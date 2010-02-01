if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Bestias de Rasganorte"
}

L:SetMiscLocalization{
	Charge			= "¡^%%s mira a (%S+) y emite un bramido!",
	CombatStart		= "Desde las cavernas más oscuras y profundas de Las Cumbres Tormentosas: ¡Gormok el Empalador! ¡A luchar, héroes!",
	Phase2			= "Preparaos, héroes, para los temibles gemelos: ¡Fauceácida y Aterraescama! ¡A la arena!",
	Phase3			= "El propio aire se congela al presentar a nuestro siguiente combatiente: ¡Aullahielo! ¡Matad o morid, campeones!",
	Gormok			= "Gormok el Empalador",
	Acidmaw			= "Fauceácida",
	Dreadscale		= "Aterraescama",
	Icehowl			= "Aullahielo"
}

L:SetOptionLocalization{
	WarningSnobold				= "Mostrar aviso cuando salen Vasallos snóbold",
	SpecialWarningImpale3		= "Mostrar aviso especial para Emaplar(>=3 ticks)",
	SpecialWarningAnger3		= "Mostrar aviso especial para Ira en aumento (>=3 ticks)",
	SpecialWarningSilence		= "Mostrar aviso especial para Silencio (bloqueo de hechizos)",
	SpecialWarningCharge		= "Mostrar aviso especial si Aullahielo te mira",
	SpecialWarningTranq			= "Mostrar aviso especial si Aullahielo gana Espumarajo (para tranquilizarlo)",
	PingCharge					= "Pulsar en el Minimapa si Aullahielo va a por Ti",
	SpecialWarningChargeNear	= "Mostrar aviso especial si Aullahielo va a cargar a alguien cerca de ti",
	SetIconOnChargeTarget		= "Poner marca a por quien va (calavera)",
	SetIconOnBileTarget			= "Poner marca quien tiene Bilis ardiente",
	ClearIconsOnIceHowl			= "Limpiar iconos despues de cargar",
	TimerNextBoss				= "Mostrar tiempo para el proximo boss",
	TimerCombatStart			= "Mostrar tiempo para el inicio del combate",
	TimerEmerge					= "Mostrar tiempo para emerger",
	TimerSubmerge				= "Mostrar tiempo para sumergir",
	RangeFrame                  = "Mostrar distancia en fase 2"
}

L:SetTimerLocalization{
	TimerNextBoss				= "Proximo boss en",
	TimerCombatStart			= "Empieza el combate",
	TimerEmerge					= "Emergen",
	TimerSubmerge				= "Se sumergen"

}

L:SetWarningLocalization{
	WarningSnobold				= "Sale Vasallo snóbold",
	SpecialWarningImpale3		= "Empalar >%d< en ti",
	SpecialWarningAnger3		= "Ira en aumento >%d<",
	SpecialWarningSilence		= "Silenciar en ~1.5 segundos",
	SpecialWarningCharge		= "Cargar en ti! Corre!",
	SpecialWarningChargeNear	= "Cargar cerca de ti! Corre",
	SpecialWarningTranq			= "Espumarajo! Tranquilizadlo!"
}

-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetWarningLocalization{
	WarnNetherPower			= "Poder abisal en Jaraxxus! Dispelead Ya!",
	SpecWarnTouch			= "Toque de Jaraxxus en TI!",
	SpecWarnTouchNear		= "Toque de Jaraxxus en >%s< cerca de ti",
	SpecWarnNetherPower		= "Dispelead Ya!",
	SpecWarnFelFireball		= "Bola de Fuego vil! Interrumpe!"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Empieza el combate"
}

L:SetMiscLocalization{
	WhisperFlame			= "Llama de la Legion en TI!",
	IncinerateTarget		= "Incinerar carne en: %s"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Mostrar tiempo para inicio del combate",
	WarnNetherPower			= "Avisar si Jaraxxus tiene Poder abisar (para dsipelear)",
	SpecWarnTouch			= "Aviso especial si tienes Toque de Jaraxxus",
	SpecWarnTouchNear		= "Aviso especial si tienes Toque de Jaraxxus cerca",
	SpecWarnNetherPower		= "Aviso especial para Poder abisal(para dispelear a jaraxxus)",
	SpecWarnFelFireball		= "Aviso especial para Fuego Vil ( para interrumpir )",
	TouchJaraxxusIcon		= "Poner icono quien tenga Toque de Jaraxxus",
	IncinerateFleshIcon		= "Poner icono quien tenga Carne",
	LegionFlameIcon			= "Poner icono quien tenga Llama de la Legion",
	LegionFlameWhisper		= "Susurrar a quien tenga la Llama de la Legion",
	LegionFlameRunSound		= "Reproducir sonido en Llama de la Legion",
	IncinerateShieldFrame	= "Mostrar la vida del boss con la barra de incinerar carne"
}

L:SetMiscLocalization{
	FirstPull	= "El gran brujo Wilfred Chispobang invocará al siguiente contrincante. Esperad a que aparezca."
}

