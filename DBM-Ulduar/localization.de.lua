if GetLocale() ~= "deDE" then return end

local L
----------------------
-- FlameLeviathan --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "Flammenleviathan"
}

L:SetMiscLocalization{
	YellPull		= "Feindeinheiten erkannt. Bedrohungsbewertung aktiv. Hauptziel erfasst. Neubewertung in T minus 30 Sekunden.",
	Emote			= "%%s pursues (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	= "Verfolgt >%s<!",
	warnNextPursueSoon	= "Ziel wechsel in 5 Sek"
}

L:SetOptionLocalization{
	SystemOverload		= "Spezialwarnung für System Überladung",
	SpecialPursueWarnYou	= "Spezialwarnung bei Verfolgung",
	PursueWarn		= "Zeige Warnung für Verfolgung eines Spielers",
	warnNextPursueSoon	= "Zeige Warnung vor nächstem Verfolgen"
}


-------------
-- Ignis --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "Ignis the Furnace Master"
}

L:SetWarningLocalization{
	WarningSlagPot			= "Slag Pot auf >%s<",
	SpecWarnJetsCast		= "Jets - Stop Casting"
}

L:SetOptionLocalization{
	SpecWarnJetsCast		= "Spezialwarnung für Flame Jets Cast (Zauber Unterbrechung)",
	WarningSlagPot			= "Warnung für Slag Pot target",
	SlagPotIcon			= "Setze Symbol auf Slag Pot target"
}

------------------
-- Razorscale --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Razorscale"
}

L:SetWarningLocalization{	
	SpecWarnDevouringFlame		= "Verschlingende Flamme - LAUF RAUS",
	warnTurretsReadySoon		= "letzer Turm bereit in 20 Sek",
	warnTurretsReady		= "letzer Turm bereit",
	SpecWarnDevouringFlameCast	= "Verschlingende Flamme auf dir",
	WarnDevouringFlameCast		= "Verschlingende Flamme auf >%s<" 
}
L:SetTimerLocalization{
	timerTurret1			= "Turm 1",
	timerTurret2			= "Turm 2",
	timerTurret3			= "Turm 3",
	timerTurret4			= "Turm 4"
}
L:SetOptionLocalization{
	SpecWarnDevouringFlame		= "Zeige Spezialwarnung wenn in einer Verschlingende Flamme",
	PlaySoundOnDevouringFlame	= "Spiele Sound wenn betroffen durch Verschlingende Flamme",
	SpecWarnDevouringFlameCast	= "Spezialwarnung wenn Verschlingende Flamme auf dich gezaubert wird",
	timerAllTurretsReady		= "Zeige Timer für Turmfertigstellung",
	warnTurretsReadySoon		= "Zeige Vorwarnung für Turmfertigstellung",
	warnTurretsReady		= "Zeige Warnung für fertige Türme",
	OptionDevouringFlame		= "Warnung für Ziel der Verschlingende Flamme (nicht verlässlich)",
	timerTurret1			= "Zeige Timer für Turm 1",
	timerTurret2			= "Zeige Timer für Turm 2",
	timerTurret3			= "Zeige Timer für Turm 3 (Heroic)",
	timerTurret4			= "Zeige Timer für Turm 4 (Heroic)"
}

L:SetMiscLocalization{
	YellAir				= "Gebt uns einen Moment, damit wir uns auf den Bau der Geschütze vorbereiten können.",
	YellAir2			= "Feuer einstellen! Lasst uns diese Gesch�tze reparieren!",
	YellGroundTemp			= "Beeilt Euch! Sie wird nicht lange am Boden bleiben!", 
	EmotePhase2			= "%%s grounded permanently!",
	FlamecastUnknown		= "UNBEKANNT"
}


-------------
-- XT002 --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT-002 Deconstructor"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecialWarningLightBomb 	= "Licht Bombe auf dir!",
	WarningLightBomb		= "Licht Bombe auf >%s<",
	SpecialWarningGravityBomb	= "Graviations Bombe auf DIR",
	WarningGravityBomb		= "Graviations Bombe auf >%s<",
}

