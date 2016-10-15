--Requires--
require "models/gamestate"
require "models/gameobject"
require "models/physics"
bump = require 'models/bump'
require "models/level"
require "models/gui"
require "models/player"
require "models/witch"
require "models/spell"
require "models/chest"
require "models/coin"
require "models/magic"
require "models/debug"
require "models/scene"

require "scenes/test"
require "scenes/title"
require "scenes/intro"
require "scenes/score"

--Global Vars--
winx = 160
winy = 144
winscale = 4
colors = {
	{15, 56, 15},
	{48, 98, 48},
	{139, 172, 15},
	{155, 188, 15}
}
gs = GameState.create()
gs.level = Level.create()
world = bump.newWorld(16)


--Love Functions--
function love.load()
	-- set window title
	love.window.setTitle( "Ultimate Warlock v." .. gs.version )
	--set background color
	love.graphics.setBackgroundColor( colors[4] )
	--set resolution based on scaling
	love.window.setMode(winx*winscale, winy*winscale)
	
	-- Load Scene
	loadScene("title")

	-- set random seed 
	love.math.setRandomSeed( os.clock() )

	--run entity load functions
	for i=1,table.getn(gs.entities) do
		gs.entities[i]:load()
	end

	gs.bgmusic = love.audio.newSource("bg_music.mp3", "static")
	gs.bgmusic:setLooping(true)
	gs.bgmusic:play()

end
 
function love.update(dt)
	gs.level:update()
	--run entity update functions
	local destroys = {}
	local enemycount = 0
	for i=1,table.getn(gs.entities) do
		gs.entities[i]:update()
		if gs.entities[i].destroyFlag then table.insert(destroys, i) end
		if gs.entities[i].name == "enemy" then
			enemycount = enemycount+1
		end
	end
	if gs.level and enemycount <=0 then
		gs.level:complete()
	end
	
	if gs.player then gs.player:update() end
	
	--destroy entities
	for i=1,table.getn(destroys) do
		if world:hasItem(gs.entities[destroys[i]]) then
			world:remove(gs.entities[destroys[i]])
		end
		table.remove(gs.entities, destroys[i])
	end
	

end
 
function love.draw()
	--set grid scaling
	love.graphics.scale(winscale,winscale)

	gs.level:draw()
	--Run entity draw functions
	for i=1,table.getn(gs.entities) do
		gs.entities[i]:draw()
	end
	if gs.player then gs.player:draw() end


	draw_gui()
	--debug()
end