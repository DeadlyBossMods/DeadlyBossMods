if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

if not DBM_GUI_L then DBM_GUI_L = {} end
local L = DBM_GUI_L

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Traducido por "
L.TranslationBy 			= "Saispai, Woopy"
L.Website					= "Visita nuestro canal de Discord (|cFF73C2FBhttps://discord.gg/deadlybossmods|r) y síguenos en Twitter (@deadlybossmods)."
L.WebsiteButton				= "Página web"

L.OTabBosses	= "Jefes"
L.OTabRaids		= "Bandas"
L.OTabDungeons	= "Mazmorras"
L.OTabWorld		= "Jefes del mundo"--Since there are so many world mods, enough to get their own tab
L.OTabScenarios	= "Escenarios"--Future use, will be used for scenarios and delves, likely after there are more than 2 mods (so probably 12.x or later)
L.OTabPlugins	= "Plugins"
L.OTabOptions	= "Opciones"
L.OTabAbout		= "Acerca de"

L.FOLLOWER	= "Seguidor"--i.e. the new dungeon type in 10.2.5. I haven't found a translated string yet

L.TabCategory_CURRENT_SEASON		= "Temporada actual"

L.TabCategory_OTHER    		= "Otros módulos"
L.TabCategory_AFFIXES		= "Afijos"

L.BossModLoaded 			= "Estadísticas de %s"
L.BossModLoad_now 			= [[Este módulo no está cargado.
Se cargará al entrar en la estancia.
También puedes hacer clic en el botón para cargar el módulo manualmente.]]

L.PosX 						= "Posición X"
L.PosY 						= "Posición Y"

L.MoveMe 					= "Posición"
L.Button_OK 				= "Aceptar"
L.Button_Cancel 			= "Cancelar"
L.Button_LoadMod 			= "Cargar módulo"
L.Mod_Enabled				= "Activar: %s"
L.Mod_Reset					= "Cargar opciones predeterminadas"
L.Reset 					= "Restaurar"
L.Import					= "Importar"

L.Enable					= ENABLE
L.Disable					= DISABLE

L.NoSound					= "Sin sonido"

L.IconsInUse				= "Iconos usados por este módulo"

-- Tab: Boss Statistics
L.BossStatistics			= "Estadísticas"
L.Statistic_Kills			= "Victorias:"
L.Statistic_Wipes			= "Derrotas:"
L.Statistic_Incompletes		= "Inacabados:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Mejor victoria:"
L.Statistic_BestRank		= "Mejor nivel:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Options
L.TabCategory_Options	 	= "Opciones generales"
L.Area_BasicSetup			= "Consejos básicos para configurar DBM"
L.Area_ModulesForYou		= "Guía de módulos"
L.Area_ProfilesSetup		= "Guía de uso de perfiles de DBM"
-- Panel: Core & GUI
L.Core_GUI 					= "Generales e interfaz"
L.General 					= "Opciones generales de DBM"
L.EnableMiniMapIcon			= "Mostrar botón junto al minimapa"
L.EnableCompartmentIcon	= "Mostrar botón de compartimento"
L.UseSoundChannel			= "Canal de audio para alertas"
L.UseMasterChannel			= "Canal de audio principal"
L.UseDialogChannel			= "Canal de audio de diálogo"
L.UseSFXChannel				= "Canal de audio de efectos de sonido"
L.Latency_Text				= "Latencia máx. para sincronización: %d"

L.Button_RangeFrame			= "Mostrar/ocultar\nmarco de distancia"
L.Button_InfoFrame			= "Mostrar/ocultar\nmarco de información"
L.Button_TestBars			= "Comprobar barras"
L.Button_MoveBars			= "Mover barras"
L.Button_ResetInfoRange		= "Restaurar posiciones predeterminadas"

L.ModelOptions				= "Opciones del visualizador de modelos 3D"
L.EnableModels				= "Mostrar modelos 3D en opciones de jefe"
L.ModelSoundOptions			= "Sonido"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.ResizeOptions			 	= "Tamaño de la ventana"
L.ResizeInfo				= "Puedes cambiar el tamaño de la GUI haciendo clic en la esquina inferior derecha y arrastrándola."
L.Button_ResetWindowSize	= "Restaurar tamaño"
L.Editbox_WindowWidth		= "Horizontal"
L.Editbox_WindowHeight		= "Vertical"

L.UIGroupingOptions					= "Opciones de agrupación de IU (cambiarlas requiere recargar la IU para cualquier módulo que ya esté cargado)"
L.GroupOptionsExcludeIcon			= "Excluir que las opciones 'Establecer icono activado' se agrupan por hechizo (en su lugar, se agruparán en su propia categoría 'Iconos')"
L.AutoExpandSpellGroups				= "Expandir opciones automáticamente que están agrupadas por hechizo"
L.ShowWAKeys						= "Mostrar las claves de WeakAuras junto a los nombres de los hechizos para ayudar a escribir WeakAuras usando los activadores de módulos de Jefe."
L.ShowSpellDescWhenExpanded	= "Continuar mostrando la descripción del hechizo cuando se expanden los grupos."--Might not be used
L.NoDescription						= "Esta facultad no tiene descripción."
L.CustomOptions						= "Esta categoría contiene opciones personalizadas para una facultad o evento que no tiene ningún hechizo o ID de diario propio. Estas opciones se han agrupado utilizando una identificación manual personalizada para facilitar la creación de WeakAuras."

--

