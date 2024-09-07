DBM.Test:Report[[
Test: TWW/NerubarPalace/Ovinax/Mythic/Wipe
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
	Unused event registration: SPELL_PERIODIC_DAMAGE 442799 (Sanguine Overflow)
	Unused event registration: SPELL_PERIODIC_MISSED 442799 (Sanguine Overflow)
	Timer for spell ID 441362 (Volatile Concoction) is triggered by event SPELL_CAST_START 442432 (Ingest Black Blood)
	Timer for spell ID 441362 (Volatile Concoction) is triggered by event SPELL_CAST_START 443003 (Volatile Concoction)
	SpecialWarning for spell ID 442526 (Experimental Dosage) is triggered by event SPELL_AURA_APPLIED 440421 (Experimental Dosage)
	Timer for spell ID 442526 (Experimental Dosage) is triggered by event SPELL_CAST_START 442432 (Ingest Black Blood)
	Timer for spell ID 446349 (Sticky Web) is triggered by event SPELL_CAST_START 442432 (Ingest Black Blood)

Unused objects:
	[Special Warning] Volatile Concoction - defensive, type=defensive, spellId=441362
	[Special Warning] Fixate on you, type=you, spellId=442250
	[Special Warning] %s damage - move away, type=gtfo, spellId=442799
	[Special Warning] Web - move away from others, type=moveaway, spellId=446349
	[Yell] Web, type=shortyell, spellId=446349

Timers:
	Tank Debuff (%s), time=20.00, type=cdcount, spellId=441362, triggerDeltas = 0.00, 2.02, 14.60, 18.04, 19.97, 20.01, 20.02, 20.00, 19.99, 19.98, 20.00, 14.50, 18.04
		[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		[  2.02] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
			 Triggered 10x, delta times: 2.02, 32.64, 19.97, 20.01, 20.02, 20.00, 19.99, 19.98, 20.00, 32.54
		[ 15.40] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-00000000E0, 442430, Broodtwister Ovi'nax, 98.2, 0, Tank1, 0
		[ 16.62] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
			 Triggered 2x, delta times: 16.62, 172.51
		[183.10] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000146, 442430, Broodtwister Ovi'nax, 80, 0, Dps7, 0
	Container Breach (%s), time=170.00, type=cdcount, spellId=442432, triggerDeltas = 0.00, 15.40, 167.70
		[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		[ 15.40] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-00000000E0, 442430, Broodtwister Ovi'nax, 98.2, 0, Tank1, 0
		[183.10] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000146, 442430, Broodtwister Ovi'nax, 80, 0, Dps7, 0
	Injection (%s), time=50.00, type=cdcount, spellId=442526, triggerDeltas = 16.62, 16.02, 49.99, 50.04, 56.46, 16.01
		[ 16.62] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
			 Triggered 2x, delta times: 16.62, 172.51
		[ 32.64] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
			 Triggered 4x, delta times: 32.64, 49.99, 50.04, 72.47
	Webs (%s), time=30.00, type=cdcount, spellId=446349, triggerDeltas = 0.00, 15.02, 1.60, 31.08, 29.94, 29.98, 30.03, 29.97, 21.51
		[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		[ 15.02] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000212, 446344, Broodtwister Ovi'nax, 98.3, 100, Tank1, 0
		[ 15.40] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-00000000E0, 442430, Broodtwister Ovi'nax, 98.2, 0, Tank1, 0
		[ 16.62] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
			 Triggered 2x, delta times: 16.62, 172.51
		[ 47.70] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000240, 446344, Broodtwister Ovi'nax, 92.8, 10, Dps7, 0
		[ 77.64] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000135, 446344, Broodtwister Ovi'nax, 86.7, 30, Dps7, 0
		[107.62] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000143, 446344, Broodtwister Ovi'nax, 83.1, 50, Tank1, 0
		[137.65] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000096, 446344, Broodtwister Ovi'nax, 80.3, 70, Dps7, 0
		[167.62] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000081, 446344, Broodtwister Ovi'nax, 80.1, 90, Dps7, 0
		[183.10] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000146, 442430, Broodtwister Ovi'nax, 80, 0, Dps7, 0

Announces:
	Injection (%s) on >%s<, type=targetcount, spellId=442526, triggerDeltas = 34.65, 50.03, 49.99, 72.50
		[ 34.65] Scheduled at 34.15 by SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[ 84.68] Scheduled at 84.18 by SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[134.67] Scheduled at 134.17 by SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		[207.17] Scheduled at 206.67 by SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0

Special warnings:
	Volatile Concoction on >%s< - taunt now, type=taunt, spellId=441362, triggerDeltas = 3.70, 33.04, 19.50, 20.14, 19.98, 20.04, 20.02, 19.96, 20.02, 33.78
		[  3.70] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
			 Triggered 7x, delta times: 3.70, 52.54, 40.12, 40.06, 19.96, 20.02, 33.78
		[ 36.74] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Tank1, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
			 Triggered 3x, delta times: 36.74, 39.64, 40.02
	Container Breach! (%s), type=count, spellId=442432, triggerDeltas = 15.40, 167.70
		[ 15.40] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-00000000E0, 442430, Broodtwister Ovi'nax, 98.2, 0, Tank1, 0
		[183.10] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000146, 442430, Broodtwister Ovi'nax, 80, 0, Dps7, 0
	Injection - move to >%s<, type=moveto, spellId=442526, triggerDeltas = 34.14, 50.03
		[ 34.14] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps10, 0x511, 440421, Experimental Dosage, 0, DEBUFF, 0
			 Triggered 2x, delta times: 34.14, 50.03
	Poison Burst - interrupt >%s<!, type=interrupt, spellId=446700, triggerDeltas = 94.40, 6.09, 6.08, 4.84, 4.86, 70.46, 2.40, 0.40, 2.04, 0.40, 2.03, 0.40, 2.03, 0.40, 2.00, 0.40, 2.04, 0.40, 2.03, 0.40, 2.03, 0.40, 2.01, 0.44, 2.00
		[ 94.40] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002B, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
			 Triggered 25x, delta times: 94.40, 6.09, 6.08, 4.84, 4.86, 70.46, 2.40, 0.40, 2.04, 0.40, 2.03, 0.40, 2.03, 0.40, 2.00, 0.40, 2.04, 0.40, 2.03, 0.40, 2.03, 0.40, 2.01, 0.44, 2.00

Yells:
	None

Voice pack sounds:
	VoicePack/kickcast
		[ 94.40] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002B, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
			 Triggered 25x, delta times: 94.40, 6.09, 6.08, 4.84, 4.86, 70.46, 2.40, 0.40, 2.04, 0.40, 2.03, 0.40, 2.03, 0.40, 2.00, 0.40, 2.04, 0.40, 2.03, 0.40, 2.03, 0.40, 2.01, 0.44, 2.00
	VoicePack/movetoegg
		[ 34.14] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps10, 0x511, 440421, Experimental Dosage, 0, DEBUFF, 0
			 Triggered 2x, delta times: 34.14, 50.03
	VoicePack/specialsoon
		[ 15.40] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-00000000E0, 442430, Broodtwister Ovi'nax, 98.2, 0, Tank1, 0
		[183.10] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000146, 442430, Broodtwister Ovi'nax, 80, 0, Dps7, 0
	VoicePack/tauntboss
		[  3.70] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
			 Triggered 7x, delta times: 3.70, 52.54, 40.12, 40.06, 19.96, 20.02, 33.78
		[ 36.74] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Tank1, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
			 Triggered 3x, delta times: 36.74, 39.64, 40.02

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2919, Broodtwister Ovi'nax, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 442526 442432 443003 443005 446700, SPELL_AURA_APPLIED 446349 446694 446690 442263 442250 442250 440421 441362, SPELL_AURA_REMOVED 446349 446694 446690 442263 442250 440421, SPELL_PERIODIC_DAMAGE 442799, SPELL_PERIODIC_MISSED 442799, UNIT_SPELLCAST_SUCCEEDED boss1
		StartTimer: 1.9, Tank Debuff (1)
		StartTimer: 15.6, Container Breach (1)
		StartTimer: 15.0, Webs (1)
	[  2.02] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (2)
	[  3.70] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Dps7 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 15.02] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000212, 446344, Broodtwister Ovi'nax, 98.3, 100, Tank1, 0
		StartTimer: 30.0, Webs (2)
	[ 15.40] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-00000000E0, 442430, Broodtwister Ovi'nax, 98.2, 0, Tank1, 0
		ShowSpecialWarning: Container Breach! (1)
		PlaySound: VoicePack/specialsoon
		StartTimer: 170.0, Container Breach (2)
		StopTimer: Timer446349cdcount\t2
		StopTimer: Timer441362cdcount\t2
	[ 16.62] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
		AntiSpam: 1
		StartTimer: 16.0, Injection (1)
		StartTimer: 18.0, Tank Debuff (2)
		StartTimer: 31.0, Webs (2)
	[ 32.64] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (2)
	[ 34.14] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps10, 0x511, 440421, Experimental Dosage, 0, DEBUFF, 0
		ShowSpecialWarning: Injection - move to Break Egg
		PlaySound: VoicePack/movetoegg
	[ 34.15] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: announce442526targetcount:CombinedShow(2.0, "Dps8") at 34.65 (+0.50)
			ShowAnnounce: Injection (2) on Dps14, Dps12, Dps3, Dps15, PlayerName, Dps1, Dps2 and one other
	[ 34.66] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (3)
	[ 36.74] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Tank1, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 47.70] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000240, 446344, Broodtwister Ovi'nax, 92.8, 10, Dps7, 0
		StartTimer: 30.0, Webs (3)
	[ 54.63] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (4)
	[ 56.24] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Dps7 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 74.64] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (5)
	[ 76.38] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Tank1, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 77.64] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000135, 446344, Broodtwister Ovi'nax, 86.7, 30, Dps7, 0
		StartTimer: 30.0, Webs (4)
	[ 82.63] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (3)
	[ 84.17] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps10: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000014, Dps10, 0x511, 440421, Experimental Dosage, 0, DEBUFF, 0
		ShowSpecialWarning: Injection - move to Break Egg
		PlaySound: VoicePack/movetoegg
	[ 84.18] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps8: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000012, Dps8, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: announce442526targetcount:CombinedShow(3.0, "Dps8") at 84.68 (+0.50)
			ShowAnnounce: Injection (3) on Dps11, Dps6, Dps13, Dps2, PlayerName, Dps9, Dps4 and one other
	[ 94.40] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002B, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[ 94.66] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (6)
	[ 96.36] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Dps7 - taunt now
		PlaySound: VoicePack/tauntboss
	[100.49] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002B, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[106.57] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002B, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[107.62] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000143, 446344, Broodtwister Ovi'nax, 83.1, 50, Tank1, 0
		StartTimer: 30.0, Webs (5)
	[111.41] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002B, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[114.66] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (7)
	[116.27] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-000000002B, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[116.40] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Tank1: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000009, Tank1, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[132.67] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (4)
	[134.17] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: announce442526targetcount:CombinedShow(4.0, "Dps7") at 134.67 (+0.50)
			ShowAnnounce: Injection (4) on Dps2, Dps6, Dps11, Dps7
	[134.65] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (8)
	[136.42] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Dps7 - taunt now
		PlaySound: VoicePack/tauntboss
	[137.65] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000096, 446344, Broodtwister Ovi'nax, 80.3, 70, Dps7, 0
		StartTimer: 30.0, Webs (6)
	[154.63] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (9)
	[156.38] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Dps7 - taunt now
		PlaySound: VoicePack/tauntboss
	[167.62] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-446344-0000000081, 446344, Broodtwister Ovi'nax, 80.1, 90, Dps7, 0
		StartTimer: 30.0, Webs (7)
	[174.63] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (10)
	[176.40] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Dps7 - taunt now
		PlaySound: VoicePack/tauntboss
	[183.10] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-442430-0000000146, 442430, Broodtwister Ovi'nax, 80, 0, Dps7, 0
		ShowSpecialWarning: Container Breach! (2)
		PlaySound: VoicePack/specialsoon
		StartTimer: 170.0, Container Breach (3)
		StopTimer: Timer446349cdcount\t7
		StopTimer: Timer441362cdcount\t10
	[186.73] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[189.13] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[189.13] SPELL_CAST_START: [Broodtwister Ovi'nax: Ingest Black Blood] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442432, Ingest Black Blood, 0, 0
		AntiSpam: 1
		StartTimer: 16.0, Injection (4)
		StartTimer: 18.0, Tank Debuff (10)
		StartTimer: 31.0, Webs (7)
	[189.53] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[191.57] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[191.97] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[194.00] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[194.40] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[196.43] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[196.83] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[198.83] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[199.23] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[201.27] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[201.67] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[203.70] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[204.10] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[205.14] SPELL_CAST_START: [Broodtwister Ovi'nax: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 442526, Experimental Dosage, 0, 0
		StartTimer: 50.0, Injection (5)
	[206.13] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[206.53] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[206.67] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Experimental Dosage] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 440421, Experimental Dosage, 0, DEBUFF, 0
		ScheduleTask: announce442526targetcount:CombinedShow(5.0, "Dps7") at 207.17 (+0.50)
			ShowAnnounce: Injection (5) on Dps7
	[207.17] SPELL_CAST_START: [Broodtwister Ovi'nax: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, "", nil, 0x0, 443003, Volatile Concoction, 0, 0
		StartTimer: 20.0, Tank Debuff (11)
	[208.54] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[208.98] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000043, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[210.18] SPELL_AURA_APPLIED: [Broodtwister Ovi'nax->Dps7: Volatile Concoction] Creature-0-1-2657-1-214506-0000000001, Broodtwister Ovi'nax, 0xa48, Player-1-00000011, Dps7, 0x512, 441362, Volatile Concoction, 0, DEBUFF, 0
		ShowSpecialWarning: Volatile Concoction on Dps7 - taunt now
		PlaySound: VoicePack/tauntboss
	[210.98] SPELL_CAST_START: [Voracious Worm: Poison Burst] Creature-0-1-2657-1-219046-0000000041, Voracious Worm, 0xa48, "", nil, 0x0, 446700, Poison Burst, 0, 0
		ShowSpecialWarning: Poison Burst - interrupt Voracious Worm!
		PlaySound: VoicePack/kickcast
	[211.40] ENCOUNTER_END: 2919, Broodtwister Ovi'nax, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 446349 446694 446690 442263 442250 440421
]]
