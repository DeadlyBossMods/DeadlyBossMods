local L

---------------------------
--  Ra'wani Kanae/Frida Ironbellows (Both) --
-- Same exact enoucnter, diff names
---------------------------
L= DBM:GetModLocalization(2344)--Ra'wani Kanae (Alliance)

L= DBM:GetModLocalization(2333)--Frida Ironbellows (Horde)

---------------------------
--  King Grong/Grong the Revenant (Both) --
---------------------------
L= DBM:GetModLocalization(2325)--King Grong (Horde)

L= DBM:GetModLocalization(2340)--Grong the Revenant (Alliance)

---------------------------
--  Grimfang and Firecaller/Flamefist and the Illuminated (Both) --
-- Same exact enoucnter, diff names
---------------------------
L= DBM:GetModLocalization(2323)--Grimfang and Firecaller (Alliance)

L= DBM:GetModLocalization(2341)--Flamefist and the Illuminated (Horde)

---------------------------
--  Treasure Guardian (Both) --
---------------------------
L= DBM:GetModLocalization(2342)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
	Bulwark =	"Bulwark",
	Hand	=	"Hand"
})

---------------------------
--  Loa Council (Both) --
---------------------------
L= DBM:GetModLocalization(2330)

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
L= DBM:GetModLocalization(2332)

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Show general warnings for phase you aren't in as well (timers will always be shown regardless of this option)"
})

---------------------------
--  Sea Priest Blockade (Both) --
---------------------------
L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Both?) --
---------------------------
L= DBM:GetModLocalization(2343)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Dazar'alor Trash"
})
