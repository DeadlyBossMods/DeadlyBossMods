if GetLocale() ~= "ptBR" then return end

if not DBM_GUI_L then DBM_GUI_L = {} end

local L = DBM_GUI_L

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Traduzido por "
L.TranslationBy 			= "GlitterStorm @ Azralon" -- your name here, localizers!
L.Website					= "Visite-nos no discord em |cFF73C2FBhttps://discord.gg/deadlybossmods|r. Siga na maioria das redes sociais @deadlybossmods ou @mysticalos"
L.WebsiteButton				= "Site"

L.OTabBosses				= "Chefes"
L.OTabRaids					= "Raides"--Just pve raids
L.OTabDungeons				= "Masmorras"--Just dungeons
L.OTabWorld					= "Chefes mundiais"--Since there are so many world mods, enough to get their own tab
L.OTabScenarios				= "Cenários"--Future use, will be used for scenarios and delves, likely after there are more than 2 mods (so probably 12.x or later)
L.OTabPlugins				= "Outro"--Scenarios, PVP, Delves (11.x), Solo/Challenge content (torghast, mage tower, etc)
L.OTabOptions				= "Opções"
L.OTabAbout					= "Sobre"

L.FOLLOWER					= "Seguidor"--i.e. the new dungeon type in 10.2.5. I haven't found a translated string yet

L.TabCategory_CURRENT_SEASON	= "Temporada atual"

L.TabCategory_OTHER			= "Outros módulos"
L.TabCategory_AFFIXES		= "Afixos"

L.BossModLoaded 			= "%s estatísticas"
L.BossModLoad_now 			= [[Esse módulo não está carregado.
Ele será carregado quando você entrar na instância.
Você também pode clicar no botão para carregar o módulo manualmente.]]

L.PosX						= "Posição X"
L.PosY						= "Posição Y"

L.MoveMe 					= "Mova-me"
L.Button_OK 				= "OK"
L.Button_Cancel 			= "Cancelar"
L.Button_LoadMod 			= "Carregar AddOn"
L.Mod_Enabled				= "Ativar: %s"
L.Mod_Reset					= "Carregar opções padrão"
L.Reset 					= "Redefinir"
L.Import					= "Importar"

--L.Enable					= ENABLE
--L.Disable					= DISABLE

L.NoSound					= "Sem som"

L.IconsInUse				= "Ícones utilizados por esse módulo"

-- Tab: Boss Statistics
L.BossStatistics			= "Estatísticas do chefe"
L.Statistic_Kills			= "Vitórias:"
L.Statistic_Wipes			= "Derrotas:"
L.Statistic_Incompletes		= "Incompletos:"--Para cenários, TODO, encontrar um jeito limpo de substituir derrotas por estatística incompleto para mods de cenário
L.Statistic_BestKill		= "Melhor tempo:"

-- Tab: General Options
L.TabCategory_Options		= "Opções gerais"
L.Area_BasicSetup			= "Dicas iniciais de configuração de DBM"
L.Area_ModulesForYou		= "Quais módulos DBM são adequados para você?"
L.Area_ProfilesSetup		= "Guia de uso de perfis DBM"
-- Panel: Core & GUI
L.Core_GUI 					= "Core e GUI"
L.General 					= "Opções gerais de DBM"
L.EnableMiniMapIcon			= "Exibir botão no minimapa"
L.EnableCompartmentIcon		= "Exibir botão do compartimento"
L.UseSoundChannel			= "Definir o canal de áudio usado pelo DBM para reproduzir sons de alerta"
L.UseMasterChannel 			= "Canal de áudio principal"
L.UseDialogChannel			= "Canal de áudio de diálogo"
L.UseSFXChannel				= "Canal de áudio de efeitos sonoros (SFX)"
L.Latency_Text				= "Latência máx. de sincronização: %d"

L.Button_RangeFrame			= "Exibir/ocultar quadro de distância"
L.Button_InfoFrame			= "Exibir/ocultar quadro de informações"
L.Button_TestBars			= "Iniciar barras de teste"
L.Button_MoveBars			= "Mover barras"
L.Button_ResetInfoRange		= "Redefinir quadros de informações/distância"

L.ModelOptions				= "Opções do visualizador de modelos 3D"
L.EnableModels				= "Ativar modelos 3D nas opções de chefe"
L.ModelSoundOptions			= "Definir opção de som para o visualizador de modelos"
L.ModelSoundShort			= "Curto"
L.ModelSoundLong			= "Longo"

L.ResizeOptions				= "Opções de redimensionamento"
L.ResizeInfo				= "Você pode redimensionar a GUI clicando no canto inferior direito e arrastando."
L.Button_ResetWindowSize	= "Redefinir o tamanho da janela da GUI"
L.Editbox_WindowWidth		= "Largura da janela GUI"
L.Editbox_WindowHeight		= "Altura da janela GUI"

L.UIGroupingOptions					= "Opções de agrupamento de IU (alterá-las requer recarregamento da IU)"
L.GroupOptionsExcludeIcon			= "Excluir as opções de 'Ativar ícone' de serem agrupadas por feitiço (elas serão agrupadas na categoria categoria de 'Ícones')"
L.GroupOptionsExcludePrivateAura 	= "Excluir as opções de som 'Aura privada' de serem agrupadas por feitiço (elas serão agrupadas na categoria de 'Auras privadas')"
L.AutoExpandSpellGroups				= "Expandir automaticamente as opções agrupadas por feitiço"
L.ShowWAKeys						= "Exibir as teclas WeakAuras ao lado dos nomes dos feitiços para ajudar a escrever WeakAuras usando os gatilhos do módulo de chefe"
--L.ShowSpellDescWhenExpanded		= "Continuar mostrando a descrição do feitiço quando os grupos forem expandidos"--Might not be used
L.NoDescription						= "Esta habilidade não tem descrição"
L.CustomOptions						= "Esta categoria contém opções personalizadas para uma habilidade ou evento que não possui ID de feitiço ou diário próprio. Essas opções foram agrupadas usando um ID manual personalizado para facilitar a criação de WeakAuras"

-- Panel: Auto Logging
L.Panel_AutoLogging 				= "Registro automático"

