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
L.OTabWorld					= "Chefes do mundo"--Since there are so many world mods, enough to get their own tab
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
L.Mod_Enabled				= "Habilitar: %s"
L.Mod_Reset					= "Carregar opções padrão"
L.Reset 					= "Resetar"
L.Import					= "Importar"

L.Enable					= "Habilitar"
L.Disable					= "Desabilitar"

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
L.Area_BasicSetup			= "Dicas iniciais de configuração do DBM"
L.Area_ModulesForYou		= "Quais módulos DBM são adequados para você?"
L.Area_ProfilesSetup		= "Guia de uso de perfis DBM"
-- Panel: Core & GUI
L.Core_GUI 					= "Cor e GUI"
L.General 					= "Opções gerais do DBM"
L.EnableMiniMapIcon			= "Exibir botão no mini-mapa"
L.EnableCompartmentIcon		= "Exibir botão do compartimento"
L.UseSoundChannel			= "Defina o canal de áudio usado pelo DBM para reproduzir sons de alerta"
L.UseMasterVolume			= "Utilizar canal principal de áudio para reproduzir arquivos de som."--Update
L.UseDialogChannel			= "Canal de áudio de diálogo."
L.UseSFXChannel				= "Canal de áudio de efeitos sonoros (SFX)."
L.Latency_Text				= "Definir latência máxima de sincronização: %d"

L.Button_RangeFrame			= "Exibir/esconder quadro de distância"
L.Button_RangeRadar			= "Exibir/esconder radar de distância" -- Não existe no en.lua
L.Button_InfoFrame			= "Exibir/esconder quadro de informações"
L.Button_TestBars			= "Iniciar barras de teste"
L.Button_MoveBars			= "Mover barras"
L.Button_ResetInfoRange		= "Resetar quadros de informações/distância"

L.ModelOptions				= "Opções do visualizador de modelos 3D"
L.EnableModels				= "Habilitar modelos 3D nas opções de chefe"
L.ModelSoundOptions			= "Definir opção de som para o visualizador de modelos"
L.ModelSoundShort			= "Curto"
L.ModelSoundLong			= "Longo"

L.ResizeOptions				= "Opções de redimensionamento"
L.ResizeInfo				= "Você pode redimensionar a GUI clicando no canto inferior direito e arrastando."
L.Button_ResetWindowSize	= "Resetar o tamanho da janela da GUI"
L.Editbox_WindowWidth		= "Largura da janela GUI"
L.Editbox_WindowHeight		= "Altura da janela GUI"

L.UIGroupingOptions			= "Opções de agrupamento de IU (alterá-las requer recarregamento da IU para qualquer mod que já esteja carregado)"
L.GroupOptionsExcludeIcon	= "Exclua as opções de 'Ativar ícone' de serem agrupadas por feitiço (elas serão agrupadas em sua própria categoria de 'Ícones')"
L.AutoExpandSpellGroups		= "Expanda automaticamente as opções agrupadas por feitiço"
L.ShowWAKeys				= "Mostre as teclas WeakAuras ao lado dos nomes dos feitiços para ajudar a escrever WeakAuras usando os gatilhos do Boss Mod."
L.ShowSpellDescWhenExpanded	= "Continuar mostrando a descrição do feitiço quando os grupos forem expandidos"--Might not be used
L.NoDescription				= "Esta habilidade não tem descrição"
L.CustomOptions				= "Esta categoria contém opções personalizadas para uma habilidade ou evento que não possui ID de feitiço ou diário próprio. Essas opções foram agrupadas usando um ID manual personalizado para facilitar a criação de WeakAuras"

-- Tab: General Timer Options
L.TimerGeneral 				= "Opções gerais do temporizador do DBM"
L.SKT_Enabled				= "Sempre mostrar um temporizador de sua vitória recorde (Sobrepõe a opção do chefe específico)"
L.ChallengeTimerOptions		= "Colocar opção para temporizador de melhor tempo em modo desafio"
L.ChallengeTimerPersonal	= "Pessoal"
L.ChallengeTimerRealm		= "Reino"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Avisos de raide"
L.RaidWarning_Header		= "Opções de avisos de raide"
L.RaidWarnColors 			= "Cores dos avisos de raide"
L.RaidWarnColor_1 			= "Cor 1"
L.RaidWarnColor_2 			= "Cor 2"
L.RaidWarnColor_3		 	= "Cor 3"
L.RaidWarnColor_4 			= "Cor 4"
L.InfoRaidWarning			= [[Você pode especificar a cor e posição do quadro de avisos de raide.
Esse quadro é utilizado para mensagens como "Jogador X está sob efeito de Y".]]
L.ColorResetted 			= "As opções de cor desse campo foram resetadas."
L.ShowWarningsInChat 		= "Exibir avisos na janela de chat."
L.WarningIconLeft 			= "Mostrar ícone do lado esquerdo."
L.WarningIconRight 			= "Mostrar ícone do lado direito."
L.WarningIconChat 			= "Mostrar ícones no chat"

