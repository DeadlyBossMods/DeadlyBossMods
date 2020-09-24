if GetLocale() ~= "frFR" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

L.HOW_TO_USE_MOD					= "Bienvenue sur DBM. Tapez /dbm help pour une liste des commandes supportées. Pour accédez aux options, tapez /dbm dans la fenêtre de discussion pour commencer la configuration. Chargez des zones spécifiques manuellement pour configurer tous les paramètres spécifiques aux boss selon vos envies. DBM essaie de le faire pour vous en analysant votre spécialisation au premier lancement, mais nous savons que de toute façon certaines personnes souhaitant activer d'autres options."

L.LOAD_MOD_ERROR				= "Erreur lors du chargement des modules %s: %s"
L.LOAD_MOD_SUCCESS			= "Modules '%s' chargés. Pour plus d'options, tapez /dbm ou /dbm help dans la fenêtre de discussion."
L.LOAD_MOD_COMBAT            = "Chargement de '%s' reporté jusqu'à la fin du combat"
L.LOAD_GUI_ERROR				= "Impossible de charger l'interface: %s"
L.LOAD_GUI_COMBAT            = "GUI ne peut pas se charger initialement en combat. GUI sera chargé après le combat. Une fois le GUI chargé, vous pourrez le charger en combat." --load?reload?change?
L.BAD_LOAD                   = "DBM a détecté une erreur de chargement du mod de l'instance car vous êtes en combat. Dès que vous sortez de combat veuillez entrer /console reloadui le plus vite possible."
L.LOAD_MOD_VER_MISMATCH		= "%s n'a pas pu être chargé car votre DBM-Core ne remplit pas les conditions. Il vous faut une version plus récente."

L.DYNAMIC_DIFFICULTY_CLUMP   = "DBM a désactivé la vérification du nombre de joueurs à portée sur ce combat pour cause de manque d'information sur le nombre de joueurs requis regroupés pour votre taille de raid."
L.DYNAMIC_ADD_COUNT          = "DBM a désactivé les alertes de décompte d'adds en vie sur ce combat pour cause de manque d'information du nombre d'adds apparaissant pour votre taille de raid."
L.DYNAMIC_MULTIPLE           = "DBM a désactivé plusieurs fonctionnalités sur ce combat pour cause de manque d'informations sur certains mécanismes pour votre taille de raid  ."

L.LOOT_SPEC_REMINDER         = "Votre spécialisation actuelle est %s. Votre choix de loot actuel est %s."

L.BIGWIGS_ICON_CONFLICT      = "DBM a détecté que vous avez activé vos icônes de raid sur DBM et Bigwigs simultanément. Désactivez les icônes de l'un d'entre-eux pour éviter tout conflit avec votre raid leader"

L.MOD_AVAILABLE				= "%s est disponible pour ce contenu. Vous pouvez trouver sur |HDBM:forums|h|cff3588ffdeadlybossmods.com|r ou sur Curse. Ce message ne s'affichera qu'une fois."

L.COMBAT_STARTED				= "%s engagé. Bonne chance et amusez-vous bien ! :)";
L.COMBAT_STARTED_IN_PROGRESS = "Vous êtes engagé dans un combat en cours contre %s. Bonne chance et amusez-vous bien ! :)"
L.GUILD_COMBAT_STARTED		= "%s a été engagé par la guilde"
L.SCENARIO_STARTED           = "%s a commencé. Bonne chance et amusez-vous bien ! :)"
L.SCENARIO_STARTED_IN_PROGRESS   = "Vous avez rejoint %s déjà entamé. Bonne chance et amusez-vous bien ! :)"
L.BOSS_DOWN					= "%s vaincu après %s !"
L.BOSS_DOWN_I                = "%s vaincu! Vous avez un total de %d victoires."
L.BOSS_DOWN_L				= "%s vaincu après %s ! Votre dernier temps était de %s et votre record de %s. Vous l'avez tué au total %d fois."
L.BOSS_DOWN_NR				= "%s vaincu après %s ! C'est un nouveau record ! (l'ancien record était de %s). Vous l'avez tué au total %d fois."
L.GUILD_BOSS_DOWN			= "%s a été vaincu par la guilde en %s!"
L.SCENARIO_COMPLETE          = "%s terminé après %s!"
L.SCENARIO_COMPLETE_I        = "%s terminé! Vous l'avez terminé un total de %d fois."
L.SCENARIO_COMPLETE_L        = "%s terminé après %s! Votre dernier run vous a pris %s et votre run le plus rapide %s. Vous avez un total de  %d runs."
L.SCENARIO_COMPLETE_NR       = "%s terminé après %s! Ceci est un nouveau record! (Votre ancient record était de %s). Vous l'avez terminé un total de %d fois."
L.COMBAT_ENDED_AT			= "Combat face à %s (%s) terminé après %s."
L.COMBAT_ENDED_AT_LONG		= "Combat face à %s (%s) terminé après %s. Vous cumulez un total de %d wipes dans cette difficulté."
L.GUILD_COMBAT_ENDED_AT		= "La guilde a wipe sur %s (%s) après %s."
L.SCENARIO_ENDED_AT          = "%s terminé après %s."
L.SCENARIO_ENDED_AT_LONG     = "%s terminé après %s. Vous avez un total de %d wipes dans cette difficulté."
L.COMBAT_STATE_RECOVERED		= "%s a été engagé il y a %s, récupération des délais..."
L.TRANSCRIPTOR_LOG_START     = "Début du log de Transcriptor."
L.TRANSCRIPTOR_LOG_END       = "Fin du log de Transcriptor."

