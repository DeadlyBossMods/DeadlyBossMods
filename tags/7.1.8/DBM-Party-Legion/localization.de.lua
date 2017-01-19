if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- <<<Black Rook Hold>>> --
-----------------------
-----------------------
-- The Amalgam of Souls --
-----------------------
L= DBM:GetModLocalization(1518)

-----------------------
-- Illysanna Ravencrest --
-----------------------
L= DBM:GetModLocalization(1653)

-----------------------
-- Smashspite the Hateful --
-----------------------
L= DBM:GetModLocalization(1664)

-----------------------
-- Lord Kur'talos Ravencrest --
-----------------------
L= DBM:GetModLocalization(1672)

-----------------------
--Black Rook Hold Trash
-----------------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name =	"Trash der Rabenwehr"
})

-----------------------
-- <<<Darkheart Thicket>>> --
-----------------------
-----------------------
-- Arch-Druid Glaidalis --
-----------------------
L= DBM:GetModLocalization(1654)

-----------------------
-- Oakheart --
-----------------------
L= DBM:GetModLocalization(1655)

-----------------------
-- Dresaron --
-----------------------
L= DBM:GetModLocalization(1656)

-----------------------
-- Shade of Xavius --
-----------------------
L= DBM:GetModLocalization(1657)

-----------------------
--Darkheart Thicket Trash
-----------------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name =	"Trash des Finsterherzdickichts"
})


-----------------------
-- <<<Eye of Azshara>>> --
-----------------------
-----------------------
-- Warlord Parjesh --
-----------------------
L= DBM:GetModLocalization(1480)

-----------------------
-- Lady Hatecoil --
-----------------------
L= DBM:GetModLocalization(1490)

L:SetWarningLocalization({
	specWarnStaticNova			= "Statische Nova - geh auf Sanddüne",
	specWarnFocusedLightning	= "Gebündelter Blitz - geh ins Wasser"
})

-----------------------
-- King Deepbeard --
-----------------------
L= DBM:GetModLocalization(1491)

-----------------------
-- Serpentrix --
-----------------------
L= DBM:GetModLocalization(1479)

-----------------------
-- Wrath of Azshara --
-----------------------
L= DBM:GetModLocalization(1492)

-----------------------
--Eye of Azshara Trash
-----------------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name =	"Trash des Auge Azsharas"
})

-----------------------
-- <<<Halls of Valor>>> --
-----------------------
-----------------------
-- Hymdall --
-----------------------
L= DBM:GetModLocalization(1485)

-----------------------
-- Hyrja --
-----------------------
L= DBM:GetModLocalization(1486)

-----------------------
-- Fenryr --
-----------------------
L= DBM:GetModLocalization(1487)

-----------------------
-- God-King Skovald --
-----------------------
L= DBM:GetModLocalization(1488)

-----------------------
-- Odyn --
-----------------------
L= DBM:GetModLocalization(1489)

L:SetMiscLocalization({
	tempestModeMessage		=	"Nicht Orkanabfolge: %s. Prüfe erneut in 8 Sekunden."
})

-----------------------
--Halls of Valor Trash
-----------------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name =	"Trash der Hallen der Tapferkeit"
})

-----------------------
-- <<<Neltharion's Lair>>> --
-----------------------
-----------------------
-- Rokmora --
-----------------------
L= DBM:GetModLocalization(1662)

-----------------------
-- Ularogg Cragshaper --
-----------------------
L= DBM:GetModLocalization(1665)

-----------------------
-- Naraxas --
-----------------------
L= DBM:GetModLocalization(1673)

-----------------------
-- Dargrul the Underking --
-----------------------
L= DBM:GetModLocalization(1687)

-----------------------
--Neltharion's Lair Trash
-----------------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name =	"Trash des Neltharions Hort"
})

-----------------------
-- <<<The Arcway>>> --
-----------------------
-----------------------
-- Ivanyr --
-----------------------
L= DBM:GetModLocalization(1497)

