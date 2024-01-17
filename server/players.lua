local function getVehicles(cid)
    local vehicles = {}
        local result = MySQL.prepare.await('SELECT `vehicle`, `plate` FROM `owned_vehicles` WHERE `owner` = ?', { cid })
        for k, v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            if vehicle.model then
                vehicles[#vehicles + 1] = {
                    id = k,
                    cid = cid,
                    label = vehicle.model or "unknown",
                    brand = vehicle.brand or "unknown",
                    model = vehicle.model or "unknown",
                    plate = vehicle.plate or "unknown",
                    fuel = vehicle.fuelLevel or "unknown",
                    engine = vehicle.engineHealth or "unknown",
                    body = vehicle.bodyHealth or "unknown"
                }
            end
        end
    return vehicles
end

local function getPlayers()
    local players = {}
    local xPlayers = ESX.GetExtendedPlayers()

    for _,xPlayer in pairs(xPlayers) do
        local vehicles = getVehicles(xPlayer.identifier)

        players[#players + 1] = {
            id = xPlayer.source,
            name = xPlayer.getName(),
            cid = xPlayer.identifier,
            license = getMyIdentifier(xPlayer.source, 'license'),
            discord = getMyIdentifier(xPlayer.source, 'discord'),
            steam = getMyIdentifier(xPlayer.source, 'steam'),
            job = xPlayer.getJob().label,
            grade = xPlayer.getJob().grade,
            dob = "Unknown",
            cash = xPlayer.getAccount("money").money,
            bank = xPlayer.getAccount("bank").money,
            phone = "Unknown",
            vehicles = vehicles
        }
    end

    table.sort(players, function(a, b) return a.id < b.id end)

    return players
end

lib.callback.register('ps-adminmenu:callback:GetPlayers', function()
    return getPlayers()
end)

-- Set Job
RegisterNetEvent('ps-adminmenu:server:SetJob', function(_, selectedData)
    local src = source
    local playerId, Job, Grade = selectedData["Player"].value, selectedData["Job"].value, selectedData["Grade"].value
    local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
    if xPlayer then
        local targetIdentifier = xPlayer.identifier
        xPlayer.setJob(Job, Grade)
        MySQL.update('UPDATE `users` SET `job` = ?, `job_grade` = ? WHERE `identifier` = ?', {Job, Grade, targetIdentifier})
        local name = xPlayer.getName()
        TriggerClientEvent('esx:showNotification', src, _U("jobset", name, Job, Grade), 'success')
    end
end)

-- Set Perms
RegisterNetEvent("ps-adminmenu:server:SetPerms", function (data, selectedData)
    if not CheckPerms('superadmin') then return end
    local src = source
    local rank = selectedData["Permissions"].value
    local targetId = selectedData["Player"].value
    local tPlayer = ESX.GetPlayerFromId(tonumber(targetId))

    if not tPlayer then
        TriggerClientEvent('esx:showNotification', src, _U("not_online"), 'success')
        return
    end

    local name = tPlayer.getName()
    tPlayer.setGroup(tostring(rank))
    TriggerClientEvent('esx:showNotification', src, _U("player_perms", name, rank), 'success')
end)
