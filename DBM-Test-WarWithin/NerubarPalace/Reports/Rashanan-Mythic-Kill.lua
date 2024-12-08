DBM.Test:Report[[
Test: TWW/NerubarPalace/Rashanan/Mythic/Kill
Mod:  DBM-Raids-WarWithin/2609

Findings:
	Unused event registration: SPELL_CAST_START 456762 (Caustic Hail)
	Unused event registration: SPELL_CAST_START 456853 (Caustic Hail)
	Timer for spell ID 334371 (Movement) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 334371 (Movement) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)
	SpecialWarning for spell ID 421532 (Smoldering Ground) is triggered by event SPELL_AURA_APPLIED 439776 (Acid Pools)
	Timer for spell ID 439784 (Spinneret's Strands) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439784 (Spinneret's Strands) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)
	Timer for spell ID 439789 (Rolling Acid) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439789 (Rolling Acid) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)
	Timer for spell ID 439795 (Web Reave) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439795 (Web Reave) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)
	Timer for spell ID 439811 (Erosive Spray) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 439811 (Erosive Spray) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)
	Timer for spell ID 444687 (Savage Assault) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 444687 (Savage Assault) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)
	Timer for spell ID 454989 (Enveloping Webs) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 454989 (Enveloping Webs) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)
	Timer for spell ID 455373 (Infested Spawn) is triggered by event SPELL_INTERRUPT 183752 (Disrupt)
	Timer for spell ID 455373 (Infested Spawn) is triggered by event SPELL_INTERRUPT 2139 (Counterspell)

Unused objects:
	[Special Warning] Savage Assault - defensive, type=defensive, spellId=444687
	[Special Warning] Savage Assault on >%s< - taunt now, type=taunt, spellId=444687
	[Special Warning] Acidic Eruption - interrupt >%s<!, type=interrupt, spellId=452806

