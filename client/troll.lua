-- Set on fire
RegisterNetEvent('ps-adminmenu:client:SetOnFire', function()
    StartEntityFire(cache.ped)
    Wait(10000)
    StopEntityFire(cache.ped)
end)

-- Explode player
RegisterNetEvent('ps-adminmenu:client:ExplodePlayer', function()
    local coords = GetEntityCoords(cache.ped)
    AddExplosion(coords.x, coords.y, coords.z, 7, 3.0, true, false, 10.0)
end)

-- Play Sound
RegisterNetEvent('ps-adminmenu:client:PlaySound', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local player = selectedData["Player"].value
    local sound = selectedData["Sound"].value

    TriggerServerEvent("InteractSound_SV:PlayOnOne", player, sound, 0.30)
end)

-- Drunk Player
RegisterNetEvent('ps-adminmenu:client:InitiateDrunkEffect', function()
    local playerPed = cache.ped
    lib.requestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    Wait(650)
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedIsDrunk(playerPed, true)
    ShakeGameplayCam("DRUNK_SHAKE", 2.0)
    Wait(30000) -- Time To Be Drunk
    SetPedMoveRateOverride(playerPed, 1.0)
    SetRunSprintMultiplierForPlayer(playerPed, 1.0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(playerPed, 1000)
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)
