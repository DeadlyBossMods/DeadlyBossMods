if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Traducido por "
L.TranslationBy 	= "Orden (ordentradus@gmail.com)"
L.Website					= "Visita nuestros foros de debate y asistencia técnica en |cFF73C2FBwww.deadlybossmods.com|r."
L.WebsiteButton				= "Foro"

L.OTabBosses	= "Jefes"
L.OTabOptions	= GAMEOPTIONS_MENU

L.TabCategory_Options	 	= "Opciones generales"
L.TabCategory_OTHER    		= "Otros módulos"

L.BossModLoaded 	= "Estadísticas de %s"
L.BossModLoad_now 	= [[Este módulo no está cargado. 
Se cargará al entrar en la estancia. 
También puedes hacer clic en el botón para cargar el módulo manualmente.]]

L.PosX = 'Posición X'
L.PosY = 'Posición Y'

L.MoveMe 		= 'Posición'
L.Button_OK 		= 'Aceptar'
L.Button_Cancel 	= 'Cancelar'
L.Button_LoadMod 	= 'Cargar módulo'
L.Mod_Enabled		= "Habilitar módulo"
L.Mod_Reset		= "Cargar opciones por defecto"
L.Reset 		= "Restaurar"

L.Enable  		= ENABLE
L.Disable		= DISABLE

L.NoSound		= "Sin sonido"

L.IconsInUse	= "Iconos usados por este módulo"

-- Tab: Boss Statistics
L.BossStatistics	= "Estadísticas"
L.Statistic_Kills	= "Victorias:"
L.Statistic_Wipes	= "Derrotas:"
L.Statistic_Incompletes		= "Inacabados:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill	= "Mejor victoria:"
L.Statistic_BestRank		= "Mejor rango:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Core Options
L.General 					= "Opciones generales de DBM"
L.EnableMiniMapIcon			= "Mostrar botón junto al minimapa"
L.UseSoundChannel			= "Canal de audio para alertas"
L.UseMasterChannel			= "Canal de audio principal"
L.UseDialogChannel			= "Canal de audio de diálogo"
L.UseSFXChannel				= "Canal de audio de efectos de sonido"
L.Latency_Text				= "Latencia máxima para sincronización: %d"

L.ModelOptions				= "Opciones del visualizador de modelos 3D"
L.EnableModels				= "Mostrar modelos 3D en opciones de jefe"
L.ModelSoundOptions			= "Sonido"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.Button_RangeFrame			= "Mostrar/ocultar\nmarco de distancia"
L.Button_InfoFrame			= "Mostrar/ocultar\nmarco de información"
L.Button_TestBars			= "Comprobar barras"
L.Button_ResetInfoRange		= "Restaurar posiciones por defecto"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Avisos de banda"
L.RaidWarning_Header		= "Opciones de avisos de banda"
L.RaidWarnColors 			= "Colores de avisos de banda"
L.RaidWarnColor_1 			= "Color 1"
L.RaidWarnColor_2 			= "Color 2"
L.RaidWarnColor_3		 	= "Color 3"
L.RaidWarnColor_4 			= "Color 4"
L.InfoRaidWarning			= [[Puedes especificar la posición y colores del marco de avisos de banda. 
Este marco se usa para mensajes como "Jugador X afectado por Y".]]
L.ColorResetted 			= "Se ha reiniciado la configuración de colores de este campo."
L.ShowWarningsInChat 		= "Mostrar avisos en el chat"
L.ShowFakedRaidWarnings 	= "Mostrar avisos como avisos de banda"
L.WarningIconLeft 			= "Mostrar iconos a la izquierda"
L.WarningIconRight 			= "Mostrar iconos a la derecha"
L.WarningIconChat 			= "Mostrar iconos en el chat"
L.WarningAlphabetical		= "Ordenar nombres alfabéticamente"
L.Warn_FontType				= "Fuente"
L.Warn_FontStyle			= "Contorno"
L.Warn_FontShadow			= "Sombra"
L.Warn_FontSize				= "Tamaño: %d"
L.Warn_Duration				= "Duración: %d s"
L.None						= "Ninguno"
L.Outline					= "Contorno"
L.ThickOutline				= "Contorno grueso"
L.MonochromeOutline			= "Contorno monocromo"
L.MonochromeThickOutline	= "Contorno monocromo grueso"
L.RaidWarnSound				= "Sonido de avisos de banda"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Mensajes generales"
L.CoreMessages				= "Opciones de mensajes del módulo general"
L.ShowPizzaMessage 			= "Mostrar avisos de temporizadores en el chat"
L.ShowAllVersions	 		= "Mostrar versión de DBM de cada miembro del grupo en el chat al hacer comprobaciones de versión. Si se deshabilita seguirá mostrando quién lo tiene desactualizado."
L.CombatMessages			= "Opciones de mensajes de combate"
L.ShowEngageMessage 		= "Mostrar mensajes de inicio de encuentro en el chat"
L.ShowDefeatMessage 		= "Mostrar mensajes de victoria y derrota en el chat"
L.ShowGuildMessages 		= "Mostrar mensajes de inicio de encuentro, victoria y derrota de hermandad en el chat"
L.WhisperMessages			= "Opciones de susurros"
L.AutoRespond 				= "Responder automáticamente a susurros en encuentro"
L.EnableStatus 				= "Responder automáticamente a susurros de 'estado'"
L.WhisperStats 				= "Incluir estadísticas de victoria y derrota en las respuestas automáticas a susurros"
L.DisableStatusWhisper 		= "Desactivar susurros automáticos de estado para todo el grupo (requiere ser el líder). Solo se aplica a bandas en dificultad normal, heroica y mítica, y a mazmorras en dificultad mítica y desafío."

