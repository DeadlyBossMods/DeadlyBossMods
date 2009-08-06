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
	WarningFireBomb			= "Предупреждение для Зажигательной бомбы",
	WarningBreath			= "Предупреждение для Арктического дыхания",
	WarningSpray			= "Предупреждение для Парализующих брызг",
	WarningRage			= "Предупреждение для Бурлящей ярости",
	SpecialWarningImpale3		= "Спец-предупреждение для Прокалывания (>=3 стека)",
	SpecialWarningFireBomb		= "Спец-предупреждение, когда Зажигательная бомба на вас",
	SpecialWarningSilence		= "Спец-предупреждение для Блока чар",
	SpecialWarningSpray		= "Спец-предупреждение, когда вы в Парализующих брызгах",
	SpecialWarningCharge		= "Спец-предупреждение, когда Айсхаул набрасываться на вас"
}

L:SetWarningLocalization{
	WarningImpale			= "%s на >%s<",
	WarningFireBomb			= "Зажигательная бомба",
	WarningSpray			= "%s на >%s<",
	WarningBreath			= "Арктическое дыхание",
	WarningRage			= "Бурлящая ярость",
	SpecialWarningImpale3		= "Прокалывание на вас",
	SpecialWarningFireBomb		= "Зажигательная бомба на вас",
	SpecialWarningSilence		= "Блок чар через 0.5 сек!",
	SpecialWarningSpray		= "Парализующие брызги на вас",
	SpecialWarningCharge		= "Рывок к вам! БЕГИТЕ!"
}