-- estavam faltando as linhas abaixo
L.Warn_Duration				= "Duração do aviso: %0.1f seg"
L.None						= "Nenhum"
L.Outline					= "Contorno"
L.ThickOutline				= "Espessura do contorno"
L.MonochromeOutline			= "Contorno monocromático"
L.MonochromeThickOutline	= "Espessura do contorno monocromático"
L.RaidWarnSound				= "Toque som no aviso de raide"

-- Special Announce Dropdowns
L.SAOne     				= "Som global 1 (pessoal)"
L.SATwo     				= "Som global 2 (todos)"
L.SAThree   				= "Som global 3 (ação de alta prioridade)"
L.SAFour    				= "Som global 4 (fuga de alta prioridade)"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Mensagens em geral"
L.CoreMessages				= "Opções de mensagens principais"
L.ShowPizzaMessage 			= "Exibir mensagens ao receber cronógrafos no quadro de chat"
L.ShowAllVersions	 		= "exibir a versão da mod para todos os membros no chat"
L.CombatMessages			= "Opções de mensagens de combate"
L.ShowEngageMessage 		= "Exibir mensagens ao iniciar combate no quadro de chat"
L.ShowDefeatMessage 		= "Exibir mensagens ao vencer chefes no quadro de chat"
L.ShowGuildMessages 		= "Exibir mensagens de puxada/vitória/derrota no quadro de chat"
L.Area_WhisperMessages		= "Opções de mensagens de sussurro"
L.AutoRespond 				= "Responder automaticamente a sussurros durante a luta"
L.WhisperStats 				= "Incluir estatísticas de derrotas/vitórias nas respostas a sussurros"

-- Tab: Barsetup
L.TabCategory_Timers		= "Configurações da barra"
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
L.AreaTitle_BarSetup		= "Opções gerais de barra"
L.AreaTitle_BarSetupSmall 	= "Opções da barra pequena"
L.AreaTitle_BarSetupHuge	= "Opções da barra grande"
L.EnableHugeBar 			= "Habilitar barra grande (aka Barra 2)"
L.BarIconLeft 				= "Ícone da esq."
L.BarIconRight 				= "Ícone da dir."
L.ExpandUpwards				= "Expandir para cima"
L.FillUpBars				= "Barras enchem"
L.ClickThrough				= "Desabilitar eventos de mouse (permite clicar através das barras)"
L.Bar_Decimal				= "Exibir porcentagens abaixo do temporizador: %d"
L.Bar_EnlargeTime			= "Barras aumentam abaixo deste tempo: %d"
L.BarSpark					= "Barra faísca"
L.BarFlash					= "Barra pisca quando estiver para expirar"
L.BarSort					= "Selecionar pelo tempo restante"


-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Avisos raide especiais"
L.Area_SpecWarn				= "Opções de avisos especiais"
L.ShowSWarningsInChat 		= "Exibir avisos especiais no quadro de chat"
L.SpecWarn_FlashFrameRepeat	= "Repetir %d vezes (se habilitado)"
L.SpecWarn_FlashRepeat		= "Repetir piscada"
L.SpecWarn_FlashColor		= "Cor pisca"
L.SpecWarn_FlashDur			= "Duração da piscada: %0.1f"
L.SpecWarn_FlashAlpha		= "Alfa da piscada: %0.1f"
L.SpecWarn_DemoButton		= "Mostrar exemplo"
L.SpecWarn_ResetMe			= "Redefinir padrões"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Avisos falados"
L.Area_VoiceSelection		= "seleção de vozes"
L.CountdownVoice			= "Definir voz primaria para sons de contagem"
L.CountdownVoice2			= "Definir voz secundaria para sons de contagem"
L.CountdownVoice3			= "Definir voz terciária para sons de contagem"
L.VoicePackChoice			= "Definir pacote de vozes para avisos falados"
L.Area_CountdownOptions		= "opções de contagens"
L.Area_VoicePackOptions		= "Opções de pacotes de vozes (Pacotes de vozes de terceiros)"
L.SpecWarn_NoSoundsWVoice	= "Filtrar avisos sonoros especiais para avisos que contem avisos falados ..."
L.SWFNever					= "Nunca"
L.SWFDefaultOnly			= "Quando avisos especiais usarem som padrão ( permitir que sons customizados ainda toquem)."
L.SWFAll					= "Quando sons especiais usarem qualquer som"
L.SpecWarn_AlwaysVoice		= "Sempre tocar todos os avisos falados (Substitui opções especificas dos chefes. Útil para lideres de raides)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs? talvez ...


