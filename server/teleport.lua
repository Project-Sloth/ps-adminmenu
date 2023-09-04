-- Teleport To Player
RegisterNetEvent('ps-adminmenu:server:TeleportToPlayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end
    local player = selectedData["Player"].value

    if not player then
        local coords = GetEntityCoords(player)
        CheckRoutingbucket(source, player)
        TriggerClientEvent('ps-adminmenu:client:TeleportToPlayer', source, coords)
    else
        TriggerClientEvent('QBCore:Notify', source, locale('not_online'), 'error')
    end
end)

-- Bring Player
RegisterNetEvent('ps-adminmenu:server:BringPlayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end
    local src = source
    local targetPed = selectedData["Player"].value

    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(targetPed)
    CheckRoutingbucket(targetPed, src)
    SetEntityCoords(target, coords)
end)