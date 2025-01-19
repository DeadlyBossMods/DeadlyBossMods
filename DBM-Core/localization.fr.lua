if GetLocale() ~= "frFR" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD					= "Bienvenue sur " .. L.DBM .. ". Tapez /dbm help pour une liste des commandes supportées. Pour accédez aux options, tapez /dbm dans la fenêtre de discussion pour commencer la configuration. Chargez des zones spécifiques manuellement pour configurer tous les paramètres spécifiques aux boss selon vos envies. " .. L.DBM .. " essaie de le faire pour vous en analysant votre spécialisation au premier lancement, mais nous savons que de toute façon certaines personnes souhaitant activer d'autres options."
L.SILENT_REMINDER 					= "Rappel : " .. L.DBM .. " est toujours en mode silencieux."
L.NEWS_UPDATE						= "|h|c11ff1111Nouvelles|r|h: Cette mise à jour modifie la structure des mods pour que le classique et le principal utilisent désormais des modules unifiés (identiques). Cela signifie que les modules Vanilla, TBC, Wrath et Cata sont maintenant installés séparément en utilisant les mêmes packages que le jeu de base. En savoir plus à ce sujet |Hgarrmission:DBM:news|h|cff3588ff[ici]|r|h"
L.NEWS_UPDATE_REPEAT				= "|h|c11ff1111Nouvelles|r|h: Cette mise à jour modifie la structure des mods pour que le classique et le principal utilisent désormais des modules unifiés (identiques). Cela signifie que les modules Vanilla, TBC, Wrath et Cata sont maintenant installés séparément en utilisant les mêmes packages que le jeu de base. Vous êtes actuellement dans un raid qui a un module manquant. Ce message continuera de s'afficher (et vous n'aurez pas d'alertes fonctionnelles pour cette zone) jusqu'à ce que vous ayez installé le module de raid manquant."

L.COPY_URL_DIALOG_NEWS 				= "Pour lire les dernières nouvelles, visitez le lien ci-dessous"

L.LOAD_MOD_ERROR			= "Erreur lors du chargement des modules %s: %s"
L.LOAD_MOD_SUCCESS			= "Modules '%s' chargés. Pour plus d'options, tapez /dbm ou /dbm help dans la fenêtre de discussion."
L.LOAD_MOD_COMBAT			= "Chargement de '%s' reporté jusqu'à la fin du combat"
L.LOAD_GUI_ERROR			= "Impossible de charger l'interface: %s"
L.LOAD_GUI_COMBAT			= "GUI ne peut pas se charger initialement en combat. GUI sera chargé après le combat. Une fois le GUI chargé, vous pourrez le charger en combat." --load?reload?change?
L.BAD_LOAD					= "" .. L.DBM .. " a détecté une erreur de chargement du mod de l'instance car vous êtes en combat. Dès que vous sortez de combat veuillez entrer /console reloadui le plus vite possible."
L.LOAD_MOD_VER_MISMATCH		= "%s n'a pas pu être chargé car votre DBM-Core ne remplit pas les conditions. Il vous faut une version plus récente."
L.LOAD_MOD_EXP_MISMATCH 	= "%s n'a pas pu être chargé car il est conçu pour une extension de WoW qui n'est pas actuellement disponible. Lorsque l'extension sera disponible, ce mod fonctionnera automatiquement."
L.LOAD_MOD_TOC_MISMATCH 	= "%s n'a pas pu être chargé car il est conçu pour un patch WoW (%s) qui n'est pas actuellement disponible. Lorsque le patch sera disponible, ce mod fonctionnera automatiquement."
L.LOAD_MOD_DISABLED 		= "%s est installé mais actuellement désactivé. Ce mod ne sera pas chargé à moins que vous ne l'activiez."
L.LOAD_MOD_DISABLED_PLURAL 	= "%s sont installés mais actuellement désactivés. Ces mods ne seront pas chargés à moins que vous ne les activiez."

L.COPY_URL_DIALOG 			= "Copier l'URL"
L.COPY_WA_DIALOG 			= "Copier la clé WA"

--Post Patch 7.1
L.TEXT_ONLY_RANGE 			= "La fenêtre de portée est limitée au texte uniquement en raison des restrictions de l'API dans cette zone."
L.NO_RANGE 					= "La fenêtre de portée ne peut pas être utilisée en raison des restrictions de l'API dans cette zone."
L.NO_ARROW 					= "La flèche ne peut pas être utilisée dans les instances."
L.NO_HUD 					= "HUDMap ne peut pas être utilisé dans les instances."

L.DYNAMIC_DIFFICULTY_CLUMP	= L.DBM .. " a désactivé la vérification du nombre de joueurs à portée sur ce combat pour cause de manque d'information sur le nombre de joueurs requis regroupés pour votre taille de raid."
L.DYNAMIC_ADD_COUNT			= L.DBM .. " a désactivé les alertes de décompte d'adds en vie sur ce combat pour cause de manque d'information du nombre d'adds apparaissant pour votre taille de raid."
L.DYNAMIC_MULTIPLE			= L.DBM .. " a désactivé plusieurs fonctionnalités sur ce combat pour cause de manque d'informations sur certains mécanismes pour votre taille de raid."

L.LOOT_SPEC_REMINDER		= "Votre spécialisation actuelle est %s. Votre choix de butin actuel est %s."

L.BIGWIGS_ICON_CONFLICT		= L.DBM .. " a détecté que vous avez activé vos icônes de raid sur " .. L.DBM .. " et Bigwigs simultanément. Désactivez les icônes de l'un d'entre-eux pour éviter tout conflit avec votre raid leader"

L.MOD_AVAILABLE				= "%s est disponible pour ce contenu. Vous pouvez trouver sur Curse, Wago, WowInterface, ou Github."
L.MOD_MISSING				= "Pas de module de raid"

L.COMBAT_STARTED				= "%s engagé. Bonne chance et amusez-vous bien ! :)";
L.COMBAT_STARTED_IN_PROGRESS 	= "Vous êtes engagé dans un combat en cours contre %s. Bonne chance et amusez-vous bien ! :)"
L.GUILD_COMBAT_STARTED 			= "%s a été engagé par le groupe de guilde de %s"
L.SCENARIO_STARTED		   		= "%s a commencé. Bonne chance et amusez-vous bien ! :)"
L.SCENARIO_STARTED_IN_PROGRESS  = "Vous avez rejoint %s déjà entamé. Bonne chance et amusez-vous bien ! :)"
L.BOSS_DOWN						= "%s vaincu après %s !"
L.BOSS_DOWN_I					= "%s vaincu! Vous avez un total de %d victoires."
L.BOSS_DOWN_L					= "%s vaincu après %s ! Votre dernier temps était de %s et votre record de %s. Vous l'avez tué au total %d fois."
L.BOSS_DOWN_NR					= "%s vaincu après %s ! C'est un nouveau record ! (l'ancien record était de %s). Vous l'avez tué au total %d fois."
L.RAID_DOWN						= "%s vaincu après %s !"
L.RAID_DOWN_L					= "%s vaincu après %s ! Votre dernier temps était de %s"
L.RAID_DOWN_NR					= "%s vaincu après %s ! C'est un nouveau record ! (l'ancien record était de %s)."
L.GUILD_BOSS_DOWN				= "%s a été vaincu par le groupe de guilde de %s après %s !"
L.SCENARIO_COMPLETE				= "%s terminé après %s!"
L.SCENARIO_COMPLETE_I			= "%s terminé! Vous l'avez terminé un total de %d fois."
L.SCENARIO_COMPLETE_L			= "%s terminé après %s! Votre dernier run vous a pris %s et votre run le plus rapide %s. Vous avez un total de %d runs."
L.SCENARIO_COMPLETE_NR			= "%s terminé après %s! Ceci est un nouveau record! (Votre ancient record était de %s). Vous l'avez terminé un total de %d fois."
L.COMBAT_ENDED_AT				= "Combat face à %s (%s) terminé après %s."
L.COMBAT_ENDED_AT_LONG			= "Combat face à %s (%s) terminé après %s. Vous cumulez un total de %d défaites dans cette difficulté."
L.GUILD_COMBAT_ENDED_AT			= "Le groupe de guilde de %s terminé sur %s (%s) après %s."
L.SCENARIO_ENDED_AT				= "%s terminé après %s."
L.SCENARIO_ENDED_AT_LONG		= "%s terminé après %s. Vous avez un total de %d défaites dans cette difficulté."
L.COMBAT_STATE_RECOVERED		= "%s a été engagé il y a %s, récupération des délais..."
L.TRANSCRIPTOR_LOG_START	 	= "Début du log de Transcriptor."
L.TRANSCRIPTOR_LOG_END	   		= "Fin du log de Transcriptor."

