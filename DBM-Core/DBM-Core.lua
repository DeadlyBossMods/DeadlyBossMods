---@diagnostic disable: assign-type-mismatch, cast-local-type
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
---@class DBMCoreNamespace
local private = select(2, ...)

--WARNING: DBM is dangerously close too 200 local variables, avoid adding locals to the file scope.
--More modulation or scoping is needed to reduce this
local DBMPrefix = "D5"
local DBMSyncProtocol = 1
private.DBMPrefix = DBMPrefix
private.DBMSyncProtocol = DBMSyncProtocol

local L = DBM_CORE_L
local CL = DBM_COMMON_L

local stringUtils = private:GetPrototype("StringUtils")
local tableUtils = private:GetPrototype("TableUtils")
local difficulties = private:GetPrototype("Difficulties")
local test = private:GetPrototype("DBMTest")

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
local DBM = private:GetPrototype("DBM")
_G.DBM = DBM
DBM.Revision = parseCurseDate("@project-date-integer@")
DBM.TaintedByTests = false -- Tests may mess with some internal state, you probably don't want to rely on DBM for an important boss fight after running it in test mode

local fakeBWVersion, fakeBWHash = 402, "6f82943"--402.3
local PForceDisable
-- The string that is shown as version
DBM.DisplayVersion = "12.0.22"--Core version
DBM.classicSubVersion = 0
DBM.dungeonSubVersion = 0
DBM.ReleaseRevision = releaseDate(2026, 2, 18) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
PForceDisable = private.isRetail and 22 or 20--When this is incremented, trigger force disable regardless of major patch
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
	local wowVersionString, wowBuild, _, wowTOC = GetBuildInfo()
	return wowTOC, private.testBuild, wowVersionString, wowBuild
end

-- dual profile setup
local _, playerClass = UnitClass("player")
DBM_UseDualProfile = true
if playerClass == "MAGE" or playerClass == "WARLOCK" or playerClass == "ROGUE" or (not private.isRetail and playerClass == "HUNTER") then
	DBM_UseDualProfile = false
end
DBM_CharSavedRevision = 2

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turqoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = 566558,--"Sound\\Doodad\\BellTollNightElf.ogg"
	SpecialWarningSound = 569200,--"Sound\\Spells\\PVPFlagTaken.ogg"
	SpecialWarningSound2 = private.isRetail and 543587 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\UR_Algalon_BHole01.ogg",--"Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg"
	SpecialWarningSound3 = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg",
	SpecialWarningSound4 = not private.isClassic and 552035 or "Interface\\AddOns\\DBM-Core\\sounds\\ClassicSupport\\HoodWolfTransformPlayer01.ogg",--"Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg"
	SpecialWarningSound5 = 554236,--"Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.ogg"
	ModelSoundValue = "Short",
	CountdownVoice = "Corsica",
	CountdownVoice2 = "Kolt",
	CountdownVoice3 = "Smooth",
	PullVoice = "Corsica",
	ChosenVoicePack2 = (GetLocale() == "enUS" or GetLocale() == "enGB") and "VEM" or "None",
	VPReplacesAnnounce = true,
	VPReplacesSADefault = true,
	EventSoundVictory2 = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg",
	EventSoundWipe = "None",
	EventSoundPullTimer = "None",
	EventSoundEngage2 = "None",
	EventSoundMusic = "None",
	EventSoundDungeonBGM = "None",
	EventSoundMusicCombined = false,
	EventMusicNoBuiltIn = false,
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
	HideBlizzardTimeline = true,
	HideDBMBars = false,
	HideDBMWarnings = false,
	SWarningAlphabetical = true,
	SWarnNameInNote = true,
	CustomSounds = 0,
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
	FilterVoidFormSay2 = false,
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
	LogDelves = false,
	LogChallenges = false,
	UseSoundChannel = "Master",
	LFDEnhance = true,
	WorldBossNearAlert = false,
	RLReadyCheckSound = true,
	AFKHealthWarning2 = private.isHardcoreServer and true or false,
	HealthWarningLow = private.isHardcoreServer and true or false,
	EnteringCombatAlert = false,
	LeavingCombatAlert = false,
	RaidDifficultyChangedAlert = true,
	RaidDifficultyChangedAlertRaidOnly = true,
	DungeonDifficultyChangedAlert = false,
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
--	GroupOptionsExcludePA = false,
	AutoExpandSpellGroups2 = true,
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
	DurabilityPosition = {"RIGHT", -150, 0},
	LatencyPosition = {"RIGHT", -150, 0},
	KeystonesPosition = {"LEFT", 30, 0},
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontShowTargetAnnouncements = true,
	DontShowSpecialWarningText = false,
	DontShowSpecialWarningFlash = false,
	DontDoSpecialWarningVibrate = false,
	DontPlaySpecialWarningSound = false,
	DontPlayPrivateAuraSound = false,
	DontShowPrivateAuraFrame = false,
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
	DontShowNameplateIconsCast = false,
	DontSendBossGUIDs = false,
	AlwaysKeepNPs = true,
	NPAuraText = true,
	NPIconSize = 30,
	NPIconOffsetX = 0,
	NPIconOffsetY = 20,--20 used to default offset is no longer covering buff/debuff icons on blizzard nameplates
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
	NPIconGlowBehavior = 1,
	CDNPIconGlowType = 1,--Pixel Default
	CastNPIconGlowBehavior = 1,
	CastNPIconGlowType2 = 4,--Button Default
	DontPlayCountdowns = false,
	DontSendYells = false,
	BlockNoteShare = false,
	DontAutoGossip = false,
	DontShowPT2 = false,
	DontPlayPTCountdown = false,
	DontShowPTText = false,
	DontShowPTNoID = false,
	PTCountThreshold2 = 5,
	LatencyThreshold = 250,
	oRA3AnnounceConsumables = false,
	SettingsMessageShown = false,
	NewsMessageShown2 = 2,--Apparently variable without 2 can still exist in some configs (config cleanup of no longer existing variables not working?)
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
	WorldBossAlert = not private.isRetail,
	WorldBuffAlert = not private.isRetail,
	BadTimerAlert = false,
	AutoAcceptFriendInvite = false,
	AutoAcceptGuildInvite = false,
	FakeBWVersion = false,
	ShortTimerText = true,
	ChatFrame = "DEFAULT_CHAT_FRAME",
	CoreSavedRevision = 1,
	SilentMode = false,
	NoCombatScanningFeatures = false,
	ZoneCombatSyncing = false,--HIDDEN power user feature to improve zone scanning accuracy in niche cases
	EnableTooltip = not private.isRetail,
	EnableTooltipInCombat = true,
	EnableTooltipHeader = true,
	HasShownMidnightPopup = false,
	IgnoreBlizzAPI = false,
	DisableSWSound = false,
	--Private Aura Frame Options
	--Player
	PrivateAurasPlayerEnabled = true,
	PrivateAurasPlayerHideBorder = false,
	PrivateAurasPlayerHideTooltip = false,
	PrivateAurasPlayerUpscaleDuration = true,
	PrivateAurasPlayerScale = 3,
	PrivateAurasPlayerSpacing = -1,
	PrivateAurasPlayerLimit = 5,
	PrivateAurasPlayerGrowDirection = "RIGHT",
	PrivateAurasPlayerWidth = 60,
	PrivateAurasPlayerHeight = 60,
	PrivateAurasPlayerAnchor = "CENTER",--NYI
	PrivateAurasPlayerRelativeTo = "CENTER",--NYI
	PrivateAurasPlayerXOffset = 0,--Partial (drag and drop only, no UI slider/editbox)
	PrivateAurasPlayerYOffset = 150,--Partial (drag and drop only, no UI slider/editbox)
	--Co-Tank
	PrivateAurasCoTankEnabled = true,
	PrivateAurasCoTankHideBorder = false,
	PrivateAurasCoTankHideTooltip = false,
	PrivateAurasCoTankUpscaleDuration = true,
	PrivateAurasCoTankScale = 3,
	PrivateAurasCoTankSpacing = -1,
	PrivateAurasCoTankLimit = 5,
	PrivateAurasCoTankGrowDirection = "LEFT",
	PrivateAurasCoTankWidth = 60,
	PrivateAurasCoTankHeight = 60,
	PrivateAurasCoTankAnchor = "CENTER",--NYI
	PrivateAurasCoTankRelativeTo = "CENTER",--NYI
	PrivateAurasCoTankXOffset = -150,--Partial (drag and drop only, no UI slider/editbox)
	PrivateAurasCoTankYOffset = 150,--Partial (drag and drop only, no UI slider/editbox)
	--Player Text Anchor
	PrivateAurasTextAnchorScale = 1.8,
	PrivateAurasTextAnchorXOffset = 0,--Partial (drag and drop only, no UI slider/editbox)
	PrivateAurasTextAnchorYOffset = -200,--Partial (drag and drop only, no UI slider/editbox)
	PrivateAurasTextAnchorEnabled = true,
	PrivateAurasTextAnchorAnchor = "TOP",--NYI
	PrivateAurasTextAnchorRelativeTo = "TOP",--NYI
}

---@type DBMMod[]
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
private.updateFunctionsDirty = true
--Raid Leader Disable variables
private.statusGuildDisabled, private.statusWhisperDisabled, private.raidIconsDisabled, private.chatBubblesDisabled = false, false, false, false

--------------
--  Locals  --
--------------
---@class DBMMod
local bossModPrototype = private:GetPrototype("DBMMod")
local mainFrame = CreateFrame("Frame", "DBMMainFrame")
local playerName = UnitName("player")
private.playerLevel = UnitLevel("player")
local playerRealm = GetRealmName()
local normalizedPlayerRealm = playerRealm:gsub("[%s-]+", "")
local lastCombatStarted = GetTime()
local chatPrefixShort = "<" .. L.DBM .. "> "
local usedProfile = "Default"
local dbmIsEnabled = true
-- Table variables
local newerVersionPerson, newersubVersionPerson, forceDisablePerson, cSyncSender, eeSyncSender, iconSetRevision, iconSetPerson, loadcIds, oocBWComms, bossIds, raid, autoRespondSpam, queuedBattlefield, bossHealth, bossHealthuIdCache, lastBossEngage, lastBossDefeat = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local inCombat = {} ---@type DBMMod[]
local combatInfo = {} ---@type table<integer, CombatInfo[]>
local inCombatTrash = {}
-- False variables
local targetEventsRegistered, combatInitialized, healthCombatInitialized, watchFrameRestore, questieWatchRestore, bossuIdFound, timerRequestInProgress = false, false, false, false, false, false, false
-- Nil variables
local currentSpecID, currentSpecName, currentSpecGroup, loadOptions, checkWipe, checkBossHealth, checkCustomBossHealth, fireEvent, LastInstanceType, breakTimerStart, AddMsg, delayedFunction, handleSync, lastGroupLeader
-- 0 variables
local eeSyncReceived, cSyncReceived, showConstantReminder, updateNotificationDisplayed, updateSubNotificationDisplayed = 0, 0, 0, 0, 0
local LastInstanceMapID = -1

local deprecatedMods = { -- a list of "banned" (meaning they are replaced by another mod or discontinued). These mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM-Battlegrounds", --replaced by DBM-PvP
	"DBM-SiegeOfOrgrimmar",--Block legacy version. New version is "DBM-SiegeOfOrgrimmarV2"
	"DBM-HighMail",
	"DBM-ProvingGrounds-MoP",--Renamed to DBM-ProvingGrounds in 6.0 version since blizzard updated content for WoD
	"DBM-ProvingGrounds",--Renamed to DBM-Challenges going forward to include proving grounds and any new single player challendges of similar design such as mage tower artifact quests
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

	"DBM-BaradinHold",--Combined into DBM-Raids-Cata
	"DBM-BastionTwilight",--Combined into DBM-Raids-Cata
	"DBM-BlackwingDescent",--Combined into DBM-Raids-Cata
	"DBM-DragonSoul",--Combined into DBM-Raids-Cata
	"DBM-Firelands",--Combined into DBM-Raids-Cata
	"DBM-ThroneFourWinds",--Combined into DBM-Raids-Cata

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

	"DBM-Affixes",--Retired in midnight
}

-----------------
--  Libraries  --
-----------------
local LibSpec
do
	if (private.isRetail or private.isCata or private.isMop) and LibStub then
		LibSpec = LibStub("LibSpecialization", true)
		if LibSpec then
			local function update(specID, _, _, playerName)
				if raid[playerName] then
					raid[playerName].specID = specID
				end
			end
			---@diagnostic disable-next-line: undefined-field
			LibSpec.RegisterGroup(DBM, update)
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
local floor, mhuge, mmin, mmax, mrandom = math.floor, math.huge, math.min, math.max, math.random
local GetNumGroupMembers, GetRaidRosterInfo = GetNumGroupMembers, GetRaidRosterInfo
local UnitName, GetUnitName = UnitName, GetUnitName
local IsInRaid, IsInGroup, IsInInstance = IsInRaid, IsInGroup, IsInInstance
local UnitAffectingCombat, InCombatLockdown, IsFalling, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty = UnitAffectingCombat, InCombatLockdown, IsFalling, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty
local UnitGUID, UnitHealth, UnitHealthMax = UnitGUID, UnitHealth, UnitHealthMax
local UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit = UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit
--local UnitTokenFromGUID, UnitPercentHealthFromGUID = UnitTokenFromGUID, UnitPercentHealthFromGUID
local GetDungeonInfo = C_LFGInfo.GetDungeonInfo or GetDungeonInfo -- Classic has C_LFGInfo but not C_LFGInfo.GetDungeonInfo, need to use global for classic
local EJ_GetSectionInfo, GetSectionIconFlags
if C_EncounterJournal then
	EJ_GetSectionInfo, GetSectionIconFlags = C_EncounterJournal.GetSectionInfo, C_EncounterJournal.GetSectionIconFlags
end
local GetSpecialization, GetSpecializationInfo, GetSpecializationInfoByID = C_SpecializationInfo and C_SpecializationInfo.GetSpecialization or GetSpecialization, C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo or GetSpecializationInfo, GetSpecializationInfoByID
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitIsGroupLeader, UnitIsGroupAssistant = UnitIsGroupLeader, UnitIsGroupAssistant
local PlaySoundFile = PlaySoundFile
local Ambiguate = Ambiguate
local C_TimerAfter = C_Timer.After
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local SendChatMessage = C_ChatInfo.SendChatMessage or SendChatMessage -- Classic has C_ChatInfo but not C_ChatInfo.SendChatMessage, need to use global for classic
local BNSendWhisper = C_BattleNet and C_BattleNet.SendWhisper or BNSendWhisper

-- Store globals that can be hooked/overriden by tests in private
private.GetInstanceInfo = GetInstanceInfo
private.IsEncounterInProgress = C_InstanceEncounter and C_InstanceEncounter.IsEncounterInProgress or IsEncounterInProgress

local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors

-- this is not technically a lib and instead a standalone addon but the api is available via LibStub
local CustomNames = C_AddOns.IsAddOnLoaded("CustomNames") and LibStub and LibStub("CustomNames")

---------------------------------
--  General (local) functions  --
---------------------------------
local checkEntry, removeEntry = tableUtils.checkEntry, tableUtils.removeEntry

---Whisper/Whisper Sync filter function
---@param sender any string for non realId and number for realId. Pass to true for realID
---@param checkFriends boolean? checks sender against friends list
---@param checkGuild boolean? checks sender against guild roster
---@param filterRaid boolean? checks sender against group members of your raid
---@param isRealIdMessage boolean? set true if this is a RealID whisper/comm
---@return boolean
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
	if checkGuild and IsInGuild() then
		--TODO, test UnitIsInMyGuild in both classics, and retail, especially for cross faction guild members. That can save a lot of cpu by removing iterating over literally entire guild roster
		local totalMembers, numOnlineMembers = GetNumGuildMembers()
		local scanTotal = GetGuildRosterShowOffline() and totalMembers or numOnlineMembers--Attempt CPU saving, if "show offline" is unchecked, we can reliably scan only online members instead of whole roster
		if scanTotal and type(scanTotal) == "number" and scanTotal > 0 then
			for i = 1, scanTotal do
				local name = GetGuildRosterInfo(i)
				if not name then break end
				name = Ambiguate(name, "none")
				if name == sender then
					return not (filterRaid and DBM:GetRaidUnitId(name))
				end
			end
		end
	end
	return false
end

---Automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
---@param protocol number
---@param prefix string
---@param msg any
---@param priority string ChatThottleLib sync priority
---@param isLogged boolean?
local function sendSync(protocol, prefix, msg, priority, isLogged)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	if dbmIsEnabled or prefix == "V" or prefix == "H" then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		local fullname = playerName .. "-" .. normalizedPlayerRealm
		local sendChannel = "SOLO"
		if not IsTrialAccount() then
			if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
				sendChannel = "INSTANCE_CHAT"
			else
				if IsInRaid() then
					sendChannel = "RAID"
				elseif IsInGroup(1) then
					sendChannel = "PARTY"
				end
			end
		end
		if sendChannel == "SOLO" then
			handleSync("SOLO", playerName, nil, (protocol or DBMSyncProtocol), prefix, strsplit("\t", msg))
		else
			if isLogged then
				ChatThrottleLib:SendAddonMessageLogged(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, sendChannel)
			else
				ChatThrottleLib:SendAddonMessage(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, sendChannel)
			end
		end
	end
end
private.sendSync = sendSync

---Wrapper to send non logged and logged syncs to a specific player via whisper
---@param protocol number
---@param prefix string
---@param msg any
---@param whisperTarget string
---@param priority string ChatThottleLib sync priority
---@param isLogged boolean?
local function sendWhisperSync(protocol, prefix, msg, whisperTarget, priority, isLogged)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	local fullname = playerName .. "-" .. normalizedPlayerRealm
	if isLogged then
		ChatThrottleLib:SendAddonMessageLogged(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "WHISPER", whisperTarget)
	else
		ChatThrottleLib:SendAddonMessage(priority, DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "WHISPER", whisperTarget)
	end
end