--Auto Logging: Logging toggles/types
L.Area_AutoLogging					= "Alternâncias de registro automático"
L.AutologBosses 					= "Registrar automaticamente o conteúdo selecionado usando o registro de combate de Blizzard"
L.AdvancedAutologBosses 			= "Registrar automaticamente o conteúdo selecionado com o Transcriptor"
--Auto Logging: Global filter Options
L.Area_AutoLoggingFilters 			= "Filtros de registro automático"
L.RecordOnlyBosses 					= "Registrar apenas encontros contra chefes"
L.DoNotLogLFG 						= "Não registrar encontros de procurando grupo"
--Auto Logging: Recorded Content types
L.Area_AutoLoggingContent 			= "Conteúdo de registro automático"
L.LogCurrentMythicRaids 			= "Raides atuais de nível Mítico (ou remix)" -- Retail Only
L.LogCurrentRaids 					= "Raides não mítica atuais (heróicos e normal se o filtro Procurando grupo estiver desativado)"
L.LogTWRaids 						= "Raides de Caminhada Temporal ou Tempo de Crona (não inclui remix)" -- Retail Only
L.LogTrivialRaids 					= "Raides triviais (abaixo do nível do personagem)"
L.LogCurrentMPlus 					= "Masmorras M+ atuais de nível (ou remix)" -- Retail Only
L.LogCurrentMythicZero 				= "Masmorras Míticas 0 atuais de nível (ou remix)" -- Retail Only
L.LogTWDungeons 					= "Masmorras de Caminhada Temporal ou Tempo de Crona (não inclui remix)" -- Retail Only
L.LogCurrentHeroic 					= "Masmorras heroicas atuais de nível (Nota: se você estiver fazendo heroico via fila e quiser que seja registrado, desative o filtro Procurando grupo)"

-- Tab: General Timer Options
L.TimerGeneral 				= "Opções de temporizador"
L.SKT_Enabled				= "Sempre exibir um temporizador de sua vitória recorde (sobrepõe a opção do chefe específico)"
L.ShowRespawn 				= "Exibir o temporizador de reaparência do chefe após uma derrota"
L.ShowQueuePop 				= "Exibir o tempo restante para aceitar um pop de fila (Procurando grupo, CB, etc)"
L.ShowBerserkWarnings 		= "Exibir anúncios a 10/5/3/1 minutos e a 30/10 segundos restantes no temporizador de $spell:26662"

-- Tab: Alerts
L.TabCategory_Alerts 		= "Alertas"
L.Area_SpecAnnounceConfig 	= "Guia de visuais e sons de anúncios especiais"
L.Area_SpecAnnounceNotes 	= "Guia de notas de anúncios especiais"
L.Area_VoicePackInfo 		= "Informações sobre pacotes de voz de DBM"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Anúncios de raide"
L.RaidWarning_Header		= "Opções de anúncios de raide"
L.RaidWarnColors 			= "Cores dos anúncios de raide"
L.RaidWarnColor_1 			= "Cor 1"
L.RaidWarnColor_2 			= "Cor 2"
L.RaidWarnColor_3		 	= "Cor 3"
L.RaidWarnColor_4 			= "Cor 4"
L.InfoRaidWarning			= [[Você pode especificar a cor e posição do quadro de anúncios de raide.
Esse quadro é utilizado para mensagens como "Jogador X está sob efeito de Y".]]
L.ColorResetted 			= "As opções de cor desse campo foram resetadas."
L.ShowWarningsInChat 		= "Exibir anúncios na janela de bate-papo"
L.WarningIconLeft 			= "Exibir ícone no lado esquerdo"
L.WarningIconRight 			= "Exibir ícone no lado direito"
L.WarningIconChat 			= "Exibir ícone no bate-papo"
L.WarningAlphabetical 		= "Ordenar nomes alfabeticamente"
L.Warn_Duration				= "Duração do anúncio: %0.1f seg"
L.None						= "Nenhum"
L.Outline					= "Contorno"
L.ThickOutline				= "Espessura do contorno"
L.MonochromeOutline			= "Contorno monocromático"
L.MonochromeThickOutline	= "Espessura do contorno monocromático"
L.RaidWarnSound				= "Reproduzir som no anúncio de raide"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame 		= "Anúncios especiais"
L.Area_SpecWarn 			= "Opções de anúncios especiais"
L.SpecWarn_ClassColor 		= "Usar coloração de classe para anúncios especiais"
L.ShowSWarningsInChat 		= "Exibir anúncios especiais no quadro de bate-papo"
L.SWarnNameInNote 			= "Usar opções Tipo 5 se uma nota de anúncio especial contiver seu nome"
L.SpecialWarningIcon 		= "Exibir ícones nos anúncios especiais"
L.ShortTextSpellname 		= "Usar texto mais curto para nome de feitiço (quando disponível)"
L.SpecWarn_FlashFrameRepeat = "Piscar %d vez(es)"
L.SpecWarn_Flash 			= "Piscar a tela"
L.SpecWarn_Vibrate 			= "Vibrar controle"
L.SpecWarn_FlashRepeat 		= "Repetir piscada"
L.SpecWarn_FlashColor 		= "Cor da piscada %d"
L.SpecWarn_FlashDur 		= "Duração da piscada: %0.1f"
L.SpecWarn_FlashAlpha 		= "Transparência da piscada: %0.1f"
L.SpecWarn_DemoButton 		= "Exibir exemplo"
L.SpecWarn_ResetMe 			= "Redefinir padrões"
L.SpecialWarnSoundOption 	= "Definir som padrão"
L.SpecialWarnHeader1 		= "Tipo 1: Definir opções para anúncios de prioridade normal que afetam você ou suas ações"
L.SpecialWarnHeader2 		= "Tipo 2: Definir opções para anúncios de prioridade normal que afetam todos"
L.SpecialWarnHeader3 		= "Tipo 3: Definir opções para anúncios de PRIORIDADE ALTA"
L.SpecialWarnHeader4 		= "Tipo 4: Definir opções para anúncios especiais de alta prioridade de correr para longe"
L.SpecialWarnHeader5 		= "Tipo 5: Definir opções para anúncios com notas contendo seu nome de jogador"

-- Special Announce Dropdowns
L.SAOne     				= "Som global 1 (pessoal)"
L.SATwo     				= "Som global 2 (todos)"
L.SAThree   				= "Som global 3 (ação de alta prioridade)"
L.SAFour    				= "Som global 4 (fuga de alta prioridade)"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 			= "Mensagens de bate-papo"
L.SelectChatFrameArea 			= "Opções de bate-papo"
L.SelectChatFrameButton 		= "Selecionar quadro de bate-papo"
L.SelectChatFrameInfoIdle 		= "As mensagens são exibidas em %s."
L.SelectChatFrameDefaultName 	= "o quadro de bate-papo padrão"
L.SelectChatFrameInfoDone 		= "As mensagens serão exibidas neste quadro de bate-papo."
L.SelectChatFrameInfoSelect 	= "Clique em um quadro de bate-papo para selecioná-lo."
L.CoreMessages					= "Opções de mensagens principais"
L.ShowPizzaMessage 				= "Exibir mensagens ao receber cronômetros no quadro de bate-papo"
L.ShowAllVersions	 			= "Exibir a versão da mod para todos os membros no bate-papo"
L.CombatMessages				= "Opções de mensagens de combate"
L.ShowEngageMessage 			= "Exibir mensagens ao iniciar combate no quadro de bate-papo"
L.ShowDefeatMessage 			= "Exibir mensagens ao vencer chefes no quadro de bate-papo"
L.ShowGuildMessages 			= "Exibir mensagens de puxada/vitória/derrota no quadro de bate-papo"
L.Area_WhisperMessages			= "Opções de mensagens de sussurro"
L.AutoRespond 					= "Responder automaticamente a sussurros durante a luta"
L.WhisperStats 					= "Incluir estatísticas de derrotas/vitórias nas respostas a sussurros"
L.ShowReminders 				= "Exibir lembretes de módulos que estão faltando, desativados, que sofreram alterações, desatualizados ou silenciados"

