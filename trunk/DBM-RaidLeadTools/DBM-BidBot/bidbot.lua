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
	enabled = false,		-- BidBot ein/aus
	chatchannel = "GUILD",		-- Ausgabe channel
	minGebot = 10,			-- Mindest Gebot
	duration = 30,			-- Laufzeit einer auction
	output = 4,			-- max. Menge der ausgegebenen Gebote
}
local settings = DBM_BidBot_Settings
local L = DBM_BidBot_Translations
DBM_BidBot = {}
DBM_BidBot.Queue = {}
DBM_BidBot.Frame = CreateFrame("Frame", "DBM_BidBotFrame", UIParent)
DBM_BidBot.Frame:SetScript("OnEvent", self.OnEvent)
DBM_BidBot.Frame:Show()
DBM_BidBot.InProgress = false
DBM_BidBot.CurrentItem = ""
DBM_BidBot.Bidders = {}

function DBM_BidBot:OnEvent(event, ...)
	if event == "ADDON_LOADED" then
		self:RegisterEvents(
			"CHAT_MSG_GUILD",
			"CHAT_MSG_RAID",
			"CHAT_MSG_PARTY",
			"CHAT_MSG_OFFICER",
			"CHAT_MSG_RAID_LEADER",
			"CHAT_MSG_WHISPER",
		)

		if DBM_BidBot_Translations[GetLocale()] then 
			L = DBM_BidBot_Translations[GetLocale()]
		end

	elseif event:sub(0, 9) == "CHAT_MSG_" then
		local chatmsg, from = select(1, ...)
		self:OnMsgRecived(chatmsg, from)
	end
end

function DBM_BidBot:RegisterEvents(...)
	for i = 1, select("#", ...) do
		self.Frame:RegisterEvent(select(i, ...))
	end
end

-- lets register the Events
DBM_BidBot:RegisterEvents("ADDON_LOADED")


function DBM_BidBot:OnMsgRecived(msg, name)
	if settings.enabled and msg and string.find(string.lower(msg), "^!bid ") then
		local ItemLink			
		ItemLink = string.gsub(msg, "^!(%w+) ", "")			
		if string.find(ItemLink, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r") then
		   for link in string.gmatch(ItemLink, "(|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r)") do
			self:AddItem(link)
		   end
		   if self.InProgress then
			SendChatMessage("<DBM>"..L.Prefix..L.Whisper_Queue, "WHISPER", nil, name)
		   else
			DBM:Schedule(1.5, self.StartBidding)
		   end
		end
		return true
	end
	return false
end

function DBM_BidBot:TranslateLink(link)  -- try to translate link to englisch name
	if not GetLocale() == "enGB" or GetLocale() == "enUS" then return link end

	local ItemLink = select(2, GetItemInfo(link) )
	return ItemLink
end


function DBM_BidBot:AddItem(ItemLink)
	local newID
	local thisID
	_, _, _, newID = string.find(ItemLink, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r")

	for k, v in pairs(self.Queue) do
		_, _, _, thisID = string.find(v, "|c(%x+)|Hitem:(.-)|h%[(.-)%]|h|r")
		if newID == thisID then
			return
		end
	end

	table.insert(self.Queue,ItemLink)
end

function DBM_BidBot:GetNextItem()
	if self.Queue[1] then
		return table.remove(self.Quene)
	else
		return false
	end
end

function  DBM_BidBot:SortTable(a, b)
	return a.Bid > b.Bid;
end

function DBM_BidBot:AddBid(Name, Gebot)
	table.insert(self.Bidders, {
		["Name"] = Name,
		["Bid"] = Gebot
	})
	SendChatMessage(L.Prefix..L.Whisper_Bid_OK:format(Gebot), "WHISPER", nil, Name)
end


function DBM_BidBot:StartBidding()
	if self.InProgress then
		self:Print(L.Prefix..L.Whisper_InUse:format(self.CurrentItem)  )

	else
		local ItemLink = self:GetNextItem()
		if ItemLink == false then
			return
		end

		if self:TranslateLink(ItemLink) then
			ItemLink = self:TranslateLink(ItemLink);
		end
		self.InProgress = true
		self.CurrentItem = ItemLink
		self.Bidders = {}

		SendChatMessage(L.Prefix..L.Message_StartBidding:format(ItemLink, UnitName("player"), settings.minGebot), settings.chatchannel);
		SendChatMessage(L.Prefix..L.Message_DoBidding:format(ItemLink, settings.Duration), settings.chatchannel);
		
		DBM:Schedule((settings.Duration / 6) * 5, function() 
			SendChatMessage(L.Prefix..L.Message_DoBidding:format(ItemLink, math.floor(settings.Duration / 6)), settings.chatchannel)
			end)
		DBM:Schedule(settings.Duration / 2, function() 
			SendChatMessage(L.Prefix..L.Message_DoBidding:format(ItemLink, math.floor(settings.Duration / 2)), settings.chatchannel)
			end)
		DBM:Schedule(settings.Duration, self.AuctionEnd)
	end
end

function DBM_BidBot:AuctionEnd()
	self.InProgress = false
	local Itembid = {
		time = time(), 
		item = self.CurrentItem, 
		points = 0, 
		member = "", 
		bids = {} 
	}

	if (self.Bidders[1] and self.Bidders[2]) then
		table.sort(self.Bidders, function(a,b) return a.Bid > b.Bid end)
		Itembid.points = self.Bidders[2]["Bid"] + 1
		Itembid.member = self.Bidders[1]["Name"]
		SendChatMessage(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, Itembid.points, self.Bidders[1]["Name"]), settings.chatchannel);

	elseif (self.Bidders[1]) then
		Itembid.points = settings.minGebot
		Itembid.member = self.Bidders[1]["Name"]
		SendChatMessage(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, Itembid.points, self.Bidders[1]["Name"]), settings.chatchannel);
	else
		Itembid.member = L.Disenchant
		SendChatMessage(L.Prefix..L.Message_NoBidMade:format(Itembid.item), settings.chatchannel);
	end

	local counter = 0
	local max = false

	for posi, werte in pairs(self.Bidders) do
	   counter = counter + 1

	   Itembid.bids[tonumber(posi)] = {
		["points"] = werte.Bid,
		["name"] = werte.Name
	   }

	   if posi <= DKPCDB.BidBot.output then
		SendChatMessage(L.Prefix..L.Message_Biddings:format(posi, werte.name, werte.Bid), settings.chatchannel)
	   else
		max = true
	   end

	end
	
	if max then
		SendChatMessage(L.Prefix..L.Message_BiddingsVisible:format(settings.output, counter), settings.chatchannel)
	end

	self.CurrentItem = ""
	self.Bidders = {}
	if #self.Queue then
		-- Shedule next Item
		SendChatMessage("--- --- --- --- ---", settings.chatchannel)
		DBM:Schedule(1.5, self.StartBidding)
	end
end	

