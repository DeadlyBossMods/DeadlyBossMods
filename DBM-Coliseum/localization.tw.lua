if GetLocale() ~= "zhTW" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "北裂境野獸"
}

L:SetMiscLocalization{
	Charge	= "^%%s怒視著(%S+)，並發出震耳的咆哮!",
}

L:SetOptionLocalization{
	WarningImpale			= "為刺穿顯示警告",
	WarningFireBomb			= "為燃燒彈顯示警告",
	WarningBreath			= "為寒地之息顯示警告",
	WarningSpray			= "為痲痺噴霧顯示警告",
	WarningRage			= "為泡沫之怒顯示警告",
	SpecialWarningImpale3		= "為刺穿(大於3層)顯示特別警告",
	SpecialWarningFireBomb		= "當你中了燃燒彈時顯示特別警告",
	SpecialWarningSlimePool		= "為泥漿池顯示特別警告",
	SpecialWarningSilence		= "為法術沉默顯示特別警告",
	SpecialWarningSpray		= "當你中了痲痺噴霧時顯示特別警告",
	SpecialWarningToxin		= "當你中了痲痺劇毒時顯示特別警告",
	SpecialWarningCharge		= "當冰嚎即將撞擊你時顯示特別警告"
}

L:SetWarningLocalization{
	WarningImpale			= "%s: >%s<",
	WarningFireBomb			= "燃燒彈",
	WarningSpray			= "%s: >%s<",
	WarningBreath			= "寒地之息",
	WarningRage			= "泡沫之怒",
	SpecialWarningImpale3		= "你中了刺穿!",
	SpecialWarningFireBomb		= "你中了燃燒彈!",
	SpecialWarningSlimePool		= "泥漿池, 跑開!",
	SpecialWarningSilence		= "0.5秒後 法術沉默!",
	SpecialWarningSpray		= "你中了痲痺噴霧!",
	SpecialWarningToxin		= "痲痺劇毒! 跑開!",
	SpecialWarningCharge		= "你中了撞擊! 跑開!"
}
