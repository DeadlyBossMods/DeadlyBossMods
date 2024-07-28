if GetLocale() ~= "deDE" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD			= "Willkommen bei "..L.DBM..". Tippe /dbm help für eine Liste unterstützter Kommandos. Für den Zugriff auf Einstellungen tippe /dbm in den Chat um die Konfiguration zu beginnen. Lade gewünschte Zonen manuell um jegliche Boss-spezifische Einstellungen nach deinen Wünschen zu konfigurieren. "..L.DBM.." setzt Standardeinstellungen für deine Spezialisierung, die du aber noch genauer anpassen kannst."
L.SILENT_REMINDER			= "Erinnerung: "..L.DBM.." befindet sich noch im Lautlos-Modus."
L.NEWS_UPDATE				= "|h|c11ff1111News|r|h: This update changes mod structure around so classic and mainline now use unified (same) modules. This means that Vanilla, TBC, Wrath, and Cata modules are now installed separately using same packages as retail. Read more about it |Hgarrmission:DBM:news|h|cff3588ff[here]|r|h"--UPDATE ME
L.COPY_URL_DIALOG_NEWS		= "Die aktuellsten Meldungen findest du immer unter dem unten stehenden Link"

L.LOAD_MOD_ERROR			= "Fehler beim Laden der Boss Mods für %s: %s"
L.LOAD_MOD_SUCCESS			= "Boss Mods für '%s' geladen. Für weitere Einstellungen wie benutzerdefinierte Sounds und individuelle Warnnotizen /dbm eingeben."
L.LOAD_MOD_COMBAT			= "Laden von '%s' verzögert bis du den Kampf verlässt."
L.LOAD_GUI_ERROR			= "Konnte die grafische Benutzeroberfläche nicht laden: %s."
L.LOAD_GUI_COMBAT			= "Die grafische Benutzeroberfläche kann nicht im Kampf geladen werden. Zur Vornahme von Einstellungen bitte diese zunächst außerhalb des Kampfes laden. Danach steht sie auch im Kampf zur Verfügung."
L.BAD_LOAD					= "Dein Boss Mod für diese Instanz konnte nicht vollständig korrekt im Kampf geladen werden. Bitte führe baldmöglichst nach Kampfende /reload aus."
L.LOAD_MOD_VER_MISMATCH		= "%s kann nicht geladen werden, da dein DBM-Core die Voraussetzungen nicht erfüllt. Es wird eine aktualisierte Version benötigt."
L.LOAD_MOD_EXP_MISMATCH		= "%s kann nicht geladen werden, da es für eine WoW Erweiterung entwickelt wurde, die derzeit nicht verfügbar ist. Mit Verfügbarkeit der neuen Erweiterung wird dieses Mod automatisch funktionieren."
L.LOAD_MOD_TOC_MISMATCH		= "%s konnte nicht geladen werden das es für einen WoW Patch (%s) designt wurde der aktuell nicht verfügbar ist. Wenn das Update verfügbar ist funktioniert dieser Mod automatisch."
L.LOAD_MOD_DISABLED			= "%s ist installiert, aber derzeit nicht aktiviert. Dieses Mod wird nicht geladen, falls du es nicht aktivierst."
L.LOAD_MOD_DISABLED_PLURAL	= "%s sind installiert, aber derzeit nicht aktiviert. Diese Mods werden nicht geladen, falls du sie nicht aktivierst."

L.COPY_URL_DIALOG					= "Kopiere URL"
--L.COPY_WA_DIALOG						= "Copy WA Key"

--Post Patch 7.1
--L.TEXT_ONLY_RANGE						= "Range frame is limited to text only due to API restrictions in this area."
L.NO_RANGE					= "Das Abstandsradar kann in Instanzen nicht genutzt werden. Es wird stattdessen die alte textbasierte Abstandsanzeige verwendet."
L.NO_ARROW					= "Der Pfeil kann in Instanzen nicht genutzt werden."
L.NO_HUD						= "Die HudMap kann in Instanzen nicht genutzt werden."

L.DYNAMIC_DIFFICULTY_CLUMP	= L.DBM.." hat das dynamische Abstandsfenster für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, auf wieviel versammelte Spieler bei deiner Gruppengröße geprüft werden muss."
L.DYNAMIC_ADD_COUNT			= L.DBM.." hat Warnungen bezüglich der Anzahl der Gegner für diesen Kampf deaktiviert, da nicht genügend Informationen vorliegen, wieviel Gegner bei deiner Gruppengröße erscheinen."
L.DYNAMIC_MULTIPLE			= L.DBM.." hat mehrere Funktionalitäten für diesen Kampf deaktiviert, da für deine Gruppengröße nicht genügend Informationen über bestimmte Kampfmechaniken vorliegen."

L.LOOT_SPEC_REMINDER			= "Deine aktuelle Spezialisierung ist %s. Deine aktuelle Beutespezialisierung ist %s."

L.BIGWIGS_ICON_CONFLICT		= L.DBM.." hat festgestellt, dass du das Setzen von Schlachtzugzeichen in \"BigWigs\" und in \""..L.DBM.."\" aktiviert hast. Bitte deaktiviere das Setzen von Zeichen in einem der beiden Addons um Konflikte zu vermeiden."

L.MOD_AVAILABLE				= "Das Mod \"%s\" ist für diese Zone/Boss verfügbar. Du kannst es von Curse/WoWI oder deadlybossmods.com herunterladen."

L.COMBAT_STARTED				= "Kampf gegen %s hat begonnen. Viel Glück! :)";
L.COMBAT_STARTED_IN_PROGRESS	= "Du wurdest in den laufenden Kampf gegen %s verwickelt. Viel Glück! :)"
--L.GUILD_COMBAT_STARTED					= "%s has been engaged by %s's guild group"
L.SCENARIO_STARTED			= "%s gestartet. Viel Glück! :)"
L.SCENARIO_STARTED_IN_PROGRESS	=	"Du bist dem laufenden Szenario %s beigetreten. Viel Glück! :)"
L.BOSS_DOWN					= "%s besiegt nach %s!"
L.BOSS_DOWN_I				= "%s besiegt! Das war dein %d. Sieg."
L.BOSS_DOWN_L				= "%s besiegt nach %s! Dein letzter Sieg hat %s gedauert und der schnellste %s. Das war dein %d. Sieg."
L.BOSS_DOWN_NR				= "%s besiegt nach %s! Das ist ein neuer Rekord! (Der alte Rekord war %s.) Das war dein %d. Sieg."
L.RAID_DOWN					= "%s gecleared nach %s"
L.RAID_DOWN_L				= "%s gecleared nach %s! Dein schnellster Clear hat %s gedauert."
L.RAID_DOWN_NR				= "%s gecleared nach %s! Dies ist ein neue Record! (der Alte Rekord war %s)."
--L.GUILD_BOSS_DOWN			= "%s has been defeated by %s's guild group after %s!"
L.SCENARIO_COMPLETE			= "%s abgeschlossen nach %s!"
L.SCENARIO_COMPLETE_I		= "%s abgeschlossen! Das war dein %d. Abschluss."
L.SCENARIO_COMPLETE_L		= "%s abgeschlossen nach %s! Dein letzter Abschluss hat %s gedauert und der schnellste %s. Das war dein %d. Abschluss."
L.SCENARIO_COMPLETE_NR		= "%s abgeschlossen nach %s! Das ist ein neuer Rekord! (Der alte Rekord war %s.) Das war dein %d. Abschluss."
L.COMBAT_ENDED_AT			= "Kampf gegen %s (%s) hat nach %s aufgehört."
L.COMBAT_ENDED_AT_LONG		= "Kampf gegen %s (%s) hat nach %s aufgehört. Das war deine %d. Niederlage auf diesem Schwierigkeitsgrad."
--L.GUILD_COMBAT_ENDED_AT					= "%s's Guild group has wiped on %s (%s) after %s."
L.SCENARIO_ENDED_AT			= "%s abgebrochen nach %s."
L.SCENARIO_ENDED_AT_LONG	= "%s abgebrochen nach %s. Das war dein %d. Abbruch auf diesem Schwierigkeitsgrad."
L.COMBAT_STATE_RECOVERED	= "Kampf gegen %s hat vor %s begonnen, Neukalibrierung der Timer erfolgt..."
L.TRANSCRIPTOR_LOG_START	= "\"Transcriptor\"-Aufzeichnung gestartet."
L.TRANSCRIPTOR_LOG_END		= "\"Transcriptor\"-Aufzeichnung beendet."

