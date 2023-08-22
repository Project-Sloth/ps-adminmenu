local QBCore = exports['qb-core']:GetCoreObject()
local hasPerms = nil

-- Admin Car
local function getVehicleFromVehList(hash)
	for _, v in pairs(QBCore.Shared.Vehicles) do
		if hash == v.hash then
			return v.model
		end
	end
end

local function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end
function PermsCheck(perms)
    lib.callback('ps-adminmenu:server:hasPerms', false, function(permission)
        hasPerms = permission
    end, perms)
    Wait(100)
    return hasPerms
end

RegisterNetEvent('ps-adminmenu:client:Admincar', function(_, _,perms)
    if not PermsCheck(perms) then return end

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
RegisterNetEvent('ps-adminmenu:client:ToggleInvisible', function(_, _,perms)
    if not PermsCheck(perms) then return end
    local ped = PlayerPedId()
    if not invisible then
        invisible = true
        QBCore.Functions.Notify(Lang:t("info.invisible", {value = "on"}), 'primary')
        SetEntityVisible(ped, false, 0)
    else
        invisible = false
        SetEntityVisible(ped, true, 0)
        QBCore.Functions.Notify(Lang:t("info.invisible", {value = "off"}), 'primary')
    end
end)


-- Godmode
local Godmode = false
RegisterNetEvent('ps-adminmenu:client:ToggleGodmode', function(_,_,perms)
    if not PermsCheck(perms) then return end

    godmode = not godmode

    if godmode then
        QBCore.Functions.Notify(Lang:t("info.godmode", {value = "enabled"}), 'primary')
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
        QBCore.Functions.Notify(Lang:t("info.godmode", {value = "disabled"}), 'primary')
    end
end)

-- Spectate
local oldPos = nil
local spectateInfo = { toggled = false, target = 0, targetPed = 0 }

RegisterNetEvent('ps-adminmenu:requestSpectate', function(targetPed, target, name)
    oldPos = GetEntityCoords(PlayerPedId())
    spectateInfo = {
        toggled = true,
        target = target,
        targetPed = targetPed
    }
end)

RegisterNetEvent('ps-adminmenu:cancelSpectate', function()
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false, spectateInfo['targetPed'])
    end
    if not Cloack and not yayeetActive then
        SetEntityVisible(PlayerPedId(), true, 0)
    end
    spectateInfo = { toggled = false, target = 0, targetPed = 0 }
    RequestCollisionAtCoord(oldPos)
    SetEntityCoords(PlayerPedId(), oldPos)
    oldPos = nil;
end)

CreateThread(function()
    while true do
        Wait(0)
        if spectateInfo['toggled'] then
            local text = {}
            local targetPed = NetworkGetEntityFromNetworkId(spectateInfo.targetPed)
            if DoesEntityExist(targetPed) then
                SetEntityVisible(PlayerPedId(), false, 0)
                if not NetworkIsInSpectatorMode() then
                    RequestCollisionAtCoord(GetEntityCoords(targetPed))
                    NetworkSetInSpectatorMode(true, targetPed)
                end
            else
                TriggerServerEvent('ps-adminmenu:spectate:teleport', spectateInfo['target'])
                while not DoesEntityExist(NetworkGetEntityFromNetworkId(spectateInfo.targetPed)) do Wait(100) end
            end
        else
            Wait(500)
        end
    end
end)

-- Set on fire
RegisterNetEvent('ps-adminmenu:client:SetOnFire', function(time)
    local playerPed = PlayerPedId()
    if time == nil then time = 10 end
    local timer = time * 1000
    StartEntityFire(playerPed)
    Wait(timer)
    StopEntityFire(playerPed)
end)

