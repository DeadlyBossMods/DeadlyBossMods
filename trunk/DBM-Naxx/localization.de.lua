if GetLocale() ~= "deDE" then return end

-- fehlende Übersetzungen:
--
-- Instrukteur Razuvious

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
   name = "Anub'Rekhan"
})

L:SetWarningLocalization({
   SpecialLocust      = "Heuschreckenschwarm",
   WarningLocustFaded   = "Heuschreckenschwarm ausgelaufen"
})

L:SetOptionLocalization({
   SpecialLocust      = "Zeige Spezialwarnung für Heuschreckenschwarm",
   WarningLocustFaded   = "Zeige Warnung wenn Heuschreckenschwarm ausläuft",
   ArachnophobiaTimer   = "Zeige Timer für Erfolg 'Arachnophobie'"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Arachnophobie"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
   name = "Großwitwe Faerlina"
})

L:SetWarningLocalization({
   WarningEmbraceExpire   = "Umarmung endet in 5 Sek",
   WarningEmbraceExpired   = "Umarmung ausgelaufen"
})

L:SetOptionLocalization({
   WarningEmbraceExpire   = "Zeige Vorwarnung wenn Umarmung ausläuft",
   WarningEmbraceExpired   = "Zeige Warnung wenn Umarmung ausläuft"
})


---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
   name = "Maexxna"
})

L:SetWarningLocalization({
   WarningSpidersSoon   = "Maexxnaspinnlinge in 5 Sek",
   WarningSpidersNow   = "Maexxnaspinnlinge gespawnt"
})

L:SetTimerLocalization({
   TimerSpider      = "Nächste Maexxnaspinnlinge"
})

L:SetOptionLocalization({
   WarningSpidersSoon   = "Zeige Vorwarnung für Maexxnaspinnlinge",
   WarningSpidersNow   = "Zeige Warnung für Maexxnaspinnlinge",
   TimerSpider         = "Zeige Timer für nächste Maexxnaspinnlinge"
})

L:SetMiscLocalization({
	YellWebWrap         = "Ich bin eingenetzt! Hilfe!",
	ArachnophobiaTimer	= "Arachnophobie"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
   name = "Noth der Seuchenbringer"
})

L:SetWarningLocalization({
   WarningTeleportNow   = "Teleportiert",
   WarningTeleportSoon   = "Teleport in 20 Sek"
})

L:SetTimerLocalization({
   TimerTeleport      = "Teleport",
   TimerTeleportBack   = "Teleport zurück"
})

L:SetOptionLocalization({
   WarningTeleportNow      = "Zeige Warnung für Teleport",
   WarningTeleportSoon      = "Zeige Vorwarnung für Teleport",
   TimerTeleport         = "Zeige Timer für Teleport",
   TimerTeleportBack      = "Zeige Timer für Teleport zurück"
})


--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
   name = "Heigan der Unreine"
})

L:SetWarningLocalization({
   WarningTeleportNow   = "Teleportiert",
   WarningTeleportSoon   = "Teleport in %d Sek"
})

L:SetTimerLocalization({
   TimerTeleport      = "Teleport"
})

L:SetOptionLocalization({
   WarningTeleportNow      = "Zeige Warnung für Teleport",
   WarningTeleportSoon      = "Zeige Vorwarnung für Teleport",
   TimerTeleport         = "Zeige Timer für Teleport"
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
   name = "Loatheb"
})

L:SetWarningLocalization({
   WarningHealSoon      = "Heilung in 3 Sek möglich",
   WarningHealNow      = "Jetzt heilen"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Zeige Vorwarnung für 3-Sekunden-Heilfenster",
	WarningHealNow		= "Zeige Warnung für 3-Sekunden-Heilfenster",
	SporeDamageAlert	= "Sende Flüsternachricht und verkünde Spieler in Raid die Sporen beschädigen\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
   name = "Flickwerk"
})

L:SetOptionLocalization({
   WarningHateful = "Verkünde Hasserfüllte Stöße im Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)"
})

L:SetMiscLocalization({
	yell1 = "Flickwerk will spielen!", 
	yell2 = "Kel’Thuzad macht Flickwerk zu seinem Abgesandten des Kriegs!",
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
   SpecialWarningInjection   = "Zeige Spezialwarnung wenn du Ziel der Mutagenen Injektion bist",
   SetIconOnInjectionTarget	= "Setze Zeichen auf Ziele von Mutagene Injektion"
})

L:SetWarningLocalization({
   SpecialWarningInjection   = "Mutagene Injektion auf dir"
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

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
   name = "Thaddius"
})

L:SetMiscLocalization({
	Yell   = "Stalagg zerquetschen!",
	Emote = "%s überlädt!",
	Emote2 = "Teslaspule überlädt!",
	Boss1 = "Feugen",
	Boss2 = "Stalagg",
	Charge1 = "negativ",
	Charge2 = "positiv"
})

