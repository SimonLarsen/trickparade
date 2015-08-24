local MinigameScene = require("scenes.minigame.MinigameScene")

local MinigameFactory = {}

local games = {
	-- Ghost
	"scenes.minigame.flicker.Controller",
	"scenes.minigame.flashlight.Controller",
	-- Splatter
	"scenes.minigame.door.Controller",
	"scenes.minigame.handshake.Controller",
	-- Critter
	"scenes.minigame.spider.Controller",
}

function MinigameFactory.random(active, level)
	--local rand = love.math.random(2, #games)
	rand = 4

	local scene = MinigameScene()
	scene:add(require(games[rand])(level))
	return scene
end

return MinigameFactory
