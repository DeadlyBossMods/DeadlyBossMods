DBM_CORE_L = {}

local L = DBM_CORE_L

L.DEADLY_BOSS_MODS					= "Deadly Boss Mods"
L.DBM								= "DBM"

if C_DateAndTime and C_DateAndTime.GetCurrentCalendarTime then
	local dateTable = C_DateAndTime.GetCurrentCalendarTime()
	if dateTable.monthDay and dateTable.month and dateTable.monthDay == 1 and dateTable.month == 4 then
		L.DEADLY_BOSS_MODS			= "Harmless Boss Mods"
		L.DBM						= "HBM"
	end
end

L.HOW_TO_USE_MOD					= "Welcome to " .. L.DBM .. ". Type /dbm help for a list of supported commands. To access options type /dbm in your chat to begin configuration. Load specific zones manually to configure any boss specific settings to your liking as well. " .. L.DBM .. " will setup defaults for your spec, but you may want to fine tune these."
L.SILENT_REMINDER					= "Reminder: " .. L.DBM .. " is still in silent mode."

L.LOAD_MOD_ERROR					= "Error while loading boss mods for %s: %s"
L.LOAD_MOD_SUCCESS					= "Loaded '%s' mods. For more options such as custom alert sounds and personalized warning notes, type /dbm."
L.LOAD_MOD_COMBAT					= "Loading of '%s' delayed until you leave combat"
L.LOAD_GUI_ERROR					= "Could not load GUI: %s"
L.LOAD_GUI_COMBAT					= "GUI cannot be initially loaded in combat. GUI will be loaded out of combat. After GUI loaded, you can open GUI in combat."
L.BAD_LOAD							= L.DBM .. " has detected your mod for this instance failed to fully load correctly because of combat. As soon as you are out of combat, please do /console reloadui as soon as possible."
L.LOAD_MOD_VER_MISMATCH				= "%s could not be loaded because your DBM-Core does not meet requirements. An updated version is required"
L.LOAD_MOD_EXP_MISMATCH				= "%s could not be loaded because it is designed for a WoW expansion that's not currently available. When expansion becomes available, this mod will automatically work."
L.LOAD_MOD_TOC_MISMATCH				= "%s could not be loaded because it is designed for a WoW patch (%s) that's not currently available. When patch becomes available, this mod will automatically work."
L.LOAD_MOD_DISABLED					= "%s is installed but currently disabled. This mod will not be loaded unless you enable it."
L.LOAD_MOD_DISABLED_PLURAL			= "%s are installed but currently disabled. These mods will not be loaded unless you enable them."

L.COPY_URL_DIALOG					= "Copy URL"

--Post Patch 7.1
L.NO_RANGE							= "Range Radar can not be used in instances. Legacy text range frame used instead"
L.NO_ARROW							= "Arrow can not be used in instances"
L.NO_HUD							= "HUDMap can not be used in instances"

L.DYNAMIC_DIFFICULTY_CLUMP			= L.DBM .. " has disabled dynamic range frame on this fight do to insufficient information about number of players needed to affect clump check for a group of your size."
L.DYNAMIC_ADD_COUNT					= L.DBM .. " has disabled add count warnings on this fight do to insufficient information about number of adds that spawn for a group of your size."
L.DYNAMIC_MULTIPLE					= L.DBM .. " has disabled multiple features on this fight do to insufficient information about certain mechanics for a group of your size."

L.LOOT_SPEC_REMINDER				= "Your current spec is %s. Your current loot choice is %s."

L.BIGWIGS_ICON_CONFLICT				= L.DBM .. " has detected that you have raid icons turned on in both BigWigs and " .. L.DBM .. ". Please disable icons in one of them to avoid conflicts"

L.MOD_AVAILABLE						= "%s is available for this zone. You can find download on Curse/Twitch or WoWI"

L.COMBAT_STARTED					= "%s engaged. Good luck and have fun! :)"
L.COMBAT_STARTED_IN_PROGRESS		= "Engaged an in progress fight against %s. Good luck and have fun! :)"
L.GUILD_COMBAT_STARTED				= "%s has been engaged by guild"
L.SCENARIO_STARTED					= "%s started. Good luck and have fun! :)"
L.SCENARIO_STARTED_IN_PROGRESS		= "Joined %s a scenario that's in progress. Good luck and have fun! :)"
L.BOSS_DOWN							= "%s down after %s!"
L.BOSS_DOWN_I						= "%s down! You have %d total victories."
L.BOSS_DOWN_L						= "%s down after %s! Your last kill took %s and your fastest kill took %s. You have %d total victories."
L.BOSS_DOWN_NR						= "%s down after %s! This is a new record! (Old record was %s). You have %d total victories."
L.RAID_DOWN							= "%s cleared after %s!"
L.RAID_DOWN_L						= "%s cleared after %s! Your fastest clear took %s."
L.RAID_DOWN_NR						= "%s cleared after %s! This is a new record! (Old record was %s)."
L.GUILD_BOSS_DOWN					= "%s has been defeated by guild after %s!"
L.SCENARIO_COMPLETE					= "%s completed after %s!"
L.SCENARIO_COMPLETE_I				= "%s completed! You have %d total clears."
L.SCENARIO_COMPLETE_L				= "%s completed after %s! Your last clear took %s and your fastest clear took %s. You have %d total clears."
L.SCENARIO_COMPLETE_NR				= "%s completed after %s! This is a new record! (Old record was %s). You have %d total clears."
L.COMBAT_ENDED_AT					= "Combat against %s (%s) ended after %s."
L.COMBAT_ENDED_AT_LONG				= "Combat against %s (%s) ended after %s. You have %d total wipes on this difficulty."
L.GUILD_COMBAT_ENDED_AT				= "Guild has wiped on %s (%s) after %s."
L.SCENARIO_ENDED_AT					= "%s ended after %s."
L.SCENARIO_ENDED_AT_LONG			= "%s ended after %s. You have %d total incompletes on this difficulty."
L.COMBAT_STATE_RECOVERED			= "%s was engaged %s ago, recovering timers... "
L.TRANSCRIPTOR_LOG_START			= "Transcriptor logging started."
L.TRANSCRIPTOR_LOG_END				= "Transcriptor logging ended."

