if GetLocale() ~= "deDE" then return end

DBM_CORE_NEED_LOCALS				= "Hey, bist du ein Programmierer oder gut in Fremdsprachen? Falls ja, benötigt DBM deine Hilfe, um in mehr Sprachen übersetzt zu werden. Falls du helfen kannst, dann besuche |HDBM:localizersneeded|h|cff3588ffunser Forum|r."
DBM_CORE_NEED_LOGS					= "DBM benötigt Transcriptor (http://www.wowace.com/addons/transcriptor/) Logs dieser Testkämpfe um möglichst gute Mods bereitstellen zu können. Falls du helfen willst, dann zeichne diese Testkämpfe mit Transcriptor auf und poste sie in unser Forum. Es werden nur Logs von 7.0 Schlachtzügen und Dungeons benötigt."
DBM_HOW_TO_USE_MOD					= "Willkommen bei DBM. Tippe /dbm help für eine Liste unterstützter Kommandos. Für den Zugriff auf Einstellungen tippe /dbm in den Chat um die Konfiguration zu beginnen. Lade gewünschte Zonen manuell um jegliche Boss-spezifische Einstellungen nach deinen Wünschen zu konfigurieren. DBM versucht dies für dich zu tun, indem es beim ersten Start deine Spezialisierung scannt, aber du kannst zusätzliche Einstellungen aktivieren."
DBM_SILENT_REMINDER					= "Erinnerung: DBM befindet sich noch im Lautlos-Modus."

DBM_FORUMS_MESSAGE					= "Du hast einen Bug oder einen falschen Timer gefunden? Du glaubst einige Mods würden zusätzliche Warnungen, Timer oder Spezialfeatures benötigen?\nBesuche die neuen Deadly Boss Mods Foren für Diskussionen, Fehlermeldungen und Featurewünsche: |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (Du kannst auf den Link klicken um ihn zu kopieren.)"
DBM_FORUMS_COPY_URL_DIALOG			= "Besuche unsere Diskussions- und Support-Foren"
DBM_FORUMS_COPY_URL_DIALOG_NEWS		= "Besuche unser Forum um mehr über dieses Feature und seine Verwendung zu erfahren"

DBM_CORE_LOAD_MOD_ERROR				= "Fehler beim Laden der Boss Mods für %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Boss Mods für '%s' geladen. Für weitere Einstellungen wie benutzerdefinierte Sounds und individuelle Warnnotizen /dbm eingeben."
DBM_CORE_LOAD_MOD_COMBAT			= "Laden von '%s' verzögert bis du den Kampf verlässt."
DBM_CORE_LOAD_GUI_ERROR				= "Konnte die grafische Benutzeroberfläche nicht laden: %s."
DBM_CORE_LOAD_GUI_COMBAT			= "Die grafische Benutzeroberfläche kann nicht im Kampf geladen werden. Zur Vornahme von Einstellungen bitte diese zunächst außerhalb des Kampfes laden. Danach steht sie auch im Kampf zur Verfügung."
DBM_CORE_BAD_LOAD					= "Dein Boss Mod für diese Instanz konnte nicht vollständig korrekt im Kampf geladen werden. Bitte führe baldmöglichst nach Kampfende /reload aus."
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s kann nicht geladen werden, da dein DBM-Core die Voraussetzungen nicht erfüllt. Es wird eine aktualisierte Version benötigt."
DBM_CORE_LOAD_MOD_DISABLED			= "%s ist installiert, aber derzeit nicht aktiviert. Dieses Mod wird nicht geladen, falls du es nicht aktivierst."
DBM_CORE_LOAD_MOD_DISABLED_PLURAL	= "%s sind installiert, aber derzeit nicht aktiviert. Diese Mods werden nicht geladen, falls du sie nicht aktivierst."

--DBM_CORE_WHATS_NEW
--DBM_CORE_WHATS_NEW_LINK

--Post Patch 7.1
DBM_CORE_NO_RANGE					= "Das Abstandsradar kann in Instanzen nicht genutzt werden. Es wird stattdessen die alte textbasierte Abstandsanzeige verwendet."
DBM_CORE_NO_ARROW					= "Der Pfeil kann in Instanzen nicht genutzt werden."
DBM_CORE_NO_HUD						= "Die HudMap kann in Instanzen nicht genutzt werden."

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM hat das dynamische Abstandsfenster für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, auf wieviel versammelte Spieler bei deiner Gruppengröße geprüft werden muss."
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM hat Warnungen bezüglich der Anzahl der Gegner für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, wieviel Gegner bei deiner Gruppengröße erscheinen."
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM hat mehrere Funktionalitäten für diesen Kampf deaktiviert, da für deine Gruppengröße nicht genügend Informationen über bestimmte Kampfmechaniken vorliegen."

DBM_CORE_LOOT_SPEC_REMINDER			= "Deine aktuelle Spezialisierung ist %s. Deine aktuelle Beutespezialisierung ist %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM hat festgestellt, dass du das Setzen von Schlachtzugzeichen in \"BigWigs\" und in \"DBM\" aktiviert hast. Bitte deaktiviere das Setzen von Zeichen in einem der beiden Addons um Konflikte zu vermeiden."

