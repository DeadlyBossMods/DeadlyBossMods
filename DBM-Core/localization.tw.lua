if GetLocale() ~= "zhTW" then return end

DBM_CORE_NEED_SUPPORT				= "嘿, 你是否擁有良好的程式開發或語言能力? 如果是的話, DBM團隊真的需要你的幫助以保持成為WOW入面最佳的首領模組。觀看 www.deadlybossmods.com 或發送郵件到 tandanu@deadlybossmods.com 或 nitram@deadlybossmods.com 來加入團隊。"
DBM_HOW_TO_USE_MOD				= "歡迎使用DBM。在聊天頻道輸入 /dbm 打開設定開始設定。你可以載入特定區域後為任何首領設定你喜歡的特別設置。DBM會在第一次啟動時嘗試掃描你的職業天賦，但有些選項你可能想打開。"

DBM_CORE_LOAD_MOD_ERROR				= "載入%s模組時發生錯誤：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功載入%s模組。輸入/dbm有更多選項。"
DBM_CORE_LOAD_GUI_ERROR				= "無法載入圖形介面：%s"

DBM_CORE_COMBAT_STARTED				= "%s開戰。祝好運與盡興! :)";
DBM_CORE_BOSS_DOWN				= "擊敗%s，經過%s!"
DBM_CORE_BOSS_DOWN_LONG				= "擊敗%s!本次經過%s，上次經過%s，最快紀錄%s。"
DBM_CORE_BOSS_DOWN_NEW_RECORD			= "擊敗%s!經過%s，這是一個新記錄!（舊紀錄為%s）"
DBM_CORE_COMBAT_ENDED				= "%s的戰鬥經過%s結束。"

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分鐘"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN					= "分"
DBM_CORE_MIN_FMT				= "%d分"
DBM_CORE_SEC					= "秒"
DBM_CORE_SEC_FMT				= "%d秒"
DBM_CORE_DEAD					= "死亡"
DBM_CORE_OK					= "確定"

DBM_CORE_GENERIC_WARNING_BERSERK		= "%s%s後狂暴"
DBM_CORE_GENERIC_TIMER_BERSERK			= "狂暴"
DBM_CORE_OPTION_TIMER_BERSERK			= "為$spell:26662顯示計時器"
DBM_CORE_OPTION_HEALTH_FRAME			= "顯示首領血量框架"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "計時器"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "提示"
DBM_CORE_OPTION_CATEGORY_MISC			= "其它"

DBM_CORE_AUTO_RESPONDED				= "已自動回覆密語。"
DBM_CORE_STATUS_WHISPER				= "%s：%s，%d/%d存活。"
DBM_CORE_AUTO_RESPOND_WHISPER			= "%s正在與%s交戰（當前%s，%d/%d存活）"
DBM_CORE_WHISPER_COMBAT_END_KILL		= "%s已經擊敗%s!"
DBM_CORE_WHISPER_COMBAT_END_WIPE		= "%s在%s的戰鬥中滅團了。"

DBM_CORE_VERSIONCHECK_HEADER			= "Deadly Boss Mods - 版本檢測"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s：%s(r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM		= "%s：尚未安裝DBM"
DBM_CORE_VERSIONCHECK_FOOTER			= "團隊中有%d名成員正在使用Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED			= "你的 Deadly Boss Mod 已經過期。請到 www.deadlybossmods.com 下載最新版本。"

DBM_CORE_UPDATEREMINDER_HEADER			= "你的 Deadly Boss Mod 已經過期。\n你可以在此網址下載到新版本%s(r%d)："
DBM_CORE_UPDATEREMINDER_FOOTER			= "Ctrl-C：複製下載網址到剪貼簿。"
DBM_CORE_UPDATEREMINDER_NOTAGAIN		= "當有新版本時顯示彈出提示"

DBM_CORE_MOVABLE_BAR				= "拖動我!"

DBM_PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h向你發送了一個倒數計時：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消該計時]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略來自%1$s的計時]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在該次遊戲連結中忽略來自%s的計時？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <時間（秒）> <文字>"

DBM_CORE_ERROR_DBMV3_LOADED			= "目前有2個版本的Deadly Boss Mods正在運行：DBMv3和DBMv4。\n按一下“確定”按鈕可將DBMv3關閉並重載插件。\n我們建議將插件目錄下的DBMv3刪除。"

DBM_CORE_MINIMAP_TOOLTIP_HEADER			= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER			= "Shift+左鍵或右鍵點擊即可移動"

DBM_CORE_RANGECHECK_HEADER			= "距離監視（%d碼）"
DBM_CORE_RANGECHECK_SETRANGE			= "設置距離"
DBM_CORE_RANGECHECK_SOUNDS			= "音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_1		= "當一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_2		= "當多於一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_0			= "沒有音效"
DBM_CORE_RANGECHECK_SOUND_1			= "預設音效"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鳴聲"
DBM_CORE_RANGECHECK_HIDE			= "隱藏"
DBM_CORE_RANGECHECK_SETRANGE_TO			= "%d碼"
DBM_CORE_RANGECHECK_LOCK			= "鎖定框架"

DBM_CORE_INFOFRAME_LOCK				= "鎖定框架"
DBM_CORE_INFOFRAME_HIDE				= "隱藏"
DBM_CORE_INFOFRAME_SHOW_SELF			= "總是顯示你的能量"		-- Always show your own power value even if you are below the threshold