L.MOVIE_SKIPPED						= L.DBM .. " has attempted to skip a cut scene automatically."
L.BONUS_SKIPPED						= L.DBM .. " has automatically closed bonus loot frame. If you need to get this frame back, type /dbmbonusroll within 3 minutes"

L.AFK_WARNING						= "You are AFK and in combat (%d percent health remaining), firing sound alert. If you are not AFK, clear your AFK flag or disable this option in 'extra features'."

L.COMBAT_STARTED_AI_TIMER			= "My CPU is a neural net processor; a learning computer. (This fight will use the new timer AI feature to generate timer approximations)"

L.PROFILE_NOT_FOUND					= "<" .. L.DBM .. "> Your current profile is corrupted. " .. L.DBM .. " will load 'Default' profile."
L.PROFILE_CREATED					= "'%s' profile created."
L.PROFILE_CREATE_ERROR				= "Create profile failed. Invalid profile name."
L.PROFILE_CREATE_ERROR_D			= "Create profile failed. '%s' profile already exists."
L.PROFILE_APPLIED					= "'%s' profile applied."
L.PROFILE_APPLY_ERROR				= "Apply profile failed. '%s' profile does not exist."
L.PROFILE_COPIED					= "'%s' profile copied."
L.PROFILE_COPY_ERROR				= "Copy profile failed. '%s' profile does not exist."
L.PROFILE_COPY_ERROR_SELF			= "Cannot copy profile to itself."
L.PROFILE_DELETED					= "'%s' profile deleted. 'Default' profile will be applied."
L.PROFILE_DELETE_ERROR				= "Delete profile failed. '%s' profile does not exist."
L.PROFILE_CANNOT_DELETE				= "Cannot delete 'Default' profile."
L.MPROFILE_COPY_SUCCESS				= "%s's (%d spec) mod settings have been copied."
L.MPROFILE_COPY_SELF_ERROR			= "Cannot copy character settings to itself"
L.MPROFILE_COPY_S_ERROR				= "Source is corrupted. Settings not copied or partly copied. Copy failed."
L.MPROFILE_COPYS_SUCCESS			= "%s's (%d spec) mod sound or note settings have been copied."
L.MPROFILE_COPYS_SELF_ERROR			= "Cannot copy character sound or note settings to itself"
L.MPROFILE_COPYS_S_ERROR			= "Source is corrupted. Sound or note settings not copied or partly copied. Copy failed."
L.MPROFILE_DELETE_SUCCESS			= "%s's (%d spec) mod settings deleted."
L.MPROFILE_DELETE_SELF_ERROR		= "Cannot delete mod settings currently in use."
L.MPROFILE_DELETE_S_ERROR			= "Source is corrupted. Settings not deleted or partly deleted. Delete failed."

L.NOTE_SHARE_SUCCESS				= "%s has shared their note for %s"
L.NOTE_SHARE_FAIL					= "%s attempted to share note text with you for %s. However, mod associated with this ability is not uninstalled or is not loaded. If you need this note, make sure you load the mod they are sharing notes for and ask them to share again"

L.NOTEHEADER						= "Enter your note text here for %s. Enclosing a players name with >< class colors it. For alerts with multiple counts, separate notes with '/'"
L.NOTEFOOTER						= "Press 'Okay' to accept changes or 'Cancel' to decline changes"
L.NOTESHAREDHEADER					= "%s has shared below note text for %s. If you accept it, it will overwrite your existing note"
L.NOTESHARED						= "Your note has been sent to the group"
L.NOTESHAREERRORSOLO				= "Lonely? Shouldn't be passing notes to yourself"
L.NOTESHAREERRORBLANK				= "Cannot share blank notes"
L.NOTESHAREERRORGROUPFINDER			= "Notes cannot be shared in BGs, LFR, or LFG"
L.NOTESHAREERRORALREADYOPEN			= "Cannot open a shared note link while note editor is already open, to prevent you from losing the note you are currently editing"

L.ALLMOD_DEFAULT_LOADED				= "Default options for all mods in this instance have been loaded."
L.ALLMOD_STATS_RESETED				= "All mod stats have been reset."
L.MOD_DEFAULT_LOADED				= "Default options for this fight have been loaded."
L.SOUNDKIT_MIGRATION				= "One or more of your warning/special warning sounds were reset to defaults do to incompatability media type or invalid sound path. " .. L.DBM .. " now only supports sound files residing your addons folder, or SoundKit IDs for playing media"

L.WORLDBOSS_ENGAGED					= "%s was possibly engaged on your realm at %s percent health. (Sent by %s)"
L.WORLDBOSS_DEFEATED				= "%s was possibly defeated on your realm (Sent by %s)."

L.TIMER_FORMAT_SECS					= "%.2f |4second:seconds;"
L.TIMER_FORMAT_MINS					= "%d |4minute:minutes;"
L.TIMER_FORMAT						= "%d |4minute:minutes; and %.2f |4second:seconds;"

L.MIN								= "min"
L.MIN_FMT							= "%d min"
L.SEC								= "sec"
L.SEC_FMT							= "%s sec"

L.GENERIC_WARNING_OTHERS			= "and one other"
L.GENERIC_WARNING_OTHERS2			= "and %d others"
L.GENERIC_WARNING_BERSERK			= "Berserk in %s %s"
L.GENERIC_TIMER_BERSERK				= "Berserk"
L.OPTION_TIMER_BERSERK				= "Show timer for $spell:26662"
L.GENERIC_TIMER_COMBAT				= "Combat starts"
L.OPTION_TIMER_COMBAT				= "Show timer for combat start"
L.BAD								= "Bad"

L.OPTION_CATEGORY_TIMERS			= "Bars"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS			= "General Announces"
L.OPTION_CATEGORY_WARNINGS_YOU		= "Personal Announces"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "Target Announces"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "Role Announces"

