local MinigameScene = require("scenes.minigame.MinigameScene")

local MinigameFactory = {}

local games = {
	-- Ghost
	"scenes.minigame.flicker.Controller",
	"scenes.minigame.flashlight.Controller",
	"scenes.minigame.cup.Controller",
	-- Splatter
	"scenes.minigame.door.Controller",
	"scenes.minigame.handshake.Controller",
	"scenes.minigame.masks.Controller",
	-- Critter
	"scenes.minigame.spider.Controller",
	"scenes.minigame.batcourse.Controller",
	"scenes.minigame.sling.Controller",
}

local first_ghost = 1
local last_ghost = 3

local first_splatter = 4
local last_splatter = 6

local first_critter = 7
local last_critter = 9

function MinigameFactory.create(id, level)
	local scene = MinigameScene()
	scene:add(require(games[id])(level))
	return scene
end

function MinigameFactory.getSequence(active)
	--[[
	local pool = {}
	if active[1] then
		for i=first_ghost, last_ghost do
			table.insert(pool, i)
		end
	end
	if active[2] then
		for i=first_splatter, last_splatter do
			table.insert(pool, i)
		end
	end
	if active[3] then
		for i=first_critter, last_critter do
			table.insert(pool, i)
		end
	end
	]]

	local pool = math.seq(1, #games)
	math.shuffle(pool)

	return pool
end

return MinigameFactory
