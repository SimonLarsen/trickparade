local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins

local speed = 80

local req = {
	5, 6, 7, 9, 12
}

function Controller:initialize(level)
	MinigameController.initialize(self, "BREAK THE DOOR")

	self.bg = Resources.getImage("minigame/door/door.png")
	self.axe = Resources.getImage("minigame/door/axe.png")
	self.face = Resources.getImage("minigame/door/face.png")
	self.hole = {}
	for i=1,4 do
		self.hole[i] = Resources.getImage("minigame/door/hole"..i..".png")
	end

	self.required = req[level]
	self.hits = 0
	self.cursorx = 180
	self.cursory = 35
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if Keyboard.isDown(Config.KEY_UP) then
		self.cursory = self.cursory - speed*dt
	end
	if Keyboard.isDown(Config.KEY_RIGHT) then
		self.cursorx = self.cursorx + speed*dt
	end
	if Keyboard.isDown(Config.KEY_DOWN) then
		self.cursory = self.cursory + speed*dt
	end
	if Keyboard.isDown(Config.KEY_LEFT) then
		self.cursorx = self.cursorx - speed*dt
	end

	if self:isCompleted() then return end

	if Keyboard.wasPressed(Config.KEY_ACTION) then
		if self.cursorx < WIDTH/2+42 and self.cursorx > WIDTH/2-42 then
			if self.hits == 0 then
				self.holex = self.cursorx
				self.holey = self.cursory
			end
			self.hits = math.min(self.hits+1, self.required)
		end
	end

	if self.hits >= self.required then
		self:onSuccess()
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)

	if self.hits > 0 then
		local frame = math.floor(self.hits / self.required * 4) + 1
		frame = math.min(frame, 4)

		love.graphics.draw(self.hole[frame], self.holex, self.holy, 0, 1, 1, 32, -20)
	end

	if self:isSuccess() then
		love.graphics.draw(self.face, self.holex, self.holey, 0, 1, 1, 32, 32)
	end

	if Keyboard.isDown(Config.KEY_ACTION) then
		love.graphics.draw(self.axe, self.cursorx+54, self.cursory+124, -0.2, 1, 1, 47, 163)
	else
		love.graphics.draw(self.axe, self.cursorx+54, self.cursory+124, 0, 1, 1, 47, 163)
	end
end

return Controller
