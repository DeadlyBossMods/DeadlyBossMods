DBM_GUI_L = {}

local L = DBM_GUI_L

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Translated by "
L.TranslationBy 			= nil -- your name here, localizers!
L.Website					= "Visit us on discord at |cFF73C2FBhttps://discord.gg/deadlybossmods|r. Follow on twitter @deadlybossmods or @MysticalOS"
L.WebsiteButton				= "Website"

L.OTabBosses	= "Bosses"--Deprecated and will be deleted once tabs no longer use this
L.OTabRaids		= "Raid"--Raids & PVP
L.OTabDungeons	= "Party/Solo"--1-5 person content (Dungeons, MoP Scenarios, World Events, Brawlers, Proving Grounds, Visions, Torghast, etc)
L.OTabPlugins	= "Core Plugins"
L.OTabOptions	= GAMEOPTIONS_MENU
L.OTabAbout		= "About"

L.TabCategory_SHADOWLANDS	= EXPANSION_NAME8
L.TabCategory_BFA	 		= EXPANSION_NAME7
L.TabCategory_LEG	 		= EXPANSION_NAME6
L.TabCategory_WOD	 		= EXPANSION_NAME5
L.TabCategory_MOP	 		= EXPANSION_NAME4
L.TabCategory_CATA	 		= EXPANSION_NAME3
L.TabCategory_WOTLK 		= EXPANSION_NAME2
L.TabCategory_BC 			= EXPANSION_NAME1
L.TabCategory_CLASSIC		= EXPANSION_NAME0
L.TabCategory_OTHER    		= "Other Mods"

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

-- Tab: General Options
L.TabCategory_Options	 	= "General Options"
L.Area_BasicSetup			= "Initial DBM Setup Tips"
L.Area_ModulesForYou		= "What DBM modules are right for you?"
L.Area_ProfilesSetup		= "DBM Profiles usage guide"
-- Panel: Core & GUI
L.Core_GUI 					= "Core & GUI"
L.General 					= "General DBM Core Options"
L.EnableMiniMapIcon			= "Show minimap button"
L.UseSoundChannel			= "Set audio channel used by DBM to play alert sounds"
L.UseMasterChannel			= "Master audio channel."
L.UseDialogChannel			= "Dialog audio channel."
L.UseSFXChannel				= "Sound Effects (SFX) audio channel."
L.Latency_Text				= "Set max latency sync threshold: %d"

L.Button_RangeFrame			= "Show/hide range frame"
L.Button_InfoFrame			= "Show/hide info frame"
L.Button_TestBars			= "Start test bars"
L.Button_ResetInfoRange		= "Reset Info/Range frames"

L.ModelOptions				= "3D Model Viewer Options"
L.EnableModels				= "Enable 3D models in boss options"
L.ModelSoundOptions			= "Set sound option for model viewer"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.ResizeOptions			 	= "Resize Options"
L.Button_ResetWindowSize	= "Reset GUI window size"
L.Editbox_WindowWidth		= "GUI window width"
L.Editbox_WindowHeight		= "GUI window height"

-- Panel: Extra Features
L.Panel_ExtraFeatures		= "Extra Features"

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
L.AutologBosses				= "Automatically record dungeons/raids using blizzard combat log"
L.AdvancedAutologBosses		= "Automatically record dungeons/raids with Transcriptor"
L.RecordOnlyBosses			= "Only record Bosses (Excludes all trash. Use '/dbm pull' before bosses to capture pre pull pots &amp; ENCOUNTER_START)"
L.LogOnlyNonTrivial			= "Only record non trivial content (normal or harder current content raids &amp; Mythic+ Dungeons)"
--
L.Area_3rdParty				= "3rd Party Addon Options"
L.ShowBBOnCombatStart		= "Perform Big Brother buff check on combat start"
L.BigBrotherAnnounceToRaid	= "Announce Big Brother results to raid"
L.Area_Invite				= "Invite Options"
L.AutoAcceptFriendInvite	= "Automatically accept group invites from friends"
L.AutoAcceptGuildInvite		= "Automatically accept group invites from guild members"
L.Area_Advanced				= "Advanced Options"
L.FakeBW					= "Pretend to be BigWigs in version checks instead of DBM (Useful for guilds that force using BigWigs)"
L.AITimer					= "Automatically generate timers for never before seen fights using DBM's built in timer AI (Useful for pulling a test boss for the very first time such as beta or PTR). Recommended to always leave this turned ON"

