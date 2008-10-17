-- **********************************************************
-- **             Deadly Boss Mods - DKP System            **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
-- 
-- The localizations are written by:
--    * deDE: Nitram/Tandanu
--    * enGB: Nitram/Tandanu
--    * (add your names here!)
--
-- 
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share  to copy, distribute, display, and perform the work
--    * to Remix  to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--
--

local default_settings = {
	enabled = true,
	sb_as_raid = true,		-- count Standby Players as Raid Members

	time_event = false,		-- count raid attendance by time and bosskills
	time_to_count = 60,		-- count all 60 Min an Event "raid attendance"
	time_points = 10,		-- points to count on time events
	time_desc = "Raid Attendance",	-- name of the Event for Time Based DKP

	boss_event = true,		-- create Event for BossKills
	boss_points = 10, 		-- points to count for Bosskill
	boss_desc = "%s",		-- name of the Event for BossKills (Killed Boss: %s)

	start_event = true,		-- create a RaidStart Event
	start_points = 10,		-- points to get for Raidstart
	start_desc = "Raid Start",	-- name of the Event for EQDKP
	
	items = {},			-- items wating for event
	events = {},			-- current raid events
	history = {}			-- history of raids
}

DBM_DKP_System_Settings = {}
local settings = default_settings

local L = DBM_DKP_System_Translations

local timespend = 0
local start_time = 0

-- functions
local RaidStart
local RaidEnd
local GetRaidList
local CreateEvent
local AddItemForEvent
local addDefaultOptions

