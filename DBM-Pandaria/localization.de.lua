if GetLocale() ~= "deDE" then return end
local L

-----------------------
-- Sha of Anger --
-----------------------
L= DBM:GetModLocalization(691)

L:SetOptionLocalization({
	RangeFrame			= "Zeige dynamisches Abstandsfenster (5m) basierend auf Spieler-Debuffs für $spell:119622",
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "Ja... JA! Nutzt Eure Wut aus! Streckt mich nieder!"
})

-----------------------
-- Salyis --
-----------------------
L= DBM:GetModLocalization(725)

L:SetOptionLocalization({
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "Bringt mir ihre Leichen!"
})

--------------
-- Oondasta --
--------------
L= DBM:GetModLocalization(826)

L:SetOptionLocalization({
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "Ihr wagt es, uns're Vorbereitungen zu stör'n? Die Zandalari werd'n sich nicht aufhalten lass'n, diesmal nicht!"
})

---------------------------
-- Nalak, The Storm Lord --
---------------------------
L= DBM:GetModLocalization(814)

L:SetOptionLocalization({
	ReadyCheck			= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Weltboss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
})

L:SetMiscLocalization({
	Pull				= "Könnt Ihr den kalten Hauch spüren?"
})

---------------------------
-- Chi-ji, The Red Crane --
---------------------------
L= DBM:GetModLocalization(857)

L:SetOptionLocalization({
	BeaconArrow				= "Zeige DBM-Pfeil, wenn jemand von $spell:144473 betroffen ist"
})

L:SetMiscLocalization({
	Pull					= "Dann lasst uns beginnen.",
	Victory					= "Eure Hoffnung strahlt hell und sogar noch heller, wenn Ihr Euch zusammentut. Sie wird Euch stets den Weg weisen, selbst in tiefster Dunkelheit."
})

------------------------------
-- Yu'lon, The Jade Serpent --
------------------------------
L= DBM:GetModLocalization(858)

L:SetMiscLocalization({
	Pull					= "Die Prüfung beginnt!",
	Wave1					= "Lasst Euren Verstand nicht von schweren Zeiten verschleiern!",
	Wave2					= "Hört auf Eure innere Stimme und sucht nach der Wahrheit.",
	Victory					= "Eure Weisheit hat Euch diese Prüfung bestehen lassen. Möge sie Euch den Weg aus der Dunkelheit erhellen."
})

--------------------------
-- Niuzao, The Black Ox --
--------------------------
L= DBM:GetModLocalization(859)

L:SetMiscLocalization({
	Pull					= "Wir werden sehen.",
	Victory					= "Auch wenn Ihr von Feinden jenseits Eurer Vorstellungskraft umringt seid, wird Eure Ausdauer Euch bewahren. Erinnert Euch daran in den kommenden Tagen.",
	VictoryDem				= "Rakkas shi alar re pathrebosh il zila rethule kiel shi shi belaros rikk kanrethad adare revos shi xi thorje Rukadare zila te lok zekul melar "--needs to be verified
})

---------------------------
-- Xuen, The White Tiger --
---------------------------
L= DBM:GetModLocalization(860)

L:SetMiscLocalization({
	Pull					= "Ha ha! Die Prüfung beginnt!",
	Victory					= "Ihr seid stark. Stärker noch, als Euch klar ist. Tragt diesen Gedanken mit Euch in die Dunkelheit und lasst ihn Euch schützen."
})

------------------------------------
-- Ordos, Fire-God of the Yaungol --
------------------------------------
L= DBM:GetModLocalization(861)

L:SetMiscLocalization({
	Pull					= "Ihr werdet meinen Platz in den ewigen Flammen einnehmen."
})
