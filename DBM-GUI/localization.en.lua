DBM_GUI_Translations = {}

local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Translated by "
L.TranslationBy 			= nil -- your name here, localizers!
L.Website					= "Visit our discussion and support forums at |cFF73C2FBwww.deadlybossmods.com|r. Follow main dev on twitter @MysticalOS"
L.WebsiteButton				= "Forums"

L.OTabBosses	= "Bosses"
L.OTabOptions	= GAMEOPTIONS_MENU

L.TabCategory_Options	 	= "General Options"
L.TabCategory_WOD	 		= EXPANSION_NAME5
L.TabCategory_MOP	 		= EXPANSION_NAME4
L.TabCategory_CATA	 		= EXPANSION_NAME3
L.TabCategory_WOTLK 		= EXPANSION_NAME2
L.TabCategory_BC 			= EXPANSION_NAME1
L.TabCategory_CLASSIC		= EXPANSION_NAME0
L.TabCategory_PVP 			= PVP
L.TabCategory_OTHER    		= "Other Boss Mods"

L.BossModLoaded 			= "%s statistics"
L.BossModLoad_now 			= [[This boss mod is not loaded. 
It will be loaded when you enter the instance. 
You can also click the button to load the mod manually.]]

L.PosX						= 'Position X'
L.PosY						= 'Position Y'

L.MoveMe 					= 'Move me'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Cancel'
L.Button_LoadMod 			= 'Load AddOn'
L.Mod_Enabled				= "Enable boss mod"
L.Mod_Reset					= "Load default options"
L.Reset 					= "Reset"

L.Enable  					= ENABLE
L.Disable					= DISABLE

L.NoSound					= "No sound"

L.IconsInUse				= "Icons used by this mod"

-- Tab: Boss Statistics
L.BossStatistics			= "Boss Statistics"
L.Statistic_Kills			= "Victories:"
L.Statistic_Wipes			= "Wipes:"
L.Statistic_Incompletes		= "Incompletes:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Best Victory:"

-- Tab: General Core Options
L.General 					= "General DBM Core Options"
L.EnableDBM 				= "Enable DBM"
L.EnableMiniMapIcon			= "Show minimap button"
L.UseMasterVolume			= "Use Master audio channel to play DBM alert sounds"
L.Latency_Text				= "Set max latency sync threshold: %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "General DBM Timer Options"
L.SKT_Enabled				= "Always show record victory timer (Overrides boss-specific option)"
L.CRT_Enabled				= "Show timer for next combat ressurection charge (6.x difficulties only)"
L.ChallengeTimerOptions		= "Set option for challenge mode best clear timer"
L.ChallengeTimerPersonal	= "Personal"
L.ChallengeTimerGuild		= GUILD
L.ChallengeTimerRealm		= "Realm"

L.ModelOptions				= "3D Model Viewer Options"
L.EnableModels				= "Enable 3D models in boss options"
L.ModelSoundOptions			= "Set sound option for model viewer"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.Button_RangeFrame			= "Show/hide range frame"
L.Button_InfoFrame			= "Show/hide info frame"
L.Button_TestBars			= "Start test bars"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Raid Warnings"
L.RaidWarning_Header		= "Raid Warning Options"
L.RaidWarnColors 			= "Raid Warning Colors"
L.RaidWarnColor_1 			= "Color 1"
L.RaidWarnColor_2 			= "Color 2"
L.RaidWarnColor_3		 	= "Color 3"
L.RaidWarnColor_4 			= "Color 4"
L.InfoRaidWarning			= [[You can specify the position and colors of the raid warning frame. 
This frame is used for messages like "Player X is affected by Y".]]
L.ColorResetted 			= "The color settings of this field have been reset."
L.ShowWarningsInChat 		= "Show warnings in chat frame"
L.ShowFakedRaidWarnings 	= "Show warnings as faked raid warning messages"
L.WarningIconLeft 			= "Show icon on left side"
L.WarningIconRight 			= "Show icon on right side"
L.WarningIconChat 			= "Show icons in chat frame"
L.Warn_FontType				= "Select font"
L.Warn_FontStyle			= "Font flags"
L.Warn_FontShadow			= "Shadow"
L.Warn_FontSize				= "Font size: %d"
L.Warn_Duration				= "Warning duration: %d sec"
L.None						= "None"
L.Outline					= "Outline"
L.ThickOutline				= "Thick outline"
L.MonochromeOutline			= "Monochrome outline"
L.MonochromeThickOutline	= "Monochrome thick outline"
L.RaidWarnSound				= "Play sound on raid warning"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "General Messages"
L.CoreMessages				= "Core Message Options"
L.ShowLoadMessage 			= "Show mod loading messages in chat frame"
L.ShowPizzaMessage 			= "Show timer broadcast messages in chat frame"
L.ShowCombatLogMessage 		= "Show DBM combat logging message in chat frame"
L.ShowTranscriptorMessage	= "Show DBM Transcriptor logging message in chat frame"
L.ShowAllVersions	 		= "Show boss mod versions for all group members in chat frame"
L.CombatMessages			= "Combat Message Options"
L.ShowEngageMessage 		= "Show engage messages in chat frame"
L.ShowKillMessage 			= "Show kill messages in chat frame"
L.ShowWipeMessage 			= "Show wipe messages in chat frame"
L.ShowGuildMessages 		= "Show show guild engage/kill/wipe message in chat frame"
L.ShowRecoveryMessage 		= "Show timer recovery messages in chat frame"
L.WhisperMessages			= "Whisper Message Options"
L.AutoRespond 				= "Auto-respond to whispers while fighting"
L.EnableStatus 				= "Reply to 'status' whispers"
L.WhisperStats 				= "Include kill/wipe stats in whisper responses"

