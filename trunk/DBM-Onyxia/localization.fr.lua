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
	WarnWhelpsSoon	= "Les Jeunes dragonnets onyxien arrivent bientôt",
}

L:SetTimerLocalization{
	TimerBreath	= "Respiration profonde",
	TimerWhelps = "Arrivée des Jeunes dragonnets onyxien"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "Montre une alerte spéciale pour la Respiration profonde",
	TimerBreath		= "Montre le timer pour la Respiration profonde",
	TimerWhelps		= "Montre le timer pour l'arrivée des Jeunes dragonnets onyxien",
	WarnWhelpsSoon	= "Montre une pré-alerte avant l'arrivée des Jeunes dragonnets onyxien",
	SoundBreath		= "Joue un son pour la Respiration profonde",
	SoundWTF		= "Joue des sons amusant du légendaire raid classic d'Onyxia"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	Breath = "%s prend une grande inspiration...",
	YellP2 = "Cet exercice dénué de sens m'ennuie. Je vais vous incinérer d'un seul coup !",
	YellP3 = "Il semble que vous ayez besoin d'une autre leçon, mortels !"
}

