if GetLocale() ~= "ptBR" then return end

local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom imita %s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "Exibir avisos quando Kohcrom imita habilidades.",
	KohcromCD		= "Exibir cronógrafo para a próxima imitação de habilidade de Kohcrom.",
	RangeFrame		= "Exibir medidor de distância (5) para conquista."
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
    ShadowYell	= "Gritar ao ser afetado por $spell:104600\n(Apenas modo heróico)",
	CustomRangeFrame	= "Opções do medidor de distância",
	Never				= "Desabilitado",
	Normal				= "Medidor Normal",
	DynamicPhase2		= "Filtrar penalidades na Fase 2",
	DynamicAlways		= "Sempre filtrar penalidades"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s absorvidas %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "Glóbulos atacáveis"
})

L:SetOptionLocalization({
	warnOozesHit		= "Anunciar quais glóbulos atingem o chefe",
	timerOozesActive	= "Exibir cronógrafo para quando os Glóbulos se tornam atacáveis",
	RangeFrame			= "Exibir medidor de distância (4) para $spell:104898\n(Modo Normal+)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242Negro|r",
	Purple			= "|cFF9932CDPúrpura|r",
	Red				= "|cFFFF0404Vermelho|r",
	Green			= "|cFF088A08Verde|r",
	Blue			= "|cFF0080FFAzul|r",
	Yellow			= "|cFFFFA901Amarelo|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d restantes",
	warnFrostTombCast		= "%s em 8 seg"
})

L:SetTimerLocalization({
	TimerSpecial			= "Primeiro especial"
})

L:SetOptionLocalization({
	WarnPillars				= "Anunciar quantos $journal:3919 ou $journal:4069 restam",
	TimerSpecial			= "Exibir cronógrafo para lançamento da primeira habilidade",
    RangeFrame				= "Exibir medidor de distância: (3) para $spell:105269, (10) para $journal:4327",
	AnnounceFrostTombIcons	= "Anunciar no chat da raide, ícones para alvos de $spell:104451\n(requer liderança)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448, GetSpellInfo(104448)),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	SpecialCount			= "Tocar som de contagem regressiva para $spell:105256 ou $spell:105465",
	SetBubbles				= "Automaticamente desabilitar balões de voz quando $spell:104451 está disponível\n(Voltando ao normal ao fim do combate)"
})

L:SetMiscLocalization({
	TombIconSet				= "Ícone de Tumba de Gelo {rt%d} colocado em %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) em 5s"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion pousa",
	timerRaidCDs		= "%s CD: %s"--spellname CD Castername
})

L:SetOptionLocalization({
	TimerCombatStart	= "Exibir cronógrafo para início do combate.",
	ResetHoTCounter		= "Reiniciar contador de Hora do Crepúsculo",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "Nunca",
	ResetDynamic		= "Zerar a cada 3/2 (heróico/normal)",
	Reset3Always		= "Sempre zerar a cada 3",
	SpecWarnHoTN		= "Aviso especial 5s antes de Hora do Crepúsculo. Se configurado para Nunca zerar, a regra de 3 em 3 será utilizada.",
	One					= "1 (ou seja, 1 4 7)",
	Two					= "2 (ou seja, 2 5)",
	Three				= "3 (ou seja, 3 6)",
	dropdownRaidCDs		= "Exibir cronógrafos para recargas da raide.",
	ShowRaidCDs			= "Todo mundo",
	ShowRaidCDsSelf		= "Apenas meus"
})

L:SetMiscLocalization({
	Pull				= "Eu sinto uma grande desordem no equilíbrio que se aproxima. O caos incendeia a minha mente!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "Elites do Crepúsculo!"
})

L:SetTimerLocalization({
	TimerCombatStart	= "Início do combate",
	TimerAdd			= "Próximos Elites"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Exibir cronógrafo para o início do combate",
	TimerAdd			= "Exibir cronógrafo para o surgimento de próximos Elites do Crepúsculo!",
	SpecWarnElites		= "Exibir aviso especial para novos Elites do Crepúsculo",
	SetTextures			= "Automaticamente desabilitar texturas projetadas durante a fase 1\n(Habilita novamente na fase 2)"
})

L:SetMiscLocalization({
	SapperEmote			= "Um draco mergulha para lançar um Sapador do Crepúsculo ao convés!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat			= "se contorce de dor e retira-se entre as nuvens rodopiantes."
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	SpecWarnTendril			= "Segure-se!"
})

L:SetOptionLocalization({
	SpecWarnTendril			= "Exibir aviso especial quando você não tem $spell:109454",--http://ptr.wowhead.com/npc=56188
	InfoFrame				= "Exibir quadro de informações para jogadores sem $spell:109454",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109459),
	ShowShieldInfo			= "Exibir vida do chefe, com uma barra de vida para $spell:105479"
})

L:SetMiscLocalization({
	Pull		= "As placas! Ele está se desfazendo! Destruam as placas e teremos uma chance de derrotá-lo!",
	NoDebuff	= "Sem %s",
	PlasmaTarget	= "Plasma Calcinante: %s",
	DRoll		= "prestes a rolar",
	DLevels			= "nivela"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetOptionLocalization({
	RangeFrame			= "Exibir medidor de distância dinâmico baseado nas penalidades do jogador para\n$spell:108649 na dificuldade heróica",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "Vocês não fizeram NADA. Seu mundo será DESTRUÍDO."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"Trash de Dragonsoul"
})

L:SetWarningLocalization({
	DrakesLeft			= "Agressores do Crepúsculo restantes: %d"
})

L:SetTimerLocalization({
	TimerDrakes			= "%s",--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "Anunciar quantos Agressores do Crepúsculo restam",
	TimerDrakes			= "Exibir cronógrafo para quando Assaltantes do Crepúsculo $spell:109904"
})

L:SetMiscLocalization({
	EoEEvent			= "Não adianta, o poder da Alma é muito grande",--Partial
	UltraxionTrash		= "Que bom vê-la novamente, Alexstrasza. Estive ocupado na minha ausência.",
	UltraxionTrashEnded = "Simples dragonetes, experimentos, um meio para uma causa maior. Você verá os frutos da pesquisa que minha prole fez."
})