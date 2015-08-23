local CurtainsTransition = class("CurtainsTransition", Entity)

CurtainsTransition.static.IN = 0
CurtainsTransition.static.OUT = 1

function CurtainsTransition:initialize(dir, time)
	Entity.initialize(self, 0, 0, -10)

	self.dir = dir
	self.progress = 0
	self.time = time or 1.0
	self.tween = tween.new(self.time, self, {progress = 1}, 'inOutCubic')
end

function CurtainsTransition:update(dt)
	local complete = self.tween:update(dt)
	if complete then
		self:kill()
	end
end

function CurtainsTransition:gui()
	love.graphics.setColor(0, 0, 0)

	if self.dir == CurtainsTransition.static.IN then
		love.graphics.rectangle("fill", 0, 0, WIDTH/2*(1-self.progress), HEIGHT)
		love.graphics.rectangle("fill", WIDTH/2*(1+self.progress), 0, WIDTH/2*(1-self.progress), HEIGHT)
	else
		love.graphics.rectangle("fill", 0, 0, WIDTH/2*self.progress, HEIGHT)
		love.graphics.rectangle("fill", WIDTH-WIDTH/2*self.progress, 0, WIDTH/2*self.progress, HEIGHT)
	end
	love.graphics.setColor(255, 255, 255)
end

return CurtainsTransition
