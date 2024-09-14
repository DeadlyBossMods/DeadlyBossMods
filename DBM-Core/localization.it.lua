if GetLocale() ~= "itIT" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD					= "Benvenuto in "..L.DBM..". Scrivi /dbm help per avere una lista dei comandi supportati. Per accedere alle opzioni scrivi in chat /dbm. Carica le zone specifiche per configurare manualmente ogni settaggio di ogni boss. "..L.DBM.." prova a farlo per te controllando la tua specializzazione alla prima esecuzione, ma alcuni potrebbero volere alcune opzioni attivate."
L.SILENT_REMINDER					= "Avviso: "..L.DBM.." è in modalità silente."
L.NEWS_UPDATE						= "|h|c11ff1111News|r|h: This update changes mod structure around so classic and mainline now use unified (same) modules. This means that Vanilla, TBC, Wrath, and Cata modules are now installed separately using same packages as retail. Read more about it |Hgarrmission:DBM:news|h|cff3588ff[here]|r|h"--UPDATE ME

--L.COPY_URL_DIALOG_NEWS					= "To read latest news, visit link below"

L.LOAD_MOD_ERROR				= "Errore nel caricamento della Boss Mod %s: %s"
L.LOAD_MOD_SUCCESS			= "Caricate '%s' mod. Per opzioni quali avvisi sonori e avvertimenti personalizzati, digitare /dbm."
L.LOAD_MOD_COMBAT			= "Caricamento di '%s' rimandato al termine del combattimento"
L.LOAD_GUI_ERROR				= "Non riesco a caricare l'Interfaccia: %s"
L.LOAD_GUI_COMBAT			= "L'Interfaccia non può essere inizializzata in combattimento, verrà caricata al termine dello stesso. Caricata, potrai aprirla anche in combattimento."
L.BAD_LOAD					= ""..L.DBM.." non è stato in grado di caricare completamente la mod in quanto in combattimento. Al termine dello stesso, esegui /console reloadui il prima possibile."
L.LOAD_MOD_VER_MISMATCH		= "%s non può essere caricata in quanto DBM-Core non rispetta i requisiti. E' richiesta la versione aggiornata."
L.LOAD_MOD_EXP_MISMATCH		= "%s non può essere caricata in quanto è sviluppata per un'espansione di WoW non ancora disponibile. Quando diverrà disponibile, questa mod funzionerà."
L.LOAD_MOD_TOC_MISMATCH		= "%s non può essere caricata in quanto è sviluppata per una patch di WoW (%s) non ancora disponibile. Quando diverrà disponibile, questa mod funzionerà."
L.LOAD_MOD_DISABLED			= "%s è installata ma disabilitata. Questa mod non sarà caricata finchè non la abiliterai."
L.LOAD_MOD_DISABLED_PLURAL	= "%s sono installati ma disabilitati. Queste mod non saranno caricate finché non le abiliterai."

L.COPY_URL_DIALOG					= "Copia URL"
--L.COPY_WA_DIALOG						= "Copy WA Key"

--Post Patch 7.1
--L.TEXT_ONLY_RANGE						= "Range frame is limited to text only due to API restrictions in this area."
L.NO_RANGE					= "Il Radar Distanziometro non può essere utilizzato nelle istanze. Verrà utilizzato il precedente riquadro testuale"
L.NO_ARROW					= "La Freccia non può essere usata nelle istanze"
L.NO_HUD						= "La HUDMap non può essere usata nelle istanze"

L.DYNAMIC_DIFFICULTY_CLUMP	= ""..L.DBM.." ha disabilitato il riquadro distanziometro per questo combattimento per insufficienti informazioni sulle distanze richieste con un gruppo di queste dimensioni."
L.DYNAMIC_ADD_COUNT			= ""..L.DBM.." ha disabilitato gli avvisi sulla quantità degli add per questo combattimento per insufficienti informazioni sul numero di add presenti con un gruppo di queste dimensioni."
L.DYNAMIC_MULTIPLE			= ""..L.DBM.." ha disabilitato diverse funzionalità per questo combattimento per insufficienti informazioni su alcune meccaniche con un gruppo di queste dimensioni."

L.LOOT_SPEC_REMINDER			= "La tua specializzazione è %s. La tua preferenza per il bottino è %s."

L.BIGWIGS_ICON_CONFLICT		= ""..L.DBM.." ha rilevato l'abilitazione delle icone incursioni sia in BigWigs che in "..L.DBM..". Disabilita le icone in uno dei due per evitare conflitti"

L.MOD_AVAILABLE				= "%s è disponibile per questa ziona. E' possibile scaricare la mod da Curse, WoWI o deadlybossmods.com"

L.COMBAT_STARTED				= "%s ingaggiato. Buona fortuna e Divertiti! :)"
L.COMBAT_STARTED_IN_PROGRESS	= "Ingaggiato combattimento in corso contro %s. Buona fortuna e Divertiti! :)"
--L.GUILD_COMBAT_STARTED					= "%s has been engaged by %s's guild group"
L.SCENARIO_STARTED			= "%s iniziato. Buona fortuna e Divertiti! :)"
L.SCENARIO_STARTED_IN_PROGRESS	= "Unito allo scenario %s in corso. Buona fortuna e Divertiti! :)"
L.BOSS_DOWN					= "%s sconfitto in %s!"
L.BOSS_DOWN_I				= "%s sconfitto! Hai totalizzato %d vittorie."
L.BOSS_DOWN_L				= "%s sconfitto in %s! La tua ultima uccisione ha richiesto %s, quella più veloce %s. Hai totalizzato %d uccisioni."
L.BOSS_DOWN_NR				= "%s sconfitto in %s! E' un nuovo record! (Precedente di %s). Hai totalizzato %d uccisioni."
--L.RAID_DOWN								= "%s cleared after %s!"
--L.RAID_DOWN_L							= "%s cleared after %s! Your fastest clear took %s."
--L.RAID_DOWN_NR							= "%s cleared after %s! This is a new record! (Old record was %s)."
--L.GUILD_BOSS_DOWN						= "%s has been defeated by %s's guild group after %s!"
L.SCENARIO_COMPLETE			= "%s completato dopo %s!"
L.SCENARIO_COMPLETE_I		= "%s completato! Hai totalizzato %d completamenti."
L.SCENARIO_COMPLETE_L		= "%s completato dopo %s! Il tuo ultimo completamento ha richiesto %s e quello più veloce %s. Hai totalizzato %d completamenti."
L.SCENARIO_COMPLETE_NR		= "%s completato dopo %s! E' un nuovo record! (Precedente di %s). Hai totalizzato %d completamenti."
L.COMBAT_ENDED_AT			= "Combattimento contro %s (%s) terminato dopo %s."
L.COMBAT_ENDED_AT_LONG		= "Combattimento contro %s (%s) terminato dopo %s. Sei stato eliminato %d volte a questa difficoltà."
--L.GUILD_COMBAT_ENDED_AT					= "%s's Guild group has wiped on %s (%s) after %s."
L.SCENARIO_ENDED_AT			= "%s è terminato dopo %s."
L.SCENARIO_ENDED_AT_LONG		= "%s è terminato dopo %s. Hai totalizzato %d fallimenti a questa difficoltà."
L.COMBAT_STATE_RECOVERED		= "%s è stato ingaggiato %s fa, ripristino temporizzatori..."
L.TRANSCRIPTOR_LOG_START		= "Avviato registro di Transcriptor."
L.TRANSCRIPTOR_LOG_END		= "Terminato registro di Transcriptor."