L.MOVIE_SKIPPED = L.DBM .. " a tenté de passer automatiquement une cinématique."
L.MOVIE_NOTSKIPPED = L.DBM .. " a détecté une cinématique pouvant être sautée mais ne l'a PAS sautée en raison d'un bug de Blizzard. Lorsque ce bug sera corrigé, le saut sera réactivé."
L.BONUS_SKIPPED = L.DBM .. " a automatiquement fermé la fenêtre de butin bonus. Si vous avez besoin de récupérer ca fenêtre, tapez /dbmbonusroll dans les 3 minutes."

L.AFK_WARNING 				= "Vous êtes ABS et en combat (%d pour cent de vie restante), déclenchement d'une alerte sonore. Si vous n'êtes pas ABS, effacez votre statut ABS ou désactivez cette option dans les 'Fonctionnalités supplémentaires'."
L.LOWHEALTH_WARNING			= "Vie faible (%d pour cent de vie restante), déclenchement de l'alerte sonore. Vous pouvez désactiver cette option dans 'Fonctionnalités supplémentaires'."
L.ENTERING_COMBAT			= "Entrée en combat"
L.LEAVING_COMBAT			= "Sortie du combat"

L.COMBAT_STARTED_AI_TIMER = "Mon CPU est un processeur neuronal ; un ordinateur d'apprentissage. (Ce combat utilisera la fonctionnalité d'IA de chronomètre pour générer des approximations de chronomètre)"

L.PROFILE_NOT_FOUND				= "<" .. L.DBM .. "> Votre profile actuel est corrompu. " .. L.DBM .. " va charger le profil par défaut."
L.PROFILE_CREATED				= "'%s' profil créé."
L.PROFILE_CREATE_ERROR			= "Echec de la création de profil. Nom du profil invalide."
L.PROFILE_CREATE_ERROR_D		= "Echec de la création de profil. Le profil '%s' existe déjà."
L.PROFILE_APPLIED				= "Le profil '%s' appliqué."
L.PROFILE_APPLY_ERROR			= "Echec séletion de profil. Le profil '%s' n'existe pas."
L.PROFILE_COPIED				= "Profil '%s' copié."
L.PROFILE_COPY_ERROR			= "Echec de la copie de profil. Le profil '%s' n'existe pas."
L.PROFILE_COPY_ERROR_SELF		= "Impossible de copier le profil sur lui-même."
L.PROFILE_DELETED				= "Profil '%s' effacé. Le profil par défaut sera utilisé."
L.PROFILE_DELETE_ERROR			= "Echec de la suppression de profil. Le profil '%s' n'existe pas."
L.PROFILE_CANNOT_DELETE			= "Impossible de supprimer le profil par défaut."
L.MPROFILE_COPY_SUCCESS			= "Les paramètres du mod %s (%d spec) ont été copiés."
L.MPROFILE_COPY_SELF_ERROR		= "Impossible de copier les paramètres du personnage sur eux-mêmes"
L.MPROFILE_COPY_S_ERROR			= "La source est corrompue. Les paramètres n'ont pas été copiés ou copiés partiellement. Echec de la copie."
L.MPROFILE_COPYS_SUCCESS		= "Les paramètres de son et des notes du mod %s (%d spec) ont été copiés."
L.MPROFILE_COPYS_SELF_ERROR		= "Impossible de copier les paramètres de son et les notes du personnage sur eux-mêmes"
L.MPROFILE_COPYS_S_ERROR		= "La source est corrompue. Les paramètres de son et des notes n'ont pas été copiés ou copiés partiellement. Echec de la copie."
L.MPROFILE_DELETE_SUCCESS		= "Les paramètres du mod %s (%d spec) ont été supprimés."
L.MPROFILE_DELETE_SELF_ERROR	= "Impossible de supprimer les paramètres du mod actuellement utilisés."
L.MPROFILE_DELETE_S_ERROR		= "La source est corrompue. Les paramètres n'ont pas été supprimés ou supprimés partiellement. Echec de la suppression."

L.NOTE_SHARE_SUCCESS			= "%s a partagé sa note pour %s"
L.NOTE_SHARE_LINK				= "Cliquez ici pour ouvrir les notes"
L.NOTE_SHARE_FAIL				= "%s a essayé de partager un texte de note pour %s. Malheureusement, le mod associé avec cette note n'est pas installé ou activé. Si vous avez besoin de celle-ci, Assurez vous d'avoir activé le mod pour lequel cette note est destinée."

L.NOTEHEADER					= "Entrez votre texte de note ici pour %s. Entourer le nom d'un joueur avec >< affichera la couleur associée. Pour les alertes vaec des notes multiples, séparez les par '/'"
L.NOTEFOOTER					= "Appuyez sur 'Ok' pour accepter les changements et 'annuler' pour refuser."
L.NOTESHAREDHEADER				= "%s a partagé la note ci-dessous pour %s. Si vous acceptez, elle effacera votre note actuelle."
L.NOTESHARED					= "Votre noet a été envoyée au groupe."
L.NOTESHAREERRORSOLO			= "Vous vous sentez seul ? Vous ne devriez pas vous envoyer eds notes à vous-même."
L.NOTESHAREERRORBLANK			= "Impossible de partager des notes vides."
L.NOTESHAREERRORGROUPFINDER		= "Les notes ne peuvent pas être partagées en BGs, LFR, or LFG"
L.NOTESHAREERRORALREADYOPEN		= "Vous ne pouvez pas ouvrir le lien de partage d'une note toujours ouverte dans l'éditeur, pour vous empêcher de perdre la note que vous êtes toujours en train de modifier."

L.ALLMOD_DEFAULT_LOADED			= "Les options par défaut pour tous les mods de cette instances ont été chargés."
L.ALLMOD_STATS_RESETED			= "Toutes les stats de tous les mods ont été réinitialisés."
L.MOD_DEFAULT_LOADED			= "Les options par défaut pour ce combat ont été chargés."

L.WORLDBOSS_ENGAGED		 		= "%s a probablement été engagé sur votre royaume à %s de vie. (Envoyé par %s)"
L.WORLDBOSS_DEFEATED		 	= "%s a probablement été tué sur votre royaume (Envoyé par %s)."
L.WORLDBUFF_STARTED				= "%s a commencé sur votre royaume depuis la faction de %s (Envoyé par %s)."

L.TIMER_FORMAT_SECS			= "%.2f |4seconde:secondes;"
L.TIMER_FORMAT_MINS			= "%d |4minute:minutes;"
L.TIMER_FORMAT				= "%d |4minute:minutes; et %.2f |4seconde:secondes;"

L.MIN						= "min"
L.MIN_FMT					= "%d min"
L.SEC						= "sec"
L.SEC_FMT					= "%s sec"

L.GENERIC_WARNING_OTHERS	= "et un autre"
L.GENERIC_WARNING_OTHERS2	= "et %d autres"
L.GENERIC_WARNING_BERSERK	= "Enrage dans %s %s"
L.GENERIC_TIMER_BERSERK		= "Enrage"
L.OPTION_TIMER_BERSERK		= "Afficher les chronomètres pour $spell:26662"
L.BAD						= "Mauvais"

L.OPTION_CATEGORY_TIMERS			= "Barres"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS			= "Annonces"
L.OPTION_CATEGORY_WARNINGS_YOU		= "Annonces personnelles"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Annonces de cible"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "Annonces de rôle"
L.OPTION_CATEGORY_SPECWARNINGS		= "Annonces spéciales"

L.OPTION_CATEGORY_SOUNDS			= "Sons"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS			= "Menu déroulants"--Still put in MISC sub grooup, just used for line separators since multiple of these on a fight (or even having on of these at all) is rare.
L.OPTION_CATEGORY_YELLS 			= "Cris"
L.OPTION_CATEGORY_NAMEPLATES 		= "Barre d'info"
L.OPTION_CATEGORY_ICONS 			= "Icônes"
L.OPTION_CATEGORY_PAURAS 			= "Auras privées"

