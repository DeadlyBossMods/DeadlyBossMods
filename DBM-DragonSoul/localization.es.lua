if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom imita %s"
})

L:SetOptionLocalization({
	KohcromWarning	= "Mostrar avisos para las habilidades que Kohcrom imita.",
	KohcromCD		= "Mostrar tiempos para las siguientes habilidades imitadas de Kohcrom.",
	RangeFrame		= "Mostrar distancia (5) para logro."
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
	ShadowYell			= "Gritar cuando te afecte $spell:104600\n(Solo dificultad Heroica)",
	CustomRangeFrame	= "Range Frame options",
	Never				= "Disabled",
	Normal				= "Normal Range Frame",
	DynamicPhase2		= "Phase2 Debuff Filtering",
	DynamicAlways		= "Always Debuff Filtering"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerOozesActive	= "Mocos atacables"
})

L:SetOptionLocalization({
	timerOozesActive	= "Mostrar tiempo para que los mocos se pueden atacar",
	RangeFrame			= "Mostrar distancia (4) para $spell:104898\n(Dificultad normal o superior)"
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
	RangeFrame				= "Mostrar distancia (3) para $spell:105269, (10) para $journal:4327",
	AnnounceFrostTombIcons	= "Anunciar iconos de los objetivos de $spell:104451 a la banda\n(requiere líder)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325)
})


L:SetMiscLocalization({
	TombIconSet				= "Icono de tumba de hielo {rt%d} en %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%%d)"--spellname Count
})

L:SetTimerLocalization({
	TimerDrakes			= "%s",
	TimerCombatStart	= "Ultraxion aterriza",
	timerRaidCDs		= "CD %s de %s listo"--spellname CD Castername
})

L:SetOptionLocalization({
	TimerDrakes			= "Mostrar tiempo para Fuga Crepuscular	de los Asaltantes Crepusculares",
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate",
	ResetHoTCounter		= "Restart Hour of Twilight counter",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "Never",
	Reset3				= "Reset in sets of 3/2 (heroic/normal)",
	Reset3Always		= "Always Reset in sets of 3",
	ShowRaidCDs			= "Mostrar tiempos de CDs de Banda"
})

L:SetMiscLocalization({
	Trash				= "Me alegra volver a verte, Alexstrasza. He estado ocupado en mi ausencia.",
	Pull				= "Percibo que se avecina una gran alteración del equilibrio. ¡Su caos inunda mi mente!"
})


-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart	= "Empieza el combate",
	TimerAdd			= "Siguientes Élites"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate",
	TimerAdd			= "Mostrar tiempo para que salgan los siguientes Élites Crepusculares"
})

L:SetMiscLocalization({
	SapperEmote			= "¡Un draco desciende para dejar a un zapador Crepuscular en la cubierta!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "¡Ponte a salvo!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Mostrar un aviso especial cuando no tengas el debuff de $spell:109454",
	InfoFrame				= "Mostrar información de jugadores sin $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "Mostrar barra de vida del boss con una barra para $spell:105479"
})

L:SetMiscLocalization({
	Pull		= "¡Las placas! ¡Se está deshaciendo! ¡Destrozad las placas y tendremos una oportunidad de derribarlo!",
	NoDebuff	= "Sin %s",
	PlasmaTarget	= "Plasma ardiente: %s",
	DRoll		= "¡Está a punto de girar",
	DLevels			= "se estabiliza."
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetWarningLocalization({
	SpecWarnTentacle	= "¡Tentáculos Virulentos!",
	SpecWarnCongealing	= "Sangre coagulante ¡Cambio!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnTentacle	= "Mostrar aviso especial cuando aparecen Tentáculos Virulentos (y Alextrasza no está activa)",
	SpecWarnCongealing	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell:format(109089),
	RangeFrame			= "Mostrar distancia dinamica basada en el estado del debuff\n$spell:108649 en dificultad Heroica",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "No habéis hecho nada. Destruiré vuestro mundo."
})
