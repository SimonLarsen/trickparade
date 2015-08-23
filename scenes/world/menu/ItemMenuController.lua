local GUIComponent = require("gui.GUIComponent")

local ItemMenuController = class("ItemMenuController", GUIComponent)

function ItemMenuController:update(dt)
	if Keyboard.wasPressed(Config.KEY_CANCEL, true) then
		gamestate.pop()
	end
end

function ItemMenuController:gui()
	self:drawBox(0, 0, 80, HEIGHT)
	self:drawBox(81, 0, WIDTH-79, HEIGHT)
end

return ItemMenuController
