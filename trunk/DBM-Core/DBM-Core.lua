-- *********************************************************
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu				http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * zhCN: Diablohu					http://wow.gamespot.com.cn
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * koKR: BlueNyx					bluenyx@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--
-- Special thanks to:
--    * Arta
--    * Omegal @ US-Whisperwind (continuing mod support for 3.2+)
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
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
	Revision = ("$Revision$"):sub(12, -3),
	Version = "4.70",
	DisplayVersion = "4.71 alpha", -- the string that is shown as version
	ReleaseRevision = 4833 -- the revision of the latest stable version that is available (for /dbm ver2)
}

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
	RaidWarningPosition = {
		Point = "TOP",
		X = 0,
		Y = -185,
	},
	StatusEnabled = true,
	AutoRespond = true,
	Enabled = true,
	ShowWarningsInChat = true,
	ShowFakedRaidWarnings = false,
	WarningIconLeft = true,
	WarningIconRight = true,
	HideBossEmoteFrame = false,
	SpamBlockRaidWarning = true,
	SpamBlockBossWhispers = false,
	ShowMinimapButton = true,
	FixCLEUOnCombatStart = false,
	ArchaeologyHumor = true,
	SetCurrentMapOnPull = true,
	BlockVersionUpdatePopup = true,
	ShowSpecialWarnings = true,
	AlwaysShowHealthFrame = false,
	ShowBigBrotherOnCombatStart = false,
	RangeFramePoint = "CENTER",
	RangeFrameX = 50,
	RangeFrameY = -50,
	RangeFrameSound1 = "none",
	RangeFrameSound2 = "none",
	RangeFrameLocked = false,
	InfoFramePoint = "CENTER",
	InfoFrameX = 75,
	InfoFrameY = -75,
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
	DontSendBossAnnounces = false,
	DontSendBossWhispers = false,
	DontSetIcons = false,
	LatencyThreshold = 200,
	BigBrotherAnnounceToRaid = false,
	SettingsMessageShown = false,
	AlwaysShowSpeedKillTimer = true,
--	HelpMessageShown = false,
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
local _, class = UnitClass("player")
local is_cata = select(4, _G.GetBuildInfo()) >= 40000--4.0 PTR or Beta
local is_china = select(4, _G.GetBuildInfo()) == 30200--Chinese wow (3.2.2) No one else should be on 3.2.x, screw private servers.
local GetCurrentMapID
local LastZoneText
local LastZoneMapID
if is_china then
	GetCurrentMapID = function() return GetCurrentMapAreaID() + 1 end -- US 4.0.1 changed all area ids by -1. So we add it back to continue supporting CN wow until they get same change.
else
	GetCurrentMapID = GetCurrentMapAreaID
end

local enableIcons = true -- set to false when a raid leader or a promoted player has a newer version of DBM

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod like DBM-Battlegrounds (replaced by DBM-PvP)) boss mods, these mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM-Battlegrounds", --replaced by DBM-PvP
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