L.MOVIE_SKIPPED				= ""..L.DBM.." ha tentato di saltare automaticamente un filmato."
--L.MOVIE_NOTSKIPPED							= L.DBM .. " has detected a skipable cut scene but has NOT skipped it due to a blizzard bug. When this bug is fixed, skipping will be re-enabled"
L.BONUS_SKIPPED				= ""..L.DBM.." ha chiuso automaticamente il riquadro del bottino bonus. Se richiesto, è possibile riaprirlo digitando /dbmbonusroll entro 3 minuti"

L.AFK_WARNING				= "Sei AFK e in combattimento (%d percento di vita rimanente), esecuzione avviso sonoro. Se non sei AFK, togliti dallo stato AFK flag o disabilita questa opzione in 'funzionalità aggiuntive'."

L.COMBAT_STARTED_AI_TIMER	= "Il mio processore fa parte di una rete neurale. (Questo combattimento utilizzerà la nuova funzione Temporizzatore IA per generare approssimazioni sulla temporizzazione)"

L.PROFILE_NOT_FOUND			= "<"..L.DBM.."> Il tuo profilo attuale è corrotto. "..L.DBM.." caricherà il profilo 'Predefinito'."
L.PROFILE_CREATED			= "Profilo '%s' creato."
L.PROFILE_CREATE_ERROR		= "Creazione profilo fallita. Nome profilo non valido."
L.PROFILE_CREATE_ERROR_D		= "Creazione profilo fallita. Il profilo '%s' esistente."
L.PROFILE_APPLIED			= "Profilo '%s' applicato."
L.PROFILE_APPLY_ERROR		= "Applicazione profilo fallita. Il profilo '%s' non esiste."
L.PROFILE_COPIED				= "Profilo '%s' copiato."
L.PROFILE_COPY_ERROR			= "Copia profilo fallita. Il profilo '%s' non esiste."
L.PROFILE_COPY_ERROR_SELF	= "Impossibile copiare il profilo su se stesso."
L.PROFILE_DELETED			= "Profilo '%s' eliminato. Verrà applicato il profilo 'Predefinito'."
L.PROFILE_DELETE_ERROR		= "Cancellazione prodilo fallita. Il profilo '%s' non esiste."
L.PROFILE_CANNOT_DELETE		= "Impossibile eliminare il profilo 'Predefinito'."
L.MPROFILE_COPY_SUCCESS		= "Le impostazioni mod di %s (spec %d) sono state copiate."
L.MPROFILE_COPY_SELF_ERROR	= "Impossibile copiare le impostazioni personaggio sullo stesso"
L.MPROFILE_COPY_S_ERROR		= "Sorgente corrotta. Impostazioni non copiate o parziali. Copia fallita."
L.MPROFILE_COPYS_SUCCESS		= "Le impostazioni sonore o le note di %s (spec %d) sono state copiate."
L.MPROFILE_COPYS_SELF_ERROR	= "Impossibile copiare i suoni o le note personaggio sullo stesso"
L.MPROFILE_COPYS_S_ERROR		= "Sorgente corrotta. Impostazioni sonore o note non copiate o parziali. Copia fallita."
L.MPROFILE_DELETE_SUCCESS	= "Impostazioni mod di %s (spec %d) eliminate."
L.MPROFILE_DELETE_SELF_ERROR	= "Impossibile eliminare impostazioni mod in uso."
L.MPROFILE_DELETE_S_ERROR	= "Sorgente corrotta. Impostazioni non cancellate o parziali. Cancellazione fallita."

L.NOTE_SHARE_SUCCESS			= "%s ha condiviso le sue note per %s"
--L.NOTE_SHARE_LINK						= "Click Here to Open Note"
L.NOTE_SHARE_FAIL			= "%s ha tentato di condividere una nota testuale con te per %s. Tuttavia, la mod associata con questa abilità non è installata o non è caricata. Se necessiti di questa nota, assicurati di caricare la mod che usano per le note e chiedi di condividerla nuovamente"

L.NOTEHEADER					= "Scrivi il testo della tua nota per %s. Racchiudendo i nomi giocatori con >< li colorerà in base alla classe. Per avvisi richiamati più volte, separare le note con '/'"
L.NOTEFOOTER					= "Premi 'Ok' per accettare le modifiche o 'Annulla' per declinarle"
L.NOTESHAREDHEADER			= "%s ha condiviso la seguente nota testuale per %s. Se accetti, sovrascriverà la tua attuale nota"
L.NOTESHARED					= "Le tue note sono state inviate al gruppo"
L.NOTESHAREERRORSOLO			= "Solitario? Non dovresti passarti le tue stesse note"
L.NOTESHAREERRORBLANK		= "Impossibile condividere note in bianco"
L.NOTESHAREERRORGROUPFINDER	= "Le note non possono essere condivise nei CdB, Ricerca Incursioni o Spedizioni"
L.NOTESHAREERRORALREADYOPEN	= "Impossibile aprire il collegamento a una nota condivisa mentre è aperto l'editor al fine di prevenire la perdita della nota attualmente in modifica"

L.ALLMOD_DEFAULT_LOADED		= "Le opzioni predefinite delle mod di quest'istanza sono state caricate."
L.ALLMOD_STATS_RESETED		= "Le statistiche della mod sono state resettate."
L.MOD_DEFAULT_LOADED			= "Le opzioni predefinite del combattimento sono state caricate."

L.WORLDBOSS_ENGAGED			= "%s è stato probabilmente ingaggiato sul reame con il %s di vita. (Inviato da %s)"
L.WORLDBOSS_DEFEATED			= "%s è stato probabilmente sconfitto sul reame (Inviato da %s)."
--L.WORLDBUFF_STARTED						= "%s buff has started on your realm for %s faction (Sent by %s)."

L.TIMER_FORMAT_SECS			= "%.2f |4secondo:secondi;"
L.TIMER_FORMAT_MINS			= "%d |4minuto:minuti;"
L.TIMER_FORMAT				= "%d |4minuto:minuti; e %.2f |4secondo:secondi;"

L.MIN						= "min"
L.MIN_FMT					= "%d min"
L.SEC						= "sec"
L.SEC_FMT					= "%s sec"

L.GENERIC_WARNING_OTHERS		= "e un altro"
L.GENERIC_WARNING_OTHERS2	= "e %d altri"
L.GENERIC_WARNING_BERSERK	= "Furia tra %s %s"
L.GENERIC_TIMER_BERSERK		= "Furia"
L.OPTION_TIMER_BERSERK		= "Visualizza Temporizzatore $spell:26662"
-- L.BAD						= "Bad"

L.OPTION_CATEGORY_TIMERS		= "Barre"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS		= "Annunci Generali"
L.OPTION_CATEGORY_WARNINGS_YOU	= "Annunci Personali"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Annunci Bersaglio"
L.OPTION_CATEGORY_WARNINGS_ROLE	= "Annunci Ruolo"
--L.OPTION_CATEGORY_SPECWARNINGS			= "Special Announces"

