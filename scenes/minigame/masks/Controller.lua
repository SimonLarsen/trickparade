local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins
-- or   self:onFail() when player fails

local speed = 200

local lvl_time = {
	5.0, 4.0, 3.4, 2.8, 2.0
}

function Controller:initialize(level)
	MinigameController.initialize(self, "PICK THE SCARY MASK")

	self.bg = Resources.getImage("minigame/masks/background.png")
	self.cursor = Resources.getImage("minigame/masks/cursor.png")
	self.img_masks = Resources.getImage("minigame/masks/masks.png")
	self.yeah = Resources.getImage("minigame/masks/yeah.png")

	self.quads = {}
	for i=1,6 do
		self.quads[i] = love.graphics.newQuad((i-1)*40, 0, 40, 50, 240, 50)
	end

	self:setTime(lvl_time[level])
	self.cursorx = WIDTH/2
	self.cursory = HEIGHT/2
	self.selection = 0

	local scary_id = love.math.random(1, 2)
	local silly_sel = {3, 4, 5, 6}
	local silly_id = math.subset(silly_sel, 2)

	self.masks = {scary_id, silly_id[1], silly_id[2]}
	math.shuffle(self.masks)
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if self:isCompleted() then return end

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

	if Keyboard.wasPressed(Config.KEY_ACTION) then
		if self.cursory > 60 then
			for i=1, 3 do
				local mx = WIDTH/2+(i-2)*50
				if self.cursorx > mx-20 and self.cursorx < mx+20 then
					if self.masks[i] <= 2 then
						self:onSuccess()
					else
						self:onFail()
					end
					self.selection = self.masks[i]
				end
			end
		end
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)

	for i=1, 3 do
		if self.masks[i] ~= self.selection then
			love.graphics.draw(self.img_masks, self.quads[self.masks[i]], WIDTH/2+(i-2)*50, HEIGHT-35, 0, 1, 1, 20, 25)
		end
	end

	if self:isCompleted() then
		love.graphics.draw(self.img_masks, self.quads[self.selection], WIDTH/2, 42, 0, 1, 1, 20, 25)

		if self:isSuccess() then
			love.graphics.draw(self.yeah, 3, -2)
		end
	else
		love.graphics.draw(self.cursor, self.cursorx, self.cursory, 0, 1, 1, 16, 16)
	end
end

return Controller
