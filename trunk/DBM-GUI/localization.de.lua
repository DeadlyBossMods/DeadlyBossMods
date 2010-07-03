if GetLocale() ~= "deDE" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 	= "Nitram & Tandanu"

L.TabCategory_Options 	= "Allgemeine Einstellungen"
L.TabCategory_WOTLK 	= "Wrath of the Lich King"
L.TabCategory_BC		= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW-Classic-Bosse"
L.TabCategory_OTHER     = "Sonstige Boss-Mods"

L.BossModLoaded 	= "Statistiken von %s"
L.BossModLoad_now 	= [[Dieses Boss Mod ist nicht geladen.
Er wird automatisch geladen, wenn du die Instanz betrittst.
Ansonsten kannst du den Button hier verwenden um das Boss Mod zu laden.]]

L.PosX = 'Position X'
L.PosY = 'Position Y'

L.MoveMe 		= 'bewegbar'
L.Button_OK 		= 'OK'
L.Button_Cancel 	= 'Abbrechen'
L.Button_LoadMod 	= 'Lade AddOn'
L.Mod_Enabled		= "Aktiviere Boss Mod"
L.Mod_EnableAnnounce	= "Zum Raid ansagen"
L.Reset 		= "zurücksetzen"

L.Enable  		= "aktiviere"
L.Disable		= "deaktiviere"

L.NoSound		= "Kein Sound"

L.IconsInUse				= "Von diesem Mod benutzte Zeichen"

-- Tab: Boss Statistics
L.BossStatistics	= "Boss-Statistiken"
L.Statistic_Kills	= "Kills:"
L.Statistic_Wipes	= "Niederlagen:"
L.Statistic_BestKill	= "Schnellster:"
L.Statistic_Heroic	= "heroisch"

-- Tab: General Options
L.General 		= "Allgemeine DBM-Optionen"
L.EnableDBM 		= "Aktiviere DBM"
L.EnableStatus 		= "Antworte auf 'status'-Flüsteranfragen"
L.AutoRespond 		= "Aktiviere automatische Antwort während eines Bosskampfes"
L.EnableMiniMapIcon	= "Aktiviere Minimap-Symbol"

L.Button_RangeFrame	= "Zeige/Verberge Abstandsfenster"
L.Button_TestBars	= "Starte Testbalken"

L.PizzaTimer_Headline 	= 'Erstelle einen "Pizza-Timer"'
L.PizzaTimer_Title	= 'Name (z.b. "Pizza!")'
L.PizzaTimer_Hours 	= "Stunden"
L.PizzaTimer_Mins 	= "Min"
L.PizzaTimer_Secs 	= "Sek"
L.PizzaTimer_ButtonStart = "Starte Timer"
L.PizzaTimer_BroadCast	= "Anderen Schlachtzugspielern anzeigen"

-- Tab: Raidwarning
L.Tab_RaidWarning 	= "Schlachtzugswarnungen"
L.RaidWarning_Header		= "Schlachtzugswarnungen-Optionen"
L.RaidWarnColors 	= "Schlachtzugs-Warnungsfarben"
L.RaidWarnColor_1 	= "Farbe 1"
L.RaidWarnColor_2 	= "Farbe 2"
L.RaidWarnColor_3 	= "Farbe 3"
L.RaidWarnColor_4 	= "Farbe 4"
L.InfoRaidWarning	= [[Hier wird die Position des Schlachtzug-Warnungs-Fenster sowie die Farbe festgelegt.
Dieses Fenster wird für Nachrichten wie "Player X ist betroffen von Y" verwendet.]]
L.ColorResetted 	= "Die Farbeinstellung wurde zurückgesetzt."
L.ShowWarningsInChat 	= "Zeige Warnungen im Nachrichten-Fenster"
L.ShowFakedRaidWarnings = "Zeige Warnungen als künstliche Schlachtzugwarnung"
L.WarningIconLeft 	= "Zeige Symbol links an"
L.WarningIconRight 	= "Zeige Symbol rechts an"
L.RaidWarnMessage 	= "Danke, dass du Deadly Boss Mods verwendest"
L.BarWhileMove 		= "Warnungen bewegbar"
L.RaidWarnSound		= "Spiele Sound bei Schlachtzug-Warnung"
L.SpecialWarnSound	= "Spiele Sound bei Spezial-Warnung"

