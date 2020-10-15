if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

if not DBM_GUI_L then DBM_GUI_L = {} end
local L = DBM_GUI_L

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Traducido por "
L.TranslationBy 			= "Saispai"
L.Website					= "Visita nuestro canal de Discord (|cFF73C2FBhttps://discord.gg/deadlybossmods|r) y síguenos en Twitter (@deadlybossmods)."
L.WebsiteButton				= "Página web"

L.OTabBosses	= "Jefes"
L.OTabRaids		= "Bandas"
L.OTabDungeons	= "Mazmorras/otros"
L.OTabPlugins	= "Plugins"
L.OTabAbout		= "Acerca de"

L.TabCategory_OTHER    		= "Otros módulos"

L.BossModLoaded 			= "Estadísticas de %s"
L.BossModLoad_now 			= [[Este módulo no está cargado.
Se cargará al entrar en la estancia.
También puedes hacer clic en el botón para cargar el módulo manualmente.]]

L.PosX 						= 'Posición X'
L.PosY 						= 'Posición Y'

L.MoveMe 					= 'Posición'
L.Button_OK 				= 'Aceptar'
L.Button_Cancel 			= 'Cancelar'
L.Button_LoadMod 			= 'Cargar módulo'
L.Mod_Enabled				= "Habilitar módulo"
L.Mod_Reset					= "Cargar opciones por defecto"
L.Reset 					= "Restaurar"

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
L.UseSoundChannel			= "Canal de audio para alertas"
L.UseMasterChannel			= "Canal de audio principal"
L.UseDialogChannel			= "Canal de audio de diálogo"
L.UseSFXChannel				= "Canal de audio de efectos de sonido"
L.Latency_Text				= "Latencia máxima para sincronización: %d"

L.Button_RangeFrame			= "Mostrar/ocultar\nmarco de distancia"
L.Button_InfoFrame			= "Mostrar/ocultar\nmarco de información"
L.Button_TestBars			= "Comprobar barras"
L.Button_ResetInfoRange		= "Restaurar posiciones por defecto"

L.ModelOptions				= "Opciones del visualizador de modelos 3D"
L.EnableModels				= "Mostrar modelos 3D en opciones de jefe"
L.ModelSoundOptions			= "Sonido"

L.ResizeOptions			 	= "Tamaño de la ventana"
L.Button_ResetWindowSize	= "Restaurar tamaño"
L.Editbox_WindowWidth		= "Horizontal"
L.Editbox_WindowHeight		= "Vertical"

-- Panel: Extra Features
L.Panel_ExtraFeatures		= "Funciones adicionales"

L.Area_SoundAlerts			= "Opciones de alertas de sonido e iluminación del icono del juego"
L.LFDEnhance				= "Reproducir sonido de comprobación de banda e iluminar icono del juego para avisos del buscador de mazmorra/banda/grupo y campos de batalla por el canal de audio general o de diálogo (en otras palabras, reproduce el sonido aunque el canal de efectos de sonido esté desactivado, y en general suena más alto)"
L.WorldBossNearAlert		= "Reproducir sonido de comprobación de banda e iluminar icono del juego cuando haya un jefe de mundo cerca"
L.RLReadyCheckSound			= "Reproducir sonido por el canal de audio general o de diálogo e iluminar el icono del juego cuando se haga una comprobación de banda"
L.AFKHealthWarning			= "Reproducir sonido de alerta e iluminar el icono del juego si tu salud se reduce mientras estás ausente"
L.AutoReplySound			= "Reproducir sonido de alerta e iluminar el icono del juego al recibir respuestas automáticas de DBM por susurro"
--
L.TimerGeneral 				= "Opciones de temporizadores"
L.SKT_Enabled				= "Mostrar temporizador para batir el récord de victoria del encuentro actual"
L.ShowRespawn				= "Mostrar temporizador para la reaparición de jefe tras cada derrota"
L.ShowQueuePop				= "Mostrar temporizador para eltiempo restante para aceptar avisos del buscador"
--
L.Area_AutoLogging			= "Opciones del registro automático"
L.AutologBosses				= "Registrar encuentros automáticamente con el registro de combate de Blizzard (usa '/dbm pull' antes de iniciar un encuentro para comenzar a grabar antes, de forma que tenga en cuenta la toma de pociones y otras acciones)"
L.AdvancedAutologBosses		= "Registrar encuentros automáticamente con Transcriptor"
L.RecordOnlyBosses			= "Registrar solo encuentros de jefe (excluye todos los combates contra enemigos que no son jefes; usa '/dbm pull' antes de un jefe para registrar el uso previo de pociones)"
L.LogOnlyNonTrivial			= "Registrar solo el contenido importante (excluye el buscador de bandas, las mazmorras, las gestas y todo el contenido antiguo)"
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

