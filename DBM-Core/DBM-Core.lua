-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- **        https://www.patreon.com/deadlybossmods       **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author & DBM maintainer)
--
-- The localizations are written by:
--    * enGB/enUS: Omegal				Twitter @MysticalOS
--    * deDE: Ebmor						http://www.deadlybossmods.com/forum/memberlist.php?mode=viewprofile&u=79
--    * ruRU: TOM_RUS					http://www.curseforge.com/profiles/TOM_RUS/
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
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). (A link to http://www.deadlybossmods.com is sufficient)
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--

local L = DBM_CORE_L

-------------------------------
--  Globals/Default Options  --
-------------------------------
local function releaseDate(year, month, day, hour, minute, second)
	hour = hour or 0
	minute = minute or 0
	second = second or 0
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
		return year.."/"..month.."/"..day.." "..hour..":"..minute..":"..second
	end
end

DBM = {
	Revision = parseCurseDate("@project-date-integer@"),
	DisplayVersion = "9.0.12 alpha", -- the string that is shown as version
	ReleaseRevision = releaseDate(2020, 12, 17) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
}
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

local wowVersionString, wowBuild, _, wowTOC = GetBuildInfo()
local testBuild = false
if IsTestBuild() then
	testBuild = true
end

function DBM:GetTOC()
	return wowTOC, testBuild, wowVersionString, wowBuild
end

function DBM:IsShadowlands()
	return self:GetTOC() >= 90001 -- 9.0.x
end

-- dual profile setup
local _, playerClass = UnitClass("player")
DBM_UseDualProfile = true
if playerClass == "MAGE" or playerClass == "WARLOCK" or playerClass == "ROGUE" then
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
	RaidWarningSound = 11742,--"Sound\\Doodad\\BellTollNightElf.ogg"
	SpecialWarningSound = 8174,--"Sound\\Spells\\PVPFlagTaken.ogg"
	SpecialWarningSound2 = 15391,--"Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg"
	SpecialWarningSound3 = "Interface\\AddOns\\DBM-Core\\sounds\\AirHorn.ogg",
	SpecialWarningSound4 = 9278,--"Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg"
	SpecialWarningSound5 = 128466,--"Sound\\Creature\\Loathstare\\Loa_Naxx_Aggro02.ogg"
	ModelSoundValue = "Short",
	CountdownVoice = "Corsica",
	CountdownVoice2 = "Kolt",
	CountdownVoice3 = "Smooth",
	ChosenVoicePack = "None",
	VoiceOverSpecW2 = "DefaultOnly",
	AlwaysPlayVoice = false,
	EventSoundVictory2 = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg",
	EventSoundWipe = "None",
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
	HideBossEmoteFrame2 = true,
	SWarningAlphabetical = true,
	SWarnNameInNote = true,
	CustomSounds = 0,
	ShowBigBrotherOnCombatStart = false,
	FilterTankSpec = true,
	FilterInterrupt2 = "TandFandBossCooldown",
	FilterInterruptNoteName = false,
	FilterDispel = true,
	FilterTrashWarnings2 = true,
	FilterVoidFormSay = true,
	--FilterSelfHud = true,
	AutologBosses = false,
	AdvancedAutologBosses = false,
	RecordOnlyBosses = false,
	LogOnlyNonTrivial = true,
	UseSoundChannel = "Master",
	LFDEnhance = true,
	WorldBossNearAlert = false,
	RLReadyCheckSound = true,
	AFKHealthWarning = false,
	AutoReplySound = true,
	HideObjectivesFrame = true,
	HideGarrisonToasts = true,
	HideGuildChallengeUpdates = true,
	HideTooltips = false,
	DisableSFX = false,
	EnableModels = true,
	GUIWidth = 800,
	GUIHeight = 600,
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
	SpecialWarningFlashDura1 = 0.4,
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
	SWarnClassColor = true,
	ArrowPosX = 0,
	ArrowPosY = -150,
	ArrowPoint = "TOP",
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontShowTargetAnnouncements = true,
	DontShowSpecialWarningText = false,
	DontShowSpecialWarningFlash = false,
	DontPlaySpecialWarningSound = false,
	DontPlayTrivialSpecialWarningSound = true,
	DontShowBossTimers = false,
	DontShowUserTimers = false,
	DontShowFarWarnings = true,
	DontSetIcons = false,
	DontRestoreIcons = false,
	DontShowRangeFrame = false,
	DontRestoreRange = false,
	DontShowInfoFrame = false,
	DontShowHudMap2 = false,
	DontShowNameplateIcons = false,
	UseNameplateHandoff = true,
	NPAuraSize = 40,
	DontPlayCountdowns = false,
	DontSendYells = false,
	BlockNoteShare = false,
	DontShowPT2 = false,
	DontShowPTCountdownText = false,
	DontPlayPTCountdown = false,
	DontShowPTText = false,
	DontShowPTNoID = false,
	PTCountThreshold2 = 5,
	LatencyThreshold = 250,
	BigBrotherAnnounceToRaid = false,
	SettingsMessageShown = false,
	ForumsMessageShown = false,
	AlwaysShowSpeedKillTimer2 = false,
	ShowRespawn = true,
	ShowQueuePop = true,
	HelpMessageVersion = 3,
	MoviesSeen = {},
	MovieFilter2 = "OnlyFight",
	LastRevision = 0,
	DebugMode = false,
	DebugLevel = 1,
	RoleSpecAlert = true,
	CheckGear = true,
	WorldBossAlert = false,
	BadTimerAlert = false,
	BadIDAlert = false,
	AutoAcceptFriendInvite = false,
	AutoAcceptGuildInvite = false,
	FakeBWVersion = false,
	AITimer = true,
	ShortTimerText = true,
	ChatFrame = "DEFAULT_CHAT_FRAME",
	CoreSavedRevision = 1,
	SilentMode = false,
}

