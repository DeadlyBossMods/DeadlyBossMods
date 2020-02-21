local L

---------------------------
--  Ra'wani Kanae/Frida Ironbellows (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alliance)

--L= DBM:GetModLocalization(2333)--Frida Ironbellows (Horde)

---------------------------
--  King Grong/Grong the Revenant (Both) --
---------------------------
--L= DBM:GetModLocalization(2325)--King Grong (Horde)

--L= DBM:GetModLocalization(2340)--Grong the Revenant (Alliance)

---------------------------
--  Grimfang and Firecaller/Flamefist and the Illuminated (Both) --
-- Same exact enoucnter, diff names
---------------------------
--L= DBM:GetModLocalization(2323)--Grimfang and Firecaller (Alliance)

--L= DBM:GetModLocalization(2341)--Flamefist and the Illuminated (Horde)

---------------------------
--  Opulence (Alliance) --
---------------------------
L= DBM:GetModLocalization(2342)

L:SetMiscLocalization({
	Bulwark =	"Bulwark",
	Hand	=	"Hand"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"Well, if ya so eager for death, ya shoulda come see me sooner!",
	BwonsamdiWrath2 =	"Sooner or later... everybody serves me!",
	Bird			 =	"Bird"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Show general warnings for phase you aren't in as well (timers will always be shown regardless of this option)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
--L= DBM:GetModLocalization(2332)

---------------------------
--  Sea Priest Blockade (Horde) --
---------------------------
--L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Horde) --
---------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "Hide player names on reverse range check and show only the summary info (the total nearby player count)",
	InterruptBehavior	= "Set elemental interrupt behavior (Will override everyone elses setting if you are raid leader)",
	Three				= "3 person rotation ",--Default
	Four				= "4 person rotation ",
	Five				= "5 person rotation ",
	SetWeather			= "Automatically turn weather density setting to lowest when boss is engaged and restore on combat end",
})

L:SetMiscLocalization({
	Port			=	"port side",
	Starboard		=	"starboard side",
	Freezing		=	"Freezing in %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Dazar'alor Trash"
})
