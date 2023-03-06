QBCore = exports['qb-core']:GetCoreObject()

-- Toggle UI stuff
local function toggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

RegisterCommand("menu", function()
	toggleUI(true)
end, false)

RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)

-- Invisible
local invisible = false

RegisterNUICallback('ToggleInvis', function(_, cb)
    local ped = PlayerPedId()
    if not invisible then
        invisible = true
        SetEntityVisible(ped, false, 0)
    else
        invisible = false
        SetEntityVisible(ped, true, 0)
    end
end)



-- Developer Mode
RegisterNUICallback('ToggleDevMode', function(_, cb)
    cb({})
    TriggerEvent('qb-admin:client:ToggleDevmode')
end)

-- Ban Player
RegisterNUICallback('banPlayer', function(data, cb)
    local player = tonumber(data.player)
    local reason = tostring(data.reason)
    local time = tonumber(data.time)
    TriggerServerEvent("ps-adminmenu:server:ban", player, reason, time)
    -- Call the ban function and pass the ban details

    print(player, reason, time)
    -- Return a response to the client
    cb('ok')
end)

-- Gives Clothing Menu
RegisterNUICallback('ToggleClothing', function(_, cb)
    cb({})
    TriggerEvent("illenium-appearance:client:openClothingShopMenu")
end)

-- Resources
RegisterNUICallback('UpdateResourceList', function(data, cb)
    print('Updating Resource List')
    TriggerServerEvent('ps-adminmenu:server:updateResource')
    cb(1)
end)

RegisterNetEvent('ps-adminmenu:client:updateResources', function(resources)
    SendNUIMessage({
        action = "updateResourceList",
        data = {
            resources = resources,
        }
    })
end)

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
    TriggerServerEvent('ps-adminmenu:server:updateResource')
   end
end)


RegisterCommand("ps-players", function()
    QBCore.Functions.TriggerCallback('ps-adminmenu:getplayers', function(players)
        for _, v in pairs(players) do
            print("Player:", v)  
        end
        
    end)
end, false)