do
	local function creategui()
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_DKPSystem, "option")
		do
			local area = panel:CreateArea(L.AreaManageRaid, nil, 150, true)

			local button = area:CreateButton(L.Button_StartDKPTracking, 200, 25)
			button:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -20)
			button:SetScript("OnShow", function(self) 
				if start_time > 0 then
					self:SetText(L.Button_StopDKPTracking)
				else 
					self:SetText(L.Button_StartDKPTracking)
				end
			end)
			button:SetScript("OnClick", function(self)
				if start_time > 0 then
					DBM:AddMsg(start_time)
					RaidEnd()
				else
					if GetNumRaidMembers() == 0 then
						DBM:AddMsg(L.Local_NoRaidPresent)
					else
						RaidStart()
					end
				end
				self:GetScript("OnShow")(self)
			end)

			local neweventpoints 	= area:CreateEditBox(L.CustomPoint, "", 75)
			local neweventdescr 	= area:CreateEditBox(L.CustomDescription, L.CustomDefault, 250)
			neweventpoints:SetNumeric()
			neweventpoints:SetMaxLetters(5)
			neweventpoints:SetPoint("TOPLEFT", button, "BOTTOMLEFT", 15, -25)
			neweventdescr:SetMaxLetters(30)
			neweventdescr:SetPoint("TOPLEFT", neweventpoints, "TOPRIGHT", 40, 0)

			local DKPto = "RAID"
			local pltable = {{text=L.AllPlayers, value="RAID"}}
			local dkpfor 	= area:CreateDropdown(L.ChatChannel, pltable, "RAID", function(value) DKPto = value end)
			dkpfor:SetPoint("TOPLEFT", neweventpoints, "BOTTOMLEFT", -25, -5)
			dkpfor:SetScript("OnShow", function(self)
				if GetNumRaidMembers() > 0 then
					table.wipe(pltable)
					table.insert(pltable, {text=L.AllPlayers, value="RAID"})
					for k,v in pairs(GetRaidList()) do
						table.insert(pltable, {text=v, value=v})
					end
				end
			end)

			local button = area:CreateButton(L.Button_CreateEvent, 200, 25)
			button:SetPoint("TOPRIGHT", neweventdescr, "BOTTOMRIGHT", 5, -5)
			button:SetScript("OnClick", function(self)
				if neweventpoints:GetNumber() <= 0 or neweventdescr:GetText() == "" then 
					DBM:AddMsg(L.Local_NoInformation)
				else
					local event = {
						event_type = "custom",
						description = neweventdescr:GetText(),
						points = neweventpoints:GetNumber(),
						timestamp = time()
					}
					if DKPto == "RAID" then
						event.members = GetRaidList()
					else
						event.members = DKPto
					end
					CreateEvent(event)
					DBM:AddMsg(L.Local_EventCreated)
					neweventpoints:SetText("")
					neweventdescr:SetText("")
				end
			end)
		end
		do
			local area = panel:CreateArea(L.AreaGeneral, nil, 290, true)

			local enabled = area:CreateCheckButton(L.Enable, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)
			
			local sbusers = area:CreateCheckButton(L.Enable_SB_Users, true)
			sbusers:SetScript("OnShow", function(self) self:SetChecked(settings.sb_as_raid) end)
			sbusers:SetScript("OnClick", function(self) settings.sb_as_raid = not not self:GetChecked() end)

			-- Create Start Events
			local startevent 	= area:CreateCheckButton(L.Enable_StarEvent, true)
			local startpoints 	= area:CreateEditBox(L.StartPoints, settings.start_points, 75)
			local startdescr 	= area:CreateEditBox(L.StartDescription, settings.start_desc, 250)
			startevent:SetScript("OnShow", function(self) self:SetChecked(settings.start_event) end)
			startevent:SetScript("OnClick", function(self) settings.start_event = not not self:GetChecked() end)
			startpoints:SetNumeric()
			startpoints:SetMaxLetters(5)
			startpoints:SetPoint("TOPLEFT", startevent, "BOTTOMLEFT", 15, -10)
			startpoints:SetScript("OnShow", function(self) self:SetText(settings.start_points) end)
			startpoints:SetScript("OnTextChanged", function(self) settings.start_points = self:GetNumber() end)
			startdescr:SetMaxLetters(30)
			startdescr:SetPoint("TOPLEFT", startpoints, "TOPRIGHT", 40, 0)
			startdescr:SetScript("OnShow", function(self) self:SetText(settings.start_desc) end)
			startdescr:SetScript("OnTextChanged", function(self) settings.start_desc = self:GetText() end)

			-- Create Boss Events
			local bossevent 	= area:CreateCheckButton(L.Enable_BossEvents)
			local bosspoints 	= area:CreateEditBox(L.BossPoints, settings.boss_points, 75)
			local bossdescr 	= area:CreateEditBox(L.BossDescription, settings.boss_desc, 250)
			bossevent:SetScript("OnShow", function(self) self:SetChecked(settings.boss_event) end)
			bossevent:SetScript("OnClick", function(self) settings.boss_event = not not self:GetChecked() end)
			bossevent:SetPoint("TOPLEFT", startevent, "BOTTOMLEFT", 0, -35)
			bosspoints:SetNumeric()
			bosspoints:SetMaxLetters(5)
			bosspoints:SetPoint("TOPLEFT", bossevent, "BOTTOMLEFT", 15, -10)
			bosspoints:SetScript("OnShow", function(self) self:SetText(settings.boss_points) end)
			bosspoints:SetScript("OnTextChanged", function(self) settings.boss_points = self:GetNumber() end)
			bossdescr:SetMaxLetters(30)
			bossdescr:SetPoint("TOPLEFT", bosspoints, "TOPRIGHT", 40, 0)
			bossdescr:SetScript("OnShow", function(self) self:SetText(settings.boss_desc) end)
			bossdescr:SetScript("OnTextChanged", function(self) settings.boss_desc = self:GetText() end)

			-- Create Time Events
			local timeevent 	= area:CreateCheckButton(L.Enable_TimeEvents)
			local timepoints 	= area:CreateEditBox(L.TimePoints, settings.time_points, 75)
			local timecount		= area:CreateEditBox(L.TimeToCount, settings.time_to_count, 75)
			local timedescr 	= area:CreateEditBox(L.TimeDescription, settings.time_desc, 250)
			timeevent:SetScript("OnShow", function(self) self:SetChecked(settings.time_event) end)
			timeevent:SetScript("OnClick", function(self) settings.time_event = not not self:GetChecked() end)
			timeevent:SetPoint("TOPLEFT", startevent, "BOTTOMLEFT", 0, -95)
			timepoints:SetNumeric()
			timepoints:SetMaxLetters(5)
			timepoints:SetPoint("TOPLEFT", timeevent, "BOTTOMLEFT", 15, -10)
			timepoints:SetScript("OnShow", function(self) self:SetText(settings.time_points) end)
			timepoints:SetScript("OnTextChanged", function(self) settings.time_points = self:GetNumber() end)
			timecount:SetNumeric()
			timecount:SetMaxLetters(4)
			timecount:SetPoint("TOPLEFT", timepoints, "BOTTOMLEFT", 0, -15)
			timecount:SetScript("OnShow", function(self) self:SetText(settings.time_to_count) end)
			timecount:SetScript("OnTextChanged", function(self) settings.time_to_count = self:GetNumber() end)
			timedescr:SetMaxLetters(30)
			timedescr:SetPoint("TOPLEFT", timecount, "TOPRIGHT", 40, 0)
			timedescr:SetScript("OnShow", function(self) self:SetText(settings.time_desc) end)
			timedescr:SetScript("OnTextChanged", function(self) settings.time_desc = self:GetText() end)
		end
		panel:SetMyOwnHeight()
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 13)
end

