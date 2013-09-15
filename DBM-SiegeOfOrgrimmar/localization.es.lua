if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory			= "Ah, you have done it!  The waters are pure once more." --TODO need translation
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetOptionLocalization({
	InfoFrame			= "Mostrar marco de información para $journal:8252"
})

L:SetMiscLocalization({
	wasteOfTime			= "Muy bien, crearé un campo para mantener aislada vuestra corrupción."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	InfoFrame			= "Mostrar marco de información para $journal:8255"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerTowerCD	= "Siguiente torre"
})

L:SetOptionLocalization({
	timerTowerCD	= "Mostrar temporizador para el siguiente asalto a la torre"
})

L:SetMiscLocalization({
	newForces1	= "Here they come!",--Jaina's line, horde may not be same, TODO need translation
	newForces2	= "Dragonmaw, advance!", --TODO need translation
	newForces3	= "For Hellscream!", --TODO need translation
	newForces4	= "Next squad, push forward!", --TODO need translation
	tower		= "The door barring the"--The door barring the South/North Tower has been breached!, TODO need translation
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Prisión en %s se desvanece (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Actitud defensiva en %ds"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "Mostrar cuenta atrás de pre-aviso para $spell:143593 (5s antes)"
})

L:SetMiscLocalization({
	newForces1					= "Warriors, on the double!", --TODO need translation
	newForces2					= "Defend the gate!", --TODO need translation
	newForces3					= "Rally the forces!", --TODO need translation
	newForces4					= "Kor'kron, at my side!", --TODO need translation
	newForces5					= "Next squad, to the front!", --TODO need translation
	allForces					= "All Kor'kron... under my command... kill them... NOW!" --TODO need translation
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	Module1 = "Module 1's all prepared for system reset.", --TODO need translation
	Victory	= "Module 2's all prepared for system reset" --TODO need translation
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Mostrar radar de rango dinámico (10)<br/>(Se muestra cuando llegas a umbral de \"Frenzy\")" --TODO need translation
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.", --TODO need translation
	newShredder	= "An Automated Shredder draws near!" --TODO need translation
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "Eres vulnerable a %s - ¡Esquiva!",
	specWarnCriteriaLinked			= "!Estás enlazado a %s!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Mostrar aviso especial cunado eres vulnerable a activar paragons",
	specWarnCriteriaLinked			= "Mostrar aviso especial cuando estés enlazado con $spell:144095"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "One", --TODO need translation
	two					= "Two", --TODO need translation
	three				= "Three", --TODO need translation
	four				= "Four", --TODO need translation
	five				= "Five", --TODO need translation
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510  --TODO need translation
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109  --TODO need translation
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216  --TODO need translation
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024  --TODO need translation
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808  --TODO need translation
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232  --TODO need translation
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232  --TODO need translation
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305  --TODO need translation
	KarozFlavor			= "You won't be leaping anymore!",---Does not have questst, http://ptr.wowhead.com/npc=65303  --TODO need translation
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178  --TODO need translation
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508  --TODO need translation
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"Entre-Jefes del Asedio de Orgrimmar"
})
