DBM.Test:Report[[
Test: SoD/ST/Atalarion
Mod:  DBM-Raids-Vanilla/AtalalarionSoD

Registered but untriggered events:
	NYI

Unused objects:
	None

Timers:
	Pillars of Might (%s), time=12.20, type=cdcount, spellId=437503
		[0.00] ENCOUNTER_START: 2952, Atal'alarion, 215, 20
		[5.00] CLEU - SPELL_CAST_START: Creature-0-5250-109-7069-218624-0000143F40, Atal'alarion, 0, 0, , nil, 0, 0, 437503, Pillars of Might
	Demolishing Smash (%s), time=27.10, type=cdcount, spellId=437597
		[0.00] ENCOUNTER_START: 2952, Atal'alarion, 215, 20
		[1.00] CLEU - SPELL_CAST_START: Creature-0-5250-109-7069-218624-0000143F40, Atal'alarion, 0, 0, , nil, 0, 0, 437597, Demolishing Smash

Announces:
	Pillars of Might (%s), type=count, spellId=437503
		[5.00] CLEU - SPELL_CAST_START: Creature-0-5250-109-7069-218624-0000143F40, Atal'alarion, 0, 0, , nil, 0, 0, 437503, Pillars of Might

SpecialWarnings:
	NYI

Yells:
	NYI

Event trace:
	 [0.00] ADDON_LOADED: DBM-Raids-Vanilla
		NewMod: AtalalarionSoD, DBM-Raids-Vanilla
		RegisterEvents: InCombat, SPELL_CAST_START 437503 437597
	 [0.00] ENCOUNTER_START: 2952, Atal'alarion, 215, 20
		StartCombat: ENCOUNTER_START
		RegisterEvents: Regular, SPELL_CAST_START 437503 437597
		AntiSpam: FLASH, true
		StartTimer: 4.8, Pillars of Might (1)
		StartTimer: 21.3, Demolishing Smash (1)
	 [1.00] CLEU - SPELL_CAST_START: Creature-0-5250-109-7069-218624-0000143F40, Atal'alarion, 0, 0, , nil, 0, 0, 437597, Demolishing Smash
		ShowSpecialWarning: Demolishing Smash! (1)
		PlaySound: VoicePack/carefly
		StartTimer: 27.1, Demolishing Smash (2)
	 Unknown trigger
		PlaySound: VoicePack/movetopillar
	 [5.00] CLEU - SPELL_CAST_START: Creature-0-5250-109-7069-218624-0000143F40, Atal'alarion, 0, 0, , nil, 0, 0, 437503, Pillars of Might
		ShowAnnounce: Pillars of Might (1)
		PlaySound: 566558
		StartTimer: 12.2, Pillars of Might (2)
	 [10.00] ENCOUNTER_END: 2952, Atal'alarion, 215, 20, 1
		StopTimer: Timer437503cdcount	2
		StopTimer: Timer437597cdcount	2
		PlaySound: Interface\AddOns\DBM-Core\sounds\Victory\SmoothMcGroove_Fanfare.ogg
		AntiSpam: EE, true
]]
