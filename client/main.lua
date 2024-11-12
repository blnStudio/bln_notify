local resourceName = GetCurrentResourceName()

-- --------------------------------------------------------
-- Action Keys
-- --------------------------------------------------------
local activeNotifications = {}

local function RegisterNotificationKeys(notificationId, keyActions)
    if not keyActions then return end
    
    local validKeyActions = {}
    for keyName, action in pairs(keyActions) do
        local keyHash = Keys[string.upper(keyName)]
        if keyHash then
            validKeyActions[keyHash] = {
                action = action,
                keyName = string.upper(keyName)
            }
        else
            print(string.format("Warning: Invalid key name '%s' for notification", keyName))
        end
    end
    
    activeNotifications[notificationId] = {
        keyActions = validKeyActions,
        active = true
    }
end

local function RemoveNotificationKeys(notificationId)
    if activeNotifications[notificationId] then
        activeNotifications[notificationId].active = false
        activeNotifications[notificationId] = nil
    end
end

CreateThread(function()
    while true do
        Wait(0)
        for notificationId, data in pairs(activeNotifications) do
            if data.active then
                for keyHash, keyData in pairs(data.keyActions) do
                    if IsControlJustPressed(0, keyHash) then
                        SendNUIMessage({
                            type = 'BLN_NOTIFY_KEY_PRESSED',
                            notificationId = notificationId,
                            key = keyData.keyName
                        })
                        TriggerEvent('bln_notify:keyPressed', keyData.action)
                    end
                end
            end
        end
    end
end)

-- --------------------------------------------------------
-- Notification System
-- --------------------------------------------------------

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

    local notificationId = math.random(1000000)
    
    options.id = notificationId
    
    if options.keyActions then
        RegisterNotificationKeys(notificationId, options.keyActions)
    end

    SendNUIMessage({
        type = "BLN_NOTIFY",
        options = finalOptions
    })

    if options.duration then
        SetTimeout(options.duration, function()
            RemoveNotificationKeys(notificationId)
        end)
    end
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

