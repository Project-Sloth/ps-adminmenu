QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

-- Functions
local function setupMenu()
	Wait(500)
	PlayerData = QBCore.Functions.GetPlayerData()
	local resources = lib.callback.await('ps-adminmenu:callback:GetResources', false)
	GetData()
	SendNUIMessage({
		action = "setupUI",
		data = {
			actions = Config.Actions,
			resources = resources,
			playerData = PlayerData,
		}
	})
end

-- Event Handlers
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	setupMenu()
end)

AddEventHandler("onResourceStart", function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		setupMenu()
	end
end)

-- NUICallbacks
RegisterNUICallback("hideUI", function()
	ToggleUI(false)
end)

--- @param data table
RegisterNUICallback("clickButton", function(data)
	local selectedData = data.selectedData
	local data = data.data
	print(json.encode(selectedData))
	if not CheckPerms(data.perms) then return end

	if data.type == "client" then
		TriggerEvent(data.event, data, selectedData)
	elseif data.type == "server" then
		TriggerServerEvent(data.event, data, selectedData)
	elseif data.type == "command" then
		ExecuteCommand(data.event)
	end

	Log("Action Used", PlayerData.name .. " (" .. PlayerData.citizenid .. ") - Used: " .. data.label .. (selectedData and (" with args: " .. json.encode(selectedData)) or ""))
end)

-- Commands
RegisterCommand("admin", function()
    if CheckPerms(Config.ResourcePerms) then
        ToggleUI(true)
    end
end, false)

-- Close UI Event
RegisterNetEvent('ps-adminmenu:client:CloseUI', function()
    ToggleUI(false)
end)

-- Change resource state
RegisterNUICallback("setResourceState", function(data, cb)
	local resources = lib.callback.await('ps-adminmenu:callback:ChangeResourceState', false, data)
	cb(resources)
end)

-- Get players
RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('ps-adminmenu:callback:GetPlayers', false)
	print(json.encode(players))
    cb(players)
end)
