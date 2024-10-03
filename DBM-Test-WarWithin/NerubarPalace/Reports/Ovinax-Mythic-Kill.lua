DBM.Test:Report[[
Test: TWW/NerubarPalace/Ovinax/Mythic/Kill
Mod:  DBM-Raids-WarWithin/2612

Findings:
	Unused event registration: SPELL_AURA_APPLIED 442250 (Fixate)
	Unused event registration: SPELL_AURA_APPLIED 442263 (Mutation: Accelerated)
	Unused event registration: SPELL_AURA_APPLIED 446349 (Sticky Web)
	Unused event registration: SPELL_AURA_APPLIED 446690 (Mutation: Ravenous)
	Unused event registration: SPELL_AURA_APPLIED 446694 (Mutation: Necrotic)
	Unused event registration: SPELL_AURA_REMOVED 440421 (Experimental Dosage)
	Unused event registration: SPELL_AURA_REMOVED 442250 (Fixate)
	Unused event registration: SPELL_AURA_REMOVED 442263 (Mutation: Accelerated)
	Unused event registration: SPELL_AURA_REMOVED 446349 (Sticky Web)
	Unused event registration: SPELL_AURA_REMOVED 446690 (Mutation: Ravenous)
	Unused event registration: SPELL_AURA_REMOVED 446694 (Mutation: Necrotic)
	Unused event registration: SPELL_CAST_START 443005 (Unknown spell)
	Timer for spell ID 441362 (Volatile Concoction) is triggered by event SPELL_CAST_START 442432 (Ingest Black Blood)
	Timer for spell ID 441362 (Volatile Concoction) is triggered by event SPELL_CAST_START 443003 (Volatile Concoction)
	Announce for spell ID 442526 (Experimental Dosage) is triggered by event SPELL_AURA_APPLIED 440421 (Experimental Dosage)
	Timer for spell ID 442526 (Experimental Dosage) is triggered by event SPELL_CAST_START 442432 (Ingest Black Blood)
	Timer for spell ID 446349 (Sticky Web) is triggered by event SPELL_CAST_START 442432 (Ingest Black Blood)

Unused objects:
	[Special Warning] Volatile Concoction - defensive, type=defensive, spellId=441362
	[Special Warning] Fixate on you, type=you, spellId=442250
	[Special Warning] Injection - move to >%s<, type=moveto, spellId=442526
	[Special Warning] Web - move away from others, type=moveaway, spellId=446349
	[Yell] {rt%2$d}%1$d, type=iconfade, spellId=442526
	[Yell] {rt%1$d}Destroy Egg, type=shortposition, spellId=442526
	[Yell] Web, type=shortyell, spellId=446349

Timers:
	Tank Debuff (%s), time=20.00, type=cdcount, spellId=441362, triggerDeltas = 0.00, 1.99, 17.41, 18.02, 20.03, 19.98, 20.06, 19.93, 20.01, 20.00, 19.99, 16.37, 18.03, 20.02, 19.97, 20.11, 19.90, 20.01, 20.01, 20.00, 13.13, 18.03, 20.03, 19.98, 20.00, 19.98, 20.02, 20.04, 19.96, 20.00, 19.99, 20.01
		[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		[  1.99] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
			 Triggered 28x, delta times: 1.99, 35.43, 20.03, 19.98, 20.06, 19.93, 20.01, 20.00, 19.99, 34.40, 20.02, 19.97, 20.11, 19.90, 20.01, 20.01, 20.00, 31.16, 20.03, 19.98, 20.00, 19.98, 20.02, 20.04, 19.96, 20.00, 19.99, 20.01
		[ 15.03] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000745, 442430, Broodtwister Ovi'nax, 97, 0, Dps4, 0
		[ 19.40] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
			 Triggered 3x, delta times: 19.40, 174.39, 171.18
		[186.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000293, 442430, Broodtwister Ovi'nax, 67, 0, Dps4, 0
		[358.89] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000501, 442430, Broodtwister Ovi'nax, 38.5, 0, Dps4, 0
	Container Breach (%s), time=166.40, type=cdcount, spellId=442432, triggerDeltas = 0.00, 15.03, 171.46, 172.40
		[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		[ 15.03] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000745, 442430, Broodtwister Ovi'nax, 97, 0, Dps4, 0
		[186.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000293, 442430, Broodtwister Ovi'nax, 67, 0, Dps4, 0
		[358.89] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000501, 442430, Broodtwister Ovi'nax, 38.5, 0, Dps4, 0
	Injection (%s), time=50.00, type=cdcount, spellId=442526, triggerDeltas = 19.40, 16.01, 50.02, 50.00, 58.36, 16.03, 50.01, 50.00, 55.14, 16.02, 50.02, 49.99
		[ 19.40] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
			 Triggered 3x, delta times: 19.40, 174.39, 171.18
		[ 35.41] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
			 Triggered 9x, delta times: 35.41, 50.02, 50.00, 74.39, 50.01, 50.00, 71.16, 50.02, 49.99
		[358.89] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000501, 442430, Broodtwister Ovi'nax, 38.5, 0, Dps4, 0
	Webs (%s), time=30.00, type=cdcount, spellId=446349, triggerDeltas = 0.00, 14.98, 4.42, 31.04, 30.01, 30.00, 30.01, 30.03, 23.30, 31.06, 29.96, 30.00, 30.00, 30.05, 20.11, 31.12, 29.89, 30.01, 30.05, 29.96, 30.00, 30.00
		[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		[ 14.98] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000006BC, 446344, Broodtwister Ovi'nax, 97, 99, Dps4, 0
		[ 15.03] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000745, 442430, Broodtwister Ovi'nax, 97, 0, Dps4, 0
		[ 19.40] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
			 Triggered 3x, delta times: 19.40, 174.39, 171.18
		[ 50.44] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000379, 446344, Broodtwister Ovi'nax, 91.1, 9, Tank2, 0
		[ 80.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000001ED, 446344, Broodtwister Ovi'nax, 84.9, 30, Tank2, 0
		[110.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000216, 446344, Broodtwister Ovi'nax, 79.5, 50, Dps4, 0
		[140.46] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000001FB, 446344, Broodtwister Ovi'nax, 74.8, 70, Dps4, 0
		[170.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000284, 446344, Broodtwister Ovi'nax, 69.1, 90, Tank2, 0
		[186.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000293, 442430, Broodtwister Ovi'nax, 67, 0, Dps4, 0
		[224.85] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000B31, 446344, Broodtwister Ovi'nax, 61.4, 10, Tank2, 0
		[254.81] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000003E9, 446344, Broodtwister Ovi'nax, 55.8, 30, Tank2, 0
		[284.81] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005E0, 446344, Broodtwister Ovi'nax, 50.5, 50, Dps4, 0
		[314.81] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000376, 446344, Broodtwister Ovi'nax, 45.9, 70, Dps4, 0
		[344.86] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005BA, 446344, Broodtwister Ovi'nax, 40.5, 90, Tank2, 0
		[358.89] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000501, 442430, Broodtwister Ovi'nax, 38.5, 0, Dps4, 0
		[396.09] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000DF5, 446344, Broodtwister Ovi'nax, 32.9, 9, Tank2, 0
		[425.98] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-000000053A, 446344, Broodtwister Ovi'nax, 25.3, 29, Dps4, 0
		[455.99] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-000000046E, 446344, Broodtwister Ovi'nax, 21, 50, Dps4, 0
		[486.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000513, 446344, Broodtwister Ovi'nax, 16.9, 70, Dps4, 0
		[516.00] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-000000062B, 446344, Broodtwister Ovi'nax, 13.2, 90, Dps4, 0
		[546.00] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005FA, 446344, Broodtwister Ovi'nax, 8.8, 100, Dps4, 0
		[576.00] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005FC, 446344, Broodtwister Ovi'nax, 3.6, 100, Tank2, 0

Announces:
	Injection (%s) on >%s<, type=targetcount, spellId=442526, triggerDeltas = 36.94, 50.00, 50.00, 74.38, 50.02, 50.02, 71.13, 50.02, 50.04
		[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps16: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000019, Dps16, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[ 86.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps11: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000013, Dps11, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
			 Triggered 2x, delta times: 86.94, 50.00
		[211.32] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps10, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps6: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000008, Dps6, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[311.36] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps12: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps12, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000005, Tank1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[432.51] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps3: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000003, Dps3, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0

Special warnings:
	Volatile Concoction on >%s< - taunt now, type=taunt, spellId=441362, triggerDeltas = 3.70, 55.35, 40.43, 39.56, 40.11, 54.45, 40.02, 39.87, 40.05, 71.19, 39.98, 40.15, 39.85, 39.98
		[  3.70] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
			 Triggered 14x, delta times: 3.70, 55.35, 40.43, 39.56, 40.11, 54.45, 40.02, 39.87, 40.05, 71.19, 39.98, 40.15, 39.85, 39.98
	Container Breach! (%s), type=count, spellId=442432, triggerDeltas = 15.03, 171.46, 172.40
		[ 15.03] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000745, 442430, Broodtwister Ovi'nax, 97, 0, Dps4, 0
		[186.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000293, 442430, Broodtwister Ovi'nax, 67, 0, Dps4, 0
		[358.89] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000501, 442430, Broodtwister Ovi'nax, 38.5, 0, Dps4, 0
	%s damage - move away, type=gtfo, spellId=442799, triggerDeltas = 182.53, 3.57, 336.25, 25.05, 5.34, 3.13, 3.09, 4.01, 18.25, 4.79, 4.74, 4.83, 3.05
		[182.53] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
			 Triggered 9x, delta times: 182.53, 3.57, 361.30, 5.34, 3.13, 3.09, 31.79, 4.83, 3.05
		[522.35] SPELL_PERIODIC_MISSED: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
			 Triggered 4x, delta times: 522.35, 40.62, 18.25, 4.79
	Poison Burst - interrupt >%s<!, type=interrupt, spellId=446700, triggerDeltas = 47.47, 0.00, 6.72, 0.01, 4.87, 0.01, 4.85, 3.63, 29.44, 0.00, 5.45, 1.11, 4.78, 4.89, 34.14, 74.50, 0.00, 3.87, 2.43, 4.88, 4.85, 34.30, 0.00, 0.00, 3.86, 2.43, 4.88, 4.84, 104.90, 0.00, 0.00, 3.00, 3.60, 0.00, 3.66, 0.00, 6.07, 4.88, 28.08, 0.00, 3.75, 2.50, 3.58, 0.00, 4.87, 1.21, 4.88, 29.22, 0.00, 0.82, 2.92, 1.21, 2.01, 1.62, 1.22, 2.02, 0.42, 3.63, 0.80, 6.08, 6.06, 4.86, 3.65
		[ 47.47] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000CE, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
			 Triggered 63x, delta times: 47.47, 0.00, 6.72, 0.01, 4.87, 0.01, 4.85, 3.63, 29.44, 0.00, 5.45, 1.11, 4.78, 4.89, 34.14, 74.50, 0.00, 3.87, 2.43, 4.88, 4.85, 34.30, 0.00, 0.00, 3.86, 2.43, 4.88, 4.84, 104.90, 0.00, 0.00, 3.00, 3.60, 0.00, 3.66, 0.00, 6.07, 4.88, 28.08, 0.00, 3.75, 2.50, 3.58, 0.00, 4.87, 1.21, 4.88, 29.22, 0.00, 0.82, 2.92, 1.21, 2.01, 1.62, 1.22, 2.02, 0.42, 3.63, 0.80, 6.08, 6.06, 4.86, 3.65

Yells:
	None

Voice pack sounds:
	VoicePack/kickcast
		[ 47.47] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000CE, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
			 Triggered 63x, delta times: 47.47, 0.00, 6.72, 0.01, 4.87, 0.01, 4.85, 3.63, 29.44, 0.00, 5.45, 1.11, 4.78, 4.89, 34.14, 74.50, 0.00, 3.87, 2.43, 4.88, 4.85, 34.30, 0.00, 0.00, 3.86, 2.43, 4.88, 4.84, 104.90, 0.00, 0.00, 3.00, 3.60, 0.00, 3.66, 0.00, 6.07, 4.88, 28.08, 0.00, 3.75, 2.50, 3.58, 0.00, 4.87, 1.21, 4.88, 29.22, 0.00, 0.82, 2.92, 1.21, 2.01, 1.62, 1.22, 2.02, 0.42, 3.63, 0.80, 6.08, 6.06, 4.86, 3.65
	VoicePack/specialsoon
		[ 15.03] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000745, 442430, Broodtwister Ovi'nax, 97, 0, Dps4, 0
		[186.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000293, 442430, Broodtwister Ovi'nax, 67, 0, Dps4, 0
		[358.89] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000501, 442430, Broodtwister Ovi'nax, 38.5, 0, Dps4, 0
	VoicePack/tauntboss
		[  3.70] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
			 Triggered 14x, delta times: 3.70, 55.35, 40.43, 39.56, 40.11, 54.45, 40.02, 39.87, 40.05, 71.19, 39.98, 40.15, 39.85, 39.98
	VoicePack/watchfeet
		[182.53] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
			 Triggered 9x, delta times: 182.53, 3.57, 361.30, 5.34, 3.13, 3.09, 31.79, 4.83, 3.05
		[522.35] SPELL_PERIODIC_MISSED: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
			 Triggered 4x, delta times: 522.35, 40.62, 18.25, 4.79

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 442526 442432 443003 443005 446700, SPELL_AURA_APPLIED 446349 446694 446690 442263 442250 442250 440421 441362, SPELL_AURA_REMOVED 446349 446694 446690 442263 442250 440421, SPELL_PERIODIC_DAMAGE 442799, SPELL_PERIODIC_MISSED 442799, UNIT_SPELLCAST_SUCCEEDED boss1
		StartTimer: 1.9, Tank Debuff (1)
		StartTimer: 15.4, Container Breach (1)
		StartTimer: 15.0, Webs (1)
	[  1.99] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (2)
	[  3.70] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 14.98] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000006BC, 446344, Broodtwister Ovi'nax, 97, 99, Dps4, 0
		StartTimer: 30.0, Webs (2)
	[ 15.03] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000745, 442430, Broodtwister Ovi'nax, 97, 0, Dps4, 0
		ShowSpecialWarning: Container Breach! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 166.4, Container Breach (2)
		StopTimer: Timer446349cdcount\t2
		StopTimer: Timer441362cdcount\t2
	[ 19.40] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
		AntiSpam: 1
		StartTimer: 16.0, Injection (1)
		StartTimer: 18.0, Tank Debuff (2)
		StartTimer: 31.0, Webs (2)
	[ 35.41] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (2)
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 37.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 36.94
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps9: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps9, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 36.94
		ScheduleTask: (anonymous function) at 37.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 36.94
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps13: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000015, Dps13, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 36.94
		ScheduleTask: (anonymous function) at 37.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 36.94
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps17: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000020, Dps17, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 36.94
		ScheduleTask: (anonymous function) at 37.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 36.94
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps14: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000016, Dps14, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 36.94
		ScheduleTask: (anonymous function) at 37.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 36.94
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps12: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps12, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 36.94
		ScheduleTask: (anonymous function) at 37.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 36.94
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps10, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 36.94
		ScheduleTask: (anonymous function) at 37.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 36.94
	[ 36.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps16: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000019, Dps16, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 36.94
		ShowAnnounce: Injection (2) on Dps7, Dps14, Dps12, Dps10, Dps17, Dps9, Dps13, Dps16
	[ 37.42] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (3)
	[ 47.47] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000CE, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 47.47] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000018, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 50.44] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000379, 446344, Broodtwister Ovi'nax, 91.1, 9, Tank2, 0
		StartTimer: 30.0, Webs (3)
	[ 54.19] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000CE, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 54.20] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000018, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 57.45] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (4)
	[ 59.05] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 59.07] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000CE, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 59.08] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000018, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 63.93] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000CE, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 67.56] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000CE, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 77.43] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (5)
	[ 80.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000001ED, 446344, Broodtwister Ovi'nax, 84.9, 30, Tank2, 0
		StartTimer: 30.0, Webs (4)
	[ 85.43] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (3)
	[ 86.93] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps15: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000017, Dps15, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 87.43 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 86.93
	[ 86.93] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps12: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps12, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 86.93
		ScheduleTask: (anonymous function) at 87.43 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 86.93
	[ 86.93] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 86.93
		ScheduleTask: (anonymous function) at 87.43 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 86.94
	[ 86.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000005, Tank1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 86.93
		ScheduleTask: (anonymous function) at 87.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 86.94
	[ 86.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps13: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000015, Dps13, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 86.94
		ScheduleTask: (anonymous function) at 87.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 86.94
	[ 86.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps16: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000019, Dps16, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 86.94
		ScheduleTask: (anonymous function) at 87.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 86.94
	[ 86.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps2: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000002, Dps2, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 86.94
		ScheduleTask: (anonymous function) at 87.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 86.94
	[ 86.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps11: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000013, Dps11, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 86.94
		ShowAnnounce: Injection (3) on Dps15, Dps13, Dps16, Dps2, Tank1, Dps12, Dps8, Dps11
	[ 97.00] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000D4, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 97.00] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002A, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 97.49] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (6)
	[ 99.48] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[102.45] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002A, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[103.56] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000D4, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[108.34] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000D4, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[110.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000216, 446344, Broodtwister Ovi'nax, 79.5, 50, Dps4, 0
		StartTimer: 30.0, Webs (5)
	[113.23] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000D4, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[117.42] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (7)
	[135.43] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (4)
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps3: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000003, Dps3, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 137.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 136.94
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps5: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000007, Dps5, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 136.94
		ScheduleTask: (anonymous function) at 137.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 136.94
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000001, Dps1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 136.94
		ScheduleTask: (anonymous function) at 137.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 136.94
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps6: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000008, Dps6, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 136.94
		ScheduleTask: (anonymous function) at 137.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 136.94
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps13: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000015, Dps13, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 136.94
		ScheduleTask: (anonymous function) at 137.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 136.94
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps10, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 136.94
		ScheduleTask: (anonymous function) at 137.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 136.94
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 136.94
		ScheduleTask: (anonymous function) at 137.44 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 136.94
	[136.94] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps11: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000013, Dps11, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 136.94
		ShowAnnounce: Injection (4) on Dps3, Dps13, Dps10, Dps7, Dps6, Dps5, Dps1, Dps11
	[137.43] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (8)
	[139.04] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[140.46] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000001FB, 446344, Broodtwister Ovi'nax, 74.8, 70, Dps4, 0
		StartTimer: 30.0, Webs (6)
	[147.37] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000035, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[157.43] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (9)
	[170.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000284, 446344, Broodtwister Ovi'nax, 69.1, 90, Tank2, 0
		StartTimer: 30.0, Webs (7)
	[177.42] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (10)
	[179.15] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[182.53] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 5x SPELL_PERIODIC_DAMAGE at 183.03, 183.52, 184.02, 184.52, 185.02
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[186.10] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[186.49] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000293, 442430, Broodtwister Ovi'nax, 67, 0, Dps4, 0
		ShowSpecialWarning: Container Breach! (2)
		PlaySound: VoicePack/specialsoon
		StartTimer: 166.4, Container Breach (3)
		StopTimer: Timer446349cdcount\t7
		StopTimer: Timer441362cdcount\t10
	[193.79] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
		AntiSpam: 1
		StartTimer: 16.0, Injection (4)
		StartTimer: 18.0, Tank Debuff (10)
		StartTimer: 31.0, Webs (7)
	[209.82] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (5)
	[211.31] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps13: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000015, Dps13, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 211.81 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 211.31
	[211.31] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps11: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000013, Dps11, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.31
		ScheduleTask: (anonymous function) at 211.81 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 211.32
	[211.32] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps3: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000003, Dps3, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.31
		ScheduleTask: (anonymous function) at 211.82 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 211.32
	[211.32] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.32
		ScheduleTask: (anonymous function) at 211.82 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 211.32
	[211.32] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000005, Tank1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.32
		ScheduleTask: (anonymous function) at 211.82 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 211.32
	[211.32] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps6: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000008, Dps6, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.32
		ScheduleTask: (anonymous function) at 211.82 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 211.32
	[211.32] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps9: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps9, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.32
		ScheduleTask: (anonymous function) at 211.82 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 211.32
	[211.32] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps10, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 211.32
		ShowAnnounce: Injection (5) on Dps13, Tank1, Dps6, Dps9, Dps8, Dps11, Dps3, Dps10
	[211.82] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (11)
	[221.87] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000E4, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[221.87] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000050, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[224.85] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000B31, 446344, Broodtwister Ovi'nax, 61.4, 10, Tank2, 0
		StartTimer: 30.0, Webs (8)
	[225.74] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000E4, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[228.17] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000050, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[231.84] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (12)
	[233.05] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000050, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[233.60] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[237.90] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000050, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[251.81] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (13)
	[254.81] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000003E9, 446344, Broodtwister Ovi'nax, 55.8, 30, Tank2, 0
		StartTimer: 30.0, Webs (9)
	[259.83] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (6)
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps11: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000013, Dps11, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 261.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 261.34
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 261.34
		ScheduleTask: (anonymous function) at 261.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 261.34
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps13: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000015, Dps13, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 261.34
		ScheduleTask: (anonymous function) at 261.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 261.34
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps2: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000002, Dps2, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 261.34
		ScheduleTask: (anonymous function) at 261.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 261.34
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000005, Tank1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 261.34
		ScheduleTask: (anonymous function) at 261.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 261.34
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps10, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 261.34
		ScheduleTask: (anonymous function) at 261.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 261.34
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps12: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps12, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 261.34
		ScheduleTask: (anonymous function) at 261.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 261.34
	[261.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps6: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000008, Dps6, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 261.34
		ShowAnnounce: Injection (6) on Dps11, Tank1, Dps10, Dps12, Dps2, Dps8, Dps13, Dps6
	[271.92] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (14)
	[272.20] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000126, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[272.20] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000EA, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[272.20] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000005E, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[273.62] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[276.06] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000126, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[278.49] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000005E, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[283.37] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000005E, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[284.81] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005E0, 446344, Broodtwister Ovi'nax, 50.5, 50, Dps4, 0
		StartTimer: 30.0, Webs (10)
	[288.21] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000005E, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[291.82] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (15)
	[309.83] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (7)
	[311.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps5: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000007, Dps5, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 311.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 311.34
	[311.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps17: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000020, Dps17, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 311.34
		ScheduleTask: (anonymous function) at 311.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 311.34
	[311.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000001, Dps1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 311.34
		ScheduleTask: (anonymous function) at 311.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 311.34
	[311.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps9: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps9, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 311.34
		ScheduleTask: (anonymous function) at 311.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 311.34
	[311.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps14: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000016, Dps14, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 311.34
		ScheduleTask: (anonymous function) at 311.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 311.34
	[311.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps3: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000003, Dps3, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 311.34
		ScheduleTask: (anonymous function) at 311.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 311.34
	[311.34] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 311.34
		ScheduleTask: (anonymous function) at 311.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 311.36
	[311.36] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps12: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps12, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 311.34
		ShowAnnounce: Injection (7) on Dps5, Dps14, Dps3, Dps8, Dps9, Dps17, Dps1, Dps12
	[311.83] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (16)
	[313.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[314.81] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000376, 446344, Broodtwister Ovi'nax, 45.9, 70, Dps4, 0
		StartTimer: 30.0, Webs (11)
	[331.84] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (17)
	[344.86] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005BA, 446344, Broodtwister Ovi'nax, 40.5, 90, Tank2, 0
		StartTimer: 30.0, Webs (12)
	[351.84] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (18)
	[353.54] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[358.89] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000501, 442430, Broodtwister Ovi'nax, 38.5, 0, Dps4, 0
		ShowSpecialWarning: Container Breach! (3)
		PlaySound: VoicePack/specialsoon
		StartTimer: 166.4, Container Breach (4)
		StopTimer: Timer446349cdcount\t12
		StopTimer: Timer441362cdcount\t18
		StopTimer: Timer442526cdcount\t7
	[364.97] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
		AntiSpam: 1
		StartTimer: 16.0, Injection (7)
		StartTimer: 18.0, Tank Debuff (18)
		StartTimer: 31.0, Webs (12)
	[380.99] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (8)
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps5: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000007, Dps5, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 382.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 382.49
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps11: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000013, Dps11, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 382.49
		ScheduleTask: (anonymous function) at 382.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 382.49
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps16: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000019, Dps16, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 382.49
		ScheduleTask: (anonymous function) at 382.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 382.49
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps9: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps9, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 382.49
		ScheduleTask: (anonymous function) at 382.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 382.49
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps10, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 382.49
		ScheduleTask: (anonymous function) at 382.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 382.49
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 382.49
		ScheduleTask: (anonymous function) at 382.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 382.49
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps6: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000008, Dps6, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 382.49
		ScheduleTask: (anonymous function) at 382.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 382.49
	[382.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000005, Tank1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 382.49
		ShowAnnounce: Injection (8) on Dps5, Dps10, Dps8, Dps6, Dps9, Dps11, Dps16, Tank1
	[383.00] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (19)
	[393.11] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000131, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[393.11] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000F8, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[393.11] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000082, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[396.09] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000DF5, 446344, Broodtwister Ovi'nax, 32.9, 9, Tank2, 0
		StartTimer: 30.0, Webs (13)
	[396.11] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000082, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[399.71] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000131, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[399.71] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000F8, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[403.03] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (20)
	[403.37] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000131, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[403.37] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000F8, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[409.44] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000F8, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[414.32] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000F8, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[423.01] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (21)
	[424.73] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[425.98] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-000000053A, 446344, Broodtwister Ovi'nax, 25.3, 29, Dps4, 0
		StartTimer: 30.0, Webs (14)
	[431.01] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (9)
	[432.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps9: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps9, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 432.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 432.49
	[432.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps12: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps12, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 432.49
		ScheduleTask: (anonymous function) at 432.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 432.49
	[432.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 432.49
		ScheduleTask: (anonymous function) at 432.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 432.49
	[432.49] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000001, Dps1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 432.49
		ScheduleTask: (anonymous function) at 432.99 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 432.50
	[432.50] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps16: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000019, Dps16, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 432.49
		ScheduleTask: (anonymous function) at 433.00 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 432.50
	[432.50] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps5: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000007, Dps5, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 432.50
		ScheduleTask: (anonymous function) at 433.00 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 432.50
	[432.50] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000005, Tank1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 432.50
		ScheduleTask: (anonymous function) at 433.00 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 432.51
	[432.51] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 432.50
		ShowAnnounce: Injection (9) on Dps9, Dps16, Dps5, Tank1, Dps1, Dps12, Dps7, Dps8
	[442.40] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000100, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[442.40] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000096, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[443.01] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (22)
	[446.15] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000096, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[448.65] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000100, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[452.23] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000100, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[452.23] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000096, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[455.99] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-000000046E, 446344, Broodtwister Ovi'nax, 21, 50, Dps4, 0
		StartTimer: 30.0, Webs (15)
	[457.10] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000096, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[458.31] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000100, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[462.99] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (23)
	[463.19] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000100, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[464.71] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[481.00] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (10)
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps10, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 483.05 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 482.55
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps9: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps9, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 482.55
		ScheduleTask: (anonymous function) at 483.05 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 482.55
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps5: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000007, Dps5, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 482.55
		ScheduleTask: (anonymous function) at 483.05 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 482.55
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps12: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps12, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 482.55
		ScheduleTask: (anonymous function) at 483.05 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 482.55
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000010, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 482.55
		ScheduleTask: (anonymous function) at 483.05 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 482.55
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 482.55
		ScheduleTask: (anonymous function) at 483.05 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 482.55
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000005, Tank1, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 482.55
		ScheduleTask: (anonymous function) at 483.05 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 482.55
	[482.55] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps3: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000003, Dps3, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 482.55
		ShowAnnounce: Injection (10) on Dps10, Dps8, Dps7, Tank1, Dps12, Dps9, Dps5, Dps3
	[483.01] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (24)
	[486.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000513, 446344, Broodtwister Ovi'nax, 16.9, 70, Dps4, 0
		StartTimer: 30.0, Webs (16)
	[492.41] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000139, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[492.41] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000A2, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[493.23] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[496.15] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000A2, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[497.36] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000139, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[499.37] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[500.99] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000A2, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[502.21] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000139, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[503.05] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (25)
	[504.23] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[504.65] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000A2, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[504.86] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[508.28] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-00000000A2, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[509.08] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[515.16] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[516.00] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-000000062B, 446344, Broodtwister Ovi'nax, 13.2, 90, Dps4, 0
		StartTimer: 30.0, Webs (17)
	[521.22] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[522.35] SPELL_PERIODIC_MISSED: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 1x SPELL_PERIODIC_MISSED at 522.84
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[523.01] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (26)
	[526.08] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[529.73] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000103, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[543.01] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (27)
	[544.71] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[546.00] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005FA, 446344, Broodtwister Ovi'nax, 8.8, 100, Dps4, 0
		StartTimer: 30.0, Webs (18)
	[547.40] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 2x SPELL_PERIODIC_DAMAGE at 548.03, 548.55
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[552.74] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 4x SPELL_PERIODIC_DAMAGE at 553.69, 554.21, 554.86, 555.36
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[555.87] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 1x SPELL_PERIODIC_DAMAGE at 558.45
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[558.96] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[562.97] SPELL_PERIODIC_MISSED: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 1x SPELL_PERIODIC_DAMAGE at 563.47
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[563.00] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (28)
	[576.00] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-00000005FC, 446344, Broodtwister Ovi'nax, 3.6, 100, Tank2, 0
		StartTimer: 30.0, Webs (19)
	[581.22] SPELL_PERIODIC_MISSED: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_PERIODIC_MISSED at 581.97, 582.47, 582.97
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[583.01] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (29)
	[584.69] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank2: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000018, Tank2, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[586.01] SPELL_PERIODIC_MISSED: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 1x SPELL_PERIODIC_MISSED at 586.53
			Filtered: 2x SPELL_PERIODIC_DAMAGE at 588, 588.51
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[590.75] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 2x SPELL_PERIODIC_DAMAGE at 591.76, 592.25
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[595.58] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
			Filtered: 1x SPELL_PERIODIC_DAMAGE at 598.12
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[598.63] SPELL_PERIODIC_DAMAGE: [Broodtwister Ovi'nax->Dps4: Sanguine Overflow] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000004, Dps4, 0x511, 442799, Sanguine Overflow, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Sanguine Overflow damage - move away
		PlaySound: VoicePack/watchfeet
	[601.38] ENCOUNTER_END: 2919, Broodtwister Ovi'nax, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 446349 446694 446690 442263 442250 440421
]]
