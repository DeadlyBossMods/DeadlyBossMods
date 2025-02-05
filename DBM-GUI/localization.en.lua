---@class DBMGUILocalization
local L = {}

DBM_GUI_L = L

L.MainFrame							= "Deadly Boss Mods" -- OPTIONAL

L.TranslationByPrefix				= "Translated by "
L.TranslationBy 					= nil -- your name here, localizers!
L.Website							= "Visit us on discord at |cFF73C2FBhttps://discord.gg/deadlybossmods|r. Follow on most socials @deadlybossmods or @mysticalos"
L.WebsiteButton						= "Website"

L.OTabBosses						= "Boss Options"--Deprecated and will be deleted once tabs no longer use this
L.OTabRaids							= "Raids"--Just pve raids
L.OTabDungeons						= "Dungeons"--Just dungeons
L.OTabWorld							= "World Bosses"--Since there are so many world mods, enough to get their own tab
L.OTabScenarios						= "Scenarios"--Future use, will be used for scenarios and delves, likely after there are more than 2 mods (so probably 12.x or later)
L.OTabPlugins						= "Other"--Scenarios, PVP, Delves (11.x), Solo/Challenge content (torghast, mage tower, etc)
L.OTabOptions						= "Core Options"
L.OTabAbout							= "About"

L.FOLLOWER							= "Follower"--i.e. the new dungeon type in 10.2.5. I haven't found a translated string yet
L.STORY					    		= PLAYER_DIFFICULTY_STORY_RAID or "Story"--i.e. the new dungeon type in 11.0.0. I haven't found a translated string yet

L.TabCategory_CURRENT_SEASON		= "Current Season"

L.TabCategory_OTHER					= "Other Mods"
L.TabCategory_AFFIXES				= "Affixes"

L.BossModLoaded 					= "%s statistics"
L.BossModLoad_now 					= [[This boss mod is not loaded.
It will be loaded when you enter the instance.
You can also click the button to load the mod manually.]]

L.PosX								= "Position X"
L.PosY								= "Position Y"

L.MoveMe 							= "Move me"
L.Button_OK 						= "OK"
L.Button_Cancel 					= "Cancel"
L.Button_LoadMod 					= "Load AddOn"
L.Mod_Enabled						= "Enable: %s"
L.Mod_Reset							= "Load default options"
L.Reset 							= "Reset"
L.Import							= "Import"

L.Enable							= ENABLE
L.Disable							= DISABLE

L.NoSound							= "No sound"

L.IconsInUse						= "Icons used by this mod"

-- Tab: Boss Statistics
L.BossStatistics					= "Boss Statistics"
L.Statistic_Kills					= "Victories:"
L.Statistic_Wipes					= "Wipes:"
L.Statistic_Incompletes				= "Incompletes:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill				= "Best Victory:"
L.Statistic_BestRank				= "Best Rank:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Options
L.TabCategory_Options	 			= "General Options"
L.Area_BasicSetup					= "Initial DBM Setup Tips"
L.Area_ModulesForYou				= "What DBM modules are right for you?"
L.Area_ProfilesSetup				= "DBM Profiles usage guide"
-- Panel: Core & GUI
L.Core_GUI 							= "Core & GUI"
L.General 							= "General DBM Core Options"
L.EnableMiniMapIcon					= "Show minimap button"
L.EnableCompartmentIcon				= "Show compartment button"
L.UseSoundChannel					= "Set audio channel used by DBM to play alert sounds"
L.UseMasterChannel					= "Master audio channel."
L.UseDialogChannel					= "Dialog audio channel."
L.UseSFXChannel						= "Sound Effects (SFX) audio channel."
L.Latency_Text						= "Set max latency sync threshold: %d"

L.Button_RangeFrame					= "Show/hide range frame"
L.Button_InfoFrame					= "Show/hide info frame"
L.Button_TestBars					= "Start test bars"
L.Button_MoveBars					= "Move bars"
L.Button_ResetInfoRange				= "Reset Info/Range frames"

L.ModelOptions						= "3D Model Viewer Options"
L.EnableModels						= "Enable 3D models in boss options"
L.ModelSoundOptions					= "Set sound option for model viewer"
L.ModelSoundShort					= SHORT
L.ModelSoundLong					= TOAST_DURATION_LONG

L.ResizeOptions			 			= "Resize Options"
L.ResizeInfo						= "You can resize the GUI by clicking the bottom-right corner, and dragging."
L.Button_ResetWindowSize			= "Reset GUI window size"
L.Editbox_WindowWidth				= "GUI window width"
L.Editbox_WindowHeight				= "GUI window height"

L.UIGroupingOptions					= "UI Grouping Options (changing these require UI reload for any mod that's already loaded)"
L.GroupOptionsExcludeIcon			= "Exclude 'Set Icon' options from getting grouped by spell (they will be grouped together in their own 'Icons' category instead)"
L.GroupOptionsExcludePrivateAura	= "Exclude 'Private Aura' sound options from getting grouped by spell (they will be grouped together in their own 'Private Auras' category instead)"
L.AutoExpandSpellGroups				= "Auto expand options that are grouped by spell"
L.ShowWAKeys						= "Show WeakAuras keys next to spell names to assist in writing WeakAuras using Boss Mod triggers."
--L.ShowSpellDescWhenExpanded		= "Continue showing spell description when groups are expanded"--Might not be used
L.NoDescription						= "This ability has no description"
L.CustomOptions						= "This category contains custom options for an ability or event that has no spell or journal ID of it's own. These options have been grouped together using a custom manual ID for the ease of creating WeakAuras"

--

-- Panel: Auto Logging
L.Panel_AutoLogging					= "Auto Logging"

