if GetLocale() ~= "esES" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Trash de la Ciudadela Inferior"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkReckoning			= "Poner iconos en los objetivos de $spell:69483"
}

L:SetMiscLocalization{
	WarderTrap1		= "¿Quién... anda ahí?",
	WarderTrap2		= "Estoy despierto..."
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Trash de Los Talleres de la Peste"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}


----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Tuetano"
}

L:SetTimerLocalization{
	achievementBoned	= "Time to free"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< es empalado!"
}


L:SetOptionLocalization{
	WarnImpale				= "Anuncia los jugadores empalados",
	achievementBoned		= "Mostrar tiempo para el logro Deshuesado",
	SetIconOnImpale			= "Poner icono a los jugadores empalados"
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
	WarnTouchInsignificance			= "%s on >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon					= "Nuevos adds pronto"
}



L:SetOptionLocalization{
	WarnAddsSoon					= "Mostrar un pre-aviso cuando vengan nuevos adds ",
	WarnReanimating					= "Mostrar un aviso cuando un add sea resucitado",											-- Reanimated Adherent/Fanatic spawning
	TimerAdds						= "Mostrar tiempo para nuevos adds",
	ShieldHealthFrame				= "Mostrar barra de vida del boss con una barra de vida para $spell:70842",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	SetIconOnDominateMind			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)

}

L:SetMiscLocalization{
	YellPull				= "¿Qué es este alboroto? ¿Osáis entrar en suelo sagrado? ¡Este será vuestro lugar de reposo final!",
	YellReanimatedFanatic	= "¡Álzate y goza de tu verdadera forma!",
	ShieldPercent			= "Barrera de maná"
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
	KillAlliance	= "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Libramorte Colmillosauro"
}

L:SetWarningLocalization{
	warnFrenzySoon	= "Frenesí pronto"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Empieza el combate"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Mostrar tiempo para inicio del combate",
	warnFrenzySoon	= "Mostrar preaviso para el Frenesí (at ~33%)",
	SetIconOnBoilingBlood	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	SetIconOnMarkCast		= "Poner iconos en los objetivos de $spell:72444 durante el casteo",
	RangeFrame		= "Mostrar distancia",
	RunePowerFrame			= "Mostrar barra de vida + barra de $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Blood Power",
	Pull				= "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge."
}


-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Panzachancro"
}

L:SetWarningLocalization{
	InhaledBlight		= "Inhalar añublo >%d<"
}

L:SetOptionLocalization{
	InhaledBlight		= "Mostrar aviso para $spell:71912",
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Caraputrea"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze			= "Moco pegajoso! Muévete!",
	SpecWarnRadiatingOoze		= "Moco emanador",
	SpecWarnMutatedInfection	= "Infección mutada en ti"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes	= "Next Poison Slime Pipes"
}

L:SetOptionLocalization{
	SpecWarnStickyOoze			= "Mostrar aviso especial para Moco pegajoso",
	SpecWarnRadiatingOoze		= "Mostrar aviso especial para Moco emanador",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "Mostrar aviso especial cuando te afecte Infección mutada",
	InfectionIcon				= "Set icons on Mutated Infection targets",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Putricide"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	YellPull	= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Consejo de Sangre"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Switch target to: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "Target switch soon",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Shadow Resonance - Move"
}

L:SetTimerLocalization{
	TimerTargetSwitch	= "Possible target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Show warning to switch targets",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	SpecWarnResonance		= "Show special warning when a Dark Nucleus is following you"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth	= "Prince Keleseth",
	Taldaram	= "Prince Taldaram",
	Valanar		= "Prince Valanar"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Reina de Sangre Lana'thel"
}

L:SetWarningLocalization{
	SpecWarnPactDarkfallen	= "Pact of the Darkfallen on you"
}

L:SetOptionLocalization{
	SpecWarnPactDarkfallen	= "Show special warning when you are affected by Pact of the Darkfallen"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Caminasuenos"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Next air phase",
	TimerNextGroundphase	= "Next ground phase"
}

L:SetWarningLocalization{
	WarnAirphase			= "Air phase",
	SpecWarnBlisteringCold	= "Blistering Cold - Run away",
	SpecWarnFrostBeacon		= "Frost Beacon on you",
	WarnGroundphaseSoon		= "Sindragosa landing soon",
	SpecWarnUnchainedMagic	= "Unchained Magic on you"
}

L:SetOptionLocalization{
	WarnAirphase			= "Announce air phase",
	SpecWarnBlisteringCold	= "Show special warning for Blistering Cold",
	SpecWarnFrostBeacon		= "Show special warning when you are affected by Frost Beacon",
	WarnGroundphaseSoon		= "Show pre-warning for ground phase",
	TimerNextAirphase		= "Show timer for next air phase",
	TimerNextGroundphase	= "Show timer for next ground phase",
	SpecWarnUnchainedMagic	= "Show special warning when you are affected by Unchained Magic"
}

L:SetMiscLocalization{
	YellAirphase	= "Your incursion ends here! None shall survive!",
	YellPull		= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "The Lich King"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

