if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

DBM_CORE_NEED_SUPPORT				= "¿Eres bueno programando o con los idiomas? Si es así, el Equipo DBM necesita tu ayuda para mantener el DBM como el mejor BossMod del WoW. Únete al equipo visitando www.deadlybossmods.com o enviando un mensaje a tandanu@deadlybossmods.com o nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Bienvenido a DBM. Para acceder a las opciones escribe /dbm en tu chat para empezar a configurarlo. Puedes cargar las zonas manualmente para configurar las opciones específicas de cada Boss a tu gusto. DBM intenta hacer esto escaneando tu clase la primera vez que se inicia, pero quizás quieras más alertas de las que necesita tu clase."

DBM_CORE_LOAD_MOD_ERROR				= "Error al cargar modulo %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Cargado modulo de '%s' !"
DBM_CORE_LOAD_GUI_ERROR				= "No se puede cargar la GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s llamado. Buena suerte y diviertase! :)";
DBM_CORE_BOSS_DOWN					= "%s murio en %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s murio en %s! Su muerte reciente fue %s y la muerte mas rapida fue %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s murio en %s! Es un nuevo record! (el antiguo era %s)"
DBM_CORE_COMBAT_ENDED				= "El combate contra %s termino en %s."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4segundo:segundos;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minuto:minutos;"
DBM_CORE_TIMER_FORMAT				= "%d |4minuto:minutos; y %d |4segundo:segundos;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "seg"
DBM_CORE_SEC_FMT					= "%d sec"
DBM_CORE_DEAD						= "muerto"
DBM_CORE_OK							= "Aceptar"

DBM_CORE_GENERIC_WARNING_BERSERK	= "Enrage en %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Enrage"
DBM_CORE_OPTION_TIMER_BERSERK		= "Mostrar tiempo para Enrage"
DBM_CORE_OPTION_HEALTH_FRAME		= "Mostrar barra de vida del boss"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barras"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Anuncios"
DBM_CORE_OPTION_CATEGORY_MISC		= "Miscelaneo"

DBM_CORE_AUTO_RESPONDED				= "Auto-respusta."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d gete viva"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s esta ocupado en la batalla contra %s (%s, %d/%d gente viva)"
DBM_CORE_WHISPER_COMBAT_END_KILL	= "%s ha derrotado a %s!"
DBM_CORE_WHISPER_COMBAT_END_WIPE	= "%s ha wipeado en %s"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Version"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM no instalado"
DBM_CORE_VERSIONCHECK_FOOTER		= "Encontrados %d jugadores con Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "¡Tu versión de Deadly Boss Mods es antigua! Por favor, visita www.deadlybossmods.com para bajarte la última versión."

DBM_CORE_UPDATEREMINDER_HEADER		= "La version de tu Deadly Boss Mods es antigua.\n Version %s (r%d) disponible para descargar aqui:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Presiona Contro+C para copiar el link de la descarga."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Mostrar popup si hay nueva version de Deadly Boss Mods"

DBM_CORE_MOVABLE_BAR				= "¡Muéveme!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h envia tu tiempo: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancelar este tiempo]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar tiempos de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "¿De verdad quieres ignorar los tiempos de %s para esta sesion?"
DBM_PIZZA_ERROR_USAGE				= "Usa: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods is running twice because you have DBMv3 and DBMv4 installed and enabled!\nClick \"Okay\" to disable DBMv3 and reload your interface.\nYou should also clean up your AddOns folder by deleting the old DBMv3 folders."

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
DBM_CORE_RANGECHECK_HIDE			= "Esconder"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d yd"
DBM_CORE_RANGECHECK_LOCK			= "Bloquear ventana"

DBM_CORE_INFOFRAME_LOCK				= "Bloquear ventana"
DBM_CORE_INFOFRAME_HIDE				= "Esconder"
DBM_CORE_INFOFRAME_SHOW_SELF			= "Siempre mostrar tu información"

DBM_LFG_INVITE						= "Invitación al grupo"

DBM_CORE_SLASHCMD_HELP				= {
	"Comandos disponibles:",
	"/dbm version: comprueba la versión de DBM de toda la banda (alias: ver)",
	"/dbm version2: comprueba la versión de DBM de toda la banda y susurra a los miembros que estan desactualizados (alias: ver2).",
	"/dbm unlock: muestra una barra de estado desplazable (alias: move)",
	"/dbm timer <x> <text>: Muestra un contador de <x> segundos con el nombre <text>",
	"/dbm broadcast timer <x> <text>: Muestra un contador de <x> segundos con el nombre <text> a la banda (requiere lider/ayudante)",
	"/dbm break <min>: Empieza un descanso de <min> minutos. Muestra a todos los miembros de banda con DBM un contador de descanso (requiere lider/ayudante).",
	"/dbm pull <seg>: Empieza una cuenta atrás para pullear en <seg> segundos. Muestra a todos los miembros de banda con DBM un contador para pullear (requiere lider/ayudante).",
	"/dbm help: muestra esta ayuda",
}

