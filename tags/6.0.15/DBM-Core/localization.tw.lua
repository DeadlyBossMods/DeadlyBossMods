if GetLocale() ~= "zhTW" then return end

DBM_CORE_NEED_SUPPORT				= "你是否擁有良好的程式開發或語言能力? 如果是的話, DBM團隊真的需要你的幫助以保持成為WOW裡最佳的首領模組。觀看 www.deadlybossmods.com 或發送郵件到 tandanu@deadlybossmods.com 或 nitram@deadlybossmods.com 來加入團隊。"
DBM_CORE_NEED_LOGS					= "DBM需要Transcriptor (http://www.wowace.com/addons/transcriptor/) 去紀錄測試伺服器的戰鬥紀錄讓插件更加完美。如果你願意幫忙，請使用transcriptor去紀錄這些戰鬥過程然後將記錄發佈在http://forums.elitistjerks.com/topic/132677-deadly-boss-mods-60-testing/ (請壓縮這些紀錄檔，這些檔案會很龐大)。僅需要6.0的團隊戰鬥紀錄，不需要五人副本的紀錄。"
DBM_HOW_TO_USE_MOD					= "歡迎使用DBM。在聊天頻道輸入 /dbm 打開設定開始設定。你可以載入特定區域後為任何首領設定你喜歡的特別設置。DBM會在第一次啟動時嘗試掃描你的職業天賦，但有些選項你可能想打開。"

DBM_FORUMS_MESSAGE					= "發現臭蟲或錯誤的計時器?你希望要讓某些模組有新的警告，計時器或是特別功能?\nDeadly Boss Mods討論，臭蟲回報與功能要求論壇 |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (你可以點擊連結去複製網址)"
DBM_FORUMS_COPY_URL_DIALOG			= "來拜訪我們新的討論與支援論壇\r\n(代管於Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "載入%s模組時發生錯誤：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功載入%s模組。輸入/dbm或/dbm help有更多選項。"
DBM_CORE_LOAD_MOD_COMBAT			= "延遲載入'%s'直到離開戰鬥"
DBM_CORE_LOAD_GUI_ERROR				= "無法載入圖形介面：%s"
DBM_CORE_LOAD_GUI_COMBAT			= "圖形介面不能在戰鬥中初始化。圖形介面將在脫離戰鬥後自動讀取，這樣就能夠再次在戰鬥中使用。"
DBM_CORE_LOAD_SKIN_COMBAT			= "DBM計時條在戰鬥中套用外觀失敗。你的計時條可能不能正常作用而可能會導致錯誤。這常發生在使用第三方插件試著在戰鬥中套用外觀。建議在脫離戰鬥後reloadui。"
DBM_CORE_BAD_LOAD					= "DBM偵測到你的此副本的模組在戰鬥中讀取失敗。一旦脫離戰鬥，請立即輸入/consoel reloadui重新載入。"
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s不能被讀取因為你的DBM核心未達需求，請更新版本。"

DBM_CORE_BLIZZ_BUGS					= "6.0中的暴雪插件改變：\n1. 如果你開啟音效設定，你可能會在戰鬥中失去插件的音效，插件的聲音優先權較低而且遊戲同時放出的音效數量超過你最大聲音頻道的值，DBM現在會自動強制設定聲音頻道的值為64。如果依舊有此類問題發生，請將'音效'完全禁用。"

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM已中禁用動態距離框架，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM已中禁用小怪計數警告，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM已中禁用多項功能，你目前的團隊人數在這場戰鬥中的機制資訊不足。"

DBM_CORE_LOOT_SPEC_REMINDER			= "你目前的專精為:%s。而你目前的拾取選擇為:%s。"

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM偵測到你同時開啟BigWigs和DBM的團隊圖示。請關閉其中之一的團隊圖示功能以免與你的隊伍隊長產生衝突。"

DBM_CORE_PROVINGGROUNDS_AD			= "試煉之地DBM-ProvingGrounds的DBM插件已經可供使用。你可以在deadlybossmods.com或Curse上找到。此訊息只會顯示一次。"

DBM_CORE_MOLTENCORE_AD				= "熔火之心DBM-MC的DBM插件已經可供使用。你可以在deadlybossmods.com或Curse上找到。此訊息只會顯示一次。."

