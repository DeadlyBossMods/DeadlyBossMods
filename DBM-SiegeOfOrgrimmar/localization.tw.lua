if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetOptionLocalization({
	InfoFrame			= "為$journal:8252顯示訊息框架"
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	InfoFrame			= "為$journal:8255顯示訊息框架"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetMiscLocalization({
	tower		= "The door barring the",--The door barring the South/North Tower has been breached!
	demolisher	= "[Kor'kron Demolisher]|h|r to assault the tower!"--In case they remove the bad epiccenter spellid will use this
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

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

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "顯示動態距離框架(10碼)\n(This is a smart range frame that shows when you reach Frenzy threshold)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.",
	newShredder	= "An Automated Shredder draws near!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "You are vulnerable to %s - Avoid!",
	specWarnCriteriaLinked			= "You are linked to %s!"
})

L:SetOptionLocalization({
	warnToxicCatalyst				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnToxicInjection			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(142528),
	specWarnToxicCatalyst			= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format("ej8036"),
	specWarnActivatedVulnerable		= "Show special warning when you are vulnerable to activating paragons",
	specWarnCriteriaLinked			= "Show special warning when you are linked to $spell:144095",
	SetIconOnAim					= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(142948),
	yellToxicCatalyst				= DBM_CORE_AUTO_YELL_OPTION_TEXT:format("ej8036"),
	RangeFrame						= DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format("6/5")
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

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("FoOTrash")

L:SetGeneralLocalization({
	name =	"圍攻奧格瑪小兵"
})
