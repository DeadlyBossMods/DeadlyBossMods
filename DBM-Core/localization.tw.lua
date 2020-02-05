if GetLocale() ~= "zhTW" then return end
DBM_DEADLY_BOSS_MODS				= "Deadly Boss Mods"
DBM_DBM								= "DBM"
local day, _, month = C_DateAndTime and C_DateAndTime.GetCurrentCalendarTime and C_DateAndTime.GetCurrentCalendarTime()
if day and month and day == 1 and month == 4 then
	DBM_DEADLY_BOSS_MODS				= "Harmless Boss Mods"
	DBM_DBM								= "HBM"
end

DBM_HOW_TO_USE_MOD							= "歡迎使用"..DBM_DBM.."。在聊天頻道輸入 /dbm 打開設定開始設定。你可以載入特定區域後為任何首領設定你喜歡的特別設置。DBM會在設定你的職業天賦的預設值，但有些選項可能需要調整。"
DBM_SILENT_REMINDER							= "提醒："..DBM_DBM.."正處於無聲模式。"

DBM_CORE_LOAD_MOD_ERROR				= "載入%s模組時發生錯誤：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功載入%s模組。更多選項例如自訂警告音效或是個人提醒註記請輸入/dbm或/dbm help。"
DBM_CORE_LOAD_MOD_COMBAT			= "延遲載入'%s'直到離開戰鬥"
DBM_CORE_LOAD_GUI_ERROR					= "無法載入圖形介面：%s"
DBM_CORE_LOAD_GUI_COMBAT				= "圖形介面不能在戰鬥中初始化。圖形介面將在脫離戰鬥後自動讀取，這樣就能夠再次在戰鬥中使用。"
DBM_CORE_BAD_LOAD								= DBM_DBM.."偵測到你的此副本的模組在戰鬥中讀取失敗。一旦脫離戰鬥，請立即輸入/consoel reloadui重新載入。"
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s不能被讀取因為你的DBM核心未達需求，請更新版本。"
DBM_CORE_LOAD_MOD_EXP_MISMATCH		= "%s不能被讀取因為這是設計給WoW資料片而目前尚未開放。當資料片開放時，此模組會自動啟用。"
DBM_CORE_LOAD_MOD_TOC_MISMATCH		= "%s不能被讀取因為這是設計給WoW更新檔(%s)而目前尚未開放。當更新檔更新時，此模組會自動啟用。"
DBM_CORE_LOAD_MOD_DISABLED					= "%s已安裝但目前停用中。此模組不會載入除非你啟用它。"
DBM_CORE_LOAD_MOD_DISABLED_PLURAL	= "%s已安裝但目前停用中。這些模組不會載入除非你啟用它們。"

DBM_COPY_URL_DIALOG					= "複製網址"

--Post Patch 7.1
DBM_CORE_NO_RANGE						= "距離雷達不能在副本中使用，使用傳統文字距離框架取代"
DBM_CORE_NO_ARROW					= "箭頭不能在副本中使用"
DBM_CORE_NO_HUD							= "HUDMap不能在副本中使用"

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= DBM_DBM.."已中禁用動態距離框架，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
DBM_CORE_DYNAMIC_ADD_COUNT			= DBM_DBM.."已中禁用小怪計數警告，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
DBM_CORE_DYNAMIC_MULTIPLE					= DBM_DBM.."已中禁用多項功能，你目前的團隊人數在這場戰鬥中的機制資訊不足。"

DBM_CORE_LOOT_SPEC_REMINDER				= "你目前的專精為:%s。而你目前的拾取選擇為:%s。"

DBM_CORE_BIGWIGS_ICON_CONFLICT		= DBM_DBM.."偵測到你同時開啟BigWigs和DBM的團隊圖示。請關閉其中之一的團隊圖示功能以免產生衝突。"

DBM_CORE_MOD_AVAILABLE						= "%s在此區域有模組可用。你可以在Curse/Twitch或WoWI下載。"

