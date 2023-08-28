-- Clothing Menu Main Event
RegisterNetEvent('ps-adminmenu:server:ClothingMenu', function(data, selectedData)
    if not CheckPerms(data.perms) then return end

    local src = source
    local playerId = tonumber(selectedData["Player"].value)

    if playerId == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
        TriggerClientEvent('qb-clothing:client:openMenu', playerId)
    if playerId == src then
        TriggerClientEvent("ps-adminmenu:client:CloseUI", src)
    end
end)