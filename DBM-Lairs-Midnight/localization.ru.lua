if GetLocale() ~= "ruRU" then return end
local L

---------------------------
-- Kith'ix
---------------------------
L = DBM:GetModLocalization(2896)

L:SetOptionLocalization({
	warnAddCasts = "Добавлять общие оповещения заклинаний и целей в период, когда активны большие адды"
})