DBM_CORE_COMBAT_STARTED					= "%s開戰。祝好運與盡興! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "與%s開戰已進行的戰鬥。祝好運與盡興! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "公會已跟%s開戰"
DBM_CORE_SCENARIO_STARTED					= "%s開始。祝好運與盡興! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "加入進行中的%s事件。祝好運與盡興! :)"
DBM_CORE_BOSS_DOWN							= "擊敗%s，用了%s!"
DBM_CORE_BOSS_DOWN_I						= "擊敗%s!你已勝利了%d次。"
DBM_CORE_BOSS_DOWN_L						= "擊敗%s!本次用了%s，上次用了%s，最快紀錄為%s。你總共戰勝了%d次。"
DBM_CORE_BOSS_DOWN_NR					= "擊敗%s!用了%s! 這是一個新記錄! (舊紀錄為%s) 你總共戰勝了%d次。"
DBM_CORE_GUILD_BOSS_DOWN				= "公會已擊敗%s，用了%s!"
DBM_CORE_SCENARIO_COMPLETE			= "%s完成!用了%s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "%s完成! 你總共完成了%d次。"
DBM_CORE_SCENARIO_COMPLETE_L		= "%s完成!本次用了%s，上次用了%s，最快紀錄為%s。你總共完成了%d次。"
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s完成!用了%s! 這是一個新記錄! (舊紀錄為%s) 你總共完成了%d次。"
DBM_CORE_COMBAT_ENDED_AT				= "%s(%s)的戰鬥經過%s結束。"
DBM_CORE_COMBAT_ENDED_AT_LONG		= "%s(%s)的戰鬥經過%s結束。你在這個難度總共滅團了%d次。"
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "公會在%s (%s)的戰鬥滅團，經過%s."
DBM_CORE_SCENARIO_ENDED_AT				= "%s結束!用了%s!"
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s結束!本次用了%s，你已有共%d次未完成的嘗試在這個難度裡。"
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s的戰鬥在%s前開始，恢復計時器中..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Transcriptor開始記錄。"
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Transcriptor結束紀錄。"

DBM_CORE_MOVIE_SKIPPED					= DBM_DBM.."已嘗試自動略過一個過場動畫。"
DBM_CORE_BONUS_SKIPPED				= DBM_DBM.."已經自動關閉額外戰利品擲骰框架。如果你需要恢復此框架，在三分鐘內輸入/dbmbonusroll"

DBM_CORE_AFK_WARNING				= "你正在暫離並戰鬥中(血量還剩餘%d百分比)所以發出警告。如果你並非暫離，請清除暫離的標籤或是在'額外功能'停用此選項。"

DBM_CORE_COMBAT_STARTED_AI_TIMER	= "我的CPU是一個神經網路處理器;一個學習中的電腦 (這場戰鬥將使用新的計時器AI功能生成近似值的計時條)"

DBM_CORE_PROFILE_NOT_FOUND			= "<"..DBM_DBM..">你目前的配置檔已經損毀。"..DBM_DBM.."會載入'Default'配置檔。"
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
DBM_CORE_SOUNDKIT_MIGRATION			= "您的一個或多個警告/特別警告音效被重置為預設設置，因為不相容的媒體類型或無效的聲音路徑。DBM現在僅支援播放在您的addons資料夾之內的聲音文件，或者媒體的SoundKit編號。"

DBM_CORE_WORLDBOSS_ENGAGED			= "在你的伺服器上的%s已在百分之%s時開戰(%s發送)。"
DBM_CORE_WORLDBOSS_DEFEATED			= "在你的伺服器上的%s已被擊敗(%s發送)。"

DBM_CORE_TIMER_FORMAT_SECS			= "%.2f秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分鐘"
DBM_CORE_TIMER_FORMAT				= "%d分%.2f秒"

DBM_CORE_MIN						= "分"
DBM_CORE_MIN_FMT				= "%d分"
DBM_CORE_SEC							= "秒"
DBM_CORE_SEC_FMT				= "%s秒"

DBM_CORE_GENERIC_WARNING_OTHERS		= "與一個其他"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "與其他%d"
DBM_CORE_GENERIC_WARNING_BERSERK	= "%s%s後狂暴"
DBM_CORE_GENERIC_TIMER_BERSERK		= "狂暴"
DBM_CORE_OPTION_TIMER_BERSERK			= "為$spell:26662顯示計時器"
DBM_CORE_GENERIC_TIMER_COMBAT		= "戰鬥開始"
DBM_CORE_OPTION_TIMER_COMBAT			= "為戰鬥開始顯示計時器"
DBM_CORE_BAD						= "地板技能"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "計時條"
--Sub cats for "announce" object
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "一般提示"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "個人提示"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "目標提示"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "角色專精提示"