---Customized syncing specifically for guild comms
---@param protocol number
---@param prefix string
---@param msg any
local function sendGuildSync(protocol, prefix, msg)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	if IsInGuild() and (dbmIsEnabled or prefix == "V" or prefix == "H") then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		local fullname = playerName .. "-" .. normalizedPlayerRealm
		ChatThrottleLib:SendAddonMessage("NORMAL", DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
end
private.sendGuildSync = sendGuildSync

---Sync Object specifically for out in the world sync messages that have different rules than standard syncs
---@param self DBM
---@param protocol number
---@param prefix string
---@param msg any
---@param noBNet boolean?
local function SendWorldSync(self, protocol, prefix, msg, noBNet)
	if not dbmIsEnabled then return end--Block all world syncs if force disabled
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	DBM:Debug("SendWorldSync running for " .. prefix)
	local fullname = playerName .. "-" .. normalizedPlayerRealm
	local sendChannel = "SOLO"
	if not IsTrialAccount() then
		if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
			sendChannel = "INSTANCE_CHAT"
		else
			if IsInRaid() then
				sendChannel = "RAID"
			elseif IsInGroup(1) then
				sendChannel = "PARTY"
			end
		end
	end
	if sendChannel == "SOLO" then
		handleSync("SOLO", playerName, nil, (protocol or DBMSyncProtocol), prefix, strsplit("\t", msg))
	else
		ChatThrottleLib:SendAddonMessage("ALERT", DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, sendChannel)
	end
	if IsInGuild() then
		ChatThrottleLib:SendAddonMessage("ALERT", DBMPrefix, fullname .. "\t" .. (protocol or DBMSyncProtocol) .. "\t" .. prefix .. "\t" .. msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
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
					ChatThrottleLib:BNSendGameData("NORMAL", DBMPrefix, DBMSyncProtocol .. "\t" .. prefix .. "\t" .. msg, "WHISPER", gameAccountID)--Just send users realm for pull, so we can eliminate connectedServers checks on sync handler
				end
			end
		end
	end
end

---Automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
---@param prefix string
---@param msg any
---@param channel string
---@param priority string ChatThottleLib sync priority
local function sendBWSync(prefix, msg, channel, priority)
	if DBM:MidRestrictionsActive() then return end--Block all in instance syncs in Midnight Alpha
	if dbmIsEnabled and not IsTrialAccount() then--Only show version checks if force disabled, nothing else
		msg = msg or ""
		ChatThrottleLib:SendAddonMessage(priority, "BigWigs", prefix .. "^" .. msg, channel)
	end
end
private.sendBWSync = sendBWSync

-- sends a whisper to a player by their character name or BNet presence id
-- returns true if the message was sent, nil otherwise
local function sendWhisper(target, msg)
	if DBM:MidRestrictionsActive() then return end--Block all in instance chat messages in Midnight Alpha
	if IsTrialAccount() then return end
	if type(target) == "number" then
		if not BNIsSelf(target) then -- Never send BNet whispers to ourselves
			BNSendWhisper(target, msg)
		end
	elseif type(target) == "string" then
		SendChatMessage(msg, "WHISPER", nil, target) -- Whispering to ourselves here is okay and somewhat useful for whisper-warnings
	end
end

-----------------------
--  Utility Methods  --
-----------------------

---@param season SeasonID?
function DBM:IsSeasonal(season)
	if season and Enum.SeasonID then
		return Enum.SeasonID[season] == private.currentSeason
	else
		return not not private.currentSeason
	end
end


--Catch alls to basically allow encounter mods to use pre retail changes within mods
---@param self DBMModOrDBM
function DBM:IsClassic()
	return not private.isRetail
end
bossModPrototype.IsClassic = DBM.IsClassic

---@param self DBMModOrDBM
function DBM:IsRetail()
	return private.isRetail
end
bossModPrototype.IsRetail = DBM.IsRetail

---@param self DBMModOrDBM
function DBM:IsCata()
	return private.isCata
end
bossModPrototype.IsCata = DBM.IsCata

---@param self DBMModOrDBM
function DBM:IsMop()
	return private.isMop
end
bossModPrototype.IsMop = DBM.IsMop

---@param self DBMModOrDBM
function DBM:IsPostCata()
	return private.isCata or private.isMop or private.isRetail
end
bossModPrototype.IsPostCata = DBM.IsPostCata

function DBM:IsPostMoP()
	return private.isRetail or private.isMop
end

---Currently same as isRetail check, but if restrictions ever come to classic we'll still have one function for checking addongeddon api
---@param self DBMModOrDBM
function DBM:IsPostMidnight()
	return private.isRetail
end
bossModPrototype.IsPostMidnight = DBM.IsPostMidnight

---@param self DBMModOrDBM
---@param includeAuras boolean?
function DBM:MidRestrictionsActive(includeAuras)
	--Not Midnight (or later), rest of checks don't apply
	if not private.isRetail then
		return false
	end
	if includeAuras and (C_Secrets.ShouldAurasBeSecret() or C_Secrets.ShouldCooldownsBeSecret()) then--Checks cooldown and auras restrictions
		return true
	end
	--In active encounter or active M+
	if private.IsEncounterInProgress() or C_ChallengeMode.IsChallengeModeActive() then
		return true
	end
	--if GetActiveMatchState() == 3 then--In active PVP match
	--	return true
	--end
	--Comms and chat messages blocked. might be redundant to above but for good measure
	if C_ChatInfo.InChatMessagingLockdown() then
		return true
	end
end
bossModPrototype.MidRestrictionsActive = DBM.MidRestrictionsActive

---@param self DBMModOrDBM
function DBM:IgnoreBlizzardAPI()
	DBM.Options.IgnoreBlizzAPI = true
end
bossModPrototype.IgnoreBlizzardAPI = DBM.IgnoreBlizzardAPI

---Disables special warning sounds from firing from blizz ENCOUNTER_WARNING api events. Use this when a module has aleady registered custom event sounds
---@param self DBMModOrDBM
function DBM:DisableSpecialWarningSounds()
	DBM.Options.DisableSWSound = true
end
bossModPrototype.DisableSpecialWarningSounds = DBM.DisableSpecialWarningSounds

do
	local issecretvalue = issecretvalue or function(val) return false end
	local hasanysecretvalues = hasanysecretvalues or function(...) return false end
	---@param self DBMModOrDBM
	function DBM:issecretvalue(val)
		return issecretvalue(val)
	end
	bossModPrototype.issecretvalue = DBM.issecretvalue

	---@param self DBMModOrDBM
	function DBM:hasanysecretvalues(...)
		return hasanysecretvalues(...)
	end
	bossModPrototype.hasanysecretvalues = DBM.hasanysecretvalues
end

function bossModPrototype:CheckBigWigs(name)
	if raid[name] and raid[name].bwversion then
		return raid[name].bwversion
	else
		return false
	end
end

---Automatic spell icon parsing
---@param spellId any
---@param objectType string?
---@param fallbackIcon any?
---@return any
function DBM:ParseSpellIcon(spellId, objectType, fallbackIcon)
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
			icon = spellId >= 6 and DBM:GetSpellTexture(spellId)
		end
	end
	return icon or fallbackIcon or 136116
end

---Automatic spell name parsing
---@param spellId any
---@param objectType string?
---@return any
function DBM:ParseSpellName(spellId, objectType)
	local spellName
	if objectType and objectType == "achievement" then
		spellName = select(2, GetAchievementInfo(spellId))
	elseif type(spellId) == "string" and spellId:match("ej%d+") then--Old Journal Format
		spellName = self:EJ_GetSectionInfo(string.sub(spellId, 3))
	elseif type(spellId) == "number" then
		if spellId < 0 then--New Journal Format
			spellName = self:EJ_GetSectionInfo(-spellId)
		else
			spellName = self:GetSpellName(spellId)
		end
	end
	return spellName
end

do
	local customSpellNamesByspellId = {}
	---Function for Registering Spell Renames/ShortText to original spellIDs
	---@param spellId number Original spellID of spell and not alternate ID
	---@param AltName string Custom name used for the spell and not alternateID
	function DBM:RegisterAltSpellName(spellId, AltName)
		--Protection against internal and external misuse
		--Also filters spellIds 0-5 which are typically not real spellids such as phase announces or spell-less timer objects
		if spellId and type(spellId) == "number" and spellId > 5 and AltName and type(AltName) == "string" then
			if not customSpellNamesByspellId[spellId] then
				customSpellNamesByspellId[spellId] = AltName
			end
		end
	end
	---Function for providing Plater and other addons access to Spell Renames/ShortText
	---@param spellId number
	function DBM:GetAltSpellName(spellId)
		return customSpellNamesByspellId[spellId]
	end
end

--------------
--  Events  --
--------------
---@alias DBMModOrDBM DBMMod|DBM
---@alias DBMEvent WowEvent|CombatlogEvent|DBMUnfilteredEvent
do
	local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
	---@type table<DBMEvent, DBMModOrDBM[]>
	local registeredEvents = {}
	---@type table<string, table<integer, integer>>
	local registeredSpellIds = {}
	---@type table<string, table<integer, integer>>
	local unfilteredCLEUEvents = {}
	---@type table<string, integer>
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

	--- Check if the player is the target. *The* player, not *a* player, see IsDestTypePlayer() for unit type checks.
	---@ref
	function argsMT:IsPlayer()
		-- If blizzard ever removes destFlags, this will automatically switch to fallback
		if args.destFlags and COMBATLOG_OBJECT_AFFILIATION_MINE then
			return bband(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		else
			return args.destName == playerName
		end
	end

	--- Check if the player is the source. *The* player, not *a* player, see IsSrcTypePlayer() for unit type checks.
	function argsMT:IsPlayerSource()
		-- If blizzard ever removes sourceFlags, this will automatically switch to fallback
		if args.sourceFlags and COMBATLOG_OBJECT_AFFILIATION_MINE then
			return bband(args.sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		else
			return args.sourceName == playerName
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
			if (not isUnitEvent or not modEvents or modEvents[event .. ...]) and (not zones or zones[LastInstanceMapID]) and not (not v.isTrashModBossFightAllowed and v.isTrashMod and #inCombat > 0) then
				if handler then
					handler(v, ...)
				end
				if v.OnEvent then
					v:OnEvent(event, ...)
				end
			end
		end
	end
	private.mainEventHandler = handleEvent -- Only for testing.

	local registerUnitEvent, unregisterUnitEvent, registerSpellId, unregisterSpellId, registerCLEUEvent, unregisterCLEUEvent
	do
		local frames = {} -- frames that are being used for unit events, one frame per unit id (this could be optimized, as it currently creates a new frame even for a different event, but that's not worth the effort as 90% of all calls are just boss1 anyways)

		---@param mod DBMModOrDBM
		function registerUnitEvent(mod, event, ...)
			mod.registeredUnitEvents = mod.registeredUnitEvents or {}
			for i = 1, select("#", ...) do
				local uId = select(i, ...)
				if not uId then break end
				local frame = frames[uId]
				if not frame then
					frame = CreateFrame("Frame")
					frame:SetScript("OnEvent", handleEvent)
					frames[uId] = frame
				end
				registeredUnitEventIds[event .. uId] = (registeredUnitEventIds[event .. uId] or 0) + 1
				mod.registeredUnitEvents[event .. uId] = true
				frame:RegisterUnitEvent(event, uId)
			end
		end

		---@param mod DBMModOrDBM
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
				DBM:Debug("|cffff0000DBM RegisterEvents Warning: " .. spellId .. " is not a number!|r")
				return
			end
			local spellName = DBM:GetSpellName(spellId)
			if spellId and not spellName then
				DBM:Debug("|cffff0000DBM RegisterEvents Warning: " .. spellId .. " id does not exist!|r")
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
			local spellName = DBM:GetSpellName(spellId)
			if spellId and not spellName then
				DBM:Debug("|cffff0000DBM unregisterSpellId Warning: " .. spellId .. " id does not exist!|r")
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
		---@param mod DBMModOrDBM
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

		---@param mod DBMModOrDBM
		function unregisterCLEUEvent(mod, event)
			test:Trace(mod, "UnregisterEvents", "Regular", event)
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
					---@diagnostic disable-next-line: missing-fields
					registeredEvents[event][i] = {}
					break
				end
			end
			if eventCleared then
				registeredEvents[event] = nil
			end
		end
	end

	--Events that must be blocked from registering on Midnight+
	--Because they check UnitHealth, UnitPower, UnitAura, UnitGUID, or CLEU
	local restrictedEvents = {
		INSTANCE_ENCOUNTER_ENGAGE_UNIT			= true,
		COMBAT_LOG_EVENT_UNFILTERED				= true,
		CHAT_MSG_MONSTER_YELL					= true,
		CHAT_MSG_MONSTER_SAY					= true,
		CHAT_MSG_MONSTER_EMOTE					= true,
		CHAT_MSG_RAID_BOSS_EMOTE				= true,
		CHAT_MSG_RAID_BOSS_WHISPER				= true,
		RAID_BOSS_EMOTE							= true,
		RAID_BOSS_WHISPER						= true,
	}

	-- UNIT_* events are special: they can take 'parameters' like this: "UNIT_HEALTH boss1 boss2" which only trigger the event for the given unit ids
	---@param self DBMModOrDBM
	---@param ... DBMEvent|string
	function DBM:RegisterEvents(...)
		test:Trace(self, "RegisterEvents", "Regular", ...)
		for i = 1, select('#', ...) do
			local event = select(i, ...)
			if not self:IsPostMidnight() or self:IsPostMidnight() and not (restrictedEvents[event] or event:sub(0, 5) == "UNIT_") then
				-- spell events with special care.
				if event:sub(0, 6) == "SPELL_" and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_" or event:sub(0, 6) == "SWING_" or event == "UNIT_DIED" or event == "UNIT_DESTROYED" or event == "PARTY_KILL" or event:sub(0, 13) == "DAMAGE_SHIELD" or event:sub(0, 20) == "DAMAGE_SHIELD_MISSED" then
					--CLEU is completely gone in Midnight+
					if not self:IsPostMidnight() then
						registerCLEUEvent(self, event)
					end
				else
					local eventWithArgs = event
					-- unit events need special care
					if event:sub(0, 5) == "UNIT_" then
						-- unit events are limited to 8 "parameters", as there is no good reason to ever use more than 5 (it's just that the code old code supported 8 (boss1-5, target, focus))
						local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8
						event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
						if not arg1 and event:sub(-11) ~= "_UNFILTERED" then -- no arguments given, support for legacy mods
							if private.isClassic then
								eventWithArgs = event .. " target mouseover targettarget mouseovertarget nameplate1 nameplate2 nameplate3 nameplate4"
							else
								eventWithArgs = event .. " target focus boss1 boss2 boss3 boss4 boss5"
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
	end

	---@param self DBMModOrDBM
	---@param ... DBMEvent|string
	--This is a custom handler used for midnight prepatch and later that does NOT restrict event but rather trusts module to only register safe events
	function DBM:RegisterSafeEvents(...)
		test:Trace(self, "RegisterEvents", "Regular", ...)
		for i = 1, select('#', ...) do
			local event = select(i, ...)
			-- spell events with special care.
			if event:sub(0, 6) == "SPELL_" and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_" or event:sub(0, 6) == "SWING_" or event == "UNIT_DIED" or event == "UNIT_DESTROYED" or event == "PARTY_KILL" or event:sub(0, 13) == "DAMAGE_SHIELD" or event:sub(0, 20) == "DAMAGE_SHIELD_MISSED" then
				--CLEU is completely gone in Midnight+
				--So do nothing
			else
				local eventWithArgs = event
				-- unit events need special care
				if event:sub(0, 5) == "UNIT_" then
					-- unit events are limited to 8 "parameters", as there is no good reason to ever use more than 5 (it's just that the code old code supported 8 (boss1-5, target, focus))
					local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8
					event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
					if not arg1 and event:sub(-11) ~= "_UNFILTERED" then -- no arguments given, support for legacy mods
						if private.isClassic then
							eventWithArgs = event .. " target mouseover targettarget mouseovertarget nameplate1 nameplate2 nameplate3 nameplate4"
						else
							eventWithArgs = event .. " target focus boss1 boss2 boss3 boss4 boss5"
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

	---@param mod DBMModOrDBM
	local function unregisterUEvent(mod, event)
		if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
			test:Trace(mod, "UnregisterEvents", "Regular", event)
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

	---@param self DBMModOrDBM
	---@param srmIncluded boolean?
	function DBM:UnregisterInCombatEvents(srmOnly, srmIncluded)
		for event, mods in pairs(registeredEvents) do
			if srmOnly then
				local i = 1
				while mods[i] do
					if mods[i] == self and event == "SPELL_AURA_REMOVED" then
						local findEvent = self.inCombatOnlyEvents and findRealEvent(self.inCombatOnlyEvents, "SPELL_AURA_REMOVED")
						if findEvent then
							unregisterCLEUEvent(self, findEvent)
							break
						end
					end
					i = i + 1
				end
			elseif (event:sub(0, 6) == "SPELL_" and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_" or event:sub(0, 13) == "DAMAGE_SHIELD" or event:sub(0, 20) == "DAMAGE_SHIELD_MISSED") then
				local i = 1
				while mods[i] do
					if mods[i] == self and (srmIncluded or event ~= "SPELL_AURA_REMOVED") then
						local findEvent = self.inCombatOnlyEvents and findRealEvent(self.inCombatOnlyEvents, event)
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
					if mods[i] == self and (self.inCombatOnlyEvents and checkEntry(self.inCombatOnlyEvents, event) or self.inCombatOnlySafeEvents and checkEntry(self.inCombatOnlySafeEvents, event)) then
						test:Trace(self, "UnregisterEvents", "InCombat", event)
						tremove(mods, i)
						match = true
					end
				end
				if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then -- unit events have their own reference count
					unregisterUEvent(self, event)
				end
				if #mods == 0 then
					registeredEvents[event] = nil
				end
			end
		end
	end

	---@param self DBMModOrDBM
	---@param ... DBMEvent|string
	function DBM:RegisterShortTermEvents(...)
		DBM:Debug("RegisterShortTermEvents fired", 2)
		test:Trace(self, "RegisterEvents", "ShortTerm", ...)
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

	---@param self DBMModOrDBM
	function DBM:UnregisterShortTermEvents()
		DBM:Debug("UnregisterShortTermEvents fired", 3)
		if self.shortTermRegisterEvents then
			DBM:Debug("UnregisterShortTermEvents found registered shortTermRegisterEvents", 2)
			for event, mods in pairs(registeredEvents) do
				if event:sub(0, 6) == "SPELL_" or event:sub(0, 6) == "RANGE_" or event:sub(0, 13) == "DAMAGE_SHIELD" or event:sub(0, 20) == "DAMAGE_SHIELD_MISSED" then
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
							test:Trace(self, "UnregisterEvents", "ShortTerm", event)
							tremove(mods, i)
							match = true
						end
					end
					if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then
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

	---@param self DBM
	---@param ... DBMEvent|string
	---Don't Use this to unregister short term events or "InCombat" events most mods use.
	---This is strictly for Core events boss mods do NOT use.
	function DBM:UnregisterEvents(...)
		test:Trace(self, "UnregisterEvents", "Regular", ...)
		for i = 1, select('#', ...) do
			local event = select(i, ...)
			-- spell events with special care.
			if event:sub(0, 6) == "SPELL_" and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_" or event:sub(0, 13) == "DAMAGE_SHIELD" or event:sub(0, 20) == "DAMAGE_SHIELD_MISSED" then
				unregisterCLEUEvent(self, event)
			else
				if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
					unregisterUEvent(self, event)
					DBM:Debug("unregisterUEvent for unit event " .. event .. " unregistered", 3)
				else
					registeredEvents[event] = nil
					mainFrame:UnregisterEvent(event)
					DBM:Debug("UnregisteredEvents for event " .. event .. " nilled", 3)
				end
			end
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
		SPELL_CAST_FAILED = true,
		DAMAGE_SHIELD = true,
		DAMAGE_SHIELD_MISSED = true
	}
	function DBM:COMBAT_LOG_EVENT_UNFILTERED()
		local timestamp, event, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10 = CombatLogGetCurrentEventInfo()
		if not event or not registeredEvents[event] then return end
		local eventSub6 = event:sub(0, 6)
		if (eventSub6 == "SPELL_" or eventSub6 == "RANGE_" or event == "DAMAGE_SHIELD" or event == "DAMAGE_SHIELD_MISSED") and not unfilteredCLEUEvents[event] and registeredSpellIds[event] then
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
				if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" or event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
					args.amount = extraArg5 or 1
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

	test:RegisterLocalHook("CombatLogGetCurrentEventInfo", function(val)
		local old = CombatLogGetCurrentEventInfo
		CombatLogGetCurrentEventInfo = val
		return old
	end)
end

--------------
--  OnLoad  --
--------------
do
	local isLoaded = false
	local onLoadCallbacks, disabledMods = {}, {}

	---@param self DBM
	local function infiniteLoopNotice(self, message)
		AddMsg(self, message)
		self:Schedule(30, infiniteLoopNotice, self, message)
	end

	---@param self DBM
	local function runDelayedFunctions(self)
		--Check if voice pack missing
		local activeVP = self.Options.ChosenVoicePack2
		if activeVP ~= "None" then
			if not self.VoiceVersions[activeVP] or (self.VoiceVersions[activeVP] and self.VoiceVersions[activeVP] == 0) then--A voice pack is selected that does not belong
				private.voiceSessionDisabled = true
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
				breakTimerStart(self, remaining, playerName, true)
			else--It must have ended while we were offline, kill variable.
				self.Options.RestoreSettingBreakTimer = nil
			end
		end
		if not IsInInstance() then
			sendGuildSync(DBMSyncProtocol, "GH")
		end
		difficulties:RefreshCache()
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
			--Establish a classic sub mod version for version checks and out of date notification/checking
			if not private.isRetail then
				local checkedRaidmodule = private.isMop and "DBM-Raids-MoP" or private.isCata and "DBM-Raids-Cata" or private.isWrath and "DBM-Raids-WoTLK" or private.isBCC and "DBM-Raids-BC" or private.isClassic and "DBM-Raids-Vanilla"
				if checkedRaidmodule and C_AddOns.DoesAddOnExist(checkedRaidmodule) then
					local version = C_AddOns.GetAddOnMetadata(checkedRaidmodule, "Version") or "r0"
					DBM.classicSubVersion = tonumber(string.sub(version, 2, 4)) or 0
				end
			end
			local checkedDungeonmodule = private.isRetail and "DBM-Party-WarWithin" or private.isMop and "DBM-Party-MoP" or private.isCata and "DBM-Party-Cataclysm" or private.isWrath and "DBM-Party-WotLK" or private.isBCC and "DBM-Party-BC" or "DBM-Party-Vanilla"
			if checkedDungeonmodule and C_AddOns.DoesAddOnExist(checkedDungeonmodule) then
				local version = C_AddOns.GetAddOnMetadata(checkedDungeonmodule, "Version") or "r0"
				DBM.dungeonSubVersion = tonumber(string.sub(version, 2, 4)) or 0
			end
			isLoaded = true
			for _, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			loadOptions(self)
			DBM_ModsToLoadWithFullTestSupport = DBM_ModsToLoadWithFullTestSupport or {} -- Separate saved var because tests mess with the usual saved vars temporarily
			DBM_ModsToLoadWithFullTestSupport.bossModsWithTests = DBM_ModsToLoadWithFullTestSupport.bossModsWithTests or {}
			DBM_ModsToLoadWithFullTestSupport.addonsWithTests = DBM_ModsToLoadWithFullTestSupport.addonsWithTests or {}
			DBT:LoadOptions("DBM")
			self.AddOns = {}
			private:OnModuleLoad()
			if C_AddOns.GetAddOnEnableState("VEM-Core", playerName) >= 1 then
				self:Disable(true)
				self:Schedule(15, infiniteLoopNotice, self, L.VEM)
				return
			end
			if C_AddOns.GetAddOnEnableState("DBM-Profiles", playerName) >= 1 then
				self:Disable(true)
				self:Schedule(15, infiniteLoopNotice, self, L.OUTDATEDPROFILES)
				return
			end
			if C_AddOns.GetAddOnEnableState("DBM-SpellTimers", playerName) >= 1 then
				---@type string|number
				local version = C_AddOns.GetAddOnMetadata("DBM-SpellTimers", "Version") or "r0"
				version = tonumber(string.sub(version, 2, 4)) or 0
				if version < 122 and not self.Options.DebugMode then
					self:Disable(true)
					self:Schedule(15, infiniteLoopNotice, self, L.OUTDATEDSPELLTIMERS)
					return
				end
			end
			--DBM plater nameplate cooldown icons are enabled, but platers are not. Inform user feature is not fully enabled or fully disabled
			--LuaLS doesn't like Plater
			---@diagnostic disable-next-line: undefined-global
			if Plater and not Plater.db.profile.bossmod_support_bars_enabled and not DBM.Options.DontShowNameplateIconsCD then
				C_TimerAfter(15, function() AddMsg(self, L.PLATER_NP_AURAS_MSG) end)
			end
			if C_AddOns.GetAddOnEnableState("DPMCore", playerName) >= 1 then
				self:Disable(true)
				self:Schedule(15, infiniteLoopNotice, self, L.DPMCORE)
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
				---@diagnostic disable-next-line: param-type-mismatch
				LibDBIcon:Register("DBM", private.dataBroker, DBM_MinimapIcon)
				if DBM_MinimapIcon.showInCompartment == nil then
					LibDBIcon:AddButtonToCompartment("DBM")
				end
			end
			--Force show timeline or else we can't start timers because it won't fire events
			if self:IsPostMidnight() then
				private.timelineViewType = C_EncounterTimeline.GetViewType()--Cache current timeline view type
				C_CVar.SetCVar("encounterTimelineShowSequenceCount", "1")--Enable count on timers
				C_EncounterWarnings.SetPlayCustomSoundsWhenHidden(true)--Allows DBM sounds to play even when blizzard frames aren't shown
				--Apply user bar color to all bars by default, since blizzard applies white (or red) to all of them by default now
				local timerRed, timerGreen, timerBlue = DBT:GetColorForType(0)
				--https://wago.tools/db2/EncounterEvent?page=25
				for i = 1, 658 do
					C_EncounterEvents.SetEventColor(i, {r = timerRed, g = timerGreen, b = timerBlue})
				end
				if self.Options.HideBlizzardTimeline then
					C_CVar.SetCVar("encounterTimelineEnabled", "1")--Force enable timeline, otherwise custom sounds don't play
					--C_EncounterTimeline.SetViewType(0)--We use blizzard api to make frame invisible
					EncounterTimeline.TrackView:SetAlpha(0)
					EncounterTimeline.TimerView:SetAlpha(0)
				else
					C_CVar.SetCVar("encounterTimelineEnabled", "1")--Force enable timeline, otherwise custom sounds don't play
				end
				if self.Options.HideBossEmoteFrame2 then
					C_EncounterWarnings.SetWarningsShown(false)
				end
				if not self.Options.HasShownMidnightPopup then
					DBM.MidnightPopup:ShowMidnightPopup()
				end
			else
				--Only mess with sound channels if NOT midnight, since it's not like we need the sound channels anymore
				local soundChannels = tonumber(GetCVar("Sound_NumChannels")) or 24--if set to 24, may return nil, Defaults usually do
				--If this messes with your fps, stop raiding with a toaster. It's only fix for addon sound ducking.
				if soundChannels < 64 then
					SetCVar("Sound_NumChannels", 64)
				end
			end
			self.Voices = {{text = "None", value = "None"}}--Create voice table, with default "None" value
			self.VoiceVersions = {}
			for i = 1, C_AddOns.GetNumAddOns() do
				local addonName = C_AddOns.GetAddOnInfo(i)
				local enabled = C_AddOns.GetAddOnEnableState(i, playerName)
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod") then
					if enabled ~= 0 then
						if checkEntry(deprecatedMods, addonName) then
							AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
						else
							local mapIdTable = {strsplit(",", C_AddOns.GetAddOnMetadata(i, "X-DBM-Mod-MapID") or "")}

							local minToc = tonumber(C_AddOns.GetAddOnMetadata(i, "X-Min-Interface") or 0)

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
								statTypes		= C_AddOns.GetAddOnMetadata(i, "X-DBM-StatTypes") or "",
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
											--For handling zones like Warfront: Arathi - Alliance
											local subTabName = GetRealZoneText(id):trim()
											for w in string.gmatch(subTabName, " - ") do
												if w:trim() ~= "" then
													subTabName = w
													break
												end
											end
											if subTabName == "" then -- GetRealZoneText() returns empty string on unknown zones, this happens for dungeons that don't yet exist
												subTabName = UNKNOWN .. " (" .. id .. ")"
											end
											self.AddOns[#self.AddOns].subTabs[k] = subTabName
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
					if checkEntry(deprecatedMods, addonName) then
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
								if C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-MidnightCompat") then--Add to TOC only if your count pack supports "fivecount.ogg"
									DBM:AddCountSound(C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-Name"), "VP: " .. voiceValue, "Interface\\AddOns\\DBM-VP" .. voiceValue .. "\\count\\", nil, true)
								else
									DBM:AddCountSound(C_AddOns.GetAddOnMetadata(i, "X-DBM-Voice-Name"), "VP: " .. voiceValue, "Interface\\AddOns\\DBM-VP" .. voiceValue .. "\\count\\")
								end
							end
						end)
					end
				end
				if C_AddOns.GetAddOnMetadata(i, "X-DBM-CountPack") and enabled ~= 0 then
					if checkEntry(deprecatedMods, addonName) then
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
					if checkEntry(deprecatedMods, addonName) then
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
					if checkEntry(deprecatedMods, addonName) then
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
					if checkEntry(deprecatedMods, addonName) then
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
				"GROUP_ROSTER_UPDATE",
				"INSTANCE_GROUP_SIZE_CHANGED",
				"CHAT_MSG_ADDON",
				"CHAT_MSG_ADDON_LOGGED",
				"BN_CHAT_MSG_ADDON",
				"PLAYER_REGEN_ENABLED",
				"ENCOUNTER_START",
				"ENCOUNTER_END",
				"BOSS_KILL",
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
				"ZONE_CHANGED_NEW_AREA",
				"START_PLAYER_COUNTDOWN",
				"CANCEL_PLAYER_COUNTDOWN"
			)
			if not DBM:IsPostMidnight() then
				self:RegisterEvents(
					"COMBAT_LOG_EVENT_UNFILTERED",
					"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
					"PLAYER_REGEN_DISABLED",
					"UNIT_DIED",
					"UNIT_DESTROYED"
				)
			else
				self:RegisterEvents(
					"ENCOUNTER_TIMELINE_EVENT_ADDED",
					"ENCOUNTER_TIMELINE_EVENT_REMOVED",
					"ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED",
					"ENCOUNTER_WARNING"
				)
			end
			if not private.isClassic then -- Retail, WoTLKC, and BCC
				self:RegisterEvents(
					"LFG_PROPOSAL_FAILED",
					"LFG_PROPOSAL_SHOW",
					"LFG_PROPOSAL_SUCCEEDED",
					"LFG_ROLE_CHECK_SHOW"
				)
			end
			if private.isRetail then
				self:RegisterEvents(
					"CHALLENGE_MODE_RESET",
					"PLAYER_DIFFICULTY_CHANGED",
					"GROUP_JOINED",
					"PLAYER_SPECIALIZATION_CHANGED",
					"SCENARIO_COMPLETED",
					"GOSSIP_SHOW",
					"PLAYER_MAP_CHANGED"
				)
				if not DBM:IsPostMidnight() then
					self:RegisterEvents(
						"UNIT_HEALTH mouseover target focus player"--Base is Frequent on retail, and _FREQUENT deleted
					)
				end
			elseif private.isMop then
				self:RegisterEvents(
					"CHALLENGE_MODE_RESET",
					"UNIT_HEALTH_FREQUENT mouseover target player targettarget",--Still exists in classic and non frequent is slow and less reliable
					"CHARACTER_POINTS_CHANGED",
					"PLAYER_SPECIALIZATION_CHANGED"
				)
			elseif private.isClassic then
				self:RegisterEvents(
					"UNIT_HEALTH_FREQUENT mouseover target player targettarget",--Still exists in classic and non frequent is slow and less reliable
					"CHARACTER_POINTS_CHANGED"
				)
			elseif private.isBCC then
				self:RegisterEvents(
					"UNIT_HEALTH_FREQUENT mouseover target focus player targettarget",--Still exists in classic and non frequent is slow and less reliable
					"CHARACTER_POINTS_CHANGED"
				)
			else -- Wrath and Cata
				self:RegisterEvents(
					"UNIT_HEALTH_FREQUENT mouseover target focus player targettarget",--Still exists in classic and non frequent is slow and less reliable
					"CHARACTER_POINTS_CHANGED",
					"PLAYER_TALENT_UPDATE"
				)
			end
			if RolePollPopup and RolePollPopup:IsEventRegistered("ROLE_POLL_BEGIN") and private.isRetail then
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
			playerName = UnitName("player")--In case it's unknown at login, we check it again
			private.isRetail = WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1)--Can also fail to intialize on login on midnight alpha
			self.Options.IgnoreBlizzAPI = false--In event it didn't get restored on combat end due to crash or reload
			self.Options.DisableSWSound = false--In event it didn't get restored on combat end due to crash or reload
		end
		self:UnregisterEvents("ADDON_LOADED")
	end

	function DBM:PLAYER_ENTERING_WORLD(isLogin, isReload)
		if isLogin or isReload then
			if self.Options.ShowReminders then
				C_TimerAfter(25, function() if self.Options.SilentMode then self:AddMsg(L.SILENT_REMINDER) end end)
				C_TimerAfter(30, function() if not self.Options.SettingsMessageShown then self.Options.SettingsMessageShown = true self:AddMsg(L.HOW_TO_USE_MOD) end end)
				if not private.isRetail then
					--Shown only once per character on login. Repeat showings now handled by the raid module check on raid zone in, and boss pull and wipes within vanilla and wrath raids
					C_TimerAfter(60, function() if self.Options.NewsMessageShown2 < 3 then self.Options.NewsMessageShown2 = 3 self:AddMsg(L.NEWS_UPDATE) end end)
				end
			end
			if not C_ChatInfo.IsAddonMessagePrefixRegistered(DBMPrefix) then
				C_ChatInfo.RegisterAddonMessagePrefix(DBMPrefix) -- main prefix for DBM4
			end
			if not C_ChatInfo.IsAddonMessagePrefixRegistered("BigWigs") then
				C_ChatInfo.RegisterAddonMessagePrefix("BigWigs")
			end
			if not C_ChatInfo.IsAddonMessagePrefixRegistered("Transcriptor") then
				C_ChatInfo.RegisterAddonMessagePrefix("Transcriptor")
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
			--Custom brewfest stuff
			if self.Options.RestoreBrewSoundVolume then
				self:Debug("Restoring Dialog volume to saved value of: "..self.Options.RestoreBrewSoundVolume)
				SetCVar("Sound_DialogVolume", self.Options.RestoreBrewSoundVolume)
				self.Options.RestoreBrewSoundVolume = nil
			end
			--RestoreSettingCustomMusic doens't need restoring here, since zone change transition will handle it
		end
		self:UnregisterEvents("PLAYER_ENTERING_WORLD")
	end
end

-----------------
--  Callbacks  --
-----------------
do
	---@alias DBMCallbackEvent DBMTestEvent
	--- |"BossMod_ShowNameplateAura"
	--- |"BossMod_HideNameplateAura"
	--- |"BossMod_EnableHostileNameplates"
	--- |"BossMod_EnableFriendlyNameplates"
	--- |"BossMod_DisableFriendlyNameplates"
	--- |"BossMod_DisableHostileNameplates"
	--- |"DBM_Debug"
	--- |"DBM_SetStage"
	--- |"DBM_AffixEvent"
	--- |"DBM_EnemyEngaged"
	--- |"DBM_TimerBegin"
	--- |"DBM_TimerStart" Deprecated
	--- |"DBM_TimerStop"
	--- |"DBM_TimerFadeUpdate"
	--- |"DBM_TimerUpdate"
	--- |"DBM_TimerPause"
	--- |"DBM_TimerResume"
	--- |"DBM_TimerUpdateIcon"
	--- |"DBM_NameplateBegin"
	--- |"DBM_NameplateStart"
	--- |"DBM_NameplateStop"
	--- |"DBM_NameplateStopAll"
	--- |"DBM_NameplatePause"
	--- |"DBM_NameplateResume"
	--- |"DBM_NameplateUpdate"
	--- |"DBM_Announce"
	--- |"DBM_raidJoin"
	--- |"DBM_raidLeave"
	--- |"DBM_partyJoin"
	--- |"DBM_partyLeave"
	--- |"DBM_MusicStart"
	--- |"DBM_MusicStop"
	--- |"DBM_UpdateZone"
	--- |"DBM_Pull"
	--- |"DBM_Kill"
	--- |"DBM_Wipe"
	--- |"DBM_PlaySound"
	--- |"DBM_TestModStarted"
	local callbacks = {}

	function fireEvent(event, ...)
		if not callbacks[event] then return end
		for _, v in ipairs(callbacks[event]) do
		    securecall(v, event, ...)
		end
	end

	---@param event DBMCallbackEvent
	---@param ... any?
	function DBM:FireEvent(event, ...)
		fireEvent(event, ...)
	end

	---@param event DBMCallbackEvent
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

	---@param event DBMCallbackEvent
	function DBM:RegisterCallback(event, f)
		if not event or type(f) ~= "function" then
			error("Usage: DBM:RegisterCallback(event, callbackFunc)", 2)
		end
		callbacks[event] = callbacks[event] or {}
		tinsert(callbacks[event], f)
		return #callbacks[event]
	end

	---@param event DBMCallbackEvent
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
					if v.classicSubVers then
						self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.DBM .. " " .. v.displayVersion .. " / " .. v.classicSubVers, showRealDate(v.revision), L.DUNGEONS .. v.dungeonSubVers), false)--Only display Dungeon version if not running two mods
					else
						self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.DBM .. " " .. v.displayVersion, showRealDate(v.revision), L.DUNGEONS .. v.dungeonSubVers), false)--Only display Dungeon version if not running two mods
					end
				end
				if not DBM:MidRestrictionsActive() and notify and v.revision < self.ReleaseRevision then
					SendChatMessage(chatPrefixShort .. L.YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
				end
			elseif self.Options.ShowAllVersions and v.displayVersion and v.bwversion then--DBM & BigWigs
				self:AddMsg(L.VERSIONCHECK_ENTRY_TWO:format(name, L.DBM .. " " .. v.displayVersion, showRealDate(v.revision), L.BIG_WIGS, ("%s - %s"):format(v.bwversion, v.bwhash)), false)
			elseif self.Options.ShowAllVersions and not v.displayVersion and v.bwversion then--BigWigs, No DBM
				self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.BIG_WIGS, ("%s - %s"):format(v.bwversion, v.bwhash), ""), false)
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

------------------------
--  Break/Pull Timer  --
------------------------

---@param timer number --time in seconds
function DBM:CreateBreakTimer(timer)
	if private.IsEncounterInProgress() then
		return self:AddMsg(L.ERROR_NO_PERMISSION_COMBAT)
	end
	if self:MidRestrictionsActive() then
		return self:AddMsg(L.NO_COMMS)
	end
	--Apparently BW wants to accept all pull timers regardless of length, and not support break timers that can be used by all users
	--Sadly, this means DBM has to also be as limiting because if boss mods are not on same page it creates conflicts within multi mod groups
	local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned("player") == "TANK"--Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
	if (self:GetRaidRank() == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" then
		return self:AddMsg(L.ERROR_NO_PERMISSION)
	end
	if timer > 60 then
		return self:AddMsg(L.BREAK_USAGE)
	end
	timer = timer * 60
	--Make sure 1 minute break timer is sent as a break timer and not a pull timer
	--if timer == 60 then
	--	timer = 61
	--end
	--if not private.isWrath then
	--	--Send blizzard countdown timer that all users see (including modless)
	--	C_PartyInfo.DoCountdown(timer)
	--	DBM:Debug("Sending Blizzard Countdown Timer")
	--else
	private.sendSync(private.DBMSyncProtocol, "BT", timer, "ALERT")
	self:Debug("Sending DBM Break Timer")
	--end
end

---@param timer number --time in seconds
function DBM:CreatePullTimer(timer)
	--Apparently BW wants to accept all pull timers regardless of length, and not support break timers that can be used by all users
	--Sadly, this means DBM has to also be as limiting because if boss mods are not on same page it creates conflicts within multi mod groups
	local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned("player") == "TANK"--Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
	if (self:GetRaidRank() == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" then
		return self:AddMsg(L.ERROR_NO_PERMISSION)
	end
	if private.IsEncounterInProgress() then
		return self:AddMsg(L.ERROR_NO_PERMISSION_COMBAT)
	end
	if timer > 0 and timer < 3 then
		return self:AddMsg(L.PULL_TIME_TOO_SHORT)
	end
	--if timer > 60 then
	--	return DBM:AddMsg(L.PULL_TIME_TOO_LONG)
	--end
	--Send blizzard countdown timer that all users see (including modless)
	C_PartyInfo.DoCountdown(timer)
	self:Debug("Sending Blizzard Countdown Timer")
end

-------------------
--  Pizza Timer  --
-------------------
do

	local function loopTimer(time, text, broadcast, sender)
		DBM:CreatePizzaTimer(time, text, broadcast, sender, true)
	end

	local ignore = {}
	---Standard Pizza Timer
	---@param time number --time in seconds
	---@param text string --timer text
	---@param broadcast boolean? --if it should be broadcast to the raid
	---@param sender any --who sent it (if it was started by sync)
	---@param loop boolean? --if the timer should loop indefinitely
	---@param terminate boolean? --if this is true, terminates the timer
	---@param whisperTarget any
	function DBM:CreatePizzaTimer(time, text, broadcast, sender, loop, terminate, whisperTarget)
		if terminate or time == 0 then
			self:Unschedule(loopTimer)
			DBT:CancelBar(text)
			fireEvent("DBM_TimerStop", "DBMPizzaTimer")
			-- Fire cancelation of pizza timer
			if broadcast and not IsTrialAccount() and not self:MidRestrictionsActive() then
				text = text:sub(1, 16)
				--No UnitName in instances at all in midnight
				if not (self:IsPostMidnight() and IsInInstance()) then
					text = text:gsub("%%t", UnitName("target") or "<no target>")
				end
				if whisperTarget then
					sendWhisperSync(DBMSyncProtocol, "UW", ("0\t%s"):format(text), whisperTarget, "ALERT", true)
				else
					sendSync(DBMSyncProtocol, "U", ("0\t%s"):format(text), "ALERT", true)
				end
			end
			return
		end
		if sender and ignore[sender] then return end
		text = text:sub(1, 16)
		--No UnitName in instances at all in midnight
		if not (self:IsPostMidnight() and IsInInstance()) then
			text = text:gsub("%%t", UnitName("target") or "<no target>")
		end
		if time < 3 then
			self:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		DBT:CreateBar(time, text, private.isRetail and 237538 or 134376)
		fireEvent("DBM_TimerBegin", "DBMPizzaTimer", text, time, private.isRetail and "237538" or "134376", "pizzatimer", nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
		if broadcast then
			if whisperTarget then
				--no dbm function uses whisper for pizza timers
				--this allows weak aura creators or other modders to use the pizza timer object unicast via whisper instead of spamming group sync channels
				sendWhisperSync(DBMSyncProtocol, "UW", ("%s\t%s"):format(time, text), whisperTarget, "ALERT", true)
			else
				sendSync(DBMSyncProtocol, "U", ("%s\t%s"):format(time, text), "ALERT", true)
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
				if not private.isRetail then
					raid[playerName].classicSubVers = DBM.classicSubVersion
				end
				raid[playerName].dungeonSubVers = DBM.dungeonSubVersion
				raid[playerName].locale = GetLocale()
				raid[playerName].enabledIcons = tostring(not DBM.Options.DontSetIcons)
				raidGuids[UnitGUID("player") or ""] = playerName
			end
		end)
	end)

	---Throttled Roster Updating to save cpu and reduce comms
	---@param self DBM
	local function updateAllRoster(self)
		if IsInRaid() then
			if not inRaid then
				twipe(newerVersionPerson)--Wipe guild syncs on group join so we trigger a new out of date notice on raid join even if one triggered on login
				twipe(newersubVersionPerson)
				twipe(forceDisablePerson)
				inRaid = true
				sendSync(DBMSyncProtocol, "H", nil, "NORMAL")
				if dbmIsEnabled and not IsTrialAccount() then
					sendBWSync("Q", ("%d^%s"):format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "RAID", "NORMAL")
				end
				if private.isRetail or private.isCata or private.isMop then
					self:Schedule(2, self.RoleCheck, false, self)
				end
				fireEvent("DBM_raidJoin", playerName)
			end
			for i = 1, GetNumGroupMembers() do
				local name, rank, subgroup, _, _, className, _, isOnline = GetRaidRosterInfo(i)
				-- Maybe GetNumGroupMembers() bug? Seems that GetNumGroupMembers() rarely returns bad value, causing GetRaidRosterInfo() returns to nil.
				-- Filter name = nil to prevent nil table error.
				if name then
					local id = "raid" .. i
					local shortname = UnitName(id)
					local guid = UnitGUID(id)
					if self:issecretvalue(guid) then
						guid = nil
					end
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
					raid[name].guid = guid or ""
					raid[name].updated = true
					raid[name].isOnline = isOnline
					if guid then
						raidGuids[guid] = name
					end
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
					removeEntry(newersubVersionPerson, i)
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
				twipe(newersubVersionPerson)
				twipe(forceDisablePerson)
				inRaid = true
				sendSync(DBMSyncProtocol, "H", nil, "NORMAL")
				if dbmIsEnabled and not IsTrialAccount() then
					sendBWSync("Q", ("%d^%s"):format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "RAID", "NORMAL")
				end
				if private.isRetail or private.isCata or private.isMop then
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
					removeEntry(newersubVersionPerson, k)
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
			twipe(newersubVersionPerson)
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
			if not private.isRetail then
				raid[playerName].classicSubVers = DBM.classicSubVersion
			end
			raid[playerName].dungeonSubVers = DBM.dungeonSubVersion
			raid[playerName].locale = GetLocale()
			raidGuids[UnitGUID("player")] = playerName
			lastGroupLeader = nil
		end
	end

	function DBM:GROUP_ROSTER_UPDATE(force)
		self:Unschedule(updateAllRoster)
		--Updated with no throttle on ADDON_LOADED, DBM:LoadMod and if in combat with a boss
		if force or #inCombat > 0 then
			updateAllRoster(self)
		else
			self:Schedule(3.5, updateAllRoster, self)
		end
	end

	function DBM:INSTANCE_GROUP_SIZE_CHANGED()
		difficulties:RefreshCache(true)
	end

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

	---Gets raid rank (0-2) for requested player by name
	---@param name string? --optional, if omited returns playerName rank
	---@return integer
	function DBM:GetRaidRank(name)
		name = name or playerName
		if name == playerName then--If name is player, try to get actual rank. Because raid[name].rank sometimes seems returning 0 even player is promoted.
			return UnitIsGroupLeader("player") and 2 or UnitIsGroupAssistant("player") and 1 or 0
		else
			return (raid[name] and raid[name].rank) or 0
		end
	end

	---Gets raid subgroup for requested player by name
	---@param name string? --optional, if omited returns playerName subgroup
	---@return integer
	function DBM:GetRaidSubgroup(name)
		name = name or playerName
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
			local icon = 0
			if not self:IsPostMidnight() then
				icon = raid[name].id and GetRaidTargetIndex(raid[name].id) or 0
			end
			return raid[name].class or "UNKNOWN", icon
		else
			return "UNKNOWN", 0
		end
	end

	---This is primarily used for cached player unitIds by name lookup
	---<br>Rarely, it's also used for boss checks by name since it simplifies code in mod.
	---@param skipBoss boolean?
	function DBM:GetRaidUnitId(name, skipBoss)
		if not skipBoss and not (self:IsPostMidnight() and IsInInstance()) then
			for i = 1, 10 do
				local unitId = "boss" .. i
				local bossName = UnitName(unitId)
				if bossName and bossName == name then
					return unitId
				end
			end
		end
		return raid[name] and raid[name].id
	end

	local fullPlayerUids = {
		"player", "party1", "party2", "party3", "party4",
		"raid1", "raid2", "raid3", "raid4", "raid5", "raid6", "raid7", "raid8", "raid9", "raid10",
		"raid11", "raid12", "raid13", "raid14", "raid15", "raid16", "raid17", "raid18", "raid19", "raid20",
		"raid21", "raid22", "raid23", "raid24", "raid25", "raid26", "raid27", "raid28", "raid29", "raid30",
		"raid31", "raid32", "raid33", "raid34", "raid35", "raid36", "raid37", "raid38", "raid39", "raid40"
	}

	---Used Strictly to look up Player UnitId by GUID
	---@param self DBMModOrDBM
	---@param playerGUID string
	function DBM:GetRaidUnitIdByGuid(playerGUID)
		local returnUnitID
		if UnitTokenFromGUID then
			returnUnitID = UnitTokenFromGUID(playerGUID)
		end
		if returnUnitID then
			return returnUnitID
		else
			--Sadly this can't use caching from raid table, because we don't know the name, only the guid
			for _, unitId in ipairs(fullPlayerUids) do
				local guid2 = UnitGUID(unitId)
				if playerGUID == guid2 then
					return unitId
				end
			end
		end
	end

	local fullEnemyUids = {
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

	---Used Strictly to look up Enemy UnitId by GUID
	---@param self DBMModOrDBM
	---@param enemyGUID string
	---@param bossOnly boolean? --Used when you only need to check "boss" unitids. Bypasses UnitTokenFromGUID (which checks EVERYTHING)
	function DBM:GetUnitIdFromGUID(enemyGUID, bossOnly)
		if self:IsPostMidnight() and IsInInstance() then return end
		local returnUnitID
		--First use blizzard internal client token check but only if it's not boss only
		--(because blizzard checks every token imaginable, even more than fullEnemyUids does and they have boss as the END in their order selection)
		--DBM prioiritzes the most common/useful tokens first, and rarely iterates passed even boss1, which is first token in OUR priorities
		if UnitTokenFromGUID and not bossOnly then
			returnUnitID = UnitTokenFromGUID(enemyGUID)
		end
	--	if self:issecretvalue(returnUnitID) then
	--		return
	--	end
		if returnUnitID then
			return returnUnitID
		else
			local usedTable = bossOnly and bossTargetuIds or fullEnemyUids
			for _, unitId in ipairs(usedTable) do
				local guid2 = UnitGUID(unitId)
	--			if self:issecretvalue(guid2) then
	--				return
	--			end
				if enemyGUID == guid2 then
					return unitId
				end
			end
		end
	end

	---Not to be confused with GetUnitIdFromGUID, in this function we don't know a specific guid so can't use UnitTokenFromGUID
	---@param self DBMModOrDBM
	---@param creatureID number
	---@param bossOnly boolean? --Used when you only need to check "boss" unitids.
	function DBM:GetUnitIdFromCID(creatureID, bossOnly)
		if self:IsPostMidnight() and IsInInstance() then return end
		--Always prioritize a quick boss unit scan on retail first
		if not private.isClassic and not private.isBCC then
			for i = 1, 10 do
				local unitId = "boss" .. i
				local bossGUID = UnitGUID(unitId)
				local cid = self:GetCIDFromGUID(bossGUID)
				if cid == creatureID then
					return unitId, bossGUID
				end
			end
		end
		if not bossOnly then
			for _, unitId in ipairs(fullEnemyUids) do
				local guid2 = UnitGUID(unitId)
				local cid = self:GetCIDFromGUID(guid2)
				if cid == creatureID then
					return unitId, guid2
				end
			end
		end
	end

	---Deprecated, only old mods use this (newer mods use GetUnitIdFromGUID or GetUnitIdFromCID)
	---@param name string
	---@param bossOnly boolean? --Used when you only need to check "boss" unitids.
	function DBM:GetBossUnitId(name, bossOnly)
		if self:IsPostMidnight() and IsInInstance() then return end
		local returnUnitID
		if not private.isClassic and not private.isBCC then
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

	---@param name string
	function DBM:GetPlayerGUIDByName(name)
		return raid[name] and raid[name].guid
	end

	function DBM:GetMyPlayerInfo()
		return playerName, private.playerLevel, playerRealm, normalizedPlayerRealm
	end

	---Intentionally grabs server name at all times, usually to make sure warning/infoframe target info can name match the combat log in the table
	function DBM:GetUnitFullName(uId)
		if not uId then return end
		return GetUnitName(uId, true)
	end

	---Shortens name but custom so we add * to off realmers instead of stripping it entirely like Ambiguate does
	---<br>Technically GetUnitName without "true" can be used to shorten name to "name (*)" but "name*" is even shorter which is why we do this
	function DBM:GetShortServerName(name)
        if not self.Options.StripServerName then return name end--If strip is disabled, just return name
        if CustomNames then
			---@diagnostic disable-next-line: undefined-field
            name = CustomNames.Get(name)
        end
        local shortName, serverName = string.split("-", name)
        if serverName and serverName ~= playerRealm and serverName ~= normalizedPlayerRealm then
            return shortName .. "*"
        else
            return name
        end
    end

	---@param guid string
	function DBM:GetFullPlayerNameByGUID(guid)
		return raidGuids[guid]
	end

	---@param guid string
	function DBM:GetPlayerNameByGUID(guid)
		return raidGuids[guid] and raidGuids[guid]:gsub("%-.*$", "")
	end

	---@param name any
	---@param higher boolean?
	---@return number
	function DBM:GetGroupId(name, higher)
		local raidMember = raid[name] or raid[self:GetUnitFullName(name) or ""]
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

---For returning the number of players actually in zone with us for status functions
---<br>This is very touchy though and will fail if everyone isn't in same SUB zone (ie same room/area)
---<br>It should work for pretty much any case but outdoor
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

---@param self DBMModOrDBM
function DBM:GetUnitCreatureId(uId)
	if self:IsPostMidnight() and IsInInstance() then return end
	return self:GetCIDFromGUID(UnitGUID(uId))
end

function DBM:GetModByCreatureId(cId)
	return bossIds[cId]
end

--Creature/Vehicle/Pet
----<type>:<subtype>:<realmID>:<mapID>:<serverID>:<dbID>:<creationbits>
--Player/Item
----<type>:<realmID>:<dbID>
---@param self DBMModOrDBM
function DBM:GetCIDFromGUID(guid)
	if self:issecretvalue(guid) then
		return 0
	end
	local guidType, _, playerdbID, _, _, cid, _ = strsplit("-", guid or "")
	if guidType and (guidType == "Creature" or guidType == "Vehicle" or guidType == "Pet") then
		return tonumber(cid)
	elseif type and (guidType == "Player" or guidType == "Item") then
		return tonumber(playerdbID)
	end
	return 0, guid
end

function DBM:IsNonPlayableGUID(guid)
	if type(guid) ~= "string" then return false end
	local guidType = strsplit("-", guid or "")
	return guidType and (guidType == "Creature" or guidType == "Vehicle" or guidType == "NPC")--To determine, add pet or not?
end

---@param self DBMModOrDBM
function DBM:IsCreatureGUID(guid)
	--Player guids aren't secrets, so if it's secret, it must be creature or npc
	if self:issecretvalue(guid) then
		return true
	end
	local guidType = strsplit("-", guid or "")
	return guidType and (guidType == "Creature" or guidType == "Vehicle")--To determine, add pet or not?
end

--Scope, will only check if a unit is within 43 yards now
---@param self DBMModOrDBM
---@param range number
---@param targetname string?
function DBM:CheckNearby(range, targetname)
	if not targetname and DBM.RangeCheck:GetDistanceAll(range) then--Do not use self on this function, because self might be bossModPrototype
		return true--No target name means check if anyone is near self, period
	elseif targetname then
		local uId = DBM:GetRaidUnitId(targetname)--Do not use self on this function, because self might be bossModPrototype
		if uId and not UnitIsUnit("player", uId) then
			local restrictionsActive = private.isRetail and DBM:HasMapRestrictions()
			local inRange = DBM.RangeCheck:GetDistance(uId)--Do not use self on this function, because self might be bossModPrototype
			if inRange and inRange < (restrictionsActive and 43 or range) + 0.5 then
				return true
			end
		end
	end
	return false
end

--Ugly, Needs improvement in code style to just dump all numeric values as args
--it's not meant to just wrap C_GossipInfo.GetOptions() but to dump out the meaningful values from it
---@param self DBMModOrDBM
---@param force boolean?
---@return number?
function DBM:GetGossipID(force)
	if DBM.Options.DontAutoGossip and not force then return nil end
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

---Hybrid all in one object to auto check and confirm multiple gossip IDs at once
---@param self DBMModOrDBM
---@param confirm boolean?
function DBM:SelectMatchingGossip(confirm, ...)
	if DBM.Options.DontAutoGossip then return false end
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

---@param self DBMModOrDBM
---@param gossipOptionID number
---@param confirm boolean?
function DBM:SelectGossip(gossipOptionID, confirm)
	if gossipOptionID and not DBM.Options.DontAutoGossip then
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

do
	local soundMigrationtable = {
		[8174] = 569200,--PVPFlagTaken
		[15391] = 543587,--UR_Algalon_BHole01
		[9278] = 552035,--HoodWolfTransformPlayer01
		[6674] = 566558,--BellTollNightElf
		[11742] = 566558,--BellTollNightElf
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
	function DBM:GetSoundMigration(sound)
		return soundMigrationtable[sound]
	end
end

function DBM:LoadModOptions(modId, inCombat, first)
	local oldSavedVarsName = modId:gsub("-", "") .. "_SavedVars"
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local savedStatsName = modId:gsub("-", "") .. "_SavedStats"
	local fullname = playerName .. "-" .. playerRealm
	if (not currentSpecID or currentSpecID == 0) or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	local profileNum = private.playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	local savedOptions = _G[savedVarsName][fullname] or {}
	local savedStats = _G[savedStatsName] or {}
	local existId = {}
	for _, id in ipairs(self.ModLists[modId]) do
		existId[id] = true
		-- init
		if not savedOptions[id] then savedOptions[id] = {} end
		---@class DBMMod
		local mod = self:GetModByName(id)
		mod.showTestUI = DBM_ModsToLoadWithFullTestSupport.bossModsWithTests[id]
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
						if checkedOption and (type(checkedOption) == "number") and self:GetSoundMigration(checkedOption) then
							savedOptions[id][profileNum][option] = self:GetSoundMigration(checkedOption)
							self:Debug("Migrated " .. option .. " to file data Id")
						end
					end
				end
			end
		end
		--apply saved option to actual option table
		mod["Options"] = savedOptions[id][profileNum]
		--stats init (only first load)
		if first then
			savedStats[id] = savedStats[id] or {}
			local stats = savedStats[id]
			stats.followerKills = stats.followerKills or 0
			stats.followerPulls = stats.followerPulls or 0
			stats.storyKills = stats.storyKills or 0
			stats.storyPulls = stats.storyPulls or 0
			stats.normalKills = stats.normalKills or 0
			stats.normalPulls = stats.normalPulls or 0
			stats.normalBestRank = stats.normalBestRank or 0
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
			mod["stats"] = stats
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
	private.playerLevel = UnitLevel("player")
	if private.playerLevel < 15 and private.playerLevel > 9 then
		self:PLAYER_SPECIALIZATION_CHANGED("player") -- Classic this is "CHARACTER_POINTS_CHANGED", but we just use this function anyway
	end
end

do
	local difficutlyToText = {
		[1] = PLAYER_DIFFICULTY1,--Normal (Dungeon)
		[2] = PLAYER_DIFFICULTY2,--Heroic (Dungeon)
		[14] = PLAYER_DIFFICULTY1,--Normal (Raid)
		[15] = PLAYER_DIFFICULTY2,--Heroic (Raid)
		[16] = PLAYER_DIFFICULTY6,--Mythic (Raid)
		[23] = PLAYER_DIFFICULTY6,--Mythic (Dungeon)
	}
	local lastRaidDifficulty = GetRaidDifficultyID() or -1
	local lastDungeonDifficulty = GetDungeonDifficultyID() or -1
	function DBM:PLAYER_DIFFICULTY_CHANGED(force)
		if not IsInGroup() then return end
		--Filter queued or solo content sitations showing difficulty change alerts
		if IsPartyLFG() or difficulties.difficultyIndex == 205 or difficulties:InstanceType(LastInstanceMapID) == 4 then return end--Follower dungeon and delves
		--Also supress alerts if in any LFG queue state
		if GetLFGMode(1) or GetLFGMode(2) or GetLFGMode(3) or GetLFGMode(4) or GetLFGMode(5) then return end
		local currentRaidDifficulty = GetRaidDifficultyID()
		local currentDungeonDifficulty = GetDungeonDifficultyID()
		if (currentRaidDifficulty ~= lastRaidDifficulty) or force then
			lastRaidDifficulty = currentRaidDifficulty
			if not self.Options.RaidDifficultyChangedAlertRaidOnly or IsInRaid() then
				if self.Options.RaidDifficultyChangedAlert and self:AntiSpam(5, "raiddiffchanged", currentRaidDifficulty) then
					if difficutlyToText[currentRaidDifficulty] then
						self:AddWarning(L.RAID_DIFFICULTY_CHANGED:format(difficutlyToText[currentRaidDifficulty]), nil, nil, true, true, 3.5)
					end
				end
			end
		end
		if not IsInRaid() then--If we're in raid we definitely don't care about dungeons
			if (currentDungeonDifficulty ~= lastDungeonDifficulty) or force then
				lastDungeonDifficulty = currentDungeonDifficulty
				if self.Options.DungeonDifficultyChangedAlert and self:AntiSpam(5, "dungeondiffchanged", currentDungeonDifficulty) then
					if difficutlyToText[currentDungeonDifficulty] then
						self:AddWarning(L.DUNGEON_DIFFICULTY_CHANGED:format(difficutlyToText[currentDungeonDifficulty]), nil, nil, true, true, 3.5)
					end
				end
			end
		end
	end

	function DBM:GROUP_JOINED()
		self:PLAYER_DIFFICULTY_CHANGED(true)
	end
end

function DBM:LoadAllModDefaultOption(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- prevent error
	if (not currentSpecID or currentSpecID == 0) or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local fullname = playerName .. "-" .. playerRealm
	local profileNum = private.playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
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
		mod["Options"] = {}
		mod["Options"] = defaultOptions
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

---@param mod DBMMod
function DBM:LoadModDefaultOption(mod)
	-- mod must be table
	if not mod then return end
	-- prevent error
	if (not currentSpecID or currentSpecID == 0) or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = (mod.modId):gsub("-", "") .. "_AllSavedVars"
	local fullname = playerName .. "-" .. playerRealm
	local profileNum = private.playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
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
	mod["Options"] = {}
	mod["Options"] = defaultOptions
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
	if (not currentSpecID or currentSpecID == 0) or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local targetName = playerName .. "-" .. playerRealm
	local targetProfile = private.playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
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
		mod["Options"] = {}
		mod["Options"] = _G[savedVarsName][targetName][id][targetProfile]
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
	if (not currentSpecID or currentSpecID == 0) or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local targetName = playerName .. "-" .. playerRealm
	local targetProfile = private.playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
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
		mod["Options"] = {}
		mod["Options"] = _G[savedVarsName][targetName][id][targetProfile]
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
	if (not currentSpecID or currentSpecID == 0) or not currentSpecGroup or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "") .. "_AllSavedVars"
	local fullname = playerName .. "-" .. playerRealm
	local profileNum = private.playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
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

function DBM:CreateDefaultModStats()
	---@class ModStats
	local defaultStats = {}
	defaultStats.followerKills = 0
	defaultStats.followerPulls = 0
	defaultStats.storyKills = 0
	defaultStats.storyPulls = 0
	defaultStats.normalKills = 0
	defaultStats.normalPulls = 0
	defaultStats.normalBestRank = 0
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
	return defaultStats
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
		local defaultStats = DBM:CreateDefaultModStats()
		mod["stats"] = defaultStats or {}
		_G[savedStatsName][id] = defaultStats or {}
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

	---@param self DBM
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
			if type(self.Options[setting]) == "number" and self:GetSoundMigration(self.Options[setting]) then
				self.Options[setting] = self:GetSoundMigration(self.Options[setting])
			end
		end
		--Inject build in media after options have loaded
		if not DBM.Options.EventMusicNoBuiltIn then
			if private.isRetail then
				DBM:AddDungeonMusic("Anduin Part 1 B", 1417242, 140)--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
				DBM:AddBattleMusic("Anduin Part 2 B", 1417248, 111)--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
				DBM:AddBattleMusic("Invincible", 1100052, 197)--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
				--Duplicate entries to the all music Table
				DBM:AddMusic("Anduin Part 1 B", 1417242, 140)--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
				DBM:AddMusic("Anduin Part 2 B", 1417248, 111)--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
				DBM:AddMusic("Invincible", 1100052, 197)--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
			end
			if private.isWrath or private.isCata or private.isMop or private.isRetail then
				DBM:AddBattleMusic("Bronze Jam", 350021, 116)--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
				DBM:AddDungeonMusic("Ulduar: Titan Orchestra", 298910, 102)--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
				--Duplicate entries to the all music Table
				DBM:AddMusic("Bronze Jam", 350021, 116)--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
				DBM:AddMusic("Ulduar: Titan Orchestra", 298910, 102)--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
				if not private.isWrath then
					DBM:AddDungeonMusic("Nightsong", 441705, 160)--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
					--Duplicate entries to the all music Table
					DBM:AddMusic("Nightsong", 441705, 160)--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
				end
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
	local timerEnabled = self.Options.ShowQueuePop and not self.Options.DontShowEventTimers
	if timerEnabled then
		DBT:CreateBar(40, L.LFG_INVITE, 237538)

	end
	fireEvent("DBM_TimerBegin", "DBMLFGTimer", L.LFG_INVITE, 40, "237538", "extratimer", nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, timerEnabled)
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
		--LuaLS doesn't like Plater
		---@diagnostic disable-next-line: undefined-global
		if not BINDING_HEADER_oRA3 then
			DBM:PlaySoundFile(567478, true)--Because regular sound uses SFX channel which is too low of volume most of time
		end
	end
	self:TransitionToDungeonBGM(false, true)
	self:Schedule(4, self.TransitionToDungeonBGM, self)
end

do
	---@param self DBM
	local function throttledTalentCheck(self)
		local lastSpecID = currentSpecID
		self:SetCurrentSpecInfo()
		if not InCombatLockdown() then
			--Refresh entire spec table if not in combat
			DBMExtraGlobal:rebuildSpecTable()
		end
		if currentSpecID ~= lastSpecID then--Don't fire specchanged unless spec actually has changed.
			self:SpecChanged()
			if (private.isRetail or private.isCata or private.isMop) and IsInGroup() then
				self:RoleCheck(false)
			end
		end
	end

	--Retail API doesn't need throttle
	function DBM:PLAYER_SPECIALIZATION_CHANGED(unit)
		if unit == "player" then
			self:Unschedule(throttledTalentCheck)
			throttledTalentCheck(self)
		end
	end
	--Throttle checks on talent point updates so that if multiple CHARACTER_POINTS_CHANGED fire in succession
	--It doesnt spam DBMs code and cause performance lag
	function DBM:CHARACTER_POINTS_CHANGED() -- Classic/BCC support
		self:Unschedule(throttledTalentCheck)
		self:Schedule(2, throttledTalentCheck, self)
	end
	--Throttle this api too.
	DBM.PLAYER_TALENT_UPDATE = DBM.CHARACTER_POINTS_CHANGED -- Wrath/Cata support
end

do
	local function AcceptPartyInvite()
		AcceptGroup()
		for i = 1, 4 do
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
			local timerEnabled = self.Options.ShowQueuePop and not self.Options.DontShowEventTimers
			queuedBattlefield[i] = select(2, GetBattlefieldStatus(i))
			local expiration = GetBattlefieldPortExpiration(queueID)
			local timerIcon = (private.isRetail and GetPlayerFactionGroup("player") or UnitFactionGroup("player")) == "Alliance" and 132486 or 132485
			if timerEnabled then
				DBT:CreateBar(expiration or 85, queuedBattlefield[i], timerIcon)
				self:FlashClientIcon()
			end
			fireEvent("DBM_TimerBegin", "DBMBFSTimer", queuedBattlefield[i], expiration or 85, tostring(timerIcon), "extratimer", nil, 0, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, timerEnabled)
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
	if #inCombat > 0 and (C_Scenario.IsInScenario() or test.Mocks and test.Mocks.IsInScenario()) then
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
	local dungeonShown = false
	local classicZones = {[509] = true, [531] = true, [469] = true, [409] = true, [2791] = true, [2792] = true, [2832] = true, [2856] = true,}
	local bcZones = {[534] = true, [532] = true, [544] = true, [548] = true, [550] = true, [564] = true, [565] = true, [580] = true}
	local wrathZones = {[615] = true, [724] = true, [649] = true, [616] = true, [631] = true, [533] = true, [249] = true, [603] = true, [624] = true}
	local cataZones = {[757] = true, [671] = true, [669] = true, [967] = true, [720] = true, [951] = true, [754] = true}
	local mopZones = {[1009] = true, [1008] = true, [1136] = true, [996] = true, [1098] = true}
	local wodZones = {[1205] = true, [1448] = true, [1228] = true}
	local legionZones = {[1712] = true, [1520] = true, [1530] = true, [1676] = true, [1648] = true}
	local bfaZones = {[1861] = true, [2070] = true, [2096] = true, [2164] = true, [2217] = true}
	local shadowlandsZones = {[2296] = true, [2450] = true, [2481] = true}
	local dragonflightZones = {[2522] = true, [2569] = true, [2549] = true}
	local importantChallenges = {2827, 2828}--TWW visions revsited
	local pvpZones = {[30] = true, [489] = true, [529] = true, [559] = true, [562] = true, [566] = true, [572] = true, [617] = true, [618] = true, [628] = true, [726] = true, [727] = true, [761] = true, [968] = true, [980] = true, [998] = true, [1105] = true, [1134] = true, [1170] = true, [1504] = true, [1505] = true, [1552] = true, [1681] = true, [1672] = true, [1803] = true, [1825] = true, [1911] = true, [2106] = true, [2107] = true, [2118] = true, [2167] = true, [2177] = true, [2197] = true, [2245] = true, [2373] = true, [2509] = true, [2511] = true, [2547] = true, [2563] = true}
	--This never wants to spam you to use mods for trivial content you don't need mods for.
	--It's intended to suggest mods for content that's relevant to your level (TW, leveling up in dungeons, or even older raids you can't just roll over)
	function DBM:CheckAvailableMods()
		--If they are running two boss mods at once, lets assume they are only using DBM for a specific feature (such as brawlers) and not nag
		--If they've disabled reminders, don't nag
		if _G["BigWigs"] or not self.Options.ShowReminders then return end
		if not self:IsTrivial() or difficulties:IsSeasonalDungeon(LastInstanceMapID) then
			local checkedDungeon = private.isRetail and "DBM-Party-WarWithin" or private.isMop and "DBM-Party-MoP" or private.isCata and "DBM-Party-Cataclysm" or private.isWrath and "DBM-Party-WotLK" or private.isBCC and "DBM-Party-BC" or "DBM-Party-Vanilla"
			--Dungeon Handling
			if (difficulties:InstanceType(LastInstanceMapID) == 2) or (difficulties:InstanceType(LastInstanceMapID) == 4) then--Dungeon or Delve
				--Show popup for season of discovery and hardcore, both of whic have higher difficulty (or higher risk in terms of hardcore) dungeons
				if self:IsSeasonal("SeasonOfDiscovery") or self:IsSeasonal("FreshHardcore") or self:IsSeasonal("Hardcore") then
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "Vanilla")
				--Also show popup on retail seasonal dungeons since those are ones being run for M0 and M+
				elseif private.isRetail and difficulties:IsSeasonalDungeon(LastInstanceMapID) then--M+ Dungeons Only
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "Retail")
				elseif private.isMop then--Mop dungeons only
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "MoP")
				else--Show a general message not a popup (Basically tbc, wrath, cata dungeons
					if not C_AddOns.DoesAddOnExist(checkedDungeon) and not dungeonShown then
						AddMsg(self, L.MOD_AVAILABLE:format("DBM Dungeons, Delves, & Events mods"), nil, private.isRetail or private.isCata or private.isMop)
						dungeonShown = true
					end
				end
			--Classic raid Handling
			elseif classicZones[LastInstanceMapID] or ((LastInstanceMapID == 249 or LastInstanceMapID == 533) and private.isClassic) then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-Vanilla") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Vanilla/SoD mods"), nil, private.isClassic)--Play sound only in Vanilla
				end
				--Show extra annoying popup in current content that's non trivial in classic or BRD raild on retail
				if private.isClassic or LastInstanceMapID == 2792 then
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "Vanilla")
				end
			--TBC raid Handling
			elseif bcZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-BC") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Burning Crusade mods"), nil, private.isBCC)--Play sound only in TBC
				--Show extra annoying popup in current content that's non trivial in classic TBC or Black Temple raid on retail
				if private.isBCC or LastInstanceMapID == 564 then
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "BCC") -- Show extra annoying popup in current content that's non trivial in classic or BRD raild on retail
				end
			--Wrath raid Handling
			elseif wrathZones[LastInstanceMapID] and not private.isClassic then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-WoTLK") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Wrath of the Lich King mods"), nil, private.isWrath)--Play sound only in wrath
				end
				--Show extra annoying popup in current content if it's classic
				if private.isWrath or LastInstanceMapID == 631 then
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "WoTLK") -- Show extra annoying popup in current content that's non trivial in classic
				end
			--Cata raid Handling
			elseif cataZones[LastInstanceMapID] then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-Cata") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Cataclysm mods"), nil, private.isCata)--Play sound only in cata
				end
				--Show extra annoying popup in current content if it's classic
				if private.isCata or LastInstanceMapID == 720 then
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "Cata") -- Show extra annoying popup in current content that's non trivial in classic
				end
			--MoP raid Handling
			elseif mopZones[LastInstanceMapID] then
				if not C_AddOns.DoesAddOnExist("DBM-Raids-MoP") then
					AddMsg(self, L.MOD_AVAILABLE:format("DBM Mists of Pandaria mods"), nil, private.isMop)
				end
				--Show extra annoying popup in current content if it's classic
				if private.isMop then--or LastInstanceMapID == 1098 (throne of thunder next timewalking raid?)
					self:AnnoyingPopupCheckZone(LastInstanceMapID, "MoP")
				end
			--WoD raid Handling
			elseif wodZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-WoD") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Warlords of Draenor mods"))
			--Legion raid Handling
			elseif legionZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Legion") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Legion mods"), nil, LastInstanceMapID == 580)--Will play sound in tomb of sargeras since Kil Jaeden is still dangerous regardless of level
			--BFA raid Handling
			elseif bfaZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-BfA") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Battle for Azeroth mods"))
			--Shadowlands raid Handling
			elseif shadowlandsZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Shadowlands") then
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Shadowlands mods"), nil, true)--Will use play sound for now, since it's not trivial enough to be silent yet
			--Dragonflight raid Handling
			elseif dragonflightZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-Raids-Dragonflight") then--Uncomment in War Within on mod split
				AddMsg(self, L.MOD_AVAILABLE:format("DBM Dragonflight mods"), nil, true)--Will use play sound for now, since it's not trivial enough to be silent yet
			end
		end
		if (difficulties:InstanceType(LastInstanceMapID) == 5) and not C_AddOns.DoesAddOnExist("DBM-Challenges") then--No trivial check on challenge scenarios
			if importantChallenges[LastInstanceMapID] then
				self:AnnoyingPopupCheckZone(LastInstanceMapID, "Retail")
			else
				AddMsg(self, L.MOD_AVAILABLE:format("DBM-Challenges"), nil, true)
			end
		end
		if pvpZones[LastInstanceMapID] and not C_AddOns.DoesAddOnExist("DBM-PvP") and not pvpShown then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM-PvP"), nil, true)
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

	---@param force boolean? Only used when /dbm musicstart is used directly by user
	---@param cleanup boolean? Runs on zone change/cinematic Start (first load delay) and combat end
	function DBM:TransitionToDungeonBGM(force, cleanup)
		if cleanup then
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
		if self.Options.EventSoundDungeonBGM and self.Options.EventSoundDungeonBGM ~= "None" and self.Options.EventSoundDungeonBGM ~= "" and not (self.Options.EventDungMusicMythicFilter and (difficulties.savedDifficulty == "mythic" or difficulties.savedDifficulty == "challenge")) then
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
					---@diagnostic disable-next-line: cast-local-type
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

	---@param self DBM
	---@param delay number?
	local function SecondaryLoadCheck(self, delay)
		local _, instanceType, difficulty, _, _, _, _, mapID, instanceGroupSize = private.GetInstanceInfo()
		difficulties:RefreshCache(true)
		LastGroupSize = instanceGroupSize
		self:Debug("Instance Check fired with mapID " .. mapID .. " and difficulty " .. difficulty .. " and delay " .. (delay or 0), 2)
		-- Difficulty index also checked because in challenge modes and M+, difficulty changes with no ID change
		-- if ID changes we need to execute updated autologging and checkavailable mods checks
		-- ID and difficulty hasn't changed, don't waste cpu doing anything else (example situation, porting into garrosh stage 4 is a loading screen)
		if LastInstanceMapID == mapID and difficulties.difficultyIndex == difficulty then
			self:TransitionToDungeonBGM()
			self:Debug("|c00F2F200No action taken because mapID and difficultyID hasn't changed since last check |r", 2)
			return
		end
		self:Debug("|c0069CCF0mapID or difficulty has changed, updating LastInstanceMapID to |r" .. mapID, 2)
		LastInstanceMapID = mapID
		DBMScheduler:UpdateZone()--Also update zone in scheduler
		fireEvent("DBM_UpdateZone", mapID)
		if instanceType == "none" or (C_Garrison and C_Garrison:IsOnGarrisonMap()) then
			LastInstanceType = "none"
			if not targetEventsRegistered then
				self:RegisterShortTermEvents("UPDATE_MOUSEOVER_UNIT", "NAME_PLATE_UNIT_ADDED", "UNIT_TARGET player")
				targetEventsRegistered = true
			end
		else
			LastInstanceType = instanceType
			if targetEventsRegistered then
				self:UnregisterShortTermEvents()
				targetEventsRegistered = false
			end
			if difficulties.savedDifficulty == "worldboss" then
				for i = #inCombat, 1, -1 do
					self:EndCombat(inCombat[i], true, nil, "Left zone of world boss")
				end
			end
		end
		-- Auto Logging for entire zone if record only bosses is off
		if not self.Options.RecordOnlyBosses then
			if LastInstanceType == "raid" or LastInstanceType == "party" then
				self:StartLogging(0)
			else
				self:StopLogging()
			end
		end
		-- LoadMod
		self:LoadModsOnDemand("mapId", mapID, delay or 0)
		self:CheckAvailableMods()
		self:UpdateMapRestrictions()
		if self:HasMapRestrictions() then
			self.Arrow:Hide()
			self.HudMap:Disable()
			if (private.isRetail and self.RangeCheck:IsShown()) or self.RangeCheck:IsRadarShown() then
				self.RangeCheck:Hide(true)
			end
		end
	end

	--Faster and more accurate loading for instances, but useless outside of them
	function DBM:LOADING_SCREEN_DISABLED(delayedCheck)
		--Extra stuff we want to clean up after loading screens only
		if not private.isClassic and not private.isBCC then
			DBT:CancelBar(L.LFG_INVITE)--Disable bar here since LFG_PROPOSAL_SUCCEEDED seems broken right now
		end
		fireEvent("DBM_TimerStop", "DBMLFGTimer")
		timerRequestInProgress = false
		--Regular load zone code beyond this point
		self:Debug("LOADING_SCREEN_DISABLED fired", 2)
		self:Unschedule(SecondaryLoadCheck)
		--SecondaryLoadCheck(self)
		--In instance tranfers with no loading screen, InstanceInfo can actually return nil for first few seconds
		if not delayedCheck then
			self:Schedule(1, SecondaryLoadCheck, self)--Minimum time delayed by one second to work around an issue on 8.x where spec info isn't available yet on reloadui
		end
		self:TransitionToDungeonBGM(false, true)
		self:Schedule(5, SecondaryLoadCheck, self, 5)
		DBM:UpdateMapRestrictions()
		if self:HasMapRestrictions() then
			self.Arrow:Hide()
			self.HudMap:Disable()
			if (private.isRetail and self.RangeCheck:IsShown()) or self.RangeCheck:IsRadarShown() then
				self.RangeCheck:Hide(true)
			end
		end
	end

	local sodLevelUpRaids = {[48] = true, [90] = true, [109] = true}

	-- Load based on MapIDs
	function DBM:ZONE_CHANGED_NEW_AREA()
		local mapID = C_Map.GetBestMapForUnit("player")
		if mapID then
			self:LoadModsOnDemand("mapId", "m" .. mapID)
		end
		DBM:CheckAvailableModsByMap()
	end

	---Special event that fires when changing zones in TWW
	---@param oldZone number if oldZone is -1, it means it's a loading screen
	---@param newZone number
	function DBM:PLAYER_MAP_CHANGED(oldZone, newZone)
		self:Debug("PLAYER_MAP_CHANGED fired with oldZone " .. oldZone .. " and newZone " .. newZone, 2)
		if oldZone == -1 then return end--Let legacy LOADING_SCREEN_DISABLED handle it for now. In future, PLAYER_MAP_CHANGED may replace LSD if classic gets it
		if LastInstanceMapID ~= newZone then
			self:Debug("Zone changed, firing secondary load check", 2)
			--Different ID than cached, run secondary load checks
			--Delay is still needed due to GetInstanceInfo not returning new information yet instantly on PLAYER_MAP_CHANGED
			self:TransitionToDungeonBGM(false, true)
			self:Unschedule(SecondaryLoadCheck)