-- Panel: Profiles
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

-- Tab: Alerts
L.TabCategory_Alerts	 	= "Alerts"
L.Area_SpecAnnounceConfig	= "Special Announce visuals and sound guide"
L.Area_SpecAnnounceNotes	= "Special Announce Notes guide"
L.Area_VoicePackInfo		= "Information on DBM Voice Packs"
-- Panel: Raidwarning
L.Tab_RaidWarning 			= "Announcements"
L.RaidWarning_Header		= "Announce Options"
L.RaidWarnColors 			= "Announce Colors"
L.RaidWarnColor_1 			= "Color 1"
L.RaidWarnColor_2 			= "Color 2"
L.RaidWarnColor_3		 	= "Color 3"
L.RaidWarnColor_4 			= "Color 4"
L.InfoRaidWarning			= [[You can specify the position and colors of the raid warning frame.
This frame is used for messages like "Player X is affected by Y".]]
L.ColorResetted 			= "The color settings of this field have been reset."
L.ShowWarningsInChat 		= "Show announcements in chat frame"
L.WarningIconLeft 			= "Show icon on left side"
L.WarningIconRight 			= "Show icon on right side"
L.WarningIconChat 			= "Show icons in chat frame"
L.WarningAlphabetical		= "Sort names alphabetically"
L.Warn_Duration				= "Announcement duration: %0.1f sec"
L.None						= "None"
L.Random					= "Random"
L.Outline					= "Outline"
L.ThickOutline				= "Thick outline"
L.MonochromeOutline			= "Monochrome outline"
L.MonochromeThickOutline	= "Monochrome thick outline"
L.RaidWarnSound				= "Play sound on raid announcement"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Special Announcements"
L.Area_SpecWarn				= "Special Announce Options"
L.SpecWarn_ClassColor		= "Use class coloring for special announcements"
L.ShowSWarningsInChat 		= "Show special announcements in chat frame"
L.SWarnNameInNote			= "Use Type 5 options if a special announce note contains your name"
L.SpecialWarningIcon		= "Show icons on special announcements"
L.ShortTextSpellname		= "Use shorter spellname text (when available)"
L.SpecWarn_FlashFrameRepeat	= "Flash %d times(s)"
L.SpecWarn_Flash			= "Flash screen"
L.SpecWarn_FlashRepeat		= "Repeat Flash"
L.SpecWarn_FlashColor		= "Flash color %d"
L.SpecWarn_FlashDur			= "Flash duration: %0.1f"
L.SpecWarn_FlashAlpha		= "Flash alpha: %0.1f"
L.SpecWarn_DemoButton		= "Show example"
L.SpecWarn_ResetMe			= "Reset to defaults"
L.SpecialWarnSoundOption	= "Set default sound"
L.SpecialWarnHeader1		= "Type 1: Set options for normal priority announcements affecting you or your actions"
L.SpecialWarnHeader2		= "Type 2: Set options for normal priority announcements affecting everyone"
L.SpecialWarnHeader3		= "Type 3: Set options for HIGH priority announcements"
L.SpecialWarnHeader4		= "Type 4: Set options for HIGH priority run away special announcements"
L.SpecialWarnHeader5		= "Type 5: Set options for announcements with notes containing your player name"

-- Panel: Generalwarnings
L.Tab_GeneralMessages 		= "Chatframe Messages"
L.CoreMessages				= "Core Message Options"
L.ShowPizzaMessage 			= "Show timer broadcast messages in chat frame"
L.ShowAllVersions	 		= "Show boss mod versions for all group members in chat frame when doing a version check. (If disabled, still does out of date/current summery)"
L.ShowReminders				= "Show reminder messages for missing sub-mods, disabled sub-mods, sub-mod hotfixes, out of date sub-mods, and silent mode still being enabled"

