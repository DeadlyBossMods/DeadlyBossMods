DBM.Test:Report[[
Test: TWW/NerubarPalace/BloodboundHorror/Mythic/Kill
Mod:  DBM-Raids-WarWithin/2611

Findings:
	Unused event registration: SPELL_AURA_APPLIED 445272 (Blood Pact)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 445272 (Blood Pact)
	Unused event registration: SPELL_AURA_REMOVED 443042 (Grasp From Beyond)
	Unused event registration: SPELL_AURA_REMOVED 452245 (Bloodcurdle)
	Unused event registration: SPELL_PERIODIC_MISSED 445518 (Black Blood)
	Unused event registration: UNIT_DIED
	SpecialWarning for spell ID 452237 (Bloodcurdle) is triggered by event SPELL_AURA_APPLIED 452245 (Bloodcurdle)
	Yell for spell ID 452237 (Bloodcurdle) is triggered by event SPELL_AURA_APPLIED 452245 (Bloodcurdle)

Unused objects:
	[Announce] Grasp faded, type=fades, spellId=443042
	[Announce] Blood Pact on >%s< (%d), type=stack, spellId=445272
	[Special Warning] Grasp - move away from others, type=moveaway, spellId=443042
	[Special Warning] Baneful Shift on >%s< - taunt now, type=taunt, spellId=443612
	[Special Warning] Spectral Slam - defensive, type=defensive, spellId=445016
	[Yell] Tentacle, type=shortyell, spellId=443042
	[Yell] %d, type=shortfade, spellId=452237

Timers:
	Goresplatter (%s), time=128.00, type=nextcount, spellId=442530, triggerDeltas = 0.00, 120.03, 128.01
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[120.03] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
			 Triggered 2x, delta times: 120.03, 128.01
	367465, time=40.00, type=nextcount, spellId=443042, triggerDeltas = 0.00, 19.15, 27.84, 31.15, 27.90, 41.12, 27.91, 31.06, 27.95, 41.07, 27.93, 31.20
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 19.15] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps6: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000011, Dps6, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[ 46.99] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000003, Dps3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
			 Triggered 2x, delta times: 46.99, 256.09
		[ 78.14] SPELL_AURA_APPLIED: [The Bloodbound Horror->Healer3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000013, Healer3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
			 Triggered 2x, delta times: 78.14, 155.94
		[106.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000006, Tank3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[147.16] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps7: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000014, Dps7, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[175.07] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps2: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000002, Dps2, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[206.13] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank1: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000004, Tank1, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
			 Triggered 2x, delta times: 206.13, 128.15
		[275.15] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps9: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000017, Dps9, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
	Crimson Rain (%s), time=128.00, type=nextcount, spellId=443203, triggerDeltas = 0.00, 11.05, 128.09, 127.96
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 11.05] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
			 Triggered 3x, delta times: 11.05, 128.09, 127.96
	Baneful Shift fades, time=40.00, type=fades, spellId=443612, triggerDeltas = 19.01, 128.04, 128.04
		[ 19.01] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
			 Triggered 3x, delta times: 19.01, 128.04, 128.04
	Gruesome Disgorge (%s), time=49.00, type=nextcount, spellId=444363, triggerDeltas = 0.00, 14.01, 59.00, 69.03, 59.05, 68.99, 59.00
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 14.01] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
			 Triggered 6x, delta times: 14.01, 59.00, 69.03, 59.05, 68.99, 59.00
	Spectral Slam, time=13.40, type=cdnp, spellId=445016, triggerDeltas = 27.80, 59.80, 68.24, 58.44, 20.69, 48.76, 56.17, 17.02
		[ 27.80] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
			 Triggered 8x, delta times: 27.80, 59.80, 68.24, 58.44, 20.69, 48.76, 56.17, 17.02
	Spewing Hemorrhage (%s), time=40.00, type=nextcount, spellId=445936, triggerDeltas = 0.00, 31.99, 58.99, 69.08, 59.00, 69.00, 59.01
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 31.99] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
			 Triggered 6x, delta times: 31.99, 58.99, 69.08, 59.00, 69.00, 59.01
	Black Bulwark, time=15.50, type=cdnp, spellId=451288, triggerDeltas = 21.57, 58.95, 69.03, 17.24, 41.76, 16.71, 52.35, 58.95, 15.50
		[ 21.57] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 9x, delta times: 21.57, 58.95, 69.03, 17.24, 41.76, 16.71, 52.35, 58.95, 15.50
	Spreads (%s), time=40.00, type=nextcount, spellId=452237, triggerDeltas = 0.00, 9.01, 32.02, 26.96, 32.02, 37.06, 31.96, 27.03, 32.00, 37.01, 32.01, 26.98, 32.01
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[  9.01] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
			 Triggered 12x, delta times: 9.01, 32.02, 26.96, 32.02, 37.06, 31.96, 27.03, 32.00, 37.01, 32.01, 26.98, 32.01

