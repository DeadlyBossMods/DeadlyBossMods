if GetLocale() ~= "ptBR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end

local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Cavejohnson @ Azralon"

L.OTabBosses	= "Chefes"
L.OTabOptions	= "Opções"

L.TabCategory_Options	 	= "Opções Gerais"
L.TabCategory_OTHER    		= "Outros módulos"

L.BossModLoaded 			= "%s estatísticas"
L.BossModLoad_now 			= [[Esse módulo não está carregado. 
Ele será carregado quando você entrar na instância. 
Você também pode clicar no botão para carregar manualmente.]]

L.PosX						= 'Posição X'
L.PosY						= 'Posição Y'

L.MoveMe 					= 'Mova-me'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Cancelar'
L.Button_LoadMod 			= 'Carregar AddOn'
L.Mod_Enabled				= "Habilitar módulo"
L.Mod_Reset					= "Carregar opções padrão"
L.Reset 					= "Redefinir"

L.Enable  					= "Habilitar"
L.Disable					= "Desabilitar"

L.NoSound					= "Sem som"

L.IconsInUse				= "Ícones utilizados por esse módulo"

-- Tab: Boss Statistics
L.BossStatistics			= "Estatísticas do Chefe"
L.Statistic_Kills			= "Vitórias:"
L.Statistic_Wipes			= "Derrotas:"
L.Statistic_Incompletes		= "Incompletos:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Melhor vítória:"

-- Tab: General Core Options
L.General 					= "Opções gerais do DBM"
L.EnableDBM 				= "Habilitar DBM"
L.EnableMiniMapIcon			= "Exibir botão no mini-mapa"
L.UseMasterVolume			= "Utilizar canal principal de áudio para reproduzir arquivos de som."
L.Latency_Text				= "Definir latência máxima de sincronização: %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "Opções gerais do temporizador do DBM"
L.SKT_Enabled				= "Sempre mostrar um temporizador de sua vitória recorde (Sobrepõe a opção do chefe específico)"
L.CRT_Enabled				= "Mostrar um temporizador para a próxima carga de ressureição em combate(apenas nas dificuldades 6.x)"
L.ChallengeTimerOptions		= "Colocar opção para temporizador de melhor tempo em modo desafio"
L.ChallengeTimerPersonal	= "Pessoal"
L.ChallengeTimerRealm		= "Reino"

L.ModelOptions				= "Opções do Visualizador de Modelos 3D"
L.EnableModels				= "Habilitar modelos 3D nas opções de chefe"
L.ModelSoundOptions			= "Definir opção de som para o visualizador de modelos"
L.ModelSoundShort			= "Curto"
L.ModelSoundLong			= "Longo"

L.Button_RangeFrame			= "Exibir/esconder quadro de distância"
L.Button_RangeRadar			= "Exibir/esconder radar de distância"
L.Button_InfoFrame			= "Exibir/esconder quadro de informações"
L.Button_TestBars			= "Iniciar barras de teste"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Avisos na Raide"
L.RaidWarning_Header		= "Opções de Avisos na Raide"
L.RaidWarnColors 			= "Cores dos Avisos na Raide"
L.RaidWarnColor_1 			= "Cor 1"
L.RaidWarnColor_2 			= "Cor 2"
L.RaidWarnColor_3		 	= "Cor 3"
L.RaidWarnColor_4 			= "Cor 4"
L.InfoRaidWarning			= [[Você pode especificar a cor e posição do quadro de avisos de raide.
Esse quadro é utilizado para mensagens como "Jogador X está sob efeito de Y".]]
L.ColorResetted 			= "As opções de cor desse campo foram redefinidas."
L.ShowWarningsInChat 		= "Exibir avisos na janela de chat."
L.ShowFakedRaidWarnings 	= "Exibir avisos como mensagens de aviso de raid."
L.WarningIconLeft 			= "Mostrar ícone do lado esquerdo."
L.WarningIconRight 			= "Mostrar ícone do lado direito."
L.WarningIconChat 			= "Mostrar ícones no chat"
L.ShowCountdownText			= "Mostrar texto de contagem regressiva"
L.RaidWarnMessage 			= "Obrigado por utilizar o Deadly Boss Mods"
L.BarWhileMove 				= "Aviso de Raide móvel"
L.RaidWarnSound				= "Tocar som junto com o aviso na raid"
L.CountdownVoice			= "Definir voz para contagem regressiva."
L.CountdownVoice2			= "Escolher voz secundária para contagem regressiva"
L.SpecialWarnSound			= "Definir som para avisos especiais que afetam você ou sua função específica."
L.SpecialWarnSound2			= "Definir som para avisos especiais que afetam todo mundo"
L.SpecialWarnSound3			= "Escolher som para avisos especiais MUITO importantes"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Mensagens em geral"
L.CoreMessages				= "Opções de mensagens principais"
L.ShowLoadMessage 			= "Exibir mensagens ao carregar módulos no quadro de chat"
L.ShowPizzaMessage 			= "Exibir mensagens ao receber cronógrafos no quadro de chat"
L.ShowCombatLogMessage 		= "Exibir mensagens de relatório de combate do DBM no chat"
L.ShowTranscriptorMessage	= "Exibir mensagens de relatório do transcritor do DBM no chat"
L.CombatMessages			= "Opções de mensagens de combate"
L.ShowEngageMessage 		= "Exibir mensagens ao iniciar combate no quadro de chat"
L.ShowKillMessage 			= "Exibir mensagens ao derrotar chefes no quadro de chat"
L.ShowWipeMessage 			= "Exibir mensanges ao ser derrotado no quadro de chat"
L.ShowRecoveryMessage 		= "Exibir mensagens ao ajustar cronógrafos no quadro de chat"
L.WhisperMessages			= "Opções de mensagens de sussuro"
L.AutoRespond 				= "Responder automaticamente a sussuros durante a luta"
L.EnableStatus 				= "Responder a sussurros de 'status'"
L.WhisperStats 				= "Incluir estatísticas de derrotas/vitórias nas respostas a sussurros"

