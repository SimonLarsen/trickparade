local Dialog = require("scenes.world.Dialog")

local NPCData = {
}

NPCData["mom1"] = {
	type = "mom",

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({ "HI, HONEY.", "TONIGHT IS HALLOWEEN!", "AREN'T YOU EXITED?" }))
		end
	}
}

return NPCData
