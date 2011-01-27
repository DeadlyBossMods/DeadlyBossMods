
DBM_CORE_NEED_SUPPORT				= "Are you good with programming or languages? If yes, the DBM team needs your help to keep DBM the best boss mod for WoW. Join the team by visiting www.deadlybossmods.com or sending a message to tandanu@deadlybossmods.com or nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Welcome to DBM. To access options type /dbm in your chat to begin configuration. Load specific zones manually to configure any boss specific settings to your liking as well. DBM tries to do this for you by scanning your spec on first run, but some might want additional options turned on anyways."

DBM_CORE_LOAD_MOD_ERROR				= "Error while loading boss mods for %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Loaded '%s' boss mods. For more options, type /dbm in your chat."
DBM_CORE_LOAD_GUI_ERROR				= "Could not load GUI: %s"

DBM_CORE_COMBAT_STARTED				= "%s engaged. Good luck and have fun! :)";
DBM_CORE_BOSS_DOWN					= "%s down after %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s down after %s! Your last kill took %s and your fastest kill took %s."
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s down after %s! This is a new record! (Old record was %s)"
DBM_CORE_COMBAT_ENDED				= "Combat against %s ended after %s."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4second:seconds;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minute:minutes;"
DBM_CORE_TIMER_FORMAT				= "%d |4minute:minutes; and %d |4second:seconds;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "sec"
DBM_CORE_SEC_FMT					= "%d sec"
DBM_CORE_DEAD						= "dead"
DBM_CORE_OK							= "Okay"

DBM_CORE_GENERIC_WARNING_BERSERK	= "Berserk in %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Berserk"
DBM_CORE_OPTION_TIMER_BERSERK		= "Show timer for $spell:26662"
DBM_CORE_OPTION_HEALTH_FRAME		= "Show boss health frame"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Bars"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Announces"
DBM_CORE_OPTION_CATEGORY_MISC		= "Miscellaneous"

DBM_CORE_AUTO_RESPONDED				= "Auto-responded."
DBM_CORE_STATUS_WHISPER				= "%s: %s, %d/%d people alive"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s is busy fighting against %s (%s, %d/%d people alive)"
DBM_CORE_WHISPER_COMBAT_END_KILL	= "%s has defeated %s!"
DBM_CORE_WHISPER_COMBAT_END_WIPE	= "%s has wiped on %s"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - Versions"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: DBM not installed"
DBM_CORE_VERSIONCHECK_FOOTER		= "Found %d players with Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Your version of Deadly Boss Mods is out-of-date. Please visit www.deadlybossmods.com to get the latest version."

DBM_CORE_UPDATEREMINDER_HEADER		= "Your version of Deadly Boss Mods is out-of-date.\n Version %s (r%d) is available for download here:"
DBM_CORE_UPDATEREMINDER_FOOTER		= "Press Ctrl-C to copy the download link to your clipboard."
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "Show popup when a new version is available"

DBM_CORE_MOVABLE_BAR				= "Drag me!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h sent you a DBM timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancel this timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignore timers from %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Do you really want to ignore DBM timers from %s for this session?"
DBM_PIZZA_ERROR_USAGE				= "Usage: /dbm [broadcast] timer <time> <text>"

DBM_CORE_ERROR_DBMV3_LOADED			= "Deadly Boss Mods is running twice because you have DBMv3 and DBMv4 installed and enabled!\nClick \"Okay\" to disable DBMv3 and reload your interface.\nYou should also clean up your AddOns folder by deleting the old DBMv3 folders."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+click or right-click to move\nAlt+shift+click for free drag and drop"

DBM_CORE_RANGECHECK_HEADER			= "Range Check (%d yd)"
DBM_CORE_RANGECHECK_SETRANGE		= "Set range"
DBM_CORE_RANGECHECK_SOUNDS			= "Sounds"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Sound when one player is in range"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Sound when more than one player is in range"
DBM_CORE_RANGECHECK_SOUND_0			= "No sound"
DBM_CORE_RANGECHECK_SOUND_1			= "Default sound"
DBM_CORE_RANGECHECK_SOUND_2			= "Annoying beep"
DBM_CORE_RANGECHECK_HIDE			= "Hide"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d yd"
DBM_CORE_RANGECHECK_LOCK			= "Lock frame"

DBM_CORE_INFOFRAME_LOCK				= "Lock frame"
DBM_CORE_INFOFRAME_HIDE				= "Hide"

DBM_LFG_INVITE						= "LFG Invite"

