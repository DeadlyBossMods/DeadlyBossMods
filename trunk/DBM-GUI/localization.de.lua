if GetLocale() ~= "deDE" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Übersetzt von "
L.TranslationBy 			= "Ebmor@EU-Malorne"
L.Website					= "Besuche die Diskussions-/Support-Foren: |cFF73C2FBwww.deadlybossmods.com|r. Folge auf Twitter: @deadlybossmods oder @MysticalOS"
L.WebsiteButton				= "Foren"

L.OTabBosses	= "Bosse"
L.OTabOptions	= GAMEOPTIONS_MENU

L.TabCategory_Options	 	= "Allgemeine Einstellungen"
L.TabCategory_OTHER    		= "Sonstige Boss Mods"

L.BossModLoaded 			= "Statistiken von %s"
L.BossModLoad_now 			= [[Dieses Boss Mod ist nicht geladen. Es wird automatisch geladen, wenn du die Instanz betrittst. Du kannst auch auf den Button klicken um das Boss Mod manuell zu laden.]]



L.PosX						= 'Position X'
L.PosY						= 'Position Y'

L.MoveMe 					= 'Positionieren'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Abbrechen'
L.Button_LoadMod 			= 'Lade Boss Mod'
L.Mod_Enabled				= "Aktiviere Boss Mod"
L.Mod_Reset					= "Lade Standardeinstellungen"
L.Reset 					= "Zurücksetzen"

L.Enable  					= "Aktiviert"
L.Disable					= "Deaktiviert"

L.NoSound					= "Kein Sound"

L.IconsInUse				= "Zeichennutzung des Mods"

-- Tab: Boss Statistics
L.BossStatistics			= "Boss Statistiken"
L.Statistic_Kills			= "Siege:"
L.Statistic_Wipes			= "Niederlagen:"
L.Statistic_Incompletes		= "Abgebrochen:"
L.Statistic_BestKill		= "Rekordzeit:"
L.Statistic_BestRank		= "Höchste Stufe:"

-- Tab: General Core Options
L.General 					= "Allgemeine Grundeinstellungen"
L.EnableMiniMapIcon			= "Aktiviere Minimap-Symbol"
L.UseSoundChannel			= "Audiokanal um DBM-Sounddateien abzuspielen"
L.UseMasterChannel			= "Master Audiokanal"
L.UseDialogChannel			= "Dialog Audiokanal"
L.UseSFXChannel				= "Soundeffekte (SFX) Audiokanal"
L.Latency_Text				= "Maximale Synchronisierungslatenz: %d"

L.ModelOptions				= "Einstellungen für 3D-Modellanzeige"
L.EnableModels				= "Aktiviere 3D-Modelle in den Bosseinstellungen"
L.ModelSoundOptions			= "Soundeinstellung für Modellanzeige"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.Button_RangeFrame			= "Zeige Abstandsfenster"
L.Button_InfoFrame			= "Zeige Infofenster"
L.Button_TestBars			= "Starte Testbalken"
L.Button_ResetInfoRange		= "Info-/Abstandsfenster zurücksetzen"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Schlachtzugwarnungen"
L.RaidWarning_Header		= "Einstellungen für Schlachtzugwarnungen"
L.RaidWarnColors 			= "Farben für Schlachtzugwarnungen"
L.RaidWarnColor_1 			= "Farbe 1"
L.RaidWarnColor_2 			= "Farbe 2"
L.RaidWarnColor_3		 	= "Farbe 3"
L.RaidWarnColor_4 			= "Farbe 4"
L.InfoRaidWarning			= [[Hier werden Position und Farben des Fensters für Schlachtzugwarnungen festgelegt. Dieses Fenster wird für Nachrichten wie "Spieler X ist betroffen von Y" verwendet.]]

