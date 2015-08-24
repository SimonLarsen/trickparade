local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

local req = {
	10, 12, 15, 17, 21
}

function Controller:initialize(level)
	MinigameController.initialize(self, "FLICKER THE LIGHTS")

	self.bg = Resources.getImage("minigame/flicker/background.png")
	self.hand_on = Resources.getImage("minigame/flicker/hand_on.png")
	self.hand_off = Resources.getImage("minigame/flicker/hand_off.png")
	self.light = Resources.getImage("minigame/flicker/lightson.png")

	self.inst = Animation(Resources.getImage("minigame/flicker/inst.png"), 16, 32, 0.15)

	self.on = true
	self.count = 0
	self.required = req[level]
end

function Controller:update(dt)
	MinigameController.update(self, dt)
	self.inst:update(dt)

	if self:isCompleted() then return end

	if self.on == true and Keyboard.wasPressed(Config.KEY_DOWN) then
		self.on = false
		self.count = self.count + 1
	
	elseif self.on == false and Keyboard.wasPressed(Config.KEY_UP) then
		self.on = true
		self.count = self.count + 1
	end

	if self.count >= self.required and not self:isSuccess() then
		self:onSuccess()
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)
	if self.on then
		love.graphics.draw(self.light, 0, 0)
		love.graphics.draw(self.hand_on, 185, 79)
	else
		love.graphics.draw(self.hand_off, 185, 101)
	end

	self.inst:draw(162, 96)
end

return Controller
