if GetLocale() ~= "deDE" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Anub'Rekhan"
})

L:SetWarningLocalization({
	SpecialLocust		= "Heuschreckenschwarm!",
	WarningLocustSoon	= "Heuschreckenschwarm in 15 Sek",
	WarningLocustNow	= "Heuschreckenschwarm!",
	WarningLocustFaded	= "Heuschreckenschwarm ausgelaufen"
})

L:SetTimerLocalization({
	TimerLocustIn	= "Heuschreckenschwarm", 
	TimerLocustFade = "Heuschreckenschwarm aktiv"
})

L:SetOptionLocalization({
	SpecialLocust		= "Spezialwarnung für Heuschreckenschwarm",
	WarningLocustSoon	= "Vorwarnung für Heuschreckenschwarm anzeigen",
	WarningLocustNow	= "Warnung für Heuschreckenschwarm anzeigen",
	WarningLocustFaded	= "Warnung wenn Heuschreckenschwarm ausläuft",
	TimerLocustIn		= "Timer für Heuschreckenschwarm anzeigen", 
	TimerLocustFade 	= "Timer für Auslaufen des Heuschreckenschwarms anzeigen"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Großwitwe Faerlina"
})

L:SetWarningLocalization({
	WarningEmbraceActive	= "Umarmung aktiv",
	WarningEmbraceExpire	= "Umarmung endet in 5 Sek",
	WarningEmbraceExpired	= "Umarmung ausgelaufen",
	WarningEnrageSoon		= "Enrage in 5 Sek",
	WarningEnrageNow		= "Enrage!"
})

L:SetTimerLocalization({
	TimerEmbrace	= "Umarmung aktiv",
	TimerEnrage		= "Enrage",
})

L:SetOptionLocalization({
	TimerEmbrace			= "Timer für Umarmung anzeigen",
	WarningEmbraceActive	= "Warnung für Umarmung anzeigen",
	WarningEmbraceExpire	= "Warnung anzeigen wenn Umarmung ausläuft",
	WarningEmbraceExpired	= "Warnung anzeigen wenn Umarmung bald ausläuft"
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
	WarningSpidersSoon	= "Spinnen in 5 Sek",
	WarningSpidersNow	= "Spinnen gespawnt!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "Web Spray",
	TimerSpider		= "Spinnen"
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
	YellWebWrap			= "Ich bin eingenetzt! Hilfe!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Noth der Seuchenbringer"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleporiert!",
	WarningTeleportSoon	= "Teleport in 20 Sek",
	WarningCurse		= "Fluch!"
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
	TimerTeleportBack	= "Teleport zurück"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Warnung für Teleport anzeigen",
	WarningTeleportSoon		= "Vorwarnung für Teleport anzeigen",
	WarningCurse			= "Warnung für Fluch anzeigen",
	TimerTeleport			= "Timer für Teleport anzeigen",
	TimerTeleportBack		= "Timer für Teleport zurück anzeigen"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Heigan der Unreine"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Teleportiert!",
	WarningTeleportSoon	= "Teleport in %d Sek",
})

L:SetTimerLocalization({
	TimerTeleport		= "Teleport",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "Warnung für Teleport anzeigen",
	WarningTeleportSoon		= "Vorwarnung für Teleport anzeigen",
	WarningCurse			= "Warnung für Fluch anzeigen",
	TimerTeleport			= "Timer für Teleport anzeigen",
	TimerTeleportBack		= "Timer für Teleport zurück anzeigen"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Loatheb"
})

L:SetWarningLocalization({
	WarningSporeNow		= "Spore gespawnt!",
	WarningSporeSoon	= "Spore in 5 Sek",
	WarningDoomNow		= "Verdammnis #%d",
	WarningHealSoon		= "Heilung in 3 Sek möglich",
	WarningHealNow		= "Jetzt heilen!"
})

L:SetTimerLocalization({
	TimerDoom			= "Verdammnis #%d",
	TimerSpore			= "Nächste Spore",
	TimerAura			= "Nekrotische Aura"
})

L:SetOptionLocalization({
	WarningSporeNow		= "Warnung für Sporen anzeigen",
	WarningSporeSoon	= "Vorwarnung für Sporen anzeigen",
	WarningDoomNow		= "Warnung für Verdammnis anzeigen",
	WarningHealSoon		= "Vorwarnung für \"Jetzt heilen!\" anzeigen",
	WarningHealNow		= "Warnung für \"Jetzt heilen\" anzeigen",
	TimerDoom			= "Timer für Verdammnis anzeigen",
	TimerSpore			= "Timer für Sporen anzeigen",
	TimerAura			= "Timer für Nekrotische Aura anzeigen"
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



-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Gluth"
})

