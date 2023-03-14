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
RegisterNUICallback('BanPlayer', function(inputs, cb)
    print(json.encode(inputs))
    local player = tonumber(inputs.player)
    local reason = tostring(inputs.reason)
    local time = tonumber(inputs.time)
    print(player, reason, time)
    TriggerServerEvent("ps-adminmenu:server:ban", player, reason, time)
    print(player, reason, time)
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