-- Panel: Bar Appearance
L.Panel_Appearance 			= "Aparência da barra"
L.Panel_Behavior 			= "Comportamento da barra"
L.AreaTitle_BarSetup 		= "Opções da barra"
L.AreaTitle_Behavior		= "Opções do comportamento da barra"
-- Panel: Color by Type
L.TabCategory_Timers		= "Temporizadores da barra"
L.Area_ColorBytype			= "Guia para colorir barras por tipo"
-- Panel: Color by Type
L.Panel_ColorByType 		= "Cores da barra"
L.AreaTitle_BarColors		= "Cores da barra normal (os padrões são atribuídos pelo tipo de habilidade)"
L.AreaTitle_ImpBarColors 	= "Cores da barra importante (estas são as barras definidas como importantes pelo usuário)"
L.BarTexture 				= "Textura da barra"
L.BarStyle					= "Estilo da barra"
L.BarDBM					= "DBM"
L.BarSimple					= "Simple (sem animação)"
L.BarStartColor				= "Cor inicial"
L.BarEndColor 				= "Cor final"
L.Bar_Height				= "Altura da barra: %d"
L.Slider_BarOffSetX 		= "Deslocamento X: %d"
L.Slider_BarOffSetY 		= "Deslocamento Y: %d"
L.Slider_BarWidth 			= "Largura da barra: %d"
L.Slider_BarScale 			= "Escala da barra: %0.2f"
L.BarSaturation				= "Saturação da barra para temporizadores pequenos: %0.2f"
L.AreaTitle_BarSetupSmall 	= "Opções da barra pequena"
L.AreaTitle_BarSetupHuge	= "Opções da barra grande"
L.AreaTitle_BarSetupVariance = "Opções da barra de variação"
L.EnableHugeBar 			= "Ativar barra grande"
L.EnableVarianceBar 		= "Ativar barras de variação"
L.VarianceTransparency		= "Transparência das barras: %0.1f"
L.ZeroatWindowEnds 			= "O texto atinge zero no final da janela de recarga"
L.ZeroatWindowStartPause 	= "O texto atinge zero no início da janela de recarga e pausa"
L.ZeroatWindowStartRestart 	= "O texto atinge zero no início da janela de recarga e depois reinicia"
L.ZeroatWindowStartNeg 		= "O texto atinge zero no início da janela de recarga e depois fica negativo"
L.BarIconLeft 				= "Ícone da esq."
L.BarIconRight 				= "Ícone da dir."
L.ExpandUpwards				= "Expandir para cima"
L.FillUpBars				= "Barras enchem"
L.ClickThrough				= "Desativar eventos de mouse (permite clicar através das barras)"
L.Bar_Decimal				= "Decimal exibe abaixo do tempo: %d"
L.Bar_Alpha					= "Transparência: %0.1f"
L.Bar_EnlargeTime			= "Barra aumenta abaixo do tempo: %d"
L.BarSpark					= "Barra faísca"
L.BarFlash					= "Barra pisca quando estiver para expirar"
L.BarSort					= "Selecionar pelo tempo restante"
L.BarColorByType 			= "Colorir por tipo"
L.Highest 					= "Maior no topo"
L.Lowest 					= "Menor no topo"
L.NoBarFade 				= "Usar cores inicial/final como cores pequena/grande em vez de mudança gradual de cor"
L.BarInlineIcons 			= "Exibir ícones inline"
L.DisableRightClickBar		= "Desativar clique direito para cancelar temporizadores"
L.ShortTimerText 			= "Usar texto curto de temporizador (quando disponível)"
L.KeepBar 					= "Manter temporizador ativo até o lançamento da habilidade"
L.KeepBar2 					= "(quando suportado pelo mod)"
L.FadeBar 					= "Desaparecer temporizadores para habilidades fora do alcance"
L.BarSkin 					= "Estilo da barra"

-- Panel: Pull, Break, Combat
L.Panel_PullBreakCombat 	= "Puxada e pausa"

L.Area_SoundOptions 		= "Opções de som"

--Types
L.BarStartColorAdd 			= "Cor inicial 1 (Add)"
L.BarEndColorAdd 			= "Cor final 1 (Add)"
L.BarStartColorAOE 			= "Cor inicial 2 (AOE)"
L.BarEndColorAOE 			= "Cor final 2 (AOE)"
L.BarStartColorDebuff 		= "Cor inicial 3 (Alvo)"
L.BarEndColorDebuff 		= "Cor final 3 (Alvo)"
L.BarStartColorInterrupt 	= "Cor inicial 4 (Interrupção)"
L.BarEndColorInterrupt 		= "Cor final 4 (Interrupção)"
L.BarStartColorRole 		= "Cor inicial 5 (Função)"
L.BarEndColorRole 			= "Cor final 5 (Função)"
L.BarStartColorPhase 		= "Cor inicial 6 (Fase)"
L.BarEndColorPhase 			= "Cor final 6 (Fase)"
L.BarStartColorUI 			= "Cor inicial 7 (Importante)"
L.BarEndColorUI 			= "Cor final 7 (Importante)"
L.BarStartColorI2 			= "Cor inicial 8 (Importante)"
L.BarEndColorI2 			= "Cor final 8 (Importante)"
--Type 7 options
L.Bar7Header 				= "Opções da barra importante"
L.Bar7ForceLarge 			= "Sempre usar barra grande"
L.Bar7CustomInline 			= "Usar ícone customizado '!' inline"
--Timer Example Texts
L.CBTGeneric = "Genérico"
L.CBTAdd = "Adds entrando"
L.CBTAOE = "Feitiço AOE"
L.CBTTargeted = "Feitiço alvo"
L.CBTInterrupt = "Feitiço interrompível"
L.CBTRole = "Feitiço de função específica"
L.CBTPhase = "Mudança de fase"
L.CBTImportant = "Feitiço importante para o usuário"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Anúncios especiais"
L.Area_SpecWarn				= "Opções de anúncios especiais"
L.ShowSWarningsInChat 		= "Exibir anúncios especiais no quadro de bate-papo"
L.SpecWarn_FlashFrameRepeat	= "Repetir %d vezes (se ativado)"
L.SpecWarn_FlashRepeat		= "Repetir piscada"
L.SpecWarn_FlashColor		= "Cor da piscada"
L.SpecWarn_FlashDur			= "Duração da piscada: %0.1f"
L.SpecWarn_FlashAlpha		= "Transparência da piscada: %0.1f"
L.SpecWarn_DemoButton		= "Exibir exemplo"
L.SpecWarn_ResetMe			= "Redefinir padrões"

