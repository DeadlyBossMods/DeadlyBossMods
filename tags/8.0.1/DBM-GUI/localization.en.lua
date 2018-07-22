DBM_GUI_Translations = {}

local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Translated by "
L.TranslationBy 			= nil -- your name here, localizers!
L.Website					= "Visit us on discord at |cFF73C2FBhttps://discord.gg/deadlybossmods|r. Follow on twitter @deadlybossmods or @MysticalOS"
L.WebsiteButton				= "Website"

L.OTabBosses	= "Bosses"
L.OTabOptions	= GAMEOPTIONS_MENU

L.TabCategory_Options	 	= "General Options"
L.TabCategory_BFA	 		= EXPANSION_NAME7 or "Battle for Azeroth"
L.TabCategory_LEG	 		= EXPANSION_NAME6
L.TabCategory_WOD	 		= EXPANSION_NAME5
L.TabCategory_MOP	 		= EXPANSION_NAME4
L.TabCategory_CATA	 		= EXPANSION_NAME3
L.TabCategory_WOTLK 		= EXPANSION_NAME2
L.TabCategory_BC 			= EXPANSION_NAME1
L.TabCategory_CLASSIC		= EXPANSION_NAME0
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
L.Statistic_BestRank		= "Best Rank:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Core Options
L.General 					= "General DBM Core Options"
L.EnableMiniMapIcon			= "Show minimap button"
L.UseSoundChannel			= "Set audio channel used by DBM to play alert sounds"
L.UseMasterChannel			= "Master audio channel."
L.UseDialogChannel			= "Dialog audio channel."
L.UseSFXChannel				= "Sound Effects (SFX) audio channel."
L.Latency_Text				= "Set max latency sync threshold: %d"

L.ModelOptions				= "3D Model Viewer Options"
L.EnableModels				= "Enable 3D models in boss options"
L.ModelSoundOptions			= "Set sound option for model viewer"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.Button_RangeFrame			= "Show/hide range frame"
L.Button_InfoFrame			= "Show/hide info frame"
L.Button_TestBars			= "Start test bars"
L.Button_ResetInfoRange		= "Reset Info/Range frames"

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
L.WarningIconLeft 			= "Show icon on left side"
L.WarningIconRight 			= "Show icon on right side"
L.WarningIconChat 			= "Show icons in chat frame"
L.WarningAlphabetical		= "Sort names alphabetically"
L.Warn_FontType				= "Select font"
L.Warn_FontStyle			= "Font flags"
L.Warn_FontShadow			= "Shadow"
L.Warn_FontSize				= "Font size: %d"
L.Warn_Duration				= "Warning duration: %0.1f sec"
L.None						= "None"
L.Random					= "Random"
L.Outline					= "Outline"
L.ThickOutline				= "Thick outline"
L.MonochromeOutline			= "Monochrome outline"
L.MonochromeThickOutline	= "Monochrome thick outline"
L.RaidWarnSound				= "Play sound on raid warning"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "General Messages"
L.CoreMessages				= "Core Message Options"
L.ShowPizzaMessage 			= "Show timer broadcast messages in chat frame"
L.ShowAllVersions	 		= "Show boss mod versions for all group members in chat frame when doing a version check. (If disabled, still does out of date/current summery)"
L.CombatMessages			= "Combat Message Options"
L.ShowEngageMessage 		= "Show engage messages in chat frame"
L.ShowDefeatMessage 		= "Show kill/wipe messages in chat frame"
L.ShowGuildMessages 		= "Show engage/kill/wipe messages for guild raids in chat frame"
L.ShowGuildMessagesPlus		= "Also show Mythic+ engage/kill/wipe messages for guild groups (requires raid option)"
L.WhisperMessages			= "Whisper Message Options"
L.AutoRespond 				= "Auto-respond to whispers while fighting"
L.EnableStatus 				= "Reply to 'status' whispers"
L.WhisperStats 				= "Include kill/wipe stats in whisper responses"
L.DisableStatusWhisper 		= "Disable status whispers for the entire group (requires Group Leader). Applies only to normal/heroic/mythic raids and mythic+ dungeons"
L.DisableGuildStatus 		= "Disable progression messages from being sent to guild for entire group (requires Group Leader)."

