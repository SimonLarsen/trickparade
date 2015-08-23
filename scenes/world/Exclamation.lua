local Exclamation = class("Exclamation", Entity)

function Exclamation:initialize(x, y)
	Entity.initialize(self, x, y, -5)

	self.time = 0
	self.sprite = Resources.getImage("world/exclamation.png")
end

function Exclamation:update(dt)
	self.time = self.time + dt
	if self.time >= 1 then
		self:kill()
	end
end

function Exclamation:draw()
	local sc = 1
	local alpha = 255

	if self.time < 0.2 then
		sc = self.time*5
		alpha = self.time*5*255
	end
	love.graphics.setColor(255, 255, 255, alpha)

	love.graphics.draw(self.sprite, self.x, self.y, 0, sc, sc, 3, 6)

	love.graphics.setColor(255, 255, 255, 255)
end

return Exclamation
