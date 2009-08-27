if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "노스랜드의 야수"
}

L:SetMiscLocalization{
	--Charge	= "^%%s (%S+)|1을;를; 노려보며 큰 소리로 울부짖습니다.",
	Charge		= "^%%s (%S+) 노려보며 큰 소리로 울부짖습니다.",
	CombatStart	= "폭풍우 봉우리의 가장 깊고 어두운 동굴에서 온, 꿰뚫는 자 고르목일세! 영웅들이여, 전투에 임하게!";	
}

L:SetOptionLocalization{
	WarningImpale				= "꿰뚫기 경보 보기",
	WarningFireBomb				= "화염 폭탄 경보 보기",
	WarningBreath				= "북극의 숨결 경보 보기",
	WarningRage					= "분노 경보 보기",
	WarningCharge				= "사나운 돌진 대상 경보 보기",
	WarningToxin				= "마비 독 대상 경보 보기",
	WarningBile					= "타오르는 담즙 대상 경보 보기",	
	SpecialWarningImpale3		= "꿰뚫기 특수 경보 보기(>=3 중첩)",
	SpecialWarningFireBomb		= "자신의 화염 폭탄 특수 경보 보기",
	SpecialWarningSlimePool		= "독 구름 특수 경보 보기",
	SpecialWarningSilence		= "주문 차단 특수 경보 보기",
	SpecialWarningSpray			= "당신이 마비의 이빨에 걸릴 경우 특수 경보 보기",
	SpecialWarningToxin			= "당신이 마비독에 걸릴 경우 특수 경보 보기",
	SpecialWarningBile			= "당신이 타오르는 담즙에 걸릴 경우 특수 경보 보기",
	SpecialWarningCharge		= "얼음울음이 당신에게 사나운 돌진을 할 경우 특수 경보 보기",
	SpecialWarningChargeNear	= "얼음울음이 당신 주변에 사나운 돌진을 할 경우 특수 경보 보기",
	SetIconOnChargeTarget		= "사나운 돌진 대상 아이콘 설정 (해골)",
	SetIconOnToxinTarget		= "마비 독 대상 아이콘 설정 (해골)",
	SetIconOnBileTarget			= "타오르는 담즙 대상 아이콘 설정",	
}

L:SetWarningLocalization{
	WarningImpale				= " %s : >%s<",
	WarningFireBomb				= "화염 폭탄",
	WarningBreath				= "북극의 숨결",
	WarningRage					= "분노",
	WarningCharge				= "사나운 돌진 : >%s<",	
	WarningToxin				= "마비 독 : >%s<",
	WarningBile					= "타오르는 담즙 : >%s<",	
	SpecialWarningImpale3		= "당신에게 꿰뚫기(3중첩 이상)",
	SpecialWarningFireBomb		= "당신에게 화염 폭탄!",
	SpecialWarningSlimePool		= "독 구름, 벗어나세요!",
	SpecialWarningBile			= "당신에게 타오르는 담즙!",
	SpecialWarningSilence		= "1.5 초이내 주문 차단!!!",
	SpecialWarningSpray			= "당신에게 마비의 이빨!",
	SpecialWarningToxin			= "당신에게 마비독! 이동하세요!",
	SpecialWarningCharge		= "당신에게 사나운 돌진! 뛰세요!",
	SpecialWarningChargeNear	= "당신 주변에 사나운 돌진! 뛰세요!"	
}


-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "군주 자락서스"
}

L:SetWarningLocalization{
	WarnFlame			= "군단 불꽃 : >%s<!",
	WarnTouch			= "자락서스의 손길 : >%s<",
	WarnNetherPower			= "자락서스가 황천의 힘을 얻었습니다! 해제하세요!",
	WarnPortalSoon			= "곧 황천의 차원문!",
	WarnVolcanoSoon			= "곧 지옥불 정령 분출!",
	SpecWarnFlesh			= "당신에게 살점 소각!",
	SpecWarnTouch			= "당신에게 자락서스의 손길!",
	SpecWarnKiss			= "여군주의 키스",
	SpecWarnTouchNear		= "당신 주변에 자락서스의 손길 : >%s<",
	SpecWarnFlame			= "군단 불꽃! 뛰세요!",
	SpecWarnNetherPower		= "지금 해제!",
	SpecWarnFelInferno		= "군단 불꽃! 움직이세요!"	
}