-- Tab: Barsetup
L.BarSetup					= "Bar Setup"
L.BarTexture				= "Bar texture"
L.BarStyle					= "Bar style"
L.BarDBM					= "DBM (animations)"
L.BarSimple					= "Simple (no animation)"
L.BarStartColor				= "Start color"
L.BarEndColor 				= "End color"
L.Bar_Font					= "Font used for bars"
L.Bar_FontSize				= "Font size: %d"
L.Bar_Height				= "Bar Height: %d"
L.Slider_BarOffSetX 		= "Offset X: %d"
L.Slider_BarOffSetY 		= "Offset Y: %d"
L.Slider_BarWidth 			= "Bar width: %d"
L.Slider_BarScale 			= "Bar scale: %0.2f"
--Types
L.BarStartColorAdd			= "Start color (Add)"
L.BarEndColorAdd			= "End color (Add)"
L.BarStartColorAOE			= "Start color (AOE)"
L.BarEndColorAOE			= "End color (AOE)"
L.BarStartColorDebuff		= "Start color (Targeted)"
L.BarEndColorDebuff			= "End color (Targeted)"
L.BarStartColorInterrupt	= "Start color (Interrupt)"
L.BarEndColorInterrupt		= "End color (Interrupt)"
L.BarStartColorRole			= "Start color (Role)"
L.BarEndColorRole			= "End color (Role)"
L.BarStartColorPhase		= "Start color (Stage)"
L.BarEndColorPhase			= "End color (Stage)"
L.BarStartColorUI			= "Start color (User)"
L.BarEndColorUI				= "End color (User)"
--Type 7 options
L.Bar7Header				= "User Bar Options"
L.Bar7ForceLarge			= "Always use large bar"
L.Bar7CustomInline			= "Use custom '!' inline icon"
L.Bar7Footer				= "(Dummy Bar won't live update)"

-- Tab: Timers
L.AreaTitle_BarColors		= "Bar Colors by timer type"
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
L.Bar_DBMOnly				= "Below options only work with \"DBM\" bar style."
L.Bar_EnlargeTime			= "Bar enlarges below time: %d"
L.Bar_EnlargePercent		= "Bar enlarges below percent: %0.1f%%"
L.BarSpark					= "Bar spark"
L.BarFlash					= "Flash bar about to expire"
L.BarSort					= "Sort by remaining time"
L.BarColorByType			= "Color by type"
L.BarInlineIcons			= "Show inline icons"
L.ShortTimerText			= "Use short timer text (when available)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Special Warnings"
L.Area_SpecWarn				= "Special Warning Options"
L.SpecWarn_ClassColor		= "Use class coloring for special warnings"
L.ShowSWarningsInChat 		= "Show special warnings in chat frame"
L.SWarnNameInNote			= "Use SW5 options if a custom note contains your name"
L.SpecialWarningIcon		= "Show icons on special warnings"
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
L.SpecialWarnSound			= "Set default sound for special warnings affecting you or your actions"
L.SpecialWarnSound2			= "Set default sound for special warnings affecting everyone"
L.SpecialWarnSound3			= "Set default sound for VERY important special warnings"
L.SpecialWarnSound4			= "Set default sound for run away special warnings"
L.SpecialWarnSound5			= "Set default sound for special warnings with notes containing your name"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Spoken Alerts"
L.Area_VoiceSelection		= "Voice Selections (scroll selection menus with mouse wheel)"
L.CountdownVoice			= "Set primary voice for count sounds"
L.CountdownVoice2			= "Set secondary voice for count sounds"
L.CountdownVoice3			= "Set tertiary voice for count sounds"
L.VoicePackChoice			= "Set voice pack for spoken alerts"
L.Area_CountdownOptions		= "Countdown Options"
L.Area_VoicePackOptions		= "Voice Pack Options (3rd party voice packs)"
L.SpecWarn_NoSoundsWVoice	= "Filter special warning sounds for warnings that also have spoken alerts..."
L.SWFNever					= "Never"
L.SWFDefaultOnly			= "when special warnings use default sounds. (Allows custom sounds to still play)"
L.SWFAll					= "when special warnings use any sound"
L.SpecWarn_AlwaysVoice		= "Always play all spoken alerts (Overrides boss-specific options. Useful for RL)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?
L.Area_GetVEM				= "Get VEM Voice Pack"
L.VEMDownload				= "|cFF73C2FBhttps://wow.curseforge.com/projects/dbm-voicepack-vem|r"
L.Area_BrowseOtherVP		= "Browse other voice packs on curse"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://wow.curseforge.com/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "Browse countdown packs on curse"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://wow.curseforge.com/search?search=dbm+count+pack|r"

