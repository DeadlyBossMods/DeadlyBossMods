if GetLocale() ~= "koKR" then return end
local L

---------------------------
-- Kith'ix
---------------------------
L = DBM:GetModLocalization(2896)

L:SetOptionLocalization({
	warnAddCasts = "큰 쫄 등장 구간 동안 관련 주문과 대상 알림 추가"
})
