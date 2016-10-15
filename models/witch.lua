Witch = {}
Witch.__index = Witch

function Witch.create()
   local wtch = GameObject.create()
   setmetatable(wtch,Witch)

    wtch.name = "enemy"
	wtch.hp = 2
	wtch.maxhp = hp
	wtch.spell = "flame"
	wtch.position.x = math.random(8, winx-16)
	wtch.position.y = math.random(8, winy/2-16)
	wtch.width = 8
	wtch.speed = math.random(50, 64)
	
	wtch.spritesheet = love.graphics.newImage("sprites/witch-sheet.png")
	wtch.spritesheet:setFilter( "nearest", "nearest")
	
	wtch.animation = "left"
	wtch.animations = {}
		wtch.animations.right = {3,3,4,4}
		wtch.animations.left = {1,1,2,2}

	wtch.conjurSpeed = math.random(math.min(400/gs.difficulty, 200),500)
	wtch.conjurTimer = math.random(0, wtch.conjurSpeed)

	wtch.physics.enabled = true
	wtch.physics.type = "dynamic"
	wtch.physics.mass = 5
	wtch.physics.drag = 0.2
	wtch.physics.target = {}
		wtch.physics.target.position = {}
			wtch.physics.target.position.x = 0
			wtch.physics.target.position.y = 0
	wtch.physics.collisionFilter = function(item, other)
		if other.name == "spell" then
			return 'cross'
		else
			return 'slide'
		end
	end

	return wtch
end

function Witch:load()
	if self.physics.enabled == true then
		world:add(self, self.position.x, self.position.y, self.width, self.height)
	end	
end

function Witch:update()
	if self.physics.target then
		xdist = self.physics.target.position.x-self.position.x
		ydist = self.physics.target.position.y-self.position.y

		--move to target
		self.physics.velocity.x = (xdist)/self.speed + math.random(-0.05,0.05)
		self.physics.velocity.y = (ydist)/self.speed + math.random(-0.05,0.05)

		if xdist > 0 then
			self.animation = "right"
		else
			self.animation = "left"
		end

		--shoot at target
		self.conjurTimer = math.max(0, self.conjurTimer - 1)
		if self.conjurTimer < 1 then
			self.conjurTimer = self.conjurSpeed
			xnorm, ynorm = math.normalize(xdist,ydist)
			conjurSpell(self, self.spell, { x=-xnorm, y=-ynorm })
		end
	end
	if self.physics.enabled == true then
		physics(self, self.physics.collisionFilter)
	end
	if self.position.x < 7 or self.position.x > winx-7 or self.position.y < 7 or self.position.y > winy-7 then
		self.hp = 0
	end
	if self.hp <= 0 then
		self.destroyFlag = true
		gs.stats[1].value = gs.stats[1].value+1
	end
end

function Witch:draw()
	spriteindex = self.animations[self.animation][math.ceil(love.timer.getTime()*10 % table.getn(self.animations[self.animation]))]
	quad = love.graphics.newQuad(16*(spriteindex-1), 0, 16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
	love.graphics.draw(self.spritesheet, quad, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, 0, 0)
end

function Witch:onCollide(col)
end