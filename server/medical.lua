-- Revive Player
RegisterNetEvent('ps-adminmenu:server:Revive', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local id = inputData["Player ID"]

    if type(id) ~= 'string' and type(id) ~= 'number' then
        return
    end

    id = tonumber(id)

    TriggerClientEvent('hospital:client:Revive', id)
end)

-- Revive All
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function(_, _, perms)
    if not PermsCheck(perms) then return end

    TriggerClientEvent('hospital:client:Revive', -1)
end)

-- Revive Radius -- use getClosesPlad [reminder for ok1ez] https://overextended.dev/ox_lib/Modules/GetClosestPed/Client#libgetclosestped
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function(_, _, perms)
    if not PermsCheck(perms) then return end

    TriggerClientEvent('hospital:client:Revive', -1)
end)

