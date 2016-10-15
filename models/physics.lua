function applyForce(entity)
	--apply force
	entity.position.x = entity.position.x + entity.physics.velocity.x/entity.physics.mass
	entity.position.y = entity.position.y + entity.physics.velocity.y/entity.physics.mass
end

function applyDrag(entity)
	--drag velocity
	entity.physics.velocity.x = entity.physics.velocity.x - entity.physics.velocity.x*entity.physics.drag
	entity.physics.velocity.y = entity.physics.velocity.y - entity.physics.velocity.y*entity.physics.drag
end

function math.normalize(x,y)
	length = math.sqrt(x * x + y * y);
	x = x/length;
	y = y/length;
	return x,y
end

function physics(entity, collisionFilter)
	applyForce(entity)
	applyDrag(entity)

	len = 0
	if entity.physics.type == "trigger" then
		--update without using collision resolution so shifty
		world:update(entity, entity.position.x, entity.position.y, entity.position.width, entity.position.height)
	elseif entity.physics.type == "static" then
		--Just sit there being solid like a coolguy
	elseif entity.physics.type == "dynamic" then
		--update with collision resolution like a boss
		actualx, actualy, cols, len = world:move(entity, entity.position.x, entity.position.y, collisionFilter)
		entity.position.x = actualx
		entity.position.y = actualy
	end

	for i=1,len do
		entity:onCollide(cols[i].other)
	end
end
