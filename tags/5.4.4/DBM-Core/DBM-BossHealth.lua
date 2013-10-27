-- TODO: some parts of this file need to be rewritten:
-- * the style sucks and it can't be changed easily, even resizing bars is a pita because of the current design (blizz status bar)
-- * the frame was never meant to support more than a simple health bar based on the creature ID; the addition of stuff like generic bars (e.g. for shields) and multi-cId bosses or GUID support added some fugly code that could be cleaned up

---------------
--  Globals  --
---------------
DBM.BossHealth = {}


-------------
--  Locals --
-------------
local bossHealth = DBM.BossHealth
local bars = {}
local barCache = {}
local updateFrame
local getBarId
local updateBar
local anchor
local header
local dropdownFrame
--local sortingEnabled

do
	local id = 0
	function getBarId()
		id = id + 1
		return id
	end
end

-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

------------
--  Menu  --
------------
local menu
menu = {
	{
		text = LOCK_FRAME,
		checked = false, -- requires DBM.Options which is not available yet
		func = function()
			menu[1].checked = not menu[1].checked
			DBM.Options.HealthFrameLocked = menu[1].checked
		end
	},
	{
		text = DBM_CORE_BOSSHEALTH_HIDE_FRAME,
		notCheckable = true,
		func = function() bossHealth:Hide() end
	}
}


-----------------------
--  Script Handlers  --
-----------------------
local function onMouseDown(self, button)
	if button == "LeftButton" and not DBM.Options.HealthFrameLocked then
		anchor.moving = true
		anchor:StartMoving()
	end
end

local function onMouseUp(self, button)
	anchor.moving = nil
	anchor:StopMovingOrSizing()
	local point, _, _, x, y = anchor:GetPoint(1)
	DBM.Options.HPFramePoint = point
	DBM.Options.HPFrameX = x
	DBM.Options.HPFrameY = y
	if button == "RightButton" then
		EasyMenu(menu, dropdownFrame, "cursor", nil, nil, "MENU")
	end
end

local onHide = onMouseUp