L.MOVIE_SKIPPED				= L.DBM.." hat versucht eine Videosequenz automatisch zu überspringen."
--L.MOVIE_NOTSKIPPED							= L.DBM .. " has detected a skipable cut scene but has NOT skipped it due to a blizzard bug. When this bug is fixed, skipping will be re-enabled"
L.BONUS_SKIPPED				= L.DBM.." hat das Beutefenster für den Bonuswurf automatisch geschlossen. Tippe /dbmbonusroll binnen drei Minuten, um es bei Bedarf anzuzeigen."

L.AFK_WARNING				= "Du bist \"AFK\" und im Kampf (%d Prozent Gesundheit verbleibend), Alarmsound ausgelöst.  Entferne deine \"AFK\"-Markierung oder deaktiviere diese Alarmierung unter \"Sonstige Funktionen\", falls du nicht \"AFK\" bist."

L.COMBAT_STARTED_AI_TIMER	= "Meine CPU ist ein neuronaler Prozessor, ein lernender Computer. (Dieser Kampf wird die neuen KI-Funktionen zur Erzeugung von Timernäherungen verwenden.)"

L.PROFILE_NOT_FOUND			= "<"..L.DBM.."> Dein derzeitiges Profil ist korrupt. "..L.DBM.." wird das Profil 'Default' laden."
L.PROFILE_CREATED			= "Profil '%s' erzeugt."
L.PROFILE_CREATE_ERROR		= "Erzeugen des Profils fehlgeschlagen. Ungültiger Profilname."
L.PROFILE_CREATE_ERROR_D	= "Erzeugen des Profils fehlgeschlagen. Profil '%s' existiert bereits."
L.PROFILE_APPLIED			= "Profil '%s' angewendet."
L.PROFILE_APPLY_ERROR		= "Anwenden des Profils fehlgeschlagen. Profil '%s' existiert nicht."
L.PROFILE_COPIED			= "Profil '%s' kopiert."
L.PROFILE_COPY_ERROR		= "Kopieren des Profils fehlgeschlagen. Profil '%s' existiert nicht."
L.PROFILE_COPY_ERROR_SELF	= "Das Profil kann nicht auf sich selbst kopiert werden."
L.PROFILE_DELETED			= "Profil '%s' gelöscht. Profil 'Default' wird angewendet."
L.PROFILE_DELETE_ERROR		= "Löschen des Profils fehlgeschlagen. Profil '%s' existiert nicht."
L.PROFILE_CANNOT_DELETE		= "Das Profil 'Default' kann nicht gelöscht werden."
L.MPROFILE_COPY_SUCCESS		= "Mod-Einstellungen von %s (Spez. %d) wurden kopiert."
L.MPROFILE_COPY_SELF_ERROR	= "Die Charaktereinstellungen können nicht auf sich selbst kopiert werden."
L.MPROFILE_COPY_S_ERROR		= "Quelle korrupt. Die Einstellungen wurden nicht oder unvollständig kopiert. Kopieren fehlgeschlagen."
L.MPROFILE_COPYS_SUCCESS	= "Mod-Soundeinstellungen oder Notizen von %s (Spez. %d) wurden kopiert."
L.MPROFILE_COPYS_SELF_ERROR	= "Die Charaktersoundeinstellungen oder Notizen können nicht auf sich selbst kopiert werden."
L.MPROFILE_COPYS_S_ERROR	= "Quelle korrupt. Die Soundeinstellungen oder Notizen wurden nicht oder unvollständig kopiert. Kopieren fehlgeschlagen."
L.MPROFILE_DELETE_SUCCESS	= "Mod-Einstellungen von %s (Spez. %d) wurden gelöscht."
L.MPROFILE_DELETE_SELF_ERROR= "Die derzeit genutzten Mod-Einstellungen können nicht gelöscht werden."
L.MPROFILE_DELETE_S_ERROR	= "Quelle korrupt. Die Einstellungen wurden nicht oder unvollständig gelöscht. Löschen fehlgeschlagen."

L.NOTE_SHARE_SUCCESS		= "%s hat die Notiz für %s geteilt."
L.NOTE_SHARE_LINK			= "Hier klicken um die Notiz zu öffnen"
L.NOTE_SHARE_FAIL			= "%s hat versucht eine Notiz mit dir für %s zu teilen. Ein Mod für diese Fähigkeit ist jedoch nicht installiert oder nicht geladen. Falls du diese Notiz benötigst, solltest du sicherstellen, dass du das entsprechende Mod geladen hast und erneut um Teilung der Notiz bitten."

L.NOTEHEADER				= "Gib deine Notiz für %s hier ein. Umschließe Spielernamen mit >< für Klassenfarben. Trenne Notizen mit '/' bei Alarmen mit mehreren Notizen."
L.NOTEFOOTER				= "'OK' um die Änderungen zu akzeptieren, sonst 'Abbrechen'"
L.NOTESHAREDHEADER			= "%s hat die Notiz unten für %s geteilt. Falls du sie akzeptierst, wird deine derzeitige Notiz überschrieben."
L.NOTESHARED				= "Deine Notiz wurde an die Gruppe gesendet."
L.NOTESHAREERRORSOLO		= "Einsam? Du solltest keine Notizen mit dir selbst teilen."
L.NOTESHAREERRORBLANK		= "Leere Notizen können nicht geteilt werden."
L.NOTESHAREERRORGROUPFINDER	= "In automatischen Gruppen der Gruppensuche können keine Notizen geteilt werden."
L.NOTESHAREERRORALREADYOPEN	= "Die geteilte Notiz kann nicht geöffnet werden während der Notizeditor bereits geöffnet ist, damit die gerade von dir bearbeitete Notiz nicht verloren geht."

L.ALLMOD_DEFAULT_LOADED		= "Standardeinstellungen für alle Mods dieser Instanz geladen."
L.ALLMOD_STATS_RESETED		= "Alle Mod-Statistiken wurden zurückgesetzt."
L.MOD_DEFAULT_LOADED		= "Standardeinstellungen für diesen Kampf geladen."

