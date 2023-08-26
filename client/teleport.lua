local lastCoords

local function teleport(vehicle, x, y, z)
    local ped = PlayerPedId()
    if vehicle then
        return SetPedCoordsKeepVehicle(ped, x, y, z)
    end
    SetEntityCoords(ped, x, y, z, false, false, false, false)
end

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

-- Teleport back
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
