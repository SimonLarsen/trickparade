local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins

local SPEED = {
	1.5, 2.5, 3.5, 4.5, 5.5
}

local THRESHOLD = 0.2

function Controller:initialize(level)
	MinigameController.initialize(self, "LIGHT UP YOUR FACE")

	self.face_lit = Resources.getImage("minigame/flashlight/face_lit.png")
	self.face = Resources.getImage("minigame/flashlight/face.png")
	self.flashlight = Resources.getImage("minigame/flashlight/flashlight.png")
	self.light = Resources.getImage("minigame/flashlight/light2.png")

	self.pos = 0
	self.level = level
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if self:isCompleted() then return end

	if Keyboard.wasPressed(Config.KEY_ACTION) then
		print(math.cos(self.pos))
		if math.abs(math.cos(self.pos)) < THRESHOLD then
			self:onSuccess()
		else
			self:onFail()
		end
	end
	
	self.pos = self.pos + dt*SPEED[self.level]
end

function Controller:draw()
	love.graphics.setColor(5, 5, 5)
	love.graphics.rectangle("fill", 0, 0, WIDTH, HEIGHT)

	love.graphics.setColor(255, 255, 255)
	if self:isSuccess() then
		love.graphics.draw(self.face_lit, 0, 0)
	else
		love.graphics.draw(self.face, 0, 0)
	end

	local rot = math.cos(self.pos)
	if self:isCompleted() then
		love.graphics.draw(self.light, WIDTH/2, HEIGHT, rot, 1, 1, 100, 140)
	end

	love.graphics.draw(self.flashlight, WIDTH/2, HEIGHT, rot, 1, 1, 15, 41)
end

return Controller