-- Panel: Auto Logging
L.Panel_AutoLogging			= "Registro automático"
--Auto Logging: Logging toggles/types
L.Area_AutoLogging			= "Opciones del registro automático"
L.AutologBosses				= "Registrar encuentros automáticamente con el registro de combate de Blizzard (escribe '/dbm pull' antes de iniciar un encuentro para comenzar a grabar antes, de forma que tenga en cuenta la toma de pociones y otras acciones)"
L.AdvancedAutologBosses		= "Registrar encuentros automáticamente con Transcriptor"
--Auto Logging: Global filter Options
L.Area_AutoLoggingFilters	= "Filtros del registro automático"
L.RecordOnlyBosses			= "Registrar solo encuentros de jefe (excluye todos los combates contra enemigos que no son jefes; escribe '/dbm pull' antes de iniciar un encuentro para registrar el uso previo de pociones)"
L.DoNotLogLFG				= "No registrar grupos del buscador de mazmorras o buscador de bandas"
--
L.Area_AutoLoggingContent			= "Contenido del registro automático"
L.LogCurrentMythicRaids				= "Bandas míticos de nivel actual"--Retail Only
L.LogCurrentRaids					= "Bandas no míticas de nivel actual (heroico, normal y buscador de bandas si el filtro está desactivado)"
L.LogTWRaids						= "Bandas de Paseo en el tiempo o Tiempo de Cromi"--Retail Only
L.LogTrivialRaids					= "Bandas triviales (de bajo nivel)"
L.LogCurrentMPlus					= "Mazmorras M+ de nivel actual"--Retail Only
L.LogCurrentMythicZero				= "Mazmorras Mítica 0 de nivel actual"--Retail Only
L.LogTWDungeons						= "Mazmorras de Paseo en el tiempo o Tiempo de Cromi"--Retail Only
L.LogCurrentHeroic					= "Mazmorras heroicas de nivel actual (Nota: si estás haciendo mazmorras mediante la función de cola y deseas que se registren, desactiva el filtro 'Buscar Grupo'.)"

-- Panel: Extra Features
L.Panel_ExtraFeatures		= "Funciones adicionales"

L.Area_SoundAlerts			= "Opciones de alertas de sonido y destello del icono del juego"
L.LFDEnhance				= "Reproducir sonido de comprobación de banda y destellar icono del juego para avisos del buscador de mazmorra/banda/grupo y campos de batalla por el canal de audio general o de diálogo (en otras palabras, reproduce el sonido aunque el canal de efectos de sonido esté desactivado, y en general suena más alto)"
L.WorldBossNearAlert		= "Reproducir sonido de comprobación de banda y destellar icono del juego cuando haya un jefe del mundo cerca"
L.RLReadyCheckSound			= "Reproducir sonido por el canal de audio general o de diálogo y destellar el icono del juego cuando se haga una comprobación de banda"
L.AFKHealthWarning			= "Reproducir sonido de alerta y destellar el icono del juego si tu salud se reduce mientras estás ausente"
L.AutoReplySound			= "Reproducir sonido de alerta y destellar el icono del juego al recibir respuestas automáticas de DBM por susurro"
--
L.TimerGeneral 				= "Opciones de temporizadores"
L.SKT_Enabled				= "Mostrar temporizador para batir el récord de victoria del encuentro actual"
L.ShowRespawn				= "Mostrar temporizador para la reaparición de jefe tras cada derrota"
L.ShowQueuePop				= "Mostrar temporizador para el tiempo restante para aceptar avisos del buscador"
L.ShowBerserkWarnings		= "Mostrar anuncios a los 10/5/3/1 minutos y a los 30/10 segundos restantes en el temporizador de $spell:26662"
--
L.Area_3rdParty				= "Opciones de addons de terceros"
L.oRA3AnnounceConsumables	= "Anunciar la verificación de consumibles oRA3 al inicio del combate."
L.Area_Invite				= "Opciones de invitación"
L.AutoAcceptFriendInvite	= "Aceptar automáticamente invitaciones a grupos de amigos"
L.AutoAcceptGuildInvite		= "Aceptar automáticamente invitaciones a grupos de miembros de la hermandad"
L.Area_Advanced				= "Opciones avanzadas"
L.FakeBW					= "Camuflar DBM como si fuera BigWigs en comprobaciones de versión (útil para hermandades que obligan a utilizar BigWigs)"
L.AITimer					= "Generar temporizadores automáticamente para encuentros no vistos anteriormente mediante la IA de temporizadores interna de DBM (útil para probar jefes por primera vez en el RPP). No funciona correctamente en encuentros con múltiples esbirros que comparten la misma facultad."

-- Panel: Profiles
L.Panel_Profile				= "Perfiles"
L.Area_CreateProfile		= "Creación de perfiles para opciones generales de DBM"
L.EnterProfileName			= "Nombre del perfil"
L.CreateProfile				= "Crear con configuración predeterminada"
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
L.SelectModProfileCopySound	= "Copiar configuración de sonido de"
L.SelectModProfileCopyNote	= "Copiar notas de"
L.SelectModProfileDelete	= "Borrar configuración de"

L.Area_ImportExportProfile			= "Importar/Exportar perfiles"
L.ImportExportInfo					= "La importación sobrescribirá tu perfil actual, hazlo bajo tu propio riesgo."
L.ButtonImportProfile				= "Importar perfil"
L.ButtonExportProfile				= "Exportar perfil"

L.ImportErrorOn					= "Faltan sonidos personalizados para configurar: %s"
L.ImportVoiceMissing			= "Paquete de voz faltante: %s"

