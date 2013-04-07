-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author) Contact: mysticalosx@gmail.com (Twitter: @MysticalOS)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu & Omegal		http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://www.dreamgen.cn | diablohudream@gmail.com
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: nBlueWiz					everfinale@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- Special thanks to:
--    * Arta
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--    * nBlueWiz (a lot of fixes in the koKR localization as well as boss mod work) Contant: everfinale@gmail.com
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
	DisplayVersion = "5.2.3 alpha", -- the string that is shown as version
	ReleaseRevision = 9085 -- the revision of the latest stable version that is available
}

-- Legacy crap; that stupid "Version" field was never a good idea.
-- Some functions that should be using ReleaseRevision still use this one, so we will just keep it and set to ReleaseRevision
DBM.Version = tostring(DBM.ReleaseRevision)
-- Hack until 5.2.4 release
DBM.ReleaseRevision = DBM.Revision

-- support for git svn which doesn't support svn keyword expansion
if not DBM.Revision then
	-- just use the latest release revision
	DBM.Revision = DBM.ReleaseRevision
end

DBM_SavedOptions = {}

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turqoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = "Sound\\Doodad\\BellTollNightElf.wav",
	SpecialWarningSound = "Sound\\Spells\\PVPFlagTaken.wav",
	SpecialWarningSound2 = "Sound\\Creature\\AlgalonTheObserver\\UR_Algalon_BHole01.wav",
	SpecialWarningSound3 = "Sound\\Creature\\KilJaeden\\KILJAEDEN02.wav",
	ModelSoundValue = "Short",
	CountdownVoice = "Corsica",
	ShowCountdownText = false,
	RaidWarningPosition = {
		Point = "TOP",
		X = 0,
		Y = -185,
	},
	Enabled = true,
	ShowWarningsInChat = true,
	ShowFakedRaidWarnings = false,
	WarningIconLeft = true,
	WarningIconRight = true,
	StripServerName = true,
	ShowLoadMessage = true,
	ShowPizzaMessage = true,
	ShowEngageMessage = true,
	ShowKillMessage = true,
	ShowWipeMessage = true,
	ShowRecoveryMessage = true,
	AutoRespond = true,
	StatusEnabled = true,
	WhisperStats = false,
	HideBossEmoteFrame = false,
	SpamBlockBossWhispers = false,
	ShowMinimapButton = false,
	BlockVersionUpdateNotice = false,
	ShowSpecialWarnings = true,
	ShowLHFrame = true,
	AlwaysShowHealthFrame = false,
	ShowBigBrotherOnCombatStart = false,
	AutologBosses = false,
	AdvancedAutologBosses = false,
	LogOnlyRaidBosses = false,
	UseMasterVolume = true,
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
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = STANDARD_TEXT_FONT,
	SpecialWarningFontSize = 50,
	SpecialWarningFontColor = {0.0, 0.0, 1.0},
	HealthFrameGrowUp = false,
	HealthFrameLocked = false,
	HealthFrameWidth = 200,
	ArrowPosX = 0,
	ArrowPosY = -150,
	ArrowPoint = "TOP",
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontSendBossWhispers = false,
	DontSetIcons = false,
	DontShowRangeFrame = false,
	DontShowInfoFrame = false,
	DontShowPT = true,
	DontShowPTCountdownText = false,
	DontPlayPTCountdown = false,
	LatencyThreshold = 250,
	BigBrotherAnnounceToRaid = false,
	SettingsMessageShown = false,
	AlwaysShowSpeedKillTimer = true,
	DisableCinematics = false,
	DisableCinematicsOutside = false,
--	HelpMessageShown = false,
	MoviesSeen = {},
	MovieFilters = {},
	LastRevision = 0,
	FilterSayAndYell = false
}

DBM.Bars = DBT:New()
DBM.Mods = {}

------------------------
-- Global Identifiers --
------------------------
DBM_DISABLE_ZONE_DETECTION = newproxy(false)
DBM_OPTION_SPACER = newproxy(false)

--------------
--  Locals  --
--------------
local enabled = true
local inCombat = {}
local combatInfo = {}
local updateFunctions = {}
local raid = {}
local modSyncSpam = {}
local autoRespondSpam = {}
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<DBM> "
local ver = ("%s (r%d)"):format(DBM.DisplayVersion, DBM.Revision)
local mainFrame = CreateFrame("Frame")
local showedUpdateReminder = false
local combatInitialized = false
local schedule
local unschedule
local loadOptions
local loadModOptions
local checkWipe
local fireEvent
local playerName = UnitName("player")
local _, class = UnitClass("player")
local LastZoneText = ""
local LastZoneMapID = -1
local queuedBattlefield = {}
local combatDelay = false
local myRealRevision = DBM.Revision or DBM.ReleaseRevision

local enableIcons = true -- set to false when a raid leader or a promoted player has a newer version of DBM
local guiRequested = false

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod like DBM-Battlegrounds (replaced by DBM-PvP)) boss mods, these mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM-Battlegrounds", --replaced by DBM-PvP
	-- ZG and ZA are now part of the party mods for Cataclysm
	"DBM-ZulAman",
	"DBM-ZG",
}

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local DBM = DBM
-- these global functions are accessed all the time by the event handler
-- so caching them is worth the effort
local ipairs, pairs, next = ipairs, pairs, next
local tinsert, tremove, twipe = table.insert, table.remove, table.wipe
local type = type
local select = select
local floor = math.floor
local UnitAffectingCombat = UnitAffectingCombat
local UnitExists = UnitExists
local GetSpellInfo = GetSpellInfo

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

-- removes all occurrences of a value in an array
-- returns true if at least one occurrence was remove, false otherwise
local function removeEntry(t, val)
	local existed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			table.remove(t, i)
			existed = true
		end
	end
	return existed
end

-- automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
local function sendSync(prefix, msg)
	local zoneType = select(2, IsInInstance())
	msg = msg or ""
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting osmething outside like sha, it'll sync in "RAID" instead)
		SendAddonMessage("D4", prefix .. "\t" .. msg, "INSTANCE_CHAT")
	else
		if IsInRaid() then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "PARTY")
		end
	end
end

--
local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = math.floor(time)
	if time < 60 then
		return DBM_CORE_TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return DBM_CORE_TIMER_FORMAT_MINS:format(time/60)
	else
		return DBM_CORE_TIMER_FORMAT:format(time/60, time % 60)
	end
end

local pformat
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