L.AUTO_RESPONDED					= "Répondu automatiquement."
L.STATUS_WHISPER					= "%s: %s, %d/%d joueurs en vie"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s est occupé à combattre %s (%s, %d/%d joueurs en vie)"
L.WHISPER_COMBAT_END_KILL			= "%s a vaincu %s !"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s a vaincu %s ! Celui-ci a été tué %d fois."
L.WHISPER_COMBAT_END_WIPE_AT		= "%s a subi une défaite sur %s à %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s a subi une défaite sur %s à %s. Ils ont un total de %d défaites dans cette difficulté."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO	  	= "%s est occupé dans %s (%d/%d personnes en vie)"
L.WHISPER_SCENARIO_END_KILL		  	= "%s vient de terminer %s !"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s vient de terminer %s ! Ils ont un total de %d victoires."
L.WHISPER_SCENARIO_END_WIPE		 	= "%s a subi une défaite dans %s"
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s a subi une défaite dans %s. Ils ont un total de %d défaites dans cette difficulté."

L.VERSIONCHECK_HEADER		= "Module de boss - Versions"
L.VERSIONCHECK_ENTRY		= "%s: %s (%s)"
L.VERSIONCHECK_ENTRY_TWO	= "%s: %s (%s) & %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM	= "%s: " .. L.DBM .. " non installé"--Two Boss mods
L.VERSIONCHECK_FOOTER		= "%d joueurs trouvés avec " .. L.DEADLY_BOSS_MODS .. " & %d joueurs avec BigWigs"
L.VERSIONCHECK_OUTDATED		= "Les joueurs suivants %d ont une version périmée du bossmod: %s"
L.YOUR_VERSION_OUTDATED	  	= "Votre version de " .. L.DEADLY_BOSS_MODS .. " est périmée. Veuillez vous rendre sur Curse, Wago, WoWInterface ou Github pour obtenir la dernière version."
L.VOICE_PACK_OUTDATED		= "Il semble que votre paquet de voix " .. L.DBM .. " manque de sons supportés sur cette version de " .. L.DBM .. ". Certains sons d'alertes spéciales ne seront pas joués s'ils utilisent des voix non supportées par votre version. Téléchargez une nouvelle version du paquet de voix ou contactez l'auteur pour une mise à jour qui l'inclut."
L.VOICE_MISSING				= "Vous aviez un paquet de voix sélectionné qui ne pouvait pas être trouvé. Votre sélection a été réinitialisée à 'Aucun'. Si ceci est une erreur, assurez-vous que votre paquet est correctement installé et activé."
L.VOICE_DISABLED			= "Vous avez actuellement au moins un paquet de voix " .. L.DBM .. " installé, mais aucun n'est activé. Si vous prévoyez d'utiliser un paquet de voix, assurez-vous qu'il est sélectionné dans 'Alertes vocales'. Sinon, désinstallez les paquets de voix inutilisés pour cacher ce message."
L.VOICE_COUNT_MISSING		= "Le compte à rebours de la voix %d se trouve dans un paquet qui ne pouvait pas être trouvé. Il a été réinitialisé à l'option par défaut."
L.BIG_WIGS					= "BigWigs" -- OPTIONAL
L.WEAKAURA_KEY				= " (|cff308530Clé WA:|r %s)"

L.UPDATEREMINDER_HEADER 			= "Votre version de " .. L.DEADLY_BOSS_MODS .. " est périmée.\nLa version %s (%s) est disponible sur Curse, Wago, WoWInterface ou Github."
L.UPDATEREMINDER_HEADER_SUBMODULE 	= "Votre module %s est périmé.\nLa version %s est disponible sur Curse, Wago, WoWInterface ou Github."
L.UPDATEREMINDER_FOOTER 			= "Appuyez sur " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " pour copier le lien de téléchargement dans votre presse-papiers."
L.UPDATEREMINDER_FOOTER_GENERIC 	= "Appuyez sur " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " pour copier le lien dans votre presse-papiers."
L.UPDATEREMINDER_DISABLE 			= "ATTENTION : Votre version de " .. L.DEADLY_BOSS_MODS .. " est périmée et incompatible avec les nouvelles versions. " .. L.DBM .. " a été désactivé jusqu’à ce que vous le mettiez à jour. Ceci vise à éviter des problèmes pour vous et les membres de votre raid."
L.UPDATEREMINDER_DISABLETEST 		= "ATTENTION : Votre version de " .. L.DEADLY_BOSS_MODS .. " est périmée, et comme il s'agit d'un royaume de test/bêta, elle a été désactivée de force. Vous devrez la mettre à jour pour pouvoir l'utiliser à nouveau. Ceci est essentiel pour éviter l'utilisation de mods périmées lors des retours sur les tests."
L.UPDATEREMINDER_HOTFIX 			= "Votre version actuelle de " .. L.DBM .. " contient des erreurs de chronomètres ou d'alertes sur ce boss. Ces problèmes ont été corrigés dans la dernière version (ou dans une version alpha si elle est disponible)."
L.UPDATEREMINDER_HOTFIX_ALPHA 		= "Votre version actuelle de " .. L.DBM .. " contient des erreurs connues pour ce combat, corrigées dans une prochaine version (ou dans une version alpha)."
L.UPDATEREMINDER_MAJORPATCH 		= "ATTENTION : Une mise à jour majeure du jeu a eu lieu et votre " .. L.DBM .. " est périmée. Il a été désactivé pour éviter des problèmes causés par un code incompatible. Téléchargez la dernière version sur deadlybossmods.com ou Curse dès que possible."
L.VEM 								= "ATTENTION : Vous utilisez " .. L.DBM .. " et Voice Encounter Mods simultanément. DBM ne fonctionnera pas dans cette configuration et ne sera pas chargé."
L.OUTDATEDPROFILES 					= "ATTENTION : DBM-Profiles n'est pas compatible avec cette version de " .. L.DBM .. ". Il doit être désactivé pour que " .. L.DBM .. " fonctionne correctement."
L.OUTDATEDSPELLTIMERS 				= "ATTENTION : DBM-SpellTimers interfère avec " .. L.DBM .. ". Veuillez le désactiver pour que " .. L.DBM .. " fonctionne correctement."
L.OUTDATEDRLT 						= "ATTENTION : DBM-RaidLeadTools interfère avec " .. L.DBM .. ". DBM-RaidLeadTools n'est plus pris en charge et doit être désactivé pour que " .. L.DBM .. " fonctionne correctement."
L.VICTORYSOUND 						= "ATTENTION : DBM-VictorySound n'est pas compatible avec cette version de " .. L.DBM .. ". Veuillez le supprimer pour éviter les conflits."
L.DPMCORE 							= "ATTENTION : Deadly PvP Mods est périmée et incompatible avec cette version de " .. L.DBM .. ". Veuillez le supprimer pour éviter les conflits."
L.DBMLDB 							= "ATTENTION : DBM-LDB est maintenant intégré dans DBM-Core. Bien qu'il ne provoque aucun problème, il est recommandé de supprimer 'DBM-LDB' de votre dossier d'add-ons."
L.DBMLOOTREMINDER 					= "ATTENTION : Vous avez installé le module tiers DBM-LootReminder. Cet add-on n'est plus compatible avec le client WoW Retail et provoque des problèmes avec " .. L.DBM .. ", notamment sur les chronomètres de pull. Il est recommandé de le désinstaller."
L.UPDATE_REQUIRES_RELAUNCH 			= "ATTENTION : Cette mise à jour de " .. L.DBM .. " ne fonctionnera pas correctement tant que vous n’aurez pas redémarré complètement le client du jeu. La mise à jour inclut des fichiers ou des modifications de fichiers .toc qui nécessitent un redémarrage pour être pris en compte."
L.OUT_OF_DATE_NAG 					= "Votre version de " .. L.DBM .. " est périmée. Il est recommandé de la mettre à jour pour ne pas manquer des alertes, des chronomètres ou des notifications importantes pour votre raid."
L.PLATER_NP_AURAS_MSG 				= L.DBM .. " offre une fonctionnalité avancée permettant d'afficher les temps de recharge des ennemis avec des icônes sur les plaques de nom. Cette option est activée par défaut pour la plupart des utilisateurs, mais pour les utilisateurs de Plater, elle est désactivée par défaut. Pour tirer pleinement parti de DBM et Plater, il est recommandé de l'activer dans la section 'Buff Special' des options de Plater. Si vous ne souhaitez plus voir ce message, vous pouvez désactiver complètement l'option 'Icônes de recharge sur les plaques de nom' dans les options des plaques de nom ou dans les options globales de DBM."

