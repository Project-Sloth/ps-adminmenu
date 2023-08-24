QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

-- Functions
local function toggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

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
	print(json.encode(Config.Actions))
	print(json.encode(resources))

	print("ADMIN MENU: LOADED")
end

RegisterCommand("admin", function()
	toggleUI(true)
end, false)

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
	toggleUI(false)
end)

RegisterNUICallback("setResourceState", function(data, cb)
	print(json.encode(data))
	local resources = lib.callback.await('ps-adminmenu:callback:ChangeResourceState', false, data)
	cb(resources)
end)

RegisterNUICallback("clickButton", function(data)
	print(json.encode(data))
end)

RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('ps-adminmenu:callback:GetPlayers', false)
	cb(players)
end)