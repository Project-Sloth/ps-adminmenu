local ShowBlips = false
local ShowNames = false
local NetCheck1 = false
local NetCheck2 = false
local Blip = nil
local Tag = nil
local currentPlayers = {}

-- Function to remove all names and Blips
local function removeNameAndBlips()
    if DoesBlipExist(Blip) then
        RemoveBlip(Blip)
    end
    if Tag then
        SetMpGamerTagVisibility(Tag, 0, false)
        SetMpGamerTagVisibility(Tag, 2, false)
        SetMpGamerTagVisibility(Tag, 4, false)
        SetMpGamerTagVisibility(Tag, 6, false)
        RemoveMpGamerTag(Tag)
    end
end

-- Function to Toggle Blips and Names
local function ToggleBlipsAndNames(isBlips)
    if isBlips then
        ShowBlips = not ShowBlips
        NetCheck1 = ShowBlips
        local message = ShowBlips and "blips_activated" or "blips_deactivated"
        QBCore.Functions.Notify(locale(message), ShowBlips and "success" or "error")
    else
        ShowNames = not ShowNames
        NetCheck2 = ShowNames
        local message = ShowNames and "names_activated" or "names_deactivated"
        QBCore.Functions.Notify(locale(message), ShowNames and "success" or "error")
    end
    if not ShowNames or not ShowBlips then
        removeNameAndBlips()
    end
end

-- Main Function to Update Blips and Names
local function UpdateBlipsAndNames(players)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, true)
    local blipSprites = { -- Sprite Per Vehicle Class
        [1] = 1,
        [8] = 226,
        [9] = 757,
        [10] = 477,
        [11] = 477,
        [12] = 67,
        [13] = 226,
        [14] = 427,
        [15] = 422,
        [16] = 423,
        [17] = 198,
        [18] = 56,
        [19] = 421,
        [20] = 477,
    }

    for _, player in pairs(players) do
        local playerId = GetPlayerFromServerId(player.id)
        local ped = GetPlayerPed(playerId)
        local name = 'ID: ' .. player.id .. ' | ' .. player.name
        Blip = GetBlipFromEntity(ped)

        Tag = CreateFakeMpGamerTag(ped, name, false, false, "", false)
        SetMpGamerTagAlpha(Tag, 0, 255)
        SetMpGamerTagAlpha(Tag, 2, 255)
        SetMpGamerTagAlpha(Tag, 4, 255)
        SetMpGamerTagAlpha(Tag, 6, 255)
        SetMpGamerTagHealthBarColour(Tag, 25)

        local isPlayerTalking = NetworkIsPlayerTalking(playerId)
        local isPlayerInvincible = GetPlayerInvincible(playerId)
        if ShowNames then
            SetMpGamerTagVisibility(Tag, 0, true)
            SetMpGamerTagVisibility(Tag, 2, true)
            SetMpGamerTagVisibility(Tag, 4, isPlayerTalking)
            SetMpGamerTagVisibility(Tag, 6, isPlayerInvincible)
        else
            SetMpGamerTagVisibility(Tag, 0, false)
            SetMpGamerTagVisibility(Tag, 2, false)
            SetMpGamerTagVisibility(Tag, 4, false)
            SetMpGamerTagVisibility(Tag, 6, false)
            RemoveMpGamerTag(Tag)
        end

        if ShowBlips then
            if not DoesBlipExist(Blip) then
                Blip = AddBlipForEntity(ped)
                ShowHeadingIndicatorOnBlip(Blip, true)
                SetBlipCategory(Blip, 7)
            else
                local veh = GetVehiclePedIsIn(ped, false)
                local classveh = GetVehicleClass(veh)
                local modelveh = GetEntityModel(veh)
                if veh ~= 0 then
                    local blipSprite = blipSprites[classveh] or 225
                    if modelveh == 'besra' or modelveh == 'hydra' or modelveh == 'lazer' then
                        blipSprite = 424
                    end

                    SetBlipSprite(Blip, blipSprite)
                    ShowHeadingIndicatorOnBlip(Blip, false)

                    local passengers = GetVehicleNumberOfPassengers(veh)
                    if passengers then
                        if not IsVehicleSeatFree(veh, -1) then
                            passengers = passengers + 1
                        end
                        ShowNumberOnBlip(Blip, passengers)
                    else
                        HideNumberOnBlip(Blip)
                    end

                    SetBlipRotation(Blip, math.ceil(GetEntityHeading(veh)))
                    SetBlipNameToPlayerName(Blip, playerId)
                    SetBlipScale(Blip, 0.85)

                    local distance = math.floor(Vdist(playerCoords.x, playerCoords.y, playerCoords.z,
                                GetEntityCoords(ped, true).x, GetEntityCoords(ped, true).y, GetEntityCoords(ped, true).z) /
                            -1) +
                        900
                    distance = math.max(0, math.min(255, distance))
                    SetBlipAlpha(Blip, distance)
                else
                    HideNumberOnBlip(Blip)
                    SetBlipSprite(Blip, 1)
                    SetBlipNameToPlayerName(Blip, playerId)
                    ShowHeadingIndicatorOnBlip(Blip, true)
                end
            end
        end
    end
end

local function preparePlayers()
    currentPlayers = {}
    Wait(100)
    currentPlayers = lib.callback.await('ps-adminmenu:callback:GetPlayers')
end

-- Toggle Blips and Names events
RegisterNetEvent('ps-adminmenu:client:toggleBlips', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    if not ShowBlips then preparePlayers() end
    ToggleBlipsAndNames(true)
end)

RegisterNetEvent('ps-adminmenu:client:toggleNames', function(data)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    if not ShowNames then preparePlayers() end
    ToggleBlipsAndNames(false)
end)

-- Mute Player
RegisterNetEvent("ps-adminmenu:client:MutePlayer", function(data, selectedData)
    local data = CheckDataFromKey(data)
    if not data or not CheckPerms(data.perms) then return end
    local playerId = selectedData["Player"].value
    if not playerId then return end
    exports["pma-voice"]:toggleMutePlayer(playerId)
end)

-- Main loop to check for updates
CreateThread(function()
    while true do
        Wait(1000)
        if NetCheck1 or NetCheck2 then
            UpdateBlipsAndNames(currentPlayers)
        end
    end
end)

-- Remove Stress
RegisterNetEvent('ps-adminmenu:client:removeStress', function(data)
    TriggerServerEvent('hud:server:RelieveStress', 100)
end)
