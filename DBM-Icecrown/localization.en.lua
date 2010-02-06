local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Lower Spire trash"
}

L:SetWarningLocalization{
	specWarnTrap		= "Trap Activated! - Deathbound Ward released"--creatureid 37007
}

L:SetOptionLocalization{
	specWarnTrap		= "Show special warning for trap activation",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "Who... goes there...?",
	WarderTrap2		= "I... awaken!",
	WarderTrap3		= "The master's sanctum has been disturbed!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Precious & Stinky"
}

L:SetWarningLocalization{
	warnMortalWound	= "%s on >%s< (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	specWarnTrap	= "Trap Activated! - Vengeful Fleshreapers incoming"--creatureid 37038
}

L:SetOptionLocalization{
	specWarnTrap	= "Show special warning for trap activation",
	warnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Quickly! We'll ambush them from behind!",
	FleshreaperTrap2		= "You... cannot escape us!",
	FleshreaperTrap3		= "The living... here?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Crimson Hall Trash"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Marrowgar"
}

L:SetTimerLocalization{
	achievementBoned	= "Time to free"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< is impaled"
}

L:SetOptionLocalization{
	WarnImpale			= "Announce $spell:69062 targets",
	achievementBoned	= "Show timer for Boned achievement",
	SetIconOnImpale		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Deathwhisper"
}

L:SetTimerLocalization{
	TimerAdds	= "New Adds"
}

L:SetWarningLocalization{
	WarnReanimating				= "Add reviving",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s on >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon				= "New adds soon",
	specWarnVengefulShade		= "Vengeful Shade attacking you - Run Away"--creatureid 38222
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Show pre-warning for adds spawning",
	WarnReanimating				= "Show warning when an add is being revived",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Show timer for new adds",
	specWarnVengefulShade		= "Show special warning when you are attacked by Vengeful Shade",--creatureid 38222
	ShieldHealthFrame			= "Show boss health with a health bar for $spell:70842",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull				= "What is this disturbance? You dare trespass upon this hallowed ground? This shall be your final resting place!",
	YellReanimatedFanatic	= "Arise, and exult in your pure form!",
	ShieldPercent			= "Mana Barrier",--Translate Spell id 70842
	Fanatic1				= "Cult Fanatic",
	Fanatic2				= "Deformed Fanatic",
	Fanatic3				= "Reanimated Fanatic"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Gunship Battle"
}

L:SetWarningLocalization{
	WarnBattleFury	= "%s (%d)",
	WarnAddsSoon	= "New adds soon"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Show time for start of combat",
	WarnAddsSoon		= "Show pre-warning for adds spawning",
	TimerAdds			= "Show timer for new adds"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts",
	TimerAdds			= "New adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Fire up the engines! We got a meetin' with destiny, lads!",
	KillAlliance	= "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!",
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy! LOK'TAR OGAR!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Deathbringer Saurfang"
}

L:SetWarningLocalization{
	warnFrenzySoon	= "Frenzy soon"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Combat starts"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Show time for start of combat",
	warnFrenzySoon			= "Show pre-warning for Frenzy (at ~33%)",
	SetIconOnBoilingBlood	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	SetIconOnMarkCast		= "Set icon on $spell:72444 targets during cast\n(Experimental, may mark tank incorrectly)",
	RangeFrame				= "Show range frame (12 yards)",
	RunePowerFrame			= "Show Boss Health + $spell:72371 bar"
}

L:SetMiscLocalization{
	RunePower			= "Blood Power",
	PullAlliance		= "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs! The Scourge have been..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Festergut"
}

L:SetWarningLocalization{
	InhaledBlight		= "Inhaled Blight >%d<",
	WarnGastricBloat	= "%s on >%s< (%s)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight		= "Show warning for $spell:71912",
	RangeFrame			= "Show range frame (8 yards)",
	WarnGastricBloat	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),	
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Rotface"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Little Ooze spawning",
	WarnUnstableOoze			= "%s on >%s< (%s)",			-- Unstable Ooze on >args.destName< (args.amount)
	specWarnLittleOoze			= "Little Ooze attacking you - Run Away"--creatureid 36897
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning",
	specWarnLittleOoze			= "Show special warning when you are attacked by Little Ooze",--creatureid 36897
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	ExplosionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69839)
}