-----------------
-- Apply Style --
-----------------
local function updateBarStyle(bar, id)
	bar:ClearAllPoints()
	if DBM.Options.HealthFrameGrowUp then
		bar:SetPoint("BOTTOM", bars[id - 1] or anchor, "TOP", 0, 0)
	else
		bar:SetPoint("TOP", bars[id - 1] or anchor, "BOTTOM", 0, 0)
	end
	local barborder = _G[bar:GetName().."BarBorder"]
	local barbar = _G[bar:GetName().."Bar"]
	local width = DBM.Options.HealthFrameWidth
	if width < 175 then -- these health frames really suck :(
		barbar:ClearAllPoints()
		barbar:SetPoint("CENTER", barbar:GetParent(), "CENTER", -6, 0)
		bar:SetWidth(DBM.Options.HealthFrameWidth)
		barborder:SetWidth(DBM.Options.HealthFrameWidth * 0.99)
		barbar:SetWidth(DBM.Options.HealthFrameWidth * 0.95)
	elseif width >= 225 then
		barbar:ClearAllPoints()
		barbar:SetPoint("CENTER", barbar:GetParent(), "CENTER", 5, 0)
		bar:SetWidth(DBM.Options.HealthFrameWidth)
		barborder:SetWidth(DBM.Options.HealthFrameWidth * 0.995)
		barbar:SetWidth(DBM.Options.HealthFrameWidth * 0.965)
	else
		bar:SetWidth(DBM.Options.HealthFrameWidth)
		barborder:SetWidth(DBM.Options.HealthFrameWidth * 0.99)
		barbar:SetWidth(DBM.Options.HealthFrameWidth * 0.95)
	end
end

-----------------------
-- Create the Frame  --
-----------------------
local function createFrame(self)
	anchor = CreateFrame("Frame", nil, UIParent)
	anchor:SetWidth(60)
	anchor:SetHeight(10)
	anchor:SetMovable(1)
	anchor:EnableMouse(1)
	anchor:SetPoint(DBM.Options.HPFramePoint, UIParent, DBM.Options.HPFramePoint, DBM.Options.HPFrameX, DBM.Options.HPFrameY)
	header = anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	header:SetPoint("BOTTOM", anchor, "BOTTOM")
	anchor:SetScript("OnUpdate", updateFrame)
	anchor:SetScript("OnMouseDown", onMouseDown)
	anchor:SetScript("OnMouseUp", onMouseUp)
	anchor:SetScript("OnHide", onHide)
	dropdownFrame = CreateFrame("Frame", "DBMBossHealthDropdown", anchor, "UIDropDownMenuTemplate")
	menu[1].checked = DBM.Options.HealthFrameLocked
end

local function createBar(self, name, ...) -- the vararg will also contain the name, see method AddBoss for details (TODO: this should be handled earlier, seriously...)
	local bar = table.remove(barCache, #barCache) or CreateFrame("Frame", "DBM_BossHealth_Bar_"..getBarId(), anchor, "DBMBossHealthBarTemplate")
	bar:Show()
	local bartext = _G[bar:GetName().."BarName"]
	local barborder = _G[bar:GetName().."BarBorder"]
	local barbar = _G[bar:GetName().."Bar"]
	barborder:SetScript("OnMouseDown", onMouseDown)
	barborder:SetScript("OnMouseUp", onMouseUp)
	barborder:SetScript("OnHide", onHide)
	if select("#", ...) <= 2 then -- 2 as the name is in the vararg
		bar.id = ...
	else
		bar.id = {...}
		bar.id[#bar.id] = nil -- we don't want the name in here
	end
	bar.hidden = false
	bar:ClearAllPoints()
	bartext:SetText(name)
	if type(bar.id) == "function" then
		local health, icon = bar.id()
		updateBar(bar, health, icon, true)
	else
		updateBar(bar, 100)
	end
	return bar
end



------------------
--  Bar Update  --
------------------
function updateBar(bar, percent, icon, dontShowDead)
	if not percent then return end
	local bartimer = _G[bar:GetName() .. "BarTimer"]
	local barbar = _G[bar:GetName() .. "Bar"]
	local barIcon = _G[bar:GetName() .. "BarIcon"]
	bartimer:SetText((percent > 0 or dontShowDead) and math.floor(percent).."%" or DEAD)
	barbar:SetValue(percent)
	barbar:SetStatusBarColor((100 - percent) / 100, percent/100, 0)
	if not icon or type(icon) ~= "number" or icon < 1 or icon > 8 then
		barIcon:Hide()
	else
		barIcon:Show()
		barIcon:SetTexCoord((icon - 1) % 4 / 4, (icon - 1) % 4 / 4 + 0.25, icon < 5 and 0 or 0.25, icon < 5 and 0.25 or 0.5)
	end
	bar.value = percent
	local bossAlive = false
	for i = 1, #bars do
		if bars[i].value > 0 then
			bossAlive = true
			break
		end
	end
	if not bossAlive and #bars > 0 then
		bossHealth:Hide()
	end
end

do
	-- TODO: entries in these caches might never get deleted, worst case: one entry per added boss to the health frame; consider wiping these tables on remove of the corresponding bar or on hiding
	local targetCache = {}
	local targetGuidCache = {}
	local function getCIDfromGUID(guid)
		if not guid then
			return -1
		end
		local cType = bit.band(guid:sub(0, 5), 0x00F)
		return (cType == 3 or cType == 5) and tonumber(guid:sub(6, 10), 16) or -1
	end

--	local function compareBars(b1, b2)
--		return b1.value > b2.value
--	end

	-- gets the health and unit id of the given creature id, returns nil if the target could not be found
	local function getHealth(cId)
		local id = targetCache[cId] -- ask the cache if we already know where the mob is
		if getCIDfromGUID(UnitGUID(id or "")) ~= cId then -- the cache doesn't know it or has invalid data, update it
			targetCache[cId] = nil
			-- check focus target
			if getCIDfromGUID(UnitGUID("focus")) == cId then
				targetCache[cId] = "focus"
			else
				-- just some hack to add support for boss unit ids
				local found = false
				for i = 1, 5 do -- are there really just boss1 to boss4? everyone seems to be assuming this...
					id = "boss"..i
					if getCIDfromGUID(UnitGUID(id)) == cId then
						found = true
						targetCache[cId] = id
						break
					end
				end
				if not found then
					-- check target and raid/party targets
					local uId = (IsInRaid() and "raid") or "party"
					for i = 0, math.max(GetNumGroupMembers(), GetNumSubgroupMembers()) do
						id = (i == 0 and "target") or uId..i.."target"
						if getCIDfromGUID(UnitGUID(id or "")) == cId then
							targetCache[cId] = id
							break
						end
					end
				end
			end
		end
		-- UnitHealthMax is sometimes 0 for one frame when the unit just showed up; so we need to check this here due to stupid UI changes
		if getCIDfromGUID(UnitGUID(id or "")) == cId and UnitHealthMax(id) ~= 0 then -- did we find the mob? if yes: update the health bar
			return UnitHealth(id) / UnitHealthMax(id) * 100, id
		end
	end

	-- gets the health and unit id of the given GUID, returns nil if the target could not be found
	-- TODO: mostly copy & paste from getHealth, these functions should probably be merged somehow...
	local function getHealthByGuid(guid)
		local id = targetGuidCache[guid] -- ask the cache if we already know where the mob is
		if UnitGUID(id or "") ~= guid then -- cache miss :(
			targetGuidCache[guid] = nil
			-- check focus target
			if UnitGUID("focus") == guid then
				targetGuidCache[guid] = "focus"
			else
				local found = false
				for i = 1, 5 do -- are there really just boss1 to boss4? everyone seems to be assuming this...
					id = "boss"..i
					if UnitGUID(id) == guid then
						found = true
						targetGuidCache[guid] = id
						break
					end
				end
				if not found then
				-- check target and raid/party targets
					local uId = (IsInRaid() and "raid") or "party"
					for i = 0, math.max(GetNumGroupMembers(), GetNumSubgroupMembers()) do
						id = (i == 0 and "target") or uId..i.."target"
						if UnitGUID(id or "") == guid then
							targetGuidCache[guid] = id
							break
						end
					end
				end
			end
		end
		-- blah, see above
		if UnitGUID(id or "") == guid and UnitHealthMax(id) ~= 0  then -- did we find the mob? if yes: update the health bar
			return UnitHealth(id) / UnitHealthMax(id) * 100, id
		end
	end

	local t = 0
	function updateFrame(self, e)
		t = t + e
		if t >= 0.5 then
			t = t - 0.5
--			if #bars > DBM.Options.HPFrameMaxEntries then
--				sortingEnabled = true
--			end
--			if sortingEnabled then
--				table.sort(bars, compareBars)
--			end
			for i, v in ipairs(bars) do
--				if i > DBM.Options.HPFrameMaxEntries then
--					v:Hide()
--				else
--					v:Show()
--				end
				if type(v.id) == "number" then -- creature ID
					local health, id = getHealth(v.id)
					if health then
						updateBar(v, health, GetRaidTargetIndex(id))
					end
				elseif type(v.id) == "string" then -- GUID
					local health, id = getHealthByGuid(v.id)
					if health then
						updateBar(v, health, GetRaidTargetIndex(id))
					end
				elseif type(v.id) == "table" then -- multi boss
					-- TODO: it would be more efficient to scan all party/raid members for all IDs instead of going over all raid members n times
					-- this is especially important for the cache
					for j, id in ipairs(v.id) do
						local health = getHealth(id)
						if health then
							updateBar(v, health)
							break
						end
					end
				elseif type(v.id) == "function" then -- generic bars
					local health, icon = v.id()
					updateBar(v, health, icon, true)
				end
			end
		end
	end
end

-----------------------
--  General Methods  --
-----------------------
function bossHealth:Show(name)
	if not anchor then createFrame(bossHealth) end
	header:SetText(name)
	anchor:Show()
	bossHealth:Clear()
end

function bossHealth:Clear()
	if not anchor or not anchor:IsShown() then return end
	for i = #bars, 1, -1 do
		local bar = bars[i]
		bar:Hide()
		bar:ClearAllPoints()
		barCache[#barCache + 1] = bar
		bars[i] = nil
	end
--	sortingEnabled = false
end

function bossHealth:Hide()
	if anchor then anchor:Hide() end
end

function bossHealth:IsShown()
	return anchor and anchor:IsShown()
end

-- HACK to support the old API cId, name. TODO: change API to name, cId and update _all_ boss mods (or: add new method AddSharedHealthBoss or something but this would also be ugly...) (or: use addBoss({cId1, cId2, ...}, name) for multi-cId bosses but that's just ugly)
-- for now: using this ugly code here instead of ugly code in all boss mods that make use of multi-cId health bars

-- hack to support shared health bosses
local function addBoss(self, name, ...) -- name, cId1, cId2, ..., cIdN, name
	if not anchor or not anchor:IsShown() then
		return
	end
	table.insert(bars, createBar(self, name, ...))
	updateBarStyle(bars[#bars], #bars)
end

-- the signature of this method is (cId1, cId2, ..., cIdN, name) for compatibility reasons (used to be cId, name)
function bossHealth:AddBoss(...)
	-- copy the name to the front of the arg list
	-- note: name is now twice in the arg list but we can't really fix that in an efficient way (this is handled in createBar()
	return addBoss(self, select(select("#", ...), ...), ...)
end

-- just pass any of the creature IDs for shared health bosses
-- also accepts the name of the bar for generic bars (i.e. id == function) as you probably don't have access to the specific closure when removing something later
function bossHealth:RemoveBoss(cId)
	if not anchor or not anchor:IsShown() then return end
	for i = #bars, 1, -1 do
		local bar = bars[i]
		if bar.id == cId or type(bar.id) == "table" and checkEntry(bar.id, cId) or type(bar.id) == "function" and (_G[bar:GetName().."BarName"]):GetText() == cId then
			if bars[i + 1] then
				local next = bars[i + 1]
				if DBM.Options.HealthFrameGrowUp then
					next:SetPoint("BOTTOM", bars[i - 1] or anchor, "TOP", 0, 0)
				else
					next:SetPoint("TOP", bars[i - 1] or anchor, "BOTTOM", 0, 0)
				end
			end
			bar:Hide()
			bar:ClearAllPoints()
			barCache[#barCache + 1] = bar
			table.remove(bars, i)
		end
	end
end

-- any ID for shared health bosses
function bossHealth:HasBoss(id)
	if not anchor or not anchor:IsShown() then return end
	for i, bar in ipairs(bars) do
		if bar.id == id or type(bar.id) == "table" and checkEntry(bar.id, id) then
			return true
		end
	end
	return false
end

-- renames an entry in the health frame
-- just pass any of the creature IDs for shared health bosses
function bossHealth:RenameBoss(cId, newName)
	if not anchor or not anchor:IsShown() then return end -- TODO: the entries should still be added even if the frame was never created if someone enables the frame mid-combat...
	for i = #bars, 1, -1 do
		local bar = bars[i]
		if bar.id == cId or type(bar.id) == "table" and checkEntry(bar.id, cId) then
			(_G[bar:GetName().."BarName"]):SetText(newName)
		end
	end
end

function bossHealth:UpdateSettings()
	if not anchor then createFrame(bossHealth) end
	anchor:SetPoint(DBM.Options.HPFramePoint, UIParent, DBM.Options.HPFramePoint, DBM.Options.HPFrameX, DBM.Options.HPFrameY)
	for i, v in ipairs(bars) do
		updateBarStyle(v, i)
	end
end

function bossHealth:Update()
	if not anchor or not anchor:IsShown() then return end
	updateFrame(self, 0.5)
end
