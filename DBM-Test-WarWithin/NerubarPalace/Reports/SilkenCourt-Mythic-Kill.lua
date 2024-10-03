DBM.Test:Report[[
Test: TWW/NerubarPalace/SilkenCourt/Mythic/Kill
Mod:  DBM-Raids-WarWithin/2608

Findings:
	Unused event registration: SPELL_AURA_APPLIED 438200 (Poison Bolt)
	Unused event registration: SPELL_AURA_APPLIED 443598 (Uncontrollable Rage)
	Unused event registration: SPELL_AURA_APPLIED 449857 (Impaled)
	Unused event registration: SPELL_AURA_APPLIED 450980 (Shatter Existence)
	Unused event registration: SPELL_AURA_APPLIED 451277 (Spike Storm)
	Unused event registration: SPELL_AURA_APPLIED 455080 (Scarab Lord's Perseverance)
	Unused event registration: SPELL_AURA_APPLIED 455850 (Mark of Rage)
	Unused event registration: SPELL_AURA_APPLIED 456235 (Stinging Delirium)
	Unused event registration: SPELL_AURA_APPLIED 456245 (Stinging Delirium)
	Unused event registration: SPELL_AURA_APPLIED 456252 (Stinging Swarm)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 438218 (Piercing Strike)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 456252 (Stinging Swarm)
	Unused event registration: SPELL_AURA_REMOVED 455080 (Scarab Lord's Perseverance)
	Unused event registration: SPELL_AURA_REMOVED 456252 (Stinging Swarm)
	Unused event registration: SPELL_CAST_START 452231 (Stinging Swarm)
	Unused event registration: SPELL_CAST_START 456174 (Burrow)
	Timer for spell ID 438218 (Piercing Strike) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 438218 (Piercing Strike) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 438355 (Cataclysmic Entropy) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 438355 (Cataclysmic Entropy) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	SpecialWarning for spell ID 438656 (Venomous Rain) is triggered by event SPELL_CAST_START 438343 (Venomous Rain)
	Timer for spell ID 438656 (Venomous Rain) is triggered by event SPELL_CAST_START 438343 (Venomous Rain)
	Timer for spell ID 438677 (Stinging Swarm) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 438677 (Stinging Swarm) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 438801 (Call of the Swarm) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 440246 (Reckless Charge) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 440504 (Impaling Eruption) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 441626 (Web Vortex) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 441626 (Web Vortex) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 441782 (Strands of Reality) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 441782 (Strands of Reality) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 442994 (Unleashed Swarm) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 443068 (Spike Eruption) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 450129 (Entropic Desolation) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 450129 (Entropic Desolation) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 450483 (Void Step) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 450483 (Void Step) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	Timer for spell ID 451277 (Spike Storm) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)

Unused objects:
	[Announce] Impaled on >%s<, type=target, spellId=449857
	[Announce] Stinging Delirium on >%s<, type=target, spellId=456245
	[Announce] Stinging Swarm on >%s< (%d), type=stack, spellId=456252
	[Special Warning] Piercing Strike - defensive, type=defensive, spellId=438218
	[Special Warning] Stinging Swarm - move to >%s<, type=moveto, spellId=438677
	[Special Warning] Uncontrollable Rage on >%s< - dispel now, type=dispel, spellId=443598
	[Special Warning] Mark of Rage on you, type=you, spellId=455850
	[Yell] Stinging Swarm, type=shortyell, spellId=438677
	[Yell] Impaled, type=shortyell, spellId=449857

Timers:
	Piercing Strike (%s), time=49.00, type=cdcount, spellId=438218, triggerDeltas = 0.00, 13.08, 20.00, 27.01, 19.98, 106.21, 16.07, 19.99, 24.98, 15.02, 21.96, 73.51, 20.05, 17.01, 31.97, 20.01, 21.00, 20.01
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 13.08] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
			 Triggered 15x, delta times: 13.08, 20.00, 27.01, 19.98, 122.28, 19.99, 24.98, 15.02, 21.96, 93.56, 17.01, 31.97, 20.01, 21.00, 20.01
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Massive Explosion (%s), time=49.00, type=cdcount, spellId=438355, triggerDeltas = 186.28, 41.80, 129.73, 92.70
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[228.08] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
			 Triggered 2x, delta times: 228.08, 222.43
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Rain (%s), time=49.00, type=cdcount, spellId=438656, triggerDeltas = 0.00, 18.29, 33.50
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 18.29] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
			 Triggered 2x, delta times: 18.29, 33.50
	Dispels (%s), time=49.00, type=cdcount, spellId=438677, triggerDeltas = 186.28, 25.04, 146.49, 81.03
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[211.32] SPELL_CAST_START: [Anub'arash: Stinging Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438677, Stinging Swarm, 0, 0
			 Triggered 2x, delta times: 211.32, 227.52
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Adds (%s), time=49.00, type=cdcount, spellId=438801, triggerDeltas = 0.00, 23.09, 163.19, 28.04
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 23.09] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
			 Triggered 2x, delta times: 23.09, 191.23
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
	Web Bomb (%s), time=49.00, type=cdcount, spellId=439838, triggerDeltas = 0.00, 15.24
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 15.24] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
	Charge, time=49.00, type=cast, spellId=440246, triggerDeltas = 38.48, 59.93, 306.15, 97.31
		[ 38.48] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
			 Triggered 4x, delta times: 38.48, 59.93, 306.15, 97.31
		[133.35] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
	Charge (%s), time=49.00, type=cdcount, spellId=440246, triggerDeltas = 0.00, 38.48, 319.33, 46.75
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 38.48] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
			 Triggered 2x, delta times: 38.48, 366.08
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Frontal [B-Anub] (%s), time=49.00, type=cdcount, spellId=440504, triggerDeltas = 0.00, 8.08, 20.00, 33.99, 124.21, 11.02, 30.01, 30.04
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[  8.08] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 6x, delta times: 8.08, 20.00, 33.99, 135.23, 30.01, 30.04
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
	Web Vortex (%s), time=49.00, type=cdcount, spellId=441626, triggerDeltas = 186.28, 20.25, 2.52, 53.18, 95.58, 33.34, 2.51, 31.21, 2.50, 61.37
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[206.53] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
			 Triggered 8x, delta times: 206.53, 2.52, 53.18, 128.92, 2.51, 31.21, 2.50, 61.37
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Frontal [R-Takazj] (%s), time=49.00, type=cdcount, spellId=441782, triggerDeltas = 186.28, 32.12, 35.96, 103.45, 22.38, 33.58, 24.93
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[218.40] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
			 Triggered 5x, delta times: 218.40, 35.96, 125.83, 33.58, 24.93
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Burrow (%s), time=49.00, type=cdcount, spellId=441791, triggerDeltas = 0.00, 35.07
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 35.07] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
	Swarm (%s), time=49.00, type=cdcount, spellId=442994, triggerDeltas = 357.81, 23.05, 75.01, 70.00
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
		[380.86] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
			 Triggered 3x, delta times: 380.86, 75.01, 70.00
	Spikes (%s), time=49.00, type=cdcount, spellId=443068, triggerDeltas = 357.81, 40.05, 30.99
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
		[397.86] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
			 Triggered 2x, delta times: 397.86, 30.99
	Leap (%s), time=49.00, type=cdcount, spellId=450045, triggerDeltas = 0.00, 42.10
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 42.10] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
	Run away! (%s), time=49.00, type=cdcount, spellId=450129, triggerDeltas = 186.28, 25.53, 146.00, 38.62, 33.72
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[211.81] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
			 Triggered 3x, delta times: 211.81, 184.62, 33.72
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Teleport (%s), time=49.00, type=cdcount, spellId=450483, triggerDeltas = 186.28, 38.78, 34.16, 23.60, 74.99, 51.30, 38.41, 29.14, 30.09
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[225.06] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
			 Triggered 7x, delta times: 225.06, 34.16, 23.60, 126.29, 38.41, 29.14, 30.09
		[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Intermission %s, time=100.00, type=intermissioncount, spellId=450483, triggerDeltas = 0.00
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
	Intermission %s, time=100.00, type=intermissioncount, spellId=451277, triggerDeltas = 186.28
		[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0

Announces:
	Poison Bolt on >%s< (%d), type=stack, spellId=438200, triggerDeltas = 25.67, 12.19, 23.59, 8.83
		[ 25.67] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Dps15: Poison Bolt] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000018, Dps15, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
			 Triggered 4x, delta times: 25.67, 12.19, 23.59, 8.83
	Piercing Strike on >%s< (%d), type=stack, spellId=438218, triggerDeltas = 34.61, 46.98, 39.99, 102.29, 39.99, 45.00, 87.52, 51.97, 41.04
		[ 34.61] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
			 Triggered 9x, delta times: 34.61, 46.98, 39.99, 102.29, 39.99, 45.00, 87.52, 51.97, 41.04
	Stinging Swarm on >%s<, type=target, spellId=438677, triggerDeltas = 214.93, 58.36, 6.74, 161.72, 1.03, 56.79
		[214.93] Scheduled at 214.43 by SPELL_AURA_APPLIED: [->Dps2: Stinging Swarm] "", nil, 0x0, Player-1-00000002, Dps2, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		[273.29] Scheduled at 272.79 by SPELL_AURA_APPLIED: [->Dps8: Stinging Swarm] "", nil, 0x0, Player-1-00000009, Dps8, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		[280.03] Scheduled at 279.53 by SPELL_AURA_APPLIED: [->Dps10: Stinging Swarm] "", nil, 0x0, Player-1-00000011, Dps10, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		[441.75] Scheduled at 441.25 by SPELL_AURA_APPLIED: [->Dps10: Stinging Swarm] "", nil, 0x0, Player-1-00000011, Dps10, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		[442.78] Scheduled at 442.28 by SPELL_AURA_APPLIED: [->Dps1: Stinging Swarm] "", nil, 0x0, Player-1-00000001, Dps1, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		[499.57] Scheduled at 499.07 by SPELL_AURA_APPLIED: [->Dps16: Stinging Swarm] "", nil, 0x0, Player-1-00000019, Dps16, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
	Adds (%s), type=count, spellId=438801, triggerDeltas = 23.09, 53.00, 138.23, 61.01
		[ 23.09] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
			 Triggered 4x, delta times: 23.09, 53.00, 138.23, 61.01
	Web Bomb (%s), type=count, spellId=439838, triggerDeltas = 15.24, 70.49
		[ 15.24] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
			 Triggered 2x, delta times: 15.24, 70.49
	Binding Webs faded, type=fades, spellId=440001, triggerDeltas = 214.08, 52.72, 128.92, 36.67, 63.90
		[214.08] SPELL_AURA_REMOVED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
			 Triggered 5x, delta times: 214.08, 52.72, 128.92, 36.67, 63.90
	Entangled on >%s<, type=target, spellId=440179, triggerDeltas = 45.05, 59.91, 306.17, 97.26
		[ 45.05] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Entangled] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 440179, Entangled, 0, BUFF, 0
			 Triggered 4x, delta times: 45.05, 59.91, 306.17, 97.26
	Burrow (%s), type=count, spellId=441791, triggerDeltas = 35.07, 60.03, 305.73, 98.04
		[ 35.07] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
			 Triggered 4x, delta times: 35.07, 60.03, 305.73, 98.04
	Leap (%s), type=count, spellId=450045, triggerDeltas = 42.10, 60.74
		[ 42.10] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
			 Triggered 2x, delta times: 42.10, 60.74
	Casting Run away!: 4.0 sec, type=cast, spellId=450129, triggerDeltas = 211.81, 55.70, 128.92, 33.72, 63.87
		[211.81] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
			 Triggered 5x, delta times: 211.81, 55.70, 128.92, 33.72, 63.87
	Teleport (%s), type=count, spellId=450483, triggerDeltas = 225.06, 34.16, 23.60, 29.25, 97.04, 38.41, 29.14, 30.09, 2.65
		[225.06] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
			 Triggered 9x, delta times: 225.06, 34.16, 23.60, 29.25, 97.04, 38.41, 29.14, 30.09, 2.65

