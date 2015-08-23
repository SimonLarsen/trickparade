local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

function Controller:initialize()
	MinigameController.initialize(self)

	self.bg_on = Resources.getImage("minigame/flicker/bg_on.png")
	self.bg_off = Resources.getImage("minigame/flicker/bg_off.png")

	self.on = true
	self.count = 0
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if self:isCompleted() then return end

	if self.on == true and Keyboard.wasPressed(Config.KEY_DOWN) then
		self.on = false
		self.count = self.count + 1
	
	elseif self.on == false and Keyboard.wasPressed(Config.KEY_UP) then
		self.on = true
		self.count = self.count + 1
	end

	if self.count >= 10 and not self:isSuccess() then
		self:onSuccess()
	end
end

function Controller:draw()
	if self.on then
		love.graphics.draw(self.bg_on, 0, 0)
	else
		love.graphics.draw(self.bg_off, 0, 0)
	end
end

return Controller