--Auto Logging: Logging toggles/types
L.Area_AutoLogging					= "Auto Logging Toggles"
L.AutologBosses						= "Automatically record selected content using blizzard combat log"
L.AdvancedAutologBosses				= "Automatically record selected content with Transcriptor"
--Auto Logging: Global filter Options
L.Area_AutoLoggingFilters			= "Auto Logging Filters"
L.RecordOnlyBosses					= "Do not record trash (Only records Bosses. Use '/dbm pull' before bosses to capture pre pull pots &amp; ENCOUNTER_START)"
L.DoNotLogLFG						= "Do not record LFG or LFR (queued content)"
--Auto Logging: Recorded Content types
L.Area_AutoLoggingContent			= "Auto Logging Content"
L.LogCurrentMythicRaids				= "Current level (or remix) Mythic raids"--Retail Only
L.LogCurrentRaids					= "Current level (or remix) non Mythic raids (Heroic, Normal, and LFR if LFG/LFR filter is disabled)"
L.LogTWRaids						= "Timewalking or Chromie Time raids (does NOT include remix)"--Retail Only
L.LogTrivialRaids					= "Trivial (below character level) raids"
L.LogCurrentMPlus					= "Current level (or remix) M+ dungeons"--Retail Only
L.LogCurrentMythicZero				= "Current level (or remix) Mythic 0 dungeons"--Retail Only
L.LogTWDungeons						= "Timewalking or Chromie Time dungeons (does NOT include remix)"--Retail Only
L.LogCurrentHeroic					= "Current level Heroic dungeons (Note: if you are doing heroic via queuing and want it logged, turn off LFG filter)"

-- Panel: Extra Features
L.Panel_ExtraFeatures				= "Extra Features"

L.Area_SoundAlerts					= "Sound/Flash Alert Options"
L.LFDEnhance						= "Play ready check sound and flash application icon for role checks &amp; BG/LFG proposals in Master or Dialog audio channel (I.E. sounds work even if SFX are off and are generally louder)"
L.WorldBossNearAlert				= "Play ready check sound and flash application icon when world bosses you are near to are pulled that you need"
L.RLReadyCheckSound					= "When a ready check is performed, play sound through Master or Dialog audio channel and flash application icon."
L.AutoReplySound					= "Play alert sound and flash application icon when receiving DBM auto reply whisper"

L.Area_CombatAlerts					= "Combat Alert Options"
L.AFKHealthWarning					= "Play alert sound and flash application icon if you are losing health (at any percent) while AFK flag present"
L.HealthWarningLow					= "Play alert sound and flash application icon if you are losing health (while below 35 percent)"
L.EnteringCombatAlert				= "Play alert sound and flash application icon when you enter combat"
L.LeavingCombatAlert				= "Play alert sound when you leave combat"
--
L.TimerGeneral 						= "Timer Options"
L.SKT_Enabled						= "Show record victory timer for current fight if available"
L.ShowRespawn						= "Show boss respawn timer after a wipe"
L.ShowQueuePop						= "Show time remaining to accept a queue pop (LFG,BG,etc)"
L.ShowBerserkWarnings				= "Show announcements at 10/5/3/1 minutes and at 30/10 seconds remaining on $spell:26662 timer"
--
L.Area_3rdParty						= "3rd Party Addon Options"
L.oRA3AnnounceConsumables			= "Announce oRA3 consumables check on combat start"
L.Area_Invite						= "Invite Options"
L.AutoAcceptFriendInvite			= "Automatically accept group invites from friends"
L.AutoAcceptGuildInvite				= "Automatically accept group invites from guild members"
L.Area_Advanced						= "Advanced Options"
L.FakeBW							= "Pretend to be BigWigs in version checks instead of DBM (Useful for guilds that force using BigWigs)"

-- Panel: Profiles
L.Panel_Profile						= "Profiles"
L.Area_CreateProfile				= "Profile Creation for DBM Core Options"
L.EnterProfileName					= "Enter profile name"
L.CreateProfile						= "Create new profile with default settings"
L.Area_ApplyProfile					= "Set Active Profile for DBM Core Options"
L.SelectProfileToApply				= "Select profile to apply"
L.Area_CopyProfile					= "Copy profile for DBM Core Options"
L.SelectProfileToCopy				= "Select profile to copy"
L.Area_DeleteProfile				= "Remove Profile for DBM Core Options"
L.SelectProfileToDelete				= "Select profile to delete"
L.Area_DualProfile					= "Boss mod profile options"
L.DualProfile						= "Enable support for different boss mod options per spec. (Managing of boss mod profiles is done from loaded boss mod stats screen)"

L.Area_ModProfile					= "Copy mod settings from another char/spec or delete mod settings"
L.ModAllReset						= "Reset all mod settings"
L.ModAllStatReset					= "Reset all mod stats"
L.SelectModProfileCopy				= "Copy all settings from"
L.SelectModProfileCopySound			= "Copy just sound setting from"
L.SelectModProfileCopyNote			= "Copy just note setting from"
L.SelectModProfileDelete			= "Delete mod settings for"

L.Area_ImportExportProfile			= "Import/Export profiles"
L.ImportExportInfo					= "Importing will overwrite your current profile, do at your own risk."
L.ButtonImportProfile				= "Import profile"
L.ButtonExportProfile				= "Export profile"

L.ImportErrorOn						= "Custom sounds missing for setting: %s"
L.ImportVoiceMissing				= "Missing voice pack: %s"

-- Tab: Alerts
L.TabCategory_Alerts	 			= "Alerts"
L.Area_SpecAnnounceConfig			= "Special Announce visuals and sound guide"
L.Area_SpecAnnounceNotes			= "Special Announce Notes guide"
L.Area_VoicePackInfo				= "Information on DBM Voice Packs"

