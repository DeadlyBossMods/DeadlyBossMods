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
   SpecialLocust      = "Heuschreckenschwarm!",
   WarningLocustSoon   = "Heuschreckenschwarm in 15 Sek",
   WarningLocustNow   = "Heuschreckenschwarm!",
   WarningLocustFaded   = "Heuschreckenschwarm ausgelaufen"
})

L:SetTimerLocalization({
   TimerLocustIn   = "Heuschreckenschwarm",
   TimerLocustFade = "Heuschreckenschwarm aktiv"
})

L:SetOptionLocalization({
   SpecialLocust      = "Spezialwarnung für Heuschreckenschwarm",
   WarningLocustSoon   = "Vorwarnung für Heuschreckenschwarm anzeigen",
   WarningLocustNow   = "Warnung für Heuschreckenschwarm anzeigen",
   WarningLocustFaded   = "Warnung wenn Heuschreckenschwarm ausläuft",
   TimerLocustIn      = "Timer für Heuschreckenschwarm anzeigen",
   TimerLocustFade    = "Timer für Auslaufen des Heuschreckenschwarms anzeigen"
})


----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
   name = "Großwitwe Faerlina"
})

L:SetWarningLocalization({
   WarningEmbraceActive   = "Umarmung aktiv",
   WarningEmbraceExpire   = "Umarmung endet in 5 Sek",
   WarningEmbraceExpired   = "Umarmung ausgelaufen",
   WarningEnrageSoon      = "Raserei in 5 Sek",
   WarningEnrageNow      = "Raserei!"
})

L:SetTimerLocalization({
   TimerEmbrace   = "Umarmung aktiv",
   TimerEnrage      = "Raserei",
})

L:SetOptionLocalization({
   TimerEmbrace         = "Timer für Umarmung anzeigen",
   WarningEmbraceActive   = "Warnung für Umarmung anzeigen",
   WarningEmbraceExpire   = "Warnung anzeigen wenn Umarmung ausläuft",
   WarningEmbraceExpired   = "Warnung anzeigen wenn Umarmung bald ausläuft"
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
   name = "Maexxna"
})

L:SetWarningLocalization({
   WarningWebWrap      = "Fangnetz: >%s<",
   WarningWebSpraySoon   = "Gespinstschauer in 5 Sek",--aka Netz versprühen (heroisch)
   WarningWebSprayNow   = "Gespinstschauer!",--aka Netz versprühen (heroisch)
   WarningSpidersSoon   = "Spinnen in 5 Sek",
   WarningSpidersNow   = "Spinnen gespawnt!"
})

L:SetTimerLocalization({
   TimerWebSpray   = "Web Spray",
   TimerSpider      = "Spinnen"
})

L:SetOptionLocalization({
   WarningWebWrap      = "Verkünde Fangnetzziele",
   WarningWebSpraySoon   = "Zeige Gespinstschauer Vorwarnung",--aka Netz versprühen (heroisch)
   WarningWebSprayNow   = "Zeige Gespinstschauer Warnung", --aka  Netz versprühen (heroisch)
   WarningSpidersSoon   = "Zeige Spinnenvorwarnung",
   WarningSpidersNow   = "Warne für Spinnen",
   TimerWebSpray      = "Zeit bis Gespinstschauer",-- aka Netz versprühen (heroisch)
   TimerSpider         = "Zeige Zeit bis Spinnen"
})

L:SetMiscLocalization({
   YellWebWrap         = "Ich bin eingenetzt! Hilfe!"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
   name = "Noth der Seuchenbringer"
})

L:SetWarningLocalization({
   WarningTeleportNow   = "Teleporiert!",
   WarningTeleportSoon   = "Teleport in 20 Sek",
   WarningCurse      = "Fluch!"
})

L:SetTimerLocalization({
   TimerTeleport      = "Teleport",
   TimerTeleportBack   = "Teleport zurück"
})

L:SetOptionLocalization({
   WarningTeleportNow      = "Warnung für Teleport anzeigen",
   WarningTeleportSoon      = "Vorwarnung für Teleport anzeigen",
   WarningCurse         = "Warnung für Fluch anzeigen",
   TimerTeleport         = "Timer für Teleport anzeigen",
   TimerTeleportBack      = "Timer für Teleport zurück anzeigen"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
   name = "Heigan der Unreine"
})

L:SetWarningLocalization({
   WarningTeleportNow   = "Teleportiert!",
   WarningTeleportSoon   = "Teleport in %d Sek",
})

L:SetTimerLocalization({
   TimerTeleport      = "Teleport",
})

L:SetOptionLocalization({
   WarningTeleportNow      = "Warnung für Teleport anzeigen",
   WarningTeleportSoon      = "Vorwarnung für Teleport anzeigen",
   WarningCurse         = "Warnung für Fluch anzeigen",
   TimerTeleport         = "Timer für Teleport anzeigen",
   TimerTeleportBack      = "Timer für Teleport zurück anzeigen"
})


----------------
--  Lolotheb  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
   name = "Loatheb"
})

