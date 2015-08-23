local MinigameScene = require("scenes.minigame.MinigameScene")
local Controller = require("scenes.minigame.flicker.Controller")

local FlickerMinigame = class("FlickerMinigame", MinigameScene)

function FlickerMinigame:initialize()
	MinigameScene.initialize(self)

	self:getCamera():setPosition(WIDTH/2, HEIGHT/2)

	self:add(Controller())
end

return FlickerMinigame
