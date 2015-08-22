local EntityFactory = {}

local Teleport = require("scenes.world.Teleport")
local Text = require("scenes.world.Text")
local Note = require("scenes.world.Note")

function EntityFactory.create(o)
	if o.type == "teleport" then
		return Teleport(
			o.x, o.y, o.width, o.height,
			tonumber(o.properties.destx),
			tonumber(o.properties.desty),
			tonumber(o.properties.dir)
		)

	elseif o.type == "text" then
		local lines = o.properties.lines:split("##")
		return Text(o.x, o.y, lines)

	elseif o.type == "note" then
		local lines = o.properties.lines:split("##")
		return Note(o.x, o.y, lines)
	end
end

return EntityFactory
