if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

DBM_CORE_NEED_SUPPORT				= "¿Eres bueno programando o con los idiomas? Si es así, el Equipo DBM necesita tu ayuda para mantener el DBM como el mejor BossMod del WoW. Únete al equipo visitando |HDBM:localizersneeded|h|cff3588ffhere|r"
DBM_HOW_TO_USE_MOD					= "Bienvenido a DBM. Para acceder a las opciones escribe /dbm en tu chat para empezar a configurarlo. Puedes cargar las zonas manualmente para configurar las opciones específicas de cada Boss a tu gusto. DBM intenta hacer esto escaneando tu clase la primera vez que se inicia, pero quizás quieras más alertas de las que necesita tu clase."

DBM_FORUMS_MESSAGE					= "¿Has encontrado un bug o un temporizador no va bien? ¿Piensas que algún jefe necesita un algún aviso adicional, un nuevo temporizador o alguna otra funcionalidad?\nVisita los nuevos foros de discusión, informe de bugs y solicitud de nuevas funcionalidades de Deadly Boss Mods en |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (puedes pulsar el enlace para copiar la URL)"
DBM_FORUMS_COPY_URL_DIALOG			= "Visita nuestro nuevo foro de dicusión y soporte"

DBM_CORE_LOAD_MOD_ERROR				= "Error al cargar modulo %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Módulo de '%s' cargado correctamente. Para más opciones escribe /dbm o /dbm help en tu chat."
DBM_CORE_LOAD_MOD_COMBAT			= "Carga de '%s' retrasada hasta que salgas del combate"
DBM_CORE_LOAD_GUI_ERROR				= "No se puede cargar la GUI: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "La GUI no puede cargarse durante el combate. La GUI se cargará después del combate. Desp'es de cargarse la GUI, podrás cargarla durante los combates."
DBM_CORE_BAD_LOAD					= "DBM ha detectado que la carga del módulo para esta instancia no ha podido realizarse por estar en combate. Tan pronto como acabe el combate, asegurese de ejecutar /console reloadui."

DBM_CORE_LOOT_SPEC_REMINDER			= "Tu especialización es %s. Tu especialización de botín es %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM ha detectado que tienes activadas las opciones de iconos de banda en BigWigs y DBM. Por favor, desactiva una de ellas para evitar conflictos con tu lider de banda."

DBM_CORE_COMBAT_STARTED				= "%s llamado. Buena suerte y diviertase! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "Involucrado en un combate contra %s. ¡Buena suerte y pásalo bien! :)"
DBM_CORE_SCENARIO_STARTED			= "Empezando %s. ¡Buena suerte y pásalo bien! :)"
DBM_CORE_BOSS_DOWN					= "%s murio en %s!"
DBM_CORE_BOSS_DOWN_I				= "¡%s murió! Lo has derrotado %d veces."
DBM_CORE_BOSS_DOWN_L				= "¡%s murio en %s! Su muerte reciente fue %s y la muerte mas rapida fue %s. Lo has detrrotado %d veces en total."
DBM_CORE_BOSS_DOWN_NR				= "¡%s murio en %s! Es un nuevo record! (el antiguo era %s). Lo has detrrotado %d veces en total."
DBM_CORE_SCENARIO_COMPLETE			= "¡%s completado en %s!"
DBM_CORE_SCENARIO_COMPLETE_L		= "¡%s completado en %s! Tu marca más reciente es %s y tu más rápida fué %s. Lo has completado %d veces."
DBM_CORE_SCENARIO_COMPLETE_NR		= "¡%s completado en %s! ¡Un nuevo record personal! (El anterior era %s). Lo has completado %d veces."
DBM_CORE_COMBAT_ENDED_AT			= "El combate contra %s (%s) terminó en %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "El combate contra %s (%s) terminó en %s. Has wipeado %d veces en esta dificultad."
DBM_CORE_SCENARIO_ENDED_AT			= "%s completado en %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s completado en %s. Lo has intentado %d veces sin éxito en esta dificultad."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s empezó %s atrás. Recalibrando temporizadores..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Comenzando transcripción."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Terminando transcripción."

DBM_CORE_TIMER_FORMAT_SECS			= "%.2f |4segundo:segundos;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minuto:minutos;"
DBM_CORE_TIMER_FORMAT				= "%d |4minuto:minutos; y %.2f |4segundo:segundos;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "seg"
DBM_CORE_SEC_FMT					= "%s seg"

