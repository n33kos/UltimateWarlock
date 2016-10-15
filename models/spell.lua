Spell = {}
Spell.__index = Spell

function Spell.create()
	local spll = GameObject.create()
	setmetatable(spll,Spell)

	spll.name = "spell"
	spll.damage = 1
	spll.speed = 2
	spll.tag = "spell"

	spll.physics.enabled = true
	spll.physics.mass = 1
	spll.physics.drag = 0.01
	spll.physics.type = "dynamic"
	spll.physics.collisionFilter = function(item, other)
		return 'cross'
	end

	return spll
end


function Spell:load()
	if self.physics.enabled == true then
		world:add(self, self.position.x-(self.width/2), self.position.y-(self.height/2), self.width, self.height)
	end
end

function Spell:update()
	if self.physics.enabled == true then
		physics(self, self.physics.collisionFilter)
	end
end

function Spell:draw()
	if self.sprite then
		love.graphics.draw(self.sprite, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
	elseif self.spritesheet and self.animations then
		spriteindex = self.animations[self.animation][math.ceil(love.timer.getTime()*10 % table.getn(self.animations[self.animation]))]
		quad = love.graphics.newQuad(self.width*(spriteindex-1), 0, self.width, self.height, self.spritesheet:getWidth(), self.spritesheet:getHeight())
		love.graphics.draw(self.spritesheet, quad, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
	end
end

function Spell:onCollide(col)
	if self.owner ~= col and self.owner ~= col.owner then
		self:spellHitEffects(col)
		self.destroyFlag = true
	end
end

function Spell:spellHitEffects(col)
	if col and col.hp then
		col.hp = col.hp - self.damage
	end
	if col and col.speed and self.name == "ice" then
		col.speed = col.speed*2
	end
end
