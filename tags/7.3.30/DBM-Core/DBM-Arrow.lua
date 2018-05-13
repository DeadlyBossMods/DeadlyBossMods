-- This file uses models and textures taken from TomTom. The 3d arrow model was created by Guillotine (curse.guillotine@gmail.com) and 2d minimap textures by Cladhaire.

----------------------------
--  Initialize variables  --
----------------------------
-- globals
DBM.Arrow = {}

-- locals
local arrowFrame = DBM.Arrow
local runAwayArrow
local targetType
local targetPlayer
local targetX, targetY, targetMapId
local hideTime, hideDistance

-- cached variables
local pi, pi2 = math.pi, math.pi * 2
local floor = math.floor
local sin, cos, atan2, sqrt, min = math.sin, math.cos, math.atan2, math.sqrt, math.min
local UnitPosition = UnitPosition
local GetTime = GetTime

--------------------
--  Create Frame  --
--------------------
local frame = CreateFrame("Button", "DBMArrow", UIParent)
frame:Hide()
frame:SetFrameStrata("HIGH")
frame:SetWidth(56)
frame:SetHeight(42)
frame:SetMovable(true)
frame:EnableMouse(false)
frame:RegisterForDrag("LeftButton", "RightButton")
frame:SetScript("OnDragStart", function(self)
	self:StartMoving()
end)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, _, x, y = self:GetPoint(1)
	DBM.Options.ArrowPoint = point
	DBM.Options.ArrowPosX = x
	DBM.Options.ArrowPosY = y
end)
local arrow = frame:CreateTexture(nil, "OVERLAY")
arrow:SetTexture("Interface\\AddOns\\DBM-Core\\textures\\arrows\\Arrow.blp")
arrow:SetAllPoints(frame)

---------------------
--  Map Utilities  --
---------------------
local calculateDistance
do
	function calculateDistance(x1, y1, x2, y2)
		local dX = x1 - x2
		local dY = y1 - y2
		return sqrt(dX * dX + dY * dY)
	end
end

-- GetPlayerFacing seems to return values between -pi and pi instead of 0 - 2pi sometimes since 3.3.3
local GetPlayerFacing = function(...)
	local result = GetPlayerFacing(...) or 0
	if result < 0 then
		result = result + pi2
	end
	return result
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
		if distance then
			if runAwayArrow then
				local perc = distance / hideDistance
				arrow:SetVertexColor(1 - perc, perc, 0)
				if distance >= hideDistance then
					frame:Hide()
				end
			else
				local perc = min(distance, 100) / 100
				arrow:SetVertexColor(1, 1 - perc, 0)
				if distance <= hideDistance then
					frame:Hide()
				end
			end
		else
			if runAwayArrow then
				arrow:SetVertexColor(1, 0.3, 0)
			else
				arrow:SetVertexColor(1, 1, 0)
			end
		end
	end
end

------------------------
--  OnUpdate Handler  --
------------------------
do
	local rotateState = 0
--	local skipFrame -- todo: skipping frames makes the arrow laggy, maybe skip frames if frame rate >= 45
	frame:SetScript("OnUpdate", function(self, elapsed)
--		skipFrame = not skipFrame
--		if skipFrame then
--			return
--		end
		if hideTime and GetTime() > hideTime then
			frame:Hide()
		end
		arrow:Show()
		-- the static arrow type is special because it doesn't depend on the player's orientation or position
		if targetType == "static" then
			return updateArrow(targetX) -- targetX contains the static angle to show
		end

		local x, y, _, mapId = UnitPosition("player")

		if targetType == "player" then
			targetX, targetY, _, targetMapId = UnitPosition(targetPlayer)
			if not targetX or mapId ~= targetMapId then
				self:Hide() -- hide the arrow if the target doesn't exist. TODO: just hide the texture and add a timeout
			end
		elseif targetType == "rotate" then
			rotateState = rotateState + elapsed
			targetX = x + cos(rotateState)
			targetY = y + sin(rotateState)
		end
		if not targetX or not targetY then
			return
		end
		local angle = atan2(targetY - y, x - targetX)
		if angle <= 0 then -- -pi < angle < pi but we need/want a value between 0 and 2 pi
			if runAwayArrow then
				angle = -angle -- 0 < angle < pi
			else
				angle = pi - angle -- pi < angle < 2pi
			end
		else
			if runAwayArrow then
				angle = pi2 - angle -- pi < angle < 2pi
			else
				angle = pi - angle  -- 0 < angle < pi
			end
		end
		updateArrow(angle - GetPlayerFacing(), calculateDistance(x, y, targetX, targetY))
	end)
