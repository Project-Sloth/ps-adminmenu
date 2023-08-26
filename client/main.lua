QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

-- Functions
local function Setup()
	Wait(1000)
	PlayerData = QBCore.Functions.GetPlayerData()
	local resources = lib.callback.await('ps-adminmenu:callback:GetResources', false)

	SendNUIMessage({
		action = "setupUI",
		data = {
			actions = Config.Actions,
			resources = resources,
			playerData = PlayerData,
		}
	})

	TriggerEvent("ps-adminmenu:client:printData")
end

-- Event Handlers
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	Setup()
end)

AddEventHandler("onResourceStart", function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		Setup()
	end
end)

-- NUICallbacks
RegisterNUICallback("hideUI", function()
	ToggleUI(false)
end)

RegisterNUICallback("clickButton", function(data)
	if data.type == "client" then
		TriggerEvent(data.event, data.perms)
	elseif data.type == "server" then
		TriggerServerEvent(data.event)
	elseif data.type == "command" then
		ExecuteCommand(data.event)
	end
end)

RegisterNUICallback("setResourceState", function(data, cb)
	local resources = lib.callback.await('ps-adminmenu:callback:ChangeResourceState', false, data)
	cb(resources)
end)

RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('ps-adminmenu:callback:GetPlayers', false)
	cb(players)
end)

-- Commands 
RegisterCommand("admin", function()
	ToggleUI(true)
end, false)
