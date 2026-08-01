local isControlling = false
local targetServerId = nil
local savedCoords = nil

local isBeingControlled = false
local currentMoveState = nil

local WALK_SPEED = 1.0
local RUN_SPEED = 2.0
local MOVE_DISTANCE = 2.0

local function stopControl()
    if not isControlling then return end

    isControlling = false

    local myPed = PlayerPedId()

    NetworkSetInSpectatorMode(false, myPed)
    SetMinimapInSpectatorMode(false, myPed)

    SetEntityVisible(myPed, true, false)
    SetEntityAlpha(myPed, 255, false)
    SetEntityCollision(myPed, true, true)

    DoScreenFadeOut(300)
    Wait(400)

    if savedCoords then
        SetEntityCoords(myPed, savedCoords.x, savedCoords.y, savedCoords.z, false, false, false, false)
        savedCoords = nil
    end

    targetServerId = nil

    DoScreenFadeIn(500)

    TriggerServerEvent('ps-adminmenu:server:stopControl')
end

local function startControl(target)
    local targetPlayer = GetPlayerFromServerId(target)

    if targetPlayer == -1 then
        TriggerEvent('chat:addMessage', { args = { '^1ERROR', 'Player is not online.' } })
        return
    end

    if target == GetPlayerServerId(PlayerId()) then
        TriggerEvent('chat:addMessage', { args = { '^1ERROR', 'You cannot control yourself.' } })
        return
    end

    local targetPed = GetPlayerPed(targetPlayer)
    if not DoesEntityExist(targetPed) then
        TriggerEvent('chat:addMessage', { args = { '^1ERROR', 'Player is not online.' } })
        return
    end

    local myPed = PlayerPedId()
    savedCoords = GetEntityCoords(myPed)

    DoScreenFadeOut(300)
    Wait(400)

    SetEntityVisible(myPed, false, false)
    SetEntityAlpha(myPed, 0, false)
    SetEntityCollision(myPed, false, false)

    local targetCoords = GetEntityCoords(targetPed)
    SetEntityCoords(myPed, targetCoords.x, targetCoords.y, targetCoords.z + 1.0, false, false, false, false)
    Wait(200)

    NetworkSetInSpectatorMode(true, targetPed)
    SetMinimapInSpectatorMode(true, targetPed)

    isControlling = true
    targetServerId = target

    DoScreenFadeIn(500)

    CreateThread(function()
        local lastSend = 0
        local SEND_INTERVAL = 50

        while isControlling do
            Wait(0)

            local tPlayer = GetPlayerFromServerId(targetServerId)
            if tPlayer == -1 then
                stopControl()
                break
            end
            local tPed = GetPlayerPed(tPlayer)
            if not DoesEntityExist(tPed) then
                stopControl()
                break
            end

            local forward  = IsDisabledControlPressed(0, 32)
            local backward = IsDisabledControlPressed(0, 33)
            local left     = IsDisabledControlPressed(0, 34)
            local right    = IsDisabledControlPressed(0, 35)
            local sprint   = IsDisabledControlPressed(0, 21)
            local jump     = IsDisabledControlJustPressed(0, 22)

            local isMoving = forward or backward or left or right

            local camRot = GetGameplayCamRot(2)
            local camHeading = camRot.z

            local now = GetGameTimer()
            if now - lastSend >= SEND_INTERVAL then
                lastSend = now

                TriggerServerEvent('ps-adminmenu:server:sendMovement', {
                    forward = forward,
                    backward = backward,
                    left = left,
                    right = right,
                    sprint = sprint,
                    jump = jump,
                    heading = camHeading,
                    moving = isMoving
                })
            end
        end
    end)
end

local function calculateMoveDirection(heading, forward, backward, left, right)
    local angle = math.rad(-heading)
    local dirX, dirY = 0.0, 0.0

    if forward then
        dirX = dirX + math.sin(angle)
        dirY = dirY + math.cos(angle)
    end
    if backward then
        dirX = dirX - math.sin(angle)
        dirY = dirY - math.cos(angle)
    end
    if left then
        dirX = dirX + math.cos(angle)
        dirY = dirY - math.sin(angle)
    end
    if right then
        dirX = dirX - math.cos(angle)
        dirY = dirY + math.sin(angle)
    end

    local len = math.sqrt(dirX * dirX + dirY * dirY)
    if len > 0 then
        dirX = dirX / len
        dirY = dirY / len
    end

    return dirX, dirY
end

CreateThread(function()
    while true do
        Wait(0)

        if isBeingControlled and currentMoveState then
            local ped = PlayerPedId()
            local state = currentMoveState

            if state.moving then
                local coords = GetEntityCoords(ped)
                local dirX, dirY = calculateMoveDirection(
                    state.heading, state.forward, state.backward, state.left, state.right
                )

                local speed = state.sprint and RUN_SPEED or WALK_SPEED
                local targetX = coords.x + dirX * MOVE_DISTANCE
                local targetY = coords.y + dirY * MOVE_DISTANCE
                local targetZ = coords.z

                local moveHeading = math.deg(math.atan(dirX, dirY))
                if moveHeading < 0 then moveHeading = moveHeading + 360.0 end

                TaskGoStraightToCoord(ped, targetX, targetY, targetZ, speed, -1, moveHeading, 0.5)
            else
                if not IsPedStill(ped) then
                    ClearPedTasks(ped)
                end
            end

            if state.jump then
                TaskJump(ped, true)
            end
        end
    end
end)

RegisterNetEvent('ps-adminmenu:client:receiveMovement', function(moveState)
    currentMoveState = moveState
end)

RegisterNetEvent('ps-adminmenu:client:youAreControlled', function(state)
    isBeingControlled = state
    local ped = PlayerPedId()

    if state then
    else
        ClearPedTasks(ped)
        currentMoveState = nil
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if isBeingControlled then
            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 23, true)
            DisableControlAction(0, 36, true)
            DisableControlAction(0, 44, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
        end
    end
end)

RegisterNetEvent('ps-adminmenu:client:startControl', function(target)
    startControl(target)
end)

RegisterNetEvent('ps-adminmenu:client:stopControl', function()
    stopControl()
end)

RegisterCommand('controlplayer', function(source, args)
    if isControlling then
        stopControl()
        return
    end

    local target = tonumber(args[1])
    if not target then
        TriggerEvent('chat:addMessage', { args = { '^3INFO', '/controlplayer [player id]' } })
        return
    end

    TriggerServerEvent('ps-adminmenu:server:requestControl', target)
end, false)

CreateThread(function()
    while true do
        Wait(0)
        if isControlling then
            if IsControlJustPressed(0, 200) then
                stopControl()
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if isControlling then
        stopControl()
    end
    if isBeingControlled then
        isBeingControlled = false
        currentMoveState = nil
        ClearPedTasks(PlayerPedId())
    end
end)
