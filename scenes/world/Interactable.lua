local Interactable = class("Interactable", Entity)

function Interactable:initialize(...)
	Entity.initialize(self, ...)
end

function Interactable:interact()
	print("Override me!")
end

function Interactable:getTile()
	return math.floor(self.x/TILEW), math.floor(self.y/TILEW)
end

return Interactable
