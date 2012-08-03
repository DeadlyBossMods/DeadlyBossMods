if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization(154)

L:SetWarningLocalization({
	warnSpecial			= "Huracan/Céfiro/Tormenta de granizo activados",
	specWarnSpecial		= "¡Habilidades especiales activas!",
	warnSpecialSoon		= "Habilidades especiales en 10 segundos!"
})

L:SetTimerLocalization({
	timerSpecial			= "Habilidades especiales CD",
	timerSpecialActive		= "Habilidades especiales activas"
})

L:SetOptionLocalization({
	warnSpecial			= "Mostrar aviso cuando Huracan/Céfiro/Tormenta de granizo sean lanzados",
	specWarnSpecial		= "Mostrar aviso especial cuando se lanzan habilidades especiales",
	timerSpecial		= "Mostrar cooldown de habilidades especiales",
	timerSpecialActive	= "Mostrar tiempo de duración de habilidades especiales",
	warnSpecialSoon		= "Mostrar pre-aviso 10 segundos antes de las habilidades especiales",
	OnlyWarnforMyTarget	= "Solo mostrar avisos/tiempos para el objetivo y foco actual\n(Oculta el resto. ¡ESTO INCLUYE AL PULLEAR!)"
})

L:SetMiscLocalization({
	gatherstrength			= "empieza a extraer fuerza"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization(155)

L:SetTimerLocalization({
	TimerFeedback 	= "Rebote (%d)"
})

L:SetOptionLocalization({
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Mostrar tiempo para la duración de $spell:87904",
	RangeFrame		= "Mostrar distancia (20) cuando te afecte $spell:89668"
})