-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local src = source
    local playerId = tonumber(inputData["Player ID"])
    local Player = QBCore.Functions.GetPlayer(playerId)
    local inv = Config.InventoryUsage

    if not (inv == "qb" or inv == "ox" or inv == "lj" or inv == "ps") then
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" or inv == "ps" then
        exports[inv .. "-inventory"]:ClearInventory(playerId, nil)
    elseif inv == "ox" then
        exports.ox_inventory:ClearInventory(playerId, nil)
    end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    QBCore.Functions.Notify(src, Lang:t("success.invcleared", {player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid}), 'Success', 7500)
end)

-- Open Inv [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenInv', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(data))
    exports.ox_inventory:forceOpenInventory(src, 'player', tonumber(data))
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
end)

-- Open Stash [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenStash', function(data)
    local src = source
    exports.ox_inventory:forceOpenInventory(src, 'stash', data)
end)

-- Give Item
RegisterNetEvent('ps-adminmenu:server:GiveItem', function(inputData, _, perms)
    if not PermsCheck(perms) then return end
    local src = source
    local playerId, item, amount = inputData["Player ID"], inputData["Item"], inputData["Amount"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))

    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if amount == nil then amount = 1 end
    if Config.Inventory == "ox" then
        exports.ox_inventory:AddItem(Player, item, tonumber(amount))
    else
        Player.Functions.AddItem(item, tonumber(amount))
    end
    QBCore.Functions.Notify(src, Lang:t("success.give_item", {info = tonumber(amount) .. " " .. item, player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success", 7500)
end)

-- Give Item to All
RegisterNetEvent('ps-adminmenu:server:GiveItemAll', function(inputData, _, perms)
    if not PermsCheck(perms) then return end
    local src = source
    local item, amount = inputData["Item"], inputData["Amount"]

    if amount == nil then amount = 1 end
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Config.Inventory == "ox" then
            exports.ox_inventory:AddItem(Player, item, tonumber(amount))
        else
            Player.Functions.AddItem(item, tonumber(amount))
        end
        QBCore.Functions.Notify(src, Lang:t("success.give_item_all", {info = tonumber(amount) .. " " .. item}), "success", 7500)
    end
end)