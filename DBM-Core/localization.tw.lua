if GetLocale() ~= "zhTW" then return end
DBM_CORE_LOAD_MOD_ERROR				= "讀取%s模組時發生錯誤：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功讀取%s模組!"
DBM_CORE_LOAD_GUI_ERROR				= "無法讀取圖形介面：%s"

DBM_CORE_COMBAT_STARTED				= "%s開戰. 祝好運與盡興! :)";
DBM_CORE_BOSS_DOWN				= "%s 倒地, 經過 %s!"
DBM_CORE_BOSS_DOWN_LONG				= "%s倒地!本次經過%s，上次經過%s，最快一次%s。"
DBM_CORE_BOSS_DOWN_NEW_RECORD			= "%s倒地! 經過	%s，這是一個新記錄!（舊紀錄為%s）"
DBM_CORE_COMBAT_ENDED				= "%s 的戰鬥經過 %s 結束."

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分鐘"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN					= "分"
DBM_CORE_MIN_FMT				= "%d 分"
DBM_CORE_SEC					= "秒"
DBM_CORE_SEC_FMT				= "%d 秒"
DBM_CORE_DEAD					= "死亡"
DBM_CORE_OK					= "確定"

DBM_CORE_GENERIC_WARNING_ENRAGE			= "%s%s後狂怒"
DBM_CORE_GENERIC_TIMER_ENRAGE			= "狂怒"
DBM_CORE_OPTION_TIMER_ENRAGE			= "顯示狂怒計時器"
DBM_CORE_OPTION_HEALTH_FRAME			= "顯示首領血量框架"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "計時條"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "公佈"
DBM_CORE_OPTION_CATEGORY_MISC			= "其它"

DBM_CORE_AUTO_RESPONDED				= "已自動回復密語。"
DBM_CORE_STATUS_WHISPER				= "%s：%s，%d/%d存活"
DBM_CORE_AUTO_RESPOND_WHISPER			= "%s正在與%s交戰，（當前%s，%d/%d存活）"

DBM_CORE_VERSIONCHECK_HEADER			= "Deadly Boss Mods - 版本檢測"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s：%s(r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM		= "%s：尚未安裝DBM"
DBM_CORE_VERSIONCHECK_FOOTER			= "團隊中有%d名成員正在使用Deadly Boss Mods"

DBM_CORE_UPDATEREMINDER_HEADER			= "你的 Deadly Boss Mod 已經過期! \n你可以在如下位址下載到新版本%s(r%d)："
DBM_CORE_UPDATEREMINDER_FOOTER			= "Ctrl-C：複製下載地址到剪貼本。"
DBM_CORE_UPDATEREMINDER_NOTAGAIN		= "當有新版本時顯示彈出提示"

DBM_CORE_MOVABLE_BAR				= "拖動我!"

DBM_PIZZA_SYNC_INFO				= "|Hplayer:%1$s|h[%1$s]|h向你發送了一個倒計時：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消該計時]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略來自%1$s的計時]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在該次遊戲連接中遮罩來自%s的計時？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <時間（秒）> <文字>"

DBM_CORE_ERROR_DBMV3_LOADED			= "目前有2個版本的Deadly Boss Mods正在運行：DBMv3和DBMv4。\n按一下“確定”按鈕可將DBMv3關閉並重載使用者介面。\n我們建議將外掛程式目錄下的DBMv3刪除。"

DBM_CORE_MINIMAP_TOOLTIP_HEADER			= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER			= "Shift+按一下或右鍵點擊即可移動"

DBM_CORE_RANGECHECK_HEADER			= "距離監視（%d碼）"
DBM_CORE_RANGECHECK_SETRANGE			= "設置距離"
DBM_CORE_RANGECHECK_SOUNDS			= "聲音"
DBM_CORE_RANGECHECK_SOUND_OPTION_1		= "當一位玩家在範圍內時播放音效"
DBM_CORE_RANGECHECK_SOUND_OPTION_2		= "當多於一位玩家時播放音效"
DBM_CORE_RANGECHECK_SOUND_0			= "沒有聲音"
DBM_CORE_RANGECHECK_SOUND_1			= "預設聲音"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鳴聲"
DBM_CORE_RANGECHECK_HIDE			= "隱藏"
DBM_CORE_RANGECHECK_SETRANGE_TO			= "%d碼"
DBM_CORE_RANGECHECK_LOCK			= "鎖定框架"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/dbm version：進行團隊範圍的DBM版本檢測（也可使用：ver）",
	"/dbm unlock：顯示一個可移動的計時條，可通過對它來移動所有DBM計時條的位置（也可使用：move）",
	"/dbm timer <x> <文本>：開始一個以<文本>為名稱的時間為<x>秒的倒計時",
	"/dbm broadcast timer <x> <文本>：向團隊廣播一個以<文本>為名稱的時間為<x>秒的倒計時（需要團隊領袖或助理許可權）",
	"/dbm help：顯示該説明資訊",
}

DBM_ERROR_NO_PERMISSION				= "無權進行該操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME			= "關閉血量框架"

DBM_CORE_ALLIANCE				= "聯盟"
DBM_CORE_HORDE					= "部落"

DBM_CORE_UNKNOWN				= "未知"

DBM_CORE_TIMER_PULL				= "戰鬥準備"
DBM_CORE_ANNOUNCE_PULL				= "%d秒後拉怪"
DBM_CORE_ANNOUNCE_PULL_NOW			= "拉怪囉!"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "快速擊殺"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target = "%s: %%s",
	cast = "%s",
	active = "%s",
	cd = "%s 冷卻",
	next = "下一次 %s",
	achievement = "%s",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target = "顯示|cff71d5ff|Hspell:%d|h%s|h|r減益計時器",
	cast = "顯示|cff71d5ff|Hspell:%d|h%s|h|r施法計時器",
	active = "顯示|cff71d5ff|Hspell:%d|h%s|h|r持續時間計時器",
	cd = "顯示|cff71d5ff|Hspell:%d|h%s|h|r冷卻計時器",
	next = "顯示下一次 |cff71d5ff|Hspell:%d|h%s|h|r顯示計時器",
	achievement = "為成就:%s顯示計時器",
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target = "%s: >%%s<",
	spell = "%s",
	cast = "施放 %s: %.1f 秒",
	soon = "%s 即將發動",
	prewarn = "%s 在 %s",
	phase = "第%d階段",
}

local prewarnOption = "為|cff71d5ff|Hspell:%d|h%s|h|r顯示預先警告"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target = "當|cff71d5ff|Hspell:%d|h%s|h|r施放在玩家身上時顯示警告",
	spell = "為|cff71d5ff|Hspell:%d|h%s|h|r顯示警告",
	cast = "當|cff71d5ff|Hspell:%d|h%s|h|r施放時顯示警告",
	soon = prewarnOption,
	prewarn = prewarnOption,
	phase = "為第%d階段顯示警告"
}