if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

DBM_CORE_NEED_SUPPORT				= "¿Se te da bien la programación o los idiomas? Si es así, el equipo de DBM necesita tu ayuda para localizar DBM a más lenguas. Si crees que puedes ayudar, visita nuestro foro |HDBM:localizersneeded|h|cff3588ffhaciendo clic aquí|r."
DBM_CORE_NEED_LOGS					= "DBM necesita registros de Transcriptor (http://www.wowace.com/addons/transcriptor/) de varios encuentros para que los módulos queden lo mejor posible. Si quieres ayudar, publica los registros de Transcriptor en nuestro foro. Por ahora solo estamos interesados en registors de mazmorra y banda de la alfa de Legion."
DBM_HOW_TO_USE_MOD					= "Bienvenido a DBM. Escribe '/dbm help' para ver la lista de comandos. Para acceder a la configuración no tienes más que escribir '/dbm'."

DBM_FORUMS_MESSAGE					= "¿Has encontrado un error o un temporizador que no funciona correctamente? ¿Crees que un módulo necesita un aviso, temporizador o función adicional?\nVisita nuestros foros de debate, comunicación de errores y petición de características en |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (haz clic para copiar la URL)."
DBM_FORUMS_COPY_URL_DIALOG			= "Visita nuestros foros de debate y asistencia técnica."
DBM_FORUMS_COPY_URL_DIALOG_NEWS		= "Para aprender más sobre esta característica y cómo funciona, visita nuestro foro."

DBM_CORE_LOAD_MOD_ERROR				= "Error al cargar el módulo de %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Módulo de '%s' cargado. Para más opciones, como alertas de sonido o notas de aviso personalizadas, escribe '/dbm'."
DBM_CORE_LOAD_MOD_COMBAT			= "Carga del módulo de '%s' aplazada hasta salir de combate."
DBM_CORE_LOAD_GUI_ERROR				= "No se ha podido cargar la interfaz: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "La interfaz no se puede cargar en combate. Se cargará la interfaz al salir de combate. Una vez cargada, podrás iniciar la interfaz en combate."
DBM_CORE_BAD_LOAD					= "DBM ha detectado que no se ha podido cargar el módulo de esta estancia porque estás en combate. Por favor, escribe '/console reloadui' nada más salir de combate."
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "No se ha podido cargar el módulo de %s porque tu módulo de DBM-Core no cumple los requisitos necesarios. Se necesita una versión más reciente."

DBM_CORE_WHATS_NEW					= "Novedades de esta versión: Se ha arreglado un error que mostraba avisos erróneos de versión desfasada. Ahora DBM nunca saltará las cinemáticas de la Costa Abrupta, sin importar la configuración de usuario. Se ha añadido el módulo de Invasiones demoníacas."

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM ha desactivado el marco de distancia dinámico para este combate debido a la falta de información sobre las diferencias según el número de jugadores."
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM ha desactivado los avisos de esbirros para este combate debido a la falta de información sobre las diferencias según el número de jugadores."
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM ha desactivado varias funciones para este combate debido a la falta de información sobre las diferencias según el número de jugadores."

DBM_CORE_LOOT_SPEC_REMINDER			= "Tu especialización es %s. Tu especialización de botín es %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM ha detectado que tienes habilitados los iconos de banda en BigWigs y DBM. Por favor, desactívalos en uno de los dos addons para evitar conflictos con la configuración de tu líder de banda."

DBM_CORE_MOD_AVAILABLE				= "El módulo de %s está disponible para este contenido. Puedes descargarlo en |HDBM:forums|h|cff3588ffdeadlybossmods.com|r o a través de Curse. Este mensaje solo se mostrará una vez."

