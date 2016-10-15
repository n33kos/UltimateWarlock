function conjurSpell(self, spell, dir)
	if spell == "heart" then
		castHeart(self, dir)
	elseif spell == "flame" then
		castFlameBolt(self, dir)
	elseif spell == "ice" then
		castIceBolt(self, dir)
	elseif spell == "arrow" then
		castArrow(self, dir)
	end
end

function setSpellPosition(self, spell, dir)
	local x,y = 0,0
	if dir.x < 0 then
		--"right"
		x = self.position.x+self.width
	elseif dir.x > 0 then
		--"left"
		x = self.position.x-spell.width
	else
		x = self.position.x
	end
	if dir.y > 0 then
		--"up"
		y = self.position.y-spell.height
	elseif dir.y < 0 then
		--"down"
		y = self.position.y+self.height
	else
		y = self.position.y
	end
	return x,y
end

--------------------SPELLS-------------------
---------------------------------------------
spellbook = {
	"heart",
	"flame",
	"ice",
	"arrow"
}
function castHeart(self, dir)
	spell = Spell.create()

	spell.owner = self
	spell.name = "heart"
	spell.speed = 0.25
	spell.damage = 1
	spell.physics.velocity.x = -dir.x*spell.speed
	spell.physics.velocity.y = -dir.y*spell.speed
	spell.physics.drag = 0.01

	spell.sprite = love.graphics.newImage("sprites/heart.png")
	spell.sprite:setFilter( "nearest", "nearest")

	spell.width = 9
	spell.height = 7
	spell.offset.x = -spell.width/2
	spell.offset.y = -spell.height/2

	spell.position.x, spell.position.y = setSpellPosition(self, spell, dir)

	spell:load()
	table.insert(gs.entities, spell)
end

function castFlameBolt(self, dir)
	spell = Spell.create()

	spell.owner = self
	spell.name = "flame"

	spell.speed = 2
	spell.damage = 1
	spell.physics.velocity.x = -dir.x*spell.speed
	spell.physics.velocity.y = -dir.y*spell.speed

	spell.spritesheet = love.graphics.newImage("sprites/flamebolt-sheet.png")
	spell.spritesheet:setFilter( "nearest", "nearest")

	-- if dir.x ~= 0 then
	-- 	spell.rotation = math.rad(90)
	-- end
	-- if dir.x < 0 then
	-- 	spell.scale.y = -1
	-- end
	-- if dir.y > 0 then
	-- 	spell.scale.y = -1
	-- end

	spell.animation = "fly"
	spell.animations = {}
	spell.animations.fly = {1,2}

	spell.width = 8
	spell.height = 8
	spell.offset.x = -spell.width/2
	spell.offset.y = -spell.height/2

	spell.position.x, spell.position.y = setSpellPosition(self, spell, dir)

	spell:load()
	table.insert(gs.entities, spell)
end

function castIceBolt(self, dir)
	spell = Spell.create()

	spell.owner = self
	spell.name = "ice"

	spell.speed = 1
	spell.damage = 1
	spell.physics.velocity.x = -dir.x*spell.speed
	spell.physics.velocity.y = -dir.y*spell.speed

	spell.spritesheet = love.graphics.newImage("sprites/ice-sheet.png")
	spell.spritesheet:setFilter( "nearest", "nearest")

	spell.animation = "fly"
	spell.animations = {}
	spell.animations.fly = {1,1,2,2}

	spell.width = 8
	spell.height = 8
	spell.offset.x = -spell.width/2
	spell.offset.y = -spell.height/2

	spell.position.x, spell.position.y = setSpellPosition(self, spell, dir)

	spell:load()
	table.insert(gs.entities, spell)
end

function castArrow(self, dir)
	spell = Spell.create()

	spell.owner = self
	spell.name = "arrow"

	spell.speed = 3
	spell.damage = 2
	spell.physics.velocity.x = -dir.x*spell.speed
	spell.physics.velocity.y = -dir.y*spell.speed

	spell.spritesheet = love.graphics.newImage("sprites/arrow-sheet.png")
	spell.spritesheet:setFilter( "nearest", "nearest")

	spell.animation = "fly"
	spell.animations = {}
	spell.animations.fly = {1,1,2,2}

	spell.width = 8
	spell.height = 8
	spell.offset.x = -spell.width/2
	spell.offset.y = -spell.height/2

	spell.position.x, spell.position.y = setSpellPosition(self, spell, dir)

	spell:load()
	table.insert(gs.entities, spell)
end