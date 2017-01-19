if GetLocale() ~= "koKR" then return end
local L

---------------
-- Skorpyron --
---------------
L= DBM:GetModLocalization(1706)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	NoDebuff	= "%s 없음"
})

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

L:SetMiscLocalization({
	First				= "1번",
	Second				= "2번",
	Third				= "3번"
})

------------------
-- Krosus --
------------------
L= DBM:GetModLocalization(1713)

------------------
-- High Botanist Tel'arn --
------------------
L= DBM:GetModLocalization(1761)

L:SetWarningLocalization({
	warnStarLow				= "플라즈마 구체가 거의 내려옴"
})

L:SetOptionLocalization({
	warnStarLow				= "플라즈마 구체가 거의 내려왔을 때 특수 경고 보기 (15% 이하)"
})

L:SetMiscLocalization({
	RadarMessage			= "레이더는 디버프가 없는 짝을 찾을 때 사용하고 HUD는 다른 디버프를 피할 때 사용하새요. 본 기능이 앞으로 발전되어 더 많은 기능을 제공했으면 좋겠습니다."
})

------------------
-- Star Augur Etraeus --
------------------
L= DBM:GetModLocalization(1732)

L:SetOptionLocalization({
	ShowNeutralColor		= "별자리의 징표가 없는 주변 플레이어를 징표가 사라지기 전까지 HUD에 하얀색 원으로 표시",
	FilterOtherSigns		= "별자리의 징표에 걸리지 않으면 대상 알림을 하지 않습니다."
})

------------------
-- Grand Magistrix Elisande --
------------------
L= DBM:GetModLocalization(1743)

L:SetMiscLocalization({
	noCLEU4EchoRings		= "시간의 파도가 널 덮치기를!"
})

------------------
-- Gul'dan --
------------------
L= DBM:GetModLocalization(1737)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("NightholdTrash")

L:SetGeneralLocalization({
	name =	"밤의 요새 일반몹"
})