DBM_CORE_COMBAT_STARTED				= "Encuentro de %s iniciado. ¡Buena suerte!"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "Te has unido al encuentro de %s mientras estaba en curso. ¡Buena suerte!"
DBM_CORE_GUILD_COMBAT_STARTED		= "Tu hermandad ha iniciado el encuentro de %s."
DBM_CORE_SCENARIO_STARTED			= "Iniciando la gesta %s. ¡Buena suerte!"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "Te has unido a la gesta %s mientras estaba en curso. ¡Buena suerte!"
DBM_CORE_BOSS_DOWN					= "¡%s ha sido derrotado en %s!"
DBM_CORE_BOSS_DOWN_I				= "¡%s ha sido derrotado! Tienes %d victorias en total."
DBM_CORE_BOSS_DOWN_L				= "¡%s ha sido derrotado en %s! Tu última victoria fue en %s, y tu récord actual es %s. Tienes %d victorias en total."
DBM_CORE_BOSS_DOWN_NR				= "¡%s ha sido derrotado en %s! ¡Es un nuevo récord! (El anterior era %s). Tienes %d victorias en total."
DBM_CORE_SCENARIO_COMPLETE			= "¡%s ha sido completada en %s!"
DBM_CORE_SCENARIO_COMPLETE_L		= "¡%s ha sido completada en %s! La última vez tardaste %s y tu récord es %s. La has completado %d veces en total."
DBM_CORE_SCENARIO_COMPLETE_NR		= "¡%s ha sido completada en %s! ¡Es un nuevo récord! (El anterior era %s). La has completado %d veces en total."
DBM_CORE_COMBAT_ENDED_AT			= "El encuentro de %s (%s) ha terminado en %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "El encuentro de %s (%s) ha terminado en %s. Tienes %d derrotas en total en esta dificultad."
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "Tu hermandad ha sido derrotada en el encuentro de %s (%s) en %s."
DBM_CORE_SCENARIO_ENDED_AT			= "%s ha terminado en %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s ha terminado en %s. Lo has intentado %d veces sin éxito en esta dificultad."
DBM_CORE_COMBAT_STATE_RECOVERED		= "El encuentro de %s comenzó hace %s. Recalibrando temporizadores..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Registro de Transcriptor iniciado."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Registro de Transcriptor finalizado."

DBM_CORE_MOVIE_SKIPPED				= "Cinemática saltada automáticamente."

DBM_CORE_COMBAT_STARTED_AI_TIMER	= "Mi unidad central es un procesador de red neuronal: una máquina capaz de aprender. (Este encuentro usará la nueva IA de temporizadores  para generar temporizadores aproximados.)"

DBM_CORE_PROFILE_NOT_FOUND			= "<DBM> Tu perfil actual está corrupto. DBM cargará el perfil 'Default'."
DBM_CORE_PROFILE_CREATED			= "Se ha creado el perfil '%s'."
DBM_CORE_PROFILE_CREATE_ERROR		= "No se ha podido crear el perfil. El nombre del perfil no es válido."
DBM_CORE_PROFILE_CREATE_ERROR_D		= "No se ha podido crear el perfil. Ya existe un perfil llamado '%s'."
DBM_CORE_PROFILE_APPLIED			= "Se ha cambiado el perfil actual a '%s'."
DBM_CORE_PROFILE_APPLY_ERROR		= "No se ha podido cambiar de perfil. El perfil '%s' no existe."
DBM_CORE_PROFILE_COPIED				= "Se ha copiado el perfil '%s'."
DBM_CORE_PROFILE_COPY_ERROR			= "No se ha podido copiar el perfil. El perfil '%s' no existe."
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "No se puede copiar un perfil a sí mismo."
DBM_CORE_PROFILE_DELETED			= "Se ha borrado el perfil '%s'. DBM cambiará ahora al perfil 'Default'."
DBM_CORE_PROFILE_DELETE_ERROR		= "No se ha podido borrar el perfil. El perfil '%s' no existe."
DBM_CORE_PROFILE_CANNOT_DELETE		= "No se puede borrar el perfil 'Default'."
DBM_CORE_MPROFILE_COPY_SUCCESS		= "Se ha copiado la configuración de módulo de %s (especialización %d)."
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "No se puede copiar una configuración de personaje a sí misma."
DBM_CORE_MPROFILE_COPY_S_ERROR		= "La configuración de origen está corrupta. Es posible que la configuración se haya copiado a medias o haya fallado por completo."
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "Se ha copiado la configuración de notas o sonido de módulo de %s (especialización %d)."
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "No se puede copiar una configuración de notas o sonido a sí misma."
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "La configuración de origen está corrupta. Es posible que la configuración de notas o sonido se haya copiado a medias o haya fallado por completo."
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "Se ha borrado la configuración de módulo de %s (especialización %d)."
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "No se puede borrar una configuración que está actualmente en uso."
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "La configuración de origen está corrupta. Es posible que la configuración se haya borrado a medias o haya fallado por completo."

DBM_CORE_NOTE_SHARE_SUCCESS			= "%s está compartiendo su nota para %s."
DBM_CORE_NOTE_SHARE_LINK			= "Haz clic aquí para abrir la nota"
DBM_CORE_NOTE_SHARE_FAIL			= "%s está intentando compartir su nota para %s. Sin embargo, el módulo asociado con esta facultad no está instalado o cargado. Si necesitas esta nota, asegúrate de que tienes el módulo asociado cargado y pídele que vuelva a compartirla."

