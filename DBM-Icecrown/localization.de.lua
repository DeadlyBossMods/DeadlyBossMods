if GetLocale() ~= "deDE" then return end

-- fehlende Übersetzungen:
--
-- Luftschiffkampf (Horde)

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Trash der unteren Spitze"
}

L:SetWarningLocalization{
	SpecWarnTrap		= "Falle aktiviert! - Todesgeweihter Wächter freigesetzt" --creatureid 37007
}

L:SetOptionLocalization{
	SpecWarnTrap		= "Zeige Spezialwarnung für Fallenaktivierung",
	SetIconOnDarkReckoning	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69483),
	SetIconOnDeathPlague	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72865)
}

L:SetMiscLocalization{
	WarderTrap1		= "Wer... ist da?",
	WarderTrap2		= "Ich erwache...",
	WarderTrap3		= "Das Sanktum des Meisters wurde entweiht!"
}

---------------------------
--  Trash - Plagueworks  --
---------------------------
L = DBM:GetModLocalization("PlagueworksTrash")

L:SetGeneralLocalization{
	name = "Trash der Seuchenwerke"
}

L:SetWarningLocalization{
	WarnMortalWound	= "%s auf >%s< (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	SpecWarnTrap	= "Falle aktiviert! - Rachsüchtige Fleischernter kommen" --creatureid 37038
}

L:SetOptionLocalization{
	SpecWarnTrap	= "Zeige Spezialwarnung fur Fallenaktivierung",
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
}

L:SetMiscLocalization{
	FleshreaperTrap1		= "Schnell, überfallen wir sie von hinten!",
	FleshreaperTrap2		= "Ihr könnt uns nicht entkommen.",
	FleshreaperTrap3		= "Die Lebenden? Hier?!"
}

---------------------------
--  Trash - Crimson Hall  --
---------------------------
L = DBM:GetModLocalization("CrimsonHallTrash")

L:SetGeneralLocalization{
	name = "Trash der Blutroten Halle"
}

L:SetWarningLocalization{
}

L:SetOptionLocalization{
	BloodMirrorIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70451)
}

L:SetMiscLocalization{
}

---------------------------
--  Trash - Frostwing Hall  --
---------------------------
L = DBM:GetModLocalization("FrostwingHallTrash")

L:SetGeneralLocalization{
	name = "Trash der Frostschwingenhallen"
}

L:SetWarningLocalization{
	SpecWarnGosaEvent	= "Sindragosa-Spießrutenlaut gestartet!"
}

L:SetTimerLocalization{
	GosaTimer			= "Zeit verbleibend"
}

L:SetOptionLocalization{
	SpecWarnGosaEvent	= "Zeige Spezialwarnung für Sindragosa-Spießrutenlauf",
	GosaTimer			= "Zeige Timer für die Dauer des Sindragosa-Spießrutenlaufs"
}

L:SetMiscLocalization{
	SindragosaEvent		= "Ihr dürft Euch der Frostkönigin nicht nähern! Schnell, haltet sie auf!"
}

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Mark'Gar"
}

L:SetTimerLocalization{
	AchievementBoned	= "Zeit zum Befreien"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< ist aufgespießt"
}

L:SetOptionLocalization{
	WarnImpale			= "Verkünde Ziele von $spell:69062",
	AchievementBoned	= "Zeige Timer für Erfolg 'Entknöchert'",
	SetIconOnImpale		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69062)
}

-------------------------
--  Lady Deathwhisper  --
-------------------------
L = DBM:GetModLocalization("Deathwhisper")

L:SetGeneralLocalization{
	name = "Lady Todeswisper"
}

L:SetTimerLocalization{
	TimerAdds	= "Neue Adds"
}

L:SetWarningLocalization{
	WarnReanimating				= "Add-Wiederbelebung",			-- Reanimating an adherent or fanatic
	WarnTouchInsignificance		= "%s auf >%s< (%s)",		-- Touch of Insignificance on >args.destName< (args.amount)
	WarnAddsSoon				= "Neue Adds bald",
	SpecWarnVengefulShade		= "Rachsüchtiger Schatten greift dich an - Lauf"--creatureid 38222
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Zeige Vorwarnung für erscheinende Adds",
	WarnReanimating				= "Zeige Warnung, wenn ein Add wiederbelebt wird",											-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Zeige Timer für neue Adds",
	SpecWarnVengefulShade		= "Zeige Spezialwarnung, wenn du von Rachsüchtigen Schatten angegriffen wirst",--creatureid 38222
	ShieldHealthFrame			= "Zeige Bossleben mit einer Leiste für $spell:70842",
	WarnTouchInsignificance		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71204, GetSpellInfo(71204) or "unknown"),	
	SetIconOnDominateMind		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71289),
	SetIconOnDeformedFanatic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70900),
	SetIconOnEmpoweredAdherent	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70901)
}

