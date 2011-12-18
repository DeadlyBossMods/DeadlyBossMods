if GetLocale() ~= "deDE" then return end
local L

--------------
--  Magmaw  --
--------------
--L = DBM:GetModLocalization(170)
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magmaul"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Loderndes Knochenkonstrukt bald (~4s)",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Zeige Spezialvorwarnung für $spell:92190 (~4s)",
	RangeFrame		= "Zeige Abstandsfenster in Phase 2 (5m)"
})

L:SetMiscLocalization({
	Slump			= "%s schlittert nach vorne und entblößt seine Zangen!",
	HeadExposed		= "%s spießt sich selbst auf, was seinen Kopf freilegt!",
	YellPhase2		= "Unfassbar! Ihr könntet tatsächlich meinen Lavawurm besiegen! Vielleicht kann ich helfen... das Zünglein an der Waage zu sein." --needs to be verified (video-captured translation)
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
--L = DBM:GetModLocalization(169)
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Omnotron-Verteidigungssystem"
})

L:SetWarningLocalization({
	SpecWarnActivated			= "Wechsel Ziel zu %s!",
	specWarnGenerator			= "Energiegenerator - Zieh %s raus!"
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Arkaner Kurzschluss",
	timerShadowConductorCast	= "Schattenleiter",
	timerNefAblity				= "Fähigkeitsbuff CD",
	timerArcaneLockout			= "Annihilator Sperre"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Zeige Zeit bis $spell:92048 gewirkt wird",
	timerArcaneBlowbackCast		= "Zeige Zeit bis $spell:91879 gewirkt wird",
	timerArcaneLockout			= "Zeige Zeit, in der $spell:91542 nicht gewirkt werden kann",
	timerNefAblity				= "Zeige Abklingzeit für heroische Fähigkeitsverbesserungen",
	SpecWarnActivated			= "Zeige Spezialwarnung, wenn ein neuer Boss aktiviert wird",
	specWarnGenerator			= "Zeige Spezialwarnung, wenn ein Boss von $spell:91557 profitiert",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "Setze ein Zeichen auf den zuletzt aktivierten Boss"
})

L:SetMiscLocalization({
	Magmatron					= "Magmatron",
	Electron					= "Elektron",
	Toxitron					= "Toxitron",
	Arcanotron					= "Arkanotron",
	YellTargetLock				= "Umschließende Schatten! Weg von mir!"
})

----------------
--  Maloriak  --
----------------
--L = DBM:GetModLocalization(173)
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase			= "%s Phase",
	WarnRemainingAdds	= "%d Entartungen verbleiben"
})

L:SetTimerLocalization({
	TimerPhase			= "Nächste Phase"
})

L:SetOptionLocalization({
	WarnPhase			= "Verkünde welche Phase als Nächstes kommt",
	WarnRemainingAdds	= "Verkünde die Anzahl der verbleibenden Entartungen",
	TimerPhase			= "Zeige Zeit bis nächste Phase",
	RangeFrame			= "Zeige Abstandsfenster (6m) während der blauen Phase",
	SetTextures			= "Automatische Deaktivierung der Grafikeinstellung 'Projizierte Texturen' in\nder dunklen Phase (wird nach Verlassen der Phase autom. wieder aktiviert)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "rote|r Phiole in den Kessel!",
	YellBlue			= "blaue|r Phiole in den Kessel!",
	YellGreen			= "grüne|r Phiole in den Kessel!",
	YellDark			= "dunkle|r Magie hinzu!", --needs to be verified (video-captured translation)
	Red					= "Rote",
	Blue				= "Blaue",
	Green				= "Grüne",
	Dark				= "Dunkle"
})

-----------------
--  Chimaeron  --
-----------------
--L = DBM:GetModLocalization(172)
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Schimaeron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame		= "Zeige Abstandsfenster (6m)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Zeige Infofenster für Gesundheit (<10k Lebenspunkte)"
})

L:SetMiscLocalization({
	HealthInfo	= "Gesundheitsinfo"
})

-----------------
--  Atramedes  --
-----------------
--L = DBM:GetModLocalization(171)
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase			= "Luftphase",
	WarnGroundphase			= "Bodenphase",
	WarnShieldsLeft			= "Uralter Zwergenschild genutzt - %d verbleibend",
	warnAddSoon				= "Nerviges Scheusal beschwört",
	specWarnAddTargetable	= "%s ist angreifbar"
})

L:SetTimerLocalization({
	TimerAirphase			= "Luftphase",
	TimerGroundphase		= "Bodenphase"
})

