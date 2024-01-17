-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local player = selectedData["Player"].value
    local reason = selectedData["Reason"].value or ""
    local time = selectedData["Duration"].value
    local xPlayer = ESX.GetPlayerFromId(player)

    local banTime = tonumber(os.time() + time)
    local timeTable = os.date('*t', banTime)

    MySQL.prepare('INSERT INTO bans (name, license, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?)', {GetPlayerName(player), xPlayer.identifier, reason, banTime, GetPlayerName(source)})

    if time == 2147483647 then
        DropPlayer(player, _U("banned") .. '\n' .. _U("reason") .. reason .. _U("ban_perm"))
    else
        DropPlayer(player,
            _U("banned") ..
            '\n' ..
            _U("reason") ..
            reason ..
            '\n' ..
            _U("ban_expires") ..
            timeTable['day'] ..
            '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
    end

    TriggerClientEvent('esx:showNotification', source, _U("playerbanned", player, banTime, reason), 'success', 7500)
end)

-- Warn Player
RegisterNetEvent('ps-adminmenu:server:WarnPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local targetId = selectedData["Player"].value
    local target = ESX.GetPlayerFromId(targetId)
    local reason = selectedData["Reason"].value
    local sender = ESX.GetPlayerFromId(source)
    local warnId = 'WARN-' .. math.random(1111, 9999)
    if target then
        TriggerClientEvent('esx:showNotification', target.source, _U("warned") .. ", for: " .. _U("reason") .. ": " .. reason, 'inform', 10000)

        TriggerClientEvent('esx:showNotification', source,_U("warngiven") .. GetPlayerName(target.source) .. ", for: " .. reason)

        MySQL.prepare('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)',
            {
                sender.identifier,
                target.identifier,
                reason,
                warnId
            })
    else
        TriggerClientEvent('esx:showNotification', source, _U("not_online"), 'error')
    end
end)

RegisterNetEvent('ps-adminmenu:server:KickPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local src = source
    local target = ESX.GetPlayerFromId(selectedData["Player"].value)
    local reason = selectedData["Reason"].value

    if not target then
        TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500)
        return
    end

    DropPlayer(target.source, _U("kicked") .. '\n' .. _U("reason") .. reason)
end)

-- Revive Player
RegisterNetEvent('ps-adminmenu:server:Revive', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local player = selectedData["Player"].value

    TriggerClientEvent('esx_ambulancejob:revive', player)
end)

-- Revive All
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    TriggerClientEvent('esx_ambulancejob:revive', -1)
end)

-- Revive Radius
RegisterNetEvent('ps-adminmenu:server:ReviveRadius', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local ped = GetPlayerPed(src)
    local pos = GetEntityCoords(ped)
    local players = ESX.GetExtendedPlayers()

    for _,v in pairs(players) do
        local target = GetPlayerPed(v.source)
        local targetPos = GetEntityCoords(target)
        local dist = #(pos - targetPos)

        if dist < 30.0 then
            TriggerClientEvent("esx_ambulancejob:revive", v.source)
        end
    end
end)

-- Set RoutingBucket
RegisterNetEvent('ps-adminmenu:server:SetBucket', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local bucket = selectedData["Bucket"].value
    local currentBucket = GetPlayerRoutingBucket(player)

    if bucket == currentBucket then
        return TriggerClientEvent('esx:showNotification', src, _U("target_same_bucket", player), 'error', 7500)
    end

    SetPlayerRoutingBucket(player, bucket)
    TriggerClientEvent('esx:showNotification', src, _U("bucket_set_for_target", player, bucket), 'success', 7500)
end)

-- Get RoutingBucket
RegisterNetEvent('ps-adminmenu:server:GetBucket', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local currentBucket = GetPlayerRoutingBucket(player)

    TriggerClientEvent('esx:showNotification', src, _U("bucket_get", player, currentBucket), 'success', 7500)
end)

-- Give Money
RegisterNetEvent('ps-adminmenu:server:GiveMoney', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value, selectedData["Type"].value
    local Player = ESX.GetPlayerFromId(tonumber(target))

    if not Player then
        return TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500)
    end

    Player.addAccountMoney(tostring(moneyType), tonumber(amount))
    TriggerClientEvent('esx:showNotification', src,
        _U((moneyType == "black_money" and "give_money_black" or "give_money"), tonumber(amount),
            Player.getName()), "success")
end)

-- Give Money to all
RegisterNetEvent('ps-adminmenu:server:GiveMoneyAll', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local amount, moneyType = selectedData["Amount"].value, selectedData["Type"].value
    local players = ESX.GetExtendedPlayers()

    for _,v in pairs(players) do
        v.addAccountMoney(tostring(moneyType), tonumber(amount))
    end
    TriggerClientEvent('esx:showNotification', src,
    _U((moneyType == "black_money" and "give_money_all_black" or "give_money_all"), tonumber(amount)), "success")
end)

-- Take Money
RegisterNetEvent('ps-adminmenu:server:TakeMoney', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target, amount, moneyType = selectedData["Player"].value, selectedData["Amount"].value, selectedData["Type"].value
    local Player = ESX.GetPlayerFromId(tonumber(target))

    if not Player then
        return TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500)
    end

    if Player.getAccount(moneyType).money >= tonumber(amount) then
        Player.removeAccountMoney(moneyType, tonumber(amount), "state-fees")
    else
        TriggerClientEvent('esx:showNotification', src, _U("not_enough_money"), "success")
    end

    TriggerClientEvent('esx:showNotification', src,
        _U((moneyType == "black_money" and "take_money_black" or "take_money"), tonumber(amount) .. "$",
            Player.getName()), "success")
end)

-- Blackout
local Blackout = false
RegisterNetEvent('ps-adminmenu:server:ToggleBlackout', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    Blackout = not Blackout

    local src = source

    TriggerClientEvent('esx:showNotification', src, _U("blackout", "enabled" and Blackout or "disabled"), 'primary')
    ExecuteCommand('blackout')
    Wait(500)
    TriggerEvent('vSync:requestSync')
end)

-- Toggle Cuffs
RegisterNetEvent('ps-adminmenu:server:CuffPlayer', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local target = selectedData["Player"].value

    TriggerClientEvent('ps-adminmenu:client:ToggleCuffs', target)
    TriggerClientEvent('esx:showNotification', source, _U("toggled_cuffs"), 'success')
end)

-- Give Clothing Menu
RegisterNetEvent('ps-adminmenu:server:ClothingMenu', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local target = tonumber(selectedData["Player"].value)

    if not target then
        return TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'error', 7500)
    end

    if target == src then
        TriggerClientEvent("ps-adminmenu:client:CloseUI", src)
    end

    TriggerClientEvent('esx_skin:openSaveableMenu', target)
end)

-- Set Ped
RegisterNetEvent("ps-adminmenu:server:setPed", function(data, selectedData)
    local src = source
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then
        TriggerClientEvent('esx:showNotification', src, _U("no_perms"), "error", 5000)
        return
    end

    local ped = selectedData["Ped Models"].label
    local tsrc = selectedData["Player"].value
    local Player = ESX.GetPlayerFromId(tsrc)

    if not Player then
        TriggerClientEvent('esx:showNotification', src, _U("not_online"), "error", 5000)
        return
    end

    TriggerClientEvent("ps-adminmenu:client:setPed", Player.source, ped)
end)
