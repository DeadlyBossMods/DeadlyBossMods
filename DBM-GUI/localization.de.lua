
if GetLocale() ~= "deDE" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translation


L.MainFrame = "Deadly Boss Mods"

L.TabCategory_Options 	= "Allgemeine Einstellungen"
L.TabCategory_WOTLK 	= "Wrath of the Lich King"
L.TabCategory_BC 	= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW Classic Bosses"
L.TabCategory_OTHER     = "Other Boss Mods"

L.BossModLoaded 	= "%s statistiken"
L.BossModLoad_now 	= [[Dieser Bossmod ist nicht geladen.
Er wird automatisch geladen, wenn du die Instanz betrittst.
Ansonsten kannst du den Knopf hier verwenden um das BossMod zu laden.]]

L.PosX = 'Position X'
L.PosY = 'Position Y'

L.MoveMe 		= 'bewegbar'
L.Button_OK 		= 'OK'
L.Button_Cancel 	= 'Abbruch'
L.Button_LoadMod 	= 'Lade AddOn'
L.Mod_Enabled		= "Aktiviere BossMod"
L.Mod_EnableAnnounce	= "Dem Raid Anzeigen"
L.Reset 		= "zurücksetzen"

L.Enable  		= "aktiviere"
L.Disable		= "deaktiviere"

L.NoSound		= "Kein Sound"

-- Tab: Boss Statistics
L.BossStatistics	= "Boss Statistiken"
L.Statistic_Kills	= "Tötungen:"
L.Statistic_Wipes	= "Niederlagen:"
L.Statistic_BestKill	= "Schnellster:"
L.Statistic_Heroic	= "heroisch"

-- Tab: General Options
L.General 		= "Allgemeine DBM Optionen"
L.EnableDBM 		= "Aktiviere DBM"
L.EnableStatus 		= "Antworte auf 'status' Flüsteranfragen"
L.EnableSpamBlock	= "Aktiviere Filter für <DBM> Boss Flüstermitteilungen"
L.AutoRespond 		= "Aktiviere automatische antwort wärend eines Bosskampfs"
L.EnableMiniMapIcon	= "Aktiviere MiniMap Symbol"

L.Button_RangeFrame	= "Zeige/Verberge Abstandsfenster"
L.Button_TestBars	= "Starte Testbalken"

L.PizzaTimer_Headline 	= 'Erstelle einen "Pizza Timer"'
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
L.InfoRaidWarning	= [[Hier wird die Position des Schlachtzug Warnungs Fenster sowie die Farbe festgelegt.
Dieses Fenster wird für Nachrichten wie "Player X ist betroffen von Y" verwendet.]]
L.ColorResetted 	= "Die Farbeinstellung wurde zurückgesetzt."
L.ShowWarningsInChat 	= "Zeige Warnungen im Nachrichten-Fenster"
L.ShowFakedRaidWarnings = "Zeige Warnungen als künstliche Schlachtzugwarnung"
L.WarningIconLeft 	= "Zeige Symbol link an"
L.WarningIconRight 	= "Zeige Symbol rechts an"
L.RaidWarnMessage 	= "Danke das du DeadlyBossMods verwendest"
L.BarWhileMove 		= "Schlachtzug beweglich"
L.RaidWarnSound		= "Sound bei Schlachtzug-Warnung"
L.SpecialWarnSound	= "Sound bei Spezial-Warnung"

-- Tab: Barsetup
L.BarSetup   		= "Bar Style"
L.BarTexture 		= "Bar Textur"

L.Slider_BarOffSetX 	= "Abstand X"
L.Slider_BarOffSetY 	= "Abstand Y"
L.Slider_BarWidth 	= "Bar Breite"
L.Slider_BarScale 	= "Bar Skalierung"
L.AreaTitle_BarSetup 	= "Allgemeine Bar Optionen"
L.AreaTitle_BarSetupSmall = "Kleine Bar Optionen"
L.AreaTitle_BarSetupHuge = "Große Bar Optionen"
L.BarIconLeft 		= "Symbol links"
L.BarIconRight 		= "Symbol rechts"
L.EnableHugeBar 	= "Aktiviere große Bar(Bar 2)"



