DBM.Test:Report[[
Test: TWW/NerubarPalace/SilkenCourt/Mythic/Wipe
Mod:  DBM-Raids-WarWithin/2608

Findings:
	Unused event registration: SPELL_AURA_APPLIED 438200 (Poison Bolt)
	Unused event registration: SPELL_AURA_APPLIED 438708 (Stinging Swarm)
	Unused event registration: SPELL_AURA_APPLIED 440001 (Binding Webs)
	Unused event registration: SPELL_AURA_APPLIED 440179 (Entangled)
	Unused event registration: SPELL_AURA_APPLIED 443598 (Uncontrollable Rage)
	Unused event registration: SPELL_AURA_APPLIED 450728 (Stinging Swarm)
	Unused event registration: SPELL_AURA_APPLIED 450980 (Shatter Existence)
	Unused event registration: SPELL_AURA_APPLIED 451277 (Spike Storm)
	Unused event registration: SPELL_AURA_APPLIED 455080 (Scarab Lord's Perseverance)
	Unused event registration: SPELL_AURA_APPLIED 455850 (Mark of Rage)
	Unused event registration: SPELL_AURA_APPLIED 456235 (Stinging Delirium)
	Unused event registration: SPELL_AURA_APPLIED 456245 (Stinging Delirium)
	Unused event registration: SPELL_AURA_APPLIED 456252 (Stinging Swarm)
	Unused event registration: SPELL_AURA_REMOVED 440001 (Binding Webs)
	Unused event registration: SPELL_AURA_REMOVED 450980 (Shatter Existence)
	Unused event registration: SPELL_AURA_REMOVED 451277 (Spike Storm)
	Unused event registration: SPELL_AURA_REMOVED 455080 (Scarab Lord's Perseverance)
	Unused event registration: SPELL_CAST_START 438355 (Cataclysmic Entropy)
	Unused event registration: SPELL_CAST_START 438677 (Stinging Swarm)
	Unused event registration: SPELL_CAST_START 441626 (Web Vortex)
	Unused event registration: SPELL_CAST_START 441782 (Strands of Reality)
	Unused event registration: SPELL_CAST_START 442994 (Unleashed Swarm)
	Unused event registration: SPELL_CAST_START 443068 (Spike Eruption)
	Unused event registration: SPELL_CAST_START 450129 (Entropic Desolation)
	Unused event registration: SPELL_CAST_START 450483 (Void Step)
	Unused event registration: SPELL_CAST_START 451016 (Shatter Existence)
	Unused event registration: SPELL_CAST_START 451327 (Raging Fury)
	Unused event registration: SPELL_CAST_START 452231 (Stinging Swarm)
	Announce for spell ID 438656 (Venomous Rain) is triggered by event SPELL_CAST_START 438343 (Venomous Rain)
	Timer for spell ID 438656 (Venomous Rain) is triggered by event SPELL_CAST_START 438343 (Venomous Rain)

Unused objects:
	[Announce] Binding Webs faded, type=fades, spellId=440001
	[Announce] Entangled on >%s<, type=target, spellId=440179
	[Announce] Skittering Leap on >%s<, type=target, spellId=450045
	[Announce] Casting Run away!: 4.0 sec, type=cast, spellId=450129
	[Announce] Teleport (%s), type=count, spellId=450483
	[Announce] Stinging Delirium on >%s<, type=target, spellId=456245
	[Special Warning] Piercing Strike - defensive, type=defensive, spellId=438218
	[Special Warning] Cataclysmic Entropy! (%s), type=count, spellId=438355
	[Special Warning] Stinging Swarm - move to >%s<, type=moveto, spellId=438677
	[Special Warning] Binding Webs on you, type=you, spellId=440001
	[Special Warning] Web Vortex! (%s), type=count, spellId=441626
	[Special Warning] Strands of Reality (%s) - dodge attack, type=dodgecount, spellId=441782
	[Special Warning] Swarm! (%s), type=count, spellId=442994
	[Special Warning] Spikes (%s) - dodge attack, type=dodgecount, spellId=443068
	[Special Warning] Uncontrollable Rage on >%s< - dispel now, type=dispel, spellId=443598
	[Special Warning] Mark of Rage on you, type=you, spellId=455850
	[Timer] Massive Explosion (%s), time=49.00, type=cdcount, spellId=438355
	[Timer] Dispels (%s), time=49.00, type=cdcount, spellId=438677
	[Timer] Web Vortex (%s), time=49.00, type=cdcount, spellId=441626
	[Timer] Frontal [S] (%s), time=49.00, type=cdcount, spellId=441782
	[Timer] Swarm (%s), time=49.00, type=cdcount, spellId=442994
	[Timer] Spikes (%s), time=49.00, type=cdcount, spellId=443068
	[Timer] Run away! (%s), time=49.00, type=cdcount, spellId=450129
	[Timer] Teleport (%s), time=49.00, type=cdcount, spellId=450483
	[Timer] Intermission %s, time=100.00, type=intermissioncount, spellId=451327
	[Yell] Stinging Swarm, type=shortyell, spellId=438677
	[Yell] Impaled, type=shortyell, spellId=449857

Timers:
	Piercing Strike (%s), time=49.00, type=cdcount, spellId=438218, triggerDeltas = 0.00, 15.02, 23.02, 24.98
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[15.02] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
			 Triggered 3x, delta times: 15.02, 23.02, 24.98
	Rain (%s), time=49.00, type=cdcount, spellId=438656, triggerDeltas = 0.00, 15.25, 41.90
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[15.25] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
			 Triggered 2x, delta times: 15.25, 41.90
	Adds (%s), time=49.00, type=cdcount, spellId=438801, triggerDeltas = 0.00, 23.01
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[23.01] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
	Web Bomb (%s), time=49.00, type=cdcount, spellId=439838, triggerDeltas = 0.00, 31.37, 32.85
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[31.37] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
			 Triggered 2x, delta times: 31.37, 32.85
	Charge (%s), time=49.00, type=cdcount, spellId=440246, triggerDeltas = 0.00, 42.95
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[42.95] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
	Frontal [A] (%s), time=49.00, type=cdcount, spellId=440504, triggerDeltas = 0.00, 8.02, 24.00, 25.01
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[ 8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 3x, delta times: 8.02, 24.00, 25.01
	Burrow (%s), time=49.00, type=cdcount, spellId=441791, triggerDeltas = 40.04
		[40.04] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
	Leap (%s), time=49.00, type=cdcount, spellId=450045, triggerDeltas = 0.00, 19.23, 27.48
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		[19.23] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
			 Triggered 2x, delta times: 19.23, 27.48
	Intermission %s, time=100.00, type=intermissioncount, spellId=450483, triggerDeltas = 0.00
		[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0

Announces:
	Poison Bolt on >%s< (%d), type=stack, spellId=438200, triggerDeltas = 54.20
		[54.20] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Tank1: Poison Bolt] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000010, Tank1, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
	Piercing Strike on >%s< (%d), type=stack, spellId=438218, triggerDeltas = 16.53, 23.02, 24.98
		[16.53] SPELL_AURA_APPLIED: [Anub'arash->Tank3: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000019, Tank3, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		[39.55] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank3: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000019, Tank3, 0x512, 438218, Piercing Strike, 0, DEBUFF, 2, 0
			 Triggered 2x, delta times: 39.55, 24.98
	Rain (%s), type=count, spellId=438656, triggerDeltas = 15.25, 41.90
		[15.25] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
			 Triggered 2x, delta times: 15.25, 41.90
	Call of the Swarm (%s), type=count, spellId=438801, triggerDeltas = 23.01, 50.01
		[23.01] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
			 Triggered 2x, delta times: 23.01, 50.01
	Web Bomb (%s), type=count, spellId=439838, triggerDeltas = 31.37, 32.85
		[31.37] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
			 Triggered 2x, delta times: 31.37, 32.85
	Burrow (%s), type=count, spellId=441791, triggerDeltas = 40.04
		[40.04] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
	Impaled on >%s<, type=target, spellId=449857, triggerDeltas = 62.54
		[62.54] Scheduled at 61.04 by SPELL_AURA_APPLIED: [->Dps11: Impaled] "", nil, 0x0, Player-1-00000015, Dps11, 0x512, 449857, Impaled, 0, DEBUFF, 0
	Leap (%s), type=count, spellId=450045, triggerDeltas = 19.23, 27.48
		[19.23] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
			 Triggered 2x, delta times: 19.23, 27.48

Special warnings:
	Rain on you, type=you, spellId=438656, triggerDeltas = 20.29
		[20.29] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank1: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000010, Tank1, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0
	Charge! (%s), type=count, spellId=440246, triggerDeltas = 42.95
		[42.95] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
	Impaling Eruption (%s) - dodge attack, type=dodgecount, spellId=440504, triggerDeltas = 8.02, 24.00, 25.01, 23.01
		[ 8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 4x, delta times: 8.02, 24.00, 25.01, 23.01
	Mark of Paranoia on you, type=you, spellId=455849, triggerDeltas = 1.72
		[ 1.72] SPELL_AURA_APPLIED: [->Tank1: Mark of Paranoia] "", nil, 0x0, Player-1-00000010, Tank1, 0x511, 455849, Mark of Paranoia, 0, DEBUFF, 0

Yells:
	None

Voice pack sounds:
	VoicePack/chargemove
		[42.95] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
	VoicePack/paranoiayou
		[ 1.72] SPELL_AURA_APPLIED: [->Tank1: Mark of Paranoia] "", nil, 0x0, Player-1-00000010, Tank1, 0x511, 455849, Mark of Paranoia, 0, DEBUFF, 0
	VoicePack/shockwave
		[ 8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
			 Triggered 4x, delta times: 8.02, 24.00, 25.01, 23.01
	VoicePack/targetyou
		[20.29] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank1: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000010, Tank1, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0

Icons:
	Icon 6, target=Creature-0-1-2657-1-218884-0000000043, scanMethod=nil
		[26.04] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000043, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 6, target=Creature-0-1-2657-1-218884-0000000046, scanMethod=nil
		[76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000046, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-000000003A, scanMethod=nil
		[26.04] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000003A, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 7, target=Creature-0-1-2657-1-218884-000000003F, scanMethod=nil
		[76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000003F, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-0000000018, scanMethod=nil
		[26.04] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000018, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
	Icon 8, target=Creature-0-1-2657-1-218884-0000000034, scanMethod=nil
		[76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000034, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0

Event trace:
	[ 0.00] ENCOUNTER_START: 2921, The Silken Court, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 438218 438801 440246 440504 438343 439838 450045 451016 438677 452231 441626 450129 441782 450483 438355 443068 451327 442994 441791, SPELL_SUMMON 438249, SPELL_AURA_APPLIED 455849 455850 438218 455080 449857 440001 450980 438708 456252 450728 451277 443598 438656 440179 456245 438200 456235, SPELL_AURA_APPLIED_DOSE 438218 438200, SPELL_AURA_REMOVED 455080 450980 451277 440001
		StartTimer: 15.0, Piercing Strike (1)
		StartTimer: 23.0, Adds (1)
		StartTimer: 8.0, Frontal [A] (1)
		StartTimer: 43.0, Charge (1)
		StartTimer: 15.2, Rain (1)
		StartTimer: 19.3, Leap (1)
		StartTimer: 31.4, Web Bomb (1)
		StartTimer: 100.0, Intermission 1.5
	[ 1.72] SPELL_AURA_APPLIED: [->Tank1: Mark of Paranoia] "", nil, 0x0, Player-1-00000010, Tank1, 0x511, 455849, Mark of Paranoia, 0, DEBUFF, 0
		ShowSpecialWarning: Mark of Paranoia on you
		PlaySound: VoicePack/paranoiayou
	[ 8.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (1) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 24.0, Frontal [A] (2)
	[15.02] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 23.0, Piercing Strike (2)
	[15.25] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowAnnounce: Rain (1)
		StartTimer: 41.9, Rain (2)
	[16.53] SPELL_AURA_APPLIED: [Anub'arash->Tank3: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000019, Tank3, 0x512, 438218, Piercing Strike, 0, DEBUFF, 0
		ShowAnnounce: Piercing Strike on Tank3 (1)
	[19.23] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
		ShowAnnounce: Leap (1)
		StartTimer: 27.3, Leap (2)
	[20.29] SPELL_AURA_APPLIED: [Skeinspinner Takazj->Tank1: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000010, Tank1, 0x511, 438656, Venomous Rain, 0, DEBUFF, 0
		ShowSpecialWarning: Rain on you
		PlaySound: VoicePack/targetyou
	[23.01] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Call of the Swarm (1)
		StartTimer: 50.0, Adds (2)
	[26.04] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000018, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000018, 2, 8, 1
	[26.04] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000003A, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-000000003A, 2, 7, 1
	[26.04] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000043, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000043, 2, 6, 1
	[31.37] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
		ShowAnnounce: Web Bomb (1)
		StartTimer: 32.9, Web Bomb (2)
	[32.02] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (2) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 25.0, Frontal [A] (3)
	[38.04] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 25.0, Piercing Strike (3)
	[39.55] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank3: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000019, Tank3, 0x512, 438218, Piercing Strike, 0, DEBUFF, 2, 0
		ShowAnnounce: Piercing Strike on Tank3 (2)
	[40.04] SPELL_CAST_START: [Anub'arash: Burrowed Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 441791, Burrowed Eruption, 0, 0
		ShowAnnounce: Burrow (1)
		StartTimer: 59.9, Burrow (2)
	[42.95] SPELL_CAST_START: [Anub'arash: Reckless Charge] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440246, Reckless Charge, 0, 0
		ShowSpecialWarning: Charge! (1)
		PlaySound: VoicePack/chargemove
		PlaySound: VoicePack/chargemove
		StartTimer: 59.9, Charge (2)
	[46.71] SPELL_CAST_START: [Skeinspinner Takazj: Skittering Leap] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 450045, Skittering Leap, 0, 0
		ShowAnnounce: Leap (2)
		StartTimer: 61.1, Leap (3)
	[54.20] SPELL_AURA_APPLIED_DOSE: [Skeinspinner Takazj->Tank1: Poison Bolt] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, Player-1-00000010, Tank1, 0x511, 438200, Poison Bolt, 0, DEBUFF, 6, 0
		ShowAnnounce: Poison Bolt on PlayerName (6)
	[57.03] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (3) - dodge attack
		PlaySound: VoicePack/shockwave
		StartTimer: 23.0, Frontal [A] (4)
	[57.15] SPELL_CAST_START: [Skeinspinner Takazj: Venomous Rain] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 438343, Venomous Rain, 0, 0
		ShowAnnounce: Rain (2)
		StartTimer: 33.2, Rain (3)
	[61.04] SPELL_AURA_APPLIED: [->Dps11: Impaled] "", nil, 0x0, Player-1-00000015, Dps11, 0x512, 449857, Impaled, 0, DEBUFF, 0
		ScheduleTask: announce449857target:CombinedShow("Dps11") at 62.54 (+1.50)
			ShowAnnounce: Impaled on Dps11
	[63.02] SPELL_CAST_START: [Anub'arash: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438218, Piercing Strike, 0, 0
		StartTimer: 24.0, Piercing Strike (4)
	[64.22] SPELL_CAST_START: [Skeinspinner Takazj: Web Bomb] Creature-0-1-2657-1-217491-0000000002, Skeinspinner Takazj, 0xa48, "", nil, 0x0, 439838, Web Bomb, 0, 0
		ShowAnnounce: Web Bomb (2)
		StartTimer: 28.1, Web Bomb (3)
	[64.53] SPELL_AURA_APPLIED_DOSE: [Anub'arash->Tank3: Piercing Strike] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Player-1-00000019, Tank3, 0x512, 438218, Piercing Strike, 0, DEBUFF, 3, 0
		ShowAnnounce: Piercing Strike on Tank3 (3)
	[73.02] SPELL_CAST_START: [Anub'arash: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 438801, Call of the Swarm, 0, 0
		ShowAnnounce: Call of the Swarm (2)
	[76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000034, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000034, 2, 8, 1
	[76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-000000003F, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-000000003F, 2, 7, 1
	[76.03] SPELL_SUMMON: [Anub'arash->Shattershell Scarab: Call of the Swarm] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, Creature-0-1-2657-1-218884-0000000046, Shattershell Scarab, 0xa48, 438249, Call of the Swarm, 0, 0
		ScanForMobs: Creature-0-1-2657-1-218884-0000000046, 2, 6, 1
	[80.04] SPELL_CAST_START: [Anub'arash: Impaling Eruption] Vehicle-0-1-2657-1-217489-0000000002, Anub'arash, 0xa48, "", nil, 0x0, 440504, Impaling Eruption, 0, 0
		ShowSpecialWarning: Impaling Eruption (4) - dodge attack
		PlaySound: VoicePack/shockwave
	[81.69] ENCOUNTER_END: 2921, The Silken Court, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 455080 450980 451277 440001
]]
