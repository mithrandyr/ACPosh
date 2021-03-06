class acBase {
    [int]$Id

    acBase() {}
    acBase([string]$className) {
        $this | Add-Member -MemberType ScriptProperty -Name "Name" -Value ([scriptblock]::Create('[{0}]::nameHT[$this.Id]' -f $className))
        $this | Add-Member -MemberType ScriptProperty -Name "Description" -Value ([scriptblock]::Create('[{0}]::descriptionHT[$this.Id]' -f $className))
    }
}
class acBool:acBase {
    [bool]$Value
    
    acBool(): base("acBool") { }

    [string] ToString() { return ("{0}: {1}" -f $this.Name, $this.Value) }

    static [acBool] Create([int]$Id, [bool]$value) { return ([acBool]@{Id = $Id; Value = $value}) }
    
    hidden static [hashtable]$nameHT = @{1 = "STUCK_BOOL"
        2 = "OPEN_BOOL"
        3 = "LOCKED_BOOL"
        4 = "ROT_PROOF_BOOL"
        5 = "ALLEGIANCE_UPDATE_REQUEST_BOOL"
        6 = "AI_USES_MANA_BOOL"
        7 = "AI_USE_HUMAN_MAGIC_ANIMATIONS_BOOL"
        8 = "ALLOW_GIVE_BOOL"
        9 = "CURRENTLY_ATTACKING_BOOL"
        10 = "ATTACKER_AI_BOOL"
        11 = "IGNORE_COLLISIONS_BOOL"
        12 = "REPORT_COLLISIONS_BOOL"
        13 = "ETHEREAL_BOOL"
        14 = "GRAVITY_STATUS_BOOL"
        15 = "LIGHTS_STATUS_BOOL"
        16 = "SCRIPTED_COLLISION_BOOL"
        17 = "INELASTIC_BOOL"
        18 = "VISIBILITY_BOOL"
        19 = "ATTACKABLE_BOOL"
        20 = "SAFE_SPELL_COMPONENTS_BOOL"
        21 = "ADVOCATE_STATE_BOOL"
        22 = "INSCRIBABLE_BOOL"
        23 = "DESTROY_ON_SELL_BOOL"
        24 = "UI_HIDDEN_BOOL"
        25 = "IGNORE_HOUSE_BARRIERS_BOOL"
        26 = "HIDDEN_ADMIN_BOOL"
        27 = "PK_WOUNDER_BOOL"
        28 = "PK_KILLER_BOOL"
        29 = "NO_CORPSE_BOOL"
        30 = "UNDER_LIFESTONE_PROTECTION_BOOL"
        31 = "ITEM_MANA_UPDATE_PENDING_BOOL"
        32 = "GENERATOR_STATUS_BOOL"
        33 = "RESET_MESSAGE_PENDING_BOOL"
        34 = "DEFAULT_OPEN_BOOL"
        35 = "DEFAULT_LOCKED_BOOL"
        36 = "DEFAULT_ON_BOOL"
        37 = "OPEN_FOR_BUSINESS_BOOL"
        38 = "IS_FROZEN_BOOL"
        39 = "DEAL_MAGICAL_ITEMS_BOOL"
        40 = "LOGOFF_IM_DEAD_BOOL"
        41 = "REPORT_COLLISIONS_AS_ENVIRONMENT_BOOL"
        42 = "ALLOW_EDGE_SLIDE_BOOL"
        43 = "ADVOCATE_QUEST_BOOL"
        44 = "IS_ADMIN_BOOL"
        45 = "IS_ARCH_BOOL"
        46 = "IS_SENTINEL_BOOL"
        47 = "IS_ADVOCATE_BOOL"
        48 = "CURRENTLY_POWERING_UP_BOOL"
        49 = "GENERATOR_ENTERED_WORLD_BOOL"
        50 = "NEVER_FAIL_CASTING_BOOL"
        51 = "VENDOR_SERVICE_BOOL"
        52 = "AI_IMMOBILE_BOOL"
        53 = "DAMAGED_BY_COLLISIONS_BOOL"
        54 = "IS_DYNAMIC_BOOL"
        55 = "IS_HOT_BOOL"
        56 = "IS_AFFECTING_BOOL"
        57 = "AFFECTS_AIS_BOOL"
        58 = "SPELL_QUEUE_ACTIVE_BOOL"
        59 = "GENERATOR_DISABLED_BOOL"
        60 = "IS_ACCEPTING_TELLS_BOOL"
        61 = "LOGGING_CHANNEL_BOOL"
        62 = "OPENS_ANY_LOCK_BOOL"
        63 = "UNLIMITED_USE_BOOL"
        64 = "GENERATED_TREASURE_ITEM_BOOL"
        65 = "IGNORE_MAGIC_RESIST_BOOL"
        66 = "IGNORE_MAGIC_ARMOR_BOOL"
        67 = "AI_ALLOW_TRADE_BOOL"
        68 = "SPELL_COMPONENTS_REQUIRED_BOOL"
        69 = "IS_SELLABLE_BOOL"
        70 = "IGNORE_SHIELDS_BY_SKILL_BOOL"
        71 = "NODRAW_BOOL"
        72 = "ACTIVATION_UNTARGETED_BOOL"
        73 = "HOUSE_HAS_GOTTEN_PRIORITY_BOOT_POS_BOOL"
        74 = "GENERATOR_AUTOMATIC_DESTRUCTION_BOOL"
        75 = "HOUSE_HOOKS_VISIBLE_BOOL"
        76 = "HOUSE_REQUIRES_MONARCH_BOOL"
        77 = "HOUSE_HOOKS_ENABLED_BOOL"
        78 = "HOUSE_NOTIFIED_HUD_OF_HOOK_COUNT_BOOL"
        79 = "AI_ACCEPT_EVERYTHING_BOOL"
        80 = "IGNORE_PORTAL_RESTRICTIONS_BOOL"
        81 = "REQUIRES_BACKPACK_SLOT_BOOL"
        82 = "DONT_TURN_OR_MOVE_WHEN_GIVING_BOOL"
        83 = "NPC_LOOKS_LIKE_OBJECT_BOOL"
        84 = "IGNORE_CLO_ICONS_BOOL"
        85 = "APPRAISAL_HAS_ALLOWED_WIELDER_BOOL"
        86 = "CHEST_REGEN_ON_CLOSE_BOOL"
        87 = "LOGOFF_IN_MINIGAME_BOOL"
        88 = "PORTAL_SHOW_DESTINATION_BOOL"
        89 = "PORTAL_IGNORES_PK_ATTACK_TIMER_BOOL"
        90 = "NPC_INTERACTS_SILENTLY_BOOL"
        91 = "RETAINED_BOOL"
        92 = "IGNORE_AUTHOR_BOOL"
        93 = "LIMBO_BOOL"
        94 = "APPRAISAL_HAS_ALLOWED_ACTIVATOR_BOOL"
        95 = "EXISTED_BEFORE_ALLEGIANCE_XP_CHANGES_BOOL"
        96 = "IS_DEAF_BOOL"
        97 = "IS_PSR_BOOL"
        98 = "INVINCIBLE_BOOL"
        99 = "IVORYABLE_BOOL"
        100 = "DYABLE_BOOL"
        101 = "CAN_GENERATE_RARE_BOOL"
        102 = "CORPSE_GENERATED_RARE_BOOL"
        103 = "NON_PROJECTILE_MAGIC_IMMUNE_BOOL"
        104 = "ACTD_RECEIVED_ITEMS_BOOL"
        105 = "UNKNOWN__GUESSEDNAME"
        106 = "FIRST_ENTER_WORLD_DONE_BOOL"
        107 = "RECALLS_DISABLED_BOOL"
        108 = "RARE_USES_TIMER_BOOL"
        109 = "ACTD_PREORDER_RECEIVED_ITEMS_BOOL"
        110 = "AFK_BOOL"
        111 = "IS_GAGGED_BOOL"
        112 = "PROC_SPELL_SELF_TARGETED_BOOL"
        113 = "IS_ALLEGIANCE_GAGGED_BOOL"
        114 = "EQUIPMENT_SET_TRIGGER_PIECE_BOOL"
        115 = "UNINSCRIBE_BOOL"
        116 = "WIELD_ON_USE_BOOL"
        117 = "CHEST_CLEARED_WHEN_CLOSED_BOOL"
        118 = "NEVER_ATTACK_BOOL"
        119 = "SUPPRESS_GENERATE_EFFECT_BOOL"
        120 = "TREASURE_CORPSE_BOOL"
        121 = "EQUIPMENT_SET_ADD_LEVEL_BOOL"
        122 = "BARBER_ACTIVE_BOOL"
        123 = "TOP_LAYER_PRIORITY_BOOL"
        124 = "NO_HELD_ITEM_SHOWN_BOOL"
        125 = "LOGIN_AT_LIFESTONE_BOOL"
        126 = "OLTHOI_PK_BOOL"
        127 = "ACCOUNT_15_DAYS_BOOL"
        128 = "HAD_NO_VITAE_BOOL"
        129 = "NO_OLTHOI_TALK_BOOL"
        130 = "AUTOWIELD_LEFT_BOOL"
    }