-- Explode player
RegisterNetEvent('ps-adminmenu:client:ExplodePlayer', function(damage)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if damage == nil then damage = "nodamage" end
    if damage == "nodamage" then
        AddExplosion(playerCoords.x, playerCoords.y, playerCoords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
    else
        AddExplosion(playerCoords.x, playerCoords.y, playerCoords.z, 2, 0.9, 1, 0, 1065353216, 0)
    end
end)

-- Time
RegisterNetEvent('ps-adminmenu:client:ChangeTime', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local time = inputData["Timestamp"] == "clear" and nil or inputData["Timestamp"] or inputData["Time Events"]
    if time then
    TriggerServerEvent('qb-weathersync:server:setTime', time, 00)
    end
end)

-- Weather
RegisterNetEvent('ps-adminmenu:client:ChangeWeather', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local weatherType = inputData["Weather"]
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
RegisterNetEvent('ps-adminmenu:client:TeleportBack', function(coords, _,perms)
    if not PermsCheck(perms) then return end

    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if lastCoords then
        local currentCoords = GetEntityCoords(ped)
        teleport(vehicle, lastCoords.x, lastCoords.y, lastCoords.z)
        lastCoords = currentCoords
    end
end)


-- Teleport to player
RegisterNetEvent('ps-adminmenu:client:TeleportToPlayer', function(coords)
    local ped = PlayerPedId()
    lastCoords = GetEntityCoords(ped)
    SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
end)


-- Teleport to coords
RegisterNetEvent('ps-adminmenu:client:TeleportToCoords', function(x, y, z, h)
    local ped = PlayerPedId()
    lastCoords = GetEntityCoords(ped)
    SetPedCoordsKeepVehicle(ped, x, y, z)
    SetEntityHeading(ped, h or GetEntityHeading(ped))
end)


-- Copy Coords
RegisterNetEvent('ps-adminmenu:client:CopyCoords', function(inputData, buttonlable, perms)
    if not PermsCheck(perms) then return end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local x, y, z, h = QBCore.Shared.Round(coords.x, 2), QBCore.Shared.Round(coords.y, 2), QBCore.Shared.Round(coords.z, 2), QBCore.Shared.Round(GetEntityHeading(ped), 2)

    local data = ""
    if buttonlable == "Copy Vector2" then
        data = string.format('vector2(%s, %s)', x, y)
        QBCore.Functions.Notify(Lang:t("success.copy_vector2"), "success", 5000)
    elseif buttonlable == "Copy Vector3" then
        data = string.format('vector3(%s, %s, %s)', x, y, z)
        QBCore.Functions.Notify(Lang:t("success.copy_vector3"), "success", 5000)
    elseif buttonlable == "Copy Vector4" then
        data = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        QBCore.Functions.Notify(Lang:t("success.copy_vector4"), "success", 5000)
    elseif buttonlable == "Copy Heading" then
        data = h
        QBCore.Functions.Notify(Lang:t("success.copy_heading"), "success", 5000)
    end

    SendNUIMessage({
        action = "CopyCoordinatesToClipboard",
        data = data
    })
end)


-- Teleport to marker
RegisterNetEvent('ps-adminmenu:client:TeleportToMarker', function(_,_,perms)
    if not PermsCheck(perms) then return end

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
RegisterNetEvent('ps-adminmenu:client:MutePlayer', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local playerid = inputData["Player ID"]
    exports['pma-voice']:toggleMutePlayer(playerid)
end)

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local stash = inputData["Stash"]
    local inv = Config.InventoryUsage
    if not (inv == "qb" or inv == "ox" or inv == "lj" or inv == "ps") then
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" or inv == "ps" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    elseif inv == "ox" then
        TriggerServerEvent("ps-adminmenu:server:OpenStash", stash)
    end
end)

-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local playerid = inputData["Player ID"]
    local inv = Config.InventoryUsage
    if not (inv == "qb" or inv == "ox" or inv == "lj" or inv == "ps") then
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" or inv == "ps" then
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerid)
    elseif inv == "ox" then
        TriggerServerEvent("ps-adminmenu:server:OpenInv", playerid)
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

-- Toggle duty
RegisterNetEvent('ps-adminmenu:client:ToggleDuty', function(_, _, perms)
    if not PermsCheck(perms) then return end

    TriggerServerEvent("QBCore:ToggleDuty")
end)

-- Cuff/Uncuff
RegisterNetEvent('ps-adminmenu:client:ToggleCuffs', function(player)
    local playerId = GetPlayerServerId(player)
    TriggerEvent("police:client:GetCuffed", playerId)
end)

-- Delete Laser Functions
local function DrawEntityViewTextInWorld(entity, coords)
    local onScreen, posX, posY = World3dToScreen2d(coords.x, coords.y, coords.z)
    local colorWhite = { r = 255, g = 255, b = 255, a = 200 }
    local textOffsetY = 0.015
    local leftPadding = 0.005
    local topPadding = 0.01
    local botPadding = 0.02
    local rectWidth = 0.12
    if onScreen then
        local data = GetEntityInfo(entity)
        local count = #data
        local offSetCount = ((count - 2) * textOffsetY) / count
        local rectHeight = (count * offSetCount) + botPadding

        DrawRect(posX, posY, rectWidth, rectHeight, colorWhite.r, colorWhite.g, colorWhite.b, colorWhite.a)

        local drawPosY = posY - rectHeight / 2 + topPadding
        for k, v in ipairs(data) do
            if k > 2 then
                SetTextScale(0.25, 0.25)
                SetTextFont(4)
                SetTextDropshadow(1.0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextColour(255, 255, 255, 215)
                SetTextJustification(1)
                SetTextEntry("STRING")
                AddTextComponentString(v)
                DrawText(posX - rectWidth / 2 + leftPadding, drawPosY)
                drawPosY = drawPosY + textOffsetY
            end
        end
    end
end

local function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =
    {
        x = 0.5 * (max.x - min.x),
        y = 0.5 * (max.y - min.y),
        z = 0.5 * (max.z - min.z)
    }

    -- Calculate the eight bounding box edges
    local edges = {}
    edges[1] = position - dim.y * rightVector - dim.x * forwardVector - dim.z * upVector
    edges[2] = edges[1] + 2 * dim.y * rightVector
    edges[3] = edges[2] + 2 * dim.z * upVector
    edges[4] = edges[1] + 2 * dim.z * upVector
    edges[5] = position + dim.y * rightVector + dim.x * forwardVector + dim.z * upVector
    edges[6] = edges[5] - 2 * dim.y * rightVector
    edges[7] = edges[6] - 2 * dim.z * upVector
    edges[8] = edges[5] - 2 * dim.z * upVector

    -- Draw lines to connect the edges and create the bounding box
    for i = 1, 4 do
        local j = i % 4 + 1
        DrawLine(edges[i].x, edges[i].y, edges[i].z, edges[j].x, edges[j].y, edges[j].z, color.r, color.g, color.b, color.a)
        DrawLine(edges[i + 4].x, edges[i + 4].y, edges[i + 4].z, edges[j + 4].x, edges[j + 4].y, edges[j + 4].z, color.r, color.g, color.b, color.a)
        DrawLine(edges[i].x, edges[i].y, edges[i].z, edges[i + 4].x, edges[i + 4].y, edges[i + 4].z, color.r, color.g, color.b, color.a)
    end
end

local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

-- Toggle Delete Laser
local deleteLaser = false
RegisterNetEvent('ps-adminmenu:client:ToggleDeleteLaser', function(_, _, perms)
    if not PermsCheck(perms) then return end

    local x = 0.4
    local y = 0.025
    deleteLaser = not deleteLaser
    CreateThread(function()
        while true do
            local wait = 7
            if deleteLaser then
                local color = {r = 255, g = 255, b = 255, a = 200}
                local position = GetEntityCoords(PlayerPedId())
                local hit, coords, entity = RayCastGamePlayCamera(1000.0)
                if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                    local entityCoord = GetEntityCoords(entity)
                    local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                    DrawEntityBoundingBox(entity, color)
                    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                    Draw2DText('Obj: ~b~' .. entity .. '~w~ Model: ~b~' .. GetEntityModel(entity), 4, {255, 255, 255}, 0.4, 0.55, 0.888)
                    Draw2DText('If you want to delete the object click on ~g~E', 4, {255, 255, 255}, 0.4, 0.55, 0.888 + 0.025)
                    if IsControlJustReleased(0, 38) then
                        SetEntityAsMissionEntity(entity, true, true)
                        DeleteEntity(entity)
                    end
                elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                    DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
                end
            else
                local wait = 500
            end
            Wait(wait)
        end
    end)
end)

-- Toggle veh dev menu
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

-- Toggle coords
local showCoords = false
RegisterNetEvent('ps-adminmenu:client:ToggleCoords', function(_, _, perms)
    if not PermsCheck(perms) then return end

    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = QBCore.Shared.Round(coords.x, 2)
            c.y = QBCore.Shared.Round(coords.y, 2)
            c.z = QBCore.Shared.Round(coords.z, 2)
            heading = QBCore.Shared.Round(heading, 2)
            Wait(1)
            Draw2DText(string.format('~w~'..Lang:t("info.ped_coords") .. '~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end)

-- Noclip

local IsNoClipping      = false
local PlayerPed         = nil
local NoClipEntity      = nil
local Camera            = nil
local NoClipAlpha       = nil
local PlayerIsInVehicle = false
local ResourceName      = GetCurrentResourceName()

local MinY, MaxY        = -89.0, 89.0

--[[
        Configurable values are commented.
]]

-- Perspective values
local PedFirstPersonNoClip      = true       -- No Clip in first person when not in a vehicle
local VehFirstPersonNoClip      = false      -- No Clip in first person when in a vehicle
local ESCEnable                 = false      -- Access Map during NoClip

-- Speed settings
local Speed                     = 1         -- Default: 1
local MaxSpeed                  = 16.0      -- Default: 16.0

-- Key bindings
local MOVE_FORWARDS             = 32        -- Default: W
local MOVE_BACKWARDS            = 33        -- Default: S
local MOVE_LEFT                 = 34        -- Default: A
local MOVE_RIGHT                = 35        -- Default: D
local MOVE_UP                   = 44        -- Default: Q
local MOVE_DOWN                 = 46        -- Default: E

local SPEED_DECREASE            = 14        -- Default: Mouse wheel down
local SPEED_INCREASE            = 15        -- Default: Mouse wheel up
local SPEED_RESET               = 348       -- Default: Mouse wheel click
local SPEED_SLOW_MODIFIER       = 36        -- Default: Left Control
local SPEED_FAST_MODIFIER       = 21        -- Default: Left Shift
local SPEED_FASTER_MODIFIER     = 19        -- Default: Left Alt


local DisabledControls = function()
    HudWeaponWheelIgnoreSelection()
    DisableAllControlActions(0)
    DisableAllControlActions(1)
    DisableAllControlActions(2)
    EnableControlAction(0, 220, true)
    EnableControlAction(0, 221, true)
    EnableControlAction(0, 245, true)
    if ESCEnable then
        EnableControlAction(0, 200, true)
    end
end

local IsControlAlwaysPressed = function(inputGroup, control)
    return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control)
end

local IsPedDrivingVehicle = function(ped, veh)
    return ped == GetPedInVehicleSeat(veh, -1)
end

local SetupCam = function()
    local entityRot = GetEntityRotation(NoClipEntity)
    Camera = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(NoClipEntity), vector3(0.0, 0.0, entityRot.z), 75.0)
    SetCamActive(Camera, true)
    RenderScriptCams(true, true, 1000, false, false)

    if PlayerIsInVehicle == 1 then
        AttachCamToEntity(Camera, NoClipEntity, 0.0, VehFirstPersonNoClip == true and 0.5 or -4.5, VehFirstPersonNoClip == true and 1.0 or 2.0, true)
    else
        AttachCamToEntity(Camera, NoClipEntity, 0.0, PedFirstPersonNoClip == true and 0.0 or -2.0, PedFirstPersonNoClip == true and 1.0 or 0.5, true)
    end

end

local DestroyCamera = function()
    SetGameplayCamRelativeHeading(0)
    RenderScriptCams(false, true, 1000, true, true)
    DetachEntity(NoClipEntity, true, true)
    SetCamActive(Camera, false)
    DestroyCam(Camera, true)
end

local GetGroundCoords = function(coords)
    local rayCast               = StartShapeTestRay(coords.x, coords.y, coords.z, coords.x, coords.y, -10000.0, 1, 0)
    local _, hit, hitCoords     = GetShapeTestResult(rayCast)
    return (hit == 1 and hitCoords) or coords
end

local CheckInputRotation = function()
    local rightAxisX = GetControlNormal(0, 220)
    local rightAxisY = GetControlNormal(0, 221)

    local rotation = GetCamRot(Camera, 2)

    local yValue = rightAxisY * -5
    local newX
    local newZ = rotation.z + (rightAxisX * -10)
    if (rotation.x + yValue > MinY) and (rotation.x + yValue < MaxY) then
        newX = rotation.x + yValue
    end
    if newX ~= nil and newZ ~= nil then
        SetCamRot(Camera, vector3(newX, rotation.y, newZ), 2)
    end

    SetEntityHeading(NoClipEntity, math.max(0, (rotation.z % 360)))
end

RunNoClipThread = function()
    Citizen.CreateThread(function()
        while IsNoClipping do
            Wait(0)
            CheckInputRotation()
            DisabledControls()

            if IsControlAlwaysPressed(2, SPEED_DECREASE) then
                Speed = Speed - 0.5
                if Speed < 0.5 then
                    Speed = 0.5
                end
            elseif IsControlAlwaysPressed(2, SPEED_INCREASE) then
                Speed = Speed + 0.5
                if Speed > MaxSpeed then
                    Speed = MaxSpeed
                end
            elseif IsDisabledControlJustReleased(0, SPEED_RESET) then
                Speed = 1
            end

            local multi = 1.0
            if IsControlAlwaysPressed(0, SPEED_FAST_MODIFIER) then
                multi = 2
            elseif IsControlAlwaysPressed(0, SPEED_FASTER_MODIFIER) then
                multi = 4
            elseif IsControlAlwaysPressed(0, SPEED_SLOW_MODIFIER) then
                multi = 0.25
            end

            if IsControlAlwaysPressed(0, MOVE_FORWARDS) then
                local pitch = GetCamRot(Camera, 0)

                if pitch.x >= 0 then
                    SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.5*(Speed * multi), (pitch.x*((Speed/2) * multi))/89))
                else
                    SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.5*(Speed * multi), -1*((math.abs(pitch.x)*((Speed/2) * multi))/89)))
                end
            elseif IsControlAlwaysPressed(0, MOVE_BACKWARDS) then
                local pitch = GetCamRot(Camera, 2)

                if pitch.x >= 0 then
                    SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, -0.5*(Speed * multi), -1*(pitch.x*((Speed/2) * multi))/89))
                else
                    SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, -0.5*(Speed * multi), ((math.abs(pitch.x)*((Speed/2) * multi))/89)))
                end
            end

            if IsControlAlwaysPressed(0, MOVE_LEFT) then
                SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, -0.5*(Speed * multi), 0.0, 0.0))
            elseif IsControlAlwaysPressed(0, MOVE_RIGHT) then
                SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.5*(Speed * multi), 0.0, 0.0))
            end

            if IsControlAlwaysPressed(0, MOVE_UP) then
                SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.0, 0.5*(Speed * multi)))
            elseif IsControlAlwaysPressed(0, MOVE_DOWN) then
                SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.0, -0.5*(Speed * multi)))
            end

            local coords = GetEntityCoords(NoClipEntity)

            RequestCollisionAtCoord(coords.x, coords.y, coords.z)

            FreezeEntityPosition(NoClipEntity, true)
            SetEntityCollision(NoClipEntity, false, false)
            SetEntityVisible(NoClipEntity, false, false)
            SetEntityInvincible(NoClipEntity, true)
            SetLocalPlayerVisibleLocally(true)
            SetEntityAlpha(NoClipEntity, NoClipAlpha, false)
            if PlayerIsInVehicle == 1 then
                SetEntityAlpha(PlayerPed, NoClipAlpha, false)
            end
            SetEveryoneIgnorePlayer(PlayerPed, true)
            SetPoliceIgnorePlayer(PlayerPed, true)
        end
        StopNoClip()
    end)