-- Panel: Raidwarning
L.Tab_RaidWarning 					= "Announcements"
L.RaidWarning_Header				= "Announce Options"
L.RaidWarnColors 					= "Announce Colors"
L.RaidWarnColor_1 					= "Color 1"
L.RaidWarnColor_2 					= "Color 2"
L.RaidWarnColor_3		 			= "Color 3"
L.RaidWarnColor_4 					= "Color 4"
L.InfoRaidWarning					= [[You can specify the position and colors of the raid warning frame.
This frame is used for messages like "Player X is affected by Y".]]
L.ColorResetted 					= "The color settings of this field have been reset."
L.ShowWarningsInChat 				= "Show announcements in chat frame"
L.WarningIconLeft 					= "Show icon on left side"
L.WarningIconRight 					= "Show icon on right side"
L.WarningIconChat 					= "Show icons in chat frame"
L.WarningAlphabetical				= "Sort names alphabetically"
L.Warn_Duration						= "Announcement duration: %0.1f sec"
L.None								= "None"
L.Random							= "Random"
L.Outline							= "Outline"
L.ThickOutline						= "Thick outline"
L.MonochromeOutline					= "Monochrome outline"
L.MonochromeThickOutline			= "Monochrome thick outline"
L.RaidWarnSound						= "Play sound on raid announcement"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame				= "Special Announcements"
L.Area_SpecWarn						= "Special Announce Options"
L.SpecWarn_ClassColor				= "Use class coloring for special announcements"
L.ShowSWarningsInChat 				= "Show special announcements in chat frame"
L.SWarnNameInNote					= "Use Type 5 options if a special announce note contains your name"
L.SpecialWarningIcon				= "Show icons on special announcements"
L.ShortTextSpellname				= "Use shorter spellname text (when available)"
L.SpecWarn_FlashFrameRepeat			= "Flash %d times(s)"
L.SpecWarn_Flash					= "Flash screen"
L.SpecWarn_Vibrate					= "Vibrate controller"
L.SpecWarn_FlashRepeat				= "Repeat Flash"
L.SpecWarn_FlashColor				= "Flash color %d"
L.SpecWarn_FlashDur					= "Flash duration: %0.1f"
L.SpecWarn_FlashAlpha				= "Flash alpha: %0.1f"
L.SpecWarn_DemoButton				= "Show example"
L.SpecWarn_ResetMe					= "Reset to defaults"
L.SpecialWarnSoundOption			= "Set default sound"
L.SpecialWarnHeader1				= "Type 1: Set options for normal priority announcements affecting you or your actions"
L.SpecialWarnHeader2				= "Type 2: Set options for normal priority announcements affecting everyone"
L.SpecialWarnHeader3				= "Type 3: Set options for HIGH priority announcements"
L.SpecialWarnHeader4				= "Type 4: Set options for HIGH priority run away special announcements"
L.SpecialWarnHeader5				= "Type 5: Set options for announcements with notes containing your player name"

-- Panel: Generalwarnings
L.Tab_GeneralMessages 				= "Chat Frame Messages"
L.SelectChatFrameArea				= "Chat Frame Options"
L.SelectChatFrameButton				= "Select chat frame"
L.SelectChatFrameInfoIdle			= "Messages are shown in %s."
L.SelectChatFrameDefaultName		= "the default chat frame"
L.SelectChatFrameInfoDone			= "Messages will be shown in this chat frame."
L.SelectChatFrameInfoSelect			= "Click on a chat frame to select it."
L.SelectChatFrameInfoSelectNow		= "Click to select %s."
L.CoreMessages						= "Core Message Options"
L.ShowPizzaMessage 					= "Show timer broadcast messages in chat frame"
L.ShowAllVersions	 				= "Show boss mod versions for all group members in chat frame when doing a version check. (If disabled, still does out of date/current summery)"
L.ShowReminders						= "Show reminder messages for missing sub-mods, disabled sub-mods, sub-mod hotfixes, out of date sub-mods, and silent mode still being enabled"

L.CombatMessages					= "Combat Message Options"
L.ShowEngageMessage 				= "Show engage messages in chat frame"
L.ShowDefeatMessage 				= "Show kill/wipe messages in chat frame"
L.ShowGuildMessages 				= "Show engage/kill/wipe messages for guild raids in chat frame"
L.ShowGuildMessagesPlus				= "Also show Mythic+ engage/kill/wipe messages for guild groups (requires raid option)"

L.Area_ChatAlerts					= "Additional Alert Options"
L.RoleSpecAlert						= "Show alert message on raid join when your loot spec does not match current spec"
L.CheckGear							= "Show gear alert message during pull (when your equipped ilvl is much lower than bag ilvl (40+) or main weapon is not equipped)"
L.WorldBossAlert					= "Show alert message when world bosses might have been engaged on your realm by guildies or friends (inaccurate if sender is CRZed)"
L.WorldBuffAlert					= "Show alert message and timer when world buff RP has been started on your realm (Disabled in SOD)"