--------------
--  Events  --
--------------
do
	local registeredEvents = {}
	local argsMT = {__index = {}}
	local args = setmetatable({}, argsMT)

	function argsMT.__index:IsSpellID(a1, a2, a3, a4, a5)
		local v = self.spellId
		return v == a1 or v == a2 or v == a3 or v == a4 or v == a5
	end

	function argsMT.__index:IsPlayer()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsPlayerSource()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bit.band(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsNPC()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0
	end

	function argsMT.__index:IsPet()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsPetSource()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsSrcTypePlayer()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsDestTypePlayer()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsSrcTypeHostile()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:IsDestTypeHostile()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:GetSrcCreatureID()
		return tonumber(self.sourceGUID:sub(6, 10), 16) or 0
	end

	function argsMT.__index:GetDestCreatureID()
		return tonumber(self.destGUID:sub(6, 10), 16) or 0
	end

	local function handleEvent(self, event, ...)
		if self == mainFrame and event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT" then
			event = event == "UNIT_HEALTH" and "UNIT_HEALTH_UNFILTERED" or "UNIT_HEALTH_FREQUENT_UNFILTERED"
		end
		if not registeredEvents[event] or not enabled then return end
		for i, v in ipairs(registeredEvents[event]) do
			local zones = v.zones
			local handler = v[event]
			if handler and (not zones or zones[LastZoneText] or zones[LastZoneMapID]) and enabled and not (v.isTrashMod and IsEncounterInProgress()) then
				handler(v, ...)
			end
		end
	end

	local registerUnitEvent, unregisterUnitEvent
	do
		local unitEventFrame1 = CreateFrame("Frame")
		local unitEventFrame2 = CreateFrame("Frame")
		local unitEventFrame3 = CreateFrame("Frame")
		local unitEventFrame4 = CreateFrame("Frame")

		unitEventFrame1:SetScript("OnEvent", handleEvent)
		unitEventFrame2:SetScript("OnEvent", handleEvent)
		unitEventFrame3:SetScript("OnEvent", handleEvent)
		unitEventFrame4:SetScript("OnEvent", handleEvent)

		function registerUnitEvent(event)
			unitEventFrame1:RegisterUnitEvent(event, "boss1", "boss2")
			unitEventFrame2:RegisterUnitEvent(event, "boss3", "boss4")
			unitEventFrame3:RegisterUnitEvent(event, "boss5", "target")
			unitEventFrame4:RegisterUnitEvent(event, "focus", "mouseover")
		end

		function unregisterUnitEvent(event)
			unitEventFrame1:UnregisterEvent(event)
			unitEventFrame2:UnregisterEvent(event)
			unitEventFrame3:UnregisterEvent(event)
			unitEventFrame4:UnregisterEvent(event)
		end

	end

	function DBM:RegisterEvents(...)
		for i = 1, select("#", ...) do
			local event = select(i, ...)
			registeredEvents[event] = registeredEvents[event] or {}
			tinsert(registeredEvents[event], self)
			-- unit events that default to boss1-5, target, and focus only
			-- for now: only UNIT_HEALTH(_FREQUENT), more events (and a lookup table for these events) might be added later
			if event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT" then
				registerUnitEvent(event)
			elseif event == "UNIT_HEALTH_UNFILTERED" or event == "UNIT_HEALTH_FREQUENT_UNFILTERED" then
				-- unfiltered version of these events
				mainFrame:RegisterEvent(event:sub(0, -12))
			else
				-- normal events
				mainFrame:RegisterEvent(event)
			end
		end
	end

	local function unregisterEvent(event)
		registeredEvents[event] = nil
		if event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT" then
			unregisterUnitEvent(event)
		elseif event == "UNIT_HEALTH_UNFILTERED" or event == "UNIT_HEALTH_FREQUENT_UNFILTERED" then
			mainFrame:UnregisterEvent(event:sub(0, -12))
		else
			mainFrame:UnregisterEvent(event)
		end
	end

	function DBM:UnregisterInCombatEvents(ignore)
		for event, mods in pairs(registeredEvents) do
			if event ~= ignore then
				for i = #mods, 1, -1 do
					if mods[i] == self and checkEntry(self.inCombatOnlyEvents, event)  then
						tremove(mods, i)
					end
				end
				if #mods == 0 then
					unregisterEvent(event)
				end
			end
		end
	end

	function DBM:UnregisterShortTermEvents()
		if self.shortTermRegisterEvents then
			for event, mods in pairs(registeredEvents) do
				for i = #mods, 1, -1 do
					if mods[i] == self and checkEntry(self.shortTermRegisterEvents, event)  then
						tremove(mods, i)
					end
				end
				if #mods == 0 then
					unregisterEvent(event)
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
		SPELL_DAMAGE = true,
		SPELL_BUILDING_DAMAGE = true,
		SPELL_MISSED = true,
		RANGE_DAMAGE = true,
		RANGE_MISSED = true,
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
			-- taken from Blizzard_CombatLog.lua
			if event:sub(0, 6) == "SPELL_" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				if event == "SPELL_INTERRUPT" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				elseif event == "SPELL_EXTRA_ATTACKS" then
					args.amount = select(4, ...)
				elseif event == "SPELL_DISPEL_FAILED" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				elseif event == "SPELL_AURA_DISPELLED" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
					args.auraType = select(7, ...)
				elseif event == "SPELL_AURA_STOLEN" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
					args.auraType = select(7, ...)
				elseif event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_REFRESH" then
					args.auraType, args.remainingPoints = select(4, ...)
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
					args.auraType, args.amount = select(4, ...)
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_CAST_FAILED" then
					args.missType = select(4, ...)
				end
			elseif event == "DAMAGE_SHIELD" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "DAMAGE_SHIELD_MISSED" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				args.missType = select(4, ...)
			elseif event == "ENCHANT_APPLIED" then
				args.spellName = select(1,...)
				args.itemId, args.itemName = select(2,...)
			elseif event == "ENCHANT_REMOVED" then
				args.spellName = select(1,...)
				args.itemId, args.itemName = select(2,...)
			elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "ENVIRONMENTAL_DAMAGE" then
				args.environmentalType = select(1,...)
				args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(2, ...)
				args.spellName = _G["ACTION_"..event.."_"..args.environmentalType]
				args.spellSchool = args.school
			elseif event == "DAMAGE_SPLIT" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
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
	local function showOldVerWarning()
		StaticPopupDialogs["DBM_OLD_VERSION"] = {
			preferredIndex = STATICPOPUP_NUMDIALOGS,
			text = DBM_CORE_ERROR_DBMV3_LOADED,
			button1 = DBM_CORE_OK,
			OnAccept = function()
				DisableAddOn("DBM_API")
				ReloadUI()
			end,
			timeout = 0,
			exclusive = 1,
			whileDead = 1
		}
		StaticPopup_Show("DBM_OLD_VERSION")
	end
	
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
			DBM.Bars:LoadOptions("DBM")
			DBM.Arrow:LoadPosition()
			if not DBM.Options.ShowMinimapButton then self:HideMinimapButton() end
			self.AddOns = {}
			for i = 1, GetNumAddOns() do
				if GetAddOnMetadata(i, "X-DBM-Mod") and not checkEntry(bannedMods, GetAddOnInfo(i)) then
					table.insert(self.AddOns, {
						sort			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or math.huge) or math.huge,
						type			= GetAddOnMetadata(i, "X-DBM-Mod-Type") or "OTHER",
						category		= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
						name			= GetAddOnMetadata(i, "X-DBM-Mod-Name") or "",
						zone			= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadZone") or "BogusZone")},--workaround, so mods with zoneids and no zonetext don't get loaded by default before zoneids even checked
						zoneId			= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadZoneID") or "")},
						subTabs			= GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
						oneFormat		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Single-Format") or 0) == 1,
						hasLFR			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-LFR") or 0) == 1,
						hasChallenge	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Challenge") or 0) == 1,
						noHeroic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Heroic") or 0) == 1,
						noStatistics	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Statistics") or 0) == 1,
						modId			= GetAddOnInfo(i),
					})
					for k, v in ipairs(self.AddOns[#self.AddOns].zone) do
						self.AddOns[#self.AddOns].zone[k] = (self.AddOns[#self.AddOns].zone[k]):trim()
					end
					for i = #self.AddOns[#self.AddOns].zoneId, 1, -1 do
						local id = tonumber(self.AddOns[#self.AddOns].zoneId[i])
						if id then
							self.AddOns[#self.AddOns].zoneId[i] = id
						else
							table.remove(self.AddOns[#self.AddOns].zoneId, i)
						end
					end
					if self.AddOns[#self.AddOns].subTabs then
						for k, v in ipairs(self.AddOns[#self.AddOns].subTabs) do
							self.AddOns[#self.AddOns].subTabs[k] = (self.AddOns[#self.AddOns].subTabs[k]):trim()
						end
					end
				end
			end
			table.sort(self.AddOns, function(v1, v2) return v1.sort < v2.sort end)
			self:RegisterEvents(
				"COMBAT_LOG_EVENT_UNFILTERED",
				"ZONE_CHANGED_NEW_AREA",
				"GROUP_ROSTER_UPDATE",
				"CHAT_MSG_ADDON",
				"PLAYER_REGEN_DISABLED",
				"PLAYER_REGEN_ENABLED",
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
				"UNIT_DIED",
				"UNIT_DESTROYED",
				"UNIT_HEALTH",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_BN_WHISPER",
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_MONSTER_SAY",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"RAID_BOSS_EMOTE",
				"PLAYER_ENTERING_WORLD",
				"LFG_PROPOSAL_SHOW",
				"LFG_PROPOSAL_FAILED",
				"LFG_PROPOSAL_SUCCEEDED",
				"UPDATE_BATTLEFIELD_STATUS",
				"UPDATE_MOUSEOVER_UNIT",
				"PLAYER_TARGET_CHANGED"	,
				"CINEMATIC_START",
				"LFG_COMPLETION_REWARD"
			)
			self:ZONE_CHANGED_NEW_AREA()
			self:GROUP_ROSTER_UPDATE()
			self:Schedule(1.5, function()
        		combatInitialized = true
			end)
			local enabled, loadable = select(4, GetAddOnInfo("DBM_API"))
			if enabled and loadable then showOldVerWarning() end
			-- setup MovieFrame hook (TODO: replace this by a proper filtering function that only filters certain movie IDs (which requires some API for boss mods to specify movie IDs and default actions)))
			-- do not use HookScript here, the movie must not even be started to prevent a strange WoW crash bug on OS X with some movies
			local oldMovieEventHandler = MovieFrame:GetScript("OnEvent")
			MovieFrame:SetScript("OnEvent", function(self, event, movieId, ...)
				if event == "PLAY_MOVIE" and (DBM.Options.DisableCinematics and IsInInstance() or (DBM.Options.DisableCinematicsOutside and not IsInInstance())) then
					-- you still have to call OnMovieFinished, even if you never actually told the movie frame to start the movie, otherwise you will end up in a weird state (input stops working)
					MovieFrame_OnMovieFinished(MovieFrame)
					return
				else
					-- other event or cinematics enabled
					return oldMovieEventHandler and oldMovieEventHandler(self, event, movieId, ...)
				end
			end)
		elseif modname == "DBM-BurningCrusade" then
			-- workaround to ban really old ZA/ZG mods that are still loaded through the compatibility layer. These mods should be excluded by the compatibility layer by design, however they are no longer loaded through the compatibility layer.
			-- that means this is unnecessary if you are using a recent version of DBM-BC. However, if you are still on an old version of DBM-BC then filtering ZA/ZG through DBM-Core wouldn't be possible and no one really ever updates DBM-BC
			self:Schedule(0, function()
				for i = #self.AddOns, 1, -1 do
					if checkEntry(bannedMods, self.AddOns[i].modId) then -- DBM-BC loads mods directly into this table and doesn't respect the bannedMods list of DBM-Core (just its own list of banned mods) (design fail)
						table.remove(self.AddOns, i)
					end
				end
			end)
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
		table.insert(callbacks[event], f)
		return #callbacks[event]
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
						table.remove(heap, i)
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

	mainFrame:SetScript("OnUpdate", function(self, elapsed)
		local time = GetTime()

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
			if i.Options.Enabled and (not i.zones or i.zones[LastZoneText] or i.zones[LastZoneMapID]) then
				i.elapsed = (i.elapsed or 0) + elapsed
				if i.elapsed >= (i.updateInterval or 0) then
					v(i, i.elapsed)
					i.elapsed = 0
				end
			end
		end

		-- clean up sync spam timers and auto respond spam blockers
		-- TODO: optimize this; using next(t, k) all the time on nearly empty hash tables is not a good idea...doesn't really matter here as modSyncSpam only very rarely contains more than 4 entries...
		local k, v = next(modSyncSpam, nil)
		if v and (time - v > 2.5) then
			modSyncSpam[k] = nil
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
	elseif cmd:sub(1, 15) == "broadcast timer" then
		local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
		if DBM:GetRaidRank(playerName) == 0 then
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
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
		DBM:CreatePizzaTimer(time, text, true)
	elseif cmd:sub(0,5) == "break" then
		if DBM:GetRaidRank(playerName) == 0 or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or IsEncounterInProgress() then--No break timers if not assistant or if it's LFR (because break timers in LFR are just not cute)
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			return
		end
		local timer = tonumber(cmd:sub(6)) or 5
		local timer = timer * 60
		local channel = (IsInRaid() and "RAID_WARNING") or "PARTY"
		DBM:CreatePizzaTimer(timer, DBM_CORE_TIMER_BREAK, true)
		DBM:Unschedule(SendChatMessage)
		if IsInGroup() then
			SendChatMessage(DBM_CORE_BREAK_START:format(timer/60), channel)
			if timer/60 > 5 then DBM:Schedule(timer - 5*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(5), channel) end
			if timer/60 > 2 then DBM:Schedule(timer - 2*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(2), channel) end
			if timer/60 > 1 then DBM:Schedule(timer - 1*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(1), channel) end
			DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_BREAK_OVER, channel)
		end
	elseif cmd:sub(1, 4) == "pull" then
		if DBM:GetRaidRank(playerName) == 0 or IsEncounterInProgress() then
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		local timer = tonumber(cmd:sub(5)) or 10
		local channel = (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or (IsInRaid() and "RAID_WARNING") or "PARTY"
		DBM:Unschedule(SendChatMessage)
		if IsInGroup() and timer > 1 then
			SendChatMessage(DBM_CORE_ANNOUNCE_PULL:format(timer), channel)--Still give everyone first raid warning (but only that one)
			DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_PULL_NOW, channel)
		end
		sendSync("PT", timer)
	elseif cmd:sub(1, 5) == "arrow" then
		if not DBM:IsInRaid() then
			DBM:AddMsg(DBM_ARROW_NO_RAIDGROUP)
			return false
		end
		local x, y = string.split(" ", cmd:sub(6):trim())
		local xNum, yNum = tonumber(x or ""), tonumber(y or "")
		local success
		if xNum and yNum then
			DBM.Arrow:ShowRunTo(xNum / 100, yNum / 100, 0)
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
			elseif DBM:GetRaidUnitId(DBM:Capitalize(subCmd)) then
				DBM.Arrow:ShowRunTo(DBM:Capitalize(subCmd))
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
	else
		DBM:LoadGUI()
	end
end

SLASH_DBMRANGE1 = "/range"
SLASH_DBMRANGE2 = "/distance"
SlashCmdList["DBMRANGE"] = function(msg)
	if DBM.RangeCheck:IsShown() then
		DBM.RangeCheck:Hide()
	else
		local r = tonumber(msg)
		if r and ((r == 10 or r == 11 or r == 15 or r == 28) or (DBM.MapSizes[GetMapInfo()] and r < 31)) then
			DBM.RangeCheck:Show(r, nil, true)
		else
			DBM.RangeCheck:Show(10, nil, true)
		end
	end
end

do
	local sortMe = {}
	local function sort(v1, v2)
		return (v1.revision or 0) > (v2.revision or 0)
	end
	function DBM:ShowVersions(notify)
		for i, v in pairs(raid) do
			table.insert(sortMe, v)
		end
		table.sort(sortMe, sort)
		self:AddMsg(DBM_CORE_VERSIONCHECK_HEADER)
		for i, v in ipairs(sortMe) do
			if v.displayVersion then
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(v.name, v.displayVersion, v.revision))
				if notify and v.revision < DBM.ReleaseRevision then
					SendChatMessage(chatPrefixShort..DBM_CORE_YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
				end
			else
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM:format(v.name))
			end
		end
		for i = #sortMe, 1, -1 do
			if not sortMe[i].revision then
				table.remove(sortMe, i)
			end
		end
		self:AddMsg(DBM_CORE_VERSIONCHECK_FOOTER:format(#sortMe))
		for i = #sortMe, 1, -1 do
			sortMe[i] = nil
		end
	end
end

-------------------
--  Pizza Timer  --
-------------------
do
	local ignore = {}
	function DBM:CreatePizzaTimer(time, text, broadcast, sender)
		if sender and ignore[sender] then return end
		text = text:sub(1, 16)
		text = text:gsub("%%t", UnitName("target") or "<no target>")
		self.Bars:CreateBar(time, text, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		if broadcast and self:GetRaidRank(playerName) >= 1 then
			sendSync("U", ("%s\t%s"):format(time, text))
		end
		if sender then self:ShowPizzaInfo(text, sender) end
	end

	function DBM:AddToPizzaIgnore(name)
		ignore[name] = true
	end
end

function DBM:ShowPizzaInfo(id, sender)
	if DBM.Options.ShowPizzaMessage then
		self:AddMsg(DBM_PIZZA_SYNC_INFO:format(sender, id))
	end
end

------------------
--  Hyperlinks  --
------------------
do
	local ignore, cancel
	StaticPopupDialogs["DBM_CONFIRM_IGNORE"] = {
		preferredIndex = STATICPOPUP_NUMDIALOGS,
		text = DBM_PIZZA_CONFIRM_IGNORE,
		button1 = YES,
		button2 = NO,
		OnAccept = function(self)
			DBM:AddToPizzaIgnore(ignore)
			DBM.Bars:CancelBar(cancel)
		end,
		timeout = 0,
		hideOnEscape = 1
	}

	DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", function(self, link, string, button, ...)
		local linkType, arg1, arg2, arg3 = strsplit(":", link)
		if linkType ~= "DBM" then
			return
		end
		if arg1 == "cancel" then
			DBM.Bars:CancelBar(link:match("DBM:cancel:(.+):nil$"))
		elseif arg1 == "ignore" then
			cancel = link:match("DBM:ignore:(.+):[^%s:]+$")
			ignore = link:match(":([^:]+)$")
			StaticPopup_Show("DBM_CONFIRM_IGNORE", ignore)
		elseif arg1 == "update" then
			DBM:ShowUpdateReminder(arg2, arg3) -- displayVersion, revision
		elseif arg1 == "showRaidIdResults" then
			DBM:ShowRaidIDRequestResults()
		end
	end)
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
		if not IsAddOnLoaded("DBM-GUI") then
			if InCombatLockdown() then
				guiRequested = true
				self:AddMsg(DBM_CORE_LOAD_GUI_COMBAT)
				return
			end
			local _, _, _, enabled = GetAddOnInfo("DBM-GUI")
			if not enabled then
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
			table.sort(callOnLoad, function(v1, v2) return v1[2] < v2[2] end)
			for i, v in ipairs(callOnLoad) do v[1]() end
			collectgarbage("collect")
		end
		return DBM_GUI:ShowHide()
	end

	function DBM:RegisterOnGuiLoadCallback(f, sort)
		table.insert(callOnLoad, {f, sort or math.huge})
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
	local raidShortNames = {}
	

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
				raidUIds["player"] = playerName
				raidGuids[UnitGUID("player")] = playerName
				raidShortNames[playerName] = playerName
			end
		end)
	end)

	local function updateAllRoster()
		if IsInRaid() then
			table.wipe(raidShortNames)
			local playerWithHigherVersionPromoted = false
			if not inRaid then
				inRaid = true
				sendSync("H")
				DBM:Schedule(2, DBM.RequestTimers, DBM)
				fireEvent("raidJoin", playerName)
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
					if not raidShortNames[shortname] then
						raidShortNames[shortname] = name
					else
						raidShortNames[shortname] = DBM_CORE_GENERIC_WARNING_DUPLICATE:format(name:gsub("%-.*$", ""))
					end
					if not playerWithHigherVersionPromoted and rank >= 1 and raid[name].revision and raid[name].revision > tonumber(DBM.Revision) then
						playerWithHigherVersionPromoted = true
					end
				end
			end
			enableIcons = not playerWithHigherVersionPromoted
			for i, v in pairs(raid) do
				if not v.updated then
					raidUIds[v.id] = nil
					raidGuids[v.guid] = nil
					raidShortNames[v.shortname] = nil
					raid[i] = nil
					fireEvent("raidLeave", i)
				else
					v.updated = nil
				end
			end
		elseif IsInGroup() then
			table.wipe(raidShortNames)
			if not inRaid then
				-- joined a new party
				inRaid = true
				sendSync("H")
				DBM:Schedule(2, DBM.RequestTimers, DBM)
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
				if not raidShortNames[shortname] then
					raidShortNames[shortname] = name
				else
					raidShortNames[shortname] = DBM_CORE_GENERIC_WARNING_DUPLICATE:format(name:gsub("%-.*$", ""))
				end
			end
			for i, v in pairs(raid) do
				if not v.updated then
					raidUIds[v.id] = nil
					raidGuids[v.guid] = nil
					raidShortNames[v.shortname] = nil
					raid[i] = nil
					fireEvent("partyLeave", i)
				else
					v.updated = nil
				end
			end
		else
			-- left the current group/raid
			inRaid = false
			enableIcons = true
			fireEvent("raidLeave", playerName)
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
			raidShortNames[playerName] = playerName
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

	function DBM:IsInRaid()
		return inRaid
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

	function DBM:GetFullNameByShortName(name)
		return raidShortNames[name]
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

	-- returns the unit ids of all raid or party members, including the player's own id
	-- limitations: will break if there are ever raids with more than 99 players or partys with more than 10
	function DBM:GetGroupMembers()
		if IsInRaid() then
			return raidIterator, GetNumGroupMembers(), "raid0"
		else
			return partyIterator, GetNumSubgroupMembers(), nil
		end
	end
end

function DBM:GetNumGroupMembers()
	return GetNumGroupMembers()
end

function DBM:GetBossUnitId(name)
	for i = 1, 5 do
		if UnitName("boss" .. i) == name then
			return "boss" .. i
		end
	end
	for uId in DBM:GetGroupMembers() do
		if UnitName(uId .. "target") == name and not UnitIsPlayer(uId .. "target") then
			return uId .. "target"
		end
	end
end

---------------
--  Options  --
---------------
do
	local function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if t1[i] == nil then
				t1[i] = v
			elseif type(v) == "table" and type(t1[i]) == "table" then
				addDefaultOptions(t1[i], v)
			end
		end
	end

	local function setRaidWarningPositon()
		RaidWarningFrame:ClearAllPoints()
		RaidWarningFrame:SetPoint(DBM.Options.RaidWarningPosition.Point, UIParent, DBM.Options.RaidWarningPosition.Point, DBM.Options.RaidWarningPosition.X, DBM.Options.RaidWarningPosition.Y)
	end

	local function migrateSavedOptions()
		-- reset default special warning font for russian clients due to many reports of problems with cyrillic characters in special warnings
		if DBM.Options.LastRevision < 7998 then
			DBM.Options.LastRevision = DBM.Revision
			if GetLocale() == "ruRU" then
				DBM.Options.SpecialWarningFont = STANDARD_TEXT_FONT
			end
		end
	end

	function loadOptions()
		DBM.Options = DBM_SavedOptions
		enabled = DBM.Options.Enabled
		addDefaultOptions(DBM.Options, DBM.DefaultOptions)
		-- load special warning options
		migrateSavedOptions()
		DBM:UpdateSpecialWarningOptions()
		-- set this with a short delay to prevent issues with other addons also trying to do the same thing with another position ;)
		DBM:Schedule(5, setRaidWarningPositon)
	end

	function loadModOptions(modId)
		local savedOptions = _G[modId:gsub("-", "").."_SavedVars"] or {}
		local savedStats = _G[modId:gsub("-", "").."_SavedStats"] or {}
		for i, v in ipairs(DBM.Mods) do
			if v.modId == modId then
				-- import old options from mods that were using the encounter ID as number as id
				-- this was changed to use the string for compatibility reasons (see issues with sync),
				-- but a user might still have saved options or stats that still use the old id as number
				if tonumber(v.id) then
					local oldId = tonumber(v.id)
					if savedOptions[oldId] then
						savedOptions[v.id] = savedOptions[oldId]
						savedOptions[oldId] = nil
					end
					if savedStats[oldId] then
						savedStats[v.id] = savedStats[oldId]
						savedStats[oldId] = nil
					end
				end
				savedOptions[v.id] = savedOptions[v.id] or v.Options
				for option, optionValue in pairs(v.Options) do
					v.DefaultOptions[option] = optionValue
					if savedOptions[v.id][option] == nil then
						savedOptions[v.id][option] = optionValue
					end
				end
				v.Options = savedOptions[v.id] or {}
				savedStats[v.id] = savedStats[v.id] or {}
				local stats = savedStats[v.id]
				stats.normalKills = stats.normalKills or 0
				stats.normalPulls = stats.normalPulls or 0
				stats.heroicKills = stats.heroicKills or 0
				stats.heroicPulls = stats.heroicPulls or 0
				stats.challengeKills = stats.challengeKills or 0
				stats.challengePulls = stats.challengePulls or 0
				stats.normal25Kills = stats.normal25Kills or 0
				stats.normal25Kills = stats.normal25Kills or 0
				stats.normal25Pulls = stats.normal25Pulls or 0
				stats.heroic25Kills = stats.heroic25Kills or 0
				stats.heroic25Pulls = stats.heroic25Pulls or 0
				stats.lfr25Kills = stats.lfr25Kills or 0
				stats.lfr25Pulls = stats.lfr25Pulls or 0
				v.stats = stats
				if v.OnInitialize then v:OnInitialize() end
				for i, cat in ipairs(v.categorySort) do -- temporary hack
					if cat == "misc" then
						table.remove(v.categorySort, i)
						table.insert(v.categorySort, cat)
						break
					end
				end
			end
		end
		_G[modId:gsub("-", "").."_SavedVars"] = savedOptions
		_G[modId:gsub("-", "").."_SavedStats"] = savedStats
	end
end


function DBM:LFG_PROPOSAL_SHOW()
	DBM.Bars:CreateBar(40, DBM_LFG_INVITE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
end

function DBM:LFG_PROPOSAL_FAILED()
	DBM.Bars:CancelBar(DBM_LFG_INVITE)
end

function DBM:LFG_PROPOSAL_SUCCEEDED()
	DBM.Bars:CancelBar(DBM_LFG_INVITE)
end

function DBM:PLAYER_REGEN_ENABLED()
	if combatDelay then
		combatDelay = false
		collectgarbage("collect")
	end
	if guiRequested and not IsAddOnLoaded("DBM-GUI") then
		guiRequested = false
		DBM:LoadGUI()
	end
end

function DBM:UPDATE_BATTLEFIELD_STATUS()
	for i = 1, 2 do
		if GetBattlefieldStatus(i) == "confirm" then
			queuedBattlefield[i] = select(2, GetBattlefieldStatus(i))
			DBM.Bars:CreateBar(85, queuedBattlefield[i], "Interface\\Icons\\Spell_Holy_BorrowedTime")	-- need to confirm the timer
		elseif queuedBattlefield[i] then
			DBM.Bars:CancelBar(queuedBattlefield[i])
			queuedBattlefield[i] = nil
		end
	end
end

--Loading routeens hacks for world bosses based on target or mouseover.
function DBM:UPDATE_MOUSEOVER_UNIT()
	if IsInInstance() or UnitIsDead("player") or UnitIsDead("mouseover") then return end--If you're in an instance no reason to waste cpu. If THE BOSS dead, no reason to load a mod for it. To prevent rare lua error, needed to filter on player dead.
	local guid = UnitGUID("mouseover")
	if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
		local cId = tonumber(guid:sub(6, 10), 16)
		if (cId == 17711 or cId == 18728) and not IsAddOnLoaded("DBM-Outlands") then--Burning Crusade World Bosses: Doomwalker and Kazzak
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-Outlands" then
					self:LoadMod(v)
					break
				end
			end
		elseif (cId == 50063 or cId == 50056 or cId == 50089 or cId == 50009 or cId == 50061) and not IsAddOnLoaded("DBM-Party-Cataclysm") then--Cataclysm World Bosses: Akamhat, Garr, Julak, Mobus, Xariona
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-Party-Cataclysm" then
					self:LoadMod(v)
					break
				end
			end
		elseif (cId == 62346 or cId == 60491 or cId == 69161 or cId == 69099) and not IsAddOnLoaded("DBM-Pandaria") then--Mists of Pandaria World Bosses: Anger, Salyis
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-Pandaria" then
					self:LoadMod(v)
					break
				end
			end
		elseif (cId == 55003 or cId == 54499 or cId == 15467 or cId == 15466 or cId == 49687) and not IsAddOnLoaded("DBM-WorldEvents") then--The Abominable Greench & his helpers (Winter Veil world boss), Omen & his minions (Lunar Festival world boss), Plants vs Zombie npc
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-WorldEvents" then
					self:LoadMod(v)
					break
				end
			end
		end
	end
end

function DBM:PLAYER_TARGET_CHANGED()
	if IsInInstance() or UnitIsDead("target") then return end--If you're in an instance no reason to waste cpu. If it's dead, no reason to load a mod for it.
	local guid = UnitGUID("target")
	if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
		local cId = tonumber(guid:sub(6, 10), 16)
		if (cId == 17711 or cId == 18728) and not IsAddOnLoaded("DBM-Outlands") then
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-Outlands" then
					self:LoadMod(v)
					break
				end
			end
		elseif (cId == 50063 or cId == 50056 or cId == 50089 or cId == 50009 or cId == 50061) and not IsAddOnLoaded("DBM-Party-Cataclysm") then
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-Party-Cataclysm" then
					self:LoadMod(v)
					break
				end
			end
		elseif (cId == 62346 or cId == 60491 or cId == 69161 or cId == 69099) and not IsAddOnLoaded("DBM-Pandaria") then
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-Pandaria" then
					self:LoadMod(v)
					break
				end
			end
		elseif (cId == 55003 or cId == 54499 or cId == 15467 or cId == 15466 or cId == 49687) and not IsAddOnLoaded("DBM-WorldEvents") then
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-WorldEvents" then
					self:LoadMod(v)
					break
				end
			end
		end
	end
end

function DBM:CINEMATIC_START()
	if DBM.Options.DisableCinematics and IsInInstance() or (DBM.Options.DisableCinematicsOutside and not IsInInstance()) then--This will also kill non movie cinematics, like the bridge in firelands
		CinematicFrame_CancelCinematic()
	end
end

function DBM:LFG_COMPLETION_REWARD()
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
--	local firstZoneChangedEvent = true
	function DBM:ZONE_CHANGED_NEW_AREA()
		--Work around for the zone ID/area updating slow because the world map doesn't always have correct information on zone change
		--unless we apsolutely make sure we force it to right zone before asking for info.
		if WorldMapFrame:IsVisible() and not IsInInstance() then --World map is open and we're not in an instance, (such as flying from zone to zone doing archaeology)
			local C, Z = GetCurrentMapContinent(), GetCurrentMapZone()--Save current map settings.
			SetMapToCurrentZone()--Force to right zone
			LastZoneMapID = GetCurrentMapAreaID() or -1 --Set accurate zone area id into cache
			LastZoneText = GetRealZoneText() or "" --Do same with zone name.
			local C2, Z2 = GetCurrentMapContinent(), GetCurrentMapZone()--Get right info after we set map to right place.
			if C2 ~= C or Z2 ~= Z then
				SetMapZoom(C, Z)--Restore old map settings if they differed to what they were prior to forcing mapchange and user has map open.
			end
		else--Map isn't open, no reason to save/restore settings, just make sure the information is correct and that's it.
			SetMapToCurrentZone()
			LastZoneMapID = GetCurrentMapAreaID() --Set accurate zone area id into cache
			LastZoneText = GetRealZoneText() --Do same with zone name.
		end
--		self:AddMsg(LastZoneMapID)--Debug
		for i, v in ipairs(self.AddOns) do
			if not IsAddOnLoaded(v.modId) and (checkEntry(v.zone, LastZoneText) or (checkEntry(v.zoneId, LastZoneMapID))) then --To Fix blizzard bug here as well. MapID loading requiring instance since we don't force map outside instances, prevent throne loading at login outside instances. -- TODO: this work-around implies that zoneID based loading is only used for instances
				-- srsly, wtf? LoadAddOn doesn't work properly on ZONE_CHANGED_NEW_AREA when reloading the UI
				-- TODO: is this still necessary? this was a WotLK beta bug A: loading stuff during a loading screen seems to bug sometimes as of 4.1
--				if firstZoneChangedEvent then
--					firstZoneChangedEvent = false
					self:Unschedule(DBM.LoadMod, DBM, v)
					self:Schedule(3, DBM.LoadMod, DBM, v)
					--Lets try multiple checks, cause quite frankly this has been failinga bout 50% of time with just one check.
					self:Schedule(4, DBM.ScenarioCheck)
					self:Schedule(8, DBM.ScenarioCheck)
					self:Schedule(12, DBM.ScenarioCheck)
--				else -- just the first event seems to be broken and loading stuff during the ZONE_CHANGED event is slightly better as it doesn't add a short lag just after the loading screen (instead the loading screen is a few ms longer, no one notices that, but a 100 ms lag a few seconds after the loading screen sucks)
--					self:LoadMod(v)
--				end
			end
		end
		if select(2, IsInInstance()) == "pvp" and not self:GetModByName("AlteracValley") then
			for i, v in ipairs(DBM.AddOns) do
				if v.modId == "DBM-PvP" then
					self:LoadMod(v)
					break
				end
			end
		end
	end
end

--LFG_IsHeroicScenario(dungeonID)--5.3
--Going to have to stop neglecting scenario mods. in fact, we should get all the current scenarios finished now, they all have heroics in 5.3
function DBM:ScenarioCheck()
	DBM:Unschedule(DBM.ScenarioCheck)
	if combatInfo[LastZoneMapID] then
		for i, v in ipairs(combatInfo[LastZoneMapID]) do
			if v.type == "scenario" and checkEntry(v.msgs, LastZoneMapID) then
				DBM:StartCombat(v.mod, 0)
			end
		end
	end
end

function DBM:LoadMod(mod)
	if type(mod) ~= "table" then return false end
	local _, _, _, enabled = GetAddOnInfo(mod.modId)
	if not enabled then
		EnableAddOn(mod.modId)
	end

	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		if reason then
			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_"..reason or ""])))
		else
--			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), DBM_CORE_UNKNOWN)) -- wtf, this should never happen....(but it does happen sometimes if you reload your UI in an instance...)
		end
		return false
	else
		if DBM.Options.ShowLoadMessage then--Make load option optional for advanced users, option is NOT in the GUI.
			self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		end
		loadModOptions(mod.modId)
		for i, v in ipairs(DBM.Mods) do -- load the hasHeroic/oneFormat attributes from the toc into all boss mods as required by the GetDifficulty() method
			if v.modId == mod.modId then
				v.type = mod.type
				v.oneFormat = mod.oneFormat
				v.hasLFR = mod.hasLFR
				v.hasChallenge = mod.hasChallenge
				v.noHeroic = mod.noHeroic
			end
		end
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		local _, instanceType, difficulty, _, maxPlayers = GetInstanceInfo()
		if InCombatLockdown() and difficulty == 1 or difficulty == 2 then--In combat in a 5 man. the garbage collect on 5 man party mods is too big to do in combat and causes "script ran too long"
			combatDelay = true
		else
			collectgarbage("collect")
		end
		return true
	end
end

do
	if select(4, GetAddOnInfo("DBM-PvP")) and select(5, GetAddOnInfo("DBM-PvP")) then
		local checkBG
		function checkBG()
			if not DBM:GetModByName("AlteracValley") and MAX_BATTLEFIELD_QUEUES then
				for i = 1, MAX_BATTLEFIELD_QUEUES do
					if GetBattlefieldStatus(i) == "confirm" then
						for i, v in ipairs(DBM.AddOns) do
							if v.modId == "DBM-PvP" then
								DBM:LoadMod(v)
								return
							end
						end
					end
				end
				DBM:Schedule(1, checkBG)
			end
		end
		DBM:Schedule(1, checkBG)
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

	syncHandlers["M"] = function(sender, mod, revision, event, ...)
		mod = DBM:GetModByName(mod or "")
		if mod and event and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, sender, revision, ...)
		end
	end

	syncHandlers["C"] = function(sender, delay, mod, revision, startHp)
		if select(2, IsInInstance()) == "pvp" then return end
		local lag = select(4, GetNetStats()) / 1000
		delay = tonumber(delay or 0) or 0
		mod = DBM:GetModByName(mod or "")
		revision = tonumber(revision or 0) or 0
		startHp = tonumber(startHp or -1) or -1
		if mod and delay and (not mod.zones or mod.zones[LastZoneText] or mod.zones[LastZoneMapID]) and (not mod.minSyncRevision or revision >= mod.minSyncRevision) then
			DBM:StartCombat(mod, delay + lag, true, startHp)
		end
	end

	syncHandlers["K"] = function(sender, cId)
		if select(2, IsInInstance()) == "pvp" then return end
		cId = tonumber(cId or "")
		if cId then DBM:OnMobKill(cId, true) end
	end

	local dummyMod -- dummy mod for the pull sound effect
	syncHandlers["PT"] = function(sender, timer)
		if select(2, IsInInstance()) == "pvp" or DBM:GetRaidRank(sender) == 0 or IsEncounterInProgress() then
			return
		end
		timer = tonumber(timer or 0)
		if timer > 60 then
			return
		end
		if not dummyMod then
			dummyMod = DBM:NewMod("PullTimerCountdownDummy")
			dummyMod.countdown = dummyMod:NewCountdown(0, 0, nil, nil, nil, true)
		end
		--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is inp rogress)
		if not DBM.Options.DontShowPT and DBM.Bars:GetBar(DBM_CORE_TIMER_PULL) then
			DBM.Bars:CancelBar(DBM_CORE_TIMER_PULL) 
		end
		if not DBM.Options.DontPlayPTCountdown then
			dummyMod.countdown:Cancel()
		end
		if not DBM.Options.DontShowPTCountdownText then
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")--easiest way to nil out timers on TimerTracker frame. This frame just has no actual star/stop functions :\
		end
		if timer == 0 then return end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is w hy we let above part of code run but not below)
		if not DBM.Options.DontShowPT then
			DBM.Bars:CreateBar(timer, DBM_CORE_TIMER_PULL, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		end
		if not DBM.Options.DontPlayPTCountdown then
			dummyMod.countdown:Start(timer)
		end
		if not DBM.Options.DontShowPTCountdownText then
			TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)--Hopefully this doesn't taint. Initial tests show positive even though it is an intrusive way of calling a blizzard timer. It's too bad the max value doesn't seem to actually work
		end
		DBM:StartLogging(timer, checkForActualPull)
	end

	-- TODO: is there a good reason that version information is broadcasted and not unicasted?
	syncHandlers["H"] = function(sender)
		sendSync("V", ("%d\t%s\t%s\t%s"):format(DBM.Revision, DBM.Version, DBM.DisplayVersion, GetLocale()))
	end

	syncHandlers["V"] = function(sender, revision, version, displayVersion, locale)
		revision, version = tonumber(revision or ""), tonumber(version or "")
		if revision and version and displayVersion and raid[sender] then
			raid[sender].revision = revision
			raid[sender].version = version
			raid[sender].displayVersion = displayVersion
			raid[sender].locale = locale
			if revision ~= 99999 and revision > tonumber(DBM.Revision) then
				if raid[sender].rank >= 1 then
					enableIcons = false
				end
			end
			if version > tonumber(DBM.Version) and version ~= 99999 then -- Update reminder
				if not showedUpdateReminder then
					local found = false
					for i, v in pairs(raid) do
						if v.version == version and v ~= raid[sender] then
							found = true
							break
						end
					end
					if found then
						showedUpdateReminder = true
						if not DBM.Options.BlockVersionUpdateNotice then
							DBM:ShowUpdateReminder(displayVersion, revision)
						else
							DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("([^\n]*)"))
							DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, version))
							DBM:AddMsg(("|HDBM:update:%s:%s|h|cff3588ff[http://dev.deadlybossmods.com]"):format(displayVersion, version))
						end
					end
				end
			end
		end
	end

	syncHandlers["U"] = function(sender, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM:GetRaidRank(sender) == 0 then return end
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
		local accessList

		StaticPopupDialogs["DBM_INSTANCE_ID_PERMISSION"] = {
			preferredIndex = STATICPOPUP_NUMDIALOGS,
			text = DBM_REQ_INSTANCE_ID_PERMISSION,
			button1 = YES,
			button2 = NO,
			OnAccept = function(self)
				accessList[self.data] = true
				syncHandlers["IR"](self.data) -- just call the sync handler again, the sender is now on the accessList and the requested data will be sent
			end,
			OnCancel = function(self, data, reason)
				SendAddonMessage("D4", "II\t" .. (reason or "unknown"), "WHISPER", self.data) -- some events might
			end,
			timeout = 59,
			hideOnEscape = 1,
			noCancelOnReuse = 1,
			multiple = 1,
			showAlert = 1,
			whileDead = 1
		}

		syncHandlers["IR"] = function(sender)
			if DBM:GetRaidRank(sender) == 0 or sender == playerName then
				return
			end
			accessList = accessList or {}
			if not accessList[sender] then
				-- ask for permission
				StaticPopup_Show("DBM_INSTANCE_ID_PERMISSION", sender, sender, sender)
				return
			end
			-- okay, send data
			local sentData = false
			for i = 1, GetNumSavedInstances() do
				local name, id, _, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, _, _, progress = GetSavedInstanceInfo(i)
				local longId = ("%x%x"):format(instanceIDMostSig, id) -- used as unique id by then default UI, so it's probably the "real" id
				if (locked or extended) and isRaid then -- only report locked raid instances
					SendAddonMessage("D4", "II\tData\t" .. name .. "\t" .. longId .. "\t" .. difficulty .. "\t" .. maxPlayers .. "\t" .. (progress or 0), "WHISPER", sender)
					sentData = true
				end
			end
			if not sentData then
				-- send something even if there is nothing to report so the receiver is able to tell you apart from someone who just didn't respond...
				SendAddonMessage("D4", "II\tNoData", "WHISPER", sender)
			end
		end

		syncHandlers["IRE"] = function(sender)
			local popup = StaticPopup_FindVisible("DBM_INSTANCE_ID_PERMISSION", sender)
			if popup and popup.data == sender then -- found the popup with the correct data (StaticPopup_FindVisible already checks the data (but only if multiple is set), check it again to be safe is the function changes or something...)
				popup:Hide()
			end
		end

		local lastRequest = 0
		local numResponses = 0
		local expectedResponses = 0
		local allResponded = false
		local results

		local updateInstanceInfo, showResults

		whisperSyncHandlers["II"] = function(sender, result, name, id, diff, maxPlayers, progress)
			if GetTime() - lastRequest > 62 or not results then
				return
			end
			if not result then
				return
			end
			name = name or "Unknown"
			id = id or ""
			diff = tonumber(diff or 0) or 0
			maxPlayers = tonumber(maxPlayers or 0) or 0
			progress = tonumber(progress or 0) or 0

			-- count responses
			if not results.responses[sender] then
				results.responses[sender] = result
				numResponses = numResponses + 1
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
				results.data[instanceId].ids[id] = results.data[instanceId].ids[id] or { progress = progress }
				table.insert(results.data[instanceId].ids[id], sender)
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
			-- TODO: you could catch some localized instances by observing IDs if there are multiple players with the same instance ID but a different name ;) (not that useful if you are trying to get a fresh instance)
			DBM:AddMsg(DBM_INSTANCE_INFO_RESULTS)
			for i, v in pairs(results.data) do
				DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_HEADER:format(v.name, v.maxPlayers, v.diff))
				for id, v in pairs(v.ids) do
					DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_INSTANCE:format(id, v.progress, table.concat(v, ", ")))
				end
			end
			local denied = {}
			local away = {}
			local noResponse = {}
			for i = 1, GetNumGroupMembers() do
				if not UnitIsUnit("raid"..i, "player") then
					table.insert(noResponse, (GetRaidRosterInfo(i)))
				end
			end
			for i, v in pairs(results.responses) do
				if v == "Data" or v == "NoData" then
				elseif v == "timeout" then
					table.insert(away, i)
				else -- could be "clicked" or "override", in both cases we don't get the data because the dialog requesting it was dismissed
					table.insert(denied, i)
				end
				removeEntry(noResponse, i)
			end
			if #denied > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_DENIED:format(table.concat(denied, ", ")))
			end
			if #away > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_AWAY:format(table.concat(away, ", ")))
			end
			if #noResponse > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_NO_RESPONSE:format(table.concat(noResponse, ", ")))
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
				if v.revision and v.name ~= playerName and UnitIsConnected(DBM:GetRaidUnitId(v.name)) then
					r = r + 1
				end
			end
			return r
		end

		function updateInstanceInfo(timeRemaining, dontAddShowResultNowButton)
			local numResponses, sent, denied, away = getResponseStats()
			local dbmUsers = getNumDBMUsers()
			DBM:AddMsg(DBM_INSTANCE_INFO_STATUS_UPDATE:format(numResponses, dbmUsers, sent, denied, timeRemaining))
			if not dontAddShowResultNowButton then
				if dbmUsers - numResponses <= 7 then -- waiting for 7 or less players, show their names and the early result option
					-- copied from above, todo: implement a smarter way of keeping track of stuff like this
					local noResponse = {}
					for i = 1, GetNumGroupMembers() do
						if not UnitIsUnit("raid"..i, "player") and raid[GetRaidRosterInfo(i)] and raid[GetRaidRosterInfo(i)].revision then -- only show players who actually can respond (== DBM users)
							table.insert(noResponse, (GetRaidRosterInfo(i)))
						end
					end
					for i, v in pairs(results.responses) do
						removeEntry(noResponse, i)
					end

					--[[
					-- this looked like the easiest way (for some reason?) to create the player string when writing this code -.-
					local function dup(...) if select("#", ...) == 0 then return else return ..., ..., dup(select(2, ...)) end end
					DBM:AddMsg(DBM_INSTANCE_INFO_SHOW_RESULTS:format(("|Hplayer:%s|h[%s]|h| "):rep(#noResponse):format(dup(unpack(noResponse)))))
					]]
					-- code that one can actually read
					for i, v in ipairs(noResponse) do
						noResponse[i] = ("|Hplayer:%s|h[%s]|h|"):format(v, v)
					end
					DBM:AddMsg(DBM_INSTANCE_INFO_SHOW_RESULTS:format(table.concat(noResponse, ", ")))
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

	local function handleSync(channel, sender, prefix, ...)
		if not prefix then
			return
		end
		local handler
		if channel == "WHISPER" then -- separate between broadcast and unicast, broadcast must not be sent as unicast or vice-versa
			handler = whisperSyncHandlers[prefix]
		else
			handler = syncHandlers[prefix]
		end
		if handler then
			return handler(sender, ...)
		end
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if prefix == "D4" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT" or channel == "WHISPER" and self:GetRaidUnitId(sender)) then
			handleSync(channel, sender, strsplit("\t", msg))
		end
	end
end


-----------------------
--  Update Reminder  --
-----------------------
function DBM:ShowUpdateReminder(newVersion, newRevision)
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:SetFrameStrata("DIALOG")
	frame:SetWidth(430)
	frame:SetHeight(155)
	frame:SetPoint("TOP", 0, -230)
	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
		insets = {left = 11, right = 12, top = 12, bottom = 11},
	})
	local fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	fontstring:SetWidth(410)
	fontstring:SetHeight(0)
	fontstring:SetPoint("TOP", 0, -16)
	fontstring:SetText(DBM_CORE_UPDATEREMINDER_HEADER:format(newVersion, newRevision))
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
	editBox:SetText("http://dev.deadlybossmods.com")
	editBox:HighlightText()
	editBox:SetScript("OnTextChanged", function(self)
		editBox:SetText("http://dev.deadlybossmods.com")
		editBox:HighlightText()
	end)
	local fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	fontstring:SetWidth(410)
	fontstring:SetHeight(0)
	fontstring:SetPoint("TOP", editBox, "BOTTOM", 0, 0)
	fontstring:SetText(DBM_CORE_UPDATEREMINDER_FOOTER)
	local button = CreateFrame("Button", nil, frame)
	button:SetHeight(24)
	button:SetWidth(75)
	button:SetPoint("BOTTOM", 0, 13)
	button:SetNormalFontObject("GameFontNormal")
	button:SetHighlightFontObject("GameFontHighlight")
	button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
	button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
	button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
	button:SetText(DBM_CORE_OK)
	button:SetScript("OnClick", function(self)
		frame:Hide()
	end)
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
			if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
				local cId = tonumber(guid:sub(6, 10), 16)
				targetList[cId] = id
			end
		end
	end

	local function clearTargetList()
		table.wipe(targetList)
	end

	local function scanForCombat(mod, mob)
		if not checkEntry(inCombat, mod) then
			buildTargetList()
			if targetList[mob] and UnitAffectingCombat(targetList[mob]) then
				DBM:StartCombat(mod, 3)
			end
			clearTargetList()
		end
	end


	local function checkForPull(mob, combatInfo)
		local uId = targetList[mob]
		if uId and UnitAffectingCombat(uId) then
			DBM:StartCombat(combatInfo.mod, 0)
			return true
		elseif uId then
			DBM:Schedule(3, scanForCombat, combatInfo.mod, mob)
		end
	end

	-- TODO: fix the duplicate code that was added for quick & dirty support of zone IDs

	-- detects a boss pull based on combat state, this is required for pre-ICC bosses that do not fire INSTANCE_ENCOUNTER_ENGAGE_UNIT events on engage
	function DBM:PLAYER_REGEN_DISABLED()
		if not combatInitialized then return end
		if combatInfo[LastZoneText] or combatInfo[LastZoneMapID] then
			buildTargetList()
			if combatInfo[LastZoneText] then
				for i, v in ipairs(combatInfo[LastZoneText]) do
					if v.type == "combat" then
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
			-- copy & paste, lol
			if combatInfo[LastZoneMapID] then
				for i, v in ipairs(combatInfo[LastZoneMapID]) do
					if v.type == "combat" then
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
			clearTargetList()
		end
	end

	local function isBossEngaged(cId)
		-- note that this is designed to work with any number of bosses, but it might be sufficient to check the first 4 unit ids
		-- TODO: check if the client supports more than 4 boss unit IDs...just because the default boss health frame is limited to 4 doesn't mean there can't be more
		local i = 1
		repeat
			local bossUnitId = "boss"..i
			local bossExists = UnitExists(bossUnitId)
			local bossGUID = bossExists and not UnitIsDead(bossUnitId) and UnitGUID(bossUnitId) -- check for UnitIsVisible maybe?
			local bossCId = bossGUID and tonumber(bossGUID:sub(6, 10), 16)
			if bossCId and (type(cId) == "number" and cId == bossCId or type(cId) == "table" and checkEntry(cId, bossCId)) then
				return true
			end
			i = i + 1
		until not bossExists
	end

	function DBM:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		if combatInfo[LastZoneText] then
			for i, v in ipairs(combatInfo[LastZoneText]) do
				if v.type == "combat" and isBossEngaged(v.multiMobPullDetection or v.mob) then
					self:StartCombat(v.mod, 0)
				end
			end
		end
		-- copy & paste, lol
		if combatInfo[LastZoneMapID] then
			for i, v in ipairs(combatInfo[LastZoneMapID]) do
				if v.type == "combat" and isBossEngaged(v.multiMobPullDetection or v.mob) then
					self:StartCombat(v.mod, 0)
				end
			end
		end
	end
end

do

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
		if combatInfo[LastZoneText] then
			for i, v in ipairs(combatInfo[LastZoneText]) do
				if v.type == type and checkEntry(v.msgs, msg)
				or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg) then
					DBM:StartCombat(v.mod, 0)
				end
			end
		end
		-- copy & paste, lol
		if combatInfo[LastZoneMapID] then
			for i, v in ipairs(combatInfo[LastZoneMapID]) do
				if v.type == type and checkEntry(v.msgs, msg)
				or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg) then
					DBM:StartCombat(v.mod, 0)
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

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		return onMonsterMessage("say", msg)
	end
