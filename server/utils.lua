local function noPerms(source)
    QBCore.Functions.Notify(source, "You are not Admin or God.", 'error')
end

--- @param perms string
function CheckPerms(perms)
    local hasPerms = QBCore.Functions.HasPermission(source, perms)

    if not hasPerms then
        return noPerms(source)
    end

    return hasPerms
end

---@param plate string
---@return boolean
function CheckAlreadyPlate ( plate )
    local vPlate = QBCore.Shared.Trim( plate )
    local result = MySQL.single.await("SELECT plate FROM player_vehicles WHERE plate = ?", {vPlate})
    if result and result.plate then return true end
    return false
end

lib.callback.register('ps-adminmenu:callback:CheckPerms', function(source, perms)
    return CheckPerms(perms)
end)

lib.callback.register('ps-adminmenu:callback:CheckAlreadyPlate', function (_, vPlate )
    return CheckAlreadyPlate( vPlate )
end)

--- @param source number
--- @param target number
function CheckRoutingbucket(source, target)
    local sourceBucket = GetPlayerRoutingBucket(source)
    local targetBucket = GetPlayerRoutingBucket(target)

    if sourceBucket == targetBucket then return end

    SetPlayerRoutingBucket(source, targetBucket)
    QBCore.Functions.Notify(source, locale("bucket_set", targetBucket), 'error', 7500)
end
