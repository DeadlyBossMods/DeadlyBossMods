if GetLocale() ~= "frFR" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationBy 			= "Psyco/Sasmira/Pettigrow/Edoz@EU-Ysondre/Leybola@EU-Sargeras/Noleen@EU-Hyjal"

L.OTabBosses	= "Boss"
L.OTabOptions	= "Options"

L.TabCategory_Options		= "Options générales"
L.TabCategory_OTHER			= "Autres modules"

L.BossModLoaded 			= "Statistiques |2 %s"
L.BossModLoad_now 			= [[Ce boss mod n'est pas chargé. 
Il le sera une fois que vous serez dans l'instance. 
Vous pouvez aussi cliquer sur le bouton pour le charger manuellement.]]

L.PosX						= 'Position en X'
L.PosY						= 'Position en Y'

L.MoveMe 					= 'Déplacez-moi'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Annuler'
L.Button_LoadMod 			= 'Charger l\'AddOn'
L.Mod_Enabled				= "Activer ce module"
L.Mod_Reset					= "Charger les options par défaut"
L.Reset 					= "Réinit."

L.Enable  					= "Activer"
L.Disable					= "Désactiver"

L.NoSound					= "Pas de son"

L.IconsInUse				= "Icônes utilisées par ce module"

-- Tab: Boss Statistics
L.BossStatistics			= "Statistiques des boss"
L.Statistic_Kills			= "Victoires:"
L.Statistic_Wipes			= "Échecs:"
L.Statistic_Incompletes		= "Non terminés:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Meilleur temps:"

-- Tab: General Core Options
L.General 					= "Options générales de DBM"
L.EnableMiniMapIcon			= "Afficher l'icône de la minicarte"
L.UseSoundChannel			= "Configurer le canal audio utilisé par DBM pour jouer les sons d'alerte"
L.UseMasterChannel			= "Canal audio principal"
L.UseDialogChannel			= "Canal audio des dialogues"
L.UseSFXChannel				= "Canal audio des effets sonores (SFX)"
L.Latency_Text				= "Seuil de latence max. pour synchro: %d"

L.ModelOptions				= "Options du visualiseur de modèle 3D"
L.EnableModels				= "Activer les modèles 3D dans les options des boss"
L.ModelSoundOptions			= "Configurer le son pour le visualiseur 3D"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.Button_RangeFrame			= "Afficher/cacher la fenêtre de portée"
L.Button_InfoFrame			= "Afficher/cacher la fenêtre des infos"
L.Button_TestBars			= "Lancer les barres de test"
L.Button_ResetInfoRange		= "Réinit. les fenêtres de portée et d'infos"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Alertes raid"
L.RaidWarning_Header		= "Options des alertes raid"
L.RaidWarnColors 			= "Couleurs des alertes raid"
L.RaidWarnColor_1 			= "Couleur 1"
L.RaidWarnColor_2 			= "Couleur 2"
L.RaidWarnColor_3		 	= "Couleur 3"
L.RaidWarnColor_4 			= "Couleur 4"
L.InfoRaidWarning			= [[Vous pouvez préciser la position et les couleurs de la fenêtre des alertes raid.
Cette fenêtre est utilisée pour les messages de type "Le joueur X est affecté par Y".]]
L.ColorResetted 			= "Les paramètres de couleur de ce champ ont été réinitialisés"
L.ShowWarningsInChat 		= "Afficher les alertes raid dans la fenêtre de chat"
L.WarningIconLeft 			= "Afficher l'icône du côté gauche"
L.WarningIconRight 			= "Afficher l'icône du côté droit"
L.WarningIconChat 			= "Afficher les icônes dans la fenêtre de chat"
L.WarningAlphabetical		= "Arranger les noms de manière alphabétique"
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
L.RaidWarnSound				= "Jouer un son sur les alertes raid"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Messages généraux"
L.CoreMessages				= "Options des messages de DBM"
L.ShowLoadMessage 			= "Afficher les messages de chargement de module dans la fenêtre de chat"
L.ShowPizzaMessage 			= "Afficher les messages d'annonce de chrono (broadcast timer messages) dans la fenêtre de chat"
L.ShowCombatLogMessage 		= "Afficher les messages d'enregistrement de combat de DBM dans la fenêtre de chat"
L.ShowTranscriptorMessage	= "Afficher les messages d'enregistrement de DBM Transcriptor dans la fenêtre de chat"
L.ShowAllVersions	 		= "Afficher les versions des BossMods pour tous les membres du groupe dans la fenêtre de chat lors d'une vérification de version. (Continue d'afficher les messages périmée/courante même si désactivé)"
L.CombatMessages			= "Options des messages liés au combat"
L.ShowEngageMessage 		= "Afficher les messages d'engagement du boss dans la fenêtre de chat"
L.ShowKillMessage 			= "Afficher les messages de victoire dans la fenêtre de chat"
L.ShowWipeMessage 			= "Afficher les messages de défaite dans la fenêtre de chat"
L.ShowGuildMessages 		= "Afficher les messages engagement/victoire/défaite en guilde dans la fenêtre de chat"
L.ShowRecoveryMessage 		= "Afficher les messages de récupération des timers dans la fenêtre de chat"
L.WhisperMessages			= "Options des chuchotements"
L.AutoRespond 				= "Répondre automatiquement aux chuchotements pendant les combats"
L.EnableStatus 				= "Répondre aux chuchotements de 'statut'"
L.WhisperStats 				= "Inclure les victoires/défaites dans les réponses"
L.DisableStatusWhisper 		= "Désactiver les chuchotements de statut pour le groupe entier (requiert Chef de groupe). S'appplique seulement aux raids normaux/heroïques/mythiques et aux donjons défis/mythiques."

