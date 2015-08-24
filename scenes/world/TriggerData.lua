local TriggerData = {}

local Dialog = require("scenes.world.Dialog")

TriggerData["need_costume"] = function(self)
	local player = self.scene:find("player")
	if player:getCostume() == "baseDELETE_ME" then
		self.scene:add(
			Dialog(
				{ "YOU CAN'T GO OUT ON", "HALLOWEEN WITHOUT A COSTUME!"},
				function() self.scene:find("player"):move(0) end
			)
		)
	else
		player:teleport(8, 11, 2)
	end
end

return TriggerData
