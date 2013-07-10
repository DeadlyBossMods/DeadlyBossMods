-- globals
DBM.Flash = {}
-- locals
local flashFrame = DBM.Flash
local r, g, b, t, a
local t2

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
	frame:SetScript("OnUpdate", function(self, elapsed)
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed
		if self.TimeSinceLastUpdate >= t then
			self:Hide()
			self:SetAlpha(0)
			return
		end
		if self.TimeSinceLastUpdate >= t2 then
			self:SetAlpha(t - self.TimeSinceLastUpdate)
		else
			self:SetAlpha(self.TimeSinceLastUpdate)
		end
	end)
	frame:Hide()
end

function flashFrame:Show(red, green, blue, dur, alpha)
	if not DBM.Options.ShowFlashFrame then return end
	r, g, b, t, a = red or 1, green or 0, blue or 0, dur or 1, alpha or 0.5
	t2 = t / 2
	frame.TimeSinceLastUpdate = 0
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