-- Tab: Barsetup
L.BarSetup					= "Configuración de barras"
L.BarTexture				= "Textura de barras"
L.BarStyle					= "Estilo de barras"
L.BarDBM					= "DBM (con animaciones)"
L.BarSimple					= "Simple (sin animaciones)"
L.BarStartColor				= "Color inicial"
L.BarEndColor 				= "Color final"
L.Bar_Font					= "Fuente del texto"
L.Bar_FontSize				= "Tamaño del texto: %d"
L.Bar_FontStyle				= "Contorno del texto"
L.Bar_Height				= "Altura de barras: %d"
L.Slider_BarOffSetX 		= "Posición X: %d"
L.Slider_BarOffSetY 		= "Posición Y: %d"
L.Slider_BarWidth 			= "Ancho de barras: %d"
L.Slider_BarScale 			= "Escala de barras: %0.2f"
--Types
L.BarStartColorAdd			= "Color inicial (esbirros)"
L.BarEndColorAdd			= "Color final (esbirros)"
L.BarStartColorAOE			= "Color inicial (áreas)"
L.BarEndColorAOE			= "Color final (áreas)"
L.BarStartColorDebuff		= "Color inicial (dirigido)"
L.BarEndColorDebuff			= "Color final (dirigido)"
L.BarStartColorInterrupt	= "Color inicial (cortar)"
L.BarEndColorInterrupt		= "Color final (cortar)"
L.BarStartColorRole			= "Color inicial (rol)"
L.BarEndColorRole			= "Color final (rol)"
L.BarStartColorPhase		= "Color inicial (fase)"
L.BarEndColorPhase			= "Color final (fase)"
L.BarStartColorUI			= "Color inicial (usuario)"
L.BarEndColorUI				= "Color final (usuario)"
--Type 7 options
L.Bar7Header				= "Opciones de barras de usuario"
L.Bar7ForceLarge			= "Usar siempre barras grandes"
L.Bar7CustomInline			= "Usar icono '!' personalizado"
L.Bar7Footer				= "(la barra de muestra no se\nactualiza en vivo)"