L.OPTION_CATEGORY_SOUNDS			= "Sounds"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS			= "Dropdowns"--Still put in MISC sub grooup, just used for line separators since multiple of these on a fight (or even having on of these at all) is rare.
L.OPTION_CATEGORY_YELLS				= "Yells"
L.OPTION_CATEGORY_NAMEPLATES		= "Nameplates"
L.OPTION_CATEGORY_ICONS				= "Icons"

L.AUTO_RESPONDED					= "Auto-responded."
L.STATUS_WHISPER					= "%s: %s, %d/%d people alive"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s is busy fighting against %s (%s, %d/%d people alive)"
L.WHISPER_COMBAT_END_KILL			= "%s has defeated %s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s has defeated %s! They have %d total victories."
L.WHISPER_COMBAT_END_WIPE_AT		= "%s has wiped on %s at %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s has wiped on %s at %s. They have %d total wipes on this difficulty."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s is busy in %s (%d/%d people alive)"
L.WHISPER_SCENARIO_END_KILL			= "%s has completed %s!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s has completed %s! They have %d total victories."
L.WHISPER_SCENARIO_END_WIPE			= "%s did not complete %s"
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s did not complete %s. They have %d total incompletes on this difficulty."

L.VERSIONCHECK_HEADER				= "Boss Mod - Versions"
L.VERSIONCHECK_ENTRY				= "%s: %s (%s) %s"--One Boss mod
L.VERSIONCHECK_ENTRY_TWO			= "%s: %s (%s) & %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM			= "%s: No boss mod installed"
L.VERSIONCHECK_FOOTER				= "Found %d player(s) with " .. L.DBM .. " & %d player(s) with Bigwigs"
L.VERSIONCHECK_OUTDATED				= "Following %d player(s) have outdated boss mod version: %s"
L.YOUR_VERSION_OUTDATED     		= "Your version of " .. L.DEADLY_BOSS_MODS .. " is out-of-date. Please download the latest version through Curse/Twitch, WoWI, or from the GitHub Releases page."
L.VOICE_PACK_OUTDATED				= "Your selected " .. L.DBM .. " voice pack is missing some sounds supported by " .. L.DBM .. ". Some warning sounds will still play default sounds. Please download a newer version of voice pack or pack contact author for an update that contains missing audio"
L.VOICE_MISSING						= "You have a " .. L.DBM .. " voice pack selected that could not be found. If this is an error, make sure your voice pack is properly installed and enabled in addons."
L.VOICE_DISABLED					= "You currently have at least one " .. L.DBM .. " voice pack installed but none enabled. If you intend to use a voice pack, make sure it's chosen in 'Spoken Alerts', else uninstall unused voice packs to hide this message"
L.VOICE_COUNT_MISSING				= "Countdown voice %d is set to a voice/count pack that could not be found. It has be reset to default setting: %s."
L.BIG_WIGS							= "BigWigs"

L.UPDATEREMINDER_HEADER				= "Your version of " .. L.DEADLY_BOSS_MODS.. " is out-of-date.\n Version %s (%s) is available for download through Curse/Twitch, WoWI, or from GitHub Releases page"
L.UPDATEREMINDER_HEADER_ALPHA		= "Your ALPHA version of " .. L.DEADLY_BOSS_MODS.. " is out-of-date.\n You are at least %s test versions behind. It is recommended that " .. L.DBM .. " users that choose ALPHA versions run the latest ALPHA. Otherwise, they should run latest RELEASE version. Out of date ALPHAs have a stricter version check because they are development versions of " .. L.DBM .. "."
L.UPDATEREMINDER_FOOTER				= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy the download link to your clipboard."
L.UPDATEREMINDER_FOOTER_GENERIC		= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy the link to your clipboard."
L.UPDATEREMINDER_DISABLE			= "WARNING: Due to your " .. L.DEADLY_BOSS_MODS.. " being too out of date, it has been force disabled and cannot be used until updated. This is to ensure outdated or incompatible mods do not cause poor play experience for yourself or fellow group members."
--L.UPDATEREMINDER_NODISABLE		= "WARNING: Your " .. L.DEADLY_BOSS_MODS.. " install is very out of date. While you may have disabled update notification, this message starts to appear after a certain threshold and cannot be disabled. Updating is HIGHLY recommended."
L.UPDATEREMINDER_HOTFIX				= L.DBM .. " version you are on has known issues during this boss encounter that are corrected if you update to latest release"
L.UPDATEREMINDER_HOTFIX_ALPHA		= L.DBM .. " version you are on has known issues during this boss encounter that are corrected in an upcoming release (or latest alpha version)"
L.UPDATEREMINDER_MAJORPATCH			= "WARNING: Do to your " .. L.DEADLY_BOSS_MODS.. " being out of date, " .. L.DBM .. " has been disabled until updated, since this is a major game patch. This is to ensure old and incompatible code doesn't cause poor play experience for yourself or fellow group members. Make sure you download a newer version from deadlybossmods.com or curse as soon as possible."
L.UPDATEREMINDER_TESTVERSION		= "WARNING: You are using a version of " .. L.DEADLY_BOSS_MODS.. " not intended to be used with this game version. Please make sure you download the appropriate version for your game client from deadlybossmods.com or curse."
L.VEM								= "WARNING: You are running both " .. L.DEADLY_BOSS_MODS.. " and Voice Encounter Mods. DBM will not run in this configuration and therefore will not be loaded."
L.OUTDATEDPROFILES					= "WARNING: DBM-Profiles not compatible with this version of " .. L.DBM .. ". It must be removed before DBM can proceed, to avoid conflict."
L.OUTDATEDSPELLTIMERS				= "WARNING: DBM-SpellTimers breaks " .. L.DBM .. " and must be disabled for " .. L.DBM .. " to function properly."
L.OUTDATEDRLT						= "WARNING: DBM-RaidLeadTools breaks " .. L.DBM .. ". DBM-RaidLeadTools is no longer supported and must be removed for " .. L.DBM .. " to function properly."
L.VICTORYSOUND						= "WARNING: DBM-VictorySound is not compatible with this version of " .. L.DBM .. ". It must be removed before " .. L.DBM .. " can proceed, to avoid conflict."
L.DPMCORE							= "WARNING: Deadly PvP mods is discontinued and not compatible with this version of " .. L.DBM .. ". It must be removed before " .. L.DBM .. " can proceed, to avoid conflict."
L.DBMLDB							= "WARNING: DBM-LDB is now built into DBM-Core. While it won't do any harm, it's recommended to remove 'DBM-LDB' from your addons folder"
L.DBMLOOTREMINDER					= "WARNING: 3rd party mod DBM-LootReminder is installed. This addon is no longer compatible with retail wow client and will cause DBM to break and not be able to send pull timers. Uninstall of this addon recommended"
L.UPDATE_REQUIRES_RELAUNCH			= "WARNING: This " .. L.DBM .. " update will not work correctly if you don't fully restart your game client. This update contains new files or .toc file changes that cannot be loaded via ReloadUI. You may encounter broken functionality or errors if you continue without a client restart."
L.OUT_OF_DATE_NAG					= "Your version of " .. L.DEADLY_BOSS_MODS.. " is out-of-date. It is recommended you update for this fight so you are not missing an important alert or timer or a yell rest of raid is expecting to see from you."
L.RETAIL_ONLY						= "WARNING: This version of " .. L.DBM .. " is only meant to be used with latest retail version World of Warcraft. Uninstall this version and install correct version of " .. L.DBM .. " for Classic WoW."