-- Tab: Alerts
L.TabCategory_Alerts	 	= "Alertas"
L.Area_SpecAnnounceConfig	= "Guía para avisos especiales"
L.Area_SpecAnnounceNotes	= "Guía para notas de avisos especiales"
L.Area_VoicePackInfo		= "Información sobre paquetes de voz de DBM"
-- Panel: Raidwarning
L.Tab_RaidWarning 			= "Avisos"
L.RaidWarning_Header		= "Opciones de avisos"
L.RaidWarnColors 			= "Colores de avisos"
L.RaidWarnColor_1 			= "Color 1"
L.RaidWarnColor_2 			= "Color 2"
L.RaidWarnColor_3		 	= "Color 3"
L.RaidWarnColor_4 			= "Color 4"
L.InfoRaidWarning			= [[Puedes especificar la posición y colores del marco de avisos de banda.
Este marco se usa para mensajes como "Jugador X afectado por Y".]]
L.ColorResetted 			= "Se ha reiniciado la configuración de colores de este campo."
L.ShowWarningsInChat 		= "Mostrar avisos en el chat"
L.WarningIconLeft 			= "Mostrar iconos a la izquierda"
L.WarningIconRight 			= "Mostrar iconos a la derecha"
L.WarningIconChat 			= "Mostrar iconos en el chat"
L.WarningAlphabetical		= "Ordenar nombres alfabéticamente"
L.Warn_Duration				= "Duración: %0.1f s"
L.None						= "Ninguno"
L.Random					= "Aleatorio"
L.Outline					= "Contorno"
L.ThickOutline				= "Contorno grueso"
L.MonochromeOutline			= "Contorno monocromo"
L.MonochromeThickOutline	= "Contorno monocromo grueso"
L.RaidWarnSound				= "Sonido de avisos"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Avisos especiales"
L.Area_SpecWarn				= "Opciones de avisos especiales"
L.SpecWarn_ClassColor		= "Utilizar colores de clase para avisos especiales"
L.ShowSWarningsInChat 		= "Mostrar avisos especiales en el chat"
L.SWarnNameInNote			= "Utilizar Destello 5 si una nota personalizada contiene tu nombre"
L.SpecialWarningIcon		= "Mostrar iconos en avisos especiales"
L.ShortTextSpellname		= "Utilizar texto abreviado cuando sea posible"
L.SpecWarn_FlashFrameRepeat	= "Repetir %d veces (si está activado)"
L.SpecWarn_Flash			= "Destello"
L.SpecWarn_Vibrate			= "Controlador de vibración"
L.SpecWarn_FlashRepeat		= "Repetir destello"
L.SpecWarn_FlashColor		= "Destello %d"
L.SpecWarn_FlashDur			= "Duración: %0.1f s"
L.SpecWarn_FlashAlpha		= "Transparencia: %0.1f"
L.SpecWarn_DemoButton		= "Mostrar ejemplo"
L.SpecWarn_ResetMe			= "Restaurar valores predeterminados"
L.SpecialWarnSoundOption	= "Sonido predeterminado"
L.SpecialWarnHeader1		= "Tipo 1: Opciones para avisos de prioridad normal relevantes a ti o a tus acciones"
L.SpecialWarnHeader2		= "Tipo 2: Opciones para avisos de prioridad normal relevantes a todos los jugadores"
L.SpecialWarnHeader3		= "Tipo 3: Opciones para avisos de alta prioridad"
L.SpecialWarnHeader4		= "Tipo 4: Opciones para avisos especiales de correr con alta prioridad"
L.SpecialWarnHeader5		= "Tipo 5: Opciones para avisos con notas que contienen tu nombre"

-- Panel: Generalwarnings
L.Tab_GeneralMessages 		= "Mensajes generales"
L.SelectChatFrameArea		= "Opciones de marco de chat"
L.SelectChatFrameButton		= "Seleccionar marco de chat"
L.SelectChatFrameInfoIdle	= "Los mensajes se muestran en %s."
L.SelectChatFrameDefaultName	= "el marco de chat predeterminado"
L.SelectChatFrameInfoDone		= "Los mensajes se mostrarán en este marco de chat."
L.SelectChatFrameInfoSelect		= "Haz clic en un marco de chat para seleccionarlo."
L.SelectChatFrameInfoSelectNow	= "Haz clic para seleccionar %s."
L.CoreMessages				= "Opciones de mensajes del módulo general"
L.ShowPizzaMessage 			= "Mostrar avisos de temporizadores en el chat"
L.ShowAllVersions	 		= "Mostrar versión de DBM de cada miembro del grupo en el chat al hacer comprobaciones de versión. Si se desactiva seguirá mostrando quién lo tiene desactualizado."
L.ShowReminders				= "Mostrar recordatorios de módulos que faltan, que están desactivados, que hayan recibido cambios, que están desactualizados o que están silenciados."

L.CombatMessages			= "Opciones de mensajes de combate"
L.ShowEngageMessage 		= "Mostrar mensajes de inicio de encuentro en el chat"
L.ShowDefeatMessage 		= "Mostrar mensajes de victoria y derrota en el chat"
L.ShowGuildMessages 		= "Mostrar mensajes de inicio de encuentro, victoria y derrota de banda de hermandad en el chat"
L.ShowGuildMessagesPlus		= "Mostrar también mensajes de inicio, victoria y derrota de Mítica+ de grupos de hermandad (requiere que la opción anterior esté activada)"

