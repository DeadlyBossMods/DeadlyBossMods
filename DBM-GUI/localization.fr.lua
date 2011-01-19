if GetLocale() ~= "frFR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations
-- Initial translation : Psyco
-- Last update : 12/27/2010

L.MainFrame 		= "Deadly Boss Mods"

L.TranslationBy 	= "Sasmira Alias Zakinda & Obscurantys@EU-Archimonde"

L.TabCategory_Options 	= "Options Générales"
L.TabCategory_CATA	 	= "Cataclysm"
L.TabCategory_WOTLK 		= "Wrath of the Lich King"
L.TabCategory_BC 		= "The Burning Crusade"
L.TabCategory_CLASSIC 	= "WoW Classique"
L.TabCategory_OTHER     	= "Autres Boss Mods"

L.BossModLoaded 	= "%s statistiques"
L.BossModLoad_now 	= [[Ce boss mod n'est pas chargé.
Il sera chargé quand vous entrerez dans l'instance. 
Vous pouvez aussi cliquer sur le bouton pour charger le mod manuellement.]]

L.PosX = "Position X"
L.PosY = "Position Y"

L.MoveMe 				= "Déplacez-moi"
L.Button_OK 			= "OK"
L.Button_Cancel 		= "Annuler"
L.Button_LoadMod 		= "Charger l'AddOn"
L.Mod_Enabled			= "Activer boss mod"
L.Mod_EnableAnnounce	= "Annoncer au raid"
L.Reset 		= "Reset"

L.Enable  		= "Activer"
L.Disable		= "Désactiver"

L.NoSound		= "Pas de Son"

L.IconsInUse	= "Icônes utilisées par cet addon"

-- Tab: Boss Statistics
L.BossStatistics		= "Statistiques des boss"
L.Statistic_Kills		= "Tués:"
L.Statistic_Wipes		= "Wipes:"
L.Statistic_BestKill	= "Meilleur down:"
L.Statistic_Heroic		= "Héroïque"
L.Statistic_10Man			= "Raid10"
L.Statistic_25Man			= "Raid25"

-- Tab: General Options
L.General 			= "Options Générales de DBM"
L.EnableDBM 		= "Activer DBM"
L.EnableStatus 		= "Répondre au chuchotement par son 'status'"
L.AutoRespond 		= "Activer la réponse automatique pendant les combats"
L.EnableMiniMapIcon	= "Afficher le bouton sur minicarte "
L.FixCLEUOnCombatStart		= "Effacer le log de combat au pull"
L.SetCurrentMapOnPull		= "Régler la map sur la zone actuelle du pull ( Assure /range & /arrow accuracy)"
L.ArchaeologyHumor			= "Rendre l'Archéologie plus interessant"
L.SKT_Enabled				= "Toujours afficher le temps de la mort du Boss (Remplace les options spécifiques au boss)"
L.Latency_Text				= "Régler la sync max du seuil de latence: %d"

L.Button_RangeFrame	= "Afficher/Cacher la fenêtre de portée"
L.Button_TestBars	= "Lancer les barres de test"

L.PizzaTimer_Headline 	= 'Crée un "Pizza Timer"'
L.PizzaTimer_Title		= 'Nom (ex. "Pizza!")'
L.PizzaTimer_Hours 		= "Heures"
L.PizzaTimer_Mins 		= "Min"
L.PizzaTimer_Secs 		= "Sec"
L.PizzaTimer_ButtonStart = "Démarrer le Timer"
L.PizzaTimer_BroadCast	= "Annoncer au Raid"