L.CombatMessages			= "Combat Message Options"
L.ShowEngageMessage 		= "Show engage messages in chat frame"
L.ShowDefeatMessage 		= "Show kill/wipe messages in chat frame"
L.ShowGuildMessages 		= "Show engage/kill/wipe messages for guild raids in chat frame"
L.ShowGuildMessagesPlus		= "Also show Mythic+ engage/kill/wipe messages for guild groups (requires raid option)"

L.Area_ChatAlerts			= "Additional Alert Options"
L.RoleSpecAlert				= "Show alert message on raid join when your loot spec does not match current spec"
L.CheckGear					= "Show gear alert message during pull (when your equipped ilvl is much lower than bag ilvl (40+) or main weapon is not equipped)"
L.WorldBossAlert			= "Show alert message when world bosses might have been engaged on your realm by guildies or friends (inaccurate if sender is CRZed)"

L.Area_BugAlerts			= "Bug Reporting Alert Options"
L.BadTimerAlert				= "Show chat message when DBM detects a bad timer with at least 1 second of incorrectness"
L.BadIDAlert				= "Show chat message when DBM detects an invalid spell or journal ID in use"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Spoken Alerts"
L.Area_VoiceSelection		= "Voice Selections"
L.CountdownVoice			= "Set primary voice for count sounds"
L.CountdownVoice2			= "Set secondary voice for count sounds"
L.CountdownVoice3			= "Set tertiary voice for count sounds"
L.VoicePackChoice			= "Set voice pack for spoken alerts"
L.Area_CountdownOptions		= "Countdown Options"
L.Area_VoicePackOptions		= "Voice Pack Options (3rd party voice packs)"
L.SpecWarn_NoSoundsWVoice	= "Filter special announce sounds for announcements that also have spoken alerts..."
L.SWFNever					= "Never"
L.SWFDefaultOnly			= "when special announcements use default sounds. (Allows custom sounds to still play)"
L.SWFAll					= "when special announcements use any sound"
L.SpecWarn_AlwaysVoice		= "Always play all spoken alerts (Even if Special Announce disabled. Useful for Raid Leader, not recommended otherwise)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?
L.Area_GetVEM				= "Get VEM Voice Pack"
L.VEMDownload				= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/dbm-voicepack-vem|r"
L.Area_BrowseOtherVP		= "Browse other voice packs on curse"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "Browse countdown packs on curse"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Panel: Event Sounds
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

-- Tab: Timers
L.TabCategory_Timers		= "Timers"
L.Area_ColorBytype			= "Color bars by type guide"
-- Panel: Color by Type
L.Panel_ColorByType	 		= "Color by Type"
L.AreaTitle_BarColors		= "Bar Colors by timer type"
L.BarTexture				= "Bar texture"
L.BarStyle					= "Bar behavior"
L.BarDBM					= "Classic (existing small bar slides to Enlarged anchor)"
L.BarSimple					= "Simple (small bar disappears and new large bar created)"
L.BarStartColor				= "Start color"
L.BarEndColor 				= "End color"
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
--Dropdown Options
L.CBTGeneric				= "Generic"
L.CBTAdd					= "Add"
L.CBTAOE					= "AOE"
L.CBTTargeted				= "Targeted"
L.CBTInterrupt				= "Interrupt"
L.CBTRole					= "Role"
L.CBTPhase					= "Phase"
L.CBTImportant				= "Important (User)"
L.CVoiceOne					= "Count Voice 1"
L.CVoiceTwo					= "Count Voice 2"
L.CVoiceThree				= "Count Voice 3"