L.MOVABLE_BAR						= "Drag me!"

--L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h sent you a " .. L.DBM .. " timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Cancel this timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Ignore timers from %1$s]|r|h"
L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h sent you a " .. L.DBM .. " timer"
L.PIZZA_CONFIRM_IGNORE				= "Do you really want to ignore " .. L.DBM .. " timers from %s for this session?"
L.PIZZA_ERROR_USAGE					= "Usage: /dbm [broadcast] timer <time> <text>. <time> must be 3 or greater."

L.MINIMAP_TOOLTIP_HEADER			= L.DEADLY_BOSS_MODS--Technically redundant
L.MINIMAP_TOOLTIP_FOOTER			= "Hold shift and drag to move"

L.RANGECHECK_HEADER					= "Range Check (%dy)"
L.RANGECHECK_HEADERT				= "Range Check (%dy-%dP)"
L.RANGECHECK_RHEADER				= "R-Range Check (%dy)"
L.RANGECHECK_RHEADERT				= "R-Range Check (%dy-%dP)"
L.RANGECHECK_SETRANGE				= "Set range"
L.RANGECHECK_SETTHRESHOLD			= "Set player threshold"
L.RANGECHECK_SOUNDS					= "Sounds"
L.RANGECHECK_SOUND_OPTION_1			= "Sound when one player is in range"
L.RANGECHECK_SOUND_OPTION_2			= "Sound when more than one player is in range"
L.RANGECHECK_SOUND_0				= "No sound"
L.RANGECHECK_SOUND_1				= "Default sound"
L.RANGECHECK_SOUND_2				= "Annoying beep"
L.RANGECHECK_SETRANGE_TO			= "%d y"
L.RANGECHECK_OPTION_FRAMES			= "Frames"
L.RANGECHECK_OPTION_RADAR			= "Show radar frame"
L.RANGECHECK_OPTION_TEXT			= "Show text frame"
L.RANGECHECK_OPTION_BOTH			= "Show both frames"
L.RANGERADAR_HEADER					= "Range:%d Players:%d"
L.RANGERADAR_RHEADER				= "R-Rng:%d Players:%d"
L.RANGERADAR_IN_RANGE_TEXT			= "%d in range (%0.1fy)"--Multi
L.RANGECHECK_IN_RANGE_TEXT			= "%d in range"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE		= "%s (%0.1fy)"--One target

L.INFOFRAME_SHOW_SELF				= "Always show your power"		-- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES				= "Set max lines"
L.INFOFRAME_SETCOLS					= "Set max columns"
L.INFOFRAME_LINESDEFAULT			= "Set by mod"
L.INFOFRAME_LINES_TO				= "%d lines"
L.INFOFRAME_COLS_TO					= "%d columns"
L.INFOFRAME_POWER					= "Power"
L.INFOFRAME_AGGRO					= "Aggro"
L.INFOFRAME_MAIN					= "Main:"--Main power
L.INFOFRAME_ALT						= "Alt:"--Alternate Power

L.LFG_INVITE						= "LFG Invite"

L.SLASHCMD_HELP						= {
	"Available slash commands:",
	"-----------------",
	"/dbm unlock: Shows a movable status bar timer (alias: move).",
	"/range <number> or /distance <number>: Shows range frame. /rrange or /rdistance to reverse colors.",
	"/hudar <number>: Shows HUD based range finder.",
	"/dbm timer: Starts a custom " .. L.DBM .. " timer, see '/dbm timer' for details.",
	"/dbm arrow: Shows the " .. L.DBM .. " arrow, see '/dbm arrow help' for details.",
	"/dbm hud: Shows the " .. L.DBM .. " hud, see '/dbm hud' for details.",
	"/dbm help2: Shows raid management slash commands"
}
L.SLASHCMD_HELP2					= {
	"Available slash commands:",
	"-----------------",
	"/dbm pull <sec>: Sends a pull timer for <sec> seconds to the raid (requires promoted. alias: pull).",
	"/dbm break <min>: Sends a break timer for <min> minutes to the raid (requires promoted. alias: break).",
	"/dbm version: Performs a boss mod version check (alias: ver).",
	"/dbm version2: Performs a boss mod version check that also whispers out of date users (alias: ver2).",
	"/dbm lockout: Asks raid members for their current raid instance lockouts (aliases: lockouts, ids) (requires promoted).",
	"/dbm lag: Performs a raid-wide latency check.",
	"/dbm durability: Performs a raid-wide durability check."
}
L.TIMER_USAGE						= {
	L.DBM .. " timer commands:",
	"-----------------",
	"/dbm timer <sec> <text>: Starts a <sec> second timer with your <text>.",
	"/dbm ltimer <sec> <text>: Starts a timer that also automatically loops until canceled.",
	"('Broadcast' in front of any timer also shares it with raid if leader/promoted)",
	"/dbm timer endloop: Stops any looping ltimer."
}

