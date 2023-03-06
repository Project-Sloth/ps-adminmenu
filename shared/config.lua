Config = Config or {}

Conifg.DebugMenu = true

Config.Admin = {
    ["admincar"] = {
        type = "server", -- "client", "server", "function", "command"
        event = "ps-adminmenu:server:ReviveAll", -- Event
        perms = {"god", "admin", "mod"}, -- Permissions 
    },
    ["banplayer"] = {
        label = "Ban Player"
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
        dropdown = {
            [1] = {type = "input", id = "ban_playerid", label = "Player ID",},
            [2] = {type = "input", id = "ban_reason", label = "Reason",},
            [3] = {type = "input", id = "ban_length", label = "Length",},
            [4] = {type = "button", id = "ban_button", label = "Ban",}, 
        },
    },
    ["bringplayer"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["changeweather"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["clearinventory"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["clothingmenu"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["customs"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["fixvehicle"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["freeze"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["givecash"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["givenuifocus"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["god"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["kick"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["kickall"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["kill"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["maxammo"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["muteplayer"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["noclip"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["openinventory"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["revive"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["reviveall"] = {
        type = "server",
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["reviveradius"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["setjob"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["spawncar"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["spectate"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["teleport"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["teleportcoords"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["teleportmarker"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["unbanplayer"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["uncuff"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    },
    ["warn"] = {
        type = "server", 
        event = "ps-adminmenu:server:ReviveAll",
        perms = {"god", "admin", "mod"}, 
    }
}

