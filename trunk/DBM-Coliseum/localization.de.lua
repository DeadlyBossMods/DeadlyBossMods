if GetLocale() ~= "deDE" then return end

local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "Bestien von Nordend"
}

L:SetMiscLocalization{
	Charge			= "%%s sieht (%S+) zornig an und lässt einen gewaltigen Schrei ertönen!",
	CombatStart		= "Er kommt aus den tiefsten, dunkelsten Höhlen der Sturmgipfel - Gormok der Pfähler! Voran, Helden!",
	Phase2		= "Stählt Euch, Helden, denn die Zwillingsschrecken Ätzschlund und Schreckensmaul erscheinen in der Arena!",
	Phase3		= "Mit der Ankündigung unseres nächsten Kämpfers gefriert die Luft selbst: Eisheuler! Tötet oder werdet getötet, Champions!",
	Gormok		= "Gormok der Pfähler",
	Acidmaw		= "Ätzschlund",
	Dreadscale	= "Schreckensmaul",
	Icehowl		= "Eisheuler"
}

L:SetOptionLocalization{
	WarningSnobold				= "Zeige Warnung für nächsten Schneeboldvasall",
	SpecialWarningImpale3		= "Zeige Spezialwarnung für Pfählen (>=3 Stapel)",
	SpecialWarningAnger3		= "Zeige Spezialwarnung für Aufkochende Wut (>=3 Stapel)",
	SpecialWarningSilence		= "Zeige Spezialwarnung für Erschütterndes Stampfen (Stille)",
	SpecialWarningCharge		= "Zeige Spezialwarnung wenn Eisheuler dich niedertrampeln will",
	SpecialWarningTranq			= "Zeige Spezialwarnung wenn Eisheuler Schäumende Wut erhält (für Einlullenden Schuss/Beruhigendes Gift)",
	PingCharge					= "Ping die Minimap wenn Eisheuler dich niedertrampeln will",
	SpecialWarningChargeNear	= "Zeige Spezialwarnung wenn Eisheuler ein Ziel in deiner Nähe niedertrampeln will",
	SetIconOnChargeTarget		= "Setze Zeichen auf Ziele von Trampeln (Totenkopf)",
	SetIconOnBileTarget			= "Setze Zeichen auf Ziele von Brennende Galle",
	ClearIconsOnIceHowl			= "Entferne alle Zeichen vor dem Trampeln",
	TimerNextBoss				= "Zeige Timer für das Erscheinen des nächsten Bosses",
	TimerCombatStart			= "Zeige Timer für Kampfbeginn",
	TimerEmerge					= "Zeige Timer für Auftauchen",
	TimerSubmerge				= "Zeige Timer für Untertauchen",
	RangeFrame                  = "Zeige Abstandsfenster in Phase 2",
	IcehowlArrow				= "Zeige Pfeil wenn Eisheuler ein Ziel in deiner Nähe niedertrampeln will"
}

L:SetTimerLocalization{
	TimerNextBoss		= "Nächster Boss",
	TimerCombatStart	= "Kampf beginnt",
	TimerEmerge			= "Auftauchen",
	TimerSubmerge		= "Untertauchen"
}

L:SetWarningLocalization{
	WarningSnobold				= "Schneeboldvasall gespawnt",
	SpecialWarningImpale3		= "Pfählen >%d< auf dir",
	SpecialWarningAnger3		= "Aufkochende Wut >%d<",
	SpecialWarningSilence		= "Stille in ~1,5 Sekunden",
	SpecialWarningCharge		= "Stürmt dich an - Lauf weg",
	SpecialWarningChargeNear	= "Stürmt deine Nähe an - Lauf weg",
	SpecialWarningTranq			= "Schäumende Wut - Einlullen/Beruhigen"
}

---------------------
--  Lord Jaraxxus  --
---------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "Lord Jaraxxus"
}

L:SetWarningLocalization{
	WarnNetherPower				= "Macht des Nether auf Lord Jaraxxus - Jetzt dispellen",
	SpecWarnTouch				= "Jaraxxus' Berührung auf dir",
	SpecWarnTouchNear			= "Jaraxxus' Berührung auf %s in deiner Nähe",
	SpecWarnNetherPower			= "Jetzt dispellen",
	SpecWarnFelFireball			= "Teufelsfeuerball - Jetzt unterbrechen"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Kampf beginnt"
}

