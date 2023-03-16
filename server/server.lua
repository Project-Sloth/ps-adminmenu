QBCore = exports['qb-core']:GetCoreObject()

local frozen = false
local permissions = {
    ['kill'] = 'admin',
    ['ban'] = 'admin',
    ['noclip'] = 'admin',
    ['kickall'] = 'admin',
    ['kick'] = 'admin',
    ["revive"] = "admin",
    ["freeze"] = "admin",
    ["goto"] = "admin",
    ["spectate"] = "admin",
    ["intovehicle"] = "admin",
    ["bring"] = "admin",
    ["inventory"] = "admin",
    ["clothing"] = "admin"
}
local players = {}

-- Get Dealers
QBCore.Functions.CreateCallback('test:getdealers', function(_, cb)
    cb(exports['qb-drugs']:GetDealers())
end)

-- Get Players
QBCore.Functions.CreateCallback('test:getplayers', function(_, cb) -- WORKS
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-admin:server:getrank', function(source, cb)
    if QBCore.Functions.HasPermission(source, 'god') or IsPlayerAceAllowed(source, 'command') then
        cb(true)
    else
        cb(false)
    end
end)

-- Functions
local function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end
-- Ban Player

RegisterNetEvent('ps-adminmenu:server:ban', function(player, reason, time)
    print(player, reason, time)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
        time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date('*t', banTime)
        MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player),
            QBCore.Functions.GetIdentifier(player, 'license'),
            QBCore.Functions.GetIdentifier(player, 'discord'),
            QBCore.Functions.GetIdentifier(player, 'ip'),
            reason,
            banTime,
            GetPlayerName(src)
        })
        
        if banTime >= 2147483647 then
            DropPlayer(player, "You have been permanently banned for: " .. reason)
        else
            DropPlayer(player, "You have been banned for: " .. reason .. '\n Expires: ' .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'])
        end
    else
        BanPlayer(src)
    end
end)

function GetAllResources(src)
    local src = src

    local resources = {}
    local max = GetNumResources() - 1
    for i = 0, max do
        local resName = GetResourceByFindIndex(i)
        local resDesc = GetResourceMetadata(resName, 'description')

        if resDesc ~= nil then
            resDesc = nil
        end

        local currentRes = {
            name = resName,
            status = GetResourceState(resName),
            author = GetResourceMetadata(resName, 'author'),
            version = GetResourceMetadata(resName, 'version'),
            description = resDesc
        }
        table.insert(resources, currentRes)
    end
    Wait(200)
    return resources
end

RegisterNetEvent('ps-adminmenu:server:updateResource', function(optionalSrc)
    local src = optionalSrc or source
    local resources = GetAllResources(src)
    TriggerClientEvent('ps-adminmenu:client:updateResources', src, resources)
end)
 

QBCore.Functions.CreateCallback('ps-adminmenu:server:GetPlayers', function(_, cb)
    local players = QBCore.Functions.GetPlayers()
    cb(players)
end)