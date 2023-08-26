-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local playerid = inputData["Player ID"]
    local inv = Config.InventoryUsage
    if not (inv == "qb" or inv == "ox" or inv == "lj" or inv == "ps") then
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" or inv == "ps" then
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerid)
    elseif inv == "ox" then
        TriggerServerEvent("ps-adminmenu:server:OpenInv", playerid)
    end
end)

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(inputData, _, perms)
    if not PermsCheck(perms) then return end

    local stash = inputData["Stash"]
    local inv = Config.InventoryUsage
    if not (inv == "qb" or inv == "ox" or inv == "lj" or inv == "ps") then
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" or inv == "ps" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    elseif inv == "ox" then
        TriggerServerEvent("ps-adminmenu:server:OpenStash", stash)
    end
end)