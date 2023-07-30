QBCore = exports['qb-core']:GetCoreObject()


local function toggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end


-- RegisterCommand("admin", function()
-- 	toggleUI(true)
-- 	SendNUIMessage({
-- 		action = "setActionData",
-- 		data = Config.Actions
-- 	})
-- 	TriggerServerEvent("ps-adminmenu:server:Getresources")

--     QBCore.Functions.TriggerCallback('ps-adminmenu:server:GetPlayers', function(Players)
--         SendNUIMessage({
--             action = "setPlayersData",
--             data = Players
--         })

--     end)


-- end, true) -- add_ace group.mod command.admin allow

RegisterNetEvent('ps-adminmenu:client:openmenu', function()
    toggleUI(true)
	SendNUIMessage({
		action = "setActionData",
		data = Config.Actions
	})
	TriggerServerEvent("ps-adminmenu:server:Getresources")

    QBCore.Functions.TriggerCallback('ps-adminmenu:server:GetPlayers', function(Players)
        SendNUIMessage({
            action = "setPlayersData",
            data = Players
        })

    end)
    QBCore.Functions.TriggerCallback('ps-adminmenu:server:GetPersonalVehicles', function(Vehicles)
        SendNUIMessage({
            action = "setPersonalVehicles",
            data = Vehicles
        })

    end)
end)

-- RegisterKeyMapping('admin', 'Open Adminmenu', 'keyboard', 'U') -- https://docs.fivem.net/docs/game-references/controls/


RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)


RegisterNUICallback("normalButton", function(data, cb)
    local event = data.event
    local type = data.type
    local inputData = data.data
    local buttonlable = data.button

    print("Event: "..event.." Type: "..type)
    if event and type then
        if type == "client" then
            TriggerEvent(event, inputData, buttonlable)
        elseif type == "server" then
            TriggerServerEvent(event, inputData, buttonlable)
        elseif type == "command" then
            ExecuteCommand(event, inputData,buttonlable)
        end
    end
    cb("ok")
end)


RegisterNetEvent('ps-adminmenu:client:UpdateResources', function(data)
    SendNUIMessage({
        action = "setResourceData", 
        data = data
    })
end)


RegisterNetEvent('ps-adminmenu:client:CloseUI', function()
    toggleUI(false)
end)


RegisterNUICallback("RefreshResources", function(data, cb)
	TriggerServerEvent("ps-adminmenu:server:Getresources")
end)


RegisterNUICallback("ChangeResourcesState", function(data, cb)
	local name = data.name
	local state = data.state
	TriggerServerEvent("ps-adminmenu:server:changeResourceState", name, state)
	Wait(500)
	TriggerServerEvent("ps-adminmenu:server:Getresources")
	cb("ok")
end)