L.ColorResetted 			= "Diese Farbeinstellung wurde zurückgesetzt."
L.ShowWarningsInChat 		= "Zeige Warnungen im Chatfenster"
L.WarningIconLeft 			= "Zeige Symbol links an"
L.WarningIconRight 			= "Zeige Symbol rechts an"
L.WarningIconChat 			= "Zeige Symbole im Chatfenster"
L.WarningAlphabetical		= "Sortiere Namen alphabetisch"
L.Warn_FontType				= "Schriftart"
L.Warn_FontStyle			= "Schriftstil"
L.Warn_FontShadow			= "Schatten"
L.Warn_FontSize				= "Schriftgröße: %d"
L.Warn_Duration				= "Warnungsdauer: %ds"
L.None						= "normal"
L.Outline					= "mit Umriss"
L.ThickOutline				= "mit dickem Umriss"
L.MonochromeOutline			= "ohne Kantenglättung, mit Umriss"
L.MonochromeThickOutline	= "ohne Kantenglättung, mit dickem Umriss"
L.RaidWarnSound				= "Sound für Schlachtzugwarnungen"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Allgemeine Meldungen"
L.CoreMessages				= "Systemmeldungen"
L.ShowPizzaMessage 			= "Zeige Meldungen für Timerbroadcasts im Chatfenster"
L.ShowAllVersions	 		= "Zeige beim Durchführen einer Versionsprüfung die Boss Mod Versionen aller Gruppenmitglieder im Chatfenster (ansonsten nur eine Zusammenfassung der Aktualität)"
L.CombatMessages			= "Kampfmeldungen"
L.ShowEngageMessage 		= "Zeige Meldungen für den Beginn von Kämpfen im Chatfenster"
L.ShowDefeatMessage 		= "Zeige Meldungen für Siege/Niederlagen im Chatfenster"
L.ShowGuildMessages 		= "Zeige Meldungen für Kampfbeginn/Siege/Niederlagen deiner Gilde im Chatfenster"
L.WhisperMessages			= "Flüstermeldungen"
L.AutoRespond 				= "Aktiviere automatische Antwort während eines Bosskampfes"
L.EnableStatus 				= "Antworte auf 'status'-Flüsteranfragen"
L.WhisperStats 				= "Füge Sieg-/Niederlagestatistik den Flüsterantworten hinzu"
L.DisableStatusWhisper 		= "Deaktiviere 'status'-Flüsteranfragen für die gesamte Gruppe (nur als Gruppenleiter; nur für normale/heroische/mythische Schlachtzüge und Herausforderungsmodus/mythische Dungeons)"

-- Tab: Barsetup
L.BarSetup					= "Balkeneinstellungen"
L.BarTexture				= "Balkentextur"
L.BarStyle					= "Balkenstil"
L.BarDBM					= "DBM (mit Animationen)"
L.BarSimple					= "Einfach (ohne Animationen)"
L.BarStartColor				= "Startfarbe"
L.BarEndColor 				= "Endfarbe"
L.Bar_Font					= "Schriftart für Balken"
L.Bar_FontSize				= "Schriftgröße: %d"
L.Bar_Height				= "Balkenhöhe: %d"
L.Slider_BarOffSetX 		= "Abstand X: %d"
L.Slider_BarOffSetY 		= "Abstand Y: %d"
L.Slider_BarWidth 			= "Breite: %d"
L.Slider_BarScale 			= "Skalierung: %0.2f"
--Types
L.BarStartColorAdd			= "Startfarbe (Add)"
L.BarEndColorAdd			= "Endfarbe (Add)"
L.BarStartColorAOE			= "Startfarbe (AOE)"
L.BarEndColorAOE			= "Endfarbe (AOE)"
L.BarStartColorDebuff		= "Startfarbe (Anvisiert)"
L.BarEndColorDebuff			= "Endfarbe (Anvisiert)"
L.BarStartColorInterrupt	= "Startfarbe (Unterbrechung)"
L.BarEndColorInterrupt		= "Endfarbe (Unterbrechung)"
L.BarStartColorRole			= "Startfarbe (Rolle)"
L.BarEndColorRole			= "Endfarbe (Rolle)"
L.BarStartColorPhase		= "Startfarbe (Phase)"
L.BarEndColorPhase			= "Endfarbe (Phase)"
L.BarStartColorUI			= "Startfarbe (Nutzer)"
L.BarEndColorUI				= "Endfarbe (Nutzer)"
--Type 7 options
L.Bar7Header				= "Einstellungen für Nutzerbalken"
L.Bar7ForceLarge			= "Nutze immer großen Balken"
L.Bar7CustomInline			= "Zeichen '!' einbetten"
L.Bar7Footer				= "(keine Live-Aktual. der Dummy-Balken)"

