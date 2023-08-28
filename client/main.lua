QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

-- Functions
local function Setup()
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

-- Commands 
RegisterCommand("admin", function()
	ToggleUI(true)
end, false)

-- Close UI Event 
RegisterNetEvent('ps-adminmenu:client:CloseUI', function()
    ToggleUI(false)
end)