L.ERROR_NO_PERMISSION				= "You don't have the required permission to do this."

--Common Locals
L.NEXT								= "Next %s"
L.COOLDOWN							= "%s CD"
L.UNKNOWN							= "Unknown"--UNKNOWN which is "Unknown" (does u vs U matter?)
L.LEFT								= "Left"
L.RIGHT								= "Right"
L.BOTH								= "Both"
L.BEHIND							= "Behind"
L.BACK								= "Back"--BACK
L.SIDE								= "Side"
L.TOP								= "Top"
L.BOTTOM							= "Bottom"
L.MIDDLE							= "Middle"
L.FRONT								= "Front"
L.EAST								= "East"
L.WEST								= "West"
L.NORTH								= "North"
L.SOUTH								= "South"
L.INTERMISSION						= "Intermission"--No blizz global for this, and will probably be used in most end tier fights with intermission phases
L.ORB								= "Orb"
L.ORBS								= "Orbs"
L.CHEST								= "Chest"--As in Treasure 'Chest'. Not Chest as in body part.
L.NO_DEBUFF							= "Not %s"--For use in places like info frame where you put "Not Spellname"
L.ALLY								= "Ally"--Such as "Move to Ally"
L.ALLIES							= "Allies"--Such as "Move to Allies"
L.ADD								= "Add"--A fight Add as in "boss spawned extra adds"
L.ADDS								= "Adds"
L.BIG_ADD							= "Big Add"
L.BOSS								= "Boss"
L.EDGE								= "Room Edge"
L.FAR_AWAY							= "Far Away"
L.BREAK_LOS							= "Break LOS"
L.RESTORE_LOS						= "Restore/Maintain LOS"
L.SAFE								= "Safe"
L.NOTSAFE							= "Not Safe"
L.SHIELD							= "Shield"
L.PILLAR							= "Pillar"
L.INCOMING							= "%s Incoming"
L.BOSSTOGETHER						= "Bosses Together"
L.BOSSAPART							= "Bosses Apart"
--Common Locals end

L.BREAK_USAGE						= "Break timer cannot be longer than 60 minutes. Make sure you're inputting time in minutes and not seconds."
L.BREAK_START						= "Break starting now -- you have %s! (Sent by %s)"
L.BREAK_MIN							= "Break ends in %s minute(s)!"
L.BREAK_SEC							= "Break ends in %s seconds!"
L.TIMER_BREAK						= "Break time!"
L.ANNOUNCE_BREAK_OVER				= "Break has ended at %s"

L.TIMER_PULL						= "Pull in"
L.ANNOUNCE_PULL						= "Pull in %d sec. (Sent by %s)"
L.ANNOUNCE_PULL_NOW					= "Pull now!"
L.ANNOUNCE_PULL_TARGET				= "Pulling %s in %d sec. (Sent by %s)"
L.ANNOUNCE_PULL_NOW_TARGET			= "Pulling %s now!"
L.GEAR_WARNING						= "Warning: Check gear. Your equipped ilvl is %d lower than bag ilvl"
L.GEAR_WARNING_WEAPON				= "Warning: Check if your weapon is correctly equipped."
L.GEAR_FISHING_POLE					= "Fishing Pole"

L.ACHIEVEMENT_TIMER_SPEED_KILL		= "Achievement"--BATTLE_PET_SOURCE_6

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS = {
	you								= "%s on YOU",
	target							= "%s on >%%s<",
	targetsource					= ">%%s< cast %s on >%%s<",
	targetcount						= "%s (%%s) on >%%s<",
	spell							= "%s",
	ends 							= "%s ended",
	endtarget						= "%s ended: >%%s<",
	fades							= "%s faded",
	adds							= "%s remaining: %%d",
	cast							= "Casting %s: %.1f sec",
	soon							= "%s soon",
	sooncount						= "%s (%%s) soon",
	countdown						= "%s in %%ds",
	prewarn							= "%s in %s",
	bait							= "%s soon - bait now",
	stage							= "Stage %s",
	prestage						= "Stage %s soon",
	count							= "%s (%%s)",
	stack							= "%s on >%%s< (%%d)",
	moveto							= "%s - move to >%%s<"
}

local prewarnOption					= "Show pre-warning for $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS = {
	you								= "Announce when $spell:%s on you",
	target							= "Announce $spell:%s targets",
	targetNF						= "Announce $spell:%s targets (ignores global target filter)",
	targetsource					= "Announce $spell:%s targets (with source)",
	targetcount						= "Announce $spell:%s targets (with count)",
	spell							= "Show warning for $spell:%s",
	ends							= "Show warning when $spell:%s has ended",
	endtarget						= "Show warning when $spell:%s has ended",
	fades							= "Show warning when $spell:%s has faded",
	adds							= "Announce how many $spell:%s remain",
	cast							= "Show warning when $spell:%s is being cast",
	soon							= prewarnOption,
	sooncount						= prewarnOption,
	countdown						= "Show pre-warning countdown spam for $spell:%s",
	prewarn 						= prewarnOption,
	bait							= "Show pre-warning (to bait) for $spell:%s",
	stage							= "Announce Stage %s",
	stagechange						= "Announce stage changes",
	prestage						= "Show a prewarning for Stage %s",
	count							= "Show warning for $spell:%s (with count)",
	stack							= "Announce $spell:%s stacks",
	moveto							= "Show warning to move to someone or some place for $spell:%s"
}

