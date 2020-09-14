if GetLocale() ~= "itIT" then return end
if not DBM_GUI_L then DBM_GUI_L = {} end
local L = DBM_GUI_L

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Tradotto da "
L.TranslationBy 			= "Kaliad, Mattmagic @ Pozzo dell'Eternità"
L.Website					= "Visitaci su Discord a |cFF73C2FBhttps://discord.gg/deadlybossmods|r. Sequici su Twitter @deadlybossmods o @MysticalOS"
L.WebsiteButton				= "Sito Web"

L.OTabBosses	= "Boss"
L.OTabOptions	= "Opzioni"

L.TabCategory_Options	 	= "Opzioni Generali"
L.TabCategory_OTHER    		= "Altre Mod"

L.BossModLoaded 			= "%s statistiche"
L.BossModLoad_now 			= [[Boss Mod non caricata.
Verrà caricata all'entrata dell'istanza.
Puoi cliccare il pulsante per forzarne il caricamento.]]

L.PosX						= 'Posizione X'
L.PosY						= 'Posizione Y'

L.MoveMe 					= 'Spostami'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Annulla'
L.Button_LoadMod 			= 'Carica AddOn'
L.Mod_Enabled				= "Abilita boss mod"
L.Mod_Reset					= "Ripristina predefiniti"
L.Reset 					= "Resetta"

L.Enable  					= "Abilita"
L.Disable					= "Disabilita"

L.NoSound					= "Nessun Suono"

L.IconsInUse				= "Icone usate da questa mod"

-- Tab: Boss Statistics
L.BossStatistics			= "Statistiche Boss"
L.Statistic_Kills			= "Sconfitto:"
L.Statistic_Wipes			= "Disfatte:"
L.Statistic_Incompletes		= "Incompleti:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Migliore:"
L.Statistic_BestRank		= "Migliore Grado:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Core Options
L.General 					= "Impostazioni Generali DBM"
L.EnableMiniMapIcon			= "Mostra pulsante minimappa"
L.UseSoundChannel			= "Imposta canale audio usato da DBM per gli avvisi sonori."
L.UseMasterChannel			= "Canale audio Principale."
L.UseDialogChannel			= "Canale audio Dialoghi."
L.UseSFXChannel				= "Canale audio Effetti Sonori (SFX)."
L.Latency_Text				= "Soglia latenza sincronizzazione: %d"

L.ModelOptions				= "Opzioni Visualizzatore 3D"
L.EnableModels				= "Abilita modelli 3D nelle opzioni boss"
L.ModelSoundOptions			= "Imposta opzioni sonore per visualizzatore"
L.ModelSoundShort			= "Breve"
L.ModelSoundLong			= "Lungo"

