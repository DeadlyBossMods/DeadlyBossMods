DBM.Test:Report[[
Test: TWW/NerubarPalace/Rashanan/Mythic/Wipe1
Mod:  DBM-Raids-WarWithin/2609

Findings:
	Unused event registration: SPELL_AURA_APPLIED 458067 (Savage Wound)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 458067 (Savage Wound)
	Unused event registration: SPELL_CAST_START 456762 (Caustic Hail)
	Unused event registration: SPELL_CAST_START 456853 (Caustic Hail)
	Timer for spell ID 334371 (Movement) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 334371 (Movement) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 334371 (Movement) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)
	Timer for spell ID 439784 (Spinneret's Strands) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439784 (Spinneret's Strands) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 439784 (Spinneret's Strands) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)
	Timer for spell ID 439789 (Rolling Acid) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439789 (Rolling Acid) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 439789 (Rolling Acid) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)
	Timer for spell ID 439795 (Web Reave) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439795 (Web Reave) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 439795 (Web Reave) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)
	Timer for spell ID 439811 (Erosive Spray) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439811 (Erosive Spray) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 439811 (Erosive Spray) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)
	Timer for spell ID 444687 (Savage Assault) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 444687 (Savage Assault) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 444687 (Savage Assault) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)
	Timer for spell ID 454989 (Enveloping Webs) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 454989 (Enveloping Webs) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 454989 (Enveloping Webs) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)
	Timer for spell ID 455373 (Infested Spawn) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 455373 (Infested Spawn) is triggered by event SPELL_INTERRUPT 351338 (Quell)
	Timer for spell ID 455373 (Infested Spawn) is triggered by event SPELL_INTERRUPT 47528 (Mind Freeze)

Unused objects:
	[Announce] Savage Wound on >%s< (%d), type=stack, spellId=458067
	[Special Warning] Savage Assault - defensive, type=defensive, spellId=444687
	[Special Warning] Acidic Eruption - interrupt >%s<!, type=interrupt, spellId=452806
	[Special Warning] Savage Wound on >%s< - taunt now, type=taunt, spellId=458067

