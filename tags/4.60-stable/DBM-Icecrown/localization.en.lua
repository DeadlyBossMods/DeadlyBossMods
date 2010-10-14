local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Lower Spire trash"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "Trap Activated! - Deathbound Ward released"--creatureid 37007
}

L:SetOptionLocalization{
	SpecWarnTrap		= "Show special warning for trap activation",
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
	name = "Plagueworks Trash"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s on >%s< (%d)",		-- Mortal Wound on >args.destName< (args.amount)
	SpecWarnTrap	= "Trap Activated! - Vengeful Fleshreapers incoming"--creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap	= "Show special warning for trap activation",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
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

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "Frostwing Hall Trash"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "Sindragosa gauntlet started!"
}

L:SetTimerLocalization{
	GosaTimer			= "Time remaining"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "Show special warning for Sindragosa gauntlet event",
	GosaTimer			= "Show timer for Sindragosa gauntlet event duration"
}

L:SetMiscLocalization{
	SindragosaEvent		= "You must not approach the Frost Queen. Quickly, stop them!"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Marrowgar"
}

L:SetTimerLocalization{
	AchievementBoned	= "Time to free"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< is impaled"
}

L:SetOptionLocalization{
	WarnImpale			= "Announce $spell:69062 targets",
	AchievementBoned	= "Show timer for Boned achievement",
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
	WarnTouchInsignificance		= "%s on >%s< (%d)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon				= "New adds soon",
	SpecWarnVengefulShade		= "Vengeful Shade attacking you - Run Away"--creatureid 38222
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Show pre-warning for adds spawning",
	WarnReanimating				= "Show warning when an add is being revived",	-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Show timer for new adds",
	SpecWarnVengefulShade		= "Show special warning when you are attacked by Vengeful Shade",--creatureid 38222
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
	PullHorde		= "Rise up, sons and daughters of the Horde! Today we battle a hated enemy of the Horde! LOK'TAR OGAR!",
	KillHorde		= "The Alliance falter. Onward to the Lich King!",
	AddsAlliance	= "Reavers, Sergeants, attack",
	AddsHorde		= "Marines, Sergeants, attack",
	MageAlliance	= "We're taking hull damage, get a battle-mage out here to shut down those cannons!",
	MageHorde		= "We're taking hull damage, get a sorcerer out here to shut down those cannons!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Deathbringer Saurfang"
}

L:SetWarningLocalization{
	WarnFrenzySoon	= "Frenzy soon"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Combat starts"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Show time for start of combat",
	WarnFrenzySoon			= "Show pre-warning for Frenzy (at ~33%)",
	BoilingBloodIcons	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame				= "Show range frame (12 yards)",
	RunePowerFrame			= "Show Boss Health + $spell:72371 bar",
	BeastIcons				= "Set icons on Blood Beasts"
}

L:SetMiscLocalization{
	RunePower			= "Blood Power",
	PullAlliance		= "For every Horde soldier that you killed -- for every Alliance dog that fell, the Lich King's armies grew. Even now the val'kyr work to raise your fallen as Scourge.",
	PullHorde			= "Kor'kron, move out! Champions, watch your backs. The Scourge have been..."
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
	WarnGastricBloat	= "%s on >%s< (%d)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight		= "Show warning for $spell:71912",
	RangeFrame			= "Show range frame (8 yards)",
	WarnGastricBloat	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),	
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons	= "Announce icons for $spell:69279 targets to raid chat\n(requires announce to be enabled and promoted status)",
	AchievementCheck	= "Announce 'Flu Shot Shortage' achievement failure to raid\n(requires promoted status)"
}

L:SetMiscLocalization{
	SporeSet	= "Gas Spore icon {rt%d} set on %s",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Inoculated <<"
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
	WarnUnstableOoze			= "%s on >%s< (%d)",			-- Unstable Ooze on >args.destName< (args.amount)
	SpecWarnLittleOoze			= "Little Ooze attacking you - Run Away"--creatureid 36897
}