DBM_CORE_NOTEHEADER					= "Introduce tu nota para %s. Los nombres de jugador entre '>' y '<' se mostrarán con el color de su clase. Para alertas con varias notas, sepáralas con '/'."
DBM_CORE_NOTEFOOTER					= "Haz clic en 'Aceptar' para guardar la nota o en 'Cancelar' para rechazarla."
DBM_CORE_NOTESHAREDHEADER			= "%s está compartiendo esta nota para %s. Si la aceptas, sobrescribirá tu nota actual."
DBM_CORE_NOTESHARED					= "Se ha enviado tu nota al grupo."
DBM_CORE_NOTESHAREERRORSOLO			= "¿Te sientes solo? Compartir notas contigo mismo no tiene sentido alguno."
DBM_CORE_NOTESHAREERRORBLANK		= "No se puede compartir notas en blanco."
DBM_CORE_NOTESHAREERRORGROUPFINDER	= "No se puede compartir notas en campos de batalla, buscador de bandas y buscador de grupo."
DBM_CORE_NOTESHAREERRORALREADYOPEN	= "No se puede abrir notas compartidas con el editor de notas ya abierto."

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "Se han cargado las opciones por defecto de todos los módulos de esta estancia."
DBM_CORE_ALLMOD_STATS_RESETED		= "Se han restaurado todas las estadísticas de este módulo."
DBM_CORE_MOD_DEFAULT_LOADED			= "Se han cargado las opciones por defecto de este encuentro."

DBM_CORE_WORLDBOSS_ENGAGED			= "Es posible que el encuentro de %s se haya iniciado en tu reino a %s de su salud máxima. (Enviado por %s.)"
DBM_CORE_WORLDBOSS_DEFEATED			= "Es posible que %s haya sido derrotado en tu reino. (Enviado por %s.)"

DBM_CORE_TIMER_FORMAT_SECS			= "%.2f |4segundo:segundos;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minuto:minutos;"
DBM_CORE_TIMER_FORMAT				= "%d |4minuto:minutos; y %.2f |4segundo:segundos;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "s"
DBM_CORE_SEC_FMT					= "%s s"

DBM_CORE_GENERIC_WARNING_OTHERS		= "y otro"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "y otros %d"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Rabia en %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Rabia"
DBM_CORE_OPTION_TIMER_BERSERK		= "Mostrar tiempo restante para $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Comienza el encuentro"
DBM_CORE_OPTION_TIMER_COMBAT		= "Mostrar temporizador para el inicio del encuentro"
DBM_CORE_OPTION_HEALTH_FRAME		= "Mostrar marco de salud del jefe"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "Barras"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "Anuncios generales"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "Anuncios personales"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "Anuncios de objetivos"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "Anuncios de rol"
DBM_CORE_OPTION_CATEGORY_SOUNDS			= "Sonidos"

DBM_CORE_AUTO_RESPONDED				= "Respondido automáticamente."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d jugadores vivos."
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s está ocupado con el encuentro de %s (%s, %d/%d jugadores vivos)."
DBM_CORE_WHISPER_COMBAT_END_KILL			= "¡%s ha derrotado a %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "¡%s ha derrotado a %s! Tiene %d victorias en total."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s ha sido derrotado en el encuentro de %s (%s)."
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s ha sido derrotado en el encuentro de %s (%s). Tiene %d derrotas en total en esta dificultad."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s está ocupado con la gesta %s (%d/%d jugadores vivos)."
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "¡%s ha completado %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "¡%s ha completado %s! Tiene %d victorias en total."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s no ha completado %s."
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s no ha completado %s. Lo ha intentado sin éxito %d veces en total en esta dificultad."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versiones"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) y %s (r%d)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: Sin instalar"
DBM_CORE_VERSIONCHECK_FOOTER		= "Se ha encontrado %d jugador(es) con DBM y %d jugador(es) con BigWigs."
DBM_CORE_YOUR_VERSION_OUTDATED      = "Tu versión de Deadly Boss Mods está desfasada. Por favor, visita www.deadlybossmods.com para descargar la última versión."
DBM_CORE_VOICE_PACK_OUTDATED		= "A este paquete de voces le faltan sonidos compatibles con esta versión de DBM. No se sustituirán los sonidos de avisos especiales que no tengan sustituto. Por favor, descarga una versión más reciente del paquete de voces o contacta con el autor para informarle de los archivos de sonido que faltan."
DBM_CORE_VOICE_MISSING				= "Tenías seleccionado un paquete de voces que no se ha podido encontrar. Se ha restaurado tu selección a 'Ninguno'. Si crees que se trata de un error, asegúrate de que el paquete de voces se haya instalado correctamente y esté habilitado en la lista de Addons."
DBM_CORE_VOICE_COUNT_MISSING		= "La voz de cuenta atrás %d está asignada a un paquete de voces que no se ha podido encontrar. Se ha restaurado a la configuración por defecto."
DBM_BIG_WIGS						= "BigWigs"
DBM_BIG_WIGS_ALPHA					= "BigWigs Alpha"

