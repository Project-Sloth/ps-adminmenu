-- Admin Car
RegisterNetEvent('ps-adminmenu:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })

    if result[1] == nil then
        MySQL.insert(
        'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)',
            {
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

-- Give Car
RegisterNetEvent("ps-adminmenu:server:givecar", function(data, selectedData)
    local src = source

    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then
        QBCore.Functions.Notify(src, locale("no_perms"), "error", 5000)
        return
    end

    local vehmodel = selectedData['Vehicle'].value
    local vehicleData = lib.callback.await("ps-adminmenu:client:getvehData", src, vehmodel)

    if not next(vehicleData) then
        return
    end

    local tsrc = selectedData['Player'].value
    local plate = selectedData['Plate (Optional)'] and selectedData['Plate (Optional)'].value or vehicleData.plate
    local garage = selectedData['Garage (Optional)'] and selectedData['Garage (Optional)'].value or Config.DefaultGarage
    local Player = QBCore.Functions.GetPlayer(tsrc)

    if plate and #plate < 1 then
        plate = vehicleData.plate
    end

    if garage and #garage < 1 then
        garage = Config.DefaultGarage
    end

    if plate:len() > 8 then
        QBCore.Functions.Notify(src, locale("plate_max"), "error", 5000)
        return
    end

    if not Player then
        QBCore.Functions.Notify(src, locale("not_online"), "error", 5000)
        return
    end

    if CheckAlreadyPlate(plate) then
        QBCore.Functions.Notify(src, locale("givecar.error.plates_alreadyused", plate:upper()), "error", 5000)
        return
    end

    MySQL.insert(
    'INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehmodel,
            joaat(vehmodel),
            json.encode(vehicleData),
            plate,
            garage,
            1
        })

    QBCore.Functions.Notify(src,
        locale("givecar.success.source", QBCore.Shared.Vehicles[vehmodel].name,
            ("%s %s"):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname)), "success", 5000)
    QBCore.Functions.Notify(Player.PlayerData.source, locale("givecar.success.target", plate:upper(), garage), "success",
        5000)
end)

-- Give Car
RegisterNetEvent("ps-adminmenu:server:SetVehicleState", function(data, selectedData)
    local src = source

    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then
        QBCore.Functions.Notify(src, locale("no_perms"), "error", 5000)
        return
    end

    local plate = string.upper(selectedData['Plate'].value)
    local state = tonumber(selectedData['State'].value)

    if plate:len() > 8 then
        QBCore.Functions.Notify(src, locale("plate_max"), "error", 5000)
        return
    end

    if not CheckAlreadyPlate(plate) then
        QBCore.Functions.Notify(src, locale("plate_doesnt_exist"), "error", 5000)
        return
    end

    MySQL.update('UPDATE player_vehicles SET state = ?, depotprice = ? WHERE plate = ?', { state, 0, plate })

    QBCore.Functions.Notify(src, locale("state_changed"), "success", 5000)
end)

-- Change Plate
RegisterNetEvent('ps-adminmenu:server:ChangePlate', function(newPlate, currentPlate)
    local newPlate = newPlate:upper()

    if Config.Inventory == 'ox_inventory' then
        exports.ox_inventory:UpdateVehicle(currentPlate, newPlate)
    end

    MySQL.Sync.execute('UPDATE player_vehicles SET plate = ? WHERE plate = ?', { newPlate, currentPlate })
    MySQL.Sync.execute('UPDATE trunkitems SET plate = ? WHERE plate = ?', { newPlate, currentPlate })
    MySQL.Sync.execute('UPDATE gloveboxitems SET plate = ? WHERE plate = ?', { newPlate, currentPlate })
end)

lib.callback.register('ps-adminmenu:server:GetVehicleByPlate', function(source, plate)
    local result = MySQL.query.await('SELECT vehicle FROM player_vehicles WHERE plate = ?', { plate })
    local veh = result[1] and result[1].vehicle or {}
    return veh
end)

-- Fix Vehicle for player
RegisterNetEvent('ps-adminmenu:server:FixVehFor', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end
    local src = source
    local playerId = selectedData['Player'].value
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player then
        local name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
        TriggerClientEvent('iens:repaira', Player.PlayerData.source)
        TriggerClientEvent('vehiclemod:client:fixEverything', Player.PlayerData.source)
        QBCore.Functions.Notify(src, locale("veh_fixed", name), 'success', 7500)
    else
        TriggerClientEvent('QBCore:Notify', src, locale("not_online"), "error")
    end
end)
