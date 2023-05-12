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
            { label = "label", type = "input", inputtype = "normal", },
            { label = "Ban", type = "button", event = "ps-adminmenu:client:banplayer", },
        },
    },
    { 
        label = "Bring Player", 
        event = "ps-adminmenu:client:BringPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Change Weather", 
        event = "ps-adminmenu:client:ChangeWeather", 
        type = "client", 
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Clear Inventory", 
        event = "ps-adminmenu:client:ClearInventory", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Clothing Menu", 
        event = "ps-adminmenu:client:ClothingMenu", 
        type = "client",
        perms = "mod", 
        dropdown = {},
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
        dropdown = {},
    },
    { 
        label = "Give Money", 
        event = "ps-adminmenu:client:GiveMoney", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Give Nui Focus", 
        event = "ps-adminmenu:client:SetNuiFocus", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "God", 
        event = "ps-adminmenu:client:ToggleGod", 
        type = "server" 
    },
    { 
        label = "Invisible", 
        event = "ps-adminmenu:client:ToggleInvisible", 
        type = "command" 
    },
    { 
        label = "Kick Player", 
        event = "ps-adminmenu:client:KickPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Kill Player", 
        event = "ps-adminmenu:client:KillPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Mute Player", 
        event = "ps-adminmenu:client:MutePlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
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
        dropdown = {},
    },
    { 
        label = "Revive Player", 
        event = "ps-adminmenu:client:Revive Player", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Revive All", 
        event = "ps-adminmenu:client:ReviveAll", 
        type = "client" 
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
        dropdown = {},
    },
    { 
        label = "Spawn Vehicle", 
        event = "ps-adminmenu:client:SpawnVehicle", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Specate Player", 
        event = "ps-adminmenu:client:Spectate Player", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Teleport To Player", 
        event = "ps-adminmenu:client:TeleportToPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Teleport To Coords", 
        event = "ps-adminmenu:client:TeleportToCoords", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Teleport To Marker", 
        event = "ps-adminmenu:client:TeleportToMarker", 
        type = "client" 
    },
    { 
        label = "Unban Player", 
        event = "ps-adminmenu:client:UnbanPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Uncuff Player", 
        event = "ps-adminmenu:client:UncuffPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
    { 
        label = "Warn Player", 
        event = "ps-adminmenu:client:WarnPlayer", 
        type = "client",
        perms = "mod", 
        dropdown = {},
    },
}
