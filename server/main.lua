local resourceName = GetCurrentResourceName()

local function SendNotification(target, options, template)
    if target == nil then
        return print("Error: source must be provided (use -1 for all players)")
    end

    TriggerClientEvent(resourceName .. ":send", target, options, template)
end

RegisterNetEvent(resourceName .. ":send")
AddEventHandler(resourceName .. ":send", function(target, options, template)
    SendNotification(target, options, template)
end)

exports("send", function(target, options, template)
    SendNotification(target, options, template)
end)

exports("tip", function(target, message, duration, placement, sound, soundSet)
    SendNotification(target, {
        title = message,
        duration = duration or 5000,
        placement = placement or 'middle-right',
        useBackground = false,
        customSound = {
            sound = sound or "INFO_SHOW",
            soundSet = soundSet or "Ledger_Sounds"
        }
    })
end)
