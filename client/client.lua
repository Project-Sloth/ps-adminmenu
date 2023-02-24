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
    cb({})
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

-- Developer Mode
RegisterNUICallback('ToggleDevMode', function(_, cb)
    cb({})
    TriggerEvent('qb-admin:client:ToggleDevmode')
end)

-- Debug Mode
RegisterNUICallback('ToggleDebugMode', function(_, cb)
    cb({})
    print("^5Debug^7: ^7Theme Changed")
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
    TriggerServerEvent('ps-adminmenu:server:updateResourceList')
    cb(1)
end)

RegisterNetEvent('ps-adminmenu:client:updateResourceList', function(resources)
    print('Updating Resource List Event')
    SendNUIMessage({
        action = "updateResourceList",
        data = {
            resources = resources,
        }
    })
end)

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
    print('Updating Resource List')
    TriggerServerEvent('ps-adminmenu:server:updateResourceList')
   end
end)