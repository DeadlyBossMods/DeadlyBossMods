local L

---------------------------
--  Eranog --
---------------------------
--L= DBM:GetModLocalization(2480)

--L:SetWarningLocalization({
--})
--
--L:SetTimerLocalization{
--}
--
--L:SetOptionLocalization({
--})
--
--L:SetMiscLocalization({
--})

---------------------------
--  Terros --
---------------------------
--L= DBM:GetModLocalization(2500)

---------------------------
--  The Primalist Council --
---------------------------
--L= DBM:GetModLocalization(2486)

---------------------------
--  Sennarth, The Cold Breath --
---------------------------
--L= DBM:GetModLocalization(2482)

---------------------------
--  Dathea, Ascended --
---------------------------
--L= DBM:GetModLocalization(2502)

---------------------------
--  Kurog Grimtotem --
---------------------------
L= DBM:GetModLocalization(2491)

L:SetTimerLocalization({
	timerDamageCD = "Damage (%s)",
	timerAvoidCD = "Avoid (%s)",
	timerUltimateCD = "Ultimate (%s)",
	timerAddEnrageCD = "Enrage (%s)"
})

L:SetOptionLocalization({
	timerDamageCD = "Show timers for targeted damage attacks: $spell:382563, $spell:373678, $spell:391055, $spell:373487",
	timerAvoidCD = "Show timers for avoidable attacks: $spell:373329, $spell:391019, $spell:395893, $spell:390920",
	timerUltimateCD = "Show timers for 100 energy ultimate attacks: $spell:374022, $spell:372456, $spell:374691, $spell:374215",
	timerAddEnrageCD = "Show timers for enrage on Mythic only difficulty adds"
})

L:SetMiscLocalization({
	Fire	= "Fire",
	Frost	= "Frost",
	Earth	= "Earth",
	Storm	= "Storm"
})

---------------------------
--  Broodkeeper Diurna --
---------------------------
L= DBM:GetModLocalization(2493)

L:SetMiscLocalization({
	staff	= "Staff",
	eStaff	= "Empowered Staff"
})

---------------------------
--  Raszageth the Storm-Eater --
---------------------------
L= DBM:GetModLocalization(2499)

L:SetOptionLocalization({
	SetBreathToBait = "Adjust breath timers during intermissions to expire based on bait timing instead of cast timing (Alerts will still fire on breath cast)"
})