end

StopNoClip = function()
    FreezeEntityPosition(NoClipEntity, false)
    SetEntityCollision(NoClipEntity, true, true)
    SetEntityVisible(NoClipEntity, true, false)
    SetLocalPlayerVisibleLocally(true)
    ResetEntityAlpha(NoClipEntity)
    ResetEntityAlpha(PlayerPed)
    SetEveryoneIgnorePlayer(PlayerPed, false)
    SetPoliceIgnorePlayer(PlayerPed, false)
    ResetEntityAlpha(NoClipEntity)
    SetPoliceIgnorePlayer(PlayerPed, true)

    if GetVehiclePedIsIn(PlayerPed, false) ~= 0 then
        while (not IsVehicleOnAllWheels(NoClipEntity)) and not IsNoClipping do
            Wait(0)
        end
        while not IsNoClipping do
            Wait(0)
            if IsVehicleOnAllWheels(NoClipEntity) then
                return SetEntityInvincible(NoClipEntity, false)
            end
        end
    else
        if (IsPedFalling(NoClipEntity) and math.abs(1 - GetEntityHeightAboveGround(NoClipEntity)) > 1.00) then
            while (IsPedStopped(NoClipEntity) or not IsPedFalling(NoClipEntity)) and not IsNoClipping do
                Wait(0)
            end
        end
        while not IsNoClipping do
            Wait(0)
            if (not IsPedFalling(NoClipEntity)) and (not IsPedRagdoll(NoClipEntity)) then
                return SetEntityInvincible(NoClipEntity, false)
            end
        end
    end