L:SetTimerLocalization{
	NextPoisonSlimePipes		= "Next Poison Slime Pipes"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Show timer for next Poison Slime Pipes",
	WarnOozeSpawn				= "Show warning for Little Ooze spawning",
	SpecWarnLittleOoze			= "Show special warning when you are attacked by Little Ooze",--creatureid 36897
	RangeFrame					= "Show range frame (8 yards)",
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	TankArrow					= "Show DBM arrow for Big Ooze kiter (Experimental)"
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
	WarnMutatedPlague			= "%s on >%s< (%d)",	-- Mutated Plague on >args.destName< (args.amount)
	SpecWarnMalleableGoo		= "Malleable Goo on you - Move away",
	SpecWarnMalleableGooNear	= "Malleable Goo near you - Watch out",
	SpecWarnUnboundPlague		= "Drop off the Unbound Plague",
	SpecWarnNextPlageSelf		= "Unbound Plage to you next, get prepared!"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "Show pre-warning for Phase 2 (at ~83%)",
	WarnPhase3Soon				= "Show pre-warning for Phase 3 (at ~38%)",
	SpecWarnMalleableGoo		= "Show special warning if you are first $spell:72295 target",
	SpecWarnMalleableGooNear	= "Show special warning if you are near first $spell:72295 target",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Set icon on first $spell:72295 target",
	NextUnboundPlagueTargetIcon	= "Set icon on next $spell:72856 target",
	YellOnMalleableGoo			= "Yell on $spell:72295",
	YellOnUnbound				= "Yell on $spell:72856",
	GooArrow					= "Show DBM arrow when $spell:72295 is near you",
	SpecWarnUnboundPlague		= "Show special warning for $spell:72856 transfer",
	SpecWarnNextPlageSelf		= "Show special warning when you are the next $spell:72856 target",
	BypassLatencyCheck			= "Don't use latency based sync check for $spell:72295\n(only use this if you're having problems otherwise)"
}

L:SetMiscLocalization{
	YellPull		= "Good news, everyone! I think I've perfected a plague that will destroy all life on Azeroth!",
	YellMalleable	= "Malleable Goo on me!",
	YellUnbound		= "Unbound Plague on me!"
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
	WarnTargetSwitchSoon	= "Target switch soon",
	SpecWarnVortex			= "Shock Vortex on you - Move away",
	SpecWarnVortexNear		= "Shock Vortex near you - Watch out"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Target switch"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Show warning to switch targets",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Show pre-warning to switch targets",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Show timer for target switch cooldown",
	SpecWarnVortex			= "Show special warning for $spell:72037 on you",
	SpecWarnVortexNear		= "Show special warning for $spell:72037 near you",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Set icon on the empowered Prince (skull)",
	RangeFrame				= "Show range frame (12 yards)",
	VortexArrow				= "Show DBM arrow when $spell:72037 is near you",
	BypassLatencyCheck		= "Don't use latency based sync check for $spell:72037\n(only use this if you're having problems otherwise)"
}

L:SetMiscLocalization{
	Keleseth			= "Prince Keleseth",
	Taldaram			= "Prince Taldaram",
	Valanar				= "Prince Valanar",
	EmpoweredFlames		= "Empowered Flames speed toward (%S+)!"
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
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "Show range frame (8 yards)",
	YellOnFrenzy			= "Yell on $spell:71474"
}

L:SetMiscLocalization{
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!",
	YellFrenzy				= "I'm hungry!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Dreamwalker"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s on >%s< (%d)",		-- Corrosion on >args.destName< (args.amount)
	WarnPortalOpen	= "Portals open"
}

L:SetTimerLocalization{
	TimerPortalsOpen		= "Portals open",
	TimerBlazingSkeleton	= "Next Blazing Skeleton",
	TimerAbom				= "Next Abomination"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton	= "Set icon on Blazing Skeleton (skull)",
	WarnPortalOpen				= "Show warning when Nightmare Portals are opened up",
	TimerPortalsOpen			= "Show timer when Nightmare Portals are opened up",
	TimerBlazingSkeleton		= "Show timer for next Blazing Skeleton spawn",
	TimerAbom					= "Show timer for next Gluttonous Abomination spawn (Experimental)",
	WarnCorrosion				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
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
	TimerNextGroundphase	= "Next ground phase",
	AchievementMystic		= "Time to clear Mystic stacks"
}

L:SetWarningLocalization{
	WarnPhase2soon			= "Phase 2 soon",
	WarnAirphase			= "Air phase",
	WarnGroundphaseSoon		= "Sindragosa landing soon",
	WarnInstability			= "Instability >%d<",
	WarnChilledtotheBone	= "Chilled to the Bone >%d<",
	WarnMysticBuffet		= "Mystic Buffet >%d<"
}

L:SetOptionLocalization{
	WarnAirphase			= "Announce air phase",
	WarnGroundphaseSoon		= "Show pre-warning for ground phase",
	WarnPhase2soon			= "Show pre-warning for Phase 2 (at ~38%)",
	TimerNextAirphase		= "Show timer for next air phase",
	TimerNextGroundphase	= "Show timer for next ground phase",
	WarnInstability			= "Show warning for your $spell:69766 stacks",
	WarnChilledtotheBone	= "Show warning for your $spell:70106 stacks",
	WarnMysticBuffet		= "Show warning for your $spell:70128 stacks",
	AnnounceFrostBeaconIcons= "Announce icons for $spell:70126 targets to raid chat\n(requires announce to be enabled and promoted status)",
	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase	= "Clear all icons before air phase",
	AchievementCheck		= "Announce 'All You Can Eat' achievement warnings to raid\n(requires promoted status)",
	RangeFrame				= "Show raid icon based range frame (10 normal, 20 heroic)"
}

