---@class DBM
local DBM = DBM

---@class DBMCoreNamespace
local private = select(2, ...)

---------------
--  Globals  --
---------------
---@class DBMBattleRezTimer
local BattleRezTimer = {}
DBM.BattleRezTimer = BattleRezTimer

local difficulties = private:GetPrototype("Difficulties")

local L = DBM_CORE_L

local floor, GetTime, mod = math.floor, GetTime, math.fmod
local standardFont = private.standardFont

-- State
---@type Frame?
local frame
---@type unknown?
local updateTicker
local chargesActive = false
local lastCharges = -1

local function CancelPreviewTimer()
	if BattleRezTimer._previewHideTimer then
		BattleRezTimer._previewHideTimer:Cancel()
		BattleRezTimer._previewHideTimer = nil
	end
end

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
	frame:SetScript("OnDragStart", function(self)
		self:StartMoving()
	end)
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		if point then
			DBM.Options.BattleRezPosition = { point, x, y }
		end
	end)

	ApplyFont()
end

local function ApplyPosition()
	if not frame then return end
	frame:ClearAllPoints()
	local pos = DBM.Options.BattleRezPosition
	if pos and pos[1] then
		frame:SetPoint(pos[1], UIParent, pos[1], pos[2], pos[3])
	else
		-- Default position if not yet saved
		frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)
	end
end

ApplyFont = function()
	if not frame then return end
	-- Guard against DBM.Options not being initialized yet (race condition during load)
	if not DBM.Options then return end
	-- Select font with nil fallback to standardFont
	local fontOption = DBM.Options.BrezFont
	local font = (not fontOption or fontOption == "standardFont") and standardFont or fontOption
	if not font then
		font = standardFont  -- Additional safety fallback
	end
	local size = DBM.Options.BrezFontSize or 18
	frame.charges:SetFont(font, size, "OUTLINE")
	frame.timer:SetFont(font, size, "OUTLINE")
	-- Resize frame to fit font: height = font + padding for backdrop insets, width scales proportionally
	frame:SetSize(size * 7 + 14, size + 12)
end

---------------------------------------
-- Update Logic
---------------------------------------
local UpdateDisplay
do
	local GetSpellCharges = C_Spell.GetSpellCharges
	UpdateDisplay = function()
		-- Check if frame should be hidden due to option being disabled
		if not DBM.Options.ShowBrezFrame then
			if updateTicker then
				updateTicker:Cancel()
				updateTicker = nil
			end
			if frame then
				frame:Hide()
			end
			-- Reset state for re-enabling
			chargesActive = false
			lastCharges = -1
			return
		end

		local chargeInfo = GetSpellCharges(20484) -- Rebirth (shared combat res pool)
		if not chargeInfo then
			-- No longer in applicable combat
			if chargesActive then
				chargesActive = false
				lastCharges = -1
				if updateTicker then
					updateTicker:Cancel()
					updateTicker = nil
				end
				if frame then
					frame:Hide()
				end
			end
			return
		end

		local charges = chargeInfo.currentCharges
		local maxCharges = chargeInfo.maxCharges
		local startTime = chargeInfo.cooldownStartTime
		local duration = chargeInfo.cooldownDuration

		-- Combat start detection
		if not chargesActive then
			chargesActive = true
			lastCharges = -1
			-- Cancel any preview auto-hide timer now that combat has started
			CancelPreviewTimer()
			if DBM.Options.ShowBrezFrame and frame then
				ApplyPosition()
				frame:EnableMouse(false)
				frame.header:Hide()
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
			local s = floor(mod(remaining, 60))
			if frame then
				frame.timer:SetText(("%d:%02d"):format(m, s))
			end
		else
			if frame then
				frame.timer:SetText("0:00")
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
		--Active Keystone (entire dungeon is one encounter)
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
		local isSupported = shouldShowFrame()
		local shouldDisplay = isSupported
		if shouldDisplay then
			if not updateTicker then
				updateTicker = C_Timer.NewTicker(1, UpdateDisplay)
			end
			UpdateDisplay()
		else
			if updateTicker then
				updateTicker:Cancel()
				updateTicker = nil
			end
			-- Cancel any pending preview auto-hide timer
			CancelPreviewTimer()
			if frame then
				frame:Hide()
			end
			-- Always reset tracking state so re-enabling options forces a full refresh
			chargesActive = false
			lastCharges = -1
		end
	end
	function BattleRezTimer:CheckSupported()
		--Frame delay it to allow time for APIs or combat to return true
		DBM:Unschedule(frameDelay)
		if DBM.Options.ShowBrezFrame then
			DBM:Schedule(1, frameDelay) -- Delay to allow combat log to update
		else
			-- Option disabled: immediately stop ticker, hide frame, reset state
			if updateTicker then
				updateTicker:Cancel()
				updateTicker = nil
			end
			-- Cancel any pending preview auto-hide timer
			CancelPreviewTimer()
			if frame then
				frame:Hide()
			end
			chargesActive = false
			lastCharges = -1
		end
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
	-- When in active combat, respect the ShowBrezFrame option
	if chargesActive and not DBM.Options.ShowBrezFrame then
		return
	end

	-- Out-of-combat preview: toggle visibility
	if not chargesActive then
		if frame:IsShown() then
			CancelPreviewTimer()
			self:Hide()
			return
		end
		CancelPreviewTimer()
	end

	ApplyPosition()
	ApplyFont()

	-- Unlock for positioning when in preview (out of combat)
	if not chargesActive then
		frame:EnableMouse(true)
		frame.header:Show()
		frame.charges:SetText("0")
		frame.charges:SetTextColor(1, 1, 1)
		frame.timer:SetText("0:00")
	else
		frame:EnableMouse(false)
		frame.header:Hide()
	end

	frame:Show()

	-- Auto-hide preview after 15 seconds if still out of combat
	if not chargesActive then
		local brt = self
		self._previewHideTimer = C_Timer.NewTimer(15, function()
			if not chargesActive and frame and frame:IsShown() then
				frame:Hide()
			end
			brt._previewHideTimer = nil
		end)
	end
end

--- Hide the frame
function BattleRezTimer:Hide()
	if not frame then return end
	if not chargesActive then
		CancelPreviewTimer()
		frame:Hide()
	end
end

function BattleRezTimer:IsShown()
	return frame and frame:IsShown()
end