DBM_CORE_OPTION_CATEGORY_SOUNDS			= "音效"
--Misc object broken down into sub cats
DBM_CORE_OPTION_CATEGORY_DROPDOWNS		= "下拉選項"
DBM_CORE_OPTION_CATEGORY_YELLS			= "大喊"
DBM_CORE_OPTION_CATEGORY_NAMEPLATES		= "名條"
DBM_CORE_OPTION_CATEGORY_ICONS			= "圖示"

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
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (%s) %s"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) & %s (%s)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：尚未安裝任何團隊首領模組"
DBM_CORE_VERSIONCHECK_FOOTER		= "找到有%d玩家正在使用DBM且有%d玩家正在使用Bigwigs"
DBM_CORE_VERSIONCHECK_OUTDATED		= "下列有%d玩家正在使用過期的首領模組:%s"
DBM_CORE_YOUR_VERSION_OUTDATED		= "你的 Deadly Boss Mod 已經過期。請到http://www.deadlybossmods.com下載最新版本。"
DBM_CORE_VOICE_PACK_OUTDATED		= "你的DBM語音包可能缺少在這個版本的DBM需要的語音。部分警告音效已經被停用。請下載新版本的語音包或是聯絡語音包作者更新並加入缺少的語音。"
DBM_CORE_VOICE_MISSING				= "DBM找不到你所選取的語音包。請確定你的語音包已正確的安裝與啟用。"
DBM_CORE_VOICE_DISABLED				= "你的語音包已安裝但是尚未啟用。如果你想使用語音包，請確定語言包已在語音警告中被選取，或是刪除不使用的語音包去隱藏此訊息。"
DBM_CORE_VOICE_COUNT_MISSING		= "所選取的語音/倒數語音包%d找不到倒數語音。設定已被重置回預設值：%s。"
DBM_BIG_WIGS						= "BigWigs"

DBM_CORE_UPDATEREMINDER_HEADER			= "你的Deadly Boss Mod已經過期。\n你可以在Curse/Twitch網站或是WOWI網站以及deadlybossmods.com下載到新版本%s (%s)"
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "你的"..DBM_DEADLY_BOSS_MODS.."測試版已經過期。\n 你至少落後%s個測試版本。建議DBM使用者如果選擇使用測試版請用最新的版本，不然應該用最新的正式版本。過期的測試版本有更嚴密的版本檢查因為這是DBM的開發版本。"
DBM_CORE_UPDATEREMINDER_FOOTER			= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製下載網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_DISABLE			= "警告:  你的DBM版本已大幅度的過期，DBM已被強制關閉並且無法使用直到更新為止。這是為了確保舊而不相容的程式碼不會對你而團隊夥伴造成低落的遊戲體驗。"
--DBM_CORE_UPDATEREMINDER_NODISABLE		= "警告: 你的DBM版本已大幅過期。此訊息在過了某個門檻之後會不能被禁用，強烈建議更新。"
DBM_CORE_UPDATEREMINDER_HOTFIX			= "你的DBM版本會在這首領戰鬥有不準確的計時器或警告。這問題已被修正在新版正式版(或是更新到最新的測試版。)"
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= "您的DBM版本在此首領戰有些已知問題，將會在未來的正式版修正 (或是最新的測試版)"
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "警告: 你的DBM已經過期，DBM已被禁用直到你更新至最新版，因為遊戲大改版。為了不讓舊的程式碼拖累遊戲體驗。請至deadlybossmods.com或是curse下載最新版本的DBM。"
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "警告: 你使用的DBM版本和遊戲版本不相容。請到deadlybossmods.com或是curse下載符合你遊戲版本的DBM。"
DBM_CORE_VEM							= "警告: 你同時使用DBM和VEM。DBM將停用而無法執行。"
DBM_CORE_3RDPROFILES					= "警告: DBM-Profiles不相容此版本DBM。請移除避免衝突。"
DBM_CORE_VICTORYSOUND				= "警告：DBM-VictorySound不相容此版本DBM。請移除避免衝突。"
DBM_CORE_DPMCORE						= "警告: Deadly PvP 模組已經停止更新而且不相容此版本的DBM。請先移除以避免衝突。"
DBM_CORE_DBMLDB						= "警告: DBM-LDB已內建在DBM-核心。雖然它不會造成任何傷害，但建議從addons資料夾中刪除“DBM-LDB”"
DBM_CORE_DBMLOOTREMINDER				= "警告：已安裝第三方模組 DBM-LootReminder。 此附加插件不再與正式版WOW客戶端相容，並且將導致DBM中斷並且無法發送請求計時器。 建議卸載此插件。"
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "警告: 如果你沒有重啟你的遊戲，這次DBM更新可能無法正確運作。這次更新包含了新的檔案或是.toc檔更新而不能使用ReloadUI載入。如果沒有將遊戲完全重啟可能會導致錯誤或功能不完整。"
DBM_CORE_OUT_OF_DATE_NAG				= "你的"..DBM_DEADLY_BOSS_MODS.."版本已經過期你設定忽略彈出更新提示。還是建議你更新避免缺少一些重要的警告或是計時器，而其他人也看不到從你發出的大喊警告。"
DBM_CORE_RETAIL_ONLY					= "警告: 此版本的DBM僅適用於最新正式版魔獸世界。反安裝此版本並為經典魔獸世界安裝正確的DBM版本。"

DBM_CORE_MOVABLE_BAR				= "拖動我!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h向你發送了一個倒數計時"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在該次遊戲連結中忽略來自%s的計時？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <時間（秒）> <文字>。<時間>必須大於等於3"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "按下Shift並拖曳即可移動"