-- Tab: Timers
L.AreaTitle_BarColors		= "Balkenfarben nach Timertyp"
L.AreaTitle_BarSetup		= "Allgemeine Balkeneinstellungen"
L.AreaTitle_BarSetupSmall 	= "Einstellungen für kleine Balken"
L.AreaTitle_BarSetupHuge	= "Einstellungen für große Balken"
L.EnableHugeBar 			= "Aktiviere große Balken (Balken 2)"
L.BarIconLeft 				= "Symbol links"
L.BarIconRight 				= "Symbol rechts"
L.ExpandUpwards				= "Erweitere oben"
L.FillUpBars				= "Balken auffüllen"
L.ClickThrough				= "Mausereignisse deaktiv. (durchklickbar)"
L.Bar_Decimal				= "Nachkomma unterhalb Restzeit: %d"
L.Bar_DBMOnly				= "Folgende Einstellungen werden nur beim \"DBM\"-Balkenstil berücksichtigt:"
L.Bar_EnlargeTime			= "Vergrößern unterhalb Restzeit: %d"
L.Bar_EnlargePercent		= "Vergrößern unterhalb Rest: %0.1f%%"
L.BarSpark					= "Balkenfunken"
L.BarFlash					= "Aufblinkende Balken bei baldigem Ablauf"
L.BarSort					= "Sortiere nach verbleibender Zeit"
L.BarColorByType			= "Färbung nach Typ"
L.BarInlineIcons			= "Zeichen einbetten"
L.ShortTimerText			= "Nutze kurzen Timertext (falls verfügbar)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Spezialwarnungen"
L.Area_SpecWarn				= "Einstellungen für Spezialwarnungen"
L.SpecWarn_ClassColor		= "Benutze Klassenfarben für Spezialwarnungen"
L.ShowSWarningsInChat 		= "Zeige Spezialwarnungen im Chatfenster"
L.SWarnNameInNote			= "Nutze SW 5 falls eine Notiz deinen Namen enthält"
L.SpecialWarningIcon		= "Zeige Symbole an Spezialwarnungen"
L.SpecWarn_FlashFrame		= "Aufblinkender Bildschirm bei Spezialwarnungen"
L.SpecWarn_FlashFrameRepeat	= "Wiederhole %d-mal (falls aktiviert)"
L.SpecWarn_Font				= "Schriftart für Spezialwarnungen" --unused
L.SpecWarn_FontSize			= "Schriftgröße: %d"
L.SpecWarn_FontColor		= "Schriftfarbe"
L.SpecWarn_FontType			= "Schriftart"
L.SpecWarn_FlashRepeat		= "Wiederh. Blinken"
L.SpecWarn_FlashColor		= "Blinkfarbe %d"
L.SpecWarn_FlashDur			= "Blinkdauer: %0.1f"
L.SpecWarn_FlashAlpha		= "Blinkalpha: %0.1f"
L.SpecWarn_DemoButton		= "Zeige Beispiel"
L.SpecWarn_MoveMe			= "Positionieren"
L.SpecWarn_ResetMe			= "Zurücksetzen"
L.SpecialWarnSound			= "Sound für Spezialwarnungen, die dich oder deine Funktion betreffen"
L.SpecialWarnSound2			= "Sound für Spezialwarnungen, die jeden betreffen"
L.SpecialWarnSound3			= "Sound für SEHR wichtige Spezialwarnungen"
L.SpecialWarnSound4			= "Sound für \"Lauf weg!\"-Spezialwarnungen"
L.SpecialWarnSound5			= "Sound für Spezialwarnungen mit Notizen die deinen Namen enthalten"

