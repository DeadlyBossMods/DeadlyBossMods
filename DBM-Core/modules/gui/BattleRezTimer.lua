---@class DBMCoreNamespace
local private = select(2, ...)

---@class DBM
local DBM = private:GetPrototype("DBM")
local difficulties = private:GetPrototype("Difficulties")

---@class DBMBattleRezTimer
local BattleRezTimer = {}
DBM.BattleRezTimer = BattleRezTimer

local L = DBM_CORE_L

local floor, GetTime, mod = math.floor, GetTime, mod
local standardFont = private.standardFont

-- State
local frame
local updateTicker
local inCombat = false
local lastCharges = -1
local isSupported = false

---@type DBT
local DBT = DBT

---------------------------------------
-- Display Frame
---------------------------------------
local ApplyFont
local function CreateDisplayFrame()
	frame = CreateFrame("Frame", "DBMBattleRezTimerFrame", UIParent, "BackdropTemplate")
	frame:SetSize(140, 30)
	frame:SetClampedToScreen(true)
	frame:SetMovable(true)
	frame:SetFrameStrata("MEDIUM")
	frame:Hide()

	frame.backdropInfo = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 12,
		insets = { left = 3, right = 3, top = 3, bottom = 3 },
	}
	frame:ApplyBackdrop()
	frame:SetBackdropColor(0, 0, 0, 0.7)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 0.8)

	-- Charges text (left side)
	local charges = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge2")
	charges:SetPoint("LEFT", frame, "LEFT", 10, 0)
	charges:SetJustifyH("LEFT")
	charges:SetTextColor(1, 1, 1)
	charges:SetText("0")
	frame.charges = charges

	-- Timer text (right side)
	local timer = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge2")
	timer:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
	timer:SetJustifyH("RIGHT")
	timer:SetTextColor(1, 1, 1)
	timer:SetText("0:00")
	frame.timer = timer

	-- Header (shown when unlocked for positioning)
	local header = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	header:SetPoint("BOTTOM", frame, "TOP", 0, 2)
	header:SetJustifyH("CENTER")
	header:SetText(L.BREZ_HEADER)
	header:Hide()
	frame.header = header

	-- Drag handling
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		DBM.Options.BattleRezPosition = { point, x, y }
	end)

	ApplyFont()
end

local function ApplyPosition()
	if not frame then return end
	frame:ClearAllPoints()
	local pos = DBM.Options.BattleRezPosition
	frame:SetPoint(pos[1], pos[2], pos[3])
end

ApplyFont = function()
	if not frame then return end
	local font = DBM.Options.BrezFont == "standardFont" and standardFont or DBM.Options.BrezFont
	local size = DBM.Options.BrezFontSize or 18
	frame.charges:SetFont(font, size, "OUTLINE")
	frame.timer:SetFont(font, size, "OUTLINE")
	-- Resize frame to fit font: height = font + padding for backdrop insets, width scales proportionally
	frame:SetSize(size * 7 + 14, size + 12)
end

local function ApplyLock()
	if not frame then return end
	if DBM.Options.LockBrezFrame then
		frame:EnableMouse(false)
		frame.header:Hide()
	else
		frame:EnableMouse(true)
		frame.header:Show()
	end
end

