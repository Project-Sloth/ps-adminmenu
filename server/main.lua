QBCore = exports['qb-core']:GetCoreObject()


-- Functions
local function NoPerms(source)
    QBCore.Functions.Notify(source, "No Perms", 'error')
end

function PermsCheck(perms)
    local hasPerms = QBCore.Functions.HasPermission(source, perms)

    if not hasPerms then
        return NoPerms(source)
    end

    return hasPerms
end

-- Callbacks
lib.callback.register('ps-adminmenu:callback:CheckPerms', function(source, perms)
    local hasPerms = QBCore.Functions.HasPermission(source, perms)
    if not hasPerms then return NoPerms(source) end

    return json.encode(hasPerms)
end)
