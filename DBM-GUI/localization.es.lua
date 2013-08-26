if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods - Español"

L.TranslationByPrefix		= "Traducido por "
L.TranslationBy 	= "Snamor, Interplay, Sueñalobos"
L.Website					= "Visita nuestros nuevos foros de discusión y soporte en |cFF73C2FBwww.deadlybossmods.com|r (¡hospedados por Elitist Jerks!)"
L.WebsiteButton				= "Foro"

L.OTabBosses	= "Jefes"
L.OTabOptions	= "Opciones"

L.TabCategory_Options 	= "Opciones generales"
L.TabCategory_MOP	 		= "Mists of Pandaria"
L.TabCategory_CATA	 		= "Cataclysm"
L.TabCategory_WOTLK 	= "Wrath of the Lich King"
L.TabCategory_BC 	= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW Classic Bosses"
L.TabCategory_OTHER     = "Otros Boss Mods"

L.BossModLoaded 	= "%s estadisticas"
L.BossModLoad_now 	= [[Este modulo no esta cargado. 
Si no se carga al entrar en la estancia. 
Puedes pulsar en el boton para cargar el modulo manualmente.]]

L.PosX = 'Posicion X'
L.PosY = 'Posicion Y'

L.MoveMe 		= '¡Muéveme!'
L.Button_OK 		= 'Aceptar'
L.Button_Cancel 	= 'Cancelar'
L.Button_LoadMod 	= 'Cargar Modulo'
L.Mod_Enabled		= "Habilitar modulo de este boss"
L.Mod_Reset		= "Cargar opciones por defecto"
L.Reset 		= "resetear"

L.Enable  		= "Habilitar"
L.Disable		= "Desabilitar"

L.NoSound		= "Sin sonido"

L.IconsInUse	= "Iconos usados por este mod"

-- Tab: Boss Statistics
L.BossStatistics	= "Estadísticas de Boss"
L.Statistic_Kills	= "Muertes:"
L.Statistic_Wipes	= "Wipes:"
L.Statistic_Incompletes		= "Incompletos:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill	= "Mejor muerte:"

-- Tab: General Core Options
L.General 		= "Opciones de DBM"
L.EnableDBM 		= "Habilitar DBM"
L.EnableMiniMapIcon	= "Mostrar icono de DBM en el mapa"
L.SetPlayerRole				= "Fijar rol del jugador automáticacmente (recomendado)"
L.UseMasterVolume			= "Usar el canal de audio Principal para reproducir archivos de sonido."
L.AutologBosses				= "Grabar encuentros automáticamente al registro de combate."
L.AdvancedAutologBosses		= "Grabar encuentros automáticamente al registro de combato mediante Transcriptor."
L.LogOnlyRaidBosses			= "Solo grabar encuentros de banda (excluyendo LFR/escenarios)."
L.Latency_Text				= "Umbral latencia máx. sincronización: %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "Opciones generales de los temporizadores"
L.SKT_Enabled			= "Mostrar siempre el contador para superar récord de tiempo (Sobreescribe la opción de bosses específicos)"
L.ChallengeTimerOptions		= "Temporizador para mejor tiempo en modos desaafío."
L.ChallengeTimerPersonal	= "Personal"
L.ChallengeTimerGuild		= "Hermandad"
L.ChallengeTimerRealm		= "Reino"

L.ModelOptions				= "Opciones del Visor de Modelos 3D"
L.EnableModels				= "Activar modelos 3D en las opciones de los jefes"
L.ModelSoundOptions			= "Assignar la opción de sonido para el Visor de Modelos"
L.ModelSoundShort			= "Corto"
L.ModelSoundLong			= "Largo"

L.Button_RangeFrame			= "Mostrar/Ocultar cuadro de distancia"
L.Button_RangeRadar			= "Mostrar/Ocultar radar de distancia"
L.Button_InfoFrame			= "Mostrar/Ocultar cuadro de información"
L.Button_TestBars			= "Probar barras"

