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
-- Algalon --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "Algalon the Observer"
}

L:SetTimerLocalization{
	TimerBigBangCast	= "Big Bang cast",
}
L:SetWarningLocalization{
	WarningPhasePunch	= "Phase Punch auf >%s<",
	WarningBlackHole	= "Black Hole",
}

L:SetOptionLocalization{
	TimerBigBangCast	= "Show Castbar for Big Bang",
	SpecWarnPhasePunch	= "Spezialwarnung bei Phase Punch on you",
	WarningPhasePunch	= "Warnung für Phase Punch target",
	WarningBlackHole	= "Warnung für Black Hole",
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
	WarnGrip			= "Steinerner Griff auf >%s<"
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
	achievementDisarmed		= "Zeige Timer fpr Armlos Erfolg"
}

L:SetMiscLocalization{
	Yell_Trigger_arm_left		= "Just a scratch!",
	Yell_Trigger_arm_right		= "Only a flesh wound!",
	Health_Body			= "Kologarn Body",
	Health_Right_Arm		= "right Arm",
	Health_Left_Arm			= "left Arm"
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
	WarningFlashFreeze	= "Flash Freeze",
	WarningStormCloud	= "Storm Cloud auf >%s<", 
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "Flash Freeze incoming", -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "Show Flash Freeze Cast-Timer",
	WarningFlashFreeze	= "Zeige Warnung für Flash Freeze",
	PlaySoundOnFlashFreeze	= "Play sound on Flash Freeze Cast",
	WarningStormCloud	= "Warnung für Storm Cloud Players",
	YellOnStormCloud	= "Yell when Storm Cloud active",
	SetIconOnStormCloud	= "Setze Symbol auf Storm Cloud Target"
}

L:SetMiscLocalization{
	YellKill		= "Ich... bin von ihm befreit... endlich.", 
	YellCloud		= "Storm Cloud on me!"
}


--------------
-- Thorim --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "Thorim"
}

L:SetWarningLocalization{
	WarningStormhammer		= "Stormhammer auf >%s<",
	UnbalancingStrike		= "Unbalancing Strike auf >%s<",
	WarningPhase2			= "Phase 2",
	WarningLightningCharge		= "Lightning Charge",
	WarningBomb			= "Rune Detonation auf >%s<",
	LightningOrb			= "Lightning Shock auf dir! Move!"
}

L:SetTimerLocalization{
	TimerHardmode			= "Hard Mode"
}

L:SetOptionLocalization{
	TimerHardmode			= "Zeige Timer für Hard Mode",
	UnbalancingStrike		= "Warnung für Unbalancing Strike Target",
	WarningStormhammer		= "Warnung für Stormhammer Target",
	WarningLightningCharge		= "Warnung für Lightning Charge",
	WarningPhase2			= "Warnung für Phase 2",
	UnbalancingStrike		= "Warnung für Unbalancing Strike",
	WarningBomb			= "Warnung für Rune Detonation",
	RangeFrame			= "Show Range Frame"
}

L:SetMiscLocalization{
	YellPhase1		= " Eindringlinge! Ihr Sterblichen, die Ihr es wagt, Euch in mein Vergnügen einzumischen, werdet... Wartet... Ihr...",
	YellPhase2		= "Ihr unverschämtes Geschmeiß! Ihr wagt es, mich in meinem Refugium herauszufordern? Ich werde Euch eigenhändig zerschmettern!",
	YellKill		= "Senkt Eure Waffen! Ich ergebe mich!",	
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!",
	YellKill		= "Stay your arms! I yield!"
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
	WarnSimulKill		= "First add down - Resurrection in ~12 sec",
	WarnFury		= "Nature's Fury auf >%s<",
	SpecWarnFury		= "Nature's Fury auf dir!",
	WarningTremor		= "Ground Tremor - Stop Casting!",
	WarnRoots		= "Roots auf >%s<",
	UnstableEnergy		= "Unstable Energy - MOVE"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam	= "Sun Beam: %s",
	TimerSimulKill		= "Resurrection",
	TimerFuryYou		= "Nature's Fury on you"
}

L:SetOptionLocalization{
	WarnPhase2		= "Warnung für Phase2",
	WarnSimulKill		= "Warnung für first mob down",
	WarnFury		= "Warnung für Nature's Fury target",
	WarnRoots		= "Warnung für Iron Roots targets",
	SpecWarnFury		= "Spezialwarnung für Nature's Fury",
	WarningTremor		= "Spezialwarnung für Ground Tremor (hard mode)",
	TimerSimulKill		= "Zeige Timer für mob resurrection",
	UnstableEnergy		= "Spezialwarnung für Unstable Energy"
}

-- Elders
L = DBM:GetModLocalization("Freya_Elders")

L:SetGeneralLocalization{
	name = "Freya's Elders"
}

L:SetOptionLocalization{
	SpecWarnFistOfStone	= "Spezialwarnung für Fist of Stone",
	WarnFistofStone		= "Warnung für Fist of Stone"
}


-------------------
-- Mimiron --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "Mimiron"
}

L:SetWarningLocalization{
	DarkGlare		= "Laser Barrage",
	WarningPlasmaBlast	= "Plasma Blast on %s - heal",
	Phase2Engaged		= "Phase 2 incoming - regroup now",
	Phase3Engaged		= "Phase 3 incoming - regroup now",
	WarnShell		= "Napalm Shells auf >%s<",
	WarnBlast		= "Plasma Blast auf >%s<",
	MagneticCore		= ">%s< got Magnetic Core",
	WarningShockBlast	= "Shock Blast - LAUF WEG",
	WarnBombSpawn		= "Bomb Bot spawned"
}

