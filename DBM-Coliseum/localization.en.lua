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
	Phase2			= "Steel yourselves, heroes, for the twin terrors, Acidmaw and Dreadscale, enter the arena!",
	Phase3			= "The air itself freezes with the introduction of our next combatant, Icehowl! Kill or be killed, champions!",
	Gormok			= "Gormok the Impaler",
	Acidmaw			= "Acidmaw",
	Dreadscale		= "Dreadscale",
	Icehowl			= "Icehowl"
}

L:SetOptionLocalization{
	WarningSnobold				= "Show warning for Snobold Vassal spawns",
	SpecialWarningImpale3		= "Show special warning for Impale (>=3 stacks)",
	SpecialWarningAnger3		= "Show special warning for Rising Anger (>=3 stacks)",
	SpecialWarningFireBomb		= "Show special warning for Fire Bomb on you",
	SpecialWarningSlimePool		= "Show special warning when you are affected by Slime Pool",
	SpecialWarningSilence		= "Show special warning for Staggering Stomp (silence)",
	SpecialWarningToxin			= "Show special warning when you are affected by Paralytic Toxin",
	SpecialWarningBile			= "Show special warning when you are affected by Burning Bile",
	SpecialWarningCharge		= "Show special warning when Icehowl is about to charge you",
	SpecialWarningTranq			= "Show special warning when Icehowl gains Frothing Rage (to tranq)",
	PingCharge					= "Ping the minimap when Icehowl is about to charge you",
	SpecialWarningChargeNear	= "Show special warning when Icehowl is about to charge near you",
	SetIconOnChargeTarget		= "Set icons on charge targets (skull)",
	SetIconOnBileTarget			= "Set icons on Burning Bile targets",
	ClearIconsOnIceHowl			= "Clear all icons before charge",
	TimerNextBoss				= "Show timer for next boss spawn",
	TimerCombatStart			= "Show timer for start of combat",
	TimerEmerge					= "Show timer for emerge",
	TimerSubmerge				= "Show timer for submerge",
	RangeFrame                  = "Show range frame in Phase 2"
}

L:SetTimerLocalization{
	TimerNextBoss				= "Next boss",
	TimerCombatStart			= "Combat starts",
	TimerEmerge					= "Emerge",
	TimerSubmerge				= "Submerge"
}

