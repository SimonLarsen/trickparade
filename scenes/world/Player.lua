local Player = class("Player", Entity)

local BoxCollider = require("BoxCollider")
local CollisionHandler = require("CollisionHandler")
local Interactable = require("scenes.world.Interactable")

Player.static.STATE_IDLE = 0
Player.static.STATE_WALK = 1
Player.static.STATE_DIALOG = 2

Player.static.WALK_SPEED = 64

function Player:initialize(x, y)
	Entity.initialize(self, x, y, 0, "player")

	self.sprite = Resources.getImage("world/player.png")
	self.collider = BoxCollider(16, 16)

	self.state = Player.static.STATE_IDLE
	self.dir = 2
end

function Player:enter()
	self.tilemap = self.scene:find("tilemap")
end

function Player:update(dt)
	if self.state == Player.static.STATE_IDLE then
		if Keyboard.isDown(Config.KEY_UP) then
			self:move(0)
		elseif Keyboard.isDown(Config.KEY_RIGHT) then
			self:move(1)
		elseif Keyboard.isDown(Config.KEY_DOWN) then
			self:move(2)
		elseif Keyboard.isDown(Config.KEY_LEFT) then
			self:move(3)
		elseif Keyboard.wasPressed(Config.KEY_ACTION) then
			self:interact()
		end
	
	elseif self.state == Player.static.STATE_WALK then
		local dist = math.min(TILEW-self.moved, Player.static.WALK_SPEED*dt)

		if self.dir == 0 then self.y = self.y - dist
		elseif self.dir == 1 then self.x = self.x + dist
		elseif self.dir == 2 then self.y = self.y + dist
		elseif self.dir == 3 then self.x = self.x - dist
		end

		self.moved = self.moved + Player.static.WALK_SPEED*dt
		if self.moved >= TILEW then
			self.moved = 0
			self.state = Player.static.STATE_IDLE
			CollisionHandler.checkAll(self.scene, dt)
		end
	end

	self.scene:getCamera():setPosition(self.x, self.y)
end

function Player:move(dir)
	self.dir = dir
	local cx, cy = self:getTileFront()

	if self.tilemap:isSolid(cx, cy) == false then
		self.state = Player.static.STATE_WALK
		self.moved = 0
	end
end

function Player:interact()
	local cx, cy = self:getTileFront()

	for i,v in ipairs(self.scene:getEntities()) do
		if v:isInstanceOf(Interactable) then
			local ocx, ocy = v:getTile()
			if cx == ocx and cy == ocy then
				v:interact()
			end
		end
	end
end

function Player:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, 8, 16)
end

function Player:getTile()
	return math.floor(self.x / TILEW), math.floor(self.y / TILEW)
end

function Player:getTileFront()
	local cx, cy = self:getTile()

	if self.dir == 0 then cy = cy-1
	elseif self.dir == 1 then cx = cx+1
	elseif self.dir == 2 then cy = cy+1
	elseif self.dir == 3 then cx = cx-1
	end

	return cx, cy
end

function Player:onCollide(o)
	if self.state == Player.static.STATE_IDLE
	and o:getName() == "teleport" then
		self.x = (o.destx+0.5)*TILEW
		self.y = (o.desty+0.5)*TILEW

		self:move(o.dir)
	end
end

function Player:setState(state)
	self.state = state
end

return Player
