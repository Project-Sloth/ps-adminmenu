
local invisible = false

RegisterNUICallback('ToggleInvis', function(_, cb)
    cb({})
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)