L:SetOptionLocalization({
	WarnAirphase			= "Zeige Warnung, wenn Atramedes abhebt",
	WarnGroundphase			= "Zeige Warnung, wenn Atramedes landet",
	WarnShieldsLeft			= "Zeige Warnung, wenn ein Uralter Zwergenschild benutzt wird",
	warnAddSoon				= "Zeige Warnung, wenn Nefarian Adds beschwört",
	specWarnAddTargetable	= "Zeige Spezialwarnung, wenn die Adds angegriffen werden können",
	TimerAirphase			= "Zeige Zeit bis nächste Luftphase",
	TimerGroundphase		= "Zeige Zeit bis nächste Bodenphase",
	InfoFrame				= "Zeige Infofenster für Geräuschpegel",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Uralter Zwergenschild",
	Soundlevel				= "Geräuschpegel",
	YellPestered			= "Nerviges Scheusal auf mir!",--npc 49740
	NefAdd					= "Atramedes, die Helden sind direkt DA DRÜBEN!",
	Airphase				= "Ja, lauft! Jeder Schritt lässt Euer Herz stärker klopfen. Laut und heftig... ohrenbetäubend. Es gibt kein Entkommen!"
})

----------------
--  Nefarian  --
----------------
--L = DBM:GetModLocalization(174)
L = DBM:GetModLocalization("Nefarian")

L:SetGeneralLocalization({
	name = "Nefarians Ende" -- official name; no conflict with BWL version
})

L:SetWarningLocalization({
	OnyTailSwipe			= "Schwanzpeitscher (Onyxia)",
	NefTailSwipe			= "Schwanzpeitscher (Nefarian)",
	OnyBreath				= "Atem (Onyxia)",
	NefBreath				= "Atem (Nefarian)",
	specWarnShadowblazeSoon	= "%s",
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding			= "Nefarian landet",
	OnySwipeTimer			= "Schwanzpeitscher CD (Ony)",
	NefSwipeTimer			= "Schwanzpeitscher CD (Nef)",
	OnyBreathTimer			= "Atem CD (Ony)",
	NefBreathTimer			= "Atem CD (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe			= "Zeige Warnung für Onyxias $spell:77827",
	NefTailSwipe			= "Zeige Warnung für Nefarians $spell:77827",
	OnyBreath				= "Zeige Warnung für Onyxias $spell:94124",
	NefBreath				= "Zeige Warnung für Nefarians $spell:94124",
	specWarnCinderMove		= "Zeige Spezialwarnung zum Weglaufen, wenn du von $spell:79339\nbetroffen bist (5s vor Explosion)",
	warnShadowblazeSoon		= "Zeige Vorwarnungscountdown für $spell:81031 (5s zuvor)\n(aus Genauigkeitsgründen erst nach Synchronisierung mit erstem Ausruf)",
	specWarnShadowblazeSoon	= "Zeige Spezialvorwarnung für $spell:81031 (aus Genauigkeits-\ngründen zu Beginn 5s Vorwarnung, 1s Vorwarnung nach erstem Ausruf)",
	timerNefLanding			= "Zeige Zeit bis Nefarian landet",
	OnySwipeTimer			= "Zeige Abklingzeit für Onyxias $spell:77827",
	NefSwipeTimer			= "Zeige Abklingzeit für Nefarians $spell:77827",
	OnyBreathTimer			= "Zeige Abklingzeit für Onyxias $spell:94124",
	NefBreathTimer			= "Zeige Abklingzeit für Nefarians $spell:94124",
	InfoFrame				= "Zeige Infofenster für Onyxias Elektrische Aufladung",
	SetWater				= "Automatische Deaktivierung der Kameraeinstellung 'Wasserkollision' bei\nKampfbeginn (wird nach Kampfende automatisch wieder aktiviert)",
	TankArrow				= "Zeige DBM-Pfeil für den Kiter von 'Belebter Knochenkrieger'\n(abgestimmt auf eine Kiter-Taktik)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame				= "Zeige Abstandsfenster (10m) für $spell:79339\n(zeigt jeden, falls du den Debuff hast; sonst nur markierte Spieler)"
})

L:SetMiscLocalization({
	NefAoe					= "Elektrizität lässt die Luft knistern!",
	YellPhase2				= "Verfluchte Sterbliche! Ein solcher Umgang mit dem Eigentum anderer verlangt nach Gewalt!",
	YellPhase3				= "Ich habe versucht, ein guter Gastgeber zu sein, aber ihr wollt einfach nicht sterben! Genug der Spielchen! Ich werde euch einfach... ALLE TÖTEN!",
	YellShadowBlaze			= "Fleisch wird zu Asche!",
	Nefarian				= "Nefarian",
	Onyxia					= "Onyxia",
	Charge					= "Elektrische Aufladung",
	ShadowBlazeExact		= "Schattensengen in %ds",
	ShadowBlazeEstimate		= "Schattensengen bald  (~5s)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Trash des Pechschwingenabstiegs"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})