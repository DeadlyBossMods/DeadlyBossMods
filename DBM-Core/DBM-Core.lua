-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author & DBM maintainer) Contact: Twitter @MysticalOS)
--
-- The localizations are written by:
--    * enGB/enUS: Omegal				http://www.deadlybossmods.com
--    * deDE: Ebmor						http://forums.elitistjerks.com/user/616736-ebmor/
--    * ruRU: Swix						stalker.kgv@gmail.com
--    * ruRU: TOM_RUS					http://www.curseforge.com/profiles/TOM_RUS/
--    * zhTW: Whyv						ultrashining@gmail.com
--    * koKR: nBlueWiz					everfinale@gmail.com
--    * zhCN: Mini Dragon				projecteurs@gmail.com
--
-- The former/inactive-translators:
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--    * zhCN: Diablohu					http://www.dreamgen.cn | diablohudream@gmail.com
--    * zhCN: oliver1452				http://forums.elitistjerks.com/user/623698-oliver1452/
--    * esES/esMX: Sueñalobos			alcortesm@gmail.com
--    * frFR: leiyla					http://forums.elitistjerks.com/user/616557-leiyla/
--
-- Special thanks to:
--    * Arta
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--    * nBlueWiz (a lot of fixes in the koKR localization as well as boss mod work) Contact: everfinale@gmail.com
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
DBM = {
	Revision = tonumber(("$Revision$"):sub(12, -3)),
	DisplayVersion = "6.0.16 alpha", -- the string that is shown as version
	ReleaseRevision = 12764 -- the revision of the latest stable version that is available
}

-- Legacy crap; that stupid "Version" field was never a good idea.
-- Some functions that should be using ReleaseRevision still use this one, so we will just keep it and set to ReleaseRevision
DBM.Version = tostring(DBM.ReleaseRevision)

-- support for git svn which doesn't support svn keyword expansion
if not DBM.Revision then
	-- just use the latest release revision
	DBM.Revision = DBM.ReleaseRevision
end

DBM_UseDualProfile = false

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turqoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = "Sound\\Doodad\\BellTollNightElf.ogg",
	SpecialWarningSound = "Sound\\Spells\\PVPFlagTaken.ogg",
	SpecialWarningSound2 = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.ogg",
	SpecialWarningSound3 = "Sound\\Creature\\KilJaeden\\KILJAEDEN02.ogg",
	SpecialWarningSound4 = "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg",
	ModelSoundValue = "Short",
	ChallengeBest = "Realm",
	CountdownVoice = "Corsica",
	CountdownVoice2 = "Kolt",
	CountdownVoice3 = "Pewsey",
	ChosenVoicePack = "None",
	VoiceOverSpecW2 = "DefaultOnly",
	AlwaysPlayVoice = false,
	ShowCountdownText = false,
	RaidWarningPosition = {
		Point = "TOP",
		X = 0,
		Y = -185,
	},
	Enabled = true,
	ShowWarningsInChat = true,
	ShowSWarningsInChat = true,
	ShowFakedRaidWarnings = false,
	WarningIconLeft = true,
	WarningIconRight = true,
	WarningIconChat = true,
	StripServerName = true,
	ShowCombatLogMessage = true,
	ShowTranscriptorMessage = true,
	ShowAllVersions = true,
	ShowLoadMessage = true,
	ShowPizzaMessage = true,
	ShowEngageMessage = true,
	ShowKillMessage = true,
	ShowWipeMessage = true,
	ShowGuildMessages = true,
	ShowRecoveryMessage = true,
	AutoRespond = true,
	StatusEnabled = true,
	WhisperStats = false,
	HideBossEmoteFrame = true,
	SpamBlockBossWhispers = true,
	ShowMinimapButton = false,
	ShowSpecialWarnings = true,
	ShowFlashFrame = true,
	CustomSounds = 0,
	AlwaysShowHealthFrame = false,
	ShowBigBrotherOnCombatStart = false,
	FilterTankSpec = true,
	AutologBosses = false,
	AdvancedAutologBosses = false,
	LogOnlyRaidBosses = false,
	UseMasterVolume = true,
	LFDEnhance = true,
	WorldBossNearAlert = false,
	AFKHealthWarning = false,
	HideObjectivesFrame = true,
	HideGarrisonUpdates = true,
	HideGuildChallengeUpdates = true,
	HideApplicantAlerts = 0,
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
	HPFramePoint = "CENTER",
	HPFrameX = -50,
	HPFrameY = 50,
	HPFrameMaxEntries = 5,
	WarningDuration = 4,
	WarningPoint = "CENTER",
	WarningX = 0,
	WarningY = 260,
	WarningFont = STANDARD_TEXT_FONT,
	WarningFontSize = 20,
	WarningFontStyle = "None",
	WarningFontShadow = true,
	SpecialWarningDuration = 4,
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = STANDARD_TEXT_FONT,
	SpecialWarningFontSize = 50,
	SpecialWarningFontStyle = "THICKOUTLINE",
	SpecialWarningFontShadow = false,
	SpecialWarningFontCol = {1.0, 0.7, 0.0},--Yellow, with a tint of orange
	SpecialWarningFlashCol1 = {1.0, 1.0, 0.0},--Yellow
	SpecialWarningFlashCol2 = {1.0, 0.5, 0.0},--Orange
	SpecialWarningFlashCol3 = {1.0, 0.0, 0.0},--Red
	SpecialWarningFlashCol4 = {1.0, 0.0, 1.0},--Purple
	SpecialWarningFlashDura1 = 0.4,
	SpecialWarningFlashDura2 = 0.4,
	SpecialWarningFlashDura3 = 1,
	SpecialWarningFlashDura4 = 0.7,
	SpecialWarningFlashAlph1 = 0.3,
	SpecialWarningFlashAlph2 = 0.3,
	SpecialWarningFlashAlph3 = 0.4,
	SpecialWarningFlashAlph4 = 0.4,
	SpecialWarningFlashRepeat1 = false,
	SpecialWarningFlashRepeat2 = false,
	SpecialWarningFlashRepeat3 = true,
	SpecialWarningFlashRepeat4 = false,
	SpecialWarningFlashRepeatAmount = 2,--Repeat 2 times, mean 3 flashes (first plus 2 repeat)
	HealthFrameGrowUp = false,
	HealthFrameLocked = false,
	HealthFrameWidth = 200,
	ArrowPosX = 0,
	ArrowPosY = -150,
	ArrowPoint = "TOP",
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontShowFarWarnings = true,
	DontSendBossWhispers = false,
	DontSetIcons = false,
	DontRestoreIcons = false,
	DontShowRangeFrame = false,
	DontRestoreRange = false,
	DontShowInfoFrame = false,
	DontShowHealthFrame = false,
	DontPlayCountdowns = false,
	DontShowPT2 = false,
	DontShowPTCountdownText = false,
	DontPlayPTCountdown = false,
	DontShowPTText = false,
	DontShowPTNoID = false,
	DontShowCTCount = false,
	DontShowFlexMessage = false,
	--
	PTCountThreshold = 5,
	LatencyThreshold = 250,
	BigBrotherAnnounceToRaid = false,
	SettingsMessageShown = false,
	ForumsMessageShown = false,
	PGMessageShown = false,
	MCMessageShown = false,
	AlwaysShowSpeedKillTimer = true,
	CRT_Enabled = false,
	HelpMessageShown2 = false,
--	BugMessageShown = 0,
	MoviesSeen = {},
	MovieFilter = "AfterFirst",
	LastRevision = 0,
	FilterSayAndYell = false,
	DebugMode = false,
	DebugLevel = 1,
	RoleSpecAlert = true,
	CheckGear = true,
	WorldBossAlert = false,
	AutoAcceptFriendInvite = false,
	AutoAcceptGuildInvite = false,
	FakeBWVersion = false,
	ChatFrame = "DEFAULT_CHAT_FRAME",
}

DBM.Bars = DBT:New()
DBM.Mods = {}
DBM.ModLists = {}
DBM.Counts = {
	{	text	= "Moshne (Male)",	value 	= "Mosh"},
	{	text	= "Corsica (Female)",value 	= "Corsica"},
	{	text	= "Koltrane (Male)",value 	= "Kolt"},
	{	text	= "Pewsey (Male)",value 	= "Pewsey"},
	{	text	= "Bear (Male Child)",value = "Bear"},
	{	text	= "Anshlun (ptBR Male)",value = "Anshlun"},
	{	text	= "Neryssa (ptBR Female)",value = "Neryssa"},
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
local blockEnable = false
local cachedGetTime = GetTime()
local lastCombatStarted = cachedGetTime
local loadcIds = {}
local inCombat = {}
local combatInfo = {}
local bossIds = {}
local updateFunctions = {}
local raid = {}
local modSyncSpam = {}
local autoRespondSpam = {}
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<DBM> "
local ver = ("%s (r%d)"):format(DBM.DisplayVersion, DBM.Revision)
local mainFrame = CreateFrame("Frame", "DBMMainFrame")
local newerVersionPerson = {}
local newerRevisionPerson = {}
local combatInitialized = false
local healthCombatInitialized = false
local pformat
local schedule
local unschedule
local loadOptions
local checkWipe
local checkBossHealth
local checkCustomBossHealth
local loopCRTimer
local fireEvent
local playerName = UnitName("player")
local playerLevel = UnitLevel("player")
local playerRealm = GetRealmName()
local gladStance = GetSpellInfo(156291)
local connectedServers = GetAutoCompleteRealms()
local _, class = UnitClass("player")
local LastInstanceMapID = -1
local LastGroupSize = 0
local LastInstanceType = nil
local queuedBattlefield = {}
local loadDelay = nil
local loadDelay2 = nil
local stopDelay = nil
local watchFrameRestore = false
local bossHealth = {}
local bossHealthuIdCache = {}
local bossuIdCache = {}
local savedDifficulty, difficultyText, difficultyIndex
local lastBossEngage = {}
local lastBossDefeat = {}
local bossuIdFound = false
local timerRequestInProgress = false
local updateNotificationDisplayed = 0
local tooltipsHidden = false
local SWFilterDisabed = 3
local currentSpecGroup = GetActiveSpecGroup()
local currentSpecID, currentSpecName
local cSyncSender = {}
local cSyncReceived = 0
local eeSyncSender = {}
local eeSyncReceived = 0
local canSetIcons = {}
local iconSetRevision = {}
local iconSetPerson = {}
local addsGUIDs = {}

local fakeBWRevision = 12669

local enableIcons = true -- set to false when a raid leader or a promoted player has a newer version of DBM
local guiRequested = false

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod like DBM-Battlegrounds (replaced by DBM-PvP)) boss mods, these mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM-Battlegrounds", --replaced by DBM-PvP
	-- ZG and ZA are now part of the party mods for Cataclysm
	"DBM-ZulAman",
	"DBM-ZG",
	"DBM-SiegeOfOrgrimmar",--Block legacy version. New version is "DBM-SiegeOfOrgrimmarV2"
	"DBM-HighMail",
	"DBM-ProvingGrounds-MoP",--Renamed to DBM-ProvingGrounds in 6.0 version since blizzard updated content for WoD
	"DBM-VPKiwiBeta",--Renamed to DBM-VPKiwi in final version.
}

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local DBM = DBM
-- these global functions are accessed all the time by the event handler
-- so caching them is worth the effort
local ipairs, pairs, next = ipairs, pairs, next
local tinsert, tremove, twipe, tsort = table.insert, table.remove, table.wipe, table.sort
local type, select = type, select
local GetTime = GetTime
local bband = bit.band
local floor, mhuge, mmin, mmax = math.floor, math.huge, math.min, math.max
local GetNumGroupMembers, GetRaidRosterInfo = GetNumGroupMembers, GetRaidRosterInfo
local IsInRaid, IsInGroup, IsInInstance = IsInRaid, IsInGroup, IsInInstance
local UnitAffectingCombat, InCombatLockdown, IsEncounterInProgress = UnitAffectingCombat, InCombatLockdown, IsEncounterInProgress
local UnitGUID, UnitHealth, UnitHealthMax, UnitBuff = UnitGUID, UnitHealth, UnitHealthMax, UnitBuff
local UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit, UnitIsAFK = UnitExists, UnitIsDead, UnitIsFriend, UnitIsUnit, UnitIsAFK
local GetSpellInfo, EJ_GetSectionInfo, GetSpellTexture, GetActiveSpecGroup = GetSpellInfo, EJ_GetSectionInfo, GetSpellTexture, GetActiveSpecGroup
local EJ_GetEncounterInfo, EJ_GetCreatureInfo, GetDungeonInfo = EJ_GetEncounterInfo, EJ_GetCreatureInfo, GetDungeonInfo
local GetInstanceInfo = GetInstanceInfo
local UnitPosition, GetCurrentMapDungeonLevel, GetMapInfo, GetCurrentMapZone, SetMapToCurrentZone = UnitPosition, GetCurrentMapDungeonLevel, GetMapInfo, GetCurrentMapZone, SetMapToCurrentZone
local GetSpecialization, GetSpecializationInfo, GetSpecializationInfoByID = GetSpecialization, GetSpecializationInfo, GetSpecializationInfoByID
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local GetPartyAssignment, UnitGroupRolesAssigned, UnitIsGroupLeader, UnitIsGroupAssistant, UnitRealmRelationship = GetPartyAssignment, UnitGroupRolesAssigned, UnitIsGroupLeader, UnitIsGroupAssistant, UnitRealmRelationship
local LoadAddOn, GetAddOnInfo, GetAddOnEnableState, GetAddOnMetadata, GetNumAddOns = LoadAddOn, GetAddOnInfo, GetAddOnEnableState, GetAddOnMetadata, GetNumAddOns
local PlaySoundFile, PlaySound = PlaySoundFile, PlaySound
local Ambiguate = Ambiguate

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

-- automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
local function sendSync(prefix, msg)
	msg = msg or ""
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() and not C_Garrison:IsOnGarrisonMap() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
		SendAddonMessage("D4", prefix .. "\t" .. msg, "INSTANCE_CHAT")
	else
		if IsInRaid() then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "PARTY")
		else--for solo raid
			SendAddonMessage("D4", prefix .. "\t" .. msg, "WHISPER", playerName)
		end
	end
end

local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time)
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
		cap = Ambiguate(cap, "short")
	end
	return cap
end

local function countDownTextDelay(timer)
	TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
end

