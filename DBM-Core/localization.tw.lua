if GetLocale() ~= "zhTW" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

local dateTable = date("*t")
if dateTable.day and dateTable.month and dateTable.day == 1 and dateTable.month == 4 then
	L.DEADLY_BOSS_MODS					= "Harmless Minion Mods"
	L.DBM								= "HMM"
end

L.HOW_TO_USE_MOD				= "歡迎使用"..L.DBM.."。在聊天頻道輸入 /dbm 打開設定開始設定。你可以載入特定區域後為任何首領設定你喜歡的特別設置。"..L.DBM.."會在設定你的職業天賦的預設值，但有些選項可能需要調整。"
L.SILENT_REMINDER				= "提醒："..L.DBM.."正處於無聲模式。"
L.NEWS_UPDATE					= "|h|c11ff1111更新說明|r|h: DBM已更新並對模組結構做了更動，因此經典版和正式版現在使用統一的（相同）模組。這意味著經典版(包含探索賽季)、燃燒的遠征、巫妖王之怒以及浩劫與重生現在分別下載並使用與正式版相同的插件包。 讀取更多訊息在|Hgarrmission:DBM:news|h|cff3588ff[此處]|r|h"
L.NEWS_UPDATE_REPEAT			= "|h|c11ff1111更新說明|r|h: DBM已更新並對模組結構做了更動，因此經典版和正式版現在使用統一的（相同）模組。這意味著經典版(包含探索賽季)、燃燒的遠征、巫妖王之怒以及浩劫與重生現在分別下載並使用與正式版相同的插件包。你目前正在缺少模組的團隊副本中。此訊息將持續顯示 (並且您將沒有此區域的功能警報) 直到你安裝了缺少的團隊副本模組為止。"


L.COPY_URL_DIALOG_NEWS			= "要閱讀最新說明，請拜訪以下連結"

L.LOAD_MOD_ERROR				= "載入%s模組時發生錯誤：%s"
L.LOAD_MOD_SUCCESS				= "成功載入%s模組。更多選項例如自訂警告音效或是個人提醒註記請輸入/dbm或/dbm help。"
L.LOAD_MOD_COMBAT				= "延遲載入'%s'直到離開戰鬥"
L.LOAD_GUI_ERROR				= "無法載入圖形介面：%s"
L.LOAD_GUI_COMBAT				= "圖形介面不能在戰鬥中初始化。圖形介面將在脫離戰鬥後自動讀取，這樣就能夠再次在戰鬥中使用。"
L.BAD_LOAD						= L.DBM.."偵測到你的此副本的模組在戰鬥中讀取失敗。一旦脫離戰鬥，請立即輸入/consoel reloadui重新載入。"
L.LOAD_MOD_VER_MISMATCH			= "%s不能被讀取因為你的"..L.DBM.."核心未達需求，請更新版本。"
L.LOAD_MOD_EXP_MISMATCH			= "%s不能被讀取因為這是設計給WoW資料片而目前尚未開放。當資料片開放時，此模組會自動啟用。"
L.LOAD_MOD_TOC_MISMATCH			= "%s不能被讀取因為這是設計給WoW更新檔(%s)而目前尚未開放。當更新檔更新時，此模組會自動啟用。"
L.LOAD_MOD_DISABLED				= "%s已安裝但目前停用中。此模組不會載入除非你啟用它。"
L.LOAD_MOD_DISABLED_PLURAL		= "%s已安裝但目前停用中。這些模組不會載入除非你啟用它們。"

L.COPY_URL_DIALOG				= "複製網址"
L.COPY_WA_DIALOG				= "複製WA鍵"

--Post Patch 7.1
L.TEXT_ONLY_RANGE				= "範圍框架受限於該區域的API限制，只限於文字。"
L.NO_RANGE						= "距離雷達不能在副本中使用，使用傳統文字距離框架取代"
L.NO_ARROW						= "箭頭不能在副本中使用"
L.NO_HUD						= "HUDMap不能在副本中使用"

L.DYNAMIC_DIFFICULTY_CLUMP		= L.DBM.."已中禁用動態距離框架，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
L.DYNAMIC_ADD_COUNT				= L.DBM.."已中禁用小怪計數警告，你目前的團隊人數在這場戰鬥中的機制資訊不足。"
L.DYNAMIC_MULTIPLE				= L.DBM.."已中禁用多項功能，你目前的團隊人數在這場戰鬥中的機制資訊不足。"

L.LOOT_SPEC_REMINDER			= "你目前的專精為:%s。而你目前的拾取選擇為:%s。"

L.BIGWIGS_ICON_CONFLICT			= L.DBM.."偵測到你同時開啟BigWigs和"..L.DBM.."的團隊圖示。請關閉其中之一的團隊圖示功能以免產生衝突。"

L.MOD_AVAILABLE					= "%s在此區域有模組可用但未安裝。你可以在Curse、Wago、WoWI或從GitHub正式版頁面下載。"
L.MOD_MISSING					= "無團隊模組"

L.COMBAT_STARTED				= "%s開戰。祝好運與盡興! :)"
L.COMBAT_STARTED_IN_PROGRESS	= "與%s開戰已進行的戰鬥。祝好運與盡興! :)"
L.GUILD_COMBAT_STARTED			= "%s已經與%s的公會團隊開戰！"
L.SCENARIO_STARTED				= "%s開始。祝好運與盡興! :)"
L.SCENARIO_STARTED_IN_PROGRESS	= "加入進行中的%s事件。祝好運與盡興! :)"
L.BOSS_DOWN						= "擊敗%s，用了%s!"
L.BOSS_DOWN_I					= "擊敗%s!你已勝利了%d次。"
L.BOSS_DOWN_L					= "擊敗%s!本次用了%s，上次用了%s，最快紀錄為%s。你總共戰勝了%d次。"
L.BOSS_DOWN_NR					= "擊敗%s!用了%s! 這是一個新記錄! (舊紀錄為%s) 你總共戰勝了%d次。"
L.RAID_DOWN						= "%s清除 用了%s！"
L.RAID_DOWN_L					= "%s清除 用時%s！你最快的清除紀錄 %s。"
L.RAID_DOWN_NR					= "%s清除 用時%s！這是一個新紀錄！(舊紀錄為 %s)。"
L.GUILD_BOSS_DOWN				= "已擊敗%s，在%s的公會團隊用了%s！"
L.SCENARIO_COMPLETE				= "%s完成!用了%s!"
L.SCENARIO_COMPLETE_I			= "%s完成! 你總共完成了%d次。"
L.SCENARIO_COMPLETE_L			= "%s完成!本次用了%s，上次用了%s，最快紀錄為%s。你總共完成了%d次。"
L.SCENARIO_COMPLETE_NR			= "%s完成!用了%s! 這是一個新記錄! (舊紀錄為%s) 你總共完成了%d次。"
L.COMBAT_ENDED_AT				= "%s(%s)的戰鬥經過%s結束。"
L.COMBAT_ENDED_AT_LONG			= "%s(%s)的戰鬥經過%s結束。你在這個難度總共滅團了%d次。"
L.GUILD_COMBAT_ENDED_AT			= "%s的公會團隊在%s (%s)的戰鬥滅團，經過%s."
L.SCENARIO_ENDED_AT				= "%s結束!用了%s!"
L.SCENARIO_ENDED_AT_LONG		= "%s結束!本次用了%s，你已有共%d次未完成的嘗試在這個難度裡。"
L.COMBAT_STATE_RECOVERED		= "%s的戰鬥在%s前開始，恢復計時器中..."
L.TRANSCRIPTOR_LOG_START		= "Transcriptor開始記錄。"
L.TRANSCRIPTOR_LOG_END			= "Transcriptor結束紀錄。"

