local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")
local Tilemap = require("scenes.world.Tilemap")

function WorldScene:initialize()
	Scene.initialize(self)

	self:setCheckCollision(false)
	self:add(Player(31.5*TILEW, 28.5*TILEW))
	local map = self:add(Tilemap())
	map:load("road")
end

return WorldScene