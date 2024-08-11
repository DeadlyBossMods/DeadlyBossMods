DBM.Test:Report[[
Test: TWW/NerubarPalace/Kyveza/Mythic/Wipe-1
Mod:  DBM-Raids-WarWithin/2601

Findings:
	Unused event registration: SPELL_AURA_APPLIED 440576 (Chasmal Gash)
	Unused event registration: SPELL_AURA_APPLIED 447169 (Death Mask)
	Unused event registration: SPELL_AURA_APPLIED 447174 (Death Cloak)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 440576 (Chasmal Gash)
	Unused event registration: SPELL_AURA_APPLIED_DOSE 447174 (Death Cloak)
	Unused event registration: SPELL_AURA_REMOVED 447169 (Death Mask)
	Unused event registration: SPELL_CAST_START 453683 (Void Shredders)
	Announce for spell ID 435414 (Starless Night) is triggered by event SPELL_CAST_START 435405 (Starless Night)
	Announce for spell ID 436867 (Assassination) is triggered by event SPELL_CAST_START 436971 (Assassination)
	Timer for spell ID 436867 (Assassination) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 437620 (Nether Rift) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 438245 (Twilight Massacre) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 439576 (Nexus Daggers) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)
	Timer for spell ID 440377 (Void Shredders) is triggered by event SPELL_AURA_REMOVED 435405 (Starless Night)

Unused objects:
	[Announce] Chasmal Gash on >%s< (%d), type=stack, spellId=440576
	[Special Warning] Void Shredders - defensive, type=defensive, spellId=440377
	[Special Warning] %d stacks of Chasmal Gash on you, type=stack, spellId=440576
	[Special Warning] Chasmal Gash on >%s< - taunt now, type=taunt, spellId=440576
	[Special Warning] Death Cloak!, type=spell, spellId=447174
	[Timer] Death Masks AI, time=49.00, type=ai, spellId=448364

Timers:
	Starless Night ends, time=24.00, type=active, spellId=435405, triggerDeltas = 96.09, 129.99
		[ 96.09] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
			 Triggered 2x, delta times: 96.09, 129.99
	Starless Night (%s), time=120.00, type=cdcount, spellId=435405, triggerDeltas = 0.00, 125.09, 130.01
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[125.09] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.09, 130.01
	Assassination (%s), time=120.00, type=cdcount, spellId=436867, triggerDeltas = 0.00, 125.09, 130.01
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[125.09] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.09, 130.01
	Rift (%s), time=30.00, type=cdcount, spellId=437620, triggerDeltas = 0.00, 21.97, 30.01, 73.11, 26.89, 29.98, 73.14, 26.86, 30.01
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[ 21.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
			 Triggered 6x, delta times: 21.97, 30.01, 100.00, 29.98, 100.00, 30.01
		[125.09] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.09, 130.01
	281001, time=30.00, type=cdcount, spellId=438245, triggerDeltas = 0.00, 33.98, 91.11, 38.88, 91.13, 38.88
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[ 33.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
			 Triggered 3x, delta times: 33.98, 129.99, 130.01
		[125.09] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.09, 130.01
	Nexus Daggers (%s), time=30.00, type=cdcount, spellId=439576, triggerDeltas = 0.00, 45.25, 79.84, 50.14, 79.87, 50.11
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[ 45.25] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
			 Triggered 3x, delta times: 45.25, 129.98, 129.98
		[125.09] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.09, 130.01
	Tank Debuff (%s), time=30.00, type=cdcount, spellId=440377, triggerDeltas = 0.00, 5.96, 34.00, 85.13, 10.90, 33.98, 85.13, 10.87, 33.98
		[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		[  5.96] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
			 Triggered 6x, delta times: 5.96, 34.00, 96.03, 33.98, 96.00, 33.98
		[125.09] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
			 Triggered 2x, delta times: 125.09, 130.01

Announces:
	Starless Night (%s), type=count, spellId=435414, triggerDeltas = 96.09, 129.99
		[ 96.09] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
			 Triggered 2x, delta times: 96.09, 129.99
	Assassination incoming debuff (%s), type=incomingcount, spellId=436867, triggerDeltas = 13.26, 129.96, 130.00
		[ 13.26] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
			 Triggered 3x, delta times: 13.26, 129.96, 130.00
	Massacre (%s), type=count, spellId=438245, triggerDeltas = 33.98, 29.99, 100.00, 30.00, 100.01, 30.00
		[ 33.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
			 Triggered 6x, delta times: 33.98, 29.99, 100.00, 30.00, 100.01, 30.00
	Casting Eternal Night: 5.0 sec, type=cast, spellId=442277, triggerDeltas = 356.09
		[356.09] SPELL_CAST_START: [Nexus-Princess Ky'veza: Eternal Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 442277, Eternal Night, 0, 0
	Death Masks (%s), type=count, spellId=448364, triggerDeltas = 18.98, 129.98, 129.99
		[ 18.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
			 Triggered 3x, delta times: 18.98, 129.98, 129.99

Special warnings:
	Nether Rift (%s) - dodge attack, type=dodgecount, spellId=437620, triggerDeltas = 21.97, 30.01, 29.97, 70.03, 29.98, 30.00, 70.00, 30.01, 30.00
		[ 21.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
			 Triggered 9x, delta times: 21.97, 30.01, 29.97, 70.03, 29.98, 30.00, 70.00, 30.01, 30.00
	Nexus Daggers (%s) - dodge attack, type=dodgecount, spellId=439576, triggerDeltas = 45.25, 29.98, 100.00, 30.01, 99.97, 30.03
		[ 45.25] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
			 Triggered 6x, delta times: 45.25, 29.98, 100.00, 30.01, 99.97, 30.03

Yells:
	None

Voice pack sounds:
	VoicePack/farfromline
		[ 45.25] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
			 Triggered 6x, delta times: 45.25, 29.98, 100.00, 30.01, 99.97, 30.03
	VoicePack/watchstep
		[ 21.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
			 Triggered 9x, delta times: 21.97, 30.01, 29.97, 70.03, 29.98, 30.00, 70.00, 30.01, 30.00

Icons:
	None

Event trace:
	[  0.00] ENCOUNTER_START: 2920, Nexus-Princess Ky'veza, 16, 20, 0
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 436971 437620 448364 438245 439576 440377 453683 442277 435405, SPELL_AURA_APPLIED 447169 447174 440576, SPELL_AURA_APPLIED_DOSE 447174 440576, SPELL_AURA_REMOVED 447169 435405
		StartTimer: 6.0, Tank Debuff (1)
		StartTimer: 11.3, Assassination (1)
		StartTimer: 22.0, Rift (1)
		StartTimer: 34.0, Massacre (1)
		StartTimer: 45.2, Nexus Daggers (1)
		StartTimer: 96.0, Starless Night (1)
	[  5.96] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 34.0, Tank Debuff (2)
	[ 13.26] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
		ShowAnnounce: Assassination incoming debuff (1)
	[ 18.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
		ShowAnnounce: Death Masks (1)
	[ 21.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (2)
		ShowSpecialWarning: Nether Rift (1) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 33.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Massacre (1)
		StartTimer: 30.0, Massacre (2)
	[ 39.96] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (3)
	[ 45.25] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 46.03, 46.76, 47.5, 48.26, 49
		StartTimer: 30.0, Nexus Daggers (2)
		ShowSpecialWarning: Nexus Daggers (1) - dodge attack
		PlaySound: VoicePack/farfromline
	[ 51.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (3)
		ShowSpecialWarning: Nether Rift (2) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 63.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Massacre (2)
	[ 75.23] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 75.99, 76.74, 77.49, 78.25, 78.99
		ShowSpecialWarning: Nexus Daggers (2) - dodge attack
		PlaySound: VoicePack/farfromline
	[ 81.95] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Nether Rift (3) - dodge attack
		PlaySound: VoicePack/watchstep
	[ 96.09] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
		ShowAnnounce: Starless Night (1)
		StartTimer: 29.0, Starless Night ends
	[125.09] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
		StartTimer: 10.8, Tank Debuff (4)
		StartTimer: 16.0, Assassination (2)
		StartTimer: 26.8, Rift (4)
		StartTimer: 38.8, Massacre (3)
		StartTimer: 50.0, Nexus Daggers (3)
		StartTimer: 100.0, Starless Night (2)
	[135.99] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 34.0, Tank Debuff (2)
	[143.22] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
		ShowAnnounce: Assassination incoming debuff (2)
	[148.96] SPELL_CAST_START: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
		ShowAnnounce: Death Masks (2)
	[151.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (5)
		ShowSpecialWarning: Nether Rift (4) - dodge attack
		PlaySound: VoicePack/watchstep
	[163.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Massacre (3)
		StartTimer: 30.0, Massacre (2)
	[169.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (3)
	[175.23] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 176.01, 176.75, 177.5, 178.24, 178.98
		StartTimer: 30.0, Nexus Daggers (2)
		ShowSpecialWarning: Nexus Daggers (3) - dodge attack
		PlaySound: VoicePack/farfromline
	[181.96] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (6)
		ShowSpecialWarning: Nether Rift (5) - dodge attack
		PlaySound: VoicePack/watchstep
	[193.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Massacre (4)
	[205.24] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 206, 206.75, 207.48, 208.25, 208.99
		ShowSpecialWarning: Nexus Daggers (4) - dodge attack
		PlaySound: VoicePack/farfromline
	[211.96] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Nether Rift (6) - dodge attack
		PlaySound: VoicePack/watchstep
	[226.08] SPELL_CAST_START: [Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 435405, Starless Night, 0, 0
		ShowAnnounce: Starless Night (2)
		StartTimer: 29.0, Starless Night ends
	[255.10] SPELL_AURA_REMOVED: [Nexus-Princess Ky'veza->Nexus-Princess Ky'veza: Starless Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, 435405, Starless Night, 0, BUFF, 0
		StartTimer: 10.8, Tank Debuff (7)
		StartTimer: 16.0, Assassination (3)
		StartTimer: 26.8, Rift (7)
		StartTimer: 38.8, Massacre (5)
		StartTimer: 50.0, Nexus Daggers (5)
		StartTimer: 100.0, Starless Night (3)
	[265.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 34.0, Tank Debuff (2)
	[273.22] SPELL_CAST_START: [Nexus-Princess Ky'veza: Assassination] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 436971, Assassination, 0, 0
		ShowAnnounce: Assassination incoming debuff (3)
	[278.95] SPELL_CAST_START: [Nexus-Princess Ky'veza: Death Masks] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 448364, Death Masks, 0, 0
		ShowAnnounce: Death Masks (3)
	[281.96] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (8)
		ShowSpecialWarning: Nether Rift (7) - dodge attack
		PlaySound: VoicePack/watchstep
	[293.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Massacre (5)
		StartTimer: 30.0, Massacre (2)
	[299.95] SPELL_CAST_START: [Nexus-Princess Ky'veza: Void Shredders] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 440377, Void Shredders, 0, 0
		StartTimer: 30.0, Tank Debuff (3)
	[305.21] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 305.97, 306.72, 307.47, 308.22, 308.97
		StartTimer: 30.0, Nexus Daggers (2)
		ShowSpecialWarning: Nexus Daggers (5) - dodge attack
		PlaySound: VoicePack/farfromline
	[311.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		StartTimer: 30.0, Rift (9)
		ShowSpecialWarning: Nether Rift (8) - dodge attack
		PlaySound: VoicePack/watchstep
	[323.98] SPELL_CAST_START: [Nexus-Princess Ky'veza: Twilight Massacre] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 438245, Twilight Massacre, 0, 0
		ShowAnnounce: Massacre (6)
	[335.24] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nexus Daggers] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 439576, Nexus Daggers, 0, 0
		AntiSpam: 2
			Filtered: 5x SPELL_CAST_START at 335.98, 336.74, 337.48, 338.24, 338.99
		ShowSpecialWarning: Nexus Daggers (6) - dodge attack
		PlaySound: VoicePack/farfromline
	[341.97] SPELL_CAST_START: [Nexus-Princess Ky'veza: Nether Rift] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 437620, Nether Rift, 0, 0
		AntiSpam: 1
		ShowSpecialWarning: Nether Rift (9) - dodge attack
		PlaySound: VoicePack/watchstep
	[356.09] SPELL_CAST_START: [Nexus-Princess Ky'veza: Eternal Night] Creature-0-1-2657-1-217748-0000000001, Nexus-Princess Ky'veza, 0xa48, "", nil, 0x0, 442277, Eternal Night, 0, 0
		ShowAnnounce: Casting Eternal Night: 5.0 sec
	[400.30] ENCOUNTER_END: 2920, Nexus-Princess Ky'veza, 16, 20, 0, 0
		EndCombat: ENCOUNTER_END
	Unknown trigger
		UnregisterEvents: Regular, SPELL_AURA_REMOVED 447169 435405
]]