L.Area_BugAlerts 			= "Opções de alerta de relatório de bugs"
L.BadTimerAlert 			= "Exibir mensagem no bate-papo quando o DBM detectar um temporizador incorreto com pelo menos 1 segundo de erro"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts 		= "Alertas de voz"
L.Area_VoiceSelection 		= "Seleções de voz"
L.CountdownVoice 			= "Voz principal para sons de contagem"
L.CountdownVoice2 			= "Voz secundária para sons de contagem"
L.CountdownVoice3 			= "Voz terciária para sons de contagem"
L.PullVoice 				= "Voz para temporizadores de puxada"
L.VoicePackChoice 			= "Pacote de voz para alertas falados"
L.MissingVoicePack 			= "Pacote de voz ausente (%s)"
L.Area_CountdownOptions 	= "Opções de contagem regressiva"
L.Area_VoicePackReplace 	= "Opções de substituição de pacote de voz"
L.VPReplaceNote 			= "Nota: pacotes de voz nunca alteram ou removem seus sons de anúncio.\nEles são simplesmente silenciados quando o pacote de voz os substitui."
L.ReplacesAnnounce 			= "Substituir os sons de anúncio (nota: muito poucos pacotes de voz são usados, exceto para mudanças de fase e adições)"
L.ReplacesSADefault 		= "Substituir os sons padrão de anúncio especial (sons personalizados definidos pelo usuário nunca serão substituídos)"
L.Area_VoicePackAdvOptions 	= "Opções avançadas de pacote de voz"
L.Area_VPLearnMore 			= "Saiba mais sobre pacotes de voz e como usar essas opções"
L.VPLearnMore 				= "|cFF73C2FBhttps://github.com/DeadlyBossMods/DBM-Retail/wiki/%5BGuide%5D-DBM-&-Voicepacks#2022-update|r" -- OPTIONAL
L.Area_BrowseOtherVP 		= "Navegar por outros pacotes de voz no curse"
L.BrowseOtherVPs 			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r" -- OPTIONAL
L.Area_BrowseOtherCT 		= "Navegar por pacotes de contagem regressiva no curse"
L.BrowseOtherCTs 			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r" -- OPTIONAL

-- Panel: Event Sounds
L.Panel_EventSounds 			= "Sons de eventos"
L.Area_SoundSelection 			= "Seleções de sons"
L.EventVictorySound 			= "Som para vitória no encontro"
L.EventWipeSound 				= "Som para derrota no encontro"
L.EventEngagePT 				= "Som para o início do temporizador de puxada"
L.EventEngageSound 				= "Som para o início do encontro"
L.EventDungeonMusic 			= "Música dentro de masmorras/raides"
L.EventEngageMusic 				= "Música durante os encontros"
L.Area_EventSoundsExtras 		= "Opções de sons de eventos"
L.EventMusicCombined 			= "Permitir todas as opções de música nas seleções de masmorra e encontro (requer recarregar IU para refletir as mudanças)"
L.DisableBuiltInMusic 			= "Desativar a música de sons de evento incorporados e carregar apenas pacotes de música de terceiros"
L.Area_EventSoundsFilters 		= "Condições de filtro de sons de eventos"
L.EventFilterDungMythicMusic 	= "Não reproduzir música de masmorra na dificuldade Mítica/Mítica+"
L.EventFilterMythicMusic 		= "Não reproduzir música de encontro na dificuldade Mítica/Mítica+"

-- Tab: Global Disables & Filters
L.TabCategory_Filters 		= "Desativações globais e filtros"
L.Area_DBMFiltersSetup 		= "Guia de filtros DBM"
L.Area_BlizzFiltersSetup 	= "Guia de filtros Blizzard"

-- Panel: Toggle DBM Features
L.Panel_SpamFilter 			= "Desativar recursos de DBM"

L.Area_SpamFilter_SpecFeatures 	= "Funcionalidades de anúncios"
L.SpamBlockNoShowAnnounce 		= "Não exibir texto nem reproduzir som para QUALQUER anúncio geral"
L.SpamBlockNoSpecWarnText 		= "Não exibir texto de anúncio especial"
L.SpamBlockNoSpecWarnFlash 		= "Não exibir piscada de tela para anúncio especial"
L.SpamBlockNoSpecWarnVibrate 	= "Não vibrar controle no anúncio especial"
L.SpamBlockNoSpecWarnSound 		= "Não reproduzir sons de anúncio especial (os sons de pacotes de voz ativados no painel de contagens et pacotes de voz ainda serão reproduzidos)"
L.SpamBlockNoPrivateAuraSound 	= "Não registrar sons de auras privadas"

L.Area_SpamFilter_Timers 		= "Funcionalidades de temporizador"
L.SpamBlockNoShowBossTimers 	= "Não exibir temporizadores para chefes de masmorras/raides"
L.SpamBlockNoShowTrashTimers 	= "Não exibir temporizadores para lixos de masmorras/raides"
L.SpamBlockNoShowEventTimers 	= "Não exibir temporizadores para eventos"
L.SpamBlockNoShowUTimers 		= "Não exibir temporizadores enviados pelo usuário"
L.SpamBlockNoCountdowns 		= "Não reproduzir sons de contagem regressiva"

L.Area_SpamFilter_Nameplates 	= "Funcionalidades de placa de nome"
L.SpamBlockNoNameplate 			= "Não exibir ícones de placa de nome apenas para mecânicas especiais de chefe (ex: bônus o penalidade em inimigos)"
L.SpamBlockNoNameplateCD 		= "Não exibir ícones de temporizador de recarga de placa de nome apenas para habilidades"
L.SpamBlockNoNameplateCasts 	= "Não exibir ícones de temporizador de lançamento de placa de nome apenas para habilidades"
L.SpamBlockNoBossGUIDs 			= "Não exibir ícones de temporizador de recarga de placa de nome para habilidades que também têm temporizadores"
L.AlwaysKeepNPs 				= "Manter ícones de temporizador de recarga de placa de nome expirados visíveis até que a habilidade seja re-lançada"