Special warnings:
	Piercing Strike on >%s< - taunt now, type=taunt, spellId=438218, triggerDeltas = 14.60, 47.01, 142.23, 44.99, 37.00, 93.55, 48.96, 41.02, 56.02
		[ 14.60] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
			 Triggered 9x, delta times: 14.60, 47.01, 142.23, 44.99, 37.00, 93.55, 48.96, 41.02, 56.02
	Cataclysmic Entropy! (%s), type=count, spellId=438355, triggerDeltas = 228.08, 57.72, 164.71, 61.90
		[228.08] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
			 Triggered 4x, delta times: 228.08, 57.72, 164.71, 61.90
	Rain (%s) - move away from others, type=moveawaycount, spellId=438656, triggerDeltas = 18.29, 33.50, 26.98
		[ 18.29] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
			 Triggered 3x, delta times: 18.29, 33.50, 26.98
	Binding Webs on you, type=you, spellId=440001, triggerDeltas = 208.57, 55.68, 128.95, 36.19, 63.90
		[208.57] SPELL_AURA_APPLIED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
			 Triggered 5x, delta times: 208.57, 55.68, 128.95, 36.19, 63.90
	Charge! (%s), type=count, spellId=440246, triggerDeltas = 38.48, 59.93, 306.15, 97.31
		[ 38.48] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
			 Triggered 4x, delta times: 38.48, 59.93, 306.15, 97.31
	Frontal [B-Anub] (%s) - dodge attack, type=dodgecount, spellId=440504, triggerDeltas = 8.08, 20.00, 33.99, 20.03, 115.20, 30.01, 30.04, 29.99
		[  8.08] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 8x, delta times: 8.08, 20.00, 33.99, 20.03, 115.20, 30.01, 30.04, 29.99
	Web Vortex! (%s), type=count, spellId=441626, triggerDeltas = 206.53, 2.52, 53.18, 2.52, 126.40, 2.51, 31.21, 2.50, 61.37, 2.50
		[206.53] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
			 Triggered 10x, delta times: 206.53, 2.52, 53.18, 2.52, 126.40, 2.51, 31.21, 2.50, 61.37, 2.50
	Frontal [R-Takazj] (%s) - dodge attack, type=dodgecount, spellId=441782, triggerDeltas = 218.40, 35.96, 23.42, 102.41, 33.58, 24.93, 43.02
		[218.40] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
			 Triggered 7x, delta times: 218.40, 35.96, 23.42, 102.41, 33.58, 24.93, 43.02
	Swarm! (%s), type=count, spellId=442994, triggerDeltas = 380.86, 75.01, 70.00
		[380.86] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
			 Triggered 3x, delta times: 380.86, 75.01, 70.00
	Spikes (%s) - dodge attack, type=dodgecount, spellId=443068, triggerDeltas = 397.86, 30.99, 64.01
		[397.86] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
			 Triggered 3x, delta times: 397.86, 30.99, 64.01
	Mark of Paranoia on you, type=you, spellId=455849, triggerDeltas = 1.60, 273.81
		[  1.60] SPELL_AURA_APPLIED: [->Dps15: Mark of Paranoia] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 455849, Mark of Paranoia, 0, DEBUFF, 0
			 Triggered 2x, delta times: 1.60, 273.81

