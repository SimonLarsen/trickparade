local View = class("View", Entity)

function View:initialize(x, y, w, h)
	Entity.initialize(self, x, y, -100)

	assert(w >= WIDTH)
	assert(h >= HEIGHT)

	self.w = w
	self.h = h
end

function View:enter()
	self.player = self.scene:find("player")
end

function View:update(dt)
	if self.player.x < self.x or self.player.x > self.x+self.w
	or self.player.y < self.y or self.player.y > self.y+self.h then
		return
	end

	local cam = self.scene:getCamera()

	local hw = WIDTH/2
	local hh = HEIGHT/2

	cam.x = math.min(math.max(cam.x, self.x+hw), self.x+self.w-hw)
	cam.y = math.min(math.max(cam.y, self.y+hh), self.y+self.h-hh)
end

return View
