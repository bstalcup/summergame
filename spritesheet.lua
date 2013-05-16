require "sprite"

SpriteSheet = {}

function SpriteSheet:new(o)
	local m = o or {}
	setmetatable(m,SpriteSheet)
	self.__index = self
	return m
end

function SpriteSheet:addFrames(key,frames)
	print(key)
	for k in pairs(frames) do
		print("\t",k,frames[k].frameTime)
	end
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
	if self.sprites then 
		if self.batch == nil then
			self.batch = love.graphics.newSpriteBatch(self.image)
		end
		self.batch:clear()
		self.batch:bind()
		for i,sprite in ipairs(self.sprites) do
			if(sprite:isVisible()) then
				self.batch:addq(sprite:getQuad(), sprite:getX(), sprite:getY())
			end
		end
		self.batch:unbind()
		love.graphics.draw(self.batch,0,0)
	end
end

function SpriteSheet:update(dt)
	if self.sprites ~= nil then
		for i,sprite in ipairs(self.sprites) do
			sprite:update(dt)
		end
	end
end

--HARDCODED SPRITESHEETS INCOMING--

function loadUnits()
	local ss = SpriteSheet:new{image = love.graphics.newImage("spriteunit.png"), frameTime=.1}
	ss:addFrames("fighter",{
			default = {
				frames = {
						love.graphics.newQuad(0,0,32,32,1024,1024),
						love.graphics.newQuad(0,32,32,32,1024,1024)
					},
				target = "default"
			}

		})
	return ss
end


function loadMisc()
	local ss = SpriteSheet:new{image = love.graphics.newImage("spritemeta.png"), frameTime=.1}
	ss:addFrames("cursor",{
			default = {
				frames = {
						love.graphics.newQuad(0,0,32,32,1024,1024),
						love.graphics.newQuad(0,32,32,32,1024,1024)
					},
				target = "default",
				frameTime = .5
			},
			click = {
				frames = {
						love.graphics.newQuad(64,0,32,32,1024,1024),
						love.graphics.newQuad(64,32,32,32,1024,1024)
				},
				target = "default",
				frameTime = .25
			}
		})
	return ss
end


function loadEffects()
	local ss = SpriteSheet:new{image = love.graphics.newImage("spriteterrain.png"), frameTime=.1}
	ss:addFrames("explosion",{
			default = {
				frames = {
						love.graphics.newQuad( 0, 0, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 32, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 64, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 96, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 128, 32, 32, 1024, 1024 ),
						love.graphics.newQuad( 0, 160, 32, 32, 1024, 1024 )
				},
				target= "default"
			}
		})
	return ss
end


function loadTerrain()
	local ss = SpriteSheet:new{image = love.graphics.newImage("spriteterrain.png"), frameTime=.1}
	ss:addFrames("tile1",{
			default = {
				frames = {
						love.graphics.newQuad( 0, 0, 32, 32, 1024, 1024 )
					},
				target = "default"
			}
			--snow{
			--	frames = {Quads},
			--	target = "snow"
			--}

		}
		)
	ss:addFrames("tile2",{
			default={
				frames = {
						love.graphics.newQuad( 32, 0, 32, 32, 1024, 1024 )
					},
				target = "default"
				}
			})
	ss:addFrames("tile3", {
			default={
				frames = {
						love.graphics.newQuad( 64, 0, 32, 32, 1024, 1024 )
				}
			}
		})
	return ss
end
		