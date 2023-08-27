-- Returns a list of vehicles from QBCore.Shared.Vehicles
local function GetVehicles()
    local vehicles = {}
    for _, v in pairs(QBCore.Shared.Vehicles) do
        table.insert(vehicles, { label = v.name, value = v.model })
    end
    return vehicles
end

-- Returns a list of items from QBCore.Shared.Items
local function GetItems()
    local items = {}

    local ItemsData = QBCore.Shared.Items

    if Config.Inventory == "ox" then
        ItemsData = exports.ox_inventory:Items()
    end

    for name, v in pairs(ItemsData) do
        table.insert(items, { label = v.label, value = name })
    end
    return items
end

-- Returns a list of jobs from QBCore.Shared.Jobs
local function GetJobs()
    local jobs = {}
    for name, v in pairs(QBCore.Shared.Jobs) do
        local gradeDataList = {}

        for grade, gradeData in pairs(v.grades) do
            table.insert(gradeDataList, { name = gradeData.name, grade = grade, isboss = gradeData.isboss })
        end

        table.insert(jobs, { label = v.label, value = name, grades = gradeDataList })
    end
    return jobs
end

-- Returns a list of gangs from QBCore.Shared.Gangs
local function GetGangs()
    local gangs = {}
    for name, v in pairs(QBCore.Shared.Gangs) do
        local gradeDataList = {}

        for grade, gradeData in pairs(v.grades) do
            table.insert(gradeDataList, { name = gradeData.name, grade = grade, isboss = gradeData.isboss })
        end

        table.insert(gangs, { label = v.label, value = name, grades = gradeDataList })
    end
    return gangs
end

-- Returns a list of locations from QBCore.Shared.Loactions
local function GetLocations()
    local locations = {}
    for name, v in pairs(QBCore.Shared.Locations) do
        table.insert(locations, { label = name, value = v, })
    end
    return locations
end

-- Sends data to the UI on resource start
function GetData()
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
end
