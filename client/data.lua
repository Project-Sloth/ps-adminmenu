local function GetVehicles()
    local vehicles = {}
    for _, v in pairs(QBCore.Shared.Vehicles) do
        local data = { name = v.name, model = v.model, }
        table.insert(vehicles, data)
    end
    return vehicles
end

local function GetItems()
    local items = {}
    for name, v in pairs(QBCore.Shared.Items) do
        local data = { name = name, label = v.label }
        table.insert(items, data)
    end
    return items
end

local function GetJobs()
    local jobs = {}
    for name, v in pairs(QBCore.Shared.Jobs) do
        local gradeDataList = {}

        for grade, gradeData in pairs(v.grades) do
            local gradeData = { name = gradeData.name, grade = grade, isboss = gradeData.isboss }
            table.insert(gradeDataList, gradeData)
        end
        local data = { name = name, label = v.label, grades = gradeDataList }
        table.insert(jobs, data)
    end
    return jobs
end

local function GetGangs()
    local gangs = {}
    for name, v in pairs(QBCore.Shared.Gangs) do
        local gradeDataList = {}

        for grade, gradeData in pairs(v.grades) do
            local gradeData = { name = gradeData.name, grade = grade, isboss = gradeData.isboss }
            table.insert(gradeDataList, gradeData)
        end
        local data = { name = name, label = v.label, grades = gradeDataList, }
        table.insert(gangs, data)
    end
    return gangs
end

local function GetLocations()
    local locations = {}
    for name, v in pairs(QBCore.Shared.Locations) do
        local data = { name = name, coords = v, }
        table.insert(locations, data)
    end
    return locations
end

local function GetStash()
    local locations = {}
    for name, v in pairs(QBCore.Shared.Locations) do
        local data = { name = name, coords = v, }
        table.insert(locations, data)
    end
    return locations
end

RegisterNetEvent('ps-adminmenu:client:printData', function()
    local data = GetJobs()
    print(json.encode(data))

    SendNUIMessage({
        action = "data",
        data = {
            vehicles = GetVehicles(),
            items = GetItems(),
            jobs = GetJobs(),
            gangs = GetGangs(),
            locations = GetLocations(),
        },
    })
end)
