local commandsTable, addedCommands = {}, {}
local blacklistCommands = {
    "sv_", "adhesive_", "citizen_", "con_", "endpoint_", "fileserver", "load_server",
    "mysql_connection", "net_tcp", "netPort", "netlib", "onesync", "onesync_",
    "rateLimiter_", "svgui", "web_base", "temp_", "txAdmin", "txa",
}

local function isCommandBlacklisted(commandName)
    for _, bcommand in pairs(blacklistCommands) do
        if string.match(commandName, '^' .. bcommand) then
            return true
        end
    end
    return false
end

lib.callback.register('ps-adminmenu:callback:GetCommands', function()
    if not CheckPerms(source, Config.ShowCommandsPerms) then return {} end

    local allCommands = GetRegisteredCommands()

    for _, command in ipairs(allCommands) do
        if not isCommandBlacklisted(command.name) and not addedCommands[command.name] then
            commandsTable[#commandsTable + 1] = {
                name = '/' .. command.name
            }
            addedCommands[command.name] = true -- prevent duplicates
        end
    end

    return commandsTable
end)
