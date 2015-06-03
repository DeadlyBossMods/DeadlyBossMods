if GetLocale() ~= "frFR" then return end
DBM_CORE_NEED_SUPPORT				= "Vous êtes bon en programmation ou en langues ? Si oui, l'équipe de DBM a besoin de votre aide pour que DBM reste le meilleur boss mod de WoW. Rejoignez l'équipe en visitant http://forums.elitistjerks.com/topic/132449-dbm-localizers-needed/"
DBM_HOW_TO_USE_MOD					= "Bienvenue sur DBM. Tapez /dbm help pour une liste des commandes supportées. Pour accédez aux options, tapez /dbm dans la fenêtre de discussion pour commencer la configuration. Chargez des zones spécifiques manuellement pour configurer tous les paramètres spécifiques aux boss selon vos envies. DBM essaie de le faire pour vous en analysant votre spécialisation au premier lancement, mais nous savons que de toute façon certaines personnes souhaitant activer d'autres options."

DBM_FORUMS_MESSAGE                                      = "Tu as remarqué un bug ou un timer mal réglé? Tu penses que certains combats ont besoin de plus d'alertes, timers ou autres fonctionnalités?\nVisite le nouveau sujet sur DBM, les rapports de bug et propositions sur le forum à l'adresse suivante: |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (you can click the link to copy the URL)"
DBM_FORUMS_COPY_URL_DIALOG                      = "Venez visiter nos nouveau forums de support et discussions\r\n(hosted by Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "Erreur lors du chargement des modules %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Modules '%s' chargés. Pour plus d'options, tapez /dbm ou /dbm help dans la fenêtre de discussion."
DBM_CORE_LOAD_MOD_COMBAT                        = "Chargement de '%s' reporté jusqu'à la fin du combat"
DBM_CORE_LOAD_GUI_ERROR				= "Impossible de charger l'interface: %s"
DBM_CORE_LOAD_GUI_COMBAT                        = "GUI ne peut pas se charger initialement en combat. GUI sera chargé après le combat. Une fois le GUI chargé, vous pourrez le charger en combat." --load?reload?change?
DBM_CORE_LOAD_SKIN_COMBAT                       = "Erreur du chargement des apparances des timers DBM du combat. Vos timers ne fonctionneront probablement pas correctement et vont générer des erreurs lua. Ceci est généralement causé par un add-on tiers essayant de modifier l'apparence des timers en cours de combat. Il est recommandé de recharger l'UI après le combat"
DBM_CORE_BAD_LOAD                                       = "DBM a détecté une erreur de chargement du mod de l'instance car vous êtes en combat. Dès que vous sortez de combat veuillez entrer /console reloadui le plus vite possible."
 
DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP       = "DBM a désactivé la vérification du nombre de joueurs à portée sur ce combat pour cause de manque d'information sur le nombre de joueurs requis regroupés pour votre taille de raid."
DBM_CORE_DYNAMIC_ADD_COUNT                      = "DBM a désactivé les alertes de décompte d'adds en vie sur ce combat pour cause de manque d'information du nombre d'adds apparaissant pour votre taille de raid."
DBM_CORE_DYNAMIC_MULTIPLE                       = "DBM a désactivé plusieurs fonctionnalités sur ce combat pour cause de manque d'informations sur certains mécanismes pour votre taille de raid  ."
 
DBM_CORE_LOOT_SPEC_REMINDER                     = "Votre spécialisation actuelle est %s. Votre choix de loot actuel est %s."
 
DBM_CORE_BIGWIGS_ICON_CONFLICT          = "DBM a détecté que vous avez activé vos icônes de raid sur DBM et Bigwigs simultanément. Désactivez les icônes de l'un d'entre-eux pour éviter tout conflit avec votre raid leader"

