local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins
-- or   self:onFail() when player fails

function Controller:initialize(level)
	MinigameController.initialize(self, "HINT TEXT")

end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if self:isCompleted() then return end
end

function Controller:draw()

end

return Controller
