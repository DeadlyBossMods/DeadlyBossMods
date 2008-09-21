-- **********************************************************
-- **                Deadly Boss Mods - BidBot             **
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

DBM_BidBot_Settings = {
	enabled = true,			-- BidBot ein/aus
	chatchannel = "GUILD",		-- Ausgabe channel
	minGebot = 10,			-- Mindest Gebot
	duration = 15,			-- Laufzeit einer auction
	output = 4,			-- max. Menge der ausgegebenen Gebote
	bidtyp_open = false,		-- post each Bid in the Raidchan
	bidtyp_payall = false,		-- pay the price you bid
}
local settings = DBM_BidBot_Settings
local L = DBM_BidBot_Translations

local BidBot_Queue = {}			-- items pending
local BidBot_Biddings = {}		-- current bids
local BidBot_InProgress = false		-- true when an auction is running
local BidBot_CurrentItem		-- item that currently run

-- Functions
local AddItem
local AddBid
local AuctionEnd
local StartBidding

do 
	local function toboolean(var) 
		if var then return true else return false end
	end

	local function creategui()
		local panel = DBM_GUI:CreateNewPanel(L.TabCategory_BidBot, "option")
		local area = panel:CreateArea(L.AreaGeneral, nil, 250, true)

		local enabled 		= area:CreateCheckButton(L.Enable, true)
		local bidtyp_open	= area:CreateCheckButton(L.PublicBids, true)
		local bidtyp_payall	= area:CreateCheckButton(L.PayWhatYouBid, true)
		local chatchannel 	= area:CreateDropdown(L.ChatChannel, 
			{{text=L.Guild,value="GUILD"},{text=L.Raid,value="RAID"},{text=L.Party,value="PARTY"}}, 
			settings.chatchannel,
			function(value) settings.chatchannel = value end
		)
		local minGebot	 	= area:CreateEditBox(L.MinBid, settings.keyword, 100)
		local duration		= area:CreateEditBox(L.Duration, settings.keyword, 100)
		local output 		= area:CreateEditBox(L.OutputBids, settings.keyword, 100)
		
		chatchannel:SetPoint("TOPLEFT", bidtyp_payall, "BOTTOMLEFT", 0, -10)
		minGebot:SetPoint("TOPLEFT", chatchannel, "BOTTOMLEFT", 30, -15)
		duration:SetPoint("TOPLEFT", minGebot, "BOTTOMLEFT", 0, -20)
		output:SetPoint("TOPLEFT", duration, "BOTTOMLEFT", 0, -20)

		minGebot:SetNumeric()
		duration:SetNumeric()
		output:SetNumeric()

		enabled:SetScript("OnClick", 		function(self) settings.enabled = toboolean(self:GetChecked()) end)
		enabled:SetScript("OnShow", 		function(self) self:SetChecked(settings.enabled) end)
		bidtyp_open:SetScript("OnClick", 	function(self) settings.bidtyp_open = toboolean(self:GetChecked()) end)
		bidtyp_open:SetScript("OnShow", 	function(self) self:SetChecked(settings.bidtyp_open) end)
		bidtyp_payall:SetScript("OnClick",	function(self) settings.bidtyp_payall = toboolean(self:GetChecked()) end)
		bidtyp_payall:SetScript("OnShow", 	function(self) self:SetChecked(settings.bidtyp_payall) end)
		minGebot:SetScript("OnTextChanged", 	function(self) settings.minGebot = self:GetNumber() end)
		minGebot:SetScript("OnShow", 		function(self) self:SetText(settings.minGebot) end)
		duration:SetScript("OnTextChanged", 	function(self) settings.duration = self:GetNumber() end)
		duration:SetScript("OnShow", 		function(self) self:SetText(settings.duration) end)
		output:SetScript("OnTextChanged", 	function(self) settings.output = self:GetNumber() end)
		output:SetScript("OnShow", 		function(self) self:SetText(settings.output) end)
	end
	DBM:RegisterOnGuiLoadCallback(creategui, 11)
end



