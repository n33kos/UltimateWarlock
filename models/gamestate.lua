GameState = {}
GameState.__index = GameState

function GameState.create()
	local gstate = {}
	setmetatable(gstate,GameState)

	gstate.title = "Ultimate Warlock"
	gstate.version = "0.1.0"
	gstate.author = "Nicholas Suski"
	
	gstate.difficulty = 0
	gstate.level = {}
	gstate.entities = {}
	gstate.projectiles = {}
	gstate.stats = {}
		gstate.stats[1] = {}
			gstate.stats[1].title = "Kills"
			gstate.stats[1].value = 0
		gstate.stats[2] = {}
			gstate.stats[2].title = "Coins"
			gstate.stats[2].value = 0
	return gstate
end