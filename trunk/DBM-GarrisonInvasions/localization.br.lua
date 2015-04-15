--Last update by GlitterStorm @ Azralon on Feb,21th,2015

if GetLocale() ~= "ptBR" then return end

local L

--------------------------
--  Garrison Invasions  --
--------------------------
L = DBM:GetModLocalization("GarrisonInvasions")

L:SetGeneralLocalization({
	name = "Invasão das guarnições"
})

L:SetWarningLocalization({
	specWarnRylak	= "Catador Alanegra esta vindo",
	specWarnWorker	= "Trabalhador aterrorizado em perigo",
	specWarnSpy		= "Um espião infiltrou-se em",
	specWarnBuilding= "Uma construção esta sendo atacada"
})

L:SetOptionLocalization({
	specWarnRylak	= "Mostra aviso especial quando um Catador Alanegra estiver vindo",
	specWarnWorker	= "Mostra aviso especial quando um trabalhador aterrorizado estiver em perigo",
	specWarnSpy		= "Mostra aviso especial quando um espião infiltrar-se",
	specWarnBuilding= "Mostra aviso especial quando uma construção estiver sendo atacada"
})

L:SetMiscLocalization({
	--General
	preCombat			= "Às armas! para os seus postos!",--Comum em todos os gritos, restante varia de acordo com a invasão
	preCombat2			= "O céu se escureceu abruptamente...",--Conselho das sombras não segue o formato das outras :\
	rylakSpawn			= "A comoção da batalha atraiu um Catador Alanegra!",--origem pnj Catador Alanegra, alvo nomejogador
	terrifiedWorker		= "Trabalhador aterrorizado em perigo!",
	sneakySpy			= "espião se infiltrou em meio ao caos!",--encurtado para ajustar "horde/alliance"
	buildingAttack		= "A %s esta sob ataque!",--Seu ferro-velho esta sob ataque!
	--Ogre
	GorianwarCaller		= "Um Belarauto Goriano juntou-se a batalha e levantou o moral!",--Talvez combinado "add" aviso especial maioria dos adds?
	WildfireElemental	= "Um Elemental do Fogo Indômito esta sendo convocado no portão frontal!",--Talvez combinado "add" aviso especial maioria dos adds?
	--Iron Horde
	Assassin			= "Um assassino esta caçando seus guardas!"--Talvez combinado "add" aviso especial maioria dos adds??
})