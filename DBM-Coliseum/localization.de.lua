
if GetLocale() ~= "deDE" then return end
local L


------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Northrend Beasts"
}

L:SetMiscLocalization{
	Charge			= "^%%s glares at (%S+) and lets out",
	CombatStart		= "Hailing from the deepest, darkest caverns of the Storm Peaks, Gormok the Impaler! Battle on, heroes!";
}

L:SetOptionLocalization{
	WarningImpale				= "Zeige Warnung für Pfählen",
	WarningFireBomb				= "Zeige Warnung für Feuerbombe",
	WarningBreath				= "Zeige Warnung für Arktischer Atem",
	WarningRage					= "Zeige Warnung für Schäumende Wut",
	WarningCharge				= "Zeige Warnung für Charge Ziel",
	WarningToxin				= "Zeige Warnung für Paralysierendes Toxin Ziel",
--	WarningSpray				= "Zeige Warnung für Paralytic Spray",
--	SpecialWarningSpray			= "Zeige Spezialwarnung bei Paralytic Spray",
	SpecialWarningImpale3		= "Zeige Spezialwarnung für Impale (>=3 Stacks)",
	SpecialWarningFireBomb		= "Zeige Spezialwarnung für Feuerbombe auf Dir",
	SpecialWarningSlimePool		= "Zeige Spezialwarnung für Schleimpfütze",
	SpecialWarningSilence		= "Zeige Spezialwarnung für Spell Block (Erschütterndes Stampfen)",
	SpecialWarningToxin			= "Zeige Spezialwarnung bei Paralysierendem Toxin",
	SpecialWarningCharge		= "Zeige Spezialwarnung wenn Icehowl auf dich Trampelt",
	SpecialWarningChargeNear	= "Zeige Spezialwarnung wenn Icehowl in deine Nähe Trampelt",
	SetIconOnChargeTarget		= "Setze Symbol auf das Trampeln Ziel (Totenkopf)",
	SetIconOnToxinTarget		= "Setze Symbol auf das Toxin Ziel (Totenkopf)",
}

L:SetWarningLocalization{
	WarningImpale				= "%s on >%s<",
	WarningFireBomb				= "Feuerbombe",
	WarningBreath				= "Arktischer Atem",
	WarningRage					= "Schäumende Wut",
	WarningCharge				= "Trampeln auf >%s<",
	WarningToxin				= "Toxin auf >%s<",
--	WarningSpray				= "%s on >%s<",
--	SpecialWarningSpray			= "Paralytic Spray auf Dir!",
	SpecialWarningImpale3		= "%d. Pfählen auf Dir",
	SpecialWarningFireBomb		= "Feuerbombe! Lauf raus!",
	SpecialWarningSlimePool		= "Schleimpfütze! Lauf raus!",
	SpecialWarningSilence		= "Spell Block in 0.5 Seconds!",
	SpecialWarningToxin			= "Toxin auf Dir! Lauf!",
	SpecialWarningCharge		= "Charge auf Dich! Lauf!",
	SpecialWarningChargeNear	= "Charge bei Dir! Lauf!"
}