L.MOVIE_SKIPPED					= L.DBM.."已嘗試自動略過一個過場動畫。"
L.MOVIE_NOTSKIPPED				= L.DBM .. "已經發現了一個可跳過的過場動畫，但由於暴雪的bug沒有跳過。當bug被修復時，跳過將重新啟用。"
L.BONUS_SKIPPED					= L.DBM.."已經自動關閉額外戰利品擲骰框架。如果你需要恢復此框架，在三分鐘內輸入/dbmbonusroll"

L.AFK_WARNING					= "你正在暫離並戰鬥中(血量還剩餘%d百分比)所以發出警告。如果你並非暫離，請清除暫離的標籤或是在'額外功能'停用此選項。"

L.COMBAT_STARTED_AI_TIMER		= "我的CPU是一個神經網路處理器;一個學習中的電腦 (這場戰鬥將使用新的計時器AI功能生成近似值的計時條)"

L.PROFILE_NOT_FOUND				= "<"..L.DBM..">你目前的配置檔已經損毀。"..L.DBM.."會載入'Default'配置檔。"
L.PROFILE_CREATED				= "配置檔'%s'已建立。"
L.PROFILE_CREATE_ERROR			= "建立配置檔失敗，無效的配置檔名稱。"
L.PROFILE_CREATE_ERROR_D		= "建立配置檔失敗，配置檔'%s'已存在。"
L.PROFILE_APPLIED				= "配置檔'%s'已套用。"
L.PROFILE_APPLY_ERROR			= "套用配置檔失敗，配置檔'%s'不存在。"
L.PROFILE_COPIED				= "配置檔'%s'已複製。"
L.PROFILE_COPY_ERROR			= "複製配置檔失敗，配置檔'%s'不存在。"
L.PROFILE_COPY_ERROR_SELF		= "不能複製配置檔到本身來源。"
L.PROFILE_DELETED				= "配置檔'%s'已刪除。配置檔'Default'會被套用。"
L.PROFILE_DELETE_ERROR			= "刪除配置檔失敗，配置檔'%s'不存在。"
L.PROFILE_CANNOT_DELETE			= "不能刪除'Default'配置檔。"
L.MPROFILE_COPY_SUCCESS			= "%s's (%d專精)模組設定已被複製。"
L.MPROFILE_COPY_SELF_ERROR		= "不能複製角色設定到本身來源"
L.MPROFILE_COPY_S_ERROR			= "配置檔來源已經損毀，設定不能被複製或是部分複製，複製已失敗。"
L.MPROFILE_COPYS_SUCCESS		= "%s's (%d專精)模組音效或註記設定已被複製。"
L.MPROFILE_COPYS_SELF_ERROR		= "不能複製角色音效或註記設定到本身來源"
L.MPROFILE_COPYS_S_ERROR		= "配置檔來源已經損毀，音效或註記設定不能被複製或是部分複製，複製已失敗。"
L.MPROFILE_DELETE_SUCCESS		= "%s's (%d專精)模組設定已被刪除。"
L.MPROFILE_DELETE_SELF_ERROR	= "不能刪除使用中的模組設定。"
L.MPROFILE_DELETE_S_ERROR		= "配置檔來源已經損毀，設定不能被刪除或是部分刪除，刪除已失敗。"

L.NOTE_SHARE_SUCCESS			= "%s已分享他的%s的註記"
L.NOTE_SHARE_LINK				= "點擊這裡打開註記"
L.NOTE_SHARE_FAIL				= "%s嘗試與你分享%s的註記。模組相關的技能沒有安裝或是載入。請確定你載入此模組並請求他們在分享一次。"

L.NOTEHEADER					= "為%s輸入你的註記。在><插入腳色名稱可套用職業顏色。多個註記請使用'/'分開"
L.NOTEFOOTER					= "按下'確定'接受變更或'取消'放棄變更"
L.NOTESHAREDHEADER				= "%s已分享%s的註記。接受註記會覆蓋你原有的註記。"
L.NOTESHARED					= "你的註記已經送出至隊伍"
L.NOTESHAREERRORSOLO			= "寂寞嗎?不應該能分享注意給你自己"
L.NOTESHAREERRORBLANK			= "不能分享空白註記"
L.NOTESHAREERRORGROUPFINDER		= "註記不能被分享在戰場、隨機團隊或隨機隊伍"
L.NOTESHAREERRORALREADYOPEN		= "不能開啟分享註記連結當註記編輯器已經被打開，避免你失去正在編輯的註記"

L.ALLMOD_DEFAULT_LOADED			= "此副本所有的選項設定已套用預設值。"
L.ALLMOD_STATS_RESETED			= "所有模組狀態已經被重置。"
L.MOD_DEFAULT_LOADED			= "此戰鬥的預設選項已套用。"

L.WORLDBOSS_ENGAGED				= "在你的伺服器上的%s已在百分之%s時開戰(%s發送)。"
L.WORLDBOSS_DEFEATED			= "在你的伺服器上的%s已被擊敗(%s發送)。"
L.WORLDBUFF_STARTED				= "在你的伺服器上的%s增益已由%s陣營開始(%s發送)。"

L.TIMER_FORMAT_SECS				= "%.2f秒"
L.TIMER_FORMAT_MINS				= "%d分鐘"
L.TIMER_FORMAT					= "%d分%.2f秒"

L.MIN							= "分"
L.MIN_FMT						= "%d分"
L.SEC							= "秒"
L.SEC_FMT						= "%s秒"

L.GENERIC_WARNING_OTHERS		= "與一個其他"
L.GENERIC_WARNING_OTHERS2		= "與其他%d"
L.GENERIC_WARNING_BERSERK		= "%s%s後狂暴"
L.GENERIC_TIMER_BERSERK			= "狂暴"
L.OPTION_TIMER_BERSERK			= "為$spell:26662顯示計時器"
L.BAD							= "地板技能"

L.OPTION_CATEGORY_TIMERS			= "計時條"
--Sub cats for "announce" object
L.OPTION_CATEGORY_WARNINGS			= "一般提示"
L.OPTION_CATEGORY_WARNINGS_YOU		= "個人提示"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "目標提示"
L.OPTION_CATEGORY_WARNINGS_ROLE		= "角色專精提示"
L.OPTION_CATEGORY_SPECWARNINGS		= "特別提示"

L.OPTION_CATEGORY_SOUNDS			= "音效"
--Misc object broken down into sub cats
L.OPTION_CATEGORY_DROPDOWNS			= "下拉選項"
L.OPTION_CATEGORY_YELLS				= "大喊"
L.OPTION_CATEGORY_NAMEPLATES		= "名條"
L.OPTION_CATEGORY_ICONS				= "圖示"
L.OPTION_CATEGORY_PAURAS			= "個人光環"

L.AUTO_RESPONDED						= "已自動回覆密語。"
L.STATUS_WHISPER						= "%s：%s，%d/%d存活。"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s正在與%s交戰（當前%s，%d/%d存活）"
L.WHISPER_COMBAT_END_KILL			= "%s已經擊敗%s!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s已經擊敗%s! 他們總共已擊殺了%d次。"
L.WHISPER_COMBAT_END_WIPE_AT		= "%s在%s還有%s時滅團了。"
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s在%s還有%s時滅團了。他們在這個難度總共滅團了%d次。"
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s忙碌於%s(%d/%d存活)"
L.WHISPER_SCENARIO_END_KILL			= "%s已經完成%s!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s已經完成%s!他們總共有%d次勝利。"
L.WHISPER_SCENARIO_END_WIPE			= "%s未完成%s。"
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s未完成%s。他們在這個難度總共未完成%d次。"

