if GetLocale() ~= "deDE" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

L.HOW_TO_USE_MOD					= "Willkommen bei DBM. Tippe /dbm help für eine Liste unterstützter Kommandos. Für den Zugriff auf Einstellungen tippe /dbm in den Chat um die Konfiguration zu beginnen. Lade gewünschte Zonen manuell um jegliche Boss-spezifische Einstellungen nach deinen Wünschen zu konfigurieren. DBM setzt Standardeinstellungen für deine Spezialisierung, die du aber noch genauer anpassen kannst."
L.SILENT_REMINDER					= "Erinnerung: DBM befindet sich noch im Lautlos-Modus."

L.LOAD_MOD_ERROR				= "Fehler beim Laden der Boss Mods für %s: %s"
L.LOAD_MOD_SUCCESS			= "Boss Mods für '%s' geladen. Für weitere Einstellungen wie benutzerdefinierte Sounds und individuelle Warnnotizen /dbm eingeben."
L.LOAD_MOD_COMBAT			= "Laden von '%s' verzögert bis du den Kampf verlässt."
L.LOAD_GUI_ERROR				= "Konnte die grafische Benutzeroberfläche nicht laden: %s."
L.LOAD_GUI_COMBAT			= "Die grafische Benutzeroberfläche kann nicht im Kampf geladen werden. Zur Vornahme von Einstellungen bitte diese zunächst außerhalb des Kampfes laden. Danach steht sie auch im Kampf zur Verfügung."
L.BAD_LOAD					= "Dein Boss Mod für diese Instanz konnte nicht vollständig korrekt im Kampf geladen werden. Bitte führe baldmöglichst nach Kampfende /reload aus."
L.LOAD_MOD_VER_MISMATCH		= "%s kann nicht geladen werden, da dein DBM-Core die Voraussetzungen nicht erfüllt. Es wird eine aktualisierte Version benötigt."
L.LOAD_MOD_EXP_MISMATCH		= "%s kann nicht geladen werden, da es für eine WoW Erweiterung entwickelt wurde, die derzeit nicht verfügbar ist. Mit Verfügbarkeit der neuen Erweiterung wird dieses Mod automatisch funktionieren."
L.LOAD_MOD_DISABLED			= "%s ist installiert, aber derzeit nicht aktiviert. Dieses Mod wird nicht geladen, falls du es nicht aktivierst."
L.LOAD_MOD_DISABLED_PLURAL	= "%s sind installiert, aber derzeit nicht aktiviert. Diese Mods werden nicht geladen, falls du sie nicht aktivierst."

L.COPY_URL_DIALOG					= "Kopiere URL"

--Post Patch 7.1
L.NO_RANGE					= "Das Abstandsradar kann in Instanzen nicht genutzt werden. Es wird stattdessen die alte textbasierte Abstandsanzeige verwendet."
L.NO_ARROW					= "Der Pfeil kann in Instanzen nicht genutzt werden."
L.NO_HUD						= "Die HudMap kann in Instanzen nicht genutzt werden."

L.DYNAMIC_DIFFICULTY_CLUMP	= "DBM hat das dynamische Abstandsfenster für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, auf wieviel versammelte Spieler bei deiner Gruppengröße geprüft werden muss."
L.DYNAMIC_ADD_COUNT			= "DBM hat Warnungen bezüglich der Anzahl der Gegner für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, wieviel Gegner bei deiner Gruppengröße erscheinen."
L.DYNAMIC_MULTIPLE			= "DBM hat mehrere Funktionalitäten für diesen Kampf deaktiviert, da für deine Gruppengröße nicht genügend Informationen über bestimmte Kampfmechaniken vorliegen."

L.LOOT_SPEC_REMINDER			= "Deine aktuelle Spezialisierung ist %s. Deine aktuelle Beutespezialisierung ist %s."

L.BIGWIGS_ICON_CONFLICT		= "DBM hat festgestellt, dass du das Setzen von Schlachtzugzeichen in \"BigWigs\" und in \"DBM\" aktiviert hast. Bitte deaktiviere das Setzen von Zeichen in einem der beiden Addons um Konflikte zu vermeiden."

L.MOD_AVAILABLE				= "Das Mod \"%s\" ist für diese Zone/Boss verfügbar. Du kannst es von Curse/WoWI oder deadlybossmods.com herunterladen."

L.COMBAT_STARTED				= "Kampf gegen %s hat begonnen. Viel Glück! :)";
L.COMBAT_STARTED_IN_PROGRESS	= "Du wurdest in den laufenden Kampf gegen %s verwickelt. Viel Glück! :)"
L.GUILD_COMBAT_STARTED		= "Kampf gegen %s wurde von deiner Gilde begonnen."
L.SCENARIO_STARTED			= "%s gestartet. Viel Glück! :)"
L.SCENARIO_STARTED_IN_PROGRESS	=	"Du bist dem laufenden Szenario %s beigetreten. Viel Glück! :)"
L.BOSS_DOWN					= "%s besiegt nach %s!"
L.BOSS_DOWN_I				= "%s besiegt! Das war dein %d. Sieg."
L.BOSS_DOWN_L				= "%s besiegt nach %s! Dein letzter Sieg hat %s gedauert und der schnellste %s. Das war dein %d. Sieg."
L.BOSS_DOWN_NR				= "%s besiegt nach %s! Das ist ein neuer Rekord! (Der alte Rekord war %s.) Das war dein %d. Sieg."
L.GUILD_BOSS_DOWN			= "%s wurde durch deine Gilde besiegt nach %s!"
L.SCENARIO_COMPLETE			= "%s abgeschlossen nach %s!"
L.SCENARIO_COMPLETE_I		= "%s abgeschlossen! Das war dein %d. Abschluss."
L.SCENARIO_COMPLETE_L		= "%s abgeschlossen nach %s! Dein letzter Abschluss hat %s gedauert und der schnellste %s. Das war dein %d. Abschluss."
L.SCENARIO_COMPLETE_NR		= "%s abgeschlossen nach %s! Das ist ein neuer Rekord! (Der alte Rekord war %s.) Das war dein %d. Abschluss."
L.COMBAT_ENDED_AT			= "Kampf gegen %s (%s) hat nach %s aufgehört."
L.COMBAT_ENDED_AT_LONG		= "Kampf gegen %s (%s) hat nach %s aufgehört. Das war deine %d. Niederlage auf diesem Schwierigkeitsgrad."
L.GUILD_COMBAT_ENDED_AT		= "Deine Gilde war %s (%s) unterlegen nach %s."
L.SCENARIO_ENDED_AT			= "%s abgebrochen nach %s."
L.SCENARIO_ENDED_AT_LONG		= "%s abgebrochen nach %s. Das war dein %d. Abbruch auf diesem Schwierigkeitsgrad."
L.COMBAT_STATE_RECOVERED		= "Kampf gegen %s hat vor %s begonnen, Neukalibrierung der Timer erfolgt..."
L.TRANSCRIPTOR_LOG_START		= "\"Transcriptor\"-Aufzeichnung gestartet."
L.TRANSCRIPTOR_LOG_END		= "\"Transcriptor\"-Aufzeichnung beendet."

