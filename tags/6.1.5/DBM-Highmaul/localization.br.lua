-- Last update by GlitterStorm @ Azralon on Feb,28th,2015
if GetLocale() ~= "ptBR" then return end

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
	pillarSpawn	= "ASCENDAM, MONTANHAS!"
})

------------------
-- Brackenspore, Walker of the Deep --
------------------
L= DBM:GetModLocalization(1196)

L:SetOptionLocalization({
	InterruptCounter	= "Contador da decomposição reseta após",  
	Two					= "depois de dois casts",
	Three				= "Depois de três casts", 
	Four				= "Depois de quatro casts"

-- cast translation would be lançar which relates to throw best to keep it at cast.

})

--------------
-- Twin Ogron --
--------------
L= DBM:GetModLocalization(1148)

L:SetOptionLocalization({
	PhemosSpecial		= "Play countdown sound for Phemos' cooldowns",
	PolSpecial			= "Toca contagem sonora para recargas do Pol",
	PhemosSpecialVoice	= "Toca alertas falados para habilidades do Phemos usando vozes selecionadas",
	PolSpecialVoice		= "Toca alertas falados para habilidades do Pol usando pacote de vozes previamente selecionadas"
})

--------------------
--Koragh --
--------------------
L= DBM:GetModLocalization(1153)


L:SetWarningLocalization({
	specWarnExpelMagicFelFades	= "Vil surgindo em 5s - Volte ao início"
})

L:SetOptionLocalization({
	specWarnExpelMagicFelFades	= "Toca aviso especial para retornar à posição inicial para $spell:172895 expirando"
})

L:SetMiscLocalization({
	supressionTarget1			= "Eu vou esmagá-lo!",
	supressionTarget2			= "Silêncio!",
	supressionTarget3			= "Quieto!",
	supressionTarget4			= "Eu vou rasgá-lo ao meio!"
})

--------------------------
-- Imperator Mar'gok --
--------------------------
L= DBM:GetModLocalization(1197)

L:SetTimerLocalization({
	timerNightTwistedCD	= "próximo Night-Twisted Adds"
})

L:SetOptionLocalization({
	GazeYellType		= "Escolha o tipo de grito para olhar do abismo",
	Countdown			= "contagem até expiração",
	Stacks				= "Quantidades conforme são aplicadas",
	timerNightTwistedCD	= "Exibe contador para o próximo Night-Twisted Faithful"
})

L:SetMiscLocalization({
	BrandedYell			= "Marcado (%d) %dy",
	GazeYell			= "Olhar do Abismo acabando %d",
	GazeYell2			= "Olhar do Abismo (%d) on %s",
	PlayerDebuffs		= "Perto do Vestígio"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HighmaulTrash")

L:SetGeneralLocalization({
	name =	"Malho Imponente Trash"
})