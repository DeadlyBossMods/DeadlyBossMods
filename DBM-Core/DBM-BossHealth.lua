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

do
	local id = 0
	function getBarId()
		id = id + 1
		return id
	end
end

-----------------------
--  Script Handlers  --
-----------------------
--[[
							<OnMouseDown>
								if arg1 == "LeftButton" and not DBM:GetMod("Kal").Options.FrameLocked then
									self.moving = true
									DBMKalFrameDrag:StartMoving()
								end
							</OnMouseDown>
							<OnMouseUp>
								self.moving = false
								DBMKalFrameDrag:StopMovingOrSizing()
								DBM:GetMod("Kal"):SaveFramePosition()
								if arg1 == "RightButton" then
									UIDropDownMenu_Initialize(DBMKalMenu, DBM:GetMod("Kal").InitializeMenu, "MENU")
									ToggleDropDownMenu(1, nil, DBMKalMenu, "DBMKalMenu", 30, 50)
								end
							</OnMouseUp>
							<OnHide>
								if self.moving then
									DBM:GetMod("Kal"):SaveFramePosition()
									DBMKalFrameDrag:StopMovingOrSizing()
									self.moving = false
								end
							</OnHide>]]


-----------------------
-- Create the Frame  --
-----------------------
local function createFrame(self)
	anchor = CreateFrame("Frame", nil, UIParent)
	anchor:SetWidth(60)
	anchor:SetHeight(10)
	anchor:SetPoint(DBM.Options.HPFramePoint, UIParent, DBM.Options.HPFramePoint, DBM.Options.HPFrameX, DBM.Options.HPFrameY)
	header = anchor:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
	header:SetPoint("BOTTOM", anchor, "BOTTOM")
	anchor:SetScript("OnUpdate", updateFrame)
end

local function createBar(self, cId, name)
	local bar = table.remove(barCache, #barCache) or CreateFrame("Frame", "DBM_BossHealth_Bar_"..getBarId(), anchor, "DBMBossHealthBarTemplate")
	local bartext = _G[bar:GetName().."BarName"]
	bar.id = cId
	bar:SetPoint("TOP", bars[#bars] or anchor, "BOTTOM", 0, 0)
	bartext:SetText(name)
	updateBar(bar, 100)
	return bar
end




------------------
--  Bar Update  --
------------------
function updateBar(bar, percent)
	local bartimer = _G[bar:GetName().."BarTimer"]
	local barbar = _G[bar:GetName().."Bar"]
	bartimer:SetText((percent > 0) and math.floor(percent).."%" or DBM_CORE_DEAD)
	barbar:SetValue(percent)
	barbar:SetStatusBarColor((100 - percent) / 100, percent/100, 0)
end

do
	local t = 0
	local targetCache = setmetatable({}, {__mode = "v"})
	local function getCIDfromGUID(guid)
		return (not guid and 0) or (guid and bit.band(guid:sub(0, 5), 0x00F) == 3 and tonumber(guid:sub(9, 12), 16)) or 0
	end
	
	function updateFrame(self, e)
		t = t + e
		if t >= 0.5 then
			t = 0
			for i, v in ipairs(bars) do
				local id = targetCache[v.id]
				if getCIDfromGUID(UnitGUID(id or "")) ~= v.id then
					local uId = ((GetNumRaidMembers() == 0) and "party") or "raid"
					for i = 0, math.max(GetNumRaidMembers(), GetNumPartyMembers()) do
						id = (i == 0 and "target") or uId..i.."target"
						if getCIDfromGUID(UnitGUID(id or "")) == v.id then
							targetCache[v.id] = id
							break
						end
					end
				end
				if getCIDfromGUID(UnitGUID(id or "")) == v.id then
					updateBar(v, ((UnitHealth(id)) / (UnitHealthMax(id)) * 100 or 100))
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
	for i = #bars, 1, -1 do
		local bar = bars[i]
		bar:Hide()
		bar:ClearAllPoints()
		barCache[#barCache] = bar
		bars[i] = nil
	end
end

function bossHealth:Hide()
	if anchor then anchor:Hide() end
end

function bossHealth:AddBoss(cId, name)
	table.insert(bars, createBar(self, cId, name))
end

