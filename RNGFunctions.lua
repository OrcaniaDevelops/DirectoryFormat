
local RNGFunctions = {}

function RNGFunctions:ChooseRandomPart(objects: table, rarities: table)

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


