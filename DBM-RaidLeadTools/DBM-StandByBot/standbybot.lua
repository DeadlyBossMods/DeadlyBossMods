-- **********************************************************
-- **             Deadly Boss Mods - StandbyBot            **
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

local mainframe = CreateFrame("frame", "DBM_StandyByBot", UIParent)

DBM_Standby_Settings = {
	enabled = true,
	sb_users = {},
	sb_times = {},
	history = {}
}

local L = DBM_StandbyBot_Translations
local settings = DBM_Standby_Settings
local inRaid = false

do 
	local function creategui()
		local panel = DBM_GUI:CreateNewPanel(L.TabCategory_Standby, "option")
		do
			local area = panel:CreateArea(L.AreaGeneral, nil, 50, true)
			local enabled = area:CreateCheckButton(L.Enable, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)
		end
		do	
			local area = panel:CreateArea(L.AreaStandbyHistory, nil, 260, true)

			local text = area:CreateText(L.NoHistoryAvailable, area.frame:GetWidth()-40, true, GameFontNormalSmall, "LEFT")
			area.frame:SetScript("OnShow", function(self)
				local mytext = ""
				for k,v in pairs(settings.history) do
					mytext = mytext.."["..k.."]: "
					for name,sbtime in pairs(v) do
						local hours = math.floor(sbtime/60/60)
						local minutes = math.floor((sbtime-(hours*60*60))/60)
						mytext = mytext..name.."("..string.format("%02d", hours)..":"..string.format("%02d", minutes)..") "
					end
					mytext = mytext.."\n"
				end
				if mytext ~= "" then
					text:SetText(mytext)
				end
			end)

		end
		panel:SetMyOwnHeight()
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 13)
end


-- functions
local CheckRaidChanges

local function AddStandbyMember(name)
	if not name then return false end
	if settings.sb_users[name] == nil then
		-- a brand new member
		DBM:AddMsg( L.Local_AddedPlayer:format(name) )
		SendChatMessage("<DBM> "..L.AddedSBUser, "WHISPER", nil, name)
		settings.sb_users[name] = time()
		if settings.sb_times[name] == nil then
			settings.sb_times[name] = 0		-- user is now firsttime SB (0 Seconds)
		end
	else
		-- member allready on the list
		SendChatMessage("<DBM> "..L.UserIsAllreadySB, "WHISPER", nil, name)
	end
end

local function RemoveStandbyMember(name, noerror)
	if not name then return false end
	if settings.sb_users[name] == nil then
		-- user issn't standby
		if not noerror then
			SendChatMessage("<DBM> "..L.NotStandby, "WHISPER", nil, name)
		end
		return false
	else
		-- remove user
		DBM:AddMsg( L.Local_RemovedPlayer:format(name) )
		settings.sb_times[name] = settings.sb_times[name] + (time() - settings.sb_users[name])
		settings.sb_users[name] = nil

		local hours = math.floor(settings.sb_times[name]/60/60)
		local minutes = math.floor((settings.sb_times[name]-(hours*60*60))/60)
		SendChatMessage("<DBM> "..L.NoLongerStandby:format(hours, minutes), "WHISPER", nil, name)

		return true
	end
end

local function UpdateTimes()
	if #settings.sb_users > 0 then
		for name, starttime in pairs(settings.sb_users) do
			settings.sb_times[name] = settings.sb_times[name] + (time() - starttime)
			settings.sb_users[name] = time()
		end
	end
end

local function SaveTimeHistory()
	if #settings.sb_times > 0 then
		local key = date(L.DateTimeFormat)
		for name,v in pairs(settings.sb_users) do
			settings.sb_times[name] = settings.sb_times[name] + (time() - v)
			settings.sb_users[name] = nil
		end
		settings.history[key] = settings.sb_times
		settings.sb_times = {}
	end
end

do
	local raidgrp = {}
	function CheckRaidChanges()
		if GetNumRaidMembers() == 0 then return end	-- not in Raidgroup
		-- check if someone left the raid
		for k,v in pairs(raidgrp) do
			local inraid = false
			for i=1, GetNumRaidMembers(), 1 do
				if UnitName("raid"..i) then
					inraid = true
				end
			end
			if not inraid then
				SendChatMessage("<DBM> "..L.LeftRaidGroup, "WHISPER", nil, k)
				raidgrp[k] = nil
			end
		end

		-- check for new members
		for i=1, GetNumRaidMembers(), 1 do
			local name = UnitName("raid"..i)
			if raidgrp[name] == nil then				
				raidgrp[name] = true
				RemoveStandbyMember(name, true)	-- remove player from SB, because he join the raid
			end
		end

	end
end

do
	local function RegisterEvents(...)
		for i = 1, select("#", ...) do
			mainframe:RegisterEvent(select(i, ...))
		end
	end
	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			RegisterEvents(
				"CHAT_MSG_GUILD",
				"CHAT_MSG_RAID",
				"CHAT_MSG_PARTY",
				"CHAT_MSG_OFFICER",
				"CHAT_MSG_RAID_LEADER",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_ADDON",
				"RAID_ROSTER_UPDATE"
			)
	
		elseif event == "CHAT_MSG_WHISPER" then
			local msg, author = select(1, ...)
			if settings.enabled and inRaid and msg == "!sb" then
				AddStandbyMember(author)
			elseif settings.enabled and inRaid and msg == "!sb off" then
				RemoveStandbyMember(author)
			end
		end
			
		if event == "RAID_ROSTER_UPDATE" or event == "ADDON_LOADED" then
			if GetNumRaidMembers() >= 1 and not inRaid then
				inRaid = true
			elseif GetNumRaidMembers() == 0 and inRaid then
				inRaid = false
				SaveTimeHistory()
			end
			if inRaid then
				CheckRaidChanges()
			end
		end

		if event:sub(0, 9) == "CHAT_MSG_" and event ~= "CHAT_MSG_WHISPER" then
			local msg, author = select(1, ...)
			if msg == "!sb" then
				local output = ""
				for k,v in pairs(settings.sb_users) do
					output = output..", "..k
				end
				output = output:sub(2)
				if output == "" then output = "none" end
				SendChatMessage("<DBM> "..L.PostStandybyList.." "..output, "WHISPER", nil, author)
			elseif msg == "!sb time" then
				if #settings.sb_times then
					SendChatMessage(L.Current_StandbyTime:format(date(L.DateTimeFormat)), "GUILD")
					local users = ""
					local count = 0
					UpdateTimes()
					for k,v in pairs(settings.sb_times) do
						count = count + 1 
						local hours = math.floor(settings.sb_times[k]/60/60)
						local minutes = math.floor((settings.sb_times[k]-(hours*60*60))/60)
						users = users..k.."("..string.format("%02d", hours)..":"..string.format("%02d", minutes).."), "

						if count >= 3 then
							count = 0
							SendChatMessage(users:sub(0, -2), "GUILD")
							users = ""
						end
					end
					if count > 0 then
						SendChatMessage(users:sub(0, -2), "GUILD")
					end
				end

			elseif msg:find("^!sb add") then
				local name = strtrim(msg:sub(8))
				name = name:sub(0,1):upper()..name:sub(2):lower()
				AddStandbyMember(name)

			elseif msg:find("^!sb del") then
				local name = strtrim(msg:sub(8))
				name = name:sub(0,1):upper()..name:sub(2):lower()
				if not RemoveStandbyMember(name) then
					DBM:AddMsg(L.Local_CantRemove)
				end
			end

		end
	end)
	
	-- lets register the Events
	RegisterEvents("ADDON_LOADED")
end