-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Campeones de Facción"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetMiscLocalization{
	Gorgrim		= "DK - Gorgrim Rajasombra",		-- 34458
	Birana 		= "D - Birana Pezuña Tempestuosa",	-- 34451
	Erin		= "D - Erin Pezuña de Niebla",		-- 34459
	Rujkah		= "H - Ruj'kah",					-- 34448
	Ginselle	= "M - Ginselle Lanzaañublo",		-- 34449
	Liandra		= "P - Liandra Clamasol",			-- 34445
	Malithas	= "P - Malithas Hoja Brillante",	-- 34456
	Caiphus		= "PR - Caiphus el Austero",		-- 34447
	Vivienne	= "PR - Vivienne Susurro Oscuro",	-- 34441
	Mazdinah	= "R - Maz'dinah",					-- 34454
	Thrakgar	= "S - Thrakgar",					-- 34444
	Broln		= "S - Broln Cuernorrecio",			-- 34455
	Harkzog		= "WL - Harkzog",					-- 34450
	Narrhok		= "W - Narrhok Rompeacero",		-- 34453
	AllianceVictory    = "¡GLORIA A LA ALIANZA!",
	HordeVictory       = "That was just a taste of what the future brings. FOR THE HORDE!",--translate
	YellKill	= "Una victoria trágica y fútil. Hoy somos menos por las pérdidas que hemos sufrido. ¿Quién podría beneficiarse de tal insensatez además del Rey Exánime? Grandes guerreros han perdido la vida. ¿Y para qué? La verdad"
} 

L:SetOptionLocalization{
	PlaySoundOnBladestorm	= "Reproducir sonido en Filotormenta"
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Gemelas Val’kyrs"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Siguiente Habilidad especial"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "Habilidad especial pronto!",
	SpecWarnSpecial		= "Cambia color!",
	SpecWarnSwitchTarget		= "Cambio!",
	SpecWarnKickNow				= "Cortar ahora!",
	WarningTouchDebuff			= "Debuff en >%s<",
	WarningPoweroftheTwins		= "Pacto de las Gemelas - curar mas a >%s<",
	SpecWarnPoweroftheTwins		= "Pacto de las Gemelas!"
}

L:SetMiscLocalization{
	YellPull 	= "En el nombre de nuestro oscuro maestro. Por el Rey Exánime. Morirás.",
	Fjola 		= "Fjola Penívea",
	Eydis		= "Eydis Penalumbra"
}

L:SetOptionLocalization{
	TimerSpecialSpell	= "Mostrar tiempo para la siguiente habilidad especial",
	WarnSpecialSpellSoon	= "Pre-aviso para la siguiente habilidad especial",
	SpecWarnSpecial		= "Mostrar aviso especial si tienes que cambiar de color",
	SpecWarnSwitchTarget		= "Mostrar aviso especial si hay que ir al otro boss",
	SpecWarnKickNow				= "Mostrar aviso especial cuando tienes que cortar el hechizo",
	SpecialWarnOnDebuff			= "Mostrar aviso especial cuando tienes que cambiar de debuff",
	SetIconOnDebuffTarget		= "Poner iconos a los objetivos con debuff ( solo heroico )",
	WarningTouchDebuff			= "Anunciar objetivos del debuff de Toque de Luz/Oscuridad",
	WarningPoweroftheTwins		= "Anunciar objetivo de Pacto de las Gemelas",
	SpecWarnPoweroftheTwins		= "Mostrar aviso especial si eres el tank y estas en una gemela con el pacto de las gemelas"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Emerger en",
	TimerSubmerge			= "Sumersion en",
	timerAdds				= "Nuevos adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak emergido",
	WarnEmergeSoon			= "Emerger en 10 seg",
	WarnSubmerge			= "Anub'arak sumergido",
	WarnSubmergeSoon		= "Sumersion en 10 seg",
	specWarnSubmergeSoon	= "Sumersion en 10 segundos!",
	SpecWarnPursue			= "Te persigue a ti!",
	warnAdds				= "Nuevos adds",
	SpecWarnShadowStrike	= "Golpe de sombras! Corta ahora!"
}

L:SetMiscLocalization{
	YellPull				= "Éste lugar será vuestra tumba!",
	Emerge					= "Emerge!",
	Burrow					= "Se sumerge!",
	PcoldIconSet			= "Icono FrioP {rt%d} puesto en %s",
	PcoldIconRemoved		= "Icono FrioP eliminado de %s"
}

L:SetOptionLocalization{
	WarnEmerge				= "Mostrar aviso para Emerger",
	WarnEmergeSoon			= "Mostrar pre-aviso para Emerger",
	WarnSubmerge			= "Mostrar aviso para Sumersion",
	WarnSubmergeSoon		= "Mostrar pre-aviso para Sumersion",
	specWarnSubmergeSoon	= "Mostrar pre-aviso especial Sumersion",
	SpecWarnPursue			= "Mostrar aviso especial si te sigue a ti",
	warnAdds				= "Mostrar aviso para nuevos adds",
	timerAdds				= "Mostrar tiempo para nuevos adds",
	TimerEmerge				= "Mostrar tiempo para Emerger",
	TimerSubmerge			= "Mostrar tiempo para Sumerger",
	PlaySoundOnPursue		= "Reproducir sonidos si te persigue",
	PursueIcon				= "Poner icono en jugador",
	SpecWarnShadowStrike	= "Mostrar aviso especial para Golpe de sombras ( para cortar )",
	RemoveHealthBuffsInP3	= "Quitar bufos de vida al inicio de la fase 3", 
	SetIconsOnPCold         = "Poner iconos en los objetivos de $spell:68510",
	AnnouncePColdIcons		= "Anunciar iconos para los ojetivos de $spell:68510 en el chat de raid\n(Requiere 'anunciar' habilitado y lider o ayudante)",
	AnnouncePColdIconsRemoved	= "También anunciar cuando se eliminen los iconos de los objetivos $spell:68510\n(Necesita la opción anterior)"
}
