DBM.Test:Report[[
Test: TWW/NerubarPalace/Ulgrax/Mythic/Wipe1
Mod:  DBM-Raids-WarWithin/2607

Findings:
	Unused event registration: SPELL_AURA_APPLIED 434705 (Tenderized)
	Unused event registration: SPELL_AURA_APPLIED 439419 (Stalker Netting)
	Unused event registration: SPELL_AURA_APPLIED 458129 (Brutal Lashings)
	Unused event registration: SPELL_AURA_REMOVED 435138 (Digestive Acid)
	Unused event registration: SPELL_AURA_REMOVED 458129 (Brutal Lashings)
	Unused event registration: SPELL_CAST_START 441451 (Stalkers Webbing)
	Unused event registration: SPELL_CAST_START 445290 (Hulking Crash)
	Unused event registration: SPELL_CAST_START 451412 (Swallowing Darkness)
	Announce for spell ID 436200 (Juggernaut Charge) is triggered by event SPELL_CAST_START 436203 (Juggernaut Charge)
	Timer for spell ID 436200 (Juggernaut Charge) is triggered by event SPELL_CAST_START 436203 (Juggernaut Charge)
	Timer for spell ID 436200 (Juggernaut Charge) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)
	Timer for spell ID 438012 (Hungering Bellows) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)
	Timer for spell ID 443842 (Swallowing Darkness) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)
	Timer for spell ID 445052 (Chittering Swarm) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)

Unused objects:
	[Announce] Stalkers Webbing on >%s<, type=target, spellId=441452
	[Special Warning] Brutal Crush - defensive, type=defensive, spellId=434697
	[Special Warning] Tenderized on >%s< - taunt now, type=taunt, spellId=434705
	[Special Warning] Brutal Lashings - soak (%s), type=soakcount, spellId=434803
	[Yell] %d, type=shortfade, spellId=435138