L:SetWarningLocalization({
   WarningSporeNow      = "Spore gespawnt!",
   WarningSporeSoon   = "Spore in 5 Sek",
   WarningDoomNow      = "Verdammnis #%d",
   WarningHealSoon      = "Heilung in 3 Sek möglich",
   WarningHealNow      = "Jetzt heilen!"
})

L:SetTimerLocalization({
   TimerDoom         = "Verdammnis #%d",
   TimerSpore         = "Nächste Spore",
   TimerAura         = "Nekrotische Aura"
})

L:SetOptionLocalization({
   WarningSporeNow      = "Warnung für Sporen anzeigen",
   WarningSporeSoon   = "Vorwarnung für Sporen anzeigen",
   WarningDoomNow      = "Warnung für Verdammnis anzeigen",
   WarningHealSoon      = "Vorwarnung für \"Jetzt heilen!\" anzeigen",
   WarningHealNow      = "Warnung für \"Jetzt heilen\" anzeigen",
   TimerDoom         = "Timer für Verdammnis anzeigen",
   TimerSpore         = "Timer für Sporen anzeigen",
   TimerAura         = "Timer für Nekrotische Aura anzeigen"
})



-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
   name = "Flickwerk"
})

L:SetOptionLocalization({
   WarningHateful = "Verkünde Hasserfüllte Stöße im Raidchat\nbenötigt Assistent/Raidleiter)"
})

L:SetMiscLocalization({
	yell1 = "Flickwerk will spielen!", 
	yell2 = "Kel’Thuzad macht Flickwerk zu seinem Abgesandten von Krieg!",
	HatefulStrike = "Hasserfüllter Stoß --> %s [%s]"
})


-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
   name = "Grobbulus"
})

L:SetOptionLocalization({
   WarningInjection      = "Warne für Mutagene Inkektion",
   SpecialWarningInjection   = "Zeige spezielle Warnung wenn man selbst Ziel der Mutagenen Injektion ist"
})

L:SetWarningLocalization({
   WarningInjection      = "Mutatagene Injektion: >%s<",
   SpecialWarningInjection   = "Mutagene Injektion auf dir!"
})



-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
   name = "Gluth"
})

L:SetOptionLocalization({
   WarningDecimateNow   = "Warnung für Dezimieren anzeign",
   WarningDecimateSoon   = "Vorwarnung für Dezimieren anzeigen",
   TimerDecimate      = "Timer für Dezimieren anzeigen"
})

L:SetWarningLocalization({
   WarningDecimateNow   = "Dezimieren!",
   WarningDecimateSoon   = "Dezimieren in 10 Sek"
})

L:SetTimerLocalization({
   TimerDecimate      = "Dezimieren"
})


----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
   name = "Thaddius"
})

L:SetMiscLocalization({
	Yell   = "Stalagg zerquetschen!",
	Boss1 = "Feugen",
	Boss2 = "Stalagg",
	Charge1 = "negative",
	Charge2 = "positive",
	Emote = "%s überlädt!",
	Emote2 = "Teslaspule überlädt!"
})

L:SetOptionLocalization({
   WarningShiftCasting      = "Warne für Polaritätsveränderung",
   WarningChargeChanged   = "Zeige spezielle Warnung wenn deine Polarität gewechselt hat",
   WarningChargeNotChanged   = "Zeige spezielle Warnung wenn deine Polarität nicht gewechselt hat",
   TimerShiftCast         = "Zeige die Zeit in der Polaritätsveränderung  gewirkt wird",
   TimerNextShift         = "Zeige die Abklingzeit für Polaritätsveränderung",
   ArrowsEnabled         = "Pfeile anzeigen",
   ArrowsRightLeft         = "Links/rechts-Pfeile anzeigen",
   ArrowsInverse         = "Umgedrehte Taktik (Pfeil nach rechts anzeigen wenn sich die Polarität ändert)"
})

L:SetWarningLocalization({
   WarningShiftCasting      = "Polaritätsveränderung in 3 sek!",
   WarningChargeChanged   = "Polarität geändert zu : %s",
   WarningChargeNotChanged   = "Polarität änderte sich nicht"
})

L:SetTimerLocalization({
   TimerShiftCast         = "Polaritätsveränderung gewirkt",
   TimerNextShift         = "Nächste Polaritätsveränderung",
})

L:SetOptionCatLocalization({
   Arrows   = "Pfeile",
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
   WarningShoutNow      = "Warne für Unterbrechender Schrei",-- oder Unterbrechungsruf , Blizzard war sich nich einig
   WarningShoutSoon   = "Zeige Vor-Warnung für Unterbrechender Schrei",
   TimerShout         = "Zeige Zeit bis Unterbrechender Schrei",
})

L:SetWarningLocalization({
   WarningShoutNow      = "Unterbrechender Schrei!",
   WarningShoutSoon   = "Unterbrechender Schrei in 5 sek"
})

L:SetTimerLocalization({
   TimerShout         = "Unterbrechender Schrei"
})