--L.COMBAT_STARTED_AI_TIMER

L.PROFILE_NOT_FOUND			= "<DBM> Votre profile actuel est corrompu. DBM va charger le profil par défaut."
L.PROFILE_CREATED			= "'%s' profil créé."
L.PROFILE_CREATE_ERROR		= "Echec de la création de profil. Nom du profil invalide."
L.PROFILE_CREATE_ERROR_D		= "Echec de la création de profil. Le profil '%s' existe déjà."
L.PROFILE_APPLIED			= "Le profil '%s' appliqué."
L.PROFILE_APPLY_ERROR		= "Echec séletion de profil. Le profil '%s' n'existe pas."
L.PROFILE_COPIED				= "Profil '%s' copié."
L.PROFILE_COPY_ERROR			= "Echec de la copie de profil. Le profil '%s' n'existe pas."
L.PROFILE_COPY_ERROR_SELF	= "Impossible de copier le profil sur lui-même."
L.PROFILE_DELETED			= "Profil '%s' effacé. Le profil par défaut sera utilisé."
L.PROFILE_DELETE_ERROR		= "Echec de la suppression de profil. Le profil '%s' n'existe pas."
L.PROFILE_CANNOT_DELETE		= "Impossible de supprimer le profil par défaut."
L.MPROFILE_COPY_SUCCESS		= "Les paramètres du mod %s (%d spec) ont été copiés."
L.MPROFILE_COPY_SELF_ERROR	= "Impossible de copier les paramètres du personnage sur eux-mêmes"
L.MPROFILE_COPY_S_ERROR		= "La source est corrompue. Les paramètres n'ont pas été copiés ou copiés partiellement. Echec de la copie."
L.MPROFILE_COPYS_SUCCESS		= "Les paramètres de son et des notes du mod %s (%d spec) ont été copiés."
L.MPROFILE_COPYS_SELF_ERROR	= "Impossible de copier les paramètres de son et les notes du personnage sur eux-mêmes"
L.MPROFILE_COPYS_S_ERROR		= "La source est corrompue. Les paramètres de son et des notes n'ont pas été copiés ou copiés partiellement. Echec de la copie."
L.MPROFILE_DELETE_SUCCESS	= "Les paramètres du mod %s (%d spec) ont été supprimés."
L.MPROFILE_DELETE_SELF_ERROR	= "Impossible de supprimer les paramètres du mod actuellement utilisés."
L.MPROFILE_DELETE_S_ERROR	= "La source est corrompue. Les paramètres n'ont pas été supprimés ou supprimés partiellement. Echec de la suppression."

L.NOTE_SHARE_SUCCESS			= "%s a partagé sa note pour %s"
L.NOTE_SHARE_LINK			= "Cliquez ici pour ouvrir les notes"
L.NOTE_SHARE_FAIL			= "%s a essayé de partager un texte de note pour %s. Malheureusement, le mod associé avec cette note n'est pas installé ou activé. Si vous avez besoin de celle-ci, Assurez vous d'avoir activé le mod pour lequel cette note est destinée."

L.NOTEHEADER					= "Entrez votre texte de note ici pour %s. Entourer le nom d'un joueur avec >< affichera la couleur associée. Pour les alertes vaec des notes multiples, séparez les par '/'"
L.NOTEFOOTER					= "Appuyez sur 'Ok' pour accepter les changements et 'annuler' pour refuser."
L.NOTESHAREDHEADER			= "%s a partagé la note ci-dessous pour %s. Si vous acceptez, elle effacera votre note actuelle."
L.NOTESHARED					= "Votre noet a été envoyée au groupe."
L.NOTESHAREERRORSOLO			= "Vous vous sentez seul? Vous ne devriez pas vous envoyer eds notes à vous-même."
L.NOTESHAREERRORBLANK		= "Impossible de partager des notes vides."
L.NOTESHAREERRORGROUPFINDER	= "Les notes ne peuvent pas être partagées en BGs, LFR, or LFG"
L.NOTESHAREERRORALREADYOPEN	= "Vous ne pouvez pas ouvrir le lien de partage d'une note toujours ouverte dans l'éditeur, pour vous empêcher de perdre la note que vous êtes toujours en train de modifier."

L.ALLMOD_DEFAULT_LOADED		= "Les options par défaut pour tous les mods de cette instances ont été chargés."
L.ALLMOD_STATS_RESETED		= "Toutes les stats de tous les mods ont été réinitialisés."
L.MOD_DEFAULT_LOADED			= "Les options par défaut pour ce combat ont été chargés."

