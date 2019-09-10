if GetLocale() ~= "itIT" then return end
DBM_HOW_TO_USE_MOD					= "Benvenuto in DBM. Scrivi /dbm help per avere una lista dei comandi supportati. Per accedere alle opzioni scrivi in chat /dbm. Carica le zone specifiche per configurare manualmente ogni settaggio di ogni boss. DBM prova a farlo per te controllando la tua specializzazione alla prima esecuzione, ma alcuni potrebbero volere alcune opzioni attivate."
DBM_SILENT_REMINDER					= "Avviso: DBM è in modalità silente."

DBM_CORE_LOAD_MOD_ERROR				= "Errore nel caricamento della Boss Mod %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Caricate '%s' mod. Per opzioni quali avvisi sonori e avvertimenti personalizzati, digitare /dbm."
DBM_CORE_LOAD_MOD_COMBAT			= "Caricamento di '%s' rimandato al termine del combattimento"
DBM_CORE_LOAD_GUI_ERROR				= "Non riesco a caricare l'Interfaccia: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "L'Interfaccia non può essere inizializzata in combattimento, verrà caricata al termine dello stesso. Caricata, potrai aprirla anche in combattimento."
DBM_CORE_BAD_LOAD					= "DBM non è stato in grado di caricare completamente la mod in quanto in combattimento. Al termine dello stesso, esegui /console reloadui il prima possibile."
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s non può essere caricata in quanto DBM-Core non rispetta i requisiti. E' richiesta la versione aggiornata."
DBM_CORE_LOAD_MOD_EXP_MISMATCH		= "%s non può essere caricata in quanto è sviluppata per un'espansione di WoW non ancora disponibile. Quando diverrà disponibile, questa mod funzionerà."
DBM_CORE_LOAD_MOD_TOC_MISMATCH		= "%s non può essere caricata in quanto è sviluppata per una patch di WoW (%s) non ancora disponibile. Quando diverrà disponibile, questa mod funzionerà."
DBM_CORE_LOAD_MOD_DISABLED			= "%s è installata ma disabilitata. Questa mod non sarà caricata finchè non la abiliterai."
DBM_CORE_LOAD_MOD_DISABLED_PLURAL	= "%s sono installati ma disabilitati. Queste mod non saranno caricate finché non le abiliterai."

DBM_COPY_URL_DIALOG					= "Copia Indirizzo"

--Post Patch 7.1
DBM_CORE_NO_RANGE					= "Il Radar Distanziometro non può essere utilizzato nelle istanze. Verrà utilizzato il precedente riquadro testuale"
DBM_CORE_NO_ARROW					= "La Freccia non può essere usata nelle istanze"
DBM_CORE_NO_HUD						= "La HUDMap non può essere usata nelle istanze"

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM ha disabilitato il riquadro distanziometro per questo combattimento per insufficienti informazioni sulle distanze richieste con un gruppo di queste dimensioni."
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM ha disabilitato gli avvisi sulla quantità degli add per questo combattimento per insufficienti informazioni sul numero di add presenti con un gruppo di queste dimensioni."
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM ha disabilitato diverse funzionalità per questo combattimento per insufficienti informazioni su alcune meccaniche con un gruppo di queste dimensioni."

DBM_CORE_LOOT_SPEC_REMINDER			= "La tua spec è %s. Il bottino selezionato è %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM ha rilevato l'abilitazione delle icone incursioni sia in BigWigs che in DBM. Disabilita le icone in uno dei due per evitare conflitti"

DBM_CORE_MOD_AVAILABLE				= "%s è disponibile per questa ziona. E' possibile scaricare la mod da Curse/Twitch, WoWI o deadlybossmods.com"

DBM_CORE_COMBAT_STARTED				= "%s ingaggiato. Buona fortuna e Divertiti! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "Ingaggiato combattimento in corso contro %s. Buona fortuna e Divertiti! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "%s è stato ingaggiato dalla gilda"
DBM_CORE_SCENARIO_STARTED			= "%s iniziato. Buona fortuna e Divertiti! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "Unito allo scenario %s in corso. Buona fortuna e Divertiti! :)"
DBM_CORE_BOSS_DOWN					= "%s sconfitto in %s!"
DBM_CORE_BOSS_DOWN_I				= "%s sconfitto! Hai totalizzato %d vittorie."
DBM_CORE_BOSS_DOWN_L				= "%s sconfitto in %s! La tua ultima uccisione ha richiesto %s, quella più veloce %s. Hai totalizzato %d uccisioni."
DBM_CORE_BOSS_DOWN_NR				= "%s sconfitto in %s! E' un nuovo record! (Precedente di %s). Hai totalizzato %d uccisioni."
DBM_CORE_GUILD_BOSS_DOWN			= "%s è stato sconfitto dalla tua gilda dopo %s!"
DBM_CORE_SCENARIO_COMPLETE			= "%s completato dopo %s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "%s completato! Hai totalizzato %d completamenti."
DBM_CORE_SCENARIO_COMPLETE_L		= "%s completato dopo %s! Il tuo ultimo completamento ha richiesto %s e quello più veloce %s. Hai totalizzato %d completamenti."
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s completato dopo %s! E' un nuovo record! (Precedente di %s). Hai totalizzato %d completamenti."
DBM_CORE_COMBAT_ENDED_AT			= "Combattimento contro %s (%s) terminato dopo %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Combattimento contro %s (%s) terminato dopo %s. Sei stato eliminato %d volte a questa difficoltà."
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "La gilda è stata eliminata da %s (%s) dopo %s."
DBM_CORE_SCENARIO_ENDED_AT			= "%s è terminato dopo %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s è terminato dopo %s. Hai totalizzato %d fallimenti a questa difficoltà."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s è stato ingaggiato %s fa, ripristino temporizzatori..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Avviato registro di Transcriptor."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Terminato registro di Transcriptor."