L:SetMiscLocalization{
	YellPull				= "Was soll die Störung? Ihr wagt es, heiligen Boden zu betreten? Dies wird der Ort Eurer letzten Ruhe sein!",
	YellReanimatedFanatic	= "Erhebt Euch und frohlocket ob Eurer reinen Form!",
	ShieldPercent			= "Manabarriere", --Translate Spell id 70842
	Fanatic1				= "Fanatischer Kultist",
	Fanatic2				= "Deformierter Fanatiker",
	Fanatic3				= "Wiederbelebter Fanatiker"
}

----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization{
	name = "Luftschiffkampf"
}

L:SetWarningLocalization{
	WarnBattleFury	= "%s (%d)",
	WarnAddsSoon	= "Neue Adds bald"
}

L:SetOptionLocalization{
	WarnBattleFury		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69638, GetSpellInfo(69638) or "Battle Fury"),
	TimerCombatStart	= "Zeige Zeit bis zum Beginn des Kampfes",
	WarnAddsSoon		= "Zeige Vorwarnung für erscheinende Adds",
	TimerAdds			= "Zeige Timer für neue Adds"
}

L:SetTimerLocalization{
	TimerCombatStart	= "Kampf beginnt",
	TimerAdds			= "Neue Adds"
}

L:SetMiscLocalization{
	PullAlliance	= "Alle Maschinen auf Volldampf! Unser Schicksal erwartet uns!",
	KillAlliance	= "Sagt nicht, ich hätte Euch nicht gewarnt, Ihr Schurken! Vorwärts, Brüder und Schwestern!",
	PullHorde		= "Erhebt Euch, Söhne und Töchter der Horde! Wir ziehen gegen einen verhassten Feind in die Schlacht! LOK'TAR OGAR!",
	KillHorde		= "Die Allianz wankt. Vorwärts zum Lichkönig!",
	AddsAlliance	= "Häscher, Unteroffiziere, Angriff!",
	AddsHorde		= "Soldaten! Zum Angriff!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Todesbringer Saurfang"
}

L:SetWarningLocalization{
	WarnFrenzySoon	= "Wahnsinn bald"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Kampf beginnt"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Zeige Zeit bis Kampfbeginn",
	WarnFrenzySoon			= "Zeige Vorwarnung für Wahnsinn (bei ~33%)",
	BoilingBloodIcons		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	RangeFrame				= "Zeige Abstandsfenster (12 m)",
	RunePowerFrame			= "Zeige Boss-Leben und Leiste für $spell:72371",
	BeastIcons				= "Setze Zeichen auf Blutbestien"
}

L:SetMiscLocalization{
	RunePower			= "Blutmacht",
	PullAlliance		= "Mit jedem Krieger der Horde, den Ihr getötet habt, mit jedem dieser Allianzhunde, der fiel, wuchsen die Armeen des Lichkönigs. Selbst in diesem Moment erwecken die Val'kyr Eure Gefallenen als Diener der Geißel.",
	PullHorde			= "Kor'kron, Aufbruch! Champions, gebt Acht. Die Geißel ist..."
}

-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization{
	name = "Fauldarm"
}

L:SetWarningLocalization{
	InhaledBlight		= "Eingeatmeter Seuchennebel >%d<",
	WarnGastricBloat	= "%s auf >%s< (%s)",		-- Gastric Bloat on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	InhaledBlight		= "Zeige Warnung für $spell:71912",
	RangeFrame			= "Zeige Abstandsfenster (8 m)",
	WarnGastricBloat	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72551, GetSpellInfo(72551) or "unknown"),	
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279),
	AnnounceSporeIcons	= "Verkünde Symbole für Ziele von $spell:69279 im Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)"
}

L:SetMiscLocalization{
	SporeSet	= "Gassporensymbol {rt%d} auf %s gesetzt"
}

---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization{
	name = "Modermiene"
}