L.WORLDBOSS_ENGAGED          = "%s a probablement été engagé sur votre royaume à %s de vie. (Envoyé par %s)"
L.WORLDBOSS_DEFEATED         = "%s a probablement été tué sur votre royaume (Envoyé par %s)."

L.TIMER_FORMAT_SECS			= "%.2f |4seconde:secondes;"
L.TIMER_FORMAT_MINS			= "%d |4minute:minutes;"
L.TIMER_FORMAT				= "%d |4minute:minutes; et %.2f |4seconde:secondes;"

L.MIN						= "min"
L.MIN_FMT					= "%d min"
L.SEC						= "sec"
L.SEC_FMT					= "%s sec"

L.GENERIC_WARNING_OTHERS     = "et un autre"
L.GENERIC_WARNING_OTHERS2    = "et %d autres"
L.GENERIC_WARNING_BERSERK	= "Enrage dans %s %s"
L.GENERIC_TIMER_BERSERK		= "Enrage"
L.OPTION_TIMER_BERSERK		= "Montrer les chronos pour $spell:26662"
L.GENERIC_TIMER_COMBAT		= "Le combat débute dans"
L.OPTION_TIMER_COMBAT		= "Montre le timer avant le début du combat"

L.OPTION_CATEGORY_TIMERS			= "Barres"
L.OPTION_CATEGORY_WARNINGS		= "Avertissements"
L.OPTION_CATEGORY_WARNINGS_YOU	= "Annonces personnelles"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Annonces de cible"
L.OPTION_CATEGORY_WARNINGS_ROLE	= "Annonces de rôle"
L.OPTION_CATEGORY_SOUNDS			= "Sons"

L.AUTO_RESPONDED						= "Répondu automatiquement."
L.STATUS_WHISPER						= "%s: %s, %d/%d joueurs en vie"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s est occupé à combattre %s (%s, %d/%d joueurs en vie)"
L.WHISPER_COMBAT_END_KILL			= "%s a vaincu %s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s a vaincu %s! Celui-ci a été tué %d fois."
L.WHISPER_COMBAT_END_WIPE_AT			= "%s a wipé sur %s à %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s a wipé sur %s à %s. Le groupe cumule %d wipes dans cette difficulté."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO      = "%s est occupé dans %s (%d/%d personnes en vie)"
L.WHISPER_SCENARIO_END_KILL          = "%s vient de terminer %s!"
L.WHISPER_SCENARIO_END_KILL_STATS    = "%s vient de terminer %s! Ils ont un total de %d victoires."
L.WHISPER_SCENARIO_END_WIPE          = "%s a échoué dans %s"
L.WHISPER_SCENARIO_END_WIPE_STATS    = "%s a échoué dans %s. Ils ont un total de %d échecs dans cette difficulté."

L.VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versions"
L.VERSIONCHECK_ENTRY			= "%s: %s (%s)"
L.VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) & %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM non installé"--Two Boss mods
L.VERSIONCHECK_FOOTER		= "%d joueurs trouvés avec Deadly Boss Mods & %d joueurs avec BigWigs"
L.VERSIONCHECK_OUTDATED		= "Les joueurs suivants %d ont une version périmée du bossmod: %s"
L.YOUR_VERSION_OUTDATED      = "Votre version de Deadly Boss Mods est périmée. Veuillez vous rendre sur www.deadlybossmods.com pour obtenir la dernière version."
L.VOICE_PACK_OUTDATED		= "Il semble que votre pack de voix DBM manquent de sons supportés sur cette version de DBM. Certains sons d'alertes spéciales ne seront pas joués s'ils utilisent des voix non supportées par votre version. Téléchargez une nouvelle version du pack devoix ou contactez l'auteur pour une mise à jour qui la contient."
L.VOICE_MISSING				= "Vous aviez un pack de voix séléctionné qui ne pouvait pas être trouvé. Votre séléction a été réinitialisée à 'Aucun'. Si ceci est une erreur, assurez vous que votre pack est correctement installé et activé."
L.VOICE_COUNT_MISSING		= "Le compte à rebours de la voix %d se trouve dans un pack qui ne pouvait pas être trouvé. Il a été reinitilisé à l'option par défaut."