end


---------------------------
--  Kill/Wipe Detection  --
---------------------------
local lowestBossHealth = 1 -- lowest health the boss had in the current fight
local savedDifficulty
local difficultyText

function checkWipe(confirm)
	if #inCombat > 0 then
		if not savedDifficulty or not difficultyText then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText = DBM:GetCurrentInstanceDifficulty()
		end
		local wipe = true
		if IsInScenarioGroup() then -- do not wipe in Scenario Group even player is ghot.
			wipe = false
		elseif IsEncounterInProgress() then
			wipe = false
		elseif InCombatLockdown() then
			wipe = false
		elseif savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- do not wipe on player dead or ghost while worldboss encounter.
			wipe = false
		else
			local uId = (IsInRaid() and "raid") or "party"
			for i = 0, GetNumGroupMembers() do
				local id = (i == 0 and "player") or uId..i
				if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
					wipe = false
					break
				end
			end
		end
		if not wipe then
			DBM:Schedule(3, checkWipe)
		elseif confirm then
			for i = #inCombat, 1, -1 do
				DBM:EndCombat(inCombat[i], true)
			end
		else
			local maxDelayTime = (savedDifficulty == "worldboss" and 20) or 5 --wait 15s more on worldboss do actual wipe.
			for i, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			DBM:Schedule(maxDelayTime, checkWipe, true)
		end
	end
