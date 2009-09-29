local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetWarningLocalization({
	SpecialLocust		= "Locust Swarm!",
	WarningLocustSoon	= "Locust Swarm in 15 sec",
	WarningLocustNow	= "Locust Swarm!",
	WarningLocustFaded	= "Locust Swarm faded"
})

L:SetTimerLocalization({
	TimerLocustIn	= "Locust Swarm", 
	TimerLocustFade = "Locust Swarm active"
})

L:SetOptionLocalization({
	SpecialLocust		= "Show special warning for Locust Swarm",
	WarningLocustSoon	= "Show Locust Swarm pre-warning",
	WarningLocustNow	= "Show Locust Swarm warning",
	WarningLocustFaded	= "Show Locust Swarm fade warning",
	TimerLocustIn		= "Show Locust Swarm timer", 
	TimerLocustFade 	= "Show Locust Swarm fade timer"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Grand Widow Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceActive	= "Widow's Embrace active",
	WarningEmbraceExpire	= "Widow's Embrace ends in 5 sec",
	WarningEmbraceExpired	= "Widow's Embrace faded",
	WarningEnrageSoon		= "Enrage soon",
	WarningEnrageNow		= "Enrage!"
})

L:SetTimerLocalization({
	TimerEmbrace	= "Embrace active",
	TimerEnrage		= "Enrage",
})

L:SetOptionLocalization({
	TimerEmbrace			= "Show Embrace timer",
	WarningEmbraceActive	= "Show Widow's Embrace warning",
	WarningEmbraceExpire	= "Show warning when Widow's Embrace expires",
	WarningEmbraceExpired	= "Show warning when Widow's Embrace is about to expire"
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Maexxna"
})

L:SetWarningLocalization({
	WarningWebWrap		= "Web Wrap: >%s<",
	WarningWebSpraySoon	= "Web Spray in 5 sec",
	WarningWebSprayNow	= "Web Spray!",
	WarningSpidersSoon	= "Spiders in 5 sec",
	WarningSpidersNow	= "Spiders spawned!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "Web Spray",
	TimerSpider		= "Spiders"
})

L:SetOptionLocalization({
	WarningWebWrap		= "Announce Web Wrap targets",
	WarningWebSpraySoon	= "Show Web Spray pre-warning",
	WarningWebSprayNow	= "Show Web Spray warning",
	WarningSpidersSoon	= "Show Spider pre-warning",
	WarningSpidersNow	= "Show Spider warning",
	TimerWebSpray		= "Show Web Spray timer",
	TimerSpider			= "Show Spider timer"
})

L:SetMiscLocalization({
	YellWebWrap			= "I'm wrapped! Help me!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth the Plaguebringer"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleported!",
	WarningTeleportSoon	= "Teleport in 20 sec",
	WarningCurse		= "Curse!"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
	TimerTeleportBack	= "Teleport back"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Show Teleport warning",
	WarningTeleportSoon		= "Show Teleport pre-warning",
	WarningCurse			= "Show Curse warning",
	TimerTeleport			= "Show Teleport timer",
	TimerTeleportBack		= "Show Teleport back timer"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan the Unclean"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleported!",
	WarningTeleportSoon	= "Teleport in %d sec",
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Show Teleport warning",
	WarningTeleportSoon		= "Show Teleport pre-warning",
	WarningCurse			= "Show Curse warning",
	TimerTeleport			= "Show Teleport timer",
	TimerTeleportBack		= "Show Teleport back timer"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningSporeNow		= "Spore spawned!",
	WarningSporeSoon	= "Spore in 5 sec",
	WarningDoomNow		= "Doom #%d",
	WarningHealSoon		= "Healing possible in 3 sec",
	WarningHealNow		= "Heal now!"
})

L:SetTimerLocalization({
	TimerDoom			= "Doom #%d",
	TimerSpore			= "Next Spore",
	TimerAura			= "Necrotic Aura"
})

L:SetOptionLocalization({
	WarningSporeNow		= "Show Spore warning",
	WarningSporeSoon	= "Show Spore pre-warning",
	WarningDoomNow		= "Show Doom warning",
	WarningHealSoon		= "Show \"Heal in 3 sec\" pre-warning",
	WarningHealNow		= "Show \"Heal now\" warning",
	TimerDoom			= "Show Doom timer",
	TimerSpore			= "Show Spore timer",
	TimerAura			= "Show Necrotic Aura timer"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Patchwerk"
})

