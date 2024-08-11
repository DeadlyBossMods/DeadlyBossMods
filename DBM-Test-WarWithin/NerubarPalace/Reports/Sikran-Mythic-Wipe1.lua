DBM.Test:Report[[
Test: TWW/NerubarPalace/Sikran/Mythic/Wipe1
Mod:  DBM-Raids-WarWithin/2599

Findings:
	Unused event registration: CHAT_MSG_RAID_BOSS_WHISPER
	Unused event registration: SPELL_AURA_APPLIED 435410 (Pierced Defenses)
	Unused event registration: SPELL_AURA_APPLIED 438845 (Expose)
	Unused event registration: SPELL_AURA_APPLIED 439191 (Decimate)
	Unused event registration: SPELL_AURA_REMOVED 439191 (Decimate)
	Unused event registration: SPELL_CAST_START 435401 (Expose)
	Unused event registration: SPELL_CAST_START 435403 (Phase Lunge)
	Unused event registration: SPELL_CAST_START 453258 (Rain of Arrows)
	Timer for spell ID 433517 (Phase Blades) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)
	Timer for spell ID 439511 (Captain's Flourish) is triggered by event SPELL_CAST_START 432965 (Expose)
	Timer for spell ID 439511 (Captain's Flourish) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)
	Timer for spell ID 439559 (Rain of Arrows) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)
	Timer for spell ID 442428 (Decimate) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)

Unused objects:
	[Announce] Decimate on >%s<, type=target, spellId=442428
	[Special Warning] Expose - defensive, type=defensive, spellId=435401
	[Special Warning] Phase Lunge - defensive, type=defensive, spellId=435403
	[Special Warning] Pierced Defenses on >%s< - taunt now, type=taunt, spellId=435410
	[Special Warning] Decimate on you, type=you, spellId=442428
	[Yell] %d, type=shortfade, spellId=442428
	[Yell] Decimate, type=shortyell, spellId=442428

Timers:
	Phase Blades (%s), time=42.60, type=cdcount, spellId=433517, triggerDeltas = 0.00, 13.13, 28.12, 48.80, 99.06, 97.63, 97.50
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 13.13] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000011E, 433475, Sikran, 91.7, 14, Tank2, 0
		[ 41.25] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000026B, 433475, Sikran, 75.7, 45, Dps14, 0
		[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 4x, delta times: 90.05, 99.06, 97.63, 97.50
	Tank Combo (%s), time=22.00, type=cdcount, spellId=439511, triggerDeltas = 0.00, 6.12, 25.39, 25.62, 32.92, 99.06, 97.63, 97.50
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[  6.12] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
			 Triggered 3x, delta times: 6.12, 25.39, 25.62
		[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 4x, delta times: 90.05, 99.06, 97.63, 97.50
	Rain of Arrows (%s), time=52.30, type=cdcount, spellId=439559, triggerDeltas = 0.00, 22.91, 67.14, 99.06, 97.63, 97.50
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 22.91] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 4x, delta times: 90.05, 99.06, 97.63, 97.50
	Decimate (%s), time=38.10, type=cdcount, spellId=442428, triggerDeltas = 0.00, 50.57, 39.48, 99.06, 97.63, 97.50
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 50.57] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 4x, delta times: 90.05, 99.06, 97.63, 97.50
	Shattering Sweep (%s), time=97.30, type=cdcount, spellId=456420, triggerDeltas = 0.00, 90.05, 99.06, 97.63, 97.50
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 4x, delta times: 90.05, 99.06, 97.63, 97.50
	Cosmic Shards fades, time=6.00, type=fades, spellId=459273, triggerDeltas = 52.93, 0.08, 27.50, 0.10, 0.08, 73.87, 0.11, 39.50, 0.04, 0.01, 0.00, 0.00, 0.01, 59.03, 0.07, 0.10, 0.07, 0.07, 27.94, 0.13, 0.05, 10.11, 0.00, 0.00, 0.04, 59.06, 0.05, 0.21, 0.04, 0.09, 0.06, 0.00, 27.60, 0.15, 0.12, 0.08, 0.06
		[ 52.93] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000D5, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
			 Triggered 9x, delta times: 52.93, 27.58, 74.05, 39.61, 59.09, 28.25, 10.29, 59.10, 28.05
		[ 53.01] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000D5, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
			 Triggered 28x, delta times: 53.01, 27.60, 0.08, 73.98, 39.54, 0.01, 0.00, 0.00, 0.01, 59.10, 0.10, 0.07, 0.07, 28.07, 0.05, 10.11, 0.00, 0.04, 59.11, 0.21, 0.04, 0.09, 0.06, 0.00, 27.75, 0.12, 0.08, 0.06
		[160.65] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000108, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
			 Triggered 2x, delta times: 160.65, 98.91