L.MOVABLE_BAR					= "Bougez-moi !"

L.PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h vous a envoyé un délai " .. L.DBM .. ": '%2$s'\n|Hgarrmission:DBM:cancel:%2$s:nil|h|cff3588ff[Annuler ce délais]|r|h |Hgarrmission:DBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorer les délais de %1$s]|r|h"
L.PIZZA_CONFIRM_IGNORE			= "Voulez-vous réellement ignorer les délais " .. L.DBM .. " de %s durant cette session ?"
L.PIZZA_ERROR_USAGE				= "Utilisation: /dbm [broadcast] timer <durée> <texte>"

L.MINIMAP_TOOLTIP_FOOTER		= "Maintenez Maj et glissez pour déplacer"

L.RANGECHECK_HEADER				= "Vérif. de portée (%d m)"
L.RANGECHECK_HEADERT			= "Vérif. de portée  (%dy-%dP)"
L.RANGECHECK_RHEADER			= "R-Vérif. de portée  (%dy)"
L.RANGECHECK_RHEADERT			= "R-Vérif. de portée  (%dy-%dP)"
L.RANGECHECK_SETRANGE			= "Définir la portée"
L.RANGECHECK_SETTHRESHOLD		= "Définir le seuil du joueur"
L.RANGECHECK_SOUNDS				= "Sons"
L.RANGECHECK_SOUND_OPTION_1		= "Son quand un joueur est à portée"
L.RANGECHECK_SOUND_OPTION_2		= "Son quand plus d'un joueur est à portée"
L.RANGECHECK_SOUND_0			= "Aucun son"
L.RANGECHECK_SOUND_1			= "Son par défaut"
L.RANGECHECK_SOUND_2			= "Bip agaçant"
L.RANGECHECK_SETRANGE_TO		= "%d m"
L.RANGECHECK_OPTION_FRAMES		= "Fenêtres"
L.RANGECHECK_OPTION_RADAR		= "Afficher la fenêtre du radar"
L.RANGECHECK_OPTION_TEXT		= "Afficher la fenêtre textuelle"
L.RANGECHECK_OPTION_BOTH		= "Afficher les deux fenêtres"
L.RANGERADAR_HEADER				= "Radar de portée (%d m)"
L.RANGERADAR_RHEADER			= "R-Portée:%d Joueurs:%d"
L.RANGERADAR_IN_RANGE_TEXT		= "%d joueurs à portée"
L.RANGECHECK_IN_RANGE_TEXT		= "%d à portée"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE	= "%s (%0.1fm)"--One target

L.INFOFRAME_TITLE				= "Fenêtre d'info"
L.INFOFRAME_SHOW_SELF			= "Toujours afficher votre puissance"		-- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES 			= "Maximum de lignes"
L.INFOFRAME_SETCOLS 			= "Maximum de colonnes"
L.INFOFRAME_LINESDEFAULT 		= "Défini par le mod"
L.INFOFRAME_LINES_TO 			= "%d lignes"
L.INFOFRAME_COLS_TO 			= "%d colonnes"
L.INFOFRAME_POWER				= "Puissance"
L.INFOFRAME_AGGRO				= "Aggro"
L.INFOFRAME_MAIN				= "Main:"--Main power
L.INFOFRAME_ALT					= "Alt:"--Alternate Power

L.LFG_INVITE					= "Invitation RdG"

L.SLASHCMD_HELP				= {
	"Commandes slash disponibles :",
	"----------------",
	"/dbm unlock : Affiche une barre de délai déplaçable (alias : move).",
	"/range <numéro> ou /distance <numéro>: Affiche la fenêtre de portée. /rrange ou /rdistance pour inverser les couleurs.",
	"/hudar <numéro>: Affiche le radar de portée HUD.",
	"/dbm timer: Lance un chronomètre DBM perso, voir '/dbm timer' pour plus de détails.",
	"/dbm arrow : Affiche la flèche DBM, voir /dbm arrow help pour les détails.",
	"/dbm hud: Affiche le HUD de DBM, voir '/dbm hud' pour plus de détails.",
	"/dbm help2: Affiche les commandes slash de gestion de raid."
}
L.SLASHCMD_HELP2				= {
	"Commandes slash disponibles:",
	"-----------------",
	"/dbm pull <sec> : Lance un délai de pull de <sec> secondes. Donne à tous les membres du raid ayant " .. L.DBM .. " ce délai de pull (nécessite d'être chef du raid ou assistant).",
	"/dbm break <min>: Envoire un chronomètre de pause de <min> minutes au raid (nécessite d'être chef du raid ou assistant).",
	"/dbm version: Effectue une vérification de version de " .. L.DBM .. " (alias : ver).",
	"/dbm version2: Effectue une vérification de version de " .. L.DBM .. " qui chuchote aux membres pas à jour (alias : ver2).",
	"/dbm lag: Effectue une vérification de latence du raid.",
	"/dbm durability: Effectue une vérification de durabilité du raid."
}
L.TIMER_USAGE	= {
	"Commandes " .. L.DBM .. " des chronomètres:",
	"-----------------",
	"/dbm timer <sec> <texte>: Commence un chronomètre de <sec> secondes avec votre <texte>.",
	"/dbm ltimer <sec> <texte>: Commence un chronomètre qui tourne en boucle jusqu'à annulation.",
	"('Broadcast' devant n'importe quel chronomètre et partage avec le raid si vous êtes chef ou assistant)",
	"/dbm timer endloop: Annule les boucles de chronomètre."
}

L.ERROR_NO_PERMISSION			= "Vous n'avez pas la permission requise pour faire cela."
L.ERROR_NO_PERMISSION_COMBAT	= "Le chronomètre de pull/pause ne peut pas être envoyé pendant que le combat est en cours."
L.PULL_TIME_TOO_SHORT			= "Le chronomètre de pull doit durer plus de 3 secondes."
L.PULL_TIME_TOO_LONG			= "Le chronomètre de pull ne peut pas dépasser 60 secondes."

L.BREAK_USAGE				= "Les chronomètres de pause ne peuvent pas durer plus de 60 minutes. Assurez vous de mettre le temps en minutes et pas secondes."
L.BREAK_START				= "La pause commence maintenant -- vous avez %s minute(s) !"
L.BREAK_MIN					= "Fin de la pause dans %s minute(s) !"
L.BREAK_SEC					= "Fin de la pause dans %s secondes !"
L.TIMER_BREAK				= "Pause !"
L.ANNOUNCE_BREAK_OVER		= "La pause est terminée"

L.TIMER_PULL					= "Pull dans"
L.ANNOUNCE_PULL					= "Pull dans %d sec. (Envoyé par %s)"
L.ANNOUNCE_PULL_NOW				= "Pull maintenant !"
L.ANNOUNCE_PULL_TARGET			= "Pull %s dans %d sec. (Envoyé par %s)"
L.ANNOUNCE_PULL_NOW_TARGET		= "Pull %s maintenant !"
L.GEAR_WARNING					= "Attention : Vérification d'équipement. Votre ilvl équippé est de %d plus bas que celui dans vos sacs"
L.GEAR_WARNING_WEAPON			= "Attention : Vérification que votre arme est correctement équipée."
L.GEAR_FISHING_POLE				= "Canne à pêche"

L.ACHIEVEMENT_TIMER_SPEED_KILL = "Victoire rapide"

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.you				= "%s sur VOUS"
L.AUTO_ANNOUNCE_TEXTS.target			= "%s sur >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetsource		= ">%%s< incantation de %s sur >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount		= "%s (%%s) sur >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell				= "%s"
L.AUTO_ANNOUNCE_TEXTS.incoming			= "Affaiblissement de %s imminent"
L.AUTO_ANNOUNCE_TEXTS.incomingcount		= "Affaiblissement de %s imminent (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends				= "%s s'est terminé"
L.AUTO_ANNOUNCE_TEXTS.endtarget			= "%s s'est terminé: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades				= "%s s'est dissipé"
L.AUTO_ANNOUNCE_TEXTS.addsleft			= "%s restant: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast				= "Incantation %s: %.1f sec"
L.AUTO_ANNOUNCE_TEXTS.soon				= "%s imminent"
L.AUTO_ANNOUNCE_TEXTS.sooncount			= "%s (%%s) imminent"
L.AUTO_ANNOUNCE_TEXTS.countdown			= "%s dans %%ds"
L.AUTO_ANNOUNCE_TEXTS.prewarn			= "%s de %s"
L.AUTO_ANNOUNCE_TEXTS.bait				= "%s imminent - appâtez maintenant"
L.AUTO_ANNOUNCE_TEXTS.stage				= "Phase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage			= "Phase %s imminente"
L.AUTO_ANNOUNCE_TEXTS.count				= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack				= "%s sur >%%s< (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto			= "%s - dirigez-vous vers >%%s<"

