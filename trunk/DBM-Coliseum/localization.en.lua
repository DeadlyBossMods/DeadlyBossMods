local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Northrend Beasts"
}

L:SetOptionLocalization{
	WarningImpale			= "Show warning for Impale",
	WarningBreath			= "Show warning for Arctic Breath",
	WarningSpray			= "Show warning for Paralytic Spray",
	WarningRage				= "Show warning for Frothing Rages",
	SpecialWarningSilence	= "Show special warning for Spell Block",
	SpecialWarningSpray		= "Show special warning if you have Paralytic Spray"
}

L:SetWarningLocalization{
	WarningImpale			= "%s on >%s<",
	WarningSpray			= "%s on >%s<",
	WarningBreath			= "Arctic Breath",
	WarningRage				= "Frothing Rages",
	SpecialWarningSilence	= "Spell Block in 0.5 Seconds!",
	SpecialWarningSpray		= "Paralytic Spray on You"
}