-- Tab: Barsetup
L.BarSetup					= "Config. des barres"
L.BarTexture				= "Texture des barres"
L.BarStyle					= "Style des barres"
L.BarDBM					= "DBM (animations)"
L.BarSimple					= "Simple (pas d'animation)"
L.BarStartColor				= "Couleur de départ"
L.BarEndColor 				= "Couleur de fin"
L.Bar_Font					= "Police pour les barres"
L.Bar_FontSize				= "Taille de cette police: %d"
L.Bar_Height				= "Hauteur de la barre: %d"
L.Slider_BarOffSetX 		= "Décalage en X: %d"
L.Slider_BarOffSetY 		= "Décalage en Y: %d"
L.Slider_BarWidth 			= "Largeur de la barre: %d"
L.Slider_BarScale 			= "Echelle de la barre: %0.2f"
--Types
L.BarStartColorAdd			= "Couleur de départ (Add)"
L.BarEndColorAdd			= "Couleur de fin (Add)"
L.BarStartColorAOE			= "Couleur de départ (AOE)"
L.BarEndColorAOE			= "Couleur de fin (AOE)"
L.BarStartColorDebuff		= "Couleur de départ (Ciblage)"
L.BarEndColorDebuff			= "Couleur de fin (Ciblage)"
L.BarStartColorInterrupt	= "Couleur de départ (Interruption)"
L.BarEndColorInterrupt		= "Couleur de fin (Interruption)"
L.BarStartColorRole			= "Couleur de départ (Rôle)"
L.BarEndColorRole			= "Couleur de fin (Rôle)"
L.BarStartColorPhase		= "Couleur de départ (Phase)"
L.BarEndColorPhase			= "Couleur de fin (Phase)"

-- Tab: Timers
L.AreaTitle_BarColors		= "Couleur des barres en fonction du type de timer"
L.AreaTitle_BarSetup		= "Options des barres classiques"
L.AreaTitle_BarSetupSmall 	= "Options des petites barres"
L.AreaTitle_BarSetupHuge	= "Options des grosses barres"
L.EnableHugeBar 			= "Activer les grosses énormes (alias Barres 2)"
L.BarIconLeft 				= "Icône à gauche"
L.BarIconRight 				= "Icône à droite"
L.ExpandUpwards				= "S'étendre vers le haut"
L.FillUpBars				= "Remplir les barres"
L.ClickThrough				= "Désactiver toute interaction avec la souris (clic à travers)"
L.Bar_Decimal				= "Afficher les décimales en dessous de: %d"
L.Bar_DBMOnly				= "Les options ci-dessous ne fonctionnent qu'avec les styles de barre \"DBM\""
L.Bar_EnlargeTime			= "Agrandir la barre en dessous de: %d"
L.Bar_EnlargePercent		= "Agrandir la barre en dessous de(%): %0.1f%%"
L.BarSpark					= "Eclaircissement de front"
L.BarFlash					= "Clignotement vers la fin"
L.BarSort					= "Arranger en fonction du temps restant"
L.BarColorByType			= "Couleur par type"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Alertes spéciales"
L.Area_SpecWarn				= "Options des alertes spéciales"
L.SpecWarn_ClassColor		= "Utiliser des couleurs selon les classes pour les alertes spéciales"
L.ShowSWarningsInChat 		= "Afficher les alertes spéciales dans la fenêtre de discussion"
L.SWarnNameInNote			= "Utiliser les options SW5 si une note personnalisée contient votre nom"
L.SpecWarn_FlashFrame		= "Faire flasher l'écran lors des alertes spéciales"
L.SpecWarn_FlashFrameRepeat	= "Répéter %d fois (si activé)" --was missing
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
L.SpecialWarnSound5			= "Son des alertes spéciales avec des notes contenant votre nom"

