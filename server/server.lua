local QBCore = exports['qb-core']:GetCoreObject()

local function NoPerms(source)
    QBCore.Functions.Notify(source, Lang:t('error.no_perms'), 'error')
end


RegisterNetEvent('ps-adminmenu:server:Getresources', function(data)
    local totalResources = GetNumResources()
    -- print("total " .. totalResources)
    local resources = {} 
    for i = 0, totalResources - 1 do
        local resourceName = GetResourceByFindIndex(i)
        local author = GetResourceMetadata(resourceName, "author")
        local version = GetResourceMetadata(resourceName, "version")
        local description = GetResourceMetadata(resourceName, "description")
        local resourceState = GetResourceState(resourceName)
        
        table.insert(resources, {
            name = resourceName,
            author = author,
            version = version,
            description = description,
            resourceState = resourceState,
        })
        -- print("Status: " .. resourceState .. " Name: " .. resourceName .. " Author: " .. (author or "N/A") .. " Version: " .. (version or "N/A") .. " Description: " .. (description or "N/A"))
    end
    TriggerClientEvent('ps-adminmenu:client:UpdateResources', -1, resources)
    --print("sendt resources")
end)
    
RegisterNetEvent('ps-adminmenu:server:changeResourceState', function(name, state)
	if state == "started" then
		StopResource(name)
	elseif state == "stopped" then
		StartResource(name)
	else
		StopResource(name)
		Wait(200)
		StartResource(name)
	end
end)

-- Get Players
QBCore.Functions.CreateCallback('ps-adminmenu:server:GetPlayers', function(_, cb)
    local Players = {}
    local GetPlayers = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(GetPlayers) do
        local playerData = v.PlayerData

        Players[#Players + 1] = {
            id = k,
            name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
            cid = playerData.citizenid,
            license = QBCore.Functions.GetIdentifier(k, 'license'),
        }
    end
    table.sort(Players, function(a, b) return a.id < b.id end)
    cb(Players)
end)

-- Admin Car
RegisterNetEvent('ps-adminmenu:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
    if result[1] == nil then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle.model,
            vehicle.hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.veh_owner"), 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.u_veh_owner"), 'error', 3000)
    end

end)

-- blackout
local Blackout = false
RegisterNetEvent('ps-adminmenu:server:ToggleBlackout', function(inputData)
    local src = source
    Blackout = not Blackout

    if Blackout then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.blackout", {value = "enabled"}), 'primary')
        while Blackout do
            Wait(0)
            exports["qb-weathersync"]:setBlackout(true)
        end
        exports["qb-weathersync"]:setBlackout(false)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.blackout", {value = "disabled"}), 'primary')
    end
end)

-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(inputData)
    local src = source
    local playerid = inputData["Player ID"]
    local reason = inputData["Reason"]
    local time = inputData["Time"]
		if reason == nil then reason = "" end
    time = tonumber(time)
    local banTime = tonumber(os.time() + time)
    if banTime > 2147483647 then
        banTime = 2147483647
    end
    local timeTable = os.date('*t', banTime)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(playerid),
        QBCore.Functions.GetIdentifier(playerid, 'license'),
        QBCore.Functions.GetIdentifier(playerid, 'discord'),
        QBCore.Functions.GetIdentifier(playerid, 'ip'),
        reason,
        banTime,
        GetPlayerName(src)
    })
    if banTime >= 2147483647 then
        DropPlayer(playerid, Lang:t("info.banned") .. '\n' .. Lang:t("info.reason") .. reason .. Lang:t("info.ban_perm") .. '\n \n' .. Lang:t("info.join_disc") .. '\n' .. QBCore.Config.Server.Discord)
    else
        DropPlayer(playerid, Lang:t("info.banned") .. '\n' .. Lang:t("info.reason") .. reason .. '\n' .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n \n' .. Lang:t("info.join_disc") .. '\n' .. QBCore.Config.Server.Discord)
    end

end)

-- Kill Player
RegisterNetEvent('ps-adminmenu:server:KillPlayer', function(inputData)
    local playerId = inputData["Player ID"]
    TriggerClientEvent('hospital:client:KillPlayer', playerId)
end)

-- Bring Player
RegisterNetEvent('ps-adminmenu:server:BringPlayer', function(inputData)
    local src = source
    local targetPed = inputData["Player ID"]

    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(targetPed)
    SetEntityCoords(target, coords)

end)

-- Teleport To Player
RegisterNetEvent('ps-adminmenu:server:TeleportToPlayer', function(inputData)
    local src = source
    
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local target = GetPlayerPed(tonumber(inputData["Player ID"]))
    if target ~= 0 then
        local coords = GetEntityCoords(target)
        TriggerClientEvent('ps-adminmenu:client:TeleportToPlayer', src, coords)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_online'), 'error')
    end
end)