L.Area_SpamFilter_Misc 			= "Funcionalidades diversas"
L.SpamBlockNoSetIcon 			= "Não definir ícones automaticamente em alvos"
L.SpamBlockNoRangeFrame 		= "Não exibir automaticamente o quadro de distância"
L.SpamBlockNoInfoFrame 			= "Não exibir automaticamente o quadro de informações"
L.SpamBlockNoHudMap 			= "Não exibir HudMap"
L.SpamBlockNoYells 				= "Não enviar gritos no bate-papo"
L.SpamBlockNoNoteSync 			= "Não aceitar notas compartilhadas"
L.SpamBlockAutoGossip 			= "Não lidar automaticamente os diálogos"

L.Area_Restore 					= "Opções de redefinição"
L.SpamBlockNoIconRestore 		= "Não salvar os estados dos ícones e redefini-los ao final do combate"
L.SpamBlockNoRangeRestore 		= "Não redefinir o quadro de distância ao estado anterior quando os mods chamam 'ocultar'"

-- Tab: Spam Filter
L.Panel_SpamFilter			= "Filtros global e de spam"
L.Area_SpamFilter			= "Opções do filtro global"
L.DontShowFarWarnings		= "Não exibir anúncios/temporizadores para eventos que estão longe"
L.StripServerName			= "Tira com nome do reino em anúncios e temporizadores"

L.Area_SpecFilter			= "Opções de especialização"
L.FilterDispels				= "Filtrar anúncios para magias dissipáveis se a seu dissipar estiver em recarga."
L.FilterCrowdControl		= "Filtrar anúncios para controle de multidão com base em interrupções se o seu controle de multidão estiver em recarga."

L.Area_PullTimer			= "Opções de filtros de puxada, pausa, e temporizadores customizados"
L.DontShowPTNoID			= "Bloquear o temporizador de puxada se não foi enviado na mesma zona que você"
L.DontShowPT				= "Não exibir a barra de puxada"
L.DontShowPTText			= "Não exibir texto de anúncio do temporizador de puxada"
L.DontPlayPTCountdown		= "Não reproduzir o áudio da contagem regressiva de puxada/customizado"
L.PT_Threshold				= "Não reproduzir o áudio do temporizador acima de: %d"

-- Panel: Reduce Information
L.Panel_ReducedInformation 			= "Reduzir informações"

L.Area_SpamFilter_Anounces 			= "Filtros de anúncios"
L.SpamBlockNoShowTgtAnnounce 		= "Não exibir texto nem reproduzir som para anúncios gerais de ALVO que não afetam você, exceto onde indicado que um anúncio específico ignora este filtro (desativação global nas funcionalidades de DBM substitui este)"
L.SpamBlockNoTrivialSpecWarnSound 	= "Não reproduzir sons de anúncio especial nem exibir piscada de tela para conteúdo trivial para o seu nível (em vez disso, toca som de anúncio não enfatizado selecionado pelo usuário)"

L.Area_SpamFilter 					= "Opções de filtro de spam"
L.DontShowFarWarnings 				= "Não exibir anúncios/temporizadores para eventos distantes"
L.StripServerName 					= "Remover nome do reino de anúncios, temporizadores, verificação de alcance e quadro de informações"
L.FilterVoidFormSay2 				= "Não enviar ícone de bate-papo nem gritos de contagem regressiva no bate-papo quando estiver na forma do vazio (gritos regulares de bate-papo ainda são enviados)"

L.Area_SpecFilter 					= "Opções de filtro de função"
L.FilterDispels 					= "Filtrar anúncios para feitiços dissipáveis se seu dissipar estiver em recarga"
L.FilterCrowdControl 				= "Filtrar anúncios para interrupções baseadas em controle de multidão se seu CC estiver em recarga"
L.FilterTrashWarnings 				= "Filtrar todos os anúncios de lixos em masmorras de seguidor, normais e triviais (fora de nível)"

L.Area_BInterruptFilter 			= "Opções de filtro de interrupção de chefe"
L.FilterTargetFocus 				= "Filtrar se o lançador não for o alvo/foco/inimigo suave atual"
L.FilterInterruptCooldown 			= "Filtrar se o feitiço de interrupção estiver em recarga"
L.FilterInterruptHealer 			= "Filtrar se você estiver em uma especialização de curador"
L.FilterInterruptNoteName 			= "Filtrar se o alerta tiver uma contagem, mas seu nome não estiver na nota personalizada" --Only used on bosses, trash mods don't assign counts
L.Area_BInterruptFilterFooter 		= "Se nenhum filtro for selecionado, todas as interrupções serão exibidas (pode ser spammante)\nAlguns mods podem ignorar esses filtros totalmente se o feitiço for criticamente importante"
L.Area_TInterruptFilter 			= "Opções de filtro de interrupção de lixo" --Reuses above 3 strings

