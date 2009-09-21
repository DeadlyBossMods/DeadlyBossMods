local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Northrend Beasts"
}

L:SetMiscLocalization{
	Charge			= "^%%s glares at (%S+) and lets out",
	CombatStart		= "Hailing from the deepest, darkest caverns of the Storm Peaks, Gormok the Impaler! Battle on, heroes!",
	Phase3			= "The air itself freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!",
	Gormok			= "Gormok the Impaler",
	Acidmaw			= "Acidmaw",
	Dreadscale		= "Dreadscale",
	Icehowl			= "Icehowl"
}

L:SetOptionLocalization{
	WarningImpale				= "Show warning for Impale",
	WarningFireBomb				= "Show warning for Fire Bomb",
	WarningBreath				= "Show warning for Arctic Breath",
--	WarningSpray				= "Show warning for Paralytic Spray",
	WarningRage					= "Show warning for Frothing Rages",
	WarningCharge				= "Show warning for Charge Target",
	WarningToxin				= "Show warning for Toxin Targets",
	WarningBile					= "Show warning for Burning Bile Targets",
	SpecialWarningImpale3		= "Show special warning for Impale (>=3 Stacks)",
	SpecialWarningFireBomb		= "Show special warning for Fire Bomb on You",
	SpecialWarningSlimePool		= "Show special warning for Slime Pool",
	SpecialWarningSilence		= "Show special warning for Spell Block",
	SpecialWarningSpray			= "Show special warning if you have Paralytic Spray",
	SpecialWarningToxin			= "Show special warning if you have Paralytic Toxin",
	SpecialWarningBile			= "Show special warning if you have Burning Bile",
	SpecialWarningCharge		= "Show special warning when Icehowl is about to charge You",
	PingCharge					= "Ping the minimap when Icehowl is about to charge You",
	SpecialWarningChargeNear	= "Show special warning when Icehowl charges near You",
	SetIconOnChargeTarget		= "Set Icon on Charge Target (skull)",
	SetIconOnBileTarget			= "Set Icon on Burning Bile Targets",
	ClearIconsOnIceHowl			= "Clear all Icons before Charge",
	TimerNextBoss				= "Show timer for next boss spawn"
}

L:SetTimerLocalization{
	TimerNextBoss				= "Next boss in"
}

L:SetWarningLocalization{
	WarningImpale				= "%s on >%s<",
	WarningFireBomb				= "Fire Bomb",
--	WarningSpray				= "%s on >%s<",
	WarningBreath				= "Arctic Breath",
	WarningRage					= "Frothing Rages",
	WarningCharge				= "Charge on >%s<",
	WarningToxin				= "Toxin on >%s<",
	WarningBile					= "Burning Bile on >%s<",
	SpecialWarningImpale3		= "Impale >%d< on You",
	SpecialWarningFireBomb		= "Fire Bomb on You",
	SpecialWarningSlimePool		= "Slime Pool, Move out!",
	SpecialWarningSilence		= "Spell Block in ~1.5 Seconds!",
	SpecialWarningSpray			= "Paralytic Spray on You",
	SpecialWarningToxin			= "Toxin on You! Move!",
	SpecialWarningCharge		= "Charge on You! Run!",
	SpecialWarningChargeNear	= "Charge near You! Run!",
	SpecialWarningBile			= "Bile on You!"
}



-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetWarningLocalization{
	WarnFlame				= "Legion Flame on >%s<",
	WarnTouch				= "Touch of Jaraxxus on >%s<",
	WarnNetherPower			= "Nether Power on Jaraxxus! Dispel Now!",
	WarnPortalSoon			= "Nether Portal Soon!",
	WarnVolcanoSoon			= "Infernal Volcano Soon!",
	SpecWarnFlesh			= "Incinerate Flesh on YOU!",
	SpecWarnTouch			= "Touch of Jaraxxus on YOU!",
	SpecWarnKiss			= "Mistress' Kiss",
	SpecWarnTouchNear		= "Touch of Jaraxxus on >%s< near you",
	SpecWarnFlame			= "Legion Flame! Run!",
	SpecWarnNetherPower		= "Dispel Now!",
	SpecWarnFelInferno		= "Fel Inferno! Run Away!"
}

L:SetMiscLocalization{
	WhisperFlame			= "Legion Flame on YOU!",
}