-- Tab: Timers
L.AreaTitle_BarColors		= "Colores de barras por tipo de temporizador"
L.AreaTitle_BarSetup		= "Opciones generales de barras"
L.AreaTitle_BarSetupSmall 	= "Opciones de barras pequeñas"
L.AreaTitle_BarSetupHuge	= "Opciones de barras grandes"
L.EnableHugeBar 			= "Habilitar barra grande (o 'Barra 2')"
L.BarIconLeft 				= "Icono izquierdo"
L.BarIconRight 				= "Icono derecho"
L.ExpandUpwards				= "Expandir arriba"
L.FillUpBars				= "Rellenar"
L.ClickThrough				= "Deshabilitar clic en barras"
L.Bar_Decimal				= "Mostrar decimales bajo: %d s"
L.Bar_DBMOnly				= "Estas opciones solo funcionan con el estilo de barras DBM"
L.Bar_EnlargeTime			= "Agrandar barras bajo tiempo: %d s"
L.Bar_EnlargePercent		= "Agrandar barras bajo %%: %0.1f%%"
L.BarSpark					= "Destello de barras"
L.BarFlash					= "Iluminar barras a punto de expirar"
L.BarSort					= "Ordenar por tiempo restante"
L.BarColorByType			= "Color por tipo"
L.BarInlineIcons			= "Iconos en barras"
L.ShortTimerText			= "Texto de temporizador breve"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Avisos especiales"
L.Area_SpecWarn				= "Opciones de avisos especiales"
L.SpecWarn_ClassColor		= "Usar colores de clase para avisos especiales"
L.ShowSWarningsInChat 		= "Mostrar avisos especiales en el chat"
L.SWarnNameInNote			= "Usar Destello 5 si una nota personalizada contiene tu nombre"
L.SpecWarn_FlashFrame		= "Destello de pantalla para avisos especiales"
L.SpecWarn_FlashFrameRepeat	= "Repetir %d veces (si está habilitado)"
L.SpecWarn_Font				= "Fuente de avisos especiales"
L.SpecWarn_FontSize			= "Tamaño: %d"
L.SpecWarn_FontColor		= "Texto"
L.SpecWarn_FontType			= "Fuente"
L.SpecWarn_FlashRepeat		= "Repetir destello"
L.SpecWarn_FlashColor		= "Destello %d"
L.SpecWarn_FlashDur			= "Duración: %0.1f s"
L.SpecWarn_FlashAlpha		= "Transparencia: %0.1f"
L.SpecWarn_DemoButton		= "Mostrar ejemplo"
L.SpecWarn_MoveMe			= "Posición"
L.SpecWarn_ResetMe			= "Restaurar valores por defecto"
L.SpecialWarnSound			= "Sonido por defecto para avisos especiales que te afecten a ti"
L.SpecialWarnSound2			= "Sonido por defecto para avisos especiales que afecten a todos"
L.SpecialWarnSound3			= "Sonido por defecto para avisos especiales MUY importantes"
L.SpecialWarnSound4			= "Sonido por defecto para avisos especiales de movimiento"
L.SpecialWarnSound5			= "Sonido por defecto para avisos especiales con notas que te mencionen"

-- Tab: Heads Up Display Frame
L.Panel_HUD					= "Indicadores"
L.Area_HUDOptions			= "Opciones de indicadores"
L.HUDColorOverride			= "Ignorar colores del módulo"
L.HUDSizeOverride			= "Ignorar tamaños del módulo"
L.HUDAlphaOverride			= "Ignorar transparencias del módulo"
L.HUDTextureOverride		= "Ignorar texturas del módulo (no se aplica a las opciones de textura de iconos)"
L.HUDColorSelect			= "Indicador %d"
L.HUDTextureSelect1			= "Textura del indicador principal"
L.HUDTextureSelect2			= "Textura del indicador secundario"
L.HUDTextureSelect3			= "Textura del indicador terciario"
L.HUDTextureSelect4			= "Textura del indicador de ubicación objetivo"
L.HUDSizeSlider				= "Radio: %0.1f"
L.HUDAlphaSlider			= "Transparencia: %0.1f"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Alertas de voz"
L.Area_VoiceSelection		= "Selección de voces"
L.CountdownVoice			= "Voz principal para cuentas atrás"
L.CountdownVoice2			= "Voz secundaria para cuentas atrás"
L.CountdownVoice3			= "Voz terciaria para cuentas atrás"
L.VoicePackChoice			= "Paquete de voz para alertas de voz"
L.Area_CountdownOptions		= "Opciones de cuenta atrás"
L.ShowCountdownText			= "Mostrar texto de cuenta atrás junto a la voz principal"
L.Area_VoicePackOptions		= "Opciones de paquetes de voz (archivos de terceros)"
L.SpecWarn_NoSoundsWVoice	= "Filtrar sonidos de avisos especiales para avisos que también tienen alertas de voz"
L.SWFNever					= "Nunca"
L.SWFDefaultOnly			= "Cuando los avisos especiales usen sonidos por defecto"
L.SWFAll					= "Cuando los avisos especiales usen cualquier sonido"
L.SpecWarn_AlwaysVoice		= "Reproducir siempre todas las alertas de voz (ignora las opciones de jefe; útil para líderes de banda)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?

