local MinigameScene = require("scenes.minigame.MinigameScene")
local Controller = require("scenes.minigame.flicker.Controller")

local FlickerMinigame = class("FlickerMinigame", MinigameScene)

function FlickerMinigame:initialize()
	MinigameScene.initialize(self)

	self:add(Controller())
end

return FlickerMinigame
