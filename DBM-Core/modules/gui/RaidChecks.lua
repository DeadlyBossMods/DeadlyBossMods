---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")

-- Raid Checks: one tabbed window for the group check tools (Consumables, Gear with durability, Latency).
-- Only the visible tab runs; its events, callbacks and OnUpdate are registered on activation and dropped on deactivation.
---@class DBMRaidChecks
local RaidChecks = {}
DBM.RaidChecks = RaidChecks

local tinsert, tremove, tsort, mmax, mfloor = table.insert, table.remove, table.sort, math.max, math.floor

local L = DBM_CORE_L
local RAID_CLASS_COLORS = _G["CUSTOM_CLASS_COLORS"] or RAID_CLASS_COLORS-- for Phanx' Class Colors
local LibStub = _G["LibStub"]
local isRetail = DBM:IsRetail()
local useModernTabs = isRetail or DBM:IsForever()
local issecrettable = _G["issecrettable"] or function() return false end

if not (LibStub and LibStub("LibDurability", true) and LibStub("LibLatency", true)) then
	DBM:AddMsg(L.UPDATE_REQUIRES_RELAUNCH)
end

local rowHeight = 14
local playerColumnWidth = 120
local defaultTopInset = 30
local minFrameWidth = 360
local defaultPosition = {"CENTER", 0, 170}--Centered, just above the player character
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

------------------------
-- Window shell
------------------------
---@class DBMRaidChecksTab
---@field key string
---@field tabText string
---@field title string
---@field topInset number?
---@field GetColumns fun(): table[]
---@field OnActivate fun()
---@field OnDeactivate fun()
---@field OnRefresh fun()
---@field OnEvent fun(event: string, ...)?
---@field OnUpdate fun(elapsed: number)?
---@field CreateControls (fun(parent: Frame): Frame[])?
---@field controls Frame[]?
---@field button Button?
---@field index integer?
---@field updateScript function?

---@type DefaultPanelTemplate?
local frame
local scroll, child
---@type table<string, DBMRaidChecksTab>
local tabs = {}
---@type DBMRaidChecksTab[]
local tabList = {}
---@type DBMRaidChecksTab?
local activeTab
local tabRunning = false
local currentColumns = {}
local shownHeaders = {}
local spareTextFrames, usedTextFrames = {}, {}

---True only while the tab is the running, visible tab (false during a UIParent hide even though IsShown stays true)
local function IsTabActive(key)
	return tabRunning and activeTab ~= nil and activeTab.key == key
end

local function ShouldUseCommScan()
	if not (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown) then
		return true
	end
	return not C_ChatInfo.InChatMessagingLockdown()
end

local function FormatPlayerName(fullName, classToken)
	local name = DBM:GetShortServerName(fullName) or fullName
	local playerColor = classToken and RAID_CLASS_COLORS[classToken]
	if playerColor then
		name = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, name, 0.41 * 255, 0.8 * 255, 0.94 * 255)
	end
	return name
end

