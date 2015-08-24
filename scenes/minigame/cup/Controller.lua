local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins
-- or   self:onFail() when player fails

local speed = 180

local min_dist = {
	200, 300, 450, 600, 900
}

function Controller:initialize(level)
	MinigameController.initialize(self, "MAKE THE CUP FLY AROUND")

	self.bg = Resources.getImage("minigame/cup/backgroud.png")
	self.cup = Resources.getImage("minigame/cup/cup.png")
	self.hand = Resources.getImage("minigame/cup/hand.png")

	self.handx = WIDTH/2
	self.handy = HEIGHT-26

	self.required = min_dist[level]
	self.cupx = WIDTH/2
	self.cupy = HEIGHT+38
	self.cupxspeed = 0
	self.cupyspeed = 0
	self.moved = 0
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	self.handx = math.min(math.max(self.handx, 24), WIDTH-24)
	self.handy = math.min(math.max(self.handy, 8), 120)

	if self.handy < HEIGHT-108 then
		self.lifted = true
	end

	self.cupxspeed = math.movetowards(self.cupxspeed, 0, 1000*dt)
	self.cupxspeed = self.cupxspeed + self.handx - self.cupx

	self.cupyspeed = math.movetowards(self.cupyspeed, 0, 1000*dt)
	self.cupyspeed = self.cupyspeed + 1500*dt
	self.cupyspeed = self.cupyspeed + self.handy+64 - self.cupy

	self.cupx = self.cupx + self.cupxspeed * dt
	self.cupy = self.cupy + self.cupyspeed * dt

	local dist = math.sqrt((self.cupxspeed*dt)^2 + (self.cupyspeed*dt)^2)
	self.moved = self.moved + dist

	if self:isCompleted() then return end

	if self.moved >= self.required then
		self:onSuccess()
	end

	if Keyboard.isDown(Config.KEY_UP) then
		self.handy = self.handy - speed * dt
	end
	if Keyboard.isDown(Config.KEY_RIGHT) then
		self.handx = self.handx + speed * dt
	end
	if Keyboard.isDown(Config.KEY_DOWN) then
		self.handy = self.handy + speed * dt
	end
	if Keyboard.isDown(Config.KEY_LEFT) then
		self.handx = self.handx - speed * dt
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)

	love.graphics.draw(self.cup, self.cupx, self.cupy, 0, 1, 1, 24, 32)

	love.graphics.setColor(0, 0, 0)
	love.graphics.line(self.handx, self.handy, self.cupx, self.cupy-24)

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.hand, self.handx, self.handy, 0, 1, 1, 40, 32)
end

return Controller
