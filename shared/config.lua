Config = {}

-- Set to true to use ox_inventory, false to use qbcore inventory.
Config.UseOXInventory = false 

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
            { label = "Player ID", InputType = "input" },
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
            { label = "Player ID", type = "input", InputType = "input" },
            { label = "Bring", type = "button", type = "server", event = "ps-adminmenu:server:BringPlayer" },
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
            { label = "Time", type = "input", InputType = "input" },
            { label = "Change", InputType = "button", type = "client", event = "ps-adminmenu:client:ChangeTime" },
        },
    },
    { 
        label = "Clear Inventory", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Clear", InputType = "button", type = "client", event = "" },
        },
    },
    { 
        label = "Clothing Menu", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Give Menu", InputType = "button", type = "client", event = "" },
        },
    },
    { 
        label = "Copy Coordinates", 
        perms = "mod", 
        dropdown = {
            { label = "Copy Vector2", InputType = "button", type = "client", event = "" },
            { label = "Copy Vector3", InputType = "button", type = "client", event = "" },
            { label = "Copy Vector4", InputType = "button", type = "client", event = "" },
        },
    },
    { 
        label = "Customs", 
        event = "ps-adminmenu:client:Customs", 
        type = "client" 
    },
    { 
        label = "Delete Vehicle", 
        event = "dv", 
        type = "command" 
    },
    { 
        label = "Freeze Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Freeze", InputType = "button", type = "client", event = "" },
        },
    },
    { 
        label = "Give Nui Focus", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Submit", InputType = "button", type = "client", event = "" },
        },
    },
    { 
        label = "God", 
        event = "ps-adminmenu:client:ToggleGodmode", 
        type = "client" 
    },
    { 
        label = "Invisible", 
        event = "ps-adminmenu:client:ToggleInvisible", 
        type = "client" 
    },
    { 
        label = "Kick Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Reason", InputType = "input" },
            { label = "Kick", InputType = "button", type = "server", event = "ps-adminmenu:server:KickPlayer" },
        },
    },
    { 
        label = "Kill Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Kill", InputType = "button", type = "client", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Mute Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Mute", InputType = "button", type = "client", event = "ps-adminmenu:client:MutePlayer" },
        },
    },
    { 
        label = "Noclip", 
        event = "ps-adminmenu:client:ToggleNoclip", 
        type = "client" 
    },
    { 
        label = "Open Inventory", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Submit", InputType = "button", type = "client", event = "ps-adminmenu:client:openInventory" },
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
        label = "Revive Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", InputType = "input" },
            { label = "Revive", InputType = "button", type = "server", event = "ps-adminmenu:server:Revive" },
        },
    },
    { 
        label = "Revive All", 
        event = "ps-adminmenu:server:ReviveAll", 
        type = "server" 
    },
    { 
        label = "Revive Radius", 
        event = "ps-adminmenu:client:ReviveRadius", 
        type = "client" 
    },
    { 
        label = "Set Job", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Job", InputType = "input" },
            { label = "Grade", InputType = "input" },
            { label = "Sumbit", InputType = "button", type = "client", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Set Money", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Amount", InputType = "input" },
            { label = "Type", InputType = "options", 
                options = { 
                    { label = "Bank", value = "bank"},
                    { label = "Cash", value = "cash"},
                    { label = "Crypto", value = "crypto"},
                },
            },
            { label = "Give", InputType = "button", type = "client", event = "" },
        },
    },
    { 
        label = "Spawn Vehicle", 
        perms = "mod", 
        dropdown = {
            { label = "Vehicle", InputType = "input" },
            { label = "Sumbit", InputType = "button", type = "server", event = "ps-adminmenu:server:SpawnVehicle" },
        },
    },
    { 
        label = "Specate Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Spectate", InputType = "button", type = "client", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Teleport To Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", InputType = "input" },
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
        type = "client" 
    },
    { 
        label = "Teleport Back", 
        event = "ps-adminmenu:client:TeleportBack", 
        type = "client" 
    },
    { 
        label = "Unban Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Unban", InputType = "button", type = "client", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Uncuff Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Uncuff", InputType = "button", type = "client", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Warn Player", 
        perms = "mod", 
        dropdown = {
            { label = "Player ID", InputType = "input" },
            { label = "Reason", InputType = "input" },
            { label = "Warn", InputType = "button", type = "client", event = "ps-adminmenu:client:banplayer" },
        },
    },
}
