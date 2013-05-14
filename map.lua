Map = {}

--self.size is tile size in pixels
--self.width is width in tiles
--self.height is height in tiles

function Map:new(o)
	local m = o or {}
	setmetatable(m,Map)
	self.__index = self
	return m
end

function Map:loadCollisionMap(col)
	self.col = col
end

function Map:loadSpriteSheet(ss)
	self.ss = ss
end

function Map:loadSpriteMap(sm, pk) 
	self.sm = sm
	self.pk = pk
end

function Map:updateView(x,y)
	self.ss:clearSpritesForKey("map")
	for tx = x , (x-1+self.width) do
		for ty = y , (y-1+self.height) do
			local rx = (tx - x) * self.size
			local ry = (ty - y) * self.size
			if self.sm[tx] and self.sm[tx][ty] then 
				local val = self.sm[tx][ty]
				self.ss:addSpriteForKey("map", val, rx, ry, self.pk)
			end
		end
	end
end

function Map:update(mouse, keyboard)
end