L.Area_ChatAlerts			= "Opciones de alertas adicionales"
L.RoleSpecAlert				= "Mostrar mensaje de alerta al unirte a una banda cuando tu especialización de botín no coincida con tu especialización actual"
L.CheckGear					= "Mostrar mensaje de alerta al iniciar un encuentro cuando tu nivel de equipo sea como mínimo 40 niveles menor que el de tu inventario o no tengas equipada un arma principal"
L.WorldBossAlert			= "Mostrar mensaje de alerta cuando un amigo o miembro de hermandad inicie un encuentro contra un jefe del mundo (impreciso si el jugador en combate está en otro reino)"
L.WorldBuffAlert			= "Mostrar mensaje de alerta y temporizador cuando un beneficio del mundo empieza en tu reino"

L.Area_BugAlerts			= "Opciones de alertas de informes de fallos"
L.BadTimerAlert				= "Mostrar mensaje en el chat cuando DBM detecte un temporizador erróneo"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Alertas de voz"
L.Area_VoiceSelection		= "Selección de voces"
L.CountdownVoice			= "Voz principal para cuentas atrás"
L.CountdownVoice2			= "Voz secundaria para cuentas atrás"
L.CountdownVoice3			= "Voz terciaria para cuentas atrás"
L.PullVoice					= "Sonido de temporizador de inicio de encuentro"
L.VoicePackChoice			= "Paquete de voz para alertas de voz"
L.MissingVoicePack			= "Paquete de voz faltante (%s)"
L.Area_CountdownOptions		= "Opciones de cuenta atrás"
L.Area_VoicePackReplace		= "Opciones de reemplazo de paquetes de voz (que suenan paquetes de voz, cuando están activados, silencian y reemplazan)"
L.VPReplaceNote				= "Nota: Los paquetes de voz nunca cambian ni eliminan los sonidos de avisos.\nSimplemente se silencian cuando el paquete de voz los reemplaza."
L.ReplacesAnnounce			= "Reemplazar los sonidos de anuncio (Nota: muy pocos usan paquetes de voz, excepto para cambios de fase y bichos.)"
L.ReplacesSA1				= "Reemplazar los sonidos del anuncio especial 1 (personal también conocido como 'pvpflag' que no son de correr)"
L.ReplacesSA2				= "Reemplazar los sonidos del anuncio especial 2 (todos también conocidos como 'cuidado')"
L.ReplacesSA3				= "Reemplazar los sonidos del anuncio especial 3 (alta prioridad también conocido como 'airhorn')"
L.ReplacesSA4				= "Reemplazar los sonidos del anuncio especial 4 (correr de alta prioridad)"
L.ReplacesGTFO				= "Reemplazar los sonidos de correr del anuncio especial"
L.ReplacesCustom			= "Reemplazar los sonidos de anuncios especiales personalizados establecidos por el usuario (no recomendado)"
L.Area_VoicePackAdvOptions	= "Opciones avanzadas del paquete de voz"
L.SpecWarn_AlwaysVoice		= "Reproducir siempre todas las alertas de voz (ignora las opciones de jefe; útil para líderes de banda)"
L.VPDontMuteSounds			= "Desactivar el silenciamiento de los sonidos de alerta habituales cuando utiliza el paquete de voz (utilícelo solo si deseas escuchar AMBOS durante las alertas)"
L.Area_VPLearnMore			= "Obten más información sobre los paquetes de voz y cómo utilizar estas opciones"
L.VPLearnMore				= "|cFF73C2FBhttps://github.com/DeadlyBossMods/DBM-Retail/wiki/%5BGuide%5D-DBM-&-Voicepacks#2022-update|r"
L.Area_BrowseOtherVP		= "Explora otros paquetes de voz en Curse"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "Explora otros paquetes de voz de cuenta atrás en Curse"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Panel: Event Sounds
L.Panel_EventSounds			= "Sonidos de eventos"
L.Area_SoundSelection		= "Selección de sonidos"
L.EventVictorySound			= "Sonido de victoria de encuentro"
L.EventWipeSound			= "Sonido de derrota de encuentro"
L.EventEngagePT				= "Sonido de temporizador de inicio de encuentro"
L.EventEngageSound			= "Sonido de inicio de encuentro"
L.EventDungeonMusic			= "Música de fondo en mazmorras y bandas"
L.EventEngageMusic			= "Música de fondo en encuentros"
L.Area_EventSoundsExtras	= "Opciones de sonidos de eventos"
L.EventMusicCombined		= "Mostrar toda la selección de música (escribe /reload en el chat para que esta opción surta efecto)"
L.Area_EventSoundsFilters	= "Filtros de sonidos de evento"
L.EventFilterDungMythicMusic= "Desactivar música personalizada de mazmorra en dificultad Mítica/M+."
L.EventFilterMythicMusic	= "Desactivar música personalizada de encuentros en dificultad Mítica/M+."

