if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Kargath Bladefist --
---------------
L= DBM:GetModLocalization(1128)

---------------------------
-- The Butcher --
---------------------------
L= DBM:GetModLocalization(971)

---------------------------
-- Tectus, the Living Mountain --
---------------------------
L= DBM:GetModLocalization(1195)

L:SetMiscLocalization({
	pillarSpawn	= "MONTAÑAS, ELVATE !"
})


------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "Reinicializar el número de Descomposiciones después de",
	Two					= "Después de dos lanzamientos",
	Three				= "Después de tres lanzamientos",
	Four				= "Después de cuatro lanzamientos"
})

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial		= "Reproduce un sonido de cuenta regresiva para los cooldowns de Phemos",
	PolSpecial			= " Reproduce un sonido de cuenta regresiva para los cooldowns de Pol",
	PhemosSpecialVoice	= "Reproduce alertas de voz para las habilidades de Phemos utilizando el pack de voz seleccionado",
	PolSpecialVoice		= " Reproduce alertas de voz para las habilidades de Pol utilizando el pack de voz seleccionado "
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)


L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "Gangrena disipada en 5s ? vuelve a tu punto de partida"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "Fijar una alerta especial para volver a su punto de partida cuando $spell:172895 se disipe"
})

L:SetMiscLocalization({
	supressionTarget1	= "Te borraré !",
	supressionTarget2	= "Silencio !",
	supressionTarget3	= "Cállate !", 
	supressionTarget4	= "Te reduciré a pedazos !"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetOptionLocalization({
	GazeYellType		= "Elegir el tipo de grito para Mirada del Abismo",
	Countdown			= "Cuenta regresiva hasta su desaparición",
	Stacks				= "Número de marcas en cada aplicación"
})

L:SetMiscLocalization({
	BrandedYell			= "Marca (%s) sobre %s",
	GazeYell			= "Mirada desaparece en %d",
	GazeYell2			= "Mirada (%d) sobre %s",
	PlayerDebuffs		= "Más cerca de la vista general"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Trash de Cognefort"
})