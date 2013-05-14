Sprite = {}

function Sprite:new(o)
	local m = o or {}
	setmetatable(m,Sprite)
	self.__index = self
	return m
end

--example frames
--{
--	default={
--		frames  = {Quads}
--		looping = true 	
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

function Sprite:getX() 
	return self.x
end

function Sprite:getY()
	return self.y
end

function Sprite:getQuad()
	if self.action == nil then
		self.aciton = "default"
	end
	local thisAction = self.frames[self.action].frames
	return self.frames[self.action].frames[self.frameCount % #thisAction]
end

function Sprite:update(dt)
	if self.frameCount == nil then
		self.frameCount = 0
	end
	if self.frameMax == nil then
		self.frameMax = 0
		for key in pairs(self.frames) do
			if #self.frames[key].frames > self.frameMax then
				self.frameMax = #self.frames[key].frames
			end
		end
	end
	if self.timeElapsed == nil then 
		self.timeElapsed = 0
	end
	self.timeElapsed = self.timeElapsed + dt
	if self.timeElapsed > self.frameTime then
		self.timeElapsed = 0
		self.frameCount = (self.frameCount + 1) % self.frameMax
	end
end