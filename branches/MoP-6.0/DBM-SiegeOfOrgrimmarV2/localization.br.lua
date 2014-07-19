if GetLocale() ~= "ptBR" then return end

local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnMeasures	= "Medidas desesperadas em breve (%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime			= "Muito bem. Eu criarei um campo para manter sua corrupção isolada."
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "Definir ícone no Fragmento Corrompido"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen		= "Torre aberta",
	warnTowerGrunt		= "Bruto da Torre"
})

L:SetTimerLocalization({
	timerTowerCD		= "Próxima Torre",
	timerTowerGruntCD	= "Próximo Bruto da Torre"
})

L:SetOptionLocalization({
	warnTowerOpen		= "Anunciar quanto uma torre é aberta",
	warnTowerGrunt		= "Anunciar quando o próximo bruto da torre aparecer",
	timerTowerCD		= "Mostrar temporizador para o próximo assalto à torre",
	timerTowerGruntCD	= "Mostrar temporizador para o próximo bruto da torre"
})

L:SetMiscLocalization({
	wasteOfTime		= "Muito bem! Grupos de desembarque, formação! Infantaria para a frente!",--Alliance Version
	wasteOfTime2	= "Muito bem. A primeira brigada desembarcou.",--Horde Version
	Pull			= "Clã Presa do Dragão, retomem as docas e mandem todos de volta para o mar! Em nome de Grito Infernal e da Verdadeira Horda!",
	newForces1		= "Lá vem eles!",--Jaina's line, alliance
	newForces1H		= "Desçam-na logo, para que eu possa colocar meus dedos em volta do seu pescoço.",--Sylva's line, horde
	newForces2		= "Presa do Dragão, avante!",
	newForces3		= "Por Grito Infernal!",
	newForces4		= "Próximo esquadrão, avançar!",
	tower			= "A porta fechando a"--A porta fechando a Torre Sul/Norte foi derrubada!
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell		= "Prisão em %s dissipa (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "Postura Defensiva em %ds"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "Mostrar pre-aviso de contagem regressiva para $spell:143593 (5s antes)"
})

L:SetMiscLocalization({
	newForces1					= "Guerreiros, depressa!",
	newForces2					= "Defendam o portão!",
	newForces3					= "Reúnam as forças!",
	newForces4					= "Kor'kron, ao meu lado!",
	newForces5					= "Próximo esquadrão, avante!",
	allForces					= "Todos os Kor'kron... sob meu comando... matem-os... AGORA!",
	nextAdds					= "Próximos Adds: "
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime		= "Estamos gravando? Hein? Tudo bem. Módulo de controle do Titã-goblin iniciando, afastem-se.",
	Module1 		= "Modulo 1's preparado para reiniciar o sistema.",
	Victory			= "Modulo 2's preparado para reiniciar o sistema."
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "Mostrar frame dinâmico de distância (10)<br/>(Este é um frame de distância inteligente que mostra quando você alcança o limiar do Frenesi)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Armas inacabadas começam a surgir na linha de montagem.",
	newShredder	= "Um Retalhador Automatizado se aproxima!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "Você está vulnerável para %s - Evite!",
	specWarnMoreParasites			= "Você precisa de mais parasitas - NÂO bloqueie!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "Mostrar aviso especial quando você está vulnerável à paragões em ativamento",
	specWarnMoreParasites			= "Mostrar aviso especial quando você precisar de mais parasitas"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "Um",
	two					= "Dois",
	three				= "Três",
	four				= "Quatro",
	five				= "Cinco",
	hisekFlavor			= "Olha quem está em silêncio agora",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Apenas mais um dia, expurgando o enxame",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "Eu vejo apenas céus sombrios no seu futuro",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Reduzidos à meros lanches de kunchong",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 mantideo a menos, só faltam mais 199",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "O fim de um antigo império",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Pegue suas Tabuletas de Gurthani e engasgue com elas",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "Veja oportunidades. Aproveite-as!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "Você não vai pular mais!",---Does not have quests, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "Uma delícia sangrenta!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Solicitação de espécime atendida"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	timerRoleplay		= "Mostrar temporizador Garrosh/Thrall RP",
	RangeFrame			= "Mostrar frame dinâmico de distância (8)<br/>(Este é um frame de distância inteligente que mostra quando você alcança o limiar de $spell:147126)",
	InfoFrame			= "Mostrar um frame informativo para jogadores sem redução de dano durante a intermission",
	yellMaliceFading	= "Gritar quando $spell:147209 estiver para acabar"
})

L:SetMiscLocalization({
	wasteOfTime			= "Não é tarde demais, Garrosh. Abstenha-se do posto de Chefe Guerreiro. Podemos encerrar isso sem mais derramamento de sangue.",
	NoReduce			= "Sem redução de dano",
	MaliceFadeYell		= "Malícia acabando em %s (%d)",
	phase3End			= "Vocês pensam que VENCERAM?"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"Trash de Cerco a Orgrimmar"
})
