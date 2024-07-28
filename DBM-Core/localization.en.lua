---@class DBMLocale
local L = {}

DBM_CORE_L = L

L.DEADLY_BOSS_MODS						= "Deadly Boss Mods" -- NO TRANSLATE
L.DBM									= "DBM" -- NO TRANSLATE

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD						= "Welcome to " .. L.DBM .. ". Type /dbm help for a list of supported commands. To access options type /dbm in your chat to begin configuration. Load specific zones manually to configure any boss specific settings to your liking as well. " .. L.DBM .. " will setup defaults for your spec, but you may want to fine tune these."
L.SILENT_REMINDER						= "Reminder: " .. L.DBM .. " is still in silent mode."
L.NEWS_UPDATE							= "|h|c11ff1111News|r|h: DBM has been updated with changes to mod structure so classic and mainline can now use unified (same) modules. This means that Vanilla (including SoD), TBC, Wrath, and Cata raid modules now need to be downloaded separately using same packages as retail. Read more about it |Hgarrmission:DBM:news|h|cff3588ff[click here]|r|h"
L.NEWS_UPDATE_REPEAT					= "|h|c11ff1111News|r|h: DBM has been updated with changes to mod structure so classic and mainline can now use unified (same) modules. This means that Vanilla (including SoD), TBC, Wrath, and Cata raid modules now need to be downloaded separately using same packages as retail. You are currently in a raid that has a missing module. This message will keep showing (and you'll have no functional alerts for this zone) until you've installed missing raid module."


L.COPY_URL_DIALOG_NEWS					= "To read latest news, visit link below"

L.LOAD_MOD_ERROR						= "Error while loading boss mods for %s: %s"
L.LOAD_MOD_SUCCESS						= "Loaded '%s' mods. For more options such as custom alert sounds and personalized warning notes, type /dbm."
L.LOAD_MOD_COMBAT						= "Loading of '%s' delayed until you leave combat"
L.LOAD_GUI_ERROR						= "Could not load GUI: %s"
L.LOAD_GUI_COMBAT						= "GUI cannot be initially loaded in combat. GUI will be loaded out of combat. After GUI loaded, you can open GUI in combat."
L.BAD_LOAD								= L.DBM .. " has detected your mod for this instance failed to fully load correctly because of combat. As soon as you are out of combat, please do /console reloadui as soon as possible."
L.LOAD_MOD_VER_MISMATCH					= "%s could not be loaded because your DBM-Core does not meet requirements. An updated version is required"
L.LOAD_MOD_EXP_MISMATCH					= "%s could not be loaded because it is designed for a WoW expansion that's not currently available. When expansion becomes available, this mod will automatically work."
L.LOAD_MOD_TOC_MISMATCH					= "%s could not be loaded because it is designed for a WoW patch (%s) that's not currently available. When patch becomes available, this mod will automatically work."
L.LOAD_MOD_DISABLED						= "%s is installed but currently disabled. This mod will not be loaded unless you enable it."
L.LOAD_MOD_DISABLED_PLURAL				= "%s are installed but currently disabled. These mods will not be loaded unless you enable them."

L.COPY_URL_DIALOG						= "Copy URL"
L.COPY_WA_DIALOG						= "Copy WA Key"

--Post Patch 7.1
L.TEXT_ONLY_RANGE						= "Range frame is limited to text only due to Blizzard disabling some functionality in this area."
L.NO_RANGE								= "Range frame can not be used due to Blizzard disabling that functionality in this area."
L.NO_ARROW								= "Arrow can not be used in instances"
L.NO_HUD								= "HUDMap can not be used in instances"

L.DYNAMIC_DIFFICULTY_CLUMP				= L.DBM .. " has disabled dynamic range frame on this fight do to insufficient information about number of players needed to affect clump check for a group of your size."
L.DYNAMIC_ADD_COUNT						= L.DBM .. " has disabled add count warnings on this fight do to insufficient information about number of adds that spawn for a group of your size."
L.DYNAMIC_MULTIPLE						= L.DBM .. " has disabled multiple features on this fight do to insufficient information about certain mechanics for a group of your size."

L.LOOT_SPEC_REMINDER					= "Your current spec is %s. Your current loot choice is %s."

L.BIGWIGS_ICON_CONFLICT					= L.DBM .. " has detected that you have raid icons turned on in both BigWigs and " .. L.DBM .. ". Please disable icons in one of them to avoid conflicts"

L.MOD_AVAILABLE							= "%s is available for this zone but not installed. You can download it on Curse, Wago, WoWI, or from the GitHub Releases page."
L.MOD_MISSING							= "No Raid Module"

L.COMBAT_STARTED						= "%s engaged. Good luck and have fun! :)"
L.COMBAT_STARTED_IN_PROGRESS			= "Engaged an in progress fight against %s. Good luck and have fun! :)"
L.GUILD_COMBAT_STARTED					= "%s has been engaged by %s's guild group"
L.SCENARIO_STARTED						= "%s started. Good luck and have fun! :)"
L.SCENARIO_STARTED_IN_PROGRESS			= "Joined %s a scenario that's in progress. Good luck and have fun! :)"
L.BOSS_DOWN								= "%s down after %s!"
L.BOSS_DOWN_I							= "%s down! You have %d total victories."
L.BOSS_DOWN_L							= "%s down after %s! Your last kill took %s and your fastest kill took %s. You have %d total victories."
L.BOSS_DOWN_NR							= "%s down after %s! This is a new record! (Old record was %s). You have %d total victories."
L.RAID_DOWN								= "%s cleared after %s!"
L.RAID_DOWN_L							= "%s cleared after %s! Your fastest clear took %s."
L.RAID_DOWN_NR							= "%s cleared after %s! This is a new record! (Old record was %s)."
L.GUILD_BOSS_DOWN						= "%s has been defeated by %s's guild group after %s!"
L.SCENARIO_COMPLETE						= "%s completed after %s!"
L.SCENARIO_COMPLETE_I					= "%s completed! You have %d total clears."
L.SCENARIO_COMPLETE_L					= "%s completed after %s! Your last clear took %s and your fastest clear took %s. You have %d total clears."
L.SCENARIO_COMPLETE_NR					= "%s completed after %s! This is a new record! (Old record was %s). You have %d total clears."
L.COMBAT_ENDED_AT						= "Combat against %s (%s) ended after %s."
L.COMBAT_ENDED_AT_LONG					= "Combat against %s (%s) ended after %s. You have %d total wipe(s) on this difficulty."
L.GUILD_COMBAT_ENDED_AT					= "%s's Guild group has wiped on %s (%s) after %s."
L.SCENARIO_ENDED_AT						= "%s ended after %s."
L.SCENARIO_ENDED_AT_LONG				= "%s ended after %s. You have %d total incompletes on this difficulty."
L.COMBAT_STATE_RECOVERED				= "%s was engaged %s ago, recovering timers... "
L.TRANSCRIPTOR_LOG_START				= "Transcriptor logging started."
L.TRANSCRIPTOR_LOG_END					= "Transcriptor logging ended."

