lib.callback.register('ps-adminmenu:callback:GetPlayers', function(source)
    local players = {}
    local GetPlayers = QBCore.Functions.GetQBPlayers()

    for k, v in pairs(GetPlayers) do
        local playerData = v.PlayerData

        players[#players + 1] = {
            id = k,
            name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
            cid = playerData.citizenid,
            license = QBCore.Functions.GetIdentifier(k, 'license'),
            discord = QBCore.Functions.GetIdentifier(k, 'discord'),
            steam = QBCore.Functions.GetIdentifier(k, 'steam'),
            job = playerData.job.label .. ' - ' .. playerData.job.grade.name,
            dob = playerData.charinfo.birthdate,
            cash = playerData.money.cash,
            bank = playerData.money.bank,
            phone = playerData.charinfo.phone
        }

    end

    table.sort(players, function(a, b) return a.id < b.id end)

    return players
end)