end

function DBM:StartCombat(mod, delay, synced, syncedStartHp)
	if not checkEntry(inCombat, mod) then
		if not mod.Options.Enabled then return end
		-- HACK: makes sure that we don't detect a false pull if the event fires again when the boss dies...
		if mod.lastKillTime and GetTime() - mod.lastKillTime < (mod.reCombatTime or 10) then return end
		if not mod.combatInfo then return end
		if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
			return
		end
		table.insert(inCombat, mod)
		lowestBossHealth = 1
		savedDifficulty, difficultyText = self:GetCurrentInstanceDifficulty()
		if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
			mod.inCombatOnlyEventsRegistered = 1
			mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
		end
		if mod:IsDifficulty("lfr25") then
			mod.stats.lfr25Pulls = mod.stats.lfr25Pulls + 1
		elseif mod:IsDifficulty("normal5", "worldboss") then
			mod.stats.normalPulls = mod.stats.normalPulls + 1
		elseif mod:IsDifficulty("heroic5") then
			mod.stats.heroicPulls = mod.stats.heroicPulls + 1
		elseif mod:IsDifficulty("challenge5") then
			mod.stats.challengePulls = mod.stats.challengePulls + 1
		elseif mod:IsDifficulty("normal10") then
			mod.stats.normalPulls = mod.stats.normalPulls + 1
			local _, _, _, _, maxPlayers = GetInstanceInfo()
			--Because we still combine 40 mans with 10 man raids, we use maxPlayers arg for player count.
		elseif mod:IsDifficulty("heroic10") then
			mod.stats.heroicPulls = mod.stats.heroicPulls + 1
		elseif mod:IsDifficulty("normal25") then
			mod.stats.normal25Pulls = mod.stats.normal25Pulls + 1
		elseif mod:IsDifficulty("heroic25") then
			mod.stats.heroic25Pulls = mod.stats.heroic25Pulls + 1
		end
		if C_Scenario.IsInScenario() then
			mod.inScenario = true
		end
		mod.inCombat = true
		mod.blockSyncs = nil
		mod.combatInfo.pull = GetTime() - (delay or 0)
		self:Schedule(mod.minCombatTime or 3, checkWipe)
		if (DBM.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) and not mod.inScenario then
			DBM.BossHealth:Show(mod.localization.general.name)
			if mod.bossHealthInfo then
				for i = 1, #mod.bossHealthInfo, 2 do
					DBM.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
				end
			else
				DBM.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
			end
		end
		local startHp = tonumber((mod:GetHP():gsub("%%$", ""))) or syncedStartHp or -1
		if mod:IsDifficulty("worldboss") and startHp < 98 then--Boss was not full health when engaged, disable combat start timer and kill record. (regards full health : 98, 99, 100)
			mod.ignoreBestkill = true
		else--Reset ignoreBestkill after wipe
			mod.ignoreBestkill = false
		end
		if (DBM.Options.AlwaysShowSpeedKillTimer or mod.Options.SpeedKillTimer) and not mod.ignoreBestkill then
			local bestTime
			if mod:IsDifficulty("lfr25") and mod.stats.lfr25BestTime then
				bestTime = mod.stats.lfr25BestTime
			elseif mod:IsDifficulty("normal5", "normal10", "worldboss") and mod.stats.normalBestTime then
				bestTime = mod.stats.normalBestTime
			elseif mod:IsDifficulty("heroic5", "heroic10") and mod.stats.heroicBestTime then
				bestTime = mod.stats.heroicBestTime
			elseif mod:IsDifficulty("challenge5") and mod.stats.challengeBestTime then
				bestTime = mod.stats.challengeBestTime
			elseif mod:IsDifficulty("normal25") and mod.stats.normal25BestTime then
				bestTime = mod.stats.normal25BestTime
			elseif mod:IsDifficulty("heroic25") and mod.stats.heroic25BestTime then
				bestTime = mod.stats.heroic25BestTime
			end
			if bestTime and bestTime > 0 then
				local speedTimer = mod:NewTimer(bestTime, DBM_SPEED_KILL_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
				speedTimer:Start()
			end
		end
		if mod.OnCombatStart and not mod.ignoreBestkill then mod:OnCombatStart(delay or 0) end
		if not synced then
			sendSync("C", (delay or 0).."\t"..mod.id.."\t"..(mod.revision or 0).."\t"..startHp)
		end
		fireEvent("pull", mod, delay, synced, startHp)
		self:ToggleRaidBossEmoteFrame(1)
		if DBM.Options.ShowBigBrotherOnCombatStart and BigBrother and type(BigBrother.ConsumableCheck) == "function" then
			if DBM.Options.BigBrotherAnnounceToRaid then
				BigBrother:ConsumableCheck("RAID")
			else
				BigBrother:ConsumableCheck("SELF")
			end
		end
		self:StartLogging(0, nil)
		if DBM.Options.ShowEngageMessage then
			if mod.ignoreBestkill then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
				self:AddMsg(DBM_CORE_COMBAT_STARTED_IN_PROGRESS:format(difficultyText..mod.combatInfo.name))
			else
				self:AddMsg(DBM_CORE_COMBAT_STARTED:format(difficultyText..mod.combatInfo.name))
			end
		end
	end
end

function DBM:UNIT_HEALTH(uId)
	local cId = UnitGUID(uId) and tonumber(UnitGUID(uId):sub(6, 10), 16)
	if not cId then
		return
	end
	for i, v in ipairs(inCombat) do
		-- best guess for the ID of the boss we are interested in (from GetBossHPString)
		local bossId = v.mainBossId or (v.combatInfo and v.combatInfo.mob) or v.creatureId
		if cId == bossId then
			local health = (UnitHealth(uId) or 0) / (UnitHealthMax(uId) or 1)
			if health < lowestBossHealth then
				lowestBossHealth = health
			end
		end
	end
end

function DBM:EndCombat(mod, wipe)
	if removeEntry(inCombat, mod) then
		if not wipe then
			mod.lastKillTime = GetTime()
			if mod.inCombatOnlyEvents then
				-- unregister all events except for SPELL_AURA_REMOVED events (might still be needed to remove icons etc...)
				mod:UnregisterInCombatEvents("SPELL_AURA_REMOVED")
				self:Schedule(2, mod.UnregisterInCombatEvents, mod) -- 2 seconds should be enough for all auras to fade
				self:Schedule(2.1, mod.Stop, mod) -- Remove accident started timers.
				mod.inCombatOnlyEventsRegistered = nil
			end
		end
		mod:Stop()
		mod.inCombat = false
		mod.blockSyncs = true
		if mod.combatInfo.killMobs then
			for i, v in pairs(mod.combatInfo.killMobs) do
				mod.combatInfo.killMobs[i] = true
			end
		end
		self:Schedule(4, DBM.StopLogging)--small delay to catch kill/died combatlog events
		if not savedDifficulty or not difficultyText then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText = self:GetCurrentInstanceDifficulty()
		end
		if wipe then
			local thisTime = GetTime() - mod.combatInfo.pull
			local wipeHP = ("%d%%"):format(lowestBossHealth * 100)
			local totalPulls = (savedDifficulty == "lfr25" and mod.stats.lfr25Pulls) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicPulls) or (savedDifficulty == "challenge5" and mod.stats.challengePulls) or (savedDifficulty == "normal25" and mod.stats.normal25Pulls) or (savedDifficulty == "heroic25" and mod.stats.heroic25Pulls) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalPulls) or 0
			local totalKills = (savedDifficulty == "lfr25" and mod.stats.lfr25Kills) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicKills) or (savedDifficulty == "challenge5" and mod.stats.challengeKills) or (savedDifficulty == "normal25" and mod.stats.normal25Kills) or (savedDifficulty == "heroic25" and mod.stats.heroic25Kills) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalKills) or 0
			if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
				if savedDifficulty == "lfr25" then
					mod.stats.lfr25Pulls = mod.stats.lfr25Pulls - 1
				elseif savedDifficulty == "heroic5" or savedDifficulty == "heroic10" then
					mod.stats.heroicPulls = mod.stats.heroicPulls - 1
				elseif savedDifficulty == "challenge5" then
					mod.stats.challengePulls = mod.stats.challengePulls - 1
				elseif savedDifficulty == "normal25" then
					mod.stats.normal25Pulls = mod.stats.normal25Pulls - 1
				elseif savedDifficulty == "heroic25" then
					mod.stats.heroic25Pulls = mod.stats.heroic25Pulls - 1
				else
					mod.stats.normalPulls = mod.stats.normalPulls - 1
				end
				if DBM.Options.ShowWipeMessage then
					self:AddMsg(DBM_CORE_COMBAT_ENDED_AT:format(difficultyText..mod.combatInfo.name, wipeHP, strFromTime(thisTime)))
				end
			else
				if DBM.Options.ShowWipeMessage then
					self:AddMsg(DBM_CORE_COMBAT_ENDED_AT_LONG:format(difficultyText..mod.combatInfo.name, wipeHP, strFromTime(thisTime), totalPulls - totalKills))
				end
			end

			local msg
			for k, v in pairs(autoRespondSpam) do
				if DBM.Options.WhisperStats then
					msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, difficultyText..(mod.combatInfo.name or ""), wipeHP, totalPulls - totalKills)
				else
					msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_AT:format(playerName, difficultyText..(mod.combatInfo.name or ""), wipeHP)
				end
				sendWhisper(k, msg)
			end
			fireEvent("wipe", mod)
		else
			local thisTime = GetTime() - mod.combatInfo.pull
			local lastTime = (savedDifficulty == "lfr25" and mod.stats.lfr25LastTime) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicLastTime) or (savedDifficulty == "challenge5" and mod.stats.challengeLastTime) or (savedDifficulty == "normal25" and mod.stats.normal25LastTime) or (savedDifficulty == "heroic25" and mod.stats.heroic25LastTime) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalLastTime) or nil
			local bestTime = (savedDifficulty == "lfr25" and mod.stats.lfr25BestTime) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicBestTime) or (savedDifficulty == "challenge5" and mod.stats.challengeBestTime) or (savedDifficulty == "normal25" and mod.stats.normal25BestTime) or (savedDifficulty == "heroic25" and mod.stats.heroic25BestTime) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalBestTime) or nil
			if savedDifficulty == "lfr25" then
				if not mod.stats.lfr25Kills or mod.stats.lfr25Kills < 0 then mod.stats.lfr25Kills = 0 end
				if mod.stats.lfr25Kills > mod.stats.lfr25Pulls then mod.stats.lfr25Kills = mod.stats.lfr25Pulls end--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats.lfr25Kills = mod.stats.lfr25Kills + 1
				if not mod.ignoreBestkill then
					mod.stats.lfr25LastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 10 then--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
						mod.stats.lfr25BestTime = thisTime
					else
						mod.stats.lfr25BestTime = math.min(bestTime or math.huge, thisTime)
					end
				end
			elseif savedDifficulty == "normal5" or savedDifficulty == "worldboss" then
				if not mod.stats.normalKills or mod.stats.normalKills < 0 then mod.stats.normalKills = 0 end
				if mod.stats.normalKills > mod.stats.normalPulls then mod.stats.normalKills = mod.stats.normalPulls end
				mod.stats.normalKills = mod.stats.normalKills + 1
				if not mod.ignoreBestkill then
					mod.stats.normalLastTime = thisTime
					mod.stats.normalBestTime = math.min(bestTime or math.huge, thisTime)
				end
			elseif savedDifficulty == "heroic5" then
				if not mod.stats.heroicKills or mod.stats.heroicKills < 0 then mod.stats.heroicKills = 0 end
				if mod.stats.heroicKills > mod.stats.heroicPulls then mod.stats.heroicKills = mod.stats.heroicPulls end
				mod.stats.heroicKills = mod.stats.heroicKills + 1
				if not mod.ignoreBestkill then
					mod.stats.heroicLastTime = thisTime
					mod.stats.heroicBestTime = math.min(bestTime or math.huge, thisTime)
				end
			elseif savedDifficulty == "challenge5" then
				if not mod.stats.challengeKills or mod.stats.challengeKills < 0 then mod.stats.challengeKills = 0 end
				if mod.stats.challengeKills > mod.stats.challengePulls then mod.stats.challengeKills = mod.stats.challengePulls end
				mod.stats.challengeKills = mod.stats.challengeKills + 1
				if not mod.ignoreBestkill then
					mod.stats.challengeLastTime = thisTime
					mod.stats.challengeBestTime = math.min(bestTime or math.huge, thisTime)
				end
			elseif savedDifficulty == "normal10" then
				if not mod.stats.normalKills or mod.stats.normalKills < 0 then mod.stats.normalKills = 0 end
				if mod.stats.normalKills > mod.stats.normalPulls then mod.stats.normalKills = mod.stats.normalPulls end
				mod.stats.normalKills = mod.stats.normalKills + 1
				if not mod.ignoreBestkill then
					mod.stats.normalLastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 1.5 then--you did not kill a raid boss in one global CD. (all level 60 raids report as instance difficulty 1 which means this time has to be ridiculously low. It's more or less only gonna fix kill times of 0.)
						mod.stats.normalBestTime = thisTime
					else
						mod.stats.normalBestTime = math.min(bestTime or math.huge, thisTime)
					end
				end
			elseif savedDifficulty == "heroic10" then
				if not mod.stats.heroicKills or mod.stats.heroicKills < 0 then mod.stats.heroicKills = 0 end
				if mod.stats.heroicKills > mod.stats.heroicPulls then mod.stats.heroicKills = mod.stats.heroicPulls end
				mod.stats.heroicKills = mod.stats.heroicKills + 1
				if not mod.ignoreBestkill then
					mod.stats.heroicLastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 10 then
						mod.stats.heroicBestTime = thisTime
					else
						mod.stats.heroicBestTime = math.min(bestTime or math.huge, thisTime)
					end
				end
			elseif savedDifficulty == "normal25" then
				if not mod.stats.normal25Kills or mod.stats.normal25Kills < 0 then mod.stats.normal25Kills = 0 end
				if mod.stats.normal25Kills > mod.stats.normal25Pulls then mod.stats.normal25Kills = mod.stats.normal25Pulls end
				mod.stats.normal25Kills = mod.stats.normal25Kills + 1
				if not mod.ignoreBestkill then
					mod.stats.normal25LastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 10 then
						mod.stats.normal25BestTime = thisTime
					else
						mod.stats.normal25BestTime = math.min(bestTime or math.huge, thisTime)
					end
				end
			elseif savedDifficulty == "heroic25" then
				if not mod.stats.heroic25Kills or mod.stats.heroic25Kills < 0 then mod.stats.heroic25Kills = 0 end
				if mod.stats.heroic25Kills > mod.stats.heroic25Pulls then mod.stats.heroic25Kills = mod.stats.heroic25Pulls end
				mod.stats.heroic25Kills = mod.stats.heroic25Kills + 1
				if not mod.ignoreBestkill then
					mod.stats.heroic25LastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 10 then
						mod.stats.heroic25BestTime = thisTime
					else
						mod.stats.heroic25BestTime = math.min(bestTime or math.huge, thisTime)
					end
				end
			end
			local totalKills = (savedDifficulty == "lfr25" and mod.stats.lfr25Kills) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicKills) or (savedDifficulty == "challenge5" and mod.stats.challengeKills) or (savedDifficulty == "normal25" and mod.stats.normal25Kills) or (savedDifficulty == "heroic25" and mod.stats.heroic25Kills) or mod.stats.normalKills
			if DBM.Options.ShowKillMessage then
				if not thisTime then--was a bad pull so we ignored thisTime
					self:AddMsg(DBM_CORE_BOSS_DOWN:format(difficultyText..mod.combatInfo.name, DBM_CORE_UNKNOWN))
				elseif mod.ignoreBestkill then
					self:AddMsg(DBM_CORE_BOSS_DOWN_I:format(difficultyText..mod.combatInfo.name, totalKills))
				elseif not lastTime then
					self:AddMsg(DBM_CORE_BOSS_DOWN:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime)))
				elseif thisTime < (bestTime or math.huge) then
					self:AddMsg(DBM_CORE_BOSS_DOWN_NR:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime), strFromTime(bestTime), totalKills))
				else
					self:AddMsg(DBM_CORE_BOSS_DOWN_L:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime), totalKills))
				end
			end
			local msg
			for k, v in pairs(autoRespondSpam) do
				if DBM.Options.WhisperStats then
					msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL_STATS:format(playerName, difficultyText..(mod.combatInfo.name or ""), totalKills)
				else
					msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL:format(playerName, difficultyText..(mod.combatInfo.name or ""))
				end
				sendWhisper(k, msg)
			end
			fireEvent("kill", mod)
		end
		table.wipe(autoRespondSpam)
		if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
		DBM.BossHealth:Hide()
		DBM.Arrow:Hide(true)
		self:ToggleRaidBossEmoteFrame(0)
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