L.AUTO_SPEC_WARN_TEXTS = {
	spell							= "%s!",
	ends							= "%s ended",
	fades							= "%s faded",
	soon							= "%s soon",
	sooncount						= "%s (%%s) soon",
	bait							= "%s soon - bait now",
	prewarn							= "%s in %s",
	dispel							= "%s on >%%s< - dispel now",
	interrupt						= "%s - interrupt >%%s<!",
	interruptcount					= "%s - interrupt >%%s<! (%%d)",
	you								= "%s on you",
	youcount						= "%s (%%s) on you",
	youpos							= "%s (Position: %%s) on you",
	soakpos							= "%s (Soak Position: %%s)",
	target							= "%s on >%%s<",
	targetcount						= "%s (%%s) on >%%s< ",
	defensive						= "%s - defensive",
	taunt							= "%s on >%%s< - taunt now",
	close							= "%s on >%%s< near you",
	move							= "%s - move away",
	keepmove						= "%s - keep moving",
	stopmove						= "%s - stop moving",
	dodge							= "%s - dodge attack",
	dodgecount						= "%s (%%s) - dodge attack",
	dodgeloc						= "%s - dodge from %%s",
	moveaway						= "%s - move away from others",
	moveawaycount					= "%s (%%s) - move away from others",
	moveto							= "%s - move to >%%s<",
	soak							= "%s - soak it",
	jump							= "%s - jump",
	run								= "%s - run away",
	cast							= "%s - stop casting",
	lookaway						= "%s on %%s - look away",
	reflect							= "%s on >%%s< - stop attacking",
	count							= "%s! (%%s)",
	stack							= "%%d stacks of %s on you",
	switch							= "%s - switch targets",
	switchcount						= "%s - switch targets (%%s)",
	gtfo							= "%%s under you - move away",
	adds							= "Incoming Adds - switch targets",
	addscustom						= "Incoming Adds - %%s",
	targetchange					= "Target Change - switch to %%s"
}

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS = {
	spell 							= "Show special warning for $spell:%s",
	ends 							= "Show special warning when $spell:%s has ended",
	fades 							= "Show special warning when $spell:%s has faded",
	soon 							= "Show pre-special warning for $spell:%s",
	sooncount						= "Show pre-special warning (with count) for $spell:%s",
	bait							= "Show pre-special warning (to bait) for $spell:%s",
	prewarn 						= "Show pre-special warning %s seconds before $spell:%s",
	dispel 							= "Show special warning to dispel/spellsteal $spell:%s",
	interrupt						= "Show special warning to interrupt $spell:%s",
	interruptcount					= "Show special warning (with count) to interrupt $spell:%s",
	you 							= "Show special warning when you are affected by $spell:%s",
	youcount						= "Show special warning (with count) when you are affected by $spell:%s",
	youpos							= "Show special warning (with position) when you are affected by $spell:%s",
	soakpos							= "Show special warning (with position) to help soak others affected by $spell:%s",
	target 							= "Show special warning when someone is affected by $spell:%s",
	targetcount 					= "Show special warning (with count) when someone is affected by $spell:%s",
	defensive 						= "Show special warning to use defensive abilites for $spell:%s",
	taunt 							= "Show special warning to taunt when other tank affected by $spell:%s",
	close 							= "Show special warning when someone close to you is affected by $spell:%s",
	move 							= "Show special warning to move out from $spell:%s",
	keepmove 						= "Show special warning to keep moving for $spell:%s",
	stopmove 						= "Show special warning to stop moving for $spell:%s",
	dodge 							= "Show special warning to dodge $spell:%s",
	dodgecount						= "Show special warning (with count) to dodge $spell:%s",
	dodgeloc						= "Show special warning (with location) to dodge $spell:%s",
	moveaway						= "Show special warning to move away from others for $spell:%s",
	moveawaycount					= "Show special warning (with count) to move away from others for $spell:%s",
	moveto							= "Show special warning to move to someone or some place for $spell:%s",
	soak							= "Show special warning to soak for $spell:%s",
	jump							= "Show special warning to move to jump for $spell:%s",
	run 							= "Show special warning to run away from $spell:%s",
	cast 							= "Show special warning to stop casting for $spell:%s",--Spell Interrupt
	lookaway						= "Show special warning to look away for $spell:%s",
	reflect 						= "Show special warning to stop attacking $spell:%s",--Spell Reflect
	count 							= "Show special warning (with count) for $spell:%s",
	stack 							= "Show special warning when you are affected by >=%d stacks of $spell:%s",
	switch							= "Show special warning to switch targets for $spell:%s",
	switchcount						= "Show special warning (with count) to switch targets for $spell:%s",
	gtfo 							= "Show special warning to move out of bad stuff on ground",
	adds							= "Show special warning to switch targets for incoming adds",
	addscustom						= "Show special warning for incoming adds",
	targetchange					= "Show special warning for priority target changes"
}

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS = {
	target							= "%s: %%s",
	cast							= "%s",
	castshort						= "%s ",--if short timers enabled, cast and next are same timer text, this is a conflict. the space resolves it
	castcount						= "%s (%%s)",
	castcountshort					= "%s (%%s) ",--Resolve short timer conflict with next timers
	castsource						= "%s: %%s",
	castsourceshort					= "%s: %%s ",--Resolve short timer conflict with next timers
	active							= "%s ends",--Buff/Debuff/event on boss
	fades							= "%s fades",--Buff/Debuff on players
	ai								= "%s AI",
	cd								= "%s CD",
	cdshort							= "~%s",
	cdcount							= "%s CD (%%s)",
	cdcountshort					= "~%s (%%s)",
	cdsource						= "%s CD: >%%s<",
	cdsourceshort					= "~%s: >%%s<",
	cdspecial						= "Special CD",
	cdspecialshort					= "~Special",
	next							= "Next %s",
	nextshort						= "%s",
	nextcount						= "Next %s (%%s)",
	nextcountshort					= "%s (%%s)",
	nextsource						= "Next %s: %%s",
	nextsourceshort					= "%s: %%s",
	nextspecial						= "Next Special",
	nextspecialshort				= "Special",
	achievement						= "%s",
	stage							= "Next Stage",
	stageshort						= "Stage",
	adds							= "Incoming Adds",
	addsshort						= "Adds",
	addscustom						= "Incoming Adds (%%s)",
	addscustomshort					= "Adds (%%s)",
	roleplay						= GUILD_INTEREST_RP
}

