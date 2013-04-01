if GetLocale() ~= "deDE" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Nitram & Tandanu"

L.OTabBosses	= "Bosse"
L.OTabOptions	= "Optionen"

L.TabCategory_Options	 	= "Allgemeine Einstellungen"
L.TabCategory_MOP	 		= "Mists of Pandaria"
L.TabCategory_CATA	 		= "Cataclysm"
L.TabCategory_WOTLK 		= "Wrath of the Lich King"
L.TabCategory_BC 			= "The Burning Crusade"
L.TabCategory_CLASSIC		= "Classic"
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
L.Mod_Reset					= "Lade Standardeinstellungen für diese Seite (IN ENTWICKLUNG!)"
L.Reset 					= "Zurücksetzen"

L.Enable  					= "Aktiviere"
L.Disable					= "Deaktiviere"

L.NoSound					= "Kein Sound"

L.IconsInUse				= "Von diesem Mod benutzte Zeichen"

-- Tab: Boss Statistics
L.BossStatistics			= "Boss Statistiken"
L.Statistic_Kills			= "Siege:"
L.Statistic_Wipes			= "Niederlagen:"
L.Statistic_Incompletes		= "Abgebrochen:"
L.Statistic_BestKill		= "Schnellster:"
L.Statistic_10Man			= "10 Spieler"
L.Statistic_25Man			= "25 Spieler"

-- Tab: General Options
L.General 					= "Allgemeine DBM-Einstellungen"
L.EnableDBM 				= "Aktiviere DBM"
L.EnableMiniMapIcon			= "Aktiviere Minimap-Symbol"
L.UseMasterVolume			= "Benutze Master-Audiokanal um Sounddateien abzuspielen."
L.DisableCinematics			= "Deaktiviere Videosequenzen innerhalb von Instanzen"
L.DisableCinematicsOutside	= "Deaktiviere Videosequenzen außerhalb von Instanzen"
L.SKT_Enabled				= "Zeige immer Timer für schnellsten Sieg (ignoriert Boss-spezifische Einstellung)"
L.AutologBosses				= "Automatische Aufzeichnung von Bosskämpfen im spieleigenen Kampflog"
L.AdvancedAutologBosses		= "Automatische Aufzeichnung von Bosskämpfen mit Addon \"Transcriptor\""
L.Latency_Text				= "Maximale Synchronisierungslatenz: %d"

L.ModelOptions				= "Einstellungen für 3D-Modellanzeige"
L.EnableModels				= "Aktiviere 3D-Modelle in den Bosseinstellungen"
L.ModelSoundOptions			= "Setze Soundeinstellung für Modellanzeige"
L.ModelSoundShort			= "Kurz"
L.ModelSoundLong			= "Lang"

L.Button_RangeFrame			= "Zeige/Verberge Abstandsfenster"
L.Button_RangeRadar			= "Zeige/Verberge Abstandsradar"
L.Button_InfoFrame			= "Zeige/Verberge Infofenster"
L.Button_TestBars			= "Starte Testbalken"

L.PizzaTimer_Headline 		= 'Erstelle einen "Pizza-Timer"'
L.PizzaTimer_Title			= 'Name (z.B. "Pizza!")'
L.PizzaTimer_Hours 			= "Stunden"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sek"
L.PizzaTimer_ButtonStart 	= "Starte Timer"
L.PizzaTimer_BroadCast		= "Anderen Schlachtzugspielern anzeigen"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Schlachtzugwarnungen"
L.RaidWarning_Header		= "Einstellungen für Schlachtzugwarnungen"
L.RaidWarnColors 			= "Farben für Schlachtzugwarnungen"
L.RaidWarnColor_1 			= "Farbe 1"
L.RaidWarnColor_2 			= "Farbe 2"
L.RaidWarnColor_3		 	= "Farbe 3"
L.RaidWarnColor_4 			= "Farbe 4"
L.InfoRaidWarning			= [[Hier wird die Position und die Farben für das Fenster für Schlachtzugwarnungen festgelegt. Dieses Fenster wird für Nachrichten wie "Player X ist betroffen von Y" verwendet.]]
L.ColorResetted 			= "Diese Farbeinstellung wurde zurückgesetzt."
L.ShowWarningsInChat 		= "Zeige Warnungen im Chatfenster"
L.ShowFakedRaidWarnings 	= "Zeige Warnungen als künstliche Schlachtzugwarnungen"
L.WarningIconLeft 			= "Zeige Symbol links an"
L.WarningIconRight 			= "Zeige Symbol rechts an"
L.ShowCountdownText			= "Zeige Countdown-Text"
L.RaidWarnMessage 			= "Danke, dass du Deadly Boss Mods verwendest"
L.BarWhileMove 				= "bewegbare Schlachtzugwarnung"
L.RaidWarnSound				= "Spiele Sound bei Schlachtzugwarnung"
L.CountdownVoice			= "Setze Stimme für Countdown- und Countout-Sounds"
L.SpecialWarnSound			= "Sound für Spezialwarnungen, die dich oder deine Rolle betreffen"
L.SpecialWarnSound2			= "Sound für Spezialwarnungen, die jeden betreffen"
L.SpecialWarnSound3			= "Sound für SEHR wichtige Spezialwarnungen (tödlich für dich/Schlachtzug)"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Allgemeine Meldungen"
L.CoreMessages				= "Systemmeldungen"
L.ShowLoadMessage 			= "Zeige Lademeldungen für Mods im Chatfenster"
L.ShowPizzaMessage 			= "Zeige Meldungen für Timerbroadcasts im Chatfenster"
L.CombatMessages			= "Kampfmeldungen"
L.ShowEngageMessage 		= "Zeige Meldungen für den Beginn von Kämpfen im Chatfenster"
L.ShowKillMessage 			= "Zeige Meldungen für Siege im Chatfenster"
L.ShowWipeMessage 			= "Zeige Meldungen für Niederlagen im Chatfenster"
L.ShowRecoveryMessage 		= "Zeige Meldungen für Neukalibrierung der Timer im Chatfenster"
L.WhisperMessages			= "Flüstermeldungen"
L.AutoRespond 				= "Aktiviere automatische Antwort während eines Bosskampfes"
L.EnableStatus 				= "Antworte auf 'status'-Flüsteranfragen"
L.WhisperStats 				= "Füge Sieg-/Niederlagestatistik den Flüsterantworten hinzu"

