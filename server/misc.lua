-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local player = selectedData["Player"].value
    local reason = selectedData["Reason"].value or ""
    local time = selectedData["Duration"].value

    local banTime = tonumber(os.time() + time)
    local timeTable = os.date('*t', banTime)

    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', { GetPlayerName(player), QBCore.Functions.GetIdentifier(player, 'license'), QBCore.Functions.GetIdentifier(player, 'discord'), QBCore.Functions.GetIdentifier(player, 'ip'), reason, banTime, GetPlayerName(source)})

    if time == 2147483647 then
        DropPlayer(player, locale("banned") .. '\n' .. locale("reason") .. reason .. locale("ban_perm"))
    else
        DropPlayer(player, locale("banned") .. '\n' .. locale("reason") .. reason .. '\n' .. locale("ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
    end

    QBCore.Functions.Notify(source, locale("playerbanned", player, banTime, reason), 'success', 7500)
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

-- Revive Radius
RegisterNetEvent('ps-adminmenu:server:ReviveRadius', function(data)
    if not CheckPerms(data.perms) then return end

    local src = source
    local ped = GetPlayerPed(src)
    local pos = GetEntityCoords(ped)
    local players = QBCore.Functions.GetPlayers()

    for k, v in pairs(players) do
        local target = GetPlayerPed(v)
        local targetPos = GetEntityCoords(target)
        local dist = #(pos - targetPos)

        if dist < 15.0 then
            TriggerClientEvent("hospital:client:Revive", v)
        end
    end
end)

-- Set RoutingBucket
RegisterNetEvent('ps-adminmenu:server:SetBucket', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local bucket = selectedData["Bucket"].value
    local currentBucket = GetPlayerRoutingBucket(player)

    if bucket == currentBucket then
        return QBCore.Functions.Notify(src, locale("target_same_bucket",  player), 'error', 7500) 
    end

    SetPlayerRoutingBucket(player, bucket)
    QBCore.Functions.Notify(src, locale("bucket_set_for_target", player, bucket), 'success', 7500)
end)

-- Give Money
RegisterNetEvent('ps-adminmenu:server:GiveMoney', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local playerId, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value, selectedData["Type"].value
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))

    if Player == nil then
        return QBCore.Functions.Notify(src, locale("not_online"), 'error', 7500) 
    end

    Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
    QBCore.Functions.Notify(src, locale((moneyType == "crypto" and "give_money_crypto" or "give_money"), tonumber(amount), Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), "success")
end)

-- Give Money to all
RegisterNetEvent('ps-adminmenu:server:GiveMoneyAll', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local amount, moneyType = selectedData["Amount"].value, selectedData["Type"].value
    local players = QBCore.Functions.GetPlayers()

    for _, v in pairs(players) do
        local Player = QBCore.Functions.GetPlayer(tonumber(v))
        Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
        QBCore.Functions.Notify(src, locale((moneyType == "crypto" and "give_money_all_crypto" or "give_money_all"), tonumber(amount)), "success")
    end
end)

-- Take Money
RegisterNetEvent('ps-adminmenu:server:TakeMoney', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local playerId, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value, selectedData["Type"].value
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))

    if Player == nil then
        return QBCore.Functions.Notify(src, locale("not_online"), 'error', 7500) 
    end

    if Player.PlayerData.money[moneyType] >= tonumber(amount) then
        Player.Functions.RemoveMoney(moneyType, tonumber(amount), "state-fees")
    else
        QBCore.Functions.Notify(src, locale("not_enough_money"), "primary")
    end

    QBCore.Functions.Notify(src, locale((moneyType == "crypto" and "take_money_crypto" or "take_money"), tonumber(amount) .. "$", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), "success")
end)

-- Blackout
local Blackout = false
RegisterNetEvent('ps-adminmenu:server:ToggleBlackout', function(data)
    if not CheckPerms(data.perms) then return end
    Blackout = not Blackout

    local src = source

    if Blackout then
        TriggerClientEvent('QBCore:Notify', src, locale("blackout", "enabled"), 'primary')
        while Blackout do
            Wait(0)
            exports["qb-weathersync"]:setBlackout(true)
        end
        exports["qb-weathersync"]:setBlackout(false)
        TriggerClientEvent('QBCore:Notify', src, locale("blackout", "disabled"), 'primary')
    end
end)

-- Toggle Cuffs
RegisterNetEvent('ps-adminmenu:server:CuffPlayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local playerId = selectedData["Player"].value

    TriggerClientEvent('ps-adminmenu:client:ToggleCuffs', playerId)
    QBCore.Functions.Notify(source, locale("toggled_cuffs"), 'success')
end)