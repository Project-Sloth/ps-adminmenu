-- Permissions
local function NoPerms(source)
    QBCore.Functions.Notify(source, "No Perms", 'error')
end

function CheckPerms(perms)
    local hasPerms = QBCore.Functions.HasPermission(source, perms)

    if not hasPerms then
        return NoPerms(source)
    end

    return hasPerms
end

function permsToString(perms)
    local allowedPerms = {}
    for k, v in pairs(perms) do
        if v then
            table.insert(allowedPerms, k)
        end
    end
    return table.concat(allowedPerms, ", ")
end

lib.callback.register('ps-adminmenu:callback:CheckPerms', function(source, perms)
    return CheckPerms(perms)
end)

-- Bucket Routing
function CheckRoutingbucket(source, target)
    local sourceBucket = GetPlayerRoutingBucket(source)
    local targetBucket = GetPlayerRoutingBucket(target)
    if sourceBucket ~= targetBucket then
        SetPlayerRoutingBucket(source, targetBucket)
        QBCore.Functions.Notify(source, locale("bucket_set", { bucket = targetBucket }), 'error', 7500)
    end
end