Announces:
	Phase Blades incoming debuff (%s), type=incomingcount, spellId=433517, triggerDeltas = 13.13, 28.12, 28.07, 40.26, 28.24, 28.13, 42.65, 27.99, 28.17, 41.46, 28.04, 28.07, 41.36, 27.91
		[ 13.13] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000011E, 433475, Sikran, 91.7, 14, Tank2, 0
		[ 41.25] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000026B, 433475, Sikran, 75.7, 45, Dps14, 0
		[ 69.32] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000253, 433475, Sikran, 67.6, 76, Tank2, 0
		[109.58] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000346, 433475, Sikran, 55.2, 16, Tank2, 0
		[137.82] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000460, 433475, Sikran, 45.6, 47, Dps14, 0
		[165.95] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000039E, 433475, Sikran, 36.4, 78, Tank2, 0
		[208.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000330, 433475, Sikran, 25.5, 17, Tank2, 0
		[236.59] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000031D, 433475, Sikran, 18.6, 48, Dps14, 0
		[264.76] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000044A, 433475, Sikran, 11.1, 79, Tank2, 0
		[306.22] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000214, 433475, Sikran, 7.7, 15, Tank2, 0
		[334.26] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000023B, 433475, Sikran, 6.9, 47, Dps14, 0
		[362.33] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000021F, 433475, Sikran, 6, 78, Tank2, 0
		[403.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000002A6, 433475, Sikran, 4.8, 15, Dps14, 0
		[431.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000364, 433475, Sikran, 3.9, 46, Tank2, 0
	Rain of Arrows (%s), type=count, spellId=439559, triggerDeltas = 22.91, 42.76, 53.66, 27.06, 26.27, 45.67, 26.80, 26.29, 44.54, 26.84, 26.38, 44.22, 26.65
		[ 22.91] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
			 Triggered 13x, delta times: 22.91, 42.76, 53.66, 27.06, 26.27, 45.67, 26.80, 26.29, 44.54, 26.84, 26.38, 44.22, 26.65
	Cosmic Shards (%s), type=count, spellId=459273, triggerDeltas = 53.51, 27.68, 73.98, 39.56, 59.34, 28.12, 10.15, 59.51, 28.01
		[ 53.51] Scheduled at 53.01 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000D5, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		[ 81.19] Scheduled at 80.69 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000031, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		[155.17] Scheduled at 154.67 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000108, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		[194.73] Scheduled at 194.23 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000057, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		[254.07] Scheduled at 253.57 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000EE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		[282.19] Scheduled at 281.69 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000111, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		[292.34] Scheduled at 291.84 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000098, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		[351.85] Scheduled at 351.35 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		[379.86] Scheduled at 379.36 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0

Special warnings:
	Expose on >%s< - taunt now, type=taunt, spellId=438845, triggerDeltas = 8.41, 51.01, 43.91, 55.15, 43.90, 56.05, 41.53, 56.14, 69.26
		[  8.41] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
			 Triggered 9x, delta times: 8.41, 51.01, 43.91, 55.15, 43.90, 56.05, 41.53, 56.14, 69.26
	Shattering Sweep - run away (%s), type=runcount, spellId=456420, triggerDeltas = 90.05, 99.06, 97.63, 97.50
		[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 4x, delta times: 90.05, 99.06, 97.63, 97.50

Yells:
	None

Voice pack sounds:
	VoicePack/justrun
		[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 4x, delta times: 90.05, 99.06, 97.63, 97.50
	VoicePack/tauntboss
		[  8.41] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
			 Triggered 9x, delta times: 8.41, 51.01, 43.91, 55.15, 43.90, 56.05, 41.53, 56.14, 69.26

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 456420 435401 432965 435403 439559 453258 442428, SPELL_AURA_APPLIED 459273 438845 435410 439191, SPELL_AURA_APPLIED_DOSE 459273 438845, SPELL_AURA_REMOVED 459273 439191, CHAT_MSG_RAID_BOSS_WHISPER, UNIT_SPELLCAST_SUCCEEDED boss1
		StartTimer: 6.0, Tank Combo (1)
		StartTimer: 12.4, Phase Blades (1)
		StartTimer: 23.0, Rain of Arrows (1)
		StartTimer: 50.8, Decimate (1)
		StartTimer: 89.9, Shattering Sweep (1)
	[  6.12] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (2)
	[  8.41] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 13.13] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000011E, 433475, Sikran, 91.7, 14, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (1)
		StartTimer: 27.6, Phase Blades (1)
	[ 22.91] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (1)
		StartTimer: 42.6, Rain of Arrows (2)
	[ 31.51] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (3)
	[ 41.25] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000026B, 433475, Sikran, 75.7, 45, Dps14, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (2)
		StartTimer: 27.6, Phase Blades (1)
	[ 50.57] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		StartTimer: 26.1, Decimate (2)
	[ 52.93] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000D5, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 53.43 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 53.01
		StartTimer: 6.0, Cosmic Shards fades
	[ 53.01] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000D5, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 52.93
		ScheduleTask: announce459273count:Schedule(2.0) at 53.51 (+0.50)
			ShowAnnounce: Cosmic Shards (2)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 57.13] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (4)
	[ 59.42] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 65.67] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (2)
	[ 69.32] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000253, 433475, Sikran, 67.6, 76, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (3)
	[ 80.51] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000031, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 81.01 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 80.61
		StartTimer: 6.0, Cosmic Shards fades
	[ 80.61] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000031, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 80.51
		ScheduleTask: announce459273count:Schedule(2.0) at 81.11 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 80.69
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 80.69] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000031, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 80.61
		ScheduleTask: announce459273count:Schedule(3.0) at 81.19 (+0.50)
			ShowAnnounce: Cosmic Shards (3)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 90.05] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Shattering Sweep - run away (1)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Shattering Sweep (2)
		StartTimer: 10.7, Tank Combo (5)
		StartTimer: 19.3, Phase Blades (4)
		StartTimer: 29.1, Rain of Arrows (3)
		StartTimer: 61.9, Decimate (3)
	[103.33] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[109.58] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000346, 433475, Sikran, 55.2, 16, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (4)
	[119.33] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (3)
	[137.82] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000460, 433475, Sikran, 45.6, 47, Dps14, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (5)
	[146.39] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (4)
	[154.56] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000108, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 155.06 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 154.67
		StartTimer: 6.0, Cosmic Shards fades
	[154.67] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000108, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 154.56
		ScheduleTask: announce459273count:Schedule(2.0) at 155.17 (+0.50)
			ShowAnnounce: Cosmic Shards (2)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[158.48] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[160.65] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000108, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[165.95] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000039E, 433475, Sikran, 36.4, 78, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (6)
	[172.66] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (5)
	[189.11] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Shattering Sweep - run away (2)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Shattering Sweep (3)
		StartTimer: 10.7, Tank Combo (9)
		StartTimer: 19.3, Phase Blades (7)
		StartTimer: 29.1, Rain of Arrows (6)
		StartTimer: 61.9, Decimate (5)
	[194.17] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000057, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 194.67 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 194.21
		StartTimer: 6.0, Cosmic Shards fades
	[194.21] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000057, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 194.17
		ScheduleTask: announce459273count:Schedule(2.0) at 194.71 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 194.22
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[194.22] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000057, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 194.21
		ScheduleTask: announce459273count:Schedule(3.0) at 194.72 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 194.22
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[194.22] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000057, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 194.22
		ScheduleTask: announce459273count:Schedule(4.0) at 194.72 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 194.22
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[194.22] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000057, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 194.22
		ScheduleTask: announce459273count:Schedule(5.0) at 194.72 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 194.23
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[194.23] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000057, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		UnscheduleTask: announce459273count:Schedule(5.0) scheduled by ScheduleTask at 194.22
		ScheduleTask: announce459273count:Schedule(6.0) at 194.73 (+0.50)
			ShowAnnounce: Cosmic Shards (6)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[202.38] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[208.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000330, 433475, Sikran, 25.5, 17, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (7)
	[218.33] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (6)
	[236.59] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000031D, 433475, Sikran, 18.6, 48, Dps14, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (8)
	[245.13] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (7)
	[253.26] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000EE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 253.76 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 253.33
		StartTimer: 6.0, Cosmic Shards fades
	[253.33] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000EE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 253.26
		ScheduleTask: announce459273count:Schedule(2.0) at 253.83 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 253.43
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[253.43] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000EE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 253.33
		ScheduleTask: announce459273count:Schedule(3.0) at 253.93 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 253.50
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[253.50] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000EE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 253.43
		ScheduleTask: announce459273count:Schedule(4.0) at 254.00 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 253.57
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[253.57] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000EE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 253.50
		ScheduleTask: announce459273count:Schedule(5.0) at 254.07 (+0.50)
			ShowAnnounce: Cosmic Shards (5)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[258.43] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[259.56] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000EE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[264.76] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000044A, 433475, Sikran, 11.1, 79, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (9)
	[271.42] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (8)
	[281.51] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000111, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 282.01 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 281.64
		StartTimer: 6.0, Cosmic Shards fades
	[281.64] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000111, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 281.51
		ScheduleTask: announce459273count:Schedule(2.0) at 282.14 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 281.69
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[281.69] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000111, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 281.64
		ScheduleTask: announce459273count:Schedule(3.0) at 282.19 (+0.50)
			ShowAnnounce: Cosmic Shards (3)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[286.74] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Shattering Sweep - run away (3)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Shattering Sweep (4)
		StartTimer: 10.7, Tank Combo (13)
		StartTimer: 19.3, Phase Blades (10)
		StartTimer: 29.1, Rain of Arrows (9)
		StartTimer: 61.9, Decimate (7)
	[291.80] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000098, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 292.30 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 291.80
		StartTimer: 6.0, Cosmic Shards fades
	[291.80] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000098, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 291.80
		ScheduleTask: announce459273count:Schedule(2.0) at 292.30 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 291.80
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[291.80] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000098, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 291.80
		ScheduleTask: announce459273count:Schedule(3.0) at 292.30 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 291.84
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[291.84] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-0000000098, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 291.80
		ScheduleTask: announce459273count:Schedule(4.0) at 292.34 (+0.50)
			ShowAnnounce: Cosmic Shards (4)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[299.96] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[306.22] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000214, 433475, Sikran, 7.7, 15, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (10)
	[315.96] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (9)
	[334.26] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000023B, 433475, Sikran, 6.9, 47, Dps14, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (11)
	[342.80] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (10)
	[350.90] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 351.40 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 350.95
		StartTimer: 6.0, Cosmic Shards fades
	[350.95] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 350.90
		ScheduleTask: announce459273count:Schedule(2.0) at 351.45 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 351.16
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[351.16] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 350.95
		ScheduleTask: announce459273count:Schedule(3.0) at 351.66 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 351.20
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[351.20] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 351.16
		ScheduleTask: announce459273count:Schedule(4.0) at 351.70 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 351.29
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[351.29] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 351.20
		ScheduleTask: announce459273count:Schedule(5.0) at 351.79 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 351.35
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[351.35] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		UnscheduleTask: announce459273count:Schedule(5.0) scheduled by ScheduleTask at 351.29
		ScheduleTask: announce459273count:Schedule(6.0) at 351.85 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 351.35
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[351.35] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AE, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		UnscheduleTask: announce459273count:Schedule(6.0) scheduled by ScheduleTask at 351.35
		ScheduleTask: announce459273count:Schedule(7.0) at 351.85 (+0.50)
			ShowAnnounce: Cosmic Shards (7)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[356.10] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[362.33] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000021F, 433475, Sikran, 6, 78, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (12)
	[369.18] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (11)
	[378.95] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 379.45 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 379.10
		StartTimer: 6.0, Cosmic Shards fades
	[379.10] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 378.95
		ScheduleTask: announce459273count:Schedule(2.0) at 379.60 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 379.22
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[379.22] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 379.10
		ScheduleTask: announce459273count:Schedule(3.0) at 379.72 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 379.30
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[379.30] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 379.22
		ScheduleTask: announce459273count:Schedule(4.0) at 379.80 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 379.36
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[379.36] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank2: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000011, Tank2, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 379.30
		ScheduleTask: announce459273count:Schedule(5.0) at 379.86 (+0.50)
			ShowAnnounce: Cosmic Shards (5)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[384.24] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Shattering Sweep - run away (4)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Shattering Sweep (5)
		StartTimer: 10.7, Tank Combo (17)
		StartTimer: 19.3, Phase Blades (13)
		StartTimer: 29.1, Rain of Arrows (12)
		StartTimer: 61.9, Decimate (9)
	[403.69] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000002A6, 433475, Sikran, 4.8, 15, Dps14, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (13)
	[413.40] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (12)
	[425.36] SPELL_AURA_APPLIED_DOSE: [Sikran->Dps14: Expose] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, Player-1-00000020, Dps14, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Dps14 - taunt now
		PlaySound: VoicePack/tauntboss
	[431.60] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000364, 433475, Sikran, 3.9, 46, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Phase Blades incoming debuff (14)
	[440.05] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000002, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (13)
	[444.61] ENCOUNTER_END: 2898, Sikran, Captain of the Sureki, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 459273 439191
]]
