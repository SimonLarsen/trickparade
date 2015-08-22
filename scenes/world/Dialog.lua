local Dialog = class("Dialog", Entity)

local Player = require("scenes.world.Player")

Dialog.static.CHAR_WAIT = 0.05
Dialog.static.LINE_WAIT = 0.5

function Dialog:initialize(lines)
	Entity.initialize(self, 0, 0, 0)

	self.font = Resources.getImageFont("small.png")

	self.lines = lines
	self.line = 1
	self.char = 1
	self.wait = 0
end

function Dialog:enter()
	self.scene:find("player"):setState(Player.static.STATE_DIALOG)
end

function Dialog:update(dt)
	if Keyboard.isDown(Config.KEY_ACTION) then
		dt = dt * 5
	end

	self.wait = self.wait - dt
	if self.wait <= 0 then
		self.wait = Dialog.static.CHAR_WAIT
		if self.char < self.lines[self.line]:len() then
			self.char = self.char + 1
			if self.char == self.lines[self.line]:len() then
				self.wait = Dialog.static.LINE_WAIT
			end

		elseif self.line < #self.lines then
			self.char = 0
			self.line = self.line + 1
		end
	end

	if Keyboard.wasPressed(Config.KEY_ACTION)
	and self.line == #self.lines and self.char == self.lines[self.line]:len() then
		self.scene:find("player"):setState(Player.static.STATE_IDLE)
		self:kill()
	end
end

function Dialog:gui()
	love.graphics.setColor(20, 20, 20)
	love.graphics.rectangle("fill", 0, HEIGHT-40, WIDTH, 40)

	love.graphics.setColor(230, 230, 230)
	love.graphics.setFont(self.font)
	local offset = 0
	for i=math.max(1, self.line-2), self.line do
		if i < self.line then
			love.graphics.print(self.lines[i], 8, HEIGHT-32+offset)
		else
			love.graphics.print(self.lines[i]:sub(1, self.char), 8, HEIGHT-32+offset)
		end
		offset = offset + 8
	end

	love.graphics.setColor(255, 255, 255)
end

return Dialog