-----------------------
-- Nightwell Sentry --
-----------------------
L= DBM:GetModLocalization(1498)

-----------------------
-- General Xakal --
-----------------------
L= DBM:GetModLocalization(1499)

L:SetMiscLocalization({
	batSpawn		=	"Reinforcements to me! NOW!"--translate (trigger)
})

-----------------------
-- Nal'tira --
-----------------------
L= DBM:GetModLocalization(1500)

-----------------------
-- Advisor Vandros --
-----------------------
L= DBM:GetModLocalization(1501)

-----------------------
--The Arcway Trash
-----------------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name =	"Trash des Arkus"
})

-----------------------
-- <<<Court of Stars>>> --
-----------------------
-----------------------
-- Patrol Captain Gerdo --
-----------------------
L= DBM:GetModLocalization(1718)

-----------------------
-- Talixae Flamewreath --
-----------------------
L= DBM:GetModLocalization(1719)

-----------------------
-- Advisor Melandrus --
-----------------------
L= DBM:GetModLocalization(1720)

-----------------------
--Court of Stars Trash
-----------------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name =	"Trash des Hofs der Sterne"
})

L:SetOptionLocalization({
	SpyHelper	= "Hilf bei der Erkennung des Spions"
})

L:SetMiscLocalization({
	Gloves1		= "Einem Gerücht zufolge trägt der Spion immer Handschuhe.",
	Gloves2		= "Wie ich hörte, verbirgt der Spion sorgfältig die Hände.",
	Gloves3		= "Ich hörte, dass der Spion immer Handschuhe anlegt.",
	Gloves4		= "Jemand behauptete, dass der Spion Handschuhe trägt, um sichtbare Narben zu verbergen.",
	NoGloves1	= "Es gibt Gerüchte, dass der Spion niemals Handschuhe trägt.",
	NoGloves2	= "Wisst Ihr... Ich habe ein zusätzliches Paar Handschuhe im Hinterzimmer gefunden. Wahrscheinlich ist der Spion hier irgendwo mit bloßen Händen unterwegs.",
	NoGloves3	= "Mir ist zu Ohren gekommen, dass der Spion ungern Handschuhe trägt.",
	NoGloves4	= "Ich hörte, dass der Spion es vermeidet, Handschuhe zu tragen, falls er schnell handeln muss.",
	Cape1		= "Jemand erwähnte, dass der Spion vorhin hier hereinkam und einen Umhang trug.",
	Cape2		= "",
	NoCape1		= "Ich hörte, dass der Spion keine Umhänge mag und sich weigert, einen zu tragen.",
	NoCape2		= "Ich hörte, dass der Spion seinen Umhang im Palast gelassen hat, bevor er hierhergekommen ist.",
	LightVest1	= "Der Spion bevorzugt auf jeden Fall Westen mit hellen Farben.",
	LightVest2	= "",
	LightVest3	= "Die Leute sagen, dass der Spion heute Abend keine dunkle Weste trägt.",
	DarkVest1	= "Der Spion bevorzugt auf alle Fälle dunkle Kleidung.",
	DarkVest2	= "Ich hörte, dass die Weste des Spions heute Abend von dunkler, kräftiger Farbe ist.",
	DarkVest3	= "Dem Spion gefallen Westen mit dunklen Farben... dunkel wie die Nacht.",
	DarkVest4	= "Gerüchte zufolge vermeidet der Spion es, helle Kleidung zu tragen, damit er nicht so auffällt.",
	Female1		= "Ein Gast hat beobachtet, wie sie und Elisande vorhin gemeinsam eingetroffen sind.",
	Female2		= "Wie ich höre, hat eine Frau sich ständig nach diesem Bezirk erkundigt...",
	Female3		= "Jemand hat behauptet, dass unser neuester Gast nicht männlich ist.",
	Female4		= "Man sagt, die Spionin wäre hier und sie wäre eine wahre Augenweide.",
	Male1		= "Irgendwo habe ich gehört, dass der Spion nicht weiblich ist.",
	Male2		= "Ich hörte, dass der Spion ein äußerst gutaussehender Herr ist.",
	Male3		= "Ein Gast sagte, sie sah, wie ein Herr an der Seite der Großmagistrix das Anwesen betreten hat.",
	Male4		= "Einer der Musiker sagte, er stellte unablässig Fragen über den Bezirk.",
	ShortSleeve1= "Mir ist zu Ohren gekommen, dass der Spion kurze Ärmel trägt, damit er seine Arme ungehindert bewegen kann.",
	ShortSleeve2= "Jemand sagte mir, dass der Spion lange Ärmel hasst.",
	ShortSleeve3= "Einer meiner Freundinnen sagte, dass sie die Kleidung des Spions gesehen hat. Er trägt keine langen Ärmel.",
	ShortSleeve4= "Mir ist zu Ohren gekommen, dass der Spion die kühle Luft mag und deshalb heute Abend keine langen Ärmel trägt.",
	LongSleeve1 = "Wie ich höre, trägt der Spion heute Abend Kleidung mit langen Ärmeln.",
	LongSleeve2 = "Jemand sagte, dass der Spion heute Abend seine Arme mit langen Ärmeln bedeckt.",
	LongSleeve3 = "Ich habe am frühen Abend einen kurzen Blick auf die langen Ärmel des Spions erhascht.",
	LongSleeve4 = "Einer meiner Freunde erwähnte, dass der Spion lange Ärmel trägt.",
	Potions1	= "Ich hörte, dass der Spion Tränke mitgebracht hat... Ich frage mich wieso?",
	Potions2	= "Von mir habt Ihr das nicht... aber der Spion verkleidet sich als Alchemist und trägt Tränke an seinem Gürtel.",
	Potions3	= "Ich bin mir ziemlich sicher, dass der Spion Tränke am Gürtel trägt.",
	Potions4	= "Wie ich hörte, hat der Spion einige Tränke mitgebracht... für alle Fälle.",
	NoPotions1	= "Wie ich hörte, hat der Spion keine Tränke bei sich.",
	NoPotions2	= "Eine Musikerin erzählte mir, dass sie gesehen hat, wie der Spion seinen letzten Trank wegwarf und jetzt keinen mehr übrig hat.",
	Book1		= "Ich hörte, dass der Spion immer ein Buch mit niedergeschriebenen Geheimnissen am Gürtel trägt.",
	Book2		= "Gerüchte zufolge liest der Spion gerne und trägt immer mindestens ein Buch bei sich.",
	Pouch1		= "Ich hörte, dass der Spion immer einen magischen Beutel mit sich herumträgt.",
	Pouch2		= "",
	Pouch3		= "",
	Pouch4		= "",
	--
	Gloves		= "Handschuhe",
	NoGloves	= "keine Handschuhe",
	Cape		= "Umhang",
	Nocape		= "kein Umhang",
	LightVest	= "helle Weste",
	DarkVest	= "dunkle Weste",
	Female		= "weiblich",
	Male		= "männlich",
	ShortSleeve = "kurze Ärmel",
	LongSleeve	= "lange Ärmel",
	Potions		= "Tränke",
	NoPotions	= "keine Tränke",
	Book		= "Buch",
	Pouch		= "Beutel"
})