L.UPDATEREMINDER_HEADER			= "Votre version de Deadly Boss Mods est périmée.\nLa version %s (%s) est disponible au téléchargement ici:"
L.UPDATEREMINDER_FOOTER			= "Faites la combinaison " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " pour copier le lien de téléchargement dans votre presse-papier."
L.UPDATEREMINDER_FOOTER_GENERIC  = "Faites la combinaison " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " pour copier le lien dans votre presse-papier."
L.UPDATEREMINDER_DISABLE         = "ALERTE: Compte tenu que votre version DBM est fortement périmée (%d révisions), DBM a été désactivé jusqu'à ce que vous le mettiez à jour. Ceci, pour éviter que des versions incompatibles de DBM ne cause de mauvaises éxpériences de jeu pour vous et les membres du raid."
L.UPDATEREMINDER_HOTFIX          = "Votre version de DBM contient des timers et alertes incorrects sur ce boss. Ceci a été corrigé dans la dernière version (ou alpha si la prochaine version n'est pas encore disponible)."
L.UPDATEREMINDER_HOTFIX_ALPHA	= "La version de DBM sur laquelle vous êtes a des problèmes connus sur ce combat qui sont corrigées dans une future version (ou au moins une version alpha)"
L.UPDATEREMINDER_MAJORPATCH		= "ATTENTION: Du au fait que votre DBM n'est pas à jour, celui-ci a été désactivé, puisqu'il y a eu une mise à jour majeure du jeu. Ceci pour être sûr que du code incompatible ou trop vieux ne réduise l'expérience de jeu pour vous ou des membres de votre groupe. Téléchargez une nouvelle version sur deadlybossmods.com ou curse dès que possible."
L.VEM							= "ATTENTION: Vous utilisez et DBM et Voice Encounter Mods. DBM ne tournera pas dans cette configuration et ne sera donc pas chargé."
L.OUTDATEDPROFILES					= "ATTENTION: DBM-Profiles n'est pas compatible avec cette version de DBM. Il faut qu'il soit désactivé pour que DBM puisse tourner sans soucis."
L.UPDATE_REQUIRES_RELAUNCH		= "ATTENTION: Cette mise à jour de DBM ne fonctionnera pas correctement si vous ne relancez pas totalement le client de jeu. Cette mise à jour contient de nouveaux fichiers ou des modifications de fichers .toc qui ne peuvent pas être chargés par un reloadUI. Vous pouvez rencontrer des erreurs tant que vous ne relancez pas le client."
L.OUT_OF_DATE_NAG				= "Votre version de DBM est périmée. Il est recommandé que vous mettiez à jour pour ne pas manquer une alerte, un timer ou un cri important que votre raid prévoit que vous ayez."

L.MOVABLE_BAR				= "Bougez-moi !"

L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h vous a envoyé un délai DBM: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Annuler ce délais]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorer les délais de %1$s]|r|h"
L.PIZZA_CONFIRM_IGNORE			= "Voulez-vous réellement ignorer les délais DBM de %s durant cette session ?"
L.PIZZA_ERROR_USAGE				= "Utilisation: /dbm [broadcast] timer <durée> <texte>"

L.MINIMAP_TOOLTIP_FOOTER		= "MAJ+clic ou clic-droit pour déplacer\nAlt+MAJ+clic pour une saisie libre"

L.RANGECHECK_HEADER			= "Vérif. de portée (%d m)"
L.RANGECHECK_SETRANGE		= "Définir la portée"
L.RANGECHECK_SETTHRESHOLD	= "Régler le seuil du joueur."
L.RANGECHECK_SOUNDS			= "Sons"
L.RANGECHECK_SOUND_OPTION_1	= "Son quand un joueur est à portée"
L.RANGECHECK_SOUND_OPTION_2	= "Son quand plus d'un joueur est à portée"
L.RANGECHECK_SOUND_0			= "Aucun son"
L.RANGECHECK_SOUND_1			= "Son par défaut"
L.RANGECHECK_SOUND_2			= "Bip agaçant"
L.RANGECHECK_SETRANGE_TO		= "%d m"
L.RANGECHECK_OPTION_FRAMES	= "Cadres"
L.RANGECHECK_OPTION_RADAR	= "Afficher le cadre du radar"
L.RANGECHECK_OPTION_TEXT		= "Afficher le cadre textuel"
L.RANGECHECK_OPTION_BOTH		= "Afficher les deux cadres"
L.RANGERADAR_HEADER			= "Radar de portée (%d m)"
L.RANGERADAR_IN_RANGE_TEXT	= "%d joueurs à portée"
L.RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fm)"--One target

L.INFOFRAME_SHOW_SELF		= "Toujours afficher votre puissance"		-- Always show your own power value even if you are below the threshold

L.LFG_INVITE						= "Invitation RdG"

