local Tilemap = class("Tilemap", Entity)

local EntityFactory = require("scenes.world.EntityFactory")

function Tilemap:initialize()
	Entity.initialize(self, 0, 0, 10, "tilemap")

	self.tiles = Resources.getImage("world/tilemap.png")
	self:createQuads()
end

function Tilemap:createQuads()
	local tilesx = math.floor(self.tiles:getWidth() / TILEW)
	local tilesy = math.floor(self.tiles:getHeight() / TILEW)

	self.quads = {}
	for iy = 0, tilesy-1 do
		for ix = 0, tilesx-1 do
			local quad = love.graphics.newQuad(
				ix*TILEW, iy*TILEW,
				TILEW, TILEW,
				self.tiles:getWidth(), self.tiles:getHeight()
			)
			table.insert(self.quads, quad)
		end
	end
end

function Tilemap:load(id)
	local file = love.filesystem.load("data/levels/" .. id .. ".lua")
	local data = file()

	for i, layer in ipairs(data.layers) do
		if layer.type == "tilelayer" then
			self.mapw = layer.width
			self.maph = layer.height
			self.batch = love.graphics.newSpriteBatch(self.tiles, self.mapw*self.maph)

			self.data = {}
			for ix = 0, self.mapw-1 do
				self.data[ix] = {}
				for iy = 0, self.maph-1 do
					id = layer.data[ix + iy*self.mapw + 1]
					self.data[ix][iy] = id-1
					if id > 0 then
						self.batch:add(self.quads[id], ix*TILEW, iy*TILEW)
					end
				end
			end
		
		elseif layer.type == "objectgroup" then
			for j, o in ipairs(layer.objects) do
				self.scene:add(EntityFactory.create(o))
			end
		end
	end
end

function Tilemap:isSolid(x, y)
	return self.data[x][y] >= 512
end

function Tilemap:draw()
	love.graphics.draw(self.batch, 0, 0)
end

return Tilemap