-- Tab: Event Sounds
L.Panel_EventSounds			= "Event Sounds"
L.Area_SoundSelection		= "Sound Selections (scroll selection menus with mouse wheel)"
L.EventVictorySound			= "Set sound played for encounter victory"
L.EventWipeSound			= "Set sound played for encounter wipe"
L.EventEngageSound			= "Set sound played for encounter engage"
L.EventDungeonMusic			= "Set music played inside dungeons/raids"
L.EventEngageMusic			= "Set music played during encounters"
L.Area_EventSoundsExtras	= "Event Sound Options"
L.EventMusicCombined		= "Allow all music choices in dungeon and encounter selections (changing this option requires UIReload to reflect changes)"
L.Area_EventSoundsFilters	= "Event Sound Filter Conditions"
L.EventFilterDungMythicMusic= "Do not play dungeon music on Mythic/Mythic+ difficulty"
L.EventFilterMythicMusic	= "Do not play encounter music on Mythic/Mythic+ difficulty"

-- Tab: Global Filter
L.Panel_SpamFilter			= "DBM Global Disables & Filters"
L.Area_SpamFilter_Outgoing	= "DBM Global Disable & Filter Options"
L.SpamBlockNoShowAnnounce	= "Do not show text or play sound for ANY general announces"
L.SpamBlockNoShowTgtAnnounce= "Do not show text or play sound for TARGET general announces (above filter overrides this one)"
L.SpamBlockNoSpecWarn		= "Do not show special warnings or play special warning sounds"
L.SpamBlockNoSpecWarnText	= "Do not show special warning text, but still allow voice packs (above filter overrides this one)"
L.SpamBlockNoShowTimers		= "Do not show mod timers (Boss Mod/CM/LFG/Respawn)"
L.SpamBlockNoShowUTimers	= "Do not show user sent timers (Custom/Pull/Break)"
L.SpamBlockNoSetIcon		= "Do not set icons on targets"
L.SpamBlockNoRangeFrame		= "Do not show range frame"
L.SpamBlockNoInfoFrame		= "Do not show info frame"
L.SpamBlockNoHudMap			= "Do not show HudMap"
L.SpamBlockNoNameplate		= "Do not show Nameplate Auras"
L.SpamBlockNoCountdowns		= "Do not play countdown sounds"
L.SpamBlockNoYells			= "Do not send chat yells"
L.SpamBlockNoNoteSync		= "Do not accept shared notes"
L.SpamBlockNoReminders		= "Do not show any login, recommendation, or update messages (NOT recommended)"

L.Area_Restore				= "DBM Restore Options (Whether DBM restores previous user state when mods finish)"
L.SpamBlockNoIconRestore	= "Do not save icon states and restore them on combat end"
L.SpamBlockNoRangeRestore	= "Do not restore range frame to previous state when mods call 'hide'"

-- Tab: Spam Filter
L.Area_SpamFilter			= "Spam Filter Options"
L.DontShowFarWarnings		= "Do not show announces/timers for events that are far away"
L.StripServerName			= "Strip realm name in warnings and timers"

L.Area_SpecFilter			= "Role Filter Options"
L.FilterTankSpec			= "Filter warnings designated for Tank role when not tank spec. (Note: Disabling this is not recommended for most users as 'taunt' warnings are now all on by default.)"
L.FilterInterruptsHeader	= "Filter warnings for interruptable spells based on behavior preference."
L.FilterInterrupts			= "If caster is not current target/focus (Always)."
L.FilterInterrupts2			= "if caster is not current target/focus (Always) or interrupt on CD (Boss Only)"
L.FilterInterrupts3			= "if caster is not current target/focus (Always) or interrupt on CD (Boss & Trash)"
L.FilterInterruptNoteName	= "Filter warnings for interruptable spells (with count) if warning does not contain your name in the custom note"
L.FilterDispels				= "Filter warnings for dispelable spells if your dispel is on cooldown"
L.FilterSelfHud				= "Filter yourself from HudMap (Excludes range based Hud functions)"

L.Area_PullTimer			= "Pull, Break, Combat, & Custom Timer Filter Options"
L.DontShowPTNoID			= "Block Pull Timer if not sent from same zone as you"
L.DontShowPT				= "Do not show Pull/Break Timer bar"
L.DontShowPTText			= "Do not show announce text for Pull/Break Timer"
L.DontPlayPTCountdown		= "Do not play Pull/Break/Combat/Custom Timer countdown audio"
L.DontShowPTCountdownText	= "Do not show Pull countdown text"
L.PT_Threshold				= "Do not show Break/Combat/Custom Timer countdown text above: %d"

