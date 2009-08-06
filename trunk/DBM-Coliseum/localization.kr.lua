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

