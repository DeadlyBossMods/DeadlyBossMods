if GetLocale() ~= "deDE" then return end

local L

---------------------------
--  Trash - Lower Spire  --
---------------------------
L = DBM:GetModLocalization("LowerSpireTrash")

L:SetGeneralLocalization{
	name = "Trash der unteren Spitze"
}

L:SetWarningLocalization{
	specWarnTrap		= "Falle aktiviert! - Todesgeweihter Wächter freigesetzt" --creatureid 37007
}

L:SetOptionLocalization{
	specWarnTrap		= "Zeige spezielle Warnung für Fallenaktivierung",
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
	name = "Schatz & Stinki"
}

L:SetWarningLocalization{
	warnMortalWound	= "%s auf >%s< (%s)",		-- Mortal Wound on >args.destName< (args.amount)
	specWarnTrap	= "Falle aktiviert! - Rachsüchtige Fleischernter kommen" --creatureid 37038
}

L:SetOptionLocalization{
	specWarnTrap	= "Zeige spezielle Warnung fur Fallenaktivierung",
	warnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(71127, GetSpellInfo(71127) or "unknown")
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

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Lord Mark'Gar"
}

L:SetTimerLocalization{
	achievementBoned	= "Zeit zum Befreien"
}

L:SetWarningLocalization{
	WarnImpale			= ">%s< ist aufgespießt"
}

L:SetOptionLocalization{
	WarnImpale			= "Verkünde $spell:69062-Ziele",
	achievementBoned	= "Zeige Timer für Entknöchert-Erfolg",
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
	specWarnVengefulShade		= "Rachsüchtiger Schatten greift dich an - Lauf"--creatureid 38222
}

L:SetOptionLocalization{
	WarnAddsSoon				= "Zeige Vorwarnung für erscheinende Adds",
	WarnReanimating				= "Zeige Warnung, wenn ein Add wiederbelebt wird",											-- Reanimated Adherent/Fanatic spawning
	TimerAdds					= "Zeige Timer für neue Adds",
	specWarnVengefulShade		= "Zeige Spezialwarnung, wenn du von Rachsüchtigen Schatten angegriffen wirst",--creatureid 38222
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
	KillHorde		= "Die Allianz wankt. Vorwärts zum Lichkönig!"
}

-----------------------------
--  Deathbringer Saurfang  --
-----------------------------
L = DBM:GetModLocalization("Deathbringer")

L:SetGeneralLocalization{
	name = "Todesbringer Saurfang"
}

L:SetWarningLocalization{
	warnFrenzySoon	= "Wahnsinn bald"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Kampf beginnt"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Zeige Zeit bis Kampfbeginn",
	warnFrenzySoon			= "Zeige Vorwarnung für Wahnsinn (bei ~33%)",
	SetIconOnBoilingBlood	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72441),
	SetIconOnMarkCast		= "Setze Zeichen auf $spell:72444-Ziele während Zauber\n(Experimentell, kann den Tank fälschlicher Weise markieren)",
	RangeFrame				= "Zeige Abstandsfenster (12 m)",
	RunePowerFrame			= "Zeige Boss-Leben und Leiste für $spell:72371"
}

L:SetMiscLocalization{
	RunePower			= "Blutmacht",
	PullAlliance		= "Mit jedem Krieger der Horde, den Ihr getötet habt, mit jedem dieser Allianzhunde, der fiel, wuchsen die Armeen des Lichkönigs. Selbst in diesem Moment erwecken die Val'kyr Eure Gefallenen als Diener der Geißel.",
--	PullHorde			= "Kor'kron, move out! Champions, watch your backs! The Scourge have been..."
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
	SetIconOnGasSpore	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69279)
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
	specWarnLittleOoze			= "Kleiner Brühschlammer greift dich an - Lauf"--creatureid 36897
}

L:SetTimerLocalization{
	NextPoisonSlimePipes	 	= "Nächster Giftschleim"
}

L:SetOptionLocalization{
	NextPoisonSlimePipes		= "Zeige Timer für nächsten Giftschleim-Auslauf",
	WarnOozeSpawn				= "Zeige Warnung für Spawn von Kleinen Brühschlammern",
	specWarnLittleOoze			= "Zeige Spezialwarnung, wenn du von Kleinen Brühschlammern angegriffen wirst",--creatureid 36897
	WarnUnstableOoze			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(69558, GetSpellInfo(69558) or "unknown"),
	InfectionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71224),
	ExplosionIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69839)
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
	specWarnMalleableGoo		= "Formbarer Schleim auf Dir - Lauf",
	specWarnMalleableGooNear	= "Formbarer Schleim in Deiner Nähe - Aufpassen"
}

L:SetOptionLocalization{
	WarnPhase2Soon				= "Zeige Vorwarnung für Phase 2 (bei ~83%)",
	WarnPhase3Soon				= "Zeige Vorwarnung für Phase 3 (bei ~38%)",
	specWarnMalleableGoo		= "Zeige spezielle Warnung für Formbarer Schleim auf Dir\n(Funktioniert nur, wenn Du das erste Ziel bist)",
	specWarnMalleableGooNear	= "Zeige spezielle Warnung für Formbarer Schleim in Deiner Nähe\n(Funktioniert nur, wenn Du in der Nähe des ersten Zieles bist)",
	WarnMutatedPlague			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(72451, GetSpellInfo(72451) or "unknown"),
	OozeAdhesiveIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70447),
	GaseousBloatIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70672),
	MalleableGooIcon			= "Setze Zeichen auf Ziel erstes $spell:72295-Ziel"
}

