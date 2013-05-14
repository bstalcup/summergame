Map = {}

function Map.new(o)
	local m = o or {}
	setmetatable(m,Map)
	return m
end

function Map.loadCollisionMap(col)
	self.col = col
end

function Map.loadSpriteSet(ss)
	self.ss = ss
end

function Map.loadSpriteMap(sm, palatte, pk) 
	self.sm = sm
end

function Map.addUnit(u)
	if self.us == nil then 
		self.us = {}
	end
	table.insert(self.us,u)
end

function updateView(x,y)
	self.ss:clearSpritesForKey("map")
	for tx = x , (x+self.width) do
		for ty = y , (y+self.height) do
			ss:addSpriteForKey("map", self.sm[tx][ty], (tx-x)*self.size, (ty-x)*self.size, self.pk)
		end
	end
end