L.MOVIE_SKIPPED							= L.DBM .. " has attempted to skip a cut scene automatically."
L.MOVIE_NOTSKIPPED							= L.DBM .. " has detected a skipable cut scene but has NOT skipped it due to a blizzard bug. When this bug is fixed, skipping will be re-enabled"
L.BONUS_SKIPPED							= L.DBM .. " has automatically closed bonus loot frame. If you need to get this frame back, type /dbmbonusroll within 3 minutes"

L.AFK_WARNING							= "You are AFK and in combat (%d percent health remaining), firing sound alert. If you are not AFK, clear your AFK flag or disable this option in 'extra features'."

L.COMBAT_STARTED_AI_TIMER				= "My CPU is a neural net processor; a learning computer. (This fight will use the new timer AI feature to generate timer approximations)"

L.PROFILE_NOT_FOUND						= "<" .. L.DBM .. "> Your current profile is corrupted. " .. L.DBM .. " will load 'Default' profile."
L.PROFILE_CREATED						= "'%s' profile created."
L.PROFILE_CREATE_ERROR					= "Create profile failed. Invalid profile name."
L.PROFILE_CREATE_ERROR_D				= "Create profile failed. '%s' profile already exists."
L.PROFILE_APPLIED						= "'%s' profile applied."
L.PROFILE_APPLY_ERROR					= "Apply profile failed. '%s' profile does not exist."
L.PROFILE_COPIED						= "'%s' profile copied."
L.PROFILE_COPY_ERROR					= "Copy profile failed. '%s' profile does not exist."
L.PROFILE_COPY_ERROR_SELF				= "Cannot copy profile to itself."
L.PROFILE_DELETED						= "'%s' profile deleted. 'Default' profile will be applied."
L.PROFILE_DELETE_ERROR					= "Delete profile failed. '%s' profile does not exist."
L.PROFILE_CANNOT_DELETE					= "Cannot delete 'Default' profile."
L.MPROFILE_COPY_SUCCESS					= "%s's (%d spec) mod settings have been copied."
L.MPROFILE_COPY_SELF_ERROR				= "Cannot copy character settings to itself"
L.MPROFILE_COPY_S_ERROR					= "Source is corrupted. Settings not copied or partly copied. Copy failed."
L.MPROFILE_COPYS_SUCCESS				= "%s's (%d spec) mod sound or note settings have been copied."
L.MPROFILE_COPYS_SELF_ERROR				= "Cannot copy character sound or note settings to itself"
L.MPROFILE_COPYS_S_ERROR				= "Source is corrupted. Sound or note settings not copied or partly copied. Copy failed."
L.MPROFILE_DELETE_SUCCESS				= "%s's (%d spec) mod settings deleted."
L.MPROFILE_DELETE_SELF_ERROR			= "Cannot delete mod settings currently in use."
L.MPROFILE_DELETE_S_ERROR				= "Source is corrupted. Settings not deleted or partly deleted. Delete failed."

L.NOTE_SHARE_SUCCESS					= "%s has shared their note for %s"
L.NOTE_SHARE_LINK						= "Click Here to Open Note"
L.NOTE_SHARE_FAIL						= "%s attempted to share note text with you for %s. However, mod associated with this ability is not installed or is not loaded. If you need this note, make sure you load the mod they are sharing notes for and ask them to share again"

L.NOTEHEADER							= "Enter your note text here for %s. Enclosing a players name with >< class colors it. For alerts with multiple counts, separate notes with '/'"
L.NOTEFOOTER							= "Press 'Okay' to accept changes or 'Cancel' to decline changes"
L.NOTESHAREDHEADER						= "%s has shared below note text for %s. If you accept it, it will overwrite your existing note"
L.NOTESHARED							= "Your note has been sent to the group"
L.NOTESHAREERRORSOLO					= "Lonely? Shouldn't be passing notes to yourself"
L.NOTESHAREERRORBLANK					= "Cannot share blank notes"
L.NOTESHAREERRORGROUPFINDER				= "Notes cannot be shared in BGs, LFR, or LFG"
L.NOTESHAREERRORALREADYOPEN				= "Cannot open a shared note link while note editor is already open, to prevent you from losing the note you are currently editing"

L.ALLMOD_DEFAULT_LOADED					= "Default options for all mods in this instance have been loaded."
L.ALLMOD_STATS_RESETED					= "All mod stats have been reset."
L.MOD_DEFAULT_LOADED					= "Default options for this fight have been loaded."

L.WORLDBOSS_ENGAGED						= "%s was possibly engaged on your realm at %s percent health. (Sent by %s)"
L.WORLDBOSS_DEFEATED					= "%s was possibly defeated on your realm (Sent by %s)."
L.WORLDBUFF_STARTED						= "%s buff has started on your realm for %s faction (Sent by %s)."

L.TIMER_FORMAT_SECS						= "%.2f |4second:seconds;"
L.TIMER_FORMAT_MINS						= "%d |4minute:minutes;"
L.TIMER_FORMAT							= "%d |4minute:minutes; and %.2f |4second:seconds;"

L.MIN									= "min"
L.MIN_FMT								= "%d min"
L.SEC									= "sec"
L.SEC_FMT								= "%s sec"

L.GENERIC_WARNING_OTHERS				= "and one other"
L.GENERIC_WARNING_OTHERS2				= "and %d others"
L.GENERIC_WARNING_BERSERK				= "Berserk in %s %s"
L.GENERIC_TIMER_BERSERK					= "Berserk"
L.OPTION_TIMER_BERSERK					= "Show timer for $spell:26662"
L.BAD									= "Bad"

L.OPTION_CATEGORY_TIMERS				= "Bars"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS				= "General Announces"
L.OPTION_CATEGORY_WARNINGS_YOU			= "Personal Announces"
L.OPTION_CATEGORY_WARNINGS_OTHER		= "Target Announces"
L.OPTION_CATEGORY_WARNINGS_ROLE			= "Role Announces"
L.OPTION_CATEGORY_SPECWARNINGS			= "Special Announces"