Yells:
	None

Voice pack sounds:
	VoicePack/aesoon
		[380.86] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
			 Triggered 3x, delta times: 380.86, 75.01, 70.00
	VoicePack/chargemove
		[ 38.48] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
			 Triggered 4x, delta times: 38.48, 59.93, 306.15, 97.31
	VoicePack/frontal
		[  8.08] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 8x, delta times: 8.08, 20.00, 33.99, 20.03, 115.20, 30.01, 30.04, 29.99
		[218.40] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
			 Triggered 7x, delta times: 218.40, 35.96, 23.42, 102.41, 33.58, 24.93, 43.02
	VoicePack/lineapart
		[208.57] SPELL_AURA_APPLIED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
			 Triggered 5x, delta times: 208.57, 55.68, 128.95, 36.19, 63.90
	VoicePack/paranoiayou
		[  1.60] SPELL_AURA_APPLIED: [->Dps15: Mark of Paranoia] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 455849, Mark of Paranoia, 0, DEBUFF, 0
			 Triggered 2x, delta times: 1.60, 273.81
	VoicePack/pullin
		[206.53] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
			 Triggered 10x, delta times: 206.53, 2.52, 53.18, 2.52, 126.40, 2.51, 31.21, 2.50, 61.37, 2.50
	VoicePack/scatter
		[ 18.29] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
			 Triggered 3x, delta times: 18.29, 33.50, 26.98
	VoicePack/specialsoon
		[228.08] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
			 Triggered 4x, delta times: 228.08, 57.72, 164.71, 61.90
	VoicePack/tauntboss
		[ 14.60] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
			 Triggered 9x, delta times: 14.60, 47.01, 142.23, 44.99, 37.00, 93.55, 48.96, 41.02, 56.02
	VoicePack/watchstep
		[397.86] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
			 Triggered 3x, delta times: 397.86, 30.99, 64.01

