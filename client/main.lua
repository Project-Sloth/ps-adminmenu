QBCore = exports['qb-core']:GetCoreObject()

-- Toggle UI stuff
local function toggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
    QBCore.Functions.TriggerCallback('ps-adminmenu:server:GetPlayers', function(playerIds)
        SendNUIMessage({
            type = 'updatePlayers',
            playerIds = playerIds,
          });
    end)
end

RegisterCommand("admin", function()
	toggleUI(true)
end, false)

RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)

--Report
local function toggleReport(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisibleReport",
		data = bool
	})
end
RegisterCommand("report", function()
	toggleReport(true)
end, false)

RegisterNUICallback("hideReport", function()
    toggleReport(false)
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
    TriggerEvent('qb-admin:client:ToggleDevmode')
end)

-- Ban Player
RegisterNUICallback('BanPlayer', function(inputs, cb)
    local player = tonumber(inputs.player)
    local reason = tostring(inputs.reason)
    local time = tonumber(inputs.time)
    TriggerServerEvent("ps-adminmenu:server:ban", player, reason, time)
    print(player, reason, time)
end)

-- Gives Clothing Menu
RegisterNUICallback('ToggleClothing', function(_, cb)
    TriggerEvent("illenium-appearance:client:openClothingShopMenu")
end)

-- Open Inventory
RegisterNUICallback('OpenPlayerInv', function(inputs, cb)
    local player = tonumber(inputs.player)
    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", player)
    print("opened inv",player)
end)

-- Godmode
local godmode = false
RegisterNUICallback('ToggleGodMode', function(_, cb)
    godmode = not godmode
    if godmode then 
        QBCore.Functions.Notify('God Mode Enabled', 'success', 5000)
    else
        QBCore.Functions.Notify('God Mode Disabled', 'error', 5000)
    end
    if godmode then
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)


-- Resources
RegisterNUICallback('UpdateResourceList', function(data, cb)
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

RegisterNUICallback("getPlayers", function(data, cb)
    QBCore.Functions.TriggerCallback('ps-adminmenu:server:GetPlayers', function(players)
        local playerIds = {}
        for _, player in ipairs(players) do
            local playerData = {}
            playerData.id = player.id
            playerData.name = player.name
            table.insert(playerIds, playerData)
        end
        cb(playerIds)
    end)
end)
