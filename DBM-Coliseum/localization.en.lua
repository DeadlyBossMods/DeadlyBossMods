local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Northrend Beasts"
}

L:SetMiscLocalization{
	Charge	= "^%%s glares at (%S+) and lets out",
}

L:SetOptionLocalization{
	WarningImpale			= "Show warning for Impale",
	WarningFireBomb			= "Show warning for Fire Bomb",
	WarningBreath			= "Show warning for Arctic Breath",
	WarningSpray			= "Show warning for Paralytic Spray",
	WarningRage				= "Show warning for Frothing Rages",
	SpecialWarningImpale3	= "Show special warning for Impale (>=3 Stacks)",
	SpecialWarningFireBomb	= "Show special warning for Fire Bomb on You",
	SpecialWarningSilence	= "Show special warning for Spell Block",
	SpecialWarningSpray		= "Show special warning if you have Paralytic Spray",
	SpecialWarningCharge	= "Show special warning when Icehowl is about to charge you"
}

L:SetWarningLocalization{
	WarningImpale			= "%s on >%s<",
	WarningFireBomb			= "Fire Bomb",
	WarningSpray			= "%s on >%s<",
	WarningBreath			= "Arctic Breath",
	WarningRage				= "Frothing Rages",
	SpecialWarningImpale3	= "Impale on You",
	SpecialWarningFireBomb	= "Fire Bomb on You",
	SpecialWarningSilence	= "Spell Block in 0.5 Seconds!",
	SpecialWarningSpray		= "Paralytic Spray on You",
	SpecialWarningCharge	= "Charge on You! Run!"
}