DBM_CORE_MOVIE_SKIPPED				= "DBM ha tentato di saltare automaticamente un filmato."
DBM_CORE_BONUS_SKIPPED				= "DBM ha chiuso automaticamente il riquadro del bottino bonus. Se richiesto, è possibile riaprirlo digitando /dbmbonusroll entro 3 minuti"
DBM_CORE_BONUS_EXPIRED				= "Hai utilizzato /dbmbonusroll per mostrare il riquadro del bottino bonus, ma non sono presenti bonus disponibili."

DBM_CORE_AFK_WARNING				= "Sei AFK e in combattimento (%d percento di vita rimanente), esecuzione avviso sonoro. Se non sei AFK, togliti dallo stato AFK flag o disabilita questa opzione in 'funzionalità aggiuntive'."

DBM_CORE_COMBAT_STARTED_AI_TIMER	= "Il mio processore fa parte di una rete neurale. (Questo combattimento utilizzerà la nuova funzione Temporizzatore IA per generare approssimazioni sulla temporizzazione)"

DBM_CORE_PROFILE_NOT_FOUND			= "<DBM> Il tuo profilo attuale è corrotto. DBM caricherà il profilo 'Predefinito'."
DBM_CORE_PROFILE_CREATED			= "Profilo '%s' creato."
DBM_CORE_PROFILE_CREATE_ERROR		= "Creazione profilo fallita. Nome profilo non valido."
DBM_CORE_PROFILE_CREATE_ERROR_D		= "Creazione profilo fallita. Il profilo '%s' esistente."
DBM_CORE_PROFILE_APPLIED			= "Profilo '%s' applicato."
DBM_CORE_PROFILE_APPLY_ERROR		= "Applicazione profilo fallita. Il profilo '%s' non esiste."
DBM_CORE_PROFILE_COPIED				= "Profilo '%s' copiato."
DBM_CORE_PROFILE_COPY_ERROR			= "Copia profilo fallita. Il profilo '%s' non esiste."
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "Impossibile copiare il profilo su se stesso."
DBM_CORE_PROFILE_DELETED			= "Profilo '%s' eliminato. Verrà applicato il profilo 'Predefinito'."
DBM_CORE_PROFILE_DELETE_ERROR		= "Cancellazione prodilo fallita. Il profilo '%s' non esiste."
DBM_CORE_PROFILE_CANNOT_DELETE		= "Impossibile eliminare il profilo 'Predefinito'."
DBM_CORE_MPROFILE_COPY_SUCCESS		= "Le impostazioni mod di %s (spec %d) sono state copiate."
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "Impossibile copiare le impostazioni personaggio sullo stesso"
DBM_CORE_MPROFILE_COPY_S_ERROR		= "Sorgente corrotta. Impostazioni non copiate o parziali. Copia fallita."
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "Le impostazioni sonore o le note di %s (spec %d) sono state copiate."
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "Impossibile copiare i suoni o le note personaggio sullo stesso"
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "Sorgente corrotta. Impostazioni sonore o note non copiate o parziali. Copia fallita."
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "Impostazioni mod di %s (spec %d) eliminate."
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "Impossibile eliminare impostazioni mod in uso."
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "Sorgente corrotta. Impostazioni non cancellate o parziali. Cancellazione fallita."

DBM_CORE_NOTE_SHARE_SUCCESS			= "%s ha condiviso le sue note per %s"
DBM_CORE_NOTE_SHARE_FAIL			= "%s ha tentato di condividere una nota testuale con te per %s. Tuttavia, la mod associata con questa abilità non è installata o non è caricata. Se necessiti di questa nota, assicurati di caricare la mod che usano per le note e chiedi di condividerla nuovamente"

DBM_CORE_NOTEHEADER					= "Scrivi il testo della tua nota per %s. Racchiudendo i nomi giocatori con >< li colorerà in base alla classe. Per avvisi richiamati più volte, separare le note con '/'"
DBM_CORE_NOTEFOOTER					= "Premi 'Ok' per accettare le modifiche o 'Annulla' per declinarle"
DBM_CORE_NOTESHAREDHEADER			= "%s ha condiviso la seguente nota testuale per %s. Se accetti, sovrascriverà la tua attuale nota"
DBM_CORE_NOTESHARED					= "Le tue note sono state inviate al gruppo"
DBM_CORE_NOTESHAREERRORSOLO			= "Solitario? Non dovresti passarti le tue stesse note"
DBM_CORE_NOTESHAREERRORBLANK		= "Impossibile condividere note in bianco"
DBM_CORE_NOTESHAREERRORGROUPFINDER	= "Le note non possono essere condivise nei CdB, Ricerca Incursioni o Spedizioni"
DBM_CORE_NOTESHAREERRORALREADYOPEN	= "Impossibile aprire il collegamento a una nota condivisa mentre è aperto l'editor al fine di prevenire la perdita della nota attualmente in modifica"

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "Le opzioni predefinite delle mod di quest'istanza sono state caricate."
DBM_CORE_ALLMOD_STATS_RESETED		= "Le statistiche della mod sono state resettate."
DBM_CORE_MOD_DEFAULT_LOADED			= "Le opzioni predefinite del combattimento sono state caricate."
DBM_CORE_SOUNDKIT_MIGRATION			= "Uno o più avvisi/avvisi speciali sonori sono stati ripristinati a causa di incompatibilità con la patch 8.2 e successive. DBM supporta solo file sonori nella cartella addons o ID SoundKit per riprodurre contenuti multimediali"

DBM_CORE_WORLDBOSS_ENGAGED			= "%s è stato probabilmente ingaggiato sul reame con il %s di vita. (Inviato da %s)"
DBM_CORE_WORLDBOSS_DEFEATED			= "%s è stato probabilmente sconfitto sul reame (Inviato da %s)."

DBM_CORE_TIMER_FORMAT_SECS			= "%.2f |4secondo:secondi;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minuto:minuti;"
DBM_CORE_TIMER_FORMAT				= "%d |4minuto:minuti; e %.2f |4secondo:secondi;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "sec"
DBM_CORE_SEC_FMT					= "%s sec"