-- automatically sends an addon message to the appropriate channel (BATTLEGROUND, RAID or PARTY)
local function sendSync(prefix, msg)
	local zoneType = select(2, IsInInstance())
	if zoneType == "pvp" or zoneType == "arena" then
		SendAddonMessage(prefix, msg, "BATTLEGROUND")
	elseif GetRealNumRaidMembers() > 0 then
		SendAddonMessage(prefix, msg, "RAID")
	elseif GetRealNumPartyMembers() > 0 then
		SendAddonMessage(prefix, msg, "PARTY")
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
	
	function argsMT.__index:IsSpellID(a1, a2, a3, a4)
		local v = self.spellId
		return v == a1 or v == a2 or v == a3 or v == a4
	end
	
	function argsMT.__index:IsPlayer()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end
	
	function argsMT.__index:IsPlayerSource()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bit.band(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
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
		return tonumber(self.sourceGUID:sub(7, 10), 16) or 0
	end
	
	function argsMT.__index:GetDestCreatureID()
		return tonumber(self.destGUID:sub(7, 10), 16) or 0
	end
	
	local function handleEvent(self, event, ...)
		if not registeredEvents[event] or DBM.Options and not DBM.Options.Enabled then return end
		for i, v in ipairs(registeredEvents[event]) do
			if type(v[event]) == "function" and (not v.zones or checkEntry(v.zones, LastZoneText) or checkEntry(v.zones, LastZoneMapID)) and (not v.Options or v.Options.Enabled) then
				v[event](v, ...)
			end
		end
	end

	function DBM:RegisterEvents(...)
		for i = 1, select("#", ...) do
			local ev = select(i, ...)
			registeredEvents[ev] = registeredEvents[ev] or {}
			tinsert(registeredEvents[ev], self)
			mainFrame:RegisterEvent(ev)
		end
	end
	
	function DBM:UnregisterAllEvents()
		for i, v in pairs(registeredEvents) do
			for i = #v, 1 do
				if v[i] == self then
					tremove(v, i)
				end
			end
			if #v == 0 then
				registeredEvents[i] = nil
				mainFrame:UnregisterEvent(i)
			end
		end
	end

	DBM:RegisterEvents("ADDON_LOADED")

	function DBM:FilterRaidBossEmote(msg, ...)
		return handleEvent(nil, "CHAT_MSG_RAID_BOSS_EMOTE_FILTERED", msg:gsub("\124c%x+(.-)\124r", "%1"), ...)
	end

	function DBM:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		if not registeredEvents[event] then return end
		twipe(args)
		args.timestamp = timestamp
		args.event = event
		args.sourceGUID = sourceGUID
		args.sourceName = sourceName
		args.sourceFlags = sourceFlags
		args.destGUID = destGUID
		args.destName = destName
		args.destFlags = destFlags
		-- taken from Blizzard_CombatLog.lua
		if event == "SWING_DAMAGE" then
			args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(1, ...)
		elseif event == "SWING_MISSED" then
			args.spellName = ACTION_SWING
			args.missType = select(1, ...)
		elseif event:sub(1, 5) == "RANGE" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "RANGE_DAMAGE" then
				args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "RANGE_MISSED" then
				args.missType = select(4, ...)
			end
		elseif event:sub(1, 5) == "SPELL" then
			args.spellId, args.spellName, args.spellSchool = select(1, ...)
			if event == "SPELL_DAMAGE" then
				args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "SPELL_MISSED" then
				args.missType, args.amountMissed = select(4, ...)
			elseif event == "SPELL_HEAL" then
				args.amount, args.overheal, args.absorbed, args.critical = select(4, ...)
				args.school = args.spellSchool
			elseif event == "SPELL_ENERGIZE" then
				args.valueType = 2
				args.amount, args.powerType = select(4, ...)
			elseif event:sub(1, 14) == "SPELL_PERIODIC" then
				if event == "SPELL_PERIODIC_MISSED" then
					args.missType = select(4, ...)
				elseif event == "SPELL_PERIODIC_DAMAGE" then
					args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
				elseif event == "SPELL_PERIODIC_HEAL" then
					args.amount, args.overheal, args.absorbed, args.critical = select(4, ...)
					args.school = args.spellSchool
				elseif event == "SPELL_PERIODIC_DRAIN" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_LEECH" then
					args.amount, args.powerType, args.extraAmount = select(4, ...)
					args.valueType = 2
				elseif event == "SPELL_PERIODIC_ENERGIZE" then
					args.amount, args.powerType = select(4, ...)
					args.valueType = 2
				end
			elseif event == "SPELL_DRAIN" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_LEECH" then
				args.amount, args.powerType, args.extraAmount = select(4, ...)
				args.valueType = 2
			elseif event == "SPELL_INTERRUPT" then
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
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
				args.auraType, args.amount = select(4, ...)
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
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
	mainFrame:SetScript("OnEvent", handleEvent)
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
		-- only tables with <= 4 array entries are accepted as cached tables are only used for tasks with few arguments for performance reasons
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
					end
				end
			end
			-- rebuild the heap from the array in O(n)
			for i = floor((firstFree - 1) / 2), 1, -1 do
				siftDown(i)
			end
		end
	end

	mainFrame:SetScript("OnUpdate", function(self, elapsed)
		local time = GetTime()
		
		-- execute scheduled tasks
		local nextTask = getMin()
		while nextTask and nextTask.time <= time do
			deleteMin()
			nextTask.func(unpack(nextTask))
			pushCachedTable(nextTask)
			nextTask = getMin()
		end
		
		-- execute OnUpdate handlers of all modules
		for i, v in pairs(updateFunctions) do
			if i.Options.Enabled and (not i.zones or checkEntry(i.zones, LastZoneText) or checkEntry(i.zones, LastZoneMapID)) then
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
		if DBM:GetRaidRank() == 0 then
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
		if DBM:GetRaidRank() == 0 then
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			return
		end
		local timer = tonumber(cmd:sub(6)) or 5
		local timer = timer * 60
		local channel = ((GetNumRaidMembers() == 0) and "PARTY") or "RAID_WARNING"
		DBM:CreatePizzaTimer(timer, DBM_CORE_TIMER_BREAK, true)
		DBM:Unschedule(SendChatMessage)
		SendChatMessage(DBM_CORE_BREAK_START:format(timer/60), channel)
		if timer/60 > 5 then DBM:Schedule(timer - 5*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(5), channel) end
		if timer/60 > 2 then DBM:Schedule(timer - 2*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(2), channel) end
		if timer/60 > 1 then DBM:Schedule(timer - 1*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(1), channel) end
		if timer > 30 then DBM:Schedule(timer - 30, SendChatMessage, DBM_CORE_BREAK_SEC:format(30), channel) end
		DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_BREAK_OVER, channel)
	elseif cmd:sub(1, 4) == "pull" then
		if DBM:GetRaidRank() == 0 then
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		local timer = tonumber(cmd:sub(5)) or 10
		local channel = ((GetNumRaidMembers() == 0) and "PARTY") or "RAID_WARNING"
		DBM:CreatePizzaTimer(timer, DBM_CORE_TIMER_PULL, true)
		SendChatMessage(DBM_CORE_ANNOUNCE_PULL:format(timer), channel)
		if timer > 7 then DBM:Schedule(timer - 7, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(7), channel) end
		if timer > 5 then DBM:Schedule(timer - 5, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(5), channel) end
		if timer > 3 then DBM:Schedule(timer - 3, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(3), channel) end
		if timer > 2 then DBM:Schedule(timer - 2, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(2), channel) end
		if timer > 1 then DBM:Schedule(timer - 1, SendChatMessage, DBM_CORE_ANNOUNCE_PULL:format(1), channel) end
		DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_PULL_NOW, channel)
	elseif cmd:sub(1, 5) == "arrow" then
		if not DBM:IsInRaid() then
			DBM:AddMsg(DBM_ARROW_NO_RAIDGROUP)
			return false
		end
		local x, y = string.split(" ", cmd:sub(6):trim())
		xNum, yNum = tonumber(x or ""), tonumber(y or "")
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
			elseif DBM:GetRaidUnitId(DBM:Capitalize(subCmd)) ~= "none" then
				DBM.Arrow:ShowRunTo(DBM:Capitalize(subCmd))
				success = true
			end
		end
		if not success then
			for i, v in ipairs(DBM_ARROW_ERROR_USAGE) do
				DBM:AddMsg(v)
			end
		end
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
		if r and (r == 10 or r == 11 or r == 15 or r == 28 or r == 12 or r == 6 or r == 8 or r == 20) then
			DBM.RangeCheck:Show(r)
		else
			DBM.RangeCheck:Show(10)
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
				if notify and v.displayVersion ~= DBM.Version and v.revision < DBM.ReleaseRevision then
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
	--[[ hmm don't think that this is realy good, so disabled for the moment
	function DBM:ElectMaster()
		-- FIXME: Add Zonecheck for raidmates
		local elect_player = nil
		local elect_revision = tonumber(DBM.Revision)
		local electd_raidlead = false

		-- first of all, we only import the ranked mates
		for i, v in pairs(raid) do
			if v.rank >= 1 then
				table.insert(sortMe, v)
			end
		end
		table.sort(sortMe, sort)		
		if not #sortMe then return nil end	-- no raid, no election

		local p = sortMe[1]
		if p.revision >= tonumber(DBM.Revision) then	-- first we check the latest revision
			DBM:AddMsg("Newest Version seems to be Revision of "..p.name.." r"..p.revision.." - local revision = r"..DBM.Revision)
			elect_revision = tonumber(p.revision)
		end
		for i, v in ipairs(sortMe) do	-- now we kick all assists with a revision lower than the hightest
			if tonumber(v.revision) < elect_revision then
				table.remove(sortMe, i)
			end
		end		
		for i, v in ipairs(sortMe) do	-- we prefere to elect the Raidleader so we try this
			if v.rank >= 2 then
				DBM:AddMsg("Revision of "..v.name.." is "..v.revision.." and thats the RaidLeader")
				elect_player = v.name
				elect_revision = tonumber(v.revision)
				elect_raidlead = true
			end
		end
		if not elect_raidlead then
			table.sort(sortMe, function(v1, v2) return v1.name > v2.name end)	-- order by Name
			if sortMe[#sortMe] then
				p = sortMe[#sortMe]
				DBM:AddMsg("Elected "..p.name.." is assist and best name")
				elect_player = p.name
				elect_revision = tonumber(p.revision)
			end
		end

		table.wipe(sortMe)
		return elect_player, elect_revision, elect_raidlead
	end
	--]]
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
		self.Bars:CreateBar(time, text)
		if broadcast and self:GetRaidRank() >= 1 then
			sendSync("DBMv4-Pizza", ("%s\t%s"):format(time, text))
		end
		if sender then DBM:ShowPizzaInfo(text, sender) end
	end

	function DBM:AddToPizzaIgnore(name)
		ignore[name] = true
	end
end

function DBM:ShowPizzaInfo(id, sender)
	self:AddMsg(DBM_PIZZA_SYNC_INFO:format(sender, id))
end



------------------
--  Hyperlinks  --
------------------
do
	local ignore, cancel
	StaticPopupDialogs["DBM_CONFIRM_IGNORE"] = {
		text = DBM_PIZZA_CONFIRM_IGNORE,
		button1 = YES,
		button2 = NO,
		OnAccept = function(self)
			DBM:AddToPizzaIgnore(ignore)
			DBM.Bars:CancelBar(cancel)
		end,
		timeout = 0,
		hideOnEscape = 1,
	}

	DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", function(self, link, string, button, ...)
		local linkType, arg1, arg2, arg3 = strsplit(":", link)
		if linkType == "DBM" and arg1 == "cancel" then
			DBM.Bars:CancelBar(link:match("DBM:cancel:(.+):nil$"))
		elseif linkType == "DBM" and arg1 == "ignore" then
			cancel = link:match("DBM:ignore:(.+):[^%s:]+$")
			ignore = link:match(":([^:]+)$")
			StaticPopup_Show("DBM_CONFIRM_IGNORE", ignore)
		elseif linkType == "DBM" and arg1 == "update" then
			DBM:ShowUpdateReminder(arg2, arg3) -- displayVersion, revision			
		end
	end)
end

do
	local old = ItemRefTooltip.SetHyperlink -- we have to hook this function since the default ChatFrame code assumes that all links except for player and channel links are valid arguments for this function
	function ItemRefTooltip:SetHyperlink(link, ...)
		if link:match("^DBM") then return end
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


---------------------------
--  Raid/Party Handling  --
---------------------------
do
	local inRaid = false
	local playerRank = 0
	
	function DBM:RAID_ROSTER_UPDATE()
		if GetNumRaidMembers() >= 1 then
			local playerWithHigherVersionPromoted = false
			for i = 1, GetNumRaidMembers() do
				local name, rank, subgroup, _, _, fileName = GetRaidRosterInfo(i)
				if (not raid[name]) and inRaid then
					fireEvent("raidJoin", name)
				end
				raid[name] = raid[name] or {}
				raid[name].name = name
				raid[name].rank = rank
				raid[name].subgroup = subgroup
				raid[name].class = fileName
				raid[name].id = "raid"..i
				raid[name].updated = true
				if not playerWithHigherVersionPromoted and rank >= 1 and raid[name].version and raid[name].version > tonumber(DBM.Version) then
					playerWithHigherVersionPromoted = true
				end
			end
			enableIcons = not playerWithHigherVersionPromoted
			if not inRaid then
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
				self:Schedule(2, DBM.RequestTimers, DBM)
				fireEvent("raidJoin", UnitName("player"))
			end
			for i, v in pairs(raid) do
				if not v.updated then
					raid[i] = nil
					fireEvent("raidLeave", i)
				else
					v.updated = nil
				end
			end
		else
			inRaid = false
			enableIcons = true
			fireEvent("raidLeave", UnitName("player"))
		end
	end

	function DBM:PARTY_MEMBERS_CHANGED()
		if GetNumRaidMembers() > 0 then return end
		if GetNumPartyMembers() >= 1 then
			if not inRaid then
				inRaid = true
				sendSync("DBMv4-Ver", "Hi!")
				self:Schedule(2, DBM.RequestTimers, DBM)
				fireEvent("partyJoin", UnitName("player"))
			end
			for i = 0, GetNumPartyMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party"..i
				end
				local name, server = UnitName(id)
				local rank, _, fileName = UnitIsPartyLeader(id), UnitClass(id)
				if server and server ~= ""  then
					name = name.."-"..server
				end
				if (not raid[name]) and inRaid then
					fireEvent("partyJoin", name)
				end
				raid[name] = raid[name] or {}
				raid[name].name = name
				if rank then
					raid[name].rank = 2
				else
					raid[name].rank = 0
				end
				raid[name].class = fileName
				raid[name].id = id
				raid[name].updated = true
			end
			for i, v in pairs(raid) do
				if not v.updated then
					raid[i] = nil
					fireEvent("partyLeave", i)
				else
					v.updated = nil
				end
			end
		else
			inRaid = false
			enableIcons = true
		end
	end

	function DBM:IsInRaid()
		return inRaid
	end

	function DBM:GetRaidRank(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].rank) or 0
	end

	function DBM:GetRaidSubgroup(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].subgroup) or 0
	end

	function DBM:GetRaidClass(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].class) or "UNKNOWN"
	end

	function DBM:GetRaidUnitId(name)
		name = name or UnitName("player")
		return (raid[name] and raid[name].id) or "none"
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
			elseif type(v) == "table" then
				addDefaultOptions(v, t2[i])
			end
		end
	end
	
	local function setRaidWarningPositon()
		RaidWarningFrame:ClearAllPoints()
		RaidWarningFrame:SetPoint(DBM.Options.RaidWarningPosition.Point, UIParent, DBM.Options.RaidWarningPosition.Point, DBM.Options.RaidWarningPosition.X, DBM.Options.RaidWarningPosition.Y)
	end
	
	function loadOptions()
		DBM.Options = DBM_SavedOptions
		addDefaultOptions(DBM.Options, DBM.DefaultOptions)
		-- load special warning options
		DBM:UpdateSpecialWarningOptions()
		-- set this with a short delay to prevent issues with other addons also trying to do the same thing with another position ;)
		DBM:Schedule(5, setRaidWarningPositon)
	end

	function loadModOptions(modId)
		local savedOptions = _G[modId:gsub("-", "").."_SavedVars"] or {}
		local savedStats = _G[modId:gsub("-", "").."_SavedStats"] or {}
		for i, v in ipairs(DBM.Mods) do
			if v.modId == modId then
				savedOptions[v.id] = savedOptions[v.id] or v.Options
				for option, optionValue in pairs(v.Options) do
					if savedOptions[v.id][option] == nil then
						savedOptions[v.id][option] = optionValue
					end
				end
				v.Options = savedOptions[v.id] or {}
				savedStats[v.id] = savedStats[v.id] or {
					normalKills = 0,
					normalPulls = 0,
					heroicKills = 0,
					heroicPulls = 0,
					normal25Kills = 0,
					normal25Pulls = 0,
					heroic25Kills = 0,
					heroic25Pulls = 0
				}
				if not savedStats[v.id].normalPulls then
					savedStats[v.id] = {
						normalKills = 0,
						normalPulls = 0,
						heroicKills = 0,
						heroicPulls = 0,
						normal25Kills = 0,
						normal25Pulls = 0,
						heroic25Kills = 0,
						heroic25Pulls = 0
					}
				end
				v.stats = savedStats[v.id]
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


