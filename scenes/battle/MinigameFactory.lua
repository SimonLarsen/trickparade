local MinigameFactory = {}

local games = {
	[1] = {
		"scenes.minigame.flicker.FlickerMinigame"
	}
}

function MinigameFactory.random(active)
	return require(games[1][1])()
end

return MinigameFactory
