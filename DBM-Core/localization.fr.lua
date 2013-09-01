if GetLocale() ~= "frFR" then return end
DBM_CORE_NEED_SUPPORT				= "Vous êtes bon en programmation ou en langues ? Si oui, l'équipe de DBM a besoin de votre aide pour que DBM reste le meilleur boss mod de WoW. Rejoignez l'équipe en visitant www.deadlybossmods.com ou en envoyant un message à tandanu@deadlybossmods.com ou à nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Bienvenue sur DBM. Tapez /dbm help pour une liste des commandes supportées. Pour accédez aux options, tapez /dbm dans la fenêtre de discussion pour commencer la configuration. Chargez des zones spécifiques manuellement pour configurer tous les paramètres spécifiques aux boss selon vos envies. DBM essaie de le faire pour vous en analysant votre spécialisation au premier lancement, mais nous savons que de toute façon certaines personnes souhaitent activer d'autres options."

DBM_CORE_LOAD_MOD_ERROR				= "Erreur lors du chargement des modules %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Modules '%s' chargés. Pour plus d'options, tapez /dbm ou /dbm help dans la fenêtre de discussion."
DBM_CORE_LOAD_GUI_ERROR				= "Impossible de charger l'interface: %s"

DBM_CORE_COMBAT_STARTED				= "%s engagé. Bonne chance et amusez-vous bien ! :)";
DBM_CORE_BOSS_DOWN					= "%s vaincu après %s !"
DBM_CORE_BOSS_DOWN_L				= "%s vaincu après %s ! Votre dernier temps était de %s et votre record de %s. Vous l'avez tué au total %d fois."
DBM_CORE_BOSS_DOWN_NR				= "%s vaincu après %s ! C'est un nouveau record ! (l'ancien record était de %s). Vous l'avez tué au total %d fois."

DBM_CORE_COMBAT_ENDED_AT			= "Combat face à %s (%s) terminé après %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Combat face à %s (%s) terminé après %s. Vous cumulez un total de %d wipes dans ce mode de difficulté."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s a été engagé il y a %s, récupération des délais..."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4seconde:secondes;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minute:minutes;"
DBM_CORE_TIMER_FORMAT				= "%d |4minute:minutes; et %d |4seconde:secondes;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "sec"
DBM_CORE_SEC_FMT					= "%d sec"
DBM_CORE_DEAD						= "mort"
DBM_CORE_OK							= "Okay"

DBM_CORE_GENERIC_WARNING_BERSERK	= "Enrage dans %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Enrage"
DBM_CORE_OPTION_TIMER_BERSERK		= "Montrer les chronos pour $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Le combat débute dans"
DBM_CORE_OPTION_TIMER_COMBAT		= "Montre le timer avant le début du combat"
DBM_CORE_OPTION_HEALTH_FRAME		= "Afficher le cadre de vie des Boss"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Bars"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Announces"
DBM_CORE_OPTION_CATEGORY_MISC		= "Divers"

DBM_CORE_AUTO_RESPONDED						= "Répondu automatiquement."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d joueurs en vie"
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s est occupé à combattre %s (%s, %d/%d joueurs en vie)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s a vaincu %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s a vaincu %s! Celui-ci a été tué %d fois."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s a wipé sur %s à %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s a wipé sur %s à %s. Le groupe cumule %d wipes dans cette difficulté."

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versions"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM non installé"
DBM_CORE_VERSIONCHECK_FOOTER		= "%d joueurs trouvés avec Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Votre version de Deadly Boss Mods est périmée. Veuillez vous rendre sur www.deadlybossmods.com pour obtenir la dernière version."

DBM_CORE_UPDATEREMINDER_HEADER		= "Votre version de Deadly Boss Mods est périmée.\nLa version %s (r%d) est disponible au téléchargement ici:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Faites la combinaison " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " pour copier le lien de téléchargement dans votre presse-papier."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Afficher un popup quand une nouvelle version est disponible"

