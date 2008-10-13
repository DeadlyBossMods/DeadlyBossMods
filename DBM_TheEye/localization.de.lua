if GetLocale() == "deDE" then
	DBM_TEMPEST_KEEP	= "Festung der Stürme";
	
	-- Void Reaver
	DBM_VOIDREAVER_NAME						= "Leerhäscher";
	DBM_VOIDREAVER_DESCRIPTION				= "Sagt Hämmern und Arkane Kugel an";
	DBM_VOIDREAVER_OPTION_WARN_ORB			= "Ziele von Arkane Kugel ansagen";
	DBM_VOIDREAVER_OPTION_YELL_ORB			= "Chat Nachricht verschicken, wenn Arkane Kugel auf dich gecastet wird";
	DBM_VOIDREAVER_OPTION_WARN_POUNDING		= "Hämmern ansagen";
	DBM_VOIDREAVER_OPTION_WARN_POUNDINGSOON	= "\"Hämmern bald\" Warnung anzeigen";

	DBM_VOIDREAVER_POUNDING					= "Hämmern";

	DBM_VOIDREAVER_WARN_ORB					= "*** Arkane Kugel auf >%s< ***";
	DBM_VOIDREAVER_YELL_ORB					= "Arkane Kugel kommt! Lauft weg!";
	DBM_VOIDREAVER_WARN_ENRAGE				= "*** Enrage in %s %s ***";
	DBM_VOIDREAVER_WARN_POUNDING			= "*** Hämmern ***";
	DBM_VOIDREAVER_WARN_POUNDING_SOON		= "*** Hämmern bald ***";
	DBM_VOIDREAVER_SPECWARN_ORB				= "Arkane Kugel auf dir!";
	
	DBM_VOIDREAVER_R_FURY					= "Zorn der Gerechtigkeit"
	
	DBM_SBT["Pounding"]						= "Hämmern";
	DBM_SBT["Next Pounding"]				= "Nächstes Hämmern";
	
	-- Solarian
	DBM_SOLARIAN_NAME						= "Hochastromant Solarian";
	DBM_SOLARIAN_DESCRIPTION				= "Sagt Zorn und ihre Adds an.";
	DBM_SOLARIAN_OPTION_WARN_WRATH			= "Zorn ansagen";
	DBM_SOLARIAN_OPTION_ICON_WRATH			= "Icon auf Zorn target setzen";
	DBM_SOLARIAN_OPTION_SPECWARN_WRATH		= "Special Warning anzeigen, wenn Zorn auf dir ist";
	DBM_SOLARIAN_OPTION_WARN_PHASE			= "Adds ansagen";

	DBM_SOLARIAN_DEBUFF_WRATH				= "([^%s]+) (%w+) von Zorn des Astromanten betroffen%." 
	DBM_SOLARIAN_CAST_SPLIT					= "Hochastromant Solarian wirkt Spalten des Astromanten.";
	DBM_SOLARIAN_YELL_ENRAGE				= "Enough of this!%s*Now I call upon the fury of the cosmos itself.";
	
	DBM_SOLARIAN_SPECWARN_WRATH				= "Zorn auf dir!";
	DBM_SOLARIAN_ANNOUNCE_WRATH				= "*** Zorn auf >%s< ***";
	DBM_SOLARIAN_ANNOUNCE_SPLIT				= "*** Adds kommen ***";
	DBM_SOLARIAN_ANNOUNCE_PRIESTS_SOON		= "*** Priester & Solarian in 5 Sek ***";
	DBM_SOLARIAN_ANNOUNCE_PRIESTS_NOW		= "*** Priester & Solarian ***";
	DBM_SOLARIAN_ANNOUNCE_AGENTS_NOW		= "*** Agenten ***";
	DBM_SOLARIAN_ANNOUNCE_SPLIT_SOON		= "*** Spalten in 5 Sekunden ***";
	DBM_SOLARIAN_ANNOUNCE_ENRAGE_PHASE		= "*** Voidwalker Phase ***";
	
	DBM_SBT["Split"]						= "Spalten";
	DBM_SBT["Priests & Solarian"]			= "Priester & Solarian";
	DBM_SBT["Agents"]						= "Agenten";
	
	
	-- Al'ar
	DBM_ALAR_NAME							= "Al'ar";
	DBM_ALAR_DESCRIPTION					= "Zeigt Timer und Warnungen für Al'ar.";
	DBM_ALAR_OPTION_MELTARMOR				= "Rüstungsschmelze ansagen";
	DBM_ALAR_OPTION_METEOR					= "Meteor ansagen";

	DBM_ALAR_DEBUFF_MELTARMOR				= "([^%s]+) (%w+) von Rüstungsschmelze betroffen%.";
	DBM_ALAR_DEBUFF_FIRE_YOU				= "Ihr seid von Flammenfeld betroffen.";
	DBM_ALAR_FLAME_BUFFET					= "Flammenfeld";


	DBM_ALAR_WARN_MELTARMOR					= "*** Rüstungsschmelze auf >%s< ***";
	DBM_ALAR_WARN_REBIRTH					= "*** Phase 2 ***";
	DBM_ALAR_WARN_FIRE						= "Flammenfeld";
	DBM_ALAR_WARN_ADD						= "*** Nächste Plattform - Add kommt ***";
	DBM_ALAR_WARN_METEOR					= "*** Meteor ***";
	DBM_ALAR_WARN_METEOR_SOON				= "*** Meteor bald ***";
	DBM_ALAR_WARN_ENRAGE					= "*** Enrage in %s %s ***";
	
	DBM_SBT["Next Platform"]				= "Nächste Plattform";
	DBM_SBT["Alar"]							= {
		[1] = {
			"Melt Armor: (.*)",
			"Rüstungsschmelze: %1",
		}
	}
	
	-- Kael'thas
	DBM_KAEL_NAME							= "Kael'thas Sonnenwanderer";
	DBM_KAEL_DESCRIPTION					= "Zeigt Timer und Warnungen für Kael'thas an.";

	DBM_KAEL_OPTION_PHASE					= "Phasen ansagen";
	DBM_KAEL_OPTION_ICON_P1					= "Icon auf Thaladreds Ziel setzen";
	DBM_KAEL_OPTION_WHISPER_P1				= "Whisper an Thaladreds Ziel schicken";
	DBM_KAEL_OPTION_RANGECHECK				= "Range Frame anzeigen wenn benötigt";
	DBM_KAEL_OPTION_CONFLAG					= "Großbrand ansagen";
	DBM_KAEL_OPTION_CONFLAG2				= "Großbrand in Phase 3 ansagen";
	DBM_KAEL_OPTION_CONFLAGTIMER2			= "Großbrand Timer in Phase 3 anzeigen";
	DBM_KAEL_OPTION_FEAR					= "Fear ansagen";
	DBM_KAEL_OPTION_FEARSOON				= "\"Fear bald\" Warnung anzeigen";
	DBM_KAEL_OPTION_TOY						= "Ferngesteuertes Spielzeug in Phase 1 ansagen";
	DBM_KAEL_OPTION_FRAME					= "HP der Waffen anzeigen";
	DBM_KAEL_OPTION_ADDFRAME				= "HP der Berater anzeigen";
	DBM_KAEL_OPTION_PYRO					= "Pyroschlag ansagen";
	DBM_KAEL_OPTION_BARRIER					= "Schockbarriere ansagen";
	DBM_KAEL_OPTION_BARRIER2				= "Schockbarriere in Phase 5 ansagen";
	DBM_KAEL_OPTION_PHOENIX					= "Phönixe ansagen";
	DBM_KAEL_OPTION_WARNMC					= "Gedankenkontrolle ansagen";
	DBM_KAEL_OPTION_ICONMC					= "Icons auf gedankenkontrollte setzen";
	DBM_KAEL_OPTION_GRAVITY					= "Announce gravity lapse"; --translate me 

	DBM_KAEL_YELL_PHASE1					= "Energie. Kraft. Mein Volk ist süchtig danach... Eine Abhängigkeit, die entstand, nachdem der Sonnenbrunnen zerstört wurde. Willkommen in der Zukunft. Ein Jammer, dass Ihr zu spät seid, um sie zu verhindern. Niemand kann mich jetzt noch aufhalten! Selama ashal'anore!";
	DBM_KAEL_EMOTE_THALADRED_TARGET			= "behält ([^%s]+) im Blickfeld!";
	DBM_KAEL_YELL_PHASE1_SANGUINAR			= "Ihr habt gegen einige meiner besten Berater bestanden... aber niemand kommt gegen die Macht des Bluthammers an. Zittert vor Fürst Blutdurst!";
	DBM_KAEL_YELL_PHASE1_CAPERNIAN			= "Capernian wird dafür sorgen, dass Euer Aufenthalt hier nicht lange währt.";
	DBM_KAEL_YELL_PHASE1_TELONICUS			= "Gut gemacht. Ihr habt Euch würdig erwiesen, gegen meinen Meisteringenieur, Telonicus, anzutreten.";
	DBM_KAEL_CAST_FEAR						= "Fürst Blutdurst beginnt Dröhnendes Gebrüll zu wirken.";
	DBM_KAEL_DEBUFF_FEAR1					= "betroffen von Dröhnendes Gebrüll";
	DBM_KAEL_DEBUFF_FEAR2					= "Blutdurst.*Dröhnendes Gebrüll";
	DBM_KAEL_DEBUFF_CONFLAGRATION			= "([^%s]+) (%w+) von Großbrand betroffen%.";
	DBM_KAEL_DEBUFF_REMOTETOY				= "([^%s]+) (%w+) von Ferngesteuertes Spielzeug betroffen%.";
	DBM_KAEL_YELL_THALA_DOWN				= "Vergebt mir, mein Prinz! Ich habe... versagt.";
	DBM_KAEL_YELL_CAPERNIAN_DOWN			= "Es ist noch nicht vorbei!";

	DBM_KAEL_YELL_PHASE2					= "Wie Ihr seht, habe ich viele Waffen in meinem Arsenal...";
	DBM_KAEL_YELL_PHASE3					= "Vielleicht habe ich Euch unterschätzt. Es wäre unfair, Euch gegen meine vier Berater gleichzeitig kämpfen zu lassen, aber... mein Volk wurde auch nie fair behandelt. Ich vergelte nur Gleiches mit Gleichem.";
	DBM_KAEL_YELL_PHASE4					= "Ach, manchmal muss man die Sache selbst in die Hand nehmen. Balamore shanal!";
	DBM_KAEL_YELL_PHASE5					= "I have not come this far to be stopped! The future I have planned will not be jeopardized! Now you will taste true power!!"; -- translate me

	DBM_KAEL_WEAPONS = {
		["Stab der Auflösung"] = 1,
		["Klinge der Unendlichkeit"] = 2,
		["Kosmische Macht"] = 3,
		["Warpschnitter"] = 4,
		["Verwüstung"] = 5,
		["Netherbespannter Langbogen"] = 6,
		["Phasenverschobenes Bollwerk"] = 7
	};
	DBM_KAEL_WEAPONS_NAMES = {
		"Stab",
		"Dolch",
		"Kolben",
		"Schwert",
		"Axt",
		"Bogen",
		"Schild"
	};


	DBM_KAEL_ADVISORS = {
		["Thaladred der Verfinsterer"] = 1,
		["Fürst Blutdurst"] = 2,
		["Großastromant Capernian"] = 3,
		["Meisteringenieur Telonicus"] = 4,
	};

	DBM_KAEL_ADVISORS_NAMES = {
		"Thaladred",
		"Blutdurst",
		"Capernian",
		"Telonicus"
	};

	DBM_KAEL_INFOFRAME_TITLE				= "Waffen";
	DBM_KAEL_INFOFRAME_ADDS_TITLE			= "Berater";

	DBM_KAEL_CAST_PYROBLAST					= "Kael'thas Sonnenwanderer beginnt Pyroschlag zu wirken.";
	DBM_KAEL_GAIN_SHOCK_BARRIER				= "Kael'thas Sonnenwanderer bekommt 'Schockbarriere'.";
	DBM_KAEL_FADE_SHOCK_BARRIER				= "Schockbarriere schwindet von Kael'thas Sonnenwanderer.";
	DBM_KAEL_CAST_PHOENIX					= "Kael'thas Sonnenwanderer wirkt Phönix.";
	DBM_KAEL_DEBUFF_MINDCONTROL				= "([^%s]+) (%w+) von Gedankenkontrolle betroffen%.";
	DBM_KAEL_FADE_MINDCONTROL				= "([^%s]+)%s?'s 'Gedankenkontrolle' wurde durch";
	DBM_KAEL_FADE_MINDCONTROL_YOU			= "Eure '?Gedankenkontrolle'? wurde durch"; --?
	DBM_KAEL_EGG							= "Phönixei";
	DBM_KAEL_YELL_GRAVITY_LAPSE				= "Having trouble staying grounded?"; --translate
	DBM_KAEL_YELL_GRAVITY_LAPSE2			= "Let us see how you fare when your world is turned upside down."; -- translate


	DBM_KAEL_SPECWARN_THALADRED_TARGET		= "Renn weg!";
	DBM_KAEL_WARN_THALADRED_TARGET			= "*** Thaladred behält >%s< im Blickfeld ***";
	DBM_KAEL_WHISPER_THALADRED_TARGET		= "Thaladred ist auf dir! Lauf weg!";
	DBM_KAEL_WARN_INC						= "*** %s kommt ***";
	DBM_KAEL_SANGUINAR						= "Fürst Blutdurst";
	DBM_KAEL_CAPERNIAN						= "Capernian";
	DBM_KAEL_TELONICUS						= "Telonicus";
	DBM_KAEL_WARN_FEAR						= "*** Fear in 1.5 Sek ***";
	DBM_KAEL_WARN_FEAR_SOON					= "*** Fear bald ***";
	DBM_KAEL_WARN_CONFLAGRATION				= "*** Großbrand auf >%s< ***";
	DBM_KAEL_WARN_REMOTETOY					= "*** Ferngesteuertes Spielzeug auf >%s< ***";

	DBM_KAEL_WARN_PHASE1					= "*** Phase 1 - Thaladred ***";
	DBM_KAEL_WARN_PHASE2					= "*** Phase 2 - Waffen ***";
	DBM_KAEL_WARN_PHASE3					= "*** Phase 3 - Adds ***";
	DBM_KAEL_WARN_PHASE4					= "*** Phase 4 - Kael'thas ***";
	DBM_KAEL_WARN_PHASE5					= "*** Phase 5 ***";

	DBM_KAEL_WARN_PYRO						= "*** Pyroschlag ***";
	DBM_KAEL_WARN_BARRIER_SOON				= "*** Schockbarriere in 5 Sek ***";
	DBM_KAEL_WARN_BARRIER_NOW				= "*** Schockbarriere ***";
	DBM_KAEL_WARN_BARRIER_DOWN				= "*** Schockbarriere down! ***";
	DBM_KAEL_WARN_PHOENIX					= "*** Phönix ***";
	DBM_KAEL_WARN_MC_TARGETS				= "*** Gedankenkontrolle: %s ***";
	DBM_KAEL_WARN_REBIRTH					= "*** Phönix tot - Ei gespawnt ***";
	DBM_KAEL_WARN_GRAVITY_LAPSE				= "*** Gravity Lapse ***"; -- translate me
	DBM_KAEL_GRAVITY_SOON					= "*** Gravity Lapse bald ***"; -- translate me
	DBM_KAEL_GRAVITY_END_SOON				= "*** Gravity Lapse hört in 5 Sek auf ***"; -- translate me

	DBM_SBT["Lord Sanguinar"]				= "Fürst Blutdurst";
	DBM_SBT["Next Fear"]					= "Nächster Fear";
	DBM_SBT["Pyroblast"]					= "Pyroschlag";
	DBM_SBT["Shock Barrier"]				= "Schockbarriere";
	DBM_SBT["Next Shock Barrier"]			= "Nächste Schockbarriere";
	DBM_SBT["Phoenix"]						= "Phönix";
	DBM_SBT["Rebirth"]						= "Widergeburt";
	DBM_SBT["Gravity Lapse"]				= "Gravity Lapse";
	DBM_SBT["Next Gravity Lapse"]			= "Next Gravity Lapse"; -- translate me
	
	DBM_SBT["KaelThas"]							= {
		[1] = {
			"Conflagration: (.*)",
			"Großbrand: %1",
		},
		[2] = {
			"Remote Toy: (.*)",
			"Spielzeug: %1",
		}
	}
	
end