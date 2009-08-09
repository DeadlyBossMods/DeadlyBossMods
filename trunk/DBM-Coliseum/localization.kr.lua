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
	Charge	= "^%%s (%S+)|1을;를; 노려보며 큰 소리로 울부짖습니다.",
}

L:SetOptionLocalization{
	WarningImpale			= "꿰뚫기 경보 보기",
	WarningFireBomb			= "화염 폭탄 경보 보기",
	WarningBreath			= "북극의 숨결 경보 보기",
	WarningSpray			= "산성 숨결 경보 보기",
	WarningRage				= "분노 경보 보기",
	SpecialWarningImpale3	= "꿰뚫기 특수 경보 보기(>=3 중첩)",
	SpecialWarningFireBomb	= "자신의 화염 폭탄 특수 경보 보기",
	SpecialWarningSlimePool	= "독 구름 특수 경보 보기",
	SpecialWarningSilence	= "주문 차단 특수 경보 보기",
	SpecialWarningSpray		= "당신이 마비의 이빨에 걸릴 경우 특수 경보 보기",
	SpecialWarningToxin		= "당신이 마비독에 걸릴 경우 특수 경보 보기",
	SpecialWarningCharge	= "얼음울음이 당신에게 돌진하게 될 경우 특수 경보 보기"
}

L:SetWarningLocalization{
	WarningImpale			= " %s : >%s<",
	WarningFireBomb			= "화염 폭탄",
	WarningSpray			= " %s : >%s<",
	WarningBreath			= "북극의 숨결",
	WarningRage				= "분노",
	SpecialWarningImpale3	= "당신에게 꿰뚫기(3중첩 이상)",
	SpecialWarningFireBomb	= "당신에게 화염 폭탄!",
	SpecialWarningSlimePool	= "독 구름, 벗어나세요!",
	SpecialWarningSilence	= "주문 차단 0.5 초 전!!!",
	SpecialWarningSpray		= "당신에게 마비의 이빨!",
	SpecialWarningToxin		= "당신에게 마비독! 이동하세요!",
	SpecialWarningCharge	= "당신에게 돌진! 뛰세요!"
}


-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "군주 자락서스"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	PortalSoonWarning	= "곧 황천의 차원문!",
	VolcanoSoonWarning	= "곧 군단의 불꽃!",
	WarnFlame			= "군단의 불길 : >%s<!"
}

L:SetMiscLocalization{
	SpecWarnFlame		= "당신에게 군단의 불꽃!",
	SpecWarnFlesh		= "당신에게 불태우기!"
}

L:SetOptionLocalization{
	PortalSoonWarning	= "황천의 차원문 사전 경고 알리기",
	VolcanoSoonWarning	= "군단의 불꽃 사전 경고 알리기",
	WarnFlame			= "군단의 불꽃 경고하기",
	SpecWarnFlame		= "군단의 불길에 걸렸을 경우 특수 경보 알리기",
	SpecWarnFlesh		= "불태우기에 걸렸을 경우 특수 경보 알리기"
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
	TimerSpecialSpell	= "Next Special Ability"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "Special Ability Soon!",
	SpecWarnSpecial		= "Change color!"
}

L:SetMiscLocalization{
	YellPull 	= "In the name of our dark master. For the Lich King. You. Will. Die.",
	Fjola 		= "Fjola Lightbane",
	Eydis		= "Eydis Darkbane"
}

L:SetOptionLocalization{
	TimerSpecialSpell	= "Show a timer for the next special ability",
	WarnSpecialSpellSoon	= "Prewarning for the next Special Ability",
	SpecWarnSpecial		= "Show a special warning when you have to change color"
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