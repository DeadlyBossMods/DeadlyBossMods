
DBM_CORE_NEED_SUPPORT				= "Are you good with programming or languages? If yes, the DBM team needs your help to keep DBM the best boss mod for WoW. Join the team by visiting www.deadlybossmods.com or sending a message to tandanu@deadlybossmods.com or nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Welcome to DBM. Type /dbm help for a list of supported commands. To access options type /dbm in your chat to begin configuration. Load specific zones manually to configure any boss specific settings to your liking as well. DBM tries to do this for you by scanning your spec on first run, but some might want additional options turned on anyways."

DBM_FORUMS_MESSAGE					= "Found a bug or wrong timer? Do you think some mod would need an additional warning, timer or special feature?\nVisit the new Deadly Boss Mods discussion, bug report and feature request forums at |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (you can click the link to copy the URL)"
DBM_FORUMS_COPY_URL_DIALOG			= "Come visit our new discussion and support forums\r\n(hosted by Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "Error while loading boss mods for %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Loaded '%s' mods. For more options, type /dbm or /dbm help in your chat."
DBM_CORE_LOAD_MOD_COMBAT			= "Loading of '%s' delayed until you leave combat"
DBM_CORE_LOAD_GUI_ERROR				= "Could not load GUI: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "GUI cannot be initially loaded in combat. GUI will be loaded out of combat. After GUI loaded, you can load GUI in combat."
DBM_CORE_BAD_LOAD					= "DBM has detected your mod for this instance failed to fully load correctly because of combat. As soon as you are out of combat, please do /console reloadui as soon as possible."

DBM_CORE_LOOT_SPEC_REMINDER			= "Your current spec is %s. Your current loot choice is %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM has detected that you have raid icons turned on in both BigWigs and DBM. Please disable icons in one of them to avoid conflict with your group leader"

DBM_CORE_COMBAT_STARTED				= "%s engaged. Good luck and have fun! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "Engaged an in progress fight against %s. Good luck and have fun! :)"
DBM_CORE_SCENARIO_STARTED			= "%s started. Good luck and have fun! :)"
DBM_CORE_BOSS_DOWN					= "%s down after %s!"
DBM_CORE_BOSS_DOWN_I				= "%s down! You have %d total victories."
DBM_CORE_BOSS_DOWN_L				= "%s down after %s! Your last kill took %s and your fastest kill took %s. You have %d total victories."
DBM_CORE_BOSS_DOWN_NR				= "%s down after %s! This is a new record! (Old record was %s). You have %d total victories."
DBM_CORE_SCENARIO_COMPLETE			= "%s completed after %s!"
DBM_CORE_SCENARIO_COMPLETE_L		= "%s completed after %s! Your last clear took %s and your fastest clear took %s. You have %d total clears."
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s completed after %s! This is a new record! (Old record was %s). You have %d total clears."
DBM_CORE_COMBAT_ENDED_AT			= "Combat against %s (%s) ended after %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Combat against %s (%s) ended after %s. You have %d total wipes on this difficulty."
DBM_CORE_SCENARIO_ENDED_AT			= "%s ended after %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s ended after %s. You have %d total incompletes on this difficulty."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s was engaged %s ago, recovering timers..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Transcriptor logging started."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Transcriptor logging ended."

DBM_CORE_TIMER_FORMAT_SECS			= "%d |4second:seconds;"
DBM_CORE_TIMER_FORMAT_MINS			= "%d |4minute:minutes;"
DBM_CORE_TIMER_FORMAT				= "%d |4minute:minutes; and %d |4second:seconds;"

DBM_CORE_MIN						= "min"
DBM_CORE_MIN_FMT					= "%d min"
DBM_CORE_SEC						= "sec"
DBM_CORE_SEC_FMT					= "%d sec"

DBM_CORE_GENERIC_WARNING_DUPLICATE	= "One of the %s"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Berserk in %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Berserk"
DBM_CORE_OPTION_TIMER_BERSERK		= "Show timer for $spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Combat starts"
DBM_CORE_OPTION_TIMER_COMBAT		= "Show timer for combat start"
DBM_CORE_OPTION_HEALTH_FRAME		= "Show boss health frame"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "Bars"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "Announces"

DBM_CORE_AUTO_RESPONDED						= "Auto-responded."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d people alive"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s is busy fighting against %s (%s, %d/%d people alive)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s has defeated %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s has defeated %s! They have %d total victories."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s has wiped on %s at %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s has wiped on %s at %s. They have %d total wipes on this difficulty."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s is busy in %s (%d/%d people alive)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s has completed %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s has completed %s! They have %d total victories."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s did not complete %s"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s did not complete %s. They have %d total incompletes on this difficulty."

