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

frame:SetScript("OnEvent", function(self, event, ...) DBMBC[event](DBMBC, ...) end)

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
		if GetAddOnMetadata(i, "X-DBM-AddOn") then
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
end


-------------------------------
--  (Faked) Boss Mod Object  --
-------------------------------
local proxy = {}

-----------------------
--  General Methods  --
-----------------------

function proxy:RegisterCombat(...) -- TODO
end

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

function proxy:AddOption(id, default, name)
	self.mod:AddBoolOption(id, default, "announce")
	DBM:GetModLocalization(self.mod.id):SetOptionLocalization({
		id = name
	})
end

function proxy:AddBarOption(bar, default)
	self.mod:AddBoolOption(id, default, "timer")
end


function proxy:IsWipe()
	local dead = 0
	for i = 1, GetNumRaidMembers() do
		dead = dead + ((UnitIsDeadOrGhost("raid"..i) and 1) or 0)
	end
	return dead >= 18
end


-----------------
--  Announces  --
-----------------
function proxy:Announce(msg, color, noBroadcast) -- TODO
end

function proxy:ScheduleAnnounce(timer, ...) -- TODO
end

function proxy:UnScheduleAnnounce(...) -- TODO
end

function proxy:AddSpecialWarning(text) -- TODO
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
	self.mod:ScheduleMethod(timer, "OnEvent", ...)
end
proxy.ScheduleSelf = proxy.ScheduleEvent


function proxy:ScheduleMethod(...)
	self.mod:ScheduleMethod(...)
end

function proxy:UnSchedule(...)
	self.mod:Unschedule(...)
end

function proxy:UnScheduleEvent(...)
	self.mod:UnscheduleMethod("OnEvent", ...)
end
proxy.UnScheduleSelf = proxy.UnScheduleEvent

function proxy:UnScheduleMethod(...)
	self.mod:UnscheduleMethod(...)
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
function proxy:StartStatusBarTimer(timer, name, icon, noBroadcast, repetitions, colorR, colorG, colorB, colorA) -- TODO

end

function proxy:UpdateStatusBarTimer(name, elapsed, timer, newName, newIcon, noBroadcast) -- TODO

end

function proxy:GetStatusBarTimerTimeLeft(name) -- TODO

end

function proxy:EndStatusBarTimer(name, noBroadcast) -- TODO

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
	if self.proxy.OnCombatStart then self.proxy:OnCombatStart(...) end
end

local function onCombatEnd(self, ...)
	if self.proxy.OnCombatStart then self.proxy:OnCombatStart(...) end
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
		local mod = DBM:NewMod(id, getAddOnIDByTab(tab))
		mod:SetRevision(1)
		mod:SetZone(zone)
		DBM:GetModLocalization(id):SetGeneralLocalization({
			name = name
		})
		local obj = setmetatable(
			{
				mod = mod
			},
			mt
		)
		mod.proxy = obj
		mod.OnSync = onSync
		return obj
	end
end



