L.VERSIONCHECK_HEADER			= "Boss Mods - 版本檢測"
L.VERSIONCHECK_ENTRY			= "%s: %s (%s) %s"--One Boss mod
L.VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) & %s (%s)"--Two Boss mods
L.VERSIONCHECK_ENTRY_NO_DBM		= "%s：尚未安裝任何團隊首領模組"
L.VERSIONCHECK_FOOTER			= "找到有%d玩家正在使用"..L.DBM.."且有%d玩家正在使用Bigwigs"
L.VERSIONCHECK_OUTDATED			= "下列有%d玩家正在使用過期的首領模組:%s"
L.YOUR_VERSION_OUTDATED			= "你的 Deadly Boss Mod 已經過期。請到Curse、Wago或是WOWI網站以及GitHub專案網頁下載最新版本。"
L.VOICE_PACK_OUTDATED			= "你的"..L.DBM.."語音包可能缺少在這個版本的"..L.DBM.."需要的語音。部分警告音效已經被停用。請下載新版本的語音包或是聯絡語音包作者更新並加入缺少的語音。"
L.VOICE_MISSING					= ""..L.DBM.."找不到你所選取的語音包。請確定你的語音包已正確的安裝與啟用。"
L.VOICE_DISABLED				= "你的語音包已安裝但是尚未啟用。如果你想使用語音包，請確定語言包已在語音警告中被選取，或是刪除不使用的語音包去隱藏此訊息。"
L.VOICE_COUNT_MISSING			= "所選取的語音/倒數語音包%d找不到倒數語音。設定已被重置回預設值：%s。"
L.BIG_WIGS						= "BigWigs"
L.WEAKAURA_KEY					= " (|cff308530WA鍵:|r %s)"

L.UPDATEREMINDER_HEADER				= "你的Deadly Boss Mod已經過期。\n你可以在Curse網站或是WOWI網站以及GitHub專案網頁下載到新版本%s (%s)"
L.UPDATEREMINDER_HEADER_SUBMODULE	= "你的 %s 模組已經過期。\n 你可以在Curse網站或是WOWI網站以及GitHub專案網頁下載到新版本 %s"
L.UPDATEREMINDER_FOOTER				= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製下載網址到剪貼簿。"
L.UPDATEREMINDER_FOOTER_GENERIC		= "按下" .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "：複製網址到剪貼簿。"
L.UPDATEREMINDER_DISABLE			= "警告: 你的"..L.DBM.."版本已大幅度的過期並且無法與新版本相容，"..L.DBM.."已被強制關閉並且無法使用直到更新為止。這是為了確保舊而不相容的程式碼不會對你而團隊夥伴造成低落的遊戲體驗。"
L.UPDATEREMINDER_DISABLETEST		= "警告: 你的"..L.DBM.."版本已大幅度的過期並且是在beta伺服器上測試，"..L.DBM.."已被強制關閉並且無法使用直到更新為止。這是為了確保未使用過期版本來生成測試反饋。"
L.UPDATEREMINDER_HOTFIX				= "你的"..L.DBM.."版本會在這首領戰鬥有不準確的計時器或警告。這問題已被修正在新版正式版(或是更新到最新的測試版。)"
L.UPDATEREMINDER_HOTFIX_ALPHA		= "您的"..L.DBM.."版本在此首領戰有些已知問題，將會在未來的正式版修正 (或是最新的測試版)"
L.UPDATEREMINDER_MAJORPATCH			= "警告: 你的"..L.DBM.."已經過期，"..L.DBM.."已被禁用直到你更新至最新版，因為遊戲大改版。為了不讓舊的程式碼拖累遊戲體驗。請至curse、Wago、WoWI或是GitHub發佈頁下載最新版本的DBM。"
L.VEM								= "警告: 你同時使用DBM和VEM。DBM將停用而無法執行。"
L.OUTDATEDPROFILES					= "警告: DBM-Profiles不相容此版本DBM。請移除避免衝突。"
L.OUTDATEDSPELLTIMERS				= "警告：DBM-SpellTimers破壞了" .. L.DBM .. ".必須要移除" .. L.DBM .. "才能正常運作。"
L.OUTDATEDRLT						= "警告：DBM-RaidLeadTools破壞了" .. L.DBM .. ". DBM-RaidLeadTools已經不再支援並且必須移除" .. L.DBM .. "才能正常運作。"
L.VICTORYSOUND						= "警告：DBM-VictorySound不相容此版本"..L.DBM.."。請移除避免衝突。"
L.DPMCORE							= "警告: Deadly PvP 模組已經停止更新而且不相容此版本的"..L.DBM.."。請先移除以避免衝突。"
L.DBMLDB							= "警告: DBM-LDB已內建在"..L.DBM.."-核心。雖然它不會造成任何傷害，但建議從addons資料夾中刪除“DBM-LDB”"
L.DBMLOOTREMINDER					= "警告：已安裝第三方模組 DBM-LootReminder。 此附加插件不再與正式版WOW客戶端相容，並且將導致"..L.DBM.."中斷並且無法發送請求計時器。 建議卸載此插件。"
L.UPDATE_REQUIRES_RELAUNCH			= "警告: 如果你沒有重啟你的遊戲，這次"..L.DBM.."更新可能無法正確運作。這次更新包含了新的檔案或是.toc檔更新而不能使用ReloadUI載入。如果沒有將遊戲完全重啟可能會導致錯誤或功能不完整。"
L.OUT_OF_DATE_NAG					= "你的"..L.DEADLY_BOSS_MODS.."版本已經過期，新版本針對特定的首領戰鬥增加新的功能和錯誤的修復。建議您進行更新來改善您的遊戲體驗。"
L.PLATER_NP_AURAS_MSG					= L.DBM .. "包含一個進階功能，用於使用名條上的圖示顯示敵人冷卻時間。 對於大多數用戶而言，預設情況下是這樣的，但是對於Plater用戶而言，除非您啟用它，否則預設情況下它會在Plater選項中關閉。 為了充分利用DBM（和Plater），建議您在“ Buff Special”部分的Plater中啟用此功能。 如果您不想再次看到此訊息，也可以在DBM全局禁用或名條選項面板中的“名條上的冷卻圖標”選項中禁用。"

L.MOVABLE_BAR					= "拖動我!"

L.PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h 向你發送了" .. L.DBM .. "的倒數計時: '%2$s'\n|Hgarrmission:DBM:cancel:%2$s:nil|h|cff3588ff[取消此倒數計時]|r|h  |Hgarrmission:DBM:ignore:%2$s:%1$s|h|cff3588ff[忽略來自 %1$s 的倒數計時]|r|h"
--L.PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h向你發送了一個倒數計時"
L.PIZZA_CONFIRM_IGNORE			= "是否要在該次遊戲連結中忽略來自%s的計時？"
L.PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <時間（秒）> <文字>。<時間>必須大於等於3"

--L.MINIMAP_TOOLTIP_HEADER				= L.DEADLY_BOSS_MODS --Technically redundant
L.MINIMAP_TOOLTIP_FOOTER		= "按下Shift並拖曳即可移動"

L.RANGECHECK_HEADER				= "距離監視(%d碼)"
L.RANGECHECK_HEADERT			= "距離監視 (%d碼-%d人)"
L.RANGECHECK_RHEADER			= "反向距離監視 (%d碼)"
L.RANGECHECK_RHEADERT			= "反向距離監視 (%d碼-%d人)"
L.RANGECHECK_SETRANGE			= "設置距離"
L.RANGECHECK_SETTHRESHOLD		= "設置玩家數量門檻"
L.RANGECHECK_SOUNDS				= "音效"
L.RANGECHECK_SOUND_OPTION_1		= "當一位玩家在範圍內時播放音效"
L.RANGECHECK_SOUND_OPTION_2		= "當多於一位玩家在範圍內時播放音效"
L.RANGECHECK_SOUND_0			= "沒有音效"
L.RANGECHECK_SOUND_1			= "預設音效"
L.RANGECHECK_SOUND_2			= "蜂鳴聲"
L.RANGECHECK_SETRANGE_TO		= "%d 碼"
L.RANGECHECK_OPTION_FRAMES		= "框架"
L.RANGECHECK_OPTION_RADAR		= "顯示雷達框架"
L.RANGECHECK_OPTION_TEXT		= "顯示文字框"
L.RANGECHECK_OPTION_BOTH		= "兩者都顯示"
L.RANGERADAR_HEADER				= "距離:%d玩家(%d)"
L.RANGERADAR_RHEADER			= "反距離:%d玩家:%d"
L.RANGERADAR_IN_RANGE_TEXT		= "%d在範圍內(%0.1f碼)"--Multi
L.RANGECHECK_IN_RANGE_TEXT		= "%d在範圍內"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE	= "%s (%0.1f碼)"--One target

