Config = Config or {}

Config.Inventory = "ox" -- "ox", "ps", "lj", "qb"
Config.Fuel = "ps-fuel" -- "ps-fuel", "LegacyFuel"

Config.Actions = {
    ["noclip"] = {
        label = "Noclip",
        type = "client",
        event = "ps-adminmenu:client:ToggleNoClip",
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
                    { label = "10 Minutes", value = "600" },
                    { label = "30 Minutes", value = "1800" },
                    { label = "1 Hour",     value = "3600" },
                    { label = "6 Hours",    value = "21600" },
                    { label = "12 Hours",   value = "43200" },
                    { label = "1 Day",      value = "86400" },
                    { label = "3 Days",     value = "259200" },
                    { label = "1 Week",     value = "604800" },
                    { label = "Permanent",  value = "2147483647" },
                },
            },
            { label = "Ban", type = "server", option = "button", event = "ps-adminmenu:server:BanPlayer" },
        },
    },
}