DBM_CORE_COMBAT_STARTED				= "%s開戰。祝好運與盡興! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "與%s開戰已進行的戰鬥。祝好運與盡興! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "公會已跟%s開戰"
DBM_CORE_SCENARIO_STARTED			= "%s開始。祝好運與盡興! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "加入進行中的%s。祝好運與盡興! :)"
DBM_CORE_BOSS_DOWN					= "擊敗%s，用了%s!"
DBM_CORE_BOSS_DOWN_I				= "擊敗%s!你已勝利了%d次。"
DBM_CORE_BOSS_DOWN_L				= "擊敗%s!本次用了%s，上次用了%s，最快紀錄為%s。你總共戰勝了%d次。"
DBM_CORE_BOSS_DOWN_NR				= "擊敗%s!用了%s! 這是一個新記錄! (舊紀錄為%s) 你總共戰勝了%d次。"
DBM_CORE_GUILD_BOSS_DOWN			= "公會已擊敗%s，用了%s!"
DBM_CORE_SCENARIO_COMPLETE			= "%s完成!用了%s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "%s完成! 你總共完成了%d次。"
DBM_CORE_SCENARIO_COMPLETE_L		= "%s完成!本次用了%s，上次用了%s，最快紀錄為%s。你總共完成了%d次。"
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s完成!用了%s! 這是一個新記錄! (舊紀錄為%s) 你總共完成了%d次。"
DBM_CORE_COMBAT_ENDED_AT			= "%s(%s)的戰鬥經過%s結束。"
DBM_CORE_COMBAT_ENDED_AT_LONG		= "%s(%s)的戰鬥經過%s結束。你在這個難度總共滅團了%d次。"
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "公會在%s (%s)的戰鬥滅團，經過%s."
DBM_CORE_SCENARIO_ENDED_AT			= "%s結束!用了%s!"
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s結束!本次用了%s，你已有共%d次未完成的嘗試在這個難度裡。"
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s的戰鬥在%s前開始，恢復計時器中..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Transcriptor開始記錄。"
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Transcriptor結束紀錄。"

DBM_CORE_PROFILE_NOT_FOUND			= "<Deadly Boss Mods>你目前的配置檔已經損毀。DBM會載入'Default'配置檔。"
DBM_CORE_PROFILE_CREATED			= "配置檔'%s'已建立。"
DBM_CORE_PROFILE_CREATE_ERROR		= "建立配置檔失敗，無效的配置檔名稱。"
DBM_CORE_PROFILE_CREATE_ERROR_D		= "建立配置檔失敗，配置檔'%s'已存在。"
DBM_CORE_PROFILE_APPLIED			= "配置檔'%s'已套用。"
DBM_CORE_PROFILE_APPLY_ERROR		= "套用配置檔失敗，配置檔'%s'不存在。"
DBM_CORE_PROFILE_COPIED				= "配置檔'%s'已複製。"
DBM_CORE_PROFILE_COPY_ERROR			= "複製配置檔失敗，配置檔'%s'不存在。"
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "不能複製配置檔到本身來源。"
DBM_CORE_PROFILE_DELETED			= "配置檔'%s'已刪除。配置檔'Default'會被套用。"
DBM_CORE_PROFILE_DELETE_ERROR		= "刪除配置檔失敗，配置檔'%s'不存在。"
DBM_CORE_PROFILE_CANNOT_DELETE		= "不能刪除'Default'配置檔。"
DBM_CORE_MPROFILE_COPY_SUCCESS		= "%s's (%d專精)模組設定已被複製。"
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "不能複製角色設定到本身來源"
DBM_CORE_MPROFILE_COPY_S_ERROR		= "配置檔來源已經損毀，設定不能被複製或是部分複製，複製已失敗。"
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "%s's (%d專精)模組音效設定已被複製。"
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "不能複製角色音效設定到本身來源"
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "配置檔來源已經損毀，音效設定不能被複製或是部分複製，複製已失敗。"
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "%s's (%d專精)模組設定已被刪除。"
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "不能刪除使用中的模組設定。"
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "配置檔來源已經損毀，設定不能被刪除或是部分刪除，刪除已失敗。"

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "此副本所有的選項設定已套用預設值。"
DBM_CORE_ALLMOD_STATS_RESETED		= "所有模組狀態已經被重置。"
DBM_CORE_MOD_DEFAULT_LOADED			= "此戰鬥的預設選項已套用。"