L:SetMiscLocalization({
	negative 	= "negative",
	positive 	= "positive",
	BreathEmote	= "Raszageth takes a deep breath..."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("VaultoftheIncarnatesTrash")

L:SetGeneralLocalization({
	name =	"VotI Trash"
})

---------------------------
--  Kazzara --
---------------------------
--L= DBM:GetModLocalization(2522)

---------------------------
--  The Amalgamation Chamber --
---------------------------
L= DBM:GetModLocalization(2529)

L:SetOptionLocalization({
	AdvancedBossFiltering	= "Actively scan distance to each of bosses in stage 1 and automatically hide certain alerts and fade timers for the boss you are NOT near (more than 43 distance)"
})

---------------------------
--  The Forgotten Experiments --
---------------------------
L= DBM:GetModLocalization(2530)

L:SetMiscLocalization({
	SafeClear		= "Safe Clear"
})

---------------------------
--  Assault of the Zaqali --
---------------------------
L= DBM:GetModLocalization(2524)

L:SetTimerLocalization{
	timerGuardsandHuntsmanCD	= "Big Adds (%s)"
}

L:SetOptionLocalization({
	timerGuardsandHuntsmanCD	= "Show timers for new Huntsman or Guards climbing the walls"
})

L:SetMiscLocalization({
	northWall		= "Commanders ascend the northern battlement!",
	southWall		= "Commanders ascend the southern battlement!"
})

---------------------------
--  Rashok --
---------------------------
L= DBM:GetModLocalization(2525)

L:SetOptionLocalization({
	TankSwapBehavior	= "Set mod behavior for tank swaps",
	OnlyIfDanger		= "Shows taunt warning only if other tank is about to take unsafe hit",
	MinMaxSoak			= "Shows taunt warning after a combos first attack, or if other tank is about to take unsafe hit",
	DoubleSoak			= "Shows taunt warning after a combo has ended, or if other tank is about to take unsafe hit"--Default
})

L:SetMiscLocalization({
	pool		= "{rt%d}Pool %d",--<icon> Pool 1,2,3
	soakpool	= "Soak Pool"
})

---------------------------
--  The Vigilant Steward, Zskarn --
---------------------------
--L= DBM:GetModLocalization(2532)

---------------------------
--  Magmorax --
---------------------------
L= DBM:GetModLocalization(2527)

L:SetMiscLocalization({
	pool		= "{rt%d}Pool %d",--<icon> Pool 1,2,3
	soakpool	= "Soak Pool"
})

---------------------------
--  Echo of Neltharion --
---------------------------
L= DBM:GetModLocalization(2523)

L:SetMiscLocalization({
	WallBreaker	= "Wall Breaker"
})

---------------------------
--  Scalecommander Sarkareth --
---------------------------
L= DBM:GetModLocalization(2520)

L:SetOptionLocalization({
	InfoFrameBehaviorTwo	= "Set mod behavior for infoframe stack tracking",
	OblivionOnly			= "Only show Oblivion stacks (stages 1 2 and 3)",--Default
	HowlOnly				= "Only show Oppressing Howl stacks (stage 1, closes otherwise)",
	Hybrid					= "Show Oppressing Howl stacks in stage 1 and Oblivion stacks in stages 2 and 3"
})

L:SetMiscLocalization({
	EarlyStaging			= "Stage terminated early by health threshold"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AberrusTrash")

L:SetGeneralLocalization({
	name =	"Aberrus Trash"
})

---------------------------
--  Amirdrassil, the Dream's Hope --
---------------------------
---------------------------
--  Gnarlroot --
---------------------------
--L= DBM:GetModLocalization(2564)

---------------------------
--  Igira the Cruel --
---------------------------
--L= DBM:GetModLocalization(2554)

---------------------------
--  Volcoross --
---------------------------
L= DBM:GetModLocalization(2557)

L:SetMiscLocalization({
	DebuffSoaks			= "Debuff Soaks (%s)"--Might be common localized later
})

---------------------------
--  Council of Dreams --
---------------------------
L= DBM:GetModLocalization(2555)

L:SetMiscLocalization({
	Ducks		= "Ducks (%s)"
})

---------------------------
--  Larodar, Keeper of the Flame --
---------------------------
L= DBM:GetModLocalization(2553)

L:SetMiscLocalization({
	currentHealth		= "%d%%",
	currentHealthIcon	= "{rt%d}%d%%",
	Roots				= "Roots (%s)",
	HealAbsorb			= "Heal Absorb (%s)"--Might be common localized later
})

---------------------------
--  Nymue, Weaver of the Cycle --
---------------------------
L= DBM:GetModLocalization(2556)

L:SetMiscLocalization({
	Threads			= "Threads (%s)"
})

---------------------------
--  Smolderon --
---------------------------
--L= DBM:GetModLocalization(2563)

---------------------------
--  Tindral Sageswift, Seer of the Flame --
---------------------------
L= DBM:GetModLocalization(2565)

L:SetMiscLocalization({
	TreeForm			= "Tree Form",
	MoonkinForm			= "Moonkin Form",
	Feathers			= "Feathers"
})

---------------------------
--  Fyrakk the Blazing --
---------------------------
L= DBM:GetModLocalization(2519)

L:SetTimerLocalization{
	timerMythicDebuffs			= "Cages (%s)"
}

L:SetWarningLocalization{
	warnMythicDebuffs			= "Cages (%s)"
}

L:SetOptionLocalization{
	warnMythicDebuffs			= "Announce when $spell:428988 and $spell:428970 debuffs have been cast (with count)",
	timerMythicDebuffs			= "Show timer (with count) for $spell:428988 and $spell:428970 debuffs"
}

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AmirdrassilTrash")

L:SetGeneralLocalization({
	name =	"Amirdrassil Trash"
})

L:SetMiscLocalization({
	FyrakkRP			= "You again. A pity I do not have time to eradicate you myself."
})