L:SetWarningLocalization{
	WarnOozeSpawn				= "Kleiner Brühschlammer erscheint",
	WarnUnstableOoze			= "%s auf >%s< (%s)",	 -- Unstable Ooze on >args.destName< (args.amount)
	SpecWarnLittleOoze			= "Kleiner Brühschlammer greift dich an - Lauf"--creatureid 36897
}

L:SetTimerLocalization{
	NextPoisonSlimePipes	 	= "Nächster Giftschleim"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Zeige Timer für nächsten Giftschleim-Auslauf",
	WarnOozeSpawn				= "Zeige Warnung für Spawn von Kleinen Brühschlammern",
	SpecWarnLittleOoze			= "Zeige Spezialwarnung, wenn du von Kleinen Brühschlammern angegriffen wirst",--creatureid 36897
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	ExplosionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69839),
	TankArrow					= "Zeige Pfeil zum Tank des Großen Schlamms (experimentell)"
}

L:SetMiscLocalization{
	YellSlimePipes1	= "Gute Nachricht, Freunde! Die Giftschleim-Rohre sind repariert!",	-- Professor Putricide
	YellSlimePipes2	= "Gute Nachricht, Freunde! Der Schleim fließt wieder!"	-- Professor Putricide
}

---------------------------
--  Professor Putricide  --
---------------------------
L = DBM:GetModLocalization("Putricide")

L:SetGeneralLocalization{
	name = "Professor Seuchenmord"
}

L:SetWarningLocalization{
	WarnPhase2Soon				= "Phase 2 bald",
	WarnPhase3Soon				= "Phase 3 bald",
	WarnMutatedPlague			= "%s auf >%s< (%s)",	-- Mutated Plague on >args.destName< (args.amount)
	SpecWarnMalleableGoo		= "Formbarer Schleim auf Dir - Lauf",
	SpecWarnMalleableGooNear	= "Formbarer Schleim in Deiner Nähe - Aufpassen",
	SpecWarnUnboundPlague		= "Lege Entfesselte Seuche ab",
	SpecWarnNextPlageSelf		= "Entfesselte Seuche als nächstes auf dir, bereite dich vor!"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "Zeige Vorwarnung für Phase 2 (bei ~83%)",
	WarnPhase3Soon				= "Zeige Vorwarnung für Phase 3 (bei ~38%)",
	SpecWarnMalleableGoo		= "Zeige Spezialwarnung für Formbarer Schleim auf Dir\n(Funktioniert nur, wenn Du das erste Ziel bist)",
	SpecWarnMalleableGooNear	= "Zeige Spezialwarnung für Formbarer Schleim in Deiner Nähe\n(Funktioniert nur, wenn Du in der Nähe des ersten Zieles bist)",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	UnboundPlagueIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72856),
	MalleableGooIcon			= "Setze Zeichen auf erstes Ziel von $spell:72295",
	NextUnboundPlagueTargetIcon	= "Setze Zeichen auf nächstes Ziel von $spell:72856",
	YellOnMalleableGoo			= "Schreie bei $spell:72295",	
	YellOnUnbound				= "Schreie bei $spell:72856",
	SpecWarnUnboundPlague		= "Zeige Spezialwarnung für Übertragung von $spell:72856",
	SpecWarnNextPlageSelf		= "Zeige Spezialwarnung wenn du in der Nähe des Ziels von $spell:72856 bist"
}

L:SetMiscLocalization{
	YellPull	= "Gute Nachricht Freunde! Ich habe eine Seuche perfektioniert, die alles Leben Azeroths auslöscht!",
	YellMalleable	= "Formbarer Schleim auf mir!",
	YellUnbound		= "Entfesselte Seuche auf mir!"
}

----------------------------
--  Blood Prince Council  --
----------------------------
L = DBM:GetModLocalization("BPCouncil")

L:SetGeneralLocalization{
	name = "Der Rat des Blutes"
}

L:SetWarningLocalization{
	WarnTargetSwitch		= "Ziel wechseln auf: %s",
	WarnTargetSwitchSoon	= "Zielwechsel bald",
	SpecWarnVortex			= "Schockvortex auf dir - Lauf weg",
	SpecWarnVortexNear		= "Schockvortex in deiner Nähe - Pass auf"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Zielwechsel"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Zeige Warnung für den Zielwechsel",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Zeige Vorwarnung für den Zielwechsel",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Zeige Timer für Zielwechsel-Cooldown",
	SpecWarnVortex			= "Zeige Spezialwarnung für $spell:72037 auf dich",
	SpecWarnVortexNear		= "Zeige Spezialwarnung für $spell:72037 in deiner Nähe",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Setze Zeichen auf den machterfüllten Prinzen (Totenkopf)",
	RangeFrame				= "Zeige Abstandsfenster (12 m)"
}

