-- Simplified Chinese by Diablohu/yleaf(yaroot@gmail.com)
-- http://wow.gamespot.com.cn
-- Last Update: 12/13/2008

-- yleaf (yaroot@gmail.com) 9-19-2009
-- merge traslation by bigfoot team  - yleaf 9-10-2010

if GetLocale() ~= "zhCN" then return end

DBM_CORE_NEED_SUPPORT				= "嘿, 你是否拥有良好的程序开发或语言能力? 如果是的话, DBM团队真心需要你的帮助以保持成为WOW里面最佳的首领报警插件。请访问 www.deadlybossmods.com 或发送邮件给 tandanu@deadlybossmods.com 或者 nitram@deadlybossmods.com 来加入我们的行列。"
DBM_HOW_TO_USE_MOD					= "欢迎使用DBM。在聊天框输入 /dbm 就可以打开设定面板进行设置。手动载入不同副本模块就可以根据你自己的喜好来调整每个首领的相关报警设定。"

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
DBM_CORE_WHISPER_COMBAT_END_KILL	= "%s已经击败%s!"
DBM_CORE_WHISPER_COMBAT_END_WIPE	= "%s在%s的战斗中灭团了。"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - 版本检测"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s：%s(r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：尚未安装DBM"
DBM_CORE_VERSIONCHECK_FOOTER		= "团队中有%d名成员正在使用Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED		= "你的 Deadly Boss Mod 已经过期。请到 www.deadlybossmods.com 下载最新版本。"

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
DBM_CORE_RANGECHECK_LOCK			= "锁定框架"

DBM_CORE_INFOFRAME_HIDE				= "隐藏"
DBM_CORE_INFOFRAME_LOCK				= "锁定框架"

DBM_LFG_INVITE						= "地下城准备确认"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/dbm version：进行团队范围的DBM版本检测（也可使用：ver）",
	"/dbm version2: 进行团队范围的DBM版本检测并密语给那些使用过期版本的玩家（也可使用：ver2）",
	"/dbm unlock：显示一个可移动的计时条，可通过对它来移动所有DBM计时条的位置（也可使用：move）",
	"/dbm timer <x> <文本>：开始一个以<文本>为名称的时间为<x>秒的倒计时",
	"/dbm broadcast timer <x> <文本>：向团队广播一个以<文本>为名称的时间为<x>秒的倒计时（需要团队领袖或助理权限）",
	"/dbm break <分钟>: 开始一个<分钟>时间的休息计时条。并向所有团队成员发送这个DBM休息计时条（需开启团队广播及助理权限）。",
	"/dbm pull <秒>: 开始一个<秒>时间的开怪计时条。 并向所有团队成员发送这个DBM开怪计时条（需开启团队广播及助理权限）。",
	"/dbm help：显示可用命令的说明。",
}

DBM_ERROR_NO_PERMISSION				= "无权进行该操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "隐藏"

DBM_CORE_ALLIANCE					= "联盟"
DBM_CORE_HORDE						= "部落"

DBM_CORE_UNKNOWN					= "未知"

DBM_CORE_BREAK_START				= "现在开始休息 - 你有%s分钟！"
DBM_CORE_BREAK_MIN					= "%s分钟后休息结束！"
DBM_CORE_BREAK_SEC					= "%s秒后休息结束！"
DBM_CORE_TIMER_BREAK				= "休息时间！"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息时间已经结束"

DBM_CORE_TIMER_PULL					= "开怪倒计时"
DBM_CORE_ANNOUNCE_PULL				= "%d 秒后开怪"
DBM_CORE_ANNOUNCE_PULL_NOW			= "开怪！"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "快速击杀"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS = {
	target					= "%s: %%s",
	cast					= "%s",
	active					= "%s",
	cd					= "%s 冷却",
	next 					= "下一次 %s",
	achievement 				= "%s",
}

DBM_CORE_AUTO_TIMER_OPTIONS = {
	target					= "显示|cff71d5ff|Hspell:%d|h%s|h|rdebuff计时",
	cast					= "显示|cff71d5ff|Hspell:%d|h%s|h|r施法计时",
	active					= "显示|cff71d5ff|Hspell:%d|h%s|h|r持续计时",
	cd					= "显示|cff71d5ff|Hspell:%d|h%s|h|r冷却计时",
	next					= "显示下一次|cff71d5ff|Hspell:%d|h%s|h|r倒计时",
	achievement				= "显示成就：%s计时",
}

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS = {
	target					= "%s: >%%s<",
	spell					= "%s",
	cast					= "施放%s：%.1f秒",
	soon					= "即将 %s",
	prewarn					= "%2$s后 %1$s",
	phase					= "第%s阶段",
	prephase				= "第%s阶段 即将到来",
	count					= "%s (%%d)",
	stack					= "%s: >%%s< (%%d)",
}

local prewarnOption				= "显示提前警报：|cff71d5ff|Hspell:%d|h%s|h|r"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS = {
	target					= "警报|cff71d5ff|Hspell:%d|h%s|h|r的目标",
	spell					= "显示警报：|cff71d5ff|Hspell:%d|h%s|h|r",
	cast					= "显示施法警报：|cff71d5ff|Hspell:%d|h%s|h|r",
	soon					= prewarnOption,
	prewarn					= prewarnOption,
	phase					= "显示第%s阶段提示",
	prephase				= "为第%s阶段显示提前警报",
	count					= "显示警报：|cff71d5ff|Hspell:%d|h%s|h|r",
	stack					= "警报|cff71d5ff|Hspell:%d|h%s|h|r的目标",
}


-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS = {
	spell					= "显示特别警报：$spell:%d",
	dispel					= "需要驱散/偷取$spell:%d时显示特别警报",
	interrupt				= "需要打断$spell:%d时显示特别警报",
	you					= "当你中了$spell:%d时显示特别警报",
	target					= "当有人中了$spell:%d时显示特别警报",
	close					= "当你附近有人中了$spell:%d时显示特别警报",
	move					= "当你中了$spell:%d需要躲开时显示特别警报",
	run					= "当你中了$spell:%d需要跑开时显示特别警报",
	cast					= "显示特别施法警报：$spell:%d",
	stack					= "当叠加了>=%d层$spell:%d时显示特别警报"
}

DBM_CORE_AUTO_SPEC_WARN_TEXTS = {
	spell					= "%s!",
	dispel					= "%%s中了%s - 快驱散",
	interrupt				= "%s - 快打断",
	you					= "你中了%s",
	target					= "%%s中了%s",
	close					= "你附近的%%s中了%s",
	move					= "%s - 快躲开",
	run					= "%s - 快跑",
	cast					= "%s - 停止施法",
	stack					= "%s (%%d)"
}


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "设定标记给$spell:%d的目标"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "为$spell:%d播放警报音效"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "当你中了$spell:%d时大喊"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "%s - 远离我"--Verify (%s is spellname)


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR		= "可拖动的特别警报"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT		= "特别警报"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED		= "此区域不支持%d码的距离检查。\n已支持的距离有10，11，15及28码。"

DBM_ARROW_MOVABLE				= "可移动箭头"
DBM_ARROW_NO_RAIDGROUP				= "此功能仅适用于副本中的团队。"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 可用命令：",
	"/dbm arrow <x> <y>  新建一个箭头在指定位置(0 < x/y < 100)",
	"/dbm arrow <玩家>  新建一个箭头并指向你队伍或团队中特定的玩家",
	"/dbm arrow hide  隐藏箭头",
	"/dbm arrow move  移动或锁定箭头",
}
