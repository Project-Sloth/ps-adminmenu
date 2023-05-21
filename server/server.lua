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

RegisterNetEvent('ps-adminmenu:server:testserver', function(data)
    print("server")
end)