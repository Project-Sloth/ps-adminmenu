QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('report', function()
    SendNUIMessage({
        action = 'setReportVisible',
        data = true
    })
    SetNuiFocus(true, true)
end)

RegisterCommand('menu', function()
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback('hideUI', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
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
    TriggerServerEvent("ok1ez-adminmenu:server:ban", player, reason, time)
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
    TriggerServerEvent('ok1ez-adminmenu:server:updateResourceList')
    cb(1)
end)

RegisterNetEvent('ok1ez-adminmenu:client:updateResourceList', function(resources)
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
    TriggerServerEvent('ok1ez-adminmenu:server:updateResourceList')
   end
end)