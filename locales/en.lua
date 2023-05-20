local Translations = {
    error = {
        ["u_veh_owner"] = "This vehicle is already yours..",
        ['cannot_store_veh'] = "Cannot store this car in your garage",
        ["not_in_veh"] = "You are not in a vehicle..",
    },
    success = {
        ["veh_owner"] = "The vehicle is now yours!",
    },
    info = {

    },

}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
