if GetLocale() ~= "frFR" then return end
if not DBM_GUI_L then DBM_GUI_L = {} end
local L = DBM_GUI_L

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Traduit par "
L.TranslationBy 			= "Psyco/Sasmira/Pettigrow/Edoz@EU-Ysondre/Leybola@EU-Sargeras/Noleen@EU-Hyjal" -- your name here, localizers!
L.Website					= "Visitez notre discord sur |cFF73C2FBhttps://discord.gg/deadlybossmods|r. Suivez-nous sur Twitter @deadlybossmods ou @MysticalOS"
L.WebsiteButton				= "Site web"

L.OTabBosses						= "Options de Boss"--Deprecated and will be deleted once tabs no longer use this
L.OTabRaids							= "Raids"--Just pve raids
L.OTabDungeons						= "Donjons"--Just dungeons
L.OTabWorld							= "Bosses du monde"--Since there are so many world mods, enough to get their own tab
L.OTabScenarios						= "Scénarios"--Future use, will be used for scenarios and delves, likely after there are more than 2 mods (so probably 12.x or later)
L.OTabPlugins						= "Autre"--Scenarios, PVP, Delves (11.x), Solo/Challenge content (torghast, mage tower, etc)
L.OTabOptions						= "Options de Core"
L.OTabAbout							= "À propos"

L.FOLLOWER							= "Sujet"--i.e. the new dungeon type in 10.2.5. I haven't found a translated string yet
L.STORY					    		= "Histoire"--i.e. the new dungeon type in 11.0.0. I haven't found a translated string yet

L.TabCategory_CURRENT_SEASON		= "Saison en cours"

L.TabCategory_OTHER			= "Autres modules"
L.TabCategory_AFFIXES		= "Affixes"

L.BossModLoaded 			= "Statistiques %s"
L.BossModLoad_now 			= [[Ce boss mod n'est pas chargé.
Il le sera une fois que vous serez dans l'instance.
Vous pouvez aussi cliquer sur le bouton pour le charger manuellement.]]

L.PosX						= "Position en X"
L.PosY						= "Position en Y"

L.MoveMe 					= "Déplacez-moi"
L.Button_OK 				= "OK"
L.Button_Cancel 			= "Annuler"
L.Button_LoadMod 			= "Charger le module"
L.Mod_Enabled				= "Activer: %s"
L.Mod_Reset					= "Charger les options par défaut"
L.Reset 					= "Réinit."
L.Import					= "Importer"

L.Enable					= "Activer"
L.Disable					= "Désactiver"

L.NoSound					= "Pas de son"

L.IconsInUse				= "Icônes utilisées par ce module"

-- Tab: Boss Statistics
L.BossStatistics			= "Statistiques des boss"
L.Statistic_Kills			= "Victoires :"
L.Statistic_Wipes			= "Échecs :"
L.Statistic_Incompletes		= "Incomplets :"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Meilleur temps :"
L.Statistic_BestRank		= "Meilleur rang :"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Core Options
L.TabCategory_Options	 	= "Options générales"
L.Area_BasicSetup			= "Aide à la configuration initiale de DBM"
L.Area_ModulesForYou		= "Quels modules DBM sont bons pour vous ?"
L.Area_ProfilesSetup		= "Guide d'utilisation des profiles DBM"

-- Panel: Core & GUI
L.Core_GUI 					= "Core et Interface"
L.General 					= "Options générales de DBM Core"
L.EnableMiniMapIcon			= "Afficher l'icône de la minicarte"
L.EnableCompartmentIcon		= "Afficher l'icône de compartiment"
L.UseSoundChannel			= "Configurer le canal audio utilisé par DBM pour jouer les sons d'alerte"
L.UseMasterChannel			= "Canal audio Principal"
L.UseDialogChannel			= "Canal audio Discussion"
L.UseSFXChannel				= "Canal audio Son (SFX)"
L.Latency_Text				= "Seuil de latence max. pour synchro: %d"

L.Button_RangeFrame			= "Afficher/cacher Cadre de portée"
L.Button_InfoFrame			= "Afficher/cacher Cadre d'infos"
L.Button_TestBars			= "Barres de test"
L.Button_MoveBars			= "Déplacer les barres"
L.Button_ResetInfoRange		= "Réinit. les cadres de portée et d'infos"

L.ModelOptions				= "Options du visualiseur de modèle 3D"
L.EnableModels				= "Activer les modèles 3D dans les options des boss"
L.ModelSoundOptions			= "Configurer le son pour le visualiseur 3D"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.ResizeOptions			 	= "Options de redimensionnage"
L.ResizeInfo				= "Vous pouvez redimensionner l'interface en étirant le coin bas-droit"
L.Button_ResetWindowSize	= "Réinit. la taille de la fenêtre"
L.Editbox_WindowWidth		= "Largeur de la fenêtre"
L.Editbox_WindowHeight		= "Hauteur de la fenêtre"

L.UIGroupingOptions			= "Options d'interface partagées (requiet de recharger l'interface pour tout module qui serait déjà chargé)"
L.GroupOptionsExcludeIcon	= "Exclure l'option 'Définir l'icône sur' du regroupement par capacité (elles seront regroupées dans la catégorie 'Icônes' comme avant)"
L.ShowWAKeys				= "Afficher les clés WeakAuras à côté des noms de sorts pour aider à écrire des WeakAuras en utilisant les déclencheurs du Boss Mod."
L.AutoExpandSpellGroups		= "Déplier automatiquement les options liées à la même capacité"
--L.ShowSpellDescWhenExpanded	= "Continuer à afficher la description du sort lorsque les groupes sont déployés."--Might not be used
L.NoDescription				= "Cette capacité n'a aucune description"
L.CustomOptions				= "Cette catégorie contient des options personnalisées pour une capacité ou un événement qui n'a pas son propre ID de sort ou de journal. Ces options ont été regroupées ensemble en utilisant un ID manuel personnalisé pour faciliter la création de WeakAuras."