Timers:
	Brutal Crush (%s), time=13.00, type=cdcount, spellId=434697, triggerDeltas = 0.00, 2.99, 12.97, 13.03, 21.98, 125.07, 7.31, 12.99, 12.99, 22.04, 135.06, 7.51, 13.02, 12.99, 22.01
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  2.99] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
			 Triggered 12x, delta times: 2.99, 12.97, 13.03, 21.98, 132.38, 12.99, 12.99, 22.04, 142.57, 13.02, 12.99, 22.01
		[176.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000308, 441425, Ulgrax the Devourer, 39.7, 100, Dps10, 0
		[366.43] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000045B, 441425, Ulgrax the Devourer, 13.2, 100, Tank3, 0
	Brutal Lashings (%s), time=36.00, type=cdcount, spellId=434803, triggerDeltas = 0.00, 32.97, 143.07, 37.31, 153.08, 37.52
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[ 32.97] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Lashings] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434803, Brutal Lashings, 0, 0
			 Triggered 3x, delta times: 32.97, 180.38, 190.60
		[176.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000308, 441425, Ulgrax the Devourer, 39.7, 100, Dps10, 0
		[366.43] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000045B, 441425, Ulgrax the Devourer, 13.2, 100, Tank3, 0
	Venomous Lash (%s), time=32.90, type=cdcount, spellId=435136, triggerDeltas = 0.00, 4.98, 24.98, 146.08, 9.32, 25.01, 156.06, 9.54, 24.97
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  4.98] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
			 Triggered 6x, delta times: 4.98, 24.98, 155.40, 25.01, 165.60, 24.97
		[176.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000308, 441425, Ulgrax the Devourer, 39.7, 100, Dps10, 0
		[366.43] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000045B, 441425, Ulgrax the Devourer, 13.2, 100, Tank3, 0
	100, time=49.00, type=cdcount, spellId=436200, triggerDeltas = 89.99, 13.73, 4.61, 7.11, 7.08, 147.84, 11.47, 4.61, 7.03, 7.15
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 2x, delta times: 89.99, 180.37
		[103.72] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
			 Triggered 2x, delta times: 103.72, 178.11
		[108.33] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 6x, delta times: 108.33, 7.11, 7.08, 163.92, 7.03, 7.15
	Hungering Bellows (%s), time=9.00, type=cdcount, spellId=438012, triggerDeltas = 89.99, 60.53, 9.01, 8.99, 101.84, 58.07, 8.97, 9.03, 8.99, 5.99
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 2x, delta times: 89.99, 180.37
		[150.52] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
			 Triggered 8x, delta times: 150.52, 9.01, 8.99, 159.91, 8.97, 9.03, 8.99, 5.99
		[176.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000308, 441425, Ulgrax the Devourer, 39.7, 100, Dps10, 0
		[366.43] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000045B, 441425, Ulgrax the Devourer, 13.2, 100, Tank3, 0
	Stage %s, time=10.00, type=stagecount, spellId=438012, triggerDeltas = 0.00, 176.04, 190.39
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[176.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000308, 441425, Ulgrax the Devourer, 39.7, 100, Dps10, 0
		[366.43] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000045B, 441425, Ulgrax the Devourer, 13.2, 100, Tank3, 0
	Stalkers Webbing (%s), time=49.00, type=cdcount, spellId=441452, triggerDeltas = 0.00, 8.98, 167.06, 13.34, 177.05, 13.53
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  8.98] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
			 Triggered 3x, delta times: 8.98, 180.40, 190.58
		[176.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000308, 441425, Ulgrax the Devourer, 39.7, 100, Dps10, 0
		[366.43] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000045B, 441425, Ulgrax the Devourer, 13.2, 100, Tank3, 0
	Swallowing Darkness, time=49.00, type=cd, spellId=443842, triggerDeltas = 89.99, 180.37
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 2x, delta times: 89.99, 180.37
	Chittering Swarm, time=49.00, type=cd, spellId=445052, triggerDeltas = 89.99, 180.37
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 2x, delta times: 89.99, 180.37

Announces:
	Venomous Lash (%s), type=count, spellId=435136, triggerDeltas = 4.98, 24.98, 28.01, 127.39, 25.01, 27.97, 137.63, 24.97, 28.01
		[  4.98] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
			 Triggered 9x, delta times: 4.98, 24.98, 28.01, 127.39, 25.01, 27.97, 137.63, 24.97, 28.01
	Digestive Acid on >%s<, type=target, spellId=435138, triggerDeltas = 22.01, 43.98, 136.36, 44.01, 146.59, 44.05
		[ 22.01] Scheduled at 21.01 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Tank6: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000017, Tank6, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[ 65.99] Scheduled at 64.99 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps4: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000009, Dps4, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[202.35] Scheduled at 201.35 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps9: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000019, Dps9, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[246.36] Scheduled at 245.36 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Tank5: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000014, Tank5, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[392.95] Scheduled at 391.95 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000001, Dps1, 0x511, 435138, Digestive Acid, 0, DEBUFF, 0
		[437.00] Scheduled at 436.00 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps7: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000016, Dps7, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
	Charge (%s), type=count, spellId=436200, triggerDeltas = 108.33, 7.11, 7.08, 7.03, 156.89, 7.03, 7.15, 7.07
		[108.33] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 8x, delta times: 108.33, 7.11, 7.08, 7.03, 156.89, 7.03, 7.15, 7.07
	Hungering Bellows (%s), type=count, spellId=438012, triggerDeltas = 150.52, 9.01, 8.99, 159.91, 8.97, 9.03, 8.99, 5.99
		[150.52] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
			 Triggered 8x, delta times: 150.52, 9.01, 8.99, 159.91, 8.97, 9.03, 8.99, 5.99
	Hardened Netting on >%s<, type=target, spellId=455831, triggerDeltas = 14.10, 1.03, 45.50, 68.02, 65.74, 11.78, 178.84, 5.21, 3.32
		[ 14.10] Scheduled at 13.60 by SPELL_AURA_APPLIED: [Hardened Netting->Dps5: Hardened Netting] Creature-0-1-2657-1-219586-0000000011, Hardened Netting, 0xa48, Player-1-00000010, Dps5, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[ 15.13] Scheduled at 14.63 by SPELL_AURA_APPLIED: [Hardened Netting->Dps5: Hardened Netting] Creature-0-1-2657-1-219586-0000000012, Hardened Netting, 0xa48, Player-1-00000010, Dps5, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[ 60.63] Scheduled at 60.13 by SPELL_AURA_APPLIED: [Hardened Netting->Healer3: Hardened Netting] Creature-0-1-2657-1-219586-000000002F, Hardened Netting, 0xa48, Player-1-00000008, Healer3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[128.65] Scheduled at 128.15 by SPELL_AURA_APPLIED: [Hardened Netting->Tank5: Hardened Netting] Creature-0-1-2657-1-219586-0000000105, Hardened Netting, 0xa48, Player-1-00000014, Tank5, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[194.39] Scheduled at 193.89 by SPELL_AURA_APPLIED: [Hardened Netting->Healer3: Hardened Netting] Creature-0-1-2657-1-219586-0000000146, Hardened Netting, 0xa48, Player-1-00000008, Healer3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[206.17] Scheduled at 205.67 by SPELL_AURA_APPLIED: [Hardened Netting->Dps7: Hardened Netting] Creature-0-1-2657-1-219586-0000000147, Hardened Netting, 0xa48, Player-1-00000016, Dps7, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[385.01] Scheduled at 384.51 by SPELL_AURA_APPLIED: [Hardened Netting->Healer3: Hardened Netting] Creature-0-1-2657-1-219586-00000000DF, Hardened Netting, 0xa48, Player-1-00000008, Healer3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[390.22] Scheduled at 389.72 by SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-00000000E2, Hardened Netting, 0xa48, Player-1-00000005, Tank1, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[393.54] Scheduled at 393.04 by SPELL_AURA_APPLIED: [Hardened Netting->Healer4: Hardened Netting] Creature-0-1-2657-1-219586-00000000E3, Hardened Netting, 0xa48, Player-1-00000012, Healer4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0

Special warnings:
	Brutal Lashings on you, type=you, spellId=434803, triggerDeltas = 33.44
		[ 33.44] CHAT_MSG_RAID_BOSS_WHISPER: Ulgrax prepares to unleash [Brutal Lashings]!, Dps1, 0, false, 0
	Digestive Acid - move to >%s<, type=moveto, spellId=435138, triggerDeltas = 20.99, 370.96
		[ 20.99] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000001, Dps1, 0x511, 435138, Digestive Acid, 0, DEBUFF, 0
			 Triggered 2x, delta times: 20.99, 370.96
	Stalkers Webbing (%s) - dodge attack, type=dodgecount, spellId=441452, triggerDeltas = 8.98, 43.98, 136.42, 43.98, 146.60, 44.00
		[  8.98] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
			 Triggered 6x, delta times: 8.98, 43.98, 136.42, 43.98, 146.60, 44.00
	Swallowing Darkness - dodge attack, type=dodge, spellId=443842, triggerDeltas = 138.95, 177.90
		[138.95] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
			 Triggered 2x, delta times: 138.95, 177.90
	Chittering Swarm - switch targets, type=switch, spellId=445052, triggerDeltas = 97.64, 178.90
		[ 97.64] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
			 Triggered 2x, delta times: 97.64, 178.90
	Hulking Crash - dodge attack, type=dodge, spellId=445123, triggerDeltas = 89.99, 180.37
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 2x, delta times: 89.99, 180.37

Yells:
	%d, type=shortfade, spellId=434803
		[ 38.44] Scheduled at 33.44 by CHAT_MSG_RAID_BOSS_WHISPER: Ulgrax prepares to unleash [Brutal Lashings]!, Dps1, 0, false, 0
			 Triggered 3x, delta times: 38.44, 1.00, 1.00
	Brutal Lashings, type=shortyell, spellId=434803
		[ 33.44] CHAT_MSG_RAID_BOSS_WHISPER: Ulgrax prepares to unleash [Brutal Lashings]!, Dps1, 0, false, 0
	Digestive Acid, type=shortyell, spellId=435138
		[ 20.99] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000001, Dps1, 0x511, 435138, Digestive Acid, 0, DEBUFF, 0
			 Triggered 2x, delta times: 20.99, 370.96

Voice pack sounds:
	VoicePack/chargemove
		[108.33] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 8x, delta times: 108.33, 7.11, 7.08, 7.03, 156.89, 7.03, 7.15, 7.07
	VoicePack/gathershare
		[ 33.44] CHAT_MSG_RAID_BOSS_WHISPER: Ulgrax prepares to unleash [Brutal Lashings]!, Dps1, 0, false, 0
	VoicePack/killmob
		[ 97.64] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
			 Triggered 2x, delta times: 97.64, 178.90
	VoicePack/movetoweb
		[ 20.99] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000001, Dps1, 0x511, 435138, Digestive Acid, 0, DEBUFF, 0
			 Triggered 2x, delta times: 20.99, 370.96
	VoicePack/watchstep
		[  8.98] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
			 Triggered 6x, delta times: 8.98, 43.98, 136.42, 43.98, 146.60, 44.00
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 2x, delta times: 89.99, 180.37
		[138.95] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
			 Triggered 2x, delta times: 138.95, 177.90

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 434803 441451 441452 435136 434697 445052 436203 436200 451412 443842 438012 445290 445123, SPELL_AURA_APPLIED 439419 455831 435138 434705 458129, SPELL_AURA_REMOVED 458129 435138, CHAT_MSG_RAID_BOSS_WHISPER, UNIT_SPELLCAST_SUCCEEDED boss1
		StartTimer: 3.0, Brutal Crush (1)
		StartTimer: 5.0, Venomous Lash (1)
		StartTimer: 9.0, Stalkers Webbing (1)
		StartTimer: 33.0, Brutal Lashings (1)
		StartTimer: 90.0, Stage 2
	[  2.99] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (2)
	[  4.98] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[  8.98] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
		ShowSpecialWarning: Stalkers Webbing (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Stalkers Webbing (2)
	[ 13.60] SPELL_AURA_APPLIED: [Hardened Netting->Dps5: Hardened Netting] Creature-0-1-2657-1-219586-0000000011, Hardened Netting, 0xa48, Player-1-00000010, Dps5, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps5") at 14.10 (+0.50)
			ShowAnnounce: Hardened Netting on Dps5
	[ 14.63] SPELL_AURA_APPLIED: [Hardened Netting->Dps5: Hardened Netting] Creature-0-1-2657-1-219586-0000000012, Hardened Netting, 0xa48, Player-1-00000010, Dps5, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps5") at 15.13 (+0.50)
			ShowAnnounce: Hardened Netting on Dps5
	[ 15.96] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (3)
	[ 20.99] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000001, Dps1, 0x511, 435138, Digestive Acid, 0, DEBUFF, 0
		ShowSpecialWarning: Digestive Acid - move to Web
		PlaySound: VoicePack/movetoweb
		ShowYell: Digestive Acid
	[ 21.01] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Tank6: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000017, Tank6, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Tank6") at 22.01 (+1.00)
			ShowAnnounce: Digestive Acid on PlayerName, Tank2, Healer3, Tank6
	[ 28.99] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 22.0, Brutal Crush (4)
	[ 29.96] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[ 32.97] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Lashings] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434803, Brutal Lashings, 0, 0
		StartTimer: 36.0, Brutal Lashings (2)
	[ 33.44] CHAT_MSG_RAID_BOSS_WHISPER: Ulgrax prepares to unleash [Brutal Lashings]!, Dps1, 0, false, 0
		AntiSpam: 1
		ShowSpecialWarning: Brutal Lashings on you
		PlaySound: VoicePack/gathershare
		ShowYell: Brutal Lashings
		ScheduleTask: yell434803shortfade:ScheduleCountdown(1.0) at 40.44 (+7.00)
			ShowYell: 1
		ScheduleTask: yell434803shortfade:ScheduleCountdown(2.0) at 39.44 (+6.00)
			ShowYell: 2
		ScheduleTask: yell434803shortfade:ScheduleCountdown(3.0) at 38.44 (+5.00)
			ShowYell: 3
	[ 50.97] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (5)
	[ 52.96] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
		ShowSpecialWarning: Stalkers Webbing (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 57.97] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[ 60.13] SPELL_AURA_APPLIED: [Hardened Netting->Healer3: Hardened Netting] Creature-0-1-2657-1-219586-000000002F, Hardened Netting, 0xa48, Player-1-00000008, Healer3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Healer3") at 60.63 (+0.50)
			ShowAnnounce: Hardened Netting on Healer3
	[ 64.99] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps4: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000009, Dps4, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps4") at 65.99 (+1.00)
			ShowAnnounce: Digestive Acid on Dps7, Healer4, Tank6, Dps4
	[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Hulking Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Chittering Swarm
		StartTimer: 12.1, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hungering Bellows (1)
	[ 97.64] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Chittering Swarm - switch targets
		PlaySound: VoicePack/killmob
	[103.72] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (2)
	[108.33] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (2)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (3)
	[115.44] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (3)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (4)
	[122.52] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (4)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (5)
	[128.15] SPELL_AURA_APPLIED: [Hardened Netting->Tank5: Hardened Netting] Creature-0-1-2657-1-219586-0000000105, Hardened Netting, 0xa48, Player-1-00000014, Tank5, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Tank5") at 128.65 (+0.50)
			ShowAnnounce: Hardened Netting on Tank2, Tank5
	[129.55] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (5)
		PlaySound: VoicePack/chargemove
	[138.95] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
		ShowSpecialWarning: Swallowing Darkness - dodge attack
		PlaySound: VoicePack/watchstep
	[150.52] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (1)
		StartTimer: 9.0, Hungering Bellows (2)
	[159.53] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (2)
		StartTimer: 9.0, Hungering Bellows (3)
	[168.52] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (3)
		StartTimer: 9.0, Hungering Bellows (4)
	[176.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000308, 441425, Ulgrax the Devourer, 39.7, 100, Dps10, 0
		StopTimer: Timer438012cdcount\t4
		StartTimer: 7.0, Brutal Crush (1)
		StartTimer: 9.0, Venomous Lash (1)
		StartTimer: 13.0, Stalkers Webbing (1)
		StartTimer: 37.0, Brutal Lashings (1)
		StartTimer: 94.9, Stage 2
	[183.35] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (2)
	[185.36] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[189.38] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
		ShowSpecialWarning: Stalkers Webbing (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Stalkers Webbing (2)
	[193.89] SPELL_AURA_APPLIED: [Hardened Netting->Healer3: Hardened Netting] Creature-0-1-2657-1-219586-0000000146, Hardened Netting, 0xa48, Player-1-00000008, Healer3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Healer3") at 194.39 (+0.50)
			ShowAnnounce: Hardened Netting on Dps7, Tank6, Healer3
	[196.34] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (3)
	[201.35] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps9: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000019, Dps9, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps9") at 202.35 (+1.00)
			ShowAnnounce: Digestive Acid on Dps5, Dps8, Dps3, Dps9
	[205.67] SPELL_AURA_APPLIED: [Hardened Netting->Dps7: Hardened Netting] Creature-0-1-2657-1-219586-0000000147, Hardened Netting, 0xa48, Player-1-00000016, Dps7, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps7") at 206.17 (+0.50)
			ShowAnnounce: Hardened Netting on Tank6, Dps7
	[209.33] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 22.0, Brutal Crush (4)
	[210.37] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[213.35] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Lashings] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434803, Brutal Lashings, 0, 0
		StartTimer: 36.0, Brutal Lashings (2)
	[231.37] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (5)
	[233.36] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
		ShowSpecialWarning: Stalkers Webbing (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[238.34] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[245.36] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Tank5: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000014, Tank5, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Tank5") at 246.36 (+1.00)
			ShowAnnounce: Digestive Acid on Healer1, Dps4, Dps9, Tank5
	[270.36] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Hulking Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Chittering Swarm
		StartTimer: 12.1, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hungering Bellows (1)
	[276.54] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Chittering Swarm - switch targets
		PlaySound: VoicePack/killmob
	[281.83] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (2)
	[286.44] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (2)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (3)
	[293.47] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (3)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (4)
	[300.62] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (4)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (5)
	[307.69] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (5)
		PlaySound: VoicePack/chargemove
	[316.85] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
		ShowSpecialWarning: Swallowing Darkness - dodge attack
		PlaySound: VoicePack/watchstep
	[328.43] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (1)
		StartTimer: 9.0, Hungering Bellows (2)
	[337.40] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (2)
		StartTimer: 9.0, Hungering Bellows (3)
	[346.43] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (3)
		StartTimer: 9.0, Hungering Bellows (4)
	[355.42] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (4)
		StartTimer: 6.0, Hungering Bellows (5)
	[361.41] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (5)
		StartTimer: 9.0, Hungering Bellows (6)
	[366.43] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000045B, 441425, Ulgrax the Devourer, 13.2, 100, Tank3, 0
		StopTimer: Timer438012cdcount\t6
		StartTimer: 7.0, Brutal Crush (1)
		StartTimer: 9.0, Venomous Lash (1)
		StartTimer: 13.0, Stalkers Webbing (1)
		StartTimer: 37.0, Brutal Lashings (1)
		StartTimer: 94.9, Stage 2
	[373.94] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (2)
	[375.97] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[379.96] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
		ShowSpecialWarning: Stalkers Webbing (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Stalkers Webbing (2)
	[384.51] SPELL_AURA_APPLIED: [Hardened Netting->Healer3: Hardened Netting] Creature-0-1-2657-1-219586-00000000DF, Hardened Netting, 0xa48, Player-1-00000008, Healer3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Healer3") at 385.01 (+0.50)
			ShowAnnounce: Hardened Netting on Healer3
	[386.96] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (3)
	[389.72] SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-00000000E2, Hardened Netting, 0xa48, Player-1-00000005, Tank1, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Tank1") at 390.22 (+0.50)
			ShowAnnounce: Hardened Netting on Tank1
	[391.95] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000001, Dps1, 0x511, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("PlayerName") at 392.95 (+1.00)
			ShowAnnounce: Digestive Acid on Dps3, Healer1, PlayerName
		ShowSpecialWarning: Digestive Acid - move to Web
		PlaySound: VoicePack/movetoweb
		ShowYell: Digestive Acid
	[393.04] SPELL_AURA_APPLIED: [Hardened Netting->Healer4: Hardened Netting] Creature-0-1-2657-1-219586-00000000E3, Hardened Netting, 0xa48, Player-1-00000012, Healer4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Healer4") at 393.54 (+0.50)
			ShowAnnounce: Hardened Netting on Healer4
	[399.95] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 22.0, Brutal Crush (4)
	[400.94] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[403.95] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Lashings] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434803, Brutal Lashings, 0, 0
		StartTimer: 36.0, Brutal Lashings (2)
	[421.96] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 13.0, Brutal Crush (5)
	[423.96] SPELL_CAST_START: [Ulgrax the Devourer: Stalkers Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalkers Webbing, 0, 0
		ShowSpecialWarning: Stalkers Webbing (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[428.95] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[436.00] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps7: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000016, Dps7, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps7") at 437.00 (+1.00)
			ShowAnnounce: Digestive Acid on Tank3, Tank6, Healer3, Dps7
	[453.36] ENCOUNTER_END: 2902, Ulgrax the Devourer, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 458129 435138
]]
