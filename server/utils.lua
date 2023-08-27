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

lib.callback.register('ps-adminmenu:callback:CheckPerms', function(source, perms)
    local hasPerms = QBCore.Functions.HasPermission(source, perms)
    if not hasPerms then return NoPerms(source) end

    return json.encode(hasPerms)
end)
