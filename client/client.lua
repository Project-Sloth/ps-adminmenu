QBCore = exports['qb-core']:GetCoreObject()

local function toggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

RegisterCommand("admin", function()
	toggleUI(true)
	SendNUIMessage({
		action = "setActionData",
		data = Config.Actions
	})
end, false)

RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)

RegisterNetEvent('ps-adminmenu:client:Admincar', function(data)
	print("AdminCarTriggerd")
end)

RegisterNUICallback("normalButton", function(data, cb) 
    local event = data.event 
    local type = data.type
	if event and type then 
		if type == "client" then 
			TriggerEvent(event)
		elseif type == "server" then 
			TriggerServerEvent(event)
		elseif type == "command" then 
			ExecuteCommand(event)
		end
	end
    cb("ok")
end)