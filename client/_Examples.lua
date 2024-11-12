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
    local awardIcons = {
        "awards_set_a_009",
        "awards_set_a_010",
        "awards_set_a_011",
        "awards_set_a_012",
        "awards_set_a_013",
        "awards_set_a_014",
        "awards_set_a_015",
        "awards_set_b_001",
        "awards_set_b_001",
        "awards_set_b_003",
        "awards_set_b_019",
        "awards_set_b_011",
        "awards_set_b_012",
        "awards_set_b_013",
        "awards_set_b_014",
        "awards_set_b_015",
        "awards_set_b_016",
        "awards_set_b_019",
        "awards_set_c_001",
        "awards_set_c_002",
        "awards_set_c_003",
        "awards_set_c_004",
        "awards_set_c_005",
        "awards_set_c_006",
        "awards_set_c_008",
        "awards_set_c_010",
        "awards_set_c_011",
        "awards_set_c_012",
        "awards_set_c_013",
        "awards_set_c_014",
        "awards_set_d_001",
        "awards_set_d_002",
        "awards_set_d_003",
        "awards_set_d_004",
        "awards_set_d_005",
        "awards_set_e_002",  
        "awards_set_e_003",
        "awards_set_e_004",
        "awards_set_e_006",
        "awards_set_e_007",
        "awards_set_e_008",
        "awards_set_e_009",
        "awards_set_e_010",
        "awards_set_e_011",
        "awards_set_e_012",
        "awards_set_e_013",
        "awards_set_f_001",
        "awards_set_f_002"
    }
    return awardIcons[math.random(#awardIcons)]
end

-- --------------------------------
-- All Advanced
-- --------------------------------

local function GetRandomColor()
    local colors = {
       "#fcba03", "#ffb86b"
    }
    return colors[math.random(#colors)]
end

local function GetRandomImage()
    local images = {
        "leaderboard_cash", "leaderboard_gold", "leaderboard_xp", "warning"
    }
    return images[math.random(#images)]
end

local function AddRandomStyling(text)
    local shouldAddColor = math.random() < 0.7
    local shouldAddImage = math.random() < 0.5
    local styledText = text
    if shouldAddColor then
        styledText = 'This is a description. ' .. "~" .. GetRandomColor() .. "~" .. styledText .. "~e~"
    end
    
    if shouldAddImage then
        styledText = styledText .. "~img:" .. GetRandomImage() .. "~ "
    end
    
    return styledText
end

RegisterCommand("bln_notify_allAdvanced", function(source, args, rawCommand)
    local baseTitle = "Notification ~#ffcc00~Title!~e~"
    local baseDescription = "This is a custom color."

    for _, placement in ipairs(placements) do
        local styledTitle = baseTitle
        local styledDescription = AddRandomStyling(baseDescription)
        
        local options = {
            title = styledTitle,
            description = styledDescription,
            icon = GetRandomIcon(),
            placement = placement,
            isRTL = args[1] == 'RTL',
            keyActions = {
                E = { 
                    action = "test_action",
                    closeOnPress = true
                }
            },
            progress = {
                enabled = true,
                type = math.random() < 0.5 and 'bar' or 'circle',
                color = GetRandomColor()
            },
            duration = 10000,
        }
        
        TriggerEvent("bln_notify:send", options)
        
        Citizen.Wait(100)
    end
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_allAdvanced", "Show notifications in all placements", {
    { name = "direction", help = "Use 'RTL' for right-to-left text direction" }
})

-- --------------------------------
-- All Tips
-- --------------------------------
RegisterCommand("bln_notify_allTips", function(source, args, rawCommand)
    local title = "This is a tip ~img:mp_roles_bounty_hunter_tier~ from ~#ffcc00~BLN Notify~e~!"

    for _, placement in ipairs(placements) do
        local options = {
            title = title,
            placement = placement,
            isRTL = args[1] == 'RTL',
            icon = args[2] == 'icon' and GetRandomIcon(),
        }
        
        TriggerEvent("bln_notify:send", options, 'TIP')
        
        Citizen.Wait(100)
    end
end, false)
TriggerEvent("chat:addSuggestion", "/bln_notify_allTips", "Show tip notifications in all placements", {
    { name = "direction", help = "Use 'RTL' for right-to-left text direction" },
    { name = "icon", help = "Use 'icon' to include a random icon" }
})

-- --------------------------------
-- bln_notify
-- --------------------------------
RegisterCommand("bln_notify", function(source, args, rawCommand)
    local defaultPlacement = "middle-right"
    local defaultTitle = "~#ffcc00~Notification~e~"
    local defaultTitleRTL = "~#ffcc00~عنوان~e~ الاشعار"
    local defaultDesc = "This is a ~#4CAF50~sample~e~ notification, with a ~img:mp_roles_collector_tier~ custom icon."
    local defaultDescRTL = "هذا هو ~#4CAF50~نموذج~e~ للإشعار، مع ~img:mp_roles_collector_tier~ أيقونة مخصصة."
    local defaultIcon = "mp_roles_trader_tier"
    
    local validPlacements = {
        ["top-right"] = true,
        ["top-center"] = true,
        ["top-left"] = true,
        ["middle-right"] = true,
        ["middle-center"] = true,
        ["middle-left"] = true,
        ["bottom-right"] = true,
        ["bottom-center"] = true,
        ["bottom-left"] = true
    }

    local isRTL = args[1] == 'rtl'
    local title, desc = '', ''
    if isRTL then
        title = defaultTitleRTL
        desc = defaultDescRTL
    else
        title = defaultTitle
        desc = defaultDesc
    end

    local options = {
        isRTL = isRTL,
        title = args[2] or title,
        description = args[3] or desc,
        icon = args[4] or defaultIcon,
        placement = (args[5] and validPlacements[args[5]] and args[5]) or defaultPlacement,
    }

    TriggerEvent("bln_notify:send", options)
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify", "Show a custom notification", {
    {name = "isRTL", help = "Use 'RTL' for right-to-left text direction"},
    { name = "title", help = "Notification title (supports colors with ~color~ or ~#hex~)" },
    { name = "description", help = "Description (supports colors and images with ~img:name~)" },
    { name = "icon", help = "Main notification icon name" },
    { name = "placement", help = "Position: [top/middle/bottom]-[left/center/right]" }
})

-- --------------------------------
-- template example
-- --------------------------------
RegisterCommand("bln_notify_template", function(source, args, rawCommand)
    local options = {
        title = args[2],
    }
    options.description = args[3] or 'This is a description example.'
    TriggerEvent("bln_notify:send", options, args[1])
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_template", "Run notification from template", {
    { name = "templateName", help = "Template name like (SUCCESS, TIP,...)" },
    { name = "title", help = "Title of notification." },
    { name = "description", help = "Description for notification (optional)." }
})

-- --------------------------------
-- progress notify example
-- --------------------------------
RegisterCommand("bln_notify_progress", function(source, args, rawCommand)
    local options = {
        title = "Information ~#ffcd02~title~e~",
        description = "This is a description with ~#ffcc00~custom color~e~.",
        icon = "warning",
        duration = 10000,
        placement = 'middle-left',
        progress = {
            enabled = true,
            type = args[1] or 'bar',
            color = '#ffcc00'
        }
    }
    TriggerEvent("bln_notify:send", options)
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_progress", "Run notification with progress", {
    { name = "type", help = "Progress type [bar], [circle]" },
})

-- --------------------------------
-- keyActions notify example
-- --------------------------------
RegisterCommand("bln_notify_key", function(source, args, rawCommand)
    local options = {
        title = "Key Notify ~#ffcd02~title~e~",
        description = "This is a description with ~#ffcc00~custom color~e~. Press ~key:ENTER~ to Accept, ~key:F6~ to decline.",
        icon = "warning",
        duration = 10000,
        placement = 'middle-left',
        keyActions = {
            ['ENTER'] = "accept", -- `accept` is action name.
            ['F6'] = "decline" 
        }
    }
    TriggerEvent("bln_notify:send", options)
end, false)

TriggerEvent("chat:addSuggestion", "/bln_notify_key", "Run notification with key", {
    { name = "key", help = "key" },
})

-- Listen event for key press of our notification
RegisterNetEvent("bln_notify:keyPressed")
AddEventHandler("bln_notify:keyPressed", function(action)
    print("Key pressed: " .. action)
end)