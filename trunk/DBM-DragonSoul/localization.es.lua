if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	SpecwarnVortexAfter	= "¡Escóndete detrás de los pilares!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecwarnVortexAfter	= "Mostrar un aviso especial cuando $spell:110047 termina"
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame	= "Mostrar distancia (10) para $spell:104601\n(sólo heroico)"
})

L:SetMiscLocalization({
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozes		= "Vienen mocos: %s",
	specWarnOozes	= "Vienen mocos!",
	specWarnManaVoid= "Vacío de maná. Cambio!"
})

L:SetTimerLocalization({
	timerOozesCD	= "Siguientes mocos"
})

L:SetOptionLocalization({
	warnOozes			= "Mostrar aviso cuando salgan mocos",
	specWarnOozes		= "Mostrar aviso especial cuando salgan mocos",
	specWarnManaVoid	= "Mostrar aviso especial cuando salga $spell:105530",
	timerOozesCD		= "Mostrar tiempo para siguientes mocos"
})

L:SetMiscLocalization({
	Black			= "|cFF424242negra|r",
	Purple			= "|cFF9932CDmorada|r",
	Red				= "|cFFFF0404roja|r",
	Green			= "|cFF088A08verde|r",
	Blue			= "|cFF0080FFazul|r",
	Yellow			= "|cFFFFA901amarilla|r"
})


-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	warnFrostTombCast		= "%s en 8 seg"
})

L:SetTimerLocalization({
	TimerSpecial			= "Primer especial"
})

L:SetOptionLocalization({
	TimerSpecial			= "Mostrar tiempo para casteo de la primera habilidad especial",
	RangeFrame				= "Mostrar distancia (3) para $spell:105269",
	AnnounceFrostTombIcons	= "Anunciar iconos de los objetivos de $spell:104451 a la banda\n(requiere líder)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451)
})


L:SetMiscLocalization({
	TombIconSet				= "Icono de tumba de hielo {rt%d} en %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Empieza el combate"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate"
})

L:SetMiscLocalization({
	Pull				= "I sense a great disturbance in the balance approaching. The chaos of it burns my mind!"--translate
})


-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Empieza el combate",
	TimerSapper			= "Siguiente Zapador Crepuscular"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate",
	TimerSapper			= "Mostrar tiempo para la aparición del siguiente Zapador Crepuscular"
})

L:SetMiscLocalization({
	SapperEmote			= "A drake swoops down to drop a Twilight Sapper onto the deck!",--translate
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})
