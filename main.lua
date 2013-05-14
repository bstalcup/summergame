require "map"
require "spritesheet"

local map
local sprite
local i,r

function love.load()
	sprite = loadSS()
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
	map:loadSpriteMap(sm, {"grass","water"})

	map:setView(1,1)
	r = 0
end

function love.draw()
	love.graphics.setColor(r,0,0)
	r = r + 1
	love.graphics.rectangle("fill",0,0,800,600)
	
	love.graphics.setColor(255,255,255)
	sprite:draw()
end

function love.update(dt)
	sprite:update(dt)
end