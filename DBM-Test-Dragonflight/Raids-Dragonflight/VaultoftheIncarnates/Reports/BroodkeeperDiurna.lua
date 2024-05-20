DBM.Test:Report[[
Test: Dragonflight/VaultOfTheIncarnates/BroodkeeperDiurna/LFR
Mod:  DBM-Raids-Dragonflight/2493

Findings:
	SpecialWarning for spell ID 257554 (Call Mommy) is triggered by event SPELL_CAST_SUCCESS 181113 (Encounter Spawn)
	Timer for spell ID 257554 (Call Mommy) is triggered by event SPELL_CAST_SUCCESS 181113 (Encounter Spawn)
	SpecialWarning for spell ID 375630 (Ionizing Charge) is triggered by event SPELL_AURA_APPLIED 375620 (Ionizing Charge)
	Yell for spell ID 375630 (Ionizing Charge) is triggered by event SPELL_AURA_APPLIED 375620 (Ionizing Charge)
	Timer for spell ID 388918 (Frozen Shroud) is triggered by event SPELL_AURA_APPLIED 375879 (Broodkeeper's Fury)
	Unused event registration: SPELL_AURA_APPLIED 375475 (Rending Bite)
	Unused event registration: SPELL_AURA_APPLIED 375829 (Clutchwatcher's Rage)
	Unused event registration: SPELL_AURA_APPLIED 375889 (Greatstaff's Wrath)
	Unused event registration: SPELL_AURA_APPLIED 376073 (Rapid Incubation)
	Unused event registration: SPELL_AURA_APPLIED 376272 (Burrowing Strike)
	Unused event registration: SPELL_AURA_APPLIED 376330 (Fixate)
	Unused event registration: SPELL_AURA_APPLIED 380483 (Empowered Greatstaff's Wrath)
	Unused event registration: SPELL_AURA_APPLIED 390561 (Diurna's Gaze)
	Unused event registration: SPELL_AURA_APPLIED 396264 (Detonating Stoneslam)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 375475 (Rending Bite)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 375829 (Clutchwatcher's Rage)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 375879 (Broodkeeper's Fury)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 376272 (Burrowing Strike)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 378782 (Mortal Wounds)
	Unused event registration: SPELL_AURA_REMOVED 375809 (Broodkeeper's Bond)
	Unused event registration: SPELL_AURA_REMOVED 376073 (Rapid Incubation)
	Unused event registration: SPELL_AURA_REMOVED 376330 (Fixate)
	Unused event registration: SPELL_AURA_REMOVED 396264 (Detonating Stoneslam)
	Unused event registration: SPELL_AURA_REMOVED_DOSE 375809 (Broodkeeper's Bond)
	Unused event registration: SPELL_CAST_START 375475 (Rending Bite)
	Unused event registration: SPELL_CAST_START 375485 (Cauterizing Flashflames)
	Unused event registration: SPELL_CAST_START 375653 (Static Jolt)
	Unused event registration: SPELL_CAST_START 376272 (Burrowing Strike)
	Unused event registration: SPELL_CAST_START 388918 (Frozen Shroud)
	Unused event registration: SPELL_CAST_START 396269 (Mortal Stoneslam)
	Unused event registration: SPELL_CAST_START 396779 (Storm Fissure)
	Unused event registration: SPELL_CAST_SUCCESS 375870 (Mortal Stoneclaws)
	Unused event registration: SPELL_CAST_SUCCESS 396269 (Mortal Stoneslam)
	Unused event registration: SPELL_PERIODIC_DAMAGE 390747 (Static Field)
	Unused event registration: SPELL_PERIODIC_MISSED 390747 (Static Field)
	Unused event registration: UNIT_DIED

Unused objects:
	[Announce] Rending Bite on >%s< (%d), type=stack, spellId=375475
	[Announce] Casting Cauterizing Flashflames: 2.0 sec, type=cast, spellId=375485
	[Announce] Casting Flame Sentry: 2.5 sec, type=cast, spellId=375575
	[Announce] Clutchwatcher's Rage on >%s< (%d), type=stack, spellId=375829
	[Announce] Burrowing Strike on >%s< (%d), type=stack, spellId=376272
	[Announce] Empowered Greatstaff's Wrath on >%s<, type=target, spellId=380483
	[Announce] Diurna's Gaze on YOU, type=you, spellId=390561
	[Special Warning] Rending Bite - defensive, type=defensive, spellId=375475
	[Special Warning] Static Jolt - interrupt >%s<! (%d), type=interruptcount, spellId=375653
	[Special Warning] Mortal Stoneclaws - defensive, type=defensive, spellId=375870
	[Special Warning] Greatstaff's Wrath on you, type=you, spellId=375889
	[Special Warning] Tremors - dodge attack, type=dodge, spellId=376257
	[Special Warning] Burrowing Strike - defensive, type=defensive, spellId=376272
	[Special Warning] Empowered Greatstaff of the Broodkeeper! (%s), type=count, spellId=380176
	[Special Warning] Empowered Greatstaff's Wrath on you, type=you, spellId=380483
	[Special Warning] Frozen Shroud! (%s), type=count, spellId=388918
	[Special Warning] %s damage - move away, type=gtfo, spellId=390747
	[Special Warning] Detonating Stoneslam on >%s< - taunt now, type=taunt, spellId=396264
	[Special Warning] Detonating Stoneslam on you, type=you, spellId=396264
	[Special Warning] Mortal Stoneslam - defensive, type=defensive, spellId=396269
	[Special Warning] Storm Fissure - dodge attack, type=dodge, spellId=396779
	[Timer] Rending Bite, time=11.00, type=cdnp, spellId=375475
	[Timer] Cauterizing Flashflames, time=11.70, type=cdnp, spellId=375485
	[Timer] Burrowing Strike, time=8.10, type=cdnp, spellId=376272
	[Timer] Mortal Stoneslam (%s), time=20.70, type=cdcount, spellId=396269
	[Timer] Storm Fissure, time=24.00, type=cd, spellId=396779
	[Yell] Greatstaff's Wrath on PlayerName, type=yell, spellId=375889
	[Yell] Empowered Greatstaff's Wrath on PlayerName, type=yell, spellId=380483
	[Yell] %d, type=shortfade, spellId=396264
	[Yell] Detonating Stoneslam, type=shortyell, spellId=396264

Timers:
	Adds (%s), time=60.00, type=addscustom, spellId=257554
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 2x, delta times: 35.61, 86.69
		[ 60.73] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AA8, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 5x, delta times: 60.73, 36.58, 68.34, 61.62, 25.01
		[295.75] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B92, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Chilling Tantrum, time=11.10, type=cdnp, spellId=375457
		[ 44.13] SPELL_CAST_START: [Juvenile Frost Proto-Dragon: Chilling Tantrum] Creature-0-3883-2522-18928-191222-0000463A8E, Juvenile Frost Proto-Dragon, 0xa48, "", nil, 0x0, 375457, Chilling Tantrum, 0, 0
			 Triggered 2x, delta times: 44.13, 130.02
	Flame Sentry, time=10.40, type=cdnp, spellId=375575
		[100.82] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463AD0, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
			 Triggered 5x, delta times: 100.82, 10.94, 119.10, 10.96, 10.95
	Ionizing Charge, time=10.00, type=cdnp, spellId=375630
		[ 68.41] SPELL_CAST_START: [Drakonid Stormbringer: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463AA8, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 375630, Ionizing Charge, 0, 0
			 Triggered 2x, delta times: 68.41, 103.30
	Mortal Stoneclaws (%s), time=20.20, type=cdcount, spellId=375870
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[  3.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
			 Triggered 13x, delta times: 3.26, 25.55, 22.47, 25.21, 22.78, 24.00, 24.00, 24.02, 24.35, 23.62, 24.00, 24.00, 25.53
	Wildfire (%s), time=21.40, type=cdcount, spellId=375871
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[  8.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
			 Triggered 12x, delta times: 8.28, 25.01, 24.99, 24.99, 25.01, 25.01, 27.48, 22.51, 25.00, 24.99, 24.99, 25.02
	Broodkeeper's Fury (%s), time=30.00, type=nextcount, spellId=375879
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
	Rapid Incubation (%s), time=24.40, type=cdcount, spellId=376073
		[ 73.29] SPELL_CAST_START: [Broodkeeper Diurna: Rapid Incubation] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 376073, Rapid Incubation, 0, 0
	Tremors, time=11.00, type=cdnp, spellId=376257
		[131.18] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463AE8, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
			 Triggered 5x, delta times: 131.18, 12.16, 92.38, 12.19, 12.13
	Staff, time=24.40, type=cdcount, spellId=380175
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[ 16.28] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
			 Triggered 10x, delta times: 16.28, 29.99, 32.65, 27.38, 32.18, 27.78, 31.53, 28.48, 29.99, 31.78
	Icy Shroud (%s), time=39.10, type=cdcount, spellId=388716
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[ 26.28] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
			 Triggered 7x, delta times: 26.28, 43.99, 44.02, 43.97, 44.03, 43.97, 44.00
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
	Frozen Shroud (%s), time=39.90, type=cdcount, spellId=388918
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0

Announces:
	Destroy Egg (%s), type=count, spellId=19873
		Unknown trigger
	Casting Chilling Tantrum: 2.0 sec, type=cast, spellId=375457
		[ 44.13] SPELL_CAST_START: [Juvenile Frost Proto-Dragon: Chilling Tantrum] Creature-0-3883-2522-18928-191222-0000463A8E, Juvenile Frost Proto-Dragon, 0xa48, "", nil, 0x0, 375457, Chilling Tantrum, 0, 0
			 Triggered 2x, delta times: 44.13, 130.02
	Ionizing Charge on >%s<, type=target, spellId=375630
		Unknown trigger
	Broodkeeper's Fury on >%s< (%d), type=stack, spellId=375879
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
	Greatstaff's Wrath on >%s<, type=target, spellId=375889
		Unknown trigger
	Rapid Incubation, type=spell, spellId=376073
		[ 73.29] SPELL_CAST_START: [Broodkeeper Diurna: Rapid Incubation] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 376073, Rapid Incubation, 0, 0
	Mortal Wounds on >%s< (%d), type=stack, spellId=378782
		[  5.07] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
			 Triggered 12x, delta times: 5.07, 25.57, 22.45, 25.22, 22.77, 24.00, 24.00, 24.00, 24.37, 23.61, 24.01, 24.01

Special warnings:
	Incoming Adds - switch targets (%s), type=addscount, spellId=257554
		[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 2x, delta times: 35.61, 86.69
		[ 60.73] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AA8, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 5x, delta times: 60.73, 36.58, 68.34, 61.62, 25.01
		[295.75] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B92, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Ionizing Charge - move away from others, type=moveaway, spellId=375630
		[173.73] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Jungri: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-121-08C3325D, Jungri, 0x511, 375620, Ionizing Charge, 0, DEBUFF, 0
	Ice Barrage - interrupt >%s<! (%d), type=interruptcount, spellId=375716
		[ 39.74] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
			 Triggered 8x, delta times: 39.74, 85.37, 3.63, 64.46, 3.63, 57.57, 3.22, 40.55
	Wildfire - dodge attack, type=dodge, spellId=375871
		[  8.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
			 Triggered 12x, delta times: 8.28, 25.01, 24.99, 24.99, 25.01, 25.01, 27.48, 22.51, 25.00, 24.99, 24.99, 25.02
	Mortal Wounds on >%s< - taunt now, type=taunt, spellId=378782
		[294.61] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
	Greatstaff of the Broodkeeper! (%s), type=count, spellId=380175
		[ 16.28] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
			 Triggered 10x, delta times: 16.28, 29.99, 32.65, 27.38, 32.18, 27.78, 31.53, 28.48, 29.99, 31.78
	Icy Shroud! (%s), type=count, spellId=388716
		[ 26.28] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
			 Triggered 7x, delta times: 26.28, 43.99, 44.02, 43.97, 44.03, 43.97, 44.00

Yells:
	Ionizing Charge on PlayerName, type=yell, spellId=375630
		[173.73] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Jungri: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-121-08C3325D, Jungri, 0x511, 375620, Ionizing Charge, 0, DEBUFF, 0

Voice pack sounds:
	VoicePack/aesoon
		[ 26.28] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
			 Triggered 7x, delta times: 26.28, 43.99, 44.02, 43.97, 44.03, 43.97, 44.00
	VoicePack/kick1r
		[ 39.74] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
			 Triggered 8x, delta times: 39.74, 85.37, 3.63, 64.46, 3.63, 57.57, 3.22, 40.55
	VoicePack/killmob
		[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 2x, delta times: 35.61, 86.69
		[ 60.73] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AA8, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 5x, delta times: 60.73, 36.58, 68.34, 61.62, 25.01
		[295.75] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B92, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	VoicePack/range5
		[173.73] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Jungri: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-121-08C3325D, Jungri, 0x511, 375620, Ionizing Charge, 0, DEBUFF, 0
	VoicePack/scatter
		[  8.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
			 Triggered 12x, delta times: 8.28, 25.01, 24.99, 24.99, 25.01, 25.01, 27.48, 22.51, 25.00, 24.99, 24.99, 25.02
	VoicePack/specialsoon
		[ 16.28] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
			 Triggered 10x, delta times: 16.28, 29.99, 32.65, 27.38, 32.18, 27.78, 31.53, 28.48, 29.99, 31.78
	VoicePack/tauntboss
		[294.61] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
	VoicePack/watchstep
		Unknown trigger

Icons:
	Icon 5, target=Creature-0-3883-2522-18928-191206-0000C63A8E, scanMethod=nil
		[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000C63A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 5, target=Creature-0-3883-2522-18928-191206-0000C63AE8, scanMethod=nil
		[122.30] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000C63AE8, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 5, target=Creature-0-3883-2522-18928-191206-0000C63B6A, scanMethod=nil
		[252.29] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000C63B6A, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 6, target=Creature-0-3883-2522-18928-191206-0000463A8E, scanMethod=nil
		[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 6, target=Creature-0-3883-2522-18928-191206-0000463AA8, scanMethod=nil
		[ 60.73] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463AA8, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 6, target=Creature-0-3883-2522-18928-191206-0000463AE8, scanMethod=nil
		[122.30] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463AE8, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 6, target=Creature-0-3883-2522-18928-191206-0000463B6A, scanMethod=nil
		[252.29] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463B6A, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 6, target=Creature-0-3883-2522-18928-191206-0000463B92, scanMethod=nil
		[298.17] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463B92, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
	Icon 6, target=Creature-0-3883-2522-18928-191206-0000C63B2A, scanMethod=nil
		[196.83] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000C63B2A, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
	Icon 6, target=Creature-0-3883-2522-18928-191206-0001463B2A, scanMethod=nil
		[193.20] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0001463B2A, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
	Icon 8, target=Creature-0-3883-2522-18928-191232-0000463AA8, scanMethod=nil
		[ 61.54] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463AA8, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 8, target=Creature-0-3883-2522-18928-191232-0000463B10, scanMethod=nil
		[165.65] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Icon 8, target=Creature-0-3883-2522-18928-191232-0000463B92, scanMethod=nil
		[295.75] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B92, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0

Event trace:
	[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 376073 375871 388716 375870 375716 376272 376257 375485 375575 375457 375653 375630 388918 396269 396779 375475, SPELL_CAST_SUCCESS 380175 375870 396269 181113, SPELL_AURA_APPLIED 375889 375829 376073 378782 390561 376272 375475 375620 375879 376330 396264 380483, SPELL_AURA_APPLIED_DOSE 375829 378782 376272 375475 375879, SPELL_AURA_REMOVED 376073 375809 376330 396264, SPELL_AURA_REMOVED_DOSE 375809, SPELL_PERIODIC_DAMAGE 390747, SPELL_PERIODIC_MISSED 390747, UNIT_DIED
		StartTimer: 3.2, Mortal Stoneclaws (1)
		StartTimer: 8.2, Wildfire (1)
		StartTimer: 16.2, Staff
		StartTimer: 35.4, Adds (1)
		StartTimer: 26.2, Icy Shroud (1)
	[  3.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (2)
	[  5.07] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[  8.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (2)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[ 16.28] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Kurtdouglas-Stormrage, Unhailed-Frostmourne
		ShowAnnounce: Destroy Egg (19)
		ShowAnnounce: Greatstaff's Wrath on Kurtdouglas-Stormrage
		ShowAnnounce: Destroy Egg (18)
	[ 26.28] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (1)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (2)
	[ 28.81] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (3)
	[ 30.64] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[ 33.29] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (3)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000463A8E, 2, 6, 1
		AntiSpam: 2
			Filtered: 2x SPELL_CAST_SUCCESS at 35.61, 35.61
		ShowSpecialWarning: Incoming Adds - switch targets (1)
		PlaySound: VoicePack/killmob
		StartTimer: 24.6, Adds (2)
	[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000C63A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000C63A8E, 2, 5, 1
	[ 39.74] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[ 44.13] SPELL_CAST_START: [Juvenile Frost Proto-Dragon: Chilling Tantrum] Creature-0-3883-2522-18928-191222-0000463A8E, Juvenile Frost Proto-Dragon, 0xa48, "", nil, 0x0, 375457, Chilling Tantrum, 0, 0
		AntiSpam: 375457
		ShowAnnounce: Casting Chilling Tantrum: 2.0 sec
		StartTimer: 11.1, Chilling Tantrum
	[ 46.27] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (2)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Unhailed-Frostmourne
	[ 51.28] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (4)
	[ 53.09] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	Unknown trigger
		ShowAnnounce: Destroy Egg (17)
		ShowAnnounce: Destroy Egg (16)
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Lebran-Hakkar
	[ 58.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (4)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[ 60.73] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AA8, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		AntiSpam: 2
			Filtered: 2x SPELL_CAST_SUCCESS at 60.73, 61.54
		ShowSpecialWarning: Incoming Adds - switch targets (2)
		PlaySound: VoicePack/killmob
		StartTimer: 36.3, Adds (3)
	[ 60.73] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463AA8, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000463AA8, 2, 6, 1
	[ 61.54] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463AA8, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191232-0000463AA8, 2, 8, 1
	[ 68.41] SPELL_CAST_START: [Drakonid Stormbringer: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463AA8, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 375630, Ionizing Charge, 0, 0
		StartTimer: 10.0, Ionizing Charge
	[ 70.27] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (2)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (3)
	Unknown trigger
		ShowAnnounce: Ionizing Charge on Fudoswrath-Staghelm, Mataadoorr-Quel'Thalas, Nitah-MoonGuard, Ravinnah-Suramar, Stratalas-Dalaran
	[ 73.29] SPELL_CAST_START: [Broodkeeper Diurna: Rapid Incubation] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 376073, Rapid Incubation, 0, 0
		ShowAnnounce: Rapid Incubation
		StartTimer: 24.0, Rapid Incubation (2)
	[ 76.49] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (5)
	[ 78.31] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[ 78.92] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (3)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[ 83.27] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (5)
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Dysmember-Stormrage, Unhailed-Frostmourne
		PlaySound: VoicePack/watchstep
		ShowAnnounce: Destroy Egg (14)
	[ 97.31] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AD0, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		AntiSpam: 2
			Filtered: 3x SPELL_CAST_SUCCESS at 97.31, 97.31, 97.33
		ShowSpecialWarning: Incoming Adds - switch targets (3)
		PlaySound: VoicePack/killmob
		StartTimer: 24.9, Adds (4)
	[ 99.27] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (6)
	[100.82] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463AD0, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
	[101.08] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[106.30] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (4)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[108.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (6)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[111.76] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463AD0, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
	Unknown trigger
		ShowAnnounce: Destroy Egg (12)
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Dysmember-Stormrage, Itìs-Proudmoore, Neilpeart-Tortheldrin, Unhailed-Frostmourne
	[114.29] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (3)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (4)
	[122.30] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463AE8, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000463AE8, 2, 6, 1
		AntiSpam: 2
			Filtered: 2x SPELL_CAST_SUCCESS at 122.3, 122.3
		ShowSpecialWarning: Incoming Adds - switch targets (4)
		PlaySound: VoicePack/killmob
		StartTimer: 43.1, Adds (5)
	[122.30] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000C63AE8, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000C63AE8, 2, 5, 1
	[123.27] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (7)
	[125.08] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[125.11] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000C63AE8, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[128.74] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463AE8, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[131.18] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463AE8, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	[133.29] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (7)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[138.48] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (5)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[143.34] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463AE8, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Itìs-Proudmoore, Neilpeart-Tortheldrin, Unhailed-Frostmourne
		ShowAnnounce: Destroy Egg (11)
		ShowAnnounce: Destroy Egg (10)
	[147.27] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (8)
	[149.08] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[158.26] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (4)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (5)
	[160.77] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (8)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[165.65] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463B10, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		AntiSpam: 2
			Filtered: 3x SPELL_CAST_SUCCESS at 165.65, 165.65, 165.65
		ShowSpecialWarning: Incoming Adds - switch targets (5)
		PlaySound: VoicePack/killmob
		StartTimer: 24.9, Adds (6)
	[165.65] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191232-0000463B10, 2, 8, 1
	[166.26] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (6)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Unhailed-Frostmourne
	[171.29] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (9)
	[171.71] SPELL_CAST_START: [Drakonid Stormbringer: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 375630, Ionizing Charge, 0, 0
		StartTimer: 10.0, Ionizing Charge
	[173.08] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	Unknown trigger
		ShowAnnounce: Destroy Egg (8)
	[173.73] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Jungri: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-121-08C3325D, Jungri, 0x511, 375620, Ionizing Charge, 0, DEBUFF, 0
		ShowSpecialWarning: Ionizing Charge - move away from others
		PlaySound: VoicePack/range5
		ShowYell: Ionizing Charge on PlayerName
	Unknown trigger
		ShowAnnounce: Ionizing Charge on Carolmi-Quel'Thalas, Dracaryn-MoonGuard, Itìs-Proudmoore, Jungri, Tellashalala-Area52
	[174.15] SPELL_CAST_START: [Juvenile Frost Proto-Dragon: Chilling Tantrum] Creature-0-3883-2522-18928-191222-0000463B10, Juvenile Frost Proto-Dragon, 0xa48, "", nil, 0x0, 375457, Chilling Tantrum, 0, 0
		AntiSpam: 375457
		ShowAnnounce: Casting Chilling Tantrum: 2.0 sec
		StartTimer: 11.1, Chilling Tantrum
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Lebran-Hakkar
	[183.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (9)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[193.20] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0001463B2A, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0001463B2A, 2, 6, 1
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[195.64] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (10)
	[196.83] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000C63B2A, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000C63B2A, 2, 6, 1
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[197.45] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[197.79] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (7)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[202.29] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (5)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (6)
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Unhailed-Frostmourne
		ShowAnnounce: Destroy Egg (7)
	[208.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (10)
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Lebran-Hakkar
		PlaySound: VoicePack/watchstep
		ShowAnnounce: Destroy Egg (6)
	[219.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (11)
	[221.06] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[226.27] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (8)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[227.27] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463B52, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		AntiSpam: 2
			Filtered: 3x SPELL_CAST_SUCCESS at 227.29, 227.29, 227.3
		ShowSpecialWarning: Incoming Adds - switch targets (6)
		PlaySound: VoicePack/killmob
		StartTimer: 36.3, Adds (7)
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Unhailed-Frostmourne
	[230.86] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463B52, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
	Unknown trigger
		ShowAnnounce: Destroy Egg (5)
		ShowAnnounce: Greatstaff's Wrath on Lebran-Hakkar
	[233.27] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (11)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[235.72] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463B52, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Dysmember-Stormrage
		ShowAnnounce: Destroy Egg (4)
	[241.82] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463B52, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
	[243.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (12)
	[245.07] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[246.26] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (6)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (7)
	[247.91] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463B52, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	[252.28] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463B6A, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		AntiSpam: 2
			Filtered: 4x SPELL_CAST_SUCCESS at 252.28, 252.29, 252.29, 252.29
		ShowSpecialWarning: Incoming Adds - switch targets (7)
		PlaySound: VoicePack/killmob
		StartTimer: 24.9, Adds (8)
	[252.29] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463B6A, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000463B6A, 2, 6, 1
	[252.29] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000C63B6A, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000C63B6A, 2, 5, 1
	[252.77] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463B52, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
	[254.40] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000C63B6A, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[256.26] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (9)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[257.62] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463B6A, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[258.26] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (12)
	[260.04] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463B52, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	Unknown trigger
		PlaySound: VoicePack/watchstep
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Lebran-Hakkar, Unhailed-Frostmourne
		ShowAnnounce: Destroy Egg (2)
	[267.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (13)
	[269.08] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[283.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		StartTimer: 22.0, Wildfire (13)
	Unknown trigger
		PlaySound: VoicePack/watchstep
	[288.04] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (10)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[290.26] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (7)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (8)
	[292.79] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		StartTimer: 21.4, Mortal Stoneclaws (14)
	[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
		ShowAnnounce: Broodkeeper's Fury on Broodkeeper Diurna (1)
		StartTimer: 30.0, Broodkeeper's Fury (2)
		StopTimer: Timer388716cdcount\t8
		StartTimer: 38.6, Frozen Shroud (1)
	Unknown trigger
		ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Lebran-Hakkar, Unhailed-Frostmourne
	[294.61] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowSpecialWarning: Mortal Wounds on Unhailed-Frostmourne - taunt now
		PlaySound: VoicePack/tauntboss
	Unknown trigger
		ShowAnnounce: Destroy Egg (0)
	[295.75] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B92, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191232-0000463B92, 2, 8, 1
		AntiSpam: 2
		ShowSpecialWarning: Incoming Adds - switch targets (8)
		PlaySound: VoicePack/killmob
		StartTimer: 43.1, Adds (9)
	[298.17] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463B92, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0000463B92, 2, 6, 1
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[301.11] ENCOUNTER_END: 2614, Broodkeeper Diurna, 17, 25, 1, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 376073 375809 376330 396264
]]
