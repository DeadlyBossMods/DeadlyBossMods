if GetLocale() ~= "deDE" then return end

DBM_CORE_NEED_SUPPORT				= "Hey, bist du ein Programmierer oder gut in Fremdsprachen? Falls ja, benötigt DBM deine Hilfe, um in mehr Sprachen übersetzt zu werden. Hilf uns hier http://forums.elitistjerks.com/topic/132449-dbm-localizers-needed/"
DBM_CORE_NEED_LOGS					= "DBM benötigt Transcriptor (http://www.wowace.com/addons/transcriptor/) Logs dieser Testkämpfe um möglichst gute Mods bereitstellen zu können. Falls du helfen willst, dann zeichne diese Testkämpfe mit Transcriptor auf und lade sie hier hoch: http://forums.elitistjerks.com/topic/132677-deadly-boss-mods-60-testing/ (bitte vorher einzippen, die Logs können sonst sehr groß werden). Es werden nur Logs von 6.0 Schlachtzügen benötigt. Logs von Dungeons sind nicht erforderlich."
DBM_HOW_TO_USE_MOD					= "Willkommen bei DBM. Tippe /dbm help für eine Liste unterstützter Kommandos. Für den Zugriff auf Einstellungen tippe /dbm in den Chat um die Konfiguration zu beginnen. Lade gewünschte Zonen manuell um jegliche Boss-spezifische Einstellungen nach deinen Wünschen zu konfigurieren. DBM versucht dies für dich zu tun, indem es beim ersten Start deine Spezialisierung scannt, aber du kannst zusätzliche Einstellungen aktivieren."

DBM_FORUMS_MESSAGE					= "Du hast einen Bug oder einen falschen Timer gefunden? Du glaubst einige Mods würden zusätzliche Warnungen, Timer oder Spezialfeatures benötigen?\nBesuche die neuen Deadly Boss Mods Foren für Diskussionen, Fehlermeldungen und Featurewünsche: |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (Du kannst auf den Link klicken um ihn zu kopieren.)"
DBM_FORUMS_COPY_URL_DIALOG			= "Besuche unsere neuen Diskussions- und Support-Foren\r\n(gehostet von Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "Fehler beim Laden der Boss Mods für %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Boss Mods für '%s' geladen. Für weitere Einstellungen /dbm oder /dbm help im Chatfenster eingeben!"
DBM_CORE_LOAD_MOD_COMBAT			= "Laden von '%s' verzögert bis du den Kampf verlässt."
DBM_CORE_LOAD_GUI_ERROR				= "Konnte die grafische Benutzeroberfläche nicht laden: %s."
DBM_CORE_LOAD_GUI_COMBAT			= "Die grafische Benutzeroberfläche kann nicht im Kampf geladen werden. Zur Vornahme von Einstellungen bitte diese zunächst außerhalb des Kampfes laden. Danach steht sie auch im Kampf zur Verfügung."
DBM_CORE_LOAD_SKIN_COMBAT			= "Das Design der DBM-Timer konnte nicht im Kampf gesetzt werden. Die Timer werden vermutlich nicht korrekt funktionieren und diverse LUA-Fehler generieren. Dies wird oft durch Mods anderer Hersteller verursacht, die versuchen Designänderungen im Kampf vorzunehmen. Du solltest nach dem Kampfende /reload ausführen."
DBM_CORE_BAD_LOAD					= "Dein Boss Mod für diese Instanz konnte nicht vollständig korrekt im Kampf geladen werden. Bitte führe baldmöglichst nach Kampfende /reload aus."

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM hat das dynamische Abstandsfenster für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, auf wieviel versammelte Spieler bei deiner Gruppengröße geprüft werden muss."
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM hat Warnungen bezüglich der Anzahl der Gegner für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, wieviel Gegner bei deiner Gruppengröße erscheinen."
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM hat mehrere Funktionalitäten für diesen Kampf deaktiviert, da für deine Gruppengröße nicht genügend Informationen über bestimmte Kampfmechaniken vorliegen."

