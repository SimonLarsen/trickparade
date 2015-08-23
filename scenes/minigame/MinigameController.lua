local MinigameController = class("MinigameController", Entity)

function MinigameController:initialize()
	Entity.initialize(self)

	self.time = 5
	self.completed = false
	self.success = false
end

function MinigameController:update(dt)
	self.time = self.time - dt

	if self.time <= 0 then
		self.time = 0
		self.completed = true
	end
end

function MinigameController:gui()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", 40, HEIGHT-30, self.time/5*200, 10)
	love.graphics.setColor(255, 255, 255)
end

function MinigameController:isCompleted()
	return self.completed
end

function MinigameController:isSuccess()
	return self.success
end

return MinigameController
