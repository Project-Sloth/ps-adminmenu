local messages = {}

-- Staff Chat
RegisterNetEvent('ps-adminmenu:server:sendMessageServer', function(message, citizenid, fullname)
    if not CheckPerms('mod') then return end

    local time = os.time() * 1000
    local players = QBCore.Functions.GetPlayers()

    for i = 1, #players, 1 do
        local player = players[i]
            if QBCore.Functions.IsOptin(player) then
                QBCore.Functions.Notify(player, locale("new_staffchat", 'inform', 7500))
            end
        end

    messages[#messages + 1] = { message = message, citizenid = citizenid, fullname = fullname, time = time }
end)


lib.callback.register('ps-adminmenu:callback:GetMessages', function()
    if not CheckPerms('mod') then return {} end
    return messages
end)
