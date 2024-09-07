DBM.Test:Report[[
Test: TWW/NerubarPalace/Sikran/Mythic/Wipe
Mod:  DBM-Raids-WarWithin/2599

Findings:
	Unused event registration: CHAT_MSG_RAID_BOSS_WHISPER
	Unused event registration: SPELL_AURA_APPLIED 435410 (Phase Lunge)
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
	[Special Warning] Phase Lunge on >%s< - taunt now, type=taunt, spellId=435410
	[Special Warning] Decimate on you, type=you, spellId=442428
	[Yell] %d, type=shortfade, spellId=442428
	[Yell] Decimate, type=shortyell, spellId=442428

Timers:
	Charge (%s), time=42.60, type=cdcount, spellId=433517, triggerDeltas = 0.00, 13.09, 27.95, 49.89, 97.33, 98.44
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 13.09] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000002A9, 433475, Sikran, 93.1, 14, Tank2, 0
		[ 41.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000200, 433475, Sikran, 78.6, 45, Tank1, 0
		[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.93, 97.33, 98.44
	Tank Combo (%s), time=22.00, type=cdcount, spellId=439511, triggerDeltas = 0.00, 7.03, 25.50, 25.60, 32.80, 97.33, 98.44
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[  7.03] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
			 Triggered 3x, delta times: 7.03, 25.50, 25.60
		[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.93, 97.33, 98.44
	Rain of Arrows (%s), time=52.30, type=cdcount, spellId=439559, triggerDeltas = 0.00, 22.82, 68.11, 97.33, 98.44
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 22.82] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.93, 97.33, 98.44
	Decimate (%s), time=38.10, type=cdcount, spellId=442428, triggerDeltas = 0.00, 51.71, 39.22, 97.33, 98.44
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 51.71] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.93, 97.33, 98.44
	Sweep (%s), time=97.30, type=cdcount, spellId=456420, triggerDeltas = 0.00, 90.93, 97.33, 98.44
		[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.93, 97.33, 98.44
	Cosmic Shards fades, time=6.00, type=fades, spellId=459273, triggerDeltas = 49.94, 4.06, 0.07, 0.01, 0.07, 0.01, 0.02, 27.17, 0.07, 63.43, 1.89, 7.07, 0.05, 0.06, 27.36, 0.06, 0.06, 0.09, 64.83, 4.28, 0.05, 0.06, 27.52, 0.05, 0.00
		[ 49.94] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
			 Triggered 7x, delta times: 49.94, 31.41, 63.50, 8.96, 27.47, 65.04, 31.91
		[ 54.00] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
			 Triggered 18x, delta times: 54.00, 0.07, 0.01, 0.07, 0.01, 0.02, 27.24, 65.32, 7.12, 0.06, 27.42, 0.06, 0.09, 69.11, 0.05, 0.06, 27.57, 0.00
		[ 60.13] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
			 Triggered 6x, delta times: 60.13, 27.24, 65.34, 7.16, 95.81, 28.58

Announces:
	Charge incoming debuff (%s), type=incomingcount, spellId=433517, triggerDeltas = 13.09, 27.95, 28.02, 41.31, 27.95, 29.26, 40.18, 30.41, 27.85, 40.11
		[ 13.09] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000002A9, 433475, Sikran, 93.1, 14, Tank2, 0
		[ 41.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000200, 433475, Sikran, 78.6, 45, Tank1, 0
		[ 69.06] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000256, 433475, Sikran, 70.3, 76, Tank2, 0
		[110.37] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000002DD, 433475, Sikran, 59, 17, Tank2, 0
		[138.32] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000329, 433475, Sikran, 50.5, 48, Tank1, 0
		[167.58] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000037D, 433475, Sikran, 41.5, 80, Tank2, 0
		[207.76] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000016F, 433475, Sikran, 30.9, 16, Tank2, 0
		[238.17] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000001BF, 433475, Sikran, 22.8, 49, Tank1, 0
		[266.02] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000001DF, 433475, Sikran, 15.4, 80, Tank2, 0
		[306.13] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000001C4, 433475, Sikran, 5.6, 15, Dps7, 0
	Rain of Arrows (%s), type=count, spellId=439559, triggerDeltas = 22.82, 40.17, 48.60, 26.74, 26.85, 43.81, 26.73, 26.64, 44.99
		[ 22.82] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
			 Triggered 9x, delta times: 22.82, 40.17, 48.60, 26.74, 26.85, 43.81, 26.73, 26.64, 44.99
	Cosmic Shards (%s), type=count, spellId=459273, triggerDeltas = 50.44, 4.24, 27.24, 63.43, 1.89, 7.18, 27.57, 64.83, 4.39, 27.57
		[ 50.44] Scheduled at 49.94 by SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		[ 54.68] Scheduled at 54.18 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		[ 81.92] Scheduled at 81.42 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000E9, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		[145.35] Scheduled at 144.85 by SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000073, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		[147.24] Scheduled at 146.74 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000073, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		[154.42] Scheduled at 153.92 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000146, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		[181.99] Scheduled at 181.49 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000087, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		[246.82] Scheduled at 246.32 by SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B6, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		[251.21] Scheduled at 250.71 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B6, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		[278.78] Scheduled at 278.28 by SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000115, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0

Special warnings:
	Expose on >%s< - taunt now, type=taunt, spellId=438845, triggerDeltas = 34.82, 51.06, 46.21, 53.57, 43.80, 53.44, 17.80
		[ 34.82] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
			 Triggered 7x, delta times: 34.82, 51.06, 46.21, 53.57, 43.80, 53.44, 17.80
	Sweep - run away (%s), type=runcount, spellId=456420, triggerDeltas = 90.93, 97.33, 98.44
		[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.93, 97.33, 98.44

Yells:
	None

Voice pack sounds:
	VoicePack/justrun
		[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
			 Triggered 3x, delta times: 90.93, 97.33, 98.44
	VoicePack/tauntboss
		[ 34.82] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
			 Triggered 7x, delta times: 34.82, 51.06, 46.21, 53.57, 43.80, 53.44, 17.80

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2898, Sikran, Captain of the Sureki, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 456420 435401 432965 435403 439559 453258 442428, SPELL_AURA_APPLIED 459273 438845 435410 439191, SPELL_AURA_APPLIED_DOSE 459273 438845, SPELL_AURA_REMOVED 459273 439191, CHAT_MSG_RAID_BOSS_WHISPER, UNIT_SPELLCAST_SUCCEEDED boss1
		StartTimer: 6.0, Tank Combo (1)
		StartTimer: 12.4, Charge (1)
		StartTimer: 23.0, Rain of Arrows (1)
		StartTimer: 50.8, Decimate (1)
		StartTimer: 89.9, Sweep (1)
	[  7.03] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (2)
	[ 13.09] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000002A9, 433475, Sikran, 93.1, 14, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (1)
		StartTimer: 27.6, Charge (1)
	[ 22.82] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (1)
		StartTimer: 42.6, Rain of Arrows (2)
	[ 32.53] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (3)
	[ 34.82] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 41.04] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000200, 433475, Sikran, 78.6, 45, Tank1, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (2)
		StartTimer: 27.6, Charge (1)
	[ 49.94] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 50.44 (+0.50)
			ShowAnnounce: Cosmic Shards (1)
		StartTimer: 6.0, Cosmic Shards fades
	[ 51.71] SPELL_CAST_START: [Sikran: Decimate] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 442428, Decimate, 0, 0
		StartTimer: 26.1, Decimate (2)
	[ 54.00] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		ScheduleTask: announce459273count:Schedule(2.0) at 54.50 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.07
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.07] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 54.00
		ScheduleTask: announce459273count:Schedule(3.0) at 54.57 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.08
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.08] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 54.07
		ScheduleTask: announce459273count:Schedule(4.0) at 54.58 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.15
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.15] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 5, 0
		UnscheduleTask: announce459273count:Schedule(4.0) scheduled by ScheduleTask at 54.08
		ScheduleTask: announce459273count:Schedule(5.0) at 54.65 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.16
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.16] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 6, 0
		UnscheduleTask: announce459273count:Schedule(5.0) scheduled by ScheduleTask at 54.15
		ScheduleTask: announce459273count:Schedule(6.0) at 54.66 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 54.18
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 54.18] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 7, 0
		UnscheduleTask: announce459273count:Schedule(6.0) scheduled by ScheduleTask at 54.16
		ScheduleTask: announce459273count:Schedule(7.0) at 54.68 (+0.50)
			ShowAnnounce: Cosmic Shards (7)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 58.13] SPELL_CAST_START: [Sikran: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 432965, Expose, 0, 0
		StartTimer: 25.1, Tank Combo (4)
	[ 60.13] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-000000011C, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[ 62.99] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (2)
	[ 69.06] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000256, 433475, Sikran, 70.3, 76, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (3)
	[ 81.35] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000E9, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 81.85 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 81.42
		StartTimer: 6.0, Cosmic Shards fades
	[ 81.42] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000E9, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 81.35
		ScheduleTask: announce459273count:Schedule(2.0) at 81.92 (+0.50)
			ShowAnnounce: Cosmic Shards (2)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[ 85.88] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 87.37] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000E9, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[ 90.93] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Sweep - run away (1)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Sweep (2)
		StartTimer: 10.7, Tank Combo (5)
		StartTimer: 19.3, Charge (4)
		StartTimer: 29.1, Rain of Arrows (3)
		StartTimer: 61.9, Decimate (3)
	[110.37] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000002DD, 433475, Sikran, 59, 17, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (4)
	[111.59] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (3)
	[132.09] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[138.32] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-0000000329, 433475, Sikran, 50.5, 48, Tank1, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (5)
	[138.33] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (4)
	[144.85] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000073, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 145.35 (+0.50)
			ShowAnnounce: Cosmic Shards (1)
		StartTimer: 6.0, Cosmic Shards fades
	[146.74] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000073, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		ScheduleTask: announce459273count:Schedule(2.0) at 147.24 (+0.50)
			ShowAnnounce: Cosmic Shards (2)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[152.71] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000073, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[153.81] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000146, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 154.31 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 153.86
		StartTimer: 6.0, Cosmic Shards fades
	[153.86] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000146, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 153.81
		ScheduleTask: announce459273count:Schedule(2.0) at 154.36 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 153.92
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[153.92] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000146, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 153.86
		ScheduleTask: announce459273count:Schedule(3.0) at 154.42 (+0.50)
			ShowAnnounce: Cosmic Shards (3)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[159.87] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000146, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[165.18] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (5)
	[167.58] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000037D, 433475, Sikran, 41.5, 80, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (6)
	[181.28] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000087, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 181.78 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 181.34
		StartTimer: 6.0, Cosmic Shards fades
	[181.34] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000087, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 181.28
		ScheduleTask: announce459273count:Schedule(2.0) at 181.84 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 181.40
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[181.40] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000087, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 181.34
		ScheduleTask: announce459273count:Schedule(3.0) at 181.90 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 181.49
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[181.49] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000087, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 181.40
		ScheduleTask: announce459273count:Schedule(4.0) at 181.99 (+0.50)
			ShowAnnounce: Cosmic Shards (4)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[185.66] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[188.26] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Sweep - run away (2)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Sweep (3)
		StartTimer: 10.7, Tank Combo (9)
		StartTimer: 19.3, Charge (7)
		StartTimer: 29.1, Rain of Arrows (6)
		StartTimer: 61.9, Decimate (5)
	[207.76] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-000000016F, 433475, Sikran, 30.9, 16, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (7)
	[208.99] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (6)
	[229.46] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[235.72] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (7)
	[238.17] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000001BF, 433475, Sikran, 22.8, 49, Tank1, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (8)
	[246.32] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B6, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 246.82 (+0.50)
			ShowAnnounce: Cosmic Shards (1)
		StartTimer: 6.0, Cosmic Shards fades
	[250.60] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B6, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		ScheduleTask: announce459273count:Schedule(2.0) at 251.10 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 250.65
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[250.65] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B6, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 250.60
		ScheduleTask: announce459273count:Schedule(3.0) at 251.15 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 250.71
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[250.71] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B6, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 4, 0
		UnscheduleTask: announce459273count:Schedule(3.0) scheduled by ScheduleTask at 250.65
		ScheduleTask: announce459273count:Schedule(4.0) at 251.21 (+0.50)
			ShowAnnounce: Cosmic Shards (4)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[255.68] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-00000000B6, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[262.36] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (8)
	[266.02] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000001DF, 433475, Sikran, 15.4, 80, Tank2, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (9)
	[278.23] SPELL_AURA_APPLIED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000115, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		ScheduleTask: announce459273count:Schedule(1.0) at 278.73 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 278.28
		StartTimer: 6.0, Cosmic Shards fades
	[278.28] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000115, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 2, 0
		UnscheduleTask: announce459273count:Schedule(1.0) scheduled by ScheduleTask at 278.23
		ScheduleTask: announce459273count:Schedule(2.0) at 278.78 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 278.28
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[278.28] SPELL_AURA_APPLIED_DOSE: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000115, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 3, 0
		UnscheduleTask: announce459273count:Schedule(2.0) scheduled by ScheduleTask at 278.28
		ScheduleTask: announce459273count:Schedule(3.0) at 278.78 (+0.50)
			ShowAnnounce: Cosmic Shards (3)
		StopTimer: Timer459273fades
		StartTimer: 6.0, Cosmic Shards fades
	[282.90] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[284.26] SPELL_AURA_REMOVED: [Cosmic Simulacrum->Tank1: Cosmic Shards] Creature-0-1-2657-1-228746-0000000115, Cosmic Simulacrum, 0xa48, Player-1-00000010, Tank1, 0x511, 459273, Cosmic Shards, 0, DEBUFF, 0
		StopTimer: Timer459273fades
	[286.70] SPELL_CAST_START: [Sikran: Shattering Sweep] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 456420, Shattering Sweep, 0, 0
		ShowSpecialWarning: Sweep - run away (3)
		PlaySound: VoicePack/justrun
		StartTimer: 97.3, Sweep (4)
		StartTimer: 10.7, Tank Combo (13)
		StartTimer: 19.3, Charge (10)
		StartTimer: 29.1, Rain of Arrows (9)
		StartTimer: 61.9, Decimate (7)
	[300.70] SPELL_AURA_APPLIED_DOSE: [Sikran->Tank2: Expose] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, Player-1-00000020, Tank2, 0x512, 438845, Expose, 0, DEBUFF, 2, 0
		AntiSpam: 1
		ShowSpecialWarning: Expose on Tank2 - taunt now
		PlaySound: VoicePack/tauntboss
	[306.13] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-433475-00000001C4, 433475, Sikran, 5.6, 15, Dps7, 0
		AntiSpam: 2
		ShowAnnounce: Charge incoming debuff (10)
	[307.35] SPELL_CAST_START: [Sikran: Rain of Arrows] Creature-0-1-2657-1-214503-0000000001, Sikran, 0xa48, "", nil, 0x0, 439559, Rain of Arrows, 0, 0
		ShowAnnounce: Rain of Arrows (9)
	[315.91] ENCOUNTER_END: 2898, Sikran, Captain of the Sureki, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 459273 439191
]]
