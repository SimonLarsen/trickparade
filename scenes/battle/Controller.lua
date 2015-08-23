local Controller = class("Controller", Entity)

function Controller:initialize()
	Entity.initialize(self)

	self.player_hp = 100
	self.enemy_hp = 100

	self.paranormal = false
	self.creeps = false
	self.slasher = false

	self.font = Resources.getImageFont("small.png")
end

function Controller:gui()
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
	love.graphics.printf("PLAYER: " .. self.player_hp, 16, 12, WIDTH-32, "right")
	love.graphics.printf("ENEMY: " .. self.enemy_hp, 16, HEIGHT-19, WIDTH-32, "left")
end

return Controller
