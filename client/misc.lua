
-- Change resource state
RegisterNUICallback("setResourceState", function(data, cb)
	local resources = lib.callback.await('ps-adminmenu:callback:ChangeResourceState', false, data)
	cb(resources)
end)

-- Get players
RegisterNUICallback("getPlayers", function(data, cb)
	local players = lib.callback.await('ps-adminmenu:callback:GetPlayers', false)
	cb(players)
end)

-- Toggles Invincibility
local visible = true
RegisterNetEvent('ps-adminmenu:client:ToggleInvisible', function(data)
    if not CheckPerms(data.perms) then return end

	visible = not visible

	SetEntityVisible(cache.ped, visible, 0)
end)

-- Gode Mode
local godmode = false
RegisterNetEvent('ps-adminmenu:client:ToggleGodmode', function(data)
    if not CheckPerms(data.perms) then return end

	godmode = not godmode

	SetPlayerInvincible(cache.playerId, godmode)
end)

