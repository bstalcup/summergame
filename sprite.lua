Sprite = {}

function Sprite:new(o)
	local m = o or {}
	setmetatable(m,Sprite)
	self.__index = self
	return m
end

--example frames
--{
--	default = {
--		frames  = {Quads}
--		target = "default"
--	}	
--	jump = {
--		frames = {Quads}
--		target = "default"
--	}
--}

function Sprite:loadFrames(frames)
	self.frames = frames
end

function Sprite:setAction(action)
	self.action = action
end

function Sprite:setPosition(x,y)
	self.x = x
	self.y = y
end

function Sprite:setVisible(visible)
	self.visible = visible
end

function Sprite:getX() 
	return self.x
end

function Sprite:getY()
	return self.y
end

function Sprite:isVisible()
	return self.visible
end

function Sprite:getQuad()
	if self.action == nil then
		self.action = "default"
	end
	if self.frameCount == nil then
		self.frameCount = 1
	end
	return self.frames[self.action].frames[self.frameCount]
end

function Sprite:update(dt)
	if self.frameCount == nil then
		self.frameCount = 1
	end
	if self.timeElapsed == nil then 
		self.timeElapsed = 0
	end
	if self.action == nil then 
		self.action = "default"
	end

	self.timeElapsed = self.timeElapsed + dt
	--print(self.timeElapsed,self.frameTime,dt)
	if self.timeElapsed > self.frameTime then
		self.timeElapsed = 0
		self.frameCount = self.frameCount + 1
		if self.frameCount > #self.frames[self.action].frames then
			self.action = self.frames[self.action].target
			self.frameCount = 1
		end
	end
end