L:SetMiscLocalization{
	WhisperFlame		= "Legionsflamme auf dir",
	IncinerateTarget	= "Fleisch einäschern: %s"
}

L:SetOptionLocalization{
	TimerCombatStart			= "Zeige Timer für Kampfbeginn",
	WarnNetherPower				= "Zeige Warnung wenn Lord Jaraxxus Macht des Nether erhält (zum Dispellen/Rauben)",
	SpecWarnTouch				= "Zeige Spezialwarnung wenn du von Jaraxxus' Berührung betroffen bist",
	SpecWarnTouchNear			= "Zeige Spezialwarnung wenn ein Spieler mit Jaraxxus' Berührung in deiner Nähe ist",
	SpecWarnNetherPower			= "Zeige Spezialwarnung für Macht des Nether (zum Dispellen/Rauben)",
	SpecWarnFelFireball			= "Zeige Spezialwarnung für Teufelsfeuerball (zum Unterbrechen)",
	TouchJaraxxusIcon			= "Setze Zeichen auf Ziele von Jaraxxus' Berührung",
	IncinerateFleshIcon			= "Setze Zeichen auf Ziele von Fleisch einäschern",
	LegionFlameIcon				= "Setze Zeichen auf Ziele von Legionsflamme",
	LegionFlameWhisper			= "Sende Flüsternachricht an Ziele von Legionsflamme",
	LegionFlameRunSound			= "Spiele Sound bei Legionsflamme",
	IncinerateShieldFrame		= "Zeige Boss-Lebenspunkte mit Lebenspunktbalken für Fleisch einäschern"
}

L:SetMiscLocalization{
	FirstPull	= "Großhexenmeister Wilfred Zischknall wird Eure nächste Herausforderung beschwören. Harrt seiner Ankunft."
}

-------------------------
--  Faction Champions  --
-------------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "Fraktionschampions"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
}

L:SetMiscLocalization{
	Gorgrim            = "Tod - Gorgrim Schattenspalter",	-- 34458
	Birana             = "Dru - Birana Sturmhuf",			-- 34451
	Erin               = "Dru - Erin Nebelhuf",				-- 34459
	Rujkah             = "Jäg - Ruj'kah",					-- 34448
	Ginselle           = "Mag - Ginselle Seuchenwerfer",	-- 34449
	Liandra            = "Pal - Liandra Sonnenrufer",		-- 34445
	Malithas           = "Pal - Malithas Glanzklinge",		-- 34456
	Caiphus            = "Pri - Caiphus der Ernste",		-- 34447
	Vivienne           = "Pri - Vivienne Schwarzraunen",	-- 34441
	Mazdinah           = "Schu - Maz'dinah",				-- 34454
	Thrakgar           = "Scha - Thrakgar",					-- 34444
	Broln              = "Scha - Broln Starkhorn",			-- 34455
	Harkzog            = "Hex - Harkzog",					-- 34450
	Narrhok            = "Kri - Narrhok Stahlbrecher",		-- 34453
	AllianceVictory    = "EHRE DER ALLIANZ!",
	HordeVictory       = "That was just a taste of what the future brings. FOR THE HORDE!",	-- to be translated
	YellKill           = "Ein tragischer Sieg. Wir wurden schwächer durch die heutigen Verluste. Wer außer dem Lichkönig profitiert von solchen Torheiten? Große Krieger gaben ihr Leben. Und wofür? Die wahre Bedrohung erwartet uns noch - der Lichkönig erwartet uns alle im Tod."
} 

L:SetOptionLocalization{
	PlaySoundOnBladestorm	= "Spiele Sound bei Klingensturm"
}

---------------------
--  Val'kyr Twins  --
---------------------
L = DBM:GetModLocalization("ValkTwins")

L:SetGeneralLocalization{
	name = "Zwillingsval'kyr"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "Nächste Spezialfähigkeit"
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "Spezialfähigkeit bald",
	SpecWarnSpecial				= "Farbe wechseln",
	SpecWarnSwitchTarget		= "Ziel wechseln",
	SpecWarnKickNow				= "Jetzt unterbrechen",
	WarningTouchDebuff			= "Debuff auf >%s<",
	WarningPoweroftheTwins		= "Macht der Zwillinge - Mehr Heilung auf >%s<",
	SpecWarnPoweroftheTwins		= "Macht der Zwillinge"
}