DBM_CORE_GENERIC_WARNING_OTHERS		= "e un altro"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "e %d altri"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Furia tra %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Furia"
DBM_CORE_OPTION_TIMER_BERSERK		= "Visualizza Temporizzatore $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Inizio combattimento"
DBM_CORE_OPTION_TIMER_COMBAT		= "Mostra temporizzatore inizio combattimento"
-- DBM_CORE_BAD						= "Bad"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barre"
-- Sottocategorie per l'oggetto "annunci"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "Annunci Generali"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "Annunci Personali"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "Annunci Bersaglio"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "Annunci Ruolo"

DBM_CORE_OPTION_CATEGORY_SOUNDS			= "Souni"
-- Oggetti vari spezzati in sottocategorie
DBM_CORE_OPTION_CATEGORY_DROPDOWNS		= "Tendine" -- Still put in MISC sub group, just used for line separators since multiple of these on a fight (or even having on of these at all) is rare.
DBM_CORE_OPTION_CATEGORY_YELLS			= "Urla"
DBM_CORE_OPTION_CATEGORY_NAMEPLATES		= "Barre dei Nomi"
DBM_CORE_OPTION_CATEGORY_ICONS			= "Icone"

DBM_CORE_AUTO_RESPONDED						= "Risposta Automatica."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d Giocatori vivi"
-- Boss
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s sta combattendo %s (%s, %d/%d giocatori vivi)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s ha sconfitto %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s ha sconfitto %s! Hanno totalizzato %d vittorie."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s ha subito una disfatta da %s al %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s ha subito una disfatta da %s al %s. Ha totalizzato %d disfatte in questa difficoltà."
-- Scenari (Senza percentuali. parole come "combattimento" o "eliminato" modificate per maggiore aderenza agli scenari)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s è occupato con %s (%d/%d persone vive)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s ha completato %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s ha completato %s! Ha totalizzato %d vittorie."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s non ha completato %s"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s non ha completato %s. Ha totalizzato %d total disfatte in questa difficoltà."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versione"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (%s)"
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) e %s (%s)" -- Due Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM non installato"
DBM_CORE_VERSIONCHECK_FOOTER		= "%d giocatori hanno Deadly Boss Mods"
DBM_CORE_VERSIONCHECK_OUTDATED		= "I seguenti %d giocatore/i hanno una versione obsoleta delle boss mod: %s"
DBM_CORE_YOUR_VERSION_OUTDATED      = "La tua versione di Deadly Boss Mods è obsoleta. Visita http://www.deadlybossmods.com per ottenere l'ultima versione."
DBM_CORE_VOICE_PACK_OUTDATED		= "Il pacchetto vocale selezionato non contiene alcuni suoni supportati da DBM. Alcuni avvisi sonori verranno eseguiti con i suoni predefiniti. Scarica una nuova versione del pacchetto vocale o contatta l'autore per un aggiornamento contenente l'audio mancante"
DBM_CORE_VOICE_MISSING				= "Hai selezionato un pacchetto vocale DBM non trovato. Se è un errore, assicurati che il pacchetto vocale sia correttamente installato e abilitato negli addon."
DBM_CORE_VOICE_DISABLED				= "Hai almeno un pacchetto vocale DBM installato ma nessuno abilitato. Se desideri usare un pacchetto vocale, assicurati che sia selezionato in 'Avvisi Parlati', altrimenti disinstalla i pacchetti vocali inutilizzati per nascondere questo messaggio"
DBM_CORE_VOICE_COUNT_MISSING		= "Conto alla rovescia %d è impostato su un pacchetto vocale/conteggio non trovato. E' stato reimportato all'opzione predefinita: %s."
DBM_BIG_WIGS						= "BigWigs"

DBM_CORE_UPDATEREMINDER_HEADER		= "La tua versione di Deadly Boss Mods e' obsoleta.\n La Versione %s (%s) e' disponibile per il download su Curse/Twitch, WoWI o da deadlybossmods.com"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Premi " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  .. " per copiare il link di download negli appunti."
DBM_CORE_UPDATEREMINDER_FOOTER		= "Premi " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  .. " per copiare il link negli appunti."

DBM_CORE_UPDATEREMINDER_DISABLE			= "AVVISO: A causa della notevole obsolescenza, Deadly Boss Mods è stato forzatamente disabilitato e non può essere utilizzato fino all'aggiornamento. Questo per assicurarsi che vecchio e incompatibile codice non causi problemi a te e al tuo gruppo."
DBM_CORE_UPDATEREMINDER_NODISABLE		= "AVVISO: La tua installazione di Deadly Boss Mods è nettamente obsoleta. Anche se hai disabilitato le notifiche di aggiornamento, questo messaggio appare dopo un certo periodo e non può essere disabilitato. E' ALTAMENTE consigliato l'aggiornamento."
DBM_CORE_UPDATEREMINDER_HOTFIX			= "La versione DBM in uso ha problemi con il combattimento di questo boss che sono stati corretti con l'ultima versione aggiornata"
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= "La versione DBM in uso ha problemi con il combattimento di questo boss che sono stati corretti con la prossima versione in arrivo (o nella versione alfa)"
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "AVVISO: Data l'obsolescenza di Deadly Boss Mods, DBM è stato disabilitato fino ad aggiornamento, trattandosi di una patch maggiore. Questo è per assicurarsi che il vecchio e incompatibile codice non causi problemi a te o al tuo gruppo. Assicurati di scaricare una nuova versione da deadlybossmods.com, Curse/Twitch o WoWI il prima possibile."
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "AVVISO: Stai utilizzando una versione di Deadly Boss Mods non prevista per questa versione del gioco. Assicurati di scaricare la versione appropriata per il tuo client di gioco da deadlybossmods.com, Curse/Twitch o WoWI."
DBM_CORE_VEM							= "AVVISO: Stai eseguento sia Deadly Boss Mods che Voice Encounter Mods. DBM non funzionerà con questa configurazione e quindi non verrà caricato."
DBM_CORE_3RDPROFILES					= "AVVISO: DBM-Profiles è incompatibile con questa versione di DBM. Deve essere rimosso per utilizzare DBM, per evitare conflitti."
DBM_CORE_DPMCORE						= "AVVISO: Deadly PvP mods è discontinuato e incompatibile con questa versione di DBM. Deve essere rimosso per utilizzare DBM, per evitare conflitti."
DBM_CORE_DBMLDB							= "AVVISO: DBM-LDB è ora incluso in DBM-Core. Anche se non dannoso, è consigliabile rimuovere 'DBM-LDB' dalla cartella addon"
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "AVVISO: Questo aggiornamento DBM non funzionerà correttamente a meno di un riavvio del gioco. Questo aggiornamento contiene nuovi file o modifiche al file .toc che non possono essere caricate con ReloadUI. Potresti avere malfunzionamenti o errori se continui senza riavviare."
DBM_CORE_OUT_OF_DATE_NAG				= "La versione di Deadly Boss Mods è obsoleta. E' consigliabile aggiornare per questo combattimento in modo da non perdere importanti avvisi, temporizzatori o urlare al resto del raid cose importanti."
DBM_CORE_RETAIL_ONLY					= "AVVISO: Questa versione di DBM è da utilizzare con l'ultima versione retail di World of Warcraft. Disinstallala e installa quella per WoW Classic."

