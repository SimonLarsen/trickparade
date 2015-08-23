local GUIComponent = class("GUIComponent", Entity)

function GUIComponent:initialize()
	Entity.initialize(self)

	self._box_image = Resources.getImage("box.png")
	self._box_quads = {}
	for iy = 0, 2 do
		for ix = 0, 2 do
			table.insert(self._box_quads, love.graphics.newQuad(ix*8, iy*8, 8, 8, 24, 24))
		end
	end
end

function GUIComponent:drawBox(x, y, w, h)
	local sx = (w-16)/8
	local sy = (h-16)/8

	love.graphics.draw(self._box_image, self._box_quads[1], x, y)
	love.graphics.draw(self._box_image, self._box_quads[2], x+8, y, 0, sx, 1)
	love.graphics.draw(self._box_image, self._box_quads[3], x+w-8, y)
	love.graphics.draw(self._box_image, self._box_quads[4], x, y+8, 0, 1, sy)
	love.graphics.draw(self._box_image, self._box_quads[5], x+8, y+8, 0, sx, sy)
	love.graphics.draw(self._box_image, self._box_quads[6], x+w-8, y+8, 0, 1, sy)
	love.graphics.draw(self._box_image, self._box_quads[7], x, y+h-8)
	love.graphics.draw(self._box_image, self._box_quads[8], x+8, y+h-8, 0, sx, 1)
	love.graphics.draw(self._box_image, self._box_quads[9], x+w-8, y+h-8)
end

return GUIComponent
