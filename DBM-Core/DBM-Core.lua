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
	DisplayVersion = "8.3.14 alpha", -- the string that is shown as version
	ReleaseRevision = releaseDate(2020, 2, 10) -- the date of the latest stable version that is available, optionally pass hours, minutes, and seconds for multiple releases in one day
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

-- dual profile setup
local _, playerClass = UnitClass("player")
DBM_UseDualProfile = true
if playerClass == "MAGE" or playerClass == "WARLOCK" or playerClass == "ROGUE" then
	DBM_UseDualProfile = false
end
DBM_CharSavedRevision = 2

--Hard code STANDARD_TEXT_FONT since skinning mods like to taint it (or worse, set it to nil, wtf?)
local standardFont = STANDARD_TEXT_FONT
if (LOCALE_koKR) then
	standardFont = "Fonts\\2002.TTF"
elseif (LOCALE_zhCN) then
	standardFont = "Fonts\\ARKai_T.ttf"
elseif (LOCALE_zhTW) then
	standardFont = "Fonts\\blei00d.TTF"
elseif (LOCALE_ruRU) then
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
	EventSoundVictory2 = "None",
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
	ShowPizzaMessage = true,
	ShowEngageMessage = true,
	ShowDefeatMessage = true,
	ShowGuildMessages = true,
	ShowGuildMessagesPlus = false,
	AutoRespond = true,
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
	HideQuestTooltips = true,
	HideTooltips = false,
	DisableSFX = false,
	EnableModels = true,
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
	WarningDuration2 = 1.5,
	WarningPoint = "CENTER",
	WarningX = 0,
	WarningY = 260,
	WarningFont = standardFont,
	WarningFontSize = 20,
	WarningFontStyle = "None",
	WarningFontShadow = true,
	SpecialWarningDuration2 = 1.5,
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = standardFont,
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
	DontShowSpecialWarnings = false,
	DontShowSpecialWarningText = false,
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
	DontShowNameplateLines = false,
	DontPlayCountdowns = false,
	DontSendYells = false,
	BlockNoteShare = false,
	DontShowReminders = false,
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
	AutoAcceptFriendInvite = false,
	AutoAcceptGuildInvite = false,
	FakeBWVersion = false,
	AITimer = true,
	ShortTimerText = true,
	ChatFrame = "DEFAULT_CHAT_FRAME",
	CoreSavedRevision = 1,
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
	{text = "None",value  = "None"},
	{text = "Random",value  = "Random"},
	{text = "Blakbyrd: FF Fanfare",value = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\bbvictory.ogg", length=4},
	{text = "SMG: FF Fanfare",value = "Interface\\AddOns\\DBM-Core\\sounds\\Victory\\SmoothMcGroove_Fanfare.ogg", length=4},
}
DBM.Defeat = {
	{text = "None",value  = "None"},
	{text = "Random",value  = "Random"},
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
--Music uses file data IDs
DBM.Music = {--Contains all music media, period
	{text = "None",value  = "None"},
	{text = "Random",value  = "Random"},
	{text = "Anduin Part 1 B",value = 1417242, length=140},--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
	{text = "Anduin Part 2 B",value = 1417248, length=111},--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
	{text = "Bronze Jam",value = 350021, length=116},--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
	{text = "Invincible",value = 1100052, length=197},--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
	{text = "Nightsong",value = 441705, length=160},--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
	{text = "Ulduar: Titan Orchestra",value = 298910, length=102},--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
}
DBM.DungeonMusic = {--Filtered list of media assigned to dungeon/raid background music catagory
	{text = "None",value  = "None"},
	{text = "Random",value  = "Random"},
	{text = "Anduin Part 1 B",value = 1417242, length=140},--"sound\\music\\Legion\\MUS_70_AnduinPt1_B.mp3" Soundkit: 68230
	{text = "Nightsong",value = 441705, length=160},--"Sound\\Music\\cataclysm\\MUS_NightElves_GU01.mp3" Soundkit: 71181
	{text = "Ulduar: Titan Orchestra",value = 298910, length=102},--"Sound\\Music\\ZoneMusic\\UlduarRaidInt\\UR_TitanOrchestraIntro.mp3" Soundkit: 15873
}
DBM.BattleMusic = {--Filtered list of media assigned to boss/encounter background music catagory
	{text = "None",value  = "None"},
	{text = "Random",value  = "Random"},
	{text = "Anduin Part 2 B",value = 1417248, length=111},--"sound\\music\\Legion\\MUS_70_AnduinPt2_B.mp3" Soundkit: 68230
	{text = "Bronze Jam",value = 350021, length=116},--"Sound\\Music\\ZoneMusic\\IcecrownRaid\\IR_BronzeJam.mp3" Soundkit: 118800
	{text = "Invincible",value = 1100052, length=197},--"Sound\\Music\\Draenor\\MUS_Invincible.mp3" Soundkit: 49536
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
local oocBWComms = {}
local combatInfo = {}
local bossIds = {}
local updateFunctions = {}
local raid = {}
local modSyncSpam = {}
local autoRespondSpam = {}
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<DBM> "
local ver = ("%s (%s)"):format(DBM.DisplayVersion, tostring(DBM.Revision))
local mainFrame = CreateFrame("Frame", "DBMMainFrame")
local newerVersionPerson = {}
local newerRevisionPerson = {}
local combatInitialized = false
local healthCombatInitialized = false
local pformat
local schedulerFrame = CreateFrame("Frame", "DBMScheduler")
schedulerFrame:Hide()
local startScheduler
local schedule
local unschedule
local unscheduleAll
local scheduleCountdown
local loadOptions
local checkWipe
local checkBossHealth
local checkCustomBossHealth
local fireEvent
local playerName = UnitName("player")
local playerLevel = UnitLevel("player")
local playerRealm = GetRealmName()
local connectedServers = GetAutoCompleteRealms()
local LastInstanceMapID = -1
local LastGroupSize = 0
local LastInstanceType = nil
local queuedBattlefield = {}
local watchFrameRestore = false
local bossHealth = {}
local bossHealthuIdCache = {}
local bossuIdCache = {}
local savedDifficulty, difficultyText, difficultyIndex, difficultyModifier
local lastBossEngage = {}
local lastBossDefeat = {}
local bossuIdFound = false
local timerRequestInProgress = false
local updateNotificationDisplayed = 0
local showConstantReminder = 0
local tooltipsHidden = false
local SWFilterDisabed = 3
local currentSpecID, currentSpecName, currentSpecGroup
local cSyncSender = {}
local cSyncReceived = 0
local eeSyncSender = {}
local eeSyncReceived = 0
local canSetIcons = {}
local iconSetRevision = {}
local iconSetPerson = {}
local addsGUIDs = {}
local targetEventsRegistered = false
local targetMonitor = {}
local statusWhisperDisabled = false
local statusGuildDisabled = false
local dbmToc = 0
local UpdateChestTimer
local breakTimerStart
local AddMsg
local delayedFunction
local dataBroker
local voiceSessionDisabled = false
local handleSync

local fakeBWVersion, fakeBWHash = 182, "85a74be"
local versionQueryString, versionResponseString = "Q^%d^%s", "V^%d^%s"

local enableIcons = true -- set to false when a raid leader or a promoted player has a newer version of DBM

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
	"DBM-KulTiras",--Merged to DBM-Azeroth-BfA
	"DBM-Zandalar",--Merged to DBM-Azeroth-BfA
}


-----------------
--  Libraries  --
-----------------
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
local tinsert, tremove, twipe, tsort, tconcat = table.insert, table.remove, table.wipe, table.sort, table.concat
local type, select = type, select
local GetTime = GetTime
local bband = bit.band
local floor, mhuge, mmin, mmax = math.floor, math.huge, math.min, math.max
local GetNumGroupMembers, GetRaidRosterInfo = GetNumGroupMembers, GetRaidRosterInfo
local UnitName, GetUnitName = UnitName, GetUnitName
local IsInRaid, IsInGroup, IsInInstance = IsInRaid, IsInGroup, IsInInstance
local UnitAffectingCombat, InCombatLockdown, IsFalling, IsEncounterInProgress, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty = UnitAffectingCombat, InCombatLockdown, IsFalling, IsEncounterInProgress, UnitPlayerOrPetInRaid, UnitPlayerOrPetInParty
local UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff = UnitGUID, UnitHealth, UnitHealthMax, UnitBuff, UnitDebuff
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
local C_TimerNewTicker, C_TimerAfter = C_Timer.NewTicker, C_Timer.After
--Temp Upvalues for uncommon functions 8.2.5 changes
local IsQuestFlaggedCompleted = C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted or IsQuestFlaggedCompleted

local SendAddonMessage = C_ChatInfo.SendAddonMessage

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

---------------------------------
--  General (local) functions  --
---------------------------------
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

local function findEntry(t, val)
	for i, v in ipairs(t) do
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
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
		SendAddonMessage("D4", prefix .. "\t" .. msg, "INSTANCE_CHAT")
	else
		if IsInRaid() then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "PARTY")
		else--for solo raid
			handleSync("SOLO", playerName, prefix, strsplit("\t", msg))
		end
	end
end

--Custom sync function that should only be used for user generated sync messages
local function sendLoggedSync(prefix, msg)
	msg = msg or ""
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
		C_ChatInfo.SendAddonMessageLogged("D4", prefix .. "\t" .. msg, "INSTANCE_CHAT")
	else
		if IsInRaid() then
			C_ChatInfo.SendAddonMessageLogged("D4", prefix .. "\t" .. msg, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			C_ChatInfo.SendAddonMessageLogged("D4", prefix .. "\t" .. msg, "PARTY")
		else--for solo raid
			C_ChatInfo.SendAddonMessageLogged("D4", prefix .. "\t" .. msg, "WHISPER", playerName)
		end
	end
end

local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time*100)/100
	if time < 60 then
		return DBM_CORE_TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return DBM_CORE_TIMER_FORMAT_MINS:format(time/60)
	else
		return DBM_CORE_TIMER_FORMAT:format(time/60, time % 60)
	end
end

do
	-- fail-safe format, replaces missing arguments with unknown
	-- note: doesn't handle cases like %%%s correctly at the moment (should become %unknown, but becomes %%s)
	-- also, the end of the format directive is not detected in all cases, but handles everything that occurs in our boss mods ;)
	--> not suitable for general-purpose use, just for our warnings and timers (where an argument like a spell-target might be nil due to missing target information from unreliable detection methods)
	local function replace(cap1, cap2)
		return cap1 == "%" and DBM_CORE_UNKNOWN
	end

	function pformat(fstr, ...)
		local ok, str = pcall(format, fstr, ...)
		return ok and str or fstr:gsub("(%%+)([^%%%s<]+)", replace):gsub("%%%%", "%%")
	end
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

local function stripServerName(cap)
	cap = cap:sub(2, -2)
	if DBM.Options.StripServerName then
		cap = Ambiguate(cap, "none")
	end
	return cap
