if GetLocale() ~= "deDE" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.TranslationBy 	= "Nitram & Tandanu"

L.MainFrame = "Deadly Boss Mods"

L.TabCategory_Options 	= "Allgemeine Einstellungen"
L.TabCategory_WOTLK 	= "Wrath of the Lich King"
L.TabCategory_BC		= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW Classic Bosses"
L.TabCategory_OTHER     = "Sonstige Boss Mods"

L.BossModLoaded 	= "%s Statistiken"
L.BossModLoad_now 	= [[Dieses Boss Mod ist nicht geladen.
Er wird automatisch geladen, wenn du die Instanz betrittst.
Ansonsten kannst du den Button hier verwenden um das Boss Mod zu laden.]]

L.PosX = 'Position X'
L.PosY = 'Position Y'

L.MoveMe 		= 'bewegbar'
L.Button_OK 		= 'OK'
L.Button_Cancel 	= 'Abbruch'
L.Button_LoadMod 	= 'Lade AddOn'
L.Mod_Enabled		= "Aktiviere Boss Mod"
L.Mod_EnableAnnounce	= "Zum Raid ansagen"
L.Reset 		= "zurücksetzen"

L.Enable  		= "aktiviere"
L.Disable		= "deaktiviere"

L.NoSound		= "Kein Sound"

-- Tab: Boss Statistics
L.BossStatistics	= "Boss Statistiken"
L.Statistic_Kills	= "Kills:"
L.Statistic_Wipes	= "Niederlagen:"
L.Statistic_BestKill	= "Schnellster:"
L.Statistic_Heroic	= "heroisch"

-- Tab: General Options
L.General 		= "Allgemeine DBM Optionen"
L.EnableDBM 		= "Aktiviere DBM"
L.EnableStatus 		= "Antworte auf 'status' Flüsteranfragen"
L.AutoRespond 		= "Aktiviere automatische Antwort während eines Bosskampfes"
L.EnableMiniMapIcon	= "Aktiviere Minimap Symbol"

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
L.Tab_RaidWarning 	= "Schlachtzug Warnungen"
L.RaidWarnColors 	= "Schlachtzug Warnungsfarben"
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
L.RaidWarnSound		= "Sound bei Schlachtzug-Warnung"
L.SpecialWarnSound	= "Sound bei Spezial-Warnung"

-- Tab: Barsetup
L.BarSetup   		= "Bar Style"
L.BarTexture 		= "Bar Textur"
L.BarStartColor = "Startfarbe"
L.BarEndColor = "Endfarbe"
L.ExpandUpwards		= "Bars nach oben aufbauen"

L.Slider_BarOffSetX 	= "Abstand X: %d"
L.Slider_BarOffSetY 	= "Abstand Y: %d"
L.Slider_BarWidth 	= "Bar Breite: %d"
L.Slider_BarScale 	= "Bar Skalierung: %0.2f"
L.AreaTitle_BarSetup 	= "Allgemeine Bar Optionen"
L.AreaTitle_BarSetupSmall = "Kleine Bar Optionen"
L.AreaTitle_BarSetupHuge = "Große Bar Optionen"
L.BarIconLeft 		= "Symbol links"
L.BarIconRight 		= "Symbol rechts"
L.EnableHugeBar 	= "Aktiviere große Bar (Bar 2)"
L.FillUpBars		= "Bars auffüllen"
L.ClickThrough		= "Maus deaktivieren (macht die Timer durchklickbar)"

-- Tab: Spam Filter
L.Panel_SpamFilter		= "Spam Filter"
L.Area_SpamFilter		= "Allgemeine Spam Filter Einstellungen"
L.HideBossEmoteFrame		= "Schlachtzugsboss-Emote-Fenster verstecken"
L.SpamBlockRaidWarning		= "Ansagen von anderen Boss Mods filtern" 
L.SpamBlockBossWhispers		= "Aktiviere Filter für <DBM> Flüstermitteilungen im Kampf"
L.BlockVersionUpdatePopup	= "Zeige Update-Meldung im Chat statt als Popup"

L.ShowBigBrotherOnCombatStart	= "Zeige BigBrother Meldung bei Kampfbeginn"