DBM_LFG_INVITE					= "地城準備確認"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/dbm version：進行團隊範圍內的版本檢測（也可使用：ver）。",
	"/dbm version2: 進行團隊範圍內的版本檢測及密語通知已過期的成員（也可使用: ver2）。",
	"/dbm unlock：顯示一個可移動的計時器（也可使用：move）。",
	"/dbm timer <x> <文字>：開始一個以<文字>為名稱的時間為<x>秒的計時器。",
	"/dbm broadcast timer <x> <文字>：向團隊廣播一個以<文字>為名稱，時間為<x>秒的計時器（需開啟團隊廣播及助理權限）。",
	"/dbm pull <秒數>: 開始備戰計時器<秒數>。向所有團隊成員發送一個DBM備戰計時器（需開啟團隊廣播及助理權限）。",
	"/dbm break <分鐘>: 開始休息計時器<分鐘>。向所有團隊成員發送一個DBM休息計時器（需開啟團隊廣播及助理權限）。",
	"/dbm help：顯示可用命令的說明。",
}

DBM_ERROR_NO_PERMISSION				= "無權進行此操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME			= "關閉血量框架"

DBM_CORE_ALLIANCE				= "聯盟"
DBM_CORE_HORDE					= "部落"

DBM_CORE_UNKNOWN				= "未知"

DBM_CORE_BREAK_START				= "現在開始休息-你有%s分鐘!"
DBM_CORE_BREAK_MIN				= "%s分鐘後休息時間結束!"
DBM_CORE_BREAK_SEC				= "%s秒後休息時間結束!"
DBM_CORE_TIMER_BREAK				= "休息時間!"
DBM_CORE_ANNOUNCE_BREAK_OVER			= "休息時間已經結束"

DBM_CORE_TIMER_PULL				= "戰鬥準備"
DBM_CORE_ANNOUNCE_PULL				= "%d秒後拉怪"
DBM_CORE_ANNOUNCE_PULL_NOW			= "拉怪囉!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL 		= "快速擊殺"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target					= "%s: %%s",
	cast					= "%s",
	active					= "%s",
	cd					= "%s 冷卻",
	next 					= "下一次 %s",
	achievement 				= "%s",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target					= "為|cff71d5ff|Hspell:%d|h%s|h|r顯示減益計時器",
	cast					= "為|cff71d5ff|Hspell:%d|h%s|h|r顯示施法計時器",
	active					= "為|cff71d5ff|Hspell:%d|h%s|h|r顯示持續時間計時器",
	cd					= "為|cff71d5ff|Hspell:%d|h%s|h|r顯示冷卻計時器",
	next					= "為下一次 |cff71d5ff|Hspell:%d|h%s|h|r顯示計時器",
	achievement				= "為成就:%s顯示計時器",
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target					= "%s: >%%s<",
	spell					= "%s",
	cast					= "施放 %s: %.1f 秒",
	soon					= "%s 即將到來",
	prewarn					= "%s 在 %s",
	phase					= "第%s階段",
	prephase				= "第%s階段 即將到來",
	count					= "%s (%%d)",
	stack					= "%s: >%%s< (%%d)",
}

local prewarnOption				= "為|cff71d5ff|Hspell:%d|h%s|h|r顯示預先警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target					= "提示|cff71d5ff|Hspell:%d|h%s|h|r的目標",
	spell					= "為|cff71d5ff|Hspell:%d|h%s|h|r顯示警告",
	cast					= "當|cff71d5ff|Hspell:%d|h%s|h|r施放時顯示警告",
	soon					= prewarnOption,
	prewarn					= prewarnOption,
	phase					= "提示第%s階段",
	prephase				= "為第%s階段顯示預先警告",
	count					= "為|cff71d5ff|Hspell:%d|h%s|h|r顯示警告",
	stack					= "提示|cff71d5ff|Hspell:%d|h%s|h|r的目標",
}

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell					= "為$spell:%d顯示特別警告",
	dispel					= "需對$spell:%d驅散/竊取時顯示特別警告",
	interrupt				= "需對$spell:%d斷法時顯示特別警告",
	you					= "當你中了$spell:%d時顯示特別警告",
	target					= "當有人中了$spell:%d時顯示特別警告",
	close					= "當你附近有人中了$spell:%d時顯示特別警告",
	move					= "當你中了$spell:%d時顯示特別警告",
	run					= "為$spell:%d顯示特別警告",
	cast					= "為$spell:%d施放時顯示特別警告",
	stack					= "為>=%d層$spell:%d時顯示特別警告"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell					= "%s!",
	dispel					= "%%s中了%s - 現在驅散",
	interrupt				= "%s - 現在斷法",
	you					= "你中了%s",
	target					= "%%s中了%s",
	close					= "你附近的%%s中了%s",
	move					= "%s - 快離開",
	run					= "%s - 快跑開",
	cast					= "%s - 停止施法",
	stack					= "%s (%%d)"
}

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "為$spell:%d的目標設置標記"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "當你中了$spell:%d時播放音效"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "當你中了$spell:%d時大喊"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "我中了%s!"

-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR		= "可拖動的特別警告"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT		= "特別警告"

DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED		= "在此區域中不支援%d碼的距離檢查。\n已支援的距離有10，11，15及28碼。"

DBM_ARROW_MOVABLE				= "可移動箭頭"

DBM_ARROW_NO_RAIDGROUP				= "此功能僅作用於團隊副本中的團隊小隊。"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 用法:",
	"/dbm arrow <x> <y>  建立一個箭頭在特定的位置(0 < x/y < 100)",
	"/dbm arrow <玩家>  建立並箭頭指向你的隊伍或團隊中特定的玩家",
	"/dbm arrow hide  隱藏箭頭",
	"/dbm arrow move  可移動箭頭",
}

DBM_SPEED_KILL_TIMER_TEXT			= "記錄擊殺"
DBM_SPEED_KILL_TIMER_OPTION			= "顯示一個計時器來打敗你上次的最快擊殺"