local Dialog = require("scenes.world.Dialog")

local EndScene = require("scenes.end.EndScene")

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
			self.scene:add(Dialog({"MOM: I MADE A COSTUME FOR","YOU OUT OF YOUR OLD BED","SHEETS."}, function()
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
			self.scene:add(Dialog({ "WOLF KID: GRRR!" }, function()
				self:startBattle()
			end))
		end,

		[1] = function(self)
			self.scene:add(Dialog({ "WOLF KID: YOU'RE MEAN!" }))
		end
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

-- Wolf kids at playground
NPCData["wolfkid2"] = {
	type = NPCData.TYPE_ENEMY,
	name = "WOLF KID",
	sprite = "wolf",
	costume = NPCData.COSTUME_CRITTER,
	state = 0,
	range = 4,
	hp = 50,
	damage = 20,

	interact = {
		[0] = function(self)
			self:startBattle()
		end,

		[1] = function(self)
			self.scene:add(Dialog({ "WOLF KID: THE ELDER KIDS", "DECIDED A RULE: CRITTERS", "ARE AFRAID OF GHOSTS,", "GHOSTS ARE AFRAID OF", "SPLATTER, AND SPLATTER ARE", "AFRAID OF CRITTERS.", "ALTHOUGH I'VE HEARD SOME", "KIDS TRY TO CHEAT BY", "COMBINING COSTUMES!"}))
		end
	},

	onWin = function(self)
		self.scene:add(Dialog({ "WOLF KID: THE ELDER KIDS", "DECIDED A RULE: CRITTERS", "ARE AFRAID OF GHOSTS,", "GHOSTS ARE AFRAID OF", "SPLATTER, AND SPLATTER ARE", "AFRAID OF CRITTERS.", "ALTHOUGH I'VE HEARD SOME", "KIDS TRY TO CHEAT BY", "COMBINING COSTUMES!"}))
		self:setNPCState(1, 0)
	end
}

NPCData["wolfkid3"] = {
	type = NPCData.TYPE_ENEMY,
	name = "WOLF KID",
	sprite = "wolf",
	costume = NPCData.COSTUME_CRITTER,
	state = 0,
	range = 4,
	hp = 50,
	damage = 20,

	interact = {
		[0] = function(self)
			self:startBattle()
		end,

		[1] = function(self)
			self.scene:add(Dialog({ "WOLF KID: I'M TELLING MY MOM" }))
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

NPCData["ghostkid1"] = {
	type = NPCData.TYPE_ENEMY,
	name = "GHOST KID",
	sprite = "ghost",
	costume = NPCData.COSTUME_GHOST,
	state = 0,
	range = 4,
	hp = 70,
	damage = 20,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"GHOST KID: YOU WON'T STAND", "A CHANCE IN THE ALLEY", "WITHOUT A SPLATTER COSTUME!"}, function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

NPCData["ghostkid2"] = {
	type = NPCData.TYPE_ENEMY,
	name = "GHOST KID",
	sprite = "ghost",
	costume = NPCData.COSTUME_GHOST,
	state = 0,
	range = 4,
	hp = 70,
	damage = 25,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"GHOST KID: BOO!"}, function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

NPCData["ghostdog1"] = {
	type = NPCData.TYPE_ENEMY,
	name = "GHOST DOG",
	sprite = "ghostdog",
	costume = NPCData.COSTUME_GHOST_CRITTER,
	state = 0,
	range = 4,
	hp = 200,
	damage = 35,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"GHOST DOG: I'M A GHOST DOG!"}, function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

-- GHOST DOG WHO GIVES YOU WOLF SUIT
NPCData["ghostdog2"] = {
	type = NPCData.TYPE_ENEMY,
	name = "GHOST DOG",
	sprite = "ghostdog",
	costume = NPCData.COSTUME_GHOST_CRITTER,
	state = 0,
	range = 4,
	hp = 230,
	damage = 40,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"GHOST DOG: I'M NOT AFRAID","OF YOU!"}, function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		self.scene:add(Dialog({"GHOST DOG: HERE. HAVE THIS.","THAT WILL HELP YOU SCARE","THE BULLIES IN THE FOREST!"}, function()
			self.scene:find("player"):giveCostume("wolf")
		end))
		self.scene:add(Dialog({"GHOST DOG GAVE YOU A WOLF"," COSTUME."}))
		self:setNPCState(1, 0)
	end
}

-- GHOST HINTING AT FRANKEN SUIT
NPCData["ghosthint"] = {
	type = NPCData.TYPE_ENEMY,
	name = "GHOST DOG",
	sprite = "ghostdog",
	costume = NPCData.COSTUME_GHOST_CRITTER,
	state = 0,
	range = 4,
	hp = 200,
	damage = 40,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"GHOST DOG: ALL THE BULLIES","ARE HANGING OUT IN THE","FOREST."}, function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

-- Jason in from of big house door
NPCData["splatterkid"] = {
	type = NPCData.TYPE_ENEMY,
	name = "SPLATTER KID",
	sprite = "splatter",
	costume = NPCData.COSTUME_SPLATTER,
	state = 0,
	range = 4,
	hp = 100,
	damage = 50,

	interact = {
		[0] = function(self)
			self:startBattle()
		end
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

-- Man who gives you franken suit
NPCData["dad"] = {
	type = NPCData.TYPE_NPC,
	name = "MAN",
	sprite = "dad",
	state = 0,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"MAN: IF YOU'RE GOING INTO","THE WOODS YOU'LL NEED THIS."},
			function()
				self.scene:find("player"):giveItem("flashlight")
				self.scene:add(Dialog({"MAN GAVE YOU A FLASHLIGHT."}))
			end))
			self:setNPCState(1)
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
			self.scene:add(Dialog({"OLD MAN: IF YOU REALLY WANT","TO SCARE THE GHOST KIDS,","YOU'LL NEED THIS."}, function()
				self.scene:find("player"):giveCostume("franken")
				self.scene:add(Dialog({"OLD MAN GAVE YOU A","FRANKENSTEIN COSTUME!"}))
			end))
			self:setNPCState(1)
		end,

		[1] = function(self)
			self.scene:add(Dialog({"OLD MAN: YOU'RE WELCOME!"}))
		end
	}
}

-- Bullies in forest
NPCData["bully1"] = {
	type = NPCData.TYPE_ENEMY,
	name = "KILLER GHOST",
	sprite = "ghostkiller",
	costume = NPCData.COSTUME_GHOST_SPLATTER,
	state = 0,
	range = 1,
	hp = 200,
	damage = 30,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"KILLER GHOST: I'M COMING", "FOR YOU!"},
			function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

NPCData["bully2"] = {
	type = NPCData.TYPE_ENEMY,
	name = "ZOMBIE WOLF",
	sprite = "wolfzombie",
	costume = NPCData.COSTUME_SPLATTER_CRITTER,
	state = 0,
	range = 3,
	hp = 200,
	damage = 30,

	interact = {
		[0] = function(self)
			self:startBattle()
		end,
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

NPCData["bully3"] = {
	type = NPCData.TYPE_ENEMY,
	name = "KILLER GHOST",
	sprite = "ghostkiller",
	costume = NPCData.COSTUME_GHOST_SPLATTER,
	state = 0,
	range = 1,
	hp = 230,
	damage = 30,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"KILLER GHOST: ARE YOU","LOOKING FOR THE BIG BULLY?"},
			function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		self:setNPCState(1, 0)
	end
}

-- Wolf outside start house
NPCData["bigbully"] = {
	type = NPCData.TYPE_ENEMY,
	name = "BIG BULLY",
	sprite = "bully",
	costume = NPCData.COSTUME_ALL,
	state = 0,
	range = 0,
	hp = 500,
	damage = 34,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({ "BIG BULLY: YOU'RE TOAST!" }, function()
				self:startBattle()
			end))
		end,
	},

	onWin = function(self)
		gamestate.switch(EndScene())
	end
}

-- GUY WHO GIVES HINT ABOUT TYPES
NPCData["typehint"] = {
	type = NPCData.TYPE_NPC,
	name = "MAN",
	sprite = "dad",
	state = 0,

	interact = {
		[0] = function(self)
			self.scene:add(Dialog({"MAN: COMBINING DIFFERENT","TYPES OF SCARES ARE","SOMETIMES MORE EFFECTIVE."}))
			self:setNPCState(1)
		end,

		[1] = function(self)
			self.scene:add(Dialog({"MAN: PAY ATTENTION TO WHAT","SCARES DIFFERENT KIDS THE","MOST."}))
		end
	}
}

return NPCData
