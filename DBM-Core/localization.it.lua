if GetLocale() ~= "itIT" then return end
DBM_CORE_NEED_SUPPORT				= "Sei bravo come programmatore? Se si, il team di DBM ha bisogno del tuo aiuto per mantenere DBM il miglior Boss Mod per WoW. Entra nel nostro gruppo visitando www.deadlybossmods.com o mandando un messaggio a tandanu@deadlybossmods.com or nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Benvenuto in DBM. Scrivi /dbm help per avere una lista dei comandi supportati. Per accedere alle opzioni scrivi in chat /dbm. Carica le zone specifiche per configurare manualmente ogni settaggio di ogni boss. DBM prova a farlo per te controllando la tua specializzazione alla prima esecuzione, ma alcuni potrebbero volere alcune opzioni attivate."

DBM_CORE_LOAD_MOD_ERROR				= "Errore nel caricamento del Boss Mod per %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Caricato '%s' mod. Per maggiori opzioni, scrivi /dbm o /dbm help in chat."
DBM_CORE_LOAD_GUI_ERROR				= "Non riesco a caricare la GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s ingaggiato. Buona fortuna e Divertiti! :)"
DBM_CORE_BOSS_DOWN					= "%s ucciso in %s!"
DBM_CORE_BOSS_DOWN_L				= "%s ucciso in %s! La tua ultima kill era durata %s, mentre la kill piu' veloce è di %s. Hai %d uccisioni in totale."
DBM_CORE_BOSS_DOWN_NR				= "%s ucciso in %s! NUOVO Record! (il vecchio era di %s). Hai %d uccisioni in totale."
DBM_CORE_COMBAT_ENDED_AT			= "Combattimento contro %s (%s) finito dopo %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Combattimento contro %s (%s) finito dopo %s. Hai %d sconfitte in questa difficolta'."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s e' stato ingaggiato %s fa, recupero dei timer..."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4secondo:secondi;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minuto:minuti;"
DBM_CORE_TIMER_FORMAT				= "%d |4minuto:minuti; e %d |4secondo:secondi;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "sec"
DBM_CORE_SEC_FMT					= "%d sec"
DBM_CORE_DEAD						= "Morto"
DBM_CORE_OK							= "Ok"

DBM_CORE_GENERIC_WARNING_BERSERK	= "Furia in %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Furia"
DBM_CORE_OPTION_TIMER_BERSERK		= "Visualizza Timer per $spell:26662"
DBM_CORE_OPTION_HEALTH_FRAME		= "Visualizza il frame della Vita del Boss"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barre"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Annunci"
DBM_CORE_OPTION_CATEGORY_MISC		= "Varie"

DBM_CORE_AUTO_RESPONDED						= "Auto-Risposto."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d Player vivi"
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s e' occupato contro %s (%s, %d/%d player vivi)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s ha sconfitto %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s ha sconfitto %s! L'ha gia' ucciso %d volte."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s e' stato ucciso da %s a %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s e' stato ucciso da %s a %s. Ha %d sconfitte in questa difficolta'."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versione"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM non installato"
DBM_CORE_VERSIONCHECK_FOOTER		= "%d giocatori hanno Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "La tua versione di Deadly Boss Mods e' obsoleta. Visita www.deadlybossmods.com per scaricare l'ultima versione."

DBM_CORE_UPDATEREMINDER_HEADER		= "La tua versione di Deadly Boss Mods e' obsoleta.\n La Versione %s (r%d) e' disponibile per il download:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Premi Ctrl-C per copiare il link."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Visualizza un pop-up quando e' disponibile una nuova versione."

DBM_CORE_MOVABLE_BAR				= "Trascinami!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h ti ha mandato un Timer DBM: '%2$s'\n|HDBM:cancella:%2$s:nil|h|cff3588ff[Cancella questo Timer]|r|h  |HDBM:ignora:%2$s:%1$s|h|cff3588ff[Ignora timer da %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Sei sicuro di voler ignorare i Timer DMB da %s per questa sessione?"
DBM_PIZZA_ERROR_USAGE				= "Uso: /dbm [broadcast] timer <time> <text>"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+click or right-click per muovere\nAlt+shift+click per trascinare liberamente"

