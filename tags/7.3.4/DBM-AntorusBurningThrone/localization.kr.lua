if GetLocale() ~= "koKR" then return end
local L

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"지금 시전할 스킬보다 이전에 시전했던 스킬의 쿨타임 타이머를 뒤로 배열합니다. 이 기능은 타이머가 뒤섞인 것의 정확도를 맞추는데 들어가는 비용을 감소시킵니다 (1-2초 빠르게 맞춰짐)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"자신의 위치와 관계 없이 모든 공대원의 단상 위치 알림 보기"
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"전투의 전반적인 상황을 정보 창에 표시"
})

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetTimerLocalization({
	timerBossIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerBossIncoming		= "다음 보스 교대 타이머 바 보기"
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"안토러스 일반몹"
})