L.Area_BugAlerts					= "Bug Reporting Alert Options"
L.BadTimerAlert						= "Show chat message when DBM detects a bad timer with at least 1 second of incorrectness"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts				= "Countdowns & Voice Packs"
L.Area_VoiceSelection				= "Voice Selections"
L.CountdownVoice					= "Set primary voice for count sounds"
L.CountdownVoice2					= "Set secondary voice for count sounds"
L.CountdownVoice3					= "Set tertiary voice for count sounds"
L.PullVoice							= "Set voice for pull timers"
L.VoicePackChoice					= "Set voice pack for spoken alerts"
L.MissingVoicePack					= "Missing Voice Pack (%s)"
L.Area_CountdownOptions				= "Countdown Options"
L.Area_VoicePackReplace				= "Voice Pack Replacement Options (which sounds voice packs, when enabled, mute and replace)"
L.VPReplaceNote						= "Note: Voice packs never change or remove your warning sounds.\nThey are simply muted when voice pack replaces them."
L.ReplacesAnnounce					= "Replace Announce sounds (Note: Very few use voice packs except for phase changes and adds"
L.ReplacesSADefault					= "Replace Default Special Announce sounds (Custom user set sounds will never be replaced)"
L.Area_VoicePackAdvOptions			= "Voice Pack Advanced Options"
L.Area_VPLearnMore					= "Learn more about voice packs and how to use these options"
L.VPLearnMore						= "|cFF73C2FBhttps://github.com/DeadlyBossMods/DBM-Retail/wiki/%5BGuide%5D-DBM-&-Voicepacks#2022-update|r" -- OPTIONAL
L.Area_BrowseOtherVP				= "Browse other voice packs on curse"
L.BrowseOtherVPs					= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r" -- OPTIONAL
L.Area_BrowseOtherCT				= "Browse countdown packs on curse"
L.BrowseOtherCTs					= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r" -- OPTIONAL

-- Panel: Event Sounds
L.Panel_EventSounds					= "Event Sounds (Victory, Wipe, etc)"
L.Area_SoundSelection				= "Sound Selections for Victory, Wipe, Pull, and background music"
L.EventVictorySound					= "Set sound played for encounter victory"
L.EventWipeSound					= "Set sound played for encounter wipe"
L.EventEngagePT						= "Set sound played for pull timer start"
L.EventEngageSound					= "Set sound played for encounter engage"
L.EventDungeonMusic					= "Set music played inside dungeons/raids"
L.EventEngageMusic					= "Set music played during encounters"
L.Area_EventSoundsExtras			= "Event Sound Options"
L.EventMusicCombined				= "Allow all music choices in dungeon and encounter selections (changing this option requires UIReload to reflect changes)"
L.DisableBuiltInMusic				= "Disable built in event sounds music and only load 3rd party music packs"
L.Area_EventSoundsFilters			= "Event Sound Filter Conditions"
L.EventFilterDungMythicMusic		= "Do not play dungeon music on Mythic/Mythic+ difficulty"
L.EventFilterMythicMusic			= "Do not play encounter music on Mythic/Mythic+ difficulty"

-- Tab: Timers
L.TabCategory_Timers				= "Timer Bars"
L.Area_ColorBytype					= "Color bars by type guide"
-- Panel: Color by Type
L.Panel_ColorByType	 				= "Bar Colors"
L.AreaTitle_BarColors				= "Normal Bar Colors (Defaults are assigned by ability type)"
L.AreaTitle_ImpBarColors			= "Important Bar Colors (These are bars set important by user)"
L.BarTexture						= "Bar texture"
L.BarStyle							= "Bar behavior"
L.BarDBM							= "Classic (existing small bar slides to Enlarged anchor)"
L.BarSimple							= "Simple (small bar disappears and new large bar created)"
L.BarStartColor						= "Start color"
L.BarEndColor 						= "End color"
L.Bar_Height						= "Bar height: %d"
L.Slider_BarOffSetX 				= "Offset X: %d"
L.Slider_BarOffSetY 				= "Offset Y: %d"
L.Slider_BarWidth 					= "Bar width: %d"
L.Slider_BarScale 					= "Bar scale: %0.2f"
L.BarSaturation						= "Bar saturation for small timers (When huge bars are disabled): %0.2f"

--Types
L.BarStartColorAdd					= "Start color 1 (Add)"
L.BarEndColorAdd					= "End color 1 (Add)"
L.BarStartColorAOE					= "Start color 2 (AOE)"
L.BarEndColorAOE					= "End color 2 (AOE)"
L.BarStartColorDebuff				= "Start color 3 (Targeted)"
L.BarEndColorDebuff					= "End color 3 (Targeted)"
L.BarStartColorInterrupt			= "Start color 4 (Interrupt)"
L.BarEndColorInterrupt				= "End color 4 (Interrupt)"
L.BarStartColorRole					= "Start color 5 (Role)"
L.BarEndColorRole					= "End color 5 (Role)"
L.BarStartColorPhase				= "Start color 6 (Stage)"
L.BarEndColorPhase					= "End color 6 (Stage)"
L.BarStartColorUI					= "Start color 7 (Important)"
L.BarEndColorUI						= "End color 7 (Important)"
L.BarStartColorI2					= "Start color 8 (Important)"
L.BarEndColorI2						= "End color 8 (Important)"
--Type 7 options
L.Bar7Header						= "Important Bar Options"
L.Bar7ForceLarge					= "Always use large bar"
L.Bar7CustomInline					= "Use custom '!' inline icon"
--Timer Example Texts
L.CBTGeneric						= "Generic"
L.CBTAdd							= "Adds Incoming"
L.CBTAOE							= "AOE Spell"
L.CBTTargeted						= "Targeted Spell"
L.CBTInterrupt						= "Interruptable Spell"
L.CBTRole							= "Specific Role Spell"
L.CBTPhase							= "Phase Change"
L.CBTImportant						= "User Important Spell"
--Dropdown Options
--Special Announce Dropdowns
L.SAOne								= "Global Sound 1 (Personal)"
L.SATwo								= "Global Sound 2 (Everyone)"
L.SAThree							= "Global Sound 3 (High Priority Action)"
L.SAFour							= "Global Sound 4 (High Priority Run Away)"
--Timer Dropdowns
L.ColorDropGeneric					= "Generic (Default: Untyped)"
L.ColorDrop1						= "Color 1 (Default: Add)"
L.ColorDrop2						= "Color 2 (Default: AOE)"
L.ColorDrop3						= "Color 3 (Default: Targeted)"
L.ColorDrop4						= "Color 4 (Default: Interrupt)"
L.ColorDrop5						= "Color 5 (Default: Role)"
L.ColorDrop6						= "Color 6 (Default: Stage)"
L.CDDImportant1						= "Important 1 (Non-Defaulted)"
L.CDDImportant2						= "Important 2 (Non-Defaulted)"
--Countdown Dropdowns
L.CVoiceOne							= "Global Countdown 1"
L.CVoiceTwo							= "Global Countdown 2"
L.CVoiceThree						= "Global Countdown 3"

