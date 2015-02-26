if GetLocale() ~= "deDE" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Übersetzt von "
L.TranslationBy 			= "Ebmor@EU-Malorne"
L.Website					= "Besuche die Diskussions- und Support-Foren: |cFF73C2FBwww.deadlybossmods.com|r. Folge dem Hauptentwickler auf Twitter: @MysticalOS"
L.WebsiteButton				= "Foren"

L.OTabBosses	= "Bosse"
L.OTabOptions	= GAMEOPTIONS_MENU

L.TabCategory_Options	 	= "Allgemeine Einstellungen"
L.TabCategory_WoD	 		= EXPANSION_NAME5
L.TabCategory_MOP	 		= EXPANSION_NAME4
L.TabCategory_CATA	 		= EXPANSION_NAME3
L.TabCategory_WOTLK 		= EXPANSION_NAME2
L.TabCategory_BC 			= EXPANSION_NAME1
L.TabCategory_CLASSIC		= EXPANSION_NAME0
L.TabCategory_PVP 			= PVP
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

-- Tab: General Core Options
L.General 					= "Allgemeine Grundeinstellungen"
L.EnableDBM 				= "Aktiviere DBM"
L.EnableMiniMapIcon			= "Aktiviere Minimap-Symbol"
L.UseMasterVolume			= "Benutze Master-Audiokanal um DBM-Sounddateien abzuspielen"
L.Latency_Text				= "Maximale Synchronisierungslatenz: %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "Allgemeine Einstellungen für Timer"
L.SKT_Enabled				= "Zeige immer Timer für Rekordzeit (ignoriert Boss-spezifische Einstellung)"
L.CRT_Enabled				= "Zeige Zeit bis zur nächsten Wiederbelebungsaufladung im Kampf (nur bei 6.x-Schwierigkeitgraden)"
L.ChallengeTimerOptions		= "Timer für den schnellsten Abschluss im Herausforderungsmodus"
L.ChallengeTimerPersonal	= "Persönliche Bestzeit"
L.ChallengeTimerGuild		= "Bestzeit der Gilde"
L.ChallengeTimerRealm		= "Bestzeit des Realms"

L.ModelOptions				= "Einstellungen für 3D-Modellanzeige"
L.EnableModels				= "Aktiviere 3D-Modelle in den Bosseinstellungen"
L.ModelSoundOptions			= "Soundeinstellung für Modellanzeige"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.Button_RangeFrame			= "Zeige Abstandsfenster"
L.Button_InfoFrame			= "Zeige Infofenster"
L.Button_TestBars			= "Starte Testbalken"

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
L.ShowFakedRaidWarnings 	= "Zeige Warnungen als künstliche Schlachtzugwarnungen"
L.WarningIconLeft 			= "Zeige Symbol links an"
L.WarningIconRight 			= "Zeige Symbol rechts an"
L.WarningIconChat 			= "Zeige Symbole im Chatfenster"
L.Warn_FontType				= "Schriftart für Schlachtzugwarnungen"
L.Warn_FontStyle			= "Schriftstil für Schlachtzugwarnungen"
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
L.ShowLoadMessage 			= "Zeige Lademeldungen für Mods im Chatfenster"
L.ShowPizzaMessage 			= "Zeige Meldungen für Timerbroadcasts im Chatfenster"
L.ShowCombatLogMessage 		= "Zeige DBM-Meldungen für das spieleigene Kampflog im Chatfenster"
L.ShowTranscriptorMessage	= "Zeige DBM-Meldungen für das \"Transcriptor\"-Log im Chatfenster"
L.ShowAllVersions	 		= "Zeige Boss Mod Versionen aller Gruppenmitglieder im Chatfenster"
L.CombatMessages			= "Kampfmeldungen"
L.ShowEngageMessage 		= "Zeige Meldungen für den Beginn von Kämpfen im Chatfenster"
L.ShowKillMessage 			= "Zeige Meldungen für Siege im Chatfenster"
L.ShowWipeMessage 			= "Zeige Meldungen für Niederlagen im Chatfenster"
L.ShowGuildMessages 		= "Zeige Meldungen für Kampfbeginn/Siege/Niederlagen deiner Gilde im Chatfenster"
L.ShowRecoveryMessage 		= "Zeige Meldungen für Neukalibrierung der Timer im Chatfenster"
L.WhisperMessages			= "Flüstermeldungen"
L.AutoRespond 				= "Aktiviere automatische Antwort während eines Bosskampfes"
L.EnableStatus 				= "Antworte auf 'status'-Flüsteranfragen"
L.WhisperStats 				= "Füge Sieg-/Niederlagestatistik den Flüsterantworten hinzu"

