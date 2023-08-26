local noclip = false
local cam = 0

local speed = 1
local maxSpeed = 16.0

local MinY = -89.0
local MaxY = 89.0

local noclipAlpha = 0

local MOVE_FORWARDS = 32   -- Default: W (32)
local MOVE_BACKWARDS = 33  -- Default: S (33)
local MOVE_LEFT  = 34      -- Default: A (34)
local MOVE_RIGHT = 35      -- Default: D (35)
local MOVE_UP = 44         -- Default: Q (44)
local MOVE_DOWN = 46       -- Default: E (46)

local SPEED_DECREASE = 14        -- Default: Mouse wheel down (14)
local SPEED_INCREASE = 15        -- Default: Mouse wheel up (15)
local SPEED_RESET = 348          -- Default: Mouse wheel click (348)
local SPEED_SLOW_MODIFIER = 36   -- Default: Left Control (36)
local SPEED_FAST_MODIFIER = 21   -- Default: Left Shift (21)
local SPEED_FASTER_MODIFIER = 19 -- Default: Left Alt (19)

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
    local rotation = GetEntityRotation(cache.ped)
    local coords = GetEntityCoords(cache.ped)

    cam = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", coords, vector3(0.0, 0.0, rotation.z), 75.0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, false, false)

    if cache.vehicle then
        AttachCamToEntity(cam, cache.ped, 0.0, -4.5, 2.0, true)
    else
        AttachCamToEntity(cam, cache.ped, 0.0, 0.0, 1.0, true)
    end
end

-- Destroys the camera
local function DestoryCam()
    Wait(100)
    SetGameplayCamRelativeHeading(0)
    RenderScriptCams(false, true, 1000, true, true)
    DetachEntity(cache.ped, true, true)
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

    if (rotation.x + yValue > MinY) and (rotation.x + yValue < MaxY) then
        newX = rotation.x + yValue
    end

    if newX ~= nil and newZ ~= nil then
        SetCamRot(cam, vector3(newX, rotation.y, newZ), 2)
    end

    SetEntityHeading(cache.ped, math.max(0, (rotation.z % 360)))
end

-- Stops the noclip
local function StopNoclip()
    FreezeEntityPosition(cache.ped, false)
    SetEntityCollision(cache.ped, true, true)
    SetEntityVisible(cache.ped, true, false)
    SetLocalPlayerVisibleLocally(true)
    ResetEntityAlpha(cache.ped)
    ResetEntityAlpha(cache.ped)
    SetEveryoneIgnorePlayer(cache.ped, false)
    SetPoliceIgnorePlayer(cache.ped, false)
    ResetEntityAlpha(cache.ped)
    SetPoliceIgnorePlayer(cache.ped, true)

    if GetVehiclePedIsIn(cache.ped, false) ~= 0 then
        while (not IsVehicleOnAllWheels(cache.ped)) and not noclip do
            Wait(0)
        end
        while not noclip do
            Wait(0)
            if IsVehicleOnAllWheels(cache.ped) then
                return SetEntityInvincible(cache.ped, false)
            end
        end
    else
        if (IsPedFalling(cache.ped) and math.abs(1 - GetEntityHeightAboveGround(cache.ped)) > 1.00) then
            while (IsPedStopped(cache.ped) or not IsPedFalling(cache.ped)) and not noclip do
                Wait(0)
            end
        end
        while not noclip do
            Wait(0)
            if (not IsPedFalling(cache.ped)) and (not IsPedRagdoll(cache.ped)) then
                return SetEntityInvincible(cache.ped, false)
            end
        end
    end
end

-- Handels the speed
local function UpdateSpeed()
    if IsControlAlwaysPressed(2, SPEED_DECREASE) then
        speed = speed - 0.5
        if speed < 0.5 then
            speed = 0.5
        end
    elseif IsControlAlwaysPressed(2, SPEED_INCREASE) then
        speed = speed + 0.5
        if speed > maxSpeed then
            speed = maxSpeed
        end
    elseif IsDisabledControlJustReleased(0, SPEED_RESET) then
        speed = 1
    end
end