-- Tab: Barsetup
L.BarSetup					= "Bar Setup"
L.BarTexture				= "Bar texture"
L.BarStyle					= "Bar style"
L.BarDBM					= "DBM"
L.BarBigWigs				= "BigWigs (no animation)"
L.BarStartColor				= "Start color"
L.BarEndColor 				= "End color"
L.Bar_Font					= "Font used for bars"
L.Bar_FontSize				= "Font size: %d"
L.Bar_Height				= "Bar Height: %d"
L.Slider_BarOffSetX 		= "Offset X: %d"
L.Slider_BarOffSetY 		= "Offset Y: %d"
L.Slider_BarWidth 			= "Bar width: %d"
L.Slider_BarScale 			= "Bar scale: %0.2f"
L.AreaTitle_BarSetup		= "General Bar Options"
L.AreaTitle_BarSetupSmall 	= "Small Bar Options"
L.AreaTitle_BarSetupHuge	= "Huge Bar Options"
L.EnableHugeBar 			= "Enable huge bar (aka Bar 2)"
L.BarIconLeft 				= "Left icon"
L.BarIconRight 				= "Right icon"
L.ExpandUpwards				= "Expand upward"
L.FillUpBars				= "Fill up"
L.ClickThrough				= "Disable mouse events (click through)"
L.Bar_Decimal				= "Decimal shows below time: %d"
L.Bar_DBMOnly				= "Below options only works with \"DBM\" bar style."
L.Bar_EnlargeTime			= "Bar enlarges below time: %d"
L.Bar_EnlargePercent		= "Bar enlarges below percent: %0.1f%%"
L.BarSpark					= "Bar spark"
L.BarFlash					= "Flash bar about to expire"
L.BarSort					= "Sort by remaining time"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Special Warnings"
L.Area_SpecWarn				= "Special Warning Options"
L.SpecWarn_Enabled			= "Show special warnings for boss abilities"
L.SpecWarn_ClassColor		= "Use class coloring for special warnings"
L.ShowSWarningsInChat 		= "Show special warnings in chat frame"
L.SpecWarn_FlashFrame		= "Show screen flash for special warnings"
L.SpecWarn_FlashFrameRepeat	= "Repeat %d times (if enabled)"
L.SpecWarn_Font				= "Font used for special warnings"
L.SpecWarn_FontSize			= "Font size: %d"
L.SpecWarn_FontColor		= "Font color"
L.SpecWarn_FontType			= "Select font"
L.SpecWarn_FlashRepeat		= "Repeat Flash"
L.SpecWarn_FlashColor		= "Flash color %d"
L.SpecWarn_FlashDur			= "Flash duration: %0.1f"
L.SpecWarn_FlashAlpha		= "Flash alpha: %0.1f"
L.SpecWarn_DemoButton		= "Show example"
L.SpecWarn_MoveMe			= "Set position"
L.SpecWarn_ResetMe			= "Reset to defaults"
L.SpecialWarnSound			= "Set default sound for special warnings affecting you or your role"
L.SpecialWarnSound2			= "Set default sound for special warnings affecting everyone"
L.SpecialWarnSound3			= "Set default sound for VERY important special warnings"
L.SpecialWarnSound4			= "Set default sound for run away special warnings"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Spoken Alerts"
L.Area_VoiceSelection		= "Voice Selections"
L.CountdownVoice			= "Set primary voice for count sounds"
L.CountdownVoice2			= "Set secondary voice for count sounds"
L.CountdownVoice3			= "Set tertiary voice for count sounds"
L.VoicePackChoice			= "Set voice pack for spoken alerts"
L.Area_CountdownOptions		= "Countdown Options"
L.ShowCountdownText			= "Show countdown text during primary voice countdowns"
L.Area_VoicePackOptions		= "Voice Pack Options (3rd party voice packs)"
L.SpecWarn_NoSoundsWVoice	= "Filter special warning sounds for warnings that also have spoken alerts..."
L.SWFNever					= "Never"
L.SWFDefaultOnly			= "when special warnings use default sounds. (Allows custom sounds to still play)"
L.SWFAll					= "when special warnings use any sound"
L.SpecWarn_AlwaysVoice		= "Always play all spoken alerts (Overrides boss-specific options. Useful for RL)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?

