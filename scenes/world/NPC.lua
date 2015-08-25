local Interactable = require("scenes.world.Interactable")

local NPC = class("NPC", Interactable)
local NPCData = require("scenes.world.NPCData")
local Transition = require("transition.CurtainsTransition")
local BattleScene = require("scenes.battle.BattleScene")
local Player = require("scenes.world.Player")

NPC.static.STATE_IDLE = 0
NPC.static.STATE_WALK = 1
NPC.static.STATE_BATTLE = 2

function NPC:initialize(x, y, id, dir)
	Interactable.initialize(self, x, y, 0, "npc")

	self.state = NPC.static.STATE_IDLE
	self.id = id
	self.dir = dir
	self.start_dir = dir
	if NPCData[self.id] == nil then
		print(self.id .. "NOT FOUND!")
	end
	self.sprite_id = NPCData[self.id].sprite
	self.battle = nil

	self.sprite = Resources.getImage("world/npc_" .. self.sprite_id .. ".png")
	self.quads = {}

	local fw = math.floor(self.sprite:getWidth() / 3)
	local fh = self.sprite:getHeight()
	self.ox = fw/2
	self.oy = fh-6
	for i=0, 2 do
		self.quads[i] = love.graphics.newQuad(
			i*fw, 0,
			fw, fh, 
			self.sprite:getWidth(), self.sprite:getHeight()
		)
	end
end

function NPC:update(dt)
	if self.state == NPC.static.STATE_BATTLE then
		if self.battle then
			local controller = self.battle:find("battlecontroller")
			if controller:isCompleted() then
				self.battle = nil
				self.state = NPC.static.STATE_IDLE
				local player = self.scene:find("player")
				player:setState(Player.static.STATE_IDLE)
				Resources.playMusic("overworld.mp3")
				if controller:isSuccess() then
					if NPCData[self.id].onWin then
						NPCData[self.id].onWin(self)
					end
				else
					player.x = 40
					player.y = 616
					player:setDir(1)
					self.dir = self.start_dir
				end
			end
		end
	end
end

function NPC:draw()
	local frame = 2 - self.dir
	local sx = 1
	if self.dir == 3 then
		frame = 1
		sx = -1
	end
	love.graphics.draw(self.sprite, self.quads[frame], self.x, self.y, 0, sx, 1, self.ox, self.oy)
end

function NPC:interact(player)
	if self.state ~= NPC.static.STATE_IDLE then return end
	
	if player.y < self.y then self.dir = 0 end
	if player.x > self.x then self.dir = 1 end
	if player.y > self.y then self.dir = 2 end
	if player.x < self.x then self.dir = 3 end

	local state = NPCData[self.id].state

	if NPCData[self.id].interact[state] then
		NPCData[self.id].interact[state](self)
	end
end

function NPC:setNPCState(s, range)
	NPCData[self.id].state = s
	if range then self:setRange(range) end
end

function NPC:startBattle()
	self.state = NPC.static.STATE_BATTLE
	self.scene:add(Transition(Transition.static.OUT, 1))
	local player = self.scene:find("player")
	player:setState(Player.static.STATE_FREEZE)
	Resources.playMusic("battle.mp3")
	timer.add(1, function()
		self.battle = BattleScene(player, self)
		self.scene:add(Transition(Transition.static.IN, 1))
		gamestate.push(self.battle)
	end)
end

function NPC:getType()
	return NPCData[self.id].type
end

function NPC:getNPCName()
	return NPCData[self.id].name
end

function NPC:getDir()
	return self.dir
end

function NPC:getRange()
	return NPCData[self.id].range or 0
end

function NPC:setRange(s)
	NPCData[self.id].range = 0
end

function NPC:getHP()
	return NPCData[self.id].hp
end

function NPC:getDamage()
	return NPCData[self.id].damage
end

function NPC:getCostume()
	return NPCData[self.id].costume
end

function NPC:getSprite()
	return self.sprite, self.quads[0]
end

return NPC