L.MOVIE_SKIPPED				= "DBM hat versucht eine Videosequenz automatisch zu überspringen."
L.BONUS_SKIPPED				= "DBM hat das Beutefenster für den Bonuswurf automatisch geschlossen. Tippe /dbmbonusroll binnen drei Minuten, um es bei Bedarf anzuzeigen."
L.BONUS_EXPIRED				= "Du hast versucht mittels /dbmbonusroll ein Beutefenster für den Bonuswurf zu öffnen. Es ist derzeit aber leider kein Bonuswurf aktiv."

L.AFK_WARNING				= "Du bist \"AFK\" und im Kampf (%d Prozent Gesundheit verbleibend), Alarmsound ausgelöst.  Entferne deine \"AFK\"-Markierung oder deaktiviere diese Alarmierung unter \"Sonstige Funktionen\", falls du nicht \"AFK\" bist."

L.COMBAT_STARTED_AI_TIMER	= "Meine CPU ist ein neuronaler Prozessor, ein lernender Computer. (Dieser Kampf wird die neuen KI-Funktionen zur Erzeugung von Timernäherungen verwenden.)"

L.PROFILE_NOT_FOUND			= "<DBM> Dein derzeitiges Profil ist korrupt. DBM wird das Profil 'Default' laden."
L.PROFILE_CREATED			= "Profil '%s' erzeugt."
L.PROFILE_CREATE_ERROR		= "Erzeugen des Profils fehlgeschlagen. Ungültiger Profilname."
L.PROFILE_CREATE_ERROR_D		= "Erzeugen des Profils fehlgeschlagen. Profil '%s' existiert bereits."
L.PROFILE_APPLIED			= "Profil '%s' angewendet."
L.PROFILE_APPLY_ERROR		= "Anwenden des Profils fehlgeschlagen. Profil '%s' existiert nicht."
L.PROFILE_COPIED				= "Profil '%s' kopiert."
L.PROFILE_COPY_ERROR			= "Kopieren des Profils fehlgeschlagen. Profil '%s' existiert nicht."
L.PROFILE_COPY_ERROR_SELF	= "Das Profil kann nicht auf sich selbst kopiert werden."
L.PROFILE_DELETED			= "Profil '%s' gelöscht. Profil 'Default' wird angewendet."
L.PROFILE_DELETE_ERROR		= "Löschen des Profils fehlgeschlagen. Profil '%s' existiert nicht."
L.PROFILE_CANNOT_DELETE		= "Das Profil 'Default' kann nicht gelöscht werden."
L.MPROFILE_COPY_SUCCESS		= "Mod-Einstellungen von %s (Spez. %d) wurden kopiert."
L.MPROFILE_COPY_SELF_ERROR	= "Die Charaktereinstellungen können nicht auf sich selbst kopiert werden."
L.MPROFILE_COPY_S_ERROR		= "Quelle korrupt. Die Einstellungen wurden nicht oder unvollständig kopiert. Kopieren fehlgeschlagen."
L.MPROFILE_COPYS_SUCCESS		= "Mod-Soundeinstellungen oder Notizen von %s (Spez. %d) wurden kopiert."
L.MPROFILE_COPYS_SELF_ERROR	= "Die Charaktersoundeinstellungen oder Notizen können nicht auf sich selbst kopiert werden."
L.MPROFILE_COPYS_S_ERROR		= "Quelle korrupt. Die Soundeinstellungen oder Notizen wurden nicht oder unvollständig kopiert. Kopieren fehlgeschlagen."
L.MPROFILE_DELETE_SUCCESS	= "Mod-Einstellungen von %s (Spez. %d) wurden gelöscht."
L.MPROFILE_DELETE_SELF_ERROR	= "Die derzeit genutzten Mod-Einstellungen können nicht gelöscht werden."
L.MPROFILE_DELETE_S_ERROR	= "Quelle korrupt. Die Einstellungen wurden nicht oder unvollständig gelöscht. Löschen fehlgeschlagen."

L.NOTE_SHARE_SUCCESS			= "%s hat die Notiz für %s geteilt."
L.NOTE_SHARE_LINK			= "Hier klicken um die Notiz zu öffnen"
L.NOTE_SHARE_FAIL			= "%s hat versucht eine Notiz mit dir für %s zu teilen. Ein Mod für diese Fähigkeit ist jedoch nicht installiert oder nicht geladen. Falls du diese Notiz benötigst, solltest du sicherstellen, dass du das entsprechende Mod geladen hast und erneut um Teilung der Notiz bitten."

L.NOTEHEADER					= "Gib deine Notiz für %s hier ein. Umschließe Spielernamen mit >< für Klassenfarben. Trenne Notizen mit '/' bei Alarmen mit mehreren Notizen."
L.NOTEFOOTER					= "'OK' um die Änderungen zu akzeptieren, sonst 'Abbrechen'"
L.NOTESHAREDHEADER			= "%s hat die Notiz unten für %s geteilt. Falls du sie akzeptierst, wird deine derzeitige Notiz überschrieben."
L.NOTESHARED					= "Deine Notiz wurde an die Gruppe gesendet."
L.NOTESHAREERRORSOLO			= "Einsam? Du solltest keine Notizen mit dir selbst teilen."
L.NOTESHAREERRORBLANK		= "Leere Notizen können nicht geteilt werden."
L.NOTESHAREERRORGROUPFINDER	= "In automatischen Gruppen der Gruppensuche können keine Notizen geteilt werden."
L.NOTESHAREERRORALREADYOPEN	= "Die geteilte Notiz kann nicht geöffnet werden während der Notizeditor bereits geöffnet ist, damit die gerade von dir bearbeitete Notiz nicht verloren geht."

