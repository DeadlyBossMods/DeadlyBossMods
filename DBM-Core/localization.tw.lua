if GetLocale() ~= "zhTW" then return end

DBM_CORE_NEED_LOCALS				= "你是否擁有良好的程式開發或語言能力? 如果是的話, DBM需要你的本地化翻譯。拜訪我們的討論區|HDBM:localizersneeded|h|cff3588ffclicking here|r"
DBM_CORE_NEED_LOGS					= "DBM需要Transcriptor (http://www.wowace.com/addons/transcriptor/) 去紀錄測試伺服器的戰鬥紀錄讓插件更加完美。如果你願意幫忙，請使用transcriptor去紀錄這些戰鬥過程然後將記錄發佈在。需要7.0的團隊和五人副本戰鬥紀錄，。"
DBM_HOW_TO_USE_MOD					= "歡迎使用DBM。在聊天頻道輸入 /dbm 打開設定開始設定。你可以載入特定區域後為任何首領設定你喜歡的特別設置。DBM會在第一次啟動時嘗試掃描你的職業天賦，但有些選項你可能想打開。"
DBM_SILENT_REMINDER					= "提醒：DBM正處於無聲模式。"

DBM_FORUMS_MESSAGE					= "發現臭蟲或錯誤的計時器?你希望要讓某些模組有新的警告，計時器或是特別功能?\nDeadly Boss Mods討論，臭蟲回報與功能要求討論區 |HDBM:forums|h|cff3588ffhttp://www.deadlybossmods.com|r (你可以點擊連結去複製網址)"
DBM_FORUMS_COPY_URL_DIALOG			= "來拜訪我們新的討論與支援討論區"
DBM_FORUMS_COPY_URL_DIALOG_NEWS		= "想知道新功能以及如何運作，拜訪我們的討論區"

DBM_CORE_LOAD_MOD_ERROR				= "載入%s模組時發生錯誤：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功載入%s模組。輸入/dbm 可自訂警告音效和個人化註記。"
DBM_CORE_LOAD_MOD_COMBAT			= "延遲載入'%s'直到離開戰鬥"
DBM_CORE_LOAD_GUI_ERROR				= "無法載入圖形介面：%s"
DBM_CORE_LOAD_GUI_COMBAT			= "圖形介面不能在戰鬥中初始化。圖形介面將在脫離戰鬥後自動開啟，這樣就能夠再次在戰鬥中使用。"
DBM_CORE_BAD_LOAD					= "DBM偵測到你的此副本的模組在戰鬥中讀取失敗。一旦脫離戰鬥，請立即輸入/console reloadui重新載入。"
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s不能被讀取因為你的DBM核心未達需求，請更新版本。"
DBM_CORE_LOAD_MOD_DISABLED			= "%s已安裝但目前停用中。此模組不會載入除非你啟用它。"
DBM_CORE_LOAD_MOD_DISABLED_PLURAL	= "%s已安裝但目前停用中。這些模組不會載入除非你啟用它們。"

DBM_CORE_WHATS_NEW					= "鬥陣特攻和暴雪英霸倒數音效已經從DBM核心分離而且有獨立的插件包下載。想重新取得這些音效。請安裝插件DBM-CountPack-Overwatch和DBM-CountPack-HoTS。也有新功能可關閉類似更新註釋再次提示。"
DBM_CORE_WHATS_NEW_LINK				= "記得：你可以到DBM Discord裡回報臭蟲，給些回饋或是只是到這看看：|HDBM:forumsnews|h|cff3588ffDiscord連結|r"

--Post Patch 7.1
DBM_CORE_NO_RANGE					= "距離雷達不能在副本中使用，使用傳統文字距離框架取代"
DBM_CORE_NO_ARROW					= "箭頭不能在副本中使用"
DBM_CORE_NO_HUD						= "HUDMap 不能在副本中使用"

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM已中禁用動態距離框架，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM已中禁用小怪計數警告，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM已中禁用多項功能，你目前的團隊人數在這場戰鬥中的機制資訊不足。"

