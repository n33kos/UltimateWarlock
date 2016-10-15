scenes.title = Level.create()

titlefont = love.graphics.newFont("fonts/pixelfont.ttf", 6)
titlefont:setFilter( "nearest", "nearest")
love.graphics.setFont(titlefont)
function scenes.title:load()

	--create world boundaries
	drawWalls()	

	--Load backround Sprites
	titleimg = GameObject.create()
	titleimg.name = "titleimg"
	titleimg.sprite = love.graphics.newImage("sprites/titleimg.png")
	titleimg.sprite:setFilter( "nearest", "nearest")
	titleimg.position.x = 0
	titleimg.position.y = 32
	table.insert(gs.entities, titleimg)

	buttonx = GameObject.create()
	buttonx.name = "buttonx"
	buttonx.sprite = love.graphics.newImage("sprites/button_x.png")
	buttonx.sprite:setFilter( "nearest", "nearest")
	buttonx.position.x = 88
	buttonx.position.y = 90
	table.insert(gs.entities, buttonx)

	buttonz = GameObject.create()
	buttonz.name = "buttonz"
	buttonz.sprite = love.graphics.newImage("sprites/button_z.png")
	buttonz.sprite:setFilter( "nearest", "nearest")
	buttonz.position.x = 38
	buttonz.position.y = 90
	table.insert(gs.entities, buttonz)
end
function scenes.title:update()
	if love.keyboard.isDown('z','x') then
		unloadScene()
		loadScene("intro")
	end
end
function scenes.title:draw()
	love.graphics.setColor(15, 56, 15)
	love.graphics.setFont(scorefont)
	love.graphics.print("or", 70, 94)
	love.graphics.setColor(255,255,255)
end