-- Panel: Profiles
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
L.SpecWarn_ClassColor		= "Usar colores de clase para avisos especiales"
L.ShowSWarningsInChat 		= "Mostrar avisos especiales en el chat"
L.SWarnNameInNote			= "Usar Destello 5 si una nota personalizada contiene tu nombre"
L.SpecialWarningIcon		= "Mostrar iconos en avisos especiales"
L.ShortTextSpellname		= "Use texto abreviado cuando sea posible"
L.SpecWarn_FlashFrameRepeat	= "Repetir %d veces (si está habilitado)"
L.SpecWarn_Flash			= "Destello"
L.SpecWarn_FlashRepeat		= "Repetir destello"
L.SpecWarn_FlashColor		= "Destello %d"
L.SpecWarn_FlashDur			= "Duración: %0.1f s"
L.SpecWarn_FlashAlpha		= "Transparencia: %0.1f"
L.SpecWarn_DemoButton		= "Mostrar ejemplo"
L.SpecWarn_ResetMe			= "Restaurar valores por defecto"
L.SpecialWarnSoundOption	= "Sonido por defecto"
L.SpecialWarnHeader1		= "Tipo 1: Opciones para avisos de prioridad normal relevantes a ti o a tus acciones"
L.SpecialWarnHeader2		= "Tipo 2: Opciones para avisos de prioridad normal relevantes a todos los jugadores"
L.SpecialWarnHeader3		= "Tipo 3: Opciones para avisos de prioridad alta"
L.SpecialWarnHeader4		= "Tipo 4: Opciones para avisos especiales de huida con prioridad alta"
L.SpecialWarnHeader5		= "Tipo 5: Opciones para avisos con notas que contienen tu nombre"

-- Panel: Generalwarnings
L.Tab_GeneralMessages 		= "Mensajes generales"
L.CoreMessages				= "Opciones de mensajes del módulo general"
L.ShowPizzaMessage 			= "Mostrar avisos de temporizadores en el chat"
L.ShowAllVersions	 		= "Mostrar versión de DBM de cada miembro del grupo en el chat al hacer comprobaciones de versión. Si se deshabilita seguirá mostrando quién lo tiene desactualizado."
L.ShowReminders				= "Mostrar recordatorios de módulos que falten, que estén desactivados, que hayan recibido cambios, que estén desfasados o que estén silenciados."

L.CombatMessages			= "Opciones de mensajes de combate"
L.ShowEngageMessage 		= "Mostrar mensajes de inicio de encuentro en el chat"
L.ShowDefeatMessage 		= "Mostrar mensajes de victoria y derrota en el chat"
L.ShowGuildMessages 		= "Mostrar mensajes de inicio de encuentro, victoria y derrota de banda de hermandad en el chat"
L.ShowGuildMessagesPlus		= "Mostrar también mensajes de inicio, victoria y derrota de Mítica+ de grupos de hermandad (requiere que la opción anterior esté activada)"

L.Area_ChatAlerts			= "Opciones de alertas adicionales"
L.RoleSpecAlert				= "Mostrar mensaje de alerta al unirte a una banda cuando tu especialización de botín no coincida con tu especialización actual"
L.CheckGear					= "Mostrar mensaje de alerta al iniciar un encuentro cuando tu nivel de equipo sea como mínimo 40 niveles menor que el de tu inventario o no tengas equipada un arma principal"
L.WorldBossAlert			= "Mostrar mensaje de alerta cuando un amigo o miembro de hermandad inicie un encuentro contra un jefe de mundo (impreciso si el jugador en combate está en otro reino)"