-- Panel: Auto Logging
L.Panel_AutoLogging					= "Enregistrement automatique"

--Auto Logging: Logging toggles/types
L.Area_AutoLogging					= "Bascules d'enregistrement automatique"
L.AutologBosses						= "Enregistrer automatiquement le contenu sélectionné en utilisant le journal de combat de Blizzard"
L.AdvancedAutologBosses				= "Enregistrer automatiquement le contenu sélectionné avec Transcriptor"
--Auto Logging: Global filter Options
L.Area_AutoLoggingFilters			= "Filtres d'enregistrement automatique"
L.RecordOnlyBosses					= "Ne pas enregistrer les trashs (Enregistre uniquement les Boss. Utilisez '/dbm pull' avant les boss pour capturer les potions pré-combat et ENCOUNTER_START)"
L.DoNotLogLFG						= "Ne pas enregistrer les contenus en file d'attente (LFG ou LFR)"
--Auto Logging: Recorded Content types
L.Area_AutoLoggingContent			= "Contenu de l'enregistrement automatique"
L.LogCurrentMythicRaids				= "Raids mythiques du niveau actuel (ou remix)" --Retail Only
L.LogCurrentRaids					= "Raids non mythiques du niveau actuel (ou remix) (Héroïque, Normal, et LFR si le filtre LFG/LFR est désactivé)"
L.LogTWRaids						= "Raids de Marcheurs du temps ou de Temps de Chromie (n'inclut PAS le remix)" --Retail Only
L.LogTrivialRaids					= "Raids triviaux (au-dessous du niveau du personnage)"
L.LogCurrentMPlus					= "Donjons M+ du niveau actuel (ou remix)" --Retail Only
L.LogCurrentMythicZero				= "Donjons Mythique 0 du niveau actuel (ou remix)" --Retail Only
L.LogTWDungeons						= "Donjons de Marcheurs du temps ou de Temps de Chromie (n'inclut PAS le remix)" --Retail Only
L.LogCurrentHeroic					= "Donjons héroïques du niveau actuel (Remarque : si vous faites de l'héroïque via la file d'attente et souhaitez l'enregistrer, désactivez le filtre LFG)"

-- Panel: Extra Features
L.Panel_ExtraFeatures		= "Fonctionnalités supplémentaires"

L.Area_SoundAlerts			= "Options des alertes sonores/flash"
L.LFDEnhance				= "Faire clignoter le bouton de l'application et jouer le son d'Appel lors des vérif. de rôle &amp; des invitations (LFG,BG,etc) dans les canaux audio Principal ou Discussion (canaux généralement plus forts, fonctionnent même si le SFX est désactivé)"
L.WorldBossNearAlert		= "Faire clignoter le bouton de l'application et jouer le son d'Appel quand un World Boss proche de vous est engagé"
L.RLReadyCheckSound			= "Quand le chef de raid lance un Appel, jouer le son via les canaux audio Principal ou Discussion et faire clignoter le bouton de l'application"
L.AFKHealthWarning			= "Faire clignoter le bouton de l'application et jouer un son d'alerte si vous perdez de la vie alors que vous absent"
L.AutoReplySound			= "Faire clignoter le bouton de l'application et jouer un son d'alerte quand vous recevez une réponse DBM automatique par chuchotement"
--
L.TimerGeneral 				= "Options des décompte"
L.SKT_Enabled				= "Décompte du record pour le combat actuel s'il est disponible"
L.ShowRespawn				= "Décompte de la réapparition du boss après un wipe"
L.ShowQueuePop				= "Décompte du temps restant pour accepter une invitation (LFG,BG,etc)"
--
L.Area_AutoLogging			= "Options d'enregistrement automatique"
L.AutologBosses				= "Enregistrement auto du combat contre un boss en utilisant le journal de combat de Blizzard"
L.AdvancedAutologBosses		= "Enregistrement auto du combat contre un boss en utilisant Transcriptor"
L.RecordOnlyBosses			= "N'enregistrer que les boss et exclure tous les trash. Utilisez '/dbm pull' avant les boss pour prendre en compte les potions (pre pot) &amp; ENCOUNTER_START"
--
L.Area_3rdParty				= "Options des Addons tiers"
L.oRA3AnnounceConsumables	= "Annoncer la vérification des consommables oRA3 au début du combat"
L.Area_Invite				= "Options des invitations"
L.AutoAcceptFriendInvite	= "Acceptation auto des invitations venant d'un ami"
L.AutoAcceptGuildInvite		= "Acceptation auto des invitations venant d'un membre de la guilde"
L.Area_Advanced				= "Options Avancées"
L.FakeBW					= "Prétendre utiliser BigWigs lors des vérifications de versions au lieu de DBM (utile pour les guildes qui forcent l'utilisation de BigWigs)"
L.AITimer					= "Utiliser un générateur automatique de décomptes pour les nouveaux combats en utilisant l'IA intégrée de DBM (utile pout engager les boss jamais vus sur la béta). Note: ceci ne fonctionnera pas correctement s'il y a plusieurs adds avec la même capacité"

-- Panel: Profiles
L.Panel_Profile				= "Profils"
L.Area_CreateProfile		= "Créer un profil"
L.EnterProfileName			= "Entrer un nom pour le nouveau profil :"
L.CreateProfile				= "Créer un profil DBM Core"
L.Area_ApplyProfile			= "Définir le profil DBM Core actif"
L.SelectProfileToApply		= "Sélection du profil à utiliser :"
L.Area_CopyProfile			= "Copier un profil DBM Core"
L.SelectProfileToCopy		= "Sélection du profil à copier :"
L.Area_DeleteProfile		= "Supprimer un profil"
L.SelectProfileToDelete		= "Sélection du profil à supprimer :"
L.Area_DualProfile			= "Options de Profil"
L.DualProfile				= "Activer la gestion des options en fonction de la spécialisation (la gestion des profiles boss mod est faite à partir de la fenêtre des statistiques des boss mod chargés)"