DBM.Bars = DBT:New()
DBM.Mods = {}
DBM.ModLists = {}
DBM.Counts = {
	{	text	= "Corsica",value 	= "Corsica", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica\\", max = 10},
	{	text	= "Koltrane",value 	= "Kolt", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Kolt\\", max = 10},
	{	text	= "Smooth",value 	= "Smooth", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Smooth\\", max = 10},
	{	text	= "Smooth (Reverb)",value 	= "SmoothR", path = "Interface\\AddOns\\DBM-Core\\Sounds\\SmoothReverb\\", max = 10},
	{	text	= "Pewsey",value 	= "Pewsey", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Pewsey\\", max = 10},
	{	text	= "Bear (Child)",value = "Bear", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Bear\\", max = 10},
	{	text	= "Moshne",	value 	= "Mosh", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\", max = 5},
	{	text	= "Anshlun (ptBR)",value = "Anshlun", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Anshlun\\", max = 10},
	{	text	= "Neryssa (ptBR)",value = "Neryssa", path = "Interface\\AddOns\\DBM-Core\\Sounds\\Neryssa\\", max = 10},
}
--Sounds use SoundKit Ids (not file data ids)
DBM.Victory = {
	{text = L.NONE,value  = "None"},
	{text = L.RANDOM,value  = "Random"},
	{text = "Blakbyrd: FF Fanfare",value = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\bbvictory.ogg", length=4},
	{text = "SMG: FF Fanfare",value = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg", length=4},
}
DBM.Defeat = {
	{text = L.NONE,value  = "None"},
	{text = L.RANDOM,value  = "Random"},
	{text = "Alizabal: Incompetent Raiders",value = 25780, length=4},--"Sound\\Creature\\ALIZABAL\\VO_BH_ALIZABAL_RESET_01.ogg"
	{text = "Bwonsamdi: Over Your Head",value = 109293, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_35_m.ogg"
	{text = "Bwonsamdi: Pour Little Thing",value = 109295, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_37_m.ogg"
	{text = "Bwonsamdi: Impressive Death",value = 109296, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_38_m.ogg"
	{text = "Bwonsamdi: All That Armor",value = 109308, length=4},--"Sound\\Creature\\bwonsamdi\\vo_801_bwonsamdi_50_m.ogg"
	{text = "Kologarn: You Fail",value = 15588, length=4},--"Sound\\Creature\\Kologarn\\UR_Kologarn_Slay02.ogg"
	{text = "Hodir: Tragic",value = 15553, length=4},--"Sound\\Creature\\Hodir\\UR_Hodir_Slay01.ogg"
	{text = "Scrollsage Nola: Cycle",value = 109069, length=4},--"sound/creature/scrollsage_nola/vo_801_scrollsage_nola_34_f.ogg"
	{text = "Thorim: Failures",value = 15742, length=4},--"Sound\\Creature\\Thorim\\UR_Thorim_P1Wipe01.ogg"
	{text = "Valithria: Failures",value = 17067, length=4},--"Sound\\Creature\\ValithriaDreamwalker\\IC_Valithria_Berserk01.ogg"
	{text = "Yogg-Saron: Laugh",value = 15757, length=4},--"Sound\\Creature\\YoggSaron\\UR_YoggSaron_Slay01.ogg"
}
DBM.DungeonMusic = {--Filtered list of media assigned to dungeon/raid background music catagory
	{text = L.NONE,value  = "None"},
	{text = L.RANDOM,value  = "Random"},
	{text = "Anduin Part 1 B",value = 1417242, length=140},--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
	{text = "Nightsong",value = 441705, length=160},--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
	{text = "Ulduar: Titan Orchestra",value = 298910, length=102},--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
}
DBM.BattleMusic = {--Filtered list of media assigned to boss/encounter background music catagory
	{text = L.NONE,value  = "None"},
	{text = L.RANDOM,value  = "Random"},
	{text = "Anduin Part 2 B",value = 1417248, length=111},--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
	{text = "Bronze Jam",value = 350021, length=116},--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
	{text = "Invincible",value = 1100052, length=197},--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
}
--Music uses file data IDs
DBM.Music = {--Contains all music media, period
	{text = L.NONE,value  = "None"},
	{text = L.RANDOM,value  = "Random"},
	{text = "Anduin Part 1 B",value = 1417242, length=140},--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
	{text = "Anduin Part 2 B",value = 1417248, length=111},--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
	{text = "Bronze Jam",value = 350021, length=116},--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
	{text = "Invincible",value = 1100052, length=197},--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
	{text = "Nightsong",value = 441705, length=160},--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
	{text = "Ulduar: Titan Orchestra",value = 298910, length=102},--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
}

------------------------
-- Global Identifiers --
------------------------
DBM_DISABLE_ZONE_DETECTION = newproxy(false)
DBM_OPTION_SPACER = newproxy(false)

--------------
--  Locals  --
--------------
local bossModPrototype = {}
local usedProfile = "Default"
local dbmIsEnabled = true
local lastCombatStarted = GetTime()
local loadcIds = {}
local inCombat = {}
DBM.oocBWComms = {}
DBM.combatInfo = {}
DBM.bossIds = {}
DBM.updateFunctions = {}
local raid = {}
DBM.modSyncSpam = {}
local autoRespondSpam = {}
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<DBM> "
--local ver = ("%s (%s)"):format(DBM.DisplayVersion, tostring(DBM.Revision))
local mainFrame = CreateFrame("Frame", "DBMMainFrame")
local newerVersionPerson = {}
local newerRevisionPerson = {}
local combatInitialized = false
local healthCombatInitialized = false
local pformat
local schedulerFrame = CreateFrame("Frame", "DBMScheduler")
schedulerFrame:Hide()
local schedule
local unschedule
local unscheduleAll
local loadOptions
local checkWipe
local checkBossHealth
local checkCustomBossHealth
local fireEvent
local playerName = UnitName("player")
local playerLevel = UnitLevel("player")
local playerRealm = GetRealmName()
local LastInstanceMapID = -1
local LastGroupSize = 0
local LastInstanceType
local queuedBattlefield = {}
local watchFrameRestore = false
DBM.bossHealth = {}
DBM.bossHealthuIdCache = {}
DBM.bossuIdCache = {}
local difficultyText, difficultyIndex, difficultyModifier = nil, nil, 0
local lastBossEngage = {}
local lastBossDefeat = {}
local bossuIdFound = false
local timerRequestInProgress = false
local updateNotificationDisplayed = 0
local showConstantReminder = 0
local currentSpecName, currentSpecGroup
local cSyncSender = {}
local cSyncReceived = 0
local eeSyncSender = {}
local eeSyncReceived = 0
DBM.canSetIcons = {}
local iconSetRevision = {}
local iconSetPerson = {}
DBM.addsGUIDs = {}
local targetEventsRegistered = false
DBM.targetMonitor = {}
local statusWhisperDisabled = false
local statusGuildDisabled = false
local dbmToc = 0
local breakTimerStart
local AddMsg
local delayedFunction
local dataBroker
DBM.voiceSessionDisabled = false
local handleSync

local fakeBWVersion, fakeBWHash = 194, "4562dcf"--194.1
local bwVersionResponseString = "V^%d^%s"
DBM.enableIcons = true -- set to false when a raid leader or a promoted player has a newer version of DBM

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod or discontinued). These mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM-Battlegrounds", --replaced by DBM-PvP
	-- ZG and ZA are now part of the party mods for Cataclysm
	"DBM-ZulAman",--Remove restriction in classic wow but add load conditions to not load on live
	"DBM-ZG",--Remove restriction in classic wow but add load conditions to not load on live
	"DBM-SiegeOfOrgrimmar",--Block legacy version. New version is "DBM-SiegeOfOrgrimmarV2"
	"DBM-HighMail",
	"DBM-ProvingGrounds-MoP",--Renamed to DBM-ProvingGrounds in 6.0 version since blizzard updated content for WoD
	"DBM-ProvingGrounds",--Renamed to DBM-Challenges going forward to include proving grounds and any new single player challendges of similar design such as mage tower artifact quests
	"DBM-VPKiwiBeta",--Renamed to DBM-VPKiwi in final version.
	"DBM-Suramar",--Renamed to DBM-Nighthold
	"DBM-KulTiras",--Merged to DBM-BfA
	"DBM-Zandalar",--Merged to DBM-BfA
	"DBM-Azeroth",--Merged into DBM-Core events mod.
	"DBM-Argus",--Merged into DBM-BrokenIsles mod
	"DBM-GarrisonInvasions",--Merged into DBM-Draenor mod
	"DBM-Azeroth-BfA",--renamed to DBM-BfA
}

--[InstanceID]={level,zoneType}
--zoneType: 1 = outdoor, 2 = dungeon, 3 = raid
local instanceDifficultyBylevel = {
	--World
	[0]={50,1},[1]={50, 1},--Eastern Kingdoms and Azeroth world events. These would be warfront and aniversery world bosses, so they'd be set to 50 for now. Likely 60 next year
	[530]={30, 1},--Outlands World Bosses
	[870]={30, 1},[1064]={30, 1},--MoP World Bosses
	[1116]={40, 1},[1159]={40, 1},[1331]={40, 1},[1158]={40, 1},[1153]={40, 1},[1152]={40, 1},[1330]={40, 1},[1160]={40, 1},[1154]={40, 1},[1464]={40, 1},--Wod World and Garrison Bosses
	[1220]={45, 1},[1779]={45, 1},--Legion World bosses
	[1643]={50, 1},[1642]={50, 1},[1718]={50, 1},[1943]={50, 1},[1876]={50, 1},[2105]={50, 1},[2111]={50, 1},[2275]={50, 1},--Bfa World bosses and warfronts
	--Raids
	[509]={30, 3},[531]={30, 3},[469]={30, 3},[409]={30, 3},--Classic Raids
	[564]=30,[534]={30, 3},[532]={30, 3},[565]={30, 3},[544]={30, 3},[548]={30, 3},[580]={30, 3},[550]={30, 3},--BC Raids
	[615]={30, 3},[724]={30, 3},[649]={30, 3},[616]={30, 3},[631]={30, 3},[533]={30, 3},[249]={30, 3},[603]={30, 3},[624]={30, 3},--Wrath Raids
	[757]={35, 3},[671]={35, 3},[669]={35, 3},[967]={35, 3},[720]={35, 3},[951]={35, 3},[754]={35, 3},--Cata Raids
	[1009]={35, 3},[1008]={35, 3},[1136]={35, 3},[996]={35, 3},[1098]={35, 3},--MoP Raids
	[1205]={40, 3},[1448]={40, 3},[1228]={40, 3},--WoD Raids (yes, only 3 kekw)
	[1712]={50, 3},[1520]={50, 3},[1530]={50, 3},[1676]={50, 3},[1648]={50, 3},--Legion Raids (Set to 50 because 45 tuning makes them difficult even at 50)
	[1861]={50, 3},[2070]={50, 3},[2096]={50, 3},[2164]={50, 3},[2217]={50, 3},--BfA Raids
	[2296]={60, 3},--Shadowlands Raids
	--Dungeons
	[48]={30, 2},[230]={30, 2},[429]={30, 2},[389]={30, 2},[34]={30, 2},--Classic Dungeons
	[540]={30, 2},[558]={30, 2},[556]={30, 2},[555]={30, 2},[542]={30, 2},[546]={30, 2},[545]={30, 2},[547]={30, 2},[553]={30, 2},[554]={30, 2},[552]={30, 2},[557]={30, 2},[269]={30, 2},[560]={30, 2},[543]={30, 2},[585]={30, 2},--BC Dungeons
	[619]={30, 2},[601]={30, 2},[595]={30, 2},[600]={30, 2},[604]={30, 2},[602]={30, 2},[599]={30, 2},[576]={30, 2},[578]={30, 2},[574]={30, 2},[575]={30, 2},[608]={30, 2},[658]={30, 2},[632]={30, 2},[668]={30, 2},[650]={30, 2},--Wrath Dungeons
	[755]={35, 2},[645]={35, 2},[36]={35, 2},[670]={35, 2},[644]={35, 2},[33]={35, 2},[643]={35, 2},[725]={35, 2},[657]={35, 2},[309]={35, 2},[859]={35, 2},[568]={35, 2},[938]={35, 2},[940]={35, 2},[939]={35, 2},[646]={35, 2},--Cata Dungeons
	[960]={35, 2},[961]={35, 2},[959]={35, 2},[962]={35, 2},[994]={35, 2},[1011]={35, 2},[1007]={35, 2},[1001]={35, 2},[1004]={35, 2},--MoP Dungeons
	[1182]={40, 2},[1175]={40, 2},[1208]={40, 2},[1195]={40, 2},[1279]={40, 2},[1176]={40, 2},[1209]={40, 2},[1358]={40, 2},--WoD Dungeons
	[1501]={45, 2},[1466]={45, 2},[1456]={45, 2},[1477]={45, 2},[1458]={45, 2},[1516]={45, 2},[1571]={45, 2},[1492]={45, 2},[1544]={45, 2},[1493]={45, 2},[1651]={45, 2},[1677]={45, 2},[1753]={45, 2},--Legion Dungeons
	[1763]={50, 2},[1754]={50, 2},[1762]={50, 2},[1864]={50, 2},[1822]={50, 2},[1877]={50, 2},[1594]={50, 2},[1841]={50, 2},[1771]={50, 2},[1862]={50, 2},[2097]={50, 2},--Bfa Dungeons
	[2286]={60, 2},[2289]={60, 2},[2290]={60, 2},[2287]={60, 2},[2285]={60, 2},[2293]={60, 2},[2291]={60, 2},[2284]={60, 2}--Shadowlands Dungeons
}


-----------------
--  Libraries  --
-----------------
local LibStub = _G["LibStub"]
local LL
if LibStub("LibLatency", true) then
	LL = LibStub("LibLatency")
end
local LD
if LibStub("LibDurability", true) then
	LD = LibStub("LibDurability")
end


--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local DBM = DBM
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
local UnitAffectingCombat, InCombatLockdown, IsFalling, IsEncounterInProgress, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty = UnitAffectingCombat, InCombatLockdown, IsFalling, IsEncounterInProgress, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty
local UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff, UnitAura = UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff, UnitAura
local UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit = UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit
local GetSpellInfo, GetDungeonInfo, GetSpellTexture, GetSpellCooldown = GetSpellInfo, GetDungeonInfo, GetSpellTexture, GetSpellCooldown
local EJ_GetEncounterInfo, EJ_GetCreatureInfo = EJ_GetEncounterInfo, EJ_GetCreatureInfo
local EJ_GetSectionInfo, GetSectionIconFlags
if C_EncounterJournal then
	EJ_GetSectionInfo, GetSectionIconFlags = C_EncounterJournal.GetSectionInfo, C_EncounterJournal.GetSectionIconFlags
end
local GetInstanceInfo = GetInstanceInfo
local GetSpecialization, GetSpecializationInfo, GetSpecializationInfoByID = GetSpecialization, GetSpecializationInfo, GetSpecializationInfoByID
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitIsGroupLeader, UnitIsGroupAssistant = UnitIsGroupLeader, UnitIsGroupAssistant
local PlaySoundFile, PlaySound = PlaySoundFile, PlaySound
local Ambiguate = Ambiguate
local C_TimerAfter = C_Timer.After
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted

local SendAddonMessage = C_ChatInfo.SendAddonMessage

local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors

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

local function findEntry(t, val)
	for _, v in ipairs(t) do
		if v and val and val:find(v) then
			return true
		end
	end
	return false
end

-- removes all occurrences of a value in an array
-- returns true if at least one occurrence was remove, false otherwise
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
							if filterRaid and DBM:GetRaidUnitId(toonName) then--Person is in raid group and filter raid enabled
								return false--just set sender as unsafe
							else
								return true
							end
						end
					end
				end
			end
		end
		--Check if it's a non bnet friend
		local nf = C_FriendList.GetNumFriends()
		for i = 1, nf do
			local toonName = C_FriendList.GetFriendInfo(i)
			if toonName == sender then
				if filterRaid and DBM:GetRaidUnitId(toonName) then--Person is in raid group and filter raid enabled
					return false--just set sender as unsafe
				else
					return true
				end
			end
		end
	end
	--Check Guildies (not used by whisper syncs, but used by status whispers)
	if checkGuild then
		local totalMembers, _, numOnlineAndMobileMembers = GetNumGuildMembers()
		local scanTotal = GetGuildRosterShowOffline() and totalMembers or numOnlineAndMobileMembers--Attempt CPU saving, if "show offline" is unchecked, we can reliably scan only online members instead of whole roster
		for i=1, scanTotal do
			local name = GetGuildRosterInfo(i)
			if not name then break end
			name = Ambiguate(name, "none")
			if name == sender then
				if filterRaid and DBM:GetRaidUnitId(name) then--Person is in raid group and filter raid enabled
					return false--just set sender as unsafe
				else
					return true
				end
			end
		end
	end
	return false
end

-- automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
local function sendSync(prefix, msg)
	msg = msg or ""
	if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
		SendAddonMessage("D4", prefix .. "\t" .. msg, "INSTANCE_CHAT")
	else
		if IsInRaid() then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "RAID")
		elseif IsInGroup(1) then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "PARTY")
		else--for solo raid
			handleSync("SOLO", playerName, prefix, strsplit("\t", msg))
		end
	end
end

function DBM:SendSync(prefix, msg)
	sendSync(prefix, msg)
end

--Custom sync function that should only be used for user generated sync messages
local function sendLoggedSync(prefix, msg)
	msg = msg or ""
	if IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
		C_ChatInfo.SendAddonMessageLogged("D4", prefix .. "\t" .. msg, "INSTANCE_CHAT")
	else
		if IsInRaid() then
			C_ChatInfo.SendAddonMessageLogged("D4", prefix .. "\t" .. msg, "RAID")
		elseif IsInGroup(1) then
			C_ChatInfo.SendAddonMessageLogged("D4", prefix .. "\t" .. msg, "PARTY")
		else--for solo raid
			handleSync("SOLO", playerName, prefix, strsplit("\t", msg))
		end
	end
end

--Sync Object specifically for out in the world sync messages that have different rules than standard syncs
local function SendWorldSync(self, prefix, msg, noBNet)
	DBM:Debug("SendWorldSync running for "..prefix)
	if IsInRaid() then
		SendAddonMessage("D4", prefix.."\t"..msg, "RAID")
	elseif IsInGroup(1) then
		SendAddonMessage("D4", prefix.."\t"..msg, "PARTY")
	else--for solo raid
		handleSync("SOLO", playerName, prefix, strsplit("\t", msg))
	end
	if IsInGuild() then
		SendAddonMessage("D4", prefix.."\t"..msg, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
	end
	if not noBNet then
		local _, numBNetOnline = BNGetNumFriends()
		local connectedServers = GetAutoCompleteRealms()
		for i = 1, numBNetOnline do
			local sameRealm = false
			local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
			if accountInfo then
				local gameAccountID, isOnline, userRealm = accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.isOnline, accountInfo.gameAccountInfo.realmName
				if gameAccountID and isOnline and userRealm then
					--local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(presenceID)--Just in case required, if it can't actually be pulled from sub table of accountInfo above
					--local userRealm = accountInfo.gameAccountInfo.realmName or L.UNKNOWN
					if connectedServers then
						for j = 1, #connectedServers do
							if userRealm == connectedServers[j] then
								sameRealm = true
								break
							end
						end
					else
						if userRealm == playerRealm then
							sameRealm = true
						end
					end
					if sameRealm then
						BNSendGameData(gameAccountID, "D4", prefix.."\t"..msg)--Just send users realm for pull, so we can eliminate connectedServers checks on sync handler
					end
				end
			end
		end
	end
end

local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time*100)/100
	if time < 60 then
		return L.TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return L.TIMER_FORMAT_MINS:format(time/60)
	else
		return L.TIMER_FORMAT:format(time/60, time % 60)
	end
end

function DBM:strFromTime(time)
	return strFromTime(time)
end

-- sends a whisper to a player by his or her character name or BNet presence id
-- returns true if the message was sent, nil otherwise
local function sendWhisper(target, msg)
	if type(target) == "number" then
		if not BNIsSelf(target) then -- never send BNet whispers to ourselves
			BNSendWhisper(target, msg)
			return true
		end
	elseif type(target) == "string" then
		-- whispering to ourselves here is okay and somewhat useful for whisper-warnings
		SendChatMessage(msg, "WHISPER", nil, target)
		return true
	end
end
local BNSendWhisper = sendWhisper

--------------
--  Events  --
--------------
do
	local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
	local registeredEvents = {}
	local registeredSpellIds = {}
	local unfilteredCLEUEvents = {}
	local registeredUnitEventIds = {}
	local argsMT = {__index = {}}
	local args = setmetatable({}, argsMT)

	function argsMT.__index:IsSpellID(a1, a2, a3, a4, a5)
		local v = self.spellId
		return v == a1 or v == a2 or v == a3 or v == a4 or v == a5
	end

	function argsMT.__index:IsPlayer()
		return bband(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsPlayerSource()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsNPC()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0
	end

	function argsMT.__index:IsPet()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsPetSource()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsSrcTypePlayer()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsDestTypePlayer()
		return bband(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsSrcTypeHostile()
		return bband(args.sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:IsDestTypeHostile()
		return bband(args.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:GetSrcCreatureID()
		return DBM:GetCIDFromGUID(self.sourceGUID)
	end

	function argsMT.__index:GetDestCreatureID()
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
			if handler and (not isUnitEvent or not modEvents or modEvents[event .. ...]) and (not zones or zones[LastInstanceMapID]) and not (v.isTrashMod and #inCombat > 0) then
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
						frame:SetScript("OnEvent", function(self, event, uId, ...)
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
				DBM:AddMsg("DBM RegisterEvents Error: "..spellId.." is not a number!")
				return
			end
			if spellId and not DBM:GetSpellInfo(spellId) then
				DBM:AddMsg("DBM RegisterEvents Error: "..spellId.." spell id does not exist!")
				return
			end
			if not registeredSpellIds[event] then
				registeredSpellIds[event] = {}
			end
			registeredSpellIds[event][spellId] = (registeredSpellIds[event][spellId] or 0) + 1
		end

		function unregisterSpellId(event, spellId)
			if not registeredSpellIds[event] then return end
			if spellId and not DBM:GetSpellInfo(spellId) then
				DBM:AddMsg("DBM unregisterSpellId Error: "..spellId.." spell id does not exist!")
				return
			end
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
	function DBM:RegisterEvents(...)
		for i = 1, select("#", ...) do
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
					if not arg1 and event:sub(event:len() - 10) ~= "_UNFILTERED" then -- no arguments given, support for legacy mods
						eventWithArgs = event .. " boss1 boss2 boss3 boss4 boss5 target focus"
						event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", eventWithArgs)
					end
					if event:sub(event:len() - 10) == "_UNFILTERED" then
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
			if eventName:sub(eventName:len() - 10) == "_UNFILTERED" then
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
					i = i +1
				end
			elseif (event:sub(0, 6) == "SPELL_"and event ~= "SPELL_NAME_UPDATE" or event:sub(0, 6) == "RANGE_") then
				local i = 1
				while mods[i] do
					if mods[i] == self and (srmIncluded or event ~= "SPELL_AURA_REMOVED") then
						local findEvent = findRealEvent(self.inCombatOnlyEvents, event)
						if findEvent then
							unregisterCLEUEvent(self, findEvent)
							break
						end
					end
					i = i +1
				end
			else
				local match = false
				for i = #mods, 1, -1 do
					if mods[i] == self and checkEntry(self.inCombatOnlyEvents, event)  then
						tremove(mods, i)
						match = true
					end
				end
				if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(0, -10) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then -- unit events have their own reference count
					unregisterUEvent(self, event)
				end
				if #mods == 0 then
					registeredEvents[event] = nil
				end
			end
		end
	end

	function DBM:RegisterShortTermEvents(...)
		local _shortTermRegisterEvents = {...}
		for k, v in pairs(_shortTermRegisterEvents) do
			if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
				-- legacy event, oh noes
				_shortTermRegisterEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
			end
		end
		self.shortTermEventsRegistered = 1
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
		if self.shortTermRegisterEvents then
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
						i = i +1
					end
				else
					local match = false
					for i = #mods, 1, -1 do
						if mods[i] == self and checkEntry(self.shortTermRegisterEvents, event) then
							tremove(mods, i)
							match = true
						end
					end
					if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(0, -10) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then
						unregisterUEvent(self, event)
					end
					if #mods == 0 then
						registeredEvents[event] = nil
					end
				end
			end
			self.shortTermEventsRegistered = nil
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
		if not registeredEvents[event] then return end
		local eventSub6 = event:sub(0, 6)
		if (eventSub6 == "SPELL_" or eventSub6 == "RANGE_") and not unfilteredCLEUEvents[event] and registeredSpellIds[event] then
			if not registeredSpellIds[event][extraArg1] then return end
		end
		-- process some high volume events without building the whole table which is somewhat faster
		-- this prevents work-around with mods that used to have their own event handler to prevent this overhead
		if noArgTableEvents[event] then
			return handleEvent(nil, event, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10)
		else
			twipe(args)
			args.timestamp = timestamp
			args.event = event
			args.sourceGUID = sourceGUID
			args.sourceName = sourceName
			args.sourceFlags = sourceFlags
			args.sourceRaidFlags = sourceRaidFlags
			args.destGUID = destGUID
			args.destName = destName
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
	local onLoadCallbacks = {}
	local disabledMods = {}

	local function infniteLoopNotice(self, message)
		AddMsg(self, message)
		self:Schedule(30, infniteLoopNotice, self, message)
	end

	local function runDelayedFunctions(self)
		--Check if voice pack missing
		local activeVP = self.Options.ChosenVoicePack
		if activeVP ~= "None" then
			if not self.VoiceVersions[activeVP] or (self.VoiceVersions[activeVP] and self.VoiceVersions[activeVP] == 0) then--A voice pack is selected that does not belong
				DBM.voiceSessionDisabled = true
				AddMsg(self, L.VOICE_MISSING)
			end
		else
			if self.Options.ShowReminders and #self.Voices > 1 then
				--At least one voice pack installed but activeVP set to "None"
				AddMsg(self, L.VOICE_DISABLED)
			end
		end
		--Check if any of countdown sounds are using missing voice pack
		local found1, found2, found3 = false, false, false
		for i = 1, #self.Counts do
			local voice = self.Counts[i].value
			if voice == self.Options.CountdownVoice then
				found1 = true
			end
			if voice == self.Options.CountdownVoice2 then
				found2 = true
			end
			if voice == self.Options.CountdownVoice3 then
				found3 = true
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
		if IsInGuild() then
			SendAddonMessage("D4", "GH", "GUILD")
		end
		if not DBM.savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			DBM.savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
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
			dbmToc = tonumber(GetAddOnMetadata("DBM-Core", "X-Min-Interface"))
			isLoaded = true
			for _, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			loadOptions(self)
			if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
				self:Disable(true)
				self:Schedule(15, infniteLoopNotice, self, L.RETAIL_ONLY)
				return
			end
			if GetAddOnEnableState(playerName, "VEM-Core") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, L.VEM) end)
				return
			end
			if GetAddOnEnableState(playerName, "DBM-Profiles") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, L.OUTDATEDPROFILES) end)
				return
			end
			if GetAddOnEnableState(playerName, "DBM-SpellTimers") >= 1 then
				local version = GetAddOnMetadata("DBM-SpellTimers", "Version") or "r0"
				version = tonumber(string.sub(version, 2, 4)) or 0
				if version < 122 and not self.Options.DebugMode then
					self:Disable(true)
					self:Schedule(15, infniteLoopNotice, self, L.OUTDATEDSPELLTIMERS)
					return
				end
			end
			if GetAddOnEnableState(playerName, "DBM-RaidLeadTools") >= 1 and not self.Options.DebugMode then
				self:Disable(true)
				self:Schedule(15, infniteLoopNotice, self, L.OUTDATEDRLT)
				return
			end
			if GetAddOnEnableState(playerName, "DPMCore") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, L.DPMCORE) end)
				return
			end
			if GetAddOnEnableState(playerName, "DBM-VictorySound") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, L.VICTORYSOUND) end)
				return
			end
			if GetAddOnEnableState(playerName, "DBM-LDB") >= 1 then
				C_TimerAfter(15, function() AddMsg(self, L.DBMLDB) end)
			end
			if GetAddOnEnableState(playerName, "DBM-LootReminder") >= 1 then
				C_TimerAfter(15, function() AddMsg(self, L.DBMLOOTREMINDER) end)
			end
			self.Bars:LoadOptions("DBM")
			self.Arrow:LoadPosition()
			-- LibDBIcon setup
			if type(DBM_MinimapIcon) ~= "table" then
				DBM_MinimapIcon = {}
			end
			if LibStub("LibDBIcon-1.0", true) then
				LibStub("LibDBIcon-1.0"):Register("DBM", dataBroker, DBM_MinimapIcon)
			end
			local soundChannels = tonumber(GetCVar("Sound_NumChannels")) or 24--if set to 24, may return nil, Defaults usually do
			--If this messes with your fps, stop raiding with a toaster. It's only fix for addon sound ducking.
			if soundChannels < 64 then
				SetCVar("Sound_NumChannels", 64)
			end
			self.AddOns = {}
			self.Voices = { {text = "None",value  = "None"}, }--Create voice table, with default "None" value
			self.VoiceVersions = {}
			for i = 1, GetNumAddOns() do
				local addonName = GetAddOnInfo(i)
				local enabled = GetAddOnEnableState(playerName, i)
				if GetAddOnMetadata(i, "X-DBM-Mod") then
					if enabled ~= 0 then
						if checkEntry(bannedMods, addonName) then
							AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
						else
							local mapIdTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-MapID") or "")}
							tinsert(self.AddOns, {
								sort			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or mhuge) or mhuge,
								type			= GetAddOnMetadata(i, "X-DBM-Mod-Type") or "OTHER",
								category		= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
								statTypes		= GetAddOnMetadata(i, "X-DBM-StatTypes") or "",
								name			= GetAddOnMetadata(i, "X-DBM-Mod-Name") or GetRealZoneText(tonumber(mapIdTable[1])) or L.UNKNOWN,
								mapId			= mapIdTable,
								subTabs			= GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID"))} or GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
								oneFormat		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Single-Format") or 0) == 1, -- Deprecated
								hasLFR			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-LFR") or 0) == 1, -- Deprecated
								hasChallenge	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Challenge") or 0) == 1, -- Deprecated
								noHeroic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Heroic") or 0) == 1, -- Deprecated
								hasMythic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Mythic") or 0) == 1, -- Deprecated
								hasTimeWalker	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-TimeWalker") or 0) == 1, -- Deprecated
								noStatistics	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Statistics") or 0) == 1,
								isWorldBoss		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-World-Boss") or 0) == 1,
								isExpedition	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Expedition") or 0) == 1,
								minRevision		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-MinCoreRevision") or 0),
								minExpansion	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-MinExpansion") or 0),
								minToc			= tonumber(GetAddOnMetadata(i, "X-Min-Interface") or 0),
								modId			= addonName,
							})
							for j = #self.AddOns[#self.AddOns].mapId, 1, -1 do
								local id = tonumber(self.AddOns[#self.AddOns].mapId[j])
								if id then
									self.AddOns[#self.AddOns].mapId[j] = id
								else
									tremove(self.AddOns[#self.AddOns].mapId, j)
								end
							end
							if self.AddOns[#self.AddOns].subTabs then
								local subTabs = self.AddOns[#self.AddOns].subTabs
								for k, _ in ipairs(subTabs) do
									--Ugly hack to inject custom string text into auto localized zone name sub cats
									if subTabs[k]:find("|") then
										local id, nameModifier = strsplit("|", subTabs[k])
										if id and nameModifier then
											id = tonumber(id)
											self.AddOns[#self.AddOns].subTabs[k] = (GetRealZoneText(id):trim() or id).." ("..nameModifier..")"
										else
											self.AddOns[#self.AddOns].subTabs[k] = (subTabs[k]):trim()
										end
									else
										local id = tonumber(subTabs[k])
										if id then
											local name = GetRealZoneText(id):trim() or id
											local subname = strsplit("-", name)--For handling zones like Warfront: Arathi - Alliance
											self.AddOns[#self.AddOns].subTabs[k] = subname
										else
											self.AddOns[#self.AddOns].subTabs[k] = (subTabs[k]):trim()
										end
									end
								end
							end
							if GetAddOnMetadata(i, "X-DBM-Mod-LoadCID") then
								local idTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadCID"))}
								for j = 1, #idTable do
									loadcIds[tonumber(idTable[j]) or ""] = addonName
								end
							end
						end
					else
						disabledMods[#disabledMods+1] = addonName
					end
				end
				if GetAddOnMetadata(i, "X-DBM-Voice") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						C_TimerAfter(0.01, function()
							local voiceValue = GetAddOnMetadata(i, "X-DBM-Voice-ShortName")
							local voiceVersion = tonumber(GetAddOnMetadata(i, "X-DBM-Voice-Version") or 0)
							if voiceVersion > 0 then--Do not insert voice version 0 into THIS table. 0 should be used by voice packs that insert only countdown
								tinsert(self.Voices, { text = GetAddOnMetadata(i, "X-DBM-Voice-Name"), value = voiceValue })
							end
							self.VoiceVersions[voiceValue] = voiceVersion
							self:Schedule(10, self.CheckVoicePackVersion, self, voiceValue)--Still at 1 since the count sounds won't break any mods or affect filter. V2 if support countsound path
							if GetAddOnMetadata(i, "X-DBM-Voice-HasCount") then--Supports adding countdown options, insert new countdown into table
								tinsert(self.Counts, { text = GetAddOnMetadata(i, "X-DBM-Voice-Name"), value = "VP:"..voiceValue, path = "Interface\\AddOns\\DBM-VP"..voiceValue.."\\count\\", max = 10})
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-CountPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local voiceGlobal = GetAddOnMetadata(i, "X-DBM-CountPack-GlobalName")
							local insertFunction = _G[voiceGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time CountPack function "..voiceGlobal.."ran", 2)
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-VictoryPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local victoryGlobal = GetAddOnMetadata(i, "X-DBM-VictoryPack-GlobalName")
							local insertFunction = _G[victoryGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time VictoryPack function "..victoryGlobal.." ran", 2)
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-DefeatPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local defeatGlobal = GetAddOnMetadata(i, "X-DBM-DefeatPack-GlobalName")
							local insertFunction = _G[defeatGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time DefeatPack function "..defeatGlobal.." ran", 2)
							end
						end)
					end
				end
				if GetAddOnMetadata(i, "X-DBM-MusicPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						C_TimerAfter(0.01, function()
							local musicGlobal = GetAddOnMetadata(i, "X-DBM-MusicPack-GlobalName")
							local insertFunction = _G[musicGlobal]
							if loaded and insertFunction then
								insertFunction()
							else
								self:Debug(addonName.." failed to load at time MusicPack function "..musicGlobal.." ran", 2)
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
				"UNIT_TARGETABLE_CHANGED",
				"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
				"UNIT_TARGET_UNFILTERED",
				"ENCOUNTER_START",
				"ENCOUNTER_END",
				"BOSS_KILL",
				"UNIT_DIED",
				"UNIT_DESTROYED",
				"UNIT_HEALTH mouseover target focus player",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_BN_WHISPER",
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_MONSTER_SAY",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"RAID_BOSS_EMOTE",
				"RAID_BOSS_WHISPER",
				"PLAYER_ENTERING_WORLD",
				"LFG_ROLE_CHECK_SHOW",
				"LFG_PROPOSAL_SHOW",
				"LFG_PROPOSAL_FAILED",
				"LFG_PROPOSAL_SUCCEEDED",
				"READY_CHECK",
				"UPDATE_BATTLEFIELD_STATUS",
				"PLAY_MOVIE",
				"CINEMATIC_START",
				"CINEMATIC_STOP",
				"PLAYER_LEVEL_CHANGED",
				"PLAYER_SPECIALIZATION_CHANGED",
				"PARTY_INVITE_REQUEST",
				"LOADING_SCREEN_DISABLED",
				"LOADING_SCREEN_ENABLED",
				"SCENARIO_COMPLETED"
			)
			if RolePollPopup:IsEventRegistered("ROLE_POLL_BEGIN") then
				RolePollPopup:UnregisterEvent("ROLE_POLL_BEGIN")
			end
			self:GROUP_ROSTER_UPDATE()
			C_TimerAfter(1.5, function()
				combatInitialized = true
			end)
			C_TimerAfter(20, function()--Delay UNIT_HEALTH combat start for 20 sec. (not to break Timer Recovery stuff)
				healthCombatInitialized = true
			end)
			self:Schedule(10, runDelayedFunctions, self)
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
			local ok, err = pcall(v, event, ...)
			if not ok then DBM:AddMsg(("Error while executing callback %s for event %s: %s"):format(tostring(v), tostring(event), err)) end
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
				error("Usage: UnregisterCallback(event, callbackFunc)", 2)
			end
			--> checking from the end to start and not stoping after found one result in case of a func being twice registered.
			for i = #callbacks[event], 1, -1 do
				if callbacks[event][i] == f then tremove (callbacks[event], i) end
			end
		else
			callbacks[event] = nil
		end
	end
end


--------------------------
--  OnUpdate/Scheduler  --
--------------------------
do
	-- stack that stores a few tables (up to 8) which will be recycled
	local popCachedTable, pushCachedTable
	local numChachedTables = 0
	do
		local tableCache

		-- gets a table from the stack, it will then be recycled.
		function popCachedTable()
			local t = tableCache
			if t then
				tableCache = t.next
				numChachedTables = numChachedTables - 1
			end
			return t
		end

		-- tries to push a table on the stack
		-- only tables with <= 4 array entries are accepted as cached tables are only used for tasks with few arguments as we don't want to have big arrays wasting our precious memory space doing nothing...
		-- also, the maximum number of cached tables is limited to 8 as DBM rarely has more than eight scheduled tasks with less than 4 arguments at the same time
		-- this is just to re-use all the tables of the small tasks that are scheduled all the time (like the wipe detection)
		-- note that the cache does not use weak references anywhere for performance reasons, so a cached table will never be deleted by the garbage collector
		function pushCachedTable(t)
			if numChachedTables < 8 and #t <= 4 then
				twipe(t)
				t.next = tableCache
				tableCache = t
				numChachedTables = numChachedTables + 1
			end
		end
	end

	-- priority queue (min-heap) that stores all scheduled tasks.
	-- insert: O(log n)
	-- deleteMin: O(log n)
	-- getMin: O(1)
	-- removeAllMatching: O(n)
	local insert, removeAllMatching, getMin, deleteMin
	do
		local heap = {}
		local firstFree = 1

		-- gets the next task
		function getMin()
			return heap[1]
		end

		-- restores the heap invariant by moving an item up
		local function siftUp(n)
			local parent = floor(n / 2)
			while n > 1 and heap[parent].time > heap[n].time do -- move the element up until the heap invariant is restored, meaning the element is at the top or the element's parent is <= the element
				heap[n], heap[parent] = heap[parent], heap[n] -- swap the element with its parent
				n = parent
				parent = floor(n / 2)
			end
		end

		-- restores the heap invariant by moving an item down
		local function siftDown(n)
			local m -- position of the smaller child
			while 2 * n < firstFree do -- #children >= 1
				-- swap the element with its smaller child
				if 2 * n + 1 == firstFree then -- n does not have a right child --> it only has a left child as #children >= 1
					m = 2 * n -- left child
				elseif heap[2 * n].time < heap[2 * n + 1].time then -- #children = 2 and left child < right child
					m = 2 * n -- left child
				else -- #children = 2 and right child is smaller than the left one
					m = 2 * n + 1 -- right
				end
				if heap[n].time <= heap[m].time then -- n is <= its smallest child --> heap invariant restored
					return
				end
				heap[n], heap[m] = heap[m], heap[n]
				n = m
			end
		end

		-- inserts a new element into the heap
		function insert(ele)
			heap[firstFree] = ele
			siftUp(firstFree)
			firstFree = firstFree + 1
		end

		-- deletes the min element
		function deleteMin()
			local min = heap[1]
			firstFree = firstFree - 1
			heap[1] = heap[firstFree]
			heap[firstFree] = nil
			siftDown(1)
			return min
		end

		-- removes multiple scheduled tasks from the heap
		-- note that this function is comparatively slow by design as it has to check all tasks and allows partial matches
		function removeAllMatching(f, mod, ...)
			-- remove all elements that match the signature, this destroyes the heap and leaves a normal array
			local v, match
			local foundMatch = false
			for i = #heap, 1, -1 do -- iterate backwards over the array to allow usage of table.remove
				v = heap[i]
				if (not f or v.func == f) and (not mod or v.mod == mod) then
					match = true
					for j = 1, select("#", ...) do
						if select(j, ...) ~= v[j] then
							match = false
							break
						end
					end
					if match then
						tremove(heap, i)
						firstFree = firstFree - 1
						foundMatch = true
					end
				end
			end
			-- rebuild the heap from the array in O(n)
			if foundMatch then
				for i = floor((firstFree - 1) / 2), 1, -1 do
					siftDown(i)
				end
			end
		end
	end


	local wrappers = {}
	local function range(max, cur, ...)
		cur = cur or 1
		if cur > max then
			return ...
		end
		return cur, range(max, cur + 1, select(2, ...))
	end
	local function getWrapper(n)
		wrappers[n] = wrappers[n] or loadstring(([[
			return function(func, tbl)
				return func(]] .. ("tbl[%s], "):rep(n):sub(0, -3) .. [[)
			end
		]]):format(range(n)))()
		return wrappers[n]
	end

	local nextModSyncSpamUpdate = 0
	--mainFrame:SetScript("OnUpdate", function(self, elapsed)
	local function onUpdate(self, elapsed)
		local time = GetTime()

		-- execute scheduled tasks
		local nextTask = getMin()
		while nextTask and nextTask.func and nextTask.time <= time do
			deleteMin()
			local n = nextTask.n
			if n == #nextTask then
				nextTask.func(unpack(nextTask))
			else
				-- too many nil values (or a trailing nil)
				-- this is bad because unpack will not work properly
				-- TODO: is there a better solution?
				getWrapper(n)(nextTask.func, nextTask)
			end
			pushCachedTable(nextTask)
			nextTask = getMin()
		end

		-- execute OnUpdate handlers of all modules
		local foundModFunctions = 0
		for i, v in pairs(DBM.updateFunctions) do
			foundModFunctions = foundModFunctions + 1
			if i.Options.Enabled and (not i.zones or i.zones[LastInstanceMapID]) then
				i.elapsed = (i.elapsed or 0) + elapsed
				if i.elapsed >= (i.updateInterval or 0) then
					v(i, i.elapsed)
					i.elapsed = 0
				end
			end
		end

		-- clean up sync spam timers and auto respond spam blockers
		if time > nextModSyncSpamUpdate then
			nextModSyncSpamUpdate = time + 20
			-- TODO: optimize this; using next(t, k) all the time on nearly empty hash tables is not a good idea...doesn't really matter here as modSyncSpam only very rarely contains more than 4 entries...
			-- we now do this just every 20 seconds since the earlier assumption about modSyncSpam isn't true any longer
			-- note that not removing entries at all would be just a small memory leak and not a problem (the sync functions themselves check the timestamp)
			local k, v = next(DBM.modSyncSpam, nil)
			if v and (time - v > 8) then
				DBM.modSyncSpam[k] = nil
			end
		end
		if not nextTask and foundModFunctions == 0 then--Nothing left, stop scheduler
			schedulerFrame:SetScript("OnUpdate", nil)
			schedulerFrame:Hide()
		end
	end

	function DBM.StartScheduler()
		if not schedulerFrame:IsShown() then
			schedulerFrame:Show()
			schedulerFrame:SetScript("OnUpdate", onUpdate)
		end
	end

	function schedule(t, f, mod, ...)
		if type(f) ~= "function" then
			error("usage: schedule(time, func, [mod, args...])", 2)
		end
		DBM:StartScheduler()
		local v
		if numChachedTables > 0 and select("#", ...) <= 4 then -- a cached table is available and all arguments fit into an array with four slots
			v = popCachedTable()
			v.time = GetTime() + t
			v.func = f
			v.mod = mod
			v.n = select("#", ...)
			for i = 1, v.n do
				v[i] = select(i, ...)
			end
			-- clear slots if necessary
			for i = v.n + 1, 4 do
				v[i] = nil
			end
		else -- create a new table
			v = {time = GetTime() + t, func = f, mod = mod, n = select("#", ...), ...}
		end
		insert(v)
	end

	function unschedule(f, mod, ...)
		if not f and not mod then
			-- you really want to kill the complete scheduler? call unscheduleAll
			error("cannot unschedule everything, pass a function and/or a mod")
		end
		return removeAllMatching(f, mod, ...)
	end

	function unscheduleAll()
		return removeAllMatching()
	end
end

function DBM:Schedule(t, f, ...)
	if type(f) ~= "function" then
		error("usage: DBM:Schedule(time, func, [args...])", 2)
	end
	return schedule(t, f, nil, ...)
end

function DBM:Unschedule(f, ...)
	return unschedule(f, nil, ...)
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
	self.Bars:CreateProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_CREATED:format(name))
end

function DBM:ApplyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_APPLY_ERROR:format(name or L.UNKNOWN))
		return
	end
	usedProfile = name
	DBM_UsedProfile = usedProfile
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	self.Bars:ApplyProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_APPLIED:format(name))
end

function DBM:CopyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_COPY_ERROR:format(name or L.UNKNOWN))
		return
	elseif name == usedProfile then
		self:AddMsg(L.PROFILE_COPY_ERROR_SELF)
		return
	end
	DBM_AllSavedOptions[usedProfile] = DBM_AllSavedOptions[name]
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	self.Bars:CopyProfile(name, "DBM")
	self:RepositionFrames()
	self:AddMsg(L.PROFILE_COPIED:format(name))
end

function DBM:DeleteProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(L.PROFILE_DELETE_ERROR:format(name or L.UNKNOWN))
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
	self.Bars:DeleteProfile(name, "DBM")
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
	local trackedHudMarkers = {}
	local function Pull(timer)
		local LFGTankException = IsPartyLFG() and UnitGroupRolesAssigned("player") == "TANK"--Tanks in LFG need to be able to send pull timer even if someone refuses to pass lead. LFG locks roles so no one can abuse this.
		if (DBM:GetRaidRank(playerName) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() or (timer > 0 and timer < 3) then
			return DBM:AddMsg(L.ERROR_NO_PERMISSION)
		end
		local targetName = (UnitExists("target") and UnitIsEnemy("player", "target")) and UnitName("target") or nil--Filter non enemies in case player isn't targetting bos but another player/pet
		if targetName then
			sendSync("PT", timer.."\t"..LastInstanceMapID.."\t"..targetName)
		else
			sendSync("PT", timer.."\t"..LastInstanceMapID)
		end
	end
	local function Break(timer)
		if IsInGroup() and (DBM:GetRaidRank(playerName) == 0 or IsPartyLFG()) or IsEncounterInProgress() or select(2, IsInInstance()) == "pvp" then--No break timers if not assistant or if it's dungeon/raid finder/BG
			DBM:AddMsg(L.ERROR_NO_PERMISSION)
			return
		end
		if timer > 60 then
			DBM:AddMsg(L.BREAK_USAGE)
			return
		end
		timer = timer * 60
		sendSync("BT", timer)
	end

	SLASH_DEADLYBOSSMODS1 = "/dbm"
	SLASH_DEADLYBOSSMODSRPULL1 = "/rpull"
	SLASH_DEADLYBOSSMODSDWAY1 = "/dway"--/way not used because DBM would load before TomTom and can't check
	SlashCmdList["DEADLYBOSSMODSDWAY"] = function(msg)
		if DBM:HasMapRestrictions() then
			DBM:AddMsg(L.NO_ARROW)
			return
		end
		local x, y = string.split(" ", msg:sub(1):trim())
		local xNum, yNum = tonumber(x or ""), tonumber(y or "")
		local success
		if xNum and yNum then
			DBM.Arrow:ShowRunTo(xNum, yNum, 1, nil, true)
			success = true
		else--Check if they used , instead of space.
			x, y = string.split(",", msg:sub(1):trim())
			xNum, yNum = tonumber(x or ""), tonumber(y or "")
			if xNum and yNum then
				DBM.Arrow:ShowRunTo(xNum, yNum, 1, nil, true)
				success = true
			end
		end
		if not success then
			if DBM.Arrow:IsShown() then
				DBM.Arrow:Hide()--Hide
			else--error
				DBM:AddMsg(L.ARROW_WAY_USAGE)
			end
		end
	end
	if not _G["BigWigs"] then
		--Register pull and break slash commands for BW converts, if BW isn't loaded
		--This shouldn't raise an issue since BW SHOULD load before DBM in any case they are both present.
		SLASH_DEADLYBOSSMODSPULL1 = "/pull"
		SLASH_DEADLYBOSSMODSBREAK1 = "/break"
		SlashCmdList["DEADLYBOSSMODSPULL"] = function(msg)
			Pull(tonumber(msg) or 10)
		end
		SlashCmdList["DEADLYBOSSMODSBREAK"] = function(msg)
			Break(tonumber(msg) or 10)
		end
	end
	SlashCmdList["DEADLYBOSSMODSRPULL"] = function(msg)
		Pull(30)
	end
	SlashCmdList["DEADLYBOSSMODS"] = function(msg)
		local cmd = msg:lower()
		if cmd == "ver" or cmd == "version" then
			DBM:ShowVersions(false)
		elseif cmd == "ver2" or cmd == "version2" then
			DBM:ShowVersions(true)
		elseif cmd == "unlock" or cmd == "move" then
			DBM.Bars:ShowMovableBar()
		elseif cmd == "help2" then
			for _, v in ipairs(L.SLASHCMD_HELP2) do DBM:AddMsg(v) end
		elseif cmd == "help" then
			for _, v in ipairs(L.SLASHCMD_HELP) do DBM:AddMsg(v) end
		elseif cmd:sub(1, 13) == "timer endloop" then
			DBM:CreatePizzaTimer(time, "", nil, nil, nil, true)
		elseif cmd:sub(1, 5) == "timer" then
			local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
			if not (time and text) then
				for _, v in ipairs(L.TIMER_USAGE) do DBM:AddMsg(v) end
				return
			end
			local min, sec = string.split(":", time)
			min = tonumber(min or "") or 0
			sec = tonumber(sec or "")
			if min and not sec then
				sec = min
				min = 0
			end
			time = min * 60 + sec
			DBM:CreatePizzaTimer(time, text)
		elseif cmd:sub(1, 6) == "ltimer" then
			local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
			if not (time and text) then
				DBM:AddMsg(L.PIZZA_ERROR_USAGE)
				return
			end
			local min, sec = string.split(":", time)
			min = tonumber(min or "") or 0
			sec = tonumber(sec or "")
			if min and not sec then
				sec = min
				min = 0
			end
			time = min * 60 + sec
			DBM:CreatePizzaTimer(time, text, nil, nil, true)
		elseif cmd:sub(1, 15) == "broadcast timer" then--Standard Timer
			local permission = true
			if DBM:GetRaidRank(playerName) == 0 or difficultyIndex == 7 or difficultyIndex == 17 then
				DBM:AddMsg(L.ERROR_NO_PERMISSION)
				permission = false
			end
			local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
			if not (time and text) then
				DBM:AddMsg(L.PIZZA_ERROR_USAGE)
				return
			end
			local min, sec = string.split(":", time)
			min = tonumber(min or "") or 0
			sec = tonumber(sec or "")
			if min and not sec then
				sec = min
				min = 0
			end
			time = min * 60 + sec
			DBM:CreatePizzaTimer(time, text, permission)
		elseif cmd:sub(1, 16) == "broadcast ltimer" then
			local permission = true
			if DBM:GetRaidRank(playerName) == 0 or difficultyIndex == 7 or difficultyIndex == 17 then
				DBM:AddMsg(L.ERROR_NO_PERMISSION)
				permission = false
			end
			local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
			if not (time and text) then
				DBM:AddMsg(L.PIZZA_ERROR_USAGE)
				return
			end
			local min, sec = string.split(":", time)
			min = tonumber(min or "") or 0
			sec = tonumber(sec or "")
			if min and not sec then
				sec = min
				min = 0
			end
			time = min * 60 + sec
			DBM:CreatePizzaTimer(time, text, permission, nil, true)
		elseif cmd:sub(0,5) == "break" then
			local timer = tonumber(cmd:sub(6)) or 5
			Break(timer)
		elseif cmd:sub(1, 4) == "pull" then
			local timer = tonumber(cmd:sub(5)) or 10
			Pull(timer)
		elseif cmd:sub(1, 5) == "rpull" then
			Pull(30)
		elseif cmd:sub(1, 3) == "lag" then
			if not LL then
				DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
				return
			end
			LL:RequestLatency()
			DBM:AddMsg(L.LAG_CHECKING)
			C_TimerAfter(5, function() DBM:ShowLag() end)
		elseif cmd:sub(1, 10) == "durability" then
			if not LD then
				DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
				return
			end
			LD:RequestDurability()
			DBM:AddMsg(L.DUR_CHECKING)
			C_TimerAfter(5, function() DBM:ShowDurability() end)
		elseif cmd:sub(1, 3) == "hud" then
			if DBM:HasMapRestrictions() then
				DBM:AddMsg(L.NO_HUD)
				return
			end
			local hudType, target, duration = string.split(" ", msg:sub(4):trim())
			if hudType == "" then
				for _, v in ipairs(L.HUD_USAGE) do
					DBM:AddMsg(v)
				end
				return
			end
			local hudDuration = tonumber(duration) or 1200--if no duration defined. 20 minutes to cover even longest of fights
			local success = false
			if type(hudType) == "string" and hudType:trim() ~= "" then
				if hudType:upper() == "HIDE" then
					for name, _ in pairs(trackedHudMarkers) do
						DBM.HudMap:FreeEncounterMarkerByTarget(12345, name)
						trackedHudMarkers[name] = nil
					end
					return
				end
				if not target then
					DBM:AddMsg(L.HUD_INVALID_TARGET)
					return
				end
				local uId
				if target:upper() == "TARGET" and UnitExists("target") then
					uId = "target"
				elseif target:upper() == "FOCUS" and UnitExists("focus") then
					uId = "focus"
				else--Try to use it as player name
					uId = DBM:GetRaidUnitId(target)
				end
				if not uId then
					DBM:AddMsg(L.HUD_INVALID_TARGET)
					return
				end
				if UnitIsUnit("player", uId) and not DBM.Options.DebugMode then--Don't allow hud to self, except if debug mode is enabled, then hud to self useful for testing
					DBM:AddMsg(L.HUD_INVALID_SELF)
					return
				end
				local targetName = UnitName(uId)
				if hudType:upper() == "ARROW" then
					local _, targetClass = UnitClass(uId)
					local color2 = RAID_CLASS_COLORS[targetClass]
					local m1 = DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", playerName, 0.1, hudDuration, 0, 1, 0, 1, nil, false):Appear()
					local m2 = DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil, false):Appear()
					trackedHudMarkers[playerName] = true
					trackedHudMarkers[targetName] = true
					m2:EdgeTo(m1, nil, hudDuration, 0, 1, 0, 1)
					success = true
				elseif hudType:upper() == "DOT" then
					local _, targetClass = UnitClass(uId)
					local color2 = RAID_CLASS_COLORS[targetClass]
					DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil, false):Appear()
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "GREEN" then
					DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 1, 0, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "RED" then
					DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 0, 0, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "YELLOW" then
					DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 1, 0, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "BLUE" then
					DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 0, 1, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "ICON" then
					local icon = GetRaidTargetIndex(uId)
					if not icon then
						DBM:AddMsg(L.HUD_INVALID_ICON)
						return
					end
					local iconString = DBM:IconNumToString(icon):lower()
					DBM.HudMap:RegisterRangeMarkerOnPartyMember(12345, iconString, targetName, 3.5, hudDuration, 1, 1, 1, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				else
					DBM:AddMsg(L.HUD_INVALID_TYPE)
				end
			end
			if success then
				DBM:AddMsg(L.HUD_SUCCESS:format(strFromTime(hudDuration)))
			end
		elseif cmd:sub(1, 5) == "arrow" then
			if DBM:HasMapRestrictions() then
				DBM:AddMsg(L.NO_ARROW)
				return
			end
			local x, y, z = string.split(" ", msg:sub(6):trim())
			local xNum, yNum, zNum = tonumber(x or ""), tonumber(y or ""), tonumber(z or "")
			local success
			if xNum and yNum then
				DBM.Arrow:ShowRunTo(xNum, yNum, 0)
				success = true
			elseif type(x) == "string" and x:trim() ~= "" then
				local subCmd = x:trim()
				if subCmd:upper() == "HIDE" then
					DBM.Arrow:Hide()
					success = true
				elseif subCmd:upper() == "MOVE" then
					DBM.Arrow:Move()
					success = true
				elseif subCmd:upper() == "TARGET" then
					DBM.Arrow:ShowRunTo("target")
					success = true
				elseif subCmd:upper() == "FOCUS" then
					DBM.Arrow:ShowRunTo("focus")
					success = true
				elseif subCmd:upper() == "MAP" then
					DBM.Arrow:ShowRunTo(yNum, zNum, 0, nil, true)
					success = true
				elseif DBM:GetRaidUnitId(subCmd) then
					DBM.Arrow:ShowRunTo(subCmd)
					success = true
				end
			end
			if not success then
				for _, v in ipairs(L.ARROW_ERROR_USAGE) do
					DBM:AddMsg(v)
				end
			end
		elseif cmd:sub(1, 7) == "lockout" or cmd:sub(1, 3) == "ids" then
			if DBM:GetRaidRank(playerName) == 0 then
				return DBM:AddMsg(L.ERROR_NO_PERMISSION)
			end
			if not IsInRaid() then
				return DBM:AddMsg(L.ERROR_NO_RAID)
			end
			DBM:RequestInstanceInfo()
		elseif cmd:sub(1, 10) == "debuglevel" then
			local level = tonumber(cmd:sub(11)) or 1
			if level < 1 or level > 3 then
				DBM:AddMsg("Invalid Value. Debug Level must be between 1 and 3.")
				return
			end
			DBM.Options.DebugLevel = level
			DBM:AddMsg("Debug Level is " .. level)
		elseif cmd:sub(1, 5) == "debug" then
			DBM.Options.DebugMode = DBM.Options.DebugMode == false and true or false
			DBM:AddMsg("Debug Message is " .. (DBM.Options.DebugMode and "ON" or "OFF"))
		elseif cmd:sub(1, 8) == "whereiam" or cmd:sub(1, 8) == "whereami" then
			if DBM:HasMapRestrictions() then
				local _, _, _, map = UnitPosition("player")
				local mapID = C_Map.GetBestMapForUnit("player")
				DBM:AddMsg(("Location Information\nYou are at zone %u (%s).\nLocal Map ID %u (%s)"):format(map, GetRealZoneText(map), mapID, GetZoneText()))
			else
				local x, y, _, map = UnitPosition("player")
				local mapID, mapx, mapy
				mapID = C_Map.GetBestMapForUnit("player")
				local tempTable = C_Map.GetPlayerMapPosition(mapID, "player")
				mapx, mapy = tempTable.x, tempTable.y
				DBM:AddMsg(("Location Information\nYou are at zone %u (%s): x=%f, y=%f.\nLocal Map ID %u (%s): x=%f, y=%f"):format(map, GetRealZoneText(map), x, y, mapID, GetZoneText(), mapx, mapy))
			end
		elseif cmd:sub(1, 7) == "request" then
			DBM:Unschedule(DBM.RequestTimers)
			DBM:RequestTimers(1)
			DBM:RequestTimers(2)
			DBM:RequestTimers(3)
		elseif cmd:sub(1, 6) == "silent" then
			DBM.Options.SilentMode = DBM.Options.SilentMode == false and true or false
			DBM:AddMsg(L.SILENTMODE_IS .. (DBM.Options.SilentMode and "ON" or "OFF"))
		elseif cmd:sub(1, 10) == "musicstart" then
			DBM:TransitionToDungeonBGM(true)
		elseif cmd:sub(1, 9) == "musicstop" then
			DBM:TransitionToDungeonBGM(false, true)
		elseif cmd:sub(1, 9) == "infoframe" then
			if DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Hide()
			else
				DBM.InfoFrame:Show(5, "test")
			end
		elseif cmd:sub(1, 10) == "aggroframe" then
			if DBM.InfoFrame:IsShown() then
				DBM.InfoFrame:Hide()
			else
				DBM.InfoFrame:SetHeader(L.INFOFRAME_AGGRO)
				DBM.InfoFrame:Show(7, "playeraggro", 1)
			end
		else
			DBM:LoadGUI()
		end
	end
end

do
	local function updateRangeFrame(r, reverse)
		if DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Hide(true)
		else
			if DBM:HasMapRestrictions() then
				DBM:AddMsg(L.NO_RANGE)
			elseif IsInInstance() then
				DBM:AddMsg(L.NO_RANGE_SOON)
			end
			if r and (r < 201) then
				DBM.RangeCheck:Show(r, nil, true, nil, reverse)
			else
				DBM.RangeCheck:Show(10, nil, true, nil, reverse)
			end
		end
	end
	SLASH_DBMRANGE1 = "/range"
	SLASH_DBMRANGE2 = "/distance"
	SLASH_DBMHUDAR1 = "/hudar"
	SLASH_DBMRRANGE1 = "/rrange"
	SLASH_DBMRRANGE2 = "/rdistance"
	SlashCmdList["DBMRANGE"] = function(msg)
		local r = tonumber(msg) or 10
		updateRangeFrame(r, false)
	end
	SlashCmdList["DBMHUDAR"] = function(msg)
		local r = tonumber(msg) or 10
		DBM.HudMap:ToggleHudar(r)
	end
	SlashCmdList["DBMRRANGE"] = function(msg)
		local r = tonumber(msg) or 10
		updateRangeFrame(r, true)
	end
end

do
	local sortMe = {}
	local OutdatedUsers = {}

	local function sort(v1, v2)
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
		for _, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		twipe(OutdatedUsers)
		self:AddMsg(L.VERSIONCHECK_HEADER)
		for _, v in ipairs(sortMe) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.displayVersion and not v.bwversion then--DBM, no BigWigs
				if self.Options.ShowAllVersions then
					self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.DBM.." "..v.displayVersion, showRealDate(v.revision), v.VPVersion or ""), false)--Only display VP version if not running two mods
				end
				if notify and v.revision < self.ReleaseRevision then
					SendChatMessage(chatPrefixShort..L.YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
				end
			elseif self.Options.ShowAllVersions and v.displayVersion and v.bwversion then--DBM & BigWigs
				self:AddMsg(L.VERSIONCHECK_ENTRY_TWO:format(name, L.DBM.." "..v.displayVersion, showRealDate(v.revision), L.BIG_WIGS, bwVersionResponseString:format(v.bwversion, v.bwhash)), false)
			elseif self.Options.ShowAllVersions and not v.displayVersion and v.bwversion then--BigWigs, No DBM
				self:AddMsg(L.VERSIONCHECK_ENTRY:format(name, L.BIG_WIGS, bwVersionResponseString:format(v.bwversion, v.bwhash), ""), false)
			else
				if self.Options.ShowAllVersions then
					self:AddMsg(L.VERSIONCHECK_ENTRY_NO_DBM:format(name), false)
				end
			end
		end
		local TotalUsers = #sortMe
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
				tinsert(OutdatedUsers, name)
			end
		end
		local TotalDBM = TotalUsers - NoDBM
		local TotalBW = TotalUsers - NoBigwigs
		self:AddMsg("---", false)
		self:AddMsg(L.VERSIONCHECK_FOOTER:format(TotalDBM, TotalBW), false)
		self:AddMsg(L.VERSIONCHECK_OUTDATED:format(OldMod, #OutdatedUsers > 0 and tconcat(OutdatedUsers, ", ") or NONE), false)
		twipe(OutdatedUsers)
		twipe(sortMe)
		for i = #sortMe, 1, -1 do
			sortMe[i] = nil
		end
	end
end


-- Lag checking
do
	local sortLag = {}
	local nolagResponse = {}
	local function sortit(v1, v2)
		return (v1.worldlag or 0) < (v2.worldlag or 0)
	end
	function DBM:ShowLag()
		for _, v in pairs(raid) do
			tinsert(sortLag, v)
		end
		tsort(sortLag, sortit)
		self:AddMsg(L.LAG_HEADER)
		for _, v in ipairs(sortLag) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.worldlag then
				self:AddMsg(L.LAG_ENTRY:format(name, v.worldlag, v.homelag), false)
			else
				tinsert(nolagResponse, v.name)
			end
		end
		if #nolagResponse > 0 then
			self:AddMsg(L.LAG_FOOTER:format(tconcat(nolagResponse, ", ")), false)
			for i = #nolagResponse, 1, -1 do
				nolagResponse[i] = nil
			end
		end
		for i = #sortLag, 1, -1 do
			sortLag[i] = nil
		end
	end
	if LL then
		LL:Register("DBM", function(homelag, worldlag, sender, channel)
			if sender and raid[sender] then
				raid[sender].homelag = homelag
				raid[sender].worldlag = worldlag
			end
		end)
	end

end

-- Durability checking
do
	local sortDur = {}
	local nodurResponse = {}
	local function sortit(v1, v2)
		return (v1.worldlag or 0) < (v2.worldlag or 0)
	end
	function DBM:ShowDurability()
		for _, v in pairs(raid) do
			tinsert(sortDur, v)
		end
		tsort(sortDur, sortit)
		self:AddMsg(L.DUR_HEADER)
		for _, v in ipairs(sortDur) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.durpercent then
				self:AddMsg(L.DUR_ENTRY:format(name, v.durpercent, v.durbroken), false)
			else
				tinsert(nodurResponse, v.name)
			end
		end
		if #nodurResponse > 0 then
			self:AddMsg(L.LAG_FOOTER:format(tconcat(nodurResponse, ", ")), false)
			for i = #nodurResponse, 1, -1 do
				nodurResponse[i] = nil
			end
		end
		for i = #sortDur, 1, -1 do
			sortDur[i] = nil
		end
	end
	if LD then
		LD:Register("DBM", function(percent, broken, sender, channel)
			if sender and raid[sender] then
				raid[sender].durpercent = percent
				raid[sender].durbroken = broken
			end
		end)
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
	function DBM:CreatePizzaTimer(time, text, broadcast, sender, loop, terminate)
		if terminate or time == 0 then
			self:Unschedule(loopTimer)
			self.Bars:CancelBar(text)
			fireEvent("DBM_TimerStop", "DBMPizzaTimer")
			return
		end
		if sender and ignore[sender] then return end
		text = text:sub(1, 16)
		text = text:gsub("%%t", UnitName("target") or "<no target>")
		if time < 3 then
			self:AddMsg(L.PIZZA_ERROR_USAGE)
			return
		end
		self.Bars:CreateBar(time, text, 237538)
		fireEvent("DBM_TimerStart", "DBMPizzaTimer", text, time, "237538", "pizzatimer", nil, 0)
		if broadcast then
			sendLoggedSync("U", ("%s\t%s"):format(time, text))
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

------------------
--  Hyperlinks  --
------------------
do
	local ignore, cancel
	local popuplevel = 0
	local function showPopupConfirmIgnore(ignore, cancel)
		local popup = CreateFrame("Frame", "DBMHyperLinks", UIParent, DBM:IsShadowlands() and "BackdropTemplate")
		popup.backdropInfo = {
			bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", -- 312922
			edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
			tile		= true,
			tileSize	= 16,
			edgeSize	= 16,
			insets		= { left = 1, right = 1, top = 1, bottom = 1 }
		}
		if not DBM:IsShadowlands() then
			popup:SetBackdrop(popup.backdropInfo)
		else
			popup:ApplyBackdrop()
		end
		popup:SetSize(500, 80)
		popup:SetPoint("TOP", UIParent, "TOP", 0, -200)
		popup:SetFrameStrata("DIALOG")
		popup:SetFrameLevel(popuplevel)
		popuplevel = popuplevel + 1

		local text = popup:CreateFontString()
		text:SetFontObject(ChatFontNormal)
		text:SetWidth(470)
		text:SetWordWrap(true)
		text:SetPoint("TOP", popup, "TOP", 0, -15)
		text:SetText(L.PIZZA_CONFIRM_IGNORE:format(ignore))

		local accept = CreateFrame("Button", nil, popup)
		accept:SetNormalTexture(130763)--"Interface\\Buttons\\UI-DialogBox-Button-Up"
		accept:SetPushedTexture(130761)--"Interface\\Buttons\\UI-DialogBox-Button-Down"
		accept:SetHighlightTexture(130762, "ADD")--"Interface\\Buttons\\UI-DialogBox-Button-Highlight"
		accept:SetSize(128, 35)
		accept:SetPoint("BOTTOM", popup, "BOTTOM", -75, 0)
		accept:SetScript("OnClick", function(f) DBM:AddToPizzaIgnore(ignore) DBM.Bars:CancelBar(cancel) f:GetParent():Hide() end)

		local atext = accept:CreateFontString()
		atext:SetFontObject(ChatFontNormal)
		atext:SetPoint("CENTER", accept, "CENTER", 0, 5)
		atext:SetText(YES)

		local decline = CreateFrame("Button", nil, popup)
		decline:SetNormalTexture(130763)--"Interface\\Buttons\\UI-DialogBox-Button-Up"
		decline:SetPushedTexture(130761)--"Interface\\Buttons\\UI-DialogBox-Button-Down"
		decline:SetHighlightTexture(130762, "ADD")--"Interface\\Buttons\\UI-DialogBox-Button-Highlight"
		decline:SetSize(128, 35)
		decline:SetPoint("BOTTOM", popup, "BOTTOM", 75, 0)
		decline:SetScript("OnClick", function(f) f:GetParent():Hide() end)

		local dtext = decline:CreateFontString()
		dtext:SetFontObject(ChatFontNormal)
		dtext:SetPoint("CENTER", decline, "CENTER", 0, 5)
		dtext:SetText(NO)
		PlaySound(850)
	end

	local function linkHook(self, link, string, button, ...)
		local linkType, arg1, arg2, arg3, arg4, arg5, arg6 = strsplit(":", link)
		if linkType ~= "DBM" then
			return
		end
		if arg1 == "cancel" then
			DBM.Bars:CancelBar(link:match("DBM:cancel:(.+):nil$"))
		elseif arg1 == "ignore" then
			cancel = link:match("DBM:ignore:(.+):[^%s:]+$")
			ignore = link:match(":([^:]+)$")
			showPopupConfirmIgnore(ignore, cancel)
		elseif arg1 == "update" then
			DBM:ShowUpdateReminder(arg2, arg3) -- displayVersion, revision
--		elseif arg1 == "forumsnews" then
--			DBM:ShowUpdateReminder(nil, nil, DBM_FORUMS_COPY_URL_DIALOG_NEWS, "https://discord.gg/DF5mffk")
--		elseif arg1 == "forums" then
--			DBM:ShowUpdateReminder(nil, nil, DBM_FORUMS_COPY_URL_DIALOG)
		elseif arg1 == "showRaidIdResults" then
			DBM:ShowRaidIDRequestResults()
		elseif arg1 == "noteshare" then
			local mod = DBM:GetModByName(arg2 or "")
			if mod then
				DBM:ShowNoteEditor(mod, arg3, arg4, arg5, arg6)--modvar, ability, text, sender
			else--Should not happen, since mod was verified before getting this far, but just in case
				DBM:Debug("Bad note share, mod not valid")
			end
		end
	end
--	local frame = _G[tostring(DBM.Options.ChatFrame)]
--	frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
	DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", linkHook) -- handles the weird case that the default chat frame is not one of the normal chat frames (3rd party chat frames or whatever causes this)
	local i = 1
	while _G["ChatFrame" .. i] do
		if _G["ChatFrame" .. i] ~= DEFAULT_CHAT_FRAME then
			_G["ChatFrame" .. i]:HookScript("OnHyperlinkClick", linkHook)
		end
		i = i + 1
	end
end

do
	local old = ItemRefTooltip.SetHyperlink -- we have to hook this function since the default ChatFrame code assumes that all links except for player and channel links are valid arguments for this function
	function ItemRefTooltip:SetHyperlink(link, ...)
		if link and link:sub(0, 4) == "DBM:" then
			return
		end
		return old(self, link, ...)
	end
end

-----------------
--  GUI Stuff  --
-----------------
do
	local callOnLoad = {}
	function DBM:LoadGUI()
		if GetAddOnEnableState(playerName, "VEM-Core") >= 1 then
			self:AddMsg(L.VEM)
			return
		end
		if GetAddOnEnableState(playerName, "DBM-Profiles") >= 1 then
			self:AddMsg(L.OUTDATEDPROFILES)
			return
		end
		if GetAddOnEnableState(playerName, "DBM-SpellTimers") >= 1 then
			local version = GetAddOnMetadata("DBM-SpellTimers", "Version") or "r0"
			version = tonumber(string.sub(version, 2, 4)) or 0
			if version < 122 and not self.Options.DebugMode then
				self:AddMsg(L.OUTDATEDSPELLTIMERS)
				return
			end
		end
		if GetAddOnEnableState(playerName, "DBM-RaidLeadTools") >= 1 and not self.Options.DebugMode then
			self:AddMsg(L.OUTDATEDRLT)
			return
		end
		if GetAddOnEnableState(playerName, "DPMCore") >= 1 then
			self:AddMsg(L.DPMCORE)
			return
		end
		if GetAddOnEnableState(playerName, "DBM-VictorySound") >= 1 then
			self:AddMsg(L.VICTORYSOUND)
			return
		end
		if not dbmIsEnabled then
			self:AddMsg(L.UPDATEREMINDER_DISABLE)
			return
		end
		if self.NewerVersion and showConstantReminder >= 1 then
			AddMsg(self, L.UPDATEREMINDER_HEADER:format(self.NewerVersion, showRealDate(self.HighestRelease)))
		end
		local firstLoad = false
		if not IsAddOnLoaded("DBM-GUI") then
			local enabled = GetAddOnEnableState(playerName, "DBM-GUI")
			if enabled == 0 then
				EnableAddOn("DBM-GUI")
			end
			local loaded, reason = LoadAddOn("DBM-GUI")
			if not loaded then
				if reason then
					self:AddMsg(L.LOAD_GUI_ERROR:format(tostring(_G["ADDON_"..reason or ""])))
				else
					self:AddMsg(L.LOAD_GUI_ERROR:format(L.UNKNOWN))
				end
				return false
			end
			if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
				collectgarbage("collect")
			end
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


----------------------
--  Minimap Button  --
----------------------
do
	--Old LDB Functions
	local frame = CreateFrame("Frame", "DBMLDBFrame")

	--New LDB Object
	if LibStub("LibDataBroker-1.1", true) then
		dataBroker = LibStub("LibDataBroker-1.1"):NewDataObject("DBM",
			{type = "launcher", label = "DBM", icon = "Interface\\AddOns\\DBM-Core\\textures\\dbm_airhorn"}
		)

		function dataBroker.OnClick(self, button)
			if IsShiftKeyDown() then return end
--			if IsAltKeyDown() and button == "RightButton" then
--				DBM.Options.SilentMode = DBM.Options.SilentMode == false and true or false
--				DBM:AddMsg(L.SILENTMODE_IS .. (DBM.Options.SilentMode and "ON" or "OFF"))
--			else
				DBM:LoadGUI()
--			end
		end

		function dataBroker.OnTooltipShow(GameTooltip)
			GameTooltip:SetText(L.MINIMAP_TOOLTIP_HEADER, 1, 1, 1)
			GameTooltip:AddLine(("%s (%s)"):format(DBM.DisplayVersion, showRealDate(DBM.Revision)), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(L.MINIMAP_TOOLTIP_FOOTER, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b, 1)
			GameTooltip:AddLine(L.LDB_TOOLTIP_HELP1, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
--			GameTooltip:AddLine(L.LDB_TOOLTIP_HELP2, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
		end
	end

	function DBM:ToggleMinimapButton()
		DBM_MinimapIcon.hide = not DBM_MinimapIcon.hide
		if DBM_MinimapIcon.hide then
			LibStub("LibDBIcon-1.0"):Hide("DBM")
		else
			LibStub("LibDBIcon-1.0"):Show("DBM")
		end
	end
end

-------------------------------------------------
--  Raid/Party Handling and Unit ID Utilities  --
-------------------------------------------------
do
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
				inRaid = true
				sendSync("H")
				SendAddonMessage("BigWigs", bwVersionQueryString:format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
				self:Schedule(2, self.RoleCheck, false, self)
				fireEvent("DBM_raidJoin", playerName)
				local bigWigs = _G["BigWigs"]
				if bigWigs and bigWigs.db.profile.raidicon and not self.Options.DontSetIcons and self:GetRaidRank() > 0 then--Both DBM and bigwigs have raid icon marking turned on.
					self:AddMsg(L.BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either or turned off to stop this alert)
				end
			end
			for i = 1, GetNumGroupMembers() do
				local name, rank, subgroup, _, _, className = GetRaidRosterInfo(i)
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
					raidGuids[UnitGUID(id) or ""] = name
				end
			end
			DBM.enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					fireEvent("DBM_raidLeave", i)
				else
					v.updated = nil
					if v.revision and v.rank > 0 and (v.enabledIcons or "") == "true" then
						iconSeter[#iconSeter + 1] = v.revision.." "..v.name
					end
				end
			end
			if #iconSeter > 0 then
				tsort(iconSeter, function(a, b) return a > b end)
				local elected = iconSeter[1]
				if playerName == elected:sub(elected:find(" ") + 1) then
					DBM.enableIcons = true
				end
			end
		elseif IsInGroup() then
			if not inRaid then
				-- joined a new party
				inRaid = true
				sendSync("H")
				SendAddonMessage("BigWigs", bwVersionQueryString:format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
				self:Schedule(2, self.RoleCheck, false, self)
				fireEvent("DBM_partyJoin", playerName)
			end
			for i = 0, GetNumSubgroupMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party"..i
				end
				local name = GetUnitName(id, true)
				local shortname = UnitName(id)
				local rank = UnitIsGroupLeader(id) and 2 or 0
				local _, className = UnitClass(id)
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
				raidGuids[UnitGUID(id) or ""] = name
			end
			DBM.enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					fireEvent("DBM_partyLeave", i)
				else
					v.updated = nil
					if v.revision and v.rank > 0 and (v.enabledIcons or "") == "true" then
						iconSeter[#iconSeter + 1] = v.revision.." "..v.name
					end
				end
			end
			if #iconSeter > 0 then
				tsort(iconSeter, function(a, b) return a > b end)
				local elected = iconSeter[1]
				if playerName == elected:sub(elected:find(" ") + 1) then
					DBM.enableIcons = true
				end
			end
		else
			-- left the current group/raid
			inRaid = false
			DBM.enableIcons = true
			fireEvent("DBM_raidLeave", playerName)
			twipe(raid)
			twipe(newerVersionPerson)
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
		end
	end

	function DBM:GROUP_ROSTER_UPDATE(force)
		self:Unschedule(updateAllRoster)
		if force then
			updateAllRoster(self)
		else
			self:Schedule(1.5, updateAllRoster, self)
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
		local _, _, _, currentMapId = UnitPosition("player")
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				local _, _, _, targetMapId = UnitPosition("raid"..i)
				if targetMapId == currentMapId then
					total = total + 1
				end
			end
		else
			total = 1--add player/self for "party" count
			for i = 1, GetNumSubgroupMembers() do
				local _, _, _, targetMapId = UnitPosition("party"..i)
				if targetMapId == currentMapId then
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

	function DBM:GetRaidUnit(name)
		return raid[name] and raid[name]
	end

	function DBM:GetRaidSubgroup(name)
		return (raid[name] and raid[name].subgroup) or 0
	end

	function DBM:GetRaidClass(name)
		return (raid[name] and raid[name].class) or "UNKNOWN"
	end

	function DBM:GetRaidUnitId(name)
		for i = 1, 5 do
			local unitId = "boss"..i
			local bossName = UnitName(unitId)
			if bossName and bossName == name then
				return unitId
			end
		end
		return raid[name] and raid[name].id
	end

	function DBM:GetEnemyUnitIdByGUID(guid)
		for i = 1, 5 do
			local unitId = "boss"..i
			local guid2 = UnitGUID(unitId)
			if guid == guid2 then
				return unitId
			end
		end
		local idType = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local guid2 = UnitGUID(unitId)
			if guid == guid2 then
				return unitId
			end
		end
		return L.UNKNOWN
	end

	function DBM:GetPlayerGUIDByName(name)
		return raid[name] and raid[name].guid
	end

	function DBM:GetMyPlayerInfo()
		return playerName, playerLevel, playerRealm
	end

	--Intentionally grabs server name at all times, usually to make sure warning/infoframe target info can name match the combat log in the table
	function DBM:GetUnitFullName(uId)
		if not uId then return nil end
		return GetUnitName(uId, true)
	end

	--Shortens name but custom so we add * to off realmers instead of stripping it entirely like Ambiguate does
	--Technically GetUnitName without "true" can be used to shorten name to "name (*)" but "name*" is even shorter which is why we do this
	function DBM:GetShortServerName(name)
		if not self.Options.StripServerName then return name end--If strip is disabled, just return name
		local shortName, serverName = string.split("-", name)
		if serverName and serverName ~= playerRealm then
			return shortName.."*"
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

	function DBM:GetGroupId(name)
		local raidMember = raid[name] or raid[GetUnitName(name, true) or ""]
		return raidMember and raidMember.groupId or 0
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
	local _, _, _, currentMapId = UnitPosition("player")
	local realGroupMembers = 0
	if IsInGroup() then
		for uId in self:GetGroupMembers() do
			local _, _, _, targetMapId = UnitPosition(uId)
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
	local guid = UnitGUID(uId)
	return self:GetCIDFromGUID(guid)
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
	if type(guid) == "number" then return false end
	local guidType = strsplit("-", guid or "")
	if guidType and (guidType == "Creature" or guidType == "Vehicle" or guidType == "NPC") then--To determine, add pet or not?
		return true
	end
	return false
end

function DBM:IsCreatureGUID(guid)
	local guidType = strsplit("-", guid or "")
	if guidType and (guidType == "Creature" or guidType == "Vehicle") then--To determine, add pet or not?
		return true
	end
	return false
end

function DBM:GetBossUnitId(name, bossOnly)--Deprecated, only old mods use this
	local returnUnitID
	for i = 1, 5 do
		if UnitName("boss" .. i) == name then
			returnUnitID = "boss"..i
		end
	end
	if not returnUnitID and not bossOnly then
		for uId in self:GetGroupMembers() do
			if UnitName(uId .. "target") == name and not UnitIsPlayer(uId .. "target") then
				returnUnitID = uId.."target"
			end
		end
	end
	return returnUnitID
end

function DBM:GetUnitIdFromGUID(cidOrGuid, bossOnly)
	local returnUnitID
	for i = 1, 5 do
		local unitId = "boss"..i
		local bossGUID = UnitGUID(unitId)
		if type(cidOrGuid) == "number" then--CID passed
			local cid = self:GetCIDFromGUID(bossGUID)
			if cid == cidOrGuid then
				returnUnitID = unitId
			end
		else--GUID passed
			if bossGUID == cidOrGuid then
				returnUnitID = unitId
			end
		end
	end
	--Didn't find valid unitID from boss units, scan raid targets
	if not returnUnitID and not bossOnly then
		for uId in DBM:GetGroupMembers() do--Do not use self on this function, because self might be bossModPrototype
			local unitId = uId .. "target"
			local bossGUID = UnitGUID(unitId)
			local cid = self:GetCIDFromGUID(cidOrGuid)
			if bossGUID == cidOrGuid or cid == cidOrGuid then
				returnUnitID = unitId
			end
		end
	end
	return returnUnitID
end

function DBM:CheckNearby(range, targetname)
	if not targetname and DBM.RangeCheck:GetDistanceAll(range) then--Do not use self on this function, because self might be bossModPrototype
		return true--No target name means check if anyone is near self, period
	else
		local uId = DBM:GetRaidUnitId(targetname)--Do not use self on this function, because self might be bossModPrototype
		if uId and not UnitIsUnit("player", uId) then
			local inRange = DBM.RangeCheck:GetDistance(uId)--Do not use self on this function, because self might be bossModPrototype
			if inRange and inRange < range+0.5 then
				return true
			end
		end
	end
	return false
end

function DBM:IsTrivial(customLevel)
	--if timewalking or chromie time, it's always non trivial content
	if C_PlayerInfo.IsPlayerInChromieTime() or difficultyIndex == 24 or difficultyIndex == 33 then
		return false
	end
	--if custom level passed, we always hard check that level for trivial vs non trivial
	if customLevel then--Custom level parameter
		if playerLevel >= customLevel then
			return true
		end
	else
		--First, auto bail and return non trivial if it's an instancce not in table to prevent nil error
		if not instanceDifficultyBylevel[LastInstanceMapID] then return false end
		--Content is trivial if player level is 10 higher than content involved
		if playerLevel >= (instanceDifficultyBylevel[LastInstanceMapID][1]+10) then
			return true
		end
	end
	return false
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

function DBM:LoadModOptions(modId, inCombat, first)
	local oldSavedVarsName = modId:gsub("-", "").."_SavedVars"
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local savedStatsName = modId:gsub("-", "").."_SavedStats"
	local fullname = playerName.."-"..playerRealm
	if not DBM.currentSpecID or not currentSpecGroup then
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
			self:Debug("LoadModOptions: No saved options, creating defaults for profile "..profileNum, 2)
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
						self:Debug("|cffff0000Everybody knows shit's fucked: |r"..option)
					end
					if (mod.DefaultOptions[option] == nil) and not (option:find("talent") or option:find("FastestClear") or option:find("CVAR") or option:find("RestoreSetting")) then
						savedOptions[id][profileNum][option] = nil
					elseif mod.DefaultOptions[option] and (type(mod.DefaultOptions[option]) == "table") then--recover broken dropdown option
						if savedOptions[id][profileNum][option] and (type(savedOptions[id][profileNum][option]) == "boolean") then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option].value
						end
					--Fix default options for colored bar by type that were set to 0 because no defaults existed at time they were created, but do now.
					elseif option:find("TColor") then
						if savedOptions[id][profileNum][option] and savedOptions[id][profileNum][option] == 0 and mod.DefaultOptions[option] and mod.DefaultOptions[option] ~= 0 then
							savedOptions[id][profileNum][option] = mod.DefaultOptions[option]
							self:Debug("Migrated "..option.." to option defaults")
						end
					--Fix options for custom special warning sounds not in addons folder that are not using soundkit IDs
					elseif option:find("SWSound") then
						if savedOptions[id][profileNum][option] and (type(savedOptions[id][profileNum][option]) == "string") and (savedOptions[id][profileNum][option] ~= "") and (savedOptions[id][profileNum][option] ~= "None") then
							local searchMsg = (savedOptions[id][profileNum][option]):lower()
							if not searchMsg:find("addons") then
								savedOptions[id][profileNum][option] = mod.DefaultOptions[option]
								self:Debug("Migrated "..option.." to option defaults")
							end
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
			if not existId[id] and not (id:find("talent") or id:find("FastestClear") or id:find("CVAR") or id:find("RestoreSetting")) then
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
		_G[savedVarsName][fullname]["talent"..profileNum] = currentSpecName
		self:Debug("LoadModOptions: Finished loading "..(_G[savedVarsName][fullname]["talent"..profileNum] or L.UNKNOWN))
	end
	_G[savedStatsName] = savedStats
	local optionsFrame = _G["DBM_GUI_OptionsFrame"]
	if not first and DBM_GUI and DBM_GUI.currentViewing and optionsFrame:IsShown() then
		optionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
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
		self:PLAYER_SPECIALIZATION_CHANGED()
	end
end

function DBM:LoadAllModDefaultOption(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- prevent error
	if not DBM.currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local fullname = playerName.."-"..playerRealm
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
	if not DBM.currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = (mod.modId):gsub("-", "").."_AllSavedVars"
	local fullname = playerName.."-"..playerRealm
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
	if not DBM.currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local targetName = playerName.."-"..playerRealm
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
		_G[savedVarsName][targetName][id][targetProfile] = {}--clear before copy
		_G[savedVarsName][targetName][id][targetProfile] = _G[savedVarsName][sourceName][id][sourceProfile]
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
		_G[savedVarsName][targetName]["talent"..targetProfile] = currentSpecName
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
	if not DBM.currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local targetName = playerName.."-"..playerRealm
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
		_G[savedVarsName][targetName]["talent"..targetProfile] = currentSpecName
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
	if not DBM.currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local fullname = playerName.."-"..playerRealm
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
	_G[savedVarsName][name]["talent"..profile] = nil
	self:AddMsg(L.MPROFILE_DELETE_SUCCESS:format(name, profile))
end

function DBM:ClearAllStats(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- variable init
	local savedStatsName = modId:gsub("-", "").."_SavedStats"
	-- prevent nil table error
	if not _G[savedStatsName] then _G[savedStatsName] = {} end
	for _, id in ipairs(self.ModLists[modId]) do
		local mod = self:GetModByName(id)
		-- prevent nil table error
		local defaultStats = {}
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
		dbmIsEnabled = true
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
		--Fix fonts if they are nil or set to any of standard font values
		if not self.Options.WarningFont or (self.Options.WarningFont == "Fonts\\2002.TTF" or self.Options.WarningFont == "Fonts\\ARKai_T.ttf" or self.Options.WarningFont == "Fonts\\blei00d.TTF" or self.Options.WarningFont == "Fonts\\FRIZQT___CYR.TTF" or self.Options.WarningFont == "Fonts\\FRIZQT__.TTF") then
			self.Options.WarningFont = "standardFont"
		end
		if not self.Options.SpecialWarningFont or (self.Options.SpecialWarningFont == "Fonts\\2002.TTF" or self.Options.SpecialWarningFont == "Fonts\\ARKai_T.ttf" or self.Options.SpecialWarningFont == "Fonts\\blei00d.TTF" or self.Options.SpecialWarningFont == "Fonts\\FRIZQT___CYR.TTF" or self.Options.SpecialWarningFont == "Fonts\\FRIZQT__.TTF") then
			self.Options.SpecialWarningFont = "standardFont"
		end
		if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then return end--Don't do sound migration in a situation user is loading wrong DBM version, to avoid sound path corruption
		--Migrate user sound options to soundkit Ids if selected media doesn't exist in Interface\\AddOns
		--This will in the short term, screw with people trying to use LibSharedMedia sound files on 8.1.5 until LSM has migrated as well.
		local migrated = false
		if type(self.Options.RaidWarningSound) == "string" and self.Options.RaidWarningSound ~= "" then
			local searchMsg = self.Options.RaidWarningSound:lower()
			if not searchMsg:find("addons") or searchMsg:find("classicsupport") then
				self.Options.RaidWarningSound = self.DefaultOptions.RaidWarningSound
				migrated = true
			end
		end
		if type(self.Options.SpecialWarningSound) == "string" and self.Options.SpecialWarningSound ~= "" then
			local searchMsg = self.Options.SpecialWarningSound:lower()
			if not searchMsg:find("addons") or searchMsg:find("classicsupport") then
				self.Options.SpecialWarningSound = self.DefaultOptions.SpecialWarningSound
				migrated = true
			end
		end
		if type(self.Options.SpecialWarningSound2) == "string" and self.Options.SpecialWarningSound2 ~= "" then
			local searchMsg = self.Options.SpecialWarningSound2:lower()
			if not searchMsg:find("addons") or searchMsg:find("classicsupport") then
				self.Options.SpecialWarningSound2 = self.DefaultOptions.SpecialWarningSound2
				migrated = true
			end
		end
		if type(self.Options.SpecialWarningSound3) == "string" and self.Options.SpecialWarningSound3 ~= "" then
			local searchMsg = self.Options.SpecialWarningSound3:lower()
			if not searchMsg:find("addons") or searchMsg:find("classicsupport") then
				self.Options.SpecialWarningSound3 = self.DefaultOptions.SpecialWarningSound3
				migrated = true
			end
		end
		if type(self.Options.SpecialWarningSound4) == "string" and self.Options.SpecialWarningSound4 ~= "" then
			local searchMsg = self.Options.SpecialWarningSound4:lower()
			if not searchMsg:find("addons") or searchMsg:find("classicsupport") then
				self.Options.SpecialWarningSound4 = self.DefaultOptions.SpecialWarningSound4
				migrated = true
			end
		end
		if type(self.Options.SpecialWarningSound5) == "string" and self.Options.SpecialWarningSound5 ~= "" then
			local searchMsg = self.Options.SpecialWarningSound5:lower()
			if not searchMsg:find("addons") or searchMsg:find("classicsupport") then
				self.Options.SpecialWarningSound5 = self.DefaultOptions.SpecialWarningSound5
				migrated = true
			end
		end
		if migrated then
			self:AddMsg(L.SOUNDKIT_MIGRATION)
		end
		--TODO, why doesn't DBM core garbage collection options like sub mods do?
		--If deleted unused option check code does get added though it needs excemption from anything comtaining text "RestoreSetting"
	end
end

do
	local lastLFGAlert = 0
	function DBM:LFG_ROLE_CHECK_SHOW()
		if not UnitIsGroupLeader("player") and self.Options.LFDEnhance and GetTime() - lastLFGAlert > 5 then
			self:FlashClientIcon()
			self:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
			lastLFGAlert = GetTime()
		end
	end
end

function DBM:LFG_PROPOSAL_SHOW()
	if self.Options.ShowQueuePop and not self.Options.DontShowBossTimers then
		self.Bars:CreateBar(40, L.LFG_INVITE, 237538)
		fireEvent("DBM_TimerStart", "DBMLFGTimer", L.LFG_INVITE, 40, "237538", "extratimer", nil, 0)
	end
	if self.Options.LFDEnhance then
		self:FlashClientIcon()
		self:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
	end
end

function DBM:LFG_PROPOSAL_FAILED()
	self.Bars:CancelBar(L.LFG_INVITE)
	fireEvent("DBM_TimerStop", "DBMLFGTimer")
end

function DBM:LFG_PROPOSAL_SUCCEEDED()
	self.Bars:CancelBar(L.LFG_INVITE)
	fireEvent("DBM_TimerStop", "DBMLFGTimer")
end

function DBM:READY_CHECK()
	if self.Options.RLReadyCheckSound then--readycheck sound, if ora3 not installed (bad to have 2 mods do it)
		self:FlashClientIcon()
		if not BINDING_HEADER_oRA3 then
			DBM:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
		end
	end
	self:TransitionToDungeonBGM(false, true)
	self:Schedule(4, self.TransitionToDungeonBGM, self)
end

function DBM:PLAYER_SPECIALIZATION_CHANGED()
	local lastSpecID = DBM.currentSpecID
	self:SetCurrentSpecInfo()
	if DBM.currentSpecID ~= lastSpecID then--Don't fire specchanged unless spec actually has changed.
		self:SpecChanged()
		if IsInGroup() then
			self:RoleCheck(false)
		end
	end
end

do
	local function AcceptPartyInvite()
		AcceptGroup()
		for i=1, STATICPOPUP_NUMDIALOGS do
			local whichDialog = _G["StaticPopup"..i].which
			if whichDialog == "PARTY_INVITE" or whichDialog == "PARTY_INVITE_XREALM" then
				_G["StaticPopup"..i].inviteAccepted = 1
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
			if self.Options.ShowQueuePop and not self.Options.DontShowBossTimers then
				queuedBattlefield[i] = select(2, GetBattlefieldStatus(i))
				local expiration = GetBattlefieldPortExpiration(queueID)
				local timerIcon = GetPlayerFactionGroup("player") == "Alliance" and 132486 or 132485
				self.Bars:CreateBar(expiration or 85, queuedBattlefield[i], timerIcon)
				self:FlashClientIcon()
				fireEvent("DBM_TimerStart", "DBMBFSTimer", queuedBattlefield[i], expiration or 85, tostring(timerIcon), "extratimer", nil, 0)
			end
			if self.Options.LFDEnhance then
				self:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
			end
		elseif queuedBattlefield[i] then
			self.Bars:CancelBar(queuedBattlefield[i])
			fireEvent("DBM_TimerStop", "DBMBFSTimer")
			queuedBattlefield[i] = nil
		end
	end
end

function DBM:SCENARIO_COMPLETED()
	if #inCombat > 0 and C_Scenario.IsInScenario() then
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if v.inScenario then
				self:EndCombat(v)
			end
		end
	end
end

--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
do
	local modAdvertisementShown = false
	local classicZones = {[509]=true,[531]=true,[469]=true,[409]=true}
	local bcZones = {[564]=true,[534]=true,[532]=true,[565]=true,[544]=true,[548]=true,[580]=true,[550]=true}
	local wrathZones = {[615]=true,[724]=true,[649]=true,[616]=true,[631]=true,[533]=true,[249]=true,[603]=true,[624]=true}
	local cataZones = {[757]=true,[671]=true,[669]=true,[967]=true,[720]=true,[951]=true,[754]=true}
	local mopZones = {[1009]=true,[1008]=true,[1136]=true,[996]=true,[1098]=true}
	local wodZones = {[1205]=true,[1448]=true,[1228]=true}
	local legionZones = {[1712]=true,[1520]=true,[1530]=true,[1676]=true,[1648]=true}
	local bfaZones = {[1861]=true,[2070]=true,[2096]=true,[2164]=true,[2217]=true}
	local challengeScenarios = {[1148]=true,[1698]=true,[1710]=true,[1703]=true,[1702]=true,[1684]=true,[1673]=true,[1616]=true,[2215]=true}
	local pvpZones = {[30]=true,[489]=true,[529]=true,[559]=true,[562]=true,[566]=true,[572]=true,[617]=true,[618]=true,[628]=true,[726]=true,[727]=true,[761]=true,[968]=true,[980]=true,[998]=true,[1105]=true,[1134]=true,[1681]=true,[1803]=true,[2107]=true,[2118]=true,[2177]=true,[2197]=true}
	local oldDungeons = {
		[48]=true,[230]=true,[429]=true,[389]=true,[34]=true,--Classic
		[540]=true,[558]=true,[556]=true,[555]=true,[542]=true,[546]=true,[545]=true,[547]=true,[553]=true,[554]=true,[552]=true,[557]=true,[269]=true,[560]=true,[543]=true,[585]=true,--BC
		[619]=true,[601]=true,[595]=true,[600]=true,[604]=true,[602]=true,[599]=true,[576]=true,[578]=true,[574]=true,[575]=true,[608]=true,[658]=true,[632]=true,[668]=true,[650]=true,--Wrath
		[755]=true,[645]=true,[36]=true,[670]=true,[644]=true,[33]=true,[643]=true,[725]=true,[657]=true,[309]=true,[859]=true,[568]=true,[938]=true,[940]=true,[939]=true,[646]=true,--Cata
		[960]=true,[961]=true,[959]=true,[962]=true,[994]=true,[1011]=true,[1007]=true,[1001]=true,[1004]=true,--MoP
		[1182]=true,[1175]=true,[1208]=true,[1195]=true,[1279]=true,[1176]=true,[1209]=true,[1358]=true,--WoD
		[1501]=true,[1466]=true,[1456]=true,[1477]=true,[1458]=true,[1516]=true,[1571]=true,[1492]=true,[1544]=true,[1493]=true,[1651]=true,[1677]=true,[1753]=true--Legion
		--[1763]=true,[1754]=true,[1762]=true,[1864]=true,[1822]=true,[1877]=true,[1594]=true,[1841]=true,[1771]=true,[1862]=true,[2097]=true--BfA Dungeons
	}
	--This never wants to spam you to use mods for trivial content you don't need mods for.
	--It's intended to suggest mods for content that's relevant to your level (TW, leveling up in dungeons, or even older raids you can't just shit on)
	function DBM:CheckAvailableMods()
		if _G["BigWigs"] or modAdvertisementShown then return end--If they are running two boss mods at once, lets assume they are only using DBM for a specific feature (such as brawlers) and not nag
		local timeWalking = C_PlayerInfo.IsPlayerInChromieTime() and true or difficultyIndex == 24 or difficultyIndex == 33 or false
		if oldDungeons[LastInstanceMapID] and (timeWalking or playerLevel < 50) and not GetAddOnInfo("DBM-Party-BC") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM Old Dungeon mods"))
			modAdvertisementShown = true
		elseif (classicZones[LastInstanceMapID] or bcZones[LastInstanceMapID]) and (timeWalking or playerLevel < 31) and not GetAddOnInfo("DBM-BlackTemple") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM BC/Vanilla mods"))
			modAdvertisementShown = true
		elseif wrathZones[LastInstanceMapID] and (timeWalking or playerLevel < 31) and not GetAddOnInfo("DBM-Ulduar") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM Wrath of the Lich King mods"))
			modAdvertisementShown = true
		elseif cataZones[LastInstanceMapID] and (timeWalking or playerLevel < 36) and not GetAddOnInfo("DBM-Firelands") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM Cataclysm mods"))
			modAdvertisementShown = true
		elseif mopZones[LastInstanceMapID] and (timeWalking or playerLevel < 36) and not GetAddOnInfo("DBM-SiegeOfOrgrimmarV2") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM Mists of Pandaria mods"))
			modAdvertisementShown = true
		elseif wodZones[LastInstanceMapID] and (timeWalking or playerLevel < 41) and not GetAddOnInfo("DBM-HellfireCitadel") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM Warlords of Draenor mods"))
			modAdvertisementShown = true
		elseif legionZones[LastInstanceMapID] and (timeWalking or playerLevel < 51) and not GetAddOnInfo("DBM-AntorusBurningThrone") then--Technically 45 level with quish, but because of tuning you need need mods even at 50
			AddMsg(self, L.MOD_AVAILABLE:format("DBM Legion mods"))
			modAdvertisementShown = true
--		elseif bfaZones[LastInstanceMapID] and (timeWalking or playerLevel < 61) and not GetAddOnInfo("DBM-Nyalotha") then--Technically 50, but tuning and huge loss of player power, zones are even HARDER at 60
--			AddMsg(self, L.MOD_AVAILABLE:format("DBM Battle for Azeroth mods"))
--			modAdvertisementShown = true
		elseif challengeScenarios[LastInstanceMapID] and not GetAddOnInfo("DBM-Challenges") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM-Challenges"))
			modAdvertisementShown = true
		elseif pvpZones[LastInstanceMapID] and not GetAddOnInfo("DBM-PvP") then
			AddMsg(self, L.MOD_AVAILABLE:format("DBM-PvP"))
			modAdvertisementShown = true
		end
	end
	function DBM:TransitionToDungeonBGM(force, cleanup)
		if cleanup then--Runs on zone change (first load delay) and combat end
			self:Unschedule(self.TransitionToDungeonBGM)
			if self.Options.RestoreSettingMusic then
				SetCVar("Sound_EnableMusic", self.Options.RestoreSettingMusic)
				self.Options.RestoreSettingMusic = nil
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
		fireEvent("DBM_MusicStart", "RaidOrDungeon")
		if self.Options.EventSoundDungeonBGM and self.Options.EventSoundDungeonBGM ~= "None" and self.Options.EventSoundDungeonBGM ~= "" and not (self.Options.EventDungMusicMythicFilter and (DBM.savedDifficulty == "mythic" or DBM.savedDifficulty == "challenge")) then
			if not self.Options.RestoreSettingMusic then
				self.Options.RestoreSettingMusic = tonumber(GetCVar("Sound_EnableMusic")) or 1
				if self.Options.RestoreSettingMusic == 0 then
					SetCVar("Sound_EnableMusic", 1)
				else
					self.Options.RestoreSettingMusic = nil--Don't actually need it
				end
			end
			local path = "MISSING"
			if self.Options.EventSoundDungeonBGM == "Random" then
				local usedTable = self.Options.EventSoundMusicCombined and DBM.Music or DBM.DungeonMusic
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
				self:Debug("Starting Dungeon music with file: "..path)
			end
		end
	end
	local function SecondaryLoadCheck(self)
		local _, instanceType, difficulty, _, _, _, _, mapID, instanceGroupSize = GetInstanceInfo()
		local currentDifficulty, currentDifficultyText = self:GetCurrentInstanceDifficulty()
		if currentDifficulty ~= DBM.savedDifficulty then
			DBM.savedDifficulty, difficultyText = currentDifficulty, currentDifficultyText
		end
		self:Debug("Instance Check fired with mapID "..mapID.." and difficulty "..difficulty, 2)
		if LastInstanceMapID == mapID then
			self:TransitionToDungeonBGM()
			self:Debug("No action taken because mapID hasn't changed since last check", 2)
			return
		end--ID hasn't changed, don't waste cpu doing anything else (example situation, porting into garrosh stage 4 is a loading screen)
		LastInstanceMapID = mapID
		LastGroupSize = instanceGroupSize
		difficultyIndex = difficulty
		if instanceType == "none" or C_Garrison:IsOnGarrisonMap() then
			LastInstanceType = "none"
			if not targetEventsRegistered then
				self:RegisterShortTermEvents("UPDATE_MOUSEOVER_UNIT")
				targetEventsRegistered = true
			end
		else
			LastInstanceType = instanceType
			if targetEventsRegistered then
				self:UnregisterShortTermEvents()
				targetEventsRegistered = false
			end
			if DBM.savedDifficulty == "worldboss" then
				for i = #inCombat, 1, -1 do
					self:EndCombat(inCombat[i], true)
				end
			end
		end
		-- LoadMod
		self:LoadModsOnDemand("mapId", mapID)
		if self.Options.ShowReminders then
			self:CheckAvailableMods()
		end
		if self:HasMapRestrictions() then
			self.Arrow:Hide()
			self.HudMap:Disable()
			if self.RangeCheck:IsRadarShown() then
				self.RangeCheck:Hide(true)
			end
		end
		-- Auto Logging for entire zone if record only bosses is off
		if not self.Options.RecordOnlyBosses then
			if LastInstanceType == "raid" or LastInstanceType == "party" then
				self:StartLogging(0, nil)
			else
				self:StopLogging()
			end
		end
	end
	--Faster and more accurate loading for instances, but useless outside of them
	function DBM:LOADING_SCREEN_DISABLED()
		self.Bars:CancelBar(L.LFG_INVITE)--Disable bar here since LFG_PROPOSAL_SUCCEEDED seems broken right now
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
			if self.RangeCheck:IsRadarShown() then
				self.RangeCheck:Hide(true)
			end
		end
	end

	function DBM:LOADING_SCREEN_ENABLED()
		--TimerTracker Cleanup, required to work around logic code blizzard put into TimerTracker for /countdown timers
		--TimerTracker is hard coded that if a type 3 timer exists, to give it prio over type 1 and type 2. This causes the M+ timer not to show, even if only like 0.01 sec was left on the /countdown
		--We want to avoid situations where players start a 10 second timer, but click keystone with fractions of a second left, preventing them from seeing the M+ timer
		if not DBM.Options.DontShowPTCountdownText then
			for _, tttimer in pairs(TimerTracker.timerList) do
				if tttimer.type == 3 and not tttimer.isFree then
					FreeTimerTrackerTimer(tttimer)
					break
				end
			end
		end
	end

	function DBM:LoadModsOnDemand(checkTable, checkValue)
		self:Debug("LoadModsOnDemand fired")
		for _, v in ipairs(self.AddOns) do
			local modTable = v[checkTable]
			local enabled = GetAddOnEnableState(playerName, v.modId)
			--self:Debug(v.modId.." is "..enabled, 2)
			if not IsAddOnLoaded(v.modId) and modTable and checkEntry(modTable, checkValue) then
				if enabled ~= 0 then
					self:LoadMod(v)
				else
					if self.Options.ShowReminders then
						self:AddMsg(L.LOAD_MOD_DISABLED:format(v.name))
					end
				end
			end
		end
		self:ScenarioCheck()--Do not filter. Because ScenarioCheck function includes filter.
	end
end

--Scenario mods
function DBM:ScenarioCheck()
	if dbmIsEnabled and DBM.combatInfo[LastInstanceMapID] then
		for _, v in ipairs(DBM.combatInfo[LastInstanceMapID]) do
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
	--Block loading world boss mods by zoneID, except if it's a heroic warfront
	if mod.isWorldBoss and not IsInInstance() and not force and difficultyIndex ~= 149 then
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
	if not DBM.currentSpecID then
		self:SetCurrentSpecInfo()
	end
	if not difficultyIndex then -- prevent error in EJ_SetDifficulty if not yet set
		DBM.savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
	end
	EJ_SetDifficulty(difficultyIndex)--Work around blizzard crash bug where other mods (like Boss) screw with Ej difficulty value, which makes EJ_GetSectionInfo crash the game when called with invalid difficulty index set.
	self:Debug("LoadAddOn should have fired for "..mod.name, 2)
	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		if reason then
			self:AddMsg(L.LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_"..reason or ""])))
		else
			self:Debug("LoadAddOn failed and did not give reason")
		end
		return false
	else
		self:Debug("LoadAddOn should have succeeded for "..mod.name, 2)
		self:AddMsg(L.LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		if self.NewerVersion and showConstantReminder >= 1 then
			AddMsg(self, L.UPDATEREMINDER_HEADER:format(self.NewerVersion, showRealDate(self.HighestRelease)))
		end
		self:LoadModOptions(mod.modId, InCombatLockdown(), true)
		if DBM_GUI then
			DBM_GUI:UpdateModList()
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
		if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
			collectgarbage("collect")
		end
		return true
	end
end

do
	local function loadModByUnit(uId)
		if not uId then
			uId = "mouseover"
		else
			uId = uId.."target"
		end
		if IsInInstance() or not UnitIsFriend("player", uId) and UnitIsDead("player") or UnitIsDead(uId) then return end--If you're in an instance no reason to waste cpu. If THE BOSS dead, no reason to load a mod for it. To prevent rare lua error, needed to filter on player dead.
		local guid = UnitGUID(uId)
		if guid and DBM:IsCreatureGUID(guid) then
			local cId = DBM:GetCIDFromGUID(guid)
			for bosscId, addon in pairs(loadcIds) do
				local enabled = GetAddOnEnableState(playerName, addon)
				if cId and bosscId and cId == bosscId and not IsAddOnLoaded(addon) and enabled ~= 0 then
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

	--Loading routeens hacks for world bosses based on target or mouseover.
	function DBM:UPDATE_MOUSEOVER_UNIT()
		loadModByUnit()
	end

	function DBM:UNIT_TARGET_UNFILTERED(uId)
		if targetEventsRegistered then--Allow outdoor mod loading
			loadModByUnit(uId)
		end
		--Debug options for seeing where BossUnitTargetScanner can be used.
		local transcriptor = _G["Transcriptor"]
		if (self.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging())) and uId:find("boss") then
			local targetName = UnitName(uId.."target") or "nil"
			self:Debug(uId.." changed targets to "..targetName)
		end
		--Active BossUnitTargetScanner
		if DBM.targetMonitor[uId] and UnitExists(uId.."target") and UnitPlayerOrPetInRaid(uId.."target") then
			self:Debug("targetMonitor for this unit exists, target exists", 2)
			local modId, returnFunc = DBM.targetMonitor[uId].modid, DBM.targetMonitor[uId].returnFunc
			self:Debug("targetMonitor: "..modId..", "..uId..", "..returnFunc, 2)
			if not DBM.targetMonitor[uId].allowTank then
				local tanking, status = UnitDetailedThreatSituation(uId, uId.."target")--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
				if tanking or (status == 3) then
					self:Debug("targetMonitor ending for unit without 'allowTank', ignoring target", 2)
					return
				end
			end
			local mod = self:GetModByName(modId)
			self:Debug("targetMonitor success for this unit, a valid target for returnFunc", 2)
			mod[returnFunc](mod, self:GetUnitFullName(uId.."target"), uId.."target", uId)--Return results to warning function with all variables.
			DBM.targetMonitor[uId] = nil
		end
	end
end

-----------------------------
--  Handle Incoming Syncs  --
-----------------------------

do
	local function checkForActualPull()
		if DBM.Options.RecordOnlyBosses and #inCombat == 0 then
			DBM:StopLogging()
		end
	end

	local syncHandlers = {}
	local whisperSyncHandlers = {}

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
	-- TI = Timer Info
	-- IR = Instance Info Request
	-- IRE = Instance Info Requested Ended/Canceled
	-- II = Instance Info
	-- WBE = World Boss engage info
	-- WBD = World Boss defeat info
	-- DSW = Disable Send Whisper
	-- NS = Note Share

	syncHandlers["M"] = function(sender, mod, revision, event, ...)
		mod = DBM:GetModByName(mod or "")
		if mod and event and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, sender, revision, ...)
		end
	end

	syncHandlers["NS"] = function(sender, modid, modvar, text, abilityName)
		if sender == playerName then return end
		if DBM.Options.BlockNoteShare or InCombatLockdown() or UnitAffectingCombat("player") or IsFalling() then return end--or DBM:GetRaidRank(sender) == 0
		if IsInGroup(2) and IsInInstance() then return end
		--^^You are in LFR, BG, or LFG. Block note syncs. They shouldn't be sendable, but in case someone edits DBM^^
		local mod = DBM:GetModByName(modid or "")
		local ability = abilityName or L.UNKNOWN
		if mod and modvar and text and text ~= "" then
			if DBM:AntiSpam(5, modvar) then--Don't allow calling same note more than once per 5 seconds
				DBM:AddMsg(L.NOTE_SHARE_SUCCESS:format(sender, ability))
				DBM:AddMsg(("|HDBM:noteshare:%s:%s:%s:%s:%s|h|cff3588ff[%s]|r|h"):format(modid, modvar, ability, text, sender, L.NOTE_SHARE_LINK))
				--DBM:ShowNoteEditor(mod, modvar, ability, text, sender)
			else
				DBM:Debug(sender.." is attempting to send too many notes so notes are being throttled")
			end
		else
			DBM:AddMsg(L.NOTE_SHARE_FAIL:format(sender, ability))
		end
	end

	syncHandlers["C"] = function(sender, delay, mod, modRevision, startHp, dbmRevision, modHFRevision, event)
		if not dbmIsEnabled or sender == playerName then return end
		if LastInstanceType == "pvp" then return end
		if LastInstanceType == "none" and (not UnitAffectingCombat("player") or #inCombat > 0) then--world boss
			local senderuId = DBM:GetRaidUnitId(sender)
			if not senderuId then return end--Should never happen, but just in case. If happens, MANY "C" syncs are sent. losing 1 no big deal.
			local _, _, _, playerZone = UnitPosition("player")
			local _, _, _, senderZone = UnitPosition(senderuId)
			if playerZone ~= senderZone then return end--not same zone
			local range = DBM.RangeCheck:GetDistance("player", senderuId)--Same zone, so check range
			if not range or range > 120 then return end
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
				if mod and delay and (not mod.zones or mod.zones[LastInstanceMapID]) and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) then
					DBM:StartCombat(mod, delay + lag, "SYNC from - "..sender, true, startHp, event)
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

	syncHandlers["DSW"] = function(sender)
		if (DBM:GetRaidRank(sender) ~= 2 or not IsInGroup()) then return end--If not on group, we're probably sender, don't disable status. IF not leader, someone is trying to spoof this, block that too
		statusWhisperDisabled = true
		DBM:Debug("Raid leader has disabled status whispers")
	end

	syncHandlers["DGP"] = function(sender)
		if (DBM:GetRaidRank(sender) ~= 2 or not IsInGroup()) then return end--If not on group, we're probably sender, don't disable status. IF not leader, someone is trying to spoof this, block that too
		statusGuildDisabled = true
		DBM:Debug("Raid leader has disabled guild progress messages")
	end

	syncHandlers["IS"] = function(sender, guid, ver, optionName)
		ver = tonumber(ver) or 0
		if ver > (iconSetRevision[optionName] or 0) then--Save first synced version and person, ignore same version. refresh occurs only above version (fastest person)
			iconSetRevision[optionName] = ver
			iconSetPerson[optionName] = guid
		end
		if iconSetPerson[optionName] == UnitGUID("player") then--Check if that highest version was from ourself
			DBM.canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			DBM.canSetIcons[optionName] = false
		end
		local name = DBM:GetFullPlayerNameByGUID(iconSetPerson[optionName]) or L.UNKNOWN
		DBM:Debug(name.." was elected icon setter for "..optionName, 2)
	end

	syncHandlers["K"] = function(sender, cId)
		if select(2, IsInInstance()) == "pvp" or select(2, IsInInstance()) == "none" then return end
		cId = tonumber(cId or "")
		if cId then DBM:OnMobKill(cId, true) end
	end

	syncHandlers["EE"] = function(sender, eId, success, mod, modRevision)
		if select(2, IsInInstance()) == "pvp" then return end
		eId = tonumber(eId or "")
		success = tonumber(success)
		mod = DBM:GetModByName(mod or "")
		modRevision = tonumber(modRevision or 0) or 0
		if mod and eId and success and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) and not eeSyncSender[sender] then
			eeSyncSender[sender] = true
			eeSyncReceived = eeSyncReceived + 1
			if eeSyncReceived > 2 then -- need at least 3 person to combat end. (for security)
				DBM:EndCombat(mod, success == 0)
			end
		end
	end

	local dummyMod -- dummy mod for the pull timer
	syncHandlers["PT"] = function(sender, timer, senderMapID, target)
		if DBM.Options.DontShowUserTimers then return end
		local LFGTankException = IsPartyLFG() and UnitGroupRolesAssigned(sender) == "TANK"
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		--Abort if mapID filter is enabled and sender actually sent a mapID. if no mapID is sent, it's always passed through (IE BW pull timers)
		if DBM.Options.DontShowPTNoID and senderMapID and tonumber(senderMapID) ~= LastInstanceMapID then return end
		timer = tonumber(timer or 0)
		if timer > 60 or (timer > 0 and timer < 3) then
			return
		end
		if not dummyMod then
			local threshold = DBM.Options.PTCountThreshold2
			threshold = floor(threshold)
			dummyMod = DBM:NewMod("PullTimerCountdownDummy")
			DBM:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{ name = L.MINIMAP_TOOLTIP_HEADER }
			dummyMod.text = dummyMod:NewAnnounce("%s", 1, "132349")
			dummyMod.geartext = dummyMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3)
			dummyMod.timer = dummyMod:NewTimer(20, "%s", "132349", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 1, threshold)
		end
		--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
		if not DBM.Options.DontShowPT2 then--and DBM.Bars:GetBar(L.TIMER_PULL)
			dummyMod.timer:Stop()
		end
		local timerTrackerRunning = false
		if not DBM.Options.DontShowPTCountdownText then
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
		if not DBM.Options.DontShowPTCountdownText then
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
		if DBM.Options.RecordOnlyBosses then
			DBM:StartLogging(timer, checkForActualPull)
		end
		if DBM.Options.CheckGear then
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
			if IsInRaid() and difference >= 30 then
				dummyMod.geartext:Show(L.GEAR_WARNING:format(floor(difference)))
			elseif IsInRaid() and (not weapon or fishingPole) then
				dummyMod.geartext:Show(L.GEAR_WARNING_WEAPON)
			end
		end
	end

	do
		local dummyMod2 -- dummy mod for the break timer
		function breakTimerStart(self, timer, sender)
			if not dummyMod2 then
				local threshold = DBM.Options.PTCountThreshold2
				threshold = floor(threshold)
				dummyMod2 = DBM:NewMod("BreakTimerCountdownDummy")
				DBM:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{ name = L.MINIMAP_TOOLTIP_HEADER }
				dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, "237538")
				dummyMod2.timer = dummyMod2:NewTimer(20, "%s", "237538", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 1, threshold)
			end
			--Cancel any existing break timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not DBM.Options.DontShowPT2 then--and DBM.Bars:GetBar(L.TIMER_BREAK)
				dummyMod2.timer:Stop()
			end
			dummyMod2.text:Cancel()
			DBM.Options.RestoreSettingBreakTimer = nil
			if timer == 0 then return end--"/dbm break 0" will strictly be used to cancel the break timer (which is why we let above part of code run but not below)
			self.Options.RestoreSettingBreakTimer = timer.."/"..time()
			if not self.Options.DontShowPT2 then
				dummyMod2.timer:Start(timer, L.TIMER_BREAK)
			end
			if not self.Options.DontShowPTText then
				local hour, minute = GetGameTime()
				minute = minute+(timer/60)
				if minute >= 60 then
					hour = hour + 1
					minute = minute - 60
				end
				minute = floor(minute)
				if minute < 10 then
					minute = tostring(0 .. minute)
				end
				dummyMod2.text:Show(L.BREAK_START:format(strFromTime(timer).." ("..hour..":"..minute..")", sender))
				if timer/60 > 10 then dummyMod2.text:Schedule(timer - 10*60, L.BREAK_MIN:format(10)) end
				if timer/60 > 5 then dummyMod2.text:Schedule(timer - 5*60, L.BREAK_MIN:format(5)) end
				if timer/60 > 2 then dummyMod2.text:Schedule(timer - 2*60, L.BREAK_MIN:format(2)) end
				if timer/60 > 1 then dummyMod2.text:Schedule(timer - 1*60, L.BREAK_MIN:format(1)) end
				dummyMod2.text:Schedule(timer, L.ANNOUNCE_BREAK_OVER:format(hour..":"..minute))
			end
			C_TimerAfter(timer, function() self.Options.RestoreSettingBreakTimer = nil end)
		end
	end

	syncHandlers["BT"] = function(sender, timer)
		if DBM.Options.DontShowUserTimers then return end
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup()) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		breakTimerStart(DBM, timer, sender)
	end

	whisperSyncHandlers["BTR3"] = function(sender, timer)
		if DBM.Options.DontShowUserTimers then return end
		timer = tonumber(timer or 0)
		if timer > 3600 then return end
		DBM:Unschedule(DBM.RequestTimers)--IF we got BTR3 sync, then we know immediately RequestTimers was successful, so abort others
		if #inCombat >= 1 then return end
		if DBM.Bars:GetBar(L.TIMER_BREAK) then return end--Already recovered. Prevent duplicate recovery
		breakTimerStart(DBM, timer, sender)
	end

	local function SendVersion(guild)
		if guild then
			local message = ("%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion)
			SendAddonMessage("D4", "GV\t" .. message, "GUILD")
			return
		end
		if DBM.Options.FakeBWVersion then
			SendAddonMessage("BigWigs", bwVersionResponseString:format(fakeBWVersion, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
			return
		end
		--(Note, faker isn't to screw with bigwigs nor is theirs to screw with dbm, but rathor raid leaders who don't let people run WTF they want to run)
		local VPVersion
		local VoicePack = DBM.Options.ChosenVoicePack
		if not DBM.voiceSessionDisabled and VoicePack ~= "None" and DBM.VoiceVersions[VoicePack] then
			VPVersion = "/ VP"..VoicePack..": v"..DBM.VoiceVersions[VoicePack]
		end
		if VPVersion then
			sendSync("V", ("%s\t%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), VPVersion))
		else
			sendSync("V", ("%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons)))
		end
	end

	local function HandleVersion(revision, version, displayVersion, sender)
		if version > DBM.Revision then -- Update reminder
			if #newerVersionPerson < 4 then
				if not checkEntry(newerVersionPerson, sender) then
					newerVersionPerson[#newerVersionPerson + 1] = sender
					DBM:Debug("Newer version detected from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision), 3)
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
									DBM.NewerVersion = temp3.."."..temp4.."."..temp5
								end
							end
						end
					end
					--Find min revision.
					updateNotificationDisplayed = 2
					AddMsg(DBM, L.UPDATEREMINDER_HEADER:match("([^\n]*)"))
					AddMsg(DBM, L.UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, showRealDate(version)))
					showConstantReminder = 1
				elseif #newerVersionPerson == 3 and raid[newerVersionPerson[1]] and raid[newerVersionPerson[2]] and raid[newerVersionPerson[3]] and updateNotificationDisplayed < 3 then--The following code requires at least THREE people to send that higher revision. That should be more than adaquate
					--Disable if out of date and it's a major patch.
					if not testBuild and dbmToc < wowTOC then
						updateNotificationDisplayed = 3
						AddMsg(DBM, L.UPDATEREMINDER_MAJORPATCH)
						DBM:Disable(true)
					--Disallow out of date to run during beta/ptr what so ever.
					elseif testBuild then
						updateNotificationDisplayed = 3
						AddMsg(DBM, L.UPDATEREMINDER_DISABLE)
						DBM:Disable(true)
					end
				end
			end
		end
	end

	-- TODO: is there a good reason that version information is broadcasted and not unicasted?
	syncHandlers["H"] = function(sender)
		DBM:Unschedule(SendVersion)--Throttle so we don't needlessly send tons of comms during initial raid invites
		DBM:Schedule(3, SendVersion)--Send version if 3 seconds have past since last "Hi" sync
	end

	syncHandlers["GH"] = function(sender)
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

	syncHandlers["BV"] = function(sender, version, hash)--Parsed from bigwigs V7+
		if version and raid[sender] then
			raid[sender].bwversion = version
			raid[sender].bwhash = hash or ""
		end
	end

	syncHandlers["V"] = function(sender, revision, version, displayVersion, locale, iconEnabled, VPVersion)
		revision, version = tonumber(revision), tonumber(version)
		if revision and version and displayVersion and raid[sender] then
			raid[sender].revision = revision
			raid[sender].version = version
			raid[sender].displayVersion = displayVersion
			raid[sender].VPVersion = VPVersion
			raid[sender].locale = locale
			raid[sender].enabledIcons = iconEnabled or "false"
			DBM:Debug("Received version info from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision), 3)
			HandleVersion(revision, version, displayVersion, sender)
		end
		DBM:GROUP_ROSTER_UPDATE()
	end

	syncHandlers["GV"] = function(sender, revision, version, displayVersion)
		revision, version = tonumber(revision), tonumber(version)
		if revision and version and displayVersion then
			DBM:Debug("Received G version info from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision), 3)
			HandleVersion(revision, version, displayVersion, sender)
		end
	end

	syncHandlers["U"] = function(sender, time, text)
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

	-- beware, ugly and missplaced code ahead
	-- todo: move this somewhere else
	do
		local accessList = {}
		local savedSender

		local inspopup = CreateFrame("Frame", "DBMPopupLockout", UIParent, DBM:IsShadowlands() and "BackdropTemplate")
		inspopup.backdropInfo = {
			bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background-Dark", -- 312922
			edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
			tile		= true,
			tileSize	= 16,
			edgeSize	= 16,
			insets		= { left = 1, right = 1, top = 1, bottom = 1 }
		}
		if not DBM:IsShadowlands() then
			inspopup:SetBackdrop(inspopup.backdropInfo)
		else
			inspopup:ApplyBackdrop()
		end
		inspopup:SetSize(500, 120)
		inspopup:SetPoint("TOP", UIParent, "TOP", 0, -200)
		inspopup:SetFrameStrata("DIALOG")

		local inspopuptext = inspopup:CreateFontString()
		inspopuptext:SetFontObject(ChatFontNormal)
		inspopuptext:SetWidth(470)
		inspopuptext:SetWordWrap(true)
		inspopuptext:SetPoint("TOP", inspopup, "TOP", 0, -15)

		local buttonaccept = CreateFrame("Button", nil, inspopup)
		buttonaccept:SetNormalTexture(130763)--"Interface\\Buttons\\UI-DialogBox-Button-Up"
		buttonaccept:SetPushedTexture(130761)--"Interface\\Buttons\\UI-DialogBox-Button-Down"
		buttonaccept:SetHighlightTexture(130762, "ADD")--"Interface\\Buttons\\UI-DialogBox-Button-Highlight"
		buttonaccept:SetSize(128, 35)
		buttonaccept:SetPoint("BOTTOM", inspopup, "BOTTOM", -75, 0)

		local buttonatext = buttonaccept:CreateFontString()
		buttonatext:SetFontObject(ChatFontNormal)
		buttonatext:SetPoint("CENTER", buttonaccept, "CENTER", 0, 5)
		buttonatext:SetText(YES)

		local buttondecline = CreateFrame("Button", nil, inspopup)
		buttondecline:SetNormalTexture(130763)--"Interface\\Buttons\\UI-DialogBox-Button-Up"
		buttondecline:SetPushedTexture(130761)--"Interface\\Buttons\\UI-DialogBox-Button-Down"
		buttondecline:SetHighlightTexture(130762, "ADD")--"Interface\\Buttons\\UI-DialogBox-Button-Highlight"
		buttondecline:SetSize(128, 35)
		buttondecline:SetPoint("BOTTOM", inspopup, "BOTTOM", 75, 0)

		local buttondtext = buttondecline:CreateFontString()
		buttondtext:SetFontObject(ChatFontNormal)
		buttondtext:SetPoint("CENTER", buttondecline, "CENTER", 0, 5)
		buttondtext:SetText(NO)

		inspopup:Hide()

		local function autoDecline(sender, force)
			inspopup:Hide()
			savedSender = nil
			if force then
				SendAddonMessage("D4", "II\t" .. "denied", "WHISPER", sender)
			else
				SendAddonMessage("D4", "II\t" .. "timeout", "WHISPER", sender)
			end
		end

		local function showPopupInstanceIdPermission(sender)
			DBM:Unschedule(autoDecline)
			DBM:Schedule(59, autoDecline, sender)
			inspopup:Hide()
			if savedSender ~= sender then
				if savedSender then
					autoDecline(savedSender, 1) -- Do not allow multiple popups, so auto decline to previous sender.
				end
				savedSender = sender
			end
			inspopuptext:SetText(L.REQ_INSTANCE_ID_PERMISSION:format(sender, sender))
			buttonaccept:SetScript("OnClick", function(f) savedSender = nil DBM:Unschedule(autoDecline) accessList[sender] = true syncHandlers["IR"](sender) f:GetParent():Hide() end)
			buttondecline:SetScript("OnClick", function(f) autoDecline(sender, 1) end)
			DBM:PlaySound(850)
			inspopup:Show()
		end

		syncHandlers["IR"] = function(sender)
			if DBM:GetRaidRank(sender) == 0 or sender == playerName then
				return
			end
			accessList = accessList or {}
			if not accessList[sender] then
				-- ask for permission
				showPopupInstanceIdPermission(sender)
				return
			end
			-- okay, send data
			local sentData = false
			for i = 1, GetNumSavedInstances() do
				local name, id, _, difficulty, locked, extended, _, isRaid, maxPlayers, textDiff, _, progress = GetSavedInstanceInfo(i)
				if (locked or extended) and isRaid then -- only report locked raid instances
					SendAddonMessage("D4", "II\tData\t" .. name .. "\t" .. id .. "\t" .. difficulty .. "\t" .. maxPlayers .. "\t" .. (progress or 0) .. "\t" .. textDiff, "WHISPER", sender)
					sentData = true
				end
			end
			if not sentData then
				-- send something even if there is nothing to report so the receiver is able to tell you apart from someone who just didn't respond...
				SendAddonMessage("D4", "II\tNoData", "WHISPER", sender)
			end
		end

		syncHandlers["IRE"] = function(sender)
			local popup = inspopup:IsShown()
			if popup and savedSender == sender then -- found the popup with the correct data
				savedSender = nil
				DBM:Unschedule(autoDecline)
				inspopup:Hide()
			end
		end

		syncHandlers["GCB"] = function(sender, modId, ver, difficulty, difficultyModifier, name)
			if not DBM.Options.ShowGuildMessages or not difficulty then return end
			if not ver or not (ver == "2") then return end--Ignore old versions
			if DBM:AntiSpam(10, "GCB") then
				if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
				difficulty = tonumber(difficulty)
				if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
				modId = tonumber(modId)
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or L.UNKNOWN
				local difficultyName
				if difficulty == 8 then
					if difficultyModifier and difficultyModifier ~= 0 then
						difficultyName = PLAYER_DIFFICULTY6.."+ ("..difficultyModifier..")"
					else
						difficultyName = PLAYER_DIFFICULTY6.."+"
					end
				elseif difficulty == 16 then
					difficultyName = PLAYER_DIFFICULTY6
				elseif difficulty == 15 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				DBM:AddMsg(L.GUILD_COMBAT_STARTED:format(difficultyName.."-"..bossName))
			end
		end

		syncHandlers["GCE"] = function(sender, modId, ver, wipe, time, difficulty, difficultyModifier, name, wipeHP)
			if not DBM.Options.ShowGuildMessages or not difficulty then return end
			if not ver or not (ver == "5") then return end--Ignore old versions
			if DBM:AntiSpam(5, "GCE") then
				if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
				difficulty = tonumber(difficulty)
				if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
				modId = tonumber(modId)
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or L.UNKNOWN
				local difficultyName
				if difficulty == 8 then
					if difficultyModifier and difficultyModifier ~= 0 then
						difficultyName = PLAYER_DIFFICULTY6.."+ ("..difficultyModifier..")"
					else
						difficultyName = PLAYER_DIFFICULTY6.."+"
					end
				elseif difficulty == 16 then
					difficultyName = PLAYER_DIFFICULTY6
				elseif difficulty == 15 then
					difficultyName = PLAYER_DIFFICULTY2
				else
					difficultyName = PLAYER_DIFFICULTY1
				end
				if wipe == "1" then
					DBM:AddMsg(L.GUILD_COMBAT_ENDED_AT:format(difficultyName.."-"..bossName, wipeHP, time))
				else
					DBM:AddMsg(L.GUILD_BOSS_DOWN:format(difficultyName.."-"..bossName, time))
				end
			end
		end

		syncHandlers["WBE"] = function(sender, modId, realm, health, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossEngage[modId..realm] and (GetTime() - lastBossEngage[modId..realm] < 30) then return end--We recently got a sync about this boss on this realm, so do nothing.
			lastBossEngage[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or L.UNKNOWN
				DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), sender))
			end
		end

		syncHandlers["WBD"] = function(sender, modId, realm, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
			lastBossDefeat[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or L.UNKNOWN
				DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, sender))
			end
		end

		whisperSyncHandlers["WBE"] = function(sender, modId, realm, health, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossEngage[modId..realm] and (GetTime() - lastBossEngage[modId..realm] < 30) then return end
			lastBossEngage[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
				local toonName = gameAccountInfo and gameAccountInfo.characterName or L.UNKNOWN
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or L.UNKNOWN
				DBM:AddMsg(L.WORLDBOSS_ENGAGED:format(bossName, floor(health), toonName))
			end
		end

		whisperSyncHandlers["WBD"] = function(sender, modId, realm, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
			lastBossDefeat[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
				local toonName = gameAccountInfo and gameAccountInfo.characterName or L.UNKNOWN
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or L.UNKNOWN
				DBM:AddMsg(L.WORLDBOSS_DEFEATED:format(bossName, toonName))
			end
		end

		local lastRequest = 0
		local numResponses = 0
		local expectedResponses = 0
		local allResponded = false
		local results

		local updateInstanceInfo, showResults

		whisperSyncHandlers["II"] = function(sender, result, name, id, diff, maxPlayers, progress, textDiff)
			if GetTime() - lastRequest > 62 or not results then
				return
			end
			if not result then
				return
			end
			name = name or L.UNKNOWN
			id = id or ""
			diff = tonumber(diff or 0) or 0
			maxPlayers = tonumber(maxPlayers or 0) or 0
			progress = tonumber(progress or 0) or 0
			textDiff = textDiff or ""

			-- count responses
			if not results.responses[sender] then
				results.responses[sender] = result
				numResponses = numResponses + 1
			end

			-- get localized difficulty text
			if textDiff ~= "" then
				results.difftext[diff] = textDiff
			end

			if result == "Data" then
				-- got data in that response and not just a "no" or "i'm away"
				local instanceId = name.." "..maxPlayers.." "..diff -- locale-dependant dungeon ID
				results.data[instanceId] = results.data[instanceId] or {
					ids = {}, -- array of all ids of all raid members
					name = name,
					diff = diff,
					maxPlayers = maxPlayers,
				}
				if diff == 5 or diff == 6 or diff == 16 then
					results.data[instanceId].ids[id] = results.data[instanceId].ids[id] or { progress = progress, haveid = true }
					tinsert(results.data[instanceId].ids[id], sender)
				else
					results.data[instanceId].ids[progress] = results.data[instanceId].ids[progress] or { progress = progress }
					tinsert(results.data[instanceId].ids[progress], sender)
				end
			end

			if numResponses >= expectedResponses then -- unlikely, lol
				DBM:Unschedule(updateInstanceInfo)
				DBM:Unschedule(showResults)
				if not allResponded then --Only display message once in case we get for example 4 syncs the last sender
					DBM:Schedule(0.99, DBM.AddMsg, DBM, L.INSTANCE_INFO_ALL_RESPONSES)
					allResponded = true
				end
				C_TimerAfter(1, showResults) --Delay results so we allow time for same sender to send more than 1 lockout, otherwise, if we get expectedResponses before all data is sent from 1 user, we clip some of their data.
			end
		end

		function showResults()
			local resultCount = 0
			-- TODO: you could catch some localized instances by observing IDs if there are multiple players with the same instance ID but a different name ;) (not that useful if you are trying to get a fresh instance)
			DBM:AddMsg(L.INSTANCE_INFO_RESULTS, false)
			DBM:AddMsg("---", false)
			for _, v in pairs(results.data) do
				resultCount = resultCount + 1
				DBM:AddMsg(L.INSTANCE_INFO_DETAIL_HEADER:format(v.name, (results.difftext[v.diff] or v.diff)), false)
				for id, r in pairs(v.ids) do
					if r.haveid then
						DBM:AddMsg(L.INSTANCE_INFO_DETAIL_INSTANCE:format(id, r.progress, tconcat(r, ", ")), false)
					else
						DBM:AddMsg(L.INSTANCE_INFO_DETAIL_INSTANCE2:format(r.progress, tconcat(r, ", ")), false)
					end
				end
				DBM:AddMsg("---", false)
			end
			if resultCount == 0 then
				DBM:AddMsg(L.INSTANCE_INFO_NOLOCKOUT, false)
			end
			local denied = {}
			local away = {}
			local noResponse = {}
			for i = 1, GetNumGroupMembers() do
				if not UnitIsUnit("raid"..i, "player") then
					tinsert(noResponse, (GetRaidRosterInfo(i)))
				end
			end
			for i, v in pairs(results.responses) do
				if v == "Data" or v == "NoData" then
				elseif v == "timeout" then
					tinsert(away, i)
				else -- could be "clicked" or "override", in both cases we don't get the data because the dialog requesting it was dismissed
					tinsert(denied, i)
				end
				removeEntry(noResponse, i)
			end
			if #denied > 0 then
				DBM:AddMsg(L.INSTANCE_INFO_STATS_DENIED:format(tconcat(denied, ", ")), false)
			end
			if #away > 0 then
				DBM:AddMsg(L.INSTANCE_INFO_STATS_AWAY:format(tconcat(away, ", ")), false)
			end
			if #noResponse > 0 then
				DBM:AddMsg(L.INSTANCE_INFO_STATS_NO_RESPONSE:format(tconcat(noResponse, ", ")), false)
			end
			results = nil
		end

		-- called when the chat link is clicked
		function DBM:ShowRaidIDRequestResults()
			if not results then -- check if we are currently querying raid IDs, results will be nil if we don't
				return
			end
			self:Unschedule(updateInstanceInfo)
			self:Unschedule(showResults)
			showResults() -- sets results to nil after the results are displayed, ending the current id request; future incoming data will be discarded
			sendSync("IRE")
		end

		local function getResponseStats()
			local numResponses = 0
			local sent = 0
			local denied = 0
			local away = 0
			for _, v in pairs(results.responses) do
				numResponses = numResponses + 1
				if v == "Data" or v == "NoData" then
					sent = sent + 1
				elseif v == "timeout" then
					away = away + 1
				else -- could be "clicked" or "override", in both cases we don't get the data because the dialog requesting it was dismissed
					denied = denied + 1
				end
			end
			return numResponses, sent, denied, away
		end

		local function getNumDBMUsers() -- without ourselves
			local r = 0
			for _, v in pairs(raid) do
				if v.revision and v.name ~= playerName and UnitIsConnected(v.id) then
					r = r + 1
				end
			end
			return r
		end

		function updateInstanceInfo(timeRemaining, dontAddShowResultNowButton)
			local numResponses, sent, denied, _ = getResponseStats()
			local dbmUsers = getNumDBMUsers()
			DBM:AddMsg(L.INSTANCE_INFO_STATUS_UPDATE:format(numResponses, dbmUsers, sent, denied, timeRemaining), false)
			if not dontAddShowResultNowButton then
				if dbmUsers - numResponses <= 7 then -- waiting for 7 or less players, show their names and the early result option
					-- copied from above, todo: implement a smarter way of keeping track of stuff like this
					local noResponse = {}
					for i = 1, GetNumGroupMembers() do
						if not UnitIsUnit("raid"..i, "player") and raid[GetRaidRosterInfo(i)] and raid[GetRaidRosterInfo(i)].revision then -- only show players who actually can respond (== DBM users)
							tinsert(noResponse, (GetRaidRosterInfo(i)))
						end
					end
					for i, _ in pairs(results.responses) do
						removeEntry(noResponse, i)
					end

					--[[
					-- this looked like the easiest way (for some reason?) to create the player string when writing this code -.-
					local function dup(...) if select("#", ...) == 0 then return else return ..., ..., dup(select(2, ...)) end end
					DBM:AddMsg(L.INSTANCE_INFO_SHOW_RESULTS:format(("|Hplayer:%s|h[%s]|h| "):rep(#noResponse):format(dup(unpack(noResponse)))), false)
					]]
					-- code that one can actually read
					for i, v in ipairs(noResponse) do
						noResponse[i] = ("|Hplayer:%s|h[%s]|h|"):format(v, v)
					end
					DBM:AddMsg(L.INSTANCE_INFO_SHOW_RESULTS:format(tconcat(noResponse, ", ")), false)
				end
			end
		end

		function DBM:RequestInstanceInfo()
			self:AddMsg(L.INSTANCE_INFO_REQUESTED)
			lastRequest = GetTime()
			allResponded = false
			results = {
				responses = { -- who responded to our request?
				},
				data = { -- the actual data
				},
				difftext = {
				}
			}
			numResponses = 0
			expectedResponses = getNumDBMUsers()
			sendSync("IR")
			self:Unschedule(updateInstanceInfo)
			self:Unschedule(showResults)
			self:Schedule(17, updateInstanceInfo, 45, true)
			self:Schedule(32, updateInstanceInfo, 30)
			self:Schedule(48, updateInstanceInfo, 15)
			C_TimerAfter(62, showResults)
		end
	end

	whisperSyncHandlers["RT"] = function(sender)
		if UnitInBattleground("player") then
			DBM:SendPVPTimers(sender)
		else
			DBM:SendTimers(sender)
		end
	end

	whisperSyncHandlers["CI"] = function(sender, mod, time)
		mod = DBM:GetModByName(mod or "")
		time = tonumber(time or 0)
		if mod and time then
			DBM:ReceiveCombatInfo(sender, mod, time)
		end
	end

	whisperSyncHandlers["TI"] = function(sender, mod, timeLeft, totalTime, id, ...)
		mod = DBM:GetModByName(mod or "")
		timeLeft = tonumber(timeLeft or 0)
		totalTime = tonumber(totalTime or 0)
		if mod and timeLeft and timeLeft > 0 and totalTime and totalTime > 0 and id then
			DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, ...)
		end
	end

	whisperSyncHandlers["VI"] = function(sender, mod, name, value)
		mod = DBM:GetModByName(mod or "")
		value = tonumber(value) or value
		if mod and name and value then
			DBM:ReceiveVariableInfo(sender, mod, name, value)
		end
	end

	handleSync = function(channel, sender, prefix, ...)
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
		else
			handler = syncHandlers[prefix]
		end
		if handler then
			return handler(sender, ...)
		end
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if prefix == "D4" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT" or channel == "WHISPER" or channel == "GUILD") then
			sender = Ambiguate(sender, "none")
			handleSync(channel, sender, strsplit("\t", msg))
		elseif prefix == "BigWigs" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT") then
			local bwPrefix, bwMsg, extra = strsplit("^", msg)
			if bwPrefix and bwMsg then
				if bwPrefix == "V" and extra then--Nil check "extra" to avoid error from older version
					local verString, hash = bwMsg, extra
					local version = tonumber(verString) or 0
					if version == 0 then return end--Just a query
					sender = Ambiguate(sender, "none")
					handleSync(channel, sender, "BV", version, hash)--Prefix changed, so it's not handled by DBMs "V" handler
					if version > fakeBWVersion then--Newer revision found, upgrade!
						fakeBWVersion = version
						fakeBWHash = hash
					end
				elseif bwPrefix == "Q" then--Version request prefix
					self:Unschedule(SendVersion)
					self:Schedule(3, SendVersion)
				elseif bwPrefix == "B" then--Boss Mod Sync
					for i = 1, #inCombat do
						local mod = inCombat[i]
						if mod and mod.OnBWSync then
							mod:OnBWSync(bwMsg, extra, sender)
						end
					end
					for i = 1, #DBM.oocBWComms do
						local mod = DBM.oocBWComms[i]
						if mod and mod.OnBWSync then
							mod:OnBWSync(bwMsg, extra, sender)
						end
					end
				end
			end
		elseif prefix == "Transcriptor" and msg then
			for i = 1, #inCombat do
				local mod = inCombat[i]
				if mod and mod.OnTranscriptorSync then
					mod:OnTranscriptorSync(msg, sender)
				end
			end
			local transcriptor = _G["Transcriptor"]
			if msg:find("spell:") and (DBM.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging())) then
				local spellId = string.match(msg, "spell:(%d+)") or L.UNKNOWN
				local spellName = string.match(msg, "h%[(.-)%]|h") or L.UNKNOWN
				local message = "RAID_BOSS_WHISPER on "..sender.." with spell of "..spellName.." ("..spellId..")"
				self:Debug(message)
			end
		end
	end
	DBM.CHAT_MSG_ADDON_LOGGED = DBM.CHAT_MSG_ADDON

	function DBM:BN_CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if prefix == "D4" and msg then
			handleSync("BN_WHISPER", sender, strsplit("\t", msg))
		end
	end
end

-----------------------
--  Update Reminder  --
-----------------------
do
	local frame, fontstring, fontstringFooter, editBox, urlText

	local function createFrame()
		frame = CreateFrame("Frame", "DBMUpdateReminder", UIParent, DBM:IsShadowlands() and "BackdropTemplate")
		frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
		frame:SetWidth(430)
		frame:SetHeight(140)
		frame:SetPoint("TOP", 0, -230)
		frame.backdropInfo = {
			bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background", -- 131071
			edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
			tile		= true,
			tileSize	= 32,
			edgeSize	= 32,
			insets		= { left = 11, right = 12, top = 12, bottom = 11 },
		}
		if not DBM:IsShadowlands() then
			frame:SetBackdrop(frame.backdropInfo)
		else
			frame:ApplyBackdrop()
		end
		fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstring:SetWidth(410)
		fontstring:SetHeight(0)
		fontstring:SetPoint("TOP", 0, -16)
		editBox = CreateFrame("EditBox", nil, frame)
		do
			local editBoxLeft = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxRight = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxMiddle = editBox:CreateTexture(nil, "BACKGROUND")
			editBoxLeft:SetTexture(130959)--"Interface\\ChatFrame\\UI-ChatInputBorder-Left"
			editBoxLeft:SetHeight(32)
			editBoxLeft:SetWidth(32)
			editBoxLeft:SetPoint("LEFT", -14, 0)
			editBoxLeft:SetTexCoord(0, 0.125, 0, 1)
			editBoxRight:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
			editBoxRight:SetHeight(32)
			editBoxRight:SetWidth(32)
			editBoxRight:SetPoint("RIGHT", 6, 0)
			editBoxRight:SetTexCoord(0.875, 1, 0, 1)
			editBoxMiddle:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
			editBoxMiddle:SetHeight(32)
			editBoxMiddle:SetWidth(1)
			editBoxMiddle:SetPoint("LEFT", editBoxLeft, "RIGHT")
			editBoxMiddle:SetPoint("RIGHT", editBoxRight, "LEFT")
			editBoxMiddle:SetTexCoord(0, 0.9375, 0, 1)
		end
		editBox:SetHeight(32)
		editBox:SetWidth(250)
		editBox:SetPoint("TOP", fontstring, "BOTTOM", 0, -4)
		editBox:SetFontObject("GameFontHighlight")
		editBox:SetTextInsets(0, 0, 0, 1)
		editBox:SetFocus()
		editBox:SetText(urlText)
		editBox:HighlightText()
		editBox:SetScript("OnTextChanged", function(self)
			editBox:SetText(urlText)
			editBox:HighlightText()
		end)
		fontstringFooter = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstringFooter:SetWidth(410)
		fontstringFooter:SetHeight(0)
		fontstringFooter:SetPoint("TOP", editBox, "BOTTOM", 0, 0)
		local button = CreateFrame("Button", nil, frame)
		button:SetHeight(24)
		button:SetWidth(75)
		button:SetPoint("BOTTOM", 0, 13)
		button:SetNormalFontObject("GameFontNormal")
		button:SetHighlightFontObject("GameFontHighlight")
		button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
		button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
		button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
		button:SetText(OKAY)
		button:SetScript("OnClick", function(self)
			frame:Hide()
		end)

	end

	function DBM:ShowUpdateReminder(newVersion, newRevision, text, url)
		urlText = url or "https://github.com/DeadlyBossMods/DeadlyBossMods/wiki"
		if not frame then
			createFrame()
		else
			editBox:SetText(urlText)
			editBox:HighlightText()
		end
		frame:Show()
		if newVersion then
			fontstring:SetText(L.UPDATEREMINDER_HEADER:format(newVersion, newRevision))
			fontstringFooter:SetText(L.UPDATEREMINDER_FOOTER)
		elseif text then
			fontstring:SetText(text)
			fontstringFooter:SetText(L.UPDATEREMINDER_FOOTER_GENERIC)
		end
	end
end

--------------------
--  Notes Editor  --
--------------------
do
	local frame, fontstring, fontstringFooter, editBox, button3

	local function createFrame()
		frame = CreateFrame("Frame", "DBMNotesEditor", UIParent, DBM:IsShadowlands() and "BackdropTemplate")
		frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
		frame:SetWidth(430)
		frame:SetHeight(140)
		frame:SetPoint("TOP", 0, -230)
		frame.backdropInfo = {
			bgFile		= "Interface\\DialogFrame\\UI-DialogBox-Background", -- 131071
			edgeFile	= "Interface\\DialogFrame\\UI-DialogBox-Border", -- 131072
			tile		= true,
			tileSize	= 32,
			edgeSize	= 32,
			insets		= { left = 11, right = 12, top = 12, bottom = 11 }
		}
		if not DBM:IsShadowlands() then
			frame:SetBackdrop(frame.backdropInfo)
		else
			frame:ApplyBackdrop()
		end
		fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstring:SetWidth(410)
		fontstring:SetHeight(0)
		fontstring:SetPoint("TOP", 0, -16)
		editBox = CreateFrame("EditBox", nil, frame)
		do
			local editBoxLeft = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxRight = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxMiddle = editBox:CreateTexture(nil, "BACKGROUND")
			editBoxLeft:SetTexture(130959)--"Interface\\ChatFrame\\UI-ChatInputBorder-Left"
			editBoxLeft:SetHeight(32)
			editBoxLeft:SetWidth(32)
			editBoxLeft:SetPoint("LEFT", -14, 0)
			editBoxLeft:SetTexCoord(0, 0.125, 0, 1)
			editBoxRight:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
			editBoxRight:SetHeight(32)
			editBoxRight:SetWidth(32)
			editBoxRight:SetPoint("RIGHT", 6, 0)
			editBoxRight:SetTexCoord(0.875, 1, 0, 1)
			editBoxMiddle:SetTexture(130960)--"Interface\\ChatFrame\\UI-ChatInputBorder-Right"
			editBoxMiddle:SetHeight(32)
			editBoxMiddle:SetWidth(1)
			editBoxMiddle:SetPoint("LEFT", editBoxLeft, "RIGHT")
			editBoxMiddle:SetPoint("RIGHT", editBoxRight, "LEFT")
			editBoxMiddle:SetTexCoord(0, 0.9375, 0, 1)
		end
		editBox:SetHeight(32)
		editBox:SetWidth(250)
		editBox:SetPoint("TOP", fontstring, "BOTTOM", 0, -4)
		editBox:SetFontObject("GameFontHighlight")
		editBox:SetTextInsets(0, 0, 0, 1)
		editBox:SetFocus()
		editBox:SetText("")
		fontstringFooter = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstringFooter:SetWidth(410)
		fontstringFooter:SetHeight(0)
		fontstringFooter:SetPoint("TOP", editBox, "BOTTOM", 0, 0)
		local button = CreateFrame("Button", nil, frame)
		button:SetHeight(24)
		button:SetWidth(75)
		button:SetPoint("BOTTOM", 80, 13)
		button:SetNormalFontObject("GameFontNormal")
		button:SetHighlightFontObject("GameFontHighlight")
		button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
		button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
		button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
		button:SetText(OKAY)
		button:SetScript("OnClick", function(self)
			local mod = DBM.Noteframe.mod
			local modvar = DBM.Noteframe.modvar
			mod.Options[modvar .. "SWNote"] = editBox:GetText() or ""
			DBM.Noteframe.mod = nil
			DBM.Noteframe.modvar = nil
			DBM.Noteframe.abilityName = nil
			frame:Hide()
		end)
		local button2 = CreateFrame("Button", nil, frame)
		button2:SetHeight(24)
		button2:SetWidth(75)
		button2:SetPoint("BOTTOM", 0, 13)
		button2:SetNormalFontObject("GameFontNormal")
		button2:SetHighlightFontObject("GameFontHighlight")
		button2:SetNormalTexture(button2:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
		button2:SetPushedTexture(button2:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
		button2:SetHighlightTexture(button2:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
		button2:SetText(CANCEL)
		button2:SetScript("OnClick", function(self)
			DBM.Noteframe.mod = nil
			DBM.Noteframe.modvar = nil
			DBM.Noteframe.abilityName = nil
			frame:Hide()
		end)
		button3 = CreateFrame("Button", nil, frame)
		button3:SetHeight(24)
		button3:SetWidth(75)
		button3:SetPoint("BOTTOM", -80, 13)
		button3:SetNormalFontObject("GameFontNormal")
		button3:SetHighlightFontObject("GameFontHighlight")
		button3:SetNormalTexture(button3:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
		button3:SetPushedTexture(button3:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
		button3:SetHighlightTexture(button3:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
		button3:SetText(SHARE_QUEST_ABBREV)
		button3:SetScript("OnClick", function(self)
			local modid = DBM.Noteframe.mod.id
			local modvar = DBM.Noteframe.modvar
			local abilityName = DBM.Noteframe.abilityName
			local syncText = editBox:GetText() or ""
			if syncText == "" then
				DBM:AddMsg(L.NOTESHAREERRORBLANK)
			elseif IsInGroup(2) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
				DBM:AddMsg(L.NOTESHAREERRORGROUPFINDER)
			else
				local msg = modid.."\t"..modvar.."\t"..syncText.."\t"..abilityName
				if IsInRaid() then
					--if DBM:GetRaidRank(playerName) == 0 then
					--	DBM:AddMsg(L.ERROR_NO_PERMISSION)
					--else
						SendAddonMessage("D4", "NS\t" .. msg, "RAID")
						DBM:AddMsg(L.NOTESHARED)
					--end
				elseif IsInGroup(1) then
					--if DBM:GetRaidRank(playerName) == 0 then
					--	DBM:AddMsg(L.ERROR_NO_PERMISSION)
					--else
						SendAddonMessage("D4", "NS\t" .. msg, "PARTY")
						DBM:AddMsg(L.NOTESHARED)
					--end
				else--Solo
					DBM:AddMsg(L.NOTESHAREERRORSOLO)
				end
			end
		end)
	end

	function DBM:ShowNoteEditor(mod, modvar, abilityName, syncText, sender)
		if not frame then
			createFrame()
			self.Noteframe = frame
		else
			if frame:IsShown() and syncText then
				self:AddMsg(L.NOTESHAREERRORALREADYOPEN)
				return
			end
		end
		frame:Show()
		fontstringFooter:SetText(L.NOTEFOOTER)
		self.Noteframe.mod = mod
		self.Noteframe.modvar = modvar
		self.Noteframe.abilityName = abilityName
		if syncText then
			button3:Hide()--Don't show share button in shared notes
			fontstring:SetText(L.NOTESHAREDHEADER:format(sender, abilityName))
			editBox:SetText(syncText)
		else
			button3:Show()
			fontstring:SetText(L.NOTEHEADER:format(abilityName))
			if type(mod.Options[modvar .. "SWNote"]) == "string" then
				editBox:SetText(mod.Options[modvar .. "SWNote"])
			else
				editBox:SetText("")
			end
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
			local id = (i == 0 and "target") or uId..i.."target"
			local guid = UnitGUID(id)
			if guid and DBM:IsCreatureGUID(guid) then
				local cId = DBM:GetCIDFromGUID(guid)
				targetList[cId] = id
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
		if dbmIsEnabled and DBM.combatInfo[LastInstanceMapID] then
			for _, v in ipairs(DBM.combatInfo[LastInstanceMapID]) do
				if v.type:find("combat") and not v.noRegenDetection then
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
		if self.Options.AFKHealthWarning and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
			self:FlashClientIcon()
			local voice = DBM.Options.ChosenVoicePack
			local path = 8585--"Sound\\Creature\\CThun\\CThunYouWillDIe.ogg"
			if not DBM.voiceSessionDisabled and voice ~= "None" then
				path = "Interface\\AddOns\\DBM-VP"..voice.."\\checkhp.ogg"
			end
			self:PlaySound(path)
			if UnitHealthMax("player") ~= 0 then
				local health = UnitHealth("player") / UnitHealthMax("player") * 100
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		end
	end

	function DBM:PLAYER_REGEN_ENABLED()
		if delayedFunction then--Will throw error if not a function, purposely not doing and type(delayedFunction) == "function" for now to make sure code works though  cause it always should be function
			delayedFunction()
			delayedFunction = nil
		end
		if watchFrameRestore then
			--ObjectiveTrackerFrame:Show()
			ObjectiveTracker_Expand()
			watchFrameRestore = false
		end
	end

	local function isBossEngaged(cId)
		-- note that this is designed to work with any number of bosses, but it might be sufficient to check the first 5 unit ids
		local i = 1
		repeat
			local bossUnitId = "boss"..i
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
		if dbmIsEnabled and DBM.combatInfo[LastInstanceMapID] then
			self:Debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId"..LastInstanceMapID, 3)
			for _, v in ipairs(DBM.combatInfo[LastInstanceMapID]) do
				if v.type:find("combat") and isBossEngaged(v.multiMobPullDetection or v.mob) then
					self:StartCombat(v.mod, 0, "IEEU")
				end
			end
		end
	end

	function DBM:UNIT_TARGETABLE_CHANGED(uId)
		local transcriptor = _G["Transcriptor"]
		if self.Options.DebugLevel > 2 or (transcriptor and transcriptor:IsLogging()) then
			local active = UnitExists(uId) and "true" or "false"
			self:Debug("UNIT_TARGETABLE_CHANGED event fired for "..UnitName(uId)..". Active: "..active)
		end
	end

	function DBM:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		local spellName = self:GetSpellInfo(spellId)
		self:Debug("UNIT_SPELLCAST_SUCCEEDED fired: "..UnitName(uId).."'s "..spellName.."("..spellId..")", 3)
	end

	function DBM:ENCOUNTER_START(encounterID, name, difficulty, size)
		self:Debug("ENCOUNTER_START event fired: "..encounterID.." "..name.." "..difficulty.." "..size)
		if dbmIsEnabled then
			if self.Options.ShowReminders then
				self:CheckAvailableMods()
			end
			if DBM.combatInfo[LastInstanceMapID] then
				for _, v in ipairs(DBM.combatInfo[LastInstanceMapID]) do
					if not v.noESDetection then
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
		self:Debug("ENCOUNTER_END event fired: "..encounterID.." "..name.." "..difficulty.." "..size.." "..success)
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.noEEDetection then return end
			if v.respawnTime and success == 0 and self.Options.ShowRespawn and not self.Options.DontShowBossTimers then--No special hacks needed for bad wrath ENCOUNTER_END. Only mods that define respawnTime have a timer, since variable per boss.
				name = string.split(",", name)
				self.Bars:CreateBar(v.respawnTime, L.TIMER_RESPAWN:format(name), 237538)--Interface\\Icons\\Spell_Holy_BorrowedTime
				fireEvent("DBM_TimerStart", "DBMRespawnTimer", L.TIMER_RESPAWN:format(name), v.respawnTime, "237538", "extratimer", nil, 0, v.id)
			end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						self:EndCombat(v, success == 0)
						sendSync("EE", encounterID.."\t"..success.."\t"..v.id.."\t"..(v.revision or 0))
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v, success == 0)
				sendSync("EE", encounterID.."\t"..success.."\t"..v.id.."\t"..(v.revision or 0))
				return
			end
		end
	end

	function DBM:BOSS_KILL(encounterID, name)
		self:Debug("BOSS_KILL event fired: "..encounterID.." "..name)
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.noBKDetection then return end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						self:EndCombat(v)
						sendSync("EE", encounterID.."\t1\t"..v.id.."\t"..(v.revision or 0))
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				self:EndCombat(v)
				sendSync("EE", encounterID.."\t1\t"..v.id.."\t"..(v.revision or 0))
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
		if dbmIsEnabled and DBM.combatInfo[LastInstanceMapID] then
			for _, v in ipairs(DBM.combatInfo[LastInstanceMapID]) do
				if v.type == type and checkEntry(v.msgs, msg) or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg) then
					self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
				elseif v.type == "combat_" .. type .. "find" and findEntry(v.msgs, msg) or v.type == "combat_" .. type and checkEntry(v.msgs, msg) then
					if IsInInstance() then--Indoor boss that uses both combat and message for combat, so in other words (such as hodir), don't require "target" of boss for yell like scanForCombat does for World Bosses
						self:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
					else--World Boss
						scanForCombat(v.mod, v.mob, 0)
						if v.mod.readyCheckQuestId and (self.Options.WorldBossNearAlert or v.mod.Options.ReadyCheck) and not IsQuestFlaggedCompleted(v.mod.readyCheckQuestId) and v.mod.readyCheckMaxLevel >= playerLevel then
							self:FlashClientIcon()
							self:PlaySound(8960, true)
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
				self:EndCombat(v)
			end
		end
	end

	function DBM:CHAT_MSG_MONSTER_YELL(msg, npc, _, _, target)
		if IsEncounterInProgress() or (IsInInstance() and InCombatLockdown()) then--Too many 5 mans/old raids don't properly return encounterinprogress
			local targetName = target or "nil"
			self:Debug("CHAT_MSG_MONSTER_YELL from "..npc.." while looking at "..targetName, 2)
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
				local spellName = DBM:GetSpellInfo(spellId) or L.UNKNOWN
				self:Debug("CHAT_MSG_RAID_BOSS_EMOTE fired: "..sender.."'s "..spellName.."("..spellId..")", 2)
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
		if IsInGroup() and not _G["BigWigs"] then
			SendAddonMessage("Transcriptor", msg, IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")--Send any emote to transcriptor, even if no spellid
		end
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		return onMonsterMessage(self, "say", msg)
	end
end

---------------------------
--  Kill/Wipe Detection  --
---------------------------

function checkWipe(self, confirm)
	if #inCombat > 0 then
		if not DBM.savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			DBM.savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
		end
		--hack for no iEEU information is provided.
		if not bossuIdFound then
			for i = 1, 5 do
				if UnitExists("boss"..i) then
					bossuIdFound = true
					break
				end
			end
		end
		local wipe -- 0: no wipe, 1: normal wipe, 2: wipe by UnitExists check.
		if IsInScenarioGroup() or (difficultyIndex == 11) or (difficultyIndex == 12) then -- Scenario mod uses special combat start and must be enabled before sceniro end. So do not wipe.
			wipe = 0
		elseif IsEncounterInProgress() then -- Encounter Progress marked, you obviously in combat with boss. So do not Wipe
			wipe = 0
		elseif DBM.savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- On dead or ghost, unit combat status detection would be fail. If you ghost in instance, that means wipe. But in worldboss, ghost means not wipe. So do not wipe.
			wipe = 0
		elseif bossuIdFound and LastInstanceType == "raid" then -- Combat started by IEEU and no boss exist and no EncounterProgress marked, that means wipe
			wipe = 2
			for i = 1, 5 do
				if UnitExists("boss"..i) then
					wipe = 0 -- Boss found. No wipe
					break
				end
			end
		else -- Unit combat status detection. No combat unit in your party and no EncounterProgress marked, that means wipe
			wipe = 1
			local uId = (IsInRaid() and "raid") or "party"
			for i = 0, GetNumGroupMembers() do
				local id = (i == 0 and "player") or uId..i
				if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
					wipe = 0 -- Someone still in combat. No wipe
					break
				end
			end
		end
		if wipe == 0 then
			self:Schedule(3, checkWipe, self)
		elseif confirm then
			for i = #inCombat, 1, -1 do
				local reason = (wipe == 1 and "No combat unit found in your party." or "No boss found : "..(wipe or "nil"))
				self:Debug("You wiped. Reason : "..reason)
				self:EndCombat(inCombat[i], true)
			end
		else
			local maxDelayTime = (DBM.savedDifficulty == "worldboss" and 15) or 5 --wait 10s more on worldboss do actual wipe.
			for _, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			self:Schedule(maxDelayTime, checkWipe, self, true)
		end
	end
end

function checkBossHealth(self, onlyHighest)
	if #inCombat > 0 then
		for _, v in ipairs(inCombat) do
			if not v.multiMobPullDetection or v.mainBoss then
				self:GetBossHP(v.mainBoss or v.combatInfo.mob or -1, onlyHighest)
			else
				for _, mob in ipairs(v.multiMobPullDetection) do
					self:GetBossHP(mob, onlyHighest)
				end
			end
		end
		self:Schedule(1, checkBossHealth, self, onlyHighest)
	end
end

function checkCustomBossHealth(self, mod)
	mod:CustomHealthUpdate()
	self:Schedule(1, checkCustomBossHealth, self, mod)
end

do
	local tooltipsHidden = false
	--Delayed Guild Combat sync object so we allow time for RL to disable them
	local function delayedGCSync(modId, difficultyIndex, difficultyModifier, name, thisTime, wipeHP)
		if not statusGuildDisabled then
			if thisTime then--Wipe event
				SendAddonMessage("D4", "GCE\t"..modId.."\t5\t1\t"..thisTime.."\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name.."\t"..wipeHP, "GUILD")
			else
				SendAddonMessage("D4", "GCB\t"..modId.."\t2\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name, "GUILD")
			end
		end
	end

	local statVarTable = {
		--Current
		["event5"] = "normal",
		["event20"] = "lfr25",
		["event40"] = "lfr25",
		["normal5"] = "normal",
		["heroic5"] = "heroic",
		["challenge5"] = "challenge",
		["lfr"] = "lfr25",
		["normal"] = "normal",
		["heroic"] = "heroic",
		["mythic"] = "mythic",
		["worldboss"] = "normal",
		["timewalker"] = "timewalker",
		["progressivechallenges"] = "normal",
		--BFA
		["normalwarfront"] = "normal",
		["heroicwarfront"] = "heroic",
		["normalisland"] = "normal",
		["heroicisland"] = "heroic",
		["mythicisland"] = "mythic",
		["teamingisland"] = "mythic",--Blizz uses mythic as fallback, so I will too
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
				self:Debug("StartCombat called by : "..event..". LastInstanceMapID is "..LastInstanceMapID)
				if event ~= "ENCOUNTER_START" then
					self:Debug("This event is started by"..event..". Review ENCOUNTER_START event to ensure if this is still needed", 2)
				end
			else
				self:Debug("StartCombat called by individual mod or unknown reason. LastInstanceMapID is "..LastInstanceMapID)
				event = ""
			end
			--check completed. starting combat
			tinsert(inCombat, mod)
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
			DBM.savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
			local name = mod.combatInfo.name
			local modId = mod.id
			if C_Scenario.IsInScenario() and (mod.addon.type == "SCENARIO") then
				mod.inScenario = true
			end
			mod.inCombat = true
			mod.blockSyncs = nil
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
			if (DBM.savedDifficulty == "worldboss" and startHp < 98) or (event == "UNIT_HEALTH" and delay > 4) or event == "TIMER_RECOVERY" then--Boss was not full health when engaged, disable combat start timer and kill record
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
				if startHp > 98 and (DBM.savedDifficulty == "worldboss" or event == "IEEU") or event == "ENCOUNTER_START" then
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
				end
				--boss health info scheduler
				if mod.CustomHealthUpdate then
					self:Schedule(1, checkCustomBossHealth, self, mod)
				else
					self:Schedule(1, checkBossHealth, self, mod.onlyHighest)
				end
			end
			--process global options
			self:HideBlizzardEvents(1)
			if self.Options.RecordOnlyBosses then
				self:StartLogging(0, nil)
			end
			if self.Options.HideObjectivesFrame and mod.addon.type ~= "SCENARIO" and GetNumTrackedAchievements() == 0 and difficultyIndex ~= 8 and not InCombatLockdown() then
				if ObjectiveTrackerFrame:IsVisible() then
					--ObjectiveTrackerFrame:Hide()
					ObjectiveTracker_Collapse()
					watchFrameRestore = true
				end
			end
			fireEvent("DBM_Pull", mod, delay, synced, startHp)
			self:FlashClientIcon()
			--serperate timer recovery and normal start.
			if event ~= "TIMER_RECOVERY" then
				--add pull count
				if mod.stats and not mod.noStatistics then
					if not mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"] then mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"] = 0 end
					mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"] = mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"] + 1
				end
				--show speed timer
				if self.Options.AlwaysShowSpeedKillTimer2 and mod.stats and not mod.ignoreBestkill and not mod.noStatistics then
					local bestTime
					if difficultyIndex == 8 then--Mythic+/Challenge Mode
						local bestMPRank = mod.stats.challengeBestRank or 0
						if bestMPRank == difficultyModifier then
							--Don't show speed kill timer if not our highest rank. DBM only stores highest rank
							bestTime = mod.stats[statVarTable[DBM.savedDifficulty].."BestTime"]
						end
					else
						bestTime = mod.stats[statVarTable[DBM.savedDifficulty].."BestTime"]
					end
					if bestTime and bestTime > 0 then
						local speedTimer = mod:NewTimer(bestTime, L.SPEED_KILL_TIMER_TEXT, "237538", nil, false)
						speedTimer:Start()
					end
				end
				--update boss left
				if mod.numBoss then
					mod.vb.bossLeft = mod.numBoss
				end
				--elect icon person
				if mod.findFastestComputer and not self.Options.DontSetIcons then
					if self:GetRaidRank() > 0 then
						for i = 1, #mod.findFastestComputer do
							local option = mod.findFastestComputer[i]
							if mod.Options[option] then
								sendSync("IS", UnitGUID("player").."\t"..tostring(DBM.Revision).."\t"..option)
							end
						end
					elseif not IsInGroup() then
						for i = 1, #mod.findFastestComputer do
							local option = mod.findFastestComputer[i]
							if mod.Options[option] then
								DBM.canSetIcons[option] = true
							end
						end
					end
				end
				--call OnCombatStart
				if mod.OnCombatStart then
					local startEvent = syncedEvent or event
					mod:OnCombatStart(delay or 0, startEvent == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or startEvent == "SPELL_CAST_SUCCESS" or startEvent == "MONSTER_MESSAGE", startEvent == "ENCOUNTER_START")
				end
				--send "C" sync
				if not synced then
					sendSync("C", (delay or 0).."\t"..modId.."\t"..(mod.revision or 0).."\t"..startHp.."\t"..tostring(DBM.Revision).."\t"..(mod.hotfixNoticeRev or 0).."\t"..event)
				end
				if UnitIsGroupLeader("player") then
					if self.Options.DisableGuildStatus then
						sendSync("DGP")
					end
					if self.Options.DisableStatusWhisper and (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) then
						sendSync("DSW")
					end
				end
				--show bigbrother check
				local bigBrother = _G["BigBrother"]
				if self.Options.ShowBigBrotherOnCombatStart and bigBrother and type(bigBrother.ConsumableCheck) == "function" then
					if self.Options.BigBrotherAnnounceToRaid then
						bigBrother:ConsumableCheck("RAID")
					else
						bigBrother:ConsumableCheck("SELF")
					end
				end
				--show enage message
				if self.Options.ShowEngageMessage and not mod.noStatistics then
					if mod.ignoreBestkill and (DBM.savedDifficulty == "worldboss") then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
						self:AddMsg(L.COMBAT_STARTED_IN_PROGRESS:format(difficultyText..name))
					elseif mod.ignoreBestkill and mod.inScenario then
						self:AddMsg(L.SCENARIO_STARTED_IN_PROGRESS:format(difficultyText..name))
					else
						if mod.addon.type == "SCENARIO" then
							self:AddMsg(L.SCENARIO_STARTED:format(difficultyText..name))
						else
							self:AddMsg(L.COMBAT_STARTED:format(difficultyText..name))
							if (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not statusGuildDisabled and not self.Options.DisableGuildStatus then--Only send relevant content, not guild beating down lich king or LFR.
								self:Schedule(1.5, delayedGCSync, modId, difficultyIndex, difficultyModifier, name)
							end
						end
					end
				end
				--stop pull count
				local dummyMod = self:GetModByName("PullTimerCountdownDummy")
				if dummyMod then--stop pull timer
					dummyMod.text:Cancel()
					dummyMod.timer:Stop()
					if not DBM.Options.DontShowPTCountdownText then
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
				fireEvent("DBM_MusicStart", "BossEncounter")
				if self.Options.EventSoundMusic and self.Options.EventSoundMusic ~= "None" and self.Options.EventSoundMusic ~= "" and not (self.Options.EventMusicMythicFilter and (DBM.savedDifficulty == "mythic" or DBM.savedDifficulty == "challenge")) then
					if not self.Options.RestoreSettingMusic then
						self.Options.RestoreSettingMusic = tonumber(GetCVar("Sound_EnableMusic")) or 1
						if self.Options.RestoreSettingMusic == 0 then
							SetCVar("Sound_EnableMusic", 1)
						else
							self.Options.RestoreSettingMusic = nil--Don't actually need it
						end
					end
					local path = "MISSING"
					if self.Options.EventSoundMusic == "Random" then
						local usedTable = self.Options.EventSoundMusicCombined and DBM.Music or DBM.BattleMusic
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
						self:Debug("Starting combat music with file: "..path)
					end
				end
			else
				self:AddMsg(L.COMBAT_STATE_RECOVERED:format(difficultyText..name, strFromTime(delay)))
				if mod.OnTimerRecovery then
					mod:OnTimerRecovery()
				end
			end
			if DBM.savedDifficulty == "worldboss" and self.Options.EnableWBSharing and not mod.noWBEsync then
				if lastBossEngage[modId..playerRealm] and (GetTime() - lastBossEngage[modId..playerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
				lastBossEngage[modId..playerRealm] = GetTime()--Update last engage time, that way we ignore our own sync
				SendWorldSync(self, "WBE", modId.."\t"..playerRealm.."\t"..startHp.."\t8\t"..name)
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
			if cId ~= 0 and not DBM.bossHealth[cId] and DBM.bossIds[cId] and UnitAffectingCombat(uId) and not (UnitPlayerOrPetInRaid(uId) or UnitPlayerOrPetInParty(uId)) and healthCombatInitialized then -- StartCombat by UNIT_HEALTH.
				if DBM.combatInfo[LastInstanceMapID] then
					for _, v in ipairs(DBM.combatInfo[LastInstanceMapID]) do
						if v.mod.Options.Enabled and not v.mod.disableHealthCombat and v.type:find("combat") and (v.multiMobPullDetection and checkEntry(v.multiMobPullDetection, cId) or v.mob == cId) then
							if v.mod.noFriendlyEngagement and UnitIsFriend("player", uId) then return end
							-- Delay set, > 97% = 0.5 (consider as normal pulling), max dealy limited to 20s.
							self:StartCombat(v.mod, health > 97 and 0.5 or mmin(GetTime() - lastCombatStarted, 20), "UNIT_HEALTH", nil, health)
						end
					end
				end
			end
			if self.Options.AFKHealthWarning and UnitIsUnit(uId, "player") and (health < 85) and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
				self:PlaySound(8585)--So fire an alert sound to save yourself from this person's behavior.
				self:AddMsg(L.AFK_WARNING:format(health))
			end
		end
	end

	function DBM:EndCombat(mod, wipe, srmIncluded)
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
			if DBM.enableIcons and not self.Options.DontSetIcons and not self.Options.DontRestoreIcons then
				-- restore saved previous icon
				for uId, icon in pairs(mod.iconRestore) do
					SetRaidTarget(uId, icon)
				end
				twipe(mod.iconRestore)
			end
			mod.inCombat = false
			mod.blockSyncs = true
			if mod.combatInfo.killMobs then
				for i, _ in pairs(mod.combatInfo.killMobs) do
					mod.combatInfo.killMobs[i] = true
				end
			end
			if not DBM.savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
				DBM.savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local name = mod.combatInfo.name
			local modId = mod.id
			if wipe and mod.stats and not mod.noStatistics then
				mod.lastWipeTime = GetTime()
				--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
				local thisTime = GetTime() - mod.combatInfo.pull
				local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
				local wipeHP = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or L.UNKNOWN
				if mod.vb.phase then
					wipeHP = wipeHP.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
				end
				if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
					local bossesKilled = mod.numBoss - mod.vb.bossLeft
					wipeHP = wipeHP.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
				end
				local totalPulls = mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"]
				local totalKills = mod.stats[statVarTable[DBM.savedDifficulty].."Kills"]
				if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
					totalPulls = totalPulls - 1
					mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"] = totalPulls
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT:format(difficultyText..name, strFromTime(thisTime)))
						else
							self:AddMsg(L.COMBAT_ENDED_AT:format(difficultyText..name, wipeHP, strFromTime(thisTime)))
							--No reason to GCE it here, so omited on purpose.
						end
					end
				else
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(L.SCENARIO_ENDED_AT_LONG:format(difficultyText..name, strFromTime(thisTime), totalPulls - totalKills))
						else
							self:AddMsg(L.COMBAT_ENDED_AT_LONG:format(difficultyText..name, wipeHP, strFromTime(thisTime), totalPulls - totalKills))
							if (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not self.Options.DisableGuildStatus then
								self:Schedule(1.5, delayedGCSync, modId, difficultyIndex, difficultyModifier, name, strFromTime(thisTime), wipeHP)
							end
						end
					end
					if self.Options.EventSoundWipe and self.Options.EventSoundWipe ~= "None" and self.Options.EventSoundWipe ~= "" then
						if self.Options.EventSoundWipe == "Random" then
							if #self.Defeat >= 3 then
								local random = fastrandom(3, #self.Defeat)
								self:PlaySoundFile(DBM.Defeat[random].value)
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
							msg = msg or chatPrefixShort..L.WHISPER_SCENARIO_END_WIPE_STATS:format(playerName, difficultyText..(name or ""), totalPulls - totalKills)
						else
							msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, difficultyText..(name or ""), wipeHP, totalPulls - totalKills)
						end
					else
						if scenario then
							msg = msg or chatPrefixShort..L.WHISPER_SCENARIO_END_WIPE:format(playerName, difficultyText..(name or ""))
						else
							msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_WIPE_AT:format(playerName, difficultyText..(name or ""), wipeHP)
						end
					end
					sendWhisper(k, msg)
				end
				fireEvent("DBM_Wipe", mod)
			elseif not wipe and mod.stats and not mod.noStatistics then
				mod.lastKillTime = GetTime()
				local thisTime = GetTime() - (mod.combatInfo.pull or 0)
				local lastTime = mod.stats[statVarTable[DBM.savedDifficulty].."LastTime"]
				local bestTime = mod.stats[statVarTable[DBM.savedDifficulty].."BestTime"]
				if not mod.stats[statVarTable[DBM.savedDifficulty].."Kills"] or mod.stats[statVarTable[DBM.savedDifficulty].."Kills"] < 0 then mod.stats[statVarTable[DBM.savedDifficulty].."Kills"] = 0 end
				--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats[statVarTable[DBM.savedDifficulty].."Kills"] = mod.stats[statVarTable[DBM.savedDifficulty].."Kills"] + 1
				if mod.stats[statVarTable[DBM.savedDifficulty].."Kills"] > mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"] then mod.stats[statVarTable[DBM.savedDifficulty].."Kills"] = mod.stats[statVarTable[DBM.savedDifficulty].."Pulls"] end
				if not mod.ignoreBestkill and mod.combatInfo.pull then
					mod.stats[statVarTable[DBM.savedDifficulty].."LastTime"] = thisTime
					--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
					if bestTime and bestTime > 0 and bestTime < 1.5 then
						mod.stats[statVarTable[DBM.savedDifficulty].."BestTime"] = thisTime
					else
						if difficultyIndex == 8 then--Mythic+/Challenge Mode
							if mod.stats.challengeBestRank > difficultyModifier then--Don't save time stats at all
								--DO nothing
							elseif mod.stats.challengeBestRank < difficultyModifier then--Update best time and best rank, even if best time is lower (for a lower rank)
								mod.stats.challengeBestRank = difficultyModifier--Update best rank
								mod.stats[statVarTable[DBM.savedDifficulty].."BestTime"] = thisTime--Write this time no matter what.
							else--Best rank must match current rank, so update time normally
								mod.stats[statVarTable[DBM.savedDifficulty].."BestTime"] = mmin(bestTime or mhuge, thisTime)
							end
						else
							mod.stats[statVarTable[DBM.savedDifficulty].."BestTime"] = mmin(bestTime or mhuge, thisTime)
						end
					end
				end
				local totalKills = mod.stats[statVarTable[DBM.savedDifficulty].."Kills"]
				if self.Options.ShowDefeatMessage then
					local msg
					local thisTimeString = thisTime and strFromTime(thisTime)
					if not mod.combatInfo.pull then--was a bad pull so we ignored thisTime, should never happen
						if scenario then
							msg = L.SCENARIO_COMPLETE:format(difficultyText..name, L.UNKNOWN)
						else
							msg = L.BOSS_DOWN:format(difficultyText..name, L.UNKNOWN)
						end
					elseif mod.ignoreBestkill then--Should never happen in a scenario so no need for scenario check.
						if scenario then
							msg = L.SCENARIO_COMPLETE_I:format(difficultyText..name, totalKills)
						else
							msg = L.BOSS_DOWN_I:format(difficultyText..name, totalKills)
						end
					elseif not lastTime then
						if scenario then
							msg = L.SCENARIO_COMPLETE:format(difficultyText..name, thisTimeString)
						else
							msg = L.BOSS_DOWN:format(difficultyText..name, thisTimeString)
						end
					elseif thisTime < (bestTime or mhuge) then
						if scenario then
							msg = L.SCENARIO_COMPLETE_NR:format(difficultyText..name, thisTimeString, strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_NR:format(difficultyText..name, thisTimeString, strFromTime(bestTime), totalKills)
						end
					else
						if scenario then
							msg = L.SCENARIO_COMPLETE_L:format(difficultyText..name, thisTimeString, strFromTime(lastTime), strFromTime(bestTime), totalKills)
						else
							msg = L.BOSS_DOWN_L:format(difficultyText..name, thisTimeString, strFromTime(lastTime), strFromTime(bestTime), totalKills)
						end
					end
					if not scenario and thisTimeString and (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not statusGuildDisabled and not self.Options.DisableGuildStatus then
						SendAddonMessage("D4", "GCE\t"..modId.."\t5\t0\t"..thisTimeString.."\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name, "GUILD")
					end
					self:Schedule(1, self.AddMsg, self, msg)
				end
				local msg
				for k, _ in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or chatPrefixShort..L.WHISPER_SCENARIO_END_KILL_STATS:format(playerName, difficultyText..(name or ""), totalKills)
						else
							msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_KILL_STATS:format(playerName, difficultyText..(name or ""), totalKills)
						end
					else
						if scenario then
							msg = msg or chatPrefixShort..L.WHISPER_SCENARIO_END_KILL:format(playerName, difficultyText..(name or ""))
						else
							msg = msg or chatPrefixShort..L.WHISPER_COMBAT_END_KILL:format(playerName, difficultyText..(name or ""))
						end
					end
					sendWhisper(k, msg)
				end
				fireEvent("DBM_Kill", mod)
				if DBM.savedDifficulty == "worldboss" and self.Options.EnableWBSharing and not mod.noWBEsync then
					if lastBossDefeat[modId..playerRealm] and (GetTime() - lastBossDefeat[modId..playerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
					lastBossDefeat[modId..playerRealm] = GetTime()--Update last defeat time before we send it, so we don't handle our own sync
					SendWorldSync(self, "WBD", modId.."\t"..playerRealm.."\t8\t"..name)
				end
				if self.Options.EventSoundVictory2 and self.Options.EventSoundVictory2 ~= "None" and self.Options.EventSoundVictory2 ~= "" then
					if self.Options.EventSoundVictory2 == "Random" then
						if #self.Victory >= 3 then
							local random = fastrandom(3, #self.Victory)
							self:PlaySoundFile(self.Victory[random].value)
						end
					else
						self:PlaySoundFile(self.Options.EventSoundVictory2, nil, true)
					end
				end
			end
			if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
			if mod.OnLeavingCombat then delayedFunction = mod.OnLeavingCombat end
			if #inCombat == 0 then--prevent error if you pulled multiple boss. (Earth, Wind and Fire)
				statusWhisperDisabled = false
				statusGuildDisabled = false
				if self.Options.RecordOnlyBosses then
					self:Schedule(10, self.StopLogging, self)--small delay to catch kill/died combatlog events
				end
				self:HideBlizzardEvents(0)
				self:Unschedule(checkBossHealth)
				self:Unschedule(checkCustomBossHealth)
				self.Arrow:Hide(true)
				if watchFrameRestore and not InCombatLockdown() then
					--ObjectiveTrackerFrame:Show()
					ObjectiveTracker_Expand()
					watchFrameRestore = false
				end
				if tooltipsHidden then
					--Better or cleaner way?
					tooltipsHidden = false
					GameTooltip:SetScript("OnShow", GameTooltip.Show)
				end
				if self.Options.DisableSFX then
					SetCVar("Sound_EnableSFX", 1)
				end
				--cache table
				twipe(autoRespondSpam)
				twipe(DBM.bossHealth)
				twipe(DBM.bossHealthuIdCache)
				twipe(DBM.bossuIdCache)
				--sync table
				twipe(DBM.canSetIcons)
				twipe(iconSetRevision)
				twipe(iconSetPerson)
				twipe(DBM.addsGUIDs)
				bossuIdFound = false
				eeSyncSender = {}
				eeSyncReceived = 0
				twipe(DBM.targetMonitor)
				self:CreatePizzaTimer(time, "", nil, nil, nil, true)--Auto Terminate infinite loop timers on combat end
				self:TransitionToDungeonBGM(false, true)
				self:Schedule(22, self.TransitionToDungeonBGM, self)
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
				sendSync("K", cId)
			end
			v.combatInfo.killMobs[cId] = false
			if v.numBoss then
				v.vb.bossLeft = (v.vb.bossLeft or v.numBoss) - 1
				self:Debug("Boss left - "..v.vb.bossLeft.."/"..v.numBoss, 2)
			end
			local allMobsDown = true
			for _, k in pairs(v.combatInfo.killMobs) do
				if k then
					allMobsDown = false
					break
				end
			end
			if allMobsDown then
				self:EndCombat(v)
			end
		elseif cId == v.combatInfo.mob and not v.combatInfo.killMobs and not v.combatInfo.multiMobPullDetection then
			if not synced then
				sendSync("K", cId)
			end
			self:EndCombat(v)
		end
	end
end

do
	local autoLog = false
	local autoTLog = false

	local function isCurrentContent()
		if instanceDifficultyBylevel[LastInstanceMapID] and (instanceDifficultyBylevel[LastInstanceMapID][1] >= playerLevel) and (instanceDifficultyBylevel[LastInstanceMapID][2] == 3) or (difficultyModifier or 0) > 0 then--current player level raid or any M+ dungeon
			return true
		end
		return false
	end

	function DBM:StartLogging(timer, checkFunc)
		self:Unschedule(DBM.StopLogging)
		if self.Options.LogOnlyNonTrivial and ((LastInstanceType ~= "raid" and difficultyModifier == 0) or IsPartyLFG() or not isCurrentContent()) then return end
		if self.Options.AutologBosses then--Start logging here to catch pre pots.
			if not LoggingCombat() then
				autoLog = true
				self:AddMsg("|cffffff00"..COMBATLOGENABLED.."|r")
				LoggingCombat(true)
				if checkFunc then
					self:Unschedule(checkFunc)
					self:Schedule(timer+10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
				end
			end
		end
		local transcriptor = _G["Transcriptor"]
		if self.Options.AdvancedAutologBosses and transcriptor then
			if not transcriptor:IsLogging() then
				autoTLog = true
				self:AddMsg("|cffffff00"..L.TRANSCRIPTOR_LOG_START.."|r")
				transcriptor:StartLog(1)
			end
			if checkFunc then
				self:Unschedule(checkFunc)
				self:Schedule(timer+10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
			end
		end
	end

	function DBM:StopLogging()
		if self.Options.AutologBosses and LoggingCombat() and autoLog then
			autoLog = false
			self:AddMsg("|cffffff00"..COMBATLOGDISABLED.."|r")
			LoggingCombat(false)
		end
		local transcriptor = _G["Transcriptor"]
		if self.Options.AdvancedAutologBosses and transcriptor and autoTLog then
			if transcriptor:IsLogging() then
				autoTLog = false
				self:AddMsg("|cffffff00"..L.TRANSCRIPTOR_LOG_END.."|r")
				transcriptor:StopLog(1)
			end
		end
	end
end

function DBM:SetCurrentSpecInfo()
	currentSpecGroup = GetSpecialization() or 1
	DBM.currentSpecID, currentSpecName = GetSpecializationInfo(currentSpecGroup)--give temp first spec id for non-specialization char. no one should use dbm with no specialization, below level 10, should not need dbm.
	DBM.currentSpecID = tonumber(DBM.currentSpecID)
end

--TODO C_IslandsQueue.GetIslandDifficultyInfo(), if 38-40 don't work
function DBM:GetCurrentInstanceDifficulty()
	local _, instanceType, difficulty, difficultyName, _, _, _, _, instanceGroupSize = GetInstanceInfo()
	if difficulty == 0 or difficulty == 172 or (difficulty == 1 and instanceType == "none") or C_Garrison:IsOnGarrisonMap() then--draenor field returns 1, causing world boss mod bug.
		return "worldboss", RAID_INFO_WORLD_BOSS.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 1 then--5 man Normal Dungeon
		return "normal5", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 2 then--5 man Heroic Dungeon
		return "heroic5", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 3 then--Legacy 10 man Normal Raid
		return "normal10", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 4 then--Legacy 25 man Normal Raid
		return "normal25", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 5 then--Legacy 10 man Heroic Raid
		return "heroic10", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 6 then--Legacy 25 man Heroic Raid
		return "heroic25", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 7 then--Legacy 25 man LFR (ie pre WoD zones)
		return "lfr25", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 8 then--Dungeon, Mythic+ (Challenge modes in mists and wod)
		local keystoneLevel = C_ChallengeMode.GetActiveKeystoneInfo() or 0
		return "challenge5", PLAYER_DIFFICULTY6.."+ ("..keystoneLevel..") - ", difficulty, instanceGroupSize, keystoneLevel
	elseif difficulty == 9 then--Legacy 40 man raids, no longer returned as index 3 (normal 10man raids)
		return "normal40", difficultyName.." - ",difficulty, instanceGroupSize, 0
	elseif difficulty == 11 then--Heroic Scenario (mostly Mists of pandaria)
		return "heroicscenario", difficultyName.." - ",difficulty, instanceGroupSize, 0
	elseif difficulty == 12 then--Normal Scenario (mostly Mists of pandaria)
		return "normalscenario", difficultyName.." - ",difficulty, instanceGroupSize, 0
	elseif difficulty == 14 then--Flexible Normal Raid
		return "normal", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 15 then--Flexible Heroic Raid
		return "heroic", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 16 then--Mythic 20 man Raid
		return "mythic", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 17 or difficulty == 151 then--Flexible LFR (ie post WoD zones)/8.3+ LFR
		return "lfr", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 18 then--Special event 40 player LFR Queue (used by molten core aniversery event)
		return "event40", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 19 then--Special event 5 player queue (used by wod pre expansion event that had miniturized version of UBRS remake)
		return "event5", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 20 then--Special event 20 player LFR Queue (never used yet)
		return "event20", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 23 then--Mythic 5 man Dungeon
		return "mythic", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 24 or difficulty == 33 then--Timewalking Dungeon, Timewalking Raid
		return "timewalker", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 38 then--Normal BfA Island expedition
		return "normalisland", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 39 then--Heroic BfA Island expedition
		return "heroicisland", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 40 then--Mythic BfA Island expedition
		return "mythicisland", difficultyName.." - ", difficulty, instanceGroupSize, 0
	elseif difficulty == 147 then--Normal BfA Warfront
		return "normalwarfront", difficultyName.." - ",difficulty, instanceGroupSize, 0
	elseif difficulty == 148 then--20 man classic raid
		return "normal20", difficultyName.." - ",difficulty, instanceGroupSize, 0
	elseif difficulty == 149 then--Heroic BfA Warfront
		return "heroicwarfront", difficultyName.." - ",difficulty, instanceGroupSize, 0
	elseif difficulty == 152 or difficulty == 167 then--Visions of Nzoth (bfa), Torghast (shadowlands)
		return "progressivechallenges", difficultyName.." - ",difficulty, instanceGroupSize, 0
	elseif difficulty == 153 then---Teaming BfA? Island expedition
		return "teamingisland", difficultyName.." - ",difficulty, instanceGroupSize, 0
	else--failsafe
		return "normal", "", difficulty, instanceGroupSize, 0
	end
end

function DBM:GetCurrentArea()
	return LastInstanceMapID
end

function DBM:GetGroupSize()
	return LastGroupSize
end

function DBM:GetKeyStoneLevel()
	return difficultyModifier
end

function DBM:HasMapRestrictions()
	--Check playerX and playerY. if they are nil restrictions are active
	--Restrictions active in all party, raid, pvp, arena maps. No restrictions in "none" or "scenario"
	local playerX, playerY = UnitPosition("player")
	if not playerX or not playerY then
		return true
	end
	return false
end

do
	local LSMMediaCacheBuilt, sharedMediaFileCache, validateCache = false, {}, {}

	local function buildLSMFileCache()
		local hashtable = LibStub("LibSharedMedia-3.0", true):HashTable("sound")
		local keytable = {}
		for k in next, hashtable do
			tinsert(keytable, k)
		end
		for i = 1, #keytable do
			sharedMediaFileCache[hashtable[keytable[i]]] = true
		end
		LSMMediaCacheBuilt = true
	end

	function DBM:ValidateSound(path, log, ignoreCustom)
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
			if #splitTable >= 3 and splitTable[1]:lower() == "interface" and splitTable[2]:lower() == "addons" and (not ignoreCustom or splitTable[3]:lower() == "dbm-customsounds") then -- We're an addon sound
				validateCache[path] = {
					exists = IsAddOnLoaded(splitTable[3]),
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

	local function playSound(self, path, ignoreSFX, validate)
		if self.Options.SilentMode or path == "" or path == "None" then
			return
		end
		local soundSetting = self.Options.UseSoundChannel
		if type(path) == "number" then
			self:Debug("PlaySound playing with media " .. path, 3)
			if soundSetting == "Dialog" then
				PlaySound(path, "Dialog", false)
			elseif ignoreSFX or soundSetting == "Master" then
				PlaySound(path, "Master", false)
			else
				PlaySound(path) -- Using SFX channel, leave forceNoDuplicates on.
			end
			fireEvent("DBM_PlaySound", path)
		else
			if validate and not self:ValidateSound(path, true, true) then
				return
			end
			self:Debug("PlaySoundFile playing with media " .. path, 3)
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

	function DBM:PlaySoundFile(path, ignoreSFX, validate)
		playSound(self, path, ignoreSFX, validate)
	end

	function DBM:PlaySound(path, ignoreSFX, validate)
		playSound(self, path, ignoreSFX, validate)
	end
end

--Future proofing EJ_GetSectionInfo compat layer to make it easier updatable.
function DBM:EJ_GetSectionInfo(sectionID)
	local info = EJ_GetSectionInfo(sectionID)
	if not info then
		if self.Options.BadIDAlert then
			self:AddMsg("|cffff0000Invalid call to EJ_GetSectionInfo for sectionID: |r"..sectionID..". Please report this bug")
		else
			self:Debug("|cffff0000Invalid call to EJ_GetSectionInfo for sectionID: |r"..sectionID)
		end
		return nil
	end
	local flag1, flag2, flag3, flag4
	local flags = GetSectionIconFlags(sectionID)
	if flags then
		flag1, flag2, flag3, flag4 = unpack(flags)
	end
	return info.title, info.description, info.headerType, info.abilityIcon, info.creatureDisplayID, info.siblingSectionID, info.firstChildSectionID, info.filteredByDifficulty, info.link, info.startsOpen, flag1, flag2, flag3, flag4
end

--Handle new spell name requesting with wrapper, to make api changes easier to handle
function DBM:GetSpellInfo(spellId)
	local name, rank, icon, castingTime, minRange, maxRange, returnedSpellId  = GetSpellInfo(spellId)
	if not returnedSpellId then--Bad request all together
		if type(spellId) == "string" then
			self:Debug("|cffff0000Invalid call to GetSpellInfo for spellID: |r"..spellId.." as a string!")
		else
			if spellId > 4 then
				if self.Options.BadIDAlert then
					self:AddMsg("|cffff0000Invalid call to GetSpellInfo for spellID: |r"..spellId..". Please report this bug")
				else
					self:Debug("|cffff0000Invalid call to GetSpellInfo for spellID: |r"..spellId)
				end
			end
		end
		return nil
	else--Good request, return now
		return name, rank, icon, castingTime, minRange, maxRange, returnedSpellId
	end
end

function DBM:UnitAura(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3
		end
	end
end

function DBM:UnitDebuff(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3
		end
	end
end

function DBM:UnitBuff(uId, spellInput, spellInput2, spellInput3, spellInput4)
	if not uId then return end
	for i = 1, 60 do
		local spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3 = UnitBuff(uId, i)
		if not spellName then return end
		if spellInput == spellName or spellInput == spellId or spellInput2 == spellName or spellInput2 == spellId or spellInput3 == spellName or spellInput3 == spellId or spellInput4 == spellName or spellInput4 == spellId then
			return spellName, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3
		end
	end
end

function DBM:UNIT_DIED(args)
	local GUID = args.destGUID
	if self:IsCreatureGUID(GUID) then
		self:OnMobKill(self:GetCIDFromGUID(GUID))
	end
	----GUIDIsPlayer
	if self.Options.AFKHealthWarning and GUID == UnitGUID("player") and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
		self:FlashClientIcon()
		self:PlaySound(8585)--So fire an alert sound to save yourself from this person's behavior.
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
	local clientUsed = {}
	local sortMe = {}

	local function sort(v1, v2)
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

	function DBM:RequestTimers(requestNum)
		twipe(sortMe)
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
			if v.name ~= playerName and UnitIsConnected(v.id) and (not UnitIsGhost(v.id)) and UnitRealmRelationship(v.id) ~= 2 and (GetTime() - (clientUsed[v.name] or 0)) > 10 then
				listNum = listNum + 1
				if listNum == requestNum then
					selectedClient = v
					clientUsed[v.name] = GetTime()
					break
				end
			end
		end
		if not selectedClient then return end
		self:Debug("Requesting timer recovery to "..selectedClient.name)
		requestedFrom[selectedClient.name] = true
		requestTime = GetTime()
		SendAddonMessage("D4", "RT", "WHISPER", selectedClient.name)
	end

	function DBM:ReceiveCombatInfo(sender, mod, time)
		if dbmIsEnabled and requestedFrom[sender] and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			self:StartCombat(mod, time, "TIMER_RECOVERY")
			--Recovery successful, someone sent info, abort other recovery requests
			self:Unschedule(self.RequestTimers)
			twipe(requestedFrom)
		end
	end

	function DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, ...)
		if requestedFrom[sender] and (GetTime() - requestTime) < 5 then
			local lag = select(4, GetNetStats()) / 1000
			for _, v in ipairs(mod.timers) do
				if v.id == id then
					v:Start(totalTime, ...)
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
			end
		end
	end
end

do
	local spamProtection = {}
	function DBM:SendTimers(target)
		self:Debug("SendTimers requested by "..target, 2)
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
			if self.Bars:GetBar(L.TIMER_BREAK) then
				local remaining = self.Bars:GetBar(L.TIMER_BREAK).timer
				SendAddonMessage("D4", "BTR3\t"..remaining, "WHISPER", target)
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
		self:Debug("SendPVPTimers requested by "..target, 2)
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
	return SendAddonMessage("D4", ("CI\t%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), "WHISPER", target)
end

function DBM:SendTimerInfo(mod, target)
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
					SendAddonMessage("D4", ("TI\t%s\t%s\t%s\t%s"):format(mod.id, timeLeft, totalTime, uId), "WHISPER", target)
				end
			end
		end
	end
end

function DBM:SendVariableInfo(mod, target)
	for vname, v in pairs(mod.vb) do
		local v2 = tostring(v)
		if v2 then
			SendAddonMessage("D4", ("VI\t%s\t%s\t%s"):format(mod.id, vname, v2), "WHISPER", target)
		end
	end
end

do
	function DBM:PLAYER_ENTERING_WORLD()
		if self.Options.ShowReminders then
			C_TimerAfter(25, function() if self.Options.SilentMode then self:AddMsg(L.SILENT_REMINDER) end end)
			C_TimerAfter(30, function() if not self.Options.SettingsMessageShown then self.Options.SettingsMessageShown = true self:AddMsg(L.HOW_TO_USE_MOD) end end)
		end
		if type(C_ChatInfo.RegisterAddonMessagePrefix) == "function" then
			if not C_ChatInfo.RegisterAddonMessagePrefix("D4") then -- main prefix for DBM4
				self:AddMsg("Error: unable to register DBM addon message prefix (reached client side addon message filter limit), synchronization will be unavailable") -- TODO: confirm that this actually means that the syncs won't show up
			end
			if not C_ChatInfo.RegisterAddonMessagePrefix("BigWigs") then
				self:AddMsg("Error: unable to register BigWigs addon message prefix (reached client side addon message filter limit), BigWigs version checks will be unavailable")
			end
			if not C_ChatInfo.RegisterAddonMessagePrefix("Transcriptor") then
				self:AddMsg("Error: unable to register Transcriptor addon message prefix (reached client side addon message filter limit)")
			end
		end
		--Check if any previous changed cvars were not restored and restore them
		if 	self.Options.DisableSFX then
			SetCVar("Sound_EnableSFX", 1)
			self:Debug("Restoring Sound_EnableSFX CVAR")
		end
		--RestoreSettingMusic doens't need restoring here, since zone change transition will handle it
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
				alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
			end
		end
		return alive
	end

	--Cleanup in 8.x with C_Map.GetMapGroupMembersInfo
	local function getNumRealAlivePlayers()
		local alive = 0
		local isInInstance = IsInInstance() or false
		local currentMapId = isInInstance and select(4, UnitPosition("player")) or C_Map.GetBestMapForUnit("player") or 0
		local currentMapName = C_Map.GetMapInfo(currentMapId) or L.UNKNOWN
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if isInInstance and select(4, UnitPosition("raid"..i)) == currentMapId or select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
				end
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				if isInInstance and select(4, UnitPosition("party"..i)) == currentMapId or select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
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
		if statusWhisperDisabled then return end--RL has disabled status whispers for entire raid.
		if not checkForSafeSender(sender, true, true, true, isRealIdMessage) then return end--Automatically reject all whisper functions from non friends, non guildies, or people in group with us
		if msg:find(chatPrefix) and not InCombatLockdown() and DBM:AntiSpam(60, "Ogron") and DBM.Options.AutoReplySound then
			--Might need more validation if people figure out they can just whisper people with chatPrefix to trigger it.
			--However if I have to add more validation it probably won't work in most languages :\ So lets hope antispam and combat check is enough
			DBM:PlaySound(41928)--"sound\\creature\\aggron1\\VO_60_HIGHMAUL_AGGRON_1_AGGRO_1.ogg"
		elseif msg == "status" and #inCombat > 0 and DBM.Options.AutoRespond then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				DBM.savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for _, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if mod.noStatistics then return end
			if IsInScenarioGroup() and not mod.soloChallenge then return end--status not really useful on scenario mods since there is no way to report progress as a percent. We just ignore it.
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or L.UNKNOWN
			if mod.vb.phase then
				hpText = hpText.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			sendWhisper(sender, chatPrefix..L.STATUS_WHISPER:format(difficultyText..(mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
		elseif #inCombat > 0 and DBM.Options.AutoRespond then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				DBM.savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for _, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if mod.noStatistics then return end
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or L.UNKNOWN
			if mod.vb.phase then
				hpText = hpText.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			if not autoRespondSpam[sender] then
				if IsInScenarioGroup() and not mod.soloChallenge then
					sendWhisper(sender, chatPrefix..L.AUTO_RESPOND_WHISPER_SCENARIO:format(playerName, difficultyText..(mod.combatInfo.name or ""), getNumAlivePlayers(), DBM:GetNumGroupMembers()))
				else
					sendWhisper(sender, chatPrefix..L.AUTO_RESPOND_WHISPER:format(playerName, difficultyText..(mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
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
		unscheduleAll()
		dbmIsEnabled = false
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
end

-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix)
	local tag = prefix or (self.localization and self.localization.general.name) or L.DBM
	local frame = _G[tostring(DBM.Options.ChatFrame)]
	frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
	if prefix ~= false then
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(tag), tostring(text)), 0.41, 0.8, 0.94)
	else
		frame:AddMessage(text, 0.41, 0.8, 0.94)
	end
end
AddMsg = DBM.AddMsg

function DBM:Debug(text, level)
	--But we still want to generate callbacks for level 1 and 2 events
	if (level or 1) < 3 then
		fireEvent("DBM_Debug", text, level)
	end
	if not self.Options or not self.Options.DebugMode then return end
	if (level or 1) <= DBM.Options.DebugLevel then
		local frame = _G[tostring(DBM.Options.ChatFrame)]
		frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
		frame:AddMessage("|cffff7d0aDBM Debug:|r "..text, 1, 1, 1)
	end
end

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer1, testTimer2, testTimer3, testTimer4, testTimer5, testTimer6, testTimer7, testTimer8
	local testSpecialWarning1, testSpecialWarning2, testSpecialWarning3
	function DBM:DemoMode()
		if not testMod then
			testMod = self:NewMod("TestMod")
			self:GetModLocalization("TestMod"):SetGeneralLocalization{ name = "Test Mod" }
			testWarning1 = testMod:NewAnnounce("%s", 1, "136116")--Interface\\Icons\\Spell_Nature_WispSplode
			testWarning2 = testMod:NewAnnounce("%s", 2, "136194")
			testWarning3 = testMod:NewAnnounce("%s", 3, "135826")
			testTimer1 = testMod:NewTimer(20, "%s", "136116", nil, nil)
			testTimer2 = testMod:NewTimer(20, "%s ", "134170", nil, nil, 1)
			testTimer3 = testMod:NewTimer(20, "%s  ", "136194", nil, nil, 3, L.MAGIC_ICON, nil, 1, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer4 = testMod:NewTimer(20, "%s   ", "136116", nil, nil, 4, L.INTERRUPT_ICON)
			testTimer5 = testMod:NewTimer(20, "%s    ", "135826", nil, nil, 2, L.HEALER_ICON, nil, 3, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer6 = testMod:NewTimer(20, "%s     ", "136116", nil, nil, 5, L.TANK_ICON, nil, 2, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer7 = testMod:NewTimer(20, "%s      ", "136116", nil, nil, 6)
			testTimer8 = testMod:NewTimer(20, "%s       ", "136116", nil, nil, 7)
			testSpecialWarning1 = testMod:NewSpecialWarning("%s", nil, nil, nil, 1, 2)
			testSpecialWarning2 = testMod:NewSpecialWarning(" %s ", nil, nil, nil, 2, 2)
			testSpecialWarning3 = testMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3, 2) -- hack: non auto-generated special warnings need distinct names (we could go ahead and give them proper names with proper localization entries, but this is much easier)
		end
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

DBM.Bars:SetAnnounceHook(function(bar)
	local prefix
	if bar.color and bar.color.r == 1 and bar.color.g == 0 and bar.color.b == 0 then
		prefix = L.HORDE or FACTION_HORDE
	elseif bar.color and bar.color.r == 0 and bar.color.g == 0 and bar.color.b == 1 then
		prefix = L.ALLIANCE or FACTION_ALLIANCE
	end
	if prefix then
		return ("%s: %s  %d:%02d"):format(prefix, _G[bar.frame:GetName().."BarName"]:GetText(), floor(bar.timer / 60), bar.timer % 60)
	end
end)

function DBM:Capitalize(str)
	local firstByte = str:byte(1, 1)
	local numBytes = 1
	if firstByte >= 0xF0 then -- firstByte & 0b11110000
		numBytes = 4
	elseif firstByte >= 0xE0 then -- firstByte & 0b11100000
		numBytes = 3
	elseif firstByte >= 0xC0 then  -- firstByte & 0b11000000
		numBytes = 2
	end
	return str:sub(1, numBytes):upper()..str:sub(numBytes + 1):lower()
end

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
		self:AddMsg(L.LOOT_SPEC_REMINDER:format(_G[role] or L.UNKNOWN, _G[lootrole]))
	end
end

-- An anti spam function to throttle spammy events (e.g. SPELL_AURA_APPLIED on all group members)
-- @param time the time to wait between two events (optional, default 2.5 seconds)
-- @param id the id to distinguish different events (optional, only necessary if your mod keeps track of two different spam events at the same time)
function DBM:AntiSpam(time, id)
	if GetTime() - (id and (self["lastAntiSpam" .. tostring(id)] or 0) or self.lastAntiSpam or 0) > (time or 2.5) then
		if id then
			self["lastAntiSpam" .. tostring(id)] = GetTime()
		else
			self.lastAntiSpam = GetTime()
		end
		return true
	else
		return false
	end
end

function DBM:InCombat()
	if #inCombat > 0 then
		return true
	end
	return false
end

function DBM:FlashClientIcon()
	if self:AntiSpam(5, "FLASH") then
		FlashClientIcon()
	end
end

do
	local iconStrings = {[1] = RAID_TARGET_1, [2] = RAID_TARGET_2, [3] = RAID_TARGET_3, [4] = RAID_TARGET_4, [5] = RAID_TARGET_5, [6] = RAID_TARGET_6, [7] = RAID_TARGET_7, [8] = RAID_TARGET_8,}
	function DBM:IconNumToString(number)
		return iconStrings[number] or number
	end
	function DBM:IconNumToTexture(number)
		return "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_"..number..".blp:12:12|t" or number
	end
end

--To speed up creating new mods.
function DBM:FindDungeonMapIDs(low, peak, contains)
	local start = low or 1
	local range = peak or 4000
	self:AddMsg("-----------------")
	for i = start, range do
		local dungeon = GetRealZoneText(i)
		if dungeon and dungeon ~= "" then
			if not contains or contains and dungeon:find(contains) then
				self:AddMsg(i..": "..dungeon)
			end
		end
	end
end

function DBM:FindInstanceIDs(low, peak, contains)
	local start = low or 1
	local range = peak or 3000
	self:AddMsg("-----------------")
	for i = start, range do
		local instance = EJ_GetInstanceInfo(i)
		if instance then
			if not contains or contains and instance:find(contains) then
				self:AddMsg(i..": "..instance)
			end
		end
	end
end

function DBM:FindScenarioIDs(low, peak, contains)
	local start = low or 1
	local range = peak or 3000
	self:AddMsg("-----------------")
	for i = start, range do
		local instance = GetDungeonInfo(i)
		if instance and (not contains or contains and instance:find(contains)) then
			self:AddMsg(i..": "..instance)
		end
	end
end

--/run DBM:FindEncounterIDs(1192)--Shadowlands
--/run DBM:FindEncounterIDs(1178, 23)--Dungeon Template (mythic difficulty)
--/run DBM:FindEncounterIDs(237, 1)--Classic Dungeons need diff 1 specified
--/run DBM:FindDungeonMapIDs(1, 500)--Find Classic Dungeon Map IDs
--/run DBM:FindInstanceIDs(1, 300)--Find Classic Dungeon Journal IDs
function DBM:FindEncounterIDs(instanceID, diff)
	if not instanceID then
		self:AddMsg("Error: Function requires instanceID be provided")
	end
	if not diff then diff = 14 end--Default to "normal" in 6.0+ if diff arg not given.
	EJ_SetDifficulty(diff)--Make sure it's set to right difficulty or it'll ignore mobs (ie ra-den if it's not set to heroic). Use user specified one as primary, with curernt zone difficulty as fallback
	self:AddMsg("-----------------")
	for i=1, 25 do
		local name, _, encounterID = EJ_GetEncounterInfoByIndex(i, instanceID)
		if name then
			self:AddMsg(encounterID..": "..name)
		end
	end
end

--Taint the script that disables /run /dump, etc
--ScriptsDisallowedForBeta = function() return false end

-------------------
--  Movie Filter --
-------------------
do
	local neverFilter = {
		[486] = true, -- Tomb of Sarg Intro
		[487] = true, -- Alliance Broken Shore cut-scene
		[488] = true, -- Horde Broken Shore cut-scene
		[489] = true, -- Unknown, currently encrypted
		[490] = true, -- Unknown, currently encrypted
	}
	function DBM:PLAY_MOVIE(id)
		if id and not neverFilter[id] then
			self:Debug("PLAY_MOVIE fired for ID: "..id, 2)
			local isInstance, instanceType = IsInInstance()
			if not isInstance or C_Garrison:IsOnGarrisonMap() or instanceType == "scenario" or self.Options.MovieFilter2 == "Never" or self.Options.MovieFilter2 == "OnlyFight" and not IsEncounterInProgress() then return end
			if self.Options.MovieFilter2 == "Block" or (self.Options.MovieFilter2 == "AfterFirst" or self.Options.MovieFilter2 == "OnlyFight") and self.Options.MoviesSeen[id] then
				MovieFrame:Hide()--can only just hide movie frame safely now, which means can't stop audio anymore :\
				self:AddMsg(L.MOVIE_SKIPPED)
			else
				self.Options.MoviesSeen[id] = true
			end
		end
	end

	function DBM:CINEMATIC_START()
		self:Debug("CINEMATIC_START fired", 2)
		self.HudMap:SupressCanvas()
		local isInstance, instanceType = IsInInstance()
		if not isInstance or C_Garrison:IsOnGarrisonMap() or instanceType == "scenario" or self.Options.MovieFilter2 == "Never" or DBM.Options.MovieFilter2 == "OnlyFight" and not IsEncounterInProgress() then return end
		local currentMapID = C_Map.GetBestMapForUnit("player")
		local currentSubZone = GetSubZoneText() or ""
		if not currentMapID then return end--Protection from map failures in zones that have no maps yet
		if self.Options.MovieFilter2 == "Block" or (self.Options.MovieFilter2 == "AfterFirst" or self.Options.MovieFilter2 == "OnlyFight") and self.Options.MoviesSeen[currentMapID..currentSubZone] then
			CinematicFrame_CancelCinematic()
			self:AddMsg(L.MOVIE_SKIPPED)
		else
			self.Options.MoviesSeen[currentMapID..currentSubZone] = true
		end
	end
	function DBM:CINEMATIC_STOP()
		self:Debug("CINEMATIC_STOP fired", 2)
		self.HudMap:UnSupressCanvas()
	end
end