-- Tab: Barsetup
L.BarSetup					= "Balkeneinstellungen"
L.BarTexture				= "Balkentextur"
L.BarStyle					= "Balkenstil"
L.BarDBM					= "DBM"
L.BarBigWigs				= "BigWigs (keine Animation)"
L.BarStartColor				= "Startfarbe"
L.BarEndColor 				= "Endfarbe"
L.Bar_Font					= "Schriftart für Balken"
L.Bar_FontSize				= "Schriftgröße: %d"
L.Bar_Height				= "Balkenhöhe: %d"
L.Slider_BarOffSetX 		= "Abstand X: %d"
L.Slider_BarOffSetY 		= "Abstand Y: %d"
L.Slider_BarWidth 			= "Breite: %d"
L.Slider_BarScale 			= "Skalierung: %0.2f"
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

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Spezialwarnungen"
L.Area_SpecWarn				= "Einstellungen für Spezialwarnungen"
L.SpecWarn_Enabled			= "Zeige Spezialwarnungen für Bossfähigkeiten"
L.ShowSWarningsInChat 		= "Zeige Spezialwarnungen im Chatfenster"
L.SpecWarn_FlashFrame		= "Aufblinkender Bildschirm bei Spezialwarnungen"
L.SpecWarn_FlashFrameRepeat	= "Wiederhole %d-mal (falls aktiviert)"
L.SpecWarn_Font				= "Schriftart für Spezialwarnungen" --unused
L.SpecWarn_FontSize			= "Schriftgröße: %d"
L.SpecWarn_FontColor		= "Schriftfarbe"
L.SpecWarn_FontType			= "Schriftart für Spezialwarnungen"
L.SpecWarn_FlashRepeat		= "Wiederh. Blinken"
L.SpecWarn_FlashColor		= "Blinkfarbe"
L.SpecWarn_FlashDur			= "Blinkdauer: %0.1f"
L.SpecWarn_FlashAlpha		= "Blinkalpha: %0.1f"
L.SpecWarn_DemoButton		= "Zeige Beispiel"
L.SpecWarn_MoveMe			= "Positionieren"
L.SpecWarn_ResetMe			= "Zurücksetzen"
L.SpecialWarnSound			= "Sound für Spezialwarnungen, die dich oder deine Rolle betreffen"
L.SpecialWarnSound2			= "Sound für Spezialwarnungen, die jeden betreffen"
L.SpecialWarnSound3			= "Sound für SEHR wichtige Spezialwarnungen"
L.SpecialWarnSound4			= "Sound für \"Lauf weg!\"-Spezialwarnungen"

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
L.SpamBlockNoSendWhisper	= "Flüstere keine Bosswarnungen an andere Spieler"
L.SpamBlockNoSetIcon		= "Setze keine Zeichen auf Ziele"
L.SpamBlockNoRangeFrame		= "Zeige kein Abstandsfenster/-radar an"
L.SpamBlockNoInfoFrame		= "Zeige kein Infofenster an"
L.SpamBlockNoHealthFrame	= "Zeige keine Lebensanzeige an"
L.SpamBlockNoCountdowns		= "Spiele keine Countdown-Sounds"