--			self:Schedule(1, SecondaryLoadCheck, self, 1)
			self:Schedule(5, SecondaryLoadCheck, self, 5)
			DBM:UpdateMapRestrictions()
			if self:HasMapRestrictions() then
				self.Arrow:Hide()
				self.HudMap:Disable()
				if (private.isRetail and self.RangeCheck:IsShown()) or self.RangeCheck:IsRadarShown() then
					self.RangeCheck:Hide(true)
				end
			end
		end
	end

	function DBM:CHALLENGE_MODE_RESET()
		--TODO, if blizzard ever removes loading screen from challenge modes start, then we need to run additional stuff from SecondaryLoadCheck here
		difficulties.difficultyIndex = 8
		self:CheckAvailableMods()
		if not self.Options.RecordOnlyBosses then
			self:StartLogging(0, nil, true)
		end
	end

	---@return string?
	local function isDmfActiveClassic()
		if DBM:IsSeasonal("SeasonOfDiscovery") then
			-- GetServerTime() returns local time in classic and there doesn't seem to be a good way to get actual server date in classic. This is good enough.
			local dmfOffset = (GetServerTime() - 1713736800) / (60 * 60 * 24 * 28) % 1
			return dmfOffset <= 0.25 and "m1456" -- Thunderbluff
				or dmfOffset >= 0.5 and dmfOffset <= 0.75 and "m1429" -- Elwynn
				or nil -- Not active
		else
			return nil -- TODO: implement Classic era logic and whatever Cataclysm is doing. Slightly more annoying to calculate than SoD
		end
	end

	---@param checkTable string
	---@param checkValue any
	---@param delay number?
	function DBM:LoadModsOnDemand(checkTable, checkValue, delay)
		self:Debug("LoadModsOnDemand fired for table " .. checkTable .. " value " .. tostring(checkValue))
		local dmfMod
		for _, v in ipairs(self.AddOns) do
			local modTable = v[checkTable]
			local enabled = C_AddOns.GetAddOnEnableState(v.modId, playerName)
			if v.modId == "DBM-WorldEvents" and enabled ~= 0 and not C_AddOns.IsAddOnLoaded(v.modId) then
				dmfMod = v
			end
			--self:Debug(v.modId .. " is " .. enabled, 2)
			if not C_AddOns.IsAddOnLoaded(v.modId) and modTable and checkEntry(modTable, checkValue) then
				if enabled ~= 0 then
					if self:IsSeasonal("SeasonOfDiscovery") and sodLevelUpRaids[LastInstanceMapID] and v.modId == "DBM-Party-Vanilla" then
						--Don't load dungeon mods in SoD Raids
						return
					end
					self:LoadMod(v)
				else
					self:AddMsg(L.LOAD_MOD_DISABLED:format(v.name))
				end
			end
		end
		if private.isRetail and delay then
			self:ScenarioCheck(delay)--Do not filter. Because ScenarioCheck function includes filter.
		end
		-- Hard-code loading logic for DMF classic which depends on time and map
		if dmfMod and checkTable == "mapId" and private.isClassic and isDmfActiveClassic() == checkValue then
			self:LoadMod(dmfMod, true)
		end
	end
