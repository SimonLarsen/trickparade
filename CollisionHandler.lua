local CollisionHandler = {}

function CollisionHandler.checkAll(scene, dt)
	local entities = scene:getEntities()
	
	for i=1, #entities do
		for j=i+1, #entities do
			local v = entities[i]
			local w = entities[j]
			if v.collider and w.collider then
				if CollisionHandler.check(v, w) then
					v:onCollide(w, dt)
					w:onCollide(v, dt)
				end
				w:onCollide(v, dt)
			end
		end
	end
end

function CollisionHandler.check(v, w)
	if v.collider:getType() == "box" and w.collider:getType() == "box" then
		return CollisionHandler.checkBoxBox(v, w)
	end
end

function CollisionHandler.checkBoxBox(a, b)
	if math.abs((a.x+a.collider.ox) - (b.x+b.collider.ox)) > (a.collider.h+b.collider.h)/2
		or math.abs((a.y+a.collider.oy) - (b.y+b.collider.oy)) > (a.collider.h+b.collider.h)/4 then
		return false
	end

	return true
end

return CollisionHandler