-- Tab: HealthFrame
L.Panel_HPFrame				= "Barras de vida"
L.Area_HPFrame				= "Opciones de barras de vida"
L.HP_Enabled				= "Mostrar siempre las barras de vida (ignora las opciones de jefe)"
L.HP_GrowUpwards			= "Expandir barras de vida hacia arriba"
L.HP_ShowDemo				= "Mostrar barras de vida"
L.BarWidth					= "Ancho: %d"

-- Tab: Global Filter
L.Panel_SpamFilter			= "Filtros globales"
L.Area_SpamFilter_Outgoing	= "Opciones de filtros globales"
L.SpamBlockNoShowAnnounce	= "Deshabilitar avisos y los sonidos asociados"
L.SpamBlockNoSpecWarn		= "Deshabilitar avisos especiales y los sonidos asociados"
L.SpamBlockNoShowTimers		= "Deshabilitar temporizadores de módulos"
L.SpamBlockNoShowUTimers	= "Deshabilitar temporizadores de usuarios"
L.SpamBlockNoSetIcon		= "Deshabilitar colocación automática de marcadores"
L.SpamBlockNoRangeFrame		= "Deshabilitar marcos de distancia"
L.SpamBlockNoInfoFrame		= "Deshabilitar marcos de información"
L.SpamBlockNoHudMap			= "Deshabilitar indicadores"
L.SpamBlockNoHealthFrame	= "Deshabilitar barras de vida"
L.SpamBlockNoCountdowns		= "Deshabilitar sonidos de cuenta atrás"
L.SpamBlockNoYells			= "Deshabilitar envío automático de mensajes en el chat"
L.SpamBlockNoNoteSync		= "Deshabilitar notas compartidas"

L.Area_Restore				= "Opciones de restauración"
L.SpamBlockNoIconRestore	= "Restaurar iconos al acabar el encuentro"
L.SpamBlockNoRangeRestore	= "Mantener los marcos de distancia cuando los módulos intenten esconderlos"

-- Tab: Spam Filter
L.Panel_SpamFilter			= "Filtros de avisos"
L.Area_SpamFilter			= "Opciones de filtros de avisos"
L.DontShowFarWarnings		= "Deshabilitar anuncios y temporizadores de eventos que estén demasiado lejos"
L.StripServerName			= "Omitir nombre del reino en avisos y temporizadores"
L.SpamBlockBossWhispers		= "Bloquear susurros automáticos de estado de encuentro"
L.BlockVersionUpdateNotice	= "Mostrar notificaciones de actualización en el chat en lugar de en ventana emergente"

L.Area_SpecFilter			= "Opciones de filtros de rol"
L.FilterTankSpec			= "Deshabilitar avisos designados para tanques cuando no sea tu rol"
L.FilterInterrupts			= "Deshabilitar avisos de facultades interrumpibles si no provienen de tu objetivo actual o enfocado (no se aplica a facultades cuya interrupción es casi obligatoria)"
L.FilterInterruptNoteName	= "Deshabilitar avisos de facultades interrumpibles con orden de interrupciones si el aviso no contiene tu nombre en la nota personalizada"
L.FilterDispels				= "Deshabilitar avisos de facultades disipables si tu disipación no está disponible"
L.FilterSelfHud				= "Excluirte de los indicadores (los indicadores de distancia no te tendrán en cuenta)"