L.OPTION_CATEGORY_SOUNDS			= "Souni"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS		= "Tendine" -- Still put in MISC sub group, just used for line separators since multiple of these on a fight (or even having on of these at all) is rare.
L.OPTION_CATEGORY_YELLS			= "Urla"
L.OPTION_CATEGORY_NAMEPLATES		= "Barre dei Nomi"
L.OPTION_CATEGORY_ICONS			= "Icone"
--L.OPTION_CATEGORY_PAURAS				= "Private Auras"

L.AUTO_RESPONDED						= "Risposta Automatica."
L.STATUS_WHISPER						= "%s: %s, %d/%d Giocatori vivi"
-- Boss
L.AUTO_RESPOND_WHISPER				= "%s sta combattendo %s (%s, %d/%d giocatori vivi)"
L.WHISPER_COMBAT_END_KILL			= "%s ha sconfitto %s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s ha sconfitto %s! Hanno totalizzato %d vittorie."
L.WHISPER_COMBAT_END_WIPE_AT			= "%s ha subito una disfatta da %s al %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s ha subito una disfatta da %s al %s. Ha totalizzato %d disfatte in questa difficoltà."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s è occupato con %s (%d/%d persone vive)"
L.WHISPER_SCENARIO_END_KILL			= "%s ha completato %s!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s ha completato %s! Ha totalizzato %d vittorie."
L.WHISPER_SCENARIO_END_WIPE			= "%s non ha completato %s"
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s non ha completato %s. Ha totalizzato %d total disfatte in questa difficoltà."

L.VERSIONCHECK_HEADER		= L.DEADLY_BOSS_MODS.." - Versione"
L.VERSIONCHECK_ENTRY			= "%s: %s (%s)"
L.VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) e %s (%s)" -- Due Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM	= "%s: "..L.DBM.." non installato"
L.VERSIONCHECK_FOOTER		= "%d giocatori hanno "..L.DEADLY_BOSS_MODS..""
L.VERSIONCHECK_OUTDATED		= "I seguenti %d giocatore/i hanno una versione obsoleta delle boss mod: %s"
L.YOUR_VERSION_OUTDATED		= "La tua versione di "..L.DEADLY_BOSS_MODS.." è obsoleta. Visita http://www.deadlybossmods.com per ottenere l'ultima versione."
L.VOICE_PACK_OUTDATED		= "Il pacchetto vocale selezionato non contiene alcuni suoni supportati da "..L.DBM..". Alcuni avvisi sonori verranno eseguiti con i suoni predefiniti. Scarica una nuova versione del pacchetto vocale o contatta l'autore per un aggiornamento contenente l'audio mancante"
L.VOICE_MISSING				= "Hai selezionato un pacchetto vocale "..L.DBM.." non trovato. Se è un errore, assicurati che il pacchetto vocale sia correttamente installato e abilitato negli addon."
L.VOICE_DISABLED				= "Hai almeno un pacchetto vocale "..L.DBM.." installato ma nessuno abilitato. Se desideri usare un pacchetto vocale, assicurati che sia selezionato in 'Avvisi Parlati', altrimenti disinstalla i pacchetti vocali inutilizzati per nascondere questo messaggio"
L.VOICE_COUNT_MISSING		= "Conto alla rovescia %d è impostato su un pacchetto vocale/conteggio non trovato. E' stato reimportato all'opzione predefinita: %s."
L.BIG_WIGS						= "BigWigs"
--L.WEAKAURA_KEY							= " (|cff308530WA Key:|r %s)"

L.UPDATEREMINDER_HEADER		= "La tua versione di "..L.DEADLY_BOSS_MODS.." e' obsoleta.\n La Versione %s (%s) e' disponibile per il download su Curse, WoWI o da deadlybossmods.com"
L.UPDATEREMINDER_FOOTER		= "Premi " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  .. " per copiare il link di download negli appunti."
L.UPDATEREMINDER_FOOTER_GENERIC		= "Premi " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  .. " per copiare il link negli appunti."
L.UPDATEREMINDER_DISABLE			= "AVVISO: A causa della notevole obsolescenza, "..L.DEADLY_BOSS_MODS.." è stato forzatamente disabilitato e non può essere utilizzato fino all'aggiornamento. Questo per assicurarsi che vecchio e incompatibile codice non causi problemi a te e al tuo gruppo."
--L.UPDATEREMINDER_DISABLETEST			= "WARNING: Due to your " .. L.DEADLY_BOSS_MODS.. " being out of date and this being a test/beta realm, it has been force disabled and cannot be used until updated. This is to ensure out of date mods aren't being used to generate test feedback"
L.UPDATEREMINDER_HOTFIX			= "La versione v in uso ha problemi con il combattimento di questo boss che sono stati corretti con l'ultima versione aggiornata"
L.UPDATEREMINDER_HOTFIX_ALPHA	= "La versione "..L.DBM.." in uso ha problemi con il combattimento di questo boss che sono stati corretti con la prossima versione in arrivo (o nella versione alfa)"
L.UPDATEREMINDER_MAJORPATCH		= "AVVISO: Data l'obsolescenza di "..L.DEADLY_BOSS_MODS..", "..L.DBM.." è stato disabilitato fino ad aggiornamento, trattandosi di una patch maggiore. Questo è per assicurarsi che il vecchio e incompatibile codice non causi problemi a te o al tuo gruppo. Assicurati di scaricare una nuova versione da deadlybossmods.com, Curse o WoWI il prima possibile."
L.VEM							= "AVVISO: Stai eseguento sia "..L.DEADLY_BOSS_MODS.." che Voice Encounter Mods. "..L.DBM.." non funzionerà con questa configurazione e quindi non verrà caricato."
L.OUTDATEDPROFILES					= "AVVISO: DBM-Profiles è incompatibile con questa versione di "..L.DBM..". Deve essere rimosso per utilizzare "..L.DBM..", per evitare conflitti."
--L.OUTDATEDSPELLTIMERS					= "WARNING: DBM-SpellTimers breaks " .. L.DBM .. " and must be disabled for " .. L.DBM .. " to function properly."
--L.OUTDATEDRLT							= "WARNING: DBM-RaidLeadTools breaks " .. L.DBM .. ". DBM-RaidLeadTools is no longer supported and must be removed for " .. L.DBM .. " to function properly."
--L.VICTORYSOUND							= "WARNING: DBM-VictorySound is not compatible with this version of " .. L.DBM .. ". It must be removed before " .. L.DBM .. " can proceed, to avoid conflict."
L.DPMCORE						= "AVVISO: Deadly PvP mods è discontinuato e incompatibile con questa versione di "..L.DBM..". Deve essere rimosso per utilizzare "..L.DBM..", per evitare conflitti."
L.DBMLDB							= "AVVISO: DBM-LDB è ora incluso in DBM-Core. Anche se non dannoso, è consigliabile rimuovere 'DBM-LDB' dalla cartella addon"
--L.DBMLOOTREMINDER						= "WARNING: 3rd party mod DBM-LootReminder is installed. This addon is no longer compatible with Retail WoW client and will cause " .. L.DBM .. " to break and not be able to send pull timers. Uninstall of this addon recommended"
L.UPDATE_REQUIRES_RELAUNCH		= "AVVISO: Questo aggiornamento "..L.DBM.." non funzionerà correttamente a meno di un riavvio del gioco. Questo aggiornamento contiene nuovi file o modifiche al file .toc che non possono essere caricate con ReloadUI. Potresti avere malfunzionamenti o errori se continui senza riavviare."
L.OUT_OF_DATE_NAG				= "La versione di "..L.DEADLY_BOSS_MODS.." è obsoleta. E' consigliabile aggiornare per questo combattimento in modo da non perdere importanti avvisi, temporizzatori o urlare al resto del raid cose importanti."
--L.PLATER_NP_AURAS_MSG					= L.DBM .. " includes an advanced feature to show enemy cooldown timers using icons on nameplates. This is on by default for most users, but for Plater users it is off by default in Plater options unless you enable it. To get the most out of DBM (and Plater) it's recommended you enable this feature in Plater under 'Buff Special' section. If you don't want to see this message again, you can also just entirely disable 'Cooldown icons on nameplates' option in DBM global disable or nameplate options panels"

