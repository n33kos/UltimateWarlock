Coin = {}
Coin.__index = Coin

function Coin.create()
	local cn = GameObject.create()
	setmetatable(cn,Coin)

	cn.name = "Coin"
	cn.damage = 0
	cn.speed = 2
	cn.tag = "spell"

	cn.spritesheet = love.graphics.newImage("sprites/coin-sheet.png")
	cn.spritesheet:setFilter( "nearest", "nearest")
	cn.animation = "spin"
	cn.animations = {}
		cn.animations.spin = {1,2,3,4}

	cn.physics.enabled = true
	cn.physics.mass = 1
	cn.physics.drag = 0.01
	cn.physics.type = "dynamic"
	cn.physics.collisionFilter = function(item, other)
		return 'cross'
	end

	return cn
end


function Coin:load()
	if self.physics.enabled == true then
		world:add(self, self.position.x-(self.width/2), self.position.y-(self.height/2), self.width, self.height)
	end
end

function Coin:update()
	if self.physics.enabled == true then
		physics(self, self.physics.collisionFilter)
	end
end

function Coin:draw()
	if self.sprite then
		love.graphics.draw(self.sprite, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
	elseif self.spritesheet and self.animations then
		spriteindex = self.animations[self.animation][math.ceil(love.timer.getTime()*10 % table.getn(self.animations[self.animation]))]
		quad = love.graphics.newQuad(self.width*(spriteindex-1), 0, self.width, self.height, self.spritesheet:getWidth(), self.spritesheet:getHeight())
		love.graphics.draw(self.spritesheet, quad, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
	end
end

function Coin:onCollide(col)
	if col.name == "player" then
		gs.stats[2].value = gs.stats[2].value + 1
		self.destroyFlag = true
	end
end

