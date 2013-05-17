astar = {}

function astar.setBounds(lx,ly,bx,by)
	if astar.bounds == nil then
		astar.bounds = {}
	end
	astar.bounds.minX = lx
	astar.bounds.minY = ly
	astar.bounds.maxX = bx
	astar.bounds.maxY = by
end

function astar.mpoint(x,y)
	return {x=x,y=y}
end

function astar.printPath(path)
	for i,point in ipairs(path) do
		print(point.x,point.y)
	end
end

function astar.distance(a,b)
	return math.sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y))
end

function astar.totalDistance(path)
	local total = 0
	for i = 2,#path do
		total = total + distance(path[i],path[i-1])
	end
	return total
end

function astar.contains(point)
	for i,visited in ipairs(astar.visited) do
		if visited.x == point.x and visited.y == point.y then
			return true
		end
	end
	return false
end

function astar.adjacent(path)
	--finds the adjacent location to the last node in the path
	local point = path[#path]
	--the point we are searching from is the last point in the path
	local possible = {
		astar.mpoint(point.x+1,point.y),
		astar.mpoint(point.x-1,point.y),
		astar.mpoint(point.x,point.y+1),
		astar.mpoint(point.x,point.y-1)
	}

	local actual = {}

	for i,p in ipairs(possible) do
		if p.x > astar.bounds.minX and p.x < astar.bounds.maxX and p.y > astar.bounds.minY and p.y < astar.bounds.maxY then
			if not astar.contains(p) then
				table.insert(actual,p)
				table.insert(astar.visited,p)
			end
		end
	end

	return actual
end

function astar.extend(path)
	ret = {}
	for i,point in ipairs(astar.adjacent(path)) do
		local temp = {}
		for j,node in ipairs(path) do
			table.insert(temp,node)
		end
		table.insert(temp,point)
		table.insert(ret,temp)
	end
	return ret
end

function astar.ucs(start,goal)
	astar.visited = {}
	local insert = function(q,p) 
		for i,v in ipairs(q) do
			if #v.path > #p.path then
				print(i)
				return i
			end
		end
		return #q
	end

	local q = {}
	local n = {path={start},dist=astar.totalDistance({start})}

	while n.path[#n.path].x ~= goal.x or n.path[#n.path].y ~= goal.y do
		for i,newPath in ipairs(astar.extend(n.path)) do
			local p = {path=newPath}
			table.insert(q,insert(q,p),p)
		end
		n = table.remove(q,1)
		if n == nil then
			print("failure")
			return {}
		end
	end
	return n.path
end