L.SLASHCMD_HELP				= {
	"Commandes slash disponibles :",
	"----------------",
	"/dbm unlock : affiche une barre de délai déplaçable (alias : move).",
	"/range <number> or /distance <number>: Affiche le cadre de portée. /rrange or /rdistance pour inverser les couleurs.",
	"/hudar <number>: Affiche le radar de portée HUD.",
	"/dbm timer: Lance un timer DBM perso, voir '/dbm timer' pour plus de détails.",
	"/dbm arrow : affiche la flèche DBM, voir /dbm arrow help pour les détails.",
	"/dbm hud: Affiche le HUD de DBM, voir '/dbm hud' pour plus de détails.",
	"/dbm help2: Affiche les commandes slash de gestion de raid."
}
L.SLASHCMD_HELP2				= {
	"Commandes slash disponibles:",
	"-----------------",
	"/dbm pull <sec> : lance un délai de pull de <sec> secondes. Donne à tous les membres du raid ayant DBM ce délai de pull (nécessite d'être chef du raid ou assistant).",
	"/dbm break <min>: Envoire un timer de pause de <min> minutes au raid (requiert leader/assistant).",
	"/dbm version: Effectue une vérification de version de DBM (alias: ver).",
	"/dbm version2: Effectue une vérification de version de DBM qui chuchote aux membres pas à jour (alias: ver2).",
	"/dbm lockout : demande aux membres du raid leurs verrouillages actuels d'instance de raid (aliases : lockouts, ids) (nécessite d'être chef du raid ou assistant).",
	"/dbm lag: Effectue une vérification de latence du raid."
}
L.TIMER_USAGE	= {
	"Commandes DBM des timers:",
	"-----------------",
	"/dbm timer <sec> <text>: Commence un timer de <sec> secondes avec votre <text>.",
	"/dbm ltimer <sec> <text>: Commence un timer qui tourne en boucle jusqu'à annulation.",
	"('Broadcast' devant n'importe quel timer et partage avec le raid si leader ou assistant)",
	"/dbm timer endloop: Annule les boucles de ltimer."
}

L.ERROR_NO_PERMISSION				= "Vous n'avez pas la permission requise pour faire cela."

L.UNKNOWN					= "inconnu"
L.LEFT						= "Gauche"
L.RIGHT						= "Droite"
L.BACK						= "Derrière"
L.MIDDLE						= "Milieu"
L.FRONT						= "Devant"--"En face"?/In front
L.INTERMISSION				= "Intermission"--No blizz global for this, and will probably be used in most end tier fights with intermission phases

L.BREAK_USAGE				= "Les timers de pause ne peuvent pas durer plus de 60 minutes. Assurez vous de mettre le temps en minutes et pas secondes."
L.BREAK_START				= "La pause commence maintenant -- vous avez %s minute(s)!"
L.BREAK_MIN					= "Fin de la pause dans %s minute(s) !"
L.BREAK_SEC					= "Fin de la pause dans %s secondes !"
L.TIMER_BREAK				= "Pause !"
L.ANNOUNCE_BREAK_OVER		= "La pause est terminée"

L.TIMER_PULL					= "Pull dans"
L.ANNOUNCE_PULL				= "Pull dans %d sec"
L.ANNOUNCE_PULL_NOW			= "Pull maintenant !"
L.GEAR_WARNING				= "Attention: Vérification d'équipement. Votre ilvl équippé est de %d plus bas que celui dans vos sacs"
L.GEAR_WARNING_WEAPON		= "Attention: Vérification que votre arme est correctement équipée."
L.GEAR_FISHING_POLE			= "Canne à pêche"

L.ACHIEVEMENT_TIMER_SPEED_KILL = "Victoire rapide"

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.target		= "%s sur >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) sur >%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell		= "%s"
L.AUTO_ANNOUNCE_TEXTS.ends		= "%s s'est terminé"
L.AUTO_ANNOUNCE_TEXTS.endtarget	= "%s s'est terminé: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades		= "%s s'est dissipé"
L.AUTO_ANNOUNCE_TEXTS.adds		= "%s restant: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast		= "Incantation %s: %.1f sec"
L.AUTO_ANNOUNCE_TEXTS.soon		= "%s imminent"
L.AUTO_ANNOUNCE_TEXTS.prewarna	= "%s de %s"
L.AUTO_ANNOUNCE_TEXTS.stage		= "Phase %s"
L.AUTO_ANNOUNCE_TEXTS.prestage	= "Phase %s imminente"
L.AUTO_ANNOUNCE_TEXTS.count		= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack		= "%s sur >%%s< (%%d)"

local prewarnOption = "Alerte préventive concernant $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.target		= "Alerte indiquant le(s) cible(s) de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.targetcount	= "Alerte indiquant le(s) cible(s) de $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.spell		= "Alerte concernant $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.ends        = "Affiche une alerte lorsque $spell:%s se termine"
L.AUTO_ANNOUNCE_OPTIONS.endtarget   = "Affiche une alerte lorsque $spell:%s se termine"
L.AUTO_ANNOUNCE_OPTIONS.fades       = "Affiche une alerte lorsque $spell:%s se dissipe"
L.AUTO_ANNOUNCE_OPTIONS.adds		= "Alerte indiquant le nombre restant de : $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.cast		= "Alerte lorsque $spell:%s est incanté"
L.AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.prewarn		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.stage		= "Alerte indiquant l'arrivée de la phase %s"
L.AUTO_ANNOUNCE_OPTIONS.stagechange	= "Annonce les changements de phase"
L.AUTO_ANNOUNCE_OPTIONS.prestage	= "Alerte préventive indiquant l'arrivée de la phase %s"
L.AUTO_ANNOUNCE_OPTIONS.count		= "Alerte concernant $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.stack		= "Alerte indiquant les cumuls de $spell:%s"

