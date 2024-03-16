-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **              https://deadlybossmods.com             **
-- **          https://patreon.com/deadlybossmods         **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author & DBM maintainer)
--
-- The localizations are written by:
--    * enGB/enUS: Omegal				Twitter @MysticalOS
--    * deDE: Ebmor
--    * ruRU: TOM_RUS					https://curseforge.com/profiles/TOM_RUS/
--    * zhTW: Whyv						ultrashining@gmail.com
--    * koKR: Elnarfim					---
--    * zhCN: Mini Dragon				projecteurs@gmail.com
--
--
-- Special thanks to:
--    * Arta
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--    * nBlueWiz (a lot of previous fixes in the koKR localization as well as boss mod work) Contact: everfinale@gmail.com
--
local _, private = ...

local wowVersionString, wowBuild, _, wowTOC = GetBuildInfo()
local testBuild = IsTestBuild()
local isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)
local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isHardcoreServer = C_GameRules and C_GameRules.IsHardcoreActive and C_GameRules.IsHardcoreActive()
local currentSeason = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2) and C_Seasons and C_Seasons.HasActiveSeason() and C_Seasons.GetActiveSeason()
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)
--local isCata = WOW_PROJECT_ID == (WOW_PROJECT_CATA_CLASSIC or 99)--NYI in first build
local isCata = (wowTOC >= 40400) and (wowTOC < 50000)

local DBMPrefix = isClassic and "D5C" or isWrath and "D5WC" or "D5"--D5 will be used for all future classic flavors as well
local DBMSyncProtocol = 1
private.DBMPrefix = DBMPrefix
private.DBMSyncProtocol = DBMSyncProtocol

local L = DBM_CORE_L
local CL = DBM_COMMON_L

-------------------------------
--  Globals/Default Options  --
-------------------------------
local function releaseDate(year, month, day, hour, minute, second)
	hour = hour or 0
	minute = minute or 0
	second = second or 0
	---@format disable
	return second + minute * 10^2 + hour * 10^4 + day * 10^6 + month * 10^8 + year * 10^10
end

local function parseCurseDate(date)
	date = tostring(date)
	if #date == 13 then
		-- support for broken curse timestamps: leading 0 in hours is missing...
		date = date:sub(1, 8) .. "0" .. date:sub(9, #date)
	end
	local year, month, day, hour, minute, second = tonumber(date:sub(1, 4)), tonumber(date:sub(5, 6)), tonumber(date:sub(7, 8)), tonumber(date:sub(9, 10)), tonumber(date:sub(11, 12)), tonumber(date:sub(13, 14))
	if year and month and day and hour and minute and second then
		return releaseDate(year, month, day, hour, minute, second)
	end
end

local function showRealDate(curseDate)
	curseDate = tostring(curseDate)
	local year, month, day, hour, minute, second = curseDate:sub(1, 4), curseDate:sub(5, 6), curseDate:sub(7, 8), curseDate:sub(9, 10), curseDate:sub(11, 12), curseDate:sub(13, 14)
	if year and month and day and hour and minute and second then
		return year .. "/" .. month .. "/" .. day .. " " .. hour .. ":" .. minute .. ":" .. second
	end
end

---@class DBM
local DBM = {
	Revision = parseCurseDate("@project-date-integer@"),
}
_G.DBM = DBM

local fakeBWVersion, fakeBWHash = 324, "a4b080f"--324.4
local bwVersionResponseString = "V^%d^%s"
local PForceDisable
-- The string that is shown as version
if isRetail then
	DBM.DisplayVersion = "10.2.30 alpha"
	DBM.ReleaseRevision = releaseDate(2024, 3, 15) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
	PForceDisable = 10--When this is incremented, trigger force disable regardless of major patch
elseif isClassic then
	DBM.DisplayVersion = "1.15.21 alpha"
	DBM.ReleaseRevision = releaseDate(2024, 3, 15) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
	PForceDisable = 6--When this is incremented, trigger force disable regardless of major patch
elseif isBCC then
	DBM.DisplayVersion = "2.6.0 alpha"--When TBC returns (and it will one day). It'll probably be game version 2.6
	DBM.ReleaseRevision = releaseDate(2024, 1, 9) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
	PForceDisable = 3--When this is incremented, trigger force disable regardless of major patch
elseif isCata then
	DBM.DisplayVersion = "4.4.0 alpha"
	DBM.ReleaseRevision = releaseDate(2024, 3, 5) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
	PForceDisable = 5--When this is incremented, trigger force disable regardless of major patch
elseif isWrath then
	DBM.DisplayVersion = "3.4.64 alpha"
	DBM.ReleaseRevision = releaseDate(2024, 3, 15) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
	PForceDisable = 5--When this is incremented, trigger force disable regardless of major patch
end
DBM.HighestRelease = DBM.ReleaseRevision --Updated if newer version is detected, used by update nags to reflect critical fixes user is missing on boss pulls

-- support for github downloads, which doesn't support curse keyword expansion
-- just use the latest release revision
if not DBM.Revision then
	DBM.Revision = DBM.ReleaseRevision
end

function DBM:ShowRealDate(curseDate)
	return showRealDate(curseDate)
end

function DBM:ReleaseDate(year, month, day, hour, minute, second)
	return releaseDate(year, month, day, hour, minute, second)
end

function DBM:GetTOC()
	return wowTOC, testBuild, wowVersionString, wowBuild
end

-- dual profile setup
local _, playerClass = UnitClass("player")
DBM_UseDualProfile = true
if playerClass == "MAGE" or playerClass == "WARLOCK" or playerClass == "ROGUE" or (not isRetail and playerClass == "HUNTER") then
	DBM_UseDualProfile = false
end
DBM_CharSavedRevision = 2

--Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
local standardFont
if LOCALE_koKR then
	standardFont = "Fonts\\2002.TTF"
elseif LOCALE_zhCN then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif LOCALE_zhTW then
	standardFont = "Fonts\\blei00d.TTF"
elseif LOCALE_ruRU then
	standardFont = "Fonts\\FRIZQT___CYR.TTF"
else
	standardFont = "Fonts\\FRIZQT__.TTF"
end

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turqoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = 566558,--"Sound\\Doodad\\BellTollNightElf.ogg"
	SpecialWarningSound = 569200,--"Sound\\Spells\\PVPFlagTaken.ogg"
	SpecialWarningSound2 = isRetail and 543587 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\UR_Algalon_BHole01.ogg",--"Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg"
	SpecialWarningSound3 = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg",
	SpecialWarningSound4 = not isClassic and 552035 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\HoodWolfTransformPlayer01.ogg",--"Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg"
	SpecialWarningSound5 = 554236,--"Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.ogg"
	ModelSoundValue = "Short",
	CountdownVoice = "Corsica",
	CountdownVoice2 = "Kolt",
	CountdownVoice3 = "Smooth",
	PullVoice = "Corsica",
	ChosenVoicePack2 = (GetLocale() == "enUS" or GetLocale() == "enGB") and "VEM" or "None",
	VPReplacesAnnounce = true,
	VPReplacesSA1 = true,
	VPReplacesSA2 = true,
	VPReplacesSA3 = true,
	VPReplacesSA4 = true,
	VPReplacesGTFO = true,
	VPReplacesCustom = false,
	AlwaysPlayVoice = false,
	VPDontMuteSounds = false,
	EventSoundVictory2 = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg",
	EventSoundWipe = "None",
	EventSoundPullTimer = "None",
	EventSoundEngage2 = "None",
	EventSoundMusic = "None",
	EventSoundDungeonBGM = "None",
	EventSoundMusicCombined = false,
	EventDungMusicMythicFilter = true,
	EventMusicMythicFilter = true,
	Enabled = true,
	ShowWarningsInChat = true,
	ShowSWarningsInChat = true,
	WarningIconLeft = true,
	WarningIconRight = true,
	WarningIconChat = true,
	WarningAlphabetical = true,
	WarningShortText = true,
	StripServerName = true,
	ShowAllVersions = true,
	ShowReminders = true,
	ShowPizzaMessage = true,
	ShowEngageMessage = true,
	ShowDefeatMessage = true,
	ShowGuildMessages = true,
	ShowGuildMessagesPlus = false,
	AutoRespond = true,
	EnableWBSharing = true,
	WhisperStats = false,
	DisableStatusWhisper = false,
	DisableGuildStatus = false,
	DisableRaidIcons = false,
	DisableChatBubbles = false,
	OverrideBossAnnounce = false,
	OverrideBossTimer = false,
	OverrideBossIcon = false,
	OverrideBossSay = false,
	NoAnnounceOverride = true,
	NoTimerOverridee = true,
	ReplaceMyConfigOnOverride = false,
	HideBossEmoteFrame2 = true,
	SWarningAlphabetical = true,
	SWarnNameInNote = true,
	CustomSounds = 0,
	FilterTankSpec = true,
	FilterBTargetFocus = true,
	FilterBInterruptCooldown = true,
	FilterBInterruptHealer = false,
	FilterInterruptNoteName = false,
	FilterTTargetFocus = true,
	FilterTInterruptCooldown = true,
	FilterTInterruptHealer = false,
	FilterDispel = true,
	FilterCrowdControl = true,
	FilterTrashWarnings2 = true,
	FilterVoidFormSay = true,
	AutologBosses = false,
	AdvancedAutologBosses = false,
	RecordOnlyBosses = false,
	DoNotLogLFG = true,
	LogCurrentMythicRaids = true,
	LogCurrentRaids = true,
	LogCurrentMPlus = true,
	LogCurrentMythicZero = false,
	LogCurrentHeroic = false,
	LogTrivialRaids = false,
	LogTWRaids = false,
	LogTrivialDungeons = false,
	LogTWDungeons = false,
	UseSoundChannel = "Master",
	LFDEnhance = true,
	WorldBossNearAlert = false,
	RLReadyCheckSound = true,
	AFKHealthWarning2 = isHardcoreServer and true or false,
	AutoReplySound = true,
	HideObjectivesFrame = true,
	HideGarrisonToasts = true,
	HideGuildChallengeUpdates = true,
	HideTooltips = false,
	DisableSFX = false,
	DisableAmbiance = false,
	DisableMusic = false,
	EnableModels = true,
	GUIWidth = 800,
	GUIHeight = 600,
	GroupOptionsExcludeIcon = false,
	AutoExpandSpellGroups = not isRetail,
	ShowWAKeys = true,
	--ShowSpellDescWhenExpanded = false,
	RangeFrameFrames = "radar",
	RangeFrameUpdates = "Average",
	RangeFramePoint = "CENTER",
	RangeFrameX = 50,
	RangeFrameY = -50,
	RangeFrameSound1 = "none",
	RangeFrameSound2 = "none",
	RangeFrameLocked = false,
	RangeFrameRadarPoint = "CENTER",
	RangeFrameRadarX = 100,
	RangeFrameRadarY = -100,
	InfoFramePoint = "CENTER",
	InfoFrameX = 75,
	InfoFrameY = -75,
	InfoFrameShowSelf = false,
	InfoFrameLines = 0,
	InfoFrameCols = 0,
	InfoFrameFont = "standardFont",
	InfoFrameFontSize = 12,
	InfoFrameFontStyle = "None",
	WarningDuration2 = 1.5,
	WarningPoint = "CENTER",
	WarningX = 0,
	WarningY = 260,
	WarningFont = "standardFont",
	WarningFontSize = 20,
	WarningFontStyle = "None",
	WarningFontShadow = true,
	SpecialWarningDuration2 = 1.5,
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = "standardFont",
	SpecialWarningFontSize2 = 35,
	SpecialWarningFontStyle = "THICKOUTLINE",
	SpecialWarningFontShadow = false,
	SpecialWarningIcon = true,
	SpecialWarningShortText = true,
	SpecialWarningFontCol = {1.0, 0.7, 0.0},--Yellow, with a tint of orange
	SpecialWarningFlashCol1 = {1.0, 1.0, 0.0},--Yellow
	SpecialWarningFlashCol2 = {1.0, 0.5, 0.0},--Orange
	SpecialWarningFlashCol3 = {1.0, 0.0, 0.0},--Red
	SpecialWarningFlashCol4 = {1.0, 0.0, 1.0},--Purple
	SpecialWarningFlashCol5 = {0.2, 1.0, 1.0},--Tealish
	SpecialWarningFlashDura1 = 0.3,
	SpecialWarningFlashDura2 = 0.4,
	SpecialWarningFlashDura3 = 1,
	SpecialWarningFlashDura4 = 0.7,
	SpecialWarningFlashDura5 = 1,
	SpecialWarningFlashAlph1 = 0.3,
	SpecialWarningFlashAlph2 = 0.3,
	SpecialWarningFlashAlph3 = 0.4,
	SpecialWarningFlashAlph4 = 0.4,
	SpecialWarningFlashAlph5 = 0.5,
	SpecialWarningFlash1 = true,
	SpecialWarningFlash2 = true,
	SpecialWarningFlash3 = true,
	SpecialWarningFlash4 = true,
	SpecialWarningFlash5 = true,
	SpecialWarningFlashCount1 = 1,
	SpecialWarningFlashCount2 = 1,
	SpecialWarningFlashCount3 = 3,
	SpecialWarningFlashCount4 = 2,
	SpecialWarningFlashCount5 = 3,
	SpecialWarningVibrate1 = false,
	SpecialWarningVibrate2 = false,
	SpecialWarningVibrate3 = true,
	SpecialWarningVibrate4 = true,
	SpecialWarningVibrate5 = true,
	SWarnClassColor = true,
	ArrowPosX = 0,
	ArrowPosY = -150,
	ArrowPoint = "TOP",
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontShowTargetAnnouncements = true,
	DontShowSpecialWarningText = false,
	DontShowSpecialWarningFlash = false,
	DontDoSpecialWarningVibrate = false,
	DontPlaySpecialWarningSound = false,
	DontPlayPrivateAuraSound = false,
	DontPlayTrivialSpecialWarningSound = true,
	SpamSpecInformationalOnly = false,
	SpamSpecRoledispel = false,
	SpamSpecRoleinterrupt = false,
	SpamSpecRoledefensive = false,
	SpamSpecRoletaunt = false,
	SpamSpecRolesoak = false,
	SpamSpecRolestack = false,
	SpamSpecRoleswitch = false,
	SpamSpecRolegtfo = false,
	DontShowBossTimers = false,
	DontShowTrashTimers = false,
	DontShowEventTimers = false,
	DontShowUserTimers = false,
	DontShowFarWarnings = true,
	DontSetIcons = false,
	DontRestoreIcons = false,
	DontShowRangeFrame = false,
	DontRestoreRange = false,
	DontShowInfoFrame = false,
	DontShowHudMap2 = false,
	UseNameplateHandoff = true,--Power user setting, no longer shown in GUI
	DontShowNameplateIcons = false,
	DontShowNameplateIconsCD = false,
	DontSendBossGUIDs = false,
	NPAuraText = true,
	NPIconSize = 30,
	NPIconXOffset = 0,
	NPIconYOffset = 0,
	NPIconSpacing = 0,
	NPIconGrowthDirection = "CENTER",
	NPIconAnchorPoint = "TOP",
	NPIconTimerEnabled = true,
	NPIconTimerFont = "standardFont",
	NPIconTimerFontStyle = "None",
	NPIconTimerFontSize = 18,
	NPIconTextEnabled = true,
	NPIconTextFont = "standardFont",
	NPIconTextFontStyle = "None",
	NPIconTextFontSize = 10,
	NPIconTextMaxLen = 7,
	DontPlayCountdowns = false,
	DontSendYells = false,
	BlockNoteShare = false,
	DontAutoGossip = false,
	DontShowPT2 = false,
	DontShowPTCountdownText = false,
	DontPlayPTCountdown = false,
	DontShowPTText = false,
	DontShowPTNoID = false,
	PTCountThreshold2 = 5,
	LatencyThreshold = 250,
	oRA3AnnounceConsumables = false,
	SettingsMessageShown = false,
	NewsMessageShown2 = 1,--Apparently varaible without 2 can still exist in some configs (config cleanup of no longer existing variables not working?)
	AlwaysShowSpeedKillTimer2 = false,
	ShowRespawn = true,
	ShowQueuePop = true,
	ShowBerserkWarnings = true,
	HelpMessageVersion = 3,
	MoviesSeen = {},
	HideMovieDuringFight = true,
	HideMovieInstanceAnywhere = true,
	HideMovieNonInstanceAnywhere = false,
	HideMovieOnlyAfterSeen = true,
	LastRevision = 0,
	DebugMode = false,
	DebugLevel = 1,
	DebugSound = true,
	RoleSpecAlert = true,
	CheckGear = true,
	WorldBossAlert = not isRetail,
	WorldBuffAlert = not isRetail,
	BadTimerAlert = false,
	AutoAcceptFriendInvite = false,
	AutoAcceptGuildInvite = false,
	FakeBWVersion = false,
	AITimer = true,
	ShortTimerText = true,
	ChatFrame = "DEFAULT_CHAT_FRAME",
	CoreSavedRevision = 1,
	SilentMode = false,
}

DBM.Mods = {}
DBM.ModLists = {}
local checkDuplicateObjects = {}

------------------------
-- Global Identifiers --
------------------------
DBM_DISABLE_ZONE_DETECTION = newproxy(false)
DBM_OPTION_SPACER = newproxy(false)

--------------
--  Privates  --
--------------
private.modSyncSpam = {}
private.updateFunctions = {}
--Raid Leader Disable variables
private.statusGuildDisabled, private.statusWhisperDisabled, private.raidIconsDisabled, private.chatBubblesDisabled = false, false, false, false

--------------
--  Locals  --
--------------
---@class DBMMod
---@field OnSync fun(self: DBMMod, event: string, ...: string)
local bossModPrototype = {}
local mainFrame = CreateFrame("Frame", "DBMMainFrame")
local playerName = UnitName("player") or error("failed to get player name")
local playerLevel = UnitLevel("player")
local playerRealm = GetRealmName()
local normalizedPlayerRealm = playerRealm:gsub("[%s-]+", "")
local lastCombatStarted = GetTime()
local chatPrefixShort = "<" .. L.DBM .. "> "
local usedProfile = "Default"
local dbmIsEnabled = true
private.dbmIsEnabled = dbmIsEnabled
-- Table variables
local newerVersionPerson, forceDisablePerson, cSyncSender, eeSyncSender, iconSetRevision, iconSetPerson, loadcIds, inCombat, oocBWComms, combatInfo, bossIds, raid, autoRespondSpam, queuedBattlefield, bossHealth, bossNames, bossHealthuIdCache, lastBossEngage, lastBossDefeat = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
-- False variables
local voiceSessionDisabled, targetEventsRegistered, combatInitialized, healthCombatInitialized, watchFrameRestore, questieWatchRestore, bossuIdFound, timerRequestInProgress = false, false, false, false, false, false, false, false
-- Nil variables
local currentSpecID, currentSpecName, currentSpecGroup, pformat, loadOptions, checkWipe, checkBossHealth, checkCustomBossHealth, fireEvent, LastInstanceType, breakTimerStart, AddMsg, delayedFunction, handleSync, savedDifficulty, difficultyText, difficultyIndex, lastGroupLeader
-- 0 variables
local dbmToc, eeSyncReceived, cSyncReceived, showConstantReminder, updateNotificationDisplayed, difficultyModifier, LastGroupSize = 0, 0, 0, 0, 0, 0, 0
local LastInstanceMapID = -1
local SWFilterDisabled = 12

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod or discontinued). These mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM-Battlegrounds", --replaced by DBM-PvP
	"DBM-SiegeOfOrgrimmar",--Block legacy version. New version is "DBM-SiegeOfOrgrimmarV2"
	"DBM-HighMail",
	"DBM-ProvingGrounds-MoP",--Renamed to DBM-ProvingGrounds in 6.0 version since blizzard updated content for WoD
	"DBM-ProvingGrounds",--Renamed to DBM-Challenges going forward to include proving grounds and any new single player challendges of similar design such as mage tower artifact quests
	"DBM-VPKiwiBeta",--Renamed to DBM-VPKiwi in final version.
	"DBM-Suramar",--Renamed to DBM-Nighthold
	"DBM-KulTiras",--Merged to DBM-BfA
	"DBM-Zandalar",--Merged to DBM-BfA
	"DBM-Argus",--Merged into DBM-BrokenIsles mod
	"DBM-GarrisonInvasions",--Merged into DBM-Draenor mod
	"DBM-Azeroth-BfA",--renamed to DBM-BfA
	"DBM-BattlefieldBarrens",--Apparently people are still running this
	"DBM-RaidLeadTools", -- Killed plugin
	"DBM-Party-Classic", -- Renamed to DBM-Party-Vanilla
	--The Culling
	"DBM-Ulduar",--Combined into DBM-Raids-WoTLK
	"DBM-VoA",--Combined into DBM-Raids-WoTLK
	"DBM-ChamberOfAspects",--Combined into DBM-Raids-WoTLK
	"DBM-Coliseum",--Combined into DBM-Raids-WoTLK
	"DBM-EyeOfEternity",--Combined into DBM-Raids-WoTLK
	"DBM-Icecrown",--Combined into DBM-Raids-WoTLK

	"DBM-Onyxia",--Combined into DBM-Raids-WoTLK
	"DBM-Naxx",--Combined into DBM-Raids-WoTLK
	"DBM-ZG", -- Part of Cataclysm party mods on retail, and part on DBM-Raids-BC on classic
	"DBM-AQ20",--Combined into DBM-Raids-Vanilla
	"DBM-AQ40",--Combined into DBM-Raids-Vanilla
	"DBM-BWL",--Combined into DBM-Raids-Vanilla
	"DBM-MC",--Combined into DBM-Raids-Vanilla

	"DBM-Karazhan",--Combined into DBM-Raids-BC
	"DBM-BlackTemple",--Combined into DBM-Raids-BC
	"DBM-Hyjal",--Combined into DBM-Raids-BC
	"DBM-Sunwell",--Combined into DBM-Raids-BC
	"DBM-TheEye",--Combined into DBM-Raids-BC
	"DBM-Serpentshrine",--Combined into DBM-Raids-BC
	"DBM-ZulAman", -- Part of Cataclysm party mods on retail, and merged into DBM-Raids-BC on classic

	"DBM-Raids-Cata",--Combined into DBM-Raids-Cataclysm (otherwise, toc file has issues on cata classic)
	"DBM-BaradinHold",--Combined into DBM-Raids-Cataclysm
	"DBM-BastionTwilight",--Combined into DBM-Raids-Cataclysm
	"DBM-BlackwingDescent",--Combined into DBM-Raids-Cataclysm
	"DBM-DragonSoul",--Combined into DBM-Raids-Cataclysm
	"DBM-Firelands",--Combined into DBM-Raids-Cataclysm
	"DBM-ThroneFourWinds",--Combined into DBM-Raids-Cataclysm

	"DBM-HeartofFear",--Combined into DBM-Raids-MoP
	"DBM-MogushanVaults",--Combined into DBM-Raids-MoP
	"DBM-TerraceofEndlessSpring",--Combined into DBM-Raids-MoP
	"DBM-ThroneofThunder",--Combined into DBM-Raids-MoP
	"DBM-SiegeOfOrgrimmarV2",--Combined into DBM-Raids-MoP

	"DBM-Highmaul",--Combined into DBM-Raids-WoD
	"DBM-BlackrockFoundry",--Combined into DBM-Raids-WoD
	"DBM-HellfireCitadel",--Combined into DBM-Raids-WoD

	"DBM-AntorusBurningThrone",--Combined into DBM-Raids-Legion
	"DBM-EmeraldNightmare",--Combined into DBM-Raids-Legion
	"DBM-Nighthold",--Combined into DBM-Raids-Legion
	"DBM-TombofSargeras",--Combined into DBM-Raids-Legion
	"DBM-TrialofValor",--Combined into DBM-Raids-Legion

	"DBM-Uldir",--Combined into DBM-Raids-BfA
	"DBM-CrucibleofStorms",--Combined into DBM-Raids-BfA
	"DBM-ZuldazarRaid",--Combined into DBM-Raids-BfA
	"DBM-EternalPalace",--Combined into DBM-Raids-BfA
	"DBM-Nyalotha",--Combined into DBM-Raids-BfA

	"DBM-SanctumOfDomination",--Combined into DBM-Raids-Shadowlands
	"DBM-CastleNathria",--Combined into DBM-Raids-Shadowlands
	"DBM-Sepulcher",--Combined into DBM-Raids-Shadowlands

	"DBM-VaultoftheIncarnates",--Combined into DBM-Raids-Dragonflight
	"DBM-Aberrus",--Combined into DBM-Raids-Dragonflight

	"DBM-DMF",--Combined into DBM-WorldEvents
}
if isRetail then
	--Retail doesn't use this folder, classic era, bc, and wrath still do
	table.insert(bannedMods, "DBM-Azeroth")--Merged into DBM-Core events mod.
end

--[InstanceID] = {level,zoneType}
--zoneType: 1 = outdoor, 2 = dungeon, 3 = raid
local instanceDifficultyBylevel
if isRetail then
	instanceDifficultyBylevel = {
		--World
		[0] = {50, 1}, [1] = {50, 1},--Eastern Kingdoms and Kalimdor world events/bosses. These would be warfront and aniversery world bosses, so they'd be set to 50 for now. Likely 60 next year
		[530] = {30, 1},--Outlands World Bosses
		[870] = {30, 1}, [1064] = {30, 1},--MoP World Bosses
		[1116] = {40, 1}, [1159] = {40, 1}, [1331] = {40, 1}, [1158] = {40, 1}, [1153] = {40, 1}, [1152] = {40, 1}, [1330] = {40, 1}, [1160] = {40, 1}, [1154] = {40, 1}, [1464] = {40, 1},--Wod World and Garrison Bosses
		[1220] = {45, 1}, [1779] = {45, 1},--Legion World bosses
		[1643] = {50, 1}, [1642] = {50, 1}, [1718] = {50, 1}, [1943] = {50, 1}, [1876] = {50, 1}, [2105] = {50, 1}, [2111] = {50, 1}, [2275] = {50, 1},--Bfa World bosses and warfronts
		[2222] = {60, 1}, [2374] = {60, 1},--Shadowlands World Bosses
		[2444] = {70, 1}, [2512] = {70, 1}, [2574] = {70, 1}, [2454] = {70, 1}, [2548] = {70, 1},--Dragonflight World Bosses
		--Raids
		[509] = {30, 3}, [531] = {30, 3}, [469] = {30, 3}, [409] = {30, 3},--Classic Raids
		[564] = {30, 3}, [534] = {30, 3}, [532] = {30, 3}, [565] = {30, 3}, [544] = {30, 3}, [548] = {30, 3}, [580] = {30, 3}, [550] = {30, 3},--BC Raids
		[615] = {30, 3}, [724] = {30, 3}, [649] = {30, 3}, [616] = {30, 3}, [631] = {30, 3}, [533] = {30, 3}, [249] = {30, 3}, [603] = {30, 3}, [624] = {30, 3},--Wrath Raids
		[757] = {35, 3}, [671] = {35, 3}, [669] = {35, 3}, [967] = {35, 3}, [720] = {35, 3}, [951] = {35, 3}, [754] = {35, 3},--Cata Raids
		[1009] = {35, 3}, [1008] = {35, 3}, [1136] = {35, 3}, [996] = {35, 3}, [1098] = {35, 3},--MoP Raids
		[1205] = {40, 3}, [1448] = {40, 3}, [1228] = {40, 3},--WoD Raids (yes, only 3 kekw)
		[1712] = {50, 3}, [1520] = {50, 3}, [1530] = {50, 3}, [1676] = {50, 3}, [1648] = {50, 3},--Legion Raids (Set to 50 because 45 tuning makes them difficult even at 55)
		[1861] = {50, 3}, [2070] = {50, 3}, [2096] = {50, 3}, [2164] = {50, 3}, [2217] = {50, 3},--BfA Raids
		[2296] = {60, 3}, [2450] = {60, 3}, [2481] = {60, 3},--Shadowlands Raids (yes, only 3 kekw, seconded)
		[2522] = {70, 3}, [2569] = {70, 3}, [2549] = {70, 3},--Dragonflight Raids
		--Dungeons
		[48] = {30, 2}, [230] = {30, 2}, [429] = {30, 2}, [389] = {30, 2}, [34] = {30, 2},--Classic Dungeons
		[540] = {30, 2}, [558] = {30, 2}, [556] = {30, 2}, [555] = {30, 2}, [542] = {30, 2}, [546] = {30, 2}, [545] = {30, 2}, [547] = {30, 2}, [553] = {30, 2}, [554] = {30, 2}, [552] = {30, 2}, [557] = {30, 2}, [269] = {30, 2}, [560] = {30, 2}, [543] = {30, 2}, [585] = {30, 2},--BC Dungeons
		[619] = {30, 2}, [601] = {30, 2}, [595] = {30, 2}, [600] = {30, 2}, [604] = {30, 2}, [602] = {30, 2}, [599] = {30, 2}, [576] = {30, 2}, [578] = {30, 2}, [574] = {30, 2}, [575] = {30, 2}, [608] = {30, 2}, [658] = {30, 2}, [632] = {30, 2}, [668] = {30, 2}, [650] = {30, 2},--Wrath Dungeons
		[755] = {35, 2}, [645] = {35, 2}, [36] = {35, 2}, [670] = {35, 2}, [644] = {35, 2}, [33] = {35, 2}, [643] = {35, 2}, [725] = {35, 2}, [657] = {35, 2}, [309] = {35, 2}, [859] = {35, 2}, [568] = {35, 2}, [938] = {35, 2}, [940] = {35, 2}, [939] = {35, 2}, [646] = {35, 2},--Cata Dungeons
		[960] = {35, 2}, [961] = {35, 2}, [959] = {35, 2}, [962] = {35, 2}, [994] = {35, 2}, [1011] = {35, 2}, [1007] = {35, 2}, [1001] = {35, 2}, [1004] = {35, 2},--MoP Dungeons
		[1182] = {40, 2}, [1175] = {40, 2}, [1208] = {40, 2}, [1195] = {40, 2}, [1279] = {40, 2}, [1176] = {40, 2}, [1209] = {40, 2}, [1358] = {40, 2},--WoD Dungeons
		[1501] = {45, 2}, [1466] = {45, 2}, [1456] = {45, 2}, [1477] = {45, 2}, [1458] = {45, 2}, [1516] = {45, 2}, [1571] = {45, 2}, [1492] = {45, 2}, [1544] = {45, 2}, [1493] = {45, 2}, [1651] = {45, 2}, [1677] = {45, 2}, [1753] = {45, 2},--Legion Dungeons
		[1763] = {50, 2}, [1754] = {50, 2}, [1762] = {50, 2}, [1864] = {50, 2}, [1822] = {50, 2}, [1877] = {50, 2}, [1594] = {50, 2}, [1841] = {50, 2}, [1771] = {50, 2}, [1862] = {50, 2}, [2097] = {50, 2},--Bfa Dungeons
		[2286] = {60, 2}, [2289] = {60, 2}, [2290] = {60, 2}, [2287] = {60, 2}, [2285] = {60, 2}, [2293] = {60, 2}, [2291] = {60, 2}, [2284] = {60, 2}, [2441] = {60, 2},--Shadowlands Dungeons
		[2520] = {70, 2}, [2451] = {70, 2}, [2516] = {70, 2}, [2519] = {70, 2}, [2526] = {70, 2}, [2515] = {70, 2}, [2521] = {70, 2}, [2527] = {70, 2}, [2579] = {70, 2},--Dragonflight Dungeons
	}
elseif isCata then--Since 2 dungeons were changed from vanilla to cata dungeons, it has it's own table and it's NOT using retail table cause the dungeons reworked in Mop are still vanilla dungeons in classic (plus diff level caps)
	instanceDifficultyBylevel = {
		--World
		[0] = {60, 1}, [1] = {60, 1},--Eastern Kingdoms and Kalimdor world bosses.
		[530] = {70, 1},--Outlands World Bosses
		--Raids
		[509] = {60, 3}, [531] = {60, 3}, [469] = {60, 3}, [409] = {60, 3},--Classic Raids (309 is legacy ZG)
		[564] = {70, 3}, [534] = {70, 3}, [532] = {70, 3}, [565] = {70, 3}, [544] = {70, 3}, [548] = {70, 3}, [580] = {70, 3}, [550] = {70, 3},--BC Raids (568 is legacy ZA)
		[615] = {80, 3}, [724] = {80, 3}, [649] = {80, 3}, [616] = {80, 3}, [631] = {80, 3}, [533] = {80, 3}, [249] = {80, 3}, [603] = {80, 3}, [624] = {80, 3},--Wrath Raids
		[757] = {85, 3}, [671] = {85, 3}, [669] = {85, 3}, [967] = {85, 3}, [720] = {85, 3}, [951] = {85, 3}, [754] = {85, 3},--Cata Raids
		--Dungeons
		[429] = {45, 2}, [389] = {18, 2}, [349] = {52, 2}, [329] = {60, 2}, [289] = {60, 2}, [230] = {60, 2}, [229] = {60, 2}, [209] = {54, 2}, [189] = {45, 2}, [129] = {47, 2}, [109] = {60, 2}, [90] = {34, 2}, [70] = {52, 2}, [48] = {32, 2}, [47] = {42, 2}, [43] = {27, 2}, [34] = {32, 2},--Classic Dungeons
		[540] = {70, 2}, [558] = {70, 2}, [556] = {70, 2}, [555] = {70, 2}, [542] = {70, 2}, [546] = {70, 2}, [545] = {70, 2}, [547] = {70, 2}, [553] = {70, 2}, [554] = {70, 2}, [552] = {70, 2}, [557] = {70, 2}, [269] = {70, 2}, [560] = {70, 2}, [543] = {70, 2}, [585] = {70, 2},--BC Dungeons
		[619] = {80, 2}, [601] = {80, 2}, [595] = {80, 2}, [600] = {80, 2}, [604] = {80, 2}, [602] = {80, 2}, [599] = {80, 2}, [576] = {80, 2}, [578] = {80, 2}, [574] = {80, 2}, [575] = {80, 2}, [608] = {80, 2}, [658] = {80, 2}, [632] = {80, 2}, [668] = {80, 2}, [650] = {80, 2},--Wrath Dungeons
		[755] = {85, 2}, [645] = {85, 2}, [36] = {85, 2}, [670] = {85, 2}, [644] = {85, 2}, [33] = {85, 2}, [643] = {85, 2}, [725] = {85, 2}, [657] = {85, 2}, [309] = {85, 2}, [859] = {85, 2}, [568] = {85, 2}, [938] = {85, 2}, [940] = {85, 2}, [939] = {85, 2}, [646] = {85, 2},--Cata Dungeons
	}
elseif isWrath then--Since naxx is moved to northrend, wrath and cata can't use tbc/classics table
	instanceDifficultyBylevel = {
		--World
		[0] = {60, 1}, [1] = {60, 1},--Eastern Kingdoms and Kalimdor world bosses.
		[530] = {70, 1},--Outlands World Bosses
		--Raids
		[509] = {60, 3}, [531] = {60, 3}, [469] = {60, 3}, [409] = {60, 3}, [309] = {60, 3},--Classic Raids (309 is legacy ZG)
		[564] = {70, 3}, [534] = {70, 3}, [532] = {70, 3}, [565] = {70, 3}, [544] = {70, 3}, [548] = {70, 3}, [580] = {70, 3}, [550] = {70, 3}, [568] = {70, 3},--BC Raids (568 is legacy ZA)
		[615] = {80, 3}, [724] = {80, 3}, [649] = {80, 3}, [616] = {80, 3}, [631] = {80, 3}, [533] = {80, 3}, [249] = {80, 3}, [603] = {80, 3}, [624] = {80, 3},--Wrath Raids
		--Dungeons
		[429] = {45, 2}, [389] = {18, 2}, [349] = {52, 2}, [329] = {60, 2}, [289] = {60, 2}, [230] = {60, 2}, [229] = {60, 2}, [209] = {54, 2}, [189] = {45, 2}, [129] = {47, 2}, [109] = {60, 2}, [90] = {34, 2}, [70] = {52, 2}, [48] = {32, 2}, [47] = {42, 2}, [43] = {27, 2}, [36] = {25, 2}, [34] = {32, 2}, [33] = {30, 2},--Classic Dungeons
		[540] = {70, 2}, [558] = {70, 2}, [556] = {70, 2}, [555] = {70, 2}, [542] = {70, 2}, [546] = {70, 2}, [545] = {70, 2}, [547] = {70, 2}, [553] = {70, 2}, [554] = {70, 2}, [552] = {70, 2}, [557] = {70, 2}, [269] = {70, 2}, [560] = {70, 2}, [543] = {70, 2}, [585] = {70, 2},--BC Dungeons
		[619] = {80, 2}, [601] = {80, 2}, [595] = {80, 2}, [600] = {80, 2}, [604] = {80, 2}, [602] = {80, 2}, [599] = {80, 2}, [576] = {80, 2}, [578] = {80, 2}, [574] = {80, 2}, [575] = {80, 2}, [608] = {80, 2}, [658] = {80, 2}, [632] = {80, 2}, [668] = {80, 2}, [650] = {80, 2},--Wrath Dungeons
	}
else--TBC and Vanilla
	instanceDifficultyBylevel = {
		--World
		[0] = {60, 1}, [1] = {60, 1},--Eastern Kingdoms and Kalimdor world bosses.
		[530] = {70, 1},--Outlands World Bosses
		--Raids
		[509] = {60, 3}, [531] = {60, 3}, [469] = {60, 3}, [409] = {60, 3}, [533] = {60, 3}, [309] = {60, 3}, [249] = {60, 3},--Classic Raids (309 is legacy ZG)
		[564] = {70, 3}, [534] = {70, 3}, [532] = {70, 3}, [565] = {70, 3}, [544] = {70, 3}, [548] = {70, 3}, [580] = {70, 3}, [550] = {70, 3}, [568] = {70, 3},--BC Raids (568 is legacy ZA)
		--Dungeons
		[429] = {45, 2}, [389] = {18, 2}, [349] = {52, 2}, [329] = {60, 2}, [289] = {60, 2}, [230] = {60, 2}, [229] = {60, 2}, [209] = {54, 2}, [189] = {45, 2}, [129] = {47, 2}, [109] = {60, 2}, [90] = {34, 2}, [70] = {52, 2}, [48] = {32, 2}, [47] = {42, 2}, [43] = {27, 2}, [36] = {25, 2}, [34] = {32, 2}, [33] = {30, 2},--Classic Dungeons
		[540] = {70, 2}, [558] = {70, 2}, [556] = {70, 2}, [555] = {70, 2}, [542] = {70, 2}, [546] = {70, 2}, [545] = {70, 2}, [547] = {70, 2}, [553] = {70, 2}, [554] = {70, 2}, [552] = {70, 2}, [557] = {70, 2}, [269] = {70, 2}, [560] = {70, 2}, [543] = {70, 2}, [585] = {70, 2},--BC Dungeons
	}
	-- Season of Discovery
	if Enum.SeasonID and currentSeason == Enum.SeasonID.SeasonOfDiscovery then
		instanceDifficultyBylevel[48] = {25, 3} -- Blackfathom deeps level up raid
		instanceDifficultyBylevel[90] = {40, 3} -- Gnomeregan level up raid
	end
end

-----------------
--  Libraries  --
-----------------
local LibSpec
do
	if isRetail and LibStub then
		LibSpec = LibStub("LibSpecialization", true)
		if LibSpec then
			local function update(specID, _, _, playerName)
				if raid[playerName] then
					raid[playerName].specID = specID
				end
			end
			---@diagnostic disable-next-line: undefined-field
			LibSpec:Register(DBM, update)
		end
	end
end

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
-- these global functions are accessed all the time by the event handler
-- so caching them is worth the effort
local ipairs, pairs, next = ipairs, pairs, next
local tonumber, tostring = tonumber, tostring
local tinsert, tremove, twipe, tsort, tconcat = table.insert, table.remove, table.wipe, table.sort, table.concat
local type, select = type, select
local GetTime = GetTime
local bband = bit.band
local mabs, floor, mhuge, mmin, mmax, mrandom = math.abs, math.floor, math.huge, math.min, math.max, math.random
local GetNumGroupMembers, GetRaidRosterInfo = GetNumGroupMembers, GetRaidRosterInfo
local UnitName, GetUnitName = UnitName, GetUnitName
local IsInRaid, IsInGroup, IsInInstance = IsInRaid, IsInGroup, IsInInstance
local UnitAffectingCombat, InCombatLockdown, IsFalling, IsEncounterInProgress, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty = UnitAffectingCombat, InCombatLockdown, IsFalling, IsEncounterInProgress, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty
local UnitGUID, UnitHealth, UnitHealthMax = UnitGUID, UnitHealth, UnitHealthMax
local UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit = UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit
--local UnitTokenFromGUID, UnitPercentHealthFromGUID = UnitTokenFromGUID, UnitPercentHealthFromGUID
local GetSpellInfo, GetSpellTexture, GetSpellCooldown = GetSpellInfo, GetSpellTexture, GetSpellCooldown
local GetDungeonInfo = C_LFGInfo.GetDungeonInfo or GetDungeonInfo -- Classic has C_LFGInfo but not C_LFGInfo.GetDungeonInfo, need to use global for classic
local EJ_GetEncounterInfo, EJ_GetCreatureInfo = EJ_GetEncounterInfo, EJ_GetCreatureInfo
local EJ_GetSectionInfo, GetSectionIconFlags
if C_EncounterJournal then
	EJ_GetSectionInfo, GetSectionIconFlags = C_EncounterJournal.GetSectionInfo, C_EncounterJournal.GetSectionIconFlags
end
local GetInstanceInfo = GetInstanceInfo
local GetSpecialization, GetSpecializationInfo, GetSpecializationInfoByID = GetSpecialization, GetSpecializationInfo, GetSpecializationInfoByID
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitIsGroupLeader, UnitIsGroupAssistant = UnitIsGroupLeader, UnitIsGroupAssistant
local PlaySoundFile = PlaySoundFile
local Ambiguate = Ambiguate
local C_TimerNewTicker, C_TimerAfter = C_Timer.NewTicker, C_Timer.After
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local SendAddonMessage = C_ChatInfo.SendAddonMessage

local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors

-- Polyfill for C_AddOns, Classic and Retail have the fully featured table, Wrath has only Metadata (as of Dec 15th 2023)
local cachedAddOns = nil
local C_AddOns = {
	GetAddOnMetadata = C_AddOns.GetAddOnMetadata,
	GetNumAddOns = C_AddOns.GetNumAddOns or GetNumAddOns, ---@diagnostic disable-line:deprecated
	GetAddOnInfo = C_AddOns.GetAddOnInfo or GetAddOnInfo, ---@diagnostic disable-line:deprecated
	LoadAddOn = C_AddOns.LoadAddOn or LoadAddOn, ---@diagnostic disable-line:deprecated
	IsAddOnLoaded = C_AddOns.IsAddOnLoaded or IsAddOnLoaded, ---@diagnostic disable-line:deprecated
	EnableAddOn = C_AddOns.EnableAddOn or EnableAddOn, ---@diagnostic disable-line:deprecated
	GetAddOnEnableState = C_AddOns.GetAddOnEnableState or function(addon, character)
		return GetAddOnEnableState(character, addon) ---@diagnostic disable-line:deprecated
	end,
	DoesAddOnExist = C_AddOns.DoesAddOnExist or function(addon)
		if not cachedAddOns then
			cachedAddOns = {}
			for i = 1, GetNumAddOns() do ---@diagnostic disable-line:deprecated
				cachedAddOns[GetAddOnInfo(i)] = true ---@diagnostic disable-line:deprecated
			end
		end
		return cachedAddOns[addon]
	end,
}

---------------------------------
--  General (local) functions  --
---------------------------------
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for _, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

local function removeEntry(t, val)
	local existed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			tremove(t, i)
			existed = true
		end
	end
	return existed
end

local function OrderedTable()
	local nextkey, firstkey = {}, {}
	nextkey[nextkey] = firstkey

	local function onext(self, key)
		while key ~= nil do
			key = nextkey[key]
			local val = self[key]
			if val ~= nil then
				return key, val
			end
		end
	end

	local selfmeta = firstkey
	selfmeta.__nextkey = nextkey

	function selfmeta:__newindex(key, val)
		rawset(self, key, val)
		if nextkey[key] == nil then
			nextkey[nextkey[nextkey]] = key
			nextkey[nextkey] = key
		end
	end

	function selfmeta:__pairs()
		return onext, self, firstkey
	end

	return setmetatable({}, selfmeta)
end

--Whisper/Whisper Sync filter function
local function checkForSafeSender(sender, checkFriends, checkGuild, filterRaid, isRealIdMessage)
	if checkFriends then
		--Check Battle.net friends
		if isRealIdMessage then
			if filterRaid then
				--Since filterRaid is true, we need to get tooninfo to see if they are in raid
				local accountInfo = C_BattleNet.GetAccountInfoByID(sender)
				if accountInfo and accountInfo.gameAccountInfo then--game account info means they are logged into a bnet game
					local toonName, client = accountInfo.gameAccountInfo.characterName, accountInfo.gameAccountInfo.clientProgram or ""
					if toonName and client == BNET_CLIENT_WOW and DBM:GetRaidUnitId(toonName) then--Check if toon name exists and if client is wow and if toonName is in raid.
						return false--just set sender as unsafe
					end
				end
			end
			return true--Basically, if not trying to filter someone who's in raid with us, always return true. Non friends can't send realid/battle.net messages
		else--Non battle.net message
			--We still need to see if it's a bnet friend, even if it's not a realID message, just have to iterate over entire friendslist to find matching toonname
			local _, numBNetOnline = BNGetNumFriends()
			for i = 1, numBNetOnline do
				local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
				if accountInfo and accountInfo.gameAccountInfo then
					local toonName, client = accountInfo.gameAccountInfo.characterName, accountInfo.gameAccountInfo.clientProgram or ""
					--Check if it's a bnet friend sending a non bnet whisper
					if toonName and client == BNET_CLIENT_WOW then--Check if toon name exists and if client is wow. If yes to both, we found right client
						if toonName == sender then--Now simply see if this is sender
							return not (filterRaid and DBM:GetRaidUnitId(toonName)) -- Person is in raid group and filter raid enabled
						end
					end
				end
			end
		end
		--Check if it's a non bnet friend
		local friendInfo = C_FriendList.GetFriendInfo(sender)
		if friendInfo then
			return not (filterRaid and DBM:GetRaidUnitId(friendInfo.name)) -- Person is in raid group and filter raid enabled
		end
	end
	--Check Guildies (not used by whisper syncs, but used by status whispers)
	if checkGuild then
		--TODO, test UnitIsInMyGuild in both classics, and retail, especially for cross faction guild members. That can save a lot of cpu by removing iterating over literally entire guild roster
		local totalMembers, _, numOnlineAndMobileMembers = GetNumGuildMembers()
		local scanTotal = GetGuildRosterShowOffline() and totalMembers or numOnlineAndMobileMembers--Attempt CPU saving, if "show offline" is unchecked, we can reliably scan only online members instead of whole roster
		for i = 1, scanTotal do
			local name = GetGuildRosterInfo(i)
			if not name then break end
			name = Ambiguate(name, "none")
			if name == sender then
				return not (filterRaid and DBM:GetRaidUnitId(name))
			end
		end
	end
	return false
end

-- automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
local function sendSync(protocol, prefix, msg)
	if dbmIsEnabled or prefix == "V" or prefix == "H" then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		local fullname = playerName .. "-" .. normalizedPlayerRealm
		if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
			SendAddonMessage(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "INSTANCE_CHAT")
		else
			if IsInRaid() then
				SendAddonMessage(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "RAID")
			elseif IsInGroup(1) then
				SendAddonMessage(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "PARTY")
			else--for solo raid
				handleSync("SOLO", playerName, nil, (protocol or DBMSyncProtocol), prefix, strsplit("\t", msg))
			end
		end
	end
end
private.sendSync = sendSync

local function sendGuildSync(protocol, prefix, msg)
	if IsInGuild() and (dbmIsEnabled or prefix == "V" or prefix == "H") then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		local fullname = playerName .. "-" .. normalizedPlayerRealm
		SendAddonMessage(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
end
private.sendGuildSync = sendGuildSync

--Custom sync function that should only be used for user generated sync messages
local function sendLoggedSync(protocol, prefix, msg)
	if dbmIsEnabled then
		msg = msg or ""
		local fullname = playerName .. "-" .. normalizedPlayerRealm
		if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
			C_ChatInfo.SendAddonMessageLogged(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "INSTANCE_CHAT")
		else
			if IsInRaid() then
				C_ChatInfo.SendAddonMessageLogged(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "RAID")
			elseif IsInGroup(1) then
				C_ChatInfo.SendAddonMessageLogged(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "PARTY")
			else--for solo raid
				handleSync("SOLO", playerName, nil, (protocol or DBMSyncProtocol), prefix, strsplit("\t", msg))
			end
		end
	end
end

--Sync Object specifically for out in the world sync messages that have different rules than standard syncs
local function SendWorldSync(self, protocol, prefix, msg, noBNet)
	if not dbmIsEnabled then return end--Block all world syncs if force disabled
	DBM:Debug("SendWorldSync running for " .. prefix)
	local fullname = playerName .. "-" .. normalizedPlayerRealm
	if IsInRaid() then
		SendAddonMessage(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "RAID")
	elseif IsInGroup(1) then
		SendAddonMessage(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "PARTY")
	else--for solo raid
		handleSync("SOLO", playerName, nil, (protocol or DBMSyncProtocol), prefix, strsplit("\t", msg))
	end
	if IsInGuild() then
		SendAddonMessage(DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
	if self.Options.EnableWBSharing and not noBNet then
		local _, numBNetOnline = BNGetNumFriends()
		local connectedServers = GetAutoCompleteRealms()
		for i = 1, numBNetOnline do
			local gameAccountID, isOnline, realmName
			local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
			if accountInfo then
				gameAccountID, isOnline, realmName = accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.isOnline, accountInfo.gameAccountInfo.realmName
			end
			if gameAccountID and isOnline and realmName then
				local sameRealm = false
				if connectedServers then
					for j = 1, #connectedServers do
						if realmName == connectedServers[j] then
							sameRealm = true
							break
						end
					end
				else
					if realmName == playerRealm or realmName == normalizedPlayerRealm then
						sameRealm = true
					end
				end
				if sameRealm then
					BNSendGameData(gameAccountID, DBMPrefix, DBMSyncProtocol .. "\t" .. prefix .. "\t" .. msg)--Just send users realm for pull, so we can eliminate connectedServers checks on sync handler
				end
			end
		end
	end
end

local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time * 100) / 100
	if time < 60 then
		return L.TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return L.TIMER_FORMAT_MINS:format(time / 60)
	else
		return L.TIMER_FORMAT:format(time / 60, time % 60)
	end
end

function DBM:strFromTime(time)
	return strFromTime(time)
end

do
	-- fail-safe format, replaces missing arguments with unknown
	-- note: doesn't handle cases like %%%s correctly at the moment (should become %unknown, but becomes %%s)
	-- also, the end of the format directive is not detected in all cases, but handles everything that occurs in our boss mods ;)
	--> not suitable for general-purpose use, just for our warnings and timers (where an argument like a spell-target might be nil due to missing target information from unreliable detection methods)
	local function replace(cap1)
		return cap1 == "%" and CL.UNKNOWN
	end

	function pformat(fstr, ...)
		local ok, str = pcall(format, fstr, ...)
		return ok and str or fstr:gsub("(%%+)([^%%%s%)<]+)", replace):gsub("%%%%", "%%")
	end
end

-- sends a whisper to a player by his or her character name or BNet presence id
-- returns true if the message was sent, nil otherwise
local function sendWhisper(target, msg)
	if type(target) == "number" then
		if not BNIsSelf(target) then -- Never send BNet whispers to ourselves
			BNSendWhisper(target, msg)
		end
	elseif type(target) == "string" then
		SendChatMessage(msg, "WHISPER", nil, target) -- Whispering to ourselves here is okay and somewhat useful for whisper-warnings
	end
end

--Another custom server name strip function that first strips out the "><" DBM wraps around playernames
local function stripServerName(cap)
	return DBM:GetShortServerName(cap:sub(2, -2))
end

local function parseSpellIcon(spellId, objectType, fallbackIcon)
	local icon
	if objectType and objectType == "achievement" then
		icon = select(10, GetAchievementInfo(spellId))
	elseif type(spellId) == "string" then--Journal ID in old format
		if spellId:match("ej%d+") then
			icon = select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3)))
		else--Icon texture ID (passed as string by module so core knows it's a FDID and not spellID
			icon = spellId
		end
	elseif type(spellId) == "number" then--SpellId or journal Id
		if spellId < 0 then--Journal ID in new format
			icon = select(4, DBM:EJ_GetSectionInfo(-spellId))
		else--SpellId
			icon = spellId >= 6 and GetSpellTexture(spellId)
		end
	end
	return icon or fallbackIcon or 136116
end

local function parseSpellName(spellId, objectType)
	local spellName
	if objectType and objectType == "achievement" then
		spellName = select(2, GetAchievementInfo(spellId))
	elseif type(spellId) == "string" and spellId:match("ej%d+") then--Old Journal Format
		spellName = DBM:EJ_GetSectionInfo(string.sub(spellId, 3))
	elseif type(spellId) == "number" then
		if spellId < 0 then--New Journal Format
			spellName = DBM:EJ_GetSectionInfo(-spellId)
		else
			spellName = DBM:GetSpellInfo(spellId)
		end
	end
	return spellName
end

--------------
--  Events  --
--------------
---@alias DBMEvent WowEvent|CombatlogEvent|DBMUnfilteredEvent
do
	local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
	local registeredEvents = {}
	local registeredSpellIds = {}
	local unfilteredCLEUEvents = {}
	local registeredUnitEventIds = {}
	---@class DBMCombatLogArgs
	local argsMT = {}
	---@class DBMCombatLogArgs
	local args = setmetatable({
		-- Explicitly define them because type deduction from CLEU events is ~impossible
		event             = nil, ---@type string
		timestamp         = nil, ---@type number
		sourceGUID        = nil, ---@type string
		sourceName        = nil, ---@type string?
		sourceFlags       = nil, ---@type number
		sourceRaidFlags   = nil, ---@type number
		destGUID          = nil, ---@type string
		destName          = nil, ---@type string?
		destFlags         = nil, ---@type number
		destRaidFlags     = nil, ---@type number
		spellId           = nil, ---@type number
		spellName         = nil, ---@type string
		extraSpellId      = nil, ---@type number
		extraSpellName    = nil, ---@type string
		environmentalType = nil, ---@type string
		amount            = nil, ---@type number
		overkill          = nil, ---@type number
		school            = nil, ---@type number
		blocked           = nil, ---@type number?
		absorbed          = nil, ---@type number?
		critical          = nil, ---@type boolean
		glancing          = nil, ---@type boolean
		crushing          = nil, ---@type boolean
	}, {__index = argsMT})

	function argsMT:IsSpellID(...)
		for i = 1, select('#', ...) do
			if args.spellId == select(i, ...) then
				return true
			end
		end
		return false
	end

	--Function exclusively used in classic era to make it a little cleaner to mass unifiy modules to auto check spellid or spellName based on game flavor
	--As of 1.15.0 classic era now has spellids, but want to keep wrapper for now in case they ever revert this or they decide to do classic fresh with no IDs one day
	function argsMT:IsSpell(...)
--		if isClassic then
--			--ugly ass performance wasting checks that have to first convert Ids to names because #nochanges
--			for i = 1, select('#', ...) do
--				local spellName = DBM:GetSpellInfo(select(i, ...))
--				if spellName and spellName == args.spellName then
--					return true
--				end
--			end
--			return false
--		else
		--Just simple table comoparison
		for i = 1, select('#', ...) do
			if args.spellId == select(i, ...) then
				return true
			end
		end
		return false
--		end
	end

	function argsMT:IsPlayer()
		-- If blizzard ever removes destFlags, this will automatically switch to fallback
		if args.destFlags and COMBATLOG_OBJECT_AFFILIATION_MINE then
			return bband(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		else
			return raid[args.destName] ~= nil--Unit in group, friendly
		end
	end

	function argsMT:IsPlayerSource()
		-- If blizzard ever removes sourceFlags, this will automatically switch to fallback
		if args.sourceFlags and COMBATLOG_OBJECT_AFFILIATION_MINE then
			return bband(args.sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		else
			return raid[args.sourceName] ~= nil -- Unit in group, friendly
		end
	end

	function argsMT:IsNPC()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0
	end

	function argsMT:IsPet()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT:IsPetSource()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT:IsSrcTypePlayer()
		-- If blizzard ever removes sourceFlags, this will automatically switch to fallback
		if args.sourceFlags and COMBATLOG_OBJECT_TYPE_PLAYER then
			return bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		else
			return raid[args.sourceName] ~= nil -- Unit in group, friendly
		end
	end

	function argsMT:IsDestTypePlayer()
		-- If blizzard ever removes destFlags, this will automatically switch to fallback
		if args.destFlags and COMBATLOG_OBJECT_TYPE_PLAYER then
			return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		else
			return raid[args.destName] ~= nil -- Unit in group, friendly
		end
	end

	function argsMT:IsSrcTypeHostile()
		-- If blizzard ever removes sourceFlags, this will automatically switch to fallback
		if args.sourceFlags and COMBATLOG_OBJECT_REACTION_HOSTILE then
			return bband(args.sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
		else
			return raid[args.sourceName] ~= nil -- Unit in group, friendly
		end
	end

	function argsMT:IsDestTypeHostile()
		-- If blizzard ever removes destFlags, this will automatically switch to fallback
		if args.destFlags and COMBATLOG_OBJECT_REACTION_HOSTILE then
			return bband(args.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
		else
			return raid[args.destName] ~= nil -- Unit in group, friendly
		end
	end

	function argsMT:GetSrcCreatureID()
		return DBM:GetCIDFromGUID(self.sourceGUID)
	end

	function argsMT:GetDestCreatureID()
		return DBM:GetCIDFromGUID(self.destGUID)
	end

	local function handleEvent(self, event, ...)
		local isUnitEvent = event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED"
		if self == mainFrame and isUnitEvent then
			-- UNIT_* events that come from mainFrame are _UNFILTERED variants and need their suffix
			event = event .. "_UNFILTERED"
			isUnitEvent = false -- not actually a real unit id for this function...
		end
		if not registeredEvents[event] or not dbmIsEnabled then return end
		for _, v in ipairs(registeredEvents[event]) do
			local zones = v.zones
			local handler = v[event]
			local modEvents = v.registeredUnitEvents
			if handler and (not isUnitEvent or not modEvents or modEvents[event .. ...]) and (not zones or zones[LastInstanceMapID]) and not (not v.isTrashModBossFightAllowed and v.isTrashMod and #inCombat > 0) then
				handler(v, ...)
			end
		end
	end

	local registerUnitEvent, unregisterUnitEvent, registerSpellId, unregisterSpellId, registerCLEUEvent, unregisterCLEUEvent
	do
		local frames = {} -- frames that are being used for unit events, one frame per unit id (this could be optimized, as it currently creates a new frame even for a different event, but that's not worth the effort as 90% of all calls are just boss1 anyways)

		function registerUnitEvent(mod, event, ...)
			mod.registeredUnitEvents = mod.registeredUnitEvents or {}
			for i = 1, select("#", ...) do
				local uId = select(i, ...)
				if not uId then break end
				local frame = frames[uId]
				if not frame then
					frame = CreateFrame("Frame")
					if uId == "mouseover" then
						-- work-around for mouse-over events (broken!)
						frame:SetScript("OnEvent", function(self, event, _, ...)
							-- we registered mouseover events, so we only want mouseover events, thanks.
							handleEvent(self, event, "mouseover", ...)
						end)
					else
						frame:SetScript("OnEvent", handleEvent)
					end
					frames[uId] = frame
				end
				registeredUnitEventIds[event .. uId] = (registeredUnitEventIds[event .. uId] or 0) + 1
				mod.registeredUnitEvents[event .. uId] = true
				frame:RegisterUnitEvent(event, uId)
			end
		end

		function unregisterUnitEvent(mod, event, ...)
			for i = 1, select("#", ...) do
				local uId = select(i, ...)
				if not uId then break end
				local frame = frames[uId]
				local refs = (registeredUnitEventIds[event .. uId] or 1) - 1
				registeredUnitEventIds[event .. uId] = refs
				if refs <= 0 then
					registeredUnitEventIds[event .. uId] = nil
					if frame then
						frame:UnregisterEvent(event)
					end
				end
				if mod.registeredUnitEvents and mod.registeredUnitEvents[event .. uId] then
					mod.registeredUnitEvents[event .. uId] = nil
				end
			end
			for i = #registeredEvents[event], 1, -1 do
				if registeredEvents[event][i] == mod then
					tremove(registeredEvents[event], i)
				end
			end
			if #registeredEvents[event] == 0 then
				registeredEvents[event] = nil
			end
		end

		function registerSpellId(event, spellId)
			if type(spellId) == "string" then--Something is screwed up, like SPELL_AURA_APPLIED DOSE
				DBM:Debug("DBM RegisterEvents Warning: " .. spellId .. " is not a number!")
				return
			end
			local spellName = DBM:GetSpellInfo(spellId)
			if spellId and not spellName then
				DBM:Debug("DBM RegisterEvents Warning: " .. spellId .. " spell id does not exist!")
				return
			end
			if not registeredSpellIds[event] then
				registeredSpellIds[event] = {}
			end
			--if isClassic then
			--	if not registeredSpellIds[event][spellName] then--Don't register duplicate spell Names
			--		registeredSpellIds[event][spellName] = (registeredSpellIds[event][spellName] or 0) + 1--But classic needs spellNames
			--	end
			--else
				registeredSpellIds[event][spellId] = (registeredSpellIds[event][spellId] or 0) + 1
			--end
		end

		function unregisterSpellId(event, spellId)
			if not registeredSpellIds[event] then return end
			local spellName = DBM:GetSpellInfo(spellId)
			if spellId and not spellName then
				DBM:Debug("DBM unregisterSpellId Warning: " .. spellId .. " spell id does not exist!")
				return
			end
			--local regName = isClassic and spellName or spellId
			local refs = (registeredSpellIds[event][spellId] or 1) - 1
			registeredSpellIds[event][spellId] = refs
			if refs <= 0 then
				registeredSpellIds[event][spellId] = nil
			end
		end

		--There are 2 tables. unfilteredCLEUEvents and registeredSpellIds table.
		--unfilteredCLEUEvents saves UNFILTERED cleu event count. this is count table to prevent bad unregister.
		--registeredSpellIds tables filtered table. this saves event and spell ids. works smiliar with unfilteredCLEUEvents table.
		function registerCLEUEvent(mod, event)
			local argTable = {strsplit(" ", event)}
			-- filtered cleu event. save information in registeredSpellIds table.
			if #argTable > 1 then
				event = argTable[1]
				for i = 2, #argTable do
					registerSpellId(event, tonumber(argTable[i]))
				end
			-- no args. works as unfiltered. save information in unfilteredCLEUEvents table.
			else
				unfilteredCLEUEvents[event] = (unfilteredCLEUEvents[event] or 0) + 1
			end
			registeredEvents[event] = registeredEvents[event] or {}
			tinsert(registeredEvents[event], mod)
		end

		function unregisterCLEUEvent(mod, event)
			local argTable = {strsplit(" ", event)}
			local eventCleared = false
			-- filtered cleu event. save information in registeredSpellIds table.
			if #argTable > 1 then
				event = argTable[1]
				for i = 2, #argTable do
					unregisterSpellId(event, tonumber(argTable[i]))
				end
				local remainingSpellIdCount = 0
				if registeredSpellIds[event] then
					for _, _ in pairs(registeredSpellIds[event]) do
						remainingSpellIdCount = remainingSpellIdCount + 1
					end
				end
				if remainingSpellIdCount == 0 then
					registeredSpellIds[event] = nil
					-- if unfilteredCLEUEvents and registeredSpellIds do not exists, clear registeredEvents.
					if not unfilteredCLEUEvents[event] then
						eventCleared = true
					end
				end
			-- no args. works as unfiltered. save information in unfilteredCLEUEvents table.
			else
				local refs = (unfilteredCLEUEvents[event] or 1) - 1
				unfilteredCLEUEvents[event] = refs
				if refs <= 0 then
					unfilteredCLEUEvents[event] = nil
					-- if unfilteredCLEUEvents and registeredSpellIds do not exists, clear registeredEvents.
					if not registeredSpellIds[event] then
						eventCleared = true
					end
				end
			end
			for i = #registeredEvents[event], 1, -1 do
				if registeredEvents[event][i] == mod then
					registeredEvents[event][i] = {}
					break
				end
			end
			if eventCleared then
				registeredEvents[event] = nil
			end
		end
	end

	-- UNIT_* events are special: they can take 'parameters' like this: "UNIT_HEALTH boss1 boss2" which only trigger the event for the given unit ids
	---@param ... DBMEvent|string
	function DBM:RegisterEvents(...)
		for i = 1, select('#', ...) do
			local event = select(i, ...)
			-- spell events with special care.
			if event:sub(0, 6) == "SPELL_" and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_" or event:sub(0, 6) == "SWING_" or event == "UNIT_DIED" or event == "UNIT_DESTROYED" or event == "PARTY_KILL" then
				registerCLEUEvent(self, event)
			else
				local eventWithArgs = event
				-- unit events need special care
				if event:sub(0, 5) == "UNIT_" then
					-- unit events are limited to 8 "parameters", as there is no good reason to ever use more than 5 (it's just that the code old code supported 8 (boss1-5, target, focus))
					local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8
					event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
					if not arg1 and event:sub(-11) ~= "_UNFILTERED" then -- no arguments given, support for legacy mods
						eventWithArgs = event .. " boss1 boss2 boss3 boss4 boss5 target"
						if not isClassic then
							eventWithArgs = eventWithArgs .. " focus"
						end
						event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", eventWithArgs)
					end
					if event:sub(-11) == "_UNFILTERED" then
						-- we really want *all* unit ids
						mainFrame:RegisterEvent(event:sub(0, -12))
					else
						registerUnitEvent(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
					end
				-- spell events with filter
				else
					-- normal events
					mainFrame:RegisterEvent(event)
				end
				registeredEvents[eventWithArgs] = registeredEvents[eventWithArgs] or {}
				tinsert(registeredEvents[eventWithArgs], self)
				if event ~= eventWithArgs then
					registeredEvents[event] = registeredEvents[event] or {}
					tinsert(registeredEvents[event], self)
				end
			end
		end
	end

	local function unregisterUEvent(mod, event)
		if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
			local eventName, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
			if eventName:sub(-11) == "_UNFILTERED" then
				mainFrame:UnregisterEvent(eventName:sub(0, -12))
			else
				unregisterUnitEvent(mod, eventName, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
			end
		end
	end

	local function findRealEvent(t, val)
		for _, v in ipairs(t) do
			local event = strsplit(" ", v)
			if event == val then
				return v
			end
		end
	end

	function DBM:UnregisterInCombatEvents(srmOnly, srmIncluded)
		---@cast self DBMMod
		for event, mods in pairs(registeredEvents) do
			if srmOnly then
				local i = 1
				while mods[i] do
					if mods[i] == self and event == "SPELL_AURA_REMOVED" then
						local findEvent = findRealEvent(self.inCombatOnlyEvents, "SPELL_AURA_REMOVED")
						if findEvent then
							unregisterCLEUEvent(self, findEvent)
							break
						end
					end
					i = i + 1
				end
			elseif (event:sub(0, 6) == "SPELL_" and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_") then
				local i = 1
				while mods[i] do
					if mods[i] == self and (srmIncluded or event ~= "SPELL_AURA_REMOVED") then
						local findEvent = findRealEvent(self.inCombatOnlyEvents, event)
						if findEvent then
							unregisterCLEUEvent(self, findEvent)
							break
						end
					end
					i = i + 1
				end
			else
				local match = false
				for i = #mods, 1, -1 do
					if mods[i] == self and checkEntry(self.inCombatOnlyEvents, event) then
						tremove(mods, i)
						match = true
					end
				end
				if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(-11) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then -- unit events have their own reference count
					unregisterUEvent(self, event)
				end
				if #mods == 0 then
					registeredEvents[event] = nil
				end
			end
		end
	end

	---@param ... DBMEvent|string
	function DBM:RegisterShortTermEvents(...)
		DBM:Debug("RegisterShortTermEvents fired", 2)
		local _shortTermRegisterEvents = {...}
		for k, v in pairs(_shortTermRegisterEvents) do
			if v:sub(0, 5) == "UNIT_" and v:sub(-11) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
				-- legacy event, oh noes
				_shortTermRegisterEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
			end
		end
		self:RegisterEvents(unpack(_shortTermRegisterEvents))
		-- Fix so we can register multiple short term events. Use at your own risk, as unsucribing will cause
		-- all short term events to unregister.
		if not self.shortTermRegisterEvents then
			self.shortTermRegisterEvents = {}
		end
		for k, v in pairs(_shortTermRegisterEvents) do
			self.shortTermRegisterEvents[k] = v
		end
		-- End fix
	end

	function DBM:UnregisterShortTermEvents()
		DBM:Debug("UnregisterShortTermEvents fired", 2)
		if self.shortTermRegisterEvents then
			DBM:Debug("UnregisterShortTermEvents found registered shortTermRegisterEvents", 2)
			for event, mods in pairs(registeredEvents) do
				if event:sub(0, 6) == "SPELL_" or event:sub(0, 6) == "RANGE_" then
					local i = 1
					while mods[i] do
						if mods[i] == self then
							local findEvent = findRealEvent(self.shortTermRegisterEvents, event)
							if findEvent then
								unregisterCLEUEvent(self, findEvent)
								break
							end
						end
						i = i + 1
					end
				else
					local match = false
					for i = #mods, 1, -1 do
						if mods[i] == self and checkEntry(self.shortTermRegisterEvents, event) then
							tremove(mods, i)
							match = true
						end
					end
					if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(-11) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then
						unregisterUEvent(self, event)
						DBM:Debug("unregisterUEvent for unit event " .. event .. " unregistered", 3)
					end
					if #mods == 0 then
						registeredEvents[event] = nil
						DBM:Debug("registeredEvents for event " .. event .. " nilled", 3)
					end
				end
			end
			self.shortTermRegisterEvents = nil
		end
	end

	DBM:RegisterEvents("ADDON_LOADED")

	function DBM:FilterRaidBossEmote(msg, ...)
		return handleEvent(nil, "CHAT_MSG_RAID_BOSS_EMOTE_FILTERED", msg:gsub("\124c%x+(.-)\124r", "%1"), ...)
	end

	local noArgTableEvents = {
		SWING_DAMAGE = true,
		SWING_MISSED = true,
		RANGE_DAMAGE = true,
		RANGE_MISSED = true,
		SPELL_DAMAGE = true,
		SPELL_BUILDING_DAMAGE = true,
		SPELL_MISSED = true,
		SPELL_ABSORBED = true,
		SPELL_HEAL = true,
		SPELL_ENERGIZE = true,
		SPELL_PERIODIC_ENERGIZE = true,
		SPELL_PERIODIC_MISSED = true,
		SPELL_PERIODIC_DAMAGE = true,
		SPELL_PERIODIC_DRAIN = true,
		SPELL_PERIODIC_LEECH = true,
		SPELL_DRAIN = true,
		SPELL_LEECH = true,
		SPELL_CAST_FAILED = true
	}
	function DBM:COMBAT_LOG_EVENT_UNFILTERED()
		local timestamp, event, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10 = CombatLogGetCurrentEventInfo()
		if not event or not registeredEvents[event] then return end
		local eventSub6 = event:sub(0, 6)
		if (eventSub6 == "SPELL_" or eventSub6 == "RANGE_") and not unfilteredCLEUEvents[event] and registeredSpellIds[event] then
			if not registeredSpellIds[event][extraArg1] then return end
		end
		-- process some high volume events without building the whole table which is somewhat faster
		-- this prevents work-around with mods that used to have their own event handler to prevent this overhead
		if noArgTableEvents[event] then
			return handleEvent(nil, event, sourceGUID, sourceName and Ambiguate(sourceName, "none"), sourceFlags, sourceRaidFlags, destGUID, destName and Ambiguate(destName, "none"), destFlags, destRaidFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10)
		else
			twipe(args)
			args.timestamp = timestamp
			args.event = event
			args.sourceGUID = sourceGUID
			args.sourceName = sourceName and Ambiguate(sourceName, "none")
			args.sourceFlags = sourceFlags
			args.sourceRaidFlags = sourceRaidFlags
			args.destGUID = destGUID
			args.destName = destName and Ambiguate(destName, "none")
			args.destFlags = destFlags
			args.destRaidFlags = destRaidFlags
			if eventSub6 == "SPELL_" then
				args.spellId, args.spellName = extraArg1, extraArg2
				if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" or event == "SPELL_AURA_REMOVED" then
					args.amount = extraArg5
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
					args.amount = extraArg5
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_INTERRUPT" or event == "SPELL_DISPEL" or event == "SPELL_DISPEL_FAILED" or event == "SPELL_AURA_STOLEN" then
					args.extraSpellId, args.extraSpellName = extraArg4, extraArg5
				end
			elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "ENVIRONMENTAL_DAMAGE" then
				args.environmentalType, args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10
			end
			return handleEvent(nil, event, args)
		end
	end
	mainFrame:SetScript("OnEvent", handleEvent)
end

--------------
--  OnLoad  --
--------------
do
	local isLoaded = false
	local onLoadCallbacks, disabledMods = {}, {}

	local function infniteLoopNotice(self, message)
		AddMsg(self, message)
		self:Schedule(30, infniteLoopNotice, self, message)
	end

	local function runDelayedFunctions(self)
		--Check if voice pack missing
		local activeVP = self.Options.ChosenVoicePack2
		if activeVP ~= "None" then
			if not self.VoiceVersions[activeVP] or (self.VoiceVersions[activeVP] and self.VoiceVersions[activeVP] == 0) then--A voice pack is selected that does not belong
				voiceSessionDisabled = true
				--Since VEM is now bundled, users may elect to disable it by simiply disabling the module
				--let's not nag them, only remind for 3rd party because then we know user installed it themselves
				if activeVP ~= "VEM" then
					AddMsg(self, L.VOICE_MISSING)
				end
			end
		end
		--Check if any of countdown sounds are using missing voice pack
		local found1, found2, found3, found4 = false, false, false, false
		for _, count in pairs(DBM:GetCountSounds()) do
			local voice = count.value
			if voice == self.Options.CountdownVoice then
				found1 = true
			end
			if voice == self.Options.CountdownVoice2 then
				found2 = true
			end
			if voice == self.Options.CountdownVoice3 then
				found3 = true
			end
			if voice == self.Options.PullVoice then
				found4 = true
			end
		end
		if not found1 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(1, self.DefaultOptions.CountdownVoice))
			self.Options.CountdownVoice = self.DefaultOptions.CountdownVoice
		end
		if not found2 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(2, self.DefaultOptions.CountdownVoice2))
			self.Options.CountdownVoice2 = self.DefaultOptions.CountdownVoice2
		end
		if not found3 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(3, self.DefaultOptions.CountdownVoice3))
			self.Options.CountdownVoice3 = self.DefaultOptions.CountdownVoice3
		end
		if not found4 then
			AddMsg(self, L.VOICE_COUNT_MISSING:format(4, self.DefaultOptions.PullVoice))
			self.Options.PullVoice = self.DefaultOptions.PullVoice
		end
		self:BuildVoiceCountdownCache()
		--Break timer recovery
		--Try local settings
		if self.Options.RestoreSettingBreakTimer then
			local timer, startTime = string.split("/", self.Options.RestoreSettingBreakTimer)
			local elapsed = time() - tonumber(startTime)
			local remaining = timer - elapsed
			if remaining > 0 then
				breakTimerStart(DBM, remaining, playerName)
			else--It must have ended while we were offline, kill variable.
				self.Options.RestoreSettingBreakTimer = nil
			end
		end
		sendGuildSync(DBMSyncProtocol, "GH")
		if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
		end
	end

	-- register a callback that will be executed once the addon is fully loaded (ADDON_LOADED fired, saved vars are available)
	function DBM:RegisterOnLoadCallback(cb)
		if isLoaded then
			cb()
		else
			onLoadCallbacks[#onLoadCallbacks + 1] = cb
		end
	end

	function DBM:ADDON_LOADED(modname)
		if modname == "DBM-Core" and not isLoaded then
			dbmToc = tonumber(C_AddOns.GetAddOnMetadata("DBM-Core", "X-Min-Interface" .. (isClassic and "-Classic" or isBCC and "-BCC" or isCata and "-Cata" or isWrath and "-Wrath" or ""))) or 0
			isLoaded = true
			for _, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			loadOptions(self)
			DBT:LoadOptions("DBM")
			self.AddOns = {}
			private:OnModuleLoad()
			if C_AddOns.GetAddOnEnableState("VEM-Core", playerName) >= 1 then
				self:Disable(true)
				self:Schedule(15, infniteLoopNotice, self, L.VEM)
				return
			end
			if C_AddOns.GetAddOnEnableState("DBM-Profiles", playerName) >= 1 then
				self:Disable(true)
				self:Schedule(15, infniteLoopNotice, self, L.OUTDATEDPROFILES)
				return
			end
			if C_AddOns.GetAddOnEnableState("DBM-SpellTimers", playerName) >= 1 then
				---@type string|number
				local version = C_AddOns.GetAddOnMetadata("DBM-SpellTimers", "Version") or "r0"
				version = tonumber(string.sub(version, 2, 4)) or 0
				if version < 122 and not self.Options.DebugMode then
					self:Disable(true)
					self:Schedule(15, infniteLoopNotice, self, L.OUTDATEDSPELLTIMERS)
					return
				end
			end
			--DBM plater nameplate cooldown icons are enabled, but platers are not. Inform user feature is not fully enabled or fully disabled
			if Plater and not Plater.db.profile.bossmod_support_bars_enabled and not DBM.Options.DontShowNameplateIconsCD then
				C_TimerAfter(15, function() AddMsg(self, L.PLATER_NP_AURAS_MSG) end)
			end
			if C_AddOns.GetAddOnEnableState("DPMCore", playerName) >= 1 then
				self:Disable(true)
				self:Schedule(15, infniteLoopNotice, self, L.DPMCORE)
				return
			end
			if C_AddOns.GetAddOnEnableState("DBM-VictorySound", playerName) >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, L.VICTORYSOUND) end)
				return
			end
			if C_AddOns.GetAddOnEnableState("DBM-LDB", playerName) >= 1 then
				C_TimerAfter(15, function() AddMsg(self, L.DBMLDB) end)
			end
			if C_AddOns.GetAddOnEnableState("DBM-LootReminder", playerName) >= 1 then
				C_TimerAfter(15, function() AddMsg(self, L.DBMLOOTREMINDER) end)
			end
			self.Arrow:LoadPosition()
			-- LibDBIcon setup
			if type(DBM_MinimapIcon) ~= "table" then
				DBM_MinimapIcon = {}
			end
			if LibStub and LibStub("LibDBIcon-1.0", true) then
				local LibDBIcon = LibStub("LibDBIcon-1.0")
				LibDBIcon:Register("DBM", private.dataBroker, DBM_MinimapIcon)
				if DBM_MinimapIcon.showInCompartment == nil then
					LibDBIcon:AddButtonToCompartment("DBM")
				end
			end
			local soundChannels = tonumber(GetCVar("Sound_NumChannels")) or 24--if set to 24, may return nil, Defaults usually do
			--If this messes with your fps, stop raiding with a toaster. It's only fix for addon sound ducking.
			if soundChannels < 64 then
				SetCVar("Sound_NumChannels", 64)
			end
			self.Voices = {{text = "None", value = "None"}}--Create voice table, with default "None" value
			self.VoiceVersions = {}
			for i = 1, C_AddOns.GetNumAddOns() do
				local addonName = C_AddOns.GetAddOnInfo(i)
				local enabled = C_AddOns.GetAddOnEnableState(i, playerName)
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod") then
					if enabled ~= 0 then
						if checkEntry(bannedMods, addonName) then
							AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
						else
							local mapIdTable = {strsplit(",", C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-MapID") or "")}

							local minToc = tonumber(C_AddOns.GetAddOnMetadata(i, "X-Min-Interface") or 0)
							if isBCC then
								minToc = tonumber(C_AddOns.GetAddOnMetadata(i, "X-Min-Interface-BCC") or minToc)
							elseif isCata then
								minToc = tonumber(C_AddOns.GetAddOnMetadata(i, "X-Min-Interface-Cata") or minToc)
							elseif isWrath then
								minToc = tonumber(C_AddOns.GetAddOnMetadata(i, "X-Min-Interface-Wrath") or minToc)
							end

							local firstMapId = mapIdTable[1]
							local firstMapName
							if tonumber(firstMapId) then
								firstMapName = GetRealZoneText(tonumber(firstMapId))
							elseif firstMapId:sub(1, 1) == "m" then
								firstMapName = C_Map.GetMapInfo(tonumber(firstMapId:sub(2)) or 0)
								firstMapName = firstMapName and firstMapName.name
							end
							for j = #mapIdTable, 1, -1 do
								local id = tonumber(mapIdTable[j])
								if id then
									mapIdTable[j] = id
								elseif not (mapIdTable[j]:sub(1, 1) == "m" and tonumber(mapIdTable[j]:sub(2))) then
									tremove(mapIdTable, j)
								end
							end

							tinsert(self.AddOns, {
								sort			= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Sort") or mhuge) or mhuge,
								type			= C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Type") or "OTHER",
								category		= C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
								statTypes		= isWrath and C_AddOns.GetAddOnMetadata(i, "X-DBM-StatTypes-Wrath") or C_AddOns.GetAddOnMetadata(i, "X-DBM-StatTypes") or "",
								name			= C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Name") or firstMapName or CL.UNKNOWN,
								mapId			= mapIdTable,
								subTabs			= C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID") and {strsplit(",", C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID"))} or C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
								oneFormat		= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Has-Single-Format") or 0) == 1, -- Deprecated
								hasLFR			= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Has-LFR") or 0) == 1, -- Deprecated
								hasChallenge	= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Has-Challenge") or 0) == 1, -- Deprecated
								noHeroic		= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-No-Heroic") or 0) == 1, -- Deprecated
								hasMythic		= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Has-Mythic") or 0) == 1, -- Deprecated
								hasTimeWalker	= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Has-TimeWalker") or 0) == 1, -- Deprecated
								noStatistics	= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-No-Statistics") or 0) == 1,
								isWorldBoss		= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-World-Boss") or 0) == 1,
								isExpedition	= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-Expedition") or 0) == 1,
								minRevision		= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-MinCoreRevision") or 0),
								minExpansion	= tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-MinExpansion") or 0),
								minToc			= minToc,
								modId			= addonName,
							})
							if self.AddOns[#self.AddOns].subTabs then
								local subTabs = self.AddOns[#self.AddOns].subTabs
								for k, _ in ipairs(subTabs) do
									--Ugly hack to inject custom string text into auto localized zone name sub cats
									if subTabs[k]:find("|") then
										local id, nameModifier = strsplit("|", subTabs[k])
										if id and nameModifier then
											id = tonumber(id)
											self.AddOns[#self.AddOns].subTabs[k] = (GetRealZoneText(id):trim() or id) .. " (" .. nameModifier .. ")"
										else
											self.AddOns[#self.AddOns].subTabs[k] = (subTabs[k]):trim()
										end
									else
										local id = tonumber(subTabs[k])
										if id then
											self.AddOns[#self.AddOns].subTabs[k] = strsplit("-", GetRealZoneText(id):trim() or id)--For handling zones like Warfront: Arathi - Alliance
										else
											self.AddOns[#self.AddOns].subTabs[k] = (subTabs[k]):trim()
										end
									end
								end
							end
							if C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-LoadCID") then
								local idTable = {strsplit(",", C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-LoadCID"))}
								for j = 1, #idTable do
									loadcIds[tonumber(idTable[j]) or ""] = addonName
								end
							end
						end
					else
						disabledMods[#disabledMods + 1] = addonName
					end
				end
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						C_TimerAfter(0.01, function()
							local voiceValue = C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-ShortName")
							local voiceVersion = tonumber(C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-Version") or 0)
							if voiceVersion > 0 then--Do not insert voice version 0 into THIS table. 0 should be used by voice packs that insert only countdown
								tinsert(self.Voices, {text = C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-Name"), value = voiceValue})
							end
							self.VoiceVersions[voiceValue] = voiceVersion
							self:Schedule(10, self.CheckVoicePackVersion, self, voiceValue)--Still at 1 since the count sounds won't break any mods or affect filter. V2 if support countsound path
							if C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-HasCount") then--Supports adding countdown options, insert new countdown into table
								DBM:AddCountSound(C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-Name"), "VP: " .. voiceValue, "Interface\\AddOns\\DBM-VP" .. voiceValue .. "\\count\\")
							end
						end)
					end
				end
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-CountPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = C_AddOns.LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local voiceGlobal = C_AddOns.GetAddOnMetadata(i, "X-DBM-CountPack-GlobalName")
							local insertFunction = _G[voiceGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName .. " failed to load at time CountPack function " .. voiceGlobal .. "ran", 2)
							end
						end)
					end
				end
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-VictoryPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = C_AddOns.LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local victoryGlobal = C_AddOns.GetAddOnMetadata(i, "X-DBM-VictoryPack-GlobalName")
							local insertFunction = _G[victoryGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName .. " failed to load at time VictoryPack function " .. victoryGlobal .. " ran", 2)
							end
						end)
					end
				end
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-DefeatPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = C_AddOns.LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local defeatGlobal = C_AddOns.GetAddOnMetadata(i, "X-DBM-DefeatPack-GlobalName")
							local insertFunction = _G[defeatGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName .. " failed to load at time DefeatPack function " .. defeatGlobal .. " ran", 2)
							end
						end)
					end
				end
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-MusicPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = C_AddOns.LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local musicGlobal = C_AddOns.GetAddOnMetadata(i, "X-DBM-MusicPack-GlobalName")
							local insertFunction = _G[musicGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName .. " failed to load at time MusicPack function " .. musicGlobal .. " ran", 2)
							end
						end)
					end
				end
			end
			tsort(self.AddOns, function(v1, v2) return v1.sort < v2.sort end)
			self:RegisterEvents(
				"COMBAT_LOG_EVENT_UNFILTERED",
				"GROUP_ROSTER_UPDATE",
				"INSTANCE_GROUP_SIZE_CHANGED",
				"CHAT_MSG_ADDON",
				"CHAT_MSG_ADDON_LOGGED",
				"BN_CHAT_MSG_ADDON",
				"PLAYER_REGEN_DISABLED",
				"PLAYER_REGEN_ENABLED",
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
				"ENCOUNTER_START",
				"ENCOUNTER_END",
				"BOSS_KILL",
				"UNIT_DIED",
				"UNIT_DESTROYED",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_BN_WHISPER",
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_MONSTER_SAY",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"RAID_BOSS_EMOTE",
				"RAID_BOSS_WHISPER",
				"PLAYER_ENTERING_WORLD",
				"READY_CHECK",
				"UPDATE_BATTLEFIELD_STATUS",
				"PLAY_MOVIE",
				"CINEMATIC_START",
				"CINEMATIC_STOP",
				"PLAYER_LEVEL_CHANGED",
				"PARTY_INVITE_REQUEST",
				"LOADING_SCREEN_DISABLED",
				"LOADING_SCREEN_ENABLED",
				"ZONE_CHANGED_NEW_AREA"
			)
			if not isClassic then -- Retail, WoTLKC, and BCC
				self:RegisterEvents(
					"LFG_PROPOSAL_FAILED",
					"LFG_PROPOSAL_SHOW",
					"LFG_PROPOSAL_SUCCEEDED",
					"LFG_ROLE_CHECK_SHOW"
				)
			end
			if isRetail then
				self:RegisterEvents(
					"UNIT_HEALTH mouseover target focus player",--Is Frequent on retail, and _FREQUENT deleted
					"CHALLENGE_MODE_RESET",
					"PLAYER_SPECIALIZATION_CHANGED",
					"SCENARIO_COMPLETED",
					"GOSSIP_SHOW"
				)
			elseif isBCC or isClassic then
				self:RegisterEvents(
					"UNIT_HEALTH_FREQUENT mouseover target focus player",--Still exists in classic and non frequent is slow and less reliable
					"CHARACTER_POINTS_CHANGED"
				)
			else -- WoTLKC and Cata
				self:RegisterEvents(
					"UNIT_HEALTH_FREQUENT mouseover target focus player",--Still exists in classic and non frequent is slow and less reliable
					"CHARACTER_POINTS_CHANGED",
					"PLAYER_TALENT_UPDATE"
				)
			end
			if RolePollPopup and RolePollPopup:IsEventRegistered("ROLE_POLL_BEGIN") and isRetail then
				RolePollPopup:UnregisterEvent("ROLE_POLL_BEGIN")
			end
			self:GROUP_ROSTER_UPDATE(true)
			C_TimerAfter(1.5, function()
				combatInitialized = true
			end)
			C_TimerAfter(20, function()--Delay UNIT_HEALTH combat start for 20 sec. (not to break Timer Recovery stuff)
				healthCombatInitialized = true
			end)
			self:Schedule(10, runDelayedFunctions, self)
			self:ZONE_CHANGED_NEW_AREA()
		end
	end
end

-----------------
--  Callbacks  --
-----------------
do
	local callbacks = {}

	function fireEvent(event, ...)
		if not callbacks[event] then return end
		for _, v in ipairs(callbacks[event]) do
		    securecall(v, event, ...)
		end
	end

	function DBM:FireEvent(event, ...)
		fireEvent(event, ...)
	end

	function DBM:IsCallbackRegistered(event, f)
		if not event or type(f) ~= "function" then
			error("Usage: IsCallbackRegistered(event, callbackFunc)", 2)
		end
		if not callbacks[event] then return end
		for i = 1, #callbacks[event] do
			if callbacks[event][i] == f then return true end
		end
		return false
	end

	function DBM:RegisterCallback(event, f)
		if not event or type(f) ~= "function" then
			error("Usage: DBM:RegisterCallback(event, callbackFunc)", 2)
		end
		callbacks[event] = callbacks[event] or {}
		tinsert(callbacks[event], f)
		return #callbacks[event]
	end

	function DBM:UnregisterCallback(event, f)
		if not event or not callbacks[event] then return end
		if f then
			if type(f) ~= "function" then
				error("Usage: DBM:UnregisterCallback(event, callbackFunc)", 2)
			end
			--> checking from the end to start and not stoping after found one result in case of a func being twice registered.
			for i = #callbacks[event], 1, -1 do
				if callbacks[event][i] == f then tremove(callbacks[event], i) end
			end
		else
			error("Usage: DBM:UnregisterCallback(event, callbackFunc)", 2)
		end
	end
end

--------------------------
--  OnUpdate/Scheduler  --
--------------------------
local DBMScheduler = private:GetModule("DBMScheduler")

function DBM:Schedule(t, f, ...)
	return DBMScheduler:Schedule(t, f, nil, ...)
end

function DBM:Unschedule(f, ...)
	return DBMScheduler:Unschedule(f, nil, ...)
end

---------------
--  Profile  --
---------------
function DBM:CreateProfile(name)
	if not name or name == "" or name:find(" ") then
		self:AddMsg(L.PROFILE_CREATE_ERROR)
		return
	end
	if DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_CREATE_ERROR_D:format(name))
		return
	end
	-- create profile
	usedProfile = name
	DBM_UsedProfile = usedProfile
	DBM_AllSavedOptions[usedProfile] = DBM_AllSavedOptions[usedProfile] or {}
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	DBT:CreateProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_CREATED:format(name))
end

function DBM:ApplyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_APPLY_ERROR:format(name or CL.UNKNOWN))
		return
	end
	usedProfile = name
	DBM_UsedProfile = usedProfile
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	DBT:ApplyProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_APPLIED:format(name))
end

function DBM:CopyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_COPY_ERROR:format(name or CL.UNKNOWN))
		return
	elseif name == usedProfile then
		self:AddMsg(L.PROFILE_COPY_ERROR_SELF)
		return
	end
	DBM_AllSavedOptions[usedProfile] = CopyTable(DBM_AllSavedOptions[name])
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	DBT:CopyProfile(name, "DBM", true)
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_COPIED:format(name))
end

function DBM:DeleteProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_DELETE_ERROR:format(name or CL.UNKNOWN))
		return
	elseif name == "Default" then-- Default profile cannot be deleted.
		self:AddMsg(L.PROFILE_CANNOT_DELETE)
		return
	end
	--Delete
	DBM_AllSavedOptions[name] = nil
	usedProfile = "Default"--Restore to default
	DBM_UsedProfile = usedProfile
	self.Options = DBM_AllSavedOptions[usedProfile]
	if not self.Options then
		-- the default profile got lost somehow (maybe WoW crashed and the saved variables file got corrupted)
		self:CreateProfile("Default")
	end
	-- rearrange position
	DBT:DeleteProfile(name, "DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_DELETED:format(name))
end

function DBM:RepositionFrames()
	-- rearrange position
	self:UpdateWarningOptions()
	self:UpdateSpecialWarningOptions()
	self.Arrow:LoadPosition()
	local rangeCheck = _G["DBMRangeCheck"]
	if rangeCheck then
		rangeCheck:ClearAllPoints()
		rangeCheck:SetPoint(self.Options.RangeFramePoint, UIParent, self.Options.RangeFramePoint, self.Options.RangeFrameX, self.Options.RangeFrameY)
	end
	local rangeCheckRadar = _G["DBMRangeCheckRadar"]
	if rangeCheckRadar then
		rangeCheckRadar:ClearAllPoints()
		rangeCheckRadar:SetPoint(self.Options.RangeFrameRadarPoint, UIParent, self.Options.RangeFrameRadarPoint, self.Options.RangeFrameRadarX, self.Options.RangeFrameRadarY)
	end
	local infoFrame = _G["DBMInfoFrame"]
	if infoFrame then
		infoFrame:ClearAllPoints()
		infoFrame:SetPoint(self.Options.InfoFramePoint, UIParent, self.Options.InfoFramePoint, self.Options.InfoFrameX, self.Options.InfoFrameY)
	end
end

----------------------
--  Slash Commands  --
----------------------

do
	local function Sort(v1, v2)
		if v1.revision and not v2.revision then
			return true
		elseif v2.revision and not v1.revision then
			return false
		elseif v1.revision and v2.revision then
			return v1.revision > v2.revision
		else
			return (v1.bwversion or 0) > (v2.bwversion or 0)
		end
	end

	function DBM:ShowVersions(notify)
		local sortMe, outdatedUsers = {}, {}
		for _, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, Sort)
		self:AddMsg(L.VERSIONCHECK_HEADER)
		for _, v in ipairs(sortMe) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.displayVersion and not v.bwversion then--DBM, no BigWigs
				if self.Options.ShowAllVersions then
					self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.DBM .. " " .. v.displayVersion, showRealDate(v.revision), v.VPVersion or ""), false)--Only display VP version if not running two mods
				end
				if notify and v.revision < self.ReleaseRevision then
					SendChatMessage(chatPrefixShort .. L.YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
				end
			elseif self.Options.ShowAllVersions and v.displayVersion and v.bwversion then--DBM & BigWigs
				self:AddMsg(L.VERSIONCHECK_ENTRY_TWO:format(name, L.DBM .. " " .. v.displayVersion, showRealDate(v.revision), L.BIG_WIGS, bwVersionResponseString:format(v.bwversion, v.bwhash)), false)
			elseif self.Options.ShowAllVersions and not v.displayVersion and v.bwversion then--BigWigs, No DBM
				self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.BIG_WIGS, bwVersionResponseString:format(v.bwversion, v.bwhash), ""), false)
			else
				if self.Options.ShowAllVersions then
					self:AddMsg(L.VERSIONCHECK_ENTRY_NO_DBM:format(name), false)
				end
			end
		end
		local NoDBM = 0
		local NoBigwigs = 0
		local OldMod = 0
		for i = #sortMe, 1, -1 do
			if not sortMe[i].revision then
				NoDBM = NoDBM + 1
			end
			if not (sortMe[i].bwversion) then
				NoBigwigs = NoBigwigs + 1
			end
			--Table sorting sorts dbm to top, bigwigs underneath. Highest version dbm always at top. so sortMe[1]
			--This check compares all dbm version to highest RELEASE version in raid.
			if sortMe[i].revision and (sortMe[i].revision < sortMe[1].version) or sortMe[i].bwversion and (sortMe[i].bwversion < fakeBWVersion) then
				OldMod = OldMod + 1
				local name = sortMe[i].name
				local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
				if playerColor then
					name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
				end
				tinsert(outdatedUsers, name)
			end
		end
		local TotalUsers = #sortMe
		self:AddMsg("---", false)
		self:AddMsg(L.VERSIONCHECK_FOOTER:format(TotalUsers - NoDBM, TotalUsers - NoBigwigs), false)
		self:AddMsg(L.VERSIONCHECK_OUTDATED:format(OldMod, #outdatedUsers > 0 and tconcat(outdatedUsers, ", ") or NONE), false)
	end
end

-------------------
--  Pizza Timer  --
-------------------
do

	local function loopTimer(time, text, broadcast, sender)
		DBM:CreatePizzaTimer(time, text, broadcast, sender, true)
	end

	local ignore = {}
	--Standard Pizza Timer
	function DBM:CreatePizzaTimer(time, text, broadcast, sender, loop, terminate, whisperTarget)
		if terminate or time == 0 then
			self:Unschedule(loopTimer)
			DBT:CancelBar(text)
			fireEvent("DBM_TimerStop", "DBMPizzaTimer")
			-- Fire cancelation of pizza timer
			if broadcast then
				text = text:sub(1, 16)
				text = text:gsub("%%t", UnitName("target") or "<no target>")
				if whisperTarget then
					C_ChatInfo.SendAddonMessageLogged(DBMPrefix, (DBMSyncProtocol .. "\tUW\t0\t%s"):format(text), "WHISPER", whisperTarget)
				else
					sendLoggedSync(DBMSyncProtocol, "U", ("0\t%s"):format(text))
				end
			end
			return
		end
		if sender and ignore[sender] then return end
		text = text:sub(1, 16)
		text = text:gsub("%%t", UnitName("target") or "<no target>")
		if time < 3 then
			self:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		DBT:CreateBar(time, text, isRetail and 237538 or 134376)
		fireEvent("DBM_TimerStart", "DBMPizzaTimer", text, time, isRetail and "237538" or "134376", "pizzatimer", nil, 0)
		if broadcast then
			if whisperTarget then
				--no dbm function uses whisper for pizza timers
				--this allows weak aura creators or other modders to use the pizza timer object unicast via whisper instead of spamming group sync channels
				C_ChatInfo.SendAddonMessageLogged(DBMPrefix, (DBMSyncProtocol .. "\tUW\t%s\t%s"):format(time, text), "WHISPER", whisperTarget)
			else
				sendLoggedSync(DBMSyncProtocol, "U", ("%s\t%s"):format(time, text))
			end
		end
		if sender then self:ShowPizzaInfo(text, sender) end
		if loop then
			self:Unschedule(loopTimer)--Only one loop timer supported at once doing this, but much cleaner this way
			self:Schedule(time, loopTimer, time, text, broadcast, sender)
		end
	end

	function DBM:AddToPizzaIgnore(name)
		ignore[name] = true
	end
end

function DBM:ShowPizzaInfo(id, sender)
	if self.Options.ShowPizzaMessage then
		self:AddMsg(L.PIZZA_SYNC_INFO:format(sender, id))
	end
end

-----------------
--  GUI Stuff  --
-----------------
do
	local callOnLoad = {}
	function DBM:LoadGUI()
		if C_AddOns.GetAddOnEnableState("VEM-Core", playerName) >= 1 then
			self:AddMsg(L.VEM)
			return
		end
		if C_AddOns.GetAddOnEnableState("DBM-Profiles", playerName) >= 1 then
			self:AddMsg(L.OUTDATEDPROFILES)
			return
		end
		if C_AddOns.GetAddOnEnableState("DBM-SpellTimers", playerName) >= 1 then
			---@type number|string
			local version = C_AddOns.GetAddOnMetadata("DBM-SpellTimers", "Version") or "r0"
			version = tonumber(string.sub(version, 2, 4)) or 0
			if version < 122 and not self.Options.DebugMode then
				self:AddMsg(L.OUTDATEDSPELLTIMERS)
				return
			end
		end
		if C_AddOns.GetAddOnEnableState("DPMCore", playerName) >= 1 then
			self:AddMsg(L.DPMCORE)
			return
		end
		if C_AddOns.GetAddOnEnableState("DBM-VictorySound", playerName) >= 1 then
			self:AddMsg(L.VICTORYSOUND)
			return
		end
		if not dbmIsEnabled then
			self:ForceDisableSpam()
			return
		end
		if self.NewerVersion and showConstantReminder >= 1 then
			AddMsg(self, L.UPDATEREMINDER_HEADER:format(self.NewerVersion, showRealDate(self.HighestRelease)))
		end
		local firstLoad = false
		if not C_AddOns.IsAddOnLoaded("DBM-GUI") then
			local enabled = C_AddOns.GetAddOnEnableState("DBM-GUI", playerName)
			if enabled == 0 then
				C_AddOns.EnableAddOn("DBM-GUI")
			end
			local loaded, reason = C_AddOns.LoadAddOn("DBM-GUI")
			if not loaded then
				if reason and _G["ADDON_" .. reason] then
					self:AddMsg(L.LOAD_GUI_ERROR:format(tostring(_G["ADDON_" .. reason])))
				else
					self:AddMsg(L.LOAD_GUI_ERROR:format(CL.UNKNOWN))
				end
				return false
			end
--			if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
--				collectgarbage("collect")
--			end
			firstLoad = true
		end
		DBM_GUI:ShowHide()
		if firstLoad then
			tsort(callOnLoad, function(v1, v2) return v1[2] < v2[2] end)
			for _, v in ipairs(callOnLoad) do v[1]() end
		end
	end

	function DBM:RegisterOnGuiLoadCallback(f, sort)
		tinsert(callOnLoad, {f, sort or mhuge})
	end
end

-------------------------------------------------
--  Raid/Party Handling and Unit ID Utilities  --
-------------------------------------------------
do
	local UnitInRaid = UnitInRaid
	local bwVersionQueryString = "Q^%d^%s"--Only used here
	local inRaid = false

	local raidGuids = {}
	local iconSeter = {}

	--	save playerinfo into raid table on load. (for solo raid)
	DBM:RegisterOnLoadCallback(function()
		C_TimerAfter(6, function()
			if not raid[playerName] then
				raid[playerName] = {}
				raid[playerName].name = playerName
				raid[playerName].shortname = playerName
				raid[playerName].guid = UnitGUID("player")
				raid[playerName].rank = 0
				raid[playerName].class = playerClass
				raid[playerName].id = "player"
				raid[playerName].groupId = 0
				raid[playerName].revision = DBM.Revision
				raid[playerName].version = DBM.ReleaseRevision
				raid[playerName].displayVersion = DBM.DisplayVersion
				raid[playerName].locale = GetLocale()
				raid[playerName].enabledIcons = tostring(not DBM.Options.DontSetIcons)
				raidGuids[UnitGUID("player") or ""] = playerName
			end
		end)
	end)

	local function updateAllRoster(self)
		if IsInRaid() then
			if not inRaid then
				twipe(newerVersionPerson)--Wipe guild syncs on group join so we trigger a new out of date notice on raid join even if one triggered on login
				twipe(forceDisablePerson)
				inRaid = true
				sendSync(DBMSyncProtocol, "H")
				if dbmIsEnabled then
					SendAddonMessage("BigWigs", bwVersionQueryString:format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
				end
				if isRetail then
					self:Schedule(2, self.RoleCheck, false, self)
				end
				fireEvent("DBM_raidJoin", playerName)
				local bigWigs = _G["BigWigs"]
				if bigWigs and bigWigs.db.profile.raidicon and not self.Options.DontSetIcons and self:GetRaidRank() > 0 then--Both DBM and bigwigs have raid icon marking turned on.
					self:AddMsg(L.BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either or turned off to stop this alert)
				end
			end
			for i = 1, GetNumGroupMembers() do
				local name, rank, subgroup, _, _, className, _, isOnline = GetRaidRosterInfo(i)
				-- Maybe GetNumGroupMembers() bug? Seems that GetNumGroupMembers() rarely returns bad value, causing GetRaidRosterInfo() returns to nil.
				-- Filter name = nil to prevent nil table error.
				if name then
					local id = "raid" .. i
					local shortname = UnitName(id)
					if (not raid[name]) and inRaid then
						fireEvent("DBM_raidJoin", name)
					end
					raid[name] = raid[name] or {}
					raid[name].name = name
					raid[name].shortname = shortname
					raid[name].rank = rank
					raid[name].subgroup = subgroup
					raid[name].class = className
					raid[name].id = id
					raid[name].groupId = i
					raid[name].guid = UnitGUID(id) or ""
					raid[name].updated = true
					raid[name].isOnline = isOnline
					raidGuids[UnitGUID(id) or ""] = name
					if rank == 2 then
						lastGroupLeader = name
					end
				end
			end
			private.enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					removeEntry(forceDisablePerson, i)
					fireEvent("DBM_raidLeave", i)
				else
					v.updated = nil
					if v.revision and v.isOnline and v.rank > 0 and (v.enabledIcons or "") == "true" then
						iconSeter[#iconSeter + 1] = v.revision .. " " .. v.name
					end
				end
			end
			if #iconSeter > 0 then
				tsort(iconSeter, function(a, b) return a > b end)
				local elected = iconSeter[1]
				if playerName == elected:sub(elected:find(" ") + 1) then--Highest revision in raid, auto allow, period, even if out of date, you're revision in raid that has assist
					private.enableIcons = true
					DBM:Debug("You have been elected as primary icon setter for raid for having newest revision in raid that has assist/lead", 2)
				end
				--Initiate backups that at least have latest version, in case the main elect doesn't have icons enabled
				for i = 2, 3 do--Allow top 3 revisions in raid to set icons, instead of just top one
					local electedBackup = iconSeter[i]
					if updateNotificationDisplayed == 0 and electedBackup and playerName == electedBackup:sub(elected:find(" ") + 1) then
						private.enableIcons = true
						DBM:Debug("You have been elected as one of 2 backup icon setters in raid that have assist/lead", 2)
					end
				end
			end
			--Recheck elected icon if group changed mid combat, so we don't end up in situation no icons are set because setter bounced
			if #inCombat > 0 then--At least one boss is engaged
				for i = #inCombat, 1, -1 do
					local mod = inCombat[i]
					if mod then
						self:ElectIconSetter(mod)
					end
				end
			end
		elseif IsInGroup() then
			if not inRaid then
				-- joined a new party
				twipe(newerVersionPerson)--Wipe guild syncs on group join so we trigger a new out of date notice on raid join even if one triggered on login
				twipe(forceDisablePerson)
				inRaid = true
				sendSync(DBMSyncProtocol, "H")
				if dbmIsEnabled then
					SendAddonMessage("BigWigs", bwVersionQueryString:format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
				end
				if isRetail then
					self:Schedule(2, self.RoleCheck, false, self)
				end
				fireEvent("DBM_partyJoin", playerName)
			end
			for i = 0, GetNumSubgroupMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party" .. i
				end
				local name = GetUnitName(id, true)
				local shortname = UnitName(id)
				local rank = UnitIsGroupLeader(id) and 2 or 0
				local _, className = UnitClass(id)
				local isOnline = UnitIsConnected(id)
				if (not raid[name]) and inRaid then
					fireEvent("DBM_partyJoin", name)
				end
				raid[name] = raid[name] or {}
				raid[name].name = name
				raid[name].shortname = shortname
				raid[name].guid = UnitGUID(id) or ""
				raid[name].rank = rank
				raid[name].class = className
				raid[name].id = id
				raid[name].groupId = i
				raid[name].updated = true
				raid[name].isOnline = isOnline
				raidGuids[UnitGUID(id) or ""] = name
				if rank >= 1 then
					lastGroupLeader = name
				end
			end
			private.enableIcons = false
			twipe(iconSeter)
			for k, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[k] = nil
					removeEntry(newerVersionPerson, k)
					removeEntry(forceDisablePerson, k)
					fireEvent("DBM_partyLeave", k)
				else
					v.updated = nil
					if v.revision and v.isOnline and v.rank > 0 and (v.enabledIcons or "") == "true" then
						iconSeter[#iconSeter + 1] = v.revision .. " " .. v.name
					end
				end
			end
			if #iconSeter > 0 then
				tsort(iconSeter, function(a, b) return a > b end)
				local elected = iconSeter[1]
				if playerName == elected:sub(elected:find(" ") + 1) then
					private.enableIcons = true
				end
			end
			--Recheck elected icon if group changed mid combat, so we don't end up in situation no icons are set because setter bounced
			if #inCombat > 0 then--At least one boss is engaged
				for i = #inCombat, 1, -1 do
					local mod = inCombat[i]
					if mod then
						self:ElectIconSetter(mod)
					end
				end
			end
		else
			-- left the current group/raid
			inRaid = false
			private.enableIcons = true
			fireEvent("DBM_raidLeave", playerName)
			twipe(raid)
			twipe(newerVersionPerson)
			twipe(forceDisablePerson)
			-- restore playerinfo into raid table on raidleave. (for solo raid)
			raid[playerName] = {}
			raid[playerName].name = playerName
			raid[playerName].shortname = playerName
			raid[playerName].guid = UnitGUID("player")
			raid[playerName].rank = 0
			raid[playerName].class = playerClass
			raid[playerName].id = "player"
			raid[playerName].groupId = 0
			raid[playerName].revision = DBM.Revision
			raid[playerName].version = DBM.ReleaseRevision
			raid[playerName].displayVersion = DBM.DisplayVersion
			raid[playerName].locale = GetLocale()
			raidGuids[UnitGUID("player")] = playerName
			lastGroupLeader = nil
		end
	end

	function DBM:GROUP_ROSTER_UPDATE(force)
		self:Unschedule(updateAllRoster)
		--Updated with no throttle on ADDON_LOADDED, DBM:LoadMod and if in combat with a boss
		if force or #inCombat > 0 then
			updateAllRoster(self)
		else
			self:Schedule(3, updateAllRoster, self)
		end
	end

	function DBM:INSTANCE_GROUP_SIZE_CHANGED()
		local _, _, _, _, _, _, _, _, instanceGroupSize = GetInstanceInfo()
		LastGroupSize = instanceGroupSize
	end

	--C_Map.GetMapGroupMembersInfo
	function DBM:GetNumRealPlayersInZone()
		if not IsInGroup() then return 1 end
		local total = 0
		local currentMapId = select(-1, UnitPosition("player"))
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				local targetMapId = select(-1, UnitPosition("raid" .. i))
				if targetMapId == currentMapId then
					total = total + 1
				end
			end
		else
			total = 1--add player/self for "party" count
			for i = 1, GetNumSubgroupMembers() do
				local targetMapId = select(-1, UnitPosition("party" .. i))
				if targetMapId == currentMapId then
					total = total + 1
				end
			end
		end
		return total
	end

	function DBM:GetNumGuildPlayersInZone() -- Classic/BCC only
		if not IsInGroup() then return 1 end
		local total = 0
		local myGuild = GetGuildInfo("player")
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				local unitGuild = GetGuildInfo("raid" .. i)--This api only works if unit is nearby, so don't even need to check location
				if unitGuild and unitGuild == myGuild then
					total = total + 1
				end
			end
		else
			total = 1--add player/self for "party" count
			for i = 1, GetNumSubgroupMembers() do
				local unitGuild = GetGuildInfo("party" .. i)--This api only works if unit is nearby, so don't even need to check location
				if unitGuild and unitGuild == myGuild then
					total = total + 1
				end
			end
		end
		return total
	end

	function DBM:GetRaidRank(name)
		name = name or playerName
		if name == playerName then--If name is player, try to get actual rank. Because raid[name].rank sometimes seems returning 0 even player is promoted.
			return UnitIsGroupLeader("player") and 2 or UnitIsGroupAssistant("player") and 1 or 0
		else
			return (raid[name] and raid[name].rank) or 0
		end
	end

	function DBM:GetRaidSubgroup(name)
		return (raid[name] and raid[name].subgroup) or 0
	end

	---@param name string
	---@return boolean
	---@overload fun(self: DBM): table
	function DBM:GetRaidRoster(name)
		if name then
			return raid[name] ~= nil
		end
		return raid
	end

	function DBM:GetRaidClass(name)
		if raid[name] then
			return raid[name].class or "UNKNOWN", raid[name].id and GetRaidTargetIndex(raid[name].id) or 0
		else
			return "UNKNOWN", 0
		end
	end

	--This is primarily used for cached player unitIds by name lookup
	--I'm not even sure why a boss check is in it, since GetBossUnitId existed (and is now deprecated)
	--I'll leave the boss checking for now since I don't know if any mods (or core) are using this function this way
	function DBM:GetRaidUnitId(name)
		for i = 1, 10 do
			local unitId = "boss" .. i
			local bossName = UnitName(unitId)
			if bossName and bossName == name then
				return unitId
			end
		end
		return raid[name] and raid[name].id
	end

	local fullUids = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "boss6", "boss7", "boss8", "boss9", "boss10",
		"mouseover", "target", "focus", "focustarget", "targettarget", "mouseovertarget",
		"party1target", "party2target", "party3target", "party4target",
		"raid1target", "raid2target", "raid3target", "raid4target", "raid5target", "raid6target", "raid7target", "raid8target", "raid9target", "raid10target",
		"raid11target", "raid12target", "raid13target", "raid14target", "raid15target", "raid16target", "raid17target", "raid18target", "raid19target", "raid20target",
		"raid21target", "raid22target", "raid23target", "raid24target", "raid25target", "raid26target", "raid27target", "raid28target", "raid29target", "raid30target",
		"raid31target", "raid32target", "raid33target", "raid34target", "raid35target", "raid36target", "raid37target", "raid38target", "raid39target", "raid40target",
		"nameplate1", "nameplate2", "nameplate3", "nameplate4", "nameplate5", "nameplate6", "nameplate7", "nameplate8", "nameplate9", "nameplate10",
		"nameplate11", "nameplate12", "nameplate13", "nameplate14", "nameplate15", "nameplate16", "nameplate17", "nameplate18", "nameplate19", "nameplate20",
		"nameplate21", "nameplate22", "nameplate23", "nameplate24", "nameplate25", "nameplate26", "nameplate27", "nameplate28", "nameplate29", "nameplate30",
		"nameplate31", "nameplate32", "nameplate33", "nameplate34", "nameplate35", "nameplate36", "nameplate37", "nameplate38", "nameplate39", "nameplate40"
	}

	local bossTargetuIds = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "boss6", "boss7", "boss8", "boss9", "boss10"
	}

	--Not to be confused with GetUnitIdFromCID
	function DBM:GetUnitIdFromGUID(guid, bossOnly)
		local returnUnitID
		--First use blizzard internal client token check but only if it's not boss only
		--(because blizzard checks every token imaginable, even more than fullUids does and they have boss as the END in their order selection)
		--DBM prioiritzes the most common/useful tokens first, and rarely iterates passed even boss1, which is first token in OUR priorities
		if UnitTokenFromGUID and not bossOnly then
			returnUnitID = UnitTokenFromGUID(guid)
		end
		if returnUnitID then
			return returnUnitID
		else
			local usedTable = bossOnly and bossTargetuIds or fullUids
			for _, unitId in ipairs(usedTable) do
				local guid2 = UnitGUID(unitId)
				if guid == guid2 then
					return unitId
				end
			end
		end
	end

	--Not to be confused with GetUnitIdFromGUID, in this function we don't know a specific guid so can't use UnitTokenFromGUID
	function DBM:GetUnitIdFromCID(creatureID, bossOnly)
		--Always prioritize a quick boss unit scan on retail first
		if not isClassic and not isBCC then
			for i = 1, 10 do
				local unitId = "boss" .. i
				local bossGUID = UnitGUID(unitId)
				local cid = self:GetCIDFromGUID(bossGUID)
				if cid == creatureID then
					return unitId
				end
			end
		end
		if not bossOnly then
			for _, unitId in ipairs(fullUids) do
				local guid2 = UnitGUID(unitId)
				local cid = self:GetCIDFromGUID(guid2)
				if cid == creatureID then
					return unitId
				end
			end
		end
	end

	--Deprecated, only old mods use this (newer mods use GetUnitIdFromGUID or GetUnitIdFromCID)
	function DBM:GetBossUnitId(name, bossOnly)
		local returnUnitID
		if not isClassic and not isBCC then
			for i = 1, 10 do
				if UnitName("boss" .. i) == name then
					returnUnitID = "boss" .. i
				end
			end
		end
		if not returnUnitID and not bossOnly then
			for uId in self:GetGroupMembers() do
				if UnitName(uId .. "target") == name and not UnitIsPlayer(uId .. "target") then
					returnUnitID = uId .. "target"
				end
			end
		end
		return returnUnitID
	end

	function DBM:GetPlayerGUIDByName(name)
		return raid[name] and raid[name].guid
	end

	function DBM:GetMyPlayerInfo()
		return playerName, playerLevel, playerRealm, normalizedPlayerRealm
	end

	--Intentionally grabs server name at all times, usually to make sure warning/infoframe target info can name match the combat log in the table
	function DBM:GetUnitFullName(uId)
		if not uId then return end
		return GetUnitName(uId, true)
	end

	--Shortens name but custom so we add * to off realmers instead of stripping it entirely like Ambiguate does
	--Technically GetUnitName without "true" can be used to shorten name to "name (*)" but "name*" is even shorter which is why we do this
	function DBM:GetShortServerName(name)
		if not self.Options.StripServerName then return name end--If strip is disabled, just return name
		local shortName, serverName = string.split("-", name)
		if serverName and serverName ~= playerRealm and serverName ~= normalizedPlayerRealm then
			return shortName .. "*"
		else
			return name
		end
	end

	function DBM:GetFullPlayerNameByGUID(guid)
		return raidGuids[guid]
	end

	function DBM:GetPlayerNameByGUID(guid)
		return raidGuids[guid] and raidGuids[guid]:gsub("%-.*$", "")
	end

	function DBM:GetGroupId(name, higher)
		local raidMember = raid[name] or raid[GetUnitName(name, true) or ""]
		return raidMember and raidMember.groupId or UnitInRaid(name) or higher and 99 or 0
	end
end

do
	-- yes, we still do avoid memory allocations during fights; so we don't use a closure around a counter here
	-- this seems to be the easiest way to write an iterator that returns the unit id *string* as first argument without a memory allocation
	local function raidIterator(groupMembers, uId)
		local a, b = uId:byte(-2, -1)
		local i = (a >= 0x30 and a <= 0x39 and (a - 0x30) * 10 or 0) + b - 0x30
		if i < groupMembers then
			return "raid" .. i + 1, i + 1
		end
	end

	local function partyIterator(groupMembers, uId)
		if not uId then
			return "player", 0
		elseif uId == "player" then
			if groupMembers > 0 then
				return "party1", 1
			end
		else
			local i = uId:byte(-1) - 0x30
			if i < groupMembers then
				return "party" .. i + 1, i + 1
			end
		end
	end

	local function soloIterator(_, state)
		if not state then -- no state == first call
			return "player", 0
		end
	end

	-- returns the unit ids of all raid or party members, including the player's own id
	-- limitations: will break if there are ever raids with more than 99 players or partys with more than 10
	function DBM:GetGroupMembers()
		if IsInRaid() then
			return raidIterator, GetNumGroupMembers(), "raid0"
		elseif IsInGroup() then
			return partyIterator, GetNumSubgroupMembers(), nil
		else
			-- solo!
			return soloIterator, nil, nil
		end
	end
end

function DBM:GetNumGroupMembers()
	return IsInGroup() and GetNumGroupMembers() or 1
end

--For returning the number of players actually in zone with us for status functions
--This is very touchy though and will fail if everyone isn't in same SUB zone (ie same room/area)
--It should work for pretty much any case but outdoor
function DBM:GetNumRealGroupMembers()
	if not IsInInstance() then--Not accurate outside of instances (such as world bosses)
		return IsInGroup() and GetNumGroupMembers() or 1--So just return regular group members.
	end
	local currentMapId = select(-1, UnitPosition("player"))
	local realGroupMembers = 0
	if IsInGroup() then
		for uId in self:GetGroupMembers() do
			local targetMapId = select(-1, UnitPosition(uId))
			if targetMapId == currentMapId then
				realGroupMembers = realGroupMembers + 1
			end
		end
	else
		return 1
	end
	return realGroupMembers
end

function DBM:GetUnitCreatureId(uId)
	return self:GetCIDFromGUID(UnitGUID(uId))
end

--Creature/Vehicle/Pet
----<type>:<subtype>:<realmID>:<mapID>:<serverID>:<dbID>:<creationbits>
--Player/Item
----<type>:<realmID>:<dbID>
function DBM:GetCIDFromGUID(guid)
	local guidType, _, playerdbID, _, _, cid, _ = strsplit("-", guid or "")
	if guidType and (guidType == "Creature" or guidType == "Vehicle" or guidType == "Pet") then
		return tonumber(cid)
	elseif type and (guidType == "Player" or guidType == "Item") then
		return tonumber(playerdbID)
	end
	return 0
end

function DBM:IsNonPlayableGUID(guid)
	if type(guid) ~= "string" then return false end
	local guidType = strsplit("-", guid or "")
	return guidType and (guidType == "Creature" or guidType == "Vehicle" or guidType == "NPC")--To determine, add pet or not?
end

function DBM:IsCreatureGUID(guid)
	local guidType = strsplit("-", guid or "")
	return guidType and (guidType == "Creature" or guidType == "Vehicle")--To determine, add pet or not?
end

--Scope, will only check if a unit is within 43 yards now
function DBM:CheckNearby(range, targetname)
	if not targetname and DBM.RangeCheck:GetDistanceAll(range) then--Do not use self on this function, because self might be bossModPrototype
		return true--No target name means check if anyone is near self, period
	else
		local uId = DBM:GetRaidUnitId(targetname)--Do not use self on this function, because self might be bossModPrototype
		if uId and not UnitIsUnit("player", uId) then
			local restrictionsActive = isRetail and DBM:HasMapRestrictions()
			local inRange = DBM.RangeCheck:GetDistance(uId)--Do not use self on this function, because self might be bossModPrototype
			if inRange and inRange < (restrictionsActive and 43 or range) + 0.5 then
				return true
			end
		end
	end
	return false
end

function DBM:IsTrivial(customLevel)
	--if timewalking or chromie time or challenge modes. it's always non trivial content
	if C_PlayerInfo.IsPlayerInChromieTime and C_PlayerInfo.IsPlayerInChromieTime() or difficultyIndex == 24 or difficultyIndex == 33 or difficultyIndex == 8 then
		return false
	end
	--if custom level passed, we always hard check that level for trivial vs non trivial
	if customLevel then--Custom level parameter
		if playerLevel >= customLevel then
			return true
		end
	else
		--First, auto bail and return non trivial if it's an instance not in table to prevent nil error
		if not instanceDifficultyBylevel[LastInstanceMapID] then return false end
		--Content is trivial if player level is 10 higher than content involved
		local levelDiff = isRetail and 10 or 15
		if playerLevel >= (instanceDifficultyBylevel[LastInstanceMapID][1] + levelDiff) then
			return true
		end
	end
	return false
end

--Ugly, Needs improvement in code style to just dump all numeric values as args
--it's not meant to just wrap C_GossipInfo.GetOptions() but to dump out the meaningful values from it
---@return string?
function DBM:GetGossipID(force)
	if self.Options.DontAutoGossip and not force then return nil end
	local table = C_GossipInfo.GetOptions()
	local tempTable = {}
	if table then
		for i = 1, #table do
			if table[i].gossipOptionID then
				tempTable[#tempTable + 1] = table[i].gossipOptionID
			elseif table[i].orderIndex then
				tempTable[#tempTable + 1] = table[i].orderIndex
			end
		end
		if tempTable[1] then
			return unpack(tempTable)
		end
		return nil
	end
	return nil
end

--Hybrid all in one object to auto check and confirm multiple gossip IDs at once
function DBM:SelectMatchingGossip(confirm, ...)
	if self.Options.DontAutoGossip then return false end
	local requestedIds = {...}
	local table = C_GossipInfo.GetOptions()
	if not table then
		return false
	end
	for i = 1, #table do
		if table[i].gossipOptionID then
			local tindex = tIndexOf(requestedIds, table[i].gossipOptionID)
			if tindex then
				self:SelectGossip(requestedIds[tindex], confirm)
			end
		elseif table[i].orderIndex then
			local tindex = tIndexOf(requestedIds, table[i].orderIndex)
			if tindex then
				self:SelectGossip(requestedIds[tindex], confirm)
			end
		end
	end
	return false
end

function DBM:SelectGossip(gossipOptionID, confirm)
	if gossipOptionID and not self.Options.DontAutoGossip then
		if gossipOptionID < 10 then--Using Index
			if C_GossipInfo.SelectOptionByIndex then--10.0.7
				C_GossipInfo.SelectOptionByIndex(gossipOptionID, "", confirm)
			else--10.0.5
				local options = C_GossipInfo.GetOptions()
				if options and options[1] then
					local realGossipOptionID = options[gossipOptionID] and options[gossipOptionID].gossipOptionID
					if realGossipOptionID then
						C_GossipInfo.SelectOption(realGossipOptionID, "", confirm)
					end
				end
			end
		else
			C_GossipInfo.SelectOption(gossipOptionID, "", confirm)
		end
	end
end

---------------
--  Options  --
---------------
function DBM:AddDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" and type(t1[i]) == "table" then
			self:AddDefaultOptions(t1[i], v)
		end
	end
end

local soundMigrationtable = {
	[8174] = 569200,--PVPFlagTaken
	[15391] = 543587,--UR_Algalon_BHole01
	[9278] = 552035,--HoodWolfTransformPlayer01
	[6674] = 566558,--BellTollNightElf
	[11742] = 566558,--BellTollNightElf
	[8585] = 546633,--CThunYouWillDIe
	[11965] = 551703,--Horseman_Laugh_01
	[37666] = 876098,--Blizzard Raid Emote
	[11466] = 552503,--BLACK_Illidan_04
	[68563] = 1412178,--VO_703_Illidan_Stormrage_03
	[11052] = 553050,--CAV_Kaz_Mark02
	[12506] = 553193,--KILJAEDEN02
	[11482] = 553566,--BLCKTMPLE_LadyMal_Aggro01
	[8826] = 554236,--Loa_Naxx_Aggro02
	[128466] = 554236,--Loa_Naxx_Aggro02
	[49764] = 555337,--TEMPEST_Millhouse_Pyro01
	[11213] = 563787,--TEMPEST_VoidRvr_Aggro01
	[15757] = 564859,--UR_YoggSaron_Slay01
	[25780] = 572130,--VO_BH_ALIZABAL_RESET_01
	[109293] = 2016732,--VO_801_Bwonsamdi_35_M
	[109295] = 2016734,--VO_801_Bwonsamdi_37_M
	[109296] = 2016735,--VO_801_Bwonsamdi_38_M
	[109308] = 2016747,--VO_801_Bwonsamdi_50_M
	[15588] = 553345,--UR_Kologarn_Slay02
	[15553] = 552023,--UR_Hodir_Slay01
	[109069] = 2015891,--VO_801_Scrollsage_Nola_34_F
	[15742] = 562111,--UR_Thorim_P1Wipe01
	[17067] = 563333,--IC_Valithria_Berserk01
	[16971] = 555967,--IC_Muradin_Saurfang02
}

function DBM:LoadModOptions(modId, inCombat, first)
	local oldSavedVarsName = modId:gsub("-", "") .. "_SavedVars"
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local savedStatsName = modId:gsub("-", "") .. "_SavedStats"
	local fullname = playerName .. "-" .. playerRealm
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	local savedOptions = _G[savedVarsName][fullname] or {}
	local savedStats = _G[savedStatsName] or {}
	local existId = {}
	for _, id in ipairs(self.ModLists[modId]) do
		existId[id] = true
		-- init
		if not savedOptions[id] then savedOptions[id] = {} end
		local mod = self:GetModByName(id)
		-- migrate old option
		if _G[oldSavedVarsName] and _G[oldSavedVarsName][id] then
			self:Debug("LoadModOptions: Found old options, importing", 2)
			local oldTable = _G[oldSavedVarsName][id]
			_G[oldSavedVarsName][id] = nil
			savedOptions[id][profileNum] = oldTable
		end
		if not savedOptions[id][profileNum] and not first then--previous profile not found. load defaults
			self:Debug("LoadModOptions: No saved options, creating defaults for profile " .. profileNum, 2)
			local defaultOptions = {}
			for option, optionValue in pairs(mod.DefaultOptions) do
				if type(optionValue) == "table" then
					optionValue = optionValue.value
				elseif type(optionValue) == "string" then
					optionValue = mod:GetRoleFlagValue(optionValue)
				end
				defaultOptions[option] = optionValue
			end
			savedOptions[id][profileNum] = defaultOptions
		else
			savedOptions[id][profileNum] = savedOptions[id][profileNum] or mod.Options
			--check new option
			for option, optionValue in pairs(mod.DefaultOptions) do
				if savedOptions[id][profileNum][option] == nil then
					if type(optionValue) == "table" then
						optionValue = optionValue.value
					elseif type(optionValue) == "string" then
						optionValue = mod:GetRoleFlagValue(optionValue)
					end
					savedOptions[id][profileNum][option] = optionValue
				end
			end
			--clean unused saved variables (do not work on combat load)
			--Why are saved options cleaned twice?
			if not inCombat then
				for option, _ in pairs(savedOptions[id][profileNum]) do
					if type(option) == "number" then
						self:Debug("|cffff0000Option type invalid: |r" .. option)
					end
					if (mod.DefaultOptions[option] == nil) and (type(option) == "number" or not (option:find("talent") or option:find("FastestClear") or option:find("CVAR") or option:find("RestoreSetting") or option:find("MoviesSeen"))) then
						savedOptions[id][profileNum][option] = nil
					elseif mod.DefaultOptions[option] and (type(mod.DefaultOptions[option]) == "table") then--recover broken dropdown option
						if savedOptions[id][profileNum][option] and (type(savedOptions[id][profileNum][option]) == "boolean") then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option].value
						end
					--Fix default options for colored bar by type that were set to 0 because no defaults existed at time they were created, but do now.
					elseif option:find("TColor") then
						if savedOptions[id][profileNum][option] and savedOptions[id][profileNum][option] == 0 and mod.DefaultOptions[option] and mod.DefaultOptions[option] ~= 0 then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option]
							self:Debug("Migrated " .. option .. " to option defaults")
						end
					--Fix options for custom special warning sounds not in addons folder that are using soundkit Ids not and File Data Ids
					elseif option:find("SWSound") then
						local checkedOption = savedOptions[id][profileNum][option]
						if checkedOption and (type(checkedOption) == "number") and soundMigrationtable[checkedOption] then
							savedOptions[id][profileNum][option] = soundMigrationtable[checkedOption]
							self:Debug("Migrated " .. option .. " to file data Id")
						end
					end
				end
			end
		end
		--apply saved option to actual option table
		mod.Options = savedOptions[id][profileNum]
		--stats init (only first load)
		if first then
			savedStats[id] = savedStats[id] or {}
			local stats = savedStats[id]
			stats.followerKills = stats.followerKills or 0
			stats.followerPulls = stats.followerPulls or 0
			stats.normalKills = stats.normalKills or 0
			stats.normalPulls = stats.normalPulls or 0
			stats.heroicKills = stats.heroicKills or 0
			stats.heroicPulls = stats.heroicPulls or 0
			stats.challengeKills = stats.challengeKills or 0
			stats.challengePulls = stats.challengePulls or 0
			stats.challengeBestRank = stats.challengeBestRank or 0
			stats.mythicKills = stats.mythicKills or 0
			stats.mythicPulls = stats.mythicPulls or 0
			stats.normal25Kills = stats.normal25Kills or 0
			stats.normal25Kills = stats.normal25Kills or 0
			stats.normal25Pulls = stats.normal25Pulls or 0
			stats.heroic25Kills = stats.heroic25Kills or 0
			stats.heroic25Pulls = stats.heroic25Pulls or 0
			stats.lfr25Kills = stats.lfr25Kills or 0
			stats.lfr25Pulls = stats.lfr25Pulls or 0
			stats.timewalkerKills = stats.timewalkerKills or 0
			stats.timewalkerPulls = stats.timewalkerPulls or 0
			mod.stats = stats
			--run OnInitialize function
			if mod.OnInitialize then mod:OnInitialize(mod) end
		end
	end
	--clean unused saved variables (do not work on combat load)
	--Why are saved options cleaned twice?
	if not inCombat then
		for id, _ in pairs(savedOptions) do
			if not existId[id] and not (id:find("talent") or id:find("FastestClear") or id:find("CVAR") or id:find("RestoreSetting") or id:find("MoviesSeen")) then
				savedOptions[id] = nil
			end
		end
		for id, _ in pairs(savedStats) do
			if not existId[id] then
				savedStats[id] = nil
			end
		end
	end
	_G[savedVarsName][fullname] = savedOptions
	if profileNum > 0 then
		_G[savedVarsName][fullname]["talent" .. profileNum] = currentSpecName
		self:Debug("LoadModOptions: Finished loading " .. (_G[savedVarsName][fullname]["talent" .. profileNum] or CL.UNKNOWN))
	end
	_G[savedStatsName] = savedStats
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if not first and DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
	table.wipe(checkDuplicateObjects)
end

function DBM:SpecChanged(force)
	if not force and not DBM_UseDualProfile then return end
	--Load Options again.
	self:Debug("SpecChanged fired", 2)
	for modId, _ in pairs(self.ModLists) do
		self:LoadModOptions(modId)
	end
end

function DBM:PLAYER_LEVEL_CHANGED()
	playerLevel = UnitLevel("player")
	if playerLevel < 15 and playerLevel > 9 then
		self:PLAYER_SPECIALIZATION_CHANGED() -- Classic this is "CHARACTER_POINTS_CHANGED", but we just use this function anyway
	end
end

function DBM:LoadAllModDefaultOption(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local fullname = playerName .. "-" .. playerRealm
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		-- prevent nil table error
		if not _G[savedVarsName][fullname][id] then _G[savedVarsName][fullname][id] = {} end
		-- actual do load default option
		local mod = self:GetModByName(id)
		local defaultOptions = {}
		for option, optionValue in pairs(mod.DefaultOptions) do
			if type(optionValue) == "table" then
				optionValue = optionValue.value
			elseif type(optionValue) == "string" then
				optionValue = mod:GetRoleFlagValue(optionValue)
			end
			defaultOptions[option] = optionValue
		end
		mod.Options = {}
		mod.Options = defaultOptions
		_G[savedVarsName][fullname][id][profileNum] = {}
		_G[savedVarsName][fullname][id][profileNum] = mod.Options
	end
	self:AddMsg(L.ALLMOD_DEFAULT_LOADED)
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:LoadModDefaultOption(mod)
	-- mod must be table
	if not mod then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = (mod.modId):gsub("-", "") .. "_AllSavedVars"
	local fullname = playerName .. "-" .. playerRealm
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][fullname] then _G[savedVarsName][fullname] = {} end
	if not _G[savedVarsName][fullname][mod.id] then _G[savedVarsName][fullname][mod.id] = {} end
	-- do load default
	local defaultOptions = {}
	for option, optionValue in pairs(mod.DefaultOptions) do
		if type(optionValue) == "table" then
			optionValue = optionValue.value
		elseif type(optionValue) == "string" then
			optionValue = mod:GetRoleFlagValue(optionValue)
		end
		defaultOptions[option] = optionValue
	end
	mod.Options = {}
	mod.Options = defaultOptions
	_G[savedVarsName][fullname][mod.id][profileNum] = {}
	_G[savedVarsName][fullname][mod.id][profileNum] = mod.Options
	self:AddMsg(L.MOD_DEFAULT_LOADED)
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModOption(modId, sourceName, sourceProfile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not DBM.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local targetName = playerName .. "-" .. playerRealm
	local targetProfile = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(L.MPROFILE_COPY_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(L.MPROFILE_COPY_S_ERROR)
		return
	end
	for _, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(L.MPROFILE_COPY_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(L.MPROFILE_COPY_S_ERROR)
			return
		end
		-- prevent nil table error
		if not _G[savedVarsName][targetName][id] then _G[savedVarsName][targetName][id] = {} end
		-- copy table
		_G[savedVarsName][targetName][id][targetProfile] = CopyTable(_G[savedVarsName][sourceName][id][sourceProfile])
		--check new option
		local mod = self:GetModByName(id)
		for option, optionValue in pairs(mod.Options) do
			if _G[savedVarsName][targetName][id][targetProfile][option] == nil then
				_G[savedVarsName][targetName][id][targetProfile][option] = optionValue
			end
		end
		-- apply to options table
		mod.Options = {}
		mod.Options = _G[savedVarsName][targetName][id][targetProfile]
	end
	if targetProfile > 0 then
		_G[savedVarsName][targetName]["talent" .. targetProfile] = currentSpecName
	end
	self:AddMsg(L.MPROFILE_COPY_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModTypeOption(modId, sourceName, sourceProfile, Type)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not self.ModLists[modId] or not Type then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local targetName = playerName .. "-" .. playerRealm
	local targetProfile = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(L.MPROFILE_COPYS_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
		return
	end
	for _, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(L.MPROFILE_COPYS_S_ERROR)
			return
		end
		-- prevent nil table error
		if not _G[savedVarsName][targetName][id] then _G[savedVarsName][targetName][id] = {} end
		-- copy table
		for option, optionValue in pairs(_G[savedVarsName][sourceName][id][sourceProfile]) do
			if option:find(Type) then
				_G[savedVarsName][targetName][id][targetProfile][option] = optionValue
			end
		end
		-- apply to options table
		local mod = self:GetModByName(id)
		mod.Options = {}
		mod.Options = _G[savedVarsName][targetName][id][targetProfile]
	end
	if targetProfile > 0 then
		_G[savedVarsName][targetName]["talent" .. targetProfile] = currentSpecName
	end
	self:AddMsg(L.MPROFILE_COPYS_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:DeleteAllModOption(modId, name, profile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not name or not profile or not self.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local fullname = playerName .. "-" .. playerRealm
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- cannot delete current profile.
	if fullname == name and profileNum == profile then
		self:AddMsg(L.MPROFILE_DELETE_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][name] then
		self:AddMsg(L.MPROFILE_DELETE_S_ERROR)
		return
	end
	for _, id in ipairs(self.ModLists[modId]) do
		-- prevent nil table error
		if not _G[savedVarsName][name][id] then
			self:AddMsg(L.MPROFILE_DELETE_S_ERROR)
			return
		end
		-- delete
		_G[savedVarsName][name][id][profile] = nil
	end
	_G[savedVarsName][name]["talent" .. profile] = nil
	self:AddMsg(L.MPROFILE_DELETE_SUCCESS:format(name, profile))
end

function DBM:ClearAllStats(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- variable init
	local savedStatsName = modId:gsub("-", "") .. "_SavedStats"
	-- prevent nil table error
	if not _G[savedStatsName] then _G[savedStatsName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		local mod = self:GetModByName(id)
		-- prevent nil table error
		local defaultStats = {}
		defaultStats.followerKills = 0
		defaultStats.followerPulls = 0
		defaultStats.normalKills = 0
		defaultStats.normalPulls = 0
		defaultStats.heroicKills = 0
		defaultStats.heroicPulls = 0
		defaultStats.challengeKills = 0
		defaultStats.challengePulls = 0
		defaultStats.challengeBestRank = 0
		defaultStats.mythicKills = 0
		defaultStats.mythicPulls = 0
		defaultStats.normal25Kills = 0
		defaultStats.normal25Kills = 0
		defaultStats.normal25Pulls = 0
		defaultStats.heroic25Kills = 0
		defaultStats.heroic25Pulls = 0
		defaultStats.lfr25Kills = 0
		defaultStats.lfr25Pulls = 0
		defaultStats.timewalkerKills = 0
		defaultStats.timewalkerPulls = 0
		mod.stats = {}
		mod.stats = defaultStats
		_G[savedStatsName][id] = {}
		_G[savedStatsName][id] = defaultStats
	end
	self:AddMsg(L.ALLMOD_STATS_RESETED)
	DBM_GUI:UpdateModList()
end

do
	local gsub = string.gsub

	local function FixElv(optionName)
		if DBM.Options[optionName]:lower():find("interface\\addons\\elvui\\media\\") then
			DBM.Options[optionName] = gsub(DBM.Options[optionName], gsub("Interface\\AddOns\\ElvUI\\Media\\", "(%a)", function(v)
				return "[" .. v:upper() .. v:lower() .. "]"
			end), "Interface\\AddOns\\ElvUI\\Core\\Media\\")
		end
	end

	function loadOptions(self)
		--init
		if not DBM_AllSavedOptions then DBM_AllSavedOptions = {} end
		usedProfile = DBM_UsedProfile or usedProfile
		if not usedProfile or (usedProfile ~= "Default" and not DBM_AllSavedOptions[usedProfile]) then
			-- DBM.Option is not loaded. so use print function
			print(L.PROFILE_NOT_FOUND)
			usedProfile = "Default"
		end
		DBM_UsedProfile = usedProfile
		self.Options = DBM_AllSavedOptions[usedProfile] or {}
		self:Enable()
		self:AddDefaultOptions(self.Options, self.DefaultOptions)
		DBM_AllSavedOptions[usedProfile] = self.Options

		-- force enable dual profile (change default)
		if DBM_CharSavedRevision < 12976 then
			if playerClass ~= "MAGE" and playerClass ~= "WARLOCK" and playerClass ~= "ROGUE" then
				DBM_UseDualProfile = true
			end
		end
		DBM_CharSavedRevision = self.Revision
		-- load special warning options
		self:UpdateWarningOptions()
		self:UpdateSpecialWarningOptions()
		self.Options.CoreSavedRevision = self.Revision
		--Fix fonts if they are nil
		if not self.Options.WarningFont then
			self.Options.WarningFont = "standardFont"
		end
		if not self.Options.SpecialWarningFont then
			self.Options.SpecialWarningFont = "standardFont"
		end
		--If users previous voice pack was not set to none, don't force change it to VEM, honor whatever it was set to before
		if self.Options.ChosenVoicePack and self.Options.ChosenVoicePack ~= "None" then
			self.Options.ChosenVoicePack2 = self.Options.ChosenVoicePack
			self.Options.ChosenVoicePack = nil
		end

		for _, setting in ipairs({
			-- Sounds
			"RaidWarningSound", "SpecialWarningSound", "SpecialWarningSound2", "SpecialWarningSound3", "SpecialWarningSound4", "SpecialWarningSound5", "EventSoundVictory2",
			"EventSoundWipe", "EventSoundEngage2", "EventSoundMusic", "EventSoundDungeonBGM", "RangeFrameSound1", "RangeFrameSound2",
			-- Fonts
			"InfoFrameFont", "WarningFont", "SpecialWarningFont"
		}) do
			-- Migrate ElvUI changes
			if type(self.Options[setting]) == "string" and self.Options[setting]:lower() ~= "none" then
				FixElv(setting)
			end
			-- Migrate soundkit to FileData ID changes
			if type(self.Options[setting]) == "number" and soundMigrationtable[self.Options[setting]] then
				self.Options[setting] = soundMigrationtable[self.Options[setting]]
			end
		end
	end
end

do
	local lastLFGAlert = 0
	function DBM:LFG_ROLE_CHECK_SHOW()
		if not UnitIsGroupLeader("player") and self.Options.LFDEnhance and GetTime() - lastLFGAlert > 5 then
			self:FlashClientIcon()
			self:PlaySoundFile(567478, true)--Because regular sound uses SFX channel which is too low of volume most of time
			lastLFGAlert = GetTime()
		end
	end
end

function DBM:LFG_PROPOSAL_SHOW()
	if self.Options.ShowQueuePop and not self.Options.DontShowEventTimers then
		DBT:CreateBar(40, L.LFG_INVITE, 237538)
		fireEvent("DBM_TimerStart", "DBMLFGTimer", L.LFG_INVITE, 40, "237538", "extratimer", nil, 0)
	end
	if self.Options.LFDEnhance then
		self:FlashClientIcon()
		self:PlaySoundFile(567478, true)--Because regular sound uses SFX channel which is too low of volume most of time
	end
end

function DBM:LFG_PROPOSAL_FAILED()
	DBT:CancelBar(L.LFG_INVITE)
	fireEvent("DBM_TimerStop", "DBMLFGTimer")
end

function DBM:LFG_PROPOSAL_SUCCEEDED()
	DBT:CancelBar(L.LFG_INVITE)
	fireEvent("DBM_TimerStop", "DBMLFGTimer")
end

function DBM:READY_CHECK()
	if self.Options.RLReadyCheckSound then--readycheck sound, if ora3 not installed (bad to have 2 mods do it)
		self:FlashClientIcon()
		if not BINDING_HEADER_oRA3 then
			DBM:PlaySoundFile(567478, true)--Because regular sound uses SFX channel which is too low of volume most of time
		end
	end
	self:TransitionToDungeonBGM(false, true)
	self:Schedule(4, self.TransitionToDungeonBGM, self)
end

do
	local function throttledTalentCheck(self)
		local lastSpecID = currentSpecID
		self:SetCurrentSpecInfo()
		if not InCombatLockdown() then
			--Refresh entire spec table if not in combat
			DBMExtraGlobal:rebuildSpecTable()
		end
		if currentSpecID ~= lastSpecID then--Don't fire specchanged unless spec actually has changed.
			self:SpecChanged()
			if isRetail and IsInGroup() then
				self:RoleCheck(false)
			end
		end
	end

	--Retail API doesn't need throttle
	function DBM:PLAYER_SPECIALIZATION_CHANGED()
		self:Unschedule(throttledTalentCheck)
		throttledTalentCheck(self)
	end
	--Throttle checks on talent point updates so that if multiple CHARACTER_POINTS_CHANGED fire in succession
	--It doesnt spam DBMs code and cause performance lag
	function DBM:CHARACTER_POINTS_CHANGED() -- Classic/BCC support
		self:Unschedule(throttledTalentCheck)
		self:Schedule(2, throttledTalentCheck, self)
	end
	--Throttle this api too.
	DBM.PLAYER_TALENT_UPDATE = DBM.CHARACTER_POINTS_CHANGED -- Wrath support
end

do
	local function AcceptPartyInvite()
		AcceptGroup()
		for i = 1, STATICPOPUP_NUMDIALOGS do
			local whichDialog = _G["StaticPopup" .. i].which
			if whichDialog == "PARTY_INVITE" or whichDialog == "PARTY_INVITE_XREALM" then
				_G["StaticPopup" .. i].inviteAccepted = 1
				StaticPopup_Hide(whichDialog)
				break
			end
		end
	end

	function DBM:PARTY_INVITE_REQUEST(sender)
		--First off, if you are in queue for something, lets not allow guildies or friends boot you from it.
		if IsInInstance() or GetLFGMode(1) or GetLFGMode(2) or GetLFGMode(3) or GetLFGMode(4) or GetLFGMode(5) then return end
		--Checks friends and guildies
		if self.Options.AutoAcceptFriendInvite then
			if checkForSafeSender(sender, self.Options.AutoAcceptFriendInvite, self.Options.AutoAcceptGuildInvite, nil, type(sender) == "number") then
				AcceptPartyInvite()
			end
		end
	end
end

function DBM:UPDATE_BATTLEFIELD_STATUS(queueID)
	for i = 1, 2 do
		if GetBattlefieldStatus(i) == "confirm" then
			if self.Options.ShowQueuePop and not self.Options.DontShowEventTimers then
				queuedBattlefield[i] = select(2, GetBattlefieldStatus(i))
				local expiration = GetBattlefieldPortExpiration(queueID)
				local timerIcon = (isRetail and GetPlayerFactionGroup("player") or UnitFactionGroup("player")) == "Alliance" and 132486 or 132485
				DBT:CreateBar(expiration or 85, queuedBattlefield[i], timerIcon)
				self:FlashClientIcon()
				fireEvent("DBM_TimerStart", "DBMBFSTimer", queuedBattlefield[i], expiration or 85, tostring(timerIcon), "extratimer", nil, 0)
			end
			if self.Options.LFDEnhance then
				self:PlaySoundFile(567478, true)--Because regular sound uses SFX channel which is too low of volume most of time
			end
		elseif queuedBattlefield[i] then
			DBT:CancelBar(queuedBattlefield[i])
			fireEvent("DBM_TimerStop", "DBMBFSTimer")
			tremove(queuedBattlefield, i)
		end
	end
end

function DBM:SCENARIO_COMPLETED()
	if #inCombat > 0 and C_Scenario.IsInScenario() then
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if v.inScenario then
				self:EndCombat(v, nil, nil, "SCENARIO_COMPLETED")
			end
		end
	end
end

--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
do
	local pvpShown = false
	local seasonalShown = false
	local classicZones = {[509] = true, [531] = true, [469] = true, [409] = true}
	local bcZones = {[564] = true, [534] = true, [532] = true, [565] = true, [544] = true, [548] = true, [580] = true, [550] = true}
	local wrathZones = {[615] = true, [724] = true, [649] = true, [616] = true, [631] = true, [533] = true, [249] = true, [603] = true, [624] = true}
	local cataZones = {[757] = true, [671] = true, [669] = true, [967] = true, [720] = true, [951] = true, [754] = true}
	local mopZones = {[1009] = true, [1008] = true, [1136] = true, [996] = true, [1098] = true}
	local wodZones = {[1205] = true, [1448] = true, [1228] = true}
	local legionZones = {[1712] = true, [1520] = true, [1530] = true, [1676] = true, [1648] = true}
	local bfaZones = {[1861] = true, [2070] = true, [2096] = true, [2164] = true, [2217] = true}
	local shadowlandsZones = {[2296] = true, [2450] = true, [2481] = true}
	local challengeScenarios = {[1148] = true, [1698] = true, [1710] = true, [1703] = true, [1702] = true, [1684] = true, [1673] = true, [1616] = true, [2215] = true}
	local pvpZones = {[30] = true, [489] = true, [529] = true, [559] = true, [562] = true, [566] = true, [572] = true, [617] = true, [618] = true, [628] = true, [726] = true, [727] = true, [761] = true, [968] = true, [980] = true, [998] = true, [1105] = true, [1134] = true, [1170] = true, [1504] = true, [1505] = true, [1552] = true, [1681] = true, [1672] = true, [1803] = true, [1825] = true, [1911] = true, [2106] = true, [2107] = true, [2118] = true, [2167] = true, [2177] = true, [2197] = true, [2245] = true, [2373] = true, [2509] = true, [2511] = true, [2547] = true, [2563] = true}
	local seasonalZones = {[2579] = true, [1279] = true, [1501] = true, [1466] = true, [1763] = true, [643] = true, [1862] = true}

	--This never wants to spam you to use mods for trivial content you don't need mods for.
	--It's intended to suggest mods for content that's relevant to your level (TW, leveling up in dungeons, or even older raids you can't just roll over)
	function DBM:CheckAvailableMods()
		if _G["BigWigs"] then return end--If they are running two boss mods at once, lets assume they are only using DBM for a specific feature (such as brawlers) and not nag
		if isRetail then
			if not self:IsTrivial() then
				if (seasonalZones[LastInstanceMapID] or instanceDifficultyBylevel[LastInstanceMapID] and instanceDifficultyBylevel[LastInstanceMapID][2] == 2) and not C_AddOns.DoesAddOnExist("DBM-Party-Dragonflight") and not seasonalShown then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Dungeon mods"))
					seasonalShown = true
				elseif (classicZones[LastInstanceMapID] or bcZones[LastInstanceMapID]) and not C_AddOns.DoesAddOnExist("DBM-Raids-BC") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM BC/Vanilla mods"))
				elseif wrathZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-WoTLK") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Wrath of the Lich King mods"))
				elseif cataZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Cataclysm") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Cataclysm mods"))
				elseif mopZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-MoP") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Mists of Pandaria mods"))
				elseif wodZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-WoD") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Warlords of Draenor mods"))
				elseif legionZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Legion") then--Technically 45 level with quish, but because of tuning you need need mods even at 50
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Legion mods"))
				elseif bfaZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-BfA") then--Technically 50, but tuning and huge loss of player power, zones are even HARDER at 60
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Battle for Azeroth mods"))
				elseif shadowlandsZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Shadowlands") then--Technically 50, but tuning and huge loss of player power, zones are even HARDER at 60
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Shadowlands mods"))
				end
			elseif challengeScenarios[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Challenges") then--No trivial check on challenge scenarios
				AddMsg(self, L.MOD_AVAILABLE:format("DBM-Challenges"))
			end
		else--Classic
			local checkedDungeon = isCata and "DBM-Party-Cataclysm" or isWrath and "DBM-Party-WotLK" or isBCC and "DBM-Party-BC" or "DBM-Party-Vanilla"
			if instanceDifficultyBylevel[LastInstanceMapID] and instanceDifficultyBylevel[LastInstanceMapID][2] == 2 and not C_AddOns.DoesAddOnExist(checkedDungeon) then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Dungeon mods"))
			end
		end
		if pvpZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-PvP") and not pvpShown then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM-PvP"))
			pvpShown = true
		end
	end

	local sodPvpZones = {
		[1440] = true, -- Ashenvale
		[1434] = true, -- Stranglethorn Vale
	}
	function DBM:CheckAvailableModsByMap()
		local mapId = C_Map.GetBestMapForUnit("player")
		if not mapId then return end
		if UnitOnTaxi("player") then return end -- Don't spam the player if they are just passing through
		if self:IsSeasonal("SeasonOfDiscovery") then
			if sodPvpZones[mapId] and not pvpShown and not C_AddOns.DoesAddOnExist("DBM-PvP") then
				self:AddMsg(L.MOD_AVAILABLE:format("DBM-PvP"))
				pvpShown = true
			end
		end
	end

	function DBM:TransitionToDungeonBGM(force, cleanup)
		if cleanup then--Runs on zone change/cinematic Start (first load delay) and combat end
			self:Unschedule(self.TransitionToDungeonBGM)
			if self.Options.RestoreSettingCustomMusic then
				SetCVar("Sound_EnableMusic", self.Options.RestoreSettingCustomMusic)
				self.Options.RestoreSettingCustomMusic = nil
				self:Debug("Restoring Sound_EnableMusic CVAR")
			end
			if self.Options.musicPlaying then--Primarily so DBM doesn't call StopMusic unless DBM is one that started it. We don't want to screw with other addons
				StopMusic()
				self.Options.musicPlaying = nil
				self:Debug("Stopping music")
			end
			fireEvent("DBM_MusicStop", "ZoneOrCombatEndTransition")
			return
		end
		if LastInstanceType ~= "raid" and LastInstanceType ~= "party" and not force then return end
		if self.Options.RestoreSettingMusic then return end--Music was disabled by the music disable override, abort here
		fireEvent("DBM_MusicStart", "RaidOrDungeon")
		if self.Options.EventSoundDungeonBGM and self.Options.EventSoundDungeonBGM ~= "None" and self.Options.EventSoundDungeonBGM ~= "" and not (self.Options.EventDungMusicMythicFilter and (savedDifficulty == "mythic" or savedDifficulty == "challenge")) then
			if not self.Options.RestoreSettingCustomMusic then
				self.Options.RestoreSettingCustomMusic = tonumber(GetCVar("Sound_EnableMusic")) or 1
				if self.Options.RestoreSettingCustomMusic == 0 then
					SetCVar("Sound_EnableMusic", 1)
				else
					self.Options.RestoreSettingCustomMusic = nil--Don't actually need it
				end
			end
			local path = "MISSING"
			if self.Options.EventSoundDungeonBGM == "Random" then
				local usedTable = self.Options.EventSoundMusicCombined and DBM:GetMusic() or DBM:GetDungeonMusic()
				if #usedTable >= 3 then
					local random = fastrandom(3, #usedTable)
					path = usedTable[random].value
				end
			else
				path = self.Options.EventSoundDungeonBGM
			end
			if path ~= "MISSING" then
				PlayMusic(path)
				self.Options.musicPlaying = true
				self:Debug("Starting Dungeon music with file: " .. path)
			end
		end
	end
	local function SecondaryLoadCheck(self)
		local _, instanceType, difficulty, _, _, _, _, mapID, instanceGroupSize = GetInstanceInfo()
		local currentDifficulty, currentDifficultyText, _, _, keystoneLevel = self:GetCurrentInstanceDifficulty()
		if currentDifficulty ~= savedDifficulty then
			savedDifficulty, difficultyText, difficultyModifier = currentDifficulty, currentDifficultyText, keystoneLevel
		end
		self:Debug("Instance Check fired with mapID " .. mapID .. " and difficulty " .. difficulty, 2)
		-- Auto Logging for entire zone if record only bosses is off
		-- This Bypasses Same ID check because we still need to recheck this on keystone difficulty check
		if not self.Options.RecordOnlyBosses then
			if LastInstanceType == "raid" or LastInstanceType == "party" then
				self:StartLogging(0)
			else
				self:StopLogging()
			end
		end
		--These can still change even if mapID doesn't
		difficultyIndex = difficulty
		LastGroupSize = instanceGroupSize
		if LastInstanceMapID == mapID then
			self:TransitionToDungeonBGM()
			self:Debug("No action taken because mapID hasn't changed since last check", 2)
			return
		end--ID hasn't changed, don't waste cpu doing anything else (example situation, porting into garrosh stage 4 is a loading screen)
		LastInstanceMapID = mapID
		DBMScheduler:UpdateZone()--Also update zone in scheduler
		fireEvent("DBM_UpdateZone", mapID)
		if instanceType == "none" or (C_Garrison and C_Garrison:IsOnGarrisonMap()) then
			LastInstanceType = "none"
			if not targetEventsRegistered then
				self:RegisterShortTermEvents("UPDATE_MOUSEOVER_UNIT", "NAME_PLATE_UNIT_ADDED", "UNIT_TARGET_UNFILTERED")
				targetEventsRegistered = true
			end
		else
			LastInstanceType = instanceType
			if targetEventsRegistered then
				self:UnregisterShortTermEvents()
				targetEventsRegistered = false
			end
			if savedDifficulty == "worldboss" then
				for i = #inCombat, 1, -1 do
					self:EndCombat(inCombat[i], true, nil, "Left zone of world boss")
				end
			end
		end
		-- LoadMod
		self:LoadModsOnDemand("mapId", mapID)
		self:CheckAvailableMods()
		if self:HasMapRestrictions() then
			self.Arrow:Hide()
			self.HudMap:Disable()
			if (isRetail and self.RangeCheck:IsShown()) or self.RangeCheck:IsRadarShown() then
				self.RangeCheck:Hide(true)
			end
		end
	end
	--Faster and more accurate loading for instances, but useless outside of them
	function DBM:LOADING_SCREEN_DISABLED()
		if isRetail then
			DBT:CancelBar(L.LFG_INVITE)--Disable bar here since LFG_PROPOSAL_SUCCEEDED seems broken right now
		end
		fireEvent("DBM_TimerStop", "DBMLFGTimer")
		timerRequestInProgress = false
		self:Debug("LOADING_SCREEN_DISABLED fired")
		self:Unschedule(SecondaryLoadCheck)
		--SecondaryLoadCheck(self)
		self:Schedule(1, SecondaryLoadCheck, self)--Now delayed by one second to work around an issue on 8.x where spec info isn't available yet on reloadui
		self:TransitionToDungeonBGM(false, true)
		self:Schedule(5, SecondaryLoadCheck, self)
		if self:HasMapRestrictions() then
			self.Arrow:Hide()
			self.HudMap:Disable()
			if (isRetail and self.RangeCheck:IsShown()) or self.RangeCheck:IsRadarShown() then
				self.RangeCheck:Hide(true)
			end
		end
	end

	-- Load based on MapIDs
	function DBM:ZONE_CHANGED_NEW_AREA()
		local mapID = C_Map.GetBestMapForUnit("player")
		if mapID then
			self:LoadModsOnDemand("mapId", "m" .. mapID)
		end
		DBM:CheckAvailableModsByMap()
	end

	function DBM:CHALLENGE_MODE_RESET()
		difficultyIndex = 8
		self:CheckAvailableMods()
		if not self.Options.RecordOnlyBosses then
			self:StartLogging(0, nil, true)
		end
	end

	function DBM:LOADING_SCREEN_ENABLED()
		--TimerTracker Cleanup, required to work around logic code blizzard put into TimerTracker for /countdown timers
		--TimerTracker is hard coded that if a type 3 timer exists, to give it prio over type 1 and type 2. This causes the M+ timer not to show, even if only like 0.01 sec was left on the /countdown
		--We want to avoid situations where players start a 10 second timer, but click keystone with fractions of a second left, preventing them from seeing the M+ timer
		if not DBM.Options.DontShowPTCountdownText and TimerTracker then -- Doesn't exist in classic
			for _, tttimer in pairs(TimerTracker.timerList) do
				if tttimer.type == 3 and not tttimer.isFree then
					FreeTimerTrackerTimer(tttimer)
					break
				end
			end
		end
	end

	function DBM:LoadModsOnDemand(checkTable, checkValue)
		self:Debug("LoadModsOnDemand fired for table " .. checkTable .. " value " .. tostring(checkValue))
		for _, v in ipairs(self.AddOns) do
			local modTable = v[checkTable]
			local enabled = C_AddOns.GetAddOnEnableState(v.modId, playerName)
			--self:Debug(v.modId .. " is " .. enabled, 2)
			if not C_AddOns.IsAddOnLoaded(v.modId) and modTable and checkEntry(modTable, checkValue) then
				if enabled ~= 0 then
					self:LoadMod(v)
				else
					self:AddMsg(L.LOAD_MOD_DISABLED:format(v.name))
				end
			end
		end
		if isRetail then
			self:ScenarioCheck()--Do not filter. Because ScenarioCheck function includes filter.
		end
	end
end

--Scenario mods
function DBM:ScenarioCheck()
	if dbmIsEnabled and combatInfo[LastInstanceMapID] then
		for _, v in ipairs(combatInfo[LastInstanceMapID]) do
			if (v.type == "scenario") and checkEntry(v.msgs, LastInstanceMapID) then
				self:StartCombat(v.mod, 0, "LOADING_SCREEN_DISABLED")
			end
		end
	end
end

function DBM:LoadMod(mod, force)
	if type(mod) ~= "table" then
		self:Debug("LoadMod failed because mod table not valid")
		return false
	end
	--Block loading world boss mods by zoneID, except if it's a heroic warfront or darkmoon faire island
	if mod.isWorldBoss and not IsInInstance() and not force and (not isRetail or difficultyIndex ~= 149) and LastInstanceMapID ~= 974 then
		return
	end
	if mod.minRevision > self.Revision then
		if self:AntiSpam(60, "VER_MISMATCH") then--Throttle message in case person keeps trying to load mod (or it's a world boss player keeps targeting
			self:AddMsg(L.LOAD_MOD_VER_MISMATCH:format(mod.name))
		end
		return
	end
	if mod.minExpansion > GetExpansionLevel() then
		self:AddMsg(L.LOAD_MOD_EXP_MISMATCH:format(mod.name))
		return
	elseif not testBuild and mod.minToc > wowTOC then
		self:AddMsg(L.LOAD_MOD_TOC_MISMATCH:format(mod.name, mod.minToc))
		return
	end
	if not currentSpecID or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	if not difficultyIndex then -- prevent error in EJ_SetDifficulty if not yet set
		savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
	end
	if isRetail then
		EJ_SetDifficulty(difficultyIndex)--Work around blizzard crash bug where other mods (like Boss) screw with Ej difficulty value, which makes EJ_GetSectionInfo crash the game when called with invalid difficulty index set.
	end
	self:Debug("LoadAddOn should have fired for " .. mod.name, 2)
	local loaded, reason = C_AddOns.LoadAddOn(mod.modId)
	if not loaded then
		if reason == "DISABLED" then
			self:AddMsg(L.LOAD_MOD_DISABLED:format(mod.name))
		elseif reason then
			self:AddMsg(L.LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_" .. reason] or CL.UNKNOWN)))
		else
			self:Debug("LoadAddOn failed and did not give reason")
		end
		return false
	else
		self:Debug("LoadAddOn should have succeeded for " .. mod.name, 2)
		self:AddMsg(L.LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		if self.NewerVersion and showConstantReminder >= 1 then
			AddMsg(self, L.UPDATEREMINDER_HEADER:format(self.NewerVersion, showRealDate(self.HighestRelease)))
		end
		self:LoadModOptions(mod.modId, InCombatLockdown(), true)
		if DBM_GUI then
			DBM_GUI:UpdateModList()
			DBM_GUI:CreateBossModTab(mod, mod.panel)
			_G["DBM_GUI_OptionsFrame"]:DisplayFrame(mod.panel.frame)
		end
		if LastInstanceType ~= "pvp" and #inCombat == 0 and IsInGroup() then--do timer recovery only mod load
			if not timerRequestInProgress then
				timerRequestInProgress = true
				-- Request timer to 3 person to prevent failure.
				self:Unschedule(self.RequestTimers)
				self:Schedule(7, self.RequestTimers, self, 1)
				self:Schedule(10, self.RequestTimers, self, 2)
				self:Schedule(13, self.RequestTimers, self, 3)
				C_TimerAfter(15, function() timerRequestInProgress = false end)
				self:GROUP_ROSTER_UPDATE(true)
			end
		end
--		if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
--			collectgarbage("collect")
--		end
		return true
	end
end

do
	local function loadModByUnit(uId)
		if IsInInstance() or not UnitIsFriend("player", uId) and UnitIsDead("player") or UnitIsDead(uId) then return end--If you're in an instance no reason to waste cpu. If THE BOSS dead, no reason to load a mod for it. To prevent rare lua error, needed to filter on player dead.
		local guid = UnitGUID(uId)
		if guid and DBM:IsCreatureGUID(guid) then
			local cId = DBM:GetCIDFromGUID(guid)
			for bosscId, addon in pairs(loadcIds) do
				local enabled = C_AddOns.GetAddOnEnableState(addon, playerName)
				if cId and bosscId and cId == bosscId and not C_AddOns.IsAddOnLoaded(addon) and enabled ~= 0 then
					for _, v in ipairs(DBM.AddOns) do
						if v.modId == addon then
							DBM:LoadMod(v, true)
							break
						end
					end
				end
			end
		end
	end

	--Loading routeens checks for world bosses based on target or mouseover or nameplate.
	function DBM:UPDATE_MOUSEOVER_UNIT()
		loadModByUnit("mouseover")
	end

	function DBM:NAME_PLATE_UNIT_ADDED(uId)
		loadModByUnit(uId)
	end

	function DBM:UNIT_TARGET_UNFILTERED(uId)
		loadModByUnit(uId .. "target")
	end
end

-----------------------------
--  Handle Incoming Syncs  --
-----------------------------

--NOTE. Don't ever try to move this out of core. My testing showed it required storing nearly every local variable in core in private, gravely poluting and inflating it beyond any kind of rational

do
	local function checkForActualPull()
		if (DBM.Options.RecordOnlyBosses and #inCombat == 0) or (not isRetail and difficultyIndex ~= 8) then
			DBM:StopLogging()
		end
	end

	local syncHandlers, whisperSyncHandlers, guildSyncHandlers = {}, {}, {}

	-- DBM uses the following prefixes since 4.1 as pre-4.1 sync code is going to be incompatible anways, so this is the perfect opportunity to throw away the old and long names
	-- M = Mod
	-- C = Combat start
	-- GC = Guild Combat Start
	-- IS = Icon set info
	-- K = Kill
	-- H = Hi!
	-- V = Incoming version information
	-- U = User Timer
	-- PT = Pull Timer (for sound effects, the timer itself is still sent as a normal timer)
	-- RT = Request Timers
	-- CI = Combat Info
	-- TR = Timer Recovery
	-- IR = Instance Info Request
	-- IRE = Instance Info Requested Ended/Canceled
	-- II = Instance Info
	-- WBE = World Boss engage info
	-- WBD = World Boss defeat info
	-- WBA = World Buff Activation
	-- RLO = Raid Leader Override
	-- NS = Note Share

	syncHandlers["M"] = function(sender, _, mod, revision, event, ...)
		mod = DBM:GetModByName(mod or "")
		if mod and event and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, sender, revision, ...)
		end
	end

	syncHandlers["NS"] = function(sender, _, modid, modvar, text, abilityName)
		if sender == playerName then return end
		if DBM.Options.BlockNoteShare or InCombatLockdown() or UnitAffectingCombat("player") or IsFalling() then return end--or DBM:GetRaidRank(sender) == 0
		if IsInGroup(2) and IsInInstance() then return end
		--^^You are in LFR, BG, or LFG. Block note syncs. They shouldn't be sendable, but in case someone edits DBM^^
		local mod = DBM:GetModByName(modid or "")
		local ability = abilityName or CL.UNKNOWN
		if mod and modvar and text and text ~= "" then
			if DBM:AntiSpam(5, modvar) then--Don't allow calling same note more than once per 5 seconds
				DBM:AddMsg(L.NOTE_SHARE_SUCCESS:format(sender, ability))
				DBM:AddMsg(("|Hgarrmission:DBM:noteshare:%s:%s:%s:%s:%s|h|cff3588ff[%s]|r|h"):format(modid, modvar, ability, text, sender, L.NOTE_SHARE_LINK))
--				DBM:ShowNoteEditor(mod, modvar, ability, text, sender)
			else
				DBM:Debug(sender .. " is attempting to send too many notes so notes are being throttled")
			end
		else
			DBM:AddMsg(L.NOTE_SHARE_FAIL:format(sender, ability))
		end
	end

	syncHandlers["C"] = function(sender, _, delay, mod, modRevision, startHp, dbmRevision, modHFRevision, event)
		if not dbmIsEnabled or sender == playerName then return end
		if LastInstanceType == "pvp" then return end
		if LastInstanceType == "none" and (not UnitAffectingCombat("player") or #inCombat > 0) then--world boss
			local senderuId = DBM:GetRaidUnitId(sender)
			if not senderuId then return end--Should never happen, but just in case. If happens, MANY "C" syncs are sent. losing 1 no big deal.
			local playerZone = select(-1, UnitPosition("player"))
			local senderZone = select(-1, UnitPosition(senderuId))
			if playerZone ~= senderZone then return end--not same zone
		end
		if not cSyncSender[sender] then
			cSyncSender[sender] = true
			cSyncReceived = cSyncReceived + 1
			if cSyncReceived > 2 then -- need at least 3 sync to combat start. (for security)
				local lag = select(4, GetNetStats()) / 1000
				delay = tonumber(delay or 0) or 0
				mod = DBM:GetModByName(mod or "")
				modRevision = tonumber(modRevision or 0) or 0
				dbmRevision = tonumber(dbmRevision or 0) or 0
				modHFRevision = tonumber(modHFRevision or 0) or 0
				startHp = tonumber(startHp or -1) or -1
				if dbmRevision < 10481 then return end
				if mod and delay and (not mod.zones or mod.zones[LastInstanceMapID]) and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) and not (#inCombat > 0 and mod.noMultiBoss) then
					DBM:StartCombat(mod, delay + lag, "SYNC from - " .. sender, true, startHp, event)
					if mod.revision < modHFRevision then--mod.revision because we want to compare to OUR revision not senders
						--There is a newer RELEASE version of DBM out that has this mods fixes that we do not possess
						if DBM.HighestRelease >= modHFRevision and DBM.ReleaseRevision < modHFRevision then
							showConstantReminder = 2
							if DBM:AntiSpam(3, "HOTFIX") then
								AddMsg(DBM, L.UPDATEREMINDER_HOTFIX)
							end
						else--This mods fixes are in an alpha version
							if DBM:AntiSpam(3, "HOTFIX") then
								AddMsg(DBM, L.UPDATEREMINDER_HOTFIX_ALPHA)
							end
						end
					end
				end
			end
		end
	end

	syncHandlers["RLO"] = function(sender, protocol, statusWhisper, guildStatus, raidIcons, chatBubbles)
		if (DBM:GetRaidRank(sender) ~= 2 or not IsInGroup()) then return end--If not on group, we're probably sender, don't disable status. IF not leader, someone is trying to spoof this, block that too
		if not protocol or protocol ~= 2 then return end--Ignore old versions
		DBM:Debug("Raid leader override comm Received")
		statusWhisper, guildStatus, raidIcons, chatBubbles = tonumber(statusWhisper) or 0, tonumber(guildStatus) or 0, tonumber(raidIcons) or 0, tonumber(chatBubbles) or 0
		local activated = false
		if statusWhisper == 1 then
			activated = true
			private.statusWhisperDisabled = true
		end
		if guildStatus == 1 then
			activated = true
			private.statusGuildDisabled = true
		end
		if raidIcons == 1 then
			activated = true
			private.raidIconsDisabled = true
		end
		if chatBubbles == 1 then
			activated = true
			private.chatBubblesDisabled = true
		end
		if activated then
			AddMsg(DBM, L.OVERRIDE_ACTIVATED)
		end
	end

	syncHandlers["IS"] = function(_, _, guid, ver, optionName)
		ver = tonumber(ver) or 0
		if ver > (iconSetRevision[optionName] or 0) then--Save first synced version and person, ignore same version. refresh occurs only above version (fastest person)
			iconSetRevision[optionName] = ver
			iconSetPerson[optionName] = guid
		end
		if iconSetPerson[optionName] == UnitGUID("player") then--Check if that highest version was from ourself
			private.canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			private.canSetIcons[optionName] = false
		end
		local name = DBM:GetFullPlayerNameByGUID(iconSetPerson[optionName]) or CL.UNKNOWN
		DBM:Debug(name .. " was elected icon setter for " .. optionName, 2)
	end

	syncHandlers["K"] = function(_, _, cId)
		if select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "none" then return end
		cId = tonumber(cId or "")
		if cId then DBM:OnMobKill(cId, true) end
	end

	syncHandlers["EE"] = function(sender, _, eId, success, mod, modRevision)
		if select(2, IsInInstance()) == "pvp" then return end
		eId = tonumber(eId or "")
		success = tonumber(success)
		mod = DBM:GetModByName(mod or "")
		modRevision = tonumber(modRevision or 0) or 0
		if mod and eId and success and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) and not eeSyncSender[sender] then
			eeSyncSender[sender] = true
			eeSyncReceived = eeSyncReceived + 1
			if eeSyncReceived > (isRetail and 2 or 0) then -- need at least 3 person to combat end. (for security) (only 1 on classic because classic breaks too badly otherwise)
				DBM:EndCombat(mod, success == 0, nil, "ENCOUNTER_END synced")
			end
		end
	end

	local dummyMod -- dummy mod for the pull timer
	syncHandlers["PT"] = function(sender, _, timer, senderMapID, target)
		if DBM.Options.DontShowUserTimers then return end
		local LFGTankException = isRetail and IsPartyLFG() and UnitGroupRolesAssigned(sender) == "TANK"
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		--Abort if mapID filter is enabled and sender actually sent a mapID. if no mapID is sent, it's always passed through (IE BW pull timers)
		if DBM.Options.DontShowPTNoID and senderMapID and tonumber(senderMapID) ~= LastInstanceMapID then return end
		timer = tonumber(timer or 0)
		--We want to permit 0 itself, but block anything negative number or anything between 0 and 3 or anything longer than minute
		if timer > 60 or (timer > 0 and timer < 3) or timer < 0 then
			return
		end
		if timer == 0 or DBM:AntiSpam(1, "PT" .. sender) then--prevent double pull timer from BW and other mods that are sending D4 and D5 at same time
			if not dummyMod then
				local threshold = DBM.Options.PTCountThreshold2
				threshold = floor(threshold)
				---@class DBMDummyMod: DBMMod
				dummyMod = DBM:NewMod("PullTimerCountdownDummy")
				dummyMod.isDummyMod = true
				DBM:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{name = L.MINIMAP_TOOLTIP_HEADER}
				dummyMod.text = dummyMod:NewAnnounce("%s", 1, "132349")
				dummyMod.geartext = dummyMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3)
				dummyMod.timer = dummyMod:NewTimer(20, "%s", "132349", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 4, threshold, nil, nil, nil, nil, nil, nil, "pull")
			end
			--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not DBM.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_PULL)
				dummyMod.timer:Stop()
			end
			local timerTrackerRunning = false
			if not DBM.Options.DontShowPTCountdownText and TimerTracker then
				for _, tttimer in pairs(TimerTracker.timerList) do
					if not tttimer.isFree then--Timer event running
						if tttimer.type == 3 then--Its a pull timer event, this is one we cancel before starting a new pull timer
							FreeTimerTrackerTimer(tttimer)
						else--Verify that a TimerTracker event NOT started by DBM isn't running, if it is, prevent executing new TimerTracker events below
							timerTrackerRunning = true
						end
					end
				end
			end
			dummyMod.text:Cancel()
			if timer == 0 then return end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is why we let above part of code run but not below)
			DBM:FlashClientIcon()
			if not DBM.Options.DontShowPT2 then
				dummyMod.timer:Start(timer, L.TIMER_PULL)
			end
			if not DBM.Options.DontShowPTCountdownText and TimerTracker then
				if not timerTrackerRunning then--if a TimerTracker event is running not started by DBM, block creating one of our own (object gets buggy if it has 2+ events running)
					--Start A TimerTracker timer using the new countdown type 3 type (ie what C_PartyInfo.DoCountdown triggers, but without sending it to entire group)
					TimerTracker_OnEvent(TimerTracker, "START_TIMER", 3, timer, timer)
					--Find the timer object DBM just created and hack our own changes into it.
					for _, tttimer in pairs(TimerTracker.timerList) do
						if tttimer.type == 3 and not tttimer.isFree then
							--We don't want the PVP bar, we only want timer text
							if timer > 10 then
								--b.startNumbers:Play()
								tttimer.bar:Hide()
							end
							break
						end
					end
				end
			end
			if not DBM.Options.DontShowPTText then
				if target then
					dummyMod.text:Show(L.ANNOUNCE_PULL_TARGET:format(target, timer, sender))
					dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW_TARGET:format(target))
				else
					dummyMod.text:Show(L.ANNOUNCE_PULL:format(timer, sender))
					dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW)
				end
			end
			if DBM.Options.EventSoundPullTimer and DBM.Options.EventSoundPullTimer ~= "" and DBM.Options.EventSoundPullTimer ~= "None" then
				DBM:PlaySoundFile(DBM.Options.EventSoundPullTimer, nil, true)
			end
			if DBM.Options.RecordOnlyBosses then
				DBM:StartLogging(timer, checkForActualPull)--Start logging here to catch pre pots.
			end
			if isRetail and DBM.Options.CheckGear and not testBuild then
				local bagilvl, equippedilvl = GetAverageItemLevel()
				local difference = bagilvl - equippedilvl
				local weapon = GetInventoryItemLink("player", 16)
				local fishingPole = false
				if weapon then
					local _, _, _, _, _, _, type = GetItemInfo(weapon)
					if type and type == L.GEAR_FISHING_POLE then
						fishingPole = true
					end
				end
				if IsInRaid() and difference >= 18 then
					dummyMod.geartext:Show(L.GEAR_WARNING:format(floor(difference)))
				elseif IsInRaid() and (not weapon or fishingPole) then
					dummyMod.geartext:Show(L.GEAR_WARNING_WEAPON)
				end
			end
		end
	end

	do
		local dummyMod2 -- dummy mod for the break timer
		function breakTimerStart(self, timer, sender)
			if not dummyMod2 then
				local threshold = DBM.Options.PTCountThreshold2
				threshold = floor(threshold)
				---@class DBMDummyMod2: DBMMod
				dummyMod2 = DBM:NewMod("BreakTimerCountdownDummy")
				dummyMod2.isDummyMod = true
				DBM:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{name = L.MINIMAP_TOOLTIP_HEADER}
				dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, isRetail and "237538" or "136106")
				--timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
				dummyMod2.timer = dummyMod2:NewTimer(20, L.TIMER_BREAK, isRetail and "237538" or "136106", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 1, threshold, nil, nil, nil, nil, nil, nil, "break")
			end
			--Cancel any existing break timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not DBM.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_BREAK)
				dummyMod2.timer:Stop()
			end
			dummyMod2.text:Cancel()
			DBM.Options.RestoreSettingBreakTimer = nil
			if timer == 0 then return end--"/dbm break 0" will strictly be used to cancel the break timer (which is why we let above part of code run but not below)
			self.Options.RestoreSettingBreakTimer = timer .. "/" .. time()
			if not self.Options.DontShowPT2 then
				dummyMod2.timer:Start(timer)
			end
			if not self.Options.DontShowPTText then
				---@type number, string|number
				local hour, minute = GetGameTime()
				minute = minute + (timer / 60)
				if minute >= 60 then
					hour = hour + 1
					minute = minute - 60
				end
				minute = floor(minute)
				if minute < 10 then
					minute = tostring(0 .. minute)
				end
				dummyMod2.text:Show(L.BREAK_START:format(strFromTime(timer) .. " (" .. hour .. ":" .. minute .. ")", sender))
				if timer / 60 > 10 then dummyMod2.text:Schedule(timer - 10 * 60, L.BREAK_MIN:format(10)) end
				if timer / 60 > 5 then dummyMod2.text:Schedule(timer - 5 * 60, L.BREAK_MIN:format(5)) end
				if timer / 60 > 2 then dummyMod2.text:Schedule(timer - 2 * 60, L.BREAK_MIN:format(2)) end
				if timer / 60 > 1 then dummyMod2.text:Schedule(timer - 1 * 60, L.BREAK_MIN:format(1)) end
				dummyMod2.text:Schedule(timer, L.ANNOUNCE_BREAK_OVER:format(hour .. ":" .. minute))
			end
			C_TimerAfter(timer, function() self.Options.RestoreSettingBreakTimer = nil end)
		end
	end

	syncHandlers["BT"] = function(sender, _, timer)
		if DBM.Options.DontShowUserTimers then return end
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup()) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		if timer == 0 or DBM:AntiSpam(1, "BT" .. sender) then
			breakTimerStart(DBM, timer, sender)
		end
	end

	whisperSyncHandlers["BTR3"] = function(sender, _, timer)
		if DBM.Options.DontShowUserTimers then return end
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		DBM:Unschedule(DBM.RequestTimers)--IF we got BTR3 sync, then we know immediately RequestTimers was successful, so abort others
		if #inCombat >= 1 then return end
		if DBT:GetBar(L.TIMER_BREAK) then return end--Already recovered. Prevent duplicate recovery
		breakTimerStart(DBM, timer, sender)
	end

	local function SendVersion(guild)
		if guild then
			local message = ("%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, tostring(PForceDisable))
			sendGuildSync(2, "GV", message)
			return
		end
		if DBM.Options.FakeBWVersion and not dbmIsEnabled then
			SendAddonMessage("BigWigs", bwVersionResponseString:format(fakeBWVersion, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
			return
		end
		--(Note, faker isn't to screw with bigwigs nor is theirs to screw with dbm, but rathor raid leaders who don't let people run WTF they want to run)
		local VPVersion
		local VoicePack = DBM.Options.ChosenVoicePack2
		if not voiceSessionDisabled and VoicePack ~= "None" and DBM.VoiceVersions[VoicePack] then
			VPVersion = "/ VP" .. VoicePack .. ": v" .. DBM.VoiceVersions[VoicePack]
		end
		if VPVersion then
			sendSync(2, "V", ("%s\t%s\t%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), tostring(PForceDisable), VPVersion))
		else
			sendSync(2, "V", ("%s\t%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), tostring(PForceDisable)))
		end
	end

	local function HandleVersion(revision, version, displayVersion, forceDisable, sender)
		if version > DBM.Revision then -- Update reminder
			if #newerVersionPerson < 4 then
				if not checkEntry(newerVersionPerson, sender) then
					newerVersionPerson[#newerVersionPerson + 1] = sender
					DBM:Debug("Newer version detected from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision), 3)
					if forceDisable > PForceDisable and not checkEntry(forceDisablePerson, sender) then
						forceDisablePerson[#forceDisablePerson + 1] = sender
						DBM:Debug("Newer force disable detected from " .. sender .. " : Rev - " .. forceDisable, 3)
					end
				end
				if #newerVersionPerson == 2 and updateNotificationDisplayed < 2 then--Only requires 2 for update notification.
					if DBM.HighestRelease < version then
						DBM.HighestRelease = version--Increase HighestRelease
						DBM.NewerVersion = displayVersion--Apply NewerVersion
						--UGLY hack to get release version number instead of alpha one
						if DBM.NewerVersion:find("alpha") then
							local temp1, _ = string.split(" ", DBM.NewerVersion)--Strip down to just version, no alpha
							if temp1 then
								local temp3, temp4, temp5 = string.split(".", temp1)--Strip version down to 3 numbers
								if temp3 and temp4 and temp5 and tonumber(temp5) then
									temp5 = tonumber(temp5)
									temp5 = temp5 - 1
									temp5 = tostring(temp5)
									DBM.NewerVersion = temp3 .. "." .. temp4 .. "." .. temp5
								end
							end
						end
					end
					--Find min revision.
					updateNotificationDisplayed = 2
					AddMsg(DBM, L.UPDATEREMINDER_HEADER:match("([^\n]*)"))
					AddMsg(DBM, L.UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, showRealDate(version)))
					showConstantReminder = 1
				elseif #newerVersionPerson >= 3 and updateNotificationDisplayed < 3 then--The following code requires at least THREE people to send that higher revision. That should be more than adaquate
					--Disable if out of date and at least 3 players sent a higher forceDisable revision
					if not testBuild and #forceDisablePerson == 3 then
						-- Start days check
						local curseDate = tostring(version)
						local daysPerMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
						local year, month, day = tonumber(curseDate:sub(1, 4)), tonumber(curseDate:sub(5, 6)), tonumber(curseDate:sub(7, 8))
						if day + 2 > daysPerMonth[month] then
							day = day + 2 - daysPerMonth[month]
							month = month + 1
						else
							day = day + 2
						end
						if month > 12 then
							month = 1
							year = year + 1
						end
						local currentDateTable = date("*t")
						if currentDateTable.year < year or currentDateTable.month < month or currentDateTable.day < day then
							return
						end
						-- End days check
						updateNotificationDisplayed = 3
						DBM:ForceDisableSpam()
						DBM:Disable(true)
					--Disallow out of date to run during beta/ptr what so ever regardless of forceDisable revision
					elseif testBuild then
						updateNotificationDisplayed = 3
						DBM:ForceDisableSpam()
						DBM:Disable(true)
					end
				end
			end
		end
	end

	-- TODO: is there a good reason that version information is broadcasted and not unicasted?
	syncHandlers["H"] = function()
		DBM:Unschedule(SendVersion)--Throttle so we don't needlessly send tons of comms during initial raid invites
		DBM:Schedule(3, SendVersion)--Send version if 3 seconds have past since last "Hi" sync
	end

	guildSyncHandlers["GH"] = function()
		if DBM.ReleaseRevision >= DBM.HighestRelease then--Do not send version to guild if it's not up to date, since this is only used for update notifcation
			DBM:Unschedule(SendVersion, true)
			--Throttle so we don't needlessly send tons of comms
			--For every 50 players online, DBM has an increasingly lower chance of replying to a version check request. This is because only 3 people actually need to reply
			--50 people or less, 100% chance anyone who saw request will reply
			--100 people on, only 50% chance DBM users replies to request
			--150 people on, only 33% chance a DBM user replies to request
			--1000 people online, only 5% chance a DBM user replies to request
			local _, online = GetNumGuildMembers()
			local chances = (online or 1) / 50
			if chances < 1 then chances = 1 end
			if mrandom(1, chances) == 1 then
				DBM:Schedule(5, SendVersion, true)--Send version if 5 seconds have past since last "Hi" sync
			end
		end
	end

	syncHandlers["BV"] = function(sender, _, version, hash)--Parsed from bigwigs V7+
		if version and raid[sender] then
			raid[sender].bwversion = version
			raid[sender].bwhash = hash or ""
		end
	end

	syncHandlers["V"] = function(sender, protocol, revision, version, displayVersion, locale, iconEnabled, forceDisable, VPVersion)
		revision, version = tonumber(revision), tonumber(version)
		if protocol >= 2 then
			forceDisable = tonumber(forceDisable) or 0
		else
			-- Protocol 1 did not send forceDisable, VPVersion was in that position
			VPVersion = forceDisable
			forceDisable = 0
		end
		if revision and version and displayVersion and raid[sender] then
			raid[sender].revision = revision
			raid[sender].version = version
			raid[sender].displayVersion = displayVersion
			raid[sender].VPVersion = VPVersion
			raid[sender].locale = locale
			raid[sender].enabledIcons = iconEnabled or "false"
			DBM:Debug("Received version info from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision), 3)
			HandleVersion(revision, version, displayVersion, forceDisable, sender)
		end
		DBM:GROUP_ROSTER_UPDATE()
	end

	guildSyncHandlers["GV"] = function(sender, _, revision, version, displayVersion, forceDisable)
		revision, version, forceDisable = tonumber(revision), tonumber(version), tonumber(forceDisable) or 0
		if revision and version and displayVersion then
			DBM:Debug("Received G version info from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision) .. ", Display Version " .. displayVersion, 3)
			HandleVersion(revision, version, displayVersion, forceDisable, sender)
		end
	end

	syncHandlers["U"] = function(sender, _, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM.Options.DontShowUserTimers then return end
		if DBM:GetRaidRank(sender) == 0 or difficultyIndex == 7 or difficultyIndex == 17 then return end
		if sender == playerName then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
		end
	end

	whisperSyncHandlers["UW"] = function(sender, _, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM.Options.DontShowUserTimers then return end
		if DBM:GetRaidRank(sender) == 0 or difficultyIndex == 7 or difficultyIndex == 17 then return end--Block in LFR, or if not an assistant
		if sender == playerName then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
		end
	end

	guildSyncHandlers["GCB"] = function(_, protocol, modId, difficulty, difficultyModifier, name, groupLeader)
		if not DBM.Options.ShowGuildMessages or not difficulty or DBM:GetRaidRank(groupLeader or "") == 2 then return end
		if not protocol or protocol ~= 4 then return end--Ignore old versions
		if DBM:AntiSpam(isRetail and 10 or 20, "GCB") then
			if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
			difficulty = tonumber(difficulty)
			if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
			modId = tonumber(modId)
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			if not isClassic and not isBCC then
				local difficultyName
				if difficulty == 8 then
					if difficultyModifier and difficultyModifier ~= 0 then
						difficultyName = PLAYER_DIFFICULTY6 .. "+ (" .. difficultyModifier .. ")"
					else
						difficultyName = PLAYER_DIFFICULTY6 .. "+"
					end
				elseif difficulty == 3 or difficulty == 175 then
					difficultyName = RAID_DIFFICULTY1
				elseif difficulty == 4 or difficulty == 176 then
					difficultyName = RAID_DIFFICULTY2
				elseif difficulty == 5 or difficulty == 193 then
					difficultyName = RAID_DIFFICULTY3
				elseif difficulty == 6 or difficulty == 194 then
					difficultyName = RAID_DIFFICULTY4
				elseif difficulty == 16 then
					difficultyName = PLAYER_DIFFICULTY6
				elseif difficulty == 15 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				DBM:AddMsg(L.GUILD_COMBAT_STARTED:format(difficultyName .. " - " .. bossName, groupLeader))-- "%s has been engaged by %s's guild group"
			else--Vanilla and TBC single format raids
				DBM:AddMsg(L.GUILD_COMBAT_STARTED:format(bossName, groupLeader))
			end
		end
	end

	guildSyncHandlers["GCE"] = function(_, protocol, modId, wipe, time, difficulty, difficultyModifier, name, groupLeader, wipeHP)
		if not DBM.Options.ShowGuildMessages or not difficulty or DBM:GetRaidRank(groupLeader or "") == 2 then return end
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if DBM:AntiSpam(isRetail and 10 or 20, "GCE") then
			if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
			difficulty = tonumber(difficulty)
			if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
			modId = tonumber(modId)
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			if not isClassic and not isBCC then
				local difficultyName
				if difficulty == 8 then
					if difficultyModifier and difficultyModifier ~= 0 then
						difficultyName = PLAYER_DIFFICULTY6 .. "+ (" .. difficultyModifier .. ")"
					else
						difficultyName = PLAYER_DIFFICULTY6 .. "+"
					end
				elseif difficulty == 3 or difficulty == 175 then
					difficultyName = RAID_DIFFICULTY1
				elseif difficulty == 4 or difficulty == 176 then
					difficultyName = RAID_DIFFICULTY2
				elseif difficulty == 5 or difficulty == 193 then
					difficultyName = RAID_DIFFICULTY3
				elseif difficulty == 6 or difficulty == 194 then
					difficultyName = RAID_DIFFICULTY4
				elseif difficulty == 16 then
					difficultyName = PLAYER_DIFFICULTY6
				elseif difficulty == 15 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				if wipe == "1" then
					DBM:AddMsg(L.GUILD_COMBAT_ENDED_AT:format(groupLeader or CL.UNKNOWN, difficultyName .. " - " .. bossName, wipeHP, time))--"%s's Guild group has wiped on %s (%s) after %s.
				else
					DBM:AddMsg(L.GUILD_BOSS_DOWN:format(difficultyName .. " - " .. bossName, groupLeader or CL.UNKNOWN, time))--"%s has been defeated by %s's guild group after %s!"
				end
			else--Vanilla and TBC single format raids
				if wipe == "1" then
					DBM:AddMsg(L.GUILD_COMBAT_ENDED_AT:format(groupLeader or CL.UNKNOWN, bossName, wipeHP, time))
				else
					DBM:AddMsg(L.GUILD_BOSS_DOWN:format(bossName, groupLeader or CL.UNKNOWN, time))
				end
			end
		end
	end

	guildSyncHandlers["WBE"] = function(sender, protocol, modId, realm, health, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if lastBossEngage[modId .. realm] and (GetTime() - lastBossEngage[modId .. realm] < 30) then return end--We recently got a sync about this boss on this realm, so do nothing.
		lastBossEngage[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), sender))
		end
	end

	guildSyncHandlers["WBD"] = function(sender, protocol, modId, realm, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if lastBossDefeat[modId .. realm] and (GetTime() - lastBossDefeat[modId .. realm] < 30) then return end
		lastBossDefeat[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, sender))
		end
	end

	guildSyncHandlers["WBA"] = function(sender, protocol, bossName, faction, spellId, time) -- Classic only
		DBM:Debug("WBA sync recieved")
		if not protocol or protocol ~= 4 or isRetail then return end--Ignore old versions
		if lastBossEngage[bossName .. faction] and (GetTime() - lastBossEngage[bossName .. faction] < 30) then return end--We recently got a sync about this buff on this realm, so do nothing.
		lastBossEngage[bossName .. faction] = GetTime()
		if DBM.Options.WorldBuffAlert and #inCombat == 0 then
			DBM:Debug("WBA sync processing")
			local factionText = faction == "Alliance" and FACTION_ALLIANCE or faction == "Horde" and FACTION_HORDE or CL.BOTH
			local buffName, _, buffIcon = DBM:GetSpellInfo(tonumber(spellId) or 0)
			DBM:AddMsg(L.WORLDBUFF_STARTED:format(buffName or CL.UNKNOWN, factionText, sender))
			DBM:PlaySoundFile(DBM.Options.RaidWarningSound, true)
			time = tonumber(time)
			if time then
				DBT:CreateBar(time, buffName or CL.UNKNOWN, buffIcon or 136106)
			end
		end
	end

	whisperSyncHandlers["WBE"] = function(sender, protocol, modId, realm, health, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if lastBossEngage[modId .. realm] and (GetTime() - lastBossEngage[modId .. realm] < 30) then return end
		lastBossEngage[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and (isRetail and not IsEncounterInProgress() or #inCombat == 0) then
			local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
			local toonName = gameAccountInfo and gameAccountInfo.characterName or CL.UNKNOWN
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), toonName))
		end
	end

	whisperSyncHandlers["WBD"] = function(sender, protocol, modId, realm, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if lastBossDefeat[modId .. realm] and (GetTime() - lastBossDefeat[modId .. realm] < 30) then return end
		lastBossDefeat[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
			local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
			local toonName = gameAccountInfo and gameAccountInfo.characterName or CL.UNKNOWN
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, toonName))
		end
	end

	whisperSyncHandlers["WBA"] = function(sender, protocol, bossName, faction, spellId, time) -- Classic only
		DBM:Debug("WBA sync recieved")
		if not protocol or protocol ~= 4 or isRetail then return end--Ignore old versions
		if lastBossEngage[bossName .. faction] and (GetTime() - lastBossEngage[bossName .. faction] < 30) then return end--We recently got a sync about this buff on this realm, so do nothing.
		lastBossEngage[bossName .. faction] = GetTime()
		if DBM.Options.WorldBuffAlert and #inCombat == 0 then
			DBM:Debug("WBA sync processing")
			local factionText = faction == "Alliance" and FACTION_ALLIANCE or faction == "Horde" and FACTION_HORDE or CL.BOTH
			local buffName, _, buffIcon = DBM:GetSpellInfo(tonumber(spellId) or 0)
			DBM:AddMsg(L.WORLDBUFF_STARTED:format(buffName or CL.UNKNOWN, factionText, sender))
			DBM:PlaySoundFile(DBM.Options.RaidWarningSound, true)
			time = tonumber(time)
			if time then
				DBT:CreateBar(time, buffName or CL.UNKNOWN, buffIcon or 136106)
			end
		end
	end

	whisperSyncHandlers["RT"] = function(sender)
		if UnitInBattleground("player") then
			DBM:SendPVPTimers(sender)
		else
			DBM:SendTimers(sender)
		end
	end

	whisperSyncHandlers["CI"] = function(sender, _, mod, time)
		mod = DBM:GetModByName(mod or "")
		time = tonumber(time or 0)
		if mod and time then
			DBM:ReceiveCombatInfo(sender, mod, time)
		end
	end

	whisperSyncHandlers["TR"] = function(sender, _, mod, timeLeft, totalTime, id, paused, ...)
		mod = DBM:GetModByName(mod or "")
		timeLeft = tonumber(timeLeft or 0)
		totalTime = tonumber(totalTime or 0)
		if mod and timeLeft and timeLeft > 0 and totalTime and totalTime > 0 and id then
			DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, paused and paused == "1" and true or false, ...)
		end
	end

	whisperSyncHandlers["VI"] = function(sender, _, mod, name, value)
		mod = DBM:GetModByName(mod or "")
		value = tonumber(value) or value
		if mod and name and value then
			DBM:ReceiveVariableInfo(sender, mod, name, value)
		end
	end

	--Function to correct a blizzard bug where off realm players have realm name stripped
	--Had to be custom function due to bugs with two players with same name on different realms
	--local function VerifyRaidName(apiName, SyncedName)
	--	local _, serverName = string.split("-", SyncedName)
	--	if serverName and serverName ~= playerRealm and serverName ~= normalizedPlayerRealm then
	--		return SyncedName--Use synced name with realm added back on
	--	else
	--		return apiName--Use api name without realm
	--	end
	--end

	handleSync = function(channel, sender, _, protocol, prefix, ...)--dbmSender unused for now
		protocol = tonumber(protocol)
		if not protocol then
			return
		end
		if protocol < DBMSyncProtocol then
			return
		end
		if not prefix then
			return
		end
		local handler
		--Can only be from a friend
		if channel == "BN_WHISPER" then
			handler = whisperSyncHandlers[prefix]
		--Whisper syncs sent from non friends are automatically rejected if not from a friend or someone in your group
		elseif channel == "WHISPER" and sender ~= playerName then -- separate between broadcast and unicast, broadcast must not be sent as unicast or vice-versa
			if (checkForSafeSender(sender, true) or DBM:GetRaidUnitId(sender)) then--Sender passes safety check, or is in group
				handler = whisperSyncHandlers[prefix]
			end
		elseif channel == "GUILD" then
			handler = guildSyncHandlers[prefix]
		else-- Instance, Raid, Party
			handler = syncHandlers[prefix]
		end
		if handler then
			--if dbmSender then
			--	--Strip spaces from realm name, since this is what Unit Tokens expect
			--	--(newer versions of DBM do this on send, but we double check for older versions)
			--	dbmSender = dbmSender:gsub("[%s-]+", "")--Needs to be fixed, if this is ever uncommented as right now it'd strip realm
			--	sender = VerifyRaidName(sender, dbmSender)
			--end
			return handler(sender, protocol, ...)
		end
	end

	local function GetCorrectSender(senderOne, senderTwo)
		local correctSender = senderOne
		if senderOne:find("-") then--first sender arg has realm name
			correctSender = Ambiguate(senderOne, "none")
		elseif senderTwo and senderTwo:find("-") then--Second sender arg has realm name
			correctSender = Ambiguate(senderTwo, "none")
		end
		return correctSender
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, senderOne, senderTwo)
		if prefix == DBMPrefix and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT" or channel == "WHISPER" or channel == "GUILD") then
			local correctSender = GetCorrectSender(senderOne, senderTwo)
			if channel == "WHISPER" then
				handleSync(channel, correctSender, nil, strsplit("\t", msg))
			else
				handleSync(channel, correctSender, strsplit("\t", msg))
			end
		elseif prefix == "BigWigs" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT") then
			local bwPrefix, bwMsg, extra = strsplit("^", msg)
			if bwPrefix and bwMsg then
				local correctSender = GetCorrectSender(senderOne, senderTwo)
				if bwPrefix == "V" and extra then--Nil check "extra" to avoid error from older version
					local verString, hash = bwMsg, extra
					local version = tonumber(verString) or 0
					if version == 0 then return end--Just a query
					handleSync(channel, correctSender, nil, DBMSyncProtocol, "BV", version, hash)--Prefix changed, so it's not handled by DBMs "V" handler
					if version > fakeBWVersion then--Newer revision found, upgrade!
						fakeBWVersion = version
						fakeBWHash = hash
					end
				elseif bwPrefix == "Q" then--Version request prefix
					self:Unschedule(SendVersion)
					self:Schedule(3, SendVersion)
				elseif bwPrefix == "B" then--Boss Mod Sync
					for i = #inCombat, 1, -1 do
						local mod = inCombat[i]
						if mod and mod.OnBWSync then
							mod:OnBWSync(bwMsg, extra, correctSender)
						end
					end
					for i = 1, #oocBWComms do
						local mod = oocBWComms[i]
						if mod and mod.OnBWSync then
							mod:OnBWSync(bwMsg, extra, correctSender)
						end
					end
				end
			end
		elseif prefix == "Transcriptor" and msg then
			local correctSender = GetCorrectSender(senderOne, senderTwo)
			for i = #inCombat, 1, -1 do
				local mod = inCombat[i]
				if mod and mod.OnTranscriptorSync then
					mod:OnTranscriptorSync(msg, correctSender)
				end
			end
			local transcriptor = _G["Transcriptor"]
			if msg:find("spell:") and (DBM.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging())) then
				local spellId = string.match(msg, "spell:(%d+)") or CL.UNKNOWN
				local spellName = string.match(msg, "h%[(.-)%]|h") or CL.UNKNOWN
				local message = "RAID_BOSS_WHISPER on " .. correctSender .. " with spell of " .. spellName .. " (" .. spellId .. ")"
				self:Debug(message)
			end
		end
	end
	DBM.CHAT_MSG_ADDON_LOGGED = DBM.CHAT_MSG_ADDON

	function DBM:BN_CHAT_MSG_ADDON(prefix, msg, _, sender)
		if prefix == DBMPrefix and msg then
			handleSync("BN_WHISPER", sender, nil, strsplit("\t", msg))
		end
	end
end

----------------------
--  Pull Detection  --
----------------------
do
	local targetList = {}
	local function buildTargetList()
		local uId = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local id = (i == 0 and "target") or uId .. i .. "target"
			local guid = UnitGUID(id)
			if guid and DBM:IsCreatureGUID(guid) then
				targetList[DBM:GetCIDFromGUID(guid)] = id
			end
		end
	end

	local function clearTargetList()
		twipe(targetList)
	end

	local function scanForCombat(mod, mob, delay)
		if not checkEntry(inCombat, mob) then
			buildTargetList()
			if targetList[mob] then
				if mod.noFriendlyEngagement and UnitIsFriend("player", targetList[mob]) then return end
				if delay > 0 and UnitAffectingCombat(targetList[mob]) and not (UnitPlayerOrPetInRaid(targetList[mob]) or UnitPlayerOrPetInParty(targetList[mob])) then
					DBM:StartCombat(mod, delay, "PLAYER_REGEN_DISABLED")
				elseif (delay == 0) then
					DBM:StartCombat(mod, 0, "PLAYER_REGEN_DISABLED_AND_MESSAGE")
				end
			end
			clearTargetList()
		end
	end

	local function checkForPull(mob, combatInfo)
		healthCombatInitialized = false
		--This just can't be avoided, tryig to save cpu by using C_TimerAfter broke this
		--This needs the redundancy and ability to pass args.
		DBM:Schedule(0.5, scanForCombat, combatInfo.mod, mob, 0.5)
		if not isRetail then
			DBM:Schedule(1.25, scanForCombat, combatInfo.mod, mob, 1.25)
		end
		DBM:Schedule(2, scanForCombat, combatInfo.mod, mob, 2)
		C_TimerAfter(2.1, function()
			healthCombatInitialized = true
		end)
	end

	-- TODO: fix the duplicate code that was added for quick & dirty support of zone IDs

	-- detects a boss pull based on combat state, this is required for pre-ICC bosses that do not fire INSTANCE_ENCOUNTER_ENGAGE_UNIT events on engage
	function DBM:PLAYER_REGEN_DISABLED()
		lastCombatStarted = GetTime()
		if not combatInitialized then return end
		if dbmIsEnabled and combatInfo[LastInstanceMapID] then
			for _, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type:find("combat") and not v.noRegenDetection and not (#inCombat > 0 and v.noMultiBoss) then
					if v.multiMobPullDetection then
						for _, mob in ipairs(v.multiMobPullDetection) do
							if checkForPull(mob, v) then
								break
							end
						end
					else
						checkForPull(v.mob, v)
					end
				end
			end
		end
		if self.Options.AFKHealthWarning2 and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
			self:FlashClientIcon()
			local voice = DBM.Options.ChosenVoicePack2
			local path = 546633--"Sound\\Creature\\CThun\\CThunYouWillDIe.ogg"
			if not voiceSessionDisabled and voice ~= "None" then
				path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
			end
			self:PlaySoundFile(path)
			if UnitHealthMax("player") ~= 0 then
				local health = UnitHealth("player") / UnitHealthMax("player") * 100
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		end
	end

	function DBM:PLAYER_REGEN_ENABLED()
		if delayedFunction then--Will throw error if not a function, purposely not doing and type(delayedFunction) == "function" for now to make sure code works though because it always should be function
			delayedFunction()
			delayedFunction = nil
		end
		if watchFrameRestore then
			if isRetail then
				ObjectiveTracker_Expand()
			elseif isCata or isWrath then
				WatchFrame:Show()
			else -- Classic Era / BCC
				QuestWatchFrame:Show()
			end
			watchFrameRestore = false
		end
		local QuestieLoader = _G["QuestieLoader"]
		if QuestieLoader then
			local QuestieTracker = _G["QuestieTracker"] or QuestieLoader:ImportModule("QuestieTracker")--Might be a global in some versions, but not a global in others
			if QuestieTracker and questieWatchRestore and QuestieTracker.Enable then
				QuestieTracker:Enable()
				questieWatchRestore = false
			end
		end
	end

	local function isBossEngaged(cId)
		-- note that this is designed to work with any number of bosses, but it might be sufficient to check the first 5 unit ids
		local i = 1
		repeat
			local bossUnitId = "boss" .. i
			local bossGUID = not UnitIsDead(bossUnitId) and UnitGUID(bossUnitId) -- check for UnitIsVisible maybe?
			local bossCId = bossGUID and DBM:GetCIDFromGUID(bossGUID)
			if bossCId and (type(cId) == "number" and cId == bossCId or type(cId) == "table" and checkEntry(cId, bossCId)) then
				return true
			end
			i = i + 1
		until not bossGUID
	end

	function DBM:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		if timerRequestInProgress then return end--do not start ieeu combat if timer request is progressing. (not to break Timer Recovery stuff)
		if dbmIsEnabled and combatInfo[LastInstanceMapID] then
			self:Debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId" .. LastInstanceMapID, 3)
			for _, v in ipairs(combatInfo[LastInstanceMapID]) do
				if not v.noIEEUDetection and not (#inCombat > 0 and v.noMultiBoss) then
					if v.type:find("combat") and isBossEngaged(v.multiMobPullDetection or v.mob) then
						self:StartCombat(v.mod, 0, "IEEU")
					end
				end
			end
		end
	end

	function DBM:ENCOUNTER_START(encounterID, name, difficulty, size)
		self:Debug("ENCOUNTER_START event fired: " .. encounterID .. " " .. name .. " " .. difficulty .. " " .. size)
		if dbmIsEnabled then
			--Only nag in raids on engage
			if IsInRaid() then
				self:CheckAvailableMods()
			end
			if combatInfo[LastInstanceMapID] then
				for _, v in ipairs(combatInfo[LastInstanceMapID]) do
					if not v.noESDetection and not (#inCombat > 0 and v.noMultiBoss) then
						if v.multiEncounterPullDetection then
							for _, eId in ipairs(v.multiEncounterPullDetection) do
								if encounterID == eId then
									self:StartCombat(v.mod, 0, "ENCOUNTER_START")
									return
								end
							end
						elseif encounterID == v.eId then
							self:StartCombat(v.mod, 0, "ENCOUNTER_START")
							return
						end
					end
				end
			end
		end
	end

	function DBM:ENCOUNTER_END(encounterID, name, difficulty, size, success)
		self:Debug("ENCOUNTER_END event fired: " .. encounterID .. " " .. name .. " " .. difficulty .. " " .. size .. " " .. success)
		if success == 0 then
			--Only nag on wipes (in any content)
			self:CheckAvailableMods()
		end
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.noEEDetection then return end
			if v.respawnTime and success == 0 and self.Options.ShowRespawn and not self.Options.DontShowEventTimers then--No special hacks needed for bad wrath ENCOUNTER_END. Only mods that define respawnTime have a timer, since variable per boss.
				name = string.split(",", name)
				DBT:CreateBar(v.respawnTime, L.TIMER_RESPAWN:format(name), isRetail and 237538 or 136106)--Interface\\Icons\\Spell_Holy_BorrowedTime, Spell_nature_timestop
				fireEvent("DBM_TimerStart", "DBMRespawnTimer", L.TIMER_RESPAWN:format(name), v.respawnTime, isRetail and "237538" or "136106", "extratimer", nil, 0, v.id)
			end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						self:EndCombat(v, success == 0, nil, "ENCOUNTER_END")
						sendSync(DBMSyncProtocol, "EE", encounterID .. "\t" .. success .. "\t" .. v.id .. "\t" .. (v.revision or 0))
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v, success == 0, nil, "ENCOUNTER_END")
				sendSync(DBMSyncProtocol, "EE", encounterID .. "\t" .. success .. "\t" .. v.id .. "\t" .. (v.revision or 0))
				return
			end
		end
	end

	function DBM:BOSS_KILL(encounterID, name)
		self:Debug("BOSS_KILL event fired: " .. encounterID .. " " .. name)
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.noBKDetection then return end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						self:EndCombat(v, nil, nil, "BOSS_KILL")
						sendSync(DBMSyncProtocol, "EE", encounterID .. "\t1\t" .. v.id .. "\t" .. (v.revision or 0))
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v, nil, nil, "BOSS_KILL")
				sendSync(DBMSyncProtocol, "EE", encounterID .. "\t1\t" .. v.id .. "\t" .. (v.revision or 0))
				return
			end
		end
	end

	local function checkExpressionList(exp, str)
		for _, v in ipairs(exp) do
			if str:match(v) then
				return true
			end
		end
		return false
	end

	-- called for all mob chat events
	local function onMonsterMessage(self, type, msg)
		-- pull detection
		if dbmIsEnabled and combatInfo[LastInstanceMapID] then
			for _, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type == type and checkEntry(v.msgs, msg) or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg) and not (#inCombat > 0 and v.noMultiBoss) then
					self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
				elseif v.type == "combat_" .. type .. "find" and tContains(v.msgs, msg) or v.type == "combat_" .. type and checkEntry(v.msgs, msg) and not (#inCombat > 0 and v.noMultiBoss) then
					if IsInInstance() then--Indoor boss that uses both combat and message for combat, so in other words (such as hodir), don't require "target" of boss for yell like scanForCombat does for World Bosses
						self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
					else--World Boss
						scanForCombat(v.mod, v.mob, 0)
						if v.mod.readyCheckQuestId and (self.Options.WorldBossNearAlert or v.mod.Options.ReadyCheck) and not IsQuestFlaggedCompleted(v.mod.readyCheckQuestId) and v.mod.readyCheckMaxLevel >= playerLevel then
							self:FlashClientIcon()
							self:PlaySoundFile(567478, true)
						end
					end
				end
			end
		end
		-- kill detection (wipe detection would also be nice to have)
		-- todo: add sync
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.combatInfo.killType == type and v.combatInfo.killMsgs[msg] then
				self:EndCombat(v, nil, nil, "onMonsterMessage")
			end
		end
	end

	function DBM:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
		if IsEncounterInProgress() or (IsInInstance() and InCombatLockdown()) then--Too many 5 mans/old raids don't properly return encounterinprogress
			local targetName = target or "nil"
			self:Debug("CHAT_MSG_MONSTER_YELL from " .. npc .. " while looking at " .. targetName, 2)
		end
		if not isRetail and not IsInInstance() then
			if msg:find(L.WORLD_BUFFS.hordeOny) then
				SendWorldSync(self, 4, "WBA", "Onyxia\tHorde\t22888\t15\t4")
				DBM:Debug("L.WORLD_BUFFS.hordeOny detected")
			elseif msg:find(L.WORLD_BUFFS.allianceOny) then
				SendWorldSync(self, 4, "WBA", "Onyxia\tAlliance\t22888\t15\t4")
				DBM:Debug("L.WORLD_BUFFS.allianceOny detected")
			elseif msg:find(L.WORLD_BUFFS.hordeNef) then
				SendWorldSync(self, 4, "WBA", "Nefarian\tHorde\t22888\t16\t4")
				DBM:Debug("L.WORLD_BUFFS.hordeNef detected")
			elseif msg:find(L.WORLD_BUFFS.allianceNef) then
				SendWorldSync(self, 4, "WBA", "Nefarian\tAlliance\t22888\t16\t4")
				DBM:Debug("L.WORLD_BUFFS.allianceNef detected")
			elseif msg:find(L.WORLD_BUFFS.rendHead) then
				SendWorldSync(self, 4, "WBA", "rendBlackhand\tHorde\t16609\t7\t4")
				DBM:Debug("L.WORLD_BUFFS.rendHead detected")
			elseif msg:find(L.WORLD_BUFFS.zgHeartYojamba) then
				-- zg buff transcripts https://gist.github.com/venuatu/18174f0e98759f83b9834574371b8d20
				-- 28.58, 28.67, 27.77, 29.39, 28.67, 29.03, 28.12, 28.19, 29.61
				SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t28\t4")
				DBM:Debug("L.WORLD_BUFFS.zgHeartYojamba detected")
			elseif msg:find(L.WORLD_BUFFS.zgHeartBooty) then
				-- 48.7, 49.76, 50.64, 49.42, 49.8, 50.67, 50.94, 51.06
				SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t49\t4")
				DBM:Debug("L.WORLD_BUFFS.zgHeartBooty detected")
			elseif msg:find(L.WORLD_BUFFS.blackfathomBoon) then
				--SendWorldSync(self, 4, "WBA", "Blackfathom\tBoth\t430947\t6\t4")
				DBM:Debug("L.WORLD_BUFFS.blackfathomBoon detected")
			end
		end
		return onMonsterMessage(self, "yell", msg)
	end

	function DBM:CHAT_MSG_MONSTER_EMOTE(msg)
		return onMonsterMessage(self, "emote", msg)
	end

	function DBM:CHAT_MSG_RAID_BOSS_EMOTE(msg, sender, ...)
		onMonsterMessage(self, "emote", msg)
		local id = msg:match("|Hspell:([^|]+)|h")
		if id then
			local spellId = tonumber(id)
			if spellId then
				local spellName = DBM:GetSpellInfo(spellId) or CL.UNKNOWN
				self:Debug("CHAT_MSG_RAID_BOSS_EMOTE fired: " .. sender .. "'s " .. spellName .. "(" .. spellId .. ")", 2)
			end
		end
		return self:FilterRaidBossEmote(msg, sender, ...)
	end

	function DBM:RAID_BOSS_EMOTE(msg, ...)--This is a mirror of above prototype only it has less args, both still exist for some reason.
		onMonsterMessage(self, "emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:RAID_BOSS_WHISPER(msg)
		--Make it easier for devs to detect whispers they are unable to see
		--TINTERFACE\\ICONS\\ability_socererking_arcanewrath.blp:20|t You have been branded by |cFFF00000|Hspell:156238|h[Arcane Wrath]|h|r!"
		if msg and msg ~= "" and IsInGroup() and not _G["BigWigs"] then
			SendAddonMessage("Transcriptor", msg, IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")--Send any emote to transcriptor, even if no spellid
		end
	end

	function DBM:GOSSIP_SHOW()
		if not IsInInstance() then return end--Don't really care about it if not in a dungeon or raid
		local cid = self:GetUnitCreatureId("npc") or 0
		local gossipOptionID = self:GetGossipID(true)
		if gossipOptionID then--At least one must return for debug
			self:Debug("GOSSIP_SHOW triggered with a gossip ID(s) of " .. strjoin(", ", gossipOptionID) .. " on creatureID " .. cid)
		end
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		if not isRetail and not IsInInstance() then
			if msg:find(L.WORLD_BUFFS.zgHeart) then
				-- 51.01 51.82 51.85 51.53
				SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t51\t4")
			end
		end
		return onMonsterMessage(self, "say", msg)
	end
end

---------------------------
--  Kill/Wipe Detection  --
---------------------------

local lastValidCombat = 0
function checkWipe(self, confirm, confirmTime)
	if #inCombat > 0 then
		if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
		end
		--hack for no iEEU information is provided.
		if not bossuIdFound then
			for i = 1, 10 do
				if UnitExists("boss" .. i) then
					bossuIdFound = true
					break
				end
			end
		end
		local wipe -- 0: no wipe, 1: normal wipe, 2: wipe by UnitExists check.
		if (isRetail and IsInScenarioGroup()) or (difficultyIndex == 11) or (difficultyIndex == 12) then -- Scenario mod uses special combat start and must be enabled before sceniro end. So do not wipe.
			wipe = 0
		elseif IsEncounterInProgress() then -- Encounter Progress marked, you obviously in combat with boss. So do not Wipe
			wipe = 0
		elseif savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- On dead or ghost, unit combat status detection would be fail. If you ghost in instance, that means wipe. But in worldboss, ghost means not wipe. So do not wipe.
			wipe = 0
		elseif bossuIdFound and LastInstanceType == "raid" then -- Combat started by IEEU and no boss exist and no EncounterProgress marked, that means wipe
			wipe = 2
			for i = 1, 10 do
				if UnitExists("boss" .. i) then
					wipe = 0 -- Boss found. No wipe
					break
				end
			end
		else -- Unit combat status detection. No combat unit in your party and no EncounterProgress marked, that means wipe
			wipe = 1
			local uId = (IsInRaid() and "raid") or "party"
			for i = 0, GetNumGroupMembers() do
				local id = (i == 0 and "player") or uId .. i
				if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
					wipe = 0 -- Someone still in combat. No wipe
					break
				end
			end
		end
		if wipe == 0 then
			lastValidCombat = GetTime()--Time stamp last valid in combat
			self:Schedule(3, checkWipe, self)
		elseif confirm then
			local timeSinceValid = GetTime() - lastValidCombat
			if timeSinceValid > confirmTime then
				for i = #inCombat, 1, -1 do
					local mod = inCombat[i]
					if not mod.noStatistics then
						self:Debug("You wiped. Reason : " .. (wipe == 1 and "No combat unit found in your party." or "No boss found : " .. (wipe or "nil")))
					end
					self:EndCombat(mod, true, nil, "checkWipe")
				end
			else--Have not reached required out of combat time yet, check again every 3 seconds until we do
				self:Schedule(3, checkWipe, self, true, confirmTime)
			end
		else
			local maxDelayTime = (savedDifficulty == "worldboss" and 15) or 5 --wait 10s more on worldboss do actual wipe.
			for _, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			self:Schedule(3, checkWipe, self, true, maxDelayTime)
		end
	end
end

function checkBossHealth(self, mod)
	if #inCombat > 0 then
		for _, v in ipairs(inCombat) do
			if not v.multiMobPullDetection or v.mainBoss then
				self:GetBossHP(v.mainBoss or v.combatInfo.mob or -1, mod.onlyHighest)
			else
				for _, mob in ipairs(v.multiMobPullDetection) do
					self:GetBossHP(mob, mod.onlyHighest)
				end
			end
		end
		self:Schedule(mod.bossHealthUpdateTime or 1, checkBossHealth, self, mod)
	end
end

function checkCustomBossHealth(self, mod)
	mod:CustomHealthUpdate()
	self:Schedule(mod.bossHealthUpdateTime or 1, checkCustomBossHealth, self, mod)
end

do
	local tooltipsHidden = false
	--Delayed Guild Combat sync object so we allow time for RL to disable them
	local function delayedGCSync(modId, difficultyIndex, difficultyModifier, name, thisTime, wipeHP)
		if not dbmIsEnabled then return end
		if not private.statusGuildDisabled and updateNotificationDisplayed == 0 then
			if thisTime then--Wipe event
				if wipeHP then
					sendGuildSync(8, "GCE", modId .. "\t1\t" .. thisTime .. "\t" .. difficultyIndex .. "\t" .. difficultyModifier .. "\t" .. name .. "\t" .. lastGroupLeader .. "\t" .. wipeHP)
				else
					sendGuildSync(8, "GCE", modId .. "\t0\t" .. thisTime .. "\t" .. difficultyIndex .. "\t" .. difficultyModifier .. "\t" .. name .. "\t" .. lastGroupLeader)
				end
			else
				sendGuildSync(4, "GCB", modId .. "\t" .. difficultyIndex .. "\t" .. difficultyModifier .. "\t" .. name .. "\t" .. lastGroupLeader)
			end
		end
	end

	local statVarTable = {
		--Current
		["event5"] = "normal",
		["event20"] = "lfr25",
		["event40"] = "lfr25",
		["follower"] = "follower",
		["normal5"] = "normal",
		["heroic5"] = "heroic",
		["challenge5"] = "challenge",
		["lfr"] = "lfr25",
		["normal"] = "normal",
		["heroic"] = "heroic",
		["mythic"] = "mythic",
		["mythic5"] = "mythic",
		["worldboss"] = "normal",
		["timewalker"] = "timewalker",
		["progressivechallenges"] = "normal",
		["delve1"] = "normal",
		--BFA
		["normalwarfront"] = "normal",
		["heroicwarfront"] = "heroic",
		["normalisland"] = "normal",
		["heroicisland"] = "heroic",
		["mythicisland"] = "mythic",
		["teamingisland"] = "mythic",--Blizz uses mythic as fallback, so I will too
		--Shadowlands
		["couragescenario"] = "normal",--Map PoA scenaris to different stats for each difficulty
		["loyaltyscenario"] = "heroic",
		["wisdomscenario"] = "mythic",
		["humilityscenario"] = "challenge",
		--Legacy
		["lfr25"] = "lfr25",
		["normal10"] = "normal",
		["normal20"] = "normal",
		["normal25"] = "normal25",--Legacy raids that have two normal difficulties still (10/25)
		["normal40"] = "normal",
		["heroic10"] = "heroic",
		["heroic25"] = "heroic25",--Legacy raids that have two heroic difficulties still (10/25)
		["normalscenario"] = "normal",
		["heroicscenario"] = "heroic",
	}

	function DBM:StartCombat(mod, delay, event, synced, syncedStartHp, syncedEvent)
		cSyncSender = {}
		cSyncReceived = 0
		if not checkEntry(inCombat, mod) then
			if not mod.Options.Enabled then return end
			if not mod.combatInfo then return end
			if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
				return
			end
			--HACK: makes sure that we don't detect a false pull if the event fires again when the boss dies...
			if mod.lastKillTime and GetTime() - mod.lastKillTime < (mod.reCombatTime or 120) and event ~= "LOADING_SCREEN_DISABLED" then return end
			if mod.lastWipeTime and GetTime() - mod.lastWipeTime < (event == "ENCOUNTER_START" and 3 or mod.reCombatTime2 or 20) and event ~= "LOADING_SCREEN_DISABLED" then return end
			if event then
				self:Debug("StartCombat called by : " .. event .. ". LastInstanceMapID is " .. LastInstanceMapID)
				if event ~= "ENCOUNTER_START" then
					self:Debug("This event is started by" .. event .. ". Review ENCOUNTER_START event to ensure if this is still needed", 2)
				end
			else
				self:Debug("StartCombat called by individual mod or unknown reason. LastInstanceMapID is " .. LastInstanceMapID)
				event = ""
			end
			--check completed. starting combat
			tinsert(inCombat, mod)
			-- Pull time is always considered as in combat, this makes sure checkWipe() triggers only after the minimum time without combat has passed since start.
			lastValidCombat = GetTime()
			if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
			end
			--Fix for "attempt to perform arithmetic on field 'stats' (a nil value)"
			if not mod.stats and not mod.noStatistics then
				self:AddMsg(L.BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
				mod.ignoreBestkill = true--Force this to true so we don't check any more occurances of "stats"
			elseif event == "TIMER_RECOVERY" then --add a lag time to delay when TIMER_RECOVERY
				delay = delay + select(4, GetNetStats()) / 1000
			end
			--set mod default info
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
			local name = mod.combatInfo.name
			local modId = mod.id
			if isRetail then
				if mod.addon.type == "SCENARIO" and C_Scenario.IsInScenario() and not mod.soloChallenge then
					mod.inScenario = true
				end
			end
			mod.engagedDiff = savedDifficulty
			mod.engagedDiffText = difficultyText
			mod.engagedDiffIndex = difficultyIndex
			mod.inCombat = true
			mod.combatInfo.pull = GetTime() - (delay or 0)
			bossuIdFound = event == "IEEU"
			if mod.minCombatTime then
				self:Schedule(mmax((mod.minCombatTime - delay), 3), checkWipe, self)
			else
				self:Schedule(3, checkWipe, self)
			end
			--get boss hp at pull
			if syncedStartHp and syncedStartHp < 1 then
				syncedStartHp = syncedStartHp * 100
			end
			local startHp = syncedStartHp or mod:GetBossHP(mod.mainBoss or mod.combatInfo.mob or -1) or 100
			--check boss engaged first?
			if (savedDifficulty == "worldboss" and startHp < 98) or (event == "UNIT_HEALTH" and delay > 4) or event == "TIMER_RECOVERY" then--Boss was not full health when engaged, disable combat start timer and kill record
				mod.ignoreBestkill = true
			elseif mod.inScenario then
				local _, currentStage, numStages = C_Scenario.GetInfo()
				if currentStage > 1 and numStages > 1 then
					mod.ignoreBestkill = true
				end
			else--Reset ignoreBestkill after wipe
				mod.ignoreBestkill = false
				--It was a clean pull, so cancel any RequestTimers which might fire after boss was pulled if boss was pulled right after mod load
				--Only want timer recovery on in progress bosses, not clean pulls
				if startHp > 98 and (savedDifficulty == "worldboss" or event == "IEEU") or event == "ENCOUNTER_START" then
					self:Unschedule(self.RequestTimers)
				end
			end
			if not mod.inScenario then
				if self.Options.HideTooltips then
					--Better or cleaner way?
					tooltipsHidden = true
					GameTooltip.Temphide = function() GameTooltip:Hide() end; GameTooltip:SetScript("OnShow", GameTooltip.Temphide)
				end
				if self.Options.DisableSFX and GetCVar("Sound_EnableSFX") == "1" then
					SetCVar("Sound_EnableSFX", 0)
					self.Options.RestoreSettingSFX = true
				end
				if self.Options.DisableAmbiance and GetCVar("Sound_EnableAmbience") == "1" then
					SetCVar("Sound_EnableAmbience", 0)
					self.Options.RestoreSettingAmbiance = true
				end
				if self.Options.DisableMusic and GetCVar("Sound_EnableMusic") == "1" then
					SetCVar("Sound_EnableMusic", 0)
					self.Options.RestoreSettingMusic = true
				end
				--boss health info scheduler
				if mod.CustomHealthUpdate then
					self:Schedule(mod.bossHealthUpdateTime or 1, checkCustomBossHealth, self, mod)
				else
					self:Schedule(mod.bossHealthUpdateTime or 1, checkBossHealth, self, mod)
				end
			end
			--process global options
			self:HideBlizzardEvents(1)
			if self.Options.RecordOnlyBosses then
				self:StartLogging(0)
			end
			local trackedAchievements
			if isClassic or isBCC then
				trackedAchievements = false
			elseif isWrath or isCata then
				trackedAchievements = (GetNumTrackedAchievements() > 0)
			else
				trackedAchievements = (C_ContentTracking and C_ContentTracking.GetTrackedIDs(2)[1])
			end
			if self.Options.HideObjectivesFrame and mod.addon.type ~= "SCENARIO" and not trackedAchievements and difficultyIndex ~= 8 and not InCombatLockdown() then
				if isRetail then--Do nothing due to taint and breaking
					--if ObjectiveTrackerFrame:IsVisible() then
					--	ObjectiveTracker_Collapse()
					--	watchFrameRestore = true
					--end
				else
					if WatchFrame then
						if WatchFrame:IsVisible() then
							WatchFrame:Hide()
							watchFrameRestore = true
						end
					elseif QuestWatchFrame:IsVisible() then -- Classic Era / BCC
						QuestWatchFrame:Hide()
						watchFrameRestore = true
					end
					local QuestieLoader = _G["QuestieLoader"]
					if QuestieLoader then
						local QuestieTracker = _G["QuestieTracker"] or QuestieLoader:ImportModule("QuestieTracker")--Might be a global in some versions, but not a global in others
						local Questie = _G["Questie"] or QuestieLoader:ImportModule("Questie")
						if QuestieTracker and Questie and Questie.db.global.trackerEnabled and QuestieTracker.Disable then
							--Will only hide questie tracker if it's not already hidden.
							QuestieTracker:Disable()
							questieWatchRestore = true
						end
					end
				end
			end
			fireEvent("DBM_Pull", mod, delay, synced, startHp)
			self:FlashClientIcon()
			--serperate timer recovery and normal start.
			if event ~= "TIMER_RECOVERY" then
				--add pull count
				if mod.stats and not mod.noStatistics then
					if not mod.stats[statVarTable[savedDifficulty] .. "Pulls"] then mod.stats[statVarTable[savedDifficulty] .. "Pulls"] = 0 end
					mod.stats[statVarTable[savedDifficulty] .. "Pulls"] = mod.stats[statVarTable[savedDifficulty] .. "Pulls"] + 1
				end
				--show speed timer
				if self.Options.AlwaysShowSpeedKillTimer2 and mod.stats and not mod.ignoreBestkill and not mod.noStatistics then
					local bestTime
					if difficultyIndex == 8 then--Mythic+/Challenge Mode
						local bestMPRank = mod.stats.challengeBestRank or 0
						if bestMPRank == difficultyModifier then
							--Don't show speed kill timer if not our highest rank. DBM only stores highest rank
							bestTime = mod.stats[statVarTable[savedDifficulty] .. "BestTime"]
						end
					else
						bestTime = mod.stats[statVarTable[savedDifficulty] .. "BestTime"]
					end
					if bestTime and bestTime > 0 then
						local speedTimer = mod:NewTimer(bestTime, L.SPEED_KILL_TIMER_TEXT, isRetail and "237538" or "136106", nil, false)
						speedTimer:Start()
					end
				end
				--update boss left
				if mod.numBoss then
					mod.vb.bossLeft = mod.numBoss
				end
				--Update Elected Icon Setter
				self:ElectIconSetter(mod)
				--call OnCombatStart
				if mod.OnCombatStart then
					local startEvent = syncedEvent or event
					mod:OnCombatStart(delay or 0, startEvent == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or startEvent == "SPELL_CAST_SUCCESS" or startEvent == "MONSTER_MESSAGE", startEvent == "ENCOUNTER_START")
				end
				--send "C" sync
				if not synced and not mod.soloChallenge then
					sendSync(DBMSyncProtocol, "C", (delay or 0) .. "\t" .. modId .. "\t" .. (mod.revision or 0) .. "\t" .. startHp .. "\t" .. tostring(self.Revision) .. "\t" .. (mod.hotfixNoticeRev or 0) .. "\t" .. event)
				end
				if UnitIsGroupLeader("player") then
					--Global disables require normal, heroic, mythic raid on retail, or 10 man normal, 25 man normal, 40 man normal, 10 man heroic, or 25 man heroic on classic
					if difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16 or difficultyIndex == 175 or difficultyIndex == 176 or difficultyIndex == 186 or difficultyIndex == 193 or difficultyIndex == 194 then
						local statusWhisper, guildStatus, raidIcons, chatBubbles = self.Options.DisableStatusWhisper and 1 or 0, self.Options.DisableGuildStatus and 1 or 0, self.Options.DisableRaidIcons and 1 or 0, self.Options.DisableChatBubbles and 1 or 0
						if statusWhisper ~= 0 or guildStatus ~= 0 or raidIcons ~= 0 or chatBubbles ~= 0 then
							sendSync(2, "RLO", statusWhisper .. "\t" .. guildStatus .. "\t" .. raidIcons .. "\t" .. chatBubbles)
						end
					end
				end
				if self.Options.oRA3AnnounceConsumables and _G["oRA3Frame"] then
					local oRA3 = LibStub and LibStub("AceAddon-3.0"):GetAddon("oRA3", true)
					if oRA3 then
						local consumables = oRA3:GetModule("Consumables", true)
						if consumables then
							---@diagnostic disable-next-line: undefined-field
							consumables:OutputResults()
						end
					end
				end
				--show engage message
				if self.Options.ShowEngageMessage and not mod.noStatistics then
					if mod.ignoreBestkill and (savedDifficulty == "worldboss") then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
						self:AddMsg(L.COMBAT_STARTED_IN_PROGRESS:format(difficultyText .. name))
					elseif mod.ignoreBestkill and mod.inScenario then
						self:AddMsg(L.SCENARIO_STARTED_IN_PROGRESS:format(difficultyText .. name))
					else
						if mod.addon.type == "SCENARIO" then
							self:AddMsg(L.SCENARIO_STARTED:format(difficultyText .. name))
						else
							self:AddMsg(L.COMBAT_STARTED:format(difficultyText .. name))
							local check = not private.statusGuildDisabled and (isRetail and ((difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty()) or difficultyIndex ~= 1 and DBM:GetNumGuildPlayersInZone() >= 10)
							if check and not self.Options.DisableGuildStatus then--Only send relevant content, not guild beating down lich king or LFR.
								self:Unschedule(delayedGCSync, modId)
								self:Schedule(isRetail and 1.5 or 3, delayedGCSync, modId, difficultyIndex, difficultyModifier, name)
							end
						end
					end
				end
				--stop pull count
				local dummyMod = self:GetModByName("PullTimerCountdownDummy")
				if dummyMod then--stop pull timer
					dummyMod.text:Cancel()
					dummyMod.timer:Stop()
					if not self.Options.DontShowPTCountdownText and TimerTracker then
						for _, tttimer in pairs(TimerTracker.timerList) do
							if tttimer.type == 3 and not tttimer.isFree then
								FreeTimerTrackerTimer(tttimer)
								break
							end
						end
					end
				end
				local bigWigs = _G["BigWigs"]
				if bigWigs and bigWigs.db.profile.raidicon and not self.Options.DontSetIcons and self:GetRaidRank() > 0 then--Both DBM and bigwigs have raid icon marking turned on.
					self:AddMsg(L.BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either or turned off to stop this alert)
				end
				if self.Options.EventSoundEngage2 and self.Options.EventSoundEngage2 ~= "" and self.Options.EventSoundEngage2 ~= "None" then
					self:PlaySoundFile(self.Options.EventSoundEngage2, nil, true)
				end
				if self.Options.EventSoundMusic and self.Options.EventSoundMusic ~= "None" and self.Options.EventSoundMusic ~= "" and not (self.Options.EventMusicMythicFilter and (savedDifficulty == "mythic" or savedDifficulty == "challenge")) and not mod.noStatistics and not self.Options.RestoreSettingMusic then
					fireEvent("DBM_MusicStart", "BossEncounter")
					if not self.Options.RestoreSettingCustomMusic then
						self.Options.RestoreSettingCustomMusic = tonumber(GetCVar("Sound_EnableMusic")) or 1
						if self.Options.RestoreSettingCustomMusic == 0 then
							SetCVar("Sound_EnableMusic", 1)
						else
							self.Options.RestoreSettingCustomMusic = nil--Don't actually need it
						end
					end
					local path = "MISSING"
					if self.Options.EventSoundMusic == "Random" then
						local usedTable = self.Options.EventSoundMusicCombined and self:GetMusic() or mod.inScenario and self:GetDungeonMusic() or self:GetBattleMusic()
						if #usedTable >= 3 then
							local random = fastrandom(3, #usedTable)
							path = usedTable[random].value
						end
					else
						path = self.Options.EventSoundMusic
					end
					if path ~= "MISSING" then
						PlayMusic(path)
						self.Options.musicPlaying = true
						self:Debug("Starting combat music with file: " .. path)
					end
				end
			else
				self:AddMsg(L.COMBAT_STATE_RECOVERED:format(difficultyText .. name, strFromTime(delay)))
				if mod.OnTimerRecovery then
					mod:OnTimerRecovery()
				end
			end
			if savedDifficulty == "worldboss" and mod.WBEsync then
				if lastBossEngage[modId .. normalizedPlayerRealm] and (GetTime() - lastBossEngage[modId .. normalizedPlayerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
				lastBossEngage[modId .. normalizedPlayerRealm] = GetTime()--Update last engage time, that way we ignore our own sync
				SendWorldSync(self, 8, "WBE", modId .. "\t" .. normalizedPlayerRealm .. "\t" .. startHp .. "\t" .. name)
			end
		end
	end

	function DBM:UNIT_HEALTH(uId)
		local cId = self:GetCIDFromGUID(UnitGUID(uId))
		local health
		if UnitHealthMax(uId) ~= 0 then
			health = UnitHealth(uId) / UnitHealthMax(uId) * 100
		end
		if not health or health < 2 then return end -- no worthy of combat start if health is below 2%
		if dbmIsEnabled and InCombatLockdown() then
			if cId ~= 0 and not bossHealth[cId] and bossIds[cId] and UnitAffectingCombat(uId) and not (UnitPlayerOrPetInRaid(uId) or UnitPlayerOrPetInParty(uId)) and healthCombatInitialized then -- StartCombat by UNIT_HEALTH.
				if combatInfo[LastInstanceMapID] then
					for _, v in ipairs(combatInfo[LastInstanceMapID]) do
						if v.mod.Options.Enabled and not v.mod.disableHealthCombat and v.type:find("combat") and (v.multiMobPullDetection and checkEntry(v.multiMobPullDetection, cId) or v.mob == cId) and not (#inCombat > 0 and v.noMultiBoss) then
							if v.mod.noFriendlyEngagement and UnitIsFriend("player", uId) then return end
							-- Delay set, > 97% = 0.5 (consider as normal pulling), max dealy limited to 20s.
							self:StartCombat(v.mod, health > 97 and 0.5 or mmin(GetTime() - lastCombatStarted, 20), "UNIT_HEALTH", nil, health)
						end
					end
				end
			end
			if self.Options.AFKHealthWarning2 and UnitIsUnit(uId, "player") and (health < (isHardcoreServer and 95 or 85)) and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
				local voice = DBM.Options.ChosenVoicePack2
				local path = 546633--"Sound\\Creature\\CThun\\CThunYouWillDIe.ogg"
				if not voiceSessionDisabled and voice ~= "None" then
					path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
				end
				self:PlaySoundFile(path)
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		end
	end
	DBM.UNIT_HEALTH_FREQUENT = DBM.UNIT_HEALTH

	function DBM:EndCombat(mod, wipe, srmIncluded, event)
		if removeEntry(inCombat, mod) then
			local scenario = mod.addon.type == "SCENARIO" and not mod.soloChallenge
			if mod.inCombatOnlyEvents and mod.inCombatOnlyEventsRegistered then
				if srmIncluded then-- unregister all events including SPELL_AURA_REMOVED events
					mod:UnregisterInCombatEvents(false, true)
				else-- unregister all events except for SPELL_AURA_REMOVED events (might still be needed to remove icons etc...)
					mod:UnregisterInCombatEvents()
					self:Schedule(2, mod.UnregisterInCombatEvents, mod, true) -- 2 seconds should be enough for all auras to fade
				end
				self:Schedule(3, mod.Stop, mod) -- Remove accident started timers.
				mod.inCombatOnlyEventsRegistered = nil
				if mod.OnCombatEnd then
					self:Schedule(3, mod.OnCombatEnd, mod, wipe, true) -- Remove accidentally shown frames
				end
			end
			if mod.updateInterval then
				mod:UnregisterOnUpdateHandler()
			end
			mod:Stop()
			if mod.paSounds then
				mod:DisablePrivateAuraSounds()
			end
			if event then
				self:Debug("EndCombat called by : " .. event .. ". LastInstanceMapID is " .. LastInstanceMapID)
			end
			if private.enableIcons and not self.Options.DontSetIcons and not self.Options.DontRestoreIcons then
				-- restore saved previous icon
				for uId, icon in pairs(mod.iconRestore) do
					SetRaidTarget(uId, icon)
				end
				twipe(mod.iconRestore)
			end
			mod.inCombat = false
			if mod.combatInfo.killMobs then
				for i, _ in pairs(mod.combatInfo.killMobs) do
					mod.combatInfo.killMobs[i] = true
				end
			end
			if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			--Fix stupid classic behavior where wipes only happen after release which causes all the instance difficulty info to be wrong
			--This uses stored values from engage first, and only current values as fallback
			local usedDifficulty = mod.engagedDiff or savedDifficulty
			local usedDifficultyText = mod.engagedDiffText or difficultyText
			local usedDifficultyIndex = mod.engagedDiffIndex or difficultyIndex
			local name = mod.combatInfo.name
			local modId = mod.id
			if wipe and mod.stats and not mod.noStatistics then
				mod.lastWipeTime = GetTime()
				--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
				local thisTime = GetTime() - mod.combatInfo.pull
				local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
				local wipeHP = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
				if mod.vb.phase then
					wipeHP = wipeHP .. " (" .. SCENARIO_STAGE:format(mod.vb.phase) .. ")"
				end
				if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
					local bossesKilled = mod.numBoss - mod.vb.bossLeft
					wipeHP = wipeHP .. " (" .. BOSSES_KILLED:format(bossesKilled, mod.numBoss) .. ")"
				end
				local totalPulls = mod.stats[statVarTable[usedDifficulty] .. "Pulls"]
				local totalKills = mod.stats[statVarTable[usedDifficulty] .. "Kills"]
				if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
					totalPulls = totalPulls - 1
					mod.stats[statVarTable[usedDifficulty] .. "Pulls"] = totalPulls
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT:format(usedDifficultyText .. name, strFromTime(thisTime)))
						else
							self:AddMsg(L.COMBAT_ENDED_AT:format(usedDifficultyText .. name, wipeHP, strFromTime(thisTime)))
							--No reason to GCE it here, so omited on purpose.
						end
					end
				else
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT_LONG:format(usedDifficultyText .. name, strFromTime(thisTime), totalPulls - totalKills))
						else
							self:AddMsg(L.COMBAT_ENDED_AT_LONG:format(usedDifficultyText .. name, wipeHP, strFromTime(thisTime), totalPulls - totalKills))
							local check = isRetail and
								((usedDifficultyIndex == 8 or usedDifficultyIndex == 14 or usedDifficultyIndex == 15 or usedDifficultyIndex == 16) and InGuildParty()) or
								usedDifficultyIndex ~= 1 and DBM:GetNumGuildPlayersInZone() >= 10 -- Classic
							if check and not self.Options.DisableGuildStatus then
								self:Unschedule(delayedGCSync, modId)
								self:Schedule(isRetail and 1.5 or 3, delayedGCSync, modId, usedDifficultyIndex, difficultyModifier, name, strFromTime(thisTime), wipeHP)
							end
						end
					end
					if self.Options.EventSoundWipe and self.Options.EventSoundWipe ~= "None" and self.Options.EventSoundWipe ~= "" then
						if self.Options.EventSoundWipe == "Random" then
							local defeatSounds = DBM:GetDefeatSounds()
							if #defeatSounds >= 3 then
								self:PlaySoundFile(defeatSounds[fastrandom(3, #defeatSounds)].value)
							end
						else
							self:PlaySoundFile(self.Options.EventSoundWipe, nil, true)
						end
					end
				end
				if showConstantReminder == 2 and IsInGroup() then
					showConstantReminder = 1
					--Show message any time this is a mod that has a newer hotfix revision and it's a wipe
					--These people need to know the wipe could very well be their fault.
					self:AddMsg(L.OUT_OF_DATE_NAG)
				end
				local msg
				for k, _ in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or chatPrefixShort .. L.WHISPER_SCENARIO_END_WIPE_STATS:format(playerName, usedDifficultyText .. (name or ""), totalPulls - totalKills)
						else
							msg = msg or chatPrefixShort .. L.WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, usedDifficultyText .. (name or ""), wipeHP, totalPulls - totalKills)
						end
					else
						if scenario then
							msg = msg or chatPrefixShort .. L.WHISPER_SCENARIO_END_WIPE:format(playerName, usedDifficultyText .. (name or ""))
						else
							msg = msg or chatPrefixShort .. L.WHISPER_COMBAT_END_WIPE_AT:format(playerName, usedDifficultyText .. (name or ""), wipeHP)
						end
					end
					sendWhisper(k, msg)
				end
				fireEvent("DBM_Wipe", mod)
			elseif not wipe and mod.stats and not mod.noStatistics then
				mod.lastKillTime = GetTime()
				local thisTime = GetTime() - (mod.combatInfo.pull or 0)
				local lastTime = mod.stats[statVarTable[usedDifficulty] .. "LastTime"]
				local bestTime = mod.stats[statVarTable[usedDifficulty] .. "BestTime"]
				if not mod.stats[statVarTable[usedDifficulty] .. "Kills"] or mod.stats[statVarTable[usedDifficulty] .. "Kills"] < 0 then mod.stats[statVarTable[usedDifficulty] .. "Kills"] = 0 end
				--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats[statVarTable[usedDifficulty] .. "Kills"] = mod.stats[statVarTable[usedDifficulty] .. "Kills"] + 1
				if mod.stats[statVarTable[usedDifficulty] .. "Kills"] > mod.stats[statVarTable[usedDifficulty] .. "Pulls"] then mod.stats[statVarTable[usedDifficulty] .. "Kills"] = mod.stats[statVarTable[usedDifficulty] .. "Pulls"] end
				if not mod.ignoreBestkill and mod.combatInfo.pull then
					mod.stats[statVarTable[usedDifficulty] .. "LastTime"] = thisTime
					--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
					if bestTime and bestTime > 0 and bestTime < 1.5 then
						mod.stats[statVarTable[usedDifficulty] .. "BestTime"] = thisTime
					else
						if usedDifficultyIndex == 8 then--Mythic+/Challenge Mode
							if mod.stats.challengeBestRank > difficultyModifier then--Don't save time stats at all
								--DO nothing
							elseif mod.stats.challengeBestRank < difficultyModifier then--Update best time and best rank, even if best time is lower (for a lower rank)
								mod.stats.challengeBestRank = difficultyModifier--Update best rank
								mod.stats[statVarTable[usedDifficulty] .. "BestTime"] = thisTime--Write this time no matter what.
							else--Best rank must match current rank, so update time normally
								mod.stats[statVarTable[usedDifficulty] .. "BestTime"] = mmin(bestTime or mhuge, thisTime)
							end
						else
							mod.stats[statVarTable[usedDifficulty] .. "BestTime"] = mmin(bestTime or mhuge, thisTime)
						end
					end
				end
				local totalKills = mod.stats[statVarTable[usedDifficulty] .. "Kills"]
				if self.Options.ShowDefeatMessage then
					local msg
					local thisTimeString = thisTime and strFromTime(thisTime)
					if not mod.combatInfo.pull then--was a bad pull so we ignored thisTime, should never happen
						if scenario then
							msg = L.SCENARIO_COMPLETE:format(usedDifficultyText .. name, CL.UNKNOWN)
						else
							msg = L.BOSS_DOWN:format(usedDifficultyText .. name, CL.UNKNOWN)
						end
					elseif mod.ignoreBestkill then--Should never happen in a scenario so no need for scenario check.
						if scenario then
							msg = L.SCENARIO_COMPLETE_I:format(usedDifficultyText .. name, totalKills)
						else
							msg = L.BOSS_DOWN_I:format(usedDifficultyText .. name, totalKills)
						end
					elseif not lastTime then
						if scenario then
							msg = L.SCENARIO_COMPLETE:format(usedDifficultyText .. name, thisTimeString)
						else
							msg = L.BOSS_DOWN:format(usedDifficultyText .. name, thisTimeString)
						end
					elseif thisTime < (bestTime or mhuge) then
						if scenario then
							msg = L.SCENARIO_COMPLETE_NR:format(usedDifficultyText .. name, thisTimeString, strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_NR:format(usedDifficultyText .. name, thisTimeString, strFromTime(bestTime), totalKills)
						end
					else
						if scenario then
							msg = L.SCENARIO_COMPLETE_L:format(usedDifficultyText .. name, thisTimeString, strFromTime(lastTime), strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_L:format(usedDifficultyText .. name, thisTimeString, strFromTime(lastTime), strFromTime(bestTime), totalKills)
						end
					end
					local check = not private.statusGuildDisabled and (isRetail and ((usedDifficultyIndex == 8 or usedDifficultyIndex == 14 or usedDifficultyIndex == 15 or usedDifficultyIndex == 16) and InGuildParty()) or usedDifficultyIndex ~= 1 and DBM:GetNumGuildPlayersInZone() >= 10) -- Classic
					if not scenario and thisTimeString and check and not self.Options.DisableGuildStatus and updateNotificationDisplayed == 0 then
						self:Unschedule(delayedGCSync, modId)
						self:Schedule(isRetail and 1.5 or 3, delayedGCSync, modId, usedDifficultyIndex, difficultyModifier, name, thisTimeString)
					end
					self:Schedule(1, self.AddMsg, self, msg)
				end
				local msg
				for k, _ in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or chatPrefixShort .. L.WHISPER_SCENARIO_END_KILL_STATS:format(playerName, usedDifficultyText .. (name or ""), totalKills)
						else
							msg = msg or chatPrefixShort .. L.WHISPER_COMBAT_END_KILL_STATS:format(playerName, usedDifficultyText .. (name or ""), totalKills)
						end
					else
						if scenario then
							msg = msg or chatPrefixShort .. L.WHISPER_SCENARIO_END_KILL:format(playerName, usedDifficultyText .. (name or ""))
						else
							msg = msg or chatPrefixShort .. L.WHISPER_COMBAT_END_KILL:format(playerName, usedDifficultyText .. (name or ""))
						end
					end
					sendWhisper(k, msg)
				end
				fireEvent("DBM_Kill", mod)
				if usedDifficulty == "worldboss" and mod.WBEsync then
					if lastBossDefeat[modId .. normalizedPlayerRealm] and (GetTime() - lastBossDefeat[modId .. normalizedPlayerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
					lastBossDefeat[modId .. normalizedPlayerRealm] = GetTime()--Update last defeat time before we send it, so we don't handle our own sync
					SendWorldSync(self, 8, "WBD", modId .. "\t" .. normalizedPlayerRealm .. "\t" .. name)
				end
				if self.Options.EventSoundVictory2 and self.Options.EventSoundVictory2 ~= "None" and self.Options.EventSoundVictory2 ~= "" then
					if self.Options.EventSoundVictory2 == "Random" then
						local victorySounds = DBM:GetVictorySounds()
						if #victorySounds >= 3 then
							self:PlaySoundFile(victorySounds[fastrandom(3, #victorySounds)].value)
						end
					else
						self:PlaySoundFile(self.Options.EventSoundVictory2, nil, true)
					end
				end
			end
			if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
			if mod.OnLeavingCombat then delayedFunction = mod.OnLeavingCombat end
			mod.engagedDiff = nil
			mod.engagedDiffText = nil
			mod.engagedDiffIndex = nil
			mod.vb.stageTotality = nil
			if #inCombat == 0 then--prevent error if you pulled multiple boss. (Earth, Wind and Fire)
				private.statusGuildDisabled, private.statusWhisperDisabled, private.raidIconsDisabled, private.chatBubblesDisabled = false, false, false, false
				if self.Options.RecordOnlyBosses then
					self:Schedule(10, self.StopLogging, self)--small delay to catch kill/died combatlog events
				end
				self:HideBlizzardEvents(0)
				self:Unschedule(checkBossHealth)
				self:Unschedule(checkCustomBossHealth)
				self.Arrow:Hide()
				if not InCombatLockdown() then
					if watchFrameRestore then
						if isRetail then
							--ObjectiveTracker_Expand()
						elseif isCata or isWrath then
							WatchFrame:Show()
						else -- Classic Era / BCC
							QuestWatchFrame:Show()
						end
						watchFrameRestore = false
					end
					local QuestieLoader = _G["QuestieLoader"]
					if QuestieLoader then
						local QuestieTracker = _G["QuestieTracker"] or QuestieLoader:ImportModule("QuestieTracker")--Might be a global in some versions, but not a global in others
						if QuestieTracker and questieWatchRestore and QuestieTracker.Enable then
							QuestieTracker:Enable()
							questieWatchRestore = false
						end
					end
				end
				if tooltipsHidden then
					--Better or cleaner way?
					tooltipsHidden = false
					GameTooltip:SetScript("OnShow", GameTooltip.Show)
				end
				if self.Options.RestoreSettingSFX then
					SetCVar("Sound_EnableSFX", 1)
					self.Options.RestoreSettingSFX = nil
				end
				if self.Options.RestoreSettingAmbiance then
					SetCVar("Sound_EnableAmbience", 1)
					self.Options.RestoreSettingAmbiance = nil
				end
				if self.Options.RestoreSettingMusic then
					SetCVar("Sound_EnableMusic", 1)
					self.Options.RestoreSettingMusic = nil
				end
				--cache table
				twipe(autoRespondSpam)
				twipe(bossHealth)
				twipe(bossHealthuIdCache)
				--sync table
				twipe(private.canSetIcons)
				twipe(iconSetRevision)
				twipe(iconSetPerson)
				bossuIdFound = false
				eeSyncSender = {}
				eeSyncReceived = 0
				self:CreatePizzaTimer(time, "", nil, nil, nil, true)--Auto Terminate infinite loop timers on combat end
				self:TransitionToDungeonBGM(false, true)
				self:Schedule(22, self.TransitionToDungeonBGM, self)
				--module cleanup
				private:ClearModuleTasks()
			end
		end
	end
end

function DBM:OnMobKill(cId, synced)
	for i = #inCombat, 1, -1 do
		local v = inCombat[i]
		if not v.combatInfo then
			return
		end
		if v.combatInfo.noBossDeathKill then return end
		if v.combatInfo.killMobs and v.combatInfo.killMobs[cId] then
			if not synced then
				sendSync(DBMSyncProtocol, "K", cId)
			end
			v.combatInfo.killMobs[cId] = false
			if v.numBoss and (v.vb.bossLeft or 0) > 0 then
				v.vb.bossLeft = (v.vb.bossLeft or v.numBoss) - 1
				self:Debug("Boss left - " .. v.vb.bossLeft .. "/" .. v.numBoss, 2)
			end
			local allMobsDown = true
			for _, k in pairs(v.combatInfo.killMobs) do
				if k then
					allMobsDown = false
					break
				end
			end
			if allMobsDown and not v.multiIDSingleBoss then--More hacks. don't let combat end for mutli CID single bosses
				self:EndCombat(v, nil, nil, "All Mobs Down")
			end
		elseif cId == v.combatInfo.mob and not v.combatInfo.killMobs and not v.combatInfo.multiMobPullDetection then
			if not synced then
				sendSync(DBMSyncProtocol, "K", cId)
			end
			self:EndCombat(v, nil, nil, "Main CID Down")
		end
	end
end

do
	local autoLog = false
	local autoTLog = false

	local function isLogableContent(self, force)
		--1: Check for any broad global filters like LFG/LFR filter
		--2: Check for what content specifically selected for logging
		--3: Boss Only filter is handled somewhere else (where StartLogging is called)

		if self.Options.DoNotLogLFG and isRetail and IsPartyLFG() then
			return false
		end

		--First checks are manual index checks versus table because even old content can be scaled up using M+ or TW scaling tech
		--Current player level Mythic+
		if self.Options.LogCurrentMPlus and (force or (difficultyIndex or 0) == 8) then
			return true
		end
		--Timewalking or Chromie Time raid
		if self.Options.LogTWRaids and (C_PlayerInfo.IsPlayerInChromieTime and C_PlayerInfo.IsPlayerInChromieTime() or difficultyIndex == 24 or difficultyIndex == 33) and (instanceDifficultyBylevel[LastInstanceMapID] and instanceDifficultyBylevel[LastInstanceMapID][2] == 3) then
			return true
		end
		--Timewalking or Chromie Time Dungeon
		if self.Options.LogTWDungeons and (C_PlayerInfo.IsPlayerInChromieTime and C_PlayerInfo.IsPlayerInChromieTime() or difficultyIndex == 24 or difficultyIndex == 33) and (instanceDifficultyBylevel[LastInstanceMapID] and instanceDifficultyBylevel[LastInstanceMapID][2] == 2) then
			return true
		end

		--Now we do checks relying on pre coded trivial check table
		--Current level Mythic raid
		if self.Options.LogCurrentMythicRaids and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID] and instanceDifficultyBylevel[LastInstanceMapID][2] == 3) and difficultyIndex == 16 then
			return true
		end
		--Current player level non Mythic raid
		if self.Options.LogCurrentRaids and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 3) and difficultyIndex ~= 16 then
			return true
		end
		--Trivial raid (ie one below players level)
		if self.Options.LogTrivialRaids and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] < playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 3) then
			return true
		end
		--Current level Mythic dungeon
		if self.Options.LogCurrentMythicZero and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 2) and difficultyIndex == 23 then
			return true
		end
		--Current level Heroic dungeon
		if self.Options.LogCurrentHeroic and instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 2) and (difficultyIndex == 2 or difficultyIndex == 174) then
			return true
		end

		return false
	end

	function DBM:StartLogging(timer, checkFunc, force)
		self:Unschedule(DBM.StopLogging)
		if isLogableContent(self, force) then
			if self.Options.AutologBosses then
				if not LoggingCombat() then
					autoLog = true
					self:AddMsg("|cffffff00" .. COMBATLOGENABLED .. "|r")
					LoggingCombat(true)
				end
			end
			local transcriptor = _G["Transcriptor"]
			if self.Options.AdvancedAutologBosses and transcriptor then
				if not transcriptor:IsLogging() then
					autoTLog = true
					self:AddMsg("|cffffff00" .. L.TRANSCRIPTOR_LOG_START .. "|r")
					transcriptor:StartLog(1)
				end
			end
			if checkFunc and (autoLog or autoTLog) then
				self:Unschedule(checkFunc)
				self:Schedule(timer + 10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
			end
		end
	end

	function DBM:StopLogging()
		if self.Options.AutologBosses and LoggingCombat() and autoLog then
			autoLog = false
			self:AddMsg("|cffffff00" .. COMBATLOGDISABLED .. "|r")
			LoggingCombat(false)
		end
		local transcriptor = _G["Transcriptor"]
		if self.Options.AdvancedAutologBosses and transcriptor and autoTLog then
			if transcriptor:IsLogging() then
				autoTLog = false
				self:AddMsg("|cffffff00" .. L.TRANSCRIPTOR_LOG_END .. "|r")
				transcriptor:StopLog(1)
			end
		end
	end
end

do
	--In event api fails to pull any data at all, just assign classes to their initial template roles from exiles reach
	local fallbackClassToRole = {
		["MAGE"] = 1449,
		["PALADIN"] = 1451,
		["WARRIOR"] = 1446,
		["DRUID"] = 1447,
		["DEATHKNIGHT"] = 1455,
		["HUNTER"] = 1448,
		["PRIEST"] = 1452,
		["ROGUE"] = 1453,
		["SHAMAN"] = 1444,
		["WARLOCK"] = 1454,
		["MONK"] = 1450,
		["DEMONHUNTER"] = 1456,
		["EVOKER"] = 1465,
	}

	function DBM:SetCurrentSpecInfo()
		if isRetail then
			currentSpecGroup = GetSpecialization() or 1
			if GetSpecializationInfo(currentSpecGroup) then
				currentSpecID, currentSpecName = GetSpecializationInfo(currentSpecGroup)--give temp first spec id for non-specialization char. no one should use dbm with no specialization, below level 10, should not need dbm.
				currentSpecID = tonumber(currentSpecID)
			else
				currentSpecID, currentSpecName = fallbackClassToRole[playerClass], playerClass
			end
		else
			local numTabs = GetNumTalentTabs()
			local highestPointsSpent = 0
			if MAX_TALENT_TABS then
				for i = 1, MAX_TALENT_TABS do
					if i <= numTabs then
						local pointsSpent = isCata and select(5, GetTalentTabInfo(i)) or select(3, GetTalentTabInfo(i))
						if pointsSpent > highestPointsSpent then
							highestPointsSpent = pointsSpent
							currentSpecGroup = i
							currentSpecID = playerClass .. tostring(i)--Associate specID with class name and tabnumber (class is used because spec name is shared in some spots like "holy")
							currentSpecName = currentSpecID
						end
					end
				end
			end
			--If 0 talents are spent, then just set them to first spec to prevent nil errors
			--This should only happen for a level 1 player or someone who's in middle of respecing
			if not currentSpecID then currentSpecID = playerClass .. tostring(1) end
		end
	end
end

--TODO C_IslandsQueue.GetIslandDifficultyInfo(), if 38-40 don't work
function DBM:GetCurrentInstanceDifficulty()
	local _, instanceType, difficulty, difficultyName, _, _, _, _, instanceGroupSize = GetInstanceInfo()
	if difficulty == 0 or difficulty == 172 or (difficulty == 1 and instanceType == "none") or (C_Garrison and C_Garrison:IsOnGarrisonMap()) then--draenor field returns 1, causing world boss mod bug.
		return "worldboss", RAID_INFO_WORLD_BOSS .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 1 or difficulty == 173 or difficulty == 184 or difficulty == 150 or difficulty == 201 then--5 man Normal Dungeon / 201 is SoD 5 man ID for a dungeon that's also a 10 man SoD Raid
		return "normal5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 2 or difficulty == 174 then--5 man Heroic Dungeon
		return "heroic5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 3 or difficulty == 175 or difficulty == 198 then--Legacy 10 man Normal Raid/SoD 10 man raid
		return "normal10", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 4 or difficulty == 176 then--Legacy 25 man Normal Raid
		return "normal25", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 5 or difficulty == 193 then--Legacy 10 man Heroic Raid
		return "heroic10", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 6 or difficulty == 194 then--Legacy 25 man Heroic Raid
		return "heroic25", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 7 then--Legacy 25 man LFR (ie pre WoD zones)
		return "lfr25", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 8 then--Dungeon, Mythic+ (Challenge modes in mists and wod)
		local keystoneLevel = C_ChallengeMode and C_ChallengeMode.GetActiveKeystoneInfo() or 0
		return "challenge5", PLAYER_DIFFICULTY6 .. "+ (" .. keystoneLevel .. ") - ", difficulty, instanceGroupSize, keystoneLevel
	elseif difficulty == 9 or difficulty == 186 then--Legacy 40 man raids, no longer returned as index 3 (normal 10man raids)
		return "normal40", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 11 then--Heroic Scenario (mostly Mists of pandaria)
		return "heroicscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 12 or difficulty == 152 then--Normal Scenario (mostly Mists of pandaria and Visions of Nzoth scenarios)
		return "normalscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 14 then--Flexible Normal Raid
		return "normal", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 15 then--Flexible Heroic Raid
		return "heroic", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 16 then--Mythic 20 man Raid
		return "mythic", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 17 or difficulty == 151 then--Flexible LFR (ie post WoD zones)/8.3+ LFR
		return "lfr", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 18 then--Special event 40 player LFR Queue (used by molten core aniversery event)
		return "event40", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 19 then--Special event 5 player queue (used by wod pre expansion event that had miniturized version of UBRS remake)
		return "event5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 20 then--Special event 20 player LFR Queue (never used yet)
		return "event20", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 23 then--Mythic 5 man Dungeon
		return "mythic5", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 24 or difficulty == 33 then--Timewalking Dungeon, Timewalking Raid
		return "timewalker", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 38 then--Normal BfA Island expedition
		return "normalisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 39 then--Heroic BfA Island expedition
		return "heroicisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 40 then--Mythic BfA Island expedition
		return "mythicisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 147 then--Normal BfA Warfront
		return "normalwarfront", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 148 or difficulty == 185 then--20 man classic raid
		return "normal20", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 149 then--Heroic BfA Warfront
		return "heroicwarfront", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 152 or difficulty == 167 then--Visions of Nzoth (bfa), Torghast (shadowlands)
		return "progressivechallenges", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 153 then---Teaming BfA? Island expedition
		return "teamingisland", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 168 then--Path of Ascention (Shadowlands)
		return "couragescenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 169 then--Path of Ascention (Shadowlands)
		return "loyaltyscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 170 then--Path of Ascention (Shadowlands)
		return "wisdomscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 171 then--Path of Ascention (Shadowlands)
		return "humilityscenario", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 192 then--Non Instanced Challenge 1 (Likely Delves base difficulty)
		return "delve1", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 205 then--Follower Dungeon (Dragonflight 10.2.5+)
		return "follower", difficultyName .. " - ", difficulty, instanceGroupSize, 0
	else--failsafe
		return "normal", "", difficulty, instanceGroupSize, 0
	end
end

function DBM:GetCurrentArea()
	return LastInstanceMapID
end

function DBM:GetCurrentDifficulty()
	return difficultyIndex
end

function DBM:GetGroupSize()
	return LastGroupSize
end

--Public api for requesting what phase a boss is in, in case they missed the DBM_SetStage callback
--ModId would be journal Id or mod string of mod.
--Encounter ID, so api can be used in event two or more bosses are engaged at same time, ID can be used to verify which encounter they're requesting
--If not mod is not provided, it'll simply return stage for first boss in combat table if a boss is engaged
function DBM:GetStage(modId)
	if modId then
		local mod = self:GetModByName(modId)
		if mod and mod.inCombat then
			return mod.vb.phase or 0, mod.vb.stageTotality or 0
		end
	else
		if #inCombat > 0 then--At least one boss is engaged
			local mod = inCombat[1]--Get first mod in table
			if mod then
				return mod.vb.phase or 0, mod.vb.stageTotality or 0, mod.multiEncounterPullDetection and mod.multiEncounterPullDetection[1] or mod.encounterId
			end
		end
	end
end

function DBM:GetKeyStoneLevel()
	return difficultyModifier
end

function DBM:HasMapRestrictions()
	--Check playerX and playerY. if they are nil restrictions are active
	--Restrictions active in all party, raid, pvp, arena maps. No restrictions in "none" or "scenario"
	local playerX, playerY = UnitPosition("player")
	return not playerX or not playerY
end

do
	local LSMMediaCacheBuilt, sharedMediaFileCache, validateCache = false, {}, {}

	local function buildLSMFileCache()
		local LSM = LibStub and LibStub("LibSharedMedia-3.0", true)
		if LSM then
			local hashtable = LSM:HashTable("sound")
			local keytable = {}
			for k in next, hashtable do
				tinsert(keytable, k)
			end
			for i = 1, #keytable do
				sharedMediaFileCache[hashtable[keytable[i]]] = true
			end
			LSMMediaCacheBuilt = true
		end
	end

	function DBM:ValidateSound(path, log, ignoreCustom)
		-- Ignore built in sounds
		if type(path) == "number" or string.find(path:lower(), "^sound[\\/]+") then
			return true
		end
		-- Validate LibSharedMedia
		if not LSMMediaCacheBuilt then
			buildLSMFileCache()
		end
		if not sharedMediaFileCache[path] and not path:find("DBM") then
			if log then
				if ignoreCustom then
					-- This uses debug print because it has potential to cause mid fight spam
					self:Debug("PlaySoundFile failed do to missing media at " .. path .. ". To fix this, re-add missing sound or change setting using this sound to a different sound.")
				else
					AddMsg(self, "PlaySoundFile failed do to missing media at " .. path .. ". To fix this, re-add missing sound or change setting using this sound to a different sound.")
				end
			end
			return false
		end
		-- Validate audio packs
		if not validateCache[path] then
			local splitTable = {}
			for split in string.gmatch(path, "[^\\/]+") do -- Matches \ and / as path delimiters (incl. more than one)
				tinsert(splitTable, split)
			end
			if #splitTable >= 3 and splitTable[3]:lower() == "dbm-customsounds" then
				validateCache[path] = {
					exists = ignoreCustom or false
				}
			elseif #splitTable >= 3 and splitTable[1]:lower() == "interface" and splitTable[2]:lower() == "addons" then -- We're an addon sound
				validateCache[path] = {
					exists = C_AddOns.IsAddOnLoaded(splitTable[3]),
					AddOn = splitTable[3]
				}
			else
				validateCache[path] = {
					exists = true
				}
			end
		end
		if validateCache[path] and not validateCache[path].exists then
			if log then
				-- This uses actual user print because these events only occure at start or end of instance or fight.
				AddMsg(self, "PlaySoundFile failed do to missing media at " .. path .. ". To fix this, re-add/enable " .. validateCache[path].AddOn .. " or change setting using this sound to a different sound.")
			end
			return false
		end
		return true
	end

	function DBM:PlaySoundFile(path, ignoreSFX, validate)
		if self.Options.SilentMode or path == "" or path == "None" then
			return
		end
		local soundSetting = self.Options.UseSoundChannel
		if type(path) == "number" then--Build in media using FileDataID
			self:Debug("PlaySoundFile playing with FileDataID " .. path, 3)
			if soundSetting == "Dialog" then
				PlaySoundFile(path, "Dialog")
			elseif ignoreSFX or soundSetting == "Master" then
				PlaySoundFile(path, "Master")
			else
				PlaySoundFile(path) -- Using SFX channel, leave forceNoDuplicates on.
			end
			fireEvent("DBM_PlaySound", path)
		else--External media, which needs path validation to avoid lua errors
			if validate and not self:ValidateSound(path, true, true) then
				return
			end
			self:Debug("PlaySoundFile playing with file path " .. path, 3)
			if soundSetting == "Dialog" then
				PlaySoundFile(path, "Dialog")
			elseif ignoreSFX or soundSetting == "Master" then
				PlaySoundFile(path, "Master")
			else
				PlaySoundFile(path)
			end
			fireEvent("DBM_PlaySound", path)
		end
	end
end

--Future proofing EJ_GetSectionInfo compat layer to make it easier updatable.
function DBM:EJ_GetSectionInfo(sectionID)
	if not isRetail then
		return "EJ_GetSectionInfo not supported on Classic, please report this message and boss"
	end
	local info = EJ_GetSectionInfo(sectionID)
	if not info then
		self:Debug("|cffff0000Invalid call to EJ_GetSectionInfo for sectionID: |r" .. sectionID)
		return
	end
	local flag1, flag2, flag3, flag4
	local flags = GetSectionIconFlags(sectionID)
	if flags then
		flag1, flag2, flag3, flag4 = unpack(flags)
	end
	return info.title, info.description, info.headerType, info.abilityIcon, info.creatureDisplayID, info.siblingSectionID, info.firstChildSectionID, info.filteredByDifficulty, info.link, info.startsOpen, flag1, flag2, flag3, flag4
end

function DBM:GetDungeonInfo(id)
	local temp = GetDungeonInfo(id)
	return type(temp) == "table" and temp.name or tostring(temp)
end

--Handle new spell name requesting with wrapper, to make api changes easier to handle
--Keep an eye on C_SpellBook.GetSpellInfo, but don't use it YET as direction of existing GetSpellInfo isn't finalized yet
function DBM:GetSpellInfo(spellId)
	--I want this to fail, and fail loudly (ie get reported when mods are completely missing the spellId)
	if not spellId or spellId == "" then
		error("|cffff0000Invalid call to GetSpellInfo for spellId. spellId is missing! |r")
	end
	local name, rank, icon, castingTime, minRange, maxRange, returnedSpellId = GetSpellInfo(spellId)
	--I want this for debug purposes to catch spellids that are removed from game/changed, but quietly to end user
	if not returnedSpellId then--Bad request all together
		if type(spellId) == "string" then
			self:Debug("|cffff0000Invalid call to GetSpellInfo for spellId: |r" .. spellId .. " as a string!")
		else
			if spellId > 4 then
				self:Debug("|cffff0000Invalid call to GetSpellInfo for spellId: |r" .. spellId)
			end
		end
		return
	end--Good request, return now
	return name, rank, icon, castingTime, minRange, maxRange, returnedSpellId
end

do
	local UnitAura = C_UnitAuras and C_UnitAuras.GetAuraDataByIndex or UnitAura
	local GetPlayerAuraBySpellID = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID
	local GetAuraDataBySpellName = C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName
	local newUnitAuraAPIs = C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName and true--Purposely separate from GetAuraDataBySpellName upvalue because I don't want to spam check if a function exists in such a frequent API call
	function DBM:UnitAura(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		if not uId then return end
		if isRetail and type(spellInput) == "number" and not spellInput2 and UnitIsUnit(uId, "player") then--A simple single spellId check should use more efficent direct blizzard method
			local spellTable = GetPlayerAuraBySpellID(spellInput)
			if not spellTable then return end
			return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
		else--Either a multi spell check, spell name check, or C_UnitAuras.GetPlayerAuraBySpellID is unavailable
			if newUnitAuraAPIs then
				if type(spellInput) == "string" and not spellInput2 then--A simple single spellName check should use more efficent direct blizzard method
					local spellTable = GetAuraDataBySpellName(uId, spellInput)
					if not spellTable then return end
					return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
				else--Either a multi spell check, or a single spell id check on non player unit (C_UnitAuras.GetPlayerAuraBySpellID is unavailable)
					for i = 1, 60 do
						local spellTable = UnitAura(uId, i)
						if not spellTable then return end
						if spellInput == spellTable.name or spellInput == spellTable.spellId or spellInput2 == spellTable.name or spellInput2 == spellTable.spellId or spellInput3 == spellTable.name or spellInput3 == spellTable.spellId or spellInput4 == spellTable.name or spellInput4 == spellTable.spellId or spellInput5 == spellTable.name or spellInput5 == spellTable.spellId then
							return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
						end
					end
				end
			else
				for i = 1, 60 do
					local spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura(uId, i)
					if not spellName then return end
					if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId or spellInput5 == spellName or spellInput5 == spellId then
						--In classic, instead of adding rank back in at beginning where it was pre 8.0, it's 15th arg return at end (value 1)
						return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3
					end
				end
			end
		end
	end

	function DBM:UnitDebuff(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		if not uId then return end
		if isRetail and type(spellInput) == "number" and not spellInput2 and UnitIsUnit(uId, "player") then--A simple single spellId check should use more efficent direct blizzard method
			local spellTable = GetPlayerAuraBySpellID(spellInput)
			if not spellTable then return end
			return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
		else--Either a multi spell check, spell name check, or C_UnitAuras.GetPlayerAuraBySpellID is unavailable
			if newUnitAuraAPIs then
				if type(spellInput) == "string" and not spellInput2 then--A simple single spellName check should use more efficent direct blizzard method
					local spellTable = GetAuraDataBySpellName(uId, spellInput, "HARMFUL")
					if not spellTable then return end
					return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
				else--Either a multi spell check, or a single spell id check on non player unit (C_UnitAuras.GetPlayerAuraBySpellID is unavailable)
					for i = 1, 60 do
						local spellTable = UnitAura(uId, i, "HARMFUL")
						if not spellTable then return end
						if spellInput == spellTable.name or spellInput == spellTable.spellId or spellInput2 == spellTable.name or spellInput2 == spellTable.spellId or spellInput3 == spellTable.name or spellInput3 == spellTable.spellId or spellInput4 == spellTable.name or spellInput4 == spellTable.spellId or spellInput5 == spellTable.name or spellInput5 == spellTable.spellId then
							return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
						end
					end
				end
			else
				for i = 1, 60 do
					local spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura(uId, i, "HARMFUL")
					if not spellName then return end
					if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId or spellInput5 == spellName or spellInput5 == spellId then
						--In classic, instead of adding rank back in at beginning where it was pre 8.0, it's 15th arg return at end (value 1)
						return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3
					end
				end
			end
		end
	end

	function DBM:UnitBuff(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		if not uId then return end
		if isRetail and type(spellInput) == "number" and not spellInput2 and UnitIsUnit(uId, "player") then--A simple single spellId check should use more efficent direct blizzard method
			local spellTable = GetPlayerAuraBySpellID(spellInput)
			if not spellTable then return end
			return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
		else--Either a multi spell check, spell name check, or C_UnitAuras.GetPlayerAuraBySpellID is unavailable
			if newUnitAuraAPIs then
				if type(spellInput) == "string" and not spellInput2 then--A simple single spellName check should use more efficent direct blizzard method
					local spellTable = GetAuraDataBySpellName(uId, spellInput, "HELPFUL")
					if not spellTable then return end
					return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
				else--Either a multi spell check, or a single spell id check on non player unit (C_UnitAuras.GetPlayerAuraBySpellID is unavailable)
					for i = 1, 60 do
						local spellTable = UnitAura(uId, i, "HELPFUL")
						if not spellTable then return end
						if spellInput == spellTable.name or spellInput == spellTable.spellId or spellInput2 == spellTable.name or spellInput2 == spellTable.spellId or spellInput3 == spellTable.name or spellInput3 == spellTable.spellId or spellInput4 == spellTable.name or spellInput4 == spellTable.spellId or spellInput5 == spellTable.name or spellInput5 == spellTable.spellId then
							return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
						end
					end
				end
			else
				for i = 1, 60 do
					local spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura(uId, i, "HELPFUL")
					if not spellName then return end
					if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId or spellInput5 == spellName or spellInput5 == spellId then
						--In classic, instead of adding rank back in at beginning where it was pre 8.0, it's 15th arg return at end (value 1)
						return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod, value1, value2, value3
					end
				end
			end
		end
	end
end

function DBM:UNIT_DIED(args)
	local GUID = args.destGUID
	if self:IsCreatureGUID(GUID) then
		self:OnMobKill(self:GetCIDFromGUID(GUID))
	end
	----GUIDIsPlayer
	--no point in playing alert on death itself on hardcore. if you're dead it's over, no reason to salt the wound
	if not isHardcoreServer and self.Options.AFKHealthWarning2 and GUID == UnitGUID("player") and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
		self:FlashClientIcon()
		local voice = DBM.Options.ChosenVoicePack2
		local path = 546633--"Sound\\Creature\\CThun\\CThunYouWillDIe.ogg"
		if not voiceSessionDisabled and voice ~= "None" then
			path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
		end
		self:PlaySoundFile(path)
		self:AddMsg(L.AFK_WARNING:format(0))
	end
end
DBM.UNIT_DESTROYED = DBM.UNIT_DIED

----------------------
--  Timer recovery  --
----------------------
do
	local requestedFrom = {}
	local requestTime = 0

	local function sort(v1, v2)
		if v1.revision and not v2.revision then
			return true
		elseif v2.revision and not v1.revision then
			return false
		elseif v1.revision and v2.revision then
			return v1.revision > v2.revision
		end
		return (v1.bwversion or 0) > (v2.bwversion or 0)
	end

	function DBM:RequestTimers(requestNum)
		if not dbmIsEnabled then return end
		local sortMe, clientUsed = {}, {}
		for _, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		self:Debug("RequestTimers Running", 2)
		local selectedClient
		local listNum = 0
		for _, v in ipairs(sortMe) do
			-- If selectedClient player's realm is not same with your's, timer recovery by selectedClient not works at all.
			-- SendAddonMessage target channel is "WHISPER" and target player is other realm, no msg sends at all. At same realm, message sending works fine. (Maybe bliz bug or SendAddonMessage function restriction?)
			if v.name ~= playerName and UnitIsConnected(v.id) and UnitIsPlayer(v.id) and (not UnitIsGhost(v.id)) and UnitRealmRelationship(v.id) ~= 2 and (GetTime() - (clientUsed[v.name] or 0)) > 10 then
				listNum = listNum + 1
				if listNum == requestNum then
					selectedClient = v
					clientUsed[v.name] = GetTime()
					break
				end
			end
		end
		if not selectedClient then return end
		self:Debug("Requesting timer recovery to " .. selectedClient.name)
		requestedFrom[selectedClient.name] = true
		requestTime = GetTime()
		SendAddonMessage(DBMPrefix, DBMSyncProtocol .. "\tRT", "WHISPER", selectedClient.name)
	end

	function DBM:ReceiveCombatInfo(sender, mod, time)
		if dbmIsEnabled and requestedFrom[sender] and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			self:StartCombat(mod, time, "TIMER_RECOVERY")
			--Recovery successful, someone sent info, abort other recovery requests
			self:Unschedule(self.RequestTimers)
			twipe(requestedFrom)
		end
	end

	function DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, paused, ...)
		if requestedFrom[sender] and (GetTime() - requestTime) < 5 then
			local lag = paused and 0 or select(4, GetNetStats()) / 1000
			for _, v in ipairs(mod.timers) do
				if v.id == id then
					v:Start(totalTime, ...)
					if paused then
						v.paused = true
					end
					v:Update(totalTime - timeLeft + lag, totalTime, ...)
				end
			end
		end
	end

	function DBM:ReceiveVariableInfo(sender, mod, name, value)
		if requestedFrom[sender] and (GetTime() - requestTime) < 5 then
			if value == "true" then
				mod.vb[name] = true
			elseif value == "false" then
				mod.vb[name] = false
			else
				mod.vb[name] = value
				if name == "phase" then
					mod:SetStage(value)--Fire stage callback for 3rd party mods when stage is recovered
				end
			end
		end
	end
end

do
	local spamProtection = {}
	function DBM:SendTimers(target)
		if not dbmIsEnabled then return end
		self:Debug("SendTimers requested by " .. target, 2)
		local spamForTarget = spamProtection[target] or 0
		-- just try to clean up the table, that should keep the hash table at max. 4 entries or something :)
		for k, v in pairs(spamProtection) do
			if GetTime() - v >= 1 then
				spamProtection[k] = nil
			end
		end
		if GetTime() - spamForTarget < 1 then -- just to prevent players from flooding this on purpose
			return
		end
		spamProtection[target] = GetTime()
		if #inCombat < 1 then
			--Break timer is up, so send that
			--But only if we are not in combat with a boss
			if DBT:GetBar(L.TIMER_BREAK) then
				local remaining = DBT:GetBar(L.TIMER_BREAK).timer
				SendAddonMessage(DBMPrefix, DBMSyncProtocol .. "\tBTR3\t" .. remaining, "WHISPER", target)
			end
			return
		end
		local mod
		for _, v in ipairs(inCombat) do
			mod = not v.isCustomMod and v
		end
		mod = mod or inCombat[1]
		self:SendCombatInfo(mod, target)
		self:SendVariableInfo(mod, target)
		self:SendTimerInfo(mod, target)
	end
	function DBM:SendPVPTimers(target)
		if not dbmIsEnabled then return end
		self:Debug("SendPVPTimers requested by " .. target, 2)
		local spamForTarget = spamProtection[target] or 0
		local time = GetTime()
		-- just try to clean up the table, that should keep the hash table at max. 4 entries or something :)
		for k, v in pairs(spamProtection) do
			if time - v >= 1 then
				spamProtection[k] = nil
			end
		end
		if time - spamForTarget < 1 then -- just to prevent players from flooding this on purpose
			return
		end
		spamProtection[target] = time
		local mod = self:GetModByName("PvPGeneral")
		if mod then
			self:SendTimerInfo(mod, target)
		end
	end
end

function DBM:SendCombatInfo(mod, target)
	if not dbmIsEnabled then return end
	return SendAddonMessage(DBMPrefix, (DBMSyncProtocol .. "\tCI\t%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), "WHISPER", target)
end

function DBM:SendTimerInfo(mod, target)
	if not dbmIsEnabled then return end
	for _, v in ipairs(mod.timers) do
		--Pass on any timer that has no type, or has one that isn't an ai timer
		if not v.type or v.type and v.type ~= "ai" then
			for _, uId in ipairs(v.startedTimers) do
				local elapsed, totalTime, timeLeft
				if select("#", string.split("\t", uId)) > 1 then
					elapsed, totalTime = v:GetTime(select(2, string.split("\t", uId)))
				else
					elapsed, totalTime = v:GetTime()
				end
				timeLeft = totalTime - elapsed
				if timeLeft > 0 and totalTime > 0 then
					SendAddonMessage(DBMPrefix, (DBMSyncProtocol .. "\tTR\t%s\t%s\t%s\t%s\t%s"):format(mod.id, timeLeft, totalTime, uId, v.paused and "1" or "0"), "WHISPER", target)
				end
			end
		end
	end
end

function DBM:SendVariableInfo(mod, target)
	if not dbmIsEnabled then return end
	for vname, v in pairs(mod.vb) do
		local v2 = tostring(v)
		if v2 then
			SendAddonMessage(DBMPrefix, (DBMSyncProtocol .. "\tVI\t%s\t%s\t%s"):format(mod.id, vname, v2), "WHISPER", target)
		end
	end
end

do
	function DBM:PLAYER_ENTERING_WORLD()
		if self.Options.ShowReminders then
			C_TimerAfter(25, function() if self.Options.SilentMode then self:AddMsg(L.SILENT_REMINDER) end end)
			C_TimerAfter(30, function() if not self.Options.SettingsMessageShown then self.Options.SettingsMessageShown = true self:AddMsg(L.HOW_TO_USE_MOD) end end)
--			C_TimerAfter(35, function() if self.Options.NewsMessageShown2 < 2 then self.Options.NewsMessageShown2 = 2 self:AddMsg(L.NEWS_UPDATE) end end)
		end
		if type(C_ChatInfo.RegisterAddonMessagePrefix) == "function" then
			if not C_ChatInfo.RegisterAddonMessagePrefix(DBMPrefix) then -- main prefix for DBM4
				self:AddMsg("Error: unable to register DBM addon message prefix (reached client side addon message filter limit), synchronization will be unavailable") -- TODO: confirm that this actually means that the syncs won't show up
			end
			if not C_ChatInfo.IsAddonMessagePrefixRegistered("BigWigs") then
				if not C_ChatInfo.RegisterAddonMessagePrefix("BigWigs") then
					self:AddMsg("Error: unable to register BigWigs addon message prefix (reached client side addon message filter limit), BigWigs version checks will be unavailable")
				end
			end
			if not C_ChatInfo.IsAddonMessagePrefixRegistered("Transcriptor") then
				if not C_ChatInfo.RegisterAddonMessagePrefix("Transcriptor") then
					self:AddMsg("Error: unable to register Transcriptor addon message prefix (reached client side addon message filter limit)")
				end
			end
		end
		--Check if any previous changed cvars were not restored and restore them
		if self.Options.RestoreSettingSFX then
			SetCVar("Sound_EnableSFX", 1)
			self.Options.RestoreSettingSFX = nil
			self:Debug("Restoring Sound_EnableSFX CVAR")
		end
		if self.Options.RestoreSettingAmbiance then
			SetCVar("Sound_EnableAmbience", 1)
			self.Options.RestoreSettingAmbiance = nil
			self:Debug("Restoring Sound_EnableAmbience CVAR")
		end
		if self.Options.RestoreSettingMusic then
			SetCVar("Sound_EnableMusic", 1)
			self.Options.RestoreSettingMusic = nil
			self:Debug("Restoring Sound_EnableMusic CVAR")
		end
		--RestoreSettingCustomMusic doens't need restoring here, since zone change transition will handle it
	end
end

------------------------------------
--  Auto-respond/Status whispers  --
------------------------------------
do
	local function getNumAlivePlayers()
		local alive = 0
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				alive = alive + ((UnitIsDeadOrGhost("raid" .. i) and 0) or 1)
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				alive = alive + ((UnitIsDeadOrGhost("party" .. i) and 0) or 1)
			end
		end
		return alive
	end

	--Cleanup in 8.x with C_Map.GetMapGroupMembersInfo
	local function getNumRealAlivePlayers()
		local alive = 0
		local isInInstance = IsInInstance()
		local currentMapId = isInInstance and select(-1, UnitPosition("player")) or C_Map.GetBestMapForUnit("player") or 0
		local currentMapName = C_Map.GetMapInfo(currentMapId) or CL.UNKNOWN
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if isInInstance and select(-1, UnitPosition("raid" .. i)) == currentMapId or select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("raid" .. i) and 0) or 1)
				end
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				if isInInstance and select(-1, UnitPosition("party" .. i)) == currentMapId or select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("party" .. i) and 0) or 1)
				end
			end
		end
		return alive
	end
	function DBM:NumRealAlivePlayers()
		return getNumRealAlivePlayers()
	end

	-- sender is a presenceId for real id messages, a character name otherwise
	local function onWhisper(msg, sender, isRealIdMessage)
		if private.statusWhisperDisabled then return end--RL has disabled status whispers for entire raid.
		if not checkForSafeSender(sender, true, true, true, isRealIdMessage) then return end--Automatically reject all whisper functions from non friends, non guildies, or people in group with us
		if msg:find(chatPrefixShort) and not InCombatLockdown() and DBM:AntiSpam(60, "Ogron") and DBM.Options.AutoReplySound then
			--Might need more validation if people figure out they can just whisper people with chatPrefix to trigger it.
			--However if I have to add more validation it probably won't work in most languages :\ So lets hope antispam and combat check is enough
			DBM:PlaySoundFile(997890)--"sound\\creature\\aggron1\\VO_60_HIGHMAUL_AGGRON_1_AGGRO_1.ogg"
		elseif msg == "status" and #inCombat > 0 and DBM.Options.AutoRespond then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for _, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if mod.noStatistics then return end
			if isRetail and not mod.soloChallenge and IsInScenarioGroup() then return end--status not really useful on scenario mods since there is no way to report progress as a percent. We just ignore it.
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
			if mod.vb.phase then
				hpText = hpText .. " (" .. SCENARIO_STAGE:format(mod.vb.phase) .. ")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText .. " (" .. BOSSES_KILLED:format(bossesKilled, mod.numBoss) .. ")"
			end
			sendWhisper(sender, chatPrefixShort .. L.STATUS_WHISPER:format(difficultyText .. (mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
		elseif #inCombat > 0 and DBM.Options.AutoRespond then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for _, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if mod.noStatistics then return end
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
			if mod.vb.phase then
				hpText = hpText .. " (" .. SCENARIO_STAGE:format(mod.vb.phase) .. ")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText .. " (" .. BOSSES_KILLED:format(bossesKilled, mod.numBoss) .. ")"
			end
			if not autoRespondSpam[sender] then
				if isRetail and not mod.soloChallenge and IsInScenarioGroup() then
					sendWhisper(sender, chatPrefixShort .. L.AUTO_RESPOND_WHISPER_SCENARIO:format(playerName, difficultyText .. (mod.combatInfo.name or ""), getNumAlivePlayers(), DBM:GetNumGroupMembers()))
				else
					sendWhisper(sender, chatPrefixShort .. L.AUTO_RESPOND_WHISPER:format(playerName, difficultyText .. (mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
				end
				DBM:AddMsg(L.AUTO_RESPONDED)
			end
			autoRespondSpam[sender] = true
		end
	end

	function DBM:CHAT_MSG_WHISPER(msg, name, _, _, _, status)
		if status ~= "GM" then
			name = Ambiguate(name, "none")
			return onWhisper(msg, name, false)
		end
	end

	function DBM:CHAT_MSG_BN_WHISPER(msg, ...)
		local presenceId = select(12, ...) -- srsly?
		return onWhisper(msg, presenceId, true)
	end
end

--This completely unregisteres or registers distruptive events so they don't obstruct combat
--Toggle is for if we are turning off or on.
--Custom is for external mods to call function without duplication and allowing pvp mods custom toggle.
do
	local unregisteredEvents = {}
	local function DisableEvent(frameName, eventName)
		if frameName:IsEventRegistered(eventName) then
			frameName:UnregisterEvent(eventName)
			unregisteredEvents[eventName] = true
		end
	end
	local function EnableEvent(frameName, eventName)
		if unregisteredEvents[eventName] then
			frameName:RegisterEvent(eventName)
			unregisteredEvents[eventName] = nil
		end
	end
	function DBM:HideBlizzardEvents(toggle, custom)
		if toggle == 1 then
			if (self.Options.HideBossEmoteFrame2 or custom) and not testBuild then
				DisableEvent(RaidBossEmoteFrame, "RAID_BOSS_EMOTE")
				DisableEvent(RaidBossEmoteFrame, "RAID_BOSS_WHISPER")
				DisableEvent(RaidBossEmoteFrame, "CLEAR_BOSS_EMOTES")
				SOUNDKIT.UI_RAID_BOSS_WHISPER_WARNING = 999999--Since blizzard can still play the sound via RaidBossEmoteFrame_OnEvent (line 148) via encounter scripts in certain cases despite the frame having no registered events
			end
			if self.Options.HideGarrisonToasts or custom then
				DisableEvent(AlertFrame, "GARRISON_MISSION_FINISHED")
				DisableEvent(AlertFrame, "GARRISON_BUILDING_ACTIVATABLE")
			end
			if self.Options.HideGuildChallengeUpdates or custom then
				DisableEvent(AlertFrame, "GUILD_CHALLENGE_COMPLETED")
			end
		elseif toggle == 0 then
			if (self.Options.HideBossEmoteFrame2 or custom) and not testBuild then
				EnableEvent(RaidBossEmoteFrame, "RAID_BOSS_EMOTE")
				EnableEvent(RaidBossEmoteFrame, "RAID_BOSS_WHISPER")
				EnableEvent(RaidBossEmoteFrame, "CLEAR_BOSS_EMOTES")
				SOUNDKIT.UI_RAID_BOSS_WHISPER_WARNING = 37666--restore it
			end
			if self.Options.HideGarrisonToasts then
				EnableEvent(AlertFrame, "GARRISON_MISSION_FINISHED")
				EnableEvent(AlertFrame, "GARRISON_BUILDING_ACTIVATABLE")
			end
			if self.Options.HideGuildChallengeUpdates then
				EnableEvent(AlertFrame, "GUILD_CHALLENGE_COMPLETED")
			end
		end
	end
end

--------------------------
--  Enable/Disable DBM  --
--------------------------
do
	local forceDisabled = false
	function DBM:Disable(forceDisable)
		DBMScheduler:Unschedule()
		dbmIsEnabled = false
		private.dbmIsEnabled = false
		forceDisabled = forceDisable
	end

	function DBM:Enable()
		if not forceDisabled then
			dbmIsEnabled = true
		end
	end

	function DBM:IsEnabled()
		return dbmIsEnabled
	end

	function DBM:ForceDisableSpam()
		if testBuild then
			DBM:AddMsg(L.UPDATEREMINDER_DISABLETEST)
		elseif dbmToc < wowTOC then
			DBM:AddMsg(L.UPDATEREMINDER_MAJORPATCH)
		else
			DBM:AddMsg(L.UPDATEREMINDER_DISABLE)
		end
	end
end

-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix, useSound, allowHiddenChatFrame)
	---@diagnostic disable-next-line: undefined-field
	local tag = prefix or (self.localization and self.localization.general.name) or L.DBM
	local frame = DBM.Options.ChatFrame and _G[tostring(DBM.Options.ChatFrame)] or DEFAULT_CHAT_FRAME
	if not frame or not frame:IsShown() and not allowHiddenChatFrame then
		frame = DEFAULT_CHAT_FRAME
	end
	if prefix ~= false then
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(tag), tostring(text)), 0.41, 0.8, 0.94)
	else
		frame:AddMessage(text, 0.41, 0.8, 0.94)
	end
	if DBM.Options.DebugSound and useSound then
		DBM:PlaySoundFile(567458)--"Ding"
	end
end
AddMsg = DBM.AddMsg

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer1, testTimer2, testTimer3, testTimer4, testTimer5, testTimer6, testTimer7, testTimer8
	local testSpecialWarning1, testSpecialWarning2, testSpecialWarning3
	function DBM:DemoMode()
		fireEvent("DBM_TestModStarted")
		if not testMod then
			testMod = self:NewMod("TestMod")
			self:GetModLocalization("TestMod"):SetGeneralLocalization{name = "Test Mod"}
			testWarning1 = testMod:NewAnnounce("%s", 1, "136116")--Interface\\Icons\\Spell_Nature_WispSplode
			testWarning2 = testMod:NewAnnounce("%s", 2, isRetail and "136194" or "136221")
			testWarning3 = testMod:NewAnnounce("%s", 3, "135826")
			testTimer1 = testMod:NewTimer(20, "%s", "136116", nil, nil)
			testTimer2 = testMod:NewTimer(20, "%s ", "134170", nil, nil, 1)
			testTimer3 = testMod:NewTimer(20, "%s  ", isRetail and "136194" or "136221", nil, nil, 3, CL.MAGIC_ICON, nil, 1, 4, nil, nil, nil, nil, nil, nil, "next")--inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
			testTimer4 = testMod:NewTimer(20, "%s   ", "136116", nil, nil, 4, CL.INTERRUPT_ICON)
			testTimer5 = testMod:NewTimer(20, "%s    ", "135826", nil, nil, 2, CL.HEALER_ICON, nil, 3, 4, nil, nil, nil, nil, nil, nil, "next")--inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
			testTimer6 = testMod:NewTimer(20, "%s     ", "136116", nil, nil, 5, CL.TANK_ICON, nil, 2, 4, nil, nil, nil, nil, nil, nil, "next")--inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
			testTimer7 = testMod:NewTimer(20, "%s      ", "136116", nil, nil, 6)
			testTimer8 = testMod:NewTimer(20, "%s       ", "136116", nil, nil, 7)
			testSpecialWarning1 = testMod:NewSpecialWarning("%s", nil, nil, nil, 1, 2)
			testSpecialWarning2 = testMod:NewSpecialWarning(" %s ", nil, nil, nil, 2, 2)
			testSpecialWarning3 = testMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3, 2) -- hack: non auto-generated special warnings need distinct names (we could go ahead and give them proper names with proper localization entries, but this is much easier)
		end
		testTimer1:Stop("Test Bar")
		testTimer2:Stop("Adds")
		testTimer3:Stop("Evil Debuff")
		testTimer4:Stop("Important Interrupt")
		testTimer5:Stop("Boom!")
		testTimer6:Stop("Handle your Role")
		testTimer7:Stop("Next Stage")
		testTimer8:Stop("Custom User Bar")
		testTimer1:Start(10, "Test Bar")
		testTimer2:Start(30, "Adds")
		testTimer3:Start(43, "Evil Debuff")
		testTimer4:Start(20, "Important Interrupt")
		testTimer5:Start(60, "Boom!")
		testTimer6:Start(35, "Handle your Role")
		testTimer7:Start(50, "Next Stage")
		testTimer8:Start(55, "Custom User Bar")
		testWarning1:Cancel()
		testWarning2:Cancel()
		testWarning3:Cancel()
		testSpecialWarning1:Cancel()
		testSpecialWarning1:CancelVoice()
		testSpecialWarning2:Cancel()
		testSpecialWarning2:CancelVoice()
		testSpecialWarning3:Cancel()
		testSpecialWarning3:CancelVoice()
		testWarning1:Show("Test-mode started...")
		testWarning1:Schedule(62, "Test-mode finished!")
		testWarning3:Schedule(50, "Boom in 10 sec!")
		testWarning3:Schedule(20, "Pew Pew Laser Owl!")
		testWarning2:Schedule(38, "Evil Spell in 5 sec!")
		testWarning2:Schedule(43, "Evil Spell!")
		testWarning1:Schedule(10, "Test bar expired!")
		testSpecialWarning1:Schedule(20, "Pew Pew Laser Owl")
		testSpecialWarning1:ScheduleVoice(20, "runaway")
		testSpecialWarning2:Schedule(43, "Fear!")
		testSpecialWarning2:ScheduleVoice(43, "fearsoon")
		testSpecialWarning3:Schedule(60, "Boom!")
		testSpecialWarning3:ScheduleVoice(60, "defensive")
	end
end

DBT:SetAnnounceHook(function(bar)
	local prefix
	if bar.color and bar.color.r == 1 and bar.color.g == 0 and bar.color.b == 0 then
		prefix = FACTION_HORDE
	elseif bar.color and bar.color.r == 0 and bar.color.g == 0 and bar.color.b == 1 then
		prefix = FACTION_ALLIANCE
	end
	if prefix then
		return ("%s: %s  %d:%02d"):format(prefix, _G[bar.frame:GetName() .. "BarName"]:GetText(), floor(bar.timer / 60), bar.timer % 60)
	end
end)

--copied from big wigs with permission from funkydude. Modified by MysticalOS
function DBM:RoleCheck(ignoreLoot)
	local spec = GetSpecialization()
	if not spec then return end
	local role = GetSpecializationRole(spec)
	if not role then return end
	local specID = GetLootSpecialization()
	local _, _, _, _, lootrole = GetSpecializationInfoByID(specID)
	if not InCombatLockdown() and not IsFalling() and ((IsPartyLFG() and (difficultyIndex == 14 or difficultyIndex == 15)) or not IsPartyLFG()) then
		if UnitGroupRolesAssigned("player") ~= role then
			UnitSetRole("player", role)
		end
	end
	--Loot reminder even if spec isn't known or we are in LFR where we have a valid for role without us being ones that set us.
	if not ignoreLoot and lootrole and (role ~= lootrole) and self.Options.RoleSpecAlert then
		self:AddMsg(L.LOOT_SPEC_REMINDER:format(_G[role] or CL.UNKNOWN, _G[lootrole]))
	end
end

-- An anti spam function to throttle spammy events (e.g. SPELL_AURA_APPLIED on all group members)
--- @param time number? time to wait between two events (optional, default 2.5 seconds)
--- @param id any? id to distinguish different events (optional, only necessary if your mod keeps track of two different spam events at the same time)
function DBM:AntiSpam(time, id)
	if GetTime() - (id and (self["lastAntiSpam" .. tostring(id)] or 0) or self.lastAntiSpam or 0) > (time or 2.5) then
		if id then
			self["lastAntiSpam" .. tostring(id)] = GetTime()
		else
			self.lastAntiSpam = GetTime()
		end
		return true
	end
	return false
end

function DBM:InCombat()
	return #inCombat > 0
end

function DBM:FlashClientIcon()
	if self:AntiSpam(5, "FLASH") then
		FlashClientIcon()
	end
end

function DBM:VibrateController()
	if self:AntiSpam(2, "VIBRATE") then
		if C_GamePad and C_GamePad.SetVibration then
			C_GamePad.SetVibration("High", 1)
		end
	end
end


do
	--Search Tags: iconto, toicon, raid icon, diamond, star, triangle
	local iconStrings = {[1] = RAID_TARGET_1, [2] = RAID_TARGET_2, [3] = RAID_TARGET_3, [4] = RAID_TARGET_4, [5] = RAID_TARGET_5, [6] = RAID_TARGET_6, [7] = RAID_TARGET_7, [8] = RAID_TARGET_8,}
	function DBM:IconNumToString(number)
		return iconStrings[number] or number
	end
	function DBM:IconNumToTexture(number)
		return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_" .. number .. ".blp:12:12|t" or number
	end
end

do
	local DevTools = private:GetModule("DevTools")
	function DBM:Debug(...)
		return DevTools:Debug(...)
	end

	function DBM:FindDungeonMapIDs(...)
		return DevTools:FindDungeonMapIDs(...)
	end

	function DBM:FindInstanceIDs(...)
		return DevTools:FindInstanceIDs(...)
	end

	function DBM:FindScenarioIDs(...)
		return DevTools:FindScenarioIDs(...)
	end

	function DBM:FindEncounterIDs(...)
		return DevTools:FindEncounterIDs(...)
	end
end

--------------------
--  Movie Filter  --
--------------------
do
	local neverFilter = {
		[486] = true, -- Tomb of Sarg Intro
		[487] = true, -- Alliance Broken Shore cut-scene
		[488] = true, -- Horde Broken Shore cut-scene
		[489] = true, -- Unknown, currently encrypted
		[490] = true, -- Unknown, currently encrypted
	}
	local requiresRecentKill = {
		[2238] = 2519--Fyrakk in Amirdrassil
	}
	local function checkOptions(self, id, mapID)
		--First, check if this specific cut scene should be blocked at all via the 3 primary rules
		local allowBlock = false
		if self.Options.HideMovieDuringFight and IsEncounterInProgress() then
			allowBlock = true
		end
		local isInstance, instanceType = IsInInstance()
		--HideMovieInstanceAnywhere means only dunegons and raids. NOT scenarios, and NOT garrisons. Delves will probably be added to this when api known
		if self.Options.HideMovieInstanceAnywhere and isInstance and instanceType ~= "scenario" and not (C_Garrison and C_Garrison:IsOnGarrisonMap()) then
			allowBlock = true
		end
		--HideMovieNonInstanceAnywhere means any outdoor area, which means anywhere non instanced or the garrison.
		--Scenarios are once again excluded, per deal with blizzard, since Legion
		--(scenarios ofen used for story events like broken shore and blizzard doesn't want addons skipping these)
		if self.Options.HideMovieNonInstanceAnywhere and instanceType ~= "scenario" and (not isInstance or (C_Garrison and C_Garrison:IsOnGarrisonMap())) then
			allowBlock = true
		end
		--Check for cinematics that should only be blocked if boss just died or was just pulled
		if mapID and requiresRecentKill[mapID] and allowBlock then
			local modID = requiresRecentKill[mapID]
			local mod = DBM:GetModByName(modID)
			if mod and mod.lastKillTime and (GetTime() - mod.lastKillTime) > 5 then
				allowBlock = false
			end
		end
		--Last check if seen yet and if seen once filter enabled, abort after flagging seen once
		if allowBlock and self.Options.HideMovieOnlyAfterSeen and not self.Options.MoviesSeen[id] then
			self.Options.MoviesSeen[id] = true
			allowBlock = false
		end
		return allowBlock
	end
	function DBM:PLAY_MOVIE(id)
		--Stop custom BG music during cut scenes regardless of block features
		self:TransitionToDungeonBGM(false, true)
		if id and not neverFilter[id] then
			self:Debug("PLAY_MOVIE fired for ID: " .. id, 2)
			if checkOptions(self, id) then
				MovieFrame:Hide()--can only just hide movie frame safely now, which means can't stop audio anymore :\
				self:AddMsg(L.MOVIE_SKIPPED)
			end
		end
	end

	function DBM:CINEMATIC_START()
		self:Debug("CINEMATIC_START fired", 2)
		--Stop custom BG music during cut scenes regardless of block features
		self:TransitionToDungeonBGM(false, true)
		self.HudMap:SupressCanvas()
		local currentMapID = C_Map.GetBestMapForUnit("player")
		local currentSubZone = GetSubZoneText() or ""
		--Just abort if map is nil, don't want to touch it if can't map cinematic to an area
		if currentMapID and checkOptions(self, currentMapID .. currentSubZone, currentMapID) then
			CinematicFrame_CancelCinematic()
			self:AddMsg(L.MOVIE_SKIPPED)
--			self:AddMsg(L.MOVIE_NOTSKIPPED)
		end
	end
	function DBM:CINEMATIC_STOP()
		self:Debug("CINEMATIC_STOP fired", 2)
		self.HudMap:UnSupressCanvas()
	end
end

----------------------------
--  Boss Mod Constructor  --
----------------------------
do
	local modsById = setmetatable({}, {__mode = "v"})
	local mt = {__index = bossModPrototype}

	function DBM:NewMod(name, modId, modSubTab, instanceId, nameModifier)
		name = tostring(name) -- the name should never be a number of something as it confuses sync handlers that just receive some string and try to get the mod from it
		if name == "DBM-ProfilesDummy" then return {} end
		if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
		---@type table
		local addon = nil
		for _, v in ipairs(self.AddOns) do
			if v.modId == modId then
				addon = v
				break
			end
		end
		---@class DBMMod
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
				},
				---@type table<string, any>
				DefaultOptions = {
					Enabled = true,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {"announce", "announceother", "announcepersonal", "announcerole", "specialannounce", "timer", "sound", "yell", "nameplate", "paura", "icon", "misc"},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				vb = {},
				iconRestore = {},
				modId = modId,
				instanceId = instanceId,
				revision = 0,
				SyncThreshold = 8,
				localization = self:GetModLocalization(name),
				groupSpells = {},
				groupOptions = OrderedTable(),
				addon = addon,
				inCombat = false,
				isTrashMod = false,
				isDummyMod = false,
				NoSortAnnounce = false
			},
			mt
		)

		if tonumber(name) and EJ_GetEncounterInfo then
			local t = EJ_GetEncounterInfo(tonumber(name))
			if type(nameModifier) == "number" then--Get name form EJ_GetCreatureInfo
				t = select(2, EJ_GetCreatureInfo(nameModifier, tonumber(name)))
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = tostring(t)
				t = string.split(",", t or name)
			end
			obj.localization.general.name = t or name
			obj.modelId = select(4, EJ_GetCreatureInfo(1, tonumber(name)))
		elseif name:match("z%d+") then
			local t = GetRealZoneText(tonumber(string.sub(name, 2)))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = string.split(",", t or name)
			end
			obj.localization.general.name = t or name
		elseif name:match("m%d+") then
			local t = C_Map.GetMapInfo(tonumber(name:sub(2)) or 0)
			local nameStr = t and t.name
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				nameStr = nameModifier(nameStr or name)
			else--default name modify
				nameStr = string.split(",", nameStr or name)
			end
			obj.localization.general.name = nameStr or name
		elseif name:match("d%d+") then
			local t = self:GetDungeonInfo(string.sub(name, 2))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = string.split(",", t or obj.localization.general.name or name)
			end
			obj.localization.general.name = t or name
		else
			obj.localization.general.name = obj.localization.general.name or name
		end
		tinsert(self.Mods, obj)
		if modId then
			self.ModLists[modId] = self.ModLists[modId] or {}
			tinsert(self.ModLists[modId], name)
		end
		modsById[name] = obj
		obj:SetZone()
		return obj
	end

	function DBM:GetModByName(name)
		return modsById[tostring(name)]
	end
end

-----------------------
--  General Methods  --
-----------------------
bossModPrototype.RegisterEvents = DBM.RegisterEvents
bossModPrototype.UnregisterInCombatEvents = DBM.UnregisterInCombatEvents
bossModPrototype.AddMsg = DBM.AddMsg
bossModPrototype.RegisterShortTermEvents = DBM.RegisterShortTermEvents
bossModPrototype.UnregisterShortTermEvents = DBM.UnregisterShortTermEvents

function bossModPrototype:SetZone(...)
	if select("#", ...) == 0 then
		self.zones = {}
		if self.addon and self.addon.mapId then
			for _, v in ipairs(self.addon.mapId) do
				self.zones[v] = true
			end
		end
	elseif select(1, ...) ~= DBM_DISABLE_ZONE_DETECTION then
		self.zones = {}
		for i = 1, select("#", ...) do
			self.zones[select(i, ...)] = true
		end
	else -- disable zone detection
		self.zones = nil
	end
end

function bossModPrototype:Toggle()
	if self.Options.Enabled then
		self:DisableMod()
	else
		self:EnableMod()
	end
end

function bossModPrototype:EnableMod()
	self.Options.Enabled = true
end

function bossModPrototype:DisableMod()
	self:Stop()
	self.Options.Enabled = false
end

function bossModPrototype:Stop()
	for _, v in ipairs(self.timers) do
		v:Stop()
	end
	self:Unschedule()
end

function bossModPrototype:SetUsedIcons(...)
	self.usedIcons = {}
	for i = 1, select("#", ...) do
		self.usedIcons[select(i, ...)] = true
	end
end

function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	if type(func) ~= "function" then return end
	DBM:Debug("Registering RegisterOnUpdateHandler")
	DBMScheduler:StartScheduler()
	self.elapsed = 0
	self.updateInterval = interval or 0
	private.updateFunctions[self] = func
end

function bossModPrototype:UnregisterOnUpdateHandler()
	self.elapsed = nil
	self.updateInterval = nil
	twipe(private.updateFunctions)
end

function bossModPrototype:SetStage(stage)
	if stage == 0 then--Increment request instead of hard value
		if not self.vb.phase then return end--Person DCed mid fight and somehow managed to perfectly time running SetStage with a value of 0 before getting variable recovery
		self.vb.phase = self.vb.phase + 1
	elseif stage == 0.5 then--Half Increment request instead of hard value
		self.vb.phase = self.vb.phase + 0.5
	else
		self.vb.phase = stage
	end
	--Separate variable to use SetStage totality for very niche weak aura practices
	if not self.vb.stageTotality then
		self.vb.stageTotality = 0
	end
	self.vb.stageTotality = self.vb.stageTotality + 1
	if self.inCombat then--Safety, in event mod manages to run any phase change calls out of combat/during a wipe we'll just safely ignore it
		fireEvent("DBM_SetStage", self, self.id, self.vb.phase, self.multiEncounterPullDetection and self.multiEncounterPullDetection[1] or self.encounterId, self.vb.stageTotality)--Mod, modId, Stage, Encounter Id (if available), total number of times SetStage has been called since combat start
		--Note, some encounters have more than one encounter Id, for these encounters, the first ID from mod is always returned regardless of actual engage ID triggered fight
		DBM:Debug("DBM_SetStage: " .. self.vb.phase .. "/" .. self.vb.stageTotality)
	end
end

--If args are passed, returns true or false
--If no args given, just returns current stage and stage total
--stage: stage value to checkf or true/false rules
--checkType: 0 or nil for just current stage match, 1 for less than check, 2 for greater than check, 3 not equal check
--useTotal: uses stage total instead of current
function bossModPrototype:GetStage(stage, checkType, useTotal)
	local currentStage, currentTotal = self.vb.phase or 0, self.vb.stageTotality or 0
	if stage then
		checkType = checkType or 0--Optional pass if just an exact match check
		if (checkType == 0) and (useTotal and currentTotal or currentStage) == stage then
			return true
		elseif (checkType == 1) and (useTotal and currentTotal or currentStage) < stage then
			return true
		elseif (checkType == 2) and (useTotal and currentTotal or currentStage) > stage then
			return true
		elseif (checkType == 3) and (useTotal and currentTotal or currentStage) ~= stage then
			return true
		end
		return false
	else
		return currentStage, currentTotal--This api doesn't need encounter Id return, since this is the local mod prototype version, which means it's already linked to specific encounter
	end
end

function bossModPrototype:AffixEvent(eventType, stage, timeAdjust, spellDebit)
	if self.inCombat then--Safety, in event mod manages to run any phase change calls out of combat/during a wipe we'll just safely ignore it
		fireEvent("DBM_AffixEvent", self, self.id, eventType, self.multiEncounterPullDetection and self.multiEncounterPullDetection[1] or self.encounterId, stage or 1, timeAdjust, spellDebit)--Mod, modId, type (0 end, 1, begin, 2, timerExtend), Encounter Id (if available), stage, amount of time to extend to, spellDebit, whether to subtrack the previous extend arg from next timer
	end
end

--------------
--  Events  --
--------------
---@param ... DBMEvent|string
function bossModPrototype:RegisterEventsInCombat(...)
	if self.inCombatOnlyEvents then
		geterrorhandler()("combat events already set")
	end
	self.inCombatOnlyEvents = {...}
	for k, v in pairs(self.inCombatOnlyEvents) do
		if v:sub(0, 5) == "UNIT_" and v:sub(-11) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
			-- legacy event, oh noes
			self.inCombatOnlyEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
		end
	end
end

-----------------------
--  Utility Methods  --
-----------------------

function bossModPrototype:IsDifficulty(...)
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsLFR()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "lfr" or diff == "lfr25"
end

--Dungeons: follower, normal, heroic. (Raids excluded)
function bossModPrototype:IsEasyDungeon()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "heroic5" or diff == "normal5" or diff == "follower5"
end

--Dungeons: Any 5 man dungeon
function bossModPrototype:IsDungeon()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "heroic5" or diff == "mythic5" or diff == "challenge5" or diff == "normal5"
end

--Dungeons: follower, normal, heroic. Raids: LFR, normal
function bossModPrototype:IsEasy()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normal" or diff == "lfr" or diff == "lfr25" or diff == "heroic5" or diff == "normal5" or diff == "follower5"
end

--Dungeons: mythic, mythic+. Raids: heroic, mythic
function bossModPrototype:IsHard()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "mythic" or diff == "mythic5" or diff == "challenge5" or diff == "heroic" or diff == "humilityscenario"
end

--Pretty much ANYTHING that has a normal mode
function bossModPrototype:IsNormal()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normal" or diff == "normal5" or diff == "normal10" or diff == "normal20" or diff == "normal25" or diff == "normal40" or diff == "normalisland" or diff == "normalwarfront"
end

---@param season SeasonID?
function DBM:IsSeasonal(season)
	if season and Enum.SeasonID then
		return Enum.SeasonID[season] == currentSeason
	else
		return not not currentSeason
	end
end

function DBM:IsFated()
	--Returns table if fated, nil otherwise
	if C_ModifiedInstance and C_ModifiedInstance.GetModifiedInstanceInfoFromMapID(LastInstanceMapID) then
		return true
	end
	return false
end
bossModPrototype.IsFated = DBM.IsFated

--Catch alls to basically allow encounter mods to use pre retail changes within mods
function DBM:IsClassic()
	return not isRetail
end
bossModPrototype.IsClassic = DBM.IsClassic

function DBM:IsRetail()
	return isRetail
end
bossModPrototype.IsRetail = DBM.IsRetail

function DBM:IsCata()
	return isCata
end
bossModPrototype.IsCata = DBM.IsCata

function bossModPrototype:IsFollower()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "follower"
end

--Pretty much ANYTHING that has a heroic mode
function bossModPrototype:IsHeroic()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "heroic" or diff == "heroic5" or diff == "heroic10" or diff == "heroic25" or diff == "heroicisland" or diff == "heroicwarfront"
end

--Pretty much ANYTHING that has mythic mode, with mythic+ included
function bossModPrototype:IsMythic()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "mythic" or diff == "challenge5" or diff == "mythicisland" or diff == "mythic5"
end

function bossModPrototype:IsMythicPlus()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "challenge5"
end

function bossModPrototype:IsEvent()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "event5" or diff == "event20" or diff == "event40"
end

function bossModPrototype:IsWarfront()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normalwarfront" or diff == "heroicwarfront"
end

function bossModPrototype:IsIsland()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normalisland" or diff == "heroicisland" or diff == "mythicisland"
end

function bossModPrototype:IsScenario()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "normalscenario" or diff == "heroicscenario" or diff == "couragescenario" or diff == "loyaltyscenario" or diff == "wisdomscenario" or diff == "humilityscenario"
end

function bossModPrototype:IsDelve()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	return diff == "delve1"
end

function bossModPrototype:IsValidWarning(sourceGUID, customunitID, loose, allowFriendly)
	if loose and InCombatLockdown() and GetNumGroupMembers() < 2 then return true end--In a loose check, this basically just checks if we're in combat, important for solo runs of torghast to not gimp mod too much
	if customunitID then
		if UnitExists(customunitID) and UnitGUID(customunitID) == sourceGUID and UnitAffectingCombat(customunitID) and (allowFriendly or not UnitIsFriend("player", customunitID)) then return true end
	else
		local unitId = DBM:GetUnitIdFromGUID(sourceGUID)
		if unitId and UnitExists(unitId) and UnitAffectingCombat(unitId) and (allowFriendly or not UnitIsFriend("player", unitId)) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsCriteriaCompleted(criteriaIDToCheck)
	if not isRetail then
		print("bossModPrototype:IsCriteriaCompleted should not be called in classic, report this message")
		return false
	end
	if not criteriaIDToCheck then
		error("usage: mod:IsCriteriaComplected(criteriaId)")
		return false
	end
	local _, _, numCriteria = C_Scenario.GetStepInfo()
	for i = 1, numCriteria do
		local _, _, criteriaCompleted, _, _, _, _, _, criteriaID = C_Scenario.GetCriteriaInfo(i)
		if criteriaID == criteriaIDToCheck and criteriaCompleted then
			return true
		end
	end
	return false
end

function bossModPrototype:LatencyCheck(custom)
	return select(4, GetNetStats()) < (custom or DBM.Options.LatencyThreshold)
end

function bossModPrototype:CheckBigWigs(name)
	if raid[name] and raid[name].bwversion then
		return raid[name].bwversion
	else
		return false
	end
end

bossModPrototype.IconNumToString = DBM.IconNumToString
bossModPrototype.IconNumToTexture = DBM.IconNumToTexture
bossModPrototype.AntiSpam = DBM.AntiSpam
bossModPrototype.HasMapRestrictions = DBM.HasMapRestrictions
bossModPrototype.GetUnitCreatureId = DBM.GetUnitCreatureId
bossModPrototype.GetCIDFromGUID = DBM.GetCIDFromGUID
bossModPrototype.IsCreatureGUID = DBM.IsCreatureGUID
bossModPrototype.GetUnitIdFromCID = DBM.GetUnitIdFromCID
bossModPrototype.GetUnitIdFromGUID = DBM.GetUnitIdFromGUID
bossModPrototype.CheckNearby = DBM.CheckNearby
bossModPrototype.IsTrivial = DBM.IsTrivial
bossModPrototype.GetGossipID = DBM.GetGossipID
bossModPrototype.SelectMatchingGossip = DBM.SelectMatchingGossip
bossModPrototype.SelectGossip = DBM.SelectGossip

do
	local TargetScanning = private:GetModule("TargetScanning")

	function bossModPrototype:GetBossTarget(...)
		return TargetScanning:GetBossTarget(self, ...)
	end

	function bossModPrototype:BossTargetScannerAbort(...)
		return TargetScanning:BossTargetScannerAbort(self, ...)
	end

	function bossModPrototype:BossUnitTargetScannerAbort(...)
		return TargetScanning:BossUnitTargetScannerAbort(self, ...)
	end

	function bossModPrototype:BossUnitTargetScanner(...)
		return TargetScanning:BossUnitTargetScanner(self, ...)
	end

	function bossModPrototype:BossTargetScanner(...)
		return TargetScanning:BossTargetScanner(self, ...)
	end

	function bossModPrototype:StartRepeatedScan(...)
		return TargetScanning:StartRepeatedScan(self, ...)
	end

	function bossModPrototype:StopRepeatedScan(...)
		return TargetScanning:StopRepeatedScan(...)--self/bossModPrototype missing not a bug, function doesn't need it
	end
end

do
	local bossCache = {}
	local lastTank

	function bossModPrototype:GetCurrentTank(cidOrGuid)
		if lastTank and GetTime() - (bossCache[cidOrGuid] or 0) < 2 then -- return last tank within 2 seconds of call
			return lastTank
		else
			cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for GetCurrentTank we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId .. i
					local tanking, status = UnitDetailedThreatSituation(id, mobuId)--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
					if tanking or (status == 3) then uId = id end--Found highest threat target, make them uId
					if uId then break end
				end
				--Did not get anything useful from threat, so use who the boss was looking at, at time of cast (ie fallbackuId)
				if fallbackuId and not uId then
					uId = fallbackuId
				end
			end
			if uId then--Now we have a valid uId
				bossCache[cidOrGuid] = GetTime()
				lastTank = UnitName(uId)
				return lastTank, uId
			end
			return false
		end
	end
end

--Now this function works perfectly. But have some limitation due to DBM.RangeCheck:GetDistance() function.
--Unfortunely, DBM.RangeCheck:GetDistance() function cannot reflects altitude difference. This makes range unreliable.
--So, we need to cafefully check range in difference altitude (Especially, tower top and bottom)
do
	local rangeCache = {}
	local rangeUpdated = {}

	function bossModPrototype:CheckBossDistance(cidOrGuid, onlyBoss, itemId, distance, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		cidOrGuid = cidOrGuid or self.creatureId
		local uId
		if type(cidOrGuid) == "number" then--CID passed
			uId = DBM:GetUnitIdFromCID(cidOrGuid, onlyBoss)
		else--GUID
			uId = DBM:GetUnitIdFromGUID(cidOrGuid, onlyBoss)
		end
		if uId then
			if not UnitIsFriend("player", uId) then--API only allowed on hostile unit
				itemId = itemId or 32698
				--/dump IsItemInRange(32698, "target")
				local inRange = IsItemInRange(itemId, uId)
				if inRange ~= nil then--IsItemInRange was a success if it returned true or false, if it failed it returns nil
					return inRange
				else--IsItemInRange doesn't work on all bosses/npcs, but tank checks do
					DBM:Debug("CheckBossDistance failed on IsItemInRange due to bad check/unitId: " .. cidOrGuid, 2)
					return self:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)--Return tank distance check fallback
				end
			else--Non hostile, immediately forward to very gimped TankDistance check (43 yards within tank target)
				DBM:Debug("CheckBossDistance failed on IsItemInRange due to friendly unit: " .. cidOrGuid, 2)
				return self:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)--Return tank distance check fallback
			end
		end
		DBM:Debug("CheckBossDistance failed on uId for: " .. cidOrGuid, 2)
		return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire
	end

	--This is still restricted because it uses friendly api, which isn't available to us in combat
	function bossModPrototype:CheckTankDistance(cidOrGuid, _, onlyBoss, defaultReturn)--distance
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		--distance = distance or 43--Basically unused
		if rangeCache[cidOrGuid] and (GetTime() - (rangeUpdated[cidOrGuid] or 0)) < 2 then -- return same range within 2 sec call
			return rangeCache[cidOrGuid]
		else
			cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid, onlyBoss)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for CheckTankDistance we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId .. i
					local tanking, status = UnitDetailedThreatSituation(id, mobuId)--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
					if tanking or (status == 3) then uId = id end--Found highest threat target, make them uId
					if uId then break end
				end
				--Did not get anything useful from threat, so use who the boss was looking at, at time of cast (ie fallbackuId)
				if fallbackuId and not uId then
					uId = fallbackuId
				end
			end
			if uId then--Now we have a valid uId
				if UnitIsUnit(uId, "player") then return true end--If "player" is target, avoid doing any complicated stuff
				if not UnitIsPlayer(uId) then
					local inRange2, checkedRange = UnitInRange(uId)--43
					if checkedRange then--checkedRange only returns true if api worked, so if we get false, true then we are not near npc
						rangeCache[cidOrGuid] = inRange2
						return inRange2
					else--Its probably a totem or just something we can't assess. Fall back to no filtering
						rangeCache[cidOrGuid] = true
						return true
					end
				end
				--Return true as safety
				rangeCache[cidOrGuid] = true
				return true
			end
			DBM:Debug("CheckTankDistance failed on uId for: " .. cidOrGuid, 2)
			return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire. But some spells will prefer not to fire(i.e : Galakras tower spell), we can define it on this function calling.
		end
	end
end

---------------------
--  Class Methods  --
---------------------
do
	--[[function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		local flags = {strsplit("|", flag)}
		for i = 1, #flags do
			local flagText = flags[i]
			flagText = flagText:gsub("-", "")
			if not specFlags[flagText] then
				print("bad flag found : " .. flagText)
			end
		end
		self:GetRoleFlagValue2(flag)
	end]]

	--to check flag is correct, remove comment block specFlags table and GetRoleFlagValue function, change this to GetRoleFlagValue2
	--disable flag check normally because double flag check comsumes more cpu on mod load.
	function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		local flags = {strsplit("|", flag)}
		for i = 1, #flags do
			local flagText = flags[i]
			if flagText:match("^-") then
				flagText = flagText:gsub("-", "")
				if not private.specRoleTable[currentSpecID][flagText] then
					return true
				end
			elseif private.specRoleTable[currentSpecID][flagText] then
				return true
			end
		end
		return false
	end

	function bossModPrototype:IsMeleeDps(uId)
		if uId then--This version includes ONLY melee dps
			local name = GetUnitName(uId, true)
			--First we check if we have acccess to specID (ie remote player is using DBM or Bigwigs)
			if isRetail and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["MeleeDps"]
			else
				--Role checks are second best thing
				local role = UnitGroupRolesAssigned(uId)
				if isRetail and (role == "HEALER" or role == "TANK") or GetPartyAssignment("MAINTANK", uId, true) then--Auto filter healer/tank from dps check, can't filter healers in classic
					return false
				end
				--Class checks for things that are a sure thing anywyas
				local _, class = UnitClass(uId)
				if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" or class == "DEMONHUNTER" then
					return true
				end
				--Now we do the ugly checks thanks to Inspect throttle
				if class == "DRUID" or class == "SHAMAN" or class == "PALADIN" or class == "MONK" then
					local unitMaxPower = UnitPowerMax(uId)
					if not isRetail and unitMaxPower < 7500 then
						return true
					end
					local powerType = UnitPowerType(uId)
					local altPowerType = UnitPower(uId, 8)--Additional check for balance druids shapeshifted into bear/cat but may still have > 0 lunar power
					--Healers all have 50k mana at 60, dps have 10k mana, plus healers still filtered by role check too
					--Tanks are already filtered out by role check
					--Maelstrom and Lunar power filtered out because they'd also return less than 11000 power (they'd both be 100)
					--feral druids, enhance shamans, windwalker monks, ret paladins should all be caught by less than 11000 power checks after filters
					if powerType ~= 11 and powerType ~= 8 and altPowerType == 0 and unitMaxPower < 11000 then--Maelstrom and Lunar power filters
						return true
					end
				end
			end
			return false
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["MeleeDps"]
	end

	function DBM:IsMelee(uId, mechanical)--mechanical arg means the check is asking if boss mechanics consider them melee (even if they aren't, such as holy paladin/mistweaver monks)
		if uId then--This version includes monk healers as melee and tanks as melee
			--Class checks performed first due to mechanical check needing to be broader than a specID check
			local _, class = UnitClass(uId)
			--In mechanical check, ALL paladins are melee so don't need anything fancy, as for rest of classes here, same deal
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" or class == "MONK" or class == "DEMONHUNTER" or (mechanical and class == "PALADIN") then
				return true
			end
			--Now we check if we have acccess to specID (ie remote player is using DBM or Bigwigs)
			local name = GetUnitName(uId, true)
			if isRetail and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["Melee"]
			else
				--Now we do the ugly checks thanks to Inspect throttle
				if (class == "DRUID" or class == "SHAMAN" or class == "PALADIN") then
					local unitMaxPower = UnitPowerMax(uId)
					if not isRetail and unitMaxPower < 7500 then
						return true
					end
					local powerType = UnitPowerType(uId)
					local altPowerType = UnitPower(uId, 8)--Additional check for balance druids shapeshifted into bear/cat but may still have > 0 lunar power
					--Hunters are now all flagged ranged because it's no longer possible to tell a survival hunter from marksman. neither will be using a pet and both have 100 focus.
					--Druids without lunar poewr or 50k mana are either feral or guardian
					--Shamans without maelstrom and 50k mana can only be enhancement
					--Paladins without 50k mana can only be prot or ret
					if powerType ~= 11 and powerType ~= 8 and altPowerType == 0 and unitMaxPower < 11000 then--Maelstrom and Lunar power filters
						return true
					end
				end
			end
			return false
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["Melee"]
	end
	bossModPrototype.IsMelee = DBM.IsMelee

	function DBM:IsRanged(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if isRetail and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["Ranged"]
			else
				print("bossModPrototype:IsRanged should not be called on external units if specID is unavailable, report this message")
			end
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["Ranged"]
	end
	bossModPrototype.IsRanged = DBM.IsRanged

	function bossModPrototype:IsSpellCaster(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if isRetail and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["SpellCaster"]
			else
				print("bossModPrototype:IsSpellCaster should not be called on external units if specID is unavailable, report this message")
			end
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["SpellCaster"]
	end

	function bossModPrototype:IsMagicDispeller(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if isRetail and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["MagicDispeller"]
			else
				print("bossModPrototype:IsMagicDispeller should not be called on external units if specID is unavailable, report this message")
			end
		end
		--Personal check Only
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["MagicDispeller"]
	end

	---------------------
	--  Sort Methods  --
	---------------------
	function DBM.SortByGroup(v1, v2)
		return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
	end
	function DBM.SortByTankAlpha(v1, v2)
		--Tank > Melee > Ranged prio, and if two of any of types, alphabetical names are preferred
		if DBM:IsTanking(v1) == DBM:IsTanking(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is tank and one isn't, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
			return true
		elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
			return false
		elseif DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByTankRoster(v1, v2)
		--Tank > Melee > Ranged prio, and if two of any of types, roster index as secondary
		if DBM:IsTanking(v1) == DBM:IsTanking(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsTanking(v1) and not DBM:IsTanking(v2) then
			return true
		elseif DBM:IsTanking(v2) and not DBM:IsTanking(v1) then
			return false
		elseif DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByMeleeAlpha(v1, v2)
		--if both are melee, the return values are equal and we use alpha sort
		--if both are ranged, the return values are equal and we use alpha sort
		if DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByMeleeRoster(v1, v2)
		--if both are melee, the return values are equal and we use raid roster index sort
		--if both are ranged, the return values are equal and we use raid roster index sort
		if DBM:IsMelee(v1) == DBM:IsMelee(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsMelee(v1) and not DBM:IsMelee(v2) then
			return true
		elseif DBM:IsMelee(v2) and not DBM:IsMelee(v1) then
			return false
		end
	end
	function DBM.SortByRangedAlpha(v1, v2)
		--if both are melee, the return values are equal and we use alpha sort
		--if both are ranged, the return values are equal and we use alpha sort
		if DBM:IsRanged(v1) == DBM:IsRanged(v2) then
			return DBM:GetUnitFullName(v1) < DBM:GetUnitFullName(v2)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsRanged(v1) and not DBM:IsRanged(v2) then
			return true
		elseif DBM:IsRanged(v2) and not DBM:IsRanged(v1) then
			return false
		end
	end
	function DBM.SortByRangedRoster(v1, v2)
		--if both are melee, the return values are equal and we use raid roster index sort
		--if both are ranged, the return values are equal and we use raid roster index sort
		if DBM:IsRanged(v1) == DBM:IsRanged(v2) then
			return DBM:GetGroupId(DBM:GetUnitFullName(v1), true) < DBM:GetGroupId(DBM:GetUnitFullName(v2), true)
		--if one is melee and one is ranged, they are not equal so it goes to the below elseifs that prio melee
		elseif DBM:IsRanged(v1) and not DBM:IsRanged(v2) then
			return true
		elseif DBM:IsRanged(v2) and not DBM:IsRanged(v1) then
			return false
		end
	end
end

function bossModPrototype:UnitClass(uId)
	if uId then--Return unit requested
		local _, class = UnitClass(uId)
		return class
	end
	return playerClass--else return "player"
end

-- if we catch someone in a tank stance keep sending them warnings, classic only
local playerIsTank = false

function bossModPrototype:IsTank()
	--IsTanking already handles external calls, no need here.
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	if not isRetail then
		if private.specRoleTable[currentSpecID]["Tank"] then
			-- 17 defensive stance, 5487 bear form, 9634 dire bear, 25780 righteous fury
			if playerIsTank or GetShapeshiftFormID() == 18 or DBM:UnitBuff('player', 5487, 9634) then
				playerIsTank = true
				return true
			end
		end
		return false
	end
	local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	return role == "TANK"
end

function bossModPrototype:IsDps(uId)
	if uId then--External unit call.
		--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
		return isRetail and UnitGroupRolesAssigned(uId) == "DAMAGER" or not GetPartyAssignment("MAINTANK", uId, true)
	end
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	if not isRetail then
		return private.specRoleTable[currentSpecID]["Dps"]
	end
	local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	return role == "DAMAGER"
end

function DBM:IsHealer(uId)
	if uId then--External unit call.
		if not isRetail then
			print("bossModPrototype:IsHealer should not be called in classic, report this message")
			return false
		end
		--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
		return UnitGroupRolesAssigned(uId) == "HEALER"
	end
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	if not isRetail then
		if private.specRoleTable[currentSpecID]["Healer"] then
			if playerClass == "DRUID" then
				-- not in form (moonkin for balance, cat/bear for ferals)
				return GetShapeshiftFormID() == nil
			end
			return true
		end
		return false
	end
	local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	return role == "HEALER"
end
bossModPrototype.IsHealer = DBM.IsHealer

function DBM:IsTanking(playerUnitID, enemyUnitID, isName, onlyRequested, enemyGUID, includeTarget, onlyS3)
	--Didn't have playerUnitID so combat log name was passed
	if isName then
		playerUnitID = DBM:GetRaidUnitId(playerUnitID)
	end
	if not playerUnitID then
		DBM:Debug("IsTanking passed with invalid unit", 2)
		return false
	end
	--If we don't know enemy unit token, but know it's GUID
	if not enemyUnitID and enemyGUID then
		enemyUnitID = DBM:GetUnitIdFromGUID(enemyGUID)
	end

	--Threat/Tanking Checks
	--We have both units. No need to find unitID
	if enemyUnitID then
		--Check threat first
		local tanking, status = UnitDetailedThreatSituation(playerUnitID, enemyUnitID)
		if (not onlyS3 and tanking) or (status == 3) then
			return true
		end
		--Non threat fallback
		if includeTarget and UnitExists(enemyUnitID .. "target") then
			if UnitIsUnit(playerUnitID, enemyUnitID .. "target") then
				return true
			end
		end
	end
	--if onlyRequested is false/nil, it means we also accept anyone that's a tank role or tanking any boss unit
	if not onlyRequested then
		--Use these as fallback if threat target not found
		if GetPartyAssignment("MAINTANK", playerUnitID, true) then
			return true
		end
		if not isClassic and not isBCC then--Allow boss checks in wrath and later
			--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
			if UnitGroupRolesAssigned and UnitGroupRolesAssigned(playerUnitID) == "TANK" then
				return true
			end
			for i = 1, 10 do
				local unitID = "boss" .. i
				local guid = UnitGUID(unitID)
				--No GUID, any unit having threat returns true, GUID, only specific unit matching guid
				if not enemyGUID or (guid and guid == enemyGUID) then
					--Check threat first
					local tanking, status = UnitDetailedThreatSituation(playerUnitID, unitID)
					if (not onlyS3 and tanking) or (status == 3) then
						return true
					end
					--Non threat fallback
					if includeTarget and UnitExists(unitID .. "target") then
						if UnitIsUnit(playerUnitID, unitID .. "target") then
							return true
						end
					end
				end
			end
		end
	end
	return false
end
bossModPrototype.IsTanking = DBM.IsTanking

function bossModPrototype:GetNumAliveTanks()
	if not IsInGroup() then return 1 end--Solo raid, you're the "tank"
	local count = 0
	local uId = (IsInRaid() and "raid") or "party"
	for i = 1, DBM:GetNumRealGroupMembers() do
		if (isRetail and UnitGroupRolesAssigned(uId .. i) == "TANK" or GetPartyAssignment("MAINTANK", uId .. i, true)) and not UnitIsDeadOrGhost(uId .. i) then
			count = count + 1
		end
	end
	return count
end

-----------------------
--  Filter Methods  --
-----------------------

do
	local interruptSpells = {
		[1766] = true,--Rogue Kick
		[2139] = true,--Mage Counterspell
		[6552] = true,--Warrior Pummel
		[15487] = true,--Priest Silence
		[19647] = true,--Warlock pet Spell Lock
		[47528] = true,--Death Knight Mind Freeze
		[57994] = true,--Shaman Wind Shear
		[78675] = true,--Druid Solar Beam
		[89766] = true,--Warlock Pet Axe Toss
		[96231] = true,--Paldin Rebuke
		[106839] = true,--Druid Skull Bash
		[116705] = true,--Monk Spear Hand Strike
		[147362] = true,--Hunter Countershot
		[183752] = true,--Demon hunter Disrupt
--		[202137] = true,--Demon Hunter Sigil of Silence (Not uncommented because CheckInterruptFilter doesn't properly handle dual interrupts for single class yet)
		[351338] = true,--Evoker Quell
	}
	--checkOnlyTandF param is used when CheckInterruptFilter is actually being used for a simpe target/focus check and nothing more.
	--checkCooldown should always be passed true except for special rotations like count warnings when you should be alerted it's your turn even if you dropped ball and put it on CD at wrong time
	--ignoreTandF is passed usually when interrupt is on a main boss or event that is global to entire raid and should always be alerted regardless of targetting.
	function bossModPrototype:CheckInterruptFilter(sourceGUID, checkOnlyTandF, checkCooldown, ignoreTandF)
		--Check healer spec filter
		if self:IsHealer() and (self.isTrashMod and DBM.Options.FilterTInterruptHealer or not self.isTrashMod and DBM.Options.FilterBInterruptHealer) then
			return false
		end

		--Check if cooldown check is required
		if checkCooldown and (self.isTrashMod and DBM.Options.FilterTInterruptCooldown or not self.isTrashMod and DBM.Options.FilterBInterruptCooldown) then
			for spellID, _ in pairs(interruptSpells) do
				--For an inverse check, don't need to check if it's known, if it's on cooldown it's known
				--This is possible since no class has 2 interrupt spells (well, actual interrupt spells)
				if (GetSpellCooldown(spellID)) ~= 0 then--Spell is on cooldown
					return false
				end
			end
		end

		local unitID
		if UnitGUID("target") == sourceGUID then
			unitID = "target"
		elseif not isClassic and (UnitGUID("focus") == sourceGUID) then
			unitID = "focus"
		elseif isRetail and (UnitGUID("softenemy") == sourceGUID) then
			unitID = "softenemy"
		end
		--Check if target/focus is required (or if checkOnlyTandF is used, meaning this isn't actually an interrupt API check)
		if checkOnlyTandF or (self.isTrashMod and DBM.Options.FilterTTargetFocus or not self.isTrashMod and DBM.Options.FilterBTargetFocus) then
			--Just return false if source isn't our target or focus, no need to do further checks
			if not ignoreTandF and not unitID then
				return false
			end
		end

		--Check if it's casting something that's not interruptable at the moment
		--needed for torghast since many mobs can have interrupt immunity with same spellIds as other mobs that can be interrupted
		if isRetail and unitID then
			if UnitCastingInfo(unitID) then
				local _, _, _, _, _, _, _, notInterruptible = UnitCastingInfo(unitID)
				if notInterruptible then return false end
			elseif UnitChannelInfo(unitID) then
				local _, _, _, _, _, _, notInterruptible = UnitChannelInfo(unitID)
				if notInterruptible then return false end
			end
		end
		return true
	end
end

do
	--lazyCheck mostly for migration, doesn't distinquish dispel types
	local lazyCheck = {
		[88423] = true,--Druid: Nature's Cure (Dps: Magic only. Healer: Magic, Curse, Poison)
		[2782] = true,--Druid: Remove Corruption (Curse and Poison)
		[115450] = true,--Monk: Detox (Healer) (Magic, Poison, and Disease)
		[218164] = true,--Monk: Detox (non Healer) (Poison and Disease)
		[527] = true,--Priest: Purify (Magic and Disease)
		[213634] = true,--Priest: Purify Disease (Disease)
		[4987] = true,--Paladin: Cleanse ( Dps/Healer: Magic. Healer Only: Poison, Disease)
		[51886] = true,--Shaman: Cleanse Spirit (Curse)
		[77130] = true,--Shaman: Purify Spirit (Magic and Curse)
		[475] = true,--Mage: Remove Curse (Curse)
		[89808] = true,--Warlock: Singe Magic (Magic)
		[360823] = true,--Evoker: Naturalize (Magic and Poison)
		[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
		[365585] = true,--Evoker: Expunge (Poison)
	}
	--Obviously only checks spells releventt for the dispel type
	local typeCheck = {
		["magic"] = {
			[88423] = true,--Druid: Nature's Cure (Dps: Magic only. Healer: Magic, Curse, Poison)
			[115450] = true,--Monk: Detox (Healer) (Magic, Poison, and Disease)
			[527] = true,--Priest: Purify (Magic and Disease)
			[4987] = true,--Paladin: Cleanse ( Dps/Healer: Magic. Healer Only: Poison, Disease)
			[77130] = true,--Shaman: Purify Spirit (Magic and Curse)
			[89808] = true,--Warlock: Singe Magic (Magic)
			[360823] = true,--Evoker: Naturalize (Magic and Poison)
		},
		["curse"] = {
			[88423] = true,--Druid: Nature's Cure (Dps: Magic only. Healer: Magic, Curse, Poison)
			[2782] = true,--Druid: Remove Corruption (Curse and Poison)
			[51886] = true,--Shaman: Cleanse Spirit (Curse)
			[77130] = true,--Shaman: Purify Spirit (Magic and Curse)
			[475] = true,--Mage: Remove Curse (Curse)
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
		},
		["poison"] = {
			[88423] = true,--Druid: Nature's Cure (Dps: Magic only. Healer: Magic, Curse, Poison)
			[2782] = true,--Druid: Remove Corruption (Curse and Poison)
			[115450] = true,--Monk: Detox (Healer) (Magic, Poison, and Disease)
			[218164] = true,--Monk: Detox (non Healer) (Poison and Disease)
			[4987] = true,--Paladin: Cleanse ( Dps/Healer: Magic. Healer Only: Poison, Disease)
			[360823] = true,--Evoker: Naturalize (Magic and Poison)
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
			[365585] = true,--Evoker: Expunge (Poison)
		},
		["disease"] = {
			[115450] = true,--Monk: Detox (Healer) (Magic, Poison, and Disease)
			[218164] = true,--Monk: Detox (non Healer) (Poison and Disease)
			[527] = true,--Priest: Purify (Magic and Disease)
			[213634] = true,--Priest: Purify Disease (Disease)
			[4987] = true,--Paladin: Cleanse ( Dps/Healer: Magic. Healer Only: Poison, Disease)
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
		},
		["bleed"] = {
			[374251] = true,--Evoker: Cauterizing Flame (Bleed, Poison, Curse, and Disease)
		},
	}
	local lastCheck, lastReturn = 0, true
	function bossModPrototype:CheckDispelFilter(dispelType)
		if not DBM.Options.FilterDispel then return true end
		-- Retail - Druid: Nature's Cure (88423), Remove Corruption (2782), Monk: Detox (115450) Monk: Detox (218164), Priest: Purify (527) Priest: Purify Disease (213634), Paladin: Cleanse (4987), Shaman: Cleanse Spirit (51886), Purify Spirit (77130), Mage: Remove Curse (475), Warlock: Singe Magic (89808)
		-- Classic - Druid: Remove Curse (2782), Priest: Purify (527), Paladin: Cleanse (4987), Mage: Remove Curse (475)
		--start, duration, enable = GetSpellCooldown
		--start & duration == 0 if spell not on cd
		if UnitIsDeadOrGhost("player") then return false end--if dead, can't dispel
		if GetTime() - lastCheck < 0.1 then--Recently returned status, return same status to save cpu from aggressive api checks caused by CheckDispelFilter running on multiple raid members getting debuffed at once
			return lastReturn
		end
		if dispelType then
			--Singe magic requires checking if pet is out
			if dispelType == "magic" and (GetSpellCooldown(89808)) == 0 and (UnitExists("pet") and self:GetCIDFromGUID(UnitGUID("pet")) == 416) then
				lastCheck = GetTime()
				lastReturn = true
				return true
			end
			--We cannot do inverse check here because some classes actually have two dispels for same type (such as evoker)
			--Therefor, we can't go false if only one of them are on cooldown. We have to go true of any of them aren't on CD instead
			--As such, we have to check if a spell is known in addition to it not being on cooldown
			for spellID, _ in pairs(typeCheck[dispelType]) do
				if typeCheck[dispelType][spellID] and IsSpellKnown(spellID) and (GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
					lastCheck = GetTime()
					if (spellID == 4987 or spellID == 88423) and not DBM:IsHealer() then--These spellIds can only dispel if healer specced
						lastReturn = false
					else--We trust the table return
						lastReturn = true
					end
					return lastReturn
				end
			end
		else--use lazy check until all mods are migrated to define type
			for spellID, _ in pairs(lazyCheck) do
				if IsSpellKnown(spellID) and (GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
					lastCheck = GetTime()
					lastReturn = true
					return true
				end
			end
		end
		lastCheck = GetTime()
		lastReturn = false
		return false
	end
end

do
	--ccLazyList used for abilities that any CC will break (except root and slow type spells since they don't stop casts)
	--TODO, allow ccType to be multiple. IE "stun,knock,disorient"
	--Spell tables likely missing stuff
	local ccLazyList = {
		[107570] = true,--Warrior: Storm Bolt (Stun)
		[46968] = true,--Warrior: Shockwave (Stun)
		[221562] = true,--DK: Asphyxiate (Stun)
		[179057] = true,--DH: Chaos Nova (Stun)
	}
	local typeCheck = {
		["stun"] = {
			[107570] = true,--Warrior: Storm Bolt (Stun)
			[46968] = true,--Warrior: Shockwave (Stun)
			[221562] = true,--DK: Asphyxiate (Stun)
			[5211] = true,--Druid: Mighty Bash (Stun)
			[408] = true,--Rogue: Kidney Shot (Stun)
			[1833] = true,--Rogue: Cheap Shot (Stun)
			[192058] = true,--Shaman: Capacitor Totem (Stun)
		},
		["knock"] = {
			[132469] = true,--Druid: Typhoon
			--[102793] = true,--Druid: Ursol's Vortex
			[108199] = true,--DK: Gorefiends Grasp
			[49576] = true,--DK: Death Grip (!Also a taunt!)
			[157981] = true,--Mage: Blast Wave
			[51490] = true,--Shaman: Thunderstorm
		},
		["disorient"] = {
			[5246] = true,--Warrior: Intimidating Shout
			[33786] = true,--Druid: Cyclone
			[2094] = true,--Rogue: Blind
			[31661] = true,--Mage: Dragon's Breath
		},
		["incapacitate"] = {
			[99] = true,--Druid: Incapacitating Roar
			[217832] = true,--DH: Imprison
			[118] = true,--Mage: Polymorph (Should be shared CD with all variants, so only need one ID)
			[383121] = true,--Mage: Mass Polymorph
			[197214] = true,--Shaman: Sundering
			[51514] = true,--Shaman: Hex
		},
		["root"] = {
			[339] = true,--Druid: Entangling roots
			[122] = true,--Mage: Frost Nova
			[51485] = true,--Shaman: Earthgrab Totem
		},
		--Many slows are spamable abilities, but can still be used in inverse CD filter
		--Since this filter checks if it's available, not if it isn't
		--So can still also be used as an "Is a slow spell known" check :D
		["slow"] = {
			[1715] = true,--Warrior: Hamstring
			[45524] = true,--DK: Chains of Ice
			[202138] = true,--DH: Sigil of Chains (also a knock?)
			[120] = true,--Mage: Cone of Cold
			[2484] = true,--Shaman: Earthbind Totem
		},
		["sleep"] = {
			[2637] = true,--Druid: Hibernate
		},
	}
	local lastCheck, lastReturn = 0, true
	function bossModPrototype:CheckCCFilter(ccType)
		if not DBM.Options.FilterCrowdControl then return true end
		--start, duration, enable = GetSpellCooldown
		--start & duration == 0 if spell not on cd
		if UnitIsDeadOrGhost("player") then return false end--if dead, can't crowd control
		if GetTime() - lastCheck < 0.1 then--Recently returned status, return same status to save cpu from aggressive api checks caused by CheckCCFilter running from multiple mobs casting at once
			return lastReturn
		end
		if ccType then
			--We cannot do inverse check here because some classes actually have two ccs for same type (such as warrior)
			--Therefor, we can't go false if only one of them are on cooldown. We have to go true of any of them aren't on CD instead
			--As such, we have to check if a spell is known in addition to it not being on cooldown
			for spellID, _ in pairs(typeCheck[ccType]) do
				if typeCheck[ccType][spellID] and IsSpellKnown(spellID) and (GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
					lastCheck = GetTime()
					lastReturn = true
					return lastReturn
				end
			end
		else--use full check since ANY CC works
			for spellID, _ in pairs(ccLazyList) do
				if IsSpellKnown(spellID) and (GetSpellCooldown(spellID)) == 0 then--Spell is known and not on cooldown
					lastCheck = GetTime()
					lastReturn = true
					return true
				end
			end
		end
		lastCheck = GetTime()
		lastReturn = false
		return false
	end
end

----------------------------
--  Boss Health Function  --
----------------------------
--This accepts both CID and GUID which makes switching to UnitPercentHealthFromGUID and UnitTokenFromGUID not as cut and dry
function DBM:GetBossHP(cIdOrGUID, onlyHighest)
	local uId = bossHealthuIdCache[cIdOrGUID] or "target"
	local guid = UnitGUID(uId)
	--Target or Cached (if already called with this cid or GUID before)
	if (self:GetCIDFromGUID(guid) == cIdOrGUID or guid == cIdOrGUID) and UnitHealthMax(uId) ~= 0 then
		if bossHealth[cIdOrGUID] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return bossHealth[cIdOrGUID], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
			bossHealth[cIdOrGUID] = hp
		end
		bossNames[cIdOrGUID] = UnitName(uId)
		return hp, uId, UnitName(uId)
	--Focus, does not exist in classic
	elseif isRetail and ((self:GetCIDFromGUID(UnitGUID("focus")) == cIdOrGUID or UnitGUID("focus") == cIdOrGUID) and UnitHealthMax("focus") ~= 0) then
		if bossHealth[cIdOrGUID] and (UnitHealth("focus") == 0 and not UnitIsDead("focus")) then return bossHealth[cIdOrGUID], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
			bossHealth[cIdOrGUID] = hp
		end
		bossNames[cIdOrGUID] = UnitName("focus")
		return hp, "focus", UnitName("focus")
	else
		--Boss UnitIds
		if isRetail then
			for i = 1, 10 do
				local unitID = "boss" .. i
				local bossguid = UnitGUID(unitID)
				if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitID) ~= 0 then
					if bossHealth[cIdOrGUID] and (UnitHealth(unitID) == 0 and not UnitIsDead(unitID)) then return bossHealth[cIdOrGUID], unitID, UnitName(unitID) end--Return last non 0 value if value is 0, since it's last valid value we had.
					local hp = UnitHealth(unitID) / UnitHealthMax(unitID) * 100
					if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
						bossHealth[cIdOrGUID] = hp
					end
					bossHealthuIdCache[cIdOrGUID] = unitID
					bossNames[cIdOrGUID] = UnitName(unitID)
					return hp, unitID, UnitName(unitID)
				end
			end
		end
		--Scan raid/party target frames
		local idType = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType .. i .. "target"
			local bossguid = UnitGUID(unitId)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitId) ~= 0 then
				if bossHealth[cIdOrGUID] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[cIdOrGUID], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
					bossHealth[cIdOrGUID] = hp
				end
				bossHealthuIdCache[cIdOrGUID] = unitId
				bossNames[cIdOrGUID] = UnitName(unitId)
				return hp, unitId, UnitName(unitId)
			end
		end
		if not isRetail then
			--Scan a few nameplates if we don't have raid boss uIDs, but not worth trying all of them
			for i = 1, 20 do
				local unitId = "nameplate" .. i
				local bossguid = UnitGUID(unitId)
				if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitId) ~= 0 then
					if bossHealth[cIdOrGUID] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[cIdOrGUID], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
					local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
					if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
						bossHealth[cIdOrGUID] = hp
					end
					bossHealthuIdCache[cIdOrGUID] = unitId
					bossNames[cIdOrGUID] = UnitName(unitId)
					return hp, unitId, UnitName(unitId)
				end
			end
		end
	end
end

function DBM:GetBossHPByUnitID(uId)
	if UnitHealthMax(uId) ~= 0 then
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[uId] = hp
		return hp, uId, UnitName(uId)
	end
end

function bossModPrototype:SetMainBossID(cid)
	self.mainBoss = cid
end

function bossModPrototype:SetBossHPInfoToHighest(numBoss)
	if numBoss ~= false then
		self.numBoss = numBoss or (self.multiMobPullDetection and #self.multiMobPullDetection)
	end
	self.highesthealth = true
end

function bossModPrototype:GetHighestBossHealth()
	local hp
	if not self.multiMobPullDetection or self.mainBoss then
		hp = bossHealth[self.mainBoss or self.combatInfo.mob or -1]
		if hp and (hp > 100 or hp <= 0) then
			hp = nil
		end
	else
		for _, mob in ipairs(self.multiMobPullDetection) do
			if (bossHealth[mob] or 0) > (hp or 0) and (bossHealth[mob] or 0) < 100 then-- ignore full health.
				hp = bossHealth[mob]
			end
		end
	end
	return hp
end

function bossModPrototype:GetLowestBossHealth()
	local hp
	if not self.multiMobPullDetection or self.mainBoss then
		hp = bossHealth[self.mainBoss or self.combatInfo.mob or -1]
		if hp and (hp > 100 or hp <= 0) then
			hp = nil
		end
	else
		for _, mob in ipairs(self.multiMobPullDetection) do
			if (bossHealth[mob] or 100) < (hp or 100) and (bossHealth[mob] or 100) > 0 then-- ignore zero health.
				hp = bossHealth[mob]
			end
		end
	end
	return hp
end

bossModPrototype.GetBossHP = DBM.GetBossHP

function DBM:GetCachedBossHealth()
	return bossHealth, bossNames
end

-------------------------
--  Timers Table Util  --
-------------------------
function bossModPrototype:GetFromTimersTable(table, difficultyName, phase, spellId, count)
	local prev = table

	if difficultyName ~= false then
		if not difficultyName or not prev[difficultyName] then
			DBM:Debug("difficultyName is missing from table")
			return
		end
		prev = prev[difficultyName]
	end

	if phase ~= false then
		if not phase or not prev[phase] then
			DBM:Debug("phase is missing from table")
			return
		end
		prev = prev[phase]
	end

	if not prev[spellId] then
		DBM:Debug("spellId is missing from table")
		return
	end
	prev = prev[spellId]

	if count then
		prev = prev[count]
	end

	return prev
end

-----------------------
--  Announce Object  --
-----------------------
---@diagnostic disable: inject-field
do
	local frame = CreateFrame("Frame", "DBMWarning", UIParent)
	local font1u = CreateFrame("Frame", "DBMWarning1Updater", UIParent)
	local font2u = CreateFrame("Frame", "DBMWarning2Updater", UIParent)
	local font3u = CreateFrame("Frame", "DBMWarning3Updater", UIParent)
	local font1 = frame:CreateFontString("DBMWarning1", "OVERLAY", "GameFontNormal")
	font1:SetWidth(1024)
	font1:SetHeight(0)
	font1:SetPoint("TOP", 0, 0)
	local font2 = frame:CreateFontString("DBMWarning2", "OVERLAY", "GameFontNormal")
	font2:SetWidth(1024)
	font2:SetHeight(0)
	font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
	local font3 = frame:CreateFontString("DBMWarning3", "OVERLAY", "GameFontNormal")
	font3:SetWidth(1024)
	font3:SetHeight(0)
	font3:SetPoint("TOP", font2, "BOTTOM", 0, 0)
	frame:SetMovable(true)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen(true)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 300)
	font1u:Hide()
	font2u:Hide()
	font3u:Hide()

	local font1elapsed, font2elapsed, font3elapsed

	local function fontHide1()
		local duration = DBM.Options.WarningDuration2
		if font1elapsed > duration * 1.3 then
			font1u:Hide()
			font1:Hide()
			if frame.font1ticker then
				frame.font1ticker:Cancel()
				frame.font1ticker = nil
			end
		elseif font1elapsed > duration then
			font1elapsed = font1elapsed + 0.05
			local alpha = 1 - (font1elapsed - duration) / (duration * 0.3)
			font1:SetAlpha(alpha > 0 and alpha or 0)
		else
			font1elapsed = font1elapsed + 0.05
			font1:SetAlpha(1)
		end
	end

	local function fontHide2()
		local duration = DBM.Options.WarningDuration2
		if font2elapsed > duration * 1.3 then
			font2u:Hide()
			font2:Hide()
			if frame.font2ticker then
				frame.font2ticker:Cancel()
				frame.font2ticker = nil
			end
		elseif font2elapsed > duration then
			font2elapsed = font2elapsed + 0.05
			local alpha = 1 - (font2elapsed - duration) / (duration * 0.3)
			font2:SetAlpha(alpha > 0 and alpha or 0)
		else
			font2elapsed = font2elapsed + 0.05
			font2:SetAlpha(1)
		end
	end

	local function fontHide3()
		local duration = DBM.Options.WarningDuration2
		if font3elapsed > duration * 1.3 then
			font3u:Hide()
			font3:Hide()
			if frame.font3ticker then
				frame.font3ticker:Cancel()
				frame.font3ticker = nil
			end
		elseif font3elapsed > duration then
			font3elapsed = font3elapsed + 0.05
			local alpha = 1 - (font3elapsed - duration) / (duration * 0.3)
			font3:SetAlpha(alpha > 0 and alpha or 0)
		else
			font3elapsed = font3elapsed + 0.05
			font3:SetAlpha(1)
		end
	end

	font1u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font1.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font1:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font1:SetTextHeight(origSize * (1.5 - (diff - 0.2) * 2.5))
		else
			font1:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	font2u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font2.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font2:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font2:SetTextHeight(origSize * (1.5 - (diff - 0.2) * 2.5))
		else
			font2:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	font3u:SetScript("OnUpdate", function(self)
		local diff = GetTime() - font3.lastUpdate
		local origSize = DBM.Options.WarningFontSize
		if diff > 0.4 then
			font3:SetTextHeight(origSize)
			self:Hide()
		elseif diff > 0.2 then
			font3:SetTextHeight(origSize * (1.5 - (diff - 0.2) * 2.5))
		else
			font3:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	function DBM:UpdateWarningOptions()
		frame:ClearAllPoints()
		frame:SetPoint(self.Options.WarningPoint, UIParent, self.Options.WarningPoint, self.Options.WarningX, self.Options.WarningY)
		local font = self.Options.WarningFont == "standardFont" and standardFont or self.Options.WarningFont
		font1:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font2:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font3:SetFont(font, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		if self.Options.WarningFontShadow then
			font1:SetShadowOffset(1, -1)
			font2:SetShadowOffset(1, -1)
			font3:SetShadowOffset(1, -1)
		else
			font1:SetShadowOffset(0, 0)
			font2:SetShadowOffset(0, 0)
			font3:SetShadowOffset(0, 0)
		end
	end

	function DBM:AddWarning(text, force)
		local added = false
		if not frame.font1ticker then
			font1elapsed = 0
			font1.lastUpdate = GetTime()
			font1:SetText(text)
			font1:Show()
			font1u:Show()
			added = true
			frame.font1ticker = frame.font1ticker or C_TimerNewTicker(0.05, fontHide1)
		elseif not frame.font2ticker then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			font2u:Show()
			added = true
			frame.font2ticker = frame.font2ticker or C_TimerNewTicker(0.05, fontHide2)
		elseif not frame.font3ticker or force then
			font3elapsed = 0
			font3.lastUpdate = GetTime()
			font3:SetText(text)
			font3:Show()
			font3u:Show()
			fontHide3()
			added = true
			frame.font3ticker = frame.font3ticker or C_TimerNewTicker(0.05, fontHide3)
		end
		if not added then
			local prevText1 = font2:GetText()
			local prevText2 = font3:GetText()
			font1:SetText(prevText1)
			font1elapsed = font2elapsed
			font2:SetText(prevText2)
			font2elapsed = font3elapsed
			self:AddWarning(text, true)
		end
	end

	do
		local anchorFrame
		local function moveEnd(self)
			anchorFrame:Hide()
			if anchorFrame.ticker then
				anchorFrame.ticker:Cancel()
				anchorFrame.ticker = nil
			end
			font1elapsed = self.Options.WarningDuration2
			font2elapsed = self.Options.WarningDuration2
			font3elapsed = self.Options.WarningDuration2
			frame:SetFrameStrata("HIGH")
			self:Unschedule(moveEnd)
			DBT:CancelBar(L.MOVE_WARNING_BAR)
		end

		function DBM:MoveWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen(true)
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-Core\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					DBT:CancelBar(L.MOVE_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.WarningPoint = point
					self.Options.WarningX = xOfs
					self.Options.WarningY = yOfs
					self:Schedule(15, moveEnd, self)
					DBT:CreateBar(15, L.MOVE_WARNING_BAR, isRetail and 237538 or 136106)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				anchorFrame:Show()
				anchorFrame.ticker = anchorFrame.ticker or C_TimerNewTicker(5, function() self:AddWarning(L.MOVE_WARNING_MESSAGE) end)
				self:AddWarning(L.MOVE_WARNING_MESSAGE)
				self:Schedule(15, moveEnd, self)
				DBT:CreateBar(15, L.MOVE_WARNING_BAR, isRetail and 237538 or 136106)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local textureCode = " |T%s:12:12|t "
	local textureExp = " |T(%S+......%S+):12:12|t "--Fix texture file including blank not strips(example: Interface\\Icons\\Spell_Frost_Ring of Frost). But this have limitations. Since I'm poor at regular expressions, this is not good fix. Do you have another good regular expression, tandanu?

	---@class Announce
	local announcePrototype = {}
	local mt = {__index = announcePrototype}

	-- TODO: is there a good reason that this is a weak table?
	local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

	local function setText(announceType, spellId, castTime, preWarnTime, customName, originalSpellID)
		local spellName
		if customName then
			spellName = customName
		else
			spellName = parseSpellName(spellId, announceType) or CL.UNKNOWN
		end
		local text
		if announceType == "cast" then
			local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
			local timer = (select(4, DBM:GetSpellInfo(originalSpellID or spellId)) or 1000) / spellHaste
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(preWarnTime or 5)))
			end
		elseif announceType == "stage" or announceType == "prestage" then
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
		elseif announceType == "stagechange" then
			text = L.AUTO_ANNOUNCE_TEXTS.spell
		else
			text = L.AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		return text, spellName
	end

	function announcePrototype:SetText(customName)
		local text, spellName = setText(self.announceType, self.spellId, self.castTime, self.preWarnTime, customName)
		self.text = text
		self.spellName = spellName
	end

	--Not to be confused with SetText, which only sets the text of object.
	--This changes actual ID so announce callback also swaps ID for WAs
	function announcePrototype:UpdateKey(altSpellId)
		self.spellId = altSpellId
		self.icon = parseSpellIcon(altSpellId, self.announceType, self.icon)
		if self.announceType then
			--Regenerate auto localized text if it's an auto localized alert
			local text, spellName = setText(self.announceType, self.spellId, self.castTime, self.preWarnTime)
			self.text = text
			self.spellName = spellName
		else--Just regenerating spellName not message text because it's likely a custom text object such as NewSpecialWarning
			self.spellName = parseSpellName(altSpellId)
		end
	end

	-- TODO: this function is an abomination, it needs to be rewritten. Also: check if these work-arounds are still necessary
	function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
		if not self.option or self.mod.Options[self.option] then
			if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
			if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
			local argTable = {...}
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			if #self.combinedtext > 0 then
				--Throttle spam.
				if DBM.Options.WarningAlphabetical then
					tsort(self.combinedtext)
				end
				local combinedText = tconcat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					combinedText = combinedText .. " " .. L.GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText .. " " .. L.GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
				end
			end
			local announceCount
			if self.announceType and (self.announceType == "count" or self.announceType == "targetcount" or self.announceType == "sooncount" or self.announceType == "incomingcount") then--Don't use find "count" here, it'll match countdown
				--Stage triggers don't pass count, but they do not need to, there is a stage callback and trigger option in WA that should be used
				if type(argTable[1]) == "number" then
					announceCount = argTable[1]
				end
			end
			local message = pformat(self.text, unpack(argTable))
			local text = ("%s%s%s|r%s"):format(
				(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
				colorCode,
				message,
				(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
			)
			self.combinedcount = 0
			self.combinedtext = {}
			if not cachedColorFunctions[self.color] then
				local color = self.color -- upvalue for the function to colorize names, accessing self in the colorize closure is not safe as the color of the announce object might change (it would also prevent the announce from being garbage-collected but announce objects are never destroyed)
				cachedColorFunctions[color] = function(cap)
					cap = cap:sub(2, -2)
					local noStrip = cap:match("noStrip ")
					if not noStrip then
						local name = cap
						local playerClass, playerIcon = DBM:GetRaidClass(name)
						if playerClass ~= "UNKNOWN" then
							cap = DBM:GetShortServerName(cap)--Only run realm strip function if class color was valid (IE it's an actual playername)
						end
						local playerColor = RAID_CLASS_COLORS[playerClass] or color
						if playerColor then
							if playerIcon > 0 and playerIcon <= 8 then
								cap = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(playerIcon) .. ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
							else
								cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
							end
						end
					else
						cap = cap:sub(9)
					end
					return cap
				end
			end
			text = text:gsub(">.-<", cachedColorFunctions[self.color])
			DBM:AddWarning(text)
			if DBM.Options.ShowWarningsInChat then
				if not DBM.Options.WarningIconChat then
					text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size TODO: is this still true as of cataclysm?
				end
				self.mod:AddMsg(text, nil)
			end
			--Message: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: you, target, targetcount, targetsource, spell, ends, endtarget, fades, adds, count, stack, cast, soon, sooncount, prewarn, bait, stage, stagechange, prestage, moveto
			------Personal/Role (Applies to you, or your job): you, stack, bait, moveto, fades
			------General Target Messages (informative, doesn't usually apply to you): target, targetsource, targetcount
			------Fight Changes (Stages, adds, boss buff/debuff, etc): stage, stagechange, prestage, adds, ends, endtarget
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority). BW would call this "emphasized"
			--announceCount: If it's a count announce, this will provide access to the number value of that count. This, along with spellId should be used instead of message text scanning for most weak auras that need to target specific count casts
			fireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false, announceCount)
			if self.sound > 0 then--0 means muted, 1 means no voice pack support, 2 means voice pack version/support
				if self.sound > 1 and DBM.Options.ChosenVoicePack2 ~= "None" and DBM.Options.VPReplacesAnnounce and not voiceSessionDisabled and not DBM.Options.VPDontMuteSounds and self.sound <= SWFilterDisabled then return end
				if not self.option or self.mod.Options[self.option .. "SWSound"] ~= "None" then
					DBM:PlaySoundFile(DBM.Options.RaidWarningSound, nil, true)--Validate true
				end
			end
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	--Object that's used when precision isn't possible (number of targets variable or unknown
	function announcePrototype:CombinedShow(delay, ...)
		if self.option and not self.mod.Options[self.option] then return end
		if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 7 then--Throttle spam. We may not need more than 6 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBMScheduler:Unschedule(self.Show, self.mod, self)
		DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	--New object that allows defining count instead of scheduling for more efficient and immediate warnings when precise count is known
	function announcePrototype:PreciseShow(maxTotal, ...)
		if self.option and not self.mod.Options[self.option] then return end
		if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 7 then--Throttle spam. We may not need more than 6 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBMScheduler:Unschedule(self.Show, self.mod, self)
		local viableTotal = DBM:NumRealAlivePlayers()
		if (maxTotal == #self.combinedtext) or (viableTotal == #self.combinedtext) then--All targets gathered, show immediately
			self:Show(...)--Does this need self or mod? will it have this bug? https://github.com/DeadlyBossMods/DBM-Unified/issues/153
		else--And even still, use scheduling backup in case counts still fail
			DBMScheduler:Schedule(1.2, self.Show, self.mod, self, ...)
		end
	end

	function announcePrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Countdown(time, numAnnounces, ...)
		DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		return DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
	end

	function announcePrototype:Play(name, customPath)
		local voice = DBM.Options.ChosenVoicePack2
		if voiceSessionDisabled or voice == "None" or not DBM.Options.VPReplacesAnnounce then return end
		local always = DBM.Options.AlwaysPlayVoice
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter and not always then return end--don't show announces that are generic target announces
		if (not DBM.Options.DontShowBossAnnounces and (not self.option or self.mod.Options[self.option]) or always) and self.sound <= SWFilterDisabled then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			local path = customPath or ("Interface\\AddOns\\DBM-VP" .. voice .. "\\" .. name .. ".ogg")
			DBM:PlaySoundFile(path)
		end
	end

	function announcePrototype:ScheduleVoice(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
		DBMScheduler:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function announcePrototype:ScheduleVoiceOverLap(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function announcePrototype:CancelVoice(...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" or not DBM.Options.VPReplacesAnnounce then return end
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName, soundOption, spellID, waCustomName)
		if not text then
			error("NewAnnounce: you must provide announce text", 2)
		end
		if type(text) == "number" then
			DBM:Debug("|cffff0000NewAnnounce: Non auto localized text cannot be numbers, fix this for |r" .. text)
		end
		if type(optionName) == "number" then
			DBM:Debug("|cffff0000NewAnnounce: Non auto localized optionNames cannot be numbers, fix this for |r" .. text)
			optionName = nil
		end
		if soundOption and type(soundOption) == "boolean" then
			soundOption = 0--No Sound
		end
		icon = parseSpellIcon(icon)
		---@class Announce
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				sound = soundOption or 1,
				mod = self,
				icon = icon,
				spellId = spellID,--For WeakAuras / other callbacks
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellID, nil, waCustomName)
		elseif optionName ~= false then
			obj.option = text
			self:AddBoolOption(obj.option, optionDefault, "announce", nil, nil, nil, spellID, nil, waCustomName)
		end
		tinsert(self.announces, obj)
		return obj
	end

	-- new constructor (partially auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		if not spellId then
			error("newAnnounce: you must provide spellId", 2)
		end
		local optionVersion, alternateSpellId
		if type(optionName) == "number" then
			if optionName > 10 then--Being used as spell name shortening
				if DBM.Options.WarningShortText then
					alternateSpellId = optionName
				end
			else--Being used as option version
				optionVersion = optionName
			end
			optionName = nil
		end
		if soundOption and type(soundOption) == "boolean" then
			soundOption = 0--No Sound
		end
		local text, spellName = setText(announceType, alternateSpellId or spellId, castTime, preWarnTime, nil, spellId)
		icon = parseSpellIcon(icon or spellId)
		---@class Announce
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				mod = self,
				icon = icon,
				sound = soundOption or 1,
				type = announceType,
				spellId = spellId,
				spellName = spellName,
				noFilter = noFilter,
				castTime = castTime,
				preWarnTime = preWarnTime,
			},
			mt
		)
		local catType = "announce"--Default to General announce
		if not self.NoSortAnnounce then--ALL announce objects will be assigned "announce", usually for mods that sort by phase instead
			--Change if Personal or Other
			if announceType == "target" or announceType == "targetcount" or announceType == "stack" then
				catType = "announceother"
			end
		end
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, catType, nil, nil, nil, spellId, announceType)
		elseif optionName ~= false then
			obj.option = catType .. spellId .. announceType .. (optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, catType, nil, nil, nil, spellId, announceType)
			if noFilter and announceType == "target" then
				self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS["targetNF"]:format(spellId)
			else
				self.localization.options[obj.option] = L.AUTO_ANNOUNCE_OPTIONS[announceType]:format(spellId)
			end
		end
		tinsert(self.announces, obj)
		return obj
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewYouAnnounce(spellId, color, ...)
		return newAnnounce(self, "you", spellId, color or 1, ...)
	end

	function bossModPrototype:NewTargetNoFilterAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption) -- spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter
		return newAnnounce(self, "target", spellId, color or 3, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, true)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 3, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewTargetSourceAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetsource", spellId, color or 3, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcount", spellId, color or 3, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewIncomingAnnounce(spellId, color, ...)
		return newAnnounce(self, "incoming", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewIncomingCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "incomingcount", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewEndAnnounce(spellId, color, ...)
		return newAnnounce(self, "ends", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewEndTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "endtarget", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewFadesAnnounce(spellId, color, ...)
		return newAnnounce(self, "fades", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewAddsLeftAnnounce(spellId, color, ...)
		return newAnnounce(self, "addsleft", spellId, color or 3, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "count", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewStackAnnounce(spellId, color, ...)
		return newAnnounce(self, "stack", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName, _, soundOption) -- spellId, color, castTime, icon, optionDefault, optionName, noArg, soundOption
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime, nil, soundOption)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 2, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewSoonCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "sooncount", spellId, color or 2, ...)
	end

	--This object disables sounds, it's almost always used in combation with a countdown timer. Even if not a countdown, its a text only spam not a sound spam
	function bossModPrototype:NewCountdownAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, _, noFilter) -- spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter
		return newAnnounce(self, "countdown", spellId, color or 4, icon, optionDefault, optionName, castTime, preWarnTime, 0, noFilter)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName, _, soundOption) -- spellId, time, color, icon, optionDefault, optionName, noArg, soundOption
		return newAnnounce(self, "prewarn", spellId, color or 2, icon, optionDefault, optionName, nil, time, soundOption)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewBaitAnnounce(spellId, color, ...)
		return newAnnounce(self, "bait", spellId, color or 3, ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewPhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "stage", stage, color or 2, icon or "136116", ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewPhaseChangeAnnounce(color, icon, ...)
		return newAnnounce(self, "stagechange", 0, color or 2, icon or "136116", ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewPrePhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "prestage", stage, color or 2, icon or "136116", ...)
	end

	---@overload fun(self, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter): Announce
	function bossModPrototype:NewMoveToAnnounce(spellId, color, ...)
		return newAnnounce(self, "moveto", spellId, color or 3, ...)
	end
end

--------------------
--  Yell Object  --
--------------------
do
	---@class Yell
	local yellPrototype = {}
	local mt = {__index = yellPrototype}
	local voidForm = GetSpellInfo(194249)

	local function newYell(self, yellType, spellId, yellText, optionDefault, optionName, chatType)
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
		end
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local displayText
		if not yellText then
			if type(spellId) == "string" and spellId:match("ej%d+") then--Old Format Journal
				displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:EJ_GetSectionInfo(string.sub(spellId, 3)) or CL.UNKNOWN)
			elseif type(spellId) == "number" then
				if spellId < 0 then--New format Journal
					spellId = -spellId
					displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:EJ_GetSectionInfo(spellId) or CL.UNKNOWN)
				else
					displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(spellId) or CL.UNKNOWN)
				end
			else
				displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(CL.UNKNOWN)
			end
		end
		--Passed spellid as yellText.
		--Auto localize spelltext using yellText instead
		if yellText and type(yellText) == "number" then
			displayText = L.AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(yellText) or CL.UNKNOWN)
		end
		---@class Yell
		local obj = setmetatable(
			{
				spellId = spellId,
				text = displayText or yellText,
				mod = self,
				chatType = chatType,
				yellType = yellType
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "yell", nil, nil, nil, spellId, yellType)
		elseif optionName ~= false then
			obj.option = "Yell" .. (spellId or yellText) .. (yellType ~= "yell" and yellType or "") .. (optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "yell", nil, nil, nil, spellId, yellType)
			self.localization.options[obj.option] = L.AUTO_YELL_OPTION_TEXT[yellType]:format(spellId)
		end
		return obj
	end

	--Standard "Yell" object that will use SAY/YELL based on what's defined in the object (Defaulting to SAY if nil)
	--I realize object being :Yell is counter intuitive to default being "SAY" but for many years the default was YELL and it's too many years of mods to change now
	function yellPrototype:Yell(...)
		if not IsInInstance() then--as of 8.2.5+, forbidden in outdoor world
			DBM:Debug("WARNING: A mod is still trying to call chat SAY/YELL messages outdoors, FIXME")
			return
		end
		if DBM.Options.DontSendYells or private.chatBubblesDisabled or self.yellType and self.yellType == "position" and (not isRetail or DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay) then return end
		if not self.option or self.mod.Options[self.option] then
			if self.yellType == "combo" then
				SendChatMessage(pformat(self.text, ...), self.chatType or "YELL")
			else
				SendChatMessage(pformat(self.text, ...), self.chatType or "SAY")
			end
		end
	end
	yellPrototype.Show = yellPrototype.Yell

	--Force override to use say message, even when object defines "YELL"
	function yellPrototype:Say(...)
		if not IsInInstance() then--as of 8.2.5+, forbidden in outdoor world
			DBM:Debug("WARNING: A mod is still trying to call chat SAY/YELL messages outdoors, FIXME")
			return
		end
		if DBM.Options.DontSendYells or private.chatBubblesDisabled or self.yellType and self.yellType == "position" and (not isRetail or DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay) then return end
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(pformat(self.text, ...), "SAY")
		end
	end

	function yellPrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Yell, self.mod, self, ...)
	end

	--Standard schedule object to schedule a say/yell based on what's defined in object
	function yellPrototype:Countdown(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime - GetTime()
				DBMScheduler:ScheduleCountdown(remaining, numAnnounces, self.Yell, self.mod, self, ...)
			end
		else
			DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Yell, self.mod, self, ...)
		end
	end

	--Scheduled Force override to use SAY message, even when object defines "YELL"
	function yellPrototype:CountdownSay(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime - GetTime()
				DBMScheduler:ScheduleCountdown(remaining, numAnnounces, self.Say, self.mod, self, ...)
			end
		else
			DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Say, self.mod, self, ...)
		end
	end

	function yellPrototype:Cancel(...)
		return DBMScheduler:Unschedule(self.Yell, self.mod, self, ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewYell(...)
		return newYell(self, "yell", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewShortYell(...)
		return newYell(self, "shortyell", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewCountYell(...)
		return newYell(self, "count", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewFadesYell(...)
		return newYell(self, "fade", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewShortFadesYell(...)
		return newYell(self, "shortfade", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewIconFadesYell(...)
		return newYell(self, "iconfade", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewPosYell(...)
		return newYell(self, "position", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewShortPosYell(...)
		return newYell(self, "shortposition", ...)
	end

	---@overload fun(self: DBMMod, self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewComboYell(...)
		return newYell(self, "combo", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewPlayerRepeatYell(...)
		return newYell(self, "repeatplayer", ...)
	end

	---@overload fun(self: DBMMod, spellId, yellText, optionDefault, optionName, chatType): Yell
	function bossModPrototype:NewIconRepeatYell(...)
		return newYell(self, "repeaticon", ...)
	end
end

------------------------------
--  Special Warning Object  --
------------------------------
do
	local frame = CreateFrame("Frame", "DBMSpecialWarning", UIParent)
	local font1 = frame:CreateFontString("DBMSpecialWarning1", "OVERLAY", "ZoneTextFont")
	font1:SetWidth(1024)
	font1:SetHeight(0)
	font1:SetPoint("TOP", 0, 0)
	local font2 = frame:CreateFontString("DBMSpecialWarning2", "OVERLAY", "ZoneTextFont")
	font2:SetWidth(1024)
	font2:SetHeight(0)
	font2:SetPoint("TOP", font1, "BOTTOM", 0, 0)
	frame:SetMovable(true)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen(true)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)

	local font1elapsed, font2elapsed, moving

	local function fontHide1()
		local duration = DBM.Options.SpecialWarningDuration2
		if font1elapsed > duration * 1.3 then
			font1:Hide()
			if frame.font1ticker then
				frame.font1ticker:Cancel()
				frame.font1ticker = nil
			end
		elseif font1elapsed > duration then
			font1elapsed = font1elapsed + 0.05
			local alpha = 1 - (font1elapsed - duration) / (duration * 0.3)
			font1:SetAlpha(alpha > 0 and alpha or 0)
		else
			font1elapsed = font1elapsed + 0.05
			font1:SetAlpha(1)
		end
	end

	local function fontHide2()
		local duration = DBM.Options.SpecialWarningDuration2
		if font2elapsed > duration * 1.3 then
			font2:Hide()
			if frame.font2ticker then
				frame.font2ticker:Cancel()
				frame.font2ticker = nil
			end
		elseif font2elapsed > duration then
			font2elapsed = font2elapsed + 0.05
			local alpha = 1 - (font2elapsed - duration) / (duration * 0.3)
			font2:SetAlpha(alpha > 0 and alpha or 0)
		else
			font2elapsed = font2elapsed + 0.05
			font2:SetAlpha(1)
		end
	end

	function DBM:UpdateSpecialWarningOptions()
		frame:ClearAllPoints()
		local font = self.Options.SpecialWarningFont == "standardFont" and standardFont or self.Options.SpecialWarningFont
		frame:SetPoint(self.Options.SpecialWarningPoint, UIParent, self.Options.SpecialWarningPoint, self.Options.SpecialWarningX, self.Options.SpecialWarningY)
		font1:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font2:SetFont(font, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font1:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
		font2:SetTextColor(unpack(self.Options.SpecialWarningFontCol))
		if self.Options.SpecialWarningFontShadow then
			font1:SetShadowOffset(1, -1)
			font2:SetShadowOffset(1, -1)
		else
			font1:SetShadowOffset(0, 0)
			font2:SetShadowOffset(0, 0)
		end
	end

	function DBM:AddSpecialWarning(text, force)
		local added = false
		if not frame.font1ticker then
			font1elapsed = 0
			font1.lastUpdate = GetTime()
			font1:SetText(text)
			font1:Show()
			added = true
			frame.font1ticker = frame.font1ticker or C_TimerNewTicker(0.05, fontHide1)
		elseif not frame.font2ticker or force then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			added = true
			frame.font2ticker = frame.font2ticker or C_TimerNewTicker(0.05, fontHide2)
		end
		if not added then
			local prevText1 = font2:GetText()
			font1:SetText(prevText1)
			font1elapsed = font2elapsed
			self:AddSpecialWarning(text, true)
		end
	end

	do
		local anchorFrame
		local function moveEnd(self)
			moving = false
			anchorFrame:Hide()
			font1elapsed = self.Options.SpecialWarningDuration2
			font2elapsed = self.Options.SpecialWarningDuration2
			frame:SetFrameStrata("HIGH")
			self:Unschedule(moveEnd)
			DBT:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
		end

		function DBM:MoveSpecialWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen(true)
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-Core\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					DBT:CancelBar(L.MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.SpecialWarningPoint = point
					self.Options.SpecialWarningX = xOfs
					self.Options.SpecialWarningY = yOfs
					self:Schedule(15, moveEnd, self)
					DBT:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, isRetail and 237538 or 136106)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				moving = true
				anchorFrame:Show()
				self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
				self:AddSpecialWarning(L.MOVE_SPECIAL_WARNING_TEXT)
				self:Schedule(15, moveEnd, self)
				DBT:CreateBar(15, L.MOVE_SPECIAL_WARNING_BAR, isRetail and 237538 or 136106)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	---@class SpecialWarning
	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	local function classColoringFunction(cap)
		cap = cap:sub(2, -2)
		local noStrip = cap:match("noStrip ")
		if not noStrip then
			local name = cap
			local playerClass, playerIcon = DBM:GetRaidClass(name)
			if playerClass ~= "UNKNOWN" then
				cap = DBM:GetShortServerName(cap)--Only run strip code on valid player classes
				if DBM.Options.SWarnClassColor then
					local playerColor = RAID_CLASS_COLORS[playerClass]
					if playerColor then
						if playerIcon > 0 and playerIcon <= 8 then
							cap = ("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t"):format(playerIcon) .. ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
						else
							cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
						end
					end
				end
			end
		else
			cap = cap:sub(9)
		end
		return cap
	end

	local textureCode = " |T%s:12:12|t "

	local specInstructionalRemapTable = {
		["dispel"] = "target",
		["interrupt"] = "spell",
		["interruptcount"] = "count",
		["defensive"] = "spell",
		["taunt"] = "target",
		["soak"] = "spell",
		["soakcount"] = "count",
		["soakpos"] = "spell",
		["switch"] = "spell",
		["switchcount"] = "count",
--		["adds"] = "spell",
--		["addscount"] = "spell",
--		["addscustom"] = "spell",
		["targetchange"] = "target",
		["gtfo"] = "spell",
		["bait"] = "soon",
		["youpos"] = "you",
		["youposcount"] = "youcount",
		["move"] = "spell",
		["keepmove"] = "spell",
		["stopmove"] = "spell",
		["dodge"] = "spell",
		["dodgecount"] = "count",
		["dodgeloc"] = "spell",
		["moveaway"] = "spell",
		["moveawaycount"] = "count",
		["moveto"] = "spell",
		["jump"] = "spell",
		["run"] = "spell",
		["runcount"] = "spell",
		["cast"] = "spell",
		["lookaway"] = "spell",
		["reflect"] = "target",
	}

	local function setText(announceType, spellId, stacks, customName)
		local text, spellName
		if customName then
			spellName = customName
		else
			spellName = parseSpellName(spellId, announceType) or CL.UNKNOWN
		end
		if announceType == "prewarn" then
			if type(stacks) == "string" then
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, stacks)
			else
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, L.SEC_FMT:format(tostring(stacks or 5)))
			end
		else
			if DBM.Options.SpamSpecInformationalOnly then
				local remapType = specInstructionalRemapTable[announceType]
				if remapType then
					local newType = remapType
					text = L.AUTO_SPEC_WARN_TEXTS[newType]:format(spellName)
				else
					text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
				end
			else
				text = L.AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
			end
		end
		return text, spellName
	end

	function specialWarningPrototype:SetText(customName)
		local text, spellName = setText(self.announceType, self.spellId, self.stacks, customName)
		self.text = text
		self.spellName = spellName
	end

	function specialWarningPrototype:UpdateKey(altSpellId)
		self.spellId = altSpellId
		self.icon = parseSpellIcon(altSpellId, self.announceType, self.icon)
		if self.announceType then
			--Regenerate auto localized text if it's an auto localized alert
			local text, spellName = setText(self.announceType, self.spellId, self.stacks)
			self.text = text
			self.spellName = spellName
		else--Just regenerating spellName not message text because it's likely a custom text object such as NewSpecialWarning
			self.spellName = parseSpellName(altSpellId)
		end
	end

	local function canVoiceReplace(self, soundId)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack2 == "None" then
			return false
		end
		soundId = soundId or self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
		local isVoicePackUsed
		if self.announceType == "gtfo" then
			isVoicePackUsed = DBM.Options.VPReplacesGTFO
		elseif type(soundId) == "number" and soundId < 5 then--Value 1-4 are SW1 defaults, otherwise it's file data ID and handled by Custom
			isVoicePackUsed = DBM.Options["VPReplacesSA" .. soundId]
		else
			isVoicePackUsed = DBM.Options.VPReplacesCustom
		end
		return isVoicePackUsed
	end

	local specTypeFilterTable = {
		["dispel"] = "dispel",
		["interrupt"] = "interrupt",
		["interruptcount"] = "interrupt",
		["defensive"] = "defensive",
		["taunt"] = "taunt",
		["soak"] = "soak",
		["soakcount"] = "soak",
		["soakpos"] = "soak",
		["stack"] = "stack",
		["switch"] = "switch",
		["switchcount"] = "switch",
		["adds"] = "switch",
		["addscount"] = "switch",
		["addscustom"] = "switch",
		["targetchange"] = "switch",
		["gtfo"] = "gtfo",
	}

	function specialWarningPrototype:Show(...)
		--Check if option for this warning is even enabled
		if (not self.option or self.mod.Options[self.option]) and not moving and frame then
			--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
			if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
			--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
			if self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 and (self.mod:IsEasyDungeon() or DBM:IsTrivial()) then return end
			--We also check if person has the role filter turned on (typical for highest end raiders who don't want as much handholding from DBM)
			local filterType = specTypeFilterTable[self.announceType]
			if filterType then
				if DBM.Options["SpamSpecRole" .. filterType] then return end
			end
			--Lastly, we check if it's a tank warning and filter if not in tank spec. This is done because tank warnings on by default and handled fluidly by spec, not option setting
			if self.announceType == "taunt" and DBM.Options.FilterTankSpec and not self.mod:IsTank() then return end--Don't tell non tanks to taunt, ever.
			local argTable = {...}
			-- add a default parameter for move away warnings
			if self.announceType == "gtfo" then
				if DBM:UnitBuff("player", 27827) then return end--Don't tell a priest in spirit of redemption form to GTFO, they can't, and they don't take damage from it anyhow
				if #argTable == 0 then
					argTable[1] = L.BAD
				end
			end
			if #self.combinedtext > 0 then
				--Throttle spam.
				if DBM.Options.SWarningAlphabetical then
					tsort(self.combinedtext)
				end
				local combinedText = tconcat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					combinedText = combinedText .. " " .. L.GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText .. " " .. L.GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
				end
			end
			--Grab count for both the callback and the notes feature
			local announceCount
			if self.announceType and self.announceType:find("count") then
				if self.announceType == "interruptcount" then
					announceCount = argTable[2]--Count should be second arg in table
				else
					announceCount = argTable[1]--Count should be first arg in table
				end
				if type(announceCount) == "string" then
					--Probably a hypehnated double count like inferno slice or marked for death
					--This is pretty atypical in newer content cause it's a bit hacky
					local mainCount = string.split("-", announceCount)
					announceCount = tonumber(mainCount)
				end
			end
			local message = pformat(self.text, unpack(argTable))
			local text = ("%s%s%s"):format(
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or "",
				message,
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or ""
			)
			local noteHasName = nil
			if self.option then
				local noteText = self.mod.Options[self.option .. "SWNote"]
				if noteText and type(noteText) == "string" and noteText ~= "" then--Filter false bool and empty strings
					if announceCount then--Counts support different note for EACH count
						local notesTable = {string.split("/", noteText)}
						noteText = notesTable[announceCount]
						if noteText and type(noteText) == "string" and noteText ~= "" then--Refilter after string split to make sure a note for this count exists
							local hasPlayerName = noteText:find(playerName)
							if DBM.Options.SWarnNameInNote and hasPlayerName then
								noteHasName = 5
							end
							--Terminate special warning, it's an interrupt count warning without player name and filter enabled
							if (self.announceType == "interruptcount") and DBM.Options.FilterInterruptNoteName and not hasPlayerName then return end
							noteText = " (" .. noteText .. ")"
							text = text .. noteText
						end
					else--Non count warnings will have one note, period
						if DBM.Options.SWarnNameInNote and noteText:find(playerName) then
							noteHasName = 5
						end
						if self.announceType and not self.announceType:find("switch") then
							noteText = noteText:gsub(">.-<", classColoringFunction)--Class color note text before combining with warning text.
						end
						noteText = " (" .. noteText .. ")"
						text = text .. noteText
					end
				end
			end
			--Text is disabled, suresss text from screen and chat frame
			if not DBM.Options.DontShowSpecialWarningText then
				--No stripping on switch warnings, ever. They will NEVER have player name, but often have adds with "-" in name
				if self.announceType and not self.announceType:find("switch") then
					text = text:gsub(">.-<", classColoringFunction)
				end
				DBM:AddSpecialWarning(text)
				if DBM.Options.ShowSWarningsInChat then
					local colorCode = ("|cff%.2x%.2x%.2x"):format(DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
					self.mod:AddMsg(colorCode .. "[" .. L.MOVE_SPECIAL_WARNING_TEXT .. "] " .. text .. "|r", nil)
				end
			end
			self.combinedcount = 0
			self.combinedtext = {}
			if not UnitIsDeadOrGhost("player") then
				if noteHasName then
					if not DBM.Options.DontShowSpecialWarningFlash and DBM.Options.SpecialWarningFlash5 then--Not included in above if statement on purpose. we don't want to trigger else rule if noteHasName is true but SpecialWarningFlash5 is false
						local repeatCount = DBM.Options.SpecialWarningFlashCount5 or 1
						DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol5[1], DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3], DBM.Options.SpecialWarningFlashDura5, DBM.Options.SpecialWarningFlashAlph5, repeatCount - 1)
					end
					if not DBM.Options.DontDoSpecialWarningVibrate and DBM.Options.SpecialWarningVibrate5 then
						DBM:VibrateController()
					end
				else
					local number = self.flash
					if not DBM.Options.DontShowSpecialWarningFlash and DBM.Options["SpecialWarningFlash" .. number] then
						local repeatCount = DBM.Options["SpecialWarningFlashCount" .. number] or 1
						local flashcolor = DBM.Options["SpecialWarningFlashCol" .. number]
						DBM.Flash:Show(flashcolor[1], flashcolor[2], flashcolor[3], DBM.Options["SpecialWarningFlashDura" .. number], DBM.Options["SpecialWarningFlashAlph" .. number], repeatCount - 1)
					end
					if not DBM.Options.DontDoSpecialWarningVibrate and DBM.Options["SpecialWarningVibrate" .. number] then
						DBM:VibrateController()
					end
				end
			end
			--Text: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: spell, ends, fades, soon, bait, dispel, interrupt, interruptcount, you, youcount, youpos, soakpos, target, targetcount, defensive, taunt, close, move, keepmove, stopmove,
			----gtfo, dodge, dodgecount, dodgeloc, moveaway, moveawaycount, moveto, soak, jump, run, cast, lookaway, reflect, count, sooncount, stack, switch, switchcount, adds, addscount, addscustom, targetchange, prewarn
			------General Target Messages (but since it's a special warning, it applies to you in some way): target, targetcount
			------Fight Changes (Stages, adds, boss buff/debuff, etc): adds, addscount, addscustom, targetchange, switch, switchcount, ends
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			------Personal/Role (Applies to you, or your job): Everything Else
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority). BW would call this "emphasized"
			--announceCount: If it's a count announce, this will provide access to the number value of that count. This, along with spellId should be used instead of message text scanning for most weak auras that need to target specific count casts
			fireEvent("DBM_Announce", text, self.icon, self.type, self.spellId, self.mod.id, true, announceCount)
			if self.sound and not DBM.Options.DontPlaySpecialWarningSound and (not self.option or self.mod.Options[self.option .. "SWSound"] ~= "None") then
				local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
				if noteHasName and type(soundId) == "number" then soundId = noteHasName end--Change number to 5 if it's not a custom sound, else, do nothing with it
				if self.hasVoice and not DBM.Options.VPDontMuteSounds and canVoiceReplace(self, soundId) and self.hasVoice <= SWFilterDisabled then return end
				DBM:PlaySpecialWarningSound(soundId or 1)
			end
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	--Object that's used when precision isn't possible (number of targets variable or unknown
	function specialWarningPrototype:CombinedShow(delay, ...)
		--Check if option for this warning is even enabled
		if self.option and not self.mod.Options[self.option] then return end
		--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
		if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
		--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 6 then--Throttle spam. We may not need more than 5 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBMScheduler:Unschedule(self.Show, self.mod, self)
		DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	--New object that allows defining count instead of scheduling for more efficient and immediate warnings when precise count is known
	function specialWarningPrototype:PreciseShow(maxTotal, ...)
		--Check if option for this warning is even enabled
		if self.option and not self.mod.Options[self.option] then return end
		--Now, check if all special warning filters are enabled to save cpu and abort immediately if true.
		if DBM.Options.DontPlaySpecialWarningSound and DBM.Options.DontShowSpecialWarningFlash and DBM.Options.DontShowSpecialWarningText then return end
		--Next, we check if trash mod warning and if so check the filter trash warning filter for trivial difficulties
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 6 then--Throttle spam. We may not need more than 5 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		DBMScheduler:Unschedule(self.Show, self.mod, self)
		local viableTotal = DBM:NumRealAlivePlayers()
		if (maxTotal == #self.combinedtext) or (viableTotal == #self.combinedtext) then--All targets gathered, show immediately
			self:Show(...)--Does this need self or mod? will it have this bug? https://github.com/DeadlyBossMods/DBM-Unified/issues/153
		else--And even still, use scheduling backup in case counts still fail
			DBMScheduler:Schedule(1.2, self.Show, self.mod, self, ...)
		end
	end

	function specialWarningPrototype:DelayedShow(delay, ...)
		DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
		DBMScheduler:Schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Countdown(time, numAnnounces, ...)
		DBMScheduler:ScheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Cancel(_, ...) -- t, ...
		return DBMScheduler:Unschedule(self.Show, self.mod, self, ...)
	end

	--Several voice lines still need generic alternatives that don't feel "instructional"
	local specInstructionalRemapVoiceTable = {
--		["dispel"] = "target",
--		["interrupt"] = "spell",
--		["interruptcount"] = "count",
--		["defensive"] = "spell",
		["taunt"] = "changemt",--Remaps sound to say a swap is happening, rather than telling you to taunt boss
--		["soak"] = "spell",
--		["soakcount"] = "count",
--		["soakpos"] = "spell",
--		["switch"] = "spell",
--		["switchcount"] = "count",
		["adds"] = "mobsoon",--Remaps sound to say mobs incoming only, not to kill them or cc them or anything else.
		["addscount"] = "mobsoon",
		["addscustom"] = "mobsoon",--Remaps sound to say mobs incoming only, not to kill them or cc them or anything else.
--		["targetchange"] = "target",
--		["gtfo"] = "spell",
--		["bait"] = "soon",
		["you"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
		["youpos"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
		["youposcount"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
--		["move"] = "spell",
--		["keepmove"] = "spell",
--		["stopmove"] = "spell",
--		["dodge"] = "spell",
--		["dodgecount"] = "count",
--		["dodgeloc"] = "spell",
		["moveaway"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
		["moveawaycount"] = "targetyou",--Remaps personal alert to just say "target you", without instruction
--		["moveto"] = "spell",
--		["jump"] = "spell",
--		["run"] = "spell",
--		["runcount"] = "spell",
--		["cast"] = "spell",
--		["lookaway"] = "spell",
--		["reflect"] = "target",
	}

	function specialWarningPrototype:Play(name, customPath)
		local always = DBM.Options.AlwaysPlayVoice
		local voice = DBM.Options.ChosenVoicePack2
		local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
		if not canVoiceReplace(self, soundId) then return end
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		local filterType = specTypeFilterTable[self.announceType]
		if filterType then
			--Filtered warning, filtered voice
			if DBM.Options["SpamSpecRole" .. filterType] then return end
		elseif DBM.Options.SpamSpecInformationalOnly then
			local remapType = specInstructionalRemapVoiceTable[self.announceType]
			if remapType then
				--Instructional disabled, remap to a less instructional voice line
				name = remapType
			end
		end
		if ((not self.option or self.mod.Options[self.option]) or always) and self.hasVoice <= SWFilterDisabled then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			--Mute VP if SW sound is set to None in the boss mod.
			if soundId == "None" then return end
			local path = customPath or ("Interface\\AddOns\\DBM-VP" .. voice .. "\\" .. name .. ".ogg")
			DBM:PlaySoundFile(path)
		end
	end

	function specialWarningPrototype:ScheduleVoice(t, ...)
		if not canVoiceReplace(self) then return end
		DBMScheduler:Unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function specialWarningPrototype:ScheduleVoiceOverLap(t, ...)
		if not canVoiceReplace(self) then return end
		return DBMScheduler:Schedule(t, self.Play, self.mod, self, ...)
	end

	function specialWarningPrototype:CancelVoice(...)
		if not canVoiceReplace(self) then return end
		return DBMScheduler:Unschedule(self.Play, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty, icon, spellID, waCustomName)
		if not text then
			error("NewSpecialWarning: you must provide special warning text", 2)
		end
		if type(text) == "string" and text:match("OptionVersion") then
			error("NewSpecialWarning: you must provide remove optionversion hack for " .. optionDefault)
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		icon = parseSpellIcon(icon)
		---@class SpecialWarning
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				mod = self,
				sound = runSound > 0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
				spellId = spellID,--For WeakAuras / other callbacks
				icon = icon,
			},
			mt
		)
		local optionId = optionName or optionName ~= false and text
		if optionId then
			obj.voiceOptionId = hasVoice and "Voice" .. optionId or nil
			obj.option = optionId .. (optionVersion or "")
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, self.NoSortAnnounce and "specialannounce" or "announce", spellID, nil, waCustomName)
		end
		tinsert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty)
		if not spellId then
			error("newSpecialWarning: you must provide spellId", 2)
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		local alternateSpellId
		if type(optionName) == "number" then
			if DBM.Options.SpecialWarningShortText then
				alternateSpellId = optionName
			end
			optionName = nil
		end
		local text, spellName = setText(announceType, alternateSpellId or spellId, stacks)
		local icon = parseSpellIcon(spellId)
		---@class SpecialWarning
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				mod = self,
				sound = runSound > 0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
				type = announceType,
				spellId = spellId,
				spellName = spellName,
				stacks = stacks,
				icon = icon,
			},
			mt
		)
		if optionName then
			obj.option = optionName
		elseif optionName ~= false then
			local difficultyIcon = ""
			if difficulty then
				--1 LFR, 2 Normal, 3 Heroic, 4 Mythic
				--Likely 1 and 2 will never be used, but being prototyped just in case
				local path = isRetail and "EncounterJournal" or "AddOns\\DBM-Core\\textures"
				if difficulty == 3 then
					difficultyIcon = "|TInterface\\" .. path .. "\\UI-EJ-Icons.blp:18:18:0:0:255:66:102:118:7:27|t"
				elseif difficulty == 4 then
					difficultyIcon = "|TInterface\\" .. path .. "\\UI-EJ-Icons.blp:18:18:0:0:255:66:133:153:40:58|t"
				end
			end
			obj.option = "SpecWarn" .. spellId .. announceType .. (optionVersion or "")
			if announceType == "stack" then
				self.localization.options[obj.option] = difficultyIcon .. L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
			elseif announceType == "prewarn" then
				self.localization.options[obj.option] = difficultyIcon .. L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(tostring(stacks or 5), spellId)
			else
				self.localization.options[obj.option] = difficultyIcon .. L.AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
			end
		end
		if obj.option then
			local catType = "announce"--Default to General announce
			if self.NoSortAnnounce then--ALL special announce objects will be assigned "specialannounce", usually for mods that sort by phase instead
				catType = "specialannounce"
			else
				--Directly affects another target (boss or player) that you need to know about
				if announceType == "target" or announceType == "targetcount" or announceType == "close" or announceType == "reflect" then
					catType = "announceother"
				--Directly affects you
				elseif announceType == "you" or announceType == "youcount" or announceType == "youpos" or announceType == "move" or announceType == "dodge" or announceType == "dodgecount" or announceType == "moveaway" or announceType == "moveawaycount" or announceType == "keepmove" or announceType == "stopmove" or announceType == "run" or announceType == "runcount" or announceType == "stack" or announceType == "moveto" or announceType == "soak" or announceType == "soakcount" or announceType == "soakpos" then
					catType = "announcepersonal"
				--Things you have to do to fulfil your role
				elseif announceType == "taunt" or announceType == "dispel" or announceType == "interrupt" or announceType == "interruptcount" or announceType == "switch" or announceType == "switchcount" then
					catType = "announcerole"
				end
			end
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, catType, spellId, announceType)
		end
		obj.voiceOptionId = hasVoice and "Voice" .. spellId or nil
		tinsert(self.specwarns, obj)
		return obj
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSpell(spellId, optionDefault, ...)
		return newSpecialWarning(self, "spell", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningEnd(spellId, optionDefault, ...)
		return newSpecialWarning(self, "ends", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningFades(spellId, optionDefault, ...)
		return newSpecialWarning(self, "fades", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSoon(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soon", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningBait(spellId, optionDefault, ...)
		return newSpecialWarning(self, "bait", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningDispel(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dispel", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningInterrupt(spellId, optionDefault, ...)
		return newSpecialWarning(self, "interrupt", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningInterruptCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "interruptcount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningYou(spellId, optionDefault, ...)
		return newSpecialWarning(self, "you", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningYouCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "youcount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningYouPos(spellId, optionDefault, ...)
		return newSpecialWarning(self, "youpos", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningYouPosCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "youposcount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSoakPos(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soakpos", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningTarget(spellId, optionDefault, ...)
		return newSpecialWarning(self, "target", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningTargetCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "targetcount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningDefensive(spellId, optionDefault, ...)
		return newSpecialWarning(self, "defensive", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningTaunt(spellId, optionDefault, ...)
		return newSpecialWarning(self, "taunt", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningClose(spellId, optionDefault, ...)
		return newSpecialWarning(self, "close", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningMove(spellId, optionDefault, ...)
		return newSpecialWarning(self, "move", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningKeepMove(spellId, optionDefault, ...)
		return newSpecialWarning(self, "keepmove", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningStopMove(spellId, optionDefault, ...)
		return newSpecialWarning(self, "stopmove", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningGTFO(spellId, optionDefault, ...)
		return newSpecialWarning(self, "gtfo", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningDodge(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dodge", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningDodgeCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dodgecount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningDodgeLoc(spellId, optionDefault, ...)
		return newSpecialWarning(self, "dodgeloc", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningMoveAway(spellId, optionDefault, ...)
		return newSpecialWarning(self, "moveaway", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningMoveAwayCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "moveawaycount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningMoveTo(spellId, optionDefault, ...)
		return newSpecialWarning(self, "moveto", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSoak(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soak", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSoakCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "soakcount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningJump(spellId, optionDefault, ...)
		return newSpecialWarning(self, "jump", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningRun(spellId, optionDefault, optionName, optionVersion, runSound, ...)
		return newSpecialWarning(self, "run", spellId, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningRunCount(spellId, optionDefault, optionName, optionVersion, runSound, ...)
		return newSpecialWarning(self, "runcount", spellId, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningCast(spellId, optionDefault, ...)
		return newSpecialWarning(self, "cast", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningLookAway(spellId, optionDefault, ...)
		return newSpecialWarning(self, "lookaway", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningReflect(spellId, optionDefault, ...)
		return newSpecialWarning(self, "reflect", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "count", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSoonCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "sooncount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, stacks, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningStack(spellId, optionDefault, stacks, ...)
		return newSpecialWarning(self, "stack", spellId, stacks, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSwitch(spellId, optionDefault, ...)
		return newSpecialWarning(self, "switch", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningSwitchCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "switchcount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningAdds(spellId, optionDefault, ...)
		return newSpecialWarning(self, "adds", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningAddsCount(spellId, optionDefault, ...)
		return newSpecialWarning(self, "addscount", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningAddsCustom(spellId, optionDefault, ...)
		return newSpecialWarning(self, "addscustom", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningTargetChange(spellId, optionDefault, ...)
		return newSpecialWarning(self, "targetchange", spellId, nil, optionDefault, ...)
	end

	---@overload fun(self: DBMMod, spellId, optionDefault, time, optionName, optionVersion, runSound, hasVoice, difficulty): SpecialWarning
	function bossModPrototype:NewSpecialWarningPreWarn(spellId, optionDefault, time, ...)
		return newSpecialWarning(self, "prewarn", spellId, time, optionDefault, ...)
	end

	function DBM:PlayCountSound(number, forceVoice, forcePath)
		if number > 10 then return end
		local voice
		if forceVoice then--For options example
			voice = forceVoice
		else
			voice = self.Options.CountdownVoice
		end
		local path
		local maxCount = 5
		if forcePath then
			path = forcePath
		else
			for _, count in pairs(DBM:GetCountSounds()) do
				if count.value == voice then
					path = count.path
					maxCount = count.max
					break
				end
			end
		end
		if not path or (number > maxCount) then return end
		self:PlaySoundFile(path .. number .. ".ogg")
	end

	do
		local minVoicePackVersion = isRetail and 16 or isCata and 16 or isWrath and 16 or 10

		function DBM:CheckVoicePackVersion(value)
			local activeVP = self.Options.ChosenVoicePack2
			--Check if voice pack out of date
			if activeVP ~= "None" and activeVP == value then
				-- User might reselect "missing" entry shown in GUI if previously selected voice pack is uninstalled or disabled
				if self.VoiceVersions[value] then
					voiceSessionDisabled = false
					if self.VoiceVersions[value] < minVoicePackVersion then--Version will be bumped when new voice packs released that contain new voices.
						if self.Options.ShowReminders then
							self:AddMsg(L.VOICE_PACK_OUTDATED)
						end
						SWFilterDisabled = self.VoiceVersions[value]--Set disable to version on current voice pack
					else
						SWFilterDisabled = minVoicePackVersion
					end
				else
					voiceSessionDisabled = true
				end
			end
		end
	end

	function DBM:PlaySpecialWarningSound(soundId, force)
		local sound
		if not force and self:IsTrivial() and self.Options.DontPlayTrivialSpecialWarningSound then
			sound = self.Options.RaidWarningSound
		else
			sound = type(soundId) == "number" and self.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId or self.Options.SpecialWarningSound
		end
		self:PlaySoundFile(sound, nil, true)
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(text, number, noSound, force) -- text, number, noSound, force
		if moving then
			return
		end
		self:AddSpecialWarning(text or L.MOVE_SPECIAL_WARNING_TEXT)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(self.Options.SpecialWarningDuration2 * 1.3, testWarningEnd)
		if number and not noSound then
			self:PlaySpecialWarningSound(number, force)
		end
		if number then
			if self.Options["SpecialWarningFlash" .. number] then
				if not force and self:IsTrivial() and self.Options.DontPlayTrivialSpecialWarningSound then return end--No flash if trivial
				local flashColor = self.Options["SpecialWarningFlashCol" .. number]
				local repeatCount = self.Options["SpecialWarningFlashCount" .. number] or 1
				self.Flash:Show(flashColor[1], flashColor[2], flashColor[3], self.Options["SpecialWarningFlashDura" .. number], self.Options["SpecialWarningFlashAlph" .. number], repeatCount - 1)
			end
			if not self.Options.DontDoSpecialWarningVibrate and self.Options["SpecialWarningVibrate" .. number] then
				self:VibrateController()
			end
		end
	end
end
---@diagnostic enable: inject-field


--------------------
--  Timer Object  --
--------------------
do
	---@class Timer
	local timerPrototype = {}
	local mt = {__index = timerPrototype}
	local countvoice1, countvoice2, countvoice3, countvoice4
	local countvoice1max, countvoice2max, countvoice3max, countvoice4max = 5, 5, 5, 5
	local countpath1, countpath2, countpath3, countpath4

	--Merged countdown object for timers with build-in countdown
	function DBM:BuildVoiceCountdownCache()
		countvoice1 = self.Options.CountdownVoice
		countvoice2 = self.Options.CountdownVoice2
		countvoice3 = self.Options.CountdownVoice3
		countvoice4 = self.Options.PullVoice
		for _, count in pairs(DBM:GetCountSounds()) do
			if count.value == countvoice1 then
				countpath1 = count.path
				countvoice1max = count.max
			end
			if count.value == countvoice2 then
				countpath2 = count.path
				countvoice2max = count.max
			end
			if count.value == countvoice3 then
				countpath3 = count.path
				countvoice3max = count.max
			end
			if count.value == countvoice4 then
				countpath4 = count.path
				countvoice4max = count.max
			end
		end
	end

	local function playCountSound(_, path, requiresCombat) -- timerId, path
		if requiresCombat and not (InCombatLockdown() or UnitAffectingCombat("player")) then return end
		DBM:PlaySoundFile(path)
	end

	local function playCountdown(timerId, timer, voice, count, requiresCombat)
		if DBM.Options.DontPlayCountdowns then return end
		timer = timer or 10
		count = count or 4
		voice = voice or 1
		if timer <= count then count = floor(timer) end
		if not countpath1 or not countpath2 or not countpath3 then
			DBM:Debug("Voice cache not built at time of playCountdown. On fly caching.", 3)
			DBM:BuildVoiceCountdownCache()
		end
		local maxCount, path
		if type(voice) == "string" then
			maxCount = 5--Safe to assume if it's not one of the built ins, it's likely heroes/OW, which has a max of 5
			path = voice
		elseif voice == 2 then
			maxCount = countvoice2max or 10
			path = countpath2 or "Interface\\AddOns\\DBM-Core\\Sounds\\Kolt\\"
		elseif voice == 3 then
			maxCount = countvoice3max or 5
			path = countpath3 or "Interface\\AddOns\\DBM-Core\\Sounds\\Smooth\\"
		elseif voice == 4 then
			maxCount = countvoice4max or 10
			path = countpath4 or "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\"
		else
			maxCount = countvoice1max or 10
			path = countpath1 or "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\"
		end
		if not path then--Should not happen but apparently it does somehow
			DBM:Debug("Voice path failed in countdownProtoType:Start.")
			return
		end
		if count == 0 then--If a count of 0 is passed,then it's a "Countout" timer, not "Countdown"
			for i = 1, timer do
				if i < maxCount then
					DBM:Schedule(i, playCountSound, timerId, path .. i .. ".ogg", requiresCombat)
				end
			end
		else
			for i = count, 1, -1 do
				if i <= maxCount then
					DBM:Schedule(timer - i, playCountSound, timerId, path .. i .. ".ogg", requiresCombat)
				end
			end
		end
	end

	--"break" and "pull" timers have custom classifications that are straight forward and not in this table
	local timerTypeSimplification = {
		--All cooldown times, be they approx cd or next exact, or even AI timers, map to "CD"
		["cdcount"] = "cd",
		["cdsource"] = "cd",
		["nextcount"] = "cd",
		["nextsource"] = "cd",
		["cdspecial"] = "cd",
		["nextspecial"] = "cd",
		["ai"] = "cd",
		["adds"] = "cd",
		["addscustom"] = "cd",
		["cdnp"] = "cd",
		["nextnp"] = "cd",

		--RPs all map to "warmup"
		["roleplay"] = "warmup",
		["combat"] = "warmup",

		--all stage types will map to "stage"
		["achievement"] = "stage",
		["stagecount"] = "stage",
		["stagecountcycle"] = "stage",
		["stagecontext"] = "stage",
		["stagecontextcount"] = "stage",
		["intermission"] = "stage",
		["intermissioncount"] = "stage",

		--Target Bars such as buff/debuff on another player, on self, or on the boss, RPs all map to "target"
		["targetcount"] = "target",
		["fades"] = "target",--Fades is usually used as a personal target timer. So like debuff on other player is "debuff (targetname)" but on self it's just "debuff fades"

		--All cast bar types map to "cast"
		["active"] = "cast",--Active bars are usually things like Whirlwind is active on the boss, or a channeled cast is being done. so effectively it's for channeled casts, as upposed to regular casts
		["castsource"] = "cast",
		["castcount"] = "cast",
	}

	--Very similar to above but more specific to key replacement and not type replacement, to match BW behavior for unification of WAs
	local waKeyOverrides = {
		["combat"] = "warmup",
		["roleplay"] = "warmup",
		["achievement"] = "stages",
		["stagecount"] = "stages",
		["stagecountcycle"] = "stages",
		["stagecontext"] = "stages",
		["stagecontextcount"] = "stages",
		["intermission"] = "stages",
		["intermissioncount"] = "stages",
	}

	function timerPrototype:Start(timer, ...)
		if not self.mod.isDummyMod then--Don't apply following rulesets to pull timers and such
			if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
			if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		end
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		if not self.option or self.mod.Options[self.option] then
			local isCountTimer = false
			if self.type and (self.type == "cdcount" or self.type == "nextcount" or self.type == "stagecount" or self.type == "stagecontextcount" or self.type == "stagecountcycle" or self.type == "intermissioncount") then
				isCountTimer = true
			end
			if isCountTimer and not self.allowdouble then--remove previous timer.
				for i = #self.startedTimers, 1, -1 do
					if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
						local bar = DBT:GetBar(self.startedTimers[i])
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
							ttext = ttext .. "(" .. self.id .. ")"
							if bar.timer > 0.2 then
								local phaseText = self.mod.vb.phase and " (" .. SCENARIO_STAGE:format(self.mod.vb.phase) .. ")" or ""
								if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
									DBM:AddMsg("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", nil, true)
									fireEvent("DBM_Debug", "Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", 2)
								else
									DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining, 2, true)
								end
							end
						end
					end
					DBT:CancelBar(self.startedTimers[i])
					DBM:Unschedule(playCountSound, self.startedTimers[i])
					fireEvent("DBM_TimerStop", self.startedTimers[i])
					tremove(self.startedTimers, i)
				end
			end
			timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
			local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
			--AI timer api:
			--Starting ai timer with (1) indicates it's a first timer after pull
			--Starting timer with (2) or (3) indicates it's a stage 2 or stage 3 first timer
			--Starting AI timer with anything above 3 indicarets it's a regular timer and to use shortest time in between two regular casts
			if self.type == "ai" then--A learning timer
				if not DBM.Options.AITimer then return end
				if timer > 5 then--Normal behavior.
					local newPhase = false
					for i = 1, 5 do
						--Check for any phase timers that are strings, if a string it means last cast of this ability was first case of a given stage
						if self["phase" .. i .. "CastTimer"] and type(self["phase" .. i .. "CastTimer"]) == "string" then--This is first cast of spell, we need to generate self.firstPullTimer
							self["phase" .. i .. "CastTimer"] = tonumber(self["phase" .. i .. "CastTimer"])
							self["phase" .. i .. "CastTimer"] = GetTime() - self["phase" .. i .. "CastTimer"]--We have generated a self.phase1CastTimer! Next pull, DBM should know timer for first cast next pull. FANCY!
							DBM:Debug("AI timer learned a first timer for current phase of " .. self["phase" .. i .. "CastTimer"], 2)
							newPhase = true
						end
					end
					if self.lastCast and not newPhase then--We have a GetTime() on last cast and it's not affected by a phase change
						local timeLastCast = GetTime() - self.lastCast--Get time between current cast and last cast
						if timeLastCast > 5 then--Prevent infinite loop cpu hang. Plus anything shorter than 5 seconds doesn't need a timer
							if not self.lowestSeenCast or (self.lowestSeenCast and self.lowestSeenCast > timeLastCast) then--Always use lowest seen cast for a timer
								self.lowestSeenCast = timeLastCast
								DBM:Debug("AI timer learned a new lowest timer of " .. self.lowestSeenCast, 2)
							end
						end
					end
					self.lastCast = GetTime()
					if self.lowestSeenCast then--Always use lowest seen cast for timer
						timer = self.lowestSeenCast
					else
						return--Don't start the bogus timer shoved into timer field in the mod
					end
				else--AI timer passed with 5 or less is indicating phase change, with timer as phase number
					if not isRetail then
						timer = floor(timer)--Floor inprecise timers in classic because combat is mostly caused by PLAYER_REGEN in dungeons
					end
					if self["phase" .. timer .. "CastTimer"] and type(self["phase" .. timer .. "CastTimer"]) == "number" then
						--Check if timer is shorter than previous learned first timer by scanning remaining time on existing bar
						local bar = DBT:GetBar(id)
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							if bar.timer > 0.2 then
								self["phase" .. timer .. "CastTimer"] = self["phase" .. timer .. "CastTimer"] - remaining
								DBM:Debug("AI timer learned a lower first timer for current phase of " .. self["phase" .. timer .. "CastTimer"], 2)
							end
						end
						timer = self["phase" .. timer .. "CastTimer"]
					else--No first pull timer generated yet, set it to GetTime, as a string
						self["phase" .. timer .. "CastTimer"] = tostring(GetTime())
						return--Don't start the x second timer
					end
				end
			end
			if DBM.Options.BadTimerAlert or DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
				if not self.type or (self.type ~= "target" and self.type ~= "active" and self.type ~= "fades" and self.type ~= "ai") and not self.allowdouble then
					local bar = DBT:GetBar(id)
					if bar then
						local remaining = ("%.1f"):format(bar.timer)
						local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
						ttext = ttext .. "(" .. self.id .. ")"
						if bar.timer > 0.2 then
							local phaseText = self.mod.vb.phase and " (" .. SCENARIO_STAGE:format(self.mod.vb.phase) .. ")" or ""
							if DBM.Options.BadTimerAlert and bar.timer > 1 then--If greater than 1 seconds off, report this out of debug mode to all users
								DBM:AddMsg("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", nil, true)
								fireEvent("DBM_Debug", "Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining .. ". Please report this bug", 2)
							else
								DBM:Debug("Timer " .. ttext .. phaseText .. " refreshed before expired. Remaining time is : " .. remaining, 2, true)
							end
						end
					end
				end
			end
			local colorId
			if self.option then
				colorId = self.mod.Options[self.option .. "TColor"]
			elseif self.colorType and type(self.colorType) == "string" then--No option for specific timer, but another bool option given that tells us where to look for TColor (for mods such as trio boss for valentines day in events mods)
				colorId = self.mod.Options[self.colorType .. "TColor"]
			else--No option, or secondary option, set colorId to hardcoded color type
				colorId = self.colorType or 0
			end
			local countVoice, countVoiceMax = 0, self.countdownMax or 4
			if self.option then
				countVoice = self.mod.Options[self.option .. "CVoice"]
				if not self.fade and (type(countVoice) == "string" or countVoice > 0) then--Started without faded and has count voice assigned
					playCountdown(id, timer, countVoice, countVoiceMax, self.requiresCombat)--timerId, timer, voice, count
				end
			end
			local bar = DBT:CreateBar(timer, id, self.icon, self.startLarge, nil, nil, nil, colorId, nil, self.keep, self.fade, countVoice, countVoiceMax, self.simpType == "cd")
			if not bar then
				return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
			end
			local msg
			if self.type and not self.text then
				msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId, self.name), ...)
			else
				if type(self.text) == "number" then--spellId passed in timer text, it's a timer with short text
					msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.text, self.name), ...)
				else
					msg = pformat(self.text, ...)
				end
			end
			msg = msg:gsub(">.-<", stripServerName)
			bar:SetText(msg, self.inlineIcon)
			--ID: Internal DBM timer ID
			--msg: Timer Text (Do not use msg has an event trigger, it varies language to language or based on user timer options. Use this to DISPLAY only (such as timer replacement UI). use spellId field 99% of time
			--timer: Raw timer value (number).
			--Icon: Texture Path for Icon
			--type: Timer type, which is one of only 7 possible types: "cd" for coolodwns, "target" for target bars such as debuff on a player, "stage" for any kind of stage timer (stage ends, next stage, or even just a warmup timer like "fight begins"), and then "cast" timer which is used for both a regular cast and a channeled cast (ie boss is casting frostbolt, or boss is channeling whirlwind). Lastly, break, pull, and berserk timers are "breaK", "pull", and "berserk" respectively
			--spellId: Raw spellid if available (most timers will have spellId or EJ ID unless it's a specific timer not tied to ability such as pull or combat start or rez timers. EJ id will be in format ej%d
			--colorID: Type classification (1-Add, 2-Aoe, 3-targeted ability, 4-Interrupt, 5-Role, 6-Stage, 7-User(custom))
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--Keep: true or nil, whether or not to keep bar on screen when it expires (if true, timer should be retained until an actual TimerStop occurs or a new TimerStart with same barId happens (in which case you replace bar with new one)
			--fade: true or nil, whether or not to fade a bar (set alpha to usersetting/2)
			--spellName: Sent so users can use a spell name instead of spellId, if they choose. Mostly to be more classic wow friendly, spellID is still preferred method (even for classic)
			--MobGUID if it could be parsed out of args
			--timerCount if current timer is a count timer. Returns number (count value) needed to have weak auras that trigger off a specific timer count without using localized message text
			local guid, timerCount
			if select("#", ...) > 0 then--If timer has args
				for i = 1, select("#", ...) do
					local v = select(i, ...)
					if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
						guid = v--If found, guid will be passed in DBM_TimerStart callback
					end
					--Not most efficient way to do it, but since it's already being done for guid, it's best not to repeat the work
					if isCountTimer and type(v) == "number" then
						timerCount = v
					end
				end
			end
			--Mods that have specifically flagged that it's safe to assume all timers from that boss mod belong to boss1
			--This check is performed secondary to args scan so that no adds guids are overwritten
			if not guid and self.mod.sendMainBossGUID and not DBM.Options.DontSendBossGUIDs and (self.type == "cd" or self.type == "next" or self.type == "cdcount" or self.type == "nextcount" or self.type == "cdspecial" or self.type == "ai") then
				guid = UnitGUID("boss1")
			end
			fireEvent("DBM_TimerStart", id, msg, timer, self.icon, self.simpType, self.waSpecialKey or self.spellId, colorId, self.mod.id, self.keep, self.fade, self.name, guid, timerCount)
			--Bssically tops bar from starting if it's being put on a plater nameplate, to give plater users option to have nameplate CDs without actually using the bars
			--This filter will only apply to trash mods though, boss timers will always be shown due to need to have them exist for Pause, Resume, Update, and GetTime/GetRemaining methods
			if guid and (self.type == "cdnp" or self.type == "nextnp") and not (DBM.Options.DebugMode and DBM.Options.DebugLevel > 1) then
				DBT:CancelBar(id)--Cancel bar without stop callback
				return false, "disabled"
			end
			if not tContains(self.startedTimers, id) then--Make sure timer doesn't exist already before adding it
				tinsert(self.startedTimers, id)
			end
			if not self.keep then--Don't ever remove startedTimers on a schedule, if it's a keep timer
				self.mod:Unschedule(removeEntry, self.startedTimers, id)
				self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
			end
			return bar
		else
			return false, "disabled"
		end
	end
	timerPrototype.Show = timerPrototype.Start

	--A way to set the fade to yes or no, overriding hardcoded value in NewTimer object with temporary one
	--If this method is used, it WILL persist until reload or changing it back
	function timerPrototype:SetFade(fadeOn, ...)
		--Done this way so SetFade can be used with :Start without needless performance cost (ie, ApplyStyle won't run unless it needs to)
		if fadeOn and not self.fade then
			self.fade = true--set timer object metatable, which will make sure next bar started uses fade
			--Find and Update an existing bar that's already started
			local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBT:GetBar(id)
			if bar and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				DBM:Unschedule(playCountSound, id)--Don't even need to check option, it's faster cpu wise to just unschedule countdown either way
			end
		elseif not fadeOn and self.fade then
			self.fade = nil--set timer object metatable, which will make sure next bar started does NOT use fade
			--Find and Update an existing bar that's already started
			local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBT:GetBar(id)
			if bar and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = nil--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if self.option then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then--Unfading bar, start countdown
						DBM:Unschedule(playCountSound, id)
						playCountdown(id, bar.timer, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
						DBM:Debug("Re-enabling a countdown on bar ID: " .. id .. " after a SetFade disable call")
					end
				end
			end
		end
	end

	--This version does NOT set timer object meta, only started bar meta
	--Use this if you only want to alter an already STARTED temporarily
	--As such it also only needs fadeOn. fadeoff isn't needed since this temp alter never affects newly started bars
	function timerPrototype:SetSTFade(fadeOn, ...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			if fadeOn and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true, self.name)--Timer ID, spellId, modId, true/nil, spellName (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				DBM:Unschedule(playCountSound, id)
			elseif not fadeOn and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil, self.name)
				bar.fade = false
				bar:ApplyStyle()
				if self.option then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then--Unfading bar, start countdown
						DBM:Unschedule(playCountSound, id)
						playCountdown(id, bar.timer, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
						DBM:Debug("Re-enabling a countdown on bar ID: " .. id .. " after a SetSTFade disable call")
					end
				end
			end
		end
	end

	function timerPrototype:SetSTKeep(keepOn, ...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			if keepOn and not bar.keep then
				bar.keep = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
			elseif not keepOn and bar.keep then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)
				bar.keep = false
				bar:ApplyStyle()
			end
		end
	end

	function timerPrototype:DelayedStart(delay, ...)
		DBMScheduler:Unschedule(self.Start, self.mod, self, ...)
		DBMScheduler:Schedule(delay or 0.5, self.Start, self.mod, self, ...)
	end
	timerPrototype.DelayedShow = timerPrototype.DelayedStart

	function timerPrototype:Schedule(t, ...)
		return DBMScheduler:Schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(...)
		return DBMScheduler:Unschedule(self.Start, self.mod, self, ...)
	end

	--TODO, figure out why this function doesn't properly stop count timers when calling stop without count on count timers
	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				fireEvent("DBM_TimerStop", self.startedTimers[i])
				DBT:CancelBar(self.startedTimers[i])
				DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
				tremove(self.startedTimers, i)
			end
		else
			local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					local guid
					for j = 1, select("#", ...) do
						local v = select(j, ...)
						if DBM:IsNonPlayableGUID(v) then--Then scan them for a mob guid
							guid = v--If found, guid will be passed in DBM_TimerStart callback
						end
					end
					--Mods that have specifically flagged that it's safe to assume all timers from that boss mod belong to boss1
					--This check is performed secondary to args scan so that no adds guids are overwritten
					if not guid and self.mod.sendMainBossGUID and not DBM.Options.DontSendBossGUIDs and (self.type == "cd" or self.type == "next" or self.type == "cdcount" or self.type == "nextcount" or self.type == "cdspecial" or self.type == "ai") then
						guid = UnitGUID("boss1")
					end
					fireEvent("DBM_TimerStop", id, guid)
					DBT:CancelBar(id)
					DBM:Unschedule(playCountSound, id)--Unschedule countdown by timerId
					tremove(self.startedTimers, i)
				end
			end
		end
		if self.type == "ai" then--A learning timer
			if not DBM.Options.AITimer then return end
			self.lastCast = nil
			for i = 1, 4 do
				--Check for any phase timers that are strings and never got a chance to become AI timers, then wipe them
				if self["phase" .. i .. "CastTimer"] and type(self["phase" .. i .. "CastTimer"]) == "string" then
					self["phase" .. i .. "CastTimer"] = nil
					DBM:Debug("Wiping incomplete new timer of stage " .. i, 2)
				end
			end
		end
	end

	--HardStop is a method used when you want to force stop all varients of a timer by ID, period, but still pass a GUID for callbacks
	--This is especially useful for count timers where guid is 2nd arg and count is 1st
	--where Stop(guid) would mismatch object and not stop a bar and calling stop on every possible count is silly and stop without args wouldn't send GUID
	function timerPrototype:HardStop(guid)
		--Mods that have specifically flagged that it's safe to assume all timers from that boss mod belong to boss1
		--This check is performed secondary to args scan so that no adds guids are overwritten
		if not guid and self.mod.sendMainBossGUID and not DBM.Options.DontSendBossGUIDs and (self.type == "cd" or self.type == "next" or self.type == "cdcount" or self.type == "nextcount" or self.type == "cdspecial" or self.type == "ai") then
			guid = UnitGUID("boss1")
		end
		for i = #self.startedTimers, 1, -1 do
			fireEvent("DBM_TimerStop", self.startedTimers[i], guid)
			DBT:CancelBar(self.startedTimers[i])
			DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
			tremove(self.startedTimers, i)
		end
	end

	--In past boss mods have always had to manually call Stop just to restart a timer, to avoid triggering false debug messages
	--This function should simplify boss mod creation by allowing you to "Restart" a timer with one call in mod instead of 2
	function timerPrototype:Restart(timer, ...)
		if self.type and (self.type == "cdcount" or self.type == "nextcount") and not self.allowdouble then
			self:Stop()--Cleanup any count timers left over on a restart
		else
			self:Stop(...)
		end
		self:Unschedule(...)--Also unschedules not yet started timers that used timer:Schedule()
		self:Start(timer, ...)
	end
	timerPrototype.Reboot = timerPrototype.Restart

	function timerPrototype:Cancel(...)
		self:Stop(...)
		self:Unschedule(...)--Also unschedules not yet started timers that used timer:Schedule()
	end

	function timerPrototype:GetTime(...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0
	end

	function timerPrototype:GetRemaining(...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		return bar and bar.timer or 0
	end

	function timerPrototype:IsStarted(...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		return bar and true
	end

	function timerPrototype:SetTimer(timer)
		self.timer = timer
	end

	function timerPrototype:Update(elapsed, totalTime, ...)
		if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
		if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		---@type DBTBar|boolean|nil
		local bar = DBT:GetBar(id)
		if not bar then
			bar = self:Start(totalTime, ...)
		end
		fireEvent("DBM_TimerUpdate", id, elapsed, totalTime)
		if bar then -- still need to check as :Start() can return nil instead of actually starting the timer
			local newRemaining = totalTime - elapsed
			if not bar.keep and newRemaining > 0 then
				--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
				self.mod:Unschedule(removeEntry, self.startedTimers, id)
				self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
			end
			if self.option then
				local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
				if (type(countVoice) == "string" or countVoice > 0) then
					if not bar.fade then--Don't start countdown voice if it's faded bar
						if newRemaining > 2 then
							--Can't be called early beacuse then it won't unschedule countdown triggered by :Start if it was called
							--Also doesn't need to be called early like it does in AddTime and RemoveTime since those early return
							DBM:Unschedule(playCountSound, id)
							playCountdown(id, newRemaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
							DBM:Debug("Updating a countdown after a timer Update call for timer ID:" .. id)
						end
					end
				end
			end
		end
		return DBT:UpdateBar(id, elapsed, totalTime)
	end

	function timerPrototype:AddTime(extendAmount, ...)
		if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
		if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		DBM:Unschedule(playCountSound, id)--Needs to be unscheduled early in case Start is called instead of Update
		local bar = DBT:GetBar(id)
		if not bar then
			return self:Start(extendAmount, ...)
		else
			local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
			if elapsed and total then
				local newRemaining = (total + extendAmount) - elapsed
				if not bar.keep then
					--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
					self.mod:Unschedule(removeEntry, self.startedTimers, id)
					self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
				end
				if self.option then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then
						if not bar.fade then--Don't start countdown voice if it's faded bar
							playCountdown(id, newRemaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
							DBM:Debug("Updating a countdown after a timer AddTime call for timer ID:" .. id)
						end
					end
				end
				fireEvent("DBM_TimerUpdate", id, elapsed, total + extendAmount)
				return DBT:UpdateBar(id, elapsed, total + extendAmount)
			end
		end
	end

	function timerPrototype:RemoveTime(reduceAmount, ...)
		if DBM.Options.DontShowBossTimers and not self.mod.isTrashMod then return end
		if DBM.Options.DontShowTrashTimers and self.mod.isTrashMod then return end
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		DBM:Unschedule(playCountSound, id)--Needs to be unscheduled here, or countdown might not be canceled if removing time made it cease to have a > 0 value
		local bar = DBT:GetBar(id)
		if not bar then
			return--Do nothing
		else
			if not bar.keep then
				self.mod:Unschedule(removeEntry, self.startedTimers, id)--Needs to be unscheduled here, or the entry might just get left in table until original expire time, if new expire time is less than 0
			end
			local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
			if elapsed and total then
				local newRemaining = (total - reduceAmount) - elapsed
				if newRemaining > 0 then
					--Correct table for tracked timer objects for adjusted time, or else timers may get stuck if stop is called on them
					if not bar.keep then
						self.mod:Schedule(newRemaining, removeEntry, self.startedTimers, id)
					end
					if self.option and newRemaining > 2 then
						local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
						if (type(countVoice) == "string" or countVoice > 0) then
							if not bar.fade then--Don't start countdown voice if it's faded bar
								if newRemaining > 2 then
									playCountdown(id, newRemaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
									DBM:Debug("Updating a countdown after a timer RemoveTime call for timer ID:" .. id)
								end
							end
						end
					end
					fireEvent("DBM_TimerUpdate", id, elapsed, total - reduceAmount)
					return DBT:UpdateBar(id, elapsed, total - reduceAmount)
				else--New remaining less than 0
					fireEvent("DBM_TimerStop", id)
					removeEntry(self.startedTimers, id)
					return DBT:CancelBar(id)
				end
			end
		end
	end

	function timerPrototype:Pause(...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		DBM:Unschedule(playCountSound, id)--Kill countdown on pause
		if bar then
			if not bar.keep then
				self.mod:Unschedule(removeEntry, self.startedTimers, id)--Prevent removal from startedTimers table while bar is paused
			end
			fireEvent("DBM_TimerPause", id)
			return bar:Pause()
		end
	end

	function timerPrototype:Resume(...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
			if elapsed and total then
				local remaining = total - elapsed
				if not bar.keep then
					self.mod:Schedule(remaining, removeEntry, self.startedTimers, id)--Re-schedule the auto remove entry stuff
				end
				--Have to check if paused bar had a countdown on resume so we can restore it
				if self.option and not bar.fade then
					local countVoice = self.mod.Options[self.option .. "CVoice"] or 0
					if (type(countVoice) == "string" or countVoice > 0) then
						playCountdown(id, remaining, countVoice, self.countdownMax, self.requiresCombat)--timerId, timer, voice, count
						DBM:Debug("Updating a countdown after a timer Resume call for timer ID:" .. id)
					end
				end
			end
			fireEvent("DBM_TimerResume", id)
			return bar:Resume()
		end
	end

	function timerPrototype:UpdateIcon(icon, ...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			icon = parseSpellIcon(icon)
			return bar:SetIcon(icon)
		end
	end

	--This function changes the spellname and callback key (but not option key) of timer object
	--This is needed for faction bosses where we need to swap out a spell key/name on fly after a boss is engaged
	function timerPrototype:UpdateKey(altSpellId, ...)
		--Check if existing bar first,
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		self.spellId = altSpellId
		self.icon = parseSpellIcon(altSpellId, self.type, self.icon)
		self.name = nil--By wiping name, it becomes uncached and can get replaced by GetLocalizedTimerText in :Start
		if bar then
			--If a bar exists while updating key we"
			--Get remainig, kill old timer, start new one with ID/name replacement applied
			local remaining = bar.timer
			self:Stop(...)
			self:Unschedule(...)
			DBM:Unschedule(playCountSound, id)
			self:Start(remaining, ...)--Restart it
		end
	end

	function timerPrototype:UpdateInline(newInline, ...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			local ttext = _G[bar.frame:GetName() .. "BarName"]:GetText() or ""
			return bar:SetText(ttext, newInline or self.inlineIcon)
		end
	end

	function timerPrototype:UpdateName(name, ...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			return bar:SetText(name, self.inlineIcon)
		end
	end

	function timerPrototype:SetColor(c, ...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			return bar:SetColor(c)
		end
	end

	function timerPrototype:DisableEnlarge(...)
		local id = self.id .. pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBT:GetBar(id)
		if bar then
			bar.small = true
		end
	end

	function timerPrototype:AddOption(optionDefault, optionName, colorType, countdown, spellId, optionType, waCustomName)
		if optionName ~= false then
			self.option = optionName or self.id
			self.mod:AddBoolOption(self.option, optionDefault, "timer", nil, colorType, countdown, spellId, optionType, waCustomName)
		end
	end

	--If a new countdown default is added to a NewTimer object, change optionName of timer to reset a new default
	function bossModPrototype:NewTimer(timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType)
		if r and type(r) == "string" then
			DBM:Debug("|cffff0000r probably has inline icon in it and needs to be fixed for |r" .. name .. r)
			r = nil--Fix it for users
		end
		if inlineIcon and type(inlineIcon) == "number" then
			DBM:Debug("|cffff0000spellID texture path or colorType is in inlineIcon field and needs to be fixed for |r" .. name .. inlineIcon)
			inlineIcon = nil--Fix it for users
		end
		icon = parseSpellIcon(icon)
		local waSpecialKey, simpType
		if customType then
			simpType = timerTypeSimplification[customType] or customType
			waSpecialKey = waKeyOverrides[customType]
		end
		---@class Timer
		local obj = setmetatable(
			{
				text = self.localization.timers[name],
				type = customType or "cd",--Auto assign
				simpType = simpType or "cd",
				waSpecialKey = waSpecialKey,
				spellId = spellId,--Allows Localized timer text to still have a spellId arg weak auras can latch onto
				timer = timer,
				id = name,
				icon = icon,
				colorType = colorType or 0,
				inlineIcon = inlineIcon,
				keep = keep,
				countdown = countdown,
				countdownMax = countdownMax,
				r = r,
				g = g,
				b = b,
				requiresCombat = requiresCombat,
				startedTimers = {},
				mod = self,
				startLarge = nil,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown, spellId, nil, waCustomName)
		tinsert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- If a new countdown is added to an existing timer that didn't have one before, use optionName (number) to force timer to reset defaults by assigning it a new variable
	---@param timerType string
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b, requiresCombat)
		if type(timer) == "string" and timer:match("OptionVersion") then
			error("OptionVersion hack deprecated, remove it from: " .. spellId)
		end
		if type(colorType) == "number" and colorType > 8 then
			DBM:AddMsg("|cffff0000texture is in the colorType arg for: |r" .. spellId)
		end
		--Use option optionName for optionVersion as well, no reason to split.
		--This ensures that remaining arg positions match for auto generated and regular NewTimer
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local allowdouble
		if type(timer) == "string" and timer:match("d%d+") then
			allowdouble = true
			timer = tonumber(string.sub(timer, 2))
		end
		local spellName, icon
		spellName = parseSpellName(spellId, timerType)
		local unparsedId = spellId
		if timerType == "achievement" then
			icon = parseSpellIcon(texture or spellId, timerType)
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "stagecontext" or timerType == "stagecontextcount" or timerType == "intermission" or timerType == "intermissioncount" then
			icon = parseSpellIcon(texture or spellId, timerType)
			if timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "stagecontext" or timerType == "stagecontextcount" or timerType == "intermission" or timerType == "intermissioncount" then
				colorType = 6
			end
		elseif timerType == "roleplay" then
			icon = parseSpellIcon(texture or spellId, timerType, isRetail and 237538 or 136106)
			colorType = 6
		elseif timerType == "adds" or timerType == "addscustom" then
			icon = parseSpellIcon(texture or spellId, timerType, 136116)
			colorType = 1
		else
			icon = parseSpellIcon(texture or spellId, timerType)
			colorType = colorType or 0
		end
		local timerTextValue
		if timerText then
			--First check if it's shorttext
			if DBM.Options.ShortTimerText then
				--If timertext is a number, accept it as a secondary auto translate spellid
				if type(timerText) == "number" then
					timerTextValue = timerText
					spellName = DBM:GetSpellInfo(timerText or 0)--Override Cached spell Name
				--Interpret it literal with no restrictions, first checking mod local table, then just taking timerText directly
				else
					timerTextValue = self.localization.timers[timerText]--Check timers table first, otherwise accept it as literal timer text
				end
			else--Short text is off, we want to be more aggressive in NOT setting short text if we can help it
				--Short text is off, and spellId does exist, only accept timerText if it's in mods localization tables, cause then it's not short text, it's hard localization
				if spellId and type(spellId) == "number" then
					--Only use timerText if it's full localized, cause that's not shorttext
					timerTextValue = rawget(self.localization.timers, timerText)
				else--If no spellID, then we allow hard setting timerText because it's only translation timer object has
					timerTextValue = self.localization.timers[timerText]
				end
			end
		end
		local id = "Timer" .. (spellId or 0) .. timerType .. (optionVersion or "")
		local simpType = timerTypeSimplification[timerType] or timerType
		local waSpecialKey = waKeyOverrides[timerType]
		---@class Timer
		local obj = setmetatable(
			{
				text = timerTextValue,
				type = timerType,
				simpType = simpType,
				waSpecialKey = waSpecialKey,--Not same as simpType, this overrides option key
				spellId = spellId,
				name = spellName,--If name gets stored as nil, it'll be corrected later in Timer start, if spell name returns in a later attempt
				timer = timer,
				id = id,
				icon = icon,
				colorType = colorType,
				inlineIcon = inlineIcon,
				keep = keep,
				countdown = countdown,
				countdownMax = countdownMax,
				r = r,
				g = g,
				b = b,
				requiresCombat = requiresCombat,
				allowdouble = allowdouble,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown, spellId, timerType)
		tinsert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if not self.localization.options[id] or self.localization.options[id] == id then
			if timerType == "achievement" then
				self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format((GetAchievementLink(spellId) or ""):gsub("%[(.+)%]", "%1"))
			elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" or timerType == "stagecount" or timerType == "stagecountcycle" or timerType == "intermission" or timerType == "intermissioncount" or timerType == "roleplay" then--Timers without spellid, generic (do not add stagecontext here, it has spellname parsing)
				self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]--Using more than 1 stage timer or more than 1 special timer will break this, fortunately you should NEVER use more than 1 of either in a mod
			else
				self.localization.options[id] = L.AUTO_TIMER_OPTIONS[timerType]:format(unparsedId)
			end
		end
		return obj
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewTargetCountTimer(...)
		return newTimer(self, "targetcount", ...)
	end

	--Buff/Debuff/event on boss
	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
	end

	----Buff/Debuff on players
	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewBuffFadesTimer(...)
		return newTimer(self, "fades", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCastTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "cast", timer, ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCastCountTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castcount", timer, ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCastSourceTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(10059)) / 10000 -- 10059 = Stormwind Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastSourceTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castsource", timer, ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCDTimer(...)
		return newTimer(self, "cd", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCDCountTimer(...)
		return newTimer(self, "cdcount", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCDSourceTimer(...)
		return newTimer(self, "cdsource", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewNextTimer(...)
		return newTimer(self, "next", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewNextCountTimer(...)
		return newTimer(self, "nextcount", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewNextSourceTimer(...)
		return newTimer(self, "nextsource", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewAchievementTimer(...)
		return newTimer(self, "achievement", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCDSpecialTimer(...)
		return newTimer(self, "cdspecial", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewNextSpecialTimer(...)
		return newTimer(self, "nextspecial", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCDComboTimer(...)
		return newTimer(self, "cdcombo", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewNextComboTimer(...)
		return newTimer(self, "nextcombo", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewStageTimer(...)
		return newTimer(self, "stage", ...)
	end
	bossModPrototype.NewPhaseTimer = bossModPrototype.NewStageTimer--Deprecated naming, once all mods are converted over, NewPhaseTimer will be wiped out for NewStageTimer

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewStageCountTimer(...)
		return newTimer(self, "stagecount", ...)
	end

	--Used mainly for compat with BW/LW timers where they use "stages" but then use the spell/journal descriptor instead of "stage d"
	--Basically, it's a generic spellName timer for "stages" callback
	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewStageContextTimer(...)
		return newTimer(self, "stagecontext", ...)
	end

	--Same as NewStageContextTimer, with count
	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewStageContextCountTimer(...)
		return newTimer(self, "stagecontextcount", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewStageCountCycleTimer(...)
		return newTimer(self, "stagecountcycle", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewIntermissionTimer(...)
		return newTimer(self, "intermission", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewIntermissionCountTimer(...)
		return newTimer(self, "intermissioncount", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewRPTimer(...)
		return newTimer(self, "roleplay", ...)
	end

	function bossModPrototype:NewCombatTimer(timer)
		return newTimer(self, "combat", timer, nil, nil, nil, nil, 0, "132349", nil, nil, 1, 5)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewAddsTimer(...)
		return newTimer(self, "adds", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewAddsCustomTimer(...)
		return newTimer(self, "addscustom", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCDNPTimer(...)
		return newTimer(self, "cdnp", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewNextNPTimer(...)
		return newTimer(self, "nextnp", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewCDCountNPTimer(...)
		return newTimer(self, "cdcountnp", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewNextCountNPTimer(...)
		return newTimer(self, "nextcountnp", ...)
	end

	---@overload fun(self: DBMMod, timer: number|string, spellId: number|string?, timerText: number|string?, optionDefault: boolean|string?, optionName: string|number?, colorType: number?, texture: number|string?, inlineIcon: string?, keep: boolean?, countdown: number?, countdownMax: number?, r: number?, g: number?, b: number?, requiresCombat: boolean?): Timer
	function bossModPrototype:NewAITimer(...)
		return newTimer(self, "ai", ...)
	end

	function bossModPrototype:GetLocalizedTimerText(timerType, spellId, Name)
		local spellName
		if Name then
			spellName = Name--Pull from name stored in object
		elseif spellId then
			DBM:Debug("|cffff0000GetLocalizedTimerText fallback, this should not happen and is a bug. this fallback should be deleted if this message is never seen after async code is live|r")
			spellName = parseSpellName(spellId, timerType)
			--Name wasn't provided, but we succeeded in getting a name, generate one into object now for caching purposes
			--This would really only happen if GetSpellInfo failed to return spell name on first attempt (which now happens in 9.0)
			if spellName then
				self.name = spellName
			end
		end
		return pformat(L.AUTO_TIMER_TEXTS[timerType], spellName)
	end
end

------------------------------
--  Berserk/Combat Objects  --
------------------------------
do
	---@class EnrageTimer
	local enragePrototype = {}
	local mt = {__index = enragePrototype}

	function enragePrototype:Start(timer)
		--User only has timer object exposed in mod options, check that here to also prevent the warnings.
		if not self.owner.Options.timer_berserk then return end
		timer = timer or self.timer or 600
		timer = timer <= 0 and self.timer - mabs(timer) or timer
		self.bar:SetTimer(timer)
		self.bar:Start()
		if not DBM.Options.ShowBerserkWarnings then return end
		if self.warning1 then
			if timer > 660 then self.warning1:Schedule(timer - 600, 10, L.MIN) end
			if timer > 300 then self.warning1:Schedule(timer - 300, 5, L.MIN) end
			if timer > 180 then self.warning2:Schedule(timer - 180, 3, L.MIN) end
		end
		if self.warning2 then
			if timer > 60 then self.warning2:Schedule(timer - 60, 1, L.MIN) end
			if timer > 30 then self.warning2:Schedule(timer - 30, 30, L.SEC) end
			if timer > 10 then self.warning2:Schedule(timer - 10, 10, L.SEC) end
		end
	end

	function enragePrototype:Schedule(t)
		return self.owner:Schedule(t, self.Start, self)
	end

	function enragePrototype:Cancel()
		self.owner:Unschedule(self.Start, self)
		if self.warning1 then
			self.warning1:Cancel()
		end
		if self.warning2 then
			self.warning2:Cancel()
		end
		self.bar:Stop()
	end
	enragePrototype.Stop = enragePrototype.Cancel

	function bossModPrototype:NewBerserkTimer(timer, text, barText, barIcon)
		timer = timer or 600
		local warning1 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 1, nil, nil, false)
		local warning2 = self:NewAnnounce(text or L.GENERIC_WARNING_BERSERK, 4, nil, nil, false)
		--timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
		local bar = self:NewTimer(timer, barText or L.GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, "berserk")
		---@class EnrageTimer
		local obj = setmetatable(
			{
				warning1 = warning1,
				warning2 = warning2,
				bar = bar,
				timer = timer,
				owner = self
			},
			mt
		)
		return obj
	end
end

---------------
--  Options  --
---------------
function bossModPrototype:AddBoolOption(name, default, cat, func, extraOption, extraOptionTwo, spellId, optionType, waCustomName)
	if checkDuplicateObjects[name] and name ~= "timer_berserk" then
		DBM:Debug("|cffff0000Option already exists for: |r" .. name)
	else
		checkDuplicateObjects[name] = true
	end
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	if cat == "timer" then
		self.DefaultOptions[name .. "TColor"] = extraOption or 0
		self.DefaultOptions[name .. "CVoice"] = extraOptionTwo or 0
	end
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if cat == "timer" then
		self.Options[name .. "TColor"] = extraOption or 0
		self.Options[name .. "CVoice"] = extraOptionTwo or 0
	end
	if spellId then
		if waCustomName then--Do custom shit for options using invalid spellIds as weak auras keys
			self:GroupWASpells(waCustomName, spellId, name)
		else
			if optionType and optionType == "achievement" then
				spellId = "at" .. spellId--"at" for achievement timer
			end
			local optionTypeMatch = optionType or ""
			if not optionTypeMatch:find("stage") then
				self:GroupSpells(spellId, name)
			end
		end
	end
	self:SetOptionCategory(name, cat, optionType, waCustomName)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddSpecialWarningOption(name, default, defaultSound, cat, spellId, optionType, waCustomName)
	if checkDuplicateObjects[name] then
		DBM:Debug("|cffff0000Option already exists for: |r" .. name)
	else
		checkDuplicateObjects[name] = true
	end
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	self.DefaultOptions[name .. "SWSound"] = defaultSound or 1
	self.DefaultOptions[name .. "SWNote"] = true
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self.Options[name .. "SWSound"] = defaultSound or 1
	self.Options[name .. "SWNote"] = true
	if spellId then
		if waCustomName then--Do custom shit for options using invalid spellIds as weak auras keys
			self:GroupWASpells(waCustomName, spellId, name)
		else
			self:GroupSpells(spellId, name)
		end
	end
	self:SetOptionCategory(name, cat, optionType, waCustomName)
end

--auraspellId must match debuff ID so EnablePrivateAuraSound function can call right option key and right debuff ID
--groupSpellId is used if a diff option key is used in all other options with spell (will be quite common)
--defaultSound is used to set default Special announce sound (1-4) just like regular special announce objects
function bossModPrototype:AddPrivateAuraSoundOption(auraspellId, default, groupSpellId, defaultSound)
	self.DefaultOptions["PrivateAuraSound" .. auraspellId] = (default == nil) or default
	self.DefaultOptions["PrivateAuraSound" .. auraspellId .. "SWSound"] = defaultSound or 1
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["PrivateAuraSound" .. auraspellId] = (default == nil) or default
	self.Options["PrivateAuraSound" .. auraspellId .. "SWSound"] = defaultSound or 1
	self.localization.options["PrivateAuraSound" .. auraspellId] = L.AUTO_PRIVATEAURA_OPTION_TEXT:format(auraspellId)
	self:GroupSpellsPA(groupSpellId or auraspellId, "PrivateAuraSound" .. auraspellId)
	self:SetOptionCategory("PrivateAuraSound" .. auraspellId, "paura", nil, nil, true)
end

--Function to actually register specific media to specific auras
--auraspellId: Private aura spellId
--voice: voice pack media path
--voiceVersion: Required voice pack verion (if not met, falls back to airhorn
function bossModPrototype:EnablePrivateAuraSound(auraspellId, voice, voiceVersion, altOptionId)
	if DBM.Options.DontPlayPrivateAuraSound then return end
	local optionId = altOptionId or auraspellId
	if self.Options["PrivateAuraSound" .. optionId] then
		if not self.paSounds then self.paSounds = {} end
		local soundId = self.Options["PrivateAuraSound" .. optionId .. "SWSound"] or DBM.Options.SpecialWarningSound--Shouldn't be nil value, but just in case options fail to load, fallback to default SW1 sound
		local mediaPath
		--Check valid voice pack sound
		local chosenVoice = DBM.Options.ChosenVoicePack2
		if chosenVoice ~= "None" and not voiceSessionDisabled and voiceVersion <= SWFilterDisabled then
			local isVoicePackUsed
			--Vet if user has voice pack enabled by sound ID
			if type(soundId) == "number" and soundId < 5 then--Value 1-4 are SW1 defaults, otherwise it's file data ID and handled by Custom
				isVoicePackUsed = DBM.Options["VPReplacesSA" .. soundId]
			else
				isVoicePackUsed = DBM.Options.VPReplacesCustom
			end
			if isVoicePackUsed then
				mediaPath = "Interface\\AddOns\\DBM-VP" .. chosenVoice .. "\\" .. voice .. ".ogg"
			else
				mediaPath = type(soundId) == "number" and DBM.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId
			end
		else
			mediaPath = type(soundId) == "number" and DBM.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId
		end
		--Absolute media path is still a number, so at this point we know it's file data Id, we need to set soundFileID
		if type(mediaPath) == "number" then
			self.paSounds[#self.paSounds + 1] = C_UnitAuras.AddPrivateAuraAppliedSound({
				spellID = auraspellId,
				unitToken = "player",
				soundFileID = mediaPath,
				outputChannel = "master",
			})
		else--It's a string, so it's not an ID, we need to set soundFileName instead
			self.paSounds[#self.paSounds + 1] = C_UnitAuras.AddPrivateAuraAppliedSound({
				spellID = auraspellId,
				unitToken = "player",
				soundFileName = mediaPath,
				outputChannel = "master",
			})
		end
	end
end

--TODO, add ability to remove specific ID only with this function. I'm not so good with tables though so gotta figure it out later
function bossModPrototype:DisablePrivateAuraSounds()
	if DBM.Options.DontPlayPrivateAuraSound then return end
	for _, id in next, self.paSounds do
		C_UnitAuras.RemovePrivateAuraAppliedSound(id)
	end
	self.paSounds = nil
end

--Extended Icon Usage Notes
--Any time extended icons is used, option must be OFF by default
--Option must be hidden from GUI if extended icoins not enabled
--If extended icons are disabled, then on mod load, users option is reset to default (off) to prevent their mod from still executing SetIcon functions (this is because even if it's hidden from GUI, if option was created and enabled, it'd still run)
function bossModPrototype:AddSetIconOption(name, spellId, default, iconType, iconsUsed, conflictWarning, groupSpellId)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if (groupSpellId or spellId) and not DBM.Options.GroupOptionsExcludeIcon then
		self:GroupSpells(groupSpellId or spellId, name)
	end
	self:SetOptionCategory(name, "icon")
	--Legacy bool and nil support
	if type(iconType) ~= "number" then
		if iconType then--true
			iconType = 5
		else --false/nil
			iconType = 0
		end
	end
	if iconType == 1 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MELEE_A:format(spellId) or self.localization.options[name]
	elseif iconType == 2 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MELEE_R:format(spellId) or self.localization.options[name]
	elseif iconType == 3 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_RANGED_A:format(spellId) or self.localization.options[name]
	elseif iconType == 4 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_RANGED_R:format(spellId) or self.localization.options[name]
	elseif iconType == 5 then
		--NPC/Mob setting uses icon elect feature and needs to establish latency check table
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_NPCS:format(spellId) or self.localization.options[name]
	elseif iconType == 6 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_ALPHA:format(spellId) or self.localization.options[name]
	elseif iconType == 7 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_ROSTER:format(spellId) or self.localization.options[name]
	elseif iconType == 8 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TANK_A:format(spellId) or self.localization.options[name]
	elseif iconType == 9 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TANK_R:format(spellId) or self.localization.options[name]
	else--Type 0 (Generic for targets)
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS:format(spellId) or self.localization.options[name]
	end
	--A table defining used icons by number, insert icon textures to end of option
	if iconsUsed then
		self.localization.options[name] = self.localization.options[name] .. " ("
		for i = 1, #iconsUsed do
			--Texture ID 137009 if direct calling RaidTargetingIcons stops working one day
			---
			if 		iconsUsed[i] == 1 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t"
			elseif	iconsUsed[i] == 2 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t"
			elseif	iconsUsed[i] == 3 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t"
			elseif	iconsUsed[i] == 4 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"
			elseif	iconsUsed[i] == 5 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t"
			elseif	iconsUsed[i] == 6 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t"
			elseif	iconsUsed[i] == 7 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t"
			elseif	iconsUsed[i] == 8 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t"
--			elseif	iconsUsed[i] == 9 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:32:48|t"
--			elseif	iconsUsed[i] == 10 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:32:48|t"
--			elseif	iconsUsed[i] == 11 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:32:48|t"
--			elseif	iconsUsed[i] == 12 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:32:48|t"
--			elseif	iconsUsed[i] == 13 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:48:64|t"
--			elseif	iconsUsed[i] == 14 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:48:64|t"
--			elseif	iconsUsed[i] == 15 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:48:64|t"
--			elseif	iconsUsed[i] == 16 then		self.localization.options[name] = self.localization.options[name] .. "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:48:64|t"
			end
		end
		self.localization.options[name] = self.localization.options[name] .. ")"
		if conflictWarning then
			self.localization.options[name] = self.localization.options[name] .. L.AUTO_ICONS_OPTION_CONFLICT
		end
	end
end

function bossModPrototype:AddArrowOption(name, spellId, default, isRunTo)
	if isRunTo == true then isRunTo = 2 end--Support legacy
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:GroupSpells(spellId, name)
	self:SetOptionCategory(name, "misc")
	if isRunTo == 2 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT:format(spellId)
	elseif isRunTo == 3 then
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT3:format(spellId)
	else
		self.localization.options[name] = L.AUTO_ARROW_OPTION_TEXT2:format(spellId)
	end
end

function bossModPrototype:AddRangeFrameOption(range, spellId, default)
	self.DefaultOptions["RangeFrame"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["RangeFrame"] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, "RangeFrame")
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT:format(range, spellId)
	else
		self.localization.options["RangeFrame"] = L.AUTO_RANGE_OPTION_TEXT_SHORT:format(range)
	end
	self:SetOptionCategory("RangeFrame", "misc")
end

function bossModPrototype:AddHudMapOption(name, spellId, default)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, name)
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT:format(spellId)
	else
		self.localization.options[name] = L.AUTO_HUD_OPTION_TEXT_MULTI
	end
	self:SetOptionCategory(name, "misc")
end

function bossModPrototype:AddNamePlateOption(name, spellId, default, forceDBM)
	if not spellId then
		error("AddNamePlateOption must provide valid spellId", 2)
	end
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:GroupSpells(spellId, name)
	self:SetOptionCategory(name, "nameplate")
	self.localization.options[name] = forceDBM and L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED:format(spellId) or L.AUTO_NAMEPLATE_OPTION_TEXT:format(spellId)
end

function bossModPrototype:AddInfoFrameOption(spellId, default, optionVersion, optionalThreshold)
	local oVersion = ""
	if optionVersion then
		oVersion = tostring(optionVersion)
	end
	self.DefaultOptions["InfoFrame" .. oVersion] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["InfoFrame" .. oVersion] = (default == nil) or default
	if spellId then
		self:GroupSpells(spellId, "InfoFrame" .. oVersion)
		if optionalThreshold then
			self.localization.options["InfoFrame" .. oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT3:format(spellId, optionalThreshold)
		else
			self.localization.options["InfoFrame" .. oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT:format(spellId)
		end
	else
		self.localization.options["InfoFrame" .. oVersion] = L.AUTO_INFO_FRAME_OPTION_TEXT2
	end
	self:SetOptionCategory("InfoFrame" .. oVersion, "misc")
end

function bossModPrototype:AddReadyCheckOption(questId, default, maxLevel)
	self.readyCheckQuestId = questId
	self.readyCheckMaxLevel = maxLevel or 999
	self.DefaultOptions["ReadyCheck"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["ReadyCheck"] = (default == nil) or default
	self.localization.options["ReadyCheck"] = L.AUTO_READY_CHECK_OPTION_TEXT
	self:SetOptionCategory("ReadyCheck", "misc")
end

function bossModPrototype:AddSpeedClearOption(name, default)
	self.DefaultOptions["SpeedClearTimer"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["SpeedClearTimer"] = (default == nil) or default
	self:SetOptionCategory("SpeedClearTimer", "timer")
	self.localization.options["SpeedClearTimer"] = L.AUTO_SPEEDCLEAR_OPTION_TEXT:format(name)
end

-- FIXME: this function does not reset any settings to default if you remove an option in a later revision and a user has selected this option in an earlier revision were it still was available
-- this will be fixed as soon as it is necessary due to removed options ;-)
function bossModPrototype:AddDropdownOption(name, options, default, cat, func, spellId)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "dropdown", value = default}
	self.Options[name] = default
	if spellId then
		self:GroupSpells(spellId, name)
	end
	self:SetOptionCategory(name, cat)
	self.dropdowns = self.dropdowns or {}
	self.dropdowns[name] = options
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddOptionSpacer(cat)
	cat = cat or "misc"
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], DBM_OPTION_SPACER)
	end
end

do
	local lineCount = 1

	function bossModPrototype:AddOptionLine(text, cat, forceIgnore)
		if self.addon and not forceIgnore then
			self.groupOptions["line" .. lineCount] = text
			lineCount = lineCount + 1
		else
			cat = cat or "misc"
			if not self.optionCategories[cat] then
				self.optionCategories[cat] = {}
			end
			if self.optionCategories[cat] then
				tinsert(self.optionCategories[cat], {line = true, text = text})
			end
		end
	end
end

function bossModPrototype:AddAnnounceSpacer()
	return self:AddOptionSpacer("announce")
end

function bossModPrototype:AddTimerSpacer()
	return self:AddOptionSpacer("timer")
end

function bossModPrototype:AddAnnounceLine(text)
	return self:AddOptionLine(text, "announce")
end

function bossModPrototype:AddTimerLine(text)
	return self:AddOptionLine(text, "timer")
end

function bossModPrototype:AddNamePlateLine(text)
	return self:AddOptionLine(text, "nameplate")
end

function bossModPrototype:AddIconLine(text)
	return self:AddOptionLine(text, "icon")
end

function bossModPrototype:AddMiscLine(text)
	return self:AddOptionLine(text, "misc", true)
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for k, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[k] = nil
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

--This function, which will be called after all iterations of GroupWASpells/GroupSpells will just straight up say "ok now ignore keys these made and just use custom ones" for extremely niche cases
function bossModPrototype:JustSetCustomKeys(catSpell, customKeys)
	catSpell = tostring(catSpell)
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	if not self.groupOptions[catSpell] then
		self.groupOptions[catSpell] = {}
	end
	self.groupOptions[catSpell].customKeys = customKeys
end

--Custom function for handling group spells where we want to group by ID, but not use that IDs name (basically a fake Id for purpose of a unified WA key)
--This lets us group options up that aren't using valid IDs, and show the ID it is using for WA in the gui next to custom name
function bossModPrototype:GroupWASpells(customName, ...)
	local spells = {...}
	local catSpell = tostring(tremove(spells, 1))
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	for _, spell in ipairs(spells) do
		local sSpell = tostring(spell)
		self.groupSpells[sSpell] = catSpell
		if sSpell ~= catSpell and self.groupOptions[sSpell] then
			if not self.groupOptions[catSpell] then
				self.groupOptions[catSpell] = {}
				self.groupOptions[catSpell].title = customName
			end
			for _, spell2 in ipairs(self.groupOptions[sSpell]) do
				tinsert(self.groupOptions[catSpell], spell2)
			end
			self.groupOptions[sSpell] = nil
		end
	end
end

--Duplicate function just for private auras to do literally same thing as GroupSpells without ability to pass extra arg
function bossModPrototype:GroupSpellsPA(...)
	local spells = {...}
	local catSpell = tostring(tremove(spells, 1))
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	for _, spell in ipairs(spells) do
		local sSpell = tostring(spell)
		self.groupSpells[sSpell] = catSpell
		if sSpell ~= catSpell and self.groupOptions[sSpell] then
			if not self.groupOptions[catSpell] then
				self.groupOptions[catSpell] = {}
				self.groupOptions[catSpell].hasPrivate = true--This single line is basically why GroupSpellsPA had to duplicate GroupSpells
			end
			for _, spell2 in ipairs(self.groupOptions[sSpell]) do
				tinsert(self.groupOptions[catSpell], spell2)
			end
			self.groupOptions[sSpell] = nil
		end
	end
end

function bossModPrototype:GroupSpells(...)
	local spells = {...}
	local catSpell = tostring(tremove(spells, 1))
	if not self.groupSpells[catSpell] then
		self.groupSpells[catSpell] = {}
	end
	for _, spell in ipairs(spells) do
		local sSpell = tostring(spell)
		self.groupSpells[sSpell] = catSpell
		if sSpell ~= catSpell and self.groupOptions[sSpell] then
			if not self.groupOptions[catSpell] then
				self.groupOptions[catSpell] = {}
			end
			for _, spell2 in ipairs(self.groupOptions[sSpell]) do
				tinsert(self.groupOptions[catSpell], spell2)
			end
			self.groupOptions[sSpell] = nil
		end
	end
end

function bossModPrototype:SetOptionCategory(name, cat, optionType, waCustomName, hasPrivate)
	optionType = optionType or ""
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if self.addon and self.groupSpells[name] and not (optionType == "gtfo" or optionType == "adds" or optionType == "addscount" or optionType == "addscustom" or optionType:find("stage") or cat == "icon" and DBM.Options.GroupOptionsExcludeIcon) then
		local sSpell = self.groupSpells[name]
		if not self.groupOptions[sSpell] then
			self.groupOptions[sSpell] = {}
		end
		if waCustomName and not self.groupOptions[sSpell].title then
			self.groupOptions[sSpell].title = waCustomName
		end
		if hasPrivate and not self.groupOptions[sSpell].hasPrivate then
			self.groupOptions[sSpell].hasPrivate = true
		end
		tinsert(self.groupOptions[sSpell], name)
	else
		if not self.optionCategories[cat] then
			self.optionCategories[cat] = {}
		end
		tinsert(self.optionCategories[cat], name)
		tinsert(self.categorySort, cat)
	end
end

--------------
--  Combat  --
--------------
function bossModPrototype:RegisterCombat(cType, ...)
	if cType then
		cType = cType:lower()
	end
	local info = {
		type = cType,
		mob = self.creatureId,
		eId = self.encounterId,
		name = self.localization.general.name or self.id,
		msgs = (cType ~= "combat") and {...},
		mod = self
	}
	if self.multiMobPullDetection then
		info.multiMobPullDetection = self.multiMobPullDetection
	end
	if self.multiEncounterPullDetection then
		info.multiEncounterPullDetection = self.multiEncounterPullDetection
	end
	if self.noESDetection then
		info.noESDetection = self.noESDetection
	end
	if self.noEEDetection then
		info.noEEDetection = self.noEEDetection
	end
	if self.noBKDetection then
		info.noBKDetection = self.noBKDetection
	end
	if self.noIEEUDetection then
		info.noIEEUDetection = self.noIEEUDetection
	end
	if self.noFriendlyEngagement then
		info.noFriendlyEngagement = self.noFriendlyEngagement
	end
	if self.noRegenDetection then
		info.noRegenDetection = self.noRegenDetection
	end
	if self.noMultiBoss then
		info.noMultiBoss = self.noMultiBoss
	end
	if self.WBEsync then
		info.WBEsync = self.WBEsync
	end
	if self.noBossDeathKill then
		info.noBossDeathKill = self.noBossDeathKill
	end
	-- use pull-mobs as kill mobs by default, can be overriden by RegisterKill
	if self.multiMobPullDetection then
		for _, v in ipairs(self.multiMobPullDetection) do
			info.killMobs = info.killMobs or {}
			info.killMobs[v] = true
		end
	end
	self.combatInfo = info
	if not self.zones then return end
	for v in pairs(self.zones) do
		combatInfo[v] = combatInfo[v] or {}
		tinsert(combatInfo[v], info)
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:RegisterKill(msgType, ...)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	if msgType == "kill" then
		if select("#", ...) > 0 then -- calling this method with 0 IDs means "use the values from SetCreatureID", this is already done by RegisterCombat as calling RegisterKill should be optional --> mod:RegisterKill("kill") with no IDs is never necessary
			self.combatInfo.killMobs = {}
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if type(v) == "number" then
					self.combatInfo.killMobs[v] = true
				end
			end
		end
	else
		self.combatInfo.killType = msgType
		self.combatInfo.killMsgs = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			self.combatInfo.killMsgs[v] = true
		end
	end
end

function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.noCombatInVehicle = not flag
end

function bossModPrototype:SetCreatureID(...)
	self.creatureId = ...
	if select("#", ...) > 1 then
		self.multiMobPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiMobPullDetection = self.multiMobPullDetection
			if not self.multiIDSingleBoss then
				self.numBoss = #self.multiMobPullDetection
				if self.inCombat then
					--Called mid combat, fix some variables
					self.vb.bossLeft = self.numBoss
				end
			else
				self.numBoss = 1
			end
		end
		for i = 1, select("#", ...) do
			local cId = select(i, ...)
			bossIds[cId] = true
		end
	else
		local cId = ...
		bossIds[cId] = true
		self.numBoss = 1
	end
end

function bossModPrototype:SetEncounterID(...)
	self.encounterId = ...
	if select("#", ...) > 1 then
		self.multiEncounterPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiEncounterPullDetection = self.multiEncounterPullDetection
		end
	end
end

function bossModPrototype:DisableESCombatDetection()
	self.noESDetection = true
	if self.combatInfo then
		self.combatInfo.noESDetection = true
	end
end

function bossModPrototype:DisableEEKillDetection()
	self.noEEDetection = true
	if self.combatInfo then
		self.combatInfo.noEEDetection = true
	end
end

function bossModPrototype:DisableBKKillDetection()
	self.noBKDetection = true
	if self.combatInfo then
		self.combatInfo.noBKDetection = true
	end
end

function bossModPrototype:DisableIEEUCombatDetection()
	self.noIEEUDetection = true
	if self.combatInfo then
		self.combatInfo.noIEEUDetection = true
	end
end

function bossModPrototype:DisableFriendlyDetection()
	self.noFriendlyEngagement = true
	if self.combatInfo then
		self.combatInfo.noFriendlyEngagement = true
	end
end

function bossModPrototype:DisableRegenDetection()
	self.noRegenDetection = true
	if self.combatInfo then
		self.combatInfo.noRegenDetection = true
	end
end

function bossModPrototype:DisableMultiBossPulls()
	self.noMultiBoss = true
	if self.combatInfo then
		self.combatInfo.noMultiBoss = true
	end
end

function bossModPrototype:EnableWBEngageSync()
	self.WBEsync = true
	if self.combatInfo then
		self.combatInfo.WBEsync = true
	end
end

function bossModPrototype:DisableBossDeathKill()
	self.noBossDeathKill = true
	if self.combatInfo then
		self.combatInfo.noBossDeathKill = true
	end
end

function bossModPrototype:SetMultiIDSingleBoss()
	self.multiIDSingleBoss = true
end

--used for knowing if a specific mod is engaged
function bossModPrototype:IsInCombat()
	return self.inCombat
end

--Used for knowing if any person is in any kind of combat period
function bossModPrototype:GroupInCombat()
	local combatFound = false
	--Any Boss engaged
	if IsEncounterInProgress() then
		combatFound = true
	end
	--Self in Combat
	if InCombatLockdown() or UnitAffectingCombat("player") then
		combatFound = true
	end
	--Any Other group member in combat
	if not combatFound then
		for uId in DBM:GetGroupMembers() do
			if UnitAffectingCombat(uId) and not UnitIsDeadOrGhost(uId) then
				combatFound = true
				break
			end
		end
	end
	return combatFound
end

function bossModPrototype:IsAlive()
	return not UnitIsDeadOrGhost("player")
end

function bossModPrototype:SetMinCombatTime(t)
	self.minCombatTime = t
end

-- needs to be called after RegisterCombat
function bossModPrototype:SetWipeTime(t)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.wipeTimer = t
end

-- fix for LFR ToES Tsulong combat detection bug after killed.
function bossModPrototype:SetReCombatTime(t, t2)--T1, after kill. T2 after wipe
	self.reCombatTime = t
	self.reCombatTime2 = t2
end

function bossModPrototype:SetOOCBWComms()
	tinsert(oocBWComms, self)
end

-----------------------
--  Synchronization  --
-----------------------
function bossModPrototype:SendSync(event, ...)
	event = event or ""
	local arg = select("#", ...) > 0 and strjoin("\t", tostringall(...)) or ""
	local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision or 0, event, arg)
	local spamId = self.id .. event .. arg -- *not* the same as the sync string, as it doesn't use the revision information
	local time = GetTime()
	--Mod syncs are more strict and enforce latency threshold always.
	--Do not put latency check in main sendSync local function (line 313) though as we still want to get version information, etc from these users.
	if not private.modSyncSpam[spamId] or (time - private.modSyncSpam[spamId]) > 8 then
		self:ReceiveSync(event, playerName, self.revision or 0, tostringall(...))
		sendSync(DBMSyncProtocol, "M", str)
	end
end

function bossModPrototype:SendBigWigsSync(msg, extra)
	if not dbmIsEnabled then return end
	msg = "B^" .. msg
	if extra then
		msg = msg .. "^" .. extra
	end
	if IsInGroup() then
		SendAddonMessage("BigWigs", msg, IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
	end
end

function bossModPrototype:ReceiveSync(event, sender, revision, ...)
	local spamId = self.id .. event .. strjoin("\t", ...)
	local time = GetTime()
	if (not private.modSyncSpam[spamId] or (time - private.modSyncSpam[spamId]) > self.SyncThreshold) and self.OnSync and (not self.minSyncRevision or revision >= self.minSyncRevision) then
		private.modSyncSpam[spamId] = time
		-- we have to use the sender as last argument for compatibility reasons (stupid old API...)
		-- avoid table allocations for frequently used number of arguments
		if select("#", ...) <= 1 then
			-- syncs with no arguments have an empty argument (also for compatibility reasons)
			self:OnSync(event, ... or "", sender)
		elseif select("#", ...) == 2 then
			self:OnSync(event, ..., select(2, ...), sender)
		else
			local tmp = {...}
			tmp[#tmp + 1] = sender
			self:OnSync(event, unpack(tmp))
		end
	end
end

function bossModPrototype:SetRevision(revision)
	revision = parseCurseDate(revision or "")
	if not revision or type(revision) == "string" then
		-- bad revision: either forgot the svn keyword or using github
		revision = DBM.Revision
	end
	self.revision = revision
end

--Either treat it as a valid number, or a curse string that needs to be made into a valid number
function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

function bossModPrototype:SetHotfixNoticeRev(revision)
	self.hotfixNoticeRev = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

-----------------
--  Scheduler  --
-----------------
function bossModPrototype:Schedule(t, f, ...)
	return DBMScheduler:Schedule(t, f, self, ...)
end

function bossModPrototype:Unschedule(f, ...)
	return DBMScheduler:Unschedule(f, self, ...)
end

function bossModPrototype:ScheduleMethod(t, method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Schedule(t, self[method], self, ...)
end
bossModPrototype.ScheduleEvent = bossModPrototype.ScheduleMethod

function bossModPrototype:UnscheduleMethod(method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Unschedule(self[method], self, ...)
end
bossModPrototype.UnscheduleEvent = bossModPrototype.UnscheduleMethod

-------------
--  Icons  --
-------------
do
	function DBM:ElectIconSetter(mod)
		--elect icon person
		if mod.findFastestComputer and not self.Options.DontSetIcons then
			if mod:IsDungeon() or self:GetRaidRank() > 0 then
				for i = 1, #mod.findFastestComputer do
					local option = mod.findFastestComputer[i]
					if mod.Options[option] then
						sendSync(DBMSyncProtocol, "IS", UnitGUID("player") .. "\t" .. tostring(self.Revision) .. "\t" .. option)
					end
				end
			elseif not IsInGroup() then
				for i = 1, #mod.findFastestComputer do
					local option = mod.findFastestComputer[i]
					if mod.Options[option] then
						private.canSetIcons[option] = true
					end
				end
			end
		end
	end

	local iconsModule = private:GetModule("Icons")

	function bossModPrototype:SetIcon(...)
		return iconsModule:SetIcon(self, ...)
	end

	function bossModPrototype:SetIconByTable(...)
		return iconsModule:SetIconByTable(self, ...)
	end

	function bossModPrototype:SetUnsortedIcon(...)
		return iconsModule:SetUnsortedIcon(self, ...)
	end

	--Backwards compat for old mods using this method, which is now merged into SetSortedIcon
	function bossModPrototype:SetAlphaIcon(delay, target, maxIcon, returnFunc, scanId, ...)
		return iconsModule:SetSortedIcon(self, "alpha", delay, target, 1, maxIcon, false, returnFunc, scanId, ...)
	end

	function bossModPrototype:SetIconBySortedTable(...)
		return iconsModule:SetIconBySortedTable(self, ...)
	end

	function bossModPrototype:SetSortedIcon(...)
		return iconsModule:SetSortedIcon(self, ...)
	end

	function bossModPrototype:ScanForMobs(...)
		return iconsModule:ScanForMobs(self, ...)
	end

	function bossModPrototype:RemoveIcon(...)
		return iconsModule:RemoveIcon(self, ...)
	end

	bossModPrototype.GetIcon = iconsModule.GetIcon
	bossModPrototype.ClearIcons = iconsModule.ClearIcons
	bossModPrototype.CanSetIcon = iconsModule.CanSetIcon
end

-----------------------
--  Model Functions  --
-----------------------
function bossModPrototype:SetModelScale(scale)
	self.modelScale = scale
end

function bossModPrototype:SetModelOffset(x, y, z)
	self.modelOffsetX = x
	self.modelOffsetY = y
	self.modelOffsetZ = z
end

function bossModPrototype:SetModelRotation(r)
	self.modelRotation = r
end

function bossModPrototype:SetModelSequence(v)
	self.modelSequence = v
end

function bossModPrototype:SetModelID(id)
	self.modelId = id
end

function bossModPrototype:SetModelSound(long, short)--PlaySoundFile prototype for model viewer, long is long sound, short is a short clip, configurable in UI, both sound paths defined in boss mods.
	self.modelSoundLong = long
	self.modelSoundShort = short
end

function bossModPrototype:GetLocalizedStrings()
	self.localization.miscStrings.name = self.localization.general.name
	return self.localization.miscStrings
end