-- Tab: Global Filter
L.Panel_SpamFilter			= "Desligamentos globais & filtros"

L.SpamBlockNoShowAnnounce	= "Não exibir anúncios ou tocar avisos sonoros"
L.SpamBlockNoSetIcon		= "Não marcar jogadores com ícones"
L.SpamBlockNoRangeFrame		= "Não exibir quadro de distância"
L.SpamBlockNoInfoFrame		= "Não exibir quadro de informação"
L.SpamBlockNoHudMap			= "Não mostrar mapas HudMap (heads up display Map)"
L.SpamBlockNoCountdowns		= "Não tocar sons de contagem regressiva"
L.SpamBlockNoIconRestore	= "Não guardar estado dos ícones e restaura-los ao fim do combate"
L.SpamBlockNoRangeRestore	= "Não restaurar o quadro de distancia para o estado anterior ( show/hide ) quando a mod pedir 'hide'"


-- Tab: Spam Filter
L.Panel_SpamFilter			= "Filtros global e de spam"
L.Area_SpamFilter			= "Opções do filtro global"
L.DontShowFarWarnings		= "Não exibir anúncios/temporizadores para eventos que estão longe"
L.StripServerName			= "Tira com nome do reino em avisos e temporizadores"

L.Area_SpecFilter			= "Opções de especialização"
L.FilterTankSpec			= "Filtrar mensagens designadas para tank role quando não for tank. (Nota: Desabilitar esta função não é recomendado para a maioria dos usuários já que avisos de 'taunt' ( insultos ) estão habilitados por definição.)"
L.FilterInterrupts			= "Filtrar avisos para habilidades passivas de cortes ( interrupts ) se o alvo não for o seu target ou focus ( Não se aplica para magias criticas que resultaram em derrota caso não seja interrompida)"
L.FilterDispels				= "Filtrar avisos para magias dissipáveis se a seu dissipar estiver em recarga."
L.FilterCrowdControl		= "Filtrar anúncios para controle de multidão com base em interrupções se o seu controle de multidão estiver em recarga."

L.Area_PullTimer			= "Opções de filtros de puxada, pausa, & temporizador customizados"
L.DontShowPTNoID			= "Bloquear o temporizador de Puxada se não foi enviado na mesma zona que você"
L.DontShowPT				= "Não exibir a barra de puxada"
L.DontShowPTText			= "Não exibir texto de anúncio do temporizador de puxada"
L.DontPlayPTCountdown		= "Não tocar o áudio da contagem regressiva de puxada/customizado"
L.PT_Threshold				= "Não exibir o texto da contagem regressiva de puxada/customizado acima de: %d"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "Bloquear funcionalidades da Blizzard"
--Toast
L.Area_HideToast					= "Desativar avisos da Blizzard (pop-ups)"
L.HideGarrisonUpdates				= "Ocultar avisos de seguidores durante combate contra chefes"
L.HideGuildChallengeUpdates			= "Ocultar avisos de desafios de guilda durante combate contra chefes"
L.HideBossKill						= "Ocultar avisos de morte de chefes"--NYI
L.HideVaultUnlock					= "Ocultar avisos de desbloqueio do cofre"--NYI
--Cut Scenes
L.Area_Cinematics					= "Bloquear cenas cinemáticas no jogo"
L.DuringFight						= "Bloquear cenas de combate durante encontros com chefes"--uses explicite IsEncounterInProgress check
L.InstanceAnywhere					= "Bloquear cenas não relacionadas a combate em qualquer lugar dentro de uma masmorra ou raide"
L.NonInstanceAnywhere				= "PERIGO: Bloquear cenas em áreas externas de mundo aberto (NÃO recomendado)"
L.OnlyAfterSeen						= "Apenas bloquear cenas depois de terem sido vistas pelo menos uma vez (ALTAMENTE recomendado, para experiência de história como pretendido pelo menos uma vez)"
--Sound
L.Area_Sound						= "Bloquear sons no jogo"
L.DisableSFX						= "Desativar efeitos sonoros durante combate contra chefes"
L.DisableAmbiance					= "Desativar ambiente sonoro durante combate contra chefes"
L.DisableMusic						= "Desativar música durante combate contra chefes (Nota: Se ativado, a música personalizada do chefe não será reproduzida se estiver ativada nos sons de evento)"
--Other
L.Area_HideBlizzard					= "Desativar e ocultar outras inconveniências da Blizzard"
L.HideBossEmoteFrame				= "Ocultar quadro de emotes de chefes de raide durante combate contra chefes"
L.HideWatchFrame					= "Ocultar quadro de acompanhamento (objetivos) durante combate contra chefes se nenhum feito estiver sendo rastreado e se não estiver em um Mítico+"
L.HideQuestTooltips					= "Ocultar objetivos de missões dos tooltips durante combate contra chefes"--Currently hidden (NYI)
L.HideTooltips						= "Ocultar completamente os tooltips durante lutas contra chefes"

