local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")
local Tilemap = require("scenes.world.Tilemap")
local CurtainsTransition = require("transition.CurtainsTransition")

function WorldScene:initialize()
	Scene.initialize(self)

	self:setCheckCollision(false)

	local startx = 4
	local starty = 39

	local world = self:add(Tilemap())
	world:load("world")
	local startx, starty = world:getPlayerStart()
	self:add(Player(startx, starty))
	self:add(CurtainsTransition(CurtainsTransition.static.IN))
end

return WorldScene
