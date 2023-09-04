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

    QBCore.Functions.Notify(source, locale("playerbanned", {target = player, duration = banTime, reason = reason}), 'success', 7500)
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

-- Check Perms
RegisterNetEvent('ps-adminmenu:server:CheckPerms', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local playerId = selectedData["Player"].value
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))

    if Player == nil then return QBCore.Functions.Notify(src, locale("not_online"), 'error', 15000) end
    local perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
    local permsStr = permsToString(perms)

    if permsStr == "" then permsStr = "NONE" end
    name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    QBCore.Functions.Notify(src, locale("player_perms", {name = name, perms = permsStr}), "primary", 7500)
end)

-- Give Money
RegisterNetEvent('ps-adminmenu:server:GiveMoney', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local playerId, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value, selectedData["Type"].value
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))

    if Player == nil then return QBCore.Functions.Notify(src, locale("not_online"), 'error', 7500) end
    Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
    if moneyType == "crypto" then
        QBCore.Functions.Notify(src, locale("give_money_crypto", {info = tonumber(amount), player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
    else
        QBCore.Functions.Notify(src, locale("give_money", {info = tonumber(amount) .. "$", player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
    end
end)

-- Give Money to all
RegisterNetEvent('ps-adminmenu:server:GiveMoneyAll', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local amount, moneyType = selectedData["Amount"].value, selectedData["Type"].value

    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
        if moneyType == "crypto" then
            QBCore.Functions.Notify(src, locale("give_money_all_crypto", {info = tonumber(amount)}), "success")
        else
            QBCore.Functions.Notify(src, locale("give_money_all", {info = tonumber(amount) .. "$", moneyType = moneyType}), "success")
        end
    end
end)

-- Take Money
RegisterNetEvent('ps-adminmenu:server:TakeMoney', function(data, selectedData)
    if not CheckPerms(data.perms) then return end
    local src = source
    local playerId, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value, selectedData["Type"].value
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))

    if Player == nil then return QBCore.Functions.Notify(src, locale("not_online"), 'error', 7500) end
    if string.len(amount) > 6 then return QBCore.Functions.Notify(src, locale("amount_max"), "error", 5000) end
    if moneyType == "bank" then
        if Player.PlayerData.money.bank >= tonumber(amount) then
            Player.Functions.RemoveMoney("bank", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, locale("take_money", {info = tonumber(amount) .. "$", player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, locale("not_enough_money"), "primary")
        end
    elseif moneyType == "cash" then
        if Player.PlayerData.money.cash >= tonumber(amount) then
            Player.Functions.RemoveMoney("cash", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, locale("take_money", {info = tonumber(amount) .. "$", player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, locale("not_enough_money"), "primary")
        end
    elseif moneyType == "crypto" then
        if Player.PlayerData.money.crypto >= tonumber(amount) then
            Player.Functions.RemoveMoney("crypto", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, locale("take_money_crypto", {info = tonumber(amount), player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, locale("not_enough_money"), "primary")
        end
    end
end)

-- blackout
local Blackout = false
RegisterNetEvent('ps-adminmenu:server:ToggleBlackout', function(data)
    if not CheckPerms(data.perms) then return end

    local src = source
    Blackout = not Blackout

    if Blackout then
        TriggerClientEvent('QBCore:Notify', src, locale("blackout", {value = "enabled"}), 'primary')
        while Blackout do
            Wait(0)
            exports["qb-weathersync"]:setBlackout(true)
        end
        exports["qb-weathersync"]:setBlackout(false)
        TriggerClientEvent('QBCore:Notify', src, locale("blackout", {value = "disabled"}), 'primary')
    end
end)