-- Tab: Heads Up Display Frame
L.Panel_HUD					= "HudMap"
L.Area_HUDOptions			= "Einstellungen für die HudMap"
L.HUDColorOverride			= "Überschreibe Mod-spezifische Farben für die HudMap"
L.HUDSizeOverride			= "Überschreibe Mod-spezifische Größen für die HudMap"
L.HUDAlphaOverride			= "Überschreibe Mod-spezifische Alphawerte (Transparenz) für die HudMap"
L.HUDTextureOverride		= "Überschreibe Mod-spezifische Texturen für die HudMap (wirkt nicht für 'Schlachtzugzeichen' Textureinstellungen)"
L.HUDColorSelect			= "HM Farbe %d"
L.HUDTextureSelect1			= "Textur für primäre HudMap"
L.HUDTextureSelect2			= "Textur für sekundäre HudMap"
L.HUDTextureSelect3			= "Textur für tertiäre HudMap"
L.HUDTextureSelect4			= "Textur für 'lauf zu' HudMap"
L.HUDSizeSlider				= "Kreisradius: %0.1f"
L.HUDAlphaSlider			= "Alpha: %0.1f"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Gesprochene Warnungen"
L.Area_VoiceSelection		= "Stimmenauswahl für akustische Zählungen und gesprochene Warnungen"
L.CountdownVoice			= "Primäre Stimme für Zählungen"
L.CountdownVoice2			= "Sekundäre Stimme für Zählungen"
L.CountdownVoice3			= "Tertiäre Stimme für Zählungen"
L.VoicePackChoice			= "Sprachpack für gesprochene Warnungen"
L.Area_CountdownOptions		= "Countdown-Einstellungen"
L.ShowCountdownText			= "Zeige Countdown-Text während Zählungen mit der primären Stimme"
L.Area_VoicePackOptions		= "Sprachpack-Einstellungen (Drittanbieter)"
L.SpecWarn_NoSoundsWVoice	= "Filtere Spezialwarnungssounds für Warnungen, für die eine Sprachausgabe verfügbar ist..."
L.SWFNever					= "nicht filtern"
L.SWFDefaultOnly			= "Spezialwarnungen eingestellt auf den Standardsound (spielt benutzerdefinierte Sounds)"
L.SWFAll					= "Spezialwarnungen eingestellt auf irgendeinen Sound"
L.SpecWarn_AlwaysVoice		= "Spiele immer alle gesprochenen Warnungen (ignoriert Boss-spezifische Einstellung, nützlich für Schlachtzugsleiter)"


-- Tab: HealthFrame
L.Panel_HPFrame				= "Lebensanzeige"
L.Area_HPFrame				= "Einstellungen für die Lebensanzeige"
L.HP_Enabled				= "Lebensanzeige immer anzeigen (ignoriert Boss-spezifische Einstellung)"
L.HP_GrowUpwards			= "Erweitere Lebensanzeige nach oben"
L.HP_ShowDemo				= "Anzeigen"
L.BarWidth					= "Balkenbreite: %d"

-- Tab: Global Filter
L.Panel_SpamFilter			= "Deaktivierung von DBM-Funktionen"
L.Area_SpamFilter_Outgoing	= "Globale Deaktivierungs- und Filtereinstellungen für DBM"
L.SpamBlockNoShowAnnounce	= "Zeige keine Mitteilungen und spiele keine Warnungssounds"
L.SpamBlockNoSpecWarn		= "Zeige keine Spezialwarnungen und spiele keine Spezialwarnungssounds"
L.SpamBlockNoShowTimers		= "Zeige keine Mod-Timer (Boss Mod/Herausforderungsmodus/Gruppensuche/Wiedererscheinen)"
L.SpamBlockNoShowUTimers	= "Zeige keine von anderen gesendeten Timer (benutzerdefiniert/Pull/Pause)"
L.SpamBlockNoSetIcon		= "Setze keine Zeichen auf Ziele"
L.SpamBlockNoRangeFrame		= "Zeige kein Abstandsfenster/-radar an"
L.SpamBlockNoInfoFrame		= "Zeige kein Infofenster an"
L.SpamBlockNoHudMap			= "Zeige keine HudMap"
L.SpamBlockNoHealthFrame	= "Zeige keine Lebensanzeige an"
L.SpamBlockNoCountdowns		= "Spiele keine Countdown-Sounds"
L.SpamBlockNoYells			= "Sende keine automatischen Schreie"
L.SpamBlockNoNoteSync		= "Akzeptiere keine geteilten Notizen"

