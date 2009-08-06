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
	Charge	= "^%%s glares at (%S+) and lets out",
}

L:SetOptionLocalization{
	WarningImpale			= "Show warning for Impale",
	WarningBreath			= "Show warning for Arctic Breath",
	WarningSpray			= "Show warning for Paralytic Spray",
	WarningRage				= "Show warning for Frothing Rages",
	SpecialWarningSilence	= "Show special warning for Spell Block",
	SpecialWarningSpray		= "Show special warning if you have Paralytic Spray",
	SpecialWarningCharge	= "Show special warning when Icehowl is about to charge you"
}

L:SetWarningLocalization{
	WarningImpale			= "%s on >%s<",
	WarningSpray			= "%s on >%s<",
	WarningBreath			= "Arctic Breath",
	WarningRage				= "Frothing Rages",
	SpecialWarningSilence	= "Spell Block in 0.5 Seconds!",
	SpecialWarningSpray		= "Paralytic Spray on You",
	SpecialWarningCharge	= "Charge on You! Run!"
}
