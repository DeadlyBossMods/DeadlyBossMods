-- This file uses models and textures taken from TomTom. The 3d arrow model was created by Guillotine (curse.guillotine@gmail.com) and 2d minimap textures by Cladhaire.

----------------------------
--  Initialize variables  --
----------------------------
-- globals
DBM.Arrow = {}

-- locals
local runAwayArrow
local targetType
local targetPlayer
local targetX, targetY

-- cached variables
local pi, pi2 = math.pi, math.pi * 2
local floor = math.floor
local sin, cos, atan2, sqrt = math.sin, math.cos, math.atan2, math.sqrt
local GetPlayerMapPosition = GetPlayerMapPosition

--------------------
--  Create Frame  --
--------------------
local frame = CreateFrame("Button", nil, UIParent)
frame:Hide()
frame:SetFrameStrata("HIGH")
frame:SetWidth(56)
frame:SetHeight(42)
frame:SetPoint("TOP", 0, -150)
frame:SetMovable(true)
frame:EnableMouse(false)
frame:RegisterForDrag("LeftButton", "RightButton")
frame:SetScript("OnDragStart", function(self)
	self:StartMoving()
end)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
end)
local arrow = frame:CreateTexture(nil, "OVERLAY")
arrow:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\arrows\\Arrow.blp")
arrow:SetAllPoints(frame)

---------------------
--  Map Utilities  --
---------------------
local SetMapToCurrentZone -- throttled SetMapToCurrentZone function to prevent lag issues with unsupported WorldMap addons
do
	local lastMapUpdate = 0
	function SetMapToCurrentZone(...)
		if GetTime() - lastMapUpdate > 1 then
			lastMapUpdate = GetTime()
			return _G.SetMapToCurrentZone(...)
		end
	end
end

local calculateDistance
do
	local mapSizes = DBM.MapSizes
	function calculateDistance(x1, y1, x2, y2)
		local mapName = GetMapInfo()
		local floors = mapSizes[mapName]
		if not floors then
			return
		end
		local dims = floors[GetCurrentMapDungeonLevel()]
		if not dims and levels and GetCurrentMapDungeonLevel() == 0 then -- we are in a known zone but the dungeon level seems to be wrong
			SetMapToCurrentZone() -- fixes the dungeon level (if it was wrong for some reason)
			dims = levels[GetCurrentMapDungeonLevel()] -- try again
			if not dims then -- there is actually a level 0 in this zone but we don't know about it...too bad :(
				return false
			end
		end
		local dX = (x1 - x2) * dims[1]
		local dY = (y1 - y2) * dims[2]
		return sqrt(dX * dX + dY * dY)
	end
end


------------------------
--  Update the arrow  --
------------------------
local updateArrow
do
	local currentCell
	function updateArrow(direction, distance)
		local cell = floor(direction / pi2 * 108 + 0.5) % 108
		if cell ~= currentCell then
			currentCell = cell
			local column = cell % 9
			local row = floor(cell / 9)
			local xStart = (column * 56) / 512
			local yStart = (row * 42) / 512
			local xEnd = ((column + 1) * 56) / 512
			local yEnd = ((row + 1) * 42) / 512
			arrow:SetTexCoord(xStart, xEnd, yStart, yEnd)
		end
	end
end

------------------------
--  OnUpdate Handler  --
------------------------
do
	local rotateState = 0
	local skipFrame
	frame:SetScript("OnUpdate", function(self, elapsed)
		if WorldMapFrame:IsShown() then -- it doesn't work while the world map frame is shown
			arrow:Hide()
			return
		end
		skipFrame = not skipFrame
		if skipFrame then
			return
		end
		arrow:Show()
		local x, y = GetPlayerMapPosition("player")
		if x == 0 and y == 0 then
			SetMapToCurrentZone()
			x, y = GetPlayerMapPosition("player")
			if x == 0 and y == 0 then
				self:Hide() -- hide the arrow if you enter a zone without a map
				return
			end
		end
		if targetType == "player" then
			targetX, targetY = GetPlayerMapPosition(targetPlayer)
		elseif targetType == "rotate" then
			rotateState = rotateState + elapsed
			targetX = x + cos(rotateState)
			targetY = y + sin(rotateState)
		end
		local angle = atan2(x - targetX, targetY - y)
		if angle <= 0 then -- -pi < angle < pi but we need/want a value between 0 and 2 pi
			if runAwayArrow then
				angle = -angle -- 0 < angle < pi
			else
				angle = pi2 + angle -- pi < angle < 2pi
			end
		else
			if runAwayArrow then
				angle = pi2 - angle -- pi < angle < 2pi
--			else
--				angle = angle  -- 0 < angle < pi
			end
		end
		-- /run DBM.Arrow:Show(nil, 0.204778417, 0.79239803552628)
		updateArrow(angle - GetPlayerFacing(), getDistance(x, y, targetX, targetY))
	end)
end


----------------------
--  Public Methods  --
----------------------
function DBM.Arrow:Show(color, ...)
	local numArgs = select("#", ...)
	if numArgs > 0 then
		frame:Show()
	end
	if numArgs == 1 then
		targetType = "player"
		targetPlayer = ...
	elseif numArgs >= 2 then
		targetType = "fixed"
		targetX, targetY = ...
	end
end

function DBM.Arrow:Hide(autoHide)
	frame:Hide()
end

local function endMove()
	frame:EnableMouse(false)
	DBM.Arrow:Hide()
end

function DBM.Arrow:Move()
	targetType = "rotate"
	frame:EnableMouse(true)
	frame:Show()
	DBM.Bars:CreateBar(25, DBM_ARROW_MOVABLE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
	DBM:Unschedule(endMove)
	DBM:Schedule(25, endMove)
end
