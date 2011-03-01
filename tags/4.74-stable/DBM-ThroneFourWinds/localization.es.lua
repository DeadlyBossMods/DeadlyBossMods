if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "Cónclave del Viento"
})

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
	gatherstrength			= "%s empieza a extraer fuerza",
	Anshal			= "Anshal",
	Nezir			= "Nezir",
	Rohash			= "Rohash"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "Al'Akir"
})

L:SetWarningLocalization({
	WarnFeedback	= "%s en >%s< (%d)",		-- Feedback on >args.destName< (args.amount)
	WarnAdd			= "Aparece Tormentilla"

})

L:SetTimerLocalization({
	TimerFeedback 	= "Rebote (%d)",
	TimerAddCD		= "Siguiente add"
})

L:SetOptionLocalization({
	WarnFeedback	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(87904, GetSpellInfo(87904) or "unknown"),
	LightningRodIcon= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(89668),
	TimerFeedback	= "Mostrar tiempo para la duración de $spell:87904",
	WarnAdd			= "Mostrar un aviso cuando salga una Tormentilla",
	TimerAddCD		= "Mostrar tiempo para nuevo add"
})

L:SetMiscLocalization({
	summonSquall=	"¡Tormentas! ¡Os convoco a mi lado!",
	phase3		=	"¡Basta! ¡No permitiré que se me contenga más tiempo!"--translate
})