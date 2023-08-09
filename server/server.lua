local QBCore = exports['qb-core']:GetCoreObject()

local function NoPerms(source)
    QBCore.Functions.Notify(source, Lang:t('error.no_perms'), 'error')
end

QBCore.Commands.Add('psadmin', 'Opens Adminmenu', {}, false, function(source, _)
    TriggerClientEvent('ps-adminmenu:client:openmenu', source)
end, 'mod')

RegisterNetEvent('ps-adminmenu:server:Getresources', function(data)
    local totalResources = GetNumResources()
    local resources = {}
    for i = 0, totalResources - 1 do
        local resourceName = GetResourceByFindIndex(i)
        local author = GetResourceMetadata(resourceName, "author")
        local version = GetResourceMetadata(resourceName, "version")
        local description = GetResourceMetadata(resourceName, "description")
        local resourceState = GetResourceState(resourceName)
        
        table.insert(resources, {
            name = resourceName,
            author = author,
            version = version,
            description = description,
            resourceState = resourceState,
        })
    end
    TriggerClientEvent('ps-adminmenu:client:UpdateResources', -1, resources)
end)

RegisterNetEvent('ps-adminmenu:server:changeResourceState', function(name, state)
    local src = source
    if state == "started" then
        StartResource(name)
        QBCore.Functions.Notify(source, Lang:t('info.started_resource'), 'primary')
    elseif state == "stopped" then
        StopResource(name)
        QBCore.Functions.Notify(source, Lang:t('info.stopped_resource'), 'primary')
    else
        StopResource(name)
        Wait(200)
        StartResource(name)
        QBCore.Functions.Notify(source, Lang:t('info.restarted_resource'), 'primary')
    end
end)

-- Get Players
lib.callback.register('ps-adminmenu:server:GetPlayers', function(source)
    local Players = {}
    local GetPlayers = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(GetPlayers) do
        local playerData = v.PlayerData
        
        Players[#Players + 1] = {
            id = k,
            name = playerData.charinfo.firstname .. ' ' .. playerData.charinfo.lastname,
            cid = playerData.citizenid,
            license = QBCore.Functions.GetIdentifier(k, 'license'),
            discord = QBCore.Functions.GetIdentifier(k, 'discord'),
            steam = QBCore.Functions.GetIdentifier(k, 'steam'),
            job = playerData.job.label .. ' - ' .. playerData.job.grade.name,
            dob = playerData.charinfo.birthdate,
            cash = playerData.money.cash,
            bank = playerData.money.bank,
            phone = playerData.charinfo.phone,
        
        }
    end
    table.sort(Players, function(a, b) return a.id < b.id end)
    return Players
end)

-- Admin Car
RegisterNetEvent('ps-adminmenu:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local Player = QBCore.Functions.GetPlayer(src)
    local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result[1] == nil then
        MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            Player.PlayerData.license,
            Player.PlayerData.citizenid,
            vehicle.model,
            vehicle.hash,
            json.encode(mods),
            plate,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.veh_owner"), 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.u_veh_owner"), 'error', 3000)
    end

end)

-- blackout
local Blackout = false
RegisterNetEvent('ps-adminmenu:server:ToggleBlackout', function(inputData)
    local src = source
    Blackout = not Blackout
    
    if Blackout then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.blackout", {value = "enabled"}), 'primary')
        while Blackout do
            Wait(0)
            exports["qb-weathersync"]:setBlackout(true)
        end
        exports["qb-weathersync"]:setBlackout(false)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.blackout", {value = "disabled"}), 'primary')
    end
end)

-- Ban Player
RegisterNetEvent('ps-adminmenu:server:BanPlayer', function(inputData)
    local src = source
    local playerid = inputData["Player ID"]
    local reason = inputData["Reason"]
    local time = inputData["Time"]
    if reason == nil then reason = "" end
    time = tonumber(time)
    local banTime = tonumber(os.time() + time)
    if banTime > 2147483647 then
        banTime = 2147483647
    end
    local timeTable = os.date('*t', banTime)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(playerid),
        QBCore.Functions.GetIdentifier(playerid, 'license'),
        QBCore.Functions.GetIdentifier(playerid, 'discord'),
        QBCore.Functions.GetIdentifier(playerid, 'ip'),
        reason,
        banTime,
        GetPlayerName(src)
    })
    if banTime >= 2147483647 then
        DropPlayer(playerid, Lang:t("info.banned") .. '\n' .. Lang:t("info.reason") .. reason .. Lang:t("info.ban_perm"))
    else
        DropPlayer(playerid, Lang:t("info.banned") .. '\n' .. Lang:t("info.reason") .. reason .. '\n' .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
    end
end)

