if GetLocale() ~= "esES" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Trashmobs"
}

L:SetWarningLocalization{
	SpecWarnDisruptingShout			= "Disrupting Shout - Stop Casting",
	SpecWarnDarkReckoning			= "Dark Reckoning - Move away"
}

L:SetOptionLocalization{
	SpecWarnDisruptingShout			= "Show special warning for $spell:71022",
	SpecWarnDarkReckoning			= "Show special warning when you are affected by $spell:69483",
	SetIconOnDarkReckoning			= "Set icons on $spell:69483 targets"
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
	WarnImpale			= ">%s< es empalado!",
	SpecWarnWhirlwind	= "Torbellino - Corre lejos",
--	SpecWarnColdflame	= "Llama Fria - Mu�vete!" -- bad encoding
}


L:SetOptionLocalization{
	WarnImpale				= "Anuncia los jugadores empalados",
	SpecWarnWhirlwind		= "Mostrar aviso especial para Torbellino",
--	SpecWarnColdflame		= "Mostrar aviso especial cuando est�s afectado por Llama Fr�a", -- bad encoding
	PlaySoundOnWhirlwind	= "Reproducir sonido de Torbellino",
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
	SpecWarnDeathDecay				= "Muerte y descomposicion - Muevete lejos!",
	SpecWarnCurseTorpor				= "Maldicion de sopor",
	SpecWarnTouchInsignificance		= "Toque de insignificancia (3)",
	WarnAddsSoon					= "Nuevos adds pronto"
}



L:SetOptionLocalization{
	WarnAddsSoon					= "Mostrar un pre-aviso cuando vengan nuevos adds ",
	WarnTouchInsignificance			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),		-- Warning isnt default (it has a count number), option is default tho (no need for translation this way)
	WarnReanimating					= "Mostrar un aviso cuando un add es resucitado",											-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance		= "Mostrar aviso especial cuando tienes 3 marcas de Toque de insignificancia",
	SpecWarnDeathDecay				= "Mostrar un aviso especial cuando estas afectado por muerte y descomposicion",
	SpecWarnCurseTorpor				= "Mostrar un aviso especial cuando sufres Maldicion de sopor",
	TimerAdds						= "Mostrar tiempo para nuevos adds",
	SetIconOnDominateMind			= "Poner iconos a los objetivos de Control Mental"
}

L:SetMiscLocalization{
--	YellPull				= "ÀQuŽ es este alboroto? ÀOs‡is entrar en suelo sagrado? ÁEste ser‡ vuestro lugar de reposo final!", -- bad encoding
--	YellReanimatedFanatic	= "Áçlzate y goza de tu verdadera forma!", -- bad encoding
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
	WarnAddsSoon		= "New adds soon"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Show time for start of combat",
	WarnAddsSoon		= "Show pre-warning for adds spawning",
	TimerAdds		= "Show timer for new adds"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts",
	TimerAdds		= "New adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Fire up the engines! We got a meetin' with destiny, lads!",
	KillAlliance	= "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Libramorte Saurfang"
}

L:SetWarningLocalization{
	warnFrenzySoon	= "Frenesi pronto"
}

L:SetOptionLocalization{
	warnFrenzySoon	= "Mostrar preaviso para el Frenes’ (at ~33%)",
	RangeFrame		= "Show range frame"
}


-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Panzachancro"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Caraputrea"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze			= "Sticky Ooze - Move out",
	SpecWarnRadiatingOoze		= "Radiating Ooze",
	SpecWarnMutatedInfection	= "Mutated Infection on you"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes	= "Next Poison Slime Pipes"
}

L:SetOptionLocalization{
	SpecWarnStickyOoze			= "Show special warning for Sticky Ooze",
	SpecWarnRadiatingOoze		= "Show special warning for Radiating Ooze",
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	SpecWarnMutatedInfection 	= "Show special warning when you are affected by Mutated Infection",
	InfectionIcon				= "Set icons on Mutated Infection targets",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning"
}

L:SetMiscLocalization{
	YellSlimePipes	= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
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