-- Panel: Bar Appearance
L.Panel_Appearance	 				= "Bar Appearance"
L.Panel_Behavior	 				= "Bar Behavior"
L.AreaTitle_BarSetup				= "Bar Appearance Options"
L.AreaTitle_Behavior				= "Bar Behavior Options"
L.AreaTitle_BarSetupSmall 			= "Small Bar Options"
L.AreaTitle_BarSetupHuge			= "Huge Bar Options"
L.AreaTitle_BarSetupVariance		= "Variance Bar Options"
L.EnableHugeBar 					= "Enable huge bar (aka Bar 2)"
L.EnableVarianceBar 				= "Enable variance bars"
L.VarianceTransparency				= "Bar transparency: %0.1f"
L.VarianceTimerTextBehavior			= "Set variance timer text behavior"
L.ZeroatWindowEnds					= "Text hits zero at end of CD window"
L.ZeroatWindowStartPause			= "Text hits zero at start of CD window and pauses"
L.ZeroatWindowStartRestart			= "Text hits zero at start of CD window then restarts"
L.ZeroatWindowStartNeg				= "Text hits zero at start of CD window then goes negative"--Default
L.BarIconLeft 						= "Left icon"
L.BarIconRight 						= "Right icon"
L.ExpandUpwards						= "Expand upward"
L.FillUpBars						= "Fill up"
L.ClickThrough						= "Disable mouse events (click through)"
L.Bar_Decimal						= "Decimal shows below time: %d"
L.Bar_Alpha							= "Alpha: %0.1f"
L.Bar_EnlargeTime					= "Bar enlarges below time: %d"
L.BarSpark							= "Bar spark"
L.BarFlash							= "Flash bar about to expire"
L.BarSort							= "Sort by remaining time"
L.BarColorByType					= "Color by type"
L.Highest							= "Highest at top"
L.Lowest							= "Lowest at top"
L.NoBarFade							= "Use Start/End colors as Small/Large colors instead of gradual color change"
L.BarInlineIcons					= "Show inline icons"
L.DisableRightClickBar				= "Disable right click to cancel timers"
L.ShortTimerText					= "Use short timer text (when available)"
L.KeepBar							= "Keep timer active until ability cast"
L.KeepBar2							= "(when supported by mod)"
L.FadeBar							= "Fade timers for out of range abilities"
L.BarSkin							= "Bar skin"

-- Panel: Pull, Break, Combat
L.Panel_PullBreakCombat				= "Pull & Break"

L.Area_SoundOptions					= "Sound Options"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 			= "Global Disables & Filters"
L.Area_DBMFiltersSetup				= "DBM Filters guide"
L.Area_BlizzFiltersSetup			= "Blizzard Filters guide"

-- Panel: Toggle DBM Features
L.Panel_SpamFilter					= "Disable DBM Features"

L.Area_SpamFilter_SpecFeatures		= "Announce Features"
L.SpamBlockNoShowAnnounce			= "Do not show text or play sound for ANY general (non emphasized) announcements"
L.SpamBlockNoSpecWarnText			= "Do not show special announce text"
L.SpamBlockNoSpecWarnFlash			= "Do not show special announce screen flash"
L.SpamBlockNoSpecWarnVibrate		= "Do not vibrate controller on special announce"
L.SpamBlockNoSpecWarnSound			= "Do not play special announce sounds (voice packs sounds enabled in Countdowns &amp; Voice Packs panel will still play)"
L.SpamBlockNoPrivateAuraSound		= "Do not register private aura sounds"

L.Area_SpamFilter_Timers			= "Timer Features"
L.SpamBlockNoShowBossTimers			= "Do not show timers for dungeon/raid bosses"
L.SpamBlockNoShowTrashTimers		= "Do not show timers for dungeon/raid trash (Note: this also disables nameplate CDs)"
L.SpamBlockNoShowEventTimers		= "Do not show timers for events or prompts (Queue pop, boss respawn, etc)"
L.SpamBlockNoShowUTimers			= "Do not show user sent timers (Custom/Pull/Break)"
L.SpamBlockNoCountdowns				= "Do not play countdown sounds"

L.Area_SpamFilter_Nameplates		= "Nameplate Features"
L.SpamBlockNoNameplate				= "Do not show nameplate only icons for special boss mechanics (ie buffs or debuffs on enemies)"
L.SpamBlockNoNameplateCD			= "Do not show nameplate only cooldown timer icons for abilities"
L.SpamBlockNoNameplateCasts			= "Do not show nameplate only cast timer icons for abilities"
L.SpamBlockNoBossGUIDs				= "Do not show nameplate cooldown timer icons for abilities that also have timers\n(Usually applies to dungeon bosses)"
L.AlwaysKeepNPs						= "Keep expired nameplate cooldown timer icons visible until ability is recast"

