if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

-------------------------
-- Rompemundos garothi --
-------------------------
L= DBM:GetModLocalization(1992)

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

---------------------------------
-- Canes manáfagos de Sargeras --
---------------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers =	"Secuenciar los temporizadores en función al último lanzamiento de cada habilidad en lugar del siguiente para reducir el desajuste de temporizadores a cambio de una leve pérdida de precisión (uno o dos segundos de margen de error)"
})

------------------------
-- Alto Mando antoran --
------------------------
L= DBM:GetModLocalization(1997)

----------------------------------
-- Eonar, la Patrona de la Vida --
----------------------------------
L= DBM:GetModLocalization(2025)

L:SetMiscLocalization({
	Obfuscators =	"Ofuscadores",
	Destructors =	"Destructores"
})

---------------------------------
-- Vigilante de portal Hasabel --
---------------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms =	"Mostrar todos los avisos independientemente de tu plataforma actual"
})

--Xoroth = "¡Admirad Xoroth, un mundo de calor infernal y huesos calcinados!",
--Rancora = "¡Contemplad Rancora, un horizonte de pozas infectas y muerte por doquier!",
--Nathreza = "Nathreza... Antaño un mundo de magia y conocimiento, ahora un escabroso lugar del que nadie puede escapar."

--------------------------------
-- Imonar el Cazador de Almas --
--------------------------------
L= DBM:GetModLocalization(2009)

----------------
-- Kin'garoth --
----------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Mostrar marco de información con una vista general del combate"
})

-----------------
-- Varimathras --
-----------------
L= DBM:GetModLocalization(1983)

------------------------
-- Aquelarre shivarra --
------------------------
L= DBM:GetModLocalization(1986)

L:SetTimerLocalization({
	timerBossIncoming		= DBM_INCOMING
})

L:SetOptionLocalization({
	timerBossIncoming		= "Mostrar temporizador para el siguiente cambio de jefe"
})

--------------
-- Aggramar --
--------------
L= DBM:GetModLocalization(1984)

--------------------------
-- Argus el Aniquilador --
--------------------------
L= DBM:GetModLocalization(2031)

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