L:SetMiscLocalization{
	YellPull	= "Im Namen unseres dunklen Meisters. Für den Lichkönig. Ihr. Werdet. Sterben.",
	Fjola		= "Fjola Lichtbann",
	Eydis		= "Eydis Nachtbann"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "Zeige Timer für nächste Spezialfähigkeit",
	WarnSpecialSpellSoon		= "Zeige Vorwarnung für nächste Spezialfähigkeit",
	SpecWarnSpecial				= "Zeige Spezialwarnung wenn du die Farbe wechseln musst",
	SpecWarnSwitchTarget		= "Zeige Spezialwarnung wenn der andere Zwilling zaubert",
	SpecWarnKickNow				= "Zeige Spezialwarnung zum Unterbrechen",
	SpecialWarnOnDebuff			= "Zeige Spezialwarnung bei Berührung (um Farbe zu wechseln)",
	SetIconOnDebuffTarget		= "Setze Zeichen auf Ziele von Berührung des Lichts/der Nacht (heroisch)",
	WarningTouchDebuff			= "Verkünde Ziele von Berührung des Lichts/der Nacht",
	WarningPoweroftheTwins		= "Verkünde Ziele von Macht der Zwillinge",
	SpecWarnPoweroftheTwins		= "Zeige Spezialwarnung wenn du einen gestärkten Zwilling tankst"
}

-----------------
--  Anub'arak  --
-----------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 					= "Anub'arak"
}

L:SetTimerLocalization{
	TimerEmerge				= "Auftauchen",
	TimerSubmerge			= "Abtauchen",
	timerAdds				= "Neue Adds"
}

L:SetWarningLocalization{
	WarnEmerge				= "Anub'arak taucht auf",
	WarnEmergeSoon			= "Auftauchen in 10 Sekunden",
	WarnSubmerge			= "Anub'arak taucht unter",
	WarnSubmergeSoon		= "Abtauchen in 10 Sekunden",
	specWarnSubmergeSoon	= "Abtauchen in 10 Sekunden!",
	SpecWarnPursue			= "Du wirst verfolgt - Lauf weg",
	warnAdds				= "Neue Adds",
	SpecWarnShadowStrike	= "Schattenhieb - Unterbreche jetzt"
}

L:SetMiscLocalization{
	YellPull				= "Dieser Ort wird Euch als Grab dienen!",
	Emerge					= "entsteigt dem Boden!",
	Burrow					= "gräbt sich in den Boden!",
	PcoldIconSet		= "DKälte-Zeichen {rt%d} auf %s gesetzt",
	PcoldIconRemoved	= "DKälte-Zeichen von %s entfernt"
}

L:SetOptionLocalization{
	WarnEmerge				= "Zeige Warnung für Auftauchen",
	WarnEmergeSoon			= "Zeige Vorwarnung für Auftauchen",
	WarnSubmerge			= "Zeige Warnung für Abtauchen",
	WarnSubmergeSoon		= "Zeige Vorwarnung für Abtauchen",
	specWarnSubmergeSoon	= "Zeige Spezialwarnung für Abtauchen bald",
	SpecWarnPursue			= "Zeige Spezialwarnung wenn du verfolgt wirst",
	warnAdds				= "Verkünde neue Adds",
	timerAdds				= "Zeige Timer für neue Adds",
	TimerEmerge				= "Zeige Timer für Auftauchen",
	TimerSubmerge			= "Zeige Timer für Abtauchen",
	PlaySoundOnPursue		= "Spiele Sound wenn du verfolgt wirst",
	PursueIcon				= "Setze Zeichen auf verfolgte Spieler",
	SpecWarnShadowStrike	= "Zeige Spezialwarnung für $spell:66134 (zum Unterbrechen)",
	RemoveHealthBuffsInP3	= "Entferne lebenspunktesteigernde Buffs in Phase 3",
	SetIconsOnPCold         = "Setze Zeichen auf Ziele von $spell:68510",
	AnnouncePColdIcons		= "Verkünde Zeichen von Zielen von $spell:68510 in Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
	AnnouncePColdIconsRemoved	= "Verkünde auch, wenn Zeichen für $spell:68510 entfernt werden\n(benötigt obige Option)"
}