L.Area_SpamFilter_Misc				= "Misc Features"
L.SpamBlockNoSetIcon				= "Do not automatically set icons on targets"
L.SpamBlockNoRangeFrame				= "Do not automatically show range frame"
L.SpamBlockNoInfoFrame				= "Do not automatically show info frame"
L.SpamBlockNoHudMap					= "Do not show HudMap"
L.SpamBlockNoYells					= "Do not send chat yells"
L.SpamBlockNoNoteSync				= "Do not accept shared notes"
L.SpamBlockAutoGossip				= "Do not automatically handle gossip dialogs"

L.Area_Restore						= "DBM Restore Options (Whether DBM restores previous user state when mods finish)"
L.SpamBlockNoIconRestore			= "Do not save icon states and restore them on combat end"
L.SpamBlockNoRangeRestore			= "Do not restore range frame to previous state when mods call 'hide'"

L.Area_PullTimer					= "Pull, Break, & Custom Timer Filter Options"
L.DontShowPTNoID					= "Block DBM Pull Timers if not sent from same zone as you"
L.DontShowPT						= "Do not show Pull/Break Timer bar"
L.DontShowPTText					= "Do not show announce text for Pull/Break Timer"
L.DontPlayPTCountdown				= "Do not play Pull/Break/Custom Timer countdown audio at all"
L.PT_Threshold						= "Do not play Pull/Break/Custom Timer countdown audio above: %d"

-- Panel: Reduce Information
L.Panel_ReducedInformation			= "Reduce Information"

L.Area_SpamFilter_Anounces			= "Announce Filters/De-escalation"
L.SpamBlockNoShowTgtAnnounce		= "Do not show text or play sound for TARGET general announcements that do not affect yourself, expect where noted that specific warning ignores this filter (global disable in DBM Features overrides this one)"
L.SpamBlockNoTrivialSpecWarnSound	= "Do not play special announce sounds or show screen flash for content that is trivial for your level (plays user selected non emphasized announce sound instead)"

L.Area_SpamFilter					= "Spam Filter Options"
L.DontShowFarWarnings				= "Do not show announcements/timers for events that are far away"
L.StripServerName					= "Strip realm name from announcements, timers, range check, and infoframe"
L.FilterVoidFormSay2				= "Do not send chat icon or countdown chat yells when in Void Form (regular chat yells still sent)"

L.Area_SpecFilter					= "Role Filter Options"
L.FilterDispels						= "Do not show announcements for dispelable spells if your dispel is on cooldown"
L.FilterCrowdControl				= "Do not show announcements for crowd control based interrupts if your CC is on cooldown"
L.FilterTrashWarnings				= "Do not show any trash mob announcements in follower, normal, and trivial (outleveled) dungeons"

L.Area_BInterruptFilter				= "Boss Interrupt Filter Options"
L.FilterTargetFocus					= "Do not show if caster is not current target/focus/softenemy"
L.FilterInterruptCooldown			= "Do not show if interrupt spell is on cooldown"
L.FilterInterruptHealer				= "Do not show if you're in a healer spec"
L.FilterInterruptNoteName			= "Do not show if alert has a count but your name isn't in the custom note"--Only used on bosses, trash mods don't assign counts
L.Area_BInterruptFilterFooter		= "If no filters are selected, all interrupts are shown (May be spammy)\nSome mods may ignore these filters entirely if spell is critically important"
L.Area_TInterruptFilter				= "Trash Interrupt Filter Options"--Reuses above 3 strings

-- Panel: DBM Handholding
L.Panel_HandFilter					= "Reduce DBM Handholding"
L.Area_SpamFilter_SpecRoleFilters	= "Special Announce Type Filters (control how much handholding DBM does)"
L.SpamSpecInformationalOnly			= "Change all instructional text/voice pack alerts from special announcements (Requires UI Reload). Alerts still show and play audio but will be generic and less directive"
L.SpamSpecRoleDispel				= "Do not show 'dispel' alerts (No text or sound at all)"
L.SpamSpecRoleInterrupt				= "Do not show 'interrupt' alerts (No text or sound at all)"
L.SpamSpecRoleDefensive				= "Do not show 'defensive' alerts (No text or sound at all)"
L.SpamSpecRoleTaunt					= "Do not show 'taunt' alerts (No text or sound at all)"
L.SpamSpecRoleSoak					= "Do not show 'soak' alerts (No text or sound at all)"
L.SpamSpecRoleStack					= "Do not show 'high stack' alerts (No text or sound at all)"
L.SpamSpecRoleSwitch				= "Do not show 'target swap' &amp; 'adds' alerts (No text or sound at all)"
L.SpamSpecRoleGTFO					= "Do not show 'gtfo' alerts (No text or sound at all)"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "Block Blizzard Features"
--Toast
L.Area_HideToast					= "Disable blizzard toasts (popups)"
L.HideGarrisonUpdates				= "Hide follower toasts during boss fights"
L.HideGuildChallengeUpdates			= "Hide guild challenge toasts during boss fights"
--L.HideBossKill					= "Hide boss kill toasts"--NYI
--L.HideVaultUnlock					= "Hide vault unlock toasts"--NYI
--Cut Scenes
L.Area_Cinematics					= "Block in-game cinematics"
L.DuringFight						= "Block in combat cut scenes during boss encounters"--uses explicite IsEncounterInProgress check
L.InstanceAnywhere					= "Block non combat cut scenes anywhere inside a dungeon or raid instance"
L.NonInstanceAnywhere				= "DANGER: Block cut scenes in outdoor open world (NOT recommended)"
L.OnlyAfterSeen						= "Only block cut scenes, based on selections above, after they have been seen at least once. (To experience story as intended at least once, this option is strongly recommended)"
--Sound
L.Area_Sound						= "Block in-game sounds"
L.DisableSFX						= "Disable sound effects channel during boss fights"
L.DisableAmbiance					= "Disable ambiance channel during boss fights"
L.DisableMusic						= "Disable music channel during boss fights (Note: If enabled, custom boss music will not play if enabled in event sounds)"
--Other
L.Area_HideBlizzard					= "Disable & Hide other Blizzard Annoyances"
L.HideBossEmoteFrame				= "Hide raid boss emote frame during boss fights"
L.HideWatchFrame					= "Hide watch (objectives) frame during boss fights if no achievements are being tracked and if not in a Mythic+"
L.HideQuestTooltips					= "Hide quest objectives from tooltips during boss fights"--Currently hidden (NYI)
L.HideTooltips						= "Completely hide tooltips during boss fights"