-- EXPORT (event based) for EQDKP - RaidTracker Addon  (thanks to my old guild Intensity@Azshara for this litte syntax info)
function CreateExportString(raid_id, event_id)
	local raid = settings.history[raid_id or #settings.history]
	local event = raid.events[event_id or #raid.events]
	if not raid or not event then return "failed" end
	local text
	local players = ""
	local raid_start = date("%c", raid.time_start)
	local raid_end = date("%c", raid.time_end)

	-- Creating RaidEvent 
	text = "<RaidInfo><key>"..raid_start.."</key><start>"..raid_start.."</start><end>"..raid_end.."</end><zone>"..(event.zone or "").."</zone><PlayerInfos>"

	-- Adding Players to this Event
	for i,name in ipairs(event.members) do
		text = text.."<key"..i.."><name>"..name.."</name></key"..i..">"
		players = players.."<key"..i.."><player>"..name.."</player><time>"..raid_start.."</time></key"..i..">"
	end
	text = text.."</PlayerInfos>"

	-- Adding BossKill
	text = text.."<BossKills><key1><name>"..event.description.."</name><time>"..date("%c", event.timestamp).."</time><attendees/></key1></BossKills>"

	-- Adding the CTRaid Stuff for their Player Leave/Join Events
	text = text.."<note><![CDATA["..(event.zone or "").." - "..(event.bossname or "").." - "..(event.points or "").."]]></note>"
	text = text.."<Join>"..players.."</Join><Leave>"..players.."</Leave>"

	-- Adding loot to the textblock
	text = text.."<Loot>"
	for k, item in pairs(event.loot or {}) do
		local ItemName = GetItemInfo(item.item)
		local ItemID = select(2, strsplit(":", item.item))
		local color = string.sub(item.item:match("^|(%x+)|"), 2)

		text = text.."<key"..k.."><ItemName>"..(ItemName or "?").."</ItemName><ItemID>"..ItemID.."</ItemID>"
		text = text.."<Icon></Icon><Class></Class><SubClass></SubClass><Color>"..color.."</Color><Count>1</Count>"
		text = text.."<Player>"..item.player.."</Player><Costs>"..item.points.."</Costs><Time>"..date("%c", event.timestamp).."</Time>"
		text = text.."<Zone></Zone><Boss>"..item.from.."</Boss>"--<Note></Note>"
		--text = text.."<Note><![CDATA[ - Zone: "..event.description.. " "..event.points.." DKP]]></Note>"
		--text = text.."<Note>"..event.description.."</Note>"
		text = text.."</key"..k..">"
	end

	text = text.."</Loot></RaidInfo>"
	return text, raid, event
end	

do
	local content
	local raid
	local event

	StaticPopupDialogs["DBM_EXPORT_DKP_STRING"] = {
		text = "DKP String - %s",
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		OnShow = function(self)
			self.editBox:SetText(content)
			self.editBox:SetFocus()
			self.editBox:HighlightText()
		end,
		timeout = 0,
		exclusive = 0,
		hideOnEscape = 1
	}

	function ShowExportString(raid_id, event_id) 
		content, raid, event = CreateExportString(raid_id, event_id)
		StaticPopup_Show("DBM_EXPORT_DKP_STRING", "raid")
	end
end


function GetRaidList()
	if GetNumRaidMembers() == 0 then return false end
	local raidusers = {}
	for i=1, GetNumRaidMembers(), 1 do
		if UnitName("raid"..i) then
			table.insert(raidusers, (UnitName("raid"..i)))
		end
	end

	if settings.sb_as_raid and #DBM_Standby_Settings.sb_users > 0 then
		for k,v in pairs(DBM_Standby_Settings.sb_users) do
			table.insert(raidusers, k)
		end
	end
	return raidusers
end

function CreateEvent(event)
	if type(settings.events) ~= "table" then settings.events = {} end
	if #settings.events == 0 then
		if type(settings.items) == "table" and #settings.items > 0 then
			-- first event, adding pending loots (like epic drops before the first boss)
			event.items = {}
			addDefaultOptions(event.items, settings.items)
			table.wipe(settings.items)
		end
	else
		if type(settings.items) == "table" and #settings.items > 0 then
			local mevent = settings.events[#settings.events]
			if not mevent.items or type(mevent.items) ~= "table" then mevent.items = {} end
			for k,v in pairs(settings.items) do
				table.insert(mevent.items, v)
			end
			table.wipe(settings.items)
		end
	end
	table.insert(settings.events, event)
end

function AddItemForEvent(item)
end

function DBM_DKP_BossKill(bossmod)
	local bossname = bossmod.localization.general.name
	if settings.boss_event then
		CreateEvent({
			event_type = "bosskill",
			zone = GetRealZoneText(),
			description = settings.boss_desc:format(bossname),
			points = settings.boss_points,
			timestamp = time(),
			members = GetRaidList()
		})		
	end
end
DBM:RegisterCallback("kill", DBM_DKP_BossKill)


function RaidStart()
	start_time = time()
	if settings.start_event then
		CreateEvent({
			event_type = "raidstart",
			zone = GetRealZoneText(),
			description = settings.start_desc,
			points = settings.start_points,
			timestamp = time(),
			members = GetRaidList(),
		})
	end
	DBM:AddMsg(L.Local_StartRaid)
end

function RaidEnd()
	local s_time = start_time
	start_time = 0
	if not #settings.events then return end
	local history = {
		time_start = s_time,
		time_end = time(),
		events = {}
	}
	for k,v in pairs(settings.events) do
		table.insert(history.events, v)
		settings.events[k] = nil
	end
	table.insert(settings.history, history)
	DBM:AddMsg(L.Local_RaidSaved)
end

function addDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if t1[i] == nil then
			t1[i] = v
		elseif type(v) == "table" then
			addDefaultOptions(v, t2[i])
		end
	end
end

do
	local mainframe = CreateFrame("frame", "DBM_DKP_System", UIParent)
	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			-- Update settings of this Addon
			settings = DBM_DKP_System_Settings
			addDefaultOptions(settings, default_settings)
		end
	end)
	mainframe:SetScript("OnUpdate", function(self, e)	
		if not settings.time_event or settings.time_to_count < 5 then return end
		timespend = timespend + e
		if timespend/60 >= settings.time_to_count then
			DBM:AddMsg(L.Local_TimeReached)
			CreateEvent({
				event_type = "",
				zone = GetRealZoneText(),
				description = settings.time_desc,
				points = settings.time_points,
				timestamp = time(),
				members = GetRaidList()
			})
			timespend = e
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")
end





