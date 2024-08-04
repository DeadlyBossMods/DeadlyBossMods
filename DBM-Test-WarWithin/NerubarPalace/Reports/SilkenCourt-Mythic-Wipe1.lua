DBM.Test:Report[[
Test: TWW/NerubarPalace/SilkenCourt/Mythic/Wipe-1
Mod:  DBM-Raids-WarWithin/2608

Findings:
	Unused event registration: SPELL_AURA_APPLIED 438200 (Poison Bolt)
	Unused event registration: SPELL_AURA_APPLIED 440001 (Binding Webs)
	Unused event registration: SPELL_AURA_APPLIED 440179 (Entangled)
	Unused event registration: SPELL_AURA_APPLIED 450728 (Stinging Swarm)
	Unused event registration: SPELL_AURA_APPLIED 450980 (Shatter Existence)
	Unused event registration: SPELL_AURA_APPLIED 451277 (Spike Storm)
	Unused event registration: SPELL_AURA_APPLIED 455080 (Scarab Lord's Perseverance)
	Unused event registration: SPELL_AURA_APPLIED 455849 (Mark of Paranoia)
	Unused event registration: SPELL_AURA_APPLIED 456245 (Stinging Delirium)
	Unused event registration: SPELL_AURA_APPLIED 456252 (Stinging Swarm)
	Unused event registration: SPELL_AURA_REMOVED 440001 (Binding Webs)
	Unused event registration: SPELL_AURA_REMOVED 455080 (Scarab Lord's Perseverance)
	Unused event registration: SPELL_CAST_START 451016 (Shatter Existence)
	Unused event registration: SPELL_CAST_START 451327 (Raging Fury)
	Unused event registration: SPELL_CAST_START 452231 (Stinging Swarm)
	Timer for spell ID 438218 (Piercing Strike) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 438218 (Piercing Strike) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
	SpecialWarning for spell ID 438343 (Venomous Rain) is triggered by event SPELL_AURA_APPLIED 438656 (Venomous Rain)
	Timer for spell ID 438355 (Cataclysmic Entropy) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Timer for spell ID 438355 (Cataclysmic Entropy) is triggered by event SPELL_AURA_REMOVED 451277 (Spike Storm)
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
	Timer for spell ID 451327 (Raging Fury) is triggered by event SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Announce for spell ID 456245 (Stinging Delirium) is triggered by event SPELL_AURA_APPLIED 456235 (Stinging Delirium)

Unused objects:
	[Announce] Binding Webs faded, type=fades, spellId=440001
	[Announce] Entangled on >%s<, type=target, spellId=440179
	[Special Warning] Piercing Strike - defensive, type=defensive, spellId=438218
	[Special Warning] Stinging Swarm - move to >%s<, type=moveto, spellId=438677
	[Special Warning] Binding Webs on you, type=you, spellId=440001
	[Special Warning] Mark of Paranoia on you, type=you, spellId=455849
	[Yell] Stinging Swarm, type=shortyell, spellId=438677
	[Yell] Impaled, type=shortyell, spellId=449857

Timers:
	Piercing Strike (%s), time=49.00, type=cdcount, spellId=438218, triggerDeltas = 0.00, 15.02, 22.99, 25.01, 266.73, 15.02, 18.99, 20.00, 23.01, 19.00, 257.55, 26.05, 19.97, 20.02, 33.98, 22.02, 20.98
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 15.02] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
			 Triggered 14x, delta times: 15.02, 22.99, 25.01, 281.75, 18.99, 20.00, 23.01, 19.00, 283.60, 19.97, 20.02, 33.98, 22.02, 20.98
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Venomous Rain (%s), time=49.00, type=cdcount, spellId=438343, triggerDeltas = 0.00, 15.22, 41.91
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 15.22] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
			 Triggered 2x, delta times: 15.22, 41.91
	Cataclysmic Entropy (%s), time=49.00, type=cdcount, spellId=438355, triggerDeltas = 329.75, 55.79, 297.78, 115.81
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[385.54] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
			 Triggered 2x, delta times: 385.54, 413.59
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Stinging Swarm (%s), time=49.00, type=cdcount, spellId=438677, triggerDeltas = 329.75, 36.01, 317.56, 63.02
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[365.76] SPELL_CAST_START: [Anub'arash: Stinging Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438677, Stinging Swarm, 0, 0
			 Triggered 2x, delta times: 365.76, 380.58
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Call of the Swarm (%s), time=49.00, type=cdcount, spellId=438801, triggerDeltas = 0.00, 23.01, 306.74, 20.04
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 23.01] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
			 Triggered 2x, delta times: 23.01, 326.78
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
	Web Bomb (%s), time=49.00, type=cdcount, spellId=439838, triggerDeltas = 0.00, 31.38, 32.86
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 31.38] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
			 Triggered 2x, delta times: 31.38, 32.86
	Reckless Charge (%s), time=49.00, type=cdcount, spellId=440246, triggerDeltas = 0.00, 42.99, 640.33, 84.35
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 42.99] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
			 Triggered 2x, delta times: 42.99, 724.68
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Impaling Eruption (%s), time=49.00, type=cdcount, spellId=440504, triggerDeltas = 0.00, 8.02, 23.98, 25.04, 272.71, 9.04, 35.00, 34.99
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[  8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 6x, delta times: 8.02, 23.98, 25.04, 281.75, 35.00, 34.99
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
	Web Vortex (%s), time=49.00, type=cdcount, spellId=441626, triggerDeltas = 329.75, 32.71, 2.51, 34.63, 2.50, 281.22, 20.21, 2.50, 68.46, 2.52, 73.85
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[362.46] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
			 Triggered 9x, delta times: 362.46, 2.51, 34.63, 2.50, 301.43, 2.50, 68.46, 2.52, 73.85
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Strands of Reality (%s), time=49.00, type=cdcount, spellId=441782, triggerDeltas = 329.75, 14.08, 32.17, 307.32, 42.82, 38.81, 48.21
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[343.83] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
			 Triggered 5x, delta times: 343.83, 32.17, 350.14, 38.81, 48.21
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Burrow (%s), time=49.00, type=cdcount, spellId=441791, triggerDeltas = 40.02
		[ 40.02] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
	Unleashed Swarm (%s), time=49.00, type=cdcount, spellId=442994, triggerDeltas = 683.32, 30.01
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
		[713.33] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
	Spike Eruption (%s), time=49.00, type=cdcount, spellId=443068, triggerDeltas = 683.32, 23.01, 37.00, 37.00, 37.01
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
		[706.33] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
			 Triggered 4x, delta times: 706.33, 37.00, 37.00, 37.01
	Skittering Leap (%s), time=49.00, type=cdcount, spellId=450045, triggerDeltas = 0.00, 19.29, 27.34
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 19.29] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
			 Triggered 2x, delta times: 19.29, 27.34
	Entropic Desolation (%s), time=49.00, type=cdcount, spellId=450129, triggerDeltas = 329.75, 37.98, 315.59, 25.48, 70.97
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[367.73] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
			 Triggered 3x, delta times: 367.73, 341.07, 70.97
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Void Step (%s), time=49.00, type=cdcount, spellId=450483, triggerDeltas = 329.75, 52.78, 26.57, 274.22, 37.77, 50.39, 24.64, 49.72, 23.10
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		[382.53] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
			 Triggered 7x, delta times: 382.53, 26.57, 311.99, 50.39, 24.64, 49.72, 23.10
		[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
	Intermission %s, time=100.00, type=intermissioncount, spellId=450483, triggerDeltas = 0.00
		[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
	Intermission %s, time=100.00, type=intermissioncount, spellId=451327, triggerDeltas = 329.75
		[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0

Announces:
	Poison Bolt on >%s< (%d), type=stack, spellId=438200, triggerDeltas = 105.25, 17.00
		[105.25] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Tank4: Poison Bolt] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000012, Tank4, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		[122.25] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Tank6: Poison Bolt] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000020, Tank6, 0x512, 438200, Poison Bolt, 0, DEBUFF, 6, 0
	Piercing Strike on >%s< (%d), type=stack, spellId=438218, triggerDeltas = 16.56, 22.97, 24.99, 24.01, 257.73, 19.00, 20.00, 23.00, 19.01, 24.00, 259.61, 19.96, 20.02, 33.98, 22.01, 41.02
		[ 16.56] SPELL_AURA_APPLIED: [Anub'arash->Tank6: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000020, Tank6, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		[ 39.53] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank6: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000020, Tank6, 0x512, 438218, Piercing Strike, 0, DEBUFF, 2, 0
			 Triggered 3x, delta times: 39.53, 24.99, 24.01
		[346.26] SPELL_AURA_APPLIED: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
			 Triggered 3x, delta times: 346.26, 364.62, 136.99
		[365.26] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 2, 0
			 Triggered 9x, delta times: 365.26, 20.00, 23.00, 19.01, 24.00, 279.57, 20.02, 33.98, 22.01
	Venomous Rain (%s), type=count, spellId=438343, triggerDeltas = 15.22, 41.91, 33.23
		[ 15.22] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
			 Triggered 3x, delta times: 15.22, 41.91, 33.23
	Call of the Swarm (%s), type=count, spellId=438801, triggerDeltas = 23.01, 50.02, 276.76, 47.97
		[ 23.01] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
			 Triggered 4x, delta times: 23.01, 50.02, 276.76, 47.97
	Web Bomb (%s), type=count, spellId=439838, triggerDeltas = 31.38, 32.86, 28.13
		[ 31.38] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
			 Triggered 3x, delta times: 31.38, 32.86, 28.13
	Burrow (%s), type=count, spellId=441791, triggerDeltas = 40.02, 59.99, 664.32, 97.01
		[ 40.02] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
			 Triggered 4x, delta times: 40.02, 59.99, 664.32, 97.01
	Impaled on >%s<, type=target, spellId=449857, triggerDeltas = 13.53, 659.85, 156.47
		[ 13.53] Scheduled at 12.03 by SPELL_AURA_APPLIED: [->Dps8: Impaled] "", nil, 0x0, Player-1-00000016, Dps8, 0x512, 449857, Impaled, 0, DEBUFF, 0
		[673.38] Scheduled at 671.88 by SPELL_AURA_APPLIED: [->Healer2: Impaled] "", nil, 0x0, Player-1-00000008, Healer2, 0x512, 449857, Impaled, 0, DEBUFF, 0
		[829.85] Scheduled at 828.35 by SPELL_AURA_APPLIED: [->Tank1: Impaled] "", nil, 0x0, Player-1-00000002, Tank1, 0x512, 449857, Impaled, 0, DEBUFF, 0
	Skittering Leap (%s), type=count, spellId=450045, triggerDeltas = 19.29, 27.34, 61.09
		[ 19.29] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
			 Triggered 3x, delta times: 19.29, 27.34, 61.09
	Skittering Leap on >%s<, type=target, spellId=450045, triggerDeltas = 368.37, 380.73
		[368.37] Scheduled at 367.87 by SPELL_AURA_APPLIED: [->Tank1: Stinging Swarm] "", nil, 0x0, Player-1-00000002, Tank1, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		[749.10] Scheduled at 748.60 by SPELL_AURA_APPLIED: [->Dps2: Stinging Swarm] "", nil, 0x0, Player-1-00000004, Dps2, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
	Casting Entropic Desolation: 4.0 sec, type=cast, spellId=450129, triggerDeltas = 367.73, 37.13, 303.94, 70.97, 76.36
		[367.73] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
			 Triggered 5x, delta times: 367.73, 37.13, 303.94, 70.97, 76.36
	Void Step (%s), type=count, spellId=450483, triggerDeltas = 382.53, 26.57, 23.68, 288.31, 50.39, 24.64, 49.72, 23.10, 3.00
		[382.53] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
			 Triggered 9x, delta times: 382.53, 26.57, 23.68, 288.31, 50.39, 24.64, 49.72, 23.10, 3.00
	Stinging Delirium on >%s<, type=target, spellId=456245, triggerDeltas = 825.87
		[825.87] SPELL_AURA_APPLIED: [->Tank1: Stinging Delirium] "", nil, 0x0, Player-1-00000002, Tank1, 0x512, 456235, Stinging Delirium, 0, DEBUFF, 0

Special warnings:
	Venomous Rain on you, type=you, spellId=438343, triggerDeltas = 20.25, 41.90, 33.24
		[ 20.25] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank4: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000012, Tank4, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0
			 Triggered 3x, delta times: 20.25, 41.90, 33.24
	Cataclysmic Entropy! (%s), type=count, spellId=438355, triggerDeltas = 385.54, 61.27, 352.32, 75.84
		[385.54] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
			 Triggered 4x, delta times: 385.54, 61.27, 352.32, 75.84
	Reckless Charge! (%s), type=count, spellId=440246, triggerDeltas = 42.99, 59.93, 664.75, 96.57
		[ 42.99] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
			 Triggered 4x, delta times: 42.99, 59.93, 664.75, 96.57
	Impaling Eruption (%s) - dodge attack, type=dodgecount, spellId=440504, triggerDeltas = 8.02, 23.98, 25.04, 23.00, 258.75, 35.00, 34.99, 35.00
		[  8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 8x, delta times: 8.02, 23.98, 25.04, 23.00, 258.75, 35.00, 34.99, 35.00
	Web Vortex! (%s), type=count, spellId=441626, triggerDeltas = 362.46, 2.51, 34.63, 2.50, 33.70, 267.73, 2.50, 68.46, 2.52, 73.85, 2.51
		[362.46] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
			 Triggered 11x, delta times: 362.46, 2.51, 34.63, 2.50, 33.70, 267.73, 2.50, 68.46, 2.52, 73.85, 2.51
	Strands of Reality (%s) - dodge attack, type=dodgecount, spellId=441782, triggerDeltas = 343.83, 32.17, 36.11, 314.03, 38.81, 48.21, 47.23
		[343.83] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
			 Triggered 7x, delta times: 343.83, 32.17, 36.11, 314.03, 38.81, 48.21, 47.23
	Unleashed Swarm! (%s), type=count, spellId=442994, triggerDeltas = 713.33, 80.00
		[713.33] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
			 Triggered 2x, delta times: 713.33, 80.00
	Spike Eruption (%s) - dodge attack, type=dodgecount, spellId=443068, triggerDeltas = 706.33, 37.00, 37.00, 37.01, 36.98
		[706.33] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
			 Triggered 5x, delta times: 706.33, 37.00, 37.00, 37.01, 36.98
	Enraged Ferocity on >%s< - dispel now, type=dispel, spellId=443598, triggerDeltas = 886.36
		[886.36] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Uncontrollable Rage] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 443598, Uncontrollable Rage, 0, BUFF, 0
	Mark of Rage on you, type=you, spellId=455850, triggerDeltas = 1.81
		[  1.81] SPELL_AURA_APPLIED: [->Tank4: Mark of Rage] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 455850, Mark of Rage, 0, DEBUFF, 0

Yells:
	None

Voice pack sounds:
	VoicePack/aesoon
		[713.33] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
			 Triggered 2x, delta times: 713.33, 80.00
	VoicePack/chargemove
		[ 42.99] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
			 Triggered 4x, delta times: 42.99, 59.93, 664.75, 96.57
	VoicePack/enrage
		[886.36] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Uncontrollable Rage] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 443598, Uncontrollable Rage, 0, BUFF, 0
	VoicePack/pullin
		[362.46] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
			 Triggered 11x, delta times: 362.46, 2.51, 34.63, 2.50, 33.70, 267.73, 2.50, 68.46, 2.52, 73.85, 2.51
	VoicePack/rageyou
		[  1.81] SPELL_AURA_APPLIED: [->Tank4: Mark of Rage] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 455850, Mark of Rage, 0, DEBUFF, 0
	VoicePack/shockwave
		[  8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 8x, delta times: 8.02, 23.98, 25.04, 23.00, 258.75, 35.00, 34.99, 35.00
		[343.83] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
			 Triggered 7x, delta times: 343.83, 32.17, 36.11, 314.03, 38.81, 48.21, 47.23
	VoicePack/specialsoon
		[385.54] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
			 Triggered 4x, delta times: 385.54, 61.27, 352.32, 75.84
	VoicePack/targetyou
		[ 20.25] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank4: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000012, Tank4, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0
			 Triggered 3x, delta times: 20.25, 41.90, 33.24
	VoicePack/watchstep
		[706.33] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
			 Triggered 5x, delta times: 706.33, 37.00, 37.00, 37.01, 36.98

Icons:
	Icon 6, target=Creature-0-1-2657-1-218884-00000000C2, scanMethod=nil
		[ 26.02] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000C2, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 6, target=Creature-0-1-2657-1-218884-00000000C7, scanMethod=nil
		[ 76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000C7, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-000000009C, scanMethod=nil
		[ 26.02] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000009C, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-00000000A1, scanMethod=nil
		[ 76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000A1, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-0000000012, scanMethod=nil
		[ 26.02] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000012, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-0000000030, scanMethod=nil
		[ 76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000030, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-0000000059, scanMethod=nil
		[352.79] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000059, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-0000000062, scanMethod=nil
		[400.77] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000062, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0

Event trace:
	[  0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 438218 438801 440246 440504 438343 439838 450045 451016 438677 452231 441626 450129 441782 450483 438355 443068 451327 442994 441791, SPELL_SUMMON 438249, SPELL_AURA_APPLIED 455849 455850 438218 455080 449857 440001 450980 438708 456252 450728 451277 443598 438656 440179 456245 438200 456235, SPELL_AURA_APPLIED_DOSE 438218 438200, SPELL_AURA_REMOVED 455080 450980 451277 440001
		StartTimer: 15.0, Piercing Strike (1)
		StartTimer: 23.0, Call of the Swarm (1)
		StartTimer: 8.0, Impaling Eruption (1)
		StartTimer: 43.0, Reckless Charge (1)
		StartTimer: 15.2, Venomous Rain (1)
		StartTimer: 19.3, Skittering Leap (1)
		StartTimer: 31.4, Web Bomb (1)
		StartTimer: 131.0, Intermission 1.5
	[  1.81] SPELL_AURA_APPLIED: [->Tank4: Mark of Rage] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 455850, Mark of Rage, 0, DEBUFF, 0
		ShowSpecialWarning: Mark of Rage on you
		PlaySound: VoicePack/rageyou
	[  8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (1) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 24.0, Impaling Eruption (2)
	[ 12.03] SPELL_AURA_APPLIED: [->Dps8: Impaled] "", nil, 0x0, Player-1-00000016, Dps8, 0x512, 449857, Impaled, 0, DEBUFF, 0
		ScheduleTask: announce449857target:CombinedShow("Dps8") at 13.53 (+1.50)
			ShowAnnounce: Impaled on Dps8
	[ 15.02] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 23.0, Piercing Strike (2)
	[ 15.22] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowAnnounce: Venomous Rain (1)
		StartTimer: 41.9, Venomous Rain (2)
	[ 16.56] SPELL_AURA_APPLIED: [Anub'arash->Tank6: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000020, Tank6, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on Tank6 (1)
	[ 19.29] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
		ShowAnnounce: Skittering Leap (1)
		StartTimer: 27.3, Skittering Leap (2)
	[ 20.25] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank4: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000012, Tank4, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0
		ShowSpecialWarning: Venomous Rain on you
		PlaySound: VoicePack/targetyou
	[ 23.01] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Call of the Swarm (1)
		StartTimer: 50.0, Call of the Swarm (2)
	[ 26.02] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000012, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000012, 2, 8, 1
	[ 26.02] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000009C, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-000000009C, 2, 7, 1
	[ 26.02] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000C2, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000C2, 2, 6, 1
	[ 31.38] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
		ShowAnnounce: Web Bomb (1)
		StartTimer: 32.9, Web Bomb (2)
	[ 32.00] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (2) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 25.0, Impaling Eruption (3)
	[ 38.01] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 25.0, Piercing Strike (3)
	[ 39.53] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank6: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000020, Tank6, 0x512, 438218, Piercing Strike, 0, DEBUFF, 2, 0
		ShowAnnounce: Piercing Strike on Tank6 (2)
	[ 40.02] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (1)
		StartTimer: 59.9, Burrow (2)
	[ 42.99] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Reckless Charge! (1)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
		StartTimer: 59.9, Reckless Charge (2)
	[ 46.63] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
		ShowAnnounce: Skittering Leap (2)
		StartTimer: 61.1, Skittering Leap (3)
	[ 57.04] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (3) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 23.0, Impaling Eruption (4)
	[ 57.13] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowAnnounce: Venomous Rain (2)
		StartTimer: 33.2, Venomous Rain (3)
	[ 62.15] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank4: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000012, Tank4, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0
		ShowSpecialWarning: Venomous Rain on you
		PlaySound: VoicePack/targetyou
	[ 63.02] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 24.0, Piercing Strike (4)
	[ 64.24] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
		ShowAnnounce: Web Bomb (2)
		StartTimer: 28.1, Web Bomb (3)
	[ 64.52] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank6: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000020, Tank6, 0x512, 438218, Piercing Strike, 0, DEBUFF, 3, 0
		ShowAnnounce: Piercing Strike on Tank6 (3)
	[ 73.03] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Call of the Swarm (2)
	[ 76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000030, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000030, 2, 8, 1
	[ 76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000A1, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000A1, 2, 7, 1
	[ 76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-00000000C7, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-00000000C7, 2, 6, 1
	[ 80.04] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (4) - dodge attack
		PlaySound: VoicePack/shockwave
	[ 88.53] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank6: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000020, Tank6, 0x512, 438218, Piercing Strike, 0, DEBUFF, 4, 0
		ShowAnnounce: Piercing Strike on Tank6 (4)
	[ 90.36] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowAnnounce: Venomous Rain (3)
	[ 92.37] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
		ShowAnnounce: Web Bomb (3)
	[ 95.39] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank4: Venomous Rain] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000012, Tank4, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0
		ShowSpecialWarning: Venomous Rain on you
		PlaySound: VoicePack/targetyou
	[100.01] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (2)
	[102.92] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Reckless Charge! (2)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
	[105.25] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Tank4: Poison Bolt] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000012, Tank4, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		ShowAnnounce: Poison Bolt on PlayerName (6)
	[107.72] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
		ShowAnnounce: Skittering Leap (3)
	[122.25] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Tank6: Poison Bolt] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Player-1-00000020, Tank6, 0x512, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		ShowAnnounce: Poison Bolt on Tank6 (6)
	[329.75] SPELL_AURA_REMOVED: [Skeinspinner Takazj->Skeinspinner Takazj: Shatter Existence] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, 450980, Shatter Existence, 0, BUFF, 0, 0
		StartTimer: 9.0, Impaling Eruption (1)
		StartTimer: 15.0, Piercing Strike (1)
		StartTimer: 20.0, Call of the Swarm (1)
		StartTimer: 36.0, Stinging Swarm (1)
		StartTimer: 14.1, Strands of Reality (1)
		StartTimer: 52.8, Void Step (1)
		StartTimer: 32.7, Web Vortex (1)
		StartTimer: 38.0, Entropic Desolation (1)
		StartTimer: 55.8, Cataclysmic Entropy (1)
		StartTimer: 132.0, Intermission 2.5
	[338.79] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (1) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 35.0, Impaling Eruption (2)
	[343.83] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Strands of Reality (1) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 32.2, Strands of Reality (2)
	[344.77] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 19.0, Piercing Strike (2)
	[346.26] SPELL_AURA_APPLIED: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on Tank1 (1)
	[349.79] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Call of the Swarm (1)
		StartTimer: 48.0, Call of the Swarm (2)
	[352.79] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000059, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000059, 2, 8, 1
	[362.46] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		ShowSpecialWarning: Web Vortex! (1)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (2)
		ScheduleTask: (anonymous function) at 372.96 (+10.50)
			Unscheduled by SPELL_CAST_START at 364.97
	[363.76] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (3)
	[364.97] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 362.46
		ShowSpecialWarning: Web Vortex! (2)
		PlaySound: VoicePack/pullin
		StartTimer: 34.6, Web Vortex (3)
		ScheduleTask: (anonymous function) at 407.57 (+42.60)
			Unscheduled by SPELL_CAST_START at 399.60
	[365.26] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 2, 0
		ShowAnnounce: Piercing Strike on Tank1 (2)
	[365.76] SPELL_CAST_START: [Anub'arash: Stinging Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438677, Stinging Swarm, 0, 0
		StartTimer: 37.0, Stinging Swarm (2)
	[367.73] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		ShowAnnounce: Casting Entropic Desolation: 4.0 sec
		StartTimer: 37.1, Entropic Desolation (2)
		ScheduleTask: (anonymous function) at 412.83 (+45.10)
			Unscheduled by SPELL_CAST_START at 404.86
	[367.87] SPELL_AURA_APPLIED: [->Tank1: Stinging Swarm] "", nil, 0x0, Player-1-00000002, Tank1, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce450045target:CombinedShow("Tank1") at 368.37 (+0.50)
			ShowAnnounce: Skittering Leap on Tank1
	[373.79] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (2) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 35.0, Impaling Eruption (3)
	[376.00] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Strands of Reality (2) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 36.1, Strands of Reality (3)
	[382.53] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (1)
		StartTimer: 26.6, Void Step (2)
	[383.76] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 23.0, Piercing Strike (4)
	[385.26] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 3, 0
		ShowAnnounce: Piercing Strike on Tank1 (3)
	[385.54] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		ShowSpecialWarning: Cataclysmic Entropy! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 61.3, Cataclysmic Entropy (2)
	[397.76] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Call of the Swarm (2)
	[399.60] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 364.97
		ShowSpecialWarning: Web Vortex! (3)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (4)
		ScheduleTask: (anonymous function) at 410.10 (+10.50)
			Unscheduled by SPELL_CAST_START at 402.10
	[400.77] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000062, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000062, 2, 8, 1
	[402.10] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 399.60
		ShowSpecialWarning: Web Vortex! (4)
		PlaySound: VoicePack/pullin
		StartTimer: 33.7, Web Vortex (5)
		ScheduleTask: (anonymous function) at 443.80 (+41.70)
			Unscheduled by SPELL_CAST_START at 435.80
	[404.86] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 367.73
		ShowAnnounce: Casting Entropic Desolation: 4.0 sec
	[406.77] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 19.0, Piercing Strike (5)
	[408.26] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 4, 0
		ShowAnnounce: Piercing Strike on Tank1 (4)
	[408.78] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (3) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 35.0, Impaling Eruption (4)
	[409.10] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (2)
		StartTimer: 23.7, Void Step (3)
	[412.11] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Strands of Reality (3) - dodge attack
		PlaySound: VoicePack/shockwave
	[425.77] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 24.0, Piercing Strike (6)
	[427.27] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 5, 0
		ShowAnnounce: Piercing Strike on Tank1 (5)
	[432.78] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (3)
	[435.80] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 402.10
		ShowSpecialWarning: Web Vortex! (5)
		PlaySound: VoicePack/pullin
	[443.78] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (4) - dodge attack
		PlaySound: VoicePack/shockwave
	[446.81] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		ShowSpecialWarning: Cataclysmic Entropy! (2)
		PlaySound: VoicePack/specialsoon
	[451.27] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 6, 0
		ShowAnnounce: Piercing Strike on Tank1 (6)
	[671.88] SPELL_AURA_APPLIED: [->Healer2: Impaled] "", nil, 0x0, Player-1-00000008, Healer2, 0x512, 449857, Impaled, 0, DEBUFF, 0
		ScheduleTask: announce449857target:CombinedShow("Healer2") at 673.38 (+1.50)
			ShowAnnounce: Impaled on Healer2
	[683.32] SPELL_AURA_REMOVED: [Anub'arash->Anub'arash: Spike Storm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 451277, Spike Storm, 0, BUFF, 0, 0
		StartTimer: 23.0, Spike Eruption (1)
		StartTimer: 26.0, Piercing Strike (1)
		StartTimer: 30.0, Unleashed Swarm (1)
		StartTimer: 84.4, Reckless Charge (1)
		StartTimer: 63.0, Stinging Swarm (1)
		StartTimer: 42.8, Strands of Reality (1)
		StartTimer: 37.8, Void Step (1)
		StartTimer: 20.2, Web Vortex (1)
		StartTimer: 25.5, Entropic Desolation (1)
		StartTimer: 115.8, Cataclysmic Entropy (1)
	[703.53] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		ShowSpecialWarning: Web Vortex! (1)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (2)
		ScheduleTask: (anonymous function) at 714.03 (+10.50)
			Unscheduled by SPELL_CAST_START at 706.03
	[706.03] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 703.53
		ShowSpecialWarning: Web Vortex! (2)
		PlaySound: VoicePack/pullin
		StartTimer: 68.5, Web Vortex (3)
		ScheduleTask: (anonymous function) at 782.53 (+76.50)
			Unscheduled by SPELL_CAST_START at 774.49
	[706.33] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spike Eruption (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 37.0, Spike Eruption (2)
	[708.80] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		ShowAnnounce: Casting Entropic Desolation: 4.0 sec
		StartTimer: 71.0, Entropic Desolation (2)
		ScheduleTask: (anonymous function) at 787.80 (+79.00)
			Unscheduled by SPELL_CAST_START at 779.77
	[709.37] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (2)
	[710.88] SPELL_AURA_APPLIED: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on Tank1 (1)
	[713.33] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
		ShowSpecialWarning: Unleashed Swarm! (1)
		PlaySound: VoicePack/aesoon
		StartTimer: 80.0, Unleashed Swarm (2)
	[721.09] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (1)
		StartTimer: 50.4, Void Step (2)
	[726.14] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Strands of Reality (1) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 38.8, Strands of Reality (2)
	[729.34] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (3)
	[730.84] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 2, 0
		ShowAnnounce: Piercing Strike on Tank1 (2)
	[743.33] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spike Eruption (2) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 37.0, Spike Eruption (3)
	[746.34] SPELL_CAST_START: [Anub'arash: Stinging Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438677, Stinging Swarm, 0, 0
		StartTimer: 77.0, Stinging Swarm (2)
	[748.60] SPELL_AURA_APPLIED: [->Dps2: Stinging Swarm] "", nil, 0x0, Player-1-00000004, Dps2, 0x512, 438708, Stinging Swarm, 0, DEBUFF, 0
		ScheduleTask: announce450045target:CombinedShow("Dps2") at 749.10 (+0.50)
			ShowAnnounce: Skittering Leap on Dps2
	[749.36] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 34.0, Piercing Strike (4)
	[750.86] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 3, 0
		ShowAnnounce: Piercing Strike on Tank1 (3)
	[764.33] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (3)
	[764.95] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Strands of Reality (2) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 48.2, Strands of Reality (3)
	[767.67] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Reckless Charge! (1)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
		StartTimer: 96.6, Reckless Charge (2)
	[771.48] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (2)
		StartTimer: 24.6, Void Step (3)
	[774.49] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 706.03
		ShowSpecialWarning: Web Vortex! (3)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (4)
		ScheduleTask: (anonymous function) at 784.99 (+10.50)
			Unscheduled by SPELL_CAST_START at 777.01
	[777.01] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 774.49
		ShowSpecialWarning: Web Vortex! (4)
		PlaySound: VoicePack/pullin
		StartTimer: 73.9, Web Vortex (5)
		ScheduleTask: (anonymous function) at 858.91 (+81.90)
			Unscheduled by SPELL_CAST_START at 850.86
	[779.77] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 708.80
		ShowAnnounce: Casting Entropic Desolation: 4.0 sec
		StartTimer: 76.4, Entropic Desolation (3)
		ScheduleTask: (anonymous function) at 864.17 (+84.40)
			Unscheduled by SPELL_CAST_START at 856.13
	[780.33] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spike Eruption (3) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 37.0, Spike Eruption (4)
	[783.34] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 22.0, Piercing Strike (5)
	[784.84] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 4, 0
		ShowAnnounce: Piercing Strike on Tank1 (4)
	[793.33] SPELL_CAST_START: [Anub'arash: Unleashed Swarm] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 442994, Unleashed Swarm, 0, 0
		ShowSpecialWarning: Unleashed Swarm! (2)
		PlaySound: VoicePack/aesoon
	[796.12] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (3)
		StartTimer: 49.7, Void Step (4)
	[799.13] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		ShowSpecialWarning: Cataclysmic Entropy! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 75.8, Cataclysmic Entropy (2)
	[805.36] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 21.0, Piercing Strike (6)
	[806.85] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 5, 0
		ShowAnnounce: Piercing Strike on Tank1 (5)
	[813.16] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Strands of Reality (3) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 47.2, Strands of Reality (4)
	[817.34] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spike Eruption (4) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 37.0, Spike Eruption (5)
	[825.87] SPELL_AURA_APPLIED: [->Tank1: Stinging Delirium] "", nil, 0x0, Player-1-00000002, Tank1, 0x512, 456235, Stinging Delirium, 0, DEBUFF, 0
		ShowAnnounce: Stinging Delirium on Tank1
	[826.34] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 20.0, Piercing Strike (7)
	[828.35] SPELL_AURA_APPLIED: [->Tank1: Impaled] "", nil, 0x0, Player-1-00000002, Tank1, 0x512, 449857, Impaled, 0, DEBUFF, 0
		ScheduleTask: announce449857target:CombinedShow("Tank1") at 829.85 (+1.50)
			ShowAnnounce: Impaled on Tank1
	[845.84] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (4)
		StartTimer: 23.1, Void Step (5)
	[847.87] SPELL_AURA_APPLIED: [Anub'arash->Tank1: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Player-1-00000002, Tank1, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on Tank1 (1)
	[850.86] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 777.01
		ShowSpecialWarning: Web Vortex! (5)
		PlaySound: VoicePack/pullin
		StartTimer: 2.5, Web Vortex (6)
		ScheduleTask: (anonymous function) at 861.36 (+10.50)
			Unscheduled by SPELL_CAST_START at 853.37
	[853.37] SPELL_CAST_START: [Skeinspinner Takazj: Web Vortex] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441626, Web Vortex, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 850.86
		ShowSpecialWarning: Web Vortex! (6)
		PlaySound: VoicePack/pullin
	[854.32] SPELL_CAST_START: [Anub'arash: Spike Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 443068, Spike Eruption, 0, 0
		ShowSpecialWarning: Spike Eruption (5) - dodge attack
		PlaySound: VoicePack/watchstep
	[856.13] SPELL_CAST_START: [Skeinspinner Takazj: Entropic Desolation] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450129, Entropic Desolation, 0, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 779.77
		ShowAnnounce: Casting Entropic Desolation: 4.0 sec
	[860.39] SPELL_CAST_START: [Skeinspinner Takazj: Strands of Reality] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 441782, Strands of Reality, 0, 0
		ShowSpecialWarning: Strands of Reality (4) - dodge attack
		PlaySound: VoicePack/shockwave
	[861.34] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (4)
	[864.24] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Reckless Charge! (2)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
	[868.94] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (5)
		StartTimer: 3.0, Void Step (6)
	[871.94] SPELL_CAST_START: [Skeinspinner Takazj: Void Step] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450483, Void Step, 0, 0
		ShowAnnounce: Void Step (6)
	[874.97] SPELL_CAST_START: [Skeinspinner Takazj: Cataclysmic Entropy] Creature-0-1-2657-1-217491-0000000001, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438355, Cataclysmic Entropy, 0, 0
		ShowSpecialWarning: Cataclysmic Entropy! (2)
		PlaySound: VoicePack/specialsoon
	[886.36] SPELL_AURA_APPLIED: [Anub'arash->Anub'arash: Uncontrollable Rage] Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, Vehicle-0-1-2657-1-217489-0000000001, Anub'arash, 0xa48, 443598, Uncontrollable Rage, 0, BUFF, 0
		ShowSpecialWarning: Enraged Ferocity on Anub'arash - dispel now
		PlaySound: VoicePack/enrage
	[902.62] ENCOUNTER_END: 2921, The Silken Court, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 455080 450980 451277 440001
]]
