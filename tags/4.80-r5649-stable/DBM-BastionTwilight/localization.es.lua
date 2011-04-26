if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"Halfus Partevermis"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	ShowDrakeHealth		= "Mostrar la vida de los dragones liberados"
})

L:SetMiscLocalization({
})

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Valiona y Theralion"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	TBwarnWhileBlackout		= "Mostrar aviso de $spell:92898 cuando $spell:86788 está activo",
	TwilightBlastArrow		= "Mostrar flecha cuando $spell:92898 está cerca de ti",
	RangeFrame				= "Mostrar distancia (10 yardas)",
	BlackoutShieldFrame		= "Mostrar barra de vida del boss con una barra para $spell:92878",
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Aliento profundo",
	BlackoutTarget			= "Desmayo: %s"
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Consejo de ascendientes"
})

L:SetWarningLocalization({
	specWarnBossLow			= "%s por debajo del 30%% ¡Siguiente fase pronto!",
	SpecWarnGrounded	= "Coge el bufo de Domeñado",
	SpecWarnSearingWinds	= "Coge el bufo de Vientos espirales"
})

L:SetTimerLocalization({
	timerTransition		= "Transición de fase"
})

L:SetOptionLocalization({
	specWarnBossLow			= "Mostrar un aviso especial cuando los Bosses estén por debajo del 30% de vida",
	SpecWarnGrounded	= "Mostrar aviso especial cuando estes a punto de perder el bufo de $spell:83581\n(~10seg antes de castear)",
	SpecWarnSearingWinds	= "Mostrar aviso especial cuando estes a punto de perder el bufo de $spell:83500\n(~10seg antes de castear)",
	timerTransition		= "Mostrar tiempo para transición de fase",
	RangeFrame			= "Mostrar distancia cuando sea necesario",
	HeartIceIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82665),
	BurningBloodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82660),
	LightningRodIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(83099),
	GravityCrushIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(84948),
	FrostBeaconIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92307),
	StaticOverloadIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92067),
	GravityCoreIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92075)
})

L:SetMiscLocalization({
	Quake			= "El suelo bajo tus pies empieza a temblar ominosamente...",
	Thundershock		= "El aire circundante chisporrotea de energía...",
	Switch			= "¡Basta de tonterías!",
	Phase3			= "Una exhibición impresionante...",
	Ignacious		= "Ignacious",
	Feludius		= "Feludius",
	Arion			= "Arion",
	Terrastra		= "Terrastra",
	Monstrosity		= "Monstruosidad de Elementium",
	Kill			= "Imposible..."
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"Cho'gall"
})

L:SetWarningLocalization({

})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	CorruptingCrashArrow	= "Mostrar una flecha cuando $spell:93178 está cerca de ti",
	InfoFrame				= "Mostrar información para $spell:81701",
	RangeFrame				= "Mostrar distancia (5 yardas) para $spell:82235",
	SetIconOnWorship		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= "Poner iconos en las Creaciones oscurecidas"
})

L:SetMiscLocalization({
	Bloodlevel		= "Corrupción"
})

----------------
--  Sinestra  --
----------------
L = DBM:GetModLocalization("Sinestra")

L:SetGeneralLocalization({
	name =	"Sinestra"
})

L:SetWarningLocalization({
	WarnDragon			= "Sale Cría Crepuscular",
	WarnOrbsSoon		= "¡Cercenadora Crepuscular en %d seg!",
	WarnEggWeaken		= "Huevo sin Caparazón Crepuscular",
	SpecWarnOrbs		= "¡Cercenadora Crepuscular pronto!",
	warnWrackJump		= "%s ha saltado a >%s<",
	WarnWrackCount5s	= "%d segundos des del último Arruinar",
	SpecWarnDispel		= "¡Han pasado %d seg des del último Arruinar ¡Dispelea ahora!",
	SpecWarnEggWeaken	= "¡Caparazón Crepuscular Eliminado! ¡Pega el Huevo!",
	SpecWarnEggShield	= "¡Caparazón Crepuscular se ha regenerado!"

})

L:SetTimerLocalization({
	TimerDragon			= "Siguientes Crias Crepusculares",
	TimerEggWeakening	= "Caparazón Crepuscular Eliminado",
	TimerEggWeaken		= "Caparazón Crepuscular Regenerándose"
})

L:SetOptionLocalization({
	WarnDragon			= "Mostrar aviso cuando salga una Cría Crepuscular",
	WarnOrbsSoon		= "Mostrar pre-aviso para $spell:92954 (5s antes, cada segundo)\n(Puede ser impreciso. Puede spamear.)",
	WarnEggWeaken		= "Mostrar aviso cuando un huevo se haya debilitado",
	warnWrackJump		= "Anunciar los objetivos del salto de $spell:92955",
	WarnWrackCount5s	= "Announce los segundos de $spell:92955 transcurridos a los 10, 15, 20 segundos",
	SpecWarnOrbs		= "Mostrar aviso especial para $spell:92954\n(Puede ser impreciso.)",
	SpecWarnDispel		= "Mostrar aviso especial para dispellear $spell:92955\n(después de cierto tiempo de que haya saltado)",
	SpecWarnEggWeaken	= "Mostrar aviso especial cuando $spell:87654 es eliminado",
	SpecWarnEggShield	= "Mostrar aviso especial cuando $spell:87654 se hay regenerado",
	TimerDragon			= "Mostrar tiempo para que salga una nueva Cría Crepuscular",
	TimerEggWeakening	= "Mostrar tiempo para eliminación de $spell:87654",
	TimerEggWeaken		= "Mostrar tiempo para regeneración de $spell:87654",
	SetIconOnOrbs		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92954)

})

L:SetMiscLocalization({
	YellDragon			= "Feed, children!  Take your fill from their meaty husks!",--translate
	YellEgg				= "You mistake this for weakness?  Fool!"--translate
})

--------------------------
--  The Bastion of Twilight Trash  --
--------------------------
L = DBM:GetModLocalization("BoTrash")

L:SetGeneralLocalization({
	name =	"Pulls de Bastión del Crepúsculo"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})