DBM_CORE_MOD_AVAILABLE				= "Das Mod \"%s\" ist für diesen Spielinhalt verfügbar. Du kannst es auf |HDBM:forums|h|cff3588ffdeadlybossmods.com|r oder Curse finden. Dieser Hinweis wird nur einmal angezeigt."

DBM_CORE_COMBAT_STARTED				= "Kampf gegen %s hat begonnen. Viel Glück! :)";
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "Du wurdest in den laufenden Kampf gegen %s verwickelt. Viel Glück! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "Kampf gegen %s wurde von deiner Gilde begonnen."
DBM_CORE_SCENARIO_STARTED			= "%s gestartet. Viel Glück! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	=	"Du bist dem laufenden Szenario %s beigetreten. Viel Glück! :)"
DBM_CORE_BOSS_DOWN					= "%s besiegt nach %s!"
DBM_CORE_BOSS_DOWN_I				= "%s besiegt! Das war dein %d. Sieg."
DBM_CORE_BOSS_DOWN_L				= "%s besiegt nach %s! Dein letzter Sieg hat %s gedauert und der schnellste %s. Das war dein %d. Sieg."
DBM_CORE_BOSS_DOWN_NR				= "%s besiegt nach %s! Das ist ein neuer Rekord! (Der alte Rekord war %s.) Das war dein %d. Sieg."
DBM_CORE_GUILD_BOSS_DOWN			= "%s wurde durch deine Gilde besiegt nach %s!"
DBM_CORE_SCENARIO_COMPLETE			= "%s abgeschlossen nach %s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "%s abgeschlossen! Das war dein %d. Abschluss."
DBM_CORE_SCENARIO_COMPLETE_L		= "%s abgeschlossen nach %s! Dein letzter Abschluss hat %s gedauert und der schnellste %s. Das war dein %d. Abschluss."
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s abgeschlossen nach %s! Das ist ein neuer Rekord! (Der alte Rekord war %s.) Das war dein %d. Abschluss."
DBM_CORE_COMBAT_ENDED_AT			= "Kampf gegen %s (%s) hat nach %s aufgehört."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Kampf gegen %s (%s) hat nach %s aufgehört. Das war deine %d. Niederlage auf diesem Schwierigkeitsgrad."
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "Deine Gilde war %s (%s) unterlegen nach %s."
DBM_CORE_SCENARIO_ENDED_AT			= "%s abgebrochen nach %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s abgebrochen nach %s. Das war dein %d. Abbruch auf diesem Schwierigkeitsgrad."
DBM_CORE_COMBAT_STATE_RECOVERED		= "Kampf gegen %s hat vor %s begonnen, Neukalibrierung der Timer erfolgt..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "\"Transcriptor\"-Aufzeichnung gestartet."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "\"Transcriptor\"-Aufzeichnung beendet."

DBM_CORE_MOVIE_SKIPPED				= "Eine Videosequenz wurde automatisch übersprungen."

DBM_CORE_AFK_WARNING				= "Du bist \"AFK\" und im Kampf (%d Prozent Gesundheit verbleibend), Alarmsound ausgelöst.  Entferne deine \"AFK\"-Markierung oder deaktiviere diese Alarmierung unter \"Sonstige Funktionen\", falls du nicht \"AFK\" bist."

DBM_CORE_COMBAT_STARTED_AI_TIMER	= "Meine CPU ist ein neuronaler Prozessor, ein lernender Computer. (Dieser Kampf wird die neuen KI-Funktionen zur Erzeugung von Timernäherungen verwenden.)"

DBM_CORE_PROFILE_NOT_FOUND			= "<DBM> Dein derzeitiges Profil ist korrupt. DBM wird das Profil 'Default' laden."
DBM_CORE_PROFILE_CREATED			= "Profil '%s' erzeugt."
DBM_CORE_PROFILE_CREATE_ERROR		= "Erzeugen des Profils fehlgeschlagen. Ungültiger Profilname."
DBM_CORE_PROFILE_CREATE_ERROR_D		= "Erzeugen des Profils fehlgeschlagen. Profil '%s' existiert bereits."
DBM_CORE_PROFILE_APPLIED			= "Profil '%s' angewendet."
DBM_CORE_PROFILE_APPLY_ERROR		= "Anwenden des Profils fehlgeschlagen. Profil '%s' existiert nicht."
DBM_CORE_PROFILE_COPIED				= "Profil '%s' kopiert."
DBM_CORE_PROFILE_COPY_ERROR			= "Kopieren des Profils fehlgeschlagen. Profil '%s' existiert nicht."
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "Das Profil kann nicht auf sich selbst kopiert werden."
DBM_CORE_PROFILE_DELETED			= "Profil '%s' gelöscht. Profil 'Default' wird angewendet."
DBM_CORE_PROFILE_DELETE_ERROR		= "Löschen des Profils fehlgeschlagen. Profil '%s' existiert nicht."
DBM_CORE_PROFILE_CANNOT_DELETE		= "Das Profil 'Default' kann nicht gelöscht werden."
DBM_CORE_MPROFILE_COPY_SUCCESS		= "Mod-Einstellungen von %s (Spez. %d) wurden kopiert."
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "Die Charaktereinstellungen können nicht auf sich selbst kopiert werden."
DBM_CORE_MPROFILE_COPY_S_ERROR		= "Quelle korrupt. Die Einstellungen wurden nicht oder unvollständig kopiert. Kopieren fehlgeschlagen."
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "Mod-Soundeinstellungen oder Notizen von %s (Spez. %d) wurden kopiert."
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "Die Charaktersoundeinstellungen oder Notizen können nicht auf sich selbst kopiert werden."
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "Quelle korrupt. Die Soundeinstellungen oder Notizen wurden nicht oder unvollständig kopiert. Kopieren fehlgeschlagen."
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "Mod-Einstellungen von %s (Spez. %d) wurden gelöscht."
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "Die derzeit genutzten Mod-Einstellungen können nicht gelöscht werden."
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "Quelle korrupt. Die Einstellungen wurden nicht oder unvollständig gelöscht. Löschen fehlgeschlagen."

