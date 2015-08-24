local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins
-- or   self:onFail() when player fails

local ice_speed = {
	2, 3, 4, 5, 6
}

local GRAVITY = 100

function Controller:initialize(level)
	MinigameController.initialize(self, "SHOOT HER WITH A COCKROACH")

	self.bg = Resources.getImage("minigame/sling/background.png")
	self.cockroach = Resources.getImage("minigame/sling/cockroach.png")
	self.marker = Resources.getImage("minigame/sling/distancemarker.png")
	self.girl_neutral = Resources.getImage("minigame/sling/girl_neutral.png")
	self.girl_scared = Resources.getImage("minigame/sling/girl_scared.png")
	self.arrow = Resources.getImage("minigame/sling/guide_arrow.png")
	self.icecream = Resources.getImage("minigame/sling/icecream.png")
	self.sling = Resources.getImage("minigame/sling/slingshot.png")

	self.pos = 0
	self.rot = 0

	self.slingy = 68
	self.power = 0

	self.xspeed = 0
	self.yspeed = 0

	self.state = 0
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if self.state == 2 then
		self.yspeed = self.yspeed + GRAVITY*dt
		self.cockroachy = self.cockroachy + self.yspeed * dt
	end

	if self:isCompleted() then return end

	if self.state == 0 then
		if Keyboard.isDown(Config.KEY_UP) then
			self.slingy = self.slingy - 30*dt
		end
		if Keyboard.isDown(Config.KEY_DOWN) then
			self.slingy = self.slingy + 30*dt
		end
		
		if Keyboard.isDown(Config.KEY_LEFT) then
			self.power = math.min(self.power + 1.2*dt, 1)
		else
			if self.power > 0 then
				self.xspeed = self.power*300
				self.yspeed = -self.power*60
				self.state = 1
				self.power = 0
			end
		end

		self.pos = self.pos + 2*dt
		self.rot = math.sin(self.pos)-0.1

		self.cockroachx = 50-38*self.power
		self.cockroachy = self.slingy+2*self.power

	elseif self.state == 1 then
		self.pos = self.pos + 2*dt
		self.rot = math.sin(self.pos)-0.1

		self.yspeed = self.yspeed + GRAVITY*dt

		self.cockroachx = self.cockroachx + self.xspeed * dt
		self.cockroachy = self.cockroachy + self.yspeed * dt

		local icex = 173 + math.cos(math.pi + self.rot+0.26)*48
		local icey = 95 + math.sin(math.pi + self.rot+0.26)*48

		if math.sqrt((self.cockroachx-icex)^2+(self.cockroachy-icey)^2) < 16 then
			self:onFail()
			self.state = 2
			self.yspeed = 0
		end

		if math.sqrt((self.cockroachx-181)^2+(self.cockroachy-55)^2) < 25 then
			self:onSuccess()
			self.state = 2
			self.yspeed = 0
		elseif self.cockroachx > WIDTH+10 then
			self:onFail()
			self.state = 2
			self.yspeed = 0
		end
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)

	love.graphics.draw(self.sling, 0, self.slingy-10)

	if self.power > 0 then
		love.graphics.draw(self.marker, 50-38*0.25*self.power, self.slingy+0.5*self.power, 0, 1, 1, 2, 2)
		love.graphics.draw(self.marker, 50-38*0.50*self.power, self.slingy+1.0*self.power, 0, 1, 1, 2, 2)
		love.graphics.draw(self.marker, 50-38*0.75*self.power, self.slingy+1.5*self.power, 0, 1, 1, 2, 2)
	end

	love.graphics.draw(self.girl_neutral, 136, 22)
	love.graphics.draw(self.icecream, 173, 95, self.rot, 1, 1, 52, 26)

	love.graphics.draw(self.cockroach, self.cockroachx, self.cockroachy, 0, 1, 1, 10, 15)

	local icex = 173 + math.cos(math.pi + self.rot+0.26)*48
	local icey = 95 + math.sin(math.pi + self.rot+0.26)*48
end

return Controller