L:SetOptionLocalization{
	SpecialWarningLightBomb		= "Spezialwarnung bei Licht Bombe auf dir",
	WarningLightBomb		= "Warnung für Licht Bombe",
	SpecialWarningGravityBomb	= "Spezialwarnung bei Graviations Bombe auf dir",
	WarningGravityBomb		= "Warnung für Graviations Bombe",
	PlaySoundOnGravityBomb		= "Spiele Sound bei Graviations Bombe auf dir",
	PlaySoundOnTympanicTantrum	= "Spiele Sound bei Erdbeben",
	SetIconOnLightBombTarget	= "Setze Symbol auf Licht Bombe target",
	SetIconOnGravityBombTarget	= "Setze Symbol auf Graviations Bombe target",
}

-------------------
-- IronCouncil --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "Iron Council"
}

L:SetWarningLocalization{
	WarningSupercharge			= "Superladung auf Boss",
	WarningChainlight			= "Kettenblitzschlag",
	WarningFusionPunch			= "Fusionsschlag",
	WarningOverwhelmingPower		= "Überwältigende Kraft auf >%s<",
	WarningRuneofPower			= "Rune der Macht",
	WarningRuneofDeath			= "Rune des Todes",
	RuneofDeath				= "Rune des Todes - LAUF RAUS",
	LightningTendrils			= "Blitzranken - LAUF",
	WarningRuneofSummoning			= "Rune of Summoning",
	Overload				= "Überladen - LAUF WEG"
}

L:SetOptionLocalization{
	WarningSupercharge			= "Zeige Warnung wenn Superladung",
	WarningChainlight			= "Warnung für Kettenblitzschlag",
	LightningTendrils			= "Spezialwarnung für Blitzranken",
	PlaySoundLightningTendrils		= "Play Sound on Blitzranken",
	WarningFusionPunch			= "Warnung für Fusionsschlag",
	WarningOverwhelmingPower		= "Warnung für Überwältigende Kraft",
	SetIconOnOverwhelmingPower		= "Setze Symbol auf Überwältigende Kraft Ziel",
	WarningRuneofPower			= "Warnung für Rune der Macht",
	WarningRuneofDeath			= "Warnung für Rune des Todes",
	WarningRuneofSummoning			= "Warnung für Rune der Beschwörung",
	RuneofDeath				= "Spezialwarnung für Rune des Todes",
	SetIconOnStaticDisruption		= "Setze Symbol auf Statische Störung Ziel",
	Overload				= "Spezialwarnung für Überladen",
	AllwaysWarnOnOverload			= "Warne immer bei Überladen (ansonsten nur wenn Boss im Ziel)"
}

L:SetMiscLocalization{
	Steelbreaker		= "Stahlbrecher",
	RunemasterMolgeim	= "Runenmeister Molgeim",
	StormcallerBrundir	= "Sturmrufer Brundir"
}


---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon der Beobachter"
}

L:SetTimerLocalization{
	NextCollapsingStar		= "neue kollabierende Sterne"
}
L:SetWarningLocalization{
	WarningPhasePunch		= "Phasenschlag auf >%s< - %d mal",
	WarningBlackHole		= "Schwarzes Loch",
	WarningBigBang			= "Grosser Knall jetzt",
	SpecWarnBigBang			= "Grosser Knall",
	PreWarningBigBang		= "Grosser Knall in ~10 sec",
	WarningCosmicSmash 		= "Kosmisches Schmettern - Explosion in 4 sek",
	SpecWarnCosmicSmash 	= "Kosmisches Schmettern"
}

