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
			local sprite = self.spritesheet:makeSprite(mapkey[val])
			sprite:setPosition((x-1)*self.size, (y-1)*self.size)
			table.insert(row,sprite)
		end
		table.insert(self.spritemap,row)
	end
	self:setView(1,10)
end

function Map:setView(nx,ny)

	if nx < -5 then nx = -5 end
	if ny < -5 then ny = -5 end
	if nx > #self.spritemap - self.height + 5 then nx = #self.spritemap - self.height + 5 end
	if ny > #self.spritemap[1] - self.width + 5 then ny = #self.spritemap[1] - self.height + 5 end

	if self.vx ~= nx or self.vy ~= ny then
		self.vx = nx
		self.vy = ny

		for x,row in ipairs(self.spritemap) do 
			for y,sprite in ipairs(row) do
				if x >= nx and y >= ny and x < nx + self.width and y < ny + self.height then
					sprite:setVisible(true)
					sprite:setPosition((x-nx)*self.size,(y-ny)*self.size)
				else
					sprite:setVisible(false)
				end
			end
		end
	end
end

function Map:update(mouse, keyboard, dt)
	if mouse.x < 100 or mouse.x > 700 or mouse.y < 100 or mouse.y > 500 then 
		if self.timeElapsed == nil then
			self.timeElapsed = 0
		end
		self.timeElapsed = self.timeElapsed + dt
		if self.timeElapsed > self.frameDelay then
			self.timeElapsed = 0

			local dx = 0
			local dy = 0

			if mouse.x < 100 and mouse.x > 0 then
				dx = -1
			end
			if mouse.x > 700 and mouse.x < 800 then
				dx = 1
			end
			if mouse.y < 100 and mouse.y > 0 then
				dy = -1
			end
			if mouse.y > 500 and mouse.y < 600 then
				dy = 1
			end

			self:setView(self.vx + dx, self.vy + dy)
		end
	end
end