DBM_CORE_MOVABLE_BAR				= "Trascinami!"

-- DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h ti ha mandato un Timer DBM: '%2$s'\n|HDBM:cancella:%2$s:nil|h|cff3588ff[Cancella questo Timer]|r|h  |HDBM:ignora:%2$s:%1$s|h|cff3588ff[Ignora timer da %1$s]|r|h"
DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h ti ha inviato un temporizzatore DBM"
DBM_PIZZA_CONFIRM_IGNORE			= "Sei sicuro di voler ignorare i Timer DMB da %s per questa sessione?"
DBM_PIZZA_ERROR_USAGE				= "Uso: /dbm [broadcast] timer <time> <text>"

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods" -- (Identico all'Inglese)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Tieni premuto Shift per trascinare liberamente"

DBM_CORE_RANGECHECK_HEADER			= "Distanziometro (%dD)"
DBM_CORE_RANGECHECK_HEADERT			= "Distanziometro (%dD-%dP)"
DBM_CORE_RANGECHECK_RHEADER			= "Distanziometro Inverso (%dD)"
DBM_CORE_RANGECHECK_RHEADERT		= "Distanziometro Inverso (%dD-%dP)"
DBM_CORE_RANGECHECK_SETRANGE		= "Imposta distanza"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "Imposta soglia giocatore"
DBM_CORE_RANGECHECK_SOUNDS			= "Souni"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Souna quando un giocatore e' in prossimita'"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Souna quando piu' giocatori sono in prossimita'"
DBM_CORE_RANGECHECK_SOUND_0			= "Nessun suono"
DBM_CORE_RANGECHECK_SOUND_1			= "Suono Standard"
DBM_CORE_RANGECHECK_SOUND_2			= "Beep Noioso"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d D"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Riquadri"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Visualizza Riquadro Radar"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Visualizza Riquadro Testuale"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Visualizza Entrambi i Riquadri"
DBM_CORE_RANGERADAR_HEADER			= "Distanza:%d Giocatori:%d"
DBM_CORE_RANGERADAR_RHEADER			= "Dist.Inv:%d Giocatori:%d"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d vicini (%dD)" -- Multi
DBM_CORE_RANGECHECK_IN_RANGE_TEXT	= "%d vicini" -- Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fD)" -- One target

DBM_CORE_INFOFRAME_SHOW_SELF		= "Visualizza sempre la tua forza"		-- Always show your own power value even if you are below the threshold
DBM_CORE_INFOFRAME_SETLINES			= "Imposta linee massime"
DBM_CORE_INFOFRAME_LINESDEFAULT		= "Imposta per mod"
DBM_CORE_INFOFRAME_LINES_TO			= "%d linee"
DBM_CORE_INFOFRAME_POWER			= "Forza"
DBM_CORE_INFOFRAME_AGGRO			= "Aggro"
DBM_CORE_INFOFRAME_MAIN				= "Principale:"--Main power
DBM_CORE_INFOFRAME_ALT				= "Alt:"--Alternate Power

DBM_LFG_INVITE						= "Invito LFG"

DBM_CORE_SLASHCMD_HELP				= {
	"Comandi Disponibili:",
	"-----------------",
	"/dbm unlock: Mostra un temporizzatore mobile (alias: move).",
	"/range <numero> o /distance <numero>: Mostra distanziometro. /rrange o /rdistance per colori invertiti.",
	"/hudar <number>: Mostra Distanziometro a HUD.",
	"/dbm timer: Avvia temporizzatore DBM personalizzato, vedi '/dbm timer' per dettagli.",
	"/dbm arrow: Mostra la freccia DBM, vedi '/dbm arrow help' per dettagli.",
	"/dbm hud: Mostra l'HUD DBM, vedi '/dbm hud' per dettagli.",
	"/dbm help2: Mostra i comandi per gestione incursione"
}
DBM_CORE_SLASHCMD_HELP2				= {
	"Comandi Disponibili:",
	"-----------------",
	"/dbm pull <sec>: Avvia un temporizzatore per pull di <sec> secondi all'incursione (richiede assist. alias: pull).",
	"/dbm break <min>: Avvia un temporizzatore per pause di <min> minuti all'incursione (richiede assist. alias: break).",
	"/dbm version: Verifica la versione delle boss mod (alias: ver).",
	"/dbm version2: Verifica la versione delle boss mod e invia un messaggio a quelli con versioni obsolete(alias: ver2).",
	"/dbm lockout: Richiede ai membri dell'incursione lo stato delle istanze (aliases: lockouts, ids) (richiede assist).",
	"/dbm lag: Esegue il controllo di latenza sull'incursione.",
	"/dbm durability: Esegue il controllo stato equip sull'incursione."
}
DBM_CORE_TIMER_USAGE	= {
	"Comandi Temporizzatore DBM:",
	"-----------------",
	"/dbm timer <sec> <testo>: Avvia un temporizzatore di <sec> secondi con il testo <testo>.",
	"/dbm ltimer <sec> <testo>: Avvia un temporizzatore a ciclo continuo fino ad annullamento.",
	"(Il prefisso 'Broadcast' di qualunque temporizzatore lo condivide se capogruppo/assistente)",
	"/dbm timer endloop: Termina il ciclo di un ltimer."
}

