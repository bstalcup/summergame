require "map"
require "spritesheet"

local map

--spritesheets
local terrain
local units
local misc

local keyboard
local mouse

function love.load()
	mouse = {press = {r=false,l=false}, lastPress = {}}
	keyboard = {press = {}, lastPress = {}}

	terrain = loadTerrain()
	misc = loadMisc()
	units = loadUnits()

	local sm = {}
	for r = 1, 30 do
		local row = {}
		for c = 1,30 do
			if r == 1 or c == 1 or r == 30 or c == 30 then
				table.insert(row,1)
			else
				table.insert(row,2)
			end
		end
		table.insert(sm,row)
	end

	map = Map:new{width = 24, height = 18, size = 32, frameDelay = .1, ox = 16, oy = 12}
	
	map:loadTerrainSpriteSheet(terrain)
	map:loadMiscSpriteSheet(misc)
	map:loadSpriteMap(sm, {"grass","water"})
	map:setView(1,1)
end

function love.draw()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",0,0,800,600)

	love.graphics.setColor(255,255,255)

	units:draw()
	terrain:draw()
	misc:draw()
end

function love.update(dt)
	for key in pairs(keyboard.press) do 
		keyboard.lastPress[key] = keyboard.press[key]
	end
	for button in pairs(mouse.press) do 
		mouse.lastPress[button] = mouse.press[button]
		mouse.press[button] = love.mouse.isDown(button)
	end

	mouse.x = love.mouse.getX()
	mouse.y = love.mouse.getY()

	terrain:update(dt)
	units:update(dt)
	misc:update(dt)
	map:update(mouse,keyboard,dt)
end

function love.keypressed(key,unicode)
	keyboard.press[key] = true
end

function love.keyreleased(key,unicode)
	keyboard.press[key] = false
end
