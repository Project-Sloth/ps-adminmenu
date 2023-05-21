QBCore = exports['qb-core']:GetCoreObject()

-- Admin Car
local function getVehicleFromVehList(hash)
	for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end
RegisterNetEvent('ps-adminmenu:client:Admincar', function(data)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)

    if veh ~= nil and veh ~= 0 then
        local plate = QBCore.Functions.GetPlate(veh)
        local props = QBCore.Functions.GetVehicleProperties(veh)
        local hash = props.model
        local vehname = getVehicleFromVehList(hash)
        if QBCore.Shared.Vehicles[vehname] ~= nil and next(QBCore.Shared.Vehicles[vehname]) ~= nil then
            TriggerServerEvent('ps-adminmenu:server:SaveCar', props, QBCore.Shared.Vehicles[vehname], GetHashKey(veh), plate)
        else
            QBCore.Functions.Notify(Lang:t("error.cannot_store_veh"), 'error')
           
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_veh"), 'error')
    end
end)

-- Invisible
RegisterNetEvent('ps-adminmenu:client:ToggleInvisible', function(data)
    local ped = PlayerPedId()
    if not invisible then
        invisible = true
        QBCore.Functions.Notify(Lang:t("info.invisible", {value = "on"}), 'inform')
        SetEntityVisible(ped, false, 0)
    else
        invisible = false
        SetEntityVisible(ped, true, 0)
        QBCore.Functions.Notify(Lang:t("info.invisible", {value = "off"}), 'inform')
    end
end)

-- godmode
local Godmode = false
RegisterNetEvent('ps-adminmenu:client:ToggleGodmode', function(data)
    godmode = not godmode

    if godmode then
        QBCore.Functions.Notify(Lang:t("info.godmode", {value = "enabled"}), 'inform')
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
        QBCore.Functions.Notify(Lang:t("info.godmode", {value = "disabled"}), 'inform')
    end
end)



-- weather
RegisterNetEvent('ps-adminmenu:client:ChangeWeather', function(inputData)
    local weatherType = inputData["Wheather"]
    TriggerServerEvent('qb-weathersync:server:setWeather', weatherType)
    QBCore.Functions.Notify(Lang:t("info.weatherType", {value = weatherType}))
end)
