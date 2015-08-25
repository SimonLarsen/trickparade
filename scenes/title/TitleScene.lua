local TitleScene = class("TitleScene", Scene)

local Controller = require("scenes.title.Controller")

function TitleScene:initialize()
	Scene.initialize(self)

	self:add(Controller())
end

return TitleScene
