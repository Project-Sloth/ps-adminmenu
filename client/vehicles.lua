local function GetVehicleName(hash)
    local vehicles = {}
    local res = lib.callback.await('ps-adminmenu:callback:GetVehicles', false)
    for _,v in pairs(res) do
        if hash == v.model then
            return v.name
        end
    end
    return vehicles
end

-- fix Vehicle
RegisterNetEvent('ps-adminmenu:client:fixEverything', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if veh and veh > 0 then
        SetVehicleUndriveable(veh, false)
        SetVehicleFixed(veh)
        SetVehicleEngineOn(veh, true, false, false)
        SetVehicleDirtLevel(veh, 0.0)
        SetVehicleOnGroundProperly(veh)
    end
end)

-- Own Vehicle
RegisterNetEvent('ps-adminmenu:client:Admincar', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    if not cache.vehicle then return end

    local props = ESX.Game.GetVehicleProperties(cache.vehicle)
    TriggerServerEvent('ps-adminmenu:server:SaveCar', props)
end)

-- Spawn Vehicle
RegisterNetEvent('ps-adminmenu:client:SpawnVehicle', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local selectedVehicle = selectedData["Vehicle"].value
    local hash = joaat(selectedVehicle)

    if not IsModelValid(hash) then return end

    lib.requestModel(hash)

    if cache.vehicle then
        DeleteVehicle(cache.vehicle)
    end
    local c = GetEntityCoords(cache.ped)
    local vehicle = CreateVehicle(hash, c.x, c.y, c.z, GetEntityHeading(cache.ped), true, false)
    TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
    exports[Config.Fuel]:SetFuel(vehicle, 100.0)
end)

-- Refuel Vehicle
RegisterNetEvent('ps-adminmenu:client:RefuelVehicle', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    if cache.vehicle then
        exports[Config.Fuel]:SetFuel(cache.vehicle, 100.0)
        ESX.ShowNotification(_U("refueled_vehicle"), 'success')
    else
        ESX.ShowNotification(_U("not_in_vehicle"), 'error')
    end
end)

-- Change plate
RegisterNetEvent('ps-adminmenu:client:ChangePlate', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local plate = selectedData["Plate"].value

    if string.len(plate) > 8 then
        return ESX.ShowNotification(_U("plate_max"), "error", 5000)
    end

    if cache.vehicle then
        local AlreadyPlate = lib.callback.await("ps-adminmenu:callback:CheckAlreadyPlate", false, plate)

        if AlreadyPlate then
            ESX.ShowNotification(_U("already_plate"), "error", 5000)
            return
        end

        local currentPlate = GetVehicleNumberPlateText(cache.vehicle)
        TriggerServerEvent('ps-adminmenu:server:ChangePlate', plate, currentPlate)
        Wait(100)
        SetVehicleNumberPlateText(cache.vehicle, plate)
    else
        ESX.ShowNotification(_U("not_in_vehicle"), 'error')
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
        SetVehicleMod(vehicle, modType, maxMod, customWheels or false)
    end

    ESX.ShowNotification(_U("vehicle_max_modded"), 'success', 7500)
end


RegisterNetEvent('ps-adminmenu:client:maxmodVehicle', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    if cache.vehicle then
        UpgradePerformance(cache.vehicle)
    else
        ESX.ShowNotification(_U("vehicle_not_driver"), 'error', 7500)
    end
end)

--Spawn Personal vehicles
RegisterNetEvent("ps-adminmenu:client:SpawnPersonalVehicle", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local plate = selectedData['VehiclePlate'].value
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    lib.callback('ps-adminmenu:server:GetVehicleByPlate', false, function(vehModel)
        V1 = vehModel
    end, plate)

    Wait(100)
    ESX.Game.SpawnVehicle(V1.model, coords, GetEntityHeading(ped), function(vehicle)
        ESX.Game.SetVehicleProperties(vehicle, V1)
        Wait(300)
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
    end)
end)

---@param vehicle number
---@return table|nil
lib.callback.register("ps-adminmenu:client:getvehData", function(vehicle, plate)
    lib.requestModel(vehicle)
    local g = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 2.0, 0.5)
    local coords = vector4(g.x, g.y, g.z, GetEntityHeading(cache.ped) + 90)
    local veh = CreateVehicle(vehicle, coords.x, coords.y, coords.z, coords.w, false, false)
    Wait(300)
    SetVehicleNumberPlateText(veh, plate)
    local prop = ESX.Game.GetVehicleProperties(veh)

    if DoesEntityExist(veh) then
        SetEntityCollision(veh, false, false)
        FreezeEntityPosition(veh, true)
        Wait(500)
        DeleteVehicle(veh)
    end

    return prop
end)