L.OPTION_CATEGORY_SOUNDS				= "Sounds"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS				= "Dropdowns"--Still put in MISC sub grooup, just used for line separators since multiple of these on a fight (or even having on of these at all) is rare.
L.OPTION_CATEGORY_YELLS					= "Yells"
L.OPTION_CATEGORY_NAMEPLATES			= "Nameplates"
L.OPTION_CATEGORY_ICONS					= "Icons"
L.OPTION_CATEGORY_PAURAS				= "Private Auras"

L.AUTO_RESPONDED						= "Auto-responded."
L.STATUS_WHISPER						= "%s: %s, %d/%d people alive"
--Bosses
L.AUTO_RESPOND_WHISPER					= "%s is busy fighting against %s (%s, %d/%d people alive)"
L.WHISPER_COMBAT_END_KILL				= "%s has defeated %s!"
L.WHISPER_COMBAT_END_KILL_STATS			= "%s has defeated %s! They have %d total victories."
L.WHISPER_COMBAT_END_WIPE_AT			= "%s has wiped on %s at %s"
L.WHISPER_COMBAT_END_WIPE_STATS_AT		= "%s has wiped on %s at %s. They have %d total wipes on this difficulty."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO			= "%s is busy in %s (%d/%d people alive)"
L.WHISPER_SCENARIO_END_KILL				= "%s has completed %s!"
L.WHISPER_SCENARIO_END_KILL_STATS		= "%s has completed %s! They have %d total victories."
L.WHISPER_SCENARIO_END_WIPE				= "%s did not complete %s"
L.WHISPER_SCENARIO_END_WIPE_STATS		= "%s did not complete %s. They have %d total incompletes on this difficulty."

L.VERSIONCHECK_HEADER					= "Boss Mod - Versions"
L.VERSIONCHECK_ENTRY					= "%s: %s (%s) %s"--One Boss mod -- OPTIONAL
L.VERSIONCHECK_ENTRY_TWO				= "%s: %s (%s) & %s (%s)"--Two Boss mods -- OPTIONAL
L.VERSIONCHECK_ENTRY_NO_DBM				= "%s: No boss mod installed"
L.VERSIONCHECK_FOOTER					= "Found %d player(s) with " .. L.DBM .. " & %d player(s) with Bigwigs"
L.VERSIONCHECK_OUTDATED					= "Following %d player(s) have outdated boss mod version: %s"
L.YOUR_VERSION_OUTDATED     			= "Your version of " .. L.DEADLY_BOSS_MODS .. " is out-of-date. Please download the latest version through Curse, Wago, WoWI, or from the GitHub Releases page."
L.VOICE_PACK_OUTDATED					= "Your selected " .. L.DBM .. " voice pack is missing some sounds supported by " .. L.DBM .. ". Some warning sounds will still play default sounds. Please download a newer version of voice pack or contact pack author for an update that contains missing audio"
L.VOICE_MISSING							= "You have a " .. L.DBM .. " voice pack selected that could not be found. If this is an error, make sure your voice pack is properly installed and enabled in addons."
L.VOICE_DISABLED						= "You currently have at least one " .. L.DBM .. " voice pack installed but none enabled. If you intend to use a voice pack, make sure it's chosen in 'Spoken Alerts', else uninstall unused voice packs to hide this message"
L.VOICE_COUNT_MISSING					= "Countdown voice %d is set to a voice/count pack that could not be found. It has been reset to default setting: %s."
L.BIG_WIGS								= "BigWigs" -- OPTIONAL
L.WEAKAURA_KEY							= " (|cff308530WA Key:|r %s)"

L.UPDATEREMINDER_HEADER					= "Your version of " .. L.DEADLY_BOSS_MODS.. " is out-of-date.\n Version %s (%s) is available for download through Curse, Wago, WoWI, or from GitHub Releases page"
L.UPDATEREMINDER_HEADER_SUBMODULE		= "Your %s module is out-of-date.\n Version %s is available for download through Curse, Wago, WoWI, or from GitHub Releases page"
L.UPDATEREMINDER_FOOTER					= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy the download link to your clipboard."
L.UPDATEREMINDER_FOOTER_GENERIC			= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy to your clipboard."
L.UPDATEREMINDER_DISABLE				= "WARNING: Due to your " .. L.DEADLY_BOSS_MODS.. " being out of date and incompatible with current game version or newer versions of DBM, it has been force disabled and cannot be used until updated. This is to ensure incompatible mods do not cause poor play experience for yourself or fellow group members."
L.UPDATEREMINDER_DISABLETEST			= "WARNING: Due to your " .. L.DEADLY_BOSS_MODS.. " being out of date and this being a test/beta realm, it has been force disabled and cannot be used until updated. This is to ensure out of date mods aren't being used to generate test feedback"
L.UPDATEREMINDER_HOTFIX					= L.DBM .. " version you are on has known issues during this boss encounter that are corrected if you update to latest release"
L.UPDATEREMINDER_HOTFIX_ALPHA			= L.DBM .. " version you are on has known issues during this boss encounter that are corrected in an upcoming release (or latest alpha version)"
L.UPDATEREMINDER_MAJORPATCH				= "WARNING: Due to your " .. L.DEADLY_BOSS_MODS.. " being out of date, " .. L.DBM .. " has been disabled until updated, since this is a major game patch. This is to ensure old and incompatible code doesn't cause poor play experience for yourself or fellow group members. Make sure you download a newer version from Curse, Wago, WoWI, or from GitHub Releases page as soon as possible."
L.VEM									= "WARNING: You are running both " .. L.DEADLY_BOSS_MODS.. " and Voice Encounter Mods. DBM will not run in this configuration and therefore will not be loaded."
L.OUTDATEDPROFILES						= "WARNING: DBM-Profiles not compatible with this version of " .. L.DBM .. ". It must be removed before DBM can proceed, to avoid conflict."
L.OUTDATEDSPELLTIMERS					= "WARNING: DBM-SpellTimers breaks " .. L.DBM .. " and must be disabled for " .. L.DBM .. " to function properly."
L.OUTDATEDRLT							= "WARNING: DBM-RaidLeadTools breaks " .. L.DBM .. ". DBM-RaidLeadTools is no longer supported and must be removed for " .. L.DBM .. " to function properly."
L.VICTORYSOUND							= "WARNING: DBM-VictorySound is not compatible with this version of " .. L.DBM .. ". It must be removed before " .. L.DBM .. " can proceed, to avoid conflict."
L.DPMCORE								= "WARNING: Deadly PvP mods is discontinued and not compatible with this version of " .. L.DBM .. ". It must be removed before " .. L.DBM .. " can proceed, to avoid conflict."
L.DBMLDB								= "WARNING: DBM-LDB is now built into DBM-Core. While it won't do any harm, it's recommended to remove 'DBM-LDB' from your addons folder"
L.DBMLOOTREMINDER						= "WARNING: 3rd party mod DBM-LootReminder is installed. This addon is no longer compatible with Retail WoW client and will cause " .. L.DBM .. " to break and not be able to send pull timers. Uninstall of this addon recommended"
L.UPDATE_REQUIRES_RELAUNCH				= "WARNING: This " .. L.DBM .. " update will not work correctly if you don't fully restart your game client. This update contains new files or .toc file changes that cannot be loaded via ReloadUI. You may encounter broken functionality or errors if you continue without a client restart."
L.OUT_OF_DATE_NAG						= "Your version of " .. L.DBM.. " is out-of-date and this specific fight mod has newer features or bug fixes. It is recommended you update for this fight to improve your experience."
L.PLATER_NP_AURAS_MSG					= L.DBM .. " includes an advanced feature to show enemy cooldown timers using icons on nameplates. This is on by default for most users, but for Plater users it is off by default in Plater options unless you enable it. To get the most out of DBM (and Plater) it's recommended you enable this feature in Plater under 'Buff Special' section. If you don't want to see this message again, you can also just entirely disable 'Cooldown icons on nameplates' option in DBM global disable or nameplate options panels"