L.AUTO_TIMER_OPTIONS = {
	target							= "Show timer for $spell:%s debuff",
	cast							= "Show timer for $spell:%s cast",
	castcount						= "Show timer (with count) for $spell:%s cast",
	castsource						= "Show timer (with source) for $spell:%s cast",
	active							= "Show timer for $spell:%s duration",
	fades							= "Show timer for when $spell:%s fades from players",
	ai								= "Show AI timer for $spell:%s cooldown",
	cd								= "Show timer for $spell:%s cooldown",
	cdcount							= "Show timer for $spell:%s cooldown",
	cdsource						= "Show timer (with source) for $spell:%s cooldown",--Maybe better wording?
	cdspecial						= "Show timer for special ability cooldown",
	next							= "Show timer for next $spell:%s",
	nextcount						= "Show timer for next $spell:%s",
	nextsource						= "Show timer (with source) for next $spell:%s",--Maybe better wording?
	nextspecial						= "Show timer for next special ability",
	achievement						= "Show timer for %s",
	stage							= "Show timer for next stage",
	adds							= "Show timer for incoming adds",
	addscustom						= "Show timer for incoming adds",
	roleplay						= "Show timer for roleplay duration"--This does need localizing though.
}


L.AUTO_ICONS_OPTION_TEXT			= "Set icons on $spell:%s targets"
L.AUTO_ICONS_OPTION_TEXT2			= "Set icons on $spell:%s"
L.AUTO_ARROW_OPTION_TEXT			= "Show " .. L.DBM .. " Arrow to move toward target affected by $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2			= "Show " .. L.DBM .. " Arrow to move away from target affected by $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3			= "Show " .. L.DBM .. " Arrow to move toward specific location for $spell:%s"
L.AUTO_YELL_OPTION_TEXT = {
	shortyell						= "Yell when you are affected by $spell:%s",
	yell							= "Yell (with player name) when you are affected by $spell:%s",
	count							= "Yell (with count) when you are affected by $spell:%s",
	fade							= "Yell (with countdown and spell name) when $spell:%s is fading",
	shortfade						= "Yell (with countdown) when $spell:%s is fading",
	iconfade						= "Yell (with countdown and icon) when $spell:%s is fading",
	position						= "Yell (with position) when you are affected by $spell:%s",
	combo							= "Yell (with custom text) when you are affected by $spell:%s and other spells at same time",
	repeatplayer					= "Yell repeatedly (with player name) when you are affected by $spell:%s",
	repeaticon						= "Yell repeatedly (with icon) when you are affected by $spell:%s"
}
L.AUTO_YELL_ANNOUNCE_TEXT = {
	shortyell						= "%s",
	yell							= "%s on " .. UnitName("player"),
	count							= "%s on " .. UnitName("player") .. " (%%d)",
	fade							= "%s fading in %%d",
	shortfade						= "%%d",
	iconfade						= "{rt%%2$d}%%1$d",
	position 						= "%s %%s on {rt%%d}" ..UnitName("player").. "{rt%%d}",
	combo							= "%s and %%s",--Spell name (from option, plus spellname given in arg)
	repeatplayer					= UnitName("player"),--Doesn't need translation, it's just player name spam
	repeaticon						= "{rt%%2$d}"--Doesn't need translation. It's just icon spam
}
L.AUTO_YELL_CUSTOM_POSITION			= "{rt%d}%s"--Doesn't need translating. Has no strings
L.AUTO_YELL_CUSTOM_POSITION2		= "{rt%d}%s{rt%d}"--Doesn't need translating. Has no strings
L.AUTO_YELL_CUSTOM_FADE				= "%s faded"
L.AUTO_HUD_OPTION_TEXT				= "Show HudMap for $spell:%s (Retired)"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "Show HudMap for various mechanics (Retired)"
L.AUTO_NAMEPLATE_OPTION_TEXT		= "Show Nameplate Auras for $spell:%s"
L.AUTO_RANGE_OPTION_TEXT			= "Show range frame (%s) for $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
L.AUTO_RANGE_OPTION_TEXT_SHORT		= "Show range frame (%s)"--For when a range frame is just used for more than one thing
L.AUTO_RRANGE_OPTION_TEXT			= "Show reverse range frame (%s) for $spell:%s"--Reverse range frame (green when players in range, red when not)
L.AUTO_RRANGE_OPTION_TEXT_SHORT		= "Show reverse range frame (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT		= "Show info frame for $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2		= "Show info frame for encounter overview"
L.AUTO_READY_CHECK_OPTION_TEXT		= "Play ready check sound when boss is pulled (even if it's not targeted)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT		= "Show timer for fastest clear of %s"

-- New special warnings
L.MOVE_WARNING_BAR					= "Announce movable"
L.MOVE_WARNING_MESSAGE				= "Thanks for using " .. L.DEADLY_BOSS_MODS
L.MOVE_SPECIAL_WARNING_BAR			= "Special warning movable"
L.MOVE_SPECIAL_WARNING_TEXT			= "Special Warning"

L.HUD_INVALID_TYPE					= "Invalid HUD type defined"
L.HUD_INVALID_TARGET				= "No valid target given for HUD"
L.HUD_INVALID_SELF					= "Cannot use self as target for HUD"
L.HUD_INVALID_ICON					= "Cannot use icon method for HUD on a target with no icon"
L.HUD_SUCCESS						= "HUD successful started with your parameters. This will cancel after %s, or by calling '/dbm hud hide'."
L.HUD_USAGE							= {
	L.DBM .. "-HudMap usage:",
	"-----------------",
	"/dbm hud <type> <target> <duration>: Creates a HUD that points to a player for the desired duration",
	"Valid types: arrow, dot, red, blue, green, yellow, icon (requires a target with raid icon)",
	"Valid targets: target, focus, <playername>",
	"Valid durations: any number (in seconds). If left blank, 20min will be used.",
	"/dbm hud hide: disables user generated HUD objects"
}