--------------
--  Events  --
--------------
do
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
			if handler and (not isUnitEvent or not modEvents or modEvents[event .. ...])  and (not zones or zones[LastInstanceMapID]) and not (v.isTrashMod and IsEncounterInProgress()) then
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
			end
			if spellId and not GetSpellInfo(spellId) then
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
			if event:sub(0, 6) == "SPELL_" or event:sub(0, 6) == "RANGE_" then
				registerCLEUEvent(self, event)
			else
				local eventWithArgs = event
				-- unit events need special care
				if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
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

	function DBM:UnregisterInCombatEvents(srmOnly)
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
			elseif (event:sub(0, 6) == "SPELL_" or event:sub(0, 6) == "RANGE_") then
				local i = 1
				while mods[i] do
					if mods[i] == self and event ~= "SPELL_AURA_REMOVED" then
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
		if self.shortTermEventsRegistered then
			return
		end
		self.shortTermRegisterEvents = {...}
		for k, v in pairs(self.shortTermRegisterEvents) do
			if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
				-- legacy event, oh noes
				self.shortTermRegisterEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
			end
		end
		self.shortTermEventsRegistered = 1
		self:RegisterEvents(unpack(self.shortTermRegisterEvents))
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
		SPELL_PERIODIC_MISSED = true,
		SPELL_PERIODIC_DAMAGE = true,
		SPELL_PERIODIC_DRAIN = true,
		SPELL_PERIODIC_LEECH = true,
		SPELL_PERIODIC_ENERGIZE = true,
		SPELL_DRAIN = true,
		SPELL_LEECH = true
	}
	function DBM:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
		if not registeredEvents[event] then return end
		local eventSub6 = event:sub(0, 6)
		if (eventSub6 == "SPELL_" or eventSub6 == "RANGE_") and not unfilteredCLEUEvents[event] then
			local spellId = ...
			if not registeredSpellIds[event][spellId] then return end
		end
		-- process some high volume events without building the whole table which is somewhat faster
		-- this prevents work-around with mods that used to have their own event handler to prevent this overhead
		if noArgTableEvents[event] then
			return handleEvent(nil, event, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
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
				args.spellId, args.spellName = ...
				if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" or event == "SPELL_AURA_REMOVED" then
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
					local _
					_, _, _, _, args.amount = ...
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_INTERRUPT" or event == "SPELL_DISPEL" or event == "SPELL_DISPEL_FAILED" or event == "SPELL_AURA_STOLEN" then
					local _
					_, _, _, args.extraSpellId, args.extraSpellName = ...
				end
			elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "ENVIRONMENTAL_DAMAGE" then
				args.environmentalType, args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = ...
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
			isLoaded = true
			for i, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			loadOptions()
--			if not GetAddOnEnableState then--Not 6.0
--				self:AddMsg(DBM_CORE_UPDATEREMINDER_MAJORPATCH)
--				return
--			end
			if GetAddOnEnableState(playerName, "VEM-Core") >= 1 then
				self:AddMsg(DBM_CORE_VEM)
				dbmIsEnabled = false
				return
			end
			if GetAddOnEnableState(playerName, "DBM-Profiles") >= 1 then
				self:Schedule(10, function() self:AddMsg(DBM_CORE_3RDPROFILES) end)
				dbmIsEnabled = false
				return
			end
			self.Bars:LoadOptions("DBM")
			self.Arrow:LoadPosition()
			if not self.Options.ShowMinimapButton then self:HideMinimapButton() end
			local soundChannels = tonumber(GetCVar("Sound_NumChannels")) or 24--if set to 24, may return nil, Defaults usually do
			if soundChannels < 64 then
				SetCVar("Sound_NumChannels", 64)
			end
			self.AddOns = {}
			self.Voices = { {text = "None",value  = "None"}, }--Create voice table, with default "None" value
			self.VoiceVersions = {}
			for i = 1, GetNumAddOns() do
				local addonName = GetAddOnInfo(i)
				local enabled = GetAddOnEnableState(playerName, i)
				if GetAddOnMetadata(i, "X-DBM-Mod") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						self:AddMsg("The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local mapIdTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-MapID") or "")}
						tinsert(self.AddOns, {
							sort			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or mhuge) or mhuge,
							type			= GetAddOnMetadata(i, "X-DBM-Mod-Type") or "OTHER",
							category		= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
							name			= GetAddOnMetadata(i, "X-DBM-Mod-Name") or GetRealZoneText(tonumber(mapIdTable[1])) or "Unknown",
							mapId			= mapIdTable,
							subTabs			= GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID"))} or GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
							oneFormat		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Single-Format") or 0) == 1,
							hasLFR			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-LFR") or 0) == 1,
							hasChallenge	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Challenge") or 0) == 1,
							noHeroic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Heroic") or 0) == 1,
							noStatistics	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Statistics") or 0) == 1,
							hasMythic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Mythic") or 0) == 1,
							isWorldBoss		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-World-Boss") or 0) == 1,
							minRevision		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-MinCoreRevision") or 0),
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
							for k, v in ipairs(self.AddOns[#self.AddOns].subTabs) do
								local id = tonumber(self.AddOns[#self.AddOns].subTabs[k])
								if id then
									self.AddOns[#self.AddOns].subTabs[k] = GetRealZoneText(id):trim()
								else
									self.AddOns[#self.AddOns].subTabs[k] = (self.AddOns[#self.AddOns].subTabs[k]):trim()
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
				end
				if GetAddOnMetadata(i, "X-DBM-Voice") and enabled ~= 0 then
					if checkEntry(bannedMods, addonName) then
						self:AddMsg("The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message. Check for an updated version of " .. addonName .. " that is compatible with your game version.")
					else
						local voiceValue = GetAddOnMetadata(i, "X-DBM-Voice-ShortName")
						local voiceVersion = tonumber(GetAddOnMetadata(i, "X-DBM-Voice-Version") or 0)
						if voiceVersion > 0 then--Do not insert voice version 0 into THIS table. 0 should be used by voice packs that insert only countdown
							tinsert(self.Voices, { text = GetAddOnMetadata(i, "X-DBM-Voice-Name"), value = voiceValue })
						end
						self.VoiceVersions[voiceValue] = voiceVersion
						self:Schedule(10, self.CheckVoicePackVersion, self, voiceValue)--Still at 1 since the count sounds won't break any mods or affect filter. V2 if support countsound path
						if GetAddOnMetadata(i, "X-DBM-Voice-HasCount") then--Supports adding countdown options, insert new countdown into table
							tinsert(self.Counts, { text = GetAddOnMetadata(i, "X-DBM-Voice-Name"), value = "VP:"..voiceValue })
						end
					end
				end
				self:Schedule(8, self.CheckVoicePackAvailable, self)
			end
			tsort(self.AddOns, function(v1, v2) return v1.sort < v2.sort end)
			self:RegisterEvents(
				"COMBAT_LOG_EVENT_UNFILTERED",
				"GROUP_ROSTER_UPDATE",
				"INSTANCE_GROUP_SIZE_CHANGED",
				"CHAT_MSG_ADDON",
				"BN_CHAT_MSG_ADDON",
				"PLAYER_REGEN_DISABLED",
				"PLAYER_REGEN_ENABLED",
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
				"UNIT_TARGETABLE_CHANGED",
				"UNIT_SPELLCAST_SUCCEEDED",
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
				"LFG_LIST_APPLICANT_LIST_UPDATED",
				"UPDATE_BATTLEFIELD_STATUS",
				"CINEMATIC_START",
				"PLAYER_LEVEL_UP",
				"CHALLENGE_MODE_START",
				"CHALLENGE_MODE_RESET",
				"CHALLENGE_MODE_END",
				"ACTIVE_TALENT_GROUP_CHANGED",
				"UPDATE_SHAPESHIFT_FORM",
				"PARTY_INVITE_REQUEST",
				"LOADING_SCREEN_DISABLED",
				"SCENARIO_CRITERIA_UPDATE"
			)
			RolePollPopup:UnregisterEvent("ROLE_POLL_BEGIN")
			self:GROUP_ROSTER_UPDATE()
			--self:LOADING_SCREEN_DISABLED()--Initial testing shows it isn't needed here and wastes cpu running funcion twice, because actual event always fires at login, AFTER addonloadded. Will remove this line if it works out ok
			self:Schedule(1.5, function()
				combatInitialized = true
			end)
			self:Schedule(20, function()--Delay UNIT_HEALTH combat start for 20 sec. (not to break Timer Recovery stuff)
				healthCombatInitialized = true
			end)
			if IsInGroup() then
				self:Schedule(15, self.RequestTimers, self)--Break timer recovery doesn't work if outside the zone when reloadui or relogging (no loadmod). Need request timer here.
			end
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

	function DBM:RegisterCallback(event, f)
		if not event or type(f) ~= "function" then
			error("Usage: DBM:RegisterCallback(event, callbackFunc)", 2)
		end
		callbacks[event] = callbacks[event] or {}
		tinsert(callbacks[event], f)
		return #callbacks[event]
	end

	function DBM:UnregisterCallback(event)
		if not event or not callbacks[event] then return end
		callbacks[event] = nil
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
	
	local nextModSyncSpamUpdate = 0
	mainFrame:SetScript("OnUpdate", function(self, elapsed)
		local time = GetTime()
		cachedGetTime = time

		-- execute scheduled tasks
		local nextTask = getMin()
		while nextTask and nextTask.func and nextTask.time <= time do
			deleteMin()
			nextTask.func(unpack(nextTask))
			pushCachedTable(nextTask)
			nextTask = getMin()
		end

		-- execute OnUpdate handlers of all modules
		for i, v in pairs(updateFunctions) do
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
	end)

	function schedule(t, f, mod, ...)
		if type(f) ~= "function" then
			error("usage: schedule(time, func, [mod, args...])", 2)
		end
		local v
		if numChachedTables > 0 and select("#", ...) <= 4 then -- a cached table is available and all arguments fit into an array with four slots
			v = popCachedTable()
			v.time = GetTime() + t
			v.func = f
			v.mod = mod
			for i = 1, select("#", ...) do
				v[i] = select(i, ...)
			end
		else -- create a new table
			v = {time = GetTime() + t, func = f, mod = mod, ...}
		end
		insert(v)
	end

	function unschedule(f, mod, ...)
		return removeAllMatching(f, mod, ...)
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

function DBM:ForceUpdate()
	mainFrame:GetScript("OnUpdate")(mainFrame, 0)
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
	self:SetRaidWarningPositon()
	self:UpdateWarningOptions()
	self:UpdateSpecialWarningOptions()
	self.Arrow:LoadPosition()
	if DBMBossHealth then
		DBMBossHealth:ClearAllPoints()
		DBMBossHealth:SetPoint(self.Options.HPFramePoint, UIParent, self.Options.HPFramePoint, self.Options.HPFrameX, self.Options.HPFrameY)
	end
	if DBMRangeCheck then
		DBMRangeCheck:ClearAllPoints()
		DBMRangeCheck:SetPoint(self.Options.RangeFramePoint, UIParent, self.Options.RangeFramePoint, self.Options.RangeFrameX, self.Options.RangeFrameY)
	end
	if DBMRangeCheckRadar then
		DBMInfoFrame:ClearAllPoints()
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
SLASH_DEADLYBOSSMODS1 = "/dbm"
SlashCmdList["DEADLYBOSSMODS"] = function(msg)
	local cmd = msg:lower()
	if cmd == "ver" or cmd == "version" then
		DBM:ShowVersions(false)
	elseif cmd == "ver2" or cmd == "version2" then
		DBM:ShowVersions(true)
	elseif cmd == "unlock" or cmd == "move" then
		DBM.Bars:ShowMovableBar()
	elseif cmd == "help" then
		for i, v in ipairs(DBM_CORE_SLASHCMD_HELP) do DBM:AddMsg(v) end
	elseif cmd:sub(1, 13) == "timer endloop" then
		DBM:CreatePizzaTimer(time, "", nil, nil, nil, nil, true)
	elseif cmd:sub(1, 5) == "timer" then
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
		DBM:CreatePizzaTimer(time, text)
	elseif cmd:sub(1, 6) == "ctimer" then
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
		DBM:CreatePizzaTimer(time, text, nil, nil, nil, true)
	elseif cmd:sub(1, 7) == "cltimer" then
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
		DBM:CreatePizzaTimer(time, text, nil, nil, true, true)
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
	elseif cmd:sub(1, 16) == "broadcast ctimer" then
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
		DBM:CreatePizzaTimer(time, text, permission, nil, nil, true)
	elseif cmd:sub(1, 17) == "broadcast cltimer" then
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
		DBM:CreatePizzaTimer(time, text, permission, nil, true, true)
	elseif cmd:sub(0,5) == "break" then
		if IsInGroup() and (DBM:GetRaidRank(playerName) == 0 or IsPartyLFG()) or IsEncounterInProgress() then--No break timers if not assistant or if it's dungeon/raid finder
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			return
		end
		local timer = tonumber(cmd:sub(6)) or 5
		local timer = timer * 60
		sendSync("BT", timer)
	elseif cmd:sub(1, 4) == "pull" then
		if (DBM:GetRaidRank(playerName) == 0 and IsInGroup()) or IsEncounterInProgress() then
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		local timer = tonumber(cmd:sub(5)) or 10
		sendSync("PT", timer.."\t"..LastInstanceMapID)
	elseif cmd:sub(1, 3) == "lag" then
		sendSync("L")
		DBM:AddMsg(DBM_CORE_LAG_CHECKING)
		DBM:Schedule(5, function() DBM:ShowLag() end)
	elseif cmd:sub(1, 5) == "arrow" then
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
		local x, y, _, map = UnitPosition("player")
		SetMapToCurrentZone()
		local mapID = GetCurrentMapAreaID()
		local mapx, mapy = GetPlayerMapPosition("player")
		DBM:AddMsg(("Location Information\nYou are at zone %u (%s): x=%f, y=%f.\nLocal Map ID %u (%s): x=%f, y=%f"):format(map, GetRealZoneText(map), x, y, mapID, GetZoneText(), mapx, mapy))
	else
		DBM:LoadGUI()
	end
end

do
	local function updateRangeFrame(r, reverse)
		if DBM.RangeCheck:IsShown() then
			DBM.RangeCheck:Hide(true)
		else
			if r and (r < 201) then
				DBM.RangeCheck:Show(r, nil, true, nil, reverse)
			else
				DBM.RangeCheck:Show(10, nil, true, nil, reverse)
			end
		end
	end
	SLASH_DBMRANGE1 = "/range"
	SLASH_DBMRANGE2 = "/distance"
	SLASH_DBMRRANGE1 = "/rrange"
	SLASH_DBMRRANGE2 = "/rdistance"
	SlashCmdList["DBMRANGE"] = function(msg)
		local r = tonumber(msg)
		updateRangeFrame(r, false)
	end
	SlashCmdList["DBMRRANGE"] = function(msg)
		local r = tonumber(msg)
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
			return (v1.bwarevision or v1.bwrevision or 0) > (v2.bwarevision or v2.bwrevision or 0)
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
			if v.displayVersion and not (v.bwrevision or v.bwarevision) then--DBM, no BigWigs
				if self.Options.ShowAllVersions then
					self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(name, "DBM "..v.displayVersion, v.revision, v.VPVersion or ""), false)--Only display VP version if not running two mods
				end
				if notify and v.revision < self.ReleaseRevision then
					SendChatMessage(chatPrefixShort..DBM_CORE_YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
				end
			elseif self.Options.ShowAllVersions and (v.displayVersion and (v.bwrevision or v.bwarevision)) then--DBM & BigWigs
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY_TWO:format(name, "DBM "..v.displayVersion, v.revision, v.bwarevision and DBM_BIG_WIGS_ALPHA or DBM_BIG_WIGS, v.bwarevision or v.bwrevision), false)
			elseif self.Options.ShowAllVersions and (not v.displayVersion and (v.bwrevision or v.bwarevision)) then--BigWigs, No DBM
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(name, v.bwarevision and DBM_BIG_WIGS_ALPHA or DBM_BIG_WIGS, v.bwarevision or v.bwrevision, ""), false)
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
			if not (sortMe[i].bwarevision or sortMe[i].bwrevision) then
				NoBigwigs = NoBigwigs + 1
			end
			--Table sorting sorts dbm to top, bigwigs underneath. Highest version dbm always at top. so sortMe[1]
			--This check compares all dbm version to highest RELEASE version in raid.
			if sortMe[i].revision and (sortMe[i].revision < sortMe[1].version) or sortMe[i].bwrevision and (sortMe[i].bwrevision < fakeBWRevision) then
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
		self:AddMsg(DBM_CORE_VERSIONCHECK_OUTDATED:format(OldMod, #OutdatedUsers > 0 and table.concat(OutdatedUsers, ", ") or NONE), false)
		twipe(OutdatedUsers)
		twipe(sortMe)
		for i = #sortMe, 1, -1 do
			sortMe[i] = nil
		end
	end
end

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
			self:AddMsg(DBM_CORE_LAG_FOOTER:format(table.concat(nolagResponse, ", ")), false)
			for i = #nolagResponse, 1, -1 do
				nolagResponse[i] = nil
			end
		end
		for i = #sortLag, 1, -1 do
			sortLag[i] = nil
		end
	end
end

-------------------
--  Pizza Timer  --
-------------------
do
	
	local function loopTimer(time, text, broadcast, sender, count)
		DBM:CreatePizzaTimer(time, text, broadcast, sender, count, true)
	end

	local ignore = {}
	local fakeMod -- dummy mod for the count sound effects
	--Standard Pizza Timer
	function DBM:CreatePizzaTimer(time, text, broadcast, sender, count, loop, terminate)
		if terminate then
			self:Unschedule(loopTimer)
			return
		end
		if sender and ignore[sender] then return end
		text = text:sub(1, 16)
		text = text:gsub("%%t", UnitName("target") or "<no target>")
		if time < 2 then
			self:AddMsg(DBM_PIZZA_ERROR_USAGE)
			return
		end
		self.Bars:CreateBar(time, text, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		if broadcast then
			if count then
				sendSync("CU", ("%s\t%s"):format(time, text))
			else
				sendSync("U", ("%s\t%s"):format(time, text))
			end
		end
		if sender then self:ShowPizzaInfo(text, sender) end
		if count then
			if not fakeMod then
				fakeMod = self:NewMod("CreateCountTimerDummy")
				self:GetModLocalization("CreateCountTimerDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
				fakeMod.countdown = fakeMod:NewCountdown(0, 0, nil, nil, nil, true)
			end
			if not self.Options.DontPlayPTCountdown then
				fakeMod.countdown:Cancel()
				fakeMod.countdown:Start(time)
			end
			if not self.Options.DontShowPTCountdownText then
				self:Unschedule(countDownTextDelay)
				TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
				local threshold = DBM.Options.PTCountThreshold
				if time > threshold then
					self:Schedule(time-threshold, countDownTextDelay, threshold)
				else
					TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, time, time)
				end
			end
		end
		if loop then
			self:Unschedule(loopTimer)--Only one loop timer supported at once doing this, but much cleaner this way
			self:Schedule(time, loopTimer, time, text, broadcast, sender, count)
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

------------------
--  Hyperlinks  --
------------------
do
	local ignore, cancel
	local popuplevel = 0
	local function showPopupConfirmIgnore(ignore, cancel)
		local popup = CreateFrame("Frame", "DBMHyperLinks", UIParent)
		popup:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = {left = 1, right = 1, top = 1, bottom = 1}}
		)
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
		text:SetText(DBM_PIZZA_CONFIRM_IGNORE:format(ignore))

		local accept = CreateFrame("Button", nil, popup)
		accept:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		accept:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		accept:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		accept:SetSize(128, 35)
		accept:SetPoint("BOTTOM", popup, "BOTTOM", -75, 0)
		accept:SetScript("OnClick", function(f) DBM:AddToPizzaIgnore(ignore) DBM.Bars:CancelBar(cancel) f:GetParent():Hide() end)

		local atext = accept:CreateFontString()
		atext:SetFontObject(ChatFontNormal)
		atext:SetPoint("CENTER", accept, "CENTER", 0, 5)
		atext:SetText(YES)

		local decline = CreateFrame("Button", nil, popup)
		decline:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		decline:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		decline:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		decline:SetSize(128, 35)
		decline:SetPoint("BOTTOM", popup, "BOTTOM", 75, 0)
		decline:SetScript("OnClick", function(f) f:GetParent():Hide() end)

		local dtext = decline:CreateFontString()
		dtext:SetFontObject(ChatFontNormal)
		dtext:SetPoint("CENTER", decline, "CENTER", 0, 5)
		dtext:SetText(NO)
		PlaySound("igMainMenuOpen")
	end

	local function linkHook(self, link, string, button, ...)
		local linkType, arg1, arg2, arg3 = strsplit(":", link)
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
		elseif arg1 == "forums" then
			DBM:ShowUpdateReminder(nil, nil, DBM_FORUMS_COPY_URL_DIALOG)
		elseif arg1 == "showRaidIdResults" then
			DBM:ShowRaidIDRequestResults()
		end
	end

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
		if link:sub(0, 4) == "DBM:" then
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
--		if not GetAddOnEnableState then--Not 6.0
--			DBM:AddMsg(DBM_CORE_UPDATEREMINDER_MAJORPATCH)
--			return
--		end
		if GetAddOnEnableState(playerName, "VEM-Core") >= 1 then
			self:AddMsg(DBM_CORE_VEM)
			dbmIsEnabled = false
			return
		end
		if GetAddOnEnableState(playerName, "DBM-Profiles") >= 1 then
			self:AddMsg(DBM_CORE_3RDPROFILES)
			dbmIsEnabled = false
			return
		end
		if not IsAddOnLoaded("DBM-GUI") then
			if InCombatLockdown() then
				guiRequested = true
				self:AddMsg(DBM_CORE_LOAD_GUI_COMBAT)
				return
			end
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
			collectgarbage("collect")
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
	local dragMode = nil

	local function moveButton(self)
		if dragMode == "free" then
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", x, y)
		else
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			centerX, centerY = math.abs(x), math.abs(y)
			centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
			centerX = x < 0 and -centerX or centerX
			centerY = y < 0 and -centerY or centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", centerX, centerY)
		end
	end

	local button = CreateFrame("Button", "DBMMinimapButton", Minimap)
	button:SetHeight(32)
	button:SetWidth(32)
	button:SetFrameStrata("MEDIUM")
	button:SetPoint("CENTER", -65.35, -38.8)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:SetNormalTexture("Interface\\AddOns\\DBM-Core\\textures\\Minimap-Button-Up")
	button:SetPushedTexture("Interface\\AddOns\\DBM-Core\\textures\\Minimap-Button-Down")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	button:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and IsAltKeyDown() then
			dragMode = "free"
			self:SetScript("OnUpdate", moveButton)
		elseif IsShiftKeyDown() or button == "RightButton" then
			dragMode = nil
			self:SetScript("OnUpdate", moveButton)
		end
	end)
	button:SetScript("OnMouseUp", function(self)
		self:SetScript("OnUpdate", nil)
	end)
	button:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() or button == "RightButton" then return end
		DBM:LoadGUI()
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(DBM_CORE_MINIMAP_TOOLTIP_HEADER, 1, 1, 1)
		GameTooltip:AddLine(ver, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DBM_CORE_MINIMAP_TOOLTIP_FOOTER, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b, 1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	function DBM:ToggleMinimapButton()
		self.Options.ShowMinimapButton = not self.Options.ShowMinimapButton
		if self.Options.ShowMinimapButton then
			button:Show()
		else
			button:Hide()
		end
	end

	function DBM:HideMinimapButton()
		return button:Hide()
	end
end

-------------------------------------------------
--  Raid/Party Handling and Unit ID Utilities  --
-------------------------------------------------
do
	local inRaid = false

	local raidUIds = {}
	local raidGuids = {}
	local iconSeter = {}

	--	save playerinfo into raid table on load. (for solo raid)
	DBM:RegisterOnLoadCallback(function()
		DBM:Schedule(5, function()
			if not raid[playerName] then
				raid[playerName] = {}
				raid[playerName].name = playerName
				raid[playerName].shortname = playerName
				raid[playerName].guid = UnitGUID("player")
				raid[playerName].rank = 0
				raid[playerName].class = class
				raid[playerName].id = "player"
				raid[playerName].revision = DBM.Revision
				raid[playerName].version = tonumber(DBM.Version)
				raid[playerName].displayVersion = DBM.DisplayVersion
				raid[playerName].locale = GetLocale()
				raid[playerName].enabledIcons = tostring(not DBM.Options.DontSetIcons)
				raidUIds["player"] = playerName
				raidGuids[UnitGUID("player")] = playerName
			end
		end)
	end)

	local function updateAllRoster()
		if IsInRaid() then
			if not inRaid then
				inRaid = true
				sendSync("H")
				SendAddonMessage("BigWigs", "VQ:0", IsPartyLFG() and "INSTANCE_CHAT" or "RAID")--Basically "H" to bigwigs. Tell Bigwigs users we joined raid. Send revision of 0 so bigwigs ignores revision but still replies with their version information
				DBM:Schedule(2, DBM.RoleCheck, false, DBM)
				fireEvent("raidJoin", playerName)
				if BigWigs and BigWigs.db.profile.raidicon and not DBM.Options.DontSetIcons then--Both DBM and bigwigs have raid icon marking turned on.
					DBM:AddMsg(DBM_CORE_BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either ore turned off to stop this alert)
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
						fireEvent("raidJoin", name)
					end
					raid[name] = raid[name] or {}
					raid[name].name = name
					raid[name].shortname = shortname
					raid[name].rank = rank
					raid[name].subgroup = subgroup
					raid[name].class = className
					raid[name].id = id
					raid[name].guid = UnitGUID(id) or ""
					raid[name].updated = true
					raidUIds[id] = name
					raidGuids[UnitGUID(id) or ""] = name
				end
			end
			enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidUIds[v.id] = nil
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					fireEvent("raidLeave", i)
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
				SendAddonMessage("BigWigs", "VQ:0", IsPartyLFG() and "INSTANCE_CHAT" or "PARTY")
				DBM:Schedule(2, DBM.RoleCheck, false, DBM)
				fireEvent("partyJoin", playerName)
			end
			for i = 0, GetNumSubgroupMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party"..i
				end
				local name, server = UnitName(id)
				local shortname = name
				local rank, _, className = UnitIsGroupLeader(id), UnitClass(id)
				if server and server ~= ""  then
					name = name.."-"..server
				end
				if (not raid[name]) and inRaid then
					fireEvent("partyJoin", name)
				end
				raid[name] = raid[name] or {}
				raid[name].name = name
				raid[name].shortname = shortname
				raid[name].guid = UnitGUID(id) or ""
				if rank then
					raid[name].rank = 2
				else
					raid[name].rank = 0
				end
				raid[name].class = className
				raid[name].id = id
				raid[name].updated = true
				raidUIds[id] = name
				raidGuids[UnitGUID(id) or ""] = name
			end
			enableIcons = false
			twipe(iconSeter)
			for i, v in pairs(raid) do
				if not v.updated then
					raidUIds[v.id] = nil
					raidGuids[v.guid] = nil
					raid[i] = nil
					removeEntry(newerVersionPerson, i)
					fireEvent("partyLeave", i)
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
			fireEvent("raidLeave", playerName)
			twipe(raid)
			twipe(newerVersionPerson)
			-- restore playerinfo into raid table on raidleave. (for solo raid)
			raid[playerName] = {}
			raid[playerName].name = playerName
			raid[playerName].shortname = playerName
			raid[playerName].guid = UnitGUID("player")
			raid[playerName].rank = 0
			raid[playerName].class = class
			raid[playerName].id = "player"
			raid[playerName].revision = DBM.Revision
			raid[playerName].version = tonumber(DBM.Version)
			raid[playerName].displayVersion = DBM.DisplayVersion
			raid[playerName].locale = GetLocale()
			raidUIds["player"] = playerName
			raidGuids[UnitGUID("player")] = playerName
		end
	end

	--This local function called if uId is not player's uId. (like target, raid1traget)
	local function getUnitFullName(uId)
		if not uId then return end
		local name, server = UnitName(uId)
		if not name then return end
		if server and server ~= ""  then
			name = name.."-"..server
		end
		return name
	end

	function DBM:GROUP_ROSTER_UPDATE()
		self:Schedule(1.5, updateAllRoster)
	end
	
	function DBM:INSTANCE_GROUP_SIZE_CHANGED()
		local _, _, _, _, _, _, _, _, instanceGroupSize = GetInstanceInfo()
		LastGroupSize = instanceGroupSize
	end

	function DBM:GetRaidRank(name)
		local name = name or playerName
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
		return raid[name] and raid[name].id
	end

	function DBM:GetUnitFullName(uId)
		return raidUIds[uId] or getUnitFullName(uId)
	end

	function DBM:GetFullPlayerNameByGUID(guid)
		return raidGuids[guid]
	end

	function DBM:GetPlayerNameByGUID(guid)
		return raidGuids[guid] and raidGuids[guid]:gsub("%-.*$", "")
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
--It should work for pretty much any case we'd use it though except maybe a fight like heroic LK? TODO: check this
function DBM:GetNumRealGroupMembers()
	if not IsInInstance() then--Not accurate outside of instances (such as world bosses)
		return IsInGroup() and GetNumGroupMembers() or 1--So just return regular group members.
	end
	local currentMapId = select(4, UnitPosition("player"))
	local realGroupMembers = 0
	if IsInGroup() then
		for uId in self:GetGroupMembers() do
			if select(4, UnitPosition(uId)) == currentMapId then
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
	return DBM:GetCIDFromGUID(guid)
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

function DBM:GetBossUnitId(name)
	for i = 1, 5 do
		if UnitName("boss" .. i) == name then
			return "boss" .. i
		end
	end
	for uId in self:GetGroupMembers() do
		if UnitName(uId .. "target") == name and not UnitIsPlayer(uId .. "target") then
			return uId .. "target"
		end
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

function DBM:SetRaidWarningPositon()
	RaidWarningFrame:ClearAllPoints()
	RaidWarningFrame:SetPoint(self.Options.RaidWarningPosition.Point, UIParent, self.Options.RaidWarningPosition.Point, self.Options.RaidWarningPosition.X, self.Options.RaidWarningPosition.Y)
end

function DBM:LoadModOptions(modId, inCombat, first)
	local oldSavedVarsName = modId:gsub("-", "").."_SavedVars"
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local savedStatsName = modId:gsub("-", "").."_SavedStats"
	local fullname = playerName.."-"..playerRealm
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
			self:Debug("LoadModOptions: Found old options, importing")
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
						savedOptions[id][profileNum][option] = mod.DefaultOptions[option].value
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
			stats.mythicKills = stats.mythicKills or 0
			stats.mythicPulls = stats.mythicPulls or 0
			stats.normal25Kills = stats.normal25Kills or 0
			stats.normal25Kills = stats.normal25Kills or 0
			stats.normal25Pulls = stats.normal25Pulls or 0
			stats.heroic25Kills = stats.heroic25Kills or 0
			stats.heroic25Pulls = stats.heroic25Pulls or 0
			stats.lfr25Kills = stats.lfr25Kills or 0
			stats.lfr25Pulls = stats.lfr25Pulls or 0
			mod.stats = stats
			--run OnInitialize function
			if mod.OnInitialize then mod:OnInitialize() end
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
		_G[savedVarsName][fullname]["talent"..profileNum] = profileNum == 3 and gladStance or currentSpecName
		self:Debug("LoadModOptions: Finished loading ".._G[savedVarsName][fullname]["talent"..profileNum])
	end
	_G[savedStatsName] = savedStats
	if not first and DBM_GUI and DBM_GUI.currentViewing and DBM_GUI_OptionsFrame:IsShown() then
		DBM_GUI_OptionsFrame:DisplayFrame(DBM_GUI.currentViewing)
	end
end

function DBM:SpecChanged(force)
	if not force and not DBM_UseDualProfile then return end
	--Load Options again.
	for modId, idTable in pairs(DBM.ModLists) do
		self:LoadModOptions(modId)
	end
end

function DBM:PLAYER_LEVEL_UP()
	playerLevel = UnitLevel("player")
	self:SpecChanged()
end

function DBM:LoadAllModDefaultOption(modId)
	-- modId is string like "DBM-Highmaul"
	if not modId or not DBM.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID then
		self:SetCurrentSpecInfo()
	end
	-- variable init
	local savedVarsName = modId:gsub("-", "").."_AllSavedVars"
	local fullname = playerName.."-"..playerRealm
	local profileNum = playerLevel > 9 and DBM_UseDualProfile and currentSpecGroup or 0
	-- prevent nil table error 
	if not _G[savedVarsName] then _G[savedVarsName] = {} end
	for i, id in ipairs(DBM.ModLists[modId]) do
		-- prevent nil table error 
		if not _G[savedVarsName][fullname][id] then _G[savedVarsName][fullname][id] = {} end
		-- actual do load default option
		local mod = DBM:GetModByName(id)
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
		_G[savedVarsName][fullname][id][profileNum] = defaultOptions
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
	if not currentSpecID then
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
	_G[savedVarsName][fullname][mod.id][profileNum] = defaultOptions
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
	if not currentSpecID then
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
	for i, id in ipairs(DBM.ModLists[modId]) do
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
		local mod = DBM:GetModByName(id)
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

function DBM:CopyAllModSoundOption(modId, sourceName, sourceProfile)
	-- modId is string like "DBM-Highmaul"
	if not modId or not sourceName or not sourceProfile or not DBM.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID then
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
	for i, id in ipairs(DBM.ModLists[modId]) do
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
			if option:find("SpecialWarningSound") then
				_G[savedVarsName][targetName][id][targetProfile][option] = optionValue
			end
		end
		-- apply to options table
		local mod = DBM:GetModByName(id)
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
	if not modId or not name or not profile or not DBM.ModLists[modId] then return end
	-- prevent error
	if not currentSpecID then
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
	for i, id in ipairs(DBM.ModLists[modId]) do
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
	if not modId or not DBM.ModLists[modId] then return end
	-- variable init
	local savedStatsName = modId:gsub("-", "").."_SavedStats"
	-- prevent nil table error 
	if not _G[savedStatsName] then _G[savedStatsName] = {} end
	for i, id in ipairs(DBM.ModLists[modId]) do
		local mod = self:GetModByName(id)
		-- prevent nil table error
		local defaultStats = {}
		defaultStats.normalKills = 0
		defaultStats.normalPulls = 0
		defaultStats.heroicKills = 0
		defaultStats.heroicPulls = 0
		defaultStats.challengeKills = 0
		defaultStats.challengePulls = 0
		defaultStats.mythicKills = 0
		defaultStats.mythicPulls = 0
		defaultStats.normal25Kills = 0
		defaultStats.normal25Kills = 0
		defaultStats.normal25Pulls = 0
		defaultStats.heroic25Kills = 0
		defaultStats.heroic25Pulls = 0
		defaultStats.lfr25Kills = 0
		defaultStats.lfr25Pulls = 0
		mod.stats = {}
		mod.stats = defaultStats
		_G[savedStatsName][id] = {}
		_G[savedStatsName][id] = defaultStats
	end
	self:AddMsg(DBM_CORE_ALLMOD_STATS_RESETED)
	DBM_GUI:UpdateModList()
end

do
	function loadOptions()
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
		DBM.Options = DBM_AllSavedOptions[usedProfile] or {}
		dbmIsEnabled = DBM.Options.Enabled or true
		DBM:AddDefaultOptions(DBM.Options, DBM.DefaultOptions)
		DBM_AllSavedOptions[usedProfile] = DBM.Options

		-- load special warning options
		DBM:UpdateWarningOptions()
		DBM:UpdateSpecialWarningOptions()
		-- set this with a short delay to prevent issues with other addons also trying to do the same thing with another position ;)
		DBM:Schedule(5, DBM.SetRaidWarningPositon, DBM)
		DBM:Schedule(20, DBM.SetRaidWarningPositon, DBM)--A second attempt after we are sure all other mods are loaded, so we can work around issues with movemanything or other mods.
	end
end

do
	local lastLFGAlert = 0
	function DBM:LFG_ROLE_CHECK_SHOW()
		if not UnitIsGroupLeader("player") and self.Options.LFDEnhance and GetTime() - lastLFGAlert > 5 then
			PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")--Because regular sound uses SFX channel which is too low of volume most of time
			lastLFGAlert = GetTime()
		end
	end
end

function DBM:LFG_PROPOSAL_SHOW()
	self.Bars:CreateBar(40, DBM_LFG_INVITE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
	if self.Options.LFDEnhance then
		PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")--Because regular sound uses SFX channel which is too low of volume most of time
	end
end

function DBM:LFG_PROPOSAL_FAILED()
	self.Bars:CancelBar(DBM_LFG_INVITE)
end

function DBM:LFG_PROPOSAL_SUCCEEDED()
	self.Bars:CancelBar(DBM_LFG_INVITE)
end

do
	local function stopQueueButtonDelay()
		QueueStatusMinimapButton.EyeHighlightAnim:Stop()
	end
	function DBM:LFG_LIST_APPLICANT_LIST_UPDATED(hasNewPending, hasNewPendingWithData)
		if QueueStatusMinimapButton:IsShown() and (self.Options.HideApplicantAlerts == 2 and not UnitIsGroupLeader("player", LE_PARTY_CATEGORY_HOME)) or (self.Options.HideApplicantAlerts >= 1 and GetNumGroupMembers() == 40) then
			QueueStatusMinimapButton.EyeHighlightAnim:Stop()
			self:Unschedule(stopQueueButtonDelay)
			self:Schedule(1, stopQueueButtonDelay, self)
			QueueStatusMinimapButton.EyeHighlightAnim:Stop()--Force stop the animation loop
		end
	end
end

function DBM:ACTIVE_TALENT_GROUP_CHANGED()
	local lastSpecID = currentSpecID
	self:SetCurrentSpecInfo()
	if currentSpecID ~= lastSpecID then--Don't fire specchanged unless spec actually has changed.
		self:SpecChanged()
		if IsInGroup() then
			self:RoleCheck(false)
		end
	end
end

function DBM:UPDATE_SHAPESHIFT_FORM()
	if class == "WARRIOR" and self:AntiSpam(0.5, "STANCE") then--check for stance changes for prot warriors that might be specced into Gladiator Stance
		self:ACTIVE_TALENT_GROUP_CHANGED()
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
		if (IsInInstance() and not C_Garrison:IsOnGarrisonMap()) or GetLFGMode(1) or GetLFGMode(2) or GetLFGMode(3) or GetLFGMode(4) or GetLFGMode(5) then return end
		--First check realID
		if self.Options.AutoAcceptFriendInvite then
			local _, numBNetOnline = BNGetNumFriends()
			for i = 1, numBNetOnline do
				local presenceID, _, _, _, _, _, _, isOnline = BNGetFriendInfo(i)
				local friendIndex = BNGetFriendIndex(presenceID)--Check if they are on more than one client at once (very likely with new launcher)
				for i=1, BNGetNumFriendToons(friendIndex) do
					local _, toonName, client = BNGetFriendToonInfo(friendIndex, i)
					if toonName and client == BNET_CLIENT_WOW then--Check if toon name exists and if client is wow. If yes to both, we found right client
						if toonName == sender then--Now simply see if this is sender
							AcceptPartyInvite()
							return
						end
					end
				end
			end
		end
		--Second check guildies
		if self.Options.AutoAcceptGuildInvite then
			local totalMembers, numOnlineGuildMembers, numOnlineAndMobileMembers = GetNumGuildMembers()
			local scanTotal = GetGuildRosterShowOffline() and totalMembers or numOnlineAndMobileMembers
			for i=1, scanTotal do
				--At this time, it's not easy to tell an officer from a non officer
				--since a guild might have ranks 1-3 or even 1-4 be officers/leader while another might only be 1-2
				--therefor, this feature is just a "yes/no" for if sender is a guildy
				local name, rank, rankIndex = GetGuildRosterInfo(i)
				if not name then break end
				name = Ambiguate(name, "none")
				if sender == name then
					AcceptPartyInvite()
					return
				end
			end
		end
	end
end

function DBM:PLAYER_REGEN_ENABLED()
	if loadDelay then
		self:Debug("loadDelay is activating LoadMod again")
		self:LoadMod(loadDelay)
	end
	if loadDelay2 then
		self:Debug("loadDelay2 is activating LoadMod again")
		self:LoadMod(loadDelay2)
	end
	if guiRequested and not IsAddOnLoaded("DBM-GUI") then
		guiRequested = false
		self:LoadGUI()
	end
end

function DBM:UPDATE_BATTLEFIELD_STATUS()
	for i = 1, 2 do
		if GetBattlefieldStatus(i) == "confirm" then
			queuedBattlefield[i] = select(2, GetBattlefieldStatus(i))
			self.Bars:CreateBar(85, queuedBattlefield[i], "Interface\\Icons\\Spell_Holy_BorrowedTime")	-- need to confirm the timer
			if self.Options.LFDEnhance then
				PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")--Because regular sound uses SFX channel which is too low of volume most of time
			end
		elseif queuedBattlefield[i] then
			self.Bars:CancelBar(queuedBattlefield[i])
			queuedBattlefield[i] = nil
		end
	end
end

function DBM:CINEMATIC_START()
	if not IsInInstance() or C_Garrison:IsOnGarrisonMap() or self.Options.MovieFilter == "Never" then return end
	SetMapToCurrentZone()
	local currentFloor = GetCurrentMapDungeonLevel() or 0
	if self.Options.MovieFilter == "Block" or self.Options.MovieFilter == "AfterFirst" and self.Options.MoviesSeen[LastInstanceMapID..currentFloor] then
		CinematicFrame_CancelCinematic()
	else
		self.Options.MoviesSeen[LastInstanceMapID..currentFloor] = true
	end
end

function DBM:SCENARIO_CRITERIA_UPDATE()
	local _, currentStage, numStages = C_Scenario.GetInfo()
	if #inCombat > 0 and currentStage > numStages and C_Scenario.IsInScenario() then
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if v.inScenario then
				self:EndCombat(v)
			end
		end
	end
end

function DBM:CHALLENGE_MODE_START(mapID)
	self:Debug("CHALLENGE_MODE_START fired for mapID "..mapID)
	if self.Options.ChallengeBest == "None" then return end
	local maps = GetChallengeModeMapTable()--Hopefully this returns WoD CMs and not MoP ones. or maybe it returns all of them?
	for i = 1, 8 do--Either giong to be 8 for WoD, or 17 if it includes mop+wod
		local _, mapIDVerify = GetChallengeModeMapInfo(maps[i])--Even though we get mapid from CHALLENGE_MODE_START, we still need CM index since GetChallengeModeMapPlayerStats doesn't take mapID :\
		if mapID == mapIDVerify then
			local guildBest, realmBest = GetChallengeBestTime(mapID)
			local lastTime, bestTime, medal = GetChallengeModeMapPlayerStats(maps[i])
			if bestTime and DBM.Options.ChallengeBest == "Personal" then
				self.Bars:CreateBar(ceil(bestTime / 1000), DBM_SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
			elseif guildBest and DBM.Options.ChallengeBest == "Guild" then
				self.Bars:CreateBar(ceil(guildBest / 1000), DBM_SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
			elseif realmBest and DBM.Options.ChallengeBest == "Realm" then
				self.Bars:CreateBar(ceil(realmBest / 1000), DBM_SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
			end
			break
		end
	end
end

function DBM:CHALLENGE_MODE_RESET()
	self:Debug("CHALLENGE_MODE_RESET fired")
	if self.Options.ChallengeBest == "None" then return end
	if self.Bars:GetBar(DBM_SPEED_CLEAR_TIMER_TEXT) then
		self.Bars:CancelBar(DBM_SPEED_CLEAR_TIMER_TEXT)
	end
end

--This event may not exist at all in game, just combat log, will have to verify.
function DBM:CHALLENGE_MODE_END(mapID, success, medal, completionTime)
	self:Debug("CHALLENGE_MODE_END fired for mapID "..mapID)
	if self.Options.ChallengeBest == "None" then return end
	if self.Bars:GetBar(DBM_SPEED_CLEAR_TIMER_TEXT) then
		self.Bars:CancelBar(DBM_SPEED_CLEAR_TIMER_TEXT)
	end
end

function DBM:GetTime()
	return cachedGetTime
end

function DBM:GetCurrentArea()
	return LastInstanceMapID
end

function DBM:GetGroupSize()
	return LastGroupSize
end

--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
do
	local targetEventsRegistered = false
	local function FixForShittyComputers()
		timerRequestInProgress = false
		local _, instanceType, difficulty, _, _, _, _, mapID, instanceGroupSize = GetInstanceInfo()
		DBM:Debug("Instance Check fired with mapID "..mapID.." and difficulty "..difficulty)
		if LastInstanceMapID == mapID then
			DBM:Debug("No action taken because mapID hasn't changed since last check")
			return
		end--ID hasn't changed, don't waste cpu doing anything else (example situation, porting into garrosh phase 4 is a loading screen)
		LastInstanceMapID = mapID
		LastGroupSize = instanceGroupSize
		difficultyIndex = difficulty
		if instanceType == "none" or C_Garrison:IsOnGarrisonMap() then
			LastInstanceType = "none"
			if not targetEventsRegistered then
				DBM:RegisterShortTermEvents("UPDATE_MOUSEOVER_UNIT", "UNIT_TARGET_UNFILTERED", "SCENARIO_UPDATE")
				targetEventsRegistered = true
			end
		else
			LastInstanceType = instanceType
			if targetEventsRegistered then
				DBM:UnregisterShortTermEvents()
				targetEventsRegistered = false
			end
			if savedDifficulty == "worldboss" then
				for i = #inCombat, 1, -1 do
					DBM:EndCombat(inCombat[i], true)
				end
			end
		end
		-- LoadMod
		DBM:LoadModsOnDemand("mapId", mapID)
		if not DBM.Options.PGMessageShown and LastInstanceMapID == 1148 and not GetAddOnInfo("DBM-ProvingGrounds") then
			DBM.Options.PGMessageShown = true
			DBM:AddMsg(DBM_CORE_PROVINGGROUNDS_AD)
		elseif not DBM.Options.MCMessageShown and LastInstanceMapID == 409 and not GetAddOnInfo("DBM-MC") then
			DBM.Options.MCMessageShown = true
			DBM:AddMsg(DBM_CORE_MOLTENCORE_AD)
		end
	end
	--Faster and more accurate loading for instances, but useless outside of them
	function DBM:LOADING_SCREEN_DISABLED()
		self:Debug("LOADING_SCREEN_DISABLED fired")
		FixForShittyComputers()
		self:Unschedule(FixForShittyComputers)
		self:Schedule(5, FixForShittyComputers, DBM)
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
					self:Debug("Not loading "..v.name.." because it is not enabled")
				end
			end
		end
		self:ScenarioCheck()--Do not filter. Because ScenarioCheck function includes filter.
	end
end

--Scenario mods
function DBM:ScenarioCheck()
	if combatInfo[LastInstanceMapID] then
		for i, v in ipairs(combatInfo[LastInstanceMapID]) do
			if (v.type == "scenario") and checkEntry(v.msgs, LastInstanceMapID) then
				self:StartCombat(v.mod, 0, "LOADING_SCREEN_DISABLED")
			end
		end
	end
end

	--In combat and it's not a raid boss. We'll just delay mod load until we leave combat to avoid "script ran to long errors"
	--This should avoid most load problems (especially in LFR) When zoning in while in combat which causes the mod to fail to load/work correctly
	--IF we are fighting a boss, we don't have much of a choice but to try and load anyways since script ran too long isn't actually a guarentee.
	--The main place we should force a mod load in combat is for IsEncounterInProgress because i'm pretty sure blizzard waves "script ran too long" function for a small amount of time after a DC
	--Outdoor bosses will try to ignore check, if they fail, well, then we need to try and find ways to make the mods that can't load in combat smaller or load faster.
function DBM:LoadMod(mod, force)
	if type(mod) ~= "table" then
		self:Debug("LoadMod failed because mod table not valid")
		return false
	end
	if mod.isWorldBoss and not IsInInstance() and not force then
		self:Debug("LoadMod denied for "..mod.name.." because world boss mods don't load this way", 2)
		return
	end--Don't load world boss mod this way.
	if mod.minRevision > DBM.Revision then
		if DBM:AntiSpam(60, "VER_MISMATCH") then--Throttle message in case person keeps trying to load mod (or it's a world boss player keeps targeting
			self:AddMsg(DBM_CORE_LOAD_MOD_VER_MISMATCH:format(mod.name))
		end
		return
	end
	if InCombatLockdown() and not IsEncounterInProgress() and IsInInstance() then
		self:Debug("LoadMod delayed do to combat")
		if not loadDelay then--Prevent duplicate DBM_CORE_LOAD_MOD_COMBAT message.
			self:AddMsg(DBM_CORE_LOAD_MOD_COMBAT:format(tostring(mod.name)))
		end
		if loadDelay and loadDelay ~= mod then--Check if load delay exists, but make sure this isn't a loop of same mod before making a second load delay
			loadDelay2 = mod
		else
			loadDelay = mod
		end
		return
	end
	if not currentSpecID then
		self:SetCurrentSpecInfo()
	end
	EJ_SetDifficulty(difficultyIndex)--Work around blizzard crash bug where other mods (like Boss) screw with Ej difficulty value, which makes EJ_GetSectionInfo crash the game when called with invalid difficulty index set.
	self:Debug("LoadAddOn should have fired for "..mod.name)
	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		if reason then
			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_"..reason or ""])))
		else
			self:Debug("LoadAddOn failed and did not give reason")
--			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), DBM_CORE_UNKNOWN)) -- wtf, this should never happen....(but it does happen sometimes if you reload your UI in an instance...)
		end
		return false
	else
		self:Debug("LoadAddOn should have succeeded for "..mod.name, 2)
		if self.Options.ShowLoadMessage then--Make load option optional for advanced users, option is NOT in the GUI.
			self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		end
		self:LoadModOptions(mod.modId, InCombatLockdown(), true)
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		local _, instanceType, difficultyID, _, _, _, _, mapID = GetInstanceInfo()
		if difficultyID == 8 then
			RequestChallengeModeMapInfo()
			RequestChallengeModeLeaders(mapID)
		end
		if instanceType == "pvp" and IsAddOnLoaded("DBM-PvP") then--Is a battleground and pvp mods are installed
			if self:GetModByName("z30") and self:GetModByName("z30").revision >= 3 then--They are loaded and correct revision
				--Do nothing
			else--They either aren't loaded or are wrong revision. in either case, it means they have old pvp mods installed that don't load correctly or are out of date
				--Not the new stand alone pvp mods these are old ones and user needs to remove them or install updated package
				self:AddMsg(DBM_CORE_OUTDATED_PVP_MODS)
			end
		elseif instanceType ~= "pvp" and #inCombat == 0 and IsInGroup() then--do timer recovery only mod load
			local doRequest = false
			if IsEncounterInProgress() then
				doRequest = true
			else
				local uId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "player") or uId..i
					if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
						doRequest = true
						break
					end
				end
			end
			if doRequest then
				timerRequestInProgress = true
				-- Request timer to 3 person to prevent failure.
				self:Schedule(8, self.RequestTimers, self)
				self:Schedule(10, self.RequestTimers, self)
				self:Schedule(12, self.RequestTimers, self)
				self:Schedule(12.5, function() timerRequestInProgress = false end)
			else
				self:Schedule(6, self.RequestTimers, self)--Do once for break timer out of combat
			end
		end
		if not InCombatLockdown() then--We loaded in combat because a raid boss was in process, but lets at least delay the garbage collect so at least load mod is half as bad, to do our best to avoid "script ran too long"
			collectgarbage("collect")
		end
		if loadDelay2 == mod then
			loadDelay2 = nil
		elseif loadDelay == mod then
			loadDelay = nil
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
		loadModByUnit(uId)
	end
end

-----------------------------
--  Handle Incoming Syncs  --
-----------------------------

do
	local function checkForActualPull()
		if #inCombat == 0 then
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

	syncHandlers["M"] = function(sender, mod, revision, event, ...)
		mod = DBM:GetModByName(mod or "")
		if mod and event and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, sender, revision, ...)
		end
	end

	syncHandlers["C"] = function(sender, delay, mod, modRevision, startHp, dbmRevision)
		if sender == playerName then return end
		if LastInstanceType == "pvp" then return end
		if LastInstanceType == "none" and (not UnitAffectingCombat("player") or #inCombat > 0) then--world boss
			local senderuId = DBM:GetRaidUnitId(sender)
			if not senderuId then return end--Should never happen, but just in case. If happens, MANY "C" syncs are sent. losing 1 no big deal.
			local playerZone, senderZone = select(4, UnitPosition("player")), select(4, UnitPosition(senderuId))
			if playerZone ~= senderZone then return end--not same zone
			local range = DBM.RangeCheck:GetDistance("player", senderuId)--Same zone, so check range
			if not range or range > 60 then return end
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
				startHp = tonumber(startHp or -1) or -1
				if dbmRevision < 10481 then return end
				if mod and delay and (not mod.zones or mod.zones[LastInstanceMapID]) and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) then
					DBM:StartCombat(mod, delay + lag, "SYNC from - "..sender, true, startHp)
				end
			end
		end
	end

	syncHandlers["HF"] = function(sender, mod, modRevision)
		mod = DBM:GetModByName(mod or "")
		modRevision = tonumber(modRevision or 0) or 0
		if mod and (mod.revision < modRevision) then
			--TODO, maybe require at least 2 senders? this doesn't disable mod or make a popup though, just warn in chat that mod may have invalid timers/warnings do to a blizzard hotfix
			if DBM:AntiSpam(3, "HOTFIX") then
				DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HOTFIX)
			end
		end
	end

	syncHandlers["IS"] = function(sender, guid, ver, optionName)
		ver = tonumber(ver)
		if ver > (iconSetRevision[optionName] or 0) then--Save first synced version and person, ignore same version. refresh occurs only above version (fastest person)
			iconSetRevision[optionName] = ver
			iconSetPerson[optionName] = guid
		end
		if iconSetPerson[optionName] == UnitGUID("player") then--Check if that highest version was from ourself
			canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			canSetIcons[optionName] = false
		end
		local name = DBM:GetFullPlayerNameByGUID(iconSetPerson[optionName])
		DBM:Debug(name.." was elected icon setter for "..optionName, 2)
	end

	syncHandlers["K"] = function(sender, cId)
		if select(2, IsInInstance()) == "pvp" then return end
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
	local dummyMod2 -- dummy mod for the break timer
	syncHandlers["PT"] = function(sender, timer, lastMapID)
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup()) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		if (lastMapID and tonumber(lastMapID) ~= LastInstanceMapID) or (not lastMapID and DBM.Options.DontShowPTNoID) then return end
		timer = tonumber(timer or 0)
		if timer > 60 then
			return
		end
		if not dummyMod then
			dummyMod = DBM:NewMod("PullTimerCountdownDummy")
			DBM:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
			dummyMod.countdown = dummyMod:NewCountdown(0, 0, nil, nil, nil, true)
			dummyMod.text = dummyMod:NewAnnounce("%s", 1, 2457)
			dummyMod.geartext = dummyMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3)
		end
		--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
		if not DBM.Options.DontShowPT2 and DBM.Bars:GetBar(DBM_CORE_TIMER_PULL) then
			DBM.Bars:CancelBar(DBM_CORE_TIMER_PULL)
		end
		if not DBM.Options.DontPlayPTCountdown then
			dummyMod.countdown:Cancel()
		end
		if not DBM.Options.DontShowPTCountdownText then
			DBM:Unschedule(countDownTextDelay)
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")--easiest way to nil out timers on TimerTracker frame. This frame just has no actual star/stop functions
		end
		dummyMod.text:Cancel()
		if timer == 0 then return end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is why we let above part of code run but not below)
		if not DBM.Options.DontShowPT2 then
			DBM.Bars:CreateBar(timer, DBM_CORE_TIMER_PULL, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		end
		if not DBM.Options.DontPlayPTCountdown then
			dummyMod.countdown:Start(timer)
		end
		if not DBM.Options.DontShowPTCountdownText then
			local threshold = DBM.Options.PTCountThreshold
			if timer > threshold then
				DBM:Schedule(timer-threshold, countDownTextDelay, threshold)
			else
				TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
			end
		end
		if not DBM.Options.DontShowPTText then
			dummyMod.text:Show(DBM_CORE_ANNOUNCE_PULL:format(timer, sender))
			dummyMod.text:Schedule(timer, DBM_CORE_ANNOUNCE_PULL_NOW)
		end
		DBM:StartLogging(timer, checkForActualPull)
		if DBM.Options.CheckGear then
			local bagilvl, equippedilvl = GetAverageItemLevel()
			local difference = bagilvl - equippedilvl
			if IsInRaid() and difference >= 40 then
				dummyMod.geartext:Show(DBM_CORE_GEAR_WARNING:format(floor(difference)))
			end
		end
	end
	
	syncHandlers["BT"] = function(sender, timer)
		if (DBM:GetRaidRank(sender) == 0 and IsInGroup()) or select(2, IsInInstance()) == "pvp" or IsEncounterInProgress() then
			return
		end
		timer = tonumber(timer or 0)
		if not dummyMod2 then
			dummyMod2 = DBM:NewMod("BreakTimerCountdownDummy")
			DBM:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
			dummyMod2.countdown = dummyMod2:NewCountdown(0, 0, nil, nil, nil, true)
			dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		end
		--Cancel any existing break timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
		if not DBM.Options.DontShowPT2 and DBM.Bars:GetBar(DBM_CORE_TIMER_BREAK) then
			DBM.Bars:CancelBar(DBM_CORE_TIMER_BREAK)
		end
		if not DBM.Options.DontPlayPTCountdown then
			dummyMod2.countdown:Cancel()
		end
		if not DBM.Options.DontShowPTCountdownText then
			DBM:Unschedule(countDownTextDelay)
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")--easiest way to nil out timers on TimerTracker frame. This frame just has no actual star/stop functions
		end
		dummyMod2.text:Cancel()
		if timer == 0 then return end--"/dbm break 0" will strictly be used to cancel the break timer (which is why we let above part of code run but not below)
		if not DBM.Options.DontShowPT2 then
			DBM.Bars:CreateBar(timer, DBM_CORE_TIMER_BREAK, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		end
		if not DBM.Options.DontPlayPTCountdown then
			dummyMod2.countdown:Start(timer)
		end
		if not DBM.Options.DontShowPTCountdownText then
			local threshold = DBM.Options.PTCountThreshold
			if timer > threshold then
				DBM:Schedule(timer-threshold, countDownTextDelay, threshold)
			else
				TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
			end
		end
		if not DBM.Options.DontShowPTText then
			dummyMod2.text:Show(DBM_CORE_BREAK_START:format(timer/60, sender))
			if timer/60 > 10 then dummyMod2.text:Schedule(timer - 10*60, DBM_CORE_BREAK_MIN:format(10)) end
			if timer/60 > 5 then dummyMod2.text:Schedule(timer - 5*60, DBM_CORE_BREAK_MIN:format(5)) end
			if timer/60 > 2 then dummyMod2.text:Schedule(timer - 2*60, DBM_CORE_BREAK_MIN:format(2)) end
			if timer/60 > 1 then dummyMod2.text:Schedule(timer - 1*60, DBM_CORE_BREAK_MIN:format(1)) end
			dummyMod2.text:Schedule(timer, DBM_CORE_ANNOUNCE_BREAK_OVER)
		end
	end
	
	whisperSyncHandlers["BTR2"] = function(sender, timer)
		if #inCombat >= 1 then return end
		if DBM.Bars:GetBar(DBM_CORE_TIMER_BREAK) then return end--Already recovered. Prevent duplicate recovery
		timer = tonumber(timer or 0)
		if not dummyMod2 then
			dummyMod2 = DBM:NewMod("BreakTimerCountdownDummy")
			DBM:GetModLocalization("BreakTimerCountdownDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
			dummyMod2.countdown = dummyMod2:NewCountdown(0, 0, nil, nil, nil, true)
			dummyMod2.text = dummyMod2:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		end
		if not DBM.Options.DontShowPT2 then
			DBM.Bars:CreateBar(timer, DBM_CORE_TIMER_BREAK, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		end
		if not DBM.Options.DontPlayPTCountdown then
			dummyMod2.countdown:Start(timer)
		end
		if not DBM.Options.DontShowPTCountdownText then
			local threshold = DBM.Options.PTCountThreshold
			if timer > threshold then
				DBM:Schedule(timer-threshold, countDownTextDelay, threshold)
			else
				TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
			end
		end
		if not DBM.Options.DontShowPTText then
			dummyMod2.text:Show(DBM_CORE_BREAK_START:format(floor(timer/60*100)/100, sender))
			if timer/60 > 10 then dummyMod2.text:Schedule(timer - 10*60, DBM_CORE_BREAK_MIN:format(10)) end
			if timer/60 > 5 then dummyMod2.text:Schedule(timer - 5*60, DBM_CORE_BREAK_MIN:format(5)) end
			if timer/60 > 2 then dummyMod2.text:Schedule(timer - 2*60, DBM_CORE_BREAK_MIN:format(2)) end
			if timer/60 > 1 then dummyMod2.text:Schedule(timer - 1*60, DBM_CORE_BREAK_MIN:format(1)) end
			dummyMod2.text:Schedule(timer, DBM_CORE_ANNOUNCE_BREAK_OVER)
		end
	end

	local function SendVersion()
		if DBM.Options.FakeBWVersion then
			SendAddonMessage("BigWigs", ("VR:%d"):format(fakeBWRevision), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")--Pretending to be bigwigs, don't send dbm version information
			return
		end
		--(Note, faker isn't to screw with bigwigs nor is theirs to screw with dbm, but rathor raid leaders who don't let people run WTF they want to run)
		local VPVersion
		local VoicePack = DBM.Options.ChosenVoicePack
		if VoicePack ~= "None" then
			VPVersion = "/ VP"..VoicePack..": v"..DBM.VoiceVersions[VoicePack]
		end
		if VPVersion then
			sendSync("V", ("%d\t%s\t%s\t%s\t%s\t%s"):format(DBM.Revision, DBM.Version, DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons), VPVersion))
		else
			sendSync("V", ("%d\t%s\t%s\t%s\t%s"):format(DBM.Revision, DBM.Version, DBM.DisplayVersion, GetLocale(), tostring(not DBM.Options.DontSetIcons)))
		end
	end

	-- TODO: is there a good reason that version information is broadcasted and not unicasted?
	syncHandlers["H"] = function(sender)
		DBM:Unschedule(SendVersion)--Throttle so we don't needlessly send tons of comms during initial raid invites
		DBM:Schedule(3, SendVersion)--Send version if 3 seconds have past since last "Hi" sync
	end

	syncHandlers["VR"] = function(sender, bwrevision)--Sent by bigwigs releases
		if bwrevision and raid[sender] then
			raid[sender].bwrevision = tonumber(bwrevision)
		end
	end

	syncHandlers["VRA"] = function(sender, bwarevision)--Sent by bigwigs Alphas
		if bwarevision and raid[sender] then
			raid[sender].bwarevision = tonumber(bwarevision)
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
			if version > tonumber(DBM.Version) and LastInstanceType ~= "pvp" then -- Update reminder
				if not checkEntry(newerVersionPerson, sender) then
					newerVersionPerson[#newerVersionPerson + 1] = sender
					DBM:Debug("Newer version detected from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision), 3)
				end
				if #newerVersionPerson < 4 then
					if #newerVersionPerson == 2 and updateNotificationDisplayed < 2 then--Only requires 2 for update notification.
						--Find min revision.
						updateNotificationDisplayed = 2
						DBM:ShowUpdateReminder(displayVersion, version)
					elseif #newerVersionPerson == 3 then--Requires 3 for force disable.
						--Find min revision.
						local revDifference = mmin((raid[newerVersionPerson[1]].revision - DBM.Revision), (raid[newerVersionPerson[2]].revision - DBM.Revision), (raid[newerVersionPerson[3]].revision - DBM.Revision))
						--The following code requires at least THREE people to send that higher revision (I just upped it from 2). That should be more than adaquate, especially since there is also a display version validator now too (that had to be writen when bigwigs was sending bad revisions few versions back)
						if revDifference > 250 then--WTF? Sorry but your DBM is being turned off until you update. Grossly out of date mods cause fps loss, freezes, lua error spam, or just very bad information, if mod is not up to date with latest changes. All around undesirable experience to put yourself or other raid mates through
							if updateNotificationDisplayed < 3 then
								updateNotificationDisplayed = 3
								DBM:AddMsg(DBM_CORE_UPDATEREMINDER_DISABLE:format(revDifference))
								DBM:Disable(true)
							end
						end
					end
				end
			end
			if DBM.DisplayVersion:find("alpha") and #newerVersionPerson < 2 and #newerRevisionPerson < 2 and updateNotificationDisplayed < 2 and (revision - DBM.Revision) > 30 then--Revision 20 can be increased in 1 day, so raised it to 30. Requires 2 person.
				if not checkEntry(newerRevisionPerson, sender) then
					newerRevisionPerson[#newerRevisionPerson + 1] = sender
					DBM:Debug("Newer revision detected from "..sender.." : Rev - "..revision..", Ver - "..version..", Rev Diff - "..(revision - DBM.Revision))
				end
				if #newerRevisionPerson == 2 then
					updateNotificationDisplayed = 2
					DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER_ALPHA:format(revision - DBM.Revision))
				end
			end
		end
		DBM:GROUP_ROSTER_UPDATE()
	end

	syncHandlers["L"] = function(sender)
		local _, _, home, world = GetNetStats()
		sendSync("LAG", ("%d\t%d"):format(home, world))
	end

	syncHandlers["LAG"] = function(sender, homelag, worldlag)
		homelag, worldlag = tonumber(homelag or ""), tonumber(worldlag or "")
		if homelag and worldlag and raid[sender] then
			raid[sender].homelag = homelag
			raid[sender].worldlag = worldlag
		end
	end

	syncHandlers["U"] = function(sender, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM:GetRaidRank(sender) == 0 or difficultyIndex == 7 or difficultyIndex == 17 then return end
		if sender == playerName then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
		end
	end
	
	syncHandlers["CU"] = function(sender, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM:GetRaidRank(sender) == 0 or difficultyIndex == 7 or difficultyIndex == 17 then return end
		if sender == playerName then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender, true)
		end
	end
	
	syncHandlers["RBW3"] = function(sender, spellId, spellName)
		if sender == playerName then return end
		if not spellName then spellName = UNKNOWN end
		local message = "RAID_BOSS_WHISPER on "..sender.." with spell of "..spellName.." ("..spellId..")"
		if DBM.Options.DebugLevel > 2 or (Transcriptor and Transcriptor:IsLogging()) then
			DBM:Debug(message)
		end
		fireEvent("DBM_Announce", message)
	end

	-- beware, ugly and missplaced code ahead
	-- todo: move this somewhere else
	do
		local accessList = {}
		local savedSender

		local inspopup = CreateFrame("Frame", "DBMPopupLockout", UIParent)
		inspopup:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
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
		buttonaccept:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		buttonaccept:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		buttonaccept:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		buttonaccept:SetSize(128, 35)
		buttonaccept:SetPoint("BOTTOM", inspopup, "BOTTOM", -75, 0)

		local buttonatext = buttonaccept:CreateFontString()
		buttonatext:SetFontObject(ChatFontNormal)
		buttonatext:SetPoint("CENTER", buttonaccept, "CENTER", 0, 5)
		buttonatext:SetText(YES)

		local buttondecline = CreateFrame("Button", nil, inspopup)
		buttondecline:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		buttondecline:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		buttondecline:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
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
			PlaySound("igMainMenuOpen")
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

		syncHandlers["GCB"] = function(sender, modId, ver, difficulty)
			if not DBM.Options.ShowGuildMessages or not difficulty then return end
			if not ver or not (ver == "2") then return end--Ignore old versions
			if DBM:AntiSpam(5, "GCB") then
				if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
				local bossName = EJ_GetEncounterInfo(modId) or UNKNOWN
				local difficultyName = UNKNOWN
				difficulty = tonumber(difficulty)
				if difficulty == 16 then
					difficultyName = PLAYER_DIFFICULTY6
				elseif difficulty == 15 then
					difficultyName = PLAYER_DIFFICULTY2
				else 
					difficultyName = PLAYER_DIFFICULTY1
				end
				DBM:AddMsg(DBM_CORE_GUILD_COMBAT_STARTED:format(difficultyName.."-"..bossName))
			end
		end
		
		syncHandlers["GCE"] = function(sender, modId, ver, wipe, time, wipeHP, difficulty)
			if not DBM.Options.ShowGuildMessages or not difficulty then return end
			if not ver or not (ver == "2") then return end--Ignore old versions
			if DBM:AntiSpam(5, "GCE") then
				if IsInInstance() then return end--Simple filter, if you are inside an instance, just filter it, if not in instance, good to go.
				local bossName = EJ_GetEncounterInfo(modId) or UNKNOWN
				local difficultyName = UNKNOWN
				difficulty = tonumber(difficulty)
				if difficulty == 16 then
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
				local bossName = EJ_GetEncounterInfo(modId) or name or UNKNOWN
				DBM:AddMsg(DBM_CORE_WORLDBOSS_ENGAGED:format(bossName, floor(health), sender))
			end
		end
		
		syncHandlers["WBD"] = function(sender, modId, realm, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
			lastBossDefeat[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				local bossName = EJ_GetEncounterInfo(modId) or name or UNKNOWN
				DBM:AddMsg(DBM_CORE_WORLDBOSS_DEFEATED:format(bossName, sender))
			end
		end

		whisperSyncHandlers["WBE"] = function(sender, modId, realm, health, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossEngage[modId..realm] and (GetTime() - lastBossEngage[modId..realm] < 30) then return end
			lastBossEngage[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				local _, toonName = BNGetToonInfo(sender)
				local bossName = EJ_GetEncounterInfo(modId) or name or UNKNOWN
				DBM:AddMsg(DBM_CORE_WORLDBOSS_ENGAGED:format(bossName, floor(health), toonName))
			end
		end
		
		whisperSyncHandlers["WBD"] = function(sender, modId, realm, ver, name)
			if not ver or not (ver == "8") then return end--Ignore old versions
			if lastBossDefeat[modId..realm] and (GetTime() - lastBossDefeat[modId..realm] < 30) then return end
			lastBossDefeat[modId..realm] = GetTime()
			if realm == playerRealm and DBM.Options.WorldBossAlert and not IsEncounterInProgress() then
				local _, toonName = BNGetToonInfo(sender)
				local bossName = EJ_GetEncounterInfo(modId) or name or UNKNOWN
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
				DBM:Schedule(1, showResults) --Delay results so we allow time for same sender to send more than 1 lockout, otherwise, if we get expectedResponses before all data is sent from 1 user, we clip some of their data.
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
						DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_INSTANCE:format(id, v.progress, table.concat(v, ", ")), false)
					else
						DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_INSTANCE2:format(v.progress, table.concat(v, ", ")), false)
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
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_DENIED:format(table.concat(denied, ", ")), false)
			end
			if #away > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_AWAY:format(table.concat(away, ", ")), false)
			end
			if #noResponse > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_NO_RESPONSE:format(table.concat(noResponse, ", ")), false)
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
					DBM:AddMsg(DBM_INSTANCE_INFO_SHOW_RESULTS:format(table.concat(noResponse, ", ")), false)
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
			self:Schedule(62, showResults)
		end
	end

	whisperSyncHandlers["RT"] = function(sender)
		DBM:SendTimers(sender)
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

	local function handleSync(channel, sender, prefix, ...)
		if not prefix then
			return
		end
		local handler
		if channel == "WHISPER" and sender ~= playerName then -- separate between broadcast and unicast, broadcast must not be sent as unicast or vice-versa
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
			local bwPrefix, bwMsg = msg:match("^(%u-):(.+)")
			if bwPrefix then
				if bwPrefix == "VR" or bwPrefix == "VRA" then--Version information prefixes
					sender = Ambiguate(sender, "none")
					handleSync(channel, sender, bwPrefix, bwMsg)
					bwMsg = tonumber(bwMsg) or 0
					if bwPrefix == "VR" then--Only upgrade to latest release version found
						if bwMsg > fakeBWRevision then fakeBWRevision = bwMsg end--Newer revision found, upgrade!
					end
				elseif prefix == "VQ" then--Version request prefix
					self:Unschedule(SendVersion)
					self:Schedule(3, SendVersion)
				end
			end
		end
	end
	
	function DBM:BN_CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if prefix == "D4" and msg then
			handleSync(channel, sender, strsplit("\t", msg))
		end
	end
end

-----------------------
--  Update Reminder  --
-----------------------
do
	local frame, fontstring, fontstringFooter

	local function createFrame()
		frame = CreateFrame("Frame", "DBMUpdateReminder", UIParent)
		frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
		frame:SetWidth(430)
		frame:SetHeight(140)
		frame:SetPoint("TOP", 0, -230)
		frame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
			insets = {left = 11, right = 12, top = 12, bottom = 11},
		})
		fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstring:SetWidth(410)
		fontstring:SetHeight(0)
		fontstring:SetPoint("TOP", 0, -16)
		local editBox = CreateFrame("EditBox", nil, frame)
		do
			local editBoxLeft = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxRight = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxMiddle = editBox:CreateTexture(nil, "BACKGROUND")
			editBoxLeft:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left")
			editBoxLeft:SetHeight(32)
			editBoxLeft:SetWidth(32)
			editBoxLeft:SetPoint("LEFT", -14, 0)
			editBoxLeft:SetTexCoord(0, 0.125, 0, 1)
			editBoxRight:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
			editBoxRight:SetHeight(32)
			editBoxRight:SetWidth(32)
			editBoxRight:SetPoint("RIGHT", 6, 0)
			editBoxRight:SetTexCoord(0.875, 1, 0, 1)
			editBoxMiddle:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
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
		editBox:SetText(DBM_CORE_UPDATEREMINDER_URL or "http://www.deadlybossmods.com")
		editBox:HighlightText()
		editBox:SetScript("OnTextChanged", function(self)
			editBox:SetText(DBM_CORE_UPDATEREMINDER_URL or "http://www.deadlybossmods.com")
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

	function DBM:ShowUpdateReminder(newVersion, newRevision, text)
		if not frame then
			createFrame()
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
		if not checkEntry(inCombat, mod) then
			buildTargetList()
			local _, iType = GetInstanceInfo()
			if targetList[mob] then
				if delay > 0 and UnitAffectingCombat(targetList[mob]) then
					DBM:StartCombat(mod, delay, "PLAYER_REGEN_DISABLED")
				elseif (delay == 0) and iType == "none" then
					DBM:StartCombat(mod, 0, "PLAYER_REGEN_DISABLED_AND_MESSAGE")
				end
			end
			clearTargetList()
		end
	end


	local function checkForPull(mob, combatInfo)
		healthCombatInitialized = false
		DBM:Schedule(0.5, scanForCombat, combatInfo.mod, mob, 0.5)
		DBM:Schedule(2, scanForCombat, combatInfo.mod, mob, 2)
		DBM:Schedule(2.1, function()
			healthCombatInitialized = true
		end)
	end

	-- TODO: fix the duplicate code that was added for quick & dirty support of zone IDs

	-- detects a boss pull based on combat state, this is required for pre-ICC bosses that do not fire INSTANCE_ENCOUNTER_ENGAGE_UNIT events on engage
	function DBM:PLAYER_REGEN_DISABLED()
		lastCombatStarted = GetTime()
		if not combatInitialized then return end
		if combatInfo[LastInstanceMapID] then
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
			local voice = DBM.Options.ChosenVoicePack
			local path = "Sound\\Creature\\CThun\\CThunYouWillDIe.ogg"
			if voice ~= "None" then 
				path = "Interface\\AddOns\\DBM-VP"..voice.."\\checkhp.ogg"
			end
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(path, "Master")
			else
				PlaySoundFile(path)
			end
		end
	end

	local function isBossEngaged(cId)
		-- note that this is designed to work with any number of bosses, but it might be sufficient to check the first 5 unit ids
		-- TODO: check if the client supports more than 5 boss unit IDs...just because the default boss health frame is limited to 5 doesn't mean there can't be more
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
		if combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type:find("combat") and isBossEngaged(v.multiMobPullDetection or v.mob) then
					self:StartCombat(v.mod, 0, "IEEU")
				end
			end
		end
	end
	
	function DBM:SCENARIO_UPDATE()
		if not C_Garrison:IsOnGarrisonMap() then return end
		local name = C_Scenario.GetInfo()
		if not name then return end-- fix false mod load when visiting other player garrision.
		local enabled = GetAddOnEnableState(playerName, "DBM-WorldEvents")
		if not IsAddOnLoaded("DBM-WorldEvents") and enabled ~= 0 then
			for i, v in ipairs(self.AddOns) do
				if v.modId == "DBM-WorldEvents" then
					self:LoadMod(v, true)
					break
				end
			end
		end
	end
	
	function DBM:UNIT_TARGETABLE_CHANGED(uId)
		if DBM.Options.DebugLevel > 2 or (Transcriptor and Transcriptor:IsLogging()) then
			local active = UnitExists(uId) and "true" or "false"
			self:Debug("UNIT_TARGETABLE_CHANGED event fired for "..UnitName(uId)..". Active: "..active)
		end
	end

	--TODO, waste less cpu and register Unit only events for boss1-5
	function DBM:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
		if not (uId == "boss1" or uId == "boss2" or uId == "boss3" or uId == "boss4" or uId == "boss5") then return end
		--Changed, only fire for debug level 3 period. transcriptor running now only forces RBW2 and UTC.
		--This event is way too spammy to see every time transcriptor running. Only want from time to time
		self:Debug("UNIT_SPELLCAST_SUCCEEDED fired: "..UnitName(uId).."'s "..spellName.."("..spellId..")", 3)
	end

	function DBM:ENCOUNTER_START(encounterID, name, difficulty, size)
		self:Debug("ENCOUNTER_START event fired: "..encounterID.." "..name.." "..difficulty.." "..size)
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

	local function endCombat(v, success, encounterID)
		if not v.combatInfo then return end--Was terminated by UNIT_DIED or YELL (which means probably wrath zone and we already have end combat, so cancel this delayed wipe)
		DBM:EndCombat(v, success == 0)
		sendSync("EE", encounterID.."\t"..success.."\t"..v.id.."\t"..(v.revision or 0))
	end
	
	function DBM:ENCOUNTER_END(encounterID, name, difficulty, size, success)
		self:Debug("ENCOUNTER_END event fired: "..encounterID.." "..name.." "..difficulty.." "..size.." "..success)
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.noEEDetection then return end
			if v.multiEncounterPullDetection then
				for _, eId in ipairs(v.multiEncounterPullDetection) do
					if encounterID == eId then
						if bossuIdFound or success == 1 then
							self:EndCombat(v, success == 0)
							sendSync("EE", encounterID.."\t"..success.."\t"..v.id.."\t"..(v.revision or 0))
						else--hack wotlk instance EE bug. wotlk instances always wipe, so delay 3sec do actual wipe.
							self:Schedule(3, endCombat, v, success, encounterID)
						end
						return
					end
				end
			elseif encounterID == v.combatInfo.eId then
				if bossuIdFound or success == 1 then
					self:EndCombat(v, success == 0)
					sendSync("EE", encounterID.."\t"..success.."\t"..v.id.."\t"..(v.revision or 0))
				else--hack wotlk instance EE bug. wotlk instances always wipe, so delay 3sec do actual wipe.
					self:Schedule(3, endCombat, v, success, encounterID)
				end
				return
			end
		end
	end
	
	function DBM:BOSS_KILL(encounterID, name)
		self:Debug("BOSS_KILL event fired: "..encounterID.." "..name)
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
	local function onMonsterMessage(type, msg)
		-- pull detection
		if combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type == type and checkEntry(v.msgs, msg) or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg) then
					DBM:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
				elseif v.type == "combat_" .. type .. "find" and findEntry(v.msgs, msg) or v.type == "combat_" .. type and checkEntry(v.msgs, msg) then
					if IsInInstance() then--Indoor boss that uses both combat and yell for combat, so in other words (such as hodir), don't require "target" of boss for yell like scanForCombat does for World Bosses
						DBM:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
					else--World Boss
						scanForCombat(v.mod, v.mob, 0)
						if (DBM.Options.WorldBossNearAlert or v.mod.Options.ReadyCheck) and not IsQuestFlaggedCompleted(v.mod.readyCheckQuestId) then
							PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")
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
				DBM:EndCombat(v)
			end
		end
	end

	function DBM:CHAT_MSG_MONSTER_YELL(msg)
		return onMonsterMessage("yell", msg)
	end

	function DBM:CHAT_MSG_MONSTER_EMOTE(msg)
		return onMonsterMessage("emote", msg)
	end

	function DBM:CHAT_MSG_RAID_BOSS_EMOTE(msg, ...)
		onMonsterMessage("emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:RAID_BOSS_EMOTE(msg, ...)--This is a mirror of above prototype only it has less args, both still exist for some reason.
		onMonsterMessage("emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end
	
	function DBM:RAID_BOSS_WHISPER(msg)
		--Make it easier for devs to detect whispers they are unable to see
		--TINTERFACE\\ICONS\\ability_socererking_arcanewrath.blp:20|t You have been branded by |cFFF00000|Hspell:156238|h[Arcane Wrath]|h|r!"
		if msg:find("spell:") and IsInGroup() then
			local spellId = string.match(msg, "spell:(%d+)") or UNKNOWN
			local spellName = string.match(msg, "h%[(.-)%]|h") or UNKNOWN
			sendSync("RBW3", spellId.."\t"..spellName)
		end
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		return onMonsterMessage("say", msg)
	end
end

---------------------------
--  Kill/Wipe Detection  --
---------------------------

function checkWipe(confirm)
	if #inCombat > 0 then
		if not savedDifficulty or not difficultyText or not difficultyIndex then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex = DBM:GetCurrentInstanceDifficulty()
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
			DBM:Schedule(3, checkWipe)
		elseif confirm then
			for i = #inCombat, 1, -1 do
				local reason = (wipe == 1 and "No combat unit found in your party." or "No boss found : "..(wipe or "nil"))
				DBM:Debug("You wiped. Reason : "..reason)
				DBM:EndCombat(inCombat[i], true)
			end
		else
			local maxDelayTime = (savedDifficulty == "worldboss" and 30) or 5 --wait 25s more on worldboss do actual wipe.
			for i, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			DBM:Schedule(maxDelayTime, checkWipe, true)
		end
	end
end

function checkBossHealth()
	if #inCombat > 0 then
		for i, v in ipairs(inCombat) do
			if not v.multiMobPullDetection or v.mainBoss then
				DBM:GetBossHP(v.mainBoss or v.combatInfo.mob or -1)
			else
				for _, mob in ipairs(v.multiMobPullDetection) do
					DBM:GetBossHP(mob)
				end
			end
		end
		DBM:Schedule(1, checkBossHealth)
	end
end

function checkCustomBossHealth(mod)
	mod:CustomHealthUpdate()
	DBM:Schedule(1, checkCustomBossHealth, mod)
end

function loopCRTimer(timer, mod)
	local crTimer = mod:NewTimer(timer, DBM_COMBAT_RES_TIMER_TEXT, "Interface\\Icons\\Spell_Nature_Reincarnation", nil, false)
	crTimer:Start()
	DBM:Schedule(timer, loopCRTimer, timer, mod)
end

do
	local statVarTable = {
		--6.0
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
		--Legacy
		["lfr25"] = "lfr25",
		["normal10"] = "normal",
		["normal25"] = "normal25",
		["heroic10"] = "heroic",
		["heroic25"] = "heroic25",
	}

	function DBM:StartCombat(mod, delay, event, synced, syncedStartHp)
		if not mod.inCombat then
			if event then
				self:Debug("StartCombat called by : "..event..". LastInstanceMapID is "..LastInstanceMapID)
			else
				self:Debug("StartCombat called by individual mod or unknown reason. LastInstanceMapID is "..LastInstanceMapID)
			end
		end
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
			if mod.lastWipeTime and GetTime() - mod.lastWipeTime < (mod.reCombatTime2 or 20) and event ~= "LOADING_SCREEN_DISABLED" then return end
			--check completed. starting combat
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
			savedDifficulty, difficultyText, difficultyIndex, LastGroupSize = self:GetCurrentInstanceDifficulty()
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
				self:Schedule(mmax((mod.minCombatTime - delay), 3), checkWipe)
			else
				self:Schedule(3, checkWipe)
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
			end
			--show health frame
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
				if (self.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) then
					if not self.BossHealth:IsShown() then
						self.BossHealth:Show(mod.localization.general.name)
					else-- pulled other boss during combat, set header text.
						self.BossHealth:SetHeaderText(BOSS)
					end
					if mod.bossHealthInfo then
						if mod.bossHealthInfo[2] and type(mod.bossHealthInfo[2]) == "number" then
							for i = 1, #mod.bossHealthInfo do--boss name gets from UnitName
								self.BossHealth:AddBoss(mod.bossHealthInfo[i])
							end
						else
							for i = 1, #mod.bossHealthInfo, 2 do
								self.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
							end
						end
					else
						self.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
					end
				--boss health info update scheduler if boss health frame is not enabled.
				elseif not mod.CustomHealthUpdate then
					self:Schedule(1, checkBossHealth)
				end
				--this function must be scheduled if boss health frame enabled.
				if mod.CustomHealthUpdate then
					self:Schedule(1, checkCustomBossHealth, mod)
				end
			end
			--process global options
			self:HideBlizzardEvents(1)
			self:StartLogging(0, nil)
			if self.Options.HideObjectivesFrame and mod.addon.type ~= "SCENARIO" and GetNumTrackedAchievements() == 0 then
				if ObjectiveTrackerFrame:IsVisible() then
					ObjectiveTrackerFrame:Hide()
					watchFrameRestore = true
				end
				--When hiding objectives frame in challenge modes, start our own timer to show medal time remaining
				local _, elapsedTime, worldTimerType = GetWorldElapsedTime(1)--Should always be 1, with only one world state timer active. if it's not, use GetWorldElapsedTimers() to find correct one
				if worldTimerType == 2 then--Challenge mode
					local bronze, silver, gold = GetChallengeModeMapTimes(LastInstanceMapID)
					local remaining
					if elapsedTime < gold then
						remaining = gold - elapsedTime
						self.Bars:CreateBar(remaining, CHALLENGE_MODE_MEDAL3, "Interface\\Icons\\Spell_Holy_BorrowedTime")
					elseif elapsedTime < silver then
						remaining = silver - elapsedTime
						self.Bars:CreateBar(remaining, CHALLENGE_MODE_MEDAL2, "Interface\\Icons\\Spell_Holy_BorrowedTime")
					elseif elapsedTime < bronze then
						remaining = bronze - elapsedTime
						self.Bars:CreateBar(remaining, CHALLENGE_MODE_MEDAL1, "Interface\\Icons\\Spell_Holy_BorrowedTime")
					end
				end
			end
			fireEvent("pull", mod, delay, synced, startHp)
			--serperate timer recovery and normal start.
			if event ~= "TIMER_RECOVERY" then
				--add pull count
				if mod.stats then
					if not mod.stats[statVarTable[savedDifficulty].."Pulls"] then mod.stats[statVarTable[savedDifficulty].."Pulls"] = 0 end
					mod.stats[statVarTable[savedDifficulty].."Pulls"] = mod.stats[statVarTable[savedDifficulty].."Pulls"] + 1
				end
				--show speed timer
				if (self.Options.AlwaysShowSpeedKillTimer or mod.Options.SpeedKillTimer) and mod.stats and not mod.ignoreBestkill then
					local bestTime = mod.stats[statVarTable[savedDifficulty].."BestTime"]
					if bestTime and bestTime > 0 then
						local speedTimer = mod:NewTimer(bestTime, DBM_SPEED_KILL_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, false)
						speedTimer:Start()
					end
				end
				if self.Options.CRT_Enabled and difficultyIndex >= 14 and difficultyIndex < 18 then--14-17 difficulties. Normal, Heroic, Mythic, LFR
					local time = 90/LastGroupSize
					time = time * 60
					loopCRTimer(time, mod)
				end
				--update boss left
				if mod.numBoss then
					mod.vb.bossLeft = mod.numBoss
				end
				--elect icon person
				if mod.findFastestComputer and not self.Options.DontSetIcons then
					if self:GetRaidRank() > 0 then
						local optionName = mod.findFastestComputer[1]
						if #mod.findFastestComputer == 1 and mod.Options[optionName] then
							sendSync("IS", UnitGUID("player").."\t"..DBM.Revision.."\t"..optionName)
						else
							for i = 1, #mod.findFastestComputer do
								local option = mod.findFastestComputer[i]
								if mod.Options[option] then
									sendSync("IS", UnitGUID("player").."\t"..DBM.Revision.."\t"..option)
								end
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
				if mod.OnCombatStart and not mod.ignoreBestkill then
					mod:OnCombatStart(delay or 0, event == "PLAYER_REGEN_DISABLED_AND_MESSAGE")
				end
				--send "C" sync
				if not synced then
					sendSync("C", (delay or 0).."\t"..modId.."\t"..(mod.revision or 0).."\t"..startHp.."\t"..DBM.Revision)
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
							if difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16 then--Only send relevant content, not guild beating down lich king or LFR.
								if InGuildParty() then--Guild Group
									SendAddonMessage("D4", "GCB\t"..modId.."\t2\t"..difficultyIndex, "GUILD")
								end
							end
						end
					end
				end
				--stop pull count
				local dummyMod = self:GetModByName("PullTimerCountdownDummy")
				if dummyMod then--stop pull timer, warning, countdowns
					dummyMod.countdown:Cancel()
					dummyMod.text:Cancel()
					self.Bars:CancelBar(DBM_CORE_TIMER_PULL)
					TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
				end
				--show hotfix notify
				if mod.hotfixNoticeRev then
					sendSync("HF", modId.."\t"..mod.hotfixNoticeRev)
				end
			elseif self.Options.ShowRecoveryMessage then--show timer recovery message
				self:AddMsg(DBM_CORE_COMBAT_STATE_RECOVERED:format(difficultyText..name, strFromTime(delay)))
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
					local presenceID, _, _, _, _, _, client, isOnline = BNGetFriendInfo(i)
					if isOnline and client == BNET_CLIENT_WOW then
						local _, _, _, userRealm = BNGetToonInfo(presenceID)
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
							BNSendGameData(presenceID, "D4", "WBE\t"..modId.."\t"..userRealm.."\t"..startHp.."\t8\t"..name)--Just send users realm for pull, so we can eliminate connectedServers checks on sync handler
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
		if not health or health < 5 then return end -- no worthy of combat start if health is below 5%
		if InCombatLockdown() then
			if cId ~= 0 and not bossHealth[cId] and bossIds[cId] and UnitAffectingCombat(uId) and healthCombatInitialized then -- StartCombat by UNIT_HEALTH.
				if combatInfo[LastInstanceMapID] then
					for i, v in ipairs(combatInfo[LastInstanceMapID]) do
						if v.mod.Options.Enabled and not v.mod.disableHealthCombat and v.type:find("combat") and (v.multiMobPullDetection and checkEntry(v.multiMobPullDetection, cId) or v.mob == cId) then
							-- Delay set, > 97% = 0.5 (consider as normal pulling), max dealy limited to 20s.
							self:StartCombat(v.mod, health > 97 and 0.5 or mmin(GetTime() - lastCombatStarted, 20), "UNIT_HEALTH", nil, health)
						end
					end
				end
			end
			if self.Options.AFKHealthWarning and UnitIsUnit(uId, "player") and (health < 85) and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
				PlaySoundFile("Sound\\Creature\\CThun\\CThunYouWillDIe.ogg", "master")--So fire an alert sound to save yourself from this person's behavior.
			end
		end
	end

	function DBM:EndCombat(mod, wipe)
		if removeEntry(inCombat, mod) then
			local scenario = mod.addon.type == "SCENARIO"
			if mod.inCombatOnlyEvents and mod.inCombatOnlyEventsRegistered then
				-- unregister all events except for SPELL_AURA_REMOVED events (might still be needed to remove icons etc...)
				mod:UnregisterInCombatEvents()
				self:Schedule(2, mod.UnregisterInCombatEvents, mod, true) -- 2 seconds should be enough for all auras to fade
				self:Schedule(2.1, mod.Stop, mod) -- Remove accident started timers.
				mod.inCombatOnlyEventsRegistered = nil
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
				savedDifficulty, difficultyText, difficultyIndex = DBM:GetCurrentInstanceDifficulty()
			end
			if not mod.stats then--This will be nil if the mod for this intance failed to load fully because "script ran too long" (it tried to load in combat and failed)
				self:AddMsg(DBM_CORE_BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
				return--Don't run any further, stats are nil on a bad load so rest of this code will also error out.
			end
			local name = mod.combatInfo.name
			local modId = mod.id
			if wipe then
				mod.lastWipeTime = GetTime()
				--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
				local thisTime = GetTime() - mod.combatInfo.pull
				local hp = mod.highesthealth and mod:GetHighestBossHealth() or mod:GetLowestBossHealth()
				local wipeHP = mod.CustomHealthUpdate and mod:CustomHealthUpdate() or hp and ("%d%%"):format(hp) or DBM_CORE_UNKNOWN
				local totalPulls = mod.stats[statVarTable[savedDifficulty].."Pulls"]
				local totalKills = mod.stats[statVarTable[savedDifficulty].."Kills"]
				if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
					totalPulls = totalPulls - 1
					if self.Options.ShowWipeMessage then
						if scenario then
							self:AddMsg(DBM_CORE_SCENARIO_ENDED_AT:format(difficultyText..name, strFromTime(thisTime)))
						else
							self:AddMsg(DBM_CORE_COMBAT_ENDED_AT:format(difficultyText..name, wipeHP, strFromTime(thisTime)))
							--No reason to GCE it here, so omited on purpose.
						end
					end
				else
					if self.Options.ShowWipeMessage then
						if scenario then
							self:AddMsg(DBM_CORE_SCENARIO_ENDED_AT_LONG:format(difficultyText..name, strFromTime(thisTime), totalPulls - totalKills))
						else
							self:AddMsg(DBM_CORE_COMBAT_ENDED_AT_LONG:format(difficultyText..name, wipeHP, strFromTime(thisTime), totalPulls - totalKills))
							if difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16 then
								if InGuildParty() then--Guild Group
									SendAddonMessage("D4", "GCE\t"..modId.."\t2\t1\t"..strFromTime(thisTime).."\t"..wipeHP.."\t"..difficultyIndex, "GUILD")
								end
							end
						end
					end
				end

				local msg
				for k, v in pairs(autoRespondSpam) do
					if self.Options.WhisperStats then
						if scenario then
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS:format(playerName, difficultyText..(name or ""), totalPulls - totalKills)
						else
							local hpText = wipeHP
							if mod.vb.phase then
								hpText = hpText.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
							end
							if mod.numBoss then
								local bossesKilled = mod.numBoss - mod.vb.bossLeft
								hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
							end
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, difficultyText..(name or ""), hpText, totalPulls - totalKills)
						end
					else
						if scenario then
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_WIPE:format(playerName, difficultyText..(name or ""))
						else
							local hpText = wipeHP
							if mod.vb.phase then
								hpText = hpText.." ("..SCENARIO_STAGE:format(mod.vb.phase)..")"
							end
							if mod.numBoss then
								local bossesKilled = mod.numBoss - mod.vb.bossLeft
								hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
							end
							msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_AT:format(playerName, difficultyText..(name or ""), hpText)
						end
					end
					sendWhisper(k, msg)
				end
				fireEvent("wipe", mod)
			else
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
						mod.stats[statVarTable[savedDifficulty].."BestTime"] = mmin(bestTime or mhuge, thisTime)
					end
				end
				local totalKills = mod.stats[statVarTable[savedDifficulty].."Kills"]
				if self.Options.ShowKillMessage then
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
							if difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16 then
								if InGuildParty() then--Guild Group
									SendAddonMessage("D4", "GCE\t"..modId.."\t2\t0\t"..strFromTime(thisTime).."\t"..difficultyIndex, "GUILD")
								end
							end
						end
					elseif thisTime < (bestTime or mhuge) then
						if scenario then
							msg = DBM_CORE_SCENARIO_COMPLETE_NR:format(difficultyText..name, strFromTime(thisTime), strFromTime(bestTime), totalKills)
						else
							msg = DBM_CORE_BOSS_DOWN_NR:format(difficultyText..name, strFromTime(thisTime), strFromTime(bestTime), totalKills)
							if difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16 then
								if InGuildParty() then--Guild Group
									SendAddonMessage("D4", "GCE\t"..modId.."\t2\t0\t"..strFromTime(thisTime).."\t"..difficultyIndex, "GUILD")
								end
							end
						end
					else
						if scenario then
							msg = DBM_CORE_SCENARIO_COMPLETE_L:format(difficultyText..name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime), totalKills)
						else
							msg = DBM_CORE_BOSS_DOWN_L:format(difficultyText..name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime), totalKills)
							if difficultyIndex == 14 or difficultyIndex == 15 or difficultyIndex == 16 then
								if InGuildParty() then--Guild Group
									SendAddonMessage("D4", "GCE\t"..modId.."\t2\t0\t"..strFromTime(thisTime).."\t"..difficultyIndex, "GUILD")
								end
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
				fireEvent("kill", mod)
				if savedDifficulty == "worldboss" and not mod.noWBEsync then
					if lastBossDefeat[modId..playerRealm] and (GetTime() - lastBossDefeat[modId..playerRealm] < 30) then return end--Someone else synced in last 10 seconds so don't send out another sync to avoid needless sync spam.
					lastBossDefeat[modId..playerRealm] = GetTime()--Update last defeat time before we send it, so we don't handle our own sync
					if IsInGuild() then
						SendAddonMessage("D4", "WBD\t"..modId.."\t"..playerRealm.."\t8\t"..name, "GUILD")--Even guild syncs send realm so we can keep antispam the same across realid as well.
					end
					local _, numBNetOnline = BNGetNumFriends()
					for i = 1, numBNetOnline do
						local sameRealm = false
						local presenceID, _, _, _, _, _, client, isOnline = BNGetFriendInfo(i)
						if isOnline and client == BNET_CLIENT_WOW then
							local _, _, _, userRealm = BNGetToonInfo(presenceID)
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
								BNSendGameData(presenceID, "D4", "WBD\t"..modId.."\t"..userRealm.."\t8\t"..name)
							end
						end
					end
				end
			end
			if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
			if #inCombat == 0 then--prevent error if you pulled multiple boss. (Earth, Wind and Fire)
				self:Schedule(10, self.StopLogging, self)--small delay to catch kill/died combatlog events
				self:HideBlizzardEvents(0)
				self:Unschedule(checkBossHealth)
				self:Unschedule(checkCustomBossHealth)
				self:Unschedule(loopCRTimer)
				self.BossHealth:Hide()
				self.Arrow:Hide(true)
				if self.Options.HideObjectivesFrame and watchFrameRestore and not scenario then
					ObjectiveTrackerFrame:Show()
					watchFrameRestore = false
					if difficultyIndex == 8 then
						--Cancel any and all CM medal when unhiding objectives frame
						self.Bars:CancelBar(CHALLENGE_MODE_MEDAL1)
						self.Bars:CancelBar(CHALLENGE_MODE_MEDAL2)
						self.Bars:CancelBar(CHALLENGE_MODE_MEDAL3)
					end
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
				self:CreatePizzaTimer(time, "", nil, nil, nil, nil, true)--Auto Terminate infinite loop timers on combat end
			elseif self.BossHealth:IsShown() then
				if mod.bossHealthInfo then
					if mod.bossHealthInfo[2] and type(mod.bossHealthInfo[2]) == "number" then
						for i = 1, #mod.bossHealthInfo do
							self.BossHealth:RemoveBoss(mod.bossHealthInfo[i])
						end
					else
						for i = 1, #mod.bossHealthInfo, 2 do
							self.BossHealth:RemoveBoss(mod.bossHealthInfo[i])
						end
					end
				else
					self.BossHealth:RemoveBoss(mod.combatInfo.mob)
				end
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
		if v.combatInfo.killMobs and v.combatInfo.killMobs[cId] then
			if not synced then
				sendSync("K", cId)
			end
			v.combatInfo.killMobs[cId] = false
			self.BossHealth:RemoveBoss(cId)
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

	function DBM:StartLogging(timer, checkFunc)
		self:Unschedule(DBM.StopLogging)
		if self.Options.LogOnlyRaidBosses and ((LastInstanceType ~= "raid") or IsPartyLFG()) then return end
		if self.Options.AutologBosses then--Start logging here to catch pre pots.
			if not LoggingCombat() then
				autoLog = true
				if self.Options.ShowCombatLogMessage then
					self:AddMsg("|cffffff00"..COMBATLOGENABLED.."|r")
				end
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
				if self.Options.ShowTranscriptorMessage then
					self:AddMsg("|cffffff00"..DBM_CORE_TRANSCRIPTOR_LOG_START.."|r")
				end
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
			if self.Options.ShowCombatLogMessage then
				self:AddMsg("|cffffff00"..COMBATLOGDISABLED.."|r")
			end
			LoggingCombat(false)
		end
		if self.Options.AdvancedAutologBosses and Transcriptor and autoTLog then
			if Transcriptor:IsLogging() then
				autoTLog = false
				if self.Options.ShowTranscriptorMessage then
					self:AddMsg("|cffffff00"..DBM_CORE_TRANSCRIPTOR_LOG_END.."|r")
				end
				Transcriptor:StopLog(1)
			end
		end
	end
end

function DBM:SetCurrentSpecInfo()
	if UnitBuff("player", gladStance) then 
		currentSpecGroup = 3 -- give 3rd spec option only for glad stance.
		currentSpecID = 74 -- temp id for glad warrior, bliz not uses it
	else
		currentSpecGroup = GetActiveSpecGroup()
		currentSpecID, currentSpecName = GetSpecializationInfo(GetSpecialization() or 1)--give temp first spec id for non-specialization char. no one should use dbm with no specialization, below level 10, should not need dbm.
		currentSpecID = tonumber(currentSpecID)
	end
end

function DBM:GetCurrentInstanceDifficulty()
	local _, instanceType, difficulty, difficultyName, _, _, _, _, instanceGroupSize = GetInstanceInfo()
	if difficulty == 0 or (difficulty == 1 and instanceType == "none") or C_Garrison:IsOnGarrisonMap() then--draenor field returns 1, causing world boss mod bug.
		return "worldboss", RAID_INFO_WORLD_BOSS.." - ", difficulty
	elseif difficulty == 1 then
		return "normal5", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 2 then
		return "heroic5", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 3 then
		return "normal10", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 4 then
		return "normal25", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 5 then
		return "heroic10", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 6 then
		return "heroic25", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 7 then--Fixed LFR (ie pre WoD zones)
		return "lfr25", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 8 then
		return "challenge5", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 9 then--40 man raids have their own difficulty now, no longer returned as normal 10man raids
		return "normal10", difficultyName.." - ",difficulty, instanceGroupSize--Just use normal10 anyways, since that's where we been saving 40 man stuff for so long anyways, no reason to change it now, not like any 40 mans can be toggled between 10 and 40 where we NEED to tell the difference.
	elseif difficulty == 11 then
		return "heroic5", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 12 then
		return "normal5", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 14 then
		return "normal", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 15 then
		return "heroic", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 16 then
		return "mythic", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 17 then--Variable LFR (ie post WoD zones)
		return "lfr", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 18 then
		return "event40", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 19 then
		return "event5", difficultyName.." - ", difficulty, instanceGroupSize
	elseif difficulty == 20 then
		return "event20", difficultyName.." - ", difficulty, instanceGroupSize
	else--failsafe
		return "normal5", "", difficulty, instanceGroupSize
	end
end

function DBM:UNIT_DIED(args)
	local GUID = args.destGUID
	if self:IsCreatureGUID(GUID) then
		self:OnMobKill(self:GetCIDFromGUID(GUID))
	end
	if self.Options.AFKHealthWarning and GUID == UnitGUID("player") and not IsEncounterInProgress() and UnitIsAFK("player") and self:AntiSpam(5, "AFK") then--You are afk and losing health, some griever is trying to kill you while you are afk/tabbed out.
		PlaySoundFile("Sound\\Creature\\CThun\\CThunYouWillDIe.ogg", "master")--So fire an alert sound to save yourself from this person's behavior.
	end
end
DBM.UNIT_DESTROYED = DBM.UNIT_DIED

----------------------
--  Timer recovery  --
----------------------
do
	local requestedFrom = nil
	local requestTime = 0
	local clientUsed = {}

	function DBM:RequestTimers()
		self:Debug("RequestTimers Running", 2)
		local bestClient
		for i, v in pairs(raid) do
			-- If bestClient player's realm is not same with your's, timer recovery by bestClient not works at all.
			-- SendAddonMessage target channel is "WHISPER" and target player is other realm, no msg sends at all. At same realm, message sending works fine. (Maybe bliz bug or SendAddonMessage function restriction?)
			if v.name ~= playerName and UnitIsConnected(v.id) and (not UnitIsGhost(v.id)) and UnitRealmRelationship(v.id) ~= 2 and v.revision and v.revision >= ((bestClient and bestClient.revision) or 0) and (GetTime() - (clientUsed[v.name] or 0)) > 10 then
				bestClient = v
				clientUsed[v.name] = GetTime()
			end
		end
		if not bestClient then return end
		self:Debug("Requesting timer recovery to "..bestClient.name)
		requestedFrom = bestClient.name
		requestTime = GetTime()
		SendAddonMessage("D4", "RT", "WHISPER", bestClient.name)
	end

	function DBM:ReceiveCombatInfo(sender, mod, time)
		if sender == requestedFrom and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			self:StartCombat(mod, time, "TIMER_RECOVERY")
		end
	end

	function DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, ...)
		if sender == requestedFrom and (GetTime() - requestTime) < 5 then
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
		if sender == requestedFrom and (GetTime() - requestTime) < 5 then
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
		if UnitInBattleground("player") then
			self:SendBGTimers(target)
			return
		end
		if #inCombat < 1 then
			--Break timer is up, so send that
			--But only if we are not in combat with a boss
			if self.Bars:GetBar(DBM_CORE_TIMER_BREAK) then
				local remaining = self.Bars:GetBar(DBM_CORE_TIMER_BREAK).timer
				SendAddonMessage("D4", "BTR2\t"..remaining, "WHISPER", target)
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
end

function DBM:SendBGTimers(target)
	local mod
	if IsActiveBattlefieldArena() then
		mod = self:GetModByName("Arenas")
	else
		-- FIXME: this doesn't work for non-english clients
		local zone = GetRealZoneText():gsub(" ", "")--Does this need updating to mapid arta?
		mod = self:GetModByName(zone)
	end
	if mod and mod.timers then
		self:SendTimerInfo(mod, target)
	end
end

function DBM:SendCombatInfo(mod, target)
	return SendAddonMessage("D4", ("CI\t%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), "WHISPER", target)
end

function DBM:SendTimerInfo(mod, target)
	for i, v in ipairs(mod.timers) do
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
		if GetLocale() == "ptBR" or GetLocale() == "frFR" or GetLocale() == "esES" or GetLocale() == "esMX" or GetLocale() == "itIT" then
			self:Schedule(10, function() if not self.Options.HelpMessageShown2 then self.Options.HelpMessageShown2 = true self:AddMsg(DBM_CORE_NEED_SUPPORT) end end)
		end
		self:Schedule(20, function() if not self.Options.ForumsMessageShown then self.Options.ForumsMessageShown = self.ReleaseRevision self:AddMsg(DBM_FORUMS_MESSAGE) end end)
		self:Schedule(30, function() if not self.Options.SettingsMessageShown then self.Options.SettingsMessageShown = true self:AddMsg(DBM_HOW_TO_USE_MOD) end end)
--		self:Schedule(40, function() if DBM.Options.BugMessageShown < 1 then DBM.Options.BugMessageShown = 1 self:AddMsg(DBM_CORE_BLIZZ_BUGS) end end)
		if type(RegisterAddonMessagePrefix) == "function" then
			if not RegisterAddonMessagePrefix("D4") then -- main prefix for DBM4
				self:AddMsg("Error: unable to register DBM addon message prefix (reached client side addon message filter limit), synchronization will be unavailable") -- TODO: confirm that this actually means that the syncs won't show up
			end
			if not RegisterAddonMessagePrefix("BigWigs") then
				self:AddMsg("Error: unable to register BigWigs addon message prefix (reached client side addon message filter limit), BigWigs version checks will be unavailable")
			end
		end
		if self.Options.sfxDisabled then--Check if sound was disabled by previous session and not re-enabled.
			self.Options.sfxDisabled = nil
			SetCVar("Sound_EnableSFX", 1)
		end
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

	local function getNumRealAlivePlayers()
		local alive = 0
		SetMapToCurrentZone()
		local currentMapId = GetCurrentMapAreaID()
		local currentMapName = GetMapNameByID(currentMapId)
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
				end
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				if select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
				end
			end
		end
		return alive
	end

	local function isOnSameServer(presenceId)
		local toonID, client = select(5, BNGetFriendInfoByID(presenceId))
		if client ~= "WoW" then
			return false
		end
		return GetRealmName() == select(4, BNGetToonInfo(toonID))
	end

	-- sender is a presenceId for real id messages, a character name otherwise
	local function onWhisper(msg, sender, isRealIdMessage)
		if msg == "status" and #inCombat > 0 and DBM.Options.StatusEnabled then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				difficultyText = select(2, DBM:GetCurrentInstanceDifficulty())
			end
			if IsInScenarioGroup() then return end--status not really useful on scenario mods since there is no way to report progress as a percent. We just ignore it.
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
			if mod.numBoss then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			sendWhisper(sender, chatPrefix..DBM_CORE_STATUS_WHISPER:format(difficultyText..(mod.combatInfo.name or ""), hpText, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
		elseif #inCombat > 0 and DBM.Options.AutoRespond and (isRealIdMessage and (not isOnSameServer(sender) or not DBM:GetRaidUnitId(select(4, BNGetFriendInfoByID(sender)))) or not isRealIdMessage and not DBM:GetRaidUnitId(sender)) then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				difficultyText = select(2, DBM:GetCurrentInstanceDifficulty())
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
			if mod.numBoss then
				local bossesKilled = mod.numBoss - mod.vb.bossLeft
				hpText = hpText.." ("..BOSSES_KILLED:format(bossesKilled, mod.numBoss)..")"
			end
			if not autoRespondSpam[sender] then
				if IsInScenarioGroup() then
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

-------------------
--  Chat Filter  --
-------------------
do
	local function filterOutgoing(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			-- we also check if self exists to prevent a possible freeze if the function is called without arguments at all
			-- as this would be even worse than the issue with missing whisper messages ;)
			return filterOutgoing(nil, nil, self, event)
		end
		return msg:sub(1, chatPrefix:len()) == chatPrefix or msg:sub(1, chatPrefixShort:len()) == chatPrefixShort, ...
	end

	local function filterIncoming(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			return filterIncoming(nil, nil, self, event)
		end
		if DBM.Options.SpamBlockBossWhispers then
			return #inCombat > 0 and (msg == "status" or msg:sub(1, chatPrefix:len()) == chatPrefix or msg:sub(1, chatPrefixShort:len()) == chatPrefixShort), ...
		else
			return msg == "status" and #inCombat > 0, ...
		end
	end

	local function filterSayYell(self, event, ...)
		return DBM.Options.FilterSayAndYell and #inCombat > 0, ...
	end

	--This is the source of the taints. As well as function DBM:AddMsg(text, prefix) function
	--It's also required and impossible to avoid since we need this stuff
	--This taint LOOKS like a StaticPopupDialog taint but it is not. That taint was actaully fixed in 5.3
	--Install http://www.wowace.com/addons/notaint/ which embeds libchatanims to fix problem.
	--Additional information at http://www.wowace.com/addons/libchatanims/
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filterSayYell)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filterSayYell)
end

--Raid Boss Emote frame handler for core and BG mods.
--This completely unregisteres or registers event so frame simply does or doesn't show events
--No dirty hooking. Least invasive way to do it. Uses lowest CPU
--Toggle is for if we are turning off or on.
--Custom is for pvp mods to call function without needing global option turned on (such as BG mods option)
--All also handled by core so both core AND pvp mods aren't trying to hook/hide it. Should all be done HERE
do
	local blizzEventsUnregistered = false
	function DBM:HideBlizzardEvents(toggle, custom)
		if toggle == 1 and not blizzEventsUnregistered then
			blizzEventsUnregistered = true
			if self.Options.HideBossEmoteFrame or custom then
				RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
				RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
				RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
			end
			if self.Options.HideGarrisonUpdates or custom then
				AlertFrame:UnregisterEvent("GARRISON_MISSION_FINISHED")
				AlertFrame:UnregisterEvent("GARRISON_BUILDING_ACTIVATABLE")
			end
			if self.Options.HideGuildChallengeUpdates or custom then
				AlertFrame:UnregisterEvent("GUILD_CHALLENGE_COMPLETED")
			end
		elseif toggle == 0 and blizzEventsUnregistered then
			blizzEventsUnregistered = false
			if self.Options.HideBossEmoteFrame or custom then
				RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
				RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_WHISPER")
				RaidBossEmoteFrame:RegisterEvent("CLEAR_BOSS_EMOTES")
			end
			if self.Options.HideGarrisonUpdates then
				AlertFrame:RegisterEvent("GARRISON_MISSION_FINISHED")
				AlertFrame:RegisterEvent("GARRISON_BUILDING_ACTIVATABLE")
			end
			if self.Options.HideGuildChallengeUpdates then
				AlertFrame:RegisterEvent("GUILD_CHALLENGE_COMPLETED")
			end
		end
	end
end

--------------------------
--  Enable/Disable DBM  --
--------------------------
function DBM:Disable(forced)
	unschedule()
	dbmIsEnabled = false
	self.Options.Enabled = false
	if forced then
		blockEnable = true
	end
end

function DBM:Enable()
	if not blockEnable then
		dbmIsEnabled = true
		self.Options.Enabled = true
	end
end

function DBM:IsEnabled()
	return self.Options.Enabled
end

-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix)
	local tag = prefix or (self.localization and self.localization.general.name) or "Deadly Boss Mods"
	local frame = _G[tostring(DBM.Options.ChatFrame)]
	frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
	if prefix ~= false then
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(tag), tostring(text)), 0.41, 0.8, 0.94)
	else
		frame:AddMessage(text, 0.41, 0.8, 0.94)
	end
end

function DBM:Debug(text, level)
	if not self.Options.DebugMode then return end
	if (level or 1) <= DBM.Options.DebugLevel then
		local frame = _G[tostring(DBM.Options.ChatFrame)]
		frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
		frame:AddMessage("|cffff7d0aDBM Debug:|r "..text, 1, 1, 1)
	end
end

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer
	local testCount1
	local testCount2
	local testSpecialWarning1
	local testSpecialWarning2
	local testSpecialWarning3
	function DBM:DemoMode()
		if not testMod then
			testMod = self:NewMod("TestMod")
			self:GetModLocalization("TestMod"):SetGeneralLocalization{ name = "Test Mod" }
			testWarning1 = testMod:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
			testWarning2 = testMod:NewAnnounce("%s", 2, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
			testWarning3 = testMod:NewAnnounce("%s", 3, "Interface\\Icons\\Spell_Fire_SelfDestruct")
			testTimer = testMod:NewTimer(20, "%s", nil, false)
			testCount1 = testMod:NewCountdown(0, 0, nil, nil, nil, true)
			testCount2 = testMod:NewCountdown(0, 0, nil, nil, nil, true, true)
			testSpecialWarning1 = testMod:NewSpecialWarning("%s")
			testSpecialWarning2 = testMod:NewSpecialWarning(" %s ", nil, nil, nil, true)
			testSpecialWarning3 = testMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3) -- hack: non auto-generated special warnings need distinct names (we could go ahead and give them proper names with proper localization entries, but this is much easier)
		end
		testTimer:Start(20, "Pew Pew Pew...")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_Starfall", "Pew Pew Pew...")
		testTimer:Start(10, "Test Bar")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_WispSplode", "Test Bar")
		testTimer:Start(43, "Evil Spell")
		testCount1:Cancel()
		testCount1:Start(43)
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Shadow_ShadesOfDarkness", "Evil Spell")
		testTimer:Start(60, "Boom!")
		testCount2:Cancel()
		testCount2:Start(60)
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Fire_SelfDestruct", "Boom!")
		testWarning1:Cancel()
		testWarning2:Cancel()
		testWarning3:Cancel()
		testSpecialWarning1:Cancel()
		testSpecialWarning2:Cancel()
		testSpecialWarning3:Cancel()
		testWarning1:Show("Test-mode started...")
		testWarning1:Schedule(62, "Test-mode finished!")
		testWarning3:Schedule(50, "Boom in 10 sec!")
		testWarning3:Schedule(20, "Pew Pew Laser Owl!")
		testWarning2:Schedule(38, "Evil Spell in 5 sec!")
		testWarning2:Schedule(43, "Evil Spell!")
		testWarning1:Schedule(10, "Test bar expired!")
		testSpecialWarning1:Schedule(20, "Pew Pew Laser Owl")
		testSpecialWarning2:Schedule(43, "Evil Spell!")
		testSpecialWarning3:Schedule(60, "Boom!")
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
	local specID = GetLootSpecialization()
	local _, _, _, _, _, lootrole = GetSpecializationInfoByID(specID)
	if not InCombatLockdown() and ((IsPartyLFG() and (difficultyIndex == 14 or difficultyIndex == 15)) or not IsPartyLFG()) then
		local tempRole--Use temp role because we still want Role to be "tank" for loot check comparison at bottom (gladiators still use tank gear)
		if role == "TANK" and UnitBuff("player", gladStance) then--Special handling for gladiator stance
			currentSpecGroup = 3 -- give 3rd spec option only for glad stance.
			currentSpecID = 74 -- temp id for glad warrior, bliz not uses it
			tempRole = "DAMAGER"
		end
		local whatToCheck = tempRole or role
		if UnitGroupRolesAssigned("player") ~= whatToCheck then
			UnitSetRole("player", whatToCheck)
		end
	end
	--Loot reminder even if spec isn't known or we are in LFR where we have a valid for role without us being ones that set us.
	if not ignoreLoot and lootrole and (role ~= lootrole) and self.Options.RoleSpecAlert then
		self:AddMsg(DBM_CORE_LOOT_SPEC_REMINDER:format(_G[role] or DBM_CORE_UNKNOWN, _G[lootrole]))
	end
end

--To speed up creating new mods.
function DBM:FindDungeonIDs()
	for i=1, 1000 do
		local dungeon = GetDungeonInfo(i)
		if dungeon then
			self:AddMsg(i..": "..dungeon)
		end
	end
end

function DBM:FindInstanceIDs()
	for i=1, 1000 do
		local instance = EJ_GetInstanceInfo(i)
		if instance then
			self:AddMsg(i..": "..instance)
		end
	end
end

function DBM:FindEncounterIDs(instanceID, diff)
	if not instanceID then
		self:AddMsg("Error: Function requires instanceID be provided")
	end
	local _, instanceType, difficultyID = GetInstanceInfo()
	if not diff then diff = 14 end--Default to "normal" in 6.0 if diff arg not given.
	if difficultyID == 0 then difficultyID = 6 end--EJ in 5.4 considers world bosses as 25man normal
	EJ_SetDifficulty(diff or difficultyID)--Make sure it's set to right difficulty or it'll ignore mobs (ie ra-den if it's not set to heroic). Use user specified one as primary, with curernt zone difficulty as fallback
	for i=1, 25 do
		local name, _, encounterID = EJ_GetEncounterInfoByIndex(i, instanceID)
		if name then
			self:AddMsg(encounterID..": "..name)
		end
	end
end

-------------------
--  Movie Filter --
-------------------
MovieFrame:HookScript("OnEvent", function(self, event, id)
	if event == "PLAY_MOVIE" and id then
		if not IsInInstance() or C_Garrison:IsOnGarrisonMap() or DBM.Options.MovieFilter == "Never" then return end
		if DBM.Options.MovieFilter == "Block" or DBM.Options.MovieFilter == "AfterFirst" and DBM.Options.MoviesSeen[id] then
			MovieFrame_OnMovieFinished(self)
		else
			DBM.Options.MoviesSeen[id] = true
		end
	end
end)

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
				categorySort = {"announce", "announceother", "announcepersonal", "announcerole", "timer", "sound", "misc"},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				countdowns = {},
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

		if tonumber(name) then
			local t = EJ_GetEncounterInfo(tonumber(name))
			if type(nameModifier) == "number" then--Get name form EJ_GetCreatureInfo
				t = select(2, EJ_GetCreatureInfo(nameModifier, tonumber(name)))
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
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
		obj:AddBoolOption("SpeedKillTimer", false, "misc")
		obj:AddBoolOption("HealthFrame", false, "misc")
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
	for i, v in ipairs(self.countdowns) do
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
	self.elapsed = 0
	self.updateInterval = interval or 0
	updateFunctions[self] = func
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
	local diff = DBM:GetCurrentInstanceDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:IsLFR()
	local diff = DBM:GetCurrentInstanceDifficulty()
	if diff == "lfr" or diff == "lfr25" then
		return true
	end
	return false
end

function bossModPrototype:IsNormal()
	local diff = DBM:GetCurrentInstanceDifficulty()
	if diff == "normal" or diff == "normal5" or diff == "normal10" or diff == "normal25" then
		return true
	end
	return false
end

function bossModPrototype:IsHeroic()
	local diff = DBM:GetCurrentInstanceDifficulty()
	if diff == "heroic" or diff == "heroic5" or diff == "heroic10" or diff == "heroic25" then
		return true
	end
	return false
end

function bossModPrototype:IsMythic()
	local diff = DBM:GetCurrentInstanceDifficulty()
	if diff == "mythic" then
		return true
	end
	return false
end

function bossModPrototype:IsEvent()
	local diff = DBM:GetCurrentInstanceDifficulty()
	if diff == "event5" or diff == "event20" or diff == "event40" then
		return true
	end
	return false
end

function bossModPrototype:IsTrivial(level)
	if playerLevel >= level then
		return true
	end
	return false
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

function bossModPrototype:SendWhisper(msg, target)
	return not DBM.Options.DontSendBossWhispers and sendWhisper(target, chatPrefixShort..msg)
end

function bossModPrototype:LatencyCheck()
	return select(4, GetNetStats()) < DBM.Options.LatencyThreshold
end

bossModPrototype.AntiSpam = DBM.AntiSpam
bossModPrototype.GetUnitCreatureId = DBM.GetUnitCreatureId
bossModPrototype.GetCIDFromGUID = DBM.GetCIDFromGUID
bossModPrototype.IsCreatureGUID = DBM.IsCreatureGUID

do
	local bossTargetuIds = {
		"target", "focus", "boss1", "boss2", "boss3", "boss4", "boss5"
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
		if uid and DBM:GetUnitCreatureId(uid) == 24207 then return nil, nil, nil end--filter army of the dead.
		return name, uid, bossuid
	end

	function bossModPrototype:GetBossTarget(cidOrGuid, scanOnlyBoss)
		local name, uid, bossuid
		if type(cidOrGuid) == "number" then
			local cidOrGuid = cidOrGuid or self.creatureId
			local cacheuid = bossuIdCache[cidOrGuid] or "boss1"
			if self:GetUnitCreatureId(cacheuid) == cidOrGuid then
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
		return name, uid, bossuid
	end

	function bossModPrototype:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, includeTank, isFinalScan)
		--Increase scan count
		local cidOrGuid = cidOrGuid or self.creatureId
		if not cidOrGuid then return end
		if not targetScanCount[cidOrGuid] then targetScanCount[cidOrGuid] = 0 end
		targetScanCount[cidOrGuid] = targetScanCount[cidOrGuid] + 1
		--Set default values
		local scanInterval = scanInterval or 0.05
		local scanTimes = scanTimes or 16
		local targetname, targetuid, bossuid = self:GetBossTarget(cidOrGuid, scanOnlyBoss)
		--Do scan
		if targetname and targetname ~= DBM_CORE_UNKNOWN then
			if not IsInGroup() then scanTimes = 1 end--Solo, no reason to keep scanning, give faster warning. But only if first scan is actually a valid target, which is why i have this check HERE
			if (isEnemyScan and UnitIsFriend("player", targetuid) or self:IsTanking(targetuid, bossuid)) and not isFinalScan and not includeTank then--On player scan, ignore tanks. On enemy scan, ignore friendly player.
				if targetScanCount[cidOrGuid] < scanTimes then--Make sure no infinite loop.
					self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, includeTank)--Scan multiple times to be sure it's not on something other then tank (or friend on enemy scan).
				else--Go final scan.
					self:BossTargetScanner(cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, includeTank, true)
				end
			else--Scan success. (or failed to detect right target.) But some spells can be used on tanks, anyway warns tank if player scan. (enemy scan block it)
				targetScanCount[cidOrGuid] = nil--Reset count for later use.
				self:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)--Unschedule all checks just to be sure none are running, we are done.
				if not (isEnemyScan and isFinalScan) then--If enemy scan, player target is always bad. So do not warn anything. Also, must filter nil value on returnFunc.
					self[returnFunc](self, targetname, targetuid, bossuid)--Return results to warning function with all variables.
				end
			end
		else--target was nil, lets schedule a rescan here too.
			if targetScanCount[cidOrGuid] < scanTimes then--Make sure not to infinite loop here as well.
				self:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, includeTank)
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

function bossModPrototype:CheckNearby(range, targetname)
	local uId = DBM:GetRaidUnitId(targetname)
	if uId then
		local inRange = DBM.RangeCheck:GetDistance("player", uId)
		if inRange and inRange < range then
			return true
		end
	end
	return false
end

--Now this function works perfectly. But have some limitation due to DBM.RangeCheck:GetDistance() function.
--Unfortunely, DBM.RangeCheck:GetDistance() function cannot reflects altitude difference. This makes range unreliable.
--So, we need to cafefully check range in difference altitude (Espcially, tower top and bottom)
do
	local rangeCache = {}
	local rangeUpdated = {}

	function bossModPrototype:CheckTankDistance(cidOrGuid, distance, defaultReturn)
		if not DBM.Options.DontShowFarWarnings then return true end--Global disable.
		if rangeCache[cidOrGuid] and (GetTime() - (rangeUpdated[cidOrGuid] or 0)) < 2 then -- return same range within 2 sec call
			if rangeCache[cidOrGuid] > distance then
				return false
			else
				return true
			end
		else
			local cidOrGuid = cidOrGuid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
			local distance = distance or 40
			local uId
			local _, fallbackuId, mobuId = self:GetBossTarget(cidOrGuid)
			if mobuId then--Have a valid mob unit ID
				--First, use trust threat more than fallbackuId and see what we pull from it first.
				--This is because for CheckTankDistance we want to know who is tanking it, not who it's targeting it.
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
				local x, y = UnitPosition(uId)
				if not x then--Failed to pull coords. This is likely a pet or a guardian or an NPC.
					local inRange2, checkedRange = UnitInRange(uId)--Use an API that works on pets and some NPCS (npcs that get a party/raid/pet ID)
					if inRange2 and checkedRange then
					end
					if checkedRange and not inRange2 then--checkedRange only returns true if api worked, so if we get false, true then we are not near npc
						return false
					else--Its probably a totem or just something we can't assess. Fall back to no filtering
						return true
					end
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)--We check how far we are from the tank who has that boss
				rangeCache[cidOrGuid] = inRange
				rangeUpdated[cidOrGuid] = GetTime()
				if inRange and (inRange > distance) then--You are not near the person tanking boss
					return false
				end
				--Tank in range, return true.
				return true
			end
			return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire. But some spells will prefer not to fire(i.e : Galakras tower spell), we can define it on this function calling.
		end
	end
end

do
	local frame = CreateFrame("Frame", "DBMShields") -- frame for CLEU events, we don't want to run all *_MISSED events through the whole DBM event system...

	local activeShields = {}
	local shieldsByGuid = {}

	frame:SetScript("OnEvent", function(self, _, _, subEvent, _, _, _, _, _, destGUID, _, _, _, ...)
		local info = destGUID and shieldsByGuid[destGUID]
		if info then
			if info.maxAbsorb then
				local _, absorbed
				if subEvent == "SWING_MISSED" then
					_, _, _, absorbed = ...
				elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then
					_, _, _, _, _, _, absorbed = ...
				end
				if absorbed then
					info.absorbRemaining = info.absorbRemaining - absorbed
				end
			elseif info.maxDamage then
				local _, damage
				if subEvent == "SWING_DAMAGE" then 
					damage = ...
				elseif subEvent == "RANGE_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_PERIODIC_DAMAGE" then 
					_, _, _, damage = ...
				end
				if damage then
					info.damageRemaining = info.damageRemaining - damage
				end
			elseif info.maxHeal then
				local _, absorbed
				if subEvent == "SPELL_HEAL" or subEvent == "SPELL_PERIODIC_HEAL" then
					_, _, _, _, _, absorbed = ...
				end
				if absorbed then
					info.healed = info.healed + absorbed
				end
			end
		end
	end)

	local function getShieldHPFunc(info)
		return function()
			return mmax(1, floor(info.absorbRemaining / info.maxAbsorb * 100))
		end
	end

	function bossModPrototype:ShowShieldHealthBar(guid, name, absorb)
		self:RemoveShieldHealthBar(guid, name)
		if #activeShields == 0 then
			frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
		local obj = {
			mod = self.id,
			name = name,
			guid = guid,
			absorbRemaining = absorb,
			maxAbsorb = absorb,
		}
		obj.func = getShieldHPFunc(obj)
		activeShields[#activeShields + 1] = obj
		shieldsByGuid[guid] = obj
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(obj.func, name)
		end
	end

	function bossModPrototype:RemoveShieldHealthBar(guid, name)
		if not guid then
			self:RemoveAllSpecialHealthBars()
		else
			shieldsByGuid[guid] = nil
			for i = #activeShields, 1, -1 do
				if activeShields[i].guid == guid and activeShields[i].mod == self.id and (not name or activeShields[i].name == name) then
					if DBM.BossHealth:IsShown() then
						DBM.BossHealth:RemoveBoss(activeShields[i].func)
					end
					tremove(activeShields, i)
				end
			end
			if #activeShields == 0 then
				frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			end
		end
	end

	local function getDamagedHPFunc(info)
		return function()
			return mmax(1, floor(info.damageRemaining / info.maxDamage * 100))
		end
	end

	function bossModPrototype:ShowDamagedHealthBar(guid, name, damage)
		self:RemoveDamagedHealthBar(guid, name)
		if #activeShields == 0 then
			frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
		local obj = {
			mod = self.id,
			name = name,
			guid = guid,
			damageRemaining = damage,
			maxDamage = damage,
		}
		obj.func = getDamagedHPFunc(obj)
		activeShields[#activeShields + 1] = obj
		shieldsByGuid[guid] = obj
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(obj.func, name)
		end
	end
	bossModPrototype.RemoveDamagedHealthBar = bossModPrototype.RemoveShieldHealthBar

	local function getHealedHPFunc(info)
		return function()
			return mmax(1, floor(info.healed / info.maxHeal * 100))
		end
	end

	function bossModPrototype:ShowAbsorbedHealHealthBar(guid, name, heal)
		self:RemoveAbsorbedHealHealthBar(guid, name)
		if #activeShields == 0 then
			frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
		local obj = {
			mod = self.id,
			name = name,
			guid = guid,
			healed = 0,
			maxHeal = heal,
		}
		obj.func = getHealedHPFunc(obj)
		activeShields[#activeShields + 1] = obj
		shieldsByGuid[guid] = obj
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(obj.func, name)
		end
	end
	bossModPrototype.RemoveAbsorbedHealHealthBar = bossModPrototype.RemoveShieldHealthBar

	-- removes all shield, damaged, healed bars of a boss mod
	function bossModPrototype:RemoveAllSpecialHealthBars()
		frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		for i = #activeShields, 1, -1 do
			if activeShields[i].mod == self.id then
				if DBM.BossHealth:IsShown() then
					DBM.BossHealth:RemoveBoss(activeShields[i].func)
				end
				shieldsByGuid[activeShields[i].guid] = nil
				tremove(activeShields, i)
			end
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
		["Melee"] = true,
		["MeleeDps"] = true,
		["Physical"] = true,
		["Ranged"] = true,
		["RangedDps"] = true,
		["ManaUser"] = true,
		["SpellCaster"] = true,
		["RaidCooldown"] = true,
		["RemovePoison"] = true,
		["RemoveDisease"] = true,
		["RemoveEnrage"] = true,
		["RemoveCurse"] = true,
		["MagicDispeller"] = true
	}]]

	local specRoleTable = {
		[62] = {	--Aracne Mage
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Amplify Magic
			["RemoveCurse"] = true,
			["MagicDispeller"] = true,
		},
		[65] = {	--Holy Paladin
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Devotion Aura
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
		},
		[66] = {	--Protection Paladin
			["Tank"] = true,
			["Melee"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
		},
		[70] = {	--Retribution Paladin
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
		},
		[71] = {	--Arms Warrior
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["RaidCooldown"] = true,--Rallying Cry
			["Physical"] = true,
		},
		[73] = {	--Protection Warrior
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["MagicDispeller"] = true,
		},
		[74] = {	--Gladiator Warrior
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[102] = {	--Balance Druid
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RemoveEnrage"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
		},
		[103] = {	--Feral Druid
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["RemoveEnrage"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
		},
		[104] = {	--Guardian Druid
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
		},
		[105] = {	-- Restoration Druid
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Tranquility
			["RemoveEnrage"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
		},
		[250] = {	--Blood DK
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
		},
		[251] = {	--Frost DK
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[253] = {	--Beastmaster Hunter
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
			["RemoveEnrage"] = true,
			["MagicDispeller"] = true,
		},
		[256] = {	--Discipline Priest
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Power Word: Barrier(Discipline) / Divine Hymn (Holy)
			["RemoveDisease"] = true,
			["MagicDispeller"] = true,
		},
		[258] = {	--Shadow Priest
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["MagicDispeller"] = true,
		},
		[259] = {	--Assassination Rogue
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["RaidCooldown"] = true,--Smoke Bomb
			["Physical"] = true,
			["RemoveEnrage"] = true,
		},
		[262] = {	--Elemental Shaman
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RemoveCurse"] = true,
			["MagicDispeller"] = true,
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
		},
		[264] = {	--Restoration Shaman
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Spirit Link Totem
			["RemoveCurse"] = true,
			["MagicDispeller"] = true,
		},
		[265] = {	--Affliction Warlock
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
		},
		[268] = {	--Brewmaster Monk
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
		},
		[269] = {	--Windwalker Monk
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
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
		},
	}
	specRoleTable[63] = specRoleTable[62]--Frost Mage
	specRoleTable[64] = specRoleTable[62]--Fire Mage
	specRoleTable[72] = specRoleTable[71]--Fury Warrior
	specRoleTable[252] = specRoleTable[251]--Unholy DK
	specRoleTable[254] = specRoleTable[253]--Markmanship Hunter
	specRoleTable[255] = specRoleTable[253]--Survival Hunter
	specRoleTable[257] = specRoleTable[256]--Holy Priest
	specRoleTable[260] = specRoleTable[259]--Combat Rogue
	specRoleTable[261] = specRoleTable[259]--Subtlety Rogue
	specRoleTable[266] = specRoleTable[265]--Demonology Warlock
	specRoleTable[267] = specRoleTable[265]--Destruction Warlock

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

	function bossModPrototype:IsMelee()
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
end

function bossModPrototype:IsTank()
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	if role == "TANK" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsDps()
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	if role == "DAMAGER" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsHealer()
	if not currentSpecID then
		DBM:SetCurrentSpecInfo()
	end
	local _, _, _, _, _, role = GetSpecializationInfoByID(currentSpecID)
	if role == "HEALER" then
		return true
	else
		return false
	end
end

function bossModPrototype:IsTanking(unit, boss)
	if not unit then return false end
	--Prefer threat target first
	if boss and UnitExists(boss) then--Only checking one bossID as requested
		local tanking, status = UnitDetailedThreatSituation(unit, boss)
		if tanking or (status == 3) then
			return true
		end
	else--Check all of them if one isn't defined
		for i = 1, 5 do
			if UnitExists("boss"..i) then
				local tanking, status = UnitDetailedThreatSituation(unit, "boss"..i)
				if tanking or (status == 3) then
					return true
				end
			end
		end
	end
	--Use these as fallback if threat target not found
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	return false
end

----------------------------
--  Boss Health Function  --
----------------------------
function DBM:GetBossHP(cId)
	local uId = bossHealthuIdCache[cId] or "target"
	if self:GetCIDFromGUID(UnitGUID(uId)) == cId and UnitHealthMax(uId) ~= 0 then
		if bossHealth[cId] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return bossHealth[cId], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[cId] = hp
		return hp, uId, UnitName(uId)
	elseif self:GetCIDFromGUID(UnitGUID("focus")) == cId and UnitHealthMax("focus") ~= 0 then
		if bossHealth[cId] and (UnitHealth("focus") == 0  and not UnitIsDead("focus")) then return bossHealth[cId], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		bossHealth[cId] = hp
		return hp, "focus", UnitName("focus")
	else
		for i = 1, 5 do
			local guid = UnitGUID("boss"..i)
			if self:GetCIDFromGUID(guid) == cId and UnitHealthMax("boss"..i) ~= 0 then
				if bossHealth[cId] and (UnitHealth("boss"..i) == 0 and not UnitIsDead("boss"..i)) then return bossHealth[cId], "boss"..i, UnitName("boss"..i) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth("boss"..i) / UnitHealthMax("boss"..i) * 100
				bossHealth[cId] = hp
				bossHealthuIdCache[cId] = "boss"..i
				return hp, "boss"..i, UnitName("boss"..i)
			end
		end
		local idType = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local guid = UnitGUID(unitId)
			if self:GetCIDFromGUID(guid) == cId and UnitHealthMax(unitId) ~= 0 then
				if bossHealth[cId] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[cId], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				bossHealth[cId] = hp
				bossHealthuIdCache[cId] = unitId
				return hp, unitId, UnitName(unitId)
			end
		end
	end
	return nil
end

function DBM:GetBossHPByGUID(guid)
	local uId = bossHealthuIdCache[guid] or "target"
	if UnitGUID(uId) == guid and UnitHealthMax(uId) ~= 0 then
		if bossHealth[guid] and (UnitHealth(uId) == 0 and not UnitIsDead(uId)) then return bossHealth[guid], uId, UnitName(uId) end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		bossHealth[guid] = hp
		return hp, uId, UnitName(uId)
	elseif UnitGUID("focus") == guid and UnitHealthMax("focus") ~= 0 then
		if bossHealth[guid] and (UnitHealth("focus") == 0  and not UnitIsDead("focus")) then return bossHealth[guid], "focus", UnitName("focus") end--Return last non 0 value if value is 0, since it's last valid value we had.
		local hp = UnitHealth("focus") / UnitHealthMax("focus") * 100
		bossHealth[guid] = hp
		return hp, "focus", UnitName("focus")
	else
		for i = 1, 5 do
			local guid2 = UnitGUID("boss"..i)
			if guid == guid2 and UnitHealthMax("boss"..i) ~= 0 then
				if bossHealth[guid] and (UnitHealth("boss"..i) == 0 and not UnitIsDead("boss"..i)) then return bossHealth[guid], "boss"..i, UnitName("boss"..i) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth("boss"..i) / UnitHealthMax("boss"..i) * 100
				bossHealth[guid] = hp
				bossHealthuIdCache[guid] = "boss"..i
				return hp, "boss"..i, UnitName("boss"..i)
			end
		end
		local idType = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local unitId = ((i == 0) and "target") or idType..i.."target"
			local guid2 = UnitGUID(unitId)
			if guid == guid2 and UnitHealthMax(unitId) ~= 0 then
				if bossHealth[guid] and (UnitHealth(unitId) == 0 and not UnitIsDead(unitId)) then return bossHealth[guid], unitId, UnitName(unitId) end--Return last non 0 value if value is 0, since it's last valid value we had.
				local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
				bossHealth[guid] = hp
				bossHealthuIdCache[guid] = unitId
				return hp, unitId, UnitName(unitId)
			end
		end
	end
	return nil
end

function DBM:GetBossHPByUnitID(uId)
	local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
	bossHealth[uId] = hp
	return hp, uId, UnitName(uId)
end

function bossModPrototype:SetBossHealthInfo(...)
	self.bossHealthInfo = {...}
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
bossModPrototype.GetBossHPByGUID = DBM.GetBossHPByGUID

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

	local font1elapsed, font2elapsed, font3elapsed, moving

	local function fontHide1()
		local duration = DBM.Options.WarningDuration
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
		local duration = DBM.Options.WarningDuration
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
		local duration = DBM.Options.WarningDuration
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
			frame.font1ticker = frame.font1ticker or C_Timer.NewTicker(0.05, fontHide1)
		elseif not frame.font2ticker then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			font2u:Show()
			added = true
			frame.font2ticker = frame.font2ticker or C_Timer.NewTicker(0.05, fontHide2)
		elseif not frame.font3ticker or force then
			font3elapsed = 0
			font3.lastUpdate = GetTime()
			font3:SetText(text)
			font3:Show()
			font3u:Show()
			fontHide3()
			added = true
			frame.font3ticker = frame.font3ticker or C_Timer.NewTicker(0.05, fontHide3)
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
		local function moveEnd()
			moving = false
			anchorFrame:Hide()
			if anchorFrame.ticker then
				anchorFrame.ticker:Cancel()
				anchorFrame.ticker = nil
			end
			font1elapsed = DBM.Options.WarningDuration
			font2elapsed = DBM.Options.WarningDuration
			font3elapsed = DBM.Options.WarningDuration
			frame:SetFrameStrata("HIGH")
			DBM:Unschedule(moveEnd)
			DBM.Bars:CancelBar(DBM_CORE_MOVE_WARNING_BAR)
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
					self:Schedule(15, moveEnd)
					self.Bars:CreateBar(15, DBM_CORE_MOVE_WARNING_BAR)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd()
			else
				moving = true
				anchorFrame:Show()
				anchorFrame.ticker = anchorFrame.ticker or C_Timer.NewTicker(5, function() DBM:AddWarning(DBM_CORE_MOVE_WARNING_MESSAGE) end)
				DBM:AddWarning(DBM_CORE_MOVE_WARNING_MESSAGE)
				self:Schedule(15, moveEnd)
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

	-- TODO: this function is an abomination, it needs to be rewritten. Also: check if these work-arounds are still necessary
	function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
		if not self.option or self.mod.Options[self.option] then
			if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
			local argTable = {...}
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			if #self.combinedtext > 0 then
				--Throttle spam.
				local combinedText = table.concat(self.combinedtext, "<, >")
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
						if DBM:GetRaidClass(name) then
							local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)] or color
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
				if DBM.Options.ShowFakedRaidWarnings then
					for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
						local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
						if frame ~= RaidWarningFrame and frame:GetScript("OnEvent") then
							frame:GetScript("OnEvent")(frame, "CHAT_MSG_RAID_WARNING", text, playerName, GetDefaultLanguage("player"), "", playerName, "", 0, 0, "", 0, 99, UnitGUID("player"))
						end
					end
				else
					self.mod:AddMsg(text, nil)
				end
			end
			if self.sound then
				if DBM.Options.UseMasterVolume then
					PlaySoundFile(DBM.Options.RaidWarningSound, "Master")
				else
					PlaySoundFile(DBM.Options.RaidWarningSound)
				end
			end
			--This callback sucks, it needs useful information for external mods to listen to it better, such as mod and spellid
			fireEvent("DBM_Announce", message)
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function announcePrototype:CombinedShow(delay, ...)
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

	function announcePrototype:Cancel(...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName, noSound)
		if not text then
			error("NewAnnounce: you must provide announce text", 2)
			return
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				sound = not noSound,
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
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

	-- new constructor (auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, noSound, optionVersion)
		if not spellId then
			error("newAnnounce: you must provide spellId", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, noSound = color, icon, optionDefault, optionName, castTime, preWarnTime, noSound, temp
		end
		local unparsedId = spellId
		local spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellId = string.sub(spellId, 3)
			spellName = EJ_GetSectionInfo(spellId) or DBM_CORE_UNKNOWN
		else
			spellName = GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		end
		icon = icon or unparsedId
		local text
		if announceType == "cast" then
			local spellHaste = select(4, GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			local timer = (select(4, GetSpellInfo(spellId)) or 1000) / spellHaste
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(tostring(preWarnTime or 5)))
			end
		elseif announceType == "phase" or announceType == "prephase" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
		elseif announceType == "phasechange" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell
		else
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
				sound = not noSound,
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
			obj.option = catType..unparsedId..announceType..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, catType)
			self.localization.options[obj.option] = DBM_CORE_AUTO_ANNOUNCE_OPTIONS[announceType]:format(unparsedId)
		end
		tinsert(self.announces, obj)
		return obj
	end

	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 2, ...)
	end

	function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcount", spellId, color or 2, ...)
	end

	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 3, ...)
	end

	function bossModPrototype:NewEndAnnounce(spellId, color, ...)
		return newAnnounce(self, "ends", spellId, color or 3, ...)
	end

	function bossModPrototype:NewEndTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "endtarget", spellId, color or 3, ...)
	end

	function bossModPrototype:NewFadesAnnounce(spellId, color, ...)
		return newAnnounce(self, "fades", spellId, color or 3, ...)
	end

	function bossModPrototype:NewAddsLeftAnnounce(spellId, color, ...)
		return newAnnounce(self, "adds", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "count", spellId, color or 3, ...)
	end

	function bossModPrototype:NewStackAnnounce(spellId, color, ...)
		return newAnnounce(self, "stack", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName, noArg, noSound, optionVersion)
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, color, castTime, icon, optionDefault, optionName, noArg, noSound = color, castTime, icon, optionDefault, optionName, noArg, noSound, temp
		end
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime, nil, noSound, optionVersion)
	end

	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 1, ...)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName, noArg, noSound, optionVersion)
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, time, color, icon, optionDefault, optionName, noArg, noSound = time, color, icon, optionDefault, optionName, noArg, noSound, temp
		end
		return newAnnounce(self, "prewarn", spellId, color or 1, icon, optionDefault, optionName, nil, time, noSound, optionVersion)
	end

	function bossModPrototype:NewPhaseAnnounce(phase, color, icon, ...)
		return newAnnounce(self, "phase", phase, color or 1, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

	function bossModPrototype:NewPhaseChangeAnnounce(color, icon, ...)
		return newAnnounce(self, "phasechange", 0, color or 1, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

	function bossModPrototype:NewPrePhaseAnnounce(phase, color, icon, ...)
		return newAnnounce(self, "prephase", phase, color or 1, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end
end

--------------------
--  Sound Object  --
--------------------
do
	--Sound Object (basically only used by countdown now)
	local soundPrototype = {}
	local mt = { __index = soundPrototype }
	function bossModPrototype:NewSound(spellId, optionDefault, optionName)
		if not (optionName == false) then--Basically, all mods still using NewSound.
			-- Because there are going to be users who update core and not old mods, we need to check and alert
			--I'll try to avoid this as much as possible by removing NewSound from all old mods in advance of dbm core update
			print("Error, NewSound depricated. Update your old DBM mods to remove this error")
			return
		end
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		return obj
	end

	function soundPrototype:Play(file)
		if DBM.Options.UseMasterVolume then
			PlaySoundFile(file, "Master")
		else
			PlaySoundFile(file)
		end
	end

	function soundPrototype:Schedule(t, ...)
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype:Cancel(...)
		return unschedule(self.Play, self.mod, self, ...)
	end

	--Voice Object
	--Individual options still generated in case a person likes to enable voice, but not for ALL warnings (they can pick and choose what is enabled/disabled"
	local soundPrototype2 = {}
	local mt = { __index = soundPrototype2 }
	function bossModPrototype:NewVoice(spellId, optionDefault, optionName, optionVersion)
		if not spellId and not optionName then
			error("NewVoice: you must provide either spellId or optionName", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, optionDefault, optionName = optionDefault, optionName, temp
		end
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if #DBM.Voices < 2 then optionName = false end--Hide options if no voice packs are installed
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound")
		elseif not (optionName == false) then
			obj.option = "Voice"..spellId..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "sound")
			self.localization.options[obj.option] = DBM_CORE_AUTO_VOICE_OPTION_TEXT:format(spellId)
		end
		return obj
	end

	--If no file at path, it should silenty fail. However, I want to try to only add NewVoice to mods for files that already exist.
	function soundPrototype2:Play(name)
		local voice = DBM.Options.ChosenVoicePack
		local always = DBM.Options.AlwaysPlayVoice
		if voice == "None" then return end
		--Filter tank specific voice alerts for non tanks if tank filter enabled
		--But still allow AlwaysPlayVoice to play as well.
		if (name == "changemt" or name == "tauntboss") and DBM.Options.FilterTankSpec and not self.mod:IsTank() and not always then return end
		if not self.option or self.mod.Options[self.option] or always then
			local path = "Interface\\AddOns\\DBM-VP"..voice.."\\"..name..".ogg"
				--Example "Interface\\AddOns\\DBM-VPHenry\\dispelnow.ogg"
				--Usage: voiceBerserkerRush:Play("dispelnow")
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(path, "Master")
			else
				PlaySoundFile(path)
			end
		end
	end

	function soundPrototype2:Schedule(t, ...)
		if DBM.Options.ChosenVoicePack == "None" then return end
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype2:Cancel(...)
		if DBM.Options.ChosenVoicePack == "None" then return end
		return unschedule(self.Play, self.mod, self, ...)
	end
end

----------------------------
--  Countdown/out object  --
----------------------------
do
	local countdownProtoType = {}
	local mt = {__index = countdownProtoType}

	local function showCountdown(timer)
		TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
	end

	local function stopCountdown()
		TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
	end

	function countdownProtoType:Start(timer, count)
		if not self.option or self.mod.Options[self.option] then
			timer = timer or self.timer or 10
			timer = timer < 2 and self.timer or timer
			count = count or self.count or 5
			if timer <= count then count = floor(timer) end
			if DBM.Options.ShowCountdownText and not (self.textDisabled or self.alternateVoice) and self.type ~= "Countout" then
				stopCountdown()
				if timer >= count then
					DBM:Schedule(timer-count, showCountdown, count)
				else
					DBM:Schedule(timer%1, showCountdown, floor(timer))
				end
			end
			if DBM.Options.DontPlayCountdowns then return end
			local voice = DBM.Options.CountdownVoice
			local voice2 = DBM.Options.CountdownVoice2
			local voice3 = DBM.Options.CountdownVoice3
			if self.alternateVoice == 2 then
				voice = voice2
			end
			if self.alternateVoice == 3 then
				voice = voice3
			end
			if voice == "Mosh" then--Voice only goes to 5
				if self.type == "Countout" then
					for i = 1, timer do
						if i < 6 then
							self.sound5:Schedule(i, "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\"..i..".ogg")
						end
					end
				else
					for i = count, 1, -1 do
						if i <= 5 then
							self.sound5:Schedule(timer-i, "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\"..i..".ogg")
						end
					end
				end
			elseif voice:find("VP:") then--voice pack voice
				local _, voiceValue = string.split(":", voice)
				if self.type == "Countout" then
					for i = 1, timer do
						if i < 11 then
							self.sound5:Schedule(i, "Interface\\AddOns\\DBM-VP"..voiceValue.."\\count\\"..i..".ogg")
						end
					end
				else
					for i = count, 1, -1 do
						self.sound5:Schedule(timer-i, "Interface\\AddOns\\DBM-VP"..voiceValue.."\\count\\"..i..".ogg")
					end
				end
			else--Voice that goes to 10
				if self.type == "Countout" then
					for i = 1, timer do
						if i < 11 then
							self.sound5:Schedule(i, "Interface\\AddOns\\DBM-Core\\Sounds\\"..voice.."\\"..i..".ogg")
						end
					end
				else
					for i = count, 1, -1 do
						self.sound5:Schedule(timer-i, "Interface\\AddOns\\DBM-Core\\Sounds\\"..voice.."\\"..i..".ogg")
					end
				end
			end
		end
	end
	countdownProtoType.Show = countdownProtoType.Start

	function countdownProtoType:Schedule(t)
		return schedule(t, self.Start, self.mod, self)
	end

	function countdownProtoType:Cancel()
		if DBM.Options.ShowCountdownText and not self.textDisabled then
			DBM:Unschedule(showCountdown)
			stopCountdown()
		end
		self.mod:Unschedule(self.Start, self)
		self.sound5:Cancel()
	end
	countdownProtoType.Stop = countdownProtoType.Cancel

	local function newCountdown(self, countdownType, timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
		if not spellId and not optionName then
			error("NewCountdown: you must provide either spellId or optionName", 2)
			return
		end
		if type(timer) == "string" and timer:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(timer, 14)
			timer, spellId, optionDefault, optionName, count, textDisabled, altVoice = spellId, optionDefault, optionName, count, textDisabled, altVoice, temp
		end
		if altVoice == true then altVoice = 2 end--Compat
		if type(timer) == "string" and timer:match("AltTwo") then
			altVoice = 3
			timer = tonumber(string.sub(timer, 7))
		elseif type(timer) == "string" and timer:match("Alt") then
			altVoice = 2
			timer = tonumber(string.sub(timer, 4))
		end
		local sound5 = self:NewSound(5, true, false)
		timer = timer or 10
		count = count or 5
		spellId = spellId or 39505
		local obj = setmetatable(
			{
				id = optionName or countdownType..spellId..(optionVersion or ""),
				type = countdownType,
				sound5 = sound5,
				timer = timer,
				count = count,
				textDisabled = textDisabled,
				alternateVoice = altVoice,
				mod = self
			},
			mt
		)
		if optionName then
			obj.option = obj.id
			self:AddBoolOption(obj.option, optionDefault, "sound")
		elseif not (optionName == false) then
			obj.option = obj.id
			self:AddBoolOption(obj.option, optionDefault, "sound")
			if countdownType == "Countdown" then
				self.localization.options[obj.option] = DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(spellId)
			elseif countdownType == "CountdownFades" then
				self.localization.options[obj.option] = DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2:format(spellId)
			elseif countdownType == "Countout" then
				self.localization.options[obj.option] = DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT:format(spellId)
			end
		end
		tinsert(self.countdowns, obj)
		return obj
	end

	function bossModPrototype:NewCountdown(timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
		return newCountdown(self, "Countdown", timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
	end

	function bossModPrototype:NewCountdownFades(timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
		return newCountdown(self, "CountdownFades", timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
	end

	function bossModPrototype:NewCountout(timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
		return newCountdown(self, "Countout", timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
	end
end

--------------------
--  Yell Object  --
--------------------
do
	local yellPrototype = {}
	local mt = { __index = yellPrototype }
	function bossModPrototype:NewYell(spellId, yellText, optionDefault, optionName, chatType, optionVersion)
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, yellText, optionDefault, optionName, chatType = yellText, optionDefault, optionName, chatType, temp
		end
		local displayText
		if not yellText then
			if type(spellId) == "string" and spellId:match("ej%d+") then
				displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT:format(EJ_GetSectionInfo(string.sub(spellId, 3)) or DBM_CORE_UNKNOWN)
			else
				displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT:format(GetSpellInfo(spellId) or DBM_CORE_UNKNOWN)
			end
		end
		local obj = setmetatable(
			{
				text = displayText or yellText,
				mod = self,
				chatType = chatType
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "misc")
		elseif not (optionName == false) then
			obj.option = "Yell"..(spellId or yellText)..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "misc")
			self.localization.options[obj.option] = DBM_CORE_AUTO_YELL_OPTION_TEXT:format(spellId)
		end
		return obj
	end

	function yellPrototype:Yell(...)
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(self.text:format(...), self.chatType or "SAY")
		end
	end

	function yellPrototype:Schedule(t, ...)
		return schedule(t, self.Yell, self.mod, self, ...)
	end

	function yellPrototype:Cancel(...)
		return unschedule(self.Yell, self.mod, self, ...)
	end

	yellPrototype.Show = yellPrototype.Yell
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
		local duration = DBM.Options.SpecialWarningDuration
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
		local duration = DBM.Options.SpecialWarningDuration
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
		font1:SetFont(self.Options.SpecialWarningFont, self.Options.SpecialWarningFontSize, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
		font2:SetFont(self.Options.SpecialWarningFont, self.Options.SpecialWarningFontSize, self.Options.SpecialWarningFontStyle == "None" and nil or self.Options.SpecialWarningFontStyle)
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
			frame.font1ticker = frame.font1ticker or C_Timer.NewTicker(0.05, fontHide1)
		elseif not frame.font2ticker or force then
			font2elapsed = 0
			font2.lastUpdate = GetTime()
			font2:SetText(text)
			font2:Show()
			added = true
			frame.font2ticker = frame.font2ticker or C_Timer.NewTicker(0.05, fontHide2)
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
		local function moveEnd()
			moving = false
			anchorFrame:Hide()
			font1elapsed = DBM.Options.SpecialWarningDuration
			font2elapsed = DBM.Options.SpecialWarningDuration
			frame:SetFrameStrata("HIGH")
			DBM:Unschedule(moveEnd)
			DBM.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
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
					self:Schedule(15, moveEnd)
					self.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd()
			else
				moving = true
				anchorFrame:Show()
				DBM:AddSpecialWarning(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
				DBM:AddSpecialWarning(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
				self:Schedule(15, moveEnd)
				self.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
			end
		end
	end

	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	function specialWarningPrototype:Show(...)
		if DBM.Options.ShowSpecialWarnings and (not self.option or self.mod.Options[self.option]) and not moving and frame then
			if self.announceType == "taunt" and DBM.Options.FilterTankSpec and not self.mod:IsTank() then return end--Don't tell non tanks to taunt, ever.
			local argTable = {...}
			if #self.combinedtext > 0 then
				--Throttle spam.
				local combinedText = table.concat(self.combinedtext, "<, >")
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
			local msg = pformat(self.text, unpack(argTable))
			local text = msg:gsub(">.-<", stripServerName)
			DBM:AddSpecialWarning(text)
			self.combinedcount = 0
			self.combinedtext = {}
			if DBM.Options.ShowSWarningsInChat then
				local colorCode = ("|cff%.2x%.2x%.2x"):format(DBM.Options.SpecialWarningFontCol[1] * 255, DBM.Options.SpecialWarningFontCol[2] * 255, DBM.Options.SpecialWarningFontCol[3] * 255)
				self.mod:AddMsg(colorCode.."["..DBM_CORE_MOVE_SPECIAL_WARNING_TEXT.."] "..text.."|r", nil)
			end
			if not UnitIsDeadOrGhost("player") and DBM.Options.ShowFlashFrame then
				if self.flash == 1 then
					local repeatCount = DBM.Options.SpecialWarningFlashRepeat1 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol1[1],DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3], DBM.Options.SpecialWarningFlashDura1, DBM.Options.SpecialWarningFlashAlph1, repeatCount)
				elseif self.flash == 2 then
					local repeatCount = DBM.Options.SpecialWarningFlashRepeat2 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol2[1],DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3], DBM.Options.SpecialWarningFlashDura2, DBM.Options.SpecialWarningFlashAlph2, repeatCount)
				elseif self.flash == 3 then
					local repeatCount = DBM.Options.SpecialWarningFlashRepeat3 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol3[1],DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3], DBM.Options.SpecialWarningFlashDura3, DBM.Options.SpecialWarningFlashAlph3, repeatCount)
				elseif self.flash == 4 then
					local repeatCount = DBM.Options.SpecialWarningFlashRepeat4 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol4[1],DBM.Options.SpecialWarningFlashCol4[2], DBM.Options.SpecialWarningFlashCol4[3], DBM.Options.SpecialWarningFlashDura4, DBM.Options.SpecialWarningFlashAlph3, repeatCount)
				end
			end
			--This callback sucks, it needs useful information for external mods to listen to it better, such as mod and spellid
			fireEvent("DBM_Announce", msg)
			if self.sound then
				local soundId = self.option and self.mod.Options[self.option .. "SpecialWarningSound"] or self.flash
				if self.hasVoice and DBM.Options.ChosenVoicePack ~= "None" and self.hasVoice <= SWFilterDisabed and (type(soundId) == "number" and DBM.Options.VoiceOverSpecW2 == "DefaultOnly" or DBM.Options.VoiceOverSpecW2 == "All") and (self.mod.Options[self.voiceOptionId] ~= false or DBM.Options.AlwaysPlayVoice) then return end
				if not self.option or self.mod.Options[self.option.."SpecialWarningSound"] ~= "None" then
					DBM:PlaySpecialWarningSound(soundId or 1)
				end
			end
		else
			self.combinedcount = 0
			self.combinedtext = {}
		end
	end

	function specialWarningPrototype:CombinedShow(delay, ...)
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

	function specialWarningPrototype:Cancel(t, ...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, noSound, runSound, optionVersion, hasVoice)
		if not text then
			error("NewSpecialWarning: you must provide special warning text", 2)
			return
		end
		if type(text) == "string" and text:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(text, 14)
			text, optionDefault, optionName, noSound, runSound = optionDefault, optionName, noSound, runSound, temp
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
				sound = not noSound,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
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

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, noSound, runSound, optionVersion, hasVoice)
		if not spellId then
			error("newSpecialWarning: you must provide spellId", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, optionDefault, optionName, noSound, runSound = optionDefault, optionName, noSound, runSound, temp
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		if hasVoice == true then--if not a number, set it to 2, old mods that don't use new numbered system
			hasVoice = 2
		end
		local spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellName = EJ_GetSectionInfo(string.sub(spellId, 3)) or DBM_CORE_UNKNOWN
		else
			spellName = GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		end
		local text
		if announceType == "prewarn" then
			if type(stacks) == "string" then
				text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, stacks)
			else
				text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(tostring(stacks or 5)))
			end
		else
			text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
		end
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				mod = self,
				sound = not noSound,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
				hasVoice = hasVoice,
			},
			mt
		)
		if optionName then
			obj.option = optionName
		elseif not (optionName == false) then
			obj.option = "SpecWarn"..spellId..announceType..(optionVersion or "")
			if announceType == "stack" then
				self.localization.options[obj.option] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
			elseif announceType == "prewarn" then
				self.localization.options[obj.option] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(tostring(stacks or 5), spellId)
			else
				self.localization.options[obj.option] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
			end
		end
		if obj.option then
			local catType = "announce"--Default to General announce
			--Directly affects another target (boss or player) that you need to know about
			if announceType == "target" or announceType == "close" or announceType == "reflect" or announceType == "switch" or announceType == "switchcount" then
				catType = "announceother"
			--Directly affects you
			elseif announceType == "you" or announceType == "move" or announceType == "dodge" or announceType == "moveaway" or announceType == "run" or announceType == "stack" or announceType == "moveto" then
				catType = "announcepersonal"
			--Things you have to do to fulfil your role
			elseif announceType == "taunt" or announceType == "dispel" or announceType == "interrupt" then
				catType = "announcerole"
			end
			obj.voiceOptionId = hasVoice and "Voice"..spellId..(type(hasVoice) == "number" and hasVoice or "") or nil
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, catType)
		end
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

	function bossModPrototype:NewSpecialWarningTarget(text, optionDefault, ...)
		return newSpecialWarning(self, "target", text, nil, optionDefault, ...)
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
	
	function bossModPrototype:NewSpecialWarningDodge(text, optionDefault, ...)
		return newSpecialWarning(self, "dodge", text, nil, optionDefault, ...)
	end
	
	function bossModPrototype:NewSpecialWarningMoveAway(text, optionDefault, ...)
		return newSpecialWarning(self, "moveaway", text, nil, optionDefault, ...)
	end
	
	function bossModPrototype:NewSpecialWarningMoveTo(text, optionDefault, ...)
		return newSpecialWarning(self, "moveto", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningRun(text, optionDefault, ...)
		return newSpecialWarning(self, "run", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCast(text, optionDefault, ...)
		return newSpecialWarning(self, "cast", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningReflect(text, optionDefault, ...)
		return newSpecialWarning(self, "reflect", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCount(text, optionDefault, ...)
		return newSpecialWarning(self, "count", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStack(text, optionDefault, stacks, optionName, noSound, runSound, optionVersion, hasVoice)
		if type(text) == "string" and text:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(text, 14)
			text, optionDefault, stacks, optionName, noSound, runSound = optionDefault, stacks, optionName, noSound, runSound, temp
		end
		return newSpecialWarning(self, "stack", text, stacks, optionDefault, optionName, noSound, runSound, optionVersion, hasVoice)
	end

	function bossModPrototype:NewSpecialWarningSwitch(text, optionDefault, ...)
		return newSpecialWarning(self, "switch", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitchCount(text, optionDefault, ...)
		return newSpecialWarning(self, "switchcount", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningPreWarn(text, optionDefault, time, optionName, noSound, runSound, optionVersion, hasVoice)
		if type(text) == "string" and text:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(text, 14)
			text, optionDefault, time, optionName, noSound, runSound = optionDefault, time, optionName, noSound, runSound, temp
		end
		return newSpecialWarning(self, "prewarn", text, time, optionDefault, optionName, noSound, runSound, optionVersion, hasVoice)
	end

	function DBM:PlayCountSound(number, forceVoice)
		if number > 10 then return end
		local voice, voice2
		if forceVoice then--Primarlly for options
			voice = forceVoice
		else
			voice = DBM.Options.CountdownVoice
			voice2 = DBM.Options.CountdownVoice2
		end
		if number > 5 and (voice == "Mosh") then--Can't count past 5
			if voice ~= voice2 then
				voice = voice2--Fall back to secondary voice option if primary is mosh
			else--Voice 1 and voice 2 were both set to "Mosh", they must really like mosh. At this point we must ignore their preference
				voice = "Corsica"
			end
		end--If number is higher than 5 and users primary voice setting ismosh, fallback to secondary voice setting
		local path
		if voice:find("VP:") then
			local _, voiceValue = string.split(":", voice)
			path = "Interface\\AddOns\\DBM-VP"..voiceValue.."\\count\\"..number..".ogg"
		else
			path = "Interface\\AddOns\\DBM-Core\\Sounds\\"..voice.."\\"..number..".ogg"
		end
		if DBM.Options.UseMasterVolume then
			PlaySoundFile(path, "Master")
		else
			PlaySoundFile(path)
		end
	end

	function DBM:CheckVoicePackAvailable()
		--Check if voice pack missing
		local activeVP = self.Options.ChosenVoicePack
		if (activeVP ~= "None" and not self.VoiceVersions[activeVP]) or (self.VoiceVersions[activeVP] and self.VoiceVersions[activeVP] == 0) then--A voice pack is selected that does not belong
			self.Options.ChosenVoicePack = "None"--Set ChosenVoicePack back to None
			self:AddMsg(DBM_CORE_VOICE_MISSING)
		end
		--Check if any of countdown sounds are using missing voice pack
		local voice1 = self.Options.CountdownVoice
		local voice2 = self.Options.CountdownVoice2
		local voice3 = self.Options.CountdownVoice3
		if voice1 == "None" then--Migrate to new setting
			self.Options.CountdownVoice = self.DefaultOptions.CountdownVoice
			self.Options.DontPlayCountdowns = true
		end
		if voice1 == "Yike" then--Migration for CN Users
			if self.VoiceVersions["Yike"] then
				self.Options.CountdownVoice = "VP:Yike"
			else
				self.Options.CountdownVoice = self.DefaultOptions.CountdownVoice--Defaults
			end
		end
		if voice1:find("VP:") then
			local _, voiceValue = string.split(":", voice1)
			if not self.VoiceVersions[voiceValue] then
				self:AddMsg(DBM_CORE_VOICE_COUNT_MISSING:format(1))
				self.Options.CountdownVoice = self.DefaultOptions.CountdownVoice
			end
		elseif voice2:find("VP:") then
			local _, voiceValue = string.split(":", voice2)
			if not self.VoiceVersions[voiceValue] then
				self:AddMsg(DBM_CORE_VOICE_COUNT_MISSING:format(2))
				self.Options.CountdownVoice2 = self.DefaultOptions.CountdownVoice2
			end
		elseif voice3:find("VP:") then
			local _, voiceValue = string.split(":", voice3)
			if not self.VoiceVersions[voiceValue] then
				self:AddMsg(DBM_CORE_VOICE_COUNT_MISSING:format(3))
				self.Options.CountdownVoice3 = self.DefaultOptions.CountdownVoice3
			end
		end
	end

	function DBM:CheckVoicePackVersion(value)
		local activeVP = self.Options.ChosenVoicePack
		--Check if voice pack out of date
		if activeVP ~= "None" and activeVP == value then
			if self.VoiceVersions[value] < 3 then--Version will be bumped when new voice packs released that contain new voices.
				self:AddMsg(DBM_CORE_VOICE_PACK_OUTDATED)
				SWFilterDisabed = self.VoiceVersions[value]--Set disable to version on current voice pack
			else
				SWFilterDisabed = 3
			end
		end
	end

	function DBM:PlaySpecialWarningSound(soundId)
		local sound = type(soundId) == "number" and self.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId or self.Options.SpecialWarningSound
		if self.Options.UseMasterVolume then
			PlaySoundFile(sound, "Master")
		else
			PlaySoundFile(sound)
		end
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(text, number)
		if moving then
			return
		end
		DBM:AddSpecialWarning(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(self.Options.SpecialWarningDuration * 1.3, testWarningEnd)
		self:PlaySpecialWarningSound(number)
		if self.Options.ShowFlashFrame then
			if number == 1 then
				local repeatCount = DBM.Options.SpecialWarningFlashRepeat1 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
				self.Flash:Show(self.Options.SpecialWarningFlashCol1[1],self.Options.SpecialWarningFlashCol1[2], self.Options.SpecialWarningFlashCol1[3], self.Options.SpecialWarningFlashDura1, self.Options.SpecialWarningFlashAlph1, repeatCount)
			elseif number == 2 then
				local repeatCount = DBM.Options.SpecialWarningFlashRepeat2 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
				self.Flash:Show(self.Options.SpecialWarningFlashCol2[1],self.Options.SpecialWarningFlashCol2[2], self.Options.SpecialWarningFlashCol2[3], self.Options.SpecialWarningFlashDura2, self.Options.SpecialWarningFlashAlph2, repeatCount)
			elseif number == 3 then
				local repeatCount = DBM.Options.SpecialWarningFlashRepeat3 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
				self.Flash:Show(self.Options.SpecialWarningFlashCol3[1],self.Options.SpecialWarningFlashCol3[2], self.Options.SpecialWarningFlashCol3[3], self.Options.SpecialWarningFlashDura3, self.Options.SpecialWarningFlashAlph3, repeatCount)
			elseif number == 4 then
				local repeatCount = DBM.Options.SpecialWarningFlashRepeat4 and DBM.Options.SpecialWarningFlashRepeatAmount or 0
				self.Flash:Show(self.Options.SpecialWarningFlashCol4[1],self.Options.SpecialWarningFlashCol4[2], self.Options.SpecialWarningFlashCol4[3], self.Options.SpecialWarningFlashDura4, self.Options.SpecialWarningFlashAlph4, repeatCount)
			end
		end
	end
end

--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}

	function timerPrototype:Start(timer, ...)
		--Move entire coundown object here and eliminate seperate countdown options.
		--Timers should have a popup of their own with "none" "5" and "10" options for countdown voice.
		--Which voice that's used still controled by primary setting in gui still. Working on GUI will be changed to "primary"
		--Smart coding in this function to check if any audio countdowns are currently running if we are to start another one, if so, use a voice not currently running? else, always prefer users primary preference.
		--Maybe add a preferred voice order if more voices get added to mod?
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		if not self.option or self.mod.Options[self.option] then
			if self.type and self.type:find("count") and not self.allowdouble then--cdcount, nextcount. remove previous timer.
				for i = #self.startedTimers, 1, -1 do
					DBM.Bars:CancelBar(self.startedTimers[i])
					DBM:Debug("Timer "..self.id.. " refreshed before expires", 2)
					self.startedTimers[i] = nil
				end
			end
			local timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			if not self.type or (self.type ~= "target" and self.type ~= "active" and self.type ~= "fades") then
				local bar = DBM.Bars:GetBar(id)
				if bar then
					DBM:Debug("Timer "..self.id.. " refreshed before expires", 2)
				end
			end
			local bar = DBM.Bars:CreateBar(timer, id, self.icon)
			if not bar then
				return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
			end
			local msg = ""
			if self.type and not self.text then
				msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId), ...)
			else
				msg = pformat(self.text, ...)
			end
			msg = msg:gsub(">.-<", stripServerName)
			bar:SetText(msg)
			--This callback sucks, it needs useful information for external mods to listen to it better, such as mod and spellid
			fireEvent("DBM_TimerStart", id, msg, timer..DBM_CORE_SEC)
			tinsert(self.startedTimers, id)
			self.mod:Unschedule(removeEntry, self.startedTimers, id)
			self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
			return bar
		else
			return false, "disabled"
		end
	end
	timerPrototype.Show = timerPrototype.Start

	function timerPrototype:DelayedStart(delay, ...)
		unschedule(self.Start, self.mod, self, ...)
		schedule(delay or 0.5, self.Start, self.mod, self, ...)
	end
	timerPrototype.DelayedShow = timerPrototype.DelayedStart

	function timerPrototype:Schedule(t, ...)
		return schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(t, ...)
		return unschedule(self.Start, self.mod, self, ...)
	end

	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				--This callback sucks, it needs useful information for external mods to listen to it better, such as mod and spellid
				fireEvent("DBM_TimerStop", self.startedTimers[i])
				DBM.Bars:CancelBar(self.startedTimers[i])
				self.startedTimers[i] = nil
			end
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					--This callback sucks, it needs useful information for external mods to listen to it better, such as mod and spellid
					fireEvent("DBM_TimerStop", id)
					DBM.Bars:CancelBar(id)
					tremove(self.startedTimers, i)
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
		if self:GetTime(...) == 0 then
			self:Start(totalTime, ...)
		end
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		return DBM.Bars:UpdateBar(id, elapsed, totalTime)
	end

	function timerPrototype:UpdateIcon(icon, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetIcon((type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or icon or "Interface\\Icons\\Spell_Nature_WispSplode")
		end
	end

	function timerPrototype:UpdateName(name, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetText(name)
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

	function timerPrototype:AddOption(optionDefault, optionName)
		if optionName ~= false then
			self.option = optionName or self.id
			self.mod:AddBoolOption(self.option, optionDefault, "timer")
		end
	end

	function bossModPrototype:NewTimer(timer, name, icon, optionDefault, optionName, r, g, b)
		local icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and GetSpellTexture(icon)) or icon or "Interface\\Icons\\Spell_Nature_WispSplode"
		local obj = setmetatable(
			{
				text = self.localization.timers[name],
				timer = timer,
				id = name,
				icon = icon,
				r = r,
				g = g,
				b = b,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName)
		tinsert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- todo: disable the timer if the player already has the achievement and when the ACHIEVEMENT_EARNED event is fired
	-- problem: heroic/normal achievements :[
	-- local achievementTimers = {}
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, texture, r, g, b, optionVersion)
		if type(timer) == "string" and timer:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(timer, 14)
			timer, spellId, timerText, optionDefault, optionName, texture, r, g, b = spellId, timerText, optionDefault, optionName, texture, r, g, b, temp
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
			icon = type(texture) == "number" and select(10, GetAchievementInfo(texture)) or texture or spellId and select(10, GetAchievementInfo(spellId))
--			if optionDefault == nil then
--				local completed = select(4, GetAchievementInfo(spellId))
--				optionDefault = not completed
--			end
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "phase" then
			icon = type(texture) == "number" and GetSpellTexture(texture) or texture or type(spellId) == "string" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId)) or "Interface\\Icons\\Spell_Nature_WispSplode"
		elseif timerType == "roleplay" then
			icon = "Interface\\Icons\\Spell_Holy_BorrowedTime"
		else
			if type(spellId) == "string" and spellId:match("ej%d+") then
				spellName = EJ_GetSectionInfo(string.sub(spellId, 3)) or ""
			else
				spellName = GetSpellInfo(spellId or 0)
			end
			if spellName then
				icon = type(texture) == "number" and GetSpellTexture(texture) or texture or type(spellId) == "string" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and GetSpellTexture(spellId))
			else
				icon = nil
			end
		end
		spellName = spellName or tostring(spellId)
		local id = "Timer"..(spellId or 0)..timerType..(optionVersion or "")
		local obj = setmetatable(
			{
				text = self.localization.timers[timerText],
				type = timerType,
				spellId = spellId,
				timer = timer,
				id = id,
				icon = icon,
				r = r,
				g = g,
				b = b,
				allowdouble = allowdouble,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName)
		tinsert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if timerType == "achievement" then
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(GetAchievementLink(spellId):gsub("%[(.+)%]", "%1"))
		elseif timerType == "cdspecial" or timerType == "nextspecial" or timerType == "phase" or timerType == "roleplay" then--Timers without spellid, generic
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]--Using more than 1 phase timer or more than 1 special timer will break this, fortunately you should NEVER use more than 1 of either in a mod
		else
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(unparsedId)
		end
		return obj
	end

	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end

	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
	end

	function bossModPrototype:NewBuffFadesTimer(...)
		return newTimer(self, "fades", ...)
	end

	function bossModPrototype:NewCastTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(4, GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(4, GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "cast", timer, ...)
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
		return newTimer(self, "phase", ...)
	end
	
	function bossModPrototype:NewRPTimer(...)
		return newTimer(self, "roleplay", ...)
	end

	function bossModPrototype:GetLocalizedTimerText(timerType, spellId)
		local spellName
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
		elseif type(spellId) == "string" and spellId:match("ej%d+") then
			spellName = EJ_GetSectionInfo(string.sub(spellId, 3))
		else
			spellName = GetSpellInfo(spellId)
		end
		return pformat(DBM_CORE_AUTO_TIMER_TEXTS[timerType], spellName)
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
		if self.countdown then
			if not DBM.Options.DontPlayPTCountdown then
				self.countdown:Start(timer)
			end
			if not DBM.Options.DontShowPTCountdownText then
				local threshold = DBM.Options.PTCountThreshold
				if timer > threshold then
					DBM:Schedule(timer-threshold, countDownTextDelay, threshold)
				else
					TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
				end
			end
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
		if self.countdown then
			DBM:Unschedule(countDownTextDelay)
			self.countdown:Cancel()
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
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
		local bar = self:NewTimer(timer, barText or DBM_CORE_GENERIC_TIMER_COMBAT, barIcon or 2457, nil, "timer_combat")
		local countdown = self:NewCountdown(0, 0, nil, false, nil, true)
		local obj = setmetatable(
			{
				bar = bar,
				timer = timer,
				countdown = countdown,
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
function bossModPrototype:AddBoolOption(name, default, cat, func)
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, cat)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddSpecialWarningOption(name, default, defaultSound, cat)
	cat = cat or "misc"
	self.DefaultOptions[name] = (default == nil) or default
	self.DefaultOptions[name.."SpecialWarningSound"] = defaultSound or 1
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self.Options[name.."SpecialWarningSound"] = defaultSound or 1
	self:SetOptionCategory(name, cat)
end

function bossModPrototype:AddSetIconOption(name, spellId, default, isHostile)
	self.DefaultOptions[name] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "misc")
	if isHostile then
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
		self.localization.options[name] = DBM_CORE_AUTO_ICONS_OPTION_TEXT2:format(spellId)
	else
		self.localization.options[name] = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(spellId)
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

function bossModPrototype:AddInfoFrameOption(spellId, default)
	self.DefaultOptions["InfoFrame"] = (default == nil) or default
	if default and type(default) == "string" then
		default = self:GetRoleFlagValue(default)
	end
	self.Options["InfoFrame"] = (default == nil) or default
	self:SetOptionCategory("InfoFrame", "misc")
	self.localization.options["InfoFrame"] = DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT:format(spellId)
end

function bossModPrototype:AddReadyCheckOption(questId, default)
	self.readyCheckQuestId = questId
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

function bossModPrototype:AddButton(name, onClick, cat, func)
	cat = cat or "misc"
	self:SetOptionCategory(name, cat)
	self.buttons = self.buttons or {}
	self.buttons[name] = onClick
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
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
	if self.noRegenDetection then
		info.noRegenDetection = self.noRegenDetection
	end
	if self.noWBEsync then
		info.noWBEsync = self.noWBEsync
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
		end
		for i = 1, select("#", ...) do
			local cId = select(i, ...)
			bossIds[cId] = true
		end
	else
		local cId = ...
		bossIds[cId] = true
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
	revision = tonumber(revision or "")
	if not revision then
		-- bad revision: either forgot the svn keyword or using git svn
		revision = DBM.Revision
	end
	self.revision = revision
end

function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = revision
end

function bossModPrototype:SetMinSyncTime(time)
	self.syncThreshold = time
end

function bossModPrototype:SetHotfixNoticeRev(revision)
	self.hotfixNoticeRev = revision
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
			DBM:Debug("SetIcon is being used impropperly. Check icon/target order")
			return--Fail silently instead of spamming icon lua errors if we screw up
		end
		icon = icon and icon >= 0 and icon <= 8 and icon or 8
		local uId = DBM:GetRaidUnitId(target)
		if uId and UnitIsUnit(uId, "player") and DBM:GetNumRealGroupMembers() < 2 then return end--Solo raid, no reason to put icon on yourself.
		if uId or UnitExists(target) then--target accepts uid, unitname both.
			uId = uId or target
			--save previous icon into a table.
			if not self.iconRestore[uId] then
				local oldIcon = self:GetIcon(uId) or 0
				self.iconRestore[uId] = oldIcon
			end
			--set icon
			SetRaidTarget(uId, self.iconRestore[uId] and icon == 0 and self.iconRestore[uId] or icon)
			--schedule restoring old icon if timer enabled.
			if timer then
				self:ScheduleMethod(timer, "SetIcon", target, 0)
			end
		end
	end

	do
		local iconSortTable = {}
		local iconSet = 0

		local function sort_by_group(v1, v2)
			return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
		end

		local function clearSortTable()
			twipe(iconSortTable)
			iconSet = 0
		end

		function bossModPrototype:SetIconBySortedTable(startIcon, reverseIcon, returnFunc)
			tsort(iconSortTable, sort_by_group)
			local icon = startIcon or 1
			for i, v in ipairs(iconSortTable) do
				if not self.iconRestore[v] then
					local oldIcon = self:GetIcon(v) or 0
					self.iconRestore[v] = oldIcon
				end
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
			self:Schedule(1.5, clearSortTable)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
		end

		function bossModPrototype:SetSortedIcon(delay, target, startIcon, maxIcon, reverseIcon, returnFunc)
			if not target then return end
			if DBM.Options.DontSetIcons or not enableIcons or DBM:GetRaidRank(playerName) == 0 then
				return
			end
			if not startIcon then startIcon = 1 end
			startIcon = startIcon and startIcon >= 0 and startIcon <= 8 and startIcon or 8
			local uId = DBM:GetRaidUnitId(target)
			if uId or UnitExists(target) then--target accepts uid, unitname both.
				uId = uId or target
				local foundDuplicate = false
				for i = #iconSortTable, 1, -1 do
					if iconSortTable[i] == uId then
						foundDuplicate = true
						break
					end
				end
				if not foundDuplicate then
					iconSet = iconSet + 1
					tinsert(iconSortTable, uId)
				end
				self:UnscheduleMethod("SetIconBySortedTable")
				if maxIcon and iconSet == maxIcon then
					self:SetIconBySortedTable(startIcon, reverseIcon, returnFunc)
				elseif self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
					self:ScheduleMethod(delay or 0.5, "SetIconBySortedTable", startIcon, reverseIcon, returnFunc)
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

	function bossModPrototype:ScanForMobs(creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName)
		if not optionName then optionName = self.findFastestComputer[1] end
		if canSetIcons[optionName] then
			--Declare variables.
			local timeNow = GetTime()
			local creatureID = creatureID--This function must not be used to boss, so remove self.creatureId. Accepts cid, guid and cid table
			local iconSetMethod = iconSetMethod or 0--Set IconSetMethod -- 0: Descending / 1:Ascending / 2: Force Set / 9:Force Stop
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
			local maxIcon = maxIcon or 8 --We only have 8 icons.
			local scanInterval = scanInterval or 0.2
			local scanningTime = scanningTime or 8
			--DO SCAN NOW
			for uId in DBM:GetGroupMembers() do
				if not self.iconRestore[uId] then
					local oldIcon = self:GetIcon(uId) or 0
					self.iconRestore[uId] = oldIcon
				end
				local unitid = uId.."target"
				local guid = UnitGUID(unitid)
				local cid = self:GetCIDFromGUID(guid)
				if guid and type(creatureID) == "table" and creatureID[cid] and not addsGUIDs[guid] then
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
				elseif guid and ((guid == creatureID) or (cid == creatureID)) and not addsGUIDs[guid] then
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
			local guid2 = UnitGUID("mouseover")
			local cid2 = self:GetCIDFromGUID(guid2)
			if guid2 and type(creatureID) == "table" and creatureID[cid2] and not addsGUIDs[guid2] then
				if type(creatureID[cid2]) == "number" then
					SetRaidTarget("mouseover", creatureID[cid2])
				else
					SetRaidTarget("mouseover", addsIcon[scanID])
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
			elseif guid2 and ((guid2 == creatureID) or (cid2 == creatureID)) and not addsGUIDs[guid2] then
				if iconSetMethod == 2 then
					SetRaidTarget("mouseover", mobIcon)
				else
					SetRaidTarget("mouseover", addsIcon[scanID])
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
			if timeNow < scanExpires[scanID] then--scan for limited times.
				self:ScheduleMethod(scanInterval, "ScanForMobs", creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName)
			else
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				--Do not wipe adds GUID table here, it's wiped by :Stop() which is called by EndCombat
			end
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
			misc				= MISCELLANEOUS
		}, returnKey)
	}
	local defaultTimerLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_GENERIC_TIMER_BERSERK,
			timer_combat = DBM_CORE_GENERIC_TIMER_COMBAT,
			TimerSpeedKill = DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL
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
			HealthFrame = DBM_CORE_OPTION_HEALTH_FRAME,
			SpeedKillTimer = DBM_SPEED_KILL_TIMER_OPTION
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