L:SetOptionLocalization({
	WarningDecimateNow	= "Warnung für Dezimieren anzeign",
	WarningDecimateSoon	= "Vorwarnung für Dezimieren anzeigen",
	TimerDecimate		= "Timer für Dezimieren anzeigen"
})

L:SetWarningLocalization({
	WarningDecimateNow	= "Dezimieren!",
	WarningDecimateSoon	= "Dezimieren in 10 Sek"
})

L:SetTimerLocalization({
	TimerDecimate		= "Dezimieren"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Thaddius"
})

L:SetMiscLocalization({
	Yell	= "Stalagg crush you!"
})

L:SetOptionLocalization({
	WarningShiftCasting		= "Show Polarity Shift warning",
	WarningChargeChanged	= "Show special warning when your polarity changed",
	WarningChargeNotChanged	= "Show special warning when your polarity did not change",
	TimerShiftCast			= "Show Polarity Shift cast timer",
	TimerNextShift			= "Show Polarity Shift cooldown timer",
	ArrowsEnabled			= "Pfeile anzeigen",
	ArrowsRightLeft			= "Links/rechts-Pfeile anzeigen",
	ArrowsInverse			= "Umgedrehte Taktik (Pfeil nach rechts anzeigen wenn sich die Polarität ändert)"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "Polarity Shift in 3 sec!",
	WarningChargeChanged	= "Polarity changed to %s",
	WarningChargeNotChanged	= "Polarity didn't change"
})

L:SetTimerLocalization({
	TimerShiftCast			= "Polarity Shift Cast",
	TimerNextShift			= "Next Polarity Shift",
})

L:SetOptionCatLocalization({
	Arrows	= "Pfeile",
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
	WarningShoutNow		= "Show Disrupting Shout warning",
	WarningShoutSoon	= "Show Disrupting Shout pre-warning",
	TimerShout			= "Show Disrupting Shout timer"
})

L:SetWarningLocalization({
	WarningShoutNow		= "Disrupting Shout!",
	WarningShoutSoon	= "Disrupting Shout in 5 sec"
})

L:SetTimerLocalization({
	TimerShout			= "Disrupting Shout"
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
	Trainee			= "|4Trainee:Trainees;",
	Knight			= "|4Knight:Knights;",
	Rider			= "|4Rider:Riders;",
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Four Horsemen"
})

L:SetOptionLocalization({
	TimerMark					= "Timer für Mark anzeigen",
	WarningMarkSoon				= "Vorwarnung für Mark anzeigen",
	WarningMarkNow				= "Warnung für Mark anzeigen",
	SpecialWarningMarkOnPlayer	= "Spezialwarnung anzeigen wenn du mehr als 4 Marks auf dir hast"
})

L:SetTimerLocalization({
	TimerMark = "Mark %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Mark %d in 4 Sek",
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
	EmoteBreath			= "%s takes in a deep breath...",
	WarningYellIceblock	= "Ich bin ein Eisblock!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "Drain Life!",
	WarningDrainLifeSoon	= "Drain Life soon",
	WarningAirPhaseSoon		= "Flugphase in 10 Sek",
	WarningAirPhaseNow		= "Flugphase",
	WarningLanded			= "Sapphiron ist gelandet",
	WarningDeepBreath		= "Tiefer Atem!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "Drain Life CD",
	TimerAir				= "Flugphase",
	TimerLanding			= "Landung in",
	TimerIceBlast			= "Tiefer Atem"	
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Kel'Thuzad"
})

L:SetOptionLocalization({
	TimerPhase2			= "Timer für Phase 2 anzeigen",
	WarningBlastTargets	= "Warnung für Frostblast anzeigen",
	WarningPhase2		= "Show Phase 2 warning",
	WarningFissure		= "Show Shadow Fissure warning",
})

L:SetMiscLocalization({
	Yell = "Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!"
})

L:SetWarningLocalization({
	WarningBlastTargets	= "Frost Blast: >%s<",
	WarningPhase2		= "Phase 2",
	WarningFissure		= "Shadow Fissure spawned"
})

L:SetTimerLocalization({
	TimerPhase2			= "Phase 2"
})



