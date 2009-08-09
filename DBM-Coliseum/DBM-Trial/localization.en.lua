local L

----------------------
-- Northrend Beasts --
----------------------
L = DBM:GetModLocalization("Beasts")

L:SetGeneralLocalization{
	name = "Northrend Beasts"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnStomp	= "Staggering Stomp",
	WarnStompSoon	= "Stomp soon!",
	WarnImpaler	= "%d Impaler on >%s<",
	WarnAcidicSpew	= "Acidic Spew",
	WarnMoltenSpew	= "Molten Spew",
	WarnToxic	= "Paralytic Toxin: >%s<",
	WarnBurn	= "Burning Bile: >%s<",
	WarnSlime	= "Slime Pool",
	WarnEnrage	= "Enraged!",
	WarnButt	= "Ferocious Butt on: >%s<",
	WarnCharge	= "Furious Charge on: >%s<",
	WarnChargeSoon	= "Trample Soon",
	WarnDaze	= "Staggered Daze",
	WarnRage	= "Frothing Rage!"
}

L:SetMiscLocalization{
	Phase2		= "Steel yourselves heroes, for the twin terrors. Acidmaw and Dreadscale, enter the arena!",
	Phase3		= "The air itself freezes with the introduction of our next combatant. Icehowl! Kill or be killed, champions!",
	Charge		= "FIXME",
	Gormok		= "Gormok the Impaler",
	Acidmaw		= "Acidmaw",
	Dreadscale	= "Dreadscale",
	Icehowl		= "Icehowl",
	SpecWarnToxic	= "Paralytic Toxin on YOU!",
	SpecWarnBurn	= "Burning Bile on YOU!",
	SpecWarnCharge	= "Furious Charge on YOU!"
}

L:SetOptionLocalization{
	WarnStomp	= "Warn when Gormok casts Staggering Stomp.",
	WarnStompSoon	= "Prewarning for Staggering Stomp",
	WarnImpaler	= "Warn when someone has 2 or more stacks of Impaler.",
	WarnAcidicSpew	= "Warn for Acidic Spew",
	WarnMoltenSpew	= "Warn for Molten Spew",
	WarnToxic	= "Warn who has Paralytic Toxin",
	WarnBurn	= "Warn who has Burning Bile",
	WarnSlime	= "Warn for Slime Pool",
	WarnEnrage	= "Warn for Enrage",
	WarnButt	= "Warn for Ferocious Butt",
	WarnCharge	= "Warn about Furious Charge on players",
	WarnChargeSoon	= "Prewarn for Furious Charge",
	WarnDaze	= "Warn when Icehowl gains Staggered Daze",
	WarnRage	= "Warn when Icehowl gains Frothing Rage",
	SpecWarnToxic	= "Warn if YOU have Paralytic Toxin",
	SpecWarnBurn	= "Warn if YOU have Burning Bile",
	SpecWarnCharge	= "Warn if YOU have Furious Charge"
}


-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("LordJaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	PortalSoonWarning	= "Nether Portal Soon!",
	VolcanoSoonWarning	= "Infernal Volcano Soon!",
	WarnFlame		= "Legion Flame on >%s<!"
}

L:SetMiscLocalization{
	SpecWarnFlame		= "Legion Flame on YOU!",
	SpecWarnFlesh		= "Incinerate Flesh on YOU!"
}

L:SetOptionLocalization{
	PortalSoonWarning	= "Prewarn Nether Portal spawning",
	VolcanoSoonWarning	= "Prewarn Infernal Volcano spawning",
	WarnFlame		= "Warns for Legion Flame",
	SpecWarnFlame		= "Special warning when you have Legion Flame",
	SpecWarnFlesh		= "Special warning when you have Incinerate Flesh"
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Faction")

L:SetGeneralLocalization{
	name = "Faction Champions"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetMiscLocalization{
	Gorgrim		= "DK - Gorgrim Shadowcleave",	-- 34458
	Birana 		= "D - Birana Stormhoof",	-- 34451
	Erin		= "D - Erin Misthoof",		-- 34459
	Rujkah		= "H - Ruj'kah",		-- 34448
	Ginselle	= "M - Ginselle Blightslinger",	-- 34449
	Liandra		= "P - Liandra Suncaller",	-- 45
	Malithas	= "P - Malithas Brightblade",	-- 56
	Caiphus		= "PR - Caiphus the Stern",	-- 47
	Vivienne	= "PR - Vivienne Blackwhisper",	-- 41
	Mazdinah	= "R - Maz'dinah",		-- 54
	Thrakgar	= "S - Thrakgar",		--  44
	Broln		= "S - Broln Stouthorn",	-- 55
	Harkzog		= "WL - Harkzog",		-- 50
	Narrhok		= "W - Narrhok Steelbreaker"	-- 53
} 

L:SetOptionLocalization{
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("ValkyrTwins")

L:SetGeneralLocalization{
	name = "Valkyr Twins"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Next Special Ability"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon	= "Special Ability Soon!",
	SpecWarnSpecial		= "Change color!"
}

L:SetMiscLocalization{
	YellPull 	= "In the name of our dark master. For the Lich King. You. Will. Die.",
	Fjola 		= "Fjola Lightbane",
	Eydis		= "Eydis Darkbane"
}

L:SetOptionLocalization{
	TimerSpecialSpell	= "Show a timer for the next special ability",
	WarnSpecialSpellSoon	= "Prewarning for the next Special Ability",
	SpecWarnSpecial		= "Show a special warning when you have to change color"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization{
	name = "Anub'arak"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnBurrow	= "Burrow!",
	WarnPursue	= "Pursuing >%s<",
	SpecWarnPursue	= "Pursuing YOU!"
}

L:SetMiscLocalization{
	YellPull	= "This place will serve as your tomb!"
}

L:SetOptionLocalization{
	WarnBurrow	= "Warning for Submerge",
	WarnPursue	= "Warning who is being followed",
	SpecWarnPursue	= "Special warning if YOU are followed"
}