-- Tab: HealthFrame
L.Panel_HPFrame				= "Health Frame"
L.Area_HPFrame				= "Health Frame Options"
L.HP_Enabled				= "Always show health frame (Overrides boss-specific option)"
L.HP_GrowUpwards			= "Expand health frame upward"
L.HP_ShowDemo				= "Show HP frame"
L.BarWidth					= "Bar width: %d"

-- Tab: Global Filter
L.Panel_SpamFilter			= "DBM Global Disables & Filters"
L.Area_SpamFilter_Outgoing	= "DBM Global Disable & Filter Options"
L.SpamBlockNoShowAnnounce	= "Do not show announces or play warning sounds"
L.SpamBlockNoSendWhisper	= "Do not send boss warning whispers to other players"
L.SpamBlockNoSetIcon		= "Do not set icons on targets"
L.SpamBlockNoRangeFrame		= "Do not show range frame"
L.SpamBlockNoInfoFrame		= "Do not show info frame"
L.SpamBlockNoHudMap			= "Do not show HudMap"
L.SpamBlockNoHealthFrame	= "Do not show health frame"
L.SpamBlockNoCountdowns		= "Do not play countdown sounds"
L.SpamBlockNoIconRestore	= "Do not save icon states and restore them on combat end"
L.SpamBlockNoRangeRestore	= "Do not restore range frame to previous state when mods call 'hide'"

-- Tab: Spam Filter
L.Area_SpamFilter			= "Spam Filter Options"
L.DontShowFarWarnings		= "Do not show announces/timers for events that are far away"
L.StripServerName			= "Strip realm name in warnings and timers"
L.SpamBlockBossWhispers		= "Filter &lt;DBM&gt; warning whispers while fighting"

L.Area_SpecFilter			= "Role Filter Options"
L.FilterTankSpec			= "Filter warnings designated for Tank role when not tank spec. (Note: Disabling this is not recommended for most users as 'taunt' warnings are now all on by default.)"
L.FilterInterrupts			= "Filter warnings for interruptable spells if caster is not your current target or focus target. (Note: does not apply to spells deemed critical to interrupt that will likely result in raid wipes if missed)"
L.FilterDispels				= "Filter warnings for dispelable spells if your dispel is on cooldown."
L.FilterSelfHud				= "Filter yourself from HudMap (Excludes range based Hud functions)"

L.Area_PullTimer			= "Pull, Break, Combat, & Custom Timer Filter Options"
L.DontShowPTNoID			= "Block Pull Timer if not sent from same zone as you"
L.DontShowPT				= "Do not show Pull/Break Timer bar"
L.DontShowPTText			= "Do not show announce text for Pull/Break Timer"
L.DontPlayPTCountdown		= "Do not play Pull/Break/Combat/Custom Timer countdown audio"
L.DontShowPTCountdownText	= "Do not show Pull/Break/Combat/Custom Timer countdown text"
L.PT_Threshold				= "Do not show Pull/Break/Combat/Custom Timer countdown text above: %d"