-- Tab: Spam Filter
L.Area_SpamFilter			= "Spam-Filter"
L.DontShowFarWarnings		= "Zeige keine Mitteilungen/Timer für weit entfernte Ereignisse"
L.StripServerName			= "Entferne den Realmnamen der Spieler in Warnungen und Timern"
L.SpamBlockBossWhispers		= "Aktiviere Filter für &lt;DBM&gt;-Flüstermitteilungen im Kampf"

L.Area_SpecFilter			= "Filtereinstellungen für Spezialisierungen"
L.FilterTankSpec			= "Unterdrücke Warnungen für Tanks, falls deine aktuelle Spezialisierung keine \"Schutz\"-Spezialisierung ist (Hinweis: Diese Filterung sollte normalerweise nicht deaktiviert werden, da alle individuellen \"Spott\"-Warnungen nun standardmäßig aktiviert sind.)"
--
--
--
--
--L.FilterHealerSpec		= "Unterdrücke Warnungen für Heiler, falls deine aktuelle Spezialisierung keine \"Heilung\"-Spezialisierung ist"--Not in use
--L.FilterDamagerSpec		= "Unterdrücke Warnungen für DDs, falls deine aktuelle Spezialisierung keine \"Schaden\"-Spezialisierung ist"--Not in use

L.Area_PullTimer			= "Filtereinstellungen für Pull-, Pausen-, Kampf- und benutzerdefinierte Timer"
L.DontShowPTNoID			= "Blockiere Pull-Timer, die nicht aus deiner derzeitigen Zone gesendet worden sind"
L.DontShowPT				= "Zeige keinen Timerbalken für Pull-/Pausen-Timer"
L.DontShowPTText			= "Zeige keine Mitteilungen für Pull-/Pausen-Timer im Chatfenster"
L.DontPlayPTCountdown		= "Spiele keinen akustischen Countdown für Pull-, Pausen-, Kampf- und benutzerdefinierte Timer"
L.DontShowPTCountdownText	= "Zeige keinen optischen Countdown für Pull-, Pausen-, Kampf- und benutzerdefinierte Timer"
L.PT_Threshold				= "Zeige keinen opt. Countd. f. Pull-/Pausen-/Kampf-/Nutzer-Timer über: %d"

L.Panel_HideBlizzard		= "Deaktivierung von Spielelementen"
L.Area_HideBlizzard			= "Einstellungen zum Deaktivieren und Verbergen von Spielelementen"
L.HideBossEmoteFrame		= "Verberge das Fenster \"RaidBossEmoteFrame\" während Bosskämpfen"
L.HideWatchFrame			= "Verberge das Fenster für die Questverfolgung während Bosskämpfen, falls keine Erfolge verfolgt werden"
L.HideGarrisonUpdates		= "Verberge Garnisonsmeldungen während Bosskämpfen"
L.HideGuildChallengeUpdates	= "Verberge Gildenerfolgsmeldungen während Bosskämpfen"
L.HideTooltips				= "Verberge Tooltips während Bosskämpfen"
L.DisableSFX				= "Deaktiviere Soundeffekte während Bosskämpfen"
L.HideApplicantAlerts		= "Unterdrücke Anwärteralarme in organisierten Gruppen"
L.HideApplicantAlertsFull	= "falls Gruppe voll ist"
L.HideApplicantAlertsNotL	= "falls du nicht der Gruppenleiter bist (\"Gruppe ist voll\"-Filter, falls du der Leiter bist)"
L.SpamBlockSayYell			= "Sprechblasen-Ansagen im Chatfenster ausblenden"
L.DisableCinematics			= "Verberge Videosequenzen"
L.AfterFirst				= "Nach jeweils einmaligem Abspielen"
L.Always					= ALWAYS

