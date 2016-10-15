Player = {}
Player.__index = Player

function Player.create()
	local plyr = GameObject.create()
	setmetatable(plyr,Player)
	
	plyr.name = "player"
	plyr.position.x = winx/2
	plyr.position.y = winy/2
	plyr.maxhp = 6
	plyr.hp = 6
	plyr.width = 10
	plyr.height = 16
	
	plyr.spritesheet = love.graphics.newImage("sprites/warlock-sheet.png")
	plyr.spritesheet:setFilter( "nearest", "nearest")

	plyr.facing = {}
	plyr.facing.x = 0
	plyr.facing.y = 0
	plyr.animation = "idle"
	plyr.animations = {}
		plyr.animations.up = {1}
		plyr.animations.down = {4}
		plyr.animations.right = {7}
		plyr.animations.left = {10}
		plyr.animations.walkup = {2,2,3,3}
		plyr.animations.walkdown = {5,5,6,6}
		plyr.animations.walkright = {8,8,9,9}
		plyr.animations.walkleft = {11,11,12,12}

	plyr.physics.enabled = true
	plyr.physics.type = "dynamic"
	plyr.physics.mass = 1
	plyr.physics.drag = 1
	plyr.physics.collisionFilter = function(item, other)
		if other.tag == "spell" then
			return 'cross'
		else
			return 'slide'
		end
	end

	plyr.conjurTimer = 0
	plyr.conjurSpeed = 15

	plyr.spellIndex = 1
	plyr.spells = {"flame"}

	return plyr
end

function Player:load()
	if self.physics.enabled == true then
		world:add(self, self.position.x, self.position.y, self.width, self.height)
	end
end

function Player:update()
	
	if self.physics.type ~= "dynamic" then
		--reset collision type after teleport
		self.physics.type = "dynamic"
	end

	self.animation = "up"
	if self.facing.x < 0 then
		self.animation = "right"
	elseif self.facing.x > 0 then
		self.animation = "left"
	elseif self.facing.y > 0 then
		self.animation = "up"
	elseif self.facing.y < 0 then
		self.animation = "down"
	end

	if love.keyboard.isDown("up") then
		self.physics.velocity.y = self.physics.velocity.y-1;
		self.animation = "walkup"
		self.facing.y = 1
		self.facing.x = 0
	end
	if love.keyboard.isDown("down") then
		self.physics.velocity.y = self.physics.velocity.y+1;
		self.animation = "walkdown"
		self.facing.y = -1
		self.facing.x = 0
	end
	if love.keyboard.isDown("left") then
		self.physics.velocity.x = self.physics.velocity.x-1;
		self.animation = "walkleft"
		self.facing.y = 0
		self.facing.x = 1
	end
	if love.keyboard.isDown("right") then
		self.physics.velocity.x = self.physics.velocity.x+1;
		self.animation = "walkright"
		self.facing.y = 0
		self.facing.x = -1
	end

	self.conjurTimer = math.max(0, self.conjurTimer - 1)
	if love.keyboard.isDown("z") then
		if self.conjurTimer < 1 then
			self.conjurTimer = self.conjurSpeed
      		conjurSpell(self, self.spells[self.spellIndex], { x=self.facing.x, y=self.facing.y })
		end
	end
	if love.keyboard.isDown("x") then
		if self.conjurTimer < 1 then
			self.conjurTimer = self.conjurSpeed
			self.spellIndex = self.spellIndex+1
			if self.spellIndex > table.getn(self.spells) then self.spellIndex = 1 end
		end
	end

	if self.physics.enabled == true then
		physics(self, self.physics.collisionFilter)
	end

	if self.position.x < 0 or self.position.x > winx or self.position.y < 0 or self.position.y > winy then
		gs.player:teleport(winx/2,winy-17)
	end
end

function Player:draw()
	spriteindex = self.animations[self.animation][math.ceil(love.timer.getTime()*10 % table.getn(self.animations[self.animation]))]
	quad = love.graphics.newQuad(16*(spriteindex-1), 0, 16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
	love.graphics.draw(self.spritesheet, quad, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, 0, 0)
end

function Player:onCollide(col)
	if col.name == "enemy" then
		self.hp = self.hp - 1
	end

	if self.hp <=0 then
		gs.player = nil
		unloadScene()
		loadScene("score")
	end

	if col.tag == "spell" then
		if col.owner ~= self then
			self.hp = self.hp - col.damage
		else
			if col.name == "heart" then
				self.hp = self.hp + col.damage
				col.destroyFlag = true
				if self.hp > self.maxhp then self.hp = self.maxhp end
			end
		end
	end

	if col.name == "enemy" then
		self.physics.velocity.x = (self.position.x - col.position.x)/2
		self.physics.velocity.y = (self.position.y - col.position.y)/2
	end

	if col.physics and col.physics.type == "trigger" then
		if col.physics.trigger and col.physics.trigger == "loadlevel" then
			unloadScene()
			loadScene(col.physics.triggerval)
		end
	end
end

function Player:teleport(x,y)
	self.position.x = x
	self.position.y = y
	self.physics.velocity.x = 0
	self.physics.velocity.y = 0
	self.physics.type = "static"
end