end


----------------------
--  Public Methods  --
----------------------
local function MapToWorldCoords(x, y)
	SetMapToCurrentZone()

	local isMapDungeon = true
	local _, a, b, c, d = GetCurrentMapDungeonLevel()
	--local floorIndex, minX, minY, maxX, maxY = GetCurrentMapDungeonLevel()

	if not (a and b and c and d) then
		isMapDungeon = false
		_, a, b, c, d = GetCurrentMapZone()
		--local zoneIndex, locLeft, locTop, locRight, locBottom = GetCurrentMapZone()
	end

	if not (a and b and c and d) then
		return x, y
	end

	local h, w = c - a, d - b
	local dx, dy = x / 100, y / 100

	if isMapDungeon then
		x = d - w * dy
		y = c - h * dx
	else
		x = b + w * dy
		y = a + h * dx
	end

	--print("x=" .. x .. ", y=" .. y)
	return x, y
end

local recentlyHidden = false
local function clearVariable()
	recentlyHidden = false
end

local function show(runAway, x, y, distance, time, legacy, dwayed)
	if DBM:HasMapRestrictions() then return end
	local wowToC = DBM:GetTOC()
	if legacy and wowToC == 80000 then
		DBM:AddMsg("Not Currently Supported in BfA")
		return
	end 
	if not frame:IsShown() and not recentlyHidden then
		DBM:AddMsg(DBM_CORE_ARROW_SUMMONED)
	end
	local player
	if type(x) == "string" then
		player, hideDistance, hideTime = x, y, hideDistance
	end
	frame:Show()
	runAwayArrow = runAway
	hideDistance = distance or runAway and 100 or 3
	if time then
		hideTime = time + GetTime()
	else
		hideTime = nil
	end
	if player then
		targetType = "player"
		targetPlayer = player
	else
		targetType = "fixed"
		if legacy and x >= 0 and x <= 100 and y >= 0 and y <= 100 then
			x, y = MapToWorldCoords(x, y)
		end
		targetX, targetY = x, y
	end
	if dwayed then
		DBM:AddMsg(DBM_ARROW_WAY_SUCCESS)
	end
end

function arrowFrame:ShowRunTo(...)
	return show(false, ...)
end

function arrowFrame:ShowRunAway(...)
	return show(true, ...)
end

-- shows a static arrow
function arrowFrame:ShowStatic(angle, time)
	--Static arrows do not need restrictions, and are still permitted even in 7.1
	runAwayArrow = false
	hideDistance = 0
	targetType = "static"
	targetX = angle * pi2 / 360
	if time then
		hideTime = time + GetTime()
	else
		hideTime = nil
	end
	frame:Show()
end

function arrowFrame:IsShown()
	return frame and frame:IsShown()
end

function arrowFrame:Hide(autoHide)
	recentlyHidden = true
	frame:Hide()
	DBM:Unschedule(clearVariable)
	DBM:Schedule(10, clearVariable)
end

local function endMove()
	frame:EnableMouse(false)
	arrowFrame:Hide()
end

function arrowFrame:Move()
	targetType = "rotate"
	runAwayArrow = false
	hideDistance = 0
	frame:EnableMouse(true)
	frame:Show()
	DBM.Bars:CreateBar(25, DBM_ARROW_MOVABLE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
	DBM:Unschedule(endMove)
	DBM:Schedule(25, endMove)
end

function arrowFrame:LoadPosition()
	frame:SetPoint(DBM.Options.ArrowPoint, DBM.Options.ArrowPosX, DBM.Options.ArrowPosY)
end