L.MOVABLE_BAR				= "Trascinami!"

L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h ti ha mandato un Timer "..L.DBM..": '%2$s'\n|Hgarrmission:DBM:cancella:%2$s:nil|h|cff3588ff[Cancella questo Timer]|r|h |Hgarrmission:DBM:ignora:%2$s:%1$s|h|cff3588ff[Ignora timer da %1$s]|r|h"
--L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h ti ha inviato un temporizzatore "..L.DBM..""
L.PIZZA_CONFIRM_IGNORE			= "Sei sicuro di voler ignorare i Timer DMB da %s per questa sessione?"
L.PIZZA_ERROR_USAGE				= "Uso: /dbm [broadcast] timer <time> <text>"

L.MINIMAP_TOOLTIP_HEADER		= L.DEADLY_BOSS_MODS -- (Identico all'Inglese)
L.MINIMAP_TOOLTIP_FOOTER		= "Tieni premuto Shift per trascinare liberamente"

L.RANGECHECK_HEADER			= "Distanziometro (%dm)"
L.RANGECHECK_HEADERT			= "Distanziometro (%dm-%dP)"
L.RANGECHECK_RHEADER			= "Distanziometro Inverso (%dD)"
L.RANGECHECK_RHEADERT		= "Distanziometro Inverso (%dm-%dP)"
L.RANGECHECK_SETRANGE		= "Imposta distanza"
L.RANGECHECK_SETTHRESHOLD	= "Imposta soglia giocatore"
L.RANGECHECK_SOUNDS			= "Souni"
L.RANGECHECK_SOUND_OPTION_1	= "Souna quando un giocatore e' in prossimita'"
L.RANGECHECK_SOUND_OPTION_2	= "Souna quando piu' giocatori sono in prossimita'"
L.RANGECHECK_SOUND_0			= "Nessun suono"
L.RANGECHECK_SOUND_1			= "Suono Standard"
L.RANGECHECK_SOUND_2			= "Beep Noioso"
L.RANGECHECK_SETRANGE_TO		= "%d m"
L.RANGECHECK_OPTION_FRAMES	= "Riquadri"
L.RANGECHECK_OPTION_RADAR	= "Visualizza Riquadro Radar"
L.RANGECHECK_OPTION_TEXT		= "Visualizza Riquadro Testuale"
L.RANGECHECK_OPTION_BOTH		= "Visualizza Entrambi i Riquadri"
L.RANGERADAR_HEADER			= "Distanza:%d Giocatori:%d"
L.RANGERADAR_RHEADER			= "Dist.Inv:%d Giocatori:%d"
L.RANGERADAR_IN_RANGE_TEXT	= "%d vicini (%0.1fm)" -- Multi
L.RANGECHECK_IN_RANGE_TEXT	= "%d vicini" -- Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fm)" -- One target

--L.INFOFRAME_TITLE						= "DBM Info Frame"
L.INFOFRAME_SHOW_SELF		= "Visualizza sempre la tua forza"		-- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES			= "Imposta linee massime"
--L.INFOFRAME_SETCOLS						= "Set max columns"
L.INFOFRAME_LINESDEFAULT		= "Imposta per mod"
L.INFOFRAME_LINES_TO			= "%d linee"
--L.INFOFRAME_COLS_TO						= "%d columns"
L.INFOFRAME_POWER			= "Forza"
L.INFOFRAME_AGGRO			= "Aggro"
L.INFOFRAME_MAIN				= "Principale:"--Main power
L.INFOFRAME_ALT				= "Alt:"--Alternate Power

L.LFG_INVITE						= "Invito LFG"

L.SLASHCMD_HELP				= {
	"Comandi Disponibili:",
	"-----------------",
	"/dbm unlock: Mostra un temporizzatore mobile (alias: move).",
	"/range <numero> o /distance <numero>: Mostra distanziometro. /rrange o /rdistance per colori invertiti.",
	"/hudar <number>: Mostra Distanziometro a HUD.",
	"/dbm timer: Avvia temporizzatore "..L.DBM.." personalizzato, vedi '/dbm timer' per dettagli.",
	"/dbm arrow: Mostra la freccia "..L.DBM..", vedi '/dbm arrow help' per dettagli.",
	"/dbm hud: Mostra l'HUD "..L.DBM..", vedi '/dbm hud' per dettagli.",
	"/dbm help2: Mostra i comandi per gestione incursione."
}
L.SLASHCMD_HELP2				= {
	"Comandi Disponibili:",
	"-----------------",
	"/dbm pull <sec>: Avvia un temporizzatore per pull di <sec> secondi all'incursione (richiede assist. alias: pull).",
	"/dbm break <min>: Avvia un temporizzatore per pause di <min> minuti all'incursione (richiede assist. alias: break).",
	"/dbm version: Verifica la versione delle boss mod (alias: ver).",
	"/dbm version2: Verifica la versione delle boss mod e invia un messaggio a quelli con versioni obsolete (alias: ver2).",
	"/dbm lag: Controlla la latenza di tutti i giocatori nell'incursione.",
	"/dbm durability: Controlla l'integrità dell'equipaggiamento di tutti i giocatori nell'incursione."
}
L.TIMER_USAGE	= {
	"Comandi Temporizzatore "..L.DBM..":",
	"-----------------",
	"/dbm timer <sec> <testo>: Avvia un temporizzatore di <sec> secondi con il testo <testo>.",
	"/dbm ltimer <sec> <testo>: Avvia un temporizzatore a ciclo continuo fino ad annullamento.",
	"(Il prefisso 'Broadcast' di qualunque temporizzatore lo condivide se capogruppo/assistente)",
	"/dbm timer endloop: Termina il ciclo di un ltimer."
}

L.ERROR_NO_PERMISSION				= "Non hai i permessi per eseguire questo comando."
--L.PULL_TIME_TOO_SHORT						= "Pull timer must be longer than 3 seconds."
L.PULL_TIME_TOO_LONG							= "Pull timer cannot be longer than 60 seconds"

L.BREAK_USAGE				= "Il temporizzatore della pausa non può durare più di 60 minuti. Assicurati di aver inserito il tempo in minuti e non in secondi."
L.BREAK_START				= "Inizia la pausa -- hai %s! (Iniziata da %s)"
L.BREAK_MIN					= "La pausa termina tra %s minuto/i!"
L.BREAK_SEC					= "La pausa termina tra %s secondi!"
L.TIMER_BREAK				= "Ora della pausa!"
L.ANNOUNCE_BREAK_OVER		= "La pausa è finita dopo %s."