DBM_CORE_WORLDBOSS_ENGAGED			= "在你的伺服器上的%s已在百分之%s時開戰(%s發送)。"
DBM_CORE_WORLDBOSS_DEFEATED			= "在你的伺服器上的%s已被擊敗(%s發送)。"

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分鐘"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN						= "分"
DBM_CORE_MIN_FMT					= "%d分"
DBM_CORE_SEC						= "秒"
DBM_CORE_SEC_FMT					= "%s秒"

DBM_CORE_GENERIC_WARNING_OTHERS		= "與一個其他"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "與其他%d"
DBM_CORE_GENERIC_WARNING_BERSERK	= "%s%s後狂暴"
DBM_CORE_GENERIC_TIMER_BERSERK		= "狂暴"
DBM_CORE_OPTION_TIMER_BERSERK		= "為$spell:26662顯示計時器"
DBM_CORE_GENERIC_TIMER_COMBAT		= "戰鬥開始"
DBM_CORE_OPTION_TIMER_COMBAT		= "為戰鬥開始顯示計時器"
DBM_CORE_OPTION_HEALTH_FRAME		= "顯示首領血量框架"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "計時器"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "一般提示"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "個人提示"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "目標提示"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "角色專精提示"
DBM_CORE_OPTION_CATEGORY_SOUNDS			= "音效"

DBM_CORE_AUTO_RESPONDED						= "已自動回覆密語。"
DBM_CORE_STATUS_WHISPER						= "%s：%s，%d/%d存活。"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s正在與%s交戰（當前%s，%d/%d存活）"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s已經擊敗%s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s已經擊敗%s! 他們總共已擊殺了%d次。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s在%s還有%s時滅團了。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s在%s還有%s時滅團了。他們在這個難度總共滅團了%d次。"
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s忙碌於%s(%d/%d存活)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s已經完成%s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s已經完成%s!他們總共有%d次勝利。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s未完成%s。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s未完成%s。他們在這個難度總共未完成%d次。"

DBM_CORE_VERSIONCHECK_HEADER		= "Boss Mods - 版本檢測"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s：%s (r%d) %s"
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s：%s (r%d) & %s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：尚未安裝任何團隊首領模組"
DBM_CORE_VERSIONCHECK_FOOTER		= "找到有%d玩家正在使用DBM且有%d玩家正在使用Bigwigs"
DBM_CORE_VERSIONCHECK_OUTDATED		= "下列有%d玩家正在使用過期的首領模組:%s"
DBM_CORE_YOUR_VERSION_OUTDATED		= "你的 Deadly Boss Mod 已經過期。請到http://dev.deadlybossmods.com下載最新版本。"
DBM_CORE_OUTDATED_PVP_MODS			= "你的DBM-PvP模組已經過期而且如果不使用請移除,或是更新最新的獨立包. 這些模組不在包含在DBM-Core下載. 尋找最新的PVP模組在http://www.deadlybossmods.com"
DBM_CORE_VOICE_PACK_OUTDATED		= "你的DBM語音包缺少在這個版本的DBM需要的語音。特別警告音效篩選器已經被關閉。請下載新版本的語音包或是聯絡語音包作者更新並加入缺少的語音。"
DBM_CORE_VOICE_MISSING				= "DBM找不到你所選取的語音包。你的語音包選項已經被重置為'None'。請確定你的語音包已正確的安裝與啟用。"
DBM_CORE_VOICE_COUNT_MISSING		= "所選取的語音包%d找不到倒數語音。設定已被重置回預設值。"
--DBM_BIG_WIGS (Same as English locales)
--DBM_BIG_WIGS_ALPHA (Same as English locales)

