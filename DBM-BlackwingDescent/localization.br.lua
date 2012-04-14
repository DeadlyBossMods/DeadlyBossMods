if GetLocale() ~= "ptBR" then return end

local L

--------------
--  Magmaw  --
--------------
--L = DBM:GetModLocalization(170)
L = DBM:GetModLocalization("Magmaw")

L:SetGeneralLocalization({
	name = "Magorja"
})

L:SetWarningLocalization({
	SpecWarnInferno	= "Constructo Ósseo Incandescente em breve (~4s)"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnInferno	= "Exibir aviso especial antecipado para $spell:92190 (~4s)",
	RangeFrame		= "Exibir medidor de distância na fase 2 (5)"
})

L:SetMiscLocalization({
	Slump			= "%s slumps forward, exposing his pincers!",
	HeadExposed		= "%s becomes impaled on the spike, exposing his head!",
	YellPhase2		= "Inconceivable! You may actually defeat my lava worm! Perhaps I can help... tip the scales."
})

-------------------------------
--  Dark Iron Golem Council  --
-------------------------------
--L = DBM:GetModLocalization(169)
L = DBM:GetModLocalization("DarkIronGolemCouncil")

L:SetGeneralLocalization({
	name = "Sistema de Defesa Omnitron"
})

L:SetWarningLocalization({
	SpecWarnActivated			= "Mude de alvo para %s!",
	specWarnGenerator			= "Gerador de Energia - Mexa-se %s!"
})

L:SetTimerLocalization({
	timerArcaneBlowbackCast		= "Explosão Arcana Reversa",
	timerShadowConductorCast	= "Infusão Sombria",
	timerNefAblity				= "Recarga Melhorar Habilidades",
	timerArcaneLockout			= "Aniquilador em Recarga"
})

L:SetOptionLocalization({
	timerShadowConductorCast	= "Exibir cronógrafo para lançamento de $spell:92048",
	timerArcaneBlowbackCast		= "Exibir cronógrafo para lançamento de $spell:91879",
	timerArcaneLockout			= "Exibir cronógrafo para recarga de $spell:91542",
	timerNefAblity				= "Exibir cronógrafo para recarga do bônus Melhorar Habilidade (modo Heróico)",
	SpecWarnActivated			= "Exibir aviso especial quando um novo chefe é ativado",
	specWarnGenerator			= "Exibir aviso especial quando um chefe obtém $spell:91557",
	AcquiringTargetIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79501),
	ConductorIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79888),
	ShadowConductorIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92053),
	SetIconOnActivated			= "Colocar ícone no último chefe ativado"
})

L:SetMiscLocalization({
	Magmatron					= "Magmatron",
	Electron					= "Eléctron",
	Toxitron					= "Toxitron",
	Arcanotron					= "Arcanotron",
	YellTargetLock				= "Sombra Envolvente! Fiquem longe!"
})

----------------
--  Maloriak  --
----------------
--L = DBM:GetModLocalization(173)
L = DBM:GetModLocalization("Maloriak")

L:SetGeneralLocalization({
	name = "Maloriak"
})

L:SetWarningLocalization({
	WarnPhase			= "Fase %s",
	WarnRemainingAdds	= "%d aberrações restantes"
})

L:SetTimerLocalization({
	TimerPhase			= "Próxima fase"
})

L:SetOptionLocalization({
	WarnPhase			= "Exibir aviso indicando qual será a próxima fase",
	WarnRemainingAdds	= "Exibir aviso indicando quantas aberrações restam",
	TimerPhase			= "Exibir cronógrafo para a próxima fase",
	RangeFrame			= "Exibir medidor de distância (6) durante a fase azul",
	SetTextures			= "Automaticamente desabilitar texturas projetadas durante a fase escura\n(habilita novamente ao término da fase)",
	FlashFreezeIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(92979),
	BitingChillIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77760),
	ConsumingFlamesIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(77786)
})

L:SetMiscLocalization({
	YellRed				= "red|r vial into the cauldron!",--Partial matchs, no need for full strings unless you really want em, mod checks for both.
	YellBlue			= "blue|r vial into the cauldron!",
	YellGreen			= "green|r vial into the cauldron!",
	YellDark			= "dark|r magic into the cauldron!",
	Red					= "Vermelha",
	Blue				= "Azul",
	Green				= "Verde",
	Dark				= "Escura"
})

-----------------
--  Chimaeron  --
-----------------
--L = DBM:GetModLocalization(172)
L = DBM:GetModLocalization("Chimaeron")

L:SetGeneralLocalization({
	name = "Khímaron"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	RangeFrame		= "Exibir medidor de distância (6)",
	SetIconOnSlime	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(82935),
	InfoFrame		= "Exibir quadro de informações para vida (<10k pv)"
})

L:SetMiscLocalization({
	HealthInfo	= "Informações de vida"
})

-----------------
--  Atramedes  --
-----------------
--L = DBM:GetModLocalization(171)
L = DBM:GetModLocalization("Atramedes")

L:SetGeneralLocalization({
	name = "Atramedes"
})

L:SetWarningLocalization({
	WarnAirphase			= "Fase aérea",
	WarnGroundphase			= "Fase terrestre",
	WarnShieldsLeft			= "Antigo Escudo Enânico usado - %d restantes",
	warnAddSoon				= "Diabrete Irritante convocado",
	specWarnAddTargetable	= "%s pode ser mirado"
})

