local interval = 10 -- In Min
local discordWebhook = "" -- CFX.RE Status Discord webhook
local embedColor = 2829617 -- HEX INT COLORS https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812
----------------------------------------------------------
local colorful = { operational = "🟢", degraded_performance = "🟡", partial_outage = "🔴", major_outage = "🔴" }
local descriptionEmoji = "📜"
local allowedErr = {
    [200] = true,
    [201] = true,
    [204] = true,
    [304] = true
}

local function grabData(callback)
    PerformHttpRequest("https://status.cfx.re/api/v2/components.json", function(err, text, headers)
        local infos = json.decode(text)
        local updatetime = os.time()
        local footerTime = os.date("%H:%M")
        local embed = {
            {
                title = "CFX.RE STATUS",
                description = "> Updates every "..interval.." minutes. \n > Last API Update: ".."<t:"..updatetime..":R>".."\n",
                color = embedColor,
                footer = {
                    text = "CFX.RE STATUS | Updated at "..footerTime.."",
                    icon_url = "https://avatars.githubusercontent.com/u/25160833?s=200&v=4"
                },
            }
        }
        for k,v in pairs(infos.components) do
            local description = v.description or "No Description"
            embed[1].description = embed[1].description .. "```".. colorful[v.status] ..": " .. v.name .. "\n".. descriptionEmoji ..": ".. description .."```"
        end
        callback(embed)
    end, 'GET')
end

local function sendMessage()
    if discordWebhook == '' then
		return print("\27[31mA webhook is missing in: discordWebhook (server > cfxrestatus.lua > line 2)\27[0m")
	end
    grabData(function(embed)
        PerformHttpRequest(discordWebhook.."?wait=true", function(err, text, headers, errorData)
            if err and not allowedErr[err] then
                print("Something's not working... Error: "..err)
            end
            SetResourceKvp('lastmessageid', json.decode(text).id)
        end, 'POST', json.encode({content = nil, username = "CFX STATUS", embeds = embed}), { ['Content-Type'] = 'application/json' })
    end)
end

local function editMessage()
    if discordWebhook == '' then
		return print("\27[31mA webhook is missing in: discordWebhook (server > cfxrestatus.lua > line 2)\27[0m")
	end
    grabData(function(embed)
        PerformHttpRequest(discordWebhook.."/messages/"..tonumber(GetResourceKvpString('lastmessageid')) , function(err, text, headers, errorData)
            if err and not allowedErr[err] then
                if err == 404 then sendMessage() end
            end
        end, 'PATCH', json.encode({content = nil, username = "CFX STATUS", embeds = embed}), { ['Content-Type'] = 'application/json' })
    end)
end

CreateThread(function()
    while true do
        if tonumber(GetResourceKvpString('lastmessageid')) then
            editMessage()
        else
            sendMessage()
        end
        Wait(interval * 1000 * 60)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
	Wait(3000)
    if discordWebhook == '' then
		print("\27[31mA webhook is missing in: discordWebhook (server > cfxrestatus.lua > line 2)\27[0m")
	end
end)
