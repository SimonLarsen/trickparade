local Tilemap = class("Tilemap", Entity)

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

	for i,v in ipairs(data.layers) do
		self.mapw = v.width
		self.maph = v.height
		self.batch = love.graphics.newSpriteBatch(self.tiles, self.mapw*self.maph)

		self.data = {}
		if v.type == "tilelayer" then
			for ix = 0, self.mapw-1 do
				self.data[ix] = {}
				for iy = 0, self.maph-1 do
					id = v.data[ix + iy*self.mapw + 1]
					self.data[ix][iy] = id-1
					self.batch:add(self.quads[id], ix*TILEW, iy*TILEW)
				end
			end
		end
	end
end

function Tilemap:draw()
	love.graphics.draw(self.batch, 0, 0)
end

return Tilemap