DBM_CORE_NOTE_SHARE_SUCCESS			= "%s hat die Notiz für %s geteilt."
DBM_CORE_NOTE_SHARE_LINK			= "Hier klicken um die Notiz zu öffnen"
DBM_CORE_NOTE_SHARE_FAIL			= "%s hat versucht eine Notiz mit dir für %s zu teilen. Ein Mod für diese Fähigkeit ist jedoch nicht installiert oder nicht geladen. Falls du diese Notiz benötigst, solltest du sicherstellen, dass du das entsprechende Mod geladen hast und erneut um Teilung der Notiz bitten."

DBM_CORE_NOTEHEADER					= "Gib deine Notiz für %s hier ein. Umschließe Spielernamen mit >< für Klassenfarben. Trenne Notizen mit '/' bei Alarmen mit mehreren Notizen."
DBM_CORE_NOTEFOOTER					= "'OK' um die Änderungen zu akzeptieren, sonst 'Abbrechen'"
DBM_CORE_NOTESHAREDHEADER			= "%s hat die Notiz unten für %s geteilt. Falls du sie akzeptierst, wird deine derzeitige Notiz überschrieben."
DBM_CORE_NOTESHARED					= "Deine Notiz wurde an die Gruppe gesendet."
DBM_CORE_NOTESHAREERRORSOLO			= "Einsam? Du solltest keine Notizen mit dir selbst teilen."
DBM_CORE_NOTESHAREERRORBLANK		= "Leere Notizen können nicht geteilt werden."
DBM_CORE_NOTESHAREERRORGROUPFINDER	= "In automatischen Gruppen der Gruppensuche können keine Notizen geteilt werden."
DBM_CORE_NOTESHAREERRORALREADYOPEN	= "Die geteilte Notiz kann nicht geöffnet werden während der Notizeditor bereits geöffnet ist, damit die gerade von dir bearbeitete Notiz nicht verloren geht."

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "Standardeinstellungen für alle Mods dieser Instanz geladen."
DBM_CORE_ALLMOD_STATS_RESETED		= "Alle Mod-Statistiken wurden zurückgesetzt."
DBM_CORE_MOD_DEFAULT_LOADED			= "Standardeinstellungen für diesen Kampf geladen."

DBM_CORE_WORLDBOSS_ENGAGED			= "Kampf gegen %s wurde möglicherweise auf deinem Realm bei %s Prozent Leben begonnen. (gesendet von %s)"
DBM_CORE_WORLDBOSS_DEFEATED			= "%s wurde möglichweise auf deinem Realm besiegt. (gesendet von %s)"

DBM_CORE_TIMER_FORMAT_SECS			= "%.2f |4Sekunde:Sekunden;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4Minute:Minuten;"
DBM_CORE_TIMER_FORMAT				= "%d |4Minute:Minuten; und %.2f |4Sekunde:Sekunden;"

DBM_CORE_MIN						= "Min"
DBM_CORE_MIN_FMT					= "%d Min"
DBM_CORE_SEC						= "Sek"
DBM_CORE_SEC_FMT					= "%s Sek"

DBM_CORE_GENERIC_WARNING_OTHERS		= "und einem anderen"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "und %d anderen"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Berserker in %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Berserker"
DBM_CORE_OPTION_TIMER_BERSERK		= "Zeige Zeit bis $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Kampfbeginn"
DBM_CORE_OPTION_TIMER_COMBAT		= "Zeige Zeit bis Kampfbeginn"
DBM_CORE_OPTION_HEALTH_FRAME		= "Zeige Lebensanzeige"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "Timer"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "Allgemeine Ansagen"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "Persönliche Ansagen"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "Zielansagen"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "Rollenansagen"
DBM_CORE_OPTION_CATEGORY_SOUNDS			= "Sounds"

DBM_CORE_AUTO_RESPONDED						= "Automatisch geantwortet."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d Spieler am Leben"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s ist damit beschäftigt gegen %s zu kämpfen! (%s, %d/%d Spieler am Leben)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s hat %s besiegt!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s hat %s besiegt! Das war der %d. Sieg."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s war %s bei %s unterlegen."
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s war %s bei %s unterlegen. Das war die %d. Niederlage auf diesem Schwierigkeitsgrad."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s ist beschäftigt in %s (%d/%d Spieler am Leben)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s hat %s abgeschlossen!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s hat %s abgeschlossen! Das war der %d. Abschluss."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s hat %s abgebrochen."
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s hat %s abgebrochen. Das war der %d. Abbruch auf diesem Schwierigkeitsgrad."

