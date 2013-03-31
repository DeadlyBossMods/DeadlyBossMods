if GetLocale() ~= "ptBR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end

local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Cavejohnson @ Azralon"

L.OTabBosses	= "Chefes"
L.OTabOptions	= "Opções"

L.TabCategory_Options	 	= "Opções Gerais"
L.TabCategory_CATA	 		= "Cataclysm"
L.TabCategory_WOTLK 		= "Wrath of the Lich King"
L.TabCategory_BC 			= "The Burning Crusade"
L.TabCategory_CLASSIC		= "WoW Classic"
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
L.Reset 					= "Redefinir"

L.Enable  					= "Habilitar"
L.Disable					= "Desabilitar"

L.NoSound					= "Sem som"

L.IconsInUse				= "Ícones utilizados por esse módulo"

-- Tab: Boss Statistics
L.BossStatistics			= "Estatísticas do Chefe"
L.Statistic_Kills			= "Vitórias:"
L.Statistic_Wipes			= "Derrotas:"
L.Statistic_BestKill		= "Melhor vítória:"
L.Statistic_10Man			= "Raide 10 jogadores"
L.Statistic_25Man			= "Raide 25 jogadores"

-- Tab: General Options
L.General 					= "Opções gerais do DBM"
L.EnableDBM 				= "Habilitar DBM"
L.EnableMiniMapIcon			= "Exibir botão no mini-mapa"
L.UseMasterVolume			= "Utilizar canal principal de áudio para reproduzir arquivos de som."
L.DisableCinematics			= "Desabilitar todas as cinemáticas no jogo."
L.SKT_Enabled				= "Sempre mostrar cronógrafo de vitória récorde (Sobrepõe opção específica por chefe)"
L.Latency_Text				= "Definir latência máxima de sincronização: %d"

L.ModelOptions				= "Opções do Visualizador de Modelos 3D"
L.EnableModels				= "Habilitar modelos 3D nas opções de chefe"
L.ModelSoundOptions			= "Definir opção de som para o visualizador de modelos"
L.ModelSoundShort			= "Curto"
L.ModelSoundLong			= "Longo"

L.Button_RangeFrame			= "Exibir/esconder quadro de distância"
L.Button_RangeRadar			= "Exibir/esconder radar de distância"
L.Button_InfoFrame			= "Exibir/esconder quadro de informações"
L.Button_TestBars			= "Iniciar barras de teste"

L.PizzaTimer_Headline 		= 'Criar um "Cronógrafo para Pizza"'
L.PizzaTimer_Title			= 'Nome (e.g. "Pizza!")'
L.PizzaTimer_Hours 			= "Horas"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Seg"
L.PizzaTimer_ButtonStart 	= "Iniciar cronógrafo"
L.PizzaTimer_BroadCast		= "Espalhar para raide"

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
L.RaidWarnMessage 			= "Obrigado por utilizar o Deadly Boss Mods"
L.BarWhileMove 				= "Aviso de Raide móvel"
L.RaidWarnSound				= "Tocar som junto com o aviso na raid"
L.CountdownVoice			= "Definir voz para contagem regressiva."
L.SpecialWarnSound			= "Definir som para avisos especiais que afetam você ou sua função específica."
L.SpecialWarnSound2			= "Definir som para avisos especiais que afetam todo mundo"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Mensagens em geral"
L.CoreMessages				= "Opções de mensagens principais"
L.ShowLoadMessage 			= "Exibir mensagens ao carregar módulos no quadro de chat"
L.ShowPizzaMessage 			= "Exibir mensagens ao receber cronógrafos no quadro de chat"
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
L.BarSetup   				= "Estilo da barra"
L.BarTexture 				= "Textura da barra"
L.BarStartColor				= "Cor inicial"
L.BarEndColor 				= "Cor final"
L.ExpandUpwards				= "Expandir barras para cima"
L.Bar_Font					= "Fonte utilizada na barra"
L.Bar_FontSize				= "Tamanho da fonte"
L.Slider_BarOffSetX 		= "Deslocamento X: %d"
L.Slider_BarOffSetY 		= "Deslocamento Y: %d"
L.Slider_BarWidth 			= "Largura da barra: %d"
L.Slider_BarScale 			= "Escala da barra: %0.2f"
L.AreaTitle_BarSetup		= "Opções gerais de barra"
L.AreaTitle_BarSetupSmall 	= "Opções da barra pequena"
L.AreaTitle_BarSetupHuge	= "Opções da barra grande"
L.BarIconLeft 				= "Ícone da esq."
L.BarIconRight 				= "Ícone da dir."
L.EnableHugeBar 			= "Habilitar barra grande"
L.FillUpBars				= "Barras enchem"
L.ClickThrough				= "Desabilitar eventos de mouse (permite clicar através das barras)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Avisos Especiais"
L.Area_SpecWarn				= "Opções de Avisos Especiais"
L.SpecWarn_Enabled			= "Mostrar avisos especiais para habilidades de chefe"
L.SpecWarn_LHFrame			= "Brilhar tela em avisos especiais"
L.SpecWarn_Font				= "Fonte utilizada para avisos especiais"
L.SpecWarn_DemoButton		= "Mostrar exemplo"
L.SpecWarn_MoveMe			= "Definir posição"
L.SpecWarn_FontSize			= "Tamanho da fonte"
L.SpecWarn_FontColor		= "Cor da fonte"
L.SpecWarn_FontType			= "Selecionar fonte"
L.SpecWarn_ResetMe			= "Redefinir padrões"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Quadro de Vida"
L.Area_HPFrame				= "Opções do Quadro de Vida"
L.HP_Enabled				= "Sempre exibir quadro de vida (Sobrepõe opção específica por chefe)"
L.HP_GrowUpwards			= "Expandir quadro de vida para cima"
L.HP_ShowDemo				= "Exibir quadro de vida"
L.BarWidth					= "Largura da barra: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Filtros Global e de Spam"
L.Area_SpamFilter				= "Opções do filtro Global"
L.HideBossEmoteFrame			= "Esconder quadro de emoção de chefe de raid" -- not so sure about that translation
L.SpamBlockBossWhispers			= "Filtrar sussuros de aviso <DBM> durante a luta."
L.BlockVersionUpdateNotice		= "Desabilitar pop-up de notificação de atualização."
L.ShowBigBrotherOnCombatStart	= "Realizar checagem de bônus no início do combate."
L.BigBrotherAnnounceToRaid		= "Anunciar resultados da checagem para a raide"

L.Area_SpamFilter_Outgoing		= "Opções de Filtro Global"
L.SpamBlockNoShowAnnounce		= "Não mostrar anúncios ou tocar sons de aviso"
L.SpamBlockNoSendWhisper		= "Não enviar sussurros para outros jogadores"
L.SpamBlockNoSetIcon			= "Não colocar ícones nos alvos."


-- Misc
L.FontHeight	= 16