DBM_CORE_VERSIONCHECK_HEADER		= "Boss Mod - Versions"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) & %s (r%d)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: No boss mod installed"
DBM_CORE_VERSIONCHECK_FOOTER		= "Found %d player(s) with DBM & %d player(s) with Bigwigs"
DBM_CORE_YOUR_VERSION_OUTDATED      = "Your version of Deadly Boss Mods is out-of-date. Please visit http://www.deadlybossmods.com to get the latest version."
DBM_CORE_OUTDATED_PVP_MODS			= "Your DBM-PvP mods are out of date and should be removed if they are not used, or updated to new stand alone package. These mods are no longer included with DBM-Core download. Latest PVP mods can be found at http://www.deadlybossmods.com"
DBM_BIG_WIGS						= "BigWigs"
DBM_BIG_WIGS_ALPHA					= "BigWigs Alpha"

DBM_CORE_UPDATEREMINDER_HEADER			= "Your version of Deadly Boss Mods is out-of-date.\n Version %s (r%d) is available for download here:"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "Your alpha version of Deadly Boss Mods is out-of-date.\n You are at least %d test versions behind. It is recommended that DBM users use the latest alpha or latest stable version. Out of date alphas can lead to poor or incomplete functionality."
DBM_CORE_UPDATEREMINDER_FOOTER			= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy the download link to your clipboard."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy the link to your clipboard."
DBM_CORE_UPDATEREMINDER_NOTAGAIN		= "Show popup when a new version is available"
DBM_CORE_UPDATEREMINDER_DISABLE			= "WARNING: Do to your Deadly Boss Mods being drastically out of date (%d revisions), it has been disabled until updated. This is to ensure old and incompatable code doesn't cause poor play experience for yourself or fellow raid members."

DBM_CORE_MOVABLE_BAR				= "Drag me!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h sent you a DBM timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancel this timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignore timers from %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Do you really want to ignore DBM timers from %s for this session?"
DBM_PIZZA_ERROR_USAGE				= "Usage: /dbm [broadcast] timer <time> <text>"

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
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d yd"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Frames"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Show radar frame"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Show text frame"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Show both frames"
DBM_CORE_RANGERADAR_HEADER			= "Range Radar (%d yd)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d players in range"

DBM_CORE_INFOFRAME_SHOW_SELF		= "Always show your power"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "LFG Invite"

DBM_CORE_SLASHCMD_HELP				= {
	"Available slash commands:",
	"/dbm version: Performs a raid-wide version check (alias: ver).",
--	"/dbm version2: Performs a raid-wide version check and whispers members who are out of date (alias: ver2).",
	"/dbm unlock: Shows a movable status bar timer (alias: move).",
	"/dbm timer <x> <text>: Starts a <x> second DBM Timer with the name <text>.",
	"/dbm broadcast timer <x> <text>: Broadcasts a <x> second DBM Timer with the name <text> to the raid (requires leader/promoted status).",
	"/dbm break <min>: Starts a break timer for <min> minutes. Gives all raid members with DBM a break timer (requires leader/promoted status).",
	"/dbm pull <sec>: Starts a pull timer for <sec> seconds. Gives all raid members with DBM a pull timer (requires leader/promoted status).",
	"/dbm arrow: Shows the DBM arrow, see /dbm arrow help for details.",
	"/dbm lockout: Asks raid members for their current raid instance lockouts (aliases: lockouts, ids) (requires leader/promoted status).",
	"/dbm lag: Performs a raid-wide latency check.",
	"/dbm help: Shows this message."
}

DBM_ERROR_NO_PERMISSION				= "You don't have the required permission to do this."

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "Close health frame"

DBM_CORE_UNKNOWN					= "unknown"--UNKNOWN which is "Unknown" (does u vs U matter?)
DBM_CORE_LEFT						= "Left"
DBM_CORE_RIGHT						= "Right"
DBM_CORE_BACK						= "Back"--BACK
DBM_CORE_FRONT						= "Front"

DBM_CORE_BREAK_START				= "Break starting now -- you have %s minute(s)!"
DBM_CORE_BREAK_MIN					= "Break ends in %s minute(s)!"
DBM_CORE_BREAK_SEC					= "Break ends in %s seconds!"
DBM_CORE_TIMER_BREAK				= "Break time!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Break time is over"

DBM_CORE_TIMER_PULL					= "Pull in"
DBM_CORE_ANNOUNCE_PULL				= "Pull in %d sec"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Pull now!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Achievement"--BATTLE_PET_SOURCE_6

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target		= "%s on >%%s<",
	targetcount	= "%s (%%d) on >%%s<",
	spell		= "%s",
	ends 		= "%s ended",
	fades		= "%s faded",
	adds		= "%s remaining: %%d",
	cast		= "Casting %s: %.1f sec",
	soon		= "%s soon",
	prewarn		= "%s in %s",
	phase		= "Phase %s",
	prephase	= "Phase %s soon",
	count		= "%s (%%d)",
	stack		= "%s on >%%s< (%%d)"
}

