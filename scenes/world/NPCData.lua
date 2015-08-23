local Dialog = require("scenes.world.Dialog")

local NPCData = {
["mom1"] = {
	type = "npc",
	sprite = "mom",
	name = "MOM",
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
},

["ghostkid1"] = {
	type = "enemy",
	sprite = "ghost",
	name = "GHOST KID",
	state = 0,
	range = 3,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({ "FITE ME IRL!" }, function()
				self:startBattle()
			end))
		end
	},

	onWin = function(self)
	end,

	onFail = function(self)
	end
}
}


return NPCData
