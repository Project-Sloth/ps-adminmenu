local messages = {}

-- Staff Chat
RegisterNetEvent('ps-adminmenu:server:sendMessageServer', function(message, citizenid, fullname)
    local time = os.time() * 1000
    local players = QBCore.Functions.GetPlayers()

    for i = 1, #players, 1 do
        local player = players[i]
        if QBCore.Functions.HasPermission(player, 'mod') or IsPlayerAceAllowed(player, 'command') then
            if QBCore.Functions.IsOptin(player) then
                QBCore.Functions.Notify(player, Lang:t("info.new_staffchat", 'inform', 7500))
            end
        end
    end
    table.insert(messages, {message = message, citizenid = citizenid, fullname = fullname, time = time})
end)

lib.callback.register('ps-adminmenu:callback:GetMessages', function(source)
    return messages
end)