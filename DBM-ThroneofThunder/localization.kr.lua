if GetLocale() ~= "koKR" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetOptionLocalization({
	RangeFrame		= "$spell:139997 주문에 대한 거리 창 보기(8m)"
})

--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetTimerLocalization({
	timerAddsCD		= "다음 부족의 문 열림",
})

L:SetOptionLocalization({
	timerAddsCD		= "다음 부족의 문 열림 바 표시",
})

L:SetMiscLocalization({
	newForces		= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	warnPossessed	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136442),
	warnSandBolt	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(136189),
	RangeFrame		= "거리 창 보기"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	specWarnCrystalShell	= "%s 받으세요!"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "$spell:137633 효과가 없을 경우 특수 경고 보기",
	InfoFrame				= "$spell:137633 효과가 없는 대상을 정보 창에서 보기"
})

L:SetMiscLocalization({
	WrongDebuff		= "%s 없음"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetMiscLocalization({
	eggsHatch	= "The eggs in one of the lower nests begin to hatch!"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	specWarnDisintegrationBeam	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(133775)
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame		= "거리 창 보기(5m/2m)"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s: >%s<, >%s< 자리바뀜"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "$spell:138618 대상 알림"
})

L:SetMiscLocalization({
	Pull		= "The orb explodes!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s: %s, %s 봉쇄됨"
})

L:SetOptionLocalization({
	warnDeadZone	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(137229),
	RangeFrame		= "전투 진영에 따라 거리 창 보기\n(일정 인원 이상이 뭉쳐 있을 때만 표시되는 똑똑한 거리 창 입니다.)"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetOptionLocalization({
	RangeFrame		= "거리 창 보기(8m)"
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame		= "거리 창 보기"
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

