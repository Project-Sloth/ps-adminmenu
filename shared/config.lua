Config = {}

Config.Actions = {
    { 
        label = "Admin car", -- Label of the button
        event = "ps-adminmenu:client:Admincar", -- Event or command
        type = "client", -- client, server, command
        perms = "mod", -- mod, admin
    },
    { 
        label = "Ban Player", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Reason", type = "input", inputtype = "normal" },
            { label = "Time", type = "options", 
               options = { 
                    { label = "10 Minutes", value = "600"},
                    { label = "30 Minutes", value = "1800"},
                    { label = "1 Hour", value = "3600"},
                    { label = "6 Hours", value = "21600"},
                    { label = "12 Hours", value = "43200"},
                    { label = "1 Day", value = "86400"},
                    { label = "3 Days", value = "259200"},
                    { label = "1 Week", value = "604800"},
                    { label = "Permanent", value = "315360000"},
                },
            },
            { label = "Ban", type = "button", event = "ps-adminmenu:server:BanPlayer" },
        },
    },
    { 
        label = "Bring Player", 
        type = "server",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Bring", type = "button", event = "ps-adminmenu:server:BringPlayer" },
        },
    },
    { 
        label = "Change Weather", 
        type = "client", 
        perms = "mod", 
        dropdown = {
            { label = "Weather", type = "options", 
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
            { label = "Change", type = "button", event = "ps-adminmenu:client:ChangeWeather" },
        },
    },
    { 
        label = "Change Time", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Time", type = "input", inputtype = "normal" },
            { label = "Change", type = "button", event = "ps-adminmenu:client:ChangeTime" },
        },
    },
    { 
        label = "Clear Inventory", 
        event = "ps-adminmenu:client:ClearInventory", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Clear", type = "button", event = "" },
        },
    },
    { 
        label = "Clothing Menu", 
        event = "ps-adminmenu:client:ClothingMenu", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Give Menu", type = "button", event = "" },
        },
    },
    { 
        label = "Customs", 
        event = "ps-adminmenu:client:Customs", 
        type = "client" 
    },
    { 
        label = "Freeze Player", 
        event = "ps-adminmenu:client:FreezePlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Freeze", type = "button", event = "" },
        },
    },
    { 
        label = "Give Money", 
        event = "ps-adminmenu:client:GiveMoney", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Amount", type = "input", inputtype = "normal" },
            { label = "Give", type = "button", event = "" },
        },
    },
    { 
        label = "Give Nui Focus", 
        event = "ps-adminmenu:client:SetNuiFocus", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Submit", type = "button", event = "" },
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
        event = "ps-adminmenu:client:KickPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Reason", type = "input", inputtype = "normal" },
            { label = "Kick", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Kill Player", 
        event = "ps-adminmenu:client:KillPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Kill", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Mute Player", 
        event = "ps-adminmenu:client:MutePlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Mute", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Noclip", 
        event = "ps-adminmenu:client:ToggleNoclip", 
        type = "client" 
    },
    { 
        label = "Open Inventory", 
        event = "ps-adminmenu:client:OpenInventory", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Submit", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Revive Player", 
        type = "server",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Revive", type = "button", event = "ps-adminmenu:server:Revive" },
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
        event = "ps-adminmenu:client:SetJob", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Job", type = "input", inputtype = "normal" },
            { label = "Grade", type = "input", inputtype = "normal" },
            { label = "Sumbit", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Spawn Vehicle", 
        event = "ps-adminmenu:client:SpawnVehicle", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Vehicle", type = "input", inputtype = "normal" },
            { label = "Sumbit", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Specate Player", 
        event = "ps-adminmenu:client:Spectate Player", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Spectate", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Teleport To Player", 
        type = "server",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Teleport", type = "button", event = "ps-adminmenu:server:TeleportToPlayer" },
        },
    },
    { 
        label = "Teleport To Coordinates",  
        type = "server",
        perms = "mod", 
        dropdown = {
            { label = "X", type = "input", inputtype = "normal" },
            { label = "Y", type = "input", inputtype = "normal" },
            { label = "Z", type = "input", inputtype = "normal" },
            { label = "Teleport", type = "button", event = "ps-adminmenu:server:TeleportToCoords" },
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
        event = "ps-adminmenu:client:UnbanPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Unban", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Uncuff Player", 
        event = "ps-adminmenu:client:UncuffPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Uncuff", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
    { 
        label = "Warn Player", 
        event = "ps-adminmenu:client:WarnPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {
            { label = "Player ID", type = "input", inputtype = "normal" },
            { label = "Reason", type = "input", inputtype = "normal" },
            { label = "Warn", type = "button", event = "ps-adminmenu:client:banplayer" },
        },
    },
}