L.Area_PullTimer			= "Opciones de filtros de inicio de encuentro, descanso, combate y personalizados"
L.DontShowPTNoID			= "Deshabilitar temporizadores de inicio de encuentro que se inicien en zonas distintas"
L.DontShowPT				= "Deshabilitar barras de temporizadores de inicio de encuentro y descanso"
L.DontShowPTText			= "Deshabilitar anuncios de temporizadores de inicio de encuentro y descanso"
L.DontPlayPTCountdown		= "Deshabilitar sonidos de cuenta atrás de temporizadores de inicio de encuentro, descanso, combate y personalizados"
L.DontShowPTCountdownText	= "Deshabilitar texto de cuenta atrás de temporizadores de inicio de encuentro, descanso, combate y personalizados"
L.PT_Threshold				= "Ocultar temporizadores por encima de: %d s"

-- Tab: Blizzard Disable & Hide
L.Panel_HideBlizzard		= "Interfaz y funciones de Blizzard"
L.Area_HideBlizzard			= "Opciones de interfaz y funciones de Blizzard"
L.HideBossEmoteFrame		= "Deshabilitar avisos de encuentro de mazmorra y banda"
L.HideWatchFrame			= "Deshabilitar seguimiento de objetivos (misiones, logros, etc.) en encuentros si no se está siguiendo un logro relacionado. En modo desafío muestra el tiempo restante."
L.HideGarrisonUpdates		= "Deshabilitar botón de ciudadela en encuentros"
L.HideGuildChallengeUpdates	= "Deshabilitar botón de desafíos de hermandad en encuentros"
L.HideTooltips				= "Deshabilitar descripciones en encuentros"
L.DisableSFX				= "Deshabilitar el canal de efectos de sonido en encuentros"
L.HideApplicantAlerts		= "Deshabilitar alertas de candidatos en grupos ya formados"
L.HideApplicantAlertsFull	= "Si el grupo está completo"
L.HideApplicantAlertsNotL	= "Si no eres el líder del grupo (aplica el filtro de grupo completo si eres el líder)"
L.SpamBlockSayYell			= "Deshabilitar bocadillos de chat"
L.DisableCinematics			= "Deshabilitar cinemáticas"
L.AfterFirst				= "Tras ver la cinemática por primera vez"
L.Always					= ALWAYS