    hidden static [hashtable]$descriptionHT = @{1 = "Can an object be picked up, if it can't this is false"
        2 = "determines whether a chest/door is open "
        3 = "determines whether a chest/door is locked"
        6 = "determines whether a creatures consumes mana on spellcast"
        7 = "creatures use human spellcasting animations"
        8 = "npc/creature accepts items being handed to it"
        9 = "creature is currently attacking"
        13 = "determines whether the object allows players models to pass through it"
        14 = "determines whether an object is affected by gravity"
        15 = "determines whether the object emits light on to nearby objects/terrain"
        16 = "related to projectile collisions"
        17 = "related to projectiles"
        18 = "generator/trap/pressureplate visibility"
        19 = "determines whether an npc/creature is attackable"
        22 = "1 = allow Inscription"
        23 = "1 = item does not appear in vendor inventory when sold"
        24 = "determines whether an item can be selected, 0 = yes, 1 = no"
        25 = "1 = character model can pass through housing barrier"
        27 = "recently attacked / was attacked ?"
        28 = "player killer status / recently killed a pk?"
        29 = "only appears if set to 1, creature does not leave a corpse"
        30 = "lifestone protection spell is active"
        33 = "doors/chests"
        34 = "doors/chests, always set to 0 if it appears"
        35 = "object is locked by default, doors/chests etc"
        39 = "sells buffs"
        42 = "1 = character will 'slide' along object if running against object at angle"
        43 = "player has completed the advocate quest"
        44 = "player is an administrator"
        45 = "Architect, Archon?"
        46 = "player is a sentinel"
        47 = "player is an advocate"
        49 = "generator has spawned on server start"
        50 = "npcs / mobs never fail to spellcast"
        52 = "creatures that don't move (npcs, mobs, mobs disguised as objects)"
        53 = "player receives damage from collisions"
        55 = "determines whether acid, mana pools, toxic air etc are active"
        56 = "character is being affected by hotspot?"
        57 = "hotspot affects AI's"
        59 = "1 = generator is currently disabled"
        60 = "player is accepting private messages"
        62 = "item opens any locked object"
        63 = "item has infinite uses"
        65 = "1 =  ignore magic resistance"
        66 = "1 = ignore banes"
        68 = "1 =  does not require spell components to cast magic"
        69 = "1 = sellable, 0 = 'This item cannot be sold'"
        71 = "1 = do not draw the object"
        75 = "house hook visibility - @house hooks on/off"
        76 = "mansions"
        77 = "house hooks enabled - @house hooks on/off"
        79 = "npc/creature will accept *any* items given to it, regardless of emoteTable"
        80 = "character ignores all portal restrictions"
        81 = "anything that requires the use of a backpack slot, that's not a backpack"
        82 = "don't turn or move when handing an item to player"
        83 = "NPC Looks Like Object (Description, no stat panel)"
        85 = "This item can only be wielded by <player>"
        86 = "1 = chest generates new items on close"
        88 = "Portal displays APPRAISAL_PORTAL_DESTINATION_STRING"
        91 = "1 = item cannot be sold, leather applied"
        92 = "1 = anyone can edit the inscription"
        93 = "1 = player is in limbo due to admin action"
        94 = "This item can only be activated by <player>"
        98 = "1 = player/object does not take any damage"
        99 = "1 = Ivoryable."
        100 = "1 = item can be dyed"
        101 = "1 = creature/corpse can generate a rare"
        102 = "1 = corpse generated a rare"
        103 = "1 =  immune to life/creature magic (Direct Cast)"
        104 = "related to ACTD_PREORDER_RECEIVED_ITEMS_BOOL"
        106 = "set after first entering world to provide benefits on login only once?"
        107 = "unable to cast any recall spell"
        108 = "1 = crystals/pearls, 0 = kits/keys/weapons/armor/etc"
        109 = "received Throne of Destiny preorder items "
        110 = "character is in @afk mode"
        111 = "character is chat gagged"
        112 = "1 = from aetheria surges / cloaks?"
        113 = "character cannot speak in allegiance chat"
        117 = "1 = all items are cleared from the chest when closed"
        122 = "barber UI / actions are active"
        123 = "property on armor for layering tools?"
        125 = "related to no-log dungeons/landblocks"
        126 = "olthoi player PK status"
        127 = "account is at least 15 days old (housing / pk olthoi island restriction)"
        128 = "PK Olthoi drop top tier loot when they die, but not if they have vitae."
        129 = "player is olthoi, can only speak in othoi channels"
        130 = "autowield left-hand "
    }
}