--------------
--  OnLoad  --
--------------
do
	local function showOldVerWarning()
		StaticPopupDialogs["DBM_OLD_VERSION"] = {
			text = DBM_CORE_ERROR_DBMV3_LOADED,
			button1 = DBM_CORE_OK,
			OnAccept = function()
				DisableAddOn("DBM_API")
				ReloadUI()
			end,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
		StaticPopup_Show("DBM_OLD_VERSION")
	end
	
	local function setCombatInitialized()
		combatInitialized = true
	end
	
	function DBM:ADDON_LOADED(modname)
		if modname == "DBM-Core" then
			loadOptions()
			DBM.Bars:LoadOptions("DBM")
			DBM.Arrow:LoadPosition()
			if not DBM.Options.ShowMinimapButton then DBM:HideMinimapButton() end
			self.AddOns = {}
			for i = 1, GetNumAddOns() do
				if GetAddOnMetadata(i, "X-DBM-Mod") and not checkEntry(bannedMods, GetAddOnInfo(i)) then
					table.insert(self.AddOns, {
						sort		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or math.huge) or math.huge,
						category	= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
						name		= GetAddOnMetadata(i, "X-DBM-Mod-Name") or "",
						zone		= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadZone") or "BogusZone")},--workaround, so mods with zoneids and no zonetext don't get loaded by default before zoneids even checked
						zoneId		= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadZoneID") or "")},
						subTabs		= GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
						hasHeroic	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Heroic-Mode") or 1) == 1,
						modId		= GetAddOnInfo(i),
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
				"RAID_ROSTER_UPDATE",
				"PARTY_MEMBERS_CHANGED",
				"CHAT_MSG_ADDON",
				"PLAYER_REGEN_DISABLED",
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
				"UNIT_DIED",
				"UNIT_DESTROYED",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_BN_WHISPER",
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_MONSTER_SAY",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"PLAYER_ENTERING_WORLD",
				"LFG_PROPOSAL_SHOW",
				"LFG_PROPOSAL_FAILED",
				"LFG_UPDATE",
				"CHAT_MSG_LOOT"
			)
			self:ZONE_CHANGED_NEW_AREA()
			self:RAID_ROSTER_UPDATE()
			self:PARTY_MEMBERS_CHANGED()
			DBM:Schedule(1.5, setCombatInitialized)
			local enabled, loadable = select(4, GetAddOnInfo("DBM_API"))
			if enabled and loadable then showOldVerWarning() end
		end
	end
end

function DBM:LFG_PROPOSAL_SHOW()
	DBM.Bars:CreateBar(40, DBM_LFG_INVITE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
end

function DBM:LFG_PROPOSAL_FAILED()
	DBM.Bars:CancelBar(DBM_LFG_INVITE)
end

function DBM:LFG_UPDATE()
    -- simple fix for China wow
    if(GetLFGInfoServer) then
        local _, joined = GetLFGInfoServer()
        if not joined then
            DBM.Bars:CancelBar(DBM_LFG_INVITE)
        end
    end
end

do
	local soundFiles = {
		[0] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper01.wav",
		[1] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper01.wav",
		[2] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper02.wav",
		[3] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper03.wav",
		[4] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper04.wav",
		[5] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper05.wav",
		[6] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper06.wav",
		[7] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper07.wav",
		[8] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_HowlingFjordWhisper08.wav",
		[9] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_Whisper01.wav",
		[10] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_Whisper02.wav",
		[11] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_Whisper03.wav",
		[12] = "Sound\\Creature\\YoggSaron\\AK_YoggSaron_Whisper04.wav",
		[13] = "Sound\\Creature\\CThun\\CThunDeathIsClose.wav",
		[14] = "Sound\\Creature\\CThun\\CThunYouAreAlready.wav",
		[15] = "Sound\\Creature\\CThun\\CThunYouWillBetray.wav",
		[16] = "Sound\\Creature\\CThun\\CThunYouWillDIe.wav",
		[17] = "Sound\\Creature\\CThun\\CThunYourCourage.wav",
		[18] = "Sound\\Creature\\CThun\\CThunYourFriends.wav",
		[19] = "Sound\\Creature\\CThun\\YourHeartWill.wav",
		[20] = "Sound\\Creature\\CThun\\YouAreWeak.wav"
	}

	function DBM:CHAT_MSG_LOOT(msg)
		local player, itemID = msg:match(DBM_LOOT_MSG)
		if player and itemID and (tonumber(itemID) == 52843 or tonumber(itemID) == 63127 or tonumber(itemID) == 63128 or tonumber(itemID) == 64392 or tonumber(itemID) == 64394 or tonumber(itemID) == 64396 or tonumber(itemID) == 64395 or tonumber(itemID) == 64397) then
			if DBM.Options.ArchaeologyHumor then
				local x = random(0, #soundFiles-1)
				PlaySoundFile(soundFiles[x])
			end
	end	end
end


--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
function DBM:ZONE_CHANGED_NEW_AREA()
	if IsInInstance() then--Don't change map if not in instance, it makes archaeologists mad.
		SetMapToCurrentZone()--To Fix blizzard bug, sometimes map isn't loaded on disconnect or reloadui
		local zoneName = GetRealZoneText()
		local zoneId = GetCurrentMapID()
		LastZoneText = zoneName--Cache zone name on change.
		LastZoneMapID = zoneId--Cache map on zone change.
--		DBM:AddMsg(("Zone Change called: current zoneName %s, current mapID %s"):format(tostring(GetRealZoneText()), tostring(GetCurrentMapID()))) -- DEBUG
		for i, v in ipairs(self.AddOns) do
			if not IsAddOnLoaded(v.modId) and (checkEntry(v.zone, zoneName) or checkEntry(v.zoneId, zoneId)) then
				-- srsly, wtf? LoadAddOn doesn't work properly on ZONE_CHANGED_NEW_AREA when reloading the UI
				-- TODO: is this still necessary? this was a WotLK beta bug
				DBM:Unschedule(DBM.LoadMod, DBM, v)
				DBM:Schedule(3, DBM.LoadMod, DBM, v)
			end
		end
	end
	if select(2, IsInInstance()) == "pvp" and not DBM:GetModByName("AlteracValley") then
		for i, v in ipairs(DBM.AddOns) do
			if v.modId == "DBM-PvP" then
				DBM:LoadMod(v)
				break
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
		self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		loadModOptions(mod.modId)
		for i, v in ipairs(DBM.Mods) do -- load the hasHeroic attribute from the toc into all boss mods as required by the GetDifficulty() method
			if v.modId == mod.modId then
				v.hasHeroic = mod.hasHeroic
			end
		end
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		collectgarbage("collect")
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
	local syncHandlers = {}
	local whisperSyncHandlers = {}

	syncHandlers["DBMv4-Mod"] = function(msg, channel, sender)
		local mod, revision, event, arg = strsplit("\t", msg)
		mod = DBM:GetModByName(mod or "")
		if mod and event and arg and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, arg, sender, revision)
		end
	end

	syncHandlers["DBMv4-Pull"] = function(msg, channel, sender)
		if select(2, IsInInstance()) == "pvp" then return end
		local delay, mod, revision = strsplit("\t", msg)
		local lag = select(3, GetNetStats()) / 1000
		delay = tonumber(delay or 0) or 0
		revision = tonumber(revision or 0) or 0
		mod = DBM:GetModByName(mod or "")
		if mod and delay and (not mod.zones or #mod.zones == 0 or checkEntry(mod.zones, LastZoneText) or checkEntry(mod.zones, LastZoneMapID)) and (not mod.minSyncRevision or revision >= mod.minSyncRevision) then
			DBM:StartCombat(mod, delay + lag, true)
		end
	end

	syncHandlers["DBMv4-Kill"] = function(msg, channel, sender)
		if select(2, IsInInstance()) == "pvp" then return end
		local cId = tonumber(msg)
		if cId then DBM:OnMobKill(cId, true) end
	end

	syncHandlers["DBMv4-Ver"] = function(msg, channel, sender)
		if msg == "Hi!" then
			sendSync("DBMv4-Ver", ("%s\t%s\t%s\t%s"):format(DBM.Revision, DBM.Version, DBM.DisplayVersion, GetLocale()))
		else
			local revision, version, displayVersion, locale = strsplit("\t", msg)
			revision, version = tonumber(revision or ""), tonumber(version or "")
			if revision and version and displayVersion and raid[sender] then
				raid[sender].revision = revision
				raid[sender].version = version
				raid[sender].displayVersion = displayVersion
				raid[sender].locale = locale
				if version > tonumber(DBM.Version) then
					if raid[sender].rank >= 1 then
						enableIcons = false
					end
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
							if not DBM.Options.BlockVersionUpdatePopup then
								DBM:ShowUpdateReminder(displayVersion, revision)
							else 
								DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("([^\n]*)"))
								DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, revision))
								DBM:AddMsg(("|HDBM:update:%s:%s|h|cff3588ff[http://deadlybossmods.com]"):format(displayVersion, revision))
							end
						end
					end
				end
			end
		end
	end

	syncHandlers["DBMv4-Pizza"] = function(msg, channel, sender)
		if select(2, IsInInstance()) == "pvp" then return end
		if DBM:GetRaidRank(sender) == 0 then return end
		if sender == UnitName("player") then return end
		local time, text = strsplit("\t", msg)
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
		end
	end

	whisperSyncHandlers["DBMv4-RequestTimers"] = function(msg, channel, sender)
		DBM:SendTimers(sender)
	end

	whisperSyncHandlers["DBMv4-CombatInfo"] = function(msg, channel, sender)
		local mod, time = strsplit("\t", msg)
		mod = DBM:GetModByName(mod or "")
		time = tonumber(time or 0)
		if mod and time then
			DBM:ReceiveCombatInfo(sender, mod, time)
		end
	end

	whisperSyncHandlers["DBMv4-TimerInfo"] = function(msg, channel, sender)
		local mod, timeLeft, totalTime, id = strsplit("\t", msg)
		mod = DBM:GetModByName(mod or "")
		timeLeft = tonumber(timeLeft or 0)
		totalTime = tonumber(totalTime or 0)
		if mod and timeLeft and timeLeft > 0 and totalTime and totalTime > 0 and id then
			DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, select(5, strsplit("\t", msg)))
		end
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if msg and channel ~= "WHISPER" and channel ~= "GUILD" then
			local handler = syncHandlers[prefix]
			if handler then handler(msg, channel, sender) end
		elseif msg and channel == "WHISPER" and self:GetRaidUnitId(sender) ~= "none" then
			local handler = whisperSyncHandlers[prefix]
			if handler then handler(msg, channel, sender) end
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
	editBox:SetText("http://www.deadlybossmods.com")
	editBox:HighlightText()
	editBox:SetScript("OnTextChanged", function(self)
		editBox:SetText("http://www.deadlybossmods.com")
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
		local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
			local id = (i == 0 and "target") or uId..i.."target"
			local guid = UnitGUID(id)
			if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
				local cId = tonumber(guid:sub(7, 10), 16)
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

	function DBM:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		if not combatInitialized then return end
		if combatInfo[LastZoneText] or combatInfo[LastZoneMapID] then
			buildTargetList()
			if combatInfo[LastZoneText] then
				for i, v in ipairs(combatInfo[LastZoneText]) do
					if v.type == "engage" then
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
					if v.type == "engage" then
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
end

do
	-- called for all mob chat events
	local function onMonsterMessage(type, msg)
		-- pull detection
		if combatInfo[LastZoneText] then
			for i, v in ipairs(combatInfo[LastZoneText]) do
				if v.type == type and checkEntry(v.msgs, msg) then
					DBM:StartCombat(v.mod, 0)
				end
			end
		end
		-- copy & paste, lol
		if combatInfo[LastZoneMapID] then
			for i, v in ipairs(combatInfo[LastZoneMapID]) do
				if v.type == type and checkEntry(v.msgs, msg) then
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

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		return onMonsterMessage("say", msg)
	end
end


---------------------------
--  Kill/Wipe Detection  --
---------------------------
function checkWipe(confirm)
	if #inCombat > 0 then
		local wipe = true
		local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
			local id = (i == 0 and "player") or uId..i
			if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
				wipe = false
				break
			end
		end
		if not wipe then
			DBM:Schedule(3, checkWipe)
		elseif confirm then
			for i = #inCombat, 1, -1 do
				DBM:EndCombat(inCombat[i], true)
			end
		else
			local maxDelayTime = 5
			for i, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			DBM:Schedule(maxDelayTime, checkWipe, true)
		end
	end
end

function DBM:StartCombat(mod, delay, synced)
	if not checkEntry(inCombat, mod) then
		if not mod.combatInfo then return end
		if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
			return
		end
		table.insert(inCombat, mod)
		self:AddMsg(DBM_CORE_COMBAT_STARTED:format(mod.combatInfo.name))
		if mod:IsDifficulty("normal5", "normal10") then
			mod.stats.normalPulls = mod.stats.normalPulls + 1
		elseif mod:IsDifficulty("heroic5", "heroic10") then
			mod.stats.heroicPulls = mod.stats.heroicPulls + 1
		elseif mod:IsDifficulty("normal25") then
			mod.stats.normal25Pulls = mod.stats.normal25Pulls + 1
		elseif mod:IsDifficulty("heroic25") then
			mod.stats.heroic25Pulls = mod.stats.heroic25Pulls + 1
		end
		mod.inCombat = true
		mod.blockSyncs = nil
		mod.combatInfo.pull = GetTime() - (delay or 0)
		self:Schedule(mod.minCombatTime or 3, checkWipe)
		if (DBM.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) and mod.Options.Enabled then
			DBM.BossHealth:Show(mod.localization.general.name)
			if mod.bossHealthInfo then
				for i = 1, #mod.bossHealthInfo, 2 do
					DBM.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
				end
			else
				DBM.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
			end
		end
		if (DBM.Options.AlwaysShowSpeedKillTimer or mod.Options.SpeedKillTimer) and mod.Options.Enabled then
			local bestTime
			if mod:IsDifficulty("normal5", "normal10") and mod.stats.normalBestTime then
				bestTime = mod.stats.normalBestTime
			elseif mod:IsDifficulty("heroic5", "heroic10") and mod.stats.heroicBestTime then
				bestTime = mod.stats.heroicBestTime
			elseif mod:IsDifficulty("normal25") and mod.stats.normal25BestTime then
				bestTime = mod.stats.normal25BestTime
			elseif mod:IsDifficulty("heroic25") and mod.stats.heroic25BestTime then
				bestTime = mod.stats.heroic25BestTime
			end
			if bestTime and bestTime > 0 then	-- only start if you already have a bestTime :)
				local speedTimer = mod:NewTimer(bestTime, DBM_SPEED_KILL_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
				speedTimer:Start()
			end
		end
		if mod.OnCombatStart and mod.Options.Enabled then mod:OnCombatStart(delay or 0) end
		if not synced then
			sendSync("DBMv4-Pull", (delay or 0).."\t"..mod.id.."\t"..(mod.revision or 0))
		end
		fireEvent("pull", mod, delay, synced)
		-- http://www.deadlybossmods.com/forum/viewtopic.php?t=1464
		if DBM.Options.ShowBigBrotherOnCombatStart and BigBrother and type(BigBrother.ConsumableCheck) == "function" then
			if DBM.Options.BigBrotherAnnounceToRaid then
				BigBrother:ConsumableCheck("RAID")
			else
				BigBrother:ConsumableCheck("SELF")
			end
		end	
		if DBM.Options.FixCLEUOnCombatStart then
			CombatLogClearEntries()
		end
		if DBM.Options.SetCurrentMapOnPull then
			SetMapToCurrentZone()--Set to current map once engaged for /range and /arrow functions.
		end
	end
end


function DBM:EndCombat(mod, wipe)
	if removeEntry(inCombat, mod) then
		mod:Stop()
		mod.inCombat = false
		mod.blockSyncs = true
		if mod.combatInfo.killMobs then
			for i, v in pairs(mod.combatInfo.killMobs) do
				mod.combatInfo.killMobs[i] = true
			end
		end
		if wipe then
			local thisTime = GetTime() - mod.combatInfo.pull
			if thisTime < 30 then
				if mod:IsDifficulty("normal5", "normal10") then
					mod.stats.normalPulls = mod.stats.normalPulls - 1
				elseif mod:IsDifficulty("heroic5", "heroic10") then
					mod.stats.heroicPulls = mod.stats.heroicPulls - 1
				elseif mod:IsDifficulty("normal25") then
					mod.stats.normal25Pulls = mod.stats.normal25Pulls - 1
				elseif mod:IsDifficulty("heroic25") then
					mod.stats.heroic25Pulls = mod.stats.heroic25Pulls - 1
				end
			end
			self:AddMsg(DBM_CORE_COMBAT_ENDED:format(mod.combatInfo.name, strFromTime(thisTime)))
			local msg
			for k, v in pairs(autoRespondSpam) do
				msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE:format(UnitName("player"), (mod.combatInfo.name or ""))
				sendWhisper(k, msg)
			end
			fireEvent("wipe", mod)
		else
			local thisTime = GetTime() - mod.combatInfo.pull
			local lastTime = (mod:IsDifficulty("normal5", "normal10") and mod.stats.normalLastTime) or (mod:IsDifficulty("heroic5", "heroic10") and mod.stats.heroicLastTime) or (mod:IsDifficulty("normal25") and mod.stats.normal25LastTime) or (mod:IsDifficulty("heroic25") and mod.stats.heroic25LastTime)
			local bestTime = (mod:IsDifficulty("normal5", "normal10") and mod.stats.normalBestTime) or (mod:IsDifficulty("heroic5", "heroic10") and mod.stats.heroicBestTime) or (mod:IsDifficulty("normal25") and mod.stats.normal25BestTime) or (mod:IsDifficulty("heroic25") and mod.stats.heroic25BestTime)
			if mod:IsDifficulty("normal5", "normal10") then
				mod.stats.normalKills = mod.stats.normalKills + 1
				mod.stats.normalLastTime = thisTime
				mod.stats.normalBestTime = math.min(bestTime or math.huge, thisTime)
			elseif mod:IsDifficulty("heroic5", "heroic10") then
				mod.stats.heroicKills = mod.stats.heroicKills + 1
				mod.stats.heroicLastTime = thisTime
				mod.stats.heroicBestTime = math.min(bestTime or math.huge, thisTime)
			elseif mod:IsDifficulty("normal25") then
				mod.stats.normal25Kills = mod.stats.normal25Kills + 1
				mod.stats.normal25LastTime = thisTime
				mod.stats.normal25BestTime = math.min(bestTime or math.huge, thisTime)
			elseif mod:IsDifficulty("heroic25") then
				mod.stats.heroic25Kills = mod.stats.heroic25Kills + 1
				mod.stats.heroic25LastTime = thisTime
				mod.stats.heroic25BestTime = math.min(bestTime or math.huge, thisTime)
			end
			if not lastTime then
				self:AddMsg(DBM_CORE_BOSS_DOWN:format(mod.combatInfo.name, strFromTime(thisTime)))
			elseif thisTime < (bestTime or math.huge) then
				self:AddMsg(DBM_CORE_BOSS_DOWN_NEW_RECORD:format(mod.combatInfo.name, strFromTime(thisTime), strFromTime(bestTime)))
			else
				self:AddMsg(DBM_CORE_BOSS_DOWN_LONG:format(mod.combatInfo.name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime)))
			end
			local msg
			for k, v in pairs(autoRespondSpam) do
				msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL:format(UnitName("player"), (mod.combatInfo.name or ""))
				sendWhisper(k, msg)
			end
			fireEvent("kill", mod)
		end
		table.wipe(autoRespondSpam)
		if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
		DBM.BossHealth:Hide()
		DBM.Arrow:Hide(true)
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
				sendSync("DBMv4-Kill", cId)
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
				sendSync("DBMv4-Kill", cId)
			end
			self:EndCombat(v)
		end
	end
