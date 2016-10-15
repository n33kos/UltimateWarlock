Level = {}
Level.__index = Level

function Level.create()
	local lvl = {}
	setmetatable(lvl,Level)
	lvl.completed = false
	lvl.coordinates = {}
		lvl.coordinates.x = 0
		lvl.coordinates.y = 0
	return lvl
end

function Level:load()
end

function Level:update()
end

function Level:draw()
end

function Level:complete()
end