L.INFOFRAME_TITLE				= "DBM資訊框架"
L.INFOFRAME_SHOW_SELF			= "總是顯示你的能量"
L.INFOFRAME_SETLINES			= "設定最大行數"
L.INFOFRAME_SETCOLS				= "設定最大行數"
L.INFOFRAME_LINESDEFAULT		= "由首領模組自動設定"
L.INFOFRAME_LINES_TO			= "%d 行"
L.INFOFRAME_COLS_TO				= "%d 行"
L.INFOFRAME_POWER				= "能量"
L.INFOFRAME_AGGRO				= "仇恨"
L.INFOFRAME_MAIN				= "主要："--Main power
L.INFOFRAME_ALT					= "次要："--Alternate Power

L.LFG_INVITE					= "地城準備確認"

L.SLASHCMD_HELP				= {
	"可用指令：",
	"-----------------",
	"/dbm unlock：顯示一個可移動的計時器（也可使用：move）。",
	"/range <數字> or /distance <數字>: 顯示距離框架。/rrange 或 /rdistance 顯示相反色。",
	"/hudar <數字>: 顯示基於距離查詢的HUD。",
	"/dbm timer: 開始一個自訂的"..L.DBM.."計時器，輸入'/dbm timer'獲得更多訊息。",
	"/dbm arrow: 顯示"..L.DBM.."箭頭，輸入'/dbm arrow help'獲得更多訊息。",
	"/dbm hud: 顯示"..L.DBM.." hud，輸入'/dbm hud'獲得更多訊息。",
	"/dbm help2: 顯示團隊管理指令",
}
L.SLASHCMD_HELP2				= {
	"可用指令：",
	"-----------------",
	"/dbm pull <秒數>: 開始備戰計時器<秒數>。向所有團隊成員發送一個"..L.DBM.."備戰計時器（需要權限）。",
	"/dbm break <分鐘>: 開始休息計時器<分鐘>。向所有團隊成員發送一個"..L.DBM.."休息計時器（需要權限）。",
	"/dbm version: 進行首領插件的版本檢測（也可使用：ver）。",
	"/dbm version2: 進行首領插件的版本檢測同時也密語提醒過期的使用者（也可使用：ver2）。",
	"/dbm lag: 進行團隊範圍內的網路延遲檢測。",
	"/dbm durability: 進行團隊範圍內的裝備耐久度檢測。"
}
L.TIMER_USAGE	= {
	L.DBM .. "計時器指令：",
	"-----------------",
	"/dbm timer <秒數> <文字>: 開始一個時間為<秒數>秒並以<文字>為名稱的計時器。",
	"/dbm ltimer <秒數> <文字>: 開始一個時間為<秒數>秒的計時器同時無限循環直到取消。",
	"(如果有團長或助理權限，在'timer'或'ltimer'計時器指令前加入'Broadcast'可以將此分享給團隊)",
	"/dbm timer endloop: 停止任何無限循環ltimer的計時器。",
}

L.ERROR_NO_PERMISSION			= "您無權發送備戰/休息計時器。"
L.ERROR_NO_PERMISSION_COMBAT	= "當遭遇戰進行中時無法發送備戰/休息計時器"
L.PULL_TIME_TOO_SHORT			= "備戰計時器必須超過3秒。 "
L.PULL_TIME_TOO_LONG			= "備戰計時器不能超過60秒。考慮使用/休息計時器取代。"

L.BREAK_USAGE					= "休息時間不可以長過60分鐘。請確定您輸入的時間是分鐘而不是秒。"
L.BREAK_START					= "現在開始休息-你有%s分鐘! (由 %s 發送)"
L.BREAK_MIN						= "%s分鐘後休息時間結束!"
L.BREAK_SEC						= "%s秒後休息時間結束!"
L.TIMER_BREAK					= "休息時間!"
L.ANNOUNCE_BREAK_OVER			= "休息結束於%s"

L.TIMER_PULL					= "戰鬥準備"
L.ANNOUNCE_PULL					= "%d秒後拉怪 (%s發起)"
L.ANNOUNCE_PULL_NOW				= "拉怪囉!"
L.ANNOUNCE_PULL_TARGET			= "%2$d秒後開打%1$s! (%3$s 發起)"
L.ANNOUNCE_PULL_NOW_TARGET		= "%s現在開打!"
L.GEAR_WARNING					= "警告：檢查裝備。你的所裝備的裝備等級低於包包中的裝備%d個等級。"
L.GEAR_WARNING_WEAPON			= "警告：檢查你是否裝備正確的武器。"
L.GEAR_FISHING_POLE				= "釣魚竿"

L.ACHIEVEMENT_TIMER_SPEED_KILL = "成就"

L.AUTO_ANNOUNCE_TEXTS.you					= "你中了%s"
L.AUTO_ANNOUNCE_TEXTS.target				= "%s:>%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetsource			= ">%%s< 施放 %s 在 >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount			= "%s (%%s):>%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell					= "%s"
L.AUTO_ANNOUNCE_TEXTS.incoming				= "%s 即將到來的減益"
L.AUTO_ANNOUNCE_TEXTS.incomingcount			= "%s 即將到來的減益 (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends 					= "%s結束"
L.AUTO_ANNOUNCE_TEXTS.endtarget				= "%s結束:>%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades					= "%s消退"
L.AUTO_ANNOUNCE_TEXTS.addsleft				= "%s還剩下:%%d"
L.AUTO_ANNOUNCE_TEXTS.cast					= "施放%s:%.1f秒"
L.AUTO_ANNOUNCE_TEXTS.soon					= "%s即將到來"
L.AUTO_ANNOUNCE_TEXTS.sooncount				= "%s (%%s)即將到來"
L.AUTO_ANNOUNCE_TEXTS.countdown				= "%s還有%%ds"
L.AUTO_ANNOUNCE_TEXTS.prewarn				= "%s在%s"
L.AUTO_ANNOUNCE_TEXTS.bait					= "%s即將到來 - 快引誘"
L.AUTO_ANNOUNCE_TEXTS.stage					= "第%s階段"
L.AUTO_ANNOUNCE_TEXTS.prestage				= "第%s階段即將到來"
L.AUTO_ANNOUNCE_TEXTS.count					= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack					=">%%s<中了%s (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto				= "%s - 移動到>%%s<"

