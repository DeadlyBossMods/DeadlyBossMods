if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD			= "Bienvenido a " .. L.DBM .. ". Escribe '/dbm help' para ver la lista de comandos. Para acceder a la configuración no tienes más que escribir '/dbm'."
L.SILENT_REMINDER			= "Recordatorio: " .. L.DBM .. " sigue en modo silencioso."
L.NEWS_UPDATE				= "|h|c11ff1111Noticias|r|h: Esta actualización cambia la estructura del módulo para que ahora el clásico y el juego principal utilizan módulos unificados (iguales). Esto significa que los módulos de Vanilla, TBC, Wrath y Cata ahora se instalan por separado utilizando los mismos paquetes que el juego original. Lee más al respecto |Hgarrmission:DBM:news|h|cff3588ff[aquí]|r|h"
L.NEWS_UPDATE_REPEAT 		= "|h|c11ff1111Noticias|r|h: Esta actualización cambia la estructura del módulo para que ahora el clásico y el juego principal utilizan módulos unificados (iguales). Esto significa que los módulos de Vanilla, TBC, Wrath y Cata ahora se instalan por separado utilizando los mismos paquetes que el juego original. Actualmente estás en una banda que tiene un módulo faltante. Este mensaje seguirá apareciendo (y no tendrás anuncios funcionales para esta zona) hasta que hayas instalado el módulo de banda faltante."

L.COPY_URL_DIALOG_NEWS		= "Para leer las últimas noticias, visita el enlace a continuación"

L.LOAD_MOD_ERROR			= "Error al cargar el módulo de %s: %s"
L.LOAD_MOD_SUCCESS			= "Módulo de '%s' cargado. Para más opciones, como alertas de sonido o notas de aviso personalizadas, escribe '/dbm'."
L.LOAD_MOD_COMBAT			= "Carga del módulo de '%s' aplazada hasta salir de combate."
L.LOAD_GUI_ERROR			= "No se ha podido cargar la interfaz: %s"
L.LOAD_GUI_COMBAT			= "La interfaz no se puede cargar en combate. Se cargará la interfaz al salir de combate. Una vez cargada, podrás iniciar la interfaz en combate."
L.BAD_LOAD					= L.DBM .. " ha detectado que no se ha podido cargar el módulo de esta estancia porque estás en combate. Por favor, escribe '/console reloadui' nada más salir de combate."
L.LOAD_MOD_VER_MISMATCH		= "No se ha podido cargar el módulo de %s porque tu módulo de DBM-Core no cumple los requisitos necesarios. Se necesita una versión más reciente."
L.LOAD_MOD_EXP_MISMATCH		= "No se ha podido cargar el módulo de %s porque está diseñado para una expansión que aún no se encuentra disponible. Este módulo se activará automáticamente cuando salga la nueva expansión."
L.LOAD_MOD_TOC_MISMATCH		= "No se ha podido cargar el módulo de %s porque está diseñado para un parche de WoW que aún no se encuentra disponible. Este módulo se activará automáticamente cuando salga dicho parche."
L.LOAD_MOD_DISABLED			= "%s está instalado pero se encuentra desactivado. Este módulo no se cargará hasta que lo actives."
L.LOAD_MOD_DISABLED_PLURAL	= "%s están instalados pero se encuentran desactivados. Estos módulos no se cargarán hasta que los actives."

L.COPY_URL_DIALOG			= "Copiar vínculo"
L.COPY_WA_DIALOG			= "Copiar clave WA"

--Post Patch 7.1
L.TEXT_ONLY_RANGE			= "El marco de distancia está limitado a texto únicamente debido a restricciones de API en esta área."
L.NO_RANGE					= "No se puede usar el radar de distancia en estancias. Se procederá a usar el marco de distancia por texto."
L.NO_ARROW					= "No se puede usar la flecha en estancias."
L.NO_HUD					= "No se puede usar el indicador en pantalla en estancias."

L.DYNAMIC_DIFFICULTY_CLUMP	= L.DBM .. " ha desactivado el marco de distancia dinámico para este combate debido a la falta de información sobre las diferencias según el número de jugadores."
L.DYNAMIC_ADD_COUNT			= L.DBM .. " ha desactivado los anuncios de esbirros para este combate debido a la falta de información sobre las diferencias según el número de jugadores."
L.DYNAMIC_MULTIPLE			= L.DBM .. " ha desactivado varias funciones para este combate debido a la falta de información sobre las diferencias según el número de jugadores."

L.LOOT_SPEC_REMINDER		= "Tu especialización es %s. La opción de botín seleccionada es %s."

L.BIGWIGS_ICON_CONFLICT		= L.DBM .. " ha detectado que tienes activados los iconos de banda en BigWigs y " .. L.DBM .. ". Por favor, desactívalos en uno de los dos addons para evitar conflictos con la configuración de tu líder de banda."

L.MOD_AVAILABLE				= "El módulo de %s está disponible para este contenido. Puedes descargarlo a través de Curse, Wago, Github o WoWInterface."
L.MOD_MISSING				= "Sin módulo de banda"

L.COMBAT_STARTED				= "Encuentro de %s iniciado. ¡Buena suerte!"
L.COMBAT_STARTED_IN_PROGRESS	= "Te has unido al encuentro de %s mientras estaba en curso. ¡Buena suerte!"
L.GUILD_COMBAT_STARTED			= "El encuentro de %s has sido iniciado por el grupo de hermandad de %s."
L.SCENARIO_STARTED				= "%s iniciado. ¡Buena suerte!"
L.SCENARIO_STARTED_IN_PROGRESS	= "Te has unido al escenario de %s mientras estaba en curso. ¡Buena suerte!"
L.BOSS_DOWN						= "¡%s ha sido derrotado en %s!"
L.BOSS_DOWN_I					= "¡%s ha sido derrotado! Tienes %d victorias en total."
L.BOSS_DOWN_L					= "¡%s ha sido derrotado en %s! Tu última victoria fue en %s, y tu récord actual es %s. Tienes %d victorias en total."
L.BOSS_DOWN_NR					= "¡%s ha sido derrotado en %s! ¡Es un nuevo récord! (El anterior era %s). Tienes %d victorias en total."
L.RAID_DOWN						= "¡%s ha sido completado en %s!"
L.RAID_DOWN_L					= "¡%s ha sido completado en %s! Tu récord actual es %s."
L.RAID_DOWN_NR					= "¡%s ha sido completado en %s! ¡Es un nuevo récord! (El anterior era %s)."
L.GUILD_BOSS_DOWN				= "¡%s ha sido derrotado por el grupo de hermandad de %s en %s!"
L.SCENARIO_COMPLETE				= "¡%s ha sido completado en %s!"
L.SCENARIO_COMPLETE_I			= "¡%s ha sido completado! Lo has completado %d veces en total."
L.SCENARIO_COMPLETE_L			= "¡%s ha sido completado en %s! La última vez tardaste %s y tu récord es %s. Lo has completado %d veces en total."
L.SCENARIO_COMPLETE_NR			= "¡%s ha sido completado en %s! ¡Es un nuevo récord! (El anterior era %s). Lo has completado %d veces en total."
L.COMBAT_ENDED_AT				= "El encuentro de %s (%s) ha terminado en %s."
L.COMBAT_ENDED_AT_LONG			= "El encuentro de %s (%s) ha terminado en %s. Tienes %d derrotas en total en esta dificultad."
L.GUILD_COMBAT_ENDED_AT			= "El grupo de hermandad de %s ha sido derrotado en el encuentro de %s (%s) en %s."
L.SCENARIO_ENDED_AT				= "%s ha terminado en %s."
L.SCENARIO_ENDED_AT_LONG		= "%s ha terminado en %s. Lo has intentado %d veces sin éxito en esta dificultad."
L.COMBAT_STATE_RECOVERED		= "El encuentro de %s inició hace %s. Recalibrando temporizadores..."
L.TRANSCRIPTOR_LOG_START		= "Registro de Transcriptor iniciado."
L.TRANSCRIPTOR_LOG_END			= "Registro de Transcriptor finalizado."

