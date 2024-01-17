local messages = {}

-- Staff Chat
RegisterNetEvent('ps-adminmenu:server:sendMessageServer', function(message, citizenid, fullname)
    if not CheckPerms('admin') then return end

    local time = os.time() * 1000
    TriggerClientEvent('chat:addMessage', -1, _U("new_staffchat", 'inform', 7500))
    messages[#messages + 1] = { message = message, citizenid = citizenid, fullname = fullname, time = time }
end)


lib.callback.register('ps-adminmenu:callback:GetMessages', function()
    if not CheckPerms('admin') then return {} end
    return messages
end)
