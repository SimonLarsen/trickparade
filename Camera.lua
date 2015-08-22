local Camera = class("Camera")

function Camera:initialize()
	self:reset()
end

function Camera:update(dt)

end

function Camera:setPosition(x, y)
	self.x, self.y = x, y
end

function Camera:move(dx, dy)
	self.x = self.x + dx
	self.y = self.y + dy
end

function Camera:getPosition()
	return self.x, self.y
end

function Camera:getX()
	return x
end

function Camera:getLeft()
	return self.x - WIDTH/2
end

function Camera:getTop()
	return self.y - HEIGHT/2
end

function Camera:getY()
	return y
end

function Camera:setScale(scale)
	self.scale = scale
end

function Camera:getScale()
	return scale
end

function Camera:reset()
	self.x = 0
	self.y = 0
	self.scale = 1
end

function Camera:apply()
	love.graphics.translate(-self.x + WIDTH/2, -self.y + HEIGHT/2)
	love.graphics.scale(self.scale)
end

return Camera
