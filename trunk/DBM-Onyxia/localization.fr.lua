if GetLocale() ~= "frFR" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	SpecWarnBreath	= "Respiration profonde",
	WarnWhelpsSoon	= "Les Jeune dragonnet onyxien arrivent bientôt",
}

L:SetTimerLocalization{
	TimerBreath	= "Respiration profonde",
	TimerWhelps = "Arriver des Jeune dragonnet onyxien"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "Montre une alerte spéciale pour la Respiration profonde",
	TimerBreath		= "Montre le timer pour la Respiration profonde",
	TimerWhelps		= "Montre le timer pour l'arriver des Jeune dragonnet onyxien",
	WarnWhelpsSoon	= "Montre une pré-alerte avant l'arriver des Jeune dragonnet onyxien",
	SoundBreath		= "Joue un sons pour la Respiration profonde"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	Breath = "%s prend une grande inspiration...",
	YellP2 = "Cet exercice dénué de sens m'ennuie. Je vais vous incinérer d'un seul coup !",
	YellP3 = "Il semble que vous ayez besoin d'une autre leçon, mortels !"
}

