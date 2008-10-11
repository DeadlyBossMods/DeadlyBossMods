if GetLocale() == "deDE" then
DBM_ZULAMAN		= "Zul'Aman"

-- Nalorakk
DBM_NALO_NAME					= "Nalorakk"
DBM_NALO_DESCRIPTION			= "Sagt die Formen und Stille an."
DBM_NALO_OPTION_PHASEPRE		= "5 Sekunden Warnung für Phasen anzeigen"
DBM_NALO_OPTION_SILENCE			= "Stille ansagen"

DBM_NALO_YELL_PULL            	= "Ihr sterbt noch schnell genug!" 
DBM_NALO_YELL_BEAR            	= "Ihr provoziert die Bestie, jetzt werdet Ihr sie kennenlernen!" 
DBM_NALO_YELL_NORMAL         	= "Macht Platz für Nalorakk!" 
DBM_NALO_DEBUFF_SILENCE         = "von Ohrenbetäubendes Gebrüll betroffen"

DBM_NALO_WARN_NORMAL_SOON		= "Normale Form in 5 Sek" 
DBM_NALO_WARN_BEAR_SOON         = "Bärform in 5 Sek" 
DBM_NALO_WARN_NORMAL         	= "Normale Form" 
DBM_NALO_WARN_BEAR   			= "Bärform" 
DBM_NALO_WARN_SILENCE       	= "Stille"

DBM_SBT["Bear Form"]			= "Bär"
DBM_SBT["Normal Form"]			= "Normale Form"


-- Akil'zon
DBM_AKIL_NAME					= "Akil'zon"
DBM_AKIL_DESCRIPTION			= "Sagt Elektrischer Sturm an und setzt einen Minimap Ping."
DBM_AKIL_OPTION_RANGE			= "Range Frame anzeigen"

DBM_AKIL_YELL_PULL				= "Ich bin der Jäger! Ihr seid die Beute..."
DBM_AKIL_DEBUFF_STORM			= "([^%s]+) (%w+) von Elektrischer Sturm betroffen"

DBM_AKIL_WARN_STORM_SOON		= "Elektrischer Sturm bald"
DBM_AKIL_WARN_STORM_ON			= "Elektrischer Sturm auf >%s<"

DBM_SBT["Electrical Storm"]		= "Elektrischer Sturm"


-- Jan'alai
DBM_JANALAI_NAME				= "Jan'alai"
DBM_JANALAI_DESCRIPTION			= "Sagt Teleport und Brutwächter an."

DBM_JANALAI_YELL_PULL			= "Die Geister der Winde besiegeln Euer Schicksal!"
DBM_JANALAI_YELL_EXPLOSION		= "Jetzt sollt Ihr brennen!"
DBM_JANALAI_YELL_HATCHER		= "Wo is' meine Brut? Was ist mit den Eiern?"

DBM_JANALAI_WARN_EXPLOSION		= "Teleport"
DBM_JANALAI_WARN_EXPLOSION_INC	= "Explosion in 1 Sek"
DBM_JANALAI_WARN_HATCHER		= "Brutwächter"
DBM_JANALAI_WARN_HATCHER_SOON	= "Brutwächter in 10 Sek"

DBM_SBT["Hatcher"]				= "Brutwächter"


-- Halazzi
DBM_HALAZZI_NAME				= "Halazzi"
DBM_HALAZZI_DESCRIPTION			= "Sagt Phasen, Totems und Raserei an."
DBM_HALAZZI_OPTION_FRENZY		= "Raserei ansagen"
DBM_HALAZZI_OPTION_TOTEM		= "Blitzschlagtotem ansagen"

DBM_HALAZZI_YELL_PULL			= "Auf die Knie und verneigt Euch... vor den Reißzähnen und der Klaue!"
DBM_HALAZZI_YELL_SPIRIT			= "Ich kämpfe mit wildem Geist..."
DBM_HALAZZI_YELL_SPIRIT_DESP	= "Geist, zurück zu mir!"
DBM_HALAZZI_CAST_TOTEM			= "Halazzi beginnt Blitzschlagtotem zu wirken." -- 2 spaces? wtf? -- okay im deutschen nicht...
DBM_HALAZZI_GAIN_FRENZY			= "Halazzi bekommt 'Raserei'."