-- Teleport To Coords
RegisterNetEvent('ps-adminmenu:server:TeleportToCoords', function(inputData)
    local src = source
    local xdata = inputData["X"]
    local ydata = inputData["Y"]
    local zdata = inputData["Z"]

    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if xdata and ydata and zdata then
        local x = tonumber((xdata:gsub(",",""))) + .0
        local y = tonumber((ydata:gsub(",",""))) + .0
        local z = tonumber((zdata:gsub(",",""))) + .0
        TriggerClientEvent('ps-adminmenu:client:TeleportToCoords', src, x, y, z)
        
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.missing_args'), 'error')
    end

end)

-- Revive Player
RegisterNetEvent('ps-adminmenu:server:Revive', function(inputData)
    local src = source
    print(inputData)
    local id = inputData["Player ID"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if type(id) ~= 'string' and type(id) ~= 'number' then
        return
    end
    id = tonumber(id)

    TriggerClientEvent('hospital:client:Revive', id)
end)

-- Revive All
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function()
    local src = source
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
    TriggerClientEvent('hospital:client:Revive', -1)
end)


-- Kick Player
RegisterNetEvent('ps-adminmenu:server:KickPlayer', function(inputData)
    local src = source
    local playerid = inputData["Player ID"]
    local reason = inputData["Reason"]
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
	if reason == nil then reason = "" end
    DropPlayer(playerid, Lang:t("info.kicked") .. '\n' .. Lang:t("info.reason") .. reason .. '\n \n' .. Lang:t("info.join_disc") .. '\n' .. QBCore.Config.Server.Discord)
end)

-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(inputData)
    local src = source
    local playerId = tonumber(inputData["Player ID"])
    local Player = QBCore.Functions.GetPlayer(playerId)
    local inv = Config.InventoryUsage

    if not (inv == "qb" or inv == "ox" or inv == "lj") then 
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" then
        exports[inv.."-inventory"]:ClearInventory(playerId, nil)
    elseif inv == "ox" then
        exports.ox_inventory:ClearInventory(playerId, nil)
    end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    QBCore.Functions.Notify(src, Lang:t("success.invcleared", {player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. " | " ..Player.PlayerData.citizenid}), 'Success', 7500)
end)

-- Clothing Menu
RegisterNetEvent('ps-adminmenu:server:ClothingMenu', function(inputData)
    local src = source
    local playerId = tonumber(inputData["Player ID"])
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    TriggerClientEvent('qb-clothing:client:openMenu', playerId)
    if playerId == src then
        TriggerClientEvent("ps-adminmenu:client:CloseUI", src)
    end
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
end)

