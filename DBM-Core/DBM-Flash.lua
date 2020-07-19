---------------
--  Globals  --
---------------
DBM.Flash = {}

--------------
--  Locals  --
--------------
local flashFrame = DBM.Flash
local frame, duration, elapsed, totalRepeat

--------------------
--  Create Frame  --
--------------------
frame = CreateFrame("Frame", "DBMFlash", UIParent, DBM:IsAlpha() and "BackdropTemplate")
frame:Hide()
frame.backdropInfo = {
	bgFile	= "Interface\\Tooltips\\UI-Tooltip-Background" -- 137056
}
if DBM:IsAlpha() then
	frame:ApplyBackdrop()
else
	frame:SetBackdrop(frame.backdropInfo)
end
frame:SetAllPoints(UIParent)
frame:SetFrameStrata("BACKGROUND")
frame:Hide()

------------------------
--  OnUpdate Handler  --
------------------------
frame:SetScript("OnUpdate", function(self, e)
	elapsed = elapsed + e
	if elapsed >= duration then
		if totalRepeat == 0 then
			self:Hide()
			return
		end
		elapsed = 0
		totalRepeat = totalRepeat - 1
		self:SetAlpha(0)
		return
	end
	self:SetAlpha(-(elapsed / (duration / 2) - 1) ^ 2 + 1)
end)

function flashFrame:Show(red, green, blue, dur, alpha, repeatFlash)
	duration = dur or 0.4
	elapsed = 0
	totalRepeat = repeatFlash or 0
	-- frame.Center:SetVertexColor(red or 1, green or 0, blue or 0, alpha or 0.3) -- Uncomment in 9.0
	frame:SetBackdropColor(red or 1, green or 0, blue or 0, alpha or 0.3)
	frame:Show()
end

function flashFrame:IsShown()
	return frame and frame:IsShown()
end

function flashFrame:Hide()
	frame:Hide()
end