class acString:acBase {
    [string]$Value

    acString(): base("acString")  { }
    
    [string] ToString() { return ("{0}: {1}" -f $this.Name, $this.value) }
    
    static [acString] Create([int]$Id, [string]$value) { return ([acString]@{Id = $Id; Value = $value}) }
    
    hidden static [hashtable]$nameHT = @{1 = "NAME_STRING"
        2 = "TITLE_STRING"
        3 = "SEX_STRING"
        4 = "HERITAGE_GROUP_STRING"
        5 = "TEMPLATE_STRING"
        6 = "ATTACKERS_NAME_STRING"
        7 = "INSCRIPTION_STRING"
        8 = "SCRIBE_NAME_STRING"
        9 = "VENDORS_NAME_STRING"
        10 = "FELLOWSHIP_STRING"
        11 = "MONARCHS_NAME_STRING"
        12 = "LOCK_CODE_STRING"
        13 = "KEY_CODE_STRING"
        14 = "USE_STRING"
        15 = "SHORT_DESC_STRING"
        16 = "LONG_DESC_STRING"
        17 = "ACTIVATION_TALK_STRING"
        18 = "USE_MESSAGE_STRING"
        19 = "ITEM_HERITAGE_GROUP_RESTRICTION_STRING"
        20 = "PLURAL_NAME_STRING"
        21 = "MONARCHS_TITLE_STRING"
        22 = "ACTIVATION_FAILURE_STRING"
        23 = "SCRIBE_ACCOUNT_STRING"
        24 = "TOWN_NAME_STRING"
        25 = "CRAFTSMAN_NAME_STRING"
        26 = "USE_PK_SERVER_ERROR_STRING"
        27 = "SCORE_CACHED_TEXT_STRING"
        28 = "SCORE_DEFAULT_ENTRY_FORMAT_STRING"
        29 = "SCORE_FIRST_ENTRY_FORMAT_STRING"
        30 = "SCORE_LAST_ENTRY_FORMAT_STRING"
        31 = "SCORE_ONLY_ENTRY_FORMAT_STRING"
        32 = "SCORE_NO_ENTRY_STRING"
        33 = "QUEST_STRING"
        34 = "GENERATOR_EVENT_STRING"
        35 = "PATRONS_TITLE_STRING"
        36 = "HOUSE_OWNER_NAME_STRING"
        37 = "QUEST_RESTRICTION_STRING"
        38 = "APPRAISAL_PORTAL_DESTINATION_STRING"
        39 = "TINKER_NAME_STRING"
        40 = "IMBUER_NAME_STRING"
        41 = "HOUSE_OWNER_ACCOUNT_STRING"
        42 = "DISPLAY_NAME_STRING"
        43 = "DATE_OF_BIRTH_STRING"
        44 = "THIRD_PARTY_API_STRING"
        45 = "KILL_QUEST_STRING"
        46 = "AFK_STRING"
        47 = "ALLEGIANCE_NAME_STRING"
        48 = "AUGMENTATION_ADD_QUEST_STRING"
        49 = "KILL_QUEST_2_STRING"
        50 = "KILL_QUEST_3_STRING"
        51 = "USE_SENDS_SIGNAL_STRING"
        52 = "GEAR_PLATING_NAME_STRING"
    }

