-- Set on fire
RegisterNetEvent('ps-adminmenu:client:SetOnFire', function(time)
    if not time then time = 10 end
    local timer = time * 1000
    StartEntityFire(cache.serverId)
    Wait(timer)
    StopEntityFire(cache.serverId)
end)

-- Explode player
RegisterNetEvent('ps-adminmenu:client:ExplodePlayer', function(damage)
    local coords = GetEntityCoords(cache.serverId)
    if damage == nil then damage = "nodamage" end
    if damage == "nodamage" then
        AddExplosion(coords.x, coords.y, coords.z, 'EXPLOSION_TANKER', 2.0, true, false, 2.0)
    else
        AddExplosion(coords.x, coords.y, coords.z, 2, 0.9, 1, 0, 1065353216, 0)
    end
end)

-- Play Sound
RegisterNetEvent('ps-adminmenu:client:PlaySound', function(data, selectedData)

    if not CheckPerms(data.perms) then return end

    local player = selectedData["Player"].value
    local coords = GetEntityCoords(GetPlayerPed(player))
    local type = selectedData["Type"].value
    local sound = selectedData["Sound"].value

    print(player, type, sound, coords)
    if type == "player" or "" or nil then
        TriggerServerEvent("InteractSound_SV:PlayOnOne", player, sound, 0.30)
    elseif type == "radius" then
        TriggerEvent('InteractSound_CL:PlayWithinDistance', coords, 25.0, sound, 0.30)
    end
end)