L:SetMiscLocalization{
	WhisperFlame		= "당신에게 군단의 불꽃!",
}

L:SetOptionLocalization{
	WarnFlame				= "군단 불꽃 경고 알리기",
	WarnTouch				= "자락서스의 손길 경고 알리기",
	WarnNetherPower			= "자락서스가 황천의 힘을 얻었을 경우 경고 하기 (해제를 위한 경고)",
	WarnPortalSoon			= "황천의 차원문 생성 사전 경고 알리기",
	WarnVolcanoSoon			= "지옥불 정령 분출 사전 경고 알리기",
	SpecWarnFlame			= "군단 불꽃에 걸렸을 경우 특수 경보 알리기",
	SpecWarnFlesh			= "살점 소각에 걸렸을 경우 특수 경보 알리기",
	SpecWarnTouch			= "당신이 자락서스의 손길에 걸렸을 경우 특수 경고 알리기",
	SpecWarnTouchNear		= "당신 주변의 플레이어가 자락서스의 손길에 걸렸을 경우 특수 경고 알리기",
	SpecWarnKiss			= "당신이 여군주의 키스에 걸렸을 경우 특수 경고 알리기",
	SpecWarnNetherPower		= "황천의 힘 특수 경고 알리기 (자락서스 해제클래스-법사/사제/주술사)",
	SpecWarnFelInferno		= "당신 주변에 군단 불꽃이 있을 경우 특수 경고 알리기(바닥)",
	TouchJaraxxusIcon		= "자락서스의 손길 대상 공격대 아이콘 설정 (엑스)",
	IncinerateFleshIcon		= "살점 소각의 공격대 대상 아이콘 설정 (해골)",
	LegionFlameIcon			= "군단의 불꽃의 공격대 대상 아이콘 설정 (네모)",
	LegionFlameWhisper		= "군단의 불꽃 대상에게 귓속말 보내기",
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "진영 대표 용사"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetMiscLocalization{
	Gorgrim		= "DK - Gorgrim Shadowcleave",	-- 34458
	Birana 		= "D - Birana Stormhoof",	-- 34451
	Erin		= "D - Erin Misthoof",		-- 34459
	Rujkah		= "H - Ruj'kah",		-- 34448
	Ginselle	= "M - Ginselle Blightslinger",	-- 34449
	Liandra		= "P - Liandra Suncaller",	-- 45
	Malithas	= "P - Malithas Brightblade",	-- 56
	Caiphus		= "PR - Caiphus the Stern",	-- 47
	Vivienne	= "PR - Vivienne Blackwhisper",	-- 41
	Mazdinah	= "R - Maz'dinah",		-- 54
	Thrakgar	= "S - Thrakgar",		--  44
	Broln		= "S - Broln Stouthorn",	-- 55
	Harkzog		= "WL - Harkzog",		-- 50
	Narrhok		= "W - Narrhok Steelbreaker"	-- 53
} 

L:SetOptionLocalization{
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "발키르 쌍둥이"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "다음 속성의 소용돌이"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "곧 속성의 소용돌이!",
	SpecWarnSpecial				= "속성(빛/어둠) 변경!",
	SpecWarnEmpoweredDarkness	= "강화된 어둠",
	SpecWarnEmpoweredLight		= "강화된 빛"
}

L:SetMiscLocalization{
	YellPull 	= "In the name of our dark master. For the Lich King. You. Will. Die.",
	Fjola 		= "피올라 라이트베인",
	Eydis		= "에디스 다크베인"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "다음 속성의 소용돌이의 타이머 보기",
	WarnSpecialSpellSoon		= "다음 속성의 소용돌이 사전 경고 보기",
	SpecWarnSpecial				= "속성(색) 변경을 해야할 때 특수 경고 보기",
	SpecWarnEmpoweredDarkness	= "강화된 어둠 특수 경고 보기",
	SpecWarnEmpoweredLight		= "강화된 빛 특수 경고 보기",
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name = "아눕아락"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnBurrow	= "Burrow!",
	WarnPursue	= "Pursuing >%s<",
	SpecWarnPursue	= "Pursuing YOU!"
}

L:SetMiscLocalization{
	YellPull	= "This place will serve as your tomb!"
}

L:SetOptionLocalization{
	WarnBurrow	= "Warning for Submerge",
	WarnPursue	= "Warning who is being followed",
	SpecWarnPursue	= "Special warning if YOU are followed"
}