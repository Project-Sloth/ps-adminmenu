-- Recive data from ui and trigger the event and etc
RegisterNUICallback("clickButton", function(data)
	local selectedData = data.selectedData
	local data = data.data

	if not CheckPerms(data.perms) then return end

	if data.type == "client" then
		TriggerEvent(data.event, data, selectedData)
	elseif data.type == "server" then
		TriggerServerEvent(data.event, data, selectedData)
	elseif data.type == "command" then
		ExecuteCommand(data.event)
	end
end)

-- Change resource state
RegisterNUICallback("setResourceState", function(data, cb)
	local resources = lib.callback.await('ps-adminmenu:callback:ChangeResourceState', false, data)
	cb(resources)
end)

-- Get players
RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('ps-adminmenu:callback:GetPlayers', false)
	cb(players)
end)