L.DisableSFX				= "Desativa o canal de efeitos sonoros durante lutas contra chefes"
L.DisableCinematics			= "Esconder as cinematics in-game"
L.AfterFirst				= "Depois que o vídeo for assistido uma vez"

L.Panel_ExtraFeatures		= "Funcionalidades extra"
L.Area_ChatAlerts			= "Opções de alerta do Chat"
L.RoleSpecAlert				= "Exibir mensagem de alerta quando sua especialização de saque não corresponder à sua especialização atual ao entrar na raide"
L.CheckGear					= "Envia um mensagem de alerta quando o seu ilvl equipado for muito menor do que o ilvl nas bolsas(40+)"
L.WorldBossAlert			= "Exibir mensagem de alerta quando um chefe do mundo possivelmente for atacado no seu reino por membros da sua guilda ou amigos (inaccurate if sender is CRZed)"
L.Area_SoundAlerts			= "Opções de som de alerta"
L.LFDEnhance				= "Tocar o som de TodosProntos para checagem de papéis &amp; CB/LDG no canal de áudio principal(I.E. sons funcionam mesmo que os efeitos sonoros estejam desligados e são geralmente mais altos)"
L.WorldBossNearAlert		= "Tocar o som de TodosProntos quando chefes do mundo perto de você que você precisa estiverem sendo atacados (Sobrepõe opção específica de chefe)"
L.AFKHealthWarning			= "Tocar som de alerta quando você estiver perdendo vida enquanto estiver LDT"
L.Area_AutoLogging			= "Opções de relatórios automáticos"
L.AutologBosses				= "Gravar automaticamente o relatório de encontro com os chefes utilizando o relatório de combate da Blizzard(Requer que seja usado /dbm pull antes do chefe <a href=\"http://www.warcraftlogs.com\">|cff3588ffwarcraftlogs.com|r</a> compatibilidade)"
L.AdvancedAutologBosses		= "Gravar automaticamente o encontro com o chefe utilizando o Transcritor"
L.LogOnlyNonTrivial			= "Só gravar encontros com chefes de raide (exclui Localizador de Raides/Grupos/Cenários)"
L.Area_3rdParty				= "Opções de addons de terceiros"
L.oRA3AnnounceConsumables	= "Anunciar a verificação dos consumíveis oRA3 no início do combate"
L.Area_Invite				= "Opções de convite"
L.AutoAcceptFriendInvite	= "Aceitar convites de amigos automaticamente"
L.AutoAcceptGuildInvite		= "Aceitar convites de membros da guilda automaticamente"
L.Area_Advanced				= "Opções avançadas"
L.FakeBW					= "Fingir ser BigWigs em checagens de versão ao invés de ser DBM (útil para guildas que forçam o uso de BigWigs)"

L.Panel_Profile				= "Perfil"
L.Area_CreateProfile		= "Criação de perfil"
L.EnterProfileName			= "Entre com o nome do perfil"
L.CreateProfile				= "Criar perfil para opções do núcleo do BDM"
L.Area_ApplyProfile			= "Definir o perfil ativo para o núcleo do DBM"
L.SelectProfileToApply		= "Selecionar o perfil a aplicar"
L.Area_CopyProfile			= "Copiar o perfil de opções do núcleo do DBM"
L.SelectProfileToCopy		= "Escolha o perfil à ser copiado"
L.Area_DeleteProfile		= "Remover o perfil de opções do núcleo do DBM"
L.SelectProfileToDelete		= "Escolha o perfil à ser removido"
L.Area_DualProfile			= "Opções de perfil da mod de chefes"
L.DualProfile				= "Habilite suporte para outras mods de chefes de acordo com a especialização. (O gerenciamento de perfis de mods de chefes é feito da tela de mods de chefes carregados)"

L.Area_ModProfile			= "Copia as preferencias da mod para outros personagens/ especializações ou deleta a customização efetuada"
L.ModAllReset				= "Reseta todas as opções da mod"
L.ModAllStatReset			= "Reseta todos os stats da mod"
L.SelectModProfileCopy		= "Copia todas as preferencias de"
L.SelectModProfileCopySound	= "Copia apenas as preferencias sonoras de"
L.SelectModProfileDelete	= "Apaga as opções da mod de"


-- Misc
L.FontType					= "Escolha fonte"
L.FontStyle					= "Bandeira de fonte (flags)"
L.FontColor					= "Cor da fonte"
L.FontShadow				= "Sombra da fonte"
L.FontSize					= "Tamanho da fonte: %d"

L.FontHeight	= 16