DBM_ERROR_NO_PERMISSION				= "Non hai i permessi per eseguire questo comando."

--Common Locals
DBM_NEXT							= "Avanti %s"
DBM_COOLDOWN						= "%s CD"
DBM_CORE_UNKNOWN					= "sconosciuto" -- UNKNOWN which is "Unknown" (does u vs U matter?)
DBM_CORE_LEFT						= "Sinistra"
DBM_CORE_RIGHT						= "Destra"
DBM_CORE_BOTH						= "Entrambi"
DBM_CORE_BACK						= "Indietro"--BACK
DBM_CORE_SIDE						= "Lato"
DBM_CORE_TOP						= "Cima"
DBM_CORE_BOTTOM						= "Fondo"
DBM_CORE_MIDDLE						= "Mezzo"
DBM_CORE_FRONT						= "Fronte"
DBM_CORE_EAST						= "Est"
DBM_CORE_WEST						= "Ovest"
DBM_CORE_NORTH						= "Nord"
DBM_CORE_SOUTH						= "Sud"
DBM_CORE_INTERMISSION				= "Interfase" -- No blizz global for this, and will probably be used in most end tier fights with intermission phases
DBM_CORE_ORB						= "Sfera"
DBM_CHEST							= "Cassa" -- As in Treasure 'Chest'. Not Chest as in body part.
DBM_NO_DEBUFF						= "No %s"--For use in places like info frame where you put "Not Spellname"
DBM_ALLY							= "Alleato" -- Such as "Move to Ally"
DBM_ADD								= "Add" -- A fight Add as in "boss spawned extra adds"
DBM_ADDS							= "Adds"
DBM_BIG_ADD							= "Add Grande"
DBM_BOSS							= "Boss"
DBM_CORE_ROOM_EDGE					= "Bordo Stanza"
DBM_CORE_FAR_AWAY					= "Lontano"
DBM_CORE_BREAK_LOS					= "Interrompi LOS"
DBM_CORE_RESTORE_LOS				= "Ripristina/Mantieni LOS"
DBM_CORE_SAFE						= "Sicuro"
DBM_CORE_NOTSAFE					= "Non Sicuro"
DBM_CORE_SHIELD						= "Scudo"
DBM_INCOMING						= "%s in Arrivo"
--Common Locals end

DBM_CORE_BREAK_USAGE				= "Il temporizzatore della pausa non può durare più di 60 minuti. Assicurati di aver inserito il tempo in minuti e non in secondi."
DBM_CORE_BREAK_START				= "Inizia la pausa -- hai %s! (Iniziata da %s)"
DBM_CORE_BREAK_MIN					= "La pausa termina tra %s minuto/i!"
DBM_CORE_BREAK_SEC					= "La pausa termina tra %s secondi!"
DBM_CORE_TIMER_BREAK				= "Ora della pausa!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "La pausa è finita dopo %s"

DBM_CORE_TIMER_PULL					= "Ingaggio"
DBM_CORE_ANNOUNCE_PULL				= "Ingaggio tra %d s (Iniziato da %s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Ingaggia ora!"
DBM_CORE_ANNOUNCE_PULL_TARGET		= "Ingaggio di %s tra %d s. (Iniziato da %s)"
DBM_CORE_ANNOUNCE_PULL_NOW_TARGET	= "Ingaggia %s ora!"
DBM_CORE_GEAR_WARNING				= "Avviso: Controllo equip. L'ilvl equipaggiato è inferiore a quello in borsa"
DBM_CORE_GEAR_WARNING_WEAPON		= "Avviso: Controlla di aver equipaggiato l'arma corretta."
DBM_CORE_GEAR_FISHING_POLE			= "Canna da Pesca"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Uccisione Rapida" -- BATTLE_PET_SOURCE_6 -- TODO:CHECK

-- Localizzazioni Temporizzatori Autogenerate
-- DBM_CORE_AUTO_ANNOUNCE_TEXTS - INIZIO
DBM_CORE_AUTO_ANNOUNCE_TEXTS.you			= "%s su di TE"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target			= "%s su >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetsource	= ">%%s< casta %s su >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) su >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends 			= "%s terminato"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget		= "%s terminato: >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades			= "%s svanito"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "%s rimanenti: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast			= "Castando %s: %.1f s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon			= "%s a breve"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.sooncount		= "%s (%%s) a breve"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%s tra %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.bait			= "%s a breve - attiralo ora"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage			= "Fase %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prestage		= "Fase %s a breve"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack			= "%s su >%%s< (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.moveto			= "%s - vai a >%%s<"
-- DBM_CORE_AUTO_ANNOUNCE_TEXTS - FINE

local prewarnOption = "Mostra preavvisi per $spell:%s"
-- DBM_CORE_AUTO_ANNOUNCE_OPTIONS - INIZIO
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.you			= "Annuncia quando affetto da $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Annuncia bersagli di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetsource	= "Annuncia bersagli di $spell:%s (con sorgente)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Annuncia bersagli di $spell:%s (con conteggio)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Mostra avvisi per $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends			= "Mostra avviso al termine di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget	= "Mostra avviso al termine di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Mostra avviso allo svanire di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Annuncia la quantità di $spell:%s rimanenti"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast			= "Mostra avviso al cast di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.sooncount	= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.bait			= "Mostra preavvisi (per attirare) per $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stage		= "Annuncia Fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stagechange	= "Annuncia cambi fase"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prestage		= "Mostra preavviso per la Fase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Mostra avviso per $spell:%s (con conteggio)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Annuncia stack di $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.moveto		= "Mostra avvisi per muoverti da qualcuno o qualcosa per $spell:%s"
-- DBM_CORE_AUTO_ANNOUNCE_OPTIONS - FINE