-----------------------
-- <<<The Maw of Souls>>> --
-----------------------
-----------------------
-- Ymiron, the Fallen King --
-----------------------
L= DBM:GetModLocalization(1502)

-----------------------
-- Harbaron --
-----------------------
L= DBM:GetModLocalization(1512)

-----------------------
-- Helya --
-----------------------
L= DBM:GetModLocalization(1663)

-----------------------
--Maw of Souls Trash
-----------------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name =	"Trash des Seelenschlundes"
})

-----------------------
-- <<<Assault Violet Hold>>> --
-----------------------
-----------------------
-- Mindflayer Kaahrj --
-----------------------
L= DBM:GetModLocalization(1686)

-----------------------
-- Millificent Manastorm --
-----------------------
L= DBM:GetModLocalization(1688)

-----------------------
-- Festerface --
-----------------------
L= DBM:GetModLocalization(1693)

-----------------------
-- Shivermaw --
-----------------------
L= DBM:GetModLocalization(1694)

-----------------------
-- Blood-Princess Thal'ena --
-----------------------
L= DBM:GetModLocalization(1702)

-----------------------
-- Anub'esset --
-----------------------
L= DBM:GetModLocalization(1696)

-----------------------
-- Sael'orn --
-----------------------
L= DBM:GetModLocalization(1697)