DBM_CORE_LOOT_SPEC_REMINDER			= "Deine aktuelle Spezialisierung ist %s. Deine aktuelle Beutespezialisierung ist %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM hat festgestellt, dass du das Setzen von Schlachtzugzeichen in \"BigWigs\" und in \"DBM\" aktiviert hast. Bitte deaktiviere das Setzen von Zeichen in einem der beiden Addons um Konflikte zu vermeiden."

DBM_CORE_PROVINGGROUNDS_AD			= "Das Mod \"DBM-ProvingGrounds\" ist für diesen Spielinhalt verfügbar. Du kannst es auf deadlybossmods.com oder Curse finden. Dieser Hinweis wird nur einmal angezeigt."

DBM_CORE_COMBAT_STARTED				= "Kampf gegen %s hat begonnen. Viel Glück! :)";
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "Du wurdest in den laufenden Kampf gegen %s verwickelt. Viel Glück! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "Kampf gegen %s wurde von deiner Gilde begonnen."
DBM_CORE_SCENARIO_STARTED			= "%s gestartet. Viel Glück! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	=	"Du bist dem laufenden %s beigetreten. Viel Glück! :)"
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

DBM_CORE_WORLDBOSS_ENGAGED			= "Kampf gegen %s wurde möglicherweise auf deinem Realm bei %s Prozent Leben begonnen. (gesendet von %s)"
DBM_CORE_WORLDBOSS_DEFEATED			= "%s wurde möglichweise auf deinem Realm besiegt. (gesendet von %s)"

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4Sekunde:Sekunden;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4Minute:Minuten;"
DBM_CORE_TIMER_FORMAT				= "%d |4Minute:Minuten; und %d |4Sekunde:Sekunden;"

DBM_CORE_MIN						= "Min"
DBM_CORE_MIN_FMT					= "%d Min"
DBM_CORE_SEC						= "Sek"
DBM_CORE_SEC_FMT					= "%d Sek"

DBM_CORE_GENERIC_WARNING_OTHERS		= "und einem anderen"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "und %d anderen"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Berserker in %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Berserker"
DBM_CORE_OPTION_TIMER_BERSERK		= "Zeige Zeit bis $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Kampfbeginn"
DBM_CORE_OPTION_TIMER_COMBAT		= "Zeige Zeit bis Kampfbeginn"
DBM_CORE_OPTION_HEALTH_FRAME		= "Zeige Lebensanzeige"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Timer"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Ansagen"

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
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) und %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: Kein Boss Mod installiert."
DBM_CORE_VERSIONCHECK_FOOTER		= "%d Spieler mit DBM und %d Spieler mit BigWigs gefunden."
DBM_CORE_YOUR_VERSION_OUTDATED      = "Deine Version von Deadly Boss Mods ist veraltet! Bitte besuche http://www.deadlybossmods.com um die neueste Version herunterzuladen."
DBM_CORE_OUTDATED_PVP_MODS			= "Deine PvP-Mods von DBM sind veraltet. Die PvP-Mods sind nicht mehr im \"DBM-Core\"-Download enthalten. Die aktuellsten PvP-Mods findest du unter http://www.deadlybossmods.com als separaten Download. Bitte lösche den Ordner \"DBM-PvP\" (unterhalb des Ordners \"...\\Interface\\AddOns\"), falls du die PvP-Mods nicht benutzt."
--DBM_BIG_WIGS
--DBM_BIG_WIGS_ALPHA