L:SetWarningLocalization{
	WarningSnobold				= "Snobold Vassal spawned",
	SpecialWarningImpale3		= "Impale >%d< on you",
	SpecialWarningAnger3		= "Rising Anger >%d<",
	SpecialWarningFireBomb		= "Fire Bomb on you",
	SpecialWarningSlimePool		= "Slime Pool - Move away",
	SpecialWarningSilence		= "Silence in ~1.5 seconds",
	SpecialWarningToxin			= "Paralytic Toxin on you - Move",
	SpecialWarningCharge		= "Charge on you - Run away",
	SpecialWarningChargeNear	= "Charge near you - Run away",
	SpecialWarningBile			= "Burning Bile on you",
	SpecialWarningTranq			= "Frothing Rage - Tranq now"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetWarningLocalization{
	WarnNetherPower				= "Nether Power on Lord Jaraxxus - Dispel now",
	SpecWarnFlesh				= "Incinerate Flesh on you",
	SpecWarnTouch				= "Touch of Jaraxxus on you",
	SpecWarnKiss				= "Mistress' Kiss on you",
	SpecWarnTouchNear			= "Touch of Jaraxxus on %s near you",
	SpecWarnFlame				= "Legion Flame on you - Run away",
	SpecWarnNetherPower			= "Dispel now",
	SpecWarnFelInferno			= "Fel Inferno - Run away",
	SpecWarnFelFireball			= "Fel Fireball - Interrupt now",
	SpecWarnFelFireballDispel	= "Fel Fireball on %s - Dispel"
}

L:SetMiscLocalization{
	WhisperFlame				= "Legion Flame on you",
	IncinerateTarget			= "Incinerate Flesh: %s"
}

L:SetOptionLocalization{
	WarnNetherPower				= "Show warning when Lord Jaraxxus gains Nether Power (to dispel/steal)",
	SpecWarnFlame				= "Show special warning when you are affected by Legion Flame",
	SpecWarnFlesh				= "Show special warning when you are affected by Incinerate Flesh",
	SpecWarnTouch				= "Show special warning when you are affected by Touch of Jaraxxus",
	SpecWarnTouchNear			= "Show special warning for Touch of Jaraxxus near you",
	SpecWarnKiss				= "Show special warning when you are affected by Mistress' Kiss",
	SpecWarnNetherPower			= "Show special warning for Nether Power (to dispel/steal)",
	SpecWarnFelInferno			= "Show special warning when you are near a Fel Inferno",
	SpecWarnFelFireball			= "Show special warning for Fel Fireball (to interrupt)",
	SpecWarnFelFireballDispel	= "Show special warning for Fel Fireball (to dispel)",
	TouchJaraxxusIcon			= "Set icons on Touch of Jaraxxus targets (cross)",
	IncinerateFleshIcon			= "Set icons on Incinerate Flesh targets (skull)",
	LegionFlameIcon				= "Set icons on Legion Flame targets (square)",
	LegionFlameWhisper			= "Send whisper to Legion Flame targets",
	LegionFlameRunSound			= "Play sound on Legion Flame",
	IncinerateShieldFrame		= "Show boss health with a health bar for Incinerate Flesh"
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Faction Champions"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecWarnHellfire		= "Hellfire - Run away",
	SpecWarnHandofProt		= "Hand of Protection on %s",
	SpecWarnDivineShield	= "Divine Shield on %s",
	specWarnIceBlock       	= "Ice Block on %s"
}

L:SetMiscLocalization{
	Gorgrim            = "DK - Gorgrim Shadowcleave",		-- 34458
	Birana             = "D - Birana Stormhoof",			-- 34451
	Erin               = "D - Erin Misthoof",				-- 34459
	Rujkah             = "H - Ruj'kah",						-- 34448
	Ginselle           = "M - Ginselle Blightslinger",		-- 34449
	Liandra            = "P - Liandra Suncaller",			-- 34445
	Malithas           = "P - Malithas Brightblade",		-- 34456
	Caiphus            = "PR - Caiphus the Stern",			-- 34447
	Vivienne           = "PR - Vivienne Blackwhisper",		-- 34441
	Mazdinah           = "R - Maz'dinah",					-- 34454
	Thrakgar           = "S - Thrakgar",					-- 34444
	Broln              = "S - Broln Stouthorn",				-- 34455
	Harkzog            = "WL - Harkzog",					-- 34450
	Narrhok            = "W - Narrhok Steelbreaker",		-- 34453
	AllianceVictory    = "Glory to the Alliance!",
	HordeVictory       = "That was just a taste of what the future brings. FOR THE HORDE!",
	YellKill           = "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."
} 

L:SetOptionLocalization{
	SpecWarnHellfire		= "Show special warning when you are affected by Hellfire",
	SpecWarnHandofProt		= "Show special warning when the Paladin casts Hand of Protection (to dispel)",
	SpecWarnDivineShield	= "Show special warning when the Paladin casts Divine Shield (to dispel)",
	specWarnIceBlock       	= "Show special warning when the Mage casts Ice Block (to dispel)"
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Val'kyr Twins"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Next special ability"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Special ability soon",
	SpecWarnSpecial				= "Change color",
	SpecWarnEmpoweredDarkness	= "Empowered Darkness on you",
	SpecWarnEmpoweredLight		= "Empowered Light on you",
	SpecWarnSwitchTarget		= "Switch target",
	SpecWarnKickNow				= "Interrupt now",
	WarningTouchDebuff			= "Debuff on >%s<",
	WarningPoweroftheTwins		= "Power of the Twins - More healing on >%s<",
	SpecWarnPoweroftheTwins		= "Power of the Twins"
}

L:SetMiscLocalization{
	YellPull 	= "In the name of our dark master. For the Lich King. You. Will. Die.",
	Fjola 		= "Fjola Lightbane",
	Eydis		= "Eydis Darkbane"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Show timer for next special ability",
	WarnSpecialSpellSoon		= "Show pre-warning for next special ability",
	SpecWarnSpecial				= "Show special warning when you have to change color",
	SpecWarnEmpoweredDarkness	= "Show special warning you are affected by Empowered Darkness",
	SpecWarnEmpoweredLight		= "Show special warning you are affected by Empowered Light",
	SpecWarnSwitchTarget		= "Show special warning when the other Twin is casting",
	SpecWarnKickNow				= "Show special warning when you have to interrupt",
	SpecialWarnOnDebuff			= "Show special warning when debuffed (to switch debuff)",
	SetIconOnDebuffTarget		= "Set icons on Touch of Light/Darkness debuff targets (heroic)",
	WarningTouchDebuff			= "Announce Touch of Light/Darkness debuff targets",
	WarningPoweroftheTwins		= "Announce Power of the Twins targets",
	SpecWarnPoweroftheTwins		= "Show special warning when you are tanking an empowered Twin"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Emerge",
	TimerSubmerge			= "Submerge",
	timerAdds				= "New adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak emerges",
	WarnEmergeSoon			= "Emerge in 10 seconds",
	WarnSubmerge			= "Anub'arak submerges",
	WarnSubmergeSoon		= "Submerge in 10 seconds",
	SpecWarnPursue			= "You are being pursued - Run away",
	warnAdds				= "New adds",
	SpecWarnShadowStrike	= "Shadow Strike - Interrupt now",
	SpecWarnPCold			= "Penetrating Cold on you"
}

L:SetMiscLocalization{
	YellPull				= "This place will serve as your tomb!",
	Emerge					= "emerges from the ground!",
	Burrow					= "burrows into the ground!",
	PcoldIconSet			= "PCold icon {rt%d} set on %s",
	PcoldIconRemoved		= "PCold icon removed from %s"
}

L:SetOptionLocalization{
	WarnEmerge				= "Show warning for emerge",
	WarnEmergeSoon			= "Show pre-warning for emerge",
	WarnSubmerge			= "Show warning for submerge",
	WarnSubmergeSoon		= "Show pre-warning for submerge",
	SpecWarnPursue			= "Show special warning when you are being pursued",
	warnAdds				= "Announce new adds",
	timerAdds				= "Show timer for new adds",
	TimerEmerge				= "Show timer for emerge",
	TimerSubmerge			= "Show timer for submerge",
	PlaySoundOnPursue		= "Play sound when you are being pursued",
	PursueIcon				= "Set icons on pursued targets",
	SpecWarnShadowStrike	= "Show special warning for Shadow Strike (to interrupt)",
	SpecWarnPCold			= "Show special warning when you are affected by Penetrating Cold",
	RemoveHealthBuffsInP3	= "Remove HP buffs at start of Phase 3", 
	SetIconsOnPCold         = "Set icons on Penetrating Cold targets",
	AnnouncePColdIcons		= "Post icons for Penetrating Cold targets to raid chat\n(requires announce to be enabled and leader/promoted status)"
}

