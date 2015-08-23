local Dialog = require("scenes.world.Dialog")

local NPCData = {
}

NPCData["mom1"] = {
	type = "mom",
	state = 0,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({ "HI, HONEY.", "TONIGHT IS HALLOWEEN!", "AREN'T YOU EXITED?" }))
			self:setNPCState(1)
		end,

		[1] = function(self)
			self.scene:add(Dialog({"MOMMY IS BUSY!!!"}))
		end
	}
}

return NPCData
