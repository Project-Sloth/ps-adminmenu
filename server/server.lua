QBCore = exports['qb-core']:GetCoreObject()

local function NoPerms(source)
    QBCore.Functions.Notify(source, Lang:t('error.no_perms'), 'error')
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
--admincar
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

--ban player
RegisterNetEvent('ps-adminmenu:server:banplayer', function(player, time, reason)
    local src = source
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
    time = tonumber(time)
    print("tet")
    local banTime = tonumber(os.time() + time)
    if banTime > 2147483647 then
        banTime = 2147483647
    end
    local timeTable = os.date('*t', banTime)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(player.id),
        QBCore.Functions.GetIdentifier(player.id, 'license'),
        QBCore.Functions.GetIdentifier(player.id, 'discord'),
        QBCore.Functions.GetIdentifier(player.id, 'ip'),
        reason,
        banTime,
        GetPlayerName(src)
    })
    if banTime >= 2147483647 then
        DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. QBCore.Config.Server.Discord)
    else
        DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.Discord)
    end

end)

-- bring player
RegisterNetEvent('ps-adminmenu:server:BringPlayer', function(inputData)
    local src = source
    local targetPed = inputData["Player ID"]

    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(targetPed)
    SetEntityCoords(target, coords)

end)

-- teleport to player
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

-- teleport to coords
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

-- heal player
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

-- heal all players
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function()
    local src = source
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
    TriggerClientEvent('hospital:client:Revive', -1)
end)