-- Panel: Raid Leader Controls
L.Tab_RLControls					= "Raid Leader Controls"
L.Area_FeatureOverrides				= "Feature Override Options"
L.OverrideIcons 					= "Disable icon marking for all users in raid, including your own"-- (Use override instead of disable if you want DBM to do marking under your terms)
L.OverrideSay						= "Disable chat bubble/SAY messages for all users in the raid, including your own"
L.DisableStatusWhisperShort			= "Disable status/reply whispers for the entire group"--Duplicated from privacy but makes sense to include option in both panels
L.DisableGuildStatusShort			= "Disable progression messages from being synced to guild for the entire group"--Duplicated from privacy but makes sense to include option in both panels
--L.DisabledForDropdown				= "Choose boss mod(s) disable is sent to"--NYI
--L.DiabledForBoth					= "Disable above features for both DBM and BW"--NYI
--L.DiabledForDBM					= "Disable above features for only DBM users"--NYI
--L.DiabledForBW					= "Disable above features for only BW users"--NYI

L.Area_ConfigOverrides				= "Configuration Override Options (NYI, coming later)"--NYI
L.OverrideBossAnnounceOptions		= "Set all DBM users boss mod announce configuration to my configuration"--NYI
L.OverrideBossTimerOptions			= "Set all DBM users boss mod timer configuration to my configuration"--NYI
L.OverrideBossIconOptions			= "Set all DBM users boss mod icon configuration to my configuration (if icon setting is disabled in above options, this option is ignored)"--NYI
L.OverrideBossSayOptions			= "Set all DBM users boss mod chat bubble configuration to my configuration (if chat bubble setting is disabled in above options, this option is ignored)"--NYI
L.ConfigAreaFooter					= "Options in this area only temporariliy override users configuration on engage without altering their saved configuration."
L.ConfigAreaFooter2					= "Recommended to consider all roles and do not exclude timers/alerts a tank, etc might need"

L.Area_receivingOptions				= "Receiving Options (NYI, coming later)"--NYI
L.NoAnnounceOverride				= "Do not accept announce overrides from raid leaders."--NYI
L.NoTimerOverridee					= "Do not accept timer overrides from raid leaders."--NYI
L.ReplaceMyConfigOnOverride			= "WARNING: Perminantly replace my mod configurations with Raid leaders, on override"--NYI
L.ReceivingFooter					= "Icon and chat bubble option overrides cannot be opted out since these settings affect other players around you"--NYI
L.ReceivingFooter2					= "If you enable these options, it's between you and RL if your configuration causes conflict with their intent"--NYI
L.ReceivingFooter3					= "If you enable the 'replace my mod configuration' your original settings will be lost on override"--NYI


L.TabFooter							= "All options in this panel only work if you are group leader in a non dungeon/LFR group"

-- Panel: Privacy
L.Tab_Privacy 						= "Auto Reply & Privacy"
L.Area_WhisperMessages				= "Whisper Message Options"
L.AutoRespond 						= "Auto-respond to whispers while fighting"
L.WhisperStats 						= "Include kill/wipe stats in whisper responses"
L.DisableStatusWhisper 				= "Disable status whispers for the entire group (requires Group Leader). Applies only to normal/heroic/mythic raids and mythic+ dungeons"
L.Area_SyncMessages					= "Addon Sync Options"
L.DisableGuildStatus 				= "Disable progression messages from being synced to guild. If group leader, this disables it for all DBM users in your group"
L.EnableWBSharing 					= "Share when you pull/defeat a world boss with your guild and your battle.net friends that are on same realm."

-- Tab: Frames & Integrations
L.TabCategory_Frames				= "Frames & Integrations"
L.Area_NamelateInfo					= "DBM Nameplate Auras Info"
-- Panel: InfoFrame
L.Panel_InfoFrame					= "Infoframe"

-- Panel: Range
L.Panel_Range						= "Rangeframe"

-- Panel: Nameplate
L.Panel_Nameplates					= "Nameplates"
L.Plater_Config						= "Open Plater Config"
L.Area_NPStyle						= "Style (Note: Only configures style when not using Plater.)"
L.NPAuraText						= "Show timer text on nameplate icons"
L.NPAuraSize						= "Icon Pixel size (squared): %d"
L.NPIcon_BarOffSetX 				= "Icon Offset X: %d"
L.NPIcon_BarOffSetY 				= "Icon Offset Y: %d"
L.NPIcon_GrowthDirection 			= "Icon Growth Direction"
L.NPIcon_Spacing		 			= "Icon Spacing: %d"
L.NPIcon_MaxTextLen		 			= "Max. Text Length: %d"
L.NPIconAnchorPoint		 			= "Icon Anchor Point"
L.NPDemo							= "Test (Be near nameplates)"
L.FontTypeTimer						= "Select timer font"
L.FontTypeText						= "Select text font"

