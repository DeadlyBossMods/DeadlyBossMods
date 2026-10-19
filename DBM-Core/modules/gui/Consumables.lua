---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

---@class DBMConsumables
local Consumables = {}
DBM.Consumables = Consumables

local tinsert, tsort, mmax, mfloor = table.insert, table.sort, math.max, math.floor

local L = DBM_CORE_L
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors
local GetAuraDataByIndex = C_UnitAuras.GetAuraDataByIndex
local GetItemCount = C_Item and C_Item.GetItemCount or GetItemCount
local GetItemInfoInstant = C_Item and C_Item.GetItemInfoInstant or GetItemInfoInstant
local issecrettable = _G["issecrettable"] or function() return false end

local TIER_NO, TIER_YES, TIER_BEST = 0, 1, 2

-- Column order is also the CCR wire order.
local columnKeys = {"flask", "food", "weapon", "hs", "rune"}

------------------------
-- Consumable data
------------------------
-- Midnight (current content only). Classic flavors can supply their own tables later and drop columns they lack.
-- All flask qualities share one buff; points[1] is the stat amount (165 best, 152 lower rank).
local flaskBuffs = {
	[1235111] = true,--Flask of the Shattered Sun (Crit)
	[1235108] = true,--Flask of the Magisters (Mastery)
	[1235110] = true,--Flask of the Blood Knights (Haste)
	[1235057] = true,--Flask of Thalassian Resistance (Vers)
}
local flaskBestPoints = 165

local runeBuffs = {
	[1264426] = true,--Void-Touched Augment Rune
}

local wellFedIcon = 136000

-- GetWeaponEnchantInfo enchantIDs, ranked by SpellItemEnchantment Tier1/Tier2.
-- Unlisted temporary enchants (class imbues, older oils) count as a plain Yes.
local weaponEnchantTiers = {
	[8051] = TIER_YES, [8052] = TIER_BEST,--Thalassian Phoenix Oil
	[8053] = TIER_YES, [8054] = TIER_BEST,--Oil of Dawn
	[8055] = TIER_YES, [8056] = TIER_BEST,--Smuggler's Enchanted Edge
	[7906] = TIER_YES, [7905] = TIER_BEST,--Refulgent Whetstone
	[7907] = TIER_YES, [7908] = TIER_BEST,--Refulgent Weightstone
	[8608] = TIER_YES, [8609] = TIER_BEST,--Laced Zoomshots
	[8610] = TIER_YES, [8611] = TIER_BEST,--Weighted Boomshots
}

local healthstoneItems = {
	5512,--Healthstone
	224464,--Demonic Healthstone
}

-- Food is ranked against the best version of the stat family the player chose, never across families.
-- Well Fed effects: points[9] = secondary rating (per stat), points[10] = stamina, points[11] = primary stat.
local FOOD_PRIMARY, FOOD_SECONDARY, FOOD_DUAL, FOOD_STAM_PRIMARY, FOOD_STAM_SECONDARY = 1, 2, 3, 4, 5
local foodPointIndex = {
	[FOOD_PRIMARY] = 11,
	[FOOD_SECONDARY] = 9,
	[FOOD_DUAL] = 9,
	[FOOD_STAM_PRIMARY] = 11,
	[FOOD_STAM_SECONDARY] = 9,
}
-- Floored best values, so client rounding (57.6 -> 57) never costs the best marker.
local foodBestPoints = {
	[FOOD_PRIMARY] = 50,
	[FOOD_SECONDARY] = 57,
	[FOOD_DUAL] = 22,
	[FOOD_STAM_PRIMARY] = 50,
	[FOOD_STAM_SECONDARY] = 64,
}
-- Well Fed and Hearty Well Fed buff spellIDs; built into a lookup on first use.
local foodFamilySpells = {
	[FOOD_PRIMARY] = {
		1232324, 1232325, 1232582, 1232584, 1233407, 1233408, 1294727,
		1233713, 1233714, 1233723, 1233724, 1233725, 1233732, 1233733,
	},
	[FOOD_SECONDARY] = {
		1219182, 1219183, 1219184, 1219185, 1232490, 1232491, 1232492, 1232493, 1232496, 1232498, 1232500, 1232501,
		1283372, 1284616, 1284617, 1284618, 1284619,
		1233703, 1233704, 1233705, 1233706, 1233715, 1233716, 1233717, 1233718, 1233720, 1233721, 1233722,
		1284641, 1284642, 1284643, 1284644, 1284647, 1284648, 1284649, 1284650,
	},
	[FOOD_DUAL] = {
		1232313, 1232316, 1232317, 1232318, 1232320, 1232321, 1233400, 1233401, 1233402, 1233403, 1233404, 1233405, 1233406,
		1233707, 1233708, 1233709, 1233710, 1233711, 1233712, 1233719, 1233726, 1233727, 1233728, 1233729, 1233730, 1233731,
	},
	[FOOD_STAM_PRIMARY] = {
		1232585, 1285644,
	},
	[FOOD_STAM_SECONDARY] = {
		1232086, 1232087, 1232089, 1232091, 1305151, 1305152, 1305154, 1305156,
		1232076, 1232078, 1232080, 1232082, 1305150, 1305153, 1305155, 1305157,
	},
}
local foodFamilyBySpell

