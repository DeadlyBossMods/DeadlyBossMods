-- Simplified Chinese by Diablohu/yleaf(yaroot@gmail.com)
-- http://wow.gamespot.com.cn
-- Last Update: 12/13/2008

-- yleaf (yaroot@gmail.com) 9-19-2009

if GetLocale() ~= "zhCN" then return end

DBM_CORE_LOAD_MOD_ERROR				= "读取%s模块时发生错误：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功读取%s模块！"
DBM_CORE_LOAD_GUI_ERROR				= "无法读取图形界面：%s"

DBM_CORE_COMBAT_STARTED				= "%s作战开始，祝你走运 :)";
DBM_CORE_BOSS_DOWN					= "%s被击杀！用时%s。"
DBM_CORE_BOSS_DOWN_LONG				= "%s被击杀！本次用时%s，上次用时%s，最快击杀用时%s。"
DBM_CORE_BOSS_DOWN_NEW_RECORD		= "%s被击杀！用时%s，新的击杀纪录诞生了！（原纪录为%s）"
DBM_CORE_COMBAT_ENDED				= "%s作战结束，用时%s。"

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分钟"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN						= "分"
DBM_CORE_MIN_FMT					= "%d 分"
DBM_CORE_SEC						= "秒"
DBM_CORE_SEC_FMT					= "%d 秒"
DBM_CORE_DEAD						= "死亡"
DBM_CORE_OK							= "确定"

DBM_CORE_GENERIC_WARNING_BERSERK	= "%s%s后激怒"
DBM_CORE_GENERIC_TIMER_BERSERK		= "激怒"
DBM_CORE_OPTION_TIMER_BERSERK		= "显示激怒倒计时"
DBM_CORE_OPTION_HEALTH_FRAME		= "显示首领生命值窗口"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "计时条"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "警报"
DBM_CORE_OPTION_CATEGORY_MISC		= "其它"

DBM_CORE_AUTO_RESPONDED				= "已自动回复密语。"
DBM_CORE_STATUS_WHISPER				= "%s：%s，%d/%d存活"
DBM_CORE_AUTO_RESPOND_WHISPER		= "%s正在与%s交战，（当前%s，%d/%d存活）"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - 版本检测"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s：%s(r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：尚未安装DBM"
DBM_CORE_VERSIONCHECK_FOOTER		= "团队中有%d名成员正在使用Deadly Boss Mods"

DBM_CORE_UPDATEREMINDER_HEADER		= "你的Deadly Boss Mods版本已过期。\n你可以在如下地址下载到新版本%s(r%d)："
DBM_CORE_UPDATEREMINDER_FOOTER		= "Ctrl-C：复制下载地址到剪切板。"
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "发现新版本后弹出提示框"

DBM_CORE_MOVABLE_BAR				= "拖动我！"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h向你发送了一个倒计时：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消该计时]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略来自%1$s的计时]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在该次游戏连接中屏蔽来自%s的计时？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <时间（秒）> <文本>"

DBM_CORE_ERROR_DBMV3_LOADED			= "目前有2个版本的Deadly Boss Mods正在运行：DBMv3和DBMv4。\n单击“确定”按钮可将DBMv3关闭并重载用户界面。\n我们建议将插件目录下的DBMv3删除。"

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+单击或右键点击即可移动"

DBM_CORE_RANGECHECK_HEADER			= "距离监视（%d码）"
DBM_CORE_RANGECHECK_SETRANGE		= "设置距离"
DBM_CORE_RANGECHECK_SOUNDS			= "声音"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "当有玩家接近时播放声音提示"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "多名玩家接近提示"
DBM_CORE_RANGECHECK_SOUND_0			= "无"
DBM_CORE_RANGECHECK_SOUND_1			= "默认声音"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鸣"
DBM_CORE_RANGECHECK_HIDE			= "隐藏"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d码"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/dbm version：进行团队范围的DBM版本检测（也可使用：ver）",
	"/dbm unlock：显示一个可移动的计时条，可通过对它来移动所有DBM计时条的位置（也可使用：move）",
	"/dbm timer <x> <文本>：开始一个以<文本>为名称的时间为<x>秒的倒计时",
	"/dbm broadcast timer <x> <文本>：向团队广播一个以<文本>为名称的时间为<x>秒的倒计时（需要团队领袖或助理权限）",
	"/dbm help：显示该帮助信息",
}

DBM_ERROR_NO_PERMISSION				= "无权进行该操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "隐藏"

DBM_CORE_ALLIANCE					= "联盟"
DBM_CORE_HORDE						= "部落"

DBM_CORE_UNKNOWN					= "未知"

DBM_CORE_TIMER_PULL					= "开怪倒计时"
DBM_CORE_ANNOUNCE_PULL				= "%d 秒后开怪"
DBM_CORE_ANNOUNCE_PULL_NOW			= "开怪！"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "快速击杀"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target = "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.cast = "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active = "%s"
DBM_CORE_AUTO_TIMER_TEXTS.cd = "%s 冷却"
DBM_CORE_AUTO_TIMER_TEXTS.next = "下一次 %s"
DBM_CORE_AUTO_TIMER_TEXTS.achievement = "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target = "显示 |cff71d5ff|Hspell:%d|h%s|h|r debuff计时"
DBM_CORE_AUTO_TIMER_OPTIONS.cast = "显示 |cff71d5ff|Hspell:%d|h%s|h|r 施法计时"
DBM_CORE_AUTO_TIMER_OPTIONS.active = "显示 |cff71d5ff|Hspell:%d|h%s|h|r 持续计时"
DBM_CORE_AUTO_TIMER_OPTIONS.cd = "显示 |cff71d5ff|Hspell:%d|h%s|h|r 冷却计时"
DBM_CORE_AUTO_TIMER_OPTIONS.next = "显示下一次 |cff71d5ff|Hspell:%d|h%s|h|r 计时"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement = "显示成就: %s 计时"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target = "%s 于 >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell = "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast = "%s: %.1f sec"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon = "即将 %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn = "%2$s 后 %1$s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase = "第 %d 阶段"

DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target = "警报目标的: |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell = "显示警报: |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast = "施法提示: |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon = "提前警报 |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn = "提前警报 |cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase = "显示阶段提示: %d"

-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "移动特殊警报"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "特殊警报"




