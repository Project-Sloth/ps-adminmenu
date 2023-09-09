--- @param bool boolean
function ToggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end


--- @param perms table
function CheckPerms(perms)
    return lib.callback.await('ps-adminmenu:callback:CheckPerms', false, perms)
end


--- @param title string
--- @param message string
function Log(title, message)
    print("ps-adminmenu: ", title, message)
    TriggerServerEvent("qb-log:server:CreateLog", "ps-adminmenu", title, "red", message)
end