L.WORLDBOSS_ENGAGED			= "Kampf gegen %s wurde möglicherweise auf deinem Realm bei %s Prozent Leben begonnen. (gesendet von %s)"
L.WORLDBOSS_DEFEATED		= "%s wurde möglichweise auf deinem Realm besiegt. (gesendet von %s)"
L.WORLDBUFF_STARTED			= "%s wurde auf deinem Realm für die Fraktion %s gestartet (Gesendet von %s)."

L.TIMER_FORMAT_SECS			= "%.2f |4Sekunde:Sekunden;"
L.TIMER_FORMAT_MINS			= "%d |4Minute:Minuten;"
L.TIMER_FORMAT				= "%d |4Minute:Minuten; und %.2f |4Sekunde:Sekunden;"

L.MIN						= "Min"
L.MIN_FMT					= "%d Min"
L.SEC						= "Sek"
L.SEC_FMT					= "%s Sek"

L.GENERIC_WARNING_OTHERS	= "und einem anderen"
L.GENERIC_WARNING_OTHERS2	= "und %d anderen"
L.GENERIC_WARNING_BERSERK	= "Berserker in %s %s"
L.GENERIC_TIMER_BERSERK		= "Berserker"
L.OPTION_TIMER_BERSERK		= "Zeige Zeit bis $spell:26662"
L.BAD						= "Schlechtes"

L.OPTION_CATEGORY_TIMERS			= "Timer"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS			= "Allgemeine Ansagen"
L.OPTION_CATEGORY_WARNINGS_YOU		= "Persönliche Ansagen"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Zielansagen"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "Rollenansagen"
L.OPTION_CATEGORY_SPECWARNINGS		= "Spezialansagen"

L.OPTION_CATEGORY_SOUNDS			= "Sounds"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS			= "Dropdown-Listen"
L.OPTION_CATEGORY_YELLS				= "Schreie"
L.OPTION_CATEGORY_NAMEPLATES		= "Namensplaketten"
L.OPTION_CATEGORY_ICONS				= "Icons"
--L.OPTION_CATEGORY_PAURAS			= "Private Auras"

L.AUTO_RESPONDED					= "Automatisch geantwortet."
L.STATUS_WHISPER					= "%s: %s, %d/%d Spieler am Leben"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s ist damit beschäftigt gegen %s zu kämpfen! (%s, %d/%d Spieler am Leben)"
L.WHISPER_COMBAT_END_KILL			= "%s hat %s besiegt!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s hat %s besiegt! Das war der %d. Sieg."
L.WHISPER_COMBAT_END_WIPE_AT		= "%s war %s bei %s unterlegen."
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s war %s bei %s unterlegen. Das war die %d. Niederlage auf diesem Schwierigkeitsgrad."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s ist beschäftigt in %s (%d/%d Spieler am Leben)"
L.WHISPER_SCENARIO_END_KILL			= "%s hat %s abgeschlossen!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s hat %s abgeschlossen! Das war der %d. Abschluss."
L.WHISPER_SCENARIO_END_WIPE			= "%s hat %s abgebrochen."
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s hat %s abgebrochen. Das war der %d. Abbruch auf diesem Schwierigkeitsgrad."

L.VERSIONCHECK_HEADER			= "Boss Mod - Versionen"
L.VERSIONCHECK_ENTRY			= "%s: %s (%s) %s"--One Boss mod
L.VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) und %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM		= "%s: Kein Boss Mod installiert."
L.VERSIONCHECK_FOOTER			= "%d Spieler mit "..L.DBM.." und %d Spieler mit BigWigs gefunden."
L.VERSIONCHECK_OUTDATED			= "Folgende %d Spieler haben veraltete "..L.DBM.." Versionen: %s"
L.YOUR_VERSION_OUTDATED     	= "Deine Version von "..L.DEADLY_BOSS_MODS.." ist veraltet! Bitte besuche http://www.deadlybossmods.com um die neueste Version herunterzuladen."
L.VOICE_PACK_OUTDATED			= "Deinem ausgewählten "..L.DBM.." Sprachpack fehlen einige Sounds, die von von "..L.DBM.." unterstützt werden. Für einige Warnungssounds werden weiterhin die Standardsounds abgespielt. Bitte lade dir eine neuere Version des Spachpacks herunter oder kontaktiere den Autor des Sprachpacks für ein Update, welches die fehlenden Sounds enthält."
L.VOICE_MISSING					= "Du hast einen "..L.DBM.." Sprachpack ausgewählt, der nicht gefunden werden konnte. Deine Auswahl wurde auf 'Kein Sprachpack' zurückgesetzt. Bitte stelle sicher, dass der Sprachpack korrekt installiert und in der Addon-Liste aktiviert wurde, falls dies ein Fehler ist."
L.VOICE_DISABLED				= "Du hast derzeit mindestens einen "..L.DBM.." Sprachpack installiert, aber keinen aktiviert. Falls du einen Sprachpack nutzen möchtest, dann wähle ihn unter \"Gesprochene Warnungen\" aus. Ansonsten kannst du die ungenutzten Sprachpacks deinstallieren, um diese Meldung zu unterdrücken."
L.VOICE_COUNT_MISSING			= "Für die Countdown-Stimme %d ist ein Sprach-/Zählpack ausgewählt, der nicht gefunden werden konnte. Die Stimme wurde auf die Standardeinstellung zurückgesetzt: %s."
--L.BIG_WIGS					= "BigWigs" -- OPTIONAL
--L.WEAKAURA_KEY				= " (|cff308530WA Key:|r %s)"

