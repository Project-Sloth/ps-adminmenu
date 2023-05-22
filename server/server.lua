QBCore = exports['qb-core']:GetCoreObject()

local function NoPerms(source)
    QBCore.Functions.Notify(source, Lang:t('error.no_perms'), 'error')
end

local function ConfigInvInvalid()
    print('^1[Error] Your Config.Inventory isnt set.. you probably had a typo\nYou have it set as= Config.Inventory = "'.. Config.Inventory .. '"')
end


RegisterNetEvent('ps-adminmenu:client:Getresources', function(data)
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


-- Spawn Vehicle
RegisterNetEvent('ps-adminmenu:server:SpawnVehicle', function(inputData)
    local vehicle = inputData["Vehicle"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    TriggerClientEvent('QBCore:Command:SpawnVehicle', source, vehicle)
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


-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(inputData)
    local src = source
    local playerid = inputData["Player ID"]
    local reason = inputData["Reason"]
    local time = inputData["Time"]
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
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
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
		if reason == nil then reason = "" end
    DropPlayer(playerid, Lang:t("info.kicked") .. '\n' .. Lang:t("info.reason") .. reason .. '\n \n' .. Lang:t("info.join_disc") .. '\n' .. QBCore.Config.Server.Discord)
end)


-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(inputData)
    local src = source
    local playerId = tonumber(inputData["Player ID"])
    local Player = QBCore.Functions.GetPlayer(playerId)
    local inv = Config.Inventory
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
    if not (inv == "qb" or inv == "ox" or inv == "lj") then 
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" then
        exports[inv.."-inventory"]:ClearInventory(playerId, nil)
    elseif inv == "ox" then
        exports.ox_inventory:ClearInventory(playerId, nil)
    end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'Error', 7500) end
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
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'Error', 7500) end
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
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'Error', 7500) end

end)