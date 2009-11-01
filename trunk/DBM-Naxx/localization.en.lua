local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetWarningLocalization({
	SpecialLocust		= "Locust Swarm",
	WarningLocustSoon	= "Locust Swarm in 15 seconds",
	WarningLocustNow	= "Locust Swarm",
	WarningLocustFaded	= "Locust Swarm faded"
})

L:SetTimerLocalization({
	TimerLocustIn	= "Locust Swarm", 
	TimerLocustFade = "Locust Swarm active"
})

L:SetOptionLocalization({
	SpecialLocust		= "Show special warning for Locust Swarm",
	WarningLocustSoon	= "Show pre-warning for Locust Swarm",
	WarningLocustNow	= "Show warning for Locust Swarm",
	WarningLocustFaded	= "Show warning for Locust Swarm fade",
	TimerLocustIn		= "Show timer for Locust Swarm", 
	TimerLocustFade 	= "Show timer for Locust Swarm fade"
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
	WarningEmbraceExpire	= "Widow's Embrace ends in 5 seconds",
	WarningEmbraceExpired	= "Widow's Embrace faded",
	WarningEnrageSoon		= "Frenzy soon",
	WarningEnrageNow		= "Frenzy"
})

L:SetTimerLocalization({
	TimerEmbrace	= "Widow's Embrace active",
	TimerEnrage		= "Frenzy"
})

L:SetOptionLocalization({
	TimerEmbrace			= "Show timer for Widow's Embrace",
	WarningEmbraceActive	= "Show warning for Widow's Embrace",
	WarningEmbraceExpire	= "Show warning when Widow's Embrace expires",
	WarningEmbraceExpired	= "Show warning when Widow's Embrace is about to expire",
	WarningEnrageSoon		= "Show pre-warning for Frenzy",
	WarningEnrageNow		= "Show warning for Frenzy",
	TimerEnrage				= "Show timer for Frenzy"
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
	WarningWebSpraySoon	= "Web Spray in 5 seconds",
	WarningWebSprayNow	= "Web Spray",
	WarningSpidersSoon	= "Maexxna Spiderlings in 5 seconds",
	WarningSpidersNow	= "Maexxna Spiderlings spawned"
})

L:SetTimerLocalization({
	TimerWebSpray	= "Web Spray",
	TimerSpider		= "Maexxna Spiderlings"
})

L:SetOptionLocalization({
	WarningWebWrap		= "Announce Web Wrap targets",
	WarningWebSpraySoon	= "Show pre-warning for Web Spray",
	WarningWebSprayNow	= "Show warning for Web Spray",
	WarningSpidersSoon	= "Show pre-warning for Maexxna Spiderlings",
	WarningSpidersNow	= "Show warning for Maexxna Spiderlings",
	TimerWebSpray		= "Show timer for Web Spray",
	TimerSpider			= "Show timer for Maexxna Spiderlings"
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
	WarningTeleportNow	= "Teleported",
	WarningTeleportSoon	= "Teleport in 20 seconds",
	WarningCurse		= "Curse"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
	TimerTeleportBack	= "Teleport back"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Show warning for Teleport",
	WarningTeleportSoon		= "Show pre-warning for Teleport",
	WarningCurse			= "Show warning for Curse of the Plaguebringer",
	TimerTeleport			= "Show timer for Teleport",
	TimerTeleportBack		= "Show timer for Teleport back"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan the Unclean"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleported",
	WarningTeleportSoon	= "Teleport in %d seconds",
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Show warning for Teleport",
	WarningTeleportSoon		= "Show pre-warning for Teleport",
	WarningCurse			= "Show warning for Curse",
	TimerTeleport			= "Show timer for Teleport",
	TimerTeleportBack		= "Show timer for Teleport back"
})


---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningSporeNow		= "Spore spawned",
	WarningSporeSoon	= "Spore in 5 seconds",
	WarningDoomNow		= "Inevitable Doom #%d",
	WarningHealSoon		= "Healing possible in 3 seconds",
	WarningHealNow		= "Heal now"
})