local prewarnOption							= "預先警告：$spell:%s"
L.AUTO_ANNOUNCE_OPTIONS.you					= "提示：中了$spell:%s時"
L.AUTO_ANNOUNCE_OPTIONS.target				= "提示：$spell:%s的目標"
L.AUTO_ANNOUNCE_OPTIONS.targetNF			= "提示：$spell:%s的目標(忽略全局目標過濾)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource		= "提示：$spell:%s的目標(包含來源)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount			= "提示：$spell:%s的目標(包含計數)"
L.AUTO_ANNOUNCE_OPTIONS.spell				= "提示：當$spell:%s施放時"
L.AUTO_ANNOUNCE_OPTIONS.incoming			= "提示：$spell:%s 的減益即將到來"
L.AUTO_ANNOUNCE_OPTIONS.incomingcount		= "提示：$spell:%s 的減益即將到來(包含計數)"
L.AUTO_ANNOUNCE_OPTIONS.ends				= "提示：當$spell:%s結束"
L.AUTO_ANNOUNCE_OPTIONS.endtarget			= "提示：當$spell:%s結束(包含目標)"
L.AUTO_ANNOUNCE_OPTIONS.fades				= "提示：當$spell:%s消退"
L.AUTO_ANNOUNCE_OPTIONS.addsleft			= "提示：$spell:%s剩餘數量"
L.AUTO_ANNOUNCE_OPTIONS.cast				= "提示：當$spell:%s開始施放"
L.AUTO_ANNOUNCE_OPTIONS.soon				= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount			= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.countdown			= "預先警告：$spell:%s的倒數計時訊息"
L.AUTO_ANNOUNCE_OPTIONS.prewarn				= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait				= "警告：$spell:%s去引誘的預先警告"
L.AUTO_ANNOUNCE_OPTIONS.stage				= "提示：第%s階段"
L.AUTO_ANNOUNCE_OPTIONS.stagechange			= "預先警告：第%s階段"
L.AUTO_ANNOUNCE_OPTIONS.prestage			= "預先警告：階段%s"
L.AUTO_ANNOUNCE_OPTIONS.count				= "提示：當$spell:%s施放時(包含計數)"
L.AUTO_ANNOUNCE_OPTIONS.stack				= "提示：$spell:%s疊加層數"
L.AUTO_ANNOUNCE_OPTIONS.moveto				= "提示：$spell:%s需要移動到某人或某個地方"

L.AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends 				= "%s結束"
L.AUTO_SPEC_WARN_TEXTS.fades				= "%s消退"
L.AUTO_SPEC_WARN_TEXTS.soon					= "%s即將到來"
L.AUTO_SPEC_WARN_TEXTS.sooncount			= "%s (%%s)即將到來"
L.AUTO_SPEC_WARN_TEXTS.bait					= "%s即將到來 - 快引誘"
L.AUTO_SPEC_WARN_TEXTS.prewarn				= "%s在%s"
L.AUTO_SPEC_WARN_TEXTS.dispel				= ">%%s<中了%s - 現在驅散"
L.AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - 快中斷>%%s< !"
L.AUTO_SPEC_WARN_TEXTS.interruptcount		= "%s - 快中斷>%%s< !(%%d)"
L.AUTO_SPEC_WARN_TEXTS.you					= "你中了%s"
L.AUTO_SPEC_WARN_TEXTS.youcount				= "你中了%s (%%s)"
L.AUTO_SPEC_WARN_TEXTS.youpos				= "你中了%s (位置：%%s)"
L.AUTO_SPEC_WARN_TEXTS.youposcount		    = "你中了%s (%%s) (位置: %%s)"
L.AUTO_SPEC_WARN_TEXTS.soakpos				= "%s - 快到%%s分傷"
L.AUTO_SPEC_WARN_TEXTS.target				= ">%%s<中了%s"
L.AUTO_SPEC_WARN_TEXTS.targetcount			= ">%%2$s<中了%s (%%1$s) "
L.AUTO_SPEC_WARN_TEXTS.link					= "%s 與 >%%s< 連結"
L.AUTO_SPEC_WARN_TEXTS.defensive			= "%s - 使用防禦技能"
L.AUTO_SPEC_WARN_TEXTS.taunt				= ">%%s<中了%s - 快嘲諷"
L.AUTO_SPEC_WARN_TEXTS.close				= "你附近的>%%s<中了%s"
L.AUTO_SPEC_WARN_TEXTS.move					= "%s - 快移動"
L.AUTO_SPEC_WARN_TEXTS.keepmove				= "%s - 保持移動"
L.AUTO_SPEC_WARN_TEXTS.stopmove				= "%s - 停止移動"
L.AUTO_SPEC_WARN_TEXTS.dodge				= "%s - 閃避攻擊"
L.AUTO_SPEC_WARN_TEXTS.dodgecount			= "%s (%%s) - 閃避攻擊"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc				= "%s - 閃避技能 %%s"
L.AUTO_SPEC_WARN_TEXTS.moveaway				= "%s - 快離開其他人"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount		= "%s (%%s) - 快離開其他人"
L.AUTO_SPEC_WARN_TEXTS.moveto				= "%s - 快跑向>%%s<"
L.AUTO_SPEC_WARN_TEXTS.soak					= "%s - 踩圈分擔"
L.AUTO_SPEC_WARN_TEXTS.soakcount			= "%s - 踩圈分擔 (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump					= "%s - 快跳躍"
L.AUTO_SPEC_WARN_TEXTS.run					= "%s - 快跑開"
L.AUTO_SPEC_WARN_TEXTS.runcount				= "%s - 快跑開 (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast					= "%s - 停止施法"
L.AUTO_SPEC_WARN_TEXTS.lookaway				= "%s 點名 %%s - 快轉頭"
L.AUTO_SPEC_WARN_TEXTS.reflect				= ">%%s<中了%s - 停止攻擊"
L.AUTO_SPEC_WARN_TEXTS.count				= "%s!(%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack				= "你中了%%d層%s"
L.AUTO_SPEC_WARN_TEXTS.switch				= "%s - 快更換目標!"
L.AUTO_SPEC_WARN_TEXTS.switchcount			= "%s - 快更換目標！(%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo					= "%%s 傷害 - 快移動"
L.AUTO_SPEC_WARN_TEXTS.adds					= "小怪出現 - 快更換目標！"
L.AUTO_SPEC_WARN_TEXTS.addscount			= "小怪出現 - 快更換目標！(%%s)"
L.AUTO_SPEC_WARN_TEXTS.addscustom			= "小怪來了 - %%s"
L.AUTO_SPEC_WARN_TEXTS.targetchange			= "更換目標 - 轉火 %%s"