function AddItem(ItemLink)
	local newID = select(4, string.find(ItemLink, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r"))
	for k, v in pairs(BidBot_Queue) do
		if newID == select(4, string.find(v, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r")) then
			return
		end
	end
	table.insert(BidBot_Queue, ItemLink)
end

function AddBid(bidder, bid)
	for k,v in pairs(BidBot_Biddings) do	-- don't create double entrys
		if v.Name == bidder then
			BidBot_Biddings[k] = nil
		end
	end
	table.insert(BidBot_Biddings, {
		["Name"] = bidder,
		["Bid"] = bid
	})
	SendChatMessage("<DBM> "..L.Prefix..L.Whisper_Bid_OK:format(bid), "WHISPER", nil, bidder)
end

function AuctionEnd()
	BidBot_InProgress = false
	local Itembid = {
		time = time(), 
		item = BidBot_CurrentItem, 
		points = 0, 
		member = "", 
		bids = {} 
	}

	if (BidBot_Biddings[1] and BidBot_Biddings[2]) then
		table.sort(BidBot_Biddings, function(a,b) return a.Bid > b.Bid end)
		Itembid.points = BidBot_Biddings[2]["Bid"] + 1
		Itembid.member = BidBot_Biddings[1]["Name"]
		SendChatMessage(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, Itembid.points, BidBot_Biddings[1]["Name"]), settings.chatchannel);

	elseif (BidBot_Biddings[1]) then
		Itembid.points = settings.minGebot
		Itembid.member = BidBot_Biddings[1]["Name"]
		SendChatMessage(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, Itembid.points, BidBot_Biddings[1]["Name"]), settings.chatchannel);
	else
		Itembid.member = L.Disenchant
		SendChatMessage(L.Prefix..L.Message_NoBidMade:format(Itembid.item), settings.chatchannel);
	end

	local counter = 0
	local max = false

	for posi, werte in pairs(BidBot_Biddings) do
	   counter = counter + 1

	   table.insert(Itembid.bids, {
		["points"] = werte.Bid,
		["name"] = werte.Name
	   })

	   if posi <= settings.output then
		SendChatMessage(L.Prefix..L.Message_Biddings:format(posi, werte.Name, werte.Bid), settings.chatchannel)
	   else
		max = true
	   end

	end
	
	if max then
		SendChatMessage(L.Prefix..L.Message_BiddingsVisible:format(settings.output, counter), settings.chatchannel)
	end

	BidBot_CurrentItem = ""
	for i=select("#", BidBot_Biddings), 1, -1 do BidBot_Biddings[i] = nil end	-- cleanup table
	if #BidBot_Queue then
		-- Shedule next Item
		SendChatMessage("--- --- --- --- ---", settings.chatchannel)
		DBM:Schedule(1.5, StartBidding)
	end
end	

function StartBidding()
	if BidBot_InProgress then
		self:Print(L.Prefix..L.Whisper_InUse:format(CurrentItem)  )
	else
		local ItemLink = false
		if BidBot_Queue[1] then
			ItemLink = table.remove(BidBot_Queue)
		end

		if ItemLink == false then
			return
		end

		BidBot_InProgress = true
		BidBot_CurrentItem = ItemLink
		for i=select("#", BidBot_Biddings), 1, -1 do BidBot_Biddings[i] = nil end

		SendChatMessage(L.Prefix..L.Message_StartBidding:format(ItemLink, UnitName("player"), settings.minGebot), settings.chatchannel);
		SendChatMessage(L.Prefix..L.Message_DoBidding:format(ItemLink, settings.duration), settings.chatchannel);
		
		DBM:Schedule((settings.duration / 6) * 5, function() 
			SendChatMessage(L.Prefix..L.Message_DoBidding:format(ItemLink, math.floor(settings.duration / 6)), settings.chatchannel)
			end)
		DBM:Schedule(settings.duration / 2, function() 
			SendChatMessage(L.Prefix..L.Message_DoBidding:format(ItemLink, math.floor(settings.duration / 2)), settings.chatchannel)
			end)
		DBM:Schedule(settings.duration, AuctionEnd)
	end
end

do 
	local function OnMsgRecived(msg, name)
		if settings.enabled and msg and string.find(string.lower(msg), "^!bid ") then
			local ItemLink			
			ItemLink = string.gsub(msg, "^!(%w+) ", "")			
			if string.find(ItemLink, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r") then
			   for link in string.gmatch(ItemLink, "(|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r)") do
				AddItem(link)
			   end
			   if BidBot_InProgress then
				SendChatMessage("<DBM>"..L.Prefix..L.Whisper_Queue, "WHISPER", nil, name)
			   else
				DBM:Schedule(1.5, StartBidding)
			   end
			end
			return true
		end
		return false
	end
	
	local BidBot_Frame = CreateFrame("Frame", "DBM_BidBotFrame", UIParent)
	local function RegisterEvents(...)
		for i = 1, select("#", ...) do
			BidBot_Frame:RegisterEvent(select(i, ...))
		end
	end
	BidBot_Frame:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			RegisterEvents(
				"CHAT_MSG_GUILD",
				"CHAT_MSG_RAID",
				"CHAT_MSG_SAY",
				"CHAT_MSG_PARTY",
				"CHAT_MSG_OFFICER",
				"CHAT_MSG_RAID_LEADER",
				"CHAT_MSG_WHISPER"
			)
	
			if DBM_BidBot_Translations[GetLocale()] then 
				L = DBM_BidBot_Translations[GetLocale()]
			end
		elseif event == "CHAT_MSG_WHISPER" then
			if tostring(tonumber(arg1)) == tostring(arg1) then
				-- here is a bid
				AddBid(arg2, tonumber(arg1))
			end

		elseif event:sub(0, 9) == "CHAT_MSG_" then
			OnMsgRecived(select(1, ...), select(2, ...))
		end
	end)
	
	-- lets register the Events
	RegisterEvents("ADDON_LOADED")
end	

