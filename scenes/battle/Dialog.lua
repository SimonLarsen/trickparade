local GUIComponent = require("gui.GUIComponent")

local Dialog = class("Dialog", GUIComponent)

Dialog.static.CHAR_WAIT = 0.05
Dialog.static.LINE_WAIT = 0.5

function Dialog:initialize(lines, fun)
	GUIComponent.initialize(self)

	self.font = Resources.getImageFont("small.png")

	self.fun = fun
	self.lines = lines
	self.line = 1
	self.char = 1
	self.wait = 0
	self.actionReleased = false
end

function Dialog:enter()

end

function Dialog:update(dt)
	self.actionReleased = self.actionReleased or not Keyboard.isDown(Config.KEY_ACTION)
	if self.actionReleased and Keyboard.isDown(Config.KEY_ACTION) then
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

	if Keyboard.wasPressed(Config.KEY_ACTION, true)
	and self.line == #self.lines and self.char == self.lines[self.line]:len() then
		self:kill()
		if self.fun then self.fun() end
	end
end

function Dialog:gui()
	love.graphics.setColor(255, 255, 255)
	self:drawBox(0, HEIGHT/2-20, WIDTH, 40)

	love.graphics.setColor(230, 230, 230)
	love.graphics.setFont(self.font)
	local offset = 0
	for i=math.max(1, self.line-2), self.line do
		if i < self.line then
			love.graphics.print(self.lines[i], 8, HEIGHT/2-12+offset)
		else
			love.graphics.print(self.lines[i]:sub(1, self.char), 8, HEIGHT/2-12+offset)
		end
		offset = offset + 8
	end

	love.graphics.setColor(255, 255, 255)
end

return Dialog