DBM_CORE_LOOT_SPEC_REMINDER			= "你目前的專精為:%s。而你目前的拾取選擇為:%s。"

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM偵測到你同時開啟BigWigs和DBM的團隊圖示。請關閉其中之一的團隊圖示功能以免與產生衝突。"

DBM_CORE_MOD_AVAILABLE				= "%s的DBM插件已經可供使用。你可以在|HDBM:forums|h|cff3588ffdeadlybossmods.com|r或Curse上找到。此訊息只會顯示一次。."

DBM_CORE_COMBAT_STARTED				= "%s開戰。祝好運與盡興! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "與%s開戰已進行的戰鬥。祝好運與盡興! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "公會已跟%s開戰"
DBM_CORE_SCENARIO_STARTED			= "%s開始。祝好運與盡興! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "加入進行中的%s事件。祝好運與盡興! :)"
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

DBM_CORE_MOVIE_SKIPPED				= "DBM已嘗試自動略過場動畫。"

DBM_CORE_AFK_WARNING				= "你正在AFK和戰鬥中(血量還剩餘%d百分比)所以發出警告。如果你沒在AFK，請清除AFK的標籤或是在額外功能禁用此選項。"

DBM_CORE_COMBAT_STARTED_AI_TIMER	= "我的CPU是類神經網路處理器，一種學習型電腦。(此戰鬥會使用新的AI計時器功能去產生計時器的近似值)"

DBM_CORE_PROFILE_NOT_FOUND			= "<DBM>你目前的配置檔已經損毀。DBM會載入'Default'配置檔。"
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
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "%s's (%d專精)模組音效或註記設定已被複製。"
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "不能複製角色音效或註記設定到本身來源"
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "配置檔來源已經損毀，音效或註記設定不能被複製或是部分複製，複製已失敗。"
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "%s's (%d專精)模組設定已被刪除。"
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "不能刪除使用中的模組設定。"
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "配置檔來源已經損毀，設定不能被刪除或是部分刪除，刪除已失敗。"

DBM_CORE_NOTE_SHARE_SUCCESS			= "%s已分享他的%s的註記"
DBM_CORE_NOTE_SHARE_LINK			= "點擊這裡打開註記"
DBM_CORE_NOTE_SHARE_FAIL			= "%s嘗試與你分享%s的註記。模組相關的技能沒有安裝或是載入。請確定你載入此模組並請求他們在分享一次。"

DBM_CORE_NOTEHEADER					= "為%s輸入你的註記。在><插入腳色名稱可套用職業顏色。多個註記請使用'/'分開"
DBM_CORE_NOTEFOOTER					= "按下'確定'接受變更或'取消'放棄變更"
DBM_CORE_NOTESHAREDHEADER			= "%s已分享%s的註記。接受註記會覆蓋你原有的註記。"
DBM_CORE_NOTESHARED					= "你的註記已經送出至隊伍"
DBM_CORE_NOTESHAREERRORSOLO			= "寂寞嗎?不應該能分享注意給你自己"
DBM_CORE_NOTESHAREERRORBLANK		= "不能分享空白註記"
DBM_CORE_NOTESHAREERRORGROUPFINDER	= "註記不能被分享在戰場、隨機團隊或隨機隊伍"
DBM_CORE_NOTESHAREERRORALREADYOPEN	= "不能開啟分享註記連結當註記編輯器已經被打開，避免你失去正在編輯的註記"

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "此副本所有的選項設定已套用預設值。"
DBM_CORE_ALLMOD_STATS_RESETED		= "所有模組狀態已經被重置。"
DBM_CORE_MOD_DEFAULT_LOADED			= "此戰鬥的預設選項已套用。"

DBM_CORE_WORLDBOSS_ENGAGED			= "在你的伺服器上的%s已在百分之%s時開戰(%s發送)。"
DBM_CORE_WORLDBOSS_DEFEATED			= "在你的伺服器上的%s已被擊敗(%s發送)。"