L:SetOptionLocalization({
	WarningHateful = "Announce Hateful Strikes to raid chat\n(you must be promoted or raid leader to use this)"
})

L:SetMiscLocalization({
	yell1 = "Patchwerk want to play!",
	yell2 = "Kel'thuzad make Patchwerk his avatar of war!",
	HatefulStrike = "Hateful Strike --> %s [%s]"
})


-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "Grobbulus"
})

L:SetOptionLocalization({
	WarningInjection		= "Show Mutating Injection warning",
	SpecialWarningInjection	= "Show special warning when you are afflicted by Mutating Injection"
})

L:SetWarningLocalization({
	WarningInjection		= "Mutating Injection: >%s<",
	SpecialWarningInjection	= "Mutating Injection on you!"
})

L:SetTimerLocalization({
})


-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Gluth"
})

L:SetOptionLocalization({
	WarningDecimateNow	= "Show Decimate warning",
	WarningDecimateSoon	= "Show Decimate pre-warning",
	TimerDecimate		= "Show Decimate timer"
})

L:SetWarningLocalization({
	WarningDecimateNow	= "Decimate!",
	WarningDecimateSoon	= "Decimate in 10 sec"
})

L:SetTimerLocalization({
	TimerDecimate		= "Decimate Cooldown"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetMiscLocalization({
	Yell	= "Stalagg crush you!",
	Emote	= "%s overloads!", -- ?
	Emote2	= "Tesla Coil overloads!", -- ?
	Boss1 = "Feugen",
	Boss2 = "Stalagg",
	Charge1 = "negative",
	Charge2 = "positive",
})

L:SetOptionLocalization({
	WarningShiftCasting		= "Show Polarity Shift warning",
	WarningChargeChanged	= "Show special warning when your polarity changed",
	WarningChargeNotChanged	= "Show special warning when your polarity did not change",
	TimerShiftCast			= "Show Polarity Shift cast timer",
	TimerNextShift			= "Show Polarity Shift cooldown timer",
	ArrowsEnabled			= "Show arrows (normal \"2 camp\" strategy)",
	ArrowsRightLeft			= "Show right/left arrows for the \"4 camp\" strategy (show left arrow if polarity changed, right if not)",
	ArrowsInverse			= "Inverse \"4 camp\" strategy (show right arrow if polarity changed, left if not)",
	WarningThrow			= "Show Tank-throw warning",
	WarningThrowSoon		= "Show Tank-throw pre-warning",
	TimerThrow				= "Show Tank-throw timer"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "Polarity Shift in 3 sec!",
	WarningChargeChanged	= "Polarity changed to %s",
	WarningChargeNotChanged	= "Polarity didn't change",
	WarningThrow			= "Tank-throw!",
	WarningThrowSoon		= "Tank-throw in 3 sec"
})

L:SetTimerLocalization({
	TimerShiftCast			= "Polarity Shift Cast",
	TimerNextShift			= "Next Polarity Shift",
	TimerThrow				= "Tank-throw"
})

L:SetOptionCatLocalization({
	Arrows	= "Arrows",
})


-----------------
--  Razuvious  --
-----------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Razuvious"
})

L:SetMiscLocalization({
	Yell1 = "Show them no mercy!",
	Yell2 = "The time for practice is over! Show me what you have learned!",
	Yell3 = "Do as I taught you!",
	Yell4 = "Sweep the leg... Do you have a problem with that?"
})

L:SetOptionLocalization({
	WarningShoutNow			= "Show Disrupting Shout warning",
	WarningShoutSoon		= "Show Disrupting Shout pre-warning",
	TimerShout				= "Show Disrupting Shout timer",
	WarningShieldWallSoon	= "Show Shield Wall expore warning",
	TimerShieldWall			= "Show Shield Wall timer",
	TimerTaunt				= "Show Taunt timer"
})

L:SetWarningLocalization({
	WarningShoutNow			= "Disrupting Shout!",
	WarningShoutSoon		= "Disrupting Shout in 5 sec",
	WarningShieldWallSoon	= "Shield Wall expires in 5 sec"
})