DBM_CORE_VERSIONCHECK_HEADER		= "Boss Mod - Versionen"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (%s) %s"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) und %s (%s)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: Kein Boss Mod installiert."
DBM_CORE_VERSIONCHECK_FOOTER		= "%d Spieler mit DBM und %d Spieler mit BigWigs gefunden."
DBM_CORE_VERSIONCHECK_OUTDATED		= "Folgende %d Spieler haben veraltete DBM Versionen: %s"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Deine Version von Deadly Boss Mods ist veraltet! Bitte besuche http://www.deadlybossmods.com um die neueste Version herunterzuladen."
DBM_CORE_VOICE_PACK_OUTDATED		= "In deinem DBM Sprachpack fehlen möglicherweise Sounds, die von dieser Version von DBM unterstützt werden. Einige Spezialwarnungssounds werden nicht unterdrückt für gesprochene Alarme, die von deiner Sprachpackversion nicht unterstützt werden. Bitte lade dir eine neuere Version des Spachpacks herunter oder kontaktiere den Autor des Sprachpacks für ein Update, welches die fehlenden Sounddateien enthält."
DBM_CORE_VOICE_MISSING				= "Du hast einen DBM Sprachpack ausgewählt, der nicht gefunden werden konnte. Deine Auswahl wurde auf 'Kein Sprachpack' zurückgesetzt. Bitte stelle sicher, dass der Sprachpack korrekt installiert und in der Addon-Liste aktiviert wurde, falls dies ein Fehler ist."
DBM_CORE_VOICE_DISABLED				= "Du hast derzeit mindestens einen DBM Sprachpack installiert, aber keinen aktiviert. Falls du einen Sprachpack nutzen möchtest, dann wähle ihn unter \"Gesprochene Warnungen\" aus. Ansonsten kannst du die ungenutzten Sprachpacks deinstallieren, um diese Meldung zu unterdrücken."
DBM_CORE_VOICE_COUNT_MISSING		= "Für die Countdown-Stimme %d ist ein Sprach-/Zählpack ausgewählt, der nicht gefunden werden konnte. Die Stimme wurde auf die Standardeinstellung zurückgesetzt: %s."
--DBM_BIG_WIGS

DBM_CORE_UPDATEREMINDER_HEADER			= "Deine Version von Deadly Boss Mods ist veraltet.\n Version %s (r%d) ist über Curse, WoWI oder hier zum Download verfügbar:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "Deine ALPHA-Version von Deadly Boss Mods ist veraltet.\nDu liegst mindestens %d Revisionen zurück. Es wird empfohlen bei einer Entscheidung für ALPHA-Versionen immer die neueste ALPHA-Version zu nutzen. Ansonsten sollte die neueste RELEASE-Version genutzt werden. ALPHA-Versionen haben eine strengere Versionsprüfung, da diese Entwicklungsversionen von DBM sind."
DBM_CORE_UPDATEREMINDER_FOOTER			= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Downloadlink in die Zwischenablage zu kopieren."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Link in die Zwischenablage zu kopieren."
DBM_CORE_UPDATEREMINDER_DISABLE			= "WARNUNG: Da dein Deadly Boss Mods zu veraltet ist, hat es sich zwangsweise deaktiviert und kann erst nach einer Aktualisierung wieder genutzt werden. Derart alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen."
DBM_CORE_UPDATEREMINDER_HOTFIX			= "Deine Version von DBM hat bekannte Probleme während dieses Bosskampfes, die durch ein Update auf die neueste DBM-Version behoben werden können."
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= "Deine Version von DBM hat bekannte Probleme während dieses Bosskampfes, die in einer künftigen DBM-Version behoben sind (oder in der neuesten Alphaversion)."
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "WARNUNG: Da dein Deadly Boss Mods veraltet und deshalb leider für diesen Major Patch des Spiels nicht mehr geeignet ist, hat es sich bis zu einer Aktualisierung deaktiviert. Alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen. Bitte lade dir baldmöglichst eine neue Version von deadlybossmods.com oder Curse herunter."
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "WARNUNG: Du benutzt eine Version von Deadly Boss Mods die nicht für diese Version des Spiels gedacht ist. Bitte lade dir eine zum Spiel passende Version von deadlybossmods.com oder Curse herunter."
DBM_CORE_VEM							= "WARNUNG: Du benutzt Deadly Boss Mods zusammen mit Voice Encounter Mods. DBM läuft nicht in dieser Konfiguration und wird deshalb nicht geladen."
DBM_CORE_3RDPROFILES					= "WARNUNG: DBM-Profiles ist mit dieser Version von DBM nicht kompatibel. Es muss entfernt werden bevor DBM genutzt werden kann um Konflikte zu vermeiden."
DBM_CORE_DPMCORE						= "WARNUNG: Deadly Pvp Mods (DPM) wird nicht mehr gepflegt und ist mit dieser Version von DBM nicht kompatibel. Es muss entfernt werden bevor DBM genutzt werden kann um Konflikte zu vermeiden."
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "WARNUNG: Dieses Update von DBM arbeitet erst nach einem vollständigem Neustart des Spielclients korrekt. Das Update enthält neue Dateien oder Änderungen an .toc-Dateien, die nicht mit \"/reload\" geladen werden können. Die Funktionsfähigkeit von DBM kann beeinträchtigt sein und es können Fehler auftreten, bis du den Spielclient neu startest."
DBM_CORE_OUT_OF_DATE_NAG				= "Deine Version von Deadly Boss Mods ist veraltet. Du solltest eine Aktualisierung für diesen Kampf durchführen, da du sonst wichtige Warnungen oder Timer verpassen könntest oder automatische \"Schreie\" fehlen, die der Rest deines Schlachtzuges von dir erwartet."