L.Area_BugAlerts			= "Opciones de alertas de informes de fallos"
L.BadTimerAlert				= "Mostrar mensaje en el chat cuando DBM detecte un temporizador erróneo"
L.BadIDAlert				= "Mostrar mensaje en el chat cuando DBM detecte una ID de hechizo o guía de aventuras incorrecta"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Alertas de voz"
L.Area_VoiceSelection		= "Selección de voces"
L.CountdownVoice			= "Voz principal para cuentas atrás"
L.CountdownVoice2			= "Voz secundaria para cuentas atrás"
L.CountdownVoice3			= "Voz terciaria para cuentas atrás"
L.VoicePackChoice			= "Paquete de voz para alertas de voz"
L.Area_CountdownOptions		= "Opciones de cuenta atrás"
L.Area_VoicePackOptions		= "Opciones de paquetes de voz (archivos de terceros)"
L.SpecWarn_NoSoundsWVoice	= "Filtrar sonidos de avisos especiales para avisos que también tienen alertas de voz"
L.SWFNever					= "Nunca"
L.SWFDefaultOnly			= "Cuando los avisos especiales usen sonidos por defecto"
L.SWFAll					= "Cuando los avisos especiales usen cualquier sonido"
L.SpecWarn_AlwaysVoice		= "Reproducir siempre todas las alertas de voz (ignora las opciones de jefe; útil para líderes de banda)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?
L.Area_GetVEM				= "Descargar VEM Voice Pack"
L.VEMDownload				= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/dbm-voicepack-vem|r"
L.Area_BrowseOtherVP		= "Explorar otros paquetes de voz en Curse"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "Explorar otros paquetes de voz de cuenta atrás en Curse"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Panel: Event Sounds
L.Panel_EventSounds			= "Sonidos de eventos"
L.Area_SoundSelection		= "Selección de sonidos"
L.EventVictorySound			= "Sonido de victoria de encuentro"
L.EventWipeSound			= "Sonido de derrota de encuentro"
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
L.BarTexture				= "Textura de barras"
L.BarStyle					= "Estilo de barras"
L.BarDBM					= "DBM (con animaciones)"
L.BarSimple					= "Simple (sin animaciones)"
L.BarStartColor				= "Color inicial"
L.BarEndColor 				= "Color final"
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
--Dropdown Options
L.CBTGeneric				= "Genérico"
L.CBTAdd					= "Esbirro"
L.CBTAOE					= "Área"
L.CBTTargeted				= "Objetivo"
L.CBTInterrupt				= "Interrumpir"
L.CBTRole					= "Rol"
L.CBTPhase					= "Fase"
L.CBTImportant				= "Importante (usuario)"
L.CVoiceOne					= "Cuenta atrás 1"
L.CVoiceTwo					= "Cuenta atrás 2"
L.CVoiceThree				= "Cuenta atrás 3"

