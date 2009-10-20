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
	WarningRage					= "Show warning for Frothing Rage",
	WarningCharge				= "Show warning for charge target",
	WarningToxin				= "Show warning for Paralytic Toxin targets",
	WarningBile					= "Show warning for Burning Bile targets",
	SpecialWarningImpale3		= "Show special warning for Impale (>=3 stacks)",
	SpecialWarningFireBomb		= "Show special warning for Fire Bomb on you",
	SpecialWarningSlimePool		= "Show special warning for Slime Pool",
	SpecialWarningSilence		= "Show special warning for Spell Block",
	SpecialWarningSpray			= "Show special warning if you have Paralytic Spray",
	SpecialWarningToxin			= "Show special warning if you have Paralytic Toxin",
	SpecialWarningBile			= "Show special warning if you have Burning Bile",
	SpecialWarningCharge		= "Show special warning when Icehowl is about to charge you",
	PingCharge					= "Ping the minimap when Icehowl is about to charge you",
	SpecialWarningChargeNear	= "Show special warning when Icehowl charges near you",
	SetIconOnChargeTarget		= "Set icon on charge target (skull)",
	SetIconOnBileTarget			= "Set icon on Burning Bile targets",
	ClearIconsOnIceHowl			= "Clear all icons before charge",
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
	WarningRage					= "Frothing Rage",
	WarningCharge				= "Charge on >%s<",
	WarningToxin				= "Paralytic Toxin on >%s<",
	WarningBile					= "Burning Bile on >%s<",
	SpecialWarningImpale3		= "Impale >%d< on you",
	SpecialWarningFireBomb		= "Fire Bomb on you",
	SpecialWarningSlimePool		= "Slime Pool - Move out",
	SpecialWarningSilence		= "Spell Block in ~1.5 seconds!",
	SpecialWarningSpray			= "Paralytic Spray on you",
	SpecialWarningToxin			= "Paralytic Toxin on you - Move",
	SpecialWarningCharge		= "Charge on you - Run away",
	SpecialWarningChargeNear	= "Charge near you - Run away",
	SpecialWarningBile			= "Burning Bile on you"
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
	WarnNetherPower			= "Nether Power on Jaraxxus - Dispel now",
	WarnPortalSoon			= "Nether Portal soon",
	WarnVolcanoSoon			= "Infernal Volcano soon",
	SpecWarnFlesh			= "Incinerate Flesh on you",
	SpecWarnTouch			= "Touch of Jaraxxus on you",
	SpecWarnKiss			= "Mistress' Kiss",
	SpecWarnTouchNear		= "Touch of Jaraxxus on >%s< near you",
	SpecWarnFlame			= "Legion Flame - Run away",
	SpecWarnNetherPower		= "Dispel now",
	SpecWarnFelInferno		= "Fel Inferno - Run away"
}

L:SetMiscLocalization{
	WhisperFlame			= "Legion Flame on you",
	IncinerateTarget		= "Incinerate Flesh: %s"
}

