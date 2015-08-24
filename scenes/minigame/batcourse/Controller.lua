local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins
-- or   self:onFail() when player fails

speed = 120

local net_rx = {
	0, 10, 25, 45, 70
}

local net_spd = {
	1.8, 1.8, 1.9, 2.0, 2.2
}

function Controller:initialize(level)
	MinigameController.initialize(self, "AVOID THE NET")

	self.bg = Resources.getImage("minigame/batcourse/background.png")
	self.bat = Resources.getImage("minigame/batcourse/bat.png")
	self.net_empty = Resources.getImage("minigame/batcourse/net_empty.png")
	self.net_filled = Resources.getImage("minigame/batcourse/net_filled.png")

	self.level = level
	self.batx = WIDTH
	self.baty = HEIGHT/2

	self.netx = WIDTH/2-15
	self.nety = HEIGHT/2

	self.pos = love.math.random()*2*math.pi
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	self.pos = self.pos + dt
	self.batx = self.batx - 50 * dt

	self.netx = WIDTH/2-15 + math.sin(self.pos * net_spd[self.level]*0.75)*net_rx[self.level]
	self.nety = HEIGHT/2 + math.sin(self.pos * net_spd[self.level]) * (HEIGHT/2-10)

	if self:isCompleted() then return end

	if Keyboard.isDown(Config.KEY_UP) then
		self.baty = self.baty - speed * dt
	end
	if Keyboard.isDown(Config.KEY_DOWN) then
		self.baty = self.baty + speed * dt
	end
	self.baty = math.min(math.max(self.baty, 16), HEIGHT-16)

	if math.abs(self.batx - self.netx) < 24
	and math.abs(self.baty - self.nety) < 16 then
		self:onFail()
	end

	if self.batx < 48 then
		self:onSuccess()
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)

	if self:isCompleted() and not self:isSuccess() then
		love.graphics.draw(self.net_filled, self.netx, self.nety, 0, 1, 1, 18, 13)
	else
		love.graphics.draw(self.bat, self.batx, self.baty, 0, 1, 1, 16, 16)
		love.graphics.draw(self.net_empty, self.netx, self.nety, 0, 1, 1, 18, 13)
	end
end

return Controller