L.Area_NPGlow						= "Glow (Note: Only configures glow when not using Plater.)"
L.NPIcon_GlowBehavior				= "Cooldown Icon Glow Behavior"
L.NPIcon_CastGlowBehavior			= "Cast Icon Glow Behavior"
L.NPIcon_GlowNone					= "Never Glow Icons"
L.NPIcon_GlowImportant				= "Glow important expiring CD/Cast Icons"
L.NPIcon_GlowAll					= "Glow all expiring CD/Cast Icons"
L.NPIcon_GlowTypeCD					= "Cooldown Icon Glow Type"
L.NPIcon_GlowTypeCast				= "Cast Icon Glow Type"
L.NPIcon_Pixel						= "Pixel"
L.NPIcon_Proc						= "Proc (Visual Bug on first session Appearance)"
L.NPIcon_AutoCast					= "Auto Cast"
L.NPIcon_Button						= "Button"

-- Misc
L.Area_General						= "General"
L.Area_Position						= "Position"
L.Area_Style						= "Style"

L.FontSize							= "Font size: %d"
L.FontStyle							= "Font flags"
L.FontColor							= "Font color"
L.FontShadow						= "Font Shadow"
L.FontType							= "Select font"

L.FontHeight	= 16 -- OPTIONAL



-- Testing
L.DevPanel							= "Development & Testing"
L.DevPanelArea						= "Development and Testing UI"
L.DevPanelExplanation				= "This is a development and testing UI which validates that DBM is working as expected by playing back combat logs." -- Test UI panel under options
L.DevModPanelExplanation			= [[Welcome to the development and testing playground for this mod.
You can play back logs of boss fights here to see how the mod behaves and to test integrations with DBM callbacks. See DBM-Test/README.md for more details on integrations and callbacks. DBM comes with example logs for many raids, but you can also import your own logs from Transcriptor.
]] -- Playground mode in mods

L.TimewarpSetting					= "Time warp: %dx"
L.TimewarpDynamic					= "Time warp: dynamic (fastest)"
L.TestSupportArea					= "Mod loading options"
L.ModNotLoadedWithTests				= "Warning: This mod is currently not loaded with full test support. If the mod directly calls API functions such as UnitHealth() or UnitName() these will not work correctly. This is often the case for functions related to unit health, power, or targets."
L.ModLoadedWithTests				= "Mod is currently loaded with test support because at least one mod in the addon has tests enabled."
L.AlwaysLoadModWithTests			= "Always load this mod with full test support (slows down loading slightly)"
L.ModLoadRequiresReload				= ", requires UI reload to take effect" -- Appended to L.AlwaysLoadModWithTests
L.TestSelectArea					= "Test data" -- Title of the UI area
L.SelectTestLog						= L.TestSelectArea -- Title for the dropdown to select a  specific test
L.SelectPerspective					= "Log perspective (simulated player)"
L.ImportTranscriptor				= "Import Transcriptor log"
L.ImportTranscriptorHeader			= [[
Import a Transcriptor log by pasting it anywhere in the edit box below. Pasting speed is roughly 2 MiB/s, this means your game will freeze for several seconds when pasting very large log files.
You can also import the current Transcriptor session from Transcriptor's saved variables with the import button to the right.]]
L.PasteLogHere						= "Press " .. (IsMacClient() and "Cmd-V" or "Ctrl-V") .. " to paste a log here."
L.LogPasted							= "Pasted %.2f MiB in %.1f seconds (%.2f MiB/s)."
L.ImportLocalTranscriptor			= "Import current\nTranscriptor session"
L.NoLocalTranscriptor				= "Could not find local Transcriptor data."
L.LocalImportDone					= "Imported %d logs with %d encounters from Transcriptor."
L.Parsing							= "Parsing..."
L.SelectLogDropdown					= "Select encounter"
L.CreateTest						= "Create Test"
L.ExportTest						= "Export Test"
L.ExportedTest						= "Exported test case with %d lines (%.1f%% filtered)."
L.ExportedTestFailedAnon			= "WARNING: Log anonymization failed, %d non-anonymized strings found (details in chat frame and output)."
L.ExportTestFailedNonAnonString		= "WARNING: String %q looks non-anonymized."
L.CreatedTest						= "Created test with %d events in %.1f seconds."
L.NoLogsFound						= "Transcriptor import contains no log data."
L.NoTestDataAvailable				= "No test data available"
L.NoLogSelected						= "Test creation failed: No log selected."
L.LogAlreadyImported				= "Test creation failed: Test already imported."

L.RewriteAllToYou					= "All players at the same time"
L.RealModOptionsBelow				= "Mod options below are synced between playground mode and your real settings."
L.Test								= "Test"
L.Tests								= "Tests"
L.AllTests							= "All tests"
L.RunTest							= "Run test"
L.RunTestShort						= "Run" -- Same intend as RunTest, but a smaller button
L.StopTest							= "Stop test"
L.StopTests							= "Stop tests"
L.RunAllTests						= "Run all tests"
L.Queued							= "Queued"
L.Running							= "Running"
L.Failed							= "Failed"
L.ShowReport						= "Show report"
L.ShowErrors						= "Show errors"
L.TestModEntry						= "[Playground] %s"
L.EnterTestMode						= "Playground mode"
L.SkipPhase							= "Skip to next phase"

L.AnonymizeTest						= "Anonymize player names and GUIDs"
L.ShowThisTestEverywhere			= "Show this test for all mods"
L.SaveThisTest						= "Save this test log persistently"

L.BossModTColor						= "Bar Color"
L.BossModCVoice						= "Countdown Voice"
L.BossModSWSound					= "Announce Sound"