Icons:
	Icon 6, target=Creature-0-1-2657-1-218884-00000000D1, scanMethod=nil
		[ 26.13] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000D1, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 6, target=Creature-0-1-2657-1-218884-00000000D9, scanMethod=nil
		[ 79.10] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000D9, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 6, target=Creature-0-1-2657-1-218884-00000000E4, scanMethod=nil
		[217.32] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000E4, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 6, target=Creature-0-1-2657-1-218884-00000000EA, scanMethod=nil
		[278.36] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000EA, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-00000000A5, scanMethod=nil
		[ 26.13] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000A5, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-00000000AC, scanMethod=nil
		[ 79.10] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000AC, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-00000000B8, scanMethod=nil
		[217.32] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000B8, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-00000000BD, scanMethod=nil
		[278.35] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000BD, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-000000000F, scanMethod=nil
		[ 26.11] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000000F, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-0000000024, scanMethod=nil
		[ 79.10] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000024, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-000000004B, scanMethod=nil
		[217.32] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000004B, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-000000005C, scanMethod=nil
		[278.35] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000005C, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0

Event trace:
	[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 438218 438801 440246 440504 438343 439838 450045 438677 452231 441626 450129 441782 450483 438355 443068 456174 442994 441791, SPELL_SUMMON 438249, SPELL_AURA_APPLIED 455849 455850 438218 455080 449857 440001 450980 438708 451277 443598 440179 456245 438200 456235 456252, SPELL_AURA_APPLIED_DOSE 438218 438200 456252, SPELL_AURA_REMOVED 455080 450980 451277 440001 456252
		StartTimer: 12.8, Piercing Strike (1)
		StartTimer: 22.8, Adds (1)
		StartTimer: 7.8, Frontal [B-Anub] (1)
		StartTimer: 38.2, Charge (1)
		StartTimer: 34.8, Burrow (1)
		StartTimer: 15.2, Rain (1)
		StartTimer: 42.0, Leap (1)
		StartTimer: 15.0, Web Bomb (1)
		StartTimer: 126.1, Intermission 1.5
	[  1.60] SPELL_AURA_APPLIED: [->Dps15: Mark of Paranoia] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 455849, Mark of Paranoia, 0, DEBUFF, 0
		ShowSpecialWarning: Mark of Paranoia on you
		PlaySound: VoicePack/paranoiayou
	[  8.08] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (1) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 20.0, Frontal [B-Anub] (2)
	[ 13.08] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (2)
	[ 14.60] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 15.24] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
		ShowAnnounce: Web Bomb (1)
		StartTimer: 70.3, Web Bomb (2)
	[ 18.29] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowSpecialWarning: Rain (1) - move away from others
		PlaySound: VoicePack/scatter
		StartTimer: 33.5, Rain (2)
	[ 23.09] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Adds (1)
		StartTimer: 53.0, Adds (2)
	[ 25.67] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Dps15: Poison Bolt] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000018, Dps15, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		ShowAnnounce: Poison Bolt on PlayerName (6)
	[ 26.11] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000000F, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-000000000F, 2, 8, 1
	[ 26.13] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000A5, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000A5, 2, 7, 1
	[ 26.13] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000D1, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000D1, 2, 6, 1
	[ 28.08] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (2) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 34.0, Frontal [B-Anub] (3)
	[ 33.08] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 27.0, Piercing Strike (3)
	[ 34.61] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[ 35.07] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (1)
		StartTimer: 60.0, Burrow (2)
	[ 37.86] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Dps15: Poison Bolt] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000018, Dps15, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		ShowAnnounce: Poison Bolt on PlayerName (6)
	[ 38.48] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Charge! (1)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
		StartTimer: 49.0, Charge
		StartTimer: 59.8, Charge (2)
	[ 42.10] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
		ShowAnnounce: Leap (1)
		StartTimer: 60.1, Leap (2)
	[ 45.05] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Entangled] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 440179, Entangled, 0, BUFF, 0
		ShowAnnounce: Entangled on Anub'arash
	[ 51.79] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowSpecialWarning: Rain (2) - move away from others
		PlaySound: VoicePack/scatter
		StartTimer: 26.8, Rain (3)
	[ 60.09] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (4)
	[ 61.45] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Dps15: Poison Bolt] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000018, Dps15, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		ShowAnnounce: Poison Bolt on PlayerName (6)
	[ 61.61] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 62.07] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (3) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 20.0, Frontal [B-Anub] (4)
	[ 70.28] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Dps15: Poison Bolt] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000018, Dps15, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		ShowAnnounce: Poison Bolt on PlayerName (6)
	[ 76.09] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Adds (2)
	[ 78.77] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowSpecialWarning: Rain (3) - move away from others
		PlaySound: VoicePack/scatter
	[ 79.10] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000024, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000024, 2, 8, 1
	[ 79.10] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000AC, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000AC, 2, 7, 1
	[ 79.10] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000D9, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000D9, 2, 6, 1
	[ 80.07] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 40.0, Piercing Strike (5)
	[ 81.59] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[ 82.10] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (4) - dodge attack
		PlaySound: VoicePack/frontal
	[ 85.73] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
		ShowAnnounce: Web Bomb (2)
	[ 95.10] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (2)
	[ 98.41] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Charge! (2)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
		StartTimer: 49.0, Charge
	[102.84] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
		ShowAnnounce: Leap (2)
	[104.96] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Entangled] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 440179, Entangled, 0, BUFF, 0
		ShowAnnounce: Entangled on Anub'arash
	[121.58] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[133.35] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		StopTimer: Timer440246cast
	[186.28] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		StartTimer: 11.0, Frontal [B-Anub] (1)
		StartTimer: 16.0, Piercing Strike (1)
		StartTimer: 28.0, Adds (1)
		StartTimer: 25.0, Dispels (1)
		StartTimer: 32.1, Frontal [R-Takazj] (1)
		StartTimer: 38.7, Teleport (1)
		StartTimer: 20.2, Web Vortex (1)
		StartTimer: 25.5, Run away! (1)
		StartTimer: 41.8, Massive Explosion (1)
		StartTimer: 132.0, Intermission 2.5
	[197.30] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (1) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 30.0, Frontal [B-Anub] (2)
	[202.35] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (2)
	[203.84] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[206.53] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		ShowSpecialWarning: Web Vortex! (1)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (2)
		ScheduleTask: (anonymous function) at 217.03 (+10.50)
			Unscheduled by SPELL_CAST_START at 209.05
	[208.57] SPELL_AURA_APPLIED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Binding Webs on you
		PlaySound: VoicePack/lineapart
	[209.05] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 206.53
		ShowSpecialWarning: Web Vortex! (2)
		PlaySound: VoicePack/pullin
		StartTimer: 53.3, Web Vortex (3)
		ScheduleTask: (anonymous function) at 270.35 (+61.30)
			Unscheduled by SPELL_CAST_START at 262.23
	[211.32] SPELL_CAST_START: [Anub'arash: Stinging Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438677, Stinging Swarm, 0, 0
		StartTimer: 58.0, Dispels (2)
	[211.81] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		ShowAnnounce: Casting Run away!: 4.0 sec
		StartTimer: 55.8, Run away! (2)
		ScheduleTask: (anonymous function) at 275.61 (+63.80)
			Unscheduled by SPELL_CAST_START at 267.51
	[214.08] SPELL_AURA_REMOVED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		ShowAnnounce: Binding Webs faded
	[214.32] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Adds (1)
		StartTimer: 61.0, Adds (2)
	[214.43] SPELL_AURA_APPLIED: [->Dps2: Stinging Swarm] "", nil, 0x0, Player-1-00000002, Dps2, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce438677target:CombinedShow("Dps2") at 214.93 (+0.50)
			ShowAnnounce: Stinging Swarm on Dps16, Dps12, Dps14, Dps7, Dps2
	[217.32] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000004B, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-000000004B, 2, 8, 1
	[217.32] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000B8, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000B8, 2, 7, 1
	[217.32] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000E4, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000E4, 2, 6, 1
	[218.40] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Frontal [R-Takazj] (1) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 35.9, Frontal [R-Takazj] (2)
	[222.34] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 25.0, Piercing Strike (3)
	[223.87] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[225.06] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (1)
		StartTimer: 34.3, Teleport (2)
	[227.31] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (2) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 30.0, Frontal [B-Anub] (3)
	[228.08] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		ShowSpecialWarning: Cataclysmic Entropy! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 57.9, Massive Explosion (2)
		ScheduleTask: (anonymous function) at 293.98 (+65.90)
			Unscheduled by SPELL_CAST_START at 285.80
	[247.32] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 15.0, Piercing Strike (4)
	[248.83] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[254.36] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Frontal [R-Takazj] (2) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 23.9, Frontal [R-Takazj] (3)
	[257.35] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (3) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 30.0, Frontal [B-Anub] (4)
	[259.22] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (2)
		StartTimer: 23.6, Teleport (3)
	[262.23] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 209.05
		ShowSpecialWarning: Web Vortex! (3)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (4)
		ScheduleTask: (anonymous function) at 272.73 (+10.50)
			Unscheduled by SPELL_CAST_START at 264.75
	[262.34] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (5)
	[263.86] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[264.25] SPELL_AURA_APPLIED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Binding Webs on you
		PlaySound: VoicePack/lineapart
	[264.75] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 262.23
		ShowSpecialWarning: Web Vortex! (4)
		PlaySound: VoicePack/pullin
	[266.80] SPELL_AURA_REMOVED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		ShowAnnounce: Binding Webs faded
	[267.51] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.81
		ShowAnnounce: Casting Run away!: 4.0 sec
	[272.79] SPELL_AURA_APPLIED: [->Dps8: Stinging Swarm] "", nil, 0x0, Player-1-00000009, Dps8, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce438677target:CombinedShow("Dps8") at 273.29 (+0.50)
			ShowAnnounce: Stinging Swarm on Dps12, Dps7, Dps3, Dps9, Dps8
	[275.33] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Adds (2)
	[275.41] SPELL_AURA_APPLIED: [->Dps15: Mark of Paranoia] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 455849, Mark of Paranoia, 0, DEBUFF, 0
		ShowSpecialWarning: Mark of Paranoia on you
		PlaySound: VoicePack/paranoiayou
	[277.78] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Frontal [R-Takazj] (3) - dodge attack
		PlaySound: VoicePack/frontal
	[278.35] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000005C, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-000000005C, 2, 8, 1
	[278.35] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000BD, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000BD, 2, 7, 1
	[278.36] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000EA, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000EA, 2, 6, 1
	[279.53] SPELL_AURA_APPLIED: [->Dps10: Stinging Swarm] "", nil, 0x0, Player-1-00000011, Dps10, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce438677target:CombinedShow("Dps10") at 280.03 (+0.50)
			ShowAnnounce: Stinging Swarm on Dps10
	[282.82] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (3)
		StartTimer: 29.2, Teleport (4)
	[284.30] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 25.0, Piercing Strike (6)
	[285.80] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 228.08
		ShowSpecialWarning: Cataclysmic Entropy! (2)
		PlaySound: VoicePack/specialsoon
	[285.83] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[287.34] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Frontal [B-Anub] (4) - dodge attack
		PlaySound: VoicePack/frontal
	[308.86] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[312.07] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (4)
	[357.81] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
		StartTimer: 40.0, Spikes (1)
		StartTimer: 20.0, Piercing Strike (1)
		StartTimer: 23.0, Swarm (1)
		StartTimer: 46.1, Charge (1)
		StartTimer: 81.0, Dispels (1)
		StartTimer: 22.3, Frontal [R-Takazj] (1)
		StartTimer: 51.2, Teleport (1)
		StartTimer: 33.4, Web Vortex (1)
		StartTimer: 38.6, Run away! (1)
		StartTimer: 92.6, Massive Explosion (1)
	[377.86] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 17.0, Piercing Strike (2)
	[379.38] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[380.19] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Frontal [R-Takazj] (1) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 33.6, Frontal [R-Takazj] (2)
	[380.86] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
		ShowSpecialWarning: Swarm! (1)
		PlaySound: VoicePack/aesoon
		StartTimer: 75.0, Swarm (2)
	[391.15] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		ShowSpecialWarning: Web Vortex! (1)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (2)
		ScheduleTask: (anonymous function) at 401.65 (+10.50)
			Unscheduled by SPELL_CAST_START at 393.66
	[393.20] SPELL_AURA_APPLIED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Binding Webs on you
		PlaySound: VoicePack/lineapart
	[393.66] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 391.15
		ShowSpecialWarning: Web Vortex! (2)
		PlaySound: VoicePack/pullin
		StartTimer: 31.1, Web Vortex (3)
		ScheduleTask: (anonymous function) at 432.76 (+39.10)
			Unscheduled by SPELL_CAST_START at 424.87
	[394.87] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 32.0, Piercing Strike (3)
	[395.72] SPELL_AURA_REMOVED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		ShowAnnounce: Binding Webs faded
	[396.38] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[396.43] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		ShowAnnounce: Casting Run away!: 4.0 sec
		StartTimer: 33.6, Run away! (2)
		ScheduleTask: (anonymous function) at 438.03 (+41.60)
			Unscheduled by SPELL_CAST_START at 430.15
	[397.86] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spikes (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 31.0, Spikes (2)
	[400.83] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (3)
	[404.56] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Charge! (1)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
		StartTimer: 49.0, Charge
		StartTimer: 98.0, Charge (2)
	[409.11] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (1)
		StartTimer: 38.4, Teleport (2)
	[411.13] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Entangled] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 440179, Entangled, 0, BUFF, 0
		ShowAnnounce: Entangled on Anub'arash
	[413.77] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Frontal [R-Takazj] (2) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 24.9, Frontal [R-Takazj] (3)
	[424.87] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 393.66
		ShowSpecialWarning: Web Vortex! (3)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (4)
		ScheduleTask: (anonymous function) at 435.37 (+10.50)
			Unscheduled by SPELL_CAST_START at 427.37
	[426.84] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (4)
	[427.37] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 424.87
		ShowSpecialWarning: Web Vortex! (4)
		PlaySound: VoicePack/pullin
		StartTimer: 61.4, Web Vortex (5)
		ScheduleTask: (anonymous function) at 496.77 (+69.40)
			Unscheduled by SPELL_CAST_START at 488.74
	[428.34] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[428.85] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spikes (2) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 64.0, Spikes (3)
	[429.39] SPELL_AURA_APPLIED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Binding Webs on you
		PlaySound: VoicePack/lineapart
	[430.15] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 396.43
		ShowAnnounce: Casting Run away!: 4.0 sec
		StartTimer: 63.9, Run away! (3)
		ScheduleTask: (anonymous function) at 502.05 (+71.90)
			Unscheduled by SPELL_CAST_START at 494.02
	[432.39] SPELL_AURA_REMOVED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		ShowAnnounce: Binding Webs faded
	[438.70] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Frontal [R-Takazj] (3) - dodge attack
		PlaySound: VoicePack/frontal
		StartTimer: 43.0, Frontal [R-Takazj] (4)
	[438.84] SPELL_CAST_START: [Anub'arash: Stinging Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438677, Stinging Swarm, 0, 0
		StartTimer: 57.0, Dispels (2)
	[441.25] SPELL_AURA_APPLIED: [->Dps10: Stinging Swarm] "", nil, 0x0, Player-1-00000011, Dps10, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce438677target:CombinedShow("Dps10") at 441.75 (+0.50)
			ShowAnnounce: Stinging Swarm on Dps10
	[442.28] SPELL_AURA_APPLIED: [->Dps1: Stinging Swarm] "", nil, 0x0, Player-1-00000001, Dps1, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce438677target:CombinedShow("Dps1") at 442.78 (+0.50)
			ShowAnnounce: Stinging Swarm on Dps8, Dps11, Dps9, Dps1
	[446.85] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 21.0, Piercing Strike (5)
	[447.52] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (2)
		StartTimer: 29.3, Teleport (3)
	[448.35] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[450.51] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		ShowSpecialWarning: Cataclysmic Entropy! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 61.8, Massive Explosion (2)
		ScheduleTask: (anonymous function) at 520.31 (+69.80)
			Unscheduled by SPELL_CAST_START at 512.41
	[455.87] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
		ShowSpecialWarning: Swarm! (2)
		PlaySound: VoicePack/aesoon
		StartTimer: 70.0, Swarm (3)
	[467.85] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (6)
	[469.36] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[476.66] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (3)
		StartTimer: 29.9, Teleport (4)
	[481.72] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Frontal [R-Takazj] (4) - dodge attack
		PlaySound: VoicePack/frontal
	[487.86] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 36.0, Piercing Strike (7)
	[488.74] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 427.37
		ShowSpecialWarning: Web Vortex! (5)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (6)
		ScheduleTask: (anonymous function) at 499.24 (+10.50)
			Unscheduled by SPELL_CAST_START at 491.24
	[489.39] SPELL_AURA_APPLIED: [Anub'arash->Dps15: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000018, Dps15, 0x511, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on PlayerName (1)
	[491.24] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 488.74
		ShowSpecialWarning: Web Vortex! (6)
		PlaySound: VoicePack/pullin
	[492.86] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spikes (3) - dodge attack
		PlaySound: VoicePack/watchstep
	[493.29] SPELL_AURA_APPLIED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		AntiSpam: 1
		ShowSpecialWarning: Binding Webs on you
		PlaySound: VoicePack/lineapart
	[494.02] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 430.15
		ShowAnnounce: Casting Run away!: 4.0 sec
	[496.29] SPELL_AURA_REMOVED: [->Dps15: Binding Webs] "", nil, 0x0, Player-1-00000018, Dps15, 0x511, 440001, Binding Webs, 0, DEBUFF, 0
		ShowAnnounce: Binding Webs faded
	[498.87] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (4)
	[499.07] SPELL_AURA_APPLIED: [->Dps16: Stinging Swarm] "", nil, 0x0, Player-1-00000019, Dps16, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce438677target:CombinedShow("Dps16") at 499.57 (+0.50)
			ShowAnnounce: Stinging Swarm on Dps4, Dps2, Dps11, Dps7, Dps16
	[501.87] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Charge! (2)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
		StartTimer: 49.0, Charge
	[506.75] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (4)
		StartTimer: 2.6, Teleport (5)
	[508.39] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Entangled] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, 440179, Entangled, 0, BUFF, 0
		ShowAnnounce: Entangled on Anub'arash
	[509.40] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Teleport (5)
	[512.41] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 450.51
		ShowSpecialWarning: Cataclysmic Entropy! (2)
		PlaySound: VoicePack/specialsoon
	[525.38] SPELL_AURA_APPLIED: [Anub'arash->Tank2: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000017, Tank2, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowSpecialWarning: Piercing Strike on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[525.87] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
		ShowSpecialWarning: Swarm! (3)
		PlaySound: VoicePack/aesoon
		StartTimer: 37.0, Swarm (4)
	[535.36] ENCOUNTER_END: 2921, The Silken Court, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 455080 450980 451277 440001 456252
]]