Timers:
	Movement (%s), time=49.00, type=stagecontextcount, spellId=334371, triggerDeltas = 0.01, 100.01, 94.11, 101.84, 93.40, 93.93, 122.83
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83
	Spinneret's Strands (%s), time=33.90, type=cdcount, spellId=439784, triggerDeltas = 0.01, 19.63, 80.38, 94.11, 101.84, 20.33, 73.07, 93.93, 14.72, 108.11
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[ 19.64] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
			 Triggered 3x, delta times: 19.64, 296.66, 181.72
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83
	Rolling Acid (%s), time=21.30, type=cdcount, spellId=439789, triggerDeltas = 0.01, 16.11, 83.90, 94.11, 16.76, 29.75, 55.33, 93.40, 22.32, 71.61, 122.83
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[ 16.12] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
			 Triggered 4x, delta times: 16.12, 194.77, 29.75, 171.05
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83
	Web Reave (%s), time=49.00, type=cdcount, spellId=439795, triggerDeltas = 0.01, 100.01, 94.11, 101.84, 93.40, 93.93, 122.83
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83
	Erosive Spray (%s), time=49.00, type=cdcount, spellId=439811, triggerDeltas = 0.01, 2.98, 29.61, 67.42, 33.30, 60.81, 33.28, 68.56, 33.27, 60.13, 33.25, 60.68, 33.26, 89.57, 33.26
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[  2.99] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
			 Triggered 8x, delta times: 2.99, 29.61, 100.72, 94.09, 101.83, 93.38, 93.94, 122.83
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83
	Tank Debuff (%s), time=49.00, type=cdcount, spellId=444687, triggerDeltas = 0.01, 10.41, 14.80, 23.69, 9.00, 42.11, 11.04, 14.83, 23.70, 5.92, 14.81, 23.81, 11.06, 14.83, 23.13, 6.48, 14.82, 31.52, 11.07, 14.81, 23.64, 6.00, 14.80, 23.08, 11.04, 14.82, 23.68, 5.95, 14.80, 23.64, 11.05, 14.80, 23.15, 6.50, 14.77, 52.56, 11.03, 14.80
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[ 10.42] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
			 Triggered 31x, delta times: 10.42, 14.80, 23.69, 9.00, 53.15, 14.83, 23.70, 5.92, 14.81, 34.87, 14.83, 23.13, 6.48, 14.82, 42.59, 14.81, 23.64, 6.00, 14.80, 34.12, 14.82, 23.68, 5.95, 14.80, 34.69, 14.80, 23.15, 6.50, 14.77, 63.59, 14.80
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83
	157317, time=49.00, type=cdcount, spellId=454989, triggerDeltas = 0.01, 100.01, 14.74, 79.37, 101.84, 45.04, 48.36, 93.93, 44.51, 78.32
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[114.76] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
			 Triggered 3x, delta times: 114.76, 226.25, 186.80
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83
	Infested Spawn (%s), time=21.30, type=cdcount, spellId=455373, triggerDeltas = 0.01, 100.01, 20.81, 73.30, 101.84, 15.28, 78.12, 15.24, 78.69, 122.83
		[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		[120.83] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
			 Triggered 3x, delta times: 120.83, 190.42, 93.36
		[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 194.13, 101.84
		[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 483.30, 122.83

Announces:
	Spinneret's Strands incoming debuff (%s), type=incomingcount, spellId=439784, triggerDeltas = 19.64, 45.05, 75.33, 94.11, 82.17, 38.87, 93.39, 49.46, 25.27, 97.59
		[ 19.64] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
			 Triggered 10x, delta times: 19.64, 45.05, 75.33, 94.11, 82.17, 38.87, 93.39, 49.46, 25.27, 97.59
	Rolling Acid incoming debuff (%s), type=incomingcount, spellId=439789, triggerDeltas = 16.12, 30.29, 114.83, 49.65, 29.75, 14.71, 156.34, 44.43, 93.92, 78.40
		[ 16.12] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
			 Triggered 10x, delta times: 16.12, 30.29, 114.83, 49.65, 29.75, 14.71, 156.34, 44.43, 93.92, 78.40
	Erosive Spray (%s), type=count, spellId=439811, triggerDeltas = 2.99, 29.61, 44.47, 56.25, 44.40, 49.69, 44.44, 57.39, 44.44, 48.94, 44.45, 49.49, 44.44, 78.39
		[  2.99] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
			 Triggered 14x, delta times: 2.99, 29.61, 44.47, 56.25, 44.40, 49.69, 44.44, 57.39, 44.44, 48.94, 44.45, 49.49, 44.44, 78.39
	Casting Acidic Eruption: 2.5 sec, type=cast, spellId=452806, triggerDeltas = 92.53, 6.03, 93.65, 96.03, 6.03, 93.75, 93.59, 122.76
		[ 92.53] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
			 Triggered 8x, delta times: 92.53, 6.03, 93.65, 96.03, 6.03, 93.75, 93.59, 122.76
	Webs (%s), type=count, spellId=454989, triggerDeltas = 60.18, 54.58, 50.04, 94.08, 82.13, 19.72, 68.63, 98.45, 14.66
		[ 60.18] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
			 Triggered 9x, delta times: 60.18, 54.58, 50.04, 94.08, 82.13, 19.72, 68.63, 98.45, 14.66
	Infested Spawn incoming debuff (%s), type=incomingcount, spellId=455373, triggerDeltas = 39.83, 81.00, 24.20, 69.93, 96.29, 25.22, 68.14, 29.74, 69.74
		[ 39.83] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
			 Triggered 9x, delta times: 39.83, 81.00, 24.20, 69.93, 96.29, 25.22, 68.14, 29.74, 69.74

Special warnings:
	Web Reave! (%s), type=count, spellId=439795, triggerDeltas = 51.19, 52.48, 94.08, 101.85, 93.41, 93.90, 122.85
		[ 51.19] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
			 Triggered 7x, delta times: 51.19, 52.48, 94.08, 101.85, 93.41, 93.90, 122.85

Yells:
	None

Voice pack sounds:
	VoicePack/gathershare
		[ 51.19] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
			 Triggered 7x, delta times: 51.19, 52.48, 94.08, 101.85, 93.41, 93.90, 122.85

Icons:
	None

Event trace:
	[  0.01] INSTANCE_ENCOUNTER_ENGAGE_UNIT: Fake Args:, boss1, true, true, true, Rasha'nan, Creature-0-1-2657-1-214504-0000000001, elite, 3497273999, boss2, false, false, false, ??, nil, normal, 0, boss3, false, false, false, ??, nil, normal, 0, boss4, false, false, false, ??, nil, normal, 0, boss5, false, false, false, ??, nil, normal, 0, Real Args:, 0
		StartCombat: IEEU
		RegisterEvents: Regular, SPELL_CAST_START 444687 439789 455373 439784 439795 439811 454989 452806 456853 456762, SPELL_AURA_APPLIED 458067, SPELL_AURA_APPLIED_DOSE 458067, SPELL_INTERRUPT
		StartTimer: 51.1, Web Reave (1)
		StartTimer: 60.1, Webs (1)
		StartTimer: 10.3, Tank Debuff (1)
		StartTimer: 16.0, Rolling Acid (1)
		StartTimer: 39.8, Infested Spawn (1)
		StartTimer: 19.6, Spinneret's Strands (1)
		StartTimer: 2.9, Erosive Spray (1)
		StartTimer: 86.3, Movement (1)
	[  2.99] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (1)
		StartTimer: 29.6, Erosive Spray (2)
	[ 10.42] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (2)
	[ 16.12] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (1)
		StartTimer: 30.3, Rolling Acid (2)
	[ 19.64] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (1)
		StartTimer: 45.0, Spinneret's Strands (2)
	[ 25.22] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 23.8, Tank Debuff (3)
	[ 32.60] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (2)
		StartTimer: 44.4, Erosive Spray (3)
	[ 39.83] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (1)
	[ 46.41] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (2)
	[ 48.91] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 9.0, Tank Debuff (4)
	[ 51.19] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Web Reave! (1)
		PlaySound: VoicePack/gathershare
	[ 57.91] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 11.7, Tank Debuff (5)
	[ 60.18] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (1)
	[ 64.69] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (2)
	[ 77.07] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (3)
	[ 92.53] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[ 98.56] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[100.02] SPELL_INTERRUPT: [Tank2->Rasha'nan: Mind Freeze] Player-1-00000012, Tank2, 0x511, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 47528, Mind Freeze, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Web Reave (2)
		StartTimer: 14.7, Webs (2)
		StartTimer: 11.0, Tank Debuff (6)
		StartTimer: 61.2, Rolling Acid (3)
		StartTimer: 20.8, Infested Spawn (2)
		StartTimer: 40.0, Spinneret's Strands (3)
		StartTimer: 33.2, Erosive Spray (4)
		StartTimer: 86.3, Movement (2)
	[103.67] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Web Reave! (2)
		PlaySound: VoicePack/gathershare
	[111.06] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (7)
	[114.76] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (2)
		StartTimer: 50.0, Webs (3)
	[120.83] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (2)
		StartTimer: 24.2, Infested Spawn (3)
	[125.89] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 23.7, Tank Debuff (8)
	[133.32] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (4)
		StartTimer: 44.4, Erosive Spray (5)
	[140.02] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (3)
	[145.03] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (3)
	[149.59] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 5.9, Tank Debuff (9)
	[155.51] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (10)
	[161.24] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (3)
	[164.80] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (3)
	[170.32] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 3.7, Tank Debuff (11)
	[177.72] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (5)
	[192.21] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[194.13] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Web Reave (3)
		StartTimer: 64.7, Webs (4)
		StartTimer: 11.0, Tank Debuff (12)
		StartTimer: 16.7, Rolling Acid (4)
		StartTimer: 20.8, Infested Spawn (4)
		StartTimer: 40.0, Spinneret's Strands (4)
		StartTimer: 33.2, Erosive Spray (6)
		StartTimer: 86.3, Movement (3)
	[197.75] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Web Reave! (3)
		PlaySound: VoicePack/gathershare
	[205.19] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (13)
	[210.89] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (4)
		StartTimer: 29.7, Rolling Acid (5)
	[214.96] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (4)
	[220.02] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 23.1, Tank Debuff (14)
	[227.41] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (6)
		StartTimer: 44.4, Erosive Spray (7)
	[234.13] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (4)
	[240.64] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (5)
		StartTimer: 14.7, Rolling Acid (6)
	[243.15] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 6.4, Tank Debuff (15)
	[249.63] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (16)
	[255.35] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (6)
	[258.88] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (4)
	[264.45] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 3.7, Tank Debuff (17)
	[271.85] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (7)
	[288.24] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[294.27] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[295.97] SPELL_INTERRUPT: [Dps13->Rasha'nan: Quell] Player-1-00000018, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 351338, Quell, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Web Reave (4)
		StartTimer: 45.0, Webs (5)
		StartTimer: 11.0, Tank Debuff (18)
		StartTimer: 21.3, Rolling Acid (7)
		StartTimer: 15.2, Infested Spawn (5)
		StartTimer: 20.3, Spinneret's Strands (5)
		StartTimer: 33.2, Erosive Spray (8)
		StartTimer: 86.3, Movement (4)
	[299.60] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Web Reave! (4)
		PlaySound: VoicePack/gathershare
	[307.04] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (19)
	[311.25] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (5)
		StartTimer: 25.2, Infested Spawn (6)
	[316.30] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (5)
		StartTimer: 38.9, Spinneret's Strands (6)
	[321.85] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 23.6, Tank Debuff (20)
	[329.24] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (8)
		StartTimer: 44.4, Erosive Spray (9)
	[336.47] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (6)
	[341.01] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (5)
		StartTimer: 19.7, Webs (6)
	[345.49] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 6.0, Tank Debuff (21)
	[351.49] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (22)
	[355.17] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (6)
	[360.73] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (6)
	[366.29] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 3.7, Tank Debuff (23)
	[373.68] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (9)
	[388.02] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[389.37] SPELL_INTERRUPT: [Dps8->Rasha'nan: Disrupt] Player-1-00000011, Dps8, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Web Reave (5)
		StartTimer: 40.0, Webs (7)
		StartTimer: 11.0, Tank Debuff (24)
		StartTimer: 22.3, Rolling Acid (7)
		StartTimer: 15.2, Infested Spawn (7)
		StartTimer: 59.1, Spinneret's Strands (7)
		StartTimer: 33.2, Erosive Spray (10)
		StartTimer: 86.3, Movement (5)
	[393.01] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Web Reave! (5)
		PlaySound: VoicePack/gathershare
	[400.41] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (25)
	[404.61] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (7)
		StartTimer: 29.7, Infested Spawn (8)
	[411.69] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (7)
		StartTimer: 44.4, Rolling Acid (8)
	[415.23] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 23.7, Tank Debuff (26)
	[422.62] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (10)
		StartTimer: 44.4, Erosive Spray (11)
	[429.36] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (7)
	[434.35] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (8)
	[438.91] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 5.9, Tank Debuff (27)
	[444.86] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (28)
	[448.56] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (7)
	[456.12] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (8)
	[459.66] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 3.7, Tank Debuff (29)
	[467.07] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (11)
	[481.61] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[483.30] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Web Reave (6)
		StartTimer: 44.5, Webs (8)
		StartTimer: 11.0, Tank Debuff (30)
		StartTimer: 66.7, Rolling Acid (9)
		StartTimer: 20.7, Infested Spawn (9)
		StartTimer: 14.7, Spinneret's Strands (8)
		StartTimer: 33.2, Erosive Spray (12)
		StartTimer: 115.0, Movement (6)
	[486.91] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Web Reave! (6)
		PlaySound: VoicePack/gathershare
	[494.35] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (31)
	[498.02] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (8)
		StartTimer: 25.3, Spinneret's Strands (9)
	[504.09] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (9)
	[509.15] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 23.1, Tank Debuff (32)
	[516.56] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (12)
		StartTimer: 44.4, Erosive Spray (13)
	[523.29] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (9)
	[527.81] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (8)
		StartTimer: 14.6, Webs (9)
	[532.30] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 6.5, Tank Debuff (33)
	[538.80] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (34)
	[542.47] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowAnnounce: Webs (9)
	[550.04] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (9)
	[553.57] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 3.7, Tank Debuff (35)
	[561.00] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (13)
	[604.37] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[606.13] SPELL_INTERRUPT: [Tank3->Rasha'nan: Disrupt] Player-1-00000020, Tank3, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Web Reave (7)
		StartTimer: 49.0, Webs (10)
		StartTimer: 11.0, Tank Debuff (36)
		StartTimer: 22.3, Rolling Acid (10)
		StartTimer: 21.3, Infested Spawn (10)
		StartTimer: 14.7, Spinneret's Strands (10)
		StartTimer: 33.2, Erosive Spray (14)
		StartTimer: 86.3, Movement (7)
	[609.76] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Web Reave! (7)
		PlaySound: VoicePack/gathershare
	[617.16] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 14.8, Tank Debuff (37)
	[620.88] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (10)
	[628.44] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Rolling Acid incoming debuff (10)
	[631.96] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		StartTimer: 23.1, Tank Debuff (38)
	[639.39] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Erosive Spray (14)
		StartTimer: 44.4, Erosive Spray (15)
	[660.06] ENCOUNTER_END: 2918, Rasha'nan, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
]]