DBM_CORE_UPDATEREMINDER_HEADER			= "你的Deadly Boss Mod已經過期。\n你可以在Curse網站或是wowinterface網站以及此網址下載到新版本%s(r%d)："
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "你的alpha版本Deadly Boss Mods已經過期。\n 你至少落後%d個測試版本。建議DBM使用者使用最新的alpha或最新的穩定版本。過期的alpha版本可能會有效能低落或未完成的功能。"
DBM_CORE_UPDATEREMINDER_FOOTER			= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製下載網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_DISABLE			= "警告: 你的DBM版本已大幅度的過期(至少過期%d個版本)，DBM已被禁用了除非更新至最新版本。這是為了確保舊而不相容的程式碼不會對你而團隊夥伴造成低落的遊戲體驗。"
DBM_CORE_UPDATEREMINDER_HOTFIX			= "你的DBM版本會在這首領戰鬥有不準確的計時器或警告。這問題已被修正在新版正式版(或是更新到最新的alpha如果新版正式版還未釋出。)"
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "警告:你的DBM已經過期，DBM已被禁用直到你更新至最新版，因為遊戲大改版。為了不讓舊的程式碼拖累遊戲體驗。請至deadlybossmods.com或是curse下載最新版本的DBM。如果你在6.0 beta看到此訊息，請到http://forums.elitistjerks.com/topic/132677-deadly-boss-mods-60-testing下載6.0 beta插件"
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "警告:你使用的DBM版本和遊戲版本不相容。請到deadlybossmods.com或是curse下載符合你遊戲版本的DBM。"
DBM_CORE_VEM							= "警告:你同時使用DBM和VEM。DBM將停用而無法執行。"
DBM_CORE_3RDPROFILES					= "警告:DBM-Profiles不相容此版本DBM。請移除避免衝突。"

DBM_CORE_MOVABLE_BAR				= "拖動我!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h向你發送了一個倒數計時：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消該計時]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略來自%1$s的計時]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在該次遊戲連結中忽略來自%s的計時？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <時間（秒）> <文字>。<時間>必須大於1"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+左鍵或右鍵點擊即可移動，Alt+Shift+點擊即可拖放"

DBM_CORE_RANGECHECK_HEADER			= "距離監視(%d碼)"
DBM_CORE_RANGECHECK_SETRANGE		= "設置距離"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "設置玩家數量門檻"
DBM_CORE_RANGECHECK_SOUNDS			= "音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "當一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "當多於一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_0			= "沒有音效"
DBM_CORE_RANGECHECK_SOUND_1			= "預設音效"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鳴聲"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d碼"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "框架"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "顯示雷達框架"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "顯示文字框"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "兩者都顯示"
DBM_CORE_RANGERADAR_HEADER			= "距離:%d玩家(%d)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d在範圍內(%d碼)"--Multi
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s(%0.1f碼)"--One target

DBM_CORE_INFOFRAME_SHOW_SELF		= "總是顯示你的能量"

DBM_LFG_INVITE						= "地城準備確認"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/range <數字> or /distance <數字>: 顯示距離框架。/rrange 或 /rdistance 顯示相反色。",
	"/dbm version：進行團隊範圍內的版本檢測（也可使用：ver）。",
	"/dbm unlock：顯示一個可移動的計時器（也可使用：move）。",
	"/dbm timer/ctimer/ltimer/cltimer <x> <文字>：開始一個以<文字>為名稱的時間為<x>秒的計時器。",
	"/dbm broadcast timer <x> <文字>：向團隊廣播一個以<文字>為名稱，時間為<x>秒的計時器（需要團隊隊長或助理權限）。",
	"/dbm timer endloop：停止任何無限循環的計時器。",
	"/dbm break <分鐘>: 開始休息計時器<分鐘>。向所有團隊成員發送一個DBM休息計時器（需要團隊隊長或助理權限）。",
	"/dbm pull <秒數>: 開始備戰計時器<秒數>。向所有團隊成員發送一個DBM備戰計時器（需要團隊隊長或助理權限）。",
	"/dbm arrow: 顯示DBM箭頭, 輸入 /dbm arrow help 獲得更多訊息。",
	"/dbm lockout: 向團隊成員請求他們當前的團隊副本鎖定訊息(鎖定訊息、副本id) (需要團隊隊長或助理權限)。",
	"/dbm lag: 進行團隊範圍內的網路延遲檢測。"
}

DBM_ERROR_NO_PERMISSION				= "無權進行此操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "關閉血量框架"

DBM_CORE_UNKNOWN					= "未知"
DBM_CORE_LEFT						= "左"
DBM_CORE_RIGHT						= "右"
DBM_CORE_BACK						= "後"
DBM_CORE_FRONT						= "前"
DBM_CORE_INTERMISSION				= "中場時間"

DBM_CORE_BREAK_START				= "現在開始休息-你有%s分鐘!"
DBM_CORE_BREAK_MIN					= "%s分鐘後休息時間結束!"
DBM_CORE_BREAK_SEC					= "%s秒後休息時間結束!"
DBM_CORE_TIMER_BREAK				= "休息時間!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息時間已經結束"

