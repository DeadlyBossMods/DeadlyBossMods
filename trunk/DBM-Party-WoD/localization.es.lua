if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L


----------------
-- Auchindoun --
----------------
-----------------------
-- Vigilante Kaathar --
-----------------------
L= DBM:GetModLocalization(1185)

--------------------------------
-- Vinculadora de almas Nyami --
--------------------------------
L= DBM:GetModLocalization(1186)

-------------
-- Azzakel --
-------------
L= DBM:GetModLocalization(1216)

---------------
-- Teron'gor --
---------------
L= DBM:GetModLocalization(1225)

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("AuchTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-------------------------
-- Minas Machacasangre --
-------------------------
-----------------------
-- Magmolatus --
-----------------------
L= DBM:GetModLocalization(893)

-----------------------------------
-- Vigilante de esclavos Crushto --
-----------------------------------
L= DBM:GetModLocalization(888)

-------------
-- Roltall --
-------------
L= DBM:GetModLocalization(887)

--------------
-- Gug'rokk --
--------------
L= DBM:GetModLocalization(889)

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("BSMTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

----------------------
-- Terminal Malavía --
----------------------
------------------------
-- Chispahete y Borka --
------------------------
L= DBM:GetModLocalization(1138)

------------------------------
-- Nitrogg Torre del Trueno --
------------------------------
L= DBM:GetModLocalization(1163)

L:SetWarningLocalization({
	warnGrenadeDown			= "%s en el suelo",
	warnMortarDown			= "%s en el suelo"
})

----------------------------
-- Señora del cielo Tovra --
----------------------------
L= DBM:GetModLocalization(1133)

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("GRDTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

----------------------
-- Puerto de Hierro --
----------------------
--------------------------
-- Sacrificador Nok'gar --
--------------------------
L= DBM:GetModLocalization(1235)

----------------------
-- Déspotas Malavía --
----------------------
L= DBM:GetModLocalization(1236)

-----------
-- Oshir --
-----------
L= DBM:GetModLocalization(1237)

-------------
-- Skulloc --
-------------
L= DBM:GetModLocalization(1238)

----------------------
-- El Vergel Eterno --
----------------------
-------------------
-- Cortezamustia --
-------------------
L= DBM:GetModLocalization(1214)

--------------------------
-- Ancianos protectores --
--------------------------
L= DBM:GetModLocalization(1207)

-------------------
-- Archimaga Sol --
-------------------
L= DBM:GetModLocalization(1208)

--------------
-- Xeri'tac --
--------------
L= DBM:GetModLocalization(1209)

L:SetMiscLocalization({
	Pull	= "¡Xeri'tac comienza a lanzarte arañitas tóxicas!"
})

-----------
-- Yalnu --
-----------
L= DBM:GetModLocalization(1210)

------------------------------
-- Cementerio de Sombraluna --
------------------------------
-----------------------------
-- Sadana Furia Sangrienta --
-----------------------------
L= DBM:GetModLocalization(1139)

--------------
-- Nhallish --
--------------
L= DBM:GetModLocalization(1168)

----------------
-- Quijahueso --
----------------
L= DBM:GetModLocalization(1140)

--------------
-- Ner'zhul --
--------------
L= DBM:GetModLocalization(1160)

----------------------
-- Trecho Celestial --
----------------------
------------
-- Ranjit --
------------
L= DBM:GetModLocalization(965)

--------------
-- Araknath --
--------------
L= DBM:GetModLocalization(966)

-------------
-- Rukhran --
-------------
L= DBM:GetModLocalization(967)

----------------------
-- Suma sabia Viryx --
----------------------
L= DBM:GetModLocalization(968)

L:SetWarningLocalization({
	warnAdd			= DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell:format("Ensamblaje de protección del Trecho Celestial"),
	specWarnAdd		= DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch:format("Ensamblaje de protección del Trecho Celestial")
})

L:SetOptionLocalization({
	warnAdd			= "Mostrar aviso para Ensamblaje de protección del Trecho Celestial",
	specWarnAdd		= "Mostrar aviso especial para cambiar de objetivo a Ensamblaje de protección del Trecho Celestial"
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("SkyreachTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

-----------------------------------
-- Cumbre de Roca Negra Superior --
-----------------------------------
----------------------------
-- Doblegamenas Gor'ashan --
----------------------------
L= DBM:GetModLocalization(1226)

-----------
-- Kyrak --
-----------
L= DBM:GetModLocalization(1227)

------------------------
-- Comandante Tharbek --
------------------------
L= DBM:GetModLocalization(1228)

-------------------------
-- Alaíra el Indomable --
-------------------------
L= DBM:GetModLocalization(1229)

-------------------------------
-- Señora de la guerra Zaela --
-------------------------------
L= DBM:GetModLocalization(1234)

L:SetTimerLocalization({
	timerZaelaReturns	= "Zaela vuelve a tierra"
})

L:SetOptionLocalization({
	timerZaelaReturns	= "Mostrar temporizador para cuando Zaela vuelva a tierra"
})

------------------------
--  Enemigos menores  --
------------------------
L = DBM:GetModLocalization("UBRSTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