L.Area_ModProfile			= "Copier les réglages depuis un autre perso/spé ou supprimer des réglages"
L.ModAllReset				= "Réinitialiser tous les réglages"
L.ModAllStatReset			= "Réinitialiser toutes les statistiques"
L.SelectModProfileCopy		= "Copier tous les réglages depuis"
L.SelectModProfileCopySound	= "Copier uniquement les réglages sonores depuis"
L.SelectModProfileCopyNote	= "Copier uniquement les réglages des notes depuis"
L.SelectModProfileDelete	= "Supprimer les réglages pour"

L.Area_ImportExportProfile	= "Importer/Exporter profils"
L.ImportExportInfo			= "Attention ! Importer un profil écrasera votre profil actuel"
L.ButtonImportProfile		= "Importer profil"
L.ButtonExportProfile		= "Exporter profil"

L.ImportErrorOn				= "Son personnalisé manquant pour : %s"
L.ImportVoiceMissing		= "Paquet de voix manquant : %s"

-- Tab: Alerts
L.TabCategory_Alerts	 	= "Alertes"
L.Area_SpecAnnounceConfig	= "Guide des effets visuels et sonores des Alertes spéciales"
L.Area_SpecAnnounceNotes	= "Guide des notes des alertes spéciales"
L.Area_VoicePackInfo		= "Information sur les paquets de voix DBM"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Announces"
L.RaidWarning_Header		= "Options des annonces"
L.RaidWarnColors 			= "Couleurs des annonces"
L.RaidWarnColor_1 			= "Couleur 1"
L.RaidWarnColor_2 			= "Couleur 2"
L.RaidWarnColor_3		 	= "Couleur 3"
L.RaidWarnColor_4 			= "Couleur 4"
L.InfoRaidWarning			= [[Vous pouvez préciser la position et les couleurs de la fenêtre des alertes raid.
Cette fenêtre est utilisée pour les messages de type "Joueur X est affecté par Y".]]
L.ColorResetted 			= "Les paramètres de couleur de ce champ ont été réinitialisés"
L.ShowWarningsInChat 		= "Afficher les alertes dans la fenêtre de discussion"
L.WarningIconLeft 			= "Afficher l'icône du côté gauche"
L.WarningIconRight 			= "Afficher l'icône du côté droit"
L.WarningIconChat 			= "Afficher les icônes dans la fenêtre de discussion"
L.WarningAlphabetical		= "Arranger les noms de manière alphabétique"
L.Warn_Duration				= "Durée de l'alerte: %0.1f sec"
L.None						= "Aucun"
L.Random					= "Aléatoire"
L.Outline					= "Simple"
L.ThickOutline				= "Epais"
L.MonochromeOutline			= "Monochrome simple"
L.MonochromeThickOutline	= "Monochrome épais"
L.RaidWarnSound				= "Jouer un son sur les alertes raid"
L.SAOne						= "Son global 1 (personnel)"
L.SATwo 					= "Son global 2 (tout le monde)"
L.SAThree 					= "Son global 3 (action de haute priorité)"
L.SAFour 					= "Son global 4 (fuite de haute priorité)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Alertes spéciales"
L.Area_SpecWarn				= "Options des spéciales"
L.SpecWarn_ClassColor		= "Utiliser la couleur des classes pour les alertes spéciales"
L.ShowSWarningsInChat 		= "Afficher les alertes spéciales dans la fenêtre de discussion"
L.SWarnNameInNote			= "Utiliser les options de type 5 si une note d'alerte spéciale contient votre nom"
L.SpecialWarningIcon		= "Afficher les icônes sur les alertes spéciales"
L.ShortTextSpellname		= "Abréger le texte des noms des sorts (si possible)"
L.SpecWarn_FlashFrameRepeat	= "Clignoter %d fois"
L.SpecWarn_Flash			= "Clignotement écran"
L.SpecWarn_Vibrate			= "Vibrations manette"
L.SpecWarn_FlashRepeat		= "Répéter Clignotement"
L.SpecWarn_FlashColor		= "Couleur Clignotement"
L.SpecWarn_FlashDur			= "Durée Clignotement : %0.1f"
L.SpecWarn_FlashAlpha		= "Alpha Clignotement : %0.1f"
L.SpecWarn_DemoButton		= "Aff. un exemple"
L.SpecWarn_ResetMe			= "Réinit. les valeurs"
L.SpecialWarnSoundOption	= "Définir son par défaut"
L.SpecialWarnHeader1		= "Type 1: Alertes à priorité moyenne affectant vous ou vos actions"
L.SpecialWarnHeader2		= "Type 2: Alertes à priorité moyenne affectant tout le monde"
L.SpecialWarnHeader3		= "Type 3: Alertes à priorité HAUTE"
L.SpecialWarnHeader4		= "Type 4: Alertes à priorité HAUTE / Alertes spéciales COUREZ"
L.SpecialWarnHeader5		= "Type 5: Alertes dont la note contient votre nom"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Messages dans la fenêtre de discussion"
L.CoreMessages				= "Options des messages de DBM"
L.ShowPizzaMessage 			= "Afficher les messages d'annonce de décomptes dans la fenêtre de discussion"
L.ShowAllVersions	 		= "Afficher les versions boss mod de tous les membres du groupe dans la fenêtre de discussion lors d'une vérification des versions. (Si désactivé, continu d'effectuer un résumé obsolète/à jour)"
L.ShowReminders				= "Afficher des messages de rappel pour les sous-modules manquants, désactivés, hotfixes, obsolètes, et mode silencieux étant toujours activé"

L.CombatMessages			= "Options des messages liés au combat"
L.ShowEngageMessage 		= "Afficher les messages de pull du boss dans la fenêtre de discussion"
L.ShowDefeatMessage 		= "Afficher les messages victoire/défaite dans la fenêtre de discussion"
L.ShowGuildMessages 		= "Afficher les messages pull/victoire/défaite pour les groupes de la guilde dans la fenêtre de discussion"
L.ShowGuildMessagesPlus		= "Afficher aussi les messages pull/victoire/défaite pour les groupes Mythique+ de la guilde (requiert raid option)" --last part isn't great

