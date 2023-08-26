local function GetVehicleName(hash)
	for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end

RegisterNetEvent('ps-adminmenu:client:Admincar', function(perms)
    if not CheckPerms(perms) then return end

    if cache.vehicle then
        local vehicleData = lib.getVehicleProperties(cache.vehicle)
        local vehName = GetVehicleName(vehicleData.model)

        if QBCore.Shared.Vehicles[vehName] then
            TriggerServerEvent('ps-adminmenu:server:SaveCar', vehicleData, QBCore.Shared.Vehicles[vehName], GetHashKey(cache.vehicle), vehicleData.plate)
        else
            QBCore.Functions.Notify(locale("cannot_store_veh"), 'error')
        end
    end
end)

-- Spawn Vehicle
RegisterNetEvent('ps-adminmenu:client:SpawnVehicle', function(perms)
    if not CheckPerms(perms) then return end

    local hash = GetHashKey("t20") --- Change this to inputdata later, this is just for testing
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
RegisterNetEvent('ps-adminmenu:client:RefuelVehicle', function(perms)
    if not CheckPerms(perms) then return end

    if cache.vehicle then
        exports[Config.Fuel]:SetFuel(cache.vehicle, 100.0)
        QBCore.Functions.Notify(locale("refueled_vehicle"), 'success')
    else
        QBCore.Functions.Notify(locale("not_in_vehicle"), 'error')
    end
end)

-- Change plate
RegisterNetEvent('ps-adminmenu:client:ChangePlate', function(inputData, _, perms)
    if not CheckPerms(perms) then return end

    local plate = inputData["Plate"]
    if string.len(plate) > 8 then return QBCore.Functions.Notify(locale("plate_max"), "error", 5000) end

    if cache.vehicle then
        SetVehicleNumberPlateText(cache.vehicle, plate)
    else
        QBCore.Functions.Notify(locale("not_in_vehicle"), 'error')
    end
end)

-- Toggle Vehicle Dev mode
local vehicleDevMode = false
RegisterNetEvent('ps-adminmenu:client:ToggleVehDevMenu', function(_, _, perms)
    if not CheckPerms(perms) then return end

    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    CreateThread(function()
        while vehicleDevMode do
            local ped = PlayerPedId()
            Wait(1)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText(Lang:t("info.vehicle_dev_data"), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
                Draw2DText(string.format(Lang:t("info.ent_id") .. '~b~%s~s~ | ' .. Lang:t("info.net_id") .. '~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
                Draw2DText(string.format(Lang:t("info.model") .. '~b~%s~s~ | ' .. Lang:t("info.hash") .. '~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
                Draw2DText(string.format(Lang:t("info.eng_health") .. '~b~%s~s~ | ' .. Lang:t("info.body_health") .. '~b~%s~s~', QBCore.Shared.Round(eHealth, 2), QBCore.Shared.Round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
            end
        end
    end)
end)

-- Max Mods
local performanceModIndices = { 11, 12, 13, 15, 16 }
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, tonumber(modType)) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
	SetVehicleFixed(vehicle)
    end
end

RegisterNetEvent('ps-adminmenu:client:maxmodVehicle', function(perms)
    if not CheckPerms(perms) then return end

    if IsPedSittingInVehicle(cache.ped, cache.vehicle) then
        if GetPedInVehicleSeat(cache.vehicle, -1) == cache.ped then
            PerformanceUpgradeVehicle(cache.vehicle)
            QBCore.Functions.Notify(locale("vehicle_max_modded"), 'success', 7500)
        else
            QBCore.Functions.Notify(locale("vehicle_not_driver"), 'error', 7500)
        end
    end
end)