if GetLocale() ~= "frFR" then return end

DBM_CORE_LOAD_MOD_ERROR				= "Erreur durant le chargement du boss mod pour %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Boss mod pour '%s' chargé!"
DBM_CORE_LOAD_GUI_ERROR				= "Ne peut charger le GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s engagé. Bonne chance et amusez-vous bien ! :)";
DBM_CORE_BOSS_DOWN					= "%s est mort après %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s est mort après %s! Votre dernier down a durée %s et le plus rapide a duré %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s est mort après %s! C'est un nouveau record! (l'ancien record était de %s)"
DBM_CORE_COMBAT_ENDED				= "Combat contre %s terminé après %s."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4seconde:secondes;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minute:minutes;"
DBM_CORE_TIMER_FORMAT				= "%d |4minute:minutes; et %d |4seconde:secondes;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "sec"
DBM_CORE_SEC_FMT					= "%d sec"
DBM_CORE_DEAD						= "mort"
DBM_CORE_OK							= "Okay"

DBM_CORE_GENERIC_WARNING_BERSERK	= "Frénésie dans %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Frénésie"
DBM_CORE_OPTION_TIMER_BERSERK		= "Afficher le timer pour la Frénésie"
DBM_CORE_OPTION_HEALTH_FRAME		= "Afficher la fenêtre de vie du Boss"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Barres"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Annonces"
DBM_CORE_OPTION_CATEGORY_MISC		= "Divers"

DBM_CORE_AUTO_RESPONDED				= "Réponse automatique."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d personnes en vie"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s est occupé(e) à combattre contre %s (%s, %d/%d personnes en vie)"
DBM_CORE_WHISPER_COMBAT_END_KILL	= "%s a vaincu %s !"
DBM_CORE_WHISPER_COMBAT_END_WIPE	= "%s a wip sur %s"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versions"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM non installé"
DBM_CORE_VERSIONCHECK_FOOTER		= "a trouvé %d joueurs avec Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Votre version de Deadly Boss Mods est périmé! Merci de visiter www.deadlybossmods.com pour avoir la dernière version."
DBM_CORE_DISABLED_ICON_FUNCTION		= "Votre version ne peut pas mettre les icones, car votre version est périmé. Merci de la mettre a jour dès que possible et réactiver la fonction icone."

DBM_CORE_UPDATEREMINDER_HEADER		= "Votre version de Deadly Boss Mods est périmée.\n Version %s (r%d) disponible ici:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Faites Ctrl-C pour copier le lien votre presse-papier."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Montre une annonce quand une nouvelle version de DBM est disponible."

DBM_CORE_MOVABLE_BAR				= "Déplace-moi!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h vous envoie un timer pizza: '%2$s'\n|HDBM:annuler:%2$s:nil|h|cff3588ff[Annuler ce timer]|r|h  |HDBM:ignorer:%2$s:%1$s|h|cff3588ff[Ignorer les timers de %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Voulez vous vraiment ignorer les timers pizza de %s pour cette session?"
DBM_PIZZA_ERROR_USAGE				= "Usage: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods est lancé en double car vous avez DBMv3 et DBMv4 d'installé et d'activé!\nCliquez sur \"Okay\" pour désactiver DBMv3 et recharger votre interfarce.\nVous pouvez aussi nettoyer votre fichier AddOns en supprimant l'ancien fichier DBMv3."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+clic ou clic droit pour déplacer\nAlt+shift+click pour drag&drop librement"

DBM_CORE_RANGECHECK_HEADER			= "Vérifie la portée (%d m)"
DBM_CORE_RANGECHECK_SETRANGE		= "Définir la portée"
DBM_CORE_RANGECHECK_SOUNDS			= "Sons"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Joue un son quand un joueur est dans la zone"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Joue un autre son quand plus d'un joueur sont dans la zone"
DBM_CORE_RANGECHECK_SOUND_0			= "Pas de son"
DBM_CORE_RANGECHECK_SOUND_1			= "Son par défaut"
DBM_CORE_RANGECHECK_SOUND_2			= "Son Ennuyeux"
DBM_CORE_RANGECHECK_HIDE			= "Cacher"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d m"
DBM_CORE_RANGECHECK_LOCK			= "Verrouiller la fenêtre"

DBM_LFG_INVITE						= "LFG Invite"

DBM_CORE_SLASHCMD_HELP				= {
	"Commandes slash disponible:",
	"/dbm version: Vérifie la version du raid (alias: ver)",
	"/dbm unlock: Affiche un Timer Status déplacable (alias: move)",
	"/dbm timer <x> <text>: Commence un <x> second Timer Pizza avec le nom <text>",
	"/dbm broadcast timer <x> <text>: Diffuse un Timer Pizza de <x> secondes avec le nom <text> au raid (Nécessite d'être promu ou leader)",
	"/dbm break <min>: Démarre un timer de pause pour <min> minutes. Envoie à tous les membres du raid avec DBM ce timer de pause (Nécessite d'être promu ou leader).",
	"/dbm help: Affiche l'aide",
}

