-- globals
DBM.Flash = {}
-- locals
local flashFrame = DBM.Flash
local r, g, b, t, a
local duration
local elapsed = 0
local totalRepeat = 0

--------------------
--  Create Frame  --
--------------------
local frame = CreateFrame("Frame", "DBMFlash", UIParent)
frame:Hide()
frame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",})
frame:SetAllPoints(UIParent)
frame:SetFrameStrata("BACKGROUND")

------------------------
--  OnUpdate Handler  --
------------------------
do
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= t then
			self:Hide()
			self:SetAlpha(0)
			if totalRepeat >= 1 then--Keep repeating until totalRepeat = 0
				flashFrame:Show(r, g, b, t, a, totalRepeat-1)
			end
			return
		end
		-- quadratic fade in/out
		self:SetAlpha(-(elapsed / (duration / 2) - 1)^2 + 1)
	end)
	frame:Hide()
end

function flashFrame:Show(red, green, blue, dur, alpha, repeatFlash)
	r, g, b, t, a = red or 1, green or 0, blue or 0, dur or 0.4, alpha or 0.3
	duration = dur
	elapsed = 0
	totalRepeat = repeatFlash or 0
	frame:SetAlpha(0)
	frame:SetBackdropColor(r, g, b, a)
	frame:Show()
end

function flashFrame:IsShown()
	return frame and frame:IsShown()
end

function flashFrame:Hide()
	frame:Hide()
end
