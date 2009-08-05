if GetLocale() ~= "ruRU" then return end

local L


------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Нордскольские звери"
}

L:SetMiscLocalization{
	Charge	= "^%%s впивается взглядом и набрасываться на (%S +)",
}

L:SetOptionLocalization{
	WarningImpale			= "Предупреждение для Прокалывания",
	WarningBreath			= "Предупреждение для Арктического дыхания",
	WarningSpray			= "Предупреждение для Парализующих брызг",
	WarningRage			= "Предупреждение для Бурлящей ярости",
	SpecialWarningSilence		= "Спец-предупреждение для Блока чар",
	SpecialWarningSpray		= "Спец-предупреждение, когда вы в Парализующих брызгах",
	SpecialWarningCharge		= "Спец-предупреждение, когда Айсхаул набрасываться на вас"
}

L:SetWarningLocalization{
	WarningImpale			= "%s на >%s<",
	WarningSpray			= "%s на >%s<",
	WarningBreath			= "Арктическое дыхание",
	WarningRage			= "Бурлящая ярость",
	SpecialWarningSilence		= "Блок чар через 0.5 сек!",
	SpecialWarningSpray		= "Парализующие брызги на вас",
	SpecialWarningCharge		= "Рывок к вам! БЕГИТЕ!"
}



