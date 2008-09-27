-- **********************************************************
-- **             Deadly Boss Mods - AutoInvite            **
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

local L = DBM_AutoInvite_Translations

DBM_AutoInvite_Options = {
	enabled = true,
	keyword = 'invite',
	guildmates = true,
	friends = true,
	other = false,
}

local settings = DBM_AutoInvite_Options
local mainframe = CreateFrame("Frame", "DBM_AutoInvite", UIParent)

-- functions for local scope
local UpdateGuildList
local IsGuildMember
local AOE_Ginvite
local UpdateFriendList
local IsFriend
local DoInvite
local slashfunction


function slashfunction()
	if GetNumRaidMembers() == 0 then
		DBM:AddMsg(L.WarnMsg_NoRaid)
	elseif not (IsRaidLeader() or IsRaidOfficer()) then
		DBM:AddMsg(L.WarnMsg_NotLead)
	else
		SendChatMessage(L.WarnMsg_InviteIncoming, "GUILD")
		GuildRoster()
		DBM:Schedule(10, AOE_Ginvite)
	end
end

do 
	local function toboolean(var) 
		if var then return true else return false end
	end

	local function creategui()
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_AutoInvite, "option")
		local area = panel:CreateArea(L.AreaGeneral, nil, 160, true)

		local enabled = area:CreateCheckButton(L.Activate, true)
		local guildmates = area:CreateCheckButton(L.AllowGuildMates, true)		
		local friends = area:CreateCheckButton(L.AllowFriends, true)		
		local other = area:CreateCheckButton(L.AllowOthers, true)		
		local keyword = area:CreateEditBox(L.KeyWord, settings.keyword, 200)		
		keyword:SetPoint('TOPLEFT', other, "BOTTOMLEFT", 15, -15)

		local aoeinv = area:CreateButton(L.Button_AOE_Invite, 150)
		aoeinv:SetPoint("TOPLEFT", keyword, "TOPRIGHT", 15, 0)
		aoeinv:SetScript("OnClick", slashfunction)

		enabled:SetScript("OnClick", 		function(self) settings.enabled = toboolean(self:GetChecked()) end)
		enabled:SetScript("OnShow", 		function(self) self:SetChecked(settings.enabled) end)
		guildmates:SetScript("OnClick", 	function(self) settings.guildmates = toboolean(self:GetChecked()) end)
		guildmates:SetScript("OnShow", 		function(self) self:SetChecked(settings.guildmates) end)
		friends:SetScript("OnClick", 		function(self) settings.friends = toboolean(self:GetChecked()) end)
		friends:SetScript("OnShow", 		function(self) self:SetChecked(settings.friends) end)
		other:SetScript("OnClick",		function(self) settings.other = toboolean(self:GetChecked()) end)
		other:SetScript("OnShow", 		function(self) self:SetChecked(settings.other) end)
		keyword:SetScript("OnTextChanged", 	function(self) settings.keyword = self:GetText():lower() end)
		keyword:SetScript("OnShow", 		function(self) self:SetText(settings.keyword) end)
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 15)
end

do
	local GuildMates = {}
	function UpdateGuildList()
		local name
		for i=#GuildMates, 1, -1 do GuildMates[i] = nil end
		for i=1, GetNumGuildMembers(), 1 do
			name = GetGuildRosterInfo(i)
			table.insert(GuildMates, name)
		end
	end
	function IsGuildMember(name)
		for _,v in pairs(GuildMates) do
			if v == name then
				return true
			end
		end
		return false
	end	
	function AOE_Ginvite()
		for _,v in pairs(GuildMates) do
			DoInvite(v)
		end
	end
end

do
	local waitinginvites = {}
	local function IsFriend(name)
		for i=1, GetNumFriends(), 1 do
			if GetFriendInfo(i) == name then
				return true
			end
		end
		return false
	end

	function DoInvite(name)
		pplcount = GetNumRaidMembers();
		if pplcount == 0 then
			pplcount = GetNumPartyMembers() or 0
			if pplcount > 0 and not IsPartyLeader() then
				DBM:AddMsg( L.InviteFailed:format(name) )
			else
				if pplcount < 5 then
					InviteUnit(name)

				elseif pplcount == 5 then
					DBM:AddMsg( L.ConvertRaid )
					ConvertToRaid()
					InviteUnit(name)
				end
			end
		elseif (IsRaidLeader() or IsRaidOfficer()) and pplcount < 40 then 
			InviteUnit(name)
		elseif not (IsRaidLeader() or IsRaidOfficer()) then
			SendChatMessage("<DBM>"..L.WhisperMsg_NotLeader, "WHISPER", nil, name)
		elseif pplcount >=40 then
			SendChatMessage("<DBM>"..L.WhisperMsg_RaidIsFull, "WHISPER", nil, name)
		end
	end

	local function OnMsgRecived(msg, name)
		if settings.enabled and msg:lower() == settings.keyword then
			local doautoinvite = false
	
			if settings.friends and IsFriend(name) then		doautoinvite = true
			elseif settings.other then				doautoinvite = true
			elseif settings.guildmates then	
				table.insert(waitinginvites, name)
				GuildRoster()
			end
			if doautoinvite then DoInvite(name) end
		end
	end

	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			self:RegisterEvent("CHAT_MSG_WHISPER")
			self:RegisterEvent("GUILD_ROSTER_UPDATE")

		
		elseif event == "CHAT_MSG_WHISPER" then
			OnMsgRecived(select(1, ...), select(2, ...))

		elseif event == "GUILD_ROSTER_UPDATE" then
			UpdateGuildList()
			for i=#waitinginvites, 1, -1 do
				if IsGuildMember(waitinginvites[i]) then
					DoInvite(waitinginvites[i])
				end
				waitinginvites[i] = nil
			end
		end
	end)
	
	-- lets register the Events
	mainframe:RegisterEvent("ADDON_LOADED")
end


SLASH_DBMAUTOINVITE1 = "/inviteguild"
SlashCmdList["DBMAUTOINVITE"] = slashfunction 






