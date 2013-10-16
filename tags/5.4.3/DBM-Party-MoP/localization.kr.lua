if GetLocale() ~= "koKR" then return end
local L

-----------------------
-- <<<Temple of the Jade Serpent>>> --
-----------------------
-----------------------
-- Wise Mari --
-----------------------
L= DBM:GetModLocalization(672)

-----------------------
-- Lorewalker Stonestep --
-----------------------
L= DBM:GetModLocalization(664)

L:SetWarningLocalization({
	SpecWarnIntensity	= "%s : %s (%d)"
})

-----------------------
-- Liu Flameheart --
-----------------------
L= DBM:GetModLocalization(658)

-----------------------
-- Sha of Doubt --
-----------------------
L= DBM:GetModLocalization(335)

-----------------------
-- <<<Stormstout Brewery>>> --
-----------------------
-----------------------
-- Ook-Ook --
-----------------------
L= DBM:GetModLocalization(668)

-----------------------
-- Hoptallus --
-----------------------
L= DBM:GetModLocalization(669)

-----------------------
-- Yan Zhu the Uncasked --
-----------------------
L= DBM:GetModLocalization(670)

L:SetWarningLocalization({
	SpecWarnFizzyBubbles	= "거품 방울 클릭 후 날아다니세요!"
})

L:SetOptionLocalization({
	SpecWarnFizzyBubbles	= "$spell:114459 효과가 없을 경우 특수 경고 보기"
})

-----------------------
-- <<<Shado-Pan Monastery>>> --
-----------------------
-----------------------
-- Gu Cloudstrike --
-----------------------
L= DBM:GetModLocalization(673)

L:SetWarningLocalization({
	warnStaticField	= "%s"
})

-----------------------
-- Snowdrift --
-----------------------
L= DBM:GetModLocalization(657)

L:SetWarningLocalization({
	warnRemainingNovice	= "음영파 신입생 : %d 남음"
})

L:SetOptionLocalization({
	warnRemainingNovice	= "음영파 신입생 남은횟수 알림 보기"
})

L:SetMiscLocalization({
	NovicesPulled		= "네 이놈들! 너희가 잠들어 있던 샤를 깨운 놈들이로구나!",
	NovicesDefeated 	= "갓 들어온 신참들보다는 강하구나. 그럼 우리의 상급생 둘을 상대해 봐라."
})

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

L:SetMiscLocalization({
	Kill		= "네 가슴이 폭력에 물들어 있는 한... 난... 다시... 돌아올 것이다."
})

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

L:SetOptionLocalization({
	InfoFrame			= "$journal:5827 정보를 정보 창으로 보기"
})

-----------------------
-- <<<The Gate of the Setting Sun>>> --
-----------------------
---------------------
-- Kiptilak --
---------------------
L= DBM:GetModLocalization(655)

-------------
-- Gadok --
-------------
L= DBM:GetModLocalization(675)

L:SetMiscLocalization({
	StaffingRun		= "포격 질주"
})

-----------------------
-- Rimok --
-----------------------
L= DBM:GetModLocalization(676)

-----------------------------
-- Raigonn --
-----------------------------
L= DBM:GetModLocalization(649)

-----------------------
-- <<<Mogu'Shan Palace>>> --
-----------------------
-----------------------
-- Trial of Kings --
-----------------------
L= DBM:GetModLocalization(708)

L:SetMiscLocalization({
	Pull		= "만회, 아니, 증명해라. 침입자들을 처치해라. 놈들의 머리를 바치는 부족은 내 총애를 얻을 것이다!",
	Kuai		= "구르단 부족이 폐하와 권력에 굶주린 너희 애송이들에게 보여주마. 왜 우리가 폐하를 보좌해야 하는지!",
	Ming		= "하르닥 부족이 왜 모구 최고의 부족인지 보여주마!",
	Haiyan		= "왜 카게쉬 부족이 왕을 보좌할 만한 힘을 가진 유일한 부족인지 보여주겠다!",
	Defeat		= "누가 우리 전당에 외부인을 들였지? 하르닥과 카게쉬 부족 놈들이나 이런 배신을 저지를 것이다!"
})

-----------------------
-- Gekkan --
-----------------------
L= DBM:GetModLocalization(690)

-----------------------
-- Weaponmaster Xin --
-----------------------
L= DBM:GetModLocalization(698)

-----------------------
-- <<<Siege of Niuzao Temple>>> --
-----------------------
-----------------------
-- Jinbak --
-----------------------
L= DBM:GetModLocalization(693)

-----------------------
-- Vo'jak --
-----------------------
L= DBM:GetModLocalization(738)

L:SetTimerLocalization({
	TimerWave	= "적 : %s"
})

L:SetOptionLocalization({
	TimerWave	= "적 등장 바 보기"
})

L:SetMiscLocalization({
	WaveStart	= "하! 무적의 사마귀 군단에 정면으로 맞서시겠다? 죽여주마!"
})

-----------------------
-- Pavalak --
-----------------------
L= DBM:GetModLocalization(692)

-----------------------
-- Neronok --
-----------------------
L= DBM:GetModLocalization(727)

-----------------------
-- <<<Scholomance>>> --
-----------------------
-----------------------
-- Instructor Chillheart --
-----------------------
L= DBM:GetModLocalization(659)

-----------------------
-- Jandice Barov --
-----------------------
L= DBM:GetModLocalization(663)

-----------------------
-- Rattlegore --
-----------------------
L= DBM:GetModLocalization(665)

L:SetWarningLocalization({
	SpecWarnGetBoned	= "뼈 무더기 클릭!"
})

L:SetOptionLocalization({
	SpecWarnGetBoned	= "$spell:113996 효과가 없을 경우 특수 경고 보기",
	InfoFrame			= "$spell:113996 없는 대상을 정보 창으로 보기"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "뼈 갑옷 없음"
})

-----------------------
-- Lillian Voss --
-----------------------
L= DBM:GetModLocalization(666)

L:SetMiscLocalization({
	Kill	= "죽어, 강령술사!"
})

-----------------------
-- Darkmaster Gandling --
-----------------------
L= DBM:GetModLocalization(684)

-----------------------
-- <<<Scarlet Halls>>> --
-----------------------
-----------------------
-- Braun --
-----------------------
L= DBM:GetModLocalization(660)

-----------------------
-- Harlan --
-----------------------
L= DBM:GetModLocalization(654)

L:SetMiscLocalization({
	Call		= "무기전문가 할란"
})

-----------------------
-- Flameweaver Koegler --
-----------------------
L= DBM:GetModLocalization(656)

-----------------------
-- <<<Scarlet Cathedral>>> --
-----------------------
-----------------------
-- Thalnos Soulrender --
-----------------------
L= DBM:GetModLocalization(688)

-----------------------
-- Korlof --
-----------------------
L= DBM:GetModLocalization(671)

L:SetOptionLocalization({
	KickArrow	= "$spell:114487 대상이 가까이 있을 경우 DBM 화살표 보기"
})

-----------------------
-- Durand/High Inquisitor Whitemane --
-----------------------
L= DBM:GetModLocalization(674)