L.Panel_HideBlizzard		= "Blizzard Disable & Hide"
L.Area_HideBlizzard			= "Blizzard Disable & Hide Options"
L.HideBossEmoteFrame		= "Hide raid boss emote frame during boss fights"
L.HideWatchFrame			= "Hide watch (objectives) frame during boss fights if no achievements are being tracked. If in a CM, creates a temp medal timer during boss fight while frame hidden."
L.HideGarrisonUpdates		= "Hide garrison toasts during boss fights"
L.HideGuildChallengeUpdates	= "Hide guild challenge toasts during boss fights"
L.HideQuestTooltips			= "Hide quest objectives from tooltips during boss fights"
L.HideTooltips				= "Completely hide tooltips during boss fights"
L.DisableSFX				= "Disable sound effects channel during boss fights"
L.DisableCinematics			= "Hide in-game cinematics"
L.AfterFirst				= "After each movie has played once"
L.Always					= ALWAYS
L.CombatOnly				= "Disable in combat (any)"
L.RaidCombat				= "Disable in combat (bosses only)"

L.Panel_ExtraFeatures		= "Extra Features"
--
L.Area_ChatAlerts			= "Text Alert Options"
L.RoleSpecAlert				= "Show alert message on raid join when your loot spec does not match current spec"
L.CheckGear					= "Show gear alert message during pull (when your equipped ilvl is much lower than bag ilvl (40+) or main weapon is not equipped)"
L.WorldBossAlert			= "Show alert message when world bosses might have been engaged on your realm by guildies or friends (inaccurate if sender is CRZed)"
--
L.Area_SoundAlerts			= "Sound/Flash Alert Options"
L.LFDEnhance				= "Play ready check sound and flash application icon for role checks &amp; BG/LFG proposals in Master or Dialog audio channel (I.E. sounds work even if SFX are off and are generally louder)"
L.WorldBossNearAlert		= "Play ready check sound and flash application icon when world bosses you are near to are pulled that you need"
L.RLReadyCheckSound			= "When a ready check is performed, play sound through Master or Dialog audio channel and flash application icon."
L.AFKHealthWarning			= "Play alert sound and flash application icon if you are losing health while AFK"
L.AutoReplySound			= "Play alert sound and flash application icon when receiving DBM auto reply whisper"
--
L.TimerGeneral 				= "Timer Options"
L.SKT_Enabled				= "Show record victory timer for current fight if available"
L.ShowRespawn				= "Show boss respawn timer after a wipe"
L.ShowQueuePop				= "Show time remaining to accept a queue pop (LFG,BG,etc)"
--
L.Area_AutoLogging			= "Auto Logging Options"
L.AutologBosses				= "Automatically record boss encounters using blizzard combat log (Use /dbm pull before bosses to start logging early for pre pots and other events.)"
L.AdvancedAutologBosses		= "Automatically record boss encounters with Transcriptor"
L.LogOnlyRaidBosses			= "Only record raid boss encounters from current expansion (exclude Raid Finder/party/scenario/old content)"
--
L.Area_3rdParty				= "3rd Party Addon Options"
L.ShowBBOnCombatStart		= "Perform Big Brother buff check on combat start"
L.BigBrotherAnnounceToRaid	= "Announce Big Brother results to raid"
L.Area_Invite				= "Invite Options"
L.AutoAcceptFriendInvite	= "Automatically accept group invites from friends"
L.AutoAcceptGuildInvite		= "Automatically accept group invites from guild members"
L.Area_Advanced				= "Advanced Options"
L.FakeBW					= "Pretend to be BigWigs in version checks instead of DBM (Useful for guilds that force using BigWigs)"
L.AITimer					= "Automatically generate timers for never before seen fights using DBM's built in timer AI (Useful for pulling a test boss for the very first time such as beta or PTR). Note: This won't work properly for multiple adds with same ability."
L.AutoCorrectTimer			= "Automatically correct timers that are too long (Useful for guilds pulling cutting edge content that boss mods aren't updated for yet). Note: This option may also make some timers worse if boss resets timers on phase changes that DBM isn't coded to handle properly yet."

L.Panel_Profile				= "Profiles"
L.Area_CreateProfile		= "Profile Creation for DBM Core Options"
L.EnterProfileName			= "Enter profile name"
L.CreateProfile				= "Create new profile with default settings"
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
L.SelectModProfileCopyNote	= "Copy just note setting from"
L.SelectModProfileDelete	= "Delete mod settings for"

-- Misc
L.FontHeight	= 16
