-- **********************************************************
-- **             Deadly Boss Mods - AutoTurnIn            **
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
	enable_runecloth = true,	-- flag 1
	enable_alterac = true,		-- flag 2
}

DBM_AutoTurnIn = {}
local settings = default_setting

local L = DBM_AutoturnIn_Translations


local quests = {
	[8371] = "Concerted Efforts",
	[7796] = L.Quest_RuneCloth,	-- Alliance: Stormwind City
	[7801] = L.Quest_RuneCloth,	-- Alliance: Darnassus
	[7806] = L.Quest_RuneCloth,	-- Alliance: Ironforge
	[7812] = L.Quest_RuneCloth,	-- Alliance: Gnomeregan Exiles
	[10358] = L.Quest_RuneCloth,	-- Alliance: Exodar
	[7819] = L.Quest_RuneCloth,	-- Horde: Undercity
	[7825] = L.Quest_RuneCloth,	-- Horde: Thunder Bluff
	[7832] = L.Quest_RuneCloth,	-- Horde: Ogrimmar
	[7837] = L.Quest_RuneCloth,	-- Horde: Darkspear Trolls
	[10363] = L.Quest_RuneCloth,	-- Horde: Silvermoon City
	
	-- AV Quests
	[6881] = "Ivus the Forest Lord",
	[7386] = "Crystal Cluster",	
	[13257] = "More Armor Scraps",
	[7026] = "Ram Riding Harnesses", 
	[6943] = "Call of Air - Ichman's Fleet",
	[6941] = "Call of Air - Vipore's Fleet",
	[6942] = "Call of Air - Slidore's Fleet",

	[6801] = "Lokholar the Ice Lord",
	[7385] = "A Gallon of Blood",
	[7224] = "Enemy Booty",
	[7002] = "Ram Hide Harnesses",
	[6826] = "Call of Air - Jeztor's Fleet",
	[6825] = "Call of Air - Guse's Fleet",
	[6827] = "Call of Air - Mulverick's Fleet",
}

local autoturnin_quests = {
	--{ npc = 15351, quest = 8371, items = { {20560, 1}, {20559, 1}, {20558, 1}, {29024, 1}} },		-- PVP Marken
	{ npc = 14722, f=1, quest = 7796, items = { {14047, 20} } }, 						-- Alliance: Stormwind City RuneCloth
	{ npc = 14725, f=1, quest = 7801, items = { {14047, 20} } },						-- Alliance: Darnassus RuneCloth
	{ npc = 14723, f=1, quest = 7806, items = { {14047, 20} } },						-- Alliance: Ironforge
	{ npc = 14724, f=1, quest = 7812, items = { {14047, 20} } },						-- Alliance: Gnomeregan Exiles
	{ npc = 20604, f=1, quest =10358, items = { {14047, 20} } }, 						-- Alliance: Exodar
	{ npc = 14729, f=1, quest = 7819, items = { {14047, 20} } }, 						-- Horde: Undercity
	{ npc = 14728, f=1, quest = 7825, items = { {14047, 20} } }, 						-- Horde: Thunder Bluff
	{ npc = 14726, f=1, quest = 7832, items = { {14047, 20} } }, 						-- Horde: Ogrimmar
	{ npc = 14727, f=1, quest = 7837, items = { {14047, 20} } }, 						-- Horde: Darkspear Trolls
	{ npc = 20612, f=1, quest =10363, items = { {14047, 20} } }, 						-- Horde: Silvermoon City
	-- AV Quests (Alliance)
	{ npc = 13442, f=2, quest = 7386, items = { {17423, 5}} },						-- AV: Crystal Cluster
	{ npc = 13442, f=2, quest = 6881, item = 17423 },							-- AV: Ivus the Forest Lord
	{ npc = 13257, f=2, quest = 6781, items = { {17422, 20}} },						-- AV: Armor Scraps
	{ npc = 13577, f=2, quest = 7026, item = 17643 },							-- AV: Frostwolf Hides
	{ npc = 13438, f=2, quest = 6942, item = 17502 },							-- AV: Call of Air - Slidore's Fleet
	{ npc = 13439, f=2, quest = 6941, item = 17503 },							-- AV: Call of Air - Vipore's Fleet
	{ npc = 13437, f=2, quest = 6943, item = 17504 },							-- AV: Call of Air - Ichman's Fleet
	-- AV Quests (Horde)
	{ npc = 13236, f=2, quest = 7385, items = { {17306, 5}} },						-- AV: A Gallon of Blood
	{ npc = 13236, f=2, quest = 6801, item = 17306 },							-- AV: Lokholar the Ice Lord
	{ npc = 13176, f=2, quest = 7224, items = { {17422, 20}} },						-- AV: Enemy Booty
	{ npc = 13441, f=2, quest = 7002, item = 17642 },							-- AV: Ram Hides
	{ npc = 13179, f=2, quest = 6825, item = 17326 },							-- AV: Call of Air - Guse's Fleet
	{ npc = 13180, f=2, quest = 6826, item = 17327 },							-- AV: Call of Air - Jeztor's Fleet
	{ npc = 13181, f=2, quest = 6827, item = 17328 },							-- AV: Call of Air - Mulverick's Fleet
}