L.AUTO_SPEC_WARN_TEXTS.spell			= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends        	= "%s s'est terminé"
L.AUTO_SPEC_WARN_TEXTS.fades           = "%s s'est dissipé"
L.AUTO_SPEC_WARN_TEXTS.soon				= "%s bientôt"
L.AUTO_SPEC_WARN_TEXTS.prewarn			= "%s dans %s"
L.AUTO_SPEC_WARN_TEXTS.dispel			= "%s on >%%s< - dissipez maintenant"
L.AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - interrompez >%%s<!"
L.AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - interrompez >%%s<! (%%d)"
L.AUTO_SPEC_WARN_TEXTS.you				= "%s sur vous"
L.AUTO_SPEC_WARN_TEXTS.youcount        = "%s (%%s) sur vous"
L.AUTO_SPEC_WARN_TEXTS.target			= "%s sur >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) on >%%s< "
L.AUTO_SPEC_WARN_TEXTS.taunt           = "%s sur >%%s< - provoquez maintenant"
L.AUTO_SPEC_WARN_TEXTS.close			= "%s sur >%%s< près de vous"
L.AUTO_SPEC_WARN_TEXTS.move			= "%s - écartez-vous"
L.AUTO_SPEC_WARN_TEXTS.dodge 			= "%s - esquivez" --not sure in which case the message appears but this should work
L.AUTO_SPEC_WARN_TEXTS.moveaway    	= "%s - écartez-vous du raid"
L.AUTO_SPEC_WARN_TEXTS.moveto      	= "%s - dirigez-vous vers >%%s<"
L.AUTO_SPEC_WARN_TEXTS.jump				= "%s - saute"
L.AUTO_SPEC_WARN_TEXTS.run				= "%s - fuyez"
L.AUTO_SPEC_WARN_TEXTS.cast			= "%s - arrêtez d'incanter"
L.AUTO_SPEC_WARN_TEXTS.reflect     	= "%s sur >%%s< - arrêtez d'attaquer"
L.AUTO_SPEC_WARN_TEXTS.count       	= "%s! (%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack			= "%s (%%d)"
L.AUTO_SPEC_WARN_TEXTS.switch			= "%s - Changer de cible"
L.AUTO_SPEC_WARN_TEXTS.switchcount		= "%s - Changer de cible (%%s)"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell 			= "Afficher une alerte spéciale pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends            = "Afficher une alerte spéciale lorsque $spell:%s se termine"
L.AUTO_SPEC_WARN_OPTIONS.fades           = "Afficher une alerte spéciale lorsque $spell:%s se dissipe"
L.AUTO_SPEC_WARN_OPTIONS.soon            = "Afficher une alerte préventive spéciale pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.prewarn         = "Afficher une alerte préventive spéciale %s seconds avant $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dispel 			= "Afficher une alerte spéciale lorsque $spell:%s doit être dissipé/volé"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "Afficher une alerte spéciale lorsque $spell:%s doit être interrompu"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Afficher une alerte spéciale (avec compte) d'interrompre $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.you 			= "Afficher une alerte spéciale lorsque vous subissez $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "Afficher une alerte spéciale (avec compte) quand vous êtes affecté par $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.target 			= "Afficher une alerte spéciale lorsque quelqu'un subit $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 	= "Afficher une alerte spéciale (avec compte) quand quelqu'un est affecté par $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.taunt           = "Afficher une alerte spéciale de provoquer lorsque l'autre tank subit $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.close 			= "Afficher une alerte spéciale lorsque quelqu'un proche de vous subit $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.move 			= "Afficher une alerte spéciale lorsque vous devez sortir de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.dodge 			= "Afficher une alerte spéciale lorqu'il faut esquiver $spell:%s" --not sure in which case the message appears but this should work
L.AUTO_SPEC_WARN_OPTIONS.moveaway        = "Afficher une alerte spéciale lorsque vous subissez $spell:%s et devez vous écarter du raid"
L.AUTO_SPEC_WARN_OPTIONS.moveto          = "Afficher une alerte spéciale lorsque vous devez vous rapprocher de quelqu'un subissant $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.run 			= "Afficher une alerte spéciale lorsque vous devez fuir $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.cast 			= "Afficher une alerte spéciale d'interrompre l'incantation de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.reflect         = "Afficher une alerte spéciale lorsqu'il faut arrêter d'attaquer pour $spell:%s"--Spell Reflect
L.AUTO_SPEC_WARN_OPTIONS.count           = "Afficher une alerte spéciale pour $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack			= "Afficher une alerte spéciale lorsque vous cumulez >=%d stacks de $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switch 			= "Afficher une alerte spéciale de changement de cible pour\n $spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.switchcount		= "Afficher une alerte spéciale (avec compte) de changer de cible pour $spell:%s"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.cast		= "%s"
L.AUTO_TIMER_TEXTS.active		= "%s se termine" --Buff/Debuff/event on boss,
L.AUTO_TIMER_TEXTS.fades		= "%s se dissipe" --Buff/Debuff on players,
L.AUTO_TIMER_TEXTS.ai			= "%s AI"
L.AUTO_TIMER_TEXTS.cd			= "Rech. %s"
L.AUTO_TIMER_TEXTS.cdcount		= "Rech. %s (%%s)"
L.AUTO_TIMER_TEXTS.cdsource	= "Rech. %s: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial	= "CD d'abilité spéciale"
L.AUTO_TIMER_TEXTS.next		= "Proch. %s"
L.AUTO_TIMER_TEXTS.nextcount	= "Proch. %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource	= "Proch. %s: >%%s<"
L.AUTO_TIMER_TEXTS.nextspecial	= "Abilité spéciale suivante"
L.AUTO_TIMER_TEXTS.achievement	= "%s"
L.AUTO_TIMER_TEXTS.stage		= "Phase Suivante"

