Chest = {}
Chest.__index = Chest

function Chest.create()
	local chst = GameObject.create()
	setmetatable(chst,Chest)

	chst.name = "Chest"
	chst.physics.enabled = true
	chst.physics.mass = 10
	chst.physics.drag = 0.01
	chst.physics.type = "dynamic"
	chst.physics.trigger = "learnspell"
	chst.opened = false
	chst.sprite = {}
	chst.sprite.open = love.graphics.newImage("sprites/chest_open.png")
	chst.sprite.open:setFilter( "nearest", "nearest")
	chst.sprite.closed = love.graphics.newImage("sprites/chest_closed.png")
	chst.sprite.closed:setFilter( "nearest", "nearest")

	chst.physics.collisionFilter = function(item, other)
		return 'cross'
	end

	return chst
end


function Chest:load()
	if self.physics.enabled == true then
		world:add(self, self.position.x-(self.width/2), self.position.y-(self.height/2), self.width, self.height)
	end
end

function Chest:update()
	if self.physics.enabled == true then
		physics(self, self.physics.collisionFilter)
	end
end

function Chest:draw()
	if self.sprite then
		if self.opened then
			love.graphics.draw(self.sprite.open, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
		else
			love.graphics.draw(self.sprite.closed, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
		end
	end
end

function Chest:onCollide(col)
end

function Chest:giveSpell(spell)
	table.insert(gs.player.spells, spell)
	-- for i=1,table.getn(spellbook) do
	-- 	local hasSpell = false
	-- 	for j=1,table.getn(gs.player.spells) do
	-- 		if spellbook[i].name == gs.player.spells[j] then
	-- 			hasSpell = true
	-- 		end
	-- 	end
	-- 	if hasSpell == false then
	-- 		table.insert(gs.player.spells, spell)
	-- 		break
	-- 	end
	-- end
end