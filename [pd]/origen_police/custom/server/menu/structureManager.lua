local cachedData = {}

local function GetStructureField(data)
    if type(data) == "table" then
        return data[Config.Framework]
    end
    return data
end

function GetDataFromStructure(structure, shouldCache, cacheTime, cacheIndex, citizenid, defaultValue)
    defaultValue = defaultValue or {}
    cachedData[cacheIndex] = cachedData[cacheIndex] or {}
    local status, data, fromCache = pcall(function()
        if  shouldCache and
            cachedData[cacheIndex][citizenid] and
            os.time() - cachedData[cacheIndex][citizenid].time < (cacheTime or 300)
        then
            return cachedData[cacheIndex][citizenid].data, true
        end

        if structure.func then
            return data.func(citizenid), false
        end

        if structure.customQuery then
            return MySQL.awaitQuery(structure.customQuery, {
                citizenid
            }), false
        end

        return MySQL.awaitQuery("SELECT "..structure.label.." AS data FROM "..structure.table.." WHERE "..structure.identifier.." = ?", {
            citizenid
        }), false
    end)

    if not status then 
        print("Something went wrong while fetching data from structure: " .. data)
        return defaultValue
    end

    if shouldCache and not fromCache then 
        cachedData[cacheIndex][citizenid] = {time = os.time(), data = data}
    end
    
    if structure.decoder then
        return structure.decoder(data) or defaultValue
    end

    local result = {}
    for _, v in pairs(data) do
        table.insert(result, v.data)
    end
    return result or defaultValue
end

function ParseScriptStructure(data, script, cacheIndex)
    local parsedStructure = {}

    if script == "default" then
        parsedStructure = data["default"][Config.Framework] or {}
    elseif type(data[script]) == "string" then
        parsedStructure = data[data[script]] or {}
    else
        parsedStructure = data[script] or {}
    end

    for k, v in pairs(parsedStructure) do 
        parsedStructure[k] = GetStructureField(v)
    end
    
    return parsedStructure
end