if GetLocale() == "deDE" then
	DBM_COILFANG = "Höhle des Schlangenschreins";
	
	
	-- Hydross the Unstable
	DBM_HYDROSS_NAME			= "Hydross der Unstete";
	DBM_HYDROSS_DESCRIPTION		= "Sagt Mark, Phasen und Wassergrab an.";
	DBM_HYDROSS_OPTION_1		= "Range Check Frame anzeigen";
	DBM_HYDROSS_OPTION_2		= "Mark ansagen";
	DBM_HYDROSS_OPTION_3		= "5 Sekunden Warnungen für alle Marks anzeigen";
	DBM_HYDROSS_OPTION_4		= "Phasen ansagen";
	DBM_HYDROSS_OPTION_5		= "Wassergrab ansagen";

	DBM_HYDROSS_YELL_PULL		= "Ich kann nicht zulassen, dass Ihr Euch einmischt!";
	DBM_HYDROSS_YELL_NATURE		= "Aaah, das Gift...";
	DBM_HYDROSS_YELL_FROST		= "Besser, viel besser.";

	DBM_HYDROSS_MARK_FROST		= "von Mal von Hydross betroffen";
	DBM_HYDROSS_MARK_NATURE		= "von Mal der der Verderbnis betroffen";
	DBM_HYDROSS_WATER_TOMB		= "([^%s]+) (%w+) von Wassergrab betroffen%.";

	DBM_HYDROSS_FROST_MARK_NOW	= "*** Frost Mark #%s ***";
	DBM_HYDROSS_NATURE_MARK_NOW	= "*** Natur Mark #%s ***";
	DBM_HYDROSS_FROST_SOON		= "*** Frost Mark #%s in 5 Sek ***";
	DBM_HYDROSS_NATURE_SOON		= "*** Natur Mark #%s in 5 Sek ***";

	DBM_HYDROSS_FROST_PHASE		= "*** Frost Phase ***";
	DBM_HYDROSS_NATURE_PHASE	= "*** Natur Phase ***";

	DBM_HYDROSS_TOMB_WARN		= "*** Wassergrab auf >%s< ***";
	
	-- Morogrim Tidewalker
	DBM_TIDEWALKER_NAME					= "Morogrim Gezeitenwandler";
	DBM_TIDEWALKER_DESCRIPTION			= "Sagt nasses Grab und Murlocs an.";
	DBM_TIDEWALKER_OPTION_1				= "Murlocs ansagen";
	DBM_TIDEWALKER_OPTION_2				= "Nasses Grab ansagen";
	DBM_TIDEWALKER_YELL_PULL			= "Die Fluten der Tiefen werden euch verschlingen."
	DBM_TIDEWALKER_EMOTE_MURLOCS		= "Das heftige Erdbeben hat nahe Murlocs alarmiert!";
	DBM_TIDEWALKER_EMOTE_GRAVE			= "%s schickt seine Feinde in ihr nasses Grab!";
	DBM_TIDEWALKER_EMOTE_GLOBES			= "%s beschwört Wasserkugeln!";
	DBM_TIDEWALKER_DEBUFF_GRAVE			= "([^%s]+) (%w+) von Nasses Grab betroffen.";

	DBM_TIDEWALKER_WARN_MURLOCS			= "*** Murlocs ***";
	DBM_TIDEWALKER_WARN_MURLOCS_SOON	= "*** Murlocs bald ***";
	DBM_TIDEWALKER_WARN_GRAVE			= "*** Nasses Grab auf %s ***";
	DBM_TIDEWALKER_WARN_GLOBES			= "*** Wasserkugeln ***";
	
	DBM_SBT["Watery Grave"]				= "Nasses Grab";
	
	-- Fathom-Lord Karathress
	DBM_FATHOMLORD_NAME					= "Tiefenlord Karathress";
	DBM_FATHOMLORD_DESCRIPTION			= "Sagt Feuerspuckendes Totem und Welle der Heilung an.";

	DBM_FATHOMLORD_YELL_PULL			= "Achtung, Wachen! Wir haben Besuch...";
	DBM_FATHOMLORD_OPTION_TOTEM_1		= "Tiefenwächter Flutvess' Totem ansagen";
	DBM_FATHOMLORD_OPTION_TOTEM_2		= "Tiefenlord Karathress' Totem ansagen";
	DBM_FATHOMLORD_OPTION_HEAL			= "Welle der Heilung ansagen";

	DBM_FATHOMLORD_TIDALVESS_TOTEM		= "Tiefenwächter Flutvess wirkt Feuerspuckendes Totem.";
	DBM_FATHOMLORD_KARATHRESS_TOTEM		= "Tiefenlord Karathress wirkt Feuerspuckendes Totem.";
	DBM_FATHOMLORD_CAST_HEAL			= "Tiefenwächter Caribdis beginnt Welle der Heilung zu wirken.";

	DBM_FATHOMLORD_SFTOTEM1_WARN		= "*** Feuerspuckendes Totem @ Flutvess ***";
	DBM_FATHOMLORD_SFTOTEM2_WARN		= "*** Feuerspuckendes Totem @ Karathress ***";
	DBM_FATHOMLORD_HEAL_WARN			= "*** Welle der Heilung ***";
	
	DBM_SBT["Healing Wave"]				= "Welle der Heilung";
	
	-- The Lurker Below
	DBM_LURKER_NAME						= "Das Grauen aus der Tiefe";
	DBM_LURKER_DESCRIPTION				= "Sagt Schwall, Wirbel und die Phasen an.";
	DBM_LURKER_OPTION_WHIRL				= "Announce Whirl";
	DBM_LURKER_OPTION_WHIRLSOON			= "Show \"Whirl soon\" warning";
	DBM_LURKER_OPTION_SPOUT				= "Schwall ansagen";
	
	DBM_LURKER_EMOTE_SPOUT				= "%s atmet tief ein!";
	DBM_LURKER_CAST_SPOUT				= "Das Grauen aus der Tiefes Schwall";
	DBM_LURKER_CAST_WHIRL				= "Das Grauen aus der Tiefes Geysir";
	DBM_LURKER_CAST_GEYSER				= "Das Grauen aus der Tiefes Wirbel trifft ([^%s]+) f";

	DBM_LURKER_WARN_SPOUT_SOON			= "*** Schwall bald ***";
	DBM_LURKER_WARN_SPOUT				= "*** Schwall ***";
	DBM_LURKER_WARN_SUBMERGE			= "*** Untergetaucht ***";
	DBM_LURKER_WARN_EMERGE				= "*** Aufgetaucht ***";

	DBM_LURKER_WARN_WHIRL				= "*** Wirbel ***";
	DBM_LURKER_WARN_WHIRL_SOON			= "*** Wirbel bald ***";

	DBM_LURKER_WARN_SUBMERGE_SOON		= "*** Untertauchen in %s Sek ***";
	
	DBM_SBT["Next Spout"]				= "Nächster Schwall";
	DBM_SBT["Spout"]					= "Schwall";
	DBM_SBT["Whirl"]					= "Wirbel";
	DBM_SBT["Submerge"]					= "Untertauchen";
	
	-- Leotheras the Blind
	DBM_LEO_NAME						= "Leotheras der Blinde";
	DBM_LEO_DESCRIPTION					= "Sagt Wirbelwind, Innere Dämonen und seine Phasen an.";
	DBM_LEO_OPTION_WHIRL				= "Wirbelwind ansagen";
	DBM_LEO_OPTION_DEMON				= "Innere Dämonen ansagen";

	DBM_LEO_YELL_PULL					= "Endlich hat meine Verbannung ein Ende!";
	DBM_LEO_YELL_DEMON					= "Hinfort, unbedeutender Elf%.%s*Ich habe jetzt die Kontrolle!"; -- stupid spaces...there are 2 spaces at the moment :[
	DBM_LEO_YELL_SHADOW					= "Nein... nein! Was habt Ihr getan? Ich bin der Meister! Hört Ihr? Ich! Ich bin... aaaaah! Ich kann ihn... nicht aufhalten..."; -- ?
	DBM_LEO_GAIN_WHIRLWIND				= "Leotheras der Blinde bekommt 'Wirbelwind'.";
	DBM_LEO_FADE_WHIRLWIND				= "Wirbelwind schwindet von Leotheras der Blinde.";
	DBM_LEO_DEBUFF_WHISPER				= "([^%s]+) (%w+) von Heimtückisches Geflüster betroffen.";
	DBM_LEO_CAST_WHISPER				= "Leotheras der Blinde beginnt Heimtückisches Geflüster zu wirken.";
	DBM_LEO_YELL_WHISPER				= "Wir haben alle unsere Dämonen";

	DBM_LEO_WARN_ENRAGE					= "*** Enrage in %s %s ***";
	DBM_LEO_WARN_WHIRL					= "*** Wirbelwind ***";
	DBM_LEO_WARN_WHIRL_SOON				= "*** Wirbelwind in 5 Sek ***";
	DBM_LEO_WARN_WHIRL_SOON_2			= "*** Wirbelwind bald ***";
	DBM_LEO_WARN_WHIRL_FADED			= "*** Wirbelwind zu Ende ***";
	DBM_LEO_WARN_SHADOW					= "*** Schatten von Leotheras ***";
	DBM_LEO_WARN_DEMON_PHASE			= "*** Dämonen Phase ***";
	DBM_LEO_WARN_NORMAL_PHASE			= "*** Normale Phase ***";
	DBM_LEO_WARN_DEMON_PHASE_SOON		= "*** Dämonen Phase in 5 Sek ***";
	DBM_LEO_WARN_NORMAL_PHASE_SOON		= "*** Normale Phase in 5 Sek ***";
	DBM_LEO_SPECWARN_INNER_DEMON		= "Innerer Dämon";
	DBM_LEO_WHISPER_INNER_DEMON			= "Töte deinen inneren Dämon!"
	DBM_LEO_WARN_DEMONS_INC				= "*** Innere Dämonen incoming ***";
	DBM_LEO_WARN_DEMONS_NOW				= "*** Innere Dämonen ***";
	
	DBM_SBT["Demon Form"]				= "Dämonen Form";
	DBM_SBT["Next Whirlwind"]			= "Nächster Wirbelwind";
	DBM_SBT["Normal Form"]				= "Normale Form";
	DBM_SBT["Inner Demons"]				= "Innere Dämonen";
	DBM_SBT["Whirlwind"]				= "Wirbelwind";
	
	-- Lady Vashj
	DBM_VASHJ_NAME						= "Lady Vashj";
	DBM_VASHJ_DESCRIPTION				= "Sagt Statische Aufladung, Spawns, Phasen, Besudelte Kerne, Schilde und Enrage and.";

	DBM_VASHJ_OPTION_RANGECHECK			= "Distanz Frame anzeigen";
	DBM_VASHJ_OPTION_CHARGE				= "Statische Aufladung ansagen";
	DBM_VASHJ_OPTION_CHARGEICON			= "Icon auf Spieler mit Statische Aufladung setzen";
	DBM_VASHJ_OPTION_SPAWNS				= "Spawns in Phase 2 ansagen";
	DBM_VASHJ_OPTION_COREWARN			= "Besudelte Kerne ansagen";
	DBM_VASHJ_OPTION_COREICON			= "Icon auf Spieler mit Besudelten Kernen setzen";
	DBM_VASHJ_OPTION_CORESPECWARN		= "Special Warning anzeigen, wenn du einen Besudelten Kern hast";


--[[DBM_VASHJ_YELL_PULL1				= "I spit on you, surface filth! ";
	DBM_VASHJ_YELL_PULL2				= "Victory to Lord Illidan! ";
	DBM_VASHJ_YELL_PULL3 				= "Death to the outsiders! Victory to Lord Illidan! ";
	DBM_VASHJ_YELL_PULL4				= "I did not wish to low myself by engaging your kind, but you leave me little coice... ";]]
	DBM_VASHJ_CAST_CHARGE				= "([^%s]+) (%w+) von Statische Aufladung betroffen%.";
	DBM_VASHJ_YELL_PHASE2				= "Die Zeit ist gekommen! Lasst keinen am Leben!";
	DBM_VASHJ_ELEMENT_DIES				= "Besudelter Elementar";
	DBM_VASHJ_FADE_SHIELD				= "Magiebarriere schwindet von Lady Vashj.";
	DBM_VASHJ_DEBUFF_CORE				= "([^%s]+) (%w+) von Paralysieren betroffen%.";
	DBM_VASHJ_YELL_PHASE3				= "Geht besser in Deckung!";


	DBM_VASHJ_WARN_CHARGE				= "*** Statische Aufladung auf >%s< ***";
	DBM_VASHJ_SPECWARN_CHARGE			= "Statische Aufladung auf dir!";

	DBM_VASHJ_WARN_PHASE2				= "*** Phase 2 ***";
	DBM_VASHJ_WARN_ELE_SOON				= "*** Besudelter Elementar in 5 Sek ***";
	DBM_VASHJ_WARN_ELE_NOW				= "*** Besudelter Elementar ***";
	DBM_VASHJ_WARN_STRIDER_SOON			= "*** Schreiter in 5 Sek ***";
	DBM_VASHJ_WARN_STRIDER_NOW			= "*** Schreiter ***";
	DBM_VASHJ_WARN_NAGA_SOON			= "*** Naga in 5 Sek ***";
	DBM_VASHJ_WARN_NAGA_NOW				= "*** Naga ***";
	DBM_VASHJ_WARN_SHIELD_FADED			= "*** Schild %d/4 down ***";
	DBM_VASHJ_WARN_CORE_LOOT			= "*** >%s< hat den Besudelten Kern  ***";
	DBM_VASHJ_SPECWARN_CORE				= "Du hast den Besudelten Kern!";

	DBM_VASHJ_WARN_PHASE3				= "*** Schild 4/4 down - Phase 3 ***";
	DBM_VASHJ_WARN_ENRAGE				= "*** Enrage in %s %s ***";
	
	DBM_SBT["Strider"]					= "Schreiter";
	DBM_SBT["Tainted Elemental"]		= "Besudelter Elementar";
	DBM_SBT["Vashj"] = {
	   [1] = {
		  [1] = "Static Charge: (.*)",
		  [2] = "Statische Aufladung: %1",
	   },
	};

end