    hidden static [hashtable]$descriptionHt = @{1 = "Object name"
        2 = "Player titles on ID panel"
        3 = "Male/Female"
        4 = "Sho, Aluvian, Gharu'ndim, Aun, Viamontian, Empyrean, Hea, Haebrous"
        5 = "Like a title, but for npcs / creatures / objects"
        7 = "Inscription text"
        8 = "Author name of the inscription"
        10 = "Current fellowship name"
        11 = "Current monarchs name"
        12 = "string on objects that match the KEY_CODE on key that unlocks"
        13 = "string on key that match the LOCK_CODE on object to be unlocked"
        14 = "Use instructions on ID panel"
        15 = "description on ID panel"
        16 = "description on ID panel"
        17 = "Messages sent when activating something (trap/pressureplate)"
        18 = "Messages sent when using an object (pk/npk altar, lifestone)"
        19 = "Racial wield requirements (Aluvian/Gharu'ndim/Sho)"
        20 = "Plural name for stackable items"
        21 = "Monarchs Rank Title"
        22 = "Attempted to activate / use something still on timer"
        23 = "SCRIBE_NAME_STRING account name"
        24 = "Town Names, Outpost Names, Casino Names on objects"
        25 = "This item can only be wielded by X -- slayer imbues etc"
        26 = "message received when using pk/npk device on pk server"
        27 = "for unused scorebook"
        28 = "for unused scorebook"
        29 = "for unused scorebook"
        30 = "for unused scorebook"
        31 = "for unused scorebook"
        32 = "for unused scorebook"
        33 = "quest flag string"
        34 = "event trigger strings"
        35 = "Patrons Rank Title"
        36 = "name displayed on house crystal"
        37 = "quest flag string"
        38 = "Displays portal destination string on portal ID panel"
        39 = "Last tinkered by X"
        40 = "imbued by X"
        41 = "related to 36"
        43 = "character date of birth on ID panel"
        44 = "unused client plugin system"
        46 = "String set by @afk msg stringhere"
        47 = "Allegiance name"
        51 = "sends signal string OnUse (similar to LocalSignal_EmoteType)"
    }
}

class weenie {
    hidden [string]$original
    [acBool[]]$bools
    $dids
    $floats
    $instanceIds
    $ints
    $int64s
    [acString[]]$strings
    
    weenie() {}
    weenie([string]$jsonText) { $this.LoadFromJson($jsonText) }

    [void] LoadFromJson([string]$jsonText) {
        $this.original = $jsonText
        $data = ConvertFrom-Json $jsonText
        $this.bools = $data.boolStats | ForEach-Object { [acBool]::Create($_.key, $_.value) }
        $this.strings = $data.stringStats | ForEach-Object { [acString]::Create($_.key, $_.value) }
    }
    [void] Reset() { $this.LoadFromJson($this.original) }
    [string] GenerateJson() {
        $data = $this.original | ConvertFrom-Json

        $data.boolStats = $this.bools | Select-Object @{name="key"; expression = {$_.Id}}, @{name="value"; expression = {[int]$_.value}}
        $data.stringStats = $this.strings | Select-Object @{name="key"; expression = {$_.Id}}, @{name="value"; expression = {$_.value}}

        return ($data | ConvertTo-Json -Depth 5)
    }
}