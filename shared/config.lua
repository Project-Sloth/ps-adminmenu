Config = Config or {}

Config.Locale = 'en'
Config.Fuel = "LegacyFuel"        -- "ps-fuel", "LegacyFuel"
Config.ResourcePerms = 'admin' -- permission to control resource(start stop restart)
Config.ShowCommandsPerms = 'admin' -- permission to show all commands
Config.Inventory = 'ox_inventory'

-- Key Bindings
Config.Keybindings = true
Config.AdminKey = "PageDown"
Config.NoclipKey = "PageUp"

-- Give Car
Config.DefaultGarage = "A"

Config.Actions = {
    ["admin_car"] = {
        label = "Admin Car",
        type = "client",
        event = "ps-adminmenu:client:Admincar",
        perms = "admin",
    },

    ["ban_player"] = {
        label = "Ban Player",
        perms = "admin",
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
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:BringPlayer" },
        },
    },

    ["change_weather"] = {
        label = "Change Weather",
        perms = "admin",
        dropdown = {
            {
                label = "Weather",
                option = "dropdown",
                data = {
                    { label = "Extrasunny", value = "extrasunny" },
                    { label = "Clear",      value = "clear" },
                    { label = "Neutral",    value = "neutral" },
                    { label = "Smog",       value = "smog" },
                    { label = "Foggy",      value = "foggy" },
                    { label = "Overcast",   value = "overcast" },
                    { label = "Clouds",     value = "clouds" },
                    { label = "Clearing",   value = "clearing" },
                    { label = "Rain",       value = "rain" },
                    { label = "Thunder",    value = "thunder" },
                    { label = "Snow",       value = "snow" },
                    { label = "Blizzard",   value = "blizzard" },
                    { label = "Snowlight",  value = "snowlight" },
                    { label = "Xmas",       value = "xmas" },
                    { label = "Halloween",  value = "halloween" },
                },
            },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:ChangeWeather" },
        },
    },

    ["change_time"] = {
        label = "Change Time",
        perms = "admin",
        dropdown = {
            {
                label = "Time Events",
                option = "dropdown",
                data = {
                    { label = "Sunrise", value = "sunrise" },
                    { label = "Morning", value = "morning" },
                    { label = "Noon",    value = "noon" },
                    { label = "Sunset",  value = "sunset" },
                    { label = "Evening", value = "evening" },
                    { label = "Night",   value = "night" },
                },
            },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:ChangeTime" },
        },
    },

    ["change_plate"] = {
        label = "Change Plate",
        perms = "admin",
        dropdown = {
            { label = "Plate",   option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:ChangePlate" },
        },
    },

    ["clear_inventory"] = {
        label = "Clear Inventory",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:ClearInventory" },
        },
    },

    ["clear_inventory_offline"] = {
        label = "Clear Inventory Offline",
        perms = "admin",
        dropdown = {
            { label = "Citizen ID", option = "text",   data = "players" },
            { label = "Confirm",    option = "button", type = "server", event = "ps-adminmenu:server:ClearInventoryOffline" },
        },
    },

    ["clothing_menu"] = {
        label = "Give Clothing Menu",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:ClothingMenu" },
        },
    },

    ["set_ped"] = {
        label = "Set Ped",
        perms = "admin",
        dropdown = {
            { label = "Player",     option = "dropdown", data = "players" },
            { label = "Ped Models", option = "dropdown", data = "pedlist" },
            { label = "Confirm",    option = "button",   type = "server", event = "ps-adminmenu:server:setPed" },
        },
    },

    ["copy_coords"] = {
        label = "Copy Coords",
        perms = "admin",
        dropdown = {
            {
                label = "Copy Coords",
                option = "dropdown",
                data = {
                    { label = "Copy Vector2", value = "vector2" },
                    { label = "Copy Vector3", value = "vector3" },
                    { label = "Copy Vector4",    value = "vector4" },
                    { label = "Copy Heading",  value = "heading" },
                },
            },
            { label = "Copy to Clipboard", option = "button", type = "client", event = "ps-adminmenu:client:copyToClipboard"},
        },
    },

    ["delete_vehicle"] = {
        label = "Delete Vehicle",
        type = "command",
        event = "dv",
        perms = "admin",
    },

    ["freeze_player"] = {
        label = "Freeze Player",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:FreezePlayer" },
        },
    },

    ["drunk_player"] = {
        label = "Make Player Drunk",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:DrunkPlayer" },
        },
    },

    ["set_ammo"] = {
        label = "Set Ammo",
        perms = "admin",
        dropdown = {
            { label = "Ammo Ammount", option = "text" },
            { label = "Confirm",      option = "button", type = "client", event = "ps-adminmenu:client:SetAmmo" },
        },
    },

    -- ["nui_focus"] = {
    --     label = "Give NUI Focus",
    --     perms = "admin",
    --     dropdown = {
    --         { label = "Player",  option = "dropdown", data = "players" },
    --         { label = "Confirm", option = "button",   type = "client", event = "" },
    --     },
    -- },

    ["god_mode"] = {
        label = "God Mode",
        type = "client",
        event = "ps-adminmenu:client:ToggleGodmode",
        perms = "admin",
    },

    ["give_car"] = {
        label = "Give Car",
        perms = "admin",
        dropdown = {
            { label = "Vehicle",           option = "dropdown", data = "vehicles" },
            { label = "Player",            option = "dropdown", data = "players" },
            { label = "Plate (Optional)",  option = "text" },
            { label = "Garage (Optional)", option = "text" },
            { label = "Confirm",           option = "button",   type = "server",  event = "ps-adminmenu:server:givecar" },
        }
    },

    ["invisible"] = {
        label = "Invisible",
        type = "client",
        event = "ps-adminmenu:client:ToggleInvisible",
        perms = "admin",
    },

    ["blackout"] = {
        label = "Toggle Blackout",
        type = "server",
        event = "ps-adminmenu:server:ToggleBlackout",
        perms = "admin",
    },

    ["toggle_laser"] = {
        label = "Toggle Laser",
        type = "client",
        event = "ps-adminmenu:client:ToggleLaser",
        perms = "admin",
    },

    ["set_perms"] = {
        label = "Set Perms",
        perms = "superadmin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            {
                label = "Permissions",
                option = "dropdown",
                data = {
                    { label = "User",   value = "user" },
                    { label = "Mod",   value = "mod" },
                    { label = "Admin", value = "admin" },
                    { label = "Superadmin",   value = "superadmin" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:SetPerms" },
        },
    },

    ["set_bucket"] = {
        label = "Set Routing Bucket",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Bucket",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SetBucket" },
        },
    },

    ["get_bucket"] = {
        label = "Get Routing Bucket",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GetBucket" },
        },
    },

    ["mute_player"] = {
        label = "Mute Player",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:MutePlayer" },
        },
    },

    ["noclip"] = {
        label = "Noclip",
        type = "client",
        event = "ps-adminmenu:client:ToggleNoClip",
        perms = "admin",
    },

    ["open_inventory"] = {
        label = "Open Inventory",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "client", event = "ps-adminmenu:client:openInventory" },
        },
    },

    ["open_stash"] = {
        label = "Open Stash",
        perms = "admin",
        dropdown = {
            { label = "Stash",   option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:openStash" },
        },
    },

    ["open_trunk"] = {
        label = "Open Trunk",
        perms = "admin",
        dropdown = {
            { label = "Plate",   option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:openTrunk" },
        },
    },

    ["change_vehicle_state"] = {
        label = "Set Vehicle Garage State",
        perms = "admin",
        dropdown = {
            { label = "Plate",   option = "text" },
            {
                label = "State",
                option = "dropdown",
                data = {
                    { label = "In",  value = "1" },
                    { label = "Out", value = "0" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:SetVehicleState" },
        },
    },

    ["revive_all"] = {
        label = "Revive All",
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = "admin",
    },

    ["revive_player"] = {
        label = "Revive Player",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:Revive" },
        },
    },

    ["revive_radius"] = {
        label = "Revive Radius",
        type = "server",
        event = "ps-adminmenu:server:ReviveRadius",
        perms = "admin",
    },

    ["refuel_vehicle"] = {
        label = "Refuel Vehicle",
        type = "client",
        event = "ps-adminmenu:client:RefuelVehicle",
        perms = "admin",
    },

    ["set_job"] = {
        label = "Set Job",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Job",     option = "dropdown", data = "jobs" },
            { label = "Grade",   option = "text", data = "grades" },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:SetJob" },
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
                    { label = "Cash",   value = "money" },
                    { label = "Bank",   value = "bank" },
                    { label = "Black", value = "black_money" },
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
                    { label = "Cash",   value = "money" },
                    { label = "Bank",   value = "bank" },
                    { label = "Black", value = "black_money" },
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
                    { label = "Cash", value = "money" },
                    { label = "Bank", value = "bank" },
                },
            },
            { label = "Confirm", option = "button", type = "server", event = "ps-adminmenu:server:TakeMoney" },
        },
    },

    ["give_item"] = {
        label = "Give Item",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Amount",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItem" },
        },
    },

    ["give_item_all"] = {
        label = "Give Item to All",
        perms = "admin",
        dropdown = {
            { label = "Item",    option = "dropdown", data = "items" },
            { label = "Amount",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:GiveItemAll" },
        },
    },

    ["spawn_vehicle"] = {
        label = "Spawn Vehicle",
        perms = "admin",
        dropdown = {
            { label = "Vehicle", option = "dropdown", data = "vehicles" },
            { label = "Confirm", option = "button",   type = "client",  event = "ps-adminmenu:client:SpawnVehicle" },
        },
    },

    ["setonfire"] = {
        label = "Set On Fire",
        perms = "admin",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server",  event = "ps-adminmenu:server:SetOnFire" },
        },
    },

    ["explodeplayer"] = {
        label = "Explode Player",
        perms = "admin",
        dropdown = {
            { label = "Player", option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server",  event = "ps-adminmenu:server:ExplodePlayer" },
        },
    },

    ["fix_vehicle"] = {
        label = "Fix Vehicle",
        type = "command",
        event = "fix",
        perms = "admin",
    },

    ["fix_vehicle_for"] = {
        label = "Fix Vehicle for player",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:FixVehFor" },
        },
    },

    ["spectate_player"] = {
        label = "Spectate Player",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:SpectateTarget" },
        },
    },

    ["telport_to_player"] = {
        label = "Teleport to Player",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:TeleportToPlayer" },
        },
    },

    ["telport_to_coords"] = {
        label = "Teleport to Coords",
        perms = "admin",
        dropdown = {
            { label = "Coords",  option = "text" },
            { label = "Confirm", option = "button", type = "client", event = "ps-adminmenu:client:TeleportToCoords" },
        },
    },

    ["teleport_to_marker"] = {
        label = "Teleport to Marker",
        type = "command",
        event = "tpm",
        perms = "admin",
    },

    ["teleport_back"] = {
        label = "Teleport Back",
        type = "client",
        event = "ps-adminmenu:client:TeleportBack",
        perms = "admin",
    },

    ["vehicle_dev"] = {
        label = "Vehicle Dev Menu",
        type = "client",
        event = "ps-adminmenu:client:ToggleVehDevMenu",
        perms = "admin",
    },

    ["toggle_coords"] = {
        label = "Toggle Coords",
        type = "client",
        event = "ps-adminmenu:client:ToggleCoords",
        perms = "admin",
    },

    ["toggle_blips"] = {
        label = "Toggle Blips",
        type = "client",
        event = "ps-adminmenu:client:toggleBlips",
        perms = "admin",
    },

    ["toggle_names"] = {
        label = "Toggle Names",
        type = "client",
        event = "ps-adminmenu:client:toggleNames",
        perms = "admin",
    },

    ["toggle_cuffs"] = {
        label = "Toggle Cuffs",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:CuffPlayer" },
        },
    },

    ["max_mods"] = {
        label = "Max Vehicle Mods",
        type = "client",
        event = "ps-adminmenu:client:maxmodVehicle",
        perms = "admin",
    },

    ["warn_player"] = {
        label = "Warn Player",
        perms = "admin",
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
        perms = "admin",
    },

    ["kick_player"] = {
        label = "Kick Player",
        perms = "admin",
        dropdown = {
            { label = "Player",  option = "dropdown", data = "players" },
            { label = "Reason",  option = "text" },
            { label = "Confirm", option = "button",   type = "server", event = "ps-adminmenu:server:KickPlayer" },
        },
    },

    ["play_sound"] = {
        label = "Play Sound",
        perms = "admin",
        dropdown = {
            { label = "Player",     option = "dropdown", data = "players" },
            {
                label = "Sound",
                option = "dropdown",
                data = {
                    { label = "Alert",      value = "alert" },
                    { label = "Cuff",       value = "cuff" },
                    { label = "Air Wrench", value = "airwrench" },
                },
            },
            { label = "Play Sound", option = "button",   type = "client", event = "ps-adminmenu:client:PlaySound" },
        },
    },
}

