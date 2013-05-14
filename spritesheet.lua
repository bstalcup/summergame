SpriteSheet = {}

function SpriteSheet:new(o)
	local m = o or {}
	setmetatable(m,SpriteSheet)
	self.__index = self
	return m
end

function SpriteSheet:loadSpritePalatte(key, palatte)
	if self.palattes == nil then
		self.palattes = {}
	end
	self.palattes[key] = palatte
end


function SpriteSheet:addSpriteForKey(key, quad, x, y, pk)
	self.update = true 
	local sprite = {}
	local palatte = pk or key
	sprite.quad = self.palattes[palatte][quad]
	sprite.x = x
	sprite.y = y
	if self.sprites == nil then
		self.sprites = {}
	end
	if self.sprites[key] == nil then
		self.sprites[key] = {}
	end
	table.insert(self.sprites[key],sprite)
end

function SpriteSheet:clearSpritesForKey(key)
	self.update = true
	if self.sprites ~= nil and self.sprites[key] ~= nil then
		self.sprites[key] = nil
	end
end

function SpriteSheet:draw()
	if self.batch == nil then
		self.batch = love.graphics.newSpriteBatch(self.image)
		self.update = true
	end
	if self.update then
		self.batch:bind()
		self.update = false
		print(#self.sprites)
		for key in pairs(self.sprites) do
			sprite = self.sprites[key]
			for i,sprite in ipairs(sprite) do
				self.batch:addq(sprite.quad,sprite.x,sprite.y)
			end
		end
		self.batch:unbind()
	end
	love.graphics.draw(self.batch,10,10)
	love.graphics.print("Hello World",0,0)
end