end

ToggleNoClip = function(state)
    IsNoClipping = state or not IsNoClipping
    PlayerPed    = PlayerPedId()
    PlayerIsInVehicle = IsPedInAnyVehicle(PlayerPed, false)
    if PlayerIsInVehicle ~= 0 and IsPedDrivingVehicle(PlayerPed, GetVehiclePedIsIn(PlayerPed, false)) then
        NoClipEntity = GetVehiclePedIsIn(PlayerPed, false)
        SetVehicleEngineOn(NoClipEntity, not IsNoClipping, true, IsNoClipping)
        NoClipAlpha = PedFirstPersonNoClip == true and 0 or 51
    else
        NoClipEntity = PlayerPed
        NoClipAlpha = VehFirstPersonNoClip == true and 0 or 51
    end

    if IsNoClipping then
        FreezeEntityPosition(PlayerPed)
        SetupCam()
        PlaySoundFromEntity(-1, "SELECT", PlayerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)

        if not PlayerIsInVehicle then
            ClearPedTasksImmediately(PlayerPed)
            if PedFirstPersonNoClip then
                Wait(1000) -- Wait for the cinematic effect of the camera transitioning into first person
            end
        else
            if VehFirstPersonNoClip then
                Wait(1000) -- Wait for the cinematic effect of the camera transitioning into first person
            end
        end

    else
        local groundCoords      = GetGroundCoords(GetEntityCoords(NoClipEntity))
        SetEntityCoords(NoClipEntity, groundCoords.x, groundCoords.y, groundCoords.z)
        Wait(50)
        DestroyCamera()
        PlaySoundFromEntity(-1, "CANCEL", PlayerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
    end

    QBCore.Functions.Notify(IsNoClipping and Lang:t("success.noclip_enabled") or Lang:t("success.noclip_disabled"))
    SetUserRadioControlEnabled(not IsNoClipping)

    if IsNoClipping then
        RunNoClipThread()
    end
end

RegisterNetEvent('ps-adminmenu:client:ToggleNoClip', function(_, _, perms)
    if not PermsCheck(perms) then return end

    ToggleNoClip(not IsNoClipping)
    TriggerEvent("ps-adminmenu:client:CloseUI")
end)

-- Toggle names and blips

local ShowBlips = false
local ShowNames = false
local NetCheck1 = false
local NetCheck2 = false

CreateThread(function()
    while true do
        Wait(1000)
        if NetCheck1 or NetCheck2 then
            TriggerServerEvent('ps-adminmenu:server:GetPlayersForBlips')
        end
    end
end)

RegisterNetEvent('ps-adminmenu:client:toggleBlips', function(_, _, perms)
    if not PermsCheck(perms) then return end

    if not ShowBlips then
        ShowBlips = true
        NetCheck1 = true
        QBCore.Functions.Notify(Lang:t("success.blips_activated"), "success")
    else
        ShowBlips = false
        QBCore.Functions.Notify(Lang:t("error.blips_deactivated"), "error")
    end
end)

RegisterNetEvent('ps-adminmenu:client:toggleNames', function(_, _, perms)
    if not PermsCheck(perms) then return end

    if not ShowNames then
        ShowNames = true
        NetCheck2 = true
        QBCore.Functions.Notify(Lang:t("success.names_activated"), "success")
    else
        ShowNames = false
        QBCore.Functions.Notify(Lang:t("error.names_deactivated"), "error")
    end
end)

RegisterNetEvent('ps-adminmenu:client:Show', function(players)
    for _, player in pairs(players) do
        local playeridx = GetPlayerFromServerId(player.id)
        local ped = GetPlayerPed(playeridx)
        local blip = GetBlipFromEntity(ped)
        local name = 'ID: '..player.id..' | '..player.name

        local Tag = CreateFakeMpGamerTag(ped, name, false, false, "", false)
        SetMpGamerTagAlpha(Tag, 0, 255) -- Sets "MP_TAG_GAMER_NAME" bar alpha to 100% (not needed just as a fail safe)
        SetMpGamerTagAlpha(Tag, 2, 255) -- Sets "MP_TAG_HEALTH_ARMOUR" bar alpha to 100%
        SetMpGamerTagAlpha(Tag, 4, 255) -- Sets "MP_TAG_AUDIO_ICON" bar alpha to 100%
        SetMpGamerTagAlpha(Tag, 6, 255) -- Sets "MP_TAG_PASSIVE_MODE" bar alpha to 100%
        SetMpGamerTagHealthBarColour(Tag, 25)  --https://wiki.rage.mp/index.php?title=Fonts_and_Colors

        if ShowNames then
            SetMpGamerTagVisibility(Tag, 0, true) -- Activates the player ID Char name and FiveM name
            SetMpGamerTagVisibility(Tag, 2, true) -- Activates the health (and armor if they have it on) bar below the player names
            if NetworkIsPlayerTalking(playeridx) then
                SetMpGamerTagVisibility(Tag, 4, true) -- If player is talking a voice icon will show up on the left side of the name
            else
                SetMpGamerTagVisibility(Tag, 4, false)
            end
            if GetPlayerInvincible(playeridx) then
                SetMpGamerTagVisibility(Tag, 6, true) -- If player is in godmode a circle with a line through it will show up
            else
                SetMpGamerTagVisibility(Tag, 6, false)
            end
        else
            SetMpGamerTagVisibility(Tag, 0, false)
            SetMpGamerTagVisibility(Tag, 2, false)
            SetMpGamerTagVisibility(Tag, 4, false)
            SetMpGamerTagVisibility(Tag, 6, false)
            RemoveMpGamerTag(Tag) -- Unloads the tags till you activate it again
            NetCheck2 = false
        end

        -- Blips Logic
        if ShowBlips then
            if not DoesBlipExist(blip) then
                blip = AddBlipForEntity(ped)
                SetBlipSprite(blip, 1)
                ShowHeadingIndicatorOnBlip(blip, true)
            else
                local veh = GetVehiclePedIsIn(ped, false)
                local blipSprite = GetBlipSprite(blip)
                --Payer Death
                if not GetEntityHealth(ped) then
                    if blipSprite ~= 274 then
                        SetBlipSprite(blip, 274)            --Dead icon
                        ShowHeadingIndicatorOnBlip(blip, false)
                    end
                --Player in Vehicle
                elseif veh ~= 0 then
                    local classveh = GetVehicleClass(veh)
                    local modelveh = GetEntityModel(veh)
                    --MotorCycles (8) or Cycles (13)
                    if classveh == 8  or classveh == 13 then
                        if blipSprite ~= 226 then
                            SetBlipSprite(blip, 226)        --Motorcycle icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --OffRoad (9)
                    elseif classveh == 9 then
                        if blipSprite ~= 757 then
                            SetBlipSprite(blip, 757)        --OffRoad icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Industrial (10)
                    elseif classveh == 10 then
                        if blipSprite ~= 477 then
                            SetBlipSprite(blip, 477)        --Truck icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Utility (11)
                    elseif classveh == 11 then
                        if blipSprite ~= 477 then
                            SetBlipSprite(blip, 477)        --Truck icon despite finding better one
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Vans (12)
                    elseif classveh == 12 then
                        if blipSprite ~= 67 then
                            SetBlipSprite(blip, 67)         --Van icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Boats (14)
                    elseif classveh == 14 then
                        if blipSprite ~= 427 then
                            SetBlipSprite(blip, 427)        --Boat icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Helicopters (15)
                    elseif classveh == 15 then
                        if blipSprite ~= 422 then
                            SetBlipSprite(blip, 422)        --Moving helicopter icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Planes (16)
                    elseif classveh == 16 then
                        if modelveh == 'besra' or modelveh == 'hydra' or modelveh == 'lazer' then
                            if blipSprite ~= 424 then
                                SetBlipSprite(blip, 424)    --Jet icon
                                ShowHeadingIndicatorOnBlip(blip, false)
                            end
                        elseif blipSprite ~= 423 then
                            SetBlipSprite(blip, 423)        --Plane icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Service (17)
                    elseif classveh == 17 then
                        if blipSprite ~= 198 then
                            SetBlipSprite(blip, 198)        --Taxi icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Emergency (18)
                    elseif classveh == 18 then
                        if blipSprite ~= 56 then
                            SetBlipSprite(blip, 56)        --Cop icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Military (19)
                    elseif classveh == 19 then
                        if modelveh == 'rhino' then
                            if blipSprite ~= 421 then
                                SetBlipSprite(blip, 421)    --Tank icon
                                ShowHeadingIndicatorOnBlip(blip, false)
                            end
                        elseif blipSprite ~= 750 then
                            SetBlipSprite(blip, 750)        --Military truck icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Commercial (20)
                    elseif classveh == 20 then
                        if blipSprite ~= 477 then
                            SetBlipSprite(blip, 477)        --Truck icon
                            ShowHeadingIndicatorOnBlip(blip, false)
                        end
                    --Every car (0, 1, 2, 3, 4, 5, 6, 7)
                    else
                        if modelveh == 'insurgent' or modelveh == 'insurgent2' or modelveh == 'limo2' then
                            if blipSprite ~= 426 then
                                SetBlipSprite(blip, 426)    --Armed car icon
                                ShowHeadingIndicatorOnBlip(blip, false)
                            end
                        elseif blipSprite ~= 225 then
                            SetBlipSprite(blip, 225)        --Car icon
                            ShowHeadingIndicatorOnBlip(blip, true)
                        end
                    end
                    -- Show number in case of passangers
                    local passengers = GetVehicleNumberOfPassengers(veh)
                    if passengers then
                        if not IsVehicleSeatFree(veh, -1) then
                            passengers = passengers + 1
                        end
                        ShowNumberOnBlip(blip, passengers)
                    else
                        HideNumberOnBlip(blip)
                    end
                --Player on Foot
                else
                    HideNumberOnBlip(blip)
                    if blipSprite ~= 1 then
                        SetBlipSprite(blip, 1)
                        ShowHeadingIndicatorOnBlip(blip, true)
                    end
                end

                SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                SetBlipNameToPlayerName(blip, playeridx)
                SetBlipScale(blip, 0.85)

                if IsPauseMenuActive() then
                    SetBlipAlpha(blip, 255)
                else
                    local x1, y1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                    local x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(playeridx), true))
                    local distance = (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) + 900
                    if distance < 0 then
                        distance = 0
                    elseif distance > 255 then
                        distance = 255
                    end
                    SetBlipAlpha(blip, distance)
                end
            end
        else
            RemoveBlip(blip)
            NetCheck1 = false
        end
    end
