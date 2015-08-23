local MinigameController = class("MinigameController", Entity)

local Transition = require("transition.CurtainsTransition")

function MinigameController:initialize()
	Entity.initialize(self, 0, 0, 0, "minigamecontroller")

	self.time = 5
	self.completed = false
	self.success = false
end

function MinigameController:enter()
	self.scene:add(Transition(Transition.static.IN, 0.5))
end

function MinigameController:update(dt)
	self.time = self.time - dt

	if self.time <= 0 then
		self.time = 0
		if self.completed == false then
			self.completed = true
			self:exit()
		end
	end
end

function MinigameController:gui()
	love.graphics.setColor(255, 0, 0)
	local ch = self.time/5*100
	love.graphics.rectangle("fill", 20, 130-ch, 10, ch)
	love.graphics.setColor(255, 255, 255)
end

function MinigameController:isCompleted()
	return self.completed
end

function MinigameController:isSuccess()
	return self.success
end

function MinigameController:onSuccess()
	self.completed = true
	self.success = true

	self:exit()
end

function MinigameController:exit()
	self.scene:add(Transition(Transition.static.OUT, 0.5))
	timer.add(0.5, function()
		gamestate.pop()
	end)
end

return MinigameController