L.MOVIE_SKIPPED				= "Cinemática saltada automáticamente."
L.MOVIE_NOTSKIPPED			= L.DBM .. " ha detectado una escena de corte que se puede omitir pero NO la ha omitido debido a un error de Blizzard. Cuando se solucione este error, se volverá a habilitar la omisión"
L.BONUS_SKIPPED				= L.DBM .. " ha cerrado automáticamente la ventana de bonus de botín. Si quieres abrirla, escribe /dbmbonusroll antes de que pasen 3 minutos."

L.AFK_WARNING				= "Estás ausente y en combate (%d por cierto de salud restante); se procederá a reproducir un sonido de alerta. Sino estás ausente, quítate el estado o desactiva esta opción en 'Funciones adicionales'."
L.LOWHEALTH_WARNING			= "Salud baja (%d por ciento de salud restante), reproduciendo alerta sonora. Puedes desactivar esta opción en 'Funciones adicionales'."
L.ENTERING_COMBAT			= "Entrando en combate"
L.LEAVING_COMBAT			= "Saliendo del combate"

L.COMBAT_STARTED_AI_TIMER	= "Mi unidad central es un procesador de red neuronal: una máquina capaz de aprender. (Este encuentro usará la IA de temporizadores para generar temporizadores aproximados.)"

L.PROFILE_NOT_FOUND				= "<" .. L.DBM .. "> Tu perfil actual está corrupto. " .. L.DBM .. " cargará el perfil 'Predeterminado'."
L.PROFILE_CREATED				= "Se ha creado el perfil '%s'."
L.PROFILE_CREATE_ERROR			= "No se ha podido crear el perfil. El nombre del perfil no es válido."
L.PROFILE_CREATE_ERROR_D		= "No se ha podido crear el perfil. Ya existe un perfil llamado '%s'."
L.PROFILE_APPLIED				= "Se ha cambiado el perfil actual a '%s'."
L.PROFILE_APPLY_ERROR			= "No se ha podido cambiar de perfil. El perfil '%s' no existe."
L.PROFILE_COPIED				= "Se ha copiado el perfil '%s'."
L.PROFILE_COPY_ERROR			= "No se ha podido copiar el perfil. El perfil '%s' no existe."
L.PROFILE_COPY_ERROR_SELF		= "No se puede copiar un perfil a sí mismo."
L.PROFILE_DELETED				= "Se ha borrado el perfil '%s'. " .. L.DBM .. " cambiará ahora al perfil 'Predeterminado'."
L.PROFILE_DELETE_ERROR			= "No se ha podido borrar el perfil. El perfil '%s' no existe."
L.PROFILE_CANNOT_DELETE			= "No se puede borrar el perfil 'Predeterminado'."
L.MPROFILE_COPY_SUCCESS			= "Se ha copiado la configuración de módulo de %s (especialización %d)."
L.MPROFILE_COPY_SELF_ERROR		= "No se puede copiar una configuración de personaje a sí misma."
L.MPROFILE_COPY_S_ERROR			= "La configuración de origen está corrupta. Es posible que la configuración se haya copiado a medias o haya fallado por completo."
L.MPROFILE_COPYS_SUCCESS		= "Se ha copiado la configuración de notas o sonido de módulo de %s (especialización %d)."
L.MPROFILE_COPYS_SELF_ERROR		= "No se puede copiar una configuración de notas o sonido a sí misma."
L.MPROFILE_COPYS_S_ERROR		= "La configuración de origen está corrupta. Es posible que la configuración de notas o sonido se haya copiado a medias o haya fallado por completo."
L.MPROFILE_DELETE_SUCCESS		= "Se ha borrado la configuración de módulo de %s (especialización %d)."
L.MPROFILE_DELETE_SELF_ERROR	= "No se puede borrar una configuración que está actualmente en uso."
L.MPROFILE_DELETE_S_ERROR		= "La configuración de origen está corrupta. Es posible que la configuración se haya borrado a medias o haya fallado por completo."

L.NOTE_SHARE_SUCCESS		= "%s está compartiendo su nota para %s."
L.NOTE_SHARE_LINK			= "Haz clic aquí para abrir la nota"
L.NOTE_SHARE_FAIL			= "%s está intentando compartir su nota para %s. Sin embargo, el módulo asociado con esta facultad no está instalado o cargado. Si necesitas esta nota, asegúrate de que tienes el módulo asociado cargado y pídele que vuelva a compartirla."

L.NOTEHEADER				= "Introduce tu nota para %s. Los nombres de jugador entre '>' y '<' se mostrarán con el color de su clase. Para alertas con varias notas, sepáralas con '/'."
L.NOTEFOOTER				= "Haz clic en 'Aceptar' para guardar la nota o en 'Cancelar' para rechazarla."
L.NOTESHAREDHEADER			= "%s está compartiendo esta nota para %s. Si la aceptas, sobrescribirá tu nota actual."
L.NOTESHARED				= "Se ha enviado tu nota al grupo."
L.NOTESHAREERRORSOLO		= "¿Te sientes solo? Compartir notas contigo mismo no tiene sentido alguno."
L.NOTESHAREERRORBLANK		= "No se puede compartir notas en blanco."
L.NOTESHAREERRORGROUPFINDER	= "No se puede compartir notas en campos de batalla, buscador de bandas y buscador de grupo."
L.NOTESHAREERRORALREADYOPEN	= "No se puede abrir notas compartidas con el editor de notas ya abierto."

L.ALLMOD_DEFAULT_LOADED		= "Se han cargado las opciones por defecto de todos los módulos de esta estancia."
L.ALLMOD_STATS_RESETED		= "Se han restablecido todas las estadísticas de este módulo."
L.MOD_DEFAULT_LOADED		= "Se han cargado las opciones por defecto de este encuentro."

L.WORLDBOSS_ENGAGED			= "Es posible que el encuentro de %s se haya iniciado en tu reino a %s de su salud máxima. (Enviado por %s.)"
L.WORLDBOSS_DEFEATED		= "Es posible que %s haya sido derrotado en tu reino. (Enviado por %s.)"
L.WORLDBUFF_STARTED			= "%s ha empezado en tu reino para la facción %s (Enviado por %s)."

L.TIMER_FORMAT_SECS			= "%.2f |4segundo:segundos;"
L.TIMER_FORMAT_MINS			= "%d |4minuto:minutos;"
L.TIMER_FORMAT				= "%d |4minuto:minutos; y %.2f |4segundo:segundos;"

L.MIN						= "min"
L.MIN_FMT					= "%d min"
L.SEC						= "s"
L.SEC_FMT					= "%s s"

L.GENERIC_WARNING_OTHERS	= "y otro"
L.GENERIC_WARNING_OTHERS2	= "y otros %d"
L.GENERIC_WARNING_BERSERK	= "Rabia en %s %s"
L.GENERIC_TIMER_BERSERK		= "Rabia"
L.OPTION_TIMER_BERSERK		= "Mostrar tiempo restante para $spell:26662"
L.BAD						= "Daño"

L.OPTION_CATEGORY_TIMERS			= "Barras"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS			= "Anuncios generales"
L.OPTION_CATEGORY_WARNINGS_YOU		= "Anuncios personales"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Anuncios de objetivos"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "Anuncios de rol"
L.OPTION_CATEGORY_SPECWARNINGS		= "Anuncios especiales"

L.OPTION_CATEGORY_SOUNDS			= "Sonidos"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS			= "Menús desplegables"
L.OPTION_CATEGORY_YELLS				= "Gritos"
L.OPTION_CATEGORY_NAMEPLATES		= "Placas de nombre"
L.OPTION_CATEGORY_ICONS				= "Iconos"
L.OPTION_CATEGORY_PAURAS			= "Auras privadas"