DBM_CORE_GENERIC_WARNING_OTHERS		= "y otro"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "y otros %d"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Enrage en %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Enrage"
DBM_CORE_OPTION_TIMER_BERSERK		= "Mostrar tiempo para Enrage"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Comienza el combate"
DBM_CORE_OPTION_TIMER_COMBAT		= "Mostrar temporizador para el comienzo del combate"
DBM_CORE_OPTION_HEALTH_FRAME		= "Mostrar barra de vida del boss"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barras"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Anuncios"

DBM_CORE_AUTO_RESPONDED				= "Auto-respusta."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d gente viva"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s esta ocupado en la batalla contra %s (%s, %d/%d gente viva)"
DBM_CORE_WHISPER_COMBAT_END_KILL	= "¡%s ha derrotado a %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "¡%s ha derrotado a %s! Lo ha matado %d veces."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s ha wipeado en %s al %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s ha wipeado en %s al %s. Ha wipeado %d veces en total en esta dificultad."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s está ocupado en %s (%d/%d gente viva)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "¡%s ha completado %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "¡%s ha completado %s! Llevan %d victorias."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s no ha completado %s"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s no ha completado %s. Lo han intentado %d veces en esta dificultad."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Version"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) y %s (r%d)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM no instalado"
DBM_CORE_VERSIONCHECK_FOOTER		= "Encontrados %d jugadores con Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "¡Tu versión de Deadly Boss Mods es antigua! Por favor, visita www.deadlybossmods.com para bajarte la última versión."

DBM_CORE_UPDATEREMINDER_HEADER		= "La versión de tu Deadly Boss Mods es antigua.\n Version %s (r%d) disponible para descargar aqui:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "La versión alpha de Deadly Boss Mods es antigua.\n Estás por lo menos %d versiones de test atrasado. Se recomienda a los usuarios de DBM que actualizen a la versión alpha más reciente o a la versión estable. Las versiones anticuadas pueden implementar funcionalidades incompletas o erroneas."
DBM_CORE_UPDATEREMINDER_FOOTER		= "Presiona Contro+C para copiar el enlace de la descarga."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Presiona " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " para copiar el enlace de la descarga."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Mostrar popup si hay nueva version de Deadly Boss Mods"
DBM_CORE_UPDATEREMINDER_DISABLE		= "PELIGRO: Como tu versión de Deadly Boss Mods está drásticamente atrasada (%d revisiones), ha sido desabilitado hasta que actualices. Esto asegura que el código viejo e incompatible no provoque una pobre experiencia de juego para ti y el resto de tus compañeros de banda."
DBM_CORE_UPDATEREMINDER_HOTFIX		= "Tu versión de DBM contiene valores incorrectos de los temporizadores y avisos en este encuentro. Esto se arreglará en versiones futuras o directamente descargando una versión alfa actualizada."
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= DBM_CORE_UPDATEREMINDER_HOTFIX--TEMP, FIX ME!

DBM_CORE_MOVABLE_BAR				= "¡Muéveme!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h envia tu tiempo: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancelar este tiempo]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar tiempos de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "¿De verdad quieres ignorar los tiempos de %s para esta sesion?"
DBM_PIZZA_ERROR_USAGE				= "Usa: /dbm [broadcast] timer <time> <text>"

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "DBM-Español"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Mayus+Raton1 o Raton2 para mover\nAlt+Mayus+Raton1 para moverlo a donde quieras"

DBM_CORE_RANGECHECK_HEADER			= "Comprobacion de Rango (%d yd)"
DBM_CORE_RANGECHECK_SETRANGE		= "Ajustar Rango"
DBM_CORE_RANGECHECK_SOUNDS			= "Sonidos"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Sonido si una persona esta a rango"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Sonido si mas de una persona estan a rango"
DBM_CORE_RANGECHECK_SOUND_0			= "Sin sonido"
DBM_CORE_RANGECHECK_SOUND_1			= "Sonido por defecto"
DBM_CORE_RANGECHECK_SOUND_2			= "Sonido de despertador"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d yd"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Marcos"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Mostrar marco de radar"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Mostrar marco de texto"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Mostrar los dos"
DBM_CORE_RANGERADAR_HEADER			= "Radar de rango (%d yd)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d jugadores a rango"

DBM_CORE_INFOFRAME_SHOW_SELF			= "Siempre mostrar tu información"

DBM_LFG_INVITE						= "Invitación al grupo"

