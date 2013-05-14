require "sprite"

SpriteSheet = {}

function SpriteSheet:new(o)
	local m = o or {}
	setmetatable(m,SpriteSheet)
	self.__index = self
	return m
end

function SpriteSheet:addFrames(key,frames)
	if self.frames == nil then
		self.frames = {}
	end
	self.frames[key] = frames
end

function SpriteSheet:makeSprite(key)
	local s = Sprite:new{frameTime=250}
	s:loadFrames(self.frames[key])
	if self.sprites == nil then
		self.sprites = {}
	end
	table.insert(self.sprites,s)
	return s
end

function SpriteSheet:draw()
	for i,sprite in ipairs(self.sprite) do
		if sprite:isVisible() then
			love.grapics.draw(sprite:getQuad(), sprite:getX(), sprite:getY())
		end
	end
end

function SpriteSheet:update(dt)
	for i,sprite in ipairs(self.sprite) do
		sprite:update(dt)
	end
end


