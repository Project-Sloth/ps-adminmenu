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
	print("AdminCarTriggerd")
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


-- Time
RegisterNetEvent('ps-adminmenu:client:ChangeTime', function(inputData)
    local time = inputData["Time"]
    print(time)
    TriggerServerEvent('qb-weathersync:server:setTime', time)
end)


-- weather
RegisterNetEvent('ps-adminmenu:client:ChangeWeather', function(inputData)
    local weatherType = inputData["Weather"]
    -- print(weatherType)
    TriggerServerEvent('qb-weathersync:server:setWeather', weatherType)
    QBCore.Functions.Notify(Lang:t("info.weatherType", {value = weatherType}))
end)


-- Teleport back
local function teleport(vehicle, x, y, z)
    local ped = PlayerPedId()
    if vehicle then
        return SetPedCoordsKeepVehicle(ped, x, y, z)
    end    
    SetEntityCoords(ped, x, y, z, false, false, false, false)
end


local lastCoords
RegisterNetEvent('ps-adminmenu:client:TeleportBack', function(coords)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if lastCoords then
        local currentCoords = GetEntityCoords(ped)
        teleport(vehicle, lastCoords.x, lastCoords.y, lastCoords.z)
        lastCoords = currentCoords
    end
end)


-- Tp to player
RegisterNetEvent('ps-adminmenu:client:TeleportToPlayer', function(coords)
    local ped = PlayerPedId()
    lastCoords = GetEntityCoords(ped)
    SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
end)


-- Tp to coords
RegisterNetEvent('ps-adminmenu:client:TeleportToCoords', function(x, y, z, h)
    local ped = PlayerPedId()
    lastCoords = GetEntityCoords(ped)
    SetPedCoordsKeepVehicle(ped, x, y, z)
    SetEntityHeading(ped, h or GetEntityHeading(ped))
end)


-- Copy Coords
RegisterNetEvent('ps-adminmenu:client:CopyCoords', function(inputData, buttonlable)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local x, y, z, h = QBCore.Shared.Round(coords.x, 2), QBCore.Shared.Round(coords.y, 2), QBCore.Shared.Round(coords.z, 2), QBCore.Shared.Round(GetEntityHeading(ped), 2)
    
    local data = ""
    if buttonlable == "Copy Vector2" then
        data = string.format('vector2(%s, %s)', x, y)
    elseif buttonlable == "Copy Vector3" then
        data = string.format('vector3(%s, %s, %s)', x, y, z)
    elseif buttonlable == "Copy Vector4" then
        data = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
    elseif buttonlable == "Copy Heading" then
        data = h
    end

    SendNUIMessage({
        action = "CopyCoordinatesToClipboard",
        data = data
    })
end)


-- tp to marker
RegisterNetEvent('ps-adminmenu:client:TeleportToMarker', function()
    local PlayerPedId = PlayerPedId
    local GetEntityCoords = GetEntityCoords
    local GetGroundZFor_3dCoord = GetGroundZFor_3dCoord

    local blipMarker <const> = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blipMarker) then
        QBCore.Functions.Notify(Lang:t("error.no_waypoint"), "error", 5000)
        return 'marker'
    end

    -- Fade screen to hide how clients get teleported.
    DoScreenFadeOut(650)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    local ped, coords <const> = PlayerPedId(), GetBlipInfoIdCoord(blipMarker)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local oldCoords <const> = GetEntityCoords(ped)
    lastCoords = GetEntityCoords(ped)

    -- Unpack coords instead of having to unpack them while iterating.
    -- 825.0 seems to be the max a player can reach while 0.0 being the lowest.
    local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
    local found = false
    if vehicle > 0 then
        FreezeEntityPosition(vehicle, true)
    else
        FreezeEntityPosition(ped, true)
    end

    for i = Z_START, 0, -25.0 do
        local z = i
        if (i % 2) ~= 0 then
            z = Z_START - i
        end

        NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
        local curTime = GetGameTimer()
        while IsNetworkLoadingScene() do
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end
        NewLoadSceneStop()
        SetPedCoordsKeepVehicle(ped, x, y, z)

        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x, y, z)
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end

        -- Get ground coord. As mentioned in the natives, this only works if the client is in render distance.
        found, groundZ = GetGroundZFor_3dCoord(x, y, z, false);
        if found then
            Wait(0)
            SetPedCoordsKeepVehicle(ped, x, y, groundZ)
            break
        end
        Wait(0)
    end

    -- Remove black screen once the loop has ended.
    DoScreenFadeIn(650)
    if vehicle > 0 then
        FreezeEntityPosition(vehicle, false)
    else
        FreezeEntityPosition(ped, false)
    end

    if not found then
        -- If we can't find the coords, set the coords to the old ones.
        -- We don't unpack them before since they aren't in a loop and only called once.
        SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
        QBCore.Functions.Notify(Lang:t("error.tp_error"), "error", 5000)
    end

    -- If Z coord was found, set coords in found coords.
    SetPedCoordsKeepVehicle(ped, x, y, groundZ)
    QBCore.Functions.Notify(Lang:t("success.teleported_waypoint"), "success", 5000)
end)


-- Mute Player
RegisterNetEvent('ps-adminmenu:client:MutePlayer', function(inputData)
    local playerid = inputData["Player ID"]
    exports['pma-voice']:toggleMutePlayer(playerid)
end)


-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(inputData)
    local stash = inputData["Stash"]
    TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
    TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
end)


-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(inputData)
    local playerid = inputData["Player ID"]
    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerid)
end)
