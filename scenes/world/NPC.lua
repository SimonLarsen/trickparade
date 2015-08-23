local Interactable = require("scenes.world.Interactable")

local NPC = class("NPC", Interactable)
local NPCData = require("scenes.world.NPCData")

NPC.static.STATE_IDLE = 0
NPC.static.STATE_WALK = 1

function NPC:initialize(x, y, id, dir)
	Interactable.initialize(self, x, y, 0, "npc")

	self.state = NPC.static.STATE_IDLE
	self.id = id
	self.dir = dir
	self.type = NPCData[self.id].type

	self.sprite = Resources.getImage("world/npc_" .. self.type .. ".png")
	self.quads = {}
	for i=0, 3 do
		self.quads[i] = love.graphics.newQuad(i*16, 0, 16, 20, 64, 20)
	end
end

function NPC:draw()
	love.graphics.draw(self.sprite, self.quads[self.dir], self.x, self.y, 0, 1, 1, 8, 15)
end

function NPC:interact(player)
	if self.state ~= NPC.static.STATE_IDLE then return end
	
	if player.y < self.y then self.dir = 0 end
	if player.x > self.x then self.dir = 1 end
	if player.y > self.y then self.dir = 2 end
	if player.x < self.x then self.dir = 3 end

	local state = NPCData[self.id].state
	NPCData[self.id].interact[state](self)
end

function NPC:setNPCState(s)
	NPCData[self.id].state = s
end

return NPC
