if GetLocale() ~= "frFR" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Psyco/Sasmira/Pettigrow/Edoz@EU-Ysondre/Leiyla@EU-CdO"

L.OTabBosses	= "Boss"
L.OTabOptions	= "Options"

L.TabCategory_Options		= "Options générales"
L.TabCategory_WoD	 		= "Warlords of Draenor"
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
L.Mod_Reset					= "Charger les options par défault"
L.Reset 					= "Réinit."

L.Enable  					= "Activer"
L.Disable					= "Désactiver"

L.NoSound					= "Pas de son"

L.IconsInUse				= "Icônes utilisées par ce module"

-- Tab: Boss Statistics
L.BossStatistics			= "Boss Statistics"
L.Statistic_Kills			= "Victoires :"
L.Statistic_Wipes			= "Échecs :"
L.Statistic_Incompletes		= "Non terminés:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Meilleur temps :"

-- Tab: General Core Options
L.General 					= "Options générales de DBM"
L.EnableDBM 				= "Activer DBM"
L.EnableMiniMapIcon			= "Afficher l'icône de la minicarte"
L.UseMasterVolume			= "Utiliser le canal audio principal pour la lecture des fichiers sonores"
L.Latency_Text				= "Seuil de latence max. pour synchro : %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "Options du timer de base de DBM"
L.SKT_Enabled				= "Toujours afficher la barre du meilleur temps (Outrepasse l'option par boss)"
L.ChallengeTimerOptions		= "Régler les options pour le timer du meilleur temps du challenge mode"
L.ChallengeTimerPersonal	= "Personnel"
L.ChallengeTimerGuild		= "Guilde"
L.ChallengeTimerRealm		= "Royaume"

L.ModelOptions				= "Options du visionneur de modèle 3D"
L.EnableModels				= "Activer les modèles 3D dans les options des boss"
L.ModelSoundOptions			= "Régler l' option sonore pour le visionneur de modèle"
L.ModelSoundShort			= "Court"
L.ModelSoundLong			= "Long"

L.Button_RangeFrame			= "Afficher/cacher le cadre des portées"
L.Button_RangeRadar			= "Afficher/cacher le radar de portée"
L.Button_InfoFrame			= "Afficher/cacher le cadre d'information"
L.Button_TestBars			= "Lancer les barres de test"

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
L.ShowSWarningsInChat 		= "Afficher les alertes spéciales dans la fenêtre de discussion"
L.ShowFakedRaidWarnings 	= "Afficher les alertes comme de faux avertissements raid"
L.WarningIconLeft 			= "Afficher l'icône sur le côté gauche"
L.WarningIconRight 			= "Afficher l'icône sur le côté droit"
L.WarningIconChat 			= "Afficher les icônes dans la fenêtre de discussion"
L.ShowCountdownText			= "Afficher le texte du compte à rebours"
L.RaidWarnMessage 			= "Merci d'utiliser Deadly Boss Mods"
L.BarWhileMove 				= "Alerte raid mobile"
L.RaidWarnSound				= "Jouer un son sur les alertes"
L.CountdownVoice			= "Voix principale du compte à rebours"
L.CountdownVoice2			= "Voix secondaire du compte à rebours"
L.SpecialWarnSound			= "Son des alertes spéciales vous affectant vous ou votre rôle"
L.SpecialWarnSound2			= "Son des alertes spéciales affectant tout le monde"
L.SpecialWarnSound3			= "Son des alertes spéciales TRES IMPORTANTES"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Messages généraux"
L.CoreMessages				= "Options des messages de base"
L.ShowLoadMessage 			= "Afficher les messages de chargement du mod dans la fenêtre de discussion"
L.ShowPizzaMessage 			= "Afficher les messages d'annonce dans la fenêtre de discussion"
L.ShowCombatLogMessage 		= "Afficher les messages d'enregistrement de combat de DBM dans la fenêtre de discussion"
L.ShowTranscriptorMessage	= "Afficher les messages d'enregistrement Transcriptor de DBM dans la fenêtre de discussion"
L.CombatMessages			= "Options des messages de combat"
L.ShowEngageMessage 		= "Afficher les messages d'engagement de combat dans la fenêtre de discussion"
L.ShowKillMessage 			= "Afficher les messages de victoire dans la fenêtre de discussion"
L.ShowWipeMessage 			= "Afficher les messages d'échec dans la fenêtre de discussion"
L.ShowRecoveryMessage 		= "Afficher les messages de récupération de timers dans la fenêtre de discussion" --timer recovery?
L.WhisperMessages			= "Options des chuchotements"
L.AutoRespond 				= "Répondre automatiquement aux messages en combat"
L.EnableStatus 				= "Répondre aux messages de 'status'"
L.WhisperStats 				= "Inclure les statistiques de victoires/échecs dans les réponses"

