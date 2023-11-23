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
RegisterNetEvent('ps-adminmenu:client:TeleportToCoords', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    local coordsStr = selectedData["Coords"].value
    local x, y, z, heading

    x, y, z, heading = coordsStr:match("(-?%d+%.?%d*),%s*(-?%d+%.?%d*),?%s*(-?%d*%.?%d*),?%s*(-?%d*%.?%d*)")

    if not x or not y then
        x, y, z, heading = coordsStr:match("(-?%d+%.?%d*)%s+(-?%d+%.?%d*)%s*(-?%d*%.?%d*)%s*(-?%d*%.?%d*)")
    end

    x = tonumber(x)
    y = tonumber(y)
    z = tonumber(z or 0)
    heading = tonumber(heading or 0)

    if x and y then
        lastCoords = GetEntityCoords(cache.ped)
        if heading and heading ~= 0 then
            SetEntityHeading(cache.ped, heading)
        end
        SetPedCoordsKeepVehicle(cache.ped, x, y, z)
    end
end)

-- Teleport to Locaton
RegisterNetEvent('ps-adminmenu:client:TeleportToLocation', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local coords = selectedData["Location"].value

    lastCoords = GetEntityCoords(cache.ped)
    SetPedCoordsKeepVehicle(cache.ped, coords.x, coords.y, coords.z)
end)

-- Teleport back
RegisterNetEvent('ps-adminmenu:client:TeleportBack', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end

    if lastCoords then
        local coords = GetEntityCoords(cache.ped)
        teleport(lastCoords.x, lastCoords.y, lastCoords.z)
        lastCoords = coords
    end
end)