-- Tab: Barsetup
L.BarSetup   				= "Balkenstil"
L.BarTexture 				= "Balkentextur"
L.BarStartColor				= "Startfarbe"
L.BarEndColor 				= "Endfarbe"
L.ExpandUpwards				= "Erweitere Balken nach oben"
L.Bar_Font					= "Schrift für Balken"
L.Bar_FontSize				= "Schriftgröße"
L.Slider_BarOffSetX 		= "Abstand X: %d"
L.Slider_BarOffSetY 		= "Abstand Y: %d"
L.Slider_BarWidth 			= "Balkenbreite: %d"
L.Slider_BarScale 			= "Balkenskalierung: %0.2f"
L.AreaTitle_BarSetup		= "Allgemeine Balkeneinstellungen"
L.AreaTitle_BarSetupSmall 	= "Einstellungen für kleine Balken"
L.AreaTitle_BarSetupHuge	= "Einstellungen für große Balken"
L.BarIconLeft 				= "Symbol links"
L.BarIconRight 				= "Symbol rechts"
L.EnableHugeBar 			= "Aktiviere große Balken (Balken 2)"
L.FillUpBars				= "Balken auffüllen"
L.ClickThrough				= "Mausereignisse deaktivieren (macht die Balken durchklickbar)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Spezialwarnungen"
L.Area_SpecWarn				= "Einstellungen für Spezialwarnungen"
L.SpecWarn_Enabled			= "Zeige Spezialwarnungen für Bossfähigkeiten"
L.SpecWarn_LHFrame			= "Aktiviere aufblinkenden Bildschirm bei Spezialwarnungen"
L.SpecWarn_Font				= "Schrift für Spezialwarnungen"
L.SpecWarn_DemoButton		= "Zeige Beispiel"
L.SpecWarn_MoveMe			= "Positionieren"
L.SpecWarn_FontSize			= "Schriftgröße"
L.SpecWarn_FontColor		= "Schriftfarbe"
L.SpecWarn_FontType			= "Wähle Schriftart"
L.SpecWarn_ResetMe			= "Auf Standard zurücksetzen"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Lebensanzeige"
L.Area_HPFrame				= "Einstellungen für die Lebensanzeige"
L.HP_Enabled				= "Lebensanzeige immer anzeigen (ignoriert Boss-spezifische Einstellung)"
L.HP_GrowUpwards			= "Erweitere Lebensanzeige nach oben"
L.HP_ShowDemo				= "Anzeigen"
L.BarWidth					= "Balkenbreite: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Filter / Spam-Filter"
L.Area_SpamFilter				= "Spam-Filter"
L.HideBossEmoteFrame			= "Verberge das Schlachtzugsboss-Emote-Fenster ('RaidBossEmoteFrame')"
L.StripServerName				= "Entferne den Realmnamen der Spieler in Warnungen und Timern"
L.SpamBlockBossWhispers			= "Aktiviere Filter für <DBM>-Flüstermitteilungen im Kampf"
L.BlockVersionUpdateNotice		= "Zeige Update-Meldung im Chatfenster statt als Popup"
L.ShowBigBrotherOnCombatStart	= "Führe bei Kampfbeginn eine \"BigBrother\"-Buffprüfung durch"
L.BigBrotherAnnounceToRaid		= "Verkünde Ergebnis der \"BigBrother\"-Buffprüfung zum Schlachtzug"
L.SpamBlockSayYell				= "Sprechblasen-Ansagen im Chatfenster ausblenden"

L.Area_SpamFilter_Outgoing		= "globale Filtereinstellungen"
L.SpamBlockNoShowAnnounce		= "Zeige keine Mitteilungen und spiele keine Warnungssounds"
L.SpamBlockNoSendWhisper		= "Sende keine Flüstermitteilungen an andere Spieler"
L.SpamBlockNoSetIcon			= "Setze keine Zeichen auf Ziele"
L.SpamBlockNoRangeFrame			= "Zeige kein Abstandsfenster/-radar an"
L.SpamBlockNoInfoFrame			= "Zeige kein Infofenster an"

L.Area_PullTimer				= "Filtereinstellungen für Pull-Timer"
L.DontShowPT					= "Zeige keinen Balken für Pull-Timer"
L.DontShowPTCountdownText		= "Zeige keinen Countdown-Text für Pull-Timer"
L.DontPlayPTCountdown			= "Spiele keinen Countdown-Sound für Pull-Timer"

-- Misc
L.FontHeight	= 16