DBM_CORE_UPDATEREMINDER_HEADER			= "Tu versión de Deadly Boss Mods está desfasada.\nPuedes descargar la versión %s (r%d) a través de Curse, WoWInterface o aquí:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "Tu versión alfa de Deadly Boss Mods está desfasada.\nEstás por lo menos %d versiones por detrás. Se recomienda a los usuarios que usen siempre la última versión alfa. De lo contrario, sería más recomendable usar la última versión oficial. Las versiones alfa tienen una comprobación de versión mucho más estricta porque son versiones de desarrollo de DBM."
DBM_CORE_UPDATEREMINDER_FOOTER			= "Pulsa " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " para copiar el enlace de descarga en tu portapapeles."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Pulsa " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " para copiar el enlace en tu portapapeles."
DBM_CORE_UPDATEREMINDER_DISABLE			= "AVISO: Se ha desactivado Deadly Boss Mods porque tu versión está demasiado desfasada. Con tal de prevenir conflictos con las versiones de otros jugadores, no se podrá volver a activar DBM hasta que lo actualices."
DBM_CORE_UPDATEREMINDER_HOTFIX			= "Tu versión de DBM actual tiene errores conocidos en este encuentro. Por favor, actualiza a la última versión."
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= "Tu versión de DBM actual tiene errores conocidos en este encuentro. Estos errores serán corregidos en la próxima versión (o ya están corregidos en la última versión alfa)."
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "AVISO: Se ha desactivado Deadly Boss Mods porque tu versión está demasiado desfasada. Como se trata de un parche de contenido importante, y con tal de prevenir conflictos con las versiones de otros jugadores, no se podrá volver a activar DBM hasta que lo actualices."
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "AVISO: Estás usando una versión de Deadly Boss Mods que no ha sido diseñada para esta versión del juego. Por favor, asegúrate de descargar la versión apropiada para tu cliente de juego desde www.deadlybossmods.com o Curse."
DBM_CORE_VEM							= "AVISO: Estás ejecutando Deadly Boss Mods y Voice Encounter Mods a la vez. DBM no funciona correctamente con esta configuración, y por tanto no se ejecutará."
DBM_CORE_3RDPROFILES					= "AVISO: DBM-Profiles no es compatible con esta versión de DBM. Con tal de evitar conflictos, DBM no se ejecutará hasta que borres tu DBM-Profiles actual."
DBM_CORE_DPMCORE						= "AVISO: Deadly PvP Mods ya no está en desarrollo y no es compatible con esta versión de DBM. Con tal de evitar conflictos, DBM no se ejecutará hasta que borres Deadly PvP Mods."
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "AVISO: Esta actualización de DBM no funcionará correctamente hasta que reinicies el juego. Esta versión contiene nuevos archivos o cambios a los archivos .toc que no pueden recargarse mediante /reload. Es muy probable que DBM no funcione correctamente hasta que reinicies el juego."
DBM_CORE_OUT_OF_DATE_NAG				= "Tu versión de Deadly Boss Mods está desfasada para este encuentro. Se recomienda que actualices DBM para no perderte ningún aviso, temporizador o indicador crucial para tu grupo de banda."

DBM_CORE_MOVABLE_BAR				= "¡Muéveme!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h ha compartido un temporizador de DBM: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancelar este temporizador]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar temporizadores de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "¿Seguro que quieres ignorar los temporizadores de %s para esta sesión?"
DBM_PIZZA_ERROR_USAGE				= "Uso: /dbm [broadcast] timer <seg> <texto>. <seg> debe ser mayor que 1."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "MAYÚS-Clic izquierdo o Clic derecho para mover este botón.\nAlt-MAYÚS-Clic izquierdo para moverlo libremente."

DBM_CORE_RANGECHECK_HEADER			= "Comprobación de distancia (%d m)"
DBM_CORE_RANGECHECK_SETRANGE		= "Ajustar distancia"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "Ajustar límite de jugadores"
DBM_CORE_RANGECHECK_SOUNDS			= "Sonidos"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Sonido si un jugador está a distancia"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Sonido si más de un jugador está a distancia"
DBM_CORE_RANGECHECK_SOUND_0			= "Sin sonido"
DBM_CORE_RANGECHECK_SOUND_1			= "Sonido por defecto"
DBM_CORE_RANGECHECK_SOUND_2			= "Pitido"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d m"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Marcos"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Mostrar marco de radar"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Mostrar marco de texto"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Mostrar ambos"
DBM_CORE_RANGERADAR_HEADER			= "Radar (%d m)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d a distancia (%d m)"--Multi
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1f m)"--One target