L.MOVABLE_BAR							= "Drag me!"

L.PIZZA_SYNC_INFO						= "|Hplayer:%1$s|h[%1$s]|h sent you a " .. L.DBM .. " timer: '%2$s'\n|Hgarrmission:DBM:cancel:%2$s:nil|h|cff3588ff[Cancel this timer]|r|h  |Hgarrmission:DBM:ignore:%2$s:%1$s|h|cff3588ff[Ignore timers from %1$s]|r|h"
--L.PIZZA_SYNC_INFO						= "|Hplayer:%1$s|h[%1$s]|h sent you a " .. L.DBM .. " timer"
L.PIZZA_CONFIRM_IGNORE					= "Do you really want to ignore " .. L.DBM .. " timers from %s for this session?"
L.PIZZA_ERROR_USAGE						= "Usage: /dbm [broadcast] timer <time> <text>. <time> must be 3 or greater."

L.MINIMAP_TOOLTIP_HEADER				= L.DEADLY_BOSS_MODS --Technically redundant -- OPTIONAL
L.MINIMAP_TOOLTIP_FOOTER				= "Hold shift and drag to move"

L.RANGECHECK_HEADER						= "Range Check (%dy)"
L.RANGECHECK_HEADERT					= "Range Check (%dy-%dP)"
L.RANGECHECK_RHEADER					= "R-Range Check (%dy)"
L.RANGECHECK_RHEADERT					= "R-Range Check (%dy-%dP)"
L.RANGECHECK_SETRANGE					= "Set range"
L.RANGECHECK_SETTHRESHOLD				= "Set player threshold"
L.RANGECHECK_SOUNDS						= "Sounds"
L.RANGECHECK_SOUND_OPTION_1				= "Sound when one player is in range"
L.RANGECHECK_SOUND_OPTION_2				= "Sound when more than one player is in range"
L.RANGECHECK_SOUND_0					= "No sound"
L.RANGECHECK_SOUND_1					= "Default sound"
L.RANGECHECK_SOUND_2					= "Annoying beep"
L.RANGECHECK_SETRANGE_TO				= "%d y"
L.RANGECHECK_OPTION_FRAMES				= "Frames"
L.RANGECHECK_OPTION_RADAR				= "Show radar frame"
L.RANGECHECK_OPTION_TEXT				= "Show text frame"
L.RANGECHECK_OPTION_BOTH				= "Show both frames"
L.RANGERADAR_HEADER						= "Range:%d Players:%d"
L.RANGERADAR_RHEADER					= "R-Rng:%d Players:%d"
L.RANGERADAR_IN_RANGE_TEXT				= "%d in range (%0.1fy)"--Multi
L.RANGECHECK_IN_RANGE_TEXT				= "%d in range"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE			= "%s (%0.1fy)"--One target

L.INFOFRAME_TITLE						= "DBM Info Frame"
L.INFOFRAME_SHOW_SELF					= "Always show your power"		-- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES					= "Set max lines"
L.INFOFRAME_SETCOLS						= "Set max columns"
L.INFOFRAME_LINESDEFAULT				= "Auto Set by boss modules"
L.INFOFRAME_LINES_TO					= "%d lines"
L.INFOFRAME_COLS_TO						= "%d columns"
L.INFOFRAME_POWER						= "Power"
L.INFOFRAME_AGGRO						= "Aggro"
L.INFOFRAME_MAIN						= "Main:"--Main power
L.INFOFRAME_ALT							= "Alt:"--Alternate Power

L.LFG_INVITE							= "LFG Invite"

