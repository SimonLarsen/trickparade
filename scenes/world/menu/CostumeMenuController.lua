local GUIComponent = require("gui.GUIComponent")

local CostumeMenuController = class("CostumeMenuController", GUIComponent)

function CostumeMenuController:update(dt)
	if Keyboard.wasPressed(Config.KEY_CANCEL, true) then
		gamestate.pop()
	end
end

function CostumeMenuController:gui()
	self:drawBox(0, 0, 80, HEIGHT)
	self:drawBox(81, 0, WIDTH-79, HEIGHT)
end

return CostumeMenuController
