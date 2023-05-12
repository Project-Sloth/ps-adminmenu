

RegisterNetEvent('ps-adminmenu:server:getResources', function(data)
    local resources = GetResourceList()
    for i=1, #resources do
        local resource = resources[i]
        local author = GetResourceMetadata(resource, 'author')
        local version = GetResourceMetadata(resource, 'version')
        local description = GetResourceMetadata(resource, 'description')
        print(resource .. ' by ' .. author .. ' (v' .. version .. '): ' .. description)
    end
end)