L.AUTO_RESPONDED					= "Respondido automáticamente."
L.STATUS_WHISPER					= "%s: %s, %d/%d jugadores vivos."
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s está ocupado con el encuentro de %s (%s, %d/%d jugadores vivos)."
L.WHISPER_COMBAT_END_KILL			= "¡%s ha derrotado a %s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "¡%s ha derrotado a %s! Tiene %d victorias en total."
L.WHISPER_COMBAT_END_WIPE_AT		= "%s ha sido derrotado en el encuentro de %s (%s)."
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s ha sido derrotado en el encuentro de %s (%s). Tiene %d derrotas en total en esta dificultad."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s está ocupado con la gesta %s (%d/%d jugadores vivos)."
L.WHISPER_SCENARIO_END_KILL			= "¡%s ha completado %s!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "¡%s ha completado %s! Tiene %d victorias en total."
L.WHISPER_SCENARIO_END_WIPE			= "%s no ha completado %s."
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s no ha completado %s. Lo ha intentado sin éxito %d veces en total en esta dificultad."

L.VERSIONCHECK_HEADER		= "Módulos de jefe - Versiones"
L.VERSIONCHECK_ENTRY		= "%s: %s (r%d)"--One Boss mod
L.VERSIONCHECK_ENTRY_TWO	= "%s: %s (r%d) y %s (r%d)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM	= "%s: Sin instalar"
L.VERSIONCHECK_FOOTER		= "Se ha encontrado %d jugador(es) con " .. L.DBM .. " y %d jugador(es) con BigWigs."
L.VERSIONCHECK_OUTDATED		= "Los siguientes %d jugadores tienen una versión desactualizada de " .. L.DBM .. ": %s"
L.YOUR_VERSION_OUTDATED		= "Tu versión de " .. L.DEADLY_BOSS_MODS .. " está desactualizada. Por favor, descarga la última versión a través de Curse, Wago, Github o WoWInterface."
L.VOICE_PACK_OUTDATED		= "A este paquete de voces le faltan sonidos compatibles con esta versión de " .. L.DBM .. ". No se sustituirán los sonidos de anuncios especiales que no tengan un sustituto. Por favor, descarga una versión más reciente del paquete de voces o contacta con el autor para informarle sobre los archivos de sonido que faltan."
L.VOICE_MISSING				= "Tenías seleccionado un paquete de voces que no se ha podido encontrar. Se ha restablecido tu selección a 'Ninguno'. Si crees que se trata de un error, asegúrate de que el paquete de voces esté instalado correctamente y activado en la lista de addons."
L.VOICE_DISABLED			= "Tienes al menos un paquete de voces de " .. L.DBM .. " instalado, pero ninguno está activado. Si quieres usar un paquete de voces, asegúrate de que lo has asignado en 'Alertas de voz'. Desinstala los paquetes de voces que no estés utilizando para ocultar este mensaje."
L.VOICE_COUNT_MISSING		= "La voz de cuenta atrás %d está asignada a un paquete de voces que no se ha podido encontrar. Se ha restablecido a la configuración predeterminada."
L.BIG_WIGS					= "BigWigs"
L.WEAKAURA_KEY				= " (|cff308530Clave WA:|r %s)"

L.UPDATEREMINDER_HEADER				= "Tu versión de " .. L.DEADLY_BOSS_MODS .. " está desactualizada.\nPuedes descargar la versión %s (%s) a través de Curse, Wago, Github o WoWInterface."
L.UPDATEREMINDER_HEADER_SUBMODULE	= "Tu módulo de %s está desactualizada.\nPuedes descargar la versión %s a través de Curse, Wago, Github o WoWInterface."
L.UPDATEREMINDER_FOOTER				= "Presiona " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar el enlace de descarga en tu portapapeles."
L.UPDATEREMINDER_FOOTER_GENERIC		= "Presiona " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar el enlace en tu portapapeles."
L.UPDATEREMINDER_DISABLE			= "AVISO: Se ha desactivado " .. L.DEADLY_BOSS_MODS .. " porque tu versión está demasiado desactualizada. Para prevenir conflictos con las versiones de otros jugadores, no se podrá volver a activar " .. L.DEADLY_BOSS_MODS .. " hasta que lo actualices."
L.UPDATEREMINDER_DISABLETEST		= "AVISO: Se ha desactivado " .. L.DEADLY_BOSS_MODS .. " porque tu versión está demasiado desactualizada y este es un reino de prueba/beta. No se podrá volver a activar " .. L.DEADLY_BOSS_MODS .. " hasta que lo actualices. Esto es para garantizar que no se utilicen modificaciones obsoletas al generar comentarios de prueba."
L.UPDATEREMINDER_HOTFIX				= "Tu versión de " .. L.DBM .. " actual tiene errores conocidos en este encuentro. Por favor, actualiza a la versión más reciente."
L.UPDATEREMINDER_HOTFIX_ALPHA		= "Tu versión de " .. L.DBM .. " actual tiene errores conocidos en este encuentro. Estos errores se corregirán en la próxima versión (o ya están corregidos en la última versión alfa)."
L.UPDATEREMINDER_MAJORPATCH			= "AVISO: Se ha desactivado " .. L.DEADLY_BOSS_MODS .. " porque tu versión está demasiado desactualizada. Dado que se trata de un parche de contenido importante, y para prevenir conflictos con las versiones de otros jugadores, no se podrá volver a activar " .. L.DEADLY_BOSS_MODS .. " hasta que lo actualices."
L.VEM								= "AVISO: Estás ejecutando " .. L.DEADLY_BOSS_MODS .. " y Voice Encounter Mods al mismo tiempo. " .. L.DBM .. " no funciona correctamente con esta configuración y, por lo tanto, no se ejecutará."
L.OUTDATEDPROFILES 					= "AVISO: DBM-Profiles no es compatible con esta versión de " .. L.DBM .. ". Para evitar conflictos, " .. L.DBM .. " no se ejecutará hasta que desactives o desinstales DBM-Profiles."
L.OUTDATEDSPELLTIMERS 				= "AVISO: DBM-SpellTimers provoca que " .. L.DBM .. " deje de funcionar. Desactívalo para que " .. L.DBM .. " funcione correctamente."
L.OUTDATEDRLT 						= "AVISO: DBM-RaidLeadTools provoca que " .. L.DBM .. " deje de funcionar. DBM-RaidLeadTools ya no es compatible con " .. L.DBM .. " y debe desactivarse para que este funcione correctamente."
L.VICTORYSOUND 						= "AVISO: DBM-VictorySound no es compatible con esta versión de " .. L.DBM .. ". Para evitar conflictos, " .. L.DBM .. " no se ejecutará hasta que desactives o desinstales DBM-VictorySound."
L.DPMCORE 							= "AVISO: Deadly PvP Mods ya no está en desarrollo y no es compatible con esta versión de " .. L.DBM .. ". Para evitar conflictos, " .. L.DBM .. " no se ejecutará hasta que borres Deadly PvP Mods."
L.DBMLDB 							= "AVISO: DBM-LDB ahora está incluido en DBM-Core. Se recomienda que borres la carpeta 'DBM-LDB' de tu carpeta de addons."
L.DBMLOOTREMINDER 					= "AVISO: Tienes instalado el módulo de terceros DBM-LootReminder. Este addon ya no es compatible con el cliente de WoW y causa conflictos con los temporizadores de " .. L.DBM .. ". Se recomienda desinstalarlo."
L.UPDATE_REQUIRES_RELAUNCH 			= "AVISO: Esta actualización de " .. L.DBM .. " no funcionará correctamente hasta que reinicies el juego. Esta versión incluye nuevos archivos o cambios en los archivos .toc que no pueden recargarse mediante /reload. Es probable que " .. L.DBM .. " no funcione correctamente hasta que reinicies el juego."
L.OUT_OF_DATE_NAG 					= "Tu versión de " .. L.DBM .. " está desactualizada para este encuentro. Se recomienda actualizar " .. L.DBM .. " para no perderte anuncios, temporizadores o indicadores cruciales para tu grupo de banda."
L.PLATER_NP_AURAS_MSG				 = L.DBM .. " incluye una función avanzada para mostrar los temporizadores de reutilización del enemigo mediante iconos en las placas de nombre. Esto está activado de forma predeterminada para la mayoría de los usuarios, pero en el caso de los usuarios de Plater, está desactivado de forma predeterminada en las opciones de Plater a menos que lo activen. Para aprovechar al máximo DBM (y Plater), se recomienda activar esta función en Plater en la sección 'Beneficio especial'. Si no deseas volver a ver este mensaje, también puedes desactivar completamente la opción 'Iconos de reutilización en las placas de nombre' en los paneles de opciones de placas de nombre o mediante la desactivación global de DBM."