L.AUTO_SPEC_WARN_OPTIONS.spell				= "特別提示：$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends				= "特別提示：$spell:%s結束"
L.AUTO_SPEC_WARN_OPTIONS.fades				= "特別提示：$spell:%s消退"
L.AUTO_SPEC_WARN_OPTIONS.soon				= "特別提示：$spell:%s即將到來"
L.AUTO_SPEC_WARN_OPTIONS.sooncount			= "特別提示：$spell:%s (包含計數)即將到來"
L.AUTO_SPEC_WARN_OPTIONS.bait				= "特別提示：$spell:%s(當誘餌)預先顯示"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 			= "特別提示：$spell:%s在%d秒前預先顯示"
L.AUTO_SPEC_WARN_OPTIONS.dispel				= "特別提示：需要驅散$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt			= "特別提示：需要中斷$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount		= "特別提示：需要中斷$spell:%s (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.you				= "特別提示：當你中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.youcount			= "特別提示：當你中了$spell:%s時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.youpos				= "特別提示：當你中了$spell:%s時 (包含站位)"
L.AUTO_SPEC_WARN_OPTIONS.youposcount	    = "特別提示：當你中了$spell:%s時 (包含站位和計數)"
L.AUTO_SPEC_WARN_OPTIONS.soakpos			= "特別提示：當需要為$spell:%s分傷時(包含站位)"
L.AUTO_SPEC_WARN_OPTIONS.target				= "特別提示：當他人中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 		= "特別提示：當他人中了$spell:%s時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.link				= "特別提示：當你中了$spell:%s與其他玩家連結時"
L.AUTO_SPEC_WARN_OPTIONS.defensive 			= "特別提示：當需要使用$spell:%s技能來減傷時"
L.AUTO_SPEC_WARN_OPTIONS.taunt 				= "特別提示：當另外一個坦中了$spell:%s並需要你嘲諷時 (當為坦克專精)"
L.AUTO_SPEC_WARN_OPTIONS.close				= "特別提示：當你附近有人中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.move				= "特別提示：當你中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 			= "特別提示：當你中了$spell:%s需要保持移動時"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 			= "特別提示：當你中了$spell:%s需要停止移動時"
L.AUTO_SPEC_WARN_OPTIONS.dodge				= "特別提示：當你中了$spell:%s並需要躲開攻擊"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount			= "特別提示：當你中了$spell:%s並需要躲開攻擊 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc			= "特別提示：當你需要閃避$spell:%s技能時(包含站位)"
L.AUTO_SPEC_WARN_OPTIONS.moveaway			= "特別提示：當你中了$spell:%s並需要跑開人群時"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount		= "特別提示：當你中了$spell:%s並需要跑開人群時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.moveto				= "特別提示：當中了$spell:%s並需要你去靠近某人或某地點時"
L.AUTO_SPEC_WARN_OPTIONS.soak				= "特別提示：當需要你去踩圈分擔$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.soakcount			= "特別提示：當需要你去踩圈分擔$spell:%s時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.jump				= "特別提示：當你中了$spell:%s需要跳起來時"
L.AUTO_SPEC_WARN_OPTIONS.run				= "特別提示：當你中了$spell:%s需要跑開時"
L.AUTO_SPEC_WARN_OPTIONS.runcount			= "特別提示：當你中了$spell:%s需要跑開時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.cast				= "特別提示：$spell:%s的施放（停止施法）"
L.AUTO_SPEC_WARN_OPTIONS.lookaway			= "特別提示：當需要為$spell:%s轉頭時"
L.AUTO_SPEC_WARN_OPTIONS.reflect 			= "特別提示：$spell:%s需要停止攻擊"
L.AUTO_SPEC_WARN_OPTIONS.count 				= "特別提示：$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack				= "特別提示：當疊加了>=%d層$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.switch 			= "特別提示：針對$spell:%s需要轉換目標"
L.AUTO_SPEC_WARN_OPTIONS.switchcount		= "特別提示：針對$spell:%s需要轉換目標 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 				= "特別提示：當地板出現危險的東西需要躲開時"
L.AUTO_SPEC_WARN_OPTIONS.adds				= "特別提示：當小怪出現需要更換目標時"
L.AUTO_SPEC_WARN_OPTIONS.addscount			= "特別提示：當小怪出現需要更換目標時 (包含計數)"

L.AUTO_SPEC_WARN_OPTIONS.addscustom			= "特別提示：即將到來的小怪"
L.AUTO_SPEC_WARN_OPTIONS.targetchange		= "特別提示：當需要更換主要目標時"

L.AUTO_TIMER_TEXTS.target					= "%s: %%s"
L.AUTO_TIMER_TEXTS.targetcount				= "%s (%%2$s): %%1$s"
L.AUTO_TIMER_TEXTS.cast						= "%s"
L.AUTO_TIMER_TEXTS.castcount				= "%s (%%s)"
L.AUTO_TIMER_TEXTS.castsource				= "%s: %%s"
L.AUTO_TIMER_TEXTS.active					= "%s結束"
L.AUTO_TIMER_TEXTS.fades					= "%s消退"
L.AUTO_TIMER_TEXTS.ai						= "%s AI"

L.AUTO_TIMER_TEXTS.cd						= "%s"
L.AUTO_TIMER_TEXTS.cdcount					= "%s (%%s)"
L.AUTO_TIMER_TEXTS.cdsource					= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial				= "特別技能"
L.AUTO_TIMER_TEXTS.cdcombo					= "%%1$s + %%2$s"

L.AUTO_TIMER_TEXTS.next 					= "%s"
L.AUTO_TIMER_TEXTS.nextcount 				= "%s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource				= "%s: %%s"
L.AUTO_TIMER_TEXTS.nextspecial				= "特別技能"
L.AUTO_TIMER_TEXTS.nextcombo				= "%%1$s + %%2$s"

L.AUTO_TIMER_TEXTS.var						= "%s"
L.AUTO_TIMER_TEXTS.varcount					= "%s (%%s)"
L.AUTO_TIMER_TEXTS.varsource				= "%s: >%%s<"
L.AUTO_TIMER_TEXTS.varspecial				= "特別技能"
L.AUTO_TIMER_TEXTS.varcombo					= "%%1$s + %%2$s"

L.AUTO_TIMER_TEXTS.achievement				= "%s"
L.AUTO_TIMER_TEXTS.stage					= "階段"
L.AUTO_TIMER_TEXTS.stagecount				= "階段 %%s"
L.AUTO_TIMER_TEXTS.stagecountcycle			= "階段 %%s (%%s)"--Example: Stage 2 (3) for a fight that alternates stage 1 and stage 2, but also tracks total cycles
L.AUTO_TIMER_TEXTS.stagecontext				= "%s"
L.AUTO_TIMER_TEXTS.stagecontextcount		= "%s (%%s)"
L.AUTO_TIMER_TEXTS.intermission				= "中場"
L.AUTO_TIMER_TEXTS.intermissioncount		= "中場 %%s"
L.AUTO_TIMER_TEXTS.adds						= "小怪"
L.AUTO_TIMER_TEXTS.addscustom  				= "小怪 (%%s)"
L.AUTO_TIMER_TEXTS.roleplay					= GUILD_INTEREST_RP
L.AUTO_TIMER_TEXTS.combat					= "戰鬥開始"

--This basically clones np only bar option and display text from regular counterparts
--L.AUTO_TIMER_TEXTS.cdnp					= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
--L.AUTO_TIMER_TEXTS.nextnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
--L.AUTO_TIMER_TEXTS.cdpnp				= L.AUTO_TIMER_TEXTS.cd -- OPTIONAL
--L.AUTO_TIMER_TEXTS.nextpnp				= L.AUTO_TIMER_TEXTS.next -- OPTIONAL
--L.AUTO_TIMER_TEXTS.castpnp				= L.AUTO_TIMER_TEXTS.cast -- OPTIONAL

L.AUTO_TIMER_OPTIONS.target					= "計時條：$spell:%s減益效果持續時間"
L.AUTO_TIMER_OPTIONS.targetcount			= "計時條：$spell:%s減益效果持續時間(包含計數)"
L.AUTO_TIMER_OPTIONS.cast					= "計時條：$spell:%s施法時間"
L.AUTO_TIMER_OPTIONS.castcount				= "計時條：$spell:%s施法時間(包含計數)"
L.AUTO_TIMER_OPTIONS.castsource				= "計時條：$spell:%s施放(包含來源)"
L.AUTO_TIMER_OPTIONS.active					= "計時條：$spell:%s效果持續時間"
L.AUTO_TIMER_OPTIONS.fades					= "計時條：$spell:%s何時從玩家身上消失"
L.AUTO_TIMER_OPTIONS.ai						= "計時條：$spell:%s冷卻的AI計時條"
L.AUTO_TIMER_OPTIONS.cd						= "計時條：$spell:%s冷卻時間"
L.AUTO_TIMER_OPTIONS.cdcount				= "計時條：$spell:%s冷卻時間"
L.AUTO_TIMER_OPTIONS.cdnp					= "計時條：只顯示名條的 $spell:%s 冷卻時間"
L.AUTO_TIMER_OPTIONS.cdsource				= "計時條：$spell:%s冷卻時間以及來源"
L.AUTO_TIMER_OPTIONS.cdspecial				= "計時條：特殊技能冷卻"
L.AUTO_TIMER_OPTIONS.cdcombo				= "計時條：技能組合冷卻"--Used for combining 2 abilities into a single timer
L.AUTO_TIMER_OPTIONS.next					= "計時條：下一次$spell:%s"
L.AUTO_TIMER_OPTIONS.nextcount				= "計時條：下一次$spell:%s"
L.AUTO_TIMER_OPTIONS.nextnp					= "計時條：只顯示名條的下一次$spell:%s"
L.AUTO_TIMER_OPTIONS.nextsource				= "計時條：下一次$spell:%s以及來源"
L.AUTO_TIMER_OPTIONS.nextspecial			= "計時條：下一次特殊技能"
L.AUTO_TIMER_OPTIONS.nextcombo				= "計時條：下一次技能組合"--Used for combining 2 abilities into a single timer

