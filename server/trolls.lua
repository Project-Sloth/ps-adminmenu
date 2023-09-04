-- Freeze Player
local frozen = false
RegisterNetEvent('ps-adminmenu:server:FreezePlayer', function(data, selectedData)
    if not CheckPerms(data.perms) then return end
    local src = source

    local playerId = selectedData["Player"].value

    local target = GetPlayerPed(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)

    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
        QBCore.Functions.Notify(src, locale("Frozen", {player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid}), 'Success', 7500)
    else
        frozen = false
        FreezeEntityPosition(target, false)
        QBCore.Functions.Notify(src, locale("deFrozen", {player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid}), 'Success', 7500)

    end
    if Player == nil then return QBCore.Functions.Notify(src, locale("not_online"), 'error', 7500) end

end)