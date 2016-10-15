scenes.test = Level.create()
function scenes.test:load()
	gs.difficulty = gs.difficulty + 1
	gs.bgmusic:setPitch(gs.bgmusic:getPitch( ) + 0.005)

	--floors
	drawFloors()

	--create world boundaries
	drawWalls()


	for i=1,math.min(math.random(0,gs.difficulty), 2) do
		rock = GameObject.create()
		rock.sprite = love.graphics.newImage("sprites/walls_h_tall.png")
		rock.sprite:setFilter( "nearest", "nearest")
		rock.position.x = math.random(8, winx/2-16)
		rock.position.y = math.random(16, winy-24)
		rock.physics.enabled = true
		rock.physics.type = "static"
		rock.width = 8
		rock.height = 8
		world:add(rock, rock.position.x, rock.position.y, rock.width, rock.height)
		table.insert(gs.entities, rock)
	end

	for i=1,math.min(math.random(0,gs.difficulty), 2) do
		rock = GameObject.create()
		rock.sprite = love.graphics.newImage("sprites/walls_h_tall.png")
		rock.sprite:setFilter( "nearest", "nearest")
		rock.position.x = math.random(winx/2+16, winx-8)
		rock.position.y = math.random(16, winy-24)
		rock.physics.enabled = true
		rock.physics.type = "static"
		rock.width = 8
		rock.height = 8
		world:add(rock, rock.position.x, rock.position.y, rock.width, rock.height)
		table.insert(gs.entities, rock)
	end

	--Load static Sprites
	chest = {}
	chest = Chest.create()
	if math.random(0, 100) > 50 then
		chest.position.x = math.random(winx/2+16, winx-24)
		chest.position.y = math.random(16, winy-24)
	else
		chest.position.x = math.random(24, winx/2-16)
		chest.position.y = math.random(16, winy-24)
	end
	chest.width = 16
	chest.height = 16
	world:add(chest, chest.position.x, chest.position.y, chest.width, chest.height)
	table.insert(gs.entities, chest)
	self.chest = chest

	gs.player:teleport(winx/2,winy-17)

	self.enemies = {}
	--Load Enemies
	for i=1,math.min(gs.difficulty, 5) do
		tmp = Witch.create()
		tmp.physics.target = gs.player
		world:add(tmp, tmp.position.x, tmp.position.y, tmp.width, tmp.height)
		table.insert(gs.entities, tmp)
		table.insert(self.enemies, tmp)
	end

	exit = GameObject.create()
	exit.name = "exit"
	exit.sprite = love.graphics.newImage("sprites/exit_closed.png")
	exit.sprite:setFilter( "nearest", "nearest")
	exit.position.x = 70
	exit.position.y = 0
	table.insert(gs.entities, exit)
	

end
function scenes.test:update()
end
function scenes.test:complete()
	if self.completed == false then
		self.completed = true
		exit = GameObject.create()
		exit.name = "exit"
		exit.sprite = love.graphics.newImage("sprites/exit.png")
		exit.sprite:setFilter( "nearest", "nearest")
		
		exit.position.x = 70
		exit.position.y = 0

		exit.physics.enabled = true
		exit.physics.type = "trigger"
		exit.physics.trigger = "loadlevel"
		exit.physics.triggerval = "test"
		exit.physics.width = 16
		exit.physics.height = 16

		exit.physics.enabled = true
		exit.physics.type = "trigger"
		exit.physics.trigger = "loadlevel"
		exit.physics.triggerval = "test"
		table.insert(gs.entities, exit)
		world:add(exit, exit.position.x, exit.position.y, 16, 16)

		self.chest.physics.enabled = false
		self.chest.opened = true
		world:remove(self.chest)
		if gs.difficulty == 1 then
			self.chest:giveSpell("ice")
			gs.player.spellIndex = 2
		elseif gs.difficulty == 2 then
			self.chest:giveSpell("arrow")
			gs.player.spellIndex = 3
		elseif gs.difficulty == 3 then
			self.chest:giveSpell("heart")
			gs.player.spellIndex = 4
		end

		for i=1,math.min(2*gs.difficulty, 10) do
			coin = Coin.create()
			tempx = math.random(24, winx-24)
			tempy = math.random(24, winy-24)
			x, y = math.normalize(tempx-self.chest.position.x, tempy-self.chest.position.y)
			coin.position.x = self.chest.position.x
			coin.position.y = self.chest.position.y
			coin.physics.velocity.x = x/4
			coin.physics.velocity.y = y/4
			coin.width = 8
			coin.height = 8
			world:add(coin, coin.position.x, coin.position.y, coin.width, coin.height)
			table.insert(gs.entities, coin)
		end
	end

end