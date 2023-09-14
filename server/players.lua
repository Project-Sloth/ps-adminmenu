local savedPlayers = {}
local function getVehicles(cid)
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

local function getPlayers()
    local players = {}
    local GetPlayers = QBCore.Functions.GetQBPlayers()

    for k, v in pairs(GetPlayers) do
        local playerData = v.PlayerData
        local vehicles = getVehicles(playerData.citizenid)

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

RegisterServerEvent('ps-adminmenu:server:preparePlayers', function()
    savedPlayers = {}
    savedPlayers = getPlayers()
end)

lib.callback.register('ps-adminmenu:callback:GetPlayers', function(source) 
    return savedPlayers
end)