L.Area_ChatAlerts			= "Options des alertes supplémentaires"
L.RoleSpecAlert				= "Afficher une alerte lorsque vous rejoignez un raid et que votre préférence de butin ne correspond pas à votre spécialisation actuelle"
L.CheckGear					= "Afficher une alerte d'équipement pendant le pull (quand votre ilvl équipé est beaucoup plus bas que votre ilvl global (40+) ou que votre arme principale n'est pas équipée)"
L.WorldBossAlert			= "Afficher une alerte lorsqu'un world boss pourrait avoir été engagé sur votre royaume par votre guilde ou des amis (incorrect si l'info est reçue par inter-serveur)"
L.WorldBuffAlert			= "Afficher une alerte et un décompte lorsqu'un évênement annonçant un world buff est détecté sur votre royaume"

L.Area_BugAlerts			= "Options des rapports de bugs"
L.BadTimerAlert				= "Afficher un message quand DBM détecte un décompte erroné avec au moins 1 seconde de différence"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Alertes vocales"
L.Area_VoiceSelection		= "Sélection des voix"
L.CountdownVoice			= "Voix principale"
L.CountdownVoice2			= "Voix secondaire"
L.CountdownVoice3			= "Voix tertiaire"
L.VoicePackChoice			= "Paquet de voix des Alertes vocales"
L.MissingVoicePack			= "Paquet de voix manquant (%s)"
L.Area_CountdownOptions		= "Options des décomptes"
L.Area_VoicePackReplace		= "Options de remplacement par le paquet de voix (quels sons seront remplacés par le paquet de voix)"
L.VPReplaceNote				= "Remarque : Les paquets de voix ne modifient ou suppriment jamais vos sons d'alertes.\nIls sont simplement mis en sourdine lorsqu'un paquet de voix les remplace."
L.ReplacesAnnounce			= "Remplacer les sons d'alerte (Note : Très peu d'utilisation pour les paquets de voix, sauf pour les changements de phases et les adds)"
L.ReplacesSA1				= "Remplacer les sons d'alerte spéciale 1 (personnelle, ou 'pvpflag')"
L.ReplacesSA2				= "Remplacer les sons d'alerte spéciale 2 (tout le monde, ou 'beware')"
L.ReplacesSA3				= "Remplacer les sons d'alerte spéciale 3 (priorité haute, ou 'airhorn')"
L.ReplacesSA4				= "Remplacer les sons d'alerte spéciale 4 (priorité haute, ou 'run away')"
L.ReplacesCustom			= "Remplacer les sons d'alerte spéciale des réglages utilisateur personnalisés (par évênement) (non recommandé)"
L.Area_VoicePackAdvOptions	= "Options avancées paquets de voix"
L.SpecWarn_AlwaysVoice		= "Toujours jouer toutes les alertes vocales même si l'Alerte spéciale est désactivée (peut être putile aux chefs de raid dans certaines situations, non recommandé autrement)"
L.VPDontMuteSounds			= "Désactiver la mise en sourdine des alertes standards lors de l'utilisation d'un paquet de voix (à utilier seulement si vous souhaitez entendre les DEUX types d'alertes sonores simultanément)"
L.Area_VPLearnMore			= "Apprenez-en plus sur les paquets de voix et comment utiliser ces options"
L.VPLearnMore				= "|cFF73C2FBhttps://github.com/DeadlyBossMods/DBM-Retail/wiki/%5BGuide%5D-DBM-&-Voicepacks#2022-update|r"
L.Area_BrowseOtherVP		= "Trouvez d'autres paquets de voix sur Curse"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "Trouvez d'autres paquets de décompte sur Curse"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Panel: Event Sounds
L.Panel_EventSounds			= "Évênements sonores"
L.Area_SoundSelection		= "Sélection du son (parcourez le menu de sélection avec la molette souris)"
L.EventVictorySound			= "Son pour les victoires"
L.EventWipeSound			= "Son pour les défaites"
L.EventEngagePT				= "Son pour le début du décompte avant pull"
L.EventEngageSound			= "Son pour le pull"
L.EventDungeonMusic			= "Musique jouée dans les donjons/raids"
L.EventEngageMusic			= "Musique jouée pendant les rencontres"
L.Area_EventSoundsExtras	= "Options des évênements sonores"
L.EventMusicCombined		= "Autoriser tous les choix de musiques dans les sélections de donjons et de rencontres (changer cette option requiert de recharger l'interface)"
L.Area_EventSoundsFilters	= "Conditions des évênements sonores"
L.EventFilterDungMythicMusic= "Ne pas jouer de musique de donjon en difficulté Mythique/Mythique+"
L.EventFilterMythicMusic	= "Ne pas jouer de musique de rencontre en difficulté Mythique/Mythique+"

-- Tab: Timers
L.TabCategory_Timers		= "Décomptes"
L.Area_ColorBytype			= "Guide de coloration par type des barres"
-- Panel: Color by Type
L.Panel_ColorByType	 		= "Couleurs des barres"
L.AreaTitle_BarColors		= "Couleurs de barre par type de décompte"
L.AreaTitle_ImpBarColors	= "Couleurs des barres importantes (Ces barres sont définies comme importantes par l'utilisateur)"
L.BarTexture				= "Texture des barres"
L.BarStyle					= "Comportement des barres"
L.BarDBM					= "Classique (les petites barres existantes glissent vers l'ancrage Enlargi)"
L.BarSimple					= "Simple (les petites barres disparaissent et de nouvelles grandes barres sont créees)"
L.BarStartColor				= "Initiale"
L.BarEndColor 				= "Finale"
L.Bar_Height				= "Hauteur : %d"
L.Slider_BarOffSetX 		= "Décalage X : %d"
L.Slider_BarOffSetY 		= "Décalage Y : %d"
L.Slider_BarWidth 			= "Largeur : %d"
L.Slider_BarScale 			= "Échelle : %0.2f"
L.BarSaturation				= "Saturation pour les petits décomptes (si les grandes barres sont désactivées) : %0.2f"