local function GetFoodFamily(spellId)
	if not foodFamilyBySpell then
		foodFamilyBySpell = {}
		for family, spells in pairs(foodFamilySpells) do
			for _, id in ipairs(spells) do
				foodFamilyBySpell[id] = family
			end
		end
	end
	return foodFamilyBySpell[spellId]
end

------------------------
-- Scanning
------------------------
local function GetPoint(points, index)
	if not points or issecrettable(points) then
		return
	end
	local value = points[index]
	if value == nil or DBM:issecretvalue(value) or type(value) ~= "number" then
		return
	end
	return value
end

local function GetFlaskTier(aura)
	local amount = GetPoint(aura.points, 1)
	return amount and amount >= flaskBestPoints and TIER_BEST or TIER_YES
end

local function GetFoodTier(unit, aura, family)
	if not family then
		return TIER_YES--Unlisted Well Fed buff
	end
	local amount = GetPoint(aura.points, foodPointIndex[family])
	if not amount then
		return TIER_YES
	end
	if select(2, UnitRace(unit)) == "Pandaren" then
		amount = amount / 2--Epicurean doubles food stats
	end
	return amount >= foodBestPoints[family] and TIER_BEST or TIER_YES
end

---Classifies flask, food and augment rune from one pass over a unit's buffs
---@param tracked table? receives the auraInstanceIDs of matched auras, so later update-only events can be filtered
---@return integer? flask, integer? food, integer? rune nil when the unit's auras aren't readable
local function ScanAuras(unit, tracked)
	if not unit or DBM:issecretunit(unit) then
		return
	end
	if tracked then
		wipe(tracked)
	end
	local flask, food, rune = TIER_NO, TIER_NO, TIER_NO
	for i = 1, 255 do
		local aura = GetAuraDataByIndex(unit, i, "HELPFUL")
		if not aura then
			break
		end
		local spellId = aura.spellId
		if DBM:issecretvalue(spellId) then
			return
		end
		local matched = true
		if flaskBuffs[spellId] then
			flask = mmax(flask, GetFlaskTier(aura))
		elseif runeBuffs[spellId] then
			rune = TIER_YES
		else
			local family = GetFoodFamily(spellId)
			if family or (not DBM:issecretvalue(aura.icon) and aura.icon == wellFedIcon) then
				food = mmax(food, GetFoodTier(unit, aura, family))
			else
				matched = false
			end
		end
		if matched and tracked and aura.auraInstanceID and not DBM:issecretvalue(aura.auraInstanceID) then
			tracked[aura.auraInstanceID] = true
		end
	end
	return flask, food, rune
end

local function IsWeaponInSlot(slot)
	local itemId = GetInventoryItemID("player", slot)
	if not itemId then
		return false
	end
	local classId = select(6, GetItemInfoInstant(itemId))
	return classId == 2--Enum.ItemClass.Weapon
end

local function GetWeaponTier()
	local hasMainHand = IsWeaponInSlot(16)
	local hasOffHand = IsWeaponInSlot(17)
	if not hasMainHand and not hasOffHand then
		return TIER_NO
	end
	local hasMainHandEnchant, _, _, mainHandEnchantId, hasOffHandEnchant, _, _, offHandEnchantId = GetWeaponEnchantInfo()
	local tier = TIER_BEST
	if hasMainHand then
		if not hasMainHandEnchant then
			return TIER_NO
		end
		tier = math.min(tier, weaponEnchantTiers[mainHandEnchantId] or TIER_YES)
	end
	if hasOffHand then
		if not hasOffHandEnchant then
			return TIER_NO
		end
		tier = math.min(tier, weaponEnchantTiers[offHandEnchantId] or TIER_YES)
	end
	return tier
