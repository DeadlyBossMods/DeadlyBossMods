if GetLocale() ~= "frFR" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Les Bêtes du Norfendre"
}

L:SetMiscLocalization{
	Charge	= "^%%s glares at (%S+) and lets out",
}

L:SetOptionLocalization{
	WarningImpale				= "Montre une alerte spéciale pour Empaler",
	WarningFireBomb				= "Montre une alerte spéciale pour les Bombe incendiaire",
	WarningBreath				= "Montre une alerte spéciale pour les Souffle arctique",
--	WarningSpray				= "Montre une alerte spéciale pour les Jet paralysant",
	WarningRage					= "Montre une alerte spéciale pour la Rage écumeuse",
	WarningCharge				= "Montre une alerte spéciale pour la cible de la charge",
	SpecialWarningImpale3		= "Montre une alerte spéciale pour l'empaler (>=3 Stacks)",
	SpecialWarningFireBomb		= "Montre une alerte spéciale quand la Bombe incendiaire est sur vous",
	SpecialWarningSlimePool		= "Montre une alerte spéciale pour les Flaque de bave",
	SpecialWarningSilence		= "Montre une alerte spéciale pour le Piétinement ahurissant",
	SpecialWarningSpray			= "Montre une alerte spéciale si vous êtes victime d'un Jet paralysant",
	SpecialWarningToxin			= "Montre une alerte spéciale si vous êtes victime de la Toxine paralysante",
	SpecialWarningCharge		= "Montre une alerte spéciale quand Icehowl est sur le point de vous charger",
	SpecialWarningChargeNear	= "Montre une alerte spéciale quand Icehowl charge a coter de vous",
	SetIconOnChargeTarget		= "Met une icone sur la cible de la charge ( Tête de mort )"
}

L:SetWarningLocalization{
	WarningImpale				= "%s sur >%s<",
	WarningFireBomb				= "Bombe incendiaire",
--	WarningSpray				= "%s sur >%s<",
	WarningBreath				= "Souffle arctique",
	WarningRage					= "Rage écumeuse",
	WarningCharge				= "Charge sur >%s<",
	SpecialWarningImpale3		= "Empaler >%d< sur VOUS",
	SpecialWarningFireBomb		= "Bombe incendiaire sur VOUS",
	SpecialWarningSlimePool		= "Flaque de bave, BOUGEZ!",
	SpecialWarningSilence		= "Piétinement ahurissant dans 0.5 Seconde!",
	SpecialWarningSpray			= "Jet paralysant",
	SpecialWarningToxin			= "Toxine paralysante sur vous, BOUGEZ!",
	SpecialWarningCharge		= "Charge sur vous! COUREZ!",
	SpecialWarningChargeNear	= "Charge a coter de vous! COUREZ!"
}



