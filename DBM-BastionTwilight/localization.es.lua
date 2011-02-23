if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"Valiona y Theralion"
})

L:SetWarningLocalization({
	WarnDazzlingDestruction	= "%s (%d)",
	WarnDeepBreath			= "%s (%d)",
	WarnTwilightShift		= "%s : >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnDazzlingDestruction	= "Mostrar aviso para $spell:86408",
	WarnDeepBreath			= "Mostrar aviso para $spell:86059",
	WarnTwilightShift		= "Mostrar aviso para $spell:93051",
	YellOnEngulfing			= "Gritar cuando tengas $spell:86622",
	YellOnTwilightMeteor	= "Gritar cuando tengas $spell:88518",
	YellOnTwilightBlast		= "Gritar cuando tengas $spell:92898",
	TwilightBlastArrow		= "Mostrar flecha cuando $spell:92898 está cerca de ti",
	RangeFrame				= "Mostrar distancia (10 yardas)",
	BlackoutIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92878),
	EngulfingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(86622)
})

L:SetMiscLocalization({
	Trigger1				= "Theralion, voy a incendiar el corredor. ¡Que no escapen!",--Change this to what deep breath emote is.
	YellEngulfing				= "¡Trago de magia en mi!",
	YellMeteor				= "¡Meteorito Crepuscular en mi!",
	YellTwilightBlast		= "¡Explosión Crepuscular en mi!"
})


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

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Consejo de ascendientes"
})

L:SetWarningLocalization({
	SpecWarnGrounded	= "Coge el bufo de Domeñado",
	SpecWarnSearingWinds	= "Coge el bufo de Vientos espirales",
	warnGravityCoreJump		= "¡Núcleo de gravedad se ha propagado a >%s<",
	warnStaticOverloadJump	= "¡Sobrecarga estática se ha propagado a >%s<"
})

L:SetTimerLocalization({
	timerTransition		= "Transición de fase"
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "Mostrar aviso especial cuando estes a punto de perder el bufo de $spell:83581\n(~10seg antes de castear)",
	SpecWarnSearingWinds	= "Mostrar aviso especial cuando estes a punto de perder el bufo de $spell:83500\n(~10seg antes de castear)",
	timerTransition		= "Mostrar tiempo para transición de fase",
	RangeFrame			= "Mostrar distancia cuando sea necesario",
	warnGravityCoreJump		= "Anunciar los objetivos de la propagación de $spell:92538",
	warnStaticOverloadJump	= "Announce los objetivos de la propagación de $spell:92467 ",
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
	WarnPhase2Soon	= "Fase 2 pronto"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Mostrar preaviso para Fase 2",
	YellOnCorrupting	= "Gritar cuando tengas $spell:93178",
	CorruptingCrashArrow	= "Mostrar una flecha cuando $spell:93178 está cerca de ti",
	InfoFrame			= "Mostrar información para $spell:82235",
	RangeFrame			= "Mostrar distancia (5 yardas) para $spell:82235",
	SetIconOnWorship	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(91317),
	SetIconOnCreature		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82414)
})

L:SetMiscLocalization({
	YellCrash	= "¡Colisión en corrupción en mi!",
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
	WarnEggWeaken		= "Huevo sin Caparazón Crepuscular",
	WarnDragon			= "Sale Cría Crepuscular"
})

L:SetTimerLocalization({
	TimerEggWeakening	= "Huevo debilitándose",
	TimerDragon			= "Siguiente Cría Crepuscular"
})

L:SetOptionLocalization({
	WarnEggWeaken		= "Mostrar aviso cuando un huevo se haya debilitado",
	WarnDragon			= "Mostrar aviso cuando salga una Cría Crepuscular",
	TimerEggWeakening	= "Mostrar tiempo para Huevo Debilitado",
	TimerDragon			= "Mostrar tiempo para que salga una nueva Cría Crepuscular"
})

L:SetMiscLocalization({
	YellDragon			= "Feed, children!  Take your fill from their meaty husks!",--translate
	YellEgg				= "You mistake this for weakness?  Fool!"--translate
})