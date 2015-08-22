local Text = require("scenes.world.Text")

local Note = class("Note", Text)

function Note:initialize(...)
	Text.initialize(self, ...)
end

function Note:draw()
	love.graphics.rectangle("fill", self.x-3, self.y-3, 6, 6)
end

return Note