DBM_ERROR_NO_PERMISSION				= "Vous n'avez pas les permissions requises pour faire ceci."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Cacher"

DBM_CORE_ALLIANCE					= "Alliance"
DBM_CORE_HORDE						= "Horde"

DBM_CORE_UNKNOWN					= "Inconnu"

DBM_CORE_BREAK_START				= "La pause démarre maintenant -- vous avez %s minute(s)!"
DBM_CORE_BREAK_MIN					= "La pause finit dans %s minutes!"
DBM_CORE_BREAK_SEC					= "La pause finit dans %s secondes!"
DBM_CORE_TIMER_BREAK				= "Break time!"-----
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Break time is over"-----

DBM_CORE_TIMER_PULL					= "Pull dans"
DBM_CORE_ANNOUNCE_PULL				= "Pull dans %d sec"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull maintenant!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Speed Kill"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target = "%s: %%s",
	cast = "%s",
	active = "%s",
	cd = "CD de: %s",
	next = "Prochain(e) %s",
	achievement = "%s",
	combatstart = "Le combat commence",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target 		= "Afficher le temps du debuff pour: |cff71d5ff|Hspell:%d|h%s|h|r",
	cast 		= "Afficher la barre d'incantation pour: |cff71d5ff|Hspell:%d|h%s|h|r",
	active 		= "Afficher le timer pour la fin de: |cff71d5ff|Hspell:%d|h%s|h|r",
	cd 			= "Afficher le cooldown pour: |cff71d5ff|Hspell:%d|h%s|h|r",
	next 		= "Afficher le timer pour le prochain: |cff71d5ff|Hspell:%d|h%s|h|r",
	achievement = "Montre le timer pour %s",
	combatstart = "Montre le timer pour le début du combat",
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target		= "%s sur >%%s<",
	spell		= "%s",
	cast		= "Cast %s: %.1f sec",
	soon		= "%s bientôt",
	prewarn		= "%s dans %s",
	phase		= "Phase %d",
}

local prewarnOption = "Montre une pré-alerte pour |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target	= "Annonce la cible de |cff71d5ff|Hspell:%d|h%s|h|r",
	spell	= "Montre une alerte pour |cff71d5ff|Hspell:%d|h%s|h|r",
	cast	= "Montre une alerte quand |cff71d5ff|Hspell:%d|h%s|h|r est en cours de cast",
	soon	= "Montre une alerte avant |cff71d5ff|Hspell:%d|h%s|h|r",
	prewarn	= "Montre une alerte avant |cff71d5ff|Hspell:%d|h%s|h|r",
	phase	= "Montre une alerte pour la phase %d",
}

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell 		= "Afficher l’alerte spéciale pour $spell:%d",
	dispel 		= "Afficher l’alerte spéciale à dispel/spellsteal \n $spell:%d",
	interupt	= "Afficher l’alerte spéciale interrompre $spell:%d",
	you 		= "Afficher l’alerte spéciale lorsque vous êtes affecté par $spell:%d",
	target 		= "Afficher l’alerte spéciale quand quelqu'un est touché par $spell:%d",
	close 		= "Afficher l’alerte spéciale quand quelqu'un est proche de vous \n affected by $spell:%d",
	move 		= "Afficher l’alerte spéciale lorsque vous êtes affecté par $spell:%d",
	run 		= "Afficher l’alerte spéciale pour $spell:%d",
	cast 		= "Afficher l’alerte spéciale pour $spell:%d cast",
	stack 		= "Afficher l’alerte spéciale pour >=%d des piles de \n $spell:%d"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell = "%s!",
	dispel = "%s on %%s - dispel maintenant",
	interupt = "%s - interrompre maintenant",
	you = "%s sur toi",
	target = "%s sur %%s",
	close = "%s sur %%s près de vous",
	move = "%s - bouge vite",
	run = "%s - éloigne toi",
	cast = "%s - stop cast",
	stack = "%s (%%d)"
}


DBM_CORE_AUTO_ICONS_OPTION_TEXT		= "Set d'icônes sur $spell:%d en targets"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "jouer un son sur $spell:%d"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Alerte spéciale déplaçable"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Alerte spéciale"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "Une %d vérification de distance n'est pas supporté dans cette zone.\nLes distances autorisés est 10, 11, 15 et 28 yard."

DBM_ARROW_MOVABLE					= "Bouger la Flèche"

DBM_ARROW_ERROR_USAGE	= {
	"DBM-flèche usage:",
	"/dbm flèche <x> <y> crée une flèche qui pointe vers une locataion spécifiques (0 < x/y < 100)",
	"/dbm flèche <player> crée une flèche qui pointe vers un joueur précis dans votre groupe ou raid",
	"/dbm flèche cache la flèche",
	"/dbm flèche fait déplacer",
}
