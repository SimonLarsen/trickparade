local GUIComponent = require("gui.GUIComponent")

local Controller = class("Controller", GUIComponent)

local btn_color = {
	[true] = { 255, 255, 255 },
	[false] = { 180, 180, 180 }
}

function Controller:initialize()
	GUIComponent.initialize(self)

	self.player_hp = 100
	self.enemy_hp = 100

	self.selection = 1

	self.active = { false, false, false }

	self.font = Resources.getImageFont("small.png")
end

function Controller:update(dt)
	if Keyboard.wasPressed(Config.KEY_UP) then
		if self.selection == 4 then self.selection = 2 end
	end
	if Keyboard.wasPressed(Config.KEY_DOWN) then
		self.selection = 4
	end
	if Keyboard.wasPressed(Config.KEY_LEFT) then
		if self.selection ~= 4 then
			self.selection = math.max(1, self.selection-1)
		end
	end
	if Keyboard.wasPressed(Config.KEY_RIGHT) then
		if self.selection ~= 4 then
			self.selection = math.min(3, self.selection+1)
		end
	end

	if Keyboard.wasPressed(Config.KEY_ACTION) then
		if self.selection <= 3 then
			self.active[self.selection] = not self.active[self.selection]
		end
	end
end

function Controller:gui()
	self:drawBox(0, HEIGHT-32, WIDTH, 32)
	self:drawBox(0, 0, WIDTH, 32)

	if self.selection <= 3 then
		self:drawBox(WIDTH/2 - 104 + (self.selection-1)*70, HEIGHT/2-34, 68, 28)
	elseif self.selection == 4 then
		self:drawBox(WIDTH/2 - 34, HEIGHT/2-4, 68, 38)
	end

	-- Draw toggle buttons
	for i=1,3 do
		love.graphics.setColor(unpack(btn_color[self.active[i]]))
		love.graphics.rectangle("fill", WIDTH/2 - 100 + (i-1)*70, HEIGHT/2-30, 60, 20)
	end

	-- Draw SCARE button
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", WIDTH/2 - 30, HEIGHT/2, 60, 30)

	-- Add button labels
	love.graphics.setColor(0, 0, 0)
	love.graphics.printf("GHOST", WIDTH/2-100, HEIGHT/2-24, 60, "center")
	love.graphics.printf("SLASHER", WIDTH/2+40, HEIGHT/2-24, 60, "center")
	love.graphics.printf("CRITTER", WIDTH/2-30, HEIGHT/2-24, 60, "center")
	love.graphics.printf("SCARE!", WIDTH/2 - 30, HEIGHT/2+12, 60, "center")

	-- Draw player/enemy names
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(self.font)
	love.graphics.printf("BULLY", 8, 8, WIDTH-16, "right")
	love.graphics.printf("PLAYER", 8, HEIGHT-24, WIDTH-16, "left")

	-- Draw health bars
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", WIDTH-108, 20, 100, 4)
	love.graphics.rectangle("fill", 8, HEIGHT-12, 100, 4)

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", WIDTH-8-self.enemy_hp, 20, self.enemy_hp, 4)
	love.graphics.rectangle("fill", 8, HEIGHT-12, self.player_hp, 4)
end

return Controller