do 

	local function checkboxevent(eventtyp, skey)
		return function(self)
			if eventtyp == "OnClick" then
				settings[skey] =  not not self:GetChecked()
			else
				self:SetChecked( (settings and settings[skey] or false) )
			end
		end
	end

	local function creategui()
		local panel = DBM_GUI:CreateNewPanel(L.TabCategory_AutoTurnIn, "option")
		do
			local area = panel:CreateArea(L.AreaGeneral, nil, 100, true)
			local enabled = area:CreateCheckButton(L.Enable, true)
			enabled:SetScript("OnShow", function(self) self:SetChecked(settings.enabled) end)
			enabled:SetScript("OnClick", function(self) settings.enabled = not not self:GetChecked() end)

			local ptext = panel:CreateText(L.HelpMe, nil, nil, GameFontHighlightSmall, "LEFT")
			ptext:ClearAllPoints()
			ptext:SetPoint('TOPLEFT', area.frame, "TOPLEFT", 20, -40)
			ptext:SetPoint('BOTTOMRIGHT', area.frame, "BOTTOMRIGHT", -20, 10)			
		end
		do
			local area = panel:CreateArea(L.AreaModules, nil, 100, true)
			local checkbox = area:CreateCheckButton(L.Enable_RuneCloth, true)
			checkbox:SetScript("OnShow", checkboxevent("OnShow", "enable_runecloth"))
			checkbox:SetScript("OnClick", checkboxevent("OnClick", "enable_runecloth"))

			local checkbox = area:CreateCheckButton(L.Enable_Alterac, true)
			checkbox:SetScript("OnShow", checkboxevent("OnShow", "enable_alterac"))
			checkbox:SetScript("OnClick", checkboxevent("OnClick", "enable_alterac"))
		
		end
		panel:SetMyOwnHeight()
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 22)
end



local function GetNPCid()
	local guid = UnitGUID("target")
	if not guid then return 0 end
	return tonumber(guid:sub(9, 12), 16)
end

local function GetItemID(itemlink)
	if not itemlink then return 0 end
	local itemid = 0
	if string.match(itemlink, "^(|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r)$") then
		itemid = select(2, strsplit(":", itemlink))
		itemid = tonumber(itemid)
	elseif string.match(itemlink, "^(%d+)$") then
		itemid = tonumber(itemlink)
	end
	return itemid
end

local function searchbag(bagid, itemid)
	local count = 0
	for i=1, GetContainerNumSlots(bagid), 1 do
		local bagitem = GetItemID(GetContainerItemLink(bagid, i))
		if bagitem == itemid then
			count = count + select(2, GetContainerItemInfo(bagid, i))
		end
	end
	return count
end

local function searchinventory(item)
	local itemid = type(item)=="number" and item or GetItemID(item)  
	local count = 0
	-- ring bag
	count = count + searchbag(-2, itemid)
	-- backpack + 4 bags
	for i=0, NUM_BAG_SLOTS, 1 do
		count = count + searchbag(i, itemid)
	end
	return count
end

do
	local function flagcheck(flag) 
		    if flag == 1 and settings.enable_runecloth then return true
		elseif flag == 2 and settings.enable_alterac then return true
		else return false
		end
	end
	local function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if t1[i] == nil then
				t1[i] = v
			elseif type(v) == "table" then
				addDefaultOptions(v, t2[i])
			end
		end
	end
	local onquest = 0
	local npc = 0
	local autostep = false

	local mainframe = CreateFrame("frame", "DBM_AutoTurnIn", UIParent)
	mainframe:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-AutoTurnIn" then
			settings = DBM_AutoTurnIn
			addDefaultOptions(settings, default_settings)

			self:RegisterEvent("GOSSIP_SHOW")
			self:RegisterEvent("QUEST_PROGRESS")
			self:RegisterEvent("QUEST_COMPLETE")

		elseif settings.enabled and event == "GOSSIP_SHOW" then
			autostep = false
			npc = GetNPCid()
			for k,v in pairs(autoturnin_quests) do
				if v.npc == npc and quests[v.quest] then	-- Got a match, try to get that quest
					if flagcheck(v.f) then			-- check for "enabled" option
						local count = select("#", GetGossipAvailableQuests())
						for i=1, count, 3 do
							if select(i, GetGossipAvailableQuests()) == quests[v.quest] then
								onquest = v.quest
								local gotall = true
								if v.item then
									if 1 > searchinventory(v.item) then
										gotall = false
									end
								else
									for _, reqitem in pairs(v.items) do
										if reqitem[2] > searchinventory(reqitem[1]) then
											gotall = false
										end
									end
								end
								if gotall then
									autostep = true
									SelectGossipAvailableQuest(i)
									return true
								end
							end
						end
					end
				end
			end

		elseif settings.enabled and event == "QUEST_PROGRESS" and autostep then
			CompleteQuest()

		elseif settings.enabled and event == "QUEST_COMPLETE" and autostep then
			GetQuestReward(0)
			autostep = false
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")	
end