-- Panel: Timers
L.Panel_Appearance	 		= "Apariencia de barras"
L.Panel_Behavior	 		= "Comportamiento de barrs"
L.AreaTitle_BarSetup		= "Opciones de apariencia de barras"
L.AreaTitle_Behavior		= "Opciones de comportamiento de barras"
L.AreaTitle_BarSetupSmall 	= "Opciones de barras pequeñas"
L.AreaTitle_BarSetupHuge	= "Opciones de barras grandes"
L.EnableHugeBar 			= "Habilitar barras grandes (o 'Barra 2')"
L.BarIconLeft 				= "Icono izquierdo"
L.BarIconRight 				= "Icono derecho"
L.ExpandUpwards				= "Expandir arriba"
L.FillUpBars				= "Rellenar"
L.ClickThrough				= "Deshabilitar clic en barras"
L.Bar_Decimal				= "Mostrar decimales bajo: %d s"
L.Bar_Alpha					= "Transparencia de barra: %0.1f"
L.Bar_EnlargeTime			= "Agrandar barras bajo tiempo: %d s"
L.BarSpark					= "Destello de barras"
L.BarFlash					= "Iluminar barras a punto de expirar"
L.BarSort					= "Ordenar por tiempo restante"
L.BarColorByType			= "Color por tipo"
L.NoBarFade					= "Usar color inicial y color final para barras pequeñas y grandes, respectivamente, en lugar de efectuar cambios de color graduales"
L.BarInlineIcons			= "Iconos en barras"
L.ShortTimerText			= "Texto de temporizador breve"
L.StripTimerText			= "Quitar 'TdR' y 'Siguiente' en los temporizadores"
L.KeepBar					= "Mantener hasta que se lance la habilidad"
L.KeepBar2					= "(siempre que el módulo lo permita)"
L.FadeBar					= "Desteñir barras de habilidades lejanas"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 	= "Filtros globales"
L.Area_DBMFiltersSetup		= "Guía de filtros de DBM"
L.Area_BlizzFiltersSetup	= "Guía de filtros de Blizzard"
-- Panel: DBM Features
L.Panel_SpamFilter			= "Funciones de DBM"
L.Area_SpamFilter_Anounces	= "Opciones de filtros globales de avisos"
L.SpamBlockNoShowAnnounce	= "Ocultar anuncios generales y desactivar los sonidos asociados"
L.SpamBlockNoShowTgtAnnounce= "Ocultar anuncios generales de objetivos y desactivar los sonidos asociados (la opción anterior anula esta)"
L.SpamBlockNoSpecWarnText	= "Ocultar avisos especiales pero sí reproducir sonidos de paquetes de voces (la opción anterior anula esta)"
L.SpamBlockNoSpecWarnFlash	= "Desactivar destellos de avisos especiales"
L.SpamBlockNoSpecWarnSound	= "Desactivar sonidos de avisos especiales (no afecta a los paquetes de voz)"

L.Area_SpamFilter_Timers	= "Opciones de filtros globales de temporizadores"
L.SpamBlockNoShowTimers		= "Ocultar temporizadores de módulos"
L.SpamBlockNoShowUTimers	= "Ocultar temporizadores de usuario"
L.SpamBlockNoCountdowns		= "Desactivar sonidos de cuenta atrás"

L.Area_SpamFilter_Misc		= "Opciones de filtros globales varios"
L.SpamBlockNoSetIcon		= "Desactivar asignación automática de iconos"
L.SpamBlockNoRangeFrame		= "Ocultar marcos de distancia"
L.SpamBlockNoInfoFrame		= "Ocultar marcos de información"
L.SpamBlockNoHudMap			= "Ocultar indicadores"
L.SpamBlockNoNameplate		= "Ocultar auras de placas de nombres (las deshabilita por completo)"
L.SpamBlockNoYells			= "Desactivar envío automático de mensajes en el chat"
L.SpamBlockNoNoteSync		= "Rechazar automáticamente notas compartidas"

L.Area_Restore				= "Opciones de restauración"
L.SpamBlockNoIconRestore	= "Restaurar iconos al acabar el encuentro"
L.SpamBlockNoRangeRestore	= "Mantener los marcos de distancia cuando los módulos intenten esconderlos"

L.Area_SpamFilter			= "Opciones de filtros de avisos"
L.DontShowFarWarnings		= "Ocultar anuncios y temporizadores de eventos que estén demasiado lejos"
L.StripServerName			= "Omitir nombre del reino en avisos y temporizadores"
L.FilterVoidFormSay			= "Deshabilitar el envío de mensajes de posición y cuenta atrás en el chat durante Forma del Vacío"

L.Area_SpecFilter			= "Opciones de filtros de rol"
L.FilterTankSpec			= "Ocultar avisos designados para tanques cuando no sea tu rol"
L.FilterInterruptsHeader	= "Patrón para ocultar avisos de facultades interrumpibles"
L.FilterInterrupts			= "Si no es tu objetivo o foco (siempre)"
L.FilterInterrupts2			= "Si no es tu objetivo o foco (siempre) o no puedes interrumpir (solo jefes)"
L.FilterInterrupts3			= "Si no es tu objetivo o foco (siempre) o no puedes interrumpir (todos los enemigos)"
L.FilterInterrupts4			= "Ocultar todos los avisos de interrupción"
L.FilterInterruptNoteName	= "Ocultar avisos de facultades interrumpibles con orden de interrupciones si el aviso no contiene tu nombre en la nota"
L.FilterDispels				= "Ocular avisos de facultades disipables si tu disipación no está disponible"
L.FilterTrashWarnings		= "Ocultar todos los avisos de enemigos menores en mazmorras normales y heroicas"