L.Button_RangeFrame			= "Distanziometro"
L.Button_InfoFrame			= "Riquadro Informativo"
L.Button_TestBars			= "Barre di Test"
L.Button_ResetInfoRange		= "Reset Informativo/Distanziometro"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Avvisi di Incursione"
L.RaidWarning_Header		= "Opzioni Avvisi Incursione"
L.RaidWarnColors 			= "Colori Avvisi Incursione"
L.RaidWarnColor_1 			= "Colore 1"
L.RaidWarnColor_2 			= "Colore 2"
L.RaidWarnColor_3		 	= "Colore 3"
L.RaidWarnColor_4 			= "Colore 4"
L.InfoRaidWarning			= [[Puoi specificare la posizione e i colori degli Avvisi di Incursione.
Questi messaggi sono usati ad esempio per "Giocatore X è afflitto da Y".]]
L.ColorResetted 			= "Impostazioni colori di questo campo resettate."
L.ShowWarningsInChat 		= "Visualizza avvisi nel riquadro Chat"
L.WarningIconLeft 			= "Mostra icona nel lato sinistro"
L.WarningIconRight 			= "Mostra icona nel lato destro"
L.WarningIconChat 			= "Mostra icone nel riquadro chat"
L.WarningAlphabetical		= "Ordina nomi alfabeticamente"
L.Warn_Duration				= "Durata avviso: %0.1f s"
L.None						= "Nessuno"
L.Random					= "Casuale"
L.Outline					= "Contorno"
L.ThickOutline				= "Contorno spesso"
L.MonochromeOutline			= "Contono monocromatico"
L.MonochromeThickOutline	= "Contono spesso monocromatico"
L.RaidWarnSound				= "Esegui suoni avviso incursione"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Messaggi Generali"
L.CoreMessages				= "Opzioni Messaggi Generali"
L.ShowPizzaMessage 			= "Visualizza i messaggi inviati a tutti in chat"
L.ShowAllVersions	 		= "Mostra versioni boss mod dei membri del gruppo in un riquadro chat durante il controllo. (Se disabilitato, mostra comunque obsoleti/sommario attuale)"
L.CombatMessages			= "Messaggi di Combattimento - Opzioni"
L.ShowEngageMessage 		= "Visualizza in chat il messaggio di Ingaggio"
L.ShowDefeatMessage 		= "Visualizza in chat il messaggio di uccisione"
L.ShowGuildMessages 		= "Mostra messaggi ingaggio/vittoria/disfatta per i raid di gilda nel riquadro chat"
L.ShowGuildMessagesPlus		= "Mostra inoltre i messaggi ingaggio/vittoria/disfatta Mitiche+ per i gruppi di gilda (richiede opzione incursione)"
L.Area_WhisperMessages		= "Opzioni Sussurri"
L.AutoRespond 				= "Rispondi automaticamente ai sussurri mentre stai combattendo"
L.WhisperStats 				= "Nelle risposte ai sussurri, aggiungi le informazioni su uccisioni e sconfitte."
L.DisableStatusWhisper 		= "Disabilita sussurri stato per il gruppo (richiede Capoincursione). Solo per incursioni normale/eroico/mitico e spedizioni mitiche+"
L.DisableGuildStatus 		= "Disabilita messaggi di progresso alla gilda per il gruppo (richiede Capoincursione)."

-- Tab: Barsetup
L.TabCategory_Timers		= "Impostazioni barre"
L.BarTexture 				= "Texture barre"
L.BarStyle					= "Stile barre"
L.BarDBM					= "DBM (animate)"
L.BarSimple					= "Semplici (non animate)"
L.BarStartColor				= "Colore iniziale"
L.BarEndColor 				= "Colore finale"
L.Bar_Height				= "Altezza barra: %d"
L.Slider_BarOffSetX 		= "Sfasamento X: %d"
L.Slider_BarOffSetY 		= "Sfasamento Y: %d"
L.Slider_BarWidth 			= "Lunghezza Barra: %d"
L.Slider_BarScale 			= "Scala Barra: %0.2f"
--Types
L.BarStartColorAdd			= "Colore inizio (Add)"
L.BarEndColorAdd			= "Colore fine (Add)"
L.BarStartColorAOE			= "Colore inizio (AOE)"
L.BarEndColorAOE			= "Colore fine (AOE)"
L.BarStartColorDebuff		= "Colore inizio (Bersaglio)"
L.BarEndColorDebuff			= "Colore fine (Bersaglio)"
L.BarStartColorInterrupt	= "Colore inizio (Interruzione)"
L.BarEndColorInterrupt		= "Colore fine (Interruzione)"
L.BarStartColorRole			= "Colore inizio (Ruolo)"
L.BarEndColorRole			= "Colore fine (Ruolo)"
L.BarStartColorPhase		= "Colore inizio (Fase)"
L.BarEndColorPhase			= "Colore fine (Fase)"
L.BarStartColorUI			= "Colore inizio (Utente)"
L.BarEndColorUI				= "Colore fine (Utente)"
--Type 7 options
L.Bar7Header				= "Opzioni Barra Utente"
L.Bar7ForceLarge			= "Usa sempre barra larga"
L.Bar7CustomInline			= "Usa icona allineata '!' personalizzata"
--Dropdown Options
L.CBTGeneric				= "Generico"
L.CBTAdd					= "Add"
L.CBTAOE					= "AOE"
L.CBTTargeted				= "Bersaglio"
L.CBTInterrupt				= "Interruzione"
L.CBTRole					= "Ruolo"
L.CBTPhase					= "Fase"
L.CBTImportant				= "Importante (Utente)"
L.CVoiceOne					= "Voce Conteggio 1"
L.CVoiceTwo					= "Voce Conteggio 2"
L.CVoiceThree				= "Voce Conteggio 3"