--------------
--  Gothik  --
--------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
   name = "Gothik"
})

L:SetOptionLocalization({
   TimerWave         = "Zeige Timer für Wellen",
   TimerPhase2         = "Zeige Phase 2 Timer",
   WarningWaveSoon      = "Zeige Vor-Warnung für die Wellen",
   WarningWaveSpawned   = "Warne, wenn eine Welle spawnt",
   WarningRiderDown   = "Warne when ein Reiter stirbt",
   WarningKnightDown   = "Warne wenn ein Ritter stirbt",
   WarningPhase2      = "Phase 2 Warnung"
})

L:SetTimerLocalization({
   TimerWave   = "Welle #%d",
   TimerPhase2   = "Phase 2"
})

L:SetWarningLocalization({
   WarningWaveSoon      = "Welle %d: %s in 3 sek",
   WarningWaveSpawned   = "Welle %d: %s gespawnt",
   WarningRiderDown   = "Reiter tot",
   WarningKnightDown   = "Ritter tot",
   WarningPhase2      = "Phase 2"
})

L:SetMiscLocalization({
   yell         = "Ihr Narren habt euren eigenen Untergang heraufbeschworen.",
   WarningWave1   = "%d %s",
   WarningWave2   = "%d %s und %d %s",
   WarningWave3   = "%d %s, %d %s und %d %s",
   Trainee         = "|4Lehrling:Lehrlinge;",
   Knight         = "|4Ritter:Ritter;",
   Rider         = "|4Reiter:Reiter;",
})


----------------
--  Horsemen  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
   name = "Four Horsemen"
})

L:SetOptionLocalization({
   TimerMark               = "Timer für Mal anzeigen",
   WarningMarkSoon            = "Vorwarnung für Mal anzeigen",
   WarningMarkNow            = "Warnung für Mal anzeigen",
   SpecialWarningMarkOnPlayer   = "Spezialwarnung anzeigen wenn du mehr als 4 Male auf dir hast"
})

L:SetTimerLocalization({
   TimerMark = "Mal %d"
})

L:SetWarningLocalization({
   WarningMarkSoon            = "Mal %d in 4 Sek",
   WarningMarkNow            = "Mal %d!",
   SpecialWarningMarkOnPlayer   = "%s: %s",
})

L:SetMiscLocalization({
   Korthazz   = "Thane Korth'azz",
   Rivendare   = "Baron Rivendare",
   Blaumeux   = "Lady Blaumeux",
   Zeliek      = "Sir Zeliek",
})


-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
   name = "Sapphiron"
})

L:SetOptionLocalization({
   WarningDrainLifeNow      = "Warne vor Lebensentzug",
   WarningDrainLifeSoon   = "Zeige Vor-Warnung für Lebensentzug",
   WarningAirPhaseSoon      = "Zeige VorWarnung für die Flugphase",
   WarningAirPhaseNow      = "Verkünde die Flugphase",
   WarningLanded         = "Warne vor der Bodenphase",
   TimerDrainLifeCD      = "Zeige Timer für Lebensentzug",
   TimerAir            = "Zeige Timer für die Flugphase",
   TimerLanding         = "Zeige Timer für die Landung",
   TimerIceBlast         = "Zeige Timer für  Tiefen Atem",
   WarningDeepBreath      = "Zeige spezielle Warnung für Tiefen Atem"
})

L:SetMiscLocalization({
   EmoteBreath         = "%s holt tief Luft.",
   WarningYellIceblock   = "Ich bin ein Eisblock!"
})

L:SetWarningLocalization({
   WarningDrainLifeNow      = "Lebensentzug!",
   WarningDrainLifeSoon   = "Lebensentzug  bald!",
   WarningAirPhaseSoon      = "Flugphase in 10 Sek",
   WarningAirPhaseNow      = "Flugphase",
   WarningLanded         = "Sapphiron ist gelandet",
   WarningDeepBreath      = "Tiefer Atem!",
})

L:SetTimerLocalization({
   TimerDrainLifeCD      = "Lebensentzug CD",
   TimerAir            = "Flugphase",
   TimerLanding         = "Landung in",
   TimerIceBlast         = "Tiefer Atem"   
})

------------------
--  Kel'thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
   name = "Kel'Thuzad"
})

L:SetOptionLocalization({
   TimerPhase2         = "Timer für Phase 2 anzeigen",
   WarningBlastTargets   = "Warnung für Frostschlag anzeigen",
   WarningPhase2      = "Zeige Phase 2 Warnung",
   WarningFissure      = "Warne vor Schattenspalt",
})

L:SetMiscLocalization({
   Yell = "Lakaien, Diener, Soldaten der eisigen Finsternis! Folgt dem Ruf von Kel'Thuzad!"
})

L:SetWarningLocalization({
   WarningBlastTargets   = "Frostschlag: >%s<",
   WarningPhase2      = "Phase 2",
   WarningFissure      = "Schattenspalt gespawnt"
})

L:SetTimerLocalization({
   TimerPhase2         = "Phase 2"
})


