local ItemMenuScene = class("ItemMenuScene", Scene)
local ItemMenuController = require("scenes.world.menu.ItemMenuController")

function ItemMenuScene:initialize()
	Scene.initialize(self)

	self:add(ItemMenuController())
end

return ItemMenuScene