L.MOVABLE_BAR					= "¡Muéveme!"

L.PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h ha compartido un temporizador de " .. L.DBM .. ": '%2$s'\n|Hgarrmission:DBM:cancel:%2$s:nil|h|cff3588ff[Cancelar este temporizador]|r|h |Hgarrmission:DBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar temporizadores de %1$s]|r|h"
L.PIZZA_CONFIRM_IGNORE			= "¿Seguro que quieres ignorar los temporizadores de %s para esta sesión?"
L.PIZZA_ERROR_USAGE				= "Uso: /dbm [broadcast] timer <seg> <texto>. <seg> debe ser mayor que 1."

L.MINIMAP_TOOLTIP_HEADER		= L.DEADLY_BOSS_MODS
L.MINIMAP_TOOLTIP_FOOTER		= "Mantén Mayús y arrastra para mover"

L.RANGECHECK_HEADER				= "Comprobación de distancia (%d m)"
L.RANGECHECK_HEADERT			= "Comprobación de distancia (%dm-%dP)"
L.RANGECHECK_RHEADER			= "Comprobación inversa de distancia (%dm)"
L.RANGECHECK_RHEADERT			= "Comprobación inversa de distancia (%dm-%dP)"
L.RANGECHECK_SETRANGE			= "Ajustar distancia"
L.RANGECHECK_SETTHRESHOLD		= "Ajustar límite de jugadores"
L.RANGECHECK_SOUNDS				= "Sonidos"
L.RANGECHECK_SOUND_OPTION_1		= "Sonido si un jugador está a distancia"
L.RANGECHECK_SOUND_OPTION_2		= "Sonido si más de un jugador está a distancia"
L.RANGECHECK_SOUND_0			= "Sin sonido"
L.RANGECHECK_SOUND_1			= "Sonido predeterminado"
L.RANGECHECK_SOUND_2			= "Pitido"
L.RANGECHECK_SETRANGE_TO		= "%d m"
L.RANGECHECK_OPTION_FRAMES		= "Marcos"
L.RANGECHECK_OPTION_RADAR		= "Mostrar marco de radar"
L.RANGECHECK_OPTION_TEXT		= "Mostrar marco de texto"
L.RANGECHECK_OPTION_BOTH		= "Mostrar ambos"
L.RANGERADAR_HEADER				= "Distancia: %d / Jugadores: %d"
L.RANGERADAR_RHEADER			= "Distancia inversa: %d / Jugadores: %d"
L.RANGERADAR_IN_RANGE_TEXT		= "%d a distancia (%0.1fm)"--Multi
L.RANGECHECK_IN_RANGE_TEXT		= "%d a distancia"	--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE	= "%s (%0.1fm)"		--One target

L.INFOFRAME_TITLE			= "Marco de info."
L.INFOFRAME_SHOW_SELF		= "Mostrar siempre tu información"	-- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES		= "Líneas máximas"
L.INFOFRAME_SETCOLS			= "Columnas máximas"
L.INFOFRAME_LINESDEFAULT	= "Establecido por módulo"
L.INFOFRAME_LINES_TO		= "%d líneas"
L.INFOFRAME_COLS_TO			= "%d columnas"
L.INFOFRAME_POWER			= "Recurso"
L.INFOFRAME_AGGRO			= "Amenaza"
L.INFOFRAME_MAIN			= "Principal:"	--Main power
L.INFOFRAME_ALT				= "Secundario:"	--Alternate Power

L.LFG_INVITE				= "Invitación del buscador"

L.SLASHCMD_HELP				= {
	"Comandos disponibles:",
	"-----------------",
	"/dbm unlock: Muestra un temporizador de ejemplo desplazable (alias: move).",
	"/range <número> o /distance <número>: Muestra el marco de distancia. /rrange y /rdistance invierten el color.",
	"/hudar <número>: Muestra el indicador de distancia en pantalla.",
	"/dbm timer: Inicia un temporizador personalizado de DBM. Escribe '/dbm timer' para más detalles.",
	"/dbm arrow: Muestra la flecha de DBM. Escribe '/dbm arrow help' para más detalles.",
	"/dbm hud: Muestra el indicador en pantalla de DBM. Escribe '/dbm hud' para más detalles.",
	"/dbm help2: Lista los comandos de banda de DBM."
}
L.SLASHCMD_HELP2				= {
	"Comandos disponibles:",
	"-----------------",
	"/dbm pull <seg>: Inicia un temporizador de inicio de encuentro para toda la banda (requiere líder o ayudante) (alias: pull).",
	"/dbm break <min>: Inicia un temporizador de descanso para toda la banda (requiere líder o ayudante) (alias: break).",
	"/dbm version: Realiza una comprobación de versión de DBM a toda la banda (alias: ver).",
	"/dbm version2: Realiza una comprobación de versión de DBM que también susurra a los jugadores con versiones desactualizadas (alias: ver2).",
	"/dbm lag: Realiza una comprobación de latencia a toda la banda.",
	"/dbm durability: Realiza una comprobación de durabilidad a toda la banda."
}
L.TIMER_USAGE	= {
	L.DBM .. " Comandos de temporizador:",
	"-----------------",
	"/dbm timer <seg> <texto>: Inicia un temporizador con texto.",
	"/dbm ltimer <seg> <texto>: Inicia un temporizador que se repite hasta que se cancele.",
	"(Si escribes 'broadcast' delante de un temporizador, lo compartirás con tu grupo de banda si eres líder o ayudante)",
	"/dbm timer endloop: Cancela todos los temporizadores que se están repitiendo."
}

L.ERROR_NO_PERMISSION			= "No tienes permiso para hacer eso."
L.ERROR_NO_PERMISSION_COMBAT 	= "El temporizador de inicio/descanso no puede ser enviado mientras el encuentro esté en progreso."
L.PULL_TIME_TOO_SHORT			= "El temporizador de inicio debe durar más de 3 segundos."
L.PULL_TIME_TOO_LONG			= "El temporizador de inicio no puede durar más de 60 segundos."

L.BREAK_USAGE				= "El temporizador de descanso no puede durar más de 60 minutos. Asegúrate de que has escrito el tiempo en minutos y no en segundos."
L.BREAK_START				= "El descanso inicia ahora. ¡Tienes %s! (Enviado por %s)"
L.BREAK_MIN					= "¡El descanso termina en %s minuto(s)!"
L.BREAK_SEC					= "¡El descanso termina en %s segundo(s)!"
L.TIMER_BREAK				= "¡Toca descanso!"
L.ANNOUNCE_BREAK_OVER		= "El descanso ha terminado."

L.TIMER_PULL				= "Iniciando en"
L.ANNOUNCE_PULL				= "Iniciando en %d seg. (enviado por %s)"
L.ANNOUNCE_PULL_NOW			= "¡Inicia ahora!"
L.ANNOUNCE_PULL_TARGET		= "Iniciando a %s en %d seg. (enviado por %s)"
L.ANNOUNCE_PULL_NOW_TARGET	= "¡Iniciando a %s!"
L.GEAR_WARNING				= "Aviso: Comprobación de equipo. Tu nivel de objeto equipado es %d menor que tu nivel de objeto de inventario."
L.GEAR_WARNING_WEAPON		= "Aviso: Comprueba que tu arma esté equipada."
L.GEAR_FISHING_POLE			= "Caña de pescar"

