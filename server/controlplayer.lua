local activeControls = {}

local function getSelectedDataEntry(selectedData, aliases)
    if type(selectedData) ~= 'table' then return nil end

    local keys = type(aliases) == 'table' and aliases or { aliases }
    for _, key in ipairs(keys) do
        if key and selectedData[key] ~= nil then
            return selectedData[key]
        end
    end

    return nil
end

function GetSelectedDataValue(selectedData, aliases, defaultValue)
    local entry = getSelectedDataEntry(selectedData, aliases)
    if entry == nil then return defaultValue end

    if type(entry) == 'table' then
        if entry.value ~= nil then return entry.value end
        if entry.label ~= nil then return entry.label end
    end

    return entry
end

RegisterNetEvent('ps-adminmenu:server:requestControl', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(source, data.perms) then return end

    local src = source

    local targetId = tonumber(GetSelectedDataValue(selectedData, { "Player", "Oyuncu" }))
    if not targetId then return end

    if activeControls[src] then
        TriggerClientEvent('ps-adminmenu:client:stopControl', src)
        return
    end

    local targetName = GetPlayerName(targetId)
    if not targetName then
        TriggerClientEvent('chat:addMessage', src, { args = { '^1ERROR', 'Player is not online.' } })
        return
    end

    if src == targetId then
        TriggerClientEvent('chat:addMessage', src, { args = { '^1ERROR', 'You cannot control yourself.' } })
        return
    end

    activeControls[src] = targetId
    TriggerClientEvent('ps-adminmenu:client:youAreControlled', targetId, true)
    TriggerClientEvent('ps-adminmenu:client:startControl', src, targetId)
end)

RegisterNetEvent('ps-adminmenu:server:sendMovement', function(moveState)
    local src = source
    local targetId = activeControls[src]

    if not targetId then return end
    if not GetPlayerName(targetId) then return end

    TriggerClientEvent('ps-adminmenu:client:receiveMovement', targetId, moveState)
end)

RegisterNetEvent('ps-adminmenu:server:stopControl', function()
    local src = source
    local targetId = activeControls[src]

    if targetId then
        TriggerClientEvent('ps-adminmenu:client:youAreControlled', targetId, false)

        activeControls[src] = nil
    end
end)

AddEventHandler('playerDropped', function()
    local src = source

    local targetId = activeControls[src]
    if targetId then
        TriggerClientEvent('ps-adminmenu:client:youAreControlled', targetId, false)
        activeControls[src] = nil
    end

    for controller, target in pairs(activeControls) do
        if target == src then
            activeControls[controller] = nil
            TriggerClientEvent('ps-adminmenu:client:stopControl', controller)
            break
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    for controller, targetId in pairs(activeControls) do
        TriggerClientEvent('ps-adminmenu:client:youAreControlled', targetId, false)
        TriggerClientEvent('ps-adminmenu:client:stopControl', controller)
    end

    activeControls = {}
end)