end

function DBM:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(1, 5), 0x00F) == 3 or bit.band(args.destGUID:sub(1, 5), 0x00F) == 5  then
		self:OnMobKill(tonumber(args.destGUID:sub(7, 10), 16))
	end
end
DBM.UNIT_DESTROYED = DBM.UNIT_DIED


----------------------
--  Timer recovery  --
----------------------
do
	local requestedFrom = nil
	local requestTime = 0

	function DBM:RequestTimers()
		local bestClient
		for i, v in pairs(raid) do
			if v.name ~= UnitName("player") and UnitIsConnected(v.id) and (not UnitIsGhost(v.id)) and (v.revision or 0) > ((bestClient and bestClient.revision) or 0) then
				bestClient = v
			end
		end
		if not bestClient then return end
		requestedFrom = bestClient.name
		requestTime = GetTime()
		SendAddonMessage("DBMv4-RequestTimers", "", "WHISPER", bestClient.name)
	end

	function DBM:ReceiveCombatInfo(sender, mod, time)
		if sender == requestedFrom and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			local lag = select(3, GetNetStats()) / 1000
			if not mod.combatInfo then return end
			table.insert(inCombat, mod)
			mod.inCombat = true
			mod.blockSyncs = nil
			mod.combatInfo.pull = GetTime() - time + lag
			self:Schedule(3, checkWipe)
		end
	end

	function DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, ...)
		if sender == requestedFrom and (GetTime() - requestTime) < 5 then
			local lag = select(3, GetNetStats()) / 1000
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
	local spamProtection = 0
	function DBM:SendTimers(target)
		if GetTime() - spamProtection < 0.4 then
			return
		end
		spamProtection = GetTime()
		if UnitInBattleground("player") then
			DBM:SendBGTimers(target)
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
	return SendAddonMessage("DBMv4-CombatInfo", ("%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull), "WHISPER", target)
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
				SendAddonMessage("DBMv4-TimerInfo", ("%s\t%s\t%s\t%s"):format(mod.id, timeLeft, totalTime, uId), "WHISPER", target)
			end
		end
	end
end

do
	local function requestTimers()
		local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
		for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
			local id = (i == 0 and "player") or uId..i
			if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
				DBM:RequestTimers()
				break
			end
		end
	end

	function DBM:PLAYER_ENTERING_WORLD()
		if #inCombat == 0 then
			DBM:Schedule(0, requestTimers)
		end
		self:LFG_UPDATE()
--		self:Schedule(10, function() if not DBM.Options.HelpMessageShown then DBM.Options.HelpMessageShown = true DBM:AddMsg(DBM_CORE_NEED_SUPPORT) end end)
		self:Schedule(10, function() if not DBM.Options.SettingsMessageShown then DBM.Options.SettingsMessageShown = true DBM:AddMsg(DBM_HOW_TO_USE_MOD) end end)
	end
end


------------------------------------
--  Auto-respond/Status whispers  --
------------------------------------
do
	local function getNumAlivePlayers()
		local alive = 0
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumPartyMembers() do
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
		if msg == "status" and #inCombat > 0 and DBM.Options.StatusEnabled then
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			sendWhisper(sender, chatPrefix..DBM_CORE_STATUS_WHISPER:format((mod.combatInfo.name or ""), mod:GetHP() or "unknown", getNumAlivePlayers(), math.max(GetNumRaidMembers(), GetNumPartyMembers() + 1)))
		elseif #inCombat > 0 and DBM.Options.AutoRespond and
		(isRealIdMessage and (not isOnSameServer(sender) or DBM:GetRaidUnitId((select(4, BNGetFriendInfoByID(sender)))) == "none") or not isRealIdMessage and DBM:GetRaidUnitId(sender) == "none") then
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			if not autoRespondSpam[sender] then
				sendWhisper(sender, chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER:format(UnitName("player"), mod.combatInfo.name or "", mod:GetHP() or "unknown", getNumAlivePlayers(), math.max(GetNumRaidMembers(), GetNumPartyMembers() + 1)))
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
		return DBM.Options.SpamBlockRaidWarning and type(msg) == "string" and (not not msg:match("^%s*%*%*%*")), ...
	end

	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filterRaidWarning)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filterRaidWarning)