L.ALLMOD_DEFAULT_LOADED		= "Standardeinstellungen für alle Mods dieser Instanz geladen."
L.ALLMOD_STATS_RESETED		= "Alle Mod-Statistiken wurden zurückgesetzt."
L.MOD_DEFAULT_LOADED			= "Standardeinstellungen für diesen Kampf geladen."

L.WORLDBOSS_ENGAGED			= "Kampf gegen %s wurde möglicherweise auf deinem Realm bei %s Prozent Leben begonnen. (gesendet von %s)"
L.WORLDBOSS_DEFEATED			= "%s wurde möglichweise auf deinem Realm besiegt. (gesendet von %s)"

L.TIMER_FORMAT_SECS			= "%.2f |4Sekunde:Sekunden;"
L.TIMER_FORMAT_MINS			= "%d |4Minute:Minuten;"
L.TIMER_FORMAT				= "%d |4Minute:Minuten; und %.2f |4Sekunde:Sekunden;"

L.MIN						= "Min"
L.MIN_FMT					= "%d Min"
L.SEC						= "Sek"
L.SEC_FMT					= "%s Sek"

L.GENERIC_WARNING_OTHERS		= "und einem anderen"
L.GENERIC_WARNING_OTHERS2	= "und %d anderen"
L.GENERIC_WARNING_BERSERK	= "Berserker in %s %s"
L.GENERIC_TIMER_BERSERK		= "Berserker"
L.OPTION_TIMER_BERSERK		= "Zeige Zeit bis $spell:26662"
L.GENERIC_TIMER_COMBAT		= "Kampfbeginn"
L.OPTION_TIMER_COMBAT		= "Zeige Zeit bis Kampfbeginn"
L.BAD						= "Schlechtes"

L.OPTION_CATEGORY_TIMERS			= "Timer"
L.OPTION_CATEGORY_WARNINGS		= "Allgemeine Ansagen"
L.OPTION_CATEGORY_WARNINGS_YOU	= "Persönliche Ansagen"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Zielansagen"
L.OPTION_CATEGORY_WARNINGS_ROLE	= "Rollenansagen"
L.OPTION_CATEGORY_SOUNDS			= "Sounds"
L.OPTION_CATEGORY_DROPDOWNS		= "Dropdown-Listen"

L.AUTO_RESPONDED						= "Automatisch geantwortet."
L.STATUS_WHISPER						= "%s: %s, %d/%d Spieler am Leben"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s ist damit beschäftigt gegen %s zu kämpfen! (%s, %d/%d Spieler am Leben)"
L.WHISPER_COMBAT_END_KILL			= "%s hat %s besiegt!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s hat %s besiegt! Das war der %d. Sieg."
L.WHISPER_COMBAT_END_WIPE_AT			= "%s war %s bei %s unterlegen."
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s war %s bei %s unterlegen. Das war die %d. Niederlage auf diesem Schwierigkeitsgrad."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s ist beschäftigt in %s (%d/%d Spieler am Leben)"
L.WHISPER_SCENARIO_END_KILL			= "%s hat %s abgeschlossen!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s hat %s abgeschlossen! Das war der %d. Abschluss."
L.WHISPER_SCENARIO_END_WIPE			= "%s hat %s abgebrochen."
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s hat %s abgebrochen. Das war der %d. Abbruch auf diesem Schwierigkeitsgrad."

L.VERSIONCHECK_HEADER		= "Boss Mod - Versionen"
L.VERSIONCHECK_ENTRY			= "%s: %s (%s) %s"--One Boss mod
L.VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) und %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM	= "%s: Kein Boss Mod installiert."
L.VERSIONCHECK_FOOTER		= "%d Spieler mit DBM und %d Spieler mit BigWigs gefunden."
L.VERSIONCHECK_OUTDATED		= "Folgende %d Spieler haben veraltete DBM Versionen: %s"
L.YOUR_VERSION_OUTDATED      = "Deine Version von Deadly Boss Mods ist veraltet! Bitte besuche http://www.deadlybossmods.com um die neueste Version herunterzuladen."
L.VOICE_PACK_OUTDATED		= "Deinem ausgewählten DBM Sprachpack fehlen einige Sounds, die von von DBM unterstützt werden. Für einige Warnungssounds werden weiterhin die Standardsounds abgespielt. Bitte lade dir eine neuere Version des Spachpacks herunter oder kontaktiere den Autor des Sprachpacks für ein Update, welches die fehlenden Sounds enthält."
L.VOICE_MISSING				= "Du hast einen DBM Sprachpack ausgewählt, der nicht gefunden werden konnte. Deine Auswahl wurde auf 'Kein Sprachpack' zurückgesetzt. Bitte stelle sicher, dass der Sprachpack korrekt installiert und in der Addon-Liste aktiviert wurde, falls dies ein Fehler ist."
L.VOICE_DISABLED				= "Du hast derzeit mindestens einen DBM Sprachpack installiert, aber keinen aktiviert. Falls du einen Sprachpack nutzen möchtest, dann wähle ihn unter \"Gesprochene Warnungen\" aus. Ansonsten kannst du die ungenutzten Sprachpacks deinstallieren, um diese Meldung zu unterdrücken."
L.VOICE_COUNT_MISSING		= "Für die Countdown-Stimme %d ist ein Sprach-/Zählpack ausgewählt, der nicht gefunden werden konnte. Die Stimme wurde auf die Standardeinstellung zurückgesetzt: %s."
--L.BIG_WIGS

