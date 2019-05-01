if GetLocale() ~= "ruRU" then return end
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
--  Opulence (Alliance) --
---------------------------
L= DBM:GetModLocalization(2342)

L:SetWarningLocalization({

})

L:SetTimerLocalization({

})

L:SetOptionLocalization({

})

L:SetMiscLocalization({
	Bulwark =	"Защитник",
	Hand	=	"Десница"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"Well, if ya so eager for death, ya shoulda come see me sooner!",
	BwonsamdiWrath2 =	"Sooner or later... everybody serves me!",
	Bird			 =	"Гнев Па'ку"
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Дополнительно показывать предупреждения для фазы, в которой вы не находитесь (таймеры отображаются всегда независимо от этой опции)"
})

---------------------------
-- High Tinker Mekkatorgue (Horde) --
---------------------------
L= DBM:GetModLocalization(2332)

---------------------------
--  Sea Priest Blockade (Horde) --
---------------------------
L= DBM:GetModLocalization(2337)

---------------------------
--  Jaina Proudmoore (Horde) --
---------------------------
L= DBM:GetModLocalization(2343)

L:SetOptionLocalization({
	ShowOnlySummary2	= "Скрывать имена игроков при проверке дистанции и показывать только сводную информацию (количество игроков, находящихся рядом)",
	InterruptBehavior	= "Настройка ротации сбития каста элементалю (Переопределит настройки у всех, если вы рейд лидер)",
	Three				= "Ротация из 3 человек ",--Default
	Four				= "Ротация из 4 человек ",
	Five				= "Ротация из 5 человек ",
	SetWeather			= "Автоматически снижать настройку плотности погоды на минимум в начале боя и восстанавливать после боя",
})

L:SetMiscLocalization({
	Port			=	"по левому борту",
	Starboard		=	"по правому борту",
	Freezing		=	"Заморозка через %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Dazar'alor Trash"
})