local prewarnOption 					= "Afficher une pré-annonce pour $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you				= "Afficher une annonce lorsque $spell:%s est sur vous."
L.AUTO_ANNOUNCE_OPTIONS.target			= "Afficher une annonce pour les cibles de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetNF		= "Afficher une annonce pour les cibles de $spell:%s (ignore le filtre de cible global)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource	= "Afficher une annonce pour les cibles de $spell:%s (avec la source)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount		= "Afficher une annonce pour les cibles de $spell:%s (avec décompte)"
L.AUTO_ANNOUNCE_OPTIONS.spell			= "Afficher une annonce pour $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.spellsource		= "Afficher une annonce pour $spell:%s (avec la source)"
L.AUTO_ANNOUNCE_OPTIONS.incoming		= "Afficher une annonce lorsque $spell:%s a des affaiblissements imminents"
L.AUTO_ANNOUNCE_OPTIONS.incomingcount 	= "Afficher une annonce lorsque $spell:%s a des affaiblissements imminents (avec décompte)"
L.AUTO_ANNOUNCE_OPTIONS.ends			= "Afficher une annonce pour lorsque $spell:%s se termine"
L.AUTO_ANNOUNCE_OPTIONS.endtarget   	= "Afficher une annonce pour lorsque $spell:%s se termine (avec cible)"
L.AUTO_ANNOUNCE_OPTIONS.fades			= "Afficher une annonce pour lorsque $spell:%s se dissipe"
L.AUTO_ANNOUNCE_OPTIONS.addsleft		= "Afficher une annonce pour le nombre restant de : $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.cast			= "Afficher une annonce pour lorsque $spell:%s est incanté"
L.AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.countdown		= "Afficher les pré-annonces avec un compte à rebours pour $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.prewarn			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait			= "Afficher les pré-annonces (pour appâter) pour $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stage			= "Afficher une annonce pour l'arrivée de la phase %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange		= "Afficher une annonce pour les changements de phase"
L.AUTO_ANNOUNCE_OPTIONS.prestage		= "Afficher les pré-annonces indiquant l'arrivée de la phase %s"
L.AUTO_ANNOUNCE_OPTIONS.count			= "Afficher une annonce pour $spell:%s (avec décompte)"
L.AUTO_ANNOUNCE_OPTIONS.stack			= "Afficher une annonce pour les cumuls de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.moveto			= "Afficher une annonce pour quand se déplacer vers quelqu'un ou quelque part pour $spell:%s"

