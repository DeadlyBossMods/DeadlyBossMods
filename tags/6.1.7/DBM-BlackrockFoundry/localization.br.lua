-- Translated by GlitterStorm @ Azralon, last update: Feb.21th.2015
if GetLocale() ~= "ptBR" then return end

local L

---------------
-- Gruul --
---------------
L= DBM:GetModLocalization(1161)

---------------------------
-- Oregorger, The Devourer --
---------------------------
L= DBM:GetModLocalization(1202)

---------------------------
-- The Blast Furnace --
---------------------------
L= DBM:GetModLocalization(1154)

L:SetWarningLocalization({
	warnBlastFrequency	= "Frequência da explosão aumentou : Aprox cada %d seg"
})

L:SetOptionLocalization({
	warnBlastFrequency	= "Anuncia quando $spell:155209 frequência aumentar"
})

------------------
-- Hans'gar And Franzok --
------------------
L= DBM:GetModLocalization(1155)

--------------
-- Flamebender Ka'graz --
--------------
L= DBM:GetModLocalization(1123)

L:SetMiscLocalization({
	TorrentYell	= "Torrente derretida caindo em %d"
})

--------------------
--Kromog, Legend of the Mountain --
--------------------
L= DBM:GetModLocalization(1162)

--------------------------
-- Beastlord Darmac --
--------------------------
L= DBM:GetModLocalization(1122)

--------------------------
-- Operator Thogar --
--------------------------
L= DBM:GetModLocalization(1147)

L:SetWarningLocalization({
	specWarnSplitSoon	= "Divisão da raid em 10"
})

L:SetOptionLocalization({
	specWarnSplitSoon	= "Exibe um aviso especial 10 segundos antes da divisão da raid"
})

L:SetMiscLocalization({
	Train			= GetSpellInfo(174806),--TODO, verify this translates in BR, it probably doesn't.
	lane			= "Pista",
	oneTrain		= "1 pista aleatória: Trem",
	oneRandom		= "Aparece em 1 pista aleatória",
	threeTrains		= "3 pistas aleatórias: Trens",
	threeRandom		= "Aparecem em 3 pistas aleatórias",
	helperMessage	= "Esse encontro pode ser melhorado com mods de terceiros 'Thogar Assist' ou um dos muitos pacotes de vozes para DBM ( con avisos sonoros ) disponíveis no site da Curse."
})

--------------------------
-- The Iron Maidens --
--------------------------
L= DBM:GetModLocalization(1203)

L:SetMiscLocalization({
	shipMessage		= "prepara-se para usar o canhão principal do Couraçado!"
})

--------------------------
-- Blackhand --
--------------------------
L= DBM:GetModLocalization(959)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("BlackrockFoundryTrash")

L:SetGeneralLocalization({
	name =	"Trash da Fundição da Rocha Negra"
})