-- Tab: Timers
L.AreaTitle_BarColors		= "Colore Barre per tipo temporizzatore"
L.AreaTitle_BarSetup		= "Opzioni Generali Barra"
L.AreaTitle_BarSetupSmall 	= "Opzioni Barra Piccola"
L.AreaTitle_BarSetupHuge	= "Opzioni Barra Gigante"
L.EnableHugeBar 			= "Abilita barra gigante (Barra 2)"
L.BarIconLeft 				= "Icona Sinistra"
L.BarIconRight 				= "Icona Destra"
L.ExpandUpwards				= "Espandi verso l'alto"
L.FillUpBars				= "Riempi la barre"
L.ClickThrough				= "Disabilita eventi mouse (clicca attraverso)"
L.Bar_Decimal				= "Decimali mostrati dopo tempo: %d"
L.Bar_Alpha					= "Trasparenza barra: %0.1f"
L.Bar_EnlargeTime			= "Allargamento barra sotto i: %d"
L.BarSpark					= "Barra scintillante"
L.BarFlash					= "Flash barra in scadenza"
L.BarSort					= "Ordina per tempo rimasto"
L.BarColorByType			= "Colora per tipo"
L.BarInlineIcons			= "Mostra icone allineate"
L.ShortTimerText			= "Usa testo breve temporizzatore (se disponibile)"
L.KeepBar					= "Mantieni temporizzatore attivo fino al cast"
L.KeepBar2					= "(se supportato dalla mod)"
L.FadeBar					= "Fai sparire temporizzatori per abilità fuori portata"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Avvisi Speciali di Incursione"
L.Area_SpecWarn				= "Opzioni Avvisi Speciali"
L.SpecWarn_ClassColor		= "Usa colore classe per avvisi speciali"
L.ShowSWarningsInChat 		= "Mostra avvisi speciali nella chat"
L.SWarnNameInNote			= "Usa opzioni SW5 se una nota contiene il tuo nome"
L.SpecialWarningIcon		= "Mostra icone negli avvisi speciali"
L.SpecWarn_FlashFrameRepeat	= "Ripeti %d volte (se abilitato)"
L.SpecWarn_FlashRepeat		= "Ripeti flash"
L.SpecWarn_FlashColor		= "Colore flash %d"
L.SpecWarn_FlashDur			= "Durata flash: %0.1f"
L.SpecWarn_FlashAlpha		= "Trasp. flash: %0.1f"
L.SpecWarn_DemoButton		= "Esempio"
L.SpecWarn_ResetMe			= "Ripristina predefiniti"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Avvisi Parlati"
L.Area_VoiceSelection		= "Selezioni Voce"
L.CountdownVoice			= "Prima Voce conto alla rovescia"
L.CountdownVoice2			= "Seconda Voce conto alla rovescia"
L.CountdownVoice3			= "Terza Voce conto alla rovescia"
L.VoicePackChoice			= "Pacchetto vocale avvisi parlati"
L.Area_CountdownOptions		= "Opzioni Conto alla Rovescia"
L.Area_VoicePackOptions		= "Opzioni Pacchetto Vocale (pacchetti di terze parti)"
L.SpecWarn_NoSoundsWVoice	= "Filtra suoni avvisi speciali che hanno anche avvisi con avvisi parlati..." -- TODO: Ricontrollare
L.SWFNever					= "Mai"
L.SWFDefaultOnly			= "quando gli avvisi speciali usano suono pred. (Permetti esecuzione di suoni personali)"
L.SWFAll					= "quando gli avvisi speciali usano qualunque suono"
L.SpecWarn_AlwaysVoice		= "Riproduci sempre tutti gli avvisi parlati (Anche se Avvisi Speciali disabilitati. Utili per Capo Incursione, sconsigliati altrimenti)"
-- TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?
L.Area_GetVEM				= "Ottieni Pacchetto Vocale VEM"
L.VEMDownload				= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/dbm-voicepack-vem|r"
L.Area_BrowseOtherVP		= "Altri pacchetti vocali su curse"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "Altri conti alla rovescia su curse"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Tab: Event Sounds
L.Panel_EventSounds			= "Eventi Sonori"
L.Area_SoundSelection		= "Selezione Suoni (scorri i menu con la rotellina)"
L.EventVictorySound			= "Suono riprodotto alla vittoria"
L.EventWipeSound			= "Suono riprodotto alla disfatta"
L.EventEngageSound			= "Suono riprodotto all'ingaggio"
L.EventDungeonMusic			= "Musica riprodotta nelle spedizioni/incursioni"
L.EventEngageMusic			= "Musica riprodotta negli scontri"
L.Area_EventSoundsExtras	= "Opzioni Eventi Sonori"
L.EventMusicCombined		= "Permetti tutte le selezioni musicali nelle spedizioni e scontri (modificando l'opzione è necessario eseguire UIReload)"
L.Area_EventSoundsFilters	= "Filtro Condizionale Eventi Sonori"
L.EventFilterDungMythicMusic= "Non riprodurre musica spedizioni nelle difficoltà Mitica/Mitica+"
L.EventFilterMythicMusic	= "Non riprodurre musica scontro nelle difficoltà Mitica/Mitica+"
-- TODO: TRADURRE DA QUI
-- Tab: Global Filter
L.Panel_SpamFilter			= "Forzamenti & Filtri"
L.Area_SpamFilter_Anounces	= "Announce Global Disable & Filter Options"
L.SpamBlockNoShowAnnounce	= "Niente testo o suoni per QUALUNQUE annuncio generale"
L.SpamBlockNoShowTgtAnnounce= "Niente testo o suoni per annuncio generale BERSAGLIO (filtro sopra sovrascrive questo)"
L.SpamBlockNoSpecWarnText	= "Niente annunci speciali, ma permetti pacchetti vocali (filtro sopra sovrascrive questo)"

