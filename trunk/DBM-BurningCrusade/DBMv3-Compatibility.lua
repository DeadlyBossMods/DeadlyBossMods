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
--    * deDE: Tandanu/Nitram
--    * enGB: Nitram/Tandanu
--    * (add your names here!)
--
-- 
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners.
--
--
--  You are free:
--    * to Share — to copy, distribute, display, and perform the work
--    * to Remix — to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.


---------------
--  Globals  --
---------------
DBMBurningCrusade_SavedModOptions = {}
DBMBC = {}
DBM_SBT = {}


--------------
--  Locals  --
--------------
local frame = CreateFrame("Frame")


----------------------
--  Event Handling  --
----------------------
local function registerEvents(...)
	for i = 1, select("#", ...) do
		frame:RegisterEvent(select(i, ...))
	end
end

frame:SetScript("OnEvent", function(self, event, ...) if DBMBC[event] then DBMBC[event](DBMBC, ...) end end)

registerEvents("ADDON_LOADED")


---------------
--  Options  --
---------------
local function loadModOptions(mod)
end


--------------
--  OnLoad  --
--------------
function DBMBC:ADDON_LOADED(mod)
	if mod ~= "DBM-BurningCrusade" then return end
	for i = 1, GetNumAddOns() do
		if GetAddOnMetadata(i, "X-DBM-BC-AddOn") then
			table.insert(DBM.AddOns, {
				sort		= tonumber(GetAddOnMetadata(i, "X-DBM-Tab-Sort") or math.huge) or math.huge,
				category	= "BC",
				name		= GetAddOnMetadata(i, "X-DBM-Name") or "",
				zone		= {strsplit(",", GetAddOnMetadata(i, "X-DBM-Tab-LoadZone") or "")},
				v3Tab		= GetAddOnMetadata(i, "X-DBM-Tab-ID"),
				modId		= GetAddOnInfo(i),
			})
		end
	end
	table.sort(DBM.AddOns, function(v1, v2) return v1.sort < v2.sort end)
	registerEvents("RAID_ROSTER_UPDATE")
	DBM:ZONE_CHANGED_NEW_AREA()
end


-------------------------------
--  (Faked) Boss Mod Object  --
-------------------------------
local proxy = {}


-----------------------
--  General Methods  --
-----------------------
function proxy:RegisterEvents(...)
	self.mod:RegisterEvents(...)
	for i = 1, select("#", ...) do
		local event = select(i, ...)
		self.mod[event] = function(self, ...)
			if self.proxy.OnEvent then self.proxy:OnEvent(event, ...) end
		end
	end
end

function proxy:SendSync(...)
	self.mod:SendSync(...)
end

function proxy:AddMsg(...)
	self.mod:AddMsg(...)
end

function proxy:AddOption(id, default, name, func)
	self.mod:AddBoolOption(id, default, "announce", func)
	DBM:GetModLocalization(self.mod.id):SetOptionLocalization({
		[id] = name
	})
end

function proxy:AddBarOption(bar, default)
	self.mod:AddBoolOption(bar:gsub("%(%.%*%)", DBM_BC_TARGET), default, "timer")
	if DBM_SBT[bar] then
		DBM:GetModLocalization(self.mod.id):SetOptionLocalization({
			[bar] = DBM_SBT[bar]
		})
	end
end

function proxy:IsWipe()
	local dead = 0
	for i = 1, GetNumRaidMembers() do
		dead = dead + ((UnitIsDeadOrGhost("raid"..i) and 1) or 0)
	end
	return dead >= 18
end


--------------
--  Combat  --
--------------
function proxy:RegisterCombat(type, ...)
	self.mod:RegisterCombat(((type and type:lower()) or "combat"), ...)
end

function proxy:SetMinCombatTime(...)
	self.mod:SetMinCombatTime(...)
end

function proxy:SetCreatureID(...)
	self.mod:SetCreatureID(...)
end


-------------------
--  Range Check  --
-------------------
function DBM_Gui_DistanceFrame_Show()
	DBM.RangeCheck:Show()
end

function DBM_Gui_DistanceFrame_Hide()
	DBM.RangeCheck:Hide()
end

function DBM_Gui_DistanceFrame_SetDistance(distance)
	DBM.RangeCheck:Show(distance)
end

-----------------
--  Announces  --
-----------------
function proxy:Announce(msg, color, noBroadcast)
	local warning = self["warning"..(color or 1)]
	if not warning then return end
	msg = msg:gsub("%s*%*%*%*%s*", "")
	warning:Show(msg)
end

function proxy:ScheduleAnnounce(timer, msg, color)
	local warning = self["warning"..(color or 1)]
	if not warning then return end
	warning:Schedule(timer, msg)
end

function proxy:UnScheduleAnnounce(msg, color)
	local warning = self["warning"..(color or 1)]
	if not warning then return end
	warning:Cancel(msg)
end

function proxy:AddSpecialWarning(text)
	self.specWarning:Show(text)
end

function proxy:SendHiddenWhisper(msg, player)
	self.mod:SendWhisper(msg, player)
end


----------------
--  Schedule  --
----------------
function proxy:Schedule(timer, func, ...)
	self.mod:Schedule(timer, func, ...)
end

function proxy:ScheduleEvent(timer, ...)
	self.mod:Schedule(timer, self.OnEvent, self, ...)
end
proxy.ScheduleSelf = proxy.ScheduleEvent


function proxy:ScheduleMethod(timer, method, ...)
	self.mod:Schedule(timer, self[method], self, ...)
end

function proxy:UnSchedule(...)
	self.mod:Unschedule(...)
end

function proxy:UnScheduleEvent(...)
	self.mod:Unschedule(self.OnEvent, self, ...)