--Types
L.BarStartColorAdd			= "Initiale (Add)"
L.BarEndColorAdd			= "Finale (Add)"
L.BarStartColorAOE			= "Initiale (AOE)"
L.BarEndColorAOE			= "Finale (AOE)"
L.BarStartColorDebuff		= "Initiale (Ciblé)"
L.BarEndColorDebuff			= "Finale (Ciblé)"
L.BarStartColorInterrupt	= "Initiale (Interruption)"
L.BarEndColorInterrupt		= "Finale (Interruption)"
L.BarStartColorRole			= "Initiale (Rôle)"
L.BarEndColorRole			= "Finale (Rôle)"
L.BarStartColorPhase		= "Initiale (Phase)"
L.BarEndColorPhase			= "Finale (Phase)"
L.BarStartColorUI			= "Initiale (Utilisateur)"
L.BarEndColorUI				= "Finale (Utilsiateur)"
--Type 7 options
L.Bar7Header				= "Options de la barre utilisateur"
L.Bar7ForceLarge			= "Toujours utiliser une grande barre"
L.Bar7CustomInline			= "Utiliser l'icône intégrée personnalisée '!'"
--Dropdown Options
L.CBTGeneric				= "Générique"
L.CBTAdd					= "Add"
L.CBTAOE					= "AOE"
L.CBTTargeted				= "Ciblé"
L.CBTInterrupt				= "Interruption"
L.CBTRole					= "Rôle"
L.CBTPhase					= "Phase"
L.CBTImportant				= "Important (Utilisateur)"
L.CVoiceOne					= "Décompte vocal 1"
L.CVoiceTwo					= "Décompte vocal 2"
L.CVoiceThree				= "Décompte vocal 3"

-- Panel: Timers
L.Panel_Appearance	 		= "Apparence des barres"
L.Panel_Behavior	 		= "Comportement des barres"
L.AreaTitle_BarSetup		= "Options de l'apparence des barres"
L.AreaTitle_Behavior		= "Bar Behavior Options"
L.AreaTitle_BarSetupSmall 	= "Options des petites barres"
L.AreaTitle_BarSetupHuge	= "Options des énormes barres"
L.EnableHugeBar 			= "Activer les énormes barres (ou Barres 2)"
L.BarIconLeft 				= "Icône à gauche"
L.BarIconRight 				= "Icône à droite"
L.ExpandUpwards				= "Étendre vers le haut"
L.FillUpBars				= "Remplissage"
L.ClickThrough				= "Désactivement les interactions souris (clic au travers)"
L.Bar_Decimal				= "Décimales affichées à partir de : %d"
L.Bar_Alpha					= "Alpha : %0.1f"
L.Bar_EnlargeTime			= "Barres agrandies à partir de : %d"
L.BarSpark					= "Barre clignotante"
L.BarFlash					= "Faire clignoter les barres qui vont expirer"
L.BarSort					= "Trier par temps restant"
L.BarColorByType			= "Couleur par type"
L.NoBarFade					= "Utiliser les couleurs initiales/finales comme couleurs petites barres/grandes barres au lieu du changement de couleur progressif"
L.BarInlineIcons			= "Icônes intégrées"
L.ShortTimerText			= "Texte de temps abrégé (si possible)"
L.KeepBar					= "Maintenir les barres actives jusqu'à l'utilisation de la capacité"
L.KeepBar2					= "(quand supporté par le module)"
L.FadeBar					= "Disparition des barres pour les capacités hors de portée"
L.BarSkin					= "Apparence des barres"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 	= "Désactivations globales & Filtres"
L.Area_DBMFiltersSetup		= "Guide des filtres DBM"
L.Area_BlizzFiltersSetup	= "Guide des filtres Blizzard"
-- Panel: DBM Features
L.Panel_SpamFilter					= "Désactivation DBM"
L.Area_SpamFilter_Anounces			= "Options des alertes Désactivations globales & Filtres"
L.SpamBlockNoShowAnnounce			= "Ne pas afficher de texte ou jouer de son pour AUCUNE alerte générale"
L.SpamBlockNoShowTgtAnnounce		= "Ne pas afficher de texte ou jouer de son pour les alertes générales CIBLE qui ne vous affecte pas, certaines alertes signalées ignoreront ce filtre (le filtre ci-dessus écrase celui-ci)"
L.SpamBlockNoTrivialSpecWarnSound	= "Ne pas jouer de son d'annonce spéciale ni faire clignoter l'écran pour le contenu bas-niveau (joue le son d'annonce par défaut sélectionné par l'utilisateur à la place)"

L.Area_SpamFilter_SpecRoleFilters	= "Filtres des annonces spéciales (contrôle la quantité gérée par DBM)"
L.SpamSpecRoleDispel				= "Filtrer les alertes 'dissipation'"
L.SpamSpecRoleInterrupt				= "Filtrer les alertes 'interruption'"
L.SpamSpecRoleDefensive				= "Filtrer les alertes 'défensive'"
L.SpamSpecRoleTaunt					= "Filtrer les alertes 'provocation'"
L.SpamSpecRoleSoak					= "Filtrer les alertes 'soak'"
L.SpamSpecRoleStack					= "Filtrer les alertes 'high stack'"
L.SpamSpecRoleSwitch				= "Filtrer les alertes 'changement de cible' &amp; 'adds'"
L.SpamSpecRoleGTFO					= "Filtrer les alertes 'sauvez-vous'"

L.Area_SpamFilter_SpecFeatures		= "Options des annonces"
L.SpamBlockNoSpecWarnText			= "Ne pas afficher de texte pour les alertes spéciales"
L.SpamBlockNoSpecWarnFlash			= "Ne pas faire clignoter l'écran pour les alertes spéciales"
L.SpamBlockNoSpecWarnVibrate		= "Ne pas faire vibrer la manette pour les alertes spéciales"
L.SpamBlockNoSpecWarnSound			= "Ne pas jouer de son d'alerte spéciale (autorise les paquets de voix, si l'un d'eux est sélectionné dans les options d'alertes vocales)"


