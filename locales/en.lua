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
        ["invcleared"] = "%{player}'s inventory is cleared",
        ["Frozen"] = "%{player}'s successfully frozen",
        ["deFrozen"] = "You've set %{player} free",
        ["noclip_enabled"] = "No-clip enabled",
        ["noclip_disabled"] = "No-clip disabled",
        ["copy_vector2"] = "Copied vector2",
        ["copy_vector3"] = "Copied vector3",
        ["copy_vector4"] = "Copied vector4",
        ["copy_heading"] = "Copied heading",
        ["give_money"] = "Gave Money to the Player",
        ["give_money_all"] = "Gave Money to every Player",
        ["give_item"] = "Gave the Item to the Player",
        ["give_item_all"] = "Gave the Item to every Player",
    },
    info = {
        ["godmode"] = "Godmode is %{value}",
        ["invisible"] = "Invisible: %{value}",
        ["banreason"] = 'Reason: %{reason}, until %{lenght}',
        ["weatherType"] = "Weather is changed to: %{value}",
        ["ban_perm"] = "You have been permanently banned!",
        ["ban_expires"] = "Ban expires: ",
        ["banned"] = "You have been banned!",
        ["reason"] = "Reason: ",
        ["kicked"] = "You have been kicked!",
        ["join_disc"] = "Join Discord for more information:",
    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