Config.PlayerActions = {
    ["teleportToPlayer"] = {
        label = "Teleport to Player",
        type = "server",
        event = "ps-adminmenu:server:TeleportToPlayer",
        perms = "admin",
    },
    ["bringPlayer"] = {
        label = "Bring Player",
        type = "server",
        event = "ps-adminmenu:server:BringPlayer",
        perms = "admin",
    },
    ["revivePlayer"] = {
        label = "Revive Player",
        event = "ps-adminmenu:server:Revive",
        perms = "admin",
        type = "server"
    },
    ["spawnPersonalVehicle"] = {
        label = "Spawn Personal Vehicle",
        event = "ps-adminmenu:client:SpawnPersonalVehicle",
        perms = "admin",
        type = "client"
    },
    ["banPlayer"] = {
        label = "Ban Player",
        event = "ps-adminmenu:server:BanPlayer",
        perms = "admin",
        type = "server"
    },
    ["kickPlayer"] = {
        label = "Kick Player",
        event = "ps-adminmenu:server:KickPlayer",
        perms = "admin",
        type = "server"
    }
}

Config.OtherActions = {
    ["toggleDevmode"] = {
        type = "client",
        event = "ps-adminmenu:client:ToggleDev",
        perms = "admin",
        label = "Toggle Devmode"
    }
}
