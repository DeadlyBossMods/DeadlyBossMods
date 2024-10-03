DBM.Test:Report[[
Test: TWW/NerubarPalace/Sikran/Mythic/Kill
Mod:  DBM-Raids-WarWithin/2599

Findings:
	Unused event registration: SPELL_AURA_APPLIED 435410 (Phase Lunge)
	Unused event registration: SPELL_AURA_APPLIED 438845 (Expose)
	Unused event registration: SPELL_AURA_APPLIED 439191 (Decimate)
	Unused event registration: SPELL_AURA_REMOVED 439191 (Decimate)
	Unused event registration: SPELL_AURA_REMOVED 459273 (Cosmic Shards)
	Unused event registration: SPELL_CAST_START 435401 (Expose)
	Unused event registration: SPELL_CAST_START 435403 (Phase Lunge)
	Unused event registration: SPELL_CAST_START 453258 (Rain of Arrows)
	Unused event registration: SPELL_CAST_SUCCESS 453258 (Rain of Arrows)
	Announce for spell ID 433517 (Phase Blades) is triggered by event SPELL_CAST_SUCCESS 433475 (Phase Blades)
	Timer for spell ID 433517 (Phase Blades) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)
	Timer for spell ID 433517 (Phase Blades) is triggered by event SPELL_CAST_SUCCESS 433475 (Phase Blades)
	Timer for spell ID 439511 (Captain's Flourish) is triggered by event SPELL_CAST_START 432965 (Expose)
	Timer for spell ID 439511 (Captain's Flourish) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)
	Timer for spell ID 439559 (Rain of Arrows) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)
	Timer for spell ID 442428 (Decimate) is triggered by event SPELL_CAST_START 456420 (Shattering Sweep)

Unused objects:
	[Special Warning] Expose - defensive, type=defensive, spellId=435401
	[Special Warning] Phase Lunge - defensive, type=defensive, spellId=435403
	[Special Warning] Phase Lunge on >%s< - taunt now, type=taunt, spellId=435410

Timers:
	Charge (%s), time=42.60, type=cdcount, spellId=433517, triggerDeltas = 0.00, 12.37, 28.11, 49.86, 21.75, 27.89, 48.50, 19.47, 27.92, 50.01, 21.73, 27.94
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 12.37] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
			 Triggered 8x, delta times: 12.37, 28.11, 71.61, 27.89, 67.97, 27.92, 71.74, 27.94
		[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.34, 98.14, 97.40
	Tank Combo (%s), time=22.00, type=cdcount, spellId=439511, triggerDeltas = 0.00, 6.28, 25.69, 25.54, 32.83, 12.17, 26.72, 26.45, 32.80, 12.16, 26.72, 26.74, 31.78, 12.17, 26.71
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[  6.28] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
			 Triggered 11x, delta times: 6.28, 25.69, 25.54, 45.00, 26.72, 26.45, 44.96, 26.72, 26.74, 43.95, 26.71
		[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.34, 98.14, 97.40
	Rain of Arrows (%s), time=52.30, type=cdcount, spellId=439559, triggerDeltas = 0.00, 22.17, 68.17, 19.49, 27.89, 50.76, 20.70, 27.91, 48.79, 19.47, 27.92
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 22.17] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
			 Triggered 7x, delta times: 22.17, 87.66, 27.89, 71.46, 27.91, 68.26, 27.92
		[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.34, 98.14, 97.40
	Decimate (%s), time=38.10, type=cdcount, spellId=442428, triggerDeltas = 0.00, 51.61, 38.73, 60.14, 38.00, 60.62, 36.78
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 51.61] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
			 Triggered 3x, delta times: 51.61, 98.87, 98.62
		[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.34, 98.14, 97.40
	Sweep (%s), time=97.30, type=cdcount, spellId=456420, triggerDeltas = 0.00, 90.34, 98.14, 97.40
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.34, 98.14, 97.40
	Cosmic Shards fades, time=6.00, type=fades, spellId=459273, triggerDeltas = 53.83, 0.01, 0.06, 0.00, 0.10, 0.01, 0.06, 26.52, 0.09, 0.02, 0.00, 0.19, 37.75, 0.01, 34.15, 0.00, 0.01, 0.07, 0.00, 0.07, 0.07, 26.72, 0.05, 0.07, 0.06, 62.34, 0.01, 9.03, 0.10, 0.00, 0.05, 27.84, 0.00, 0.06, 0.01, 0.11, 0.04, 34.41, 0.02
		[ 53.83] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
			 Triggered 9x, delta times: 53.83, 26.76, 38.05, 34.16, 26.94, 62.52, 9.04, 27.99, 34.63
		[ 53.84] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
			 Triggered 30x, delta times: 53.84, 0.06, 0.00, 0.10, 0.01, 0.06, 26.61, 0.02, 0.00, 0.19, 37.76, 34.15, 0.01, 0.07, 0.00, 0.07, 0.07, 26.77, 0.07, 0.06, 62.35, 9.13, 0.00, 0.05, 27.84, 0.06, 0.01, 0.11, 0.04, 34.43

Announces:
	Charge incoming debuff (%s), type=incomingcount, spellId=433517, triggerDeltas = 12.37, 28.11, 28.00, 43.61, 27.89, 27.68, 40.29, 27.92, 27.97, 43.77, 27.94
		[ 12.37] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
			 Triggered 11x, delta times: 12.37, 28.11, 28.00, 43.61, 27.89, 27.68, 40.29, 27.92, 27.97, 43.77, 27.94
	Decimate incoming debuff (%s), type=incomingcount, spellId=442428, triggerDeltas = 51.61, 26.84, 72.03, 27.11, 71.51, 27.98
		[ 51.61] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
			 Triggered 6x, delta times: 51.61, 26.84, 72.03, 27.11, 71.51, 27.98
	Cosmic Shards (%s), type=count, spellId=459273, triggerDeltas = 54.57, 26.82, 37.76, 34.37, 26.90, 62.35, 9.18, 28.06, 34.43
		[ 54.57] Scheduled at 54.07 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		[ 81.39] Scheduled at 80.89 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000009D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		[119.15] Scheduled at 118.65 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000A1, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		[153.52] Scheduled at 153.02 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		[180.42] Scheduled at 179.92 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AB, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		[242.77] Scheduled at 242.27 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		[251.95] Scheduled at 251.45 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006E, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		[280.01] Scheduled at 279.51 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		[314.44] Scheduled at 313.94 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000008D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0

Special warnings:
	Expose on >%s< - taunt now, type=taunt, spellId=438845, triggerDeltas = 34.25, 51.07, 46.18, 53.20, 44.94, 53.65, 43.74
		[ 34.25] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
			 Triggered 7x, delta times: 34.25, 51.07, 46.18, 53.20, 44.94, 53.65, 43.74
	Rain of Arrows (%s) - dodge attack, type=dodgecount, spellId=439559, triggerDeltas = 24.19, 40.20, 47.46, 27.86, 27.70, 43.75, 27.93, 27.94, 40.32, 27.93
		[ 24.19] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
			 Triggered 10x, delta times: 24.19, 40.20, 47.46, 27.86, 27.70, 43.75, 27.93, 27.94, 40.32, 27.93
	Sweep - run away (%s), type=runcount, spellId=456420, triggerDeltas = 90.34, 98.14, 97.40
		[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.34, 98.14, 97.40

Yells:
	None

Voice pack sounds:
	VoicePack/justrun
		[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.34, 98.14, 97.40
	VoicePack/tauntboss
		[ 34.25] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
			 Triggered 7x, delta times: 34.25, 51.07, 46.18, 53.20, 44.94, 53.65, 43.74
	VoicePack/watchstep
		[ 24.19] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
			 Triggered 10x, delta times: 24.19, 40.20, 47.46, 27.86, 27.70, 43.75, 27.93, 27.94, 40.32, 27.93

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 456420 435401 432965 435403 439559 453258 442428, SPELL_CAST_SUCCESS 439559 453258 433475, SPELL_AURA_APPLIED 459273 438845 435410 439191, SPELL_AURA_APPLIED_DOSE 459273 438845, SPELL_AURA_REMOVED 459273 439191
		StartTimer: 6.0, Tank Combo (1)
		StartTimer: 12.4, Charge (1)
		StartTimer: 22.2, Rain of Arrows (1)
		StartTimer: 50.8, Decimate (1)
		StartTimer: 89.9, Sweep (1)
	[  6.28] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (2)
	[ 12.37] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (1)
		StartTimer: 27.6, Charge (2)
	[ 22.17] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		StartTimer: 40.2, Rain of Arrows (2)
	[ 24.19] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (1) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 31.97] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (3)
	[ 34.25] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 40.48] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (2)
		StartTimer: 27.6, Charge (3)
	[ 51.61] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		ShowAnnounce: Decimate incoming debuff (1)
		StartTimer: 26.1, Decimate (2)
	[ 53.83] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 54.33 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 53.84
		StartTimer: 6.0, Cosmic Shards fades
	[ 53.84] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 53.83
		ScheduleTask: announce459273count:Schedule(2.0) at 54.34 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 53.90
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 53.90] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 53.84
		ScheduleTask: announce459273count:Schedule(3.0) at 54.40 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 53.90
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 53.90] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 53.90
		ScheduleTask: announce459273count:Schedule(4.0) at 54.40 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.00
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.00] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 53.90
		ScheduleTask: announce459273count:Schedule(5.0) at 54.50 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.01
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.01] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		UnscheduleTask: announce459273count:Schedule(5.0) scheduled by ScheduleTask at 54.00
		ScheduleTask: announce459273count:Schedule(6.0) at 54.51 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.07
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.07] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000099, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		UnscheduleTask: announce459273count:Schedule(6.0) scheduled by ScheduleTask at 54.01
		ScheduleTask: announce459273count:Schedule(7.0) at 54.57 (+0.50)
			ShowAnnounce: Cosmic Shards (7)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 57.51] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (4)
	[ 64.39] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 68.48] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (3)
	[ 78.45] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		ShowAnnounce: Decimate incoming debuff (2)
	[ 80.59] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000009D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 81.09 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 80.68
		StartTimer: 6.0, Cosmic Shards fades
	[ 80.68] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000009D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 80.59
		ScheduleTask: announce459273count:Schedule(2.0) at 81.18 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 80.70
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 80.70] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000009D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 80.68
		ScheduleTask: announce459273count:Schedule(3.0) at 81.20 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 80.70
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 80.70] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000009D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 80.70
		ScheduleTask: announce459273count:Schedule(4.0) at 81.20 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 80.89
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 80.89] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000009D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 80.70
		ScheduleTask: announce459273count:Schedule(5.0) at 81.39 (+0.50)
			ShowAnnounce: Cosmic Shards (5)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 85.32] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 90.34] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Sweep - run away (1)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Sweep (2)
		StartTimer: 10.7, Tank Combo (5)
		StartTimer: 19.3, Charge (4)
		StartTimer: 19.5, Rain of Arrows (3)
		StartTimer: 60.1, Decimate (3)
	[102.51] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (6)
	[109.83] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		StartTimer: 27.9, Rain of Arrows (4)
	[111.85] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (3) - dodge attack
		PlaySound: VoicePack/watchstep
	[112.09] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (4)
		StartTimer: 27.6, Charge (5)
	[118.64] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000A1, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 119.14 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 118.65
		StartTimer: 6.0, Cosmic Shards fades
	[118.65] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000A1, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 118.64
		ScheduleTask: announce459273count:Schedule(2.0) at 119.15 (+0.50)
			ShowAnnounce: Cosmic Shards (2)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[129.23] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (7)
	[131.50] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[137.72] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		StartTimer: 27.9, Rain of Arrows (5)
	[139.71] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (4) - dodge attack
		PlaySound: VoicePack/watchstep
	[139.98] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (5)
		StartTimer: 27.6, Charge (6)
	[150.48] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		ShowAnnounce: Decimate incoming debuff (3)
		StartTimer: 27.1, Decimate (4)
	[152.80] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 153.30 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 152.80
		StartTimer: 6.0, Cosmic Shards fades
	[152.80] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 152.80
		ScheduleTask: announce459273count:Schedule(2.0) at 153.30 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 152.81
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[152.81] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 152.80
		ScheduleTask: announce459273count:Schedule(3.0) at 153.31 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 152.88
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[152.88] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 152.81
		ScheduleTask: announce459273count:Schedule(4.0) at 153.38 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 152.88
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[152.88] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 152.88
		ScheduleTask: announce459273count:Schedule(5.0) at 153.38 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 152.95
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[152.95] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		UnscheduleTask: announce459273count:Schedule(5.0) scheduled by ScheduleTask at 152.88
		ScheduleTask: announce459273count:Schedule(6.0) at 153.45 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 153.02
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[153.02] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-0000000049, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		UnscheduleTask: announce459273count:Schedule(6.0) scheduled by ScheduleTask at 152.95
		ScheduleTask: announce459273count:Schedule(7.0) at 153.52 (+0.50)
			ShowAnnounce: Cosmic Shards (7)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[155.68] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (8)
	[167.41] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (5) - dodge attack
		PlaySound: VoicePack/watchstep
	[167.66] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (6)
	[177.59] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		ShowAnnounce: Decimate incoming debuff (4)
	[179.74] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AB, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 180.24 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 179.79
		StartTimer: 6.0, Cosmic Shards fades
	[179.79] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AB, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 179.74
		ScheduleTask: announce459273count:Schedule(2.0) at 180.29 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 179.86
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[179.86] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AB, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 179.79
		ScheduleTask: announce459273count:Schedule(3.0) at 180.36 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 179.92
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[179.92] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000AB, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 179.86
		ScheduleTask: announce459273count:Schedule(4.0) at 180.42 (+0.50)
			ShowAnnounce: Cosmic Shards (4)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[184.70] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[188.48] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Sweep - run away (2)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Sweep (3)
		StartTimer: 10.7, Tank Combo (9)
		StartTimer: 19.3, Charge (7)
		StartTimer: 19.5, Rain of Arrows (6)
		StartTimer: 60.1, Decimate (5)
	[200.64] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (10)
	[207.95] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (7)
		StartTimer: 27.6, Charge (8)
	[209.18] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		StartTimer: 27.9, Rain of Arrows (7)
	[211.16] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (6) - dodge attack
		PlaySound: VoicePack/watchstep
	[227.36] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (11)
	[229.64] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[235.87] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (8)
		StartTimer: 27.6, Charge (9)
	[237.09] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		StartTimer: 27.9, Rain of Arrows (8)
	[239.09] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (7) - dodge attack
		PlaySound: VoicePack/watchstep
	[242.26] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 242.76 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 242.27
		StartTimer: 6.0, Cosmic Shards fades
	[242.27] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 242.26
		ScheduleTask: announce459273count:Schedule(2.0) at 242.77 (+0.50)
			ShowAnnounce: Cosmic Shards (2)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[249.10] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		ShowAnnounce: Decimate incoming debuff (5)
		StartTimer: 27.1, Decimate (6)
	[251.30] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006E, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 251.80 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 251.40
		StartTimer: 6.0, Cosmic Shards fades
	[251.40] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006E, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 251.30
		ScheduleTask: announce459273count:Schedule(2.0) at 251.90 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 251.40
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[251.40] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006E, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 251.40
		ScheduleTask: announce459273count:Schedule(3.0) at 251.90 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 251.45
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[251.45] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000006E, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 251.40
		ScheduleTask: announce459273count:Schedule(4.0) at 251.95 (+0.50)
			ShowAnnounce: Cosmic Shards (4)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[254.10] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (12)
	[263.84] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (9)
	[267.03] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (8) - dodge attack
		PlaySound: VoicePack/watchstep
	[277.08] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		ShowAnnounce: Decimate incoming debuff (6)
	[279.29] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 279.79 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 279.29
		StartTimer: 6.0, Cosmic Shards fades
	[279.29] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 279.29
		ScheduleTask: announce459273count:Schedule(2.0) at 279.79 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 279.35
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[279.35] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 279.29
		ScheduleTask: announce459273count:Schedule(3.0) at 279.85 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 279.36
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[279.36] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 279.35
		ScheduleTask: announce459273count:Schedule(4.0) at 279.86 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 279.47
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[279.47] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 279.36
		ScheduleTask: announce459273count:Schedule(5.0) at 279.97 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 279.51
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[279.51] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B8, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		UnscheduleTask: announce459273count:Schedule(5.0) scheduled by ScheduleTask at 279.47
		ScheduleTask: announce459273count:Schedule(6.0) at 280.01 (+0.50)
			ShowAnnounce: Cosmic Shards (6)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[283.29] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[285.88] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Sweep - run away (3)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Sweep (4)
		StartTimer: 10.7, Tank Combo (13)
		StartTimer: 19.3, Charge (10)
		StartTimer: 19.5, Rain of Arrows (9)
		StartTimer: 60.1, Decimate (7)
	[298.05] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (14)
	[305.35] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		StartTimer: 27.9, Rain of Arrows (10)
	[307.35] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (9) - dodge attack
		PlaySound: VoicePack/watchstep
	[307.61] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (10)
		StartTimer: 27.6, Charge (11)
	[313.92] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000008D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 314.42 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 313.94
		StartTimer: 6.0, Cosmic Shards fades
	[313.94] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Dps19: Cosmic Shards] Creature-0-1-2657-1-228746-000000008D, Cosmic Simulacrum, 0xa48, Player-1-00000019, Dps19, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 313.92
		ScheduleTask: announce459273count:Schedule(2.0) at 314.44 (+0.50)
			ShowAnnounce: Cosmic Shards (2)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[324.76] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 26.4, Tank Combo (15)
	[327.03] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank1: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank1, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank1 - taunt now
		PlaySound: VoicePack/tauntboss
	[333.27] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		StartTimer: 27.9, Rain of Arrows (11)
	[335.28] SPELL_CAST_SUCCESS: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowSpecialWarning: Rain of Arrows (10) - dodge attack
		PlaySound: VoicePack/watchstep
	[335.55] SPELL_CAST_SUCCESS: [Sikran: Phase Blades] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 433475, Phase Blades, 0, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (11)
		StartTimer: 27.6, Charge (12)
	[336.09] ENCOUNTER_END: 2898, Sikran, Captain of the Sureki, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 459273 439191
]]