-----------------------
-- Fel Lord Betrug --
-----------------------
L= DBM:GetModLocalization(1711)

-----------------------
--Assault Violet Hold Trash
-----------------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name =	"Trash des Sturms auf die VF"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Neues Portal bald",
	WarningPortalNow	= "Portal %d",
	WarningBossNow		= "Boss kommt"
})

L:SetTimerLocalization({
	TimerPortal			= "Portal CD"
})

L:SetOptionLocalization({
	WarningPortalNow		= "Zeige Warnung für neues Portal",
	WarningPortalSoon		= "Zeige Vorwarnung für neues Portal",
	WarningBossNow			= "Zeige Warnung für neuen Boss",
	TimerPortal				= "Zeige Timer für nächstes Portal (nach einem Boss)"
})

L:SetMiscLocalization({
	Malgath		=	"Lord Malgath"
})

-----------------------
-- <<<Vault of the Wardens>>> --
-----------------------
-----------------------
-- Tirathon Saltheril --
-----------------------
L= DBM:GetModLocalization(1467)

-----------------------
-- Inquisitor Tormentorum --
-----------------------
L= DBM:GetModLocalization(1695)

-----------------------
-- Ash'golm --
-----------------------
L= DBM:GetModLocalization(1468)

-----------------------
-- Glazer --
-----------------------
L= DBM:GetModLocalization(1469)

-----------------------
-- Cordana --
-----------------------
L= DBM:GetModLocalization(1470)

-----------------------
--Vault of Wardens Trash
-----------------------
L = DBM:GetModLocalization("VoWTrash")

L:SetGeneralLocalization({
	name =	"Trash des Verlieses der Wächterinnen"
})

-----------------------
-- <<<Return To Karazhan>>> --
-----------------------
-----------------------
-- Maiden of Virtue --
-----------------------
L= DBM:GetModLocalization(1825)

-----------------------
-- Opera Hall: Wikket  --
-----------------------
L= DBM:GetModLocalization(1820)

-----------------------
-- Opera Hall: Westfall Story --
-----------------------
L= DBM:GetModLocalization(1826)

-----------------------
-- Opera Hall: Beautiful Beast  --
-----------------------
L= DBM:GetModLocalization(1827)

-----------------------
-- Attumen the Huntsman --
-----------------------
L= DBM:GetModLocalization(1835)

-----------------------
-- Moroes --
-----------------------
L= DBM:GetModLocalization(1837)

-----------------------
-- The Curator --
-----------------------
L= DBM:GetModLocalization(1836)

-----------------------
-- Shade of Medivh --
-----------------------
L= DBM:GetModLocalization(1817)

-----------------------
-- Mana Devourer --
-----------------------
L= DBM:GetModLocalization(1818)

-----------------------
-- Viz'aduum the Watcher --
-----------------------
L= DBM:GetModLocalization(1838)

-----------------------
--Nightbane
-----------------------
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization({
	name =	"Schrecken der Nacht"
})

-----------------------
--Return To Karazhan Trash
-----------------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name =	"Trash der Rückkehr nach Karazhan"
})

L:SetMiscLocalization({
	speedRun		=	"Die seltsame Kühle einer dunklen Präsenz durchweht die Luft..."
})

