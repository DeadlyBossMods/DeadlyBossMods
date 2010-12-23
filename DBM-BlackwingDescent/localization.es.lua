if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Faucemagma"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Sistema de defensa de Omnotron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Magmatron	= "Magmatron",
	Electron	= "Electron",
	Toxitron	= "Toxitron",
	Arcanotron	= "Arcanotron",
	SayBomb		= "¡Bomba de veneno en mi!"
})

L:SetOptionLocalization({
	SayBombTarget	= "Gritar en el chat cuando seas el objetivo de $spell:80157",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowInfusionIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92048)
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase		= "Fase %s",
	WarnRemainingAdds	= "%d aberraciones restantes"
})

L:SetTimerLocalization({
	TimerPhase		= "Siguiente fase"
})

L:SetMiscLocalization({
	YellRed			= "red|r vial into the cauldron!",--translate
	YellBlue		= "blue|r vial into the cauldron!",--translate
	YellGreen		= "green|r vial into the cauldron!",--translate
	YellDark		= "dark|r vial into the cauldron!",--translate
	Red				= "Roja",
	Blue			= "Azul",
	Green			= "Verde",
	Dark			= "Oscura"
})

L:SetOptionLocalization({
	WarnPhase		= "Mostrar aviso de la fase que viene",
	WarnRemainingAdds	= "Mostrar un aviso con las aberraciones restantes",
	TimerPhase		= "Mostrar tiempo para la siguiente fase",	
	RangeFrame		= "Mostrar distancia (6 yardas) durante la fase azul",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})


-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Fase 2 pronto",
	WarnBreak	= "%s en >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Mostrar un preaviso para la fase 2",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown")
})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase		= "Fase aerea",
	WarnGroundphase		= "Fase en tierra",
	WarnShieldsLeft		= "Ancient Dwarven Shield used - %d left"--translate
})

L:SetTimerLocalization({
	TimerAirphase		= "Fase aerea",
	TimerGroundphase	= "Fase en tierra"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Ancient Dwarven Shield",--translate
	Airphase		= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"--translate
})

L:SetOptionLocalization({
	WarnAirphase		= "Mostrar aviso cuando Atramedes levanta el vuelo",
	WarnGroundphase		= "Mostrar aviso cuando Atramedes aterriza",
	WarnShieldsLeft		= "Show warning when a Ancient Dwarven Shield gets used",--translate
	TimerAirphase		= "Mostrar tiempo para siguiente Fase aerea",
	TimerGroundphase	= "Mostrar tiempo para siguiente Fase en tierra",
	TrackingIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	YellPhase2		= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",--translate
	ChromaticPrototype	= "Chromatic Prototype"--translate
})

L:SetOptionLocalization({
})
