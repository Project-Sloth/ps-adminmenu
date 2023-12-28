local function GetVehicleName(hash)
    for _, v in pairs(QBCore.Shared.Vehicles) do
        if hash == v.hash then
            return v.model
        end
    end
end

-- Own Vehicle
RegisterNetEvent('ps-adminmenu:client:Admincar', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    if not cache.vehicle then return end

    local props = lib.getVehicleProperties(cache.vehicle)
    local name = GetVehicleName(props.model)
    local sharedVehicles = QBCore.Shared.Vehicles[name]
    local hash = GetHashKey(cache.vehicle)

    if sharedVehicles then
        TriggerServerEvent('ps-adminmenu:server:SaveCar', props, sharedVehicles, hash, props.plate)
    else
        QBCore.Functions.Notify(locale("cannot_store_veh"), 'error')
    end
end)

-- Spawn Vehicle
RegisterNetEvent('ps-adminmenu:client:SpawnVehicle', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local selectedVehicle = selectedData["Vehicle"].value
    local hash = GetHashKey(selectedVehicle)

    if not IsModelValid(hash) then return end

    lib.requestModel(hash)

    if cache.vehicle then
        DeleteVehicle(cache.vehicle)
    end

    local vehicle = CreateVehicle(hash, GetEntityCoords(cache.ped), GetEntityHeading(cache.ped), true, false)
    TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
    exports[Config.Fuel]:SetFuel(vehicle, 100.0)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
end)

-- Refuel Vehicle
RegisterNetEvent('ps-adminmenu:client:RefuelVehicle', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    if cache.vehicle then
        exports[Config.Fuel]:SetFuel(cache.vehicle, 100.0)
        QBCore.Functions.Notify(locale("refueled_vehicle"), 'success')
    else
        QBCore.Functions.Notify(locale("not_in_vehicle"), 'error')
    end
end)

-- Change plate
RegisterNetEvent('ps-adminmenu:client:ChangePlate', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local plate = selectedData["Plate"].value

    if string.len(plate) > 8 then
        return QBCore.Functions.Notify(locale("plate_max"), "error", 5000)
    end

    if cache.vehicle then
        local AlreadyPlate = lib.callback.await("ps-adminmenu:callback:CheckAlreadyPlate", false, plate)

        if AlreadyPlate then
            QBCore.Functions.Notify(locale("already_plate"), "error", 5000)
            return
        end

        local currentPlate = GetVehicleNumberPlateText(cache.vehicle)
        TriggerServerEvent('ps-adminmenu:server:ChangePlate', plate, currentPlate)
        Wait(100)
        SetVehicleNumberPlateText(cache.vehicle, plate)
        Wait(100)
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', QBCore.Functions.GetPlate(cache.vehicle))
    else
        QBCore.Functions.Notify(locale("not_in_vehicle"), 'error')
    end
end)


-- Toggle Vehicle Dev mode
local VEHICLE_DEV_MODE = false
local function UpdateVehicleMenu()
    while VEHICLE_DEV_MODE do
        Wait(1000)

        local vehicle = lib.getVehicleProperties(cache.vehicle)
        local name = GetVehicleName(vehicle.model)
        local netID = VehToNet(cache.vehicle)

        SendNUIMessage({
            action = "showVehicleMenu",
            data = {
                show = VEHICLE_DEV_MODE,
                name = name,
                model = vehicle.model,
                netID = netID,
                engine_health = vehicle.engineHealth,
                body_health = vehicle.bodyHealth,
                plate = vehicle.plate,
                fuel = vehicle.fuelLevel,
            }
        })
    end
end

RegisterNetEvent('ps-adminmenu:client:ToggleVehDevMenu', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    if not cache.vehicle then return end

    VEHICLE_DEV_MODE = not VEHICLE_DEV_MODE

    if VEHICLE_DEV_MODE then
        CreateThread(UpdateVehicleMenu)
    end
end)

-- Max Mods
local PERFORMANCE_MOD_INDICES = { 11, 12, 13, 15, 16 }
local function UpgradePerformance(vehicle)
    SetVehicleModKit(vehicle, 0)
    ToggleVehicleMod(vehicle, 18, true)
    SetVehicleFixed(vehicle)

    for _, modType in ipairs(PERFORMANCE_MOD_INDICES) do
        local maxMod = GetNumVehicleMods(vehicle, modType) - 1
        SetVehicleMod(vehicle, modType, maxMod, customWheels)
    end

    QBCore.Functions.Notify(locale("vehicle_max_modded"), 'success', 7500)
end


RegisterNetEvent('ps-adminmenu:client:maxmodVehicle', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    if cache.vehicle then
        UpgradePerformance(cache.vehicle)
    else
        QBCore.Functions.Notify(locale("vehicle_not_driver"), 'error', 7500)
    end
end)

-- Spawn Personal vehicles

RegisterNetEvent("ps-adminmenu:client:SpawnPersonalVehicle", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local plate = selectedData['VehiclePlate'].value
    local ped = PlayerPedId()
    local coords = QBCore.Functions.GetCoords(ped)
    local cid = QBCore.Functions.GetPlayerData().citizenid

    lib.callback('ps-adminmenu:server:GetVehicleByPlate', false, function(vehModel)
        vehicle = vehModel
    end, plate)

    Wait(100)
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(vehicle)
        local veh = NetToVeh(vehicle)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(ped, veh, -1)
        SetVehicleModKit(veh, 0)
        Wait(100)
        QBCore.Functions.SetVehicleProperties(veh, props)
        SetVehicleNumberPlateText(veh, plate)
        exports[Config.Fuel]:SetFuel(veh, 100.0)
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
        TriggerEvent('iens:repaira', ped)
        TriggerEvent('vehiclemod:client:fixEverything', ped)
    end, vehicle, coords, true)
end)


-- Get Vehicle Data
lib.callback.register("ps-adminmenu:client:getvehData", function(vehicle)
    lib.requestModel(vehicle)

    local coords = vec(GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 2.0, 0.5), GetEntityHeading(cache.ped) + 90)
    local veh = CreateVehicle(vehicle, coords, false, false)

    local prop = {}
    if DoesEntityExist(veh) then
        SetEntityCollision(veh, false, false)
        FreezeEntityPosition(veh, true)
        prop = QBCore.Functions.GetVehicleProperties(veh)
        Wait(500)
        DeleteVehicle(veh)
    end

    return prop
end)
