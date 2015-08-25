local EndScene = class("EndScene", Scene)

local Controller = require("scenes.end.Controller")

function EndScene:initialize()
	Scene.initialize(self)

	self:add(Controller())
end

return EndScene