-- Kill Player
RegisterNetEvent('ps-adminmenu:server:KillPlayer', function(inputData)
    local playerId = inputData["Player ID"]
    TriggerClientEvent('hospital:client:KillPlayer', playerId)
end)

-- Bring Player
RegisterNetEvent('ps-adminmenu:server:BringPlayer', function(inputData)
    local src = source
    local targetPed = inputData["Player ID"]
    
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(targetPed)
    CheckRoutingbucket(targetPed, src)
    SetEntityCoords(target, coords)
end)

-- Warn Player
RegisterNetEvent('ps-adminmenu:server:warnplayer', function(inputData)
    local targetPlayer = QBCore.Functions.GetPlayer(inputData["Player ID"])
    local msg = inputData["Reason"]
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    local warnId = 'WARN-' .. math.random(1111, 9999)
    if targetPlayer ~= nil then
        TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, {args = {"SYSTEM", Lang:t("info.warning_chat_message") .. GetPlayerName(source) .. "," .. Lang:t("info.reason") .. ": " .. msg}, color = 255, 0, 0})
        TriggerClientEvent('chat:addMessage', source, {args = {"SYSTEM", Lang:t("info.warning_staff_message") .. GetPlayerName(targetPlayer.PlayerData.source) .. ", for: " .. msg}, color = 255, 0, 0})
        MySQL.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
    end
end)
-- Teleport To Player
RegisterNetEvent('ps-adminmenu:server:TeleportToPlayer', function(inputData)
    local src = source
    
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local target = GetPlayerPed(tonumber(inputData["Player ID"]))
    if target ~= 0 then
        local coords = GetEntityCoords(target)
        CheckRoutingbucket(src, target)
        TriggerClientEvent('ps-adminmenu:client:TeleportToPlayer', src, coords)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.not_online'), 'error')
    end
end)

-- Teleport To Coords
RegisterNetEvent('ps-adminmenu:server:TeleportToCoords', function(inputData)
    local src = source
    local xdata = inputData["X"]
    local ydata = inputData["Y"]
    local zdata = inputData["Z"]
    
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if xdata and ydata and zdata then
        local x = tonumber((xdata:gsub(",", ""))) + .0
        local y = tonumber((ydata:gsub(",", ""))) + .0
        local z = tonumber((zdata:gsub(",", ""))) + .0
        TriggerClientEvent('ps-adminmenu:client:TeleportToCoords', src, x, y, z)
    
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.missing_args'), 'error')
    end

end)