DBM_CORE_SLASHCMD_HELP				= {
	"Comandos disponibles:",
	"/dbm version: comprueba la versión de DBM de toda la banda (alias: ver)",
--	"/dbm version2: comprueba la versión de DBM de toda la banda y susurra a los miembros que estan desactualizados (alias: ver2).",
	"/dbm unlock: muestra una barra de estado desplazable (alias: move)",
	"/dbm timer <x> <texto>: Muestra un contador de <x> segundos con el nombre <texto>",
	"/dbm broadcast timer <x> <texto>: Muestra un contador de <x> segundos con el nombre <texto> a la banda (requiere lider/ayudante)",
	"/dbm break <min>: Empieza un descanso de <min> minutos. Muestra a todos los miembros de banda con DBM un contador de descanso (requiere lider/ayudante).",
	"/dbm pull <seg>: Empieza una cuenta atrás para pullear en <seg> segundos. Muestra a todos los miembros de banda con DBM un contador para pullear (requiere lider/ayudante).",
	"/dbm arrow: Muestra la flecha DBM, escribe /dbm arrow help para más detalles.",
	"/dbm lockout: pregunta a los miembros de la raid por sus bloqueos de estancia (alias: lockouts, ids) (requiere líder/ayudante).",
	"/dbm lag: Realiza una comprobación de latencia a todos los miembros de la banda.",
	"/dbm help: muestra esta ayuda"
}

DBM_ERROR_NO_PERMISSION				= "No tienes permiso para hacer eso."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Esconder marco de vida"

DBM_CORE_UNKNOWN					= "desconocido"--UNKNOWN which is "Unknown" (does u vs U matter?)
DBM_CORE_LEFT						= "Izquierda"
DBM_CORE_RIGHT						= "Derecha"
DBM_CORE_BACK						= "Detrás"--BACK
DBM_CORE_FRONT						= "Delante"

DBM_CORE_BREAK_START				= "¡El descanso empieza ahora -- tienes %s!"
DBM_CORE_BREAK_MIN					= "¡El descanso acaba en %s minuto(s)!"
DBM_CORE_BREAK_SEC					= "¡El descanso acaba en %s segundos!"
DBM_CORE_TIMER_BREAK				= "¡Descanso!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "El descanso terminó"

DBM_CORE_TIMER_PULL					= "Pull en"
DBM_CORE_ANNOUNCE_PULL				= "Pull en %d seg (Iniciado por %s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull ahora!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Matar rapido"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target		= "%s en >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) en >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell		= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends 		= "%s terminó"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades		= "%s se disipa"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds		= "%s restantes: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast		= "Lanzando %s: %.1f sec"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon		= "%s pronto"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%s en %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase		= "Fase %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase	= "Fase %s pronto"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count		= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack		= "%s en >%%s< (%%d)"

