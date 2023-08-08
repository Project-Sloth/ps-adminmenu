QBCore = exports['qb-core']:GetCoreObject()
local hasPerms = nil

local function toggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

RegisterNetEvent('ps-adminmenu:client:openmenu', function()
    toggleUI(true)
	SendNUIMessage({
		action = "setActionData",
		data = Config.Actions
	})
	TriggerServerEvent("ps-adminmenu:server:Getresources")

    lib.callback('ps-adminmenu:server:GetPlayers', false, function(Players)
        SendNUIMessage({
            action = "setPlayersData",
            data = Players
        }) 
    end)
end)

RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)


RegisterNUICallback("normalButton", function(data, cb)
    local event = data.event
    local type = data.type
    local inputData = data.data
    local buttonlable = data.button
    local perms = data.perms
    lib.callback('ps-adminmenu:server:hasPerms', false, function(permission)
        hasPerms = permission
    end, perms)
    Wait(50)
    print("Event: " .. event .. " Type: " .. type .. " Perms: " .. perms, "Has Perms: ", hasPerms)
    if event and type then
        if hasPerms then
            if type == "client" then
                TriggerEvent(event, inputData, buttonlable)
            elseif type == "server" then
                TriggerServerEvent(event, inputData, buttonlable)
            elseif type == "command" then
                ExecuteCommand(event, inputData, buttonlable)
            end
        else
            print("no perms")
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

-- Chat Backend
RegisterNUICallback("GetMessages", function(data, cb)
	local data = lib.callback.await('ps-adminmenu:callback:GetMessages', false)
	SendNUIMessage({
		action = "setMessages",
		data = data
	})
end)

RegisterNUICallback("SendMessage", function(data, cb)
	local Player = QBCore.Functions.GetPlayerData()
	local message = data.message
	print(message, Player.citizenid, Player.charinfo.firstname .. " " .. Player.charinfo.lastname )
	-- print(dump(Player))
	TriggerServerEvent("ps-adminmenu:server:sendMessageServer", message, Player.citizenid, Player.charinfo.firstname .. " " .. Player.charinfo.lastname)

	local data = lib.callback.await('ps-adminmenu:callback:GetMessages', false)
	SendNUIMessage({
		action = "setMessages",
		data = data
	})
end)

-- Metrics Backend
RegisterNUICallback("GetMetrics", function(data, cb)
    local data = lib.callback('ps-adminmenu:server:getServerMetrics', false)
    SendNUIMessage({
        action = "setMetrics",
        data = data
    }) 
    print(json.encode(data))
end)