L:SetOptionLocalization{
	SpecWarnPhasePunch		= "Spezial Warnung f�r Phasenschlag stacks",
	WarningBigBang			= "Warnung bei Grosser Knall",
	PreWarningBigBang		= "Vorwarnung f�r Grosser Knall",
	SpecWarnBigBang			= "Spezialwarnung f�r Grosser Knall",
	WarningPhasePunch		= "Warnung bei Phasenschlag",
	WarningBlackHole		= "Warnung f�r Schwarzes Loch",
	NextCollapsingStar		= "Zeit f�r kollabierende Sterne anzeigen",
	WarningCosmicSmash 		= "Warnung bei Kosmisches Schmettern",
	SpecWarnCosmicSmash 	= "Spezialwarnung f�r Kosmisches Schmettern"
}

L:SetMiscLocalization{
	YellPull				= "Euer Handeln ist unlogisch. Alle M�glichkeiten dieser Begegnung wurden berechnet. Das Pantheon wird die Nachricht des Beobachters erhalten, ungeachtet des Ausgangs.",
	YellPullFirst			= "Seht Eure Welt durch meine Augen: Ein Universum so gewaltig - grenzenlos - unbegreiflich selbst f�r die Kl�gsten unter Euch.",
	Emote_CollapsingStars	= "%s beginnt damit, kollabierende Sterne zu beschw�ren!!",
}

----------------
-- Kologarn --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "Kologarn"
}

L:SetWarningLocalization{
	SpecialWarningEyebeam		= "Augenstrahl auf dir - MOVE",
	WarningEyebeam				= "Augenstrahl auf >%s<",
	WarnGrip					= "Steinerner Griff auf >%s<"
}

L:SetTimerLocalization{
	timerLeftArm			= "Nachwachsen linker Arm",
	timerRightArm			= "Nachwachsen rechter Arm",
	achievementDisarmed		= "Zeit für Armlos"
}

L:SetOptionLocalization{
	SpecialWarningEyebeam		= "Zeige Spezialwarnung wenn betroffen von Fokussierter Augenstrahl",
	timerLeftArm			= "Zeige Timer für Arm-Nachwachsen (links)",
	timerRightArm			= "Zeige Timer für Arm-Nachwachsen (rechts)",
	achievementDisarmed		= "Zeige Timer für Armlos Erfolg"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Das ist nur ein Kratzer!",	
	Yell_Trigger_arm_right		= "Ist nur 'ne Fleischwunde!",
	Health_Body			= "Kologarn",
	Health_Right_Arm		= "Rechter Arm",
	Health_Left_Arm			= "Linker Arm",
	FocusedEyebeam			= "%s fokussiert seinen Blick auf Euch!"
}

---------------
-- Auriaya --
---------------
L = DBM:GetModLocalization("Auriaya")

L:SetGeneralLocalization{
	name = "Auriaya"
}

L:SetMiscLocalization{
	Defender 		= "Wilder Verteidiger (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast		= "Schildwachenschlag - Unterbrechen!",
	SpecWarnVoid		= "Wilde Essenz - MOVE!",
	WarnCatDied 		= "Wilder Verteidiger tot (%d leben übrig)",
	WarnCatDiedOne	 	= "Wilder Verteidiger tot (1 leben übrig)",
	WarnFear		= "Schreckliches Kreischen!",
	WarnFearSoon 		= "Nächstes Schreckliches Kreischen gleich",
	WarnSonic		= "Überschallkreischen!",
	WarnSwarm		= "Wächterschwarm auf >%s<"
}

L:SetOptionLocalization{
	SpecWarnBlast		= "Show Special Warning on Sentinel Blast",
	SpecWarnVoid		= "Spezialwarnung wenn betroffen von Wilde Essenz",
	WarnFear		= "Zeige Warnung für Schreckliches Kreischen",
	WarnFearSoon		= "Zeige Vor-Warnung für Schreckliches Kreischen",
	WarnCatDied		= "Zeige Warnung wenn ein Wilder Verteidiger stirbt",
	WarnSwarm		= "Zeige Warnung für Wächterschwarm",
	WarnSonic		= "Zeige Warnung für Überschallkreischen"
}


