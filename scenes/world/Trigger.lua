local Trigger = class("Trigger", Entity)

local BoxCollider = require("BoxCollider")
local TriggerData = require("scenes.world.TriggerData")

function Trigger:initialize(x, y, width, height, id)
	Entity.initialize(self, x, y, 0, "trigger")

	self.id = id
	self.collider = BoxCollider(width, height, width/2, height/2)
end

function Trigger:trigger()
	TriggerData[self.id](self)
end

return Trigger
