-- Admin Car
RegisterNetEvent('ps-adminmenu:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})

    if result[1] == nil then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle.model,
            vehicle.hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, locale("veh_owner"), 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, locale("u_veh_owner"), 'error', 3000)
    end
end)

-- Change Plate
RegisterNetEvent('ps-adminmenu:server:ChangePlate', function(newPlate, currentPlate)
    local newPlate = newPlate:upper()

    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:UpdateVehicle(currentPlate, newPlate)
    end

    MySQL.Sync.execute('UPDATE player_vehicles SET plate = ? WHERE plate = ?', {newPlate, currentPlate})
    MySQL.Sync.execute('UPDATE trunkitems SET plate = ? WHERE plate = ?', {newPlate, currentPlate})
    MySQL.Sync.execute('UPDATE gloveboxitems SET plate = ? WHERE plate = ?', {newPlate, currentPlate})
end)

lib.callback.register('ps-adminmenu:server:GetVehicleByPlate', function(source, plate)
    local result = MySQL.query.await('SELECT vehicle FROM player_vehicles WHERE plate = ?', {plate})
    local veh = result[1] and result[1].vehicle or {}
    return veh
end)

-- Fix Vehicle for player
RegisterNetEvent('ps-adminmenu:server:FixVehFor', function(data, selectedData)
    if not CheckPerms(data.perms) then return end
    local src = source
    local playerId = selectedData['Player'].value
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player then
        TriggerClientEvent('iens:repaira', Player.PlayerData.source)
        TriggerClientEvent('vehiclemod:client:fixEverything', Player.PlayerData.source)
        QBCore.Functions.Notify(src, locale("fixed_veh", Player), 'success', 7500)

    else
        TriggerClientEvent('QBCore:Notify', src, locale("not_online"), "error")
    end
end)