end


do
	local old = RaidWarningFrame:GetScript("OnEvent")
	RaidWarningFrame:SetScript("OnEvent", function(self, event, msg, ...)
		if DBM.Options.SpamBlockRaidWarning and msg:find("%*%*%* .* %*%*%*") then
			return
		end
		return old(self, event, msg, ...)
	end)
end

do	
	local old = RaidBossEmoteFrame:GetScript("OnEvent")
	RaidBossEmoteFrame:SetScript("OnEvent", function(...)
		if DBM.Options.HideBossEmoteFrame and #inCombat > 0 then
			return
		end
		return old(...)
	end)
end


--------------------------
--  Enable/Disable DBM  --
--------------------------
function DBM:Disable()
	unschedule()
	self.Options.Enabled = false
end

function DBM:Enable()
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
	local testSpecialWarning
	function DBM:DemoMode()
		if not testMod then
			testMod = DBM:NewMod("TestMod")
			testWarning1 = testMod:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
			testWarning2 = testMod:NewAnnounce("%s", 2, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
			testWarning3 = testMod:NewAnnounce("%s", 3, "Interface\\Icons\\Spell_Fire_SelfDestruct")
			testTimer = testMod:NewTimer(20, "%s")			
			testSpecialWarning = testMod:NewSpecialWarning("%s")
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
		testSpecialWarning:Cancel()
		testWarning1:Show("Test-mode started...")
		testWarning1:Schedule(62, "Test-mode finished!")
		testWarning3:Schedule(50, "Boom in 10 sec!")
		testWarning3:Schedule(20, "Pew Pew Laser Owl!")
		testWarning2:Schedule(38, "Evil Spell in 5 sec!")
		testWarning2:Schedule(43, "Evil Spell!")
		testWarning1:Schedule(10, "Test bar expired!")
		testSpecialWarning:Schedule(60, "Boom!")
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

	function DBM:NewMod(name, modId, modSubTab)
		if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
					Announce = false,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				modId = modId,
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
		if obj.localization.general.name == "name" then obj.localization.general.name = name end
		table.insert(self.Mods, obj)
		modsById[name] = obj
		obj:AddBoolOption("SpeedKillTimer", false, "misc")
		obj:AddBoolOption("HealthFrame", false, "misc")
		obj:SetZone()
		return obj
	end

	function DBM:GetModByName(name)
		return modsById[name]
	end
end


-----------------------
--  General Methods  --
-----------------------
bossModPrototype.RegisterEvents = DBM.RegisterEvents
bossModPrototype.UnregisterAllEvents = DBM.UnregisterAllEvents
bossModPrototype.AddMsg = DBM.AddMsg

function bossModPrototype:SetZone(...)
	if select("#", ...) == 0 then
		if self.addon and self.addon.zone and #self.addon.zone > 0 and self.addon.zoneId and #self.addon.zoneId > 0 then
			self.zones = {}
			for i, v in ipairs(self.addon.zone) do
				self.zones[#self.zones + 1] = v
			end
			for i, v in ipairs(self.addon.zoneId) do
				self.zones[#self.zones + 1] = v
			end
		else
			self.zones = self.addon and (self.addon.zone and #self.addon.zone > 0 and self.addon.zone or self.addon.zoneId and #self.addon.zoneId > 0 and self.addon.zoneId) or {}
		end
	elseif select(1, ...) ~= DBM_DISABLE_ZONE_DETECTION then
		self.zones = {...}
	else -- disable zone detection
		self.zones = nil
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
	self.revision = revision
end

function bossModPrototype:SendWhisper(msg, target)
	return not DBM.Options.DontSendBossWhispers and sendWhisper(target, chatPrefixShort..msg)
end

function bossModPrototype:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	return (guid and (tonumber(guid:sub(7, 10), 16))) or 0
end

function bossModPrototype:GetCIDFromGUID(guid)
	return (guid and (tonumber(guid:sub(7, 10), 16))) or 0
end

function bossModPrototype:GetBossTarget(cid)
	cid = cid or self.creatureId
	for i = 1, GetNumRaidMembers() do
		if self:GetUnitCreatureId("raid"..i.."target") == cid then
			return UnitName("raid"..i.."targettarget"), "raid"..i.."targettarget"
		elseif self:GetUnitCreatureId("focus") == cid then	-- we check our own focus frame, maybe the boss is there ;)
			return UnitName("focustarget"), "focustarget"
		end
	end
end

function bossModPrototype:GetThreatTarget(cid)
	cid = cid or self.creatureId
	for i = 1, GetNumRaidMembers() do
		if self:GetUnitCreatureId("raid"..i.."target") == cid then
			for x = 1, GetNumRaidMembers() do
				if UnitDetailedThreatSituation("raid"..x, "raid"..i.."target") == 1 then
					return "raid"..x
				end
			end
		end
	end
end

function bossModPrototype:Stop(cid)
	for i, v in ipairs(self.timers) do
		v:Stop()
	end
	self:Unschedule()
end

-- hard coded party-mod support, yay :)
-- returns heroic for old instances that do not have a heroic mode (Naxx, Ulduar...)
function bossModPrototype:GetDifficulty() 
	local _, instanceType, difficulty, _, _, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if instanceType == "raid" and isDynamicInstance and not is_cata then -- "dynamic" instance (ICC) (3.3.5 only)
		if difficulty == 1 then -- 10 men
			return playerDifficulty == 0 and "normal10" or playerDifficulty == 1 and "heroic10" or "unknown"
		elseif difficulty == 2 then -- 25 men
			return playerDifficulty == 0 and "normal25" or playerDifficulty == 1 and "heroic25" or "unknown"
		end
	else -- support for "old" instances (in 4.0 blizz switched all instances to 1-4 method)
		if difficulty == 1 then 
			return instanceType == "raid" and "normal10" or "normal5"
		elseif difficulty == 2 then 
			return instanceType == "raid" and "normal25" or "heroic5"
		elseif difficulty == 3 then 
			return "heroic10" 
		elseif difficulty == 4 then 
			return "heroic25" 
		end
	end
end 

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
	return select(3, GetNetStats()) < DBM.Options.LatencyThreshold
end

local function getTalentpointsSpent(spellID)
	local spellName = GetSpellInfo(spellID)
	for tabIndex=1, GetNumTalentTabs() do
		for talentID=1, GetNumTalents(tabIndex) do
			local name, _, _, _, spent = GetTalentInfo(tabIndex, talentID)
			if(name == spellName) then
				return spent
			end
		end
	end
	return 0
end

--Complex talent checker.
--First verifies if it's cata beta or live to determin if it should use 51 pt checks or 31 pt.
--It determins if person is even high enough level for that to even work.
--if not, it only checks class and returns yes to roll to avoid misjudging someones spec and turning options off for them that shouldn't be off.
--(plus fixes nil error if they are below level 11 and have no talents yet)
--Try to avoid using "not" in boss mods for checks if it can be helped, Only 2 mods i know if apsolutely couldn't avoid using not.

if is_cata then--It's Cataclysm
	function bossModPrototype:IsMelee()
		if UnitLevel("player") >= 69 then
			return class == "ROGUE"
			or class == "WARRIOR"
			or class == "DEATHKNIGHT"
			or (class == "PALADIN" and select(5, GetTalentTabInfo(1)) < 31)
     		or (class == "SHAMAN" and select(5, GetTalentTabInfo(2)) >= 31)
			or (class == "DRUID" and select(5, GetTalentTabInfo(2)) >= 31)
		else
			return class == "ROGUE"
			or class == "WARRIOR"
			or class == "DEATHKNIGHT"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
		end
	end

	function bossModPrototype:IsRanged()
		if UnitLevel("player") >= 69 then
			return class == "MAGE"
			or class == "HUNTER"
			or class == "WARLOCK"
			or class == "PRIEST"
			or (class == "PALADIN" and select(5, GetTalentTabInfo(1)) >= 31)
     		or (class == "SHAMAN" and select(5, GetTalentTabInfo(2)) < 31)
			or (class == "DRUID" and select(5, GetTalentTabInfo(2)) < 31)
		else
			return class == "MAGE"
			or class == "HUNTER"
			or class == "WARLOCK"
			or class == "PRIEST"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
		end
	end

	function bossModPrototype:IsManaUser()--Similar to ranged, but includes all paladins and all shamens and excludes hunters in cata
		if UnitLevel("player") >= 69 then
			return class == "MAGE"
			or class == "WARLOCK"
			or class == "PRIEST"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or (class == "DRUID" and select(5, GetTalentTabInfo(2)) < 31)
		else
			return class == "MAGE"
			or class == "WARLOCK"
			or class == "PRIEST"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
		end
	end

	local function IsDeathKnightTank()
		-- idea taken from addon 'ElitistJerks'
		local tankTalents = (getTalentpointsSpent(50371) >= 2 and 1 or 0) +	-- Improved Blood Presence
	                    (getTalentpointsSpent(49787) >= 3 and 1 or 0) +		-- Toughness
						(getTalentpointsSpent(49501) >= 3 and 1 or 0)		-- Blade Barrier
		return tankTalents >= 2
	end

	local function IsDruidTank()
	-- idea taken from addon 'ElitistJerks'
		local tankTalents = (getTalentpointsSpent(57880) >= 2 and 1 or 0) +	-- Natural Reaction
	                    (getTalentpointsSpent(16931) >= 3 and 1 or 0) +		-- Thick Hide
						(getTalentpointsSpent(61336) >= 1 and 1 or 0)		-- Survival Instincts
		return tankTalents >= 3
	end

	function bossModPrototype:IsTank()
		if UnitLevel("player") >= 69 then
			return (class == "WARRIOR" and select(5, GetTalentTabInfo(3)) >= 31)
     		or (class == "DEATHKNIGHT" and IsDeathKnightTank())
			or (class == "PALADIN" and select(5, GetTalentTabInfo(2)) >= 31)
			or (class == "DRUID" and select(5, GetTalentTabInfo(2)) >= 31 and IsDruidTank())
		else
			return class == "WARRIOR"
     		or class == "DEATHKNIGHT"
			or class == "PALADIN"
			or class == "DRUID"
		end
	end

	function bossModPrototype:IsHealer()
		if UnitLevel("player") >= 69 then
			return (class == "PALADIN" and select(5, GetTalentTabInfo(1)) >= 31)
     		or (class == "SHAMAN" and select(5, GetTalentTabInfo(3)) >= 31)
			or (class == "DRUID" and select(5, GetTalentTabInfo(3)) >= 31)
			or (class == "PRIEST" and select(5, GetTalentTabInfo(3)) < 31)
		else
			return class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
			or class == "PRIEST"
		end
	end
else--It's not cataclysm
	function bossModPrototype:IsMelee()
		if UnitLevel("player") >= 62 then
			return class == "ROGUE"
			or class == "WARRIOR"
			or class == "DEATHKNIGHT"
			or (class == "PALADIN" and select(3, GetTalentTabInfo(1)) < 51)
     		or (class == "SHAMAN" and select(3, GetTalentTabInfo(2)) >= 51)
			or (class == "DRUID" and select(3, GetTalentTabInfo(2)) >= 51)
		else
			return class == "ROGUE"
			or class == "WARRIOR"
			or class == "DEATHKNIGHT"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
		end
	end

	function bossModPrototype:IsRanged()
		if UnitLevel("player") >= 62 then
			return class == "MAGE"
			or class == "HUNTER"
			or class == "WARLOCK"
			or class == "PRIEST"
			or (class == "PALADIN" and select(3, GetTalentTabInfo(1)) >= 51)
     		or (class == "SHAMAN" and select(3, GetTalentTabInfo(2)) < 51)
			or (class == "DRUID" and select(3, GetTalentTabInfo(2)) < 51)
		else
			return class == "MAGE"
			or class == "HUNTER"
			or class == "WARLOCK"
			or class == "PRIEST"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
		end
	end

	function bossModPrototype:IsManaUser()--Similar to ranged, but includes all paladins and all shamens and excludes hunters in cata
		if UnitLevel("player") >= 62 then
			return class == "MAGE"
			or class == "HUNTER"
			or class == "WARLOCK"
			or class == "PRIEST"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or (class == "DRUID" and select(3, GetTalentTabInfo(2)) < 51)
		else
			return class == "MAGE"
			or class == "HUNTER"
			or class == "WARLOCK"
			or class == "PRIEST"
			or class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
		end
	end

	local function IsDeathKnightTank()
		-- idea taken from addon 'ElitistJerks'
		local tankTalents = (getTalentpointsSpent(16271) >= 5 and 1 or 0) +		-- Anticipation
	                    (getTalentpointsSpent(49042) >= 5 and 1 or 0) +		-- Toughness
						(getTalentpointsSpent(55225) >= 5 and 1 or 0)		-- Blade Barrier
		return tankTalents >= 2
	end

	local function IsDruidTank()
	-- idea taken from addon 'ElitistJerks'
		local tankTalents = (getTalentpointsSpent(57881) >= 2 and 1 or 0) +		-- Natural Reaction
	                    (getTalentpointsSpent(16929) >= 3 and 1 or 0) +		-- Thick Hide
						(getTalentpointsSpent(61336) >= 1 and 1 or 0) +		-- Survival Instincts
						(getTalentpointsSpent(33856) >= 3 and 1 or 0) +		-- Survival of the Fittest
						(getTalentpointsSpent(57877) >= 3 and 1 or 0)		-- Protector of the Pack
		return tankTalents >= 4
	end

	function bossModPrototype:IsTank()
		if UnitLevel("player") >= 62 then
			return (class == "WARRIOR" and select(3, GetTalentTabInfo(3)) >= 51)
     		or (class == "DEATHKNIGHT" and IsDeathKnightTank())
			or (class == "PALADIN" and select(3, GetTalentTabInfo(2)) >= 51)
			or (class == "DRUID" and select(3, GetTalentTabInfo(2)) >= 51 and IsDruidTank())
		else
			return class == "WARRIOR"
     		or class == "DEATHKNIGHT"
			or class == "PALADIN"
			or class == "DRUID"
		end
	end

	function bossModPrototype:IsHealer()
		if UnitLevel("player") >= 62 then
			return (class == "PALADIN" and select(3, GetTalentTabInfo(1)) >= 51)
     		or (class == "SHAMAN" and select(3, GetTalentTabInfo(3)) >= 51)
			or (class == "DRUID" and select(3, GetTalentTabInfo(3)) >= 51)
			or (class == "PRIEST" and select(3, GetTalentTabInfo(3)) < 51)
		else
			return class == "PALADIN"
     		or class == "SHAMAN"
			or class == "DRUID"
			or class == "PRIEST"
		end
	end
end
--These don't matter since they don't check talents
function bossModPrototype:IsPhysical()
	return self:IsMelee() or class == "HUNTER"
end

function bossModPrototype:CanRemoveEnrage()
	return class == "HUNTER" or class == "ROGUE"
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
	local textureExp = " |T(%S+):12:12|t "
	local announcePrototype = {}
	local mt = {__index = announcePrototype}
	
	local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

	function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
		if not self.option or self.mod.Options[self.option] then
			if self.mod.Options.Announce and not DBM.Options.DontSendBossAnnounces and (IsRaidLeader() or (IsPartyLeader() and GetNumPartyMembers() >= 1)) then
				local message = pformat(self.text, ...)
				message = message:gsub("|3%-%d%((.-)%)", "%1") -- for |3-id(text) encoding in russian localization
				SendChatMessage(("*** %s ***"):format(message), GetNumRaidMembers() > 0 and "RAID_WARNING" or "PARTY")
			end
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
					if DBM:GetRaidClass(cap) then
						local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(cap)] or color
						cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
					end
					return cap
				end
			end
			text = text:gsub(">.-<", cachedColorFunctions[self.color])
			RaidNotice_AddMessage(RaidWarningFrame, text, ChatTypeInfo["RAID_WARNING"]) -- the color option doesn't work (at least it didn't work during the WotLK beta...todo: check this)
			if DBM.Options.ShowWarningsInChat then
				text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size
				if DBM.Options.ShowFakedRaidWarnings then
					for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
						local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
						if frame ~= RaidWarningFrame and frame:GetScript("OnEvent") then
							frame:GetScript("OnEvent")(frame, "CHAT_MSG_RAID_WARNING", text, UnitName("player"), GetDefaultLanguage("player"), "", UnitName("player"), "", 0, 0, "", 0, 99, "")
						end
					end
				else
					self.mod:AddMsg(text, nil)
				end
			end
			PlaySoundFile(DBM.Options.RaidWarningSound)
		end
	end

	function announcePrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName)
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				option = optionName or text,
				mod = self,
				icon = (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")
		end
		table.insert(self.announces, obj)
		return obj
	end
	
	-- new constructor (auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime)
		spellName = GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		icon = icon or spellId
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
		elseif announceType == "phase" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellId)
		else
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				option = optionName or text,
				mod = self,
				icon = (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")
		end
		table.insert(self.announces, obj)
		self.localization.options[text] = DBM_CORE_AUTO_ANNOUNCE_OPTIONS[announceType]:format(spellId, spellName)
		return obj
	end
	
	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 2, ...)
	end
	
	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 3, ...)
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
end