-- Tab: Barsetup
L.BarSetup   				= "Organisation des barres"
L.BarTexture 				= "Texture des barres"
L.BarStyle					= "Style des barres"
L.BarDBM					= "DBM"
L.BarBigWigs				= "BigWigs (no animation)"
L.BarStartColor				= "Couleur au début"
L.BarEndColor 				= "Couleur à la fin"
L.Bar_Font					= "Police de texte des barres"
L.Bar_FontSize				= "Taille de police: %d"
L.Bar_Height				= "Hauteur des barres: %d"
L.Slider_BarOffSetX 		= "Décalage horizontal: %d"
L.Slider_BarOffSetY 		= "Décalage vertical: %d"
L.Slider_BarWidth 			= "Largeur des barres: %d"
L.Slider_BarScale 			= "Echelle des barres: %0.2f"
L.AreaTitle_BarSetup		= "Options de la barre générale"
L.AreaTitle_BarSetupSmall 	= "Options de la petite barre "
L.AreaTitle_BarSetupHuge	= "Options de la grosse barre"
L.EnableHugeBar 			= "Activer la grosse barre (alias Barre 2)"
L.BarIconLeft 				= "Icone gauche"
L.BarIconRight 				= "Icone droite"
L.ExpandUpwards				= "Décaler vers le haut"
L.FillUpBars				= "Remplir les barres"
L.ClickThrough				= "Désactiver toute interaction avec la souris (clic à travers)"
L.Bar_DBMOnly				= "Les options ci-dessous ne fonctionnent qu'avec le style de barre \"DBM\"."
L.Bar_EnlargeTime			= "Agrandir la barre sous: %d secondes"
L.Bar_EnlargePercent		= "Agrandir la barre sous: %0.1f%%"
L.BarSpark					= "Ligne blanche de front de progression"
L.BarFlash					= "Faire clignoter la barre vers la fin "

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Alertes spéciales"
L.Area_SpecWarn				= "Options des alertes spéciales"
L.SpecWarn_Enabled			= "Afficher des alertes spéciales pour les techniques des boss"
L.SpecWarn_FlashFrame		= "Faire flasher l'écran lors des alertes spéciales"
L.SpecWarn_Font				= "Police de texte des alertes spéciales"
L.SpecWarn_FontSize			= "Taille de la police: %d"
L.SpecWarn_FontColor		= "Couleur du texte"
L.SpecWarn_FontType			= "Choisissez la police"
L.SpecWarn_FlashColor		= "Couleur du flash"
L.SpecWarn_FlashDur			= "Durée du flash: %0.1f"
L.SpecWarn_FlashAlpha		= "Taux alpha du flash: %0.1f"
L.SpecWarn_DemoButton		= "Aff. un exemple"
L.SpecWarn_MoveMe			= "Définir la position"
L.SpecWarn_ResetMe			= "Réinit. les valeurs"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Cadre des vies"
L.Area_HPFrame				= "Options du cadre des vies"
L.HP_Enabled				= "Toujours afficher le cadre (Outrepasse l'option par boss)"
L.HP_GrowUpwards			= "Décaler vers le haut"
L.HP_ShowDemo				= "Aff. le cadre"
L.BarWidth					= "Longueur des barres : %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Filtres globaux et de spam"
L.Area_SpamFilter				= "Options des filtres de spam"
L.StripServerName				= "Ne pas afficher le royaume sur les alertes et les timers"
L.SpamBlockBossWhispers			= "Filtrer les chuchotements d'alerte &lt;DBM&gt; pendant les rencontres"
L.ShowBBOnCombatStart			= "Effectuer une vérif. générale des buffs au début du combat"
L.BigBrotherAnnounceToRaid		= "Annoncer les résultats de la vérif. générale au raid"