L.Area_SpamFilter_Timers	= "Options du chronomètre"
L.SpamBlockNoShowUTimers	= "Ne pas afficher au joueur les décomptes envoyés (Personnalisés/Pull/Pause)"
L.SpamBlockNoCountdowns		= "Ne pas jouer le son du compte à rebours"

L.Area_SpamFilter_Misc		= "Options divers"
L.SpamBlockNoSetIcon		= "Ne pas placer d'icônes sur les cibles"
L.SpamBlockNoRangeFrame		= "Ne pas afficher le cadre des portées"
L.SpamBlockNoInfoFrame		= "Ne pas afficher le cadre d'information"
L.SpamBlockNoHudMap			= "Ne pas afficher la HudMap"
L.SpamBlockNoNameplate		= "Ne pas afficher les auras des barres de vie"
L.SpamBlockNoYells			= "Ne pas envoyer de cris dans le chat"
L.SpamBlockNoNoteSync		= "Ne pas accepter les notes partagées"

L.Area_Restore				= "Options de restauration DBM (Restaure la dernière utilisation de DBM ou non lors de la fin d'un module)"
L.SpamBlockNoIconRestore	= "Ne pas sauvegarder l'état des icônes et les restaurer en fin de combat"
L.SpamBlockNoRangeRestore	= "Ne pas restaurer le radar de portée quand les addons le cachent"

L.Area_SpamFilter			= "Options des filtres de spam"
L.DontShowFarWarnings		= "Ne pas afficher les annonces/décomptes pour les événements lointains"
L.StripServerName			= "Ne pas afficher le royaume sur les alertes et les décomptes"
L.FilterVoidFormSay2			= "Ne pas envoyer de message d'icône ou de décompte sous Forme du Vide (les messages normaux seront toujours envoyés)"

L.Area_SpecFilter			= "Options de filtre par rôle"
L.FilterTankSpec			= "Filtrer les alertes réservées aux tanks si vous n'êtes pas en spé tank. (Note: Désactivation non recommandée car les alertes de taunt sont activées en permanence par défaut.)"
L.FilterInterruptNoteName	= "Filtrer les alertes des sorts interruptibles (avec compte) si l'alerte ne contient pas votre nom dans la note personnalisée"
L.FilterDispels				= "Filtrer les alertes de dissipations si votre sort de dissipation est en recharge"
L.FilterCrowdControl		= "Filtrer les annonces pour les interruptions basées sur le contrôle de foule si votre CC est en temps de recharge."
L.FilterTrashWarnings		= "Filtrer toutes les annonces liées aux trash dans les donjons normaux &amp; héroïques"

L.Area_PullTimer			= "Options du filtre des décomptes de pull, pause, & personnalisé"
L.DontShowPTNoID			= "Bloquer les décomptes de pull envoyés depuis une zone différente de la vôtre"
L.DontShowPT				= "Ne pas afficher la barre de pull/pause"
L.DontShowPTText			= "Ne pas afficher le texte d'alerte du décompte de pull/pause"
L.DontPlayPTCountdown		= "Ne jouer aucun son de décompte de pull/pause/perso"
L.PT_Threshold				= "Pas de son du décompte de pull/pause/perso au delà de : %d"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "Bloquer les fonctionnalités de Blizzard."
--Toast
L.Area_HideToast 					= "Désactiver les notifications Blizzard"
L.HideGarrisonUpdates 				= "Cacher les notifications de suivi pendant les combats de boss"
L.HideGuildChallengeUpdates 		= "Cacher les notifications de défi de guilde pendant les combats de boss"
--L.HideBossKill 					= "Cacher les notifications de mort de boss" --NYI
--L.HideVaultUnlock					= "Cacher les notifications de déblocage du coffre" --NYI
--Cut Scenes
L.Area_Cinematics 					= "Bloquer les cinématiques en jeu"
L.DuringFight 						= "Bloquer les cinématiques en combat pendant les rencontres de boss" -- utilise une vérification explicite de IsEncounterInProgress
L.InstanceAnywhere 					= "Bloquer les cinématiques non liées au combat n'importe où à l'intérieur d'une instance de donjon ou de raid"
L.NonInstanceAnywhere 				= "DANGER : Bloquer les cinématiques en extérieur dans le monde ouvert (NON recommandé)"
L.OnlyAfterSeen 					= "Ne bloquer les cinématiques qu'après les avoir vues au moins une fois (Vivement recommandé pour vivre l'histoire telle qu'elle a été conçue au moins une fois)"
-- Sound
L.Area_Sound 						= "Bloquer les sons en jeu"
L.DisableSFX 						= "Désactiver le canal des effets sonores pendant les combats de boss"
L.DisableAmbiance 					= "Désactiver le canal de l'ambiance sonore pendant les combats de boss"
L.DisableMusic 						= "Désactiver le canal de la musique pendant les combats de boss (Remarque : Si activé, la musique de boss personnalisée ne sera pas jouée si elle est activée dans les sons d'événement)"
-- Autres
L.Area_HideBlizzard 				= "Désactiver et cacher d'autres irritants Blizzard"
L.HideBossEmoteFrame 				= "Cacher le cadre des émotes de boss de raid pendant les combats de boss"
L.HideWatchFrame 					= "Cacher le cadre de suivi (objectifs) pendant les combats de boss s'il n'y a pas d'exploits en cours de suivi et si ce n'est pas dans une Mythique +"
L.HideQuestTooltips 				= "Cacher les objectifs de quête des info-bulles pendant les combats de boss" --Currently hidden (NYI)
L.HideTooltips 						= "Cacher complètement les info-bulles pendant les combats de boss"

