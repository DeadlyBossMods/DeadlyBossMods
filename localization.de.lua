if GetLocale() ~= "deDE" then return end

DBM_CORE_LOAD_MOD_ERROR				= "Fehler beim Laden von Boss Mods für %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Boss Mods für '%s' geladen!"
DBM_CORE_LOAD_GUI_ERROR				= "Konnte das GUI nicht laden: %s"

DBM_CORE_COMBAT_STARTED				= "Kampf gegen %s hat begonnen. Viel Glück! :)";
DBM_CORE_BOSS_DOWN					= "%s tot nach %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s tot nach %s! Euer letzter kill hat %s gedauert und der schnellste %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s tot nach %s! Das ist ein neuer Rekord! (der alte Rekord war %s)"
DBM_CORE_COMBAT_ENDED				= "Kampf gegen %s hat nach %s aufgehört."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4Sekunde:Sekunden;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4Minute:Minuten;"
DBM_CORE_TIMER_FORMAT				= "%d |4Minute:Minuten; und %d |4Sekunde:Sekunden;"

DBM_CORE_MIN						= "Min"
DBM_CORE_MIN_FMT					= "%d Min"
DBM_CORE_SEC						= "Sek"
DBM_CORE_SEC_FMT					= "%d Sek"
DBM_CORE_DEAD						= "Tot"
DBM_CORE_OK							= "Okay"

DBM_CORE_GENERIC_WARNING_ENRAGE		= "Enrage in %s %s"
DBM_CORE_GENERIC_TIMER_ENRAGE		= "Enrage"
DBM_CORE_OPTION_TIMER_ENRAGE		= "Enrage-Timer anzeigen"
DBM_CORE_OPTION_HEALTH_FRAME		= "BossHealth-Frame anzeigen"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Timer"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Ansagen"
DBM_CORE_OPTION_CATEGORY_MISC		= "Verschiedenes"

DBM_CORE_AUTO_RESPONDED				= "Automatisch geantwortet."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d Spieler am Leben"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s ist damit beschäftigt gegen %s zu kämpfen! (%s, %d/%d Spieler am Leben)"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versionen"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM nicht installiert"
DBM_CORE_VERSIONCHECK_FOOTER		= "%d Spieler mit Deadly Boss Mods gefunden"

DBM_CORE_UPDATEREMINDER_HEADER		= "Deine Version von Deadly Boss Mods ist veraltet.\n Version %s (r%d) ist hier zum Download verfügbar:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Drücke Strg+C um den Download-Link in die Zwischenablage zu kopieren"
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Zeige Popup wenn eine neue Version verfügbar ist"

DBM_CORE_MOVABLE_BAR				= "Zieh mich!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h hat dir einen Pizza-Timer geschickt: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Diesen Timer abbrechen]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Pizza-Timer von %1$s ignorieren]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Willst du wirklich Pizza-Timer von %s für diese Session ignorieren?"
DBM_PIZZA_ERROR_USAGE				= "Benutzung: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods läuft doppelt, da du DBMv3 und DBMv4 installiert und aktiviert hast!\nKlick auf \"Okay\" um DBMv3 zu deaktivieren und dein Interface neu zu laden.\nAußerdem solltest du deinen AddOn-Ordner aufräumen indem du alle DBMv3 Mods löschst."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+Klick oder Rechtsklick zum bewegen"

DBM_CORE_RANGECHECK_HEADER			= "Abstandscheck (%d m)"
DBM_CORE_RANGECHECK_SETRANGE		= "Abstand einstellen"
DBM_CORE_RANGECHECK_HIDE			= "Verstecken"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d m"
DBM_CORE_RANGECHECK_LOCK			= "Frame sperren"

DBM_CORE_SLASHCMD_HELP				= {
	"Verfügbare Slash-Commands:",
	"/dbm version: führt einen raidweiten Versionscheck durch (alias: ver)",
	"/dbm unlock: zeigt einen bewegbaren Timer an (alias: move)",
	"/dbm timer <x> <text>: startet einen <x> Sekunden langen Pizza-Timer mit dem Namen <text>",
	"/dbm broadcast timer <x> <text>: schickt einen <x> Sekunden langen Pizza-Timer mit dem Namen <text> an den raid (benötigt (A) oder (L))",
	"/dbm help: zeigt diese Hilfe",
}

DBM_ERROR_NO_PERMISSION				= "Du hast nicht die benötigte Berechtigung für diesen Befehl!"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Verstecken"

DBM_CORE_ALLIANCE					= "Allianz"
DBM_CORE_HORDE						= "Horde"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target 		= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.cast 			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active 		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.cd 			= "%s CD"
DBM_CORE_AUTO_TIMER_TEXTS.next 			= "Nächster %s"
DBM_CORE_AUTO_TIMER_TEXTS.achievement 	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Debufftimer für |cff71d5ff|Hspell:%d|h%s|h|r anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cast 		= "Casttimer für |cff71d5ff|Hspell:%d|h%s|h|r anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.active 		= "Timer während |cff71d5ff|Hspell:%d|h%s|h|r aktiv ist anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cd 			= "Cooldowntimer für |cff71d5ff|Hspell:%d|h%s|h|r anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.next 		= "Timer für nächstes |cff71d5ff|Hspell:%d|h%s|h|r anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement = "Timer für %s anzeigen"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target 	= "%s auf >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell 		= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast 		= "%s in %.1f Sek"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon 		= "%s bald"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn 	= "%s in %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase 		= "Phase %d"

DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target 	= "Ziel von |cff71d5ff|Hspell:%d|h%s|h|r ansagen"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell 	= "Zeige Warnung für |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast 	= "Zeige Warnung wenn |cff71d5ff|Hspell:%d|h%s|h|r gezaubert wird"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon 	= "Zeige Vorwarnung für |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 	= "Zeige Vorwarnung für |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase 	= "Zeige Warnung fühase %d"



