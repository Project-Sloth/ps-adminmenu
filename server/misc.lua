-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local player = selectedData["Player"].value
    local reason = selectedData["Reason"].value
    local time = selectedData["Duration"].value

    if reason == nil then reason = "" end
    time = tonumber(time)
    local banTime = tonumber(os.time() + time)

    if banTime > 2147483647 then
        banTime = 2147483647
    end

    local timeTable = os.date('*t', banTime)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)',
        {
            GetPlayerName(player),
            QBCore.Functions.GetIdentifier(player, 'license'),
            QBCore.Functions.GetIdentifier(player, 'discord'),
            QBCore.Functions.GetIdentifier(player, 'ip'),
            reason,
            banTime,
            GetPlayerName(source)
        })
    if banTime >= 2147483647 then
        DropPlayer(player, locale("banned") .. '\n' .. locale("reason") .. reason .. locale("ban_perm"))
    else
        DropPlayer(player, locale("banned") .. '\n' .. locale("reason") .. reason .. '\n' .. locale("ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
    end
end)

-- Revive Player
RegisterNetEvent('ps-adminmenu:server:Revive', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local player = selectedData["Player"].value

    TriggerClientEvent('hospital:client:Revive', player)
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

-- Set RoutingBucket
RegisterNetEvent('ps-adminmenu:server:SetBucket', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local player = selectedData["Player"].value
    local bucket = selectedData["Bucket"].value

    local currentBucket = GetPlayerRoutingBucket(player)
    if bucket == currentBucket then return QBCore.Functions.Notify(source, locale("target_same_bucket", {target = player}), 'error', 7500) end
    SetPlayerRoutingBucket(player, bucket)
    QBCore.Functions.Notify(source, locale("bucket_set_for_target", {target = player, bucket = bucket}), 'success', 7500)
end)