Announces:
	Crimson Rain (%s), type=count, spellId=443203, triggerDeltas = 11.05, 128.09, 127.96
		[ 11.05] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
			 Triggered 3x, delta times: 11.05, 128.09, 127.96
	Baneful Shift faded, type=fades, spellId=443612, triggerDeltas = 59.01, 128.06, 128.03
		[ 59.01] SPELL_AURA_REMOVED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
			 Triggered 3x, delta times: 59.01, 128.06, 128.03
	Baneful Shift on YOU, type=you, spellId=443612, triggerDeltas = 19.01, 128.04, 128.04
		[ 19.01] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
			 Triggered 3x, delta times: 19.01, 128.04, 128.04
	Casting Manifest Horror: 4.0 sec, type=cast, spellId=445174, triggerDeltas = 21.69, 4.01, 4.01, 50.59, 4.00, 4.01, 3.99, 4.02, 53.45, 4.01, 4.01, 4.02, 3.99, 4.02, 38.38, 4.00, 4.01, 4.01, 4.00, 4.00, 49.41, 4.00, 4.00, 4.03, 46.55, 4.00, 4.01, 4.01, 4.00, 4.00
		[ 21.69] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000FF, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
			 Triggered 30x, delta times: 21.69, 4.01, 4.01, 50.59, 4.00, 4.01, 3.99, 4.02, 53.45, 4.01, 4.01, 4.02, 3.99, 4.02, 38.38, 4.00, 4.01, 4.01, 4.00, 4.00, 49.41, 4.00, 4.00, 4.03, 46.55, 4.00, 4.01, 4.01, 4.00, 4.00

