if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Trash de la Ciudadela Inferior"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "¡Trampa activada! ¡Sale un Depositario!"
}

L:SetOptionLocalization{
	SpecWarnTrap		= "Mostrar aviso especial cuando se active trampa",
	SetIconOnDarkReckoning		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "¿Quién... anda ahí?",
	WarderTrap2		= "Estoy despierto...",
	WarderTrap3		= "El sagrario del maestro ha sido perturbado."
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Precioso y Apestoso"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s en >%s< (%d)",
	SpecWarnTrap	= "¡Trampa activada! ¡Salen Siegacarnes vengativos!"--creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap		= "Mostrar aviso especial cuando se active trampa",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Rápido, ¡atacaremos por la espalda!",
	FleshreaperTrap2		= "¡No... puedes escapar!",
	FleshreaperTrap3		= "¿Los vivos? ¿¡Aquí!?"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Trash de La Sala Carmsesí"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "Trash de Las Cámaras de Alaescarcha"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "¡Guantelete de Sindragosa ha empezado!"
}

L:SetTimerLocalization{
	GosaTimer			= "Tiempo restante"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "Mostrar aviso especial para el guantelete de Sindragosa",
	GosaTimer			= "Mostrar tiempo para el evento del guantelete de Sindragosa"
}

L:SetMiscLocalization{
	SindragosaEvent		= "No debéis acercaros a la Reina de Escarcha. ¡Detenedlos, rápido!"
}


----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Tuetano"
}

L:SetTimerLocalization{
	AchievementBoned	= "Tiempo para liberar"
}

L:SetWarningLocalization{
	WarnImpale			= "¡>%s< es empalado!"
}


L:SetOptionLocalization{
	WarnImpale				= "Anuncia los jugadores empalados",
	AchievementBoned		= "Mostrar tiempo para el logro Deshuesado",
	SetIconOnImpale			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Susurramuerte"
}

L:SetTimerLocalization{
	TimerAdds				= "Nuevos Adds"
}


L:SetWarningLocalization{
	WarnReanimating					= "Resurreccion de Add",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance			= "%s en >%s< (%d)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon					= "Nuevos adds pronto",
	SpecWarnVengefulShade		= "¡Sombra vengativa te ataca! ¡Corre!"--creatureid 38222
}



L:SetOptionLocalization{
	WarnAddsSoon					= "Mostrar un pre-aviso cuando vengan nuevos adds ",
	WarnReanimating					= "Mostrar un aviso cuando un add sea resucitado",											-- Reanimated Adherent/Fanatic spawning
	TimerAdds						= "Mostrar tiempo para nuevos adds",
	SpecWarnVengefulShade			= "Mostrar aviso especial cuando te ataque una Sombra vengativa",--creatureid 38222
	ShieldHealthFrame				= "Mostrar barra de vida del boss con una barra de vida para $spell:70842",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	SetIconOnDominateMind			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)

}

L:SetMiscLocalization{
	YellPull				= "¿Qué es este alboroto? ¿Osáis entrar en suelo sagrado? ¡Este será vuestro lugar de reposo final!",
	YellReanimatedFanatic	= "¡Álzate y goza de tu verdadera forma!",
	ShieldPercent			= "Barrera de maná",
	Fanatic1				= "Fanático del Culto",
	Fanatic2				= "Fanático deformado",
	Fanatic3				= "Fanático reanimado"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Batalla de naves de guerra"
}

L:SetWarningLocalization{
	WarnBattleFury		= "%s (%d)",
	WarnAddsSoon		= "Nuevos adds pronto"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Mostrar tiempo para el inicio del combate",
	WarnAddsSoon		= "Mostrar pre-aviso para la salida de nuevos adds",
	TimerAdds		= "Mostrar tiempo para nuevos adds"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate",
	TimerAdds		= "Nuevos adds"
}