-- Tab: Timers
L.TabCategory_Timers		= "Temporizadores"
L.Area_ColorBytype			= "Guía para colores de barras por tipo"
-- Panel: Color by Type
L.Panel_ColorByType	 		= "Colores por tipo"
L.AreaTitle_BarColors		= "Colores de barras por tipo de temporizador"
L.AreaTitle_ImpBarColors	= "Colores de barras importantes (estas son barras configuradas como importantes por el usuario)"
L.BarTexture				= "Textura de barras"
L.BarStyle					= "Estilo de barras"
L.BarDBM					= "DBM (con animaciones)"
L.BarSimple					= "Simple (sin animaciones)"
L.BarStartColor				= "Color inicial"
L.BarEndColor 				= "Color final"
L.Bar_Height				= "Altura de barras: %d"
L.Slider_BarOffSetX 		= "Posición X: %d"
L.Slider_BarOffSetY 		= "Posición Y: %d"
L.Slider_BarWidth 			= "Anchura de barras: %d"
L.Slider_BarScale 			= "Escala de barras: %0.2f"
L.BarSaturation				= "Saturación de barras para temporizadores pequeños (cuando las barras grandes están desactivadas): %0.2f"
--Types
L.BarStartColorAdd			= "Color inicial 1 (esbirros)"
L.BarEndColorAdd			= "Color final 1 (esbirros)"
L.BarStartColorAOE			= "Color inicial 2 (áreas)"
L.BarEndColorAOE			= "Color final 2 (áreas)"
L.BarStartColorDebuff		= "Color inicial 3 (objetivo)"
L.BarEndColorDebuff			= "Color final 3 (objetivo)"
L.BarStartColorInterrupt	= "Color inicial 4 (interrumpir)"
L.BarEndColorInterrupt		= "Color final 4 (interrumpir)"
L.BarStartColorRole			= "Color inicial 5 (rol)"
L.BarEndColorRole			= "Color final 5 (rol)"
L.BarStartColorPhase		= "Color inicial 6 (fase)"
L.BarEndColorPhase			= "Color final 6 (fase)"
L.BarStartColorUI			= "Color inicial 7 (importante)"
L.BarEndColorUI				= "Color final 7 (importante)"
L.BarStartColorI2			= "Color inicial 8 (importante)"
L.BarEndColorI2				= "Color final 8 (importante)"
--Type 7 options
L.Bar7Header				= "Opciones de barras importantes"
L.Bar7ForceLarge			= "Utilizar siempre barras grandes"
L.Bar7CustomInline			= "Utilizar icono '!' personalizado"
--Dropdown Options
L.CBTGeneric				= "Genérico"
L.CBTAdd					= "Esbirro"
L.CBTAOE					= "Área"
L.CBTTargeted				= "Objetivo"
L.CBTInterrupt				= "Interrumpir"
L.CBTRole					= "Rol"
L.CBTPhase					= "Fase"
L.CBTImportant				= "Importante"
--Dropdown Options
L.SAOne						= "Sonido global 1 (personal)"
L.SATwo						= "Sonido global 2 (todos)"
L.SAThree					= "Global Sound 3 (acción de alta prioridad)"
L.SAFour					= "Global Sound 4 (correr de alta prioridad)"
L.ColorDropGeneric			= "Genérico (original)"
L.ColorDrop1				= "Color 1"
L.ColorDrop2				= "Color 2"
L.ColorDrop3				= "Color 3"
L.ColorDrop4				= "Color 4"
L.ColorDrop5				= "Color 5"
L.ColorDrop6				= "Color 6"
L.CDDImportant1				= "Importante 1"
L.CDDImportant2				= "Importante 2"
L.CVoiceOne					= "Cuenta atrás 1"
L.CVoiceTwo					= "Cuenta atrás 2"
L.CVoiceThree				= "Cuenta atrás 3"

-- Panel: Timers
L.Panel_Appearance	 		= "Apariencia de barras"
L.Panel_Behavior	 		= "Comportamiento de barras"
L.AreaTitle_BarSetup		= "Opciones de apariencia de barras"
L.AreaTitle_Behavior		= "Opciones de comportamiento de barras"
L.AreaTitle_BarSetupSmall 	= "Opciones de barras pequeñas"
L.AreaTitle_BarSetupHuge	= "Opciones de barras grandes"
L.EnableHugeBar 			= "Activar barras grandes (o 'Barra 2')"
L.BarIconLeft 				= "Icono izquierdo"
L.BarIconRight 				= "Icono derecho"
L.ExpandUpwards				= "Expandir arriba"
L.FillUpBars				= "Rellenar"
L.ClickThrough				= "Desactivar clic en barras"
L.Bar_Decimal				= "Mostrar decimales bajo: %d s"
L.Bar_Alpha					= "Transparencia: %0.1f"
L.Bar_EnlargeTime			= "Agrandar barras bajo tiempo: %d s"
L.BarSpark					= "Destello de barras"
L.BarFlash					= "Destellar barras a punto de expirar"
L.BarSort					= "Ordenar por tiempo restante"
L.BarColorByType			= "Color por tipo"
L.Highest					= "Alto hacia arriba"
L.Lowest					= "Bajo hacia arriba"
L.NoBarFade					= "Utilizar color inicial y color final para barras pequeñas y grandes, respectivamente, en lugar de efectuar cambios de color graduales"
L.BarInlineIcons			= "Iconos en barras"
L.DisableRightClickBar		= "Desactivar clic derecho para cancelar temporizadores"
L.ShortTimerText			= "Texto de temporizador breve"
L.KeepBar					= "Mantener hasta que se lance la facultad"
L.KeepBar2					= "(siempre que el módulo lo permita)"
L.FadeBar					= "Desteñir barras de facultades lejanas"
L.BarSkin					= "Estilo de barra"

-- Panel: Pull, Break, Combat
L.Panel_PullBreakCombat		= "Inicio y descanso"

L.Area_SoundOptions			= "Opciones de sonido"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 	= "Filtros globales"
L.Area_DBMFiltersSetup		= "Guía de filtros de DBM"
L.Area_BlizzFiltersSetup	= "Guía de filtros de Blizzard"
-- Panel: DBM Features
L.Panel_SpamFilter			= "Funciones de DBM"

