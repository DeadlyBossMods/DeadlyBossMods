DBM.Test:Report[[
Test: Dragonflight/VaultOfTheIncarnates/BroodkeeperDiurna/LFR
Mod:  DBM-Raids-Dragonflight/2493

Findings:
	Unused event registration: SPELL_AURA_APPLIED 375475 (Rending Bite)
	Unused event registration: SPELL_AURA_APPLIED 375829 (Clutchwatcher's Rage)
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
	Unused event registration: SPELL_AURA_REMOVED 376073 (Rapid Incubation)
	Unused event registration: SPELL_AURA_REMOVED 376330 (Fixate)
	Unused event registration: SPELL_AURA_REMOVED 396264 (Detonating Stoneslam)
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
	Adds (%s), time=60.00, type=addscustom, spellId=257554, triggerDeltas = 0.00, 35.61, 25.12, 36.58, 24.99, 43.35, 61.62, 25.01, 43.47
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 2x, delta times: 35.61, 86.69
		[ 60.73] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AA8, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 5x, delta times: 60.73, 36.58, 68.34, 61.62, 25.01
		[295.75] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B92, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Chilling Tantrum, time=11.10, type=cdnp, spellId=375457, triggerDeltas = 44.13, 130.02
		[ 44.13] SPELL_CAST_START: [Juvenile Frost Proto-Dragon: Chilling Tantrum] Creature-0-3883-2522-18928-191222-0000463A8E, Juvenile Frost Proto-Dragon, 0xa48, "", nil, 0x0, 375457, Chilling Tantrum, 0, 0
			 Triggered 2x, delta times: 44.13, 130.02
	Flame Sentry, time=10.40, type=cdnp, spellId=375575, triggerDeltas = 100.82, 10.94, 119.10, 10.96, 10.95
		[100.82] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463AD0, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
			 Triggered 5x, delta times: 100.82, 10.94, 119.10, 10.96, 10.95
	Ionizing Charge, time=10.00, type=cdnp, spellId=375630, triggerDeltas = 68.41, 103.30
		[ 68.41] SPELL_CAST_START: [Drakonid Stormbringer: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463AA8, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 375630, Ionizing Charge, 0, 0
			 Triggered 2x, delta times: 68.41, 103.30
	Mortal Stoneclaws (%s), time=20.20, type=cdcount, spellId=375870, triggerDeltas = 0.00, 3.26, 25.55, 22.47, 25.21, 22.78, 24.00, 24.00, 24.02, 24.35, 23.62, 24.00, 24.00, 25.53
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[  3.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
			 Triggered 13x, delta times: 3.26, 25.55, 22.47, 25.21, 22.78, 24.00, 24.00, 24.02, 24.35, 23.62, 24.00, 24.00, 25.53
	Wildfire (%s), time=21.40, type=cdcount, spellId=375871, triggerDeltas = 0.00, 8.28, 25.01, 24.99, 24.99, 25.01, 25.01, 27.48, 22.51, 25.00, 24.99, 24.99, 25.02
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[  8.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
			 Triggered 12x, delta times: 8.28, 25.01, 24.99, 24.99, 25.01, 25.01, 27.48, 22.51, 25.00, 24.99, 24.99, 25.02
	Broodkeeper's Fury (%s), time=30.00, type=nextcount, spellId=375879, triggerDeltas = 293.19
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
	Rapid Incubation (%s), time=24.40, type=cdcount, spellId=376073, triggerDeltas = 73.29
		[ 73.29] SPELL_CAST_START: [Broodkeeper Diurna: Rapid Incubation] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 376073, Rapid Incubation, 0, 0
	Tremors, time=11.00, type=cdnp, spellId=376257, triggerDeltas = 131.18, 12.16, 92.38, 12.19, 12.13
		[131.18] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463AE8, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
			 Triggered 5x, delta times: 131.18, 12.16, 92.38, 12.19, 12.13
	Staff, time=24.40, type=cdcount, spellId=380175, triggerDeltas = 0.00, 16.28, 29.99, 32.65, 27.38, 32.18, 27.78, 31.53, 28.48, 29.99, 31.78
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[ 16.28] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
			 Triggered 10x, delta times: 16.28, 29.99, 32.65, 27.38, 32.18, 27.78, 31.53, 28.48, 29.99, 31.78
	Icy Shroud (%s), time=39.10, type=cdcount, spellId=388716, triggerDeltas = 0.00, 26.28, 43.99, 44.02, 43.97, 44.03, 43.97, 44.00
		[  0.00] ENCOUNTER_START: 2614, Broodkeeper Diurna, 17, 25, 0
		[ 26.28] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
			 Triggered 7x, delta times: 26.28, 43.99, 44.02, 43.97, 44.03, 43.97, 44.00
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
	Frozen Shroud (%s), time=39.90, type=cdcount, spellId=388918, triggerDeltas = 293.19
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0

Announces:
	Destroy Egg (%s), type=count, spellId=19873, triggerDeltas = 22.19, 3.98, 27.01, 3.99, 29.01, 27.01, 33.00, 26.98, 31.01, 7.02, 20.98, 8.01, 23.99, 30.99
		[ 22.19] Scheduled at 20.19 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 19, 0
		[ 26.17] Scheduled at 24.17 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 18, 0
		[ 53.18] Scheduled at 51.18 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 17, 0
		[ 57.17] Scheduled at 55.17 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 16, 0
		[ 86.18] Scheduled at 84.18 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 14, 0
		[113.19] Scheduled at 111.19 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 12, 0
		[146.19] Scheduled at 144.19 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 10, 0
		[173.17] Scheduled at 171.17 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 8, 0
		[204.18] Scheduled at 202.18 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 7, 0
		[211.20] Scheduled at 209.20 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 6, 0
		[232.18] Scheduled at 230.18 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 5, 0
		[240.19] Scheduled at 238.19 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 4, 0
		[264.18] Scheduled at 262.18 by SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 2, 0
		[295.17] Scheduled at 293.17 by SPELL_AURA_REMOVED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 0
	Casting Chilling Tantrum: 2.0 sec, type=cast, spellId=375457, triggerDeltas = 44.13, 130.02
		[ 44.13] SPELL_CAST_START: [Juvenile Frost Proto-Dragon: Chilling Tantrum] Creature-0-3883-2522-18928-191222-0000463A8E, Juvenile Frost Proto-Dragon, 0xa48, "", nil, 0x0, 375457, Chilling Tantrum, 0, 0
			 Triggered 2x, delta times: 44.13, 130.02
	Ionizing Charge on >%s<, type=target, spellId=375630, triggerDeltas = 70.73, 103.30
		[ 70.73] Scheduled at 70.43 by SPELL_AURA_APPLIED: [Drakonid Stormbringer->Stratalas-Dalaran: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463AA8, Drakonid Stormbringer, 0xa48, Player-3683-0B6747EA, Stratalas-Dalaran, 0x512, 375620, Ionizing Charge, 0, DEBUFF, 0
		[174.03] Scheduled at 173.73 by SPELL_AURA_APPLIED: [Drakonid Stormbringer->Carolmi-Quel'Thalas: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-1428-0949B0C0, Carolmi-Quel'Thalas, 0x512, 375620, Ionizing Charge, 0, DEBUFF, 0
	Broodkeeper's Fury on >%s< (%d), type=stack, spellId=375879, triggerDeltas = 293.19
		[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
	Greatstaff's Wrath on >%s<, type=target, spellId=375889, triggerDeltas = 21.82, 4.02, 24.53, 6.93, 27.32, 28.75, 30.40, 26.71, 6.03, 26.02, 6.56, 21.04, 2.19, 6.76, 22.19, 32.05
		[ 21.82] Scheduled at 19.82 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Kurtdouglas-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463A8C, Greatstaff of the Broodkeeper, 0xa48, Player-60-057187CD, Kurtdouglas-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[ 25.84] Scheduled at 23.84 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Kurtdouglas-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463A90, Greatstaff of the Broodkeeper, 0xa48, Player-60-057187CD, Kurtdouglas-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[ 50.37] Scheduled at 48.37 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Unhailed-Frostmourne: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463AA9, Greatstaff of the Broodkeeper, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[ 57.30] Scheduled at 55.30 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463AB0, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[ 84.62] Scheduled at 82.62 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Dysmember-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463ACB, Greatstaff of the Broodkeeper, 0xa48, Player-60-0C2ADCAC, Dysmember-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[113.37] Scheduled at 111.37 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Neilpeart-Tortheldrin: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463AE8, Greatstaff of the Broodkeeper, 0xa48, Player-1168-09E38807, Neilpeart-Tortheldrin, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[143.77] Scheduled at 141.77 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Itìs-Proudmoore: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B06, Greatstaff of the Broodkeeper, 0xa48, Player-5-0BE1E561, Itìs-Proudmoore, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[170.48] Scheduled at 168.48 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B21, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[176.51] Scheduled at 174.51 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B27, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[202.53] Scheduled at 200.53 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B41, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[209.09] Scheduled at 207.09 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B47, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[230.13] Scheduled at 228.13 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Unhailed-Frostmourne: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B5C, Greatstaff of the Broodkeeper, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[232.32] Scheduled at 230.32 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B5F, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[239.08] Scheduled at 237.08 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B65, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[261.27] Scheduled at 259.27 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0001463B7B, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		[293.32] Scheduled at 291.32 by SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0001463B9B, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
	Rapid Incubation, type=spell, spellId=376073, triggerDeltas = 73.29
		[ 73.29] SPELL_CAST_START: [Broodkeeper Diurna: Rapid Incubation] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 376073, Rapid Incubation, 0, 0
	Mortal Wounds on >%s< (%d), type=stack, spellId=378782, triggerDeltas = 5.07, 25.57, 22.45, 25.22, 22.77, 24.00, 24.00, 24.00, 24.37, 23.61, 24.01, 24.01
		[  5.07] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
			 Triggered 12x, delta times: 5.07, 25.57, 22.45, 25.22, 22.77, 24.00, 24.00, 24.00, 24.37, 23.61, 24.01, 24.01

Special warnings:
	Incoming Adds - switch targets (%s), type=addscount, spellId=257554, triggerDeltas = 35.61, 25.12, 36.58, 24.99, 43.35, 61.62, 25.01, 43.47
		[ 35.61] SPELL_CAST_SUCCESS: [Primalist Mage: Encounter Spawn] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 2x, delta times: 35.61, 86.69
		[ 60.73] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AA8, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
			 Triggered 5x, delta times: 60.73, 36.58, 68.34, 61.62, 25.01
		[295.75] SPELL_CAST_SUCCESS: [Drakonid Stormbringer: Encounter Spawn] Creature-0-3883-2522-18928-191232-0000463B92, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
	Ionizing Charge - move away from others, type=moveaway, spellId=375630, triggerDeltas = 173.73
		[173.73] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Jungri: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-121-08C3325D, Jungri, 0x511, 375620, Ionizing Charge, 0, DEBUFF, 0
	Ice Barrage - interrupt >%s<! (%d), type=interruptcount, spellId=375716, triggerDeltas = 39.74, 85.37, 3.63, 64.46, 3.63, 57.57, 3.22, 40.55
		[ 39.74] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0000463A8E, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
			 Triggered 8x, delta times: 39.74, 85.37, 3.63, 64.46, 3.63, 57.57, 3.22, 40.55
	Wildfire - dodge attack, type=dodge, spellId=375871, triggerDeltas = 8.28, 25.01, 24.99, 24.99, 25.01, 25.01, 27.48, 22.51, 25.00, 24.99, 24.99, 25.02
		[  8.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
			 Triggered 12x, delta times: 8.28, 25.01, 24.99, 24.99, 25.01, 25.01, 27.48, 22.51, 25.00, 24.99, 24.99, 25.02
	Mortal Wounds on >%s< - taunt now, type=taunt, spellId=378782, triggerDeltas = 294.61
		[294.61] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
	Greatstaff of the Broodkeeper! (%s), type=count, spellId=380175, triggerDeltas = 16.28, 29.99, 32.65, 27.38, 32.18, 27.78, 31.53, 28.48, 29.99, 31.78
		[ 16.28] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
			 Triggered 10x, delta times: 16.28, 29.99, 32.65, 27.38, 32.18, 27.78, 31.53, 28.48, 29.99, 31.78
	Icy Shroud! (%s), type=count, spellId=388716, triggerDeltas = 26.28, 43.99, 44.02, 43.97, 44.03, 43.97, 44.00
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
		[ 10.28] Scheduled at 8.28 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[ 35.29] Scheduled at 33.29 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[ 60.28] Scheduled at 58.28 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[ 85.27] Scheduled at 83.27 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[110.28] Scheduled at 108.28 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[135.29] Scheduled at 133.29 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[162.77] Scheduled at 160.77 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[185.28] Scheduled at 183.28 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[210.28] Scheduled at 208.28 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[235.27] Scheduled at 233.27 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[260.26] Scheduled at 258.26 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		[285.28] Scheduled at 283.28 by SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0

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
		ScheduleTask: (anonymous function) at 11.26 (+8.00)
		StartTimer: 21.4, Mortal Stoneclaws (2)
	[  5.07] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[  8.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 10.28 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (2)
	[ 16.28] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[ 19.82] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Kurtdouglas-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463A8C, Greatstaff of the Broodkeeper, 0xa48, Player-60-057187CD, Kurtdouglas-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Kurtdouglas-Stormrage") at 21.82 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Kurtdouglas-Stormrage, Unhailed-Frostmourne
	[ 20.19] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 19, 0
		ScheduleTask: announce19873count:Schedule(19.0) at 22.19 (+2.00)
			ShowAnnounce: Destroy Egg (19)
	[ 23.84] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Kurtdouglas-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463A90, Greatstaff of the Broodkeeper, 0xa48, Player-60-057187CD, Kurtdouglas-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Kurtdouglas-Stormrage") at 25.84 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Kurtdouglas-Stormrage
	[ 24.17] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 18, 0
		ScheduleTask: announce19873count:Schedule(18.0) at 26.17 (+2.00)
			ShowAnnounce: Destroy Egg (18)
	[ 26.28] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (1)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (2)
	[ 28.81] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 36.81 (+8.00)
		StartTimer: 21.4, Mortal Stoneclaws (3)
	[ 30.64] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[ 33.29] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 35.29 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (3)
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
	[ 48.37] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Unhailed-Frostmourne: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463AA9, Greatstaff of the Broodkeeper, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Unhailed-Frostmourne") at 50.37 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Unhailed-Frostmourne
	[ 51.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 17, 0
		ScheduleTask: announce19873count:Schedule(17.0) at 53.18 (+2.00)
			ShowAnnounce: Destroy Egg (17)
	[ 51.28] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 59.28 (+8.00)
		StartTimer: 21.4, Mortal Stoneclaws (4)
	[ 53.09] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[ 55.17] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 16, 0
		ScheduleTask: announce19873count:Schedule(16.0) at 57.17 (+2.00)
			ShowAnnounce: Destroy Egg (16)
	[ 55.30] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463AB0, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Lebran-Hakkar") at 57.30 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Lebran-Hakkar
	[ 58.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 60.28 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (4)
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
	[ 70.43] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Stratalas-Dalaran: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463AA8, Drakonid Stormbringer, 0xa48, Player-3683-0B6747EA, Stratalas-Dalaran, 0x512, 375620, Ionizing Charge, 0, DEBUFF, 0
		ScheduleTask: announce375630target:CombinedShow("Stratalas-Dalaran") at 70.73 (+0.30)
			ShowAnnounce: Ionizing Charge on Fudoswrath-Staghelm, Mataadoorr-Quel'Thalas, Nitah-MoonGuard, Ravinnah-Suramar, Stratalas-Dalaran
	[ 73.29] SPELL_CAST_START: [Broodkeeper Diurna: Rapid Incubation] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 376073, Rapid Incubation, 0, 0
		ShowAnnounce: Rapid Incubation
		StartTimer: 24.0, Rapid Incubation (2)
	[ 76.49] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 84.49 (+8.00)
		StartTimer: 21.4, Mortal Stoneclaws (5)
	[ 78.31] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[ 78.92] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (3)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[ 82.62] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Dysmember-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463ACB, Greatstaff of the Broodkeeper, 0xa48, Player-60-0C2ADCAC, Dysmember-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Dysmember-Stormrage") at 84.62 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Dysmember-Stormrage, Unhailed-Frostmourne
	[ 83.19] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 15, 0
		ScheduleTask: announce19873count:Schedule(15.0) at 85.19 (+2.00)
			Unscheduled by SPELL_AURA_REMOVED_DOSE at 84.18
	[ 83.27] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 85.27 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (5)
	[ 84.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 14, 0
		UnscheduleTask: announce19873count:Schedule(15.0) scheduled by ScheduleTask at 83.19
		ScheduleTask: announce19873count:Schedule(14.0) at 86.18 (+2.00)
			ShowAnnounce: Destroy Egg (14)
	[ 97.31] SPELL_CAST_SUCCESS: [Tarasek Legionnaire: Encounter Spawn] Creature-0-3883-2522-18928-191215-0000463AD0, Tarasek Legionnaire, 0xa48, "", nil, 0x0, 181113, Encounter Spawn, 0, 0
		AntiSpam: 2
			Filtered: 3x SPELL_CAST_SUCCESS at 97.31, 97.31, 97.33
		ShowSpecialWarning: Incoming Adds - switch targets (3)
		PlaySound: VoicePack/killmob
		StartTimer: 24.9, Adds (4)
	[ 99.27] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 107.27 (+8.00)
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
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 110.28 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (6)
	[110.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 13, 0
		ScheduleTask: announce19873count:Schedule(13.0) at 112.18 (+2.00)
			Unscheduled by SPELL_AURA_REMOVED_DOSE at 111.19
	[111.19] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 12, 0
		UnscheduleTask: announce19873count:Schedule(13.0) scheduled by ScheduleTask at 110.18
		ScheduleTask: announce19873count:Schedule(12.0) at 113.19 (+2.00)
			ShowAnnounce: Destroy Egg (12)
	[111.37] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Neilpeart-Tortheldrin: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463AE8, Greatstaff of the Broodkeeper, 0xa48, Player-1168-09E38807, Neilpeart-Tortheldrin, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Neilpeart-Tortheldrin") at 113.37 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Dysmember-Stormrage, Itìs-Proudmoore, Neilpeart-Tortheldrin, Unhailed-Frostmourne
	[111.76] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463AD0, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
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
		ScheduleTask: (anonymous function) at 131.27 (+8.00)
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
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 135.29 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (7)
	[138.48] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (5)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[141.77] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Itìs-Proudmoore: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B06, Greatstaff of the Broodkeeper, 0xa48, Player-5-0BE1E561, Itìs-Proudmoore, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Itìs-Proudmoore") at 143.77 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Itìs-Proudmoore, Neilpeart-Tortheldrin, Unhailed-Frostmourne
	[142.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 11, 0
		ScheduleTask: announce19873count:Schedule(11.0) at 144.18 (+2.00)
			Unscheduled by SPELL_AURA_REMOVED_DOSE at 144.19
	[143.34] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463AE8, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	[144.19] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 10, 0
		UnscheduleTask: announce19873count:Schedule(11.0) scheduled by ScheduleTask at 142.18
		ScheduleTask: announce19873count:Schedule(10.0) at 146.19 (+2.00)
			ShowAnnounce: Destroy Egg (10)
	[147.27] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 155.27 (+8.00)
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
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 162.77 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (8)
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
	[168.48] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B21, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Caan-Stormrage") at 170.48 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Unhailed-Frostmourne
	[170.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 9, 0
		ScheduleTask: announce19873count:Schedule(9.0) at 172.18 (+2.00)
			Unscheduled by SPELL_AURA_REMOVED_DOSE at 171.17
	[171.17] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 8, 0
		UnscheduleTask: announce19873count:Schedule(9.0) scheduled by ScheduleTask at 170.18
		ScheduleTask: announce19873count:Schedule(8.0) at 173.17 (+2.00)
			ShowAnnounce: Destroy Egg (8)
	[171.29] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 179.29 (+8.00)
		StartTimer: 21.4, Mortal Stoneclaws (9)
	[171.71] SPELL_CAST_START: [Drakonid Stormbringer: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, "", nil, 0x0, 375630, Ionizing Charge, 0, 0
		StartTimer: 10.0, Ionizing Charge
	[173.08] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[173.73] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Jungri: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-121-08C3325D, Jungri, 0x511, 375620, Ionizing Charge, 0, DEBUFF, 0
		ShowSpecialWarning: Ionizing Charge - move away from others
		PlaySound: VoicePack/range5
		ShowYell: Ionizing Charge on PlayerName
	[173.73] SPELL_AURA_APPLIED: [Drakonid Stormbringer->Carolmi-Quel'Thalas: Ionizing Charge] Creature-0-3883-2522-18928-191232-0000463B10, Drakonid Stormbringer, 0xa48, Player-1428-0949B0C0, Carolmi-Quel'Thalas, 0x512, 375620, Ionizing Charge, 0, DEBUFF, 0
		ScheduleTask: announce375630target:CombinedShow("Carolmi-Quel'Thalas") at 174.03 (+0.30)
			ShowAnnounce: Ionizing Charge on Carolmi-Quel'Thalas, Dracaryn-MoonGuard, Itìs-Proudmoore, PlayerName, Tellashalala-Area52
	[174.15] SPELL_CAST_START: [Juvenile Frost Proto-Dragon: Chilling Tantrum] Creature-0-3883-2522-18928-191222-0000463B10, Juvenile Frost Proto-Dragon, 0xa48, "", nil, 0x0, 375457, Chilling Tantrum, 0, 0
		AntiSpam: 375457
		ShowAnnounce: Casting Chilling Tantrum: 2.0 sec
		StartTimer: 11.1, Chilling Tantrum
	[174.51] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B27, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Lebran-Hakkar") at 176.51 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Lebran-Hakkar
	[183.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 185.28 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (9)
	[193.20] SPELL_CAST_START: [Primalist Mage: Ice Barrage] Creature-0-3883-2522-18928-191206-0001463B2A, Primalist Mage, 0xa48, "", nil, 0x0, 375716, Ice Barrage, 0, 0
		ScanForMobs: Creature-0-3883-2522-18928-191206-0001463B2A, 2, 6, 1
		ShowSpecialWarning: Ice Barrage - interrupt Primalist Mage! (1)
		PlaySound: VoicePack/kick1r
	[195.64] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 203.64 (+8.00)
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
	[200.53] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B41, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Caan-Stormrage") at 202.53 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Unhailed-Frostmourne
	[202.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 7, 0
		ScheduleTask: announce19873count:Schedule(7.0) at 204.18 (+2.00)
			ShowAnnounce: Destroy Egg (7)
	[202.29] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (5)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (6)
	[207.09] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B47, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Lebran-Hakkar") at 209.09 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Lebran-Hakkar
	[208.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 210.28 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (10)
	[209.20] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 6, 0
		ScheduleTask: announce19873count:Schedule(6.0) at 211.20 (+2.00)
			ShowAnnounce: Destroy Egg (6)
	[219.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 227.26 (+8.00)
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
	[228.13] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Unhailed-Frostmourne: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B5C, Greatstaff of the Broodkeeper, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Unhailed-Frostmourne") at 230.13 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Unhailed-Frostmourne
	[230.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 5, 0
		ScheduleTask: announce19873count:Schedule(5.0) at 232.18 (+2.00)
			ShowAnnounce: Destroy Egg (5)
	[230.32] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B5F, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Lebran-Hakkar") at 232.32 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Lebran-Hakkar
	[230.86] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463B52, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
	[233.27] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 235.27 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (11)
	[235.72] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463B52, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	[237.08] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0000463B65, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Caan-Stormrage") at 239.08 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Dysmember-Stormrage
	[238.19] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 4, 0
		ScheduleTask: announce19873count:Schedule(4.0) at 240.19 (+2.00)
			ShowAnnounce: Destroy Egg (4)
	[241.82] SPELL_CAST_START: [Dragonspawn Flamebender: Flame Sentry] Creature-0-3883-2522-18928-191230-0000463B52, Dragonspawn Flamebender, 0xa48, "", nil, 0x0, 375575, Flame Sentry, 0, 0
		AntiSpam: 375575
		StartTimer: 10.4, Flame Sentry
	[243.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 251.26 (+8.00)
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
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 260.26 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (12)
	[259.27] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Caan-Stormrage: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0001463B7B, Greatstaff of the Broodkeeper, 0xa48, Player-60-0F4263ED, Caan-Stormrage, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Caan-Stormrage") at 261.27 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Lebran-Hakkar, Unhailed-Frostmourne
	[260.04] SPELL_CAST_START: [Tarasek Earthreaver: Tremors] Creature-0-3883-2522-18928-191225-0000463B52, Tarasek Earthreaver, 0xa48, "", nil, 0x0, 376257, Tremors, 0, 0
		AntiSpam: 376257
		StartTimer: 11.0, Tremors
	[261.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 3, 0
		ScheduleTask: announce19873count:Schedule(3.0) at 263.18 (+2.00)
			Unscheduled by SPELL_AURA_REMOVED_DOSE at 262.18
	[262.18] SPELL_AURA_REMOVED_DOSE: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 2, 0
		UnscheduleTask: announce19873count:Schedule(3.0) scheduled by ScheduleTask at 261.18
		ScheduleTask: announce19873count:Schedule(2.0) at 264.18 (+2.00)
			ShowAnnounce: Destroy Egg (2)
	[267.26] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 275.26 (+8.00)
		StartTimer: 21.4, Mortal Stoneclaws (13)
	[269.08] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowAnnounce: Mortal Wounds on Unhailed-Frostmourne (1)
	[283.28] SPELL_CAST_START: [Broodkeeper Diurna: Wildfire] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375871, Wildfire, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Wildfire - dodge attack
		PlaySound: VoicePack/scatter
		ScheduleTask: specWarn375871dodge:ScheduleVoice("watchstep") at 285.28 (+2.00)
			PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Wildfire (13)
	[288.04] SPELL_CAST_SUCCESS: [Broodkeeper Diurna: Greatstaff of the Broodkeeper] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 380175, Greatstaff of the Broodkeeper, 0, 0
		ShowSpecialWarning: Greatstaff of the Broodkeeper! (10)
		PlaySound: VoicePack/specialsoon
		StartTimer: 23.1, Staff
	[290.26] SPELL_CAST_START: [Broodkeeper Diurna: Icy Shroud] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 388716, Icy Shroud, 0, 0
		ShowSpecialWarning: Icy Shroud! (7)
		PlaySound: VoicePack/aesoon
		StartTimer: 41.5, Icy Shroud (8)
	[291.32] SPELL_AURA_APPLIED: [Greatstaff of the Broodkeeper->Lebran-Hakkar: Greatstaff's Wrath] Creature-0-3883-2522-18928-191448-0001463B9B, Greatstaff of the Broodkeeper, 0xa48, Player-1136-091F1B1B, Lebran-Hakkar, 0x512, 375889, Greatstaff's Wrath, 0, DEBUFF, 0
		ScheduleTask: announce375889target:CombinedShow("Lebran-Hakkar") at 293.32 (+2.00)
			ShowAnnounce: Greatstaff's Wrath on Caan-Stormrage, Lebran-Hakkar, Unhailed-Frostmourne
	[292.79] SPELL_CAST_START: [Broodkeeper Diurna: Mortal Stoneclaws] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, "", nil, 0x0, 375870, Mortal Stoneclaws, 0, 0
		ScheduleTask: (anonymous function) at 300.79 (+8.00)
		StartTimer: 21.4, Mortal Stoneclaws (14)
	[293.17] SPELL_AURA_REMOVED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Bond] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375809, Broodkeeper's Bond, 0, BUFF, 0
		ScheduleTask: announce19873count:Schedule(0.0) at 295.17 (+2.00)
			ShowAnnounce: Destroy Egg (0)
	[293.19] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Broodkeeper Diurna: Broodkeeper's Fury] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, 375879, Broodkeeper's Fury, 0, BUFF, 0
		ShowAnnounce: Broodkeeper's Fury on Broodkeeper Diurna (1)
		StartTimer: 30.0, Broodkeeper's Fury (2)
		StopTimer: Timer388716cdcount\t8
		StartTimer: 38.6, Frozen Shroud (1)
	[294.61] SPELL_AURA_APPLIED: [Broodkeeper Diurna->Unhailed-Frostmourne: Mortal Wounds] Creature-0-3883-2522-18928-190245-0000463935, Broodkeeper Diurna, 0xa48, Player-3725-0C0F490C, Unhailed-Frostmourne, 0x512, 378782, Mortal Wounds, 0, DEBUFF, 0
		ShowSpecialWarning: Mortal Wounds on Unhailed-Frostmourne - taunt now
		PlaySound: VoicePack/tauntboss
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
