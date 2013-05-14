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
	local s = Sprite:new{frameTime = self.frameTime}
	s:loadFrames(self.frames[key])
	if self.sprites == nil then
		self.sprites = {}
	end
	table.insert(self.sprites,s)
	return s
end

function SpriteSheet:draw()
	if self.batch == nil then
		self.batch = love.graphics.newSpriteBatch(self.image)
	end
	self.batch:clear()
	self.batch:bind()
	for i,sprite in ipairs(self.sprites) do
		self.batch:addq(sprite:getQuad(), sprite:getX(), sprite:getY())
	end
	self.batch:unbind()
	love.graphics.draw(self.batch,12,16)
end

function SpriteSheet:update(dt)
	for i,sprite in ipairs(self.sprites) do
		sprite:update(dt)
	end
end

function loadSS()
	local ss = SpriteSheet:new{image = love.graphics.newImage("spritemap.png"), frameTime=.1}
	ss:addFrames("grass",{
			default = {
				frames = {
						love.graphics.newQuad( 0, 0, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 32, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 64, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 96, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 128, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 160, 32, 32, 1024, 1024 )
					},
				target = "default"
			}
			--snow{
			--	frames = {Quads},
			--	target = "snow"
			--}

		}
		)
	ss:addFrames("water",{
			default={
				frames = {
						love.graphics.newQuad( 32, 0, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 32, 32, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 32, 64, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 32, 96, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 32, 128, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 32, 160, 32, 32, 1024, 1024 )
					},
				target = "default"
				}
			})
	ss:addFrames("block", {
			default={
				frames = {
						love.graphics.newQuad( 64, 0, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 64, 32, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 64, 64, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 64, 96, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 64, 128, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 64, 160, 32, 32, 1024, 1024 )

				}
			}
		})
	return ss
end
		