DBM_ERROR_NO_PERMISSION				= "No tienes permiso para hacer eso."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Esconder"

DBM_CORE_ALLIANCE					= "Alianza"
DBM_CORE_HORDE						= "Horda"

DBM_CORE_UNKNOWN					= "desconocido"

DBM_CORE_BREAK_START				= "¡El descanso empieza ahora -- tienes %s minuto(s)!"
DBM_CORE_BREAK_MIN					= "¡El descanso acaba en %s minuto(s)!"
DBM_CORE_BREAK_SEC					= "¡El descanso acaba en %s segundos!"
DBM_CORE_TIMER_BREAK				= "¡Descanso!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "El descanso terminó"

DBM_CORE_TIMER_PULL					= "Pull en"
DBM_CORE_ANNOUNCE_PULL				= "Pull en %d seg"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull ahora!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Matar rapido"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target = "%s: %%s",
	cast = "%s",
	active = "%s",
	cd = "%s CD",
	next = "Siguiente %s",
	achievement = "%s",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target = "Mostrar tiempo de debuff |cff71d5ff|Hspell:%d|h%s|h|r ",
	cast = "Mostrar tiempo de cast de |cff71d5ff|Hspell:%d|h%s|h|r ",
	active = "Mostrar duración de |cff71d5ff|Hspell:%d|h%s|h|r ",
	cd = "Mostrar CD de |cff71d5ff|Hspell:%d|h%s|h|r ",
	next = "Mostrar tiempo para el siguiente |cff71d5ff|Hspell:%d|h%s|h|r ",
	achievement = "Mostrar tiempo para %s",
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target = "%s en >%%s<",
	spell = "%s",
	cast = "Casteando %s: %.1f seg",
	soon = "%s pronto",
	prewarn = "%s en %s",
	phase = "Fase %d",
}

local prewarnOption = "Mostrar una pre-alerta para |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target	= "Anunciar objetivo de |cff71d5ff|Hspell:%d|h%s|h|r",
	spell	= "Mostrar aviso para |cff71d5ff|Hspell:%d|h%s|h|r",
	cast	= "Mostrar aviso cuando castee |cff71d5ff|Hspell:%d|h%s|h|r",
	soon	= "Mostrar pre-aviso para |cff71d5ff|Hspell:%d|h%s|h|r",
	prewarn	= "Mostrar pre-aviso para |cff71d5ff|Hspell:%d|h%s|h|r",
	phase	= "Mostrar aviso para fase %d",
}


-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell 	= "Mostrar aviso especial para $spell:%d",
	dispel 	= "Mostrar aviso especial para dispelear/robar hechizo \n $spell:%d",
	interrupt= "Mostrar aviso especial para interrumpir $spell:%d",
	you 	= "Mostrar aviso especial cuando te afecta \n $spell:%d",
	target 	= "Mostrar aviso especial cuando a alguien le afecta \n $spell:%d",
	close 	= "Mostrar aviso especial cuando a alguien cerca de ti \n le afecta $spell:%d",
	move 	= "Mostrar aviso especial cuando te afecta \n $spell:%d",
	run 	= "Mostrar aviso especial para $spell:%d",
	cast 	= "Mostrar aviso especial para casteo de $spell:%d",
	stack 	= "Mostrar aviso especial cuando tienes >=%d marcas de \n $spell:%d"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell = "%s",
	dispel = "%s ¡dispelea ahora!",
	interrupt = "%s ¡interrumpe ahora!",
	you = "%s en ti!",
	target = "%s en %%s",
	close = "%s en %%s cerca de ti",
	move = "%s ¡muévete!",
	run = "%s ¡corre!",
	cast = "%s ¡para de castear!",
	stack = "%s (%%d)"
}


DBM_CORE_AUTO_ICONS_OPTION_TEXT		= "Poner iconos en objetivos de $spell:%d"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "Reproducir sonido en $spell:%d"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Aviso especial desplazable"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Aviso especial"

DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "La comprobación de rango de %d yardas no está disponible en esta zona.\nLos rangos disponibles son 10, 11, 15 y 28 yardas."

DBM_ARROW_MOVABLE					= "Flecha movible"
DBM_ARROW_NO_RAIDGROUP				= "Esta funcionalidad solo puede usarse en grupos de banda o en estancias de banda."
DBM_ARROW_ERROR_USAGE	= {
	"Uso de DBM-Arrow:",
	"/dbm arrow <x> <y>: Crea una flecha que apunta a una dirección específica (0 < x/y < 100)",
	"/dbm arrow <jugador>: Crea una flecha que apunta a un miembro específico de la banda",
	"/dbm arrow hide: Oculta la flecha",
	"/dbm arrow move: Hace la flecha movible",
}

DBM_SPEED_KILL_TIMER_TEXT	= "Superar récord"
DBM_SPEED_KILL_TIMER_OPTION	= "Mostrar tiempo para superar tu muerte más rápida"
