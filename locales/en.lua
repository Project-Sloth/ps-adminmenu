local Translations = {
    error = {
        ["u_veh_owner"] = "This vehicle is already yours..",
        ['cannot_store_veh'] = "Cannot store this car in your garage",
        ["not_in_veh"] = "You are not in a vehicle..",
        ["no_perms"] = "You do not have permission to do this",
        ["missing_args"] = 'Not every argument has been entered (x, y, z)',
        ["not_online"] = 'Player not online',
        ['no_waypoint'] = 'No Waypoint Set.',
        ["tp_error"] = 'Error While Teleporting.',
    },
    success = {
        ["veh_owner"] = "The vehicle is now yours!",
        ["teleported_waypoint"] = 'Teleported To Waypoint.',
    },
    info = {
        ["godmode"] = "Godmode is %{value}",
        ["invisible"] = "Invisible: %{value}",
        ["banreason"] = 'Reason: %{reason}, until %{lenght}',
        ["weatherType"] = "Weather is changed to: %{value}",
        ["ban_perm"] = "\n\nYour ban is permanent.\n🔸 Check our Discord for more information: ",
        ["ban_expires"] = "\n\nBan expires: ",
        ["banned"] = "You have been banned:",
    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
