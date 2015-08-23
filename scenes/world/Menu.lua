local GUIComponent = require("gui.GUIComponent")

local Menu = class("Menu", GUIComponent)

Menu.static.OPTIONS = {
	"COSTUMES",
	"ITEMS",
	"STATS",
	"OPTIONS",
	"EXIT"
}

function Menu:initialize()
	GUIComponent.initialize(self)

	self.font = Resources.getImageFont("small.png")
	self.selection = 1
end

function Menu:update(dt)
	if Keyboard.wasPressed(Config.KEY_DOWN) then
		self.selection = self.selection + 1
		if self.selection > #Menu.static.OPTIONS then
			self.selection = 1
		end

	elseif Keyboard.wasPressed(Config.KEY_UP) then
		self.selection = self.selection - 1
		if self.selection == 0 then
			self.selection = #Menu.static.OPTIONS
		end

	elseif Keyboard.wasPressed(Config.KEY_ACTION) then
		if self.selection == 5 then
			self:exit()
		end

	elseif Keyboard.wasPressed(Config.KEY_CANCEL, true) then
		self:exit()
	end
end

function Menu:gui()
	self:drawBox(WIDTH-88, 0, 88, HEIGHT)

	love.graphics.setColor(230, 230, 230)
	love.graphics.setFont(self.font)
	for i,v in ipairs(Menu.static.OPTIONS) do
		love.graphics.print(v, WIDTH-72, 8 + (i-1)*12)
		if i == self.selection then
			love.graphics.print("*", WIDTH-82, 8 + (i-1)*12)
		end
	end

	love.graphics.setColor(255, 255, 255)
end

function Menu:exit()
	self.scene:find("player"):setState(0)
	self:kill()
end

return Menu
