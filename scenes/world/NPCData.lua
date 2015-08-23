local Dialog = require("scenes.world.Dialog")

local NPCData = {}

NPCData.TYPE_NPC = 0
NPCData.TYPE_ENEMY = 1

NPCData.COSTUME_GHOST            = 0
NPCData.COSTUME_SPLATTER         = 1
NPCData.COSTUME_CRITTER          = 2
NPCData.COSTUME_GHOST_SPLATTER   = 3
NPCData.COSTUME_GHOST_CRITTER    = 4
NPCData.COSTUME_SPLATTER_CRITTER = 5
NPCData.COSTUME_ALL              = 6

NPCData["mom1"] = {
	type = NPCData.TYPE_NPC,
	name = "MOM",
	sprite = "mom",
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

NPCData["ghostkid1"] = {
	type = NPCData.TYPE_ENEMY,
	name = "GHOST KID",
	sprite = "ghost",
	costume = NPCData.COSTUME_GHOST,
	state = 0,
	range = 3,
	hp = 100,
	damage = 20,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({ "FITE ME IRL!" }, function()
				self:startBattle()
			end))
		end,

		[1] = function(self)
			self.scene:add(Dialog({ "YOU CHEATED!" }))
		end
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

return NPCData
