local oldPos = nil
local spectateInfo = {
    toggled = false,
    target = 0,
    targetPed = 0
}

RegisterNetEvent('ps-adminmenu:requestSpectate', function(targetPed, target, name)
    oldPos = GetEntityCoords(cache.ped)
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
    SetEntityVisible(cache.ped, true, false)
    spectateInfo = { toggled = false, target = 0, targetPed = 0 }
    RequestCollisionAtCoord(oldPos.x, oldPos.y, oldPos.z)
    SetEntityCoords(cache.ped, oldPos.x, oldPos.y, oldPos.z)
    oldPos = nil
end)

CreateThread(function()
    while true do
        Wait(0)
        if spectateInfo['toggled'] then
            local targetPed = NetworkGetEntityFromNetworkId(spectateInfo.targetPed)
            if DoesEntityExist(targetPed) then
                SetEntityVisible(cache.ped, false, false)
                if not NetworkIsInSpectatorMode() then
                    local c = GetEntityCoords(targetPed)
                    RequestCollisionAtCoord(c.x, c.y, c.z)
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
