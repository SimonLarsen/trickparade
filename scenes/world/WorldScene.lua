local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")
local Tilemap = require("scenes.world.Tilemap")

function WorldScene:initialize()
	Scene.initialize(self)

	self:setCheckCollision(false)

	self:add(Player(8.5*TILEW, 15.5*TILEW))
	self:add(Tilemap()):load("road")
end

return WorldScene