L.Area_SpamFilter_SpecFeatures		= "Opciones de avisos"
L.SpamBlockNoShowAnnounce			= "Ocultar anuncios generales y desactivar los sonidos asociados"
L.SpamBlockNoSpecWarnText			= "Ocultar avisos especiales pero sí reproducir sonidos de paquetes de voces (la opción anterior anula esta)"
L.SpamBlockNoSpecWarnFlash			= "Desactivar destellos de avisos especiales"
L.SpamBlockNoSpecWarnVibrate		= "No vibrar el controlador en un aviso especial"
L.SpamBlockNoSpecWarnSound			= "Desactivar sonidos de avisos especiales (no afecta a los paquetes de voz)"
L.SpamBlockNoPrivateAuraSound		= "No registrar sonidos de auras privados"

L.Area_SpamFilter_Timers			= "Opciones de filtros globales de temporizadores"
L.SpamBlockNoShowBossTimers			= "No mostrar temporizadores para jefes de mazmorras/bandas"
L.SpamBlockNoShowTrashTimers		= "No mostrar temporizadores para bichos (Nota: esto también desactiva los TdR con placa de nombre.)"
L.SpamBlockNoShowEventTimers		= "No mostrar temporizadores para eventos o avisos (cola, campo de batalla, etc.)"
L.SpamBlockNoShowUTimers			= "Ocultar temporizadores de usuario"
L.SpamBlockNoCountdowns				= "Desactivar sonidos de cuenta atrás"

L.Area_SpamFilter_Nameplates	= "Opciones de filtro y desactivación global de placa de nombre"
L.SpamBlockNoNameplate			= "Ocultar auras de placas de nombres (las desactiva por completo)"
L.SpamBlockNoNameplateCD		= "Ocultar iconos de placas de nombre para tiempos de reutilización de facultades"
L.SpamBlockNoBossGUIDs			= "Ocultar iconos de placas de nombre para tiempos de reutilización de facultades para jefes enemigos.\n(Aún verás iconos de bichos o jefes de múltiples objetivos si está activado.)"


L.Area_SpamFilter_Misc		= "Opciones de filtros globales varios"
L.SpamBlockNoSetIcon		= "Desactivar asignación automática de iconos"
L.SpamBlockNoRangeFrame		= "Ocultar marcos de distancia"
L.SpamBlockNoInfoFrame		= "Ocultar marcos de información"
L.SpamBlockNoHudMap			= "Ocultar indicadores"
L.SpamBlockNoYells			= "Desactivar envío automático de mensajes en el chat"
L.SpamBlockNoNoteSync		= "Rechazar automáticamente notas compartidas"
L.SpamBlockAutoGossip		= "No manejar automáticamente los diálogos."

L.Area_Restore				= "Opciones de restauración"
L.SpamBlockNoIconRestore	= "Restaurar iconos al acabar el encuentro"
L.SpamBlockNoRangeRestore	= "Mantener los marcos de distancia cuando los módulos intenten ocultarlos"

L.Area_PullTimer			= "Opciones de filtros de inicio de encuentro, descanso, y personalizados"
L.DontShowPTNoID			= "Ocultar temporizadores de inicio de encuentro que se inician en zonas distintas"
L.DontShowPT				= "Ocultar barras de temporizadores de inicio de encuentro y descanso"
L.DontShowPTText			= "Ocultar anuncios de temporizadores de inicio de encuentro y descanso"
L.DontPlayPTCountdown		= "Desactivar sonidos de cuenta atrás de temporizadores de inicio de encuentro, descanso, y personalizados"
L.PT_Threshold				= "Ocultar temporizadores por encima de: %d s"

-- Panel: Reduce Information
L.Panel_ReducedInformation			= "Reducir la información"

L.Area_SpamFilter_Anounces			= "Anunciar filtros/desescalada"
L.SpamBlockNoShowTgtAnnounce		= "Ocultar texto ni reproduce sonido para anuncios generales de OBJETIVO que no le afectan; espera, cuando se indique, que un aviso específico ignore este filtro (la desactivación global en las funciones de DBM anula este)"
L.SpamBlockNoTrivialSpecWarnSound	= "No reproducir sonidos de anuncio especiales ni muestra destello en la pantalla para contenido que sea trivial para tu nivel (en su lugar, reproduce un sonido de anuncio no enfatizado seleccionado por el usuario)"

L.Area_SpamFilter			= "Opciones de filtros de avisos"
L.DontShowFarWarnings		= "Ocultar anuncios y temporizadores de eventos que están demasiado lejos"
L.StripServerName			= "Omitir nombre del reino en avisos y temporizadores"
L.FilterVoidFormSay2			= "Desactivar el envío de mensajes de posición y cuenta atrás en el chat durante Forma del Vacío"

L.Area_SpecFilter			= "Opciones de filtros de rol"
L.FilterTankSpec			= "Ocultar avisos designados para tanques cuando no sea tu rol"
L.FilterDispels				= "Ocular avisos de facultades disipables si tu disipación no está disponible"
L.FilterCrowdControl		= "Filtrar anuncios para interrupciones basadas en el control de multitudes si tu control de multitudes está en tiempo de reutilización."
L.FilterTrashWarnings		= "Ocultar todos los avisos de enemigos menores en mazmorras normales y heroicas"