L.PizzaTimer_Headline 	= 'Crear "Cronomentro"'
L.PizzaTimer_Title	= 'Nombre (ej. "Pizza!")'
L.PizzaTimer_Hours 	= "Horas"
L.PizzaTimer_Mins 	= "Min"
L.PizzaTimer_Secs 	= "Seg"
L.PizzaTimer_ButtonStart = "Iniciar"
L.PizzaTimer_BroadCast	= "Anunciar a Banda"

-- Tab: Raidwarning
L.Tab_RaidWarning 	= "Avisos a banda"
L.RaidWarning_Header= "Opciones de aviso de banda"
L.RaidWarnColors 	= "Colores de Avisos a banda"
L.RaidWarnColor_1 	= "Color 1"
L.RaidWarnColor_2 	= "Color 2"
L.RaidWarnColor_3 	= "Color 3"
L.RaidWarnColor_4 	= "Color 4"
L.InfoRaidWarning	= [[Puedes especificar posición y colores del cuadro de aviso de banda. 
Este marco se usa en mensajes como "El jugador X está afectado por Y"]]
L.ColorResetted 	= "Los ajustes de color de este campo se han reiniciado"
L.ShowWarningsInChat 	= "Mostrar avisos en el chat"
L.ShowFakedRaidWarnings = "Mostrar avisos en el chat de banda"
L.WarningIconLeft 	= "Mostrar icono en el lado izquierdo"
L.WarningIconRight 	= "Mostrar icono en el lado derecho"
L.WarningIconChat 	= "Mostrar iconos en el chat"
L.ShowCountdownText	= "Mostrar text de cuenta atrás"
L.RaidWarnMessage 	= "Gracias por usar Deadly Boss Mods - Español"
L.BarWhileMove 		= "Avisos de banda se pueden mover"
L.RaidWarnSound		= "Reproducir sonido para aviso-banda"
L.CountdownVoice	= "Fijar voz para sonido de cuenta atrás"
L.CountdownVoice2	= "Fijar voz secundaria para sonido de cuenta atrás"
L.SpecialWarnSound	= "Fijar sonido para avisos especiales que te afecten a ti o a tu rol"
L.SpecialWarnSound2	= "Fijar sonido para avisos especiales que afectan a todos"
L.SpecialWarnSound3	= "Fijar sonido para avisos especiales MUY IMPORTANTES"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 	= "Mensajes generales"
L.CoreMessages			= "Opciones de mensajes del núcleo"
L.ShowLoadMessage 		= "Mostrar mensajes de carga de mods en la ventana de chat"
L.ShowPizzaMessage 		= "Mostrar mensajes de transmisión de tiempo en la ventana de chat"
L.CombatMessages		= "Opciones de mensajes de combate"
L.ShowEngageMessage 	= "Mostrar mensajes al empezar un combate en la ventana de chat"
L.ShowKillMessage 		= "Mostrar mensajes de derrota en la ventana de chat"
L.ShowWipeMessage 		= "Mostrar mensajes de wipe en la ventana de chat"
L.ShowRecoveryMessage	= "Mostrar mensajes de calibración de tiempos en la ventana de chat"
L.WhisperMessages		= "Opciones de mensajes de susurro"
L.AutoRespond 			= "Habilitar auto-responder si estas en un Boss"
L.EnableStatus 			= "Responder 'estado' a los que te susurren en banda"
L.WhisperStats 			= "Incluir las veces que se ha derrotado/wipeado en un boss a la respuestas de susurro"

