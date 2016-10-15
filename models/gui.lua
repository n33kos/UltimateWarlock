heart = love.graphics.newImage("sprites/heart.png")
heart:setFilter( "nearest", "nearest")

heart_empty = love.graphics.newImage("sprites/heart_empty.png")
heart_empty:setFilter( "nearest", "nearest")

medallion = love.graphics.newImage("sprites/medallion.png")
medallion:setFilter( "nearest", "nearest")

flame = love.graphics.newImage("sprites/flamebolt1.png")
flame:setFilter( "nearest", "nearest")

ice = love.graphics.newImage("sprites/ice1.png")
ice:setFilter( "nearest", "nearest")

arrow = love.graphics.newImage("sprites/arrow1.png")
arrow:setFilter( "nearest", "nearest")

function draw_gui()
	if gs.player then
		for i=1,gs.player.maxhp do
			love.graphics.draw(heart_empty, math.floor(i*10)-8, 2, math.rad(0), 1, 1, 0, 0)
		end
		for i=1,gs.player.hp do
			love.graphics.draw(heart, math.floor(i*10)-8, 2, math.rad(0), 1, 1, 0, 0)
		end
		draw_spell()
	end
end 

function draw_spell()
	love.graphics.draw(medallion, winx-16, 0, math.rad(0), 1, 1, 0, 0)
	if gs.player.spells[gs.player.spellIndex] == "heart" then
		love.graphics.draw(heart, winx -10, 8, math.rad(0), 1, 1, 4, 4)
	elseif gs.player.spells[gs.player.spellIndex] == "flame" then
		love.graphics.draw(flame, winx -8, 8, math.rad(0), 1, 1, 3, 4)
	elseif gs.player.spells[gs.player.spellIndex] == "ice" then
		love.graphics.draw(ice, winx-9, 8, math.rad(0), 1, 1, 3, 4)
	elseif gs.player.spells[gs.player.spellIndex] == "arrow" then
		love.graphics.draw(arrow, winx-8, 8, math.rad(0), 1, 1, 3, 4)
	end
end