L.AUTO_TIMER_OPTIONS.target		= "Durée d'affaiblissement de $spell:%s"
L.AUTO_TIMER_OPTIONS.cast		= "Durée d'incantation de $spell:%s"
L.AUTO_TIMER_OPTIONS.active		= "Durée d'activité de $spell:%s"
L.AUTO_TIMER_OPTIONS.fades		= "Délai avant la dissipation de $spell:%s"
L.AUTO_TIMER_OPTIONS.ai			= "Afficher le timer IA pour le cooldown de $spell:%s"
L.AUTO_TIMER_OPTIONS.cd			= "Durée de recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdcount		= "Durée de recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdsource	= "Durée de recharge de $spell:%s"
L.AUTO_TIMER_OPTIONS.cdspecial	= "Afficher le timer pour le cooldown d'abilité spéciale"
L.AUTO_TIMER_OPTIONS.next		= "Délai avant le prochain $spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount	= "Délai avant le prochain $spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource	= "Délai avant le prochain $spell:%s"
L.AUTO_TIMER_OPTIONS.nextspecial	= "Afficher le timer de l'abilité spéciale suivante"
L.AUTO_TIMER_OPTIONS.achievement	= "Délai pour réussir %s"
L.AUTO_TIMER_OPTIONS.stage		= "Afficher le timer de la phase suivante"
L.AUTO_TIMER_OPTIONS.roleplay	= "Afficher le timer de la durée du roleplay"--This does need localizing though.

L.AUTO_ICONS_OPTION_TEXT			= "Placer des icônes sur les cibles de $spell:%s"
L.AUTO_ICONS_OPTION_TEXT2        = "Placer des icônes sur $spell:%s"
L.AUTO_ARROW_OPTION_TEXT         = "Afficher la flèche DBM en direction de la cible affectée par $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2        = "Afficher la flèche DBM pour s'éloigner de la cible affectée par $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3		= "Show DBM Arrow to move toward specific location for $spell:%s"

L.AUTO_YELL_OPTION_TEXT.yell		= "Crie quand vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.count	= "Crie (avec compte) quand vous êtes affecté par $spell:%s"
L.AUTO_YELL_OPTION_TEXT.fade		= "Crie (avec compte à rebours) lorsque $spell:%s se dissipe"
L.AUTO_YELL_OPTION_TEXT.position	= "Crie (avec position) quand vous êtes affecté par $spell:%s"

L.AUTO_YELL_ANNOUNCE_TEXT.yell		= "%s sur " .. UnitName("player") .. "!"
L.AUTO_YELL_ANNOUNCE_TEXT.count		= "%s sur " .. UnitName("player") .. "! (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade		= "%s disparaît dans %%d"
L.AUTO_YELL_ANNOUNCE_TEXT.position 	= "%s %%s sur {rt%%d}"..UnitName("player").."{rt%%d}"

L.AUTO_HUD_OPTION_TEXT			= "Afficher la map HUD pour $spell:%s"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "Afficher la map HUD pour diverses activités"
L.AUTO_RANGE_OPTION_TEXT         = "Afficher la fênetre des distances (%s) pour $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
L.AUTO_RANGE_OPTION_TEXT_SHORT   = "Afficher la fênetre des distances (%s)"--For when a range frame is just used for more than one thing
L.AUTO_RRANGE_OPTION_TEXT		= "Afficher la fênetre des distances inversée (%s) pour $spell:%s"--Reverse range frame (green when players in range, red when not)
L.AUTO_RRANGE_OPTION_TEXT_SHORT	= "Afficher la fênetre des distances inversée (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT    = "Afficher la fênetre d'information pour $spell:%s" --What frame is this?
L.AUTO_READY_CHECK_OPTION_TEXT   = "Jouer le son du ready check lorsque le boss est engagé (même si ce dernier n'est pas la cible)"

-- New special warnings
L.MOVE_SPECIAL_WARNING_BAR	= "Alerte spéciale mobile"
L.MOVE_WARNING_MESSAGE		= "Merci d'utiliser Deadly Boss Mods"
L.MOVE_SPECIAL_WARNING_BAR	= "Alertes spéciales mobiles"
L.MOVE_SPECIAL_WARNING_TEXT	= "Alerte spéciale"

