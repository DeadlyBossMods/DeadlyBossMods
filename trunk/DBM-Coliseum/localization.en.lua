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
	SpecialWarningSlimePool	= "Show special warning for Slime Pool",
	SpecialWarningSilence	= "Show special warning for Spell Block",
	SpecialWarningSpray		= "Show special warning if you have Paralytic Spray",
	SpecialWarningToxin		= "Show special warning if you have Paralytic Toxin",
	SpecialWarningCharge	= "Show special warning when Icehowl is about to charge You"
}

L:SetWarningLocalization{
	WarningImpale			= "%s on >%s<",
	WarningFireBomb			= "Fire Bomb",
	WarningSpray			= "%s on >%s<",
	WarningBreath			= "Arctic Breath",
	WarningRage				= "Frothing Rages",
	SpecialWarningImpale3	= "Impale on You",
	SpecialWarningFireBomb	= "Fire Bomb on You",
	SpecialWarningSlimePool	= "Slime Pool, Move out!",
	SpecialWarningSilence	= "Spell Block in 0.5 Seconds!",
	SpecialWarningSpray		= "Paralytic Spray on You",
	SpecialWarningToxin		= "Toxin on You! Move!",
	SpecialWarningCharge	= "Charge on You! Run!"
}


