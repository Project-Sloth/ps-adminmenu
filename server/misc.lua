-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(data, selectedData)
    local id = selectedData["Player"].value
    local reason = selectedData["Reason"].value
    local time = selectedData["Duration"].value

    if not CheckPerms(data.perms) then return end

    if reason == nil then reason = "" end
    time = tonumber(time)
    local banTime = tonumber(os.time() + time)

    if banTime > 2147483647 then
        banTime = 2147483647
    end

    local timeTable = os.date('*t', banTime)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
        {
            GetPlayerName(id),
            QBCore.Functions.GetIdentifier(id, 'license'),
            QBCore.Functions.GetIdentifier(id, 'discord'),
            QBCore.Functions.GetIdentifier(id, 'ip'),
            reason,
            banTime,
            GetPlayerName(source)
        })
    if banTime >= 2147483647 then
        DropPlayer(id, locale("banned") .. '\n' .. locale("reason") .. reason .. locale("ban_perm"))
    else
        DropPlayer(id, locale("banned") .. '\n' .. locale("reason") .. reason .. '\n' .. locale("ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
    end
end)

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