--------------------
--  Sound Object  --
--------------------
do
	local soundPrototype = {}
	local mt = { __index = soundPrototype }
	function bossModPrototype:NewSound(spellId, optionName, optionDefault)
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				option = optionName or DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(spellId),
				mod = self,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(obj.option, optionDefault, "misc")
		end
		return obj
	end
	bossModPrototype.NewRunAwaySound = bossModPrototype.NewSound
	
	function soundPrototype:Play(file)
		if not self.option or self.mod.Options[self.option] then
			PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
		end
	end

	function soundPrototype:Schedule(t, ...)
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype:Cancel(...)
		return unschedule(self.Play, self.mod, self, ...)
	end	
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
			LowHealthFrame:SetAlpha(self.timer - 3)
		elseif self.timer <= 2 then
			frame:SetAlpha(self.timer/2)
		elseif self.timer <= 0 then
			frame:Hide()
		end
	end)

	function specialWarningPrototype:Show(...)
		if DBM.Options.ShowSpecialWarnings and (not self.option or self.mod.Options[self.option]) and not moving and frame then	
			font:SetText(pformat(self.text, ...))
			LowHealthFrame:Show()
			LowHealthFrame:SetAlpha(1)
			frame:Show()
			frame:SetAlpha(1)
			frame.timer = 5
			if self.sound then
				PlaySoundFile(DBM.Options.SpecialWarningSound)
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
		local obj = setmetatable(
			{
				text = self.localization.warnings[text], 
				option = optionName or text,
				mod = self,
				sound = not noSound,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")		
		end
		table.insert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, noSound, runSound)
		spellName = GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		local text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName) 
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				announceType = announceType,
				option = optionName or text,
				mod = self,
				sound = not noSound,
			},
			mt
		)
		if optionName == false then
			obj.option = nil
		else
			self:AddBoolOption(optionName or text, optionDefault, "announce")		-- todo cleanup core code from that indexing type using options[text] is very bad!!! ;)
		end
		table.insert(self.specwarns, obj)
		if announceType == "stack" then
			self.localization.options[text] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
		else
			self.localization.options[text] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
		end
		return obj
	end

	function bossModPrototype:NewSpecialWarningSpell(text, optionDefault, ...)
		return newSpecialWarning(self, "spell", text, nil, optionDefault, ...)
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

	function bossModPrototype:NewSpecialWarningStack(text, optionDefault, stacks, ...)
		return newSpecialWarning(self, "stack", text, stacks, optionDefault, ...)
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
					DBM:Unschedule(moveEnd)
					DBM.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function() 
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)		
					DBM.Options.SpecialWarningPoint = point
					DBM.Options.SpecialWarningX = xOfs
					DBM.Options.SpecialWarningY = yOfs	
					DBM:Schedule(15, moveEnd)
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
			if self.type and not self.text then
				bar:SetText(pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId), ...))
			else				
				bar:SetText(pformat(self.text, ...))
			end
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
			return bar:SetIcon((type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon)
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
		local icon = type(icon) == "number" and select(3, GetSpellInfo(icon)) or icon
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
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
			icon = type(texture) == "number" and select(10, GetAchievementInfo(texture)) or texture or spellId and select(10, GetAchievementInfo(spellId))
--			if optionDefault == nil then
--				local completed = select(4, GetAchievementInfo(spellId))
--				optionDefault = not completed
--			end
		else
			spellName = GetSpellInfo(spellId or 0)
			if spellName then
				icon = type(texture) == "number" and select(3, GetSpellInfo(texture)) or texture or spellId and select(3, GetSpellInfo(spellId))
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
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(spellId, spellName)
		end
		return obj
	end

	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end
	
	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
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
	
	function bossModPrototype:NewNextTimer(...)
		return newTimer(self, "next", ...)
	end
	
	function bossModPrototype:NewAchievementTimer(...)
		return newTimer(self, "achievement", ...)
	end
	
	function bossModPrototype:GetLocalizedTimerText(timerType, spellId)
		local spellName
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
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
	cat = cat or misc
	self:SetOptionCategory(name, cat)
	self.buttons = self.buttons or {}
	self.buttons[name] = onClick
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

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
	local addedKillMobs = false
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		if type(v) == "number" then
			info.killMobs = info.killMobs or {}
			info.killMobs[select(i, ...)] = true
			addedKillMobs = true
		end
	end
	if not addedKillMobs and self.multiMobPullDetection then
		for i, v in ipairs(self.multiMobPullDetection) do
			info.killMobs = info.killMobs or {}
			info.killMobs[v] = true
		end
	end
	self.combatInfo = info
	if not self.zones then return end
	for i, v in ipairs(self.zones) do
		combatInfo[v] = combatInfo[v] or {}
		table.insert(combatInfo[v], info)
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:RegisterKill(msgType, ...)
	if cType then
		cType = cType:lower()
	end
	if not self.combatInfo then
		return
	end
	self.combatInfo.killType = msgType
	self.combatInfo.killMsgs = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		self.combatInfo.killMsgs[v] = true
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		return
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
	self.combatInfo.wipeTimer = t
end

function bossModPrototype:GetBossHPString(cId)
	local idType = (GetNumRaidMembers() == 0 and "party") or "raid"
	for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
		local unitId = ((i == 0) and "target") or idType..i.."target"
		local guid = UnitGUID(unitId)
		if guid and (tonumber(guid:sub(7, 10), 16)) == cId then
			return math.floor(UnitHealth(unitId)/UnitHealthMax(unitId) * 100).."%"
		end
	end
	return DBM_CORE_UNKNOWN
end

function bossModPrototype:GetHP()
	return self:GetBossHPString((self.combatInfo and self.combatInfo.mob) or self.creatureId)
end

function bossModPrototype:IsWipe()
	local wipe = true
	local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
	for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
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
function bossModPrototype:SendSync(event, arg)
	event = event or ""
	arg = arg or ""
	local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision or 0, event, arg)
	local spamId = self.id..event..arg
	local time = GetTime()
	if not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 2.5 then
		self:ReceiveSync(event, arg, nil, self.revision or 0)
		sendSync("DBMv4-Mod", str)
	end