L.UPDATEREMINDER_HEADER			= "Deine Version von "..L.DEADLY_BOSS_MODS.." ist veraltet.\n Version %s (%s) kann über Curse/Twitch, WoWI oder von deadlybossmods.com heruntergeladen werden."
L.UPDATEREMINDER_FOOTER			= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Downloadlink in die Zwischenablage zu kopieren."
L.UPDATEREMINDER_FOOTER_GENERIC	= "Drücke " .. (IsMacClient() and "Cmd-C" or "Strg+C")  ..  " um den Link in die Zwischenablage zu kopieren."
L.UPDATEREMINDER_DISABLE		= "WARNUNG: Da dein "..L.DEADLY_BOSS_MODS.." zu veraltet ist, hat es sich zwangsweise deaktiviert und kann erst nach einer Aktualisierung wieder genutzt werden. Derart alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen."
--L.UPDATEREMINDER_DISABLETEST			= "WARNING: Due to your " .. L.DEADLY_BOSS_MODS.. " being out of date and this being a test/beta realm, it has been force disabled and cannot be used until updated. This is to ensure out of date mods aren't being used to generate test feedback"
L.UPDATEREMINDER_HOTFIX			= "Deine Version von "..L.DBM.." hat bekannte Probleme während dieses Bosskampfes, die durch ein Update auf die neueste DBM-Version behoben werden können."
L.UPDATEREMINDER_HOTFIX_ALPHA	= "Deine Version von "..L.DBM.." hat bekannte Probleme während dieses Bosskampfes, die in einer künftigen DBM-Version behoben sind (oder in der neuesten Alphaversion)."
L.UPDATEREMINDER_MAJORPATCH		= "WARNUNG: Da dein "..L.DEADLY_BOSS_MODS.." veraltet und deshalb leider für diesen Major Patch des Spiels nicht mehr geeignet ist, hat es sich bis zu einer Aktualisierung deaktiviert. Alter und inkompatibler Code kann zu einem schlechten Spielerlebnis bei dir oder deinen Schlachtzugsmitgliedern führen. Bitte lade dir baldmöglichst eine neue Version von deadlybossmods.com oder Curse herunter."
L.VEM							= "WARNUNG: Du benutzt "..L.DEADLY_BOSS_MODS.." zusammen mit Voice Encounter Mods. "..L.DBM.." läuft nicht in dieser Konfiguration und wird deshalb nicht geladen."
L.OUTDATEDPROFILES				= "WARNUNG: DBM-Profiles ist mit dieser Version von DBM nicht kompatibel. Es muss entfernt werden bevor "..L.DBM.." genutzt werden kann um Konflikte zu vermeiden."
L.OUTDATEDSPELLTIMERS			= "WARNUNG: DBM-SpellTimers funktioniert nicht mehr und muss deaktiviert werden damit " .. L.DBM .. " richtig funktioniert."
L.OUTDATEDRLT					= "WARNUNG: DBM-RaidLeadTools funktioniert nicht mehr und muss entfernt werden damit " .. L.DBM .. "  richtig funktioniert."
L.VICTORYSOUND					= "WARNUNG: DBM-VictorySound ist nicht kompatible mit dieser version von " .. L.DBM .. " und muss, um Konflikte zu vermeiden, deaktiviert werden damit " .. L.DBM .. " genutzt werden kann."
L.DPMCORE						= "WARNUNG: Deadly Pvp Mods (DPM) wird nicht mehr gepflegt und ist mit dieser Version von "..L.DBM.." nicht kompatibel. Es muss entfernt werden bevor "..L.DBM.." genutzt werden kann um Konflikte zu vermeiden."
L.DBMLDB						= "WARNUNG: DBM-LDB ist nun DBM-Core integriert. Obwohl es keine schädlichen Auswirkungen hat, wird empfohlen 'DBM-LDB' aus dem Addon-Ordner zu entfernen."
L.DBMLOOTREMINDER				= "WARNUNG: 3rd party mod DBM-LootReminder ist installiert. Dieses Addon ist nicht mehr Kompatibel mit dem Retail WoW Client und führt dazu das " .. L.DBM .. " nicht mehr funktioniert und keine Pull-Timer mehr senden kann. Komplette Entfernung des Addons wird empfohlen."
L.UPDATE_REQUIRES_RELAUNCH		= "WARNUNG: Dieses Update von "..L.DBM.." arbeitet erst nach einem vollständigem Neustart des Spielclients korrekt. Das Update enthält neue Dateien oder Änderungen an .toc-Dateien, die nicht mit \"/reload\" geladen werden können. Die Funktionsfähigkeit von DBM kann beeinträchtigt sein und es können Fehler auftreten, bis du den Spielclient neu startest."
L.OUT_OF_DATE_NAG				= "Deine Version von "..L.DEADLY_BOSS_MODS.." ist veraltet. Du solltest eine Aktualisierung für diesen Kampf durchführen, da du sonst wichtige Warnungen oder Timer verpassen könntest oder automatische \"Schreie\" fehlen, die der Rest deines Schlachtzuges von dir erwartet."
--L.PLATER_NP_AURAS_MSG			= L.DBM .. " includes an advanced feature to show enemy cooldown timers using icons on nameplates. This is on by default for most users, but for Plater users it is off by default in Plater options unless you enable it. To get the most out of DBM (and Plater) it's recommended you enable this feature in Plater under 'Buff Special' section. If you don't want to see this message again, you can also just entirely disable 'Cooldown icons on nameplates' option in DBM global disable or nameplate options panels"

L.MOVABLE_BAR					= "Zieh mich!"

L.PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h hat dir einen DBM-Timer geschickt: '%2$s'\n|Hgarrmission:DBM:cancel:%2$s:nil|h|cff3588ff[Diesen Timer abbrechen]|r|h  |Hgarrmission:DBM:ignore:%2$s:%1$s|h|cff3588ff[Timer von %1$s ignorieren]|r|h"
--L.PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h hat dir einen DBM-Timer geschickt"
L.PIZZA_CONFIRM_IGNORE			= "Willst du wirklich DBM-Timer von %s für diese Sitzung ignorieren?"
L.PIZZA_ERROR_USAGE				= "Benutzung: /dbm [broadcast] timer <Sekunden> <Text>. <Sekunden> muss größer als 1 sein."

L.MINIMAP_TOOLTIP_FOOTER		= "Shift gedrückt halten und Ziehen zum Bewegen"

L.RANGECHECK_HEADER			= "Abstandscheck (%dy)"
L.RANGECHECK_HEADERT		= "Abstandscheck (%dy-%dP)"
L.RANGECHECK_RHEADER		= "Radar-Abstandscheck (%dy)"
L.RANGECHECK_RHEADERT		= "Radar-Abstandscheck (%dy-%dP)"
L.RANGECHECK_SETRANGE		= "Abstand einstellen"
L.RANGECHECK_SETTHRESHOLD	= "Spielerschwellwert"
L.RANGECHECK_SOUNDS			= "Sounds"
L.RANGECHECK_SOUND_OPTION_1	= "Sound, falls ein Spieler in Reichweite ist"
L.RANGECHECK_SOUND_OPTION_2	= "Sound, falls mehr als ein Spieler in Reichweite ist"
L.RANGECHECK_SOUND_0		= "Kein Sound"
L.RANGECHECK_SOUND_1		= "Standard-Sound"
L.RANGECHECK_SOUND_2		= "Nerviges Piepsen"
L.RANGECHECK_SETRANGE_TO	= "%dm"
L.RANGECHECK_OPTION_FRAMES	= "Fenster"
L.RANGECHECK_OPTION_RADAR	= "Zeige Radarfenster"
L.RANGECHECK_OPTION_TEXT	= "Zeige Textfenster"
L.RANGECHECK_OPTION_BOTH	= "Zeige beide Fenster"
L.RANGERADAR_HEADER			= "Abstand:%d Spieler:%d"
L.RANGERADAR_RHEADER		= "Radarabstand:%d Spieler:%d"
L.RANGERADAR_IN_RANGE_TEXT	= "%d in Reichweite (%0.1fm)"
L.RANGECHECK_IN_RANGE_TEXT	= "%d in Reichweite"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fm)"

--L.INFOFRAME_TITLE						= "DBM Info Frame"
L.INFOFRAME_SHOW_SELF		= "Eigene Stärke immer anzeigen" -- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES		= "Setze maximale Zeilenanzahl"
L.INFOFRAME_SETCOLS			= "Setze maximale Spaltenanzahl"
L.INFOFRAME_LINESDEFAULT	= "gesetzt vom Mod"
L.INFOFRAME_LINES_TO		= "%d Zeilen"
--L.INFOFRAME_COLS_TO		= "%d columns"
L.INFOFRAME_POWER			= "Energie"
L.INFOFRAME_AGGRO			= "Aggro"
L.INFOFRAME_MAIN			= "Primär:"--Main power
L.INFOFRAME_ALT				= "Alt:"--Alternate Power

L.LFG_INVITE				= "Einladung der Gruppensuche"

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
	"/dbm lag: Prüft die Latenz im gesamten Schlachtzug.",
	"/dbm durability: Prüft die Haltbarkeit im gesamten Schlachtzug."
}
L.TIMER_USAGE	= {
	L.DBM .. "-Timer Kommandos:",
	"-----------------",
	"/dbm timer <sec> <text>: Startet einen <sec> Sekunden langen Timer mit deinem <text>.",
	"/dbm ltimer <sec> <text>: Startet einen Timer, der automatisch wiederholt wird, bis er abgebrochen wird.",
	"/dbm broadcast timer/ltimer/cltimer <sec> <text>: schickt den Timer an den Schlachtzug (nur als Leiter/Assistent).",
	"/dbm timer endloop: Stoppt alle ltimer-.",
}