DBM_CORE_MOVABLE_BAR				= "Bougez-moi !"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h vous a envoyé un délai DBM: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Annuler ce délais]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignorer les délais de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Voulez-vous réellement ignorer les délais DBM de %s de cette session ?"
DBM_PIZZA_ERROR_USAGE				= "Utilisation: /dbm [broadcast] timer <durée> <texte>"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "MAJ+clic ou clic-droit pour déplacer\nAlt+MAJ+clic pour une saisie libre"

DBM_CORE_RANGECHECK_HEADER			= "Vérif. de portée (%d m)"
DBM_CORE_RANGECHECK_SETRANGE		= "Définir la portée"
DBM_CORE_RANGECHECK_SOUNDS			= "Sons"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Son quand un joueur est à portée"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Son quand plus d'un joueur est à portée"
DBM_CORE_RANGECHECK_SOUND_0			= "Aucun son"
DBM_CORE_RANGECHECK_SOUND_1			= "Son par défaut"
DBM_CORE_RANGECHECK_SOUND_2			= "Bip agaçant"
DBM_CORE_RANGECHECK_HIDE			= "Cacher"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d m"
DBM_CORE_RANGECHECK_LOCK			= "Verrouiller le cadre"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Cadres"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Afficher le cadre du radar"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Afficher le cadre textuel"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Afficher les deux cadres"
DBM_CORE_RANGECHECK_OPTION_SPEED	= "Fréquence de MAJ (Rechar. requis)"
DBM_CORE_RANGECHECK_OPTION_SLOW		= "Lente (faible utilisation du CPU)"
DBM_CORE_RANGECHECK_OPTION_AVERAGE	= "Moyenne"
DBM_CORE_RANGECHECK_OPTION_FAST		= "Rapide (plus proche du temps réel)"
DBM_CORE_RANGERADAR_HEADER			= "Radar de portée (%d m)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d joueurs à portée"

DBM_CORE_INFOFRAME_LOCK				= "Verrouiller le cadre"
DBM_CORE_INFOFRAME_HIDE				= "Masquer"
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
	"/dbm help : affiche ce message.",
}

DBM_ERROR_NO_PERMISSION				= "Vous n'avez pas la permission requise pour faire cela."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Fermer le cadre des vies"

DBM_CORE_ALLIANCE					= "Alliance"
DBM_CORE_HORDE						= "Horde"

DBM_CORE_UNKNOWN					= "inconnu"
DBM_CORE_LEFT						= "Gauche"
DBM_CORE_RIGHT						= "Droite"
DBM_CORE_BACK						= "Back"--Translate
DBM_CORE_FRONT						= "Front"--Translate

DBM_CORE_BREAK_START				= "La pause commence maintenant -- vous avez %s minute(s)!"
DBM_CORE_BREAK_MIN					= "Fin de la pause dans %s minute(s) !"
DBM_CORE_BREAK_SEC					= "Fin de la pause dans %s secondes !"
DBM_CORE_TIMER_BREAK				= "Pause !"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "La pause est terminée"

DBM_CORE_TIMER_PULL					= "Pull dans"
DBM_CORE_ANNOUNCE_PULL				= "Pull dans %d sec"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull maintenant !"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Victoire rapide"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s se termine" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s se dissipe" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "Rech. %s "
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "Rech. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "Rech. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next			= "Proch. %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "Proch. %s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "Proch. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "Durée d'affaiblissement de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "Durée d'incantation de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "Durée d'activité de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Délai avant la dissipation de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "Durée de recharge de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "Durée de recharge de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Durée de recharge de $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "Délai avant le prochain $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "Délai avant le prochain $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Délai avant le prochain $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "Délai pour réussir %s"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target			= "%s sur >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d) sur >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "%s restant: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast			= "Incantation %s: %.1f sec"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon			= "%s imminent"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarna		= "%s de %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase			= "Phase %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase		= "Phase %s imminente"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack			= "%s sur >%%s< (%%d)"

