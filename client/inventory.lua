-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local playerid = inputData["Player ID"]
    if Config.Inventory ~= 'ox_inventory' then
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerid)
    else
        TriggerServerEvent("ps-adminmenu:server:OpenInv", playerid)
    end
end)

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local stash = inputData["Stash"]
    if Config.Inventory ~= 'ox_inventory' then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    else
        TriggerServerEvent("ps-adminmenu:server:OpenStash", stash)
    end
end)
