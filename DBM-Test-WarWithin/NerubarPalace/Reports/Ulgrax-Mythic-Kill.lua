DBM.Test:Report[[
Test: TWW/NerubarPalace/Ulgrax/Mythic/Kill
Mod:  DBM-Raids-WarWithin/2607

Findings:
	Unused event registration: CHAT_MSG_RAID_BOSS_WHISPER
	Unused event registration: SPELL_AURA_APPLIED 434705 (Tenderized)
	Unused event registration: SPELL_AURA_APPLIED 439419 (Stalker's Netting)
	Unused event registration: SPELL_AURA_APPLIED 458129 (Carnivorous Contest)
	Unused event registration: SPELL_AURA_REMOVED 435138 (Digestive Acid)
	Unused event registration: SPELL_AURA_REMOVED 458129 (Carnivorous Contest)
	Unused event registration: SPELL_CAST_START 434803 (Carnivorous Contest)
	Unused event registration: SPELL_CAST_START 441451 (Stalker's Webbing)
	Unused event registration: SPELL_CAST_START 445290 (Hulking Crash)
	Unused event registration: SPELL_CAST_START 451412 (Swallowing Darkness)
	Announce for spell ID 436200 (Juggernaut Charge) is triggered by event SPELL_CAST_START 436203 (Juggernaut Charge)
	Timer for spell ID 436200 (Juggernaut Charge) is triggered by event SPELL_CAST_START 436203 (Juggernaut Charge)
	Timer for spell ID 436200 (Juggernaut Charge) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)
	Timer for spell ID 438012 (Hungering Bellows) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)
	Timer for spell ID 443842 (Swallowing Darkness) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)
	Timer for spell ID 445052 (Chittering Swarm) is triggered by event SPELL_CAST_START 445123 (Hulking Crash)

Unused objects:
	[Announce] Stalker's Webbing on >%s<, type=target, spellId=441452
	[Special Warning] Brutal Crush - defensive, type=defensive, spellId=434697
	[Special Warning] Tenderized on >%s< - taunt now, type=taunt, spellId=434705
	[Special Warning] Soak - move to >%s<, type=moveto, spellId=434803
	[Special Warning] Soak on you, type=you, spellId=434803
	[Special Warning] Digestive Acid - move to >%s<, type=moveto, spellId=435138
	[Yell] %d, type=shortfade, spellId=434803
	[Yell] Soak, type=shortyell, spellId=434803
	[Yell] %d, type=shortfade, spellId=435138
	[Yell] Digestive Acid, type=shortyell, spellId=435138

Timers:
	Berserk, time=600.00, type=berserk, spellId=<none>, triggerDeltas = 0.00
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
	Brutal Crush (%s), time=13.00, type=cdcount, spellId=434697, triggerDeltas = 0.00, 2.97, 15.02, 15.04, 18.96, 118.46, 8.16, 15.00, 15.01, 18.99, 116.31, 7.76, 15.01, 14.99, 18.99
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  2.97] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
			 Triggered 12x, delta times: 2.97, 15.02, 15.04, 18.96, 126.62, 15.00, 15.01, 18.99, 124.07, 15.01, 14.99, 18.99
		[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
	Soak (%s), time=36.00, type=cdcount, spellId=434803, triggerDeltas = 0.00, 170.45, 173.47
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
	Venomous Lash (%s), time=32.90, type=cdcount, spellId=435136, triggerDeltas = 0.00, 5.00, 24.99, 140.46, 10.17, 24.98, 138.32, 9.73, 25.02
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  5.00] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
			 Triggered 6x, delta times: 5.00, 24.99, 150.63, 24.98, 148.05, 25.02
		[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
	Digestive Acid (%s), time=47.00, type=cdcount, spellId=435138, triggerDeltas = 0.00, 14.98, 155.47, 20.18, 153.29, 19.74
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[ 14.98] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
			 Triggered 3x, delta times: 14.98, 175.65, 173.03
		[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
	Charge (%s), time=49.00, type=cdcount, spellId=436200, triggerDeltas = 89.99, 12.33, 4.63, 7.04, 7.16, 144.48, 12.17, 4.61, 7.13, 7.10, 142.04, 12.17
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.99, 175.64, 173.05
		[102.32] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
			 Triggered 3x, delta times: 102.32, 175.48, 173.05
		[106.95] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 6x, delta times: 106.95, 7.04, 7.16, 161.26, 7.13, 7.10
	Hunger (%s), time=9.00, type=cdcount, spellId=438012, triggerDeltas = 89.99, 60.43, 7.00, 7.00, 101.21, 60.28, 7.00, 6.98, 98.79
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.99, 175.64, 173.05
		[150.42] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
			 Triggered 6x, delta times: 150.42, 7.00, 7.00, 161.49, 7.00, 6.98
		[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
	Stage %s, time=10.00, type=stagecount, spellId=438012, triggerDeltas = 0.00, 170.45, 173.47
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
	Webs (%s), time=49.00, type=cdcount, spellId=441452, triggerDeltas = 0.00, 9.00, 161.45, 14.22, 159.25, 13.75
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  9.00] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
			 Triggered 3x, delta times: 9.00, 175.67, 173.00
		[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
	Swallowing Darkness, time=49.00, type=cd, spellId=443842, triggerDeltas = 89.99, 175.64, 173.05
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.99, 175.64, 173.05
	Swarm, time=49.00, type=cd, spellId=445052, triggerDeltas = 89.99, 175.64, 173.05
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.99, 175.64, 173.05

Announces:
	Berserk in %s %s, type=nil, spellId=<none>, triggerDeltas = 300.00
		[300.00] Scheduled at 0.00 by ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
	Berserk in %s %s, type=nil, spellId=<none>, triggerDeltas = 420.00
		[420.00] Scheduled at 0.00 by ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
	Venomous Lash (%s), type=count, spellId=435136, triggerDeltas = 5.00, 24.99, 28.00, 122.63, 24.98, 28.01, 120.04, 25.02, 28.02
		[  5.00] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
			 Triggered 9x, delta times: 5.00, 24.99, 28.00, 122.63, 24.98, 28.01, 120.04, 25.02, 28.02
	Digestive Acid on >%s<, type=target, spellId=435138, triggerDeltas = 19.01, 47.00, 128.63, 46.98, 126.05, 47.00
		[ 19.01] Scheduled at 18.01 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps4: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000005, Dps4, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[ 66.01] Scheduled at 65.01 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps10: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000011, Dps10, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[194.64] Scheduled at 193.64 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps9: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000010, Dps9, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[241.62] Scheduled at 240.62 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000002, Dps1, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[367.67] Scheduled at 366.67 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps14: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000015, Dps14, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[414.67] Scheduled at 413.67 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps13: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000014, Dps13, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
	Charge (%s), type=count, spellId=436200, triggerDeltas = 106.95, 7.04, 7.16, 7.12, 154.14, 7.13, 7.10, 7.13
		[106.95] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 8x, delta times: 106.95, 7.04, 7.16, 7.12, 154.14, 7.13, 7.10, 7.13
	Hungering Bellows (%s), type=count, spellId=438012, triggerDeltas = 150.42, 7.00, 7.00, 161.49, 7.00, 6.98
		[150.42] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
			 Triggered 6x, delta times: 150.42, 7.00, 7.00, 161.49, 7.00, 6.98
	Hardened Netting on >%s<, type=target, spellId=455831, triggerDeltas = 60.68, 73.83, 19.34, 19.35, 1.22, 165.32, 10.95, 46.31, 3.71, 15.22
		[ 60.68] Scheduled at 60.18 by SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-00000000D4, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[134.51] Scheduled at 134.01 by SPELL_AURA_APPLIED: [Hardened Netting->Dps18: Hardened Netting] Creature-0-1-2657-1-219586-0000000039, Hardened Netting, 0xa48, Player-1-00000019, Dps18, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[153.85] Scheduled at 153.35 by SPELL_AURA_APPLIED: [Hardened Netting->Dps15: Hardened Netting] Creature-0-1-2657-1-219586-0000000046, Hardened Netting, 0xa48, Player-1-00000016, Dps15, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[173.20] Scheduled at 172.70 by SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-0000000049, Hardened Netting, 0xa48, Player-1-00000012, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[174.42] Scheduled at 173.92 by SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-00000000B7, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[339.74] Scheduled at 339.24 by SPELL_AURA_APPLIED: [Hardened Netting->Dps14: Hardened Netting] Creature-0-1-2657-1-219586-00000000CA, Hardened Netting, 0xa48, Player-1-00000015, Dps14, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[350.69] Scheduled at 350.19 by SPELL_AURA_APPLIED: [Hardened Netting->Dps2: Hardened Netting] Creature-0-1-2657-1-219586-0000000087, Hardened Netting, 0xa48, Player-1-00000003, Dps2, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[397.00] Scheduled at 396.50 by SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-00000000CF, Hardened Netting, 0xa48, Player-1-00000001, Tank1, 0x511, 455831, Hardened Netting, 0, DEBUFF, 0
		[400.71] Scheduled at 400.21 by SPELL_AURA_APPLIED: [Hardened Netting->Dps13: Hardened Netting] Creature-0-1-2657-1-219586-00000000D0, Hardened Netting, 0xa48, Player-1-00000014, Dps13, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[415.93] Scheduled at 415.43 by SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-0000000094, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0

Special warnings:
	Webs (%s) - dodge attack, type=dodgecount, spellId=441452, triggerDeltas = 9.00, 45.01, 130.66, 44.97, 128.03, 45.00
		[  9.00] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
			 Triggered 6x, delta times: 9.00, 45.01, 130.66, 44.97, 128.03, 45.00
	Swallowing Darkness - dodge attack, type=dodge, spellId=443842, triggerDeltas = 137.87, 175.34
		[137.87] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
			 Triggered 2x, delta times: 137.87, 175.34
	Swarm - switch targets, type=switch, spellId=445052, triggerDeltas = 96.22, 175.50, 173.03
		[ 96.22] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
			 Triggered 3x, delta times: 96.22, 175.50, 173.03
	Crash - dodge attack, type=dodge, spellId=445123, triggerDeltas = 89.99, 175.64, 173.05
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.99, 175.64, 173.05

Yells:
	None

Voice pack sounds:
	VoicePack/chargemove
		[106.95] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 8x, delta times: 106.95, 7.04, 7.16, 7.12, 154.14, 7.13, 7.10, 7.13
	VoicePack/killmob
		[ 96.22] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
			 Triggered 3x, delta times: 96.22, 175.50, 173.03
	VoicePack/watchstep
		[  9.00] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
			 Triggered 6x, delta times: 9.00, 45.01, 130.66, 44.97, 128.03, 45.00
		[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.99, 175.64, 173.05
		[137.87] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
			 Triggered 2x, delta times: 137.87, 175.34

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 434803 441451 441452 435136 434697 445052 436203 436200 451412 443842 438012 445290 445123 435138, SPELL_AURA_APPLIED 439419 455831 435138 434705 458129, SPELL_AURA_REMOVED 458129 435138, CHAT_MSG_RAID_BOSS_WHISPER, UNIT_SPELLCAST_SUCCEEDED boss1
		StartTimer: 3.0, Brutal Crush (1)
		StartTimer: 5.0, Venomous Lash (1)
		StartTimer: 9.0, Webs (1)
		StartTimer: 14.9, Digestive Acid (1)
		StartTimer: 33.0, Soak (1)
		StartTimer: 90.0, Stage 2
		StartTimer: 600.0, Berserk
		ScheduleTask: announce:Schedule(5.0, "min") at 300.00 (+300.00)
			ShowAnnounce: Berserk in 5 min
		ScheduleTask: announce:Schedule(3.0, "min") at 420.00 (+420.00)
			ShowAnnounce: Berserk in 3 min
		ScheduleTask: announce:Schedule(1.0, "min") at 540.00 (+540.00)
			Unscheduled by ENCOUNTER_END at 454.29
		ScheduleTask: announce:Schedule(30.0, "sec") at 570.00 (+570.00)
			Unscheduled by ENCOUNTER_END at 454.29
		ScheduleTask: announce:Schedule(10.0, "sec") at 590.00 (+590.00)
			Unscheduled by ENCOUNTER_END at 454.29
	[  2.97] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (2)
	[  5.00] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[  9.00] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Webs (2)
	[ 14.98] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
		StartTimer: 47.0, Digestive Acid (2)
	[ 17.99] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (3)
	[ 18.01] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps4: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000005, Dps4, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps4") at 19.01 (+1.00)
			ShowAnnounce: Digestive Acid on Dps17, Dps2, Dps5, Dps4
	[ 29.99] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[ 33.03] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 19.0, Brutal Crush (4)
	[ 51.99] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (5)
	[ 54.01] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 57.99] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[ 60.18] SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-00000000D4, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps8") at 60.68 (+0.50)
			ShowAnnounce: Hardened Netting on Dps11, Dps2, Dps8
	[ 65.01] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps10: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000011, Dps10, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps10") at 66.01 (+1.00)
			ShowAnnounce: Digestive Acid on Dps11, Dps7, Dps6, Dps10
	[ 89.99] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Swarm
		StartTimer: 11.8, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hunger (1)
	[ 96.22] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Swarm - switch targets
		PlaySound: VoicePack/killmob
	[102.32] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (1)
	[106.95] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (1)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (2)
	[113.99] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (2)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (3)
	[121.15] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (3)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (4)
	[128.27] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (4)
		PlaySound: VoicePack/chargemove
	[134.01] SPELL_AURA_APPLIED: [Hardened Netting->Dps18: Hardened Netting] Creature-0-1-2657-1-219586-0000000039, Hardened Netting, 0xa48, Player-1-00000019, Dps18, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps18") at 134.51 (+0.50)
			ShowAnnounce: Hardened Netting on Dps18
	[137.87] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
		ShowSpecialWarning: Swallowing Darkness - dodge attack
		PlaySound: VoicePack/watchstep
	[150.42] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (1)
		StartTimer: 7.0, Hunger (2)
	[153.35] SPELL_AURA_APPLIED: [Hardened Netting->Dps15: Hardened Netting] Creature-0-1-2657-1-219586-0000000046, Hardened Netting, 0xa48, Player-1-00000016, Dps15, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps15") at 153.85 (+0.50)
			ShowAnnounce: Hardened Netting on Dps13, Dps15
	[157.42] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (2)
		StartTimer: 7.0, Hunger (3)
	[164.42] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (3)
		StartTimer: 7.0, Hunger (4)
	[170.45] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-000000013A, 441425, Ulgrax the Devourer, 65.4, 100, Pet3, 0
		StopTimer: Timer438012cdcount\t4
		StartTimer: 7.0, Brutal Crush (1)
		StartTimer: 9.0, Venomous Lash (1)
		StartTimer: 13.0, Webs (1)
		StartTimer: 19.2, Digestive Acid (1)
		StartTimer: 37.0, Soak (1)
		StartTimer: 94.9, Stage 2
	[172.70] SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-0000000049, Hardened Netting, 0xa48, Player-1-00000012, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps11") at 173.20 (+0.50)
			ShowAnnounce: Hardened Netting on Dps11
	[173.92] SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-00000000B7, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps8") at 174.42 (+0.50)
			ShowAnnounce: Hardened Netting on Dps14, Dps8
	[178.61] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (2)
	[180.62] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[184.67] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Webs (2)
	[190.63] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
		StartTimer: 47.0, Digestive Acid (2)
	[193.61] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (3)
	[193.64] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps9: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000010, Dps9, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps9") at 194.64 (+1.00)
			ShowAnnounce: Digestive Acid on Dps5, Dps6, Dps11, Dps9
	[205.60] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[208.62] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 19.0, Brutal Crush (4)
	[227.61] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (5)
	[229.64] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[233.61] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[240.62] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps1: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000002, Dps1, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps1") at 241.62 (+1.00)
			ShowAnnounce: Digestive Acid on Dps5, Dps9, Dps6, Dps1
	[265.63] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Swarm
		StartTimer: 11.8, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hunger (1)
	[271.72] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Swarm - switch targets
		PlaySound: VoicePack/killmob
	[277.80] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (1)
	[282.41] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (1)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (2)
	[289.54] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (2)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (3)
	[296.64] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (3)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (4)
	[303.77] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (4)
		PlaySound: VoicePack/chargemove
	[313.21] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
		ShowSpecialWarning: Swallowing Darkness - dodge attack
		PlaySound: VoicePack/watchstep
	[325.91] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (1)
		StartTimer: 7.0, Hunger (2)
	[332.91] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (2)
		StartTimer: 7.0, Hunger (3)
	[339.24] SPELL_AURA_APPLIED: [Hardened Netting->Dps14: Hardened Netting] Creature-0-1-2657-1-219586-00000000CA, Hardened Netting, 0xa48, Player-1-00000015, Dps14, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps14") at 339.74 (+0.50)
			ShowAnnounce: Hardened Netting on Dps6, Dps14
	[339.89] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (3)
		StartTimer: 7.0, Hunger (4)
	[343.92] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000255, 441425, Ulgrax the Devourer, 35.2, 100, Dps8, 0
		StopTimer: Timer438012cdcount\t4
		StartTimer: 7.0, Brutal Crush (1)
		StartTimer: 9.0, Venomous Lash (1)
		StartTimer: 13.0, Webs (1)
		StartTimer: 19.2, Digestive Acid (1)
		StartTimer: 37.0, Soak (1)
		StartTimer: 94.9, Stage 2
	[350.19] SPELL_AURA_APPLIED: [Hardened Netting->Dps2: Hardened Netting] Creature-0-1-2657-1-219586-0000000087, Hardened Netting, 0xa48, Player-1-00000003, Dps2, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps2") at 350.69 (+0.50)
			ShowAnnounce: Hardened Netting on Dps2
	[351.68] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (2)
	[353.65] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[357.67] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Webs (2)
	[363.66] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
		StartTimer: 47.0, Digestive Acid (2)
	[366.67] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps14: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000015, Dps14, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps14") at 367.67 (+1.00)
			ShowAnnounce: Digestive Acid on Dps3, Dps9, Dps18, Dps14
	[366.69] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (3)
	[378.67] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[381.68] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 19.0, Brutal Crush (4)
	[396.50] SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-00000000CF, Hardened Netting, 0xa48, Player-1-00000001, Tank1, 0x511, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("PlayerName") at 397.00 (+0.50)
			ShowAnnounce: Hardened Netting on Dps11, PlayerName
	[400.21] SPELL_AURA_APPLIED: [Hardened Netting->Dps13: Hardened Netting] Creature-0-1-2657-1-219586-00000000D0, Hardened Netting, 0xa48, Player-1-00000014, Dps13, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps13") at 400.71 (+0.50)
			ShowAnnounce: Hardened Netting on Dps11, Dps13
	[400.67] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (5)
	[402.67] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[406.69] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[413.67] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps13: Digestive Acid] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, Player-1-00000014, Dps13, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps13") at 414.67 (+1.00)
			ShowAnnounce: Digestive Acid on Dps14, Dps15, Dps6, Dps13
	[415.43] SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-0000000094, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps8") at 415.93 (+0.50)
			ShowAnnounce: Hardened Netting on Dps8
	[438.68] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Swarm
		StartTimer: 11.8, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hunger (1)
	[444.75] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Swarm - switch targets
		PlaySound: VoicePack/killmob
	[450.85] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000002, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (1)
	[454.29] ENCOUNTER_END: 2902, Ulgrax the Devourer, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
		UnscheduleTask: announce:Schedule(1.0, "min") scheduled by ScheduleTask at 0.00
		UnscheduleTask: announce:Schedule(30.0, "sec") scheduled by ScheduleTask at 0.00
		UnscheduleTask: announce:Schedule(10.0, "sec") scheduled by ScheduleTask at 0.00
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 458129 435138
]]