L.Area_Restore				= "DBM-Wiederherstellungseinstellungen (Setzen des vorherigen Nutzerzustands nach Mod-Ende)"
L.SpamBlockNoIconRestore	= "Setze Markierungszeichen am Kampfende nicht auf den vorherigen Zustand zurück"
L.SpamBlockNoRangeRestore	= "Setze das Abstandsfenster nicht auf den vorherigen Zustand zurück, wenn es von Mods ausgeblendet wird"

-- Tab: Spam Filter
L.Area_SpamFilter			= "Spam-Filter"
L.DontShowFarWarnings		= "Zeige keine Mitteilungen/Timer für weit entfernte Ereignisse"
L.StripServerName			= "Entferne den Realmnamen der Spieler in Warnungen und Timern"
L.SpamBlockBossWhispers		= "Aktiviere Filter für &lt;DBM&gt;-Flüstermitteilungen im Kampf"
L.BlockVersionUpdateNotice	= "Zeige häufigere Meldungen zur Aktualisierung einer veralteten DBM-Version im Chatfenster statt als Pop-up"

L.Area_SpecFilter			= "Filtereinstellungen für Rollen"
L.FilterTankSpec			= "Unterdrücke Warnungen für Tanks, falls deine aktuelle Spezialisierung keine \"Schutz\"-Spezialisierung ist (Hinweis: Diese Filterung sollte normalerweise nicht deaktiviert werden, da alle individuellen \"Spott\"-Warnungen nun standardmäßig aktiviert sind.)"
L.FilterInterrupts			= "Unterdrücke Warnungen für unterbrechbare Zauber, falls diese nicht von deinem aktuellen Ziel oder Fokusziel gewirkt werden (Hinweis: Diese Einstellung hat keine Wirkung auf Zauber, deren Unterbrechung als kritisch eingestuft wird und die wahrscheinlich tödlich für den Schlachtzug sind, falls sie nicht unterbrochen werden.)"
L.FilterInterruptNoteName	= "Unterdrücke Warnungen für unterbrechbare Zauber (mit Zählung), falls die Warnung nicht deinen Namen in der nutzerdefinierten Notiz enthält"
L.FilterDispels				= "Unterdrücke Warnungen für reinigbare Zauber, falls deine Reinigungen noch abklingen"
L.FilterSelfHud				= "Filtere dich selbst in HudMap (ausgenommen Abstands-basierte Hud-Funktionen)"

L.Area_PullTimer			= "Filtereinstellungen für Pull-, Pausen-, Kampf- und benutzerdefinierte Timer"
L.DontShowPTNoID			= "Blockiere Pull-Timer, die nicht aus deiner derzeitigen Zone gesendet worden sind"
L.DontShowPT				= "Zeige keinen Timerbalken für Pull-/Pausen-Timer"
L.DontShowPTText			= "Zeige keine Mitteilungen für Pull-/Pausen-Timer im Chatfenster"
L.DontPlayPTCountdown		= "Spiele keinen akustischen Countdown für Pull-, Pausen-, Kampf- und benutzerdefinierte Timer"
L.DontShowPTCountdownText	= "Zeige keinen optischen Countdown für Pull-, Pausen-, Kampf- und benutzerdefinierte Timer"
L.PT_Threshold				= "Zeige keinen opt. Countd. für Pausen-/Kampf-/Nutzer-Timer über: %d"