DBM_CORE_COMBAT_STARTED				= "%s engagé. Bonne chance et amusez-vous bien ! :)";
DBM_CORE_COMBAT_STARTED_IN_PROGRESS     = "Vous êtes engagé dans un combat en cours contre %s. Bonne chance et amusez-vous bien ! :)"
DBM_CORE_SCENARIO_STARTED                       = "%s a commencé. Bonne chance et amusez-vous bien ! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS   = "Vous avez rejoint %s déjà entamé. Bonne chance et amusez-vous bien ! :)"
DBM_CORE_BOSS_DOWN					= "%s vaincu après %s !"
DBM_CORE_BOSS_DOWN_I                            = "%s vaincu! Vous avez un total de %d victoires."
DBM_CORE_BOSS_DOWN_L				= "%s vaincu après %s ! Votre dernier temps était de %s et votre record de %s. Vous l'avez tué au total %d fois."
DBM_CORE_BOSS_DOWN_NR				= "%s vaincu après %s ! C'est un nouveau record ! (l'ancien record était de %s). Vous l'avez tué au total %d fois."
DBM_CORE_SCENARIO_COMPLETE                      = "%s terminé après %s!"
DBM_CORE_SCENARIO_COMPLETE_I            = "%s terminé! Vous l'avez terminé un total de %d fois."
DBM_CORE_SCENARIO_COMPLETE_L            = "%s terminé après %s! Votre dernier run vous a pris %s et votre run le plus rapide %s. Vous avez un total de  %d runs."
DBM_CORE_SCENARIO_COMPLETE_NR           = "%s terminé après %s! Ceci est un nouveau record! (Votre ancient record était de %s). Vous l'avez terminé un total de %d fois."
DBM_CORE_COMBAT_ENDED_AT			= "Combat face à %s (%s) terminé après %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Combat face à %s (%s) terminé après %s. Vous cumulez un total de %d wipes dans cette difficulté."
DBM_CORE_SCENARIO_ENDED_AT                      = "%s terminé après %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG         = "%s terminé après %s. Vous avez un total de %d wipes dans cette difficulté."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s a été engagé il y a %s, récupération des délais..."
DBM_CORE_TRANSCRIPTOR_LOG_START         = "Début du log de Transcriptor."
DBM_CORE_TRANSCRIPTOR_LOG_END           = "Fin du log de Transcriptor."

DBM_CORE_WORLDBOSS_ENGAGED                      = "%s a probablement été engagé sur votre royaume à %s de vie. (Envoyé par %s)"
DBM_CORE_WORLDBOSS_DEFEATED                     = "%s a probablement été tué sur votre royaume (Envoyé par %s)."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4seconde:secondes;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minute:minutes;"
DBM_CORE_TIMER_FORMAT				= "%d |4minute:minutes; et %d |4seconde:secondes;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "sec"
DBM_CORE_SEC_FMT					= "%s sec"

DBM_CORE_GENERIC_WARNING_OTHERS         = "et un autre"
DBM_CORE_GENERIC_WARNING_OTHERS2        = "et %d autres"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Enrage dans %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Enrage"
DBM_CORE_OPTION_TIMER_BERSERK		= "Montrer les chronos pour $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Le combat débute dans"
DBM_CORE_OPTION_TIMER_COMBAT		= "Montre le timer avant le début du combat"
DBM_CORE_OPTION_HEALTH_FRAME		= "Afficher le cadre de vie des Boss"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barres"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Avertissements"

DBM_CORE_AUTO_RESPONDED						= "Répondu automatiquement."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d joueurs en vie"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s est occupé à combattre %s (%s, %d/%d joueurs en vie)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s a vaincu %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s a vaincu %s! Celui-ci a été tué %d fois."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s a wipé sur %s à %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s a wipé sur %s à %s. Le groupe cumule %d wipes dans cette difficulté."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO          = "%s est occupé dans %s (%d/%d personnes en vie)"
DBM_CORE_WHISPER_SCENARIO_END_KILL                      = "%s vient de terminer %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS        = "%s vient de terminer %s! Ils ont un total de %d victoires."
DBM_CORE_WHISPER_SCENARIO_END_WIPE                      = "%s a échoué dans %s"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS        = "%s a échoué dans %s. Ils ont un total de %d échecs dans cette difficulté."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versions"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM non installé"--Two Boss mods
DBM_CORE_VERSIONCHECK_FOOTER		= "%d joueurs trouvés avec Deadly Boss Mods & %d joueurs avec BigWigs"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Votre version de Deadly Boss Mods est périmée. Veuillez vous rendre sur www.deadlybossmods.com pour obtenir la dernière version."

