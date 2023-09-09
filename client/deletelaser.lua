local function DrawEntityViewTextInWorld(entity, coords)
    local onScreen, posX, posY = World3dToScreen2d(coords.x, coords.y, coords.z)
    local colorWhite = { r = 255, g = 255, b = 255, a = 200 }
    local textOffsetY = 0.015
    local leftPadding = 0.005
    local topPadding = 0.01
    local botPadding = 0.02
    local rectWidth = 0.12
    if onScreen then
        local data = GetEntityInfo(entity)
        local count = #data
        local offSetCount = ((count - 2) * textOffsetY) / count
        local rectHeight = (count * offSetCount) + botPadding

        DrawRect(posX, posY, rectWidth, rectHeight, colorWhite.r, colorWhite.g, colorWhite.b, colorWhite.a)

        local drawPosY = posY - rectHeight / 2 + topPadding
        for k, v in ipairs(data) do
            if k > 2 then
                SetTextScale(0.25, 0.25)
                SetTextFont(4)
                SetTextDropshadow(1.0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextColour(255, 255, 255, 215)
                SetTextJustification(1)
                SetTextEntry("STRING")
                AddTextComponentString(v)
                DrawText(posX - rectWidth / 2 + leftPadding, drawPosY)
                drawPosY = drawPosY + textOffsetY
            end
        end
    end
end

local function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =
    {
        x = 0.5 * (max.x - min.x),
        y = 0.5 * (max.y - min.y),
        z = 0.5 * (max.z - min.z)
    }

    -- Calculate the eight bounding box edges
    local edges = {}
    edges[1] = position - dim.y * rightVector - dim.x * forwardVector - dim.z * upVector
    edges[2] = edges[1] + 2 * dim.y * rightVector
    edges[3] = edges[2] + 2 * dim.z * upVector
    edges[4] = edges[1] + 2 * dim.z * upVector
    edges[5] = position + dim.y * rightVector + dim.x * forwardVector + dim.z * upVector
    edges[6] = edges[5] - 2 * dim.y * rightVector
    edges[7] = edges[6] - 2 * dim.z * upVector
    edges[8] = edges[5] - 2 * dim.z * upVector

    -- Draw lines to connect the edges and create the bounding box
    for i = 1, 4 do
        local j = i % 4 + 1
        DrawLine(edges[i].x, edges[i].y, edges[i].z, edges[j].x, edges[j].y, edges[j].z, color.r, color.g, color.b, color.a)
        DrawLine(edges[i + 4].x, edges[i + 4].y, edges[i + 4].z, edges[j + 4].x, edges[j + 4].y, edges[j + 4].z, color.r, color.g, color.b, color.a)
        DrawLine(edges[i].x, edges[i].y, edges[i].z, edges[i + 4].x, edges[i + 4].y, edges[i + 4].z, color.r, color.g, color.b, color.a)
    end
end

local function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

-- Toggle Delete Laser
local deleteLaser = false
RegisterNetEvent('ps-adminmenu:client:ToggleDeleteLaser', function()
    local x = 0.4
    local y = 0.025
    deleteLaser = not deleteLaser
    CreateThread(function()
        while true do
            local wait = 7
            if deleteLaser then
                local color = {r = 255, g = 255, b = 255, a = 200}
                local position = GetEntityCoords(PlayerPedId())
                local hit, coords, entity = RayCastGamePlayCamera(1000.0)
                if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                    local entityCoord = GetEntityCoords(entity)
                    local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                    DrawEntityBoundingBox(entity, color)
                    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                    --Draw2DText('Obj: ~b~' .. entity .. '~w~ Model: ~b~' .. GetEntityModel(entity), 4, {255, 255, 255}, 0.4, 0.55, 0.888)
                    --Draw2DText('If you want to delete the object click on ~g~E', 4, {255, 255, 255}, 0.4, 0.55, 0.888 + 0.025)
                    if IsControlJustReleased(0, 38) then
                        SetEntityAsMissionEntity(entity, true, true)
                        DeleteEntity(entity)
                    end
                elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                    DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
                end
            else
                local wait = 500
            end
            Wait(wait)
        end
    end)
end)