-- Panel: Timers
L.Panel_Appearance	 		= "Bar Appearance"
L.Panel_Behavior	 		= "Bar Behavior"
L.AreaTitle_BarSetup		= "Bar Appearance Options"
L.AreaTitle_Behavior		= "Bar Behavior Options"
L.AreaTitle_BarSetupSmall 	= "Small Bar Options"
L.AreaTitle_BarSetupHuge	= "Huge Bar Options"
L.EnableHugeBar 			= "Enable huge bar (aka Bar 2)"
L.BarIconLeft 				= "Left icon"
L.BarIconRight 				= "Right icon"
L.ExpandUpwards				= "Expand upward"
L.FillUpBars				= "Fill up"
L.ClickThrough				= "Disable mouse events (click through)"
L.Bar_Decimal				= "Decimal shows below time: %d"
L.Bar_Alpha					= "Bar Alpha: %0.1f"
L.Bar_EnlargeTime			= "Bar enlarges below time: %d"
L.BarSpark					= "Bar spark"
L.BarFlash					= "Flash bar about to expire"
L.BarSort					= "Sort by remaining time"
L.BarColorByType			= "Color by type"
L.NoBarFade					= "Use Start/End colors as Small/Large colors instead of gradual color change"
L.BarInlineIcons			= "Show inline icons"
L.ShortTimerText			= "Use short timer text (when available)"
L.StripTimerText			= "Strip CD/Next out of timers"
L.KeepBar					= "Keep timer active until ability cast"
L.KeepBar2					= "(when supported by mod)"
L.FadeBar					= "Fade timers for out of range abilities"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 	= "Global Disables & Filters"
L.Area_DBMFiltersSetup		= "DBM Filters guide"
L.Area_BlizzFiltersSetup	= "Blizzard Filters guide"
-- Panel: DBM Features
L.Panel_SpamFilter			= "DBM Features"
L.Area_SpamFilter_Anounces	= "Announce Global Disable & Filter Options"
L.SpamBlockNoShowAnnounce	= "Do not show text or play sound for ANY general announcements"
L.SpamBlockNoShowTgtAnnounce= "Do not show text or play sound for TARGET general announcements (above filter overrides this one)"
L.SpamBlockNoSpecWarnText	= "Do not show special announce text"
L.SpamBlockNoSpecWarnFlash	= "Do not show special announce screen flash"
L.SpamBlockNoSpecWarnSound	= "Do not play special announce sounds (still permits voice packs, if one is enabled in Spoken Alerts panel)"

L.Area_SpamFilter_Timers	= "Timer Global Disable & Filter Options"
L.SpamBlockNoShowTimers		= "Do not show mod timers (Boss Mod/CM/LFG/Respawn)"
L.SpamBlockNoShowUTimers	= "Do not show user sent timers (Custom/Pull/Break)"
L.SpamBlockNoCountdowns		= "Do not play countdown sounds"

L.Area_SpamFilter_Misc		= "Misc Global Disable & Filter Options"
L.SpamBlockNoSetIcon		= "Do not set icons on targets"
L.SpamBlockNoRangeFrame		= "Do not show range frame"
L.SpamBlockNoInfoFrame		= "Do not show info frame"
L.SpamBlockNoHudMap			= "Do not show HudMap"
L.SpamBlockNoNameplate		= "Do not show Nameplate Auras"
L.SpamBlockNoYells			= "Do not send chat yells"
L.SpamBlockNoNoteSync		= "Do not accept shared notes"

L.Area_Restore				= "DBM Restore Options (Whether DBM restores previous user state when mods finish)"
L.SpamBlockNoIconRestore	= "Do not save icon states and restore them on combat end"
L.SpamBlockNoRangeRestore	= "Do not restore range frame to previous state when mods call 'hide'"

L.Area_SpamFilter			= "Spam Filter Options"
L.DontShowFarWarnings		= "Do not show announcements/timers for events that are far away"
L.StripServerName			= "Strip realm name from announcements, timers, range check, and infoframe"
L.FilterVoidFormSay			= "Do not send chat icon or countdown chat yells when in Void Form (regular chat yells still sent)"

L.Area_SpecFilter			= "Role Filter Options"
L.FilterTankSpec			= "Filter announcements designated for Tank role when not tank spec. (Note: Disabling this is not recommended for most users as 'taunt' announcements are now all on by default.)"
L.FilterInterruptsHeader	= "Filter announcements for interruptable spells based on behavior preference."
L.FilterInterrupts			= "If caster is not current target/focus (Always)."
L.FilterInterrupts2			= "If caster is not current target/focus (Always) or interrupt on CD (Boss Only)"
L.FilterInterrupts3			= "If caster is not current target/focus (Always) or interrupt on CD (Boss & Trash)"
L.FilterInterrupts4			= "Always filter interrupt announcements (you don't want to see them period)"
L.FilterInterruptNoteName	= "Filter announcements for interruptable spells (with count) if announce does not contain your name in the custom note"
L.FilterDispels				= "Filter announcements for dispelable spells if your dispel is on cooldown"
L.FilterTrashWarnings		= "Filter all trash mob announcements in normal &amp; heroic dungeons"

