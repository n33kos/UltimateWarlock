scenes.score = Level.create()
scorefont = love.graphics.newFont("fonts/pixelfont.ttf", 10)
scorefont:setFilter( "nearest", "nearest")
scorefontsmall = love.graphics.newFont("fonts/pixelfont.ttf", 8)
scorefontsmall:setFilter( "nearest", "nearest")
love.graphics.setFont(scorefont)

function scenes.score:load()
	--create world boundaries
	self.clickmax = 100
	self.clicktimer = self.clickmax
	drawWalls()	
end
function scenes.score:update()
	self.clicktimer = math.max(self.clicktimer-1,0)
	if love.keyboard.isDown('z','x') then
		if self.clicktimer <= 0 then
			self.clicktimer = self.clickmax
			gs.player = nil
			gs.difficulty = 0
			gs.stats[1].value = 0
			gs.stats[2].value = 0
			unloadScene()
			loadScene("intro")
		end
	end
end
function scenes.score:draw()
	love.graphics.setColor(15, 56, 15)
	
	love.graphics.setFont(scorefont)
	love.graphics.print("GAME OVER", 26, 26)
	love.graphics.setFont(scorefontsmall)
	love.graphics.print("Level: "..gs.difficulty, 26, 60)
	for i=1,table.getn(gs.stats) do
		love.graphics.print(gs.stats[i].title..": "..gs.stats[i].value, 26, 60+i*15)
	end
	
	love.graphics.setColor(255,255,255)
end