local resources = {}

lib.callback.register('ps-adminmenu:callback:GetResources', function(source)
    local totalResources = GetNumResources()
        
    resources = {}
        
    for i = 0, totalResources - 1 do
        local resourceName = GetResourceByFindIndex(i)
        local author = GetResourceMetadata(resourceName, "author")
        local version = GetResourceMetadata(resourceName, "version")
        local description = GetResourceMetadata(resourceName, "description")
        local resourceState = GetResourceState(resourceName)

        resources[#resources + 1] = {
            name = resourceName,
            author = author,
            version = version,
            description = description,
            resourceState = resourceState,
        }
    end

    return resources
end)


lib.callback.register('ps-adminmenu:callback:ChangeResourceState', function(source, data, perms)
    print(json.encode(data))
    if not CheckPerms(Config.ResourcePerms) then return end

    if data.state == "start" then
        StartResource(data.name)
        print("Started " .. data.name)
    elseif data.state == "stop" then
        StopResource(data.name)
        print("Stopped " .. data.name)
    elseif data.state == "restart" then
        StopResource(data.name)
        Wait(200)
        StartResource(data.name)
        print("Restarted " .. data.name)
    end

    return resources
end)
