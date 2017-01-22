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

---------------------------
-- Elerethe Renferal --
---------------------------
L= DBM:GetModLocalization(1744)

L:SetWarningLocalization({
	warnWebOfPain		= ">%s< is linked to >%s<",--Only this needs localizing
	specWarnWebofPain	= "You are linked to >%s<"--Only this needs localizing
})

L:SetOptionLocalization({
	warnWebOfPain		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target:format(215307),--No need to copy to other locals
	specWarnWebofPain	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you:format(215307),--No need to copy to other locals
	WebConfiguration	= "Set HUD/Arrow options for Web of Pain",
	Disabled			= "Disabled",
	Arrow				= "Show only traditional Arrow if you're affected",
	HudSelf				= "Show HUD line only if you're affected",
	HudAll				= "Show HUD line for all affected targets"
})

L:SetMiscLocalization({
	MapMessage			= "Note: This mod uses arrow/HUD options that can be configured in GUI. These options will also break in 7.1"
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
