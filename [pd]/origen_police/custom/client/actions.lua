local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("origen_police:client:domyfinguer", function()
    local PlayerData = FW_GetPlayerData(false)
    local text = Config.Translations['domyfinguer']:format((PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname))
    -- UseCommand('me', text)
    QBCore.Functions.Progressbar("fingerprint_scan", "正在进行指纹验证...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_fbi_heist",
        anim = "loop",
        flags = 49,
    }, {}, {}, function() -- 成功回调
        UseCommand('me', text)
    end, function() -- 取消回调
        UseCommand('me', "嫌疑人取消了指纹验证")
    end)
end)

function LeavePoliceEquipment(p)
    local PlayerData = FW_GetPlayerData(false)
    local invID = "armas_policiales_" .. (p.station or 0).."_"..PlayerData.citizenid
    local stashData = Config.Stashes.PoliceEquipment
    OpenStash(invID, stashData.label, stashData.slots, stashData.weight, PlayerData.citizenid, true)
end

function PoliceInventory(p)
    local PlayerData = FW_GetPlayerData(false)
    local invID = "inventario_policial_" .. (p.station or 0)
    local stashData = Config.Stashes.PoliceInventory
    OpenStash(invID, stashData.label, stashData.slots, stashData.weight, PlayerData.citizenid, false)
end

function OpenEvidenceInventory(p)
    OpenMenu('dialog', GetCurrentResourceName(), 'evidenceInventory', {
        title = "Enter the Evidence ID",
    }, function(data, menu)
        if type(data) ~= "table" then
            data = {value = data}
        end
        if data and data.value then
            local text = tostring(data.value)
            if text and text:gsub("%s+", "") ~= "" then
                local stashData = Config.Stashes.Evidence
                OpenStash("org_police_evidence_"..text, stashData.label.." "..text, stashData.slots, stashData.weight, nil, false)
            end

            menu.close()
        else
            ShowNotification(Config.Translations.MustEnterNumber)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function CanOpenQuickAccessMenu()
    -- Check if player can open quick access menu
    local PlayerData = FW_GetPlayerData(false)
    if PlayerData == nil or PlayerData.job == nil or PlayerData.job.name == nil then return false end
    return (CanOpenTablet(PlayerData.job.name)[1] and PlayerData.job.onduty)
end

function handCuff(cb) -- This is just a callback so you can do anything you want, there's no need to add anything if you don't want to.
    cb(true)
end

-- rb_code
local isHandcuffed = false

exports('isHandcuffed', function()
    return isHandcuffed
end)

local function HandCuffAnimation()
    local ped = PlayerPedId()
    if isHandcuffed == true then
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Cuff', 0.2)
    else
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Uncuff', 0.2)
    end

    loadAnimDict('mp_arrest_paired')
    Wait(100)
    TaskPlayAnim(ped, 'mp_arrest_paired', 'cop_p2_back_right', 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Cuff', 0.2)
    Wait(3500)
    TaskPlayAnim(ped, 'mp_arrest_paired', 'exit', 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

local function GetCuffedAnimation(playerId)
    local ped = PlayerPedId()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
    local heading = GetEntityHeading(cuffer)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Cuff', 0.2)
    loadAnimDict('mp_arrest_paired')
    SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, 0.0))

    Wait(100)
    SetEntityHeading(ped, heading)
    TaskPlayAnim(ped, 'mp_arrest_paired', 'crook_p2_back_right', 3.0, 3.0, -1, 32, 0, 0, 0, 0, true, true, true)
    Wait(2500)
end

RegisterNetEvent('police:client:GetCuffed', function(playerId, isSoftcuff)
    local ped = PlayerPedId()
    if not isHandcuffed then
        isHandcuffed = true
        TriggerServerEvent('police:server:SetHandcuffStatus', true)
        ClearPedTasksImmediately(ped)
        if GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then
            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        end
        if not isSoftcuff then
            cuffType = 16
            GetCuffedAnimation(playerId)  -- 软手铐还没搞清楚是哪个
            QBCore.Functions.Notify("您被铐住了", 'primary')
        else
            cuffType = 49
            GetCuffedAnimation(playerId)
            QBCore.Functions.Notify("您被铐住了，但可以走动", 'primary')
        end
    else
        isHandcuffed = false
        isEscorted = false
        TriggerEvent('hospital:client:isEscorted', isEscorted)
        DetachEntity(ped, true, false)
        TriggerServerEvent('police:server:SetHandcuffStatus', false)
        ClearPedTasksImmediately(ped)
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Uncuff', 0.2)
        QBCore.Functions.Notify("您被解拷了", 'success')
    end
end)

RegisterNetEvent('police:client:CuffPlayerSoft', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                TriggerServerEvent('police:server:CuffPlayer', playerId, true)
                HandCuffAnimation()
            else
                QBCore.Functions.Notify("您或对方在载具中", 'error')
            end
        else
            QBCore.Functions.Notify("没有人在附近", 'error')
        end
    else
        Wait(2000)
    end
end)

local controlsToDisable = {  -- when isHandcuffed
    24, 257, 25, 263,  -- Attack, Attack 2, Aim, Melee Attack 1
    45, 21, 22, 44, 37, 23,  -- Reload, Sprint, Jump, Cover, Select Weapon
    288, 289, 170, 167,  -- Disable phone, Inventory, Animations, Job
    26, 73, 199,  -- Disable looking behind, clearing animation, pause screen
    59, 71, 72,  -- Disable steering, driving forward, reversing in vehicle
    36,  -- Disable going stealth
    264, 257, 140, 141, 142, 143,  -- Disable melee
    75,   -- Disable exit vehicle
    38,  -- E
    19,  -- lmenu
}
-- 保持被拷的线程
CreateThread(function()
    while true do
        Wait(1)
        
        if isHandcuffed then
            for _, control in ipairs(controlsToDisable) do
                DisableControlAction(0, control, true)
            end

            if not IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
                loadAnimDict('mp_arresting')
                TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            end
        else
            Wait(2000)
        end
    end
end)