L:SetMiscLocalization{
	PullAlliance	= "¡Arrancad motores! ¡Tenemos una cita con el destino, muchachos!",
	KillAlliance	= "¡No digáis que no lo avisé, sinvergüenzas! Adelante, hermanos.",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!!",--translate
	KillHorde		= "The Alliance falter. Onward to the Lich King!",--translate
	AddsAlliance	= "¡Atracadores, Sargentos, atacad!",
	AddsHorde		= "¡Atracadores, Marinos, atacad!"

}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Libramorte Colmillosauro"
}

L:SetWarningLocalization{
	WarnFrenzySoon	= "Frenesí pronto"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Empieza el combate"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Mostrar tiempo para inicio del combate",
	WarnFrenzySoon	= "Mostrar preaviso para el Frenesí (at ~33%)",
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame		= "Mostrar distancia (12 yardas)",
	RunePowerFrame			= "Mostrar barra de vida + barra de $spell:72371",
	BeastIcons				= "Poner iconos en las Bestias de Sangre"
}

L:SetMiscLocalization{
	RunePower			= "Poder de sangre",
	PullAlliance		= "Por cada soldado de la Horda que matasteis... Por cada perro de la Alianza que cayó, el ejército del Rey Exánime creció. Ahora, hasta las Val'kyr alzan a los caídos para la Plaga.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs! The Scourge have been..."--translate
}


-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Panzachancro"
}

L:SetWarningLocalization{
	InhaledBlight		= "Inhalar añublo >%d<",
	WarnGastricBloat	= "%s en >%s< (%d)"
}

L:SetOptionLocalization{
	InhaledBlight		= "Mostrar aviso para $spell:71912",
	RangeFrame			= "Mostrar distancia (8 yardas)",
	WarnGastricBloat	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),	
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons	= "Anunciar los iconos de los objetivos de $spell:69279 en el chat de banda\n(Necesita Anunciar habilitado y ayudante/líder de banda)",
	AchievementCheck	= "Anunciar fallo del logro 'Sin vacunas' a la banda\n(requiere líder/ayudante)"
}

L:SetMiscLocalization{
	SporeSet	= "Icono {rt%d} de espora de gas en %s",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Inoculado <<"
}


---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Caraputrea"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Sale moco pequeño",
	WarnUnstableOoze			= "%s en >%s< (%d)",			-- Unstable Ooze on >args.destName< (args.amount)
	SpecWarnLittleOoze			= "¡Moco pequeño te ataca! ¡Corre!" --creatureid 36897
}

L:SetTimerLocalization{
	NextPoisonSlimePipes	= "Siguientes tuberías de babosas"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Mostrar tiempo para siguientes tuberías de babosas venenosas",
	WarnOozeSpawn				= "Mostrar aviso cuando salgan mocos pequeños",
	SpecWarnLittleOoze			= "Mostrar aviso especial cuando te ataque un Moco pequeño",--creatureid 36897
	RangeFrame					= "Mostrar distancia (8 yardas)",
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "Mostrar flecha hacia el tanque del Moco grande (Experimental)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "¡Buenas noticias, amigos! He arreglado las tuberías de babosas venenosas.",	-- Professor Putricide
	YellSlimePipes2	= "¡Grandes noticias, amigos! Las babosas vuelven a fluir."	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Putricidio"
}

L:SetWarningLocalization{
	WarnPhase2Soon		= "Fase 2 pronto",
	WarnPhase3Soon		= "Fase 3 pronto",
	WarnMutatedPlague	= "%s en >%s< (%d)",	-- Mutated Plague on >args.destName< (args.amount)
	SpecWarnMalleableGoo		= "Moco maleable en ti ¡Muévete!",
	SpecWarnMalleableGooNear	= "Moco maleable cerca de ti ¡Ten cuidado!",
	SpecWarnUnboundPlague		= "¡Transfiere la Peste desatada!",
	SpecWarnNextPlageSelf		= "¡Peste desatada pronto en ti pronto, prepárate!"
}

