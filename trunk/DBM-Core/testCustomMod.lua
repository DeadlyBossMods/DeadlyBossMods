DBM_TEST_CUSTOM_MOD = {
	name = "testMod (Hogger)",
	revision = 15,
	enrage = 300,
	combatDetection = "yell",
--	combatDetection = "combat",
	combatTrigger = "blah test",
--	combatTrigger = 12345,
	killMobs = {
		12345
	},
	triggers = {
		{
			type = "CHAT_MSG_MONSTER_YELL",
			trigger = "test yell",
			barTimer = 10,
			barText = "test yell1 bar",
			--warning
		},
--		...
	},
}
