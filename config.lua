Config = {}

Config.Templates = {
    -- ----------------------------
    -- Advanced notification templates
    -- ----------------------------
    INFO = {
        title = "~#3c9ce6~Information~e~",
        icon = "warning",
        duration = 5000,
        placement = 'middle-left',
        customSound = {
            sound = "INFO",
            soundSet = "HUD_SHOP_SOUNDSET"
        }
    },
    SUCCESS = {
        title = "~#73f75c~Success!~e~",
        icon = "tick",
        duration = 5000,
        placement = 'middle-left',
        customSound = {
            sound = "CHECKPOINT_PERFECT",
            soundSet = "HUD_MINI_GAME_SOUNDSET",
        }
    },
    ERROR = {
        title = "~#f73434~Failed!~e~",
        icon = "cross",
        duration = 7000,
        placement = 'middle-left',
        customSound = {
            sound = "FAIL",
            soundSet = "Objective_Sounds"
        }
    },
    REWARD_MONEY = {
        title = "~#ffcc00~Here's your reward!~e~",
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