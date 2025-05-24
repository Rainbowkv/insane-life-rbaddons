Poker = {}
Poker.FrameworkType = ''
Poker.FrameworkObject = nil

local function fetchSharedObject(resourceName, exportName, eventName)
    try(function()
        Poker.FrameworkObject = exports[resourceName][exportName]()
    end, function (err)
        print(err)
        TriggerEvent(eventName, function (Obj)
            Poker.FrameworkObject = Obj
        end)
        Citizen.CreateThread(function()
            Citizen.Wait(200)
            if not Poker.FrameworkObject then
                debugPrint('^9ERROR^7', -1, 'Framework loading failed. Given parameters:')
                debugPrint('^9ERROR^7', -1, ('Framework name: ^4%s^7, event name: ^4%s^7, export function name: ^4%s^7, used type: ^4%s^7'):format(Config.Framework, eventName, exportName, Poker.FrameworkType))
                debugPrint('NOTE', -1, 'If any of the parameters do not match your server settings please check your ^4*/framework.lua^7 files')
                Poker.FrameworkType = 'custom'
            end
        end)
    end)
end

Citizen.CreateThread(function()
    if Config.Framework == 'auto' then
        if GetResourceState('es_extended') == 'started' then
            Poker.FrameworkType = 'esx'
        elseif GetResourceState('qb-core') == 'started' then
            Poker.FrameworkType = 'qbcore'
        else
            Poker.FrameworkType = 'custom'
        end
    elseif Config.Framework == 'esx' then
        Poker.FrameworkType = 'esx'
    elseif Config.Framework == 'qbcore' then
        Poker.FrameworkType = 'qbcore'
    else
        Poker.FrameworkType = 'custom'
    end
    
    local evName = IsDuplicityVersion() and Config.FrameworkData.SharedObjectEventNameSV or Config.FrameworkData.SharedObjectEventNameCL
    if Poker.FrameworkType == 'esx' then
        emitNetCB(SVCB.FETCH_FRAMEWORK_RESOURCE_NAME, function (resName)
            fetchSharedObject(resName, 'getSharedObject', evName or 'esx:getSharedObject')
        end)
    elseif Poker.FrameworkType == 'qbcore' then
        emitNetCB(SVCB.FETCH_FRAMEWORK_RESOURCE_NAME, function (resName)
            if GetResourceState('qbx_core') == 'started' then
                fetchSharedObject('qb-core', 'GetCoreObject', evName or 'QBCore:GetObject')
            else
                fetchSharedObject(resName, 'GetCoreObject', evName or 'QBCore:GetObject')
            end
        end)
    elseif Poker.FrameworkType == 'custom' then
        -- Add code for your custom framework
        debugPrint('^6ERROR^7', -1, 'Framework loading failed. No code for custom framework provided, check your ^4*/framework.lua^7 files')
    end

    debugPrint('FRAMEWORK', -1, ('Framework name: ^4%s^7, event name: ^4%s^7, export function name: ^4%s^7, used type: ^4%s^7'):format(Config.Framework, eventName, exportName, Poker.FrameworkType))
end)

Poker.ShowNotification = function(msg)
    if Config.Notifications == 'framework' then
        if Poker.FrameworkType == 'qbcore' or Poker.Framework == 'qb' then
            Poker.FrameworkObject.Functions.Notify(msg)
        elseif Poker.FrameworkType == 'esx' then
            Poker.FrameworkObject.ShowNotification(msg)
        end
    end
end

Poker.ShowButtonNotification = function(msg, coords)
    if Config.Notifications == 'framework' and Poker.FrameworkObject then
        if Poker.FrameworkType == 'qbcore' then
            Poker.DrawText3D(coords, msg)
        elseif Poker.FrameworkType == 'esx' then
            Poker.FrameworkObject.ShowHelpNotification(msg)
        end
    end
end

Poker.DrawText3D = function (coords, text)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z + 1.2)
    local camCoords = GetGameplayCamCoords()
    local dist = #(coords - camCoords)
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

Citizen.CreateThread(function()
    local sitAtTableCtr = Config.Controls.SitAtTable
    local camSwitchCtr = Config.Controls.CameraSwitch
    local str = STRINGS['notification_sit_at_table']
    while true do
        Citizen.Wait(0)
        if ClosestTable and ClosestChairIndex then
            if PlayerState == 'inactive' or PlayerState == 'loadingSit' then
                Poker.ShowButtonNotification(str, GetEntityCoords(ClosestTable.tableObj))
                if IsControlJustPressed(sitAtTableCtr[1], sitAtTableCtr[2]) then
                    PlayerState = 'loadingSit'
                    SendReactMessage('setWindowType', 'join')
                    
                    SetNuiFocus(true, true)
                    SendReactMessage('setVisible', true)
                    SendReactMessage('setTableInfo', {
                        bigBlind = ClosestTable.bigBlind,
                        smallBlind = math.floor(ClosestTable.bigBlind / 2),
                        buyIn = ClosestTable.buyIn,
                    })
                end
            elseif PlayerState == 'playing' or PlayerState == 'atTable' then
                if IsControlJustPressed(camSwitchCtr[1], camSwitchCtr[2]) or IsDisabledControlJustPressed(camSwitchCtr[1], camSwitchCtr[2]) then
                    if IsNuiFocused() then
                        handleCameraChange('free')
                    else
                        handleCameraChange('static_default')
                    end
                end
            end
        end
    end
end)
