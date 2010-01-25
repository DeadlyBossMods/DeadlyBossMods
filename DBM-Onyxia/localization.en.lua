local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	WarnWhelpsSoon		= "Onyxian Whelps soon",
	WarnPhase2Soon		= "Phase 2 soon",
	WarnPhase3Soon		= "Phase 3 soon"
}

L:SetTimerLocalization{
	TimerWhelps	= "Onyxian Whelps"
}

L:SetOptionLocalization{
	TimerWhelps				= "Show timer for Onyxian Whelps",
	WarnWhelpsSoon			= "Show pre-warning for Onyxian Whelps",
	SoundWTF				= "Play some funny sounds from a legendary classic Onyxia raid",
	WarnPhase2Soon			= "Show pre-warning for Phase 2 (at ~67%)",
	WarnPhase3Soon			= "Show pre-warning for Phase 3 (at ~41%)"
}

L:SetMiscLocalization{
	YellP2 = "This meaningless exertion bores me. I'll incinerate you all from above!",
	YellP3 = "It seems you'll need another lesson, mortals!"
}

