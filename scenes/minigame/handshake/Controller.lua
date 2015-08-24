local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins
-- or   self:onFail() when player fails

local speed = 80

local radius = {
	5, 10, 20, 30, 40
}

function Controller:initialize(level)
	MinigameController.initialize(self, "REACH AND PULL")

	self.bg = Resources.getImage("minigame/handshake/background.png")
	self.enemy = Resources.getImage("minigame/handshake/hand_enemy.png")
	self.handshake = Resources.getImage("minigame/handshake/handshake.png")
	self.you = Resources.getImage("minigame/handshake/hand_you.png")
	self.pop = Resources.getImage("minigame/handshake/pop.png")
	self.sleeve = Resources.getImage("minigame/handshake/sleeve.png")
	self.font = Resources.getFont("gothic.ttf", 16)

	self.level= level

	self.cursorx = WIDTH-54
	self.cursory = HEIGHT/2

	self.enemyx = 61
	self.enemyy = HEIGHT/2+20

	self.pos = 0
	self.state = 0
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if self:isCompleted() then return end

	if self.state == 0 then
		self.pos = self.pos + dt

		self.enemyy = HEIGHT/2+20 + math.sin(self.pos*3) * radius[self.level]

		if Keyboard.isDown(Config.KEY_UP) then
			self.cursory = self.cursory - speed*dt
		end
		if Keyboard.isDown(Config.KEY_RIGHT) then
			self.cursorx = self.cursorx + speed*dt
		end
		if Keyboard.isDown(Config.KEY_DOWN) then
			self.cursory = self.cursory + speed*dt
		end
		if Keyboard.isDown(Config.KEY_LEFT) then
			self.cursorx = self.cursorx - speed*dt
		end

		if math.abs(self.cursorx - self.enemyx) < 10
		and math.abs(self.cursory - self.enemyy) < 10 then
			self.state = 1
			self.cursorx = self.enemyx
			self.cursory = self.enemyy
		end
	
	elseif self.state == 1 then
		if Keyboard.isDown(Config.KEY_RIGHT) then
			self.cursorx = self.cursorx + speed*dt
		end

		if self.cursorx > 64 then
			self:onSuccess()
			self.state = 2
		end
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)

	if self.state == 0 then
		love.graphics.draw(self.you, self.cursorx, self.cursory, 0, 1, 1, 54, 34)
		love.graphics.draw(self.sleeve, self.cursorx+30, self.cursory-57)

		love.graphics.draw(self.enemy, self.enemyx, self.enemyy, 0, 1, 1, 61, 32)
	elseif self.state == 1 then
		love.graphics.draw(self.handshake, self.enemyx, self.enemyy+1, 0, 1, 1, 61, 32)
		love.graphics.draw(self.sleeve, self.enemyx+46, self.enemyy-55)

		love.graphics.setColor(0, 0, 0)
		love.graphics.printf("PULL!", -1, HEIGHT/2-19, WIDTH, "center")
		love.graphics.printf("PULL!", 1, HEIGHT/2-19, WIDTH, "center")
		love.graphics.printf("PULL!", -1, HEIGHT/2-17, WIDTH, "center")
		love.graphics.printf("PULL!", 1, HEIGHT/2-17, WIDTH, "center")

		love.graphics.setColor(255, 255, 255)
		love.graphics.printf("PULL!", 0, HEIGHT/2-18, WIDTH, "center")
	elseif self.state == 2 then
		love.graphics.draw(self.handshake, self.enemyx, self.enemyy, 0, 1, 1, 61, 32)
		love.graphics.draw(self.pop, self.enemyx+19, self.enemyy-93)
	end
end

return Controller