L.ERROR_NO_PERMISSION				= "Du hast nicht die benötigte Berechtigung für diesen Befehl!"
L.PULL_TIME_TOO_SHORT						= "Pull-Timer muss länger als 3 Sekunden sein"
L.PULL_TIME_TOO_LONG							= "Pull timer cannot be longer than 60 seconds"

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
L.AUTO_ANNOUNCE_TEXTS.targetsource						= ">%%s< wirkt %s auf >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) auf >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell		= "%s"
--L.AUTO_ANNOUNCE_TEXTS.incoming							= "%s incoming debuff"
--L.AUTO_ANNOUNCE_TEXTS.incomingcount						= "%s incoming debuff (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends 		= "%s ist beendet"
L.AUTO_ANNOUNCE_TEXTS.endtarget	= "%s ist beendet: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades		= "%s ist beendet"
L.AUTO_ANNOUNCE_TEXTS.addsleft		= "%s verbleibend: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast		= "Wirkt %s: %.1f Sek"
L.AUTO_ANNOUNCE_TEXTS.soon		= "%s bald"
L.AUTO_ANNOUNCE_TEXTS.sooncount	= "%s (%%s) bald"
L.AUTO_ANNOUNCE_TEXTS.countdown							= "%s in %%ds"
L.AUTO_ANNOUNCE_TEXTS.prewarn		= "%s in %s"
L.AUTO_ANNOUNCE_TEXTS.bait								= "%s bald - bait jetzt"
L.AUTO_ANNOUNCE_TEXTS.stage		= "Phase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage	= "Phase %s bald"
L.AUTO_ANNOUNCE_TEXTS.count		= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack		= "%s auf >%%s< (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto								= "%s - gehe zu >%%s<"

local prewarnOption = "Zeige Vorwarnung für $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you			= "Verkünde, wenn du von $spell:%s betroffen bist"
L.AUTO_ANNOUNCE_OPTIONS.target		= "Verkünde Ziele von $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetNF	= "Verkünde Ziele von $spell:%s (ignoriert globalen Ziel Filtert)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource= "Verkünde Ziele von $spell:%s (mit Quelle)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount	= "Verkünde Ziele von $spell:%s (mit Zählung)"
L.AUTO_ANNOUNCE_OPTIONS.spell		= "Zeige Warnung für $spell:%s"
--L.AUTO_ANNOUNCE_OPTIONS.incoming			= "Announce when $spell:%s has incoming debuffs"
--L.AUTO_ANNOUNCE_OPTIONS.incomingcount		= "Announce (with count) when $spell:%s has incoming debuffs"
L.AUTO_ANNOUNCE_OPTIONS.ends		= "Zeige Warnung, wenn $spell:%s beendet ist"
L.AUTO_ANNOUNCE_OPTIONS.endtarget	= "Zeige Warnung, wenn $spell:%s beendet ist"
L.AUTO_ANNOUNCE_OPTIONS.fades		= "Zeige Warnung, wenn $spell:%s beendet ist"
L.AUTO_ANNOUNCE_OPTIONS.addsleft	= "Verkünde die Anzahl der verbleibenden $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.cast		= "Zeige Warnung, wenn $spell:%s gewirkt wird"
L.AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount	= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.countdown	= "Zeige Vorwarnungs-Countdown für $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.prewarn 	= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait 		= "Zeige Vorwarnungs (zum Baiten) für $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stage		= "Verkünde Phase %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange	= "Verkünde Phasenwechsel"
L.AUTO_ANNOUNCE_OPTIONS.prestage	= "Zeige Vorwarnung für Phase %s"
L.AUTO_ANNOUNCE_OPTIONS.count		= "Zeige Warnung für $spell:%s (mit Zählung)"
L.AUTO_ANNOUNCE_OPTIONS.stack		= "Verkünde $spell:%s Stapel"
L.AUTO_ANNOUNCE_OPTIONS.moveto		= "Zeige Warnung für Bewegungen zu Spieler oder Ort für $spell:%s"