local prewarnOption = "Show pre-warning for $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target		= "Announce $spell:%s targets",
	targetcount	= "Announce $spell:%s targets",
	spell		= "Show warning for $spell:%s",
	ends		= "Show warning when $spell:%s has ended",
	fades		= "Show warning when $spell:%s has faded",
	adds		= "Announce how many $spell:%s remain",
	cast		= "Show warning when $spell:%s is being cast",
	soon		= prewarnOption,
	prewarn 	= prewarnOption,
	phase		= "Announce Phase %s",
	prephase	= "Show a prewarning for Phase %s",
	count		= "Show warning for $spell:%s",
	stack		= "Announce $spell:%s stacks"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell		= "%s!",
	ends		= "%s ended",
	fades		= "%s faded",
	soon		= "%s soon",
	prewarn		= "%s in %s",
	dispel		= "%s on >%%s< - dispel now",
	interrupt	= "%s - interrupt >%%s<!",
	you			= "%s on you",
	target		= "%s on >%%s<",
	close		= "%s on >%%s< near you",
	move		= "%s - move away",
	run			= "%s - run away",
	cast		= "%s - stop casting",
	reflect		= "%s - stop attacking",
	count		= "%s! (%%d)",
	stack		= "%%d stacks of %s on you",
	switch		= ">%s< - switch targets"
}

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell 		= "Show special warning for $spell:%s",
	ends 		= "Show special warning when $spell:%s has ended",
	fades 		= "Show special warning when $spell:%s has faded",
	soon 		= "Show pre-special warning for $spell:%s",
	prewarn 	= "Show pre-special warning %d seconds before $spell:%s",
	dispel 		= "Show special warning to dispel/spellsteal $spell:%s",
	interrupt	= "Show special warning to interrupt $spell:%s",
	you 		= "Show special warning when you are affected by $spell:%s",
	target 		= "Show special warning when someone is affected by $spell:%s",
	close 		= "Show special warning when someone close to you is affected by $spell:%s",
	move 		= "Show special warning to move out from $spell:%s",
	run 		= "Show special warning to run away from $spell:%s",
	cast 		= "Show special warning to stop casting for $spell:%s",--Spell Interrupt
	reflect 	= "Show special warning to stop attacking $spell:%s",--Spell Reflect
	count 		= "Show special warning for $spell:%s",
	stack 		= "Show special warning when you are affected by >=%d stacks of $spell:%s",--too long?
	switch		= "Show special warning to switch targets for $spell:%s"
}

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target		= "%s: >%%s<",
	cast		= "%s",
	active		= "%s ends",--Buff/Debuff/event on boss
	fades		= "%s fades",--Buff/Debuff on players
	cd			= "%s CD",
	cdcount		= "%s CD (%%d)",
	cdsource	= "%s CD: >%%s<",
	next		= "Next %s",
	nextcount	= "Next %s (%%d)",
	nextsource	= "Next %s: >%%s<",
	achievement	= "%s"
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target		= "Show timer for $spell:%s debuff",
	cast		= "Show timer for $spell:%s cast",
	active		= "Show timer for $spell:%s duration",
	fades		= "Show timer for when $spell:%s fades from players",
	cd			= "Show timer for $spell:%s cooldown",
	cdcount		= "Show timer for $spell:%s cooldown",
	cdsource	= "Show timer (with source) for $spell:%s cooldown",--Maybe better wording?
	next		= "Show timer for next $spell:%s",
	nextcount	= "Show timer for next $spell:%s",
	nextsource	= "Show timer (with source) for next $spell:%s",--Maybe better wording?
	achievement	= "Show timer for %s"
}


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Set icons on $spell:%s targets"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "Play \"run away\" sound for $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Play countdown sound for $spell:%s cooldown"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "Play countdown sound for when $spell:%s fades"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Play countout sound for $spell:%s duration"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "Yell when you are affected by $spell:%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "%s on " .. UnitName("player") .. "!"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Show range frame (%s) for $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Show range frame (%s)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Play ready check sound when boss is pulled (even if it's not targeted)"

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
	"/dbm arrow move  makes the arrow movable"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Record Victory"
DBM_SPEED_KILL_TIMER_OPTION	= "Show a timer to beat your fastest victory"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Best Clear"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s requested to see your current instance IDs and progress.\nDo you want to send this information to %s? He or she will be able to request this information during your current session (i. e. until you relog)."
DBM_ERROR_NO_RAID					= "You need to be in a raid group to use this feature."
DBM_INSTANCE_INFO_REQUESTED			= "Sent request for raid lockout information to the raid group.\nPlease note that the users will be asked for permission before sending the data to you, so it might take a minute until we get all responses."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "Got responses from %d players of %d DBM users: %d sent data, %d denied the request. Waiting %d more seconds for responses..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Received responses from all raid members"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s (%d), difficulty %d:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, progress %d: %s"
DBM_INSTANCE_INFO_STATS_DENIED		= "Denied the request: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Away: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "No recent DBM version installed: %s"
DBM_INSTANCE_INFO_RESULTS			= "Instance ID scan results. Note that instances might show up more than once if there are players with localized WoW clients in your raid."
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Players yet to respond: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Show results now]|r|h"

DBM_CORE_LAG_CHECKING				= "Checking raid Latency..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - Latency Results"
DBM_CORE_LAG_ENTRY					= "%s: World delay [%d ms] / Home delay [%d ms]"
DBM_CORE_LAG_FOOTER					= "No Response: %s"
