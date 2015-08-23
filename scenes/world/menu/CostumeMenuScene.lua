local CostumeMenuScene = class("CostumeMenuScene", Scene)
local CostumeMenuController = require("scenes.world.menu.CostumeMenuController")

function CostumeMenuScene:initialize()
	Scene.initialize(self)

	self:add(CostumeMenuController())
end

return CostumeMenuScene
