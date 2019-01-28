-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2018/01/28

if GetLocale() ~= "zhCN" then return end
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
--  Opulence (Alliance) -- 宝藏守护者
---------------------------
L= DBM:GetModLocalization(2342)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
	Bulwark =	"壁垒",
	Hand	=	"手"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"既然你们这么想死，干嘛不早点来找我？",
	BwonsamdiWrath2 =	"迟早……所有人都会臣服于我！",
	Bird			 =	"鸟"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "即使你不在对应位面也显示警告 (计时条不受影响)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
L= DBM:GetModLocalization(2332)

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
	name =	"达萨罗之战小怪"
})