Special warnings:
	Goresplatter (%s) - dodge attack, type=dodgecount, spellId=442530, triggerDeltas = 120.03, 128.01
		[120.03] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
			 Triggered 2x, delta times: 120.03, 128.01
	Gruesome Disgorge! (%s), type=count, spellId=444363, triggerDeltas = 14.01, 59.00, 69.03, 59.05, 68.99, 59.00
		[ 14.01] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
			 Triggered 6x, delta times: 14.01, 59.00, 69.03, 59.05, 68.99, 59.00
	%s damage - move away, type=gtfo, spellId=445518, triggerDeltas = 176.53, 56.61, 19.61, 5.06
		[176.53] SPELL_PERIODIC_DAMAGE: [->Tank4: Black Blood] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 445518, Black Blood, 0, 0
			 Triggered 4x, delta times: 176.53, 56.61, 19.61, 5.06
	Spewing Hemorrhage - run away (%s), type=runcount, spellId=445936, triggerDeltas = 31.99, 58.99, 69.08, 59.00, 69.00, 59.01
		[ 31.99] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
			 Triggered 6x, delta times: 31.99, 58.99, 69.08, 59.00, 69.00, 59.01
	Black Bulwark - interrupt >%s<! (%d), type=interruptcount, spellId=451288, triggerDeltas = 21.57, 58.95, 69.03, 17.24, 41.76, 16.71, 52.35, 58.95, 15.50
		[ 21.57] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 9x, delta times: 21.57, 58.95, 69.03, 17.24, 41.76, 16.71, 52.35, 58.95, 15.50
	Bloodcurdle - move away from others, type=moveaway, spellId=452237, triggerDeltas = 11.04, 32.03, 26.94, 32.01, 37.06, 31.96, 27.05, 31.98, 37.03, 32.00, 26.97, 32.04
		[ 11.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
			 Triggered 12x, delta times: 11.04, 32.03, 26.94, 32.01, 37.06, 31.96, 27.05, 31.98, 37.03, 32.00, 26.97, 32.04

Yells:
	Bloodcurdle, type=shortyell, spellId=452237
		[ 11.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
			 Triggered 12x, delta times: 11.04, 32.03, 26.94, 32.01, 37.06, 31.96, 27.05, 31.98, 37.03, 32.00, 26.97, 32.04

Voice pack sounds:
	VoicePack/justrun
		[ 31.99] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
			 Triggered 6x, delta times: 31.99, 58.99, 69.08, 59.00, 69.00, 59.01
	VoicePack/kick1r
		[ 21.57] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 6x, delta times: 21.57, 58.95, 69.03, 59.00, 69.06, 58.95
	VoicePack/kick2r
		[166.79] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000051, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 3x, delta times: 166.79, 58.47, 126.80
	VoicePack/scatter
		[ 11.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
			 Triggered 12x, delta times: 11.04, 32.03, 26.94, 32.01, 37.06, 31.96, 27.05, 31.98, 37.03, 32.00, 26.97, 32.04
	VoicePack/shockwave
		[ 14.01] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
			 Triggered 6x, delta times: 14.01, 59.00, 69.03, 59.05, 68.99, 59.00
	VoicePack/watchfeet
		[176.53] SPELL_PERIODIC_DAMAGE: [->Tank4: Black Blood] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 445518, Black Blood, 0, 0
			 Triggered 4x, delta times: 176.53, 56.61, 19.61, 5.06
	VoicePack/watchstep
		[120.03] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
			 Triggered 2x, delta times: 120.03, 128.01

Icons:
	Icon 5, target=Creature-0-1-2657-1-221945-00000000FF, scanMethod=nil
		[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000FF, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 5, target=Creature-0-1-2657-1-221945-0000000103, scanMethod=nil
		[ 78.01] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000103, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 5, target=Creature-0-1-2657-1-221945-0000000107, scanMethod=nil
		[147.05] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000107, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 5, target=Creature-0-1-2657-1-221945-000000010A, scanMethod=nil
		[206.04] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000010A, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 5, target=Creature-0-1-2657-1-221945-000000010F, scanMethod=nil
		[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000010F, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 5, target=Creature-0-1-2657-1-221945-0000000112, scanMethod=nil
		[334.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000112, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000D0, scanMethod=nil
		[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000D0, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000D8, scanMethod=nil
		[ 78.01] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000D8, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000E2, scanMethod=nil
		[147.05] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000E2, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000EC, scanMethod=nil
		[206.04] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000EC, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000F1, scanMethod=nil
		[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000F1, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000F8, scanMethod=nil
		[334.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000F8, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-0000000012, scanMethod=nil
		[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000012, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-0000000031, scanMethod=nil
		[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000031, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-0000000051, scanMethod=nil
		[147.05] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000051, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-0000000077, scanMethod=nil
		[206.04] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000077, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-0000000097, scanMethod=nil
		[275.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000097, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-00000000BC, scanMethod=nil
		[334.06] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000BC, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221667-0000000012, scanMethod=nil
		[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221667-0000000031, scanMethod=nil
		[ 78.01] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000031, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221667-0000000051, scanMethod=nil
		[147.05] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000051, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221667-0000000077, scanMethod=nil
		[206.04] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000077, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221667-0000000097, scanMethod=nil
		[275.08] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000097, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221667-00000000BC, scanMethod=nil
		[334.07] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-00000000BC, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0

Event trace:
	[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 444363 452237 445936 442530 451288 445016 445174, SPELL_CAST_SUCCESS 443203, SPELL_SUMMON 444830 444835, SPELL_AURA_APPLIED 443612 452245 443042 445272, SPELL_AURA_APPLIED_DOSE 445272, SPELL_AURA_REMOVED 443612 452245 443042, SPELL_PERIODIC_DAMAGE 445518, SPELL_PERIODIC_MISSED 445518, UNIT_DIED
		StartTimer: 11.0, Crimson Rain (1)
		StartTimer: 14.0, Gruesome Disgorge (1)
		StartTimer: 19.1, Grasp (1)
		StartTimer: 32.0, Spewing Hemorrhage (1)
		StartTimer: 9.0, Spreads (1)
		StartTimer: 120.0, Goresplatter (1)
	[  9.01] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (2)
	[ 11.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[ 11.05] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
		ShowAnnounce: Crimson Rain (1)
		StartTimer: 128.0, Crimson Rain (2)
	[ 14.01] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Gruesome Disgorge! (1)
		PlaySound: VoicePack/shockwave
		StartTimer: 59.0, Gruesome Disgorge (2)
	[ 19.01] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
		ShowAnnounce: Baneful Shift on YOU
		StartTimer: 40.0, Baneful Shift fades
	[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000012, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000012, 2, 7, 1
	[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-0000000012, 2, 8, 1
	[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000D0, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000D0, 2, 6, 1
	[ 19.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000FF, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000FF, 2, 5, 1
	[ 19.15] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps6: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000011, Dps6, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 19.15, 19.15
		StartTimer: 27.8, Grasp (2)
	[ 21.57] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Black Bulwark
	[ 21.69] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000FF, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 21.7, 21.7
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 25.70] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000012, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 25.7, 25.7
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 27.80] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000012, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[ 29.71] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000FF, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 29.71, 29.71
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 31.99] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Spewing Hemorrhage - run away (1)
		PlaySound: VoicePack/justrun
		StartTimer: 59.0, Spewing Hemorrhage (2)
	[ 41.03] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 27.0, Spreads (3)
	[ 43.07] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[ 46.99] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000003, Dps3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 46.99, 46.99
		StartTimer: 31.1, Grasp (3)
	[ 59.01] SPELL_AURA_REMOVED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
		ShowAnnounce: Baneful Shift faded
	[ 67.99] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (4)
	[ 70.01] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[ 73.01] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Gruesome Disgorge! (2)
		PlaySound: VoicePack/shockwave
		StartTimer: 69.1, Gruesome Disgorge (3)
	[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000031, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000031, 2, 7, 1
	[ 78.01] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000D8, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000D8, 2, 6, 1
	[ 78.01] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000031, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-0000000031, 2, 8, 1
	[ 78.01] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000103, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000103, 2, 5, 1
	[ 78.14] SPELL_AURA_APPLIED: [The Bloodbound Horror->Healer3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000013, Healer3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 78.14, 78.14
		StartTimer: 27.8, Grasp (4)
	[ 80.30] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000103, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 80.3, 80.3
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 80.52] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000031, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Black Bulwark
	[ 84.30] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000031, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 84.3, 84.3
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 87.60] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000031, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[ 88.31] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000031, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 88.31, 88.31
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 90.98] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Spewing Hemorrhage - run away (2)
		PlaySound: VoicePack/justrun
		StartTimer: 69.1, Spewing Hemorrhage (3)
	[ 92.30] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000D8, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 92.3
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 96.32] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000D8, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 96.32
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[100.01] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (5)
	[102.02] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[106.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000006, Tank3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 106.04, 106.04
		StartTimer: 41.1, Grasp (5)
	[120.03] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
		ShowSpecialWarning: Goresplatter (1) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 128.0, Goresplatter (2)
	[137.07] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (6)
	[139.08] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[139.14] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
		ShowAnnounce: Crimson Rain (2)
		StartTimer: 128.0, Crimson Rain (3)
	[142.04] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Gruesome Disgorge! (3)
		PlaySound: VoicePack/shockwave
		StartTimer: 59.0, Gruesome Disgorge (4)
	[147.05] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000051, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000051, 2, 7, 1
	[147.05] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000E2, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000E2, 2, 6, 1
	[147.05] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000051, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-0000000051, 2, 8, 1
	[147.05] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000107, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000107, 2, 5, 1
	[147.05] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
		ShowAnnounce: Baneful Shift on YOU
		StartTimer: 40.0, Baneful Shift fades
	[147.16] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps7: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000014, Dps7, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 147.16, 147.16
		StartTimer: 27.8, Grasp (6)
	[149.55] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000051, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Black Bulwark
	[149.77] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000107, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 149.77, 149.77
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[153.78] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E2, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 153.78, 153.78
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[155.84] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000051, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[157.79] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000107, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 157.79
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[160.06] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Spewing Hemorrhage - run away (3)
		PlaySound: VoicePack/justrun
		StartTimer: 59.0, Spewing Hemorrhage (4)
	[161.81] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E2, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 161.81
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[165.80] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E2, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[166.79] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000051, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 15.5, Black Bulwark
	[169.03] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 27.0, Spreads (7)
	[169.82] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E2, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[171.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[175.07] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps2: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000002, Dps2, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 175.07, 175.07
		StartTimer: 31.1, Grasp (7)
	[176.53] SPELL_PERIODIC_DAMAGE: [->Tank4: Black Blood] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[187.07] SPELL_AURA_REMOVED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
		ShowAnnounce: Baneful Shift faded
	[196.06] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (8)
	[198.09] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[201.09] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Gruesome Disgorge! (4)
		PlaySound: VoicePack/shockwave
		StartTimer: 69.1, Gruesome Disgorge (5)
	[206.04] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000077, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000077, 2, 7, 1
	[206.04] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000077, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-0000000077, 2, 8, 1
	[206.04] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000EC, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000EC, 2, 6, 1
	[206.04] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000010A, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-000000010A, 2, 5, 1
	[206.13] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank1: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000004, Tank1, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 206.13, 206.13
		StartTimer: 27.8, Grasp (8)
	[208.20] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000010A, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 208.2, 208.2
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[208.55] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000077, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Black Bulwark
	[212.20] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000010A, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 212.2, 212.2
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[214.28] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000077, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[216.21] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000010A, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 216.21, 216.21
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[219.06] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Spewing Hemorrhage - run away (4)
		PlaySound: VoicePack/justrun
		StartTimer: 69.1, Spewing Hemorrhage (5)
	[220.22] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000EC, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 220.22
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[224.22] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000EC, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[225.26] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000077, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 15.5, Black Bulwark
	[228.06] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (9)
	[228.22] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000EC, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[230.07] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[233.14] SPELL_PERIODIC_DAMAGE: [->Tank4: Black Blood] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[234.08] SPELL_AURA_APPLIED: [The Bloodbound Horror->Healer3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000013, Healer3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 234.08, 234.08
		StartTimer: 41.1, Grasp (9)
	[234.97] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000077, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[248.04] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
		ShowSpecialWarning: Goresplatter (2) - dodge attack
		PlaySound: VoicePack/watchstep
		StartTimer: 128.0, Goresplatter (3)
	[252.75] SPELL_PERIODIC_DAMAGE: [->Tank4: Black Blood] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[257.81] SPELL_PERIODIC_DAMAGE: [->Tank4: Black Blood] "", nil, 0x0, Player-1-00000012, Tank4, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[265.07] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (10)
	[267.10] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[267.10] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
		ShowAnnounce: Crimson Rain (3)
		StartTimer: 128.0, Crimson Rain (4)
	[270.08] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Gruesome Disgorge! (5)
		PlaySound: VoicePack/shockwave
		StartTimer: 59.0, Gruesome Disgorge (6)
	[275.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000097, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000097, 2, 7, 1
	[275.08] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000097, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-0000000097, 2, 8, 1
	[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000F1, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000F1, 2, 6, 1
	[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000010F, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-000000010F, 2, 5, 1
	[275.09] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
		ShowAnnounce: Baneful Shift on YOU
		StartTimer: 40.0, Baneful Shift fades
	[275.15] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps9: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000017, Dps9, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 275.15, 275.15
		StartTimer: 27.8, Grasp (10)
	[277.61] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000097, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Black Bulwark
	[277.63] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000010F, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 277.63, 277.63
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[281.63] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000F1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 281.63, 281.63
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[283.73] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000097, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[285.63] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000F1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 285.64, 285.64
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[288.06] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Spewing Hemorrhage - run away (5)
		PlaySound: VoicePack/justrun
		StartTimer: 59.0, Spewing Hemorrhage (6)
	[289.66] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000F1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[297.08] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 27.0, Spreads (11)
	[299.10] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[303.08] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps3: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000003, Dps3, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 303.08, 303.08
		StartTimer: 31.1, Grasp (11)
	[315.10] SPELL_AURA_REMOVED: [The Bloodbound Horror->Tank4: Baneful Shift] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 443612, Baneful Shift, 0, DEBUFF, 0
		ShowAnnounce: Baneful Shift faded
	[324.06] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (12)
	[326.07] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[329.08] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Gruesome Disgorge! (6)
		PlaySound: VoicePack/shockwave
		StartTimer: 69.1, Gruesome Disgorge (7)
	[334.06] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000BC, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000BC, 2, 7, 1
	[334.07] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-00000000BC, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-00000000BC, 2, 8, 1
	[334.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000F8, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000F8, 2, 6, 1
	[334.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000112, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000112, 2, 5, 1
	[334.28] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank1: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000004, Tank1, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 2x SPELL_AURA_APPLIED at 334.28, 334.28
		StartTimer: 27.8, Grasp (12)
	[336.21] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000112, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 336.21, 336.21
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[336.56] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-00000000BC, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Black Bulwark
	[339.90] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-00000000BC, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[340.21] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000BC, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 340.21, 340.21
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[344.22] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000112, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 344.22, 344.22
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[347.07] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Spewing Hemorrhage - run away (6)
		PlaySound: VoicePack/justrun
		StartTimer: 69.1, Spewing Hemorrhage (7)
	[348.23] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000F8, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 348.23, 348.23
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[352.06] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-00000000BC, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Black Bulwark - interrupt Lost Watcher! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 15.5, Black Bulwark
	[352.23] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000F8, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 352.23
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[356.07] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (13)
	[356.23] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000112, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[356.92] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-00000000BC, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		StartTimer: 13.4, Spectral Slam
	[358.11] SPELL_AURA_APPLIED: [The Bloodbound Horror->Tank4: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Tank4, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Bloodcurdle - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[359.02] ENCOUNTER_END: 2917, The Bloodbound Horror, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 443612 452245 443042
]]