L:SetMiscLocalization{
	YellPull	= "Gute Nachricht Freunde! Ich habe eine Seuche perfektioniert, die alles Leben Azeroths auslöscht!"
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
	WarnTargetSwitchSoon	= "Zielwechsel bald"
}

L:SetTimerLocalization{
	TimerTargetSwitch		= "Zielwechsel"
}

L:SetOptionLocalization{
	WarnTargetSwitch		= "Zeige Warnung für den Zielwechsel",-- Warn when another Prince needs to be damaged
	WarnTargetSwitchSoon	= "Zeige Vorwarnung für den Zielwechsel",-- Every ~47 secs, you have to dps a different Prince
	TimerTargetSwitch		= "Zeige Timer für Zielwechsel-Cooldown",
	EmpoweredFlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(72040),
	ActivePrinceIcon		= "Setze Symbol auf den machterfüllten Prinzen (Totenkopf)"
}

L:SetMiscLocalization{
	Keleseth			= "Prinz Keleseth",
	Taldaram			= "Prinz Taldaram",
	Valanar				= "Prinz Valanar",
	EmpoweredFlames		= "Infernoflammen rasen auf (%S+) zu!"
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
	SetIconOnDarkFallen			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71340),
	SwarmingShadowsIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(71266),
	BloodMirrorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70838)
}

L:SetMiscLocalization{
	SwarmingShadows			= "Shadows amass and swarm around (%S+)!"
}

-----------------------------
--  Valithria Dreamwalker  --
-----------------------------
L = DBM:GetModLocalization("Valithria")

L:SetGeneralLocalization{
	name = "Valithria Traumwandler"
}

L:SetWarningLocalization{
	warnCorrosion	= "%s auf >%s< (%s)"		-- Corrosion on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	warnCorrosion	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(70751, GetSpellInfo(70751) or "unknown")
}

L:SetMiscLocalization{
	YellPull		= "Intruders have breached the inner sanctum. Hasten the destruction of the green dragon! Leave only bones and sinew for the reanimation!",
	YellKill		= "I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!",
	YellPortals		= "I have opened a portal into the Dream. Your salvation lies within, heroes...",
	YellPhase2		= "My strength is returning. Press on, heroes!"--Need to confirm this is when adds spawn faster (phase 2) before used in mod
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
	TimerNextGroundphase	= "Nächste Bodenphase"
}

L:SetWarningLocalization{
	WarnAirphase			= "Luftphase",
	WarnGroundphaseSoon		= "Sindragosa landet bald"
}

L:SetOptionLocalization{
	WarnAirphase			= "Kündige Luftphase an",
	WarnGroundphaseSoon		= "Zeige Vorwarnung für Bodenphase",
	warnPhase2soon			= "Zeige Vorwarnung für Phase 2 (bei ~33%)",
	TimerNextAirphase		= "Zeige Timer für nächste Luftphase",
	TimerNextGroundphase	= "Zeige Timer für nächste Bodenphase",
	warnInstability			= "Zeige Warnung für deine $spell:69766-Stacks",
	warnChilledtotheBone	= "Zeige Warnung für deine $spell:70106-Stacks",
	warnMysticBuffet		= "Zeige Warnung für deine $spell:70128-Stacks",
	SetIconOnFrostBeacon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70126)
}

L:SetMiscLocalization{
	YellAirphase	= "Euer Vormarsch endet hier! Keiner wird überleben!",
	YellPhase2		= "Now, feel my master's limitless power and despair!",	--to be translated
	YellPull		= "Ihr seid Narren, euch hierher zu wagen. Der eisige Wind Nordends wird eure Seelen verschlingen!"
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
	specWarnDefileCast		= "Entweihen auf dir - Lauf weg",
	specWarnDefileCastNear	= "Entweihen in deiner Nähe - Aufpassen"
}

L:SetTimerLocalization{
	TimerCombatStart		= "Kampf beginnt"
}

L:SetOptionLocalization{
	TimerCombatStart		= "Zeige Timer für Kampfbeginn",
	WarnPhase2Soon			= "Zeige Vorwarnung für Übergang in Phase 2 (bei ~73%)",
	WarnPhase3Soon			= "Zeige Vorwarnung für Übergang in Phase 3 (bei ~43%)",
	specWarnDefileCast		= "Zeige Spezialwarnung für $spell:72762 auf dir",
	specWarnDefileCastNear	= "Zeige Spezialwarnung für $spell:72762 in deiner Nähe",
	DefileIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73779),
	NecroticPlagueIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(73912)
}

L:SetMiscLocalization{
	YellPull		= "So the Light's vaunted justice has finally arrived? Shall I lay down Frostmourne and throw myself at your mercy, Fordring?"	--to be translated
}