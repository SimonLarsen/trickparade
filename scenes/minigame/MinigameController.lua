local MinigameController = class("MinigameController", Entity)

local Transition = require("transition.CurtainsTransition")
local Candle = require("scenes.minigame.Candle")
local HintText = require("scenes.minigame.HintText")

MinigameController.static.MAX_TIME = 5

function MinigameController:initialize(hint)
	Entity.initialize(self, 0, 0, 0, "minigamecontroller")

	self._time = MinigameController.static.MAX_TIME
	self._hint = hint

	self._completed = false
	self._success = false
end

function MinigameController:enter()
	self.scene:getCamera():setPosition(WIDTH/2, HEIGHT/2)

	self.candle = self.scene:add(Candle(20, HEIGHT))
	self.scene:add(HintText(self._hint))
	self.scene:add(Transition(Transition.static.IN, 0.5))
end

function MinigameController:update(dt)
	self._time = self._time - dt
	local size = self._time / MinigameController.static.MAX_TIME
	self.candle:setSize(size)

	if self._time <= 0 then
		self._time = 0
		if self._completed == false then
			self._completed = true
			self:exit()
		end
	end
end

function MinigameController:isCompleted()
	return self._completed
end

function MinigameController:isSuccess()
	return self._success
end

function MinigameController:onSuccess()
	self._completed = true
	self._success = true

	self:exit()
end

function MinigameController:onFail()
	self._completed = true
	self._success = false

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
