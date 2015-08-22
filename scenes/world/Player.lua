local Player = class("Player", Entity)

function Player:initialize(x, y)
	Entity.initialize(self, x, y, 0, "player")

	self.sprite = Resources.getImage("world/player.png")
end

function Player:update(dt)

end

function Player:draw()
	love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1, 5, 16)
end

return Player