-- Panel: DBM Handholding
L.Panel_HandFilter 					= "Reduzir assistência de DBM"
L.Area_SpamFilter_SpecRoleFilters 	= "Filtros de tipo de anúncio especial"
L.SpamSpecInformationalOnly 		= "Alterar todo o texto/alertas de pacotes de voz instrutivos de anúncios especiais (requer recarregar a interface). Os alertas ainda serão exibidos e reproduzirão áudio, mas serão genéricos e menos diretos"
L.SpamSpecRoleDispel 				= "Não exibir alertas de 'dissipar' (Sem texto ou som)"
L.SpamSpecRoleInterrupt 			= "Não exibir alertas de 'interrupção' (Sem texto ou som)"
L.SpamSpecRoleDefensive 			= "Não exibir alertas de 'defensivo' (Sem texto ou som)"
L.SpamSpecRoleTaunt 				= "Não exibir alertas de 'provocar' (Sem texto ou som)"
L.SpamSpecRoleSoak 					= "Não exibir alertas de 'absorver' (Sem texto ou som)"
L.SpamSpecRoleStack 				= "Não exibir alertas de 'acúmulo alto' (Sem texto ou som)"
L.SpamSpecRoleSwitch 				= "Não exibir alertas de 'troca de alvo' e 'adds' (Sem texto ou som)"
L.SpamSpecRoleGTFO 					= "Não exibir alertas de 'GTFO' (Sem texto ou som)"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "Bloquear funcionalidades de Blizzard"
--Toast
L.Area_HideToast					= "Desativar anúncios de Blizzard (pop-ups)"
L.HideGarrisonUpdates				= "Ocultar anúncios de seguidores durante combate contra chefes"
L.HideGuildChallengeUpdates			= "Ocultar anúncios de desafios de guilda durante combate contra chefes"
--L.HideBossKill					= "Ocultar anúncios de morte de chefes"--NYI
--L.HideVaultUnlock					= "Ocultar anúncios de desbloqueio do cofre"--NYI
--Cut Scenes
L.Area_Cinematics					= "Bloquear cenas cinemáticas do jogo"
L.DuringFight						= "Bloquear cenas de combate durante encontros com chefes"--uses explicite IsEncounterInProgress check
L.InstanceAnywhere					= "Bloquear cenas não relacionadas a combate em qualquer lugar dentro de uma masmorra ou raide"
L.NonInstanceAnywhere				= "PERIGO: Bloquear cenas em áreas externas de mundo aberto (NÃO recomendado)"
L.OnlyAfterSeen						= "Apenas bloquear cenas depois de terem sido vistas pelo menos uma vez (ALTAMENTE recomendado, para experiência de história como pretendido pelo menos uma vez)"
--Sound
L.Area_Sound						= "Desativar sons do jogo"
L.DisableSFX						= "Desativar efeitos sonoros durante combate contra chefes"
L.DisableAmbiance					= "Desativar ambiente sonoro durante combate contra chefes"
L.DisableMusic						= "Desativar música durante combate contra chefes (Nota: Se ativado, a música personalizada do chefe não será reproduzida se estiver ativada nos sons de evento)"
--Other
L.Area_HideBlizzard					= "Desativar e ocultar outras inconveniências de Blizzard"
L.HideBossEmoteFrame				= "Ocultar quadro de emotes de chefes de raide durante combate contra chefes"
L.HideWatchFrame					= "Ocultar quadro de acompanhamento (objetivos) durante combate contra chefes se nenhum feito estiver sendo rastreado e se não estiver em um Mítico+"
L.HideQuestTooltips					= "Ocultar objetivos de missões das dicas durante combate contra chefes"
L.HideTooltips						= "Ocultar completamente as dicas durante lutas contra chefes"

L.DisableSFX						= "Desativar o canal de efeitos sonoros durante lutas contra chefes"

-- Panel: Raid Leader Controls
L.Tab_RLControls 					= "Controles de líder de raide"
L.Area_FeatureOverrides 			= "Opções de substituição de funcionalidades"
L.OverrideIcons 					= "Desativar a marcação de ícones para todos os usuários na raide, incluindo você mesmo" -- (Use override instead of disable if you want DBM to do marking under your terms)
L.OverrideSay 						= "Desativar mensagens de bolha de bate-papo/DIZ para todos os usuários na raide, incluindo você mesmo"
L.DisableStatusWhisperShort 		= "Desativar sussurros de status/resposta para todo o grupo" --Duplicated from privacy but makes sense to include option in both panels
L.DisableGuildStatusShort 			= "Desativar mensagens de progresso sincronizadas com a guilda para todo o grupo" --Duplicated from privacy but makes sense to include option in both panels
--L.DisabledForDropdown 			= "Ocultar mod(s) de chefe para os quais a desativação será enviada" -- NYI
--L.DiabledForBoth 					= "Desativar as funcionalidades acima para DBM e BW" -- NYI
--L.DiabledForDBM 					= "Desativar as funcionalidades acima apenas para usuários de DBM" -- NYI
--L.DiabledForBW 					= "Desativar as funcionalidades acima apenas para usuários do BW" -- NYI

L.Area_ConfigOverrides 				= "Opções de substituição de configuração" -- NYI
L.OverrideBossAnnounceOptions 		= "Definir a configuração de anúncios de mods de chefe para todos os usuários de DBM igual à minha configuração" -- NYI
L.OverrideBossTimerOptions 			= "Definir a configuração de temporizadores de mods de chefe para todos os usuários de DBM igual à minha configuração" -- NYI
L.OverrideBossIconOptions 			= "Definir a configuração de ícones de mods de chefe para todos os usuários de DBM igual à minha configuração (se a configuração de ícones estiver desativada nas opções acima, esta opção será ignorada)" -- NYI
L.OverrideBossSayOptions 			= "Definir a configuração de bolhas de chat de mods de chefe para todos os usuários de DBM igual à minha configuração (se a configuração de bolhas de bate-papo estiver desativada nas opções acima, esta opção será ignorada)" -- NYI
L.ConfigAreaFooter 					= "As opções nesta área apenas substituem temporariamente a configuração dos usuários ao iniciar o combate sem alterar sua configuração salva."
L.ConfigAreaFooter2 				= "Recomenda-se considerar todas as funções e não excluir temporizadores/alertas necessários para tanques, etc."

L.Area_receivingOptions 			= "Opções de recebimento" -- NYI
L.NoAnnounceOverride 				= "Não aceitar substituições de anúncios dos líderes de raide." -- NYI
L.NoTimerOverridee 					= "Não aceitar substituições de temporizadores dos líderes de raide." -- NYI
L.ReplaceMyConfigOnOverride 		= "AVISO: Substituir permanentemente minhas configurações de mods pelas do líder de raide ao aceitar substituições" -- NYI
L.ReceivingFooter 					= "As substituições de opções de ícones e bolhas de bate-papo não podem ser recusadas, pois essas configurações afetam outros jogadores ao seu redor" -- NYI
L.ReceivingFooter2 					= "Se você ativar essas opções, é entre você e o líder de raide se sua configuração causar conflitos com a intenção deles" -- NYI
L.ReceivingFooter3 					= "Se você ativar a opção 'substituir minhas configurações de mod', suas configurações originais serão perdidas ao aceitar a substituição" -- NYI

L.TabFooter = "Todas as opções neste painel só funcionam se você for o líder do grupo em um grupo que não seja de masmorra/LFR"

-- Panel: Privacy
L.Tab_Privacy 				= "Controles de privacidade"
L.Area_WhisperMessages 		= "Opções de mensagens de sussurro"
L.AutoRespond 				= "Responder automaticamente a sussurros durante o combate"
L.WhisperStats 				= "Incluir estatísticas de vitórias/derrotas nas respostas de sussurro"
L.DisableStatusWhisper 		= "Desativar sussurros de status para todo o grupo (requer ser o líder do grupo). Aplica-se apenas a raides normal/heróica/mítica e masmorras míticas+"
L.Area_SyncMessages 		= "Opções de sincronização do addon"
L.DisableGuildStatus 		= "Desativar mensagens de progresso sincronizadas com a guilda. Se for líder do grupo, isso desativa para todos os usuários de DBM no grupo"
L.EnableWBSharing 			= "Compartilhar quando você engajar/derrotar um chefe mundial com sua guilda e amigos na battle.net que estão no mesmo reino."

