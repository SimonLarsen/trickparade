local Entity = class("Entity")

function Entity:initialize(x, y, z, name)
	self.x = x or 0
	self.y = y or 0
	self.z = z or 0
	
	self.name = name

	self.alive = true
end

function Entity:enter()
	
end

function Entity:update(dt)
	
end

function Entity:draw()
	
end

function Entity:gui()
	
end

function Entity:kill()
	self.alive = false
end

function Entity:isAlive()
	return self.alive
end

function Entity:setName(name)
	self.name = name
end

function Entity:getName()
	return self.name
end

function Entity:onCollide(o)
	
end

function Entity:onRemove()
	
end

return Entity