L:SetOptionLocalization{
	WarnFlame				= "Warns for Legion Flame",
	WarnTouch				= "Show warning for Touch of Jaraxxus",
	WarnNetherPower			= "Warn when Jaraxxus gains Nether Power (for dispel/steal)",
	WarnPortalSoon			= "Prewarn Nether Portal spawning",
	WarnVolcanoSoon			= "Prewarn Infernal Volcano spawning",
	SpecWarnFlame			= "Special warning when you have Legion Flame",
	SpecWarnFlesh			= "Special warning when you have Incinerate Flesh",
	SpecWarnTouch			= "Special warning for Touch of Jaraxxus on you",
	SpecWarnTouchNear		= "Special warning for Touch of Jaraxxus near you",
	SpecWarnKiss			= "Special warning for Mistress' Kiss on you",
	SpecWarnNetherPower		= "Special warning for Nether Power (to dispel Jaraxxus)",
	SpecWarnFelInferno		= "Special warning when you are to near to an Fel Inferno",
	TouchJaraxxusIcon		= "Set Icon on Touch of Jaraxxus target (cross)",
	IncinerateFleshIcon		= "Set Icon on Incinerate Flesh target (skull)",
	LegionFlameIcon			= "Set Icon on Legion Flame target (square)",
	LegionFlameWhisper		= "Send Whisper to Legion Flame target"
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Faction Champions"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	WarnHellfire		= "Hellfire",
	SpecWarnHellfire	= "Hellfire! Move Away!"
}

L:SetMiscLocalization{
	Gorgrim		= "DK - Gorgrim Shadowcleave",		-- 34458
	Birana 		= "D - Birana Stormhoof",			-- 34451
	Erin		= "D - Erin Misthoof",				-- 34459
	Rujkah		= "H - Ruj'kah",					-- 34448
	Ginselle	= "M - Ginselle Blightslinger",		-- 34449
	Liandra		= "P - Liandra Suncaller",			-- 34445
	Malithas	= "P - Malithas Brightblade",		-- 34456
	Caiphus		= "PR - Caiphus the Stern",			-- 34447
	Vivienne	= "PR - Vivienne Blackwhisper",		-- 34441
	Mazdinah	= "R - Maz'dinah",					-- 34454
	Thrakgar	= "S - Thrakgar",					-- 34444
	Broln		= "S - Broln Stouthorn",			-- 34455
	Harkzog		= "WL - Harkzog",					-- 34450
	Narrhok		= "W - Narrhok Steelbreaker",		-- 34453
	YellKill	= "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."
} 

L:SetOptionLocalization{
	WarnHellfire			= "Warn when Harzog casts Hellfire",
	SpecWarnHellfire		= "Special Warning when you take damage from Hellfire"
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Valkyr Twins"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Next Special Ability"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Special Ability Soon!",
	SpecWarnSpecial				= "Change color!",
	SpecWarnEmpoweredDarkness	= "Empowered Darkness",
	SpecWarnEmpoweredLight		= "Empowered Light",
	SpecWarnSwitchTarget		= "Switch Target!",
	SpecWarnKickNow				= "Kick Now!"
}

L:SetMiscLocalization{
	YellPull 	= "In the name of our dark master. For the Lich King. You. Will. Die.",
	Fjola 		= "Fjola Lightbane",
	Eydis		= "Eydis Darkbane"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Show a timer for the next special ability",
	WarnSpecialSpellSoon		= "Prewarning for the next Special Ability",
	SpecWarnSpecial				= "Show a special warning when you have to change color",
	SpecWarnEmpoweredDarkness	= "Show Special Warning for Empowered Darkness",
	SpecWarnEmpoweredLight		= "Show Special Warning for Empowered Light",
	SpecWarnSwitchTarget		= "Show Special Warning when the other Boss is Casting",
	SpecWarnKickNow				= "Show Special Warning when you have to do a Counterspell"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge			= "Emerge in",
	TimerSubmerge		= "Submerge in"
}

L:SetWarningLocalization{
	WarnEmerge			= "Anub'arak emerged",
	WarnEmergeSoon		= "Emerge in 10 sec",
	WarnSubmerge		= "Anub'arak submerged",
	WarnSubmergeSoon	= "Submerge in 10 sec",
	WarnPursue			= "Pursuing >%s<",
	SpecWarnPursue		= "Pursuing you!"
}

L:SetMiscLocalization{
	YellPull			= "This place will serve as your tomb!",
	Swarm				= "The swarm shall overtake you!",
	Emerge				= "%s emerges from the ground!",
	Burrow				= "%s burrows into the ground!"
}

L:SetOptionLocalization{
	WarnEmerge			= "Show warning for Emerge",
	WarnEmergeSoon		= "Show pre-warning for Emerge",
	WarnSubmerge		= "Show warning for Submerge",
	WarnSubmergeSoon	= "Show pre-warning for Submerge",
	SpecWarnPursue		= "Special warning when you are being followed",
	TimerEmerge			= "Show timer for Emerge",
	TimerSubmerge		= "Show timer for Submerge",
	PlaySoundOnPursue	= "Play sound when you are being followed",
	PursueIcon			= "Set icon on pursued player",
	WarnPursue			= "Announce pursued player"
}
