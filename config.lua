Config = {}

Config.Templates = {
    -- ----------------------------
    -- Advanced notification templates
    -- ----------------------------
    INFO = {
        title = "Information",
        icon = "warning",
        duration = 5000,
        titleColor = "#FFFFFF",
        descriptionColor = "#CCCCCC",
        placement = 'middle-left',
        customSound = {
            sound = "INFO",
            soundSet = "HUD_SHOP_SOUNDSET"
        }
    },
    SUCCESS = {
        title = "Success",
        icon = "tick",
        duration = 5000,
        titleColor = "#00FF00",
        descriptionColor = "#CCFFCC",
        placement = 'middle-left',
        customSound = {
            sound = "CHECKPOINT_PERFECT",
            soundSet = "HUD_MINI_GAME_SOUNDSET",
        }
    },
    ERROR = {
        title = "Error",
        icon = "cross",
        duration = 7000,
        titleColor = "#FF0000",
        descriptionColor = "#FFCCCC",
        placement = 'middle-left',
        customSound = {
            sound = "FAIL",
            soundSet = "Objective_Sounds"
        }
    },
    REWARD_MONEY = {
        title = "Here's your reward!",
        icon = 'toast_mp_daily_objective_small',
        duration = 7000,
        placement = 'middle-left',
        customSound = {
            sound = "REWARD_NEW_GUN",
            soundSet = "HUD_REWARD_SOUNDSET"
        }
    },
    
    -- ----------------------------
    -- Tip notification templates
    -- ----------------------------
    TIP = {
        useBackground = false,
        duration = 5000,
        placement = 'middle-right',
        customSound = {
            sound = "INFO_SHOW",
            soundSet = "Ledger_Sounds"
        }
    },
    TIP_CASH = {
        icon = 'leaderboard_cash',
        useBackground = false,
        duration = 5000,
        placement = 'middle-right',
        customSound = {
            sound = "PURCHASE",
            soundSet = "Ledger_Sounds"
        }
    },
    TIP_XP = {
        icon = 'leaderboard_xp',
        useBackground = false,
        duration = 5000,
        placement = 'middle-right',
        customSound = {
            sound = "INFO_SHOW",
            soundSet = "Ledger_Sounds"
        }
    },
    TIP_GOLD = {
        icon = 'leaderboard_gold',
        useBackground = false,
        duration = 5000,
        placement = 'middle-right',
        customSound = {
            sound = "REWARD_NEW_GUN",
            soundSet = "HUD_REWARD_SOUNDSET"
        }
    },
}