DBM_CORE_TIMER_PULL					= "戰鬥準備"
DBM_CORE_ANNOUNCE_PULL				= "%d秒後拉怪 (%s發起)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "拉怪囉!"
DBM_CORE_GEAR_WARNING				= "警告：檢查裝備。你的所裝備的裝備等級低於包包中的裝備%d個等級。"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "成就"

DBM_CORE_AUTO_ANNOUNCE_TEXTS.target			= "%s:>%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d):>%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends 			= "%s結束"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget		= "%s結束:>%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades			= "%s消退"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "%s還剩下:%%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast			= "施放%s:%.1f秒"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon			= "%s即將到來"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%s在%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase			= "第%s階段"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase		= "第%s階段即將到來"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack			= ">%%s<中了%s (%%d)"

DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "提示$spell:%s的目標"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "提示$spell:%s的目標"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "為$spell:%s顯示警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends			= "為$spell:%s結束顯示警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget	= "為$spell:%s結束顯示警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "為$spell:%s消退顯示警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "提示$spell:%s的剩餘數量"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast			= "當$spell:%s施放時顯示警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon			= "為$spell:%s顯示預先警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn		= "為$spell:%s顯示預先警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "提示第%s階段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phasechange	= "提示階段轉換"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase		= "為第%s階段顯示預先警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "為$spell:%s顯示警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "提示$spell:%s的堆疊"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell			= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends 			= "%s結束"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades			= "%s消退"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon			= "%s即將到來"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn		= "%s在%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel		= ">%%s<中了%s - 現在驅散"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt		= "%s - 快中斷>%%s< !"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount= "%s - 快中斷>%%s< !(%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you			= "你中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target		= ">%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt			= ">%%s<中了%s - 快嘲諷"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close			= "你附近的>%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move			= "%s - 快移動"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge			= "%s - 閃避攻擊"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway		= "%s - 快離開其他人"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto		= "%s - 快跑向>%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run			= "%s - 快跑開"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast			= "%s - 停止施法"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect		= "%s - 停止攻擊"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count			= "%s!(%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack			= "你中了%%d層%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch		= ">%s< - 快更換目標!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount	= ">%s< - 快更換目標!(%%d)"

DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell		= "為$spell:%s顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 		= "為$spell:%s結束顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 		= "為$spell:%s消退顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 		= "為$spell:%s顯示預先特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 	= "在%s秒前為$spell:%s顯示預先特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel		= "需對$spell:%s驅散/竊取時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "需對$spell:%s斷法時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you			= "當你中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target		= "當有人中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 		= "當其他坦克中了$spell:%s顯示特別警告去嘲諷"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close		= "當你附近有人中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move		= "當你中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 		= "當需要閃避$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway	= "為$spell:%s要跑離開其他人時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto		= "當需要跑向中了$spell:%s的人時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run			= "為$spell:%s顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast		= "為$spell:%s施放時顯示停止施法的特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect		= "為$spell:%s施放時顯示停止攻擊的特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 		= "為$spell:%s顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack		= "為中了>=%d層$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "需對$spell:%s更換目標時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount = DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt

DBM_CORE_AUTO_TIMER_TEXTS.target			= "%s:>%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast				= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active			= "%s結束"
DBM_CORE_AUTO_TIMER_TEXTS.fades				= "%s消退"
DBM_CORE_AUTO_TIMER_TEXTS.cd				= "%s冷卻"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount			= "%s冷卻 (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource			= "%s冷卻:>%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next 				= "下一次%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount 		= "下一次%s (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource		= "下一次%s:>%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.phase				= "下一個階段"
DBM_CORE_AUTO_TIMER_TEXTS.roleplay			= GUILD_INTEREST_RP

DBM_CORE_AUTO_TIMER_OPTIONS.target			= "為$spell:%s顯示減益計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cast			= "為$spell:%s顯示施法計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.active			= "為$spell:%s顯示持續時間計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.fades			= "當$spell:%s將從玩家消退顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cd				= "為$spell:%s顯示冷卻計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount			= "為$spell:%s顯示冷卻計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource		= "為$spell:%s顯示冷卻計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.next			= "為下一次$spell:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount		= "為下一次$spell:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource		= "為下一次$spell:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement		= "為成就:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.phase			= "為下一個階段顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay		= "為角色扮演持續時間顯示計時器"

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "為$spell:%s的目標設置標記"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "為$spell:%s設置標記"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "為跑向中了$spell:%s的目標顯示DBM箭頭"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "為離開中了$spell:%s的目標顯示DBM箭頭"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "為中了$spell:%s後移動到特定區域顯示DBM箭頭"
DBM_CORE_AUTO_VOICE_OPTION_TEXT			= "為$spell:%s播放語音音效"
DBM_CORE_AUTO_VOICE2_OPTION_TEXT		= "為階段轉換播放語音音效"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "為$spell:%s的冷卻播放倒數計時音效"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "為$spell:%s的減益播放倒數計時音效"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "為$spell:%s的持續時間播放倒數計時音效"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "當你中了$spell:%s時大喊"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "" .. UnitName("player") .. "中了%s!"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "為$spell:%2$s顯示距離框架(%1$s碼)"
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "顯示距離框架(%s碼)"
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "為$spell:%2$s顯示反色距離框架(%1$s碼)"--Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "顯示反色距離框架(%s碼)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "為$spell:%s顯示訊息框架"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "當首領開打時撥放準備檢查的音效(即使沒有選定目標)"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "可移動提示"
DBM_CORE_MOVE_WARNING_MESSAGE		= "感謝您使用Deadly Boss Mods"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "可拖動的特別警告"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "特別警告"

DBM_ARROW_MOVABLE					= "可移動箭頭"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 用法:",
	"/dbm arrow <x> <y>  建立一個箭頭在特定的位置(使用世界地圖座標)",
	"/dbm arrow map <x> <y>  建立一個箭頭在特定的位置 (使用小地圖座標)",
	"/dbm arrow <玩家>  建立並箭頭指向你的隊伍或團隊中特定的玩家",
	"/dbm arrow hide  隱藏箭頭",
	"/dbm arrow move  可移動箭頭"
}

DBM_SPEED_KILL_TIMER_TEXT	= "勝利紀錄"
DBM_SPEED_KILL_TIMER_OPTION	= "顯示一個計時器來打敗你上次的最快勝利"
DBM_SPEED_CLEAR_TIMER_TEXT	= "最佳紀錄"
DBM_COMBAT_RES_TIMER_TEXT	= "下一個戰復充能"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s想要查看你的副本ID和進度鎖定情況。\n你想發送該訊息給%s嗎? 在你的當前進程（除非你下線）他可以一直查閱該訊息。"
DBM_ERROR_NO_RAID					= "你必須在一個團隊中才可以使用這個功能。"
DBM_INSTANCE_INFO_REQUESTED			= "查看團隊成員的副本鎖定訊息。\n請注意，隊員們將會被詢問是否願意發送資料給你，因此可能需要等待一段時間才能獲得全部的回覆。"
DBM_INSTANCE_INFO_STATUS_UPDATE		= "從%d個玩家獲得訊息，來自%d個DBM用戶：%d人發送了資料, %d人拒絕回傳資料。繼續為更多回覆等待%d秒..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "已獲得全部團隊成員的回傳資料"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "發送者:%s 結果類型:%s 副本名:%s 副本ID:%s 難度:%d 大小:%d 進度:%s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, 難度%s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, 進度%d:%s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    進度%d:%s"
DBM_INSTANCE_INFO_STATS_DENIED		= "拒絕回傳數據:%s"
DBM_INSTANCE_INFO_STATS_AWAY		= "離開:%s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "沒有安裝最新版本的DBM:%s"
DBM_INSTANCE_INFO_RESULTS			= "副本ID掃描結果。注意如果團隊中有不同語言版本的魔獸客戶端，那麼同一副本可能會出現不止一次。"
DBM_INSTANCE_INFO_SHOW_RESULTS		= "仍未回覆的玩家: %s\n|HDBM:showRaidIdResults|h|cff3588ff[查看結果]|r|h"

DBM_CORE_LAG_CHECKING				= "檢測團隊成員的網路延遲中..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - 網路延遲結果"
DBM_CORE_LAG_ENTRY					= "%s:世界延遲[%d毫秒]/家延遲[%d毫秒]"
DBM_CORE_LAG_FOOTER					= "無回應:%s"
