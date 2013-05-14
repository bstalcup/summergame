require "map"
require "spritesheet"

local map
local sprite
local i

function love.load()
	i = love.graphics.newImage("spritemap.png")
	sprite = SpriteSheet:new{image = i} 
	local palatte = {
		love.graphics.newQuad(0,0,32,32,1024,1024), 
		love.graphics.newQuad(32,0,32,32,1024,1024), 
		love.graphics.newQuad(64,0,32,32,1024,1024)
	}
	sprite:loadSpritePalatte("map",palatte)
	local sm = {
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, -- 1
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 2
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 3
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 4
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 5
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 6
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 7
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 8
		{1, 2, 2, 2, 2, 2, 2, 2, 2, 1}, -- 9
		{1, 1, 1, 1, 1, 1, 1, 1, 1, 1}  -- 10
	}
	map = Map:new{width = 10, height = 10, size = 32}
	
	map:loadSpriteSheet(sprite)
	map:loadSpriteMap(sm, "map")

	map:updateView(1,1)
end

function love.draw()
	sprite:draw()
end