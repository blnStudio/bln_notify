local resourceName = GetCurrentResourceName()

local function SendNotification(options, template)
    if type(options) ~= "table" and type(template) ~= "table" then
        return print("Error: options or template must be a table")
    end

    local finalOptions = {}
    
    if template and type(template) == "string" and Config.Templates[template] then
        for k, v in pairs(Config.Templates[template]) do
            finalOptions[k] = v
        end
    end
    
    for k, v in pairs(options) do
        finalOptions[k] = v
    end

    SendNUIMessage({
        type = "BLN_NOTIFY",
        options = finalOptions
    })
end

RegisterNuiCallback("playSound", function(data, cb)

    if data.sound and data.soundSet then
        PlaySoundFrontend(data.sound, data.soundSet, true, 0)
    else
        local sound = "INFO_HIDE"
        local soundSet = "Ledger_Sounds"
        PlaySoundFrontend(sound, soundSet, true, 0)
    end
    cb("ok")
end)

RegisterNetEvent(resourceName .. ":send")
AddEventHandler(resourceName .. ":send", function(options, template)
    SendNotification(options, template)
end)