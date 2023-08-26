function ToggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

function CheckPerms(perms)
    local hasPerms = lib.callback.await('ps-adminmenu:callback:CheckPerms', false, perms)

    return hasPerms
end