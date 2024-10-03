DBM.Test:Report[[
Test: TWW/NerubarPalace/QueenAnsurek/Mythic/Wipe
Mod:  DBM-Raids-WarWithin/2602

Findings:
	Unused event registration: SPELL_AURA_APPLIED 440885 (Liquefy)
	Unused event registration: SPELL_AURA_APPLIED 441556 (Reaction Vapor)
	Unused event registration: SPELL_AURA_APPLIED 443342 (Gorge)
	Unused event registration: SPELL_AURA_APPLIED 447207 (Predation)
	Unused event registration: SPELL_AURA_APPLIED 447967 (Gloom Touch)
	Unused event registration: SPELL_AURA_APPLIED 453990 (Echoing Connection)
	Unused event registration: SPELL_AURA_APPLIED 462558 (Cosmic Rupture)
	Unused event registration: SPELL_AURA_APPLIED 462693 (Echoing Connection)
	Unused event registration: SPELL_AURA_APPLIED 464056 (Gloom Touch)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 441556 (Reaction Vapor)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 443342 (Gorge)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 443726 (Gloom Hatchling)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 449236 (Caustic Fangs)
	Unused event registration: SPELL_AURA_REMOVED 437586 (Reactive Toxin)
	Unused event registration: SPELL_AURA_REMOVED 443656 (Infest)
	Unused event registration: SPELL_AURA_REMOVED 443903 (Abyssal Infusion)
	Unused event registration: SPELL_AURA_REMOVED 445013 (Dark Barrier)
	Unused event registration: SPELL_AURA_REMOVED 445021 (Null Detonation)
	Unused event registration: SPELL_AURA_REMOVED 445152 (Acolyte's Essence)
	Unused event registration: SPELL_AURA_REMOVED 447967 (Gloom Touch)
	Unused event registration: SPELL_AURA_REMOVED 451278 (Concentrated Toxin)
	Unused event registration: SPELL_AURA_REMOVED 453990 (Echoing Connection)
	Unused event registration: SPELL_AURA_REMOVED 455387 (Abyssal Reverberation)
	Unused event registration: SPELL_AURA_REMOVED 462558 (Cosmic Rupture)
	Unused event registration: SPELL_AURA_REMOVED 464056 (Gloom Touch)
	Unused event registration: SPELL_CAST_START 437093 (Feast)
	Unused event registration: SPELL_CAST_START 440883 (Liquefy)
	Unused event registration: SPELL_CAST_START 456623 (Reactive Toxin)
	Unused event registration: SPELL_CAST_SUCCESS 449986 (Aphotic Communion)
	Unused event registration: SPELL_PERIODIC_DAMAGE 443403 (Gloom)
	Unused event registration: SPELL_PERIODIC_MISSED 443403 (Gloom)
	Timer for spell ID 438976 (Royal Condemnation) is triggered by event SPELL_CAST_START 449986 (Aphotic Communion)
	Timer for spell ID 439299 (Web Blades) is triggered by event SPELL_CAST_START 449986 (Aphotic Communion)
	SpecialWarning for spell ID 440899 (Liquefy) is triggered by event SPELL_AURA_APPLIED 436800 (Liquefy)
	SpecialWarning for spell ID 443325 (Infest) is triggered by event SPELL_AURA_APPLIED 443656 (Infest)
	Timer for spell ID 443325 (Infest) is triggered by event SPELL_CAST_START 449986 (Aphotic Communion)
	Timer for spell ID 443336 (Gorge) is triggered by event SPELL_CAST_START 449986 (Aphotic Communion)
	Announce for spell ID 443888 (Abyssal Infusion) is triggered by event SPELL_AURA_APPLIED 443903 (Abyssal Infusion)
	Timer for spell ID 443888 (Abyssal Infusion) is triggered by event SPELL_CAST_START 449986 (Aphotic Communion)
	Timer for spell ID 444829 (Queen's Summons) is triggered by event SPELL_CAST_START 449986 (Aphotic Communion)
	Timer for spell ID 445422 (Frothing Gluttony) is triggered by event SPELL_CAST_START 449986 (Aphotic Communion)
	SpecialWarning for spell ID 447411 (Wrest) is triggered by event SPELL_CAST_START 450191 (Wrest)
	Timer for spell ID 447411 (Wrest) is triggered by event SPELL_CAST_START 447076 (Predation)
	Timer for spell ID 447411 (Wrest) is triggered by event SPELL_CAST_START 450191 (Wrest)
	Timer for spell ID 447456 (Paralyzing Venom) is triggered by event SPELL_CAST_START 447076 (Predation)

Unused objects:
	[Announce] Reaction Vapor (%s), type=count, spellId=441556
	[Announce] Gorge on >%s< (%d), type=stack, spellId=443342
	[Announce] Caustic Fangs on >%s< (%d), type=stack, spellId=449236
	[Special Warning] Feast - defensive, type=defensive, spellId=437093
	[Special Warning] Reactive Toxin - move away from others, type=moveaway, spellId=437592
	[Special Warning] Reactive Toxin - move to >%s<, type=moveto, spellId=437592
	[Special Warning] Shackles (Position: %s) on you, type=youpos, spellId=438976
	[Special Warning] Liquefy - defensive, type=defensive, spellId=440899
	[Special Warning] Infest - move away from others, type=moveaway, spellId=443325
	[Special Warning] Gorge - defensive, type=defensive, spellId=443336
	[Special Warning] Portal (Position: %s) on you, type=youpos, spellId=443888
	[Special Warning] Gloom Touch - move away from others, type=moveaway, spellId=447967
	[Special Warning] Oust - defensive, type=defensive, spellId=448147
	[Special Warning] %d stacks of Caustic Fangs on you, type=stack, spellId=449236
	[Special Warning] Cosmic Rupture on you, type=you, spellId=462558
	[Yell] {rt%2$d}%1$d, type=iconfade, spellId=437592
	[Yell] {rt%1$d}Reactive Toxin, type=shortposition, spellId=437592
	[Yell] {rt%1$d}Shackles, type=shortposition, spellId=438976
	[Yell] %d, type=shortfade, spellId=443325
	[Yell] Infest, type=shortyell, spellId=443325
	[Yell] {rt%2$d}%1$d, type=iconfade, spellId=443888
	[Yell] {rt%1$d}Portal, type=shortposition, spellId=443888
	[Yell] %d, type=shortfade, spellId=445152
	[Yell] %d, type=shortfade, spellId=447967
	[Yell] Gloom Touch, type=shortyell, spellId=447967
	[Yell] %d, type=shortfade, spellId=451278
	[Yell] %d, type=shortfade, spellId=455387
	[Yell] %d, type=shortfade, spellId=462558

Timers:
	Nova (%s), time=49.00, type=cdcount, spellId=437417, triggerDeltas = 0.00, 29.38, 55.99
		[  0.00] ENCOUNTER_START: 2922, Queen Ansurek, 16, 20, 0
		[ 29.38] SPELL_CAST_START: [Queen Ansurek: Venom Nova] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437417, Venom Nova, 0, 0
			 Triggered 2x, delta times: 29.38, 55.99
	Reactive Toxin (%s), time=49.00, type=cdcount, spellId=437592, triggerDeltas = 0.00, 19.36, 56.06
		[  0.00] ENCOUNTER_START: 2922, Queen Ansurek, 16, 20, 0
		[ 19.36] SPELL_CAST_START: [Queen Ansurek: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437592, Reactive Toxin, 0, 0
			 Triggered 2x, delta times: 19.36, 56.06
	Shackles (%s), time=49.00, type=cdcount, spellId=438976, triggerDeltas = 315.47, 116.73, 52.01
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		[432.20] SPELL_CAST_START: [Queen Ansurek: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 438976, Royal Condemnation, 0, 0
			 Triggered 2x, delta times: 432.20, 52.01
	Blades (%s), time=49.00, type=cdcount, spellId=439299, triggerDeltas = 0.00, 20.41, 39.98, 13.02, 25.02, 15.95, 201.09, 49.21, 10.99, 26.01, 21.00, 17.02, 15.98, 46.99, 19.00, 13.99
		[  0.00] ENCOUNTER_START: 2922, Queen Ansurek, 16, 20, 0
		[ 20.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps6: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000006, Dps6, 0x512, 439299, Web Blades, 0, 0
		[ 60.39] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps10: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000010, Dps10, 0x512, 439299, Web Blades, 0, 0
		[ 73.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps16: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000016, Dps16, 0x512, 439299, Web Blades, 0, 0
		[ 98.43] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps11: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000011, Dps11, 0x512, 439299, Web Blades, 0, 0
			 Triggered 2x, delta times: 98.43, 15.95
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		[364.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps8: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000008, Dps8, 0x512, 439299, Web Blades, 0, 0
		[375.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps18: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 439299, Web Blades, 0, 0
		[401.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps7: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000007, Dps7, 0x512, 439299, Web Blades, 0, 0
		[422.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps9: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000009, Dps9, 0x512, 439299, Web Blades, 0, 0
		[439.70] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps2: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000002, Dps2, 0x512, 439299, Web Blades, 0, 0
		[455.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps13: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000013, Dps13, 0x512, 439299, Web Blades, 0, 0
		[502.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps5: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000005, Dps5, 0x512, 439299, Web Blades, 0, 0
		[521.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Tank1: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 439299, Web Blades, 0, 0
		[535.66] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps14: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 439299, Web Blades, 0, 0
	Roots (%s), time=49.00, type=cdcount, spellId=439814, triggerDeltas = 0.00, 12.41, 40.02, 54.00
		[  0.00] ENCOUNTER_START: 2922, Queen Ansurek, 16, 20, 0
		[ 12.41] SPELL_CAST_START: [Queen Ansurek: Silken Tomb] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 439814, Silken Tomb, 0, 0
			 Triggered 3x, delta times: 12.41, 40.02, 54.00
	Tank Combo (%s), time=49.00, type=cdcount, spellId=440899, triggerDeltas = 0.00, 6.38, 39.99
		[  0.00] ENCOUNTER_START: 2922, Queen Ansurek, 16, 20, 0
		[  6.38] SPELL_CAST_START: [Queen Ansurek: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 440899, Liquefy, 0, 0
			 Triggered 2x, delta times: 6.38, 39.99
	Infest (%s), time=49.00, type=cdcount, spellId=443325, triggerDeltas = 315.47, 30.21, 66.00
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		[345.68] SPELL_CAST_START: [Queen Ansurek: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443325, Infest, 0, 0
			 Triggered 2x, delta times: 345.68, 66.00
	Pools (%s), time=49.00, type=cdcount, spellId=443336, triggerDeltas = 315.47, 32.17, 66.02
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		[347.64] SPELL_CAST_START: [Queen Ansurek: Gorge] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443336, Gorge, 0, 0
			 Triggered 2x, delta times: 347.64, 66.02
	Portals (%s), time=49.00, type=cdcount, spellId=443888, triggerDeltas = 315.47, 58.18, 80.01
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		[373.65] SPELL_CAST_START: [Queen Ansurek: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443888, Abyssal Infusion, 0, 0
			 Triggered 2x, delta times: 373.65, 80.01
	Big Adds (%s), time=49.00, type=cdcount, spellId=444829, triggerDeltas = 315.47, 44.18, 64.00
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		[359.65] SPELL_CAST_START: [Queen Ansurek: Queen's Summons] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 444829, Queen's Summons, 0, 0
			 Triggered 2x, delta times: 359.65, 64.00
	Null Detonation, time=8.20, type=cdnp, spellId=445021, triggerDeltas = 367.69, 0.14, 0.16, 5.45, 0.61, 0.80, 7.01, 49.80, 0.15, 0.14, 0.14, 6.58, 0.13, 0.16, 0.16, 5.77, 0.80, 0.13, 0.30, 5.17, 63.40, 0.14, 0.15, 0.15, 0.16, 6.41, 0.15, 0.13, 0.18, 0.13, 6.43, 0.13, 0.14, 0.16, 0.16, 3.65, 2.76, 0.13, 0.31, 0.14, 0.92, 3.03, 2.61, 0.31, 0.14, 1.68, 2.27, 2.62, 0.30, 0.15, 1.36, 2.59, 2.61, 0.31, 0.15
		[367.69] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 55x, delta times: 367.69, 0.14, 0.16, 5.45, 0.61, 0.80, 7.01, 49.80, 0.15, 0.14, 0.14, 6.58, 0.13, 0.16, 0.16, 5.77, 0.80, 0.13, 0.30, 5.17, 63.40, 0.14, 0.15, 0.15, 0.16, 6.41, 0.15, 0.13, 0.18, 0.13, 6.43, 0.13, 0.14, 0.16, 0.16, 3.65, 2.76, 0.13, 0.31, 0.14, 0.92, 3.03, 2.61, 0.31, 0.14, 1.68, 2.27, 2.62, 0.30, 0.15, 1.36, 2.59, 2.61, 0.31, 0.15
	Ring (%s), time=49.00, type=cdcount, spellId=445422, triggerDeltas = 315.47, 69.21, 79.98
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		[384.68] SPELL_CAST_START: [Queen Ansurek: Frothing Gluttony] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 445422, Frothing Gluttony, 0, 0
			 Triggered 2x, delta times: 384.68, 79.98
	Intermission %s, time=140.00, type=intermissioncount, spellId=447207, triggerDeltas = 0.00
		[  0.00] ENCOUNTER_START: 2922, Queen Ansurek, 16, 20, 0
	Pull (%s), time=49.00, type=cdcount, spellId=447411, triggerDeltas = 153.83, 6.01, 19.08, 19.01, 25.01, 11.72, 8.00, 8.00, 5.42, 5.38, 8.03, 7.98
		[153.83] SPELL_CAST_START: [Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447076, Predation, 0, 0
		[159.84] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447411, Wrest, 0, 0
			 Triggered 3x, delta times: 159.84, 19.08, 19.01
		[200.09] SPELL_AURA_REMOVED: [Queen Ansurek->Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 447207, Predation, 0, BUFF, 0, 0
		[222.94] UNIT_DIED: [->Ascended Voidspeaker] "", nil, 0x0, Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, -1, false, 0, 0
		[234.66] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
			 Triggered 6x, delta times: 234.66, 8.00, 8.00, 10.80, 8.03, 7.98
		[256.08] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-0000000321, 447208, Queen Ansurek, 63.6, 0, ??, 0
		[284.25] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-000000043B, 447208, Queen Ansurek, 63.6, 0, ??, 0
	Toxic Waves (%s), time=4.00, type=cdcount, spellId=447456, triggerDeltas = 153.83, 13.06, 4.01, 3.99, 11.05, 4.02, 3.99
		[153.83] SPELL_CAST_START: [Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447076, Predation, 0, 0
		[166.89] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
			 Triggered 6x, delta times: 166.89, 4.01, 3.99, 11.05, 4.02, 3.99
		[200.09] SPELL_AURA_REMOVED: [Queen Ansurek->Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 447207, Predation, 0, BUFF, 0, 0
	Knock Up, time=5.00, type=cast, spellId=448046, triggerDeltas = 222.94, 86.33
		[222.94] UNIT_DIED: [->Ascended Voidspeaker] "", nil, 0x0, Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, -1, false, 0, 0
			 Triggered 2x, delta times: 222.94, 86.33
	Oust, time=10.00, type=cdnp, spellId=448147, triggerDeltas = 237.12, 0.26, 9.73, 0.28, 15.71, 10.01
		[237.12] SPELL_CAST_START: [Chamber Guardian: Oust] Creature-0-1-2657-1-223204-0000000035, Chamber Guardian, 0xa48, "", nil, 0x0, 448147, Oust, 0, 0
			 Triggered 6x, delta times: 237.12, 0.26, 9.73, 0.28, 15.71, 10.01
	Cosmic Apocalypse, time=85.00, type=cast, spellId=448458, triggerDeltas = 202.57
		[202.57] SPELL_CAST_START: [Devoted Worshipper: Cosmic Apocalypse] Creature-0-1-2657-1-223318-000000002F, Devoted Worshipper, 0xa48, "", nil, 0x0, 448458, Cosmic Apocalypse, 0, 0
		[273.60] UNIT_DIED: [->Devoted Worshipper] "", nil, 0x0, Creature-0-1-2657-1-223318-000000009C, Devoted Worshipper, 0xa48, -1, false, 0, 0
	Acidic Apocalypse, time=35.00, type=cast, spellId=449940, triggerDeltas = 288.26
		[288.26] SPELL_CAST_START: [Queen Ansurek: Acidic Apocalypse] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449940, Acidic Apocalypse, 0, 0
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
	Expulsion Beam (%s), time=10.00, type=cdcount, spellId=451600, triggerDeltas = 222.94, 12.55, 9.99, 16.01, 9.99
		[222.94] UNIT_DIED: [->Ascended Voidspeaker] "", nil, 0x0, Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, -1, false, 0, 0
		[235.49] SPELL_CAST_START: [Chamber Expeller: Expulsion Beam] Creature-0-1-2657-1-224368-0000000036, Chamber Expeller, 0xa48, "", nil, 0x0, 451600, Expulsion Beam, 0, 0
			 Triggered 4x, delta times: 235.49, 9.99, 16.01, 9.99
		[250.97] UNIT_DIED: [->Chamber Expeller] "", nil, 0x0, Creature-0-1-2657-1-224368-00000000A0, Chamber Expeller, 0xa48, -1, false, 0, 0
	Gloom Touch, time=10.00, type=cd, spellId=464056, triggerDeltas = 256.08
		[256.08] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-0000000321, 447208, Queen Ansurek, 63.6, 0, ??, 0

Announces:
	%s, type=stagechange, spellId=<none>, triggerDeltas = 153.83, 46.26, 115.38
		[153.83] SPELL_CAST_START: [Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447076, Predation, 0, 0
		[200.09] SPELL_AURA_REMOVED: [Queen Ansurek->Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 447207, Predation, 0, BUFF, 0, 0
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
	Platform (%s), type=count, spellId=232537, triggerDeltas = 256.08, 28.17, 30.21
		[256.08] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-0000000321, 447208, Queen Ansurek, 63.6, 0, ??, 0
		[284.25] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-000000043B, 447208, Queen Ansurek, 63.6, 0, ??, 0
		[314.46] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-000000014A, 447208, Queen Ansurek, 63.6, 0, ??, 0
	Reactive Toxin (%s) on >%s<, type=targetcount, spellId=437592, triggerDeltas = 21.70, 56.07, 53.06
		[ 21.70] Scheduled at 21.20 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps3: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000003, Dps3, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		[ 77.77] Scheduled at 77.27 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps17: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000017, Dps17, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		[130.83] Scheduled at 130.33 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps4: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000004, Dps4, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
	Shackles on >%s<, type=target, spellId=438976, triggerDeltas = 428.70, 52.04, 33.92
		[428.70] Scheduled at 427.70 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps4: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000004, Dps4, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		[480.74] Scheduled at 479.74 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps14: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		[514.66] Scheduled at 513.66 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps13: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000013, Dps13, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
	Roots (%s), type=count, spellId=439814, triggerDeltas = 12.41, 40.02, 54.00, 25.98
		[ 12.41] SPELL_CAST_START: [Queen Ansurek: Silken Tomb] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 439814, Silken Tomb, 0, 0
			 Triggered 4x, delta times: 12.41, 40.02, 54.00, 25.98
	Gloom Hatchling on >%s< (%d), type=stack, spellId=443726, triggerDeltas = 501.09
		[501.09] SPELL_AURA_APPLIED: [Queen Ansurek->Queen Ansurek: Gloom Hatchling] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 443726, Gloom Hatchling, 0, BUFF, 0
	Portals (%s) on >%s<, type=targetcount, spellId=443888, triggerDeltas = 375.49, 0.44, 79.57, 0.43, 79.55, 0.45
		[375.49] SPELL_AURA_APPLIED: [Queen Ansurek->Dps1: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000001, Dps1, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		[375.93] Scheduled at 375.43 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps3: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000003, Dps3, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		[455.50] SPELL_AURA_APPLIED: [Queen Ansurek->Dps4: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000004, Dps4, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		[455.93] Scheduled at 455.43 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps6: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000006, Dps6, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		[535.48] SPELL_AURA_APPLIED: [Queen Ansurek->Dps14: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		[535.93] Scheduled at 535.43 by SPELL_AURA_APPLIED: [Queen Ansurek->Dps15: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000015, Dps15, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
	Big Adds (%s), type=count, spellId=444829, triggerDeltas = 359.65, 64.00, 83.01
		[359.65] SPELL_CAST_START: [Queen Ansurek: Queen's Summons] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 444829, Queen's Summons, 0, 0
			 Triggered 3x, delta times: 359.65, 64.00, 83.01
	Froth Vapor on >%s< (%d), type=stack, spellId=445880, triggerDeltas = 557.69
		[557.69] SPELL_AURA_APPLIED: [Queen Ansurek->Queen Ansurek: Froth Vapor] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 445880, Froth Vapor, 0, BUFF, 0
	Toxic Waves (%s), type=count, spellId=447456, triggerDeltas = 166.89, 4.01, 3.99, 11.05, 4.02, 3.99
		[166.89] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
			 Triggered 6x, delta times: 166.89, 4.01, 3.99, 11.05, 4.02, 3.99
	Knock Up, type=spell, spellId=448046, triggerDeltas = 222.94, 86.33
		[222.94] UNIT_DIED: [->Ascended Voidspeaker] "", nil, 0x0, Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, -1, false, 0, 0
			 Triggered 2x, delta times: 222.94, 86.33
	Casting Cosmic Apocalypse: 95.0 sec, type=cast, spellId=448458, triggerDeltas = 202.57
		[202.57] SPELL_CAST_START: [Devoted Worshipper: Cosmic Apocalypse] Creature-0-1-2657-1-223318-000000002F, Devoted Worshipper, 0xa48, "", nil, 0x0, 448458, Cosmic Apocalypse, 0, 0
	Frothy Toxin (%s), type=count, spellId=464638, triggerDeltas = 34.67, 1.50, 57.15, 55.00, 1.61, 1.48
		[ 34.67] Scheduled at 33.17 by SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 0
		[ 36.17] Scheduled at 34.67 by SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 2, 0
		[ 93.32] Scheduled at 91.82 by SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 3, 0
		[148.32] Scheduled at 146.82 by SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 2, 0
		[149.93] Scheduled at 148.43 by SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 3, 0
		[151.41] Scheduled at 149.91 by SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 4, 0

Special warnings:
	Nova! (%s), type=count, spellId=437417, triggerDeltas = 29.38, 55.99, 56.05
		[ 29.38] SPELL_CAST_START: [Queen Ansurek: Venom Nova] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437417, Venom Nova, 0, 0
			 Triggered 3x, delta times: 29.38, 55.99, 56.05
	Blades (%s) - dodge attack, type=dodgecount, spellId=439299, triggerDeltas = 20.41, 39.98, 13.02, 25.02, 15.95, 26.07, 224.23, 10.99, 26.01, 21.00, 17.02, 15.98, 46.99, 19.00, 13.99
		[ 20.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps6: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000006, Dps6, 0x512, 439299, Web Blades, 0, 0
		[ 60.39] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps10: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000010, Dps10, 0x512, 439299, Web Blades, 0, 0
		[ 73.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps16: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000016, Dps16, 0x512, 439299, Web Blades, 0, 0
		[ 98.43] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps11: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000011, Dps11, 0x512, 439299, Web Blades, 0, 0
			 Triggered 2x, delta times: 98.43, 15.95
		[140.45] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps17: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000017, Dps17, 0x512, 439299, Web Blades, 0, 0
		[364.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps8: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000008, Dps8, 0x512, 439299, Web Blades, 0, 0
		[375.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps18: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 439299, Web Blades, 0, 0
		[401.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps7: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000007, Dps7, 0x512, 439299, Web Blades, 0, 0
		[422.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps9: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000009, Dps9, 0x512, 439299, Web Blades, 0, 0
		[439.70] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps2: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000002, Dps2, 0x512, 439299, Web Blades, 0, 0
		[455.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps13: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000013, Dps13, 0x512, 439299, Web Blades, 0, 0
		[502.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps5: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000005, Dps5, 0x512, 439299, Web Blades, 0, 0
		[521.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Tank1: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 439299, Web Blades, 0, 0
		[535.66] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps14: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 439299, Web Blades, 0, 0
	Liquefy on >%s< - taunt now, type=taunt, spellId=440899, triggerDeltas = 7.90, 39.99, 54.01
		[  7.90] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 436800, Liquefy, 0, DEBUFF, 0
			 Triggered 3x, delta times: 7.90, 39.99, 54.01
	%s damage - move away, type=gtfo, spellId=441958, triggerDeltas = 17.68, 94.10, 26.04, 44.68, 67.08, 32.05
		[ 17.68] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
			 Triggered 6x, delta times: 17.68, 94.10, 26.04, 44.68, 67.08, 32.05
	Infest on >%s< - taunt now, type=taunt, spellId=443325, triggerDeltas = 347.17, 66.01, 81.98
		[347.17] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 443656, Infest, 0, DEBUFF, 0
			 Triggered 3x, delta times: 347.17, 66.01, 81.98
	Null Detonation - interrupt >%s<! (%d), type=interruptcount, spellId=445021, triggerDeltas = 367.69, 0.14, 0.16, 5.45, 0.61, 0.80, 7.01, 50.23, 6.58, 0.13, 0.16, 0.16, 5.77, 0.80, 0.13, 0.30, 5.17, 77.43, 0.13, 0.14, 0.16, 0.16, 3.65, 2.76, 0.13, 0.31, 0.14, 0.92, 3.03, 2.61, 0.31, 0.14, 1.68, 2.27, 2.62, 0.30, 0.15, 1.36, 2.59, 2.61, 0.31, 0.15
		[367.69] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 42x, delta times: 367.69, 0.14, 0.16, 5.45, 0.61, 0.80, 7.01, 50.23, 6.58, 0.13, 0.16, 0.16, 5.77, 0.80, 0.13, 0.30, 5.17, 77.43, 0.13, 0.14, 0.16, 0.16, 3.65, 2.76, 0.13, 0.31, 0.14, 0.92, 3.03, 2.61, 0.31, 0.14, 1.68, 2.27, 2.62, 0.30, 0.15, 1.36, 2.59, 2.61, 0.31, 0.15
	Acolyte's Essence - move away from others, type=moveaway, spellId=445152, triggerDeltas = 389.77, 78.60
		[389.77] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Acolyte's Essence] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 445152, Acolyte's Essence, 0, DEBUFF, 0
			 Triggered 2x, delta times: 389.77, 78.60
	Ring - run away (%s), type=runcount, spellId=445422, triggerDeltas = 384.68, 79.98, 88.01
		[384.68] SPELL_CAST_START: [Queen Ansurek: Frothing Gluttony] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 445422, Frothing Gluttony, 0, 0
			 Triggered 3x, delta times: 384.68, 79.98, 88.01
	Pull! (%s), type=count, spellId=447411, triggerDeltas = 159.84, 19.08, 19.01, 36.73, 8.00, 8.00, 10.80, 8.03, 7.98
		[159.84] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447411, Wrest, 0, 0
			 Triggered 3x, delta times: 159.84, 19.08, 19.01
		[234.66] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
			 Triggered 6x, delta times: 234.66, 8.00, 8.00, 10.80, 8.03, 7.98
	Shadowblast - interrupt >%s<! (%d), type=interruptcount, spellId=447950, triggerDeltas = 208.42, 0.36, 4.06, 0.00, 4.15, 0.58, 4.39, 70.61, 0.93, 2.93, 0.90, 2.64, 1.22, 3.73, 0.22, 3.69
		[208.42] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
			 Triggered 16x, delta times: 208.42, 0.36, 4.06, 0.00, 4.15, 0.58, 4.39, 70.61, 0.93, 2.93, 0.90, 2.64, 1.22, 3.73, 0.22, 3.69
	Bomb - move away from others, type=moveaway, spellId=451278, triggerDeltas = 145.55
		[145.55] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Concentrated Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 451278, Concentrated Toxin, 0, DEBUFF, 0
	Expulsion Beam (%s) - dodge attack, type=dodgecount, spellId=451600, triggerDeltas = 235.49, 9.99, 16.01, 9.99
		[235.49] SPELL_CAST_START: [Chamber Expeller: Expulsion Beam] Creature-0-1-2657-1-224368-0000000036, Chamber Expeller, 0xa48, "", nil, 0x0, 451600, Expulsion Beam, 0, 0
			 Triggered 4x, delta times: 235.49, 9.99, 16.01, 9.99
	Cataclysmic Evolution on >%s<, type=target, spellId=451832, triggerDeltas = 557.76
		[557.76] SPELL_AURA_APPLIED: [Queen Ansurek->Queen Ansurek: Cataclysmic Evolution] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 451832, Cataclysmic Evolution, 0, BUFF, 0
	Dark Detonation - interrupt >%s<! (%d), type=interruptcount, spellId=455374, triggerDeltas = 261.61, 0.16, 7.85, 2.18, 5.86
		[261.61] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-000000003D, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
			 Triggered 5x, delta times: 261.61, 0.16, 7.85, 2.18, 5.86
	Bomb - move away from others, type=moveaway, spellId=455387, triggerDeltas = 476.24
		[476.24] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Abyssal Reverberation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 455387, Abyssal Reverberation, 0, DEBUFF, 0

Yells:
	Bomb, type=shortyell, spellId=451278
		[145.55] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Concentrated Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 451278, Concentrated Toxin, 0, DEBUFF, 0
	Bomb, type=shortyell, spellId=455387
		[476.24] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Abyssal Reverberation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 455387, Abyssal Reverberation, 0, DEBUFF, 0

Voice pack sounds:
	VoicePack/farfromline
		[235.49] SPELL_CAST_START: [Chamber Expeller: Expulsion Beam] Creature-0-1-2657-1-224368-0000000036, Chamber Expeller, 0xa48, "", nil, 0x0, 451600, Expulsion Beam, 0, 0
			 Triggered 4x, delta times: 235.49, 9.99, 16.01, 9.99
	VoicePack/getknockedup
		[ 29.38] SPELL_CAST_START: [Queen Ansurek: Venom Nova] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437417, Venom Nova, 0, 0
			 Triggered 3x, delta times: 29.38, 55.99, 56.05
		[222.94] UNIT_DIED: [->Ascended Voidspeaker] "", nil, 0x0, Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, -1, false, 0, 0
			 Triggered 2x, delta times: 222.94, 86.33
	VoicePack/kick1r
		[208.42] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
			 Triggered 4x, delta times: 208.42, 0.36, 83.79, 0.93
		[261.61] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-000000003D, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
			 Triggered 2x, delta times: 261.61, 0.16
		[367.69] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 4x, delta times: 367.69, 0.14, 0.16, 64.10
	VoicePack/kick2r
		[212.84] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000032, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
			 Triggered 4x, delta times: 212.84, 0.00, 83.59, 0.90
		[269.62] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-000000003D, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
			 Triggered 2x, delta times: 269.62, 2.18
		[373.44] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 7x, delta times: 373.44, 0.61, 0.80, 63.82, 0.13, 0.16, 0.16
	VoicePack/kick3r
		[216.99] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000032, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
			 Triggered 4x, delta times: 216.99, 0.58, 82.40, 1.22
		[277.66] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-000000003D, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
		[381.86] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 10x, delta times: 381.86, 63.03, 0.80, 0.13, 0.30, 82.60, 0.13, 0.14, 0.16, 0.16
	VoicePack/kick4r
		[221.96] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
			 Triggered 3x, delta times: 221.96, 82.96, 0.22
		[451.29] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 6x, delta times: 451.29, 81.67, 2.76, 0.13, 0.31, 0.14
	VoicePack/kick5r
		[308.83] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-000000004A, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		[537.22] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 5x, delta times: 537.22, 3.03, 2.61, 0.31, 0.14
	VoicePack/kickcast
		[544.99] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
			 Triggered 10x, delta times: 544.99, 2.27, 2.62, 0.30, 0.15, 1.36, 2.59, 2.61, 0.31, 0.15
	VoicePack/phasechange
		[153.83] SPELL_CAST_START: [Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447076, Predation, 0, 0
	VoicePack/pthree
		[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
	VoicePack/ptwo
		[200.09] SPELL_AURA_REMOVED: [Queen Ansurek->Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 447207, Predation, 0, BUFF, 0, 0
	VoicePack/pullin
		[159.84] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447411, Wrest, 0, 0
			 Triggered 3x, delta times: 159.84, 19.08, 19.01
		[234.66] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
			 Triggered 6x, delta times: 234.66, 8.00, 8.00, 10.80, 8.03, 7.98
		[384.68] SPELL_CAST_START: [Queen Ansurek: Frothing Gluttony] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 445422, Frothing Gluttony, 0, 0
			 Triggered 3x, delta times: 384.68, 79.98, 88.01
	VoicePack/runout
		[145.55] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Concentrated Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 451278, Concentrated Toxin, 0, DEBUFF, 0
		[476.24] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Abyssal Reverberation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 455387, Abyssal Reverberation, 0, DEBUFF, 0
	VoicePack/stilldanger
		[557.76] SPELL_AURA_APPLIED: [Queen Ansurek->Queen Ansurek: Cataclysmic Evolution] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 451832, Cataclysmic Evolution, 0, BUFF, 0
	VoicePack/targetyou
		[389.77] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Acolyte's Essence] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 445152, Acolyte's Essence, 0, DEBUFF, 0
			 Triggered 2x, delta times: 389.77, 78.60
	VoicePack/tauntboss
		[  7.90] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 436800, Liquefy, 0, DEBUFF, 0
			 Triggered 3x, delta times: 7.90, 39.99, 54.01
		[347.17] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 443656, Infest, 0, DEBUFF, 0
			 Triggered 3x, delta times: 347.17, 66.01, 81.98
	VoicePack/watchfeet
		[ 17.68] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
			 Triggered 6x, delta times: 17.68, 94.10, 26.04, 44.68, 67.08, 32.05
	VoicePack/watchstep
		[ 20.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps6: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000006, Dps6, 0x512, 439299, Web Blades, 0, 0
		[ 60.39] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps10: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000010, Dps10, 0x512, 439299, Web Blades, 0, 0
		[ 73.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps16: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000016, Dps16, 0x512, 439299, Web Blades, 0, 0
		[ 98.43] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps11: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000011, Dps11, 0x512, 439299, Web Blades, 0, 0
			 Triggered 2x, delta times: 98.43, 15.95
		[140.45] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps17: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000017, Dps17, 0x512, 439299, Web Blades, 0, 0
		[364.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps8: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000008, Dps8, 0x512, 439299, Web Blades, 0, 0
		[375.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps18: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 439299, Web Blades, 0, 0
		[401.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps7: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000007, Dps7, 0x512, 439299, Web Blades, 0, 0
		[422.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps9: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000009, Dps9, 0x512, 439299, Web Blades, 0, 0
		[439.70] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps2: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000002, Dps2, 0x512, 439299, Web Blades, 0, 0
		[455.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps13: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000013, Dps13, 0x512, 439299, Web Blades, 0, 0
		[502.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps5: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000005, Dps5, 0x512, 439299, Web Blades, 0, 0
		[521.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Tank1: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 439299, Web Blades, 0, 0
		[535.66] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps14: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 439299, Web Blades, 0, 0

Icons:
	Icon 1, target=Creature-0-1-2657-1-221863-0000000100, scanMethod=nil
		[428.10] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000100, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000100, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 1, target=Creature-0-1-2657-1-221863-0000000102, scanMethod=nil
		[511.12] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 2, target=Creature-0-1-2657-1-221863-0000000114, scanMethod=nil
		[511.28] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 4, target=Creature-0-1-2657-1-221863-00000000E1, scanMethod=nil
		[363.98] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000E1, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000E1, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 4, target=Creature-0-1-2657-1-221863-00000000E8, scanMethod=nil
		[427.95] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000E8, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000E8, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 4, target=Creature-0-1-2657-1-221863-00000000EF, scanMethod=nil
		[510.97] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 5, target=Creature-0-1-2657-1-221863-00000000AF, scanMethod=nil
		[363.84] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 5, target=Creature-0-1-2657-1-221863-00000000B6, scanMethod=nil
		[427.80] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000B6, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000B6, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 5, target=Creature-0-1-2657-1-221863-00000000BE, scanMethod=nil
		[510.83] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 8, target=Creature-0-1-2657-1-221863-000000005E, scanMethod=nil
		[363.70] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 8, target=Creature-0-1-2657-1-221863-0000000071, scanMethod=nil
		[427.66] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
	Icon 8, target=Creature-0-1-2657-1-221863-0000000088, scanMethod=nil
		[510.69] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0

Event trace:
	[  0.00] ENCOUNTER_START: 2922, Queen Ansurek, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 437592 456623 437417 439814 440899 440883 437093 447076 447411 450191 449940 449986 447950 448458 448147 451600 455374 443888 445422 444829 445021 438976 443325 443336 447456, SPELL_CAST_SUCCESS 439299 449986, SPELL_AURA_APPLIED 437586 441958 436800 440885 447207 453990 464056 447967 462558 451278 443903 455387 445880 445152 438974 443656 443726 443342 451832 464638 441556 445013 462693, SPELL_AURA_APPLIED_DOSE 449236 445880 443726 443342 464638 441556, SPELL_AURA_REMOVED 437586 447207 453990 462558 451278 443903 455387 445152 443656 445013 445021 464056 447967, SPELL_PERIODIC_DAMAGE 443403, SPELL_PERIODIC_MISSED 443403, UNIT_DIED, UNIT_SPELLCAST_SUCCEEDED boss1
		StartTimer: 19.1, Reactive Toxin (1)
		StartTimer: 29.3, Nova (1)
		StartTimer: 12.4, Roots (1)
		StartTimer: 6.4, Tank Combo (1)
		StartTimer: 20.4, Blades (1)
		StartTimer: 153.0, Intermission 1
	[  6.38] SPELL_CAST_START: [Queen Ansurek: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 440899, Liquefy, 0, 0
		StartTimer: 40.0, Tank Combo (2)
	[  7.90] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 436800, Liquefy, 0, DEBUFF, 0
		ShowSpecialWarning: Liquefy on Dps18 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 12.41] SPELL_CAST_START: [Queen Ansurek: Silken Tomb] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 439814, Silken Tomb, 0, 0
		ShowAnnounce: Roots (1)
		StartTimer: 40.0, Roots (2)
	[ 17.68] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
		AntiSpam: 4
		ShowSpecialWarning: Grasping Silk damage - move away
		PlaySound: VoicePack/watchfeet
	[ 19.36] SPELL_CAST_START: [Queen Ansurek: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437592, Reactive Toxin, 0, 0
		StartTimer: 55.8, Reactive Toxin (2)
	[ 20.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps6: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000006, Dps6, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 20.9, 21.39, 21.91
		ShowSpecialWarning: Blades (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 40.0, Blades (2)
	[ 21.16] SPELL_AURA_APPLIED: [Queen Ansurek->Dps14: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 21.66 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 21.20
	[ 21.20] SPELL_AURA_APPLIED: [Queen Ansurek->Dps3: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000003, Dps3, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 21.16
		ScheduleTask: (anonymous function) at 21.70 (+0.50)
			ShowAnnounce: Reactive Toxin (2) on Dps14, Dps3
	[ 29.38] SPELL_CAST_START: [Queen Ansurek: Venom Nova] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437417, Venom Nova, 0, 0
		ShowSpecialWarning: Nova! (1)
		PlaySound: VoicePack/getknockedup
		StartTimer: 56.0, Nova (2)
	[ 33.17] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 0
		ScheduleTask: announce464638count:Schedule(1.0) at 34.67 (+1.50)
			ShowAnnounce: Frothy Toxin (1)
	[ 34.67] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 2, 0
		ScheduleTask: announce464638count:Schedule(2.0) at 36.17 (+1.50)
			ShowAnnounce: Frothy Toxin (2)
	[ 46.37] SPELL_CAST_START: [Queen Ansurek: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 440899, Liquefy, 0, 0
		StartTimer: 54.0, Tank Combo (3)
	[ 47.89] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 436800, Liquefy, 0, DEBUFF, 0
		ShowSpecialWarning: Liquefy on Dps18 - taunt now
		PlaySound: VoicePack/tauntboss
	[ 52.43] SPELL_CAST_START: [Queen Ansurek: Silken Tomb] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 439814, Silken Tomb, 0, 0
		ShowAnnounce: Roots (2)
		StartTimer: 54.0, Roots (3)
	[ 60.39] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps10: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000010, Dps10, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 60.89, 61.38, 61.89
		ShowSpecialWarning: Blades (2) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 13.0, Blades (3)
	[ 73.41] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps16: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000016, Dps16, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 73.92, 74.42, 74.91
		ShowSpecialWarning: Blades (3) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 25.0, Blades (4)
	[ 75.42] SPELL_CAST_START: [Queen Ansurek: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437592, Reactive Toxin, 0, 0
		StartTimer: 55.8, Reactive Toxin (3)
	[ 77.15] SPELL_AURA_APPLIED: [Queen Ansurek->Dps1: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000001, Dps1, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 77.65 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 77.20
	[ 77.20] SPELL_AURA_APPLIED: [Queen Ansurek->Dps6: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000006, Dps6, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 77.15
		ScheduleTask: (anonymous function) at 77.70 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 77.27
	[ 77.27] SPELL_AURA_APPLIED: [Queen Ansurek->Dps17: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000017, Dps17, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 77.20
		ScheduleTask: (anonymous function) at 77.77 (+0.50)
			ShowAnnounce: Reactive Toxin (3) on Dps1, Dps6, Dps17
	[ 85.37] SPELL_CAST_START: [Queen Ansurek: Venom Nova] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437417, Venom Nova, 0, 0
		ShowSpecialWarning: Nova! (2)
		PlaySound: VoicePack/getknockedup
		StartTimer: 56.0, Nova (3)
	[ 89.08] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 0
		ScheduleTask: announce464638count:Schedule(1.0) at 90.58 (+1.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 90.35
	[ 90.35] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 2, 0
		UnscheduleTask: announce464638count:Schedule(1.0) scheduled by ScheduleTask at 89.08
		ScheduleTask: announce464638count:Schedule(2.0) at 91.85 (+1.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 91.82
	[ 91.82] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 3, 0
		UnscheduleTask: announce464638count:Schedule(2.0) scheduled by ScheduleTask at 90.35
		ScheduleTask: announce464638count:Schedule(3.0) at 93.32 (+1.50)
			ShowAnnounce: Frothy Toxin (3)
	[ 98.43] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps11: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000011, Dps11, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 98.92, 99.41, 99.91
		ShowSpecialWarning: Blades (4) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 16.0, Blades (5)
	[101.90] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Liquefy] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 436800, Liquefy, 0, DEBUFF, 0
		ShowSpecialWarning: Liquefy on Dps18 - taunt now
		PlaySound: VoicePack/tauntboss
	[106.43] SPELL_CAST_START: [Queen Ansurek: Silken Tomb] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 439814, Silken Tomb, 0, 0
		ShowAnnounce: Roots (3)
		StartTimer: 26.0, Roots (4)
	[111.78] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
		AntiSpam: 4
		ShowSpecialWarning: Grasping Silk damage - move away
		PlaySound: VoicePack/watchfeet
	[114.38] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps11: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000011, Dps11, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 114.89, 115.39, 115.9
		ShowSpecialWarning: Blades (5) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 26.0, Blades (6)
	[130.17] SPELL_AURA_APPLIED: [Queen Ansurek->Dps7: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000007, Dps7, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 130.67 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 130.25
	[130.25] SPELL_AURA_APPLIED: [Queen Ansurek->Dps2: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000002, Dps2, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 130.17
		ScheduleTask: (anonymous function) at 130.75 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 130.31
	[130.31] SPELL_AURA_APPLIED: [Queen Ansurek->Dps12: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000012, Dps12, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 130.25
		ScheduleTask: (anonymous function) at 130.81 (+0.50)
			Unscheduled by SPELL_AURA_APPLIED at 130.33
	[130.33] SPELL_AURA_APPLIED: [Queen Ansurek->Dps4: Reactive Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000004, Dps4, 0x512, 437586, Reactive Toxin, 0, DEBUFF, 0
		UnscheduleTask: (anonymous function) scheduled by ScheduleTask at 130.31
		ScheduleTask: (anonymous function) at 130.83 (+0.50)
			ShowAnnounce: Reactive Toxin (4) on Dps7, Dps12, Dps2, Dps4
	[132.41] SPELL_CAST_START: [Queen Ansurek: Silken Tomb] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 439814, Silken Tomb, 0, 0
		ShowAnnounce: Roots (4)
	[137.82] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
		AntiSpam: 4
		ShowSpecialWarning: Grasping Silk damage - move away
		PlaySound: VoicePack/watchfeet
	[140.45] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps17: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000017, Dps17, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 140.91, 141.41, 141.92
		ShowSpecialWarning: Blades (6) - dodge attack
		PlaySound: VoicePack/watchstep
	[141.42] SPELL_CAST_START: [Queen Ansurek: Venom Nova] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 437417, Venom Nova, 0, 0
		ShowSpecialWarning: Nova! (3)
		PlaySound: VoicePack/getknockedup
	[145.55] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 0
		ScheduleTask: announce464638count:Schedule(1.0) at 147.05 (+1.50)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 146.82
	[145.55] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Concentrated Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 451278, Concentrated Toxin, 0, DEBUFF, 0
		ShowSpecialWarning: Bomb - move away from others
		PlaySound: VoicePack/runout
		ShowYell: Bomb
	[146.82] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 2, 0
		UnscheduleTask: announce464638count:Schedule(1.0) scheduled by ScheduleTask at 145.55
		ScheduleTask: announce464638count:Schedule(2.0) at 148.32 (+1.50)
			ShowAnnounce: Frothy Toxin (2)
	[148.43] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 3, 0
		ScheduleTask: announce464638count:Schedule(3.0) at 149.93 (+1.50)
			ShowAnnounce: Frothy Toxin (3)
	[149.91] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Tank1: Frothy Toxin] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 464638, Frothy Toxin, 0, DEBUFF, 4, 0
		ScheduleTask: announce464638count:Schedule(4.0) at 151.41 (+1.50)
			ShowAnnounce: Frothy Toxin (4)
	[153.83] SPELL_CAST_START: [Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447076, Predation, 0, 0
		ShowAnnounce: Stage 1.5
		PlaySound: VoicePack/phasechange
		StartTimer: 6.0, Pull (1)
		StartTimer: 13.0, Toxic Waves (1)
	[159.84] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447411, Wrest, 0, 0
		ShowSpecialWarning: Pull! (1)
		PlaySound: VoicePack/pullin
		StartTimer: 19.0, Pull (2)
	[166.89] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
		ShowAnnounce: Toxic Waves (1)
		StartTimer: 4.0, Toxic Waves (2)
	[170.90] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
		ShowAnnounce: Toxic Waves (2)
		StartTimer: 4.0, Toxic Waves (3)
	[174.89] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
		ShowAnnounce: Toxic Waves (3)
		StartTimer: 11.0, Toxic Waves (4)
	[178.92] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447411, Wrest, 0, 0
		ShowSpecialWarning: Pull! (2)
		PlaySound: VoicePack/pullin
		StartTimer: 19.0, Pull (3)
	[182.50] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
		AntiSpam: 4
		ShowSpecialWarning: Grasping Silk damage - move away
		PlaySound: VoicePack/watchfeet
	[185.94] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
		ShowAnnounce: Toxic Waves (4)
		StartTimer: 4.0, Toxic Waves (5)
	[189.96] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
		ShowAnnounce: Toxic Waves (5)
		StartTimer: 4.0, Toxic Waves (6)
	[193.95] SPELL_CAST_START: [Queen Ansurek: Paralyzing Venom] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447456, Paralyzing Venom, 0, 0
		ShowAnnounce: Toxic Waves (6)
		StartTimer: 11.0, Toxic Waves (7)
	[197.93] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 447411, Wrest, 0, 0
		ShowSpecialWarning: Pull! (3)
		PlaySound: VoicePack/pullin
		StartTimer: 19.0, Pull (4)
	[200.09] SPELL_AURA_REMOVED: [Queen Ansurek->Queen Ansurek: Predation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 447207, Predation, 0, BUFF, 0, 0
		ShowAnnounce: Stage 2
		PlaySound: VoicePack/ptwo
		StopTimer: Timer447411cdcount\t4
		StopTimer: Timer447456cdcount\t7
	[202.57] SPELL_CAST_START: [Devoted Worshipper: Cosmic Apocalypse] Creature-0-1-2657-1-223318-000000002F, Devoted Worshipper, 0xa48, "", nil, 0x0, 448458, Cosmic Apocalypse, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 202.88
		ShowAnnounce: Casting Cosmic Apocalypse: 95.0 sec
		StartTimer: 85.0, Cosmic Apocalypse
	[208.42] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (1)
		PlaySound: VoicePack/kick1r
	[208.78] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000032, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (1)
		PlaySound: VoicePack/kick1r
	[212.84] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000032, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (2)
		PlaySound: VoicePack/kick2r
	[212.84] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (2)
		PlaySound: VoicePack/kick2r
	[216.99] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000032, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (3)
		PlaySound: VoicePack/kick3r
	[217.57] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (3)
		PlaySound: VoicePack/kick3r
	[221.96] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (4)
		PlaySound: VoicePack/kick4r
	[222.94] UNIT_DIED: [->Ascended Voidspeaker] "", nil, 0x0, Creature-0-1-2657-1-223150-0000000031, Ascended Voidspeaker, 0xa48, -1, false, 0, 0
		AntiSpam: 6
			Filtered: 1x UNIT_DIED at 222.94
		ShowAnnounce: Knock Up
		PlaySound: VoicePack/getknockedup
		StartTimer: 6.0, Knock Up
		StartTimer: 11.9, Pull (1)
		StartTimer: 12.5, Expulsion Beam (1)
	Unknown trigger
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\4.ogg
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\3.ogg
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\2.ogg
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\1.ogg
	[234.66] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
		ShowSpecialWarning: Pull! (1)
		PlaySound: VoicePack/pullin
		StartTimer: 8.0, Pull (2)
	[235.49] SPELL_CAST_START: [Chamber Expeller: Expulsion Beam] Creature-0-1-2657-1-224368-0000000036, Chamber Expeller, 0xa48, "", nil, 0x0, 451600, Expulsion Beam, 0, 0
		AntiSpam: 2
			Filtered: 1x SPELL_CAST_START at 235.72
		ShowSpecialWarning: Expulsion Beam (1) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 10.0, Expulsion Beam (2)
	[237.12] SPELL_CAST_START: [Chamber Guardian: Oust] Creature-0-1-2657-1-223204-0000000035, Chamber Guardian, 0xa48, "", nil, 0x0, 448147, Oust, 0, 0
		StartTimer: 10.0, Oust
	[237.38] SPELL_CAST_START: [Chamber Guardian: Oust] Creature-0-1-2657-1-223204-000000009F, Chamber Guardian, 0xa48, "", nil, 0x0, 448147, Oust, 0, 0
		StartTimer: 10.0, Oust
	[242.66] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
		ShowSpecialWarning: Pull! (2)
		PlaySound: VoicePack/pullin
		StartTimer: 8.0, Pull (3)
	[245.48] SPELL_CAST_START: [Chamber Expeller: Expulsion Beam] Creature-0-1-2657-1-224368-0000000036, Chamber Expeller, 0xa48, "", nil, 0x0, 451600, Expulsion Beam, 0, 0
		AntiSpam: 2
			Filtered: 1x SPELL_CAST_START at 245.73
		ShowSpecialWarning: Expulsion Beam (2) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 10.0, Expulsion Beam (3)
	[247.11] SPELL_CAST_START: [Chamber Guardian: Oust] Creature-0-1-2657-1-223204-0000000035, Chamber Guardian, 0xa48, "", nil, 0x0, 448147, Oust, 0, 0
		StartTimer: 10.0, Oust
	[247.39] SPELL_CAST_START: [Chamber Guardian: Oust] Creature-0-1-2657-1-223204-000000009F, Chamber Guardian, 0xa48, "", nil, 0x0, 448147, Oust, 0, 0
		StartTimer: 10.0, Oust
	[249.58] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
		AntiSpam: 4
		ShowSpecialWarning: Grasping Silk damage - move away
		PlaySound: VoicePack/watchfeet
	[250.66] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
		ShowSpecialWarning: Pull! (3)
		PlaySound: VoicePack/pullin
		StartTimer: 8.0, Pull (4)
	[250.97] UNIT_DIED: [->Chamber Expeller] "", nil, 0x0, Creature-0-1-2657-1-224368-00000000A0, Chamber Expeller, 0xa48, -1, false, 0, 0
		StopTimer: Timer451600cdcount\t3
	[256.08] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-0000000321, 447208, Queen Ansurek, 63.6, 0, ??, 0
		ShowAnnounce: Platform (1)
		StopTimer: Timer447411cdcount\t4
		StartTimer: 6.0, Pull (4)
		StartTimer: 6.0, Gloom Touch
	[261.46] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
		ShowSpecialWarning: Pull! (4)
		PlaySound: VoicePack/pullin
		StartTimer: 8.0, Pull (5)
	[261.49] SPELL_CAST_START: [Chamber Expeller: Expulsion Beam] Creature-0-1-2657-1-224368-000000003B, Chamber Expeller, 0xa48, "", nil, 0x0, 451600, Expulsion Beam, 0, 0
		AntiSpam: 2
			Filtered: 1x SPELL_CAST_START at 262.55
		ShowSpecialWarning: Expulsion Beam (3) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 10.0, Expulsion Beam (4)
	[261.61] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-000000003D, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
		ShowSpecialWarning: Dark Detonation - interrupt Chamber Acolyte! (1)
		PlaySound: VoicePack/kick1r
	[261.77] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-00000000A4, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
		ShowSpecialWarning: Dark Detonation - interrupt Chamber Acolyte! (1)
		PlaySound: VoicePack/kick1r
	[263.10] SPELL_CAST_START: [Chamber Guardian: Oust] Creature-0-1-2657-1-223204-000000003B, Chamber Guardian, 0xa48, "", nil, 0x0, 448147, Oust, 0, 0
		StartTimer: 10.0, Oust
	[269.49] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
		ShowSpecialWarning: Pull! (5)
		PlaySound: VoicePack/pullin
		StartTimer: 8.0, Pull (6)
	[269.62] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-000000003D, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
		ShowSpecialWarning: Dark Detonation - interrupt Chamber Acolyte! (2)
		PlaySound: VoicePack/kick2r
	[271.48] SPELL_CAST_START: [Chamber Expeller: Expulsion Beam] Creature-0-1-2657-1-224368-000000003B, Chamber Expeller, 0xa48, "", nil, 0x0, 451600, Expulsion Beam, 0, 0
		AntiSpam: 2
			Filtered: 1x SPELL_CAST_START at 272.57
		ShowSpecialWarning: Expulsion Beam (4) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 10.0, Expulsion Beam (5)
	[271.80] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-00000000A4, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
		ShowSpecialWarning: Dark Detonation - interrupt Chamber Acolyte! (2)
		PlaySound: VoicePack/kick2r
	[273.11] SPELL_CAST_START: [Chamber Guardian: Oust] Creature-0-1-2657-1-223204-000000003B, Chamber Guardian, 0xa48, "", nil, 0x0, 448147, Oust, 0, 0
		StartTimer: 10.0, Oust
	[273.60] UNIT_DIED: [->Devoted Worshipper] "", nil, 0x0, Creature-0-1-2657-1-223318-000000009C, Devoted Worshipper, 0xa48, -1, false, 0, 0
		StopTimer: Timer448458cast
	[277.47] SPELL_CAST_START: [Queen Ansurek: Wrest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 450191, Wrest, 0, 0
		ShowSpecialWarning: Pull! (6)
		PlaySound: VoicePack/pullin
		StartTimer: 8.0, Pull (7)
	[277.66] SPELL_CAST_START: [Chamber Acolyte: Dark Detonation] Creature-0-1-2657-1-226200-000000003D, Chamber Acolyte, 0xa48, "", nil, 0x0, 455374, Dark Detonation, 0, 0
		ShowSpecialWarning: Dark Detonation - interrupt Chamber Acolyte! (3)
		PlaySound: VoicePack/kick3r
	[281.63] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Grasping Silk] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 441958, Grasping Silk, 0, DEBUFF, 0
		AntiSpam: 4
		ShowSpecialWarning: Grasping Silk damage - move away
		PlaySound: VoicePack/watchfeet
	[284.25] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-000000043B, 447208, Queen Ansurek, 63.6, 0, ??, 0
		ShowAnnounce: Platform (2)
		StopTimer: Timer447411cdcount\t7
	[288.26] SPELL_CAST_START: [Queen Ansurek: Acidic Apocalypse] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449940, Acidic Apocalypse, 0, 0
		StartTimer: 35.0, Acidic Apocalypse
	[292.57] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-000000004A, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (1)
		PlaySound: VoicePack/kick1r
	[293.50] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-00000000A9, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (1)
		PlaySound: VoicePack/kick1r
	[296.43] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-000000004A, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (2)
		PlaySound: VoicePack/kick2r
	[297.33] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-00000000A9, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (2)
		PlaySound: VoicePack/kick2r
	[299.97] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-000000004A, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (3)
		PlaySound: VoicePack/kick3r
	[301.19] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-00000000A9, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (3)
		PlaySound: VoicePack/kick3r
	[304.92] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-000000004A, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (4)
		PlaySound: VoicePack/kick4r
	[305.14] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-00000000A9, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (4)
		PlaySound: VoicePack/kick4r
	[308.83] SPELL_CAST_START: [Ascended Voidspeaker: Shadowblast] Creature-0-1-2657-1-223150-000000004A, Ascended Voidspeaker, 0xa48, "", nil, 0x0, 447950, Shadowblast, 0, 0
		ShowSpecialWarning: Shadowblast - interrupt Ascended Voidspeaker! (5)
		PlaySound: VoicePack/kick5r
	[309.27] UNIT_DIED: [->Ascended Voidspeaker] "", nil, 0x0, Creature-0-1-2657-1-223150-000000004A, Ascended Voidspeaker, 0xa48, -1, false, 0, 0
		AntiSpam: 6
			Filtered: 1x UNIT_DIED at 309.27
		ShowAnnounce: Knock Up
		PlaySound: VoicePack/getknockedup
		StartTimer: 6.0, Knock Up
	Unknown trigger
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\4.ogg
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\3.ogg
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\2.ogg
		PlaySound: Interface\AddOns\DBM-Core\Sounds\Corsica\1.ogg
	[314.46] UNIT_SPELLCAST_SUCCEEDED: boss1, Cast-3-1-2657-2-447208-000000014A, 447208, Queen Ansurek, 63.6, 0, ??, 0
		ShowAnnounce: Platform (3)
	[315.47] SPELL_CAST_START: [Queen Ansurek: Aphotic Communion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 449986, Aphotic Communion, 0, 0
		StopTimer: Timer449940cast
		ShowAnnounce: Stage 3
		PlaySound: VoicePack/pthree
		StartTimer: 57.8, Portals (1)
		StartTimer: 68.8, Ring (1)
		StartTimer: 43.8, Big Adds (1)
		StartTimer: 116.3, Shackles (1)
		StartTimer: 29.8, Infest (1)
		StartTimer: 31.8, Pools (1)
		StartTimer: 20.4, Blades (1)
	[345.68] SPELL_CAST_START: [Queen Ansurek: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443325, Infest, 0, 0
		StartTimer: 66.0, Infest (2)
	[347.17] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 443656, Infest, 0, DEBUFF, 0
		ShowSpecialWarning: Infest on Dps18 - taunt now
		PlaySound: VoicePack/tauntboss
	[347.64] SPELL_CAST_START: [Queen Ansurek: Gorge] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443336, Gorge, 0, 0
		StartTimer: 66.0, Pools (2)
	[359.65] SPELL_CAST_START: [Queen Ansurek: Queen's Summons] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 444829, Queen's Summons, 0, 0
		ShowAnnounce: Big Adds (1)
		StartTimer: 64.0, Big Adds (2)
	[363.70] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-000000005E, 2, 8, 1
	[363.84] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-00000000AF, 2, 5, 1
	[363.98] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000E1, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000E1, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-00000000E1, 2, 4, 1
	[364.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps8: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000008, Dps8, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 365.21, 365.69, 366.18
		ShowSpecialWarning: Blades (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 11.0, Blades (2)
	[367.69] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 8.2, Null Detonation
	[367.83] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 8.2, Null Detonation
	[367.99] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000E1, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 8.2, Null Detonation
	[373.44] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-000000005E, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 8.2, Null Detonation
	[373.65] SPELL_CAST_START: [Queen Ansurek: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443888, Abyssal Infusion, 0, 0
		StartTimer: 80.0, Portals (2)
	[374.05] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000E1, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 8.2, Null Detonation
	[374.85] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 8.2, Null Detonation
	[375.43] SPELL_AURA_APPLIED: [Queen Ansurek->Dps3: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000003, Dps3, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 375.93 (+0.50)
			ShowAnnounce: Portals (2) on Dps3, Dps1
	[375.49] SPELL_AURA_APPLIED: [Queen Ansurek->Dps1: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000001, Dps1, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		ShowAnnounce: Portals (2) on Dps3, Dps1
	[375.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps18: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 376.19, 376.69, 377.17
		ShowSpecialWarning: Blades (2) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 26.0, Blades (3)
	[381.86] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000AF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[384.68] SPELL_CAST_START: [Queen Ansurek: Frothing Gluttony] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 445422, Frothing Gluttony, 0, 0
		ShowSpecialWarning: Ring - run away (1)
		PlaySound: VoicePack/pullin
		StartTimer: 80.0, Ring (2)
	[389.77] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Acolyte's Essence] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 445152, Acolyte's Essence, 0, DEBUFF, 0
		ShowSpecialWarning: Acolyte's Essence - move away from others
		PlaySound: VoicePack/targetyou
	[401.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps7: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000007, Dps7, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 402.18, 402.68, 403.18
		ShowSpecialWarning: Blades (3) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 21.0, Blades (4)
	[411.68] SPELL_CAST_START: [Queen Ansurek: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443325, Infest, 0, 0
		StartTimer: 82.0, Infest (3)
	[413.18] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 443656, Infest, 0, DEBUFF, 0
		ShowSpecialWarning: Infest on Dps18 - taunt now
		PlaySound: VoicePack/tauntboss
	[413.66] SPELL_CAST_START: [Queen Ansurek: Gorge] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443336, Gorge, 0, 0
		StartTimer: 82.0, Pools (3)
	[422.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps9: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000009, Dps9, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 423.16, 423.68, 424.18
		ShowSpecialWarning: Blades (4) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 17.0, Blades (5)
	[423.65] SPELL_CAST_START: [Queen Ansurek: Queen's Summons] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 444829, Queen's Summons, 0, 0
		ShowAnnounce: Big Adds (2)
		StartTimer: 83.0, Big Adds (3)
	[427.66] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-0000000071, 2, 8, 1
	[427.70] SPELL_AURA_APPLIED: [Queen Ansurek->Dps3: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000003, Dps3, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		AntiSpam: 5
			Filtered: 2x SPELL_AURA_APPLIED at 427.7, 427.7
	[427.70] SPELL_AURA_APPLIED: [Queen Ansurek->Dps4: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000004, Dps4, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		ScheduleTask: announce438976target:CombinedShow("Dps4") at 428.70 (+1.00)
			ShowAnnounce: Shackles on Dps3, Dps19, Dps4
	[427.80] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000B6, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000B6, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-00000000B6, 2, 5, 1
	[427.95] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000E8, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000E8, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-00000000E8, 2, 4, 1
	[428.10] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000100, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000100, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-0000000100, 2, 1, 1
	[431.66] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[431.81] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000B6, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[431.95] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000E8, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[432.09] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000100, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 8.2, Null Detonation
	[432.20] SPELL_CAST_START: [Queen Ansurek: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 438976, Royal Condemnation, 0, 0
		StartTimer: 52.0, Shackles (2)
	[438.67] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 8.2, Null Detonation
	[438.80] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000B6, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 8.2, Null Detonation
	[438.96] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000E8, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 8.2, Null Detonation
	[439.12] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000100, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 8.2, Null Detonation
	[439.70] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps2: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000002, Dps2, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 440.19, 440.7, 441.18
		ShowSpecialWarning: Blades (5) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 16.0, Blades (6)
	[444.89] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000E8, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[445.69] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[445.82] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000B6, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[446.12] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000100, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[451.29] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000071, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (4)
		PlaySound: VoicePack/kick4r
		StartTimer: 8.2, Null Detonation
	[453.66] SPELL_CAST_START: [Queen Ansurek: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 443888, Abyssal Infusion, 0, 0
		StartTimer: 80.0, Portals (3)
	[455.43] SPELL_AURA_APPLIED: [Queen Ansurek->Dps6: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000006, Dps6, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 455.93 (+0.50)
			ShowAnnounce: Portals (3) on Dps6, Dps4
	[455.50] SPELL_AURA_APPLIED: [Queen Ansurek->Dps4: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000004, Dps4, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		ShowAnnounce: Portals (3) on Dps6, Dps4
	[455.68] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps13: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000013, Dps13, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 456.17, 456.69, 457.17
		ShowSpecialWarning: Blades (6) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 47.0, Blades (7)
	[464.66] SPELL_CAST_START: [Queen Ansurek: Frothing Gluttony] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 445422, Frothing Gluttony, 0, 0
		ShowSpecialWarning: Ring - run away (2)
		PlaySound: VoicePack/pullin
		StartTimer: 88.0, Ring (3)
	[468.37] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Acolyte's Essence] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 445152, Acolyte's Essence, 0, DEBUFF, 0
		ShowSpecialWarning: Acolyte's Essence - move away from others
		PlaySound: VoicePack/targetyou
	[476.24] SPELL_AURA_APPLIED: [Queen Ansurek->Tank1: Abyssal Reverberation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 455387, Abyssal Reverberation, 0, DEBUFF, 0
		ShowSpecialWarning: Bomb - move away from others
		PlaySound: VoicePack/runout
		ShowYell: Bomb
	[479.74] SPELL_AURA_APPLIED: [Queen Ansurek->Dps8: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000008, Dps8, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		AntiSpam: 5
			Filtered: 2x SPELL_AURA_APPLIED at 479.74, 479.74
	[479.74] SPELL_AURA_APPLIED: [Queen Ansurek->Dps14: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		ScheduleTask: announce438976target:CombinedShow("Dps14") at 480.74 (+1.00)
			ShowAnnounce: Shackles on Dps8, Dps1, Dps14
	[484.21] SPELL_CAST_START: [Queen Ansurek: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 438976, Royal Condemnation, 0, 0
		StartTimer: 34.0, Shackles (3)
	[495.16] SPELL_AURA_APPLIED: [Queen Ansurek->Dps18: Infest] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000019, Dps18, 0x512, 443656, Infest, 0, DEBUFF, 0
		ShowSpecialWarning: Infest on Dps18 - taunt now
		PlaySound: VoicePack/tauntboss
	[501.09] SPELL_AURA_APPLIED: [Queen Ansurek->Queen Ansurek: Gloom Hatchling] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 443726, Gloom Hatchling, 0, BUFF, 0
		ShowAnnounce: Gloom Hatchling on Queen Ansurek (1)
	[502.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps5: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000005, Dps5, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 503.19, 503.68, 504.17
		ShowSpecialWarning: Blades (7) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 19.0, Blades (8)
	[506.66] SPELL_CAST_START: [Queen Ansurek: Queen's Summons] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 444829, Queen's Summons, 0, 0
		ShowAnnounce: Big Adds (3)
	[510.69] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-0000000088, 2, 8, 1
	[510.83] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-00000000BE, 2, 5, 1
	[510.97] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-00000000EF, 2, 4, 1
	[511.12] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-0000000102, 2, 1, 1
	[511.28] SPELL_AURA_APPLIED: [Summoned Acolyte->Summoned Acolyte: Dark Barrier] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, 445013, Dark Barrier, 0, BUFF, 26990372, 0
		ScanForMobs: Creature-0-1-2657-1-221863-0000000114, 2, 2, 1
	[513.66] SPELL_AURA_APPLIED: [Queen Ansurek->Dps7: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000007, Dps7, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		AntiSpam: 5
			Filtered: 2x SPELL_AURA_APPLIED at 513.66, 513.66
	[513.66] SPELL_AURA_APPLIED: [Queen Ansurek->Dps13: Royal Condemnation] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000013, Dps13, 0x512, 438974, Royal Condemnation, 0, DEBUFF, 0
		ScheduleTask: announce438976target:CombinedShow("Dps13") at 514.66 (+1.00)
			ShowAnnounce: Shackles on Dps7, Dps6, Dps13
	[514.69] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[514.83] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[514.98] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[515.13] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[515.29] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[521.67] SPELL_CAST_SUCCESS: [Queen Ansurek->Tank1: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000018, Tank1, 0x511, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 522.16, 522.66, 523.16
		ShowSpecialWarning: Blades (8) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 14.0, Blades (9)
	[521.70] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[521.85] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[521.98] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[522.16] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[522.29] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		StartTimer: 8.2, Null Detonation
	[528.72] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[528.85] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[528.99] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[529.15] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[529.31] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 8.2, Null Detonation
	[532.96] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (4)
		PlaySound: VoicePack/kick4r
		StartTimer: 8.2, Null Detonation
	[535.43] SPELL_AURA_APPLIED: [Queen Ansurek->Dps15: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000015, Dps15, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		ScheduleTask: (anonymous function) at 535.93 (+0.50)
			ShowAnnounce: Portals (4) on Dps15, Dps14
	[535.48] SPELL_AURA_APPLIED: [Queen Ansurek->Dps14: Abyssal Infusion] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 443903, Abyssal Infusion, 0, DEBUFF, 0
		ShowAnnounce: Portals (4) on Dps15, Dps14
	[535.66] SPELL_CAST_SUCCESS: [Queen Ansurek->Dps14: Web Blades] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Player-1-00000014, Dps14, 0x512, 439299, Web Blades, 0, 0
		AntiSpam: 3
			Filtered: 3x SPELL_CAST_SUCCESS at 536.16, 536.67, 537.14
		ShowSpecialWarning: Blades (9) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 22.0, Blades (10)
	[535.72] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (4)
		PlaySound: VoicePack/kick4r
		StartTimer: 8.2, Null Detonation
	[535.85] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (4)
		PlaySound: VoicePack/kick4r
		StartTimer: 8.2, Null Detonation
	[536.16] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (4)
		PlaySound: VoicePack/kick4r
		StartTimer: 8.2, Null Detonation
	[536.30] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (4)
		PlaySound: VoicePack/kick4r
		StartTimer: 8.2, Null Detonation
	[537.22] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (5)
		PlaySound: VoicePack/kick5r
		StartTimer: 8.2, Null Detonation
	[540.25] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (5)
		PlaySound: VoicePack/kick5r
		StartTimer: 8.2, Null Detonation
	[542.86] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (5)
		PlaySound: VoicePack/kick5r
		StartTimer: 8.2, Null Detonation
	[543.17] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (5)
		PlaySound: VoicePack/kick5r
		StartTimer: 8.2, Null Detonation
	[543.31] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (5)
		PlaySound: VoicePack/kick5r
		StartTimer: 8.2, Null Detonation
	[544.99] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (6)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[547.26] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (6)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[549.88] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (6)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[550.18] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (6)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[550.33] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (6)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[551.69] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000EF, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (7)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[552.67] SPELL_CAST_START: [Queen Ansurek: Frothing Gluttony] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, "", nil, 0x0, 445422, Frothing Gluttony, 0, 0
		ShowSpecialWarning: Ring - run away (3)
		PlaySound: VoicePack/pullin
	[554.28] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000088, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (7)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[556.89] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-00000000BE, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (7)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[557.20] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000102, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (7)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[557.35] SPELL_CAST_START: [Summoned Acolyte: Null Detonation] Creature-0-1-2657-1-221863-0000000114, Summoned Acolyte, 0xa48, "", nil, 0x0, 445021, Null Detonation, 0, 0
		ShowSpecialWarning: Null Detonation - interrupt Summoned Acolyte! (7)
		PlaySound: VoicePack/kickcast
		StartTimer: 8.2, Null Detonation
	[557.69] SPELL_AURA_APPLIED: [Queen Ansurek->Queen Ansurek: Froth Vapor] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 445880, Froth Vapor, 0, BUFF, 0
		ShowAnnounce: Froth Vapor on Queen Ansurek (1)
	[557.69] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Queen Ansurek: Froth Vapor] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 445880, Froth Vapor, 0, BUFF, 2, 0
		ScheduleTask: announce445880stack:Schedule("Queen Ansurek", 2.0) at 558.69 (+1.00)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 557.69
	[557.69] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Queen Ansurek: Froth Vapor] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 445880, Froth Vapor, 0, BUFF, 3, 0
		UnscheduleTask: announce445880stack:Schedule("Queen Ansurek", 2.0) scheduled by ScheduleTask at 557.69
		ScheduleTask: announce445880stack:Schedule("Queen Ansurek", 3.0) at 558.69 (+1.00)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 557.69
	[557.69] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Queen Ansurek: Froth Vapor] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 445880, Froth Vapor, 0, BUFF, 4, 0
		UnscheduleTask: announce445880stack:Schedule("Queen Ansurek", 3.0) scheduled by ScheduleTask at 557.69
		ScheduleTask: announce445880stack:Schedule("Queen Ansurek", 4.0) at 558.69 (+1.00)
			Unscheduled by SPELL_AURA_APPLIED_DOSE at 557.69
	[557.69] SPELL_AURA_APPLIED_DOSE: [Queen Ansurek->Queen Ansurek: Froth Vapor] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 445880, Froth Vapor, 0, BUFF, 5, 0
		UnscheduleTask: announce445880stack:Schedule("Queen Ansurek", 4.0) scheduled by ScheduleTask at 557.69
		ScheduleTask: announce445880stack:Schedule("Queen Ansurek", 5.0) at 558.69 (+1.00)
			Unscheduled by ENCOUNTER_END at 557.93
	[557.76] SPELL_AURA_APPLIED: [Queen Ansurek->Queen Ansurek: Cataclysmic Evolution] Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, Creature-0-1-2657-1-218370-0000000002, Queen Ansurek, 0xa48, 451832, Cataclysmic Evolution, 0, BUFF, 0
		ShowSpecialWarning: Cataclysmic Evolution on Queen Ansurek
		PlaySound: VoicePack/stilldanger
	[557.93] ENCOUNTER_END: 2922, Queen Ansurek, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
		UnscheduleTask: announce445880stack:Schedule("Queen Ansurek", 5.0) scheduled by ScheduleTask at 557.69
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 437586 447207 453990 462558 451278 443903 455387 445152 443656 445013 445021 464056 447967
]]
