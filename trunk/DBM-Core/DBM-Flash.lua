DBM.Flash = {}
local r, g, b, t, a
local t2

--------------------
--  Create Frame  --
--------------------
flashFrame = CreateFrame("Frame", "DBMFlash", UIParent)
flashFrame:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",})
flashFrame:SetAllPoints(UIParent)
flashFrame:SetFrameStrata("BACKGROUND")

------------------------
--  OnUpdate Handler  --
------------------------
do
	flashFrame:SetScript("OnUpdate", function(self, elapsed)
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
	flashFrame:Hide()
end

function DBM.Flash:Show(red, green, blue, dur, alpha)
	if not DBM.Options.ShowFlashFrame then return end
	r, g, b, t, a = red, green, blue, dur or 1, alpha or 0.5
	t2 = t / 2
	flashFrame.TimeSinceLastUpdate = 0
	flashFrame:SetAlpha(0)
	flashFrame:SetBackdropColor(r, g, b, a)
	flashFrame:Show()
end