-- Tab: Frames & Integrations
L.TabCategory_Frames 		= "Quadros e integrações"
L.Area_NamelateInfo 		= "Informações das auras de placas de nome de DBM"

-- Panel: InfoFrame
L.Panel_InfoFrame 			= "Quadro de informações"

-- Panel: Range
L.Panel_Range				= "Quadro de distância"

-- Panel: Nameplate
L.Panel_Nameplates 			= "Placas de nome"
L.Plater_Config 			= "Abrir configuração de Plater"
L.Area_NPStyle 				= "Estilo (Nota: configura o estilo apenas quando não está usando Plater.)"
L.NPAuraText 				= "Exibir texto do temporizador nos ícones das placas de nome"
L.NPAuraSize 				= "Tamanho em pixels do ícone: %d"
L.NPIcon_BarOffSetX 		= "Deslocamento do ícone X: %d"
L.NPIcon_BarOffSetY 		= "Deslocamento do ícone Y: %d"
L.NPIcon_GrowthDirection 	= "Direção de crescimento dos ícones"
L.NPIcon_Spacing 			= "Espaçamento dos ícones: %d"
L.NPIcon_MaxTextLen 		= "Comprimento máx. do texto: %d"
L.NPIconAnchorPoint 		= "Ponto de ancoragem do ícone"
L.NPDemo 					= "Teste (esteja próximo às placas de nome)"
L.FontTypeTimer 			= "Selecionar fonte do temporizador"
L.FontTypeText 				= "Selecionar fonte do texto"

L.Area_NPGlow 				= "Iluminação (Nota: configura a iluminação apenas quando não está usando o Plater.)"
L.NPIcon_GlowBehavior 		= "Comportamento de iluminação dos ícones de recarga"
L.NPIcon_CastGlowBehavior 	= "Comportamento de iluminação dos ícones de lançamento"
L.NPIcon_GlowNone 			= "Nunca iluminar ícones"
L.NPIcon_GlowImportant 		= "Iluminar ícones importantes de recarga/lançamento expirando"
L.NPIcon_GlowAll 			= "Iluminar todos os ícones de recarga/lançamento expirando"
L.NPIcon_GlowTypeCD 		= "Tipo de iluminação para ícones de recarga"
L.NPIcon_GlowTypeCast 		= "Tipo de iluminação para ícones de lançamento"
L.NPIcon_Pixel 				= "Pixel"
L.NPIcon_Proc 				= "Proc"
L.NPIcon_AutoCast 			= "Lançamento automático"
L.NPIcon_Button 			= "Botão"

L.Panel_ExtraFeatures		= "Funcionalidades extra"

L.Area_ChatAlerts			= "Opções de alerta do bate-papo"
L.RoleSpecAlert				= "Exibir mensagem de alerta quando sua especialização de saque não corresponder à sua especialização atual ao entrar na raide"
L.CheckGear					= "Envia um mensagem de alerta quando o seu ilvl equipado for muito menor do que o ilvl nas bolsas(40+)"
L.WorldBossAlert			= "Exibir mensagem de alerta quando um chefe mundial possivelmente for atacado no seu reino por membros da sua guilda ou amigos"
L.WorldBuffAlert 			= "Exibir mensagem de alerta e temporizador quando o RP de bônus mundial for iniciado no seu reino (Desativado em SoD)"

L.Area_SoundAlerts			= "Opções de som de alerta"
L.LFDEnhance				= "Reproduzir o som de TodosProntos para checagem de papéis e CB/LDG no canal de áudio principal (i.e. sons funcionam mesmo que os efeitos sonoros estejam desligados e são geralmente mais altos)"
L.WorldBossNearAlert		= "Reproduzir o som de TodosProntos quando chefes do mundo perto de você que você precisa estiverem sendo atacados"
L.RLReadyCheckSound 		= "Reproduzir o som através do canal de áudio principal ou de diálogo e faça o ícone do aplicativo piscar quando uma verificação de prontidão for realizada"
L.AutoReplySound 			= "Reproduzir som de alerta e fazer o ícone do aplicativo piscar ao receber o sussurro de resposta automática de DBM"

L.Area_AutoLogging			= "Opções de registro automático"
L.AutologBosses 			= "Gravar automaticamente o registro dos encontros com chefes usando o registro de combate de Blizzard (requer o uso de /dbm pull antes do chefe para compatibilidade com <a href=\"http://www.warcraftlogs.com\">|cff3588ffwarcraftlogs.com|r</a>)"
L.AdvancedAutologBosses		= "Gravar automaticamente o encontro com o chefe utilizando o Transcriptor"

L.Area_3rdParty				= "Opções de addons de terceiros"
L.oRA3AnnounceConsumables	= "Anunciar a verificação dos consumíveis oRA3 no início do combate"

L.Area_Invite				= "Opções de convite"
L.AutoAcceptFriendInvite	= "Aceitar convites de amigos automaticamente"
L.AutoAcceptGuildInvite		= "Aceitar convites de membros da guilda automaticamente"
L.Area_Advanced				= "Opções avançadas"
L.FakeBW					= "Fingir ser BigWigs em checagens de versão ao invés de ser DBM (útil para guildas que forçam o uso de BigWigs)"

L.Area_CombatAlerts			= "Opções de alertas de combate"
L.AFKHealthWarning			= "Reproduzir som de alerta e fazer o ícone do aplicativo piscar quando você estiver perdendo vida (em qualquer porcentagem) enquanto estiver LDT"
L.HealthWarningLow			= "Reproduzir som de alerta e fazer o ícone do aplicativo piscar quando você estiver perdendo vida (quando estiver abaixo de 35%) enquanto estiver LDT"
L.EnteringCombatAlert		= "Reproduzir som de alerta e fazer o ícone do aplicativo piscar ao entrar em combate"
L.LeavingCombatAlert		= "Reproduzir som de alerta ao sair de combate"

L.Panel_Profile				= "Perfil"
L.Area_CreateProfile		= "Criação de perfil"
L.EnterProfileName			= "Entre com o nome do perfil"
L.CreateProfile				= "Criar perfil para opções do core de DBM"
L.Area_ApplyProfile			= "Definir o perfil ativo para o core de DBM"
L.SelectProfileToApply		= "Selecionar o perfil a aplicar"
L.Area_CopyProfile			= "Copiar o perfil para o core de DBM"
L.SelectProfileToCopy		= "Selecionar o perfil a ser copiado"
L.Area_DeleteProfile		= "Remover o perfil para o core de DBM"
L.SelectProfileToDelete		= "Selecionar o perfil a ser removido"
L.Area_DualProfile			= "Opções de perfil da mod de chefes"
L.DualProfile				= "Ativar suporte para outros mods de chefes de acordo com a especialização. (O gerenciamento de perfis de mods de chefes é feito da tela de mods de chefes carregados)"

