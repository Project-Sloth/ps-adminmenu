local noclip = false
local cam = 0
local ped
local speed = 1
local maxSpeed = 16


-- Disable the controls
local function DisabledControls()
    HudWeaponWheelIgnoreSelection()
    DisableAllControlActions(0)
    DisableAllControlActions(1)
    DisableAllControlActions(2)
    EnableControlAction(0, 220, true)
    EnableControlAction(0, 221, true)
    EnableControlAction(0, 245, true)
end

-- Setup the camera
local function SetupCam()
    local rotation = GetEntityRotation(ped)
    local coords = GetEntityCoords(ped)

    cam = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", coords, vector3(0.0, 0.0, rotation.z), 75.0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, false, false)
    AttachCamToEntity(cam, ped, 0.0, 0.0, 1.0, true)
end

-- Destroys the camera
local function DestoryCam()
    Wait(100)
    SetGameplayCamRelativeHeading(0)
    RenderScriptCams(false, true, 1000, true, true)
    DetachEntity(ped, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
end

-- Checks if a control is always pressed
local IsControlAlwaysPressed = function(inputGroup, control)
    return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control)
end

-- Updates the camera rotation
local function UpdateCameraRotation()
    local rightAxisX = GetControlNormal(0, 220)
    local rightAxisY = GetControlNormal(0, 221)
    local rotation = GetCamRot(cam, 2)
    local yValue = rightAxisY * -5
    local newX
    local newZ = rotation.z + (rightAxisX * -10)

    if (rotation.x + yValue > -89.0) and (rotation.x + yValue < 89.0) then
        newX = rotation.x + yValue
    end

    if newX ~= nil and newZ ~= nil then
        SetCamRot(cam, vector3(newX, rotation.y, newZ), 2)
    end

    SetEntityHeading(ped, math.max(0, (rotation.z % 360)))
end

-- Gets the ground coords
local function TeleportToGround()
    local coords = GetEntityCoords(ped)
    local rayCast = StartShapeTestRay(coords.x, coords.y, coords.z, coords.x, coords.y, -10000.0, 1, 0)
    local _, hit, hitCoords = GetShapeTestResult(rayCast)

    if hit == 1 then
        SetEntityCoords(ped, hitCoords.x, hitCoords.y, hitCoords.z)
    else
        SetEntityCoords(ped, coords.x, coords.y, coords.z)
    end
end

-- Toggles the behavior of visiblty, collision, etc
local function ToggleBehavior(bool)
    local coords = GetEntityCoords(ped)

    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    FreezeEntityPosition(ped, bool)
    SetEntityCollision(ped, not bool, not bool)
    SetEntityVisible(ped, not bool, not bool)
    SetEntityInvincible(ped, bool)
    SetEntityAlpha(ped, bool and noclipAlpha or 255, false)
    SetLocalPlayerVisibleLocally(true)
    SetEveryoneIgnorePlayer(ped, bool)
    SetPoliceIgnorePlayer(ped, bool)

    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle ~= 0 then
        SetEntityAlpha(vehicle, bool and noclipAlpha or 255, false)
    end
end


-- Stops the noclip
local function StopNoclip()
    DestoryCam()
    TeleportToGround()
    ToggleBehavior(false)
end

-- Handels the speed
local function UpdateSpeed()
    if IsControlAlwaysPressed(2, 14) then
        speed = speed - 0.5
        if speed < 0.5 then
            speed = 0.5
        end
    elseif IsControlAlwaysPressed(2, 15) then
        speed = speed + 0.5
        if speed > maxSpeed then
            speed = maxSpeed
        end
    elseif IsDisabledControlJustReleased(0, 348) then
        speed = 1
    end
end

-- Handels the movement
local function UpdateMovement()
    local multi = 1.0
    if IsControlAlwaysPressed(0, 21) then
        multi = 2
    elseif IsControlAlwaysPressed(0, 19) then
        multi = 4
    elseif IsControlAlwaysPressed(0, 36) then
        multi = 0.25
    end

    if IsControlAlwaysPressed(0, 32) then
        local pitch = GetCamRot(cam, 0)

        if pitch.x >= 0 then
            SetEntityCoordsNoOffset(ped,
                GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5 * (speed * multi),
                    (pitch.x * ((speed / 2) * multi)) / 89))
        else
            SetEntityCoordsNoOffset(ped,
                GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5 * (speed * multi),
                    -1 * ((math.abs(pitch.x) * ((speed / 2) * multi)) / 89)))
        end
    elseif IsControlAlwaysPressed(0, 33) then
        local pitch = GetCamRot(cam, 2)

        if pitch.x >= 0 then
            SetEntityCoordsNoOffset(ped,
                GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.5 * (speed * multi),
                    -1 * (pitch.x * ((speed / 2) * multi)) / 89))
        else
            SetEntityCoordsNoOffset(ped,
                GetOffsetFromEntityInWorldCoords(ped, 0.0, -0.5 * (speed * multi),
                    ((math.abs(pitch.x) * ((speed / 2) * multi)) / 89)))
        end
    end

    if IsControlAlwaysPressed(0, 34) then
        SetEntityCoordsNoOffset(ped,
            GetOffsetFromEntityInWorldCoords(ped, -0.5 * (speed * multi), 0.0, 0.0))
    elseif IsControlAlwaysPressed(0, 35) then
        SetEntityCoordsNoOffset(ped,
            GetOffsetFromEntityInWorldCoords(ped, 0.5 * (speed * multi), 0.0, 0.0))
    end

    if IsControlAlwaysPressed(0, 44) then
        SetEntityCoordsNoOffset(ped,
            GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 0.5 * (speed * multi)))
    elseif IsControlAlwaysPressed(0, 46) then
        SetEntityCoordsNoOffset(ped,
            GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -0.5 * (speed * multi)))
    end
end

-- Toggles the noclip
local function ToggleNoclip()
    noclip = not noclip

    if cache.vehicle then
        ped = cache.vehicle
    else
        ped = cache.ped
    end

    if noclip then
        SetupCam()
        ToggleBehavior(true)
        while noclip do
            Wait(0)
            UpdateCameraRotation()
            DisabledControls()
            UpdateSpeed()
            UpdateMovement()
        end
    else
        StopNoclip()
    end
end

RegisterNetEvent('ps-adminmenu:client:ToggleNoClip', function()
    if not CheckPerms(Config.Actions["noclip"].perms) then return end
    ToggleNoclip()
end)