end

--Scenario mods
function DBM:ScenarioCheck(delay)
	if dbmIsEnabled and combatInfo[LastInstanceMapID] then
		for _, v in ipairs(combatInfo[LastInstanceMapID]) do
			if (v.type == "scenario") and checkEntry(v.msgs, LastInstanceMapID) then
				self:StartCombat(v.mod, delay or 0, "LOADING_SCREEN_DISABLED")
			end
		end
	end
end

function DBM:LoadMod(mod, force, enableTestSupport)
	enableTestSupport = enableTestSupport or DBM_ModsToLoadWithFullTestSupport.addonsWithTests[mod.modId]
	if type(mod) ~= "table" then
		self:Debug("LoadMod failed because mod table not valid")
		return false
	end
	--Block loading world boss mods by zoneID, except if it's a heroic warfront or darkmoon faire island
	if mod.isWorldBoss and not IsInInstance() and not force and (not private.isRetail or difficulties.difficultyIndex ~= 149) and LastInstanceMapID ~= 974 then
		return
	end
	if mod.minRevision > self.Revision then
		if self:AntiSpam(60, "VER_MISMATCH") then--Throttle message in case person keeps trying to load mod (or it's a world boss player keeps targeting
			self:AddMsg(L.LOAD_MOD_VER_MISMATCH:format(mod.name))
		end
		return
	end
	if mod.minExpansion > GetExpansionLevel() and not force then
		self:AddMsg(L.LOAD_MOD_EXP_MISMATCH:format(mod.name))
		return
	elseif not private.testBuild and mod.minToc > private.wowTOC then
		self:AddMsg(L.LOAD_MOD_TOC_MISMATCH:format(mod.name, mod.minToc))
		return
	end
	if (not currentSpecID or currentSpecID == 0) or (currentSpecName or "") == playerClass then
		self:SetCurrentSpecInfo()
	end
	difficulties:RefreshCache()
	if private.isRetail or private.isMop then
		EJ_SetDifficulty(difficulties.difficultyIndex)--Work around blizzard crash bug where other mods (like Boss) screw with Ej difficulty value, which makes EJ_GetSectionInfo crash the game when called with invalid difficulty index set.
	end
	self:Debug("LoadAddOn should have fired for " .. mod.name, 2)
	local loaded, reason
	if enableTestSupport and test:Load() then
		test:OnBeforeLoadAddOn()
		loaded, reason = C_AddOns.LoadAddOn(mod.modId)
		test:OnAfterLoadAddOn()
	else
		loaded, reason = C_AddOns.LoadAddOn(mod.modId)
	end
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
		self:LoadModOptions(mod.modId, InCombatLockdown(), true) -- Show the test UI immediately to make it clear that the mod is loaded with test support
		if DBM_GUI then
			DBM_GUI:UpdateModList()
			DBM_GUI:CreateBossModTab(mod, mod.panel)
			if DBM_GUI.currentViewing == mod.panel.frame then
				_G["DBM_GUI_OptionsFrame"]:DisplayFrame(mod.panel.frame)
			end
		end
		if LastInstanceType ~= "pvp" and #inCombat == 0 and IsInGroup() then--do timer recovery only mod load
			if not timerRequestInProgress then
				timerRequestInProgress = true
				if self:IsPostMidnight() then--TODO, see if needed, blizzard timeline might already resend added events
				--	--Request timeline timers from API
					self:RecoverBlizzardTimers()
				end
				-- Request timer to 3 person to prevent failure.
				self:Unschedule(self.RequestTimers)
				if not self:MidRestrictionsActive() then
					self:Schedule(7, self.RequestTimers, self, 1)
					self:Schedule(10, self.RequestTimers, self, 2)
					self:Schedule(13, self.RequestTimers, self, 3)
				end
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

function DBM:LoadModByName(modName, force, enableTestSupport)
	for _, v in ipairs(self.AddOns) do
		if v.modId == modName then
			self:LoadMod(v, force, enableTestSupport)
		end
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
		if self:IsPostMidnight() and IsInInstance() then return end
		loadModByUnit("mouseover")
	end

	function DBM:NAME_PLATE_UNIT_ADDED(uId)
		if self:IsPostMidnight() and IsInInstance() then return end
		loadModByUnit(uId)
	end

	function DBM:UNIT_TARGET(uId)
		if self:IsPostMidnight() and IsInInstance() then return end
		loadModByUnit(uId .. "target")
	end
end

-----------------------------
--  Handle Incoming Syncs  --
-----------------------------

--NOTE. Don't ever try to move this out of core. My testing showed it required storing nearly every local variable in core in private, gravely poluting and inflating it beyond any kind of rational

do
	local GetItemInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
	local function checkForActualPull()
		-- We don't need to check `RecordOnlyBosses` as it's already checked in where this function is called
		-- If you have more than 1 mob, keep logging
		-- If you're in mythic+, keep logging
		-- Otherwise, stop logging post-pull timer ended
		if #inCombat == 0 and difficulties.difficultyIndex ~= 8 then
			DBM:StopLogging()
		end
	end

	local DBMZoneCombatScanner = private:GetModule("TrashCombatScanningModule")

	local syncHandlers, whisperSyncHandlers, guildSyncHandlers = {}, {}, {}

	-- DBM uses the following prefixes since 4.1 as pre-4.1 sync code is going to be incompatible anways, so this is the perfect opportunity to throw away the old and long names
	-- M = Mod
	-- C = Combat start
	-- ZC = Zone Combat
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
		---@diagnostic disable-next-line: param-type-mismatch
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
				---@diagnostic disable-next-line: param-type-mismatch
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

	syncHandlers["ZC"] = function(sender, _, guid, cid)
		DBMZoneCombatScanner:OnSync(sender, guid, tonumber(cid))
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

	syncHandlers["K"] = function(_, _, cId, difficulty)
		if not difficulty then return end
		difficulty = tonumber(difficulty)
		--Ignore kill events sent from wrong difficulty (such as a player doing same raid at same time in another difficulty)
		if difficulty ~= difficulties.difficultyIndex then return end
		if select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "none" then return end
		cId = tonumber(cId or "")
		if cId then DBM:OnMobKill(cId, true) end
	end

	syncHandlers["EE"] = function(sender, _, eId, success, mod, modRevision)
		if select(2, IsInInstance()) == "pvp" then return end
		eId = tonumber(eId or "")
		success = tonumber(success)
		---@diagnostic disable-next-line: param-type-mismatch
		mod = DBM:GetModByName(mod or "")
		modRevision = tonumber(modRevision or 0) or 0
		if mod and eId and success and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) and not eeSyncSender[sender] then
			eeSyncSender[sender] = true
			eeSyncReceived = eeSyncReceived + 1
			if eeSyncReceived > (private.isRetail and 2 or 0) then -- need at least 3 person to combat end. (for security) (only 1 on classic because classic breaks too badly otherwise)
				DBM:EndCombat(mod, success == 0, nil, "ENCOUNTER_END synced")
			end
		end
	end

	local dummyMod -- dummy mod for the pull timer

	---@param self DBM
	---@param sender string
	---@param timer any string or number only, but luaLS bitches if I actually tell it that
	---@param blizzardTimer boolean?
	local function pullTimerStart(self, sender, timer, blizzardTimer)
		if not timer then return end
		if not blizzardTimer then return end--Ignore old DBM version comms
		local unitId
		if sender then--Blizzard cancel events triggered by system (such as encounter start) have no sender
			if blizzardTimer then
				unitId = self:GetRaidUnitIdByGuid(sender)
				sender = self:GetUnitFullName(unitId) or sender
			else
				unitId = self:GetRaidUnitId(sender)
			end
			local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned(sender) == "TANK"
			if (self:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or private.IsEncounterInProgress() then
				return
			end
		end
		--Abort if mapID filter is enabled and sender actually sent a mapID. if no mapID is sent, it's always passed through (IE BW pull timers)
		if unitId then
			local senderMapID = IsInInstance() and select(-1, UnitPosition(unitId)) or C_Map.GetBestMapForUnit(unitId) or 0
			local playerMapID = IsInInstance() and select(-1, UnitPosition("player")) or C_Map.GetBestMapForUnit("player") or 0
			if self.Options.DontShowPTNoID and senderMapID and playerMapID and senderMapID ~= playerMapID then return end
		end
		timer = tonumber(timer or 0)
		--We want to permit 0 itself, but block anything negative number or anything between 0 and 3 or anything longer than minute
		if (timer > 0 and timer < 3) then--timer > 60 or
			return
		end
		if timer <= 0 or self:AntiSpam(1, "PT" .. (sender or "SYSTEM")) then--prevent double pull timer from BW and other mods that are sending D4 and D5 at same time (DELETE AntiSpam Later)
			if not dummyMod then
				local threshold = self.Options.PTCountThreshold2
				threshold = floor(threshold)
				---@class DBMDummyMod: DBMMod
				dummyMod = self:NewMod("PullTimerCountdownDummy")
				dummyMod.isDummyMod = true
				self:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{name = L.MINIMAP_TOOLTIP_HEADER}
				dummyMod.text = dummyMod:NewAnnounce("%s", 1, "132349")
				dummyMod.geartext = dummyMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3)
				dummyMod.timer = dummyMod:NewTimer(20, "%s", "132349", nil, nil, 0, nil, nil, self.Options.DontPlayPTCountdown and 0 or 4, threshold, nil, nil, nil, nil, nil, nil, "pull")
			end
			--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not self.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_PULL)
				dummyMod.timer:Stop()
			end
			dummyMod.text:Cancel()
			if timer == 0 then return end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is why we let above part of code run but not below)
			self:FlashClientIcon()
			if not self.Options.DontShowPT2 then
				dummyMod.timer:Start(timer, L.TIMER_PULL)
			end
			if not self.Options.DontShowPTText and timer then
				if not self:IsPostMidnight() then
					local target = unitId and DBM:GetUnitFullName(unitId.."target")
					if target and not raid[target] then
						dummyMod.text:Show(L.ANNOUNCE_PULL_TARGET:format(target, timer, sender))
						dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW_TARGET:format(target))
					else
						dummyMod.text:Show(L.ANNOUNCE_PULL:format(timer, sender))
						dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW)
					end
				else
					dummyMod.text:Show(L.ANNOUNCE_PULL:format(timer, sender))
					dummyMod.text:Schedule(timer, L.ANNOUNCE_PULL_NOW)
				end
			end
			if self.Options.EventSoundPullTimer and self.Options.EventSoundPullTimer ~= "" and self.Options.EventSoundPullTimer ~= "None" then
				self:PlaySoundFile(self.Options.EventSoundPullTimer, nil, true)
			end
			if self.Options.RecordOnlyBosses then
				self:StartLogging(timer, checkForActualPull)--Start logging here to catch pre pots.
			end
			if private.isRetail and self.Options.CheckGear and not private.testBuild then
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
		---@param self DBM
		---@param timer number
		---@param sender string
		---@param isRecovery boolean?
		function breakTimerStart(self, timer, sender, isRecovery)
			local LFGTankException = IsPartyLFG and IsPartyLFG() and UnitGroupRolesAssigned(sender) == "TANK"
			if not isRecovery and ((self:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or private.IsEncounterInProgress()) then
				return
			end
			if not dummyMod2 then
				local threshold = self.Options.PTCountThreshold2
				threshold = floor(threshold)
				---@class DBMDummyMod2: DBMMod
				dummyMod2 = self:NewMod("BreakTimerCountdownDummy")
				dummyMod2.isDummyMod = true
				self:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{name = L.MINIMAP_TOOLTIP_HEADER}
				dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, private.isRetail and "237538" or "136106")
				--timer, name, icon, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b, spellId, requiresCombat, waCustomName, customType
				dummyMod2.timer = dummyMod2:NewTimer(20, L.TIMER_BREAK, private.isRetail and "237538" or "136106", nil, nil, 0, nil, nil, self.Options.DontPlayPTCountdown and 0 or 1, threshold, nil, nil, nil, nil, nil, nil, "break")
			end
			--Cancel any existing break timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not self.Options.DontShowPT2 then--and DBT:GetBar(L.TIMER_BREAK)
				dummyMod2.timer:Stop()
			end
			dummyMod2.text:Cancel()
			self.Options.RestoreSettingBreakTimer = nil
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
				dummyMod2.text:Show(L.BREAK_START:format(stringUtils.strFromTime(timer) .. " (" .. hour .. ":" .. minute .. ")", sender))
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
		if DBM.Options.DontShowUserTimers then return end--or not private.isWrath
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup()) or select(2, IsInInstance()) == "pvp" or private.IsEncounterInProgress() then
			return
		end
		if timer == 0 or DBM:AntiSpam(1, "BT" .. sender) then
			--For some reawson LuaLS is really stupid here. despite fact for it to be IMPOSSIBLE for timer to be anything but a valid number
			--It expects an extra number check for no reason at all
			---@diagnostic disable-next-line: param-type-mismatch
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
		--For some reawson LuaLS is really stupid here. despite fact for it to be IMPOSSIBLE for timer to be anything but a valid number
		--It expects an extra number check for no reason at all
		---@diagnostic disable-next-line: param-type-mismatch
		breakTimerStart(DBM, timer, sender, true)--, nil, true
	end

	local function SendVersion(guild)
		--Due to increasing addon comm throttling in instances, guild version sharing is disabled in instances to reduce comms
		if guild and not IsInInstance() then
			local message
			if not private.isRetail and DBM.classicSubVersion then
				message = ("%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, tostring(PForceDisable), tostring(DBM.classicSubVersion))
				sendGuildSync(3, "GV", message)
			else
				message = ("%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, tostring(PForceDisable))
				sendGuildSync(2, "GV", message)
			end
			return
		end
		if DBM.Options.FakeBWVersion and not dbmIsEnabled and not IsTrialAccount() then
			sendBWSync("V", ("%d^%s"):format(fakeBWVersion, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY", "NORMAL")
			return
		end
		--(Note, faker isn't to screw with bigwigs nor is theirs to screw with dbm, but rathor raid leaders who don't let people run WTF they want to run)
		sendSync(3, "V", ("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), tostring(PForceDisable), tostring(DBM.classicSubVersion or 0), tostring(DBM.dungeonSubVersion or 0)), "NORMAL")
	end

	local function HandleVersion(revision, version, displayVersion, forceDisable, sender, classicSubVers)
		if version > DBM.Revision then -- Update reminder
			--Core Version Handling
			if #newerVersionPerson < 4 then
				if not checkEntry(newerVersionPerson, sender) then
					newerVersionPerson[#newerVersionPerson + 1] = sender
					DBM:Debug("Newer version detected from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision), 3)
					if (forceDisable > PForceDisable) and not checkEntry(forceDisablePerson, sender) then
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
					if not private.testBuild and #forceDisablePerson == 3 then
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
					elseif private.testBuild then
						updateNotificationDisplayed = 3
						DBM:ForceDisableSpam()
						DBM:Disable(true)
					end
				end
			end
		end
		if not private.isRetail and type(classicSubVers) == 'number' and classicSubVers > DBM.classicSubVersion then -- Update reminder
			if #newersubVersionPerson < 4 then
				if not checkEntry(newersubVersionPerson, sender) then
					newersubVersionPerson[#newersubVersionPerson + 1] = sender
					DBM:Debug("Newer classic subversion detected from " .. sender .. " : Rev - " .. classicSubVers .. ", Rev Diff - " .. (classicSubVers - DBM.classicSubVersion), 3)
				end
				if #newersubVersionPerson == 2 and updateSubNotificationDisplayed < 2 then--Only requires 2 for update notification.
					updateSubNotificationDisplayed = 2
					local checkedSubmodule = private.isMop and "DBM-Raids-MoP" or private.isCata and "DBM-Raids-Cata" or private.isWrath and "DBM-Raids-WoTLK" or private.isBCC and "DBM-Raids-BC" or "DBM-Raids-Vanilla"
					AddMsg(DBM, L.UPDATEREMINDER_HEADER_SUBMODULE:match("\n(.*)"):format(checkedSubmodule, classicSubVers))
					showConstantReminder = 1
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

	syncHandlers["V"] = function(sender, protocol, revision, version, displayVersion, locale, iconEnabled, forceDisable, classicSubVers, dungeonSubVers)
		revision, version, classicSubVers, dungeonSubVers = tonumber(revision), tonumber(version), tonumber(classicSubVers), tonumber(dungeonSubVers) or 0
		if protocol < 3 then return end
		--Nil it out on retail, replace with string on classic versions
		if classicSubVers and classicSubVers == 0 then
			if private.isRetail then
				classicSubVers = nil
			else
				classicSubVers = L.MOD_MISSING
			end
		end
		if dungeonSubVers and dungeonSubVers == 0 then
			dungeonSubVers = L.NOT_INSTALLED
		end
		forceDisable = tonumber(forceDisable) or 0
		if revision and version and displayVersion and raid[sender] then
			raid[sender].revision = revision
			raid[sender].version = version
			raid[sender].displayVersion = displayVersion
			raid[sender].dungeonSubVers = dungeonSubVers
			if not private.isRetail then
				raid[sender].classicSubVers = classicSubVers
			end
			raid[sender].locale = locale
			raid[sender].enabledIcons = iconEnabled or "false"
			DBM:Debug("Received version info from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision), 3)
			HandleVersion(revision, version, displayVersion, forceDisable, sender, classicSubVers)
		end
		DBM:GROUP_ROSTER_UPDATE()
	end

	guildSyncHandlers["GV"] = function(sender, _, revision, version, displayVersion, forceDisable, classicSubVers)
		revision, version, forceDisable, classicSubVers = tonumber(revision), tonumber(version), tonumber(forceDisable) or 0, tonumber(classicSubVers)
		--Nil it out on retail, replace with string on classic versions
		if classicSubVers and classicSubVers == 0 then
			if private.isRetail then
				classicSubVers = nil
			else
				classicSubVers = L.MOD_MISSING
			end
		end
		if revision and version and displayVersion then
			DBM:Debug("Received G version info from " .. sender .. " : Rev - " .. revision .. ", Ver - " .. version .. ", Rev Diff - " .. (revision - DBM.Revision) .. ", Display Version " .. displayVersion, 3)
			HandleVersion(revision, version, displayVersion, forceDisable, sender, classicSubVers)
		end
	end

	syncHandlers["U"] = function(sender, _, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM.Options.DontShowUserTimers then return end
		if DBM:GetRaidRank(sender) == 0 or difficulties.difficultyIndex == 7 or difficulties.difficultyIndex == 17 then return end
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
		if DBM:GetRaidRank(sender) == 0 or difficulties.difficultyIndex == 7 or difficulties.difficultyIndex == 17 then return end--Block in LFR, or if not an assistant
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
		if DBM:AntiSpam(private.isRetail and 10 or 20, "GCB") then
			if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
			difficulty = tonumber(difficulty)
			if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
			modId = tonumber(modId)
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			if not private.isClassic and not private.isBCC then
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
		if DBM:AntiSpam(private.isRetail and 10 or 20, "GCE") then
			if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
			difficulty = tonumber(difficulty)
			if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
			modId = tonumber(modId)
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			if not private.isClassic and not private.isBCC then
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
					if DBM:IsPostMidnight() then
						DBM:AddMsg(L.GUILD_COMBAT_ENDED:format(groupLeader or CL.UNKNOWN, difficultyName .. " - " .. bossName, time))
					else
						DBM:AddMsg(L.GUILD_COMBAT_ENDED_AT:format(groupLeader or CL.UNKNOWN, difficultyName .. " - " .. bossName, wipeHP, time))--"%s's Guild group has wiped on %s (%s) after %s.
					end
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
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not private.IsEncounterInProgress() then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), sender))
		end
	end

	guildSyncHandlers["WBD"] = function(sender, protocol, modId, realm, name)
		if not protocol or protocol ~= 8 then return end--Ignore old versions
		if lastBossDefeat[modId .. realm] and (GetTime() - lastBossDefeat[modId .. realm] < 30) then return end
		lastBossDefeat[modId .. realm] = GetTime()
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not private.IsEncounterInProgress() then
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, sender))
		end
	end

	guildSyncHandlers["WBA"] = function(sender, protocol, bossName, faction, spellId, time) -- Classic only
		if DBM:IsSeasonal("SeasonOfDiscovery") then -- All World Buffs are spammy in SoD, disable
			return
		end
		if not protocol or protocol ~= 4 or private.isRetail then return end--Ignore old versions
		if lastBossEngage[bossName .. faction] and (GetTime() - lastBossEngage[bossName .. faction] < 30) then return end--We recently got a sync about this buff on this realm, so do nothing.
		lastBossEngage[bossName .. faction] = GetTime()
		if DBM.Options.WorldBuffAlert and #inCombat == 0 then
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
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and (private.isRetail and not private.IsEncounterInProgress() or #inCombat == 0) then
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
		if (realm == playerRealm or realm == normalizedPlayerRealm) and DBM.Options.WorldBossAlert and not private.IsEncounterInProgress() then
			local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
			local toonName = gameAccountInfo and gameAccountInfo.characterName or CL.UNKNOWN
			modId = tonumber(modId)--If it fails to convert into number, this makes it nil
			local bossName = modId and (EJ_GetEncounterInfo and EJ_GetEncounterInfo(modId) or DBM:GetModLocalization(modId).general.name) or name or CL.UNKNOWN
			DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, toonName))
		end
	end

	whisperSyncHandlers["WBA"] = function(sender, protocol, bossName, faction, spellId, time) -- Classic only
		if not protocol or protocol ~= 4 or private.isRetail then return end--Ignore old versions
		if lastBossEngage[bossName .. faction] and (GetTime() - lastBossEngage[bossName .. faction] < 30) then return end--We recently got a sync about this buff on this realm, so do nothing.
		lastBossEngage[bossName .. faction] = GetTime()
		if DBM.Options.WorldBuffAlert and #inCombat == 0 then
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
			if self:issecretvalue(msg) then
				return
			end
			local correctSender = GetCorrectSender(senderOne, senderTwo)
			if channel == "WHISPER" then
				handleSync(channel, correctSender, nil, strsplit("\t", msg))
			else
				handleSync(channel, correctSender, strsplit("\t", msg))
			end
		elseif prefix == "BigWigs" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT") then
			if self:issecretvalue(msg) then
				return
			end
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
			if self:issecretvalue(msg) then
				return
			end
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

	function DBM:START_PLAYER_COUNTDOWN(initiatedByGuid, timeSeconds)
		if self:hasanysecretvalues(initiatedByGuid, timeSeconds) then
			return
		end
		--Ignore this event in combat
		if #inCombat > 0 then return end
--		if timeSeconds > 60 then--treat as a break timer
--			breakTimerStart(self, timeSeconds, initiatedBy, true)
--		else--Treat as a pull timer
			--In TWW, initiatedByName is in a diff place. We solve this by simply checking new location cause that'll be nil on live
			pullTimerStart(self, initiatedByGuid, timeSeconds, true)
--		end
	end

	function DBM:CANCEL_PLAYER_COUNTDOWN(initiatedByGuid)
		if self:issecretvalue(initiatedByGuid) then
			return
		end
		--when CANCEL_PLAYER_COUNTDOWN is called by ENCOUNTER_START, sender is nil
--		breakTimerStart(self, 0, initiatedBy, true)
		--In TWW, initiatedByName is in a diff place. We solve this by simply checking new location cause that'll be nil on live
		pullTimerStart(self, initiatedByGuid, 0, true)
	end
end

----------------------
--  Pull Detection  --
----------------------
do
	local targetList = {}
	local function buildTargetList()
		--Iterate over all raid/party members and their targets
		local uId = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local id = (i == 0 and "target") or uId .. i .. "target"
			local guid = UnitGUID(id)
			if guid and DBM:IsCreatureGUID(guid) then
				targetList[DBM:GetCIDFromGUID(guid)] = id
			end
		end
		--Iterate over active nameplates
		for _, frame in pairs(C_NamePlate.GetNamePlates()) do
			local foundUnit = frame.namePlateUnitToken
			if foundUnit and UnitAffectingCombat(foundUnit) then
				local guid = UnitGUID(foundUnit)
				if guid and DBM:IsCreatureGUID(guid) then
					targetList[DBM:GetCIDFromGUID(guid)] = foundUnit
				end
			end
		end
	end

	local function clearTargetList()
		twipe(targetList)
	end

	---@param mod DBMMod
	---@param mob number Mob CreatureId
	---@param delay number
	local function scanForCombat(mod, mob, delay, combatType)
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

	---@param mob number Mob CreatureId
	---@param combatInfo CombatInfo
	local function checkForPull(mob, combatInfo, combatType)
		healthCombatInitialized = false
		--This just can't be avoided, trying to save cpu by using C_TimerAfter broke this
		--This needs the redundancy and ability to pass args.
		DBM:Schedule(0.5, scanForCombat, combatInfo.mod, mob, 0.5, combatType)
		if not private.isRetail then
			DBM:Schedule(1.25, scanForCombat, combatInfo.mod, mob, 1.25, combatType)
		end
		DBM:Schedule(2, scanForCombat, combatInfo.mod, mob, 2, combatType)
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
							if checkForPull(mob, v, v.type) then
								break
							end
						end
					else
						checkForPull(v.mob, v)
					end
				end
			end
		end
		--Prio the afk warning if afk
		if self.Options.AFKHealthWarning2 and not private.IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(3, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
			self:FlashClientIcon()
			local voice = DBM.Options.ChosenVoicePack2
			local path = 566558--Nightelf Bell
			if not private.voiceSessionDisabled and voice ~= "None" then
				path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
			end
			self:PlaySoundFile(path)
			if UnitHealthMax("player") ~= 0 then
				local health = UnitHealth("player") / UnitHealthMax("player") * 100
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		elseif self.Options.EnteringCombatAlert and not private.IsEncounterInProgress() and self:AntiSpam(10, "COMBAT") then
			self:FlashClientIcon()
			local voice = DBM.Options.ChosenVoicePack2
			if not private.voiceSessionDisabled and voice ~= "None" and private.swFilterDisabled >= 17 then
				self:PlaySoundFile("Interface\\AddOns\\DBM-VP" .. voice .. "\\enteringcombat.ogg")
				self:AddMsg(L.ENTERING_COMBAT)--Shown with no sound cause voice played
			else
				self:AddMsg(L.ENTERING_COMBAT, nil, true)--Played using generic sound
			end
		end
	end

	function DBM:PLAYER_REGEN_ENABLED()
		if delayedFunction then--Will throw error if not a function, purposely not doing and type(delayedFunction) == "function" for now to make sure code works though because it always should be function
			delayedFunction()
			delayedFunction = nil
		end
		if watchFrameRestore then
			if private.isRetail or private.isCata or private.isMop then
				ObjectiveTracker_Expand()
			elseif private.isWrath then
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
		if self.Options.LeavingCombatAlert and not private.IsEncounterInProgress() and self:AntiSpam(10, "LEAVINGCOMBAT") then
			local voice = DBM.Options.ChosenVoicePack2
			if not private.voiceSessionDisabled and voice ~= "None" and private.swFilterDisabled >= 17 then
				self:PlaySoundFile("Interface\\AddOns\\DBM-VP" .. voice .. "\\leavingcombat.ogg")
				self:AddMsg(L.LEAVING_COMBAT)--Shown with no sound cause voice played
			else
				self:AddMsg(L.LEAVING_COMBAT, nil, true)--Played using generic sound
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
			if not self:IsPostMidnight() and v.respawnTime and success == 0 then--No special hacks needed for bad wrath ENCOUNTER_END. Only mods that define respawnTime have a timer, since variable per boss.
				local timerEnabled = self.Options.ShowRespawn and not self.Options.DontShowEventTimers
				name = string.split(",", name)
				if timerEnabled then
					DBT:CreateBar(v.respawnTime, L.TIMER_RESPAWN:format(name), private.isRetail and 237538 or 136106)--Interface\\Icons\\Spell_Holy_BorrowedTime, Spell_nature_timestop
				end
				fireEvent("DBM_TimerBegin", "DBMRespawnTimer", L.TIMER_RESPAWN:format(name), v.respawnTime, private.isRetail and "237538" or "136106", "extratimer", nil, 0, v.id, nil, nil, nil, nil, nil, nil, nil, nil, nil, timerEnabled)
			end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						self:EndCombat(v, success == 0, nil, "ENCOUNTER_END")
						if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
							sendSync(DBMSyncProtocol, "EE", encounterID .. "\t" .. success .. "\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
						end
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v, success == 0, nil, "ENCOUNTER_END")
				if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
					sendSync(DBMSyncProtocol, "EE", encounterID .. "\t" .. success .. "\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
				end
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
						if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
							sendSync(DBMSyncProtocol, "EE", encounterID .. "\t1\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
						end
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v, nil, nil, "BOSS_KILL")
				if self:AntiSpam(3, "EE") then--Most bosses have both BOSS_KILL and ENCOUNTER_END, we don't want to send two EE syncs if we don't have to
					sendSync(DBMSyncProtocol, "EE", encounterID .. "\t1\t" .. v.id .. "\t" .. (v.revision or 0), "NORMAL")
				end
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

	---called for all mob chat events
	---@param self DBM
	---@param type string
	---@param msg string
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
						if v.mod.readyCheckQuestId and (self.Options.WorldBossNearAlert or v.mod.Options.ReadyCheck) and not IsQuestFlaggedCompleted(v.mod.readyCheckQuestId) and v.mod.readyCheckMaxLevel >= private.playerLevel then
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
		if self:issecretvalue(msg) then
			return
		end
		if private.IsEncounterInProgress() or (IsInInstance() and InCombatLockdown()) then--Too many 5 mans/old raids don't properly return encounterinprogress
			local targetName = target or "nil"
			self:Debug("CHAT_MSG_MONSTER_YELL from " .. npc .. " while looking at " .. targetName, 2)
		end
		if private.isClassic and not IsInInstance() then
			if self:IsSeasonal("SeasonOfDiscovery") then -- All World Buffs are spammy in SoD, disable
				return
			end
			if msg:find(L.WORLD_BUFFS.hordeOny) then
				SendWorldSync(self, 4, "WBA", "Onyxia\tHorde\t22888\t15\t4")
			elseif msg:find(L.WORLD_BUFFS.allianceOny) then
				SendWorldSync(self, 4, "WBA", "Onyxia\tAlliance\t22888\t15\t4")
			elseif msg:find(L.WORLD_BUFFS.hordeNef) then
				SendWorldSync(self, 4, "WBA", "Nefarian\tHorde\t22888\t16\t4")
			elseif msg:find(L.WORLD_BUFFS.allianceNef) then
				SendWorldSync(self, 4, "WBA", "Nefarian\tAlliance\t22888\t16\t4")
			elseif msg:find(L.WORLD_BUFFS.rendHead) then
				SendWorldSync(self, 4, "WBA", "rendBlackhand\tHorde\t16609\t7\t4")
			elseif msg:find(L.WORLD_BUFFS.zgHeartYojamba) then
				-- zg buff transcripts https://gist.github.com/venuatu/18174f0e98759f83b9834574371b8d20
				-- 28.58, 28.67, 27.77, 29.39, 28.67, 29.03, 28.12, 28.19, 29.61
				SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t28\t4")
			elseif msg:find(L.WORLD_BUFFS.zgHeartBooty) then
				-- 48.7, 49.76, 50.64, 49.42, 49.8, 50.67, 50.94, 51.06
				SendWorldSync(self, 4, "WBA", "Zandalar\tBoth\t24425\t49\t4")
			elseif msg:find(L.WORLD_BUFFS.blackfathomBoon) then
				--SendWorldSync(self, 4, "WBA", "Blackfathom\tBoth\t430947\t6\t4")
			end
		end
		return onMonsterMessage(self, "yell", msg)
	end

	function DBM:CHAT_MSG_MONSTER_EMOTE(msg)
		if self:issecretvalue(msg) then
			return
		end
		return onMonsterMessage(self, "emote", msg)
	end

	function DBM:CHAT_MSG_RAID_BOSS_EMOTE(msg, sender, ...)
		if self:issecretvalue(msg) then
			return
		end
		onMonsterMessage(self, "emote", msg)
		local id = msg:match("|Hspell:([^|]+)|h")
		if id then
			local spellId = tonumber(id)
			if spellId then
				local spellName = DBM:GetSpellName(spellId) or CL.UNKNOWN
				self:Debug("CHAT_MSG_RAID_BOSS_EMOTE fired: " .. sender .. "'s " .. spellName .. "(" .. spellId .. ")", 2)
			end
		end
		return self:FilterRaidBossEmote(msg, sender, ...)
	end

	function DBM:RAID_BOSS_EMOTE(msg, ...)--This is a mirror of above prototype only it has less args, both still exist for some reason.
		if self:issecretvalue(msg) then
			return
		end
		onMonsterMessage(self, "emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:RAID_BOSS_WHISPER(msg)
		if self:issecretvalue(msg) then
			return
		end
		--Make it easier for devs to detect whispers they are unable to see
		--TINTERFACE\\ICONS\\ability_socererking_arcanewrath.blp:20|t You have been branded by |cFFF00000|Hspell:156238|h[Arcane Wrath]|h|r!"
		if msg and msg ~= "" and #msg < 255 and IsInGroup() and not _G["BigWigs"] and not IsTrialAccount() then
			ChatThrottleLib:SendAddonMessage("ALERT", "Transcriptor", msg, IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")--Alert prio used since time accuracy is paramount for accurate logging
		end
	end

	function DBM:GOSSIP_SHOW()
		if not IsInInstance() then return end--Don't really care about it if not in a dungeon or raid
		local gossipOptionID = self:GetGossipID(true)
		if gossipOptionID then--At least one must return for debug
			if DBM:MidRestrictionsActive() then
				--GUID is a secret in combat
				self:Debug("GOSSIP_SHOW triggered with a gossip ID(s) of " .. strjoin(", ", tostring(gossipOptionID)))
			else
				local cid = self:GetUnitCreatureId("npc") or 0
				self:Debug("GOSSIP_SHOW triggered with a gossip ID(s) of " .. strjoin(", ", tostring(gossipOptionID)) .. " on creatureID " .. cid)
			end
		end
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		if self:issecretvalue(msg) then
			return
		end
		if private.isClassic and not IsInInstance() then
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
do
	---@param self DBM
	---@param confirm boolean?
	---@param confirmTime number?
	function checkWipe(self, confirm, confirmTime)
		if #inCombat > 0 then
			difficulties:RefreshCache()
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
			if (private.isRetail and IsInScenarioGroup()) or (difficulties.difficultyIndex == 11) or (difficulties.difficultyIndex == 12) or (difficulties.difficultyIndex == 208) then -- Scenario mod uses special combat start and must be enabled before sceniro end. So do not wipe.
				wipe = 0
			elseif private.IsEncounterInProgress() then -- Encounter Progress marked, you obviously in combat with boss. So do not Wipe
				wipe = 0
			elseif difficulties.savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- On dead or ghost, unit combat status detection would be fail. If you ghost in instance, that means wipe. But in worldboss, ghost means not wipe. So do not wipe.
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
				local maxDelayTime = (difficulties.savedDifficulty == "worldboss" and 15) or 5 --wait 10s more on worldboss do actual wipe.
				for _, v in ipairs(inCombat) do
					maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
				end
				self:Schedule(3, checkWipe, self, true, maxDelayTime)
			end
		end
	end

	---@param self DBM
	---@param mod DBMMod
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

	---@param self DBM
	---@param mod DBMMod
	function checkCustomBossHealth(self, mod)
		mod:CustomHealthUpdate()
		self:Schedule(mod.bossHealthUpdateTime or 1, checkCustomBossHealth, self, mod)
	end

	local tooltipsHidden = false
	---Delayed Guild Combat sync object so we allow time for RL to disable them
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

	---@param mod DBMMod
	---@param delay number
	---@param event string?
	---@param synced boolean?
	---@param syncedStartHp number?
	---@param syncedEvent string?
	function DBM:StartCombat(mod, delay, event, synced, syncedStartHp, syncedEvent)
		---@class DBMMod
		mod = mod
		cSyncSender = {}
		cSyncReceived = 0
		if not checkEntry(inCombat, mod) then
			if DBM.TaintedByTests then
				self:AddMsg(L.DBM_TAINTED_BY_TESTS) -- Shows this early in case tests messed with some filters below
			end
			if not mod.Options.Enabled then return end
			if not mod.combatInfo then return end
			if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
				return
			end
			--Hack to disable modules from activating in timewalking difficulty that have duplicate non timewalking difficulty mods
			--ie Cookie
			if mod.combatInfo.DisableInTimewalking and difficulties.savedDifficulty == 24 then
				return
			end
			if mod.combatInfo.RequiresTimewalking and difficulties.savedDifficulty ~= 24 then
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
			test:Trace(mod, "StartCombat", event)
			tinsert(inCombat, mod)
			-- Pull time is always considered as in combat, this makes sure checkWipe() triggers only after the minimum time without combat has passed since start.
			lastValidCombat = GetTime()
			if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
			end
			if mod.inCombatOnlySafeEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterSafeEvents(unpack(mod.inCombatOnlySafeEvents))
			end
			--Fix for "attempt to perform arithmetic on field 'stats' (a nil value)"
			if not mod.stats and not mod.noStatistics then
				self:AddMsg(L.BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
				mod.ignoreBestkill = true--Force this to true so we don't check any more occurances of "stats"
			elseif event == "TIMER_RECOVERY" then --add a lag time to delay when TIMER_RECOVERY
				delay = delay + select(4, GetNetStats()) / 1000
			end
			--set mod default info
			difficulties:RefreshCache(true)
			local name = mod.combatInfo.name
			local modId = mod.id
			if private.isRetail then
				self.PrivateAuras:RegisterAllUnits()
				if mod.addon and mod.addon.type == "SCENARIO" and (C_Scenario.IsInScenario() or test.Mocks and test.Mocks.IsInScenario()) and not mod.soloChallenge then
					mod.inScenario = true
				end
			end
			mod.engagedDiff = difficulties.savedDifficulty
			mod.engagedDiffText = difficulties.difficultyText
			mod.engagedDiffIndex = difficulties.difficultyIndex
			mod.engagedDiffModifier = difficulties.difficultyModifier
			mod.inCombat = true
			---@class CombatInfo
			local combatInfo = mod.combatInfo
			combatInfo.pull = GetTime() - (delay or 0)
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
			if (difficulties.savedDifficulty == "worldboss" and startHp < 98) or (event == "UNIT_HEALTH" and delay > 4) or event == "TIMER_RECOVERY" then--Boss was not full health when engaged, disable combat start timer and kill record
				mod.ignoreBestkill = true
			elseif mod.inScenario then
				local scenarioType, currentStage, numStages = C_Scenario.GetInfo()
				--Delves start in stage 2 of 3 because stage 1 is "entering" apparently.
				if currentStage > (scenarioType == "Delves" and 2 or 1) and numStages > 1 then
					mod.ignoreBestkill = true
				end
			else--Reset ignoreBestkill after wipe
				mod.ignoreBestkill = false
				--It was a clean pull, so cancel any RequestTimers which might fire after boss was pulled if boss was pulled right after mod load
				--Only want timer recovery on in progress bosses, not clean pulls
				if startHp > 98 and (difficulties.savedDifficulty == "worldboss" or event == "IEEU") or event == "ENCOUNTER_START" then
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
				if not self:IsPostMidnight() then
					if mod.CustomHealthUpdate then
						self:Schedule(mod.bossHealthUpdateTime or 1, checkCustomBossHealth, self, mod)
					else
						self:Schedule(mod.bossHealthUpdateTime or 1, checkBossHealth, self, mod)
					end
				end
			end
			--process global options
			self:HideBlizzardEvents(1)
			if self.Options.RecordOnlyBosses then
				self:StartLogging(0)
			end
			local trackedAchievements
			--TODO, is MoP classic still using the old path? will TBC when it launches on aniversary
			if private.isClassic or private.isBCC then
				trackedAchievements = false
			elseif private.isWrath or private.isCata then
				trackedAchievements = (GetNumTrackedAchievements() > 0)
			else
				trackedAchievements = (C_ContentTracking and C_ContentTracking.GetTrackedIDs(2)[1])
			end
			if self.Options.HideObjectivesFrame and mod.addon and mod.addon.type ~= "SCENARIO" and not trackedAchievements and difficulties.difficultyIndex ~= 8 and not InCombatLockdown() then
				if private.isRetail or private.isCata or private.isMop then--Do nothing due to taint and breaking
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
			self:UpdateMapRestrictions()
			--serperate timer recovery and normal start.
			if event ~= "TIMER_RECOVERY" then
				--add pull count
				if mod.stats and not mod.noStatistics then
					if not mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] then mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] = 0 end
					mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "Pulls"] + 1
				end
				--show speed timer
				if self.Options.AlwaysShowSpeedKillTimer2 and mod.stats and not mod.ignoreBestkill and not mod.noStatistics then
					local bestTime
					if difficulties.difficultyIndex == 8 or difficulties.difficultyIndex == 208 or difficulties.difficultyIndex == 226 then--Mythic+/Challenge Mode, Delves, and sod Molten Core
						local bestRank = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "BestRank"] or 0
						if bestRank == difficulties.difficultyModifier then
							--Don't show speed kill timer if not our highest rank. DBM only stores highest rank
							bestTime = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "BestTime"]
						end
					else
						bestTime = mod.stats[difficulties.statVarTable[difficulties.savedDifficulty] .. "BestTime"]
					end
					if bestTime and bestTime > 0 then
						local speedTimer = mod:NewTimer(bestTime, L.SPEED_KILL_TIMER_TEXT, private.isRetail and "237538" or "136106", nil, false)
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
				if not self:IsPostMidnight() then
					if mod.OnCombatStart then
						local startEvent = syncedEvent or event
						local nonZeroDelay = delay or 0
						if nonZeroDelay == 0 then
							nonZeroDelay = 0.000001
						end
						mod:OnCombatStart(nonZeroDelay, startEvent == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or startEvent == "SPELL_CAST_SUCCESS" or startEvent == "MONSTER_MESSAGE", startEvent == "ENCOUNTER_START")
					end
				else
					--call OnLimitedCombatStart (for mods that need to start separate oncombat start rules for retail vs classic due to retail restrictions)
					if mod.OnLimitedCombatStart then
						local startEvent = syncedEvent or event
						local nonZeroDelay = delay or 0
						if nonZeroDelay == 0 then
							nonZeroDelay = 0.000001
						end
						mod:OnLimitedCombatStart(nonZeroDelay, startEvent == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or startEvent == "SPELL_CAST_SUCCESS" or startEvent == "MONSTER_MESSAGE", startEvent == "ENCOUNTER_START")
					end
					if self.Options.HideBlizzardTimeline then
						C_CVar.SetCVar("encounterTimelineEnabled", "1")
						EncounterTimeline.TrackView:SetAlpha(0)
						EncounterTimeline.TimerView:SetAlpha(0)
					end
				end
				--send "C" sync
				if not synced and not mod.soloChallenge then
					sendSync(DBMSyncProtocol, "C", (delay or 0) .. "\t" .. modId .. "\t" .. (mod.revision or 0) .. "\t" .. startHp .. "\t" .. tostring(self.Revision) .. "\t" .. (mod.hotfixNoticeRev or 0) .. "\t" .. event, "ALERT")
				end
				if UnitIsGroupLeader("player") then
					--Global disables require normal, heroic, mythic raid on retail, or 10 man normal, 25 man normal, 40 man normal, 10 man heroic, or 25 man heroic on classic
					if difficulties.difficultyIndex == 14 or difficulties.difficultyIndex == 15 or difficulties.difficultyIndex == 16 or difficulties.difficultyIndex == 175 or difficulties.difficultyIndex == 176 or difficulties.difficultyIndex == 186 or difficulties.difficultyIndex == 193 or difficulties.difficultyIndex == 194 then
						local statusWhisper, guildStatus, raidIcons, chatBubbles = self.Options.DisableStatusWhisper and 1 or 0, self.Options.DisableGuildStatus and 1 or 0, self.Options.DisableRaidIcons and 1 or 0, self.Options.DisableChatBubbles and 1 or 0
						if statusWhisper ~= 0 or guildStatus ~= 0 or raidIcons ~= 0 or chatBubbles ~= 0 then
							sendSync(2, "RLO", statusWhisper .. "\t" .. guildStatus .. "\t" .. raidIcons .. "\t" .. chatBubbles, "ALERT")
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
					if mod.ignoreBestkill and (difficulties.savedDifficulty == "worldboss") then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
						self:AddMsg(L.COMBAT_STARTED_IN_PROGRESS:format(difficulties.difficultyText .. name))
					elseif mod.ignoreBestkill and mod.inScenario then
						self:AddMsg(L.SCENARIO_STARTED_IN_PROGRESS:format(difficulties.difficultyText .. name))
					else
						if mod.addon and mod.addon.type == "SCENARIO" then
							self:AddMsg(L.SCENARIO_STARTED:format(difficulties.difficultyText .. name))
						else
							self:AddMsg(L.COMBAT_STARTED:format(difficulties.difficultyText .. name))
							local check = not private.statusGuildDisabled and (private.isRetail and ((difficulties.difficultyIndex == 8 or difficulties.difficultyIndex == 14 or difficulties.difficultyIndex == 15 or difficulties.difficultyIndex == 16) and InGuildParty()) or difficulties.difficultyIndex ~= 1 and DBM:GetNumGuildPlayersInZone() >= 10)
							if check and not self.Options.DisableGuildStatus then--Only send relevant content, not guild beating down lich king or LFR.
								self:Unschedule(delayedGCSync, modId)
								self:Schedule(private.isRetail and 1.5 or 3, delayedGCSync, modId, difficulties.difficultyIndex, difficulties.difficultyModifier, name)
							end
						end
					end
				end
				--stop pull count
				---@class DBMDummyMod: DBMMod
				local dummyMod = self:GetModByName("PullTimerCountdownDummy")
				if dummyMod then--stop pull timer
					dummyMod.text:Cancel()
					dummyMod.timer:Stop()
				end
				if self.Options.EventSoundEngage2 and self.Options.EventSoundEngage2 ~= "" and self.Options.EventSoundEngage2 ~= "None" then
					self:PlaySoundFile(self.Options.EventSoundEngage2, nil, true)
				end
				if not mod.inScenario and self.Options.EventSoundMusic and self.Options.EventSoundMusic ~= "None" and self.Options.EventSoundMusic ~= "" and not (self.Options.EventMusicMythicFilter and (difficulties.savedDifficulty == "mythic" or difficulties.savedDifficulty == "challenge")) and not mod.noStatistics and not self.Options.RestoreSettingMusic then
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
						local usedTable = self.Options.EventSoundMusicCombined and self:GetMusic() or self:GetBattleMusic()
						if #usedTable >= 3 then
							local random = fastrandom(3, #usedTable)
							---@diagnostic disable-next-line: cast-local-type
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
				self:AddMsg(L.COMBAT_STATE_RECOVERED:format(difficulties.difficultyText .. name, stringUtils.strFromTime(delay)))
				if mod.OnTimerRecovery then
					mod:OnTimerRecovery()
				end
			end
			if difficulties.savedDifficulty == "worldboss" and mod.WBEsync then
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
		if dbmIsEnabled then
			if cId ~= 0 and not bossHealth[cId] and bossIds[cId] and UnitAffectingCombat(uId) and not (UnitPlayerOrPetInRaid(uId) or UnitPlayerOrPetInParty(uId)) and healthCombatInitialized then -- StartCombat by UNIT_HEALTH.
				if combatInfo[LastInstanceMapID] then
					for _, v in ipairs(combatInfo[LastInstanceMapID]) do
						if v.mod.Options.Enabled and not v.mod.disableHealthCombat and v.type:find("combat") and (v.multiMobPullDetection and checkEntry(v.multiMobPullDetection, cId) or v.mob == cId) and not (#inCombat > 0 and v.noMultiBoss) then
							if v.mod.noFriendlyEngagement and UnitIsFriend("player", uId) then return end
							-- Delay set, > 97% = 0.5 (consider as normal pulling), max delay limited to 20s.
							self:StartCombat(v.mod, health > 97 and 0.5 or mmin(GetTime() - lastCombatStarted, 20), "UNIT_HEALTH", nil, health)
						end
					end
				end
			end
			if UnitIsUnit(uId, "player") and health < 100 and not private.IsEncounterInProgress() then
				--PRIO afk alert first
				if self.Options.AFKHealthWarning2 and (health < (private.isHardcoreServer and 95 or 85)) and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then
					local voice = DBM.Options.ChosenVoicePack2
					local path = 566558--Nightelf Bell
					if not private.voiceSessionDisabled and voice ~= "None" then
						path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
					end
					self:PlaySoundFile(path)
					self:AddMsg(L.AFK_WARNING:format(health))
				--Low health warning
				elseif self.Options.HealthWarningLow and health < 35 and self:AntiSpam(5, "LOWHEALTH") then
					local voice = DBM.Options.ChosenVoicePack2
					local path = 566558--Nightelf Bell
					if not private.voiceSessionDisabled and voice ~= "None" then
						path = "Interface\\AddOns\\DBM-VP" .. voice .. "\\checkhp.ogg"
					end
					self:PlaySoundFile(path)
					self:AddMsg(L.LOWHEALTH_WARNING:format(health))
				end
			end
		end
	end
	DBM.UNIT_HEALTH_FREQUENT = DBM.UNIT_HEALTH

	---@param mod DBMMod
	---@param wipe boolean?
	---@param srmIncluded boolean? unregister all events including SPELL_AURA_REMOVED events
	---@param event string?
	function DBM:EndCombat(mod, wipe, srmIncluded, event)
		---@class DBMMod
		mod = mod
		if removeEntry(inCombat, mod) then
			test:Trace(mod, "EndCombat", event)
			local scenario = mod.addon and mod.addon.type == "SCENARIO" and not mod.soloChallenge
			if (mod.inCombatOnlyEvents or mod.inCombatOnlySafeEvents) and mod.inCombatOnlyEventsRegistered then
				if srmIncluded then
					mod:UnregisterInCombatEvents(false, true)
				else
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
			if mod.tlTimerEvents then
				mod:DisableTimelineOptions()
			end
			if mod.tlSoundEvents then
				mod:DisableAlertOptions()
			end
			if private.isRetail then
				self.PrivateAuras:UnregisterPrivateAuras(nil)--Sending no unit unregisters all
			end
			self.Options.IgnoreBlizzAPI = false
			self.Options.DisableSWSound = false
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
			difficulties:RefreshCache(true)
			--Fix stupid classic behavior where wipes only happen after release which causes all the instance difficulty info to be wrong
			--This uses stored values from engage first, and only current values as fallback
			local usedDifficulty = mod.engagedDiff or difficulties.savedDifficulty
			local usedDifficultyText = mod.engagedDiffText or difficulties.difficultyText
			local usedDifficultyIndex = mod.engagedDiffIndex or difficulties.difficultyIndex
			local usedDifficultyModifier = mod.engagedDiffModifier or difficulties.difficultyModifier or 0
			local name = mod.combatInfo.name
			local modId = mod.id
			if wipe and mod.stats and not mod.noStatistics then
				mod.lastWipeTime = GetTime()
				--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
				local thisTime = GetTime() - mod.combatInfo.pull
				local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
				local wipeHP
				if not DBM:IsPostMidnight() then
					wipeHP = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
					if mod.vb.phase then
						wipeHP = wipeHP .. " (" .. SCENARIO_STAGE:format(mod.vb.phase) .. ")"
					end
					if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
						local bossesKilled = mod.numBoss - mod.vb.bossLeft
						wipeHP = wipeHP .. " (" .. BOSSES_KILLED:format(bossesKilled, mod.numBoss) .. ")"
					end
				end
				local totalPulls = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"]
				local totalKills = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"]
				if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
					totalPulls = totalPulls - 1
					mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"] = totalPulls
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime)))
						else
							if self:IsPostMidnight() then
								self:AddMsg(L.COMBAT_ENDED:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime)))
							else
								self:AddMsg(L.COMBAT_ENDED_AT:format(usedDifficultyText .. name, wipeHP, stringUtils.strFromTime(thisTime)))
							end
							--No reason to GCE it here, so omited on purpose.
						end
					end
				else
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT_LONG:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime), totalPulls - totalKills))
						else
							if self:IsPostMidnight() then
								self:AddMsg(L.COMBAT_ENDED_LONG:format(usedDifficultyText .. name, stringUtils.strFromTime(thisTime), totalPulls - totalKills))
							else
								self:AddMsg(L.COMBAT_ENDED_AT_LONG:format(usedDifficultyText .. name, wipeHP, stringUtils.strFromTime(thisTime), totalPulls - totalKills))
							end
							local check = private.isRetail and
								((usedDifficultyIndex == 8 or usedDifficultyIndex == 14 or usedDifficultyIndex == 15 or usedDifficultyIndex == 16) and InGuildParty()) or
								usedDifficultyIndex ~= 1 and DBM:GetNumGuildPlayersInZone() >= 10 -- Classic
							if check and not self.Options.DisableGuildStatus then
								self:Unschedule(delayedGCSync, modId)
								self:Schedule(private.isRetail and 1.5 or 3, delayedGCSync, modId, usedDifficultyIndex, difficulties.difficultyModifier, name, stringUtils.strFromTime(thisTime), wipeHP)
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
				local lastTime = mod.stats[difficulties.statVarTable[usedDifficulty] .. "LastTime"]
				local bestTime = mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"]
				if not mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] or mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] < 0 then mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] = 0 end
				--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] + 1
				if mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] > mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"] then mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"] = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Pulls"] end
				if not mod.ignoreBestkill and mod.combatInfo.pull then
					mod.stats[difficulties.statVarTable[usedDifficulty] .. "LastTime"] = thisTime
					--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
					if bestTime and bestTime > 0 and bestTime < 1.5 then
						mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = thisTime
					else
						if usedDifficultyIndex == 8 or usedDifficultyIndex == 208 or usedDifficultyIndex == 226 then--Mythic+/Challenge Mode, Delves, and sod Molten Core
							if mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestRank"] > usedDifficultyModifier then--Don't save time stats at all
								--DO nothing
							elseif mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestRank"] < usedDifficultyModifier then--Update best time and best rank, even if best time is lower (for a lower rank)
								mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestRank"] = usedDifficultyModifier--Update best rank
								mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = thisTime--Write this time no matter what.
							else--Best rank must match current rank, so update time normally
								mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = mmin(bestTime or mhuge, thisTime)
							end
						else
							mod.stats[difficulties.statVarTable[usedDifficulty] .. "BestTime"] = mmin(bestTime or mhuge, thisTime)
						end
					end
				end
				local totalKills = mod.stats[difficulties.statVarTable[usedDifficulty] .. "Kills"]
				if self.Options.ShowDefeatMessage then
					local msg
					local thisTimeString = thisTime and stringUtils.strFromTime(thisTime)
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
							msg = L.SCENARIO_COMPLETE_NR:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_NR:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(bestTime), totalKills)
						end
					else
						if scenario then
							msg = L.SCENARIO_COMPLETE_L:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(lastTime), stringUtils.strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_L:format(usedDifficultyText .. name, thisTimeString, stringUtils.strFromTime(lastTime), stringUtils.strFromTime(bestTime), totalKills)
						end
					end
					local check = not private.statusGuildDisabled and (private.isRetail and ((usedDifficultyIndex == 8 or usedDifficultyIndex == 14 or usedDifficultyIndex == 15 or usedDifficultyIndex == 16) and InGuildParty()) or usedDifficultyIndex ~= 1 and DBM:GetNumGuildPlayersInZone() >= 10) -- Classic
					if not scenario and thisTimeString and check and not self.Options.DisableGuildStatus and updateNotificationDisplayed == 0 then
						self:Unschedule(delayedGCSync, modId)
						self:Schedule(private.isRetail and 1.5 or 3, delayedGCSync, modId, usedDifficultyIndex, usedDifficultyModifier, name, thisTimeString)
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
				if self.Options.EventSoundVictory2 and self.Options.EventSoundVictory2 ~= "None" and self.Options.EventSoundVictory2 ~= "" and difficulties.difficultyIndex ~= 232 then--No victory in duos
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
			if mod.OnCombatEnd then mod:OnCombatEnd(wipe or false) end
			if mod.OnLeavingCombat then delayedFunction = mod.OnLeavingCombat end
			mod.engagedDiff = nil
			mod.engagedDiffText = nil
			mod.engagedDiffIndex = nil
			mod.engagedDiffModifier = nil
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
						if private.isRetail or private.isCata or private.isMop then
							--ObjectiveTracker_Expand()
						elseif private.isWrath then
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
				self:CreatePizzaTimer(0, "", nil, nil, nil, true)--Auto Terminate infinite loop timers on combat end
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
				sendSync(DBMSyncProtocol, "K", cId .. "\t" .. difficulties.difficultyIndex, "ALERT")
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
				sendSync(DBMSyncProtocol, "K", cId .. "\t" .. difficulties.difficultyIndex, "ALERT")
			end
			self:EndCombat(v, nil, nil, "Main CID Down")
		end
	end