L:SetOptionLocalization({
   WarningChargeChanged   = "Zeige Spezialwarnung wenn deine Polarität gewechselt hat",
   WarningChargeNotChanged   = "Zeige Spezialwarnung wenn deine Polarität nicht gewechselt hat",
   ArrowsEnabled         = "Zeige Pfeile (normale \"2-Camps\"-Strategie)",
   ArrowsRightLeft         = "Zeige Links-/rechts-Pfeile für die \"4-Camps\"-Strategie (zeige Pfeil nach links wenn sich die Polarität geändert hat, rechts wenn nicht)",
   ArrowsInverse         = "Umgedrehte Taktik (Pfeil nach rechts anzeigen wenn sich die Polarität ändert, links wenn nicht)"
})

L:SetWarningLocalization({
   WarningChargeChanged   = "Polarität geändert zu %s",
   WarningChargeNotChanged   = "Polarität hat sich nicht geändert"
})

L:SetOptionCatLocalization({
   Arrows   = "Pfeile"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
   name = "Instrukteur Razuvious"
})

L:SetMiscLocalization({
   Yell1 = "Show them no mercy!",	-- to be translated
   Yell2 = "The time for practice is over! Show me what you have learned!",	-- to be translated
   Yell3 = "Do as I taught you!",	-- to be translated
   Yell4 = "Sweep the leg... Do you have a problem with that?"	-- to be translated
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Zeige Warnung für Auslaufen von Schildwall"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Schildwall endet in 5 Sekunden"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
   name = "Gothik der Ernter"
})

L:SetOptionLocalization({
   TimerWave         = "Zeige Timer für nächste Welle",
   TimerPhase2         = "Zeige Timer für Phase 2",
   WarningWaveSoon      = "Zeige Vorwarnung für die Wellen",
   WarningWaveSpawned   = "Zeige Warnung für gespawnte Wellen",
   WarningRiderDown   = "Zeige Warnung wenn ein Unerbittlicher Reiter stirbt",
   WarningKnightDown   = "Zeige Warnung wenn ein Unerbittlicher Todesritter stirbt"
})

L:SetTimerLocalization({
   TimerWave   = "Welle %d",
   TimerPhase2   = "Phase 2"
})

L:SetWarningLocalization({
   WarningWaveSoon      = "Welle %d: %s in 3 Sek",
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
   Rider         = "|4Reiter:Reiter;"
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
   name = "Die vier Reiter"
})

L:SetOptionLocalization({
   WarningMarkSoon            = "Zeige Vorwarnung für Mal",
   WarningMarkNow            = "Zeige Warnung für Mal",
   SpecialWarningMarkOnPlayer   = "Zeige Spezialwarnung wenn du mehr als 4 Male auf dir hast"
})

L:SetTimerLocalization({
})

L:SetWarningLocalization({
   WarningMarkSoon            = "Mal %d in 3 Sekunden",
   WarningMarkNow            = "Mal %d",
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
   name = "Saphiron"
})

L:SetOptionLocalization({
   WarningAirPhaseSoon      = "Zeige Vorwarnung für Flugphase",
   WarningAirPhaseNow      = "Verkünde Flugphase",
   WarningLanded         = "Verkünde Bodenphase",
   TimerAir            = "Zeige Timer für Flugphase",
   TimerLanding         = "Zeige Timer für Landung",
   TimerIceBlast         = "Zeige Timer für Frostatem",
   WarningDeepBreath      = "Zeige Spezialwarnung für Frostatem",
   WarningIceblock		= "Schreie wenn du ein Eisblock bist"
})

L:SetMiscLocalization({
   EmoteBreath         = "%s holt tief Luft.",
   WarningYellIceblock   = "Ich bin ein Eisblock!"
})

L:SetWarningLocalization({
   WarningAirPhaseSoon      = "Flugphase in 10 Sek",
   WarningAirPhaseNow      = "Flugphase",
   WarningLanded         = "Saphiron ist gelandet",
   WarningDeepBreath      = "Frostatem",
})

L:SetTimerLocalization({
   TimerAir            = "Flugphase",
   TimerLanding         = "Landung",
   TimerIceBlast         = "Frostatem"   
})

------------------
--  Kel'Thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
   name = "Kel'Thuzad"
})

L:SetOptionLocalization({
   TimerPhase2         = "Zeige Timer für Phase 2",
   specwarnP2Soon	= "Zeige Spezialwarnung 10 Sekunden bevor Kel'Thuzad angreift",
   warnAddsSoon	= "Zeige Vorwarnung für Wächter von Eiskrone",
   ShowRange		= "Show range frame when Phase 2 starts"
})

L:SetMiscLocalization({
   Yell = "Lakaien, Diener, Soldaten der eisigen Finsternis! Folgt dem Ruf von Kel'Thuzad!"
})

L:SetWarningLocalization({
	specwarnP2Soon	= "Kel'Thuzad greift in 10 Sekunden an",
	warnAddsSoon	= "Wächter von Eiskrone bald"
})

L:SetTimerLocalization({
   TimerPhase2         = "Phase 2"
})

