if GetLocale() ~= "deDE" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
   name = "Onyxia"
}

L:SetWarningLocalization{
	WarnWhelpsSoon		= "Welpen kommen bald",
	WarnPhase2Soon		= "Phase 2 bald",
	WarnPhase3Soon		= "Phase 3 bald"
}

L:SetTimerLocalization{
	TimerWhelps	= "Welpenspawn"
}

L:SetOptionLocalization{
	TimerWhelps				= "Zeige Timer für Welpenspawn",
	WarnWhelpsSoon			= "Zeige Vorwarnung für Welpenspawn",
	SoundWTF				= "Spiele witzige Sounds eines legendären Classic-Raids",
	WarnPhase2Soon			= "Zeige Vorwarnung für Phase 2 (bei ~67%)",
	WarnPhase3Soon			= "Zeige Vorwarnung für Phase 3 (bei ~41%)"
}

L:SetMiscLocalization{
   YellP2 = "Diese sinnlose Anstrengung langweilt mich. Ich werde Euch alle von oben verbrennen!",
   YellP3 = "Mir scheint, dass Ihr noch eine Lektion braucht, sterbliche Wesen!"
}

