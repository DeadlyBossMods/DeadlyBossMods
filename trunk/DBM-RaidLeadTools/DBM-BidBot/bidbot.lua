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

DBM_BidBot_ItemHistory = {}		-- ItemHistory

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
local DoInjectToDKPSystem

do 
	local function toboolean(var) 
		if var then return true else return false end
	end

	local function creategui()
		local panel = DBM_RaidLeadPanel:CreateNewPanel(L.TabCategory_BidBot, "option")
		do
			local area = panel:CreateArea(L.AreaGeneral, nil, 260, true)
	
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
		do	
			local area = panel:CreateArea(L.AreaItemHistory, nil, 260, true)

			local history = area:CreateScrollingMessageFrame(area.frame:GetWidth()-40, 220)
			history:SetPoint("TOPLEFT", area.frame, "TOPLEFT", 10, -10)

			history:SetScript("OnShow", function(self)
				if #DBM_BidBot_ItemHistory > 0 then
					self:SetMaxLines(#DBM_BidBot_ItemHistory+1)
					for k,itembid in pairs(DBM_BidBot_ItemHistory) do
						local mytext = "["..date(L.DateFormat, itembid.time).."]: "..itembid.item.." "..itembid.points.." DKP --> "
						for k,v in pairs(itembid.bids) do
							mytext = mytext..k..". "..v.name.."("..v.points..") "
						end
						self:AddMessage(mytext)
					end
				end
			end)
--[[
			local text = area:CreateText(L.NoHistoryAvailable, area.frame:GetWidth()-40, true, GameFontNormalSmall, "LEFT")
			area.frame:SetScript("OnShow", function(self)
				local mytext = ""
				for i=#DBM_BidBot_ItemHistory, 1, -1 do	-- reverse order, last is newest
					local itembid = DBM_BidBot_ItemHistory[i]
					mytext = mytext.."["..date(L.DateFormat, itembid.time).."]: "..itembid.item.." "..itembid.points.." DKP \n     ---> "
					for k,v in pairs(itembid.bids) do
						mytext = mytext..k..". "..v.name.."("..v.points..") "
					end
					mytext = mytext.."\n"
				end
				if mytext ~= "" then
					text:SetText(mytext)
				end
			end)
--]]
		end
		panel:SetMyOwnHeight()
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
	if settings.bidtyp_open then
		SendChatMessage(L.Prefix..L.Message_BidPubMessage:format(bidder, bid), settings.chatchannel)
	else
		SendChatMessage("<DBM> "..L.Prefix..L.Whisper_Bid_OK:format(bid), "WHISPER", nil, bidder)
	end
end

function AuctionEnd()
	BidBot_InProgress = false
	local Itembid = {
		time = time(), 
		item = BidBot_CurrentItem, 
		points = 0, 
		bids = {} 
	}

	if (BidBot_Biddings[1] and BidBot_Biddings[2]) then
		table.sort(BidBot_Biddings, function(a,b) return a.Bid > b.Bid end)
		if settings.bidtyp_payall then
			Itembid.points = BidBot_Biddings[1]["Bid"]
		else
			Itembid.points = BidBot_Biddings[2]["Bid"] + 1
		end
		SendChatMessage(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, BidBot_Biddings[1]["Name"], Itembid.points), settings.chatchannel)

	elseif (BidBot_Biddings[1]) then
		if settings.bidtyp_payall then
			Itembid.points = BidBot_Biddings[1]["Bid"]
		else
			Itembid.points = settings.minGebot
		end
		SendChatMessage(L.Prefix..L.Message_ItemGoesTo:format(Itembid.item, BidBot_Biddings[1]["Name"], Itembid.points), settings.chatchannel);
	else
		SendChatMessage(L.Prefix..L.Message_NoBidMade:format(Itembid.item), settings.chatchannel);
	end

	local counter = 0
	local max = false
	local msg = ""

	for posi, werte in pairs(BidBot_Biddings) do
	   counter = counter + 1

	   table.insert(Itembid.bids, {
		["points"] = werte.Bid,
		["name"] = werte.Name
	   })
	   msg = msg..werte.Name.."("..werte.Bid..")"

	   if posi <= settings.output then
		SendChatMessage(L.Prefix..L.Message_Biddings:format(posi, werte.Name, werte.Bid), settings.chatchannel)
	   elseif not max then
		max = true
	   end
	end
	table.insert(DBM_BidBot_ItemHistory, Itembid)

	if counter > 0 then
		DoInjectToDKPSystem(Itembid)
	end

	-- Sync History
	SendAddonMessage("DBM_BidBot", "ITEM:"..select(2, strsplit(":", Itembid.item))..":"..Itembid.points..":("..msg..")", "RAID")
	SendAddonMessage("DBM_BidBot", "ITEM:"..select(2, strsplit(":", Itembid.item))..":"..Itembid.points..":("..msg..")", "GUILD")

	if max then
		SendChatMessage(L.Prefix..L.Message_BiddingsVisible:format(counter), settings.chatchannel)
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
	local hiddenedit = CreateFrame('EditBox', "DBM_DKP_PopupExtension", UIParent)
	hiddenedit:SetWidth(40)
	hiddenedit:SetHeight(20)
	hiddenedit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
	hiddenedit:SetFontObject('GameFontHighlightSmall')
	hiddenedit:SetNumeric()
	hiddenedit:SetMaxLetters(5)
	hiddenedit:Hide()
	hiddenedit.left = hiddenedit:CreateTexture(nil, "BACKGROUND")
	hiddenedit.left:SetPoint("LEFT", hiddenedit, "LEFT", -10, 0)
	hiddenedit.left:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left")
	hiddenedit.left:SetTexCoordModifiesRect(true)
	hiddenedit.left:SetTexCoord(0, .15, 0, 1)  
	hiddenedit.right = hiddenedit:CreateTexture(nil, "BACKGROUND")
	hiddenedit.right:SetPoint("RIGHT", hiddenedit, "RIGHT", 240, 0)
	hiddenedit.right:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
	hiddenedit.right:SetTexCoordModifiesRect(true)
	hiddenedit.right:SetTexCoord(.95, 1, 0, 1)	-- last 10 pixel

	-- /script StaticPopup_Show("DBM_DKP_ACCEPT", "item")	
	StaticPopupDialogs["DBM_DKP_ACCEPT"] = {
		text = "bitte Item %s bestätigen",
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 32,
		OnShow = function(self)
			hiddenedit:SetParent(self)
			hiddenedit:SetPoint("TOPRIGHT", self.editBox, "TOPLEFT", -10, -6)
			hiddenedit:SetText(hiddenedit.itemtable.points)
			hiddenedit:Show()
			self.editBox:SetFocus()
			self.editBox:SetText(hiddenedit.itemtable.player)
		end,
		OnAccept = function(self)
			hiddenedit.itemtable.points = tonumber(hiddenedit:GetNumber())
			hiddenedit.itemtable.player = self.editBox:GetText()
			if hiddenedit.itemtable.points and hiddenedit.itemtable.points > 0 then
				-- don't save item when DKP are zero
				table.insert(DBM_DKP_System_Settings.items, hiddenedit.itemtable)
			end
			hiddenedit.itemtable = nil
		end,
		--OnCancel
		OnHide = function(self)
			hiddenedit:SetParent(UIParent)
			hiddenedit:Hide()
			hiddenedit:SetText("")

			self.editBox:SetText("")
		end,
		timeout = 0,
		exclusive = 1,
		hideOnEscape = 0
	}
	
	function DoInjectToDKPSystem(itemtable)
		if DBM_DKP_System_Settings and DBM_DKP_System_Settings.enabled then
			if not DBM_DKP_System_Settings.items then DBM_DKP_System_Settings.items = {} end
			hiddenedit.itemtable = {
				item = itemtable.item,
				points = itemtable.points,
				time = itemtable.time,
				player = itemtable.bids[1].name
			}
			StaticPopup_Show("DBM_DKP_ACCEPT", itemtable.item)
		end
	end