L.ACHIEVEMENT_TIMER_SPEED_KILL = "Logro"

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.you			= "%s en ti"
L.AUTO_ANNOUNCE_TEXTS.target		= "%s en >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetsource	= "%s de >%%s< en >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) en >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell			= "%s"
L.AUTO_ANNOUNCE_TEXTS.incoming		= "%s perjuicio entrate"
L.AUTO_ANNOUNCE_TEXTS.incomingcount	= "%s perjuicio entrante (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends 			= "%s ha terminado"
L.AUTO_ANNOUNCE_TEXTS.endtarget		= "%s ha terminado en >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades			= "%s ha terminado"
L.AUTO_ANNOUNCE_TEXTS.addsleft		= "%s restantes: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast			= "Lanzando %s en %.1f s"
L.AUTO_ANNOUNCE_TEXTS.soon			= "%s en breve"
L.AUTO_ANNOUNCE_TEXTS.sooncount		= "%s (%%s) en breve"
L.AUTO_ANNOUNCE_TEXTS.countdown		= "%s en %%ds"
L.AUTO_ANNOUNCE_TEXTS.prewarn		= "%s en %s"
L.AUTO_ANNOUNCE_TEXTS.bait			= "%s en breve - ¡posiciónalo!"
L.AUTO_ANNOUNCE_TEXTS.stage			= "Fase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage		= "Fase %s en breve"
L.AUTO_ANNOUNCE_TEXTS.count			= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack			= "%s en >%%s< (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto		= "%s - ¡ve a >%%s<!"

local prewarnOption = "Mostrar anuncio anticipado para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you				= "Mostrar anuncio de que te afecta $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.target			= "Mostrar anuncio de los objetivos de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetNF		= "Mostrar anuncio de los objetivos de $spell:%s (ignora filtro de objetivo global)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource	= "Mostrar anuncio de los objetivos de $spell:%s (y quién lo lanza)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount		= "Mostrar anuncio de los objetivos de $spell:%s (con contador)"
L.AUTO_ANNOUNCE_OPTIONS.spell			= "Mostrar anuncio cuando $spell:%s sea lanzado"
L.AUTO_ANNOUNCE_OPTIONS.spellsource		= "Mostrar anuncio cuando $spell:%s sea lanzado (y quién lo lanza)"
L.AUTO_ANNOUNCE_OPTIONS.incoming		= "Mostrar anuncio cuando $spell:%s tiene perjuicios inminentes"
L.AUTO_ANNOUNCE_OPTIONS.incomingcount	= "Mostrar anuncio cuando $spell:%s tiene perjuicios inminentes (con contador)"
L.AUTO_ANNOUNCE_OPTIONS.ends			= "Mostrar anuncio cuando $spell:%s termine"
L.AUTO_ANNOUNCE_OPTIONS.endtarget		= "Mostrar anuncio cuando $spell:%s termine"
L.AUTO_ANNOUNCE_OPTIONS.fades			= "Mostrar anuncio cuando $spell:%s expire"
L.AUTO_ANNOUNCE_OPTIONS.addsleft		= "Mostrar anuncio para el número de $spell:%s restantes"
L.AUTO_ANNOUNCE_OPTIONS.cast			= "Mostrar anuncio cuando $spell:%s comience a lanzarse"
L.AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.countdown		= "Mostrar anuncio anticipado con cuenta atrás para $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait			= "Mostrar anuncio anticipado para posicionar $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stage			= "Mostrar anuncio para fase %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange		= "Mostrar anuncio para cambios de fase"
L.AUTO_ANNOUNCE_OPTIONS.prestage		= "Mostrar anuncio anticipado para fase %s"
L.AUTO_ANNOUNCE_OPTIONS.count			= "Mostrar anuncio para $spell:%s (con contador)"
L.AUTO_ANNOUNCE_OPTIONS.stack			= "Mostrar anuncio para acumulaciones de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.moveto			= "Mostrar anuncio para juntarse con alguien o ir a algún sitio para $spell:%s"

L.AUTO_SPEC_WARN_TEXTS.spell		= "¡%s!"
L.AUTO_SPEC_WARN_TEXTS.ends			= "%s ha terminado"
L.AUTO_SPEC_WARN_TEXTS.fades		= "%s ha terminado"
L.AUTO_SPEC_WARN_TEXTS.soon			= "%s en breve"
L.AUTO_SPEC_WARN_TEXTS.sooncount	= "%s (%%s) en breve"
L.AUTO_SPEC_WARN_TEXTS.bait			= "%s en breve - ¡Posiciónalo!"
L.AUTO_SPEC_WARN_TEXTS.prewarn		= "%s en %s"
L.AUTO_SPEC_WARN_TEXTS.dispel		= "%s en >%%s< - ¡Disipa ahora!"
L.AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - ¡Interrumpe a >%%s<!"
L.AUTO_SPEC_WARN_TEXTS.interruptcount= "%s - ¡Interrumpe a >%%s<! (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you			= "%s en ti"
L.AUTO_SPEC_WARN_TEXTS.youcount		= "%s (%%s) en ti"
L.AUTO_SPEC_WARN_TEXTS.youpos		= "%s (posición: %%s) en ti"
L.AUTO_SPEC_WARN_TEXTS.youposcount	= "%s (%%s) (posición: %%s) en ti"
L.AUTO_SPEC_WARN_TEXTS.soakpos		= "%s (posición: %%s)"
L.AUTO_SPEC_WARN_TEXTS.target		= "%s en >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount	= "%s (%%s) en >%%s< "
L.AUTO_SPEC_WARN_TEXTS.link			= "%s vinculado con >%%s<"
L.AUTO_SPEC_WARN_TEXTS.defensive	= "%s - ¡Facultad defensiva ahora!"
L.AUTO_SPEC_WARN_TEXTS.taunt		= "%s en >%%s< - ¡Provoca ahora!"
L.AUTO_SPEC_WARN_TEXTS.close		= "%s en >%%s< cerca de ti"
L.AUTO_SPEC_WARN_TEXTS.move			= "%s - ¡Sal de ahí!"
L.AUTO_SPEC_WARN_TEXTS.keepmove		= "%s - ¡No dejes de moverte!"
L.AUTO_SPEC_WARN_TEXTS.stopmove		= "%s - ¡Deja de moverte!"
L.AUTO_SPEC_WARN_TEXTS.dodge		= "%s - ¡Esquiva!"
L.AUTO_SPEC_WARN_TEXTS.dodgecount	= "%s (%%s) - ¡Esquiva!"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc		= "%s - ¡Esquiva por %%s!"
L.AUTO_SPEC_WARN_TEXTS.moveaway		= "%s - ¡Aléjate de los demás!"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount= "%s (%%s) - ¡Aléjate de los demás!"
L.AUTO_SPEC_WARN_TEXTS.moveto		= "%s - ¡Ve a >%%s<!"
L.AUTO_SPEC_WARN_TEXTS.soak			= "%s - ¡Absorbe!"
L.AUTO_SPEC_WARN_TEXTS.soakcount	= "%s - ¡Absorbe! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump			= "%s - ¡Salta!"
L.AUTO_SPEC_WARN_TEXTS.run			= "%s - ¡Corre!"
L.AUTO_SPEC_WARN_TEXTS.runcount		= "%s - ¡Corre! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast			= "%s - ¡Deja de lanzar!"
L.AUTO_SPEC_WARN_TEXTS.lookaway		= "%s en %%s - ¡Aparta!"
L.AUTO_SPEC_WARN_TEXTS.reflect		= "%s en >%%s< - ¡No ataques!"
L.AUTO_SPEC_WARN_TEXTS.count		= "¡%s! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack		= "%%d acumulaciones de %s en ti"
L.AUTO_SPEC_WARN_TEXTS.switch		= "%s - ¡Cambia de objetivo!"
L.AUTO_SPEC_WARN_TEXTS.switchcount	= "%s - ¡Cambia de objetivo! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo			= "%%s a tus pies - ¡Huye!"
L.AUTO_SPEC_WARN_TEXTS.adds			= "Esbirros en breve - ¡Cambia de objetivo!"
L.AUTO_SPEC_WARN_TEXTS.addscount	= "Esbirros en breve - ¡Cambia de objetivo! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.addscustom	= "Esbirros en breve - %%s"
L.AUTO_SPEC_WARN_TEXTS.targetchange	= "¡Cambia de objetivo a %%s!"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Mostrar anuncio especial para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends 			= "Mostrar anuncio especial cuando termine $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.fades 			= "Mostrar anuncio especial cuando expire $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soon 			= "Mostrar anuncio anticipado especial para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.sooncount		= "Mostrar anuncio anticipado especial (con contador) para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.bait			= "Mostrar anuncio anticipado especial para posicionar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Mostrar anuncio anticipado especial %s s antes de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 		= "Mostrar anuncio especial para disipar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Mostrar anuncio especial para interrumpir $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Mostrar anuncio especial (con contador) para interrumpir $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Mostrar anuncio especial cuando te afecte $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Mostrar anuncio especial (con contador) cuando te afecte $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youpos			= "Mostrar anuncio especial (con posición) cuando te afecte $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youposcount	= "Mostrar anuncio especial (con posición y contador) cuando te afecte $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakpos		= "Mostrar anuncio especial (con posición) para acompañar a los jugadores afectados por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.target 		= "Mostrar anuncio especial cuando $spell:%s afecte a un jugador"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Mostrar anuncio especial (con contador) cuando $spell:%s afecte a un jugador"
L.AUTO_SPEC_WARN_OPTIONS.link			= "Mostrar anuncio especial cuando estés vinculado a otro jugador por $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.defensive 		= "Mostrar anuncio especial para usar mitigaciones para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt 			= "Mostrar anuncio especial para provocar cuando $spell:%s afecte al otro tanque"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Mostrar anuncio especial cuando $spell:%s afecte a un jugador cercano"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Mostrar anuncio especial para salir de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Mostrar anuncio especial para no dejar de moverte durante $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Mostrar anuncio especial para dejar de moverte durante $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Mostrar anuncio especial para esquivar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount		= "Mostrar anuncio especial (con contador) para esquivar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "Mostrar anuncio especial (con ubicación) para esquivar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveaway		= "Mostrar anuncio especial para alejarse de los demás jugadores durante $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "Mostrar anuncio especial (con contador) para alejarse de los demás jugadores durante $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveto			= "Mostrar anuncio especial para juntarse con alguien o ir a algún sitio para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soak			= "Mostrar anuncio especial para absorber $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakcount		= "Mostrar anuncio especial (con contador) para interceptar $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.jump			= "Mostrar anuncio especial para saltar para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Mostrar anuncio especial para correr de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.runcount		= "Mostrar anuncio especial (con contador) para correr de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Mostrar anuncio especial para dejar de lanzar durante $spell:%s"--Spell Interrupt
L.AUTO_SPEC_WARN_OPTIONS.lookaway		= "Mostrar anuncio especial para apartar de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect 		= "Mostrar anuncio especial para dejar de atacar durante $spell:%s"--Spell Reflect
L.AUTO_SPEC_WARN_OPTIONS.count 			= "Mostrar anuncio especial (con contador) para $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack 			= "Mostrar anuncio especial cuando tengas %d o más acumulaciones de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switch			= "Mostrar anuncio especial para cambiar de objetivo a $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount	= "Mostrar anuncio especial (con contador) para cambiar de objetivo a $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Mostrar anuncio especial para huirte de áreas de daño en el suelo"
L.AUTO_SPEC_WARN_OPTIONS.adds			= "Mostrar anuncio especial para cambiar de objetivo cuando falte poco para que aparezcan esbirros"
L.AUTO_SPEC_WARN_OPTIONS.addscount		= "Mostrar anuncio especial (con contador) para cambiar de objetivo cuando falte poco para que aparezcan esbirros"
L.AUTO_SPEC_WARN_OPTIONS.addscustom		= "Mostrar anuncio especial cuando falte poco para que aparezcan esbirros"
L.AUTO_SPEC_WARN_OPTIONS.targetchange	= "Mostrar anuncio especial para cambiar a objetivos prioritarios"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target		= "%s: %%s"
L.AUTO_TIMER_TEXTS.targetcount	= "%s (%%2$s): %%1$s"
L.AUTO_TIMER_TEXTS.cast			= "%s"
L.AUTO_TIMER_TEXTS.castcount	= "%s (%%s)"
L.AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
L.AUTO_TIMER_TEXTS.active		= "%s termina"--Buff/Debuff/event on boss
L.AUTO_TIMER_TEXTS.fades		= "%s expira"--Buff/Debuff on players
L.AUTO_TIMER_TEXTS.ai			= "IA de %s"

