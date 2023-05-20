QBCore = exports['qb-core']:GetCoreObject()

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


RegisterNetEvent('ps-adminmenu:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
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
    else
        BanPlayer(src)
    end
end)
