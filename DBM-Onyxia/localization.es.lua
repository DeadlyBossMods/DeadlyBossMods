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
	SpecWarnBreath	= "Mostrar aviso especial para Aliento Profundo ( Echa fuego )",
	TimerBreath		= "Mostrar tiempo para Alieto Profundo ( Fuego )",
	TimerWhelps		= "Mostrar tiempo para las crias",
	WarnWhelpsSoon	= "Mostrar pre-aviso para las crias",
	SoundBreath		= "Sonido si estas en el area del fuego"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	YellP2 = "Este ejercicio sin sentido me aburre. ¡Os inceneraré a todos desde arriba!",
	YellP3 = "¡Aprende a saber estar, mortal!"
}