L:SetTimerLocalization({
	TimerDoom			= "Inevitable Doom #%d",
	TimerSpore			= "Next Spore",
	TimerAura			= "Necrotic Aura"
})

L:SetOptionLocalization({
	WarningSporeNow		= "Show warning for Spore",
	WarningSporeSoon	= "Show pre-warning for Spore",
	WarningDoomNow		= "Show warning for Inevitable Doom",
	WarningHealSoon		= "Show pre-warning for \"Heal in 3 seconds\"",
	WarningHealNow		= "Show warning for \"Heal now\"",
	TimerDoom			= "Show timer for Inevitable Doom",
	TimerSpore			= "Show timer for Spore",
	TimerAura			= "Show timer for Necrotic Aura"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Patchwerk"
})

L:SetOptionLocalization({
	WarningHateful = "Announce Hateful Strikes to raid chat\n(requires announce to be enabled and leader/promoted status)"
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
	WarningInjection		= "Show warning for Mutating Injection",
	SpecialWarningInjection	= "Show special warning when you are affected by Mutating Injection"
})

L:SetWarningLocalization({
	WarningInjection		= "Mutating Injection: >%s<",
	SpecialWarningInjection	= "Mutating Injection on you"
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
	WarningDecimateNow	= "Show warning for Decimate",
	WarningDecimateSoon	= "Show pre-warning for Decimate",
	TimerDecimate		= "Show timer for Decimate"
})

L:SetWarningLocalization({
	WarningDecimateNow	= "Decimate",
	WarningDecimateSoon	= "Decimate in 10 seconds"
})

L:SetTimerLocalization({
	TimerDecimate		= "Decimate cooldown"
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
	Boss1	= "Feugen",
	Boss2	= "Stalagg",
	Charge1 = "negative",
	Charge2 = "positive",
})

L:SetOptionLocalization({
	WarningShiftCasting		= "Show warning for Polarity Shift",
	WarningChargeChanged	= "Show special warning when your polarity changed",
	WarningChargeNotChanged	= "Show special warning when your polarity did not change",
	TimerShiftCast			= "Show timer for Polarity Shift cast",
	TimerNextShift			= "Show timer for Polarity Shift cooldown",
	ArrowsEnabled			= "Show arrows (normal \"2 camp\" strategy)",
	ArrowsRightLeft			= "Show left/right arrows for the \"4 camp\" strategy (show left arrow if polarity changed, right if not)",
	ArrowsInverse			= "Inverse \"4 camp\" strategy (show right arrow if polarity changed, left if not)",
	WarningThrow			= "Show warning for tank throw",
	WarningThrowSoon		= "Show pre-warning for tank throw",
	TimerThrow				= "Show timer for tank throw"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "Polarity Shift in 3 seconds",
	WarningChargeChanged	= "Polarity changed to %s",
	WarningChargeNotChanged	= "Polarity did not change",
	WarningThrow			= "Tank throw",
	WarningThrowSoon		= "Tank throw in 3 seconds"
})

L:SetTimerLocalization({
	TimerShiftCast			= "Polarity Shift cast",
	TimerNextShift			= "Next Polarity Shift",
	TimerThrow				= "Tank throw"
})

L:SetOptionCatLocalization({
	Arrows	= "Arrows",
})


----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Instructor Razuvious"
})

L:SetMiscLocalization({
	Yell1 = "Show them no mercy!",
	Yell2 = "The time for practice is over! Show me what you have learned!",
	Yell3 = "Do as I taught you!",
	Yell4 = "Sweep the leg... Do you have a problem with that?"
})

L:SetOptionLocalization({
	WarningShoutNow			= "Show warning for Disrupting Shout",
	WarningShoutSoon		= "Show pre-warning for Disrupting Shout",
	TimerShout				= "Show timer for Disrupting Shout",
	WarningShieldWallSoon	= "Show pre-warning for Shield Wall expiration",
	TimerShieldWall			= "Show timer for Shield Wall",
	TimerTaunt				= "Show timer for Taunt"
})