-- Tab: Heads Up Display Frame
L.Panel_HUD					= "Affichages tête haute(HUD)"
L.Area_HUDOptions			= "Options du HUD"
L.HUDColorOverride			= "Outrepasser les paramètres de couleurs du mod pour le HUD"
L.HUDSizeOverride			= "Outrepasser les paramètres de tailles du mod pour le HUD"
L.HUDAlphaOverride			= "Outrepasser les paramètres de transparence du mod pour le HUD"
L.HUDTextureOverride		= "Outrepasser les paramètres de textures du mod pour le HUD (ne s'applique pas aux icônes)"
L.HUDColorSelect			= "Couleur du HUD %d"
L.HUDTextureSelect1			= "Texture du 1er HUD"
L.HUDTextureSelect2			= "Texture du 2e HUD"
L.HUDTextureSelect3			= "Texture du 3e HUD"
L.HUDTextureSelect4			= "Texture de l'HUD 'courir vers'"
L.HUDSizeSlider				= "Rayon du cercle: %0.1f"
L.HUDAlphaSlider			= "Transparence: %0.1f"

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
L.Panel_SpamFilter			= "Filtres globaux et de spam"
L.Area_SpamFilter_Outgoing	= "Options des filtres globaux"
L.SpamBlockNoShowAnnounce	= "Ne pas afficher d'annonces ou jouer de sons d'alerte"
L.SpamBlockNoSpecWarn		= "Ne pas afficher d'annonces ou jouer de sons d'alerte spéciales"
L.SpamBlockNoShowTimers		= "Ne pas afficher les timers de module (Boss Mod/CM/LFG/Respawn)"
L.SpamBlockNoShowUTimers	= "Ne pas afficher au joueur les timers envoyés (Personnalisés/Pull/Pause)"
L.SpamBlockNoSetIcon		= "Ne pas placer d'icônes sur les cibles"
L.SpamBlockNoRangeFrame		= "Ne pas afficher le cadre des portées"
L.SpamBlockNoInfoFrame		= "Ne pas afficher le cadre d'information"
L.SpamBlockNoHudMap			= "Do not show HudMap"
L.SpamBlockNoHealthFrame	= "Ne pas afficher le cadre des vies"
L.SpamBlockNoCountdowns		= "Ne pas jouer le son du compte à rebours"
L.SpamBlockNoYells			= "Ne pas envoyer de cris dans le chat"
L.SpamBlockNoNoteSync		= "Ne pas accepter les notes partagées"

L.Area_Restore				= "Options de restauration DBM (Restaure ladernière utilisation de DBM ou non lors de la fin d'un module)"
L.SpamBlockNoIconRestore	= "Ne pas sauvegarder l'état des icônes et les restaurer en fin de combat"
L.SpamBlockNoRangeRestore	= "Ne pas restaurer le radar de portée quand les addons le cachent"

-- Tab: Spam Filter
L.Area_SpamFilter			= "Options des filtres de spam"
L.DontShowFarWarnings		= "Ne pas afficher les annonces/timers pour les événements distants"
L.StripServerName			= "Ne pas afficher le royaume sur les alertes et les timers"
L.SpamBlockBossWhispers		= "Filtrer les chuchotements d'alerte &lt;DBM&gt; pendant les rencontres"
L.BlockVersionUpdateNotice	= "Désactiver le popup de notification de mise à jour"

L.Area_SpecFilter			= "Options du filtre de Spécialisation"
L.FilterTankSpec			= "Filtrer les alertes réservées aux tanks si vous n'êtes pas en spé tank. (Note: Désactivé n'est pas recommandé car les alertes de taunt sont activés en permanence par défaut.)"
L.FilterInterrupts			= "Filtrer les alertes d'interruption si le caster n'est pas votre cible ou focus (Note: Ne s'applique pas aux sorts critiques qui peuvent causer des wipes)"
L.FilterInterruptNoteName	= "Filtrer les alertes des sorts interruptibles (avec compte) si l'alerte ne contient pas votre nom dans la note personnalisée"
L.FilterDispels				= "Filtrer les alertes pour les dispells si votre sort de dispell est disponible"
L.FilterSelfHud				= "Filtrer vous-même de la carte du HUD (exclu les fonctions HUD basées sur la portée)"

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
L.SpamBlockSayYell			= "Masquer les annonces des onglets de chat de la fenêtre de discussion pendant les combats contre un boss"
L.DisableCinematics			= "Désactiver les cinématiques en jeu"
L.AfterFirst				= "Après que la cinématique ait été jouée une fois"
L.Always					= "Toujours"

