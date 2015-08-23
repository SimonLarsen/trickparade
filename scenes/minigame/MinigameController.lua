local MinigameController = class("MinigameController", Entity)

local Transition = require("transition.CurtainsTransition")
local Candle = require("scenes.minigame.Candle")

MinigameController.static.MAX_TIME = 5

function MinigameController:initialize()
	Entity.initialize(self, 0, 0, 0, "minigamecontroller")

	self.time = MinigameController.static.MAX_TIME

	self.completed = false
	self.success = false
end

function MinigameController:enter()
	self.candle = self.scene:add(Candle(20, HEIGHT))
	self.scene:add(Transition(Transition.static.IN, 0.5))
end

function MinigameController:update(dt)
	self.time = self.time - dt
	local size = self.time / MinigameController.static.MAX_TIME
	self.candle:setSize(size)

	if self.time <= 0 then
		self.time = 0
		if self.completed == false then
			self.completed = true
			self:exit()
		end
	end
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
	timer.add(1, function()
		self.scene:add(Transition(Transition.static.OUT, 0.5))
		timer.add(0.5, function()
			gamestate.pop()
		end)
	end)
end

return MinigameController
