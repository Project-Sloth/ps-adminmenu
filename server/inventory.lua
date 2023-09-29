-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local player = selectedData["Player"].value
    local Player = QBCore.Functions.GetPlayer(player)
    local name = GetPlayerName(src)

    if not Player then
        return QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500)
    end

    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:ClearInventory(player)
    else
        exports[Config.Inventory]:ClearInventory(player, nil)
    end

    QBCore.Functions.Notify(src, locale("invcleared", name), 'success', 7500)
end)

-- Open Inv [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenInv', function(data)
    local Player = QBCore.Functions.GetPlayer(data)

    if not Player then 
        return QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500) 
    end

    exports.ox_inventory:forceOpenInventory(source, 'player', data)
end)

-- Open Stash [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenStash', function(data)
    exports.ox_inventory:forceOpenInventory(source, 'stash', data)
end)

-- Give Item
RegisterNetEvent('ps-adminmenu:server:GiveItem', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local target = selectedData["Player"].value
    local item = selectedData["Item"].value
    local amount = selectedData["Amount"].value
    local Player = QBCore.Functions.GetPlayer(target)

    if not item or not amount then return end
    if not Player then
        return QBCore.Functions.Notify(source, locale("not_online"), 'error', 7500) 
    end

    Player.Functions.AddItem(item, amount)
    QBCore.Functions.Notify(source, locale("give_item", tonumber(amount) .. " " .. item, Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname), "success", 7500)
end)

-- Give Item to All
RegisterNetEvent('ps-adminmenu:server:GiveItemAll', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local item = selectedData["Item"].value
    local amount = selectedData["Amount"].value
    local players = QBCore.Functions.GetPlayers()

    if not item or not amount then return end

    for _, id in pairs(players) do
        local Player = QBCore.Functions.GetPlayer(id)
        Player.Functions.AddItem(item, amount)
        QBCore.Functions.Notify(source, locale("give_item_all", amount .. " " .. item), "success", 7500)
    end
end)
