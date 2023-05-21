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

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(inputData)
    local stash = inputData["Stash"]
    if not Config.UseOXInventory then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    else 
        print("ox_inv")
    end
end)

-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(inputData)
    local playerid = inputData["Player ID"]
    if not Config.UseOXInventory then
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerid)
    else 
        print("ox_inv")
    end
end)

-- Mute Player
RegisterNetEvent('ps-adminmenu:client:MutePlayer', function(inputData)
    local playerid = inputData["Player ID"]
    exports['pma-voice']:toggleMutePlayer(playerid)
end)
