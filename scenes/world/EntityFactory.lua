local EntityFactory = {}

local Teleport = require("scenes.world.Teleport")
local Text = require("scenes.world.Text")
local Note = require("scenes.world.Note")
local NPC = require("scenes.world.NPC")

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
		return Text(
			o.x + TILEW/2,
			o.y + TILEW/2,
			lines
		)
	elseif o.type == "note" then
		local lines = o.properties.lines:split("##")
		return Note(
			o.x + TILEW/2,
			o.y + TILEW/2,
			lines
		)
	elseif o.type == "npc" then
		return NPC(
			o.x + TILEW/2,
			o.y + TILEW/2,
			o.properties.id,
			tonumber(o.properties.dir)
		)
	end
end

return EntityFactory