-- Tab: Raidwarning
L.Tab_RaidWarning 	= "Alertes raid"
L.RaidWarning_Header		= "Options des alertes de raid"
L.RaidWarnColors 	= "Couleurs des alertes raid"
L.RaidWarnColor_1 	= "Couleur 1"
L.RaidWarnColor_2 	= "Couleur 2"
L.RaidWarnColor_3 	= "Couleur 3"
L.RaidWarnColor_4 	= "Couleur 4"
L.InfoRaidWarning	= [[Vous pouvez spécifier la position et la couleur de l'affichage des Alertes Raid.
Cet affichage est utilisé pour des messages comme "Joueur X est affecté par Y"]]
L.ColorResetted 	= "La couleur de ce champs a été réinitialisée."
L.ShowWarningsInChat 	= "Afficher les alertes dans la fenêtre de dialogue"
L.ShowFakedRaidWarnings = "Afficher les alertes comme de faux avertissements de raid"
L.WarningIconLeft 	= "Afficher l'icône à gauche"
L.WarningIconRight 	= "Afficher l'icône à droite"
L.RaidWarnMessage 	= "Merci d'utiliser Deadly Boss Mods"
L.BarWhileMove 		= "Alerte-raid déplaçable"
L.RaidWarnSound		= "Jouer un son pour les alertes raid"
L.SpecialWarnSound	= "Jouer un son pour les alertes spéciales"

-- Tab: Barsetup
L.BarSetup   				= "Style des barres"
L.BarTexture 				= "Texture des barres"
L.BarStartColor 			= "Couleur de départ"
L.BarEndColor 				= "Couleur de fin"
L.ExpandUpwards				= "Nouvelles barres au-dessus"
L.Bar_Font					= "Police utiliser pour les barres"
L.Bar_FontSize				= "Taille des polices"
L.Slider_BarOffSetX 		= "Position X: %d"
L.Slider_BarOffSetY 		= "Position Y: %d"
L.Slider_BarWidth 			= "Largeur: %d"
L.Slider_BarScale 			= "Echelle: %0.2f"
L.AreaTitle_BarSetup 		= "Options générales des barres"
L.AreaTitle_BarSetupSmall 	= "Options des petites barres"
L.AreaTitle_BarSetupHuge 	= "Options des grandes barres"
L.BarIconLeft 				= "Icône gauche"
L.BarIconRight 				= "Icône droit"
L.EnableHugeBar 			= "Activer les grandes barres (Barre 2)"
L.FillUpBars				= "Remplir les barres"
L.ClickThrough				= "Enlève le contrôle par la souris (Vous autorise à cliquer à travers les barres)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Alertes spéciales"
L.Area_SpecWarn				= "Configuration des alertes spéciales"
L.SpecWarn_Enabled			= "Montre les alertes spéciales pour les capacités des boss"
L.SpecWarn_Font				= "Police utilisée pour les alertes spéciales"
L.SpecWarn_DemoButton		= "Montre un exemple"
L.SpecWarn_MoveMe			= "Définir la position"
L.SpecWarn_FontSize			= "Taille de police"
L.SpecWarn_FontColor			= "Couleur de police"
L.SpecWarn_FontType			= "Choisir la police"
L.SpecWarn_ResetMe			= "Réinitialiser"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Barre de vie"
L.Area_HPFrame				= "Configurer la Barre de vie"
L.HP_Enabled				= "Toujours montrer la Barre de vie, même si elle est désactivée dans le Module"
L.HP_GrowUpwards			= "Prolonge la barre de vie vers le haut"
L.HP_ShowDemo				= "Montre la fenêtre des points de vie"
L.BarWidth					= "Longueur de la barre: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Filtre anti-spam"
L.Area_SpamFilter				= "Options générales du filtre anti-spam"
L.HideBossEmoteFrame			= "Cacher la fenêtre des emotes de boss"
L.SpamBlockRaidWarning			= "Filtrer les annonces venant d'autres boss mods"
L.SpamBlockBossWhispers			= "Filtre: Alerter les chuchotements en commencant par <DBM> lors des combats"
L.BlockVersionUpdatePopup		= "Enlève le message pop-up quand vous êtes sur un boss"
L.ShowBigBrotherOnCombatStart	= "Autoriser Big Brother à regarder les buffs quand le combat débute"
L.BigBrotherAnnounceToRaid		= "Autoriser Big Brother à annoncer les résultats au raid"

L.Area_SpamFilter_Outgoing		= "Options Global des Filtres"
L.SpamBlockNoShowAnnounce		= "Ne pas montrer les annonces ou jouer les sons"
L.SpamBlockNoSendAnnounce		= "Ne pas écrire les annonces dans le chat de raid"
L.SpamBlockNoSendWhisper		= "Ne pas chuchoter les autres joueurs"
L.SpamBlockNoSetIcon			= "Ne pas mettre d'icônes sur la cible"