L:SetOptionLocalization{
	WarnPhase2Soon			= "Mostrar pre-aviso para Fase 2 (al ~83%)",
	WarnPhase3Soon			= "Mostrar pre-aviso para Fase 3 (al ~38%)",	
	SpecWarnMalleableGoo		= "Mostrar aviso especial para Moco maleable en ti\n(Sólo funciona en el primer objetivo)",
	SpecWarnMalleableGooNear	= "Mostrar aviso especial para Moco maleable cerca de ti\n(Sólo funciona si estás cerca del primer objetivo)",
	WarnMutatedPlague		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Poner icono en el primero objetivo de $spell:72295",
	NextUnboundPlagueTargetIcon	= "Poner icono en el siguiente objetivo de $spell:72856",
	YellOnMalleableGoo			= "Gritar cuando tengas $spell:72295",
	YellOnUnbound				= "Gritar cuando tengas $spell:72856",	
	GooArrow					= "Mostrar flecha cuando $spell:72295 esté cerca de ti",
	SpecWarnUnboundPlague		= "Mostrar aviso especial para transferencia de $spell:72856",
	SpecWarnNextPlageSelf		= "Mostrar aviso especial cuando seas el próximo objetivo de $spell:72856",
	BypassLatencyCheck			= "No usar la comprobación de sincronización basada en latencia para $spell:72295\n(sólo usar esta opción si tienes problemas de otro modo)"
}

L:SetMiscLocalization{
	YellPull	= "¡Buenas noticias, amigos! Creo que he perfeccionado una plaga que destruirá toda la vida en Azeroth.",
	YellMalleable	= "¡Moco maleable va hacia mi!",
	YellUnbound		= "¡Peste desatada en mi!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Concilio de los Príncipes de Sangre"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Cambiar objetivo a: %s",	
	WarnTargetSwitchSoon	= "Cambiar de objetivo pronto",	
	SpecWarnVortex			= "Vórtice de choque en ti ¡Muévete!",
	SpecWarnVortexNear		= "Vórtice de choque cerca de ti ¡Ten cuidado!"
}

L:SetTimerLocalization{
	TimerTargetSwitch	= "Cambio de objetivo"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Mostrar aviso para cambiar de objetivos",
	WarnTargetSwitchSoon	= "Mostrar pre-aviso para cambiar de objetivos",
	TimerTargetSwitch		= "Mostrar tiempo para siguiente cambio de objetivo",
	SpecWarnVortex			= "Mostrar aviso especial para $spell:72037 en ti",
	SpecWarnVortexNear		= "Mostrar aviso especial para $spell:72037 cerca de ti",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Poner un icono en el príncipe con Invocación (Cruz)",
	RangeFrame				= "Mostrar distancia (12 yardas)",
	VortexArrow				= "Mostrar flecha cuando $spell:72037 esté cerca de ti",
	BypassLatencyCheck		= "No usar la comprobación de sincronización basada en latencia para $spell:72037\n(sólo usar esta opción si tienes problemas de otro modo)"
}

L:SetMiscLocalization{
	Keleseth	= "Príncipe Keleseth",
	Taldaram	= "Príncipe Taldaram",
	Valanar		= "Príncipe Valanar",
	EmpoweredFlames		= "¡Llamas potenciadas arremeten contra (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reina de Sangre Lana'thel"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkFallen			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame					= "Mostrar distancia (8 yardas)",
	YellOnFrenzy				= "Gritar cuando tengas $spell:71474"
}

L:SetMiscLocalization{
	SwarmingShadows			= "¡Las sombras se acumulan alrededor de (%S+)!",
	YellFrenzy				= "¡Tengo hambre!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Caminasueños"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s en >%s< (%d)",
	WarnPortalOpen	= "Se abren los portales"
}