local prewarnOption = "Alerte préventive concernant $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "Alerte indiquant le(s) cible(s) de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Alerte indiquant le(s) cible(s) de $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "Alerte concernant $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Alerte indiquant le nombre restant de : $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast			= "Alerte quand $spell:%s est incanté"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "Alerte indiquant l'arrivée de la phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase		= "Alerte préventive indiquant l'arrivée de la phase %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "Alerte concernant $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "Alerte indiquant les cumuls de $spell:%s"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 		= "Alerte spéciale concernant $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 		= "Alerte spéciale quand $spell:%s doit être dissipé/volé"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "Alerte spéciale quand $spell:%s doit être interrompu"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 		= "Alerte spéciale quand vous subissez $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 		= "Alerte spéciale quand quelqu'un subit $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 		= "Alerte spéciale quand quelqu'un proche de vous subit $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 		= "Alerte spéciale quand vous subissez $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 		= "Alerte spéciale concernant $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 		= "Alerte spéciale quand $spell:%s est incanté"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 		= "Alerte spéciale quand >=%d cumuls de $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch 		= "Alerte spéciale de changement de cible pour\n $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel	= "%s on >%%s< - dissipez maintenant"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt = "%s - interrompez >%%s<!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you		= "%s sur vous"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target	= "%s sur >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close		= "%s sur >%%s< près de vous"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move		= "%s - écartez-vous"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run		= "%s - fuyez"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast		= "%s - arrêtez d'incanter"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack		= "%s (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch	= ">%s< - Changer de cible"


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Icônes sur les cibles de $spell:%s"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "Jouer le son \"run away\" pour $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Compte à rebours sonore pour $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Compte à rebours sonore pour ka durée de $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "Cri quand vous subissez $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "%s sur " .. UnitName("player") .. " !"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Alerte spéciale mobile"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Alerte spéciale"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "Une vérification de portée de %d mètres n'est pas supportée dans cette zone.\nLes portées supportées sont de 10, 11, 15 et 28 mètres."

DBM_ARROW_MOVABLE					= "Flèche mobile"
DBM_ARROW_NO_RAIDGROUP				= "Cette fonction n'est disponible que dans les groupes de raid et dans les instances de raid."
DBM_ARROW_ERROR_USAGE	= {
	"Utilisation de DBM-Arrow:",
	"/dbm arrow <x> <y>  créée une flèche qui pointe vers une position spécifique (0 < x/y < 100)",
	"/dbm arrow <player>  créée une flèche qui pointe vers un joueur spécifique de votre groupe ou raid",
	"/dbm arrow hide  masque la flèche",
	"/dbm arrow move  rend la flèche déplaçable",
}

DBM_SPEED_KILL_TIMER_TEXT	= "Record à battre"
DBM_SPEED_KILL_TIMER_OPTION	= "Délai pour battre votre record"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s a demandé à voir vos IDs d'instance actuels ainsi que leurs progressions.\nSouhaitez-vous envoyer cette information à %s ? Il ou elle pourra demander cette information pendant toute votre session actuelle (c'est-à-dire jusqu'à ce que vous vous reconnectez)."
DBM_ERROR_NO_RAID					= "Vous devez être dans un groupe de raid pour utiliser cette fonctionnalité."
DBM_INSTANCE_INFO_REQUESTED			= "Requête envoyée pour obtenir les information de verrouillage de raid au groupe de raid.\nVeuillez noter que la permission sera demandée aux utilisateurs avant que les données ne vous soient envoyées ; il se peut donc que cela prenne du temps pour recevoir toutes les réponses."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Réception des réponses de %d joueurs sur les %d utilisateurs de DBM : %d ont envoyé les données, %d ont refusé la requête. Attente des autres réponses pendant encore %d secondes..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Réponses reçues de tous les membres du raid"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Expéditeur: %s TypeRésultat: %s NomInstance: %s IDInstance: %s Difficulté: %d Taille: %d Progression: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s (%d), difficulté %d :"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progression %d : %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "A refusé la requête : %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Absent: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Sans une version récente de DBM: %s"
DBM_INSTANCE_INFO_RESULTS			= "Résultats de l'analyse des IDs d'instance. Notez que les instances peuvent apparaître plusieurs fois si les joueurs de votre raid ont WoW dans différentes langues."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Joueurs qui doivent encore répondre: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Afficher les résultats maintenant]|r|h"