-- Tab: Barsetup
L.BarSetup   		= "Balkenstil"
L.BarTexture 		= "Balkentextur"
L.BarStartColor = "Startfarbe"
L.BarEndColor = "Endfarbe"
L.ExpandUpwards		= "Balken nach oben aufbauen"
L.Bar_Font					= "Schrift, die für Balken benutzt wird"
L.Bar_FontSize				= "Schriftgröße"
L.Slider_BarOffSetX 	= "Abstand X: %d"
L.Slider_BarOffSetY 	= "Abstand Y: %d"
L.Slider_BarWidth 	= "Balkenbreite: %d"
L.Slider_BarScale 	= "Balkenskalierung: %0.2f"
L.AreaTitle_BarSetup 	= "Allgemeine Balkenoptionen"
L.AreaTitle_BarSetupSmall = "Kleine-Balken-Optionen"
L.AreaTitle_BarSetupHuge = "Große-Balken-Optionen"
L.BarIconLeft 		= "Symbol links"
L.BarIconRight 		= "Symbol rechts"
L.EnableHugeBar 	= "Aktiviere große Balken (Balken 2)"
L.FillUpBars		= "Balken auffüllen"
L.ClickThrough		= "Maus deaktivieren (macht die Timer durchklickbar)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Spezialwarnungen"
L.Area_SpecWarn				= "Spezialwarnungs-Optionen"
L.SpecWarn_Enabled			= "Zeige Spezialwarnungen für Bossfähigkeiten"
L.SpecWarn_Font				= "Schrift, die für Spezialwarnungen benutzt wird"
L.SpecWarn_DemoButton		= "Zeige Beispiel"
L.SpecWarn_MoveMe			= "Setze Position"
L.SpecWarn_FontSize			= "Schriftgröße"
L.SpecWarn_FontColor		= "Schriftfarbe"
L.SpecWarn_FontType			= "Wähle Schriftart"
L.SpecWarn_ResetMe			= "Auf Standard zurücksetzen"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Lebensanzeige"
L.Area_HPFrame				= "Lebensanzeige-Optionen"
L.HP_Enabled				= "Lebensanzeige immer anzeigen (überschreibt boss-spezifische Option)"
L.HP_GrowUpwards			= "Erweitere Lebensanzeige nach oben"
L.HP_ShowDemo				= "Zeige Lebensanzeige"
L.BarWidth					= "Balkenbreite: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter		= "Spam-Filter"
L.Area_SpamFilter		= "Allgemeine Spam-Filter-Einstellungen"
L.HideBossEmoteFrame		= "Schlachtzugsboss-Emote-Fenster verstecken"
L.SpamBlockRaidWarning		= "Ansagen von anderen Boss Mods filtern" 
L.SpamBlockBossWhispers		= "Aktiviere Filter für <DBM>-Flüstermitteilungen im Kampf"
L.BlockVersionUpdatePopup	= "Zeige Update-Meldung im Chat statt als Popup"
L.ShowBigBrotherOnCombatStart	= "Führe Big-Brother-Buffprüfung bei Kampfbeginn durch"
L.BigBrotherAnnounceToRaid		= "Ergebnis der Big-Brother-Buffprüfung zum Raid Chat veröffentlichen"

L.Area_SpamFilter_Outgoing		= "Global Filter-Optionen"
L.SpamBlockNoShowAnnounce		= "Zeige keine Verkündungen und spiele keine Warnungssounds"
L.SpamBlockNoSendAnnounce		= "Sende keine Verkündungen an den Raidchat"
L.SpamBlockNoSendWhisper		= "Sende keine Flüstermitteilungen an andere Spieler"
L.SpamBlockNoSetIcon			= "Setze keine Zeichen auf Ziele"
