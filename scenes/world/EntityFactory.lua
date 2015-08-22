local EntityFactory = {}

local Teleport = require("scenes.world.Teleport")

function EntityFactory.create(o)
	if o.type == "teleport" then
		return Teleport(
			o.x, o.y,
			o.width, o.height,
			tonumber(o.properties.destx),
			tonumber(o.properties.desty),
			tonumber(o.properties.dir)
		)
	end
end

return EntityFactory
