local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	SpecWarnBreath		= "Deep Breath",
	SpecWarnBlastNova	= "Blast Nova - Run away",
	WarnWhelpsSoon		= "Onyxian Whelps soon",
	WarnPhase3Soon		= "Phase 3 soon"
}

L:SetTimerLocalization{
	TimerBreath	= "Deep Breath",
	TimerWhelps = "Onyxian Whelps"
}

L:SetOptionLocalization{
	SpecWarnBreath			= "Show special warning for Deep Breath",
	BlastNovaWarning		= "Show special warning for Blast Nova",
	TimerBreath				= "Show timer for Deep Breath",
	TimerWhelps				= "Show timer for Onyxian Whelps",
	WarnWhelpsSoon			= "Show pre-warning for Onyxian Whelps",
	SoundBreath				= "Play sound on Deep Breath",
	PlaySoundOnBlastNova	= "Play sound on Blast Nova",
	SoundWTF				= "Play some funny sounds from a legendary classic Onyxia raid",
	WarnPhase3Soon			= "Show pre-warning for Phase 3 (at ~41%)"
}

L:SetMiscLocalization{
	Breath = "%s takes in a deep breath...",
	YellP2 = "This meaningless exertion bores me. I'll incinerate you all from above!",
	YellP3 = "It seems you'll need another lesson, mortals!"
}


