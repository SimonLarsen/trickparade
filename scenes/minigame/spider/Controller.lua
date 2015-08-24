local MinigameController = require("scenes.minigame.MinigameController")

local Controller = class("Controller", MinigameController)

-- Call self:onSuccess() when player wins

local inp = {
	[0] = Config.KEY_UP,
	[1] = Config.KEY_RIGHT,
	[2] = Config.KEY_DOWN,
	[3] = Config.KEY_LEFT
}

local req = {
	8, 10, 12, 14, 16
}

function Controller:initialize(level)
	MinigameController.initialize(self, "LOWER THE SPIDER")

	self.bg = Resources.getImage("minigame/spider/background.png")
	self.rod = Resources.getImage("minigame/spider/fishingrod.png")

	self.guy = Resources.getImage("minigame/spider/guy.png")
	self.guy_scared = Resources.getImage("minigame/spider/guy_scared.png")

	self.hand = Resources.getImage("minigame/spider/turninghand.png")
	self.spider = Resources.getImage("minigame/spider/spider.png")

	self.required = req[level]
	self.step = 0
	self.progress = 0
end

function Controller:update(dt)
	MinigameController.update(self, dt)

	if Keyboard.wasPressed(inp[self.step]) then
		self.step = (self.step + 1) % 4
		self.progress = math.min(1, self.progress + 1/(self.required-0.01))
	end

	if self.progress >= 1 and not self:isCompleted() then
		self:onSuccess()
	end
end

function Controller:draw()
	love.graphics.draw(self.bg, 0, 0)

	if self.progress < 1 then
		love.graphics.draw(self.guy, 137, 79)
	else
		love.graphics.draw(self.guy_scared, 137, 79)
	end

	love.graphics.draw(self.rod, 0, 9)

	local x = 43 + math.cos(self.progress*10)*5
	local y = 107 + math.sin(self.progress*10)*5
	love.graphics.draw(self.hand, x, y, 0, 1, 1, 7, 9)

	x = 165
	y = 35 + self.progress*75

	love.graphics.setColor(0, 0, 0)
	love.graphics.line(x, 35, x, y)

	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.spider, x, y, 0, 1, 1, 7, 10)
end

return Controller
