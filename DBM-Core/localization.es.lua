if GetLocale() ~= "esES" then return end

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

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Version"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM no instalado"
DBM_CORE_VERSIONCHECK_FOOTER		= "Encontrados %d jugadores con Deadly Boss Mods"

DBM_CORE_UPDATEREMINDER_HEADER		= "La version de tu Deadly Boss Mods es antigua.\n Version %s (r%d) disponible para descargar aqui:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Presiona Contro+C para copiar el link de la descarga."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Mostrar popup si hay nueva version de Deadly Boss Mods"

DBM_CORE_MOVABLE_BAR				= "Mueve me!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h envia tu tiempo: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancelar este tiempo]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorar tiempos de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "De verdad quieres ignorar los tiempos de %s para esta sesion?"
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

DBM_CORE_SLASHCMD_HELP				= {
	"Comandos disponibles:",
	"/dbm version: performans a raid-wide version check (alias: ver)",
	"/dbm unlock: shows a movable status bar timer (alias: move)",
	"/dbm timer <x> <text>: Starts a <x> second Pizza Timer with the name <text>",
	"/dbm broadcast timer <x> <text>: Broadcasts a <x> second Pizza Timer with the name <text> to the raid (required promoted or leader)",
	"/dbm help: shows this help",
}

DBM_ERROR_NO_PERMISSION				= "No tienes permiso para hacer eso."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Esconder"

DBM_CORE_ALLIANCE					= "Alianza"
DBM_CORE_HORDE						= "Horda"

DBM_CORE_UNKNOWN					= "desconocido"

DBM_CORE_TIMER_PULL					= "Pull en"
DBM_CORE_ANNOUNCE_PULL				= "Pull en %d seg"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull ahora!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Matar rapido"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.cast 			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.cd 			= "%s CD"
DBM_CORE_AUTO_TIMER_TEXTS.next 			= "Siguiente %s"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target 		= "Mostrar tiempo de debuff |cff71d5ff|Hspell:%d|h%s|h|r "
DBM_CORE_AUTO_TIMER_OPTIONS.cast 		= "mostrar tiempo de cast de |cff71d5ff|Hspell:%d|h%s|h|r "
DBM_CORE_AUTO_TIMER_OPTIONS.active 		= "Mostrar duracion de |cff71d5ff|Hspell:%d|h%s|h|r "
DBM_CORE_AUTO_TIMER_OPTIONS.cd 			= "Mostrar cd de |cff71d5ff|Hspell:%d|h%s|h|r "
DBM_CORE_AUTO_TIMER_OPTIONS.next 		= "Mostrar tiempo para el siguiente |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement = "Mostrar tiempo para %s"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target = "%s en >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell = "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast = "Casteando %s: %.1f seg"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon = "%s pronto"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn = "%s en %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase = "Fase %d"

DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target	= "Anunciar objetivo de |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell	= "Mostrar aviso para |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast		= "Mostrar aviso cuando castee |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon		= "Show pre-warning for |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn	= "Show pre-warning for |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase	= "Mostrar aviso para fase %d"