L.UPDATEREMINDER_HEADER			= "Deine Version von Deadly Boss Mods ist veraltet.\n Version %s (%s) kann über Curse/Twitch, WoWI oder von deadlybossmods.com heruntergeladen werden."
L.UPDATEREMINDER_FOOTER			= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Downloadlink in die Zwischenablage zu kopieren."
L.UPDATEREMINDER_FOOTER_GENERIC	= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Link in die Zwischenablage zu kopieren."
L.UPDATEREMINDER_DISABLE			= "WARNUNG: Da dein Deadly Boss Mods zu veraltet ist, hat es sich zwangsweise deaktiviert und kann erst nach einer Aktualisierung wieder genutzt werden. Derart alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen."
L.UPDATEREMINDER_HOTFIX			= "Deine Version von DBM hat bekannte Probleme während dieses Bosskampfes, die durch ein Update auf die neueste DBM-Version behoben werden können."
L.UPDATEREMINDER_HOTFIX_ALPHA	= "Deine Version von DBM hat bekannte Probleme während dieses Bosskampfes, die in einer künftigen DBM-Version behoben sind (oder in der neuesten Alphaversion)."
L.UPDATEREMINDER_MAJORPATCH		= "WARNUNG: Da dein Deadly Boss Mods veraltet und deshalb leider für diesen Major Patch des Spiels nicht mehr geeignet ist, hat es sich bis zu einer Aktualisierung deaktiviert. Alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen. Bitte lade dir baldmöglichst eine neue Version von deadlybossmods.com oder Curse herunter."
L.VEM							= "WARNUNG: Du benutzt Deadly Boss Mods zusammen mit Voice Encounter Mods. DBM läuft nicht in dieser Konfiguration und wird deshalb nicht geladen."
L.OUTDATEDPROFILES					= "WARNUNG: DBM-Profiles ist mit dieser Version von DBM nicht kompatibel. Es muss entfernt werden bevor DBM genutzt werden kann um Konflikte zu vermeiden."
L.DPMCORE						= "WARNUNG: Deadly Pvp Mods (DPM) wird nicht mehr gepflegt und ist mit dieser Version von DBM nicht kompatibel. Es muss entfernt werden bevor DBM genutzt werden kann um Konflikte zu vermeiden."
L.DBMLDB							= "WARNUNG: DBM-LDB ist nun DBM-Core integriert. Obwohl es keine schädlichen Auswirkungen hat, wird empfohlen 'DBM-LDB' aus dem Addon-Ordner zu entfernen."
L.UPDATE_REQUIRES_RELAUNCH		= "WARNUNG: Dieses Update von DBM arbeitet erst nach einem vollständigem Neustart des Spielclients korrekt. Das Update enthält neue Dateien oder Änderungen an .toc-Dateien, die nicht mit \"/reload\" geladen werden können. Die Funktionsfähigkeit von DBM kann beeinträchtigt sein und es können Fehler auftreten, bis du den Spielclient neu startest."
L.OUT_OF_DATE_NAG				= "Deine Version von Deadly Boss Mods ist veraltet. Du solltest eine Aktualisierung für diesen Kampf durchführen, da du sonst wichtige Warnungen oder Timer verpassen könntest oder automatische \"Schreie\" fehlen, die der Rest deines Schlachtzuges von dir erwartet."

L.MOVABLE_BAR				= "Zieh mich!"

L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h hat dir einen DBM-Timer geschickt: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Diesen Timer abbrechen]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Timer von %1$s ignorieren]|r|h"
--L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h hat dir einen DBM-Timer geschickt"
L.PIZZA_CONFIRM_IGNORE			= "Willst du wirklich DBM-Timer von %s für diese Sitzung ignorieren?"
L.PIZZA_ERROR_USAGE				= "Benutzung: /dbm [broadcast] timer <Sekunden> <Text>. <Sekunden> muss größer als 1 sein."

--L.MINIMAP_TOOLTIP_HEADER
L.MINIMAP_TOOLTIP_FOOTER		= "Shift gedrückt halten und Ziehen zum Bewegen"

L.RANGECHECK_HEADER			= "Abstandscheck (%dm)"
L.RANGECHECK_SETRANGE		= "Abstand einstellen"
L.RANGECHECK_SETTHRESHOLD	= "Spielerschwellwert"
L.RANGECHECK_SOUNDS			= "Sounds"
L.RANGECHECK_SOUND_OPTION_1	= "Sound, falls ein Spieler in Reichweite ist"
L.RANGECHECK_SOUND_OPTION_2	= "Sound, falls mehr als ein Spieler in Reichweite ist"
L.RANGECHECK_SOUND_0			= "Kein Sound"
L.RANGECHECK_SOUND_1			= "Standard-Sound"
L.RANGECHECK_SOUND_2			= "Nerviges Piepsen"
L.RANGECHECK_SETRANGE_TO		= "%dm"
L.RANGECHECK_OPTION_FRAMES	= "Fenster"
L.RANGECHECK_OPTION_RADAR	= "Zeige Radarfenster"
L.RANGECHECK_OPTION_TEXT		= "Zeige Textfenster"
L.RANGECHECK_OPTION_BOTH		= "Zeige beide Fenster"
L.RANGERADAR_HEADER			= "Abstand:%dm Spieler:%d"
L.RANGERADAR_IN_RANGE_TEXT	= "%d in Reichweite (%0.1fm)"
L.RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fm)"

L.INFOFRAME_SHOW_SELF		= "Eigene Stärke immer anzeigen" -- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES			= "Setze maximale Zeilenanzahl"
L.INFOFRAME_LINESDEFAULT		= "gesetzt vom Mod"
L.INFOFRAME_LINES_TO			= "%d Zeilen"
L.INFOFRAME_POWER			= "Energie"
L.INFOFRAME_MAIN				= "Primär:"--Main power
L.INFOFRAME_ALT				= "Alt:"--Alternate Power

L.LFG_INVITE						= "Einladung der Gruppensuche"

L.SLASHCMD_HELP				= {
	"Verfügbare Slash-Kommandos:",
	"-----------------",
	"/dbm unlock: Zeigt einen bewegbaren Timer an (alias: move).",
	"/range <number> oder /distance <number>: Zeige Abstandsfenster. /rrange oder /rdistance um die Farben zu invertieren.",
	"/hudar <number>: Zeige HudMap-basierenden Abstandssucher.",
	"/dbm timer: Startet einen benutzerdefinierten DBM-Timer, siehe '/dbm timer' für Details.",
	"/dbm arrow: Zeigt den DBM-Pfeil, siehe '/dbm arrow help' für Details.",
	"/dbm hud: Zeige die DBM-HudMap, siehe '/dbm hud' für Details.",
	"/dbm help2: Zeige Slash-Kommandos für das Management von Schlachtzügen."
}
L.SLASHCMD_HELP2				= {
	"Verfügbare Slash-Kommandos:",
	"-----------------",
	"/dbm pull <sec>: Schickt einen Pull-Timer für <sec> Sekunden an alle Schlachzugsmitglieder (nur als Leiter/Assistent).",
	"/dbm break <min>: Schickt einen Pause-Timer für <min> Minuten an alle Schlachzugsmitglieder (nur als Leiter/Assistent).",
	"/dbm version: Führt eine Boss Mod Versionsprüfung durch (Alias: ver).",
	"/dbm version2: Führt eine Boss Mod Versionsprüfung durch und flüstert Nutzer mit veralteten Versionen an (Alias: ver2).",
	"/dbm lockout: Fragt die Schlachtzugsmitglieder nach ihren derzeitigen Instanzsperren (IDs) (nur als Leiter/Assistent) (Aliase: lockouts, ids).",
	"/dbm lag: Prüft die Latenz im gesamten Schlachtzug.",
	"/dbm durability: Prüft die Haltbarkeit im gesamten Schlachtzug."
}
L.TIMER_USAGE	= {
	"DBM-Timer Kommandos:",
	"/dbm timer <sec> <text>: Startet einen <sec> Sekunden langen Timer mit deinem <text>.",
	"/dbm ltimer <sec> <text>: Startet einen Timer, der automatisch wiederholt wird, bis er abgebrochen wird.",
	"/dbm broadcast timer/ltimer/cltimer <sec> <text>: schickt den Timer an den Schlachtzug (nur als Leiter/Assistent).",
	"/dbm timer endloop: Stoppt alle ltimer-.",
}