DBM_CORE_RANGECHECK_HEADER			= "距離監視(%dD)"
DBM_CORE_RANGECHECK_HEADERT			= "距離監視 (%dD-%dP)"
DBM_CORE_RANGECHECK_RHEADER			= "R-距離監視 (%dD)"
DBM_CORE_RANGECHECK_RHEADERT		= "R-距離監視 (%dD-%dP)"
DBM_CORE_RANGECHECK_SETRANGE		= "設置距離"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "設置玩家數量門檻"
DBM_CORE_RANGECHECK_SOUNDS			= "音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "當一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "當多於一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_0			= "沒有音效"
DBM_CORE_RANGECHECK_SOUND_1			= "預設音效"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鳴聲"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d D"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "框架"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "顯示雷達框架"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "顯示文字框"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "兩者都顯示"
DBM_CORE_RANGERADAR_HEADER			= "距離:%d玩家(%d)"
DBM_CORE_RANGERADAR_RHEADER			= "反距離:%d玩家:%d"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d在範圍內(%dD)"--Multi
DBM_CORE_RANGECHECK_IN_RANGE_TEXT	= "%d在範圍內"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fD)"--One target

DBM_CORE_INFOFRAME_SHOW_SELF		= "總是顯示你的能量"
DBM_CORE_INFOFRAME_SETLINES			= "設定最大行數"
DBM_CORE_INFOFRAME_LINESDEFAULT		= "由插件設定"
DBM_CORE_INFOFRAME_LINES_TO			= "%d 行"
DBM_CORE_INFOFRAME_POWER			= "能量"
DBM_CORE_INFOFRAME_AGGRO			= "仇恨"
DBM_CORE_INFOFRAME_MAIN				= "主要："--Main power
DBM_CORE_INFOFRAME_ALT				= "次要："--Alternate Power

DBM_LFG_INVITE						= "地城準備確認"

DBM_CORE_SLASHCMD_HELP				= {
	"可用指令：",
	"-----------------",
	"/dbm unlock：顯示一個可移動的計時器（也可使用：move）。",
	"/range <數字> or /distance <數字>: 顯示距離框架。/rrange 或 /rdistance 顯示相反色。",
	"/hudar <數字>: 顯示基於距離查詢的HUD。",
	"/dbm timer: 開始一個自訂的DBM計時器，輸入'/dbm timer'獲得更多訊息。",
	"/dbm arrow: 顯示DBM箭頭，輸入'/dbm arrow help'獲得更多訊息。",
	"/dbm hud: 顯示DBM hud，輸入'/dbm hud'獲得更多訊息。",
	"/dbm help2: 顯示團隊管理指令",
}
DBM_CORE_SLASHCMD_HELP2				= {
	"可用指令：",
	"-----------------",
	"/dbm pull <秒數>: 開始備戰計時器<秒數>。向所有團隊成員發送一個DBM備戰計時器（需要權限）。",
	"/dbm break <分鐘>: 開始休息計時器<分鐘>。向所有團隊成員發送一個DBM休息計時器（需要權限）。",
	"/dbm version: 進行首領插件的版本檢測（也可使用：ver）。",
	"/dbm version2: 進行首領插件的版本檢測同時也密語提醒過期的使用者（也可使用：ver2）。",
	"/dbm lockout: 向團隊成員請求他們當前的團隊副本鎖定訊息(鎖定訊息、副本id) (需要權限)。",
	"/dbm lag: 進行團隊範圍內的網路延遲檢測。",
	"/dbm durability: 進行團隊範圍內的裝備耐久度檢測。"
}
DBM_CORE_TIMER_USAGE	= {
	"DBM計時器指令：",
	"-----------------",
	"/dbm timer <秒數> <文字>: 開始一個時間為<秒數>秒並以<文字>為名稱的計時器。",
	"/dbm ltimer <秒數> <文字>: 開始一個時間為<秒數>秒的計時器同時無限循環直到取消。",
	"(在任何計時器指令前加入'Broadcast'可以把指令分享給團隊，如果有團隊隊長或助理權限)",
	"/dbm timer endloop: 停止任何無限循環ltimer的計時器。",
}

DBM_ERROR_NO_PERMISSION				= "無權進行此操作。"

