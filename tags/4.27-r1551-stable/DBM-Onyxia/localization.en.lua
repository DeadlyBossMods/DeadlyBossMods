local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	SpecWarnBreath	= "Deep Breath",
	WarnWhelpsSoon	= "Whelp spawn soon",
}

L:SetTimerLocalization{
	TimerBreath	= "Deep Breath",
	TimerWhelps = "Whelp Spawn"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "Show special warning for Deep Breath",
	TimerBreath		= "Show timer for Deep Breath",
	TimerWhelps		= "Show timer for whelp spawns",
	WarnWhelpsSoon	= "Show pre-warning for whelp spawns",
	SoundBreath		= "Play sound on Deep Breath"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	Breath = "%s takes in a deep breath...",
	YellP2 = "This meaningless exertion bores me. I'll incinerate you all from above!",
	YellP3 = "It seems you'll need another lesson, mortals!"
}