-- Handels the movement
local function UpdateMovement()
    local multi = 1.0
    if IsControlAlwaysPressed(0, SPEED_FAST_MODIFIER) then
        multi = 2
    elseif IsControlAlwaysPressed(0, SPEED_FASTER_MODIFIER) then
        multi = 4
    elseif IsControlAlwaysPressed(0, SPEED_SLOW_MODIFIER) then
        multi = 0.25
    end

    if IsControlAlwaysPressed(0, MOVE_FORWARDS) then
        local pitch = GetCamRot(cam, 0)

        if pitch.x >= 0 then
            SetEntityCoordsNoOffset(cache.ped,
                GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.5 * (speed * multi),
                    (pitch.x * ((speed / 2) * multi)) / 89))
        else
            SetEntityCoordsNoOffset(cache.ped,
                GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.5 * (speed * multi),
                    -1 * ((math.abs(pitch.x) * ((speed / 2) * multi)) / 89)))
        end
    elseif IsControlAlwaysPressed(0, MOVE_BACKWARDS) then
        local pitch = GetCamRot(cam, 2)

        if pitch.x >= 0 then
            SetEntityCoordsNoOffset(cache.ped,
                GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, -0.5 * (speed * multi),
                    -1 * (pitch.x * ((speed / 2) * multi)) / 89))
        else
            SetEntityCoordsNoOffset(cache.ped,
                GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, -0.5 * (speed * multi),
                    ((math.abs(pitch.x) * ((speed / 2) * multi)) / 89)))
        end
    end

    if IsControlAlwaysPressed(0, MOVE_LEFT) then
        SetEntityCoordsNoOffset(cache.ped,
            GetOffsetFromEntityInWorldCoords(cache.ped, -0.5 * (speed * multi), 0.0, 0.0))
    elseif IsControlAlwaysPressed(0, MOVE_RIGHT) then
        SetEntityCoordsNoOffset(cache.ped,
            GetOffsetFromEntityInWorldCoords(cache.ped, 0.5 * (speed * multi), 0.0, 0.0))
    end

    if IsControlAlwaysPressed(0, MOVE_UP) then
        SetEntityCoordsNoOffset(cache.ped,
            GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.0, 0.5 * (speed * multi)))
    elseif IsControlAlwaysPressed(0, MOVE_DOWN) then
        SetEntityCoordsNoOffset(cache.ped,
            GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.0, -0.5 * (speed * multi)))
    end
end

local function Noclip()
    SetupCam()
    CreateThread(function()
        while noclip do
            Wait(0)
            UpdateCameraRotation()
            DisabledControls()
            UpdateSpeed()
            UpdateMovement()


            local coords = GetEntityCoords(cache.ped)

            RequestCollisionAtCoord(coords.x, coords.y, coords.z)

            FreezeEntityPosition(cache.ped, true)
            SetEntityCollision(cache.ped, false, false)
            SetEntityVisible(cache.ped, false, false)
            SetEntityInvincible(cache.ped, true)
            SetLocalPlayerVisibleLocally(true)
            SetEntityAlpha(cache.ped, noclipAlpha, false)
            SetEveryoneIgnorePlayer(cache.ped, true)
            SetPoliceIgnorePlayer(cache.ped, true)
            if cache.vehicle then
                SetEntityAlpha(cache.ped, noclipAlpha, false)
            end
        end
        StopNoclip()
    end)
end

local function GetGroundCoords()
    local coords = GetEntityCoords(cache.ped)
    local rayCast = StartShapeTestRay(coords.x, coords.y, coords.z, coords.x, coords.y, -10000.0, 1, 0)
    local _, hit, hitCoords = GetShapeTestResult(rayCast)

    return (hit == 1 and hitCoords) or coords
end

local function ToggleNoclip()
    noclip = not noclip

    if noclip then
        Noclip()
    else
        local coords = GetGroundCoords()
        SetEntityCoords(cache.ped, coords.x, coords.y, coords.z)
        DestoryCam()
    end

    print('noclip', noclip)
end

RegisterNetEvent('ps-adminmenu:client:ToggleNoClip', function(perms)
    if not CheckPerms(perms) then return end
    ToggleNoclip()
    -- ToggleNoclip(not IsNoClipping)
    -- ToggleUI(false)
end)