DBM_CORE_RANGECHECK_HEADER			= "Monitor di Prossimita' (%d mt)"
DBM_CORE_RANGECHECK_SETRANGE		= "Imposta distanza"
DBM_CORE_RANGECHECK_SOUNDS			= "Souni"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Souna quando un giocatore e' in prossimita'"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Souna quando piu' giocatori sono in prossimita'"
DBM_CORE_RANGECHECK_SOUND_0			= "Nessun suono"
DBM_CORE_RANGECHECK_SOUND_1			= "Suono Standard"
DBM_CORE_RANGECHECK_SOUND_2			= "Beep Noioso"
DBM_CORE_RANGECHECK_HIDE			= "Nascondi"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d yd"
DBM_CORE_RANGECHECK_LOCK			= "Blocca la Finestra"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Finestre"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Visualizza il Radar"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Visualizza Finestra di Testo"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Visualizza entrambe le finestre"
DBM_CORE_RANGECHECK_OPTION_SPEED	= "Frequenza di Aggiornamento (Richiede Reload.)"
DBM_CORE_RANGECHECK_OPTION_SLOW		= "Lento (CPU Lente)"
DBM_CORE_RANGECHECK_OPTION_AVERAGE	= "Medio"
DBM_CORE_RANGECHECK_OPTION_FAST		= "Veloce (praticamente real-time)"
DBM_CORE_RANGERADAR_HEADER			= "Radar di Prossimita' (%d yd)"

DBM_CORE_INFOFRAME_LOCK				= "Blocca Finestra"
DBM_CORE_INFOFRAME_HIDE				= "Nascondi"
DBM_CORE_INFOFRAME_SHOW_SELF		= "Visualizza sempre la tua forza"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Invito LFG"

DBM_CORE_SLASHCMD_HELP				= {
	"Comandi Disponibili:",
	"/dbm version: Controlla la versione di tutti i giocatori dell'Incursione (alias: ver).",
--	"/dbm version2: Performs a raid-wide version check and whispers members who are out of date (alias: ver2).",
	"/dbm unlock: Visualizza una finestra mobile dei timer (alias: move).",
	"/dbm timer <x> <text>: Lancia un timer DBM da <x> secondi con il nome <text>.",
	"/dbm broadcast timer <x> <text>: Invia a tutti un Timer DBM da <x> secondi con il nome <text> (richiede CapoIncursione o Assistente).",
	"/dbm break <min>: Lancia un Timer di Pausa di <min> minuti. Da a tutti i giocatori un Timer DBM di pausa (richiede CapoIncursione o Assistente).",
	"/dbm pull <sec>: Avvia un Timer di Pull di <sec> secondi. Da' a tutti i giocatori un Timer DBM di Pull (richiede CapoIncursione o Assistente).",
	"/dbm arrow: Visualizza le Frecce DBM, vedi anche /dbm arrow help per i dettagli.",
	"/dbm lockout: Chiede a tutti i giocatori di linkare l'ID dell'incursione in cui sono salvati (aliases: lockouts, ids) (richiede CapoIncursione o Assistente).",
	"/dbm help: Visualizza questo messaggio."
}

DBM_ERROR_NO_PERMISSION				= "Non hai i permessi per eseguire questo comando."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Chiudi Finestra della Vita"

DBM_CORE_ALLIANCE					= "Alleanza"
DBM_CORE_HORDE						= "Orda"

DBM_CORE_UNKNOWN					= "sconosciuto"
DBM_CORE_LEFT						= "Left"--Translate
DBM_CORE_RIGHT						= "Right"--Translate
DBM_CORE_BACK						= "Back"--Translate
DBM_CORE_FRONT						= "Front"--Translate

DBM_CORE_BREAK_START				= "Pausa iniziata-- Hai %s minuto(i)!"
DBM_CORE_BREAK_MIN					= "La Pausa finisce tra %s minuto(i)!"
DBM_CORE_BREAK_SEC					= "La Pausa finisce tra %s secondi!"
DBM_CORE_TIMER_BREAK				= "Pausa!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "La Pausa e' Finita!"

DBM_CORE_TIMER_PULL					= "Inizio Combattimento"
DBM_CORE_ANNOUNCE_PULL				= "Inizio Combattimento in %d sec"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Ingaggiare ORA!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Uccisione Rapida"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s finisce" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s svanisce" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "%s CD"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "%s CD (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "%s CD: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next			= "Prossimo %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "Prossimo %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Prossimo %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Visualizza Timer per il debuff $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Visualizza Timer per il lancio di $spell:%s "
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Visualizza Timer per la durata di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Visualizza Timer quando $spell:%s svanisce dai Giocatori"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "Visualizza Timer per il tempo di recupero di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Visualizza Timer per il tempo di recupero di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Visualizza Timer per il tempo di recupero di $spell:%s (con il caster)" --Maybe better wording?
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Visualizza Timer per il prossimo/a $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Visualizza Timer per il prossimo/a $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Visualizza Timer per il prossimo/a $spell:%s (con il caster)" --Maybe better wording?
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Visualizza Timer per %s"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target			= "%s su >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d) su >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "%s rimanente: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast			= "Lancio di %s: %.1f sec"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon			= "%s imminente"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%s in %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase			= "Fase %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase		= "Fase %s imminente"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack			= "%s su >%%s< (%%d)"

