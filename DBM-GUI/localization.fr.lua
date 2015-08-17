if GetLocale() ~= "frFR" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Psyco/Sasmira/Pettigrow/Edoz@EU-Ysondre/Leiyla@EU-CdO/Noleen@EU-Hyjal"



L.OTabBosses	= "Boss"
L.OTabOptions	= "Options"

L.TabCategory_Options		= "Options générales"
L.TabCategory_WoD	 		= "Warlords of Draenor"
L.TabCategory_MOP	 		= "Mists of Pandaria"
L.TabCategory_CATA			= "Cataclysm"
L.TabCategory_WOTLK			= "Wrath of the Lich King"
L.TabCategory_BC			= "The Burning Crusade"
L.TabCategory_CLASSIC		= "WoW classique"
L.TabCategory_PVP 			= "PVP"
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
L.CRT_Enabled				= "Affiche un timer pour la prochaine charge de résurrection en combat (uniquement pour les difficultés 6.x)" --line was missing
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
L.Button_RangeRadar			= "Afficher/cacher le radar de portée" --doesn't seem to exist in the en.lua
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
L.ShowFakedRaidWarnings 	= "Afficher les alertes comme de faux avertissements raid"
L.WarningIconLeft 			= "Afficher l'icône sur le côté gauche"
L.WarningIconRight 			= "Afficher l'icône sur le côté droit"
L.WarningIconChat 			= "Afficher les icônes dans la fenêtre de discussion"
L.RaidWarnMessage 			= "Merci d'utiliser Deadly Boss Mods"
L.BarWhileMove 				= "Alerte raid mobile"
L.RaidWarnSound				= "Jouer un son sur les alertes"

