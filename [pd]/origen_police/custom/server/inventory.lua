Citizen.CreateThread(function ()
    while true do
        if Config.Inventory ~= "qb-inventory" and Config.Inventory ~= "origen_inventory" and Config.Inventory ~= "ls-inventory" then break end
        Wait(10000)
        local time = os.date("*t")

        if time.hour == 23 then
            MySQL.query('DELETE FROM stashitems WHERE stash LIKE "armas_policiales%"')
            print('SAPD - Armouty inventory deleted')
            break
        end
    end
    if GetResourceState("ox_inventory") ~= "started" then return end

    for mapIndex, _ in pairs(Tables.Markers) do
        exports.ox_inventory:RegisterStash('armas_policiales_'..mapIndex, Config.Translations['Equipment'], 100, 100*1000, true)
    end
    exports.ox_inventory:RegisterStash('OrigenPersonalStash', Config.Translations['Equipment'], 100, 100*1000, true)
end)

function LeaveTakePertenences(station, source)
    local Player = FW_GetPlayer(source)
    if Config.Inventory == "ox_inventory" or Config.Inventory == "qs-inventory" or Config.Inventory == "codem-inventory" or Config.Inventory == "new-qb-inventory" or Config.Inventory == "origen_inventory" then
        if Player.PlayerData.metadata["pertenencesSaved"] and type(Player.PlayerData.metadata["pertenencesSaved"]) == "table" then
            for k, v in pairs(Player.PlayerData.metadata["pertenencesSaved"]) do
                Player.Functions.AddItem(v.name, v.count, k, v.metadata)
            end
            Player.Functions.SetMetaData("pertenencesSaved", 0)
            TriggerClientEvent("origen_police:ShowNotification", source, Config.Translations.PertenencesPickUp)
        else
            if #Player.PlayerData.items == 0 then
                return
            end
            local itemsToSave = {}
            for _, v in pairs(Player.PlayerData.items) do
                if not v then return end
                itemsToSave[v.slot] = {
                    name = v.name,
                    count = Config.Inventory == "ox_inventory" and v.count or v.amount,
                    metadata = Config.Inventory == "ox_inventory" and v.metadata or v.info
                }
            end
            Player.Functions.SetMetaData("pertenencesSaved", itemsToSave)
            if Config.Inventory == "qs-inventory" then
                exports['qs-inventory']:ClearInventory(source)
            else
                Player.Functions.ClearInventory()
            end
            TriggerClientEvent("origen_police:ShowNotification", source, Config.Translations.LeavePertenences)
        end
        return
    end

    local stashID = (Config.Framework == "esx" and string.match(Player.PlayerData.citizenid, ":(.*)") or Player.PlayerData.citizenid) .. "_police_station_" .. station
    local stash = exports[Config.Inventory == "new-qb-inventory" and "qb-inventory" or Config.Inventory]:GetStashItems(stashID)
    local has = #stash > 0

    if has then
        Player.Functions.ClearInventory()
        for _, v in pairs(stash) do
            Player.Functions.AddItem(v.name, v.amount, v.slot, v.info)
        end
        TriggerEvent(Config.Inventory .. ":server:SaveStashItems", stashID, {})
        TriggerClientEvent("origen_police:ShowNotification", source, Config.Translations.PertenencesPickUp)
    else
        local playerItems = Player.PlayerData.items
        TriggerEvent(Config.Inventory .. ":server:SaveStashItems", stashID, playerItems)
        Player.Functions.ClearInventory()
        TriggerClientEvent("origen_police:ShowNotification", source, Config.Translations.LeavePertenences)
    end
end

function GetTrunkItems(plate)
    if Config.Inventory == "qs-inventory" then
        local data = MySQL.awaitQuery("SELECT items FROM inventory_trunk WHERE plate = ? LIMIT 1", {plate})
        if data[1] == nil then return nil end
        local result = json.decode(data[1].items)
        result = {
            items = result,
        }
        return result
    elseif Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:GetInventoryItems('trunk'..plate)
    elseif Config.Inventory == "codem-inventory" then
        local data = MySQL.awaitQuery("SELECT trunk FROM codem_new_vehicleandglovebox WHERE plate = ?", {plate})

        if data[1] == nil then return nil end
        local result = json.decode(data[1].trunk)
        result = {
            items = result,
        }
        return result
    elseif Config.Inventory == "origen_inventory" then
        return exports["origen_inventory"]:GetInventory('trunk', 'trunk_'..plate)
    end

    return exports[Config.Inventory == "new-qb-inventory" and "qb-inventory" or Config.Inventory]:GetTrunk(plate)
end

function GetGloveboxItems(plate)
    if Config.Inventory == "qs-inventory" then
        local data = MySQL.awaitQuery("SELECT items FROM inventory_glovebox WHERE plate = ? LIMIT 1", {plate})
        if data[1] == nil then return nil end
        local result = json.decode(data[1].items)
        result = {
            items = result,
        }
        return result
    elseif Config.Inventory == "ox_inventory" then
        return exports['ox_inventory']:GetInventoryItems('glove'..plate)
    elseif Config.Inventory == "codem-inventory" then
        local data = MySQL.awaitQuery("SELECT glovebox FROM codem_new_vehicleandglovebox WHERE plate = ?", {plate})

        if data[1] == nil then return nil end
        local result = json.decode(data[1].glovebox)
        result = {
            items = result,
        }
        return result
    elseif Config.Inventory == "origen_inventory" then
        return exports["origen_inventory"]:GetInventory('glovebox', 'glove_'..plate)
    end

    return exports[Config.Inventory == "new-qb-inventory" and "qb-inventory" or Config.Inventory]:GetGlovebox(plate)
