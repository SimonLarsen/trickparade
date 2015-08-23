local Candle = class("Candle", Entity)

function Candle:initialize(x, y)
	Entity.initialize(self, x, y, 0, "candle")

	self.size = 1

	self.base = Resources.getImage("minigame/candle_base.png")
	self.body = Resources.getImage("minigame/candle_body.png")
	self.top = Animation(Resources.getImage("minigame/candle_top.png"), 24, 41, 0.15)
	self.out = Resources.getImage("minigame/candle_out.png")

	self.body_quad = love.graphics.newQuad(0, 0, 24, 57, 24, 57)
end

-- Value from 0 to 1
function Candle:setSize(s)
	self.size = s
	self.body_quad:setViewport(0, (1-self.size)*57, 24, self.size*57)
end

function Candle:update(dt)
	self.top:update(dt)
end

function Candle:gui()
	if self.size > 0 then
		love.graphics.draw(self.body, self.body_quad, self.x, self.y-33-self.size*57, 0, 1, 1, 12, 0)
		self.top:draw(self.x, self.y-73-self.size*57, 0, 1, 1, 12, 0)
		love.graphics.draw(self.base, self.x, self.y-33, 0, 1, 1, 12, 0)
	else
		love.graphics.draw(self.out, self.x, self.y-39, 0, 1, 1, 12, 0)
	end
end

return Candle