function DBM:StartLogging(timer, checkFunc)
	self:Unschedule(DBM.StopLogging)
	local difficulty = self:GetCurrentInstanceDifficulty()
	if DBM.Options.LogOnlyRaidBosses and difficulty ~= "normal10" and difficulty ~= "normal25" and difficulty ~= "heroic10" and difficulty ~= "heroic25" then return end
	if DBM.Options.AutologBosses and not LoggingCombat() then--Start logging here to catch pre pots.
		self:AddMsg("|cffffff00"..COMBATLOGENABLED.."|r")
		LoggingCombat(1)
		if checkFunc then
			self:Unschedule(checkFunc)
			self:Schedule(timer+10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
		end
	end
	if DBM.Options.AdvancedAutologBosses and IsAddOnLoaded("Transcriptor") then
		if not Transcriptor:IsLogging() then
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
	if DBM.Options.AutologBosses and LoggingCombat() then
		DBM:AddMsg("|cffffff00"..COMBATLOGDISABLED.."|r")
		LoggingCombat(0)
	end
	if DBM.Options.AdvancedAutologBosses and IsAddOnLoaded("Transcriptor") then
		if Transcriptor:IsLogging() then
			DBM:AddMsg("|cffffff00"..DBM_CORE_TRANSCRIPTOR_LOG_END.."|r")
			Transcriptor:StopLog(1)
		end
	end
end

function DBM:GetCurrentInstanceDifficulty()
	local _, instanceType, difficulty, _, maxPlayers = GetInstanceInfo()
	if not instanceType then--It's a scenario and blizzard reports these really goofy. Only place instanceType is nil
		return "normal5", GUILD_CHALLENGE_TYPE4.." - "--Just treat these like 5 man normals, for stat purposes.
		--5.3, heroic scenarios added, they can be heroic5 GUILD_CHALLENGE_TYPE4
	elseif difficulty == 1 then
		if instanceType == "party" then
			return "normal5", PLAYER_DIFFICULTY1.." ("..maxPlayers..") - "
		else--Should never happen anymore, now that outdoor areas return 0 instead of 1 like they used to, but we leave just in case
			return "normal5", ""
		end
	elseif difficulty == 2 then
		return "heroic5", PLAYER_DIFFICULTY2.." ("..maxPlayers..") - "
	elseif difficulty == 3 then
		return "normal10", PLAYER_DIFFICULTY1.." ("..maxPlayers..") - "
	elseif difficulty == 4 then
		return "normal25", PLAYER_DIFFICULTY1.." ("..maxPlayers..") - "
	elseif difficulty == 5 then
		return "heroic10", PLAYER_DIFFICULTY2.." ("..maxPlayers..") - "
	elseif difficulty == 6 then
		return "heroic25", PLAYER_DIFFICULTY2.." ("..maxPlayers..") - "
	elseif difficulty == 7 then
		return "lfr25", PLAYER_DIFFICULTY3.." - "
	elseif difficulty == 8 then
		return "challenge5", CHALLENGE_MODE.." - "
	elseif difficulty == 9 then--40 man raids have their own difficulty now, no longer returned as normal 10man raids
		return "normal10", PLAYER_DIFFICULTY1.." ("..maxPlayers..") - "--Just use normal10 anyways, since that's where we been saving 40 man stuff for so long anyways, no reason to change it now, not like any 40 mans can be toggled between 10 and 40 where we NEED to tell the difference.
	else--Returned 0, likely a world boss
		return "worldboss", DBM_CORE_WORLD_BOSS.." - "
	end
end

function DBM:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(1, 5), 0x00F) == 3 or bit.band(args.destGUID:sub(1, 5), 0x00F) == 5  then
		self:OnMobKill(tonumber(args.destGUID:sub(6, 10), 16))
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
		local bestClient
		for i, v in pairs(raid) do
			-- If bestClient player's realm is not same with your's, timer recovery by bestClient not works at all. 
			-- SendAddonMessage target channel is "WHISPER" and target player is other realm, no msg sends at all. At same realm, message sending works fine. (Maybe bliz bug or SendAddonMessage function restriction?)
			if v.name ~= playerName and UnitIsConnected(v.id) and (not UnitIsGhost(v.id)) and (v.revision or 0) > ((bestClient and bestClient.revision) or 0) and not select(2, UnitName(v.id)) and not clientUsed[v.name] then
				bestClient = v
				clientUsed[v.name] = true
			end
		end
		if not bestClient then return end
		requestedFrom = bestClient.name
		requestTime = GetTime()
		SendAddonMessage("D4", "RT", "WHISPER", bestClient.name)
	end

	function DBM:ReceiveCombatInfo(sender, mod, time)
		if sender == requestedFrom and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			if not mod.Options.Enabled then return end
			local lag = select(4, GetNetStats()) / 1000
			if not mod.combatInfo then return end
			self:AddMsg(DBM_CORE_COMBAT_STATE_RECOVERED:format(mod.combatInfo.name, strFromTime(time + lag)))
			table.insert(inCombat, mod)
			lowestBossHealth = 1
			savedDifficulty, difficultyText = self:GetCurrentInstanceDifficulty()
			if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
			end
			if C_Scenario.IsInScenario() then
				mod.inScenario = true
			end
			mod.inCombat = true
			mod.blockSyncs = nil
			mod.combatInfo.pull = GetTime() - time + lag
			if mod.minCombatTime then
				self:Schedule(math.max((mod.minCombatTime - time - lag), 3), checkWipe)
			else
				self:Schedule(3, checkWipe)
			end
			if (DBM.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) and not mod.inSecnario then
				DBM.BossHealth:Show(mod.localization.general.name)
				if mod.bossHealthInfo then
					for i = 1, #mod.bossHealthInfo, 2 do
						DBM.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
					end
				else
					DBM.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
				end
			end
			if (DBM.Options.AlwaysShowSpeedKillTimer or mod.Options.SpeedKillTimer) then
				local bestTime
				local elapsed = time + lag
				if mod:IsDifficulty("lfr25") and mod.stats.lfr25BestTime then
					bestTime = mod.stats.lfr25BestTime
				elseif mod:IsDifficulty("normal5", "normal10", "worldboss") and mod.stats.normalBestTime then
					bestTime = mod.stats.normalBestTime
				elseif mod:IsDifficulty("heroic5", "heroic10") and mod.stats.heroicBestTime then
					bestTime = mod.stats.heroicBestTime
				elseif mod:IsDifficulty("challenge5") and mod.stats.challengeBestTime then
					bestTime = mod.stats.challengeBestTime
				elseif mod:IsDifficulty("normal25") and mod.stats.normal25BestTime then
					bestTime = mod.stats.normal25BestTime
				elseif mod:IsDifficulty("heroic25") and mod.stats.heroic25BestTime then
					bestTime = mod.stats.heroic25BestTime
				end
				if bestTime and bestTime > 0 and elapsed < bestTime then	-- only start if you already have a bestTime :)
					local speedTimer = mod:NewTimer(bestTime, DBM_SPEED_KILL_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
					speedTimer:Update(time + lag, bestTime)
				end
			end
			self:ToggleRaidBossEmoteFrame(1)
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
end

do
	local spamProtection = {}
	function DBM:SendTimers(target)
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
		if #inCombat < 1 then return end
		local mod
		for i, v in ipairs(inCombat) do
			mod = not v.isCustomMod and v
		end
		mod = mod or inCombat[1]
		self:SendCombatInfo(mod, target)
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

do
	local function requestTimers()
		if #inCombat == 0 then
			if IsEncounterInProgress() then
				DBM:RequestTimers()
			else
				local uId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "player") or uId..i
					if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
						DBM:RequestTimers()
						break
					end
				end
			end
		end
	end

	function DBM:PLAYER_ENTERING_WORLD()
		self:Schedule(6, requestTimers) -- Time recovery. 3.5 sec too early if you have slow machine. try multiple check
		self:Schedule(10, requestTimers)
		self:Schedule(14, requestTimers)
		self:Schedule(18, requestTimers)