-- Tab: Extra Features
L.Panel_ExtraFeatures		= "Funciones adicionales"
--
L.Area_ChatAlerts			= "Opciones de alertas de texto"
L.RoleSpecAlert				= "Mostrar mensaje de alerta al unirte a una banda cuando tu especialización de botín no coincida con tu especialización actual"
L.CheckGear					= "Mostrar mensaje de alerta al iniciar un encuentro cuando tu nivel de equipo sea como mínimo 40 niveles menor que el de tu inventario o no tengas equipada un arma principal"
L.WorldBossAlert			= "Mostrar mensaje de alerta cuando un amigo o miembro de hermandad inicie un encuentro contra un jefe de mundo (impreciso si el jugador en combate está en otro reino)"
--
L.Area_SoundAlerts			= "Opciones de alertas de sonido e iluminación del icono del juego"
L.LFDEnhance				= "Reproducir sonido de comprobación de banda e iluminar icono del juego para avisos del buscador de mazmorra/banda/grupo y campos de batalla por el canal de audio general o de diálogo (en otras palabras, reproduce el sonido aunque el canal de efectos de sonido esté desactivado, y en general suena más alto)"
L.WorldBossNearAlert		= "Reproducir sonido de comprobación de banda e iluminar icono del juego cuando haya un jefe de mundo cerca"
L.RLReadyCheckSound			= "Reproducir sonido por el canal de audio general o de diálogo e iluminar el icono del juego cuando se haga una comprobación de banda"
L.AFKHealthWarning			= "Reproducir sonido de alerta e iluminar el icono del juego si tu salud se reduce mientras estás ausente"
L.AutoReplySound			= "Reproducir sonido de alerta e iluminar el icono del juego al recibir respuestas automáticas de DBM por susurro"
--
L.TimerGeneral 				= "Opciones de temporizadores"
L.SKT_Enabled				= "Mostrar temporizador para batir el récord de victoria del encuentro actual"
L.CRT_Enabled				= "Mostrar temporizador para la siguiente resurrección en combate"
L.ShowRespawn				= "Mostrar temporizador para la reaparición de jefe tras cada derrota"
L.ShowQueuePop				= "Mostrar temporizador para eltiempo restante para aceptar avisos del buscador"
--
L.Area_AutoLogging			= "Opciones del registro automático"
L.AutologBosses				= "Grabar encuentros automáticamente con el registro de combate de Blizzard (usa '/dbm pull' antes de iniciar un encuentro para comenzar a grabar antes, de forma que tenga en cuenta la toma de pociones y otras acciones)"
L.AdvancedAutologBosses		= "Grabar encuentros automáticamente con Transcriptor"
L.LogOnlyRaidBosses			= "Grabar solo encuentros de jefe de banda de la expansión actual (excluye el buscador de bandas)"
--
L.Area_3rdParty				= "Opciones de addons de terceros"
L.ShowBBOnCombatStart		= "Realizar comprobación de beneficios de Big Brother al iniciar un encuentro"
L.BigBrotherAnnounceToRaid	= "Anunciar resultados de Big Brother en el chat de banda"
L.Area_Invite				= "Opciones de invitación"
L.AutoAcceptFriendInvite	= "Aceptar automáticamente invitaciones a grupos de amigos"
L.AutoAcceptGuildInvite		= "Aceptar automáticamente invitaciones a grupos de miembros de la hermandad"
L.Area_Advanced				= "Opciones avanzadas"
L.FakeBW					= "Camuflar DBM como si fuera BigWigs en comprobaciones de versión (útil para hermandades que obligan a usar BigWigs)"
L.AITimer					= "Generar temporizadores automáticamente para encuentros no vistos anteriormente mediante la IA de temporizadores interna de DBM (útil para probar jefes por primera vez en el RPP). No funciona correctamente en encuentros con múltiples esbirros que comparten la misma facultad."
L.AutoCorrectTimer			= "Corregir automáticamente temporizadores que son demasiado largos (útil para contenido nuevo para el que DBM todavía no está actualizado). Nota: esta opción puede empeorar algunos temporizadores si el encuentro los reinicia en cambios de fase para los que DBM todavía no está preparado."

L.PizzaTimer_Headline 		= 'Crear una cuenta atrás para la pizza'
L.PizzaTimer_Title			= 'Nombre (ej. "¡Pizza!")'
L.PizzaTimer_Hours 			= "Horas"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Seg"
L.PizzaTimer_ButtonStart 	= "Iniciar temporizador"
L.PizzaTimer_BroadCast		= "Transmitir a la banda"

L.Panel_Profile				= "Perfiles"
L.Area_CreateProfile		= "Creación de perfiles para opciones generales de DBM"
L.EnterProfileName			= "Nombre del perfil"
L.CreateProfile				= "Crear con configuración por defecto"
L.Area_ApplyProfile			= "Perfil activo de opciones generales de DBM"
L.SelectProfileToApply		= "Perfil activo"
L.Area_CopyProfile			= "Copiar perfil de opciones generales de DBM"
L.SelectProfileToCopy		= "Copiar perfil"
L.Area_DeleteProfile		= "Borrar perfil de opciones generales de DBM"
L.SelectProfileToDelete		= "Borrar perfil"
L.Area_DualProfile			= "Opciones de perfil de DBM"
L.DualProfile				= "Permitir varias opciones de módulo de jefe por especialización (cada perfil se configura desde el menú de cada módulo)"

L.Area_ModProfile			= "Configuración de perfil"
L.ModAllReset				= "Restaurar configuración"
L.ModAllStatReset			= "Restaurar estadísticas"
L.SelectModProfileCopy		= "Copiar configuración de"
L.SelectModProfileCopySound	= "Copiar conf. de sonido de"
L.SelectModProfileCopyNote	= "Copiar notas de"
L.SelectModProfileDelete	= "Borrar configuración de"

-- Misc
L.FontHeight	= 16