L.ERROR_NO_PERMISSION				= "Du hast nicht die benötigte Berechtigung für diesen Befehl!"

--Common Locals
L.NEXT							= "Nächste %s"
L.COOLDOWN						= "%s CD"
L.UNKNOWN					= "unbekannt"
L.LEFT						= "Links"
L.RIGHT						= "Rechts"
L.BOTH						= "Beide"
L.BACK						= "Hinten"
L.SIDE						= "Seite"
L.TOP						= "Oben"
L.BOTTOM						= "Unten"
L.MIDDLE						= "Mitte"
L.FRONT						= "Vorne"
L.EAST						= "Osten"
L.WEST						= "Westen"
L.NORTH						= "Norden"
L.SOUTH						= "Süden"
L.INTERMISSION				= "Übergang"
L.ORB						= "Kugel"
L.CHEST							= "Kiste"
L.NO_DEBUFF						= "Kein %s"
L.ALLY							= "Verbündeten"
L.ADD								= "Add"
L.ADDS							= "Adds"
L.ROOM_EDGE					= "Rand des Raums"
L.FAR_AWAY					= "Weit weg"
L.BREAK_LOS					= "Meide Sichtlinie"
L.SAFE						= "Sicher"
L.SHIELD						= "Schutzschild"
L.INCOMING						= "%s kommt"
L.BOSSTOGETHER				= "Bosses Together"
L.BOSSAPART					= "Bosses Apart"
--Common Locals end

L.BREAK_USAGE				= "Ein Pause-Timer kann nicht länger als 60 Minuten sein. Beachte bitte, dass für Pausen-Timer die Zeit in Minuten (und nicht in Sekunden) anzugeben ist."
L.BREAK_START				= "Pause startet jetzt -- du hast %s! (gesendet von: %s)"
L.BREAK_MIN					= "Pause endet in %s Minute(n)!"
L.BREAK_SEC					= "Pause endet in %s Sekunden!"
L.TIMER_BREAK				= "Pause!"
L.ANNOUNCE_BREAK_OVER		= "Pause ist vorbei (seit %s Uhr)"

L.TIMER_PULL					= "Pull in"
L.ANNOUNCE_PULL				= "Pull in %d Sekunden. (gesendet von: %s)"
L.ANNOUNCE_PULL_NOW			= "Pull jetzt!"
L.ANNOUNCE_PULL_TARGET		= "Pulle %s in %d Sekunden. (gesendet von: %s)"
L.ANNOUNCE_PULL_NOW_TARGET	= "Pulle %s jetzt!"
L.GEAR_WARNING				= "Warnung: Prüfe deine Ausrüstung. Deine angelegte Gegenstandsstufe ist um %d niedriger als die in deinen Taschen."
L.GEAR_WARNING_WEAPON		= "Warnung: Prüfe ob du deine Waffe korrekt angelegt hast."
L.GEAR_FISHING_POLE			= "Angelrute"

L.ACHIEVEMENT_TIMER_SPEED_KILL = "Zeit für Erfolg"

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.you		= "%s auf DIR"
L.AUTO_ANNOUNCE_TEXTS.target		= "%s auf >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) auf >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell		= "%s"
L.AUTO_ANNOUNCE_TEXTS.ends 		= "%s ist beendet"
L.AUTO_ANNOUNCE_TEXTS.endtarget	= "%s ist beendet: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades		= "%s ist beendet"
L.AUTO_ANNOUNCE_TEXTS.adds		= "%s verbleibend: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast		= "Wirkt %s: %.1f Sek"
L.AUTO_ANNOUNCE_TEXTS.soon		= "%s bald"
L.AUTO_ANNOUNCE_TEXTS.sooncount	= "%s (%%s) bald"
L.AUTO_ANNOUNCE_TEXTS.prewarn		= "%s in %s"
L.AUTO_ANNOUNCE_TEXTS.stage		= "Phase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage	= "Phase %s bald"
L.AUTO_ANNOUNCE_TEXTS.count		= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack		= "%s auf >%%s< (%%d)"

local prewarnOption = "Zeige Vorwarnung für $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you			= "Verkünde, wenn du von $spell:%s betroffen bist"
L.AUTO_ANNOUNCE_OPTIONS.target		= "Verkünde Ziele von $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetcount	= "Verkünde Ziele von $spell:%s (mit Zählung)"
L.AUTO_ANNOUNCE_OPTIONS.spell		= "Zeige Warnung für $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.ends		= "Zeige Warnung, wenn $spell:%s beendet ist"
L.AUTO_ANNOUNCE_OPTIONS.endtarget	= "Zeige Warnung, wenn $spell:%s beendet ist"
L.AUTO_ANNOUNCE_OPTIONS.fades		= "Zeige Warnung, wenn $spell:%s beendet ist"
L.AUTO_ANNOUNCE_OPTIONS.adds		= "Verkünde die Anzahl der verbleibenden $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.cast		= "Zeige Warnung, wenn $spell:%s gewirkt wird"
L.AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount	= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.prewarn 	= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.stage		= "Verkünde Phase %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange	= "Verkünde Phasenwechsel"
L.AUTO_ANNOUNCE_OPTIONS.prestage	= "Zeige Vorwarnung für Phase %s"
L.AUTO_ANNOUNCE_OPTIONS.count		= "Zeige Warnung für $spell:%s (mit Zählung)"
L.AUTO_ANNOUNCE_OPTIONS.stack		= "Verkünde $spell:%s Stapel"

