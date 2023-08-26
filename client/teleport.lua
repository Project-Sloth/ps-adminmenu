local lastCoords

local function teleport(x, y, z)
    if cache.vehicle then
        return SetPedCoordsKeepVehicle(cache.ped, x, y, z)
    end
    SetEntityCoords(cache.ped, x, y, z, false, false, false, false)
end

-- Teleport to player
RegisterNetEvent('ps-adminmenu:client:TeleportToPlayer', function(coords)
    lastCoords = GetEntityCoords(cache.ped)
    SetPedCoordsKeepVehicle(cache.ped, coords.x, coords.y, coords.z)
end)

-- Teleport to coords
RegisterNetEvent('ps-adminmenu:client:TeleportToCoords', function(x, y, z, h)
    lastCoords = GetEntityCoords(cache.ped)
    SetPedCoordsKeepVehicle(cache.ped, x, y, z)
    SetEntityHeading(cache.ped, h or GetEntityHeading(cache.ped))
end)

-- Teleport back
RegisterNetEvent('ps-adminmenu:client:TeleportBack', function(_, _, perms)
    if not PermsCheck(perms) then return end

    if lastCoords then
        local coords = GetEntityCoords(cache.ped)
        teleport(lastCoords.x, lastCoords.y, lastCoords.z)
        lastCoords = coords
    end
end)
