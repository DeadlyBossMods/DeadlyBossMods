
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
	SpecWarnBreath		= "Tiefer Atem",
	SpecWarnBlastNova	= "Drucknova! Lauf weg!",
	WarnWhelpsSoon		= "Welpen kommen bald",
	WarnPhase3Soon		= "Phase 3 beginnt gleich" 
}

L:SetTimerLocalization{
	TimerBreath	= "Tiefer Atem",
	TimerWhelps	= "Welpenspawn"
}

L:SetOptionLocalization{
	SpecWarnBreath			= "Zeige Spezialwarnung für tiefen Atem",
	SpecWarnBlastNova		= "Zeige Spezialwarnung für Drucknova",
	TimerBreath				= "Zeige Timer für tiefen Atem",
	TimerWhelps				= "Zeige Timer für Welpenspawn",
	WarnWhelpsSoon			= "Zeige Vorwarnung für Welpenspawn",
	SoundBreath				= "Spiele Sound bei tiefem Atem",
	PlaySoundOnBlastNova	= "Spiele Sound bei Drucknova",
	SoundWTF				= "Spiele witzige Sounds eines legendären Classic-Raids",
	WarnPhase3Soon			= "Zeige Vorwarnung für Phase 3 (bei ~41%)"
}

L:SetMiscLocalization{
   Breath = "%s atmet tief ein...",
   YellP2 = "Diese sinnlose Anstrengung langweilt mich. Ich werde Euch alle von oben verbrennen!",
   YellP3 = "Mir scheint, dass Ihr noch eine Lektion braucht, sterbliche Wesen!"
}