L.HUD_INVALID_TYPE			= "Type de HUD défini invalide"
L.HUD_INVALID_TARGET			= "Pas de cible valide disponible pour le HUD"
L.HUD_INVALID_SELF			= "Impossible de s'utiliser soi-même comme cible pour le HUD"
L.HUD_INVALID_ICON			= "Impossible d'utiliser la méthode par icône pour le HUD sans cible avec l'icône"
L.HUD_SUCCESS				= "Le HUD a démarré correctement avec vos paramètres. Ceci va s'arrêter dans %s, ou en tapant '/dbm hud hide'."
L.HUD_USAGE	= {
	"Utilisation de DBM-HudMap:",
	"-----------------",
	"/dbm hud <type> <target> <duration>: Crée un HUD qui indique un joueur pour la durée choisie",
	"Valid types: flèche, rouge, bleu, vert, jaune, icône (requiert une cible avec une icône de raid)",
	"Valid targets: cible, focus, <nom du joueur>",
	"Valid durations: n'importe quel nombre (en secondes). Si laissé vide, il sera affiché pendant 20min.",
	"/dbm hud hide:  désactive et cache le HUD"
}

L.ARROW_MOVABLE					= "Flèche mobile"
L.ARROW_ERROR_USAGE	= {
	"Utilisation de DBM-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>:  crée une flèche qui pointe vers une position spécifique (0 < x/y < 100)",
	"/dbm arrow map <x> <y>: Crée une flèche qui pointe vers une position spécifique (en utilisant les coordonnées sur la carte)",
	"/dbm arrow <player>:  Crée une flèche qui pointe vers un joueur spécifique de votre groupe ou raid",
	"/dbm arrow hide:  Masque la flèche",
	"/dbm arrow move:  Rend la flèche mobile"
}

L.SPEED_KILL_TIMER_TEXT	= "Record à battre"
L.SPEED_CLEAR_TIMER_TEXT  = "Meilleur clean"
L.COMBAT_RES_TIMER_TEXT	= "Prochaine charge de rez en combat"
L.TIMER_RESPAWN		= "%s Réapparition"

L.REQ_INSTANCE_ID_PERMISSION		= "%s a demandé à voir vos IDs d'instance actuels ainsi que leurs progressions.\nSouhaitez-vous envoyer cette information à %s ? Il ou elle pourra demander cette information pendant toute votre session actuelle (c'est-à-dire jusqu'à ce que vous vous reconnectez)."
L.ERROR_NO_RAID					= "Vous devez être dans un groupe de raid pour utiliser cette fonctionnalité."
L.INSTANCE_INFO_REQUESTED			= "Requête envoyée pour obtenir les information de verrouillage de raid au groupe de raid.\nVeuillez noter que la permission sera demandée aux utilisateurs avant que les données ne vous soient envoyées, il se peut donc que cela prenne du temps pour recevoir toutes les réponses."
L.INSTANCE_INFO_STATUS_UPDATE		= "Réception des réponses de %d joueurs sur les %d utilisateurs de DBM : %d ont envoyé les données, %d ont refusé la requête. Attente des autres réponses pendant encore %d secondes..."
L.INSTANCE_INFO_ALL_RESPONSES		= "Réponses reçues de tous les membres du raid"
L.INSTANCE_INFO_DETAIL_DEBUG		= "Expéditeur: %s TypeRésultat: %s NomInstance: %s IDInstance: %s Difficulté: %d Taille: %d Progression: %s"
L.INSTANCE_INFO_DETAIL_HEADER		= "%s, difficulté %s :"
L.INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progression %d : %s"
L.INSTANCE_INFO_DETAIL_INSTANCE2	= "    progression %d : %s"
L.INSTANCE_INFO_NOLOCKOUT			= "Il n'y a pas d'info de verrouillage raid dans votre groupe."
L.INSTANCE_INFO_STATS_DENIED		= "A refusé la requête : %s"
L.INSTANCE_INFO_STATS_AWAY		= "Absent: %s"
L.INSTANCE_INFO_STATS_NO_RESPONSE	= "Sans une version récente de DBM: %s"
L.INSTANCE_INFO_RESULTS			= "Résultats de l'analyse des IDs d'instance. Notez que les instances peuvent apparaître plusieurs fois si les joueurs de votre raid ont WoW dans différentes langues."
L.INSTANCE_INFO_SHOW_RESULTS		= "Joueurs qui doivent encore répondre: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Afficher les résultats maintenant]|r|h"

L.LAG_CHECKING               = "Vérification de la latence du raid..."
L.LAG_HEADER                 = "Deadly Boss Mods - Résultats sur la latence"
L.LAG_ENTRY                  = "%s: délai monde [%d ms] / délai domicile [%d ms]"
L.LAG_FOOTER                 = "Pas de réponse: %s"
