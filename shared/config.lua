Config = Config or {}

Config.Fuel = "ps-fuel" -- "ps-fuel", "LegacyFuel"

Config.Actions = {

    ["admin_car"] = {
        label = "Admin Car",
        type = "client",
        event = "ps-adminmenu:client:Admincar",
        perms = "mod",
    },

    ["ban_player"] = {
        label = "Ban Player",
        perms = "mod",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Reason", option = "text" },
            {
                label = "Duration",
                option = "dropdown",
                data = {
                    { label = "Permanent",  value = "2147483647" },
                    { label = "10 Minutes", value = "600" },
                    { label = "30 Minutes", value = "1800" },
                    { label = "1 Hour",     value = "3600" },
                    { label = "6 Hours",    value = "21600" },
                    { label = "12 Hours",   value = "43200" },
                    { label = "1 Day",      value = "86400" },
                    { label = "3 Days",     value = "259200" },
                    { label = "1 Week",     value = "604800" },
                    { label = "3 Week",     value = "1814400" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:BanPlayer" },
        },
    },

    ["bring_player"] = {
        label = "Bring Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:BringPlayer" },
        },
    },

    ["change_weather"] = {
        label = "Change Weather",
        perms = "mod",
        dropdown = {
            {
                label = "Weather",
                option = "dropdown",
                data = {
                    { label = "Extrasunny", value = "Extrasunny" },
                    { label = "Clear",      value = "Clear" },
                    { label = "Neutral",    value = "Neutral" },
                    { label = "Smog",       value = "Smog" },
                    { label = "Foggy",      value = "Foggy" },
                    { label = "Overcast",   value = "Overcast" },
                    { label = "Clouds",     value = "Clouds" },
                    { label = "Clearing",   value = "Clearing" },
                    { label = "Rain",       value = "Rain" },
                    { label = "Thunder",    value = "Thunder" },
                    { label = "Snow",       value = "Snow" },
                    { label = "Blizzard",   value = "Blizzard" },
                    { label = "Snowlight",  value = "Snowlight" },
                    { label = "Xmas",       value = "Xmas" },
                    { label = "Halloween",  value = "Halloween" },
                },
            },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:ChangeWeather" },
        },
    },

    ["change_time"] = {
        label = "Change Time",
        perms = "mod",
        dropdown = {
            {
                label = "Time Events",
                option = "dropdown",
                data = {
                    { label = "Sunrise", value = "06" },
                    { label = "Morning", value = "09" },
                    { label = "Noon",    value = "12" },
                    { label = "Sunset",  value = "21" },
                    { label = "Evening", value = "22" },
                    { label = "Night",   value = "24" },
                },
            },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:ChangeTime" },
        },
    },

    ["change_plate"] = {
        label = "Change Plate",
        perms = "mod",
        dropdown = {
            { label = "Plate", option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:ChangePlate" },
        },
    },

    ["clear_inventory"] = {
        label = "Clear Inventory",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:ClearInventory" },
        },
    },

    ["clothing_menu"] = {
        label = "Give Clothing Menu",
        perms = "mod",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:ClothingMenu" },
        },
    },

    ["copy_coords"] = {
        label = "Copy Coords",
        perms = "mod",
        dropdown = {
            { label = "Copy Vector2", option = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
            { label = "Copy Vector3", option = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
            { label = "Copy Vector4", option = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
            { label = "Copy Heading", option = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
        },
    },

    ["delete_vehicle"] = {
        label = "Delete Vehicle",
        type = "command",
        event = "dv",
        perms = "mod",
    },

    ["freeze_player"] = {
        label = "Freeze Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:FreezePlayer" },
        },
    },

    ["nui_focus"] = {
        label = "Give NUI Focus",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "" },
        },
    },

    ["god_mode"] = {
        label = "God Mode",
        type = "client",
        event = "ps-adminmenu:client:ToggleGodmode",
        perms = "mod",
    },

    ["invisible"] = {
        label = "Invisible",
        type = "client",
        event = "ps-adminmenu:client:ToggleInvisible",
        perms = "mod",
    },

    ["blackout"] = {
        label = "Toggle Blackout",
        type = "server",
        event = "ps-adminmenu:server:ToggleBlackout",
        perms = "mod",
    },

    ["toggle_duty"] = {
        label = "Toggle Duty",
        type = "server",
        event = "QBCore:ToggleDuty",
        perms = "mod",
    },

    ["toggle_delete_lazer"] = {
        label = "Toggle Delete Laser",
        type = "client",
        event = "ps-adminmenu:client:ToggleDeleteLaser",
        perms = "mod",
    },

    ["check_perms"] = {
        label = "Check Perms",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:CheckPerms" },
        },
    },

    ["set_perms"] = {
        label = "Set Perms",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            {
                label = "Permissions",
                option = "dropdown",
                data = {
                    { label = "Mod",   value = "mod" },
                    { label = "Admin", value = "admin" },
                    { label = "God",   value = "god" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:SetPerms" },
        },
    },

    ["set_bucket"] = {
        label = "Set Bucket",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Bucket", option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:server:SetBucket" },
        },
    },

    ["mute_player"] = {
        label = "Check Perms",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:MutePlayer" },
        },
    },

    ["noclip"] = {
        label = "Noclip",
        type = "client",
        event = "ps-adminmenu:client:ToggleNoClip",
        perms = "mod",
    },

    ["open_inventory"] = {
        label = "Open Inventory",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:openInventory" },
        },
    },

    ["open_stash"] = {
        label = "Open Stash",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:openStash" },
        },
    },

    ["revive_all"] = {
        label = "Revive All",
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = "mod",
    },

    ["revive_player"] = {
        label = "Revive Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:Revive" },
        },
    },

    ["revive_radius"] = {
        label = "Revive Radius",
        type = "server",
        event = "ps-adminmenu:server:ReviveRadius",
        perms = "mod",
    },

    ["refuel_vehicle"] = {
        label = "Refuel Vehicle",
        type = "client",
        event = "ps-adminmenu:client:RefuelVehicle",
        perms = "mod",
    },

    ["set_job"] = {
        label = "Set Job",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Job",     option = "dropdown", data = "jobs" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SetJob" },
        },
    },

    ["set_gang"] = {
        label = "Set Gang",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Gang",    option = "dropdown", data = "gangs" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SetJob" },
        },
    },

    ["give_money"] = {
        label = "Give Money",
        perms = "admin",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Amount", option = "text" },
            {
                label = "Type",
                option = "dropdown",
                data = {
                    { label = "Cash", value = "cash" },
                    { label = "Bank", value = "bank" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:GiveMoney" },
        },
    },

    ["give_money_all"] = {
        label = "Give Money to All",
        perms = "admin",
        dropdown = {
            { label = "Amount",  option = "text" },
            {
                label = "Type",
                option = "dropdown",
                data = {
                    { label = "Cash", value = "cash" },
                    { label = "Bank", value = "bank" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:GiveMoneyAll" },
        },
    },

    ["remove_money"] = {
        label = "Remove Money",
        perms = "admin",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Amount", option = "text" },
            {
                label = "Type",
                option = "dropdown",
                data = {
                    { label = "Cash", value = "cash" },
                    { label = "Bank", value = "bank" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:TakeMoney" },
        },
    },

    ["give_item"] = {
        label = "Give Item",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Amount",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItem" },
        },
    },

    ["give_item_all"] = {
        label = "Give Item to All",
        perms = "mod",
        dropdown = {
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Amount",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItemAll" },
        },
    },

    ["spawn_vehicle"] = {
        label = "Spawn Vehicle",
        perms = "mod",
        dropdown = {
            { label = "Vehicle",    option = "dropdown", data = "vehicles" },
            { label = "Confirm", option = "button",   type = "client",  event = "ps-adminmenu:client:SpawnVehicle" },
        },
    },

    ["fix_vehicle"] = {
        label = "Fix Vehicle",
        type = "command",
        event = "fix",
        perms = "mod",
    },

    ["spactate_player"] = {
        label = "Spectate Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SpectateTarget" },
        },
    },

    ["telport_to_player"] = {
        label = "Teleport to Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:server:TeleportToPlayer" },
        },
    },

    ["telport_to_coords"] = {
        label = "Teleport to Coords",
        perms = "mod",
        dropdown = {
            { label = "Coords",  option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:TeleportToCoords" },
        },
    },

    ["teleport_to_location"] = {
        label = "Teleport to Location",
        perms = "mod",
        dropdown = {
            { label = "Location",  option = "dropdown", data = "locations" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:TeleportToLocation" },
        },
    },

    ["teleport_to_marker"] = {
        label = "Teleport to Marker",
        type = "command",
        event = "tpm",
        perms = "mod",
    },

    ["teleport_back"] = {
        label = "Teleport Back",
        type = "client",
        event = "ps-adminmenu:client:TeleportBack",
        perms = "mod",
    },

    ["vehicle_dev"] = {
        label = "Vehicle Dev Menu",
        type = "client",
        event = "ps-adminmenu:client:ToggleVehDevMenu",
        perms = "mod",
    },

    ["toggle_coords"] = {
        label = "Toggle Coords",
        type = "client",
        event = "ps-adminmenu:client:ToggleCoords",
        perms = "mod",
    },

    ["toggle_blips"] = {
        label = "Toggle Blips",
        type = "client",
        event = "ps-adminmenu:client:toggleBlips",
        perms = "mod",
    },

    ["toggle_names"] = {
        label = "Toggle Blips",
        type = "client",
        event = "ps-adminmenu:client:toggleNames",
        perms = "mod",
    },

    ["toggle_cuffs"] = {
        label = "Toggle Cuffs",
        type = "client",
        event = "ps-adminmenu:client:toggleCuffs",
        perms = "mod",
    },

    ["max_mods"] = {
        label = "Max Vehicle Mods",
        type = "client",
        event = "ps-adminmenu:client:maxmodVehicle",
        perms = "mod",
    },

    ["warn_player"] = {
        label = "Warn Player",
        perms = "mod",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Reason",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:WarnPlayer" },
        },
    },

    ["infinite_ammo"] = {
        label = "Infinite Ammo",
        type = "client",
        event = "ps-adminmenu:client:setInfiniteAmmo",
        perms = "mod",
    },

    ["play_sound"] = {
        label = "Play Sound",
        perms = "mod",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            {
                label = "Sound",
                option = "dropdown",
                data = {
                    { label = "Alert",  value = "alert" },
                    { label = "Cuff", value = "cuff" },
                    { label = "Air Wrench", value = "airwrench" },
                },
            },
            { label = "Play Sound", option = "button", type = "client", event = "ps-adminmenu:client:PlaySound" },
        },
    },
}

AddEventHandler("onResourceStart", function()
    Wait(100)
	if GetResourceState('ox_inventory') == 'started' then
        Config.Inventory = 'ox_inventory'
    elseif GetResourceState('ps-inventory') == 'started' then
        Config.Inventory = 'ps-inventory'
    elseif GetResourceState('lj-inventory') == 'started' then
        Config.Inventory = 'lj-inventory'
    elseif GetResourceState('qb-inventory') == 'started' then
        Config.Inventory = 'qb-inventory'
	end
    print("Inventory: " .. Config.Inventory)
end)