L:SetTimerLocalization{
	ProximityMines		= "New Proximity Mines",
	TimerHardmode		= "Hard Mode - Self-Destruct"
}

L:SetOptionLocalization{
	DarkGlare		= "Spezialwarnung für Laser Barrage",
	WarningShockBlast	= "Spezialwarnung für Shock Blast",
	WarnBlast		= "Warnung für Plasma Blast target",
	WarnShell		= "Warnung für Napalm Shells target",
	TimeToPhase2		= "begin Phase 2",
	TimeToPhase3		= "begin Phase 3",
	MagneticCore		= "Warnung für Magnetic Core looter",
	HealthFramePhase4	= "Zeige HP Anzeige in Phase 4",
	AutoChangeLootToFFA	= "Auto Switch Looting to FreeForAll in Phase3",
	WarnBombSpawn		= "Warnung für Bomb Bots",
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
	SpecialWarningShadowCrash	= "Shadow Crash auf dir",
	SpecialWarningSurgeDarkness	= "Surge of Darkness",
	WarningShadowCrash		= "Shadow Crash auf >%s<",
	SpecialWarningShadowCrashNear	= "Shadow Crash in deiner Nähe!",
	WarningLeechLife		= "Life Leech auf >%s<",
	SpecialWarningLLYou		= "Life Leech auf dir!",
	SpecialWarningLLNear		= "Life Leech on %s in deiner Nähe!"
}

L:SetOptionLocalization{
	WarningShadowCrash		= "Zeige Warnung für Shadow Crash",
	SetIconOnShadowCrash		= "Setze Symbol auf Shadow Crash target (skull)",
	SetIconOnLifeLeach		= "Setze Symbol auf Life Leech target (cross)",
	SpecialWarningSurgeDarkness	= "Spezialwarnung für Surge of Darkness",
	SpecialWarningShadowCrash	= "Spezialwarnung für Shadow Crash",
	SpecialWarningLLYou		= "Spezialwarnung für Life Leach auf DIR",
	SpecialWarningLLNear		= "Spezialwarnung für Life Leach in near of you",
	CrashWhisper			= "Flüstere Spieler wenn er Shadow Crash Target ist",
	YellOnLifeLeech			= "Schreie bei Life Leech",
	YellOnShadowCrash		= "Schreie bei Shadow Crash",
	specWarnShadowCrashNear		= "Spezialwarnung bei Shadow Crash near you"
}

L:SetMiscLocalization{
	EmoteSaroniteVapors		= "A cloud of saronite vapors coalesces nearby!",
	CrashWhisper			= "Shadow Crash auf dir! Run away!",
	YellLeech			= "Life Leech on me!",
	YellCrash			= "Shadow Crash on me!"
}


-----------------
-- YoggSaron --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "Yogg-Saron"
}

L:SetMiscLocalization{
	YellPull 		= "The time to strike at the head of the beast will soon be upon us! Focus your anger and hatred on his minions!",
	YellPhase2 		= "I am the lucid dream.",
	Sara 			= "Sara",
	WhisperBrainLink 	= "Brain Link auf dir! Run to %s!",
	WarningYellSqueeze	= "Squeeze on me! Help me!"
}

L:SetWarningLocalization{
	WarningGuardianSpawned 		= "Guardian spawned",
	WarningCrusherTentacleSpawned	= "Crusher Tentacle Spawned",
	WarningP2 			= "Phase 2",
	WarningBrainLink 		= "Brain Link auf >%s< and >%s<",
	SpecWarnBrainLink 		= "Brain Link on you and %s!",
	WarningSanity 			= "%d Sanity debuffs remaining",
	SpecWarnSanity 			= "%d Sanity debuffs remaining",
	SpecWarnGuardianLow 		= "Stop attacking this Guardian!",
	WarnMadness			= "Casting Induce Madness",
	SpecWarnMadnessOutNow		= "Madness ends - LAUF RAUS",
	WarnBrainPortalSoon		= "Portal in 3 sec",	
	WarnSqueeze 			= "Squeeze: >%s<",
	WarnFavor			= "Sara's Favor auf >%s<",
	SpecWarnFavor			= "Sara's Favor auf DIR"
}

L:SetOptionLocalization{
	WarningGuardianSpawned		= "Warnung für Guardian Spawns",
	WarningCrusherTentacleSpawned	= "Warnung für Crusher Tentacle Spawns",
	WarningP2			= "Warnung für Phase 2",
	WarningP3			= "Warnung für Phase 3",
	WarningBrainLink		= "Warnung für Brain Links",
	SpecWarnBrainLink		= "Spezialwarnung bei Brain Linked",
	WarningSanity			= "Zeige Warnung wennSanity low",
	SpecWarnSanity			= "Spezialwarnung bei Sanity very low",
	SpecWarnGuardianLow		= "Spezialwarnung bei Guardian (P1) is low (for DDs)",
	WarnMadness			= "Warnung für Madness",
	WarnBrainPortalSoon		= "Warnung für Portal",
	SpecWarnMadnessOutNow		= "Show Special Warning shortly before Madness ends",
	SetIconOnFearTarget		= "Setze Symbol auf Fear Target",
	WarnFavor			= "Warnung für Sara's Fervor target",
	SpecWarnFavor			= "Spezialwarnung für Sara's Fervor",
	WarnSqueeze			= "Warnung für Squeeze target",
	specWarnBrainPortalSoon		= "Warnung für Brain Portal soon"
}