end

local function GetHealthstoneTier()
	for _, itemId in ipairs(healthstoneItems) do
		if (GetItemCount(itemId, false, true) or 0) > 0 then
			return TIER_YES
		end
	end
	return TIER_NO
end

---@param tracked table?
---@return integer? flask, integer? food, integer weapon, integer hs, integer? rune
local function ScanSelf(tracked)
	local flask, food, rune = ScanAuras("player", tracked)
	return flask, food, GetWeaponTier(), GetHealthstoneTier(), rune
end

local function EncodeTier(tier)
	return tier and tostring(tier) or "-"
end

local function DecodeTier(value)
	value = tonumber(value)
	if value == TIER_NO or value == TIER_YES or value == TIER_BEST then
		return value
	end
end

------------------------
-- State
------------------------
---@type DefaultPanelTemplate?
local frame
local scroll, child, titlePlayer
local playerWidth = 120
local columnTitles, columnWidths = {}, {}

local spareTextFrames, usedTextFrames = {}, {}
local entries = {}
local dirtyMembers = {}
local unitToName = {}
local sortList = {}
local needsRedraw = false
local updateElapsed = 0
local commToken = 0
local lastQueryTime = -math.huge
local queryScheduled, replyScheduled = false, false

local updateThrottleSeconds = 0.5
local commReplyTimeoutSeconds = 3
local queryThrottleSeconds = 2
local replyCoalesceSeconds = 1

local validAnchorPoints = {
	TOP = true,
	BOTTOM = true,
	LEFT = true,
	RIGHT = true,
	CENTER = true,
	TOPLEFT = true,
	TOPRIGHT = true,
	BOTTOMLEFT = true,
	BOTTOMRIGHT = true
}

local yesText, noText, naText = "|cff00ff00" .. YES .. "|r", "|cffff2020" .. NO .. "|r", "|cff808080" .. L.CONSUMABLES_NA .. "|r"
local bestText = yesText .. " |TInterface\\COMMON\\FavoritesIcon:12:12|t"

local function IsDisplayShown()
	return frame and frame:IsShown()
end

local function IsSelf(name)
	return name == private.playerName
end

local function ShouldUseCommScan()
	if not (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown) then
		return true
	end
	return not C_ChatInfo.InChatMessagingLockdown()
end