DBM_CORE_TIMER_FORMAT_SECS			= "%.2f秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分鐘"
DBM_CORE_TIMER_FORMAT				= "%d分%.2f秒"

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
DBM_CORE_VOICE_PACK_OUTDATED		= "你的DBM語音包可能缺少在這個版本的DBM需要的語音。部分警告音效已經被停用。請下載新版本的語音包或是聯絡語音包作者更新並加入缺少的語音。"
DBM_CORE_VOICE_MISSING				= "DBM找不到你所選取的語音包。你的語音包選項已經被重置為'None'。請確定你的語音包已正確的安裝與啟用。"
DBM_CORE_VOICE_DISABLED				= "你的語音包已安裝但是尚未啟用。如果你想使用語音包，請確定語言包已在語音警告中被選取，或是刪除不使用的語音包去隱藏此訊息。"
DBM_CORE_VOICE_COUNT_MISSING		= "所選取的語音/倒數語音包%d找不到倒數語音。設定已被重置回預設值。"

DBM_CORE_UPDATEREMINDER_HEADER			= "你的Deadly Boss Mod已經過期。\n你可以在Curse網站或是wowinterface網站以及此網址下載到新版本%s(r%d)："
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "你的ALPHA版本Deadly Boss Mods已經過期。\n 你至少落後%d個測試版本。建議DBM使用者使用最新的ALPHA或最新的穩定版本。過期的alpha版本可能會有效能低落或未完成的功能。"
DBM_CORE_UPDATEREMINDER_FOOTER			= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製下載網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_DISABLE			= "警告: 你的DBM版本已過期太多版本(至少過期%d個版本)，DBM已被強制禁用了而不能啟用除非更新至最新版本。這是為了確保舊而不相容的程式碼不會對你而團隊夥伴造成低落的遊戲體驗。"
DBM_CORE_UPDATEREMINDER_HOTFIX			= "你的DBM版本會在這首領戰鬥有不準確的計時器或警告。這問題已被修正在新版正式版"
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= "你的DBM版本會在這首領戰鬥有不準確的計時器或警告。這問題已被修正在新版正式版(或是更新到最新的alpha)"
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "警告:你的DBM已經過期，DBM已被禁用直到你更新至最新版，因為遊戲大改版。為了不讓舊的程式碼拖累遊戲體驗。請至deadlybossmods.com或是curse下載最新版本的DBM。"
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "警告:你使用的DBM版本和遊戲版本不相容。請到deadlybossmods.com或是curse下載符合你遊戲版本的DBM。"
DBM_CORE_VEM							= "警告:你同時使用DBM和VEM。DBM將停用而無法執行。"
DBM_CORE_3RDPROFILES					= "警告:DBM-Profiles不相容此版本DBM。請移除避免衝突。"
DBM_CORE_DPMCORE						= "警告:Deadly PvP 模組已經停止更新而且不相容此版本的DBM。請移除避免衝突。"
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "警告:如果你沒有重啟你的遊戲，這次DBM更新可能無法正確運作。這次更新包含了新的檔案或是.toc檔更新而不能使用ReloadUI載入。如果沒有將遊戲完全重啟可能會導致錯誤或功能不完整。"
DBM_CORE_OUT_OF_DATE_NAG				= "你的DBM版本已經過期你設定忽略彈出更新提示。還是建議你更新避免缺少一些重要的警告或是計時器，而其他人也看不到從你發出的大喊警告。"

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
DBM_CORE_INFOFRAME_SETLINES			= "設定最大線條數"
DBM_CORE_INFOFRAME_LINESDEFAULT		= "由模組設定"
DBM_CORE_INFOFRAME_LINES_TO			= "%d線條"

DBM_LFG_INVITE						= "地城準備確認"

