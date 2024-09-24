if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Ulgrax the Devourer (2902) --
---------------------------
--L= DBM:GetModLocalization(2607)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  The Bloodbound Horror (2917) --
---------------------------
--L= DBM:GetModLocalization(2611)

---------------------------
--  Sikran, Captain of the Sureki (2898) --
---------------------------
--L= DBM:GetModLocalization(2599)

---------------------------
--  Rasha'nan (2918) --
---------------------------
--L= DBM:GetModLocalization(2609)

---------------------------
--  Bloodtwister Ovi'nax (2919) --
---------------------------
L= DBM:GetModLocalization(2612)

L:SetOptionLocalization({
	EggBreakerBehavior	= "알 깨기 작동 방식 설정 (공대장이면 이 설정을 다른 사람의 설정보다 우선 적용)",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.CROSS_ICON_SMALL .. " (모든 난이도) 징표를 근딜 > 원거리 > 힐러순으로 (Bigwigs 작동 방식에 맞춤)",--Default
	MatchEW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.CROSS_ICON_SMALL .. " (신화 이외) ".. DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. " (신화) 근딜 > 원거리 > 힐러순으로 (Echo 버전 Bigwigs 작동 방식에 맞춤)",
	UseAllAscending		= "|TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:0:16:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:16:32:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:32:48:0:16|t, |TInterface\\TargetingFrame\\UI-RaidTargetingIcons.blp:13:13:0:0:64:64:48:64:0:16|t, 기타 징표를 근딜 > 원거리 > 힐러순으로",
	DisableIconsForRaid	= "대상에 징표를 설정하지 않고 징표 없는 말풍선 알림만 표시",
	DisableAllForRaid	= "징표 설정과 말풍선 알림 모두 끄기"
})

---------------------------
--  Nexus-Princess Ky'veza(2920) --
---------------------------
--L= DBM:GetModLocalization(2601)

---------------------------
--  The Silken Court (2921) --
---------------------------
L= DBM:GetModLocalization(2608)

L:SetMiscLocalization({
	Red		= " [빨강]",--Skeinspinner Takazj
	Blue	= " [파랑]"--Anub'arash
})

---------------------------
--  Queen Ansurek (2922) --
---------------------------
L= DBM:GetModLocalization(2602)

L:SetOptionLocalization({
	ToxinBehavior		= "반응성 독소 작동 방식 설정 (공대장이면 이 설정을 다른 사람의 설정보다 우선 적용)",
	MatchBW				= DBM_COMMON_L.SQUARE_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL .. " (모든 난이도) 징표를 근딜 > 원거리 > 힐러순으로 (Bigwigs 작동 방식에 맞춤)",--Default
	UseAllAscending		= DBM_COMMON_L.STAR_ICON_SMALL ..", ".. DBM_COMMON_L.CIRCLE_ICON_SMALL ..", ".. DBM_COMMON_L.DIAMOND_ICON_SMALL ..", ".. DBM_COMMON_L.TRIANGLE_ICON_SMALL ..", ".. DBM_COMMON_L.MOON_ICON_SMALL .. " (모든 난이도) 근딜 > 원거리 > 힐러순으로",
	DisableIconsForRaid	= "대상에 징표를 설정하지 않고 징표 없는 말풍선 알림만 표시",
	DisableAllForRaid	= "징표 설정과 말풍선 알림 모두 끄기"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NerubarPalaceTrash")

L:SetGeneralLocalization({
	name =	"네룹아르 궁전 일반몹"
})
