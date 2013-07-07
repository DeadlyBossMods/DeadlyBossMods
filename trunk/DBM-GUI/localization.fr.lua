if GetLocale() ~= "frFR" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Psyco/Sasmira/Pettigrow/Edoz@EU-Ysondre"

L.OTabBosses	= "Boss"
L.OTabOptions	= "Options"

L.TabCategory_Options		= "Options générales"
L.TabCategory_MOP	 		= "Mists of Pandaria"
L.TabCategory_CATA			= "Cataclysm"
L.TabCategory_WOTLK			= "Wrath of the Lich King"
L.TabCategory_BC			= "The Burning Crusade"
L.TabCategory_CLASSIC		= "WoW classique"
L.TabCategory_OTHER			= "Autres modules"

L.BossModLoaded 			= "Statistiques |2 %s"
L.BossModLoad_now 			= [[Ce boss mod n'est pas chargé. 
Il le sera une fois que vous serez dans l'instance. 
Cliquez sur le bouton pour charger manuellement.]]

L.PosX						= 'Position en X'
L.PosY						= 'Position en Y'

L.MoveMe 					= 'Déplacez-moi'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Annuler'
L.Button_LoadMod 			= 'Charger l\'AddOn'
L.Mod_Enabled				= "Activer ce module"
L.Reset 					= "Réinit."

L.Enable  					= "Activer"
L.Disable					= "Désactiver"

L.NoSound					= "Pas de son"

L.IconsInUse				= "Icônes utilisées par ce module"

-- Tab: Boss Statistics
L.BossStatistics			= "Boss Statistics"
L.Statistic_Kills			= "Victoires :"
L.Statistic_Wipes			= "Échecs :"
L.Statistic_BestKill		= "Meilleur :"

-- Tab: General Options
L.General 					= "Options générales de DBM"
L.EnableDBM 				= "Activer DBM"
L.EnableStatus 				= "Répondre aux chuchotements 'status'"
L.AutoRespond 				= "Activer le répondeur pendant les rencontres"
L.EnableMiniMapIcon			= "Afficher l'icône de la minicarte"
L.UseMasterVolume			= "Utiliser le canal audio principal pour la lecture des fichiers sonores"
L.SKT_Enabled				= "Tj afficher le délai pour battre le record (surplante toute autre option)"
L.Latency_Text				= "Seuil de latence max. pour synchro : %d"

L.ModelOptions				= "Options du visionneur de modèle 3D"
L.EnableModels				= "Activer les modèles 3D dans les options des boss"
L.ModelSoundOptions			= "Option sonore pour le visionneur"
L.ModelSoundShort			= "Court"
L.ModelSoundLong			= "Long"

L.Button_RangeFrame			= "Cadre des portées"
L.Button_RangeRadar			= "Show/hide range radar"
L.Button_InfoFrame			= "Show/hide info frame"
L.Button_TestBars			= "Barres de test"

L.PizzaTimer_Headline 		= 'Création d\'un "délai pizza"'
L.PizzaTimer_Title			= 'Nom (par ex. : "Pizza !")'
L.PizzaTimer_Hours 			= "Hrs"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sec"
L.PizzaTimer_ButtonStart 	= "Lancer le délai"
L.PizzaTimer_BroadCast		= "Diffuser au raid"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Alertes raid"
L.RaidWarning_Header		= "Options des alertes raid"
L.RaidWarnColors 			= "Couleurs des alertes raid"
L.RaidWarnColor_1 			= "Couleur 1"
L.RaidWarnColor_2 			= "Couleur 2"
L.RaidWarnColor_3		 	= "Couleur 3"
L.RaidWarnColor_4 			= "Couleur 4"
L.InfoRaidWarning			= [[Vous pouvez spécifier la position et les couleurs du cadre des alertes. 
Ce cadre est utilisé pour les messages du genre "Joueur X subit Y".]]
L.ColorResetted 			= "Les paramètres de couleur pour ce champ ont été réinitialisés."
L.ShowWarningsInChat 		= "Afficher les alertes dans la fenêtre de discussion"
L.ShowFakedRaidWarnings 	= "Afficher les alertes comme de faux Avertissements raid"
L.WarningIconLeft 			= "Afficher l'icône sur le côté gauche"
L.WarningIconRight 			= "Afficher l'icône sur le côté droit"
L.RaidWarnMessage 			= "Merci d'utiliser Deadly Boss Mods"
L.BarWhileMove 				= "Alerte raid mobile"
L.RaidWarnSound				= "Son des alertes"
L.CountdownVoice			= "Voix des comptes à rebours"
L.SpecialWarnSound			= "Son des alertes spéciales affectant vous-même ou votre rôle"
L.SpecialWarnSound2			= "Son des alertes spéciales affectant tout le monde"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "General Messages"
L.CoreMessages				= "Core Message Options"
L.ShowLoadMessage 			= "Show mod loading messages in chat frame"
L.ShowPizzaMessage 			= "Show timer broadcast messages in chat frame"
L.CombatMessages			= "Combat Message Options"
L.ShowEngageMessage 		= "Show engage messages in chat frame"
L.ShowKillMessage 			= "Show kill messages in chat frame"
L.ShowWipeMessage 			= "Show wipe messages in chat frame"
L.ShowRecoveryMessage 		= "Show timer recovery messages in chat frame"
L.WhisperMessages			= "Whisper Message Options"
L.AutoRespond 				= "Auto-respond to whispers while fighting"
L.EnableStatus 				= "Reply to 'status' whispers"
L.WhisperStats 				= "Include kill/wipe stats in whisper responses"

