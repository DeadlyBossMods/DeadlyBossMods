if GetLocale() == "deDE" then
	--Attumen
	DBM_ATH_NAME			= "Attumen der Jäger";
	DBM_ATH_DESCRIPTION		= "Zeigt einen Timer für seinen Fluch.";
	DBM_ATH_OPTION_1		= "5 Sekunden Warnung anzeigen";

	DBM_ATH_WARN_CURSE		= "*** Fluch ***";
	DBM_ATH_CURSE_SOON		= "*** Fluch bald ***";

	DBM_ATH_MIDNIGHT		= "Mittnacht";
	DBM_ATH_CURSE			= "von Körperlose Präsenz betroffen";
	DBM_ATH_YELL_1			= "Komm Mittnacht, lass' uns dieses Gesindel auseinander treiben!";

	DBM_SBT["Curse"]		= "Fluch";

	--Moroes
	DBM_MOROES_NAME			= "Moroes";
	DBM_MOROES_DESCRIPTION	= "Zeigt einen Timer für Verschwinden an.";
	DBM_MOROES_OPTION_1		= "\"Verschwinden\" Warnung anzeigen";
	DBM_MOROES_OPTION_2		= "\"Wieder da\" Warnung anzeigen";
	DBM_MOROES_OPTION_3		= "\"Verschwinden bald\" Warnung anzeigen";
	DBM_MOROES_OPTION_4		= "Erdrosseln Warnung anzeigen";

	DBM_MOROES_VANISH_WARN	= "*** Vanish ***";
	DBM_MOROES_VANISH_FADED	= "*** Moroes ist wieder da ***";
	DBM_MOROES_VANISH_SOON	= "*** Vanish bald ***";
	DBM_MOROES_GARROTE_WARN	= "*** Erdrosseln auf >%s< ***";


	DBM_MOROES_YELL_START	= "Hm, unangekündigte Besucher. Es müssen Vorbereitungen getroffen werden";
	DBM_MOROES_VANISH_GAIN	= "Moroes bekommt 'Verschwinden'.";
	DBM_MOROES_VANISH_FADES	= "Verschwinden schwindet von Moroes.";
	DBM_MOROES_GARROTE		= "([^%s]+) (%w+) von Erdrosseln betroffen%.";
	
	DBM_SBT["Vanish"]		= "Verschwinden";

	-- Maiden of Virtue
	DBM_MOV_NAME			= "Tugendhafte Maid";
	DBM_MOV_DESCRIPTION		= "Zeigt einen Timer für Buße.";
	DBM_MOV_OPTION_1		= "Reichweiten Check";
	DBM_MOV_OPTION_2		= "Heiliges Feuer ansagen";
	
	
	DBM_MOV_YELL_PULL		= "Euer Verhalten wird nicht toleriert.";
	DBM_MOV_REPENTANCE		= "ist von Buße betroffen";
	DBM_MOV_YELL_REP_1		= "Löst Euch von Euren verdorbenen Gedanken";
	DBM_MOV_YELL_REP_2		= "Eure Unreinheit muss geläutert werden";
	DBM_MOV_WARN_REP		= "*** Buße ***";
	DBM_MOV_WARN_REP_SOON	= "*** Buße bald ***";
	DBM_SBT["Repentance Cooldown"]	= "Buße Cooldown";
		
	DBM_MOV_DEBUFF_HOLYFIRE	= "([^%s]+) (%w+) von Heiliges Feuer betroffen%.";
	DBM_MOV_WARN_HOLYFIRE	= "*** Heiliges Feuer auf >%s< ***";


	-- Romulo and Julianne
	DBM_RJ_NAME				= "Romulo und Julianne";
	DBM_RJ_DESCRIPTION		= "Sagt Romulos Wagemutig und Juliannes Hingabe an.";
	DBM_RJ_OPTION_1			= "Juliannes Heilung ansagen";

	DBM_RJ_DARING_WARN		= "*** Wagemutig auf Romulo ***";
	DBM_RJ_DEVOTION_WARN	= "*** Hingabe auf Julianne ***";
	DBM_RJ_HEAL_WARN		= "*** Heilung ***";

	DBM_RJ_ROMULO			= "Romulo";
	DBM_RJ_JULIANNE			= "Julianne";
	DBM_RJ_GAIN_DARING		= "Romulo bekommt 'Wagemutig'.";
	DBM_RJ_GAIN_DEVOTION 	= "Julianne bekommt 'Hingabe'.";
	DBM_RJ_CAST_HEAL		= "Julianne beginnt Ewige Zuneigung zu wirken.";
	DBM_RJ_PHASE2_YELL		= "Komm, milde, liebevolle Nacht! Komm, gibt mir meinen Romulo zurück!";
	DBM_SBT["Heal"]			= "Heilung";
	
	-- Big Bad Wolf
	DBM_BBW_NAME			= "Der große böse Wolf";
	DBM_BBW_DESCRIPTION		= "Zeigt einen Timer für Rotkäppchen.";
	DBM_BBW_OPTION_1		= "Fear ansagen";

	DBM_BBW_YELL_1			= "The better to own you with!";
	DBM_BBW_GAIN_DEBUFF		= "([^%s]+) bekommt 'Rotkäppchen";
	DBM_BBW_AFFLICTED_DEBUFF= "([^%s]+) (%w+) von Rotkäppchen betroffen";

	DBM_BBW_YOU_GAIN		= "Ihr bekommt 'Rotkäppchen'."
	DBM_BBW_FEAR_EXP		= "Erschreckendes Gebrüll";

	DBM_BBW_FEAR_WARN		= "*** Fear ***";
	DBM_BBW_FEAR_SOON		= "*** Fear bald ***";
	DBM_BBW_RRH_WARN		= "*** >%s< ist Rotkäppchen ***";
	DBM_BBW_RUN_AWAY		= "Renn weg!";
	DBM_BBW_RUN_AWAY_WHISP	= "Du bist Rotkäppchen! Renn weg!";
	
	DBM_SBT["Red Riding Hood"]		= "Rotkäppchen";
	DBM_SBT["Next Red Riding Hood"]	= "Nächstes Rotkäppchen";
	
	-- Curator
	DBM_CURA_NAME			= "Der Kurator";
	DBM_CURA_DESCRIPTION	= "Zeigt einen Timer für seine Hervorrufung.";

	DBM_CURA_YELL_PULL		= "Die Menagerie ist nur für Gäste.";
	DBM_CURA_YELL_OOM		= "Ihre Anfrage kann nicht bearbeitet werden.";

	DBM_CURA_EVO_NOW		= "*** Hervorrufung ***";
	DBM_CURA_EVO_SOON		= "*** Hervorrufung bald ***";
	
	DBM_SBT["Evocation"]		= "Hervorrufung";
	DBM_SBT["Next Evocation"]	= "Nächste Hervorrufung";

	-- Terestian Illhoof
	DBM_TI_NAME				= "Terestian Siechhuf";
	DBM_TI_DESCRIPTION		= "Sagt Opferung und Schwäche Phasen an.";
	DBM_TI_OPTION_1			= "Wichtel Respawn ansagen";

	DBM_TI_YELL_PULL		= "Ah, Ihr kommt genau richtig. Die Rituale fangen gleich an!";
	DBM_TI_SACRIFICE		= "([^%s]+) (%w+) von Opferung betroffen%.";
	DBM_TI_EMOTE_IMP		= "%s stößt einen Schmerzensschrei aus und zeigt auf ihren Meister.";
	DBM_TI_CAST_IMP			= "Terestian Siechhuf wirkt Imp beschwören.";

	DBM_TI_SACRIFICE_WARN	= "*** >%s< wird geopfert ***";
	DBM_TI_SACRIFICE_SOON	= "*** Opferung bald ***";
	DBM_TI_WEAKENED_WARN	= "*** Geschwächt ***";
	DBM_TI_IMP_SOON			= "*** Wichtel Respawn bald ***";
	DBM_TI_IMP_RESPAWNED	= "*** Wichtel wieder da ***";
		
	DBM_SBT["Sacrifice"]	= "Opferung";
	DBM_SBT["Weakened"]		= "Geschwächt";

	-- Shade of Aran
	DBM_ARAN_NAME			= "Arans Schemen";
	DBM_ARAN_DESCRIPTION	= "Sagt Flammenkranz und Arkane Explosion an.";

	DBM_ARAN_CAST_WREATH	= "Arans Schemen beginnt Flammenkranz zu wirken.";
	DBM_ARAN_CAST_AE		= "Arans Schemen beginnt Arkane Explosion zu wirken.";
	DBM_ARAN_CAST_BLIZZ		= "Arans Schemen beginnt Blizzard beschwören zu wirken.";
	DBM_ARAN_YELL_ADDS		= "Ich bin noch nicht fertig! Nein, ich habe noch ein paar Tricks auf Lager…";
	DBM_ARAN_YELL_BLIZZ1	= "Zurück in die eisige Finsternis mit Euch!";
	DBM_ARAN_YELL_BLIZZ2	= "Ich werde Euch alle einfrieren!";

	DBM_ARAN_WREATH_WARN	= "*** Flammenkranz in 5 Sekunden ***";
	DBM_ARAN_AE_WARN		= "*** Arkane Explosion ***";
	DBM_ARAN_BLIZZ_WARN		= "*** Blizzard ***";
	DBM_ARAN_ADDS_WARN		= "*** Elementare ***";
	DBM_ARAN_DO_NOT_MOVE	= "Nicht bewegen!";
	
	DBM_SBT["Arcane Explosion"]		= "Arkane Explosion";
	DBM_SBT["Flame Wreath"]			= "Flammenkranz";
	DBM_SBT["Flame Wreath Cast"]	= "Flammenkranz";
	
	--Netherspite
	DBM_NS_NAME				= "Nethergroll";
	DBM_NS_DESCRIPTION		= "Zeigt Timer für seine Phasen und sagt Zone der Leere an.";
	DBM_NS_OPTION_1			= "Phasen ansagen";
	DBM_NS_OPTION_2			= "5 Sekunden Warnung für Phasen zeigen";
	DBM_NS_OPTION_3			= "Zone der Leere ansagen";
	DBM_NS_OPTION_4			= "Netheratem ansagen";

	DBM_NS_CAST_MODE_SWAP	= "Nethergroll wirkt Moduswechsel.";
	DBM_NS_CAST_VOID_ZONE	= "Nethergroll wirkt Zone der Leere.";
	DBM_NS_CAST_BREATH		= "Nethergroll beginnt Netheratem zu wirken.";
	DBM_NS_EMOTE_PHASE_2	= "Netherenergien versetzen %s in rasende Wut!";
	DBM_NS_EMOTE_PHASE_1	= "%s schreit auf und öffnet Tore zum Nether.";
	
	DBM_NS_WARN_PORTAL		= "*** Portal Phase ***";
	DBM_NS_WARN_BANISH		= "*** Banish Phase ***";
	DBM_NS_WARN_PORTAL_SOON	= "*** Portal Phase in 5 Sek ***";
	DBM_NS_WARN_BANISH_SOON	= "*** Banish Phase in 5 Sek ***";
	DBM_NS_WARN_BREATH		= "*** Netheratem ***";
	DBM_NS_WARN_VOID_ZONE	= "*** Zone der Leere ***";
	
	DBM_SBT["Netherbreath"]	= "Netheratem";
	
	--Prince Malchezaar
	DBM_PRINCE_NAME			= "Prinz Malchezaar"
	DBM_PRINCE_DESCRIPTION	= "Sagt Infernos, Entkräften, Schattenwort: Schmerz und Schattennova an.";
	DBM_PRINCE_OPTION_1		= "Schattennova ansagen";
	DBM_PRINCE_OPTION_2		= "Entkräften ansagen";
	DBM_PRINCE_OPTION_3		= "Whisper verschicken";
	DBM_PRINCE_OPTION_4		= "Schattenwort: Schmerz ansagen";
	DBM_PRINCE_OPTION_5		= "Inferno ansagen";

	DBM_PRINCE_YELL_PULL	= "Der Wahnsinn führte Euch zu mir. Ich werde Euch das Genick brechen!";
	DBM_PRINCE_YELL_P2		= "Dummköpfe! Zeit ist das Feuer, in dem Ihr brennen werdet!";
	DBM_PRINCE_YELL_P3		= "Wie könnt Ihr hoffen, einer so überwältigenden Macht gewachsen zu sein?";
	DBM_PRINCE_YELL_INF1	= "Alle Realitäten, alle Dimensionen stehen mir offen!";
	DBM_PRINCE_YELL_INF2	= "Ihr steht nicht nur vor Malchezzar allein, sondern vor den Legionen, die ich befehlige!";
	DBM_PRINCE_SWP			= "([^%s]+) (%w+) von Schattenwort: Schmerz betroffen.";
	DBM_PRINCE_ENFEEBLE		= "([^%s]+) (%w+) von Entkräften betroffen.";
	DBM_PRINCE_CAST_NOVA	= "Prinz Malchezaar beginnt Schattennova zu wirken.";
	DBM_PRINCE_INF_SPAWN	= "Höllenbestie bekommt 'Höllenfeuer'";


	DBM_PRINCE_WARN_NOVA		= "*** Schattennova in 2 Sek ***";
	DBM_PRINCE_WARN_ENFEEBLE	= "*** Entkräften ***";
	DBM_PRINCE_WHISP_ENFEEBLE	= "Entkräften auf dir!";
	DBM_PRINCE_WARN_SWP			= "*** Schattenwort: Schmerz auf >%s< ***";
	DBM_PRINCE_WARN_INF			= "*** Inferno #%s ***";
	DBM_PRINCE_WARN_INF_SOON	= "*** Inferno #%s bald ***";
	DBM_PRINCE_WARN_PHASE		= "*** Phase %s ***";
	
	DBM_SBT["Shadow Nova"]	= "Schattennova";
	DBM_SBT["Enfeeble"]		= "Entkräften";
	DBM_SBT["Infernal"]		= "Inferno";
	
	--Wizard of Oz
	DBM_OZ_NAME				= "Zauberer von Oz";
	DBM_OZ_DESCRIPTION		= "Sagt den Spawn von Brüller, Strohmann, Blechkopf und der bösen Hexe an.";
	DBM_OZ_OPTION_1			= "Reichweiten Check in Phase 2 anzeigen";

	DBM_OZ_CRONE_NAME		= "Die böse Hexe";
	DBM_OZ_YELL_DOROTHEE	= "Oh Tito, wir müssen einfach einen Weg nach Hause finden! Der alte Zauberer ist unsere einzige Hoffnung! Strohmann, Brüller, Blechkopf, wollt ihr - wartet… Donnerwetter, schaut! Wir haben Besucher!";
	DBM_OZ_YELL_ROAR		= "Ich habe keine Angst vor Euch! Wollt Ihr kämpfen? Hä, wollt Ihr? Kommt schon! Ich schaffe Euch mit beiden Pfoten hinter dem Rücken!";
	DBM_OZ_YELL_STRAWMAN	= "Was soll ich nur mit Euch machen? Mit fällt einfach nichts ein.";
	DBM_OZ_YELL_TINHEAD		= "Ich könnte wirklich ein Herz brauchen. Kann ich Eures haben?";
	DBM_OZ_YELL_TITO		= "Lass' nicht zu, dass sie uns wehtun, Tito. Nein, das wirst du nicht, oder?";
	DBM_OZ_YELL_CRONE		= "Wehe Euch allen, meine Hübschen!";
	DBM_OZ_SUMMON_TITO		= "Dorothee beginnt Tito beschwören zu wirken.";
	
	DBM_OZ_WARN_TITO		= "*** Tito ***";
	DBM_OZ_WARN_ROAR		= "*** Brüller ***";
	DBM_OZ_WARN_STRAWMAN	= "*** Strohmann ***";
	DBM_OZ_WARN_TINHEAD		= "*** Blechkopf ***";
	
	-- Nightbane
	DBM_NB_NAME				= "Schrecken der Nacht";
	DBM_NB_DESCRIPTION		= "Sagt Fear, Verbrannte Erde, Ablenkende Asche, Knochenregen, Rauchende Explosion und seine Luft Phasen an.";
	DBM_NB_OPTION_1			= "Special Warning für Verbrannte Erde anzeigen";
	DBM_NB_OPTION_2			= "Ablenkende Asche auf ranged Damage Dealern und Heilern ansagen";
	DBM_NB_OPTION_3			= "Knochenregen ansagen";
	DBM_NB_OPTION_4			= "Rauchende Explosion ansagen";
	DBM_NB_OPTION_5			= "Special Warning wenn man Target von Rauchende Explosion ist";

	DBM_NB_EMOTE_PULL		= "Etwas Uraltes erwacht in der Ferne...";
	DBM_NB_YELL_PULL		= "Narren! Ich werde Eurem Leiden ein schnelles Ende setzen!";
	DBM_NB_YELL_AIR			= "Abscheuliches Gewürm! Ich werde euch aus der Luft vernichten!";
	DBM_NB_YELL_GROUND		= "Genug! Ich werde landen und mich höchst persönlich um Euch kümmern!";
	DBM_NB_YELL_GROUND2		= "Insekten! Lasst mich Euch meine Kraft aus nächster Nähe demonstrieren!";
	DBM_NB_CAST_FEAR		= "Schrecken der Nacht beginnt Dröhnendes Gebrüll zu wirken.";
	DBM_NB_EARTH_YOU		= "Ihr seid von Verbrannte Erde betroffen.";
	DBM_NB_CAST_BONES		= "([^%s]+) (%w+) von Knochenregen betroffen%.";
	DBM_NB_CAST_ASH			= "([^%s]+) (%w+) von Ablenkende Asche betroffen.";
	DBM_NB_CAST_SMOKE		= "([^%s]+) (%w+) von Sengende Schlacke betroffen%.";

	DBM_NB_FEAR_WARN		= "*** Fear ***";
	DBM_NB_FEAR_SOON_WARN	= "*** Fear bald ***";
	DBM_NB_AIR_WARN			= "*** Luft Phase ***";
	DBM_NB_EARTH_WARN		= "Verbrannte Erde";
	DBM_NB_SMOKE_SPECWARN	= "Rauchende Explosion";
	DBM_NB_BONES_WARN		= "*** Knochenregen ***";
	DBM_NB_ASH_WARN			= "*** Ablenkende Asche auf >%s< ***";
	DBM_NB_SMOKE_WARN		= "*** Rauchende Explosion auf >%s< ***";	
	
	DBM_SBT["Nightbane"]	= "Schrecken der Nacht";
	DBM_SBT["Next Fear"]	= "Nächstes Fear";
end