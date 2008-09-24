if GetLocale() == "deDE" then
	DBM_BLACK_TEMPLE	= "Der Schwarze Tempel";

	-- High Warlord Naj'entus
	DBM_NAJENTUS_NAME				= "Oberster Kriegsfürst Naj'entus";
	DBM_NAJENTUS_DESCRIPTION		= "Sagt Aufspießender Stachel und Gezeitenschild an.";

	DBM_NAJENTUS_OPTION_ICON		= "Icon auf das Ziel von Aufspießender Stachel setzen";
	DBM_NAJENTUS_OPTION_RANGECHECK	= "Range Frame anzeigen";

	DBM_NAJENTUS_YELL_PULL			= "Im Namen Lady Vashjs werdet Ihr sterben!";
	DBM_NAJENTUS_DEBUFF_SPINE		= "([^%s]+) (%w+) von Aufspießender Stachel betroffen%.";
	DBM_NAJENTUS_DEBUFF_SHIELD		= "Oberster Kriegsfürst Naj'entus ist von Gezeitenschild betroffen.";
	DBM_NAJENTUS_FADE_SHIELD		= "Gezeitenschild schwindet von Oberster Kriegsfürst Naj'entus.";
	
	DBM_NAJENTUS_WARN_SPINE			= "*** Aufspießender Stachel auf >%s< ***";
	DBM_NAJENTUS_WARN_ENRAGE		= "*** Enrage in %s %s ***";
	DBM_NAJENTUS_WARN_SHIELD		= "*** Gezeitenschild ***";
	DBM_NAJENTUS_WARN_SHIELD_SOON	= "*** Gezeitenschild bald ***";
	
	DBM_NAJENTUS_FRAME_TITLE			= "Naj'entus"
	DBM_NAJENTUS_FRAME_TEXT				= "Spieler mit unter 8500 HP:"
	DBM_NAJENTUS_SPELL_PWS				= "Machtword: Schield"
	DBM_NAJENTUS_SPELL_FW				= "Frost Ward"
	DBM_NAJENTUS_SPELL_FB				= "Fel Blossom"
	
	DBM_SBT["Next Tidal Shield"]		= "Nächstes Gezeitenschild"
	
	
	-- Supremus
	DBM_SUPREMUS_NAME					= "Supremus";
	DBM_SUPREMUS_DESCRIPTION			= "Sagten Phasen und Ziele an.";
	DBM_SUPREMUS_OPTION_TARGETWARN		= "Supremus' Ziel in Phase 2 ansagen";
	DBM_SUPREMUS_OPTION_TARGETICON		= "Icon auf Supremus' Ziel setzen";
	DBM_SUPREMUS_OPTION_TARGETWHISPER	= "Whisper an Supremus' Ziel schicken";

	DBM_SUPREMUS_EMOTE_PHASE1			= "schlägt wütend auf den Boden!";
	DBM_SUPREMUS_EMOTE_PHASE2			= "Der Boden beginnt aufzubrechen!";
	DBM_SUPREMUS_EMOTE_NEWTARGET		= "ein neues Ziel!";
	DBM_SUPREMUS_DEBUFF_FIRE			= "Ihr seid von Glühende Flamme betroffen.";
	DBM_SUPREMUS_DEBUFF_VOLCANO			= "You are afflicted by Volcanic Geyser.";

	DBM_SUPREMUS_WARN_KITE_TARGET		= "Target: >%s<";
	DBM_SUPREMUS_WARN_PHASE_1_SOON		= "*** Tank-Phase in 10 Sek ***";
	DBM_SUPREMUS_WARN_PHASE_2_SOON		= "*** Kite-Phase in 10 Sek ***";
	DBM_SUPREMUS_WARN_PHASE_1			= "*** Tank-Phase ****";
	DBM_SUPREMUS_WARN_PHASE_2			= "*** Kite-Phase ***";
	DBM_SUPREMUS_SPECWARN_FIRE			= "Feuer!";
	DBM_SUPREMUS_SPECWARN_VOLCANO		= "Vulkan!";
	DBM_SUPREMUS_WHISPER_RUN_AWAY		= "Lauf weg!";
	
	DBM_SBT["Tank & Spank Phase"]		= "Tank Phase"
	
	-- Shade of Akama
	DBM_AKAMA_NAME						= "Akamas Schemen";
	DBM_AKAMA_DESCRIPTION				= nil;

	DBM_AKAMA_MOB_AKAMA					= "Akama";
	DBM_AKAMA_MOB_CHANNELER				= "Kanalisierer der Aschenzungen";
	DBM_AKAMA_MOB_SORCERER				= "Zauberhexer der Aschenzungen";
	DBM_AKAMA_MOB_DIES					= "%s stirbt.";

	DBM_AKAMA_WARN_CHANNELER_DOWN		= "**** %s/6 Kanalisierer tot ****";
	DBM_AKAMA_WARN_SORCERER_DOWN		= "**** %s Zauberhexer tot ****";
	
	-- Teron Gorefiend
	DBM_GOREFIEND_NAME					= "Teron Blutschatten";
	DBM_GOREFIEND_DESCRIPTION			= "Sagt Schatten des Todes und Verbrennen an.";

	DBM_GOREFIEND_OPTION_INCINERATE		= "Verbrennen ansagen";

	DBM_GOREFIEND_YELL_PULL				= "Die Rache ist mein!";
	DBM_GOREFIEND_DEBUFF_SOD			= "([^%s]+) (%w+) von Schatten des Todes betroffen%.";
	DBM_GOREFIEND_DEBUFF_INCINERATE		= "([^%s]+) (%w+) von Verbrennen betroffen%.";

	DBM_GOREFIEND_WARN_SOD				= "*** Schatten des Todes: >%s< ***";
	DBM_GOREFIEND_WARN_INCINERATE		= "*** Verbrennen: >%s< ***";

	DBM_GOREFIEND_SPECWARN_SOD			= "Schatten des Todes";
	
	DBM_SBT["TeronGorefiend"]			= {
		{
			"Vengeful Spirit: (.*)",
			"Geist: %1",
		},
		{
			"Shadow of Death: (.*)",
			"Schatten: %1",
		}
	}
	
	
	-- Bloodboil
	DBM_BLOODBOIL_NAME					= "Gurtogg Siedeblut";
	DBM_BLOODBOIL_DESCRIPTION			= "Sagt Siedeblut und Teufelswut an.";
	DBM_BLOODBOIL_OPTION_SMASH			= "Bogenzerkracher ansagen";

	DBM_BLOODBOIL_YELL_PULL				= "Horde... wird Euch zerschmettern.";
	DBM_BLOODBOIL_DEBUFF_BLOODBOIL		= "von Siedeblut betroffen";
	DBM_BLOODBOIL_GAIN_FEL_RAGE			= "Gurtogg Siedeblut bekommt 'Teufelswut'.";
	DBM_BLOODBOIL_FADE_FEL_RAGE			= "Teufelswut schwindet von Gurtogg Siedeblut.";
	DBM_BLOODBOIL_DEBUFF_FEL_RAGE		= "([^%s]+) (%w+) von Teufelswut betroffen%.";
	DBM_BLOODBOIL_DEBUFF_SMASH			= "([^%s]+) (%w+) von Bogenzerkracher betroffen%.";

	DBM_BLOODBOIL_WARN_BLOODBOIL		= "*** Siedeblut #%s ***";
	DBM_BLOODBOIL_WARN_ENRAGE			= "*** Enrage in %s %s ***";
	DBM_BLOODBOIL_WARN_FELRAGE_SOON		= "*** Teufelswut bald ***";
	DBM_BLOODBOIL_WARN_NORMAL_SOON		= "*** Normale Phase in 5 Sek ***";
	DBM_BLOODBOIL_WARN_FELRAGE			= "*** Teufelswut auf >%s< ***";
	DBM_BLOODBOIL_WARN_NORMALPHASE		= "*** Normale Phase ***";
	DBM_BLOODBOIL_WARN_SMASH			= "*** Bogenzerkracher ***";
	DBM_BLOODBOIL_WARN_SMASH_SOON		= "*** Bogenzerkracher bald ***";
	
	DBM_SBT["Fel Rage"]					= "Teufelswut"
	DBM_SBT["Bloodboil"]				= "Siedeblut"
	DBM_SBT["Normal Phase"]				= "Normale Phase"
	
	-- Essence (Reliquary) of Souls
	DBM_SOULS_NAME						= "Reliquiar der Verirrten"
	DBM_SOULS_DESCRIPTION				= "Sagt Enrage, Fixieren, Seelensauger, Runenschild, Abstumpfen und Bosheit an."
	DBM_SOULS_OPTION_DRAIN				= "Seelensauger ansagen"
	DBM_SOULS_OPTION_DRAIN_CAST			= "Seelensauger Cast ansagen (für Massenbannung)"
	DBM_SOULS_OPTION_FIXATE				= "Fixieren ansagen"
	DBM_SOULS_OPTION_SPITE				= "Bosheit ansagen"
	DBM_SOULS_OPTION_SCREAM				= "Seelenschrei ansagen"
	DBM_SOULS_OPTION_SPECWARN_SPITE		= "Special warning anzeigen, wenn Bosheit auf dir ist"
	DBM_SOULS_OPTION_WHISPER_SPITE		= "Whisper an Spieler mit Bosheit schicken"

	DBM_SOULS_BOSS_KILL_NAME			= "Essenz des Zorns"
	DBM_SOULS_YELL_PULL					= "Auf Euch warten nur Schmerz und Leid!"
	DBM_SOULS_EMOTE_ENRAGE				= "%s wird wütend!"
	DBM_SOULS_GAIN_RUNESHIELD			= "Essenz der Begierde bekommt 'Runenschild'."
	DBM_SOULS_CAST_SPIRIT_SHOCK			= "Essenz der Begierde beginnt Geistschock zu wirken."
	DBM_SOULS_CAST_DEADEN				= "Essenz der Begierde beginnt Abstumpfen zu wirken."
	DBM_SOULS_CAST_SOULDRAIN			= "Essenz des Leidens beginnt Seelensauger zu wirken."
	DBM_SOULS_YELL_DESIRE				= "Ihr könnt alles haben, was Ihr wollt... doch es hat einen Preis."
	DBM_SOULS_YELL_DESIRE_DEMONIC		= "Shi shi rikk rukadare shi tichar kar x gular"
	DBM_SOULS_DEBUFF_SPITE				= "([^%s]+) (%w+) von Bosheit betroffen%."
	DBM_SOULS_DEBUFF_SOULDRAIN			= "([^%s]+) (%w+) von Seelensauger betroffen%."
	DBM_SOULS_DEBUFF_FIXATE				= "([^%s]+) (%w+) von Fixieren betroffen%."
	DBM_SOULS_CAST_SOULSCREAM			= "Essenz des Zorns%s?'s Seelenschrei trifft"
	DBM_SOULS_YELL_ANGER_INC			= "Seid auf der Hut, ich lebe!"

	DBM_SOULS_WARN_ENRAGE_SOON			= "*** Enrage bald ***"
	DBM_SOULS_WARN_ENRAGE				= "*** Enrage ***"
	DBM_SOULS_WARN_ENRAGE_OVER			= "*** Enrage vorbei ***"
	DBM_SOULS_WARN_RUNESHIELD			= "*** Runenschild ***"
	DBM_SOULS_WARN_RUNESHIELD_SOON		= "*** Runenschild in 3 Sek ***"
	DBM_SOULS_WARN_DEADEN				= "*** Abstumpfen ****"
	DBM_SOULS_WARN_DEADEN_SOON			= "*** Abstumpfen in 5 Sek ***"
	DBM_SOULS_WARN_DESIRE_INC			= "*** Essenz der Begierde - Null Mana in ~3 Minuten ***"
	DBM_SOULS_WARN_MANADRAIN			= "*** Null Mana in 20 Sek ***"
	DBM_SOULS_WARN_SPITE				= "*** Bosheit auf %s ***"
	DBM_SOULS_WARN_SOULDRAIN			= "*** Seelensauger auf %s ***"
	DBM_SOULS_WARN_SOULDRAIN_CAST		= "*** Seelensauger wird gezaubert ***"
	DBM_SOULS_WARN_FIXATE				= "*** Fixieren: >%s< ***"
	DBM_SOULS_SPECWARN_FIXATE			= "Fixieren!"
	DBM_SOULS_WARN_SCREAM				= "*** Seelenschrei ***"
	DBM_SOULS_SPECWARN_SPITE			= "Bosheit!"
	DBM_SOULS_WARN_ANGER_INC			= "*** Essenz des Zorns ***"
	DBM_SOULS_WHISPER_SPITE				= "Bosheit auf dir!"
	
	DBM_SBT["Next Enrage"]				= "Nächster Enrage"
	DBM_SBT["Mana Drain"]				= "Manasauger"
	DBM_SBT["Rune Shield"]				= "Runenschild"
	DBM_SBT["Deaden"]					= "Abstumpfen"
	DBM_SBT["Soul Scream"]				= "Seelenschrei"
	DBM_SBT["Souls"]					= {
		[1] = {
			"Fixate: (.*)",
			"Fixieren: %1",
		}
	}
	
	-- Mother Shahraz
	DBM_SHAHRAZ_NAME					= "Mutter Shahraz"
	DBM_SHAHRAZ_DESCRIPTION				= "Sagt Verhängnisvolle Affäre an und setzt Icons auf die Targets."
	DBM_SHAHRAZ_OPTION_BEAM				= "Strahlen ansagen"
	DBM_SHAHRAZ_OPTION_BEAM_SOON		= "\"Strahl bald\" Warnung anzeigen"

	DBM_SHAHRAZ_YELL_PULL				= "Also... Geschäft oder Vergnügen?"
	DBM_SHAHRAZ_AFFLICT_FA				= "([^%s]+) (%w+) von Verhängnisvolle Affäre betroffen."
	DBM_SHAHRAZ_BEAM_VILE				= "von Übler Strahl betroffen"
	

	DBM_SHAHRAZ_BEAM_SINISTER			= "Mutter Shahraz%s?'s Finsterer Strahl"
	DBM_SHAHRAZ_BEAM_SINFUL				= "Mutter Shahraz%s?'s Sündhafter Strahl"
	DBM_SHAHRAZ_BEAM_WICKED				= "Mutter Shahraz%s?'s Heimtückischer Strahl"
	DBM_SHAHRAZ_WARN_ENRAGE				= "*** Enrage in %s %s ***"
	DBM_SHAHRAZ_WARN_FA					= "*** Verhängnisvolle Affäre auf %s ***"
	DBM_SHAHRAZ_SPECWARN_FA				= "Verhängnisvolle Affäre"
	DBM_SHAHRAZ_WHISPER_FA				= "Verhängnisvolle Affäre auf dir!"
	DBM_SHAHRAZ_WARN_BEAM_VILE			= "*** Übler Strahl ***"
	DBM_SHAHRAZ_WARN_BEAM_SINISTER		= "*** Finsterer Strahl ***"
	DBM_SHAHRAZ_WARN_BEAM_SINFUL		= "*** Sündhafter Strahl ***"
	DBM_SHAHRAZ_WARN_BEAM_WICKED		= "*** Heimtückischer Strahl ***"	
	DBM_SHAHRAZ_WARN_BEAM_SOON			= "*** Strahl in 3 Sek ***"
	
	DBM_SBT["Next Beam"]				= "Nächster Strahl"

	-- Illidari Council
	DBM_COUNCIL_NAME					= "Rat der Illidari"
	DBM_COUNCIL_DESCRIPTION				= "Sagt Kreis der Heilung, Tödliches Gift, Göttlicher Zorn, Verschwinden und Schilde an."
	DBM_COUNCIL_OPTION_COH				= "Kreis der Heilung ansagen"
	DBM_COUNCIL_OPTION_DP				= "Tödliches Gift ansagen"
	DBM_COUNCIL_OPTION_DW				= "Göttlicher Zorn ansagen"
	DBM_COUNCIL_OPTION_VANISH			= "Verschwinden ansagen"
	DBM_COUNCIL_OPTION_VANISHFADED		= "Warnung anzeigen, wenn Veras wieder da ist"
	DBM_COUNCIL_OPTION_VANISHFADESOON	= "Warnung 5 Sekunden bevor Veras wieder da ist anzeigen"
	DBM_COUNCIL_OPTION_SN				= "Reflektierender Schild ansagen"
	DBM_COUNCIL_OPTION_SS				= "Zauberschild ansagen"
	DBM_COUNCIL_OPTION_SM				= "Meleeschild ansagen"
	DBM_COUNCIL_OPTION_DEVAURA			= "Aura der Hingabe ansagen"
	DBM_COUNCIL_OPTION_RESAURA			= "Aura der Hingabe ansagen"

	DBM_COUNCIL_MOB_GATHIOS				= "Gathios der Zerschmetterer"
	DBM_COUNCIL_MOB_MALANDE				= "Lady Malande"
	DBM_COUNCIL_MOB_ZEREVOR				= "Hochnethermant Zerevor"
	DBM_COUNCIL_MOB_VERAS				= "Veras Schwarzschatten"
	
	DBM_COUNCIL_MOB_GATHIOS_EN			= "Gathios the Shatterer"
	DBM_COUNCIL_MOB_MALANDE_EN			= "Lady Malande"
	DBM_COUNCIL_MOB_ZEREVOR_EN			= "High Nethermancer Zerevor"
	DBM_COUNCIL_MOB_VERAS_EN			= "Veras Darkshadow"
	
	DBM_COUNCIL_YELL_PULL1				= "Gemeinsprache... welch barbarische Zunge. Bandal!"
	DBM_COUNCIL_YELL_PULL2				= "Wollt Ihr mich auf die Probe stellen?"
	DBM_COUNCIL_YELL_PULL3				= "Ich habe Besseres zu tun..."
	DBM_COUNCIL_YELL_PULL4				= "Flieht oder sterbt!"

	DBM_COUNCIL_CAST_COH				= "Lady Malande beginnt Kreis der Heilung zu wirken."
	DBM_COUNCIL_HEAL_COH				= "Lady Malande%s?'s Kreis der Heilung heilt"
	DBM_COUNCIL_INTERRUPT_COH			= "unterbricht Kreis der Heilung von Lady Malande"
	DBM_COUNCIL_BUFF_VANISH				= "Veras Schwarzschatten bekommt 'Verschwinden'."
	DBM_COUNCIL_FADE_VANISH				= "Verschwinden schwindet von Veras Schwarzschatten."
	DBM_COUNCIL_DEBUFF_POISON			= "([^%s]+) (%w+) von Tödliches Gift betroffen"
	DBM_COUNCIL_BUFF_SPELLWARD			= "(.-) bekommt 'Segen des Zauberschutzes'."
	DBM_COUNCIL_BUFF_PROTECTION			= "(.-) bekommt 'Segen des Schutzes'."
	DBM_COUNCIL_BUFF_SHIELD				= "Lady Malande bekommt 'Reflektierender Schild'."
	DBM_COUNCIL_DEBUFF_WRATH			= "([^%s]+) (%w+) von Göttlicher Zorn betroffen."
	DBM_COUNCIL_BUFF_DEV_AURA			= "bekommt 'Aura der Hingabe'"
	DBM_COUNCIL_BUFF_RES_AURA			= "bekommt 'Aura des chromatischen Widerstands'"

	DBM_COUNCIL_WARN_CAST_COH			= "Kreis der Heilung"
	DBM_COUNCIL_WARN_POISON				= "Tödliches Gift auf >%s<"
	DBM_COUNCIL_WARN_SHIELD_NORMAL		= "Reflektierender Schild"
	DBM_COUNCIL_WARN_SHIELD_SPELL		= "Zauberschild auf %s"
	DBM_COUNCIL_WARN_SHIELD_MELEE		= "Meleeschild auf %s"
	DBM_COUNCIL_WARN_VANISH				= "Verschwinden"
	DBM_COUNCIL_WARN_VANISH_FADED		= "Veras wieder da"
	DBM_COUNCIL_WARN_WRATH				= "Göttlicher Zorn auf >%s<"
	DBM_COUNCIL_WARN_AURA_DEV			= "Aura der Hingabe"
	DBM_COUNCIL_WARN_AURA_RES			= "Aura des Widerstands"
	DBM_COUNCIL_WARN_VANISHFADE_SOON	= "Veras in 5 Sec wieder da"
	
	DBM_SBT["Circle of Healing"]		= "Kreis der Heilung"
	DBM_SBT["Next Circle of Healing"]	= "Nächster Kreis der Heilung"
	DBM_SBT["Reflective Shield"]		= "Reflektierender Schild"
	DBM_SBT["Vanish"]					= "Verschwinden"
	DBM_SBT["Devotion Aura"]			= "Aura der Hingabe"
	DBM_SBT["Resistance Aura"]			= "Aura des Widerstands"
	DBM_SBT["Council"]					= {
		{
			"Spell Shield: (.*)",
			"Zauberschild: %1",
		},
		{
			"Melee Shield: (.*)",
			"Meleeschild: %1",
		},
	}
	
	
	-- Illidan Stormrage
	DBM_ILLIDAN_NAME					= "Illidan Sturmgrimm"
	DBM_ILLIDAN_DESCRIPTION				= "Sagt Phasen, Abscheren, Schattengeister, Sperrfeuer, Eye Blast, Peinigende Flammen, Schattendämonen, Flammenexplosion und Enrage an."
	DBM_ILLIDAN_OPTION_RANGECHECK		= "Range Check Frame in Phase 3 anzeigen"
	DBM_ILLIDAN_OPTION_PHASES			= "Phasen ansagen"
	DBM_ILLIDAN_OPTION_SHEARCAST		= "Abscheren Cast ansagen"
	DBM_ILLIDAN_OPTION_SHEAR			= "Abscheren ansagen"
	DBM_ILLIDAN_OPTION_SHADOWFIEND		= "Schattengeister ansagen"
	DBM_ILLIDAN_OPTION_ICONFIEND		= "Icons auf Schattengeister-Ziele setzen"
	DBM_ILLIDAN_OPTION_BARRAGE			= "Dunkles Sperrfeuer ansagen"
	DBM_ILLIDAN_OPTION_BARRAGE_SOON		= "\"Sperrfeuer bald\" Warnung anzeigen"
	DBM_ILLIDAN_OPTION_EYEBEAM			= "Eye Blast ansagen"
	DBM_ILLIDAN_OPTION_FLAMES			= "Peinigende Flammen ansagen"
	DBM_ILLIDAN_OPTION_DEMONFORM		= "Dämonen/Normale Form ansagen"
	DBM_ILLIDAN_OPTION_FLAMEBURST		= "Flammenexplosion ansagen"
	DBM_ILLIDAN_OPTION_SHADOWDEMONS		= "Schattendämonen ansagen"
	DBM_ILLIDAN_OPTION_EYEBEAMSOON		= "\"Eye Blast bald\" Warnung anzeigen"

	DBM_ILLIDAN_YELL_PULL				= "Die Zeit ist gekommen: der Augenblick ist endlich da!"
	DBM_ILLIDAN_DEBUFF_SHEAR			= "([^%s]+) (%w+) von Abscheren betroffen"
	DBM_ILLIDAN_DEBUFF_SHADOWFIEND		= "([^%s]+) (%w+) von Schädlicher Schattengeist betroffen"
	DBM_ILLIDAN_DEBUFF_DARKBARRAGE		= "([^%s]+) (%w+) von Dunkles Sperrfeuer betroffen"
	DBM_ILLIDAN_YELL_EYEBEAM			= "Blickt in die Augen des Verräters!"
	DBM_ILLIDAN_DEBUFF_FLAMES			= "([^%s]+) (%w+) von Peinigende Flammen betroffen"
	DBM_ILLIDAN_CAST_PHASE2				= "Klinge von Azzinoth wirkt Träne von Azzinoth beschwören."
	DBM_ILLIDAN_YELL_DEMONFORM			= "Erzittert vor der Macht des Dämonen!"
	DBM_ILLIDAN_YELL_PHASE4				= "War's das schon, Sterbliche? Ist das alles, was Ihr zu bieten habt?"
	DBM_ILLIDAN_FLAME_DOWN				= "Flamme von Azzinoth stirbt."
	DBM_ILLIDAN_CAST_FLAMEBURST			= "Flammenexplosion trifft ([^%s]+)"
