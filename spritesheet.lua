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
	local s = Sprite:new()
	s:loadFrames(self.frames[key])
	if self.sprites == nil then
		self.sprites = {}
	end
	table.insert(self.sprites,s)
	return s
end

function SpriteSheet:draw()
	for i,sprite in ipairs(self.sprite) do
		love.grapics.draw(sprite:getQuad(), sprite:getX(), sprite:getY())
	end
end

function SpriteSheet:update(dt)
	for i,sprite in ipairs(self.sprite) do
		sprite:update(dt)
	end
end



function loadSS()
	local ss = SpriteSheet:new()
	ss:addFrames("grass",{
			default={
				frames = {
						love.graphics.newQuad( 0, 0, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 0, 32, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 0, 64, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 0, 96, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 0, 128, 32, 32, 1024, 1024 )
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
						love.graphics.newQuad( 32, 0, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 32, 32, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 32, 64, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 32, 96, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 32, 128, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 32, 160, 32, 32, 1024, 1024 )
					},
				target = "default"
				}
			})
	ss:addFrames("block", {
			default={
				frames = {
						love.graphics.newQuad( 64, 0, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 64, 32, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 64, 64, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 64, 96, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 64, 128, 32, 32, 1024, 1024 )
						love.graphics.newQuad( 64, 160, 32, 32, 1024, 1024 )

				}
			}
		})
end
		