L.AUTO_TIMER_OPTIONS.var					= "計時條：$spell:%s冷卻時間 (包含差額)"
L.AUTO_TIMER_OPTIONS.varcount				= "計時條：$spell:%s冷卻時間 (包含計數與差額)"
L.AUTO_TIMER_OPTIONS.varnp					= "計時條：只在名條顯示$spell:%s冷卻時間 (包含差額)"
L.AUTO_TIMER_OPTIONS.varpnp					= "計時條：只在優先名條顯示$spell:%s冷卻時間 (包含差額)"
L.AUTO_TIMER_OPTIONS.varsource				= "計時條：$spell:%s冷卻時間 (包含來源與差額)"
L.AUTO_TIMER_OPTIONS.varspecial				= "計時條：特殊技能冷卻 (包含差額)"
L.AUTO_TIMER_OPTIONS.varcombo				= "計時條：技能組合冷卻 (包含差額)"

L.AUTO_TIMER_OPTIONS.achievement			= "計時條：成就%s"
L.AUTO_TIMER_OPTIONS.stage					= "計時條：下一階段"
L.AUTO_TIMER_OPTIONS.stagecount				= "計時條：下一階段(包含計數)"
L.AUTO_TIMER_OPTIONS.stagecountcycle		= "計時條：下一階段(包含階段計數與循環計數)"
L.AUTO_TIMER_OPTIONS.stagecontext			= "計時條：下一次$spell:%s階段"
L.AUTO_TIMER_OPTIONS.stagecontextcount		= "計時條：下一次$spell:%s階段(包含計數)"
L.AUTO_TIMER_OPTIONS.intermission			= "計時條：下個中場"
L.AUTO_TIMER_OPTIONS.intermissioncount		= "計時條：下個中場(包含計數)"
L.AUTO_TIMER_OPTIONS.adds					= "計時條：下一次小怪"
L.AUTO_TIMER_OPTIONS.addscustom				= "計時條：小怪出現"
L.AUTO_TIMER_OPTIONS.roleplay				= "計時條：劇情持續時間"
L.AUTO_TIMER_OPTIONS.combat					= "為戰鬥開始顯示計時器"

L.AUTO_ICONS_OPTION_TARGETS					= "為$spell:%s的目標設置標記"
L.AUTO_ICONS_OPTION_TARGETS_TANK_A			= "為$spell:%s的目標設置標記，優先等級為坦克高於近戰高於遠程，並以字母順序優先"
L.AUTO_ICONS_OPTION_TARGETS_TANK_R			= "為$spell:%s的目標設置標記，優先等級為坦克高於近戰高於遠程，並以團隊陣容優先"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_A			= "為$spell:%s的目標設置標記，以近戰和字母順序優先"
L.AUTO_ICONS_OPTION_TARGETS_MELEE_R			= "為$spell:%s的目標設置標記，以近戰和團隊陣容優先"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_A		= "為$spell:%s的目標設置標記，以遠程和字母順序優先"
L.AUTO_ICONS_OPTION_TARGETS_RANGED_R		= "為$spell:%s的目標設置標記，以遠程和團隊陣容優先"
L.AUTO_ICONS_OPTION_TARGETS_ALPHA			= "為$spell:%s的目標設置標記，以字母順序優先"
L.AUTO_ICONS_OPTION_TARGETS_ROSTER			= "為$spell:%s的目標設置標記，以團隊陣容優先"
L.AUTO_ICONS_OPTION_NPCS					= "為$spell:%s設置標記"

L.AUTO_ICONS_OPTION_CONFLICT				= " (可能與其他選項衝突)"
L.AUTO_ARROW_OPTION_TEXT					= "為跑向中了$spell:%s的目標顯示"..L.DBM.."箭頭"
L.AUTO_ARROW_OPTION_TEXT2					= "為離開中了$spell:%s的目標顯示"..L.DBM.."箭頭"
L.AUTO_ARROW_OPTION_TEXT3					= "為中了$spell:%s後移動到特定區域顯示"..L.DBM.."箭頭"
L.AUTO_YELL_OPTION_TEXT.shortyell			= "當你中了$spell:%s時大喊"
L.AUTO_YELL_OPTION_TEXT.yell				= "當你中了$spell:%s時大喊(玩家名字)"
L.AUTO_YELL_OPTION_TEXT.count				= "當你中了$spell:%s時大喊(次數)"
L.AUTO_YELL_OPTION_TEXT.fade				= "當$spell:%s正消退時大喊(倒數和技能名稱)"
L.AUTO_YELL_OPTION_TEXT.shortfade			= "當$spell:%s正消退時大喊(倒數)"
L.AUTO_YELL_OPTION_TEXT.iconfade			= "當$spell:%s正消退時大喊(倒數與圖示)"
L.AUTO_YELL_OPTION_TEXT.position			= "當你中了$spell:%s時大喊(包含位置與玩家名字)"
L.AUTO_YELL_OPTION_TEXT.shortposition		= "當你中了$spell:%s時大喊(包含位置)"
L.AUTO_YELL_OPTION_TEXT.combo				= "當你同時中了$spell:%s與其他法術時大喊(包含自訂文字)"
L.AUTO_YELL_OPTION_TEXT.repeatplayer		= "當你中了$spell:%s時重複大喊(玩家名字)"
L.AUTO_YELL_OPTION_TEXT.repeaticon			= "當你中了$spell:%s時重複大喊(圖示)"
L.AUTO_YELL_ANNOUNCE_TEXT.shortyell			= "%s"
L.AUTO_YELL_ANNOUNCE_TEXT.yell				= "" .. UnitName("player") .. "中了%s"
L.AUTO_YELL_ANNOUNCE_TEXT.count				= "" .. UnitName("player") .. "中了%s(%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade				= "%s %%d秒後消退!"
L.AUTO_YELL_ANNOUNCE_TEXT.shortfade			= "%%d"
L.AUTO_YELL_ANNOUNCE_TEXT.iconfade			= "{rt%%2$d}%%1$d"
L.AUTO_YELL_ANNOUNCE_TEXT.position 			= UnitName("player").." ({rt%%3$d})中了%1$s! (%%1$s - {rt%%2$d})"
L.AUTO_YELL_ANNOUNCE_TEXT.shortposition 	= "{rt%%1$d}%s"--Icon, Spellname
L.AUTO_YELL_ANNOUNCE_TEXT.combo				= "%s與%%s"--Spell name (from option, plus spellname given in arg)
L.AUTO_YELL_ANNOUNCE_TEXT.repeatplayer		= UnitName("player")--Doesn't need translation, it's just player name spam
L.AUTO_YELL_ANNOUNCE_TEXT.repeaticon		= "{rt%%1$d}"

--L.AUTO_YELL_CUSTOM_POSITION				= "{rt%d}%s"--Doesn't need translating. Has no strings (Used in niche situations such as icon repeat yells)
L.AUTO_YELL_CUSTOM_FADE					= "%s已消退"
L.AUTO_HUD_OPTION_TEXT					= "為$spell:%s顯示HudMap(不再作用)"
L.AUTO_HUD_OPTION_TEXT_MULTI			= "為不同的機制顯示HudMap(不再作用)"
L.AUTO_NAMEPLATE_OPTION_TEXT			= "為$spell:%s顯示姓名版光環，使用在相容的名條插件或"..L.DBM..""
L.AUTO_NAMEPLATE_OPTION_TEXT_FORCED		= "為$spell:%s顯示姓名版光環，使用在"..L.DBM..""