end

do
	local autoLog = false
	local autoTLog = false

	function DBM:StartLogging(timer, checkFunc, force)
		self:Unschedule(DBM.StopLogging)
		if self:IsLogableContent(force) then
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

	--In event api fails to pull any data at all, just assign classes to generic DPS role (typically unspecced players such as sub level 11)
	local catafallbackClassToRole = {
		["MAGE"] = 799,--Arcane Mage
		["PALADIN"] = 855,--Ret Paladin
		["WARRIOR"] = 746,--Arms Warrior
		["DRUID"] = 752,--Balance druid
		["DEATHKNIGHT"] = 399,--Frost DK
		["HUNTER"] = 811,--Beastmaster Hunter
		["PRIEST"] = 795,--Shadow Priest
		["ROGUE"] = 182,--Assassination Rogue
		["SHAMAN"] = 263,--Enhancement Shaman
		["WARLOCK"] = 871,--Affliction Warlock
	}

	function DBM:SetCurrentSpecInfo()
		if private.isRetail or private.isMop then
			currentSpecGroup = GetSpecialization()
			if currentSpecGroup then
				currentSpecID, currentSpecName = GetSpecializationInfo(currentSpecGroup)
				currentSpecID = tonumber(currentSpecID)
				if not currentSpecID or currentSpecID == 0 then
					currentSpecID, currentSpecName = fallbackClassToRole[playerClass], playerClass
				end
			else
				currentSpecID, currentSpecName = fallbackClassToRole[playerClass], playerClass--give temp first spec id for non-specialization char. no one should use dbm with no specialization, below level 10, should not need dbm.
			end
			DBM:Debug("Current specID set to: "..currentSpecID, 2)
		elseif private.isCata then
			currentSpecGroup = GetPrimaryTalentTree()
			if currentSpecGroup and GetTalentTabInfo(currentSpecGroup) then
				currentSpecID, currentSpecName = GetTalentTabInfo(currentSpecGroup)
				currentSpecID = tonumber(currentSpecID)
			else
				currentSpecID, currentSpecName = catafallbackClassToRole[playerClass], playerClass--give temp first spec id for non-specialization char. no one should use dbm with no specialization, below level 10, should not need dbm.
			end
			DBM:Debug("Current specID set to: "..currentSpecID, 2)
		else
			local numTabs = GetNumTalentTabs()
			local highestPointsSpent = 0
			if MAX_TALENT_TABS then
				for i = 1, MAX_TALENT_TABS do
					if i <= numTabs then
						local _, _, _, _, pointsSpent = GetTalentTabInfo(i)--specID, specName will be used in next update once era spec table rebuilt
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
		if not InCombatLockdown() and currentSpecID and not private.specRoleTable[currentSpecID] then
			--Refresh entire spec table if not in combat and it's still missing for some reason
			DBMExtraGlobal:rebuildSpecTable()
		end
	end
