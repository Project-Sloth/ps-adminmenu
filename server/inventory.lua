-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local Player = QBCore.Functions.GetPlayer(player)

    if not Player then
        return QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500)
    end

    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:ClearInventory(player)
    else
        exports[Config.Inventory]:ClearInventory(player, nil)
    end

    QBCore.Functions.Notify(src,
        locale("invcleared", Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname),
        'success', 7500)
end)

-- Clear Inventory Offline
RegisterNetEvent('ps-adminmenu:server:ClearInventoryOffline', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source
    local citizenId = selectedData["Citizen ID"].value
    local Player = QBCore.Functions.GetPlayerByCitizenId(citizenId)

    if Player then
        if Config.Inventory == 'ox_inventory' then
            exports.ox_inventory:ClearInventory(Player.PlayerData.source)
        else
            exports[Config.Inventory]:ClearInventory(Player.PlayerData.source, nil)
        end
        QBCore.Functions.Notify(src,
            locale("invcleared", Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname),
            'success', 7500)
    else
        MySQL.Async.fetchAll("SELECT * FROM players WHERE citizenid = @citizenid", { ['@citizenid'] = citizenId },
            function(result)
                if result and result[1] then
                    MySQL.Async.execute("UPDATE players SET inventory = '{}' WHERE citizenid = @citizenid",
                        { ['@citizenid'] = citizenId })
                    QBCore.Functions.Notify(src, "Player's inventory cleared", 'success', 7500)
                else
                    QBCore.Functions.Notify(src, locale("player_not_found"), 'error', 7500)
                end
            end)
    end
end)

-- Open Inv [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenInv', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'player', data)
end)

-- Open Stash [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenStash', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'stash', data)
end)

-- Open Trunk [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenTrunk', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'trunk', data)
end)

-- Give Item
RegisterNetEvent('ps-adminmenu:server:GiveItem', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local target = selectedData["Player"].value
    local item = selectedData["Item"].value
    local amount = tonumber(selectedData["Amount"].value)
    local Player = QBCore.Functions.GetPlayer(target)

    if not item or not amount or amount <= 0 then return end
    if not Player then
        return QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500)
    end

    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:AddItem(target, item, amount)
    elseif Config.Inventory == "qb-inventory" then
        Player.Functions.AddItem(item, amount)
    end

    QBCore.Functions.Notify(source,
        locale("give_item", amount .. " " .. item,
            Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), "success", 7500)
end)

-- Give Item to All
RegisterNetEvent('ps-adminmenu:server:GiveItemAll', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local item = selectedData["Item"].value
    local amount = tonumber(selectedData["Amount"].value)
    local players = QBCore.Functions.GetPlayers()

    if not item or not amount or amount <= 0 then return end

    for _, id in pairs(players) do
        if Config.Inventory == "ox_inventory" then
            exports.ox_inventory:AddItem(id, item, amount)
        elseif Config.Inventory == "qb-inventory" then
            local Player = QBCore.Functions.GetPlayer(id)
            if Player then
                Player.Functions.AddItem(item, amount)
            end
        end
    end

    QBCore.Functions.Notify(source, locale("give_item_all", amount .. " " .. item), "success", 7500)
end)