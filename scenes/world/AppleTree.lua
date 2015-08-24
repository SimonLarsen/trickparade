local Interactable = require("scenes.world.Interactable")
local Dialog = require("scenes.world.Dialog")

local AppleTree = class("AppleTree", Interactable)

function AppleTree:initialize(x, y)
	Interactable.initialize(self, x, y)
end

function AppleTree:interact()
	local player = self.scene:find("player")
	if not player:hasItem("apple") then
		player:giveItem("apple")
		self.scene:add(Dialog({"YOU TOOK AN APPLE."}))
	end
end

return AppleTree
