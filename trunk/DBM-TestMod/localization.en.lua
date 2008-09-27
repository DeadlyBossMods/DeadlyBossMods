local L

L = DBM:GetModLocalization("The Test Mod")

L:SetGeneralLocalization({
	name = "Hogger"
})

L:SetWarningLocalization({
	shield_applied	= "Shield on >%s<",
	shield_expire	= "Shield was casted 3 sec ago",
	shield_expire2	= ">%s< casted %s 6 sec ago",
	shield_removed	= "Shield removed",
})

L:SetTimerLocalization({
	shield_timer	= "Shield: %s",
	ultimateTestTimer = "Test %s lol %s 123 %s ..."
})

L:SetOptionLocalization({
	shield_applied	= "shield_applied (localized)",
	shield_expire	= "shield_expire (localized)",
	testoption		= "testoption (localized)",
	shield_removed	= "shield_removed (localized)",
	shield_timer	= "test (localized)"
})

L:SetMiscLocalization({
	test1 = "Localized test1",
	test2 = "Localized test2",
})






local L

L = DBM:GetModLocalization("The Test Mod")

L:SetWarningLocalization({
	shield_applied	= "Schild auf %s",
	shield_removed	= "Schild entfernt",
})