---------------------------------------
-- Update Logic
---------------------------------------
local UpdateDisplay
do
	local GetSpellCharges = C_Spell.GetSpellCharges
	UpdateDisplay = function()
		local chargeInfo = GetSpellCharges(20484) -- Rebirth (shared combat res pool)
		if not chargeInfo then
			-- No longer in applicable combat
			if inCombat then
				inCombat = false
				lastCharges = -1
				if updateTicker then
					updateTicker:Cancel()
					updateTicker = nil
				end
				if frame then
					frame:Hide()
				end
				-- Cancel DBM bar if active
				if DBM.Options.ShowBrezBar then
					DBT:CancelBar(L.COMBAT_RES_TIMER_TEXT)
				end
			end
			return
		end

		local charges = chargeInfo.currentCharges
		local maxCharges = chargeInfo.maxCharges
		local startTime = chargeInfo.cooldownStartTime
		local duration = chargeInfo.cooldownDuration

		-- Combat start detection
		if not inCombat then
			inCombat = true
			lastCharges = -1
			if DBM.Options.ShowBrezFrame and frame then
				ApplyPosition()
				ApplyLock()
				frame:Show()
			end
		end

		-- Update charges display
		if charges ~= lastCharges then
			lastCharges = charges
			if frame then
				frame.charges:SetText(tostring(charges))
				if charges == 0 then
					frame.charges:SetTextColor(1, 0, 0)
				elseif charges == maxCharges then
					frame.charges:SetTextColor(0, 1, 0)
				else
					frame.charges:SetTextColor(1, 1, 0)
				end
			end
		end

		-- Update timer display
		if charges < maxCharges and duration > 0 then
			local remaining = duration - (GetTime() - startTime)
			if remaining < 0 then remaining = 0 end
			local m = floor(remaining / 60)
			local s = mod(remaining, 60)
			if frame then
				frame.timer:SetText(("%d:%02d"):format(m, s))
			end
			-- DBM bar option
			if DBM.Options.ShowBrezBar then
				DBT:CreateBar(remaining, L.COMBAT_RES_TIMER_TEXT, 134222) -- spell_nature_reincarnation
			end
		else
			if frame then
				frame.timer:SetText("0:00")
			end
			if DBM.Options.ShowBrezBar then
				DBT:CancelBar(L.COMBAT_RES_TIMER_TEXT)
			end
		end
	end
end

---------------------------------------
-- Instance Check
---------------------------------------
do
	local supportedDifficulties = {
		[14] = true,	-- Normal Raid
		[15] = true,	-- Heroic Raid
		[16] = true,	-- Mythic Raid
		[17] = true,	-- LFR
		[23] = true,	-- Mythic 0
	}
	-- Difficulty IDs that use the shared combat res charge pool
	local function shouldShowFrame()
		--Active Keystone
		if difficulties.difficultyIndex == 8 then
			return true
		end
		--Not in correct zone, return false
		if not supportedDifficulties[difficulties.difficultyIndex] then
			return false
		end
		--In combat with a boss return true
		if DBM:InCombat() then
			return true
		end
		return false
	end

	local function frameDelay()
		local wasSupported = isSupported
		isSupported = shouldShowFrame()
		if isSupported and (DBM.Options.ShowBrezFrame or DBM.Options.ShowBrezBar) then
			if not updateTicker then
				updateTicker = C_Timer.NewTicker(1, UpdateDisplay)
			end
			UpdateDisplay()
		elseif not isSupported and wasSupported then
			if updateTicker then
				updateTicker:Cancel()
				updateTicker = nil
			end
			inCombat = false
			lastCharges = -1
			if frame then
				frame:Hide()
			end
			if DBM.Options.ShowBrezBar then
				DBT:CancelBar(L.COMBAT_RES_TIMER_TEXT)
			end
		end
	end
	function BattleRezTimer:CheckSupported()
		--Frame delay it to allow time for apis or combat to return true
		DBM:Unschedule(frameDelay)
		DBM:Schedule(1, frameDelay) -- Delay to allow combat log to update
	end
end

CreateDisplayFrame()

---------------------------------------
-- Public API
---------------------------------------

function BattleRezTimer:UpdateStyle()
	ApplyFont()
end

--- Show the frame for manual positioning (out of combat preview)
function BattleRezTimer:Show()
	if not frame then return end
	ApplyPosition()
	ApplyFont()
	-- Temporarily unlock for positioning
	frame:EnableMouse(true)
	frame.header:Show()
	frame.charges:SetText("0")
	frame.charges:SetTextColor(1, 1, 1)
	frame.timer:SetText("0:00")
	frame:Show()
end

--- Hide the frame
function BattleRezTimer:Hide()
	if not frame then return end
	if not inCombat then
		frame:Hide()
	end
end
