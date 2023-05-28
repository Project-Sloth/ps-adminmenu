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
        ["empty_input"] = 'Input was empty.',
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
        ["give_money"] = "Gave %{player} %{info}",
        ["give_money_crypto"] = "Gave %{info} Crypto/s to %{player}",
        ["give_money_all"] = "Added %{info} to every Players %{moneyType}",
        ["give_money_all_crypto"] = "Gave %{info} Crypto/s to every Player",
        ["give_item"] = "Gave %{info} to %{player}",
        ["give_item_all"] = "Gave %{info} to every Player",
        ["take_money"] = "Removed %{info} from %{player}",
        ["take_money_crypto"] = "Removed %{info} Crypto/s from %{player}",
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
        ["blackout"] = "Blackout is %{value}",
        ["not_enough_money"] = "Insufficient funds to remove money from the player",
    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
