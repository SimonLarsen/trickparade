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

-- Mom inside home
NPCData["mom"] = {
	type = NPCData.TYPE_NPC,
	name = "MOM",
	sprite = "mom",
	state = 0,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"MOM: I MADE A CUSTOME FOR","YOU OUT OF YOUR OLD BED","SHEETS."}, function()
				self.scene:find("player"):giveCostume("ghost")
				self.scene:add(Dialog({"MOM GAVE YOU GHOST COSTUME!"}))
			end))
			self:setNPCState(1)
		end,

		[1] = function(self)
			self.scene:add(Dialog({"HAVE FUN!"}))
		end
	}
}

-- Wolf outside start house
NPCData["wolfkid1"] = {
	type = NPCData.TYPE_ENEMY,
	name = "WOLF KID",
	sprite = "wolf",
	costume = NPCData.COSTUME_CRITTER,
	state = 0,
	range = 2,
	hp = 30,
	damage = 10,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({ "GRRR!" }, function()
				self:startBattle()
			end))
		end,

		[1] = function(self)
			self.scene:add(Dialog({ "YOU'RE MEAN!" }))
		end
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

-- Kid at antrance of alley
NPCData["alleyblocker"] = {
	type = NPCData.TYPE_NPC,
	name = "COOL KID",
	sprite = "ghost",
	state = 0,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({ "COOL KID: IF YOU WANT TO","HANG WITH US YOU'LL HAVE TO","PROVE YOU'RE COOL ENOUGH."}))
			self:setNPCState(1)
		end,

		[1] = function(self)
			local player = self.scene:find("player")
			if player:hasItem("apple") then
				self.scene:add(Dialog({"COOL KID: YOU'RE COOL."}))
			else
				self.scene:add(Dialog({"COOL KID: STEAL AN APPLE", "FROM THE OLD MANS BACK YARD", "THEN WE'LL LET YOU IN!"}))
			end
		end
	}
}

-- Old man in house with apples
NPCData["oldman"] = {
	type = NPCData.TYPE_NPC,
	name = "OLD MAN",
	sprite = "gramps",
	state = 0,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"OLD MAN: I DON'T HAVE ANY","CANDY!"}))
		end
	}
}

return NPCData