L.Area_SpamFilter_Outgoing		= "Options des filtres globaux"
L.SpamBlockNoShowAnnounce		= "Ne pas afficher d'annonces ou jouer de sons d'alerte"
L.DontShowFarWarnings			= "Ne pas afficher les annonces/timers pour les événements distants"
L.SpamBlockNoSendWhisper		= "Ne pas chuchoter les alertes boss aux autres joueurs"
L.SpamBlockNoSetIcon			= "Ne pas placer d'icônes sur les cibles"
L.SpamBlockNoRangeFrame			= "Ne pas afficher le cadre des portées"
L.SpamBlockNoInfoFrame			= "Ne pas afficher le cadre d'information"
L.SpamBlockNoHealthFrame		= "Ne pas afficher le cadre des vies"

L.Area_PullTimer			= "Options du filtre des timers de pull"
L.DontShowPTNoID			= "Bloquer les chronos de pull envoyés depuis une zone différente de la votre"
L.DontShowPT				= "Ne pas afficher la barre de pull"
L.DontShowPTText			= "Ne pas afficher le texte d'annonce du chrono de pull"
L.DontPlayPTCountdown		= "Ne pas jouer le son du compte à rebours du chrono de pull"
L.DontShowPTCountdownText	= "Ne pas afficher le texte du compte à rebours du chrono de pull"
L.PT_Threshold				= "Ne pas afficher le texte du compte à rebours s'il reste plus de: %d sec."

--Tab: Hide Blizzard
L.Panel_HideBlizzard		= "Masquer Blizzard"
L.Area_HideBlizzard			= "Options pour masquer Blizzard"
L.HideBossEmoteFrame		= "Masquer le cadre des vies des boss pendant les combats contre un boss"
L.HideWatchFrame			= "Masquer le cadre de suivi d'objectifs pendant les combats contre un boss"
L.HideTooltips				= "Masquer le cadre d'information pendant les combats contre un boss"
L.SpamBlockSayYell			= "Masquer les annonces des onglets de chat de la fenêtre de discussion pendant les combats contre un boss"
L.DisableCinematics			= "Désactiver les cinématiques en jeu"
L.AfterFirst				= "Après que la cinématique ait été jouée une fois"
L.Always					= "Toujours"

--Tab: Extra Features
L.Panel_ExtraFeatures		= "Fonctionnalités supplémentaires"
L.Area_ChatAlerts			= "Options des alertes dans le chat"
L.RoleSpecAlert				= "Afficher une alerte lorsque votre spé ne correspond pas à votre choix de loot en rejoignant un raid"
L.WorldBossAlert			= "Afficher une alerte lorsqu'un World Boss a probablement été engagé sur votre royaume par votre guilde ou des amis (érronée si info reçue de CRZed)"
L.Area_SoundAlerts			= "Options des alertes sonores"
L.LFDEnhance				= "Jouer le son du readycheck sur les vérif. de rôle &amp; sur les propositions de BG/RdG dans le canal audio principal (généralement plus fort, fonctionne même si le SFX est désactivé)"
L.WorldBossNearAlert		= "Jouer le son du readycheck lorsqu'un World Boss proche de vous que vous avez besoin est engagé (Outrepasse l'option par boss)"
L.AFKHealthWarning			= "Jouer un son d'alerte si vous perdez de la vie alors que vous ABS"
L.Area_AutoLogging			= "Options d'enregistrement auto"
L.AutologBosses				= "Automatiquement enregistrer le combat contre un boss en utilisant le combat log de Blizzard (Il faut utiliser la commande /dbm pull avant le boss pour que ce soit compatible avec <a href=\"http://www.warcraftlogs.com\">|cff3588ffwarcraftlogs.com|r</a>)"
L.AdvancedAutologBosses		= "Automatiquement enregistrer le combat contre un boss en utilisant Transcriptor"
L.LogOnlyRaidBosses			= "N'enregistrer que les combats contre un boss (exclus RdR/dongeon/scenario)"
L.Area_Invite				= "Options des invitations"
L.AutoAcceptFriendInvite	= "Accepter les invitations venant d'un ami automatiquement"
L.AutoAcceptGuildInvite		= "Accepter les invitations venant d'un membre de la guilde automatiquement"

L.PizzaTimer_Headline 		= 'Création d\'un "délai pizza"'
L.PizzaTimer_Title			= 'Nom (par ex. : "Pizza !")'
L.PizzaTimer_Hours 			= "Hrs"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sec"
L.PizzaTimer_ButtonStart 	= "Lancer le délai"
L.PizzaTimer_BroadCast		= "Diffuser au raid"

-- Misc
L.FontHeight	= 16