-------------
-- Hodir --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "Hodir"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "Blitzeis",
	WarningStormCloud	= "Storm Cloud auf >%s<", 
}

L:SetOptionLocalization{
	WarningFlashFreeze	= "Zeige Warnung für Blitzeis",
	PlaySoundOnFlashFreeze	= "Spiele Sound bei Blitzeis",
	WarningStormCloud	= "Zeige Warnung für Sturmwolke auf Spieler",
	YellOnStormCloud	= "Schreie wenn Sturmwolke auf dir",
	SetIconOnStormCloud	= "Setze Symbol auf den Spieler mit Sturmwolke"
}

L:SetMiscLocalization{
	YellKill		= "Ich... bin von ihm befreit... endlich.", 
	YellCloud		= "Sturmwolke auf mir!"
}


--------------
-- Thorim --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningStormhammer		= "Sturmhammer auf >%s<",
	UnbalancingStrike		= "Schlag des Ungleichgewichts auf >%s<",
	WarningPhase2			= "Phase 2",
	WarningLightningCharge		= "Blitzladung",
	WarningBomb			= "Runendetonation auf >%s<",
	LightningOrb			= "Blitzladung auf dir, lauf weg!"
}

L:SetTimerLocalization{
	TimerHardmode			= "Hard Mode"
}

L:SetOptionLocalization{
	TimerHardmode			= "Zeige Timer für Hard Mode",
	UnbalancingStrike		= "Warnung für Schlag des Ungleichgewichts",
	WarningStormhammer		= "Warnung für Sturmhammer",
	WarningLightningCharge		= "Warnung für Blitzladung",
	WarningPhase2			= "Warnung für Phase 2",
	WarningBomb			= "Warnung für Runendetonation",
	RangeFrame			= "Zeige Abstands Fenster"
}

L:SetMiscLocalization{
	YellPhase1		= " Eindringlinge! Ihr Sterblichen, die Ihr es wagt, Euch in mein Vergnügen einzumischen, werdet... Wartet... Ihr...",
	YellPhase2		= "Ihr unverschämtes Geschmeiß! Ihr wagt es, mich in meinem Refugium herauszufordern? Ich werde Euch eigenhändig zerschmettern!",
	YellKill		= "Senkt Eure Waffen! Ich ergebe mich!"
}


-------------
-- Freya --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "Freya"
}

L:SetMiscLocalization{
	SpawnYell		= "Helft mir, Kinder!",
	WaterSpirit		= "Uralter Wassergeist",
	Snaplasher		= "Knallpeitscher",
	StormLasher		= "Sturmpeitscher",
	YellKill		= "Seine Macht über mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden." 
}

L:SetWarningLocalization{
	WarnPhase2		= "Phase 2",
	WarnSimulKill		= "Erster tot - Wiederbelebung in ~12 sec",
	WarnFury		= "Furor der Natur auf >%s<",
	SpecWarnFury		= "Furor der Natur auf dir!",
	WarningTremor		= "Bebende Erde - nichtmehr Zaubern!",
	WarnRoots		= "Eiserne Wurzeln auf >%s<",
	UnstableEnergy		= "Instabile Energie - lauf!"
}

L:SetTimerLocalization{
	TimerSimulKill		= "Wiederbelebung",
}

L:SetOptionLocalization{
	WarnPhase2		= "Warnung für Phase 2",
	WarnSimulKill		= "Warnung für erster der dreier Gruppe tot",
	WarnFury		= "Warnung für Furor der Natur",
	WarnRoots		= "Warnung für Gestärkte Eiserne Wurzeln",
	SpecWarnFury		= "Spezialwarnung für Furor der Natur",
	WarningTremor		= "Spezialwarnung für Bebende Erde",
	TimerSimulKill		= "Zeige Timer für gegner Wiederbelebung",
	UnstableEnergy		= "Spezialwarnung für Instabile Energie"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Spezialwarnung für Fäuste aus Stein",
	WarnFistofStone		= "Warnung für Fäuste aus Stein"
}