L.Area_SpamFilter_Timers	= "Timer Global Disable & Filter Options"
L.SpamBlockNoShowTimers		= "Niente temporizzatori mod (Boss Mod/CM/LFG/Respawn)"
L.SpamBlockNoShowUTimers	= "Niente temporizzatori utente (Personalizzato/Pull/Pausa)"
L.SpamBlockNoCountdowns		= "Niente suoni conto alla rovescia"

L.Area_SpamFilter_Misc		= "Misc Global Disable & Filter Options"
L.SpamBlockNoSetIcon		= "Nessuna icona sui bersagli"
L.SpamBlockNoRangeFrame		= "Non mostrare distanziometro"
L.SpamBlockNoInfoFrame		= "Non mostrare riquadro info"
L.SpamBlockNoHudMap			= "Non mostrare HudMap"
L.SpamBlockNoNameplate		= "Non mostrare Auree Barre Vitali (disabilita completamente)"
L.SpamBlockNoNameplateLines	= "Non mostrare linee Aura Barre Vitali (icone aura visibili)"
L.SpamBlockNoYells			= "Non urlare in chat"
L.SpamBlockNoNoteSync		= "Non accettare note condivise"

L.Area_Restore				= "Ripristino Opzioni DBM (Se DBM ripristina lo stato utente al termine della mod)"
L.SpamBlockNoIconRestore	= "Non salvare stato icone e ripristinale al termine del combattimento"
L.SpamBlockNoRangeRestore	= "Non ripristinare distanziometro allo stato precedente quando la mod chiama 'nascondi'"

-- Tab: Spam Filter
L.Area_SpamFilter			= "Opzioni Filtro Spam"
L.DontShowFarWarnings		= "Non mostrare annunci/temporizzatori di eventi lontani"
L.StripServerName			= "Togli nome reame negli avvisi e temporizzatori"
L.FilterVoidFormSay			= "Niente posizioni/conteggi in chat in Forma del Vuoto"

