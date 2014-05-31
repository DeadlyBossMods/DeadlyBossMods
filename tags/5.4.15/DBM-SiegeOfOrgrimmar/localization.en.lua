local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory			= "Ah, you have done it!  The waters are pure once more."
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	warnCalamity		= "%s",
	specWarnCalamity	= "%s",
	specWarnMeasures	= "Desperate Measures soon (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime			= "Very well, I will create a field to keep your corruption quarantined."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Set icon on Corrupted Fragment"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen		= "Tower opened",
	warnTowerGrunt		= "Tower Grunt"
})

L:SetTimerLocalization({
	timerTowerCD		= "Next Tower",
	timerTowerGruntCD	= "Next Tower Grunt"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Announce when tower opens",
	warnTowerGrunt		= "Announce when new tower grunt spawns",
	timerTowerCD		= "Show timer for next tower assault",
	timerTowerGruntCD	= "Show timer for next tower grunt"
})

L:SetMiscLocalization({
	wasteOfTime		= "Well done! Landing parties, form up! Footmen to the front!",--Alliance Version
	wasteOfTime2	= "Well done. The first brigade has made landfall.",--Horde Version
	Pull			= "Dragonmaw clan, retake the docks and push them into the sea!  In the name of Hellscream and the True Horde!",
	newForces1		= "Here they come!",--Jaina's line, alliance
	newForces1H		= "Bring her down quick so i can wrap my fingers around her neck.",--Sylva's line, horde
	newForces2		= "Dragonmaw, advance!",
	newForces3		= "For Hellscream!",
	newForces4		= "Next squad, push forward!",
	tower			= "The door barring the"--The door barring the South/North Tower has been breached!
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

L:SetOptionLocalization({
	timerAssaultModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8177"),
	timerSiegeModeCD		= DBM_CORE_AUTO_TIMER_OPTIONS.next:format("ej8178")
})

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Prison on %s fades (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Defensive Stance in %ds"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "Show pre-warning countdown for $spell:143593 (5s before)"
})

L:SetMiscLocalization({
	newForces1					= "Warriors, on the double!",
	newForces2					= "Defend the gate!",
	newForces3					= "Rally the forces!",
	newForces4					= "Kor'kron, at my side!",
	newForces5					= "Next squad, to the front!",
	allForces					= "All Kor'kron... under my command... kill them... NOW!",
	nextAdds					= "Next Adds: ",
	mage						= "|c"..RAID_CLASS_COLORS["MAGE"].colorStr..LOCALIZED_CLASS_NAMES_MALE["MAGE"].."|r",
	shaman						= "|c"..RAID_CLASS_COLORS["SHAMAN"].colorStr..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].."|r",
	rogue						= "|c"..RAID_CLASS_COLORS["ROGUE"].colorStr..LOCALIZED_CLASS_NAMES_MALE["ROGUE"].."|r",
	hunter						= "|c"..RAID_CLASS_COLORS["HUNTER"].colorStr..LOCALIZED_CLASS_NAMES_MALE["HUNTER"].."|r",
	warrior						= "|c"..RAID_CLASS_COLORS["WARRIOR"].colorStr..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].."|r"
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
	wasteOfTime		= "Hey, we recording?  Yeah?  Okay.  Goblin-Titan control module starting up, please stand back.",
	Module1 		= "Module 1's all prepared for system reset.",
	Victory			= "Module 2's all prepared for system reset."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Show dynamic range frame (10)<br/>(This is a smart range frame that shows when you reach Frenzy threshold)"
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
	specWarnMoreParasites			= "You need more parasites - Do NOT block!"
})

L:SetOptionLocalization({
	warnToxicCatalyst				= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format("ej8036"),
	specWarnActivatedVulnerable		= "Show special warning when you are vulnerable to activating paragons",
	specWarnMoreParasites			= "Show special warning when you need more parasites",
	yellToxicCatalyst				= DBM_CORE_AUTO_YELL_OPTION_TEXT:format("ej8036")
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "One",
	two					= "Two",
	three				= "Three",
	four				= "Four",
	five				= "Five",
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "You won't be leaping anymore!",---Does not have quests, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetTimerLocalization({
	timerRoleplay		= GUILD_INTEREST_RP
})

L:SetOptionLocalization({
	timerRoleplay		= "Show timer for Garrosh/Thrall RP",
	RangeFrame			= "Show dynamic range frame (8)<br/>(This is a smart range frame that shows when you reach $spell:147126 threshold)",
	InfoFrame			= "Show info frame for players without damage reduction during intermission",
	yellMaliceFading	= "Yell when $spell:147209 is about to fade"
})

L:SetMiscLocalization({
	wasteOfTime			= "It is not too late, Garrosh. Lay down the mantle of Warchief. We can end this here, now, with no more bloodshed.",
	NoReduce			= "No damage reduction",
	MaliceFadeYell		= "Malice fading on %s (%d)"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"Siege of Orgrimmar Trash"
})
