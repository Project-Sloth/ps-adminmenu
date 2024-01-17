local function noPerms(source)
    TriggerClientEvent('esx:showNotification', source, "You are not Admin or God.", 'error')
end

local function isAdmin(player, perms)
    local xPlayer = ESX.GetPlayerFromId(player)
    local myGroup = xPlayer.getGroup()
    if myGroup == "superadmin" then return true end
    if type(perms) == "table" then
        for _,v in pairs(perms) do
            if myGroup == v then
                return true
            end
        end
    else
        return myGroup == perms
    end
    return false
end

--- @param perms string
function CheckPerms(perms)
    local hasPerms = isAdmin(source, perms)

    if not hasPerms then
        return noPerms(source)
    end
    return hasPerms
end

function CheckDataFromKey(key)
    local action = Config.Actions[key]
    if action then
        local data = nil

        if action.event then
            data = action
        end

        if action.dropdown then
            for _, v in pairs(action.dropdown) do
                if v.event then
                    local new = v
                    new.perms = action.perms
                    data = new
                    break
                end
            end
        end

        return data
    end

    local playerActions = Config.PlayerActions[key]
    if playerActions then
        return playerActions
    end

    local otherActions = Config.OtherActions[key]
    if otherActions then
        return otherActions
    end
end

---@param plate string
---@return boolean
function CheckAlreadyPlate(plate)
    local vPlate = Trim(plate)
    local result = MySQL.single.await("SELECT `plate` FROM `owned_vehicles` WHERE `plate` = ?", { vPlate })
    if result and result.plate then return true end
    return false
end

lib.callback.register('ps-adminmenu:callback:CheckPerms', function(_, perms)
    return CheckPerms(perms)
end)

lib.callback.register('ps-adminmenu:callback:CheckAlreadyPlate', function(_, vPlate)
    return CheckAlreadyPlate(vPlate)
end)

lib.callback.register('ps-adminmenu:callback:GetESXJobs', function(_)
    return ESX.GetJobs()
end)

lib.callback.register('ps-adminmenu:callback:GetESXItems', function(_)
    return ESX.Items
end)

--- @param source number
--- @param target number
function CheckRoutingbucket(source, target)
    local sourceBucket = GetPlayerRoutingBucket(source)
    local targetBucket = GetPlayerRoutingBucket(target)

    if sourceBucket == targetBucket then return end

    SetPlayerRoutingBucket(source, targetBucket)
    TriggerClientEvent('esx:showNotification', source, _U("bucket_set", targetBucket), 'error', 7500)
end