DBM_CORE_INFOFRAME_SHOW_SELF			= "Mostrar siempre tu información"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Invitación del buscador"

DBM_CORE_SLASHCMD_HELP				= {
	"Comandos disponibles:",
	"-----------------",
	"/dbm unlock: Muestra un temporizador de ejemplo desplazable (alias: move).",
	"/range <número> o /distance <número>: Muestra el marco de distancia. /rrange y /rdistance invierten el color.",
	"/hudar <número>: Muestra el indicador de distancia en pantalla.",
	"/dbm timer: Inicia un temporizador personalizado de DBM. Consulta '/dbm timer' para más detalles.",
	"/dbm arrow: Muestra la flecha de DBM. Consulta '/dbm arrow help' para más detalles.",
	"/dbm hud: Muestra el indicador en pantalla de DBM. Escribe '/dbm hud' para más detalles.",
	"/dbm help2: Lista los comandos de banda de DBM."
}

DBM_CORE_SLASHCMD_HELP2				= {
	"Comandos disponibles:",
	"-----------------",
	"/dbm pull <seg>: Inicia un temporizador de inicio de encuentro para toda la banda (requiere líder o ayudante) (alias: pull).",
	"/dbm break <min>: Inicia un temporizador de descanso para toda la banda (requiere líder o ayudante) (alias: break).",
	"/dbm version: Realiza una comprobación de versión de DBM a toda la banda (alias: ver).",
	"/dbm version2: Realiza una comprobación de versión de DBM que también susurra a los jugadores con versiones desfasadas (alias: ver2).",
	"/dbm lockout: Realiza una comprobación de registros de banda a toda la banda (requiere líder o ayudante) (alias: lockouts, ids).",
	"/dbm lag: Realiza una comprobación de latencia a toda la banda."
}

DBM_CORE_TIMER_USAGE	= {
	"DBM timer commands:",
	"-----------------",
	"/dbm timer <seg> <texto>: Inicia un temporizador con texto.",
	"/dbm ctimer <seg> <texto>: Inicia un temporizador con texto de cuenta atrás.",
	"/dbm ltimer <seg> <texto>: Inicia un temporizador que se repite hasta que se cancela.",
	"/dbm cltimer <seg> <texto>: Inicia un temporizador con texto de cuenta atrás que se repite hasta que se cancela.",
	"(Si escribes 'broadcast' delante de un temporizador, lo compartirás con tu grupo de banda si eres líder o ayudante)",
	"/dbm timer endloop: Cancela todos los ltimer o cltimer que se estén repitiendo."
}

DBM_ERROR_NO_PERMISSION				= "No tienes permiso para hacer eso."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Ocultar marco de salud"

DBM_CORE_UNKNOWN					= "Desconocido"--UNKNOWN which is "Unknown" (does u vs U matter?)
DBM_CORE_LEFT						= "Izquierda"
DBM_CORE_RIGHT						= "Derecha"
DBM_CORE_BACK						= "Detrás"--BACK
DBM_CORE_MIDDLE						= "En medio"
DBM_CORE_FRONT						= "Delante"
DBM_CORE_INTERMISSION				= "Interfase"--No blizz global for this, and will probably be used in most end tier fights with intermission phases

DBM_CORE_BREAK_USAGE				= "El temporizador de descanso no puede durar más de 60 minutos. Asegúrate de que has escrito el tiempo en minutos y no en segundos."
DBM_CORE_BREAK_START				= "El descanso comienza ahora. ¡Tienes %s! (Enviado por %s)"
DBM_CORE_BREAK_MIN					= "¡El descanso termina en %s minuto(s)!"
DBM_CORE_BREAK_SEC					= "¡El descanso termina en %s segundo(s)!"
DBM_CORE_TIMER_BREAK				= "¡Toca descanso!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "El descanso ha terminado."