L.Area_BInterruptFilter				= "Opciones de filtro de interrupción de jefe"
L.FilterTargetFocus					= "Filtrar si el lanzador no es el objetivo/enfoque actual"
L.FilterInterruptCooldown			= "Filtrar si el hechizo de interrupción está en tiempo de reutilización"
L.FilterInterruptHealer				= "Filtrar si estás en una especialización de sanador"
L.FilterInterruptNoteName			= "Filtrar si la alerta tiene un recuento pero tu nombre no está en la nota personalizada"--Only used on bosses, trash mods don't assign counts
L.Area_BInterruptFilterFooter		= "Si no se selecciona ningún filtro, se muestran todas las interrupciones (puede ser spam)\nAlgunos módulos pueden ignorar estos filtros por completo si el hechizo es de importancia crítica."
L.Area_TInterruptFilter				= "Opciones de filtro de interrupción de bichos"--Reuses above 3 strings

-- Panel: DBM Handholding
L.Panel_HandFilter					= "Reducir la sujeción de DBM"
L.Area_SpamFilter_SpecRoleFilters	= "Filtros de tipo de anuncio especial (controla cuánta comunicación realiza DBM)"
L.SpamSpecInformationalOnly			= "Remover todo el texto instructivo/alertas de los anuncios especiales (requiere recarga de la interfaz de usuario). Las alertas seguirán mostrando y reproduciendo audio, pero serán genéricas y no directivas."
L.SpamSpecRoleDispel				= "Filtrar las alertas 'disipar' por completo (sin texto ni sonido)"
L.SpamSpecRoleInterrupt				= "Filtrar las alertas 'interrumpir' por completo (sin texto ni sonido)"
L.SpamSpecRoleDefensive				= "Filtrar las alertas 'defensiva' por completo (sin texto ni sonido)"
L.SpamSpecRoleTaunt					= "Filtrar las alertas 'provocar' por completo (sin texto ni sonido)"
L.SpamSpecRoleSoak					= "Filtrar las alertas 'daño' por completo (sin texto ni sonido)"
L.SpamSpecRoleStack					= "Filtrar las alertas 'acumulaciones de perjuicios' por completo (sin texto ni sonido)"
L.SpamSpecRoleSwitch				= "Filtrar las alertas 'cambia de objetivo' y 'bichos' (sin texto ni sonido)"
L.SpamSpecRoleGTFO					= "Filtrar las alertas 'correr' por completo (sin texto ni sonido)"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "Bloquear funciones de Blizzard"
--Toast
L.Area_HideToast					= "Desactivar notificaciones emergentes de Blizzard"
L.HideGarrisonUpdates				= "Ocultar notificaciones de seguidores durante encuentros contra jefes"
L.HideGuildChallengeUpdates			= "Ocultar notificaciones de desafíos de hermandad durante encuentros contra jefes"
L.HideBossKill						= "Ocultar notificaciones de muerte de jefes"--NYI
L.HideVaultUnlock					= "Ocultar notificaciones de desbloqueo de la cámara"--NYI
--Cut Scenes
L.Area_Cinematics 					= "Bloquear cinemáticas del juego"
L.DuringFight 						= "Bloquear escenas de corte durante encuentros de jefes" --uses explicite IsEncounterInProgress check
L.InstanceAnywhere 					= "Bloquear escenas de corte no relacionadas con combate en cualquier lugar dentro de una mazmorra o estancia de banda"
L.NonInstanceAnywhere 				= "¡PELIGRO! Bloquear escenas de corte en el mundo exterior abierto (NO recomendado)"
L.OnlyAfterSeen 					= "Solo bloquear escenas de corte después de haberlas visto al menos una vez (MUY recomendado, para experimentar la historia como se pretendía al menos una vez)"
--Sound
L.Area_Sound 						= "Bloquear sonidos del juego"
L.DisableSFX 						= "Desactivar canal de efectos de sonido durante encuentros de jefe"
L.DisableAmbiance 					= "Desactivar canal de ambiente durante encuentros de jefe"
L.DisableMusic 						= "Desactivar canal de música durante combates de jefes (Nota: Si está activado, la música personalizada de jefes no se reproducirá si está activada en sonidos de eventos)"
--Other
L.Area_HideBlizzard 				= "Desactivar y ocultar otras molestias de Blizzard"
L.HideBossEmoteFrame 				= "Ocultar marco de emociones de jefe de banda durante encuentros de jefe"
L.HideWatchFrame 					= "Ocultar marco de seguimiento (objetivos) durante encuentros de jefe si no se están siguiendo logros y si no está en un Mítico+"
L.HideQuestTooltips 				= "Ocultar objetivos de misión de las descripciones emergentes durante encuentros de jefes" --Currently hidden (NYI)
L.HideTooltips 						= "Ocultar completamente las descripciones emergentes durante encuentros de jefe"

-- Panel: Raid Leader Controls
L.Tab_RLControls					= "Controles de líder de banda"
L.Area_FeatureOverrides				= "Opciones de anulación de funciones"
L.OverrideIcons 					= "Desactivar el marcado de iconos para todos los usuarios en banda, incluido el tuyo (utiliza anular en lugar de desactivar si deseas que DBM marque según tus términos)"
L.OverrideSay						= "Desactivar la burbuja de chat/mensajes DECIR para todos los usuarios en la banda, incluido el tuyo"
L.DisableStatusWhisperShort			= "Desactivar estado/susurros de respuesta para todo el grupo"--Duplicated from privacy but makes sense to include option in both panels
L.DisableGuildStatusShort			= "Desactivar la sincronización de mensajes de progresión con la hermandad para todo el grupo."--Duplicated from privacy but makes sense to include option in both panels
L.DisabledForDropdown				= "Elige la desactivación del mod(s) del jefe y se envía a"--NYI
L.DiabledForBoth					= "Desactiva las funciones anteriores tanto para DBM como para BW"--NYI
L.DiabledForDBM						= "Desactiva las funciones anteriores solo para usuarios de DBM"--NYI
L.DiabledForBW						= "Desactiva las funciones anteriores solo para usuarios de BW"--NYI