L.AUTO_RANGE_OPTION_TEXT				= "為$spell:%2$s顯示距離框架(%1$s碼)"
L.AUTO_RANGE_OPTION_TEXT_SHORT			= "顯示距離框架(%s碼)"
L.AUTO_RRANGE_OPTION_TEXT				= "為$spell:%2$s顯示反色距離框架(%1$s碼)"--Reverse range frame (green when players in range, red when not)
L.AUTO_RRANGE_OPTION_TEXT_SHORT			= "顯示反色距離框架(%s碼)"
L.AUTO_INFO_FRAME_OPTION_TEXT			= "為$spell:%s顯示訊息框架"
L.AUTO_INFO_FRAME_OPTION_TEXT2			= "為戰鬥概覽顯示訊息框架"
L.AUTO_INFO_FRAME_OPTION_TEXT3			= "為$spell:%s顯示訊息框架(當達到%%s的閥值時)"
L.AUTO_READY_CHECK_OPTION_TEXT			= "當首領開打時撥放準備檢查的音效(即使沒有選定目標)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT			= "顯示 %s 的最快清除計時器"
L.AUTO_PRIVATEAURA_OPTION_TEXT			= "為這場戰鬥的私人光環$spell:%s播放DBM音效警告。"

L.AUTO_GOSSIP_BUFFS						= "自動選擇npc的對話選項或專業增益"
L.AUTO_GOSSIP_PERFORM_ACTION			= "自動選擇對話選項來執行動作 (例如使用傳送功能)"
L.AUTO_GOSSIP_START_ENCOUNTER			= "自動選擇對話選項來開始遭遇戰"

-- New special warnings
L.MOVE_WARNING_BAR			= "可移動提示"
L.MOVE_WARNING_MESSAGE		= "感謝您使用"..L.DEADLY_BOSS_MODS..""
L.MOVE_SPECIAL_WARNING_BAR	= "可拖動的特別警告"
L.MOVE_SPECIAL_WARNING_TEXT	= "特別警告"

L.HUD_INVALID_TYPE			= "無效的HUD類型定義"
L.HUD_INVALID_TARGET		= "無有效的HUD目標"
L.HUD_INVALID_SELF			= "不能將HUD目标設定成自己"
L.HUD_INVALID_ICON			= "不能設定對無團隊標記的目標"
L.HUD_SUCCESS				= "HUD成功使用你的參數運作。這會在%s後取消，或是使用'/dbm hud hide'指令取消。"
L.HUD_USAGE	= {
	L.DBM .. "-HudMap 用法:",
	"-----------------",
	"/dbm hud <類型> <目標> <持續時間>: 建立一個指向玩家的HUD",
	"有效類型: arrow, dot, red, blue, green, yellow, icon(需要團隊標記)",
	"有效目標: target, focus, <玩家名字>",
	"有效持續時間: 任何秒數。如果無輸入值則預設為20分鐘",
	"/dbm hud hide  停用玩家生成的HUD物件"
}

L.ARROW_MOVABLE					= "可移動箭頭"
L.ARROW_WAY_USAGE				= "/dway <x> <y>: 建立一個箭頭指向一個指定地點 (使用本地區域地圖座標)"
L.ARROW_WAY_SUCCESS				= "要隱藏箭頭，鍵入 '/dbm arrow hide' 或到達箭頭"
L.ARROW_ERROR_USAGE	= {
	L.DBM .. "-Arrow 用法:",
	"-----------------",
	"/dbm arrow <x> <y>: 建立一個箭頭在特定的位置(使用世界地圖座標)",
	"/dbm arrow map <x> <y>: 建立一個箭頭在特定的位置 (使用小地圖座標)",
	"/dbm arrow <玩家>: 建立並箭頭指向你的隊伍或團隊中特定的玩家",
	"/dbm arrow hide: 隱藏箭頭",
	"/dbm arrow move: 可移動箭頭"
}

L.SPEED_KILL_TIMER_TEXT			= "勝利紀錄"
L.SPEED_CLEAR_TIMER_TEXT		= "最佳紀錄"
L.COMBAT_RES_TIMER_TEXT			= "下一個戰復充能"
L.TIMER_RESPAWN					= "%s 重生"

L.LAG_CHECKING					= "檢測團隊成員的網路延遲中..."
L.LAG_HEADER					= ""..L.DEADLY_BOSS_MODS.." - 網路延遲結果"
L.LAG_ENTRY						= "%s:世界延遲[%d毫秒]/本地延遲[%d毫秒]"
L.LAG_FOOTER					= "無回應:%s"

L.DUR_CHECKING					= "檢測團隊裝備耐久度..."
L.DUR_HEADER					= ""..L.DEADLY_BOSS_MODS.." - 裝備耐久度結果"
L.DUR_ENTRY						= "%s:耐久度[%d百分比]/裝備損壞[%s]"

L.OVERRIDE_ACTIVATED			= "領隊已啟用此首領的配置覆蓋"

--LDB
L.LDB_TOOLTIP_HELP1				= "點擊開啟" .. L.DBM
L.LDB_TOOLTIP_HELP2				= "Alt+右鍵點擊切換到無聲模式"
L.SILENTMODE_IS                 = "無聲模式是 "

L.WORLD_BUFFS = {
	hordeOny							= "部落的人民，奧格瑪的城民，來吧，聚集到一起歡慶部落英雄的誕生。",
	allianceOny							= "暴風城的城民和盟友們，今天，有人創造了歷史。",
	hordeNef							= "奈法利安被!@#掉了！奧格瑪的人們",
	allianceNef							= "聯盟的人民們，黑石領主已經被幹掉了！",
	zgHeart								= "只差最後一步，我們就可以擺脫靈魂掠奪者的威脅了……",
	zgHeartBooty						= "靈魂掠奪者血神已經被打敗了！我們不再有危險了！",
	zgHeartYojamba						= "開始儀式，我的僕從們。我們必須把哈卡完全打回扭曲虛空中！",
	rendHead							= "那個假的酋長，雷德·黑手，已經倒下了！",
	blackfathomBoon						= "黑澗深淵的恩賜"
}

-- Annoying popup, especially for classic players
L.DBM_INSTALL_REMINDER_HEADER	= "檢測到不完整的DBM安裝！"
--L.DBM_INSTALL_REMINDER_EXPLAIN	= "Welcome to %s. DBM mods for bosses here are in the %s which you do not have installed. DBM will not show timers or warnings in this zone unless you install the %s!"
L.DBM_INSTALL_REMINDER_DISABLE	= "停用此區域的全部 DBM 警告與計時器。" -- Used when we believe it's a user error that the mod isn't installed (i.e., current raids)
L.DBM_INSTALL_REMINDER_DISABLE2 = "不要再顯示此組件的訊息。" -- Used for unimportant mods, i.e., dungeons
L.DBM_INSTALL_REMINDER_DL_WAGO	= "按下 " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " 來複製Wago.io的連結到剪貼簿。"
L.DBM_INSTALL_REMINDER_DL_CURSE	= "按下 " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " 來複製Curseforge的連結到剪貼簿。"
--"Press " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "
L.DBM_INSTALL_PACKAGE_VANILLA	= "經典與探索賽季組件"
L.DBM_INSTALL_PACKAGE_BCC		= "燃燒的遠征組件"
L.DBM_INSTALL_PACKAGE_WRATH		= "巫妖王組件"
L.DBM_INSTALL_PACKAGE_CATA		= "浩劫與重生組件"
L.DBM_INSTALL_PACKAGE_MOP		= "潘達利亞的迷霧組件"
L.DBM_INSTALL_PACKAGE_DUNGEON	= "地下城、探究以及事件組件"

-- Tests
L.DBM_TAINTED_BY_TESTS			= "DBM在當前階段使用了包含時間扭曲的測試模式，建議使用DBM在真正的首領戰鬥中之前重新載入UI。一切都應該按預期工作但並不保證！"
