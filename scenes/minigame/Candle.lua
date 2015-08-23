local Candle = class("Candle", Entity)

function Candle:initialize(x, y)
	Entity.initialize(self, x, y, 0, "candle")

	self.size = 1

	self.base = Resources.getImage("minigame/candle_base.png")
	self.body = Resources.getImage("minigame/candle_body.png")
	self.top = Animation(Resources.getImage("minigame/candle_top.png"), 24, 41, 0.1)
	self.out = Animation(Resources.getImage("minigame/candle_out.png"), 24, 62, 0.13, false)
end

-- Value from 0 to 1
function Candle:setSize(s)
	self.size = s
end

function Candle:update(dt)
	self.top:update(dt)
	if self.size <= 0 then
		self.out:update(dt)
	end
end

function Candle:gui()
	if self.size > 0 then
		love.graphics.draw(self.body, self.x, self.y-37-self.size*57, 0, 1, 1, 12, 0)
		self.top:draw(self.x, self.y-73-self.size*57, 0, 1, 1, 12, 0)
		love.graphics.draw(self.base, self.x, self.y-39, 0, 1, 1, 12, 0)
	else
		self.out:draw(self.x, self.y-62, 0, 1, 1, 12, 0)
	end
end

return Candle
