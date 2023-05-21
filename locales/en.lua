local Translations = {
    error = {
        ["u_veh_owner"] = "This vehicle is already yours..",
        ['cannot_store_veh'] = "Cannot store this car in your garage",
        ["not_in_veh"] = "You are not in a vehicle..",
        ["no_perms"] = "You do not have permission to do this",
    },
    success = {
        ["veh_owner"] = "The vehicle is now yours!",
    },
    info = {
        ["godmode"] = "Godmode is %{value}",
        ["invisible"] = "Invisible: %{value}",
        ["banreason"] = 'Reason: %{reason}, until %{lenght}',
        ["weatherType"] = "Weather is changed to: %{value}",
    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
