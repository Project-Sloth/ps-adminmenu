-- Revive Player
RegisterNetEvent('ps-adminmenu:server:Revive', function(data, selectedData)
    local id = selectedData["Player"].value

    if not CheckPerms(data.perms) then return end
    if not id then return end

    TriggerClientEvent('hospital:client:Revive', id)
end)

-- Revive All
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function(data)
    if not CheckPerms(data.perms) then return end

    TriggerClientEvent('hospital:client:Revive', -1)
end)

-- Revive Radius -- use getClosesPlad [reminder for ok1ez] https://overextended.dev/ox_lib/Modules/GetClosestPed/Client#libgetclosestped
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function(data)
    if not CheckPerms(data.perms) then return end

    TriggerClientEvent('hospital:client:Revive', -1)
end)

