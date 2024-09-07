DBM.Test:Report[[
Test: TWW/NerubarPalace/Ulgrax/Mythic/Wipe
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
	[Special Warning] Carnivorous Contest - soak (%s), type=soakcount, spellId=434803
	[Special Warning] Carnivorous Contest on you, type=you, spellId=434803
	[Special Warning] Digestive Acid - move to >%s<, type=moveto, spellId=435138
	[Yell] %d, type=shortfade, spellId=434803
	[Yell] Carnivorous Contest, type=shortyell, spellId=434803
	[Yell] %d, type=shortfade, spellId=435138
	[Yell] Digestive Acid, type=shortyell, spellId=435138

Timers:
	Brutal Crush (%s), time=13.00, type=cdcount, spellId=434697, triggerDeltas = 0.00, 2.94, 14.98, 15.04, 18.98, 129.20, 7.63, 15.01, 14.97, 19.00, 135.85, 8.16, 14.99, 15.02, 19.00, 163.92, 7.05
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  2.94] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
			 Triggered 13x, delta times: 2.94, 14.98, 15.04, 18.98, 136.83, 15.01, 14.97, 19.00, 144.01, 14.99, 15.02, 19.00, 170.97
		[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
	Soak (%s), time=36.00, type=cdcount, spellId=434803, triggerDeltas = 0.00, 181.14, 192.46, 221.09
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
	Venomous Lash (%s), time=32.90, type=cdcount, spellId=435136, triggerDeltas = 0.00, 4.92, 25.00, 151.22, 9.61, 25.03, 157.82, 10.16, 25.01, 185.92, 9.06
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  4.92] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
			 Triggered 7x, delta times: 4.92, 25.00, 160.83, 25.03, 167.98, 25.01, 194.98
		[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
	Digestive Acid (%s), time=47.00, type=cdcount, spellId=435138, triggerDeltas = 0.00, 14.93, 166.21, 19.61, 172.85, 20.14, 200.95
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[ 14.93] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
			 Triggered 3x, delta times: 14.93, 185.82, 192.99
		[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
	Charge (%s), time=49.00, type=cdcount, spellId=436200, triggerDeltas = 89.92, 11.90, 4.62, 7.06, 7.08, 155.18, 12.30, 4.61, 7.08, 7.05, 161.97, 12.10, 4.61, 7.09, 7.05
		[ 89.92] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.92, 185.84, 193.01
		[101.82] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
			 Triggered 3x, delta times: 101.82, 186.24, 192.81
		[106.44] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 9x, delta times: 106.44, 7.06, 7.08, 172.09, 7.08, 7.05, 178.68, 7.09, 7.05
	Hunger (%s), time=9.00, type=cdcount, spellId=438012, triggerDeltas = 89.92, 59.75, 6.96, 7.02, 6.98, 8.02, 97.11, 60.80, 7.03, 7.00, 6.97, 8.01, 6.99, 96.21, 59.91, 6.99, 6.98, 7.05, 8.01, 6.98, 7.03, 6.98, 8.01, 6.98
		[ 89.92] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.92, 185.84, 193.01
		[149.67] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
			 Triggered 21x, delta times: 149.67, 6.96, 7.02, 6.98, 8.02, 157.91, 7.03, 7.00, 6.97, 8.01, 6.99, 156.12, 6.99, 6.98, 7.05, 8.01, 6.98, 7.03, 6.98, 8.01, 6.98
		[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
	Stage %s, time=10.00, type=stagecount, spellId=438012, triggerDeltas = 0.00, 181.14, 192.46, 221.09
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
	Webs (%s), time=49.00, type=cdcount, spellId=441452, triggerDeltas = 0.00, 8.94, 172.20, 13.62, 178.84, 14.17, 206.92, 13.09
		[  0.00] ENCOUNTER_START: 2902, Ulgrax the Devourer, 16, 20, 0
		[  8.94] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
			 Triggered 4x, delta times: 8.94, 185.82, 193.01, 220.01
		[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
	Swallowing Darkness, time=49.00, type=cd, spellId=443842, triggerDeltas = 89.92, 185.84, 193.01
		[ 89.92] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.92, 185.84, 193.01
	Swarm, time=49.00, type=cd, spellId=445052, triggerDeltas = 89.92, 185.84, 193.01
		[ 89.92] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.92, 185.84, 193.01

Announces:
	Venomous Lash (%s), type=count, spellId=435136, triggerDeltas = 4.92, 25.00, 28.00, 132.83, 25.03, 27.95, 140.03, 25.01, 27.97, 167.01
		[  4.92] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
			 Triggered 10x, delta times: 4.92, 25.00, 28.00, 132.83, 25.03, 27.95, 140.03, 25.01, 27.97, 167.01
	Digestive Acid on >%s<, type=target, spellId=435138, triggerDeltas = 18.93, 47.03, 138.81, 47.00, 145.97, 47.02
		[ 18.93] Scheduled at 17.93 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps4: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000005, Dps4, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[ 65.96] Scheduled at 64.96 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Healer1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000004, Healer1, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[204.77] Scheduled at 203.77 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps9: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000012, Dps9, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[251.77] Scheduled at 250.77 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps13: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000017, Dps13, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[397.74] Scheduled at 396.74 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Tank2: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000015, Tank2, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		[444.76] Scheduled at 443.76 by SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps10: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000013, Dps10, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
	Charge (%s), type=count, spellId=436200, triggerDeltas = 106.44, 7.06, 7.08, 7.08, 165.01, 7.08, 7.05, 7.13, 171.55, 7.09, 7.05, 7.10
		[106.44] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 12x, delta times: 106.44, 7.06, 7.08, 7.08, 165.01, 7.08, 7.05, 7.13, 171.55, 7.09, 7.05, 7.10
	Hungering Bellows (%s), type=count, spellId=438012, triggerDeltas = 149.67, 6.96, 7.02, 6.98, 8.02, 157.91, 7.03, 7.00, 6.97, 8.01, 6.99, 156.12, 6.99, 6.98, 7.05, 8.01, 6.98, 7.03, 6.98, 8.01, 6.98
		[149.67] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
			 Triggered 21x, delta times: 149.67, 6.96, 7.02, 6.98, 8.02, 157.91, 7.03, 7.00, 6.97, 8.01, 6.99, 156.12, 6.99, 6.98, 7.05, 8.01, 6.98, 7.03, 6.98, 8.01, 6.98
	Hardened Netting on >%s<, type=target, spellId=455831, triggerDeltas = 20.95, 1.34, 4.88, 41.17, 11.07, 4.95, 122.91, 47.65, 11.55, 30.62, 17.35, 26.21, 74.15, 19.22, 25.56, 30.04, 14.49, 38.51
		[ 20.95] Scheduled at 20.45 by SPELL_AURA_APPLIED: [Hardened Netting->Dps1: Hardened Netting] Creature-0-1-2657-1-219586-0000000144, Hardened Netting, 0xa48, Player-1-00000001, Dps1, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[ 22.29] Scheduled at 21.79 by SPELL_AURA_APPLIED: [Hardened Netting->Tank3: Hardened Netting] Creature-0-1-2657-1-219586-0000000015, Hardened Netting, 0xa48, Player-1-00000018, Tank3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[ 27.17] Scheduled at 26.67 by SPELL_AURA_APPLIED: [Hardened Netting->Dps12: Hardened Netting] Creature-0-1-2657-1-219586-0000000018, Hardened Netting, 0xa48, Player-1-00000016, Dps12, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[ 68.34] Scheduled at 67.84 by SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-0000000033, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[ 79.41] Scheduled at 78.91 by SPELL_AURA_APPLIED: [Hardened Netting->Healer2: Hardened Netting] Creature-0-1-2657-1-219586-0000000039, Hardened Netting, 0xa48, Player-1-00000011, Healer2, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[ 84.36] Scheduled at 83.86 by SPELL_AURA_APPLIED: [Hardened Netting->Dps12: Hardened Netting] Creature-0-1-2657-1-219586-000000003D, Hardened Netting, 0xa48, Player-1-00000016, Dps12, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[207.27] Scheduled at 206.77 by SPELL_AURA_APPLIED: [Hardened Netting->Dps4: Hardened Netting] Creature-0-1-2657-1-219586-000000016E, Hardened Netting, 0xa48, Player-1-00000005, Dps4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[254.92] Scheduled at 254.42 by SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-00000001CE, Hardened Netting, 0xa48, Player-1-00000010, Tank1, 0x511, 455831, Hardened Netting, 0, DEBUFF, 0
		[266.47] Scheduled at 265.97 by SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-0000000175, Hardened Netting, 0xa48, Player-1-00000014, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[297.09] Scheduled at 296.59 by SPELL_AURA_APPLIED: [Hardened Netting->Dps6: Hardened Netting] Creature-0-1-2657-1-219586-00000000B3, Hardened Netting, 0xa48, Player-1-00000007, Dps6, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[314.44] Scheduled at 313.94 by SPELL_AURA_APPLIED: [Hardened Netting->Dps14: Hardened Netting] Creature-0-1-2657-1-219586-00000000C0, Hardened Netting, 0xa48, Player-1-00000020, Dps14, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[340.65] Scheduled at 340.15 by SPELL_AURA_APPLIED: [Hardened Netting->Dps10: Hardened Netting] Creature-0-1-2657-1-219586-00000001D9, Hardened Netting, 0xa48, Player-1-00000013, Dps10, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[414.80] Scheduled at 414.30 by SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-00000000EE, Hardened Netting, 0xa48, Player-1-00000014, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[434.02] Scheduled at 433.52 by SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-00000000F4, Hardened Netting, 0xa48, Player-1-00000014, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[459.58] Scheduled at 459.08 by SPELL_AURA_APPLIED: [Hardened Netting->Dps4: Hardened Netting] Creature-0-1-2657-1-219586-00000000FB, Hardened Netting, 0xa48, Player-1-00000005, Dps4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[489.62] Scheduled at 489.12 by SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-0000000104, Hardened Netting, 0xa48, Player-1-00000010, Tank1, 0x511, 455831, Hardened Netting, 0, DEBUFF, 0
		[504.11] Scheduled at 503.61 by SPELL_AURA_APPLIED: [Hardened Netting->Dps4: Hardened Netting] Creature-0-1-2657-1-219586-0000000111, Hardened Netting, 0xa48, Player-1-00000005, Dps4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		[542.62] Scheduled at 542.12 by SPELL_AURA_APPLIED: [Hardened Netting->Tank2: Hardened Netting] Creature-0-1-2657-1-219586-000000012F, Hardened Netting, 0xa48, Player-1-00000015, Tank2, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0

Special warnings:
	Webs (%s) - dodge attack, type=dodgecount, spellId=441452, triggerDeltas = 8.94, 44.98, 140.84, 45.00, 148.01, 44.99, 175.02
		[  8.94] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
			 Triggered 7x, delta times: 8.94, 44.98, 140.84, 45.00, 148.01, 44.99, 175.02
	Swallowing Darkness - dodge attack, type=dodge, spellId=443842, triggerDeltas = 137.14, 186.91, 192.12
		[137.14] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
			 Triggered 3x, delta times: 137.14, 186.91, 192.12
	Swarm - switch targets, type=switch, spellId=445052, triggerDeltas = 96.16, 185.85, 192.78
		[ 96.16] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
			 Triggered 3x, delta times: 96.16, 185.85, 192.78
	Crash - dodge attack, type=dodge, spellId=445123, triggerDeltas = 89.92, 185.84, 193.01
		[ 89.92] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.92, 185.84, 193.01

Yells:
	None

Voice pack sounds:
	VoicePack/chargemove
		[106.44] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
			 Triggered 12x, delta times: 106.44, 7.06, 7.08, 7.08, 165.01, 7.08, 7.05, 7.13, 171.55, 7.09, 7.05, 7.10
	VoicePack/killmob
		[ 96.16] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
			 Triggered 3x, delta times: 96.16, 185.85, 192.78
	VoicePack/watchstep
		[  8.94] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
			 Triggered 7x, delta times: 8.94, 44.98, 140.84, 45.00, 148.01, 44.99, 175.02
		[ 89.92] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
			 Triggered 3x, delta times: 89.92, 185.84, 193.01
		[137.14] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
			 Triggered 3x, delta times: 137.14, 186.91, 192.12

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
	[  2.94] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (2)
	[  4.92] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[  8.94] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Webs (2)
	[ 14.93] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
		StartTimer: 47.0, Digestive Acid (2)
	[ 17.92] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (3)
	[ 17.93] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps4: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000005, Dps4, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps4") at 18.93 (+1.00)
			ShowAnnounce: Digestive Acid on Dps10, Dps12, Dps2, Dps4
	[ 20.45] SPELL_AURA_APPLIED: [Hardened Netting->Dps1: Hardened Netting] Creature-0-1-2657-1-219586-0000000144, Hardened Netting, 0xa48, Player-1-00000001, Dps1, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps1") at 20.95 (+0.50)
			ShowAnnounce: Hardened Netting on Dps1
	[ 21.79] SPELL_AURA_APPLIED: [Hardened Netting->Tank3: Hardened Netting] Creature-0-1-2657-1-219586-0000000015, Hardened Netting, 0xa48, Player-1-00000018, Tank3, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Tank3") at 22.29 (+0.50)
			ShowAnnounce: Hardened Netting on Tank3
	[ 26.67] SPELL_AURA_APPLIED: [Hardened Netting->Dps12: Hardened Netting] Creature-0-1-2657-1-219586-0000000018, Hardened Netting, 0xa48, Player-1-00000016, Dps12, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps12") at 27.17 (+0.50)
			ShowAnnounce: Hardened Netting on Dps12
	[ 29.92] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[ 32.96] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 19.0, Brutal Crush (4)
	[ 51.94] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (5)
	[ 53.92] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 57.92] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[ 64.96] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Healer1: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000004, Healer1, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Healer1") at 65.96 (+1.00)
			ShowAnnounce: Digestive Acid on Tank3, Dps2, Dps13, Healer1
	[ 67.84] SPELL_AURA_APPLIED: [Hardened Netting->Dps8: Hardened Netting] Creature-0-1-2657-1-219586-0000000033, Hardened Netting, 0xa48, Player-1-00000009, Dps8, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps8") at 68.34 (+0.50)
			ShowAnnounce: Hardened Netting on Dps8
	[ 78.91] SPELL_AURA_APPLIED: [Hardened Netting->Healer2: Hardened Netting] Creature-0-1-2657-1-219586-0000000039, Hardened Netting, 0xa48, Player-1-00000011, Healer2, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Healer2") at 79.41 (+0.50)
			ShowAnnounce: Hardened Netting on Healer2
	[ 83.86] SPELL_AURA_APPLIED: [Hardened Netting->Dps12: Hardened Netting] Creature-0-1-2657-1-219586-000000003D, Hardened Netting, 0xa48, Player-1-00000016, Dps12, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps12") at 84.36 (+0.50)
			ShowAnnounce: Hardened Netting on Dps12
	[ 89.92] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Swarm
		StartTimer: 12.1, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hunger (1)
	[ 96.16] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Swarm - switch targets
		PlaySound: VoicePack/killmob
	[101.82] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (2)
	[106.44] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (2)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (3)
	[113.50] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (3)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (4)
	[120.58] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (4)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (5)
	[127.66] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (5)
		PlaySound: VoicePack/chargemove
	[137.14] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
		ShowSpecialWarning: Swallowing Darkness - dodge attack
		PlaySound: VoicePack/watchstep
	[149.67] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (1)
		StartTimer: 7.0, Hunger (2)
	[156.63] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (2)
		StartTimer: 7.0, Hunger (3)
	[163.65] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (3)
		StartTimer: 7.0, Hunger (4)
	[170.63] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (4)
		StartTimer: 6.0, Hunger (5)
	[178.65] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (5)
		StartTimer: 7.0, Hunger (6)
	[181.14] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000549, 441425, Ulgrax the Devourer, 37.3, 100, Dps14, 0
		StopTimer: Timer438012cdcount\t6
		StartTimer: 7.0, Brutal Crush (1)
		StartTimer: 9.0, Venomous Lash (1)
		StartTimer: 13.0, Webs (1)
		StartTimer: 19.6, Digestive Acid (1)
		StartTimer: 37.0, Soak (1)
		StartTimer: 94.9, Stage 2
	[188.77] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (2)
	[190.75] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[194.76] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Webs (2)
	[200.75] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
		StartTimer: 47.0, Digestive Acid (2)
	[203.77] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps9: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000012, Dps9, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps9") at 204.77 (+1.00)
			ShowAnnounce: Digestive Acid on Healer2, Dps8, Dps13, Dps9
	[203.78] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (3)
	[206.77] SPELL_AURA_APPLIED: [Hardened Netting->Dps4: Hardened Netting] Creature-0-1-2657-1-219586-000000016E, Hardened Netting, 0xa48, Player-1-00000005, Dps4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps4") at 207.27 (+0.50)
			ShowAnnounce: Hardened Netting on Dps4
	[215.78] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[218.75] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 19.0, Brutal Crush (4)
	[237.75] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (5)
	[239.76] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[243.73] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[250.77] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps13: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000017, Dps13, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps13") at 251.77 (+1.00)
			ShowAnnounce: Digestive Acid on Healer1, Dps9, Dps12, Dps13
	[254.42] SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-00000001CE, Hardened Netting, 0xa48, Player-1-00000010, Tank1, 0x511, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("PlayerName") at 254.92 (+0.50)
			ShowAnnounce: Hardened Netting on PlayerName, Dps12
	[265.97] SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-0000000175, Hardened Netting, 0xa48, Player-1-00000014, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps11") at 266.47 (+0.50)
			ShowAnnounce: Hardened Netting on Healer2, Dps11
	[275.76] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Swarm
		StartTimer: 12.1, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hunger (1)
	[282.01] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Swarm - switch targets
		PlaySound: VoicePack/killmob
	[288.06] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (2)
	[292.67] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (2)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (3)
	[296.59] SPELL_AURA_APPLIED: [Hardened Netting->Dps6: Hardened Netting] Creature-0-1-2657-1-219586-00000000B3, Hardened Netting, 0xa48, Player-1-00000007, Dps6, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps6") at 297.09 (+0.50)
			ShowAnnounce: Hardened Netting on Dps6
	[299.75] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (3)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (4)
	[306.80] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (4)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (5)
	[313.93] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (5)
		PlaySound: VoicePack/chargemove
	[313.94] SPELL_AURA_APPLIED: [Hardened Netting->Dps14: Hardened Netting] Creature-0-1-2657-1-219586-00000000C0, Hardened Netting, 0xa48, Player-1-00000020, Dps14, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps14") at 314.44 (+0.50)
			ShowAnnounce: Hardened Netting on Dps14
	[324.05] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
		ShowSpecialWarning: Swallowing Darkness - dodge attack
		PlaySound: VoicePack/watchstep
	[336.56] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (1)
		StartTimer: 7.0, Hunger (2)
	[340.15] SPELL_AURA_APPLIED: [Hardened Netting->Dps10: Hardened Netting] Creature-0-1-2657-1-219586-00000001D9, Hardened Netting, 0xa48, Player-1-00000013, Dps10, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps10") at 340.65 (+0.50)
			ShowAnnounce: Hardened Netting on Dps10
	[343.59] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (2)
		StartTimer: 7.0, Hunger (3)
	[350.59] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (3)
		StartTimer: 7.0, Hunger (4)
	[357.56] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (4)
		StartTimer: 6.0, Hunger (5)
	[365.57] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (5)
		StartTimer: 7.0, Hunger (6)
	[372.56] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (6)
		StartTimer: 7.0, Hunger (7)
	[373.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-00000004CF, 441425, Ulgrax the Devourer, 4.4, 100, Dps14, 0
		StopTimer: Timer438012cdcount\t7
		StartTimer: 7.0, Brutal Crush (1)
		StartTimer: 9.0, Venomous Lash (1)
		StartTimer: 13.0, Webs (1)
		StartTimer: 19.6, Digestive Acid (1)
		StartTimer: 37.0, Soak (1)
		StartTimer: 94.9, Stage 2
	[381.76] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (2)
	[383.76] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[387.77] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Webs (2)
	[393.74] SPELL_CAST_START: [Ulgrax the Devourer: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435138, Digestive Acid, 0, 0
		StartTimer: 47.0, Digestive Acid (2)
	[396.74] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Tank2: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000015, Tank2, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Tank2") at 397.74 (+1.00)
			ShowAnnounce: Digestive Acid on Tank3, Dps1, Dps12, Tank2
	[396.75] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (3)
	[408.77] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (2)
		StartTimer: 28.0, Venomous Lash (3)
	[411.77] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 19.0, Brutal Crush (4)
	[414.30] SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-00000000EE, Hardened Netting, 0xa48, Player-1-00000014, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps11") at 414.80 (+0.50)
			ShowAnnounce: Hardened Netting on Dps11
	[430.77] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (5)
	[432.76] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[433.52] SPELL_AURA_APPLIED: [Hardened Netting->Dps11: Hardened Netting] Creature-0-1-2657-1-219586-00000000F4, Hardened Netting, 0xa48, Player-1-00000014, Dps11, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps11") at 434.02 (+0.50)
			ShowAnnounce: Hardened Netting on Dps11
	[436.74] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (3)
	[443.76] SPELL_AURA_APPLIED: [Ulgrax the Devourer->Dps10: Digestive Acid] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, Player-1-00000013, Dps10, 0x512, 435138, Digestive Acid, 0, DEBUFF, 0
		ScheduleTask: announce435138target:CombinedShow("Dps10") at 444.76 (+1.00)
			ShowAnnounce: Digestive Acid on Dps12, Dps13, Dps8, Dps10
	[459.08] SPELL_AURA_APPLIED: [Hardened Netting->Dps4: Hardened Netting] Creature-0-1-2657-1-219586-00000000FB, Hardened Netting, 0xa48, Player-1-00000005, Dps4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps4") at 459.58 (+0.50)
			ShowAnnounce: Hardened Netting on Dps4
	[468.77] SPELL_CAST_START: [Ulgrax the Devourer: Hulking Crash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445123, Hulking Crash, 0, 0
		ShowSpecialWarning: Crash - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 6.8, Swarm
		StartTimer: 12.1, Charge (1)
		StartTimer: 48.1, Swallowing Darkness
		StartTimer: 59.0, Hunger (1)
	[474.79] SPELL_CAST_START: [Ulgrax the Devourer: Chittering Swarm] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 445052, Chittering Swarm, 0, 0
		ShowSpecialWarning: Swarm - switch targets
		PlaySound: VoicePack/killmob
	[480.87] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436200, Juggernaut Charge, 0, 0
		StartTimer: 4.6, Charge (2)
	[485.48] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (2)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (3)
	[489.12] SPELL_AURA_APPLIED: [Hardened Netting->Tank1: Hardened Netting] Creature-0-1-2657-1-219586-0000000104, Hardened Netting, 0xa48, Player-1-00000010, Tank1, 0x511, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("PlayerName") at 489.62 (+0.50)
			ShowAnnounce: Hardened Netting on PlayerName
	[492.57] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (3)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (4)
	[499.62] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (4)
		PlaySound: VoicePack/chargemove
		StartTimer: 7.1, Charge (5)
	[503.61] SPELL_AURA_APPLIED: [Hardened Netting->Dps4: Hardened Netting] Creature-0-1-2657-1-219586-0000000111, Hardened Netting, 0xa48, Player-1-00000005, Dps4, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Dps4") at 504.11 (+0.50)
			ShowAnnounce: Hardened Netting on Dps4
	[506.72] SPELL_CAST_START: [Ulgrax the Devourer: Juggernaut Charge] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 436203, Juggernaut Charge, 0, 0
		ShowAnnounce: Charge (5)
		PlaySound: VoicePack/chargemove
	[516.17] SPELL_CAST_START: [Ulgrax the Devourer: Swallowing Darkness] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 443842, Swallowing Darkness, 0, 0
		ShowSpecialWarning: Swallowing Darkness - dodge attack
		PlaySound: VoicePack/watchstep
	[528.68] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (1)
		StartTimer: 7.0, Hunger (2)
	[535.67] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (2)
		StartTimer: 7.0, Hunger (3)
	[542.12] SPELL_AURA_APPLIED: [Hardened Netting->Tank2: Hardened Netting] Creature-0-1-2657-1-219586-000000012F, Hardened Netting, 0xa48, Player-1-00000015, Tank2, 0x512, 455831, Hardened Netting, 0, DEBUFF, 0
		ScheduleTask: announce455831target:CombinedShow("Tank2") at 542.62 (+0.50)
			ShowAnnounce: Hardened Netting on Tank2
	[542.65] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (3)
		StartTimer: 7.0, Hunger (4)
	[549.70] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (4)
		StartTimer: 6.0, Hunger (5)
	[557.71] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (5)
		StartTimer: 7.0, Hunger (6)
	[564.69] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (6)
		StartTimer: 7.0, Hunger (7)
	[571.72] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (7)
		StartTimer: 7.0, Hunger (8)
	[578.70] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (8)
		StartTimer: 6.0, Hunger (9)
	[586.71] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (9)
		StartTimer: 7.0, Hunger (10)
	[593.69] SPELL_CAST_START: [Ulgrax the Devourer: Hungering Bellows] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 438012, Hungering Bellows, 0, 0
		ShowAnnounce: Hungering Bellows (10)
		StartTimer: 7.0, Hunger (11)
	[594.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-441425-0000000441, 441425, Ulgrax the Devourer, 1.7, 100, Dps14, 0
		StopTimer: Timer438012cdcount\t11
		StartTimer: 7.0, Brutal Crush (1)
		StartTimer: 9.0, Venomous Lash (1)
		StartTimer: 13.0, Webs (1)
		StartTimer: 19.6, Digestive Acid (1)
		StartTimer: 37.0, Soak (1)
		StartTimer: 94.9, Stage 2
	[601.74] SPELL_CAST_START: [Ulgrax the Devourer: Brutal Crush] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 434697, Brutal Crush, 0, 0
		StartTimer: 15.0, Brutal Crush (2)
	[603.75] SPELL_CAST_START: [Ulgrax the Devourer: Venomous Lash] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 435136, Venomous Lash, 0, 0
		ShowAnnounce: Venomous Lash (1)
		StartTimer: 25.0, Venomous Lash (2)
	[607.78] SPELL_CAST_START: [Ulgrax the Devourer: Stalker's Webbing] Creature-0-1-2657-1-215657-0000000001, Ulgrax the Devourer, 0xa48, "", nil, 0x0, 441452, Stalker's Webbing, 0, 0
		ShowSpecialWarning: Webs (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 43.9, Webs (2)
	[612.60] ENCOUNTER_END: 2902, Ulgrax the Devourer, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 458129 435138
]]
