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

function Map:loadSpriteSheet(spritesheet)
	self.spritesheet = spritesheet
end

function Map:loadSpriteMap(spritemap, mapkey) 
	self.spritemap = {}
	for x,_ in ipairs(spritemap) do
		local row = {}
		for y,val in ipairs(_) do 
			local sprite = spritesheet:makeSprite(mapkey[val])
			sprite:setPosition((x-1)*self.size, (y-1)*self.size)
			table.insert(row,sprite)
		end
	end
end

function Map:setView(nx,ny)
	for x,row in ipairs(spritemap) do 
		for y,sprite in ipairs(row) do
			if x >= nx and y >= ny and x < nx + self.width and y < ny + self.height then
				sprite:setVsible(false)
			else
				sprite:setVisible(true)
			end
		end
	end
end

function Map:update(mouse, keyboard, dt)
end