L.Panel_HideBlizzard		= "Deaktivierung von Spielelementen"
L.Area_HideBlizzard			= "Einstellungen zum Deaktivieren und Verbergen von Spielelementen"
L.HideBossEmoteFrame		= "Verberge das Fenster \"RaidBossEmoteFrame\" während Bosskämpfen"
L.HideWatchFrame			= "Verberge das Fenster für die Questverfolgung während Bosskämpfen, falls keine Erfolge verfolgt werden"
L.HideGarrisonUpdates		= "Verberge Garnisonsmeldungen während Bosskämpfen"
L.HideGuildChallengeUpdates	= "Verberge Gildenerfolgsmeldungen während Bosskämpfen"
L.HideQuestTooltips			= "Verberge Questziele in Tooltips während Bosskämpfen"
L.HideTooltips				= "Verberge Tooltips vollständig während Bosskämpfen"
L.DisableSFX				= "Deaktiviere Soundeffekte während Bosskämpfen"
L.SpamBlockSayYell			= "Sprechblasen-Ansagen im Chatfenster ausblenden"
L.DisableCinematics			= "Verberge Videosequenzen"
L.AfterFirst				= "Nach jeweils einmaligem Abspielen"
L.Always					= ALWAYS
L.DisableTalkingHead		= "Blockiere \"Sprechenden Kopf\""
L.CombatOnly				= "im Kampf deaktivieren (alle)"
L.RaidCombat				= "im Kampf deaktivieren (nur Bosse)"

L.Panel_ExtraFeatures		= "Sonstige Funktionen"
--
L.Area_ChatAlerts			= "Alarmmeldungen im Chatfenster"
L.RoleSpecAlert				= "Zeige Alarmmeldung, wenn deine Beutespezialisierung nicht deiner aktuellen Spezialisierung beim Betreten eines Schlachtzugs entspricht"
L.CheckGear					= "Zeige Alarmmeldung beim Pull, wenn deine angelegte Gegenstandsstufe viel niedriger als die in deinen Taschen (40+) oder deine Hauptwaffe nicht ausgerüstet ist"
L.WorldBossAlert			= "Zeige Alarmmeldung, wenn auf deinem Realm Gildenmitglieder oder Freunde möglicherweise beginnen gegen Weltbosse zu kämpfen (ungenau falls Sender \"CRZed\" ist)"
--
L.Area_SoundAlerts			= "Akustische und aufblinkende Alarme"
L.LFDEnhance				= "Spiele \"Bereitschaftscheck\"-Sound und lasse Anwendungsymbol aufblicken für Rollenabfragen und Einladungen der Gruppensuche im Master- oder Dialog-Audiokanal (funktioniert z.B. auch wenn Soundeffekte abgeschaltet sind und ist allgemein lauter)"
L.WorldBossNearAlert		= "Spiele \"Bereitschaftscheck\"-Sound und lasse Anwendungsymbol aufblicken, wenn Weltbosse in deiner Nähe gepullt werden, die du brauchst"
L.RLReadyCheckSound			= "Wenn ein Bereitschaftscheck durchgeführt wird, den Sound im Master- oder Dialog-Audiokanal abspielen und Anwendungsymbol aufblicken lassen"
L.AFKHealthWarning			= "Spiele Alarmsound und lasse Anwendungsymbol aufblicken, wenn du Gesundheit verlierst, während du als nicht an der Tastatur (\"AFK\") markiert bist"
--L.AutoReplySound			--translate? (misleading option..)
--
L.TimerGeneral 				= "Allgemeine Einstellungen für Timer"
L.SKT_Enabled				= "Zeige Timer für Rekordzeit für aktuellen Kampf (falls verfügbar)"
L.CRT_Enabled				= "Zeige Zeit bis zur nächsten Wiederbelebungsaufladung im Kampf"
L.ShowRespawn				= "Zeige Zeit bis zum Wiedererscheinen des Bosses nach einer Niederlage"
L.ShowQueuePop				= "Zeige verbleibende Zeit zur Annahme einer Warteschlangeneinladung (Gruppensuche, Schlachtfelder, etc.)"
--
L.Area_AutoLogging			= "Automatische Aufzeichnungen"
L.AutologBosses				= "Automatische Aufzeichnung von Bosskämpfen im spieleigenen Kampflog (/dbm pull vor Bossen wird benötigt um die Aufzeichnung rechtzeitig für \"Pre-Pots\" und andere Ereignisse zu starten)"
L.AdvancedAutologBosses		= "Automatische Aufzeichnung von Bosskämpfen mit Addon \"Transcriptor\""
L.LogOnlyRaidBosses			= "Nur Schlachtzugbosskämpfe der aktuellen Erweiterung aufzeichnen\n(ohne Schlachtzugsbrowser-/Dungeon-/Szenarienbosskämpfe/alte Spielinhalte)"
--
L.Area_3rdParty				= "Einstellungen für Addons von Drittanbietern"
L.ShowBBOnCombatStart		= "Führe bei Kampfbeginn eine \"BigBrother\"-Buffprüfung durch"
L.BigBrotherAnnounceToRaid	= "Verkünde Ergebnis der \"BigBrother\"-Buffprüfung zum Schlachtzug"
L.Area_Invite				= "Einstellungen für Einladungen"
L.AutoAcceptFriendInvite	= "Automatisch Gruppeneinladungen von Freunden akzeptieren"
L.AutoAcceptGuildInvite		= "Automatisch Gruppeneinladungen von Gildenmitgliedern akzeptieren"
L.Area_Advanced				= "Erweiterte Einstellungen"
L.FakeBW					= "Bei Versionsprüfungen als \"BigWigs\" ausgeben, statt als DBM (nützlich für Gilden, die die Nutzung von \"BigWigs\" erzwingen)"
L.AITimer					= "Erzeuge automatisch Timer für unbekannte Kämpfe mit der in DBM eingebauten Timer-KI (nützlich beim erstmaligen Pullen eines Test-Bosses, etwa auf Beta- oder PTR-Servern) Hinweis: Dies funktioniert nicht richtig bei mehreren Gegnern mit derselben Fähigkeit."
L.AutoCorrectTimer			= "Korrigiere automatisch zu lange Timer (nützlich für Gilden, die Kämpfe im topaktuellen \"End-Content\" bestreiten, für die noch keine aktualisierten Boss Mods verfügbar sind) Hinweis: Diese Einstellung kann auch einige Timer verschlechtern, falls bei Phasenwechseln, deren Behandlung in DBM bislang noch nicht geeignet programmiert wurde, Timerrücksetzungen stattfinden."

