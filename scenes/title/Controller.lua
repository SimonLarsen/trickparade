local Controller = class("Controller", Entity)
local Transition = require("transition.CurtainsTransition")

function Controller:initialize()
	Entity.initialize(self)

	self.bg = Resources.getImage("title/title.png")

	self.time = 0
end

function Controller:update(dt)
	self.time = self.time + dt

	if self.time > 0.5 and Keyboard.wasPressed(Config.KEY_ACTION) then
		self.scene:add(Transition(Transition.static.OUT, 1))
		timer.add(1, function()
			gamestate.switch(require("scenes.world.WorldScene")())
			self.scene:add(Transition(Transition.static.IN, 1))
		end)
	end
end

function Controller:gui()
	love.graphics.draw(self.bg, 0, 0)
end

return Controller