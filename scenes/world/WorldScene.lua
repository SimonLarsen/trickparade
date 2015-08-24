local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")
local Tilemap = require("scenes.world.Tilemap")
local CurtainsTransition = require("transition.CurtainsTransition")

function WorldScene:initialize()
	Scene.initialize(self)

	self:setCheckCollision(false)

	local startx = 4
	local starty = 39

	self:add(Player((startx+0.5)*TILEW, (starty+0.5)*TILEW))
	self:add(Tilemap()):load("world")
	self:add(CurtainsTransition(CurtainsTransition.static.IN))
end

return WorldScene