L.AUTO_SPEC_WARN_TEXTS.spell			= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends				= "%s beendet"
L.AUTO_SPEC_WARN_TEXTS.fades			= "%s beendet"
L.AUTO_SPEC_WARN_TEXTS.soon				= "%s bald"
L.AUTO_SPEC_WARN_TEXTS.sooncount		= "%s (%%s) bald"
L.AUTO_SPEC_WARN_TEXTS.bait				= "%s bald - bait jetzt"
L.AUTO_SPEC_WARN_TEXTS.prewarn			= "%s in %s"
L.AUTO_SPEC_WARN_TEXTS.dispel			= "%s auf >%%s< - jetzt reinigen"
L.AUTO_SPEC_WARN_TEXTS.interrupt		= "%s - unterbrich >%%s<!"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - unterbrich >%%s<! (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you				= "%s auf dir"
L.AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) auf dir"
L.AUTO_SPEC_WARN_TEXTS.youpos			= "%s (Position: %%s) auf dir"
L.AUTO_SPEC_WARN_TEXTS.youposcount		= "%s (%%s) (Position: %%s) auf dir!"
L.AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Soak Position: %%s)"
L.AUTO_SPEC_WARN_TEXTS.target			= "%s auf >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) auf >%%s< "
L.AUTO_SPEC_WARN_TEXTS.defensive		= "%s - Defensivfähigkeiten"
L.AUTO_SPEC_WARN_TEXTS.taunt			= "%s auf >%%s< - jetzt spotten"
L.AUTO_SPEC_WARN_TEXTS.close			= "%s auf >%%s< in deiner Nähe"
L.AUTO_SPEC_WARN_TEXTS.move				= "%s - geh weg"
L.AUTO_SPEC_WARN_TEXTS.keepmove			= "%s - lauf weiter"
L.AUTO_SPEC_WARN_TEXTS.stopmove			= "%s - bleib stehen"
L.AUTO_SPEC_WARN_TEXTS.dodge			= "%s - Angriff ausweichen"
L.AUTO_SPEC_WARN_TEXTS.dodgecount		= "%s (%%s) - Angriff ausweichen"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc			= "%s von %%s - ausweichen"
L.AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - geh weg von anderen"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount	= "%s (%%s) - geh weg von anderen"
L.AUTO_SPEC_WARN_TEXTS.moveto			= "%s - geh zu >%%s<"
L.AUTO_SPEC_WARN_TEXTS.soak				= "%s - soaken"
L.AUTO_SPEC_WARN_TEXTS.soakcount		= "%s - soake (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump				= "%s - spring"
L.AUTO_SPEC_WARN_TEXTS.run				= "%s - lauf weg"
--L.AUTO_SPEC_WARN_TEXTS.runcount							= "%s - run away (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast				= "%s - stoppe Zauber"
L.AUTO_SPEC_WARN_TEXTS.lookaway			= "%s - schau weg"
L.AUTO_SPEC_WARN_TEXTS.reflect			= "%s auf >%%s< - stoppe Angriffe"
L.AUTO_SPEC_WARN_TEXTS.count				= "%s! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack				= "%%d Stapel von %s auf dir"
L.AUTO_SPEC_WARN_TEXTS.switch			= "%s - Ziel wechseln"
L.AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - Ziel wechseln (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo				= "%%s unter dir - lauf raus"
L.AUTO_SPEC_WARN_TEXTS.adds				= "Adds kommen - Ziel wechseln"
--L.AUTO_SPEC_WARN_TEXTS.addscount							= "Incoming Adds - switch targets (%%s)"--Basically a generic of switch
L.AUTO_SPEC_WARN_TEXTS.addscustom		= "Adds kommen - %%s"
L.AUTO_SPEC_WARN_TEXTS.targetchange						= "Zielwechsel - wechsel zu  %%s"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Spezialwarnung für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends 			= "Spezialwarnung, wenn $spell:%s beendet ist"
L.AUTO_SPEC_WARN_OPTIONS.fades 			= "Spezialwarnung, wenn $spell:%s beendet ist"
L.AUTO_SPEC_WARN_OPTIONS.soon 			= "Spezialvorwarnung für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.sooncount		= "Spezialvorwarnung (mit Zählung) für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.bait			= "Spezialvorwarnung (zum Baiten) für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Spezialvorwarnung %s Sekunden vor $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 		= "Spezialwarnung zum Reinigen/Rauben von $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Spezialwarnung zum Unterbrechen von $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Spezialwarnung (mit Zählung) zum Unterbrechen von $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Spezialwarnung, wenn du von $spell:%s betroffen bist"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Spezialwarnung (mit Zählung), wenn du von $spell:%s betroffen bist"
L.AUTO_SPEC_WARN_OPTIONS.youpos			= "Spezialwarnung (mit Position), wenn du von $spell:%s betroffen bist"
L.AUTO_SPEC_WARN_OPTIONS.youposcount	= "Spezialwarnung (mit Position und Zählung), wenn du von $spell:%s betroffen bist"
L.AUTO_SPEC_WARN_OPTIONS.soakpos		= "Spezialwarnung (mit Position) zur Schadensteilung mit von $spell:%s Betroffenen"
L.AUTO_SPEC_WARN_OPTIONS.target 		= "Spezialwarnung, wenn jemand von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Spezialwarnung (mit Zählung), wenn jemand von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.defensive 		= "Spezialwarnung zur Nutzung von Defensivfähigkeiten bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt 			= "Spezialwarnung zum Spotten, wenn der andere Tank von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Spezialwarnung, wenn jemand in deiner Nähe von $spell:%s betroffen ist"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Spezialwarnung zum Herausgehen aus $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Spezialwarnung zum Weiterlaufen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Spezialwarnung zum Stehen bleiben bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Spezialwarnung zum Ausweichen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount		= "Spezialwarnung (mit Zählung) zum Ausweichen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "Spezialwarnung (mit Ort) zum Ausweichen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveaway		= "Spezialwarnung zum Weggehen von anderen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "Spezialwarnung (mit Zählung) zum Weggehen von anderen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveto			= "Spezialwarnung zum Hingehen zu jemand oder zu einem Ort bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soak			= "Spezialwarnung zum Soaken für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakcount		= "Spezialwarnung (mit Zählung) zum Soaken für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.jump			= "Spezialwarnung zum Springen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Spezialwarnung zum Weglaufen vor $spell:%s"
--L.AUTO_SPEC_WARN_OPTIONS.runcount		= "Show special announce (with count) to run away from $spell:%s",
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Spezialwarnung zum Zauberstopp bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.lookaway		= "Spezialwarnung zum Wegschauen bei $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect 		= "Spezialwarnung zum Angriffsstopp auf $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.count 			= "Spezialwarnung für $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack 			= "Spezialwarnung bei >=%d Stapel von $spell:%s auf dir"
L.AUTO_SPEC_WARN_OPTIONS.switch			= "Spezialwarnung für Zielwechsel auf $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount	= "Spezialwarnung (mit Zählung) für Zielwechsel auf $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Spezialwarnung zum Rauslaufen aus schlechten Dingen auf dem Boden"
L.AUTO_SPEC_WARN_OPTIONS.adds			= "Spezialwarnung für Zielwechsel auf ankommende Adds"
--L.AUTO_SPEC_WARN_OPTIONS.addscount	= "Show special announce (with count) to switch targets for incoming adds"
L.AUTO_SPEC_WARN_OPTIONS.addscustom		= "Spezialwarnung für ankommende Adds"
L.AUTO_SPEC_WARN_OPTIONS.targetchange	= "Spezialwarnung für wechsel des Prioritätsziels"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target		= "%s: %%s"
L.AUTO_TIMER_TEXTS.targetcount							= "%s (%%2$s): %%1$s" -- OPTIONAL
L.AUTO_TIMER_TEXTS.cast			= "%s"
L.AUTO_TIMER_TEXTS.castcount							= "%s (%%s)" -- OPTIONAL
L.AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
L.AUTO_TIMER_TEXTS.active		= "%s endet"--Buff/Debuff/event on boss
L.AUTO_TIMER_TEXTS.fades		= "%s schwindet"--Buff/Debuff on players
L.AUTO_TIMER_TEXTS.ai			= "%s KI"

L.AUTO_TIMER_TEXTS.cd			= "%s CD"
L.AUTO_TIMER_TEXTS.cdcount		= "%s (%%s) CD"
L.AUTO_TIMER_TEXTS.cdsource		= "%s CD: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial	= "Spezial CD"

L.AUTO_TIMER_TEXTS.next			= "Nächster %s"
L.AUTO_TIMER_TEXTS.nextcount	= "Nächster %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource	= "Nächster %s: %%s"
L.AUTO_TIMER_TEXTS.nextspecial	= "Nächste Spezial"

L.AUTO_TIMER_TEXTS.achievement	= "%s"
L.AUTO_TIMER_TEXTS.stage		= "Nächste Phase"
--L.AUTO_TIMER_TEXTS.stagecount							= "Stage %%s"--NOT BUGGED, stage is 2nd arg, spellID is ignored on purpose
--L.AUTO_TIMER_TEXTS.stagecountcycle						= "Stage %%s (%%s)"--^^. Example: Stage 2 (3) for a fight that alternates stage 1 and stage 2, but also tracks total cycles
--L.AUTO_TIMER_TEXTS.stagecontext						= "%s" -- OPTIONAL
--L.AUTO_TIMER_TEXTS.stagecontextcount					= "%s (%%s)" -- OPTIONAL
--L.AUTO_TIMER_TEXTS.intermission						= "Intermission"
--L.AUTO_TIMER_TEXTS.intermissioncount					= "Intermission %%s"
L.AUTO_TIMER_TEXTS.adds			= "Nächste Adds"
L.AUTO_TIMER_TEXTS.addscustom	= "Nächste Adds (%%s)"
L.AUTO_TIMER_TEXTS.roleplay		= GUILD_INTEREST_RP or "Rollenspiel"--Used mid fight, pre fight, or even post fight. Boss does NOT auto engage upon completion
L.AUTO_TIMER_TEXTS.combat		= "Kampfbeginn"
--This basically clones np only bar option and display text from regular counterparts
L.AUTO_TIMER_TEXTS.cdnp = L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextnp = L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.cdcountnp = L.AUTO_TIMER_TEXTS.cdcount -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextcountnp = L.AUTO_TIMER_TEXTS.nextcount -- OPTIONAL

L.AUTO_TIMER_OPTIONS.target		= "Dauer des Debuffs für $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.targetcount= "Dauer des Debuffs (mit Zählung) für $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.cast		= "Wirkzeit von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.castcount	= "Wirkzeit (mit Zählung) von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.castsource	= "Wirkzeit von $spell:%s anzeigen (mit Quelle)"
L.AUTO_TIMER_OPTIONS.active		= "Dauer von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.fades		= "Zeit bis $spell:%s von Spielern schwindet anzeigen"
L.AUTO_TIMER_OPTIONS.ai			= "KI-Timer für die Abklingzeit von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.cd			= "Abklingzeit von $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.cdcount	= "Abklingzeit von $spell:%s anzeigen"
--L.AUTO_TIMER_OPTIONS.cdnp		= "Show nameplate only timer for $spell:%s cooldown"
--L.AUTO_TIMER_OPTIONS.cdnpcount= "Show nameplate only timer (with count) for $spell:%s cooldown"
L.AUTO_TIMER_OPTIONS.cdsource	= "Abklingzeit von $spell:%s anzeigen (mit Quelle)"
L.AUTO_TIMER_OPTIONS.cdspecial	= "Abklingzeit für Spezialfähigkeit anzeigen"
--L.AUTO_TIMER_OPTIONS.cdcombo								= "Show timer for ability combo cooldown"--Used for combining 2 abilities into a single timer
L.AUTO_TIMER_OPTIONS.next		= "Zeit bis nächstes $spell:%s anzeigen"
L.AUTO_TIMER_OPTIONS.nextcount	= "Zeit bis nächstes $spell:%s anzeigen"
--L.AUTO_TIMER_OPTIONS.nextnp	= "Show nameplate only timer for next $spell:%s"
--L.AUTO_TIMER_OPTIONS.nextnpcount	= "Show nameplate only timer (with count) for next $spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource	= "Zeit bis nächstes $spell:%s anzeigen (mit Quelle)"
L.AUTO_TIMER_OPTIONS.nextspecial	= "Zeige Zeit bis nächste Spezialfähigkeit"
--L.AUTO_TIMER_OPTIONS.nextcombo							= "Show timer for next ability combo"--Used for combining 2 abilities into a single timer
L.AUTO_TIMER_OPTIONS.achievement	= "Zeit für %s anzeigen"
L.AUTO_TIMER_OPTIONS.stage		= "Zeige Zeit bis nächste Phase"
--L.AUTO_TIMER_OPTIONS.stagecount							= "Show timer (with count) for next stage"
--L.AUTO_TIMER_OPTIONS.stagecountcycle						= "Show timer (with stage count and cycle count) for next stage"
--L.AUTO_TIMER_OPTIONS.stagecontext						= "Show timer for next $spell:%s stage"
--L.AUTO_TIMER_OPTIONS.stagecontextcount					= "Show timer (with count) for next $spell:%s stage"
--L.AUTO_TIMER_OPTIONS.intermission						= "Show timer for next intermission"
--L.AUTO_TIMER_OPTIONS.intermissioncount					= "Show timer (with count) for next intermission"
L.AUTO_TIMER_OPTIONS.adds		= "Zeige Zeit bis Adds erscheinen"
L.AUTO_TIMER_OPTIONS.addscustom	= "Zeige Zeit bis Adds erscheinen"
L.AUTO_TIMER_OPTIONS.roleplay	= "Dauer des Rollenspiels anzeigen"
L.AUTO_TIMER_OPTIONS.combat		= "Zeige Zeit bis Kampfbeginn"

L.AUTO_ICONS_OPTION_TARGETS				= "Setze Zeichen auf Ziele von $spell:%s"
--L.AUTO_ICONS_OPTION_TARGETS_TANK_A	= "Set icons on $spell:%s targets with tank over melee over ranged priority and alphabetical fallback"
--L.AUTO_ICONS_OPTION_TARGETS_TANK_R	= "Set icons on $spell:%s targets with tank over melee over ranged priority and raid roster fallback"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A		= "Setze Zeichen auf Ziele von $spell:%s beginnend mit melee und nach Alphabetischer Reihenfolge"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R		= "Setze Zeichen auf Ziele von $spell:%s beginnend mit melee und nach Raidroster Reihenfolge"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A	= "Setze Zeichen auf Ziele von $spell:%s beginnend mit ranged und nach Alphabetischer Reihenfolge"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R	= "Setze Zeichen auf Ziele von $spell:%s beginnend mit ranged und nach Raidroster Reihenfolge"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA		= "Setze Zeichen auf Ziele von $spell:%s nach Alphabetischer Reihenfolge"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER		= "Setze Zeichen auf Ziele von $spell:%s  nach Raidroster Reihenfolge"
L.AUTO_ICONS_OPTION_NPCS				= "Setze Zeichen auf $spell:%s"
L.AUTO_ICONS_OPTION_CONFLICT			= " (kann zu Konflikten mit anderen Optionen führen)"

L.AUTO_ARROW_OPTION_TEXT			= "Zeige DBM-Pfeil zum Hingehen zum von $spell:%s betroffenen Ziel"
L.AUTO_ARROW_OPTION_TEXT2		= "Zeige DBM-Pfeil zum Weggehen vom von $spell:%s betroffenen Ziel"
L.AUTO_ARROW_OPTION_TEXT3		= "Zeige DBM-Pfeil zum Hingehen zum richtigen Ort für $spell:%s"

L.AUTO_YELL_OPTION_TEXT.shortyell		= "Schreie, wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.yell			= "Schreie (mit Spielernamen), wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.count			= "Schreie (mit Zählung), wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.fade			= "Schreie (mit Countdown und Zaubernamen), wenn $spell:%s endet"
L.AUTO_YELL_OPTION_TEXT.shortfade		= "Schreie (mit Countdown), wenn $spell:%s endet"
L.AUTO_YELL_OPTION_TEXT.iconfade		= "Schreie (mit Countdown und Zeichen), wenn $spell:%s endet"
L.AUTO_YELL_OPTION_TEXT.position		= "Schreie (mit Position und Spielername), wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.shortposition	= "Schreie (mit Position), wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.combo			= "Schreie (mit angepasstem Text), wenn du gleichzeitig von $spell:%s und einem weiteren Zauber betroffen bist"
L.AUTO_YELL_OPTION_TEXT.repeatplayer	= "Schreie wiederholt (mit Spielername) wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.repeaticon		= "Schreie wiederholt (mit Icon) wenn du von $spell:%s betroffen bist"
L.AUTO_YELL_OPTION_TEXT.icontarget		= "Schreie Icons wenn du das Ziel von $spell:%s bist um andere zu warnen"

L.AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%s"
L.AUTO_YELL_ANNOUNCE_TEXT.yell		= "%s auf " .. UnitName("player")
L.AUTO_YELL_ANNOUNCE_TEXT.count		= "%s auf " .. UnitName("player") .. " (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade		= "%s endet in %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade	= "{rt%%2$d}%%1$d"
L.AUTO_YELL_ANNOUNCE_TEXT.position	= "%s %%s auf {rt%%d}"..UnitName("player").."{rt%%d}"
--L.AUTO_YELL_ANNOUNCE_TEXT.shortposition 						= "{rt%%1$d}%s %%2$d"--Icon, Spellname, number -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.combo		= "%s und %%s"
--L.AUTO_YELL_ANNOUNCE_TEXT.repeatplayer						= UnitName("player")--Doesn't need translation, it's just player name spam -- OPTIONAL
--L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon							= "{rt%%1$d}"--Doesn't need translation. It's just icon spam -- OPTIONAL

--L.AUTO_YELL_CUSTOM_POSITION				= "{rt%d}%s"--Doesn't need translating. Has no strings (Used in niche situations such as icon repeat yells) -- OPTIONAL
L.AUTO_YELL_CUSTOM_FADE			= "%s beendet"
L.AUTO_HUD_OPTION_TEXT			= "Zeige HudMap für $spell:%s (außer Betrieb)"
L.AUTO_HUD_OPTION_TEXT_MULTI	= "Zeige HudMap für diverse Mechaniken (außer Betrieb)"
L.AUTO_NAMEPLATE_OPTION_TEXT	= "Zeige Namensplakettenaura für $spell:%s"
--L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED		= "Show Nameplate Auras for $spell:%s using only "..L.DBM
L.AUTO_RANGE_OPTION_TEXT		= "Zeige Abstandsfenster (%sm) für $spell:%s"
L.AUTO_RANGE_OPTION_TEXT_SHORT	= "Zeige Abstandsfenster (%sm)"
L.AUTO_RRANGE_OPTION_TEXT		= "Zeige inverses Abstandsfenster (%sm) für $spell:%s"
L.AUTO_RRANGE_OPTION_TEXT_SHORT	= "Zeige inverses Abstandsfenster (%sm)"
L.AUTO_INFO_FRAME_OPTION_TEXT	= "Zeige Infofenster für $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2	= "Zeige Infofenster für Kampfübersicht"
L.AUTO_INFO_FRAME_OPTION_TEXT3	= "Zeige Infofenster für $spell:%s (falls der Schwellwert von %%s übertroffen ist)"
L.AUTO_READY_CHECK_OPTION_TEXT	= "Spiele \"Bereitschaftscheck\"-Sound, wenn der Boss angegriffen wird (auch wenn er nicht als Ziel gesetzt ist)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT	= "Zeige Timer für den schnellsten Clear von %s"
--L.AUTO_PRIVATEAURA_OPTION_TEXT= "Play DBM sound alerts for $spell:%s private auras on this fight."

-- New special warnings
L.MOVE_WARNING_BAR			= "bewegbare Schlachtzugwarnung"
L.MOVE_WARNING_MESSAGE		= "Danke, dass du "..L.DEADLY_BOSS_MODS.." verwendest"
L.MOVE_SPECIAL_WARNING_BAR	= "bewegbare Spezialwarnung"
L.MOVE_SPECIAL_WARNING_TEXT	= "Spezialwarnung"

L.HUD_INVALID_TYPE			= "Der angegebene Typ für die HudMap ist ungültig."
L.HUD_INVALID_TARGET			= "Es wurde kein gültiges Ziel für die HudMap angegeben."
L.HUD_INVALID_SELF			= "Die HudMap kann nicht auf dich selbst zeigen."
L.HUD_INVALID_ICON			= "Der Typ 'icon' für die HudMap kann nicht auf Ziele ohne gesetztem Schlachtzugzeichen angewendet werden."
L.HUD_SUCCESS				= "Die HudMap wurde erfolgreich mit deinen Parametern gestartet. Sie läuft nach %s aus oder zuvor durch Aufruf von '/dbm hud hide'."
L.HUD_USAGE	= {
	"Benutzung der "..L.DBM.."-HudMap:",
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
	"Benutzung des "..L.DBM.."-Pfeils:",
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

L.LAG_CHECKING				= "Prüfe Schlachtzuglatenz..."
L.LAG_HEADER					= L.DEADLY_BOSS_MODS.." - Latenzergebnisse"
L.LAG_ENTRY					= "%s: %dms (Welt) / %dms (Standort)"
L.LAG_FOOTER					= "Keine Antwort: %s"

L.DUR_CHECKING				= "Prüfe Schlachtzughaltbarkeit..."
L.DUR_HEADER					= L.DEADLY_BOSS_MODS.." - Haltbarkeitergebnisse"
L.DUR_ENTRY					= "%s: Haltbarkeit [%d Prozent] / Ausrüstung defekt [%s]"

--L.OVERRIDE_ACTIVATED					= "Configuration overrides have been activated for this encounter by RL"

--LDB
L.LDB_TOOLTIP_HELP1	= "Links-Klick, um "..L.DBM.." zu öffnen."
L.LDB_TOOLTIP_HELP2	= "Rechts-Klick, um das Konfigurationsmenü zu öffnen."
L.SILENTMODE_IS							= "stummer Modus ist "

L.WORLD_BUFFS.hordeOny		= "Mitglieder der Horde, Bewohner von Ogrimmar, kommt und sammelt euch um den Held der Horde zu feiern"
L.WORLD_BUFFS.allianceOny	= "Bürger und Verbündete Stormwinds, am heutigen Tage ist Geschichte geschrieben worden."
L.WORLD_BUFFS.hordeNef		= "NEFARIAN WURDE GETÖTET! Einwohner von Orgrimmar"
L.WORLD_BUFFS.allianceNef	= "Angehörige der Allianz, der Herrscher des Blackrocks wurde besiegt!"
L.WORLD_BUFFS.zgHeart		= "Nun ist nur noch ein letzter Schritt nötig, um uns von der Bedrohung des Seelenschinders zu befreien"
L.WORLD_BUFFS.zgHeartBooty	= "Der Blutgott, der Seelenschinder, wurde besiegt! Wir werden nicht länger unterdrückt!"
L.WORLD_BUFFS.zgHeartYojamba= "Beginnt mit dem Ritual, meine Diener. Wir müssen das Herz von Hakkar wieder in das Nichts verbannen!"
L.WORLD_BUFFS.rendHead		= "Rend Blackhand, der falsche Kriegshäuptling, ist gefallen!"
--L.WORLD_BUFFS.blackfathomBoon						= "boon of Blackfathom"

-- Annoying popup, especially for classic players
L.DBM_INSTALL_REMINDER_HEADER	= "Unvollständige DBM-Installation entdeckt!"
L.DBM_INSTALL_REMINDER_EXPLAIN	= "Willkommen in %s. DBM Mods für Bosse hier sind im %s welches nicht installiert ist. DBM wird keine Timer und Warnungen in dieser Zone anzeigen bis das %s installiert wird!"
L.DBM_INSTALL_REMINDER_DISABLE	= "Alle Warnungen und Timer in dieser Zone deaktivieren." -- Used when we believe it's a user error that the mod isn't installed (i.e., current raids)
L.DBM_INSTALL_REMINDER_DISABLE2 = "Diese Nachricht für dieses Paket nicht nochmal anzeigen." -- Used for unimportant mods, i.e., dungeons
L.DBM_INSTALL_REMINDER_DL_WAGO	= "Kopieren um von Wago.io herunterzuladen"
L.DBM_INSTALL_REMINDER_DL_CURSE	= "Kopieren um von Curse herunterzuladen"
L.DBM_INSTALL_PACKAGE_VANILLA	= "Vanilla und Season of Discovery Paket"
L.DBM_INSTALL_PACKAGE_DUNGEON	= "Dungeons, Delves und Events Paket"
