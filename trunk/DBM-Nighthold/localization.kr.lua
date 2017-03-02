if GetLocale() ~= "koKR" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

---------------------------
-- Chronomatic Anomaly --
---------------------------
L= DBM:GetModLocalization(1725)

---------------------------
-- Trilliax --
---------------------------
L= DBM:GetModLocalization(1731)

------------------
-- Spellblade Aluriel --
------------------
L= DBM:GetModLocalization(1751)

------------------
-- Tichondrius --
------------------
L= DBM:GetModLocalization(1762)

L:SetOptionLocalization({
	HUDSeekerLines		= "추적 박쥐떼 경로에 HUD 표시"
})

L:SetMiscLocalization({
	First				= "1번 낙인",
	Second				= "2번 낙인",
	Third				= "3번 낙인",
	Adds1				= "부하들아! 이리 와라!",
	Adds2				= "이 멍청이들에게 싸우는 법을 알려 줘라!"
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

L:SetWarningLocalization({
	warnSlamSoon		= "%d초 후 다리 파괴"
})

L:SetOptionLocalization({
	warnSlamSoon		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon:format(205862)
})

L:SetMiscLocalization({
	MoveLeft			= "왼쪽으로 이동",
	MoveRight			= "오른쪽으로 이동"
})

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "플라스마 구체 체력 낮음"
})

L:SetOptionLocalization({
	warnStarLow				= "플라스마 구체 체력이 낮으면 특수 경고 보기 (25% 이하)"
})

L:SetMiscLocalization({
	RadarMessage			= "레이더는 디버프가 없는 짝을 찾을 때 사용하고 HUD는 다른 디버프를 피할 때 사용하세요. 본 기능이 앞으로 발전되어 더 많은 기능을 제공했으면 좋겠습니다."
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowCustomNPAuraTextures	= "별자리의 징표에 걸리면 징표 디버프 대신 사용자 지정 녹색/빨간색 아이콘 표시",
	FilterOtherSigns		= "당신이 걸리지 않은 징표는 대상 알림에서 제외합니다."
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetTimerLocalization({
	timerFastTimeBubble		= "시간 빠름 바닥 (%d)",
	timerSlowTimeBubble		= "시간 느림 바닥 (%d)"
})

L:SetOptionLocalization({
	timerFastTimeBubble		= "$spell:209166 바닥 타이머 바 보기",
	timerSlowTimeBubble		= "$spell:209165 바닥 타이머 바 보기"
})

L:SetMiscLocalization({
	noCLEU4EchoRings		= "시간의 파도가 널 덮치기를!",
	noCLEU4EchoOrbs				= "시간은 제멋대로 사라져 버리지.",
	prePullRP				= "모두 예견했다. 너희를 여기로 이끈 운명의 실마리를. 군단을 막으려는 너희의 필사적인 몸부림을."
})

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

L:SetMiscLocalization({
	mythicPhase3		= "악마사냥꾼의 영혼을 육신으로 돌려보내야 할 때요... 군단의 주인을 거부해야 하오!",
	prePullRP			= "아, 그래, 영웅들이 납셨군. 아주 끈질겨... 자신감이 넘치고. 그 오만 때문에 파멸할 것이다!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"밤의 요새 일반몹"
})
