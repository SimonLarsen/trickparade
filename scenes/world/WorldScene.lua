local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")
local Tilemap = require("scenes.world.Tilemap")
local Dialog = require("scenes.world.Dialog")

function WorldScene:initialize()
	Scene.initialize(self)

	self:setCheckCollision(false)

	self:add(Player(31.5*TILEW, 28.5*TILEW))
	self:add(Tilemap()):load("road")
	self:add(Dialog({
		"PURI PURIN PURI PURIN",
		"GIGA PURIN",
		"KYUMO PA-TI-",
		"GIGA PURIN!"

	}))
end

return WorldScene