L.AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends				= "%s beendet"
L.AUTO_SPEC_WARN_TEXTS.fades				= "%s beendet"
L.AUTO_SPEC_WARN_TEXTS.soon				= "%s bald"
L.AUTO_SPEC_WARN_TEXTS.sooncount			= "%s (%%s) bald"
L.AUTO_SPEC_WARN_TEXTS.prewarn			= "%s in %s"
L.AUTO_SPEC_WARN_TEXTS.dispel			= "%s auf >%%s< - jetzt reinigen"
L.AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - unterbrich >%%s<!"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - unterbrich >%%s<! (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you				= "%s auf dir"
L.AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) auf dir"
L.AUTO_SPEC_WARN_TEXTS.youpos			= "%s (Position: %%s) auf dir"
L.AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Soak Position: %%s)"
L.AUTO_SPEC_WARN_TEXTS.target			= "%s auf >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) auf >%%s< "
L.AUTO_SPEC_WARN_TEXTS.defensive			= "%s - Defensivfähigkeiten"
L.AUTO_SPEC_WARN_TEXTS.taunt				= "%s auf >%%s< - jetzt spotten"
L.AUTO_SPEC_WARN_TEXTS.close				= "%s auf >%%s< in deiner Nähe"
L.AUTO_SPEC_WARN_TEXTS.move				= "%s - geh weg"
L.AUTO_SPEC_WARN_TEXTS.keepmove			= "%s - lauf weiter"
L.AUTO_SPEC_WARN_TEXTS.stopmove			= "%s - bleib stehen"
L.AUTO_SPEC_WARN_TEXTS.dodge				= "%s - Angriff ausweichen"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc			= "%s von %%s - ausweichen"
L.AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - geh weg von anderen"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount		= "%s (%%s) - geh weg von anderen"
L.AUTO_SPEC_WARN_TEXTS.moveto			= "%s - geh zu >%%s<"
L.AUTO_SPEC_WARN_TEXTS.jump				= "%s - spring"
L.AUTO_SPEC_WARN_TEXTS.run				= "%s - lauf weg"
L.AUTO_SPEC_WARN_TEXTS.cast				= "%s - stoppe Zauber"
L.AUTO_SPEC_WARN_TEXTS.lookaway			= "%s - schau weg"
L.AUTO_SPEC_WARN_TEXTS.reflect			= "%s auf >%%s< - stoppe Angriffe"
L.AUTO_SPEC_WARN_TEXTS.count				= "%s! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack				= "%%d Stapel von %s auf dir"
L.AUTO_SPEC_WARN_TEXTS.switch			= "%s - Ziel wechseln"
L.AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - Ziel wechseln (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo				= "%%s unter dir - lauf raus"
L.AUTO_SPEC_WARN_TEXTS.adds				= "Adds kommen - Ziel wechseln"
L.AUTO_SPEC_WARN_TEXTS.addscustom		= "Adds kommen - %%s"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Spezialwarnung für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends 			= "Spezialwarnung, wenn $spell:%s beendet ist"
L.AUTO_SPEC_WARN_OPTIONS.fades 			= "Spezialwarnung, wenn $spell:%s beendet ist"
L.AUTO_SPEC_WARN_OPTIONS.soon 			= "Spezialvorwarnung für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.sooncount		= "Spezialvorwarnung (mit Zählung) für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Spezialvorwarnung %s Sekunden vor $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 			= "Spezialwarnung zum Reinigen/Rauben von $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Spezialwarnung zum Unterbrechen von $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Spezialwarnung (mit Zählung) zum Unterbrechen von $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Spezialwarnung, wenn du von $spell:%s betroffen bist"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Spezialwarnung (mit Zählung), wenn du von $spell:%s betroffen bist"
L.AUTO_SPEC_WARN_OPTIONS.youpos			= "Spezialwarnung (mit Position), wenn du von $spell:%s betroffen bist"
L.AUTO_SPEC_WARN_OPTIONS.soakpos			= "Spezialwarnung (mit Position) zur Schadensteilung mit von $spell:%s Betroffenen"
L.AUTO_SPEC_WARN_OPTIONS.target 			= "Spezialwarnung, wenn jemand von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Spezialwarnung (mit Zählung), wenn jemand von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.defensive 		= "Spezialwarnung zur Nutzung von Defensivfähigkeiten bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt 			= "Spezialwarnung zum Spotten, wenn der andere Tank von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Spezialwarnung, wenn jemand in deiner Nähe von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Spezialwarnung zum Herausgehen aus $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Spezialwarnung zum Weiterlaufen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Spezialwarnung zum Stehen bleiben bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Spezialwarnung zum Ausweichen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "Spezialwarnung (mit Ort) zum Ausweichen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveaway		= "Spezialwarnung zum Weggehen von anderen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "Spezialwarnung (mit Zählung) zum Weggehen von anderen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveto			= "Spezialwarnung zum Hingehen zu jemand oder zu einem Ort bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.jump			= "Spezialwarnung zum Springen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Spezialwarnung zum Weglaufen vor $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Spezialwarnung zum Zauberstopp bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.lookaway		= "Spezialwarnung zum Wegschauen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect 		= "Spezialwarnung zum Angriffsstopp auf $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.count 			= "Spezialwarnung für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack 			= "Spezialwarnung bei >=%d Stapel von $spell:%s auf dir"
L.AUTO_SPEC_WARN_OPTIONS.switch			= "Spezialwarnung für Zielwechsel auf $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount		= "Spezialwarnung (mit Zählung) für Zielwechsel auf $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Spezialwarnung zum Rauslaufen aus schlechten Dingen auf dem Boden"
L.AUTO_SPEC_WARN_OPTIONS.adds			= "Spezialwarnung für Zielwechsel auf ankommende Adds"
L.AUTO_SPEC_WARN_OPTIONS.addscustom		= "Spezialwarnung für ankommende Adds"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target		= "%s: %%s"
L.AUTO_TIMER_TEXTS.cast		= "%s"
L.AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
L.AUTO_TIMER_TEXTS.active		= "%s endet"--Buff/Debuff/event on boss
L.AUTO_TIMER_TEXTS.fades		= "%s schwindet"--Buff/Debuff on players
L.AUTO_TIMER_TEXTS.ai			= "%s KI"
L.AUTO_TIMER_TEXTS.cd			= "%s CD"
L.AUTO_TIMER_TEXTS.cdcount		= "%s CD (%%s)"
L.AUTO_TIMER_TEXTS.cdsource	= "%s CD: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial	= "Spezial CD"
L.AUTO_TIMER_TEXTS.next		= "Nächster %s"
L.AUTO_TIMER_TEXTS.nextcount	= "Nächster %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource	= "Nächster %s: %%s"
L.AUTO_TIMER_TEXTS.nextspecial	= "Nächste Spezial"
L.AUTO_TIMER_TEXTS.achievement	= "%s"
L.AUTO_TIMER_TEXTS.stage		= "Nächste Phase"
L.AUTO_TIMER_TEXTS.adds		= "Nächste Adds"
L.AUTO_TIMER_TEXTS.addscustom	= "Nächste Adds (%%s)"
--L.AUTO_TIMER_TEXTS.roleplay

L.AUTO_TIMER_OPTIONS.target		= "Dauer des Debuffs $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.cast		= "Wirkzeit von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.castsource	= "Wirkzeit von $spell:%s anzeigen (mit Quelle)"
L.AUTO_TIMER_OPTIONS.active		= "Dauer von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.fades		= "Zeit bis $spell:%s von Spielern schwindet anzeigen"
L.AUTO_TIMER_OPTIONS.ai			= "KI-Timer für die Abklingzeit von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.cd			= "Abklingzeit von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.cdcount		= "Abklingzeit von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.cdsource	= "Abklingzeit von $spell:%s anzeigen (mit Quelle)"
L.AUTO_TIMER_OPTIONS.cdspecial	= "Abklingzeit für Spezialfähigkeit anzeigen"
L.AUTO_TIMER_OPTIONS.next		= "Zeit bis nächstes $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.nextcount	= "Zeit bis nächstes $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.nextsource	= "Zeit bis nächstes $spell:%s anzeigen (mit Quelle)"
L.AUTO_TIMER_OPTIONS.nextspecial	= "Zeige Zeit bis nächste Spezialfähigkeit"
L.AUTO_TIMER_OPTIONS.achievement	= "Zeit für %s anzeigen"
L.AUTO_TIMER_OPTIONS.stage		= "Zeige Zeit bis nächste Phase"
L.AUTO_TIMER_OPTIONS.adds		= "Zeige Zeit bis Adds erscheinen"
L.AUTO_TIMER_OPTIONS.addscustom	= "Zeige Zeit bis Adds erscheinen"
L.AUTO_TIMER_OPTIONS.roleplay	= "Dauer des Rollenspiels anzeigen"


L.AUTO_ICONS_OPTION_TEXT			= "Setze Zeichen auf Ziele von $spell:%s"
L.AUTO_ICONS_OPTION_TEXT2		= "Setze Zeichen auf $spell:%s"
L.AUTO_ARROW_OPTION_TEXT			= "Zeige DBM-Pfeil zum Hingehen zum von $spell:%s betroffenen Ziel"
L.AUTO_ARROW_OPTION_TEXT2		= "Zeige DBM-Pfeil zum Weggehen vom von $spell:%s betroffenen Ziel"
L.AUTO_ARROW_OPTION_TEXT3		= "Zeige DBM-Pfeil zum Hingehen zum richtigen Ort für $spell:%s"

L.AUTO_YELL_OPTION_TEXT.shortyell	= "Schreie, wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.yell			= "Schreie (mit Spielernamen), wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.count		= "Schreie (mit Zählung), wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.fade			= "Schreie (mit Countdown und Zaubernamen), wenn $spell:%s endet"
L.AUTO_YELL_OPTION_TEXT.shortfade	= "Schreie (mit Countdown), wenn $spell:%s endet"
L.AUTO_YELL_OPTION_TEXT.iconfade		= "Schreie (mit Countdown und Zeichen), wenn $spell:%s endet"
L.AUTO_YELL_OPTION_TEXT.position		= "Schreie (mit Position), wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.combo		= "Schreie (mit angepasstem Text), wenn du gleichzeitig von $spell:%s und einem weiteren Zauber betroffen bist"

L.AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%s"
L.AUTO_YELL_ANNOUNCE_TEXT.yell		= "%s auf " .. UnitName("player")
L.AUTO_YELL_ANNOUNCE_TEXT.count		= "%s auf " .. UnitName("player") .. " (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade		= "%s endet in %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade	= "{rt%%2$d}%%1$d"
L.AUTO_YELL_ANNOUNCE_TEXT.position	= "%s %%s auf {rt%%d}"..UnitName("player").."{rt%%d}"
L.AUTO_YELL_ANNOUNCE_TEXT.combo		= "%s und %%s"

--L.AUTO_YELL_CUSTOM_POSITION
L.AUTO_YELL_CUSTOM_FADE			= "%s beendet"
L.AUTO_HUD_OPTION_TEXT			= "Zeige HudMap für $spell:%s (außer Betrieb)"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "Zeige HudMap für diverse Mechaniken (außer Betrieb)"
L.AUTO_NAMEPLATE_OPTION_TEXT		= "Zeige Namensplakettenaura für $spell:%s"
L.AUTO_RANGE_OPTION_TEXT			= "Zeige Abstandsfenster (%sm) für $spell:%s"
L.AUTO_RANGE_OPTION_TEXT_SHORT	= "Zeige Abstandsfenster (%sm)"
L.AUTO_RRANGE_OPTION_TEXT		= "Zeige inverses Abstandsfenster (%sm) für $spell:%s"
L.AUTO_RRANGE_OPTION_TEXT_SHORT	= "Zeige inverses Abstandsfenster (%sm)"
L.AUTO_INFO_FRAME_OPTION_TEXT	= "Zeige Infofenster für $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2	= "Zeige Infofenster für Kampfübersicht"
L.AUTO_READY_CHECK_OPTION_TEXT	= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Boss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"

-- New special warnings
L.MOVE_WARNING_BAR			= "bewegbare Schlachtzugwarnung"
L.MOVE_WARNING_MESSAGE		= "Danke, dass du Deadly Boss Mods verwendest"
L.MOVE_SPECIAL_WARNING_BAR	= "bewegbare Spezialwarnung"
L.MOVE_SPECIAL_WARNING_TEXT	= "Spezialwarnung"

L.HUD_INVALID_TYPE			= "Der angegebene Typ für die HudMap ist ungültig."
L.HUD_INVALID_TARGET			= "Es wurde kein gültiges Ziel für die HudMap angegeben."
L.HUD_INVALID_SELF			= "Die HudMap kann nicht auf dich selbst zeigen."
L.HUD_INVALID_ICON			= "Der Typ 'icon' für die HudMap kann nicht auf Ziele ohne gesetztem Schlachtzugzeichen angewendet werden."
L.HUD_SUCCESS				= "Die HudMap wurde erfolgreich mit deinen Parametern gestartet. Sie läuft nach %s aus oder zuvor durch Aufruf von '/dbm hud hide'."
L.HUD_USAGE	= {
	"Benutzung der DBM-HudMap:",
	"-----------------",
	"/dbm hud <Typ> <Ziel> <Dauer>: Erzeugt eine HudMap, die für die gewünschte Dauer auf einen Spieler zeigt",
	"gültige Typen: arrow, dot, red, blue, green, yellow, icon (benötigt ein Ziel mit gesetztem Schlachtzugzeichen)",
	"gültige Ziele: target, focus, <Spielername>",
	"gültige Dauer: beliebige Zahl (in Sekunden). 20 Minuten, falls Dauer nicht angegeben.",
	"/dbm hud hide: Deaktiviert und versteckt die HudMap"
}

L.ARROW_MOVABLE					= "Pfeil (bewegbar)"
L.ARROW_WAY_USAGE					= "/dway <x> <y>: Erzeugt einen Pfeil, der auf einen bestimmten Ort zeigt (benutzt lokale Kartenkoordinaten der Zone)"
L.ARROW_WAY_SUCCESS				= "Um den Pfeil zu verstecken '/dbm arrow hide' eingeben oder das Pfeilziel erreichen"
L.ARROW_ERROR_USAGE	= {
	"Benutzung des DBM-Pfeils:",
	"-----------------",
	"/dbm arrow <x> <y>: Erzeugt einen Pfeil, der auf einen bestimmten Ort zeigt (benutzt Weltkoordinaten)",
	"/dbm arrow map <x> <y>: Erzeugt einen Pfeil, der auf einen bestimmten Ort zeigt (benutzt Kartenkoordinaten der Zone)",
	"/dbm arrow <player>: Erzeugt einen Pfeil, der auf einen bestimmten Spieler in deiner Gruppe oder deinem Schlachtzug zeigt (unterscheidet Groß-/Kleinschreibung)",
	"/dbm arrow hide: Versteckt den Pfeil",
	"/dbm arrow move: Macht den Pfeil beweglich"
}

L.SPEED_KILL_TIMER_TEXT	= "Rekordzeit"
L.SPEED_CLEAR_TIMER_TEXT	= "Abschlussbestzeit"
L.COMBAT_RES_TIMER_TEXT	= "Kampfbelebung +"
L.TIMER_RESPAWN		= "%s Wiedererscheinen"


L.REQ_INSTANCE_ID_PERMISSION		= "%s möchte deine aktuellen Instanzsperren (IDs) einsehen.\n Möchtest Du diese Informationen an %s senden? Dieser Spieler wird in der Lage sein, diese Informationen während deiner aktuellen Sitzung abzufragen (also bis du dich neu einloggst)."
L.ERROR_NO_RAID					= "Du musst dich in einem Schlachtzug befinden um dieses Feature nutzen zu können."
L.INSTANCE_INFO_REQUESTED			= "Frage den gesamten Schlachtzug nach Instanzsperren (IDs) ab.\nBitte beachte, dass die Spieler nach ihrer Erlaubnis gefragt werden, bevor die Daten an dich gesendet werden. Bis zum Erhalt aller Antworten kann also einige Zeit vergehen."
L.INSTANCE_INFO_STATUS_UPDATE		= "Antworten von %d Spielern von %d DBM-Nutzern erhalten: %d sendeten Daten, %d haben die Anfrage abgelehnt. Warte %d weitere Sekunden auf Antworten..."
L.INSTANCE_INFO_ALL_RESPONSES		= "Antworten von allen Mitgliedern des Schlachtzuges erhalten"
L.INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"  -- debug message not translated by intention
L.INSTANCE_INFO_DETAIL_HEADER		= "%s, Schwierigkeitsgrad %s:"
L.INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, Fortschritt %d: %s"
L.INSTANCE_INFO_DETAIL_INSTANCE2	= "    Fortschritt %d: %s"
L.INSTANCE_INFO_NOLOCKOUT			= "In deiner Schlachtzuggruppe sind keine Informationen über Instanzsperren vorhanden."
L.INSTANCE_INFO_STATS_DENIED		= "Anfrage abgelehnt: %s"
L.INSTANCE_INFO_STATS_AWAY		= "Abwesend: %s"
L.INSTANCE_INFO_STATS_NO_RESPONSE	= "Keine aktuelle DBM-Version installiert: %s"
L.INSTANCE_INFO_RESULTS			= "Ergebnis des Instanzsperren-Scans (IDs). Bitte beachte, dass Instanzen mehrmals angezeigt werden, wenn sich Spieler mit anderssprachigen WoW-Klienten im Schlachtzug befinden."
L.INSTANCE_INFO_SHOW_RESULTS		= "Spieler die noch nicht geantwortet haben: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Ergebnisse jetzt anzeigen]|r|h"
--L.INSTANCE_INFO_SHOW_RESULTS		= "Spieler die noch nicht geantwortet haben: %s"

L.LAG_CHECKING				= "Prüfe Schlachtzuglatenz..."
L.LAG_HEADER					= "Deadly Boss Mods - Latenzergebnisse"
L.LAG_ENTRY					= "%s: %dms (Welt) / %dms (Standort)"
L.LAG_FOOTER					= "Keine Antwort: %s"

L.DUR_CHECKING				= "Prüfe Schlachtzughaltbarkeit..."
L.DUR_HEADER					= "Deadly Boss Mods - Haltbarkeitergebnisse"
L.DUR_ENTRY					= "%s: Haltbarkeit [%d Prozent] / Ausrüstung defekt [%s]"
L.LAG_FOOTER					= "Keine Antwort: %s"

--LDB
L.LDB_TOOLTIP_HELP1	= "Links-Klick, um DBM zu öffnen."
L.LDB_TOOLTIP_HELP2	= "Rechts-Klick, um das Konfigurationsmenü zu öffnen."

L.LDB_LOAD_MODS		= "Lade Boss Mod"

L.LDB_CAT_OTHER		= "Sonstige Boss Mods"

L.LDB_CAT_GENERAL		= "Allgemein"
L.LDB_ENABLE_BOSS_MOD	= "Aktiviere Boss Mod"