end

function DBM:GetCurrentArea()
	return LastInstanceMapID
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

do
	local hasRestrictions = false
	---@param self DBMModOrDBM
	function DBM:UpdateMapRestrictions()
		--Check playerX and playerY. if they are nil restrictions are active
		--Restrictions active in all party, raid, pvp, arena maps. No restrictions in "none" or "scenario"
		local playerX, playerY = UnitPosition("player")
		if playerX and playerY then
			hasRestrictions = false
		else
			hasRestrictions = true
		end
	end

	---@param self DBMModOrDBM
	function DBM:HasMapRestrictions()
		return hasRestrictions
	end
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
		test:Trace(self, "PlaySound", path)
	end
end

---Future proofing EJ_GetSectionInfo compat layer to make it easier updatable.
function DBM:EJ_GetSectionInfo(sectionID)--Should be number, but accepts string too since Blizzards api converts strings to number.
	if not sectionID then return end
	if private.isClassic or private.isBCC or private.isWrath then
		return "EJ_GetSectionInfo not supported on Classic, please report this message and boss"
	end
	--Built in wow api extension doesn't know EJ_GetSectionInfo can accept strings
	local info = EJ_GetSectionInfo(sectionID)
	if not info then
		self:Debug("|cffff0000Invalid call to EJ_GetSectionInfo for sectionID: |r" .. sectionID)
		return
	end
	local flag1, flag2, flag3, flag4
	--Built in wow api extension doesn't know EJ_GetSectionInfo can accept strings
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

do
	--Handle new spell name requesting with wrapper, to make api changes easier to handle
	local GetSpellInfo, GetSpellTexture, GetSpellCooldown, GetSpellName
	local halfAssedClassicPath
	if C_Spell and C_Spell.GetSpellInfo then
		GetSpellInfo, GetSpellTexture, GetSpellName = C_Spell.GetSpellInfo, C_Spell.GetSpellTexture, C_Spell.GetSpellName
		--Blizzard forgot to sync GetSpellCooldown to C Space with other spells in all classic versions (cata and vanilla and wrath alike)
		--This is what happens when you do half assed syncs that can't even maintain parity properly during rebases
		if not C_Spell.GetSpellCooldown then
			---@diagnostic disable-next-line: undefined-field
			GetSpellCooldown = _G.GetSpellCooldown
			halfAssedClassicPath = true--Need to set variable so the wrapper knows it's arg return and not table return
		else
			GetSpellCooldown = C_Spell.GetSpellCooldown
		end
	end
	---Wrapper for Blizzard GetSpellInfo global that converts new table returns to old arg returns
	---<br>This avoids having to significantly update nearly 20 years of boss mods.
	---@param spellId string|number Should be number, but accepts string too since Blizzards api converts strings to number.
	function DBM:GetSpellInfo(spellId)
		--I want this to fail, and fail loudly (ie get reported when mods are completely missing the spellId)
		if not spellId or spellId == "" then
			error("|cffff0000Invalid call to GetSpellInfo for spellId. spellId is missing! |r")
		end
		local name, rank, icon, castingTime, minRange, maxRange, returnedSpellId
		local spellTable = GetSpellInfo(spellId)
		if spellTable then
			name, rank, icon, castingTime, minRange, maxRange, returnedSpellId = spellTable.name, nil, spellTable.iconID, spellTable.castTime, spellTable.minRange, spellTable.maxRange, spellTable.spellID
		end
		return name, rank, icon, castingTime, minRange, maxRange, returnedSpellId
	end

	---@param spellId string|number --Should be number, but accepts string too since Blizzards api converts strings to number.
	function DBM:GetSpellTexture(spellId)
		if not spellId then return end--Unlike 10.x and older, 11.x now errors if called without a spellId
		--Doesn't need a table at this time
		local texture
		--if newPath then
		--	local spellTable = GetSpellTexture(spellId)
		--	if spellTable then
		--		texture = spellTable.texture
		--	end
		--else
			texture = GetSpellTexture(spellId)
		--end
		return texture
	end

	---Wrapper for Blizzard GetSpellName global that auto handles using GetSpellName on newer clients and GetSpellInfo for older ones
	---@param spellId string|number --Should be number, but accepts string too since Blizzards api converts strings to number.
	function DBM:GetSpellName(spellId)
		if not spellId then return end--Unlike 10.x and older, 11.x now errors if called without a spellId
		local spellName = GetSpellName(spellId)
		return spellName
	end

	---Wrapper for Blizzard GetSpellCooldown global that converts new table returns to old arg returns
	---<br>This avoids having to significantly update nearly 20 years of boss mods.
	---@param spellId string|number --Should be number, but accepts string too since Blizzards api converts strings to number.
	function DBM:GetSpellCooldown(spellId)
		local start, duration, enable = 0, 0, true--return off CD values if API fails (ie midnight)
		if not self:MidRestrictionsActive(true) then
			if not halfAssedClassicPath then
				local spellTable = GetSpellCooldown(spellId)
				if spellTable then
					---@diagnostic disable-next-line: undefined-field
					start, duration, enable = spellTable.startTime, spellTable.duration, spellTable.isEnabled
				end
			else
				start, duration, enable = GetSpellCooldown(spellId)
			end
		end
		return start, duration, enable
	end
end