L:SetMiscLocalization{
	Keleseth			= "Prinz Keleseth",
	Taldaram			= "Prinz Taldaram",
	Valanar				= "Prinz Valanar",
	EmpoweredFlames		= "Machtvolle Flammen rasen auf (%S+) zu!"
}

-----------------------------
--  Blood-Queen Lana'thel  --
-----------------------------
L = DBM:GetModLocalization("Lanathel")

L:SetGeneralLocalization{
	name = "Blutkönigin Lana'thel"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnDarkFallen		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838),
	RangeFrame				= "Zeige Abstandsfenster (8 m)",
	YellOnFrenzy			= "Schreie bei $spell:71474"
}

L:SetMiscLocalization{
	SwarmingShadows			= "Schatten sammeln sich und schwärmen um (%S+)!",
	YellFrenzy				= "Ich habe Durst!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Traumwandler"
}

L:SetWarningLocalization{
	WarnCorrosion	= "%s auf >%s< (%s)",		-- Corrosion on >args.destName< (args.amount)
	WarnPortalOpen	= "Portale offen"
}

L:SetTimerLocalization{
	TimerPortalsOpen	= "Portale offen",
	TimerBlazingSkeleton	= "Loderndes Skelett"
}

L:SetOptionLocalization{
	SetIconOnBlazingSkeleton		= "Setze Zeichen auf Loderndes Skelett (Totenkopf)",
	WarnPortalOpen				= "Zeige Warnung wenn Alptraumportale geöffnet sind",
	TimerPortalsOpen			= "Zeige Timer wenn Alptraumportale geöffnet sind",
	TimerBlazingSkeleton		= "Zeige Timer für nächstes Loderndes Skelett",
	WarnCorrosion	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull		= "Eindringlinge im Inneren Sanktum! Beschleunigt die Vernichtung des grünen Drachen! Bewahrt nur Knochen und Sehnen für die Wiederbelebung auf!",
	YellKill		= "ICH BIN GEHEILT! Ysera, erlaubt mir diese üblen Kreaturen zu beseitigen!",
	YellPortals		= "Ich habe ein Portal in den Traum geöffnet. Darin liegt Eure Erlösung, Helden...",
	YellPhase2		= "Meine Kraft kehrt zurück. Macht weiter, Helden!"
}

------------------
--  Sindragosa  --
------------------
L = DBM:GetModLocalization("Sindragosa")

L:SetGeneralLocalization{
	name = "Sindragosa"
}

L:SetTimerLocalization{
	TimerNextAirphase		= "Nächste Luftphase",
	TimerNextGroundphase	= "Nächste Bodenphase",
	AchievementMystic		= "Ablaufzeit für Mystischer Puffer"
}

L:SetWarningLocalization{
	WarnPhase2soon			= "Phase 2 bald",
	WarnAirphase			= "Luftphase",
	WarnGroundphaseSoon		= "Sindragosa landet bald",
	WarnInstability			= "Instablität >%d<",
	WarnChilledtotheBone	= "Durchgefroren >%d<",
	WarnMysticBuffet		= "Mystischer Puffer >%d<"
}

L:SetOptionLocalization{
	WarnAirphase			= "Kündige Luftphase an",
	WarnGroundphaseSoon		= "Zeige Vorwarnung für Bodenphase",
	WarnPhase2soon			= "Zeige Vorwarnung für Phase 2 (bei ~38%)",
	TimerNextAirphase		= "Zeige Timer für nächste Luftphase",
	TimerNextGroundphase	= "Zeige Timer für nächste Bodenphase",
	WarnInstability			= "Zeige Warnung für deine $spell:69766-Stacks",
	WarnChilledtotheBone	= "Zeige Warnung für deine $spell:70106-Stacks",
	WarnMysticBuffet		= "Zeige Warnung für deine $spell:70128-Stacks",
	AnnounceFrostBeaconIcons= "Poste Zeichen für Ziele von $spell:70126 in Raidchat\n(benötigt aktivierte Ankündigungen und (L)- oder (A)-Status)",
 	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126),
	SetIconOnUnchainedMagic	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69762),
	ClearIconsOnAirphase	= "Entferne alle Zeichen vor der Luftphase",
	RangeFrame				= "Zeige Abstandsfenster (10 m normal, 20 m heroisch)\n(zeigt nur Spieler mit Raidzeichen an)"
}

