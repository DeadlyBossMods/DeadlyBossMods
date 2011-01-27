if GetLocale() ~= "deDE" then return end
local L

--------------
--  Magmaw  --
--------------
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magmaul"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Blazing Bone Construct Soon (~4s)",--translate
	WarnPhase2Soon	= "Phase 2 bald"

})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Slump			= "%s schlittert nach vorne und entblößt seine Zangen!",
	HeadExposed		= "%s spießt sich selbst auf, was seinen Kopf freilegt!",
	YellPhase2		= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales." --translate
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Zeige Spezialvorwarnung für $spell:92190 (~4s)",
	WarnPhase2Soon	= "Zeige Vorwarnung für Phase 2",
	RangeFrame		= "Zeige Abstandsfenster in Phase 2 (8)"

})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Omnotron-Verteidigungssystem"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Arkaner Kurzschluss",
	timerShadowConductorCast	= "Schattenleiter"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Zeige Timer für das Wirken von $spell:92053",
	timerArcaneBlowbackCast	= "Zeige Timer für das Wirken von $spell:91879",
	AcquiringTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	BombTargetIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(80094),
	ShadowConductorIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053)
})

L:SetMiscLocalization({
	Magmatron		= "Magmatron",
	Electron		= "Elektron",
	Toxitron		= "Toxitron",
	Arcanotron		= "Arkanotron"
})

----------------
--  Maloriak  --
----------------
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase		= "%s Phase",
	WarnRemainingAdds	= "%d Entartungen verbleiben"
})

L:SetTimerLocalization({
	TimerPhase		= "Nächste Phase"
})

L:SetMiscLocalization({
	YellRed			= "wirft eine |cFFFF0000rote|r Phiole in den Kessel!",
	YellBlue		= "wirft eine |cFFFF0000blaue|r Phiole in den Kessel!",
	YellGreen		= "wirft eine |cFFFF0000grüne|r Phiole in den Kessel!",
	YellDark		= "dark|r vial into the cauldron!",--guesswork, this isn't confirmed but if it's consistent with other strings is probably right.
	Red				= "rot",
	Blue			= "blau",
	Green			= "grün",
	Dark			= "dunkel" --most likely not
})

L:SetOptionLocalization({
	WarnPhase		= "Zeige Warnung, welche Phase kommt",
	WarnRemainingAdds	= "Zeige Warnung, wieviele Entartungen verbleiben",
	TimerPhase		= "Zeige Timer für die nächste Phase",
	RangeFrame		= "Zeige Abstandsfenster (6) während der blauen Phase",
	FlashFreezeIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

-----------------
--  Chimaeron  --
-----------------
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Chimaeron"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "Phase 2 bald",
	WarnBreak	= "%s auf >%s< (%d)"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "Zeige Vorwarnung für Phase 2",
	RangeFrame		= "Zeige Abstandsfenster(6)",
	WarnBreak	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(82881, GetSpellInfo(82881) or "unknown"),
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame	= "Zeige Infofenst4er für Gesundheit (<10k hp)"

})

-----------------
--  Atramedes  --
-----------------
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase		= "Luftphase",
	WarnGroundphase		= "Bodenphase",
	WarnShieldsLeft		= "Uralter Zwergenschild genutzt - noch %d" 
})

L:SetTimerLocalization({
	TimerAirphase		= "Luftphase",
	TimerGroundphase	= "Bodenphase"
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Uralter Zwergenschild",
	Soundlevel				= "Soundlevel",
	Airphase		= "Ja, lauft! Jeder Schritt lässt Euer Herz stärker klopfen. Laut und heftig... ohrenbetäubend. Es gibt kein Entkommen!"
})

L:SetOptionLocalization({
	WarnAirphase		= "Zeige Warnung, wenn Atramedes abhebt",
	WarnGroundphase		= "Zeige Warnung, wenn Atramedes landet",
	WarnShieldsLeft		= "Zeige Warnung, wenn ein Uralter Zwergenschild benutzt wird",
	TimerAirphase		= "Zeige Timer für die nächste Luftphase",
	TimerGroundphase	= "Zeige Timer für die nächste Bodenphase",
	InfoFrame			= "Zeige Infofebster für Soundlevel",
	TrackingIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-BD")	-- No conflict with BWL version :)

L:SetGeneralLocalization({
	name = "Nefarian"
})

L:SetWarningLocalization({
	OnyTailSwipe		= "Tail Lash (Onyxia)",
	NefTailSwipe		= "Tail Lash (Nefarian)",
	OnyBreath			= "Breath (Onyxia)",
	NefBreath			= "Breath (Nefarian)"
})

L:SetTimerLocalization({
	OnySwipeTimer		= "Tail Lash CD (Ony)",
	NefSwipeTimer		= "Tail Lash CD (Nef)",
	OnyBreathTimer		= "Breath CD (Ony)",
	NefBreathTimer		= "Breath CD (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe		= "Show warning for Onyxia's $spell:77827",
	NefTailSwipe		= "Show warning for Nefarian's $spell:77827",
	OnyBreath			= "Show warning for Onyxia's $spell:94124",
	NefBreath			= "Show warning for Nefarian's $spell:94124",
	OnySwipeTimer		= "Show timer for Onyxia's $spell:77827 cooldown",
	NefSwipeTimer		= "Show timer for Nefarian's $spell:77827 cooldown",
	OnyBreathTimer		= "Show timer for Onyxia's $spell:94124 cooldown",
	NefBreathTimer		= "Show timer for Nefarian's $spell:94124 cooldown",
	YellOnCinder		= "Yell on $spell:79339",
	RangeFrame			= "Show range frame (10) when you have $spell:79339",
	SetIconOnCinder		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339)
})

L:SetMiscLocalization({
	NefAoe				= "The air crackles with electricity!",--translate
	YellPhase2			= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",--translate
	YellPhase3			= "I have tried to be an accommodating host, but you simply will not die! Time to throw all pretense aside and just... KILL YOU ALL!",--translate
	YellCinder			= "Explosive Cinders on me!"--translate
})