end

function RemoveItem(xPlayer, name, amount, slot)
    if Config.Inventory == "origen_inventory" then
        return exports.origen_inventory:RemoveItem(xPlayer.source, name, amount)
    elseif Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:RemoveItem(xPlayer.source, name, amount, nil, slot)
    end
    return xPlayer.removeInventoryItem(name, amount, slot)
end

function GetItemFromSlot(xPlayer, slot)
    if Config.Inventory == "origen_inventory" then
        return exports.origen_inventory:GetItemBySlot(xPlayer.source, slot)
    elseif Config.Inventory == "core_inventory" then
        return exports['core_inventory']:getInventory('primary-' .. (Config.Framework == "esx" and xPlayer.citizenid:gsub(':','') or xPlayer.citizenid))[1]
    end
    for _, v in pairs(xPlayer.items) do
        if v.slot == slot then
            return v
        end
    end
end

local ArmouryRegistered = false

FW_CreateCallback("origen_police:server:OpenPoliceArmoury", function(source, cb, data)
    if not CanOpenTablet(source)[2] then -- Don't allow to open the stash if the player don't have a valid job(config/permissions.lua)
        return cb(false)
    end
    local id = "origen_police_armoury"
    if Config.Inventory == "core_inventory" then
        exports['core_inventory']:clearInventory(id)

        for _, v in pairs(Config.Armory.items) do
            exports['core_inventory']:addItem(id, v.name, tonumber(v.amount), nil, 'big_storage')
        end
        exports['core_inventory']:openInventory(source, id, 'big_storage', nil, nil, true, nil)
    elseif Config.Inventory == "ox_inventory" then
        for _, v in pairs(Config.Armory.items) do 
            v.metadata = {}
            v.metadata.serial = v.info.serie
            v.metadata.components = {}
            if v.info and v.info.attachments then
                for z, u in pairs(v.info.attachments) do 
                    v.metadata.components[z] = u.component:lower()
                end
            end
        end
        local allowedPolices = {}
        for _, v in pairs(Config.JobCategory) do
            for _, j in pairs(v) do 
                allowedPolices[j.name] = 0
            end
        end
        exports['ox_inventory']:RegisterShop('OrigenPoliceArmoury', {
            name = "Police Armoury",
            inventory = Config.Armory.items,
            groups = allowedPolices
        })
    elseif Config.Inventory == "tgiann-inventory" then
        exports["tgiann-inventory"]:RegisterShop(id, Config.Armory.items)
        exports["tgiann-inventory"]:OpenShop(source, id)
    elseif Config.Inventory == "new-qb-inventory" then
        if not ArmouryRegistered then
            ArmouryRegistered = true
            exports["qb-inventory"]:CreateShop({
                name = id,
                label = "Origen Police Armoury",
                coords = GetEntityCoords(GetPlayerPed(source)),
                items = Config.Armory.items
            })
        end
        exports["qb-inventory"]:OpenShop(source, id)
    else
        print("No supported inventory found for armoury")
    end
    cb(true)
end)

FW_CreateCallback("origen_police:server:OpenPoliceStash", function(source, cb, id, label, slots, weight, private)
    if not CanOpenTablet(source)[2] then -- Don't allow to open the stash if the player don't have a valid job(config/permissions.lua)
        return cb(false)
    end
    local coords = GetEntityCoords(GetPlayerPed(source))
    if Config.Inventory == "ox_inventory" then
        if exports.ox_inventory:GetInventory(id) then
            return cb(true)
        end
        exports.ox_inventory:RegisterStash(id, label, slots, weight, private and true or nil)
    elseif Config.Inventory == "origen_inventory" then
        exports.origen_inventory:RegisterStash(id, label, slots, weight)
        exports.origen_inventory:OpenInventory(source, 'stash', id)
    elseif Config.Inventory == "new-qb-inventory" then
        exports['qb-inventory']:OpenInventory(source, id, {
            label = label,
            maxweight = weight,
            slots = slots
        })
    elseif Config.Inventory == "core_inventory" then
        exports['core_inventory']:openInventory(source, id, 'big_storage', nil, nil, true, nil)
    elseif Config.Inventory == "tgiann-inventory" then
        exports["tgiann-inventory"]:RegisterStash(id, label, slots, weight, false, false, coords, {}, {})
        TriggerClientEvent("origen_police:client:tgiann:OpenStash", source, id)
    else
        print("No supported inventory found for stashes")
        return cb(false)
    end
    cb(true)
end)

RegisterNetEvent("origen_police:server:OpenOtherPlayerInv", function(targetId)
    local src = source
    if not CanOpenTablet(source)[2] then -- Don't allow to open the stash if the player don't have a valid job(config/permissions.lua)
        return
    end
    if Config.Inventory == 'new-qb-inventory' then
        exports['qb-inventory']:OpenInventoryById(src, targetId)
    elseif Config.Inventory == 'tgiann-inventory' then
        exports["tgiann-inventory"]:OpenInventoryById(src, targetId)
    else
        print("No supported inventory found for open other player inventory")
    end
end)

-- OTHER INTEGRATIONS

if Config.Inventory == 'codem-inventory' then
    RegisterServerEvent('origen_police:server:SetInventoryRobStatus')
    AddEventHandler('origen_police:server:SetInventoryRobStatus', function(playerId, val)
        TriggerClientEvent('codem-inventory:client:robstatus', playerId, val)
    end)
end