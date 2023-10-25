local ObjectList = require "data.object"

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
local activeLaser = false
RegisterNetEvent('ps-adminmenu:client:ToggleLaser', function()
    local x = 0.4
    local y = 0.025
    activeLaser = not activeLaser
    CreateThread(function()
        while true do
            local wait = 7
            if activeLaser then
                local color = {r = 255, g = 255, b = 255, a = 200}
                local position = GetEntityCoords(PlayerPedId())
                local hit, coords, entity = RayCastGamePlayCamera(1000.0)
                local objectData = {}

                DisableControlAction(0, 200)
                DisableControlAction(0, 26)

                if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                    local entityCoord = GetEntityCoords(entity)
                    local heading = GetEntityHeading(entity)
                    local model = GetEntityModel(entity)
                    local minimum, maximum = GetModelDimensions(model)
                    DrawEntityBoundingBox(entity, color)
                    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)

                    objectData.hash = model
                    objectData.name = ObjectList[model]
                    objectData.coords = ("vec4(%s, %s, %s, %s)"):format(entityCoord.x, entityCoord.y, entityCoord.z, heading)
                    
                    if IsControlJustReleased(0, 38) then
                        SetEntityAsMissionEntity(entity, true, true)
                        DeleteEntity(entity)
                    end

                    if IsDisabledControlJustReleased(0, 26) then
                        lib.setClipboard(json.encode(objectData, {indent = true}))
                    end
                
                elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                    DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                    DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
                end

                if IsDisabledControlJustReleased(0, 200) then
                    activeLaser = not activeLaser
                end
                
                SendNUIMessage({
                    action = "showEntityInfo",
                    data = {
                        show = true,
                        hash = objectData.hash or "",
                        name = objectData.name or "",
                    }
                })
            else
                local wait = 500
                SendNUIMessage({
                    action = "showEntityInfo",
                    data = {
                        show = false,
                    }
                })
            end
            Wait(wait)
        end
    end)
end)