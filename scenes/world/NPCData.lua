local Dialog = require("scenes.world.Dialog")

local NPCData = {}

NPCData["test1"] = {
	[0] = function(self)
		self.scene:add(Dialog({"HELLO!"}))
		self:setNPCState(1)
	end,
	[1] = function(self)
		self.scene:add(Dialog({"PLEASE GO AWAY."}))
	end
}

return NPCData
