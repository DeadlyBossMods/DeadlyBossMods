DBM_GUI_Translations = {}

local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TabCategory_Options 	= "General Options"
L.TabCategory_WOTLK 	= "Wrath of the Lich King"
L.TabCategory_BC 	= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW Classic Bosses"
L.TabCategory_OTHER     = "Other Boss Mods"

L.BossModLoaded 	= "%s statistics"
L.BossModLoad_now 	= [[This Boss Mod is not loaded. 
It will be loaded when you enter the instance. 
You can also click the button to load the mod manually.]]

L.PosX = 'Position X'
L.PosY = 'Position Y'

L.MoveMe 		= 'move me'
L.Button_OK 		= 'OK'
L.Button_Cancel 	= 'Cancel'
L.Button_LoadMod 	= 'Load AddOn'
L.Mod_Enabled		= "Enable boss mod"
L.Mod_EnableAnnounce	= "Announce to raid"
L.Reset 		= "reset"

L.Enable  		= "enable"
L.Disable		= "disable"

L.NoSound		= "No Sound"

-- Tab: Boss Statistics
L.BossStatistics	= "Boss Statistics"
L.Statistic_Kills	= "Kills:"
L.Statistic_Wipes	= "Wipes:"
L.Statistic_BestKill	= "Best kill:"
L.Statistic_Heroic	= "heroic"

-- Tab: General Options
L.General 		= "General Options"
L.EnableDBM 		= "Enable DBM"
L.EnableStatus 		= "Reply to 'status' whispers"
L.AutoRespond 		= "Enable auto-respond while fighting"

L.PizzaTimer_Headline 	= 'Create a "Pizza Timer"'
L.PizzaTimer_Title	= 'Name (e.g. "Pizza!")'
L.PizzaTimer_Hours 	= "Hours"
L.PizzaTimer_Mins 	= "Min"
L.PizzaTimer_Secs 	= "Sec"
L.PizzaTimer_ButtonStart = "Start Timer"
L.PizzaTimer_BroadCast	= "Broadcast to Raid"

-- Tab: Raidwarning
L.Tab_RaidWarning 	= "Raid Warnings"
L.RaidWarnColors 	= "Raid Warning Colors"
L.RaidWarnColor_1 	= "Color 1"
L.RaidWarnColor_2 	= "Color 2"
L.RaidWarnColor_3 	= "Color 3"
L.RaidWarnColor_4 	= "Color 4"
L.InfoRaidWarning	= [[You can specify the position and colors of the raid warning frame. 
This frame is used for messages like "Player X is afflicted by Y" messages]]
L.ColorResetted 	= "The Color Setting of this field has been resetted"
L.ShowWarningsInChat 	= "Show warnings in chatframe"
L.ShowFakedRaidWarnings = "Show warnings as faked Raid Warning messages"
L.WarningIconLeft 	= "Show icon on left side"
L.WarningIconRight 	= "Show icon on right side"
L.RaidWarnMessage 	= "Thanks for using DeadlyBossMods"
L.BarWhileMove 		= "Raidwarn movable"
L.RaidWarnSound		= "Play Sound on RaidWarning"

-- Tab: Barsetup
L.BarSetup   = "Bar Style"
L.BarTexture = "Bar Texture"

L.Slider_BarOffSetX 	= "OffSet X"
L.Slider_BarOffSetY 	= "OffSet Y"
L.Slider_BarWidth 	= "Bar width"
L.Slider_BarScale 	= "Bar scale"
L.AreaTitle_BarSetup 	= "General Bar Options"
L.AreaTitle_BarSetupSmall = "Small Bar Options"
L.AreaTitle_BarSetupHuge = "Huge Bar Options"
L.BarIconLeft 		= "Left Icon"
L.BarIconRight 		= "Right Icon"
L.EnableHugeBar 	= "Enable Huge Bar (Bar 2)"

-- BossMod studio
L.TabCategory_BossModStudio = "Boss Mod Studio"
L.TabCategory_Triggers = "Triggers and Events"
L.AreaHead_CreateBossMod = "Main Informations of this new BossMod"
L.BossName = "Name of the BossMod - like 'Hogger'"
L.BossID = "Creature ID"
L.BossLookup = "Take ID from Target"

L.AreaHead_Pull = "Pull / Combat Detection"
L.CombatFromYell = "Combat starts with a Yell"
L.CombatAutoDetect = "Automatic Combat Detection"
L.BossPullYell = "what does the Boss yell on pull"
L.BossEnrages = "boss enrage"
L.BossEnrageBar = "Show Enrage Bar"
L.BossEnrageAnnounce = "Announce Enrage to Raid"

L.Min = "Min"
L.Sec = "Sec"

L.AreaHead_TriggerCreate = "Create an Boss Event Trigger"
L.Describe_TriggerCreate = [[Triggers can be created to handle events in bossfights. If the Boss yell some stuff or use one of his abilitys you need to catch and use them. As an example, the boss gains Shieldwall and you want to start a Bar when this occur, you simply have to choose BossBuffs or Debuffs and type in an Name for this event like "Shieldwall"]]

L.Trigger_Typ = "Event that shall be triggered"
L.Trigger_Name = "Name of this Trigger (a description)"
L.Trigger_Typ_Spell = "Spell or Style"
L.Trigger_Typ_Buff = "Buff or Debuff"
L.Trigger_Typ_Yell = "Yell or Emote"
L.Trigger_Typ_Time = "Time based"
L.Trigger_Typ_Hp = "HitPoint Based"
L.Trigger_Create_Bttn = "create trigger"
L.Trigger_Delete_Bttn = "delete trigger"

L.EventYellText = "Yell/Say/Emote that shall call the Event"
L.EventTimeBased = "Trigger after X seconds"
L.EventHpBased = "Trigger on X percent HitPoints"
L.EventSpellID = "Spell ID"
L.EventAnnounce = "Announce"
L.EventAnnounceText = "Message to announce"
L.EventSpecialWarn = "Show Special Warning"
L.EventSpecialWarn_OnlyMe = "only if affects me"
L.EventStartBar = "Start a timer Bar"
L.EventWarnEnd = "Show warning before timer ends"
L.EventWarnMsg = "Warning Message"
L.EventSetIcon = "Set Icon on Target (on yells %t of text)"