L.TIMER_PULL					= "Ingaggio"
L.ANNOUNCE_PULL				= "Ingaggio tra %d s. (Iniziato da %s)"
L.ANNOUNCE_PULL_NOW			= "Ingaggia ora!"
L.ANNOUNCE_PULL_TARGET		= "Ingaggio di %s tra %d s. (Iniziato da %s)"
L.ANNOUNCE_PULL_NOW_TARGET	= "Ingaggia %s ora!"
L.GEAR_WARNING				= "Avviso: Controlla l'equipaggiamento. Il livello oggetti equipaggiato è %d meno di quello in borsa."
L.GEAR_WARNING_WEAPON		= "Avviso: Controlla di aver equipaggiato l'arma corretta."
L.GEAR_FISHING_POLE			= "Canna da Pesca"

L.ACHIEVEMENT_TIMER_SPEED_KILL = "Uccisione Rapida" -- BATTLE_PET_SOURCE_6

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.you			= "%s su di TE"
L.AUTO_ANNOUNCE_TEXTS.target			= "%s su >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetsource	= ">%%s< casta %s su >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) su >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell			= "%s"
--L.AUTO_ANNOUNCE_TEXTS.incoming							= "%s incoming debuff"
--L.AUTO_ANNOUNCE_TEXTS.incomingcount						= "%s incoming debuff (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends 			= "%s terminato"
L.AUTO_ANNOUNCE_TEXTS.endtarget		= "%s terminato: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades			= "%s svanito"
L.AUTO_ANNOUNCE_TEXTS.addsleft		= "%s rimanenti: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast			= "Castando %s: %.1f s"
L.AUTO_ANNOUNCE_TEXTS.soon			= "%s a breve"
L.AUTO_ANNOUNCE_TEXTS.sooncount		= "%s (%%s) a breve"
--L.AUTO_ANNOUNCE_TEXTS.countdown							= "%s in %%ds"
L.AUTO_ANNOUNCE_TEXTS.prewarn		= "%s tra %s"
L.AUTO_ANNOUNCE_TEXTS.bait			= "%s a breve - attiralo ora"
L.AUTO_ANNOUNCE_TEXTS.stage			= "Fase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage		= "Fase %s a breve"
L.AUTO_ANNOUNCE_TEXTS.count			= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack			= "%s su >%%s< (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto			= "%s - vai a >%%s<"

local prewarnOption = "Mostra preavvisi per $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you			= "Annuncia quando affetto da $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.target		= "Annuncia bersagli di $spell:%s"
--L.AUTO_ANNOUNCE_OPTIONS.targetNF							= "Announce $spell:%s targets (ignores global target filter)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource	= "Annuncia bersagli di $spell:%s (con sorgente)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount	= "Annuncia bersagli di $spell:%s (con conteggio)"
L.AUTO_ANNOUNCE_OPTIONS.spell		= "Mostra avvisi per $spell:%s"
--L.AUTO_ANNOUNCE_OPTIONS.incoming							= "Announce when $spell:%s has incoming debuffs"
--L.AUTO_ANNOUNCE_OPTIONS.incomingcount						= "Announce (with count) when $spell:%s has incoming debuffs"
L.AUTO_ANNOUNCE_OPTIONS.ends			= "Mostra avviso al termine di $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.endtarget	= "Mostra avviso al termine di $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.fades		= "Mostra avviso allo svanire di $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.addsleft		= "Annuncia la quantità di $spell:%s rimanenti"
L.AUTO_ANNOUNCE_OPTIONS.cast			= "Mostra avviso al cast di $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount	= prewarnOption
--L.AUTO_ANNOUNCE_OPTIONS.countdown							= "Show pre-warning countdown spam for $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait			= "Mostra preavvisi (per attirare) per $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stage		= "Annuncia Fase %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange	= "Annuncia cambi fase"
L.AUTO_ANNOUNCE_OPTIONS.prestage		= "Mostra preavviso per la Fase %s"
L.AUTO_ANNOUNCE_OPTIONS.count		= "Mostra avviso per $spell:%s (con conteggio)"
L.AUTO_ANNOUNCE_OPTIONS.stack		= "Annuncia stack di $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.moveto		= "Mostra avvisi per muoverti da qualcuno o qualcosa per $spell:%s"