L.Area_ConfigOverrides				= "Opciones de anulación de configuración"--NYI
L.OverrideBossAnnounceOptions		= "Establecer la configuración de anuncio de todos los usuarios de DBM en mi configuración"--NYI
L.OverrideBossTimerOptions			= "Establecer la configuración de temporizador de todos los usuarios de DBM en mi configuración"--NYI
L.OverrideBossIconOptions			= "Establecer la configuración de icono todos los usuarios de DBM en mi configuración (si la configuración del icono está desactivada en las opciones anteriores, esta opción se ignora)"--NYI
L.OverrideBossSayOptions			= "Establecer la configuración de chat de todos los usuarios de DBM en mi configuración (Si la configuración de la burbuja de chat está desactivada en las opciones anteriores, esta opción se ignora)"--NYI
L.ConfigAreaFooter					= "Las opciones en esta área solo anulan temporalmente la configuración de los usuarios al participar sin alterar su configuración guardada."
L.ConfigAreaFooter2					= "Se recomienda considerar todos los roles y no excluir los temporizadores/alertas que un tanque, etc. pueda necesitar."

L.Area_receivingOptions				= "Opciones de recepción"--NYI
L.NoAnnounceOverride				= "No acepta anuncios anulados por parte de los líderes de la banda."--NYI
L.NoTimerOverridee					= "No acepta anulaciones del temporizador por parte de los líderes de la banda."--NYI
L.ReplaceMyConfigOnOverride			= "AVISO: Reemplace permanentemente mis configuraciones de modificación con líderes de banda, al anularlas"--NYI
L.ReceivingFooter					= "Las anulaciones de opciones de iconos y burbujas de chat no se pueden desactivar ya que estas configuraciones afectan a otros jugadores a tu alrededor."--NYI
L.ReceivingFooter2					= "Si activas estas opciones, es entre tú y líder de banda si tu configuración causa conflicto con su intención."--NYI
L.ReceivingFooter3					= "Si activas 'reemplazar mi configuración de módulo', tu configuración original se perderá al anularla."--NYI

L.TabFooter							= "Todas las opciones en este panel solo funcionan si eres líder de grupo en un grupo que no es de mazmorra/buscador de banda"

-- Panel: Privacy
L.Tab_Privacy 				= "Controles de privacidad"
L.Area_WhisperMessages		= "Opciones de susurros"
L.AutoRespond 				= "Responder automáticamente a susurros en encuentro"
L.WhisperStats 				= "Incluir estadísticas de victoria y derrota en las respuestas automáticas a susurros"
L.DisableStatusWhisper 		= "Desactivar susurros automáticos de estado de encuentro del grupo o banda para todos los jugadores (requiere ser el líder). Solo se aplica a bandas en dificultad normal, heroica y mítica, y a mazmorras de piedra angular."
L.Area_SyncMessages			= "Opciones de sincronización de addons"
L.DisableGuildStatus 		= "Desactivar mensajes de hermandad de estado de encuentro del grupo o banda para todos los jugadores (requiere ser el líder)."
L.EnableWBSharing 			= "Compartir tus inicios y victorias de encuentros con jefes del mundo con tu hermandad y amigos de Battle.net que están en el mismo reino que tú"

-- Tab: Frames & Integrations
L.TabCategory_Frames		= "Marcos e integración"
L.Area_NamelateInfo			= "Información de auras de placas de nombres de DBM"
-- Panel: InfoFrame
L.Panel_InfoFrame			= "Marco de información"

-- Panel: Range
L.Panel_Range				= "Marco de distancia"

-- Panel: Nameplate
L.Panel_Nameplates			= "Placas de nombres"
L.Area_NPStyle				= "Contorno (solo cuando DBM controla las placas de nombres)"
L.NPAuraText				= "Mostrar texto del temporizador en los iconos de la placa de nombre"
L.NPAuraSize				= "Tamaño del aura: %d"
L.NPIcon_BarOffSetX 		= "Desplazamiento del icono X: %d"
L.NPIcon_BarOffSetY 		= "Desplazamiento del icono Y: %d"
L.NPIcon_GrowthDirection 	= "Dirección de crecimiento del icono"
L.NPIcon_Spacing		 	= "Espaciado del icono: %d"
L.NPIcon_MaxTextLen		 	= "Longitud del texto máx.: %d"
L.NPIconAnchorPoint			= "Punto de anclaje del icono"
L.NPDemo					= "Probar (Acercase de placas de nombre)"
L.FontTypeTimer				= "Seleccionar fuente del temporizador"
L.FontTypeText				= "Seleccionar fuente de texto"

-- Misc
L.Area_General				= "General"
L.Area_Position				= "Posición"
L.Area_Style				= "Estilo"

L.FontSize					= "Tamaño: %d"
L.FontStyle					= "Contorno"
L.FontColor					= "Texto"
L.FontShadow				= "Sombra"
L.FontType					= "Fuente"

L.FontHeight	= 16