--Common Locals
DBM_NEXT									= "下一次%s"
DBM_COOLDOWN						= "%s冷卻"
DBM_CORE_UNKNOWN			= "未知"
DBM_CORE_LEFT						= "左"
DBM_CORE_RIGHT						= "右"
DBM_CORE_BOTH						= "兩邊"
DBM_CORE_BACK						= "後"
DBM_CORE_SIDE						= "側邊"
DBM_CORE_TOP							= "上"
DBM_CORE_BOTTOM				= "下"
DBM_CORE_MIDDLE					= "中"
DBM_CORE_FRONT					= "前"
DBM_CORE_EAST						= "東"
DBM_CORE_WEST						= "西"
DBM_CORE_NORTH					= "北"
DBM_CORE_SOUTH					= "南"
DBM_CORE_INTERMISSION		= "中場時間"
DBM_CORE_ORB							= "球"
DBM_CORE_ORBS						= "球"
DBM_CHEST									= "獎勵箱"
DBM_NO_DEBUFF						= "沒有%s"
DBM_ALLY									= "隊友"
DBM_ALLIES									= "隊友"--Such as "Move to Ally"
DBM_ADD									= "小怪"
DBM_ADDS									= "小怪"
DBM_BIG_ADD							= "大怪"
DBM_BOSS									= "首領"
DBM_CORE_ROOM_EDGE		= "房間邊緣"
DBM_CORE_FAR_AWAY				= "遠離"
DBM_CORE_BREAK_LOS			= "卡視角"
DBM_CORE_RESTORE_LOS		= "恢復/保持視角"
DBM_CORE_SAFE						= "安全"
DBM_CORE_NOTSAFE				= "不安全"
DBM_CORE_SHIELD					= "護盾"
DBM_INCOMING						= "%s 來了"
--Common Locals end

DBM_CORE_BREAK_USAGE				= "休息時間不可以長過60分鐘。請確定您輸入的時間是分鐘而不是秒。"
DBM_CORE_BREAK_START					= "現在開始休息-你有%s分鐘! (由 %s 發送)"
DBM_CORE_BREAK_MIN					= "%s分鐘後休息時間結束!"
DBM_CORE_BREAK_SEC						= "%s秒後休息時間結束!"
DBM_CORE_TIMER_BREAK					= "休息時間!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息結束於%s"

DBM_CORE_TIMER_PULL							= "戰鬥準備"
DBM_CORE_ANNOUNCE_PULL					= "%d秒後拉怪 (%s發起)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "拉怪囉!"
DBM_CORE_ANNOUNCE_PULL_TARGET		= "%2$d秒後開打%1$s! (%3$s 發起)"
DBM_CORE_ANNOUNCE_PULL_NOW_TARGET	= "%s現在開打!"
DBM_CORE_GEAR_WARNING						= "警告：檢查裝備。你的所裝備的裝備等級低於包包中的裝備%d個等級。"
DBM_CORE_GEAR_WARNING_WEAPON		= "警告：檢查你是否裝備正確的武器。"
DBM_CORE_GEAR_FISHING_POLE			= "釣魚竿"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "成就"

DBM_CORE_AUTO_ANNOUNCE_TEXTS.you					= "你中了%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target				= "%s:>%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetsource	= ">%%s< 施放 %s 在 >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount		= "%s (%%s):>%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell				= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends 				= "%s結束"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget		= "%s結束:>%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades				= "%s消退"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds				= "%s還剩下:%%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast					= "施放%s:%.1f秒"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon				= "%s即將到來"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.sooncount		= "%s (%%s)即將到來"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.countdown	= "%s還有%%ds"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn			= "%s在%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.bait					= "%s即將到來 - 快引誘"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage				= "第%s階段"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prestage			= "第%s階段即將到來"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count				= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack				=">%%s<中了%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.moveto			= "%s - 移動到>%%s<"

