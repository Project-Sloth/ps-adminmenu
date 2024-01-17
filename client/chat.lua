local function getMessagesCallBack()
	return lib.callback.await('ps-adminmenu:callback:GetMessages', false)
end

RegisterNUICallback("GetMessages", function(_, cb)
	local data = getMessagesCallBack()
	if next(data) then
		SendNUIMessage({
			action = "setMessages",
			data = data
		})
	end
	cb(1)
end)

RegisterNUICallback("SendMessage", function(msgData, cb)
	local message = msgData.message
	print(message, PlayerData.identifier, PlayerData.firstName .. " " .. PlayerData.lastName )

	TriggerServerEvent("ps-adminmenu:server:sendMessageServer", message, PlayerData.identifier, PlayerData.firstName .. " " .. PlayerData.lastName)

	local data = getMessagesCallBack()
	SendNUIMessage({
		action = "setMessages",
		data = data
	})
	cb(1)
end)