-- DBM_CORE_AUTO_SPEC_WARN_TEXTS - INIZIO
DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends				= "%s terminata"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s svanita"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "%s a breve"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.sooncount			= "%s (%%s) a breve"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.bait				= "%s a breve - attiralo subito"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s tra %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel			= "%s su >%%s< - dispellalo subito"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - interrompi >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - interrompi >%%s<! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you				= "%s su di te"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) su di te"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youpos			= "%s (Posizione: %%s) su di te"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Entra in Posizione: %%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target			= "%s su >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) su >%%s< "
DBM_CORE_AUTO_SPEC_WARN_TEXTS.defensive			= "%s - difensivi"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= "%s su >%%s< - tauntalo subito"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close				= "%s su >%%s< vicino a te"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move				= "%s - spostati"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.keepmove			= "%s - continua a muoverti"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stopmove			= "%s - fermo"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge				= "%s - evita l'attacco"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgecount		= "%s (%%s) - evita l'attacco"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgeloc			= "%s - evita da %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - spostati dagli altri"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveawaycount		= "%s (%%s) - spostati dagli altri"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - spostati a >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soak				= "%s - entraci"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.jump				= "%s - salta"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run				= "%s - scappa"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast				= "%s - interrompi il cast"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.lookaway			= "%s su %%s - distogli lo sguardo"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect			= "%s su >%%s< - interrompi l'attacco"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count				= "%s! (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack				= "%%d stack di %s su di te"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch			= "%s - cambio bersaglio"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - cambio bersaglio (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.gtfo				= "%%s sotto di te - spostati"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.adds				= "Add in Arrivo - cambio bersaglio"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.addscustom		= "Add in Arrivo - %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetchange		= "Cambio Bersaglio - passa a %%s"
-- DBM_CORE_AUTO_SPEC_WARN_TEXTS - FINE

-- Auto-generated Special Warning Localizations
-- DBM_CORE_AUTO_SPEC_WARN_OPTIONS - Inizio
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 			= "Mostra avviso speciale per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 			= "Mostra avviso speciale al termine di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 			= "Mostra avviso speciale allo svanire di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 			= "Mostra preavviso speciale per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.sooncount		= "Mostra preavviso speciale (con conteggio) per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.bait			= "Mostra preavviso speciale (per attirare) per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Mostra preavviso speciale di %s secondi prima di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 			= "Mostra avviso speciale per dispel di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt		= "Mostra avviso speciale per interruzione di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Mostra avviso speciale (con conteggio) per interrompere $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 			= "Mostra avviso speciale quando affetto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youcount		= "Mostra avviso speciale (con conteggio) quando affetto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youpos			= "Mostra avviso speciale (con posizione) quando affetto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soakpos			= "Mostra avviso speciale (con posizione) per entrare dagli affetti da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 			= "Mostra avviso speciale quando qualcuno è affetto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Mostra avviso speciale (con conteggio) quando qualcuno è affetto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.defensive 		= "Mostra avviso speciale per usare i difensivi con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 			= "Mostra avviso speciale per tautare quando l'altro difensore è affetto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 			= "Mostra avviso speciale quando qualcuno vicino è affetto da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 			= "Mostra avviso speciale per spostarti da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Mostra avviso speciale per continuare a muoverti con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Mostra avviso speciale per fermarti con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 			= "Mostra avviso speciale per evitare $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgecount		= "Mostra avviso speciale (con conteggio) per evitare $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "Mostra avviso speciale (con posizione) per evitare $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway		= "Mostra avviso speciale per spostarsi dagli altri con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "Mostra avviso speciale (con conteggio) per spostarsi dagli altri con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto			= "Mostra avviso speciale per muoverti verso qualcuno o qualcosa per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soak			= "Mostra avviso speciale per entrare in $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.jump			= "Mostra avviso speciale per muoverti per saltare per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 			= "Mostra avviso speciale per sfuggire da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 			= "Mostra avviso speciale per interrompere il cast per $spell:%s" -- Interruzione Abilità
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.lookaway		= "Mostra avviso speciale per distogliere lo sguardo da $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 		= "Mostra avviso speciale per interrompere gli attacchi con $spell:%s" -- Riflesso Abilità
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 			= "Mostra avviso speciale (con conteggio) per $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 			= "Mostra avviso speciale quando affetto da >= %d stack di $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch			= "Mostra avviso speciale per cambiare bersaglio con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount		= "Mostra avviso speciale (con conteggio) per cambiare bersaglio con $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Mostra avviso speciale per spostarsi dalle schifezze a terra"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.adds			= "Mostra avviso speciale per cambiare bersaglio per l'arrivo di add"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.addscustom		= "Mostra avviso speciale per l'arrivo di add"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetchange	= "Mostra avviso speciale per cambio bersaglio prioritario"
-- DBM_CORE_AUTO_SPEC_WARN_OPTIONS - FINE

-- Localizzazioni Temporizzatori Autogenerate
-- DBM_CORE_AUTO_TIMER_TEXTS - INIZIO
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.cast			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.castcount		= "%s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s terminato" -- Buff/Debuff/Eventi su boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s svanito" -- Buff/Debuff su giocatori
DBM_CORE_AUTO_TIMER_TEXTS.ai			= "%s IA"
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "%s CD"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "%s CD (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "%s CD: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial		= "CD Speciale"
DBM_CORE_AUTO_TIMER_TEXTS.next			= "Prossimo %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "Prossimo %s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Prossimo %s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial	= "Prossimo Speciale"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.stage			= "Prossima Fase"
DBM_CORE_AUTO_TIMER_TEXTS.adds			= "Add in Arrivo"
DBM_CORE_AUTO_TIMER_TEXTS.addscustom	= "Add in Arrivo (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.roleplay		= GUILD_INTEREST_RP
-- DBM_CORE_AUTO_TIMER_TEXTS - FINE