end)

RegisterNetEvent('ps-adminmenu:client:GetVehicles', function(cid)
    local playerVehicles = lib.callback.await('ps-adminmenu:server:GetVehicles', false, cid)
    SendNUIMessage({
        action = "setVehicles",
        data = playerVehicles
    })
end)

RegisterNetEvent("ps-adminmenu:client:SpawnPersonalvehicle", function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local plate = inputData['Personal Vehicle']
    local ped = PlayerPedId()
    local coords = QBCore.Functions.GetCoords(ped)
    local cid = QBCore.Functions.GetPlayerData().citizenid

    QBCore.Functions.TriggerCallback("qb-garage:server:GetVehicleProperties", function(properties, plate)
        props = properties
    end, plate)
    lib.callback('ps-adminmenu:server:GetVehicleByPlate', false, function(vehModel)
        vehicle = vehModel
    end, plate)
    Wait(100)
    QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(vehicle)
        local veh = NetToVeh(vehicle)
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(ped, veh, -1)
        SetVehicleModKit(veh, 0)
        Wait(100)
        QBCore.Functions.SetVehicleProperties(veh, props)
        SetVehicleNumberPlateText(veh, plate)
        exports[Config.FuelScript]:SetFuel(veh, 100.0)
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    end, vehicle, coords, true)
end)

