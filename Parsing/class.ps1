class acBool {
    [int]$Id
    [string]$Name
    [string]$Description
    [bool]$Value
}


class weenie {
    [acBool[]]$bools
    $dids
    $floats
    $instanceIds
    $ints
    $int64s
    $strings
    
    weenie() {

    }
}

class acUtility {
    static [acBool[]] ListBool(){
       return @(@{ID="1"; Name = "STUCK_BOOL"; Description = "Can an object be picked up, if it can't this is false"}
            @{ID="2"; Name = "OPEN_BOOL"; Description = "determines whether a chest/door is open "}
            @{ID="3"; Name = "LOCKED_BOOL"; Description = "determines whether a chest/door is locked"}
            @{ID="4"; Name = "ROT_PROOF_BOOL"}
            @{ID="5"; Name = "ALLEGIANCE_UPDATE_REQUEST_BOOL"}
            @{ID="6"; Name = "AI_USES_MANA_BOOL"; Description = "determines whether a creatures consumes mana on spellcast"}
            @{ID="7"; Name = "AI_USE_HUMAN_MAGIC_ANIMATIONS_BOOL"; Description = "creatures use human spellcasting animations"}
            @{ID="8"; Name = "ALLOW_GIVE_BOOL"; Description = "npc/creature accepts items being handed to it"}
            @{ID="9"; Name = "CURRENTLY_ATTACKING_BOOL"; Description = "creature is currently attacking"}
            @{ID="10"; Name = "ATTACKER_AI_BOOL"}
            @{ID="11"; Name = "IGNORE_COLLISIONS_BOOL"}
            @{ID="12"; Name = "REPORT_COLLISIONS_BOOL"}
            @{ID="13"; Name = "ETHEREAL_BOOL"; Description = "determines whether the object allows players models to pass through it"}
            @{ID="14"; Name = "GRAVITY_STATUS_BOOL"; Description = "determines whether an object is affected by gravity"}
            @{ID="15"; Name = "LIGHTS_STATUS_BOOL"; Description = "determines whether the object emits light on to nearby objects/terrain"}
            @{ID="16"; Name = "SCRIPTED_COLLISION_BOOL"; Description = "related to projectile collisions"}
            @{ID="17"; Name = "INELASTIC_BOOL"; Description = "related to projectiles"}
            @{ID="18"; Name = "VISIBILITY_BOOL"; Description = "generator/trap/pressureplate visibility"}
            @{ID="19"; Name = "ATTACKABLE_BOOL"; Description = "determines whether an npc/creature is attackable"}
            @{ID="20"; Name = "SAFE_SPELL_COMPONENTS_BOOL"}
            @{ID="21"; Name = "ADVOCATE_STATE_BOOL"}
            @{ID="22"; Name = "INSCRIBABLE_BOOL"; Description = "1 = allow Inscription"}
            @{ID="23"; Name = "DESTROY_ON_SELL_BOOL"; Description = "1 = item does not appear in vendor inventory when sold"}
            @{ID="24"; Name = "UI_HIDDEN_BOOL"; Description = "determines whether an item can be selected, 0 = yes, 1 = no"}
            @{ID="25"; Name = "IGNORE_HOUSE_BARRIERS_BOOL"; Description = "1 = character model can pass through housing barrier"}
            @{ID="26"; Name = "HIDDEN_ADMIN_BOOL"}
            @{ID="27"; Name = "PK_WOUNDER_BOOL"; Description = "recently attacked / was attacked ?"}
            @{ID="28"; Name = "PK_KILLER_BOOL"; Description = "player killer status / recently killed a pk?"}
            @{ID="29"; Name = "NO_CORPSE_BOOL"; Description = "only appears if set to 1, creature does not leave a corpse"}
            @{ID="30"; Name = "UNDER_LIFESTONE_PROTECTION_BOOL"; Description = "lifestone protection spell is active"}
            @{ID="31"; Name = "ITEM_MANA_UPDATE_PENDING_BOOL"}
            @{ID="32"; Name = "GENERATOR_STATUS_BOOL"}
            @{ID="33"; Name = "RESET_MESSAGE_PENDING_BOOL"; Description = "doors/chests"}
            @{ID="34"; Name = "DEFAULT_OPEN_BOOL"; Description = "doors/chests, always set to 0 if it appears"}
            @{ID="35"; Name = "DEFAULT_LOCKED_BOOL"; Description = "object is locked by default, doors/chests etc"}
            @{ID="36"; Name = "DEFAULT_ON_BOOL"}
            @{ID="37"; Name = "OPEN_FOR_BUSINESS_BOOL"}
            @{ID="38"; Name = "IS_FROZEN_BOOL"}
            @{ID="39"; Name = "DEAL_MAGICAL_ITEMS_BOOL"; Description = "sells buffs"}
            @{ID="40"; Name = "LOGOFF_IM_DEAD_BOOL"}
            @{ID="41"; Name = "REPORT_COLLISIONS_AS_ENVIRONMENT_BOOL"}
            @{ID="42"; Name = "ALLOW_EDGE_SLIDE_BOOL"; Description = "1 = character will 'slide' along object if running against object at angle"}
            @{ID="43"; Name = "ADVOCATE_QUEST_BOOL"; Description = "player has completed the advocate quest"}
            @{ID="44"; Name = "IS_ADMIN_BOOL"; Description = "player is an administrator"}
            @{ID="45"; Name = "IS_ARCH_BOOL"; Description = "Architect, Archon?"}
            @{ID="46"; Name = "IS_SENTINEL_BOOL"; Description = "player is a sentinel"}
            @{ID="47"; Name = "IS_ADVOCATE_BOOL"; Description = "player is an advocate"}
            @{ID="48"; Name = "CURRENTLY_POWERING_UP_BOOL"}
            @{ID="49"; Name = "GENERATOR_ENTERED_WORLD_BOOL"; Description = "generator has spawned on server start"}
            @{ID="50"; Name = "NEVER_FAIL_CASTING_BOOL"; Description = "npcs / mobs never fail to spellcast"}
            @{ID="51"; Name = "VENDOR_SERVICE_BOOL"}
            @{ID="52"; Name = "AI_IMMOBILE_BOOL"; Description = "creatures that don't move (npcs, mobs, mobs disguised as objects)"}
            @{ID="53"; Name = "DAMAGED_BY_COLLISIONS_BOOL"; Description = "player receives damage from collisions"}
            @{ID="54"; Name = "IS_DYNAMIC_BOOL"}
            @{ID="55"; Name = "IS_HOT_BOOL"; Description = "determines whether acid, mana pools, toxic air etc are active"}
            @{ID="56"; Name = "IS_AFFECTING_BOOL"; Description = "character is being affected by hotspot?"}
            @{ID="57"; Name = "AFFECTS_AIS_BOOL"; Description = "hotspot affects AI's"}
            @{ID="58"; Name = "SPELL_QUEUE_ACTIVE_BOOL"}
            @{ID="59"; Name = "GENERATOR_DISABLED_BOOL"; Description = "1 = generator is currently disabled"}
            @{ID="60"; Name = "IS_ACCEPTING_TELLS_BOOL"; Description = "player is accepting private messages"}
            @{ID="61"; Name = "LOGGING_CHANNEL_BOOL"}
            @{ID="62"; Name = "OPENS_ANY_LOCK_BOOL"; Description = "item opens any locked object"}
            @{ID="63"; Name = "UNLIMITED_USE_BOOL"; Description = "item has infinite uses"}
            @{ID="64"; Name = "GENERATED_TREASURE_ITEM_BOOL"}
            @{ID="65"; Name = "IGNORE_MAGIC_RESIST_BOOL"; Description = "1 =  ignore magic resistance"}
            @{ID="66"; Name = "IGNORE_MAGIC_ARMOR_BOOL"; Description = "1 = ignore banes"}
            @{ID="67"; Name = "AI_ALLOW_TRADE_BOOL"}
            @{ID="68"; Name = "SPELL_COMPONENTS_REQUIRED_BOOL"; Description = "1 =  does not require spell components to cast magic"}
            @{ID="69"; Name = "IS_SELLABLE_BOOL"; Description = "1 = sellable, 0 = 'This item cannot be sold'"}
            @{ID="70"; Name = "IGNORE_SHIELDS_BY_SKILL_BOOL"}
            @{ID="71"; Name = "NODRAW_BOOL"; Description = "1 = do not draw the object"}
            @{ID="72"; Name = "ACTIVATION_UNTARGETED_BOOL"}
            @{ID="73"; Name = "HOUSE_HAS_GOTTEN_PRIORITY_BOOT_POS_BOOL"}
            @{ID="74"; Name = "GENERATOR_AUTOMATIC_DESTRUCTION_BOOL"}
            @{ID="75"; Name = "HOUSE_HOOKS_VISIBLE_BOOL"; Description = "house hook visibility - @house hooks on/off"}
            @{ID="76"; Name = "HOUSE_REQUIRES_MONARCH_BOOL"; Description = "mansions"}
            @{ID="77"; Name = "HOUSE_HOOKS_ENABLED_BOOL"; Description = "house hooks enabled - @house hooks on/off"}
            @{ID="78"; Name = "HOUSE_NOTIFIED_HUD_OF_HOOK_COUNT_BOOL"}
            @{ID="79"; Name = "AI_ACCEPT_EVERYTHING_BOOL"; Description = "npc/creature will accept *any* items given to it, regardless of emoteTable"}
            @{ID="80"; Name = "IGNORE_PORTAL_RESTRICTIONS_BOOL"; Description = "character ignores all portal restrictions"}
            @{ID="81"; Name = "REQUIRES_BACKPACK_SLOT_BOOL"; Description = "anything that requires the use of a backpack slot, that's not a backpack"}
            @{ID="82"; Name = "DONT_TURN_OR_MOVE_WHEN_GIVING_BOOL"; Description = "don't turn or move when handing an item to player"}
            @{ID="83"; Name = "NPC_LOOKS_LIKE_OBJECT_BOOL"; Description = "NPC Looks Like Object (Description, no stat panel)"}
            @{ID="84"; Name = "IGNORE_CLO_ICONS_BOOL"}
            @{ID="85"; Name = "APPRAISAL_HAS_ALLOWED_WIELDER_BOOL"; Description = "This item can only be wielded by <player>"}
            @{ID="86"; Name = "CHEST_REGEN_ON_CLOSE_BOOL"; Description = "1 = chest generates new items on close"}
            @{ID="87"; Name = "LOGOFF_IN_MINIGAME_BOOL"}
            @{ID="88"; Name = "PORTAL_SHOW_DESTINATION_BOOL"; Description = "Portal displays APPRAISAL_PORTAL_DESTINATION_STRING"}
            @{ID="89"; Name = "PORTAL_IGNORES_PK_ATTACK_TIMER_BOOL"}
            @{ID="90"; Name = "NPC_INTERACTS_SILENTLY_BOOL"}
            @{ID="91"; Name = "RETAINED_BOOL"; Description = "1 = item cannot be sold, leather applied"}
            @{ID="92"; Name = "IGNORE_AUTHOR_BOOL"; Description = "1 = anyone can edit the inscription"}
            @{ID="93"; Name = "LIMBO_BOOL"; Description = "1 = player is in limbo due to admin action"}
            @{ID="94"; Name = "APPRAISAL_HAS_ALLOWED_ACTIVATOR_BOOL"; Description = "This item can only be activated by <player>"}
            @{ID="95"; Name = "EXISTED_BEFORE_ALLEGIANCE_XP_CHANGES_BOOL"}
            @{ID="96"; Name = "IS_DEAF_BOOL"}
            @{ID="97"; Name = "IS_PSR_BOOL"}
            @{ID="98"; Name = "INVINCIBLE_BOOL"; Description = "1 = player/object does not take any damage"}
            @{ID="99"; Name = "IVORYABLE_BOOL"; Description = "1 = Ivoryable."}
            @{ID="100"; Name = "DYABLE_BOOL"; Description = "1 = item can be dyed"}
            @{ID="101"; Name = "CAN_GENERATE_RARE_BOOL"; Description = "1 = creature/corpse can generate a rare"}
            @{ID="102"; Name = "CORPSE_GENERATED_RARE_BOOL"; Description = "1 = corpse generated a rare"}
            @{ID="103"; Name = "NON_PROJECTILE_MAGIC_IMMUNE_BOOL"; Description = "1 =  immune to life/creature magic (Direct Cast)"}
            @{ID="104"; Name = "ACTD_RECEIVED_ITEMS_BOOL"; Description = "related to ACTD_PREORDER_RECEIVED_ITEMS_BOOL"}
            @{ID="105"; Name = "UNKNOWN__GUESSEDNAME"}
            @{ID="106"; Name = "FIRST_ENTER_WORLD_DONE_BOOL"; Description = "set after first entering world to provide benefits on login only once?"}
            @{ID="107"; Name = "RECALLS_DISABLED_BOOL"; Description = "unable to cast any recall spell"}
            @{ID="108"; Name = "RARE_USES_TIMER_BOOL"; Description = "1 = crystals/pearls, 0 = kits/keys/weapons/armor/etc"}
            @{ID="109"; Name = "ACTD_PREORDER_RECEIVED_ITEMS_BOOL"; Description = "received Throne of Destiny preorder items "}
            @{ID="110"; Name = "AFK_BOOL"; Description = "character is in @afk mode"}
            @{ID="111"; Name = "IS_GAGGED_BOOL"; Description = "character is chat gagged"}
            @{ID="112"; Name = "PROC_SPELL_SELF_TARGETED_BOOL"; Description = "1 = from aetheria surges / cloaks?"}
            @{ID="113"; Name = "IS_ALLEGIANCE_GAGGED_BOOL"; Description = "character cannot speak in allegiance chat"}
            @{ID="114"; Name = "EQUIPMENT_SET_TRIGGER_PIECE_BOOL"}
            @{ID="115"; Name = "UNINSCRIBE_BOOL"}
            @{ID="116"; Name = "WIELD_ON_USE_BOOL"}
            @{ID="117"; Name = "CHEST_CLEARED_WHEN_CLOSED_BOOL"; Description = "1 = all items are cleared from the chest when closed"}
            @{ID="118"; Name = "NEVER_ATTACK_BOOL"}
            @{ID="119"; Name = "SUPPRESS_GENERATE_EFFECT_BOOL"}
            @{ID="120"; Name = "TREASURE_CORPSE_BOOL"}
            @{ID="121"; Name = "EQUIPMENT_SET_ADD_LEVEL_BOOL"}
            @{ID="122"; Name = "BARBER_ACTIVE_BOOL"; Description = "barber UI / actions are active"}
            @{ID="123"; Name = "TOP_LAYER_PRIORITY_BOOL"; Description = "property on armor for layering tools?"}
            @{ID="124"; Name = "NO_HELD_ITEM_SHOWN_BOOL"}
            @{ID="125"; Name = "LOGIN_AT_LIFESTONE_BOOL"; Description = "related to no-log dungeons/landblocks"}
            @{ID="126"; Name = "OLTHOI_PK_BOOL"; Description = "olthoi player PK status"}
            @{ID="127"; Name = "ACCOUNT_15_DAYS_BOOL"; Description = "account is at least 15 days old (housing / pk olthoi island restriction)"}
            @{ID="128"; Name = "HAD_NO_VITAE_BOOL"; Description = "PK Olthoi drop top tier loot when they die, but not if they have vitae."}
            @{ID="129"; Name = "NO_OLTHOI_TALK_BOOL"; Description = "player is olthoi, can only speak in othoi channels"}
            @{ID="130"; Name = "AUTOWIELD_LEFT_BOOL"; Description = "autowield left-hand "}) |
        ForEach-Object { [acBool]$_ }
    }
    static [acBool] CreateBool([int]$id, [bool]$value) {
        return [acUtility]::ListBool() | Where-Object Id -eq $id | ForEach-Object { $_.Value = $value; $_ }
    }
}