Timers:
	Movement (%s), time=49.00, type=stagecontextcount, spellId=334371, triggerDeltas = 0.00, 62.84, 65.77, 66.81, 65.65, 65.66
		[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 4x, delta times: 128.61, 66.81, 65.65, 65.66
	Spinneret's Strands (%s), time=33.90, type=cdcount, spellId=439784, triggerDeltas = 0.00, 62.84, 65.77, 18.64, 48.17, 131.31
		[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 3x, delta times: 128.61, 66.81, 131.31
		[147.25] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
	Toxic Waves (%s), time=21.30, type=cdcount, spellId=439789, triggerDeltas = 0.00, 62.84, 65.77, 132.46
		[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 2x, delta times: 128.61, 132.46
	Soak (%s), time=49.00, type=cdcount, spellId=439795, triggerDeltas = 62.84, 65.77, 66.81, 65.65, 65.66
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 4x, delta times: 128.61, 66.81, 65.65, 65.66
	Spray (%s), time=49.00, type=cdcount, spellId=439811, triggerDeltas = 0.00, 8.10, 54.74, 23.62, 42.15, 23.65, 43.16, 23.64, 42.01, 23.64
		[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		[  8.10] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
			 Triggered 5x, delta times: 8.10, 78.36, 65.80, 66.80, 65.65
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 3x, delta times: 128.61, 66.81, 65.65
	Tank Debuff (%s), time=49.00, type=cdcount, spellId=444687, triggerDeltas = 0.00, 5.52, 22.58, 2.02, 12.93, 19.79, 9.76, 2.01, 17.98, 2.00, 11.87, 22.15, 9.76, 2.03, 17.99, 2.00, 11.84, 23.19, 9.74, 2.01, 18.01, 2.01, 11.85, 22.03, 9.77, 2.02, 18.09, 2.00, 11.74, 22.04, 9.77, 2.02
		[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		[  5.52] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
			 Triggered 26x, delta times: 5.52, 22.58, 2.02, 12.93, 29.55, 2.01, 17.98, 2.00, 11.87, 31.91, 2.03, 17.99, 2.00, 11.84, 32.93, 2.01, 18.01, 2.01, 11.85, 31.80, 2.02, 18.09, 2.00, 11.74, 31.81, 2.02
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 4x, delta times: 128.61, 66.81, 65.65, 65.66
	Webs (%s), time=49.00, type=cdcount, spellId=454989, triggerDeltas = 0.00, 62.84, 65.77, 66.81, 65.65, 65.66
		[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 4x, delta times: 128.61, 66.81, 65.65, 65.66
	Adds (%s), time=21.30, type=cdcount, spellId=455373, triggerDeltas = 0.00, 62.84, 132.58, 14.31, 51.34, 14.33, 51.33
		[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		[195.42] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
			 Triggered 3x, delta times: 195.42, 65.65, 65.66
		[209.73] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
			 Triggered 2x, delta times: 209.73, 65.67

Announces:
	Spinneret's Strands incoming debuff (%s), type=incomingcount, spellId=439784, triggerDeltas = 14.15, 82.52, 50.58, 15.19, 51.62
		[ 14.15] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
			 Triggered 5x, delta times: 14.15, 82.52, 50.58, 15.19, 51.62
	Toxic Waves incoming debuff (%s), type=incomingcount, spellId=439789, triggerDeltas = 35.06, 68.39, 41.00, 137.28
		[ 35.06] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
			 Triggered 4x, delta times: 35.06, 68.39, 41.00, 137.28
	Spray (%s), type=count, spellId=439811, triggerDeltas = 8.10, 40.01, 38.35, 25.01, 40.79, 25.00, 41.80, 25.03, 40.62, 25.02
		[  8.10] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
			 Triggered 10x, delta times: 8.10, 40.01, 38.35, 25.01, 40.79, 25.00, 41.80, 25.03, 40.62, 25.02
	Casting Acidic Eruption: 2.5 sec, type=cast, spellId=452806, triggerDeltas = 62.09, 64.41, 66.90, 65.70, 65.57
		[ 62.09] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
			 Triggered 5x, delta times: 62.09, 64.41, 66.90, 65.70, 65.57
	Infested Spawn incoming debuff (%s), type=incomingcount, spellId=455373, triggerDeltas = 18.71, 58.47, 132.55, 20.04, 45.63, 24.83
		[ 18.71] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
			 Triggered 6x, delta times: 18.71, 58.47, 132.55, 20.04, 45.63, 24.83
	Savage Wound on >%s< (%d), type=stack, spellId=458067, triggerDeltas = 7.10, 22.53, 2.04, 12.95, 2.47, 27.05, 2.02, 17.98, 2.00, 11.86, 3.00, 28.91, 2.01, 18.04, 2.00, 11.98, 2.35, 30.42, 2.01, 18.02, 2.00, 11.87, 2.50, 29.28, 2.01, 18.08, 2.01, 11.78, 2.52, 29.26
		[  7.10] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
			 Triggered 12x, delta times: 7.10, 24.57, 15.42, 27.05, 20.00, 45.77, 22.05, 46.76, 31.89, 31.78, 22.10, 14.30
		[ 29.63] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
			 Triggered 13x, delta times: 29.63, 14.99, 31.54, 31.84, 33.92, 18.04, 16.33, 30.42, 20.03, 16.37, 49.37, 13.79, 31.78
		[ 96.14] SPELL_AURA_APPLIED_DOSE: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 2, 0
			 Triggered 3x, delta times: 96.14, 77.80, 100.46
		[111.00] SPELL_AURA_APPLIED_DOSE: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 2, 0
			 Triggered 2x, delta times: 111.00, 117.74

Special warnings:
	%s damage - move away, type=gtfo, spellId=421532, triggerDeltas = 65.36, 62.09, 60.36, 4.02, 66.38, 39.57, 24.88, 4.87
		[ 65.36] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
			 Triggered 8x, delta times: 65.36, 62.09, 60.36, 4.02, 66.38, 39.57, 24.88, 4.87
	Soak! (%s), type=count, spellId=439795, triggerDeltas = 66.45, 65.80, 66.80, 65.66, 65.66
		[ 66.45] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
			 Triggered 5x, delta times: 66.45, 65.80, 66.80, 65.66, 65.66
	Webs (%s) - dodge attack, type=dodgecount, spellId=454989, triggerDeltas = 38.05, 43.39, 85.80, 66.83, 60.94
		[ 38.05] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
			 Triggered 5x, delta times: 38.05, 43.39, 85.80, 66.83, 60.94

Yells:
	None

Voice pack sounds:
	VoicePack/gathershare
		[ 66.45] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
			 Triggered 5x, delta times: 66.45, 65.80, 66.80, 65.66, 65.66
	VoicePack/watchfeet
		[ 65.36] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
			 Triggered 8x, delta times: 65.36, 62.09, 60.36, 4.02, 66.38, 39.57, 24.88, 4.87
	VoicePack/watchstep
		[ 38.05] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
			 Triggered 5x, delta times: 38.05, 43.39, 85.80, 66.83, 60.94

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2918, Rasha'nan, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 444687 439789 455373 439784 439795 439811 454989 452806 456853 456762, SPELL_AURA_APPLIED 458067 439776, SPELL_AURA_APPLIED_DOSE 458067, SPELL_INTERRUPT, SPELL_PERIODIC_DAMAGE 439776, SPELL_PERIODIC_MISSED 439776
		StartTimer: 38.0, Webs (1)
		StartTimer: 5.5, Tank Debuff (1)
		StartTimer: 33.0, Toxic Waves (1)
		StartTimer: 18.7, Adds (1)
		StartTimer: 14.2, Spinneret's Strands (1)
		StartTimer: 8.1, Spray (1)
		StartTimer: 56.3, Movement (1)
	[  5.52] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 5.82 (+0.30)
		StartTimer: 22.5, Tank Debuff (2)
	[  7.10] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[  8.10] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (1)
		StartTimer: 40.0, Spray (2)
	[ 14.15] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (1)
	[ 18.71] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (1)
	[ 28.10] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 28.40 (+0.30)
		StartTimer: 2.0, Tank Debuff (3)
	[ 29.63] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[ 30.12] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 30.42 (+0.30)
		StartTimer: 12.9, Tank Debuff (4)
	[ 31.67] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[ 35.06] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Toxic Waves incoming debuff (1)
	[ 38.05] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 43.05] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 43.35 (+0.30)
		StartTimer: 2.5, Tank Debuff (5)
	[ 44.62] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[ 45.55] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 45.85 (+0.30)
	[ 47.09] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[ 48.11] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (2)
	[ 62.09] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[ 62.84] SPELL_INTERRUPT: [Dps6->Rasha'nan: Counterspell] Player-1-00000006, Dps6, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 2139, Counterspell, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Soak (1)
		StartTimer: 18.6, Webs (2)
		StartTimer: 9.7, Tank Debuff (6)
		StartTimer: 38.0, Toxic Waves (2)
		StartTimer: 14.3, Adds (2)
		StartTimer: 33.8, Spinneret's Strands (2)
		StartTimer: 23.6, Spray (3)
		StartTimer: 57.2, Movement (2)
	[ 65.36] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[ 66.45] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Soak! (1)
		PlaySound: VoicePack/gathershare
	[ 72.60] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 72.90 (+0.30)
		StartTimer: 2.0, Tank Debuff (7)
	[ 74.14] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[ 74.61] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 74.91 (+0.30)
		StartTimer: 18.0, Tank Debuff (8)
	[ 76.16] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[ 77.18] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (2)
	[ 81.44] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowSpecialWarning: Webs (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 86.46] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (3)
		StartTimer: 25.0, Spray (4)
	[ 92.59] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 92.89 (+0.30)
		StartTimer: 2.0, Tank Debuff (9)
	[ 94.14] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[ 94.59] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 94.89 (+0.30)
		StartTimer: 11.4, Tank Debuff (10)
	[ 96.14] SPELL_AURA_APPLIED_DOSE: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 2, 0
		ShowAnnounce: Savage Wound on PlayerName (2)
	[ 96.67] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (2)
	[103.45] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Toxic Waves incoming debuff (2)
	[106.46] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 106.76 (+0.30)
		StartTimer: 2.5, Tank Debuff (11)
	[108.00] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[108.95] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 109.25 (+0.30)
	[111.00] SPELL_AURA_APPLIED_DOSE: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 2, 0
		ShowAnnounce: Savage Wound on Tank1 (2)
	[111.47] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (4)
	[126.50] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[127.45] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[128.61] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Soak (2)
		StartTimer: 38.6, Webs (3)
		StartTimer: 9.7, Tank Debuff (12)
		StartTimer: 13.8, Toxic Waves (3)
		StartTimer: 18.6, Spinneret's Strands (3)
		StartTimer: 23.6, Spray (5)
		StartTimer: 57.2, Movement (3)
	[132.25] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Soak! (2)
		PlaySound: VoicePack/gathershare
	[138.37] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 138.67 (+0.30)
		StartTimer: 2.0, Tank Debuff (13)
	[139.91] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[140.40] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 140.70 (+0.30)
		StartTimer: 18.0, Tank Debuff (14)
	[141.92] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[144.45] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Toxic Waves incoming debuff (3)
	[147.25] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (3)
		StartTimer: 15.1, Spinneret's Strands (4)
	[152.26] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (5)
		StartTimer: 25.0, Spray (6)
	[158.39] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 158.69 (+0.30)
		StartTimer: 2.0, Tank Debuff (15)
	[159.96] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[160.39] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 160.69 (+0.30)
		StartTimer: 11.8, Tank Debuff (16)
	[161.96] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[162.44] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (4)
	[167.24] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowSpecialWarning: Webs (3) - dodge attack
		PlaySound: VoicePack/watchstep
	[172.23] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 172.53 (+0.30)
		StartTimer: 2.5, Tank Debuff (17)
	[173.94] SPELL_AURA_APPLIED_DOSE: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 2, 0
		ShowAnnounce: Savage Wound on PlayerName (2)
	[174.74] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 175.04 (+0.30)
	[176.29] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[177.26] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (6)
	[187.81] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
			Filtered: 2x SPELL_AURA_APPLIED at 188.37, 188.98
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[191.83] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
			Filtered: 1x SPELL_AURA_APPLIED at 193.07
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[193.40] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[195.42] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Soak (3)
		StartTimer: 38.6, Webs (4)
		StartTimer: 9.7, Tank Debuff (18)
		StartTimer: 14.3, Adds (3)
		StartTimer: 18.6, Spinneret's Strands (5)
		StartTimer: 23.6, Spray (7)
		StartTimer: 57.2, Movement (4)
	[199.05] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Soak! (3)
		PlaySound: VoicePack/gathershare
	[205.16] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 205.46 (+0.30)
		StartTimer: 2.0, Tank Debuff (19)
	[206.71] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[207.17] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 207.47 (+0.30)
		StartTimer: 18.0, Tank Debuff (20)
	[208.72] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[209.73] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (3)
		StartTimer: 20.0, Adds (4)
	[214.06] SPELL_CAST_START: [Rasha'nan: Spinneret's Strands] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439784, Spinneret's Strands, 0, 0
		ShowAnnounce: Spinneret's Strands incoming debuff (5)
	[219.06] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (7)
		StartTimer: 25.0, Spray (8)
	[225.18] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 225.48 (+0.30)
		StartTimer: 2.0, Tank Debuff (21)
	[226.74] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[227.19] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 227.49 (+0.30)
		StartTimer: 11.8, Tank Debuff (22)
	[228.74] SPELL_AURA_APPLIED_DOSE: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 2, 0
		ShowAnnounce: Savage Wound on Tank1 (2)
	[229.77] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (4)
	[234.07] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowSpecialWarning: Webs (4) - dodge attack
		PlaySound: VoicePack/watchstep
	[239.04] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 239.34 (+0.30)
		StartTimer: 2.5, Tank Debuff (23)
	[240.61] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[241.55] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 241.85 (+0.30)
	[243.11] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[244.09] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (8)
	[258.21] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[259.10] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[261.07] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Soak (4)
		StartTimer: 33.8, Webs (5)
		StartTimer: 9.7, Tank Debuff (24)
		StartTimer: 18.6, Toxic Waves (4)
		StartTimer: 14.4, Adds (5)
		StartTimer: 23.6, Spray (9)
		StartTimer: 57.2, Movement (5)
	[264.71] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Soak! (4)
		PlaySound: VoicePack/gathershare
	[270.84] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 271.14 (+0.30)
		StartTimer: 2.0, Tank Debuff (25)
	[272.39] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[272.86] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 273.16 (+0.30)
		StartTimer: 18.0, Tank Debuff (26)
	[274.40] SPELL_AURA_APPLIED_DOSE: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 2, 0
		ShowAnnounce: Savage Wound on PlayerName (2)
	[275.40] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (5)
		StartTimer: 24.7, Adds (6)
	[281.73] SPELL_CAST_START: [Rasha'nan: Rolling Acid] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439789, Rolling Acid, 0, 0
		ShowAnnounce: Toxic Waves incoming debuff (4)
	[284.71] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (9)
		StartTimer: 25.0, Spray (10)
	[290.95] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 291.25 (+0.30)
		StartTimer: 2.0, Tank Debuff (27)
	[292.48] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[292.95] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 293.25 (+0.30)
		StartTimer: 11.8, Tank Debuff (28)
	[294.49] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[295.01] SPELL_CAST_START: [Rasha'nan: Enveloping Webs] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 454989, Enveloping Webs, 0, 0
		ShowSpecialWarning: Webs (5) - dodge attack
		PlaySound: VoicePack/watchstep
	[297.78] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
			Filtered: 1x SPELL_AURA_APPLIED at 299.56
			Filtered: 2x SPELL_PERIODIC_DAMAGE at 300.06, 300.56
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[300.23] SPELL_CAST_START: [Rasha'nan: Infested Spawn] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 455373, Infested Spawn, 0, 0
		ShowAnnounce: Infested Spawn incoming debuff (6)
	[304.69] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 304.99 (+0.30)
		StartTimer: 2.5, Tank Debuff (29)
	[306.27] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[307.22] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 307.52 (+0.30)
	[308.79] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on PlayerName (1)
	[309.73] SPELL_CAST_START: [Rasha'nan: Erosive Spray] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439811, Erosive Spray, 0, 0
		ShowAnnounce: Spray (10)
	[322.66] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
			Filtered: 2x SPELL_AURA_APPLIED at 323.34, 324.51
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[324.67] SPELL_CAST_START: [Rasha'nan: Acidic Eruption] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 452806, Acidic Eruption, 0, 0
		ShowAnnounce: Casting Acidic Eruption: 2.5 sec
	[326.73] SPELL_INTERRUPT: [Dps13->Rasha'nan: Disrupt] Player-1-00000013, Dps13, 0x512, Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, 183752, Disrupt, 0, 452806, Acidic Eruption, 0
		StartTimer: 3.6, Soak (5)
		StartTimer: 38.6, Webs (6)
		StartTimer: 9.7, Tank Debuff (30)
		StartTimer: 19.1, Adds (7)
		StartTimer: 13.8, Spinneret's Strands (6)
		StartTimer: 57.2, Movement (6)
	[327.53] SPELL_AURA_APPLIED: [Rasha'nan->Dps17: Acid Pools] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000017, Dps17, 0x511, 439776, Acid Pools, 0, DEBUFF, 0
		AntiSpam: 1
			Filtered: 1x SPELL_PERIODIC_MISSED at 328.04
		ShowSpecialWarning: Acid Pools damage - move away
		PlaySound: VoicePack/watchfeet
	[330.37] SPELL_CAST_START: [Rasha'nan: Web Reave] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 439795, Web Reave, 0, 0
		ShowSpecialWarning: Soak! (5)
		PlaySound: VoicePack/gathershare
	[336.50] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 336.80 (+0.30)
		StartTimer: 2.0, Tank Debuff (31)
	[338.05] SPELL_AURA_APPLIED: [Rasha'nan->Tank1: Savage Wound] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, Player-1-00000018, Tank1, 0x512, 458067, Savage Wound, 0, DEBUFF, 0
		ShowAnnounce: Savage Wound on Tank1 (1)
	[338.52] SPELL_CAST_START: [Rasha'nan: Savage Assault] Creature-0-1-2657-1-214504-0000000001, Rasha'nan, 0xa48, "", nil, 0x0, 444687, Savage Assault, 0, 0
		ScheduleTask: (anonymous function) at 338.82 (+0.30)
		StartTimer: 18.0, Tank Debuff (32)
	[339.04] ENCOUNTER_END: 2918, Rasha'nan, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
]]