--liens below were missing
L.Warn_FontType				= "Choisir une police"
L.Warn_FontStyle			= "Contours de la police"
L.Warn_FontShadow			= "Ombre"
L.Warn_FontSize				= "Taille de la police: %d"
L.Warn_Duration				= "Durée de l'alerte: %d sec"
L.None						= "Aucun"
L.Outline					= "Simple"
L.ThickOutline				= "Epais"
L.MonochromeOutline			= "Monochrome simple"
L.MonochromeThickOutline	= "Monochrome épais"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Messages généraux"
L.CoreMessages				= "Options des messages de base"
L.ShowLoadMessage 			= "Afficher les messages de chargement du mod dans la fenêtre de discussion"
L.ShowPizzaMessage 			= "Afficher les messages d'annonce dans la fenêtre de discussion"
L.ShowCombatLogMessage 		= "Afficher les messages d'enregistrement de combat de DBM dans la fenêtre de discussion"
L.ShowTranscriptorMessage	= "Afficher les messages d'enregistrement Transcriptor de DBM dans la fenêtre de discussion"
L.ShowAllVersions	 		= "Affiche les versions des BossMods pour chaque membre du groupe dans la fenêtre de discussion" --line was missing
L.CombatMessages			= "Options des messages de combat"
L.ShowEngageMessage 		= "Afficher les messages d'engagement de combat dans la fenêtre de discussion"
L.ShowKillMessage 			= "Afficher les messages de victoire dans la fenêtre de discussion"
L.ShowWipeMessage 			= "Afficher les messages d'échec dans la fenêtre de discussion"
L.ShowGuildMessages 		= "Afficher les messages de engagement/victoire/échec de la guilde dans la fenêtre de discussion" --line was missing
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
L.BarSimple					= "Simple (no animation)"
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
L.Bar_Decimal				= "Afficher décimales en dessous de: %d" --was missing
L.Bar_DBMOnly				= "Les options ci-dessous ne fonctionnent qu'avec le style de barre \"DBM\"."
L.Bar_EnlargeTime			= "Agrandir la barre sous: %d secondes"
L.Bar_EnlargePercent		= "Agrandir la barre sous: %0.1f%%"
L.BarSpark					= "Ligne blanche de front de progression"
L.BarFlash					= "Faire clignoter la barre vers la fin "
L.BarSort					= "Classer en fonction du temps restant" --was missing

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Alertes spéciales"
L.Area_SpecWarn				= "Options des alertes spéciales"
L.SpecWarn_FlashFrame		= "Faire flasher l'écran lors des alertes spéciales"
L.SpecWarn_FlashFrameRepeat	= "Répéter %d fois (si activé)" --was missing
L.ShowSWarningsInChat 		= "Afficher les alertes spéciales dans la fenêtre de discussion"
L.SpecWarn_Font				= "Police de texte des alertes spéciales"
L.SpecWarn_FontSize			= "Taille de la police: %d"
L.SpecWarn_FontColor		= "Couleur du texte"
L.SpecWarn_FontType			= "Choisissez la police"
L.SpecWarn_FlashRepeat		= "Répéter Flash" --was missing
L.SpecWarn_FlashColor		= "Couleur du flash"
L.SpecWarn_FlashDur			= "Durée du flash: %0.1f"
L.SpecWarn_FlashAlpha		= "Taux alpha du flash: %0.1f"
L.SpecWarn_DemoButton		= "Aff. un exemple"
L.SpecWarn_MoveMe			= "Définir la position"
L.SpecWarn_ResetMe			= "Réinit. les valeurs"
L.SpecialWarnSound			= "Son des alertes spéciales vous affectant vous ou votre rôle"
L.SpecialWarnSound2			= "Son des alertes spéciales affectant tout le monde"
L.SpecialWarnSound3			= "Son des alertes spéciales TRES IMPORTANTES"
L.SpecialWarnSound4			= "Son des alertes spéciales de fuite"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Alertes Vocales"
L.Area_VoiceSelection		= "Sélection des voix"
L.CountdownVoice			= "Définir la voix principale" --shortened to avoid overlap in game
L.CountdownVoice2			= "Définir la deuxième voix pour les comptes à rebours"
L.CountdownVoice3			= "Définir la troisième voix" --shortened to avoid overlap in game
L.VoicePackChoice			= "Définir le Pack de voix pour les Alertes Vocales"
L.Area_CountdownOptions		= "Options des Comptes à rebours"
L.ShowCountdownText			= "Afficher le texte du compte à rebours lors des comptes à rebours de la voix principale" --might be possible to make it shorter
L.Area_VoicePackOptions		= "Options des Packs de voix (Pack de voix tiers)"
L.SpecWarn_NoSoundsWVoice	= "Ne pas jouer d'alerte spéciale s'il y a déjà une alerte vocale"
L.SWFNever					= "Jamais"
L.SWFDefaultOnly			= "quand les alertes spéciales jouent les sons de base. (N'agit pas pour les sons modifiés)"
L.SWFAll					= "quand les alertes spéciales jouent n'importe quel son"
L.SpecWarn_AlwaysVoice		= "Toujours jouer toutes les alertes vocales (Outrepasse les options par boss. Utile pour les RL)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?

-- Tab: HealthFrame
L.Panel_HPFrame				= "Cadre des vies"
L.Area_HPFrame				= "Options du cadre des vies"
L.HP_Enabled				= "Toujours afficher le cadre (Outrepasse l'option par boss)"
L.HP_GrowUpwards			= "Décaler vers le haut"
L.HP_ShowDemo				= "Aff. le cadre"
L.BarWidth					= "Longueur des barres : %d"

-- Tab: Global Filter
L.Panel_SpamFilter				= "Filtres globaux et de spam"
L.Area_SpamFilter_Outgoing		= "Options des filtres globaux"
L.SpamBlockNoShowAnnounce		= "Ne pas afficher d'annonces ou jouer de sons d'alerte"
L.SpamBlockNoSetIcon			= "Ne pas placer d'icônes sur les cibles"
L.SpamBlockNoRangeFrame			= "Ne pas afficher le cadre des portées"
L.SpamBlockNoInfoFrame			= "Ne pas afficher le cadre d'information"
L.SpamBlockNoHealthFrame		= "Ne pas afficher le cadre des vies"
L.SpamBlockNoCountdowns			= "Ne pas jouer le son du compte à rebours"
L.SpamBlockNoIconRestore		= "Ne pas sauvegarder l'état des icônes et les restaurer en fin de combat"
L.SpamBlockNoRangeRestore		= "Ne pas restaurer le radar de portée quand les addons appellent un 'hide'" --might be inexact