-- Max mods
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

-- Infinite Ammo
RegisterNetEvent('ps-adminmenu:client:setInfiniteAmmo', function(_, _, perms)
    if not PermsCheck(perms) then return end

    local ped = PlayerPedId()
    InfiniteAmmo = not InfiniteAmmo
        local weapon = GetSelectedPedWeapon(ped)
        if InfiniteAmmo then
            if GetAmmoInPedWeapon(ped, weapon) < 6 then SetAmmoInClip(ped, weapon, 10) Wait(50) end
            while InfiniteAmmo do
                weapon = GetSelectedPedWeapon(ped)
                SetPedInfiniteAmmo(ped, true, weapon)
                RefillAmmoInstantly(ped)
                Wait(250)
            end
        else
            SetPedInfiniteAmmo(ped, false, weapon)
        end
    QBCore.Functions.Notify(Lang:t("success.inf_ammo_toggled"), 'success', 7500)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == ResourceName then
        FreezeEntityPosition(NoClipEntity, false)
        FreezeEntityPosition(PlayerPed, false)
        SetEntityCollision(NoClipEntity, true, true)
        SetEntityVisible(NoClipEntity, true, false)
        SetLocalPlayerVisibleLocally(true)
        ResetEntityAlpha(NoClipEntity)
        ResetEntityAlpha(PlayerPed)
        SetEveryoneIgnorePlayer(PlayerPed, false)
        SetPoliceIgnorePlayer(PlayerPed, false)
        ResetEntityAlpha(NoClipEntity)
        SetPoliceIgnorePlayer(PlayerPed, true)
        SetEntityInvincible(NoClipEntity, false)
    end
end)