L.AUTO_TIMER_TEXTS.cd			= "%s"
L.AUTO_TIMER_TEXTS.cdcount		= "%s (%%s)"
L.AUTO_TIMER_TEXTS.cdsource		= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial	= "Facultad especial"

L.AUTO_TIMER_TEXTS.next			= "%s"
L.AUTO_TIMER_TEXTS.nextcount	= "%s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource	= "%s: %%s"
L.AUTO_TIMER_TEXTS.nextspecial	= "Facultad especial"

L.AUTO_TIMER_TEXTS.var			= "%s"
L.AUTO_TIMER_TEXTS.varcount		= "%s (%%s)"
L.AUTO_TIMER_TEXTS.varsource	= "%s: >%%s<"--Now same as next, as the ~ was moved to timer number -- OPTIONAL
L.AUTO_TIMER_TEXTS.varspecial	= "Facultad especial"--Now same as next, as the ~ was moved to timer number
L.AUTO_TIMER_TEXTS.varcombo		= "%%1$s + %%2$s"--Now same as next, as the ~ was moved to timer number -- OPTIONAL

L.AUTO_TIMER_TEXTS.achievement			= "Logro: %s"
L.AUTO_TIMER_TEXTS.stage				= "Fase"
L.AUTO_TIMER_TEXTS.stagecount			= "Fase %%s"
L.AUTO_TIMER_TEXTS.stagecountcycle		= "Fase %%s (%%s)"--Example: Stage 2 (3) for a fight that alternates stage 1 and stage 2, but also tracks total cycles
L.AUTO_TIMER_TEXTS.stagecontext			= "%s"
L.AUTO_TIMER_TEXTS.stagecontextcount	= "%s (%%s)"
L.AUTO_TIMER_TEXTS.intermission			= "Intermedio"
L.AUTO_TIMER_TEXTS.intermissioncount	= "Intermedio %%s"
L.AUTO_TIMER_TEXTS.adds					= "Esbirros"
L.AUTO_TIMER_TEXTS.addscustom			= "Esbirros (%%s)"
L.AUTO_TIMER_TEXTS.roleplay				= "Diálogo"
L.AUTO_TIMER_TEXTS.combat				= "Inicia el encuentro"
--This basically clones np only bar option and display text from regular counterparts
L.AUTO_TIMER_TEXTS.cdnp					= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.cdpnp				= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextpnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.castpnp				= L.AUTO_TIMER_TEXTS.cast -- OPTIONAL

L.AUTO_TIMER_OPTIONS.target				= "Mostrar temporizador para la duración del perjuicio de $spell:%s"
L.AUTO_TIMER_OPTIONS.targetcount		= "Mostrar temporizador (con contador) para la duración del perjuicio de $spell:%s"
L.AUTO_TIMER_OPTIONS.cast				= "Mostrar temporizador para el lanzamiento de $spell:%s"
L.AUTO_TIMER_OPTIONS.castpnp			= "Mostrar temporizador de placa de nombre para el lanzamiento de $spell:%s"
L.AUTO_TIMER_OPTIONS.castcount			= "Mostrar temporizador (con contador) para el lanzamiento de $spell:%s"
L.AUTO_TIMER_OPTIONS.castsource			= "Mostrar temporizador (y quién lo lanza) para el lanzamiento de $spell:%s"
L.AUTO_TIMER_OPTIONS.active				= "Mostrar temporizador para la duración de $spell:%s"
L.AUTO_TIMER_OPTIONS.fades				= "Mostrar temporizador para el tiempo restante del perjuicio de $spell:%s en los jugadores"
L.AUTO_TIMER_OPTIONS.ai					= "Mostrar temporizador inteligente para el tiempo de reutilización de $spell:%s"

L.AUTO_TIMER_OPTIONS.cd					= "Mostrar temporizador para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdcount			= "Mostrar temporizador (con contador) para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdnp				= "Mostrar temporizador de placa de nombre para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdsource			= "Mostrar temporizador (y quién lo lanza) para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdspecial			= "Mostrar temporizador para el tiempo de reutilización de 'Facultad especial'."