DBM_CORE_TIMER_PULL					= "Iniciando en"
DBM_CORE_ANNOUNCE_PULL				= "Iniciando en %d s (iniciado por %s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "¡Iniciad ahora!"
DBM_CORE_ANNOUNCE_PULL_TARGET		= "Llamando a %s en %d s (iniciado por %s)"
DBM_CORE_ANNOUNCE_PULL_NOW_TARGET	= "¡Llamando a %s!"
DBM_CORE_GEAR_WARNING				= "Aviso: Comprobación de equipo. Tu nivel de objeto equipado es %d menor que tu nivel de objeto de inventario."
DBM_CORE_GEAR_WARNING_WEAPON		= "Aviso: Comprueba que tu arma esté equipada."
DBM_CORE_GEAR_FISHING_POLE			= "Caña de pescar"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Logro"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	you			= "%s en ti",
	target		= "%s en >%%s<",
	targetcount	= "%s (%%s) en >%%s<",
	spell		= "%s",
	ends 		= "%s ha terminado",
	endtarget	= "%s ha terminado en >%%s<",
	fades		= "%s ha terminado",
	adds		= "%s restantes: %%d",
	cast		= "Lanzando %s en %.1f s",
	soon		= "%s en breve",
	prewarn		= "%s en %s",
	phase		= "Fase %s",
	prephase	= "Fase %s en breve",
	count		= "%s (%%s)",
	stack		= "%s en >%%s< (%%d)"
}

local prewarnOption = "Mostrar aviso previo para $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	you			= "Anunciar que te afecta $spell:%s",
	target		= "Anunciar objetivos de $spell:%s",
	targetcount	= "Anunciar objetivos de $spell:%s (con contador)",
	spell		= "Mostrar aviso para $spell:%s",
	ends		= "Mostrar aviso cuando termine $spell:%s",
	endtarget	= "Mostrar aviso cuando termine $spell:%s",
	fades		= "Mostrar aviso cuando expire $spell:%s",
	adds		= "Anunciar el número de $spell:%s restantes",
	cast		= "Mostrar aviso cuando se esté lanzando $spell:%s",
	soon		= prewarnOption,
	prewarn 	= prewarnOption,
	phase		= "Anunciar cambio a Fase %s",
	phasechange	= "Anunciar cambios de fase",
	prephase	= "Mostrar aviso previo para Fase %s",
	count		= "Mostrar aviso (con contador) para $spell:%s",
	stack		= "Anunciar acumulaciones de $spell:%s"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell			= "¡%s!",
	ends			= "%s ha terminado",
	fades			= "%s ha terminado",
	soon			= "%s en breve",
	prewarn			= "%s en %s",
	dispel			= "%s en >%%s< - ¡disipa ahora!",
	interrupt		= "%s - ¡interrumpe a >%%s<!",
	interruptcount	= "%s - ¡interrumpe a >%%s<! (%%d)",
	you				= "%s en ti",
	youcount		= "%s (%%s) en ti",
	youpos			= "%s (posición: %%s) en ti",
	soakpos			= "%s (posición: %%s)",
	target			= "%s en >%%s<",
	targetcount		= "%s (%%s) en >%%s< ",
	defensive		= "%s - ¡facultad defensiva ahora!",
	taunt			= "%s en >%%s< - ¡provoca ahora!",
	close			= "%s en >%%s< cerca de ti",
	move			= "%s - ¡sal de ahí!",
	dodge			= "%s - ¡esquiva!",
	moveaway		= "%s - ¡aléjate de los demás!",
	moveto			= "%s - ¡ve a >%%s<!",
	jump			= "%s - ¡salta!",
	run				= "%s - ¡huye!",
	cast			= "%s - ¡deja de canalizar!",
	reflect			= "%s en >%%s< - ¡no ataques!",
	count			= "¡%s! (%%s)",
	stack			= "%%d acumulaciones de %s en ti",
	switch			= "%s - ¡cambia de objetivo!",
	switchcount		= "%s - ¡cambia de objetivo! (%%s)"
}

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell 			= "Mostrar aviso especial para $spell:%s",
	ends 			= "Mostrar aviso especial cuando termine $spell:%s",
	fades 			= "Mostrar aviso especial cuando expire $spell:%s",
	soon 			= "Mostrar aviso previo especial para $spell:%s",
	prewarn 		= "Mostrar aviso previo especial %s s antes de $spell:%s",
	dispel 			= "Mostrar aviso especial para disipar $spell:%s",
	interrupt		= "Mostrar aviso especial para interrumpir $spell:%s",
	interruptcount	= "Mostrar aviso especial (con contador) para interrumpir $spell:%s",
	you 			= "Mostrar aviso especial cuando te afecte $spell:%s",
	youcount		= "Mostrar aviso especial (con contador) cuando te afecte $spell:%s",
	youpos			= "Mostrar aviso especial (con posición) cuando te afecte $spell:%s",
	soakpos			= "Mostrar aviso especial (con posición) para acompañar a los jugadores afectados por $spell:%s",
	target 			= "Mostrar aviso especial cuando $spell:%s afecte a un jugador",
	targetcount 	= "Mostrar aviso especial (con contador) cuando $spell:%s afecte a un jugador",
	defensive 		= "Mostrar aviso especial para usar mitigaciones para $spell:%s",
	taunt 			= "Mostrar aviso especial para provocar cuando el otro tanque sea afectado por $spell:%s",
	close 			= "Mostrar aviso especial cuando un jugador cercano sea afectado por $spell:%s",
	move 			= "Mostrar aviso especial para salir de $spell:%s",
	dodge 			= "Mostrar aviso especial para esquivar $spell:%s",
	moveaway		= "Mostrar aviso especial para alejarse de los demás jugadores durante $spell:%s",
	moveto			= "Mostrar aviso especial para juntarse con los jugadores afectados por $spell:%s",
	jump			= "Mostrar aviso especial para saltar para $spell:%s",
	run 			= "Mostrar aviso especial para huir de $spell:%s",
	cast 			= "Mostrar aviso especial para dejar de canalizar durante $spell:%s",--Spell Interrupt
	reflect 		= "Mostrar aviso especial para dejar de atacar durante $spell:%s",--Spell Reflect
	count 			= "Mostrar aviso especial (con contador) para $spell:%s",
	stack 			= "Mostrar aviso especial cuando tengas %d ó más acumulaciones de $spell:%s",
	switch			= "Mostrar aviso especial para cambiar de objetivo a $spell:%s",
	switchcount		= "Mostrar aviso especial (con contador) para cambiar de objetivo a $spell:%s"
}

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target		= "%s: %%s",
	cast		= "%s",
	active		= "%s termina",--Buff/Debuff/event on boss
	fades		= "%s expira",--Buff/Debuff on players
	ai			= "IA de %s",
	cd			= "%s TdR",
	cdcount		= "%s TdR (%%d)",
	cdsource	= "%s TdR: >%%s<<",
	cdspecial	= "Facultad especial TdR",
	next		= "Siguiente %s",
	nextcount	= "Siguiente %s (%%s)",
	nextsource	= "Siguiente %s: %%s",
	nextspecial	= "Siguiente facultad especial",
	achievement	= "Logro: %s",
	phase		= "Siguiente fase",
	roleplay	= "Diálogo"
}