local prewarnOption = "Visualizza un pre-Avvertimento per $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Announcia i bersagli di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Annuncia i bersagli di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Visualizza avvertimento per $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Annuncia quanto rimane di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast			= "Mostra un avviso quando sta per partire $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "Anuncia la fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase		= "Mostra un pre-Avvertimento per la Fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Mostra un Avviso per $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Annuncia l'accumulo di $spell:%s"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Mostra un Avviso Speciale per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Mostra un Avviso Speciale per dissipare/rubare $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Mostra un Avviso Speciale per interrompere $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Mostra un Avviso Speciale quando sei afflitto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Mostra un Avviso Speciale quando qualcuno e' afflitto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Mostra un Avviso Speciale quando qualcuno vicino a te e' afflitto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Mostra un Avviso Speciale quando sei afflitto da\n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Mostra un Avviso Speciale per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Mostra un Avviso Speciale per il lancio di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Mostra un Avviso Speciale per Accumuli >=%d di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "Mostra un Avviso Speciale per cambiare Bersaglio per $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel	= "%s su >%%s< - rimuovilo ora!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - interrompi >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you		= "%s su di te"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target	= "%s su >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close		= "%s su >%%s< vicino a te"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move		= "%s - Spostati"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run		= "%s - Corri Via!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast		= "%s - Smetti di Attaccare!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack		= "%s (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch	= ">%s< - Cambia Bersaglio"


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Imposta Icone sui bersagli di $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "Fai il suono \"muoviti\" per $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Esegui il conto alla rovescia per $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Esegui il conteggio per la durata di $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "Urla quando sei afflitto da $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "%s su di " .. UnitName("player") .. "!"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Avvisi Speciali Mobili"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Avvisi Speciali"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "Un monitor di prossimita' di %d metri non e' supportato in questa zona.\nLe distanze supportate sono 10, 11, 15 e 28 metri."

DBM_ARROW_MOVABLE					= "Frecce Mobili"
DBM_ARROW_ERROR_USAGE	= {
	"Utilizzo di DBM-Arrow:",
	"/dbm arrow <x> <y>  crea una freccia che punta in una direzione specifica (0 < x/y < 100)",
	"/dbm arrow <player>  crea una freccia che punta verso un giocatore specifico",
	"/dbm arrow hide  nasconde la freccia",
	"/dbm arrow move  rende la freccia mobile"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Miglior Uccisione"
DBM_SPEED_KILL_TIMER_OPTION	= "Visualizza un timer per battere il tuo record"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s ha richiesto di vedere l'ID e il progress della tua incursione.\nVuoi inviare questa informazione a %s? Potra' richiederti quest'informazione per tutta questa sessione (finche' non rilogghi)."
DBM_ERROR_NO_RAID					= "Devi essere in un Incursione per usare questa funzione."
DBM_INSTANCE_INFO_REQUESTED			= "Mandala richiesta di informazioni sul lock del gruppo di Incursione.\nVerra' chiesto a tutti il permesso di inviare questa informazione, quindi potrebbero passare alcuni secondi."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Ricevute le risposte di %d giocatori of %d utenti DBM : %d Dati inviati, %d richieste negate. Attendo qualche secondo per le altre %d risposte..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Ricevute le risposte da tutti."
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Mittente: %s Tipo di Risultato: %s Nome Incursione: %s ID: %s Difficulta': %d Dimensione: %d Progress: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, difficulta' %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progress %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    progress %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Hanno rifiutato la richiesta: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "In pausa: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Nessuna versione di DBM installata: %s"
DBM_INSTANCE_INFO_RESULTS			= "Risultati della Scansione ID di Incursione. Guarda che le istanze potrebbero essere riportate piu' volte se ci sono dei client di gioco localizzati nella tua incursione."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Players yet to respond: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Show results now]|r|h"