DBM_CORE_UPDATEREMINDER_HEADER		= "Votre version de Deadly Boss Mods est périmée.\nLa version %s (r%d) est disponible au téléchargement ici:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA    = "Votre version Alpha de DBM-alpha est périmée.\n Vous avez au moins %d versions de test de retard. Il est recommandé au utilisateurs d'utiliser la dernière version alpha ou la dernière version stable. Les versions alpha périmées peuvent mener à des fonctionnalités absentes ou cassées."
DBM_CORE_UPDATEREMINDER_FOOTER		= "Faites la combinaison " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " pour copier le lien de téléchargement dans votre presse-papier."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC  = "Faites la combinaison " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " pour copier le lien dans votre presse-papier."
DBM_CORE_UPDATEREMINDER_DISABLE                 = "ALERTE: Compte tenu que votre version DBM est fortement périmée (%d révisions), DBM a été désactivé jusqu'à ce que vous le mettiez à jour. Ceci, pour éviter que des versions incompatibles de DBM ne cause de mauvaises éxpériences de jeu pour vous et les membres du raid."
DBM_CORE_UPDATEREMINDER_HOTFIX                  = "Votre version de DBM contient des timers et alertes incorrects sur ce boss. Ceci a été corrigé dans la dernière version (ou alpha si la prochaine version n'est pas encore disponible)."
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= DBM_CORE_UPDATEREMINDER_HOTFIX--TEMP, FIX ME!

DBM_CORE_MOVABLE_BAR				= "Bougez-moi !"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h vous a envoyé un délai DBM: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Annuler ce délais]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorer les délais de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Voulez-vous réellement ignorer les délais DBM de %s durant cette session ?"
DBM_PIZZA_ERROR_USAGE				= "Utilisation: /dbm [broadcast] timer <durée> <texte>"

DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "MAJ+clic ou clic-droit pour déplacer\nAlt+MAJ+clic pour une saisie libre"

DBM_CORE_RANGECHECK_HEADER			= "Vérif. de portée (%d m)"
DBM_CORE_RANGECHECK_SETRANGE		= "Définir la portée"
DBM_CORE_RANGECHECK_SOUNDS			= "Sons"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Son quand un joueur est à portée"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Son quand plus d'un joueur est à portée"
DBM_CORE_RANGECHECK_SOUND_0			= "Aucun son"
DBM_CORE_RANGECHECK_SOUND_1			= "Son par défaut"
DBM_CORE_RANGECHECK_SOUND_2			= "Bip agaçant"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d m"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Cadres"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Afficher le cadre du radar"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Afficher le cadre textuel"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Afficher les deux cadres"
DBM_CORE_RANGERADAR_HEADER			= "Radar de portée (%d m)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d joueurs à portée"

DBM_CORE_INFOFRAME_SHOW_SELF		= "Toujours afficher votre puissance"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "Invitation RdG"

DBM_CORE_SLASHCMD_HELP				= {
	"Commandes slash disponibles :",
	"/dbm version : effectue une vérification des versions de tout le raid (alias : ver).",
--	"/dbm version2: Performs a raid-wide version check and whispers members who are out of date (alias: ver2).",
	"/dbm unlock : affiche une barre de délai déplaçable (alias : move).",
	"/dbm timer <x> <texte> : lance un délai DBM de <x> secondes ayant pour nom <texte>.",
	"/dbm broadcast timer <x> <texte> : diffuse un délai DBM de <x> secondes ayant pour nom <texte> au raid (nécessite d'être chef du raid ou assistant).",
	"/dbm break <min> : lance un délai de pause de <min> minutes. Donne à tous les membres du raid ayant DBM ce délai de pause (nécessite d'être chef du raid ou assistant).",
	"/dbm pull <sec> : lance un délai de pull de <sec> secondes. Donne à tous les membres du raid ayant DBM ce délai de pull (nécessite d'être chef du raid ou assistant).",
	"/dbm arrow : affiche la flèche DBM, voir /dbm arrow help pour les détails.",
	"/dbm lockout : demande aux membres du raid leurs verrouillages actuels d'instance de raid (aliases : lockouts, ids) (nécessite d'être chef du raid ou assistant).",
	"/dbm help : affiche ce message."
}

DBM_ERROR_NO_PERMISSION				= "Vous n'avez pas la permission requise pour faire cela."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Fermer le cadre des vies"

DBM_CORE_UNKNOWN					= "inconnu"
DBM_CORE_LEFT						= "Gauche"
DBM_CORE_RIGHT						= "Droite"
DBM_CORE_BACK						= "Derrière"
DBM_CORE_FRONT						= "Devant"--"En face"?/In front

