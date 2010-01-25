-- This file uses models and textures taken from TomTom. The 3d arrow model was created by Guillotine (curse.guillotine@gmail.com) and 2d minimap textures by Cladhaire.

----------------------------
--  Initialize variables  --
----------------------------
-- globals
DBM.Arrow = {}

-- locals
local arrowColor
local targetType
local targetPlayer
local targetX, targetY

-- cached variables
local pi, pi2 = math.pi, math.pi * 2
local floor = math.floor
local sin, cos, atan2 = math.sin, math.cos, math.atan2
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

local currentCell
local function updateArrow(direction)
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

local rotateState = 0
frame:SetScript("OnUpdate", function(self, elapsed) -- do not throttle this function as might make the arrow "laggy"
	if WorldMapFrame:IsShown() then
		return
	end
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
	if angle < 0 then -- we need a value between 0 and 2 pi
		angle = -angle
	else
		angle = pi2 - angle
	end
	-- /run DBM.Arrow:Show(nil, 0.204778417, 0.79239803552628)
	updateArrow(angle - GetPlayerFacing())
end)


function DBM.Arrow:Show(color, ...)
	arrowColor = color
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
