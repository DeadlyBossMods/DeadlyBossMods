if GetLocale() ~= "deDE" then return end
local L

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"Ändere auf heroischem/mythischem Schwierigkeitsgrad die Reihung der Timer für die Abklingzeiten der Bossfähigkeiten zugunsten der Übersichtlichkeit auf Kosten der Genauigkeit (1-2s zeitiger)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		=	"Nächster Verdunkler (%s)",
	timerDestructor 	=	"Nächster Zerstörer (%s)",
	timerPurifier 		=	"Nächster Läuterer (%s)",
	timerBats	 		=	"Nächste Fledermäuse (%s)"
})

L:SetMiscLocalization({
	Obfuscators =	"Verdunkler",
	Destructors =	"Zerstörer",
	Purifiers 	=	"Läuterer",
	Bats 		=	"Fledermäuse",
	EonarHealth	= 	"Eonar Leben",
	EonarPower	= 	"Eonar Energie",
	NextLoc		=	"Nächste:"
})

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"Zeige alle Ansagen unabhängig von der Spielerplattform"
})

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

L:SetMiscLocalization({
	DispelMe =		"Reinige mich!"
})

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Zeige Infofenster für Kampfübersicht",
	UseAddTime = "Zeige, während der Boss sich in der Bauphase befindet, weiterhin die Timer zur Anzeige was als Nächstes kommt, anstatt sie zu verstecken (falls deaktiviert, werden die korrekten Timer fortgesetzt, wenn der Boss wieder aktiv wird, bieten aber ggf. nur eine geringe Vorwarnzeit, falls Fähigkeiten in 1-2 Sekunden wieder verfügbar sein sollten)"
})

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetTimerLocalization({
	timerBossIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerBossIncoming	= "Zeige Zeit bis nächsten Bosswechsel",
	TauntBehavior		= "Setze Spottverhalten für Tankwechsel",
	TwoMythicThreeNon	= "Wechsel bei 2 Stacks (mythisch) bzw. 3 Stacks (andere Schwierigkeitsgrade)",
	TwoAlways			= "Wechsel immer bei 2 Stacks (unabhängig vom Schwierigkeitsgrad)",
	ThreeAlways			= "Wechsel immer bei 3 Stacks (unabhängig vom Schwierigkeitsgrad)",
	SetLighting			= "Grafikeinstellung 'Beleuchtungsqualität' automat. auf 'Niedrig' setzen (wird nach dem Kampfende auf die vorherige Einstellung zurückgesetzt)",
	InterruptBehavior	= "Setze Unterbrechungsverhalten für Schlachtzug (nur als Schlachtzugsleiter)",
	Three				= "3-Personen-Rotation",
	Four				= "4-Personen-Rotation",
	Five				= "5-Personen-Rotation",
	IgnoreFirstKick		= "Allererste Unterbrechung bei der Rotation nicht berücksichtigen (nur als Schlachtzugsleiter)"
})

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

L:SetOptionLocalization({
	ignoreThreeTank	= "Unterdrücke Schnitt/Brecher Spottspezialwarnungen bei Verwendung von drei oder mehr Tanks (da DBM für diese Zusammensetzung die genaue Tankrotation nicht bestimmen kann). Falls ein Tank stirbt und die Anzahl auf 2 fällt, wird dieser Filter automatisch deaktiviert."
})

L:SetMiscLocalization({
	Foe			=	"Brecher",
	Rend		=	"Schnitt",
	Tempest 	=	"Sturm",
	Current		=	"Aktuell:"
})

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "Urteil CD (%s)"
})

L:SetMiscLocalization({
	SeaText		=	"{rt6} Tempo/Viels",
	SkyText		=	"{rt5} Krit/Meist",
	Blight		=	"Seuche",
	Burst		=	"Explosion",
	Sentence	=	"Urteil",
	Bomb		=	"Bombe"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Trash des Antorus"
})
