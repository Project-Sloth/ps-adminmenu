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