DBM_HALAZZI_WARN_SPIRIT			= "Geist spawned"
DBM_HALAZZI_WARN_SPIRIT_DESP	= "Geist despawned"
DBM_HALAZZI_WARN_TOTEM			= "Blitzschlagtotem"
DBM_HALAZZI_WARN_FRENZY			= "Raserei - Tranq Shot" -- tranq shot...wtf....


-- Malacrass
DBM_MALACRASS_NAME				= "Hexlord Malacrass"
DBM_MALACRASS_DESCRIPTION		= "Sagt Geistblitze und Seele entziehen an."


DBM_MALACRASS_YELL_PULL			= "Der Schatten wird Euch verschlingen..."
DBM_MALACRASS_DEBUFF_SIPHON		= "([^%s]+) (%w+) von Seele entziehen betroffen"
DBM_MALACRASS_YELL_BOLTS		= "Eure Seele wird bluten!"

DBM_MALACRASS_WARN_SIPHON		= "Seele entziehen auf >%s<"
DBM_MALACRASS_WARN_BOLTS		= "Geistblitze"
DBM_MALACRASS_WARN_BOLTS_SOON	= "Geistblitze in 5 Sek"

DBM_SBT["Spirit Bolts"]			= "Geistblitze"
DBM_SBT["Next Spirit Bolts"]	= "Nächste Geistblitze"
DBM_SBT["Malacrass"]			= {
	{
		"Siphon Soul: (.*)",
		"Seele entziehen: %1",
	},
}


-- Zul'jin
DBM_ZULJIN_NAME					= "Zul'jin"
DBM_ZULJIN_DESCRIPTION			= "Sagt Phasen, Schleichende Paralyse, Klauenwut und Schrecklicher Wurf an."

DBM_ZULJIN_OPTION_PARA			= "Schleichende Paralyse ansagen"
DBM_ZULJIN_OPTION_LYNX			= "Klauenwut ansagen"

DBM_ZULJIN_YELL_PULL			= "Keiner kann es mit mir aufnehmen!"
DBN_ZULJIN_YELL_PHASE_2			= "Sagt 'Hallo' zu Bruder Bär..."
DBM_ZULJIN_YELL_PHASE_3			= "Niemand versteckt sich vor dem Adler!"
DBM_ZULJIN_YELL_PHASE_4			= "Lernt meine Brüder kennen: Reißzahn und Klaue!"
DBM_ZULJIN_YELL_PHASE_5			= "Was starrt Ihr in die Luft? Der Drachenfalke steht schon vor Euch!"

DBM_ZULJIN_DEBUFF_PARALYSIS		= "von Schleichende Paralyse betroffen"
DBM_ZULJIN_DEBUFF_DOT			= "([^%s]+) (%w+) von Schrecklicher Wurf betroffen"
DBM_ZULJIN_DEBUFF_LYNX			= "([^%s]+) (%w+) von Klauenwut betroffen%.$"

DBM_ZULJIN_WARN_PHASE_1			= "Phase 1 - Troll"
DBM_ZULJIN_WARN_PHASE_2			= "Phase 2 - Bär"
DBM_ZULJIN_WARN_PHASE_3			= "Phase 3 - Adler"
DBM_ZULJIN_WARN_PHASE_4			= "Phase 4 - Luchs"
DBM_ZULJIN_WARN_PHASE_5			= "Phase 5 - Drachenfalke"

DBM_ZULJIN_WARN_PARALYSIS		= "Schleichende Paralyse"
DBM_ZULJIN_WARN_PARALYSIS_SOON	= "Schleichende Paralyse bald"
DBM_ZULJIN_WARN_LYNX			= "Klauenwut auf >%s<"
DBM_ZULJIN_WARN_DOT				= "Schrecklicher Wurf auf >%s<"

DBM_SBT["Creeping Paralysis"]	= "Schleichende Paralyse"


end