-- Freeze Player
local frozen = false
RegisterNetEvent('ps-adminmenu:server:FreezePlayer', function(inputData)
    local src = source
    local playerId = tonumber(inputData["Player ID"])
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local target = GetPlayerPed(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)

    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
        QBCore.Functions.Notify(src, Lang:t("success.Frozen", {player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. " | " ..Player.PlayerData.citizenid}), 'Success', 7500)
    else
        frozen = false
        FreezeEntityPosition(target, false)
        QBCore.Functions.Notify(src, Lang:t("success.deFrozen", {player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. " | " ..Player.PlayerData.citizenid}), 'Success', 7500)

    end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end

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

-- Give Money
RegisterNetEvent('ps-adminmenu:server:GiveMoney', function(inputData)
    local src = source
    local playerId, amount, moneyType = inputData["Player ID"], inputData["Amount"], inputData["Type"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
    if moneyType == "crypto" then 
        QBCore.Functions.Notify(src, Lang:t("success.give_money_crypto", {info = tonumber(amount), player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname}), "success")
    else
        QBCore.Functions.Notify(src, Lang:t("success.give_money", {info = tonumber(amount).. "$", player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname}), "success")
    end
end)

-- Give Money to all
RegisterNetEvent('ps-adminmenu:server:GiveMoneyAll', function(inputData)
    local src = source
    local amount, moneyType = inputData["Amount"], inputData["Type"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
        if moneyType == "crypto" then 
            QBCore.Functions.Notify(src, Lang:t("success.give_money_all_crypto", {info = tonumber(amount)}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("success.give_money_all", {info = tonumber(amount).. "$", moneyType = moneyType}), "success")
        end
    end
end)

-- Take Money
RegisterNetEvent('ps-adminmenu:server:TakeMoney', function(inputData)
    local src = source
    local playerId, amount, moneyType = inputData["Player ID"], inputData["Amount"], inputData["Type"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if moneyType == "bank" then
        if Player.PlayerData.money.bank >= tonumber(amount) then
            Player.Functions.RemoveMoney("bank", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, Lang:t("success.take_money", {info = tonumber(amount).. "$", player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("info.not_enough_money"), "primary")
        end
    elseif moneyType == "cash" then
        if Player.PlayerData.money.cash >= tonumber(amount) then
            Player.Functions.RemoveMoney("cash", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, Lang:t("success.take_money", {info = tonumber(amount).. "$", player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("info.not_enough_money"), "primary")
        end
    elseif moneyType == "crypto" then
        if Player.PlayerData.money.crypto >= tonumber(amount) then
            Player.Functions.RemoveMoney("crypto", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, Lang:t("success.take_money_crypto", {info = tonumber(amount), player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("info.not_enough_money"), "primary")
        end
    end
end)

-- Give Item
RegisterNetEvent('ps-adminmenu:server:GiveItem', function(inputData)
    local src = source
    local playerId, item, amount = inputData["Player ID"], inputData["Item"], inputData["Amount"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if amount == nil then amount = 1 end
    if Config.Inventory == "ox" then
        exports.ox_inventory:AddItem(Player, item, tonumber(amount))
    else
        Player.Functions.AddItem(item, tonumber(amount))
    end
    QBCore.Functions.Notify(src, Lang:t("success.give_item", {info = tonumber(amount).. " " ..item, player = Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname}), "success", 7500)
end)

-- Give Item to All
RegisterNetEvent('ps-adminmenu:server:GiveItemAll', function(inputData)
    local src = source
    local item, amount = inputData["Item"], inputData["Amount"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if amount == nil then amount = 1 end
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Config.Inventory == "ox" then
            exports.ox_inventory:AddItem(Player, item, tonumber(amount))
        else
            Player.Functions.AddItem(item, tonumber(amount))
        end
        QBCore.Functions.Notify(src, Lang:t("success.give_item_all", {info = tonumber(amount).. " " ..item}), "success", 7500)
    end
end)

-- Server Announcement
RegisterNetEvent('ps-adminmenu:server:ServerAnnouncement', function(inputData)
    local src = source
    local message, length = inputData["Message"], inputData["Length"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if message == nil then QBCore.Functions.Notify(src, Lang:t("error.empty_input"), "error", 7500) return end
    if length == nil then length = 15 end
    QBCore.Functions.Notify(-1, "SERVER ANNOUNCEMENT: "..message, "primary", length)
    TriggerEvent("InteractSound_SV:PlayOnAll", "pager", 0.40)
end)

-- Message Player
RegisterNetEvent('ps-adminmenu:server:MessagePlayer', function(inputData)
    local src = source
    local playerID, message, length = inputData["Player ID"], inputData["Message"], inputData["Length"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if playerID == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if message == nil then QBCore.Functions.Notify(src, Lang:t("error.empty_input"), "error", 7500) return end
    if length == nil then length = 15 end
    QBCore.Functions.Notify(playerID, "PRIVATE ADMIN MESSAGE: "..message, "primary", length)
    TriggerEvent("InteractSound_SV:PlayOnAll", "pager", 0.30)
end)

function permsToString(perms)
    local allowedPerms = {}
    for k, v in pairs(perms) do
        if v then
            table.insert(allowedPerms, k)
        end
    end
    return table.concat(allowedPerms, ", ")
end

-- Check Perms
RegisterNetEvent('ps-adminmenu:server:CheckPerms', function(inputData)
    local src = source
    local playerId = inputData["Player ID"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    local perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
    local permsStr = permsToString(perms)
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 15000) end
    if permsStr == "" then permsStr = "NONE" end
    QBCore.Functions.Notify(src, Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. " got [ " ..permsStr.. " ] Permissions.", "primary", 7500)
end)

-- Set Perms
RegisterNetEvent('ps-adminmenu:server:SetPerms', function(inputData)
    local src = source
    local playerId, permissions = inputData["Player ID"], inputData["Permissions"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if permissions == nil then return QBCore.Functions.Notify(src, Lang:t("error.empty_input"), 'error', 15000) end 
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 15000) end
    QBCore.Functions.AddPermission(Player.PlayerData.source, permissions)
    QBCore.Functions.Notify(src, Player.PlayerData.charinfo.firstname.. " " ..Player.PlayerData.charinfo.lastname.. " got added " ..permissions.. " Permissions.", "primary", 7500)
    QBCore.Functions.Notify(playerId, "Added " ..permissions.. " Permissions.", "primary", 7500)
end)

-- Set Job
RegisterNetEvent('ps-adminmenu:server:SetJob', function(inputData)
    local src = source
    local playerId, Job, grade = inputData["Player ID"], inputData["Job"], inputData["Grade"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end

    Player.Functions.SetJob(tostring(Job), tonumber(grade))
end)

-- Set Gang
RegisterNetEvent('ps-adminmenu:server:SetGang', function(inputData)
    local src = source
    local playerId, Gang, grade = inputData["Player ID"], inputData["Gang"], inputData["Grade"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end

    Player.Functions.SetGang(tostring(Gang), tonumber(grade))
end)