L.AUTO_SPEC_WARN_TEXTS.spell			= "%s !"
L.AUTO_SPEC_WARN_TEXTS.ends				= "%s s'est terminé"
L.AUTO_SPEC_WARN_TEXTS.fades		  	= "%s s'est dissipé"
L.AUTO_SPEC_WARN_TEXTS.soon				= "%s bientôt"
L.AUTO_SPEC_WARN_TEXTS.sooncount		= "%s (%%s) imminent"
L.AUTO_SPEC_WARN_TEXTS.bait				= "%s imminent - appâtez maintenant"
L.AUTO_SPEC_WARN_TEXTS.prewarn			= "%s dans %s"
L.AUTO_SPEC_WARN_TEXTS.dispel			= "%s on >%%s< - dissipez maintenant"
L.AUTO_SPEC_WARN_TEXTS.interrupt		= "%s - interrompez >%%s< !"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - interrompez >%%s< ! (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you				= "%s sur vous"
L.AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) sur vous"
L.AUTO_SPEC_WARN_TEXTS.youpos 			= "%s (Position : %%s) sur vous"
L.AUTO_SPEC_WARN_TEXTS.youposcount 		= "%s (%%s) (Position : %%s) sur vous"
L.AUTO_SPEC_WARN_TEXTS.soakpos 			= "%s (Position d'absorption : %%s)"
L.AUTO_SPEC_WARN_TEXTS.target			= "%s sur >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) sur >%%s< "
L.AUTO_SPEC_WARN_TEXTS.link				= "%s lié avec >%%s<"
L.AUTO_SPEC_WARN_TEXTS.defensive		= "%s - défensif"
L.AUTO_SPEC_WARN_TEXTS.taunt		   	= "%s sur >%%s< - provoquez maintenant"
L.AUTO_SPEC_WARN_TEXTS.close			= "%s sur >%%s< près de vous"
L.AUTO_SPEC_WARN_TEXTS.move				= "%s - écartez-vous"
L.AUTO_SPEC_WARN_TEXTS.keepmove 		= "%s - continuez à écarter"
L.AUTO_SPEC_WARN_TEXTS.stopmove 		= "%s - arrêtez de écarter"
L.AUTO_SPEC_WARN_TEXTS.dodge 			= "%s - esquivez"
L.AUTO_SPEC_WARN_TEXTS.dodgecount 		= "%s (%%s) - esquivez l'attaque"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc 		= "%s - esquivez depuis %%s"
L.AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - écartez-vous du raid"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount	= "%s (%%s) - écartez-vous des autres"
L.AUTO_SPEC_WARN_TEXTS.moveto	  		= "%s - dirigez-vous vers >%%s<"
L.AUTO_SPEC_WARN_TEXTS.soak 			= "%s - absorbez-le"
L.AUTO_SPEC_WARN_TEXTS.soakcount 		= "%s - absorbez (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump				= "%s - saute"
L.AUTO_SPEC_WARN_TEXTS.run				= "%s - fuyez"
L.AUTO_SPEC_WARN_TEXTS.runcount			= "%s - fuyez (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast				= "%s - arrêtez d'incanter"
L.AUTO_SPEC_WARN_TEXTS.lookaway			= "%s sur %%s - regardez ailleurs"
L.AUTO_SPEC_WARN_TEXTS.reflect	 		= "%s sur >%%s< - arrêtez d'attaquer"
L.AUTO_SPEC_WARN_TEXTS.count	   		= "%s ! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack			= "%s (%%d)"
L.AUTO_SPEC_WARN_TEXTS.switch			= "%s - Changer de cible"
L.AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - Changer de cible (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo 			= "%%s de dégâts - éloignez-vous"
L.AUTO_SPEC_WARN_TEXTS.adds 			= "Adds imminents - changez de cibles" --Basically a generic of switch
L.AUTO_SPEC_WARN_TEXTS.addscount 		= "Adds imminents - changez de cibles (%%s)" --Basically a generic of switch
L.AUTO_SPEC_WARN_TEXTS.addscustom 		= "Adds imminents - %%s" --Same as above, but more info, pretty much made for like 3 boss mods, such as akama
L.AUTO_SPEC_WARN_TEXTS.targetchange 	= "Changement de cible - passez à %%s"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Afficher une annonce spéciale pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends			= "Afficher une annonce spéciale lorsque $spell:%s se termine"
L.AUTO_SPEC_WARN_OPTIONS.fades		   	= "Afficher une annonce spéciale lorsque $spell:%s se dissipe"
L.AUTO_SPEC_WARN_OPTIONS.soon			= "Afficher une pré-annonce spéciale pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.sooncount		= "Afficher une pré-annonce spéciale (avec compte) pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.bait			= "Afficher une annonce pré-spéciale (pour appâter) pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn		= "Afficher une pré-annonce spéciale %s seconds avant $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 		= "Afficher une annonce spéciale lorsque $spell:%s doit être dissipé/volé"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Afficher une annonce spéciale lorsque $spell:%s doit être interrompu"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Afficher une annonce spéciale (avec compte) d'interrompre $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Afficher une annonce spéciale lorsque vous subissez $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Afficher une annonce spéciale (avec compte) quand vous êtes affecté par $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youpos 		= "Afficher une annonce spéciale (avec position) lorsque vous êtes affecté par $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youposcount 	= "Afficher une annonce spéciale (avec position et décompte) lorsque vous êtes affecté par $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakpos 		= "Afficher une annonce spéciale (avec position) pour aider à absorber les effets de $spell:%s sur d'autres"
L.AUTO_SPEC_WARN_OPTIONS.target 		= "Afficher une annonce spéciale lorsque quelqu'un subit $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Afficher une annonce spéciale (avec compte) quand quelqu'un est affecté par $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.link			= "Afficher une annonce spéciale lorsque vous êtes lié à un autre joueur par $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.defensive 		= "Afficher une annonce spéciale pour utiliser les capacités défensives pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt		   	= "Afficher une annonce spéciale de provoquer lorsque l'autre tank subit $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Afficher une annonce spéciale lorsque quelqu'un proche de vous subit $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Afficher une annonce spéciale lorsque vous devez sortir de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "Afficher une annonce spéciale pour continuer à écarter pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stopmove	 	= "Afficher une annonce spéciale pour arrêter de écarter pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Afficher une annonce spéciale lorqu'il faut esquiver $spell:%s" --not sure in which case the message appears but this should work
L.AUTO_SPEC_WARN_OPTIONS.dodgecount 	= "Afficher une annonce spéciale (avec compte) lorqu'il faut esquiver $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc 		= "Afficher une annonce spéciale (avec emplacement) lorqu'il faut esquiver $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.moveaway		= "Afficher une annonce spéciale lorsque vous subissez $spell:%s et devez vous écarter du raid"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount 	= "Afficher une annonce spéciale (avec compte) lorsque vous subissez $spell:%s et devez vous écarter du raid"
L.AUTO_SPEC_WARN_OPTIONS.moveto		  	= "Afficher une annonce spéciale lorsque vous devez vous rapprocher de quelqu'un subissant $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soak 			= "Afficher une annonce spéciale pour absorber $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.soakcount 		= "Afficher une annonce spéciale (avec compte) pour absorber $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.jump 			= "Afficher une annonce spéciale pour sauter pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Afficher une annonce spéciale lorsque vous devez fuir $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.runcount		= "Afficher une annonce spéciale (avec compte) lorsque vous devez fuir $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Afficher une annonce spéciale d'interrompre l'incantation de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.lookaway		= "Afficher une annonce spéciale pour regarder ailleurs pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect		= "Afficher une annonce spéciale lorsqu'il faut arrêter d'attaquer pour $spell:%s"--Spell Reflect
L.AUTO_SPEC_WARN_OPTIONS.count		   	= "Afficher une annonce spéciale pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack			= "Afficher une annonce spéciale lorsque vous cumulez >=%d stacks de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switch 		= "Afficher une annonce spéciale de changement de cible pour\n $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount	= "Afficher une annonce spéciale (avec compte) de changer de cible pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "Afficher une annonce spéciale pour sortir de la zone des dégâts au sol"
L.AUTO_SPEC_WARN_OPTIONS.adds 			= "Afficher une annonce spéciale pour changer de cibles pour les adds imminents"
L.AUTO_SPEC_WARN_OPTIONS.addscount 		= "Afficher une annonce spéciale (avec compte) pour changer de cibles pour les adds imminents"
L.AUTO_SPEC_WARN_OPTIONS.addscustom 	= "Afficher une annonce spéciale pour les adds imminents"
L.AUTO_SPEC_WARN_OPTIONS.targetchange 	= "Afficher une annonce spéciale pour les changements de cible prioritaires"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.targetcount	= "%s (%%2$s): %%1$s"
L.AUTO_TIMER_TEXTS.cast			= "%s"
L.AUTO_TIMER_TEXTS.castcount	= "%s (%%s)" -- OPTIONAL
L.AUTO_TIMER_TEXTS.castsource	= "%s: %%s" -- OPTIONAL
L.AUTO_TIMER_TEXTS.active		= "%s se termine" --Buff/Debuff/event on boss,
L.AUTO_TIMER_TEXTS.fades		= "%s se dissipe" --Buff/Debuff on players,
L.AUTO_TIMER_TEXTS.ai			= "%s AI"

L.AUTO_TIMER_TEXTS.cd			= "Rech. %s"
L.AUTO_TIMER_TEXTS.cdcount		= "Rech. %s (%%s)"
L.AUTO_TIMER_TEXTS.cdsource		= "Rech. %s: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial	= "Rech. de capacité spéciale"

L.AUTO_TIMER_TEXTS.next			= "Proch. %s"
L.AUTO_TIMER_TEXTS.nextcount	= "Proch. %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource	= "Proch. %s: >%%s<"
L.AUTO_TIMER_TEXTS.nextspecial	= "Proch. capacité spéciale"

L.AUTO_TIMER_TEXTS.var			= "%s"
L.AUTO_TIMER_TEXTS.varcount		= "%s (%%s)"
L.AUTO_TIMER_TEXTS.varsource	= "%s: >%%s<"--Now same as next, as the ~ was moved to timer number -- OPTIONAL
L.AUTO_TIMER_TEXTS.varspecial	= "Capacité spéciale"--Now same as next, as the ~ was moved to timer number
L.AUTO_TIMER_TEXTS.varcombo		= "%%1$s + %%2$s"--Now same as next, as the ~ was moved to timer number -- OPTIONAL

L.AUTO_TIMER_TEXTS.achievement			= "%s"
L.AUTO_TIMER_TEXTS.stage				= "Phase"
L.AUTO_TIMER_TEXTS.stagecount			= "Phase %%s"--NOT BUGGED, stage is 2nd arg, spellID is ignored on purpose
L.AUTO_TIMER_TEXTS.stagecountcycle		= "Phase %%s (%%s)"--^^. Example: Stage 2 (3) for a fight that alternates stage 1 and stage 2, but also tracks total cycles
L.AUTO_TIMER_TEXTS.stagecontext			= "%s" -- OPTIONAL
L.AUTO_TIMER_TEXTS.stagecontextcount	= "%s (%%s)" -- OPTIONAL
L.AUTO_TIMER_TEXTS.intermission			= "Intervalle"
L.AUTO_TIMER_TEXTS.intermissioncount	= "Intervalle %%s"
L.AUTO_TIMER_TEXTS.adds					= "Adds"
L.AUTO_TIMER_TEXTS.addscustom			= "Adds (%%s)"
L.AUTO_TIMER_TEXTS.roleplay				= GUILD_INTEREST_RP or "Roleplay"--Used mid fight, pre fight, or even post fight. Boss does NOT auto engage upon completion
L.AUTO_TIMER_TEXTS.combat				= "Le combat débute dans"
--This basically clones np only bar option and display text from regular counterparts
L.AUTO_TIMER_TEXTS.cdnp					= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.cdpnp				= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextpnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.castpnp				= L.AUTO_TIMER_TEXTS.cast -- OPTIONAL

L.AUTO_TIMER_OPTIONS.target				= "Afficher un chronomètre pour d'affaiblissement de $spell:%s"
L.AUTO_TIMER_OPTIONS.targetcount		= "Afficher un chronomètre (avec compte) pour d'affaiblissement de $spell:%s"
L.AUTO_TIMER_OPTIONS.cast				= "Afficher un chronomètre pour d'incantation de $spell:%s"
L.AUTO_TIMER_OPTIONS.castpnp			= "Afficher un chronomètre sur la plaque de nom uniquement pour d'incantation de $spell:%s"
L.AUTO_TIMER_OPTIONS.castcount			= "Afficher un chronomètre (avec compte) pour d'incantation de $spell:%s"
L.AUTO_TIMER_OPTIONS.castsource			= "Afficher un chronomètre (avec source) pour d'incantation de $spell:%s"
L.AUTO_TIMER_OPTIONS.active				= "Afficher un chronomètre pour la durée de $spell:%s"
L.AUTO_TIMER_OPTIONS.fades				= "Afficher un chronomètre avant la dissipation de $spell:%s"
L.AUTO_TIMER_OPTIONS.ai					= "Afficher un chronomètre IA pour le recharge de $spell:%s"

L.AUTO_TIMER_OPTIONS.cd					= "Afficher un chronomètre pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdcount			= "Afficher un chronomètre (avec compte) pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdnp 				= "Afficher un chronomètre sur la plaque de nom uniquement pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdsource			= "Afficher un chronomètre pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdspecial			= "Afficher un chronomètre pour le recharge de capacité spéciale"
L.AUTO_TIMER_OPTIONS.cdcombo			= "Afficher un chronomètre pour le recharge de la combinaison de capacités"--Used for combining 2 abilities into a single timer

L.AUTO_TIMER_OPTIONS.next				= "Afficher un chronomètre avant le prochain $spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount			= "Afficher un chronomètre avant le prochain $spell:%s"
L.AUTO_TIMER_OPTIONS.nextnp 			= "Afficher un chronomètre sur la plaque de nom uniquement pour le prochain $spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource			= "Afficher un chronomètre avant le prochain $spell:%s"
L.AUTO_TIMER_OPTIONS.nextspecial		= "Afficher un chronomètre avant la prochaine capacité spéciale"
L.AUTO_TIMER_OPTIONS.nextcombo			= "Afficher un chronomètre pour la prochaine combinaison de capacités"--Used for combining 2 abilities into a single timer

L.AUTO_TIMER_OPTIONS.var				= "Afficher un chronomètre (avec variation) pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.varcount			= "Afficher un chronomètre (avec compte et variation) pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.varnp				= "Afficher uniquement un chronomètre sur la plaque de nom (avec variation) pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.varpnp				= "Afficher uniquement un chronomètre prioritaire sur la plaque de nom (avec variation) pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.varsource			= "Afficher un chronomètre (avec source et variation) pour le recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.varspecial			= "Afficher un chronomètre (avec variation) pour le recharge de capacité spéciale"
L.AUTO_TIMER_OPTIONS.varcombo			= "Afficher un chronomètre (avec variation) pour le recharge de combo de capacités"

L.AUTO_TIMER_OPTIONS.achievement		= "Afficher un chronomètre pour réussir %s"
L.AUTO_TIMER_OPTIONS.stage				= "Afficher un chronomètre de la prochaine phase"
L.AUTO_TIMER_OPTIONS.stagecount 		= "Afficher un chronomètre (avec compte) pour la prochaine phase"
L.AUTO_TIMER_OPTIONS.stagecountcycle 	= "Afficher un chronomètre (avec compte de phase et compte de cycle) pour la prochaine phase"
L.AUTO_TIMER_OPTIONS.stagecontext 		= "Afficher un chronomètre pour la prochaine phase de $spell:%s"
L.AUTO_TIMER_OPTIONS.stagecontextcount 	= "Afficher un chronomètre (avec compte) pour la prochaine phase de $spell:%s"
L.AUTO_TIMER_OPTIONS.intermission 		= "Afficher un chronomètre pour la prochaine interruption"
L.AUTO_TIMER_OPTIONS.intermissioncount 	= "Afficher un chronomètre (avec compte) pour la prochaine interruption"
L.AUTO_TIMER_OPTIONS.adds 				= "Afficher un chronomètre pour les adds imminents"
L.AUTO_TIMER_OPTIONS.addscustom 		= "Afficher un chronomètre pour les adds imminents"
L.AUTO_TIMER_OPTIONS.roleplay			= "Afficher un chronomètre de la durée du roleplay"
L.AUTO_TIMER_OPTIONS.combat				= "Afficher un chronomètre avant le début du combat"

L.AUTO_ICONS_OPTION_TARGETS				= "Définir des icônes sur les cibles de $spell:%s"
L.AUTO_ICONS_OPTION_TARGETS_TANK_A 		= "Définir des icônes sur les cibles de $spell:%s avec priorité tank sur mêlée sur distance et alphabétique comme solution de repli"
L.AUTO_ICONS_OPTION_TARGETS_TANK_R 		= "Définir des icônes sur les cibles de $spell:%s avec priorité tank sur mêlée sur distance et la liste de raid comme solution de repli"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A 	= "Définir des icônes sur les cibles de $spell:%s avec priorité mêlée et alphabétique"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R 	= "Définir des icônes sur les cibles de $spell:%s avec priorité mêlée et de la liste de raid"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A	= "Définir des icônes sur les cibles de $spell:%s avec priorité distance et alphabétique"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R 	= "Définir des icônes sur les cibles de $spell:%s avec priorité distance et de la liste de raid"
L.AUTO_ICONS_OPTION_TARGETS_MRH			= "Définir des icônes sur les cibles de $spell:%s avec priorité mêlée sur distance sur soigneurs et la liste de raid comme solution de repli"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA 		= "Définir des icônes sur les cibles de $spell:%s avec priorité alphabétique"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER 		= "Définir des icônes sur les cibles de $spell:%s avec priorité de la liste de raid"
L.AUTO_ICONS_OPTION_NPCS				= "Définir des icônes sur $spell:%s"
L.AUTO_ICONS_OPTION_CONFLICT			= " (Peut entrer en conflit avec d'autres options)"

L.AUTO_ARROW_OPTION_TEXT				= "Afficher la flèche " .. L.DBM .. " en direction de la cible affectée par $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2				= "Afficher la flèche " .. L.DBM .. " pour s'éloigner de la cible affectée par $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3				= "Afficher la flèche " .. L.DBM .. " pour s'éloigner vers un emplacement spécifique pour $spell:%s"

L.AUTO_YELL_OPTION_TEXT.shortyell		= "Crie lorsque vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.yell			= "Crie lorsque vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.count			= "Crie (avec compte) lorsque vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.fade			= "Crie (avec compte à rebours) lorsque $spell:%s se dissipe"
L.AUTO_YELL_OPTION_TEXT.shortfade		= "Crie (avec compte à rebours) lorsque $spell:%s se dissipe"
L.AUTO_YELL_OPTION_TEXT.iconfade		= "Crie (avec compte à rebours et icône) lorsque $spell:%s se dissipe"
L.AUTO_YELL_OPTION_TEXT.position		= "Crie (avec position) lorsque vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.shortposition 	= "Crie (avec position) lorsque vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.combo 			= "Crie (avec texte personnalisé) lorsque vous êtes affecté par $spell:%s et d'autres sorts en même temps"
L.AUTO_YELL_OPTION_TEXT.repeatplayer 	= "Crie de manière répétée (avec le nom du joueur) lorsque vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.repeaticon 		= "Crie de manière répétée (avec icône) lorsque vous êtes affecté par $spell:%s"

L.AUTO_YELL_ANNOUNCE_TEXT.shortyell		= "%s" -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.yell			= "%s sur " .. UnitName("player") .. " !"
L.AUTO_YELL_ANNOUNCE_TEXT.count			= "%s sur " .. UnitName("player") .. " ! (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade			= "%s disparaît dans %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade		= "%%d" -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade		= "{rt%%2$d}%%1$d" -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.position 		= "%s %%s sur {rt%%d}"..UnitName("player").."{rt%%d}"
L.AUTO_YELL_ANNOUNCE_TEXT.shortposition = "{rt%%1$d}%s"--Icon, Spellname -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.combo			= "%s et %%s"--Spell name (from option, plus spellname given in arg)
L.AUTO_YELL_ANNOUNCE_TEXT.repeatplayer	= UnitName("player")--Doesn't need translation, it's just player name spam -- OPTIONAL
L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon	= "{rt%%1$d}"--Doesn't need translation. It's just icon spam -- OPTIONAL

L.AUTO_YELL_CUSTOM_POSITION			= "{rt%d}%s"--Doesn't need translating. Has no strings (Used in niche situations such as icon repeat yells) -- OPTIONAL
L.AUTO_YELL_CUSTOM_FADE				= "%s disparaît"
L.AUTO_HUD_OPTION_TEXT				= "Afficher HUD pour $spell:%s"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "Afficher HUD pour diverses activités"
L.AUTO_NAMEPLATE_OPTION_TEXT 		= "Afficher les auras de la plaque de nom pour $spell:%s en utilisant un add-on de barre d'info compatible ou "..L.DBM
L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED = "Afficher les auras de la plaque de nom pour $spell:%s en utilisant uniquement "..L.DBM
L.AUTO_RANGE_OPTION_TEXT		 	= "Afficher la fenêtre de portée (%s) pour $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
L.AUTO_RANGE_OPTION_TEXT_SHORT  	= "Afficher la fenêtre de portée (%s)"--For when a range frame is just used for more than one thing
L.AUTO_RRANGE_OPTION_TEXT			= "Afficher la fenêtre de portée inversée (%s) pour $spell:%s"--Reverse range frame (green when players in range, red when not)
L.AUTO_RRANGE_OPTION_TEXT_SHORT		= "Afficher la fenêtre de portée inversée (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT		= "Afficher la fênetre d'information pour $spell:%s" --What frame is this?
L.AUTO_INFO_FRAME_OPTION_TEXT2 		= "Afficher la fênetre d'information pour un aperçu de l'encounter"
L.AUTO_INFO_FRAME_OPTION_TEXT3 		= "Afficher la fênetre d'information pour $spell:%s (lorsque le seuil de %%s est atteint)"
L.AUTO_READY_CHECK_OPTION_TEXT   	= "Jouer le son de l'appel lorsque le boss est engagé (même si ce dernier n'est pas la cible)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT		= "Afficher un chronomètre pour le run plus rapide %s"
L.AUTO_PRIVATEAURA_OPTION_TEXT		= "Jouer des alertes sonores DBM pour les auras privées de $spell:%s dans ce combat."

-- New special warnings
L.MOVE_WARNING_BAR			= "Annonce mobile"
L.MOVE_WARNING_MESSAGE		= "Merci d'utiliser " .. L.DEADLY_BOSS_MODS .. ""
L.MOVE_SPECIAL_WARNING_BAR	= "Alertes spéciales mobiles"
L.MOVE_SPECIAL_WARNING_TEXT	= "Alerte spéciale"

L.HUD_INVALID_TYPE			= "Type de HUD défini invalide"
L.HUD_INVALID_TARGET		= "Pas de cible valide disponible pour le HUD"
L.HUD_INVALID_SELF			= "Impossible de s'utiliser soi-même comme cible pour le HUD"
L.HUD_INVALID_ICON			= "Impossible d'utiliser la méthode par icône pour le HUD sans cible avec l'icône"
L.HUD_SUCCESS				= "Le HUD a démarré correctement avec vos paramètres. Ceci va s'arrêter dans %s, ou en tapant '/dbm hud hide'."
L.HUD_USAGE	= {
	"Utilisation de " .. L.DBM .. "-HudMap:",
	"-----------------",
	"/dbm hud <type> <cible> <durée>: Crée un HUD qui indique un joueur pour la durée choisie",
	"Types valides : flèche, rouge, bleu, vert, jaune, icône (requiert une cible avec une icône de raid)",
	"Cibles valides : cible, focus, <nom du joueur>",
	"Durées valides : n'importe quel nombre (en secondes). Si laissé vide, il sera affiché pendant 20 min.",
	"/dbm hud hide:  désactive et cache le HUD"
}

L.ARROW_MOVABLE				= "Flèche mobile"
L.ARROW_WAY_USAGE			= "/dway <x> <y>: Crée une flèche pointant vers une position spécifique (en utilisant les coordonnées locales de la carte de zone)"
L.ARROW_WAY_SUCCESS			= "Pour cacher la flèche, faites '/dbm arrow hide' ou atteignez la flèche"
L.ARROW_ERROR_USAGE	= {
	"Utilisation de " .. L.DBM .. "-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: Crée une flèche qui pointe vers une position spécifique (0 < x/y < 100)",
	"/dbm arrow map <x> <y>: Crée une flèche qui pointe vers une position spécifique (en utilisant les coordonnées sur la carte)",
	"/dbm arrow <joueur>: Crée une flèche qui pointe vers un joueur spécifique de votre groupe ou raid",
	"/dbm arrow hide: Cache la flèche",
	"/dbm arrow move: Rend la flèche mobile"
}

L.SPEED_KILL_TIMER_TEXT		= "Record à battre"
L.SPEED_CLEAR_TIMER_TEXT  	= "Meilleur clear"
L.COMBAT_RES_TIMER_TEXT		= "Prochaine charge de résurrection en combat"
L.TIMER_RESPAWN				= "%s Réapparition"

L.LAG_CHECKING			   	= "Vérification de la latence du raid..."
L.LAG_HEADER				= L.DEADLY_BOSS_MODS .. " - Résultats sur la latence"
L.LAG_ENTRY				  	= "%s: délai monde [%d ms] / délai domicile [%d ms]"
L.LAG_FOOTER				= "Pas de réponse: %s"

L.DUR_CHECKING 				= "Vérification de la durabilité du raid... "
L.DUR_HEADER 				= L.DEADLY_BOSS_MODS.. " - Résultats de durabilité"
L.DUR_ENTRY 				= "%s: Durabilité [%d pour cent] / Équipement endommagé [%s]"

L.OVERRIDE_ACTIVATED 		= "Les remplacements de configuration ont été activés pour cette rencontre par le responsable de raid"

--LDB
L.LDB_TOOLTIP_HELP1 		= "Cliquez pour ouvrir " .. L.DBM
L.LDB_TOOLTIP_HELP2 		= "Alt+clic droit pour basculer le mode silencieux"
L.SILENTMODE_IS 			= "Le mode silencieux est "

L.WORLD_BUFFS.hordeOny			= "Peuple de la Horde, citoyens d’Orgrimmar, venez, rassemblez-vous et célébrez un héros de la Horde"
L.WORLD_BUFFS.allianceOny		= "Citoyens et alliés de Stormwind, ce jour est historique."
L.WORLD_BUFFS.hordeNef			= "NEFARIAN A ÉTÉ TUÉ ! Peuple d'Orgrimmar"
L.WORLD_BUFFS.allianceNef		= "Citoyens de l'Alliance, le seigneur du clan Blackrock a été tué !"
L.WORLD_BUFFS.zgHeart			= "Il ne reste plus qu'une étape avant que prenne fin la menace de l'Écorcheur d'âmes"
L.WORLD_BUFFS.zgHeartBooty		= "Le Dieu sanglant, l'Écorcheur d'âmes, a été vaincu ! Nous ne sommes plus menacés !"
L.WORLD_BUFFS.zgHeartYojamba	= "Commencez le rituel, mes serviteurs. Nous devons renvoyer le cœur d'Hakkar dans le vide !"
L.WORLD_BUFFS.rendHead			= "Le faux chef Rend Blackhand est tombé !"
L.WORLD_BUFFS.blackfathomBoon	= "Bienfait de Brassenoire"

-- Annoying popup, especially for classic players
L.DBM_INSTALL_REMINDER_HEADER = "Installation incomplète de DBM détectée !"
L.DBM_INSTALL_REMINDER_EXPLAIN = "Bienvenue à %s. Les mods DBM pour les boss ici se trouvent dans le %s que vous n'avez pas installé. DBM n'affichera pas de chronomètres ou d'annonces dans cette zone à moins que vous n'installiez le %s !"
L.DBM_INSTALL_REMINDER_DISABLE = "Désactiver tous les annonces et chronomètres de DBM dans cette zone." -- Used when we believe it's a user error that the mod isn't installed (i.e., current raids)
L.DBM_INSTALL_REMINDER_DISABLE2 = "Ne plus afficher ce message pour ce paquet." -- Used for unimportant mods, i.e., dungeons
L.DBM_INSTALL_REMINDER_DL_WAGO = "Appuyez sur " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " pour copier le lien Wago.io dans votre presse-papiers."
L.DBM_INSTALL_REMINDER_DL_CURSE = "Appuyez sur " .. (IsMacClient() and "Cmd-C" or "Ctrl-C") .. " pour copier le lien Curseforge dans votre presse-papiers."
--"Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "

L.DBM_INSTALL_PACKAGE_VANILLA 	= "Paquet de Vanilla et La saison de la découverte"
L.DBM_INSTALL_PACKAGE_BCC 		= "Paquet de Burning Crusade"
L.DBM_INSTALL_PACKAGE_WRATH 	= "Paquet de Wrath"
L.DBM_INSTALL_PACKAGE_CATA 		= "Paquet de Cataclysm"
L.DBM_INSTALL_PACKAGE_MOP		= "Paquet de Mist of Pandaria"
L.DBM_INSTALL_PACKAGE_DUNGEON 	= "Paquet de Donjons, Gouffres et Événements"

-- Tests
L.DBM_TAINTED_BY_TESTS = "DBM a été utilisé en mode test avec distorsion temporelle lors de la session actuelle, il est recommandé de recharger votre interface avant d'utiliser DBM dans un combat de boss réel. Tout devrait fonctionner comme prévu, mais aucune garantie !"
