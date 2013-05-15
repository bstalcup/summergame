require "map"
require "spritesheet"

local map
local terrain

local keyboard
local mouse

function love.load()
	terrain = loadTerrain()

	local sm = {}
	for r = 1, 100 do
		local row = {}
		for c = 1,100 do
			if r == 1 or c == 1 or r == 100 or c == 100 then
				table.insert(row,1)
			else
				table.insert(row,2)
			end
		end
		print(#row)
		table.insert(sm,row)
	end

	map = Map:new{width = 24, height = 18, size = 32}
	
	map:loadSpriteSheet(terrain)
	map:loadSpriteMap(sm, {"grass","water"})
	map:setView(1,1)
end

function love.draw()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",0,0,800,600)

	love.graphics.setColor(255,255,255)
	terrain:draw()
end

function love.update(dt)
	mouse.x = love.mouse.getX()
	mouse.y = love.mouse.getY()
	
	terrain:update(mouse,keyboard,dt)
end

function love.keypressed(key,unicode)
	keyboard[key] = true
end

function love.keyreleased(key,unicode)
	keyboard[key] = false
end
