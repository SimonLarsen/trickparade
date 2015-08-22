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
	self.npc_state = 0
end

function NPC:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.rectangle("fill", self.x-8, self.y-16, 16, 20)
end

function NPC:interact()
	if self.state ~= NPC.static.STATE_IDLE then return end
	
	NPCData[self.id][self.npc_state](self)
end

function NPC:setNPCState(s)
	self.npc_state = s
end

return NPC