--		self:LFG_UPDATE()
--		self:Schedule(10, function() if not DBM.Options.HelpMessageShown then DBM.Options.HelpMessageShown = true DBM:AddMsg(DBM_CORE_NEED_SUPPORT) end end)
		self:Schedule(10, function() if not DBM.Options.SettingsMessageShown then DBM.Options.SettingsMessageShown = true self:AddMsg(DBM_HOW_TO_USE_MOD) end end)
		if type(RegisterAddonMessagePrefix) == "function" then
			if not RegisterAddonMessagePrefix("D4") then -- main prefix for DBM4
				self:AddMsg("Error: unable to register DBM addon message prefix (reached client side addon message filter limit), synchronization will be unavailable") -- TODO: confirm that this actually means that the syncs won't show up
			end
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


	local function isOnSameServer(presenceId)
		local toonID, client = select(5, BNGetFriendInfoByID(presenceId))
		if client ~= "WoW" then
			return false
		end
		return GetRealmName() == select(4, BNGetToonInfo(toonID))
	end

	-- sender is a presenceId for real id messages, a character name otherwise
	local function onWhisper(msg, sender, isRealIdMessage)
		-- ignore oQueue messages
		if msg and msg:sub(1, 3) == "OQ," then
			return
		end
		if msg == "status" and #inCombat > 0 and DBM.Options.StatusEnabled then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				difficultyText = select(2, DBM:GetCurrentInstanceDifficulty())
			end
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			sendWhisper(sender, chatPrefix..DBM_CORE_STATUS_WHISPER:format(difficultyText..(mod.combatInfo.name or ""), mod:GetHP() or "unknown", getNumAlivePlayers(), GetNumGroupMembers()))
		elseif #inCombat > 0 and DBM.Options.AutoRespond and
		(isRealIdMessage and (not isOnSameServer(sender) or not DBM:GetRaidUnitId(select(4, BNGetFriendInfoByID(sender)))) or not isRealIdMessage and not DBM:GetRaidUnitId(sender)) then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				difficultyText = select(2, DBM:GetCurrentInstanceDifficulty())
			end
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if not autoRespondSpam[sender] then
				sendWhisper(sender, chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER:format(playerName, difficultyText..(mod.combatInfo.name or ""), mod:GetHP() or "unknown", getNumAlivePlayers(), GetNumGroupMembers()))
				DBM:AddMsg(DBM_CORE_AUTO_RESPONDED)
			end
			autoRespondSpam[sender] = true
		end
	end

	function DBM:CHAT_MSG_WHISPER(msg, name)
		return onWhisper(msg, name, false)
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

	local function filterRaidWarning(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			return filterRaidWarning(nil, nil, self, event)
		end
		return type(msg) == "string" and (not not msg:match("^%s*%*%*%*")), ...
	end

	local function filterSayYell(self, event, ...)
		return DBM.Options.FilterSayAndYell and #inCombat > 0, ...
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filterSayYell)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filterSayYell)
end


do
	local old = RaidWarningFrame:GetScript("OnEvent")
	RaidWarningFrame:SetScript("OnEvent", function(self, event, msg, ...)
		if msg:find("%*%*%* .* %*%*%*") then
			return
		end
		return old(self, event, msg, ...)
	end)
end

--Raid Boss Emote frame handler for core and BG mods.
--This completely unregisteres or registers event so frame simply does or doesn't show events
--No dirty hooking. Least invasive way to do it. Uses lowest CPU
--Toggle is for if we are turning off or on.
--Custom is for exterior mods to call function without needing global option turned on (such as BG mods option)
--All also handled by core so both core AND pvp mods aren't trying to hook/hide it. Should all be done HERE
local unRegistered = false
function DBM:ToggleRaidBossEmoteFrame(toggle, custom)
	if not DBM.Options.HideBossEmoteFrame and not custom then return end
	if toggle == 1 and not unRegistered then
		unRegistered = true
		RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
		RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
	elseif toggle == 0 and unRegistered then
		unRegistered = false
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_WHISPER")
	end
end


--------------------------
--  Enable/Disable DBM  --
--------------------------
function DBM:Disable()
	unschedule()
	enabled = false
	self.Options.Enabled = false
end

function DBM:Enable()
	enabled = true
	self.Options.Enabled = true
end

function DBM:IsEnabled()
	return self.Options.Enabled
end


-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix)
	prefix = prefix or (self.localization and self.localization.general.name) or "Deadly Boss Mods"
	DEFAULT_CHAT_FRAME:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(prefix), tostring(text)), 0.41, 0.8, 0.94)
