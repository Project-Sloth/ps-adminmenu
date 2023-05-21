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
	TriggerServerEvent("ps-adminmenu:client:Getresources")
end, false)

RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)

RegisterNUICallback("normalButton", function(data, cb)
    local event = data.event
    local type = data.type
    local inputData = data.data

    if event and inputData and type then
        if type == "client" then
            TriggerEvent(event, inputData)
        elseif type == "server" then
            TriggerServerEvent(event, inputData)
        elseif type == "command" then
            ExecuteCommand(event, inputData)
        end
    elseif event and type then
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


RegisterNetEvent('ps-adminmenu:client:UpdateResources', function(data)
    --print("Done")
    SendNUIMessage({
        action = "setResourceData", 
        data = data
    })
    --print("Done")
end)

RegisterNUICallback("RefreshResources", function(data, cb)
	TriggerServerEvent("ps-adminmenu:client:Getresources")
end)

RegisterNUICallback("ChangeResourcesState", function(data, cb)
	local name = data.name
	local state = data.state
	TriggerServerEvent("ps-adminmenu:server:changeResourceState", name, state)
	Wait(500)
	TriggerServerEvent("ps-adminmenu:client:Getresources")
	cb("ok")
end)