DBM_CORE_MOVABLE_BAR				= "Zieh mich!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h hat dir einen DBM-Timer geschickt: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Diesen Timer abbrechen]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Timer von %1$s ignorieren]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Willst du wirklich DBM-Timer von %s für diese Sitzung ignorieren?"
DBM_PIZZA_ERROR_USAGE				= "Benutzung: /dbm [broadcast] timer <Sekunden> <Text>. <Sekunden> muss größer als 1 sein."

--DBM_CORE_MINIMAP_TOOLTIP_HEADER
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+Klick oder Rechtsklick zum Bewegen\nAlt+Shift+Klick zum freien Bewegen"

DBM_CORE_RANGECHECK_HEADER			= "Abstandscheck (%dm)"
DBM_CORE_RANGECHECK_SETRANGE		= "Abstand einstellen"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "Spielerschwellwert"
DBM_CORE_RANGECHECK_SOUNDS			= "Sounds"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Sound, falls ein Spieler in Reichweite ist"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Sound, falls mehr als ein Spieler in Reichweite ist"
DBM_CORE_RANGECHECK_SOUND_0			= "Kein Sound"
DBM_CORE_RANGECHECK_SOUND_1			= "Standard-Sound"
DBM_CORE_RANGECHECK_SOUND_2			= "Nerviges Piepsen"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%dm"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Fenster"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Zeige Radarfenster"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Zeige Textfenster"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Zeige beide Fenster"
DBM_CORE_RANGERADAR_HEADER			= "Abstand:%dm Spieler:%d"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d in Reichweite (%dm)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fm)"

DBM_CORE_INFOFRAME_SHOW_SELF		= "Eigene Stärke immer anzeigen" -- Always show your own power value even if you are below the threshold
DBM_CORE_INFOFRAME_SETLINES			= "Setze maximale Zeilenanzahl"
DBM_CORE_INFOFRAME_LINESDEFAULT		= "gesetzt vom Mod"
DBM_CORE_INFOFRAME_LINES_TO			= "%d Zeilen"

DBM_LFG_INVITE						= "Einladung der Gruppensuche"

