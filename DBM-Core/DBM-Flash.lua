---------------
--  Globals  --
---------------
DBM.Flash = {}

--------------
--  Locals  --
--------------
local flashFrame = DBM.Flash
local frame, r, g, b, t, a, duration
local elapsed, totalRepeat = 0, 0

--------------------
--  Create Frame  --
--------------------
frame = CreateFrame("Frame", "DBMFlash", UIParent, DBM:IsAlpha() and "BackdropTemplate")
frame:Hide()
frame.backdropInfo = {
	bgFile	= "Interface\\Tooltips\\UI-Tooltip-Background" -- 137056
}
if not DBM:IsAlpha() then
	frame:SetBackdrop(frame.backdropInfo)
else
	frame:ApplyBackdrop()
end
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
			if totalRepeat >= 1 then
				flashFrame:Show(r, g, b, t, a, totalRepeat - 1)
			end
			return
		end
		self:SetAlpha(-(elapsed / (duration / 2) - 1) ^ 2 + 1)
	end)
	frame:Hide()
end

function flashFrame:Show(red, green, blue, dur, alpha, repeatFlash)
	r, g, b, t, a = red or 1, green or 0, blue or 0, dur or 0.4, alpha or 0.3
	duration = dur
	elapsed = 0
	totalRepeat = repeatFlash or 0
	frame:SetAlpha(0)
	frame.backdropColor = CreateColor(r, g, b)
	frame.backdropColorAlpha = a
	if not DBM:IsAlpha() then
		frame:SetBackdropColor(r, g, b, a)
	else
		frame:ApplyBackdrop()
	end
	frame:Show()
end

function flashFrame:IsShown()
	return frame and frame:IsShown()
end

function flashFrame:Hide()
	frame:Hide()
end