L.Panel_ExtraFeatures		= "Sonstige Funktionen"
L.Area_ChatAlerts			= "Alarmmeldungen im Chatfenster"
L.RoleSpecAlert				= "Zeige Alarmmeldung, wenn deine Beutespezialisierung nicht deiner aktuellen Spezialisierung beim Betreten eines Schlachtzugs entspricht"
L.CheckGear					= "Zeige Alarmmeldung beim Pull, wenn deine angelegte Gegenstandsstufe viel niedriger als die in deinen Taschen ist (40+)"
L.WorldBossAlert			= "Zeige Alarmmeldung, wenn auf deinem Realm Gildenmitglieder oder Freunde möglicherweise beginnen gegen Weltbosse zu kämpfen (ungenau falls Sender \"CRZed\" ist)"
L.Area_SoundAlerts			= "Akustische Alarme"
L.LFDEnhance				= "Spiele \"Bereitschaftscheck\"-Sound für Rollenabfragen und Einladungen der Gruppensuche im Master-Audiokanal (funktioniert z.B. auch wenn Soundeffekte abgeschaltet sind und ist allgemein lauter)"
L.WorldBossNearAlert		= "Spiele \"Bereitschaftscheck\"-Sound, wenn Weltbosse in deiner Nähe gepullt werden, die du brauchst (Boss-spezifische Einstellung)"
L.AFKHealthWarning			= "Spiele Alarmsound, wenn du Gesundheit verlierst, während du als nicht an der Tastatur (\"AFK\") markiert bist"
L.Area_AutoLogging			= "Automatische Aufzeichnungen"
L.AutologBosses				= "Automatische Aufzeichnung von Bosskämpfen im spieleigenen Kampflog (/dbm pull vor Bossen wird benötigt um die Aufzeichnung rechtzeitig für \"Pre-Pots\" und andere Ereignisse zu starten)"
L.AdvancedAutologBosses		= "Automatische Aufzeichnung von Bosskämpfen mit Addon \"Transcriptor\""
L.LogOnlyRaidBosses			= "Nur Schlachtzugbosskämpfe aufzeichnen\n(ohne Schlachtzugsbrowser-/Dungeon-/Szenarienbosskämpfe)"
L.Area_3rdParty				= "Einstellungen für Addons von Drittanbietern"
L.ShowBBOnCombatStart		= "Führe bei Kampfbeginn eine \"BigBrother\"-Buffprüfung durch"
L.BigBrotherAnnounceToRaid	= "Verkünde Ergebnis der \"BigBrother\"-Buffprüfung zum Schlachtzug"
L.Area_Invite				= "Einstellungen für Einladungen"
L.AutoAcceptFriendInvite	= "Automatisch Gruppeneinladungen von Freunden akzeptieren"
L.AutoAcceptGuildInvite		= "Automatisch Gruppeneinladungen von Gildenmitgliedern akzeptieren"
L.Area_Advanced				= "Erweiterte Einstellungen"
L.FakeBW					= "Bei Versionsprüfungen als \"BigWigs\" ausgeben, statt als DBM (nützlich für Gilden, die die Nutzung von \"BigWigs\" erzwingen)"

L.PizzaTimer_Headline 		= 'Erstelle einen "Pizza-Timer"'
L.PizzaTimer_Title			= 'Name (z.B. "Pizza!")'
L.PizzaTimer_Hours 			= "Stunden"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sek"
L.PizzaTimer_ButtonStart 	= "Starte Timer"
L.PizzaTimer_BroadCast		= "Anderen Schlachtzugspielern anzeigen"

L.Panel_Profile				= "Profile"
L.Area_CreateProfile		= "Profilerzeugung"
L.EnterProfileName			= "Profilnamen eingeben"
L.CreateProfile				= "Erzeuge Profil für DBM Core Einstellungen"
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
L.SelectModProfileDelete	= "Lösche Mod-Einstellungen für"

-- Misc
L.FontHeight	= 16
