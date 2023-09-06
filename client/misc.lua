-- Change resource state
RegisterNUICallback("setResourceState", function(data, cb)
	local resources = lib.callback.await('ps-adminmenu:callback:ChangeResourceState', false, data)
	cb(resources)
end)

-- Get players
RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('ps-adminmenu:callback:GetPlayers', false)
	print(json.encode(players))
    cb(players)
end)

-- Toggles Invincibility
local visible = true
RegisterNetEvent('ps-adminmenu:client:ToggleInvisible', function(data)
	if not CheckPerms(data.perms) then return end

	visible = not visible

	SetEntityVisible(cache.ped, visible, 0)
end)

-- God Mode
local godmode = false
RegisterNetEvent('ps-adminmenu:client:ToggleGodmode', function(data)
	if not CheckPerms(data.perms) then return end

	godmode = not godmode

    if godmode then
        QBCore.Functions.Notify(locale("godmode", "enabled"), 'primary')
        while godmode do
            Wait(0)
            SetPlayerInvincible(cache.playerId, true)
        end
        SetPlayerInvincible(cache.playerId, false)
        QBCore.Functions.Notify(locale("godmode", "disabled"), 'primary')
    end
end)

-- Cuff/Uncuff
RegisterNetEvent('ps-adminmenu:client:ToggleCuffs', function(player)
    local playerId = GetPlayerServerId(player)
    TriggerEvent("police:client:GetCuffed", playerId)
end)

-- Revive Radius
RegisterNetEvent('ps-adminmenu:client:ReviveRadius', function(data)
    if not CheckPerms(data.perms) then return end
	local coords = GetEntityCoords(cache.ped)
	local radius = lib.getNearbyPlayers(coords, 5.0, true)
	print(json.encode(radius))
end)

-- Copy Coordinates
local function CopyCoords(data)
    local coords = GetEntityCoords(cache.ped)
	local heading = GetEntityHeading(cache.ped)
    local formats = { vector2 = "%.2f, %.2f", vector3 = "%.2f, %.2f, %.2f", vector4 = "%.2f, %.2f, %.2f, %.2f", heading = "%.2f" }
    local format = formats[data]

	local values = {coords.x, coords.y, coords.z, heading}
	lib.setClipboard(string.format(format, table.unpack(values, 1, #format)))
end

RegisterCommand("vector2", function()
	CopyCoords("vector2")
end, false)

RegisterCommand("vector3", function()
	CopyCoords("vector3")
end, false)

RegisterCommand("vector4", function()
	CopyCoords("vector4")
end, false)

RegisterCommand("heading", function()
	CopyCoords("heading")
end, false)

-- Infinite Ammo
local InfiniteAmmo = false
RegisterNetEvent('ps-adminmenu:client:setInfiniteAmmo', function(data)
	if not CheckPerms(data.perms) then return end
    InfiniteAmmo = not InfiniteAmmo

    if GetAmmoInPedWeapon(cache.ped, cache.weapon) < 6 then
        SetAmmoInClip(cache.ped, cache.weapon, 10)
        Wait(50)
    end

    while InfiniteAmmo do
        SetPedInfiniteAmmo(cache.ped, true, cache.weapon)
        RefillAmmoInstantly(cache.ped)
        Wait(250)
    end

    SetPedInfiniteAmmo(cache.ped, false, cache.weapon)

end)

-- Toggle coords
local showCoords = false
RegisterNetEvent('ps-adminmenu:client:ToggleCoords', function(data)
	if not CheckPerms(data.perms) then return end


    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = QBCore.Shared.Round(coords.x, 2)
            c.y = QBCore.Shared.Round(coords.y, 2)
            c.z = QBCore.Shared.Round(coords.z, 2)
            heading = QBCore.Shared.Round(heading, 2)
            Wait(1)
            Draw2DText(string.format('~w~'..locale("ped_coords") .. '~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end)