local Translations = {
    error = {
        ["u_veh_owner"] = "This vehicle is already yours..",
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
