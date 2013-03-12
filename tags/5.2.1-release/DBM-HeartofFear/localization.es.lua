if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- Imperial Vizier Zor'lok --
------------
L= DBM:GetModLocalization(745)

L:SetWarningLocalization({
	specwarnPlatform	= "Cambio de plataforma"
})

L:SetOptionLocalization({
	specwarnPlatform	= "Mostrar aviso especial cuando el boss cambia de plataforma",
	ArrowOnAttenuation	= "Mostrar flecha durante $spell:127834 indicando donde hay que moverse",
	MindControlIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122740)
})

L:SetMiscLocalization({
	Platform	= "¡El visir imperial Zor'lok vuela hacia una de las plataformas!",--translate?
	Defeat		= "No sucumbiremos ante la desesperación del vacío oscuro. Si Ella desea que perezcamos, así lo haremos."
})


------------
-- Blade Lord Ta'yak --
------------
L= DBM:GetModLocalization(744)

L:SetOptionLocalization({
	UnseenStrikeArrow	= "Mostrar flecha cuando a alguien le afecta $spell:122949 ",
	RangeFrame			= "Mostrar distancia (8) para $spell:123175"
})


-------------------------------
-- Garalon --
-------------------------------
L= DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "¡Sal del anillo morado!"
})

L:SetOptionLocalization({
	specwarnUnder	= "Mostrar aviso especial cuando estás debajo del boss",
	PheromonesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(122835)
})

L:SetMiscLocalization({
	UnderHim	= "Debajo de él"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L= DBM:GetModLocalization(741)

L:SetOptionLocalization({
	AmberPrisonIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(121885)
})

L:SetMiscLocalization({
	Reinforcements		= "Wind Lord Mel'jarak calls for reinforcements!"--translate
})

------------
-- Amber-Shaper Un'sok --
------------
L= DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLifeTutor		= "1: Interrumpe/debuffa objetivo, 2: Interrúmpete a tí mismo, 3: Regenera vida/voluntad, 4: Salir del vehículo",
	warnAmberExplosion			= ">%s< está casteando %s",
	warnInterruptsAvailable		= "Interrupciones disponibles para %s: >%s<",
	specwarnWillPower			= "¡Se te agota la voluntad!",
	specwarnAmberExplosionYou	= "Interrumpte TU %s!",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s: Interrumpe %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s: Interrumpe %s!"--Amber Montrosity
})

L:SetTimerLocalization({
	timerAmberExplosionAMCD		= "%s CD: %s"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "Mostrar resumen de las habilidades del Ensamblaje mutado",
	warnAmberExplosion			= "Mostrar aviso (con fuente) cuando $spell:122398 es casteado",
	warnInterruptsAvailable		= "Anunciar quien tiene Golper de ámbar disponible para interrumpir $spell:122402",
	specwarnWillPower			= "Mostrar aviso especial cuando tu voluntad es baja",
	specwarnAmberExplosionYou	= "Mostrar aviso especial para interrumpir tu propio $spell:122398",
	specwarnAmberExplosionAM	= "Mostrar aviso especial para interrumpir $spell:122402 de la Monstruosidad de ámbar",
	specwarnAmberExplosionOther	= "Mostrar aviso especial para interrumpir $spell:122398 de Ensamblaje mutado",
	timerAmberExplosionAMCD		= "Mostrar tiempo para el siguiente $spell:122402 de la Monstruosidad de ámbar",
	InfoFrame					= "Mostrar información con la Voluntad de los jugadores",
	FixNameplates				= "Desactivar placas de nombres que interfieren al pullear\n(restaura la configuración cuando dejas el combate)"
})

L:SetMiscLocalization({
	WillPower					= "Voluntad"
})


------------
-- Grand Empress Shek'zeer --
------------
L= DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap		= "Progreso de Trampa de ámbar: (%d/5)",
})

L:SetOptionLocalization({
	warnAmberTrap		= "Mostrar aviso (con progreso) cuando se está creando $spell:125826",
	InfoFrame		= "Mostrar información de jugadores a los que les afecta $spell:125390",
	RangeFrame		= "Mostrar distancia (5) para $spell:123735",
	StickyResinIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(124097)
})

L:SetMiscLocalization({
	PlayerDebuffs	= "Fijado",
	YellPhase3			= "No more excuses, Empress! Eliminate these cretins or I will kill you myself!"--translate
})
