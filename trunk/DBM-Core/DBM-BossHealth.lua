

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



----...
-- Create the Frame  --
-----...
local function createFrame(self)
	anchor = CreateFrame("Frame", nil, UIParent)
	anchor:SetPoint(DBM.Options.HPFramePoint, UIParent, DBM.Options.HPFramePoint, DBM.Options.HPFrameX, DBM.Options.HPFrameY)
	header = anchor:CreateFontString("GameFontNormalSmall")
end

local function createBar(cId, name)
	local bar = table.remove(barCache, #barCache) or CreateFrame("Frame", "DBM_BossHealth_Bar_"..getBarId(), anchor, "DBT_Template")
	local bartext = _G[bar:GetName().."TimerName"]
	bar:SetPoint("TOP", bars[#bars - 1] or anchor, "BOTTOM", 0, bars[#bars - 1] and -6 or -1)
	bartext:SetText(name)
	updateBar(bar, 100)
end


--
--  Bar Update
--
function updateBar(bar, percent)
	local bartimer = _G[bar:GetName().."TimerText"]
	bartimer:SetText((percent > 0) and percent.."%" or DBM_CORE_DEAD)
	bar:SetValue(percent)
	bar:SetStatusBarColor((100 - percent) / 100, percent/100, 0)
end



-----------------------
--  General Methods  --
-----------------------
function bossHealth:Show(name)
	if not anchor then createFrame(bossHealth)
	header:SetText(name)
	anchor:Show()
end

function bossHealth:Clear()
	for i = #bars, 1, -1 do
		bar:Hide()
		bar:ClearAllPoints()
		barCache[#barCache] = bar
	end
end

function bossHealth:Hide()
	if anchor then anchor:Hide() end
end

function bossHealth:AddBoss(cId)
	table.insert(bars, createBar(self, cId))
end