DBM_CORE_AUTO_TIMER_OPTIONS = {
	target		= "Mostrar temporizador para la duración del perjuicio de $spell:%s",
	cast		= "Mostrar temporizador para el lanzamiento de $spell:%s",
	active		= "Mostrar temporizador para la duración de $spell:%s",
	fades		= "Mostrar temporizador para el tiempo restante del perjuicio de $spell:%s en los jugadores",
	ai			= "Mostrar temporizador inteligente para el tiempo de reutilización de $spell:%s",
	cd			= "Mostrar temporizador para el tiempo de reutilización de $spell:%s",
	cdcount		= "Mostrar temporizador (con contador) para el tiempo de reutilización de $spell:%s",
	cdsource	= "Mostrar temporizador (y quién lo lanza) para el tiempo de reutilización de $spell:%s",
	cdspecial	= "Mostrar temporizador para el tiempo de reutilización de 'Facultad especial'.",
	next		= "Mostrar temporizador para el siguiente $spell:%s",
	nextcount	= "Mostrar temporizador (con contador) para el siguiente $spell:%s",
	nextsource	= "Mostrar temporizador (y quién lo lanza) para el siguiente $spell:%s",
	nextspecial	= "Mostrar temporizador para la siguiente 'Facultad especial'.",
	achievement	= "Mostrar temporizador para el logro %s",
	phase		= "Mostrar temporizador para la siguiente fase",
	roleplay	= "Mostrar temporizador para la duración del diálogo"
}

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Poner iconos en los objetivos de $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Poner iconos en $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "Mostrar flecha indicadora para juntarse con los objetivos afectados por $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "Mostrar flecha indicadora para alejarse de los objetivos afectados por $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "Mostrar flecha indicadora para ir a una ubicación específica para $spell:%s"
DBM_CORE_AUTO_VOICE_OPTION_TEXT			= "Reproducir alertas de voz para $spell:%s"
DBM_CORE_AUTO_VOICE2_OPTION_TEXT		= "Reproducir alertas de voz para los cambios de fase"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Reproducir sonido de cuenta atrás para el tiempo de reutilización de $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "Reproducir sonido de cuenta atrás para la duración restante de $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Reproducir sonido de contador para la duración de $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT = {
	yell		= "Gritar cuando te afecte $spell:%s",
	count		= "Gritar (con contador) cuando te afecte $spell:%s",
	fade		= "Gritar (con tiempo de reutilización) cuando $spell:%s esté a punto de expirar",
	position	= "Gritar (con posición) cuando te afecte $spell:%s"
}
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT = {
	yell		= "¡%s en " .. UnitName("player") .. "!",
	count		= "¡%s en " .. UnitName("player") .. "! (%%d)",
	fade		= "%s expirando en %%d",
	position 	= "%s %%s en {rt%%d}"..UnitName("player").."{rt%%d}"
}
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "Mostrar indicador en pantalla para $spell:%s"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "Mostrar indicadores en pantalla para varias mecánicas"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Mostrar marco de distancia (%s m) para $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Mostrar marco de distancia (%s m)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "Mostrar marco de distancia inverso (%s m) para $spell:%s"--Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "Mostrar marco de distancia inverso (%s m)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Mostrar marco de información para $spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Reproducir sonido de comprobación de banda cuando se inicie el encuentro (aunque no lo tengas como objetivo)"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "Anuncio desplazable"
DBM_CORE_MOVE_WARNING_MESSAGE		= "Gracias por usar Deadly Boss Mods"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Aviso especial desplazable"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Aviso especial"