L.PizzaTimer_Headline 		= 'Erstelle einen "Pizza-Timer"'
L.PizzaTimer_Title			= 'Name (z.B. "Pizza!")'
L.PizzaTimer_Hours 			= "Stunden"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sek"
L.PizzaTimer_ButtonStart 	= "Starte Timer"
L.PizzaTimer_BroadCast		= "Anderen Schlachtzugspielern anzeigen"

L.Panel_Profile				= "Profile"
L.Area_CreateProfile		= "Profilerzeugung für DBM Core Einstellungen"
L.EnterProfileName			= "Profilnamen eingeben"
L.CreateProfile				= "Erzeuge Profil mit Standardeinstellungen"
L.Area_ApplyProfile			= "Aktives Profil für DBM Core Einstellungen"
L.SelectProfileToApply		= "Anzuwendendes Profil auswählen"
L.Area_CopyProfile			= "Kopiere Profil für DBM Core Einstellungen"
L.SelectProfileToCopy		= "Zu kopierendes Profil auswählen"
L.Area_DeleteProfile		= "Entferne Profil für DBM Core Einstellungen"
L.SelectProfileToDelete		= "Zu löschendes Profil auswählen"
L.Area_DualProfile			= "Boss Mod Profileinstellungen"
L.DualProfile				= "Aktiviere Unterstützung für verschiedene Boss Mod Einstellungen pro Spezialisierung (Die Verwaltung der Boss Mod Profile erfolgt im geladenen Boss Mod Statistikfenster.)"

L.Area_ModProfile			= "Kopiere Mod-Einstellungen von Charakter/Spezialisierung oder lösche Mod-Einstellungen"
L.ModAllReset				= "Alle Einstellungen zurücksetzen"
L.ModAllStatReset			= "Alle Statistiken zurücksetzen"
L.SelectModProfileCopy		= "Kopiere alle Einstellungen von"
L.SelectModProfileCopySound	= "Kopiere nur Soundeinst. von"
L.SelectModProfileCopyNote	= "Kopiere nur Notizen von"
L.SelectModProfileDelete	= "Lösche Mod-Einstellungen für"

-- Misc
L.FontHeight	= 16