-- Revive Player
RegisterNetEvent('ps-adminmenu:server:Revive', function(inputData)
    local src = source
    local id = inputData["Player ID"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if type(id) ~= 'string' and type(id) ~= 'number' then
        return
    end
    id = tonumber(id)
    
    TriggerClientEvent('hospital:client:Revive', id)
end)

-- Revive All
RegisterNetEvent('ps-adminmenu:server:ReviveAll', function()
    local src = source
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
    TriggerClientEvent('hospital:client:Revive', -1)
end)


-- Kick Player
RegisterNetEvent('ps-adminmenu:server:KickPlayer', function(inputData)
    local src = source
    local playerId = inputData["Player ID"]
    local reason = inputData["Reason"]
    if not QBCore.Functions.HasPermission(src, "admin") then NoPerms(src) return end
    if playerId == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if reason == nil then reason = "NONE" end
    DropPlayer(playerId, Lang:t("info.kicked") .. '\n' .. Lang:t("info.reason") .. reason)
end)

-- Clear Inventory
RegisterNetEvent('ps-adminmenu:server:ClearInventory', function(inputData)
    local src = source
    local playerId = tonumber(inputData["Player ID"])
    local Player = QBCore.Functions.GetPlayer(playerId)
    local inv = Config.InventoryUsage
    
    if not (inv == "qb" or inv == "ox" or inv == "lj" or inv == "ps") then
        ConfigInvInvalid()
        return;
    end
    if inv == "qb" or inv == "lj" or inv == "ps" then
        exports[inv .. "-inventory"]:ClearInventory(playerId, nil)
    elseif inv == "ox" then
        exports.ox_inventory:ClearInventory(playerId, nil)
    end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    QBCore.Functions.Notify(src, Lang:t("success.invcleared", {player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid}), 'Success', 7500)
end)

-- Clothing Menu
RegisterNetEvent('ps-adminmenu:server:ClothingMenu', function(inputData)
    local src = source
    local playerId = tonumber(inputData["Player ID"])
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if playerId == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    TriggerClientEvent('qb-clothing:client:openMenu', playerId)
    if playerId == src then
        TriggerClientEvent("ps-adminmenu:client:CloseUI", src)
    end
end)

-- Freeze Player
local frozen = false
RegisterNetEvent('ps-adminmenu:server:FreezePlayer', function(inputData)
    local src = source
    local playerId = tonumber(inputData["Player ID"])
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local target = GetPlayerPed(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    
    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
        QBCore.Functions.Notify(src, Lang:t("success.Frozen", {player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid}), 'Success', 7500)
    else
        frozen = false
        FreezeEntityPosition(target, false)
        QBCore.Functions.Notify(src, Lang:t("success.deFrozen", {player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " | " .. Player.PlayerData.citizenid}), 'Success', 7500)
    
    end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end

end)

-- Open Inv [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenInv', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(tonumber(data))
    exports.ox_inventory:forceOpenInventory(src, 'player', tonumber(data))
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
end)

-- Open Stash [ox side]
RegisterNetEvent('ps-adminmenu:server:OpenStash', function(data)
    local src = source
    exports.ox_inventory:forceOpenInventory(src, 'stash', data)
end)

-- Give Money
RegisterNetEvent('ps-adminmenu:server:GiveMoney', function(inputData)
    local src = source
    local playerId, amount, moneyType = inputData["Player ID"], inputData["Amount"], inputData["Type"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
    if moneyType == "crypto" then
        QBCore.Functions.Notify(src, Lang:t("success.give_money_crypto", {info = tonumber(amount), player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
    else
        QBCore.Functions.Notify(src, Lang:t("success.give_money", {info = tonumber(amount) .. "$", player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
    end
end)

-- Give Money to all
RegisterNetEvent('ps-adminmenu:server:GiveMoneyAll', function(inputData)
    local src = source
    local amount, moneyType = inputData["Amount"], inputData["Type"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        Player.Functions.AddMoney(tostring(moneyType), tonumber(amount))
        if moneyType == "crypto" then
            QBCore.Functions.Notify(src, Lang:t("success.give_money_all_crypto", {info = tonumber(amount)}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("success.give_money_all", {info = tonumber(amount) .. "$", moneyType = moneyType}), "success")
        end
    end
end)

-- Take Money
RegisterNetEvent('ps-adminmenu:server:TakeMoney', function(inputData)
    local src = source
    local playerId, amount, moneyType = inputData["Player ID"], inputData["Amount"], inputData["Type"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if string.len(amount) > 6 then return QBCore.Functions.Notify(src, Lang:t("error.amount_max"), "error", 5000) end
    if moneyType == "bank" then
        if Player.PlayerData.money.bank >= tonumber(amount) then
            Player.Functions.RemoveMoney("bank", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, Lang:t("success.take_money", {info = tonumber(amount) .. "$", player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("info.not_enough_money"), "primary")
        end
    elseif moneyType == "cash" then
        if Player.PlayerData.money.cash >= tonumber(amount) then
            Player.Functions.RemoveMoney("cash", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, Lang:t("success.take_money", {info = tonumber(amount) .. "$", player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("info.not_enough_money"), "primary")
        end
    elseif moneyType == "crypto" then
        if Player.PlayerData.money.crypto >= tonumber(amount) then
            Player.Functions.RemoveMoney("crypto", tonumber(amount), "state-fees")
            QBCore.Functions.Notify(src, Lang:t("success.take_money_crypto", {info = tonumber(amount), player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success")
        else
            QBCore.Functions.Notify(src, Lang:t("info.not_enough_money"), "primary")
        end
    end
end)

-- sit in vehicle
RegisterNetEvent('ps-adminmenu:server:SitInVehicle', function(inputData)
    local src = source
    local playerId = inputData["Player ID"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    local admin = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local vehicle = GetVehiclePedIsIn(targetPed, false)
    local seat = -1
    if vehicle ~= 0 then
        local coords = GetEntityCoords(targetPed)
        SetEntityCoords(admin, coords)
        
        for i = 0, 8, 1 do
            if GetPedInVehicleSeat(vehicle, i) == 0 then
                seat = i
                break
            end
        end
        Wait(100)
        if seat ~= -1 then
            SetPedIntoVehicle(admin, vehicle, seat)
            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.entered_vehicle"), 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_free_seats"), 'danger', 5000)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Player not inside a vehicle", 'danger', 5000)
    
    end
end)

-- Give Item
RegisterNetEvent('ps-adminmenu:server:GiveItem', function(inputData)
    local src = source
    local playerId, item, amount = inputData["Player ID"], inputData["Item"], inputData["Amount"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if amount == nil then amount = 1 end
    if Config.Inventory == "ox" then
        exports.ox_inventory:AddItem(Player, item, tonumber(amount))
    else
        Player.Functions.AddItem(item, tonumber(amount))
    end
    QBCore.Functions.Notify(src, Lang:t("success.give_item", {info = tonumber(amount) .. " " .. item, player = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname}), "success", 7500)
end)

-- Give Item to All
RegisterNetEvent('ps-adminmenu:server:GiveItemAll', function(inputData)
    local src = source
    local item, amount = inputData["Item"], inputData["Amount"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if amount == nil then amount = 1 end
    for _, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Config.Inventory == "ox" then
            exports.ox_inventory:AddItem(Player, item, tonumber(amount))
        else
            Player.Functions.AddItem(item, tonumber(amount))
        end
        QBCore.Functions.Notify(src, Lang:t("success.give_item_all", {info = tonumber(amount) .. " " .. item}), "success", 7500)
    end
end)

-- Server Announcement
RegisterNetEvent('ps-adminmenu:server:ServerAnnouncement', function(inputData)
    local src = source
    local message, length = inputData["Message"], inputData["Length"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if message == nil then QBCore.Functions.Notify(src, Lang:t("error.empty_input"), "error", 7500) return end
    if length == nil then length = 15 end
    QBCore.Functions.Notify(-1, "SERVER ANNOUNCEMENT: " .. message, "primary", length)
    TriggerEvent("InteractSound_SV:PlayOnAll", "pager", 0.40)
end)

-- Message Player
RegisterNetEvent('ps-adminmenu:server:MessagePlayer', function(inputData)
    local src = source
    local playerID, message, length = inputData["Player ID"], inputData["Message"], inputData["Length"]
    if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if playerID == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    if message == nil then QBCore.Functions.Notify(src, Lang:t("error.empty_input"), "error", 7500) return end
    if length == nil then length = 15 end
    QBCore.Functions.Notify(playerID, "PRIVATE ADMIN MESSAGE: " .. message, "primary", length)
    TriggerEvent("InteractSound_SV:PlayOnAll", "pager", 0.30)
end)

function permsToString(perms)
    local allowedPerms = {}
    for k, v in pairs(perms) do
        if v then
            table.insert(allowedPerms, k)
        end
    end
    return table.concat(allowedPerms, ", ")
end

-- Check Perms
RegisterNetEvent('ps-adminmenu:server:CheckPerms', function(inputData)
    local src = source
    local playerId = inputData["Player ID"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 15000) end
    local perms = QBCore.Functions.GetPermission(Player.PlayerData.source)
    local permsStr = permsToString(perms)
    --if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if permsStr == "" then permsStr = "NONE" end
    QBCore.Functions.Notify(src, Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " got [ " .. permsStr .. " ] Permissions.", "primary", 7500)
end)

-- Set Perms
RegisterNetEvent('ps-adminmenu:server:SetPerms', function(inputData)
    local src = source
    local playerId, permissions = inputData["Player ID"], inputData["Permissions"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    --if not QBCore.Functions.HasPermission(src, "mod") then NoPerms(src) return end
    if permissions == nil then return QBCore.Functions.Notify(src, Lang:t("error.empty_input"), 'error', 15000) end
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 15000) end
    QBCore.Functions.AddPermission(Player.PlayerData.source, permissions)
    QBCore.Functions.Notify(src, Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " got added " .. permissions .. " Permissions.", "primary", 7500)
    QBCore.Functions.Notify(playerId, "Added " .. permissions .. " Permissions.", "primary", 7500)
end)

-- Set Job
RegisterNetEvent('ps-adminmenu:server:SetJob', function(inputData)
    local src = source
    local playerId, Job, grade = inputData["Player ID"], inputData["Job"], inputData["Grade"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    
    Player.Functions.SetJob(tostring(Job), tonumber(grade))
end)

-- Set Gang
RegisterNetEvent('ps-adminmenu:server:SetGang', function(inputData)
    local src = source
    local playerId, Gang, grade = inputData["Player ID"], inputData["Gang"], inputData["Grade"]
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player == nil then return QBCore.Functions.Notify(src, Lang:t("error.not_online"), 'error', 7500) end
    
    Player.Functions.SetGang(tostring(Gang), tonumber(grade))
end)

-- toggle namens and blips
local players = {}

RegisterNetEvent('ps-adminmenu:server:GetPlayersForBlips', function()
    local src = source
    TriggerClientEvent('ps-adminmenu:client:Show', src, players)
end)

-- Fix Vehicle for player
RegisterNetEvent('ps-adminmenu:server:FixVehFor', function(inputData)
    local src = source
    local playerId = inputData['Player ID']
    local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Player then
        TriggerClientEvent('iens:repaira', Player.PlayerData.source)
        TriggerClientEvent('vehiclemod:client:fixEverything', Player.PlayerData.source)
    else
        TriggerClientEvent('QBCore:Notify', src, "player not online", "error")
    end
end)

CreateThread(function()
    while true do
        local tempPlayers = {}
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local targetped = GetPlayerPed(v)
            local ped = QBCore.Functions.GetPlayer(v)
            tempPlayers[#tempPlayers + 1] = {
                name = (ped.PlayerData.charinfo.firstname or '') .. ' ' .. (ped.PlayerData.charinfo.lastname or '') .. ' | CID: ' .. ped.PlayerData.citizenid .. ' (' .. (GetPlayerName(v) or '') .. ')',
                id = v,
                coords = GetEntityCoords(targetped),
                cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
                citizenid = ped.PlayerData.citizenid,
                sources = GetPlayerPed(ped.PlayerData.source),
                sourceplayer = ped.PlayerData.source
            
            }
        end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(tempPlayers, function(a, b)
            return a.id < b.id
        end)
        players = tempPlayers
        Wait(1500)
    end
end)

-- Spectate
local spectating = {}
RegisterNetEvent('ps-adminmenu:server:SpectateTarget', function(inputData)
    local target = inputData['Player ID']
    local type = "1"
    if target == source then return QBCore.Functions.Notify(source, 'Cannot Spectate yourself!', 'error', 7500) end
    if spectating[source] then type = "0" end
    TriggerEvent('ps-adminmenu:spectate', target, type == "1", source)
    CheckRoutingbucket(source, target)

end)
AddEventHandler('ps-adminmenu:spectate', function(target, on, source)
    local tPed = GetPlayerPed(target)
    if DoesEntityExist(tPed) then
        if not on then
            TriggerClientEvent('ps-adminmenu:cancelSpectate', source)
            spectating[source] = false
            FreezeEntityPosition(GetPlayerPed(source), false)
            TriggerClientEvent('ps-adminmenu:client:toggleNames', source)
        elseif on then
            TriggerClientEvent('ps-adminmenu:requestSpectate', source, NetworkGetNetworkIdFromEntity(tPed), target, GetPlayerName(target))
            spectating[source] = true
            TriggerClientEvent('ps-adminmenu:client:toggleNames', source)
        
        end
    end
end)

RegisterNetEvent('ps-adminmenu:spectate:teleport', function(target)
    local source = source
    local ped = GetPlayerPed(target)
    if DoesEntityExist(ped) then
        local targetCoords = GetEntityCoords(ped)
        SetEntityCoords(GetPlayerPed(source), targetCoords.x, targetCoords.y, targetCoords.z - 10)
        FreezeEntityPosition(GetPlayerPed(source), true)
    end
end)

-- Set on fire
RegisterNetEvent('ps-adminmenu:server:SetOnFire', function(inputData)
    local playerId, time = inputData["Player ID"], inputData["Time"]
    TriggerClientEvent('ps-adminmenu:client:SetOnFire', playerId, time)
    QBCore.Functions.Notify(source, Lang:t("success.set_on_fire"), 'success')

end)

-- Explode Player
RegisterNetEvent('ps-adminmenu:server:ExplodePlayer', function(inputData)
    local playerId, damage = inputData["Player ID"], inputData["Damage"]
    
    TriggerClientEvent('ps-adminmenu:client:ExplodePlayer', playerId, damage)
    QBCore.Functions.Notify(source, Lang:t("success.explode_player"), 'success')
end)

lib.callback.register('ps-adminmenu:server:GetVehicles', function(source, cid)
    local result = MySQL.query.await('SELECT vehicle, plate, fuel, engine, body FROM player_vehicles WHERE citizenid = ?', {cid})
    local Vehicles = {}
    
    for k, v in pairs(result) do
        local vehicleData = QBCore.Shared.Vehicles[v.vehicle]
        if vehicleData then
            Vehicles[#Vehicles + 1] = {
                id = k,
                cid = cid,
                label = vehicleData["brand"] .. " | " .. vehicleData["name"] .. " | " .. v.plate,
                brand = vehicleData["brand"],
                model = vehicleData["model"],
                plate = v.plate,
                fuel = v.fuel,
                engine = v.engine,
                body = v.body
            }
        end
    end
    
    table.sort(Vehicles, function(a, b)
        return a.label < b.label
    end)
    
    return Vehicles
end)

lib.callback.register('ps-adminmenu:server:GetVehicleByPlate', function(source, plate)
    local result = MySQL.query.await('SELECT vehicle FROM player_vehicles WHERE plate = ?', {plate})
    local veh = result[1] and result[1].vehicle or {}
    return veh
end)

lib.callback.register('ps-adminmenu:server:hasPerms', function(source, perms)
    local hasPerms = QBCore.Functions.HasPermission(source, perms)
    if not hasPerms then return NoPerms(source) end
    return true
end)

-- Chat Backend
local messages = {}

RegisterNetEvent('ps-adminmenu:server:sendMessageServer', function(message, citizenid, fullname)
    local time = os.time() * 1000
    table.insert(messages, {message = message, citizenid = citizenid, fullname = fullname, time = time})
end)

lib.callback.register('ps-adminmenu:callback:GetMessages', function(source)
    return messages
end)

-- Metrics Backend
lib.callback.register('ps-adminmenu:server:getServerMetrics', function(source)
    local src = source
    local ServerMetrics = {
        TotalCash = 0,
        TotalBank = 0,
        TotalItems = 0
    }
    
    local results = MySQL.query.await("SELECT money, inventory FROM `players`", {})
    ServerMetrics.CharacterCount = #results
    
    for _, v in ipairs(results) do
        local money = json.decode(v.money)
        if money then
            ServerMetrics.TotalCash = ServerMetrics.TotalCash + math.floor(money.cash)
            ServerMetrics.TotalBank = ServerMetrics.TotalBank + math.floor(money.bank)
        end
        
        local inv = json.decode(v.inventory)
        if inv then
            ServerMetrics.TotalItems = ServerMetrics.TotalItems + #inv
        end
    end
    
    ServerMetrics.VehicleCount = #MySQL.query.await("SELECT vehicle FROM `player_vehicles`", {})
    ServerMetrics.BansCount = #MySQL.query.await("SELECT name FROM `bans`", {})
    ServerMetrics.UniquePlayers = #MySQL.query.await("SELECT DISTINCT `license` FROM `players`", {})
    
    return {ServerMetrics}
end)

--- Checks if the source is inside of the target's routingbucket
--- if not set the source's routingbucket to the target's
--- @param source string - The player's ID
--- @param target string - The player's ID
function CheckRoutingbucket(source, target)
    local sourceBucket = GetPlayerRoutingBucket(source)
    local targetBucket = GetPlayerRoutingBucket(target)
    if sourceBucket ~= targetBucket then SetPlayerRoutingBucket(source, targetBucket) QBCore.Functions.Notify(source, 'Routing Bucket set to: %s', 'error', 7500):format(targetBucket) end
end

-- Set Routing bucket
RegisterNetEvent('ps-adminmenu:server:SetRouting', function(inputData)
    local target, bucket = inputData['Player ID'], inputData['Bucket']
    
    local currentBucket = GetPlayerRoutingBucket(target)
    if bucket == currentBucket then return QBCore.Functions.Notify(source, 'Tried to place %s in the same bucket', 'error', 7500):format(target) end
    SetPlayerRoutingBucket(target, bucket)
    QBCore.Functions.Notify(source, 'Routing bucket set for: %s to bucket: %s', 'success', 7500):format(target, bucket)
end)