end

do 
	local inRaid = false
	local bidbot_clients = {}
	local function OnMsgRecived(msg, name, nocheck)
		if settings.enabled and inRaid and msg and string.find(string.lower(msg), "^!bid ") then
			if not nocheck and GetNumRaidMembers() > 0 then
				for i=1, GetNumRaidMembers(), 1 do
					if bidbot_clients[UnitName("raid"..i)] and UnitIsConnected("raid"..i) and UnitName("raid"..i) < UnitName("player") then
						-- we don't need to start, the player with hightest name is used
						return
					end
				end
			end
			local ingroup = false
			if GetNumRaidMembers() > 0 then
				for i=1, GetNumRaidMembers(), 1 do
					if UnitName("raid"..i) == name then
						ingroup = true
					end
				end
			end
			if not ingroup then
				-- users from outside can't start a Bid round. (like spaming GuildMates ^^)
				return
			end

			local ItemLink = string.gsub(msg, "^!(%w+) ", "")
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

 	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", function(msg) return (BidBot_InProgress and msg:find("^%d+$")) end)

	BidBot_Frame:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" and select(1, ...) == "DBM-RaidLeadTools" then
			RegisterEvents(
				"CHAT_MSG_GUILD",
				"CHAT_MSG_RAID",
				"CHAT_MSG_SAY",
				"CHAT_MSG_PARTY",
				"CHAT_MSG_OFFICER",
				"CHAT_MSG_RAID_LEADER",
				"CHAT_MSG_WHISPER",
				"RAID_ROSTER_UPDATE",
				"CHAT_MSG_ADDON"
			)
	
			if DBM_BidBot_Translations[GetLocale()] then 
				L = DBM_BidBot_Translations[GetLocale()]
			end
		elseif event == "CHAT_MSG_WHISPER" then
			if BidBot_InProgress and arg1:find("^%d+$") then
				-- here is a bid
				AddBid(arg2, tonumber(arg1))
			end
		elseif event == "CHAT_MSG_ADDON" then
			local prefix, msg, channel, sender = select(1, ...)
			if prefix == "DBM_BidBot" then
				if msg == "Hi!" then
					bidbot_clients[sender] = true
					if channel == "RAID" then
						SendAddonMessage("DBM_BidBot", "Hi!", "WHISPER", sender)				
					end
				elseif msg:sub(0, 5) == "ITEM:" and sender ~= UnitName("player") then
					if DBM:GetRaidUnitId(sender) ~= "none" and not channel == "RAID" then return end
					if DBM:GetRaidUnitId(sender) == "none" and not channel == "GUILD" then return end
					local _, itemid, dkp, savedbids = strsplit(":",msg)
					local Itembid = {
						time = time(), 
						item = select(2, GetItemInfo(itemid)), 
						points = dkp,
						bids = {} 
					}
					for bidder, biddkp  in string.gmatch(savedbids, '(%a+)%((%d+)%)') do
						table.insert(Itembid.bids, { ["points"] = biddkp, ["name"] = bidder })
					end
					table.insert(DBM_BidBot_ItemHistory, Itembid)
					
					if Itembid.bids[1] and Itembid.bids[1].name then
						DoInjectToDKPSystem(Itembid)
					end
				end
			end
		end
			
		if event == "RAID_ROSTER_UPDATE" or event == "ADDON_LOADED" then
			if GetNumRaidMembers() >= 1 and not inRaid then
				inRaid = true
				SendAddonMessage("DBM_BidBot", "Hi!", "RAID")
			elseif GetNumRaidMembers() == 0 and inRaid then
				inRaid = false
			end
		end

		if event:sub(0, 9) == "CHAT_MSG_" then
			OnMsgRecived(select(1, ...), select(2, ...), (event=="CHAT_MSG_WHISPER"))
		end
	end)
	
	-- lets register the Events
	RegisterEvents("ADDON_LOADED")
end

