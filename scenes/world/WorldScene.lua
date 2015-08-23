local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")
local Tilemap = require("scenes.world.Tilemap")
local CurtainsTransition = require("transition.CurtainsTransition")

function WorldScene:initialize()
	Scene.initialize(self)

	self:setCheckCollision(false)

	self:add(Player(8.5*TILEW, 15.5*TILEW))
	self:add(Tilemap()):load("road")
	self:add(CurtainsTransition(CurtainsTransition.static.IN))
end

return WorldScene
