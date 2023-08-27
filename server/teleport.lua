-- Teleport To Player
RegisterNetEvent('ps-adminmenu:server:TeleportToPlayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local player = selectedData["Player"].value

    if not player then
        local coords = GetEntityCoords(target)
        CheckRoutingbucket(source, target)
        TriggerClientEvent('ps-adminmenu:client:TeleportToPlayer', source, coords)
    else
        TriggerClientEvent('QBCore:Notify', source, locale('not_online'), 'error')
    end
end)