L.Panel_ExtraFeatures		= "Fonctionnalités supplémentaires"
--
L.Area_ChatAlerts			= "Options des alertes dans le chat"
L.RoleSpecAlert				= "Afficher une alerte lorsque votre spé ne correspond pas à votre choix de loot en rejoignant un raid"
L.CheckGear					= "Affiche un message d'alerte pendant les pull quand votre ilvl équipé est beaucoup plus bas que votre ilvl global (40+)"
L.WorldBossAlert			= "Afficher une alerte lorsqu'un World Boss a probablement été engagé sur votre royaume par votre guilde ou des amis (érronée si info reçue de CRZed)"
--
L.Area_SoundAlerts			= "Options des alertes sonores"
L.LFDEnhance				= "Jouer le son du readycheck sur les vérif. de rôle &amp; sur les propositions de BG/RdG dans le canal audio principal (généralement plus fort, fonctionne même si le SFX est désactivé)"
L.WorldBossNearAlert		= "Jouer le son du readycheck lorsqu'un World Boss proche de vous que vous avez besoin est engagé (Outrepasse l'option par boss)"
L.RLReadyCheckSound			= "Jouer les sons de l'appel des vrais appels via le canal principal ou de dialogue"
L.AFKHealthWarning			= "Jouer un son d'alerte si vous perdez de la vie alors que vous ABS"
L.AutoReplySound			= "Jouer un son d'alerte lorsque vous recevez une réponse automatique de DBM"
--
L.TimerGeneral 				= "Options des timers"
L.SKT_Enabled				= "Afficher le timer du record pour lecombat actuel s'il est disponible"
L.CRT_Enabled				= "Afficher le timer de la prochaine charge de resurrection en combat"
L.ShowRespawn				= "Afficher le timer de la réapparition du boss après un wipe"
L.ShowQueuePop				= "Afficher le timer du temps restant pour accepter l'invitation (LFG,BG,etc)"
L.ChallengeTimerOptions		= "Réglage du timer du meilleur temps en challenge mode"
L.ChallengeTimerPersonal	= "Personnel"
L.ChallengeTimerGuild		= GUILD
L.ChallengeTimerRealm		= "Serveur"
--
L.Area_AutoLogging			= "Options d'enregistrement auto"
L.AutologBosses				= "Automatiquement enregistrer le combat contre un boss en utilisant le combat log de Blizzard (Il faut utiliser la commande /dbm pull avant le boss pour que ce soit compatible avec <a href=\"http://www.warcraftlogs.com\">|cff3588ffwarcraftlogs.com|r</a>)"
L.AdvancedAutologBosses		= "Automatiquement enregistrer le combat contre un boss en utilisant Transcriptor"
L.LogOnlyRaidBosses			= "N'enregistrer que les combats contre un boss (exclus RdR/dongeon/scenario)"
--
L.Area_3rdParty				= "Options des Addons tiers"
L.ShowBBOnCombatStart		= "Effectuer la vérification des buffs de Big Brother au début des combats"
L.BigBrotherAnnounceToRaid	= "Annoncer les résultats de Big Brother au raid"
L.Area_Invite				= "Options des invitations"
L.AutoAcceptFriendInvite	= "Accepter les invitations venant d'un ami automatiquement"
L.AutoAcceptGuildInvite		= "Accepter les invitations venant d'un membre de la guilde automatiquement"
L.Area_Advanced				= "Options Avancées"
L.FakeBW					= "Prétendre être BigWigs lors des vérifications de versions au lieu de DBM (Utile pour les guildes qui forcent l'utilisation de BigWigs)"
L.AITimer					= "Utiliser un générateur automatique de timers pour des nouveaux combats utilisant l'IA intégrée de DBM (Utile pout engager les boss jamais vus sur la beta). Note: ceci ne fonctionnera pas correctement s'il y a plusieurs adds avec la même abilité"
L.AutoCorrectTimer			= "Corriger automatiquement les timers trop longs (Utile pour les guildes sur le contenu haut niveau pour lequel les bossmods ne sont pas encore mis à jour)"

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
L.SelectModProfileCopyNote	= "Copier uniquement les réglages des notes depuis"
L.SelectModProfileDelete	= "Supprimer les réglages pour"

-- Misc
L.FontHeight	= 16