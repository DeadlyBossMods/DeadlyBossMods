if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  Wrathion, the Black Emperor --
---------------------------
L= DBM:GetModLocalization(2368)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
})

---------------------------
--  Maut --
---------------------------
L= DBM:GetModLocalization(2365)

---------------------------
--  The Prophet Skitra --
---------------------------
L= DBM:GetModLocalization(2369)

---------------------------
--  Dark Inquisitor Xanesh --
---------------------------
L= DBM:GetModLocalization(2377)

L:SetMiscLocalization({
	ObeliskSpawn	= "Obelisks of shadow, rise!"--Only as backup, in case the NPC target check stops working
})

---------------------------
--  The Hivemind --
---------------------------
L= DBM:GetModLocalization(2372)

L:SetMiscLocalization({
	Together	= "보스 붙이세요",
	Apart		= "보스 떨어트리세요"
})

---------------------------
--  Shad'har the Insatiable --
---------------------------
L= DBM:GetModLocalization(2367)

---------------------------
-- Drest'agath --
---------------------------
L= DBM:GetModLocalization(2373)

---------------------------
--  Vexiona --
---------------------------
L= DBM:GetModLocalization(2370)

---------------------------
--  Ra-den the Despoiled --
---------------------------
L= DBM:GetModLocalization(2364)

L:SetMiscLocalization({
	Furthest	= "제일 먼 대상",
	Closest		= "가장 가까운 대상"
})

---------------------------
--  Il'gynoth, Corruption Reborn --
---------------------------
L= DBM:GetModLocalization(2374)

L:SetOptionLocalization({
	SetIconOnlyOnce		= "가장 생명력이 낮은 쫄을 탐지해서 징표를 한번만 지정하고 죽을때까지 징표 유지",
	InterruptBehavior	= "혈류 공급 차단 방식 설정 (공대장일 경우 다른 사람의 설정보다 우선 적용)",
	Two				= "2인 로테이션 ",--Default
	Three				= "3인 로테이션 ",
	Four				= "4인 로테이션 ",
	Five				= "5인 로테이션 "
})

---------------------------
--  Carapace of N'Zoth --
---------------------------
L= DBM:GetModLocalization(2366)

---------------------------
--  N'Zoth, the Corruptor --
---------------------------
L= DBM:GetModLocalization(2375)

L:SetMiscLocalization({
	ExitMind		= "정신세계 탈출",
	Away			= "뒤로",
	Toward			= "앞으로"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NyalothaTrash")

L:SetGeneralLocalization({
	name =	"나이알로사 일반몹"
})

