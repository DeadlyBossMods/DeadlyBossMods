if GetLocale() ~= "ruRU" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
	InfoFrame			= "Информационное окно для $journal:8255"
})

L:SetMiscLocalization({
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	newForces1				= "Warriors, on the double!",
	newForces2				= "Defend the gate!",
	newForces3				= "Rally the forces!",
	newForces4				= "Kor'kron, at my side!",
	newForces5				= "Next squad, to the front!"
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.",
	newShredder	= "An Automated Shredder draws near!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "Вы уязвимы к %s - Избегайте!",
	specWarnCriteriaLinked			= "Вы слинкованы с %s!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Спец-предупреждение когда идеал, к которому вы уязвимы активирует идеалов",
	specWarnCriteriaLinked			= "Спец-предупреждение когда вы слинкованы с $spell:144095"
})

L:SetMiscLocalization({
	calculatedTarget	= "calculating eye!",
	--thanks to blizz, the only accurate way for this to work, is to translate 15 emotes in all languages
	yellow				= "Yellow",
	red					= "Red",
	blue				= "Blue",
	purple				= "Purple",
	green				= "Green",
	bomb				= "Bomb",
	sword				= "Swords",
	drums				= "Drums",
	mantid				= "Mantid",--Assumed
	staff 				= "Staff",--Assumed
	one					= "One",
	two					= "Pair",
	three				= "Three",
	four				= "Four",--Assumed
	five				= "Five",--Assumed
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "You won't be leaping anymore!",---Does not have questst, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("FoOTrash")

L:SetGeneralLocalization({
	name =	"Трэш мобы Осады Оргриммара"
})

L:SetOptionLocalization({
})