end
proxy.UnScheduleSelf = proxy.UnScheduleEvent

function proxy:UnScheduleMethod(method, ...)
	self.mod:Unschedule(self[method], self, ...)
end

function proxy:UnScheduleAll()
	self.mod:Unschedule()
end

function proxy:GetEventScheduleTimeLeft()
	return 0
end
proxy.GetSelfScheduleTimeLeft = proxy.GetEventScheduleTimeLeft

function proxy:GetAnnounceScheduleTimeLeft()
	return 0
end

function proxy:GetMethodScheduleTimeLeft()
	return 0
end



------------
--  Bars  --
------------
function proxy:StartStatusBarTimer(timer, name, icon, noBroadcast, repetitions, colorR, colorG, colorB, colorA)
	if self.Options[name] == false then return end
	self.timer:Start(timer, name)
	self.timer:UpdateIcon(icon, name)
end

function proxy:UpdateStatusBarTimer(name, elapsed, timer, newName, newIcon, noBroadcast)
	self.timer:Update(elapsed, timer, name)
	if newIcon then self.timer:UpdateIcon(newIcon, name) end
	if newName then self.timer:UpdateName(newName, name) end
end

function proxy:GetStatusBarTimerTimeLeft(name)
	self.timer:GetTime(name)
end

function proxy:EndStatusBarTimer(name)
	self.timer:Stop(name)
end

-------------
--  Icons  --
-------------
function proxy:SetIcon(target, timer, icon)
	self.mod:SetIcon(target, icon, timer)
end

function proxy:RemoveIcon(...)
	self.mod:RemoveIcon(...)
end

function proxy:RemoveAllIcons()
	return 0
end


--------------------------
--  Callback Functions  --
--------------------------
local function onSync(self, ...)
	if self.proxy.OnSync then self.proxy:OnSync(...) end
end

local function onCombatStart(self, ...)
	self.proxy.InCombat = true
	if self.proxy.OnCombatStart then self.proxy:OnCombatStart(...) end
end

local function onCombatEnd(self, ...)
	if self.proxy.OnCombatEnd then self.proxy:OnCombatEnd(...) end
	self.proxy.InCombat = false
end

local function onInitialize(self)
	if self.proxy.OnUpdate then	self:RegisterOnUpdateHandler(self.proxy.OnUpdate, self.proxy.UpdateInterval or 0.2) end
	self.proxy.Options = self.Options
end

-------------------
--  Constructor  --
-------------------
do
	local function getAddOnIDByTab(tab)
		for i, v in ipairs(DBM.AddOns) do
			if tab == v.v3Tab then
				return v.modId
			end
		end
	end
	local mt = {__index = proxy}

	function DBM:NewBossMod(id, name, _, zone, tab)
		local obj = setmetatable({}, mt)
		local mod = DBM:NewMod(id, getAddOnIDByTab(tab))
		mod:SetRevision(1)
		mod:SetZone(zone)
		obj.timer = mod:NewTimer(10, "%s", nil, nil, false)
		obj.warning1 = mod:NewAnnounce("%s", 1, nil, nil, false)
		obj.warning2 = mod:NewAnnounce("%s", 2, nil, nil, false)
		obj.warning3 = mod:NewAnnounce("%s", 3, nil, nil, false)
		obj.warning4 = mod:NewAnnounce("%s", 4, nil, nil, false)
		obj.specWarning = mod:NewSpecialWarning("%s", nil, false)
		DBM:GetModLocalization(id):SetGeneralLocalization({
			name = name
		})
		obj.mod = mod
		obj.Options = mod.Options
		mod.proxy = obj
		mod.OnSync = onSync
		mod.OnCombatStart = onCombatStart
		mod.OnCombatEnd = onCombatEnd
		mod.OnInitialize = onInitialize
		return obj
	end
end

----------------------
--  Misc functions  --
----------------------

function DBM:GetMod(id)
	return DBM:GetModByName(id) and DBM:GetModByName(id).proxy
end

function DBM.SecondsToTime(t)
	if t <= 60 then
		return ("%.1f"):format(t)
	else
		return ("%d:%0.2d"):format(t/60, math.fmod(t, 60))
	end
end

function DBM.Capitalize(s)
	s = tostring(s)
	if GetLocale() == "krKR" or GetLocale() == "zhCN" or GetLocale() == "zhTW"  or GetLocale() == "ruRU" then
		return s
	else
		return s:sub(0, 1):upper()..s:sub(2)
	end
end

function DBM.GetBuff(unitID, buff)
	local i = 1
	while UnitBuff(unitID, i) do
		if UnitBuff(unitID, i) == buff then
			return i
		end
		i = i + 1
	end
end

function DBM.GetDebuff(unitID, buff)
	local i = 1
	while UnitDebuff(unitID, i) do
		if UnitDebuff(unitID, i) == buff then
			return i
		end
		i = i + 1
	end
end

DBM.Rank = 0
do
	local function updateRank()
		DBM.Rank = DBM:GetRaidRank() or 0
	end
	
	function DBMBC:RAID_ROSTER_UPDATE()
		DBM:Schedule(0, updateRank)
	end
end


-------------------------------
--  Schedule function hooks  --
-------------------------------

do
	local old = DBM.Schedule
	function DBM:Schedule(t, ...)
		if type(self) == "number" then
			old(DBM, self, t, ...)
		else
			old(self, t, ...)
		end
	end
end

do
	local old = DBM.Unschedule
	function DBM:Unschedule(...)
		if type(self) == "function" then
			old(DBM, self, ...)
		else
			old(self, ...)
		end
	end
end

function DBM.UnSchedule(...)
	DBM:Unschedule(...)
end