end

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
		for i, v in ipairs(registeredEvents[event]) do
			local zones = v.zones
			local handler = v[event]
			local modEvents = v.registeredUnitEvents
			if handler and (not isUnitEvent or not modEvents or modEvents[event .. ...])  and (not zones or zones[LastInstanceMapID]) and not (v.isTrashMod and #inCombat > 0) then
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
					for i, v in pairs(registeredSpellIds[event]) do
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
			local event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
			if event:sub(event:len() - 10) == "_UNFILTERED" then
				mainFrame:UnregisterEvent(event:sub(0, -12))
			else
				unregisterUnitEvent(mod, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
			end
		end
	end

	local function findRealEvent(t, val)
		for i, v in ipairs(t) do
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
		SPELL_PERIODIC_ENERGIZE = true,
		SPELL_DRAIN = true,
		SPELL_LEECH = true,
		SPELL_CAST_FAILED = true
	}
	function DBM:COMBAT_LOG_EVENT_UNFILTERED()
		local timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, extraArg1, extraArg2, extraArg3, extraArg4, extraArg5, extraArg6, extraArg7, extraArg8, extraArg9, extraArg10 = CombatLogGetCurrentEventInfo()
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

	local function runDelayedFunctions(self)
		--Check if voice pack missing
		local activeVP = self.Options.ChosenVoicePack
		if activeVP ~= "None" then
			if not self.VoiceVersions[activeVP] or (self.VoiceVersions[activeVP] and self.VoiceVersions[activeVP] == 0) then--A voice pack is selected that does not belong
				voiceSessionDisabled = true
				AddMsg(DBM, DBM_CORE_VOICE_MISSING)
			end
		else
			if not self.Options.DontShowReminders and #self.Voices > 1 then
				--At least one voice pack installed but activeVP set to "None"
				AddMsg(DBM, DBM_CORE_VOICE_DISABLED)
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
			AddMsg(DBM, DBM_CORE_VOICE_COUNT_MISSING:format(1, self.DefaultOptions.CountdownVoice))
			self.Options.CountdownVoice = self.DefaultOptions.CountdownVoice
		end
		if not found2 then
			AddMsg(DBM, DBM_CORE_VOICE_COUNT_MISSING:format(2, self.DefaultOptions.CountdownVoice2))
			self.Options.CountdownVoice2 = self.DefaultOptions.CountdownVoice2
		end
		if not found3 then
			AddMsg(DBM, DBM_CORE_VOICE_COUNT_MISSING:format(3, self.DefaultOptions.CountdownVoice3))
			self.Options.CountdownVoice3 = self.DefaultOptions.CountdownVoice3
		end
		self:BuildVoiceCountdownCache()
		--Break timer recovery
		--Try local settings
		if self.Options.tempBreak2 then
			local timer, startTime = string.split("/", self.Options.tempBreak2)
			local elapsed = time() - tonumber(startTime)
			local remaining = timer - elapsed
			if remaining > 0 then
				breakTimerStart(DBM, remaining, playerName)
			else--It must have ended while we were offline, kill variable.
				self.Options.tempBreak2 = nil
			end
		end
		if IsInGuild() then
			SendAddonMessage("D4", "GH", "GUILD")
		end
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
			dbmToc = tonumber(GetAddOnMetadata("DBM-Core", "X-Min-Interface"))
			isLoaded = true
			for i, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			loadOptions(self)
			if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, DBM_CORE_RETAIL_ONLY) end)
				return
			end
			if GetAddOnEnableState(playerName, "VEM-Core") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, DBM_CORE_VEM) end)
				return
			end
			if GetAddOnEnableState(playerName, "DBM-Profiles") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, DBM_CORE_3RDPROFILES) end)
				return
			end
			if GetAddOnEnableState(playerName, "DPMCore") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, DBM_CORE_DPMCORE) end)
				return
			end
			if GetAddOnEnableState(playerName, "DBM-VictorySound") >= 1 then
				self:Disable(true)
				C_TimerAfter(15, function() AddMsg(self, DBM_CORE_VICTORYSOUND) end)
				return
			end
			if GetAddOnEnableState(playerName, "DBM-LDB") >= 1 then
				C_TimerAfter(15, function() AddMsg(self, DBM_CORE_DBMLDB) end)
			end
			if GetAddOnEnableState(playerName, "DBM-LootReminder") >= 1 then
				C_TimerAfter(15, function() AddMsg(self, DBM_CORE_DBMLOOTREMINDER) end)
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
								name			= GetAddOnMetadata(i, "X-DBM-Mod-Name") or GetRealZoneText(tonumber(mapIdTable[1])) or DBM_CORE_UNKNOWN,
								mapId			= mapIdTable,
								subTabs			= GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID"))} or GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
								oneFormat		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Single-Format") or 0) == 1,
								hasLFR			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-LFR") or 0) == 1,
								hasChallenge	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Challenge") or 0) == 1,
								noHeroic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Heroic") or 0) == 1,
								noStatistics	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Statistics") or 0) == 1,
								hasMythic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Mythic") or 0) == 1,
								hasTimeWalker	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-TimeWalker") or 0) == 1,
								isWorldBoss		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-World-Boss") or 0) == 1,
								isExpedition	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Expedition") or 0) == 1,
								minRevision		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-MinCoreRevision") or 0),
								minExpansion	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-MinExpansion") or 0),
								minToc			= tonumber(GetAddOnMetadata(i, "X-Min-Interface") or 0),
								modId			= addonName,
							})
							for i = #self.AddOns[#self.AddOns].mapId, 1, -1 do
								local id = tonumber(self.AddOns[#self.AddOns].mapId[i])
								if id then
									self.AddOns[#self.AddOns].mapId[i] = id
								else
									tremove(self.AddOns[#self.AddOns].mapId, i)
								end
							end
							if self.AddOns[#self.AddOns].subTabs then
								local subTabs = self.AddOns[#self.AddOns].subTabs
								for k, v in ipairs(subTabs) do
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
								for i = 1, #idTable do
									loadcIds[tonumber(idTable[i]) or ""] = addonName
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
					end
				end
				if GetAddOnMetadata(i, "X-DBM-CountPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						local voiceGlobal = GetAddOnMetadata(i, "X-DBM-CountPack-GlobalName")
						local insertFunction = _G[voiceGlobal]
						if loaded and insertFunction then
							insertFunction()
						else
							DBM:Debug(addonName.." failed to load at time CountPack function "..voiceGlobal.."ran", 2)
						end
					end
				end
				if GetAddOnMetadata(i, "X-DBM-VictoryPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						local victoryGlobal = GetAddOnMetadata(i, "X-DBM-VictoryPack-GlobalName")
						local insertFunction = _G[victoryGlobal]
						if loaded and insertFunction then
							insertFunction()
						else
							DBM:Debug(addonName.." failed to load at time VictoryPack function "..victoryGlobal.." ran", 2)
						end
					end
				end
				if GetAddOnMetadata(i, "X-DBM-DefeatPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						local defeatGlobal = GetAddOnMetadata(i, "X-DBM-DefeatPack-GlobalName")
						local insertFunction = _G[defeatGlobal]
						if loaded and insertFunction then
							insertFunction()
						else
							DBM:Debug(addonName.." failed to load at time DefeatPack function "..defeatGlobal.." ran", 2)
						end
					end
				end
				if GetAddOnMetadata(i, "X-DBM-MusicPack") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						AddMsg(self, "The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local loaded = LoadAddOn(addonName)
						local musicGlobal = GetAddOnMetadata(i, "X-DBM-MusicPack-GlobalName")
						local insertFunction = _G[musicGlobal]
						if loaded and insertFunction then
							insertFunction()
						else
							DBM:Debug(addonName.." failed to load at time MusicPack function "..musicGlobal.." ran", 2)
						end
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
		for i, v in ipairs(callbacks[event]) do
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
		local tableCache = nil

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
					for i = 1, select("#", ...) do
						if select(i, ...) ~= v[i] then
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
		for i, v in pairs(updateFunctions) do
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
			local k, v = next(modSyncSpam, nil)
			if v and (time - v > 8) then
				modSyncSpam[k] = nil
			end
		end
		if not nextTask and foundModFunctions == 0 then--Nothing left, stop scheduler
			schedulerFrame:SetScript("OnUpdate", nil)
			schedulerFrame:Hide()
		end
	end

	function startScheduler()
		if not schedulerFrame:IsShown() then
			schedulerFrame:Show()
			schedulerFrame:SetScript("OnUpdate", onUpdate)
		end
	end

	function schedule(t, f, mod, ...)
		if type(f) ~= "function" then
			error("usage: schedule(time, func, [mod, args...])", 2)
		end
		startScheduler()
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

	function scheduleCountdown(time, numAnnounces, func, mod, self, ...)
		time = time or 5
		numAnnounces = numAnnounces or 3
		for i = 1, numAnnounces do
			schedule(time - i, func, mod, self, i, ...)
		end
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
		self:AddMsg(DBM_CORE_PROFILE_CREATE_ERROR)
		return
	end
	if DBM_AllSavedOptions[name] then
		self:AddMsg(DBM_CORE_PROFILE_CREATE_ERROR_D:format(name))
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
	self:AddMsg(DBM_CORE_PROFILE_CREATED:format(name))
end

function DBM:ApplyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(DBM_CORE_PROFILE_APPLY_ERROR:format(name or DBM_CORE_UNKNOWN))
		return
	end
	usedProfile = name
	DBM_UsedProfile = usedProfile
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	self.Bars:ApplyProfile("DBM")
	self:RepositionFrames()
	self:AddMsg(DBM_CORE_PROFILE_APPLIED:format(name))
end

function DBM:CopyProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(DBM_CORE_PROFILE_COPY_ERROR:format(name or DBM_CORE_UNKNOWN))
		return
	elseif name == usedProfile then
		self:AddMsg(DBM_CORE_PROFILE_COPY_ERROR_SELF)
		return
	end
	DBM_AllSavedOptions[usedProfile] = DBM_AllSavedOptions[name]
	self:AddDefaultOptions(DBM_AllSavedOptions[usedProfile], self.DefaultOptions)
	self.Options = DBM_AllSavedOptions[usedProfile]
	-- rearrange position
	self.Bars:CopyProfile(name, "DBM")
	self:RepositionFrames()
	self:AddMsg(DBM_CORE_PROFILE_COPIED:format(name))
end

function DBM:DeleteProfile(name)
	if not name or not DBM_AllSavedOptions[name] then
		self:AddMsg(DBM_CORE_PROFILE_DELETE_ERROR:format(name or DBM_CORE_UNKNOWN))
		return
	elseif name == "Default" then-- Default profile cannot be deleted.
		self:AddMsg(DBM_CORE_PROFILE_CANNOT_DELETE)
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
	self:AddMsg(DBM_CORE_PROFILE_DELETED:format(name))
end

function DBM:RepositionFrames()
	-- rearrange position
	self:UpdateWarningOptions()
	self:UpdateSpecialWarningOptions()
	self.Arrow:LoadPosition()
	if DBMRangeCheck then
		DBMRangeCheck:ClearAllPoints()
		DBMRangeCheck:SetPoint(self.Options.RangeFramePoint, UIParent, self.Options.RangeFramePoint, self.Options.RangeFrameX, self.Options.RangeFrameY)
	end
	if DBMRangeCheckRadar then
		DBMRangeCheckRadar:ClearAllPoints()
		DBMRangeCheckRadar:SetPoint(self.Options.RangeFrameRadarPoint, UIParent, self.Options.RangeFrameRadarPoint, self.Options.RangeFrameRadarX, self.Options.RangeFrameRadarY)
	end
	if DBMInfoFrame then
		DBMInfoFrame:ClearAllPoints()
		DBMInfoFrame:SetPoint(self.Options.InfoFramePoint, UIParent, self.Options.InfoFramePoint, self.Options.InfoFrameX, self.Options.InfoFrameY)
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
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
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
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			return
		end
		if timer > 60 then
			DBM:AddMsg(DBM_CORE_BREAK_USAGE)
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
			DBM:AddMsg(DBM_CORE_NO_ARROW)
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
				DBM:AddMsg(DBM_ARROW_WAY_USAGE)
			end
		end
	end
	if not BigWigs then
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
			for i, v in ipairs(DBM_CORE_SLASHCMD_HELP2) do DBM:AddMsg(v) end
		elseif cmd == "help" then
			for i, v in ipairs(DBM_CORE_SLASHCMD_HELP) do DBM:AddMsg(v) end
		elseif cmd:sub(1, 13) == "timer endloop" then
			DBM:CreatePizzaTimer(time, "", nil, nil, nil, true)
		elseif cmd:sub(1, 5) == "timer" then
			local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
			if not (time and text) then
				for i, v in ipairs(DBM_CORE_TIMER_USAGE) do DBM:AddMsg(v) end
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
				DBM:AddMsg(DBM_PIZZA_ERROR_USAGE)
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
				DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
				permission = false
			end
			local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
			if not (time and text) then
				DBM:AddMsg(DBM_PIZZA_ERROR_USAGE)
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
				DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
				permission = false
			end
			local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
			if not (time and text) then
				DBM:AddMsg(DBM_PIZZA_ERROR_USAGE)
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
				DBM:AddMsg(DBM_CORE_UPDATE_REQUIRES_RELAUNCH)
				return
			end
			LL:RequestLatency()
			DBM:AddMsg(DBM_CORE_LAG_CHECKING)
			C_TimerAfter(5, function() DBM:ShowLag() end)
		elseif cmd:sub(1, 10) == "durability" then
			if not LD then
				DBM:AddMsg(DBM_CORE_UPDATE_REQUIRES_RELAUNCH)
				return
			end
			LD:RequestDurability()
			DBM:AddMsg(DBM_CORE_DUR_CHECKING)
			C_TimerAfter(5, function() DBM:ShowDurability() end)
		elseif cmd:sub(1, 3) == "hud" then
			if DBM:HasMapRestrictions() then
				DBM:AddMsg(DBM_CORE_NO_HUD)
				return
			end
			local hudType, target, duration = string.split(" ", msg:sub(4):trim())
			if hudType == "" then
				for i, v in ipairs(DBM_CORE_HUD_USAGE) do
					DBM:AddMsg(v)
				end
				return
			end
			local hudDuration = tonumber(duration) or 1200--if no duration defined. 20 minutes to cover even longest of fights
			local success = false
			if type(hudType) == "string" and hudType:trim() ~= "" then
				if hudType:upper() == "HIDE" then
					for name, points in pairs(trackedHudMarkers) do
						DBMHudMap:FreeEncounterMarkerByTarget(12345, name)
						trackedHudMarkers[name] = nil
					end
					return
				end
				if not target then
					DBM:AddMsg(DBM_CORE_HUD_INVALID_TARGET)
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
					DBM:AddMsg(DBM_CORE_HUD_INVALID_TARGET)
					return
				end
				if UnitIsUnit("player", uId) and not DBM.Options.DebugMode then--Don't allow hud to self, except if debug mode is enabled, then hud to self useful for testing
					DBM:AddMsg(DBM_CORE_HUD_INVALID_SELF)
					return
				end
				local targetName = UnitName(uId)
				if hudType:upper() == "ARROW" then
					local _, targetClass = UnitClass(uId)
					local color2 = RAID_CLASS_COLORS[targetClass]
					local m1 = DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, "party", playerName, 0.1, hudDuration, 0, 1, 0, 1, nil, false):Appear()
					local m2 = DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil, false):Appear()
					trackedHudMarkers[playerName] = true
					trackedHudMarkers[targetName] = true
					m2:EdgeTo(m1, nil, hudDuration, 0, 1, 0, 1)
					success = true
				elseif hudType:upper() == "DOT" then
					local _, targetClass = UnitClass(uId)
					local color2 = RAID_CLASS_COLORS[targetClass]
					DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, "party", targetName, 0.75, hudDuration, color2.r, color2.g, color2.b, 1, nil, false):Appear()
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "GREEN" then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 1, 0, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "RED" then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 0, 0, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "YELLOW" then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 1, 1, 0, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "BLUE" then
					DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, "highlight", targetName, 3.5, hudDuration, 0, 0, 1, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				elseif hudType:upper() == "ICON" then
					local icon = GetRaidTargetIndex(uId)
					if not icon then
						DBM:AddMsg(DBM_CORE_HUD_INVALID_ICON)
						return
					end
					local iconString = DBM:IconNumToString(icon):lower()
					DBMHudMap:RegisterRangeMarkerOnPartyMember(12345, iconString, targetName, 3.5, hudDuration, 1, 1, 1, 0.5, nil, false):Pulse(0.5, 0.5)
					trackedHudMarkers[targetName] = true
					success = true
				else
					DBM:AddMsg(DBM_CORE_HUD_INVALID_TYPE)
				end
			end
			if success then
				DBM:AddMsg(DBM_CORE_HUD_SUCCESS:format(strFromTime(hudDuration)))
			end
		elseif cmd:sub(1, 5) == "arrow" then
			if DBM:HasMapRestrictions() then
				DBM:AddMsg(DBM_CORE_NO_ARROW)
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
				for i, v in ipairs(DBM_ARROW_ERROR_USAGE) do
					DBM:AddMsg(v)
				end
			end
		elseif cmd:sub(1, 7) == "lockout" or cmd:sub(1, 3) == "ids" then
			if DBM:GetRaidRank(playerName) == 0 then
				return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			end
			if not IsInRaid() then
				return DBM:AddMsg(DBM_ERROR_NO_RAID)
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
			DBM:AddMsg("SilentMode is " .. (DBM.Options.SilentMode and "ON" or "OFF"))
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
				DBM.InfoFrame:SetHeader(DBM_CORE_INFOFRAME_AGGRO)
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
				DBM:AddMsg(DBM_CORE_NO_RANGE)
			elseif IsInInstance() then
				DBM:AddMsg(DBM_CORE_NO_RANGE_SOON)
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
		DBMHudMap:ToggleHudar(r)
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
		for i, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		twipe(OutdatedUsers)
		self:AddMsg(DBM_CORE_VERSIONCHECK_HEADER)
		for i, v in ipairs(sortMe) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.displayVersion and not v.bwversion then--DBM, no BigWigs
				if self.Options.ShowAllVersions then
					self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(name, "DBM "..v.displayVersion, showRealDate(v.revision), v.VPVersion or ""), false)--Only display VP version if not running two mods
				end
				if notify and v.revision < self.ReleaseRevision then
					SendChatMessage(chatPrefixShort..DBM_CORE_YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
				end
			elseif self.Options.ShowAllVersions and v.displayVersion and v.bwversion then--DBM & BigWigs
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY_TWO:format(name, "DBM "..v.displayVersion, showRealDate(v.revision), DBM_BIG_WIGS, versionResponseString:format(v.bwversion, v.bwhash)), false)
			elseif self.Options.ShowAllVersions and not v.displayVersion and v.bwversion then--BigWigs, No DBM
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(name, DBM_BIG_WIGS, versionResponseString:format(v.bwversion, v.bwhash), ""), false)
			else
				if self.Options.ShowAllVersions then
					self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM:format(name), false)
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
		self:AddMsg(DBM_CORE_VERSIONCHECK_FOOTER:format(TotalDBM, TotalBW), false)
		self:AddMsg(DBM_CORE_VERSIONCHECK_OUTDATED:format(OldMod, #OutdatedUsers > 0 and tconcat(OutdatedUsers, ", ") or NONE), false)
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
		for i, v in pairs(raid) do
			tinsert(sortLag, v)
		end
		tsort(sortLag, sortit)
		self:AddMsg(DBM_CORE_LAG_HEADER)
		for i, v in ipairs(sortLag) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.worldlag then
				self:AddMsg(DBM_CORE_LAG_ENTRY:format(name, v.worldlag, v.homelag), false)
			else
				tinsert(nolagResponse, v.name)
			end
		end
		if #nolagResponse > 0 then
			self:AddMsg(DBM_CORE_LAG_FOOTER:format(tconcat(nolagResponse, ", ")), false)
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
		for i, v in pairs(raid) do
			tinsert(sortDur, v)
		end
		tsort(sortDur, sortit)
		self:AddMsg(DBM_CORE_DUR_HEADER)
		for i, v in ipairs(sortDur) do
			local name = v.name
			local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
			if playerColor then
				name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
			end
			if v.durpercent then
				self:AddMsg(DBM_CORE_DUR_ENTRY:format(name, v.durpercent, v.durbroken), false)
			else
				tinsert(nodurResponse, v.name)
			end
		end
		if #nodurResponse > 0 then
			self:AddMsg(DBM_CORE_LAG_FOOTER:format(tconcat(nodurResponse, ", ")), false)
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
			self:AddMsg(DBM_PIZZA_ERROR_USAGE)
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
		self:AddMsg(DBM_PIZZA_SYNC_INFO:format(sender, id))
	end
end

-----------------
--  GUI Stuff  --
-----------------
do
	local callOnLoad = {}
	function DBM:LoadGUI()
		if GetAddOnEnableState(playerName, "VEM-Core") >= 1 then
			self:AddMsg(DBM_CORE_VEM)
			return
		end
		if GetAddOnEnableState(playerName, "DBM-Profiles") >= 1 then
			self:AddMsg(DBM_CORE_3RDPROFILES)
			return
		end
		if GetAddOnEnableState(playerName, "DPMCore") >= 1 then
			self:AddMsg(DBM_CORE_DPMCORE)
			return
		end
		if GetAddOnEnableState(playerName, "DBM-VictorySound") >= 1 then
			self:AddMsg(DBM_CORE_VICTORYSOUND)
			return
		end
		if not dbmIsEnabled then
			DBM:AddMsg(DBM_CORE_UPDATEREMINDER_DISABLE)
			return
		end
		if not IsAddOnLoaded("DBM-GUI") then
			local enabled = GetAddOnEnableState(playerName, "DBM-GUI")
			if enabled == 0 then
				EnableAddOn("DBM-GUI")
			end
			local loaded, reason = LoadAddOn("DBM-GUI")
			if not loaded then
				if reason then
					self:AddMsg(DBM_CORE_LOAD_GUI_ERROR:format(tostring(_G["ADDON_"..reason or ""])))
				else
					self:AddMsg(DBM_CORE_LOAD_GUI_ERROR:format(DBM_CORE_UNKNOWN))
				end
				return false
			end
			tsort(callOnLoad, function(v1, v2) return v1[2] < v2[2] end)
			for i, v in ipairs(callOnLoad) do v[1]() end
			if not InCombatLockdown() and not UnitAffectingCombat("player") and not IsFalling() then--We loaded in combat but still need to avoid garbage collect in combat
				collectgarbage("collect")
			end
		end
		return DBM_GUI:ShowHide()
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
			DBM:LoadGUI()
		end

		function dataBroker.OnTooltipShow(GameTooltip)
			GameTooltip:SetText(DBM_CORE_MINIMAP_TOOLTIP_HEADER, 1, 1, 1)
			GameTooltip:AddLine(("%s (%s)"):format(DBM.DisplayVersion, showRealDate(DBM.Revision)), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine(DBM_CORE_MINIMAP_TOOLTIP_FOOTER, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b, 1)
			GameTooltip:AddLine(DBM_LDB_TOOLTIP_HELP1, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
		--	GameTooltip:AddLine(DBM_LDB_TOOLTIP_HELP2, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b)
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
				SendAddonMessage("BigWigs", versionQueryString:format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
				self:Schedule(2, self.RoleCheck, false, self)
				fireEvent("DBM_raidJoin", playerName)
				if BigWigs and BigWigs.db.profile.raidicon and not self.Options.DontSetIcons and self:GetRaidRank() > 0 then--Both DBM and bigwigs have raid icon marking turned on.
					self:AddMsg(DBM_CORE_BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either or turned off to stop this alert)
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
			enableIcons = false
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
					enableIcons = true
				end
			end
		elseif IsInGroup() then
			if not inRaid then
				-- joined a new party
				inRaid = true
				sendSync("H")
				SendAddonMessage("BigWigs", versionQueryString:format(0, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
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
			enableIcons = false
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
					enableIcons = true
				end
			end
		else
			-- left the current group/raid
			inRaid = false
			enableIcons = true
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
		return DBM_CORE_UNKNOWN
	end

	function DBM:GetPlayerGUIDByName(name)
		return raid[name] and raid[name].guid
	end

	function DBM:GetMyPlayerInfo()
		return playerName, playerLevel, playerRealm
	end

	function DBM:GetUnitFullName(uId)
		if not uId then return nil end
		return GetUnitName(uId, true)
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
	local type, _, playerdbID, _, _, cid, creationbits = strsplit("-", guid or "")
	if type and (type == "Creature" or type == "Vehicle" or type == "Pet") then
		return tonumber(cid)
	elseif type and (type == "Player" or type == "Item") then
		return tonumber(playerdbID)
	end
	return 0
end

function DBM:IsCreatureGUID(guid)
	local type = strsplit("-", guid or "")
	if type and (type == "Creature" or type == "Vehicle") then--To determine, add pet or not?
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
		for uId in self:GetGroupMembers() do
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
	if not targetname and DBM.RangeCheck:GetDistanceAll(range) then
		return true--No target name means check if anyone is near self, period
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId and not UnitIsUnit("player", uId) then
			local inRange = DBM.RangeCheck:GetDistance(uId)
			if inRange and inRange < range+0.5 then
				return true
			end
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
	if not currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	local savedOptions = _G[savedVarsName][fullname] or {}
	local savedStats = _G[savedStatsName] or {}
	local existId = {}
	for i, id in ipairs(DBM.ModLists[modId]) do
		existId[id] = true
		-- init
		if not savedOptions[id] then savedOptions[id] = {} end
		local mod = DBM:GetModByName(id)
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
			if not inCombat then
				for option, optionValue in pairs(savedOptions[id][profileNum]) do
					if mod.DefaultOptions[option] == nil then
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
	if not inCombat then
		for id, table in pairs(savedOptions) do
			if not existId[id] and not id:find("talent") then
				savedOptions[id] = nil
			end
		end
		for id, table in pairs(savedStats) do
			if not existId[id] then
				savedStats[id] = nil
			end
		end
	end
	_G[savedVarsName][fullname] = savedOptions
	if profileNum > 0 then
		_G[savedVarsName][fullname]["talent"..profileNum] = currentSpecName
		self:Debug("LoadModOptions: Finished loading "..(_G[savedVarsName][fullname]["talent"..profileNum] or DBM_CORE_UNKNOWN))
	end
	_G[savedStatsName] = savedStats
	if not first and DBM_GUI and DBM_GUI.currentViewing and DBM_GUI_OptionsFrame:IsShown() then
		DBM_GUI_OptionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:SpecChanged(force)
	if not force and not DBM_UseDualProfile then return end
	--Load Options again.
	self:Debug("SpecChanged fired", 2)
	for modId, idTable in pairs(self.ModLists) do
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
	if not currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local fullname = playerName.."-"..playerRealm
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	for i, id in ipairs(self.ModLists[modId]) do
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
	self:AddMsg(DBM_CORE_ALLMOD_DEFAULT_LOADED)
	-- update gui if showing
	if DBM_GUI and DBM_GUI.currentViewing and DBM_GUI_OptionsFrame:IsShown() then
		DBM_GUI_OptionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:LoadModDefaultOption(mod)
	-- mod must be table
	if not mod then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup then
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
	self:AddMsg(DBM_CORE_MOD_DEFAULT_LOADED)
	-- update gui if showing
	if DBM_GUI and DBM_GUI.currentViewing and DBM_GUI_OptionsFrame:IsShown() then
		DBM_GUI_OptionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModOption(modId, sourceName, sourceProfile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not DBM.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local targetName = playerName.."-"..playerRealm
	local targetProfile = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(DBM_CORE_MPROFILE_COPY_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(DBM_CORE_MPROFILE_COPY_S_ERROR)
		return
	end
	local targetOptions = _G[savedVarsName][targetName] or {}
	for i, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(DBM_CORE_MPROFILE_COPY_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(DBM_CORE_MPROFILE_COPY_S_ERROR)
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
	self:AddMsg(DBM_CORE_MPROFILE_COPY_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	if DBM_GUI and DBM_GUI.currentViewing and DBM_GUI_OptionsFrame:IsShown() then
		DBM_GUI_OptionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:CopyAllModTypeOption(modId, sourceName, sourceProfile, Type)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not self.ModLists[modId] or not Type then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local targetName = playerName.."-"..playerRealm
	local targetProfile = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- do not copy setting itself
	if targetName == sourceName and targetProfile == sourceProfile then
		self:AddMsg(DBM_CORE_MPROFILE_COPYS_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	-- check source is exist
	if not _G[savedVarsName][sourceName] then
		self:AddMsg(DBM_CORE_MPROFILE_COPYS_S_ERROR)
		return
	end
	local targetOptions = _G[savedVarsName][targetName] or {}
	for i, id in ipairs(self.ModLists[modId]) do
		-- check source is exist
		if not _G[savedVarsName][sourceName][id] then
			self:AddMsg(DBM_CORE_MPROFILE_COPYS_S_ERROR)
			return
		end
		if not _G[savedVarsName][sourceName][id][sourceProfile] then
			self:AddMsg(DBM_CORE_MPROFILE_COPYS_S_ERROR)
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
	self:AddMsg(DBM_CORE_MPROFILE_COPYS_SUCCESS:format(sourceName, sourceProfile))
	-- update gui if showing
	if DBM_GUI and DBM_GUI.currentViewing and DBM_GUI_OptionsFrame:IsShown() then
		DBM_GUI_OptionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:DeleteAllModOption(modId, name, profile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not name or not profile or not self.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID or not currentSpecGroup then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local fullname = playerName.."-"..playerRealm
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- cannot delete current profile.
	if fullname == name and profileNum == profile then
		self:AddMsg(DBM_CORE_MPROFILE_DELETE_SELF_ERROR)
		return
	end
	-- prevent nil table error
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	if not _G[savedVarsName][name] then
		self:AddMsg(DBM_CORE_MPROFILE_DELETE_S_ERROR)
		return
	end
	for i, id in ipairs(self.ModLists[modId]) do
		-- prevent nil table error
		if not _G[savedVarsName][name][id] then
			self:AddMsg(DBM_CORE_MPROFILE_DELETE_S_ERROR)
			return
		end
		-- delete
		_G[savedVarsName][name][id][profile] = nil
	end
	_G[savedVarsName][name]["talent"..profile] = nil
	self:AddMsg(DBM_CORE_MPROFILE_DELETE_SUCCESS:format(name, profile))
end

function DBM:ClearAllStats(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not self.ModLists[modId] then return end
	-- variable init
	local savedStatsName = modId:gsub("-", "").."_SavedStats"
	-- prevent nil table error
	if not _G[savedStatsName] then _G[savedStatsName] = {} end
	for i, id in ipairs(self.ModLists[modId]) do
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
	self:AddMsg(DBM_CORE_ALLMOD_STATS_RESETED)
	DBM_GUI:UpdateModList()
end

do
	function loadOptions(self)
		--init
		if not DBM_AllSavedOptions then DBM_AllSavedOptions = {} end
		usedProfile = DBM_UsedProfile or usedProfile
		if not usedProfile or (usedProfile ~= "Default" and not DBM_AllSavedOptions[usedProfile]) then
			-- DBM.Option is not loaded. so use print function
			print(DBM_CORE_PROFILE_NOT_FOUND)
			usedProfile = "Default"
		end
		DBM_UsedProfile = usedProfile
		--migrate old options
		if DBM_SavedOptions and not DBM_AllSavedOptions[usedProfile] then
			DBM_AllSavedOptions[usedProfile] = DBM_SavedOptions
		end
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
			self:AddMsg(DBM_CORE_SOUNDKIT_MIGRATION)
		end
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
		self.Bars:CreateBar(40, DBM_LFG_INVITE, 237538)
		fireEvent("DBM_TimerStart", "DBMLFGTimer", DBM_LFG_INVITE, 40, "237538", "extratimer", nil, 0)
	end
	if self.Options.LFDEnhance then
		self:FlashClientIcon()
		self:PlaySound(8960, true)--Because regular sound uses SFX channel which is too low of volume most of time
	end
end

function DBM:LFG_PROPOSAL_FAILED()
	self.Bars:CancelBar(DBM_LFG_INVITE)
	fireEvent("DBM_TimerStop", "DBMLFGTimer")
end

function DBM:LFG_PROPOSAL_SUCCEEDED()
	self.Bars:CancelBar(DBM_LFG_INVITE)
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
	local lastSpecID = currentSpecID
	self:SetCurrentSpecInfo()
	if currentSpecID ~= lastSpecID then--Don't fire specchanged unless spec actually has changed.
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
	local cataZones = {[757]=true,[671]=true,[669]=true,[967]=true,[720]=true,[951]=true,[754]=true}--951 is a second but unused mapID for firelands, likely the ID of TW/scaling version that will replace 10/25 at some point
	local mopZones = {[1009]=true,[1008]=true,[1136]=true,[996]=true,[1098]=true}
	local wodZones = {[1205]=true,[1448]=true,[1228]=true}
	local legionZones = {[1712]=true,[1520]=true,[1530]=true,[1676]=true,[1648]=true}
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
	}
	--This never wants to spam you to use mods for trivial content you don't need mods for.
	--It's intended to suggest mods for content that's relevant to your level (TW, leveling up in dungeons, or even older raids you can't just shit on)
	function DBM:CheckAvailableMods()
		if BigWigs or modAdvertisementShown then return end--If they are running two boss mods at once, lets assume they are only using DBM for a specific feature (such as brawlers) and not nag
		local timeWalking = difficultyIndex == 24 or difficultyIndex == 33 or false
		if oldDungeons[LastInstanceMapID] and (timeWalking or playerLevel < 110) and not GetAddOnInfo("DBM-Party-BC") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM Old Dungeon mods"))
			modAdvertisementShown = true
		elseif (classicZones[LastInstanceMapID] or bcZones[LastInstanceMapID]) and (timeWalking or playerLevel < 71) and not GetAddOnInfo("DBM-BlackTemple") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM BC/Vanilla mods"))
			modAdvertisementShown = true
		elseif wrathZones[LastInstanceMapID] and (timeWalking or playerLevel < 86) and not GetAddOnInfo("DBM-Ulduar") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM Wrath of the Lich King mods"))
			modAdvertisementShown = true
		elseif cataZones[LastInstanceMapID] and (timeWalking or playerLevel < 91) and not GetAddOnInfo("DBM-Firelands") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM Cataclysm mods"))
			modAdvertisementShown = true
		elseif mopZones[LastInstanceMapID] and (timeWalking or playerLevel < 101) and not GetAddOnInfo("DBM-SiegeOfOrgrimmarV2") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM Mists of Pandaria mods"))
			modAdvertisementShown = true
		elseif wodZones[LastInstanceMapID] and (timeWalking or playerLevel < 111) and not GetAddOnInfo("DBM-HellfireCitadel") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM Warlords of Draenor mods"))
			modAdvertisementShown = true
		elseif legionZones[LastInstanceMapID] and (timeWalking or playerLevel < 121) and not GetAddOnInfo("DBM-AntorusBurningThrone") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM Legion mods"))
			modAdvertisementShown = true
		elseif challengeScenarios[LastInstanceMapID] and not GetAddOnInfo("DBM-Challenges") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM-Challenges"))
			modAdvertisementShown = true
		elseif pvpZones[LastInstanceMapID] and not GetAddOnInfo("DBM-PvP") then
			AddMsg(self, DBM_CORE_MOD_AVAILABLE:format("DBM-PvP"))
			modAdvertisementShown = true
		end
	end
	function DBM:TransitionToDungeonBGM(force, cleanup)
		if cleanup then--Runs on zone change (first load delay) and combat end
			self:Unschedule(self.TransitionToDungeonBGM)
			if self.Options.tempMusicSetting then
				SetCVar("Sound_EnableMusic", self.Options.tempMusicSetting)
				self.Options.tempMusicSetting = nil
				DBM:Debug("Restoring Sound_EnableMusic CVAR")
			end
			if self.Options.musicPlaying then--Primarily so DBM doesn't call StopMusic unless DBM is one that started it. We don't want to screw with other addons
				StopMusic()
				self.Options.musicPlaying = nil
				DBM:Debug("Stopping music")
			end
			fireEvent("DBM_MusicStop", "ZoneOrCombatEndTransition")
			return
		end
		if LastInstanceType ~= "raid" and LastInstanceType ~= "party" and not force then return end
		fireEvent("DBM_MusicStart", "RaidOrDungeon")
		if self.Options.EventSoundDungeonBGM and self.Options.EventSoundDungeonBGM ~= "None" and self.Options.EventSoundDungeonBGM ~= "" and not (self.Options.EventDungMusicMythicFilter and (savedDifficulty == "mythic" or savedDifficulty == "challenge")) then
			if not self.Options.tempMusicSetting then
				self.Options.tempMusicSetting = tonumber(GetCVar("Sound_EnableMusic")) or 1
				if self.Options.tempMusicSetting == 0 then
					SetCVar("Sound_EnableMusic", 1)
				else
					self.Options.tempMusicSetting = nil--Don't actually need it
				end
			end
			local path = "MISSING"
			if self.Options.EventSoundDungeonBGM == "Random" then
				local usedTable = self.Options.EventSoundMusicCombined and DBM.Music or DBM.DungeonMusic
				local random = fastrandom(3, #usedTable)
				path = usedTable[random].value
			else
				path = self.Options.EventSoundDungeonBGM
			end
			PlayMusic(path)
			self.Options.musicPlaying = true
			DBM:Debug("Starting Dungeon music with file: "..path)
		end
	end
	local function SecondaryLoadCheck(self)
		local _, instanceType, difficulty, _, _, _, _, mapID, instanceGroupSize = GetInstanceInfo()
		local currentDifficulty, currentDifficultyText = self:GetCurrentInstanceDifficulty()
		if currentDifficulty ~= savedDifficulty then
			savedDifficulty, difficultyText = currentDifficulty, currentDifficultyText
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
			if savedDifficulty == "worldboss" then
				for i = #inCombat, 1, -1 do
					self:EndCombat(inCombat[i], true)
				end
			end
		end
		-- LoadMod
		self:LoadModsOnDemand("mapId", mapID)
		if not self.Options.DontShowReminders then
			self:CheckAvailableMods()
		end
		if DBM:HasMapRestrictions() then
			DBM.Arrow:Hide()
			DBMHudMap:Disable()
			if DBM.RangeCheck:IsRadarShown() then
				DBM.RangeCheck:Hide(true)
			end
		end
		-- Auto Logging for entire zone if record only bosses is off
		if not DBM.Options.RecordOnlyBosses then
			if LastInstanceType == "raid" or LastInstanceType == "party" then
				self:StartLogging(0, nil)
			else
				self:StopLogging()
			end
		end
	end
	--Faster and more accurate loading for instances, but useless outside of them
	function DBM:LOADING_SCREEN_DISABLED()
		self.Bars:CancelBar(DBM_LFG_INVITE)--Disable bar here since LFG_PROPOSAL_SUCCEEDED seems broken right now
		fireEvent("DBM_TimerStop", "DBMLFGTimer")
		timerRequestInProgress = false
		self:Debug("LOADING_SCREEN_DISABLED fired")
		self:Unschedule(SecondaryLoadCheck)
		--SecondaryLoadCheck(self)
		self:Schedule(1, SecondaryLoadCheck, self)--Now delayed by one second to work around an issue on 8.x where spec info isn't available yet on reloadui
		self:TransitionToDungeonBGM(false, true)
		self:Schedule(5, SecondaryLoadCheck, self)
		if DBM:HasMapRestrictions() then
			DBM.Arrow:Hide()
			DBMHudMap:Disable()
			if DBM.RangeCheck:IsRadarShown() then
				DBM.RangeCheck:Hide(true)
			end
		end
	end

	function DBM:LoadModsOnDemand(checkTable, checkValue)
		self:Debug("LoadModsOnDemand fired")
		for i, v in ipairs(self.AddOns) do
			local modTable = v[checkTable]
			local enabled = GetAddOnEnableState(playerName, v.modId)
			--self:Debug(v.modId.." is "..enabled, 2)
			if not IsAddOnLoaded(v.modId) and modTable and checkEntry(modTable, checkValue) then
				if enabled ~= 0 then
					self:LoadMod(v)
				else
					if not self.Options.DontShowReminders then
						self:AddMsg(DBM_CORE_LOAD_MOD_DISABLED:format(v.name))
					end
				end
			end
		end
		self:ScenarioCheck()--Do not filter. Because ScenarioCheck function includes filter.
	end
end

--Scenario mods
function DBM:ScenarioCheck()
	if dbmIsEnabled and combatInfo[LastInstanceMapID] then
		for i, v in ipairs(combatInfo[LastInstanceMapID]) do
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
			self:AddMsg(DBM_CORE_LOAD_MOD_VER_MISMATCH:format(mod.name))
		end
		return
	end
	if mod.minExpansion > GetExpansionLevel() then
		self:AddMsg(DBM_CORE_LOAD_MOD_EXP_MISMATCH:format(mod.name))
		return
	elseif not testBuild and mod.minToc > wowTOC then
		self:AddMsg(DBM_CORE_LOAD_MOD_TOC_MISMATCH:format(mod.name, mod.minToc))
		return
	end
	if not currentSpecID then
		self:SetCurrentSpecInfo()
	end
	if not difficultyIndex then -- prevent error in EJ_SetDifficulty if not yet set
		savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
	end
	EJ_SetDifficulty(difficultyIndex)--Work around blizzard crash bug where other mods (like Boss) screw with Ej difficulty value, which makes EJ_GetSectionInfo crash the game when called with invalid difficulty index set.
	self:Debug("LoadAddOn should have fired for "..mod.name, 2)
	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		if reason then
			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_"..reason or ""])))
		else
			self:Debug("LoadAddOn failed and did not give reason")
		end
		return false
	else
		self:Debug("LoadAddOn should have succeeded for "..mod.name, 2)
		self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
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
					for i, v in ipairs(DBM.AddOns) do
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
		if (self.Options.DebugLevel > 2 or (Transcriptor and Transcriptor:IsLogging())) and uId:find("boss") then
			local targetName = UnitName(uId.."target") or "nil"
			self:Debug(uId.." changed targets to "..targetName)
		end
		--Active BossUnitTargetScanner
		if targetMonitor[uId] and UnitExists(uId.."target") and UnitPlayerOrPetInRaid(uId.."target") then
			self:Debug("targetMonitor for this unit exists, target exists", 2)
			local modId, returnFunc = targetMonitor[uId].modid, targetMonitor[uId].returnFunc
			self:Debug("targetMonitor: "..modId..", "..uId..", "..returnFunc, 2)
			if not targetMonitor[uId].allowTank then
				local tanking, status = UnitDetailedThreatSituation(uId, uId.."target")--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
				if tanking or (status == 3) then
					self:Debug("targetMonitor ending for unit without 'allowTank', ignoring target", 2)
					return
				end
			end
			local mod = self:GetModByName(modId)
			self:Debug("targetMonitor success for this unit, a valid target for returnFunc", 2)
			mod[returnFunc](mod, self:GetUnitFullName(uId.."target"), uId.."target", uId)--Return results to warning function with all variables.
			targetMonitor[uId] = nil
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

	local function restoreTimerTrackerSounds()
		SOUNDKIT.UI_BATTLEGROUND_COUNTDOWN_TIMER = 25477
		SOUNDKIT.UI_BATTLEGROUND_COUNTDOWN_FINISHED = 25478
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
		if DBM.Options.BlockNoteShare or InCombatLockdown() or UnitAffectingCombat("player") or IsFalling() or DBM:GetRaidRank(sender) == 0 then return end
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then return end
		--^^You are in LFR, BG, or LFG. Block note syncs. They shouldn't be sendable, but in case someone edits DBM^^
		local mod = DBM:GetModByName(modid or "")
		local ability = abilityName or DBM_CORE_UNKNOWN
		if mod and modvar and text and text ~= "" then
			if DBM:AntiSpam(5, modvar) then--Don't allow calling same note more than once per 5 seconds
				DBM:AddMsg(DBM_CORE_NOTE_SHARE_SUCCESS:format(sender, abilityName))
				DBM:ShowNoteEditor(mod, modvar, ability, text, sender)
			else
				DBM:Debug(sender.." is attempting to send too many notes so notes are being throttled")
			end
		else
			DBM:AddMsg(DBM_CORE_NOTE_SHARE_FAIL:format(sender, ability))
		end
	end

	syncHandlers["C"] = function(sender, delay, mod, modRevision, startHp, dbmRevision, modHFRevision)
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
					DBM:StartCombat(mod, delay + lag, "SYNC from - "..sender, true, startHp)
					if (mod.revision < modHFRevision) and (mod.revision > 1000) then--mod.revision because we want to compare to OUR revision not senders
						if DBM:AntiSpam(3, "HOTFIX") and not DBM.Options.DontShowReminders then
							if DBM.HighestRelease < modHFRevision then--There is a newer RELEASE version of DBM out that has this mods fixes
								showConstantReminder = 2
								DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HOTFIX)
							else--This mods fixes are in an alpha version
								DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA)
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
			canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			canSetIcons[optionName] = false
		end
		local name = DBM:GetFullPlayerNameByGUID(iconSetPerson[optionName]) or DBM_CORE_UNKNOWN
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
	syncHandlers["PT"] = function(sender, timer, lastMapID, target)
		if DBM.Options.DontShowUserTimers then return end
		local LFGTankException = IsPartyLFG() and UnitGroupRolesAssigned(sender) == "TANK"
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup() and not LFGTankException) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		if (lastMapID and tonumber(lastMapID) ~= LastInstanceMapID) or (not lastMapID and DBM.Options.DontShowPTNoID) then return end
		timer = tonumber(timer or 0)
		if timer > 60 or (timer > 0 and timer < 3) then
			return
		end
		if not dummyMod then
			local threshold = DBM.Options.PTCountThreshold2
			threshold = floor(threshold)
			dummyMod = DBM:NewMod("PullTimerCountdownDummy")
			DBM:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
			dummyMod.text = dummyMod:NewAnnounce("%s", 1, "132349")
			dummyMod.geartext = dummyMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3)
			dummyMod.timer = dummyMod:NewTimer(20, "%s", "132349", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 1, threshold)
		end
		--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
		if not DBM.Options.DontShowPT2 then--and DBM.Bars:GetBar(DBM_CORE_TIMER_PULL)
			dummyMod.timer:Stop()
		end
		if not DBM.Options.DontShowPTCountdownText then
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")--easiest way to nil out timers on TimerTracker frame. This frame just has no actual star/stop functions
			DBM:Unschedule(restoreTimerTrackerSounds)
			restoreTimerTrackerSounds()
		end
		dummyMod.text:Cancel()
		if timer == 0 then return end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is why we let above part of code run but not below)
		DBM:FlashClientIcon()
		if not DBM.Options.DontShowPT2 then
			dummyMod.timer:Start(timer, DBM_CORE_TIMER_PULL)
		end
		if not DBM.Options.DontShowPTCountdownText then
			--Start A TimerTracker timer by tricking it to start a BG timer
			TimerTracker_OnEvent(TimerTracker, "START_TIMER", 1, timer, timer)
			--Set default timer sound globals to fake values
			SOUNDKIT.UI_BATTLEGROUND_COUNTDOWN_TIMER = 999999
			SOUNDKIT.UI_BATTLEGROUND_COUNTDOWN_FINISHED = 999999
			--But schedule method to restore the globals when timer ends
			DBM:Unschedule(restoreTimerTrackerSounds)
			DBM:Schedule(timer+3, restoreTimerTrackerSounds)
			--Find the timer object DBM just created and hack our own changes into it.
			local timerObject
			for a,b in pairs(TimerTracker.timerList) do
				if b.type == 1 and not b.isFree then
					timerObject = b
					break
				end
			end
			if timerObject then
				--Set end texture to nothing to eliminate pvp logo/hourglass
				timerObject.GoTexture:SetTexture("")
				timerObject.GoTextureGlow:SetTexture("")
				--We don't want the PVP bar, we only want timer text
				if timer > 10 then
					--timerObject.startNumbers:Play()
					timerObject.bar:Hide()
				end
			end
		end
		if not DBM.Options.DontShowPTText then
			if target then
				dummyMod.text:Show(DBM_CORE_ANNOUNCE_PULL_TARGET:format(target, timer, sender))
				dummyMod.text:Schedule(timer, DBM_CORE_ANNOUNCE_PULL_NOW_TARGET:format(target))
			else
				dummyMod.text:Show(DBM_CORE_ANNOUNCE_PULL:format(timer, sender))
				dummyMod.text:Schedule(timer, DBM_CORE_ANNOUNCE_PULL_NOW)
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
				if type and type == DBM_CORE_GEAR_FISHING_POLE then
					fishingPole = true
				end
			end
			if IsInRaid() and difference >= 30 then
				dummyMod.geartext:Show(DBM_CORE_GEAR_WARNING:format(floor(difference)))
			elseif IsInRaid() and (not weapon or fishingPole) then
				dummyMod.geartext:Show(DBM_CORE_GEAR_WARNING_WEAPON)
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
				DBM:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
				dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, "237538")
				dummyMod2.timer = dummyMod2:NewTimer(20, "%s", "237538", nil, nil, 0, nil, nil, DBM.Options.DontPlayPTCountdown and 0 or 1, threshold)
			end
			--Cancel any existing break timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
			if not DBM.Options.DontShowPT2 then--and DBM.Bars:GetBar(DBM_CORE_TIMER_BREAK)
				dummyMod2.timer:Stop()
			end
			dummyMod2.text:Cancel()
			DBM.Options.tempBreak2 = nil
			if timer == 0 then return end--"/dbm break 0" will strictly be used to cancel the break timer (which is why we let above part of code run but not below)
			self.Options.tempBreak2 = timer.."/"..time()
			if not self.Options.DontShowPT2 then
				dummyMod2.timer:Start(timer, DBM_CORE_TIMER_BREAK)
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
				dummyMod2.text:Show(DBM_CORE_BREAK_START:format(strFromTime(timer).." ("..hour..":"..minute..")", sender))
				if timer/60 > 10 then dummyMod2.text:Schedule(timer - 10*60, DBM_CORE_BREAK_MIN:format(10)) end
				if timer/60 > 5 then dummyMod2.text:Schedule(timer - 5*60, DBM_CORE_BREAK_MIN:format(5)) end
				if timer/60 > 2 then dummyMod2.text:Schedule(timer - 2*60, DBM_CORE_BREAK_MIN:format(2)) end
				if timer/60 > 1 then dummyMod2.text:Schedule(timer - 1*60, DBM_CORE_BREAK_MIN:format(1)) end
				dummyMod2.text:Schedule(timer, DBM_CORE_ANNOUNCE_BREAK_OVER:format(hour..":"..minute))
			end
			C_TimerAfter(timer, function() self.Options.tempBreak2 = nil end)
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
		if DBM.Bars:GetBar(DBM_CORE_TIMER_BREAK) then return end--Already recovered. Prevent duplicate recovery
		breakTimerStart(DBM, timer, sender)
	end

	local function SendVersion(guild)
		if guild then
			local message = ("%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion)
			SendAddonMessage("D4", "GV\t" .. message, "GUILD")
			return
		end
		if DBM.Options.FakeBWVersion then
			SendAddonMessage("BigWigs", versionResponseString:format(fakeBWVersion, fakeBWHash), IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
			return
		end
		--(Note, faker isn't to screw with bigwigs nor is theirs to screw with dbm, but rathor raid leaders who don't let people run WTF they want to run)
		local VPVersion
		local VoicePack = DBM.Options.ChosenVoicePack
		if not voiceSessionDisabled and VoicePack ~= "None" and DBM.VoiceVersions[VoicePack] then
			VPVersion = "/ VP"..VoicePack..": v"..DBM.VoiceVersions[VoicePack]
		end
		if VPVersion then
			sendSync("V", ("%s\t%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), VPVersion))
		else
			sendSync("V", ("%s\t%s\t%s\t%s\t%s"):format(tostring(DBM.Revision), tostring(DBM.ReleaseRevision), DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons)))
		end
	end

	local function HandleVersion(revision, version, displayVersion, sender, noRaid)
		if version > DBM.Revision then -- Update reminder
			if #newerVersionPerson < 4 then
				if not checkEntry(newerVersionPerson, sender) then
					newerVersionPerson[#newerVersionPerson + 1] = sender
					DBM:Debug("Newer version detected from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision), 3)
				end
				if #newerVersionPerson == 2 and updateNotificationDisplayed < 2 then--Only requires 2 for update notification.
					if DBM.HighestRelease < version then
						DBM.HighestRelease = version
					end
					DBM.NewerVersion = displayVersion
					--UGLY hack to get release version number instead of alpha one
					if DBM.NewerVersion:find("alpha") then
						local temp1, temp2 = string.split(" ", DBM.NewerVersion)--Strip down to just version, no alpha
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
					--Find min revision.
					updateNotificationDisplayed = 2
					AddMsg(DBM, DBM_CORE_UPDATEREMINDER_HEADER:match("([^\n]*)"))
					AddMsg(DBM, DBM_CORE_UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, version))
					showConstantReminder = 1
				elseif not noRaid and #newerVersionPerson == 3 and updateNotificationDisplayed < 3 then--The following code requires at least THREE people to send that higher revision. That should be more than adaquate
					--Disable if revision grossly out of date even if not major patch.
					if raid[newerVersionPerson[1]] and raid[newerVersionPerson[2]] and raid[newerVersionPerson[3]] then
						local revDifference = mmin(((raid[newerVersionPerson[1]].revision or 0) - DBM.Revision), ((raid[newerVersionPerson[2]].revision or 0) - DBM.Revision), ((raid[newerVersionPerson[3]].revision or 0) - DBM.Revision))
						if revDifference > 100000000 then--Approx 1 month old 20190416172622
							if updateNotificationDisplayed < 3 then
								updateNotificationDisplayed = 3
								AddMsg(DBM, DBM_CORE_UPDATEREMINDER_DISABLE)
								DBM:Disable(true)
							end
						end
					--Disable if out of date and it's a major patch.
					elseif not testBuild and dbmToc < wowTOC then
						updateNotificationDisplayed = 3
						AddMsg(DBM, DBM_CORE_UPDATEREMINDER_MAJORPATCH)
						DBM:Disable(true)
					end
				end
			end
		end
		if DBM.DisplayVersion:find("alpha") and #newerRevisionPerson < 3 and updateNotificationDisplayed < 2 and (revision - DBM.Revision) > 7000000 then--Approx 7 days old 20190416172622
			if not checkEntry(newerRevisionPerson, sender) then
				newerRevisionPerson[#newerRevisionPerson + 1] = sender
				DBM:Debug("Newer revision detected from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision))
			end
			if #newerRevisionPerson == 2 and raid[newerRevisionPerson[1]] and raid[newerRevisionPerson[2]] then
				local revDifference = mmin(((raid[newerRevisionPerson[1]].revision or 0) - DBM.Revision), ((raid[newerRevisionPerson[2]].revision or 0) - DBM.Revision))
				if testBuild and revDifference > 3000000 then--Approx 3 days old 20190416172622
					updateNotificationDisplayed = 3
					AddMsg(DBM, DBM_CORE_UPDATEREMINDER_DISABLE)
					DBM:Disable(true)
				else
					updateNotificationDisplayed = 2
					AddMsg(DBM, DBM_CORE_UPDATEREMINDER_HEADER_ALPHA:format(revDifference))
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
		DBM:Unschedule(SendVersion, true)--Throttle so we don't needlessly send tons of comms during initial raid invites
		DBM:Schedule(3, SendVersion, true)--Send version if 3 seconds have past since last "Hi" sync
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
			HandleVersion(revision, version, displayVersion, sender, true)
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

		local inspopup = CreateFrame("Frame", "DBMPopupLockout", UIParent)
		inspopup:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",--312922
			edgeFile = 131072,--"Interface\\DialogFrame\\UI-DialogBox-Border"
			tile = true, tileSize = 16, edgeSize = 16,
			insets = {left = 1, right = 1, top = 1, bottom = 1}}
		)
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
			inspopuptext:SetText(DBM_REQ_INSTANCE_ID_PERMISSION:format(sender, sender))
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
				local name, id, _, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, textDiff, _, progress = GetSavedInstanceInfo(i)
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
				local bossName = EJ_GetEncounterInfo(modId) or name or DBM_CORE_UNKNOWN
				local difficultyName = DBM_CORE_UNKNOWN
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
				DBM:AddMsg(DBM_CORE_GUILD_COMBAT_STARTED:format(difficultyName.."-"..bossName))
			end
		end

		syncHandlers["GCE"] = function(sender, modId, ver, wipe, time, difficulty, difficultyModifier, name, wipeHP)
			if not DBM.Options.ShowGuildMessages or not difficulty then return end
			if not ver or not (ver == "5") then return end--Ignore old versions
			if DBM:AntiSpam(5, "GCE") then
				if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
				difficulty = tonumber(difficulty)
				if not DBM.Options.ShowGuildMessagesPlus and difficulty == 8 then return end
				local bossName = EJ_GetEncounterInfo(modId) or name or DBM_CORE_UNKNOWN
				local difficultyName = DBM_CORE_UNKNOWN
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
					DBM:AddMsg(DBM_CORE_GUILD_COMBAT_ENDED_AT:format(difficultyName.."-"..bossName, wipeHP, time))
				else
					DBM:AddMsg(DBM_CORE_GUILD_BOSS_DOWN:format(difficultyName.."-"..bossName, time))
				end
			end
		end

		syncHandlers["WBE"] = function(sender, modId, realm, health, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossEngage[modId..realm] and (GetTime() - lastBossEngage[modId..realm] < 30) then return end--We recently got a sync about this boss on this realm, so do nothing.
			lastBossEngage[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or DBM_CORE_UNKNOWN
				DBM:AddMsg(DBM_CORE_WORLDBOSS_ENGAGED:format(bossName, floor(health), sender))
			end
		end

		syncHandlers["WBD"] = function(sender, modId, realm, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
			lastBossDefeat[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or DBM_CORE_UNKNOWN
				DBM:AddMsg(DBM_CORE_WORLDBOSS_DEFEATED:format(bossName, sender))
			end
		end

		whisperSyncHandlers["WBE"] = function(sender, modId, realm, health, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossEngage[modId..realm] and (GetTime() - lastBossEngage[modId..realm] < 30) then return end
			lastBossEngage[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
				local toonName = gameAccountInfo and gameAccountInfo.characterName or DBM_CORE_UNKNOWN
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or DBM_CORE_UNKNOWN
				DBM:AddMsg(DBM_CORE_WORLDBOSS_ENGAGED:format(bossName, floor(health), toonName))
			end
		end

		whisperSyncHandlers["WBD"] = function(sender, modId, realm, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
			lastBossDefeat[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(sender)
				local toonName = gameAccountInfo and gameAccountInfo.characterName or DBM_CORE_UNKNOWN
				modId = tonumber(modId)--If it fails to convert into number, this makes it nil
				local bossName = modId and EJ_GetEncounterInfo(modId) or name or DBM_CORE_UNKNOWN
				DBM:AddMsg(DBM_CORE_WORLDBOSS_DEFEATED:format(bossName, toonName))
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
			name = name or DBM_CORE_UNKNOWN
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
					DBM:Schedule(0.99, DBM.AddMsg, DBM, DBM_INSTANCE_INFO_ALL_RESPONSES)
					allResponded = true
				end
				C_TimerAfter(1, showResults) --Delay results so we allow time for same sender to send more than 1 lockout, otherwise, if we get expectedResponses before all data is sent from 1 user, we clip some of their data.
			end
		end

		function showResults()
			local resultCount = 0
			-- TODO: you could catch some localized instances by observing IDs if there are multiple players with the same instance ID but a different name ;) (not that useful if you are trying to get a fresh instance)
			DBM:AddMsg(DBM_INSTANCE_INFO_RESULTS, false)
			DBM:AddMsg("---", false)
			for i, v in pairs(results.data) do
				resultCount = resultCount + 1
				DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_HEADER:format(v.name, (results.difftext[v.diff] or v.diff)), false)
				for id, v in pairs(v.ids) do
					if v.haveid then
						DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_INSTANCE:format(id, v.progress, tconcat(v, ", ")), false)
					else
						DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_INSTANCE2:format(v.progress, tconcat(v, ", ")), false)
					end
				end
				DBM:AddMsg("---", false)
			end
			if resultCount == 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_NOLOCKOUT, false)
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
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_DENIED:format(tconcat(denied, ", ")), false)
			end
			if #away > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_AWAY:format(tconcat(away, ", ")), false)
			end
			if #noResponse > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_NO_RESPONSE:format(tconcat(noResponse, ", ")), false)
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
			for k, v in pairs(results.responses) do
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
			for i, v in pairs(raid) do
				if v.revision and v.name ~= playerName and UnitIsConnected(v.id) then
					r = r + 1
				end
			end
			return r
		end

		function updateInstanceInfo(timeRemaining, dontAddShowResultNowButton)
			local numResponses, sent, denied, away = getResponseStats()
			local dbmUsers = getNumDBMUsers()
			DBM:AddMsg(DBM_INSTANCE_INFO_STATUS_UPDATE:format(numResponses, dbmUsers, sent, denied, timeRemaining), false)
			if not dontAddShowResultNowButton then
				if dbmUsers - numResponses <= 7 then -- waiting for 7 or less players, show their names and the early result option
					-- copied from above, todo: implement a smarter way of keeping track of stuff like this
					local noResponse = {}
					for i = 1, GetNumGroupMembers() do
						if not UnitIsUnit("raid"..i, "player") and raid[GetRaidRosterInfo(i)] and raid[GetRaidRosterInfo(i)].revision then -- only show players who actually can respond (== DBM users)
							tinsert(noResponse, (GetRaidRosterInfo(i)))
						end
					end
					for i, v in pairs(results.responses) do
						removeEntry(noResponse, i)
					end

					--[[
					-- this looked like the easiest way (for some reason?) to create the player string when writing this code -.-
					local function dup(...) if select("#", ...) == 0 then return else return ..., ..., dup(select(2, ...)) end end
					DBM:AddMsg(DBM_INSTANCE_INFO_SHOW_RESULTS:format(("|Hplayer:%s|h[%s]|h| "):rep(#noResponse):format(dup(unpack(noResponse)))), false)
					]]
					-- code that one can actually read
					for i, v in ipairs(noResponse) do
						noResponse[i] = ("|Hplayer:%s|h[%s]|h|"):format(v, v)
					end
					DBM:AddMsg(DBM_INSTANCE_INFO_SHOW_RESULTS:format(tconcat(noResponse, ", ")), false)
				end
			end
		end

		function DBM:RequestInstanceInfo()
			self:AddMsg(DBM_INSTANCE_INFO_REQUESTED)
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
		elseif channel == "WHISPER" and sender ~= playerName and (checkForSafeSender(sender, true) or DBM:GetRaidUnitId(sender)) then -- separate between broadcast and unicast, broadcast must not be sent as unicast or vice-versa
			handler = whisperSyncHandlers[prefix]
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
					for i = 1, #oocBWComms do
						local mod = oocBWComms[i]
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
			if msg:find("spell:") and (DBM.Options.DebugLevel > 2 or (Transcriptor and Transcriptor:IsLogging())) then
				local spellId = string.match(msg, "spell:(%d+)") or DBM_CORE_UNKNOWN
				local spellName = string.match(msg, "h%[(.-)%]|h") or DBM_CORE_UNKNOWN
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
		frame = CreateFrame("Frame", "DBMUpdateReminder", UIParent)
		frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
		frame:SetWidth(430)
		frame:SetHeight(140)
		frame:SetPoint("TOP", 0, -230)
		frame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",--131071
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,--131072
			insets = {left = 11, right = 12, top = 12, bottom = 11},
		})
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
		urlText = url or DBM_CORE_UPDATEREMINDER_URL or "http://www.deadlybossmods.com"
		if not frame then
			createFrame()
		else
			editBox:SetText(urlText)
			editBox:HighlightText()
		end
		frame:Show()
		if newVersion then
			fontstring:SetText(DBM_CORE_UPDATEREMINDER_HEADER:format(newVersion, newRevision))
			fontstringFooter:SetText(DBM_CORE_UPDATEREMINDER_FOOTER)
		elseif text then
			fontstring:SetText(text)
			fontstringFooter:SetText(DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC)
		end
	end
end

--------------------
--  Notes Editor  --
--------------------
do
	local frame, fontstring, fontstringFooter, editBox, button3

	local function createFrame()
		frame = CreateFrame("Frame", "DBMNotesEditor", UIParent)
		frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
		frame:SetWidth(430)
		frame:SetHeight(140)
		frame:SetPoint("TOP", 0, -230)
		frame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",--131071
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,--131072
			insets = {left = 11, right = 12, top = 12, bottom = 11},
		})
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
				DBM:AddMsg(DBM_CORE_NOTESHAREERRORBLANK)
			elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
				DBM:AddMsg(DBM_CORE_NOTESHAREERRORGROUPFINDER)
			else
				local msg = modid.."\t"..modvar.."\t"..syncText.."\t"..abilityName
				if IsInRaid() then
					if DBM:GetRaidRank(playerName) == 0 then
						DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
					else
						SendAddonMessage("D4", "NS\t" .. msg, "RAID")
						DBM:AddMsg(DBM_CORE_NOTESHARED)
					end
				elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
					if DBM:GetRaidRank(playerName) == 0 then
						DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
					else
						SendAddonMessage("D4", "NS\t" .. msg, "PARTY")
						DBM:AddMsg(DBM_CORE_NOTESHARED)
					end
				else--Solo
					DBM:AddMsg(DBM_CORE_NOTESHAREERRORSOLO)
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
				self:AddMsg(DBM_CORE_NOTESHAREERRORALREADYOPEN)
				return
			end
		end
		frame:Show()
		fontstringFooter:SetText(DBM_CORE_NOTEFOOTER)
		self.Noteframe.mod = mod
		self.Noteframe.modvar = modvar
		self.Noteframe.abilityName = abilityName
		if syncText then
			button3:Hide()--Don't show share button in shared notes
			fontstring:SetText(DBM_CORE_NOTESHAREDHEADER:format(sender, abilityName))
			editBox:SetText(syncText)
		else
			button3:Show()
			fontstring:SetText(DBM_CORE_NOTEHEADER:format(abilityName))
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
		if dbmIsEnabled and combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
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
			if not voiceSessionDisabled and voice ~= "None" then
				path = "Interface\\AddOns\\DBM-VP"..voice.."\\checkhp.ogg"
			end
			self:PlaySound(path)
			if UnitHealthMax("player") ~= 0 then
				local health = UnitHealth("player") / UnitHealthMax("player") * 100
				self:AddMsg(DBM_CORE_AFK_WARNING:format(health))
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
		if dbmIsEnabled and combatInfo[LastInstanceMapID] then
			self:Debug("INSTANCE_ENCOUNTER_ENGAGE_UNIT event fired for zoneId"..LastInstanceMapID, 3)
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type:find("combat") and isBossEngaged(v.multiMobPullDetection or v.mob) then
					self:StartCombat(v.mod, 0, "IEEU")
				end
			end
		end
	end

	function DBM:UNIT_TARGETABLE_CHANGED(uId)
		if self.Options.DebugLevel > 2 or (Transcriptor and Transcriptor:IsLogging()) then
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
			if not self.Options.DontShowReminders then
				self:CheckAvailableMods()
			end
			if combatInfo[LastInstanceMapID] then
				for i, v in ipairs(combatInfo[LastInstanceMapID]) do
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
				local name = string.split(",", name)
				self.Bars:CreateBar(v.respawnTime, DBM_CORE_TIMER_RESPAWN:format(name), 237538)--Interface\\Icons\\Spell_Holy_BorrowedTime
				fireEvent("DBM_TimerStart", "DBMRespawnTimer", DBM_CORE_TIMER_RESPAWN:format(name), v.respawnTime, "237538", "extratimer", nil, 0, v.id)
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
		for i, v in ipairs(exp) do
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
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
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
				local spellName = DBM:GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
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
		if IsInGroup() and not BigWigs then
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
		if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
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
		local wipe = 1 -- 0: no wipe, 1: normal wipe, 2: wipe by UnitExists check.
		if IsInScenarioGroup() or (difficultyIndex == 11) or (difficultyIndex == 12) then -- Scenario mod uses special combat start and must be enabled before sceniro end. So do not wipe.
			wipe = 0
		elseif IsEncounterInProgress() then -- Encounter Progress marked, you obviously in combat with boss. So do not Wipe
			wipe = 0
		elseif savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- On dead or ghost, unit combat status detection would be fail. If you ghost in instance, that means wipe. But in worldboss, ghost means not wipe. So do not wipe.
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
			local maxDelayTime = (savedDifficulty == "worldboss" and 15) or 5 --wait 10s more on worldboss do actual wipe.
			for i, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			self:Schedule(maxDelayTime, checkWipe, self, true)
		end
	end
end

function checkBossHealth(self)
	if #inCombat > 0 then
		for i, v in ipairs(inCombat) do
			if not v.multiMobPullDetection or v.mainBoss then
				self:GetBossHP(v.mainBoss or v.combatInfo.mob or -1)
			else
				for _, mob in ipairs(v.multiMobPullDetection) do
					self:GetBossHP(mob)
				end
			end
		end
		self:Schedule(1, checkBossHealth, self)
	end
end

function checkCustomBossHealth(self, mod)
	mod:CustomHealthUpdate()
	self:Schedule(1, checkCustomBossHealth, self, mod)
end

do
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
		["normalwarfront"] = "normal",
		["heroicwarfront"] = "heroic",
		["normalisland"] = "normal",
		["heroicisland"] = "heroic",
		["mythicisland"] = "mythic",
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

	function DBM:StartCombat(mod, delay, event, synced, syncedStartHp)
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
			end
			--check completed. starting combat
			if self.Options.DisableGuildStatus and UnitIsGroupLeader("player") then
				sendSync("DGP")
			end
			tinsert(inCombat, mod)
			if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
			end
			--Fix for "attempt to perform arithmetic on field 'stats' (a nil value)"
			if not mod.stats then
				self:AddMsg(DBM_CORE_BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
				mod.ignoreBestkill = true--Force this to true so we don't check any more occurances of "stats"
			elseif event == "TIMER_RECOVERY" then --add a lag time to delay when TIMER_RECOVERY
				delay = delay + select(4, GetNetStats()) / 1000
			end
			--set mod default info
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = self:GetCurrentInstanceDifficulty()
			local name = mod.combatInfo.name
			local modId = mod.id
			if C_Scenario.IsInScenario() and (mod.addon.type == "SCENARIO") then
				mod.inScenario = true
			end
			mod.inCombat = true
			mod.blockSyncs = nil
			mod.combatInfo.pull = GetTime() - (delay or 0)
			bossuIdFound = (event or "") == "IEEU"
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
					self.Options.sfxDisabled = true
					SetCVar("Sound_EnableSFX", 0)
				end
				--boss health info scheduler
				if mod.CustomHealthUpdate then
					self:Schedule(1, checkCustomBossHealth, self, mod)
				else
					self:Schedule(1, checkBossHealth, self)
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
				if mod.stats then
					if not mod.stats[statVarTable[savedDifficulty].."Pulls"] then mod.stats[statVarTable[savedDifficulty].."Pulls"] = 0 end
					mod.stats[statVarTable[savedDifficulty].."Pulls"] = mod.stats[statVarTable[savedDifficulty].."Pulls"] + 1
				end
				--show speed timer
				if self.Options.AlwaysShowSpeedKillTimer2 and mod.stats and not mod.ignoreBestkill then
					local bestTime
					if difficultyIndex == 8 then--Mythic+/Challenge Mode
						local bestMPRank = mod.stats.challengeBestRank or 0
						if bestMPRank == difficultyModifier then
							--Don't show speed kill timer if not our highest rank. DBM only stores highest rank
							bestTime = mod.stats[statVarTable[savedDifficulty].."BestTime"]
						end
					else
						bestTime = mod.stats[statVarTable[savedDifficulty].."BestTime"]
					end
					if bestTime and bestTime > 0 then
						local speedTimer = mod:NewTimer(bestTime, DBM_SPEED_KILL_TIMER_TEXT, "237538", nil, false)
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
								canSetIcons[option] = true
							end
						end
					end
				end
				--call OnCombatStart
				if mod.OnCombatStart then
					mod:OnCombatStart(delay or 0, event == "PLAYER_REGEN_DISABLED_AND_MESSAGE" or event == "SPELL_CAST_SUCCESS")
				end
				--send "C" sync
				if not synced then
					sendSync("C", (delay or 0).."\t"..modId.."\t"..(mod.revision or 0).."\t"..startHp.."\t"..tostring(DBM.Revision).."\t"..(mod.hotfixNoticeRev or 0))
				end
				if self.Options.DisableStatusWhisper and UnitIsGroupLeader("player") and (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) then
					sendSync("DSW")
				end
				--show bigbrother check
				if self.Options.ShowBigBrotherOnCombatStart and BigBrother and type(BigBrother.ConsumableCheck) == "function" then
					if self.Options.BigBrotherAnnounceToRaid then
						BigBrother:ConsumableCheck("RAID")
					else
						BigBrother:ConsumableCheck("SELF")
					end
				end
				--show enage message
				if self.Options.ShowEngageMessage then
					if mod.ignoreBestkill and (savedDifficulty == "worldboss") then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
						self:AddMsg(DBM_CORE_COMBAT_STARTED_IN_PROGRESS:format(difficultyText..name))
					elseif mod.ignoreBestkill and mod.inScenario then
						self:AddMsg(DBM_CORE_SCENARIO_STARTED_IN_PROGRESS:format(difficultyText..name))
					else
						if mod.addon.type == "SCENARIO" then
							self:AddMsg(DBM_CORE_SCENARIO_STARTED:format(difficultyText..name))
						else
							self:AddMsg(DBM_CORE_COMBAT_STARTED:format(difficultyText..name))
							if (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not statusGuildDisabled and not self.Options.DisableGuildStatus then--Only send relevant content, not guild beating down lich king or LFR.
								SendAddonMessage("D4", "GCB\t"..modId.."\t2\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name, "GUILD")
							end
						end
					end
				end
				--stop pull count
				local dummyMod = self:GetModByName("PullTimerCountdownDummy")
				if dummyMod then--stop pull timer
					dummyMod.text:Cancel()
					dummyMod.timer:Stop()
					TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
				end
				if BigWigs and BigWigs.db.profile.raidicon and not self.Options.DontSetIcons and self:GetRaidRank() > 0 then--Both DBM and bigwigs have raid icon marking turned on.
					self:AddMsg(DBM_CORE_BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either or turned off to stop this alert)
				end
				if self.Options.EventSoundEngage2 and self.Options.EventSoundEngage2 ~= "" and self.Options.EventSoundEngage2 ~= "None" then
					self:PlaySoundFile(self.Options.EventSoundEngage2, nil, true)
				end
				fireEvent("DBM_MusicStart", "BossEncounter")
				if self.Options.EventSoundMusic and self.Options.EventSoundMusic ~= "None" and self.Options.EventSoundMusic ~= "" and not (self.Options.EventMusicMythicFilter and (savedDifficulty == "mythic" or savedDifficulty == "challenge")) then
					if not self.Options.tempMusicSetting then
						self.Options.tempMusicSetting = tonumber(GetCVar("Sound_EnableMusic")) or 1
						if self.Options.tempMusicSetting == 0 then
							SetCVar("Sound_EnableMusic", 1)
						else
							self.Options.tempMusicSetting = nil--Don't actually need it
						end
					end
					local path = "MISSING"
					if self.Options.EventSoundMusic == "Random" then
						local usedTable = self.Options.EventSoundMusicCombined and DBM.Music or DBM.BattleMusic
						local random = fastrandom(3, #usedTable)
						path = usedTable[random].value
					else
						path = self.Options.EventSoundMusic
					end
					PlayMusic(path)
					self.Options.musicPlaying = true
					DBM:Debug("Starting combat music with file: "..path)
				end
			else
				self:AddMsg(DBM_CORE_COMBAT_STATE_RECOVERED:format(difficultyText..name, strFromTime(delay)))
				if mod.OnTimerRecovery then
					mod:OnTimerRecovery()
				end
			end
			if savedDifficulty == "worldboss" and not mod.noWBEsync then
				if lastBossEngage[modId..playerRealm] and (GetTime() - lastBossEngage[modId..playerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
				lastBossEngage[modId..playerRealm] = GetTime()--Update last engage time, that way we ignore our own sync
				if IsInGuild() then
					SendAddonMessage("D4", "WBE\t"..modId.."\t"..playerRealm.."\t"..startHp.."\t8\t"..name, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
				end
				local _, numBNetOnline = BNGetNumFriends()
				for i = 1, numBNetOnline do
					local sameRealm = false
					local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
					if accountInfo then
						local gameAccountID, isOnline, userRealm = accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.isOnline, accountInfo.gameAccountInfo.realmName
						if gameAccountID and isOnline and userRealm then
							--local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(presenceID)--Just in case required, if it can't actually be pulled from sub table of accountInfo above
							--local userRealm = accountInfo.gameAccountInfo.realmName or DBM_CORE_UNKNOWN
							if connectedServers then
								for i = 1, #connectedServers do
									if userRealm == connectedServers[i] then
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
								BNSendGameData(gameAccountID, "D4", "WBE\t"..modId.."\t"..userRealm.."\t"..startHp.."\t8\t"..name)--Just send users realm for pull, so we can eliminate connectedServers checks on sync handler
							end
						end
					end
				end
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
					for i, v in ipairs(combatInfo[LastInstanceMapID]) do
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
				self:AddMsg(DBM_CORE_AFK_WARNING:format(health))
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
					self:Schedule(3, mod.OnCombatEnd, mod, wipe) -- Remove accidentally shown frames
				end
			end
			if mod.updateInterval then
				mod:UnregisterOnUpdateHandler()
			end
			mod:Stop()
			if enableIcons and not self.Options.DontSetIcons and not self.Options.DontRestoreIcons then
				-- restore saved previous icon
				for uId, icon in pairs(mod.iconRestore) do
					SetRaidTarget(uId, icon)
				end
				twipe(mod.iconRestore)
			end
			mod.inCombat = false
			mod.blockSyncs = true
			if mod.combatInfo.killMobs then
				for i, v in pairs(mod.combatInfo.killMobs) do
					mod.combatInfo.killMobs[i] = true
				end
			end
			if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local name = mod.combatInfo.name
			local modId = mod.id
			if wipe and mod.stats then
				mod.lastWipeTime = GetTime()
				--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
				local thisTime = GetTime() - mod.combatInfo.pull
				local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
				local wipeHP = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or DBM_CORE_UNKNOWN
				if mod.vb.phase then
					wipeHP = wipeHP.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
				end
				if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
					local bossesKilled = mod.numBoss - mod.vb.bossLeft
					wipeHP = wipeHP.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
				end
				local totalPulls = mod.stats[statVarTable[savedDifficulty].."Pulls"]
				local totalKills = mod.stats[statVarTable[savedDifficulty].."Kills"]
				if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
					totalPulls = totalPulls - 1
					mod.stats[statVarTable[savedDifficulty].."Pulls"] = totalPulls
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(DBM_CORE_SCENARIO_ENDED_AT:format(difficultyText..name, strFromTime(thisTime)))
						else
							self:AddMsg(DBM_CORE_COMBAT_ENDED_AT:format(difficultyText..name, wipeHP, strFromTime(thisTime)))
							--No reason to GCE it here, so omited on purpose.
						end
					end
				else
					if self.Options.ShowDefeatMessage then
						if scenario then
							self:AddMsg(DBM_CORE_SCENARIO_ENDED_AT_LONG:format(difficultyText..name, strFromTime(thisTime), totalPulls - totalKills))
						else
							self:AddMsg(DBM_CORE_COMBAT_ENDED_AT_LONG:format(difficultyText..name, wipeHP, strFromTime(thisTime), totalPulls - totalKills))
							if (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not statusGuildDisabled and not self.Options.DisableGuildStatus then--Maybe add mythic plus/CM?
								SendAddonMessage("D4", "GCE\t"..modId.."\t5\t1\t"..strFromTime(thisTime).."\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name.."\t"..wipeHP, "GUILD")
							end
						end
					end
					if self.Options.EventSoundWipe and self.Options.EventSoundWipe ~= "None" and self.Options.EventSoundWipe ~= "" then
						if self.Options.EventSoundWipe == "Random" then
							local random = fastrandom(3, #DBM.Defeat)
							self:PlaySoundFile(DBM.Defeat[random].value)--Since this one hard reads table, shouldn't need to validate path
						else
							self:PlaySoundFile(self.Options.EventSoundWipe, nil, true)
						end
					end
				end
				if not self.Options.DontShowReminders and showConstantReminder == 2 and IsInGroup() and savedDifficulty ~= "lfr" and savedDifficulty ~= "lfr25" then
					showConstantReminder = 1
					--Show message any time this is a mod that has a newer hotfix revision
					--These people need to know the wipe could very well be their fault.
					self:AddMsg(DBM_CORE_OUT_OF_DATE_NAG)
				end
				local msg
				for k, v in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS:format(playerName, difficultyText..(name or ""), totalPulls - totalKills)
						else
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, difficultyText..(name or ""), wipeHP, totalPulls - totalKills)
						end
					else
						if scenario then
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_WIPE:format(playerName, difficultyText..(name or ""))
						else
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_AT:format(playerName, difficultyText..(name or ""), wipeHP)
						end
					end
					sendWhisper(k, msg)
				end
				fireEvent("DBM_Wipe", mod)
			elseif not wipe and mod.stats then
				mod.lastKillTime = GetTime()
				local thisTime = GetTime() - (mod.combatInfo.pull or 0)
				local lastTime = mod.stats[statVarTable[savedDifficulty].."LastTime"]
				local bestTime = mod.stats[statVarTable[savedDifficulty].."BestTime"]
				if not mod.stats[statVarTable[savedDifficulty].."Kills"] or mod.stats[statVarTable[savedDifficulty].."Kills"] < 0 then mod.stats[statVarTable[savedDifficulty].."Kills"] = 0 end
				--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats[statVarTable[savedDifficulty].."Kills"] = mod.stats[statVarTable[savedDifficulty].."Kills"] + 1
				if mod.stats[statVarTable[savedDifficulty].."Kills"] > mod.stats[statVarTable[savedDifficulty].."Pulls"] then mod.stats[statVarTable[savedDifficulty].."Kills"] = mod.stats[statVarTable[savedDifficulty].."Pulls"] end
				if not mod.ignoreBestkill and mod.combatInfo.pull then
					mod.stats[statVarTable[savedDifficulty].."LastTime"] = thisTime
					--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
					if bestTime and bestTime > 0 and bestTime < 1.5 then
						mod.stats[statVarTable[savedDifficulty].."BestTime"] = thisTime
					else
						if difficultyIndex == 8 then--Mythic+/Challenge Mode
							local bestMPRank = mod.stats.challengeBestRank or 0
							if mod.stats.challengeBestRank > difficultyModifier then--Don't save time stats at all
								--DO nothing
							elseif mod.stats.challengeBestRank < difficultyModifier then--Update best time and best rank, even if best time is lower (for a lower rank)
								mod.stats.challengeBestRank = difficultyModifier--Update best rank
								mod.stats[statVarTable[savedDifficulty].."BestTime"] = thisTime--Write this time no matter what.
							else--Best rank must match current rank, so update time normally
								mod.stats[statVarTable[savedDifficulty].."BestTime"] = mmin(bestTime or mhuge, thisTime)
							end
						else
							mod.stats[statVarTable[savedDifficulty].."BestTime"] = mmin(bestTime or mhuge, thisTime)
						end
					end
				end
				local totalKills = mod.stats[statVarTable[savedDifficulty].."Kills"]
				if self.Options.ShowDefeatMessage then
					local msg = ""
					if not mod.combatInfo.pull then--was a bad pull so we ignored thisTime, should never happen
						if scenario then
							msg = DBM_CORE_SCENARIO_COMPLETE:format(difficultyText..name, DBM_CORE_UNKNOWN)
						else
							msg = DBM_CORE_BOSS_DOWN:format(difficultyText..name, DBM_CORE_UNKNOWN)
						end
					elseif mod.ignoreBestkill then--Should never happen in a scenario so no need for scenario check.
						if scenario then
							msg = DBM_CORE_SCENARIO_COMPLETE_I:format(difficultyText..name, totalKills)
						else
							msg = DBM_CORE_BOSS_DOWN_I:format(difficultyText..name, totalKills)
						end
					elseif not lastTime then
						if scenario then
							msg = DBM_CORE_SCENARIO_COMPLETE:format(difficultyText..name, strFromTime(thisTime))
						else
							msg = DBM_CORE_BOSS_DOWN:format(difficultyText..name, strFromTime(thisTime))
							if (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not statusGuildDisabled and not self.Options.DisableGuildStatus then
								SendAddonMessage("D4", "GCE\t"..modId.."\t5\t0\t"..strFromTime(thisTime).."\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name, "GUILD")
							end
						end
					elseif thisTime < (bestTime or mhuge) then
						if scenario then
							msg = DBM_CORE_SCENARIO_COMPLETE_NR:format(difficultyText..name, strFromTime(thisTime), strFromTime(bestTime), totalKills)
						else
							msg = DBM_CORE_BOSS_DOWN_NR:format(difficultyText..name, strFromTime(thisTime), strFromTime(bestTime), totalKills)
							if (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not statusGuildDisabled and not self.Options.DisableGuildStatus then
								SendAddonMessage("D4", "GCE\t"..modId.."\t5\t0\t"..strFromTime(thisTime).."\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name, "GUILD")
							end
						end
					else
						if scenario then
							msg = DBM_CORE_SCENARIO_COMPLETE_L:format(difficultyText..name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime), totalKills)
						else
							msg = DBM_CORE_BOSS_DOWN_L:format(difficultyText..name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime), totalKills)
							if (difficultyIndex == 8 or difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16) and InGuildParty() and not statusGuildDisabled and not self.Options.DisableGuildStatus then
								SendAddonMessage("D4", "GCE\t"..modId.."\t5\t0\t"..strFromTime(thisTime).."\t"..difficultyIndex.."\t"..difficultyModifier.."\t"..name, "GUILD")
							end
						end
					end
					self:Schedule(1, self.AddMsg, self, msg)
				end
				local msg
				for k, v in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS:format(playerName, difficultyText..(name or ""), totalKills)
						else
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL_STATS:format(playerName, difficultyText..(name or ""), totalKills)
						end
					else
						if scenario then
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_KILL:format(playerName, difficultyText..(name or ""))
						else
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL:format(playerName, difficultyText..(name or ""))
						end
					end
					sendWhisper(k, msg)
				end
				fireEvent("DBM_Kill", mod)
				if savedDifficulty == "worldboss" and not mod.noWBEsync then
					if lastBossDefeat[modId..playerRealm] and (GetTime() - lastBossDefeat[modId..playerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
					lastBossDefeat[modId..playerRealm] = GetTime()--Update last defeat time before we send it, so we don't handle our own sync
					if IsInGuild() then
						SendAddonMessage("D4", "WBD\t"..modId.."\t"..playerRealm.."\t8\t"..name, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
					end
					local _, numBNetOnline = BNGetNumFriends()
					for i = 1, numBNetOnline do
						local sameRealm = false
						local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
						if accountInfo then
							local gameAccountID, isOnline, userRealm = accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.isOnline, accountInfo.gameAccountInfo.realmName
							if gameAccountID and isOnline and userRealm then
								--local gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(presenceID)--Just in case required, if it can't actually be pulled from sub table of accountInfo above
								--local userRealm = accountInfo.gameAccountInfo.realmName or DBM_CORE_UNKNOWN
								if connectedServers then
									for i = 1, #connectedServers do
										if userRealm == connectedServers[i] then
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
									BNSendGameData(gameAccountID, "D4", "WBD\t"..modId.."\t"..userRealm.."\t8\t"..name)
								end
							end
						end
					end
				end
				if self.Options.EventSoundVictory2 and self.Options.EventSoundVictory2 ~= "None" and self.Options.EventSoundVictory2 ~= "" then
					if self.Options.EventSoundVictory2 == "Random" then
						local random = fastrandom(3, #DBM.Victory)
						self:PlaySoundFile(DBM.Victory[random].value)
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
				if self.Options.sfxDisabled then
					self.Options.sfxDisabled = nil
					SetCVar("Sound_EnableSFX", 1)
				end
				--cache table
				twipe(autoRespondSpam)
				twipe(bossHealth)
				twipe(bossHealthuIdCache)
				twipe(bossuIdCache)
				--sync table
				twipe(canSetIcons)
				twipe(iconSetRevision)
				twipe(iconSetPerson)
				twipe(addsGUIDs)
				bossuIdFound = false
				eeSyncSender = {}
				eeSyncReceived = 0
				twipe(targetMonitor)
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
			for i, v in pairs(v.combatInfo.killMobs) do
				if v then
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
		if LastInstanceMapID == 1861 or LastInstanceMapID == 2070 or LastInstanceMapID == 2096 or LastInstanceMapID == 2164 or LastInstanceMapID == 2217 then--BfA
			return true
		end
		return false
	end

	function DBM:StartLogging(timer, checkFunc)
		self:Unschedule(DBM.StopLogging)
		if self.Options.LogOnlyNonTrivial and ((LastInstanceType ~= "raid") or IsPartyLFG() or not isCurrentContent()) then return end
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
		if self.Options.AdvancedAutologBosses and Transcriptor then
			if not Transcriptor:IsLogging() then
				autoTLog = true
				self:AddMsg("|cffffff00"..DBM_CORE_TRANSCRIPTOR_LOG_START.."|r")
				Transcriptor:StartLog(1)
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
		if self.Options.AdvancedAutologBosses and Transcriptor and autoTLog then
			if Transcriptor:IsLogging() then
				autoTLog = false
				self:AddMsg("|cffffff00"..DBM_CORE_TRANSCRIPTOR_LOG_END.."|r")
				Transcriptor:StopLog(1)
			end
		end
	end
end

function DBM:SetCurrentSpecInfo()
	currentSpecGroup = GetSpecialization() or 1
	currentSpecID, currentSpecName = GetSpecializationInfo(currentSpecGroup)--give temp first spec id for non-specialization char. no one should use dbm with no specialization, below level 10, should not need dbm.
	currentSpecID = tonumber(currentSpecID)
end

--TODO C_IslandsQueue.GetIslandDifficultyInfo(), if 38-40 don't work
function DBM:GetCurrentInstanceDifficulty()
	local _, instanceType, difficulty, difficultyName, _, _, _, _, instanceGroupSize = GetInstanceInfo()
	if difficulty == 0 or (difficulty == 1 and instanceType == "none") or C_Garrison:IsOnGarrisonMap() then--draenor field returns 1, causing world boss mod bug.
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
	elseif difficulty == 17 or difficulty == 151 then--Flexible LFR (ie post WoD zones)/8.3+ LFR?
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
	local LSMMediaCacheBuilt = false
	local sharedMediaFileCache = {}
	local function buildLSMFileCache()
		local keytable = {}
		for k in next, LibStub("LibSharedMedia-3.0", true):HashTable("sound") do
			tinsert(keytable, k)
			for i=1,#keytable do
				local k = keytable[i]
				local path = LibStub("LibSharedMedia-3.0", true):HashTable("sound")[k]
				sharedMediaFileCache[path] = true
			end
		end
		LSMMediaCacheBuilt = true
	end
	local function playSound(self, path, ignoreSFX, validate)
		local soundSetting = self.Options.UseSoundChannel
		if type(path) == "number" then
			DBM:Debug("PlaySound playing with media "..path, 3)
			if soundSetting == "Dialog" then
				PlaySound(path, "Dialog", false)
			elseif ignoreSFX or soundSetting == "Master" then
				PlaySound(path, "Master", false)
			else
				PlaySound(path)--using SFX channel, leave forceNoDuplicates on.
			end
			fireEvent("DBM_PlaySound", path)
		else
			if validate then
				--Validate LibSharedMedia
				if not LSMMediaCacheBuilt then buildLSMFileCache() end
				if not sharedMediaFileCache[path] and not path:find("DBM") then
					--This uses debug print because it has potential to cause mid fight spam
					DBM:Debug("PlaySoundFile failed do to missing media at "..path..". To fix this, re-add missing sound or change setting using this sound to a different sound.")
					return
				end
				--Validate Event packs
				if not DBMVPSoundEventsPack and path:find("DBM-SoundEventsPack") then
					--This uses actual user print because these events only occure at start or end of instance or fight.
					AddMsg("PlaySoundFile failed do to missing media at "..path..". To fix this, re-add/enable DBM-SoundEventsPack or change setting using this sound to a different sound.")
					return
				end
				if not DBMVPSMGPack and path:find("DBM-SMGEventsPack") then
					--This uses actual user print because these events only occure at start or end of instance or fight.
					AddMsg("PlaySoundFile failed do to missing media at "..path..". To fix this, re-add/enable DBM-SMGEventsPack or change setting using this sound to a different sound.")
					return
				end
			end
			DBM:Debug("PlaySoundFile playing with media "..path, 3)
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
		if self.Options.SilentMode or path == "" or path == "None" then return end
		playSound(self, path, ignoreSFX, validate)
	end

	function DBM:PlaySound(path, ignoreSFX, validate)
		if self.Options.SilentMode then return end
		playSound(self, path, ignoreSFX, validate)
	end
end

--Future proofing EJ_GetSectionInfo compat layer to make it easier updatable.
function DBM:EJ_GetSectionInfo(sectionID)
	local info = EJ_GetSectionInfo(sectionID);
	local flag1, flag2, flag3, flag4;
	local flags = GetSectionIconFlags(sectionID);
	if flags then
		flag1, flag2, flag3, flag4 = unpack(flags);
	end
	return info.title, info.description, info.headerType, info.abilityIcon, info.creatureDisplayID, info.siblingSectionID, info.firstChildSectionID, info.filteredByDifficulty, info.link, info.startsOpen, flag1, flag2, flag3, flag4
end

--Handle new spell name requesting with wrapper, to make api changes easier to handle
function DBM:GetSpellInfo(spellId)
	local name, rank, icon, castingTime, minRange, maxRange, returnedSpellId  = GetSpellInfo(spellId)
	if not returnedSpellId then--Bad request all together
		DBM:Debug("|cffff0000Invalid call to GetSpellInfo for spellID: |r"..spellId)
		return nil
	else--Good request, return now
		return name, rank, icon, castingTime, minRange, maxRange, returnedSpellId
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
		self:AddMsg(DBM_CORE_AFK_WARNING:format(0))
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
		for i, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		tsort(sortMe, sort)
		self:Debug("RequestTimers Running", 2)
		local selectedClient
		local listNum = 0
		for i, v in ipairs(sortMe) do
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
			for i, v in ipairs(mod.timers) do
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
			if self.Bars:GetBar(DBM_CORE_TIMER_BREAK) then
				local remaining = self.Bars:GetBar(DBM_CORE_TIMER_BREAK).timer
				SendAddonMessage("D4", "BTR3\t"..remaining, "WHISPER", target)
			end
			return
		end
		local mod
		for i, v in ipairs(inCombat) do
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
		local mod
		--Acquire correct pvp mod for zone we are in
		if LastInstanceMapID == 529 or LastInstanceMapID == 1681 or LastInstanceMapID == 2107 or LastInstanceMapID == 2177 then--Arathi
			mod = self:GetModByName("z2107")
		elseif LastInstanceMapID == 30 or LastInstanceMapID == 2197 then--Alteract Valley
			mod = self:GetModByName("z30")
		elseif LastInstanceMapID == 566 or LastInstanceMapID == 968 then--Eye of the Storm
			mod = self:GetModByName("z566")
		else--Any other BG we can just use current MapID as mod ID
			mod = self:GetModByName("z"..tostring(LastInstanceMapID))
		end
		if mod then
			self:SendTimerInfo(mod, target)
		end
	end
end

function DBM:SendCombatInfo(mod, target)
	return SendAddonMessage("D4", ("CI\t%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), "WHISPER", target)
end

function DBM:SendTimerInfo(mod, target)
	for i, v in ipairs(mod.timers) do
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
		if not self.Options.DontShowReminders then
			C_TimerAfter(25, function() if self.Options.SilentMode then self:AddMsg(DBM_SILENT_REMINDER) end end)
			C_TimerAfter(30, function() if not self.Options.SettingsMessageShown then self.Options.SettingsMessageShown = true self:AddMsg(DBM_HOW_TO_USE_MOD) end end)
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
		if self.Options.sfxDisabled then
			self.Options.sfxDisabled = nil
			SetCVar("Sound_EnableSFX", 1)
			DBM:Debug("Restoring Sound_EnableSFX CVAR")
		end
		if self.Options.tempQuestCVar then
			SetCVar("showQuestTrackingTooltips", self.Options.tempQuestCVar)
			self.Options.tempQuestCVar = nil
			DBM:Debug("Restoring showQuestTrackingTooltips CVAR")
		end
		--tempMusicSetting doens't need restoring here, since zone change transition will handle it
		if self.Options.RestoreRange then self.Options.RestoreRange = nil end--User DCed while this was true, clear it
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
		local currentMapName = C_Map.GetMapInfo(currentMapId) or DBM_CORE_UNKNOWN
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
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if IsInScenarioGroup() and not mod.soloChallenge then return end--status not really useful on scenario mods since there is no way to report progress as a percent. We just ignore it.
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or DBM_CORE_UNKNOWN
			if mod.vb.phase then
				hpText = hpText.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			sendWhisper(sender, chatPrefix..DBM_CORE_STATUS_WHISPER:format(difficultyText..(mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
		elseif #inCombat > 0 and DBM.Options.AutoRespond then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				savedDifficulty, difficultyText, difficultyIndex, LastGroupSize, difficultyModifier = DBM:GetCurrentInstanceDifficulty()
			end
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
			local hpText = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or DBM_CORE_UNKNOWN
			if mod.vb.phase then
				hpText = hpText.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
			end
			if mod.numBoss and mod.vb.bossLeft and mod.numBoss > 1 then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			if not autoRespondSpam[sender] then
				if IsInScenarioGroup() and not mod.soloChallenge then
					sendWhisper(sender, chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO:format(playerName, difficultyText..(mod.combatInfo.name or ""), getNumAlivePlayers(), DBM:GetNumGroupMembers()))
				else
					sendWhisper(sender, chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER:format(playerName, difficultyText..(mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
				end
				DBM:AddMsg(DBM_CORE_AUTO_RESPONDED)
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
			if self.Options.HideQuestTooltips then
				self.Options.tempQuestCVar = tonumber(GetCVar("showQuestTrackingTooltips")) or 1
				if self.Options.tempQuestCVar == 1 then
					SetCVar("showQuestTrackingTooltips", 0)
				else
					self.Options.tempQuestCVar = nil--Don't actually need it
				end
			end
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
			if self.Options.tempQuestCVar then
				SetCVar("showQuestTrackingTooltips", self.Options.tempQuestCVar)
				self.Options.tempQuestCVar = nil
				DBM:Debug("Restoring Quest Tooltip CVAR")
			end
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
	local tag = prefix or (self.localization and self.localization.general.name) or "DBM"
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
	if not self.Options or not self.Options.DebugMode then return end
	if (level or 1) <= DBM.Options.DebugLevel then
		local frame = _G[tostring(DBM.Options.ChatFrame)]
		frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
		frame:AddMessage("|cffff7d0aDBM Debug:|r "..text, 1, 1, 1)
		fireEvent("DBM_Debug", text, level)
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
			testTimer3 = testMod:NewTimer(20, "%s  ", "136194", nil, nil, 3, DBM_CORE_MAGIC_ICON, nil, 1, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer4 = testMod:NewTimer(20, "%s   ", "136116", nil, nil, 4, DBM_CORE_INTERRUPT_ICON)
			testTimer5 = testMod:NewTimer(20, "%s    ", "135826", nil, nil, 2, DBM_CORE_HEALER_ICON, nil, 3, 4)--inlineIcon, keep, countdown, countdownMax
			testTimer6 = testMod:NewTimer(20, "%s     ", "136116", nil, nil, 5, DBM_CORE_TANK_ICON, nil, 2, 4)--inlineIcon, keep, countdown, countdownMax
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
		prefix = DBM_CORE_HORDE or FACTION_HORDE
	elseif bar.color and bar.color.r == 0 and bar.color.g == 0 and bar.color.b == 1 then
		prefix = DBM_CORE_ALLIANCE or FACTION_ALLIANCE
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
		self:AddMsg(DBM_CORE_LOOT_SPEC_REMINDER:format(_G[role] or DBM_CORE_UNKNOWN, _G[lootrole]))
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

function DBM:GetTOC()
	return wowTOC, testBuild, wowVersionString, wowBuild
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
		local instance2 = GetDungeonInfo(string.sub(i, 2))
		if instance then
			if not contains or contains and instance:find(contains) then
				self:AddMsg(i..": "..instance)
			end
		end
	end
end

--/run DBM:FindEncounterIDs(1028)--Azeroth
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
			DBM:Debug("PLAY_MOVIE fired for ID: "..id, 2)
			local isInstance, instanceType = IsInInstance()
			if not isInstance or C_Garrison:IsOnGarrisonMap() or instanceType == "scenario" or DBM.Options.MovieFilter2 == "Never" or DBM.Options.MovieFilter2 == "OnlyFight" and not IsEncounterInProgress() then return end
			if DBM.Options.MovieFilter2 == "Block" or (self.Options.MovieFilter2 == "AfterFirst" or self.Options.MovieFilter2 == "OnlyFight") and DBM.Options.MoviesSeen[id] then
				MovieFrame:Hide()--can only just hide movie frame safely now, which means can't stop audio anymore :\
				DBM:AddMsg(DBM_CORE_MOVIE_SKIPPED)
			else
				DBM.Options.MoviesSeen[id] = true
			end
		end
	end

	function DBM:CINEMATIC_START()
		self:Debug("CINEMATIC_START fired", 2)
		DBMHudMap:SupressCanvas()
		local isInstance, instanceType = IsInInstance()
		if not isInstance or C_Garrison:IsOnGarrisonMap() or instanceType == "scenario" or self.Options.MovieFilter2 == "Never" or DBM.Options.MovieFilter2 == "OnlyFight" and not IsEncounterInProgress() then return end
		local currentMapID = C_Map.GetBestMapForUnit("player")
		if not currentMapID then return end--Protection from map failures in zones that have no maps yet
		if self.Options.MovieFilter2 == "Block" or (self.Options.MovieFilter2 == "AfterFirst" or self.Options.MovieFilter2 == "OnlyFight") and self.Options.MoviesSeen[currentMapID] then
			CinematicFrame_CancelCinematic()
			self:AddMsg(DBM_CORE_MOVIE_SKIPPED)
		else
			self.Options.MoviesSeen[currentMapID] = true
		end
	end
	function DBM:CINEMATIC_STOP()
		self:Debug("CINEMATIC_STOP fired", 2)
		DBMHudMap:UnSupressCanvas()
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
		if name == "DBM-ProfilesDummy" then return end
		if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
				},
				DefaultOptions = {
					Enabled = true,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {"announce", "announceother", "announcepersonal", "announcerole", "timer", "sound", "yell", "nameplate", "icon", "misc"},
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
				localization = self:GetModLocalization(name)
			},
			mt
		)
		for i, v in ipairs(self.AddOns) do
			if v.modId == modId then
				obj.addon = v
				break
			end
		end

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
			local t = GetRealZoneText(string.sub(name, 2))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = string.split(",", t or name)
			end
			obj.localization.general.name = t or name
		elseif name:match("d%d+") then
			local t = GetDungeonInfo(string.sub(name, 2))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = string.split(",", t or name)
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
			for i, v in ipairs(self.addon.mapId) do
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
	for i, v in ipairs(self.timers) do
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
	startScheduler()
	if type(func) ~= "function" then return end
	self.elapsed = 0
	self.updateInterval = interval or 0
	updateFunctions[self] = func
end

function bossModPrototype:UnregisterOnUpdateHandler()
	self.elapsed = nil
	self.updateInterval = nil
	twipe(updateFunctions)
end

--------------
--  Events  --
--------------
function bossModPrototype:RegisterEventsInCombat(...)
	if self.inCombatOnlyEvents then
		geterrorhandler()("combat events already set")
	end
	self.inCombatOnlyEvents = {...}
	for k, v in pairs(self.inCombatOnlyEvents) do
		if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
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
	if diff == "lfr" or diff == "lfr25" then
		return true
	end
	return false
end

--Dungeons: normal, heroic. (Raids excluded)
function bossModPrototype:IsEasyDungeon()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "heroic5" or diff == "normal5" then
		return true
	end
	return false
end

--Dungeons: normal, heroic. Raids: LFR, normal
function bossModPrototype:IsEasy()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normal" or diff == "lfr" or diff == "lfr25" or diff == "heroic5" or diff == "normal5" then
		return true
	end
	return false
end

--Dungeons: mythic, mythic+. Raids: heroic, mythic
function bossModPrototype:IsHard()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "mythic" or diff == "challenge5" or diff == "heroic" then
		return true
	end
	return false
end

--Pretty much ANYTHING that has a normal mode
function bossModPrototype:IsNormal()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normal" or diff == "normal5" or diff == "normal10" or diff == "normal20" or diff == "normal25" or diff == "normal40" or diff == "normalisland" or diff == "normalwarfront" then
		return true
	end
	return false
end

--Pretty much ANYTHING that has a heroic mode
function bossModPrototype:IsHeroic()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "heroic" or diff == "heroic5" or diff == "heroic10" or diff == "heroic25" or diff == "heroicisland" or diff == "heroicwarfront" then
		return true
	end
	return false
end

--Pretty much ANYTHING that has mythic mode, with mythic+ included
function bossModPrototype:IsMythic()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "mythic" or diff == "challenge5" or diff == "mythicisland" then
		return true
	end
	return false
end

function bossModPrototype:IsEvent()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "event5" or diff == "event20" or diff == "event40" then
		return true
	end
	return false
end

function bossModPrototype:IsWarfront()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normalwarfront" or diff == "heroicwarfront" then
		return true
	end
	return false
end

function bossModPrototype:IsIsland()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normalisland" or diff == "heroicisland" or diff == "mythicisland" then
		return true
	end
	return false
end

function bossModPrototype:IsScenario()
	local diff = savedDifficulty or DBM:GetCurrentInstanceDifficulty()
	if diff == "normalscenario" or diff == "heroicscenario" then
		return true
	end
	return false
end

function bossModPrototype:IsTrivial(level)
	if difficultyIndex == 24 then return false end--Timewalker dungeon, ignore level and return false for trivial
	if playerLevel >= level then
		return true
	end
	return false
end

function bossModPrototype:IsValidWarning(sourceGUID, customunitID)
	if customunitID then
		if UnitExists(customunitID) and UnitGUID(customunitID) == sourceGUID and UnitAffectingCombat(customunitID) then return true end
	else
		for uId in DBM:GetGroupMembers() do
			local target = uId.."target"
			if UnitExists(target) and UnitGUID(target) == sourceGUID and UnitAffectingCombat(target) then return true end
			local targettwo = uId.."targettarget"
			if UnitExists(targettwo) and UnitGUID(targettwo) == sourceGUID and UnitAffectingCombat(targettwo) then return true end
		end
	end
	return false
end

--Skip param is used when CheckInterruptFilter is actually being used for a simpe target/focus check and nothing more.
--checkCooldown should never be passed with skip or COUNT interrupt warnings. It should be passed with any other interrupt filter
function bossModPrototype:CheckInterruptFilter(sourceGUID, force, checkCooldown, ignoreTandF)
	if DBM.Options.FilterInterrupt2 == "None" and not force then return true end--user doesn't want to use interrupt filter, always return true
	if DBM.Options.FilterInterrupt2 == "Always" and not force then return false end--user wants to filter ALL interrupts, always return false
	--Pummel, Mind Freeze, Counterspell, Kick, Skull Bash, Rebuke, Silence, Wind Shear, Disrupt, Solar Beam
	local InterruptAvailable = true
	local requireCooldown = checkCooldown
	if (DBM.Options.FilterInterrupt2 == "onlyTandF") or self.isTrashMod and (DBM.Options.FilterInterrupt2 == "TandFandBossCooldown") then
		requireCooldown = false
	end
	if requireCooldown and (UnitIsDeadOrGhost("player") or (GetSpellCooldown(6552)) ~= 0 or (GetSpellCooldown(47528)) ~= 0 or (GetSpellCooldown(282151)) ~= 0 or (GetSpellCooldown(2139)) ~= 0 or (GetSpellCooldown(1766)) ~= 0 or (GetSpellCooldown(106839)) ~= 0 or (GetSpellCooldown(96231)) ~= 0 or (GetSpellCooldown(15487)) ~= 0 or (GetSpellCooldown(57994)) ~= 0 or (GetSpellCooldown(183752)) ~= 0 or (GetSpellCooldown(78675)) ~= 0) then
		InterruptAvailable = false--checkCooldown check requested and player has no spell that can interrupt available (or is dead)
	end
	if InterruptAvailable and (ignoreTandF or UnitGUID("target") == sourceGUID or UnitGUID("focus") == sourceGUID) then
		return true
	end
	return false
end

function bossModPrototype:CheckDispelFilter()
	if not DBM.Options.FilterDispel then return true end
	--Druid: Nature's Cure (88423), Remove Corruption (2782), Monk: Detox (115450) Monk: Detox (218164), Priest: Purify (527) Priest: Purify Disease (213634), Paladin: Cleanse (4987), Shaman: Cleanse Spirit (51886), Purify Spirit (77130), Mage: Remove Curse (475), Warlock: Singe Magic (89808)
	--start, duration, enable = GetSpellCooldown
	--start & duration == 0 if spell not on cd
	if UnitIsDeadOrGhost("player") then return false end--if dead, can't dispel
	if (GetSpellCooldown(88423)) ~= 0 or (GetSpellCooldown(2782)) ~= 0 or (GetSpellCooldown(115450)) ~= 0 or (GetSpellCooldown(218164)) ~= 0 or (GetSpellCooldown(527)) ~= 0 or (GetSpellCooldown(213634)) ~= 0 or (GetSpellCooldown(4987)) ~= 0 or (GetSpellCooldown(51886)) ~= 0 or (GetSpellCooldown(77130)) ~= 0 or (GetSpellCooldown(475)) ~= 0 or (GetSpellCooldown(89808)) ~= 0 then
		return false
	end
	return true
end

function bossModPrototype:IsCriteriaCompleted(criteriaIDToCheck)
	if not criteriaIDToCheck then
		geterrorhandler()("usage: mod:IsCriteriaComplected(criteriaId)")
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
bossModPrototype.GetUnitIdFromGUID = DBM.GetUnitIdFromGUID
bossModPrototype.CheckNearby = DBM.CheckNearby

do
	local bossTargetuIds = {
		"boss1", "boss2", "boss3", "boss4", "boss5", "focus", "target"
	}
	local targetScanCount = {}
	local repeatedScanEnabled = {}

	local function getBossTarget(guid, scanOnlyBoss)
		local name, uid, bossuid
		local cacheuid = bossuIdCache[guid] or "boss1"
		if UnitGUID(cacheuid) == guid then
			bossuid = cacheuid
			name = DBM:GetUnitFullName(cacheuid.."target")
			uid = cacheuid.."target"
			bossuIdCache[guid] = bossuid
		end
		if name then return name, uid, bossuid end
		for i, uId in ipairs(bossTargetuIds) do
			if UnitGUID(uId) == guid then
				bossuid = uId
				name = DBM:GetUnitFullName(uId.."target")
				uid = uId.."target"
				bossuIdCache[guid] = bossuid
				break
			end
		end
		if name or scanOnlyBoss then return name, uid, bossuid end
		-- Now lets check nameplates
		for i = 1, 40 do
			if UnitGUID("nameplate"..i) == guid then
				bossuid = "nameplate"..i
				name = DBM:GetUnitFullName("nameplate"..i.."target")
				uid = "nameplate"..i.."target"
				bossuIdCache[guid] = bossuid
				break
			end
		end
		if name then return name, uid, bossuid end
		-- failed to detect from default uIds, scan all group members's target.
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if UnitGUID("raid"..i.."target") == guid then
					bossuid = "raid"..i.."target"
					name = DBM:GetUnitFullName("raid"..i.."targettarget")
					uid = "raid"..i.."targettarget"
					bossuIdCache[guid] = bossuid
					break
				end
			end
		elseif IsInGroup() then
			for i = 1, GetNumSubgroupMembers() do
				if UnitGUID("party"..i.."target") == guid then
					bossuid = "party"..i.."target"
					name = DBM:GetUnitFullName("party"..i.."targettarget")
					uid = "party"..i.."targettarget"
					bossuIdCache[guid] = bossuid
					break
				end
			end
		end
		return name, uid, bossuid
	end

	function bossModPrototype:GetBossTarget(cidOrGuid, scanOnlyBoss)
		local name, uid, bossuid
		if type(cidOrGuid) == "number" then
			local cidOrGuid = cidOrGuid or self.creatureId
			local cacheuid = bossuIdCache[cidOrGuid] or "boss1"
			if self:GetUnitCreatureId(cacheuid) == cidOrGuid then
				bossuIdCache[cidOrGuid] = cacheuid
				bossuIdCache[UnitGUID(cacheuid)] = cacheuid
				name, uid, bossuid = getBossTarget(UnitGUID(cacheuid), scanOnlyBoss)
			else
				local found = false
				for i, uId in ipairs(bossTargetuIds) do
					if self:GetUnitCreatureId(uId) == cidOrGuid then
						found = true
						bossuIdCache[cidOrGuid] = uId
						bossuIdCache[UnitGUID(uId)] = uId
						name, uid, bossuid = getBossTarget(UnitGUID(uId), scanOnlyBoss)
						break
					end
				end
				if not found and not scanOnlyBoss then
					if IsInRaid() then
						for i = 1, GetNumGroupMembers() do
							if self:GetUnitCreatureId("raid"..i.."target") == cidOrGuid then
								bossuIdCache[cidOrGuid] = "raid"..i.."target"
								bossuIdCache[UnitGUID("raid"..i.."target")] = "raid"..i.."target"
								name, uid, bossuid = getBossTarget(UnitGUID("raid"..i.."target"))
								break
							end
						end
					elseif IsInGroup() then
						for i = 1, GetNumSubgroupMembers() do
							if self:GetUnitCreatureId("party"..i.."target") == cidOrGuid then
								bossuIdCache[cidOrGuid] = "party"..i.."target"
								bossuIdCache[UnitGUID("party"..i.."target")] = "party"..i.."target"
								name, uid, bossuid = getBossTarget(UnitGUID("party"..i.."target"))
								break
							end
						end
					end
				end
			end
		else
			name, uid, bossuid = getBossTarget(cidOrGuid, scanOnlyBoss)
		end
		if uid then
			local cid = DBM:GetUnitCreatureId(uid)
			if cid == 24207 or cid == 80258 or cid == 87519 then--filter army of the dead/Garrison Footman (basically same thing as army)
				return nil, nil, nil
			end
		end
		return name, uid, bossuid
	end

	function bossModPrototype:BossTargetScannerAbort(cidOrGuid, returnFunc)
		targetScanCount[cidOrGuid] = nil--Reset count for later use.
		self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
		DBM:Debug("Boss target scan for "..cidOrGuid.." should be aborting.", 3)
	end

	function bossModPrototype:BossUnitTargetScannerAbort(uId)
		if not uId then--Not called with unit, means mod requested to clear all used units
			DBM:Debug("BossUnitTargetScannerAbort called without unit, clearing all targetMonitor units", 2)
			table.wipe(targetMonitor)
			return
		end
		if targetMonitor[uId] and targetMonitor[uId].allowTank and UnitExists(uId.."target") and UnitPlayerOrPetInRaid(uId.."target") then
			self:Debug("targetMonitor unit exists, allowTank target exists", 2)
			local modId, returnFunc = targetMonitor[uId].modid, targetMonitor[uId].returnFunc
			self:Debug("targetMonitor: "..modId..", "..uId..", "..returnFunc, 2)
			local mod = self:GetModByName(modId)
			self:Debug("targetMonitor found a target that probably is a tank", 2)
			mod[returnFunc](mod, self:GetUnitFullName(uId.."target"), uId.."target", uId)--Return results to warning function with all variables.
		end
		targetMonitor[uId] = nil
		DBM:Debug("Boss unit target scan should be aborting for "..uId, 3)
	end

	function bossModPrototype:BossUnitTargetScanner(uId, returnFunc, scanTime, allowTank)
		--UNIT_TARGET event monitor target scanner. Will instantly detect a target change of a registered Unit
		--If target change occurs before this method is called (or if boss doesn't change target because cast ends up actually being on the tank, target scan will fail completely
		--If allowTank is passed, it basically tells this scanner to return current target of unitId at time of failure/abort when scanTime is complete
		local scanDuration = scanTime or 1.5
		targetMonitor[uId] = {}
		targetMonitor[uId].modid, targetMonitor[uId].returnFunc, targetMonitor[uId].allowTank = self.id, returnFunc, allowTank
		self:ScheduleMethod(scanDuration, "BossUnitTargetScannerAbort", uId)--In case of BossUnitTargetScanner firing too late, and boss already having changed target before monitor started, it needs to abort after x seconds
	end

	function bossModPrototype:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, isFinalScan, targetFilter, tankFilter)
		--Increase scan count
		cidOrGuid = cidOrGuid or self.creatureId
		if not cidOrGuid then return end
		if not targetScanCount[cidOrGuid] then targetScanCount[cidOrGuid] = 0 end
		targetScanCount[cidOrGuid] = targetScanCount[cidOrGuid] + 1
		--Set default values
		scanInterval = scanInterval or 0.05
		scanTimes = scanTimes or 16
		local targetname, targetuid, bossuid = self:GetBossTarget(cidOrGuid, scanOnlyBoss)
		DBM:Debug("Boss target scan "..targetScanCount[cidOrGuid].." of "..scanTimes..", found target "..(targetname or "nil").." using "..(bossuid or "nil"), 3)--Doesn't hurt to keep this, as level 3
		--Do scan
		if targetname and targetname ~= DBM_CORE_UNKNOWN and (not targetFilter or (targetFilter and targetFilter ~= targetname)) then
			if not IsInGroup() then scanTimes = 1 end--Solo, no reason to keep scanning, give faster warning. But only if first scan is actually a valid target, which is why i have this check HERE
			if (isEnemyScan and UnitIsFriend("player", targetuid) or self:IsTanking(targetuid, bossuid)) and not isFinalScan then--On player scan, ignore tanks. On enemy scan, ignore friendly player.
				if targetScanCount[cidOrGuid] < scanTimes then--Make sure no infinite loop.
					self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter)--Scan multiple times to be sure it's not on something other then tank (or friend on enemy scan).
				else--Go final scan.
					self:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, true, targetFilter, tankFilter)
				end
			else--Scan success. (or failed to detect right target.) But some spells can be used on tanks, anyway warns tank if player scan. (enemy scan block it)
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
				if (tankFilter and self:IsTanking(targetuid, bossuid)) or (isFinalScan and isEnemyScan) then return end--If enemyScan and playerDetected, return nothing
				local scanningTime = (targetScanCount[cidOrGuid] or 1) * scanInterval
				self[returnFunc](self, targetname, targetuid, bossuid, scanningTime)--Return results to warning function with all variables.
			end
		else--target was nil, lets schedule a rescan here too.
			if targetScanCount[cidOrGuid] < scanTimes then--Make sure not to infinite loop here as well.
				self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter)
			else
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
			end
		end
	end

	--infinite scanner. so use this carefully.
	local function repeatedScanner(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, mod)
		if repeatedScanEnabled[returnFunc] then
			local cidOrGuid = cidOrGuid or mod.creatureId
			local scanInterval = scanInterval or 0.1
			local targetname, targetuid, bossuid = mod:GetBossTarget(cidOrGuid, scanOnlyBoss)
			if targetname and (includeTank or not mod:IsTanking(targetuid, bossuid)) then
				mod[returnFunc](mod, targetname, targetuid, bossuid)
			end
			DBM:Schedule(scanInterval, repeatedScanner, cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, mod)
		end
	end

	function bossModPrototype:StartRepeatedScan(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
		repeatedScanEnabled[returnFunc] = true
		repeatedScanner(cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank, self)
	end

	function bossModPrototype:StopRepeatedScan(returnFunc)
		repeatedScanEnabled[returnFunc] = nil
	end
end

do
	local bossCache = {}
	local lastTank = nil

	function bossModPrototype:GetCurrentTank(cidOrGuid)
		if lastTank and GetTime() - (bossCache[cidOrGuid] or 0) < 2 then -- return last tank within 2 seconds of call
			return lastTank
		else
			local cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for GetCurrentTank we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId..i
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
				return UnitName(lastTank), uId
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

	function bossModPrototype:CheckBossDistance(cidOrGuid, onlyBoss, itemId, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		cidOrGuid = cidOrGuid or self.creatureId
		local uId = DBM:GetUnitIdFromGUID(cidOrGuid, onlyBoss)
		if uId then
			local itemId = itemId or 32698
			local inRange = IsItemInRange(itemId, uId)
			if inRange then--IsItemInRange was a success
				return inRange
			else--IsItemInRange doesn't work on all bosses/npcs, but tank checks do
				DBM:Debug("CheckBossDistance failed on IsItemInRange for: "..cidOrGuid, 2)
				return self:CheckTankDistance(cidOrGuid, nil, onlyBoss, defaultReturn)--Return tank distance check fallback
			end
		end
		DBM:Debug("CheckBossDistance failed on uId for: "..cidOrGuid, 2)
		return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire
	end

	function bossModPrototype:CheckTankDistance(cidOrGuid, distance, onlyBoss, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		distance = distance or 43
		if rangeCache[cidOrGuid] and (GetTime() - (rangeUpdated[cidOrGuid] or 0)) < 2 then -- return same range within 2 sec call
			if rangeCache[cidOrGuid] > distance then
				return false
			else
				return true
			end
		else
			local cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid, onlyBoss)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for CheckTankDistance we want to know who is tanking it, not who it's targeting.
				local unitId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "target") or unitId..i
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
				local inRange = 0
				if not UnitIsPlayer(uId) then
					local inRange2, checkedRange = UnitInRange(uId)--43
					if checkedRange then--checkedRange only returns true if api worked, so if we get false, true then we are not near npc
						return inRange2 and true or false
					else--Its probably a totem or just something we can't assess. Fall back to no filtering
						return true
					end
				else
					inRange = DBM.RangeCheck:GetDistance("player", uId)--We check how far we are from the tank who has that boss
				end
				rangeCache[cidOrGuid] = inRange
				rangeUpdated[cidOrGuid] = GetTime()
				if inRange and (inRange > distance) then--You are not near the person tanking boss
					return false
				end
				--Tank in range, return true.
				return true
			end
			DBM:Debug("CheckTankDistance failed on uId for: "..cidOrGuid, 2)
			return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire. But some spells will prefer not to fire(i.e : Galakras tower spell), we can define it on this function calling.
		end
	end
end

---------------------
--  Class Methods  --
---------------------
do
	--[[local specFlags ={
		["Tank"] = true,
		["Dps"] = true,
		["Healer"] = true,
		["Melee"] = true,--ANY melee, including tanks or healers that are 100% excempt from healer/ranged mechanics (like mistweaver monks)
		["MeleeDps"] = true,
		["Physical"] = true,
		["Ranged"] = true,--ANY ranged, healer and dps included
		["RangedDps"] = true,--Only ranged dps
		["ManaUser"] = true,--Affected by things like mana drains, or mana detonation, etc
		["SpellCaster"] = true,--Has channeled casts, can be interrupted/spell locked by roars, etc, include healers. Use CasterDps if dealing with reflect
		["CasterDps"] = true,--Ranged dps that uses spells, relevant for spell reflect type abilities that only reflect spells but not ranged physical such as hunters
		["RaidCooldown"] = true,
		["RemovePoison"] = true,--from ally
		["RemoveDisease"] = true,--from ally
		["RemoveEnrage"] = true,--Can remove enemy enrage. returned in 8.x!
		["RemoveCurse"] = true,--from ally
		["RemoveMagic"] = true,--from ally
		["MagicDispeller"] = true,--from ENEMY, not debuffs on players. use "Healer" or "RemoveMagic" for ally magic dispels. ALL healers can do that on retail, and warlock Imps
		["HasInterrupt"] = true,--Has an interrupt that is 24 seconds or less CD that is BASELINE (not a talent)
		["HasImmunity"] = true,--Has an immunity that can prevent or remove a spell effect (not just one that reduces damage like turtle or dispursion)
	}]]

	local specRoleTable = {
		[62] = {	--Arcane Mage
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
			["RemoveCurse"] = true,
		},
		[65] = {	--Holy Paladin
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Devotion Aura
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
			["HasImmunity"] = true,
		},
		[66] = {	--Protection Paladin
			["Tank"] = true,
			["Melee"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
		},
		[70] = {	--Retribution Paladin
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
		},
		[71] = {	--Arms Warrior
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["RaidCooldown"] = true,--Rallying Cry
			["Physical"] = true,
			["HasInterrupt"] = true,
		},
		[73] = {	--Protection Warrior
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RaidCooldown"] = true,--Rallying Cry (in 8.x)
		},
		[102] = {	--Balance Druid
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["RemoveEnrage"] = true,
		},
		[103] = {	--Feral Druid
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[104] = {	--Guardian Druid
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[105] = {	-- Restoration Druid
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Tranquility
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["RemoveEnrage"] = true,
			["RemoveMagic"] = true,
		},
		[250] = {	--Blood DK
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
		},
		[251] = {	--Frost DK
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
		},
		[253] = {	--Beastmaster Hunter
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[254] = {	--Markmanship Hunter Hunter
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
		},
		[255] = {	--Survival Hunter (Legion+)
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RemoveEnrage"] = true,
		},
		[256] = {	--Discipline Priest
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,--Iffy. Technically yes, but this can't be used to determine eligable target for dps only debuffs
			["RaidCooldown"] = true,--Power Word: Barrier(Discipline) / Divine Hymn (Holy)
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
			["MagicDispeller"] = true,
		},
		[258] = {	--Shadow Priest
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
			["RemoveDisease"] = true,
		},
		[259] = {	--Assassination Rogue
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
		},
		[262] = {	--Elemental Shaman
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["RemoveCurse"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[263] = {	--Enhancement Shaman
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[264] = {	--Restoration Shaman
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Spirit Link Totem
			["RemoveCurse"] = true,
			["RemoveMagic"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[265] = {	--Affliction Warlock
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RemoveMagic"] = true,--Singe Magic (Imp)
			["CasterDps"] = true,
		},
		[268] = {	--Brewmaster Monk
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
		},
		[269] = {	--Windwalker Monk
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasInterrupt"] = true,
		},
		[270] = {	--Mistweaver Monk
			["Healer"] = true,
			["Melee"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Revival
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
		},
		[577] = {	--Havok Demon Hunter
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["MagicDispeller"] = true,
		},
		[581] = {	--Vengeance Demon Hunter
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["MagicDispeller"] = true,
		},
	}
	specRoleTable[63] = specRoleTable[62]--Frost Mage same as arcane
	specRoleTable[64] = specRoleTable[62]--Fire Mage same as arcane
	specRoleTable[72] = specRoleTable[71]--Fury Warrior same as Arms
	specRoleTable[252] = specRoleTable[251]--Unholy DK same as frost
	specRoleTable[257] = specRoleTable[256]--Holy Priest same as disc
	specRoleTable[260] = specRoleTable[259]--Combat Rogue same as Assassination
	specRoleTable[261] = specRoleTable[259]--Subtlety Rogue same as Assassination
	specRoleTable[266] = specRoleTable[265]--Demonology Warlock same as Affliction
	specRoleTable[267] = specRoleTable[265]--Destruction Warlock same as Affliction

	--[[function bossModPrototype:GetRoleFlagValue(flag)
		if not flag then return false end
		local flags = {strsplit("|", flag)}
		for i = 1, #flags do
			local flagText = flags[i]
			flagText = flagText:gsub("-", "")
			if not specFlags[flagText] then
				print("bad flag found : "..flagText)
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
				if not specRoleTable[currentSpecID][flagText] then
					return true
				end
			else
				if specRoleTable[currentSpecID][flagText] then
					return true
				end
			end
		end
		return false
	end

	function bossModPrototype:IsMeleeDps(uId)
		if uId then--This version includes ONLY melee dps
			local role = UnitGroupRolesAssigned(uId)
			if role == "HEALER" or role == "TANK" then--Auto filter healer from dps check
				return false
			end
			local _, class = UnitClass(uId)
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" then
				return true
			end
			--Inspect throttle exists, so have to do it this way
			if class == "DRUID" or class == "SHAMAN" or class == "PALADIN" or class == "MONK" or class == "HUNTER" then
				local unitMaxPower = UnitPowerMax(uId)
				--Mark and beast have 120 base focus, survival has 100 base focus. Not sure if this is best way to do it or if it breaks with talent/artifact weapon
				--Elemental shaman have 100 unit power base, while enhancement have 150 power base, so a shaman with > 150 but less tha 35000 is the melee one
				if (unitMaxPower < 101 and class == "HUNTER") or (unitMaxPower >= 150 and class == "SHAMAN" and unitMaxPower < 35000) or unitMaxPower < 35000 then
					return true
				end
			end
			return false
		end
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[currentSpecID]["MeleeDps"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsMelee(uId)
		if uId then--This version includes monk healers as melee and tanks as melee
			local _, class = UnitClass(uId)
			if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" or class == "MONK" then
				return true
			end
			--Inspect throttle exists, so have to do it this way
			if class == "DRUID" or class == "SHAMAN" or class == "PALADIN" then
				if UnitPowerMax(uId) < 35000 then
					return true
				end
			end
			return false
		end
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[currentSpecID]["Melee"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsRanged()
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[currentSpecID]["Ranged"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsSpellCaster()
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[currentSpecID]["SpellCaster"] then
			return true
		else
			return false
		end
	end

	function bossModPrototype:IsMagicDispeller()
		if not currentSpecID then
			DBM:SetCurrentSpecInfo()
		end
		if specRoleTable[currentSpecID]["MagicDispeller"] then
			return true
		else
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

function bossModPrototype:IsTank()
	--IsTanking already handles external calls, no need here.
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	if role == "TANK" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsDps(uId)
	if uId then--External unit call.
		if UnitGroupRolesAssigned(uId) == "DAMAGER" then
			return true
		end
		return false
	end
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	if role == "DAMAGER" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsHealer(uId)
	if uId then--External unit call.
		if UnitGroupRolesAssigned(uId) == "HEALER" then
			return true
		end
		return false
	end
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	if role == "HEALER" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsTanking(unit, boss, isName, onlyRequested)
	if isName then--Passed combat log name, so pull unit ID
		unit = DBM:GetRaidUnitId(unit)
	end
	if not unit then
		DBM:Debug("IsTanking passed with invalid unit", 2)
		return false
	end
	--Prefer threat target first
	if boss then--Only checking one bossID as requested
		local tanking, status = UnitDetailedThreatSituation(unit, boss)
		if tanking or (status == 3) then
			return true
		end
	else--Check all of them if one isn't defined
		for i = 1, 5 do
			--if UnitExists("boss"..i) then
				local tanking, status = UnitDetailedThreatSituation(unit, "boss"..i)
				if tanking or (status == 3) then
					return true
				end
			--end
		end
	end
	if not onlyRequested then
		--Use these as fallback if threat target not found
		if GetPartyAssignment("MAINTANK", unit, 1) then
			return true
		end
		if UnitGroupRolesAssigned(unit) == "TANK" then
			return true
		end
	end
	return false
end

function bossModPrototype:GetNumAliveTanks()
	if not IsInGroup() then return 1 end--Solo raid, you're the "tank"
	local count = 0
	local uId = (IsInRaid() and "raid") or "party"
	for i = 1, DBM:GetNumRealGroupMembers() do
		if UnitGroupRolesAssigned(uId..i) == "TANK" and not UnitIsDeadOrGhost(uId..i) then
			count = count + 1
		end
	end
	return count
end

----------------------------
--  Boss Health Function  --
----------------------------
function DBM:GetBossHP(cIdOrGUID)
	local uId = bossHealthuIdCache[cIdOrGUID] or "target"
	local guid = UnitGUID(uId)
	--Target or Cached (if already called with this cid or GUID before)
	if (self:GetCIDFromGUID(guid) == cIdOrGUID or guid == cIdOrGUID) and UnitHealthMax(uId) ~= 0 then
		if bossHealth[cIdOrGUID] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return bossHealth[cIdOrGUID], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[cIdOrGUID] = hp
		return hp, uId, UnitName(uId)
	--Focus
	elseif (self:GetCIDFromGUID(UnitGUID("focus")) == cIdOrGUID or UnitGUID("focus") == cIdOrGUID) and UnitHealthMax("focus") ~= 0 then
		if bossHealth[cIdOrGUID] and (UnitHealth("focus") == 0  and not UnitIsDead("focus")) then return bossHealth[cIdOrGUID], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		bossHealth[cIdOrGUID] = hp
		return hp, "focus", UnitName("focus")
	else
		--Boss UnitIds
		for i = 1, 5 do
			local unitID = "boss"..i
			local bossguid = UnitGUID(unitID)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitID) ~= 0 then
				if bossHealth[cIdOrGUID] and (UnitHealth(unitID) == 0 and not UnitIsDead(unitID)) then return bossHealth[cIdOrGUID], unitID, UnitName(unitID) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitID) / UnitHealthMax(unitID) * 100
				bossHealth[cIdOrGUID] = hp
				bossHealthuIdCache[cIdOrGUID] = unitID
				return hp, unitID, UnitName(unitID)
			end
		end
		--Scan raid/party target frames
		local idType = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local bossguid = UnitGUID(unitId)
			if (self:GetCIDFromGUID(bossguid) == cIdOrGUID or bossguid == cIdOrGUID) and UnitHealthMax(unitId) ~= 0 then
				if bossHealth[cIdOrGUID] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[cIdOrGUID], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				bossHealth[cIdOrGUID] = hp
				bossHealthuIdCache[cIdOrGUID] = unitId
				return hp, unitId, UnitName(unitId)
			end
		end
	end
	return nil
end

function DBM:GetBossHPByUnitID(uId)
	if UnitHealthMax(uId) ~= 0 then
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[uId] = hp
		return hp, uId, UnitName(uId)
	end
	return nil
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

-----------------------
--  Announce Object  --
-----------------------
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
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
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
			font1:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
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
			font2:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
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
			font3:SetTextHeight(origSize * (1.5 - (diff-0.2) * 2.5))
		else
			font3:SetTextHeight(origSize * (1 + diff * 2.5))
		end
	end)

	function DBM:UpdateWarningOptions()
		frame:ClearAllPoints()
		frame:SetPoint(self.Options.WarningPoint, UIParent, self.Options.WarningPoint, self.Options.WarningX, self.Options.WarningY)
		font1:SetFont(self.Options.WarningFont, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font2:SetFont(self.Options.WarningFont, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
		font3:SetFont(self.Options.WarningFont, self.Options.WarningFontSize, self.Options.WarningFontStyle == "None" and nil or self.Options.WarningFontStyle)
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
			self.Bars:CancelBar(DBM_CORE_MOVE_WARNING_BAR)
		end

		function DBM:MoveWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-GUI\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					self.Bars:CancelBar(DBM_CORE_MOVE_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.WarningPoint = point
					self.Options.WarningX = xOfs
					self.Options.WarningY = yOfs
					self:Schedule(15, moveEnd, self)
					self.Bars:CreateBar(15, DBM_CORE_MOVE_WARNING_BAR)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				anchorFrame:Show()
				anchorFrame.ticker = anchorFrame.ticker or C_TimerNewTicker(5, function() self:AddWarning(DBM_CORE_MOVE_WARNING_MESSAGE) end)
				self:AddWarning(DBM_CORE_MOVE_WARNING_MESSAGE)
				self:Schedule(15, moveEnd, self)
				self.Bars:CreateBar(15, DBM_CORE_MOVE_WARNING_BAR)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local textureCode = " |T%s:12:12|t "
	local textureExp = " |T(%S+......%S+):12:12|t "--Fix texture file including blank not strips(example: Interface\\Icons\\Spell_Frost_Ring of Frost). But this have limitations. Since I'm poor at regular expressions, this is not good fix. Do you have another good regular expression, tandanu?
	local announcePrototype = {}
	local mt = {__index = announcePrototype}

	-- TODO: is there a good reason that this is a weak table?
	local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

	local function setText(announceType, spellId, castTime, preWarnTime)
		local spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellId = string.sub(spellId, 3)
			spellName = DBM:EJ_GetSectionInfo(spellId) or DBM_CORE_UNKNOWN
		else
			spellName = DBM:GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		end
		local text
		if announceType == "cast" then
			local spellHaste = select(4, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			local timer = (select(4, DBM:GetSpellInfo(spellId)) or 1000) / spellHaste
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(tostring(preWarnTime or 5)))
			end
		elseif announceType == "stage" or announceType == "prestage" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
		elseif announceType == "stagechange" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell
		else
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		return text, spellName
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
					combinedText = combinedText.." "..DBM_CORE_GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText.." "..DBM_CORE_GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
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
						if DBM.Options.StripServerName then
							cap = Ambiguate(cap, "short")
						end
						local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)] or color
						if playerColor then
							cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
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
			if self.sound > 0 then
				if self.sound > 1 and DBM.Options.ChosenVoicePack ~= "None" and not voiceSessionDisabled and self.sound <= SWFilterDisabed then return end
				if not self.option or self.mod.Options[self.option.."SWSound"] ~= "None" then
					DBM:PlaySoundFile(DBM.Options.RaidWarningSound, nil, true)--Validate true
				end
			end
			--Message: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: you, target, targetsource, spell, ends, endtarget, fades, adds, count, stack, cast, soon, sooncount, prewarn, bait, stage, stagechange, prestage, moveto
			------Personal/Role (Applies to you, or your job): you, stack, bait, moveto, fades
			------General Target Messages (informative, doesn't usually apply to you): target, targetsource
			------Fight Changes (Stages, adds, boss buff/debuff, etc): stage, stagechange, prestage, adds, ends, endtarget
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority).
			fireEvent("DBM_Announce", message, self.icon, self.type, self.spellId, self.mod.id, false)
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function announcePrototype:CombinedShow(delay, ...)
		if self.option and not self.mod.Options[self.option] then return end
		if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter then return end--don't show announces that are generic target announces
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 8 then--Throttle spam. We may not need more than 9 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		unschedule(self.Show, self.mod, self)
		schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Countdown(time, numAnnounces, ...)
		scheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	function announcePrototype:Play(name, customPath)
		local voice = DBM.Options.ChosenVoicePack
		if voiceSessionDisabled or voice == "None" then return end
		local always = DBM.Options.AlwaysPlayVoice
		if DBM.Options.DontShowTargetAnnouncements and (self.announceType == "target" or self.announceType == "targetcount") and not self.noFilter and not always then return end--don't show announces that are generic target announces
		if (not DBM.Options.DontShowBossAnnounces and (not self.option or self.mod.Options[self.option]) or always) and self.sound <= SWFilterDisabed then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			local path = customPath or "Interface\\AddOns\\DBM-VP"..voice.."\\"..name..".ogg"
			DBM:PlaySoundFile(path)
		end
	end

	function announcePrototype:ScheduleVoice(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function announcePrototype:ScheduleVoiceOverLap(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function announcePrototype:CancelVoice(...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return unschedule(self.Play, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName, soundOption)
		if not text then
			error("NewAnnounce: you must provide announce text", 2)
			return
		end
		if type(optionName) == "number" then
			DBM:Debug("Non auto localized optionNames cannot be numbers, fix this for "..text)
			optionName = nil
		end
		if soundOption and type(soundOption) == "boolean" then
			soundOption = 0--No Sound
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				sound = soundOption or 1,
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or tonumber(icon) or 136116,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = text
			self:AddBoolOption(obj.option, optionDefault, "announce")
		end
		tinsert(self.announces, obj)
		return obj
	end

	-- new constructor (partially auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		if not spellId then
			error("newAnnounce: you must provide spellId", 2)
			return
		end
		local optionVersion, alternateSpellId
		if type(optionName) == "number" then
			if optionName > 1000 then--Being used as spell name shortening
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
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			print("newAnnounce for "..color.." is using OptionVersion hack. this is depricated")
			return
		end
		local text, spellName = setText(announceType, alternateSpellId or spellId, castTime, preWarnTime)
		icon = icon or spellId
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or tonumber(icon) or 136116,
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
		--Change if Personal or Other
		if announceType == "target" or announceType == "targetcount" or announceType == "stack" then
			catType = "announceother"
		end
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, catType)
		elseif not (optionName == false) then
			obj.option = catType..spellId..announceType..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, catType)
			self.localization.options[obj.option] = DBM_CORE_AUTO_ANNOUNCE_OPTIONS[announceType]:format(spellId)
		end
		tinsert(self.announces, obj)
		return obj
	end

	function bossModPrototype:NewYouAnnounce(spellId, color, ...)
		return newAnnounce(self, "you", spellId, color or 1, ...)
	end

	function bossModPrototype:NewTargetNoFilterAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		return newAnnounce(self, "target", spellId, color or 3, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, true)
	end

	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetSourceAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetsource", spellId, color or 3, ...)
	end

	function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcount", spellId, color or 3, ...)
	end

	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 2, ...)
	end

	function bossModPrototype:NewEndAnnounce(spellId, color, ...)
		return newAnnounce(self, "ends", spellId, color or 2, ...)
	end

	function bossModPrototype:NewEndTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "endtarget", spellId, color or 2, ...)
	end

	function bossModPrototype:NewFadesAnnounce(spellId, color, ...)
		return newAnnounce(self, "fades", spellId, color or 2, ...)
	end

	function bossModPrototype:NewAddsLeftAnnounce(spellId, color, ...)
		return newAnnounce(self, "adds", spellId, color or 3, ...)
	end

	function bossModPrototype:NewCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "count", spellId, color or 2, ...)
	end

	function bossModPrototype:NewStackAnnounce(spellId, color, ...)
		return newAnnounce(self, "stack", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName, noArg, soundOption)
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime, nil, soundOption)
	end

	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 2, ...)
	end

	function bossModPrototype:NewSoonCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "sooncount", spellId, color or 2, ...)
	end

	--This object disables sounds, it's almost always used in combation with a countdown timer. Even if not a countdown, its a text only spam not a sound spam
	function bossModPrototype:NewCountdownAnnounce(spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, soundOption, noFilter)
		return newAnnounce(self, "countdown", spellId, color or 4, icon, optionDefault, optionName, castTime, preWarnTime, 0, noFilter)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName, noArg, soundOption)
		return newAnnounce(self, "prewarn", spellId, color or 2, icon, optionDefault, optionName, nil, time, soundOption)
	end

	function bossModPrototype:NewBaitAnnounce(spellId, color, ...)
		return newAnnounce(self, "bait", spellId, color or 3, ...)
	end

	function bossModPrototype:NewPhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "stage", stage, color or 2, icon or "136116", ...)
	end

	function bossModPrototype:NewPhaseChangeAnnounce(color, icon, ...)
		return newAnnounce(self, "stagechange", 0, color or 2, icon or "136116", ...)
	end

	function bossModPrototype:NewPrePhaseAnnounce(stage, color, icon, ...)
		return newAnnounce(self, "prestage", stage, color or 2, icon or "136116", ...)
	end

	function bossModPrototype:NewMoveToAnnounce(spellId, color, ...)
		return newAnnounce(self, "moveto", spellId, color or 3, ...)
	end
end

--------------------
--  Yell Object  --
--------------------
do
	local voidForm = GetSpellInfo(194249)
	local yellPrototype = {}
	local mt = { __index = yellPrototype }
	local function newYell(self, yellType, spellId, yellText, optionDefault, optionName, chatType)
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			print("newYell for: "..yellText.." is using OptionVersion hack. This is depricated")
			return
		end
		local optionVersion
		if type(optionName) == "number" then
			optionVersion = optionName
			optionName = nil
		end
		local displayText
		if not yellText then
			if type(spellId) == "string" and spellId:match("ej%d+") then
				displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:EJ_GetSectionInfo(string.sub(spellId, 3)) or DBM_CORE_UNKNOWN)
			else
				displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(spellId) or DBM_CORE_UNKNOWN)
			end
		end
		--Passed spellid as yellText.
		--Auto localize spelltext using yellText instead
		if yellText and type(yellText) == "number" then
			displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT[yellType]:format(DBM:GetSpellInfo(yellText) or DBM_CORE_UNKNOWN)
		end
		local obj = setmetatable(
			{
				text = displayText or yellText,
				mod = self,
				chatType = chatType,
				yellType = yellType
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "yell")
		elseif not (optionName == false) then
			obj.option = "Yell"..(spellId or yellText)..(yellType ~= "yell" and yellType or "")..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "yell")
			self.localization.options[obj.option] = DBM_CORE_AUTO_YELL_OPTION_TEXT[yellType]:format(spellId)
		end
		return obj
	end

	function yellPrototype:Yell(...)
		if not IsInInstance() then--as of 8.2.5, forbidden in outdoor world
			DBM:Debug("WARNING: A mod is still trying to call chat SAY/YELL messages outdoors, FIXME")
			return
		end
		if DBM.Options.DontSendYells or self.yellType and self.yellType == "position" and DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay then return end
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
		if not IsInInstance() then--as of 8.2.5, forbidden in outdoor world
			DBM:Debug("WARNING: A mod is still trying to call chat SAY/YELL messages outdoors, FIXME")
			return
		end
		if DBM.Options.DontSendYells or self.yellType and self.yellType == "position" and DBM:UnitBuff("player", voidForm) and DBM.Options.FilterVoidFormSay then return end
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(pformat(self.text, ...), "SAY")
		end
	end

	function yellPrototype:Schedule(t, ...)
		return schedule(t, self.Yell, self.mod, self, ...)
	end

	function yellPrototype:Countdown(time, numAnnounces, ...)
		if time > 60 then--It's a spellID not a time
			local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", time)
			if expireTime then
				local remaining = expireTime-GetTime()
				scheduleCountdown(remaining, numAnnounces, self.Yell, self.mod, self, ...)
			end
		else
			scheduleCountdown(time, numAnnounces, self.Yell, self.mod, self, ...)
		end
	end

	function yellPrototype:Cancel(...)
		return unschedule(self.Yell, self.mod, self, ...)
	end

	function bossModPrototype:NewYell(...)
		return newYell(self, "yell", ...)
	end

	function bossModPrototype:NewShortYell(...)
		return newYell(self, "shortyell", ...)
	end

	function bossModPrototype:NewCountYell(...)
		return newYell(self, "count", ...)
	end

	function bossModPrototype:NewFadesYell(...)
		return newYell(self, "fade", ...)
	end

	function bossModPrototype:NewShortFadesYell(...)
		return newYell(self, "shortfade", ...)
	end

	function bossModPrototype:NewIconFadesYell(...)
		return newYell(self, "iconfade", ...)
	end

	function bossModPrototype:NewPosYell(...)
		return newYell(self, "position", ...)
	end

	function bossModPrototype:NewComboYell(...)
		return newYell(self, "combo", ...)
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
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
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
		frame:SetPoint(self.Options.SpecialWarningPoint, UIParent, self.Options.SpecialWarningPoint, self.Options.SpecialWarningX, self.Options.SpecialWarningY)
		font1:SetFont(self.Options.SpecialWarningFont, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font2:SetFont(self.Options.SpecialWarningFont, self.Options.SpecialWarningFontSize2, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
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
			self.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
		end

		function DBM:MoveSpecialWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("TOP", frame, "TOP", 0, 32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-GUI\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					self.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					self.Options.SpecialWarningPoint = point
					self.Options.SpecialWarningX = xOfs
					self.Options.SpecialWarningY = yOfs
					self:Schedule(15, moveEnd, self)
					self.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd(self)
			else
				moving = true
				anchorFrame:Show()
				DBM:AddSpecialWarning(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
				DBM:AddSpecialWarning(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
				self:Schedule(15, moveEnd, self)
				self.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	local function classColoringFunction(cap)
		cap = cap:sub(2, -2)
		local noStrip = cap:match("noStrip ")
		if not noStrip then
			local name = cap
			if DBM.Options.StripServerName then
				cap = Ambiguate(cap, "short")
			end
			if DBM.Options.SWarnClassColor then
				local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)]
				if playerColor then
					cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
				end
			end
		else
			cap = cap:sub(9)
		end
		return cap
	end

	local textureCode = " |T%s:12:12|t "

	local function setText(announceType, spellId, stacks)
		local text, spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellName = DBM:EJ_GetSectionInfo(string.sub(spellId, 3)) or DBM_CORE_UNKNOWN
		else
			spellName = DBM:GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		end
		if announceType == "prewarn" then
			if type(stacks) == "string" then
				text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, stacks)
			else
				text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(tostring(stacks or 5)))
			end
		else
			text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
		end
		return text, spellName
	end

	function specialWarningPrototype:Show(...)
		if not DBM.Options.DontShowSpecialWarnings and not DBM.Options.DontShowSpecialWarningText and (not self.option or self.mod.Options[self.option]) and not moving and frame then
			if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
			if self.announceType == "taunt" and DBM.Options.FilterTankSpec and not self.mod:IsTank() then return end--Don't tell non tanks to taunt, ever.
			local argTable = {...}
			-- add a default parameter for move away warnings
			if self.announceType == "gtfo" then
				if DBM:UnitBuff("player", 27827) then return end--Don't tell a priest in spirit of redemption form to GTFO, they can't, and they don't take damage from it anyhow
				if #argTable == 0 then
					argTable[1] = DBM_CORE_BAD
				end
			end
			if #self.combinedtext > 0 then
				--Throttle spam.
				if DBM.Options.SWarningAlphabetical then
					tsort(self.combinedtext)
				end
				local combinedText = tconcat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					combinedText = combinedText.." "..DBM_CORE_GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					combinedText = combinedText.." "..DBM_CORE_GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				--Process
				for i = 1, #argTable do
					if type(argTable[i]) == "string" then
						argTable[i] = combinedText
					end
				end
			end
			local message = pformat(self.text, unpack(argTable))
			local text = ("%s%s%s"):format(
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or "",
				message,
				(DBM.Options.SpecialWarningIcon and self.icon and textureCode:format(self.icon)) or ""
			)
			local noteHasName = false
			if self.option then
				local noteText = self.mod.Options[self.option .. "SWNote"]
				if noteText and type(noteText) == "string" and noteText ~= "" then--Filter false bool and empty strings
					local count1 = self.announceType == "count" or self.announceType == "switchcount" or self.announceType == "targetcount"
					local count2 = self.announceType == "interruptcount"
					if count1 or count2 then--Counts support different note for EACH count
						local noteCount
						local notesTable = {string.split("/", noteText)}
						if count1 then
							noteCount = argTable[1]--Count should be first arg in table
						elseif count2 then
							noteCount = argTable[2]--Count should be second arg in table
						end
						if type(noteCount) == "string" then
							--Probably a hypehnated double count like inferno slice or marked for death
							local mainCount = string.split("-", noteCount)
							noteCount = tonumber(mainCount)
						end
						noteText = notesTable[noteCount]
						if noteText and type(noteText) == "string" and noteText ~= "" then--Refilter after string split to make sure a note for this count exists
							local hasPlayerName = noteText:find(playerName)
							if DBM.Options.SWarnNameInNote and hasPlayerName then
								noteHasName = 5
							end
							--Terminate special warning, it's an interrupt count warning without player name and filter enabled
							if count2 and DBM.Options.FilterInterruptNoteName and not hasPlayerName then return end
							noteText = " ("..noteText..")"
							text = text..noteText
						end
					else--Non count warnings will have one note, period
						if DBM.Options.SWarnNameInNote and noteText:find(playerName) then
							noteHasName = 5
						end
						if self.announceType and self.announceType:find("switch") then
							noteText = noteText:gsub(">.-<", classColoringFunction)--Class color note text before combining with warning text.
						end
						noteText = " ("..noteText..")"
						text = text..noteText
					end
				end
			end
			--No stripping on switch warnings, ever. They will NEVER have player name, but often have adds with "-" in name
			if self.announceType and not self.announceType:find("switch") then
				text = text:gsub(">.-<", classColoringFunction)
			end
			DBM:AddSpecialWarning(text)
			self.combinedcount = 0
			self.combinedtext = {}
			if DBM.Options.ShowSWarningsInChat then
				local colorCode = ("|cff%.2x%.2x%.2x"):format(DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
				self.mod:AddMsg(colorCode.."["..DBM_CORE_MOVE_SPECIAL_WARNING_TEXT.."] "..text.."|r", nil)
			end
			if not UnitIsDeadOrGhost("player") then
				if noteHasName then
					if DBM.Options.SpecialWarningFlash5 then--Not included in above if statement on purpose. we don't want to trigger else rule if noteHasName is true but SpecialWarningFlash5 is false
						local repeatCount = DBM.Options.SpecialWarningFlashCount5 or 1
						DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol5[1],DBM.Options.SpecialWarningFlashCol5[2], DBM.Options.SpecialWarningFlashCol5[3], DBM.Options.SpecialWarningFlashDura5, DBM.Options.SpecialWarningFlashAlph5, repeatCount-1)
					end
				else
					local number = self.flash
					if DBM.Options["SpecialWarningFlash"..number] then
						local repeatCount = DBM.Options["SpecialWarningFlashCount"..number] or 1
						local flashcolor = DBM.Options["SpecialWarningFlashCol"..number]
						DBM.Flash:Show(flashcolor[1], flashcolor[2], flashcolor[3], DBM.Options["SpecialWarningFlashDura"..number], DBM.Options["SpecialWarningFlashAlph"..number], repeatCount-1)
					end
				end
			end
			--Text: Full message text
			--Icon: Texture path/id for icon
			--Type: Announce type
			----Types: spell, ends, fades, soon, bait, dispel, interrupt, interruptcount, you, youcount, youpos, soakpos, target, targetcount, defensive, taunt, close, move, keepmove, stopmove,
			----gtfo, dodge, dodgecount, dodgeloc, moveaway, moveawaycount, moveto, soak, jump, run, cast, lookaway, reflect, count, sooncount, stack, switch, switchcount, adds, addscustom, targetchange, prewarn
			------General Target Messages (but since it's a special warning, it applies to you in some way): target, targetcount
			------Fight Changes (Stages, adds, boss buff/debuff, etc): adds, addscustom, targetchange, switch, switchcount, ends
			------General (can really apply to anything): spell, count, soon, sooncount, prewarn
			------Personal/Role (Applies to you, or your job): Everything Else
			--SpellId: Raw spell or encounter journal Id if available.
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--boolean: Whether or not this warning is a special warning (higher priority).
			fireEvent("DBM_Announce", text, self.icon, self.type, self.spellId, self.mod.id, true)
			if self.sound then
				local soundId = self.option and self.mod.Options[self.option .. "SWSound"] or self.flash
				if noteHasName and type(soundId) == "number" then soundId = noteHasName end--Change number to 5 if it's not a custom sound, else, do nothing with it
				if self.hasVoice and DBM.Options.ChosenVoicePack ~= "None" and not voiceSessionDisabled and self.hasVoice <= SWFilterDisabed and (type(soundId) == "number" and soundId < 5 and DBM.Options.VoiceOverSpecW2 == "DefaultOnly" or DBM.Options.VoiceOverSpecW2 == "All") then return end
				if not self.option or self.mod.Options[self.option.."SWSound"] ~= "None" then
					DBM:PlaySpecialWarningSound(soundId or 1)
				end
			end
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function specialWarningPrototype:CombinedShow(delay, ...)
		if DBM.Options.DontShowSpecialWarnings or DBM.Options.DontShowSpecialWarningText then return end
		if self.option and not self.mod.Options[self.option] then return end
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		local argTable = {...}
		for i = 1, #argTable do
			if type(argTable[i]) == "string" then
				if #self.combinedtext < 8 then--Throttle spam. We may not need more than 9 targets..
					if not checkEntry(self.combinedtext, argTable[i]) then
						self.combinedtext[#self.combinedtext + 1] = argTable[i]
					end
				else
					self.combinedcount = self.combinedcount + 1
				end
			end
		end
		unschedule(self.Show, self.mod, self)
		schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:DelayedShow(delay, ...)
		unschedule(self.Show, self.mod, self, ...)
		schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Countdown(time, numAnnounces, ...)
		scheduleCountdown(time, numAnnounces, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Cancel(t, ...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Play(name, customPath)
		local always = DBM.Options.AlwaysPlayVoice
		local voice = DBM.Options.ChosenVoicePack
		if voiceSessionDisabled or voice == "None" then return end
		if self.mod:IsEasyDungeon() and self.mod.isTrashMod and DBM.Options.FilterTrashWarnings2 then return end
		if (not DBM.Options.DontShowSpecialWarnings and (not self.option or self.mod.Options[self.option]) or always) and self.hasVoice <= SWFilterDisabed then
			--Filter tank specific voice alerts for non tanks if tank filter enabled
			--But still allow AlwaysPlayVoice to play as well.
			if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
			local path = customPath or "Interface\\AddOns\\DBM-VP"..voice.."\\"..name..".ogg"
			DBM:PlaySoundFile(path)
		end
	end

	function specialWarningPrototype:ScheduleVoice(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		unschedule(self.Play, self.mod, self)--Allow ScheduleVoice to be used in same way as CombinedShow
		return schedule(t, self.Play, self.mod, self, ...)
	end

	--Object Permits scheduling voice multiple times for same object
	function specialWarningPrototype:ScheduleVoiceOverLap(t, ...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function specialWarningPrototype:CancelVoice(...)
		if voiceSessionDisabled or DBM.Options.ChosenVoicePack == "None" then return end
		return unschedule(self.Play, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty)
		if not text then
			error("NewSpecialWarning: you must provide special warning text", 2)
			return
		end
		if type(text) == "string" and text:match("OptionVersion") then
			print("NewSpecialWarning: you must provide remove optionversion hack for "..optionDefault)
			return
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				mod = self,
				sound = runSound>0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
			},
			mt
		)
		local optionId = optionName or optionName ~= false and text
		if optionId then
			obj.voiceOptionId = hasVoice and "Voice"..optionId or nil
			obj.option = optionId..(optionVersion or "")
			self:AddSpecialWarningOption(optionId, optionDefault, runSound, "announce")
		end
		tinsert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, optionVersion, runSound, hasVoice, difficulty)
		if not spellId then
			error("newSpecialWarning: you must provide spellId", 2)
			return
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
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				mod = self,
				sound = runSound>0,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
				difficulty = difficulty,
				type = announceType,
				spellId = spellId,
				spellName = spellName,
				stacks = stacks,
				icon = (type(spellId) == "string" and spellId:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3)))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or nil
			},
			mt
		)
		if optionName then
			obj.option = optionName
		elseif not (optionName == false) then
			local difficultyIcon = ""
			if difficulty then
				--1 LFR, 2 Normal, 3 Heroic, 4 Mythic
				--Likely 1 and 2 will never be used, but being prototyped just in case
				if difficulty == 3 then
					difficultyIcon = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:18:18:0:0:255:66:102:118:7:27|t"
				elseif difficulty == 4 then
					difficultyIcon = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:18:18:0:0:255:66:133:153:40:58|t"
				end
			end
			obj.option = "SpecWarn"..spellId..announceType..(optionVersion or "")
			if announceType == "stack" then
				self.localization.options[obj.option] = difficultyIcon..DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
			elseif announceType == "prewarn" then
				self.localization.options[obj.option] = difficultyIcon..DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(tostring(stacks or 5), spellId)
			else
				self.localization.options[obj.option] = difficultyIcon..DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
			end
		end
		if obj.option then
			local catType = "announce"--Default to General announce
			--Directly affects another target (boss or player) that you need to know about
			if announceType == "target" or announceType == "targetcount" or announceType == "close" or announceType == "reflect" then
				catType = "announceother"
			--Directly affects you
			elseif announceType == "you" or announceType == "youcount" or announceType == "youpos" or announceType == "move" or announceType == "dodge" or announceType == "dodgecount" or announceType == "moveaway" or announceType == "moveawaycount" or announceType == "keepmove" or announceType == "stopmove" or announceType == "run" or announceType == "stack" or announceType == "moveto" or announceType == "soak" or announceType == "soakpos" then
				catType = "announcepersonal"
			--Things you have to do to fulfil your role
			elseif announceType == "taunt" or announceType == "dispel" or announceType == "interrupt" or announceType == "interruptcount" or announceType == "switch" or announceType == "switchcount" then
				catType = "announcerole"
			end
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, catType)
		end
		obj.voiceOptionId = hasVoice and "Voice"..spellId or nil
		tinsert(self.specwarns, obj)
		return obj
	end

	function bossModPrototype:NewSpecialWarningSpell(text, optionDefault, ...)
		return newSpecialWarning(self, "spell", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningEnd(text, optionDefault, ...)
		return newSpecialWarning(self, "ends", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningFades(text, optionDefault, ...)
		return newSpecialWarning(self, "fades", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoon(text, optionDefault, ...)
		return newSpecialWarning(self, "soon", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningBait(text, optionDefault, ...)
		return newSpecialWarning(self, "bait", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDispel(text, optionDefault, ...)
		return newSpecialWarning(self, "dispel", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterrupt(text, optionDefault, ...)
		return newSpecialWarning(self, "interrupt", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterruptCount(text, optionDefault, ...)
		return newSpecialWarning(self, "interruptcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYou(text, optionDefault, ...)
		return newSpecialWarning(self, "you", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouCount(text, optionDefault, ...)
		return newSpecialWarning(self, "youcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYouPos(text, optionDefault, ...)
		return newSpecialWarning(self, "youpos", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoakPos(text, optionDefault, ...)
		return newSpecialWarning(self, "soakpos", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTarget(text, optionDefault, ...)
		return newSpecialWarning(self, "target", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetCount(text, optionDefault, ...)
		return newSpecialWarning(self, "targetcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDefensive(text, optionDefault, ...)
		return newSpecialWarning(self, "defensive", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTaunt(text, optionDefault, ...)
		return newSpecialWarning(self, "taunt", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningClose(text, optionDefault, ...)
		return newSpecialWarning(self, "close", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMove(text, optionDefault, ...)
		return newSpecialWarning(self, "move", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningKeepMove(text, optionDefault, ...)
		return newSpecialWarning(self, "keepmove", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStopMove(text, optionDefault, ...)
		return newSpecialWarning(self, "stopmove", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningGTFO(text, optionDefault, ...)
		return newSpecialWarning(self, "gtfo", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodge(text, optionDefault, ...)
		return newSpecialWarning(self, "dodge", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeCount(text, optionDefault, ...)
		return newSpecialWarning(self, "dodgecount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDodgeLoc(text, optionDefault, ...)
		return newSpecialWarning(self, "dodgeloc", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAway(text, optionDefault, ...)
		return newSpecialWarning(self, "moveaway", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveAwayCount(text, optionDefault, ...)
		return newSpecialWarning(self, "moveawaycount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMoveTo(text, optionDefault, ...)
		return newSpecialWarning(self, "moveto", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoak(text, optionDefault, ...)
		return newSpecialWarning(self, "soak", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningJump(text, optionDefault, ...)
		return newSpecialWarning(self, "jump", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningRun(text, optionDefault, optionName, optionVersion, runSound, ...)
		return newSpecialWarning(self, "run", text, nil, optionDefault, optionName, optionVersion, runSound or 4, ...)
	end

	function bossModPrototype:NewSpecialWarningCast(text, optionDefault, ...)
		return newSpecialWarning(self, "cast", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningLookAway(text, optionDefault, ...)
		return newSpecialWarning(self, "lookaway", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningReflect(text, optionDefault, ...)
		return newSpecialWarning(self, "reflect", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCount(text, optionDefault, ...)
		return newSpecialWarning(self, "count", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoonCount(text, optionDefault, ...)
		return newSpecialWarning(self, "sooncount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStack(text, optionDefault, stacks, ...)
		return newSpecialWarning(self, "stack", text, stacks, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitch(text, optionDefault, ...)
		return newSpecialWarning(self, "switch", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitchCount(text, optionDefault, ...)
		return newSpecialWarning(self, "switchcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAdds(text, optionDefault, ...)
		return newSpecialWarning(self, "adds", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningAddsCustom(text, optionDefault, ...)
		return newSpecialWarning(self, "addscustom", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTargetChange(text, optionDefault, ...)
		return newSpecialWarning(self, "targetchange", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningPreWarn(text, optionDefault, time, ...)
		return newSpecialWarning(self, "prewarn", text, time, optionDefault, ...)
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
			for i = 1, #self.Counts do
				if self.Counts[i].value == voice then
					path = self.Counts[i].path
					maxCount = self.Counts[i].max
					break
				end
			end
		end
		if not path or (number > maxCount) then return end
		self:PlaySoundFile(path..number..".ogg")
	end

	function DBM:RegisterCountSound(t, v, p, m)
		--Prevent duplicate insert
		for i = 1, #self.Counts do
			if self.Counts[i].value == v then return end
		end
		--Insert into counts table.
		if t and v and p and m then
			tinsert(self.Counts, { text = t, value = v, path = p, max = m })
		end
	end

	function DBM:CheckVoicePackVersion(value)
		local activeVP = self.Options.ChosenVoicePack
		--Check if voice pack out of date
		if activeVP ~= "None" and activeVP == value then
			if self.VoiceVersions[value] < 8 then--Version will be bumped when new voice packs released that contain new voices.
				if not self.Options.DontShowReminders then
					self:AddMsg(DBM_CORE_VOICE_PACK_OUTDATED)
				end
				SWFilterDisabed = self.VoiceVersions[value]--Set disable to version on current voice pack
			else
				SWFilterDisabed = 8
			end
		end
	end

	function DBM:PlaySpecialWarningSound(soundId)
		local sound = type(soundId) == "number" and self.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId or self.Options.SpecialWarningSound
		self:PlaySoundFile(sound, nil, true)
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(text, number, noSound)
		if moving then
			return
		end
		self:AddSpecialWarning(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(self.Options.SpecialWarningDuration2 * 1.3, testWarningEnd)
		if number and not noSound then
			self:PlaySpecialWarningSound(number)
		end
		if number and DBM.Options["SpecialWarningFlash"..number] then
			local flashColor = self.Options["SpecialWarningFlashCol"..number]
			local repeatCount = self.Options["SpecialWarningFlashCount"..number] or 1
			self.Flash:Show(flashColor[1], flashColor[2], flashColor[3], self.Options["SpecialWarningFlashDura"..number], self.Options["SpecialWarningFlashAlph"..number], repeatCount-1)
		end
	end
end

--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}
	local countvoice1, countvoice2, countvoice3 = nil, nil, nil
	local countvoice1max, countvoice2max, countvoice3max = 5, 5, 5
	local countpath1, countpath2, countpath3 = nil, nil, nil

	--Merged countdown object for timers with build-in countdown
	function DBM:BuildVoiceCountdownCache()
		countvoice1 = self.Options.CountdownVoice
		countvoice2 = self.Options.CountdownVoice2
		countvoice3 = self.Options.CountdownVoice3
		local voicesFound = 0
		for i = 1, #self.Counts do
			local curVoice = self.Counts[i]
			if curVoice.value == countvoice1 then
				countpath1 = curVoice.path
				countvoice1max = curVoice.max
			end
			if curVoice.value == countvoice2 then
				countpath2 = curVoice.path
				countvoice2max = curVoice.max
			end
			if curVoice.value == countvoice3 then
				countpath3 = curVoice.path
				countvoice3max = curVoice.max
			end
		end
	end

	local function playCountSound(timerId, path)
		DBM:PlaySoundFile(path)
	end

	local function playCountdown(timerId, timer, voice, count)
		if DBM.Options.DontPlayCountdowns then return end
		timer = timer or 10
		count = count or 5
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
					DBM:Schedule(i, playCountSound, timerId, path..i..".ogg")
				end
			end
		else
			for i = count, 1, -1 do
				if i <= maxCount then
					DBM:Schedule(timer-i, playCountSound, timerId, path..i..".ogg")
				end
			end
		end
	end

	function timerPrototype:Start(timer, ...)
		if DBM.Options.DontShowBossTimers then return end
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		if not self.option or self.mod.Options[self.option] then
			if self.type and (self.type == "cdcount" or self.type == "nextcount") and not self.allowdouble then--remove previous timer.
				for i = #self.startedTimers, 1, -1 do
					if DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
						local bar = DBM.Bars:GetBar(self.startedTimers[i])
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
							ttext = ttext.."("..self.id..")"
							if bar.timer > 0.2 then
								DBM:Debug("Timer "..ttext.. " refreshed before expired. Remaining time is : "..remaining, 2)
							end
						end
					end
					DBM.Bars:CancelBar(self.startedTimers[i])
					fireEvent("DBM_TimerStop", self.startedTimers[i])
					self.startedTimers[i] = nil
				end
			end
			local timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
			--AI timer api:
			--Starting ai timer with (1) indicates it's a first timer after pull
			--Starting timer with (2) or (3) indicates it's a stage 2 or stage 3 first timer
			--Starting AI timer with anything above 3 indicarets it's a regular timer and to use shortest time in between two regular casts
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			if self.type == "ai" then--A learning timer
				if not DBM.Options.AITimer then return end
				if timer > 4 then--Normal behavior.
					local newPhase = false
					for i = 1, 4 do
						--Check for any phase timers that are strings, if a string it means last cast of this ability was first case of a given stage
						if self["phase"..i.."CastTimer"] and type(self["phase"..i.."CastTimer"]) == "string" then--This is first cast of spell, we need to generate self.firstPullTimer
							self["phase"..i.."CastTimer"] = tonumber(self["phase"..i.."CastTimer"])
							self["phase"..i.."CastTimer"] = GetTime() - self["phase"..i.."CastTimer"]--We have generated a self.phase1CastTimer! Next pull, DBM should know timer for first cast next pull. FANCY!
							DBM:Debug("AI timer learned a first timer for current phase of "..self["phase"..i.."CastTimer"], 2)
							newPhase = true
						end
					end
					if self.lastCast and not newPhase then--We have a GetTime() on last cast and it's not affected by a phase change
						local timeLastCast = GetTime() - self.lastCast--Get time between current cast and last cast
						if timeLastCast > 4 then--Prevent infinite loop cpu hang. Plus anything shorter than 5 seconds doesn't need a timer
							if not self.lowestSeenCast or (self.lowestSeenCast and self.lowestSeenCast > timeLastCast) then--Always use lowest seen cast for a timer
								self.lowestSeenCast = timeLastCast
								DBM:Debug("AI timer learned a new lowest timer of "..self.lowestSeenCast, 2)
							end
						end
					end
					self.lastCast = GetTime()
					if self.lowestSeenCast then--Always use lowest seen cast for timer
						timer = self.lowestSeenCast
					else
						return--Don't start the bogus timer shoved into timer field in the mod
					end
				else--AI timer passed with 4 or less is indicating phase change, with timer as phase number
					if self["phase"..timer.."CastTimer"] and type(self["phase"..timer.."CastTimer"]) == "number" then
						--Check if timer is shorter than previous learned first timer by scanning remaining time on existing bar
						local bar = DBM.Bars:GetBar(id)
						if bar then
							local remaining = ("%.1f"):format(bar.timer)
							if bar.timer > 0.2 then
								self["phase"..timer.."CastTimer"] = self["phase"..timer.."CastTimer"] - remaining
								DBM:Debug("AI timer learned a lower first timer for current phase of "..self["phase"..timer.."CastTimer"], 2)
							end
						end
						timer = self["phase"..timer.."CastTimer"]
					else--No first pull timer generated yet, set it to GetTime, as a string
						self["phase"..timer.."CastTimer"] = tostring(GetTime())
						return--Don't start the x second timer
					end
				end
			end
			if DBM.Options.DebugMode and DBM.Options.DebugLevel > 1 then
				if not self.type or (self.type ~= "target" and self.type ~= "active" and self.type ~= "fades" and self.type ~= "ai") then
					local bar = DBM.Bars:GetBar(id)
					if bar then
						local remaining = ("%.1f"):format(bar.timer)
						local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
						ttext = ttext.."("..self.id..")"
						if bar.timer > 0.2 then
							DBM:Debug("Timer "..ttext.. " refreshed before expired. Remaining time is : "..remaining, 2)
						end
					end
				end
			end
			local colorId = 0
			if self.option then
				colorId = self.mod.Options[self.option .. "TColor"]
			elseif self.colorType and type(self.colorType) == "string" then--No option for specific timer, but another bool option given that tells us where to look for TColor
				colorId = self.mod.Options[self.colorType .. "TColor"] or 0
			end
			local countVoice, countVoiceMax = 0, self.countdownMax or 4
			if self.option then
				countVoice = self.mod.Options[self.option .. "CVoice"]
				if not self.fade and (type(countVoice) == "string" or countVoice > 0) then--Started without faded and has count voice assigned
					playCountdown(id, timer, countVoice, countVoiceMax)--timerId, timer, voice, count
				end
			end
			local bar = DBM.Bars:CreateBar(timer, id, self.icon, nil, nil, nil, nil, colorId, nil, self.keep, self.fade, countVoice, countVoiceMax)
			if not bar then
				return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
			end
			local msg = ""
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
			--type: Timer type (Cooldowns: cd, cdcount, nextcount, nextsource, cdspecial, nextspecial, stage, ai. Durations: target, active, fades, roleplay. Casting: cast)
			--spellId: Raw spellid if available (most timers will have spellId or EJ ID unless it's a specific timer not tied to ability such as pull or combat start or rez timers. EJ id will be in format ej%d
			--colorID: Type classification (1-Add, 2-Aoe, 3-targeted ability, 4-Interrupt, 5-Role, 6-Stage, 7-User(custom))
			--Mod ID: Encounter ID as string, or a generic string for mods that don't have encounter ID (such as trash, dummy/test mods)
			--Keep: true or nil, whether or not to keep bar on screen when it expires (if true, timer should be retained until an actual TimerStop occurs or a new TimerStart with same barId happens (in which case you replace bar with new one)
			--fade: true or nil, whether or not to fade a bar (set alpha to usersetting/2)
			fireEvent("DBM_TimerStart", id, msg, timer, self.icon, self.type, self.spellId, colorId, self.mod.id, self.keep, self.fade)
			tinsert(self.startedTimers, id)
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
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Cancel countdown, because we just enabled a bar fade
					DBM:Unschedule(playCountSound, id)
					DBM:Debug("Disabling a countdown on bar ID: "..id.." after a SetFade enable call")
				end
			end
		elseif not fadeOn and self.fade then
			self.fade = nil--set timer object metatable, which will make sure next bar started does NOT use fade
			--Find and Update an existing bar that's already started
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = nil--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Unfading bar, start countdown
					DBM:Unschedule(playCountSound, id)
					playCountdown(id, bar.timer, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetFade disable call")
				end
			end
		end
	end

	--This version does NOT set timer object meta, only started bar meta
	--Use this if you only want to alter an already STARTED temporarily
	--As such it also only needs fadeOn. fadeoff isn't needed since this temp alter never affects newly started bars
	function timerPrototype:SetSTFade(fadeOn, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			if fadeOn and not bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, true)--Timer ID, spellId, modId, true/nil (new callback only needed if we update an existing timers fade, self.fade is passed in timer start object for new timers)
				bar.fade = true--Set bar object metatable, which is copied from timer metatable at bar start only
				bar:ApplyStyle()
				if bar.countdown then--Cancel countdown, because we just enabled a bar fade
					DBM:Unschedule(playCountSound, id)
					DBM:Debug("Disabling a countdown on bar ID: "..id.." after a SetSTFade enable call")
				end
			elseif not fadeOn and bar.fade then
				fireEvent("DBM_TimerFadeUpdate", id, self.spellId, self.mod.id, nil)
				bar.fade = false
				bar:ApplyStyle()
				if bar.countdown then--Unfading bar, start countdown
					DBM:Unschedule(playCountSound, id)
					playCountdown(id, bar.timer, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
					DBM:Debug("Re-enabling a countdown on bar ID: "..id.." after a SetSTFade disable call")
				end
			end
		end
	end

	function timerPrototype:DelayedStart(delay, ...)
		unschedule(self.Start, self.mod, self, ...)
		schedule(delay or 0.5, self.Start, self.mod, self, ...)
	end
	timerPrototype.DelayedShow = timerPrototype.DelayedStart

	function timerPrototype:Schedule(t, ...)
		return schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(...)
		return unschedule(self.Start, self.mod, self, ...)
	end

	--TODO, figure out why this function doesn't properly stop count timers when calling stop without count on count timers
	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				fireEvent("DBM_TimerStop", self.startedTimers[i])
				DBM.Bars:CancelBar(self.startedTimers[i])
				DBM:Unschedule(playCountSound, self.startedTimers[i])--Unschedule countdown by timerId
				self.startedTimers[i] = nil
			end
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					fireEvent("DBM_TimerStop", id)
					DBM.Bars:CancelBar(id)
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
				if self["phase"..i.."CastTimer"] and type(self["phase"..i.."CastTimer"]) == "string" then
					self["phase"..i.."CastTimer"] = nil
					DBM:Debug("Wiping incomplete new timer of stage "..i, 2)
				end
			end
		end
	end

	function timerPrototype:Cancel(...)
		self:Stop(...)
		self:Unschedule(...)
	end

	function timerPrototype:GetTime(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0
	end

	function timerPrototype:GetRemaining(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and bar.timer or 0
	end

	function timerPrototype:IsStarted(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and true
	end

	function timerPrototype:SetTimer(timer)
		self.timer = timer
	end

	function timerPrototype:Update(elapsed, totalTime, ...)
		if DBM.Options.DontShowBossTimers then return end
		if self:GetTime(...) == 0 then
			self:Start(totalTime, ...)
		end
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		fireEvent("DBM_TimerUpdate", id, elapsed, totalTime)
		if bar and bar.countdown and bar.countdown > 0 then
			DBM:Unschedule(playCountSound, id)
			if not bar.fade then--Don't start countdown voice if it's faded bar
				playCountdown(id, totalTime-elapsed, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
				DBM:Debug("Updating a countdown after a timer Update call for timer ID:"..id)
			end
		end
		return DBM.Bars:UpdateBar(id, elapsed, totalTime)
	end

	function timerPrototype:AddTime(extendAmount, ...)
		if DBM.Options.DontShowBossTimers then return end
		if self:GetTime(...) == 0 then
			return self:Start(extendAmount, ...)
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar then
				local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
				if elapsed and total then
					if bar.countdown then
						DBM:Unschedule(playCountSound, id)
						if not bar.fade then--Don't start countdown voice if it's faded bar
							local newRemaining = (total+extendAmount) - elapsed
							playCountdown(id, newRemaining, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
							DBM:Debug("Updating a countdown after a timer AddTime call for timer ID:"..id)
						end
					end
					fireEvent("DBM_TimerUpdate", id, elapsed, total+extendAmount)
					return DBM.Bars:UpdateBar(id, elapsed, total+extendAmount)
				end
			end
		end
	end

	function timerPrototype:RemoveTime(reduceAmount, ...)
		if DBM.Options.DontShowBossTimers then return end
		if self:GetTime(...) == 0 then
			return--Do nothing
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:GetBar(id)
			if bar then
				local elapsed, total = (bar.totalTime - bar.timer), bar.totalTime
				if elapsed and total then
					local newRemaining = (total-reduceAmount) - elapsed
					if newRemaining > 0 then
						if bar.countdown and newRemaining > 2 then
							DBM:Unschedule(playCountSound, id)
							if not bar.fade then--Don't start countdown voice if it's faded bar
								playCountdown(id, newRemaining, bar.countdown, bar.countdownMax)--timerId, timer, voice, count
								DBM:Debug("Updating a countdown after a timer RemoveTime call for timer ID:"..id)
							end
						end
						fireEvent("DBM_TimerUpdate", id, elapsed, total-reduceAmount)
						return DBM.Bars:UpdateBar(id, elapsed, total-reduceAmount)
					else--New remaining less than 0
						if bar.countdown then
							DBM:Unschedule(playCountSound, id)
						end
						fireEvent("DBM_TimerStop", id)
						return DBM.Bars:CancelBar(id)
					end
				end
			end
		end
	end

	function timerPrototype:UpdateIcon(icon, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetIcon((type(icon) == "string" and icon:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or tonumber(icon) or 136116)
		end
	end

	function timerPrototype:UpdateInline(newInline, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			local ttext = _G[bar.frame:GetName().."BarName"]:GetText() or ""
			return bar:SetText(ttext, newInline or self.inlineIcon)
		end
	end

	function timerPrototype:UpdateName(name, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetText(name, self.inlineIcon)
		end
	end

	function timerPrototype:SetColor(c, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetColor(c)
		end
	end

	function timerPrototype:DisableEnlarge(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			bar.small = true
		end
	end

	function timerPrototype:AddOption(optionDefault, optionName, colorType, countdown)
		if optionName ~= false then
			self.option = optionName or self.id
			self.mod:AddBoolOption(self.option, optionDefault, "timer", nil, colorType, countdown)
		end
	end

	--If a new countdown default is added to a NewTimer object, change optionName of timer to reset a new default
	function bossModPrototype:NewTimer(timer, name, texture, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b)
		if r and type(r) == "string" then
			DBM:Debug("|cffff0000r probably has inline icon in it and needs to be fixed for |r"..name..r)
			r = nil--Fix it for users
		end
		if inlineIcon and type(inlineIcon) == "number" then
			DBM:Debug("|cffff0000spellID texture path or colorType is in inlineIcon field and needs to be fixed for |r"..name..inlineIcon)
			inlineIcon = nil--Fix it for users
		end
		local icon = (type(texture) == "string" and texture:match("ej%d+") and select(4, DBM:EJ_GetSectionInfo(string.sub(texture, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(texture, 3)))) or (type(texture) == "number" and GetSpellTexture(texture)) or tonumber(texture) or "136116"
		local obj = setmetatable(
			{
				text = self.localization.timers[name],
				timer = timer,
				id = name,
				icon = icon,
				colorType = colorType,
				inlineIcon = inlineIcon,
				keep = keep,
				countdown = countdown,
				countdownMax = countdownMax,
				r = r,
				g = g,
				b = b,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown)
		tinsert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- If a new countdown is added to an existing timer that didn't have one before, use optionName (number) to force timer to reset defaults by assigning it a new variable
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, colorType, texture, inlineIcon, keep, countdown, countdownMax, r, g, b)
		if type(timer) == "string" and timer:match("OptionVersion") then
			DBM:Debug("|cffff0000OptionVersion hack depricated, remove it from: |r"..spellId)
			return
		end
		if type(colorType) == "number" and colorType > 7 then
			DBM:Debug("|cffff0000texture is in the colorType arg for: |r"..spellId)
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
		local unparsedId = spellId
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
			icon = type(texture) == "number" and select(10, GetAchievementInfo(texture)) or tonumber(texture) or spellId and select(10, GetAchievementInfo(spellId))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" then
			icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or 136116
			if timerType == "stage" then
				colorType = 6
			end
		elseif timerType == "roleplay" then
			icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or 237538
			colorType = 6
		elseif timerType == "adds" or timerType == "addscustom" then
			icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or 136116
			colorType = 1
		else
			if type(spellId) == "string" and spellId:match("ej%d+") then
				spellName = DBM:EJ_GetSectionInfo(string.sub(spellId, 3)) or ""
			else
				spellName = DBM:GetSpellInfo(spellId or 0)
			end
			if spellName then
				icon = type(texture) == "number" and GetSpellTexture(texture) or tonumber(texture) or type(spellId) == "string" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, DBM:EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId))
			else
				icon = nil
			end
		end
		spellName = spellName or tostring(spellId)
		local timerTextValue
		--If timertext is a number, accept it as a secondary auto translate spellid
		if DBM.Options.ShortTimerText and timerText and type(timerText) == "number" then
			timerTextValue = timerText
			spellName = DBM:GetSpellInfo(timerText or 0)--Override Cached spell Name
		else
			timerTextValue = self.localization.timers[timerText] or timerText--Check timers table first, otherwise accept it as literal timer text
		end
		local id = "Timer"..(spellId or 0)..timerType..(optionVersion or "")
		local obj = setmetatable(
			{
				text = timerTextValue,
				type = timerType,
				spellId = spellId,
				name = spellName,
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
				allowdouble = allowdouble,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName, colorType, countdown)
		tinsert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if timerType == "achievement" then
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(GetAchievementLink(spellId):gsub("%[(.+)%]", "%1"))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "stage" or timerType == "roleplay" then--Timers without spellid, generic
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]--Using more than 1 stage timer or more than 1 special timer will break this, fortunately you should NEVER use more than 1 of either in a mod
		else
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(unparsedId)
		end
		return obj
	end

	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end

	--Buff/Debuff/event on boss
	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
	end

	----Buff/Debuff on players
	function bossModPrototype:NewBuffFadesTimer(...)
		return newTimer(self, "fades", ...)
	end

	function bossModPrototype:NewCastTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "cast", timer, ...)
	end

	function bossModPrototype:NewCastCountTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castcount", timer, ...)
	end

	function bossModPrototype:NewCastSourceTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, DBM:GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, DBM:GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastSourceTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "castsource", timer, ...)
	end

	function bossModPrototype:NewCDTimer(...)
		return newTimer(self, "cd", ...)
	end

	function bossModPrototype:NewCDCountTimer(...)
		return newTimer(self, "cdcount", ...)
	end

	function bossModPrototype:NewCDSourceTimer(...)
		return newTimer(self, "cdsource", ...)
	end

	function bossModPrototype:NewNextTimer(...)
		return newTimer(self, "next", ...)
	end

	function bossModPrototype:NewNextCountTimer(...)
		return newTimer(self, "nextcount", ...)
	end

	function bossModPrototype:NewNextSourceTimer(...)
		return newTimer(self, "nextsource", ...)
	end

	function bossModPrototype:NewAchievementTimer(...)
		return newTimer(self, "achievement", ...)
	end

	function bossModPrototype:NewCDSpecialTimer(...)
		return newTimer(self, "cdspecial", ...)
	end

	function bossModPrototype:NewNextSpecialTimer(...)
		return newTimer(self, "nextspecial", ...)
	end

	function bossModPrototype:NewPhaseTimer(...)
		return newTimer(self, "stage", ...)
	end

	function bossModPrototype:NewRPTimer(...)
		return newTimer(self, "roleplay", ...)
	end

	function bossModPrototype:NewAddsTimer(...)
		return newTimer(self, "adds", ...)
	end

	function bossModPrototype:NewAddsCustomTimer(...)
		return newTimer(self, "addscustom", ...)
	end

	function bossModPrototype:NewAITimer(...)
		return newTimer(self, "ai", ...)
	end

	function bossModPrototype:GetLocalizedTimerText(timerType, spellId, Name)
		local spellName
		if Name then
			spellName = Name--Pull from name stored in object
		elseif spellId then
			DBM:Debug("|cffff0000GetLocalizedTimerText fallback, this should not happen and is a bug. this fallback should be deleted if this message is never seen after async code is live|r")
			if timerType == "achievement" then
				spellName = select(2, GetAchievementInfo(spellId))
			elseif type(spellId) == "string" and spellId:match("ej%d+") then
				spellName = DBM:EJ_GetSectionInfo(string.sub(spellId, 3))
			else
				spellName = DBM:GetSpellInfo(spellId)
			end
		end
		if DBM_CORE_AUTO_TIMER_TEXTS[timerType.."short"] and DBM.Bars:GetOption("StripCDText") then
			return pformat(DBM_CORE_AUTO_TIMER_TEXTS[timerType.."short"], spellName)
		else
			return pformat(DBM_CORE_AUTO_TIMER_TEXTS[timerType], spellName)
		end
	end
end

------------------------------
--  Berserk/Combat Objects  --
------------------------------
do
	local enragePrototype = {}
	local mt = {__index = enragePrototype}

	function enragePrototype:Start(timer)
		timer = timer or self.timer or 600
		timer = timer <= 0 and self.timer - timer or timer
		self.bar:SetTimer(timer)
		self.bar:Start()
		if self.warning1 then
			if timer > 660 then self.warning1:Schedule(timer - 600, 10, DBM_CORE_MIN) end
			if timer > 300 then self.warning1:Schedule(timer - 300, 5, DBM_CORE_MIN) end
			if timer > 180 then self.warning2:Schedule(timer - 180, 3, DBM_CORE_MIN) end
		end
		if self.warning2 then
			if timer > 60 then self.warning2:Schedule(timer - 60, 1, DBM_CORE_MIN) end
			if timer > 30 then self.warning2:Schedule(timer - 30, 30, DBM_CORE_SEC) end
			if timer > 10 then self.warning2:Schedule(timer - 10, 10, DBM_CORE_SEC) end
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
		local warning1 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
		local warning2 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)
		local bar = self:NewTimer(timer, barText or DBM_CORE_GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk")
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

	function bossModPrototype:NewCombatTimer(timer, text, barText, barIcon)
		timer = timer or 10
		--NewTimer(timer, name, texture, optionDefault, optionName, colorType, inlineIcon, keep, countdown, countdownMax, r, g, b)
		local bar = self:NewTimer(timer, barText or DBM_CORE_GENERIC_TIMER_COMBAT, barIcon or "132349", nil, "timer_combat", nil, nil, nil, 1, 5)
		local obj = setmetatable(
			{
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
function bossModPrototype:AddBoolOption(name, default, cat, func, extraOption, extraOptionTwo)
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	if cat == "timer" then
		self.DefaultOptions[name.."TColor"] = extraOption or 0
		self.DefaultOptions[name.."CVoice"] = extraOptionTwo or 0
	end
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	if cat == "timer" then
		self.Options[name.."TColor"] = extraOption or 0
		self.Options[name.."CVoice"] = extraOptionTwo or 0
	end
	self:SetOptionCategory(name, cat)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddSpecialWarningOption(name, default, defaultSound, cat)
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	self.DefaultOptions[name.."SWSound"] = defaultSound or 1
	self.DefaultOptions[name.."SWNote"] = true
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self.Options[name.."SWSound"] = defaultSound or 1
	self.Options[name.."SWNote"] = true
	self:SetOptionCategory(name, cat)
end

function bossModPrototype:AddSetIconOption(name, spellId, default, isHostile, iconsUsed)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "icon")
	if isHostile then
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
		self.localization.options[name] = DBM_CORE_AUTO_ICONS_OPTION_TEXT2:format(spellId)
	else
		self.localization.options[name] = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(spellId)
	end
	--A table defining used icons by number, insert icon textures to end of option
	if iconsUsed then
		self.localization.options[name] = self.localization.options[name].." ("
		for i=1, #iconsUsed do
			--Texture ID 137009 if direct calling RaidTargetingIcons stops working one day
			if 		iconsUsed[i] == 1 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t"
			elseif	iconsUsed[i] == 2 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t"
			elseif	iconsUsed[i] == 3 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t"
			elseif	iconsUsed[i] == 4 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t"
			elseif	iconsUsed[i] == 5 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:16:32|t"
			elseif	iconsUsed[i] == 6 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:16:32|t"
			elseif	iconsUsed[i] == 7 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:16:32|t"
			elseif	iconsUsed[i] == 8 then		self.localization.options[name] = self.localization.options[name].."|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:16:32|t"
			end
		end
		self.localization.options[name] = self.localization.options[name]..")"
	end
end

function bossModPrototype:AddArrowOption(name, spellId, default, isRunTo)
	if isRunTo == true then isRunTo = 2 end--Support legacy
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "misc")
	if isRunTo == 2 then
		self.localization.options[name] = DBM_CORE_AUTO_ARROW_OPTION_TEXT:format(spellId)
	elseif isRunTo == 3 then
		self.localization.options[name] = DBM_CORE_AUTO_ARROW_OPTION_TEXT3:format(spellId)
	else
		self.localization.options[name] = DBM_CORE_AUTO_ARROW_OPTION_TEXT2:format(spellId)
	end
end

function bossModPrototype:AddRangeFrameOption(range, spellId, default)
	self.DefaultOptions["RangeFrame"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["RangeFrame"] = (default == nil) or default
	self:SetOptionCategory("RangeFrame", "misc")
	if spellId then
		self.localization.options["RangeFrame"] = DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(range, spellId)
	else
		self.localization.options["RangeFrame"] = DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format(range)
	end
end

function bossModPrototype:AddHudMapOption(name, spellId, default)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "misc")
	if spellId then
		self.localization.options[name] = DBM_CORE_AUTO_HUD_OPTION_TEXT:format(spellId)
	else
		self.localization.options[name] = DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI
	end
end

function bossModPrototype:AddNamePlateOption(name, spellId, default)
	if not spellId then
		error("AddNamePlateOption must provide valid spellId", 2)
	end
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "nameplate")
	self.localization.options[name] = DBM_CORE_AUTO_NAMEPLATE_OPTION_TEXT:format(spellId)
end

function bossModPrototype:AddInfoFrameOption(spellId, default, optionVersion)
	local oVersion = ""
	if optionVersion then
		optionVersion = tostring(optionVersion)
	end
	self.DefaultOptions["InfoFrame"..oVersion] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["InfoFrame"..oVersion] = (default == nil) or default
	self:SetOptionCategory("InfoFrame"..oVersion, "misc")
	if spellId then
		self.localization.options["InfoFrame"..oVersion] = DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT:format(spellId)
	else
		self.localization.options["InfoFrame"..oVersion] = DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT2
	end
end

function bossModPrototype:AddReadyCheckOption(questId, default, maxLevel)
	self.readyCheckQuestId = questId
	self.readyCheckMaxLevel = maxLevel or 999
	self.DefaultOptions["ReadyCheck"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["ReadyCheck"] = (default == nil) or default
	self.localization.options["ReadyCheck"] = DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT
	self:SetOptionCategory("ReadyCheck", "misc")
end

function bossModPrototype:AddSliderOption(name, minValue, maxValue, valueStep, default, cat, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "slider", value = default or 0}
	self.Options[name] = default or 0
	self:SetOptionCategory(name, cat)
	self.sliders = self.sliders or {}
	self.sliders[name] = {
		minValue = minValue,
		maxValue = maxValue,
		valueStep = valueStep,
	}
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddEditboxOption(name, default, cat, width, height, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "editbox", value = default or ""}
	self.Options[name] = default or ""
	self:SetOptionCategory(name, cat)
	self.editboxes = self.editboxes or {}
	self.editboxes[name] = {
		width = width,
		height = height
	}
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddButton(name, onClick, cat, width, height, fontObject)
	cat = cat or "misc"
	self:SetOptionCategory(name, cat)
	self.buttons = self.buttons or {}
	self.buttons[name] = {
		onClick = onClick,
		width = width,
		height = height,
		fontObject = fontObject
	}
end

-- FIXME: this function does not reset any settings to default if you remove an option in a later revision and a user has selected this option in an earlier revision were it still was available
-- this will be fixed as soon as it is necessary due to removed options ;-)
function bossModPrototype:AddDropdownOption(name, options, default, cat, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = {type = "dropdown", value = default}
	self.Options[name] = default
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

function bossModPrototype:AddOptionLine(text, cat)
	cat = cat or "misc"
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
	end
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], {line = true, text = text})
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

function bossModPrototype:AddMiscLine(text)
	return self:AddOptionLine(text, "misc")
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for i, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[i] = nil
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

function bossModPrototype:SetOptionCategory(name, cat)
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
	end
	tinsert(self.optionCategories[cat], name)
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
	if self.noFriendlyEngagement then
		info.noFriendlyEngagement = self.noFriendlyEngagement
	end
	if self.noRegenDetection then
		info.noRegenDetection = self.noRegenDetection
	end
	if self.noWBEsync then
		info.noWBEsync = self.noWBEsync
	end
	if self.noBossDeathKill then
		info.noBossDeathKill = self.noBossDeathKill
	end
	-- use pull-mobs as kill mobs by default, can be overriden by RegisterKill
	if self.multiMobPullDetection then
		for i, v in ipairs(self.multiMobPullDetection) do
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
			self.numBoss = #self.multiMobPullDetection
			if self.inCombat then
				--Called mid combat, fix some variables
				self.vb.bossLeft = self.numBoss
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

function bossModPrototype:DisableWBEngageSync()
	self.noWBEsync = true
	if self.combatInfo then
		self.combatInfo.noWBEsync = true
	end
end

function bossModPrototype:IsInCombat()
	return self.inCombat
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
	if not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 8 then
		self:ReceiveSync(event, nil, self.revision or 0, tostringall(...))
		sendSync("M", str)
	end
end

function bossModPrototype:SendBigWigsSync(msg, extra)
	msg = "B^".. msg
	if extra then
		msg = msg .."^".. extra
	end
	if IsInGroup() then
		SendAddonMessage("BigWigs", msg, IsInGroup(2) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or "PARTY")
	end
end

function bossModPrototype:ReceiveSync(event, sender, revision, ...)
	local spamId = self.id .. event .. strjoin("\t", ...)
	local time = GetTime()
	if (not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > self.SyncThreshold) and self.OnSync and (not (self.blockSyncs and sender)) and (not sender or (not self.minSyncRevision or revision >= self.minSyncRevision)) then
		modSyncSpam[spamId] = time
		-- we have to use the sender as last argument for compatibility reasons (stupid old API...)
		-- avoid table allocations for frequently used number of arguments
		if select("#", ...) <= 1 then
			-- syncs with no arguments have an empty argument (also for compatibility reasons)
			self:OnSync(event, ... or "", sender)
		elseif select("#", ...) == 2 then
			self:OnSync(event, ..., select(2, ...), sender)
		else
			local tmp = { ... }
			tmp[#tmp + 1] = sender
			self:OnSync(event, unpack(tmp))
		end
	end
end

function bossModPrototype:SetRevision(revision)
	revision = parseCurseDate(revision or "")
	if not revision or revision == "@project-date-integer@" then
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
	return schedule(t, f, self, ...)
end

function bossModPrototype:Unschedule(f, ...)
	return unschedule(f, self, ...)
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
	local scanExpires = {}
	local addsIcon = {}
	local addsIconSet = {}

	function bossModPrototype:SetIcon(target, icon, timer)
		if not target then return end--Fix a rare bug where target becomes nil at last second (end combat fires and clears targets)
		if DBM.Options.DontSetIcons or not enableIcons or DBM:GetRaidRank(playerName) == 0 then
			return
		end
		self:UnscheduleMethod("SetIcon", target)
		if type(icon) ~= "number" or type(target) ~= "string" then--icon/target probably backwards.
			DBM:Debug("|cffff0000SetIcon is being used impropperly. Check icon/target order|r")
			return--Fail silently instead of spamming icon lua errors if we screw up
		end
		icon = icon and icon >= 0 and icon <= 8 and icon or 8
		local uId = DBM:GetRaidUnitId(target)
		if uId and UnitIsUnit(uId, "player") and DBM:GetNumRealGroupMembers() < 2 then return end--Solo raid, no reason to put icon on yourself.
		if uId or UnitExists(target) then--target accepts uid, unitname both.
			uId = uId or target
			--save previous icon into a table.
			local oldIcon = self:GetIcon(uId) or 0
			if not self.iconRestore[uId] then
				self.iconRestore[uId] = oldIcon
			end
			--set icon
			if oldIcon ~= icon then--Don't set icon if it's already set to what we're setting it to
				SetRaidTarget(uId, self.iconRestore[uId] and icon == 0 and self.iconRestore[uId] or icon)
			end
			--schedule restoring old icon if timer enabled.
			if timer then
				self:ScheduleMethod(timer, "SetIcon", target, 0)
			end
		end
	end

	do
		local iconSortTable = {}
		local iconSet = {}

		local function sort_by_group(v1, v2)
			return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
		end

		local function clearSortTable(scanID)
			iconSortTable[scanID] = nil
			iconSet[scanID] = nil
		end

		function bossModPrototype:SetIconByAlphaTable(returnFunc, scanID)
			tsort(iconSortTable[scanID])--Sorted alphabetically
			for i = 1, #iconSortTable[scanID] do
				local target = iconSortTable[scanID][i]
				if i > 8 then
					DBM:Debug("|cffff0000Too many players to set icons, reconsider where using icons|r", 2)
					return
				end
				if not self.iconRestore[target] then
					local oldIcon = self:GetIcon(target) or 0
					self.iconRestore[target] = oldIcon
				end
				SetRaidTarget(target, i)--Icons match number in table in alpha sort
				if returnFunc then
					self[returnFunc](self, target, i)--Send icon and target to returnFunc. (Generally used by announce icon targets to raid chat feature)
				end
			end
			DBM:Schedule(1.5, clearSortTable, scanID)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
		end

		function bossModPrototype:SetAlphaIcon(delay, target, maxIcon, returnFunc, scanID)
			if not target then return end
			if DBM.Options.DontSetIcons or not enableIcons or DBM:GetRaidRank(playerName) == 0 then
				return
			end
			scanID = scanID or 1
			local uId = DBM:GetRaidUnitId(target)
			if uId or UnitExists(target) then--target accepts uid, unitname both.
				uId = uId or target
				if not iconSortTable[scanID] then iconSortTable[scanID] = {} end
				if not iconSet[scanID] then iconSet[scanID] = 0 end
				local foundDuplicate = false
				for i = #iconSortTable[scanID], 1, -1 do
					if iconSortTable[scanID][i] == uId then
						foundDuplicate = true
						break
					end
				end
				if not foundDuplicate then
					iconSet[scanID] = iconSet[scanID] + 1
					tinsert(iconSortTable[scanID], uId)
				end
				self:UnscheduleMethod("SetIconByAlphaTable")
				if maxIcon and iconSet[scanID] == maxIcon then
					self:SetIconByAlphaTable(returnFunc, scanID)
				elseif self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
					self:ScheduleMethod(delay or 0.5, "SetIconByAlphaTable", returnFunc, scanID)
				end
			end
		end

		function bossModPrototype:SetIconBySortedTable(startIcon, reverseIcon, returnFunc, scanID)
			tsort(iconSortTable[scanID], sort_by_group)
			local icon, CustomIcons
			if startIcon and type(startIcon) == "table" then--Specific gapped icons
				CustomIcons = true
				icon = 1
			else
				icon = startIcon or 1
			end
			for i, v in ipairs(iconSortTable[scanID]) do
				if not self.iconRestore[v] then
					local oldIcon = self:GetIcon(v) or 0
					self.iconRestore[v] = oldIcon
				end
				if CustomIcons then
					SetRaidTarget(v, startIcon[icon])--do not use SetIcon function again. It already checked in SetSortedIcon function.
					icon = icon + 1
					if returnFunc then
						self[returnFunc](self, v, startIcon[icon])--Send icon and target to returnFunc. (Generally used by announce icon targets to raid chat feature)
					end
				else
					SetRaidTarget(v, icon)--do not use SetIcon function again. It already checked in SetSortedIcon function.
					if reverseIcon then
						icon = icon - 1
					else
						icon = icon + 1
					end
					if returnFunc then
						self[returnFunc](self, v, icon)--Send icon and target to returnFunc. (Generally used by announce icon targets to raid chat feature)
					end
				end
			end
			DBM:Schedule(1.5, clearSortTable, scanID)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
		end

		function bossModPrototype:SetSortedIcon(delay, target, startIcon, maxIcon, reverseIcon, returnFunc, scanID)
			if not target then return end
			if DBM.Options.DontSetIcons or not enableIcons or DBM:GetRaidRank(playerName) == 0 then
				return
			end
			scanID = scanID or 1
			if not startIcon then startIcon = 1 end
			local uId = DBM:GetRaidUnitId(target)
			if uId or UnitExists(target) then--target accepts uid, unitname both.
				uId = uId or target
				if not iconSortTable[scanID] then iconSortTable[scanID] = {} end
				if not iconSet[scanID] then iconSet[scanID] = 0 end
				local foundDuplicate = false
				for i = #iconSortTable[scanID], 1, -1 do
					if iconSortTable[scanID][i] == uId then
						foundDuplicate = true
						break
					end
				end
				if not foundDuplicate then
					iconSet[scanID] = iconSet[scanID] + 1
					tinsert(iconSortTable[scanID], uId)
				end
				self:UnscheduleMethod("SetIconBySortedTable")
				if maxIcon and iconSet[scanID] == maxIcon then
					self:SetIconBySortedTable(startIcon, reverseIcon, returnFunc, scanID)
				elseif self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
					self:ScheduleMethod(delay or 0.5, "SetIconBySortedTable", startIcon, reverseIcon, returnFunc, scanID)
				end
			end
		end
	end

	function bossModPrototype:GetIcon(uId)
		return UnitExists(uId) and GetRaidTargetIndex(uId)
	end

	function bossModPrototype:RemoveIcon(target)
		return self:SetIcon(target, 0)
	end

	function bossModPrototype:ClearIcons()
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if UnitExists("raid"..i) and GetRaidTargetIndex("raid"..i) then
					SetRaidTarget("raid"..i, 0)
				end
			end
		else
			for i = 1, GetNumSubgroupMembers() do
				if UnitExists("party"..i) and GetRaidTargetIndex("party"..i) then
					SetRaidTarget("party"..i, 0)
				end
			end
		end
	end

	function bossModPrototype:CanSetIcon(optionName)
		if canSetIcons[optionName] then
			return true
		end
		return false
	end

	local mobUids = {"mouseover", "target", "boss1", "boss2", "boss3", "boss4", "boss5",
	"nameplate1", "nameplate2", "nameplate3", "nameplate4", "nameplate5", "nameplate6", "nameplate7", "nameplate8", "nameplate9", "nameplate10",
	"nameplate11", "nameplate12", "nameplate13", "nameplate14", "nameplate15", "nameplate16", "nameplate17", "nameplate18", "nameplate19", "nameplate20",
	"nameplate21", "nameplate22", "nameplate23", "nameplate24", "nameplate25", "nameplate26", "nameplate27", "nameplate28", "nameplate29", "nameplate30",
	"nameplate31", "nameplate32", "nameplate33", "nameplate34", "nameplate35", "nameplate36", "nameplate37", "nameplate38", "nameplate39", "nameplate40"}
	function bossModPrototype:ScanForMobs(creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName, isFriendly, secondCreatureID, skipMarked)
		if not optionName then optionName = self.findFastestComputer[1] end
		if canSetIcons[optionName] then
			--Declare variables.
			DBM:Debug("canSetIcons true", 2)
			local timeNow = GetTime()
			local creatureID = creatureID--This function must not be used to boss, so remove self.creatureId. Accepts cid, guid and cid table
			local iconSetMethod = iconSetMethod or 0--Set IconSetMethod -- 0: Descending / 1:Ascending / 2: Force Set / 9:Force Stop
			local scanningTime = scanningTime or 8
			local maxIcon = maxIcon or 8 --We only have 8 icons.
			local isFriendly = isFriendly or false
			local secondCreatureID = secondCreatureID or 0
			local scanInterval = scanInterval or 0.2
			--With different scanID, this function can support multi scanning same time. Required for Nazgrim.
			local scanID = 0
			if type(creatureID) == "number" then
				scanID = creatureID --guid and table no not supports multi scanning. only cid supports multi scanning
			end
			if iconSetMethod == 9 then--Force stop scanning
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				return
			end
			if not addsIcon[scanID] then addsIcon[scanID] = mobIcon or 8 end
			if not addsIconSet[scanID] then addsIconSet[scanID] = 0 end
			if not scanExpires[scanID] then scanExpires[scanID] = timeNow + scanningTime end
			--DO SCAN NOW
			for _, unitid2 in ipairs(mobUids) do
				local guid2 = UnitGUID(unitid2)
				local cid2 = self:GetCIDFromGUID(guid2)
				local isEnemy = UnitIsEnemy("player", unitid2) or true--If api returns nil, assume it's an enemy
				local isFiltered = false
				if (not isFriendly and not isEnemy) or (skipMarked and not GetRaidTargetIndex(unitid2)) then
					isFiltered = true
					DBM:Debug("A unit skipped because it's a filtered mob", 3)
				end
				if not isFiltered then
					if guid2 and type(creatureID) == "table" and creatureID[cid2] and not addsGUIDs[guid2] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if type(creatureID[cid2]) == "number" then
							SetRaidTarget(unitid2, creatureID[cid2])
						else
							SetRaidTarget(unitid2, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid2] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					elseif guid2 and (guid2 == creatureID or cid2 == creatureID or cid2 == secondCreatureID) and not addsGUIDs[guid2] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if iconSetMethod == 2 then
							SetRaidTarget(unitid2, mobIcon)
						else
							SetRaidTarget(unitid2, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid2] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					end
				end
			end
			for uId in DBM:GetGroupMembers() do
				local unitid = uId.."target"
				local guid = UnitGUID(unitid)
				local cid = self:GetCIDFromGUID(guid)
				local isEnemy = UnitIsEnemy("player", unitid) or true--If api returns nil, assume it's an enemy
				local isFiltered = false
				if (not isFriendly and not isEnemy) or (skipMarked and not GetRaidTargetIndex(unitid)) then
					isFiltered = true
					DBM:Debug("ScanForMobs aborting because filtered mob", 2)
				end
				if not isFiltered then
					if guid and type(creatureID) == "table" and creatureID[cid] and not addsGUIDs[guid] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if type(creatureID[cid]) == "number" then
							SetRaidTarget(unitid, creatureID[cid])
						else
							SetRaidTarget(unitid, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					elseif guid and (guid == creatureID or cid == creatureID or cid == secondCreatureID) and not addsGUIDs[guid] then
						DBM:Debug("Match found, SHOULD be setting icon", 2)
						if iconSetMethod == 2 then
							SetRaidTarget(unitid, mobIcon)
						else
							SetRaidTarget(unitid, addsIcon[scanID])
							if iconSetMethod == 1 then
								addsIcon[scanID] = addsIcon[scanID] + 1
							else
								addsIcon[scanID] = addsIcon[scanID] - 1
							end
						end
						addsGUIDs[guid] = true
						addsIconSet[scanID] = addsIconSet[scanID] + 1
						if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
							--clear variables
							scanExpires[scanID] = nil
							addsIcon[scanID] = nil
							addsIconSet[scanID] = nil
							return
						end
					end
				end
			end
			if timeNow < scanExpires[scanID] then--scan for limited times.
				self:ScheduleMethod(scanInterval, "ScanForMobs", creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName, isFriendly, secondCreatureID)
			else
				DBM:Debug("Stopping ScanForMobs for: "..(optionName or "nil"), 2)
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				--Do not wipe adds GUID table here, it's wiped by :Stop() which is called by EndCombat
			end
		else
			DBM:Debug("Not elected to set icons for "..(optionName or "nil"), 2)
		end
	end
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

function bossModPrototype:SetModelMoveSpeed(v)
	self.modelMoveSpeed = v
end

function bossModPrototype:SetModelID(id)
	self.modelId = id
end

function bossModPrototype:SetModelSound(long, short)--PlaySoundFile prototype for model viewer, long is long sound, short is a short clip, configurable in UI, both sound paths defined in boss mods.
	self.modelSoundLong = long
	self.modelSoundShort = short
end

function bossModPrototype:EnableModel()
	self.modelEnabled = true
end

function bossModPrototype:DisableModel()
	self.modelEnabled = nil
end

--------------------
--  Localization  --
--------------------
function bossModPrototype:GetLocalizedStrings()
	self.localization.miscStrings.name = self.localization.general.name
	return self.localization.miscStrings
end

-- Not really good, needs a few updates
do
	local modLocalizations = {}
	local modLocalizationPrototype = {}
	local mt = {__index = modLocalizationPrototype}
	local returnKey = {__index = function(t, k) return k end}
	local defaultCatLocalization = {
		__index = setmetatable({
			timer				= DBM_CORE_OPTION_CATEGORY_TIMERS,
			announce			= DBM_CORE_OPTION_CATEGORY_WARNINGS,
			announceother		= DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER,
			announcepersonal	= DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU,
			announcerole		= DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE,
			sound				= DBM_CORE_OPTION_CATEGORY_SOUNDS,
			yell				= DBM_CORE_OPTION_CATEGORY_YELLS,
			icon				= DBM_CORE_OPTION_CATEGORY_ICONS,
			nameplate			= DBM_CORE_OPTION_CATEGORY_NAMEPLATES,
			misc				= MISCELLANEOUS
		}, returnKey)
	}
	local defaultTimerLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_GENERIC_TIMER_BERSERK,
			timer_combat = DBM_CORE_GENERIC_TIMER_COMBAT
		}, returnKey)
	}
	local defaultAnnounceLocalization = {
		__index = setmetatable({
			warning_berserk = DBM_CORE_GENERIC_WARNING_BERSERK
		}, returnKey)
	}
	local defaultOptionLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_OPTION_TIMER_BERSERK,
			timer_combat = DBM_CORE_OPTION_TIMER_COMBAT,
		}, returnKey)
	}
	local defaultMiscLocalization = {
		__index = {}
	}

	function modLocalizationPrototype:SetGeneralLocalization(t)
		for i, v in pairs(t) do
			self.general[i] = v
		end
	end

	function modLocalizationPrototype:SetWarningLocalization(t)
		for i, v in pairs(t) do
			self.warnings[i] = v
		end
	end

	function modLocalizationPrototype:SetTimerLocalization(t)
		for i, v in pairs(t) do
			self.timers[i] = v
		end
	end

	function modLocalizationPrototype:SetOptionLocalization(t)
		for i, v in pairs(t) do
			self.options[i] = v
		end
	end

	function modLocalizationPrototype:SetOptionCatLocalization(t)
		for i, v in pairs(t) do
			self.cats[i] = v
		end
	end

	function modLocalizationPrototype:SetMiscLocalization(t)
		for i, v in pairs(t) do
			self.miscStrings[i] = v
		end
	end

	function DBM:CreateModLocalization(name)
		name = tostring(name)
		local obj = {
			general = setmetatable({}, returnKey),
			warnings = setmetatable({}, defaultAnnounceLocalization),
			options = setmetatable({}, defaultOptionLocalization),
			timers = setmetatable({}, defaultTimerLocalization),
			miscStrings = setmetatable({}, defaultMiscLocalization),
			cats = setmetatable({}, defaultCatLocalization),
		}
		setmetatable(obj, mt)
		modLocalizations[name] = obj
		return obj
	end

	function DBM:GetModLocalization(name)
		name = tostring(name)
		return modLocalizations[name] or self:CreateModLocalization(name)
	end
end
