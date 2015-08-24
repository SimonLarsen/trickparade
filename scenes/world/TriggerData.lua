local TriggerData = {}

local Dialog = require("scenes.world.Dialog")

TriggerData["need_costume"] = function(self)
	local player = self.scene:find("player")
	if player:getCostume() == "base" then
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

TriggerData["alleyblocker"] = function(self)
	local player = self.scene:find("player")
	if not player:hasItem("apple") then
		self.scene:add(Dialog({"THE KID PUSHES YOU BACK."}, function()
			player:move(2)
		end
		))
	end
end

TriggerData["leftblock"] = function(self)
	local player = self.scene:find("player")
	self.scene:add(
		Dialog({"MOM SAYS YOU'RE NOT ALLOWED","TO GO ANY FURTHER AWAY FROM","HOME."},
			function()
				player:move(1)
			end
		)
	)
end

TriggerData["flashblock"] = function(self)
	local player = self.scene:find("player")
	if not player:hasItem("flashlight") then
		self.scene:add(
			Dialog({"YOU CAN'T GO INTO THE","WOODS WITHOUT A FLASHLIGHT."},
				function()
					player:move(3)
				end
			)
		)
	end
end

return TriggerData