L:SetTimerLocalization{
	TimerPortalsOpen	= "Se abren los portales",
	TimerBlazingSkeleton	= "Siguiente Esqueleto llameante",
	TimerAbom				= "Siguiente Abominación"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Poner icono en Esqueleto llameante (calavera)",
	WarnPortalOpen				= "Mostrar aviso cuando $spell:72483 se abren",
	TimerPortalsOpen			= "Mostrar tiempo para la apertura de Portal Pesadilla",
	TimerBlazingSkeleton			= "Mostrar tiempo para la próxima salida de Esqueleto llameante",
	TimerAbom					= "Mostrar tiempo para siguiente Abominación glotona (Experimental)",
	WarnCorrosion	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull		= "Han entrado intrusos en el Sagrario Interior. Apresuraos en acabar con el dragón verde. ¡Dejad solo huesos y tendones para la reanimación!",
	YellKill		= "¡ESTOY RENOVADA! Ysera, haz que estas asquerosas criaturas descansen.",
	YellPortals		= "He abierto un portal al Sueño. Vuestra salvación está dentro, héroes...",
	YellPhase2		= "Mi fuerza vuelve. ¡Continuad, héroes!"
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Siguiente fase aerea",
	TimerNextGroundphase	= "Siguiente fase en el suelo",
	AchievementMystic		= "Tiempo para limpiar Sacudida Mística"
}

L:SetWarningLocalization{
	WarnPhase2soon			= "Fase 2 pronto",
	WarnAirphase			= "Fase aerea",
	WarnGroundphaseSoon		= "Sindragosa aterriza pronto",
	WarnInstability			= "Inestabilidad >%d<",
	WarnChilledtotheBone	= "Helado hasta los huesos >%d<",
	WarnMysticBuffet		= "Sacudida mística >%d<"
}

L:SetOptionLocalization{
	WarnAirphase			= "Anunciar fase aerea",
	WarnGroundphaseSoon		= "Mostrar pre-aviso para fase en el suelo",
	WarnPhase2soon			= "Mostrar pre-aviso para Fase 2 (al ~33%)",
	TimerNextAirphase		= "Mostrar tiempo para siguiente fase aerea",
	TimerNextGroundphase	= "Mostrar tiempo para siguiente fase en el suelo",
	WarnInstability			= "Mostrar aviso de tus marcas de $spell:69766",
	WarnChilledtotheBone	= "Mostrar aviso de tus marcas de $spell:70106",
	WarnMysticBuffet		= "Mostrar aviso de tus marcas de $spell:70128",
	AnnounceFrostBeaconIcons= "Anunciar los iconos de los objetivos de $spell:70126 en el chat de banda\n(Requiere 'anunciar' activado y líder/ayudante)",
	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase	= "Eliminar todos los iconos antes de la fase aerea",
	AchievementCheck		= "Anunciar avisos del logro 'Sacúdete' a la banda\n(Requiere líder/ayudante)",
	RangeFrame				= "Mostrar distancia (10 normal, 20 heroico)\n(Solo mostrará los jugadores marcados)"
}

