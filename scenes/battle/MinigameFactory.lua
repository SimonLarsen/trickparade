local MinigameScene = require("scenes.minigame.MinigameScene")

local MinigameFactory = {}

local games = {
	-- Ghost
	[1] = "scenes.minigame.flicker.Controller",
	-- Splatter
	[2] = "scenes.minigame.door.Controller",
	-- Critter
	[3] = "scenes.minigame.spider.Controller",
}

function MinigameFactory.random(active, level)
	--local rand = love.math.random(2, #games)
	rand = 2

	local scene = MinigameScene()
	scene:add(require(games[rand])(level))
	return scene
end

return MinigameFactory