L:SetWarningLocalization({
	WarningShoutNow			= "Disrupting Shout",
	WarningShoutSoon		= "Disrupting Shout in 5 seconds",
	WarningShieldWallSoon	= "Shield Wall expires in 5 seconds"
})

L:SetTimerLocalization({
	TimerShout			= "Disrupting Shout",
	TimerTaunt			= "Taunt",
	TimerShieldWall		= "Shield Wall"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Gothik the Harvester"
})

L:SetOptionLocalization({
	TimerWave			= "Show timer for wave",
	TimerPhase2			= "Show timer for Phase 2",
	WarningWaveSoon		= "Show pre-warning for wave",
	WarningWaveSpawned	= "Show warning for wave spawned",
	WarningRiderDown	= "Show warning when an Unrelenting Rider dies",
	WarningKnightDown	= "Show warning when an Unrelenting Death Knight dies",
	WarningPhase2		= "Show warning for Phase 2"
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
})


---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Four Horsemen"
})

L:SetOptionLocalization({
	TimerMark					= "Show timer for Mark",
	WarningMarkSoon				= "Show pre-warning for Mark",
	WarningMarkNow				= "Show warning for Mark",
	SpecialWarningMarkOnPlayer	= "Show special warning when you have >4 marks on you"
})

L:SetTimerLocalization({
	TimerMark = "Mark %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Mark %d in 3 seconds",
	WarningMarkNow				= "Mark %d",
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
	WarningDrainLifeNow		= "Show warning for Life Drain",
	WarningDrainLifeSoon	= "Show pre-warning for Life Drain",
	WarningAirPhaseSoon		= "Show pre-warning for air phase",
	WarningAirPhaseNow		= "Show warning for air phase",
	WarningLanded			= "Show warning for ground phase",
	TimerDrainLifeCD		= "Show timer for Life Drain",
	TimerAir				= "Show timer for air phase",
	TimerLanding			= "Show timer for landing",
	TimerIceBlast			= "Show timer for Frost Breath",
	WarningDeepBreath		= "Show special warning for Frost Breath",
	WarningIceblock			= "Yell on Ice Block"
})

L:SetMiscLocalization({
	EmoteBreath				= "%s takes a deep breath.",
	WarningYellIceblock		= "I'm an Ice Block!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "Life Drain",
	WarningDrainLifeSoon	= "Life Drain soon",
	WarningAirPhaseSoon		= "Air phase in 10 seconds",
	WarningAirPhaseNow		= "Air phase",
	WarningLanded			= "Sapphiron landed",
	WarningDeepBreath		= "Frost Breath"
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "Life Drain cooldown",
	TimerAir				= "Air phase",
	TimerLanding			= "Landing in",
	TimerIceBlast			= "Frost Breath"	
})

------------------
--  Kel'Thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetOptionLocalization({
	BlastTimer				= "Show timer for Frost Blast (4 second timer until targets die)",
	TimerPhase2				= "Show timer for Phase 2",
	WarningBlastTargets		= "Announce Frost Blast targets",
	WarningPhase2			= "Show warning for Phase 2",
	WarningFissure			= "Show warning for Shadow Fissure",
	WarningMana				= "Show warning for Detonate Mana",
	WarningChainsTargets	= "Announce Chains of Kel'Thuzad targets",
	specwarnP2Soon			= "Show special warning 10 seconds before Kel'Thuzad engages",
	ShowRange				= "Show range frame when Phase 2 starts",
})

L:SetMiscLocalization({
	Yell = "Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!"
})

L:SetWarningLocalization({
	WarningBlastTargets		= "Frost Blast: >%s<",
	WarningPhase2			= "Phase 2",
	WarningFissure			= "Shadow Fissure spawned",
	WarningMana				= "Detonate Mana: >%s<",
	WarningChainsTargets	= "Chains of Kel'Thuzad: >%s<",
	specwarnP2Soon			= "Kel'Thuzad engages in 10 Seconds"
})

L:SetTimerLocalization({
	TimerPhase2			= "Phase 2",
	BlastTimer			= "Heal now"
})



