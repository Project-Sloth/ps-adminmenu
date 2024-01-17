-- Freeze Player
local frozen = false

RegisterNetEvent('ps-adminmenu:server:FreezePlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source

    local target = selectedData["Player"].value

    local ped = GetPlayerPed(target)
    local Player = ESX.GetPlayerFromId(target)

    if not frozen then
        frozen = true
        FreezeEntityPosition(ped, true)
        TriggerClientEvent('esx:showNotification', src,
            _U("Frozen",
                Player.getName()), 'Success', 7500)
    else
        frozen = false
        FreezeEntityPosition(ped, false)
        TriggerClientEvent('esx:showNotification', src,
            _U("deFrozen",
                Player.getName()), 'Success', 7500)
    end
    if Player == nil then return TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500) end
end)

-- Drunk Player
RegisterNetEvent('ps-adminmenu:server:DrunkPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target = selectedData["Player"].value
    local Player = ESX.GetPlayerFromId(target)

    if not Player then
        return TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500)
    end

    TriggerClientEvent('ps-adminmenu:client:InitiateDrunkEffect', target)
    TriggerClientEvent('esx:showNotification', src,
        _U("playerdrunk",
            Player.getName()), 'Success', 7500)
end)

-- Set on fire
RegisterNetEvent('ps-adminmenu:server:SetOnFire', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target = selectedData["Player"].value
    local Player = ESX.GetPlayerFromId(target)

    if not Player then
        return TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500)
    end

    TriggerClientEvent('ps-adminmenu:client:SetOnFire', target)
    TriggerClientEvent('esx:showNotification', src,
        "Player on fire",
            Player.getName(), 'Success', 7500)
end)

-- Explode Player
RegisterNetEvent('ps-adminmenu:server:ExplodePlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target = selectedData["Player"].value
    local Player = ESX.GetPlayerFromId(target)

    if not Player then
        return TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500)
    end

    TriggerClientEvent('ps-adminmenu:client:ExplodePlayer', target)
    TriggerClientEvent('esx:showNotification', src,
        "Player Exploded",
            Player.getName(), 'Success', 7500)
end)
