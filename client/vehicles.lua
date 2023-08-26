local function getVehicleFromVehList(hash)
	for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end

RegisterNetEvent('ps-adminmenu:client:Admincar', function(_, _,perms)
    if not PermsCheck(perms) then return end

    if cache.vehicle then
        local plate = QBCore.Functions.GetPlate(cache.vehicle)
        local props = QBCore.Functions.GetVehicleProperties(cache.vehicle)
        local hash = props.model
        local vehname = getVehicleFromVehList(hash)
        if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
            TriggerServerEvent('ps-adminmenu:server:SaveCar', props, QBCore.Shared.Vehicles[vehname], GetHashKey(cache.vehicle), plate)
        else
            QBCore.Functions.Notify(Lang:t("error.cannot_store_veh"), 'error')

        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_veh"), 'error')
    end
end)

-- Spawn Vehicle
RegisterNetEvent('ps-adminmenu:client:SpawnVehicle', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local ped = PlayerPedId()
    local hash = GetHashKey(inputData["Vehicle"])
    local veh = GetVehiclePedIsUsing(ped)
    if not IsModelInCdimage(hash) then return end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end

    if IsPedInAnyVehicle(ped) then
        DeleteVehicle(veh)
    end

    local vehicle = CreateVehicle(hash, GetEntityCoords(ped), GetEntityHeading(ped), true, false)
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    exports[Config.FuelScript]:SetFuel(vehicle, 100.0)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetModelAsNoLongerNeeded(hash)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
end)

-- Refuel Vehicle
RegisterNetEvent('ps-adminmenu:client:RefuelVehicle', function(_, _, perms)
    if not PermsCheck(perms) then return end

    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        local veh = GetVehiclePedIsUsing(ped)
        exports[Config.FuelScript]:SetFuel(veh, 100.0)
        QBCore.Functions.Notify(Lang:t("success.refueled_vehicle"))
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_vehicle"))
    end
end)

-- Change plate
RegisterNetEvent('ps-adminmenu:client:ChangePlate', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local ped = PlayerPedId()
    local plate = inputData["Plate"]
    if string.len(plate) > 8 then return QBCore.Functions.Notify(Lang:t("error.plate_max"), "error", 5000) end
    if IsPedInAnyVehicle(ped) then
        local veh = GetVehiclePedIsUsing(ped)
        SetVehicleNumberPlateText(veh, plate)
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_vehicle"))
    end
end)

-- Toggle Vehicle Dev mode
local vehicleDevMode = false
RegisterNetEvent('ps-adminmenu:client:ToggleVehDevMenu', function(_, _, perms)
    if not PermsCheck(perms) then return end

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

RegisterNetEvent('ps-adminmenu:client:maxmodVehicle', function(_, _, perms)
    if not PermsCheck(perms) then return end

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if IsPedSittingInVehicle(ped, vehicle) then
        if GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
            PerformanceUpgradeVehicle(vehicle)
            QBCore.Functions.Notify(Lang:t("success.vehicle_max_modded"), 'success', 7500)
        else
            QBCore.Functions.Notify(Lang:t("error.vehicle_not_driver"), 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_veh"), 'error', 7500)
    end
end)