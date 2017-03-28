local L

---------------
-- Nythendra --
---------------
L= DBM:GetModLocalization(1703)

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------
-- Il'gynoth, Heart of Corruption --
---------------------------
L= DBM:GetModLocalization(1738)

L:SetOptionLocalization({
	SetIconOnlyOnce2	= "Set icon only once per ooze scan then disable until at least one blows up (experimental)",
	InfoFrameBehavior	= "Set information InfoFrame shows during encounter",
	Fixates				= "Show players affected by Fixate",
	Adds				= "Show add counts for all add types"
})

L:SetMiscLocalization({
	AddSpawnNotice		= "As players overgear encounter, add spawns grow increasingly faster as encounter was designd by blizzard with auto pacing code. As such, if you overgear/overkill fight, take the add spawn timers witha grain of salt."
})

---------------------------
-- Elerethe Renferal --
---------------------------
L= DBM:GetModLocalization(1744)

L:SetWarningLocalization({
	warnWebOfPain		= ">%s< is linked to >%s<",--Only this needs localizing
	specWarnWebofPain	= "You are linked to >%s<"--Only this needs localizing
})

---------------------------
-- Ursoc --
---------------------------
L= DBM:GetModLocalization(1667)

L:SetOptionLocalization({
	NoAutoSoaking2		= "Disable all auto soaking related warnings/arrows/HUDs for Focused Gaze"
})

L:SetMiscLocalization({
	SoakersText			= "Soakers Assigned: %s"
})

---------------------------
-- Dragons of Nightmare --
---------------------------
L= DBM:GetModLocalization(1704)

------------------
-- Cenarius --
------------------
L= DBM:GetModLocalization(1750)

L:SetMiscLocalization({
	BrambleYell			= "Brambles NEAR " .. UnitName("player") .. "!",
	BrambleMessage		= "Note: DBM can't detect who is actually FIXATED by Bramble. It does, however, warn who the initial target is for the SPAWN. Boss picks player, throws it them. After this, bramble picks ANOTHER target mods can't detect"
})

------------------
-- Xavius --
------------------
L= DBM:GetModLocalization(1726)

L:SetOptionLocalization({
	InfoFrameFilterDream	= "Filter players who are affected by $spell:206005 from the InfoFrame"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EmeraldNightmareTrash")

L:SetGeneralLocalization({
	name =	"Emerald Nightmare Trash"
})
