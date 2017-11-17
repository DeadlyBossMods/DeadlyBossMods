if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

------------
-- Goroth --
------------
L= DBM:GetModLocalization(1862)

---------------------------
-- Inquisición demoníaca --
---------------------------
L= DBM:GetModLocalization(1867)

--------------
-- Harjatan --
--------------
L= DBM:GetModLocalization(1856)

-----------------------
-- Maestra Sassz'ine --
-----------------------
L= DBM:GetModLocalization(1861)

L:SetOptionLocalization({
	TauntOnPainSuccess	= "Sincronizar temporizadores y avisos de provocar para el final del lanzamiento de Carga de dolor en lugar del comienzo (para ciertas estrategias de mítico en que se deja que Carga de dolor golpee una vez, de lo contrario no se recomienda activar esta opción)"
})

-------------------------
-- Hermanas de la Luna --
-------------------------
L= DBM:GetModLocalization(1903)

-----------------------
-- Huésped Inhóspito --
-----------------------
L= DBM:GetModLocalization(1896)

L:SetOptionLocalization({
	IgnoreTemplarOn3Tank	= "Ignorar la Armadura de huesos de los Templarios reanimados en el marco de información, los anuncios y los marcos de unidad cuando haya tres o más tanques (no cambiar en medio de combate, rompe los contadores)"
})

--------------------
-- Doncella Vigía --
--------------------
L= DBM:GetModLocalization(1897)

------------------
-- Avatar Caído --
------------------
L= DBM:GetModLocalization(1873)

L:SetOptionLocalization({
	InfoFrame =	"Mostrar marco de información con una vista general del combate"
})

L:SetMiscLocalization({
	FallenAvatarDialog	= "Aunque este cuerpo fue en otro tiempo el receptor del poder de Sargeras, el templo en sí es nuestra recompensa. Gracias a él, ¡reduciremos vuestro mundo a cenizas!"
})

----------------
-- Kil'jaeden --
----------------
L= DBM:GetModLocalization(1898)

L:SetWarningLocalization({
	warnSingularitySoon		= "Empujón en %ds"
})

L:SetMiscLocalization({
	Obelisklasers	= "Láser de obelisco"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("TombSargTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})
