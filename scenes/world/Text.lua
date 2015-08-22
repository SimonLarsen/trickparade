local Interactable = require("scenes.world.Interactable")
local Dialog = require("scenes.world.Dialog")

local Text = class("Text", Interactable)

function Text:initialize(x, y, lines)
	Interactable.initialize(self, x, y, 1)

	self.lines = lines
end

function Text:interact()
	self.scene:add(Dialog(self.lines))
end

return Text