-- Panel: Raid Leader Controls
L.Tab_RLControls					= "Contrôles du chef de raid"
L.Area_FeatureOverrides				= "Options de dérogation des fonctionnalités"
L.OverrideIcons 					= "Désactiver le marquage des icônes pour tous les utilisateurs du raid, y compris vous-même"-- (Use override instead of disable if you want DBM to do marking under your terms)
L.OverrideSay						= "Désactiver les messages de bulle de chat/DIRE pour tous les utilisateurs du raid, y compris vous-même"
L.DisableStatusWhisperShort			= "Désactiver les chuchotements de statut/réponse pour tout le groupe"--Duplicated from privacy but makes sense to include option in both panels
L.DisableGuildStatusShort			= "Désactiver la synchronisation des messages de progression avec la guilde pour tout le groupe"--Duplicated from privacy but makes sense to include option in both panels
--L.DisabledForDropdown				= "Choisir le(s) mod(s) de boss désactivé(s) pour"--NYI
--L.DiabledForBoth					= "Désactiver les fonctionnalités ci-dessus pour DBM et BW"---NYI
--L.DiabledForDBM					= "Désactiver les fonctionnalités ci-dessus uniquement pour les utilisateurs de DBM"--NYI
--L.DiabledForBW					= "Désactiver les fonctionnalités ci-dessus uniquement pour les utilisateurs de BW"--NYI

L.Area_ConfigOverrides				= "Options de dérogation de configuration (PAS ENCORE IMPLEMENTÉ, à venir)"--NYI
L.OverrideBossAnnounceOptions		= "Définir la configuration des annonces des mods de boss de tous les utilisateurs de DBM sur ma configuration"--NYI
L.OverrideBossTimerOptions			= "Définir la configuration des chronomètres des mods de boss de tous les utilisateurs de DBM sur ma configuration"--NYI
L.OverrideBossIconOptions			= "Définir la configuration des icônes des mods de boss de tous les utilisateurs de DBM sur ma configuration (si le paramètre d'icône est désactivé dans les options ci-dessus, cette option est ignorée)"--NYI
L.OverrideBossSayOptions			= "Définir la configuration des bulles de chat des mods de boss de tous les utilisateurs de DBM sur ma configuration (si le paramètre de bulle de chat est désactivé dans les options ci-dessus, cette option est ignorée)"--NYI
L.ConfigAreaFooter					= "Les options de cette zone ne modifient temporairement la configuration des utilisateurs lors de l'engagement sans altérer leur configuration sauvegardée."
L.ConfigAreaFooter2					= "Il est recommandé de prendre en compte tous les rôles et de ne pas exclure les chronomètres/alertes qu'un tank, etc. pourrait avoir besoin"

L.Area_receivingOptions				= "Options de réception (PAS ENCORE IMPLEMENTÉ, à venir)"--NYI
L.NoAnnounceOverride				= "Ne pas accepter les dérogations d'annonces des chefs de raid."--NYI
L.NoTimerOverridee					= "Ne pas accepter les dérogations de chronomètre des chefs de raid."--NYI
L.ReplaceMyConfigOnOverride			= "AVERTISSEMENT : Remplacer de manière permanente mes configurations de mod par celles du chef de raid lors de la dérogation"--NYI
L.ReceivingFooter					= "Les dérogations des options d'icônes et de bulles de chat ne peuvent pas être refusées car ces paramètres affectent les autres joueurs autour de vous"--NYI
L.ReceivingFooter2					= "Si vous activez ces options, c'est entre vous et le chef de raid si votre configuration entre en conflit avec leur intention"--NYI
L.ReceivingFooter3					= "Si vous activez l'option 'remplacer ma configuration de mod', vos paramètres d'origine seront perdus lors de la dérogation"--NYI

L.TabFooter							= "Toutes les options de ce panneau ne fonctionnent que si vous êtes chef de groupe dans un groupe hors donjon/LFR"

-- Panel: Privacy
L.Tab_Privacy 				= "Messages privés"
L.Area_WhisperMessages		= "Options des chuchotements"
L.AutoRespond 				= "Répondre automatiquement aux chuchotements pendant les combats"
L.WhisperStats 				= "Inclure les victoires/défaites dans les réponses"
L.DisableStatusWhisper 		= "Désactiver les chuchotements de statut pour le groupe entier (requiert Chef de groupe). S'appplique seulement aux raids normaux/heroïques/mythiques et aux donjons défis/mythiques."
L.Area_SyncMessages			= "Options de synchronisation des addons"
L.DisableGuildStatus 		= "Empêcher les messages de progression de se synchroniser avec la guilde, si vous êtes chef de groupe, cela affectera tous les utilisateurs de DBM dans votre groupe"
L.EnableWBSharing 			= "Partager quand vous engagez/battez un world boss avec votre guilde et vos amis battle.net qui sont sur le même royaume"

-- Tab: Frames & Integrations
L.TabCategory_Frames		= "Cadres et Intégrations"
L.Area_NamelateInfo			= "Informations sur les auras des plaques de nom de DBM"
-- Panel: InfoFrame
L.Panel_InfoFrame			= "Cadre d'infos"

-- Panel: Range
L.Panel_Range				= "Cadre de portée"

-- Panel: Nameplate
L.Panel_Nameplates			= "Barres de vie"
L.Area_NPStyle				= "Style (Remarque : Configure uniquement le style lorsque DBM gère les plaques de nom.)"
L.NPAuraText				= "Afficher le texte du chronomètre sur les icônes des plaques de nom"
L.NPAuraSize				= "Taille des pixels de l'aura (carré) : %d"
L.NPIcon_BarOffSetX 		= "Décalage X de l'icône : %d"
L.NPIcon_BarOffSetY 		= "Décalage Y de l'icône : %d"
L.NPIcon_GrowthDirection 	= "Direction de croissance de l'icône"
L.NPIcon_Spacing		 	= "Espacement de l'icône : %d"
L.NPIcon_MaxTextLen		 	= "Longueur max. du texte : %d"
L.NPIconAnchorPoint		 	= "Point d'ancrage de l'icône"
L.NPDemo					= "Test (Soyez près des plaques de nom)"
L.FontTypeTimer				= "Sélectionner la police du chronomètre"
L.FontTypeText				= "Sélectionner la police du texte"

