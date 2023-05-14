QBCore = exports['qb-core']:GetCoreObject()

-- Admin Car
RegisterNetEvent('ps-adminmenu:client:Admincar', function(data)
	print("AdminCarTriggerd")
end)

-- Invisible
RegisterNetEvent('ps-adminmenu:client:ToggleInvisible', function(data)
    local ped = PlayerPedId()
    if not invisible then
        invisible = true
        SetEntityVisible(ped, false, 0)
    else
        invisible = false
        SetEntityVisible(ped, true, 0)
    end
end)