-- Tab: Barsetup
L.BarSetup   				= "Style des barres"
L.BarTexture 				= "Texture des barres"
L.BarStartColor				= "Début"
L.BarEndColor 				= "Fin"
L.ExpandUpwards				= "Ajouter vers le haut"
L.Bar_Font					= "Police des barres"
L.Bar_FontSize				= "Taille de la police"
L.Slider_BarOffSetX 		= "Décalage X : %d"
L.Slider_BarOffSetY 		= "Décalage Y : %d"
L.Slider_BarWidth 			= "Largeur : %d"
L.Slider_BarScale 			= "Échelle : %0.2f"
L.AreaTitle_BarSetup		= "Options générales des barres"
L.AreaTitle_BarSetupSmall 	= "Options des petites barres"
L.AreaTitle_BarSetupHuge	= "Options des grosses barres"
L.BarIconLeft 				= "Icône à G"
L.BarIconRight 				= "Icône à D"
L.EnableHugeBar 			= "Activer les grosses barre (alias Barre 2)"
L.FillUpBars				= "Remplir les barres"
L.ClickThrough				= "Désactiver toute interaction avec la souris (clic à travers)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Alertes spéciales"
L.Area_SpecWarn				= "Options des alertes spéciales"
L.SpecWarn_Enabled			= "Afficher des alertes spéciales pour les techniques des boss"
L.SpecWarn_FlashFrame		= "Faire flasher l'écran lors des alertes spéciales"
L.SpecWarn_Font				= "Police des alertes spéciales"
L.SpecWarn_DemoButton		= "Aff. un exemple"
L.SpecWarn_MoveMe			= "Définir la position"
L.SpecWarn_FontSize			= "Taille de la police"
L.SpecWarn_FontColor		= "Couleur"
L.SpecWarn_FontType			= "Choix de la police"
L.SpecWarn_ResetMe			= "Valeurs par défaut"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Cadre des vies"
L.Area_HPFrame				= "Options du cadre des vies"
L.HP_Enabled				= "Toujours afficher le cadre (surplante toute autre option)"
L.HP_GrowUpwards			= "Étendre le cadre des vies vers le haut"
L.HP_ShowDemo				= "Aff. cadre des vies"
L.BarWidth					= "Largeur des barres : %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Filtres globaux et de spam"
L.Area_SpamFilter				= "Options des filtres de spam"
L.HideBossEmoteFrame			= "Masquer le cadre des émotes des boss de raid"
L.SpamBlockBossWhispers			= "Filtrer les chuchotements d'alerte <DBM> pendant les rencontres"
L.BlockVersionUpdateNotice		= "Désactiver le popup de notification de mise à jour"
L.ShowBigBrotherOnCombatStart	= "Effectuer une vérif. des buffs Big Brother au début du combat"
L.BigBrotherAnnounceToRaid		= "Annoncer les résultats de Big Brother au raid"

L.Area_SpamFilter_Outgoing		= "Options des filtres globaux"
L.SpamBlockNoShowAnnounce		= "Ne pas afficher d'annonces ou jouer de sons d'alerte"
L.SpamBlockNoSendWhisper		= "Ne pas envoyer de chuchotements aux autres joueurs"
L.SpamBlockNoSetIcon			= "Ne pas placer d'icônes sur les cibles"
L.SpamBlockNoRangeFrame			= "Ne pas afficher le cadre de distance"
L.SpamBlockNoInfoFrame			= "Ne pas afficher le cadre d'information"

-- Misc
L.FontHeight	= 16
