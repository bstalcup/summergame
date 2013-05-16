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

function Map:loadTerrainSpriteSheet(spritesheet)
	self.spritesheet = spritesheet
end

function Map:loadMiscSpriteSheet(spritesheet)
	self.misc = spritesheet
end

function Map:loadSpriteMap(spritemap, mapkey) 
	self.spritemap = {}
	for y,_ in ipairs(spritemap) do
		local row = {}
		for x,val in ipairs(_) do 
			local sprite = self.spritesheet:makeSprite(mapkey[val])
			sprite:setPosition((x-1)*self.size, (y-1)*self.size)
			table.insert(row,sprite)
		end
		table.insert(self.spritemap,row)
	end
	self:setView(1,10)
end

function Map:setView(nx,ny)
	if nx < -4 then nx = -4 end
	if ny < -4 then ny = -4 end
	if nx > #self.spritemap[1] - self.width + 5 then nx = #self.spritemap[1] - self.width + 5 end
	if ny > #self.spritemap - self.height + 5 then ny = #self.spritemap - self.height + 5 end

	if self.vx ~= nx or self.vy ~= ny then
		self.vx = nx
		self.vy = ny

		for y,row in ipairs(self.spritemap) do 
			for x,sprite in ipairs(row) do
				if x >= nx and y >= ny and x < nx + self.width and y < ny + self.height then
					sprite:setVisible(true)
					sprite:setPosition(self.ox + (x-nx)*self.size,self.oy + (y-ny)*self.size)
				else
					sprite:setVisible(false)
				end
			end
		end
	end
end

function Map:findPath(ax,ay,bx,by) 
	local start = {x=ax,y=ay}
	local goal  = {x=bx,y=by}

	local print_path = function(a) 
		for i,point in ipairs(a) do
			print(i,point.x,point.y)
		end
	end

	local adj = function(path)
		local point = path[#path] 
		local check = {{x=point.x+1,y=point.y},{x=point.x-1,y=point.y},{x=point.x,y=point.y+1},{x=point.x,y=point.y-1}}
		local ret = {}

		local contains = function(p)
			for i,a in ipairs(path) do 
				if a.x == p.x and a.y == p.y then
					return true
				end
			end
			return false
		end

		for i,c in ipairs(check) do
			if c.x > 0 and c.x <= self.width and c.y > 0 and c.y <= self.height then
				if self.col == nil or self.col[c.y][c.x] then
					if not contains(c) then
						table.insert(ret,c)
					end
				end
			end
		end
		return ret
	end
	local copy = function(array,point)
		local a = {}
		for i,val in ipairs(array) do
			table.insert(a,val)
		end
		table.insert(a,point)
		return a
	end
	local distance = function(a,b)
		if a == nil or b == nil then return 0 end 
		return math.sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y))
	end

	local q = {}
	local n = {start}
	while n[#n].x ~= goal.x and n[#n].x ~= goal.x do
		print_path(n)
		for i,point in ipairs(adj(n)) do
			print(point)
			table.insert(q,copy(n,point))
		end
		table.sort(q,function(patha,pathb)
			print_path(patha)
			print_path(pathb)
			local adist = 0
			local bdist = 0
			for i = 2,#patha do
				adist = adist + distance(patha[i-1],patha[i])
			end
			for i = 2,#pathb do 
				bdist = bdist + distance(pathb[i-1],patha[i])
			end
			return adist < bdist
		end)
		n = table.remove(q)
	end
	return n
end


function Map:update(mouse, keyboard, dt)
	if self.cursor == nil then
		self.cursor = self.misc:makeSprite("cursor")
		self.cursor:setVisible(true)
	end
	if mouse.x > 0 and mouse.x < 800 and mouse.y > 0 and mouse.y < 600 then
		local cx = math.floor((mouse.x-self.ox)/self.size)*self.size + self.ox
		local cy = math.floor((mouse.y-self.oy)/self.size)*self.size + self.oy

		self.cursor:setPosition(cx,cy)

	end
	if mouse.press["l"] and not mouse.lastPress["l"] then
		self.cursor:setAction("click")
	end

	if mouse.x < 100 or mouse.x > 700 or mouse.y < 100 or mouse.y > 500 then 
		if self.scrollTime == nil then
			self.scrollTime = 0
		end
		self.scrollTime = self.scrollTime + dt
		if self.scrollTime > self.frameDelay then
			self.scrollTime = 0

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
	else
		self.scrollTime = 0
	end
end