DBM_CORE_BREAK_START				= "La pause commence maintenant -- vous avez %s minute(s)!"
DBM_CORE_BREAK_MIN					= "Fin de la pause dans %s minute(s) !"
DBM_CORE_BREAK_SEC					= "Fin de la pause dans %s secondes !"
DBM_CORE_TIMER_BREAK				= "Pause !"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "La pause est terminée"

DBM_CORE_TIMER_PULL					= "Pull dans"
DBM_CORE_ANNOUNCE_PULL				= "Pull dans %d sec"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull maintenant !"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Victoire rapide"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target		= "%s sur >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) sur >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell		= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends		= "%s s'est terminé"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget	= "%s s'est terminé: >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades		= "%s s'est dissipé"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds		= "%s restant: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast		= "Incantation %s: %.1f sec"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon		= "%s imminent"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarna	= "%s de %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase		= "Phase %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase	= "Phase %s imminente"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count		= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack		= "%s sur >%%s< (%%d)"

local prewarnOption = "Alerte préventive concernant $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Alerte indiquant le(s) cible(s) de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Alerte indiquant le(s) cible(s) de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Alerte concernant $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends            = "Affiche une alerte lorsque $spell:%s se termine"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget       = "Affiche une alerte lorsque $spell:%s se termine"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades           = "Affiche une alerte lorsque $spell:%s se dissipe"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds		= "Alerte indiquant le nombre restant de : $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast		= "Alerte lorsque $spell:%s est incanté"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "Alerte indiquant l'arrivée de la phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase	= "Alerte préventive indiquant l'arrivée de la phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Alerte concernant $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Alerte indiquant les cumuls de $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends            = "%s s'est terminé"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades           = "%s s'est dissipé"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon            = "%s bientôt"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn         = "%s dans %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel		= "%s on >%%s< - dissipez maintenant"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt		= "%s - interrompez >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount= "%s - interrompez >%%s<! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you             = "%s sur vous"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target		= "%s sur >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt           = "%s sur >%%s< - provoquez maintenant"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close		= "%s sur >%%s< près de vous"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move		= "%s - écartez-vous"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge 	= "%s - esquivez" --not sure in which case the message appears but this should work
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway      = "%s - écartez-vous du raid"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto        = "%s - dirigez-vous vers >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run			= "%s - fuyez"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast			= "%s - arrêtez d'incanter"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect       = "%s sur >%%s< - arrêtez d'attaquer"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count         = "%s! (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack			= "%s (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch		= ">%s< - Changer de cible"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount	= ">%s< - Changer de cible (%%d)"


-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Afficher une alerte spéciale pour $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends            = "Afficher une alerte spéciale lorsque $spell:%s se termine"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades           = "Afficher une alerte spéciale lorsque $spell:%s se dissipe"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon            = "Afficher une alerte préventive spéciale pour $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn         = "Afficher une alerte préventive spéciale %s seconds avant $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Afficher une alerte spéciale lorsque $spell:%s doit être dissipé/volé"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Afficher une alerte spéciale lorsque $spell:%s doit être interrompu"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Afficher une alerte spéciale lorsque vous subissez $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Afficher une alerte spéciale lorsque quelqu'un subit $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt           = "Afficher une alerte spéciale de provoquer lorsque l'autre tank subit $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Afficher une alerte spéciale lorsque quelqu'un proche de vous subit $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Afficher une alerte spéciale lorsque vous devez sortir de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 		= "Afficher une alerte spéciale lorqu'il faut esquiver $spell:%s" --not sure in which case the message appears but this should work
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway        = "Afficher une alerte spéciale lorsque vous subissez $spell:%s et devez vous écarter du raid"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto          = "Afficher une alerte spéciale lorsque vous devez vous rapprocher de quelqu'un subissant $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Afficher une alerte spéciale lorsque vous devez fuir $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Afficher une alerte spéciale d'interrompre l'incantation de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect         = "Afficher une alerte spéciale lorsqu'il faut arrêter d'attaquer pour $spell:%s"--Spell Reflect
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count           = "Afficher une alerte spéciale pour $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Afficher une alerte spéciale lorsque vous cumulez >=%d stacks de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch 		= "Afficher une alerte spéciale de changement de cible pour\n $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s se termine" --Buff/Debuff/event on boss,
DBM_CORE_AUTO_TIMER_TEXTS.fades		= "%s se dissipe" --Buff/Debuff on players,
DBM_CORE_AUTO_TIMER_TEXTS.cd		= "Rech. %s "
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "Rech. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource	= "Rech. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next		= "Proch. %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount	= "Proch. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Proch. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Durée d'affaiblissement de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Durée d'incantation de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Durée d'activité de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Délai avant la dissipation de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cd		= "Durée de recharge de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Durée de recharge de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Durée de recharge de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Délai avant le prochain $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Délai avant le prochain $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Délai avant le prochain $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Délai pour réussir %s"

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Placer des icônes sur les cibles de $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2                = "Placer des icônes sur $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT                 = "Afficher la flèche DBM en direction de la cible affectée par $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2                = "Afficher la flèche DBM pour s'éloigner de la cible affectée par $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "Jouer le son \"run away\" pour $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Compte à rebours sonore pour $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2		= "Compte à rebours sonore pour lorsque $spell:%s se dissipe"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Compte à rebours sonore pour la durée de $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "Cri quand vous subissez $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell		= "%s sur " .. UnitName("player") .. " !"
DBM_CORE_AUTO_RANGE_OPTION_TEXT                 = "Afficher la fênetre des distances (%s) pour $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT   = "Afficher la fênetre des distances (%s)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT    = "Afficher la fênetre d'information pour $spell:%s" --What frame is this?
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT   = "Jouer le son du ready check lorsque le boss est engagé (même si ce dernier n'est pas la cible)"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Alerte spéciale mobile"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Alerte spéciale"


DBM_ARROW_MOVABLE					= "Flèche mobile"
DBM_ARROW_ERROR_USAGE	= {
	"Utilisation de DBM-Arrow:",
	"/dbm arrow <x> <y>  créée une flèche qui pointe vers une position spécifique (0 < x/y < 100)",
	"/dbm arrow <player>  créée une flèche qui pointe vers un joueur spécifique de votre groupe ou raid",
	"/dbm arrow hide  masque la flèche",
	"/dbm arrow move  rend la flèche déplaçable"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Record à battre"
DBM_SPEED_CLEAR_TIMER_TEXT      = "Meilleur clean"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s a demandé à voir vos IDs d'instance actuels ainsi que leurs progressions.\nSouhaitez-vous envoyer cette information à %s ? Il ou elle pourra demander cette information pendant toute votre session actuelle (c'est-à-dire jusqu'à ce que vous vous reconnectez)."
DBM_ERROR_NO_RAID					= "Vous devez être dans un groupe de raid pour utiliser cette fonctionnalité."
DBM_INSTANCE_INFO_REQUESTED			= "Requête envoyée pour obtenir les information de verrouillage de raid au groupe de raid.\nVeuillez noter que la permission sera demandée aux utilisateurs avant que les données ne vous soient envoyées, il se peut donc que cela prenne du temps pour recevoir toutes les réponses."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Réception des réponses de %d joueurs sur les %d utilisateurs de DBM : %d ont envoyé les données, %d ont refusé la requête. Attente des autres réponses pendant encore %d secondes..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Réponses reçues de tous les membres du raid"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Expéditeur: %s TypeRésultat: %s NomInstance: %s IDInstance: %s Difficulté: %d Taille: %d Progression: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, difficulté %s :"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progression %d : %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    progression %d : %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "A refusé la requête : %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Absent: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Sans une version récente de DBM: %s"
DBM_INSTANCE_INFO_RESULTS			= "Résultats de l'analyse des IDs d'instance. Notez que les instances peuvent apparaître plusieurs fois si les joueurs de votre raid ont WoW dans différentes langues."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Joueurs qui doivent encore répondre: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Afficher les résultats maintenant]|r|h"

DBM_CORE_LAG_CHECKING                           = "Vérification de la latence du raid..."
DBM_CORE_LAG_HEADER                                     = "Deadly Boss Mods - Résultats sur la latence"
DBM_CORE_LAG_ENTRY                                      = "%s: délai monde [%d ms] / délai domicile [%d ms]"
DBM_CORE_LAG_FOOTER                                     = "Pas de réponse: %s"
