local resourceName = GetCurrentResourceName()

local placements = {
    "top-right",
    "top-center",
    "top-left",
    "middle-right",
    "middle-center",
    "middle-left",
    "bottom-right",
    "bottom-center",
    "bottom-left"
}

local function GetRandomIcon()
    local iconList = {
        'generic_bundle_crafting',
        'consumable_meal_camp_stew_daily_7',
        'document_animal_pamphlet',
        'document_card_pentacles_set',
        'mp_animal_panther_legendary_03',
        'provision_coin_1800_gld_dlr',
        'generic_coach',
        'generic_horse_mod',
    }
    return iconList[math.random(#iconList)]
end

RegisterCommand("bln_notify_allAdvanced", function(source, args, rawCommand)
    local title = "Notification!"
    local description = "This is a test notification for all placements. We can also specify direction in this command."

    for _, placement in ipairs(placements) do
        local options = {
            title = title,
            description = description,
            icon = GetRandomIcon(),
            placement = placement,
            isRTL = args[1] == 'RTL',
        }
        
        TriggerEvent(resourceName .. ":send", options)
        
        Citizen.Wait(100)
    end
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_allAdvanced", "Show notifications in all placements", {
    { name = "direction", help = "Use 'RTL' for right-to-left text direction" }
})

RegisterCommand("bln_notify_allTips", function(source, args, rawCommand)
    local title = "This is a tip from BLN Notify!"

    for _, placement in ipairs(placements) do
        local options = {
            title = title,
            placement = placement,
            isRTL = args[1] == 'RTL',
            icon = args[2] == 'icon' and GetRandomIcon(),
        }
        
        TriggerEvent(resourceName .. ":send", options, 'TIP')
        
        Citizen.Wait(100)
    end
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_allTips", "Show tip notifications in all placements", {
    { name = "direction", help = "Use 'RTL' for right-to-left text direction" },
    { name = "icon", help = "Use 'icon' to include a random icon" }
})

RegisterCommand("bln_notify_info", function(source, args, rawCommand)
    local description = "This is an INFO notification."
    local options = {
        placement = args[1] or 'middle-right',
        description = description,
    }
    TriggerEvent(resourceName .. ":send", options, "INFO")
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_info", "Show an INFO notification", {
    { name = "placement", help = "Notification placement (e.g., 'middle-right')" }
})

RegisterCommand("bln_notify_success", function(source, args, rawCommand)
    local description = "This is a SUCCESS notification."
    local options = {
        placement = args[1] or 'middle-right',
        description = description
    }
    TriggerEvent(resourceName .. ":send", options, "SUCCESS")
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_success", "Show a SUCCESS notification", {
    { name = "placement", help = "Notification placement (e.g., 'middle-right')" }
})

RegisterCommand("bln_notify_error", function(source, args, rawCommand)
    local description = "This is an ERROR notification."
    local options = {
        placement = args[1] or 'middle-right',
        description = description
    }
    TriggerEvent(resourceName .. ":send", options, "ERROR")
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_error", "Show an ERROR notification", {
    { name = "placement", help = "Notification placement (e.g., 'middle-right')" }
})

RegisterCommand("bln_notify", function(source, args, rawCommand)
    local options = {
        title = 'Hello!',
        description = "This is a TIP notification.",
        icon = GetRandomIcon(),
        placement = args[1] or 'middle-right',
    }
    TriggerEvent(resourceName .. ":send", options)
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify", "Show a custom notification", {
    { name = "placement", help = "Notification placement (e.g., 'middle-right')" }
})

RegisterCommand("bln_notify_tip", function(source, args, rawCommand)
    local options = {
        title = 'This is a TIP notification.',
        placement = args[1] or 'middle-right',
        icon = args[2] == 'icon' and GetRandomIcon(),
    }
    TriggerEvent(resourceName .. ":send", options, "TIP")
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_tip", "Show a TIP notification", {
    { name = "placement", help = "Notification placement (e.g., 'middle-right')" },
    { name = "icon", help = "Use 'icon' to include a random icon" }
})

print("BLN Notify Advanced Examples loaded. Use the following commands to test:")
print("/bln_notify_allAdvanced [RTL]")
print("/bln_notify_allTips [RTL] [icon]")
print("/bln_notify_info [placement]")
print("/bln_notify_success [placement]")
print("/bln_notify_error [placement]")
print("/bln_notify [placement]")
print("/bln_notify_tip [placement] [icon]")