-- DBM_CORE_AUTO_TIMER_OPTIONS - INIZIO
DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Mostra temporizzatore debuff di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Mostra temporizzatore cast di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.castcount	= "Mostra temporizzatore (con conteggio) cast di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.castsource	= "Mostra temporizzatore (con sorgente) cast di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Mostra temporizzatore durata di $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Mostra temporizzatore allo svanire di $spell:%s dai giocatori"
DBM_CORE_AUTO_TIMER_OPTIONS.ai			= "Mostra temporizzatore AI ricarica $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "Mostra temporizzatore ricarica $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Mostra temporizzatore ricarica cooldown $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Mostra temporizzatore (con sorgente) ricarica $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial	= "Mostra temporizzatore ricarica dell'abilità speciale"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Mostra temporizzatore prossima $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Mostra temporizzatore prossima $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Mostra temporizzatore (con sorgente) per prossima $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial	= "Mostra temporizzatore prossima abilità speciale"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Mostra temporizzatore %s"
DBM_CORE_AUTO_TIMER_OPTIONS.stage		= "Mostra temporizzatore per prossima fase"
DBM_CORE_AUTO_TIMER_OPTIONS.adds		= "Mostra temporizzatore add in arrivo"
DBM_CORE_AUTO_TIMER_OPTIONS.addscustom	= "Mostra temporizzatore add in arrivo"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay	= "Mostra temporizzatore durata gioco di ruolo"
-- DBM_CORE_AUTO_TIMER_OPTIONS - FINE


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Imposta icone sui bersagli di $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Imposta icone su $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "Mostra la Freccia DBM per muoversi verso i bersagli affetti da $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "Mostra la Freccia DBM per scansarsi dai bersagli affetti da $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "Mostra la Freccia DBM per muoversi verso località specifiche per $spell:%s"
-- DBM_CORE_AUTO_YELL_OPTION_TEXT - INIZIO
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortyell	= "Urla quando affetto da $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yell			= "Urla (con nome giocatore) quando affetto da $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.count		= "Urla (con conteggio) quando affetto da $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.fade			= "Urla (con conto alla rovescia e nome abilità) allo svanire di $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortfade	= "Urla (con conto alla rovescia) allo svanire di $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.iconfade		= "Urla (con conto alla rovescia ed icona) allo svanire di $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.position		= "Urla (con posizione) quando affetto da $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.combo		= "Urla (con testo personalizzato) quando affetto da $spell:%s e altre allo stesso tempo"
-- DBM_CORE_AUTO_YELL_OPTION_TEXT - FINE
-- DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT - INIZIO
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell		= "%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell			= "%s su " .. UnitName("player")
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.count			= "%s su " .. UnitName("player") .. " (%%d)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.fade			= "%s svanisce tra %%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortfade		= "%%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.iconfade		= "{rt%%2$d}%%1$d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.position 		= "%s %%s su {rt%%d}"..UnitName("player").."{rt%%d}"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.combo			= "%s e %%s" -- Nome abilità (da opzioni, più nome abilità passata in arg)
-- DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT - FINE
DBM_CORE_AUTO_YELL_CUSTOM_POSITION		= "{rt%d}%s"--Doesn't need translating. Has no strings
DBM_CORE_AUTO_YELL_CUSTOM_POSITION2		= "{rt%d}%s{rt%d}"--Doesn't need translating. Has no strings
DBM_CORE_AUTO_YELL_CUSTOM_FADE			= "%s svanito"
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "Mostra la HudMap per l'abilità $spell:%s (Dismessa)"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "Mostra la HudMap per varie meccaniche (Dismessa)"
DBM_CORE_AUTO_NAMEPLATE_OPTION_TEXT		= "Mostra l'Aura della Barra del Nome per $spell:%s"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Mostra distanziometro (%s) per $spell:%s" -- string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Mostra distanziometro (%s)" -- For when a range frame is just used for more than one thing
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "Mostra distanziometro invertito (%s) per $spell:%s" -- Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "Mostra distanziometro invertito (%s)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Mostra riquadro informativo per $spell:%s"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT2	= "Mostra riquadro informativo per la panoramica scontro"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Riproduti il suono controllo gruppo al pull del boss (anche se non bersagliato)"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "Annunci mobili"
DBM_CORE_MOVE_WARNING_MESSAGE		= "Grazie per utilizzare Deadly Boss Mods"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Avvisi speciali mobili"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Avvisi Speciali"

DBM_CORE_HUD_INVALID_TYPE			= "Tipo invalido di HUD definito"
DBM_CORE_HUD_INVALID_TARGET			= "Nessun bersaglio valido dato per l'HUD"
DBM_CORE_HUD_INVALID_SELF			= "Impossibile utilizzare se stessi come bersaglio HUD"
DBM_CORE_HUD_INVALID_ICON			= "Impossibile utilizzare l'icona per HUD su un bersaglio senza icona"
DBM_CORE_HUD_SUCCESS				= "HUD avviato con successo con i tuoi parametri. Verrà annullato dopo %s, o digitando '/dbm hud hide'."
DBM_CORE_HUD_USAGE	= {
	"Utilizzo di DBM-HudMap:",
	"-----------------",
	"/dbm hud <tipo> <bersaglio> <durata>: Crea un HUD che punta al giocatore per la durata desiderata",
	"Tipi validi: arrow, dot, red, blue, green, yellow, icon (richiede un bersaglio con icona incursione)",
	"Bersagli validi: target, focus, <nomegiocatore>",
	"Durate valide: qualsiasi numero (in secondi). Se in bianco, verranno impostati 20min.",
	"/dbm hud hide:  disabilita e nasconde l'HUD"
}