local prewarnOption			= "預先警告：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.you				= "警告：中了$spell:%s時"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target				= "警告：$spell:%s的目標"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetsource	= "警告：$spell:%s的目標(包含來源)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "警告：$spell:%s的目標(包含計數)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell				= "警告：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends				= "警告：$spell:%s結束"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget		= "警告：$spell:%s結束"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades				= "警告：$spell:%s消退"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds				= "警告：$spell:%s剩餘數量"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast				= "警告：$spell:%s的施放"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon				= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.sooncount		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.countdown	= "預先警告：$spell:%s的倒數計時訊息"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.bait				= "警告：$spell:%s去引誘的預先警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stage				= "警告：第%s階段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phasechange	= "警告：階段轉換"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stagechange	= "預先警告：第%s階段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count				= "警告：$spell:%s(包含計數)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack				= "警告：$spell:%s疊加層數"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.moveto			= "警告：$spell:%s需要移動到某人或某個地方"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends 				= "%s結束"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s消退"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "%s即將到來"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.sooncount		= "%s (%%s)即將到來"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.bait					= "%s即將到來 - 快引誘"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s在%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel				= ">%%s<中了%s - 現在驅散"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - 快中斷>%%s< !"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount= "%s - 快中斷>%%s< !(%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you					= "你中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youcount		= "你中了%s (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youpos			= "你中了%s (位置：%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soakpos			= "%s - 快到%%s分傷"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target				= ">%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetcount		= ">%%2$s<中了%s (%%1$s) "
DBM_CORE_AUTO_SPEC_WARN_TEXTS.defensive		= "%s - 使用防禦技能"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= ">%%s<中了%s - 快嘲諷"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close				= "你附近的>%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move				= "%s - 快移動"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.keepmove		= "%s - 保持移動"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stopmove		= "%s - 停止移動"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge				= "%s - 閃避攻擊"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgecount	= "%s (%%s) - 閃避攻擊"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgeloc		= "%s - 閃避技能 %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveawaycount	= "%s (%%s) - 快離開其他人"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway		= "%s - 快離開其他人"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - 快跑向>%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soak				= "%s - 踩圈分擔"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.jump				= "%s - 快跳躍"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run					= "%s - 快跑開"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast					= "%s - 停止施法"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.lookaway		= "%s 點名 %%s - 快轉頭"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect				= ">%%s<中了%s - 停止攻擊"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count				= "%s!(%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack				= "你中了%%d層%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch				= "%s - 快更換目標!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount	= "%s - 快更換目標！(%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.gtfo					= "%%s 注意腳下 - 快移動"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.adds				= "小怪出現 - 快更換目標！"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.addscustom	= "小怪來了 - %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetchange	= "更換目標 - 轉火 %%s"

DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell					= "特別警告：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends					= "特別警告：$spell:%s結束"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades					= "特別警告：$spell:%s消退"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon					= "特別警告：$spell:%s即將到來"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.sooncount			= "特別警告：$spell:%s (包含計數)即將到來"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.bait						= "特別警告：$spell:%s(當誘餌)預先顯示"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 			= "特別警告：$spell:%s在%d秒前預先顯示"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel					= "特別警告：需要驅散或偷取$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt			= "特別警告：需要中斷$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= "特別警告：需要中斷$spell:%s (包含計數)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you						= "特別警告：當你中了$spell:%s時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youcount			= "特別警告：當你中了$spell:%s時 (包含計數)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youpos				= "特別警告：當你中了$spell:%s時 (包含站位)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soakpos				= "特別警告：當需要為$spell:%s分傷時(包含站位)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target					= "特別警告：當他人中了$spell:%s時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetcount 		= "特別警告：當他人中了$spell:%s時 (包含計數)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.defensive 			= "特別警告：當需要使用$spell:%s技能來減傷時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 					= "特別警告：當另外一個坦中了$spell:%s並需要你嘲諷時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close					= "特別警告：當你附近有人中了$spell:%s時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move					= "特別警告：當你中了$spell:%s時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.keepmove 		= "特別警告：當你中了$spell:%s需要保持移動時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stopmove 			= "特別警告：當你中了$spell:%s需要停止移動時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge					= "特別警告：當你中了$spell:%s並需要躲開攻擊"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgecount		= "特別警告：當你中了$spell:%s並需要躲開攻擊 (包含計數)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgeloc			= "特別警告：當你需要閃避$spell:%s技能時(包含站位)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway			= "特別警告：當你中了$spell:%s並需要跑開人群時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveawaycount	= "特別警告：當你中了$spell:%s並需要跑開人群時 (包含計數)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto				= "特別警告：當中了$spell:%s並需要你去靠近某人或某地點時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soak					= "特別警告：當需要你去踩圈分擔$spell:%s時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.jump					= "特別警告：當你中了$spell:%s需要跳起來時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run						= "特別警告：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast					= "特別警告：$spell:%s的施放（停止施法）"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.lookaway			= "特別警告：當需要為$spell:%s轉頭時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 				= "特別警告：$spell:%s需要停止攻擊"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 				= "特別警告：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack					= "特別警告：當疊加了>=%d層$spell:%s時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch 				= "特別警告：針對$spell:%s需要轉換目標"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount		= "特別警告：針對$spell:%s需要轉換目標 (包含計數)"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.gtfo 					= "特別警告：當地板出現危險的東西需要躲開時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.adds					= "特別警告：當小怪出現需要更換目標時"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.addscustom		= "特別警告：即將到來的小怪"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetchange		= "特別警告：當需要更換主要目標時"

DBM_CORE_AUTO_TIMER_TEXTS.target				= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.cast					= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.castshort		= "%s "
DBM_CORE_AUTO_TIMER_TEXTS.castcount			= "%s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.castcountshort	= "%s (%%s) "
DBM_CORE_AUTO_TIMER_TEXTS.castsource		= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.castsourceshort	= "%s: %%s "
DBM_CORE_AUTO_TIMER_TEXTS.active				= "%s結束"
DBM_CORE_AUTO_TIMER_TEXTS.fades					= "%s消退"
DBM_CORE_AUTO_TIMER_TEXTS.ai						= "%s AI"
DBM_CORE_AUTO_TIMER_TEXTS.cd						= "%s冷卻"
DBM_CORE_AUTO_TIMER_TEXTS.cdshort			= "~%s"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount			= "%s冷卻 (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.cdcountshort	= "~%s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource			= "%s冷卻:>%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdsourceshort	= "~%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial			= "特別技能冷卻"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecialshort	= "~特別技能"
DBM_CORE_AUTO_TIMER_TEXTS.next 					= "下一次%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextshort		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount 		= "下一次%s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextcountshort	= "%s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource		= "下一次%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.nextsourceshort	= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial		= "下一次特別技能"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecialshort= "特別技能"
DBM_CORE_AUTO_TIMER_TEXTS.achievement		= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.stage					= "下一個階段"
DBM_CORE_AUTO_TIMER_TEXTS.stageshort		= "階段"
DBM_CORE_AUTO_TIMER_TEXTS.adds					= "小怪到來"
DBM_CORE_AUTO_TIMER_TEXTS.addsshort		= "小怪"
DBM_CORE_AUTO_TIMER_TEXTS.addscustom  	= "小怪出現(%s%s)"
DBM_CORE_AUTO_TIMER_TEXTS.addscustomshort	= "小怪 (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.roleplay			= GUILD_INTEREST_RP

DBM_CORE_AUTO_TIMER_OPTIONS.target				= "計時條：$spell:%s減益效果持續時間"
DBM_CORE_AUTO_TIMER_OPTIONS.cast					= "計時條：$spell:%s施法時間"
DBM_CORE_AUTO_TIMER_OPTIONS.castcount		= "計時條：$spell:%s施法時間(包含計數)"
DBM_CORE_AUTO_TIMER_OPTIONS.castsource		= "計時條：$spell:%s施放(包含來源)"
DBM_CORE_AUTO_TIMER_OPTIONS.active				= "計時條：$spell:%s效果持續時間"
DBM_CORE_AUTO_TIMER_OPTIONS.fades				= "計時條：$spell:%s何時從玩家身上消失"
DBM_CORE_AUTO_TIMER_OPTIONS.ai						= "計時條：$spell:%s冷卻的AI計時條"
DBM_CORE_AUTO_TIMER_OPTIONS.cd					= "計時條：$spell:%s冷卻時間"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount			= "計時條：$spell:%s冷卻時間"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource			= "計時條：$spell:%s冷卻時間以及來源"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial			= "計時條：特殊技能冷卻"
DBM_CORE_AUTO_TIMER_OPTIONS.next					= "計時條：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount		= "計時條：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource		= "計時條：下一次$spell:%s以及來源"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial		= "計時條：下一次特殊技能"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "計時條：成就%s"
DBM_CORE_AUTO_TIMER_OPTIONS.stage				= "計時條：下一階段"
DBM_CORE_AUTO_TIMER_OPTIONS.adds				= "計時條：下一次小怪"
DBM_CORE_AUTO_TIMER_OPTIONS.addscustom	= "計時條：小怪出現"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay			= "計時條：劇情持續時間"

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "為$spell:%s的目標設置標記"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "為$spell:%s設置標記"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "為跑向中了$spell:%s的目標顯示"..DBM_DBM.."箭頭"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "為離開中了$spell:%s的目標顯示"..DBM_DBM.."箭頭"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "為中了$spell:%s後移動到特定區域顯示"..DBM_DBM.."箭頭"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortyell	= "當你中了$spell:%s時大喊"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yell		= "當你中了$spell:%s時大喊(玩家名字)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.count	= "當你中了$spell:%s時大喊(次數)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.fade		= "當$spell:%s正消退時大喊(倒數和技能名稱)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortfade	= "當$spell:%s正消退時大喊(倒數)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.iconfade		= "當$spell:%s正消退時大喊(倒數與圖示)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.position	= "當你中了$spell:%s時大喊(包含位置)"
DBM_CORE_AUTO_YELL_OPTION_TEXT.combo			= "當你同時中了$spell:%s與其他法術時大喊(包含自訂文字)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell	= "%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell	= "" .. UnitName("player") .. "中了%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.count	= "" .. UnitName("player") .. "中了%s(%%d)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.fade	= "%s %%d秒後消退!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortfade	= "%%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.iconfade		= "{rt%%2$d}%%1$d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.position = UnitName("player").." ({rt%%3$d})中了%1$s! (%%1$s - {rt%%2$d})" 
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.combo			= "%s與%%s"--Spell name (from option, plus spellname given in arg)

DBM_CORE_AUTO_YELL_CUSTOM_FADE			= "%s已消退"
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "為$spell:%s顯示HudMap(不再作用)"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "為不同的機制顯示HudMap(不再作用)"
DBM_CORE_AUTO_NAMEPLATE_OPTION_TEXT		= "為$spell:%s顯示姓名版光環"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "為$spell:%2$s顯示距離框架(%1$s碼)"
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "顯示距離框架(%s碼)"
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "為$spell:%2$s顯示反色距離框架(%1$s碼)"--Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "顯示反色距離框架(%s碼)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "為$spell:%s顯示訊息框架"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT2	= "為戰鬥概覽顯示訊息框架"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "當首領開打時撥放準備檢查的音效(即使沒有選定目標)"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "可移動提示"
DBM_CORE_MOVE_WARNING_MESSAGE		= "感謝您使用"..DBM_DEADLY_BOSS_MODS..""
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "可拖動的特別警告"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "特別警告"

DBM_CORE_HUD_INVALID_TYPE			= "無效的HUD類型定義"
DBM_CORE_HUD_INVALID_TARGET			= "無有效的HUD目標"
DBM_CORE_HUD_INVALID_SELF			= "不能將HUD目标設定成自己"
DBM_CORE_HUD_INVALID_ICON			= "不能設定對無團隊標記的目標"
DBM_CORE_HUD_SUCCESS				= "HUD成功使用你的參數運作。這會在%s後取消，或是使用'/dbm hud hide'指令取消。"
DBM_CORE_HUD_USAGE	= {
	"DBM-HudMap 用法:",
	"/dbm hud <類型> <目標> <持續時間>: 建立一個指向玩家的HUD",
	"有效類型: arrow, dot, red, blue, green, yellow, icon(需要團隊標記)",
	"有效目標: target, focus, <玩家名字>",
	"有效持續時間: 任何秒數。如果無輸入值則預設為20分鐘",
	"/dbm hud hide  停用玩家生成的HUD物件"
}

DBM_ARROW_MOVABLE					= "可移動箭頭"
DBM_ARROW_WAY_USAGE					= "/dway <x> <y>: 建立一個箭頭指向一個指定地點 (使用本地區域地圖座標)"
DBM_ARROW_WAY_SUCCESS				= "要隱藏箭頭，鍵入 '/dbm arrow hide' 或到達箭頭"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 用法:",
	"/dbm arrow <x> <y>: 建立一個箭頭在特定的位置(使用世界地圖座標)",
	"/dbm arrow map <x> <y>: 建立一個箭頭在特定的位置 (使用小地圖座標)",
	"/dbm arrow <玩家>: 建立並箭頭指向你的隊伍或團隊中特定的玩家",
	"/dbm arrow hide: 隱藏箭頭",
	"/dbm arrow move: 可移動箭頭"
}

DBM_SPEED_KILL_TIMER_TEXT	= "勝利紀錄"
DBM_SPEED_CLEAR_TIMER_TEXT	= "最佳紀錄"
DBM_COMBAT_RES_TIMER_TEXT	= "下一個戰復充能"
DBM_CORE_TIMER_RESPAWN		= "%s 重生"


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
--DBM_INSTANCE_INFO_SHOW_RESULTS		= "仍未回覆的玩家: %s\n|HDBM:showRaidIdResults|h|cff3588ff[查看結果]|r|h"
DBM_INSTANCE_INFO_SHOW_RESULTS		= "仍未回覆的玩家: %s"

DBM_CORE_LAG_CHECKING				= "檢測團隊成員的網路延遲中..."
DBM_CORE_LAG_HEADER					= ""..DBM_DEADLY_BOSS_MODS.." - 網路延遲結果"
DBM_CORE_LAG_ENTRY					= "%s:世界延遲[%d毫秒]/本地延遲[%d毫秒]"
DBM_CORE_LAG_FOOTER					= "無回應:%s"

DBM_CORE_DUR_CHECKING				= "檢測團隊裝備耐久度..."
DBM_CORE_DUR_HEADER					= ""..DBM_DEADLY_BOSS_MODS.." - 裝備耐久度結果"
DBM_CORE_DUR_ENTRY					= "%s:耐久度[%d百分比]/裝備損壞[%s]"
DBM_CORE_LAG_FOOTER					= "無回應:%s"


--LDB
DBM_LDB_TOOLTIP_HELP1	= "點擊開啟"..DBM_DBM..""
--DBM_LDB_TOOLTIP_HELP2	= "右鍵開啟設置選單"
DBM_LDB_LOAD_MODS		= "載入首領模組"
DBM_LDB_CAT_OTHER		= "其他首領模組"
DBM_LDB_CAT_GENERAL		= "一般"
DBM_LDB_ENABLE_BOSS_MOD	= "啟用首領模組"