L.Area_SpecFilter			= "Opzioni Filtro Ruolo"
L.FilterTankSpec			= "Filtra avvisi per i Tank quando senza spec da Tank. (Nota: E' sconsigliato disabilitarlo a tutti gli utenti in quanto gli avvisi 'taunt' sono tutti attivi di base.)"
L.FilterInterruptsHeader	= "Filtra avvisi per abilità interrompibili basate sulle preferenze comportamento."
L.FilterInterrupts			= "Se il caster non è obiettivo/focus attuale (Sempre)."
L.FilterInterrupts2			= "Se il caster non è obiettivo/focus attuale (Sempre), CD interrompibili (Solo Boss)"
L.FilterInterrupts3			= "Se il caster non è obiettivo/focus attuale (Sempre), CD interrompibili (Boss/Scartini)"
L.FilterInterruptNoteName	= "Filtra avvisi solo per abilità interrompibili (con conteggio) se l'avviso non contiene il tuo nome in nota personalizzata"
L.FilterDispels				= "Filtra avvisi per abilità dispellabili se i tuoi dispel sono in ricarica"
L.FilterTrashWarnings		= "Filtra tutti gli avvisi degli scartini nelle spedizioni normali ed eroiche"

L.Area_PullTimer			= "Opzioni Filtro Temporizzatori Pull, Pause, Combattimenti e Personalizzati"
L.DontShowPTNoID			= "Blocca Temporizzatori Pull se non inviati dalla tua zona"
L.DontShowPT				= "Niente barre Temporizzatore Pull/Pausa"
L.DontShowPTText			= "Niente annunci testuali Temporizzatore Pull/Pausa"
L.DontShowPTCountdownText	= "Niente testo conto alla rovescia Pull"
L.DontPlayPTCountdown		= "Niente audio conto alla rovescia Pull/Pausa/Combattimento/Temp. Personale"
L.PT_Threshold				= "No audio conto alla rovescia Pull/Pausa/Combattimento/Temp. Personale sopra: %d"

L.Panel_HideBlizzard		= "Forzature Blizzard"
L.Area_HideBlizzard			= "Opzioni Forzature Blizzard"
L.HideBossEmoteFrame		= "Nascondi riquadro emote boss durante i combattimenti"
L.HideWatchFrame			= "Nascondi tracciamento obiettivi durante i boss se non tracciati e se non in Mitiche+"
L.HideGarrisonUpdates		= "Nascondi notifiche seguaci durante i boss"
L.HideGuildChallengeUpdates	= "Nascondi notifiche sfide gilda durante i boss"
L.HideQuestTooltips			= "Nascondi obiettivi missioni dai suggerimenti durante i boss"
L.HideTooltips				= "Nascondi completamente suggerimenti durante i boss"
L.DisableSFX				= "Disabilita canale effetti sonori durante i boss"
L.DisableCinematics			= "Nascondi cinematiche in gioco"
L.OnlyFight					= "Solo durante i combattimenti, dopo aver visto il filmato almeno una volta"
L.AfterFirst				= "Nelle istanze, dopo aver visto il filmato almeno una volta"
L.CombatOnly				= "Disabilita in combattimento (qualunque)"
L.RaidCombat				= "Disabilita in combattimento (solo boss)"