DBM_CORE_SLASHCMD_HELP				= {
	"Available slash commands:",
	"/dbm version: Performs a raid-wide version check (alias: ver).",
	"/dbm version2: Performs a raid-wide version check and whispers members who are out of date (alias: ver2).",
	"/dbm unlock: Shows a movable status bar timer (alias: move).",
	"/dbm timer <x> <text>: Starts a <x> second DBM Timer with the name <text>.",
	"/dbm broadcast timer <x> <text>: Broadcasts a <x> second DBM Timer with the name <text> to the raid (requires leader/promoted status).",
	"/dbm break <min>: Starts a break timer for <min> minutes. Gives all raid members with DBM a break timer (requires leader/promoted status).",
	"/dbm pull <sec>: Starts a pull timer for <sec> seconds. Gives all raid members with DBM a pull timer (requires leader/promoted status).",
	"/dbm help: Shows slash command descriptions",
}

DBM_ERROR_NO_PERMISSION				= "You don't have the required permission to do this."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Close health frame"

DBM_CORE_ALLIANCE					= "Alliance"
DBM_CORE_HORDE						= "Horde"

DBM_CORE_UNKNOWN					= "unknown"

DBM_CORE_BREAK_START				= "Break starting now -- you have %s minute(s)!"
DBM_CORE_BREAK_MIN					= "Break ends in %s minute(s)!"
DBM_CORE_BREAK_SEC					= "Break ends in %s seconds!"
DBM_CORE_TIMER_BREAK				= "Break time!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Break time is over"

DBM_CORE_TIMER_PULL					= "Pull in"
DBM_CORE_ANNOUNCE_PULL				= "Pull in %d sec"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull now!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Speed Kill"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target = "%s: %%s",
	cast = "%s",
	active = "%s",
	cd = "%s CD",
	next = "Next %s",
	achievement = "%s",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target = "Show timer for |cff71d5ff|Hspell:%d|h%s|h|r debuff",
	cast = "Show timer for |cff71d5ff|Hspell:%d|h%s|h|r cast",
	active = "Show timer for |cff71d5ff|Hspell:%d|h%s|h|r duration",
	cd = "Show timer for |cff71d5ff|Hspell:%d|h%s|h|r cooldown",
	next = "Show timer for next |cff71d5ff|Hspell:%d|h%s|h|r",
	achievement = "Show timer for %s",
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target = "%s on >%%s<",
	spell = "%s",
	cast = "Casting %s: %.1f sec",
	soon = "%s soon",
	prewarn = "%s in %s",
	phase = "Phase %d",
}

local prewarnOption = "Show pre-warning for |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target = "Announce |cff71d5ff|Hspell:%d|h%s|h|r targets",
	spell = "Show warning for |cff71d5ff|Hspell:%d|h%s|h|r",
	cast = "Show warning when |cff71d5ff|Hspell:%d|h%s|h|r is being cast",
	soon = prewarnOption,
	prewarn = prewarnOption,
	phase = "Announce Phase %d"
}


-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell 		= "Show special warning for $spell:%d",
	dispel 		= "Show special warning to dispel/spellsteal \n $spell:%d",
	interrupt	= "Show special warning to interrupt $spell:%d",
	you 		= "Show special warning when you are affected by \n $spell:%d",
	target 		= "Show special warning when someone is affected by \n $spell:%d",
	close 		= "Show special warning when someone close to you is \n affected by $spell:%d",
	move 		= "Show special warning when you are affected by \n $spell:%d",
	run 		= "Show special warning for $spell:%d",
	cast 		= "Show special warning for $spell:%d cast",
	stack 		= "Show special warning for >=%d stacks of \n $spell:%d"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell = "%s!",
	dispel = "%s on %%s - dispel now",
	interrupt = "%s - interrupt now",
	you = "%s on you",
	target = "%s on %%s",
	close = "%s on %%s near you",
	move = "%s - move away",
	run = "%s - run away",
	cast = "%s - stop casting",
	stack = "%s (%%d)"
}


DBM_CORE_AUTO_ICONS_OPTION_TEXT		= "Set icons on $spell:%d targets"
DBM_CORE_AUTO_SOUND_OPTION_TEXT		= "Play sound on $spell:%d"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Special warning movable"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Special Warning"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "A %d yard range check is not supported in this zone.\nSupported ranges are 10, 11, 15 and 28 yard."

DBM_ARROW_MOVABLE					= "Arrow movable"
DBM_ARROW_NO_RAIDGROUP				= "This function only works in raid groups and within raid instances."
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow usage:",
	"/dbm arrow <x> <y>  creates an arrow that points to a specific locataion (0 < x/y < 100)",
	"/dbm arrow <player>  creates and arrow that points to a specific player in your party or raid",
	"/dbm arrow hide  hides the arrow",
	"/dbm arrow move  makes the arrow movable",
}

DBM_SPEED_KILL_TIMER_TEXT	= "Record Kill"
DBM_SPEED_KILL_TIMER_OPTION	= "Show a timer to beat your fastest kill"