DBM_ARROW_MOVABLE					= "Freccia mobile"
DBM_ARROW_WAY_USAGE					= "/dway <x> <y>: Crea una freccia che punta in una posizione specifica (utilizzando coordinate zona locale)"
DBM_ARROW_WAY_SUCCESS				= "Per nascondere la freccia, scrivi '/dbm arrow hide' o raggiungi la freccia"
DBM_ARROW_ERROR_USAGE	= {
	"Utilizzo di DBM-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: Crea una freccia che punta in una posizione specifica (utilizzando coordinate mondo)",
	"/dbm arrow map <x> <y>: Crea una freccia che punta in una posizione specifica (utilizzando coordinate zona)",
	"/dbm arrow <giocatore>: Crea una freccia che punta verso un giocatore specifico nel tuo gruppo o raid (distingue maiuscole/minuscole!)",
	"/dbm arrow hide: Nasconde la freccia",
	"/dbm arrow move: Rende la freccia mobile"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Record Vittoria"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Migliore Clear"
DBM_COMBAT_RES_TIMER_TEXT	= "Prossima Carica CR"
DBM_CORE_TIMER_RESPAWN		= "Respawn %s"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s ha richiesto di vedere l'ID e il progress della tua incursione.\nVuoi inviare questa informazione a %s? Potrà richiederti quest'informazione per tutta questa sessione (finche' non rilogghi)."
DBM_ERROR_NO_RAID					= "Devi essere in un Incursione per usare questa funzione."
DBM_INSTANCE_INFO_REQUESTED			= "Manda la richiesta di informazioni sul lock del gruppo di Incursione.\nVerrà chiesto a tutti il permesso di inviare questa informazione, quindi potrebbero passare alcuni secondi."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Ricevute le risposte di %d giocatori of %d utenti DBM : %d Dati inviati, %d richieste negate. Attendo qualche secondo per le altre %d risposte..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Ricevute le risposte da tutti."
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Mittente: %s Tipo di Risultato: %s Nome Incursione: %s ID: %s Difficulta': %d Dimensione: %d Progress: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, difficoltà %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progresso %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    progresso %d: %s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "Non sono presenti informazioni sull'incursione nel tuo gruppo incursione."
DBM_INSTANCE_INFO_STATS_DENIED		= "Hanno rifiutato la richiesta: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "In pausa: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Nessuna versione di DBM installata: %s"
DBM_INSTANCE_INFO_RESULTS			= "Risultati della Scansione ID di Incursione. Guarda che le istanze potrebbero essere riportate piu' volte se ci sono dei client di gioco localizzati nella tua incursione."
-- DBM_INSTANCE_INFO_SHOW_RESULTS		= "Players yet to respond: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Show results now]|r|h"
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Giocatori in attesa di risposta: %s"

DBM_CORE_LAG_CHECKING				= "Analisi Latenza incursione..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Risultati Latenza"
DBM_CORE_LAG_ENTRY					= "%s: Mondo [%d ms] / Locale [%d ms]"
DBM_CORE_LAG_FOOTER					= "Nessuna Risposta: %s"

DBM_CORE_DUR_CHECKING				= "Analisi Stato Equipaggiamento Incursione..."
DBM_CORE_DUR_HEADER					= "Deadly Boss Mods - Risultati Stato Equipaggiamento"
DBM_CORE_DUR_ENTRY					= "%s: Durata [%d percento] / Equip rotto [%s]"
DBM_CORE_LAG_FOOTER					= "Nessuna Risposta: %s"

--Role Icons
-- DBM_CORE_TANK_ICON			= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:21:7:27|t"
-- DBM_CORE_DAMAGE_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:39:55:7:27|t"
-- DBM_CORE_HEALER_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:70:86:7:27|t"

-- DBM_CORE_TANK_ICON_SMALL	= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:6:21:7:27|t"
-- DBM_CORE_DAMAGE_ICON_SMALL	= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:39:55:7:27|t"
-- DBM_CORE_HEALER_ICON_SMALL	= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:70:86:7:27|t"
--Importance Icons
-- DBM_CORE_HEROIC_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:22:22:0:0:255:66:102:118:7:27|t"
-- DBM_CORE_DEADLY_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:22:22:0:0:255:66:133:153:7:27|t"
-- DBM_CORE_IMPORTANT_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:168:182:7:27|t"
-- DBM_CORE_MYTHIC_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:22:22:0:0:255:66:133:153:40:58|t"

-- DBM_CORE_HEROIC_ICON_SMALL	= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:14:14:0:0:255:66:102:118:7:27|t"
-- DBM_CORE_DEADLY_ICON_SMALL	= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:14:14:0:0:255:66:133:153:7:27|t"
-- DBM_CORE_IMPORTANT_ICON_SMALL= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:168:182:7:27|t"
--Type Icons
-- DBM_CORE_INTERRUPT_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:198:214:7:27|t"
-- DBM_CORE_MAGIC_ICON			= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:229:247:7:27|t"
-- DBM_CORE_CURSE_ICON			= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:21:40:58|t"
-- DBM_CORE_POISON_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:39:55:40:58|t"
-- DBM_CORE_DISEASE_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:70:86:40:58|t"
-- DBM_CORE_ENRAGE_ICON		= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:102:118:40:58|t"

--LDB
DBM_LDB_TOOLTIP_HELP1	= "Click SX per aprire DBM"
DBM_LDB_TOOLTIP_HELP2	= "Click DX per aprire la configurazione"

DBM_LDB_LOAD_MODS		= "Carica i Moduli Boss"

-- DBM_LDB_CAT_BFA			= EXPANSION_NAME7
-- DBM_LDB_CAT_LEG			= EXPANSION_NAME6
-- DBM_LDB_CAT_WOD			= EXPANSION_NAME5
-- DBM_LDB_CAT_MOP			= EXPANSION_NAME4
-- DBM_LDB_CAT_CATA		= EXPANSION_NAME3
-- DBM_LDB_CAT_WOTLK		= EXPANSION_NAME2
-- DBM_LDB_CAT_BC			= EXPANSION_NAME1
-- DBM_LDB_CAT_CLASSIC 	= EXPANSION_NAME0
DBM_LDB_CAT_OTHER		= "Altre Boss Mod"

DBM_LDB_CAT_GENERAL		= "Generale"
DBM_LDB_ENABLE_BOSS_MOD	= "Abilita Boss Mod"