-------------------
-- Mimiron --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare		= "P3Wx2-Lasersalve",
	WarningPlasmaBlast	= "Plasma Blast on %s - heal",
	Phase2Engaged		= "Phase 2 - Aufstellung einnehmen",
	Phase3Engaged		= "Phase 3 - Aufstellung einnehmen",
	WarnShell		= "Brandbombe auf >%s<",
	WarnBlast		= "Plasmaeruption auf >%s<",
	MagneticCore		= ">%s< hat Magnetischer Kern",
	WarningShockBlast	= "Schockschlag - LAUF WEG",
	WarnBombSpawn		= "neuer Bombenbot"
}

L:SetTimerLocalization{
	ProximityMines		= "neue bewegungsempfindliche Minen",
	TimerHardmode		= "Hard Mode - Self-Destruct"
}

L:SetOptionLocalization{
	TimeToPhase2		= "Timer für Begin der 2. Phase",
	TimeToPhase3		= "Timer für Begin der 3. Phase",
	DarkGlare		= "Spezialwarnung für P3Wx2-Lasersalve",
	WarningShockBlast	= "Spezialwarnung für Schockschlag",
	WarnBlast		= "Warnung für Plasmaeruption",
	WarnShell		= "Warnung für Brandbombe",
	MagneticCore		= "Warnung für Magnetischer Kern",
	HealthFramePhase4	= "Zeige HP Anzeige in Phase 4",
	AutoChangeLootToFFA	= "Automatisch in Phase 3 auf freies Plündern einstellen",
	WarnBombSpawn		= "Warnung für Bombenbot",
	TimerHardmode		= "Zeige Timer für Hard Mode"
}

L:SetMiscLocalization{
	MobPhase1		= "Leviathan Mk II",
	MobPhase2		= "VX-001",
	MobPhase3		= "Aerial Command Unit",
	YellPull		= "Wir haben nicht viel Zeit, Freunde! Ihr werdet mir dabei helfen, meine neueste und großartigste Kreation zu testen. Bevor Ihr nun Eure Meinung ändert, denkt daran, dass Ihr mir etwas schuldig seid, nach dem Unfug, den Ihr mit dem XT-002 angestellt habt",

	YellHardPull		= "Warum habt Ihr das denn jetzt gemacht?",
	YellPhase2		= "WUNDERBAR! Das sind Ergebnisse nach meinem Geschmack! Integrität der Hülle bei 98,9 Prozent! So gut wie keine Dellen! Und weiter geht's.",
	YellPhase3		= "Danke Euch, Freunde! Eure Anstrengungen haben fantastische Daten geliefert!",
	YellPhase4		= "Vorversuchsphase abgeschlossen. Jetzt kommt der eigentliche Test!",
	LootMsg			= "([^%s]+).*Hitem:(%d+)"
}


