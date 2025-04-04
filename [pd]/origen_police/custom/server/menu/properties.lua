local ApartmentStructure = {
    ["qs-housing"] = {
        table = "player_houses",
        label = "house",
        identifier = "owner"
    },
    ["origen_housing"] = {
        func = function(citizenid)
            local houses = exports.origen_housing:getOwnedHouses(citizenid)
            local result = {}
            if houses then
                for _, houseID in pairs(houses) do
                    local house = exports['origen_housing']:getHouse(houseID)
                    if type(house) == 'table' then
                        table.insert(result, { label = house.name })
                    end
                end
            end
            return result
        end
    },
    ["esx_property"] = {
        func = function(citizenid)
            local houses = exports['esx_property']:GetPlayerProperties(citizenid)
            local result = {}
            if houses then
                for _, house in pairs(houses) do
                    table.insert(result, { label = prop.Name or prop.label })
                end
            end
            return result
        end
    },
    ["default"] = {
        ["qbcore"] = {
            table = "apartments",
            label = "label",
            identifier = "citizenid"
        },
        ["esx"] = {
            table = "users",
            label = "last_property",
            identifier = "identifier"
        }
    }
}

-- DON'T TOUCH ANYTHING BELOW THIS LINE UNLESS YOU KNOW WHAT YOU'RE DOING
-- NO SUPPORT WILL BE PROVIDED FOR CHANGES MADE BELOW THIS LINE

ApartmentStructure = ParseScriptStructure(ApartmentStructure, Config.HousingSystem, 1)

function GetCitizenProperties(citizenid)
    return GetDataFromStructure(ApartmentStructure, true, 300, 1, citizenid, {})
end