L.AUTO_TIMER_OPTIONS.next				= "Mostrar temporizador para el siguiente $spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount			= "Mostrar temporizador (con contador) para el siguiente $spell:%s"
L.AUTO_TIMER_OPTIONS.nextnp				= "Mostrar temporizador de placa de nombre para el siguiente $spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource			= "Mostrar temporizador (y quién lo lanza) para el siguiente $spell:%s"
L.AUTO_TIMER_OPTIONS.nextspecial		= "Mostrar temporizador para la siguiente 'Facultad especial'."

L.AUTO_TIMER_OPTIONS.var				= "Mostrar temporizador (con variación) para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.varcount			= "Mostrar temporizador (con contador y variación) para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.varnp				= "Mostrar solo el temporizador en la placa de nombre (con variación) para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.varpnp				= "Mostrar solo el temporizador prioritario en la placa de nombre (con variación) para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.varsource			= "Mostrar temporizador (con variación y quién lo lanza) para el tiempo de reutilización de $spell:%s"
L.AUTO_TIMER_OPTIONS.varspecial			= "Mostrar temporizador (con variación) para el tiempo de reutilización de facultad especial"
L.AUTO_TIMER_OPTIONS.varcombo			= "Mostrar temporizador (con variación) para el tiempo de reutilización de combo de facultades"

L.AUTO_TIMER_OPTIONS.achievement		= "Mostrar temporizador para el logro %s"
L.AUTO_TIMER_OPTIONS.stage				= "Mostrar temporizador para la siguiente fase"
L.AUTO_TIMER_OPTIONS.stagecount			= "Mostrar temporizador (con contador) para la siguiente fase"
L.AUTO_TIMER_OPTIONS.stagecountcycle	= "Mostrar temporizador (con contador de fases y ciclos) para la siguiente fase"
L.AUTO_TIMER_OPTIONS.stagecontext		= "Mostrar temporizador para la siguiente fase de $spell:%s"
L.AUTO_TIMER_OPTIONS.stagecontextcount	= "Mostrar temporizador (con contador) para la siguiente fase de $spell:%s"
L.AUTO_TIMER_OPTIONS.intermission		= "Mostrar temporizador para el siguiente intermedio"
L.AUTO_TIMER_OPTIONS.intermissioncount	= "Mostrar temporizador (con contador) para el siguiente intermedio"
L.AUTO_TIMER_OPTIONS.adds				= "Mostrar temporizador para la siguiente aparición de esbirros"
L.AUTO_TIMER_OPTIONS.addscustom			= "Mostrar temporizador para la siguiente aparición de esbirros"
L.AUTO_TIMER_OPTIONS.roleplay			= "Mostrar temporizador para la duración del diálogo"
L.AUTO_TIMER_OPTIONS.combat				= "Mostrar temporizador para el inicio del encuentro"

L.AUTO_ICONS_OPTION_TARGETS				= "Establecer iconos en los objetivos de $spell:%s"
L.AUTO_ICONS_OPTION_TARGETS_TANK_A		= "Establecer iconos en objetivos de $spell:%s con prioridad tanque sobre cuerpo a cuerpo sobre a distancia y alfabética como alternativa"
L.AUTO_ICONS_OPTION_TARGETS_TANK_R		= "Establecer iconos en objetivos de $spell:%s con prioridad tanque sobre cuerpo a cuerpo sobre a distancia y la lista de banda como alternativa"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A		= "Establecer iconos en objetivos de $spell:%s con prioridad cuerpo a cuerpo y alfabética"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R		= "Establecer iconos en objetivos de $spell:%s con prioridad cuerpo a cuerpo y lista de banda"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A	= "Establecer iconos en objetivos de $spell:%s con prioridad a distancia y alfabética"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R	= "Establecer iconos en objetivos de $spell:%s con prioridad a distancia y lista de banda"
L.AUTO_ICONS_OPTION_TARGETS_MRH			= "Establecer iconos en objetivos de $spell:%s con prioridad cuerpo a cuerpo sobre a distancia sobre sanador y la lista de banda como alternativa"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA		= "Establecer iconos en objetivos de $spell:%s con prioridad alfabética"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER		= "Establecer iconos en objetivos de $spell:%s con prioridad lista de banda"
L.AUTO_ICONS_OPTION_NPCS				= "Establecer iconos en $spell:%s"
L.AUTO_ICONS_OPTION_CONFLICT			= "(Puede entrar en conflicto con otras opciones)"

L.AUTO_ARROW_OPTION_TEXT				= "Mostrar flecha indicadora para juntarse con los objetivos afectados por $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2				= "Mostrar flecha indicadora para alejarse de los objetivos afectados por $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3				= "Mostrar flecha indicadora para ir a una ubicación específica para $spell:%s"

L.AUTO_YELL_OPTION_TEXT.shortyell		= "Gritar cuando te afecte $spell:%s"
L.AUTO_YELL_OPTION_TEXT.yell			= "Gritar (con tu nombre) cuando te afecte $spell:%s"
L.AUTO_YELL_OPTION_TEXT.count			= "Gritar (con contador) cuando te afecte $spell:%s"
L.AUTO_YELL_OPTION_TEXT.fade			= "Gritar (con duración restante y tu nombre) cuando $spell:%s esté a punto de expirar"
L.AUTO_YELL_OPTION_TEXT.shortfade		= "Gritar (con duración restante) cuando $spell:%s esté a punto de expirar"
L.AUTO_YELL_OPTION_TEXT.iconfade		= "Gritar (con duración restante e icono) cuando $spell:%s esté a punto de expirar"
L.AUTO_YELL_OPTION_TEXT.position		= "Gritar (con posición) cuando te afecte $spell:%s"
L.AUTO_YELL_OPTION_TEXT.shortposition	= "Gritar (con posición) cuando te afecte $spell:%s"
L.AUTO_YELL_OPTION_TEXT.combo			= "Gritar (con texto personalizado) cuando te afecten $spell:%s y otro(s) hechizo(s) a la vez"
L.AUTO_YELL_OPTION_TEXT.repeatplayer	= "Gritar repetidamente (con tu nombre) cuando te afecte $spell:%s"
L.AUTO_YELL_OPTION_TEXT.repeaticon		= "Gritar repetidamente (con icono) cuando te afecte $spell:%s"

L.AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%s"
L.AUTO_YELL_ANNOUNCE_TEXT.yell		= "¡%s en " .. UnitName("player") .. "!"
L.AUTO_YELL_ANNOUNCE_TEXT.count		= "¡%s en " .. UnitName("player") .. "! (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade		= "%s expirando en %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade	= "{rt%%2$d}%%1$d"
L.AUTO_YELL_ANNOUNCE_TEXT.position 	= "%s %%s en {rt%%d}"..UnitName("player").."{rt%%d}"
L.AUTO_YELL_ANNOUNCE_TEXT.shortposition 	= "{rt%%1$d}%s"--Icon, Spellname
L.AUTO_YELL_ANNOUNCE_TEXT.combo			= "%s y %%s"--Spell name (from option, plus spellname given in arg)
L.AUTO_YELL_ANNOUNCE_TEXT.repeatplayer	= UnitName("player")--Doesn't need translation, it's just player name spam
L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon	= "{rt%%1$d}"--Doesn't need translation. It's just icon spam