L.AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends				= "%s terminata"
L.AUTO_SPEC_WARN_TEXTS.fades				= "%s svanita"
L.AUTO_SPEC_WARN_TEXTS.soon				= "%s a breve"
L.AUTO_SPEC_WARN_TEXTS.sooncount			= "%s (%%s) a breve"
L.AUTO_SPEC_WARN_TEXTS.bait				= "%s a breve - attiralo subito"
L.AUTO_SPEC_WARN_TEXTS.prewarn			= "%s tra %s"
L.AUTO_SPEC_WARN_TEXTS.dispel			= "%s su >%%s< - dispellalo subito"
L.AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - interrompi >%%s<!"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - interrompi >%%s<! (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you				= "%s su di te"
L.AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) su di te"
L.AUTO_SPEC_WARN_TEXTS.youpos			= "%s (Posizione: %%s) su di te"
--L.AUTO_SPEC_WARN_TEXTS.youposcount							= "%s (%%s) (Position: %%s) on you"
L.AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Entra in Posizione: %%s)"
L.AUTO_SPEC_WARN_TEXTS.target			= "%s su >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) su >%%s< "
L.AUTO_SPEC_WARN_TEXTS.defensive			= "%s - difensivi"
L.AUTO_SPEC_WARN_TEXTS.taunt				= "%s su >%%s< - tauntalo subito"
L.AUTO_SPEC_WARN_TEXTS.close				= "%s su >%%s< vicino a te"
L.AUTO_SPEC_WARN_TEXTS.move				= "%s - spostati"
L.AUTO_SPEC_WARN_TEXTS.keepmove			= "%s - continua a muoverti"
L.AUTO_SPEC_WARN_TEXTS.stopmove			= "%s - fermati"
L.AUTO_SPEC_WARN_TEXTS.dodge				= "%s - evita l'attacco"
L.AUTO_SPEC_WARN_TEXTS.dodgecount		= "%s (%%s) - evita l'attacco"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc			= "%s - evita da %%s"
L.AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - spostati dagli altri"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount		= "%s (%%s) - spostati dagli altri"
L.AUTO_SPEC_WARN_TEXTS.moveto			= "%s - spostati a >%%s<"
L.AUTO_SPEC_WARN_TEXTS.soak				= "%s - entraci"
--L.AUTO_SPEC_WARN_TEXTS.soakcount							= "%s - soak (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump				= "%s - salta"
L.AUTO_SPEC_WARN_TEXTS.run				= "%s - scappa"
--L.AUTO_SPEC_WARN_TEXTS.runcount							= "%s - run away (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast				= "%s - non castare"
L.AUTO_SPEC_WARN_TEXTS.lookaway			= "%s su %%s - distogli lo sguardo"
L.AUTO_SPEC_WARN_TEXTS.reflect			= "%s su >%%s< - non attaccare"
L.AUTO_SPEC_WARN_TEXTS.count				= "%s! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack				= "%%d stack di %s su di te"
L.AUTO_SPEC_WARN_TEXTS.switch			= "%s - cambio bersaglio"
L.AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - cambio bersaglio (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo				= "%%s sotto di te - spostati"
L.AUTO_SPEC_WARN_TEXTS.adds				= "Add in Arrivo - cambio bersaglio"
--L.AUTO_SPEC_WARN_TEXTS.addscount							= "Incoming Adds - switch targets (%%s)"--Basically a generic of switch
L.AUTO_SPEC_WARN_TEXTS.addscustom		= "Add in Arrivo - %%s"
L.AUTO_SPEC_WARN_TEXTS.targetchange		= "Cambio Bersaglio - passa a %%s"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Mostra avviso speciale per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends 			= "Mostra avviso speciale al termine di $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.fades 			= "Mostra avviso speciale allo svanire di $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soon 			= "Mostra preavviso speciale per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.sooncount		= "Mostra preavviso speciale (con conteggio) per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.bait			= "Mostra preavviso speciale (per attirare) per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Mostra preavviso speciale di %s secondi prima di $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 			= "Mostra avviso speciale per dispel di $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Mostra avviso speciale per interrompere $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Mostra avviso speciale (con conteggio) per interrompere $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Mostra avviso speciale quando affetto da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Mostra avviso speciale (con conteggio) quando affetto da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youpos			= "Mostra avviso speciale (con posizione) quando affetto da $spell:%s"
--L.AUTO_SPEC_WARN_OPTIONS.youposcount							= "Show special announce (with position and count) when you are affected by $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakpos			= "Mostra avviso speciale (con posizione) per entrare dagli affetti da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.target 			= "Mostra avviso speciale quando qualcuno è affetto da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Mostra avviso speciale (con conteggio) quando qualcuno è affetto da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.defensive 		= "Mostra avviso speciale per usare abilità difensive per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt 			= "Mostra avviso speciale per tauntare quando l'altro difensore è affetto da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Mostra avviso speciale quando qualcuno vicino è affetto da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Mostra avviso speciale per spostarti da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Mostra avviso speciale per continuare a muoverti con $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 		= "Mostra avviso speciale per fermarti con $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Mostra avviso speciale per evitare $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount		= "Mostra avviso speciale (con conteggio) per evitare $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "Mostra avviso speciale (con posizione) per evitare $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveaway		= "Mostra avviso speciale per spostarsi dagli altri con $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "Mostra avviso speciale (con conteggio) per spostarsi dagli altri con $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveto			= "Mostra avviso speciale per muoverti verso qualcuno o qualcosa per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soak			= "Mostra avviso speciale per entrare in $spell:%s"
--L.AUTO_SPEC_WARN_OPTIONS.soakcount							= "Show special announce (with count) to soak for $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.jump			= "Mostra avviso speciale per muoverti per saltare per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Mostra avviso speciale per sfuggire da $spell:%s"
--L.AUTO_SPEC_WARN_OPTIONS.runcount							= "Show special announce (with count) to run away from $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Mostra avviso speciale per non castare per $spell:%s" -- Interruzione Abilità
L.AUTO_SPEC_WARN_OPTIONS.lookaway		= "Mostra avviso speciale per distogliere lo sguardo da $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect 		= "Mostra avviso speciale per non attaccare per $spell:%s" -- Riflesso Abilità
L.AUTO_SPEC_WARN_OPTIONS.count 			= "Mostra avviso speciale (con conteggio) per $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack 			= "Mostra avviso speciale quando affetto da >= %d stack di $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switch			= "Mostra avviso speciale per cambiare bersaglio con $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount		= "Mostra avviso speciale (con conteggio) per cambiare bersaglio con $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Mostra avviso speciale per spostarsi dalle schifezze a terra"
L.AUTO_SPEC_WARN_OPTIONS.adds			= "Mostra avviso speciale per cambiare bersaglio per l'arrivo di add"
--L.AUTO_SPEC_WARN_OPTIONS.addscount							= "Show special announce (with count) to switch targets for incoming adds"
L.AUTO_SPEC_WARN_OPTIONS.addscustom		= "Mostra avviso speciale per l'arrivo di add"
L.AUTO_SPEC_WARN_OPTIONS.targetchange	= "Mostra avviso speciale per cambio bersaglio prioritario"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target		= "%s: %%s"
--L.AUTO_TIMER_TEXTS.targetcount							= "%s (%%2$s): %%1$s" -- OPTIONAL
L.AUTO_TIMER_TEXTS.cast			= "%s"
--L.AUTO_TIMER_TEXTS.castcount		= "%s (%%s)"
L.AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
L.AUTO_TIMER_TEXTS.active		= "%s terminato" -- Buff/Debuff/Eventi su boss
L.AUTO_TIMER_TEXTS.fades			= "%s svanito" -- Buff/Debuff su giocatori
L.AUTO_TIMER_TEXTS.ai			= "%s IA"

L.AUTO_TIMER_TEXTS.cd			= "%s CD"
L.AUTO_TIMER_TEXTS.cdcount		= "%s (%%s) CD"
L.AUTO_TIMER_TEXTS.cdsource		= "%s CD: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial		= "CD Speciale"

L.AUTO_TIMER_TEXTS.next			= "Prossimo %s"
L.AUTO_TIMER_TEXTS.nextcount		= "Prossimo %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource	= "Prossimo %s: %%s"
L.AUTO_TIMER_TEXTS.nextspecial	= "Prossimo Speciale"

L.AUTO_TIMER_TEXTS.achievement	= "%s"
L.AUTO_TIMER_TEXTS.stage			= "Prossima Fase"
--L.AUTO_TIMER_TEXTS.stagecount							= "Stage %%s"--NOT BUGGED, stage is 2nd arg, spellID is ignored on purpose
--L.AUTO_TIMER_TEXTS.stagecountcycle						= "Stage %%s (%%s)"--^^. Example: Stage 2 (3) for a fight that alternates stage 1 and stage 2, but also tracks total cycles
--L.AUTO_TIMER_TEXTS.stagecontext						= "%s" -- OPTIONAL
--L.AUTO_TIMER_TEXTS.stagecontextcount					= "%s (%%s)" -- OPTIONAL
--L.AUTO_TIMER_TEXTS.intermission						= "Intermission"
--L.AUTO_TIMER_TEXTS.intermissioncount					= "Intermission %%s"
L.AUTO_TIMER_TEXTS.adds			= "Add in Arrivo"
L.AUTO_TIMER_TEXTS.addscustom	= "Add in Arrivo (%%s)"
L.AUTO_TIMER_TEXTS.roleplay		= GUILD_INTEREST_RP
L.AUTO_TIMER_TEXTS.combat		= "Inizio combattimento"
--This basically clones np only bar option and display text from regular counterparts
L.AUTO_TIMER_TEXTS.cdnp					= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.cdpnp				= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextpnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.castpnp				= L.AUTO_TIMER_TEXTS.cast -- OPTIONAL

L.AUTO_TIMER_OPTIONS.target		= "Mostra temporizzatore debuff di $spell:%s"
--L.AUTO_TIMER_OPTIONS.targetcount							= "Show timer (with count) for $spell:%s debuff"
L.AUTO_TIMER_OPTIONS.cast		= "Mostra temporizzatore cast di $spell:%s"
L.AUTO_TIMER_OPTIONS.castcount	= "Mostra temporizzatore (con conteggio) cast di $spell:%s"
L.AUTO_TIMER_OPTIONS.castsource	= "Mostra temporizzatore (con sorgente) cast di $spell:%s"
L.AUTO_TIMER_OPTIONS.active		= "Mostra temporizzatore durata di $spell:%s"
L.AUTO_TIMER_OPTIONS.fades		= "Mostra temporizzatore allo svanire di $spell:%s dai giocatori"
L.AUTO_TIMER_OPTIONS.ai			= "Mostra temporizzatore AI ricarica $spell:%s"
L.AUTO_TIMER_OPTIONS.cd			= "Mostra temporizzatore ricarica $spell:%s"
L.AUTO_TIMER_OPTIONS.cdcount		= "Mostra temporizzatore ricarica cooldown $spell:%s"
--L.AUTO_TIMER_OPTIONS.cdnp								= "Show nameplate only timer for $spell:%s cooldown"
L.AUTO_TIMER_OPTIONS.cdsource	= "Mostra temporizzatore (con sorgente) ricarica $spell:%s"
L.AUTO_TIMER_OPTIONS.cdspecial	= "Mostra temporizzatore ricarica dell'abilità speciale"
--L.AUTO_TIMER_OPTIONS.cdcombo								= "Show timer for ability combo cooldown"--Used for combining 2 abilities into a single timer
L.AUTO_TIMER_OPTIONS.next		= "Mostra temporizzatore prossima $spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount	= "Mostra temporizzatore prossima $spell:%s"
--L.AUTO_TIMER_OPTIONS.nextnp								= "Show nameplate only timer for next $spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource	= "Mostra temporizzatore (con sorgente) per prossima $spell:%s"
L.AUTO_TIMER_OPTIONS.nextspecial	= "Mostra temporizzatore prossima abilità speciale"
--L.AUTO_TIMER_OPTIONS.nextcombo							= "Show timer for next ability combo"--Used for combining 2 abilities into a single timer
L.AUTO_TIMER_OPTIONS.achievement	= "Mostra temporizzatore %s"
L.AUTO_TIMER_OPTIONS.stage		= "Mostra temporizzatore per prossima fase"
--L.AUTO_TIMER_OPTIONS.stagecount							= "Show timer (with count) for next stage"
--L.AUTO_TIMER_OPTIONS.stagecountcycle						= "Show timer (with stage count and cycle count) for next stage"
--L.AUTO_TIMER_OPTIONS.stagecontext						= "Show timer for next $spell:%s stage"
--L.AUTO_TIMER_OPTIONS.stagecontextcount					= "Show timer (with count) for next $spell:%s stage"
--L.AUTO_TIMER_OPTIONS.intermission						= "Show timer for next intermission"
--L.AUTO_TIMER_OPTIONS.intermissioncount					= "Show timer (with count) for next intermission"
L.AUTO_TIMER_OPTIONS.adds		= "Mostra temporizzatore add in arrivo"
L.AUTO_TIMER_OPTIONS.addscustom	= "Mostra temporizzatore add in arrivo"
L.AUTO_TIMER_OPTIONS.roleplay	= "Mostra temporizzatore durata gioco di ruolo"
L.AUTO_TIMER_OPTIONS.combat		= "Mostra temporizzatore inizio combattimento"

L.AUTO_ICONS_OPTION_TARGETS			= "Imposta icone sui bersagli di $spell:%s"
--L.AUTO_ICONS_OPTION_TARGETS_TANK_A		= "Set icons on $spell:%s targets with tank over melee over ranged priority and alphabetical fallback"
--L.AUTO_ICONS_OPTION_TARGETS_TANK_R		= "Set icons on $spell:%s targets with tank over melee over ranged priority and raid roster fallback"
--L.AUTO_ICONS_OPTION_TARGETS_MELEE_A		= "Set icons on $spell:%s targets with melee and alphabetical priority"
--L.AUTO_ICONS_OPTION_TARGETS_MELEE_R		= "Set icons on $spell:%s targets with melee and raid roster priority"
--L.AUTO_ICONS_OPTION_TARGETS_RANGED_A	= "Set icons on $spell:%s targets with ranged and alphabetical priority"
--L.AUTO_ICONS_OPTION_TARGETS_RANGED_R	= "Set icons on $spell:%s targets with ranged and raid roster priority"
--L.AUTO_ICONS_OPTION_TARGETS_ALPHA		= "Set icons on $spell:%s targets with alphabetical priority"
--L.AUTO_ICONS_OPTION_TARGETS_ROSTER		= "Set icons on $spell:%s targets with raid roster priority"
L.AUTO_ICONS_OPTION_NPCS		= "Imposta icone su $spell:%s"
--L.AUTO_ICONS_OPTION_CONFLICT			= " (May conflict with other options)"

L.AUTO_ARROW_OPTION_TEXT			= "Mostra la Freccia "..L.DBM.." per muoversi verso i bersagli affetti da $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2		= "Mostra la Freccia "..L.DBM.." per scansarsi dai bersagli affetti da $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3		= "Mostra la Freccia "..L.DBM.." per muoversi verso località specifiche per $spell:%s"

L.AUTO_YELL_OPTION_TEXT.shortyell	= "Urla quando affetto da $spell:%s"
L.AUTO_YELL_OPTION_TEXT.yell			= "Urla (con nome giocatore) quando affetto da $spell:%s"
L.AUTO_YELL_OPTION_TEXT.count		= "Urla (con conteggio) quando affetto da $spell:%s"
L.AUTO_YELL_OPTION_TEXT.fade			= "Urla (con conto alla rovescia e nome abilità) allo svanire di $spell:%s"
L.AUTO_YELL_OPTION_TEXT.shortfade	= "Urla (con conto alla rovescia) allo svanire di $spell:%s"
L.AUTO_YELL_OPTION_TEXT.iconfade		= "Urla (con conto alla rovescia ed icona) allo svanire di $spell:%s"
L.AUTO_YELL_OPTION_TEXT.position		= "Urla (con posizione) quando affetto da $spell:%s"
--L.AUTO_YELL_OPTION_TEXT.shortposition						= "Yell (with position) when you are affected by $spell:%s"
L.AUTO_YELL_OPTION_TEXT.combo		= "Urla (con testo personalizzato) quando affetto da $spell:%s e altre allo stesso tempo"
--L.AUTO_YELL_OPTION_TEXT.repeatplayer						= "Yell repeatedly (with player name) when you are affected by $spell:%s"
--L.AUTO_YELL_OPTION_TEXT.repeaticon							= "Yell repeatedly (with icon) when you are affected by $spell:%s"

L.AUTO_YELL_ANNOUNCE_TEXT.shortyell		= "%s"
L.AUTO_YELL_ANNOUNCE_TEXT.yell			= "%s su " .. UnitName("player")
L.AUTO_YELL_ANNOUNCE_TEXT.count			= "%s su " .. UnitName("player") .. " (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade			= "%s svanisce tra %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade		= "%%d"
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade		= "{rt%%2$d}%%1$d"
L.AUTO_YELL_ANNOUNCE_TEXT.position 		= "%s %%s su {rt%%d}"..UnitName("player").."{rt%%d}"
--L.AUTO_YELL_ANNOUNCE_TEXT.shortposition 						= "{rt%%1$d}%s"--Icon, Spellname -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.combo			= "%s e %%s" -- Nome abilità (da opzioni, più nome abilità passata in arg)
--L.AUTO_YELL_ANNOUNCE_TEXT.repeatplayer						= UnitName("player")--Doesn't need translation, it's just player name spam -- OPTIONAL
--L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon							= "{rt%%1$d}"--Doesn't need translation. It's just icon spam -- OPTIONAL

L.AUTO_YELL_CUSTOM_POSITION		= "{rt%d}%s"--Doesn't need translating. Has no strings
L.AUTO_YELL_CUSTOM_FADE			= "%s svanito"
L.AUTO_HUD_OPTION_TEXT			= "Mostra la HudMap per l'abilità $spell:%s (Dismessa)"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "Mostra la HudMap per varie meccaniche (Dismessa)"
L.AUTO_NAMEPLATE_OPTION_TEXT		= "Mostra l'Aura della Barra del Nome per $spell:%s"
--L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED		= "Show Nameplate Auras for $spell:%s using only "..L.DBM
L.AUTO_RANGE_OPTION_TEXT			= "Mostra distanziometro (%s) per $spell:%s" -- string used for range so we can use things like "5/2" as a value for that field
L.AUTO_RANGE_OPTION_TEXT_SHORT	= "Mostra distanziometro (%s)" -- For when a range frame is just used for more than one thing
L.AUTO_RRANGE_OPTION_TEXT		= "Mostra distanziometro invertito (%s) per $spell:%s" -- Reverse range frame (green when players in range, red when not)
L.AUTO_RRANGE_OPTION_TEXT_SHORT	= "Mostra distanziometro invertito (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT	= "Mostra riquadro informativo per $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2	= "Mostra riquadro informativo per la panoramica scontro"
--L.AUTO_INFO_FRAME_OPTION_TEXT3			= "Show info frame for $spell:%s (when threshold of %%s is met)"
L.AUTO_READY_CHECK_OPTION_TEXT	= "Riproduti il suono controllo gruppo al pull del boss (anche se non bersagliato)"
--L.AUTO_SPEEDCLEAR_OPTION_TEXT			= "Show timer for fastest clear of %s"
--L.AUTO_PRIVATEAURA_OPTION_TEXT			= "Play DBM sound alerts for $spell:%s private auras on this fight."

-- New special warnings
L.MOVE_WARNING_BAR			= "Annunci mobili"
L.MOVE_WARNING_MESSAGE		= "Grazie per utilizzare "..L.DEADLY_BOSS_MODS..""
L.MOVE_SPECIAL_WARNING_BAR	= "Avvisi speciali mobili"
L.MOVE_SPECIAL_WARNING_TEXT	= "Avvisi Speciali"

L.HUD_INVALID_TYPE			= "Tipo invalido di HUD definito"
L.HUD_INVALID_TARGET			= "Nessun bersaglio valido dato per l'HUD"
L.HUD_INVALID_SELF			= "Impossibile utilizzare se stessi come bersaglio HUD"
L.HUD_INVALID_ICON			= "Impossibile utilizzare l'icona per HUD su un bersaglio senza icona"
L.HUD_SUCCESS				= "HUD avviato con successo con i tuoi parametri. Verrà annullato dopo %s, o digitando '/dbm hud hide'."
L.HUD_USAGE	= {
	"Utilizzo di "..L.DBM.."-HudMap:",
	"-----------------",
	"/dbm hud <tipo> <bersaglio> <durata>: Crea un HUD che punta al giocatore per la durata desiderata",
	"Tipi validi: arrow, dot, red, blue, green, yellow, icon (richiede un bersaglio con icona incursione)",
	"Bersagli validi: target, focus, <nomegiocatore>",
	"Durate valide: qualsiasi numero (in secondi). Se in bianco, verranno impostati 20 minuti.",
	"/dbm hud hide:  disabilita e nasconde l'HUD"
}

L.ARROW_MOVABLE					= "Freccia mobile"
L.ARROW_WAY_USAGE					= "/dway <x> <y>: Crea una freccia che punta in una posizione specifica (utilizzando coordinate zona locale)"
L.ARROW_WAY_SUCCESS				= "Per nascondere la freccia, scrivi '/dbm arrow hide' o raggiungi la freccia"
L.ARROW_ERROR_USAGE	= {
	"Utilizzo di "..L.DBM.."-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: Crea una freccia che punta in una posizione specifica (utilizzando coordinate mondo)",
	"/dbm arrow map <x> <y>: Crea una freccia che punta in una posizione specifica (utilizzando coordinate zona)",
	"/dbm arrow <giocatore>: Crea una freccia che punta verso un giocatore specifico nel tuo gruppo o raid (distingue maiuscole/minuscole!)",
	"/dbm arrow hide: Nasconde la freccia",
	"/dbm arrow move: Rende la freccia mobile"
}

L.SPEED_KILL_TIMER_TEXT	= "Record Vittoria"
L.SPEED_CLEAR_TIMER_TEXT	= "Migliore Clear"
L.COMBAT_RES_TIMER_TEXT	= "Prossima Carica CR"
L.TIMER_RESPAWN		= "Respawn %s"

L.LAG_CHECKING				= "Analisi Latenza incursione..."
L.LAG_HEADER					= L.DEADLY_BOSS_MODS.." - Risultati Latenza"
L.LAG_ENTRY					= "%s: Reame [%d ms] / Locale [%d ms]"
L.LAG_FOOTER					= "Nessuna Risposta: %s"

L.DUR_CHECKING				= "Analisi Stato Equipaggiamento Incursione..."
L.DUR_HEADER					= L.DEADLY_BOSS_MODS.." - Risultati Stato Equipaggiamento"
L.DUR_ENTRY					= "%s: Durata [%d percento] / Equipaggiamento rotto [%s]"

--L.OVERRIDE_ACTIVATED					= "Configuration overrides have been activated for this encounter by RL"

--LDB
L.LDB_TOOLTIP_HELP1	= "Clicca per aprire "..L.DBM..""
L.LDB_TOOLTIP_HELP2	= "Clicca col tasto destro per aprire la configurazione"
--L.SILENTMODE_IS							= "SilentMode is "

--L.WORLD_BUFFS.hordeOny							= "People of the Horde, citizens of Orgrimmar, come, gather round and celebrate a hero of the Horde",
--L.WORLD_BUFFS.allianceOny							= "Citizens and allies of Stormwind, on this day, history has been made.",
--L.WORLD_BUFFS.hordeNef							= "NEFARIAN IS SLAIN! People of Orgrimmar",
--L.WORLD_BUFFS.allianceNef							= "Citizens of the Alliance, the Lord of Blackrock is slain!",
--L.WORLD_BUFFS.zgHeart								= "Now, only one step remains to rid us of the Soulflayer's threat",
--L.WORLD_BUFFS.zgHeartBooty						= "The Blood God, the Soulflayer, has been defeated!  We are imperiled no longer!",
--L.WORLD_BUFFS.zgHeartYojamba						= "Begin the ritual, my servants.  We must banish the heart of Hakkar back into the void!",
--L.WORLD_BUFFS.rendHead							= "The false Warchief, Rend Blackhand, has fallen!",
--L.WORLD_BUFFS.blackfathomBoon						= "boon of Blackfathom"
