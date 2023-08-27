

RegisterNetEvent('ps-adminmenu:server:PlaySoundRadius', function(id, sound)
    local ped = GetPlayerPed(id)
    local coords = GetEntityCoords(ped)

    TriggerEvent('InteractSound_CL:PlayWithinDistance', coords, 25.0, sound, 0.30)
end)