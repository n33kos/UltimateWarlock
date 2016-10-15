function loadScene(lvl)
	gs.level = scenes[lvl]
	gs.level.completed = false
	gs.level:load()
end

function unloadScene()
	world = bump.newWorld(16)
	gs.entities = {}
	if gs.player then
		world:add(gs.player, gs.player.position.x, gs.player.position.y, gs.player.width, gs.player.height)
	end
end

function drawWalls()
	walls = {}
	--------------------Horzontal
	for i=0,winx/8 do
		wall_segment = GameObject.create()
		wall_segment.name = "wall"
		wall_segment.sprite = love.graphics.newImage("sprites/walls_h_tall.png")
		wall_segment.sprite:setFilter( "nearest", "nearest")

		--logic block here for stretching
		wall_segment.position.x = i*8
		wall_segment.position.y = 0
		wall_segment.width = 8
		wall_segment.height = 16

		table.insert(walls, wall_segment)
		table.insert(gs.entities, wall_segment)
	end
	for i=0,winx/8 do
		wall_segment = GameObject.create()
		wall_segment.name = "wall"
		wall_segment.sprite = love.graphics.newImage("sprites/walls_h.png")
		wall_segment.sprite:setFilter( "nearest", "nearest")

		--logic block here for stretching
		wall_segment.position.x = i*8
		wall_segment.position.y = winy-8
		wall_segment.width = 8
		wall_segment.height = 8

		table.insert(walls, wall_segment)
		table.insert(gs.entities, wall_segment)
	end
	------------Vertical
	for i=0,winy/8 do
		wall_segment = GameObject.create()
		wall_segment.name = "wall"
		wall_segment.sprite = love.graphics.newImage("sprites/walls_v.png")
		wall_segment.sprite:setFilter( "nearest", "nearest")

		--logic block here for stretching
		wall_segment.position.x = 0
		wall_segment.position.y = i*8
		wall_segment.width = 8
		wall_segment.height = 8

		table.insert(walls, wall_segment)
		table.insert(gs.entities, wall_segment)
	end
	for i=0,winy/8 do
		wall_segment = GameObject.create()
		wall_segment.name = "wall"
		wall_segment.sprite = love.graphics.newImage("sprites/walls_v.png")
		wall_segment.sprite:setFilter( "nearest", "nearest")

		--logic block here for stretching
		wall_segment.position.x = winx-8
		wall_segment.position.y = i*8
		wall_segment.width = 8
		wall_segment.height = 8

		table.insert(walls, wall_segment)
		table.insert(gs.entities, wall_segment)
	end

	--Add Collision Boxes for walls
	world:add(walls[1], 0, 0, winx, 8)
	world:add(walls[2], 0, winy-8, winx, 8)
	world:add(walls[3], 0, 0, 8, winy)
	world:add(walls[4], winx-8, 0, 8, winy)
end

function drawFloors()
	bricks = GameObject.create()
	bricks.name = "bricks"
	bricks.sprite = love.graphics.newImage("sprites/bricks.png")
	bricks.sprite:setFilter( "nearest", "nearest")
	bricks.position.x = 0
	bricks.position.y = 0
	table.insert(gs.entities, bricks)
end

scenes = {}