L.Area_ModProfile			= "Copia as preferencias da mod para outros personagens/ especializações ou deleta a customização efetuada"
L.ModAllReset				= "Redefine todas as opções do mod"
L.ModAllStatReset			= "Redefine todos os stats do mod"
L.SelectModProfileCopy		= "Copia todas as preferencias de"
L.SelectModProfileCopySound	= "Copia apenas as preferencias sonoras de"
L.SelectModProfileDelete	= "Apaga as opções da mod de"

L.Area_ImportExportProfile 	= "Importar/exportar perfis"
L.ImportExportInfo 			= "Importar substituirá seu perfil atual, faça por sua conta e risco."
L.ButtonImportProfile 		= "Importar perfil"
L.ButtonExportProfile 		= "Exportar perfil"

L.ImportErrorOn 			= "Sons personalizados ausentes para a configuração: %s"
L.ImportVoiceMissing 		= "Pacote de voz ausente: %s"

-- Misc
L.Area_General 				= "Geral"
L.Area_Position 			= "Posição"
L.Area_Style 				= "Estilo"

L.FontType					= "Selecionar fonte"
L.FontStyle					= "Bandeira da fonte"
L.FontColor					= "Cor da fonte"
L.FontShadow				= "Sombra da fonte"
L.FontSize					= "Tamanho da fonte: %d"

L.FontHeight	= 16

-- Testing
L.DevPanel 						= "Desenvolvimento e testes"
L.DevPanelArea 					= "Interface de desenvolvimento e testes"
L.DevPanelExplanation 			= "Esta é uma interface de desenvolvimento e teste que valida se o DBM está funcionando como esperado ao reproduzir registros de combate."
L.DevModPanelExplanation 		= [[Bem-vindo ao ambiente de desenvolvimento e testes deste mod.
Você pode reproduzir registros de batalhas de chefes aqui para ver como o mod se comporta e testar integrações com callbacks de DBM. Consulte DBM-Test/README.md para mais detalhes sobre integrações e callbacks. O DBM vem com registros de exemplo para muitas raides, mas você também pode importar seus próprios registros de Transcriptor.
]]

L.TimewarpSetting 				= "Distorção temporal: %dx"
L.TimewarpDynamic 				= "Distorção temporal: dinâmica (mais rápida)"
L.TestSupportArea 				= "Opções de carregamento do mod"
L.ModNotLoadedWithTests 		= "AVISO: Este mod não está carregado com suporte completo a testes. Se o mod chamar diretamente funções da API, como UnitHealth() ou UnitName(), elas não funcionarão corretamente. Isso é comum em funções relacionadas à saúde, energia ou alvos da unidade."
L.ModLoadedWithTests 			= "O mod está atualmente carregado com suporte a testes porque pelo menos um mod no addon tem testes ativados."
L.AlwaysLoadModWithTests 		= "Sempre carregar este mod com suporte completo a testes (torna o carregamento ligeiramente mais lento)"
L.ModLoadRequiresReload 		= ", requer recarregar a interface para aplicar"
L.TestSelectArea 				= "Dados de teste"
L.SelectTestLog 				= L.TestSelectArea
L.SelectPerspective 			= "Perspectiva do registro (jogador simulado)"
L.ImportTranscriptor 			= "Importar registro de Transcriptor"
L.ImportTranscriptorHeader 		= [[
Importe um registro de Transcriptor colando-o em qualquer lugar na caixa de edição abaixo. A velocidade de colagem é de aproximadamente 2 MiB/s, o que significa que o jogo ficará congelado por vários segundos ao colar arquivos de registro muito grandes.
Você também pode importar a sessão atual de Transcriptor das variáveis salvas de Transcriptor com o botão de importação à direita.]]
L.PasteLogHere 					= "Pressione " .. (IsMacClient() and "Cmd-V" or "Ctrl-V") .. " para colar um registro aqui."
L.LogPasted 					= "Colado %.2f MiB em %.1f segundos (%.2f MiB/s)."
L.ImportLocalTranscriptor 		= "Importar sessão\natual de Transcriptor"
L.NoLocalTranscriptor 			= "Não foi possível encontrar dados locais de Transcriptor."
L.LocalImportDone 				= "Importados %d registros com %d encontros de Transcriptor."
L.Parsing 						= "Analisando..."
L.SelectLogDropdown 			= "Selecionar encontro"
L.CreateTest 					= "Criar teste"
L.ExportTest 					= "Exportar teste"
L.ExportedTest 					= "Caso de teste exportado com %d linhas (%.1f%% filtradas)."
L.ExportedTestFailedAnon 		= "AVISO: Falha na anonimização do registro, %d cadeias não anonimizadas encontradas (detalhes na janela de bate-papo e saída)."
L.ExportTestFailedNonAnonString = "AVISO: A cadeia %q parece não estar anonimizada."
L.CreatedTest 					= "Teste criado com %d eventos em %.1f segundos."
L.NoLogsFound 					= "A importação de Transcriptor não contém dados de registro."
L.NoTestDataAvailable 			= "Nenhum dado de teste disponível"
L.NoLogSelected 				= "Criação de teste falhou: Nenhum registro selecionado."
L.LogAlreadyImported 			= "Criação de teste falhou: Teste já importado."

L.RewriteAllToYou 				= "Todos os jogadores ao mesmo tempo"
L.RealModOptionsBelow 			= "As opções do mod abaixo são sincronizadas entre o modo playground e suas configurações reais."
L.Test 							= "Teste"
L.Tests 						= "Testes"
L.AllTests 						= "Todos os testes"
L.RunTest 						= "Executar teste"
L.RunTestShort 					= "Executar"
L.StopTest 						= "Parar teste"
L.StopTests 					= "Parar testes"
L.RunAllTests 					= "Executar todos os testes"
L.Queued 						= "Enfileirado"
L.Running 						= "Executando"
L.Failed 						= "Falhou"
L.ShowReport 					= "Exibir relatório"
L.ShowErrors 					= "Exibir erros"
L.TestModEntry 					= "[Playground] %s"
L.EnterTestMode 				= "Modo Playground"
L.SkipPhase 					= "Pular para próxima fase"

L.AnonymizeTest 				= "Anonimizar nomes e GUIDs dos jogadores"
L.ShowThisTestEverywhere 		= "Exibir este teste para todos os módulos"
L.SaveThisTest 					= "Salvar este registro de teste de forma persistente"

L.BossModTColor						= "Cor da barra"
L.BossModCVoice						= "Voz para contagem regressiva"
L.BossModSWSound					= "Som de anúncio"