L.SLASHCMD_HELP							= {
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
L.SLASHCMD_HELP2						= {
	"Available slash commands:",
	"-----------------",
	"/dbm pull <sec>: Sends a pull timer for <sec> seconds to the raid (requires promoted. alias: pull).",
	"/dbm break <min>: Sends a break timer for <min> minutes to the raid (requires promoted. alias: break).",
	"/dbm version: Performs a boss mod version check (alias: ver).",
	"/dbm version2: Performs a boss mod version check that also whispers out of date users (alias: ver2).",
	"/dbm lag: Performs a raid-wide latency check.",
	"/dbm durability: Performs a raid-wide durability check."
}
L.TIMER_USAGE							= {
	L.DBM .. " timer commands:",
	"-----------------",
	"/dbm timer <sec> <text>: Starts a <sec> second timer with your <text>.",
	"/dbm ltimer <sec> <text>: Starts a timer that also automatically loops until canceled.",
	"('Broadcast' in front of the 'timer' or 'ltimer' also shares it with raid if leader/promoted)",
	"/dbm timer endloop: Stops any looping ltimer."
}

L.ERROR_NO_PERMISSION					= "You don't have the required permission to send pull/break timer."
L.ERROR_NO_PERMISSION_COMBAT			= "Pull/Break timer cannot be sent while encounter in progress"
L.PULL_TIME_TOO_SHORT					= "Pull timer must be longer than 3 seconds."
L.PULL_TIME_TOO_LONG					= "Pull timer cannot be longer than 60 seconds. Consider using a /break timer instead."

L.BREAK_USAGE							= "Break timer cannot be longer than 60 minutes. Make sure you're inputting time in minutes and not seconds."
L.BREAK_START							= "Break starting now -- you have %s! (Sent by %s)"
L.BREAK_MIN								= "Break ends in %s minute(s)!"
L.BREAK_SEC								= "Break ends in %s seconds!"
L.TIMER_BREAK							= "Break time!"
L.ANNOUNCE_BREAK_OVER					= "Break has ended at %s"

L.TIMER_PULL							= "Pull in"
L.ANNOUNCE_PULL							= "Pull in %d sec. (Sent by %s)"
L.ANNOUNCE_PULL_NOW						= "Pull now!"
L.ANNOUNCE_PULL_TARGET					= "Pulling %s in %d sec. (Sent by %s)"
L.ANNOUNCE_PULL_NOW_TARGET				= "Pulling %s now!"
L.GEAR_WARNING							= "Warning: Check gear. Your equipped ilvl is %d lower than bag ilvl"
L.GEAR_WARNING_WEAPON					= "Warning: Check if your weapon is correctly equipped."
L.GEAR_FISHING_POLE						= "Fishing Pole"

L.ACHIEVEMENT_TIMER_SPEED_KILL			= "Achievement"--BATTLE_PET_SOURCE_6

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS = {
	you									= "%s on YOU",
	target								= "%s on >%%s<",
	targetsource						= ">%%s< cast %s on >%%s<",
	targetcount							= "%s (%%s) on >%%s<",
	spell								= "%s", -- OPTIONAL
	spellsource							= ">%%s< cast %s",
	incoming							= "%s incoming debuff",
	incomingcount						= "%s incoming debuff (%%s)",
	ends 								= "%s ended",
	endtarget							= "%s ended: >%%s<",
	fades								= "%s faded",
	addsleft							= "%s remaining: %%d",
	cast								= "Casting %s: %.1f sec",
	soon								= "%s soon",
	sooncount							= "%s (%%s) soon",
	countdown							= "%s in %%ds",
	prewarn								= "%s in %s",
	bait								= "%s soon - bait now",
	stage								= "Stage %s",
	prestage							= "Stage %s soon",
	count								= "%s (%%s)", -- OPTIONAL
	stack								= "%s on >%%s< (%%d)",
	moveto								= "%s - move to >%%s<"
}

local prewarnOption						= "Show pre-warning for $spell:%s"
L.AUTO_ANNOUNCE_OPTIONS = {
	you									= "Announce when $spell:%s on you",
	target								= "Announce $spell:%s targets",
	targetNF							= "Announce $spell:%s targets (ignores global target filter)",
	targetsource						= "Announce $spell:%s targets (with source)",
	targetcount							= "Announce $spell:%s targets (with count)",
	spell								= "Announce when $spell:%s has been cast",
	spellsource							= "Announce when $spell:%s has been cast (with source)",
	incoming							= "Announce when $spell:%s has incoming debuffs",
	incomingcount						= "Announce (with count) when $spell:%s has incoming debuffs",
	ends								= "Announce when $spell:%s has ended",
	endtarget							= "Announce when $spell:%s has ended (with target)",
	fades								= "Announce when $spell:%s has faded",
	addsleft							= "Announce how many $spell:%s remain",
	cast								= "Announce when $spell:%s begins casting",
	soon								= prewarnOption,
	sooncount							= prewarnOption,
	countdown							= "Show pre-warning countdown spam for $spell:%s",
	prewarn 							= prewarnOption,
	bait								= "Show pre-warning (to bait) for $spell:%s",
	stage								= "Announce Stage %s",
	stagechange							= "Announce stage changes",
	prestage							= "Show a prewarning for Stage %s",
	count								= "Announce when $spell:%s has been cast (with count)",
	stack								= "Announce $spell:%s stacks",
	moveto								= "Announce when to move to someone or some place for $spell:%s"
}

L.AUTO_SPEC_WARN_TEXTS = {
	spell								= "%s!", -- OPTIONAL
	ends								= "%s ended",
	fades								= "%s faded",
	soon								= "%s soon",
	sooncount							= "%s (%%s) soon",
	bait								= "%s soon - bait now",
	prewarn								= "%s in %s",
	dispel								= "%s on >%%s< - dispel now",
	interrupt							= "%s - interrupt >%%s<!",
	interruptcount						= "%s - interrupt >%%s<! (%%d)",
	you									= "%s on you",
	youcount							= "%s (%%s) on you",
	youpos								= "%s (Position: %%s) on you",
	youposcount							= "%s (%%s) (Position: %%s) on you",
	soakpos								= "%s (Soak Position: %%s)",
	target								= "%s on >%%s<",
	targetcount							= "%s (%%s) on >%%s< ",
	defensive							= "%s - defensive",
	taunt								= "%s on >%%s< - taunt now",
	close								= "%s on >%%s< near you",
	move								= "%s - move away",
	keepmove							= "%s - keep moving",
	stopmove							= "%s - stop moving",
	dodge								= "%s - dodge attack",
	dodgecount							= "%s (%%s) - dodge attack",
	dodgeloc							= "%s - dodge from %%s",
	moveaway							= "%s - move away from others",
	moveawaycount						= "%s (%%s) - move away from others",
	moveawaytarget						= "%s - move away from %%s",
	moveto								= "%s - move to >%%s<",
	soak								= "%s - soak it",
	soakcount							= "%s - soak (%%s)",
	jump								= "%s - jump",
	run									= "%s - run away",
	runcount							= "%s - run away (%%s)",
	cast								= "%s - stop casting",
	lookaway							= "%s on %%s - look away",
	reflect								= "%s on >%%s< - stop attacking",
	count								= "%s! (%%s)", -- OPTIONAL
	stack								= "%%d stacks of %s on you",
	switch								= "%s - switch targets",
	switchcount							= "%s - switch targets (%%s)",
	switchcustom						= "%s - switch targets (%%s)",
	gtfo								= "%%s damage - move away",
	adds								= "Incoming Adds - switch targets",--Basically a generic of switch
	addscount							= "Incoming Adds - switch targets (%%s)",--Basically a generic of switch
	addscustom							= "Incoming Adds - %%s",--Same as above, but more info, pretty much made for like 3 boss mods, such as akama
	targetchange						= "Target Change - switch to %%s"
}

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS = {
	spell 								= "Show special announce for $spell:%s",
	ends 								= "Show special announce when $spell:%s has ended",
	fades 								= "Show special announce when $spell:%s has faded",
	soon 								= "Show pre-special announce for $spell:%s",
	sooncount							= "Show pre-special announce (with count) for $spell:%s",
	bait								= "Show pre-special announce (to bait) for $spell:%s",
	prewarn 							= "Show pre-special announce %s seconds before $spell:%s",
	dispel 								= "Show special announce to dispel $spell:%s",
	interrupt							= "Show special announce to interrupt $spell:%s",
	interruptcount						= "Show special announce (with count) to interrupt $spell:%s",
	you 								= "Show special announce when you are affected by $spell:%s",
	youcount							= "Show special announce (with count) when you are affected by $spell:%s",
	youpos								= "Show special announce (with position) when you are affected by $spell:%s",
	youposcount							= "Show special announce (with position and count) when you are affected by $spell:%s",
	soakpos								= "Show special announce (with position) to help soak others affected by $spell:%s",
	target 								= "Show special announce when someone is affected by $spell:%s",
	targetcount 						= "Show special announce (with count) when someone is affected by $spell:%s",
	defensive 							= "Show special announce to use defensive abilites for $spell:%s",
	taunt 								= "Show special announce to taunt when other tank affected by $spell:%s",
	close 								= "Show special announce when someone close to you is affected by $spell:%s",
	move 								= "Show special announce to move out from $spell:%s",
	keepmove 							= "Show special announce to keep moving for $spell:%s",
	stopmove 							= "Show special announce to stop moving for $spell:%s",
	dodge 								= "Show special announce to dodge $spell:%s",
	dodgecount							= "Show special announce (with count) to dodge $spell:%s",
	dodgeloc							= "Show special announce (with location) to dodge $spell:%s",
	moveaway							= "Show special announce to move away from others for $spell:%s",
	moveawaycount						= "Show special announce (with count) to move away from others for $spell:%s",
	moveawaytarget						= "Show special announce (with target) to move away from others for $spell:%s",
	moveto								= "Show special announce to move to someone or some place for $spell:%s",
	soak								= "Show special announce to soak for $spell:%s",
	soakcount							= "Show special announce (with count) to soak for $spell:%s",
	jump								= "Show special announce to move to jump for $spell:%s",
	run 								= "Show special announce to run away from $spell:%s",
	runcount							= "Show special announce (with count) to run away from $spell:%s",
	cast 								= "Show special announce to stop casting for $spell:%s",--Spell Interrupt
	lookaway							= "Show special announce to look away for $spell:%s",
	reflect 							= "Show special announce to stop attacking $spell:%s",--Spell Reflect
	count 								= "Show special announce (with count) for $spell:%s",
	stack 								= "Show special announce when you are affected by >=%d stacks of $spell:%s",
	switch								= "Show special announce to switch targets for $spell:%s",
	switchcount							= "Show special announce (with count) to switch targets for $spell:%s",
	switchcustom						= "Show special announce (with info) to switch targets for $spell:%s",
	gtfo 								= "Show special announce to move out of bad stuff on ground",
	adds								= "Show special announce to switch targets for incoming adds",
	addscount							= "Show special announce (with count) to switch targets for incoming adds",
	addscustom							= "Show special announce for incoming adds",
	targetchange						= "Show special announce for priority target changes"
}

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS = {
	target								= "%s: %%s", -- OPTIONAL
	targetcount							= "%s (%%2$s): %%1$s", -- OPTIONAL
	cast								= "%s", -- OPTIONAL
	castcount							= "%s (%%s)", -- OPTIONAL
	castsource							= "%s: %%s", -- OPTIONAL
	active								= "%s ends",--Buff/Debuff/event on boss
	fades								= "%s fades",--Buff/Debuff on players
	ai									= "%s AI",

	cd									= "%s",--Now same as next, as the ~ was moved to timer number -- OPTIONAL
	cdcount								= "%s (%%s)",--Now same as next, as the ~ was moved to timer number -- OPTIONAL
	cdsource							= "%s: >%%s<",--Now same as next, as the ~ was moved to timer number -- OPTIONAL
	cdspecial							= "Special",--Now same as next, as the ~ was moved to timer number
	cdcombo								= "%%1$s + %%2$s",--Now same as next, as the ~ was moved to timer number -- OPTIONAL

	next								= "%s", -- OPTIONAL
	nextcount							= "%s (%%s)", -- OPTIONAL
	nextsource							= "%s: >%%s<", -- OPTIONAL
	nextspecial							= "Special",
	nextcombo							= "%%1$s + %%2$s",--Now same as next, as the ~ was moved to timer number -- OPTIONAL

	achievement							= "%s", -- OPTIONAL
	stage								= "Stage",
	stagecount							= "Stage %%s",--NOT BUGGED, stage is 2nd arg, spellID is ignored on purpose
	stagecountcycle						= "Stage %%s (%%s)",--^^. Example: Stage 2 (3) for a fight that alternates stage 1 and stage 2, but also tracks total cycles
	stagecontext						= "%s", -- OPTIONAL
	stagecontextcount					= "%s (%%s)", -- OPTIONAL
	intermission						= "Intermission",
	intermissioncount					= "Intermission %%s",
	adds								= "Adds",
	addscustom							= "Adds (%%s)",
	roleplay							= GUILD_INTEREST_RP or "Roleplay",--Used mid fight, pre fight, or even post fight. Boss does NOT auto engage upon completion
	combat								= "Combat starts"--Only used if the boss auto engages upon completion (ie ragnaros type situation)
}
--This basically clones np only bar option and display text from regular counterparts
L.AUTO_TIMER_TEXTS.cdnp = L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextnp = L.AUTO_TIMER_TEXTS.next -- OPTIONAL
L.AUTO_TIMER_TEXTS.cdcountnp = L.AUTO_TIMER_TEXTS.cdcount -- OPTIONAL
L.AUTO_TIMER_TEXTS.nextcountnp = L.AUTO_TIMER_TEXTS.nextcount -- OPTIONAL

L.AUTO_TIMER_OPTIONS = {
	target								= "Show timer for $spell:%s debuff",
	targetcount							= "Show timer (with count) for $spell:%s debuff",
	cast								= "Show timer for $spell:%s cast",
	castcount							= "Show timer (with count) for $spell:%s cast",
	castsource							= "Show timer (with source) for $spell:%s cast",
	active								= "Show timer for $spell:%s duration",
	fades								= "Show timer for when $spell:%s fades from players",
	ai									= "Show AI timer for $spell:%s cooldown",
	cd									= "Show timer for $spell:%s cooldown",
	cdcount								= "Show timer for $spell:%s cooldown",
	cdnp								= "Show nameplate only timer for $spell:%s cooldown",
	cdnpcount							= "Show nameplate only timer (with count) for $spell:%s cooldown",
	cdsource							= "Show timer (with source) for $spell:%s cooldown",--Maybe better wording?
	cdspecial							= "Show timer for special ability cooldown",
	cdcombo								= "Show timer for ability combo cooldown",--Used for combining 2 abilities into a single timer
	next								= "Show timer for next $spell:%s",
	nextcount							= "Show timer for next $spell:%s",
	nextnp								= "Show nameplate only timer for next $spell:%s",
	nextnpcount							= "Show nameplate only timer (with count) for next $spell:%s",
	nextsource							= "Show timer (with source) for next $spell:%s",--Maybe better wording?
	nextspecial							= "Show timer for next special ability",
	nextcombo							= "Show timer for next ability combo",--Used for combining 2 abilities into a single timer
	achievement							= "Show timer for %s",
	stage								= "Show timer for next stage",
	stagecount							= "Show timer (with count) for next stage",
	stagecountcycle						= "Show timer (with stage count and cycle count) for next stage",
	stagecontext						= "Show timer for next $spell:%s stage",
	stagecontextcount					= "Show timer (with count) for next $spell:%s stage",
	intermission						= "Show timer for next intermission",
	intermissioncount					= "Show timer (with count) for next intermission",
	adds								= "Show timer for incoming adds",
	addscustom							= "Show timer for incoming adds",
	roleplay							= "Show timer for roleplay duration",--This does need localizing though.
	combat								= "Show timer for combat start"
}

L.AUTO_ICONS_OPTION_TARGETS				= "Set icons on $spell:%s targets"--Usually used for player targets with no specific sorting
L.AUTO_ICONS_OPTION_TARGETS_TANK_A		= "Set icons on $spell:%s targets with tank over melee over ranged priority and alphabetical fallback"
L.AUTO_ICONS_OPTION_TARGETS_TANK_R		= "Set icons on $spell:%s targets with tank over melee over ranged priority and raid roster fallback"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A		= "Set icons on $spell:%s targets with melee and alphabetical priority"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R		= "Set icons on $spell:%s targets with melee and raid roster priority"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A	= "Set icons on $spell:%s targets with ranged and alphabetical priority"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R	= "Set icons on $spell:%s targets with ranged and raid roster priority"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA		= "Set icons on $spell:%s targets with alphabetical priority"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER		= "Set icons on $spell:%s targets with raid roster priority"
L.AUTO_ICONS_OPTION_NPCS				= "Set icons on $spell:%s"--usually used for npcs/mobs
L.AUTO_ICONS_OPTION_CONFLICT			= " (May conflict with other options)"

L.AUTO_ARROW_OPTION_TEXT				= "Show " .. L.DBM .. " Arrow to move toward target affected by $spell:%s"
L.AUTO_ARROW_OPTION_TEXT2				= "Show " .. L.DBM .. " Arrow to move away from target affected by $spell:%s"
L.AUTO_ARROW_OPTION_TEXT3				= "Show " .. L.DBM .. " Arrow to move toward specific location for $spell:%s"

L.AUTO_YELL_OPTION_TEXT = {
	shortyell							= "Yell when you are affected by $spell:%s",
	yell								= "Yell (with player name) when you are affected by $spell:%s",
	count								= "Yell (with count) when you are affected by $spell:%s",
	fade								= "Yell (with countdown and spell name) when $spell:%s is fading",
	shortfade							= "Yell (with countdown) when $spell:%s is fading",
	iconfade							= "Yell (with countdown and icon) when $spell:%s is fading",
	position							= "Yell (with position and player name) when you are affected by $spell:%s",
	shortposition						= "Yell (with position) when you are affected by $spell:%s",
	combo								= "Yell (with custom text) when you are affected by $spell:%s and other spells at same time",
	repeatplayer						= "Yell repeatedly (with player name) when you are affected by $spell:%s",
	repeaticon							= "Yell repeatedly (with icon) when you are affected by $spell:%s",
	icontarget							= "Yell icons when you are targeted by $spell:%s to warn others",
}
L.AUTO_YELL_ANNOUNCE_TEXT = {
	shortyell							= "%s", -- OPTIONAL
	yell								= "%s on " .. UnitName("player"),
	count								= "%s on " .. UnitName("player") .. " (%%d)",
	fade								= "%s fading in %%d",
	shortfade							= "%%d", -- OPTIONAL
	iconfade							= "{rt%%2$d}%%1$d", -- OPTIONAL
	position 							= "%s %%s on {rt%%d}" ..UnitName("player").. "{rt%%d}",
	shortposition 						= "{rt%%1$d}%s %%2$d",--Icon, Spellname, number -- OPTIONAL
	combo								= "%s and %%s",--Spell name (from option, plus spellname given in arg)
	repeatplayer						= UnitName("player"),--Doesn't need translation, it's just player name spam -- OPTIONAL
	repeaticon							= "{rt%%1$d}",--Doesn't need translation. It's just icon spam -- OPTIONAL
	icontarget							= "{rt%%1$d}{rt%%1$d}{rt%%1$d}",--Doesn't need translation. It's just an icon repeated 3 times-- OPTIONAL
}
L.AUTO_YELL_CUSTOM_POSITION				= "{rt%d}%s"--Doesn't need translating. Has no strings (Used in niche situations such as icon repeat yells) -- OPTIONAL
L.AUTO_YELL_CUSTOM_FADE					= "%s faded"
L.AUTO_HUD_OPTION_TEXT					= "Show HudMap for $spell:%s (Retired)"
L.AUTO_HUD_OPTION_TEXT_MULTI			= "Show HudMap for various mechanics (Retired)"
L.AUTO_NAMEPLATE_OPTION_TEXT			= "Show Nameplate Auras for $spell:%s using compatible nameplate addon or "..L.DBM
L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED		= "Show Nameplate Auras for $spell:%s using only "..L.DBM
L.AUTO_RANGE_OPTION_TEXT				= "Show range frame (%s) for $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
L.AUTO_RANGE_OPTION_TEXT_SHORT			= "Show range frame (%s)"--For when a range frame is just used for more than one thing
L.AUTO_RRANGE_OPTION_TEXT				= "Show reverse range frame (%s) for $spell:%s"--Reverse range frame (green when players in range, red when not)
L.AUTO_RRANGE_OPTION_TEXT_SHORT			= "Show reverse range frame (%s)"
L.AUTO_INFO_FRAME_OPTION_TEXT			= "Show info frame for $spell:%s"
L.AUTO_INFO_FRAME_OPTION_TEXT2			= "Show info frame for encounter overview"
L.AUTO_INFO_FRAME_OPTION_TEXT3			= "Show info frame for $spell:%s (when threshold of %%s is met)"
L.AUTO_READY_CHECK_OPTION_TEXT			= "Play ready check sound when boss is pulled (even if it's not targeted)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT			= "Show timer for fastest clear of %s"
L.AUTO_PRIVATEAURA_OPTION_TEXT			= "Play DBM sound alerts for $spell:%s private auras on this fight."

L.AUTO_GOSSIP_BUFFS						= "Auto select gossip choice(s) for npc or profession buffs"
L.AUTO_GOSSIP_PERFORM_ACTION			= "Auto select gossip choice(s) to perform actions (such as using transports)"
L.AUTO_GOSSIP_START_ENCOUNTER			= "Auto select gossip choice to start encounter"--This will never need to be plural, since it won't be in a trash mod like other two

-- New special warnings
L.MOVE_WARNING_BAR						= "Announce movable"
L.MOVE_WARNING_MESSAGE					= "Thanks for using " .. L.DEADLY_BOSS_MODS
L.MOVE_SPECIAL_WARNING_BAR				= "Special warning movable"
L.MOVE_SPECIAL_WARNING_TEXT				= "Special Warning"

L.HUD_INVALID_TYPE						= "Invalid HUD type defined"
L.HUD_INVALID_TARGET					= "No valid target given for HUD"
L.HUD_INVALID_SELF						= "Cannot use self as target for HUD"
L.HUD_INVALID_ICON						= "Cannot use icon method for HUD on a target with no icon"
L.HUD_SUCCESS							= "HUD successful started with your parameters. This will cancel after %s, or by calling '/dbm hud hide'."
L.HUD_USAGE								= {
	L.DBM .. "-HudMap usage:",
	"-----------------",
	"/dbm hud <type> <target> <duration>: Creates a HUD that points to a player for the desired duration",
	"Valid types: arrow, dot, red, blue, green, yellow, icon (requires a target with raid icon)",
	"Valid targets: target, focus, <playername>",
	"Valid durations: any number (in seconds). If left blank, 20min will be used.",
	"/dbm hud hide: disables user generated HUD objects"
}

L.ARROW_MOVABLE							= "Arrow movable"
L.ARROW_WAY_USAGE						= "/dway <x> <y>: Creates an arrow that points to a specific location (using local zone map coordinates)"
L.ARROW_WAY_SUCCESS						= "To hide arrow, do '/dbm arrow hide' or reach arrow"
L.ARROW_ERROR_USAGE						= {
	L.DBM .. "-Arrow usage:",
	"-----------------",
	"/dbm arrow <x> <y>: Creates an arrow that points to a specific location (using world coordinates)",
	"/dbm arrow map <x> <y>: Creates an arrow that points to a specific location (using zone map coordinates)",
	"/dbm arrow <player>: Creates and arrow that points to a specific player in your party or raid (case sensitive!)",
	"/dbm arrow hide: Hides the arrow",
	"/dbm arrow move: Makes the arrow movable"
}

L.SPEED_KILL_TIMER_TEXT					= "Record Victory"
L.SPEED_CLEAR_TIMER_TEXT				= "Best Clear"
L.COMBAT_RES_TIMER_TEXT					= "Next CR Charge"
L.TIMER_RESPAWN							= "%s Respawn"

L.LAG_CHECKING							= "Checking raid Latency... "
L.LAG_HEADER							= L.DEADLY_BOSS_MODS.. " - Latency Results"
L.LAG_ENTRY								= "%s: World delay [%d ms] / Home delay [%d ms]"
L.LAG_FOOTER							= "No Response: %s"

L.DUR_CHECKING							= "Checking raid Durability... "
L.DUR_HEADER							= L.DEADLY_BOSS_MODS.. " - Durability Results"
L.DUR_ENTRY								= "%s: Durability [%d percent] / Gear broken [%s]"

L.OVERRIDE_ACTIVATED					= "Configuration overrides have been activated for this encounter by RL"

--LDB
L.LDB_TOOLTIP_HELP1						= "Click to open " .. L.DBM
L.LDB_TOOLTIP_HELP2						= "Alt+right click to toggle Silent Mode"
L.SILENTMODE_IS							= "SilentMode is "

L.WORLD_BUFFS = {
	hordeOny							= "People of the Horde, citizens of Orgrimmar, come, gather round and celebrate a hero of the Horde",
	allianceOny							= "Citizens and allies of Stormwind, on this day, history has been made.",
	hordeNef							= "NEFARIAN IS SLAIN! People of Orgrimmar",
	allianceNef							= "Citizens of the Alliance, the Lord of Blackrock is slain!",
	zgHeart								= "Now, only one step remains to rid us of the Soulflayer's threat",
	zgHeartBooty						= "The Blood God, the Soulflayer, has been defeated!  We are imperiled no longer!",
	zgHeartYojamba						= "Begin the ritual, my servants.  We must banish the heart of Hakkar back into the void!",
	rendHead							= "The false Warchief, Rend Blackhand, has fallen!",
	blackfathomBoon						= "boon of Blackfathom"
}

-- Annoying popup, especially for classic players
L.DBM_INSTALL_REMINDER_HEADER	= "Incomplete DBM installation detected!"
L.DBM_INSTALL_REMINDER_EXPLAIN	= "Welcome to %s. DBM mods for bosses here are in the %s which you do not have installed. DBM will not show timers or warnings in this zone unless you install the %s!"
L.DBM_INSTALL_REMINDER_DISABLE	= "Disable all DBM warnings and timers in this zone." -- Used when we believe it's a user error that the mod isn't installed (i.e., current raids)
L.DBM_INSTALL_REMINDER_DISABLE2 = "Do not show this message again for this package." -- Used for unimportant mods, i.e., dungeons
L.DBM_INSTALL_REMINDER_DL_WAGO	= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy the Wago.io link to your clipboard."
L.DBM_INSTALL_REMINDER_DL_CURSE	= "Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " to copy the Curseforge link to your clipboard."
--"Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "
L.DBM_INSTALL_PACKAGE_VANILLA	= "Vanilla and Season of Discovery package"
L.DBM_INSTALL_PACKAGE_WRATH		= "Wrath package"
L.DBM_INSTALL_PACKAGE_CATA		= "Cataclysm package"
L.DBM_INSTALL_PACKAGE_DUNGEON	= "Dungeons, Delves, and Events package"