L.Panel_ExtraFeatures		= "Funzionalità Aggiuntive"
--
L.Area_ChatAlerts			= "Opzioni Avviso Testuale"
L.RoleSpecAlert				= "Mostra avviso all'entrata dell'incursione quando spec del bottino e giocatore non coincidono"
L.CheckGear					= "Mostra avviso equipaggiamento al pull (quando l'ilvl equipaggiato è almeno 40 livelli più basso di quello in borsa o in mancanze dell'arma principale)"
L.WorldBossAlert			= "Mostra avviso quando boss mondiali sono stati ingaggiati sul tuo reame da gildani o amici (inaccurato se il mittente è in zona condivisa)"
--
L.Area_SoundAlerts			= "Opzioni Avvisi Sonori/Flash"
L.LFDEnhance				= "Esegui suono controllo gruppo e intermittenza icona applicazione per il controllo ruoli e proposte CdB/LFG nel canale audio Principale o Dialoghi (funzionano anche con effetti disattivati e generalmente sono più alti)"
L.WorldBossNearAlert		= "Esegui suono controllo gruppo e intermittenza icona applicazione quando boss mondiali vicini che ti servono vengono pullati"
L.RLReadyCheckSound			= "Al controllo gruppo, riproduci suono canale audio Principale o Dialoghi e intermittenza icona applicazione."
L.AFKHealthWarning			= "Esegui suono controllo gruppo e intermittenza icona applicazione se stai perdendo vita da AFK"
L.AutoReplySound			= "Esegui suono controllo gruppo e intermittenza icona applicazione alla ricezione di risposte automatiche DBM"
--
L.TimerGeneral 				= "Opzioni Temporizzatore"
L.SKT_Enabled				= "Mostra temporizzatore record vittorie del combattimento, se disponibile"
L.ShowRespawn				= "Mostra temporizzatore respawn dopo un eliminazione"
L.ShowQueuePop				= "Mostra tempo rimanente per accettare la coda (LFG, CdB, ecc)"
--
L.Area_AutoLogging			= "Opzioni Registro Automatico"
L.AutologBosses				= "Registra automaticamente gli incontri log con il registro di combattimento blizzard (Usa /dbm pull prima dei boss per registrare prepozze e altri eventi precedenti.)"
L.AdvancedAutologBosses		= "Regostra automaticamente gli scontri boss con Transcriptor"
L.LogOnlyNonTrivial			= "Registra gli scontri boss incursione solo dell'espansione attuale (esclude Ricerca Incursioni/gruppo/scenari/vecchi contenuti)"
--
L.Area_3rdParty				= "Opzioni di Terze Parti"
L.ShowBBOnCombatStart		= "Esegui controllo Big Brother a inizio combattimento"
L.BigBrotherAnnounceToRaid	= "Annuncia risultati Big Brother all'incursione"
L.Area_Invite				= "Opzioni Invito"
L.AutoAcceptFriendInvite	= "Accetta automaticamente inviti gruppo da parte di amici"
L.AutoAcceptGuildInvite		= "Accetta automaticamente inviti gruppo da parte di gildani"
L.Area_Advanced				= "Opzioni Avanzate"
L.FakeBW					= "Fingi di essere BigWigs nei controlli versioni anziché DBM (Utile per le gilde che forzano l'uso di BigWigs)"
L.AITimer					= "Genera automaticamente temporizzatori per combattimenti vai visti utilizzando il Temporizzatore IA incluso in DBM (Utile per pullare un boss in prova per la prima volta come sulle beta o PTR). Nota: Non è garantito il funzionamento con add multipli con la stessa abilità."

L.Panel_Profile				= "Profili"
L.Area_CreateProfile		= "Creazione Profilo per Opzioni DBM Base"
L.EnterProfileName			= "Inserisci nome profilo"
L.CreateProfile				= "Crea profilo a impostazioni predefinite"
L.Area_ApplyProfile			= "Imposta Profilo Attivo per Opzioni DBM Base"
L.SelectProfileToApply		= "Seleziona profilo da applicare"
L.Area_CopyProfile			= "Copia profilo per Opzioni DBM Base"
L.SelectProfileToCopy		= "Seleziona Profilo da copiare"
L.Area_DeleteProfile		= "Rimuovi Profilo per Opzioni DBM Base"
L.SelectProfileToDelete		= "Seleziona profilo da rimuovere"
L.Area_DualProfile			= "Opzioni profilo boss mod"
L.DualProfile				= "Abilita supporto per differenti opzioni boss mod in base a spec. (La gestione dei profili boss mod avviene dal menu di stato delle mod caricate)"

L.Area_ModProfile			= "Copia impostazioni mod da altro pg/spec o elimina impostazioni mod"
L.ModAllReset				= "Ripristina impostazioni mod"
L.ModAllStatReset			= "Ripristina statistiche mod"
L.SelectModProfileCopy		= "Copia tutte impostazioni da"
L.SelectModProfileCopySound	= "Copia impostazioni suoni da"
L.SelectModProfileCopyNote	= "Copia impostazioni note da"
L.SelectModProfileDelete	= "Elimina impostazioni mod"

-- Misc
L.FontType					= "Seleziona carattere"
L.FontStyle					= "Stile carattere"
L.FontColor					= "Colore carattere"
L.FontShadow				= "Ombre"
L.FontSize					= "Dimensioni carattere: %d"

L.FontHeight	= 16
