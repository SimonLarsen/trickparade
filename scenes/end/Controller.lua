local Controller = class("Controller", Entity)
local Transition = require("transition.CurtainsTransition")

function Controller:initialize()
	Entity.initialize(self)

	self.img = {}
	for i=1,4 do
		self.img[i] = Resources.getImage("end/ending"..i..".png")
	end

	self.time = 0.5
	self.step = 1
end

function Controller:enter()
	Resources.playMusic("ending.mp3")
end

function Controller:update(dt)
	self.time = self.time - dt

	if self.time <= 0 and self.step < 4
	and Keyboard.wasPressed(Config.KEY_ACTION) then
		self.step = self.step + 1
		self.time = 0.5
	end
end

function Controller:gui()
	love.graphics.draw(self.img[self.step], 0, 0)
end

return Controller