L:SetMiscLocalization{
	YellSlimePipes1	= "Good news, everyone! I've fixed the poison slime pipes!",	-- Professor Putricide
	YellSlimePipes2	= "Great news, everyone! The slime is flowing again!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Putricide"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "Phase 2 soon",
	WarnPhase3Soon				= "Phase 3 soon",
	WarnMutatedPlague			= "%s on >%s< (%s)",	-- Mutated Plague on >args.destName< (args.amount)
	specWarnMalleableGoo		= "Malleable Goo on you - Move away",
	specWarnMalleableGooNear	= "Malleable Goo near you - Watch out"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "Show pre-warning for Phase 2 (at ~83%)",
	WarnPhase3Soon				= "Show pre-warning for Phase 3 (at ~38%)",
	specWarnMalleableGoo		= "Show special warning for Malleable Goo on you\n(Only works if you are first target)",
	specWarnMalleableGooNear	= "Show special warning for Malleable Goo near you\n(Only works if you are near first target)",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	MalleableGooIcon			= "Set icon on first $spell:72295 target"
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
	WarnTargetSwitch		= "Switch target to: %s",
	WarnTargetSwitchSoon	= "Target switch soon"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Show warning to switch targets",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Set icon on the empowered Prince (skull)"
}

L:SetMiscLocalization{
	Keleseth			= "Prince Keleseth",
	Taldaram			= "Prince Taldaram",
	Valanar				= "Prince Valanar",
	EmpoweredFlames		= "Inferno Flames speed toward (%S+)!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Blood-Queen Lana'thel"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkFallen			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838)
}

L:SetMiscLocalization{
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Dreamwalker"
}

L:SetWarningLocalization{
	warnCorrosion	= "%s on >%s< (%s)"		-- Corrosion on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	warnCorrosion	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull		= "Intruders have breached the inner sanctum. Hasten the destruction of the green dragon! Leave only bones and sinew for the reanimation!",
	YellKill		= "I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!",
	YellPortals		= "I have opened a portal into the Dream. Your salvation lies within, heroes...",
	YellPhase2		= "My strength is returning. Press on, heroes!"--Need to confirm this is when adds spawn faster (phase 2) before used in mod
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
	warnPhase2soon			= "Phase 2 soon",
	WarnAirphase			= "Air phase",
	WarnGroundphaseSoon		= "Sindragosa landing soon",
	warnInstability			= "Instability >%d<",
	warnChilledtotheBone	= "Chilled to the Bone >%d<",
	warnMysticBuffet		= "Mystic Buffet >%d<"
}

L:SetOptionLocalization{
	WarnAirphase			= "Announce air phase",
	WarnGroundphaseSoon		= "Show pre-warning for ground phase",
	warnPhase2soon			= "Show pre-warning for Phase 2 (at ~33%)",
	TimerNextAirphase		= "Show timer for next air phase",
	TimerNextGroundphase	= "Show timer for next ground phase",
	warnInstability			= "Show warning for your $spell:69766 stacks",
	warnChilledtotheBone	= "Show warning for your $spell:70106 stacks",
	warnMysticBuffet		= "Show warning for your $spell:70128 stacks",
	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126)
}

L:SetMiscLocalization{
	YellAirphase	= "Your incursion ends here! None shall survive!",
	YellPhase2		= "Now, feel my master's limitless power and despair!",
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
	WarnPhase2Soon			= "Phase 2 transition soon",
	WarnPhase3Soon			= "Phase 3 transition soon",
	specWarnDefileCast		= "Defile on you - Move away",
	specWarnDefileCastNear	= "Defile near you - Watch out"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Show time for start of combat",
	WarnPhase2Soon			= "Show pre-warning for Phase 2 transition (at ~73%)",
	WarnPhase3Soon			= "Show pre-warning for Phase 3 transition (at ~43%)",
	specWarnDefileCast		= "Show special warning for $spell:72762 on you",
	specWarnDefileCastNear	= "Show special warning for $spell:72762 near you",
	DefileIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73779),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912)
}

L:SetMiscLocalization{
	YellPull		= "So the Light's vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?"
}