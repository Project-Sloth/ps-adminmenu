-- Open Inventory
RegisterNetEvent('ps-adminmenu:client:openInventory', function(data, selectedData)
    local player = selectedData["Player"].value

    if not CheckPerms(data.perms) then return end

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("ps-adminmenu:server:OpenInv", player )
    else
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", player )
    end
end)

-- Open Stash
RegisterNetEvent('ps-adminmenu:client:openStash', function(data, selectedData)
    local stash = selectedData["Stash"].value
    if not CheckPerms(data.perms) then return end

    if Config.Inventory == 'ox_inventory' then
        TriggerServerEvent("ps-adminmenu:server:OpenStash", stash)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring(stash))
        TriggerEvent("inventory:client:SetCurrentStash", tostring(stash))
    end
end)
