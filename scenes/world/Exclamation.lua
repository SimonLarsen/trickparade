local Exclamation = class("Exclamation", Entity)

function Exclamation:initialize(x, y)
	Entity.initialize(self, x, y, -5)

	self.sprite = Resources.getImage("world/exclamation.png")
	self.sx = 2
	self.sy = 0
	self.alpha = 255
	self.time = 1

	self.tween = tween.new(0.5, self, { sx = 1, sy = 1 }, 'inOutElastic')
end

function Exclamation:update(dt)
	self.time = self.time - dt
	self.tween:update(dt)

	if self.time <= 0 then
		self:kill()
	end
end

function Exclamation:draw()
	local sc = 1
	local alpha = 255

	love.graphics.setColor(255, 255, 255, self.alpha)

	love.graphics.draw(self.sprite, self.x, self.y, 0, self.sx, self.sy, 3, 6)

	love.graphics.setColor(255, 255, 255, 255)
end

return Exclamation
