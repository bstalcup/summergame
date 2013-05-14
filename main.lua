require "map"
require "spritesheet"

local map
local ss

function love.load() 
	map = Map:new()
	ss  = SpriteSheet:new()
end

function love.draw()
    love.graphics.print("Hello World", 400, 300)
end