--L.Area_NPGlow				= "Glow (Note: Only configures glow when DBM is handling nameplates.)"
L.NPIcon_GlowBehavior 		= "Comportement de l'illumination de l'icône"
--L.NPIcon_CastGlowBehavior = "Cast Icon Glow Behavior"
L.NPIcon_GlowNone			= "Ne jamais illuminer les icônes"
L.NPIcon_GlowImportant		= "Illuminer les icônes importants de recharge/incantation expirant"
L.NPIcon_GlowAll			= "Illuminer tous les icônes de recharge/incantation expirant"
--L.NPIcon_GlowTypeCD		= "Cooldown Icon Glow Type"
--L.NPIcon_GlowTypeCast		= "Cast Icon Glow Type"
--L.NPIcon_Pixel  			= "Pixel"
--L.NPIcon_Proc  			= "Proc"
--L.NPIcon_AutoCast  		= "Auto Cast"
--L.NPIcon_Button       	 = "Button"

-- Misc
L.Area_General				= "Général"
L.Area_Position				= "Position"
L.Area_Style				= "Style"

L.FontSize					= "Taille de la police: %d"
L.FontStyle					= "Contours de la police"
L.FontColor					= "Couleur texte"
L.FontShadow				= "Ombre"
L.FontType					= "Choisir une police"

L.FontHeight	= 16

-- Testing
L.DevPanel							= "Développement et Tests"
L.DevPanelArea						= "Interface de développement et de tests"
L.DevPanelExplanation				= "Ceci est une interface de développement et de tests qui valide que DBM fonctionne comme prévu en rejouant des journaux de combat." -- Test UI panel under options
L.DevModPanelExplanation			= [[Bienvenue dans l'aire de développement et de tests pour ce mod.
Vous pouvez rejouer des journaux de combats de boss ici pour voir comment le mod se comporte et tester les intégrations avec les callbacks de DBM. Voir DBM-Test/README.md pour plus de détails sur les intégrations et callbacks. DBM est fourni avec des journaux d'exemple pour de nombreux raids, mais vous pouvez également importer vos propres journaux depuis Transcriptor.
]]  -- Playground mode in mods

L.TimewarpSetting					= "Distorsion temporelle : %dx"
L.TimewarpDynamic					= "Distorsion temporelle : dynamique (la plus rapide)"
L.TestSupportArea					= "Options de chargement du mod"
L.ModNotLoadedWithTests				= "Avertissement : Ce mod n'est actuellement pas chargé avec un support complet pour les tests. Si le mod appelle directement des fonctions API telles que UnitHealth() ou UnitName(), celles-ci ne fonctionneront pas correctement. C'est souvent le cas pour les fonctions liées à la santé, au pouvoir ou aux cibles des unités."
L.ModLoadedWithTests				= "Le mod est actuellement chargé avec un support pour les tests car au moins un mod dans l'addon a des tests activés."
L.AlwaysLoadModWithTests			= "Charger toujours ce mod avec un support complet pour les tests (ralentit légèrement le chargement)"
L.ModLoadRequiresReload				= ", nécessite un rechargement de l'interface pour prendre effet" -- Appended to L.AlwaysLoadModWithTests
L.TestSelectArea					= "Données de test" -- Title of the UI area
L.SelectTestLog						= L.TestSelectArea  -- Title for the dropdown to select a  specific test
L.SelectPerspective					= "Perspective du journal (joueur simulé)"
L.ImportTranscriptor				= "Importer le journal Transcriptor"
L.ImportTranscriptorHeader			= [[
Importez un journal Transcriptor en le collant dans n'importe quelle partie du champ d'édition ci-dessous. La vitesse de collage est d'environ 2 MiB/s, ce qui signifie que votre jeu se figera pendant plusieurs secondes lors du collage de fichiers de journal très volumineux.
Vous pouvez également importer la session actuelle de Transcriptor depuis les variables sauvegardées de Transcriptor avec le bouton d'importation à droite.]]
L.PasteLogHere						= "Appuyez sur " .. (IsMacClient() and "Cmd-V" or "Ctrl-V") .. " pour coller un journal ici."
L.LogPasted							= "Collé %.2f MiB en %.1f secondes (%.2f MiB/s)."
L.ImportLocalTranscriptor			= "Importer la session\nactuelle de Transcriptor"
L.NoLocalTranscriptor				= "Impossible de trouver les données locales de Transcriptor."
L.LocalImportDone					= "Importé %d journaux avec %d rencontres depuis Transcriptor."
L.Parsing							= "Analyse en cours..."
L.SelectLogDropdown					= "Sélectionner une rencontre"
L.CreateTest						= "Créer un test"
L.CreatedTest						= "Test créé avec %d événements en %.1f secondes."
L.NoLogsFound						= "L'importation de Transcriptor ne contient pas de données de journal."
L.NoTestDataAvailable				= "Aucune donnée de test disponible"
L.NoLogSelected						= "Échec de la création du test : Aucun journal sélectionné."
L.LogAlreadyImported				= "Échec de la création du test : Test déjà importé."

L.RewriteAllToYou					= "Tous les joueurs en même temps"
L.RealModOptionsBelow				= "Les options du mod ci-dessous sont synchronisées entre le mode de test et vos paramètres réels."
L.Test								= "Test"
L.Tests								= "Tests"
L.AllTests							= "Tous les tests"
L.RunTest							= "Exécuter le test"
L.RunTestShort						= "Exécuter" -- Same intend as RunTest, but a smaller button
L.StopTest							= "Arrêter le test"
L.StopTests							= "Arrêter les tests"
L.RunAllTests						= "Exécuter tous les tests"
L.Queued							= "En attente"
L.Running							= "En cours"
L.Failed							= "Échoué"
L.ShowReport						= "Afficher le rapport"
L.ShowDiff							= "Afficher les différences"
L.ShowErrors						= "Afficher les erreurs"
L.TestModEntry						= "[Aire de tests] %s"
L.EnterTestMode						= "Mode de test"