L:SetMiscLocalization{
	YellAirphase	= "¡Aquí termina vuestra incursión! ¡Nadie sobrevivirá!",
	YellPhase2		= "¡Ahora sentid el poder sin fin de mi maestro y desesperad!",
	BeaconIconSet	= "Señal de Escarcha, icono {rt%d} en %s",
	AchievementWarning	= "Aviso: %s tiene 5 marcas de Sacudida mística",
	AchievementFailed	= ">> LOGRO FALLADO: %s tiene %d marcas de Sacudida mística <<",
	YellPull		= "¡Estáis locos por haber venido aquí! Los vientos helados de Rasganorte consumirán vuestras almas."
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "El Rey Exánime"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "Transición a la Fase 2 pronto",
	WarnPhase3Soon			= "Transición a la Fase 3 pronto",
	ValkyrWarning			= "¡>%s< ha sido agarrado!",
	SpecWarnYouAreValkd		= "¡Te agarra una Valkyr!",
	SpecWarnDefileCast		= "Profanar en ti ¡Muévete!",
	SpecWarnDefileNear		= "Profanar cerca de ti ¡Ten cuidado!",
	SpecWarnTrapNear		= "Trampa de las Sombras cerca de ti ¡Ten cuidado!",
	WarnNecroticPlagueJump	= "Peste necrótica saltó a >%s<",
	SpecWarnPALGrabbed		= "Paladin Healer %s ha sido agarrado",
	SpecWarnPRIGrabbed		= "Sacerdote Healer %s ha sido agarrado",
	SpecWarnValkyrLow		= "Valkyr con menos del 55%"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Empieza el combate",
	TimerRoleplay		= "Diálogo",
	PhaseTransition		= "Transición de fase",
	TimerNecroticPlagueCleanse = "Purgar Peste necrótica"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Mostrar tiempo para el inicio del combate",
	TimerRoleplay			= "Mostrar tiempo para Diálogo",
	WarnNecroticPlagueJump	= "Anunciar los objetivos donde $spell:73912 ha saltado",
	TimerNecroticPlagueCleanse	= "Mostrar tiempo para purgar Peste necrótica\nantes de la primera marca",
	PhaseTransition			= "Mostrar tiempo para las transiciones de fase",
	WarnPhase2Soon			= "Mostrar pre-aviso para transición a la Fase 2 (al ~73%)",
	WarnPhase3Soon			= "Mostrar pre-aviso para transición a la Fase 3 (al ~43%)",
	ValkyrWarning			= "Anunciar quien ha sido agarrado por las Valkyr",
	SpecWarnYouAreValkd		= "Mostrar aviso especial cuando seas agarrado por una Valkyr",
	SpecWarnHealerGrabbed	= "Mostrar un aviso especial cuando un healer paladín o sacerdote es agarrado\n(Es necesario que ese healer esté usando DBM)",
	SpecWarnDefileCast		= "Mostrar aviso especial para $spell:72762 en ti",
	SpecWarnDefileNear		= "Mostrar aviso especial para $spell:72762 cerca de ti",
	SpecWarnTrapNear		= "Mostrar aviso especial para $spell:73539 cerca de ti",
	YellOnDefile			= "Gritar cuando tengas $spell:72762",
	YellOnTrap				= "Gritar cuando tengas $spell:73539",
	DefileIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
	ValkyrIcon				= "Poner iconos en las Valkyr",
	DefileArrow				= "Mostrar flecha cuando $spell:72762 está cerca de ti",
	TrapArrow				= "Mostrar flecha cuando $spell:73539 está cerca de ti",
	LKBugWorkaround			= "No usar la comprobación de sincronización basada en latencia para profanar/trampa de las sombras\n(Activado por defecto hasta que se arregle un bug de comprovación sincronización)",
	AnnounceValkGrabs		= "Aunciar el objetivo de Guardia de las Sombras Val'kyr en el chat de banda\n(necesita 'anunciar' activado y líder/ayudante)",
	SpecWarnValkyrLow		= "Mostrar aviso especial cuando la Valkyr está por debajo del 55%",
	AnnouncePlagueStack		= "Anunciar las marcas de $spell:73912 a la banda (10 marcas, cada 5 después)\n(requiere líder/ayudante)"
}

L:SetMiscLocalization{
	LKPull		= "¿Así que por fin ha llegado la elogiada justicia de la Luz? ¿Debería deponer la Agonía de Escarcha y confiar en tu piedad, Vadín?",
	YellDefile		= "¡Profanar en mi!",
	YellTrap		= "¡Trampa de sombras en mi!",
	YellValk		= "¡Me han agarrado!",
	LKRoleplay		= "¿Me pregunto si de verdad os mueve la... rectitud?",
	PlagueWhisper	= "Has sido infectado por",
	ValkGrabbedIcon	= "Val'kyr {rt%d} ha agarrado a %s",
	ValkGrabbed		= "Val'kyr ha agarrado a %s",
	PlagueStackWarning		= "Aviso: %s tiene %d marcas de Peste Necrótica",
	AchievementCompleted	= ">> LOGRO COMPLETADO: %s tiene %d marcas de Peste Necrótica <<"
}