end

function bossModPrototype:ReceiveSync(event, arg, sender, revision)
	local spamId = self.id..event..arg
	local time = GetTime()
	if (not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 2.5) and self.OnSync and (not (self.blockSyncs and sender)) and (not sender or (not self.minSyncRevision or revision >= self.minSyncRevision)) then
		modSyncSpam[spamId] = time
		self:OnSync(event, arg, sender)
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
	if DBM.Options.DontSetIcons or not enableIcons or DBM:GetRaidRank() == 0 then
		return
	end
	icon = icon and icon >= 0 and icon <= 8 and icon or 8
	local oldIcon = self:GetIcon(target) or 0
	SetRaidTarget(DBM:GetRaidUnitId(target), icon)
	self:UnscheduleMethod("SetIcon", target)
	if timer then
		self:ScheduleMethod(timer, "RemoveIcon", target)
		if oldIcon then
			self:ScheduleMethod(timer + 1, "SetIcon", target, oldIcon)
		end
	end
end

function bossModPrototype:GetIcon(target)
	return GetRaidTargetIndex(DBM:GetRaidUnitId(target))
end

function bossModPrototype:RemoveIcon(target, timer)
	return self:SetIcon(target, 0, timer)
end

function bossModPrototype:ClearIcons()
	if GetNumRaidMembers() > 0 then
		for i = 1, GetNumRaidMembers() do
			if UnitExists("raid"..i) and GetRaidTargetIndex("raid"..i) then
				SetRaidTarget("raid"..i, 0)
			end
		end
	else
		for i = 1, GetNumPartyMembers() do
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
		return modLocalizations[name] or self:CreateModLocalization(name)
	end
end

