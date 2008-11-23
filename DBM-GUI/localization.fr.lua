if GetLocale() ~= "frFR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TabCategory_Options 	= "Options Générales"
L.TabCategory_WOTLK 	= "Wrath of the Lich King"
L.TabCategory_BC 	= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW Classic Bosses"
L.TabCategory_OTHER     = "Autre Boss Mods"

L.BossModLoaded 	= "%s statistiques"
L.BossModLoad_now 	= [[Ce boss mod n'est pas chargé. 
Il sera chargé quand vous entrerez dans l'instance. 
Vous pouvez aussi click sur le bouton pour chargé le mod manuellement.]]

L.PosX = 'Position X'
L.PosY = 'Position Y'

L.MoveMe 		= 'déplace moi'
L.Button_OK 		= 'OK'
L.Button_Cancel 	= 'Annuler'
L.Button_LoadMod 	= 'Charge AddOn'
L.Mod_Enabled		= "Activé boss mod"
L.Mod_EnableAnnounce	= "Annonce au raid"
L.Reset 		= "reset"

L.Enable  		= "activé"
L.Disable		= "désactivé"

L.NoSound		= "Pas de Son"

-- Tab: Boss Statistics
L.BossStatistics	= "Boss Statistiques"
L.Statistic_Kills	= "Tués:"
L.Statistic_Wipes	= "Wipes:"
L.Statistic_BestKill	= "Best kill:"
L.Statistic_Heroic	= "héroique"

-- Tab: General Options
L.General 		= "Options Générales DBM"
L.EnableDBM 		= "Activé DBM"
L.EnableStatus 		= "Réponse du 'status' au chuchotement"
L.AutoRespond 		= "Activer réponse-auto pendant combat"
L.EnableMiniMapIcon	= "Afficher le bouton minicarte "

L.Button_RangeFrame	= "Afficher/Cacher range-frame"
L.Button_TestBars	= "Commencer barres de test "

L.PizzaTimer_Headline 	= 'Créer un "Pizza Timer"'
L.PizzaTimer_Title	= 'Name (e.g. "Pizza!")'
L.PizzaTimer_Hours 	= "Hours"
L.PizzaTimer_Mins 	= "Min"
L.PizzaTimer_Secs 	= "Sec"
L.PizzaTimer_ButtonStart = "Commencer Timer"
L.PizzaTimer_BroadCast	= "Diffuser au Raid"

-- Tab: Raidwarning
L.Tab_RaidWarning 	= "Alerte Raid"
L.RaidWarnColors 	= "Couleurs Alerte Raid"
L.RaidWarnColor_1 	= "Couleur 1"
L.RaidWarnColor_2 	= "Couleur 2"
L.RaidWarnColor_3 	= "Couleur 3"
L.RaidWarnColor_4 	= "Couleur 4"
L.InfoRaidWarning	= [[Vous pouvez spécifier la position et la couleurs de l'affichage d'Alerte Raid. 
Cet affichage est utilisé pour des messages comme "Joueur X est affecté par Y" messages]]
L.ColorResetted 	= "Définir la couleur de se champs have been resetted"
L.ShowWarningsInChat 	= "Afficher alertes dans la fenétre de dialogue"
L.ShowFakedRaidWarnings = "Afficher alertes as faked Raid Warning messages"
L.WarningIconLeft 	= "Afficher l'icone sur le coté gauche"
L.WarningIconRight 	= "Afficher l'icone sur le coté droit"
L.RaidWarnMessage 	= "Merci d'utiliser Deadly Boss Mods"
L.BarWhileMove 		= "Alerte-raid déplacable"
L.RaidWarnSound		= "Jouer son sur alerte-raid"
L.SpecialWarnSound	= "Jouer son on alerte-spécial"

-- Tab: Barsetup
L.BarSetup   = "Style de la Barre"
L.BarTexture = "Texture de la Barre"
L.BarStartColor = "Couleur Départ"
L.BarEndColor = "Couleur Fin"
L.ExpandUpwards		= "Expand bars upwards"

L.Slider_BarOffSetX 	= "Offset X: %d"
L.Slider_BarOffSetY 	= "Offset Y: %d"
L.Slider_BarWidth 	= "Largeur Barre: %d"
L.Slider_BarScale 	= "Bar scale: %0.2f"
L.AreaTitle_BarSetup 	= "Options Générales Barres"
L.AreaTitle_BarSetupSmall = "Options des Petites Barres"
L.AreaTitle_BarSetupHuge = "Options des Grandes Barres"
L.BarIconLeft 		= "Icone Gauche"
L.BarIconRight 		= "Icone Droit"
L.EnableHugeBar 	= "Activé Grande Barre (Barre 2)"
L.FillUpBars		= "Remplir Barres"

-- Tab: Spam Filter
L.Panel_SpamFilter		= "Filtre Spam"
L.Area_SpamFilter		= "Options Générales Filtre Spam"
L.HideBossEmoteFrame	= "Cacher raid boss emote frame"
L.SpamBlockRaidWarning	= "Filtre annonce venant d'autre boss mods" 
L.SpamBlockBossWhispers	= "Filtre <DBM> alerte chuchotement pendant combat"

