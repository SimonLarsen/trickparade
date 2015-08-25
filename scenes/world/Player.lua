local Player = class("Player", Entity)

local BoxCollider = require("BoxCollider")
local CollisionHandler = require("CollisionHandler")
local Interactable = require("scenes.world.Interactable")
local Menu = require("scenes.world.Menu")
local Exclamation = require("scenes.world.Exclamation")

local Transition = require("transition.CurtainsTransition")

Player.static.STATE_IDLE = 0
Player.static.STATE_WALK = 1
Player.static.STATE_FREEZE = 2

Player.static.WALK_SPEED = 64

function Player:initialize(x, y)
	Entity.initialize(self, x, y, 0, "player")

	self.collider = BoxCollider(16, 16)

	self.state = Player.static.STATE_IDLE
	self.costume = "base"
	self.items = {}

	self.anim = Animation(
		Resources.getImage("world/player_" .. self.costume .. "_down.png"),
		16, 21, 1/8, true, 8, 15
	)
	self.anim._frame = 2
	self:setDir(2)
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

		elseif Keyboard.wasPressed(Config.KEY_ACTION, true) then
			self:interact()
	
		--[[
		elseif Keyboard.wasPressed(Config.KEY_CANCEL, true) then
			self.state = Player.static.STATE_FREEZE
			self.scene:add(Menu())
		]]
		end
	
	elseif self.state == Player.static.STATE_WALK then
		self.anim:update(dt)

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
			self:checkEnemyFOV()
		end
	end

	self.scene:getCamera():setPosition(
		math.min(math.max(self.x, WIDTH/2), self.tilemap:getWidth() - WIDTH/2),
		math.min(math.max(self.y, HEIGHT/2), self.tilemap:getHeight() - HEIGHT/2)
	)
end

function Player:checkEnemyFOV()
	local cx, cy = self:getTile()

	for i,v in ipairs(self.scene:getEntities()) do
		if v:getName() == "npc" then
			local ocx, ocy = v:getTile()
			local dir = v:getDir()
			local range = v:getRange()
			local detected = false

			if dir == 0 and cx == ocx
			and cy < ocy and cy >= ocy-range then
				detected = true
			end

			if dir == 1 and cy == ocy
			and cx > ocx and cx <= ocx+range then
				detected = true
			end

			if dir == 2 and cx == ocx
			and cy > ocy and cy <= ocy+range then
				detected = true
			end

			if dir == 3 and cy == ocy
			and cx < ocx and cx >= ocx-range then
				detected = true
			end

			if detected then
				self.scene:add(Exclamation(v.x, v.y-22))
				v:interact(self)
				Resources.playSound("encounter.wav")
				return
			end
		end
	end
end

function Player:move(dir)
	self:setDir(dir)
	local cx, cy = self:getTileFront()

	for i,v in ipairs(self.scene:getEntities()) do
		if v:getName() == "npc" then
			local ocx, ocy = v:getTile()
			if cx == ocx and cy == ocy then
				return
			end
		end
	end

	if self.tilemap:isSolid(cx, cy) == false then
		self.state = Player.static.STATE_WALK
		self.moved = 0
	end
end

function Player:setDir(dir)
	self.dir = dir
	local img
	if self.dir == 0 then img = Resources.getImage("world/player_"..self.costume.."_up.png")
	elseif self.dir == 1 then img = Resources.getImage("world/player_"..self.costume.."_side.png")
	elseif self.dir == 2 then img = Resources.getImage("world/player_"..self.costume.."_down.png")
	elseif self.dir == 3 then img = Resources.getImage("world/player_"..self.costume.."_side.png")
	end
	self.anim._image = img
end

function Player:interact()
	local cx, cy = self:getTileFront()

	for i,v in ipairs(self.scene:getEntities()) do
		if v:isInstanceOf(Interactable) then
			local ocx, ocy = v:getTile()
			if cx == ocx and cy == ocy then
				v:interact(self)
			end
		end
	end
end

function Player:draw()
	local sx = 1
	if self.dir == 3 then sx = -1 end
	self.anim:draw(self.x, self.y, 0, sx, 1)
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
	if self.state ~= Player.static.STATE_IDLE then return end

	if o:getName() == "teleport" then
		self:teleport(o.destx, o.desty, o.dir)
	elseif o:getName() == "trigger" then
		o:trigger()
	end
end

function Player:teleport(x, y, dir)
	self.scene:add(Transition(Transition.static.OUT, 1))
	self:setState(Player.static.STATE_FREEZE)
	timer.add(1, function()
		self.x = (x+0.5)*TILEW
		self.y = (y+0.5)*TILEW

		self.scene:add(Transition(Transition.static.IN, 1))
	end)
	timer.add(1.5, function()
		self:move(dir)
	end)
end

function Player:setState(state)
	self.state = state
end

function Player:getHP()
	return 100
end

function Player:getSprite()
	local spr = Resources.getImage("world/player_" .. self.costume .. "_down.png")
	local fw = math.floor(spr:getWidth() / 4)
	local fh = spr:getHeight()
	local quad = love.graphics.newQuad(0, 0, fw, fh, spr:getWidth(), spr:getHeight())

	return spr, quad
end

function Player:getCostume()
	return self.costume
end

function Player:setCostume(c)
	self.costume = c
	self:setDir(self.dir)
end

function Player:giveCostume(c)
	if c == "ghost" and self.costume == "base" then
		self:setCostume(c)
	end
	if c == "franken" and self.costume == "ghost" then
		self:setCostume(c)
	end
	if c == "wolf" then
		self:setCostume(c)
	end
end

function Player:getDamage(type)
	if type == "ghost" then
		if self.costume == "ghost" then return 1 end

	elseif type == "splatter" then

	elseif type == "critter" then

	end

	return 0
end

function Player:hasItem(item)
	for i,v in ipairs(self.items) do
		if v == item then return true end
	end
	return false
end

function Player:giveItem(i)
	table.insert(self.items, i)
end

return Player
