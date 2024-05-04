
DBM.Test:DefineTest{
	name = "SoD/ST/Atalarion",
	addon = "DBM-Raids-Vanilla",
	mod = "AtalalarionSoD",
	instanceInfo = {name = "", instanceType = "party", difficultyID = 215, difficultyName = "Normal", maxPlayers = 20, dynamicDifficulty = 0, instanceID = 109, instanceGroupSize = 20},
	playerName = "Tandanu",
	-- FIXME: this example is just written by hand, we need an importer from transcriptor events
	-- FIXME: this will likely end up hitting the 65k constant limit, maybe just put raw transcriptor or a single raw string in here?
	log = {
		{0, "ENCOUNTER_START", 2952, "Atal'alarion", 215, 20},
		{0, "PLAYER_REGEN_DISABLED"},
		{1, "COMBAT_LOG_EVENT_UNFILTERED", 1, "SPELL_CAST_START", false, "Creature-0-5250-109-7069-218624-0000143F40", "Atal'alarion", 0, 0, "", nil, 0, 0, 437597, "Demolishing Smash"},
		{5, "COMBAT_LOG_EVENT_UNFILTERED", 10, "SPELL_CAST_START", false, "Creature-0-5250-109-7069-218624-0000143F40", "Atal'alarion", 0, 0, "", nil, 0, 0, 437503, "Pillars of Might"},
		{10, "ENCOUNTER_END", 2952, "Atal'alarion", 215, 20, 1},
		{10, "BOSS_KILL", 2952, "Atal'alarion"},
		{10.1, "PLAYER_REGEN_ENABLED"},
	}
}