L.ARROW_MOVABLE						= "Arrow movable"
L.ARROW_WAY_USAGE					= "/dway <x> <y>: Creates an arrow that points to a specific location (using local zone map coordinates)"
L.ARROW_WAY_SUCCESS					= "To hide arrow, do '/dbm arrow hide' or reach arrow"
L.ARROW_ERROR_USAGE					= {
	L.DBM .. "-Arrow usage:",
	"-----------------",
	"/dbm arrow <x> <y>: Creates an arrow that points to a specific location (using world coordinates)",
	"/dbm arrow map <x> <y>: Creates an arrow that points to a specific location (using zone map coordinates)",
	"/dbm arrow <player>: Creates and arrow that points to a specific player in your party or raid (case sensitive!)",
	"/dbm arrow hide: Hides the arrow",
	"/dbm arrow move: Makes the arrow movable"
}

L.SPEED_KILL_TIMER_TEXT				= "Record Victory"
L.SPEED_CLEAR_TIMER_TEXT			= "Best Clear"
L.COMBAT_RES_TIMER_TEXT				= "Next CR Charge"
L.TIMER_RESPAWN						= "%s Respawn"


L.REQ_INSTANCE_ID_PERMISSION		= "%s requested to see your current instance IDs and progress.\nDo you want to send this information to %s? He or she will be able to request this information during your current session (i. e. until you relog)."
L.ERROR_NO_RAID						= "You need to be in a raid group to use this feature."
L.INSTANCE_INFO_REQUESTED			= "Sent request for raid lockout information to the raid group.\nPlease note that the users will be asked for permission before sending the data to you, so it might take a minute until we get all responses."
L.INSTANCE_INFO_STATUS_UPDATE		= "Got responses from %d players of %d " .. L.DBM .. " users: %d sent data, %d denied the request. Waiting %d more seconds for responses... "
L.INSTANCE_INFO_ALL_RESPONSES		= "Received responses from all raid members"
L.INSTANCE_INFO_DETAIL_DEBUG		= "Sender: %s ResultType: %s InstanceName: %s InstanceID: %s Difficulty: %d Size: %d Progress: %s"
L.INSTANCE_INFO_DETAIL_HEADER		= "%s, difficulty %s:"
L.INSTANCE_INFO_DETAIL_INSTANCE		= "    ID %s, progress %d: %s"
L.INSTANCE_INFO_DETAIL_INSTANCE2	= "    Progress %d: %s"
L.INSTANCE_INFO_NOLOCKOUT			= "There is no raid lockout information in your raid group."
L.INSTANCE_INFO_STATS_DENIED		= "Denied the request: %s"
L.INSTANCE_INFO_STATS_AWAY			= "Away: %s"
L.INSTANCE_INFO_STATS_NO_RESPONSE	= "No recent " .. L.DBM .. " version installed: %s"
L.INSTANCE_INFO_RESULTS				= "Instance ID scan results. Note that instances might show up more than once if there are players with localized WoW clients in your raid."
--L.INSTANCE_INFO_SHOW_RESULTS		= "Players yet to respond: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Show results now]|r|h"
L.INSTANCE_INFO_SHOW_RESULTS		= "Players yet to respond: %s"

L.LAG_CHECKING						= "Checking raid Latency... "
L.LAG_HEADER						= L.DEADLY_BOSS_MODS.. " - Latency Results"
L.LAG_ENTRY							= "%s: World delay [%d ms] / Home delay [%d ms]"
L.LAG_FOOTER						= "No Response: %s"

L.DUR_CHECKING						= "Checking raid Durability... "
L.DUR_HEADER						= L.DEADLY_BOSS_MODS.. " - Durability Results"
L.DUR_ENTRY							= "%s: Durability [%d percent] / Gear broken [%s]"
L.LAG_FOOTER						= "No Response: %s"

--Role Icons
L.TANK_ICON							= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:21:7:27|t"
L.DAMAGE_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:39:55:7:27|t"
L.HEALER_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:70:86:7:27|t"

L.TANK_ICON_SMALL					= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:6:21:7:27|t"
L.DAMAGE_ICON_SMALL					= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:39:55:7:27|t"
L.HEALER_ICON_SMALL					= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:70:86:7:27|t"
--Importance Icons
L.HEROIC_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:22:22:0:0:255:66:102:118:7:27|t"
L.DEADLY_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:22:22:0:0:255:66:133:153:7:27|t"
L.IMPORTANT_ICON					= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:168:182:7:27|t"
L.MYTHIC_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:22:22:0:0:255:66:133:153:40:58|t"

L.HEROIC_ICON_SMALL					= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:14:14:0:0:255:66:102:118:7:27|t"
L.DEADLY_ICON_SMALL					= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:14:14:0:0:255:66:133:153:7:27|t"
L.IMPORTANT_ICON_SMALL				= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:12:12:0:0:255:66:168:182:7:27|t"
--Type Icons
L.INTERRUPT_ICON					= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:198:214:7:27|t"
L.MAGIC_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:229:247:7:27|t"
L.CURSE_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:6:21:40:58|t"
L.POISON_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:39:55:40:58|t"
L.DISEASE_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:70:86:40:58|t"
L.ENRAGE_ICON						= "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:20:20:0:0:255:66:102:118:40:58|t"

--LDB
L.LDB_TOOLTIP_HELP1					= "Click to open " .. L.DBM
L.LDB_TOOLTIP_HELP2					= "Alt+right click to toggle Silent Mode"
L.SILENTMODE_IS						= "SilentMode is "

L.LDB_LOAD_MODS						= "Load boss mods"

L.LDB_CAT_SL						= EXPANSION_NAME8 or "Shadowlands"
L.LDB_CAT_BFA						= EXPANSION_NAME7
L.LDB_CAT_LEG						= EXPANSION_NAME6
L.LDB_CAT_WOD						= EXPANSION_NAME5
L.LDB_CAT_MOP						= EXPANSION_NAME4
L.LDB_CAT_CATA						= EXPANSION_NAME3
L.LDB_CAT_WOTLK						= EXPANSION_NAME2
L.LDB_CAT_BC						= EXPANSION_NAME1
L.LDB_CAT_CLASSIC 					= EXPANSION_NAME0
L.LDB_CAT_OTHER						= "Other Boss Mods"

L.LDB_CAT_GENERAL					= "General"
L.LDB_ENABLE_BOSS_MOD				= "Enable boss mod"
