local function GetVehicles(cid)
    local result = MySQL.query.await(
    'SELECT vehicle, plate, fuel, engine, body FROM player_vehicles WHERE citizenid = ?', { cid })
    local Vehicles = {}

    for k, v in pairs(result) do
        local vehicleData = QBCore.Shared.Vehicles[v.vehicle]
        if vehicleData then
            Vehicles[#Vehicles + 1] = {
                id = k,
                cid = cid,
                label = vehicleData["brand"] .. " | " .. vehicleData["name"] .. " | " .. v.plate,
                brand = vehicleData["brand"],
                model = vehicleData["model"],
                plate = v.plate,
                fuel = v.fuel,
                engine = v.engine,
                body = v.body
            }
        end
    end

    table.sort(Vehicles, function(a, b)
        return a.label < b.label
    end)

    return Vehicles
end

local function GetPlayers()
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
end

local function GetCombinedData()
    local combinedData = {}
    local players = GetPlayers()

    for _, player in pairs(players) do
        local vehicles = GetVehicles(player.cid)

        if #vehicles > 0 then
            combinedData[#combinedData + 1] = {
                player = player,
                vehicles = vehicles
            }
        end
    end

    return combinedData
end

lib.callback.register('ps-adminmenu:callback:GetPlayers', function(source)
    local players = GetCombinedData()

    return players
end)
