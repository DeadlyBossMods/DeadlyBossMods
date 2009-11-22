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
	SpecWarnBreath		= "Respiration profonde",
	SpecWarnBlastNova	= "Nova explosive. BOUGEZ !",
	WarnWhelpsSoon		= "Les Jeunes dragonnets onyxien arrivent bientôt",
	WarnPhase3Soon		= "Phase 3 bientôt"
}

L:SetTimerLocalization{
	TimerWhelps = "Arrivée des Jeunes dragonnets onyxien"
}

L:SetOptionLocalization{
	SpecWarnBreath			= "Montre une alerte spéciale pour la Respiration profonde",
	SpecWarnBlastNova		= "Montre une alerte spéciale pour la Nova explosive",
	TimerWhelps				= "Montre le timer pour l'arrivée des Jeunes dragonnets onyxien",
	WarnWhelpsSoon			= "Montre une pré-alerte avant l'arrivée des Jeunes dragonnets onyxien",
	SoundBreath				= "Joue un son pour la Respiration profonde",
	PlaySoundOnBlastNova	= "Joue un sons pour la Nova explosive",
	SoundWTF				= "Joue des sons amusants du légendaire raid classic d'Onyxia",
	WarnPhase3Soon			= "Montre une alerte pour la phase 3 (~41%)"
}

L:SetMiscLocalization{
	YellP2 = "Cet exercice dénué de sens m'ennuie. Je vais vous incinérer d'un seul coup !",
	YellP3 = "Il semble que vous ayez besoin d'une autre leçon, mortels !"
}