--------------------
-- GeneralVezax --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "General Vezax"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Schattengeschoss auf dir",
	SpecialWarningSurgeDarkness	= "Sog der Dunkelheit",
	WarningShadowCrash		= "Schattengeschoss auf >%s<",
	SpecialWarningShadowCrashNear	= "Schattengeschoss in deiner Nähe!",
	WarningLeechLife		= "Mal der Gesichtslosen auf >%s<",
	SpecialWarningLLYou		= "Mal der Gesichtslosen auf dir!",
	SpecialWarningLLNear		= "Mal der Gesichtslosen auf >%s< in deiner Nähe!"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "Zeige Warnung für Schattengeschoss",
	SetIconOnShadowCrash		= "Setze Symbol auf Schattengeschoss Ziel",
	SetIconOnLifeLeach		= "Setze Symbol auf Mal der Gesichtslosen",
	SpecialWarningSurgeDarkness	= "Spezialwarnung für Sog der Dunkelheit",
	SpecialWarningShadowCrash	= "Spezialwarnung für Schattengeschoss",
	SpecialWarningLLYou		= "Spezialwarnung für Mal der Gesichtslosen auf DIR",
	SpecialWarningLLNear		= "Spezialwarnung für Mal der Gesichtslosen in deiner Nähe",
	CrashWhisper			= "Flüstere Spieler wenn er Ziel des Schattengeschoss ist",
	YellOnLifeLeech			= "Schreie bei Mal der Gesichtslosen",
	YellOnShadowCrash		= "Schreie bei Schattengeschoss",
	specWarnShadowCrashNear		= "Spezialwarnung bei Schattengeschoss in deiner Nähe"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper			= "Schattengeschoss auf dir! lauf weg!",
	YellLeech			= "Mal der Gesichtslosen auf mir!",
	YellCrash			= "Schattengeschoss auf mir!"
}


-----------------
-- YoggSaron --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 					= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2 					= "I am the lucid dream.",
	Sara 						= "Sara",
	WhisperBrainLink 			= "Brain Link auf dir! Run to %s!",
	WarningYellSqueeze			= "Quetschen auf mir! Hilfe!"
}

L:SetWarningLocalization{
	WarningP2 						= "Phase 2",
	WarningGuardianSpawned 			= "neuer Wächter",
	WarningCrusherTentacleSpawned	= "neues Mörderischen Schlammling",
	WarningBrainLink 				= "Gehirnverbindung auf >%s< und >%s<",
	SpecWarnBrainLink 				= "Gehirnverbindung zwischen dir and %s!",
	WarningSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnSanity 					= "%d Geistige Gesundheit übrig",
	SpecWarnGuardianLow 			= "Wächter nicht mehr angreifen!",
	WarnMadness						= "Wahnsinn hervorrufen",
	SpecWarnMadnessOutNow			= "Wahnsinn hervorrufen - LAUF RAUS",
	WarnBrainPortalSoon				= "Portal in 3 sec",	
	WarnSqueeze 					= "Quetschen: >%s<",
	WarnFavor						= "Saras Eifer auf >%s<",
	SpecWarnFavor					= "Saras Eifer auf dir!"
}

L:SetOptionLocalization{
	WarningP2						= "Warnung für Phase 2",
	WarningP3						= "Warnung für Phase 3",
	WarningGuardianSpawned			= "Warnung für neue Wächter",
	WarningCrusherTentacleSpawned	= "Warnung für neue Mörderischen Schlammling",
	WarningBrainLink				= "Warnung für Gehirnverbindung",
	SpecWarnBrainLink				= "Spezialwarnung bei Gehirnverbindung",
	WarningSanity					= "Zeige Warnung wenn Geistige Gesundheit niedrig",
	SpecWarnSanity					= "Spezialwarnung bei Geistige Gesundheit sehr niedrig",
	SpecWarnGuardianLow				= "Spezialwarnung bei Wächter (P1) ist kurz vor dem Tot (für DDs)",
	WarnMadness						= "Warnung für Wahnsinn hervorrufen",
	SpecWarnMadnessOutNow			= "Spezialwarnung kurz vor Ende von Wahnsinn hervorrufen",
	SpecWarnFavor					= "Spezialwarnung für Saras Eifer",
	WarnFavor						= "Warnung für Saras Eifer",
	WarnSqueeze						= "Warnung für Quetschen",
	WarnBrainPortalSoon				= "Warnung für Portale",
	specWarnBrainPortalSoon			= "Warnung für Brain Portal in Kürze",
	SetIconOnFearTarget				= "Setze Symbol auf Spieler mit Geisteskrankheit",
	SetIconOnMCTarget				= "Setze Symbol auf Spieler mit Gedanken beherrschen",
	SpecWarnMaladyNear				= "Spezialwarnung f�r Geisteskrankheit in deiner N�he"
}