-- Tab: Barsetup
L.BarSetup   				= "Configurações da barra"
L.BarTexture 				= "Textura da barra"
L.BarStyle				= "Estilo da barra"
L.BarDBM				= "DBM"
L.BarBigWigs				= "BigWigs (sem animação)"
L.BarStartColor				= "Cor inicial"
L.BarEndColor 				= "Cor final"
L.Bar_Font				= "Fonte utilizada na barra"
L.Bar_FontSize				= "Tamanho da fonte"
L.Bar_Height				= "Altura da barra: %d"
L.Slider_BarOffSetX 			= "Deslocamento X: %d"
L.Slider_BarOffSetY 			= "Deslocamento Y: %d"
L.Slider_BarWidth 			= "Largura da barra: %d"
L.Slider_BarScale 			= "Escala da barra: %0.2f"
L.AreaTitle_BarSetup			= "Opções gerais de barra"
L.AreaTitle_BarSetupSmall 		= "Opções da barra pequena"
L.AreaTitle_BarSetupHuge		= "Opções da barra grande"
L.EnableHugeBar 			= "Habilitar barra grande (aka Barra 2)"
L.BarIconLeft 				= "Ícone da esq."
L.BarIconRight 				= "Ícone da dir."
L.ExpandUpwards				= "Expandir para cima"
L.FillUpBars				= "Barras enchem"
L.ClickThrough				= "Desabilitar eventos de mouse (permite clicar através das barras)"
L.Bar_DBMOnly				= "As opções abaixo só funcionam com o estilo de barra \"DBM\" ."
L.Bar_EnlargeTime			= "Barras aumentam abaixo deste tempo: %d"
L.Bar_EnlargePercent			= "Barras aumentam abaixo desta porcentagem: %0.1f%%"
L.BarSpark				= "Barra faísca"
L.BarFlash				= "Barra pisca quando estiver para expirar"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame			= "Avisos Especiais"
L.Area_SpecWarn				= "Opções de Avisos Especiais"
L.SpecWarn_Enabled			= "Mostrar avisos especiais para habilidades de chefe"
L.SpecWarn_FlashFrame			= "Brilhar tela em avisos especiais"
L.SpecWarn_AdSound			= "Habilita opções avançadas de som para avisos especiais (requer reinicialização da interface)"
L.SpecWarn_Font				= "Fonte utilizada para avisos especiais"
L.SpecWarn_FontSize			= "Tamanho da fonte"
L.SpecWarn_FontColor			= "Cor da fonte"
L.SpecWarn_FontType			= "Selecionar fonte"
L.SpecWarn_FlashColor			= "Cor pisca"
L.SpecWarn_FlashDur			= "Duração da piscada: %0.1f"
L.SpecWarn_FlashAlpha			= "Alfa da piscada: %0.1f"
L.SpecWarn_DemoButton			= "Mostrar exemplo"
L.SpecWarn_MoveMe			= "Definir posição"
L.SpecWarn_ResetMe			= "Redefinir padrões"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Quadro de Vida"
L.Area_HPFrame				= "Opções do Quadro de Vida"
L.HP_Enabled				= "Sempre exibir quadro de vida (Sobrepõe opção específica por chefe)"
L.HP_GrowUpwards			= "Expandir quadro de vida para cima"
L.HP_ShowDemo				= "Exibir quadro de vida"
L.BarWidth				= "Largura da barra: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter			= "Filtros Global e de Spam"
L.Area_SpamFilter			= "Opções do filtro Global"
L.StripServerName			= "Tira com nome do reino em avisos e temporizadores"
L.SpamBlockBossWhispers			= "Filtra &lt;DBM&gt; avisos de sussurro enquanto estiver lutando"
L.BlockVersionUpdateNotice		= "Desabilitar popup de notificação de atualização (Não recomendado)"
L.ShowBBOnCombatStart			= "Fazer checagem de Buff com Big Brother no início do combate"
L.BigBrotherAnnounceToRaid		= "Anunciar resultados do Big Brother para a raide"