DBM_CORE_SLASHCMD_HELP				= {
	"可用指令：",
	"-----------------",
	"/dbm unlock：顯示一個可移動的計時器（也可使用：move）。",
	"/range <數字> 或 /distance <數字>: 顯示距離框架。/rrange 或 /rdistance 顯示相反色。",
	"/hudar <數字>: 顯示HUD距離顯示器。",
	"/dbm timer: 啟動DBM自訂計時器，輸入'/dbm timer'獲得更多訊息。",
	"/dbm arrow: 顯示DBM箭頭，輸入'/dbm arrow help'獲得更多訊息。",
	"/dbm hud: 顯示DBM hud，輸入'/dbm hud'獲得更多訊息。",
	"/dbm help2: 顯示團隊管理可用指令"
}
DBM_CORE_SLASHCMD_HELP2				= {
	"可用指令：",
	"-----------------",
	"/dbm pull <秒數>: 開始備戰計時器<秒數>。向所有團隊成員發送一個DBM備戰計時器（需要團隊隊長或助理權限）。",
	"/dbm break <分鐘>: 開始休息計時器<分鐘>。向所有團隊成員發送一個DBM休息計時器（需要團隊隊長或助理權限）。",
	"/dbm version：進行團隊的版本檢測（也可使用：ver）。",
	"/dbm version2: 進行團隊的版本檢測並密語提醒過期的使用者（也可使用：ver2）。",
	"/dbm lockout: 向團隊成員請求他們當前的團隊副本鎖定訊息(鎖定訊息、副本id) (需要團隊隊長或助理權限)。",
	"/dbm lag: 進行團隊範圍內的網路延遲檢測。",
	"/dbm durability: 進行團隊範圍內的裝備耐久度檢測。"
}
DBM_CORE_TIMER_USAGE	= {
	"DBM計時器指令：",
	"-----------------",
	"/dbm timer <秒> <文字>: 啟用計時器。",
	"/dbm ctimer <秒> <文字>: 啟用計時器包含倒數文字。",
	"/dbm ltimer <秒> <文字>: 啟用會自動循環的計時器。",
	"/dbm cltimer <秒> <文字>: 啟用會自動循環及倒數文字的計時器。",
	"(在任何計時器指令前加入'Broadcast'可以把指令分享給團隊（需要團隊隊長或助理權限）)",
	"/dbm timer endloop：停止任何無限循環的計時器。"
}

DBM_ERROR_NO_PERMISSION				= "無權進行此操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "關閉血量框架"

--Common Locals
DBM_NEXT							= "下一次%s"
DBM_COOLDOWN						= "%s冷卻"
DBM_CORE_UNKNOWN					= "未知"
DBM_CORE_LEFT						= "左"
DBM_CORE_RIGHT						= "右"
DBM_CORE_BACK						= "後"
DBM_CORE_MIDDLE						= "中"
DBM_CORE_FRONT						= "前"
DBM_CORE_EAST						= "東"
DBM_CORE_WEST						= "西"
DBM_CORE_NORTH						= "北"
DBM_CORE_SOUTH						= "南"
DBM_CORE_INTERMISSION				= "中場時間"
DBM_CORE_ORB						= "球"
DBM_CHEST							= "獎勵箱"
DBM_NO_DEBUFF						= "沒有%s"
DBM_ALLY							= "隊友"
DBM_ADDS							= "小怪"
DBM_CORE_ROOM_EDGE					= "房間邊緣"
DBM_CORE_SAFE						= "安全"
--Common Locals end

DBM_CORE_BREAK_USAGE				= "休息時間不能長於60分鐘。請確定你輸入的時間是分鐘不是秒。"
DBM_CORE_BREAK_START				= "現在開始休息-你有%s分鐘!"
DBM_CORE_BREAK_MIN					= "%s分鐘後休息時間結束!"
DBM_CORE_BREAK_SEC					= "%s秒後休息時間結束!"
DBM_CORE_TIMER_BREAK				= "休息時間!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息時間結束於%s"

DBM_CORE_TIMER_PULL					= "戰鬥準備"
DBM_CORE_ANNOUNCE_PULL				= "%d秒後拉怪 (%s發起)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "拉怪囉!"
DBM_CORE_ANNOUNCE_PULL_TARGET		= "開打%s在%d秒後 (%s發起)"
DBM_CORE_ANNOUNCE_PULL_NOW_TARGET	= "開打%s!"
DBM_CORE_GEAR_WARNING				= "警告：檢查裝備。你的所裝備的裝備等級低於包包中的裝備%d個等級。"
DBM_CORE_GEAR_WARNING_WEAPON		= "警告：檢查你是否裝備正確的武器。"
DBM_CORE_GEAR_FISHING_POLE			= "釣魚竿"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "成就"