L.Area_PullTimer			= "Opciones de filtros de inicio de encuentro, descanso, combate y personalizados"
L.DontShowPTNoID			= "Ocultar temporizadores de inicio de encuentro que se inicien en zonas distintas"
L.DontShowPT				= "Ocultar barras de temporizadores de inicio de encuentro y descanso"
L.DontShowPTText			= "Ocultar anuncios de temporizadores de inicio de encuentro y descanso"
L.DontShowPTCountdownText	= "Ocultar texto de cuenta atrás de temporizadores de inicio de encuentro, descanso, combate y personalizados"
L.DontPlayPTCountdown		= "Desactivar sonidos de cuenta atrás de temporizadores de inicio de encuentro, descanso, combate y personalizados"
L.PT_Threshold				= "Ocultar temporizadores por encima de: %d s"

-- Panel: Blizzard Features
L.Panel_HideBlizzard		= "Interfaz y funciones de Blizzard"
L.Area_HideBlizzard			= "Opciones de interfaz y funciones de Blizzard"
L.HideBossEmoteFrame		= "Ocultar avisos de encuentro de mazmorra y banda"
L.HideWatchFrame			= "Ocultar seguimiento de objetivos (misiones, logros, etc.) en encuentros si no se está siguiendo un logro relacionado. En modo desafío muestra el tiempo restante."
L.HideGarrisonUpdates		= "Ocultar botón de ciudadela en jefes"
L.HideGuildChallengeUpdates	= "Ocultar botón de desafíos de hermandad en jefes"
L.HideQuestTooltips			= "Ocultar objetivos de misión en en descripciones emergentes durante Hide quest objectives from tooltips during boss fights"
L.HideTooltips				= "Ocultar por completo las descripciones emergentes en encuentros"
L.DisableSFX				= "Desactivar el canal de efectos de sonido en encuentros"
L.DisableCinematics			= "Saltar cinemáticas automáticamente"
L.OnlyFight					= "Solo en combate, tras haber visto la cinemática por primera vez"
L.AfterFirst				= "Tras haber visto la cinemática por primera vez"
L.CombatOnly				= "En combate"
L.RaidCombat				= "En combate (solo en jefes)"

-- Panel: Privacy
L.Tab_Privacy 				= "Controles de privacidad"
L.Area_WhisperMessages		= "Opciones de susurros"
L.AutoRespond 				= "Responder automáticamente a susurros en encuentro"
L.WhisperStats 				= "Incluir estadísticas de victoria y derrota en las respuestas automáticas a susurros"
L.DisableStatusWhisper 		= "Desactivar susurros automáticos de estado de encuentro del grupo o banda para todos los jugadores (requiere ser el líder). Solo se aplica a bandas en dificultad normal, heroica y mítica, y a mazmorras de piedra angular."
L.Area_SyncMessages			= "Opciones de sincronización de addons"
L.DisableGuildStatus 		= "Desactivar mensajes de hermandad de estado de encuentro del grupo o banda para todos los jugadores (requiere ser el líder)."
L.EnableWBSharing 			= "Compartir tus inicios y victorias de encuentros con jefes de mundo con tu hermandad y amigos de Battle.net que estén en el mismo reino que tú"

-- Tab: Frames & Integrations
L.TabCategory_Frames		= "Marcos e integración"
L.Area_NamelateInfo			= "Información de auras de placas de nombres de DBM"
-- Panel: InfoFrame
L.Panel_InfoFrame			= "Marco de información"

-- Panel: Range
L.Panel_Range				= "Marco de distancia"

-- Panel: Nameplate
L.Panel_Nameplates			= "Placas de nombres"
L.UseNameplateHandoff		= "Permitir que otros addons (KuiNameplates, Threat Plates, Plater) controlen las auras de placas de nombres. Activa esta opción si utilizas un addon de placas de nombres para disponer de opciones de configuración más avanzadas."
L.Area_NPStyle				= "Contorno (solo cuando DBM controla las placas de nombres)"
L.NPAuraSize				= "Tamaño del aura: %d"

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
