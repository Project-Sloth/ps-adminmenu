QBCore = exports['qb-core']:GetCoreObject()

-- Admin Car
RegisterNetEvent('ps-adminmenu:client:Admincar', function(data)
	print("AdminCarTriggerd")
end)

-- Invisible
RegisterNetEvent('ps-adminmenu:client:ToggleInvisible', function(data)
    local ped = PlayerPedId()
    if not invisible then
        invisible = true
        SetEntityVisible(ped, false, 0)
    else
        invisible = false
        SetEntityVisible(ped, true, 0)
    end
end)

-- Ban
RegisterNetEvent('ps-adminmenu:client:banplayer', function(inputData)
    local playerid = inputData["Player ID"]
    local reason = inputData["Reason"]
    local time = inputData["Time"]
    if playerid and reason and time then
        print("ID: " .. playerid)
        print("Reason: " .. reason)
        print("Time: " .. time)
    end
end)