DBM_CORE_AUTO_ANNOUNCE_TEXTS.you			= "你中了%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target			= "%s:>%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s):>%%s<"
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
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack			= ">%%s<中了%s (%%d)"

DBM_CORE_AUTO_ANNOUNCE_OPTIONS.you			= "提示當你中了$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "提示$spell:%s的目標"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "提示$spell:%s的目標(次數)"
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
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "為$spell:%s顯示警告(次數)"
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
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youcount		= "你中了%s (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youpos		= "你中了%s (站位：%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soakpos		= "%s - 快到%%s分傷"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target		= ">%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetcount	= ">%%2$s<中了%s (%%1$s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.defensive		= "%s - 使用防禦技能"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt			= ">%%s<中了%s - 快嘲諷"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close			= "你附近的>%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move			= "%s - 快移動"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge			= "%s - 閃避攻擊"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway		= "%s - 快離開其他人"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto		= "%s - 快跑向>%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.jump			= "%s - 快跳躍"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run			= "%s - 快跑開"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast			= "%s - 停止施法"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect		= "%s - 停止攻擊"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count			= "%s!(%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack			= "你中了%%d層%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch		= "%s - 快更換目標!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount	= "%s - 快更換目標!(%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.gtfo			= "注意腳下 - 快移動"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.Adds			= "小怪來了 - 快更換目標!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.Addscustom	= "小怪來了 - %s"

DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell		= "為$spell:%s顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 		= "為$spell:%s結束顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 		= "為$spell:%s消退顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 		= "為$spell:%s顯示預先特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 	= "在%s秒前為$spell:%s顯示預先特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel		= "需對$spell:%s驅散/竊取時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "需對$spell:%s斷法時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= "需對$spell:%s斷法(次數)時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you			= "當你中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youcount	= "當你中了$spell:%s時(次數)顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youpos		= "當你中了$spell:%s時(站位)顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soakpos		= "當需要為$spell:%s分傷時(站位)顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target		= "當有人中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetcount	= "當有人中了$spell:%s時(次數)顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.defensive	= "需對$spell:%s使用防禦技能時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 		= "當其他坦克中了$spell:%s顯示特別警告去嘲諷"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close		= "當你附近有人中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move		= "當你中了$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 		= "當需要閃避$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway	= "當你中了$spell:%s要跑離開其他人時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto		= "為$spell:%s需要跑向某人或某地時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.jump		= "當你中了$spell:%s需跳起來時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run			= "為$spell:%s顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast		= "為$spell:%s施放時顯示停止施法的特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect		= "為$spell:%s施放時顯示停止攻擊的特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 		= "為$spell:%s顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack		= "為中了>=%d層$spell:%s時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch		= "為$spell:%s顯示特別警告去更換目標"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount = "為$spell:%s顯示特別警告(次數)去更換目標"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.gtfo 		= "為離開地上危險的技能時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.Adds		= "為到來的小怪更換目標時顯示特別警告"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.Addscustom	= "為到來的小怪顯示特別警告"

DBM_CORE_AUTO_TIMER_TEXTS.target			= "%s:%%s"
DBM_CORE_AUTO_TIMER_TEXTS.cast				= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.castsource		= "%s:%%s"
DBM_CORE_AUTO_TIMER_TEXTS.active			= "%s結束"
DBM_CORE_AUTO_TIMER_TEXTS.fades				= "%s消退"
DBM_CORE_AUTO_TIMER_TEXTS.ai				= "%sAI"
DBM_CORE_AUTO_TIMER_TEXTS.cd				= "%s冷卻"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount			= "%s冷卻 (%%d)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource			= "%s冷卻:>%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial			= "特別技能冷卻"
DBM_CORE_AUTO_TIMER_TEXTS.next 				= "下一次%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount 		= "下一次%s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource		= "下一次%s:%%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial		= "下一次特別技能"
DBM_CORE_AUTO_TIMER_TEXTS.achievement		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.phase				= "下一個階段"
DBM_CORE_AUTO_TIMER_TEXTS.adds				= "下一次小怪到來"
DBM_CORE_AUTO_TIMER_TEXTS.addscustom  		= "小怪到來(%s)"
DBM_CORE_AUTO_TIMER_TEXTS.roleplay			= GUILD_INTEREST_RP

DBM_CORE_AUTO_TIMER_OPTIONS.target			= "為$spell:%s顯示減益計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cast			= "為$spell:%s顯示施法計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.castsource		= "為$spell:%s的施法來源顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.active			= "為$spell:%s顯示持續時間計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.fades			= "當$spell:%s將從玩家消退顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.ai				= "為$spell:%s顯示AI計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cd				= "為$spell:%s顯示冷卻計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount			= "為$spell:%s顯示冷卻計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource		= "為$spell:%s顯示冷卻計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial		= "為特別技能顯示冷卻計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.next			= "為下一次$spell:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount		= "為下一次$spell:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource		= "為下一次$spell:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial		= "為下一次特別技能顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement		= "為成就:%s顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.phase			= "為下一個階段顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.adds			= "為到來的小怪顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.addscustom		= "為到來的小怪顯示計時器"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay		= "為角色扮演持續時間顯示計時器"

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "為$spell:%s的目標設置標記"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "為$spell:%s設置標記"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "為跑向中了$spell:%s的目標顯示DBM箭頭"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "為離開中了$spell:%s的目標顯示DBM箭頭"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "為中了$spell:%s後移動到特定區域顯示DBM箭頭"
DBM_CORE_AUTO_VOICE_OPTION_TEXT			= "為$spell:%s播放語音音效"
DBM_CORE_AUTO_VOICE2_OPTION_TEXT		= "為階段轉換播放語音音效"
DBM_CORE_AUTO_VOICE3_OPTION_TEXT		= "為到來的小怪播放語音音效"
DBM_CORE_AUTO_VOICE4_OPTION_TEXT		= "為地上危險的技能播放語音音效"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "為$spell:%s的冷卻播放倒數計時音效"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "為$spell:%s的減益播放倒數計時音效"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "為$spell:%s的持續時間播放倒數計時音效"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortyell	= "當你中了$spell:%s時大喊"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yell		= "當你中了$spell:%s時大喊(玩家名字)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.count	= "當你中了$spell:%s時大喊(次數)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.fade		= "當$spell:%s正消退時大喊(倒數和技能名稱)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortfade	= "當$spell:%s正消退時大喊(倒數)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.position	= "當你中了$spell:%s時大喊(位置)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell	= "" .. UnitName("player") .. "中了%s!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.count	= "" .. UnitName("player") .. "中了%s!(%%d)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.fade	= "%s在%%d秒後消退!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.position = "" .. UnitName("player") .. "中了%s!(%%s)".."{rt%%d}"--Arg order is going to be a problem. any way to word differently for playername at end?
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "為$spell:%s顯示HudMap(已退役)"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "為不同的機制顯示HudMap(已退役)"
DBM_CORE_AUTO_NAMEPLATE_OPTION_TEXT		= "為$spell:%s顯示名條光環"
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

DBM_CORE_HUD_INVALID_TYPE			= "無效的HUD類型定義"
DBM_CORE_HUD_INVALID_TARGET			= "無有效的HUD目標"
DBM_CORE_HUD_INVALID_SELF			= "不能將HUD目标設定成自己"
DBM_CORE_HUD_INVALID_ICON			= "不能設定對無團隊標記的目標"
DBM_CORE_HUD_SUCCESS				= "HUD成功使用你的參數運作。這會在%s後取消，或是使用'/dbm hud hide'指令取消。"
DBM_CORE_HUD_USAGE	= {
	"DBM-HudMap 用法:",
	"/dbm hud <類型> <目標> <持續時間>  建立一個指向玩家的HUD",
	"有效類型: arrow, dot, red, blue, green, yellow, icon(需要團隊標記)",
	"有效目標: target, focus, <玩家名字>",
	"有效持續時間: 任何秒數。如果無輸入值則預設為20分鐘",
	"/dbm hud hide  關閉並隱藏HUD"
}

DBM_ARROW_MOVABLE					= "可移動箭頭"
DBM_ARROW_WAY_USAGE					= "/dway <x> <y>: 建立一個箭頭來指向特定位置(使用區域地圖坐標)"
DBM_ARROW_WAY_SUCCESS				= "要隱藏箭頭, 輸入 '/dbm arrow hide' 或是抵達箭頭"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 用法:",
	"/dbm arrow <x> <y>  建立一個箭頭在特定的位置(使用世界地圖座標)",
	"/dbm arrow map <x> <y>  建立一個箭頭在特定的位置 (使用小地圖座標)",
	"/dbm arrow <玩家>  建立並箭頭指向你的隊伍或團隊中特定的玩家",
	"/dbm arrow hide  隱藏箭頭",
	"/dbm arrow move  可移動箭頭"
}

DBM_SPEED_KILL_TIMER_TEXT	= "勝利紀錄"
DBM_SPEED_CLEAR_TIMER_TEXT	= "最佳紀錄"
DBM_COMBAT_RES_TIMER_TEXT	= "下一個戰復充能"
DBM_CORE_TIMER_RESPAWN		= "%s重生"

DBM_CORE_DUR_CHECKING				= "檢測團隊裝備耐久度..."
DBM_CORE_DUR_HEADER					= "Deadly Boss Mods - 裝備耐久度結果"
DBM_CORE_DUR_ENTRY					= "%s:耐久度[%d百分比]/裝備損壞[%s]"
DBM_CORE_LAG_FOOTER					= "無回應:%s"

DBM_REQ_INSTANCE_ID_PERMISSION		= "%s想要查看你的副本ID和進度鎖定情況。\n你想發送該訊息給%s嗎? 在你的當前進程（除非你下線）他可以一直查閱該訊息。"
DBM_ERROR_NO_RAID					= "你必須在一個團隊中才可以使用這個功能。"
DBM_INSTANCE_INFO_REQUESTED			= "查看團隊成員的副本鎖定訊息。\n請注意，隊員們將會被詢問是否願意發送資料給你，因此可能需要等待一段時間才能獲得全部的回覆。"
DBM_INSTANCE_INFO_STATUS_UPDATE		= "從%d個玩家獲得訊息，來自%d個DBM用戶：%d人發送了資料, %d人拒絕回傳資料。繼續為更多回覆等待%d秒..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "已獲得全部團隊成員的回傳資料"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "發送者:%s 結果類型:%s 副本名:%s 副本ID:%s 難度:%d 大小:%d 進度:%s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, 難度%s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, 進度%d:%s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    進度%d:%s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "你的團隊沒有副本進度資訊。"
DBM_INSTANCE_INFO_STATS_DENIED		= "拒絕回傳數據:%s"
DBM_INSTANCE_INFO_STATS_AWAY		= "離開:%s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "沒有安裝最新版本的DBM:%s"
DBM_INSTANCE_INFO_RESULTS			= "副本ID掃描結果。注意如果團隊中有不同語言版本的魔獸客戶端，那麼同一副本可能會出現不止一次。"
DBM_INSTANCE_INFO_SHOW_RESULTS		= "仍未回覆的玩家: %s\n|HDBM:showRaidIdResults|h|cff3588ff[查看結果]|r|h"

DBM_CORE_LAG_CHECKING				= "檢測團隊成員的網路延遲中..."
DBM_CORE_LAG_HEADER					= "Deadly Boss Mods - 網路延遲結果"
DBM_CORE_LAG_ENTRY					= "%s:世界延遲[%d毫秒]/家延遲[%d毫秒]"
DBM_CORE_LAG_FOOTER					= "無回應:%s"