DBM_CORE_HUD_INVALID_TYPE			= "No se ha proporcionado un tipo de indicador en pantalla válido."
DBM_CORE_HUD_INVALID_TARGET			= "No se ha proporcionado un objetivo válido."
DBM_CORE_HUD_INVALID_SELF			= "No puedes usarte a ti mismo como objetivo."
DBM_CORE_HUD_INVALID_ICON			= "No se puede usar el tipo icono en un objetivo sin icono."
DBM_CORE_HUD_SUCCESS				= "Indicador en pantalla realizado con éxito. Expirará en %s o al escribir '/dbm hud hide'."
DBM_CORE_HUD_USAGE	= {
	"Uso de DBM-HudMap:",
	"-----------------",
	"/dbm hud <tipo> <objetivo> <seg>: Crea un indicador en pantalla que apunta al jugador objetivo durante el tiempo designado.",
	"Tipos válidos: arrow, dot, red, blue, green, yellow, icon (requiere un objetivo con icono de banda)",
	"Objetivos válidos: target, focus, <jugador>",
	"Duraciones válidas: cualquier número (en segundos). Si se deja en blanco, durará 20 minutos.",
	"/dbm hud hide: cancela y oculta el indicador en pantalla."
}

DBM_ARROW_MOVABLE					= "Flecha desplazable"
DBM_ARROW_ERROR_USAGE	= {
	"Uso de DBM-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: Crea una flecha que apunta a una ubicación específica (merdiante coordenadas de mundo).",
	"/dbm arrow map <x> <y>: Crea una flecha que apunta a una ubicación específica (mediante coordenadas de zona).",
	"/dbm arrow <jugador>: Crea una flecha que apunta al jugador específico de tu grupo o banda.",
	"/dbm arrow hide: Oculta la flecha.",
	"/dbm arrow move: Permite mover la flecha."
}

DBM_SPEED_KILL_TIMER_TEXT	= "Superar récord"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Récord actual"
DBM_COMBAT_RES_TIMER_TEXT	= "Siguiente resurrección"
DBM_CORE_TIMER_RESPAWN		= "Jefe reaparece"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s ha solicitado ver tu registro de estancias actual.\n¿Quieres compartir esta información con %s?."
DBM_ERROR_NO_RAID					= "Tienes que estar en un grupo de banda para usar esta característica."
DBM_INSTANCE_INFO_REQUESTED			= "Se ha enviado una solicitud al grupo de banda.\nPor favor, ten en cuenta que los jugadores deben aceptarla para que puedas recibir los datos."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Se ha recibido datos de %d de %d jugadores con DBM: %d han compartido sus datos, %d han rechazado la petición. Esperando %d segundos más..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Se ha recibido datos de todos los miembros de la banda."
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Personaje: %s Resultado: %s Estancia: %s ID: %s Dificultad: %d Tamaño: %d Jefes: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, dificultad %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, %d jefes: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    %d jefes: %s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "Tu grupo de banda no tiene registros de estancia."
DBM_INSTANCE_INFO_STATS_DENIED		= "Petición rechazada: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Ausente: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Sin versión de DBM compatible: %s"
DBM_INSTANCE_INFO_RESULTS			= "Resultados de la comprobación de registros de estancia. Ten en cuenta que una misma estancia puede salir varias veces si hay jugadores en tu banda con el cliente de juego en un idioma distinto."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Jugadores que todavía no han respondido:: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Mostrar resultados]|r|h"

DBM_CORE_LAG_CHECKING				= "Comprobando latencia de la banda..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Resultados de latencia"
DBM_CORE_LAG_ENTRY					= "%s: Latencia de mundo [%d ms] / Latencia de hogar [%d ms]"
DBM_CORE_LAG_FOOTER					= "Sin respuesta: %s"
