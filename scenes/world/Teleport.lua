local Teleport = class("Teleport", Entity)

local BoxCollider = require("BoxCollider")

function Teleport:initialize(x, y, width, height, destx, desty, dir)
	Entity.initialize(self, x, y, 0, "teleport")

	self.collider = BoxCollider(width, height, width/2, height/2)

	self.destx = destx
	self.desty = desty
	self.dir = dir
end

return Teleport
