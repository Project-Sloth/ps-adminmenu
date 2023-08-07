Config = {}

Config.InventoryUsage =  "qb" -- qb(for qb-inventory) lj(for lj-inventory) or ox(for ox_inventory) [Inventory system]

Config.FuelScript =  "ps-fuel" -- LegacyFuel / qb-fuel / ps-fuel / lj-fuel [Car spawning/fixing]

Config.Actions = {
    {
        label = "Admin car", -- Label of the button
        event = "ps-adminmenu:client:Admincar", -- Event or command
        type = "client", -- client, server, command
        perms = "mod", -- mod, admin
    },
    {
        label = "Ban Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Reason", InputType = "input" },
            { label = "Time", InputType = "options",
            options = {
                    { label = "10 Minutes", value = "600"},
                    { label = "30 Minutes", value = "1800"},
                    { label = "1 Hour", value = "3600"},
                    { label = "6 Hours", value = "21600"},
                    { label = "12 Hours", value = "43200"},
                    { label = "1 Day", value = "86400"},
                    { label = "3 Days", value = "259200"},
                    { label = "1 Week", value = "604800"},
                    { label = "Permanent", value = "2147483647"},
                },
            },
            { label = "Ban", InputType = "button", type = "server", event = "ps-adminmenu:server:BanPlayer" },
        },
    },
    {
        label = "Bring Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", type = "input", InputType = "players" },
            { label = "Bring", InputType = "button", type = "server", event = "ps-adminmenu:server:BringPlayer" },
        },
    },
    {
        label = "Kick Player",
        perms = "admin",
        dropdown = {
            { label = "Player ID", type = "input", InputType = "players" },
            { label = "Reason", type = "input", InputType = "input" },
            { label = "Kick", InputType = "button", type = "server", event = "ps-adminmenu:server:KickPlayer" },
        },
    },
    {
        label = "Server Announcement",
        perms = "admin",
        dropdown = {
            { label = "Message", type = "message", InputType = "input" },
            { label = "Length", InputType = "options",
            options = {
                 { label = "10 Seconds", value = "10000"},
                 { label = "15 Seconds", value = "15000"},
                 { label = "30 Seconds", value = "30000"},
                 { label = "45 Seconds", value = "45000"},
                 { label = "1 Minutes", value = "60000"},
                 { label = "2 Minutes", value = "180000"},
             },
         },
            { label = "Announce", InputType = "button", type = "server", event = "ps-adminmenu:server:ServerAnnouncement" },
        },
    },
    {
        label = "Change Weather",
        perms = "mod",
        dropdown = {
            { label = "Weather", InputType = "options",
               options = {
                { label = "Extrasunny", value = "Extrasunny"},
                { label = "Clear", value = "Clear"},
                { label = "Neutral", value = "Neutral"},
                { label = "Smog", value = "Smog"},
                { label = "Foggy", value = "Foggy"},
                { label = "Overcast", value = "Overcast"},
                { label = "Clouds", value = "Clouds"},
                { label = "Clearing", value = "Clearing"},
                { label = "Rain", value = "Rain"},
                { label = "Thunder", value = "Thunder"},
                { label = "Snow", value = "Snow"},
                { label = "Blizzard", value = "Blizzard"},
                { label = "Snowlight", value = "Snowlight"},
                { label = "Xmas", value = "Xmas"},
                { label = "Halloween", value = "Halloween"},
                },
            },
            { label = "Change", InputType = "button", type = "client", event = "ps-adminmenu:client:ChangeWeather" },
        },
    },
    {
        label = "Change Time",
        type = "client",
        perms = "mod",
        dropdown = {
            { label = "Timestamp", InputType = "options",
               options = {
                { label = "Clear Input", value = "clear"},
                { label = "01:00", value = "01"},
                { label = "02:00", value = "02"},
                { label = "03:00", value = "03"},
                { label = "04:00", value = "04"},
                { label = "05:00", value = "05"},
                { label = "06:00", value = "06"},
                { label = "07:00", value = "07"},
                { label = "08:00", value = "08"},
                { label = "09:00", value = "09"},
                { label = "10:00", value = "10"},
                { label = "11:00", value = "11"},
                { label = "12:00", value = "12"},
                { label = "13:00", value = "13"},
                { label = "14:00", value = "14"},
                { label = "15:00", value = "15"},
                { label = "16:00", value = "16"},
                { label = "17:00", value = "17"},
                { label = "18:00", value = "18"},
                { label = "19:00", value = "19"},
                { label = "20:00", value = "20"},
                { label = "21:00", value = "21"},
                { label = "22:00", value = "22"},
                { label = "23:00", value = "23"},
                { label = "24:00", value = "24"},
                },
            },
            { label = "Time Events", InputType = "options",
               options = {
                { label = "Clear Input", value = "clear"},
                { label = "Sunrise", value = "06"},
                { label = "Morning", value = "09"},
                { label = "Noon", value = "12"},
                { label = "Sunset", value = "21"},
                { label = "Evening", value = "22"},
                { label = "Night", value = "24"},
                },
            },
            { label = "Change", InputType = "button", type = "client", event = "ps-adminmenu:client:ChangeTime" },
        },
    },
    {
        label = "Clear Inventory",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Clear", InputType = "button", type = "server", event = "ps-adminmenu:server:ClearInventory" },
        },
    },
    {
        label = "Message Player",
        perms = "admin",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Message", type = "message", InputType = "input" },
            { label = "Length", InputType = "options",
                options = {
                    { label = "10 Seconds", value = "10000"},
                    { label = "15 Seconds", value = "15000"},
                    { label = "30 Seconds", value = "30000"},
                    { label = "45 Seconds", value = "45000"},
                    { label = "1 Minutes", value = "60000"},
                    { label = "2 Minutes", value = "180000"},
                },
            },
            { label = "Send Message", InputType = "button", type = "server", event = "ps-adminmenu:server:MessagePlayer" },
        },
    },
    {
        label = "Clothing Menu",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Give Menu", InputType = "button", type = "server", event = "ps-adminmenu:server:ClothingMenu" },
        },
    },
    {
        label = "Copy Coordinates",
        perms = "mod",
        dropdown = {
            { label = "Copy Vector2", InputType = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
            { label = "Copy Vector3", InputType = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
            { label = "Copy Vector4", InputType = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
            { label = "Copy Heading", InputType = "button", type = "client", event = "ps-adminmenu:client:CopyCoords" },
        },
    },
    {
        label = "Delete Vehicle",
        perms = "mod",
        event = "dv",
        type = "command"
    },
    {
        label = "Freeze Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Freeze", InputType = "button", type = "server", event = "ps-adminmenu:server:FreezePlayer" },
        },
    },
    {
        label = "Give Nui Focus",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Submit", InputType = "button", type = "client", event = "" },
        },
    },
    {
        label = "God",
        event = "ps-adminmenu:client:ToggleGodmode",
        perms = "mod",
        type = "client"
    },
    {
        label = "Invisible",
        event = "ps-adminmenu:client:ToggleInvisible",
        perms = "mod",
        type = "client"
    },
    {
        label = "Toggle Blackout",
        event = "ps-adminmenu:server:ToggleBlackout",
        perms = "mod",
        type = "server"
    },
    {
        label = "Toggle Duty",
        event = "ps-adminmenu:client:ToggleDuty",
        perms = "mod",
        type = "client"
    },
    {
        label = "Toggle Delete Laser",
        event = "ps-adminmenu:client:ToggleDeleteLaser",
        perms = "mod",
        type = "client"
    },
    {
        label = "Kill Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Kill", InputType = "button", type = "server", event = "ps-adminmenu:server:KillPlayer" },
        },
    },
    {
        label = "Check Permissions",
        perms = "admin",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Check", InputType = "button", type = "server", event = "ps-adminmenu:server:CheckPerms" },
        },
    },
    {
        label = "Set Permissions",
        perms = "admin",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Permissions", InputType = "options",
                options = {
                { label = "Mod", value = "mod"},
                { label = "Admin", value = "admin"},
                { label = "God", value = "god"},
                },
            },
            { label = "Confirm", InputType = "button", type = "server", event = "ps-adminmenu:server:SetPerms" },
        },
    },
    {
        label = "Mute Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Mute", InputType = "button", type = "client", event = "ps-adminmenu:client:MutePlayer" },
        },
    },
    {
        label = "Noclip",
        event = "ps-adminmenu:client:ToggleNoClip",
        type = "client",
        perms = "mod",
    },
    {
        label = "Open Inventory",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Submit", InputType = "button", type = "client", event = "ps-adminmenu:client:openInventory" },
        },
    },
    {
        label = "Set On Fire",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Time", InputType = "input" },
            { label = "Let him Burn", InputType = "button", type = "server", event = "ps-adminmenu:server:SetOnFire" },
        },
    },
    {
        label = "Explode Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Damage", InputType = "options",
                options = {
                    { label = "No Damage", value = "nodamage"},
                    { label = "Damage", value = "damage"},
                },
            },
            { label = "BOOOM", InputType = "button", type = "server", event = "ps-adminmenu:server:ExplodePlayer" },
        },
    },
    {
        label = "Sit in Vehicle",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Confirm", InputType = "button", type = "server", event = "ps-adminmenu:server:SitInVehicle" },
        },
    },
    {
        label = "Open Stash",
        perms = "mod",
        dropdown = {
            { label = "Stash", InputType = "input" },
            { label = "Submit", InputType = "button", type = "client", event = "ps-adminmenu:client:openStash" },
        },
    },
    {
        label = "Change Plate",
        perms = "mod",
        dropdown = {
            { label = "Plate", InputType = "input" },
            { label = "Confirm", InputType = "button", type = "client", event = "ps-adminmenu:client:ChangePlate" },
        },
    },
    {
        label = "Refuel vehicle",
        event = "ps-adminmenu:client:RefuelVehicle",
        type = "client",
        perms = "mod",
    },
    {
        label = "Revive Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", type = "input", InputType = "players" },
            { label = "Revive", InputType = "button", type = "server", event = "ps-adminmenu:server:Revive" },
        },
    },
    {
        label = "Revive All",
        event = "ps-adminmenu:server:ReviveAll",
        type = "server",
        perms = "admin",
    },
    {
        label = "Set Job",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Job", InputType = "input" },
            { label = "Grade", InputType = "input" },
            { label = "Sumbit", InputType = "button", type = "server", event = "ps-adminmenu:server:SetJob" },
        },
    },
    {
        label = "Set Gang",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Gang", InputType = "input" },
            { label = "Grade", InputType = "input" },
            { label = "Sumbit", InputType = "button", type = "server", event = "ps-adminmenu:server:SetGang" },
        },
    },
    {
        label = "Give Money",
        perms = "admin",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Amount", InputType = "input" },
            { label = "Type", InputType = "options",
                options = {
                    { label = "Bank", value = "bank"},
                    { label = "Cash", value = "cash"},
                    { label = "Crypto", value = "crypto"},
                },
            },
            { label = "Give", InputType = "button", type = "server", event = "ps-adminmenu:server:GiveMoney" },
        },
    },
    {
        label = "Give Money to All",
        perms = "admin",
        dropdown = {
            { label = "Amount", InputType = "input" },
            { label = "Type", InputType = "options",
                options = {
                    { label = "Bank", value = "bank"},
                    { label = "Cash", value = "cash"},
                    { label = "Crypto", value = "crypto"},
                },
            },
            { label = "Give", InputType = "button", type = "server", event = "ps-adminmenu:server:GiveMoneyAll" },
        },
    },
    {
        label = "Take Money",
        perms = "admin",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Amount", InputType = "input" },
            { label = "Type", InputType = "options",
                options = {
                    { label = "Bank", value = "bank"},
                    { label = "Cash", value = "cash"},
                    { label = "Crypto", value = "crypto"},
                },
            },
            { label = "Remove", InputType = "button", type = "server", event = "ps-adminmenu:server:TakeMoney" },
        },
    },
    {
        label = "Give Item",
        perms = "admin",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Item", InputType = "input" },
            { label = "Amount", InputType = "input"},
            { label = "Give", InputType = "button", type = "server", event = "ps-adminmenu:server:GiveItem" },
        },
    },
    {
        label = "Give Item to All",
        perms = "admin",
        dropdown = {
            { label = "Item", InputType = "input" },
            { label = "Amount", InputType = "input"},
            { label = "Give", InputType = "button", type = "server", event = "ps-adminmenu:server:GiveItemAll" },
        },
    },
    {
        label = "Spawn Vehicle",
        perms = "mod",
        dropdown = {
            { label = "Vehicle", InputType = "input" },
            { label = "Sumbit", InputType = "button", type = "client", event = "ps-adminmenu:client:SpawnVehicle" },
        },
    },
    {
        label = "Fix Vehicle",
        event = "fix",
        type = "command",
        perms = "mod",
    },
    {
        label = "Fix Vehicle For",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Fix Vehicle", InputType = "button", type = "server", event = "ps-adminmenu:server:FixVehFor" },
        },
        perms = "mod",
    },
    {
        label = "Spectate Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Spectate", InputType = "button", type = "server", event = "ps-adminmenu:server:SpectateTarget" },
        },
    },
    {
        label = "Teleport To Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", type = "input", InputType = "players" },
            { label = "Teleport", InputType = "button", type = "server", event = "ps-adminmenu:server:TeleportToPlayer" },
        },
    },
    {
        label = "Teleport To Coordinates",
        perms = "mod",
        dropdown = {
            { label = "X", type = "input", InputType = "input" },
            { label = "Y", type = "input", InputType = "input" },
            { label = "Z", type = "input", InputType = "input" },
            { label = "Teleport", InputType = "button", type = "server", event = "ps-adminmenu:server:TeleportToCoords" },
        },
    },
    {
        label = "Teleport To Marker",
        event = "ps-adminmenu:client:TeleportToMarker",
        type = "client",
        perms = "mod",
    },
    {
        label = "Teleport Back",
        event = "ps-adminmenu:client:TeleportBack",
        type = "client",
        perms = "mod",
    },
    {
        label = "Vehicle Dev Menu",
        event = "ps-adminmenu:client:ToggleVehDevMenu",
        type = "client",
        perms = "mod",
    },
    {
        label = "Toggle Coords",
        event = "ps-adminmenu:client:ToggleCoords",
        type = "client",
        perms = "mod",
    },
    {
        label = "Toggle Blips",
        event = "ps-adminmenu:client:toggleBlips",
        type = "client",
        perms = "mod",
    },
    {
        label = "Toggle Names",
        event = "ps-adminmenu:client:toggleNames",
        type = "client",
        perms = "mod",
    },
    {
        label = "Max Mod Vehicle",
        event = "ps-adminmenu:client:maxmodVehicle",
        type = "client",
        perms = "mod",
    },
    {
        label = "Toggle Cuffs",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Confirm", InputType = "button", type = "client", event = "ps-adminmenu:client:ToggleCuffs" },
        },
    },
    {
        label = "Warn Player",
        perms = "mod",
        dropdown = {
            { label = "Player ID", InputType = "players" },
            { label = "Reason", InputType = "input" },
            { label = "Warn", InputType = "button", type = "server", event = "ps-adminmenu:server:warnplayer" },
        },
    },
    {
        label = "Infinite Ammo",
        event = "ps-adminmenu:client:setInfiniteAmmo",
        type = "client",
        perms = "mod",
    },
}

function ConfigInvInvalid()
    print('^1[Error] Your Config.InventoryUsage isnt set.. you probably had a typo\nYou have it set as= Config.InventoryUsage = "'.. Config.InventoryUsage .. '"')
end