-- Tab: Spam Filter
L.Area_SpamFilter				= "Options des filtres de spam"
L.DontShowFarWarnings			= "Ne pas afficher les annonces/timers pour les événements distants"
L.StripServerName				= "Ne pas afficher le royaume sur les alertes et les timers"
L.SpamBlockBossWhispers			= "Filtrer les chuchotements d'alerte &lt;DBM&gt; pendant les rencontres"
L.BlockVersionUpdateNotice		= "Désactiver le popup de notification de mise à jour"

L.Area_SpecFilter			= "Options du filtre de Spécialisation"
L.FilterTankSpec			= "Filtre les alertes réservées aux tanks si vous n'êtes pas en spé tank. (Note: Désactivé n'est pas recommandé car les alertes de taunt sont activés en permanence par défaut.)"
--Healer and Damager not in use yet. Tank is easily black and white. if not a tank, disable taunt warnings. Pretty obvious.
--Healer and Damager a bit more tricky, since often times, Healer DO need to switch and kill adds designated a dps roll (hi disc attonement priest)
--Or a dps does need to handle debuff dispels. Or a dps/tank need to know when aoe damage is going out just as much as healer for personal CDs
--Etc etc. Point being, I translate these but I'm not sure they could ever actually be used as effectively as the tank spec filter.
--L.FilterHealerSpec		= "Filter warnings designated for Healer role when not Healer spec"--Not in use
--L.FilterDamagerSpec		= "Filter warnings designated for Damager role when not Damager spec"--Not in use

L.Area_PullTimer			= "Options du filtre des timers de pull"
L.DontShowPTNoID			= "Bloquer les chronos de pull envoyés depuis une zone différente de la votre"
L.DontShowPT				= "Ne pas afficher la barre de pull"
L.DontShowPTText			= "Ne pas afficher le texte d'annonce du chrono de pull"
L.DontPlayPTCountdown		= "Ne pas jouer le son du compte à rebours du chrono de pull"
L.DontShowPTCountdownText	= "Ne pas afficher le texte du compte à rebours du chrono de pull"
L.PT_Threshold				= "Ne pas afficher le texte du compte à rebours s'il reste plus de: %d sec."

L.Panel_HideBlizzard		= "Masquer Blizzard"
L.Area_HideBlizzard			= "Options pour masquer Blizzard"
L.HideBossEmoteFrame		= "Masquer le cadre des vies des boss pendant les combats contre un boss"
L.HideWatchFrame			= "Masquer le cadre de suivi d'objectifs pendant les combats contre un boss"
L.HideGarrisonUpdates		= "Masque les notifications de fief pendant les combats de boss"
L.HideGuildChallengeUpdates	= "Masque les notifications de défis de guilde pendant les combats de boss"
L.HideTooltips				= "Masquer le cadre d'information pendant les combats contre un boss"
L.DisableSFX				= "Désactive le canal des effets sonores pendant les boss" --was missing
L.HideApplicantAlerts		= "Supprime les alertes de candidats dans les groupes pré-définis"
L.HideApplicantAlertsFull	= "Si le groupe est complet"
L.HideApplicantAlertsNotL	= "Si vous n'êtes pas responsable du groupe (Agit si le groupe est complet lorsque vous êtes le responsable)"
L.SpamBlockSayYell			= "Masquer les annonces des onglets de chat de la fenêtre de discussion pendant les combats contre un boss"
L.DisableCinematics			= "Désactiver les cinématiques en jeu"
L.AfterFirst				= "Après que la cinématique ait été jouée une fois"
L.Always					= "Toujours"

