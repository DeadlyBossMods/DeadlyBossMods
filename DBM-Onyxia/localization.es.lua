if GetLocale() ~= "esES" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "Onyxia"
}

L:SetWarningLocalization{
	SpecWarnBreath	= "Aliento profundo",
	WarnWhelpsSoon	= "Pronto saldran crias",
}

L:SetTimerLocalization{
	TimerBreath	= "Aliento profundo",
	TimerWhelps = "Salen crias"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "Mostrar aviso especial para Aliento profundo",
	TimerBreath		= "Mostrar tiempo para Aliento profundo",
	TimerWhelps		= "Mostrar tiempo para las crias",
	WarnWhelpsSoon	= "Mostrar pre-aviso para las crias",
	SoundBreath		= "Sonido sie stas en el area del Aliento profundo"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	Breath = "%s takes in a deep breath...",
	YellP2 = "This meaningless exertion bores me. I'll incinerate you all from above!",
	YellP3 = "It seems you'll need another lesson, mortals!"
}
