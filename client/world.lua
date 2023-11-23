-- Changes the time
RegisterNetEvent('ps-adminmenu:client:ChangeTime', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local time = selectedData["Time Events"].value

    if not time then return end

    TriggerServerEvent('qb-weathersync:server:setTime', time, 00)
end)

-- Changes the weather
RegisterNetEvent('ps-adminmenu:client:ChangeWeather', function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local weather = selectedData["Weather"].value

    TriggerServerEvent('qb-weathersync:server:setWeather', weather)
end)
