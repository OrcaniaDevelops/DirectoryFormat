
--Scripted by OrcaniaDevelops
-- Created 7/13/25
-- Last Updated 7/14/25

local RNGFunctions = {}


--[[

How this works:

Takes weight values and returns them as should.


 Example:

    local objects = {
		workspace.Basic,
		workspace.Rare,
		workspace.Legendary
	}

	local rarities = {
		["Basic"] = 70,
		["Rare"] = 25,
		["Legendary"] = 5
	}
	
	local RNGFunctions = require(location.ScriptName) - type example game.ReplicatedStorage.Directory.RNGFunctions
	
	local newChoice = RNGFunctions:ChooseRandom(objects, rarities)
	print(newChoice)
		
		

--]]

function RNGFunctions:ChooseRandom(objects: table, rarities: table)

    local randomNum = math.random(1,100)
    local count = 0
	
	for rarity, weight in rarities do

		counter += weight

		if randomNum <= counter then
			return objects[rarity]
        end

	end)

end)

return RNGFunctions


