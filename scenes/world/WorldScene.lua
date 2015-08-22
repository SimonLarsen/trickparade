local WorldScene = class("WorldScene", Scene)

local Player = require("scenes.world.Player")

function WorldScene:initialize()
	Scene.initialize(self)

	self:add(Player(0, 0))
end

return WorldScene