-- Tab: Barsetup
L.BarSetup   = "Estilo de barra"
L.BarTexture = "Textura de barra"
L.BarStartColor = "Color de inicio"
L.BarEndColor = "Color de fin"
L.ExpandUpwards		= "Ampliar las barras hacia arriba"
L.Bar_Font			= "Fuente de las barras"
L.Bar_FontSize		= "Tamaño de la fuente"
L.Slider_BarOffSetX 	= "Desplazamiento X: %d"
L.Slider_BarOffSetY 	= "Desplazamiento Y: %d"
L.Slider_BarWidth 	= "Ancho de barra: %d"
L.Slider_BarScale 	= "Escala de barra: %0.2f"
L.AreaTitle_BarSetup 	= "Opciones de Barras"
L.AreaTitle_BarSetupSmall = "Barra de la derecha"
L.AreaTitle_BarSetupHuge = "Barra del medio"
L.BarIconLeft 		= "Icono izq."
L.BarIconRight 		= "Icono der."
L.EnableHugeBar 	= "Habilitar barra del medio (Bar 2)"
L.FillUpBars		= "Llénese Barras"
L.ClickThrough		= "Desabilitar acciones de ratón ( si pulsas en las barras )"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Avisos Especiales"
L.Area_SpecWarn				= "Opciones de Avisos Especiales"
L.SpecWarn_Enabled			= "Mostrar Avisos Especiales para habilidades de jefes"
L.SpecWarn_FlashFrame		= "Mostrar un flash de pantalla para avisos especiales"
L.SpecWarn_AdSound		= "Habilitar opciones avanzadas de sonido para avisos especiales (requiere recargar UI)"
L.SpecWarn_Font				= "Fuente usada para avisos especiales"
L.SpecWarn_FontSize			= "Tamaño de fuente: %d"
L.SpecWarn_FontColor		= "Fuente"
L.SpecWarn_FontType			= "Elegir fuente"
L.SpecWarn_FlashColor		= "Parpadeo"
L.SpecWarn_FlashDur		= "Duración del parpadeo: %0.1f"
L.SpecWarn_FlashAlpha		= "Alpha del parpadeo: %0.1f"
L.SpecWarn_DemoButton		= "Ver ejemplo"
L.SpecWarn_MoveMe			= "Definir posición"
L.SpecWarn_ResetMe			= "Reiniciar con los valores por defecto"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Barra de vida"
L.Area_HPFrame				= "Opciones de la barra de vida"
L.HP_Enabled				= "Siempre ver la barra de vida (Sobreescribe la opción de bosses específicos)"
L.HP_GrowUpwards			= "Mover la barra de vida arriba"
L.HP_ShowDemo				= "Ver barra de vida"
L.BarWidth					= "Ancho de la barra: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter		= "Filtro de Spam"
L.Area_SpamFilter		= "Opciones de spam"
L.StripServerName		= "Eliminar nombre de reino de los avisos y temporizadores"
L.SpamBlockBossWhispers		= "Filtrar los avisos de &lt;DBM&gt; mientras estas en combate"
L.BlockVersionUpdateNotice	= "Desabilitar avisos de actualizaciones"
L.ShowBigBrotherOnCombatStart	= "Comprobar los bufos con Big Brother al inicio del combate"
L.BigBrotherAnnounceToRaid		= "Anunciar los resultados de Big Brother a la banda"

L.Area_SpamFilter_Outgoing		= "Opciones de Filtro Global"
L.SpamBlockNoShowAnnounce		= "No mostrar avisos o reproducir sonidos"
L.SpamBlockNoSendWhisper		= "No enviar susurros a otros jugadores"
L.SpamBlockNoSetIcon			= "No poner iconos en objetivos"
L.SpamBlockNoRangeFrame			= "No mostrar radar de rango"
L.SpamBlockNoInfoFrame			= "No mostrar marco de información"

L.Area_PullTimer				= "Opciones de filtrado del temporizador de Pull"
L.DontShowPT					= "No mostrar la barra de temporizador para el pull"
L.DontShowPTCountdownText		= "No mostrar texto de cuenta atras del pull"
L.DontPlayPTCountdown			= "No reproducir audio de cuenta atras para el pull"
L.DontShowPTText				= "No mostrar texto de anuncio de cuenta atras para el pull"

L.Panel_HideBlizzard			= "Esconder Blizzard"
L.Area_HideBlizzard				= "Opciones para esconder interfaz de Blizzard"
L.HideBossEmoteFrame			= "Esconder marco de emoción de los Jefes durante el combate"
L.HideWatchFrame				= "Esconder marco de objetivos durante el combate"
L.SpamBlockSayYell				= "Esconder texto de bocadillos del chat"
L.DisableCinematics				= "Saltar secuencias cinemáticas"
L.AfterFirst					= "Tras haberlas visto la primera vez"
L.Always						= "Siempre"

-- Misc
L.FontHeight	= 16