DBM_CORE_UPDATEREMINDER_HEADER			= "Deine Version von Deadly Boss Mods ist veraltet.\n Version %s (r%d) ist hier zum Download verfügbar:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "Deine Alphaversion von Deadly Boss Mods ist veraltet.\nDu liegst mindestens %d Revisionen zurück. Es wird empfohlen, die neueste Alphaversion oder neueste stabile Version von DBM zu benutzen. Die Funktionalität veralteter Alphaversionen kann schlecht oder unvollständig sein."
DBM_CORE_UPDATEREMINDER_FOOTER			= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Downloadlink in die Zwischenablage zu kopieren."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Link in die Zwischenablage zu kopieren."
DBM_CORE_UPDATEREMINDER_DISABLE			= "WARNUNG: Da dein Deadly Boss Mods extrem veraltet ist (mindestens %d Revisionen), hat es sich bis zu einer Aktualisierung deaktiviert. Derart alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen."
DBM_CORE_UPDATEREMINDER_HOTFIX			= "Deine Version von DBM wird für diesen Bosskampf falsche Timer und Warnungen anzeigen. Dies wurde in einer neueren Version von DBM korrigiert (oder in einer Alphaversion, falls eine neuere Releaseversion noch nicht verfügbar ist)."
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "WARNUNG: Da dein Deadly Boss Mods veraltet und deshalb leider für diesen Major Patch des Spiels nicht mehr geeignet ist, hat es sich bis zu einer Aktualisierung deaktiviert. Alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen. Bitte lade dir baldmöglichst eine neue Version von deadlybossmods.com oder Curse herunter. Falls du diese Meldung auf einem 6.0 beta Testserver bekommst, dann lade dir die Beta-Version des Mods hier herunter: http://forums.elitistjerks.com/topic/132677-deadly-boss-mods-60-testing"
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "WARNUNG: Du benutzt eine Version von Deadly Boss Mods die nicht für diese Version des Spiels gedacht ist. Bitte lade dir eine zum Spiel passende Version von deadlybossmods.com oder Curse herunter."

DBM_CORE_MOVABLE_BAR				= "Zieh mich!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h hat dir einen DBM-Timer geschickt: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Diesen Timer abbrechen]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Timer von %1$s ignorieren]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Willst du wirklich DBM-Timer von %s für diese Sitzung ignorieren?"
DBM_PIZZA_ERROR_USAGE				= "Benutzung: /dbm [broadcast] timer <Sekunden> <Text>. <Sekunden> muss größer als 1 sein."

--DBM_CORE_MINIMAP_TOOLTIP_HEADER
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+Klick oder Rechtsklick zum Bewegen\nAlt+Shift+Klick zum freien Bewegen"

DBM_CORE_RANGECHECK_HEADER			= "Abstandscheck (%dm)"
DBM_CORE_RANGECHECK_SETRANGE		= "Abstand einstellen"
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
DBM_CORE_RANGERADAR_HEADER			= "Abstandsradar (%dm)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d Spieler in Reichweite"

DBM_CORE_INFOFRAME_SHOW_SELF		= "Eigene Stärke immer anzeigen" -- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Einladung der Gruppensuche"

DBM_CORE_SLASHCMD_HELP				= {
	"Verfügbare Slash-Kommandos:",
	"/dbm version: Prüft die Version im gesamten Schlachtzug (Alias: ver).",
--	"/dbm version2: Prüft die Version im gesamten Schlachtzug und flüstert Mitglieder mit veralteten Versionen an (Alias: ver2).",
	"/dbm unlock: Zeigt einen bewegbaren Timer an (alias: move).",
	"/dbm timer/ctimer/ltimer/cltimer <x> <text>: Startet einen <x> Sekunden langen DBM-Timer mit dem Namen <text>. Unter http://tinyurl.com/kwsfl59 gibt es Erläuterungen zu jedem Timertyp.",
	"/dbm broadcast timer/ctimer/ltimer/cltimer <x> <text>: Schickt einen <x> Sekunden langen DBM-Timer mit dem Namen <text> an den Schlachtzug (nur als Leiter/Assistent).",
	"/dbm timer endloop: Stoppt alle ltimer- und cltimer-Schleifen.",
	"/dbm break <min>: Startet einen Pause-Timer für <min> Minuten. Schickt allen Schlachzugsmitgliedern mit DBM einen Pause-Timer (nur als Leiter/Assistent).",
	"/dbm pull <sec>: Startet einen Pull-Timer für <sec> Sekunden. Schickt allen Schlachzugsmitgliedern mit DBM einen Pull-Timer (nur als Leiter/Assistent).",
	"/dbm arrow: Zeigt den DBM-Pfeil, siehe /dbm arrow help für Details.",
	"/dbm lockout: Fragt die Schlachtzugsmitglieder nach ihren derzeitigen Instanzsperren (IDs) (nur als Leiter/Assistent).",
	"/dbm lag: Prüft die Latenz im gesamten Schlachtzug.",
	"/dbm help: Zeigt diese Hilfe."
}