L.Panel_HideBlizzard		= "Blizzard Disable & Hide"
L.Area_HideBlizzard			= "Blizzard Disable & Hide Options"
L.HideBossEmoteFrame		= "Hide raid boss emote frame during boss fights"
L.HideWatchFrame			= "Hide watch (objectives) frame during boss fights if no achievements are being tracked. If in a CM, creates a temp medal timer during boss fight while frame hidden."
L.HideGarrisonUpdates		= "Hide garrison toasts during boss fights"
L.HideGuildChallengeUpdates	= "Hide guild challenge toasts during boss fights"
L.HideTooltips				= "Hide tooltips during boss fights"
L.DisableSFX				= "Disable sound effects channel during boss fights"
L.HideApplicantAlerts		= "Supress applicant alerts in premade groups"
L.HideApplicantAlertsFull	= "If group is full"
L.HideApplicantAlertsNotL	= "if not the group leader (applies group is full filter if you are the leader)"
L.SpamBlockSayYell			= "Hide chat bubbles announces from the chat frame"
L.DisableCinematics			= "Hide in-game cinematics"
L.AfterFirst				= "After each movie has played once"
L.Always					= ALWAYS

L.Panel_ExtraFeatures		= "Extra Features"
L.Area_ChatAlerts			= "Text Alert Options"
L.RoleSpecAlert				= "Show alert message on raid join when your loot spec does not match current spec"
L.CheckGear					= "Show gear alert message during pull (when your equipped ilvl is much lower than bag ilvl (40+) or main weapon is not equipped)"
L.WorldBossAlert			= "Show alert message when world bosses might have been engaged on your realm by guildies or friends (inaccurate if sender is CRZed)"
L.Area_SoundAlerts			= "Sound Alert Options"
L.LFDEnhance				= "Play readycheck sound for role checks &amp; BG/LFG proposals in Master audio channel (I.E. sounds work even if SFX are off and are generally louder)"
L.WorldBossNearAlert		= "Play readycheck sound when world bosses you are near to are pulled that you need (Overrides boss-specific option)"
L.RLReadyCheckSound			= "Play readycheck sounds from actual ready checks through master audio channel."
L.AFKHealthWarning			= "Play alert sound if you are losing health while AFK"
L.Area_AutoLogging			= "Auto Logging Options"
L.AutologBosses				= "Automatically record boss encounters using blizzard combat log (Use /dbm pull before bosses to start logging early for pre pots and other events.)"
L.AdvancedAutologBosses		= "Automatically record boss encounters with Transcriptor"
L.LogOnlyRaidBosses			= "Only record raid boss encounters (exclude Raid Finder/party/scenario)"
L.Area_3rdParty				= "3rd Party Addon Options"
L.ShowBBOnCombatStart		= "Perform Big Brother buff check on combat start"
L.BigBrotherAnnounceToRaid	= "Announce Big Brother results to raid"
L.Area_Invite				= "Invite Options"
L.AutoAcceptFriendInvite	= "Automatically accept group invites from friends"
L.AutoAcceptGuildInvite		= "Automatically accept group invites from guild members"
L.Area_Advanced				= "Advanced Options"
L.FakeBW					= "Pretend to be BigWigs in version checks instead of DBM (Useful for guilds that force using BigWigs)"

L.PizzaTimer_Headline 		= 'Create a "Pizza Timer"'
L.PizzaTimer_Title			= 'Name (e.g. "Pizza!")'
L.PizzaTimer_Hours 			= "Hours"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sec"
L.PizzaTimer_ButtonStart 	= "Start timer"
L.PizzaTimer_BroadCast		= "Broadcast to raid"

L.Panel_Profile				= "Profiles"
L.Area_CreateProfile		= "Profile Creation"
L.EnterProfileName			= "Enter profile name"
L.CreateProfile				= "Create profile for DBM Core Options"
L.Area_ApplyProfile			= "Set Active Profile for DBM Core Options"
L.SelectProfileToApply		= "Select profile to apply"
L.Area_CopyProfile			= "Copy profile for DBM Core Options"
L.SelectProfileToCopy		= "Select profile to copy"
L.Area_DeleteProfile		= "Remove Profile for DBM Core Options"
L.SelectProfileToDelete		= "Select profile to delete"
L.Area_DualProfile			= "Boss mod profile options"
L.DualProfile				= "Enable support for different boss mod options per spec. (Managing of boss mod profiles is done from loaded boss mod stats screen)"

L.Area_ModProfile			= "Copy mod settings from another char/spec or delete mod settings"
L.ModAllReset				= "Reset all mod settings"
L.ModAllStatReset			= "Reset all mod stats"
L.SelectModProfileCopy		= "Copy all settings from"
L.SelectModProfileCopySound	= "Copy just sound setting from"
L.SelectModProfileDelete	= "Delete mod settings for"

-- Misc
L.FontHeight	= 16
