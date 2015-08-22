local Interactable = require("scenes.world.Interactable")
local Dialog = require("scenes.world.Dialog")

local Note = class("Note", Interactable)

function Note:initialize(x, y, lines)
	Interactable.initialize(self, x, y, 1)

	self.lines = lines
end

function Note:interact()
	self.scene:add(Dialog(self.lines))
end

function Note:draw()
	love.graphics.rectangle("fill", self.x-3, self.y-3, 6, 6)
end

return Note