DBM_CORE_SLASHCMD_HELP				= {
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
DBM_CORE_SLASHCMD_HELP2				= {
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
DBM_CORE_TIMER_USAGE	= {
	"DBM-Timer Kommandos:",
	"/dbm timer <sec> <text>: Startet einen <sec> Sekunden langen Timer mit deinem <text>.",
	"/dbm ctimer <sec> <text>: Startet einen Timer mit Countdown.",
	"/dbm ltimer <sec> <text>: Startet einen Timer, der automatisch wiederholt wird, bis er abgebrochen wird.",
	"/dbm cltimer <sec> <text>: Startet einen Timer mit Countdown, der automatisch wiederholt wird, bis er abgebrochen wird.",
	"/dbm broadcast timer/ctimer/ltimer/cltimer <sec> <text>: schickt den Timer an den Schlachtzug (nur als Leiter/Assistent).",
	"/dbm timer endloop: Stoppt alle ltimer- und cltimer-Schleifen.",
}

DBM_ERROR_NO_PERMISSION				= "Du hast nicht die benötigte Berechtigung für diesen Befehl!"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Verstecken"

--Common Locals
DBM_NEXT							= "Nächste %s"
DBM_COOLDOWN						= "%s CD"
DBM_CORE_UNKNOWN					= "unbekannt"
DBM_CORE_LEFT						= "Links"
DBM_CORE_RIGHT						= "Rechts"
DBM_CORE_BACK						= "Hinten"
DBM_CORE_MIDDLE						= "Mitte"
DBM_CORE_FRONT						= "Vorne"
DBM_CORE_INTERMISSION				= "Übergang"
DBM_CORE_ORB						= "Kugel"
DBM_CHEST							= "Kiste"
DBM_NO_DEBUFF						= "Kein %s"
DBM_ALLY							= "Verbündeten"
DBM_ADDS							= "Adds"
DBM_CORE_ROOM_EDGE					= "Rand des Raums"
DBM_CORE_SAFE						= "Sicher"
--Common Locals end

DBM_CORE_BREAK_USAGE				= "Ein Pause-Timer kann nicht länger als 60 Minuten sein. Beachte bitte, dass für Pausen-Timer die Zeit in Minuten (und nicht in Sekunden) anzugeben ist."
DBM_CORE_BREAK_START				= "Pause startet jetzt -- du hast %s! (gesendet von: %s)"
DBM_CORE_BREAK_MIN					= "Pause endet in %s Minute(n)!"
DBM_CORE_BREAK_SEC					= "Pause endet in %s Sekunden!"
DBM_CORE_TIMER_BREAK				= "Pause!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Pause ist vorbei (seit %s Uhr)"

DBM_CORE_TIMER_PULL					= "Pull in"
DBM_CORE_ANNOUNCE_PULL				= "Pull in %d Sekunden. (gesendet von: %s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull jetzt!"
DBM_CORE_ANNOUNCE_PULL_TARGET		= "Pulle %s in %d Sekunden. (gesendet von: %s)"
DBM_CORE_ANNOUNCE_PULL_NOW_TARGET	= "Pulle %s jetzt!"
DBM_CORE_GEAR_WARNING				= "Warnung: Prüfe deine Ausrüstung. Deine angelegte Gegenstandsstufe ist um %d niedriger als die in deinen Taschen."
DBM_CORE_GEAR_WARNING_WEAPON		= "Warnung: Prüfe ob du deine Waffe korrekt angelegt hast."
DBM_CORE_GEAR_FISHING_POLE			= "Angelrute"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Zeit für Erfolg"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.you		= "%s auf DIR"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target		= "%s auf >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) auf >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell		= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends 		= "%s ist beendet"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget	= "%s ist beendet: >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades		= "%s ist beendet"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds		= "%s verbleibend: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast		= "Wirkt %s: %.1f Sek"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon		= "%s bald"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%s in %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase		= "Phase %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase	= "Phase %s bald"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count		= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack		= "%s auf >%%s< (%%d)"

local prewarnOption = "Zeige Vorwarnung für $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.you			= "Verkünde, wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Verkünde Ziele von $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Verkünde Ziele von $spell:%s (mit Zählung)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Zeige Warnung für $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends		= "Zeige Warnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget	= "Zeige Warnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Zeige Warnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds		= "Verkünde die Anzahl der verbleibenden $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast		= "Zeige Warnung, wenn $spell:%s gewirkt wird"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 	= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "Verkünde Phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phasechange	= "Verkünde Phasenwechsel"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase	= "Zeige Vorwarnung für Phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Zeige Warnung für $spell:%s (mit Zählung)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Verkünde $spell:%s Stapel"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends				= "%s beendet"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s beendet"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "%s bald"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s in %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel			= "%s auf >%%s< - jetzt reinigen"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - unterbrich >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - unterbrich >%%s<! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you				= "%s auf dir"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) auf dir"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youpos			= "%s (Position: %%s) auf dir"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Soak Position: %%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target			= "%s auf >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) auf >%%s< "
DBM_CORE_AUTO_SPEC_WARN_TEXTS.defensive			= "%s - Defensivfähigkeiten"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= "%s auf >%%s< - jetzt spotten"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close				= "%s auf >%%s< in deiner Nähe"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move				= "%s - geh weg"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge				= "%s - Angriff ausweichen"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - geh weg von anderen"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - geh zu >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.jump				= "%s - spring"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run				= "%s - lauf weg"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast				= "%s - stoppe Zauber"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect			= "%s auf >%%s< - stoppe Angriffe"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count				= "%s! (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack				= "%%d Stapel von %s auf dir"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch			= "%s - Ziel wechseln"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - Ziel wechseln (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.gtfo				= "Schlechtes unter dir - lauf raus"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.Adds				= "Adds kommen - Ziel wechseln"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 			= "Spezialwarnung für $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 			= "Spezialwarnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 			= "Spezialwarnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 			= "Spezialvorwarnung für $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Spezialvorwarnung %s Sekunden vor $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 			= "Spezialwarnung zum Reinigen/Rauben von $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt		= "Spezialwarnung zum Unterbrechen von $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Spezialwarnung (mit Zählung) zum Unterbrechen von $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 			= "Spezialwarnung, wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youcount		= "Spezialwarnung (mit Zählung), wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youpos			= "Spezialwarnung (mit Position), wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soakpos			= "Spezialwarnung (mit Position) zur Schadensteilung mit von $spell:%s Betroffenen"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 			= "Spezialwarnung, wenn jemand von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Spezialwarnung (mit Zählung), wenn jemand von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.defensive 		= "Spezialwarnung zur Nutzung von Defensivfähigkeiten bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 			= "Spezialwarnung zum Spotten, wenn der andere Tank von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 			= "Spezialwarnung, wenn jemand in deiner Nähe von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 			= "Spezialwarnung zum Herausgehen aus $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 			= "Spezialwarnung zum Ausweichen bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway		= "Spezialwarnung zum Weggehen von anderen bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto			= "Spezialwarnung zum Hingehen zu jemand oder zu einem Ort bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.jump			= "Spezialwarnung zum Springen bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 			= "Spezialwarnung zum Weglaufen vor $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 			= "Spezialwarnung zum Zauberstopp bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 		= "Spezialwarnung zum Angriffsstopp auf $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 			= "Spezialwarnung für $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 			= "Spezialwarnung bei >=%d Stapel von $spell:%s auf dir"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch			= "Spezialwarnung für Zielwechsel auf $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount		= "Spezialwarnung (mit Zählung) für Zielwechsel auf $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Spezialwarnung zum Rauslaufen aus schlechten Dingen auf dem Boden"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.Adds			= "Spezialwarnung für Zielwechsel auf ankommende Adds"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.cast		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s endet"--Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades		= "%s schwindet"--Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.ai			= "%s KI"
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "%s CD"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "%s CD (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource	= "%s CD: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial	= "Spezialfähigkeit CD"
DBM_CORE_AUTO_TIMER_TEXTS.next		= "Nächster %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount	= "Nächster %s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Nächster %s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial	= "Nächste Spezialfähigkeit"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.phase		= "Nächste Phase"
DBM_CORE_AUTO_TIMER_TEXTS.adds		= "Nächste Adds"
--DBM_CORE_AUTO_TIMER_TEXTS.roleplay

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Dauer des Debuffs $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Wirkzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.castsource	= "Wirkzeit von $spell:%s anzeigen (mit Quelle)"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Dauer von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Zeit bis $spell:%s von Spielern schwindet anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.ai			= "KI-Timer für die Abklingzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "Abklingzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Abklingzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Abklingzeit von $spell:%s anzeigen (mit Quelle)"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial	= "Abklingzeit für Spezialfähigkeit anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Zeit bis nächstes $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Zeit bis nächstes $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Zeit bis nächstes $spell:%s anzeigen (mit Quelle)"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial	= "Zeige Zeit bis nächste Spezialfähigkeit"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Zeit für %s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.phase		= "Zeige Zeit bis nächste Phase"
DBM_CORE_AUTO_TIMER_OPTIONS.adds		= "Zeige Zeit bis Adds erscheinen"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay	= "Dauer des Rollenspiels anzeigen"


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Setze Zeichen auf Ziele von $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Setze Zeichen auf $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "Zeige DBM-Pfeil zum Hingehen zum von $spell:%s betroffenen Ziel"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "Zeige DBM-Pfeil zum Weggehen vom von $spell:%s betroffenen Ziel"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "Zeige DBM-Pfeil zum Hingehen zum richtigen Ort für $spell:%s"
DBM_CORE_AUTO_VOICE_OPTION_TEXT			= "Spiele gesprochene Warnungen für $spell:%s"
DBM_CORE_AUTO_VOICE2_OPTION_TEXT		= "Spiele gesprochene Warnungen für Phasenwechsel"
DBM_CORE_AUTO_VOICE3_OPTION_TEXT		= "Spiele gesprochene Warnungen für ankommende Adds"
DBM_CORE_AUTO_VOICE4_OPTION_TEXT		= "Spiele gesprochene Warnungen für schlechte Dinge auf dem Boden"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Spiele akustischen Countdown bis $spell:%s gewirkt wird"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "Spiele akustischen Countdown bis $spell:%s schwindet"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Zähle akustisch die Dauer von $spell:%s"

DBM_CORE_AUTO_YELL_OPTION_TEXT.shortyell	= "Schreie, wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yell			= "Schreie (mit Spielernamen), wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_YELL_OPTION_TEXT.count		= "Schreie (mit Zählung), wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_YELL_OPTION_TEXT.fade			= "Schreie (mit Countdown und Zaubernamen), wenn $spell:%s endet"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortfade	= "Schreie (mit Countdown), wenn $spell:%s endet"
DBM_CORE_AUTO_YELL_OPTION_TEXT.position		= "Schreie (mit Position), wenn du von $spell:%s betroffen bist"

DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell		= "%s auf " .. UnitName("player") .. "!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.count		= "%s auf " .. UnitName("player") .. "! (%%d)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.fade		= "%s endet in %%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.position	= "%s %%s auf {rt%%d}"..UnitName("player").."{rt%%d}"

--DBM_CORE_AUTO_YELL_CUSTOM_POSITION
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "Zeige HudMap für $spell:%s (außer Betrieb)"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "Zeige HudMap für diverse Mechaniken (außer Betrieb)"
DBM_CORE_AUTO_NAMEPLATE_OPTION_TEXT		= "Zeige Namensplakettenaura für $spell:%s"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Zeige Abstandsfenster (%sm) für $spell:%s"
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Zeige Abstandsfenster (%sm)"
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "Zeige inverses Abstandsfenster (%sm) für $spell:%s"
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "Zeige inverses Abstandsfenster (%sm)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Zeige Infofenster für $spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Boss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "bewegbare Schlachtzugwarnung"
DBM_CORE_MOVE_WARNING_MESSAGE		= "Danke, dass du Deadly Boss Mods verwendest"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "bewegbare Spezialwarnung"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Spezialwarnung"

DBM_CORE_HUD_INVALID_TYPE			= "Der angegebene Typ für die HudMap ist ungültig."
DBM_CORE_HUD_INVALID_TARGET			= "Es wurde kein gültiges Ziel für die HudMap angegeben."
DBM_CORE_HUD_INVALID_SELF			= "Die HudMap kann nicht auf dich selbst zeigen."
DBM_CORE_HUD_INVALID_ICON			= "Der Typ 'icon' für die HudMap kann nicht auf Ziele ohne gesetztem Schlachtzugzeichen angewendet werden."
DBM_CORE_HUD_SUCCESS				= "Die HudMap wurde erfolgreich mit deinen Parametern gestartet. Sie läuft nach %s aus oder zuvor durch Aufruf von '/dbm hud hide'."
DBM_CORE_HUD_USAGE	= {
	"Benutzung der DBM-HudMap:",
	"-----------------",
	"/dbm hud <Typ> <Ziel> <Dauer>: Erzeugt eine HudMap, die für die gewünschte Dauer auf einen Spieler zeigt",
	"gültige Typen: arrow, dot, red, blue, green, yellow, icon (benötigt ein Ziel mit gesetztem Schlachtzugzeichen)",
	"gültige Ziele: target, focus, <Spielername>",
	"gültige Dauer: beliebige Zahl (in Sekunden). 20 Minuten, falls Dauer nicht angegeben.",
	"/dbm hud hide: Deaktiviert und versteckt die HudMap"
}

DBM_ARROW_MOVABLE					= "Pfeil (bewegbar)"
DBM_ARROW_WAY_USAGE					= "/dway <x> <y>: Erzeugt einen Pfeil, der auf einen bestimmten Ort zeigt (benutzt lokale Kartenkoordinaten der Zone)"
DBM_ARROW_WAY_SUCCESS				= "Um den Pfeil zu verstecken '/dbm arrow hide' eingeben oder das Pfeilziel erreichen"
DBM_ARROW_ERROR_USAGE	= {
	"Benutzung des DBM-Pfeils:",
	"-----------------",
	"/dbm arrow <x> <y>: Erzeugt einen Pfeil, der auf einen bestimmten Ort zeigt (benutzt Weltkoordinaten)",
	"/dbm arrow map <x> <y>: Erzeugt einen Pfeil, der auf einen bestimmten Ort zeigt (benutzt Kartenkoordinaten der Zone)",
	"/dbm arrow <player>: Erzeugt einen Pfeil, der auf einen bestimmten Spieler in deiner Gruppe oder deinem Schlachtzug zeigt (unterscheidet Groß-/Kleinschreibung)",
	"/dbm arrow hide: Versteckt den Pfeil",
	"/dbm arrow move: Macht den Pfeil beweglich"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Rekordzeit"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Abschlussbestzeit"
DBM_COMBAT_RES_TIMER_TEXT	= "Kampfbelebung +"
DBM_CORE_TIMER_RESPAWN		= "%s Wiedererscheinen"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s möchte deine aktuellen Instanzsperren (IDs) einsehen.\n Möchtest Du diese Informationen an %s senden? Dieser Spieler wird in der Lage sein, diese Informationen während deiner aktuellen Sitzung abzufragen (also bis du dich neu einloggst)."
DBM_ERROR_NO_RAID					= "Du musst dich in einem Schlachtzug befinden um dieses Feature nutzen zu können."
DBM_INSTANCE_INFO_REQUESTED			= "Frage den gesamten Schlachtzug nach Instanzsperren (IDs) ab.\nBitte beachte, dass die Spieler nach ihrer Erlaubnis gefragt werden, bevor die Daten an dich gesendet werden. Bis zum Erhalt aller Antworten kann also einige Zeit vergehen."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Antworten von %d Spielern von %d DBM-Nutzern erhalten: %d sendeten Daten, %d haben die Anfrage abgelehnt. Warte %d weitere Sekunden auf Antworten..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Antworten von allen Mitgliedern des Schlachtzuges erhalten"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"  -- debug message not translated by intention
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, Schwierigkeitsgrad %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, Fortschritt %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    Fortschritt %d: %s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "In deiner Schlachtzuggruppe sind keine Informationen über Instanzsperren vorhanden."
DBM_INSTANCE_INFO_STATS_DENIED		= "Anfrage abgelehnt: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Abwesend: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Keine aktuelle DBM-Version installiert: %s"
DBM_INSTANCE_INFO_RESULTS			= "Ergebnis des Instanzsperren-Scans (IDs). Bitte beachte, dass Instanzen mehrmals angezeigt werden, wenn sich Spieler mit anderssprachigen WoW-Klienten im Schlachtzug befinden."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Spieler die noch nicht geantwortet haben: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Ergebnisse jetzt anzeigen]|r|h"

DBM_CORE_LAG_CHECKING				= "Prüfe Schlachtzuglatenz..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Latenzergebnisse"
DBM_CORE_LAG_ENTRY					= "%s: %dms (Welt) / %dms (Standort)"
DBM_CORE_LAG_FOOTER					= "Keine Antwort: %s"

DBM_CORE_DUR_CHECKING				= "Prüfe Schlachtzughaltbarkeit..."
DBM_CORE_DUR_HEADER					= "Deadly Boss Mods - Haltbarkeitergebnisse"
DBM_CORE_DUR_ENTRY					= "%s: Haltbarkeit [%d Prozent] / Ausrüstung defekt [%s]"
DBM_CORE_LAG_FOOTER					= "Keine Antwort: %s"

--Role Icons
--DBM_CORE_TANK_ICON
--DBM_CORE_HEALER_ICON
--DBM_CORE_DAMAGE_ICON
--Importance Icons
--DBM_CORE_HEROIC_ICON
--DBM_CORE_DEADLY_ICON
--DBM_CORE_IMPORTANT_ICON
--Type Icons
--DBM_CORE_INTERRUPT_ICON
--DBM_CORE_MAGIC_ICON
--DBM_CORE_POISON_ICON
--DBM_CORE_DISEASE_ICON
--DBM_CORE_CURSE_ICON
--DBM_CORE_ENRAGE_ICON
