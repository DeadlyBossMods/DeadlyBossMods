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
	Trigger1				= "Theralion, voy a incendiar el corredor. ¡Que no escapen!"--Change this to what deep breath emote is.
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"Consejo de ascendientes"
})

L:SetWarningLocalization({
	specWarnBossLow			= "%s below 30%% - next phase soon!",
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
	SetIconOnCreature		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82414)
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
	WarnSlicerSoon		= "¡Cercenadora Crepuscular en %d seg!",
	WarnEggWeaken		= "Huevo sin Caparazón Crepuscular",
	SpecWarnSlicer		= "¡Cercenadora Crepuscular pronto!",
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
	WarnSlicerSoon		= "Show pre-warning for $spell:92954 (Before 5s, Every 1s)\n(Expected warning. may not be accurate. Can be spammy.)",--translate
	WarnEggWeaken		= "Mostrar aviso cuando un huevo se haya debilitado",
	SpecWarnSlicer		= "Show special warning for $spell:92954\n(Expected warning. may not be accurate)",--translate
	SpecWarnDispel		= "Show special warning to dispel $spell:92955\n(after certain time elapsed from casted/jumped)",--translate
	SpecWarnEggWeaken	= "Show special warning when $spell:87654 removed", -- translate
	SpecWarnEggShield	= "Show special warning when $spell:87654 regenerated", -- translate
	TimerDragon			= "Mostrar tiempo para que salga una nueva Cría Crepuscular",
	TimerEggWeakening	= "Mostrar tiempo para eliminación de $spell:87654",
	TimerEggWeaken		= "Mostrar tiempo para regeneración de $spell:87654"

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
