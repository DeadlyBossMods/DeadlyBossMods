DBM.Test:Report[[
Test: TWW/NerubarPalace/Kyveza/Mythic/Kill
Mod:  DBM-Raids-WarWithin/2601

Findings:
	Unused event registration: SPELL_AURA_APPLIED 440576 (Chasmal Gash)
	Unused event registration: SPELL_AURA_APPLIED 447169 (Death Mask)
	Unused event registration: SPELL_AURA_APPLIED 447174 (Death Cloak)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 440576 (Chasmal Gash)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 447174 (Death Cloak)
	Unused event registration: SPELL_AURA_REMOVED 437343 (Queensbane)
	Unused event registration: SPELL_AURA_REMOVED 447169 (Death Mask)
	Unused event registration: SPELL_CAST_START 453683 (Void Shredders)
	Announce for spell ID 435414 (Starless Night) is triggered by event SPELL_CAST_START 435405 (Starless Night)
	Announce for spell ID 436867 (Assassination) is triggered by event SPELL_CAST_START 436971 (Assassination)
	Timer for spell ID 436867 (Assassination) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 437620 (Nether Rift) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 438245 (Twilight Massacre) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 439409 (Dark Viscera) is triggered by event SPELL_AURA_APPLIED 437343 (Queensbane)
	Timer for spell ID 439576 (Nexus Daggers) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 440377 (Void Shredders) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 448364 (Death Masks) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)

Unused objects:
	[Announce] Gash on >%s< (%d), type=stack, spellId=440576
	[Special Warning] Queensbane - move away from others, type=moveaway, spellId=437343
	[Special Warning] Void Shredders - defensive, type=defensive, spellId=440377
	[Special Warning] %d stacks of Gash on you, type=stack, spellId=440576
	[Special Warning] Gash on >%s< - taunt now, type=taunt, spellId=440576
	[Special Warning] Death Cloak!, type=spell, spellId=447174
	[Yell] %d, type=shortfade, spellId=437343

Timers:
	Starless Night ends, time=24.00, type=active, spellId=435405, triggerDeltas = 96.12, 129.99
		[ 96.12] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
			 Triggered 2x, delta times: 96.12, 129.99
	Starless Night (%s), time=120.00, type=cdcount, spellId=435405, triggerDeltas = 0.00, 125.13, 130.00
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.13, 130.00
	Assassination (%s), time=120.00, type=cdcount, spellId=436867, triggerDeltas = 0.00, 125.13, 130.00
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.13, 130.00
	Rift (%s), time=30.00, type=cdcount, spellId=437620, triggerDeltas = 0.00, 22.01, 29.99, 73.13, 26.85, 30.03, 73.12, 26.87, 30.02
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[ 22.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
			 Triggered 6x, delta times: 22.01, 29.99, 99.98, 30.03, 99.99, 30.02
		[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.13, 130.00
	Charges (%s), time=30.00, type=cdcount, spellId=438245, triggerDeltas = 0.00, 33.98, 91.15, 38.88, 91.12, 38.88
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[ 33.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
			 Triggered 3x, delta times: 33.98, 130.03, 130.00
		[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.13, 130.00
	Orbs, time=10.00, type=cast, spellId=439409, triggerDeltas = 17.03, 23.33, 30.03, 76.63, 23.37, 30.00, 76.66, 23.33, 30.00
		[ 17.03] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps7: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000007, Dps7, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		[ 40.36] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps3: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000003, Dps3, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		[ 70.39] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps2: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000002, Dps2, 0x512, 437343, Queensbane, 0, DEBUFF, 0
			 Triggered 2x, delta times: 70.39, 130.00
		[147.02] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps11: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000011, Dps11, 0x512, 437343, Queensbane, 0, DEBUFF, 0
			 Triggered 2x, delta times: 147.02, 130.03
		[170.39] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps19: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000020, Dps19, 0x512, 437343, Queensbane, 0, DEBUFF, 0
			 Triggered 2x, delta times: 170.39, 129.99
		[330.38] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps5: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000005, Dps5, 0x512, 437343, Queensbane, 0, DEBUFF, 0
	Daggers (%s), time=30.00, type=cdcount, spellId=439576, triggerDeltas = 0.00, 45.38, 79.75, 50.26, 79.74, 50.24
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[ 45.38] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
			 Triggered 3x, delta times: 45.38, 130.01, 129.98
		[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.13, 130.00
	Tank Debuff (%s), time=30.00, type=cdcount, spellId=440377, triggerDeltas = 0.00, 10.02, 29.99, 85.12, 14.89, 29.98, 85.13, 14.88, 30.01
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[ 10.02] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
			 Triggered 6x, delta times: 10.02, 29.99, 100.01, 29.98, 100.01, 30.01
		[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.13, 130.00
	Death Masks (%s), time=49.00, type=cdcount, spellId=448364, triggerDeltas = 0.00, 125.13, 130.00
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.13, 130.00

Announces:
	Starless Night (%s), type=count, spellId=435414, triggerDeltas = 96.12, 129.99
		[ 96.12] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
			 Triggered 2x, delta times: 96.12, 129.99
	Assassination incoming debuff (%s), type=incomingcount, spellId=436867, triggerDeltas = 13.74, 130.01, 130.03
		[ 13.74] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
			 Triggered 3x, delta times: 13.74, 130.01, 130.03
	Charges (%s), type=count, spellId=438245, triggerDeltas = 33.98, 30.03, 100.00, 30.00, 100.00, 29.99
		[ 33.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
			 Triggered 6x, delta times: 33.98, 30.03, 100.00, 30.00, 100.00, 29.99
	Casting Eternal Night: 5.0 sec, type=cast, spellId=442277, triggerDeltas = 356.12
		[356.12] SPELL_CAST_START: [Nexus-Princess Ky'veza: Eternal Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 442277, Eternal Night, 0, 0
	Death Masks (%s), type=count, spellId=448364, triggerDeltas = 19.02, 129.99, 130.01
		[ 19.02] SPELL_CAST_SUCCESS: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
			 Triggered 3x, delta times: 19.02, 129.99, 130.01

Special warnings:
	Nether Rift (%s) - dodge attack, type=dodgecount, spellId=437620, triggerDeltas = 22.01, 29.99, 30.00, 69.98, 30.03, 29.98, 70.01, 30.02, 30.00
		[ 22.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
			 Triggered 9x, delta times: 22.01, 29.99, 30.00, 69.98, 30.03, 29.98, 70.01, 30.02, 30.00
	Daggers (%s) - dodge attack, type=dodgecount, spellId=439576, triggerDeltas = 45.38, 29.97, 100.04, 29.96, 100.02, 30.00
		[ 45.38] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
			 Triggered 6x, delta times: 45.38, 29.97, 100.04, 29.96, 100.02, 30.00

Yells:
	None

Voice pack sounds:
	VoicePack/farfromline
		[ 45.38] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
			 Triggered 6x, delta times: 45.38, 29.97, 100.04, 29.96, 100.02, 30.00
	VoicePack/watchstep
		[ 22.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
			 Triggered 9x, delta times: 22.01, 29.99, 30.00, 69.98, 30.03, 29.98, 70.01, 30.02, 30.00

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 436971 437620 438245 439576 440377 453683 442277 435405, SPELL_CAST_SUCCESS 448364, SPELL_AURA_APPLIED 447169 447174 440576 437343, SPELL_AURA_APPLIED_DOSE 447174 440576, SPELL_AURA_REMOVED 447169 435405 437343
		StartTimer: 10.0, Tank Debuff (1)
		StartTimer: 13.2, Assassination (1)
		StartTimer: 22.0, Rift (1)
		StartTimer: 34.0, Charges (1)
		StartTimer: 45.2, Daggers (1)
		StartTimer: 96.0, Starless Night (1)
		StartTimer: 18.9, Death Masks (1)
	[ 10.02] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (2)
	[ 13.74] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
		ShowAnnounce: Assassination incoming debuff (1)
	[ 17.03] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps7: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000007, Dps7, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 17.26, 17.53, 17.75, 18
		StartTimer: 10.0, Orbs
	[ 19.02] SPELL_CAST_SUCCESS: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
		ShowAnnounce: Death Masks (1)
	[ 22.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (2)
		ShowSpecialWarning: Nether Rift (1) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 33.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Charges (1)
		StartTimer: 30.0, Charges (2)
	[ 40.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (3)
	[ 40.36] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps3: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000003, Dps3, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 40.47, 40.56, 40.7, 40.77
		StartTimer: 10.0, Orbs
	[ 45.38] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 46.15, 46.9, 47.65, 48.39, 49.14
		StartTimer: 30.0, Daggers (2)
		ShowSpecialWarning: Daggers (1) - dodge attack
		PlaySound: VoicePack/farfromline
	[ 52.00] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (3)
		ShowSpecialWarning: Nether Rift (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 64.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Charges (2)
	[ 70.39] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps2: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000002, Dps2, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 70.5, 70.6, 70.69, 70.78
		StartTimer: 10.0, Orbs
	[ 75.35] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 76.12, 76.85, 77.62, 78.36, 79.12
		ShowSpecialWarning: Daggers (2) - dodge attack
		PlaySound: VoicePack/farfromline
	[ 82.00] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Nether Rift (3) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 96.12] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
		ShowAnnounce: Starless Night (1)
		StartTimer: 29.0, Starless Night ends
	[125.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
		StartTimer: 14.8, Tank Debuff (4)
		StartTimer: 18.1, Assassination (2)
		StartTimer: 26.8, Rift (4)
		StartTimer: 38.8, Charges (3)
		StartTimer: 50.0, Daggers (3)
		StartTimer: 100.0, Starless Night (2)
		StartTimer: 23.8, Death Masks (2)
	[140.02] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (5)
	[143.75] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
		ShowAnnounce: Assassination incoming debuff (2)
	[147.02] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps11: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000011, Dps11, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 147.27, 147.53, 147.78, 148.02
		StartTimer: 10.0, Orbs
	[149.01] SPELL_CAST_SUCCESS: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
		ShowAnnounce: Death Masks (2)
	[151.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (5)
		ShowSpecialWarning: Nether Rift (4) - dodge attack
		PlaySound: VoicePack/watchstep
	[164.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Charges (3)
		StartTimer: 30.0, Charges (2)
	[170.00] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (6)
	[170.39] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps19: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000020, Dps19, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 170.49, 170.6, 170.69, 170.79
		StartTimer: 10.0, Orbs
	[175.39] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 176.15, 176.91, 177.64, 178.38, 179.13
		StartTimer: 30.0, Daggers (2)
		ShowSpecialWarning: Daggers (3) - dodge attack
		PlaySound: VoicePack/farfromline
	[182.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (6)
		ShowSpecialWarning: Nether Rift (5) - dodge attack
		PlaySound: VoicePack/watchstep
	[194.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Charges (4)
	[200.39] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps2: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000002, Dps2, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 200.51, 200.59, 200.69, 200.8
		StartTimer: 10.0, Orbs
	[205.35] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 206.11, 206.85, 207.6, 208.36, 209.11
		ShowSpecialWarning: Daggers (4) - dodge attack
		PlaySound: VoicePack/farfromline
	[211.99] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Nether Rift (6) - dodge attack
		PlaySound: VoicePack/watchstep
	[226.11] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
		ShowAnnounce: Starless Night (2)
		StartTimer: 29.0, Starless Night ends
	[255.13] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
		StartTimer: 14.8, Tank Debuff (7)
		StartTimer: 18.1, Assassination (3)
		StartTimer: 26.8, Rift (7)
		StartTimer: 38.8, Charges (5)
		StartTimer: 50.0, Daggers (5)
		StartTimer: 100.0, Starless Night (3)
		StartTimer: 23.8, Death Masks (3)
	[270.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (8)
	[273.78] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
		ShowAnnounce: Assassination incoming debuff (3)
	[277.05] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps11: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000011, Dps11, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 277.3, 277.56, 277.8, 278.03
		StartTimer: 10.0, Orbs
	[279.02] SPELL_CAST_SUCCESS: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
		ShowAnnounce: Death Masks (3)
	[282.00] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (8)
		ShowSpecialWarning: Nether Rift (7) - dodge attack
		PlaySound: VoicePack/watchstep
	[294.01] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Charges (5)
		StartTimer: 30.0, Charges (2)
	[300.02] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (9)
	[300.38] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps19: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000020, Dps19, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 300.49, 300.62, 300.75, 300.83
		StartTimer: 10.0, Orbs
	[305.37] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 306.11, 306.89, 307.63, 308.37, 309.12
		StartTimer: 30.0, Daggers (2)
		ShowSpecialWarning: Daggers (5) - dodge attack
		PlaySound: VoicePack/farfromline
	[312.02] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (9)
		ShowSpecialWarning: Nether Rift (8) - dodge attack
		PlaySound: VoicePack/watchstep
	[324.00] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Charges (6)
	[330.38] SPELL_AURA_APPLIED: [Nexus-Princess Ky'veza->Dps5: Queensbane] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Player-1-00000005, Dps5, 0x512, 437343, Queensbane, 0, DEBUFF, 0
		AntiSpam: (nil)
			Filtered: 4x SPELL_AURA_APPLIED at 330.51, 330.6, 330.68, 330.77
		StartTimer: 10.0, Orbs
	[335.37] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 336.11, 336.87, 337.63, 338.37, 339.13
		ShowSpecialWarning: Daggers (6) - dodge attack
		PlaySound: VoicePack/farfromline
	[342.02] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Nether Rift (9) - dodge attack
		PlaySound: VoicePack/watchstep
	[356.12] SPELL_CAST_START: [Nexus-Princess Ky'veza: Eternal Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 442277, Eternal Night, 0, 0
		ShowAnnounce: Casting Eternal Night: 5.0 sec
	[394.58] ENCOUNTER_END: 2920, Nexus-Princess Ky'veza, 16, 20, 1, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 447169 435405 437343
]]
