GameObject = {}
GameObject.__index = GameObject

function GameObject.create()
   local gameobj = {}
   setmetatable(gameobj,GameObject)
   
	gameobj.position = {}	
		gameobj.position.x = 0
		gameobj.position.y = 0
	gameobj.width = 16
	gameobj.height = 16
	gameobj.scale = {}
		gameobj.scale.x = 1
		gameobj.scale.y = 1
	gameobj.offset = {}
		gameobj.offset.x = 0
		gameobj.offset.y = 0
	gameobj.rotation = math.rad(0)
	gameobj.sprite = nil
	gameobj.physics = {}
		gameobj.physics.enabled = false
		gameobj.physics.type = "static"
		gameobj.physics.mass = 10
		gameobj.physics.drag = 1
		gameobj.physics.velocity = {}
			gameobj.physics.velocity.x = 0
			gameobj.physics.velocity.y = 0
	gameobj.tags = {}

	return gameobj
end

function GameObject:load()
	if self.physics.enabled == true then
		world:add(self, self.position.x, self.position.y, self.width, self.height)
	end
end

function GameObject:update()
	if self.physics.enabled == true then
		physics(self)
	end
end

function GameObject:draw()
	if self.sprite then
		love.graphics.draw(self.sprite, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
	elseif self.spritesheet and self.animations then
		spriteindex = self.animations[self.animation][math.ceil(love.timer.getTime()*10 % table.getn(self.animations[self.animation]))]
		quad = love.graphics.newQuad(16*(spriteindex-1), 0, 16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
		love.graphics.draw(self.spritesheet, quad, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.offset.x, self.offset.y)
	end
end

function GameObject:addTag(tag)
	table.insert(self.tags, tag)
end

function GameObject:removeTag(tag)
	for key,selftag in self.tag do
		if selftag == tag then
			table.remove(self.tags, key)
		end
	end
end

function GameObject:onCollide(col)
end