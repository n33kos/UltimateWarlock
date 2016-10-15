scenes.intro = Level.create()
function scenes.intro:load()
	-- Load Player
	gs.player = Player.create()
	gs.player:load()
	gs.player.position.x = winx/2 - 8
	gs.player.position.y = winy-16

	--Load backround Sprites
	for i=1,math.random(20,30) do
		shrub = GameObject.create()
		shrub.name = "shrub"
		shrub.sprite = love.graphics.newImage("sprites/shrub.png")
		shrub.sprite:setFilter( "nearest", "nearest")
		shrub.position.x = math.random(0, winx)
		shrub.position.y = math.random(0, winy)
		table.insert(gs.entities, shrub)
	end

	--Load static Sprites
	for i=1,math.random(3,5) do
		rock = GameObject.create()
		rock.sprite = love.graphics.newImage("sprites/rock.png")
		rock.sprite:setFilter( "nearest", "nearest")
		rock.position.x = math.random(0, winx)
		rock.position.y = math.random(0, winy)
		rock.physics.enabled = true
		rock.physics.type = "static"
		rock.width = 8
		rock.height = 6
		world:add(rock, rock.position.x, rock.position.y, rock.width, rock.height)
		table.insert(gs.entities, rock)
	end

	entrance = GameObject.create()
	entrance.name = "entrance"
	entrance.sprite = love.graphics.newImage("sprites/entrance.png")
	entrance.sprite:setFilter( "nearest", "nearest")
	entrance.physics.enabled = true
	entrance.physics.type = "trigger"
	entrance.physics.trigger = "loadlevel"
	entrance.physics.triggerval = "test"
	entrance.physics.width = 160
	entrance.physics.height = 30

	entrance.physics.enabled = true
	entrance.physics.type = "trigger"
	entrance.physics.trigger = "loadlevel"
	entrance.physics.triggerval = "test"

	table.insert(gs.entities, entrance)



	--Add Collision Boxes for walls
	world:add({name="wall"}, 0, 0, 68, 46)
	world:add(entrance, 0, 0, entrance.physics.width, 30)
	world:add({name="wall"}, 92, 0, 68, 46)

	world:add({name="wall"}, 0, winy, winx, 1)
	world:add({name="wall"}, 0, 0, 1, winy)
	world:add({name="wall"}, winx, 0, 1, winy)

end
function scenes.intro:update()
end