DBM_ERROR_NO_PERMISSION				= "Du hast nicht die benötigte Berechtigung für diesen Befehl!"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Verstecken"

DBM_CORE_UNKNOWN					= "unbekannt"
DBM_CORE_LEFT						= "Links"
DBM_CORE_RIGHT						= "Rechts"
DBM_CORE_BACK						= "Hinten"
DBM_CORE_FRONT						= "Vorne"

DBM_CORE_BREAK_START				= "Pause startet jetzt -- du hast %s Minute(n)! (gesendet von: %s)"
DBM_CORE_BREAK_MIN					= "Pause endet in %s Minute(n)!"
DBM_CORE_BREAK_SEC					= "Pause endet in %s Sekunden!"
DBM_CORE_TIMER_BREAK				= "Pause!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Pause ist vorbei"

DBM_CORE_TIMER_PULL					= "Pull in"
DBM_CORE_ANNOUNCE_PULL				= "Pull in %d Sekunden. (gesendet von: %s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull jetzt!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Zeit für Erfolg"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target		= "%s auf >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d) auf >%%s<"
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
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count		= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack		= "%s auf >%%s< (%%d)"

local prewarnOption = "Zeige Vorwarnung für $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Verkünde Ziele von $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Verkünde Ziele von $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Zeige Warnung für $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends		= "Zeige Warnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget	= "Zeige Warnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Zeige Warnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds		= "Verkünde die Anzahl der verbleibenden $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast		= "Zeige Warnung, wenn $spell:%s gewirkt wird"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 	= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "Verkünde Phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase	= "Zeige Vorwarnung für Phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Zeige Warnung für $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Verkünde $spell:%s Stapel"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends		= "%s beendet"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades		= "%s beendet"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon		= "%s bald"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn		= "%s in %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel		= "%s auf >%%s< - jetzt reinigen"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - unterbreche >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you			= "%s auf dir"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target		= "%s auf >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt			= "%s auf >%%s< - jetzt spotten"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close		= "%s auf >%%s< in deiner Nähe"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move		= "%s - geh weg"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway	= "%s - geh weg von anderen"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto		= "%s - geh zu >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run			= "%s - lauf weg"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast		= "%s - stoppe Zauber"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect		= "%s auf >%%s< - stoppe Angriffe"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count		= "%s! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack		= "%%d Stapel von %s auf dir"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch		= ">%s< - Ziel wechseln"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Spezialwarnung für $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 		= "Spezialwarnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 		= "Spezialwarnung, wenn $spell:%s beendet ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 		= "Spezialvorwarnung für $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 	= "Spezialvorwarnung %d Sekunden vor $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Spezialwarnung zum Reinigen/Rauben von $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Spezialwarnung zum Unterbrechen von $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Spezialwarnung, wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Spezialwarnung, wenn jemand von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 		= "Spezialwarnung zum Spotten, wenn der andere Tank von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Spezialwarnung, wenn jemand in deiner Nähe von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Spezialwarnung zum Herausgehen aus $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway	= "Spezialwarnung zum Weggehen von anderen bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto		= "Spezialwarnung zum Hingehen zu jemand, der von $spell:%s betroffen ist"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Spezialwarnung zum Weglaufen vor $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Spezialwarnung zum Zauberstopp bei $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 	= "Spezialwarnung zum Angriffsstopp auf $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 		= "Spezialwarnung für $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Spezialwarnung bei >=%d Stapel von $spell:%s auf dir"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "Spezialwarnung für Zielwechsel auf $spell:%s"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s endet"--Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades		= "%s schwindet"--Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "%s CD"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "%s CD (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource	= "%s CD: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next		= "Nächster %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount	= "Nächster %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Nächster %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Dauer des Debuffs $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Wirkzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Dauer von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Zeit bis $spell:%s von Spielern schwindet anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "Abklingzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Abklingzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Abklingzeit von $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Zeit bis nächstes $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Zeit bis nächstes $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Zeit bis nächstes $spell:%s anzeigen"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Zeit für %s anzeigen"


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Setze Zeichen auf Ziele von $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Setze Zeichen auf $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "Zeige DBM-Pfeil zum Hingehen zum von $spell:%s betroffenen Ziel"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "Zeige DBM-Pfeil zum Weggehen vom von $spell:%s betroffenen Ziel"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "Spiele \"Lauf weg!\"-Sound für $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Spiele akustischen Countdown bis $spell:%s gewirkt wird"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "Spiele akustischen Countdown bis $spell:%s schwindet"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Zähle akustisch die Dauer von $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "Schreie, wenn du von $spell:%s betroffen bist"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "%s auf " .. UnitName("player") .. "!"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Zeige Abstandsfenster (%sm) für $spell:%s"
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Zeige Abstandsfenster (%sm)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Zeige Infofenster für $spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Boss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"

-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "bewegbare Spezialwarnung"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Spezialwarnung"

DBM_ARROW_MOVABLE					= "Pfeil (bewegbar)"
DBM_ARROW_ERROR_USAGE	= {
	"Benutzung des DBM-Pfeils:",
	"/dbm arrow <x> <y>  erzeugt einen Pfeil, der auf bestimmte Koordinaten zeigt (0 < x/y < 100)",
	"/dbm arrow <player>  erzeugt einen Pfeil, der auf einen bestimmten Spieler in deiner Gruppe oder deinem Schlachtzug zeigt",
	"/dbm arrow hide  versteckt den Pfeil",
	"/dbm arrow move  macht den Pfeil beweglich"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Rekordzeit"
DBM_SPEED_KILL_TIMER_OPTION	= "Zeige einen Timer zur Verbesserung deiner Rekordzeit"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Abschlussbestzeit"
DBM_COMBAT_RES_TIMER_TEXT	= "Kampfbelebung +"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s möchte deine aktuellen Instanzsperren (IDs) einsehen.\n Möchtest Du diese Informationen an %s senden? Dieser Spieler wird in der Lage sein, diese Informationen während deiner aktuellen Sitzung abzufragen (also bis du dich neu einloggst)."
DBM_ERROR_NO_RAID					= "Du musst dich in einem Schlachtzug befinden um dieses Feature nutzen zu können."
DBM_INSTANCE_INFO_REQUESTED			= "Frage den gesamten Schlachtzug nach Instanzsperren (IDs) ab.\nBitte beachte, dass die Spieler nach ihrer Erlaubnis gefragt werden, bevor die Daten an dich gesendet werden. Bis zum Erhalt aller Antworten kann also einige Zeit vergehen."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Antworten von %d Spielern von %d DBM-Nutzern erhalten: %d sendeten Daten, %d haben die Anfrage abgelehnt. Warte %d weitere Sekunden auf Antworten..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Antworten von allen Mitgliedern des Schlachtzuges erhalten"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"  -- debug message not translated by intention
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s (%d), Schwierigkeitsgrad %d:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, Fortschritt %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Anfrage abgelehnt: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Abwesend: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Keine aktuelle DBM-Version installiert: %s"
DBM_INSTANCE_INFO_RESULTS			= "Ergebnis des Instanzsperren-Scans (IDs). Bitte beachte, dass Instanzen mehrmals angezeigt werden, wenn sich Spieler mit anderssprachigen WoW-Klienten im Schlachtzug befinden."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Spieler die noch nicht geantwortet haben: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Ergebnisse jetzt anzeigen]|r|h"

DBM_CORE_LAG_CHECKING				= "Prüfe Schlachtzuglatenz..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Latenzergebnisse"
DBM_CORE_LAG_ENTRY					= "%s: %dms (Welt) / %dms (Standort)"
DBM_CORE_LAG_FOOTER					= "Keine Antwort: %s"
