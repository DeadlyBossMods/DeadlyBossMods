if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- <<<Atal'Dazar >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("AtalDazarTrash")

L:SetGeneralLocalization({
	name =	"아탈다자르 일반몹"
})

-----------------------
-- <<<Freehold >>> --
-----------------------
-----------------------
-- Council o' Captains --
-----------------------
L= DBM:GetModLocalization(2093)

L:SetWarningLocalization({
	warnGoodBrew		= "%s 시전: 3초",
	specWarnBrewOnBoss	= "버프 맥주 - %s 자리로 이동"
})

L:SetOptionLocalization({
	warnGoodBrew		= "버프 맥주가 시전되면 경고 보기",
	specWarnBrewOnBoss	= "보스 자리에 버프 맥주가 나오면 특별 경고 보기"
})

L:SetMiscLocalization({
	critBrew		= "극대화 맥주",
	hasteBrew		= "가속 맥주"
})

-----------------------
-- Ring of Booty --
-----------------------
L= DBM:GetModLocalization(2094)

L:SetMiscLocalization({
	openingRP = "자, 다들 판돈을 거십시오! 여기 새로운 호구... 아니, 선수가 등장했습니다! 굴그토크, 우딘, 시작해!"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("FreeholdTrash")

L:SetGeneralLocalization({
	name =	"자유지대 일반몹"
})

-----------------------
-- <<<Kings' Rest >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("KingsRestTrash")

L:SetGeneralLocalization({
	name =	"왕들의 안식처 일반몹"
})

-----------------------
-- <<<Shrine of the Storm >>> --
-----------------------
-----------------------
-- Lord Stormsong --
-----------------------
L= DBM:GetModLocalization(2155)

L:SetMiscLocalization({
	openingRP	= "손님이 있는 것 같군, 스톰송 군주."
})

---------
--Trash--
---------
L = DBM:GetModLocalization("SotSTrash")

L:SetGeneralLocalization({
	name =	"폭풍의 사원 일반몹"
})

-----------------------
-- <<<Siege of Boralus >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("BoralusTrash")

L:SetGeneralLocalization({
	name =	"보랄러스 공성전 일반몹"
})

-----------------------
-- <<<Temple of Sethraliss>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("SethralissTrash")

L:SetGeneralLocalization({
	name =	"세스랄리스 사원 일반몹"
})

-----------------------
-- <<<MOTHERLOAD>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("UndermineTrash")

L:SetGeneralLocalization({
	name =	"왕노다지 광산!! 일반몹"
})

-----------------------
-- <<<The Underrot>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("UnderrotTrash")

L:SetGeneralLocalization({
	name =	"썩은굴 일반몹"
})

-----------------------
-- <<<Tol Dagor >>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("TolDagorTrash")

L:SetGeneralLocalization({
	name =	"톨 다고르 일반몹"
})

-----------------------
-- <<<Waycrest Manor>>> --
-----------------------
---------
--Trash--
---------
L = DBM:GetModLocalization("WaycrestTrash")

L:SetGeneralLocalization({
	name =	"웨이크레스트 저택 일반몹"
})

-----------------------
-- <<<Operation: Mechagon>>> --
-----------------------
-----------------------
-- Tussle Tonks --
-----------------------
L= DBM:GetModLocalization(2336)

L:SetMiscLocalization({
	openingRP		= "통계상으로 아주 이례적인 일이군요! 방문객들이 아직 살아 있었습니다!"
})

---------
--Trash--
---------
L = DBM:GetModLocalization("MechagonTrash")

L:SetGeneralLocalization({
	name =	"메카곤 일반몹"
})
