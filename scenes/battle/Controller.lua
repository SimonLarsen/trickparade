local GUIComponent = require("gui.GUIComponent")

local Controller = class("Controller", GUIComponent)

function Controller:initialize()
	GUIComponent.initialize(self)

	self.player_hp = 100
	self.enemy_hp = 100

	self.selection = 1

	self.paranormal = false
	self.creeps = false
	self.slasher = false

	self.font = Resources.getImageFont("small.png")
end

function Controller:gui()
	self:drawBox(0, HEIGHT-32, WIDTH, 32)
	self:drawBox(0, 0, WIDTH, 32)

	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", WIDTH/2 - 100, HEIGHT/2-30, 60, 20)
	love.graphics.rectangle("fill", WIDTH/2 - 30, HEIGHT/2-30, 60, 20)
	love.graphics.rectangle("fill", WIDTH/2 + 40, HEIGHT/2-30, 60, 20)

	love.graphics.rectangle("fill", WIDTH/2 - 30, HEIGHT/2, 60, 30)

	love.graphics.setColor(0, 0, 0)
	love.graphics.printf("OCCULT", WIDTH/2-100, HEIGHT/2-24, 60, "center")
	love.graphics.printf("CREEPS", WIDTH/2-30, HEIGHT/2-24, 60, "center")
	love.graphics.printf("SLASHER", WIDTH/2+40, HEIGHT/2-24, 60, "center")
	love.graphics.printf("GO!", WIDTH/2 - 30, HEIGHT/2+12, 60, "center")

	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(self.font)
	love.graphics.printf("ENEMY", 8, 8, WIDTH-16, "right")
	love.graphics.printf("PLAYER", 8, HEIGHT-24, WIDTH-16, "left")

	love.graphics.rectangle("fill", WIDTH-8-self.enemy_hp, 20, self.enemy_hp, 4)
	love.graphics.rectangle("fill", 8, HEIGHT-12, self.player_hp, 4)
end

return Controller
