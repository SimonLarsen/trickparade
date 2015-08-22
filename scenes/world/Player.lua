local Player = class("Player", Entity)

function Player:initialize(x, y)
	Entity.initialize(self, x, y, 0, "player")

	self.sprite = Resources.getImage("world/player.png")
end

function Player:update(dt)
	if Keyboard.wasPressed("up") then
		self.y = self.y - 16
	end
	if Keyboard.wasPressed("down") then
		self.y = self.y + 16
	end
	if Keyboard.wasPressed("left") then
		self.x = self.x - 16
	end
	if Keyboard.wasPressed("right") then
		self.x = self.x + 16
	end

	self.scene:getCamera():setPosition(self.x, self.y)
end

function Player:draw()
	love.graphics.draw(self.sprite, math.floor(self.x), math.floor(self.y), 0, 1, 1, 8, 16)
end

return Player
