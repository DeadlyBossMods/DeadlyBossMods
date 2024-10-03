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
	[Special Warning] Gruesome Disgorge on >%s< - taunt now, type=taunt, spellId=443612
	[Yell] Tentacle, type=shortyell, spellId=443042
	[Yell] %d, type=shortfade, spellId=452237

Timers:
	Run away! (%s), time=128.00, type=nextcount, spellId=442530, triggerDeltas = 0.00, 119.99, 128.02
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[119.99] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
			 Triggered 2x, delta times: 119.99, 128.02
	Grasp (%s), time=40.00, type=nextcount, spellId=443042, triggerDeltas = 0.00, 19.08, 27.87, 31.16, 27.86, 41.17, 27.87, 31.12, 27.89, 41.14, 27.87
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 19.08] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps10: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000010, Dps10, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
			 Triggered 2x, delta times: 19.08, 128.06
		[ 46.95] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps6: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000006, Dps6, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
			 Triggered 2x, delta times: 46.95, 256.08
		[ 78.11] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps13: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000013, Dps13, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[105.97] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps4: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000004, Dps4, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[175.01] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps14: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000014, Dps14, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[206.13] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps8: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000008, Dps8, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[234.02] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps2: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000002, Dps2, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		[275.16] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps12: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Dps12, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
	Crimson Rain (%s), time=128.00, type=nextcount, spellId=443203, triggerDeltas = 0.00, 11.04, 128.09, 127.92
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 11.04] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
			 Triggered 3x, delta times: 11.04, 128.09, 127.92
	Gruesome Disgorge fades, time=40.00, type=fades, spellId=443612, triggerDeltas = 19.03, 127.99, 128.03
		[ 19.03] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
			 Triggered 3x, delta times: 19.03, 127.99, 128.03
	Frontal (%s), time=49.00, type=nextcount, spellId=444363, triggerDeltas = 0.00, 13.99, 58.99, 69.04, 59.01, 69.02, 59.00
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 13.99] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
			 Triggered 6x, delta times: 13.99, 58.99, 69.04, 59.01, 69.02, 59.00
	Slam, time=13.40, type=cdnp, spellId=445016, triggerDeltas = 30.70, 57.05, 18.26, 53.45, 58.30, 21.87, 46.06, 3.64, 13.38
		[ 30.70] SPELL_CAST_SUCCESS: [Lost Watcher->Dps19: Spectral Slam] Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, Player-1-00000019, Dps19, 0x511, 445016, Spectral Slam, 0, 0
			 Triggered 5x, delta times: 30.70, 128.76, 126.23, 3.64, 13.38
		[ 87.75] SPELL_CAST_SUCCESS: [Lost Watcher->Tank1: Spectral Slam] Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, Player-1-00000020, Tank1, 0x512, 445016, Spectral Slam, 0, 0
			 Triggered 4x, delta times: 87.75, 18.26, 111.75, 21.87
	Beams (%s), time=40.00, type=nextcount, spellId=445936, triggerDeltas = 0.00, 31.95, 59.03, 69.02, 59.03, 69.00
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[ 31.95] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
			 Triggered 5x, delta times: 31.95, 59.03, 69.02, 59.03, 69.00
	Shield, time=15.50, type=cdnp, spellId=451288, triggerDeltas = 21.48, 58.99, 16.43, 52.62, 16.66, 42.37, 17.13, 16.99, 34.89, 0.28, 17.02, 2.42, 14.55
		[ 21.48] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 13x, delta times: 21.48, 58.99, 16.43, 52.62, 16.66, 42.37, 17.13, 16.99, 34.89, 0.28, 17.02, 2.42, 14.55
	Spreads (%s), time=40.00, type=nextcount, spellId=452237, triggerDeltas = 0.00, 8.97, 32.01, 26.98, 32.02, 37.02, 31.99, 27.03, 32.00, 37.02, 31.98, 27.01
		[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		[  8.97] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
			 Triggered 11x, delta times: 8.97, 32.01, 26.98, 32.02, 37.02, 31.99, 27.03, 32.00, 37.02, 31.98, 27.01

Announces:
	Crimson Rain (%s), type=count, spellId=443203, triggerDeltas = 11.04, 128.09, 127.92
		[ 11.04] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
			 Triggered 3x, delta times: 11.04, 128.09, 127.92
	Gruesome Disgorge faded, type=fades, spellId=443612, triggerDeltas = 59.02, 128.02, 128.02
		[ 59.02] SPELL_AURA_REMOVED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
			 Triggered 3x, delta times: 59.02, 128.02, 128.02
	Gruesome Disgorge on YOU, type=you, spellId=443612, triggerDeltas = 19.03, 127.99, 128.03
		[ 19.03] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
			 Triggered 3x, delta times: 19.03, 127.99, 128.03
	Casting Manifest Horror: 4.0 sec, type=cast, spellId=445174, triggerDeltas = 21.62, 3.99, 4.00, 4.01, 4.01, 43.46, 4.01, 4.00, 4.01, 4.00, 4.00, 4.01, 4.00, 40.06, 4.01, 4.00, 4.00, 4.01, 4.01, 3.99, 4.02, 3.99, 4.01, 4.00, 4.01, 4.03, 3.97, 4.02, 3.42, 4.01, 4.02, 3.99, 3.99, 4.02, 49.14, 4.00, 4.00, 4.02, 3.99, 4.01, 4.01, 4.01, 4.01, 4.00, 3.99, 4.00, 4.01, 4.01
		[ 21.62] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000C6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
			 Triggered 48x, delta times: 21.62, 3.99, 4.00, 4.01, 4.01, 43.46, 4.01, 4.00, 4.01, 4.00, 4.00, 4.01, 4.00, 40.06, 4.01, 4.00, 4.00, 4.01, 4.01, 3.99, 4.02, 3.99, 4.01, 4.00, 4.01, 4.03, 3.97, 4.02, 3.42, 4.01, 4.02, 3.99, 3.99, 4.02, 49.14, 4.00, 4.00, 4.02, 3.99, 4.01, 4.01, 4.01, 4.01, 4.00, 3.99, 4.00, 4.01, 4.01

Special warnings:
	Run away! - run away (%s), type=runcount, spellId=442530, triggerDeltas = 119.99, 128.02
		[119.99] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
			 Triggered 2x, delta times: 119.99, 128.02
	Frontal! (%s), type=count, spellId=444363, triggerDeltas = 13.99, 58.99, 69.04, 59.01, 69.02, 59.00
		[ 13.99] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
			 Triggered 6x, delta times: 13.99, 58.99, 69.04, 59.01, 69.02, 59.00
	Slam - defensive, type=defensive, spellId=445016, triggerDeltas = 282.69
		[282.69] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
	%s damage - move away, type=gtfo, spellId=445518, triggerDeltas = 30.42, 36.70, 59.14, 88.65, 7.17, 30.43, 47.98, 10.32
		[ 30.42] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
			 Triggered 8x, delta times: 30.42, 36.70, 59.14, 88.65, 7.17, 30.43, 47.98, 10.32
	Beams (%s) - dodge attack, type=dodgecount, spellId=445936, triggerDeltas = 31.95, 59.03, 69.02, 59.03, 69.00
		[ 31.95] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
			 Triggered 5x, delta times: 31.95, 59.03, 69.02, 59.03, 69.00
	Shield - interrupt >%s<! (%d), type=interruptcount, spellId=451288, triggerDeltas = 21.48, 58.99, 16.43, 52.62, 16.66, 42.37, 17.13, 16.99, 34.89, 0.28, 17.02, 2.42, 14.55
		[ 21.48] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 13x, delta times: 21.48, 58.99, 16.43, 52.62, 16.66, 42.37, 17.13, 16.99, 34.89, 0.28, 17.02, 2.42, 14.55
	Spreads - move away from others, type=moveaway, spellId=452237, triggerDeltas = 10.98, 32.02, 26.98, 32.01, 37.05, 31.98, 27.03, 32.00, 37.01, 32.00, 26.97
		[ 10.98] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
			 Triggered 11x, delta times: 10.98, 32.02, 26.98, 32.01, 37.05, 31.98, 27.03, 32.00, 37.01, 32.00, 26.97

Yells:
	Bloodcurdle, type=shortyell, spellId=452237
		[ 10.98] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
			 Triggered 11x, delta times: 10.98, 32.02, 26.98, 32.01, 37.05, 31.98, 27.03, 32.00, 37.01, 32.00, 26.97

Voice pack sounds:
	VoicePack/defensive
		[282.69] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
	VoicePack/farfromline
		[ 31.95] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
			 Triggered 5x, delta times: 31.95, 59.03, 69.02, 59.03, 69.00
	VoicePack/frontal
		[ 13.99] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
			 Triggered 6x, delta times: 13.99, 58.99, 69.04, 59.01, 69.02, 59.00
	VoicePack/justrun
		[119.99] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
			 Triggered 2x, delta times: 119.99, 128.02
	VoicePack/kick1r
		[ 21.48] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 5x, delta times: 21.48, 58.99, 69.05, 59.03, 69.01
	VoicePack/kick2r
		[ 96.90] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 4x, delta times: 96.90, 69.28, 59.50, 69.18
	VoicePack/kick3r
		[242.67] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
			 Triggered 2x, delta times: 242.67, 69.16
	VoicePack/kick4r
		[277.84] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
	VoicePack/kick5r
		[297.28] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
	VoicePack/scatter
		[ 10.98] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
			 Triggered 11x, delta times: 10.98, 32.02, 26.98, 32.01, 37.05, 31.98, 27.03, 32.00, 37.01, 32.00, 26.97
	VoicePack/watchfeet
		[ 30.42] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
			 Triggered 8x, delta times: 30.42, 36.70, 59.14, 88.65, 7.17, 30.43, 47.98, 10.32

Icons:
	Icon 4, target=Creature-0-1-2657-1-221667-0000000008, scanMethod=nil
		[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 4, target=Creature-0-1-2657-1-221667-000000001F, scanMethod=nil
		[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 4, target=Creature-0-1-2657-1-221667-000000003E, scanMethod=nil
		[147.02] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-000000003E, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 4, target=Creature-0-1-2657-1-221667-000000005B, scanMethod=nil
		[206.06] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 4, target=Creature-0-1-2657-1-221667-0000000075, scanMethod=nil
		[275.08] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
	Icon 5, target=Creature-0-1-2657-1-221945-00000000DA, scanMethod=nil
		[206.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000DA, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000AD, scanMethod=nil
		[206.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000AD, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000C6, scanMethod=nil
		[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000C6, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000CB, scanMethod=nil
		[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000CB, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000D4, scanMethod=nil
		[147.02] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000D4, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 6, target=Creature-0-1-2657-1-221945-00000000E1, scanMethod=nil
		[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000E1, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-0000000092, scanMethod=nil
		[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000092, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-0000000098, scanMethod=nil
		[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-00000000A6, scanMethod=nil
		[147.02] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 7, target=Creature-0-1-2657-1-221945-00000000B4, scanMethod=nil
		[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000B4, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221945-0000000008, scanMethod=nil
		[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000008, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221945-000000001F, scanMethod=nil
		[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000001F, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221945-000000003E, scanMethod=nil
		[147.01] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000003E, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221945-000000005B, scanMethod=nil
		[206.06] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000005B, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
	Icon 8, target=Creature-0-1-2657-1-221945-0000000075, scanMethod=nil
		[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000075, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0

Event trace:
	[  0.00] ENCOUNTER_START: 2917, The Bloodbound Horror, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 444363 452237 445936 442530 451288 445016 445174, SPELL_CAST_SUCCESS 443203 445016, SPELL_SUMMON 444830 444835, SPELL_AURA_APPLIED 443612 452245 443042 445272, SPELL_AURA_APPLIED_DOSE 445272, SPELL_AURA_REMOVED 443612 452245 443042, SPELL_PERIODIC_DAMAGE 445518, SPELL_PERIODIC_MISSED 445518, UNIT_DIED
		StartTimer: 11.0, Crimson Rain (1)
		StartTimer: 14.0, Frontal (1)
		StartTimer: 19.1, Grasp (1)
		StartTimer: 32.0, Beams (1)
		StartTimer: 9.0, Spreads (1)
		StartTimer: 120.0, Run away! (1)
	[  8.97] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (2)
	[ 10.98] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[ 11.04] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
		ShowAnnounce: Crimson Rain (1)
		StartTimer: 128.0, Crimson Rain (2)
	[ 13.99] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Frontal! (1)
		PlaySound: VoicePack/frontal
		StartTimer: 59.0, Frontal (2)
	[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000008, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000008, 2, 8, 1
	[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-0000000008, 2, 4, 1
	[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000092, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000092, 2, 7, 1
	[ 18.97] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000C6, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000C6, 2, 6, 1
	[ 19.03] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
		ShowAnnounce: Gruesome Disgorge on YOU
		StartTimer: 40.0, Gruesome Disgorge fades
	[ 19.08] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps10: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000010, Dps10, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 19.08, 19.08, 19.08
		StartTimer: 27.8, Grasp (2)
	[ 21.48] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Shield
	[ 21.62] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000C6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 21.62, 21.62
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 25.61] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000092, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 25.61, 25.61
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 29.61] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000092, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 30.42] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[ 30.70] SPELL_CAST_SUCCESS: [Lost Watcher->Dps19: Spectral Slam] Creature-0-1-2657-1-221667-0000000008, Lost Watcher, 0xa48, Player-1-00000019, Dps19, 0x511, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[ 31.95] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Beams (1) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 59.0, Beams (2)
	[ 33.62] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000092, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 37.63] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000092, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 40.98] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 27.0, Spreads (3)
	[ 43.00] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[ 46.95] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps6: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000006, Dps6, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 46.95, 46.95, 46.95
		StartTimer: 31.1, Grasp (3)
	[ 59.02] SPELL_AURA_REMOVED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
		ShowAnnounce: Gruesome Disgorge faded
	[ 67.12] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[ 67.96] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (4)
	[ 69.98] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[ 72.98] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Frontal! (2)
		PlaySound: VoicePack/frontal
		StartTimer: 69.1, Frontal (3)
	[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000001F, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-000000001F, 2, 8, 1
	[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-000000001F, 2, 4, 1
	[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000098, 2, 7, 1
	[ 77.99] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000CB, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000CB, 2, 6, 1
	[ 78.11] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps13: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000013, Dps13, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 78.12, 78.12, 78.12
		StartTimer: 27.8, Grasp (4)
	[ 80.47] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Shield
	[ 81.09] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000CB, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 81.09, 81.09
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 85.10] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000CB, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 85.1, 85.1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 87.75] SPELL_CAST_SUCCESS: [Lost Watcher->Tank1: Spectral Slam] Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, Player-1-00000020, Tank1, 0x512, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[ 89.10] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 89.1, 89.1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 90.98] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Beams (2) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 69.1, Beams (3)
	[ 93.11] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 96.90] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 15.5, Shield
	[ 97.11] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[ 99.98] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (5)
	[101.11] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[101.99] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[105.12] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[105.97] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps4: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000004, Dps4, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 105.97, 105.97, 105.97
		StartTimer: 41.1, Grasp (5)
	[106.01] SPELL_CAST_SUCCESS: [Lost Watcher->Tank1: Spectral Slam] Creature-0-1-2657-1-221667-000000001F, Lost Watcher, 0xa48, Player-1-00000020, Tank1, 0x512, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[109.12] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000098, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[119.99] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
		ShowSpecialWarning: Run away! - run away (1)
		PlaySound: VoicePack/justrun
		StartTimer: 128.0, Run away! (2)
	[126.26] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[137.00] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (6)
	[139.04] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[139.13] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
		ShowAnnounce: Crimson Rain (2)
		StartTimer: 128.0, Crimson Rain (3)
	[142.02] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Frontal! (3)
		PlaySound: VoicePack/frontal
		StartTimer: 59.0, Frontal (4)
	[147.01] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000003E, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-000000003E, 2, 8, 1
	[147.02] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
		ShowAnnounce: Gruesome Disgorge on YOU
		StartTimer: 40.0, Gruesome Disgorge fades
	[147.02] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000A6, 2, 7, 1
	[147.02] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000D4, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000D4, 2, 6, 1
	[147.02] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-000000003E, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-000000003E, 2, 4, 1
	[147.14] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps10: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000010, Dps10, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 147.14, 147.14, 147.14
		StartTimer: 27.8, Grasp (6)
	[149.18] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000D4, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 149.18, 149.18
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[149.52] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000003E, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Shield
	[153.19] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000003E, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 153.19, 153.19
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[157.19] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000003E, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 157.19
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[159.46] SPELL_CAST_SUCCESS: [Lost Watcher->Dps19: Spectral Slam] Creature-0-1-2657-1-221667-000000003E, Lost Watcher, 0xa48, Player-1-00000019, Dps19, 0x511, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[160.00] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Beams (3) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 59.0, Beams (4)
	[161.19] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000003E, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 1x SPELL_CAST_START at 161.19
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[165.20] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[166.18] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000003E, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 15.5, Shield
	[168.99] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 27.0, Spreads (7)
	[169.21] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[171.02] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[173.20] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[175.01] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps14: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000014, Dps14, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 175.01, 175.01, 175.01
		StartTimer: 31.1, Grasp (7)
	[177.22] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[181.21] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[185.22] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[187.04] SPELL_AURA_REMOVED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
		ShowAnnounce: Gruesome Disgorge faded
	[189.22] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[193.23] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[196.02] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (8)
	[197.26] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[198.05] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[201.03] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Frontal! (4)
		PlaySound: VoicePack/frontal
		StartTimer: 69.1, Frontal (5)
	[201.23] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[205.25] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000A6, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[206.06] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-000000005B, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-000000005B, 2, 8, 1
	[206.06] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-000000005B, 2, 4, 1
	[206.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000AD, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000AD, 2, 6, 1
	[206.07] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000DA, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000DA, 2, 5, 1
	[206.13] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps8: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000008, Dps8, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 206.13, 206.13, 206.13
		StartTimer: 27.8, Grasp (8)
	[208.55] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Shield
	[208.67] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000DA, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 3x SPELL_CAST_START at 208.68, 208.68, 209.25
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[212.68] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000DA, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 3x SPELL_CAST_START at 212.68, 212.68, 213.24
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[214.91] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[216.70] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000AD, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 3x SPELL_CAST_START at 216.7, 216.7, 217.24
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[217.76] SPELL_CAST_SUCCESS: [Lost Watcher->Tank1: Spectral Slam] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, Player-1-00000020, Tank1, 0x512, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[219.03] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Beams (4) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 69.1, Beams (5)
	[220.69] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000DA, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 3x SPELL_CAST_START at 220.69, 220.71, 221.26
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[222.08] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
			Filtered: 1x SPELL_PERIODIC_DAMAGE at 223.07
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[224.68] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-000000005B, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 224.7, 225.27
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[225.68] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 15.5, Shield
	[228.02] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (9)
	[228.70] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000AD, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[230.05] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[234.02] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps2: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000002, Dps2, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 234.02, 234.02, 234.02
		StartTimer: 41.1, Grasp (9)
	[239.63] SPELL_CAST_SUCCESS: [Lost Watcher->Tank1: Spectral Slam] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, Player-1-00000020, Tank1, 0x512, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[242.67] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 15.5, Shield
	[248.01] SPELL_CAST_START: [The Bloodbound Horror: Goresplatter] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 442530, Goresplatter, 0, 0
		ShowSpecialWarning: Run away! - run away (2)
		PlaySound: VoicePack/justrun
		StartTimer: 128.0, Run away! (3)
	[252.51] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[265.04] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (10)
	[267.05] SPELL_CAST_SUCCESS: [The Bloodbound Horror: Crimson Rain] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 443203, Crimson Rain, 0, 0
		ShowAnnounce: Crimson Rain (3)
		StartTimer: 128.0, Crimson Rain (4)
	[267.06] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[270.05] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Frontal! (5)
		PlaySound: VoicePack/frontal
		StartTimer: 59.0, Frontal (6)
	[275.05] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
		ShowAnnounce: Gruesome Disgorge on YOU
		StartTimer: 40.0, Gruesome Disgorge fades
	[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-0000000075, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-0000000075, 2, 8, 1
	[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000B4, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000B4, 2, 7, 1
	[275.08] SPELL_SUMMON: [The Bloodbound Horror->Lost Watcher: Summon Lost Watcher] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, 444830, Summon Lost Watcher, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221667-0000000075, 2, 4, 1
	[275.08] SPELL_SUMMON: [The Bloodbound Horror->Forgotten Harbinger: Summon Forgotten Harbinger] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Creature-0-1-2657-1-221945-00000000E1, Forgotten Harbinger, 0xa48, 444835, Summon Forgotten Harbinger, 0, 0
		ScanForMobs: Creature-0-1-2657-1-221945-00000000E1, 2, 6, 1
	[275.16] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps12: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000012, Dps12, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 275.16, 275.16, 275.16
		StartTimer: 27.8, Grasp (10)
	[277.56] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (1)
		PlaySound: VoicePack/kick1r
		StartTimer: 15.5, Shield
	[277.84] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (4)
		PlaySound: VoicePack/kick4r
		StartTimer: 15.5, Shield
	[277.84] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 277.85, 277.85
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[281.84] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000B4, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 281.84, 281.84
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[282.69] SPELL_CAST_START: [Lost Watcher: Spectral Slam] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, "", nil, 0x0, 445016, Spectral Slam, 0, 0
		ShowSpecialWarning: Slam - defensive
		PlaySound: VoicePack/defensive
	[285.69] SPELL_CAST_SUCCESS: [Lost Watcher->Dps19: Spectral Slam] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, Player-1-00000019, Dps19, 0x511, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[285.84] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000075, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 285.84, 285.84
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[288.03] SPELL_CAST_START: [The Bloodbound Horror: Spewing Hemorrhage] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 445936, Spewing Hemorrhage, 0, 0
		ShowSpecialWarning: Beams (5) - dodge attack
		PlaySound: VoicePack/farfromline
		StartTimer: 59.0, Beams (6)
	[289.33] SPELL_CAST_SUCCESS: [Lost Watcher->Dps19: Spectral Slam] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, Player-1-00000019, Dps19, 0x511, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[289.86] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000075, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 289.86, 289.86
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[293.85] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 293.85, 293.85
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[294.86] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (2)
		PlaySound: VoicePack/kick2r
		StartTimer: 15.5, Shield
	[297.02] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 27.0, Spreads (11)
	[297.28] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-000000005B, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (5)
		PlaySound: VoicePack/kick5r
		StartTimer: 15.5, Shield
	[297.86] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 297.87, 297.87
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[299.06] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[300.49] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[301.87] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000075, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 301.87, 301.87
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[302.71] SPELL_CAST_SUCCESS: [Lost Watcher->Dps19: Spectral Slam] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, Player-1-00000019, Dps19, 0x511, 445016, Spectral Slam, 0, 0
		StartTimer: 10.4, Slam
	[303.03] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps6: Grasp From Beyond] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000006, Dps6, 0x512, 443042, Grasp From Beyond, 0, DEBUFF, 0
		AntiSpam: 2
			Filtered: 3x SPELL_AURA_APPLIED at 303.03, 303.03, 303.03
		StartTimer: 31.1, Grasp (11)
	[305.88] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-0000000075, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 305.89, 305.89
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[309.89] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000B4, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 309.89, 309.89
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[310.81] SPELL_PERIODIC_DAMAGE: [->Dps19: Black Blood] "", nil, 0x0, Player-1-00000019, Dps19, 0x511, 445518, Black Blood, 0, 0
		AntiSpam: 3
		ShowSpecialWarning: Black Blood damage - move away
		PlaySound: VoicePack/watchfeet
	[311.83] SPELL_CAST_START: [Lost Watcher: Black Bulwark] Creature-0-1-2657-1-221667-0000000075, Lost Watcher, 0xa48, "", nil, 0x0, 451288, Black Bulwark, 0, 0
		ShowSpecialWarning: Shield - interrupt Lost Watcher! (3)
		PlaySound: VoicePack/kick3r
		StartTimer: 15.5, Shield
	[313.89] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 313.89, 313.89
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[315.06] SPELL_AURA_REMOVED: [The Bloodbound Horror->Dps19: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 443612, Gruesome Disgorge, 0, DEBUFF, 0
		ShowAnnounce: Gruesome Disgorge faded
	[317.88] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000E1, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 317.88, 317.88
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[321.88] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000B4, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 321.88, 321.89
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[324.03] SPELL_CAST_START: [The Bloodbound Horror: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 452237, Bloodcurdle, 0, 0
		StartTimer: 32.0, Spreads (12)
	[325.89] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000B4, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 325.89, 325.89
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[326.03] SPELL_AURA_APPLIED: [The Bloodbound Horror->Dps19: Bloodcurdle] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, Player-1-00000019, Dps19, 0x511, 452245, Bloodcurdle, 0, DEBUFF, 0
		ShowSpecialWarning: Spreads - move away from others
		PlaySound: VoicePack/scatter
		ShowYell: Bloodcurdle
	[329.05] SPELL_CAST_START: [The Bloodbound Horror: Gruesome Disgorge] Creature-0-1-2657-1-214502-0000000001, The Bloodbound Horror, 0xa48, "", nil, 0x0, 444363, Gruesome Disgorge, 0, 0
		ShowSpecialWarning: Frontal! (6)
		PlaySound: VoicePack/frontal
		StartTimer: 69.1, Frontal (7)
	[329.90] SPELL_CAST_START: [Forgotten Harbinger: Manifest Horror] Creature-0-1-2657-1-221945-00000000B4, Forgotten Harbinger, 0xa48, "", nil, 0x0, 445174, Manifest Horror, 0, 0
		AntiSpam: 1
			Filtered: 2x SPELL_CAST_START at 329.9, 329.91
		ShowAnnounce: Casting Manifest Horror: 4.0 sec
	[330.34] ENCOUNTER_END: 2917, The Bloodbound Horror, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 443612 452245 443042
]]
