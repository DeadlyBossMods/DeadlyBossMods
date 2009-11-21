local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Marrowgar"
}

L:SetTimerLocalization{
	achievementBoned		= "Time to free"
}

L:SetWarningLocalization{
	WarnImpale				= ">%s< is impaled",
	SpecWarnWhirlwind		= "Whirlwind - Run away",
	SpecWarnColdflame		= "Coldflame - Move away"
}

L:SetOptionLocalization{
	WarnImpale				= "Announce Impale targets",
	SpecWarnWhirlwind		= "Show special warning for Whirlwind",
	SpecWarnColdflame		= "Show special warning when you take damage from Coldflame",
	PlaySoundOnWhirlwind	= "Play sound on Whirlwind",
	achievementBoned		= "Show timer for Boned Achievement"
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Deathwhisper"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnReanimating			= "Add reviving",	-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s on >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	SpecWarnDeathDecay		= "Death and Decay - move away",
	SpecWarnCurseTorpor		= "Curse of Torpor on you",
	SpecWarnTouchInsignificance	= "Touch of Insignificance (3)"
}

L:SetOptionLocalization{
	WarnTouchInsignificance		= "Show warning for Touch of Insignificance",
	WarnReanimating			= "Show warning when an add is getting revived",	-- Reanimated Adherent/Fanatic spawning
	SpecWarnTouchInsignificance	= "Show special warning when you have 3 stacks of Touch of Insignificance",
	SpecWarnDeathDecay		= "Show special warning when you are affected by Death and Decay",
	SpecWarnCurseTorpor		= "Show special warning when you are affected by Curse of Torpor"
}

L:SetMiscLocalization{
	YellPull			= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellReanimatedFanatic		= "Arise, and exult in your pure form!",
}
------------------------
--  The Deathbringer  --
------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "The Deathbringer"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Gunship Battle"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Festergut"
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
	name = "Rotface"
}

L:SetWarningLocalization{
	SpecWarnStickyOoze			= "Sticky Ooze - Move out",
	SpecWarnRadiatingOoze		= "Radiating Ooze",
	SpecWarnMutatedInfection 	= "Mutated Infection on you"
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
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
	YellSlimePipes				= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
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
	name = "Blood Prince Council"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Switch target to: %s",		-- Ugh, no nice spellname/id to use for general localization :(
	WarnTargetSwitchSoon	= "Target switch soon",			-- Spellname = Invocation of Blood   or   Spellname = Invocation of Blood (X) Move  (server side script where X indicates the first letter of the Prince name
	SpecWarnResonance		= "Shadow Resonance - Move"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Possible target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Show warning to switch targets",								-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",							-- Every ~31 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	SpecWarnResonance		= "Show special warning when a Dark Nucleus is following you"	-- If it follows you, you have to move to the tank
}

L:SetMiscLocalization{
	Keleseth				= "Prince Keleseth",
	Taldaram				= "Prince Taldaram",
	Valanar					= "Prince Valanar"
}

-----------------------
--  Queen Lana'thel  --
-----------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Blood Queen Lanathel"
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
	name = "Valithria Dreamwalker"
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
	YellAirphase			= "Your incursion ends here! None shall survive!",
	YellPull				= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"
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