local function WipeTextFrames()
	for _frame in next, usedTextFrames do
		if not _frame.Keep and not _frame.IsSpare then
			_frame.IsSpare = true
			_frame:Hide()
			_frame:SetText("")
			_frame:SetFontObject(GameFontNormal)
			_frame:ClearAllPoints()
			spareTextFrames[#spareTextFrames + 1] = _frame
		end
	end
end

local function GetTextFrame()
	---@class DBMConsumablesTextFrame: FontString
	---@field Keep boolean?
	---@field IsSpare boolean
	local _frame = spareTextFrames[#spareTextFrames]
	if _frame then
		spareTextFrames[#spareTextFrames] = nil
		_frame.IsSpare = false
		_frame:Show()
		return _frame
	end
	---@class DBMConsumablesTextFrame
	_frame = child:CreateFontString(nil, nil, "GameFontNormal")
	_frame.IsSpare = false
	_frame:SetJustifyH("LEFT")
	usedTextFrames[_frame] = true
	return _frame
end

local function ScanSelfInto(entry)
	entry.trackedAuras = entry.trackedAuras or {}
	local flask, food, weapon, hs, rune = ScanSelf(entry.trackedAuras)
	if flask then
		entry.flask, entry.food, entry.rune = flask, food, rune
	end
	entry.weapon, entry.hs = weapon, hs
	entry.pending = false
end

local function ScanMemberAuras(name, entry)
	-- A failed scan must not keep blocking CCR replies for the aura columns.
	entry.liveAuras = false
	local unit = DBM:GetRaidUnitId(name, true)
	-- Out-of-visibility members (another instance/zone) report no auras rather than their real ones.
	if not unit or DBM:issecretunit(unit) or not UnitIsConnected(unit) or not UnitIsVisible(unit) then
		return
	end
	entry.trackedAuras = entry.trackedAuras or {}
	local flask, food, rune = ScanAuras(unit, entry.trackedAuras)
	if flask then
		entry.flask, entry.food, entry.rune = flask, food, rune
		entry.liveAuras = true
	end
end

------------------------
-- Display
------------------------
local function FormatTier(tier, pending)
	if tier == TIER_BEST then
		return bestText
	elseif tier == TIER_YES then
		return yesText
	elseif tier == TIER_NO then
		return noText
	elseif pending then
		return "..."
	end
	return "?"
end

local function HasWarlockInGroup()
	for name in pairs(DBM:GetRaidRoster()) do
		if DBM:GetRaidClass(name) == "WARLOCK" then
			return true
		end
	end
	return false
end

local function CountMissing(entry, hasWarlock)
	local missing = 0
	for _, key in ipairs(columnKeys) do
		if entry[key] == TIER_NO and (key ~= "hs" or hasWarlock) then
			missing = missing + 1
		end
	end
	return missing
end

local function Redraw()
	if not IsDisplayShown() then
		return
	end
	local hasWarlock = HasWarlockInGroup()
	wipe(sortList)
	for _, entry in pairs(entries) do
		entry.missing = CountMissing(entry, hasWarlock)
		tinsert(sortList, entry)
	end
	tsort(sortList, function(v1, v2)
		if v1.missing ~= v2.missing then
			return v1.missing > v2.missing
		end
		return v1.name < v2.name
	end)

	WipeTextFrames()

	for i, entry in ipairs(sortList) do
		local fullName = entry.name
		local name = DBM:GetShortServerName(fullName) or fullName
		local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(fullName)]
		if playerColor then
			name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
		end

		local offset = -((i - 1) * 14) - 4
		local textPlayer = GetTextFrame()
		textPlayer:SetText(name)
		textPlayer:SetPoint("TOP", titlePlayer, "BOTTOM", 0, offset)
		textPlayer:SetWidth(playerWidth)

		for _, key in ipairs(columnKeys) do
			local text = GetTextFrame()
			if key == "hs" and not hasWarlock then
				text:SetText(naText)
			else
				text:SetText(FormatTier(entry[key], entry.pending))
			end
			text:SetPoint("TOP", columnTitles[key], "BOTTOM", 0, offset)
			text:SetWidth(columnWidths[key])
		end
	end

	child:SetHeight(mmax(scroll:GetHeight(), 50 + #sortList * 14))
	scroll:UpdateScrollChildRect()
end

------------------------
-- Comms
------------------------
local function SendQuery()
	if not IsDisplayShown() or not private.sendSync or not ShouldUseCommScan() then
		return
	end
	local wait = queryThrottleSeconds - (GetTime() - lastQueryTime)
	if wait > 0 then
		if not queryScheduled then
			queryScheduled = true
			C_Timer.After(wait, function()
				queryScheduled = false
				SendQuery()
			end)
		end
		return
	end
	lastQueryTime = GetTime()
	commToken = commToken + 1
	local token = commToken
	private.sendSync(private.DBMSyncProtocol or 1, "CCQ", nil, "NORMAL")
	C_Timer.After(commReplyTimeoutSeconds, function()
		if token ~= commToken or not IsDisplayShown() then
			return
		end
		for _, entry in pairs(entries) do
			entry.pending = false
		end
		needsRedraw = true
	end)
end

local function SendReply()
	replyScheduled = false
	if not private.sendSync or not ShouldUseCommScan() then
		return
	end
	local flask, food, weapon, hs, rune = ScanSelf()
	private.sendSync(private.DBMSyncProtocol or 1, "CCR", ("%s\t%s\t%s\t%s\t%s"):format(EncodeTier(flask), EncodeTier(food), EncodeTier(weapon), EncodeTier(hs), EncodeTier(rune)), "NORMAL")
end

---Adds new roster members and drops departed ones
---@return boolean needsQuery
local function SyncRoster()
	local roster = DBM:GetRaidRoster()
	for name in pairs(entries) do
		if not roster[name] then
			entries[name] = nil
			dirtyMembers[name] = nil
		end
	end
	-- Unit tokens shift on any roster change, so rebuild the reverse lookup used by UNIT_AURA.
	wipe(unitToName)
	for name in pairs(roster) do
		local unit = DBM:GetRaidUnitId(name, true)
		if unit then
			unitToName[unit] = name
		end
	end
	local useComms = private.sendSync and ShouldUseCommScan()
	local needsQuery = false
	for name in pairs(roster) do
		if not entries[name] then
			local entry = {name = name, pending = false}
			entries[name] = entry
			if IsSelf(name) then
				ScanSelfInto(entry)
			else
				ScanMemberAuras(name, entry)
				local unit = DBM:GetRaidUnitId(name, true)
				-- Query regardless of version discovery (version replies lag the roster); unanswered members simply stay "?".
				if useComms and unit and UnitIsConnected(unit) then
					needsQuery = true
					if DBM:CheckDBM(name) then
						entry.pending = true
					end
				end
			end
		end
	end
	return needsQuery
end

local function Refresh()
	commToken = commToken + 1
	wipe(entries)
	wipe(dirtyMembers)
	if SyncRoster() then
		SendQuery()
	end
	Redraw()
end

------------------------
-- Events
------------------------
---Update-only aura events (stacks/durations) are only relevant if they touch an aura we classified
local function TouchesTrackedAura(entry, updateInfo)
	if not updateInfo or updateInfo.isFullUpdate or updateInfo.addedAuras or updateInfo.removedAuraInstanceIDs or issecrettable(updateInfo) then
		return true
	end
	local updated = updateInfo.updatedAuraInstanceIDs
	if not updated or not entry.trackedAuras then
		return false
	end
	for _, auraInstanceId in ipairs(updated) do
		if not DBM:issecretvalue(auraInstanceId) and entry.trackedAuras[auraInstanceId] then
			return true
		end
	end
	return false
end

local function OnEvent(_, event, unit, updateInfo)
	if event == "UNIT_AURA" then
		-- Hot path: a single lookup rejects nameplates, targets and pets before any other work.
		if DBM:issecretvalue(unit) then
			return
		end
		local name = unitToName[unit]
		if not name or dirtyMembers[name] then
			return
		end
		local entry = entries[name]
		if entry and TouchesTrackedAura(entry, updateInfo) then
			dirtyMembers[name] = true
		end
	elseif event == "UNIT_INVENTORY_CHANGED" or event == "BAG_UPDATE_DELAYED" then
		dirtyMembers[private.playerName] = true
	end
end

-- DBM_RosterUpdated fires after core's throttled roster rebuild, so GetRaidRoster and unit IDs are current here.
local function OnRosterUpdated()
	if not IsDisplayShown() then
		return
	end
	if SyncRoster() then
		SendQuery()
	end
	needsRedraw = true
end

local function OnUpdate(_, elapsed)
	updateElapsed = updateElapsed + elapsed
	if updateElapsed < updateThrottleSeconds then
		return
	end
	updateElapsed = 0
	for name in pairs(dirtyMembers) do
		dirtyMembers[name] = nil
		local entry = entries[name]
		if entry then
			if IsSelf(name) then
				ScanSelfInto(entry)
			else
				ScanMemberAuras(name, entry)
			end
			needsRedraw = true
		end
	end
	if needsRedraw then
		needsRedraw = false
		Redraw()
	end
end

------------------------
-- Frame
------------------------
local function CreateDisplayFrame()
	if frame then
		return frame
	end
	frame = CreateFrame("Frame", "DBMConsumablesFrame", UIParent, "DefaultPanelTemplate") --[[@as DefaultPanelTemplate]]
	tinsert(_G["UISpecialFrames"], frame:GetName())
	frame:Hide()
	frame:SetSize(380, 300)
	frame:SetClampedToScreen(true)
	frame:SetPoint("LEFT")
	frame:SetFrameStrata("DIALOG")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetTitle(L.CONSUMABLES_HEADER)
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.ConsumablesPosition = {point, x, y}
	end)
	-- Register/unregister symmetrically in OnShow/OnHide so a UIParent hide (Alt-Z, cinematics) pauses and resumes cleanly.
	frame:SetScript("OnShow", function(self)
		self:RegisterEvent("UNIT_AURA")
		self:RegisterEvent("BAG_UPDATE_DELAYED")
		self:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
		self:SetScript("OnEvent", OnEvent)
		self:SetScript("OnUpdate", OnUpdate)
		if not DBM:IsCallbackRegistered("DBM_RosterUpdated", OnRosterUpdated) then
			DBM:RegisterCallback("DBM_RosterUpdated", OnRosterUpdated)
		end
		Refresh()
	end)
	frame:SetScript("OnHide", function(self)
		self:UnregisterAllEvents()
		self:SetScript("OnEvent", nil)
		self:SetScript("OnUpdate", nil)
		DBM:UnregisterCallback("DBM_RosterUpdated", OnRosterUpdated)
		commToken = commToken + 1
		updateElapsed = 0
		needsRedraw = false
		wipe(entries)
		wipe(dirtyMembers)
		wipe(unitToName)
		wipe(sortList)
	end)

	frame.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock")
	frame.Bg:SetColorTexture(0, 0, 0, 0.8)

	local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButtonDefaultAnchors")
	closeBtn:SetFrameLevel(frame.NineSlice:GetFrameLevel() + 10)

	scroll = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
	scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 30)

	child = CreateFrame("Frame", nil, scroll)
	scroll:SetScrollChild(child)
	child:SetSize(scroll:GetWidth(), scroll:GetHeight())
	child:SetPoint("LEFT")

	local refresh = CreateFrame("Button", nil, frame)
	refresh:SetSize(20, 20)
	refresh:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 8, 6)
	refresh:SetText("REFRESH")
	refresh:Show()
	refresh:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton")
	refresh:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton-Down")
	refresh:SetHighlightTexture("Interface\\Buttons\\UI-RefreshButton")
	refresh:SetScript("OnClick", Refresh)

	titlePlayer = GetTextFrame()
	titlePlayer.Keep = true
	titlePlayer:SetFontObject(GameFontNormalLarge)
	titlePlayer:SetText(PLAYER)
	titlePlayer:SetPoint("TOPLEFT", child, 7, 0)
	titlePlayer:SetWidth(playerWidth)

	local headers = {
		flask = L.CONSUMABLES_FLASK,
		food = L.CONSUMABLES_FOOD,
		weapon = L.CONSUMABLES_WEAPON,
		hs = L.CONSUMABLES_HS,
		rune = L.CONSUMABLES_RUNE,
	}
	local totalWidth = playerWidth
	local previous = titlePlayer
	for _, key in ipairs(columnKeys) do
		local title = GetTextFrame()
		title.Keep = true
		title:SetFontObject(GameFontNormalLarge)
		title:SetText(headers[key])
		title:SetPoint("LEFT", previous, "RIGHT", 0, 0)
		local width = mmax(70, mfloor(title:GetStringWidth()) + 20)
		title:SetWidth(width)
		columnTitles[key], columnWidths[key] = title, width
		totalWidth = totalWidth + width
		previous = title
	end

	child:SetWidth(totalWidth + 8)
	frame:SetWidth(child:GetWidth() + 32)
	return frame
end

------------------------
-- API
------------------------
function Consumables:Show()
	if DBM.Keystones then
		DBM.Keystones:Hide()
	end
	if DBM.GearCheck then
		DBM.GearCheck:Hide()
	end
	if DBM.Durability and DBM.Durability.Hide then
		DBM.Durability:Hide()
	end
	if DBM.Latency and DBM.Latency.Hide then
		DBM.Latency:Hide()
	end
	local displayFrame = CreateDisplayFrame()
	if _G["DBM_GUI_OptionsFrame"] then
		displayFrame:SetFrameLevel(_G["DBM_GUI_OptionsFrame"]:GetFrameLevel() + 10)
	end
	displayFrame:ClearAllPoints()
	local position = DBM.Options.ConsumablesPosition
	if type(position) ~= "table" or not validAnchorPoints[position[1]] or type(position[2]) ~= "number" or type(position[3]) ~= "number" then
		position = {"RIGHT", -150, 0}
	end
	displayFrame:SetPoint(position[1], position[2], position[3])
	if displayFrame:IsShown() then
		Refresh()
	else
		displayFrame:Show()--OnShow registers events and refreshes
	end
end

function Consumables:Hide()
	if frame then
		frame:Hide()
	end
end

function Consumables:OnSync(event, sender, flask, food, weapon, hs, rune)
	if event == "CCQ" then
		if not private.sendSync or IsSelf(sender) or not DBM:GetRaidRoster(sender) or not ShouldUseCommScan() then
			return
		end
		-- Coalesce bursts (e.g. many auto-shown frames on a ready check) into a single reply.
		if not replyScheduled then
			replyScheduled = true
			C_Timer.After(replyCoalesceSeconds, SendReply)
		end
	elseif event == "CCR" then
		if not IsDisplayShown() or IsSelf(sender) then
			return
		end
		local entry = entries[sender]
		if not entry then
			return
		end
		if not entry.liveAuras then
			entry.flask, entry.food, entry.rune = DecodeTier(flask), DecodeTier(food), DecodeTier(rune)
		end
		entry.weapon, entry.hs = DecodeTier(weapon), DecodeTier(hs)
		entry.pending = false
		needsRedraw = true
	end
end
