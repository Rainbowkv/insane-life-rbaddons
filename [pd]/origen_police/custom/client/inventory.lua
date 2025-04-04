function OpenStash(id, label, slots, weight, owner, private)
    if  Config.Inventory == "qb-inventory" or
        Config.Inventory == "qs-inventory" or
        Config.Inventory == "ls-inventory" or
        Config.Inventory == "codem-inventory"
    then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", id, {
            maxweight = weight,
            slots = slots,
            label = label
        })
        TriggerEvent("inventory:client:SetCurrentStash", id)
    else
        FW_TriggerCallback("origen_police:server:OpenPoliceStash", function(data)
            if not owner then
                local PlayerData = FW_GetPlayerData(false)
                owner = PlayerData.citizenid
            end
            if Config.Inventory == "ox_inventory" then
                exports.ox_inventory:openInventory('stash', {id=id, owner = owner})
            elseif Config.Inventory == "tgiann-inventory" then
                exports["tgiann-inventory"]:OpenInventory('stash', id, nil, nil)
            end
        end, id, label, slots, weight, private)
    end
end

function OpenArmoury()
    if  Config.Inventory == "qb-inventory" or
        Config.Inventory == "origen_inventory" or
        Config.Inventory == "qs-inventory" or
        Config.Inventory == "ls-inventory"
    then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Equipment", Config.Armory)
    elseif Config.Inventory == "codem-inventory" then
        TriggerEvent('codem-inventory:OpenPlayerShop', Config.Armory.items)
    else
        FW_TriggerCallback("origen_police:server:OpenPoliceArmoury", function(data)
            if Config.Inventory == "ox_inventory" then
                exports.ox_inventory:openInventory('shop', { type = 'OrigenPoliceArmoury', id = 1})
            end
        end)
    end
end

function OpenOtherPlayerInv(pID)
    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:openNearbyInventory()
    elseif  Config.Inventory == 'qb-inventory' or
            Config.Inventory == "origen_inventory" or
            Config.Inventory == 'qs-inventory'or
            Config.Inventory == "ls-inventory"
    then
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", pID)
    elseif Config.Inventory == 'codem-inventory' then
        TriggerEvent('codem-inventory:client:openplayerinventory', pID)
        local isClose = true
        CreateThread(function()
            while isClose do
                local targetPed = GetPlayerPed(GetPlayerFromServerId(pID))
                if not targetPed then isClose = false return end
                local targetCoords = GetEntityCoords(targetPed)
                local playerCoords = GetEntityCoords(PlayerPedId())
                if #(targetCoords - playerCoords) >= 4.0 then
                    TriggerServerEvent('origen_police:server:SetInventoryRobStatus', pID, false)
                    isClose = false
                end
                Wait(3)
            end
        end)
    elseif Config.Inventory == 'core_inventory' then
        TriggerServerEvent('core_inventory:server:openInventory', pID, 'otherplayer', nil, nil, false)
    else
        TriggerServerEvent("origen_police:server:OpenOtherPlayerInv", pID)
    end
end

local animsToSearch = {
    { dict = 'missminuteman_1ig_2', anim = 'handsup_base', flag = 3 },
    { dict = 'mp_arresting', anim = 'idle', flag = 3 },
    { dict = 'random@mugging3', anim = 'handsup_standing_base', flag = 3},
    { dict = 'combat@damage@writhe', anim = 'writhe_loop', flag = 3 },
    { dict = 'veh@low@front_ps@idle_duck', anim = 'sit', flag = 3 },
    { dict = 'move_injured_ground', anim = 'front_loop', flag = 3 },
    { dict = 'dead', anim = 'dead_a', flag = 3 },
}

function CanSearchPlayer(player)
    return true
end

function SearchClosestPlayer(playerId)
    local ped = PlayerPedId()
    if Config.Framework == "qbcore" then
        ProgressBar("search_player_inv", "Searching", 3000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@gangops@facility@servers@bodysearch@",
            anim = "player_search",
            flags = 49,
        }, {}, {}, function()
            StopAnimTask(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 1.0)
            OpenOtherPlayerInv(playerId)
            StartSearchDistance(playerId)
        end)
    elseif Config.Framework == "esx" then
        if GetResourceState("esx_progressbar") ~= "missing" then
            RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
            while not HasAnimDictLoaded("anim@gangops@facility@servers@bodysearch@") do
                Citizen.Wait(0)
            end
            TaskPlayAnim(ped, "anim@gangops@facility@servers@bodysearch@", "player_search", 8.0, 8.0, -1, 49, 0, 0, 0, 0)
            Citizen.CreateThread(function()
                Wait(3000)
                local _, _ = pcall(function()
                    exports["esx_progressbar"]:CancelProgressbar()
                end)
                OpenOtherPlayerInv(playerId)
                StartSearchDistance(playerId)
            end)
            ProgressBar("Searching", 3000, {
                FreezePlayer = false,
            })
        else
            Citizen.Wait(3000)
            OpenOtherPlayerInv(playerId)
            StartSearchDistance(playerId)
        end
    end
end

function GiveVehicleKeys(vehicle)
    -- Your code here
end

function GetPlayerItems(PlayerData)
    if Config.Inventory == "qs-inventory" then
        return exports['qs-inventory']:getUserInventory() or {}
    elseif Config.Inventory == "ls-inventory" then
        return exports["ls-inventory"]:GetPlayerItems() or {}
    elseif Config.Inventory == "origen_inventory" then
        return exports.origen_inventory:GetInventory() or {}
    elseif Config.Inventory == "ox_inventory" then
        return exports.ox_inventory:GetPlayerItems() or {}
    elseif Config.Inventory == "codem-inventory" then
        return exports["codem-inventory"]:GetClientPlayerInventory() or {}
    elseif Config.Inventory == 'core_inventory' then
        local inventory = -1
        FW_TriggerCallback("core_inventory:server:getInventory", function(data)
            inventory = data
        end)
        while inventory == -1 do
            Citizen.Wait(0)
        end
        return inventory or {}
    end

    if not PlayerData then
        PlayerData = FW_GetPlayerData()
    end
    return PlayerData.items or {}
end

function GetItemFromWeapon(PlayerData, weapon)
    if Config.Inventory == "core_inventory" then
        local data = exports["core_inventory"]:GetCurrentWeaponData()
        data.label = Config.WeaponsLabels[data.name] or "Unknown"
        return data
    end
    for _, v in pairs(GetPlayerItems(PlayerData)) do
        if GetHashKey(v.name) == weapon then
            return v
        end
    end
end

exports("GetPlayerItems", GetPlayerItems)

function LockInventory(value) -- To avoid the player to open the inventory
    if Config.Inventory == "ox_inventory" then
        return -- Looks like when searching other player inventory ox check if the inv is bussy, cause the player is cuffed agents can't search the inventory of cuffed players
    end
    LocalPlayer.state.invBusy = value
end