L:SetTimerLocalization({
	TimerAirphase			= "Próxima fase aérea",
	TimerGroundphase		= "Próxima fase terrestre"
})

L:SetOptionLocalization({
	WarnAirphase			= "Exibir aviso quando Atramedes levanta voo",
	WarnGroundphase			= "Exibir aviso quando Atramedes pousa",
	WarnShieldsLeft			= "Exibir aviso quando um Antigo Escudo Enânico é usado",
	warnAddSoon				= "Exibir aviso quando Nefarian convoca diabretes",
	specWarnAddTargetable	= "Exibir aviso especial quando diabretes podem ser mirados",
	TimerAirphase			= "Exibir cronógrafo para a próxima fase aérea",
	TimerGroundphase		= "Exibir cronógrafo para a próxima fase terrestre",
	InfoFrame				= "Exibir quadro de informações para o níveis de som",
	TrackingIcon			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(78092)
})

L:SetMiscLocalization({
	AncientDwarvenShield	= "Antigo Escudo Enânico",
	Soundlevel				= "Nível de som",
	YellPestered			= "Diabrete Irritante em mim!",--npc 49740
	NefAdd					= "Atramedes, the heroes are right THERE!",
	Airphase				= "Yes, run! With every step your heart quickens. The beating, loud and thunderous... Almost deafening. You cannot escape!"
})

----------------
--  Nefarian  --
----------------
--L = DBM:GetModLocalization(174)
L = DBM:GetModLocalization("Nefarian")

L:SetGeneralLocalization({
	name = "O fim de Nefarian"	-- No conflict with BWL version (probably also why blizzard calls the encounter "Nefarian's End"
})

L:SetWarningLocalization({
	OnyTailSwipe			= "Açoite de Cauda (Onyxia)",
	NefTailSwipe			= "Açoite de Cauda (Nefarian)",
	OnyBreath				= "Sopro (Onyxia)",
	NefBreath				= "Sopro (Nefarian)",
	specWarnShadowblazeSoon	= "%s",
	warnShadowblazeSoon		= "%s"
})

L:SetTimerLocalization({
	timerNefLanding			= "Nefarian pousa",
	OnySwipeTimer			= "Recarga Açoite de Cauda (Ony)",
	NefSwipeTimer			= "Recarga Açoite de Cauda (Nef)",
	OnyBreathTimer			= "Recarga Sopro (Ony)",
	NefBreathTimer			= "Recarga Sopro (Nef)"
})

L:SetOptionLocalization({
	OnyTailSwipe			= "Exibir aviso para $spell:77827 de Onyxia",
	NefTailSwipe			= "Exibir aviso para $spell:77827 de Nefarian",
	OnyBreath				= "Exibir aviso para $spell:94124 de Onyxia",
	NefBreath				= "Exibir aviso para $spell:94124 de Nefarian",
	specWarnCinderMove		= "Exibir aviso especial para afastar-se quando você está sob efeito de\n $spell:79339 (5s antes da explosão)",
	warnShadowblazeSoon		= "Exibir aviso antecipado para $spell:81031 (5s antes)\n(Funciona apenas após o cronógrafo estar sincronizado, para garantir a precisão)",
	specWarnShadowblazeSoon	= "Exibir aviso antecipado para $spell:81031\n(Primeiro aviso 5s antes. Segundo aviso 1s antes, após sincronia, para garantir precisão)",
	timerNefLanding			= "Exibir cronógrafo para quando Nefarian pousa",
	OnySwipeTimer			= "Exibir cronógrafo para recarga de $spell:77827 (Onyxia)",
	NefSwipeTimer			= "Exibir cronógrafo para recarga de $spell:77827 (Nefarian)",
	OnyBreathTimer			= "Exibir cronógrafo para recarga de $spell:94124 (Onyxia)",
	NefBreathTimer			= "Exibir cronógrafo para recarga de $spell:94124 (Nefarian)",
	InfoFrame				= "Exibir quadro de informações da Energia Elétrica de Onyxia",
	SetWater				= "Automaticamente desabilitar colisão com a água, ao entrar em combate\n(habilita novamente, ao sair de combate)",
	TankArrow				= "Exibe seta do DBM para o kiter dos Guerreiros Animados de Osso\n(utilizado em stratégia de um kiter)",--npc 41918
	SetIconOnCinder			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(79339),
	RangeFrame				= "Exibir medidor de distância (10) para $spell:79339\n(Mostra todo mundo se você tiver o debuff, caso contrário, apenas jogadores com ícones)"
})

L:SetMiscLocalization({
	NefAoe					= "The air crackles with electricity!",
	YellPhase2				= "Curse you, mortals! Such a callous disregard for one's possessions must be met with extreme force!",
	YellPhase3				= "I have tried to be an accommodating host, but you simply will not die! Time to throw all pretense aside and just... KILL YOU ALL!",
	YellShadowBlaze			= "Flesh turns to ash!",
	Nefarian				= "Nefarian",
	Onyxia					= "Onyxia",
	Charge					= "Electric Charge",
	ShadowBlazeExact		= "Centelha de Labareda Sombria em %ds",
	ShadowBlazeEstimate		= "Centelha de Labareda Sombria em breve (~5s)"
})

-------------------------------
--  Blackwing Descent Trash  --
-------------------------------
L = DBM:GetModLocalization("BWDTrash")

L:SetGeneralLocalization({
	name = "Trash de Descenso do Asa Negra"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})
