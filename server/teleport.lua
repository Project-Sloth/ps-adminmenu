-- Teleport To Player
RegisterNetEvent('ps-adminmenu:server:TeleportToPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local targetPed = GetPlayerPed(player)
    local coords = GetEntityCoords(targetPed)

    CheckRoutingbucket(src, player)
    TriggerClientEvent('ps-adminmenu:client:TeleportToPlayer', src, coords)
end)

-- Bring Player
RegisterNetEvent('ps-adminmenu:server:BringPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local targetPed = selectedData["Player"].value
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(targetPed)

    CheckRoutingbucket(targetPed, src)
    SetEntityCoords(target, coords)
end)