L.Area_PullTimer			= "Pull, Break, Combat, & Custom Timer Filter Options"
L.DontShowPTNoID			= "Block DBM Pull Timers if not sent from same zone as you (will never block BigWigs timers that are sent with no zone ID)"
L.DontShowPT				= "Do not show Pull/Break Timer bar"
L.DontShowPTText			= "Do not show announce text for Pull/Break Timer"
L.DontShowPTCountdownText	= "Do not show Pull countdown text"
L.DontPlayPTCountdown		= "Do not play Pull/Break/Combat/Custom Timer countdown audio at all"
L.PT_Threshold				= "Do not play Pull/Break/Combat/Custom Timer countdown audio above: %d"

-- Panel: Blizzard Features
L.Panel_HideBlizzard		= "Blizzard Features"
L.Area_HideBlizzard			= "Blizzard Disable & Hide Options"
L.HideBossEmoteFrame		= "Hide raid boss emote frame during boss fights"
L.HideWatchFrame			= "Hide watch (objectives) frame during boss fights if no achievements are being tracked and if not in a Mythic+"
L.HideGarrisonUpdates		= "Hide follower toasts during boss fights"
L.HideGuildChallengeUpdates	= "Hide guild challenge toasts during boss fights"
L.HideQuestTooltips			= "Hide quest objectives from tooltips during boss fights"
L.HideTooltips				= "Completely hide tooltips during boss fights"
L.DisableSFX				= "Disable sound effects channel during boss fights"
L.DisableCinematics			= "Hide in-game cinematics"
L.OnlyFight					= "Only during fight, after each movie has played once"
L.AfterFirst				= "In instance, after each movie has played once"
L.CombatOnly				= "Disable in combat (any)"
L.RaidCombat				= "Disable in combat (bosses only)"

-- Panel: Privacy
L.Tab_Privacy 				= "Privacy Controls"
L.Area_WhisperMessages		= "Whisper Message Options"
L.AutoRespond 				= "Auto-respond to whispers while fighting"
L.WhisperStats 				= "Include kill/wipe stats in whisper responses"
L.DisableStatusWhisper 		= "Disable status whispers for the entire group (requires Group Leader). Applies only to normal/heroic/mythic raids and mythic+ dungeons"
L.Area_SyncMessages			= "Addon Sync Options"
L.DisableGuildStatus 		= "Disable progression messages from being synced to guild. If group leader, this disables it for all DBM users in your group"
L.EnableWBSharing 			= "Share when you pull/defeat a world boss with your guild and your battle.net friends that are on same realm."

-- Tab: Frames & Integrations
L.TabCategory_Frames		= "Frames & Integrations"
L.Area_NamelateInfo			= "DBM Nameplate Auras Info"
-- Panel: InfoFrame
L.Panel_InfoFrame			= "Infoframe"

-- Panel: Range
L.Panel_Range				= "Rangeframe"

-- Panel: Nameplate
L.Panel_Nameplates			= "Nameplates"
L.UseNameplateHandoff		= "Hand off nameplate aura requests to supported nameplate addons (KuiNameplates, Threat Plates, Plater) instead of handling internally. This is recommended option as it allows more advanted features and configuration to be done via nameplate addon"
L.Area_NPStyle				= "Style (Note: Only configures style when DBM is handling nameplates.)"
L.NPAuraSize				= "Aura Pixel size (squared): %d"

-- Misc
L.Area_General				= "General"
L.Area_Position				= "Position"
L.Area_Style				= "Style"

L.FontSize					= "Font size: %d"
L.FontStyle					= "Font flags"
L.FontColor					= "Font color"
L.FontShadow				= "Font Shadow"
L.FontType					= "Select font"

L.FontHeight	= 16