L:SetMiscLocalization{
	YellAirphase	= "Euer Vormarsch endet hier! Keiner wird überleben!",
	YellPhase2		= "Fühlt die grenzenlose Macht meines Meisters, und verzweifelt!",
	YellAirphaseDem		= "Rikk zilthuras rikk zila Aman adare tiriosh ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	YellPhase2Dem		= "Zar kiel xi romathIs zilthuras revos ruk toralar ",--Demonic, since curse of tonges is used by some guilds and it messes up yell detection.
	BeaconIconSet			= "Frostleuchtfeuer-Zeichen {rt%d} auf %s gesetzt",
	YellPull		= "Ihr seid Narren, euch hierher zu wagen. Der eisige Wind Nordends wird eure Seelen verschlingen!"	-- momentan nicht verwendet
}

---------------------
--  The Lich King  --
---------------------
L = DBM:GetModLocalization("LichKing")

L:SetGeneralLocalization{
	name = "Der Lichkönig"
}

L:SetWarningLocalization{
	WarnPhase2Soon			= "Übergang in Phase 2 bald",
	WarnPhase3Soon			= "Übergang in Phase 3 bald",
	SpecWarnDefileCast		= "Entweihen auf dir - Lauf weg",
	SpecWarnDefileNear		= "Entweihen in deiner Nähe - Aufpassen",
	SpecWarnTrapNear		= "Schattenfalle in deiner Nähe - Aufpassen",
	WarnNecroticPlagueJump	= "Nekrotische Seuche auf >%s< gesprungen",
	SpecWarnValkyrLow		= "Valkyr below 55%"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Kampf beginnt",
	TimerRoleplay			= "Rollenspiel",
	PhaseTransition			= "Phasenübergang",
	TimerNecroticPlagueCleanse = "Nekrotische Seuche reinigen"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Zeige Timer für Kampfbeginn",
	TimerRoleplay			= "Zeige Timer für Rollenspiel",
	WarnNecroticPlagueJump	= "Verkünde Sprungziele von $spell:73912",
	TimerNecroticPlagueCleanse	= "Zeige Timer um Nekrotische Seuche vor dem ersten Tick zu reinigen",
	PhaseTransition			= "Zeige Timer für Phasenübergänge",
	WarnPhase2Soon			= "Zeige Vorwarnung für Übergang in Phase 2 (bei ~73%)",
	WarnPhase3Soon			= "Zeige Vorwarnung für Übergang in Phase 3 (bei ~43%)",
	SpecWarnDefileCast		= "Zeige Spezialwarnung für $spell:72762 auf dir",
	SpecWarnDefileNear		= "Zeige Spezialwarnung für $spell:72762 in deiner Nähe",
	SpecWarnTrapNear		= "Zeige Spezialwarnung für $spell:73539 in deiner Nähe",
	YellOnDefile			= "Schreie bei $spell:72762",
	YellOnTrap				= "Schreie bei $spell:73539",
	DefileIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72762),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912),
	RagingSpiritIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69200),
	TrapIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73539),
	ValkyrIcon				= "Setze Zeichen auf Valkyren",
	DefileArrow				= "Zeige Pfeil wenn $spell:72762 in deiner Nähe ist",
	TrapArrow				= "Zeige Pfeil wenn $spell:73539 in deiner Nähe ist",
	SpecWarnValkyrLow		= "Show special warning when Valkyr is below 55% HP"
}

L:SetMiscLocalization{
	LKPull					= "Der vielgerühmte Streiter des Lichts ist endlich hier? Soll ich Frostgram niederlegen und mich Eurer Gnade ausliefern, Fordring?",
	YellDefile				= "Entweihen auf mir!",
	YellTrap				= "Schattenfalle auf mir!",
	YellKill				= "Keine Fragen, keine Zweifel mehr - Ihr SEID Azeroths größte Champions. Ihr habt jede meiner Herausforderungen gemeistert. Meine mächtigsten Diener fielen unter Eurem unnachgiebigen Ansturm... Eurer grenzenlosen Wut...",
	LKRoleplay				= "Ist es wirklich Rechtschaffenheit, die Euch treibt? Ich bin mir nicht sicher…",
	PlagueWhisper			= "Ihr wurdet von der"
}
