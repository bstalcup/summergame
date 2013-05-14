SpriteSheet = {}

function SpriteSheet.new(o)
	local m = o or {}
	setmetatable(m,Map)
	return m
end

function SpriteSheet.loadSpritePalatte(key, palatte)
	if self.palattes == nil then
		self.palattes = {}
	end
	self.palattes[key] = palatte
end


function SpriteSheet.addSpriteForKey(key, quad, x, y, pk)
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

function SpriteSheet.clearSpritesForKey(key)
	self.update = true
	if self.sprites ~= nil and self.sprites[key] ~= nil then
		self.sprites[key] = nil
	end
end

function SpriteSheet.draw()
	if self.batch == nil then
		self.batch = love.graphics.newSpriteBatch(self.image)
		self.update = true
	end
	if self.update then
		batch.bind()
		self.update = false
		for key,sprites in ipairs(self.sprites) do
			for i,sprite in ipairs(sprite) do
				batch:addq(sprite.quad,sprite.x,sprite.y)
			end
		end
		batch.unbind()
	end
end