L.Area_SpamFilter_Outgoing		= "Opções de Filtro Global"
L.SpamBlockNoShowAnnounce		= "Não exibir anúncios ou tocar sons de aviso"
L.DontShowFarWarnings			= "Não exibir anúncios/temporizadores para eventos que estão longe"
L.SpamBlockNoSendWhisper		= "Não enviar sussurros para outros jogadores"
L.SpamBlockNoSetIcon			= "Não colocar ícones nos alvos."
L.SpamBlockNoRangeFrame			= "Não exibir quadro de distância"
L.SpamBlockNoInfoFrame			= "Não exibir quadro de informação"
L.SpamBlockNoHealthFrame		= "Não exibir quadro de vida"

L.Area_PullTimer			= "Opções de Filtros de Pull, Combate, & Temporizador customizados"
L.DontShowPTNoID			= "Bloquear o temporizador de Pull se não foi enviado na mesma zona que você"
L.DontShowPT				= "Não exibir a barra de pull"
L.DontShowPTText			= "Não exibir texto de anúncio do temporizador de pull"
L.DontPlayPTCountdown			= "Não tocar o audio da contagem regressiva de pull/combate/customizado"
L.DontShowPTCountdownText		= "Não exibir o texto da contagem regressiva de pull/combate/customizado"
L.PT_Threshold				= "Não exibir o texto da contagem regressiva de pull/combate/customizado acima de: %d"

L.Panel_HideBlizzard			= "Esconder Blizzard"
L.Area_HideBlizzard			= "Esconder Opções da Blizzard"
L.HideBossEmoteFrame			= "Esconder o quadro de emote do chefe de raide durante as lutas"
L.HideWatchFrame			= "Esconder/acompanhar quadros (de objetivos) durante as lutas contra os chefes"
L.HideTooltips				= "Esconder as dicas durante as lutas contra os chefes"
L.SpamBlockSayYell			= "Esconder os anúncios de balões de chat do quadro de chat"
L.DisableCinematics			= "Esconder as cinematics in-game"
L.AfterFirst				= "Depois que o vídeo for assistido uma vez"

L.Panel_ExtraFeatures			= "Características Extra"
L.Area_ChatAlerts			= "Opções de alerta do Chat"
L.RoleSpecAlert				= "Exibir mensagem de alerta quando sua especialização de saque não corresponder à sua especialização atual ao entrar na raide"
L.WorldBossAlert			= "Exibir mensagem de alerta quando um chefe do mundo possivelmente for atacado no seu reino por membros da sua guilda ou amigos (inaccurate if sender is CRZed)"
L.Area_SoundAlerts			= "Opções de Som de Alerta"
L.LFDEnhance				= "Tocar o som de TodosProntos para checagem de papéis &amp; CB/LDG no canal de audio principal(I.E. sons funcionam mesmo que os efeitos sonoros estejam desligados e são geralmente mais altos)"
L.WorldBossNearAlert		= "Tocar o som de TodosProntos quando chefes do mundo perto de você que vocÊ precisa estiverem sendo atacados (Sobrepõe opção específica de chefe)"
L.AFKHealthWarning			= "Tocar som de alerta quando você estiver perdendo vida enquanto estiver LDT"
L.Area_AutoLogging			= "opções de relatórios automáticos"
L.AutologBosses				= "Gravar automaticamente o relatório de encontro com os chefes utilizando o relatório de combate da Blizzard(Requer que seja usado /dbm pull antes do chefe <a href=\"http://www.warcraftlogs.com\">|cff3588ffwarcraftlogs.com|r</a> compatibilidade)"
L.AdvancedAutologBosses		= "Gravar automaticamente o encontro com o chefe utilizando o Transcritor"
L.LogOnlyRaidBosses			= "Só gravar encontros com chefes de raide (exclui Localizador de Raides/Grupos/Cenarios)"
L.Area_Invite				= "Opções de convite"
L.AutoAcceptFriendInvite	= "Aceitar convites de amigos automaticamente"
L.AutoAcceptGuildInvite		= "Aceitar convites de membros da guilda automaticamente"


L.PizzaTimer_Headline 		= 'Criar um "Cronógrafo para Pizza"'
L.PizzaTimer_Title			= 'Nome (e.g. "Pizza!")'
L.PizzaTimer_Hours 			= "Horas"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Seg"
L.PizzaTimer_ButtonStart 	= "Iniciar cronógrafo"
L.PizzaTimer_BroadCast		= "Espalhar para raide"


-- Misc
L.FontHeight	= 16
