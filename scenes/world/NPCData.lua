local Dialog = require("scenes.world.Dialog")

local NPCData = {
}

NPCData["mom1"] = {
	type = "mom",

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"HI, HONEY!"}))
		end
	}
}

return NPCData