local function WipeTextFrames()
	for _frame in next, usedTextFrames do
		if not _frame.IsSpare then
			_frame.IsSpare = true
			_frame:Hide()
			_frame:SetText("")
			_frame:ClearAllPoints()
			spareTextFrames[#spareTextFrames + 1] = _frame
		end
	end
end

local function GetTextFrame()
	---@class DBMRaidChecksTextFrame: FontString
	---@field IsSpare boolean
	local _frame = spareTextFrames[#spareTextFrames]
	if _frame then
		spareTextFrames[#spareTextFrames] = nil
		_frame.IsSpare = false
		_frame:Show()
		return _frame
	end
	---@class DBMRaidChecksTextFrame
	_frame = child:CreateFontString(nil, nil, "GameFontNormal")
	_frame.IsSpare = false
	_frame:SetJustifyH("LEFT")
	usedTextFrames[_frame] = true
	return _frame
end

-- Column headers are created once per column definition and reused whenever that column is shown.
local function GetHeader(def)
	local header = def.header
	if not header then
		header = child:CreateFontString(nil, nil, "GameFontNormalLarge")
		header.Keep = true
		header:SetJustifyH("LEFT")
		header:SetText(def.title)
		def.width = def.width or mmax(def.minWidth or 55, mfloor(header:GetStringWidth()) + 20)
		header:SetWidth(def.width)
		def.header = header
	end
	return header
end

---Lays out the active tab's current columns and sizes the window to fit them and the tab strip
local function ApplyLayout()
	if not frame or not activeTab then
		return
	end
	for i = #shownHeaders, 1, -1 do
		shownHeaders[i]:Hide()
		shownHeaders[i] = nil
	end
	currentColumns = activeTab.GetColumns()
	local contentWidth, previous = 0, nil
	for _, def in ipairs(currentColumns) do
		local header = GetHeader(def)
		header:ClearAllPoints()
		if previous then
			header:SetPoint("LEFT", previous, "RIGHT", 0, 0)
		else
			header:SetPoint("TOPLEFT", child, 7, 0)
		end
		header:Show()
		shownHeaders[#shownHeaders + 1] = header
		contentWidth = contentWidth + def.width
		previous = header
	end
	scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -(activeTab.topInset or defaultTopInset))
	child:SetWidth(contentWidth + 8)
	local tabStripWidth = 20
	for _, tab in ipairs(tabList) do
		tabStripWidth = tabStripWidth + (tab.button and tab.button:GetWidth() or 0)
	end
	frame:SetWidth(mmax(minFrameWidth, contentWidth + 40, tabStripWidth))
end

---Draws one row per entry in list; cellText(entry, columnKey) returns each cell's text
local function RenderRows(list, cellText)
	WipeTextFrames()
	for i, entry in ipairs(list) do
		local offset = -((i - 1) * rowHeight) - 4 - rowHeight / 2
		for _, def in ipairs(currentColumns) do
			local text = GetTextFrame()
			text:SetText(cellText(entry, def.key))
			-- Center cells on the row so inline icons cannot shift text below neighboring cells.
			text:SetPoint("LEFT", def.header, "BOTTOMLEFT", 0, offset)
			text:SetWidth(def.width)
		end
	end
	child:SetHeight(mmax(scroll:GetHeight(), 50 + #list * rowHeight))
	scroll:UpdateScrollChildRect()
end

---@param tab DBMRaidChecksTab
local function RegisterTab(tab)
	tabs[tab.key] = tab
	tabList[#tabList + 1] = tab
	if tab.OnUpdate then
		tab.updateScript = function(_, elapsed)
			tab.OnUpdate(elapsed)
		end
	end
end

local function OnCombatStarted()
	RaidChecks:Hide()
end

local function ActivateTab()
	local tab = activeTab
	if not frame or not tab or tabRunning then
		return
	end
	PanelTemplates_SetTab(frame, tab.index)
	frame:SetTitle(tab.title)
	for _, other in ipairs(tabList) do
		if other.controls then
			for _, control in ipairs(other.controls) do
				control:SetShown(other == tab)
			end
		end
	end
	tabRunning = true
	DBM:RegisterCallback("DBM_Pull", OnCombatStarted)
	ApplyLayout()
	if tab.updateScript then
		frame:SetScript("OnUpdate", tab.updateScript)
	end
	tab.OnActivate()
end

local function DeactivateTab()
	if not frame or not activeTab or not tabRunning then
		return
	end
	tabRunning = false
	DBM:UnregisterCallback("DBM_Pull", OnCombatStarted)
	frame:UnregisterAllEvents()
	frame:SetScript("OnUpdate", nil)
	activeTab.OnDeactivate()
	WipeTextFrames()
end

---Switches tabs; selecting the current tab restarts it with a fresh scan
local function SelectTab(key)
	local tab = tabs[key]
	if not tab then
		return
	end
	-- IsVisible, not IsShown: while UIParent is hidden the tab stays deferred until OnShow activates it.
	if frame and frame:IsVisible() then
		DeactivateTab()
		activeTab = tab
		ActivateTab()
	else
		activeTab = tab
	end
end

---Registers an event for the active tab; DeactivateTab drops all of them
local function RegisterTabEvent(event, unit)
	if not frame then
		return
	end
	if unit then
		frame:RegisterUnitEvent(event, unit)
	else
		frame:RegisterEvent(event)
	end
end

local function HideIfActive(key)
	if frame and frame:IsShown() and activeTab and activeTab.key == key then
		frame:Hide()
	end
end

local function CreateDisplayFrame()
	if frame then
		return frame
	end
	frame = CreateFrame("Frame", "DBMRaidChecksFrame", UIParent, "DefaultPanelTemplate") --[[@as DefaultPanelTemplate]]
	tinsert(_G["UISpecialFrames"], frame:GetName())
	frame:Hide()
	frame:SetSize(minFrameWidth, 300)
	frame:SetClampedToScreen(true)
	frame:SetPoint("LEFT")
	frame:SetFrameStrata("DIALOG")
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.RaidChecksPosition = {point, x, y}
	end)
	-- Activation pairs with OnShow/OnHide so a UIParent hide (Alt-Z, cinematics) pauses and resumes the tab cleanly.
	frame:SetScript("OnShow", ActivateTab)
	frame:SetScript("OnHide", DeactivateTab)
	frame:SetScript("OnEvent", function(_, event, ...)
		if tabRunning and activeTab and activeTab.OnEvent then
			activeTab.OnEvent(event, ...)
		end
	end)

	frame.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock")
	frame.Bg:SetColorTexture(0, 0, 0, 0.8)

	local closeBtn = CreateFrame("Button", nil, frame, "UIPanelCloseButtonDefaultAnchors")
	closeBtn:SetFrameLevel(frame.NineSlice:GetFrameLevel() + 10)

	scroll = CreateFrame("ScrollFrame", nil, frame, "ScrollFrameTemplate")
	scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -defaultTopInset)
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
	refresh:SetScript("OnClick", function()
		if tabRunning and activeTab then
			activeTab.OnRefresh()
		end
	end)

	for i, tab in ipairs(tabList) do
		tab.index = i
		---@class DBMRaidChecksTabButton: Button
		---@field Text FontString
		-- Classic uses legacy selected/disabled textures; Forever shares Mainline's tab helpers.
		local button = CreateFrame("Button", frame:GetName() .. "Tab" .. i, frame, useModernTabs and "PanelTabButtonTemplate" or "TabButtonTemplate")
		tab.button = button
		PanelTemplates_SetNumTabs(frame, i)
		if i == 1 then
			button:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 11, 2)
		else
			button:SetPoint("TOPLEFT", tabList[i - 1].button, "TOPRIGHT", 1, 0)
		end
		button.Text:SetText(tab.tabText)
		if not useModernTabs then
			PanelTemplates_TabResize(button, 24)
		end
		button:SetScript("OnClick", function()
			SelectTab(tab.key)
		end)
		if tab.CreateControls then
			tab.controls = tab.CreateControls(frame)
			for _, control in ipairs(tab.controls) do
				control:Hide()
			end
		end
	end
	return frame
end

---Opens the window on the given tab ("consumables", "gear" or "latency"); reopening the current tab rescans it
function RaidChecks:Show(key)
	if not tabs[key] then
		return
	end
	if DBM.Keystones then
		DBM.Keystones:Hide()
	end
	local displayFrame = CreateDisplayFrame()
	if _G["DBM_GUI_OptionsFrame"] then
		displayFrame:SetFrameLevel(_G["DBM_GUI_OptionsFrame"]:GetFrameLevel() + 10)
	end
	displayFrame:ClearAllPoints()
	local position = DBM.Options.RaidChecksPosition
	if type(position) ~= "table" or not validAnchorPoints[position[1]] or type(position[2]) ~= "number" or type(position[3]) ~= "number" then
		position = defaultPosition
	end
	displayFrame:SetPoint(position[1], position[2], position[3])
	if displayFrame:IsShown() then
		SelectTab(key)
	else
		activeTab = tabs[key]
		displayFrame:Show()--OnShow activates the tab
	end
end

function RaidChecks:Hide()
	if frame then
		frame:Hide()
	end
end

------------------------
-- Consumables tab (retail only for now)
------------------------
if isRetail then
	---@class DBMConsumables
	local Consumables = {}
	DBM.Consumables = Consumables

	local GetAuraDataByIndex = C_UnitAuras.GetAuraDataByIndex
	local GetItemCount = C_Item and C_Item.GetItemCount or GetItemCount
	local GetItemInfoInstant = C_Item and C_Item.GetItemInfoInstant or GetItemInfoInstant

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

	-- Inspected weapons expose an oil only as a green tooltip line tagged with its profession quality atlas (no duration).
	local inspectEnchantAtlas = "Professions%-ChatIcon%-Quality%-"
	local inspectBestEnchantAtlas = "Professions%-ChatIcon%-Quality%-12%-Tier2"
	local inspectClassImbues = {}
	for class, names in pairs({SHAMAN = L.CONSUMABLES_SHAMAN_IMBUES, PALADIN = L.CONSUMABLES_PALADIN_IMBUES}) do
		local lookup = {}
		for _, name in ipairs(names) do
			lookup[name] = true
		end
		inspectClassImbues[class] = lookup
	end

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
	local entries = {}
	local dirtyMembers = {}
	local unitToName = {}
	local sortList = {}
	local needsRedraw = false
	local updateElapsed = 0
	local commToken = 0
	local lastQueryTime = -math.huge
	local queryScheduled, replyScheduled = false, false
	local nextInspectTime = 0
	local IsAwaitingInspect--Defined with the inspect fallback below

	local updateThrottleSeconds = 0.5
	local commReplyTimeoutSeconds = 3
	local queryThrottleSeconds = 2
	local replyCoalesceSeconds = 1

	local yesText, noText, naText = "|cff00ff00" .. YES .. "|r", "|cffff2020" .. NO .. "|r", "|cff808080" .. L.CONSUMABLES_NA .. "|r"
	-- FavoritesIcon has heavy transparent padding, so the texture size runs larger than the visible star.
	local bestText = yesText .. " |TInterface\\COMMON\\FavoritesIcon:20:20:0:0|t"

	local function IsDisplayShown()
		return IsTabActive("consumables")
	end

	local function IsSelf(name)
		return name == private.playerName
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
		-- Remember which unit was read, so a later roster rebuild can tell if it pointed at someone else.
		entry.scannedUnit = unit
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

	local drawHasWarlock = false

	local function CellText(entry, key)
		if key == "player" then
			return FormatPlayerName(entry.name, DBM:GetRaidClass(entry.name))
		elseif key == "hs" and not drawHasWarlock then
			return naText
		end
		return FormatTier(entry[key], entry.pending or (key == "weapon" and IsAwaitingInspect(entry.name, entry)))
	end

	local function SortByMissing(v1, v2)
		if v1.missing ~= v2.missing then
			return v1.missing > v2.missing
		end
		return v1.name < v2.name
	end

	local function Redraw()
		if not IsDisplayShown() then
			return
		end
		drawHasWarlock = HasWarlockInGroup()
		wipe(sortList)
		for _, entry in pairs(entries) do
			entry.missing = CountMissing(entry, drawHasWarlock)
			tinsert(sortList, entry)
		end
		tsort(sortList, SortByMissing)
		RenderRows(sortList, CellText)
	end

	------------------------
	-- Comms
	------------------------
	local function SendQuery()
		if not IsDisplayShown() then
			return
		end
		if not private.sendSync or not ShouldUseCommScan() then
			-- Query abandoned (e.g. chat lockdown began during the throttle wait); stop waiting on replies so inspects can proceed.
			for _, entry in pairs(entries) do
				entry.pending = false
			end
			needsRedraw = true
			return
		end
		local wait = queryThrottleSeconds - (GetTime() - lastQueryTime)
		-- Hold inspects until the reply window closes (including any throttle wait) so DBM users aren't inspected for data they're about to send.
		nextInspectTime = mmax(nextInspectTime, GetTime() + mmax(wait, 0) + commReplyTimeoutSeconds)
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

	------------------------
	-- Inspect fallback (Weapon column for members that don't answer CCR)
	------------------------
	local activeInspect = {}
	local inspectToken = 0
	local inspectRetryAt, inspectAttempts, inspectUnreachable = {}, {}, {}
	local inspectSpacingSeconds = 1
	local inspectTimeoutSeconds = 4
	local inspectRetrySeconds = 5
	local inspectMaxAttempts = 4
	local lineTypeEnchantPermanent = Enum.TooltipDataLineType and Enum.TooltipDataLineType.ItemEnchantmentPermanent
	local lineTypeCraftingQuality = Enum.TooltipDataLineType and Enum.TooltipDataLineType.ProfessionCraftingQuality

	local function IsGreen(color)
		if type(color) ~= "table" or issecrettable(color) then
			return false
		end
		local r, g, b = color.r, color.g, color.b
		return type(r) == "number" and type(g) == "number" and type(b) == "number" and r < 0.2 and g > 0.9 and b < 0.2
	end

	---@return integer|false|nil tier false when no recognized enhancement exists; nil when tooltip data isn't ready
	local function GetInspectedSlotTier(unit, slot, classToken)
		local classImbues = inspectClassImbues[classToken]
		local data = C_TooltipInfo.GetInventoryItem(unit, slot)
		if not data or issecrettable(data) or type(data.lines) ~= "table" or issecrettable(data.lines) then
			return nil
		end
		local firstLine = data.lines[1]
		if not firstLine or firstLine.leftText == _G["RETRIEVING_ITEM_INFO"] then
			return nil
		end
		for _, line in ipairs(data.lines) do
			local text, lineType = line.leftText, line.type
			if type(text) == "string" and not DBM:issecretvalue(text) and not DBM:issecretvalue(lineType)
				and lineType ~= lineTypeEnchantPermanent and lineType ~= lineTypeCraftingQuality
				and IsGreen(line.leftColor) then
				if text:find(inspectEnchantAtlas) then
					return text:find(inspectBestEnchantAtlas) and TIER_BEST or TIER_YES
				elseif classImbues and lineType == 0 and classImbues[text] then
					return TIER_YES
				end
			end
		end
		return false
	end

	---@return boolean isWeapon, boolean? notReady
	local function IsInspectedWeapon(unit, slot)
		local itemId = GetInventoryItemID(unit, slot)
		if not itemId then
			return false, GetInventoryItemTexture(unit, slot) ~= nil--Equipped, but item data hasn't arrived
		end
		return select(6, GetItemInfoInstant(itemId)) == 2--Enum.ItemClass.Weapon
	end

	---Mirrors GetWeaponTier for an inspected unit
	---@return integer? tier, boolean? notReady
	local function ScanInspectedWeapon(unit, classToken)
		local tier, anyWeapon = TIER_BEST, false
		for slot = 16, 17 do
			local isWeapon, notReady = IsInspectedWeapon(unit, slot)
			if notReady then
				return nil, true
			end
			if isWeapon then
				anyWeapon = true
				local slotTier = GetInspectedSlotTier(unit, slot, classToken)
				if slotTier == nil then
					return nil, true
				elseif slotTier == false then
					if inspectClassImbues[classToken] then
						-- An unrecognized class imbue remains unknown rather than No.
						return nil
					end
					return TIER_NO
				end
				tier = math.min(tier, slotTier)
			end
		end
		return anyWeapon and tier or TIER_NO
	end

	local function FinishInspect()
		wipe(activeInspect)
		-- Never pull inspect data out from under Blizzard's Inspect window.
		if not (InspectFrame and InspectFrame:IsShown()) then
			ClearInspectPlayer()
		end
	end

	local function ResetInspects()
		inspectToken = inspectToken + 1
		if activeInspect.name then
			FinishInspect()
		end
		wipe(inspectRetryAt)
		wipe(inspectAttempts)
		wipe(inspectUnreachable)
		nextInspectTime = 0
	end

	local function IsInspectCandidate(name, entry, now)
		return entry.weapon == nil and not entry.pending and not IsSelf(name)
			and (inspectAttempts[name] or 0) < inspectMaxAttempts and (inspectRetryAt[name] or 0) <= now
	end

	---Still expecting an inspect result, so the Weapon cell shows "..." rather than "?"
	function IsAwaitingInspect(name, entry)
		return entry.weapon == nil and not IsSelf(name) and not inspectUnreachable[name]
			and (inspectAttempts[name] or 0) < inspectMaxAttempts
	end

	local function RequestNextInspect(now)
		if activeInspect.name or now < nextInspectTime then
			return
		end
		if InCombatLockdown() or UnitAffectingCombat("player") or (InspectFrame and InspectFrame:IsShown()) then
			return
		end
		for name, entry in pairs(entries) do
			if IsInspectCandidate(name, entry, now) then
				local unit = DBM:GetRaidUnitId(name, true)
				local guid = unit and not DBM:issecretunit(unit) and UnitIsConnected(unit) and UnitIsVisible(unit)
					and CanInspect(unit) and CheckInteractDistance(unit, 1) and UnitGUID(unit)
				if guid and not DBM:issecretvalue(guid) then
					inspectToken = inspectToken + 1
					local token = inspectToken
					activeInspect.name, activeInspect.guid, activeInspect.token = name, guid, token
					inspectAttempts[name] = (inspectAttempts[name] or 0) + 1
					inspectUnreachable[name] = nil
					nextInspectTime = now + inspectSpacingSeconds
					NotifyInspect(unit)
					C_Timer.After(inspectTimeoutSeconds, function()
						if activeInspect.token == token then
							inspectRetryAt[name] = GetTime() + inspectRetrySeconds
							FinishInspect()
							needsRedraw = true
						end
					end)
					return
				end
				-- Out of range or not visible: check again later without spending an attempt.
				if not inspectUnreachable[name] then
					inspectUnreachable[name] = true
					needsRedraw = true
				end
				inspectRetryAt[name] = now + inspectRetrySeconds
			end
		end
	end

	local function OnInspectReady(guid)
		if not activeInspect.name or DBM:issecretvalue(guid) or guid ~= activeInspect.guid then
			return
		end
		local name = activeInspect.name
		local entry = entries[name]
		local unit = DBM:GetRaidUnitId(name, true)
		if entry and entry.weapon == nil and unit and not DBM:issecretunit(unit) and UnitGUID(unit) == guid then
			local classToken = DBM:GetRaidClass(name)
			local tier, notReady = ScanInspectedWeapon(unit, classToken)
			if notReady then
				inspectRetryAt[name] = GetTime() + inspectSpacingSeconds
			else
				entry.weapon = tier
				inspectAttempts[name] = inspectMaxAttempts--Settled (including unknown imbue classes); Refresh re-checks
				needsRedraw = true
			end
		end
		FinishInspect()
	end

	---Adds new roster members and drops departed ones
	---@return boolean needsQuery
	local function SyncRoster()
		local roster = DBM:GetRaidRoster()
		for name in pairs(entries) do
			if not roster[name] then
				entries[name] = nil
				dirtyMembers[name] = nil
				-- A rejoining member must start fresh, and a pending inspect for them must not restore retry state.
				inspectRetryAt[name], inspectAttempts[name], inspectUnreachable[name] = nil, nil, nil
				if activeInspect.name == name then
					FinishInspect()
				end
			end
		end
		-- Unit tokens shift on any roster change, so rebuild the reverse lookup used by UNIT_AURA.
		wipe(unitToName)
		for name in pairs(roster) do
			local unit = DBM:GetRaidUnitId(name, true)
			if unit then
				unitToName[unit] = name
				-- Scans made through a stale unit ID (before core's rebuild) may have read another player's buffs.
				local entry = entries[name]
				if entry and entry.scannedUnit and entry.scannedUnit ~= unit then
					if entry.liveAuras then
						-- Those values came from the wrong unit; show unknown unless the rescan can read the right one.
						entry.flask, entry.food, entry.rune = nil, nil, nil
						entry.liveAuras = false
					end
					if entry.trackedAuras then
						wipe(entry.trackedAuras)
					end
					entry.scannedUnit = nil
					dirtyMembers[name] = true
					needsRedraw = true
				end
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

	local lastCheckStarted
	local function Refresh()
		lastCheckStarted = GetTime()
		commToken = commToken + 1
		wipe(entries)
		wipe(dirtyMembers)
		ResetInspects()
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
		if not updateInfo or issecrettable(updateInfo) then
			return true
		end
		local fullUpdate, added, removed, updated = updateInfo.isFullUpdate, updateInfo.addedAuras, updateInfo.removedAuraInstanceIDs, updateInfo.updatedAuraInstanceIDs
		if DBM:hasanysecretvalues(fullUpdate, added, removed, updated) then
			return true
		end
		if fullUpdate or added or removed then
			return true
		end
		if updated and issecrettable(updated) then
			return true
		end
		if not updated or not entry.trackedAuras then
			return false
		end
		for _, auraInstanceId in ipairs(updated) do
			if DBM:issecretvalue(auraInstanceId) or entry.trackedAuras[auraInstanceId] then
				return true
			end
		end
		return false
	end

	local function OnEvent(event, unit, updateInfo)
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
		elseif event == "INSPECT_READY" then
			OnInspectReady(unit)--First arg is the inspected GUID
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

	local function OnUpdate(elapsed)
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
		RequestNextInspect(GetTime())
		if needsRedraw then
			needsRedraw = false
			Redraw()
		end
	end

	------------------------
	-- Tab
	------------------------
	local columns = {
		{key = "player", title = PLAYER, width = playerColumnWidth},
		{key = "flask", title = L.CONSUMABLES_FLASK, minWidth = 70},
		{key = "food", title = L.CONSUMABLES_FOOD, minWidth = 70},
		{key = "weapon", title = L.CONSUMABLES_WEAPON, minWidth = 70},
		{key = "hs", title = L.CONSUMABLES_HS, minWidth = 70},
		{key = "rune", title = L.CONSUMABLES_RUNE, minWidth = 70},
	}

	RegisterTab({
		key = "consumables",
		tabText = L.RAIDCHECKS_TAB_CONSUMABLES,
		title = L.CONSUMABLES_HEADER,
		GetColumns = function()
			return columns
		end,
		OnActivate = function()
			RegisterTabEvent("UNIT_AURA")
			RegisterTabEvent("BAG_UPDATE_DELAYED")
			RegisterTabEvent("UNIT_INVENTORY_CHANGED", "player")
			RegisterTabEvent("INSPECT_READY")
			if not DBM:IsCallbackRegistered("DBM_RosterUpdated", OnRosterUpdated) then
				DBM:RegisterCallback("DBM_RosterUpdated", OnRosterUpdated)
			end
			Refresh()
		end,
		OnDeactivate = function()
			DBM:UnregisterCallback("DBM_RosterUpdated", OnRosterUpdated)
			commToken = commToken + 1
			ResetInspects()
			updateElapsed = 0
			needsRedraw = false
			wipe(entries)
			wipe(dirtyMembers)
			wipe(unitToName)
			wipe(sortList)
		end,
		OnEvent = OnEvent,
		OnUpdate = OnUpdate,
		OnRefresh = Refresh,
	})

	---@param fromReadyCheck boolean?
	function Consumables:Show(fromReadyCheck)
		if fromReadyCheck and IsDisplayShown() and lastCheckStarted and GetTime() - lastCheckStarted < 10 then
			return
		end
		RaidChecks:Show("consumables")
	end

	function Consumables:Hide()
		HideIfActive("consumables")
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
end

------------------------
-- Gear tab (group view also shows durability)
------------------------
do
	---@class DBMGearCheck
	local GearCheck = {}
	DBM.GearCheck = GearCheck
	---@class DBMDurability
	local Durability = {}
	DBM.Durability = Durability

	local isMop = DBM:IsMop()
	local checkMissingGems = not DBM:IsVanilla()
	-- Ordinary enchants audited for Naxxramas, Zul'Aman and Siege of Orgrimmar.
	-- Forever and other Classic versions remain disabled until separately audited.
	local checkMissingEnchants = isRetail or DBM:IsVanillaEra() or DBM:IsTBC() or isMop
	local hasRangedSlot = not (isRetail or isMop or DBM:IsForever())
	local lastEquipmentSlot = hasRangedSlot and 18 or 17
	local GetItemStats = C_Item and C_Item.GetItemStats or _G["GetItemStats"]--Classic API, absent from Retail definitions
	local GetItemInfo = C_Item and C_Item.GetItemInfo or GetItemInfo
	local GetDetailedItemLevelInfo = C_Item and C_Item.GetDetailedItemLevelInfo or GetDetailedItemLevelInfo

	local LibDurability = LibStub and LibStub("LibDurability", true)

	local pendingInspects = {}
	local pendingCommReplies = {}
	local guildGearData = {}
	local inspectRetryCounts = {}
	local inspectRetryDeadlines = {}
	local knownRosterMembers = {}
	local activeInspect = {}
	local inspectToken = 0
	local commRequestToken = 0
	local guildSyncToken = 0
	local guildGearQuerySent = false
	local guildUpdatePending = false
	local inspectUpdateElapsed = 0
	local pendingRosterRefresh = false
	local sortGear = {}
	local commReplyTimeoutSeconds = 3
	local inspectTimeoutSeconds = 4
	local inspectMaxRetries = 6
	local guildGearQuerySpamSeconds = 60
	local guildScanMaxRetries = 6
	local guildScanRetrySeconds = 0.5
	local maxReasonableItemLevel = 10000
	local guildUpdateDebounceSeconds = 0.2
	local inspectRetryWindowSeconds = 30
	local sortGuild = {}
	-- "group" (roster, with durability) or "guild" (guild-wide gear sync)
	local gearView = "group"
	local viewButtons

	local Refresh, SendGuildGearSyncRequest, RequestNextInspect, HandleRosterUpdate, ScanGear

	local function IsDisplayShown()
		return IsTabActive("gear")
	end

	local function SetPlayerGearState(name, itemLevel, missingGems, missingEnchants, pending, unavailable)
		local player = DBM:GetRaidRoster()[name]
		if not player then
			return
		end
		player.gearilvl = itemLevel
		player.gearmissinggems = checkMissingGems and missingGems or nil
		player.gearmissingenchants = checkMissingEnchants and missingEnchants or nil
		player.gearpending = pending or false
		player.gearunavailable = unavailable or false
	end

	local function RoundItemLevel(itemLevel)
		if type(itemLevel) ~= "number" then
			return
		end
		return mfloor((itemLevel * 10) + 0.5) / 10
	end

	local function GetGearText(player)
		if type(player.gearilvl) == "number" then
			return ("%.1f"):format(player.gearilvl)
		end
		if player.gearpending then
			return "..."
		end
		if player.gearunavailable then
			return "?"
		end
		return "-"
	end

	local function GetGearCountText(player, key)
		if type(player[key]) == "number" then
			return tostring(player[key])
		end
		if player.gearpending then
			return "..."
		end
		if player.gearunavailable then
			return "?"
		end
		return "-"
	end

	local function GetDurabilityText(player, key)
		local value = player[key]
		return value ~= nil and tostring(value) or "?"
	end

	local function GearCellText(player, key)
		if key == "player" then
			return FormatPlayerName(player.name, player.class)
		elseif key == "ilvl" then
			return GetGearText(player)
		elseif key == "gems" then
			return GetGearCountText(player, "gearmissinggems")
		elseif key == "enchants" then
			return GetGearCountText(player, "gearmissingenchants")
		elseif key == "durability" then
			return GetDurabilityText(player, "durpercent")
		elseif key == "broken" then
			return GetDurabilityText(player, "durbroken")
		end
		return ""
	end

	local function SortGear(v1, v2)
		local v1State = type(v1.gearilvl) == "number" and 3 or v1.gearpending and 2 or v1.gearunavailable and 1 or 0
		local v2State = type(v2.gearilvl) == "number" and 3 or v2.gearpending and 2 or v2.gearunavailable and 1 or 0
		if v1State ~= v2State then
			return v1State > v2State
		end
		if v1.gearilvl ~= v2.gearilvl then
			return (v1.gearilvl or -1) > (v2.gearilvl or -1)
		end
		return v1.name < v2.name
	end

	local function UpdateRaidTab()
		wipe(sortGear)
		for _, v in pairs(DBM:GetRaidRoster()) do
			tinsert(sortGear, v)
		end
		tsort(sortGear, SortGear)
		RenderRows(sortGear, GearCellText)
	end

	local function UpdateGuildTab()
		wipe(sortGuild)
		for name, data in pairs(guildGearData) do
			tinsert(sortGuild, {name = name, class = data.class, gearilvl = data.itemLevel, gearmissinggems = data.missingGems, gearmissingenchants = data.missingEnchants})
		end
		tsort(sortGuild, SortGear)
		RenderRows(sortGuild, GearCellText)
	end

	local function Update()
		if not IsDisplayShown() then
			return
		end
		if gearView == "group" then
			UpdateRaidTab()
		else
			UpdateGuildTab()
		end
	end

	local function ClearInspectQueue()
		inspectToken = inspectToken + 1
		commRequestToken = commRequestToken + 1
		ClearInspectPlayer()
		wipe(pendingInspects)
		wipe(pendingCommReplies)
		wipe(inspectRetryCounts)
		wipe(inspectRetryDeadlines)
		wipe(knownRosterMembers)
		wipe(activeInspect)
	end

	local function MarkInspectUnavailable(name)
		pendingCommReplies[name] = nil
		inspectRetryCounts[name] = nil
		inspectRetryDeadlines[name] = nil
		SetPlayerGearState(name, nil, nil, nil, false, true)
	end

	local function QueueInspectRetry(name)
		local now = GetTime()
		local deadline = inspectRetryDeadlines[name]
		if not deadline then
			deadline = now + inspectRetryWindowSeconds
			inspectRetryDeadlines[name] = deadline
		end
		local retryCount = (inspectRetryCounts[name] or 0) + 1
		if retryCount <= inspectMaxRetries and now <= deadline then
			inspectRetryCounts[name] = retryCount
			SetPlayerGearState(name, nil, nil, nil, true, false)
			tinsert(pendingInspects, name)
			return true
		end
		inspectRetryCounts[name] = nil
		inspectRetryDeadlines[name] = nil
		SetPlayerGearState(name, nil, nil, nil, false, true)
		return false
	end

	local function ShouldAwaitCommReply(name)
		return DBM:CheckDBM(name) and true or false
	end

	local function RemovePendingInspect(name)
		for i = #pendingInspects, 1, -1 do
			if pendingInspects[i] == name then
				tremove(pendingInspects, i)
			end
		end
	end

	local function SendGearSyncRequest()
		if not IsDisplayShown() or not private.sendSync or not ShouldUseCommScan() or not next(pendingCommReplies) then
			return
		end
		commRequestToken = commRequestToken + 1
		local requestToken = commRequestToken
		private.sendSync(private.DBMSyncProtocol or 1, "GIQ", nil, "NORMAL")
		C_Timer.After(commReplyTimeoutSeconds, function()
			if not IsDisplayShown() or requestToken ~= commRequestToken then
				return
			end
			local queuedInspect = false
			for name in pairs(pendingCommReplies) do
				pendingCommReplies[name] = nil
				if knownRosterMembers[name] then
					tinsert(pendingInspects, name)
					queuedInspect = true
				end
			end
			if queuedInspect then
				Update()
				RequestNextInspect()
			end
		end)
	end

	-- Finish within four seconds, leaving time for the whisper before the five-second query closes.
	local function RetryGuildPlayerScan(onSuccess, isCurrent)
		local deadline = GetTime() + commReplyTimeoutSeconds + 1
		local retries = 0
		local function AttemptScan()
			if GetTime() > deadline or not IsInGuild() or not ShouldUseCommScan() or (isCurrent and not isCurrent()) then
				return
			end
			local itemLevel, missingGems, missingEnchants = ScanGear("player")
			if type(itemLevel) == "number" then
				onSuccess(itemLevel, missingGems, missingEnchants)
			elseif retries < guildScanMaxRetries then
				retries = retries + 1
				C_Timer.After(guildScanRetrySeconds, AttemptScan)
			end
		end
		AttemptScan()
	end

	function SendGuildGearSyncRequest()
		if not IsDisplayShown() or not private.sendGuildSync or not ShouldUseCommScan() or not IsInGuild() then
			return
		end
		wipe(guildGearData)
		guildGearQuerySent = true
		guildSyncToken = guildSyncToken + 1
		local requestToken = guildSyncToken
		-- Seed our own data since self-sent GGR messages are filtered out in AddonComms.
		-- The shared player name has no realm suffix, matching the key format GetCorrectSender produces
		-- for same-realm WHISPER senders. Cross-realm peers arrive as "Name-Realm" via GetCorrectSender,
		-- so there is no collision between the local player and any same-name cross-realm guild member.
		local selfName = private.playerName
		RetryGuildPlayerScan(function(selfItemLevel, selfMissingGems, selfMissingEnchants)
			local selfClass = select(2, UnitClass("player"))
			guildGearData[selfName] = {class = selfClass, itemLevel = selfItemLevel, missingGems = selfMissingGems, missingEnchants = selfMissingEnchants}
			Update()
		end, function()
			return requestToken == guildSyncToken and guildGearQuerySent and IsDisplayShown() and gearView == "guild"
		end)
		private.sendGuildSync(private.DBMSyncProtocol or 1, "GGQ", nil)
		C_Timer.After(commReplyTimeoutSeconds + 2, function()
			-- Guard staleness first: a rapid re-request increments guildSyncToken, making this timer stale.
			-- Resetting guildGearQuerySent here would close the active query window and silently drop replies.
			if requestToken ~= guildSyncToken then
				return
			end
			guildGearQuerySent = false
			if not IsDisplayShown() or gearView ~= "guild" then
				return
			end
			Update()
		end)
	end

	-- Retail retains its Midnight slot policy.
	local enchantableSlots = isRetail and {
		[1] = true,--Helm
	--	[2] = true,--Neck
		[3] = true,--Shoulder
	--	[4] = true,--Shirt
		[5] = true,--Chest
	--	[6] = true,--Waist
		[7] = true,--Legs
		[8] = true,--Feet
	--	[9] = true,--Wrist
	--	[10] = true,--Hands
		[11] = true,--Finger1
		[12] = true,--Finger2
	--	[15] = true,--Back
		[16] = true,--MainHand
	--	[17] = true,--OffHand
	} or checkMissingEnchants and {
		[1] = not isMop,--Head enchants were removed in MoP
		[3] = true,--Shoulder inscriptions, including Vanilla reputation enchants
		[5] = true,--Chest
		[7] = true,--Leg armor, spellthread or Vanilla arcanums
		[8] = true,--Feet
		[9] = true,--Wrist
		[10] = true,--Hands
		[15] = true,--Back
		[16] = true,--Weapon or MoP scope
		[17] = true,--Weapon/shield; MoP also permits held-in-offhand items
		[18] = hasRangedSlot,--Scopes only, not wands/thrown/relics
		-- Rings and other profession-only enhancements are deliberately excluded.
	} or {}

	-- https://warcraft.wiki.gg/wiki/Enchantments_by_slot#Pre-6.0_enchants
	local function IsEnchantableClassicItem(itemLink)
		local itemName, _, _, _, _, _, _, _, equipLoc, _, _, classID, subclassID = GetItemInfo(itemLink)
		if not itemName then
			return nil--Uncached: retry instead of claiming a complete count.
		end
		if classID == 2 then--Weapons: scopes cover bows/guns/crossbows as well.
			return subclassID ~= 16 and subclassID ~= 20 and (subclassID ~= 19 or isMop)--Not thrown/fishing poles/pre-MoP wands
		end
		return equipLoc == "INVTYPE_SHIELD" or isMop and equipLoc == "INVTYPE_HOLDABLE"
	end

	--TODO, collect list of enchant Ids and show a () next to count showing number of cheap enchants in use
	function ScanGear(unit)
		if not unit then
			return
		end
		if DBM:issecretunit(unit) then
			return
		end
		-- Request every equipped link before returning so cold slots can load together.
		local itemLinks, linksPending = {}, false
		for slot = 1, lastEquipmentSlot do
			if slot ~= 4 then
				itemLinks[slot] = GetInventoryItemLink(unit, slot)
				if not itemLinks[slot] and GetInventoryItemTexture(unit, slot) then
					linksPending = true
				end
			end
		end
		if linksPending then
			return
		end
		local isPlayer = UnitIsUnit(unit, "player")
		local useInspectItemLevel = C_PaperDollInfo and C_PaperDollInfo.GetInspectItemLevel
		local calculateItemLevel = not isPlayer and not useInspectItemLevel
		local totalItemLevel, itemLevelSlots = 0, hasRangedSlot and 17 or 16
		local mainHandEquipLoc, hasOffHand
		local mainHandItemLevel = 0
		local averageItemLevel
		local missingGems = checkMissingGems and 0 or nil
		local missingEnchants = checkMissingEnchants and 0 or nil
		for i = 1, lastEquipmentSlot do
			local itemLink = itemLinks[i]
			if itemLink then
				local enchant, gem1, gem2, gem3, gem4 = itemLink:match("item:%d+:(%d*):(%d*):(%d*):(%d*):(%d*):")
				if (checkMissingGems or checkMissingEnchants) and not enchant then
					return--Incomplete item link.
				end
				if checkMissingGems then
					local expectedGems, filledSockets = 0, 0
					local statTable = GetItemStats(itemLink)
					if not statTable then
						return--Item data is still loading; use the bounded retry queue.
					end
					for mod, count in next, statTable do
						if mod:find("EMPTY_SOCKET_", nil, true) then
							expectedGems = expectedGems + count
						end
					end
					if (tonumber(gem1) or 0) > 0 then filledSockets = filledSockets + 1 end
					if (tonumber(gem2) or 0) > 0 then filledSockets = filledSockets + 1 end
					if (tonumber(gem3) or 0) > 0 then filledSockets = filledSockets + 1 end
					if (tonumber(gem4) or 0) > 0 then filledSockets = filledSockets + 1 end
					missingGems = missingGems + mmax(0, expectedGems - filledSockets)
				end

				if enchantableSlots[i] and (enchant == "" or enchant == "0") then
					---@type boolean?
					local eligible = true
					if not isRetail and i >= 16 then
						eligible = IsEnchantableClassicItem(itemLink)
					end
					if eligible == nil then
						return
					elseif eligible then
						missingEnchants = missingEnchants + 1
					end
				end

				if calculateItemLevel then
					local itemLevel = GetDetailedItemLevelInfo and GetDetailedItemLevelInfo(itemLink)
					if type(itemLevel) ~= "number" then
						return--Do not substitute the base level for an upgraded MoP item.
					end
					totalItemLevel = totalItemLevel + itemLevel
					if i == 16 then
						mainHandItemLevel = itemLevel
						mainHandEquipLoc = select(9, GetItemInfo(itemLink))
						if not mainHandEquipLoc then return end
					elseif i == 17 then
						hasOffHand = true
					end
				end
			end
		end
		if isPlayer then
			local _, equipped = GetAverageItemLevel()
			--Player returns decimal precision
			averageItemLevel = RoundItemLevel(equipped)
		elseif useInspectItemLevel then
			--Unfortunately, this api does NOT return decimal precision
			averageItemLevel = useInspectItemLevel(unit)
		else
			-- Empty slots count as zero. A lone two-hander fills both hand slots;
			-- occupied offhands (including Titan's Grip) already contribute their own level.
			if not hasOffHand and (mainHandEquipLoc == "INVTYPE_2HWEAPON" or mainHandEquipLoc == "INVTYPE_RANGED" or mainHandEquipLoc == "INVTYPE_RANGEDRIGHT") then
				totalItemLevel = totalItemLevel + mainHandItemLevel
			end
			averageItemLevel = RoundItemLevel(totalItemLevel / itemLevelSlots)
		end
		return averageItemLevel, missingGems, missingEnchants
	end

	local function ScanPlayerGear(name)
		local itemLevel, missingGems, missingEnchants = ScanGear("player")
		if type(itemLevel) == "number" then
			inspectRetryCounts[name] = nil
			inspectRetryDeadlines[name] = nil
			SetPlayerGearState(name, itemLevel, missingGems, missingEnchants, false, false)
		else
			QueueInspectRetry(name)
		end
	end

	local function FinishInspect(token, itemLevel, missingGems, missingEnchants)
		if not activeInspect.name then
			return
		end
		if activeInspect.token ~= token then
			return
		end
		if type(itemLevel) ~= "number" then
			QueueInspectRetry(activeInspect.name)
		else
			pendingCommReplies[activeInspect.name] = nil
			inspectRetryCounts[activeInspect.name] = nil
			inspectRetryDeadlines[activeInspect.name] = nil
			SetPlayerGearState(activeInspect.name, itemLevel, missingGems, missingEnchants, false, false)
		end
		wipe(activeInspect)
		ClearInspectPlayer()
		Update()
		if pendingRosterRefresh and IsDisplayShown() then
			pendingRosterRefresh = false
			HandleRosterUpdate()
			return
		end
		if IsDisplayShown() and #pendingInspects > 0 then
			C_Timer.After(0.1, function()
				if IsDisplayShown() and not activeInspect.name then
					RequestNextInspect()
				end
			end)
		end
	end

	local function ScanActiveInspect()
		if not activeInspect.name or not activeInspect.ready then
			return
		end
		local unit = DBM:GetRaidUnitId(activeInspect.name, true)
		if not unit or DBM:issecretunit(unit) or not UnitExists(unit) or UnitGUID(unit) ~= activeInspect.guid then
			FinishInspect(activeInspect.token)
			return
		end
		local itemLevel, missingGems, missingEnchants = ScanGear(unit)
		if type(itemLevel) == "number" then
			FinishInspect(activeInspect.token, itemLevel, missingGems, missingEnchants)
		end
	end

	function RequestNextInspect()
		if not IsDisplayShown() or activeInspect.name then
			return
		end
		if InCombatLockdown() or UnitAffectingCombat("player") or (InspectFrame and InspectFrame:IsShown()) then
			return
		end
		local inspectAttemptsThisPass = #pendingInspects
		for _ = 1, inspectAttemptsThisPass do
			if #pendingInspects == 0 then
				break
			end
			local name = tremove(pendingInspects, 1)
			local unit = DBM:GetRaidUnitId(name, true)
			if unit and DBM:issecretunit(unit) then
				MarkInspectUnavailable(name)
			elseif name == DBM:GetUnitFullName("player") then
				ScanPlayerGear(name)
			else
				local canInspect = unit and UnitExists(unit) and UnitIsConnected(unit) and not UnitIsUnit(unit, "player") and CheckInteractDistance(unit, 1) and CanInspect(unit)
				if canInspect then
					local guid = UnitGUID(unit)
					if guid then
						inspectToken = inspectToken + 1
						activeInspect.name = name
						activeInspect.guid = guid
						activeInspect.token = inspectToken
						NotifyInspect(unit)
						local token = inspectToken
						C_Timer.After(inspectTimeoutSeconds, function()
							if activeInspect.name == name and activeInspect.guid == guid and activeInspect.token == token then
								FinishInspect(token)
							end
						end)
						return
					end
				end
				MarkInspectUnavailable(name)
			end
		end
		Update()
	end

	local function SeedRaid()
		local playerName = DBM:GetUnitFullName("player")
		local useComms = private.sendSync and ShouldUseCommScan()
		wipe(knownRosterMembers)
		wipe(pendingCommReplies)
		for name in pairs(DBM:GetRaidRoster()) do
			knownRosterMembers[name] = true
			if name == playerName then
				ScanPlayerGear(name)
			else
				local unit = DBM:GetRaidUnitId(name, true)
				if unit and DBM:issecretunit(unit) then
					MarkInspectUnavailable(name)
				else
					SetPlayerGearState(name, nil, nil, nil, true, false)
					if useComms and ShouldAwaitCommReply(name) then
						pendingCommReplies[name] = true
					else
						tinsert(pendingInspects, name)
					end
				end
			end
		end
		if useComms then
			SendGearSyncRequest()
		end
	end

	function HandleRosterUpdate()
		local roster = DBM:GetRaidRoster()
		local playerName = DBM:GetUnitFullName("player")
		local useComms = private.sendSync and ShouldUseCommScan()
		local needsCommRequest = false
		local currentMembers = {}

		for i = #pendingInspects, 1, -1 do
			if not roster[pendingInspects[i]] then
				tremove(pendingInspects, i)
			end
		end

		for name in next, inspectRetryCounts do
			if not roster[name] then
				inspectRetryCounts[name] = nil
				inspectRetryDeadlines[name] = nil
			end
		end
		for name in next, inspectRetryDeadlines do
			if not roster[name] then
				inspectRetryDeadlines[name] = nil
			end
		end
		for name in next, pendingCommReplies do
			if not roster[name] then
				pendingCommReplies[name] = nil
			end
		end

		if activeInspect.name and not roster[activeInspect.name] then
			wipe(activeInspect)
			ClearInspectPlayer()
		end

		for name in pairs(roster) do
			currentMembers[name] = true
			if not knownRosterMembers[name] then
				if name == playerName then
					ScanPlayerGear(name)
				else
					local unit = DBM:GetRaidUnitId(name, true)
					if unit and DBM:issecretunit(unit) then
						MarkInspectUnavailable(name)
					else
						SetPlayerGearState(name, nil, nil, nil, true, false)
						if useComms and ShouldAwaitCommReply(name) then
							pendingCommReplies[name] = true
							needsCommRequest = true
						else
							tinsert(pendingInspects, name)
						end
					end
				end
			end
		end

		if not useComms and next(pendingCommReplies) then
			for name in pairs(pendingCommReplies) do
				pendingCommReplies[name] = nil
				tinsert(pendingInspects, name)
			end
		end

		wipe(knownRosterMembers)
		for name in pairs(currentMembers) do
			knownRosterMembers[name] = true
		end

		if useComms and needsCommRequest then
			SendGearSyncRequest()
		end

		Update()
		RequestNextInspect()
	end

	function Refresh()
		ClearInspectQueue()
		SeedRaid()
		Update()
		RequestNextInspect()
	end

	-- DBM_RosterUpdated fires after core's throttled roster rebuild, so GetRaidRoster and unit IDs are current here.
	local function OnRosterUpdated()
		if IsDisplayShown() then
			if activeInspect.name then
				pendingRosterRefresh = true
			else
				HandleRosterUpdate()
			end
		end
	end

	local function OnEvent(event, arg1)
		if event == "PLAYER_REGEN_ENABLED" then
			if IsDisplayShown() and #pendingInspects > 0 and not activeInspect.name then
				RequestNextInspect()
			end
		elseif event == "INSPECT_READY" then
			if type(arg1) == "string" and arg1 == activeInspect.guid then
				activeInspect.ready = true
				ScanActiveInspect()
			end
		end
	end

	local function OnUpdate(elapsed)
		inspectUpdateElapsed = inspectUpdateElapsed + elapsed
		if inspectUpdateElapsed < 0.5 then
			return
		end
		inspectUpdateElapsed = 0
		ScanActiveInspect()
		if IsDisplayShown() and #pendingInspects > 0 and not activeInspect.name then
			RequestNextInspect()
		end
	end

	------------------------
	-- Durability (Group view columns)
	------------------------
	local function RequestDurability()
		if LibDurability then
			LibDurability:RequestDurability()
		end
	end

	if LibDurability then
		LibDurability:Register("DBM", function(percent, broken, sender)
			if not sender then
				return
			end
			-- LibDurability keeps only the first return from UnitNameUnmodified on Forever.
			if private.isForever and sender == UnitNameUnmodified("player") then
				sender = private.playerName
			end
			local player = DBM:GetRaidRoster()[sender]
			if player then
				player.durpercent = mfloor(percent)
				player.durbroken = broken
			end
			if gearView == "group" then
				Update()
			end
		end)
	end

	------------------------
	-- Tab
	------------------------
	local columnPlayer = {key = "player", title = PLAYER, width = playerColumnWidth}
	local columnItemLevel = {key = "ilvl", title = _G["ITEM_LEVEL_ABBR"] or "iLvl", minWidth = 75}
	local columnGems = checkMissingGems and {key = "gems", title = L.GEAR_MISSING_GEMS, minWidth = 55}
	local columnEnchants = checkMissingEnchants and {key = "enchants", title = L.GEAR_MISSING_ENCHANTS, minWidth = 55}
	local groupColumns, guildColumns = {columnPlayer, columnItemLevel}, {columnPlayer, columnItemLevel}
	if columnGems then
		tinsert(groupColumns, columnGems)
		tinsert(guildColumns, columnGems)
	end
	if columnEnchants then
		tinsert(groupColumns, columnEnchants)
		tinsert(guildColumns, columnEnchants)
	end
	if LibDurability then
		-- Durability comes from LibDurability group comms, so it has no guild equivalent.
		tinsert(groupColumns, {key = "durability", title = L.GEAR_DURABILITY, minWidth = 55})
		tinsert(groupColumns, {key = "broken", title = L.GEAR_BROKEN, minWidth = 55})
	end

	local function UpdateViewButtons()
		if not viewButtons then
			return
		end
		for view, button in pairs(viewButtons) do
			if view == gearView then
				button:LockHighlight()
			else
				button:UnlockHighlight()
			end
		end
	end

	local function ActivateView()
		if gearView == "group" then
			Refresh()
			RequestDurability()
		else
			Update()
			if ShouldUseCommScan() and IsInGuild() then
				SendGuildGearSyncRequest()
			end
		end
	end

	local function SetGearView(view)
		if gearView == view then
			return
		end
		gearView = view
		UpdateViewButtons()
		if IsDisplayShown() then
			ApplyLayout()
			ActivateView()
		end
	end

	RegisterTab({
		key = "gear",
		tabText = L.RAIDCHECKS_TAB_GEAR,
		title = L.GEAR_HEADER,
		topInset = 52,--Room for the Group/Guild toggle
		GetColumns = function()
			return gearView == "guild" and guildColumns or groupColumns
		end,
		CreateControls = function(parent)
			local groupButton = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
			groupButton:SetSize(80, 20)
			groupButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, -28)
			groupButton:SetText(GROUP)
			groupButton:SetScript("OnClick", function()
				SetGearView("group")
			end)
			local guildButton = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
			guildButton:SetSize(80, 20)
			guildButton:SetPoint("LEFT", groupButton, "RIGHT", 4, 0)
			guildButton:SetText(GUILD)
			guildButton:SetScript("OnClick", function()
				SetGearView("guild")
			end)
			viewButtons = {group = groupButton, guild = guildButton}
			UpdateViewButtons()
			return {groupButton, guildButton}
		end,
		OnActivate = function()
			local inGuild = IsInGuild()
			viewButtons.guild:SetShown(inGuild)
			if not inGuild and gearView == "guild" then
				gearView = "group"
				ApplyLayout()
			end
			UpdateViewButtons()
			if not DBM:IsCallbackRegistered("DBM_RosterUpdated", OnRosterUpdated) then
				DBM:RegisterCallback("DBM_RosterUpdated", OnRosterUpdated)
			end
			RegisterTabEvent("INSPECT_READY")
			RegisterTabEvent("PLAYER_REGEN_ENABLED")
			ActivateView()
		end,
		OnDeactivate = function()
			DBM:UnregisterCallback("DBM_RosterUpdated", OnRosterUpdated)
			pendingRosterRefresh = false
			inspectUpdateElapsed = 0
			guildSyncToken = guildSyncToken + 1
			guildGearQuerySent = false
			ClearInspectQueue()
		end,
		OnEvent = OnEvent,
		OnUpdate = OnUpdate,
		OnRefresh = function()
			if gearView == "group" then
				Refresh()
				RequestDurability()
			elseif ShouldUseCommScan() and IsInGuild() then
				SendGuildGearSyncRequest()
			end
		end,
	})

	local function ShowGroupView()
		gearView = "group"
		UpdateViewButtons()
		RaidChecks:Show("gear")
	end

	function GearCheck:Show()
		ShowGroupView()
	end

	function GearCheck:Hide()
		HideIfActive("gear")
	end

	-- Durability lives in the Gear tab's Group view.
	function Durability:Show()
		ShowGroupView()
	end

	function Durability:Hide()
		HideIfActive("gear")
	end

	function GearCheck:OnSync(event, sender, itemLevel, missingGems, missingEnchants, classToken)
		if event == "GIQ" then
			if not private.sendSync or sender == private.playerName or not ShouldUseCommScan() or not DBM:GetRaidRoster(sender) then
				return
			end
			local selfItemLevel, selfMissingGems, selfMissingEnchants = ScanGear("player")
			if type(selfItemLevel) == "number" then
				private.sendSync(private.DBMSyncProtocol or 1, "GIR", ("%s\t%d\t%d"):format(selfItemLevel, selfMissingGems or 0, selfMissingEnchants or 0), "NORMAL")
			end
		elseif event == "GIR" then
			if sender == DBM:GetUnitFullName("player") then
				return
			end
			if not DBM:GetRaidRoster(sender) then
				return
			end
			pendingCommReplies[sender] = nil
			RemovePendingInspect(sender)
			if activeInspect.name == sender then
				wipe(activeInspect)
				ClearInspectPlayer()
			end
			itemLevel = tonumber(itemLevel)
			missingGems = tonumber(missingGems)
			missingEnchants = tonumber(missingEnchants)
			if type(itemLevel) == "number" then
				inspectRetryCounts[sender] = nil
				inspectRetryDeadlines[sender] = nil
				SetPlayerGearState(sender, RoundItemLevel(itemLevel), missingGems, missingEnchants, false, false)
			else
				SetPlayerGearState(sender, nil, nil, nil, true, false)
				tinsert(pendingInspects, sender)
			end
			if IsDisplayShown() then
				Update()
				if #pendingInspects > 0 and not activeInspect.name then
					RequestNextInspect()
				end
			end
		elseif event == "GGQ" then
			-- Use the shared player name to match GetCorrectSender, including Forever.
			-- GetUnitFullName returns "Name-Realm" which never equals an ambiguated same-realm sender.
			if not private.sendWhisperSync or sender == private.playerName or not IsInGuild() then
				return
			end
			if not ShouldUseCommScan() then
				return
			end
			if not DBM:AntiSpam(guildGearQuerySpamSeconds, "GGQ:" .. sender) then
				return
			end
			RetryGuildPlayerScan(function(selfItemLevel, selfMissingGems, selfMissingEnchants)
				local selfClass = select(2, UnitClass("player")) or ""
				private.sendWhisperSync(private.DBMSyncProtocol or 1, "GGR", ("%s\t%d\t%d\t%s"):format(selfItemLevel, selfMissingGems or 0, selfMissingEnchants or 0, selfClass), sender, "NORMAL")
			end)
		elseif event == "GGR" then
			if sender == private.playerName then
				return
			end
			if not guildGearQuerySent or not IsInGuild() then
				return
			end
			itemLevel = tonumber(itemLevel)
			missingGems = tonumber(missingGems)
			missingEnchants = tonumber(missingEnchants)
			if type(classToken) ~= "string" or classToken == "" then
				classToken = nil
			end
			if type(itemLevel) ~= "number" or itemLevel < 0 or itemLevel > maxReasonableItemLevel then
				return
			end
			missingGems = checkMissingGems and missingGems and mmax(0, mfloor(missingGems)) or nil
			missingEnchants = checkMissingEnchants and missingEnchants and mmax(0, mfloor(missingEnchants)) or nil
			guildGearData[sender] = {class = classToken, itemLevel = itemLevel, missingGems = missingGems, missingEnchants = missingEnchants}
			if IsDisplayShown() and gearView == "guild" and not guildUpdatePending then
				guildUpdatePending = true
				C_Timer.After(guildUpdateDebounceSeconds, function()
					guildUpdatePending = false
					if IsDisplayShown() and gearView == "guild" then
						Update()
					end
				end)
			end
		end
	end
end

------------------------
-- Latency tab
------------------------
do
	---@class DBMLatency
	local Latency = {}
	DBM.Latency = Latency

	local LibLatency = LibStub and LibStub("LibLatency", true)
	local sortLag = {}

	local function Update()
		if not IsTabActive("latency") then
			return
		end
		wipe(sortLag)
		for _, v in pairs(DBM:GetRaidRoster()) do
			tinsert(sortLag, v)
		end
		tsort(sortLag, function(v1, v2)
			return (v1.worldlag or 9999) < (v2.worldlag or 9999)
		end)
		RenderRows(sortLag, function(player, key)
			if key == "player" then
				return FormatPlayerName(player.name, player.class)
			end
			local value = player[key]
			return value ~= nil and tostring(value) or "?"
		end)
	end

	local function RequestLatency()
		if LibLatency then
			LibLatency:RequestLatency()
		end
	end

	if LibLatency then
		LibLatency:Register("DBM", function(homelag, worldlag, sender)
			if not sender then
				return
			end
			-- LibLatency keeps only the first return from UnitNameUnmodified on Forever.
			if private.isForever and sender == UnitNameUnmodified("player") then
				sender = private.playerName
			end
			local player = DBM:GetRaidRoster()[sender]
			if player then
				player.homelag = homelag
				player.worldlag = worldlag
			end
			Update()
		end)
	end

	local columns = {
		{key = "player", title = PLAYER, width = playerColumnWidth},
		{key = "worldlag", title = WORLD, minWidth = 75},
		{key = "homelag", title = HOME, minWidth = 75},
	}

	RegisterTab({
		key = "latency",
		tabText = L.RAIDCHECKS_TAB_LATENCY,
		title = L.LAG_HEADER,
		GetColumns = function()
			return columns
		end,
		OnActivate = function()
			Update()
			RequestLatency()
		end,
		OnDeactivate = function()
			wipe(sortLag)
		end,
		OnRefresh = RequestLatency,
	})

	function Latency:Show()
		RaidChecks:Show("latency")
	end

	function Latency:Hide()
		HideIfActive("latency")
	end
end