L:SetTimerLocalization({
	TimerShout			= "Disrupting Shout",
	TimerTaunt			= "Taunt",
	TimerShieldWall		= "Shield Wall"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik"
})

L:SetOptionLocalization({
	TimerWave			= "Show Wave timer",
	TimerPhase2			= "Show Phase 2 timer",
	WarningWaveSoon		= "Show Wave pre-warning",
	WarningWaveSpawned	= "Show Wave spawned warning",
	WarningRiderDown	= "Show warning when a Rider dies",
	WarningKnightDown	= "Show warning when a Knight dies",
	WarningPhase2		= "Show Phase 2 warning"
})

L:SetTimerLocalization({
	TimerWave	= "Wave #%d",
	TimerPhase2	= "Phase 2"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Wave %d: %s in 3 sec",
	WarningWaveSpawned	= "Wave %d: %s spawned",
	WarningRiderDown	= "Rider down",
	WarningKnightDown	= "Knight down",
	WarningPhase2		= "Phase 2"
})

L:SetMiscLocalization({
	yell			= "Foolishly you have sought your own demise.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s and %d %s",
	WarningWave3	= "%d %s, %d %s and %d %s",
	Trainee			= "Trainees",
	Knight			= "Knights",
	Rider			= "Riders",
--	Trainee			= "|4Trainee:Trainees;",
--	Knight			= "|4Knight:Knights;",
--	Rider			= "|4Rider:Riders;",
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Four Horsemen"
})

L:SetOptionLocalization({
	TimerMark					= "Show Mark timer",
	WarningMarkSoon				= "Show Mark pre-warning",
	WarningMarkNow				= "Show Mark warning",
	SpecialWarningMarkOnPlayer	= "Show special warning when you have > 4 marks on you"
})

L:SetTimerLocalization({
	TimerMark = "Mark %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Mark %d in 3 sec",
	WarningMarkNow				= "Mark %d!",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz	= "Thane Korth'azz",
	Rivendare	= "Baron Rivendare",
	Blaumeux	= "Lady Blaumeux",
	Zeliek		= "Sir Zeliek",
})


-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Sapphiron"
})

L:SetOptionLocalization({
	WarningDrainLifeNow		= "Show Drain Life warning",
	WarningDrainLifeSoon	= "Show Drain Life pre-warning",
	WarningAirPhaseSoon		= "Show Air Phase pre-warning",
	WarningAirPhaseNow		= "Show Air Phase warning",
	WarningLanded			= "Show Ground Phase warning",
	TimerDrainLifeCD		= "Show Drain Life timer",
	TimerAir				= "Show Air Phase timer",
	TimerLanding			= "Show Landing in timer",
	TimerIceBlast			= "Show Deep Breath timer",
	WarningDeepBreath		= "Show Deep Breath special warning"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s takes a deep breath.",
	WarningYellIceblock	= "I'm an Ice Block!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "Drain Life!",
	WarningDrainLifeSoon	= "Drain Life soon",
	WarningAirPhaseSoon		= "Air Phase in 10 sec",
	WarningAirPhaseNow		= "Air Phase",
	WarningLanded			= "Sapphiron landed",
	WarningDeepBreath		= "Deep Breath!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "Drain Life CD",
	TimerAir				= "Air Phase",
	TimerLanding			= "Landing in",
	TimerIceBlast			= "Deep Breath"	
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetOptionLocalization({
	TimerPhase2			= "Show Phase 2 timer",
	WarningBlastTargets	= "Show Frost Blast warning",
	WarningPhase2		= "Show Phase 2 warning",
	WarningFissure		= "Show Shadow Fissure warning",
	WarningMana			= "Show Detonate warning",
	WarningChainsTargets= "Show Chains of Kel'Thuzad Warning"
})

L:SetMiscLocalization({
	Yell = "Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!"
})

L:SetWarningLocalization({
	WarningBlastTargets	= "Frost Blast: >%s<",
	WarningPhase2		= "Phase 2",
	WarningFissure		= "Shadow Fissure spawned",
	WarningMana			= "Detonate Mana: >%s<",
	WarningChainsTargets= "Chains of Kel'Thuzad: >%s<"
})

L:SetTimerLocalization({
	TimerPhase2			= "Phase 2"
})