do
	--TODO, use GetUnitAuraBySpellID and GetUnitAuraBySpellName when possible for better performance
	local UnitAura = C_UnitAuras and C_UnitAuras.GetAuraDataByIndex or UnitAura
	local GetPlayerAuraBySpellID = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID
	local GetAuraDataBySpellName = C_UnitAuras and C_UnitAuras.GetAuraDataBySpellName
	---Custom UnitAura wrapper that can check spells by spellID or spell name for up to 5 spells at once
	---@param uId string
	---@param spellInput number|string|nil|unknown --required, accepts spellname or spellid
	---@param spellInput2 number|string|nil|unknown? --optional 2nd spell, accepts spellname or spellid
	---@param spellInput3 number|string|nil|unknown? --optional 3rd spell, accepts spellname or spellid
	---@param spellInput4 number|string|nil|unknown? --optional 4th spell, accepts spellname or spellid
	---@param spellInput5 number|string|nil|unknown? --optional 5th spell, accepts spellname or spellid
	function DBM:UnitAura(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		if not uId or self:issecretvalue(uId) then return end
		if private.isRetail and type(spellInput) == "number" and not spellInput2 and UnitIsUnit(uId, "player") then--A simple single spellId check should use more efficent direct blizzard method
			local spellTable = GetPlayerAuraBySpellID(spellInput)
			if not spellTable or self:issecretvalue(spellTable.name) then return end
			return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
		else--Either a multi spell check, spell name check, or C_UnitAuras.GetPlayerAuraBySpellID is unavailable
			if type(spellInput) == "string" and not spellInput2 then--A simple single spellName check should use more efficent direct blizzard method
				--Work around new bug in wow api extention
				---@diagnostic disable-next-line: param-type-mismatch
				local spellTable = GetAuraDataBySpellName(uId, spellInput)
				if not spellTable or self:issecretvalue(spellTable.name) then return end
				return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
			else--Either a multi spell check, or a single spell id check on non player unit (C_UnitAuras.GetPlayerAuraBySpellID is unavailable)
				for i = 1, 60 do
					--Work around new bug in wow api extention
					---@diagnostic disable-next-line: param-type-mismatch
					local spellTable = UnitAura(uId, i)
					if not spellTable or self:issecretvalue(spellTable.name) then return end
					if spellInput == spellTable.name or spellInput == spellTable.spellId or spellInput2 == spellTable.name or spellInput2 == spellTable.spellId or spellInput3 == spellTable.name or spellInput3 == spellTable.spellId or spellInput4 == spellTable.name or spellInput4 == spellTable.spellId or spellInput5 == spellTable.name or spellInput5 == spellTable.spellId then
						return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
					end
				end
			end
		end
	end

	---Custom UnitDebuff wrapper that can check spells by spellID or spell name for up to 5 spells at once
	---@param uId string
	---@param spellInput number|string|nil|unknown --required, accepts spellname or spellid
	---@param spellInput2 number|string|nil|unknown? --optional 2nd spell, accepts spellname or spellid
	---@param spellInput3 number|string|nil|unknown? --optional 3rd spell, accepts spellname or spellid
	---@param spellInput4 number|string|nil|unknown? --optional 4th spell, accepts spellname or spellid
	---@param spellInput5 number|string|nil|unknown? --optional 5th spell, accepts spellname or spellid
	function DBM:UnitDebuff(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		if not uId or self:issecretvalue(uId) then return end
		if private.isRetail and type(spellInput) == "number" and not spellInput2 and UnitIsUnit(uId, "player") then--A simple single spellId check should use more efficent direct blizzard method
			local spellTable = GetPlayerAuraBySpellID(spellInput)
			if not spellTable or self:issecretvalue(spellTable.name) then return end
			return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
		else--Either a multi spell check, spell name check, or C_UnitAuras.GetPlayerAuraBySpellID is unavailable
			if type(spellInput) == "string" and not spellInput2 then--A simple single spellName check should use more efficent direct blizzard method
				---@diagnostic disable-next-line: param-type-mismatch
				local spellTable = GetAuraDataBySpellName(uId, spellInput, "HARMFUL")
				if not spellTable or self:issecretvalue(spellTable.name) then return end
				return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
			else--Either a multi spell check, or a single spell id check on non player unit (C_UnitAuras.GetPlayerAuraBySpellID is unavailable)
				for i = 1, 60 do
					---@diagnostic disable-next-line: param-type-mismatch
					local spellTable = UnitAura(uId, i, "HARMFUL")
					if not spellTable or self:issecretvalue(spellTable.name) then return end
					if spellInput == spellTable.name or spellInput == spellTable.spellId or spellInput2 == spellTable.name or spellInput2 == spellTable.spellId or spellInput3 == spellTable.name or spellInput3 == spellTable.spellId or spellInput4 == spellTable.name or spellInput4 == spellTable.spellId or spellInput5 == spellTable.name or spellInput5 == spellTable.spellId then
						return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
					end
				end
			end
		end
	end

	---Custom UnitBuff wrapper that can check spells by spellID or spell name for up to 5 spells at once
	---@param uId string
	---@param spellInput number|string|nil|unknown --required, accepts spellname or spellid
	---@param spellInput2 number|string|nil|unknown? --optional 2nd spell, accepts spellname or spellid
	---@param spellInput3 number|string|nil|unknown? --optional 3rd spell, accepts spellname or spellid
	---@param spellInput4 number|string|nil|unknown? --optional 4th spell, accepts spellname or spellid
	---@param spellInput5 number|string|nil|unknown? --optional 5th spell, accepts spellname or spellid
	function DBM:UnitBuff(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		if not uId or self:issecretvalue(uId) then return end
		if private.isRetail and type(spellInput) == "number" and not spellInput2 and UnitIsUnit(uId, "player") then--A simple single spellId check should use more efficent direct blizzard method
			local spellTable = GetPlayerAuraBySpellID(spellInput)
			if not spellTable or self:issecretvalue(spellTable.name) then return end
			return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
		else--Either a multi spell check, spell name check, or C_UnitAuras.GetPlayerAuraBySpellID is unavailable
			if type(spellInput) == "string" and not spellInput2 then--A simple single spellName check should use more efficent direct blizzard method
				---@diagnostic disable-next-line: param-type-mismatch
				local spellTable = GetAuraDataBySpellName(uId, spellInput, "HELPFUL")
				if not spellTable or self:issecretvalue(spellTable.name) then return end
				return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
			else--Either a multi spell check, or a single spell id check on non player unit (C_UnitAuras.GetPlayerAuraBySpellID is unavailable)
				for i = 1, 60 do
					---@diagnostic disable-next-line: param-type-mismatch
					local spellTable = UnitAura(uId, i, "HELPFUL")
					if not spellTable or self:issecretvalue(spellTable.name) then return end
					if spellInput == spellTable.name or spellInput == spellTable.spellId or spellInput2 == spellTable.name or spellInput2 == spellTable.spellId or spellInput3 == spellTable.name or spellInput3 == spellTable.spellId or spellInput4 == spellTable.name or spellInput4 == spellTable.spellId or spellInput5 == spellTable.name or spellInput5 == spellTable.spellId then
						return spellTable.name, spellTable.icon, spellTable.applications, spellTable.dispelName, spellTable.duration, spellTable.expirationTime, spellTable.sourceUnit, spellTable.isStealable, spellTable.nameplateShowPersonal, spellTable.spellId, spellTable.canApplyAura, spellTable.isBossAura, spellTable.isFromPlayerOrPlayerPet, spellTable.nameplateShowAll, spellTable.timeMod, spellTable.points[1] or nil, spellTable.points[2] or nil, spellTable.points[3] or nil
					end
				end
			end
		end
	end

	---Function for returning if ANYONE in raid has a buff
	---@param spellInput number|string|nil|unknown --required, accepts spellname or spellid
	---@param spellInput2 number|string|nil|unknown? --optional 2nd spell, accepts spellname or spellid
	---@param spellInput3 number|string|nil|unknown? --optional 3rd spell, accepts spellname or spellid
	---@param spellInput4 number|string|nil|unknown? --optional 4th spell, accepts spellname or spellid
	---@param spellInput5 number|string|nil|unknown? --optional 5th spell, accepts spellname or spellid
	function DBM:RaidUnitBuff(spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		if self:MidRestrictionsActive(true) then return false end--Block access to UnitAura in combat in midnight
		for uId in DBM:GetGroupMembers() do
			local buff = DBM:UnitBuff(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
			if buff then
				return true
			end
		end
		return false
	end

	---Function for returning if ANYONE in raid has a debuff
	---@param spellInput number|string|nil|unknown --required, accepts spellname or spellid
	---@param spellInput2 number|string|nil|unknown? --optional 2nd spell, accepts spellname or spellid
	---@param spellInput3 number|string|nil|unknown? --optional 3rd spell, accepts spellname or spellid
	---@param spellInput4 number|string|nil|unknown? --optional 4th spell, accepts spellname or spellid
	---@param spellInput5 number|string|nil|unknown? --optional 5th spell, accepts spellname or spellid
	function DBM:RaidUnitDebuff(spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
		--Still gonna globally block this function because in no situation should we itereate entire raid in a post midnight world
		if self:MidRestrictionsActive(true) then return false end--Block access to UnitAura in combat in midnight
		for uId in DBM:GetGroupMembers() do
			local debuff = DBM:UnitDebuff(uId, spellInput, spellInput2, spellInput3, spellInput4, spellInput5)
			if debuff then
				return true
			end
		end
		return false
	end
end

--Event not registered in midnight, no additional checks needed
function DBM:UNIT_DIED(args)
	local GUID = args.destGUID
	if self:IsCreatureGUID(GUID) then
		self:OnMobKill(self:GetCIDFromGUID(GUID))
	end
	if inCombatTrash[GUID] then
		inCombatTrash[GUID] = nil
	end
	----GUIDIsPlayer
	--no point in playing alert on death itself on hardcore. if you're dead it's over, no reason to salt the wound
	if not private.isHardcoreServer and self.Options.AFKHealthWarning2 and GUID == UnitGUID("player") and not private.IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
		self:FlashClientIcon()
		local voice = DBM.Options.ChosenVoicePack2
		local path = 566558--Nightelf Bell
		if not private.voiceSessionDisabled and voice ~= "None" then
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
		self:Debug("RequestTimers Running", 3)
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
		sendWhisperSync(DBMSyncProtocol, "RT", "", selectedClient.name, "ALERT")
	end

	---@param mod DBMMod
	function DBM:ReceiveCombatInfo(sender, mod, time)
		if dbmIsEnabled and requestedFrom[sender] and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			self:StartCombat(mod, time, "TIMER_RECOVERY")
			--Recovery successful, someone sent info, abort other recovery requests
			self:Unschedule(self.RequestTimers)
			twipe(requestedFrom)
		end
	end

	---@param mod DBMMod
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

	---@param mod DBMMod
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
		if not dbmIsEnabled or IsTrialAccount() then return end
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
				sendWhisperSync(DBMSyncProtocol, "BTR3", remaining, target, "NORMAL")
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

---@param mod DBMMod
function DBM:SendCombatInfo(mod, target)
	if not dbmIsEnabled or IsTrialAccount() then return end
	return sendWhisperSync(DBMSyncProtocol, "CI", ("%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), target, "NORMAL")
end

---@param mod DBMMod
function DBM:SendTimerInfo(mod, target)
	if not dbmIsEnabled or IsTrialAccount() then return end
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
					sendWhisperSync(DBMSyncProtocol, "TR", ("%s\t%s\t%s\t%s\t%s"):format(mod.id, timeLeft, totalTime, uId, v.paused and "1" or "0"), target, "NORMAL")
				end
			end
		end
	end
end

---@param mod DBMMod
function DBM:SendVariableInfo(mod, target)
	if not dbmIsEnabled or IsTrialAccount() then return end
	for vname, v in pairs(mod.vb) do
		local v2 = tostring(v)
		if v2 then
			sendWhisperSync(DBMSyncProtocol, "VI", ("%s\t%s\t%s"):format(mod.id, vname, v2), target, "NORMAL")
		end
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
		elseif msg == "status" and #inCombat > 0 and DBM.Options.AutoRespond then--Delves still allow "status" specific whispers to be permissive
			difficulties:RefreshCache()
			local mod
			for _, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if mod.noStatistics then return end
			if private.isRetail and not mod.soloChallenge and IsInScenarioGroup() then return end--status not really useful on scenario mods since there is no way to report progress as a percent. We just ignore it.
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or CL.UNKNOWN
			if mod.vb.phase then
				hpText = hpText .. " (" .. SCENARIO_STAGE:format(mod.vb.phase) .. ")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText .. " (" .. BOSSES_KILLED:format(bossesKilled, mod.numBoss) .. ")"
			end
			sendWhisper(sender, chatPrefixShort .. L.STATUS_WHISPER:format(difficulties.difficultyText .. (mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
		elseif #inCombat > 0 and DBM.Options.AutoRespond and difficulties.difficultyIndex ~= 208 then--Auto respond in any instance except delves
			difficulties:RefreshCache()
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
				if private.isRetail and not mod.soloChallenge and IsInScenarioGroup() then
					sendWhisper(sender, chatPrefixShort .. L.AUTO_RESPOND_WHISPER_SCENARIO:format(playerName, difficulties.difficultyText .. (mod.combatInfo.name or ""), getNumAlivePlayers(), DBM:GetNumGroupMembers()))
				else
					sendWhisper(sender, chatPrefixShort .. L.AUTO_RESPOND_WHISPER:format(playerName, difficulties.difficultyText .. (mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
				end
				DBM:AddMsg(L.AUTO_RESPONDED)
			end
			autoRespondSpam[sender] = true
		end
	end

	function DBM:CHAT_MSG_WHISPER(msg, name, _, _, _, status)
		if self:issecretvalue(msg) then
			return
		end
		if name and type(name) == "string" and status ~= "GM" then
			name = Ambiguate(name, "none")
			return onWhisper(msg, name, false)
		end
	end

	function DBM:CHAT_MSG_BN_WHISPER(msg, ...)
		if self:issecretvalue(msg) then
			return
		end
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
			if (self.Options.HideBossEmoteFrame2 or custom) and not private.testBuild then
				DisableEvent(RaidBossEmoteFrame, "RAID_BOSS_EMOTE")
				DisableEvent(RaidBossEmoteFrame, "RAID_BOSS_WHISPER")
				DisableEvent(RaidBossEmoteFrame, "CLEAR_BOSS_EMOTES")
				MuteSoundFile(567394) -- SOUNDKIT.RAID_BOSS_EMOTE_WARNING
				MuteSoundFile(876098) -- SOUNDKIT.UI_RAID_BOSS_WHISPER_WARNING
			end
			if self.Options.HideGarrisonToasts or custom then
				DisableEvent(AlertFrame, "GARRISON_MISSION_FINISHED")
				DisableEvent(AlertFrame, "GARRISON_BUILDING_ACTIVATABLE")
			end
			if self.Options.HideGuildChallengeUpdates or custom then
				DisableEvent(AlertFrame, "GUILD_CHALLENGE_COMPLETED")
			end
		elseif toggle == 0 then
			if (self.Options.HideBossEmoteFrame2 or custom) and not private.testBuild then
				EnableEvent(RaidBossEmoteFrame, "RAID_BOSS_EMOTE")
				EnableEvent(RaidBossEmoteFrame, "RAID_BOSS_WHISPER")
				EnableEvent(RaidBossEmoteFrame, "CLEAR_BOSS_EMOTES")
				UnmuteSoundFile(567394) -- SOUNDKIT.RAID_BOSS_EMOTE_WARNING
				UnmuteSoundFile(876098) -- SOUNDKIT.UI_RAID_BOSS_WHISPER_WARNING
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
	-- Clear all stored timers for antispam, sync spam, combat re-detection etc.
	-- This is run after tests with time warping because these may refer to a time in the future
	function DBM:ClearSpamTimers()
		-- TODO: many of these timers follow the same anti-spam pattern, it would be useful to move those to a shared function to clean up this mess
		local time = _G.GetTime() -- to not accidentally pull in time-warped time, but it should be called after timewarping is disabled
		table.wipe(private.modSyncSpam)
		table.wipe(lastBossEngage)
		table.wipe(lastBossDefeat)
		lastCombatStarted = time
		lastValidCombat = time
		--lastLFGAlert = time -- local to the event handler, but doesn't really matter
		local function clearAntiSpam(obj)
			for k, v in pairs(obj) do -- TODO: consider moving lastAntiSpam to its own table, it'd be much cleaner
				if type(k) == "string" and k:match("^lastAntiSpam") and type(v) == "number" then
					obj[k] = nil
				end
			end
		end
		for _, mod in ipairs(DBM.Mods) do
			---@diagnostic disable-next-line: inject-field
			mod.lastKillTime = nil
			---@diagnostic disable-next-line: inject-field
			mod.lastWipeTime = nil
			---@diagnostic disable-next-line: inject-field
			if mod.combatInfo then
				mod.combatInfo.pull = nil
			end
			clearAntiSpam(mod)
		end
		clearAntiSpam(DBM)
	end

	local forceDisabled = false
	function DBM:Disable(forceDisable)
		for _, mod in ipairs(inCombat) do
			-- force combat end if anything is active because :Unschedule below breaks wipe detection leaving you in a weird state
			DBM:EndCombat(mod, true, true, "DBM:Disable() called")
		end
		for _, mod in ipairs(DBM.Mods) do
			mod:UnregisterShortTermEvents()
		end
		DBMScheduler:Unschedule()
		dbmIsEnabled = false
		forceDisabled = forceDisable
		DBT:CancelAllBars()
		DBM:ClearSpamTimers()
		DBM.InfoFrame:Hide()
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
		if private.testBuild then
			DBM:AddMsg(L.UPDATEREMINDER_DISABLETEST)
		else
			DBM:AddMsg(L.UPDATEREMINDER_DISABLE)
		end
	end
end

-----------------------
--  Misc. Functions  --
-----------------------
---@param self DBMModOrDBM
---@param text string
---@param prefix string|boolean?
---@param useSound boolean?
---@param allowHiddenChatFrame boolean?
---@param isDebug boolean? Used to play debug sounds on timer refresh warnings
---@param customColor number? Custom color index from WarningColors table
function DBM:AddMsg(text, prefix, useSound, allowHiddenChatFrame, isDebug, customColor)
	---@diagnostic disable-next-line: undefined-field
	local tag = prefix or (self.localization and self.localization.general.name) or L.DBM
	local frame = DBM.Options.ChatFrame and _G[tostring(DBM.Options.ChatFrame)] or DEFAULT_CHAT_FRAME
	if not frame or not frame:IsShown() and not allowHiddenChatFrame then
		frame = DEFAULT_CHAT_FRAME
	end
	local red, green, blue
	if customColor then
		red, green, blue = DBM.Options.WarningColors[customColor].r, DBM.Options.WarningColors[customColor].g, DBM.Options.WarningColors[customColor].b
	else
		red, green, blue = 0.41, 0.8, 0.94
	end
	if prefix ~= false then
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(tag), tostring(text)), red, green, blue)
	else
		frame:AddMessage(text, red, green, blue)
	end
	if DBM.Options.DebugSound and isDebug then
		DBM:PlaySoundFile(567458)--"Ding"
	end
	if useSound then
		DBM:PlaySoundFile(DBM.Options.RaidWarningSound, nil, true)
	end
end
AddMsg = DBM.AddMsg

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer1, testTimer2, testTimer3, testTimer4, testTimer5, testTimer6, testTimer7, testTimer8
	local testSpecialWarning1, testSpecialWarning2, testSpecialWarning3
	function DBM:DemoMode(forceOld)
		if self:IsPostMidnight() and not forceOld then
			--Run the encounter timeline demo mode instead of DBM test Bars
			C_EncounterTimeline.AddEditModeEvents()
		else
			fireEvent("DBM_TestModStarted")
			if not testMod then
				---@class DBMModTestMod: DBMMod
				testMod = self:NewMod("TestMod")
				self:GetModLocalization("TestMod"):SetGeneralLocalization{name = "Test Mod"}
				testWarning1 = testMod:NewAnnounce("%s", 1, "136116")--Interface\\Icons\\Spell_Nature_WispSplode
				testWarning2 = testMod:NewAnnounce("%s", 2, private.isRetail and "136194" or "136221")
				testWarning3 = testMod:NewAnnounce("%s", 3, "135826")
				testTimer1 = testMod:NewTimer(20, "%s", "136116", nil, nil)
				testTimer2 = testMod:NewTimer(20, "%s ", "134170", nil, nil, 1, CL.DAMAGE_ICON)
				testTimer3 = testMod:NewTimer(20, "%s  ", private.isRetail and "136194" or "136221", nil, nil, 3, CL.HEALER_ICON..CL.MAGIC_ICON, nil, 1, 4, nil, nil, nil, nil, nil, nil, "next")
				testTimer4 = testMod:NewTimer(20, "%s   ", "136116", nil, nil, 4, CL.INTERRUPT_ICON, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)--Flagged Priority for test mode
				testTimer5 = testMod:NewTimer(20, "%s    ", "135826", nil, nil, 2, CL.HEALER_ICON, nil, 3, 4, nil, nil, nil, nil, nil, nil, "next")
				testTimer6 = testMod:NewTimer(20, "%s     ", "136116", nil, nil, 5, CL.TANK_ICON..CL.BLEED_ICON, nil, 2, 4, nil, nil, nil, nil, nil, nil, "next")
				testTimer7 = testMod:NewTimer(20, "%s      ", "136116", nil, nil, 6)
				testTimer8 = testMod:NewTimer(20, "%s       ", "136116", nil, nil, 7)
				testSpecialWarning1 = testMod:NewSpecialWarning("%s", nil, nil, nil, 1, 2)
				testSpecialWarning2 = testMod:NewSpecialWarning(" %s ", nil, nil, nil, 2, 2)
				testSpecialWarning3 = testMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3, 2) -- hack: non auto-generated special warnings need distinct names (we could go ahead and give them proper names with proper localization entries, but this is much easier)
			end
			testTimer1:Stop("Test Bar showing 5s Variance")
			testTimer2:Stop("Adds")
			testTimer3:Stop("Evil Debuff")
			testTimer4:Stop("Important Interrupt")
			testTimer5:Stop("Boom!")
			testTimer6:Stop("Tank Buster")
			testTimer7:Stop("Next Stage")
			testTimer8:Stop("Custom User Bar")
			testTimer1:Start("v5-10", "Test Bar showing 5s Variance")
			testTimer2:Start("v25-30", "Adds")
			testTimer3:Start(43, "Evil Debuff")
			testTimer4:Start(20, "Important Interrupt")
			testTimer5:Start(60, "Boom!")
			testTimer6:Start("v32-35", "Tank Buster")
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
			testWarning1:Schedule(10, "Test Bar expired!")
			testSpecialWarning1:Schedule(20, "Pew Pew Laser Owl")
			testSpecialWarning1:ScheduleVoice(20, "runaway")
			testSpecialWarning2:Schedule(43, "Fear!")
			testSpecialWarning2:ScheduleVoice(43, "fearsoon")
			testSpecialWarning3:Schedule(60, "Boom!")
			testSpecialWarning3:ScheduleVoice(60, "defensive")
		end
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
	local role
	if private.isRetail then
		local spec = GetSpecialization()
		if not spec then return end
		role = GetSpecializationRole(spec)
		if not role then return end
		local specID = GetLootSpecialization()
		local _, _, _, _, lootrole = GetSpecializationInfoByID(specID)
		--Loot reminder even if spec isn't known or we are in LFR where we have a valid for role without us being ones that set us.
		if not ignoreLoot and lootrole and (role ~= lootrole) and self.Options.RoleSpecAlert then
			self:AddMsg(L.LOOT_SPEC_REMINDER:format(_G[role] or CL.UNKNOWN, _G[lootrole]))
		end
	else--Cata
		if (not currentSpecID or currentSpecID == 0) then
			DBM:SetCurrentSpecInfo()
		end
		if currentSpecID and private.specRoleTable[currentSpecID] then
			if private.specRoleTable[currentSpecID]["Healer"] then
				role = "HEALER"
			elseif private.specRoleTable[currentSpecID]["Tank"] then
				role = "TANK"
			else
				role = "DAMAGER"
			end
		else--By some miracle, despite excessive redundancy, it still failed because classic spagetti code.
			role = "DAMAGER"--Set default role (which is what cataclysm does btw, it sets everyone to damager on raid join unless changed by our mod)
		end
	end
	if not InCombatLockdown() and not IsFalling() and ((IsPartyLFG() and (difficulties.difficultyIndex == 14 or difficulties.difficultyIndex == 15)) or not IsPartyLFG()) then
		if UnitGroupRolesAssigned("player") ~= role then
			UnitSetRole("player", role)
		end
	end
end

-- An anti spam function to throttle spammy events (e.g. SPELL_AURA_APPLIED on all group members)
---@param self DBMModOrDBM
---@param time number? time to wait between two events (optional, default 2.5 seconds)
---@param id any? id to distinguish different events (optional, only necessary if your mod keeps track of two different spam events at the same time)
---@param targetName any? string optional extra ID to filter spams per target
function DBM:AntiSpam(time, id, targetName)
	id = id or "(nil)"
	if targetName then
		-- Yes, mods could just piece together an id like this themselves
		-- The actual point of this is tests: targetName may refer to the real player replaying the log due to combat log rewriting and hence needs to be filtered in the report.
		id = id .. " on " .. targetName
	end
	if GetTime() - (self["lastAntiSpam" .. tostring(id)] or -math.huge) > (time or 2.5) then
		self["lastAntiSpam" .. tostring(id)] = GetTime()
		test:Trace(self, "AntiSpam", id, targetName or false, true)
		return true
	end
	test:Trace(self, "AntiSpam", id, targetName or false, false)
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

	---@param self DBMModOrDBM
	function DBM:IconNumToString(number)
		return iconStrings[number] or number
	end

	---@param self DBMModOrDBM
	function DBM:IconNumToTexture(number)
		return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_" .. number .. ".blp:12:12|t" or number
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
	---@param self DBM
	local function checkOptions(self, id, mapID)
		--First, check if this specific cut scene should be blocked at all via the 3 primary rules
		local allowBlock = false
		if self.Options.HideMovieDuringFight and private.IsEncounterInProgress() then
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
	---@param flag SpecFlags
	---@return boolean
	function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		if (not currentSpecID or currentSpecID == 0) then
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

	---@param uId playerUUIDs?
	function bossModPrototype:IsMeleeDps(uId)
		if uId then--This version includes ONLY melee dps
			local name = GetUnitName(uId, true)
			--First we check if we have acccess to specID (ie remote player is using DBM or Bigwigs)
			if (private.isRetail or private.isCata or private.isMop) and raid[name] and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["MeleeDps"]
			else
				--Role checks are second best thing
				local role = UnitGroupRolesAssigned(uId)
				if private.isRetail and (role == "HEALER" or role == "TANK") or GetPartyAssignment("MAINTANK", uId, true) then--Auto filter healer/tank from dps check, can't filter healers in classic
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
					if not private.isRetail and unitMaxPower < 7500 then
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
		if (not currentSpecID or currentSpecID == 0) then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["MeleeDps"]
	end

	---@param self DBMModOrDBM
	---@param uId playerUUIDs?
	function DBM:IsMelee(uId)
		if uId then--This version includes monk healers as melee and tanks as melee
			--Class checks performed first on classes that are absolutely definitive (cause they'll work even if user doesn't have DBM or BW)
			local _, class = UnitClass(uId)
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" or class == "MONK" or class == "DEMONHUNTER" or class == "PALADIN" then
				return true
			end
			--Now we check if we have acccess to specID (ie remote player is using DBM or Bigwigs)
			local name = GetUnitName(uId, true)
			if (private.isRetail or private.isCata or private.isMop) and raid[name] and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["Melee"]
			else
				--Now we do the ugly checks thanks to Inspect throttle
				if (class == "DRUID" or class == "SHAMAN") then
					local unitMaxPower = UnitPowerMax(uId)
					if not private.isRetail and unitMaxPower < 7500 then
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
		if (not currentSpecID or currentSpecID == 0) then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["Melee"]
	end
	bossModPrototype.IsMelee = DBM.IsMelee

	---@param self DBMModOrDBM
	---@param uId playerUUIDs?
	function DBM:IsRanged(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if (private.isRetail or private.isCata or private.isMop) and raid[name] and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["Ranged"]
			else
				self:AddMsg("IsRanged is being called on a player" .. name .. " that doesn't have an available specID. This likely means they are not using DBM or Bigwigs and can hamper functionality of this encounter module")
			end
		end
		--Personal check Only
		if (not currentSpecID or currentSpecID == 0) then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["Ranged"]
	end
	bossModPrototype.IsRanged = DBM.IsRanged

	---@param uId playerUUIDs?
	function bossModPrototype:IsSpellCaster(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if (private.isRetail or private.isCata or private.isMop) and raid[name] and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["SpellCaster"]
			else
				self:AddMsg("IsSpellCaster is being called on a player" .. name .. " that doesn't have an available specID. This likely means they are not using DBM or Bigwigs and can hamper functionality of this encounter module")
			end
		end
		--Personal check Only
		if (not currentSpecID or currentSpecID == 0) then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["SpellCaster"]
	end

	---@param uId playerUUIDs?
	function bossModPrototype:IsMagicDispeller(uId)
		if uId then
			local name = GetUnitName(uId, true)
			if (private.isRetail or private.isCata or private.isMop) and raid[name] and raid[name].specID then--We know their specId
				local specID = raid[name].specID
				return private.specRoleTable[specID]["MagicDispeller"]
			else
				self:AddMsg("IsMagicDispeller is being called on a player" .. name .. " that doesn't have an available specID. This likely means they are not using DBM or Bigwigs and can hamper functionality of this encounter module")
			end
		end
		--Personal check Only
		if (not currentSpecID or currentSpecID == 0) then
			DBM:SetCurrentSpecInfo()
		end
		return private.specRoleTable[currentSpecID]["MagicDispeller"]
	end
end

---@param uId string? Used for querying external unit. If nil, queries "player"
function bossModPrototype:UnitClass(uId)
	if uId then--Return unit requested
		local _, class = UnitClass(uId)
		return class
	end
	return playerClass--else return "player"
end

do
	-- if we catch someone in a tank stance keep sending them warnings, classic only
	local playerIsTank = false

	function bossModPrototype:IsTank()
		--IsTanking already handles external calls, no need here.
		if (not currentSpecID or currentSpecID == 0) then
			DBM:SetCurrentSpecInfo()
		end
		if not private.isRetail and not private.isMop then
			if private.specRoleTable[currentSpecID]["Tank"] then
				-- 17 defensive stance, 5487 bear form, 9634 dire bear, 25780 righteous fury
				if playerIsTank or GetShapeshiftFormID() == 18 or DBM:UnitBuff("player", 5487, 9634) then
					playerIsTank = true
					return true
				end
			end
			return false
		end
		local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
		return role == "TANK"
	end
end

---@param uId playerUUIDs? Used for querying external unit. If nil, queries "player"
---@return boolean
function bossModPrototype:IsDps(uId)
	if uId then--External unit call.
		--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
		return (private.isRetail or private.isMop) and UnitGroupRolesAssigned(uId) == "DAMAGER" or not GetPartyAssignment("MAINTANK", uId, true)
	end
	if (not currentSpecID or currentSpecID == 0) then
		DBM:SetCurrentSpecInfo()
	end
	if not private.isRetail and not private.isMop then
		return private.specRoleTable[currentSpecID]["Dps"]
	end
	local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	return role == "DAMAGER"
end

---@param self DBMModOrDBM
---@param uId playerUUIDs? Used for querying external unit. If nil, queries "player"
---@return boolean
function DBM:IsHealer(uId)
	if uId then--External unit call.
		if not private.isRetail and not private.isMop then
			print("bossModPrototype:IsHealer should not be called in classic, report this message")
			return false
		end
		--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
		return UnitGroupRolesAssigned(uId) == "HEALER"
	end
	if (not currentSpecID or currentSpecID == 0) then
		DBM:SetCurrentSpecInfo()
	end
	if not private.isRetail and not private.isMop then
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

---@param self DBMModOrDBM
---@param playerUnitID playerUUIDs|targetUIDs? unitID of requested unit. this or isName must be provided
---@param enemyUnitID enemyUIDs|targetUIDs? unitID of tanked unit we're checking. This or enemyGUID must be provided
---@param isName string? name of the requested unit. This or playerUnitID must be provided
---@param onlyRequested boolean? true if tight search, false if loose search that will return ALL tank specs
---@param enemyGUID string? guid of tanked unit we're checking. This or enemyUnitID must be provided
---@param includeTarget boolean? set to true to allow bosses target to be good enough if threat check fails
---@param onlyS3 boolean? true for tight threat check (status 3 securly tanked required). loose threat otherwise
---@return boolean
function DBM:IsTanking(playerUnitID, enemyUnitID, isName, onlyRequested, enemyGUID, includeTarget, onlyS3)
	--Didn't have playerUnitID so combat log name was passed
	if isName then
		playerUnitID = DBM:GetRaidUnitId(isName)
	end
	if not playerUnitID then
		DBM:Debug("IsTanking passed with invalid unit", 2)
		return false
	end
	--If we don't know enemy unit token, but know it's GUID
	if not enemyUnitID and enemyGUID then
		enemyUnitID = self:GetUnitIdFromGUID(enemyGUID)
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
		if not private.isClassic and not private.isBCC then--Allow boss checks in wrath and later
			--no SpecID checks because SpecID is only availalbe with DBM/Bigwigs, but both DBM/Bigwigs auto set DAMAGER/HEALER/TANK roles anyways so it'd be redundant
			if UnitGroupRolesAssigned and UnitGroupRolesAssigned(playerUnitID) == "TANK" then
				return true
			end
			if not self:MidRestrictionsActive() then
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
	end
	return false
end
bossModPrototype.IsTanking = DBM.IsTanking

function bossModPrototype:GetNumAliveTanks()
	if not IsInGroup() then return 1 end--Solo raid, you're the "tank"
	local count = 0
	local uId = (IsInRaid() and "raid") or "party"
	for i = 1, DBM:GetNumRealGroupMembers() do
		if (private.isRetail and UnitGroupRolesAssigned(uId .. i) == "TANK" or GetPartyAssignment("MAINTANK", uId .. i, true)) and not UnitIsDeadOrGhost(uId .. i) then
			count = count + 1
		end
	end
	return count
end

----------------------------
--  Boss Health Function  --
----------------------------
do
	local bossNames, bossIcons = {}, {}

	---This accepts both CID and GUID which makes switching to UnitPercentHealthFromGUID and UnitTokenFromGUID not as cut and dry
	---@param self DBMModOrDBM
	---@param cIdOrGUID number|string
	---@param onlyHighest boolean?
	function DBM:GetBossHP(cIdOrGUID, onlyHighest)
		if not self:IsPostMidnight() then
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
				bossIcons[cIdOrGUID] = GetRaidTargetIndex(uId)
				return hp, uId, UnitName(uId)
			--Focus, does not exist in classic
			elseif private.isRetail and ((self:GetCIDFromGUID(UnitGUID("focus")) == cIdOrGUID or UnitGUID("focus") == cIdOrGUID) and UnitHealthMax("focus") ~= 0) then
				if bossHealth[cIdOrGUID] and (UnitHealth("focus") == 0 and not UnitIsDead("focus")) then return bossHealth[cIdOrGUID], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
				if not onlyHighest or onlyHighest and hp > (bossHealth[cIdOrGUID] or 0) then
					bossHealth[cIdOrGUID] = hp
				end
				bossNames[cIdOrGUID] = UnitName("focus")
				bossIcons[cIdOrGUID] = GetRaidTargetIndex("focus")
				return hp, "focus", UnitName("focus")
			else
				--Boss UnitIds
				if private.isRetail then
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
							bossIcons[cIdOrGUID] = GetRaidTargetIndex(unitID)
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
						bossIcons[cIdOrGUID] = GetRaidTargetIndex(unitId)
						return hp, unitId, UnitName(unitId)
					end
				end
				if not private.isRetail then
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
							bossIcons[cIdOrGUID] = GetRaidTargetIndex(unitId)
							return hp, unitId, UnitName(unitId)
						end
					end
				end
			end
		end
	end

	function DBM:GetBossHPByUnitID(uId)
		if not self:IsPostMidnight() then
			if UnitHealthMax(uId) ~= 0 then
				local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
				bossHealth[uId] = hp
				return hp, uId, UnitName(uId)
			end
		end
	end

	function bossModPrototype:SetMainBossID(cid)
		self.mainBoss = cid
	end

	---Used to instruct boss mod to record the health % of highest health boss when multiple bosses
	function bossModPrototype:SetBossHPInfoToHighest(numBoss)
		if numBoss ~= false then
			self.numBoss = numBoss or (self.multiMobPullDetection and #self.multiMobPullDetection)
		end
		self.highesthealth = true
	end

	function bossModPrototype:GetHighestBossHealth()
		if self:IsPostMidnight() then
			return bossHealth[self.combatInfo.mob or -1]
		end
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
		if self:IsPostMidnight() then
			return bossHealth[self.combatInfo.mob or -1]
		end
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
		return bossHealth, bossNames, bossIcons
	end
end


---------------
--  Options  --
---------------
---@param name any Option name must be string, but language server gets confused if it's not set to any
---@param default SpecFlags|boolean?
---@param cat string? category type: ie "timer", "announce", "misc", "sound", etc
---@param func any? Custom function to call when option is changed
---@param extraOption string|number? Used for attached options such as timer color or special warning sound
---@param extraOptionTwo string|number? Used for attached options such as countdown voice or special warning note
---@param spellId any? spellId to group with other options for same spell
---@param optionSubType string? ie "gtfo", "adds", "achievement", "stage", etc
---@param waCustomName string? used to inject custom weak aura spellId key text
function bossModPrototype:AddBoolOption(name, default, cat, func, extraOption, extraOptionTwo, spellId, optionSubType, waCustomName)
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
	if type(default) == "string" then
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
			if optionSubType and optionSubType == "achievement" then
				spellId = "at" .. spellId--"at" for achievement timer
			end
			local optionTypeMatch = optionSubType or ""
			if not optionTypeMatch:find("stage") then
				self:GroupSpells(spellId, name)
			end
		end
	end
	self:SetOptionCategory(name, cat, optionSubType, waCustomName)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

---@param name any
---@param default SpecFlags|boolean?
---@param defaultSound number|string? Can be number for built in spec warn sound 1-4 or string for custom sound path
---@param cat string? category type: ie "timer", "announce", "misc", "sound", etc
---@param spellId any? spellId to group with other options for same spell
---@param optionType string?
---@param waCustomName string? used to inject custom weak aura spellId key text
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
	if type(default) == "string" then
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

---@meta
---@alias paSubTypes
---|0: Generic subtype for generalized use
---|1: Custom subtype for when targetted by the private aura spell
---|2: Custom subtype for when standing in the private aura spell (GTFO)
---@param auraspellId number must match debuff ID so EnablePrivateAuraSound function can call right option key and right debuff ID
---@param default SpecFlags|boolean?
---@param groupSpellId number? is used if a diff option key is used in all other options with spell (will be quite common)
---@param defaultSound acceptedSASounds? is used to set default Special announce sound (1-4) just like regular special announce objects
---@param subType paSubTypes? 0/nil: default, 1: targetted, 2:gtfo
function bossModPrototype:AddPrivateAuraSoundOption(auraspellId, default, groupSpellId, defaultSound, subType)
	self.DefaultOptions["PrivateAuraSound" .. auraspellId] = (default == nil) or default
	self.DefaultOptions["PrivateAuraSound" .. auraspellId .. "SWSound"] = defaultSound or 1
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["PrivateAuraSound" .. auraspellId] = (default == nil) or default
	--LuaLS is just stupid here. There is no rule that says self.Options.Variable has to be a bool. Entire SWSound variable scope is always a number
	---@diagnostic disable-next-line: assign-type-mismatch
	self.Options["PrivateAuraSound" .. auraspellId .. "SWSound"] = defaultSound or 1
	subType = subType or 0
	if subType == 1 then
		self.localization.options["PrivateAuraSound" .. auraspellId] = L.AUTO_PRIVATEAURA_OPTION_TARGET_TEXT:format(auraspellId)
	elseif subType == 2 then
		self.localization.options["PrivateAuraSound" .. auraspellId] = L.AUTO_PRIVATEAURA_OPTION_GTFO_TEXT:format(auraspellId)
	else
		self.localization.options["PrivateAuraSound" .. auraspellId] = L.AUTO_PRIVATEAURA_OPTION_TEXT:format(auraspellId)
	end
--	if not DBM.Options.GroupOptionsExcludePA then
		self:GroupSpellsPA(groupSpellId or auraspellId, "PrivateAuraSound" .. auraspellId)
--	end
	self:SetOptionCategory("PrivateAuraSound" .. auraspellId, "paura", nil, nil, true)
end

---Object for customizing blizzard timeline object with colors and sounds
---@param spellId number SpellID used for option text and saved variables
---@param default SpecFlags|boolean?
---@param defaultColor timerColorType ColorId 1-6 for color bar by type
---@param defaultVoice number? VoiceId for countdown voice
---@param groupSpellId number? is used if a diff option key is used in all other options with spell (will be quite common)
function bossModPrototype:AddCustomTimerOptions(spellId, default, defaultColor, defaultVoice, groupSpellId)
	self.DefaultOptions["CustomTimerOption" .. spellId] = (default == nil) or default
	--Note:, TColor and CVoice are generated in AddBoolOption
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["CustomTimerOption" .. spellId] = (default == nil) or default

	self.localization.options["CustomTimerOption" .. spellId] = L.AUTO_CUSTOMTIMER_OPTION_TEXT:format(spellId)
	self:GroupSpellsPA(groupSpellId or spellId, "CustomTimerOption" .. spellId)
	self:AddBoolOption("CustomTimerOption" .. spellId, default, "timer", nil, defaultColor, defaultVoice, spellId)
end

---Object for cusotmizing blizzard alerts to be shown or what sound plays for them
---@param auraspellId number SpellID used for option text and saved variables
---@param default SpecFlags|boolean?
---@param defaultSound acceptedSASounds is used to set default Special announce sound (1-4) just like regular special announce objects
---@param groupSpellId number? is used if a diff option key is used in all other options with spell (will be quite common)
function bossModPrototype:AddCustomAlertSoundOption(auraspellId, default, defaultSound, groupSpellId)
	self.DefaultOptions["CustomAlertOption" .. auraspellId] = (default == nil) or default
	self.DefaultOptions["CustomAlertOption" .. auraspellId .. "SWSound"] = defaultSound
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["CustomAlertOption" .. auraspellId] = (default == nil) or default
	--LuaLS is just stupid here. There is no rule that says self.Options.Variable has to be a bool. Entire SWSound variable scope is always a number
	---@diagnostic disable-next-line: assign-type-mismatch
	self.Options["CustomAlertOption" .. auraspellId .. "SWSound"] = defaultSound or 1
	self.localization.options["CustomAlertOption" .. auraspellId] = L.AUTO_CUSTOMALERT_OPTION_TEXT:format(auraspellId)
	self:GroupSpellsPA(groupSpellId or auraspellId, "CustomAlertOption" .. auraspellId)
	self:SetOptionCategory("CustomAlertOption" .. auraspellId, "paura")
end

---@meta
---@alias iconTypes
---|0: Player icon using no sorting. Most common in boss mods
---|1: Player icon using melee > ranged with alphabetical sorting on multiple melee
---|2: Player icon using melee > ranged with raid roster index sorting on multiple melee
---|3: Player icon using ranged > melee with alphabetical sorting on multiple ranged
---|4: Player icon using ranged > melee with raid roster index sorting on multiple ranged
---|5: NPC icon using feature that chooses ideal setter. Always use 5 for NPCS
---|6: Player icon using only alphabetical sorting
---|7: Player icon using only raid roster index sorting
---|8: Player icon using tank > non tank with alphabetical sorting on multiple melee
---|9: Player icon using tank > non tank with raid roster index sorting on multiple melee
---|10: Player icon using melee > ranged > healer
---|11: Player icon using tank > dps > healer
---@param default SpecFlags|boolean?
---@param iconType iconTypes?
---@param iconsUsed table? table defining used icons such as {1, 2, 3}
---@param conflictWarning boolean? set to true if this mod has 2 or more icon options that use the same icons
function bossModPrototype:AddSetIconOption(name, spellId, default, iconType, iconsUsed, conflictWarning, groupSpellId)
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if (groupSpellId or spellId) and not DBM.Options.GroupOptionsExcludeIcon then
		self:GroupSpells(groupSpellId or spellId, name)
	end
	self:SetOptionCategory(name, "icon")
	--Legacy notice about outdated bool and nil support
	--Will be removed before TWW
	iconType = iconType or 0
	if type(iconType) ~= "number" then
		error("DBM iconType must be a number. If you are seeing this error your content mods are probabably out of date")
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
	elseif iconType == 10 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_MRH:format(spellId) or self.localization.options[name]
	elseif iconType == 11 then
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS_TOH:format(spellId) or self.localization.options[name]
	else--Type 0 (Generic for targets)
		self.localization.options[name] = spellId and L.AUTO_ICONS_OPTION_TARGETS:format(spellId) or self.localization.options[name]
	end
	--A table defining used icons by number, insert icon textures to end of option
	if iconsUsed then
		self.localization.options[name] = self.localization.options[name] .. " ("
		for i = 1, #iconsUsed do
			--Texture ID 137009 if direct calling RaidTargetingIcons stops working one day
			---
			if 		iconsUsed[i] == 1 then		self.localization.options[name] = self.localization.options[name] .. CL.STAR_ICON_SMALL
			elseif	iconsUsed[i] == 2 then		self.localization.options[name] = self.localization.options[name] .. CL.CIRCLE_ICON_SMALL
			elseif	iconsUsed[i] == 3 then		self.localization.options[name] = self.localization.options[name] .. CL.DIAMOND_ICON_SMALL
			elseif	iconsUsed[i] == 4 then		self.localization.options[name] = self.localization.options[name] .. CL.TRIANGLE_ICON_SMALL
			elseif	iconsUsed[i] == 5 then		self.localization.options[name] = self.localization.options[name] .. CL.MOON_ICON_SMALL
			elseif	iconsUsed[i] == 6 then		self.localization.options[name] = self.localization.options[name] .. CL.SQUARE_ICON_SMALL
			elseif	iconsUsed[i] == 7 then		self.localization.options[name] = self.localization.options[name] .. CL.CROSS_ICON_SMALL
			elseif	iconsUsed[i] == 8 then		self.localization.options[name] = self.localization.options[name] .. CL.SKULL_ICON_SMALL
			end
		end
		self.localization.options[name] = self.localization.options[name] .. ")"
		if conflictWarning then
			self.localization.options[name] = self.localization.options[name] .. L.AUTO_ICONS_OPTION_CONFLICT
		end
	end
end

---Still used for situations we may use static arrows to point for a specific way to move. Legacy arrows also supported toward/away from specific player units
---@meta
---@alias arrowTypes
---|1: Shows an arrow pointing toward player target
---|2: Shows an arrow pointing away from player target
---|3: Shows an arrow pointing toward specific location
---@param name string Option name
---@param spellId number if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
---@param isRunTo arrowTypes|number
function bossModPrototype:AddArrowOption(name, spellId, default, isRunTo)
	if isRunTo == true then isRunTo = 2 end--Support legacy
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
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

---Legacy object at this point. Range checks aren't added to new modules due to no longer being usable inside raids. they should NOT be removed from old modules in event blizzard ever adds built in functionality we can automate
---@param range number|string Non optional, should be number if fixed ranged or string with custom string such as "various" or "10/6"
---@param spellId number? if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
function bossModPrototype:AddRangeFrameOption(range, spellId, default)
	self.DefaultOptions["RangeFrame"] = (default == nil) or default
	if type(default) == "string" then
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

---Legacy object at this point. HUD checks aren't added to new modules due to no longer being usable inside raids.
---@param name string Option name
---@param spellId number? if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
function bossModPrototype:AddHudMapOption(name, spellId, default)
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
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

---@param name string Option name
---@param spellId number if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
---@param forceDBM boolean? Used in very rare cases we need to use nameplate feature without a clean place to use enable/disable callbacks for 3rd party NP addons
function bossModPrototype:AddNamePlateOption(name, spellId, default, forceDBM)
	if not spellId then
		error("AddNamePlateOption must provide valid spellId", 2)
	end
	self.DefaultOptions[name] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:GroupSpells(spellId, name)
	self:SetOptionCategory(name, "nameplate")
	self.localization.options[name] = forceDBM and L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED:format(spellId) or L.AUTO_NAMEPLATE_OPTION_TEXT:format(spellId)
end

---@param spellId number? if used, auto localizes using spell or journal id. if left blank uses generic description
---@param default SpecFlags|boolean?
function bossModPrototype:AddInfoFrameOption(spellId, default, optionVersion, optionalThreshold)
	local oVersion = ""
	if optionVersion then
		oVersion = tostring(optionVersion)
	end
	self.DefaultOptions["InfoFrame" .. oVersion] = (default == nil) or default
	if type(default) == "string" then
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


---@meta
---@alias gossipTypes
---|"Action": Auto select gossip choice(s) to perform actions (such as using transports)
---|"Encounter": Auto select gossip choice to start encounter
---|"Buff": Auto select gossip choice(s) for npc or profession buffs
---@param default SpecFlags|boolean?
---@param gossipType gossipTypes|string
function bossModPrototype:AddGossipOption(default, gossipType, optionVersion)
	local oVersion = ""
	if optionVersion then
		oVersion = tostring(optionVersion)
	end
	self.DefaultOptions["AutoGossip" .. gossipType .. oVersion] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["AutoGossip" .. gossipType .. oVersion] = (default == nil) or default
	if gossipType == "Action" then
		self.localization.options["AutoGossip" .. gossipType .. oVersion] = L.AUTO_GOSSIP_PERFORM_ACTION
	elseif gossipType == "Encounter" then
		self.localization.options["AutoGossip" .. gossipType .. oVersion] = L.AUTO_GOSSIP_START_ENCOUNTER
	else--Buff
		self.localization.options["AutoGossip" .. gossipType .. oVersion] = L.AUTO_GOSSIP_BUFFS
	end
	self:SetOptionCategory("AutoGossip" .. gossipType .. oVersion, "misc")
end

---@param default SpecFlags|boolean?
---@param maxLevel number? set max level if you want to disable this readycheck from firing at a certain point
function bossModPrototype:AddReadyCheckOption(questId, default, maxLevel)
	self.readyCheckQuestId = questId
	self.readyCheckMaxLevel = maxLevel or 999
	self.DefaultOptions["ReadyCheck"] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["ReadyCheck"] = (default == nil) or default
	self.localization.options["ReadyCheck"] = L.AUTO_READY_CHECK_OPTION_TEXT
	self:SetOptionCategory("ReadyCheck", "misc")
end

---@param name string Option Name
---@param default SpecFlags|boolean?
function bossModPrototype:AddSpeedClearOption(name, default)
	self.DefaultOptions["SpeedClearTimer"] = (default == nil) or default
	if type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["SpeedClearTimer"] = (default == nil) or default
	self:SetOptionCategory("SpeedClearTimer", "timer")
	self.localization.options["SpeedClearTimer"] = L.AUTO_SPEEDCLEAR_OPTION_TEXT:format(name)
end

-- FIXME: this function does not reset any settings to default if you remove an option in a later revision and a user has selected this option in an earlier revision were it still was available
-- this will be fixed as soon as it is necessary due to removed options ;-)
---@param name string Option Name
---@param options table Options table
---@param default any Which table entry is default
---@param cat string? Option Category. If left blank, defaults to "misc"
---@param func any?
---@param spellId number? spellId used for option category grouping
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

---This function, which will be called after all iterations of GroupWASpells/GroupSpells will just straight up say "ok now ignore keys these made and just use custom ones" for extremely niche cases
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

---Custom function for handling group spells where we want to group by ID, but not use that IDs name (basically a fake Id for purpose of a unified WA key)
---This lets us group options up that aren't using valid IDs, and show the ID it is using for WA in the gui next to custom name
---@param customName string? Used to inject custom weak aura spellId key text
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

---Duplicate function just for private auras to do literally same thing as GroupSpells without ability to pass extra arg
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

---@param name any
---@param cat string category type: ie "timer", "announce", "misc", "sound", etc
---@param optionSubType string? ie "gtfo", "adds", "achievement", "stage", etc
---@param waCustomName string? used to inject custom weak aura spellId key text
---@param hasPrivate boolean? used to mark option as private aura option so it displays PA icon in GUI
function bossModPrototype:SetOptionCategory(name, cat, optionSubType, waCustomName, hasPrivate)
	optionSubType = optionSubType or ""
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if self.addon and self.groupSpells[name] and not (optionSubType == "gtfo" or optionSubType == "adds" or optionSubType == "addscount" or optionSubType == "addscustom" or optionSubType:find("stage") or cat == "icon" and DBM.Options.GroupOptionsExcludeIcon) then--or cat == "paura" and DBM.Options.GroupOptionsExcludePA
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
---@meta
---@alias combatTypes
---|"combat": Default Option. Triggers Combat on ENCOUNTER_START, INSTANCE_ENCOUNTER_ENGAGE_UNIT, UNIT_HEALTH, PLAYER_REGEN_DISABLED
---|"yell": Triggers Combat on CHAT_MSG_MONSTER_YELL
---|"say": Triggers Combat on CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY
---|"emote": Triggers Combat on CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE
---|"yell_regex": Triggers Combat on CHAT_MSG_MONSTER_YELL using regex matching
---|"say_regex": Triggers Combat on CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY using regex matching
---|"emote_regex": Triggers Combat on CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE using regex matching
---|"combat_yell": Same as combat, but also uses CHAT_MSG_MONSTER_YELL exact matching
---|"combat_say": Same as combat, but also uses CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY exact matching
---|"combat_emote": Same as combat, but also uses CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE exact matching
---|"combat_yellfind": Same as combat, but also uses CHAT_MSG_MONSTER_YELL loose matching
---|"combat_sayfind": Same as combat, but also uses CHAT_MSG_SAY or CHAT_MSG_MONSTER_SAY loose matching
---|"combat_emotefind": Same as combat, but also uses CHAT_MSG_EMOTE or CHAT_MSG_MONSTER_EMOTE loose matching
---|"scenario": Tells mod to treat an entire scenario as combat
---@param cType combatTypes
function bossModPrototype:RegisterCombat(cType, ...)
	if cType then
		cType = cType:lower()
	end
	---@class CombatInfo
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
	if self.DisableInTimewalking then
		info.DisableInTimewalking = self.DisableInTimewalking
	end
	if self.RequiresTimewalking then
		info.RequiresTimewalking = self.RequiresTimewalking
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

---Needs to be called _AFTER_ RegisterCombat
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
		---@class CombatInfo
		local combatInfo = self.combatInfo
		combatInfo.killType = msgType
		combatInfo.killMsgs = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			combatInfo.killMsgs[v] = true
		end
	end
end

function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	---@class CombatInfo
	local combatInfo = self.combatInfo
	combatInfo.noCombatInVehicle = not flag
end

---Used to set creature IDs this mod will scan for Boss Health and legacy or backup combat detection methods
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
	else
		self.numBoss = 1
		if self.combatInfo then
			--Called mid combat, update combatinfo mob for boss health and win detection
			self.combatInfo.mob = self.creatureId
		end
	end
	for i = 1, select("#", ...) do
		local cId = select(i, ...)
		if bossIds[cId] then
			DBM:Debug("Duplicate mods for cId " .. cId .. ": " .. self.id .. ", " .. bossIds[cId].id)
		end
		bossIds[cId] = self
	end
end

---Used to set Encounter IDs this mod will pass to ENCOUNTER_START/ENCOUNTER_END/BOSS_KILL
function bossModPrototype:SetEncounterID(...)
	self.encounterId = ...
	if select("#", ...) > 1 then
		self.multiEncounterPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiEncounterPullDetection = self.multiEncounterPullDetection
		end
	end
	if self.localization.general.name == self.id then
		self.localization.general.name = DBM:GetGeneratedLocales("encounter")[...] or self.localization.general.name
	end
end

---Used to disable ENCOUNTER_START from detecting boss combat
function bossModPrototype:DisableESCombatDetection()
	self.noESDetection = true
	if self.combatInfo then
		self.combatInfo.noESDetection = true
	end
end

---Used to disable ENCOUNTER_END for kill detection
function bossModPrototype:DisableEEKillDetection()
	self.noEEDetection = true
	if self.combatInfo then
		self.combatInfo.noEEDetection = true
	end
end

---Used to disable BOSS_KILL for kill detection
function bossModPrototype:DisableBKKillDetection()
	self.noBKDetection = true
	if self.combatInfo then
		self.combatInfo.noBKDetection = true
	end
end

---Used to disable INSTANCE_ENCOUNTER_ENGAGE_UNIT from detecting boss combat
function bossModPrototype:DisableIEEUCombatDetection()
	self.noIEEUDetection = true
	if self.combatInfo then
		self.combatInfo.noIEEUDetection = true
	end
end

---Used to prevent engaging a boss that's friendly
function bossModPrototype:DisableFriendlyDetection()
	self.noFriendlyEngagement = true
	if self.combatInfo then
		self.combatInfo.noFriendlyEngagement = true
	end
end

---Used to disable using PLAYER_REGEN_DISABLED from detecting boss combat
function bossModPrototype:DisableRegenDetection()
	self.noRegenDetection = true
	if self.combatInfo then
		self.combatInfo.noRegenDetection = true
	end
end

---Used to disable timewalking bosses in non timewalking dungeons that have different variants of same with same ID, in same instance
function bossModPrototype:DisableInTimeWalking()
	self.DisableInTimewalking = true
	if self.combatInfo then
		self.combatInfo.DisableInTimewalking = true
	end
end

---Used to disable non timewalking bosses in timewalking dungeons that have different variants of same with same ID, in same instance
function bossModPrototype:RequiresTimeWalking()
	self.RequiresTimewalking = true
	if self.combatInfo then
		self.combatInfo.RequiresTimewalking = true
	end
end

function bossModPrototype:DisableMultiBossPulls()
	self.noMultiBoss = true
	if self.combatInfo then
		self.combatInfo.noMultiBoss = true
	end
end

---Used to permit mod from sending syncs for world bosses.
function bossModPrototype:EnableWBEngageSync()
	self.WBEsync = true
	if self.combatInfo then
		self.combatInfo.WBEsync = true
	end
end

---Used when a bosses death condition should be ignored (maybe they die repeatedly for example)
function bossModPrototype:DisableBossDeathKill()
	self.noBossDeathKill = true
	if self.combatInfo then
		self.combatInfo.noBossDeathKill = true
	end
end

---Used when a boss is scripted in a hacky way that their creature Id changes mid fight, and we want to treat multiple IDs as a single boss
function bossModPrototype:SetMultiIDSingleBoss()
	self.multiIDSingleBoss = true
end

---Used for knowing if a specific mod is engaged
function bossModPrototype:IsInCombat()
	return self.inCombat
end

---Used for checking if any person in group is in any kind of combat
---@param self DBMModOrDBM
function DBM:GroupInCombat()
	local combatFound = false
	--Any Boss engaged
	if private.IsEncounterInProgress() then
		combatFound = true
	end
	--Self in Combat
	if InCombatLockdown() or UnitAffectingCombat("player") then
		combatFound = true
	end
	--Any Other group member in combat
	if not combatFound then
		for uId in DBM:GetGroupMembers() do
			if UnitAffectingCombat(uId) then
				combatFound = true
				break
			end
		end
	end
	return combatFound
end
bossModPrototype.GroupInCombat = DBM.GroupInCombat

function bossModPrototype:IsAlive()
	return not UnitIsDeadOrGhost("player")
end

---Sets minimum amount of time before a pull is concidered valid.
---@param t number
function bossModPrototype:SetMinCombatTime(t)
	self.minCombatTime = t
end

---Needs to be called after RegisterCombat
---<br>Sets time out of combat required before a module should declare a wipe
---@param t number
function bossModPrototype:SetWipeTime(t)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	---@class CombatInfo
	local combatInfo = self.combatInfo
	combatInfo.wipeTimer = t
end

---Used to specify amount of time before allowing a boss to be pulled again.
---@param t number? used to specify recombat time after a kill.
---@param t2 number? used to specify recombat time after a wipe
function bossModPrototype:SetReCombatTime(t, t2)
	self.reCombatTime = t
	self.reCombatTime2 = t2
end

function bossModPrototype:SetOOCBWComms()
	tinsert(oocBWComms, self)
end

-----------------------
--  Synchronization  --
-----------------------
do
	---@param self DBMMod
	local function prepareSync(self, event, ...)
		event = event or ""
		local arg = select("#", ...) > 0 and strjoin("\t", tostringall(...)) or ""
		local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision or 0, event, arg)
		local spamId = self.id .. event .. arg -- *not* the same as the sync string, as it doesn't use the revision information
		local time = GetTime()
		--Mod syncs are more strict and enforce latency threshold always.
		--Do not put latency check in main sendSync local function (line 313) though as we still want to get version information, etc from these users.
		if not private.modSyncSpam[spamId] or (time - private.modSyncSpam[spamId]) > 8 then
			self:ReceiveSync(event, playerName, self.revision or 0, tostringall(...))
			sendSync(DBMSyncProtocol, "M", str, "ALERT")
		end
	end

	---Send boss mod communication
	---@param event string
	---@param ... any
	function bossModPrototype:SendSync(event, ...)
		prepareSync(self, event, ...)
	end

	---Variant of SendSync used to prevent comms spam
	---@param throttle number
	---@param event string
	---@param ... any
	function bossModPrototype:SendThrottledSync(throttle, event, ...)
		if self:AntiSpam(throttle, "SyncSpam"..event) then
			prepareSync(self, event, ...)
		end
	end
end

---This is not to be confused with a sendBWSync. It's specifically for bigwigs boss syncs (using their "B" prefix)
function bossModPrototype:SendBigWigsSync(msg, extra)
	if not dbmIsEnabled or IsTrialAccount() then return end
	--msg = "B^" .. msg
	if extra then
		msg = msg .. "^" .. extra
	end
	if IsInGroup() then
		sendBWSync("B", msg, IsInGroup(2) and "INSTANCE_CHAT" or "RAID", "ALERT")
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

---@param revision number|string Either a number in the format "202101010000" (year, month, day, hour, minute) or string "@file-date-integer@" to be auto set by packager
function bossModPrototype:SetRevision(revision)
	revision = parseCurseDate(revision or "")
	if not revision or type(revision) == "string" then
		-- bad revision: either forgot the svn keyword or using github
		revision = DBM.Revision
	end
	self.revision = revision
end

---Will block boss mod communication from other users if their revision older than defined revision
---<br> string revisions are date integer format (new), number revisions are legacy revisions (that should be updated)
function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

---Used for chat message that specific module is out of date and has key fixes
function bossModPrototype:SetHotfixNoticeRev(revision)
	self.hotfixNoticeRev = (type(revision or "") == "number") and revision or parseCurseDate(revision)
end

-------------
--  Icons  --
-------------
do
	---@param mod DBMMod
	function DBM:ElectIconSetter(mod)
		--elect icon person
		if mod.findFastestComputer and not self.Options.DontSetIcons then
			if mod:IsDungeon() or self:GetRaidRank() > 0 then
				for i = 1, #mod.findFastestComputer do
					local option = mod.findFastestComputer[i]
					if mod.Options[option] then
						sendSync(DBMSyncProtocol, "IS", UnitGUID("player") .. "\t" .. tostring(self.Revision) .. "\t" .. option, "NORMAL")
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
end

-- Expose some file-local data to private for testing purposes only.

--[[
test:RegisterLocalHook("LastInstanceMapID", function(val)
	local old = LastInstanceMapID
	LastInstanceMapID = val
	return old
end)

test:RegisterLocalHook("GetTime", function(val)
	local old = GetTime
	GetTime = val
	return old
end)

test:RegisterLocalHook("UnitDetailedThreatSituation", function(val)
	local old = UnitDetailedThreatSituation
	UnitDetailedThreatSituation = val
	return old
end)

test:RegisterLocalHook("UnitAffectingCombat", function(val)
	local old = UnitAffectingCombat
	UnitAffectingCombat = val
	return old
end)

test:RegisterLocalHook("UnitGUID", function(val)
	local old = UnitGUID
	UnitGUID = val
	return old
end)

private.mainFrame = mainFrame
--]]
