local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")
local Tilemap = require("scenes.world.Tilemap")

function WorldScene:initialize()
	Scene.initialize(self)

	self:add(Player(16*16+8, 8*8+8))
	local map = self:add(Tilemap())
	map:load("road")
end

return WorldScene