end

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer
	local testSpecialWarning1
	local testSpecialWarning2
	local testSpecialWarning3
	function DBM:DemoMode()
		if not testMod then
			testMod = self:NewMod("TestMod")
			testWarning1 = testMod:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
			testWarning2 = testMod:NewAnnounce("%s", 2, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
			testWarning3 = testMod:NewAnnounce("%s", 3, "Interface\\Icons\\Spell_Fire_SelfDestruct")
			testTimer = testMod:NewTimer(20, "%s")
			testSpecialWarning1 = testMod:NewSpecialWarning("%s")
			testSpecialWarning2 = testMod:NewSpecialWarning("%s", nil, nil, nil, true)
			testSpecialWarning3 = testMod:NewSpecialWarning("%s", nil, nil, nil, 3)
		end
		testTimer:Start(20, "Pew Pew Pew...")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_Starfall", "Pew Pew Pew...")
		testTimer:Start(10, "Test Bar")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_WispSplode", "Test Bar")
		testTimer:Start(43, "Evil Spell")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Shadow_ShadesOfDarkness", "Evil Spell")
		testTimer:Start(60, "Boom!")
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
		testSpecialWarning3:Schedule(43, "Evil Spell!")
		testSpecialWarning2:Schedule(60, "Boom!")
	end
end

DBM.Bars:SetAnnounceHook(function(bar)
	local prefix
	if bar.color and bar.color.r == 1 and bar.color.g == 0 and bar.color.b == 0 then
		prefix = DBM_CORE_HORDE
	elseif bar.color and bar.color.r == 0 and bar.color.g == 0 and bar.color.b == 1 then
		prefix = DBM_CORE_ALLIANCE
	end
	if prefix then
		return ("%s: %s  %d:%02d"):format(prefix, _G[bar.frame:GetName().."BarName"]:GetText(), math.floor(bar.timer / 60), bar.timer % 60)
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

-----------------
--  Map Sizes  --
-----------------
DBM.MapSizes = {}

function DBM:RegisterMapSize(zone, ...)
	if not DBM.MapSizes[zone] then
		DBM.MapSizes[zone] = {}
	end
	local zone = DBM.MapSizes[zone]
	for i = 1, select("#", ...), 3 do
		local level, width, height = select(i, ...)
		zone[level] = {width, height}
	end
end


-------------------
--  Movie Filter --
-------------------
MovieFrame:HookScript("OnEvent", function(self, event, id)
	if event == "PLAY_MOVIE" and id then
		if DBM.Options.MovieFilters[id] == "Block" or DBM.Options.MovieFilters[id] == "OnlyFirst" and DBM.Options.MoviesSeen[id] then
			MovieFrame_OnMovieFinished(self)
		end
	end
end)

function DBM:MovieFilter(mod, ...)
	local i = 1
	while i <= select("#", ...) do
		local id, name, default = select(i, ...)
		if type(default) == "string" then
			-- id, name, defaultSetting
			i = i + 3
		else
			-- id, name
			i = i + 2
			default = nil
		end
		mod:AddBoolOption(tostring(id), default == "Block", "BlockMovies")
		-- mod:AddButton
	end
end


--------------------------
--  Boss Mod Prototype  --
--------------------------
local bossModPrototype = {}


----------------------------
--  Boss Mod Constructor  --
----------------------------
do
	local modsById = setmetatable({}, {__mode = "v"})
	local mt = {__index = bossModPrototype}

	function DBM:NewMod(name, modId, modSubTab, instanceId, encounterId)
		if type(name) == "number" then
			encounterId = name
		end
		name = tostring(name) -- the name should never be a number of something as it confuses sync handlers that just receive some string and try to get the mod from it
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
				categorySort = {},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				countdowns = {},
				modId = modId,
				instanceId = instanceId,
				encounterId = encounterId,
				revision = 0,
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

		if obj.localization.general.name == "name" then
			if encounterId then
				local t = EJ_GetEncounterInfo(encounterId)
				obj.localization.general.name = string.split(",", t)
			else
				obj.localization.general.name = name
			end
		end
		table.insert(self.Mods, obj)
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
bossModPrototype.UnregisterShortTermEvents = DBM.UnregisterShortTermEvents

function bossModPrototype:SetZone(...)
	if select("#", ...) == 0 then
		self.zones = {}
		if self.addon and self.addon.zone then
			for i, v in ipairs(self.addon.zone) do
				self.zones[v] = true
			end
		end
		if self.addon and self.addon.zoneId then
			for i, v in ipairs(self.addon.zoneId) do
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


function bossModPrototype:RegisterEventsInCombat(...)
	if not self.inCombatOnlyEvents then
		self.inCombatOnlyEvents = {...}
	else
		for i = 1, select("#", ...) do
			local ev = select(i, ...)
			tinsert(self.inCombatOnlyEvents, ev)
		end
	end
end

function bossModPrototype:RegisterShortTermEvents(...)
	if not self.shortTermRegisterEvents then
		self.shortTermRegisterEvents = {...}
	else
		for i = 1, select("#", ...) do
			local ev = select(i, ...)
			tinsert(self.shortTermRegisterEvents, ev)
		end
	end
	if self.shortTermRegisterEvents and not self.shortTermEventsRegistered then
		self.shortTermEventsRegistered = 1
		self:RegisterEvents(unpack(self.shortTermRegisterEvents))
	end
end

function bossModPrototype:SetCreatureID(...)
	self.creatureId = ...
	if select("#", ...) > 1 then
		self.multiMobPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiMobPullDetection = self.multiMobPullDetection
		end
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

function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	if type(func) ~= "function" then return end
	self.elapsed = 0
	self.updateInterval = interval or 0
	updateFunctions[self] = func
end

function bossModPrototype:SetRevision(revision)
	revision = tonumber(revision or "")
	if not revision then
		-- bad revision: either forgot the svn keyword or using git svn
		revision = DBM.Revision
	end
	self.revision = revision
end

function bossModPrototype:SendWhisper(msg, target)
	return not DBM.Options.DontSendBossWhispers and sendWhisper(target, chatPrefixShort..msg)
end

function bossModPrototype:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	return (guid and (tonumber(guid:sub(6, 10), 16))) or 0
end

function bossModPrototype:GetCIDFromGUID(guid)
	return (guid and (tonumber(guid:sub(6, 10), 16))) or 0
end

local bossTargetuIds = {
	"target", "focus", "boss1", "boss2", "boss3", "boss4", "boss5"
}

-- leave this function for older mods compatiblity.
function bossModPrototype:GetBossTarget(cid)
	cid = cid or self.creatureId
	local name, uid, bossuid
	for i, uId in ipairs(bossTargetuIds) do
		if self:GetUnitCreatureId(uId) == cid then
			bossuid = uId
			name = DBM:GetUnitFullName(uId.."target")
			uid = DBM:GetRaidUnitId(name) or uId.."target"--overrride target uid because uid+"target" is variable uid.
			break
		end
	end
	if name and uid and bossuid then return name, uid, bossuid end
	-- failed to detect from default uIds, scan all group members's target.
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			if self:GetUnitCreatureId("raid"..i.."target") == cid then
				bossuid = "raid"..i.."target"
				name = DBM:GetUnitFullName("raid"..i.."targettarget")
				uid = DBM:GetRaidUnitId(name) or "raid"..i.."targettarget"--overrride target uid because uid+"target" is variable uid.
				break
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			if self:GetUnitCreatureId("party"..i.."target") == cid then
				bossuid = "party"..i.."target"
				name = DBM:GetUnitFullName("party"..i.."targettarget")
				uid = DBM:GetRaidUnitId(name) or "party"..i.."targettarget"--overrride target uid because uid+"target" is variable uid.
				break
			end
		end
	end
	return name, uid, bossuid
end

local targetScanCount = 0

function bossModPrototype:BossTargetScanner(cid, returnFunc, scanInterval, scanTimes, isEnemyScan, isFinalScan)
	--Increase scan count
	targetScanCount = targetScanCount + 1
	--Set default values
	local cid = cid or self.creatureId
	local scanInterval = scanInterval or 0.05
	local scanTimes = scanTimes or 16
	local targetname, targetuid, bossuid = self:GetBossTarget(cid)
	--Do scan
	if isEnemyScan and targetname or UnitExists(targetname) then--We check target exists on player scan to prevent nil error. But on enemy scan, do not check target exists.
		if (isEnemyScan and UnitIsFriend("player", targetuid) or self:IsTanking(targetuid, bossuid)) and not isFinalScan then--On player scan, ignore tanks. On enemy scan, ignore friendly player.
			if targetScanCount < scanTimes then--Make sure no infinite loop.
				self:ScheduleMethod(scanInterval, "BossTargetScanner", cid, returnFunc, scanInterval, scanTimes, isEnemyScan)--Scan multiple times to be sure it's not on something other then tank (or friend on enemy scan).
			else--Go final scan.
				self:BossTargetScanner(cid, returnFunc, scanInterval, scanTimes, isEnemyScan, true)
			end
		else--Scan success. (or failed to detect right target.) But some spells can be used on tanks, anyway warns tank if player scan. (enemy scan block it)
			targetScanCount = 0--Reset count for later use.
			self:UnscheduleMethod("BossTargetScanner")--Unschedule all checks just to be sure none are running, we are done.
			if not (isEnemyScan and isFinalScan) then--If enemy scan, player target is always bad. So do not warn anything. Also, must filter nil value on returnFunc.
				self:ScheduleMethod(0, returnFunc, targetname, targetuid, bossuid)--Return results to warning function with all variables.
			end
		end
	else--target was nil, lets schedule a rescan here too.
		if targetScanCount < scanTimes then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(scanInterval, "BossTargetScanner", cid, returnFunc, scanInterval, scanTimes, isEnemyScan)
		end
	end
end

function bossModPrototype:GetThreatTarget(cid)
	cid = cid or self.creatureId
	local name, realm, uid
	if self:GetUnitCreatureId("target") == cid then
		if UnitDetailedThreatSituation("player", "target") == 1 then
			return "player"
		end
	elseif IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			if self:GetUnitCreatureId("raid"..i.."target") == cid then
				for x = 1, GetNumGroupMembers() do
					if UnitDetailedThreatSituation("raid"..x, "raid"..i.."target") == 1 then
						return "raid"..x
					end
				end
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			if self:GetUnitCreatureId("party"..i.."target") == cid then
				for x = 1, GetNumSubgroupMembers() do
					if UnitDetailedThreatSituation("party"..x, "party"..i.."target") == 1 then
						return "party"..x
					end
				end
			end
		end
	end
end

function bossModPrototype:Stop(cid)
	for i, v in ipairs(self.timers) do
		v:Stop()
	end
	for i, v in ipairs(self.countdowns) do
		v:Stop()
	end
	self:Unschedule()
end

bossModPrototype.GetDifficulty = DBM.GetCurrentInstanceDifficulty

function bossModPrototype:IsDifficulty(...)
	local diff = self:GetDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:SetUsedIcons(...)
	self.usedIcons = {}
	for i = 1, select("#", ...) do
		self.usedIcons[select(i, ...)] = true
	end
end

function bossModPrototype:LatencyCheck()
	return select(4, GetNetStats()) < DBM.Options.LatencyThreshold
end

-- An anti spam function to throttle spammy events (e.g. SPELL_AURA_APPLIED on all group members)
-- @param time the time to wait between two events (optional, default 2.5 seconds)
-- @param id the id to distinguish different events (optional, only necessary if your mod keeps track of two different spam events at the same time)
function bossModPrototype:AntiSpam(time, id)
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

--Simple talent checker.
--It checks for key skills in spellbook, without having to do in dept talent point checks.

function bossModPrototype:IsMelee()
	return class == "ROGUE"
	or class == "WARRIOR"
	or class == "DEATHKNIGHT"
	or class == "MONK"--Iffy slope, monk healers will be ranged and melee. :\
	or (class == "PALADIN" and (GetSpecialization() ~= 1))
    or (class == "SHAMAN" and (GetSpecialization() == 2))
	or (class == "DRUID" and (GetSpecialization() == 2 or GetSpecialization() == 3))
end

function bossModPrototype:IsMeleeDps()
	return class == "ROGUE"
	or (class == "WARRIOR" and (GetSpecialization() ~= 3))
	or (class == "DEATHKNIGHT" and (GetSpecialization() ~= 1))
	or (class == "MONK" and (GetSpecialization() == 3))
	or (class == "PALADIN" and (GetSpecialization() == 3))
    or (class == "SHAMAN" and (GetSpecialization() == 2))
	or (class == "DRUID" and (GetSpecialization() == 2))
end

function bossModPrototype:IsRanged()--Including healer
	return class == "MAGE"
	or class == "HUNTER"
	or class == "WARLOCK"
	or class == "PRIEST"
	or (class == "PALADIN" and (GetSpecialization() == 1))
    or (class == "SHAMAN" and (GetSpecialization() ~= 2))
	or (class == "DRUID" and (GetSpecialization() == 1 or GetSpecialization() == 4))
	or (class == "MONK" and (GetSpecialization() == 2))--Iffy slope, monk healers will be ranged and melee. :\
end

function bossModPrototype:IsRangedDps()
	return class == "MAGE"
	or class == "HUNTER"
	or class == "WARLOCK"
	or (class == "PRIEST" and (GetSpecialization() == 3))
    or (class == "SHAMAN" and (GetSpecialization() == 1))
	or (class == "DRUID" and (GetSpecialization() == 1))
end

function bossModPrototype:IsManaUser()--Similar to ranged, but includes all paladins and all shaman
	return class == "MAGE"
	or class == "WARLOCK"
	or class == "PRIEST"
	or class == "PALADIN"
    or class == "SHAMAN"
	or (class == "DRUID" and (GetSpecialization() == 1 or GetSpecialization() == 4))
	or (class == "MONK" and (GetSpecialization() == 2))
end

function bossModPrototype:IsDps()--For features that simply should only be on for dps and not healers or tanks and without me having to use "not is heal or not is tank" rules :)
	return class == "WARLOCK"
	or class == "MAGE"
	or class == "HUNTER"
	or class == "ROGUE"
	or (class == "WARRIOR" and (GetSpecialization() ~= 3))
	or (class == "DEATHKNIGHT" and (GetSpecialization() ~= 1))
	or (class == "PALADIN" and (GetSpecialization() == 3))
	or (class == "DRUID" and (GetSpecialization() == 1 or GetSpecialization() == 2))
	or (class == "SHAMAN" and (GetSpecialization() ~= 3))
   	or (class == "PRIEST" and (GetSpecialization() == 3))
	or (class == "MONK" and (GetSpecialization() == 3))
end

function bossModPrototype:IsTank()
	return (class == "WARRIOR" and (GetSpecialization() == 3))
	or (class == "DEATHKNIGHT" and (GetSpecialization() == 1))
	or (class == "PALADIN" and (GetSpecialization() == 2))
	or (class == "DRUID" and (GetSpecialization() == 3))
	or (class == "MONK" and (GetSpecialization() == 1))
end

function bossModPrototype:IsTanking(unit, boss)
	if not unit then return false end 
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists(boss.."target") and UnitDetailedThreatSituation(unit, boss) then
		return true
	end
	return false
end

function bossModPrototype:IsHealer()
	return (class == "PALADIN" and (GetSpecialization() == 1))
	or (class == "SHAMAN" and (GetSpecialization() == 3))
	or (class == "DRUID" and (GetSpecialization() == 4))
	or (class == "PRIEST" and (GetSpecialization() ~= 3))
	or (class == "MONK" and (GetSpecialization() == 2))
end

--These don't matter since they don't check talents
function bossModPrototype:IsPhysical()
	return self:IsMelee() or class == "HUNTER"
end

function bossModPrototype:CanRemoveEnrage()
	return class == "HUNTER" or class == "ROGUE" or class == "DRUID"
end
-------------------------
--  Boss Health Frame  --
-------------------------
function bossModPrototype:SetBossHealthInfo(...)
	self.bossHealthInfo = {...}
end


-----------------------
--  Announce Object  --
-----------------------
do
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
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			local text = ("%s%s%s|r%s"):format(
				(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
				colorCode,
				pformat(self.text, ...),
				(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
			)
			if not cachedColorFunctions[self.color] then
				local color = self.color -- upvalue for the function to colorize names, accessing self in the colorize closure is not safe as the color of the announce object might change (it would also prevent the announce from being garbage-collected but announce objects are never destroyed)
				cachedColorFunctions[color] = function(cap)
					cap = cap:sub(2, -2)
					local name = cap
					if DBM.Options.StripServerName then
						cap = cap:gsub("%-.*$", "")
					end
					if DBM:GetRaidClass(name) then
						local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)] or color
						cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
					end
					return cap
				end
			end
			text = text:gsub(">.-<", cachedColorFunctions[self.color])
			RaidNotice_AddMessage(RaidWarningFrame, text, ChatTypeInfo["RAID_WARNING"]) -- the color option doesn't work (at least it didn't work during the WotLK beta...todo: check this (this would save some of the WTFs))
			if DBM.Options.ShowWarningsInChat then
				text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size TODO: is this still true as of cataclysm?
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
					PlaySoundFile(DBM.Options.RaidWarningSound, "Master")--4.0.6 arg to use master sound channel, re-enableing sound playback when effects are turned off.
				else
					PlaySoundFile(DBM.Options.RaidWarningSound)--not cata so we don't use the channel arg to maintain CN wow compatability.
				end
			end
		end
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
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				sound = not noSound,
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(optionName, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = text
			self:AddBoolOption(text, optionDefault, "announce")
		end
		table.insert(self.announces, obj)
		return obj
	end

	-- new constructor (auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, noSound)
		if not spellId then
			error("newAnnounce: you must provide spellId", 2)
			return
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
			local spellHaste = select(7, GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			local timer = (select(7, GetSpellInfo(spellId)) or 1000) / spellHaste
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(preWarnTime or 5))
			end
		elseif announceType == "phase" or announceType == "prephase" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
		else
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
				sound = not noSound,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(optionName, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = "Announce"..unparsedId..announceType
			self:AddBoolOption("Announce"..unparsedId..announceType, optionDefault, "announce")
			self.localization.options["Announce"..unparsedId..announceType] = DBM_CORE_AUTO_ANNOUNCE_OPTIONS[announceType]:format(unparsedId)
		end
		table.insert(self.announces, obj)
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

	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName)
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime)
	end

	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 1, ...)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName)
		return newAnnounce(self, "prewarn", spellId, color or 1, icon, optionDefault, optionName, nil, time)
	end

	function bossModPrototype:NewPhaseAnnounce(phase, color, icon, ...)
		return newAnnounce(self, "phase", phase, color or 1, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

	function bossModPrototype:NewPrePhaseAnnounce(phase, color, icon, ...)
		return newAnnounce(self, "prephase", phase, color or 1, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

end

--------------------
--  Sound Object  --
--------------------
do
	local soundPrototype = {}
	local mt = { __index = soundPrototype }
	function bossModPrototype:NewSound(spellId, optionName, optionDefault)
		if not spellId and not optionName then
			error("NewSound: you must provide either spellId or optionName", 2)
			return
		end
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(optionName, optionDefault, "misc")
		elseif not (optionName == false) then
			obj.option = "Sound"..spellId
			self:AddBoolOption("Sound"..spellId, optionDefault, "misc")
			self.localization.options["Sound"..spellId] = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(spellId)
		end
		return obj
	end
	bossModPrototype.NewRunAwaySound = bossModPrototype.NewSound

	function soundPrototype:Play(file)
		if not self.option or self.mod.Options[self.option] then
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav", "Master")
			else
				PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
			end
		end
	end

	function soundPrototype:Schedule(t, ...)
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype:Cancel(...)
		return unschedule(self.Play, self.mod, self, ...)
	end
end

------------------------
--  Countdown object  --
------------------------
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
			if DBM.Options.ShowCountdownText and not self.textDisabled then
				if timer >= count then 
					DBM:Schedule(timer-count, showCountdown, count)
				else
					DBM:Schedule(timer%1, showCountdown, floor(timer))
				end
			end
			if DBM.Options.CountdownVoice == "None" then return end
			if DBM.Options.CountdownVoice == "Mosh" then
				for i = count, 1, -1 do
					if i <= 5 then
						self.sound5:Schedule(timer-i, "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\"..i..".ogg")
					end
				end
			else--When/if more voices get added we can tweak it to use elseif rules, but for now else works smarter cause then ANY value will return to a default voice.
				for i = count, 1, -1 do
					self.sound5:Schedule(timer-i, "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica_S\\"..i..".ogg")
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
		self.sound1:Cancel()
		self.sound2:Cancel()
		self.sound3:Cancel()
		self.sound4:Cancel()
		self.sound5:Cancel()
	end
	countdownProtoType.Stop = countdownProtoType.Cancel

	function bossModPrototype:NewCountdown(timer, spellId, optionDefault, optionName, count, textDisabled)
		if not spellId and not optionName then
			error("NewCountdown: you must provide either spellId or optionName", 2)
			return
		end
		local sound5 = self:NewSound(5, false, true)
		local sound4 = self:NewSound(4, false, true)
		local sound3 = self:NewSound(3, false, true)
		local sound2 = self:NewSound(2, false, true)
		local sound1 = self:NewSound(1, false, true)
		timer = timer or 10
		count = count or 5
		spellId = spellId or 39505
		local obj = setmetatable(
			{
				id = optionName or "Countdown"..spellId,
				sound1 = sound1,
				sound2 = sound2,
				sound3 = sound3,
				sound4 = sound4,
				sound5 = sound5,
				timer = timer,
				count = count,
				textDisabled = textDisabled,
				mod = self
			},
			mt
		)
		if optionName then
			obj.option = obj.id
			self:AddBoolOption(optionName, optionDefault, "misc")
		elseif not (optionName == false) then
			obj.option = obj.id
			self:AddBoolOption(obj.id, optionDefault, "misc")
			self.localization.options[obj.id] = DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(spellId)
		end
		table.insert(self.countdowns, obj)
		return obj
	end
end

------------------------
--  Countout object  --
------------------------
do
	local countoutProtoType = {}
	local mt = {__index = countoutProtoType}

	function countoutProtoType:Start(timer)
		if not self.option or self.mod.Options[self.option] then
			timer = timer or self.timer or 10
			timer = timer <= 5 and self.timer or timer
			if DBM.Options.CountdownVoice == "None" then return end
			if DBM.Options.CountdownVoice == "Mosh" and timer == 5 then--Don't have 6-10 for him yet.
				for i = 1, timer do
					self.sound5:Schedule(i, "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\"..i..".ogg")
				end
			else--When/if more voices get added we can tweak it to use elseif rules, but for now else works smarter cause then ANY value will return to a default voice.
				--Ugly as hel way to do it but i coudln't think of a different way to do it accurately
				for i = 1, timer do
					self.sound5:Schedule(i, "Interface\\AddOns\\DBM-Core\\Sounds\\Corsica_S\\"..i..".ogg")
				end
			end
		end
	end

	function countoutProtoType:Schedule(t)
		return schedule(t, self.Start, self.mod, self)
	end

	function countoutProtoType:Cancel()
		self.mod:Unschedule(self.Start, self)
		self.sound1:Cancel()
		self.sound2:Cancel()
		self.sound3:Cancel()
		self.sound4:Cancel()
		self.sound5:Cancel()
	end
	countoutProtoType.Stop = countoutProtoType.Cancel

	function bossModPrototype:NewCountout(timer, spellId, optionDefault, optionName)
		if not spellId and not optionName then
			error("NewCountout: you must provide either spellId or optionName", 2)
			return
		end
		local sound5 = self:NewSound(5, false, true)
		local sound4 = self:NewSound(4, false, true)
		local sound3 = self:NewSound(3, false, true)
		local sound2 = self:NewSound(2, false, true)
		local sound1 = self:NewSound(1, false, true)
		timer = timer or 10
		spellId = spellId or 39505
		local obj = setmetatable(
			{
				sound1 = sound1,
				sound2 = sound2,
				sound3 = sound3,
				sound4 = sound4,
				sound5 = sound5,
				timer = timer,
				mod = self
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(optionName, optionDefault, "misc")
		elseif not (optionName == false) then
			obj.option = "Countout"..spellId
			self:AddBoolOption("Countout"..spellId, optionDefault, "misc")
			self.localization.options["Countout"..spellId] = DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT:format(spellId)
		end
		return obj
	end
end

--------------------
--  Yell Object  --
--------------------
do
	local yellPrototype = {}
	local mt = { __index = yellPrototype }
	function bossModPrototype:NewYell(spellId, yellText, optionDefault, optionName, chatType)
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
			return
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
			self:AddBoolOption(optionName, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = "Yell"..(yellText or spellId)
			self:AddBoolOption("Yell"..(yellText or spellId), optionDefault, "announce")
			self.localization.options["Yell"..(yellText or spellId)] = DBM_CORE_AUTO_YELL_OPTION_TEXT:format(spellId)
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
	local frame = CreateFrame("Frame", nil, UIParent)
	local font = frame:CreateFontString(nil, "OVERLAY", "ZoneTextFont")
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
	frame:Hide()
	font:SetWidth(1024)
	font:SetHeight(0)
	font:SetPoint("CENTER", 0, 0)

	local moving
	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	function DBM:UpdateSpecialWarningOptions()
		frame:ClearAllPoints()
		frame:SetPoint(DBM.Options.SpecialWarningPoint, UIParent, DBM.Options.SpecialWarningPoint, DBM.Options.SpecialWarningX, DBM.Options.SpecialWarningY)
		font:SetFont(DBM.Options.SpecialWarningFont, DBM.Options.SpecialWarningFontSize, "THICKOUTLINE")
		font:SetTextColor(unpack(DBM.Options.SpecialWarningFontColor))
	end

	local shakeFrame = CreateFrame("Frame")
	shakeFrame:SetScript("OnUpdate", function(self, elapsed)
		self.timer = self.timer - elapsed
	end)
	shakeFrame:Hide()

	frame:SetScript("OnUpdate", function(self, elapsed)
		self.timer = self.timer - elapsed
		if self.timer >= 3 and self.timer <= 4 then
			if not self.healthFrameHidden then
				LowHealthFrame:SetAlpha(self.timer - 3)
			end
		elseif self.timer <= 2 then
			frame:SetAlpha(self.timer/2)
		elseif self.timer <= 0 then
			if not self.healthFrameHidden then
				LowHealthFrame:Hide()
			end
			frame:Hide()
		end
	end)

	function specialWarningPrototype:Show(...)
		if DBM.Options.ShowSpecialWarnings and (not self.option or self.mod.Options[self.option]) and not moving and frame then
			local msg = pformat(self.text, ...)
			local stripName = function(cap)
				cap = cap:sub(2, -2)
				if DBM.Options.StripServerName then
					cap = cap:gsub("%-.*$", "")
				end
				return cap
			end
			msg = msg:gsub(">.-<", stripName)
			font:SetText(msg)
			if DBM.Options.ShowLHFrame and not UnitIsDeadOrGhost("player") then
				LowHealthFrame:Show()
				LowHealthFrame:SetAlpha(1)
				frame.healthFrameHidden = nil
			else
				frame.healthFrameHidden = true -- to prevent bugs in the case that this option is changed while the flash effect is active (which is not that unlikely as there is a test button in the gui...)
			end
			frame:Show()
			frame:SetAlpha(1)
			frame.timer = 5
			if self.sound then
				if self.runSound == true then self.runSound = 2 end--Hack to make old mods using "true" to be 2 instead so compatability isn't broken.
				if DBM.Options.UseMasterVolume then
					PlaySoundFile(self.runSound == 2 and DBM.Options.SpecialWarningSound2 or self.runSound == 3 and DBM.Options.SpecialWarningSound3 or DBM.Options.SpecialWarningSound, "Master")
				else
					PlaySoundFile(self.runSound == 2 and DBM.Options.SpecialWarningSound2 or self.runSound == 3 and DBM.Options.SpecialWarningSound3 or DBM.Options.SpecialWarningSound)
				end
			end
		end
	end

	function specialWarningPrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Cancel(t, ...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, noSound, runSound)
		if not text then
			error("NewSpecialWarning: you must provide special warning text", 2)
			return
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				mod = self,
				sound = not noSound,
				runSound = runSound,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(optionName, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = text
			self:AddBoolOption(text, optionDefault, "announce")
		end
		table.insert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, noSound, runSound)
		if not spellId then
			error("newSpecialWarning: you must provide spellId", 2)
			return
		end
		local spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellName = EJ_GetSectionInfo(string.sub(spellId, 3)) or DBM_CORE_UNKNOWN
		else
			spellName = GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		end
		local text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				announceType = announceType,
				mod = self,
				sound = not noSound,
				runSound = runSound,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(optionName, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = "SpecWarn"..spellId..announceType
			self:AddBoolOption("SpecWarn"..spellId..announceType, optionDefault, "announce")
			if announceType == "stack" then
				self.localization.options["SpecWarn"..spellId..announceType] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
			else
				self.localization.options["SpecWarn"..spellId..announceType] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
			end
		end
		table.insert(self.specwarns, obj)
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

	function bossModPrototype:NewSpecialWarningYou(text, optionDefault, ...)
		return newSpecialWarning(self, "you", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTarget(text, optionDefault, ...)
		return newSpecialWarning(self, "target", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningClose(text, optionDefault, ...)
		return newSpecialWarning(self, "close", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMove(text, optionDefault, ...)
		return newSpecialWarning(self, "move", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningRun(text, optionDefault, ...)
		return newSpecialWarning(self, "run", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCast(text, optionDefault, ...)
		return newSpecialWarning(self, "cast", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCount(text, optionDefault, ...)
		return newSpecialWarning(self, "count", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStack(text, optionDefault, stacks, ...)
		return newSpecialWarning(self, "stack", text, stacks, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSwitch(text, optionDefault, ...)
		return newSpecialWarning(self, "switch", text, nil, optionDefault, ...)
	end

	do
		local anchorFrame
		local function moveEnd()
			moving = false
			anchorFrame:Hide()
			frame.timer = 1.5 -- fade out
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
				anchorFrame:SetPoint("CENTER", 0, -32)
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
					DBM.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					DBM.Options.SpecialWarningPoint = point
					DBM.Options.SpecialWarningX = xOfs
					DBM.Options.SpecialWarningY = yOfs
					self:Schedule(15, moveEnd)
					DBM.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd()
			else
				moving = true
				anchorFrame:Show()
				self:Schedule(15, moveEnd)
				DBM.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				font:SetText(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
				frame.timer = math.huge
			end
		end
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(text)
		if moving then
			return
		end
		font:SetText(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
		frame:Show()
		frame:SetAlpha(1)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(3, testWarningEnd)
		frame.timer = 3
	end
end


--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}

	function timerPrototype:Start(timer, ...)
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		if not self.option or self.mod.Options[self.option] then
			local timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
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
			local stripName = function(cap)
				cap = cap:sub(2, -2)
				if DBM.Options.StripServerName then
					cap = cap:gsub("%-.*$", "")
				end
				return cap
			end
			msg = msg:gsub(">.-<", stripName)
			bar:SetText(msg)
			table.insert(self.startedTimers, id)
			self.mod:Unschedule(removeEntry, self.startedTimers, id)
			self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
			return bar
		else
			return false, "disabled"
		end
	end
	timerPrototype.Show = timerPrototype.Start

	function timerPrototype:Schedule(t, ...)
		return schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(t, ...)
		return unschedule(self.Start, self.mod, self, ...)
	end

	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				DBM.Bars:CancelBar(self.startedTimers[i])
				self.startedTimers[i] = nil
			end
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					DBM.Bars:CancelBar(id)
					table.remove(self.startedTimers, i)
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
			return bar:SetIcon((type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode")
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
		local icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode"
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
		table.insert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- todo: disable the timer if the player already has the achievement and when the ACHIEVEMENT_EARNED event is fired
	-- problem: heroic/normal achievements :[
	-- local achievementTimers = {}
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, texture, r, g, b)
		-- new argument timerText is optional (usually only required for achievement timers as they have looooong names)
		if type(timerText) == "boolean" or type(optionDefault) == "string" then -- check if the argument was skipped
			return newTimer(self, timerType, timer, spellId, nil, timerText, optionDefault, optionName, texture, r, g, b)
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
		else
			if type(spellId) == "string" and spellId:match("ej%d+") then
				spellName = EJ_GetSectionInfo(string.sub(spellId, 3)) or ""
			else
				spellName = GetSpellInfo(spellId or 0)
			end
			if spellName then
				icon = type(texture) == "number" and select(3, GetSpellInfo(texture)) or texture or type(spellId) == "string" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and select(3, GetSpellInfo(spellId)))
			else
				icon = nil
			end
		end
		spellName = spellName or tostring(spellId)
		local id = "Timer"..(spellId or 0)..self.id..#self.timers
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
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName)
		table.insert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if timerType == "achievement" then
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(GetAchievementLink(spellId):gsub("%[(.+)%]", "%1"))
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
		if timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(7, GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(7, GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
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


---------------------
--  Enrage Object  --
---------------------
do
	local enragePrototype = {}
	local mt = {__index = enragePrototype}

	function enragePrototype:Start(timer)
		timer = timer or self.timer or 600
		timer = timer <= 0 and self.timer - timer or timer
		self.bar:SetTimer(timer)
		self.bar:Start()
		if timer > 660 then self.warning1:Schedule(timer - 600, 10, DBM_CORE_MIN) end
		if timer > 300 then self.warning1:Schedule(timer - 300, 5, DBM_CORE_MIN) end
		if timer > 180 then self.warning2:Schedule(timer - 180, 3, DBM_CORE_MIN) end
		if timer > 60 then self.warning2:Schedule(timer - 60, 1, DBM_CORE_MIN) end
		if timer > 30 then self.warning2:Schedule(timer - 30, 30, DBM_CORE_SEC) end
		if timer > 10 then self.warning2:Schedule(timer - 10, 10, DBM_CORE_SEC) end
	end

	function enragePrototype:Schedule(t)
		return self.owner:Schedule(t, self.Start, self)
	end

	function enragePrototype:Cancel()
		self.owner:Unschedule(self.Start, self)
		self.warning1:Cancel()
		self.warning2:Cancel()
		self.bar:Stop()
	end
	enragePrototype.Stop = enragePrototype.Cancel

	function bossModPrototype:NewBerserkTimer(timer, text, barText, barIcon)
		timer = timer or 600
		local warning1 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
		local warning2 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)
		local bar = self:NewTimer(timer or 600, barText or DBM_CORE_GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk")
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


--------------------------
--  Shield Health Bars  --
--------------------------

do
	local frame = CreateFrame("Frame") -- frame for CLEU events, we don't want to run all *_MISSED events through the whole DBM event system...
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	local activeShields = {}
	local shieldsByGuid = {}

	local function getShieldHPFunc(shieldInfo)
		return function()
			return math.max(1, math.floor(shieldInfo.absorbRemaining / shieldInfo.maxAbsorb * 100))
		end
	end

	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
			local shieldInfo = destGUID and shieldsByGuid[destGUID]
			if shieldInfo then
				local absorbed
				if subEvent == "SWING_MISSED" then
					absorbed = select(3, ...)
				elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then
					absorbed = select(6, ...)
				end
				if absorbed then
					shieldInfo.absorbRemaining = shieldInfo.absorbRemaining - absorbed
				end
			end
	end)

	function bossModPrototype:ShowShieldHealthBar(guid, spellId, absorb)
		self:RemoveShieldHealthBar(guid, spellId)
		local obj = {
			mod = self.id,
			spellId = spellId,
			guid = guid,
			absorbRemaining = absorb,
			maxAbsorb = absorb,
		}
		obj.func = getShieldHPFunc(obj)
		activeShields[#activeShields + 1] = obj
		shieldsByGuid[guid] = obj
		DBM.BossHealth:AddBoss(obj.func, GetSpellInfo(spellId) or spellId)
	end

	-- removes shield health bars for a specific guid and spellId (optional)
	function bossModPrototype:RemoveShieldHealthBar(guid, spellId)
		shieldsByGuid[guid] = nil
		for i = #activeShields, 1, -1 do
			if activeShields[i].guid == guid and activeShields[i].mod == self.id and (not spellId or activeShields[i].spellId == spellId) then
				DBM.BossHealth.RemoveBoss(activeShields[i].func)
				table.remove(activeShields, i)
			end
		end
	end

	-- removes all shield bars of a boss mod
	function bossModPrototype:RemoveAllShieldHealthBars()
		for i = #activeShields, 1, -1 do
			if activeShields[i].mod == self.id then
				DBM.BossHealth.RemoveBoss(activeShields[i].func)
				shieldsByGuid[activeShields[i].guid] = nil
				table.remove(activeShields, i)
			end
		end
	end
end


---------------
--  Options  --
---------------
function bossModPrototype:AddBoolOption(name, default, cat, func)
	cat = cat or "misc"
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, cat)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for i, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[i] = nil
			removeEntry(self.categorySort, i)
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

function bossModPrototype:AddSliderOption(name, minValue, maxValue, valueStep, default, cat, func)
	cat = cat or "misc"
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
		table.insert(self.optionCategories[cat], DBM_OPTION_SPACER)
	end
end

function bossModPrototype:AddAnnounceSpacer()
	return self:AddOptionSpacer("announce")
end

function bossModPrototype:AddTimerSpacer()
	return self:AddOptionSpacer("timer")
end


function bossModPrototype:SetOptionCategory(name, cat)
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
		table.insert(self.categorySort, cat)
	end
	table.insert(self.optionCategories[cat], name)
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
		name = self.localization.general.name or self.id,
		msgs = (cType ~= "combat") and {...},
		mod = self
	}
	if self.multiMobPullDetection then
		info.multiMobPullDetection = self.multiMobPullDetection
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
		table.insert(combatInfo[v], info)
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

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.noCombatInVehicle = not flag
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
function bossModPrototype:SetReCombatTime(t)-- bad wording: ReCombat?
	self.reCombatTime = t
end

-- updated for status whisper.
function bossModPrototype:SetMainBossID(...)
	self.mainBossId = ...
end

function bossModPrototype:GetBossHPString(cId)
	for i = 1, 5 do
		local guid = UnitGUID("boss"..i)
		if guid and tonumber(guid:sub(6, 10), 16) == cId then
			return math.floor(UnitHealth("boss"..i) / UnitHealthMax("boss"..i) * 100) .. "%"
		end
	end
	local idType = (IsInRaid() and "raid") or "party"
	for i = 0, GetNumGroupMembers() do
		local unitId = ((i == 0) and "target") or idType..i.."target"
		local guid = UnitGUID(unitId)
		if guid and (tonumber(guid:sub(6, 10), 16)) == cId then
			return math.floor(UnitHealth(unitId)/UnitHealthMax(unitId) * 100).."%"
		end
	end
	return DBM_CORE_UNKNOWN
end

function bossModPrototype:GetHP()
	return self:GetBossHPString(self.mainBossId or (self.combatInfo and self.combatInfo.mob) or self.creatureId)
end

function bossModPrototype:IsWipe()
	local wipe = true
	local uId = (IsInRaid() and "raid") or "party"
	for i = 0, GetNumGroupMembers() do
		local id = (i == 0 and "player") or uId..i
		if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
			wipe = false
			break
		end
	end
	return wipe
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
	if not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 2.5 then
		self:ReceiveSync(event, nil, self.revision or 0, tostringall(...))
		sendSync("M", str)
	end
end

function bossModPrototype:ReceiveSync(event, sender, revision, ...)
	local spamId = self.id .. event .. strjoin("\t", ...)
	local time = GetTime()
	if (not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 2.5) and self.OnSync and (not (self.blockSyncs and sender)) and (not sender or (not self.minSyncRevision or revision >= self.minSyncRevision)) then
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

function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = revision
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
function bossModPrototype:SetIcon(target, icon, timer)
	if DBM.Options.DontSetIcons or not enableIcons or (DBM:GetRaidRank(playerName) == 0 and IsInGroup()) then -- Can set icon in solo raid.
		return
	end
	icon = icon and icon >= 0 and icon <= 8 and icon or 8
	local uId = DBM:GetRaidUnitId(target)
	if not uId then uId = target end
	local oldIcon = self:GetIcon(uId) or 0
	SetRaidTarget(uId, icon)
	self:UnscheduleMethod("SetIcon", target)
	if timer then
		self:ScheduleMethod(timer, "RemoveIcon", target)
		if oldIcon then
			self:ScheduleMethod(timer + 1, "SetIcon", target, oldIcon)
		end
	end
end

function bossModPrototype:GetIcon(uId)
	return GetRaidTargetIndex(uId)
end

function bossModPrototype:RemoveIcon(target, timer)
	return self:SetIcon(target, 0, timer)
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
			timer		= DBM_CORE_OPTION_CATEGORY_TIMERS,
			announce	= DBM_CORE_OPTION_CATEGORY_WARNINGS,
			misc		= DBM_CORE_OPTION_CATEGORY_MISC
		}, returnKey)
	}
	local defaultTimerLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_GENERIC_TIMER_BERSERK,
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
			HealthFrame = DBM_CORE_OPTION_HEALTH_FRAME,
			SpeedKillTimer = DBM_SPEED_KILL_TIMER_OPTION
		}, returnKey)
	}
	local defaultMiscLocalization = {
		__index = function(t, k)
			return t.misc.general[k] or t.misc.options[k] or t.misc.warnings[k] or t.misc.timers[k] or t.misc.cats[k] or k
		end
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
		obj.miscStrings.misc = obj
		setmetatable(obj, mt)
		modLocalizations[name] = obj
		return obj
	end

	function DBM:GetModLocalization(name)
		name = tostring(name)
		return modLocalizations[name] or self:CreateModLocalization(name)
	end
end