--	DBM_ILLIDAN_CAST_SHADOWDEMS			= "Illidan Stormrage begins to cast Summon Shadow Demons." -- nobody should be in range for this event (damage aura)
	DBM_ILLIDAN_SPELL_SHADOWDEMONS		= "Schattendämonen beschwören"
	DBM_ILLIDAN_SPELL_SHEAR				= "Abscheren "
	DBM_ILLIDAN_YELL_START				= "Akama. Euer falsches Spiel überrascht mich nicht. Ich hätte Euch und Eure missgestalteten Brüder schon vor langer Zeit abschlachten sollen."
	DBM_ILLIDAN_DEBUFF_DEMON			= "([^%s]+) (%w+) von Paralysieren betroffen"

	DBM_ILLIDAN_WARN_SHEAR				= "Abscheren auf >%s<"
	DBM_ILLIDAN_WARN_SHADOWFIEND		= "Schattengeist auf >%s<"
	DBM_ILLIDAN_WARN_BARRAGE			= "Dunkles Sperrfeuer auf >%s<"
	DBM_ILLIDAN_WARN_BARRAGE_SOON		= "Dunkles Sperrfeuer bald"
	DBM_ILLIDAN_WARN_EYEBEAM			= "Eye Blast"
	DBM_ILLIDAN_WARN_FLAMES				= "Peinigende Flammen auf %s"
	DBM_ILLIDAN_WARN_PHASE2				= "Phase 2"
	DBM_ILLIDAN_WARN_PHASE3				= "Phase 3"
	DBM_ILLIDAN_WARN_PHASE4				= "Phase 4"
	DBM_ILLIDAN_WARN_PHASE_DEMON		= "Dämonen Phase"
	DBM_ILLIDAN_WARN_FLAMEBURST			= "Flammenexplosion #%s"
	DBM_ILLIDAN_WARN_FLAMEBURST_SOON	= "Flammenexplosion bald"
	DBM_ILLIDAN_WARN_SHADOWDEMSSOON		= "Schattendämonen bald"
	DBM_ILLIDAN_WARN_SHADOWDEMS			= "Schattendämonen"
	DBM_ILLIDAN_WARN_NORMALPHASE_SOON	= "Normale Phase in 10 Sek"
	DBM_ILLIDAN_WARN_CASTSHEAR			= "Abscheren wird gezaubert"
	DBM_ILLIDAN_WARN_EYEBEAM_SOON		= "Eye Blast bald"
	DBM_ILLIDAN_WARN_PHASE_NORMAL		= "Normale Phase"
	DBM_ILLIDAN_WARN_DEMONPHASE_SOON	= "Dämonen Phase in 10 Sek"
	DBM_ILLIDAN_WARN_SHADOWDEMSON		= "Schattendämonen auf %s"
	DBM_ILLIDAN_STATUSMSG_PHASE2		= "Phase 2"

	DBM_ILLIDAN_SELFWARN_SHADOWFIEND	= "Schädlicher Schattengeist"
	DBM_ILLIDAN_SELFWARN_SHADOW			= "Peinigende Flammen"
	DBM_ILLIDAN_SELFWARN_DEMONS			= "Schattendämon"
	
	DBM_SBT["Next Dark Barrage"]		= "Nächstes Sperrfeuer"
	DBM_SBT["Demon Phase"]				= "Dämonen Phase"
	DBM_SBT["Normal Phase"]				= "Normale Phase"
	DBM_SBT["Shadow Demons"]			= "Schattendämonen"
	DBM_SBT["Next Flame Burst"]			= "Nächste Flammenexplosion"
	DBM_SBT["Illidan"]					= {
		{
			"Shear: (.*)",
			"Abscheren: %1",
		},
		{
			"Shadowfiend: (.*)",
			"Schattengeist: %1",
		},
		{
			"Dark Barrage: (.*)",
			"Sperrfeuer: %1",
		},
		{
			"Flames: (.*)",
			"Flammen: %1",
		},
	}
end