local prewarnOption = "Mostrar pre-aviso para $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Anunciar objetivos de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Anunciar objetivos de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Mostrar aviso para $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends		= "Mostrar aviso cuando $spell:%s ha terminado"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Mostrar aviso cuando $spell:%s se ha disipado"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds		= "Anunciar cuantos $spell:%s quedan"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast		= "Mostrar aviso cuando $spell:%s está siendo lanzado"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 	= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "Anunciar Fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase	= "Mostrar preaviso para Fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Mostrar aviso para $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Anunciar acumulaciones de $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends		= "%s terminó"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades		= "%s se disipa"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon		= "%s pronto"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn		= "%s en %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel		= "%s en >%%s< - ¡dispelea ahora!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - ¡interrumpe >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - ¡interrumpe >%%s<! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you			= "¡%s en ti!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youcount		= "¡%s (%%s) en ti!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target		= "%s en >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close		= "%s en >%%s< cerca tuyo"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move		= "%s - ¡muévete!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge 	= DBM_CORE_AUTO_SPEC_WARN_TEXTS.move--FIXME (this is a temp until localized properly as a dodge warning)
DBM_CORE_AUTO_SPEC_WARN_TEXTS.jump		= "%s - ¡salta!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run			= "%s - ¡corre!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast		= "%s - ¡para de castear!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect		= "%s en >%%s< - ¡para de atacar!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count		= "%s! (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack		= "%%d acumulaciones de %s en ti"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch		= ">%s< - ¡cambio de objetivos!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount	= ">%s< - ¡cambio de objetivos! (%%s)"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Mostrar aviso especial para $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 		= "Mostrar aviso especial cuando $spell:%s ha terminado"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 		= "Mostrar aviso especial cuando $spell:%s se ha disipado"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 		= "Mostrar pre-aviso para $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 	= "Mostrar pre-aviso %s segundos antes de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Mostrar aviso especial para limpiar/robar $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Mostrar aviso especial para interrumpir $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Mostrar aviso especial cuando te afecte $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youcount	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you--Temp, translate correctly (with count)
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Mostrar aviso especial cuando a alguien le afecte $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Mostrar aviso especial cuando a alguien cerca tuyo le afecte $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Mostrar aviso especial para salir de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move--FIXME (this is a temp until localized properly as a dodge warning)
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Mostrar aviso especial para huir de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Mostrar aviso especial para parar de castear por $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 	= "Mostrar aviso especial para parar de atacar por $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 		= "Mostrar aviso especial para $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Mostrar aviso especial cuando tienes >=%d acumulaciones de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "Mostrar aviso especial para cambiar objetivos con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch--Temp, translate correctly (with count)
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt--Temp, translate correctly (with count)

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s termina"--Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades		= "%s se disipa"--Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "%s CD"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "%s CD (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource	= "%s CD: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next		= "Siguiente %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount	= "Siguiente %s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Siguiente %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Mostrar temporizador para el perjuicio $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Mostrar temporizador de lanzamiento para $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Mostrar temporizador para la duración de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Mostrar temporizador para cuando $spell:%s se disipa en los jugadores"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "Mostrar temporizador para el cooldown de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Mostrar temporizador para el cooldown de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Mostrar temporizador (con origen) para el cooldown de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Mostrar temporizador para el siguiente $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Mostrar temporizador para el siguiente $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Mostrar temporizador (con origen) para el siguiente $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Mostrar temporizador para %s"


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Poner iconos en objetivos de $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Poner iconos en hechizo $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "Reproducir sonido \"huye pequeña\" en $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Reproducir sonido de cuenta atrás para $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2		= "Reproducir sonido de cuenta atrás para cuando $spell:%s se disipa"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Reproducir sonido de la duración de $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yell		= "Gritar cuando tengas $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell	= "¡%s en " .. UnitName("player") .. "!"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Mostrar radar de rango (%s) para $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Mostrar radar de rango (%s)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Mostrar cuadro de información para $spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Reproducir sonido de listos al comienzo del combate (incluso si no se tiene como objetivo al jefe)"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Aviso especial desplazable"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Aviso especial"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "La comprobación de rango de %d yardas no está disponible en esta zona.\nLos rangos disponibles son 10, 11, 15 y 28 yardas."

DBM_ARROW_MOVABLE					= "Flecha movible"
DBM_ARROW_ERROR_USAGE	= {
	"Uso de DBM-Arrow:",
	"/dbm arrow <x> <y>: Crea una flecha que apunta a una dirección específica (0 < x/y < 100)",
	"/dbm arrow <jugador>: Crea una flecha que apunta a un miembro específico de la banda",
	"/dbm arrow hide: Oculta la flecha",
	"/dbm arrow move: Hace la flecha movible"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Superar récord"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Tu mejro récord"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s ha pedido tu ID de estancia y el progreso.\nQuieres enviarle esta información a %s? Esa persona podrá volver a solicitar esta información si aceptas hasta que reloguees."
DBM_ERROR_NO_RAID					= "Tienes que estar en un grupo de banda para usar ésta característica."
DBM_INSTANCE_INFO_REQUESTED			= "Enviar solicitud de ID de estancias al grupo de banda.\nPor favor, entiende que los jugadores serán preguntados por si quieren enviarte esa información antes, por lo que se puede tardar un minuto en recibir todas las respuestas."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Se ha obtenido respuesta de %d jugadores de %d usuarios de DBM: %d han enviado los datos, %d han denegado la solicitud. Se esperará %d segundos más para respuestas..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Se ha recibido respuestas de todos los miembros de la banda"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Personaje: %s Resultado: %s Estancia: %s IDEstancia: %s Difficultad: %d Tamaño: %d Progreso: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, dificultad %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progreso %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    progreso %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Han denegado la solicitud: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Ausentes: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "No tienen una versión reciente de DBM instalada: %s"
DBM_INSTANCE_INFO_RESULTS			= "Resultado del escaneo del ID de estancia. Quizas algunas estancias aparezcan más de una vez si hay jugadores que juegan a WoW con distintos idiomas en la banda."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Jugadores que aún no han contestado: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Show results now]|r|h"

DBM_CORE_LAG_CHECKING				= "Comprobando latencia de la banda..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Resultados de latencia"
DBM_CORE_LAG_ENTRY					= "%s: latencia del mundo [%d ms] / latencia del hogar [%d ms]"
DBM_CORE_LAG_FOOTER					= "Sin respuesta: %s"
