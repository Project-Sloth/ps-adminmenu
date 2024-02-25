local spectating = {}

RegisterNetEvent('ps-adminmenu:server:SpectateTarget', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local player = selectedData["Player"].value

    local type = "1"
    if player == source then return QBCore.Functions.Notify(source, locale("cant_spectate_yourself"), 'error', 7500) end
    if spectating[source] then type = "0" end
    TriggerEvent('ps-adminmenu:spectate', player, type == "1", source, data.perms)
    CheckRoutingbucket(source, player)
end)

AddEventHandler('ps-adminmenu:spectate', function(target, on, source, perms)
    local tPed = GetPlayerPed(target)
    local data = {}
    data.perms = perms
    if DoesEntityExist(tPed) then
        if not on then
            TriggerClientEvent('ps-adminmenu:cancelSpectate', source)
            spectating[source] = false
            FreezeEntityPosition(GetPlayerPed(source), false)
            TriggerClientEvent('ps-adminmenu:client:toggleNames', source, data)
        elseif on then
            TriggerClientEvent('ps-adminmenu:requestSpectate', source, NetworkGetNetworkIdFromEntity(tPed), target,
                GetPlayerName(target))
            spectating[source] = true
            TriggerClientEvent('ps-adminmenu:client:toggleNames', source, data)
        end
    end
end)

RegisterNetEvent('ps-adminmenu:spectate:teleport', function(target)
    local source = source
    local ped = GetPlayerPed(target)
    if DoesEntityExist(ped) then
        local targetCoords = GetEntityCoords(ped)
        SetEntityCoords(GetPlayerPed(source), targetCoords.x, targetCoords.y, targetCoords.z - 10)
        FreezeEntityPosition(GetPlayerPed(source), true)
    end
end)