L.AUTO_YELL_CUSTOM_POSITION			= "{rt%d}%s"--Doesn't need translating. Has no strings (Used in niche situations such as icon repeat yells)
L.AUTO_YELL_CUSTOM_FADE				= "%s ha expirado"
L.AUTO_HUD_OPTION_TEXT				= "Mostrar indicador en pantalla para $spell:%s"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "Mostrar indicadores en pantalla para varias mecánicas"
L.AUTO_NAMEPLATE_OPTION_TEXT		= "Mostrar auras en placas de nombres para $spell:%s"
L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED	= "Mostrar auras en placas de nombres para $spell:%s solamente usando "..L.DBM
L.AUTO_RANGE_OPTION_TEXT			= "Mostrar marco de distancia (%s m) para $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
L.AUTO_RANGE_OPTION_TEXT_SHORT		= "Mostrar marco de distancia (%s m)"--For when a range frame is just used for more than one thing
L.AUTO_RRANGE_OPTION_TEXT			= "Mostrar marco de distancia inverso (%s m) para $spell:%s"--Reverse range frame (green when players in range, red when not)
L.AUTO_RRANGE_OPTION_TEXT_SHORT		= "Mostrar marco de distancia inverso (%s m)"
L.AUTO_INFO_FRAME_OPTION_TEXT		= "Mostrar marco de información para $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2		= "Mostrar marco de información con una vista general del encuentro"
L.AUTO_INFO_FRAME_OPTION_TEXT3		= "Mostrar marco de información para $spell:%s (cuando se alcanza el umbral de %%s)"
L.AUTO_READY_CHECK_OPTION_TEXT		= "Reproducir sonido de comprobación de banda cuando se inicie el encuentro (aunque no lo tengas como objetivo)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT		= "Mostrar temporizador para el récord actual de completar %s"
L.AUTO_PRIVATEAURA_OPTION_TEXT		= "Reproduce anuncios de sonido de DBM para auras privadas de $spell:%s en este encuentro."

-- New special warnings
L.MOVE_WARNING_BAR			= "Anuncio desplazable"
L.MOVE_WARNING_MESSAGE		= "Gracias por usar " .. L.DEADLY_BOSS_MODS
L.MOVE_SPECIAL_WARNING_BAR	= "Aviso especial desplazable"
L.MOVE_SPECIAL_WARNING_TEXT	= "Aviso especial"

L.HUD_INVALID_TYPE			= "No se ha proporcionado un tipo de indicador en pantalla válido."
L.HUD_INVALID_TARGET		= "No se ha proporcionado un objetivo válido."
L.HUD_INVALID_SELF			= "No puedes usarte a ti mismo como objetivo."
L.HUD_INVALID_ICON			= "No se puede usar el tipo icono en un objetivo sin icono."
L.HUD_SUCCESS				= "Indicador en pantalla realizado con éxito. Expirará en %s o al escribir '/dbm hud hide'."
L.HUD_USAGE	= {
	"Uso de " .. L.DBM .. "-HudMap:",
	"-----------------",
	"/dbm hud <tipo> <objetivo> <duración>: Crea un indicador en pantalla que apunta al jugador objetivo durante el tiempo designado.",
	"Tipos válidos: arrow, dot, red, blue, green, yellow, icon (requiere un objetivo con icono de banda)",
	"Objetivos válidos: objetivo, enfoque, <nombre de jugador>",
	"Duraciones válidas: cualquier número (en segundos). Si se deja en blanco, durará 20 minutos.",
	"/dbm hud hide: cancela y oculta el indicador en pantalla."
}

L.ARROW_MOVABLE					= "Flecha desplazable"
L.ARROW_WAY_USAGE				= "/dway <x> <y>: Crea una flecha que apunta a una ubicación designada mediante coordenadas locales."
L.ARROW_WAY_SUCCESS				= "Para ocultar la flecha, escribe '/dbm arrow hide' o alcanza la ubicación designada."
L.ARROW_ERROR_USAGE	= {
	"Uso de " .. L.DBM .. "-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: Crea una flecha que apunta a una ubicación específica (mediante coordenadas de mundo).",
	"/dbm arrow map <x> <y>: Crea una flecha que apunta a una ubicación específica (mediante coordenadas de zona).",
	"/dbm arrow <jugador>: Crea una flecha que apunta al jugador específico de tu grupo o banda.",
	"/dbm arrow hide: Oculta la flecha.",
	"/dbm arrow move: Permite mover la flecha."
}

L.SPEED_KILL_TIMER_TEXT		= "Superar récord"
L.SPEED_CLEAR_TIMER_TEXT	= "Récord actual"
L.COMBAT_RES_TIMER_TEXT		= "Siguiente resurrección"
L.TIMER_RESPAWN				= "%s reaparece"

L.LAG_CHECKING				= "Comprobando latencia de la banda..."
L.LAG_HEADER				= L.DEADLY_BOSS_MODS.. " - Resultados de latencia"
L.LAG_ENTRY					= "%s: Latencia de mundo [%d ms] / Latencia de hogar [%d ms]"
L.LAG_FOOTER				= "Sin respuesta: %s"

L.DUR_CHECKING				= "Comprobando durabilidad de la banda..."
L.DUR_HEADER				= L.DEADLY_BOSS_MODS.. " - Resultados de durabilidad"
L.DUR_ENTRY					= "%s: Durabilidad [%d%%] / Piezas rotas [%s]"

L.OVERRIDE_ACTIVATED		= "Líder de banda ha activado las anulaciones de configuración para este encuentro"

--LDB
L.LDB_TOOLTIP_HELP1	= "Haz clic para abrir " .. L.DBM
L.LDB_TOOLTIP_HELP2	= "Alt-Clic derecho para activar/desactivar modo silencioso"
L.SILENTMODE_IS	= "El modo silencioso es "

L.WORLD_BUFFS.hordeOny			= "Miembros de la Horda, ciudadanos de Orgrimmar, vengan y reúnanse para homenajear un hecho heroico"
L.WORLD_BUFFS.allianceOny		= "Ciudadanos y aliados de Ventormenta, en el día de hoy, hemos hecho historia."
L.WORLD_BUFFS.hordeNef			= "¡NEFARIAN HA SIDO ASESINADO! Ciudadanos de Orgrimmar"
L.WORLD_BUFFS.allianceNef		= "¡Ciudadanos de la Alianza, el Señor de Roca Negra está muerto!"
L.WORLD_BUFFS.zgHeart			= "Ahora, solo un paso más para poder librarnos de la amenaza del Cazador de Almas"
L.WORLD_BUFFS.zgHeartBooty		= "¡El Dios de la Sangre, el Cazador de Almas, ha sido derrotado! ¡Ya no corremos peligro!"
L.WORLD_BUFFS.zgHeartYojamba	= "Comiencen el ritual, sirvientes. ¡Debemos desterrar el corazón de Hakkar al vacío!"
L.WORLD_BUFFS.rendHead			= "¡El falso Jefe de Guerra Rend Puño Negro ha caído!"
L.WORLD_BUFFS.blackfathomBoon	= "Favor de Brazanegra"

-- Annoying popup, especially for classic players
L.DBM_INSTALL_REMINDER_HEADER = "¡Se ha detectado una instalación incompleta de DBM!"
L.DBM_INSTALL_REMINDER_EXPLAIN = "Bienvenido a %s. Los módulos de DBM para los jefes aquí están en el %s que no tienes instalado. ¡DBM no mostrará temporizadores ni advertencias en esta zona a menos que instales el %s!"
L.DBM_INSTALL_REMINDER_DISABLE = "Desactiva todos los anuncios y temporizadores de DBM en esta zona."  -- Used when we believe it's a user error that the mod isn't installed (i.e., current raids)
L.DBM_INSTALL_REMINDER_DISABLE2 = "No mostrar este mensaje nuevamente para este paquete." -- Used for unimportant mods, i.e., dungeons
L.DBM_INSTALL_REMINDER_DL_WAGO = "Presiona " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar el enlace de Wago.io en tu portapapeles."
L.DBM_INSTALL_REMINDER_DL_CURSE = "Presiona " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " para copiar el enlace de Curseforge en tu portapapeles."

L.DBM_INSTALL_PACKAGE_VANILLA = "Paquete de Era y Temporada de descubrimiento"
L.DBM_INSTALL_PACKAGE_BCC		= "Paquete de Burning Crusade"
L.DBM_INSTALL_PACKAGE_WRATH = "Paquete de Wrath"
L.DBM_INSTALL_PACKAGE_CATA = "Paquete de Cataclysm"
L.DBM_INSTALL_PACKAGE_MOP		= "Paquete de Mist of Pandaria"
L.DBM_INSTALL_PACKAGE_DUNGEON = "Paquete de Mazmorras, Abismos y Eventos"

-- Tests
L.DBM_TAINTED_BY_TESTS = "DBM se utilizó en modo de prueba con distorsión temporal en la sesión actual, se recomienda recargar tu interfaz antes de usar DBM en un combate de jefe real. Todo debería funcionar como se espera, ¡pero no hay garantías!"