L:SetMiscLocalization{
	YellAirphase		= "Your incursion ends here! None shall survive!",
	YellPhase2			= "Now, feel my master's limitless power and despair!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet		= "Frost Beacon icon {rt%d} set on %s",
	AchievementWarning	= "Warning: %s has 5 stacks of Mystic Buffet",
	AchievementFailed	= ">> ACHIEVEMENT FAILED: %s has %d stacks of Mystic Buffet <<",
	YellPull			= "You are fools to have come to this place. The icy winds of Northrend will consume your souls!"--Not currently in use.
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
	ValkyrWarning			= ">%s< has been grabbed!",
	SpecWarnYouAreValkd		= "You have been grabbed",
	SpecWarnDefileCast		= "Defile on you - Move away",
	SpecWarnDefileNear		= "Defile near you - Watch out",
	SpecWarnTrapNear		= "Shadow Trap near you - Watch out",
	WarnNecroticPlagueJump	= "Necrotic Plague jumped to >%s<",
	SpecWarnPALGrabbed		= "Paladin Healer %s has been grabbed",
	SpecWarnPRIGrabbed		= "Priest Healer %s has been grabbed",
	SpecWarnValkyrLow		= "Valkyr below 55%"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Combat starts",
	TimerRoleplay		= "Roleplay",
	PhaseTransition		= "Phase transition",
	TimerNecroticPlagueCleanse = "Cleanse Necrotic Plague"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Show timer for start of combat",
	TimerRoleplay			= "Show timer for roleplay event",
	WarnNecroticPlagueJump	= "Announce $spell:73912 jump targets",
	TimerNecroticPlagueCleanse	= "Show timer to cleanse Necrotic Plague before\nthe first tick",
	PhaseTransition			= "Show time for phase transitions",
	WarnPhase2Soon			= "Show pre-warning for Phase 2 transition (at ~73%)",
	WarnPhase3Soon			= "Show pre-warning for Phase 3 transition (at ~43%)",
	ValkyrWarning			= "Announce who has been grabbed by Val'kyr Shadowguards",
	SpecWarnYouAreValkd		= "Show special warning when you have been grabbed by a Val'kyr Shadowguard",--npc36609
	SpecWarnHealerGrabbed	= "Show special warning when a paladin or priest healer has been grabbed\n(requires that healer to be running DBM)",
	SpecWarnDefileCast		= "Show special warning for $spell:72762 on you",
	SpecWarnDefileNear		= "Show special warning for $spell:72762 near you",
	SpecWarnTrapNear		= "Show special warning for $spell:73539 near you",
	YellOnDefile			= "Yell on $spell:72762",
	YellOnTrap				= "Yell on $spell:73539",
	DefileIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	HarvestSoulIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74327),
	ValkyrIcon				= "Set icons on Valkyrs",
	DefileArrow				= "Show DBM arrow when $spell:72762 is near you",
	TrapArrow				= "Show DBM arrow when $spell:73539 is near you",
	LKBugWorkaround			= "Don't use latency based sync check for defile/shadow trap\n(Default on until a bug in sync check is worked out)",
	AnnounceValkGrabs		= "Announce Val'kyr Shadowguard grab targets to raid chat\n(requires announce to be enabled and promoted status)",
	SpecWarnValkyrLow		= "Show special warning when Valkyr is below 55% HP",
	AnnouncePlagueStack		= "Announce $spell:73912 stacks to raid (10 stacks, every 5 after 10)\n(requires promoted status)"
}

L:SetMiscLocalization{
	LKPull					= "So the Light's vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?",
	YellDefile				= "Defile on me!",
	YellTrap				= "Shadow Trap on me!",
	YellValk				= "I've been grabbed!",
	LKRoleplay				= "Is it truly righteousness that drives you? I wonder...",
	PlagueWhisper			= "You have been infected by",
	ValkGrabbedIcon			= "Valkyr Shadowguard {rt%d} grabbed %s",
	ValkGrabbed				= "Valkyr Shadowguard grabbed %s",
	PlagueStackWarning		= "Warning: %s has %d stacks of Necrotic Plague",
	AchievementCompleted	= ">> ACHIEVEMENT COMPLETE: %s has %d stacks of Necrotic Plague <<"
}