L:SetOptionLocalization{
	WarnFlame				= "Show warning for Legion Flame",
	WarnTouch				= "Show warning for Touch of Jaraxxus",
	WarnNetherPower			= "Show warning when Jaraxxus gains Nether Power (to dispel/steal)",
	WarnPortalSoon			= "Show pre-warning for Nether Portal spawn",
	WarnVolcanoSoon			= "Show pre-warning for Infernal Volcano spawn",
	SpecWarnFlame			= "Show special warning when you are affected by Legion Flame",
	SpecWarnFlesh			= "Show special warning when you are affected by Incinerate Flesh",
	SpecWarnTouch			= "Show special warning for Touch of Jaraxxus on you",
	SpecWarnTouchNear		= "Show special warning for Touch of Jaraxxus near you",
	SpecWarnKiss			= "Show special warning for Mistress' Kiss on you",
	SpecWarnNetherPower		= "Show special warning for Nether Power (to dispel/steal)",
	SpecWarnFelInferno		= "Show special warning when you are near a Fel Inferno",
	TouchJaraxxusIcon		= "Set icon on Touch of Jaraxxus target (cross)",
	IncinerateFleshIcon		= "Set icon on Incinerate Flesh target (skull)",
	LegionFlameIcon			= "Set icon on Legion Flame target (square)",
	LegionFlameWhisper		= "Send whisper to Legion Flame target",
	IncinerateShieldFrame	= "Show boss health with a health bar for Incinerate Flesh"
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
	SpecWarnHellfire		= "Hellfire - Run away",
	SpecWarnHandofProt		= "Hand of Protection on >%s<",
	SpecWarnDivineShield	= "Divine Shield on >%s<"
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
	SpecWarnHellfire		= "Show special warning when you take damage from Hellfire",
	SpecWarnHandofProt		= "Show special warning when the Paladin casts Hand of Protection",
	SpecWarnDivineShield	= "Show special warning when the Paladin casts Divine Shield"
}

------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "Valkyr Twins"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Next special ability"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Special ability soon",
	SpecWarnSpecial				= "Change color",
	SpecWarnEmpoweredDarkness	= "Empowered Darkness",
	SpecWarnEmpoweredLight		= "Empowered Light",
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
	SpecWarnEmpoweredDarkness	= "Show special warning for Empowered Darkness",
	SpecWarnEmpoweredLight		= "Show special warning for Empowered Light",
	SpecWarnSwitchTarget		= "Show special warning when the other Twin is casting",
	SpecWarnKickNow				= "Show special warning when you have to interrupt",
	SpecialWarnOnDebuff			= "Show special warning when debuffed (to switch debuff)",
	SetIconOnDebuffTarget		= "Set icon on Touch of Light/Darkness debuff targets (Heroic)",
	WarningTouchDebuff			= "Announce Touch of Light/Darkness debuff targets",
	WarningPoweroftheTwins		= "Announce current target for Power of the Twins",
	SpecWarnPoweroftheTwins		= "Show special warning when you are tanking an empowered Twin"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Emerge in",
	TimerSubmerge			= "Submerge in",
	timerAdds				= "New adds in"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak emerges",
	WarnEmergeSoon			= "Emerge in 10 seconds",
	WarnSubmerge			= "Anub'arak submerges",
	WarnSubmergeSoon		= "Submerge in 10 seconds",
	WarnPursue				= "Pursuing >%s<",
	SpecWarnPursue			= "Pursuing you",
	warnAdds				= "Adds incoming",
	SpecWarnShadowStrike	= "Shadow Strike - Interrupt now",
	SpecWarnPCold			= "Penetrating Cold"
}

L:SetMiscLocalization{
	YellPull				= "This place will serve as your tomb!",
	Emerge					= "emerges from the ground!",
	Burrow					= "burrows into the ground!"
}

L:SetOptionLocalization{
	WarnEmerge				= "Show warning for emerge",
	WarnEmergeSoon			= "Show pre-warning for emerge",
	WarnSubmerge			= "Show warning for submerge",
	WarnSubmergeSoon		= "Show pre-warning for submerge",
	SpecWarnPursue			= "Show special warning when you are being pursued",
	warnAdds				= "Show warning for new incoming adds",
	timerAdds				= "Show timer for new incoming adds",
	TimerEmerge				= "Show timer for emerge",
	TimerSubmerge			= "Show timer for submerge",
	PlaySoundOnPursue		= "Play sound when you are being pursued",
	PursueIcon				= "Set icon on pursued player",
	WarnPursue				= "Announce pursued player",
	SpecWarnShadowStrike	= "Show special warning for Shadow Strike (to interrupt)",
	SpecWarnPCold			= "Show special warning for Penetrating Cold",
	RemoveHealthBuffsInP3	= "Remove HP buffs at start of Phase 3", 
	SetIconsOnPCold         = "Set icons on Penetrating Cold targets"
}

