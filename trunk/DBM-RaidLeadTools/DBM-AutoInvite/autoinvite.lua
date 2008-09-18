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


L = {}
L.TabCategory_AutoInvite 	= "AutoInvite Tool"
L.AreaGeneral 			= "Gerneal Invite Options"
L.AllowGuildMates 		= "Allow AutoInvite from GuildMates"
L.AllowFriends 			= "Allow AutoInvite from Friends"
L.AllowOthers 			= "Allow AutoInvite from Everyone else"
L.Activate 			= "Enable Autoinvite by Keyword"
L.KeyWord 			= "Keyword to whisper for Invite"
L.InviteFailed 			= "Can't invite Player ->%s<- to Group"
L.ConvertRaid 			= "Converting group to Raid"
L.WhisperMsg_RaidIsFull 	= "Sorry, can't invite you. Raid is full."
L.WhisperMsg_NotLeader 		= "Sorry, can't invite you. I'm not the group Leader."

DBM_AutoInvite_Options = {
	active = true,
	keyword = 'invite',
	guildmates = true,
	friends = true,
	other = false,
}

local settings = DBM_AutoInvite_Options
local mainframe = CreateFrame("Frame", "DBM_AutoInvite", UIParent)

-- functions
local UpdateGuildList
local IsGuildMember
local UpdateFriendList
local IsFriend

do 
	local function toboolean(var) 
		if var then return true else return false end
	end

	local function creategui()
		local panel = DBM_GUI:CreateNewPanel(L.TabCategory_AutoInvite, "option")
		local area = panel:CreateArea(L.AreaGeneral, nil, 150, true)

		local enabled = area:CreateCheckButton(L.Activate, true)
		local guildmates = area:CreateCheckButton(L.AllowGuildMates, true)		
		local friends = area:CreateCheckButton(L.AllowFriends, true)		
		local other = area:CreateCheckButton(L.AllowOthers, true)		
		local keyword = area:CreateEditBox(L.KeyWord, settings.keyword, 200)		
		keyword:SetPoint('TOPLEFT', other, "BOTTOMLEFT", 10, -15)

		enabled:SetScript("OnClick", 		function(self) settings.enabled = toboolean(self:GetChecked()) end)
		guildmates:SetScript("OnClick", 	function(self) settings.guildmates = toboolean(self:GetChecked()) end)
		friends:SetScript("OnClick", 		function(self) settings.friends = toboolean(self:GetChecked()) end)
		other:SetScript("OnClick",		function(self) settings.other = toboolean(self:GetChecked()) end)
		keyword:SetScript("OnTextChanged", 	function(self) settings.keyword = self:GetText():lower() end)
	end
	--DBM:CallFuncOnLoad("GUI", creategui)
end

do
	local GuildMates = {}
	function UpdateGuildList()
		for i=#GuildMates, 1, -1 do GuildMates[i] = nil end
		for i=1, GetNumGuildMembers(), 1 do
			table.insert(GuildMates, GetGuildRosterInfo(i))
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
end	


do
	local function IsFriend(name)
		for i=1, GetNumFriends(), 1 do
			if GetFriendInfo(i) == name then
				return true
			end
		end
		return false
	end

	local function DoInvite(name)
		pplcount = GetNumRaidMembers();
		if pplcount == 0 then 
			if not IsPartyLeader() then
				DBM:AddMsg( L.InviteFailed:format(name) )
			else
				pplcount = GetNumPartyMembers();
				if numparty < 5 then
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
		if settings.enabled and msg and msg:lower() == setting.keyword then
			local doautoinvite = false
			if settings.guildmates and IsGuildMember(name) then	doautoinvite = true	
			elseif settings.friends and IsFriend(name) then		doautoinvite = true
			elseif settings.other then				doautoinvite = true
			end
			if doautoinvite then DoInvite(name) end
		end
	end

	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			mainframe:RegisterEvent("CHAT_MSG_WHISPER")
		
		elseif event == "CHAT_MSG_WHISPER" then
			OnMsgRecived(select(1, ...), select(2, ...))
		end
	end)
	
	-- lets register the Events
	mainframe:RegisterEvent("ADDON_LOADED")
end








