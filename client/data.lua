local PedList = require "data.ped"

-- Returns a list of vehicles from QBCore.Shared.Vehicles
local function GetVehicles()
    local vehicles = {}
    local res = lib.callback.await('ps-adminmenu:callback:GetVehicles', false)
    for _,v in pairs(res) do
        vehicles[#vehicles + 1] = { label = v.name, value = v.model }
    end
    return vehicles
end

-- Returns a list of items from QBCore.Shared.Items
local function GetItems()
    local items = {}
    local itemsData = {}

    if Config.Inventory == "ox_inventory" then
        itemsData = exports.ox_inventory:Items()
    else
        itemsData = lib.callback.await('ps-adminmenu:callback:GetESXItems', false)
    end

    for n, v in pairs(itemsData) do
        items[#items + 1] = {label = v.label, value = n}
    end
    return items
end

-- Returns a list of jobs from QBCore.Shared.Jobs
local function GetJobs()
    local jobs = {}

    local jobList = lib.callback.await('ps-adminmenu:callback:GetESXJobs', false)
    local gradeDataList = {}
    for _, v in pairs(jobList) do
        for _, gradeData in pairs(v.grades) do
            gradeData['skin_male'] = nil -- Removed for better debug
            gradeData['skin_female'] = nil -- Removed for better debug
            gradeDataList[#gradeDataList + 1] = { name = gradeData.name, grade = gradeData.grade, isboss = false }
        end
        jobs[#jobs + 1] = { label = v.label, value = v.name, grades = gradeDataList }
    end
    return jobs
end

-- Sends data to the UI on resource start
function GetData()
    SendNUIMessage({
        action = "data",
        data = {
            vehicles = GetVehicles(),
            items = GetItems(),
            jobs = GetJobs(),
            pedlist = PedList
        },
    })
end
