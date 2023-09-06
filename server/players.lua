local function GetVehicles(cid)
    local result = MySQL.query.await('SELECT vehicle, plate, fuel, engine, body FROM player_vehicles WHERE citizenid = ?', { cid })
    local vehicles = {}

    for k, v in pairs(result) do
        local vehicleData = QBCore.Shared.Vehicles[v.vehicle]

        if vehicleData then
            vehicles[#vehicles + 1] = {
                id = k,
                cid = cid,
                label = vehicleData.name,
                brand = vehicleData.brand,
                model = vehicleData.model,
                plate = v.plate,
                fuel = v.fuel,
                engine = v.engine,
                body = v.body
            }
        end
    end

    return vehicles
end

local function GetPlayers()
    local players = {}
    local GetPlayers = QBCore.Functions.GetQBPlayers()

    for k, v in pairs(GetPlayers) do
        local playerData = v.PlayerData
        local vehicles = GetVehicles(playerData.citizenid)

        players[#players + 1] = {
            id = k,
            name = playerData.charinfo.firstname..' '..playerData.charinfo.lastname,
            cid = playerData.citizenid,
            license = QBCore.Functions.GetIdentifier(k, 'license'),
            discord = QBCore.Functions.GetIdentifier(k, 'discord'),
            steam = QBCore.Functions.GetIdentifier(k, 'steam'),
            job = playerData.job.label..' - '..playerData.job.grade.name,
            dob = playerData.charinfo.birthdate,
            cash = playerData.money.cash,
            bank = playerData.money.bank,
            phone = playerData.charinfo.phone,
            vehicles = vehicles
        }
    end

    table.sort(players, function(a, b) return a.id < b.id end)

    return players
end

lib.callback.register('ps-adminmenu:callback:GetPlayers', function(source)
    local players = GetPlayers()
    return players
end)

-- toggle namens and blips
local players = {}

RegisterNetEvent('ps-adminmenu:server:GetPlayersForBlips', function()
    local src = source
    TriggerClientEvent('ps-adminmenu:client:Show', src, players)
end)

-- Warn Player
RegisterNetEvent('ps-adminmenu:server:warnplayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local targetPlayer = QBCore.Functions.GetPlayer(selectedData["Player"].value)
    local msg = selectedData["Reason"].value
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    local warnId = 'WARN-' .. math.random(1111, 9999)
    if targetPlayer ~= nil then
        TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, {args = {"SYSTEM", locale("warning_chat_message") .. GetPlayerName(source) .. "," .. locale("reason") .. ": " .. msg}, color = 255, 0, 0})
        TriggerClientEvent('chat:addMessage', source, {args = {"SYSTEM", locale("warning_staff_message") .. GetPlayerName(targetPlayer.PlayerData.source) .. ", for: " .. msg}, color = 255, 0, 0})
        MySQL.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, locale("not_online"), 'error')
    end
end)