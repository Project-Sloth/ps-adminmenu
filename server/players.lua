local function getVehicles(cid)
    local result = MySQL.query.await(
    'SELECT vehicle, plate, fuel, engine, body FROM player_vehicles WHERE citizenid = ?', { cid })
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

local function getPlayers()
    local players = {}
    local GetPlayers = QBCore.Functions.GetQBPlayers()

    for k, v in pairs(GetPlayers) do
        local playerData = v.PlayerData
        local vehicles = getVehicles(playerData.citizenid)

        players[#players + 1] = {
            id = k,
            name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
            cid = playerData.citizenid,
            license = QBCore.Functions.GetIdentifier(k, 'license'),
            discord = QBCore.Functions.GetIdentifier(k, 'discord'),
            steam = QBCore.Functions.GetIdentifier(k, 'steam'),
            job = playerData.job.label,
            grade = playerData.job.grade.level,
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
    return getPlayers()
end)

-- Set Job
RegisterNetEvent('ps-adminmenu:server:SetJob', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local playerId, Job, Grade = selectedData["Player"].value, selectedData["Job"].value, selectedData["Grade"].value
    local Player = QBCore.Functions.GetPlayer(playerId)
    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local jobInfo = QBCore.Shared.Jobs[Job]
    local grade = jobInfo["grades"][selectedData["Grade"].value]

    if not jobInfo then
        TriggerClientEvent('QBCore:Notify', source, "Not a valid job", 'error')
        return
    end

    if not grade then
        TriggerClientEvent('QBCore:Notify', source, "Not a valid grade", 'error')
        return
    end

    Player.Functions.SetJob(tostring(Job), tonumber(Grade))
    if Config.RenewedPhone then
        exports['qb-phone']:hireUser(tostring(Job), Player.PlayerData.citizenid, tonumber(Grade))
    end

    QBCore.Functions.Notify(src, locale("jobset", name, Job, Grade), 'success', 5000)
end)

-- Set Gang
RegisterNetEvent('ps-adminmenu:server:SetGang', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local playerId, Gang, Grade = selectedData["Player"].value, selectedData["Gang"].value, selectedData["Grade"].value
    local Player = QBCore.Functions.GetPlayer(playerId)
    local name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    local GangInfo = QBCore.Shared.Gangs[Gang]
    local grade = GangInfo["grades"][selectedData["Grade"].value]

    if not GangInfo then
        TriggerClientEvent('QBCore:Notify', source, "Not a valid Gang", 'error')
        return
    end

    if not grade then
        TriggerClientEvent('QBCore:Notify', source, "Not a valid grade", 'error')
        return
    end

    Player.Functions.SetGang(tostring(Gang), tonumber(Grade))
    QBCore.Functions.Notify(src, locale("gangset", name, Gang, Grade), 'success', 5000)
end)

-- Set Perms
RegisterNetEvent("ps-adminmenu:server:SetPerms", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local rank = selectedData["Permissions"].value
    local targetId = selectedData["Player"].value
    local tPlayer = QBCore.Functions.GetPlayer(tonumber(targetId))

    if not tPlayer then
        QBCore.Functions.Notify(src, locale("not_online"), "error", 5000)
        return
    end

    local name = tPlayer.PlayerData.charinfo.firstname .. ' ' .. tPlayer.PlayerData.charinfo.lastname

    QBCore.Functions.AddPermission(tPlayer.PlayerData.source, tostring(rank))
    QBCore.Functions.Notify(tPlayer.PlayerData.source, locale("player_perms", name, rank), 'success', 5000)
end)

-- Remove Stress
RegisterNetEvent("ps-adminmenu:server:RemoveStress", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local targetId = selectedData['Player (Optional)'] and tonumber(selectedData['Player (Optional)'].value) or src
    local tPlayer = QBCore.Functions.GetPlayer(tonumber(targetId))

    if not tPlayer then
        QBCore.Functions.Notify(src, locale("not_online"), "error", 5000)
        return
    end

    TriggerClientEvent('ps-adminmenu:client:removeStress', targetId)

    QBCore.Functions.Notify(tPlayer.PlayerData.source, locale("removed_stress_player"), 'success', 5000)
end)