L.Panel_ExtraFeatures		= "Fonctionnalités supplémentaires"
L.Area_ChatAlerts			= "Options des alertes dans le chat"
L.RoleSpecAlert				= "Afficher une alerte lorsque votre spé ne correspond pas à votre choix de loot en rejoignant un raid"
L.CheckGear					= "Affiche un message d'alerte pendant les pull quand votre ilvl équipé est beaucoup plus bas que votre ilvl global (40+)"
L.WorldBossAlert			= "Afficher une alerte lorsqu'un World Boss a probablement été engagé sur votre royaume par votre guilde ou des amis (érronée si info reçue de CRZed)"
L.Area_SoundAlerts			= "Options des alertes sonores"
L.LFDEnhance				= "Jouer le son du readycheck sur les vérif. de rôle &amp; sur les propositions de BG/RdG dans le canal audio principal (généralement plus fort, fonctionne même si le SFX est désactivé)"
L.WorldBossNearAlert		= "Jouer le son du readycheck lorsqu'un World Boss proche de vous que vous avez besoin est engagé (Outrepasse l'option par boss)"
L.AFKHealthWarning			= "Jouer un son d'alerte si vous perdez de la vie alors que vous ABS"
L.Area_AutoLogging			= "Options d'enregistrement auto"
L.AutologBosses				= "Automatiquement enregistrer le combat contre un boss en utilisant le combat log de Blizzard (Il faut utiliser la commande /dbm pull avant le boss pour que ce soit compatible avec <a href=\"http://www.warcraftlogs.com\">|cff3588ffwarcraftlogs.com|r</a>)"
L.AdvancedAutologBosses		= "Automatiquement enregistrer le combat contre un boss en utilisant Transcriptor"
L.LogOnlyRaidBosses			= "N'enregistrer que les combats contre un boss (exclus RdR/dongeon/scenario)"
L.Area_3rdParty				= "Options des Addons tiers"
L.ShowBBOnCombatStart		= "Effectuer la vérification des buffs de Big Brother au début des combats"
L.BigBrotherAnnounceToRaid	= "Annoncer les résultats de Big Brother au raid"
L.Area_Invite				= "Options des invitations"
L.AutoAcceptFriendInvite	= "Accepter les invitations venant d'un ami automatiquement"
L.AutoAcceptGuildInvite		= "Accepter les invitations venant d'un membre de la guilde automatiquement"
L.Area_Advanced				= "Options Avancées"
L.FakeBW					= "Prétendre être BigWigs lors des vérifications de versions au lieu de DBM (Utile pour les guildes qui forcent l'utilisation de BigWigs)"

L.PizzaTimer_Headline 		= 'Création d\'un "délai pizza"'
L.PizzaTimer_Title			= 'Nom (par ex. : "Pizza !")'
L.PizzaTimer_Hours 			= "Hrs"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sec"
L.PizzaTimer_ButtonStart 	= "Lancer le délai"
L.PizzaTimer_BroadCast		= "Diffuser au raid"

L.Panel_Profile				= "Profils"
L.Area_CreateProfile		= "Création de Profil"
L.EnterProfileName			= "Entrer un nom de profil"
L.CreateProfile				= "Créer un profil pour les options de DBM Core"
L.Area_ApplyProfile			= "Appliquer le profil actif aux options de DBM Core"
L.SelectProfileToApply		= "Sélectionner le profil à appliquer"
L.Area_CopyProfile			= "Copier un profil d'option de DBM Core"
L.SelectProfileToCopy		= "Sélectionner le profil à copier"
L.Area_DeleteProfile		= "Supprimer un profil"
L.SelectProfileToDelete		= "Sélectionner le profil à supprimer"
L.Area_DualProfile			= "Options de Profil"
L.DualProfile				= "Activer le support de différents profils pour chaque spécialisation. (Managing of boss mod profiles is done from loaded boss mod stats screen)" --Don't know how to translate the second part

L.Area_ModProfile			= "Copier les réglages depuis un autre perso/spé ou supprimer des réglages"
L.ModAllReset				= "Réinitialiser tous les réglages"
L.ModAllStatReset			= "Réinitialiser toutes les statistiques"
L.SelectModProfileCopy		= "Copier tous les réglages depuis"
L.SelectModProfileCopySound	= "Copier uniquement les réglages sonores depuis"
L.SelectModProfileDelete	= "Supprimer les réglages pour"

-- Misc
L.FontHeight	= 16
