if GetLocale() ~= "itIT" then return end
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
	Bulwark =	"Protettore",
	Hand	=	"Mano"
})

---------------------------
--  Loa Council (Alliance) --
---------------------------
L= DBM:GetModLocalization(2330)

L:SetMiscLocalization({
	BwonsamdiWrath =	"Well, if ya so eager for death, ya shoulda come see me sooner!", -- TODO
	BwonsamdiWrath2 =	"Sooner or later... everybody serves me!", -- TODO
	Bird			 =	"Uccello" -- TODO
})

---------------------------
--  King Rastakhan (Alliance) --
---------------------------
L= DBM:GetModLocalization(2335)

L:SetOptionLocalization({
	AnnounceAlternatePhase	= "Mostra avvisi generali per le fasi in cui non ti trovi (i temporizzatori verranno comunque sempre mostrati)"
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
	ShowOnlySummary2	= "Nascondi giocatori nel distanziometro inverso e mostra solo info sommarie (totale giocatori vicini)",
	InterruptBehavior	= "Imposta comportamento interruzione elementale (Sovrascriverà ogni impostazione altrui se capogruppo)",
	Three				= "rotazione a 3 persone ",--Default
	Four				= "rotazione a 4 persone ",
	Five				= "rotazione a 5 persone",
	SetWeather			= "Imposta densità effetti climatici al minimo all'ingaggio del boss e ripristina al termine",
})

L:SetMiscLocalization({
	Port			=	"lato porto",
	Starboard		=	"lato tribordo",
	Freezing		=	"Congelamento tra %s"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ZuldazarRaidTrash")

L:SetGeneralLocalization({
	name =	"Scartini Dazar'alor"
})
