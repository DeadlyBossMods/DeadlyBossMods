-- Simplified Chinese by Diablohu(diablohudream@gmail.com) & yleaf(yaroot@gmail.com)
-- merge traslation by bigfoot team  - yleaf 9-10-2010
-- Last update: 2/25/2013

if GetLocale() ~= "zhCN" then return end

DBM_CORE_NEED_SUPPORT				= "嘿, 你是否拥有良好的程序开发或语言能力? 如果是的话, DBM团队真心需要你的帮助以保持成为WOW里面最佳的首领报警插件。请访问 www.deadlybossmods.com 或发送邮件给 tandanu@deadlybossmods.com 或者 nitram@deadlybossmods.com 来加入我们的行列。"
DBM_HOW_TO_USE_MOD					= "欢迎使用DBM。在聊天框输入 /dbm help 以获取可用命令的帮助。输入 /dbm 可打开设置窗口。手动打开指定区域的模组即可开始针对各个模块进行设置，也可以浏览首领击杀记录。DBM 会在你首次尝试首领战时自动进行扫描，但是有些设置需要手动开启。"

DBM_CORE_LOAD_MOD_ERROR				= "读取%s模块时发生错误：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功读取%s模块。在聊天框输入 /dbm 或 /dbm help 可进行更多设置。"
DBM_CORE_LOAD_GUI_ERROR				= "无法读取图形界面：%s"
DBM_CORE_LOAD_GUI_COMBAT			= "无法在战斗中初始化图形界面。请先在非战斗状态打开图形设置界面，之后的战斗中就可以自由打开和关闭该界面了。"

DBM_CORE_COMBAT_STARTED				= "%s作战开始，祝你走运 :)"
DBM_CORE_BOSS_DOWN					= "%s战斗胜利！用时%s！"
DBM_CORE_BOSS_DOWN_L				= "%s战斗胜利！用时%s！上次用时%s，最快用时%s。总计%d次胜利。"
DBM_CORE_BOSS_DOWN_NR				= "%s战斗胜利！用时%s！新的纪录诞生了！原纪录为%s。总计%d次胜利。"
DBM_CORE_COMBAT_ENDED_AT			= "%s（%s）作战结束，用时%s。"
DBM_CORE_COMBAT_ENDED_AT_LONG		= "%s（%s）作战结束，用时%s。该难度下总计失败%d次。"
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s作战%s前开始，正在恢复计时条……"

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分钟"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN						= "分"
DBM_CORE_MIN_FMT					= "%d分"
DBM_CORE_SEC						= "秒"
DBM_CORE_SEC_FMT					= "%d秒"
DBM_CORE_DEAD						= "死亡"
DBM_CORE_OK							= "确定"

DBM_CORE_GENERIC_WARNING_BERSERK	= "%s%s后狂暴"
DBM_CORE_GENERIC_TIMER_BERSERK		= "狂暴"
DBM_CORE_OPTION_TIMER_BERSERK		= "计时条：$spell:26662"
DBM_CORE_OPTION_HEALTH_FRAME		= "首领生命值窗口"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "计时条"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "警报"
DBM_CORE_OPTION_CATEGORY_MISC		= "其它"

DBM_CORE_AUTO_RESPONDED						= "已自动回复密语。"
DBM_CORE_STATUS_WHISPER						= "%s：%s，%d/%d存活"
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s正在与%s交战，（当前%s，%d/%d存活）"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s已在%s的战斗中取得胜利！"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s已在%s的战斗中取得胜利！总计%d次胜利。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s在%s（%s）的战斗中灭团了。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s在%s（%s）的战斗中灭团了。该难度下总共失败%d次。"

DBM_CORE_VERSIONCHECK_HEADER		= "Deadly Boss Mods - 版本检测"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s：%s (r%d)"
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：未安装DBM"
DBM_CORE_VERSIONCHECK_FOOTER		= "团队中有%d名成员正在使用Deadly Boss Mods"
DBM_CORE_YOUR_VERSION_OUTDATED		= "你的Deadly Boss Mods已经过期。请访问 http://dev.deadlybossmods.com 下载最新版本。"

DBM_CORE_UPDATEREMINDER_HEADER		= "你的Deadly Boss Mods版本已过期。\n你可以在如下地址下载到新版本%s（r%d）："
DBM_CORE_UPDATEREMINDER_FOOTER		= (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "Ctrl+C：复制下载地址到剪切板。"
DBM_CORE_UPDATEREMINDER_NOTAGAIN	= "检测到新版本后弹出提示框"

DBM_CORE_MOVABLE_BAR				= "拖动我！"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h向你发送了一个DBM计时条：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消该计时]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略来自%1$s的计时条]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在该次游戏连接中屏蔽来自%s的计时条？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <时间（秒）> <文本>"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER (Same as English locales)
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+拖动 / 右键拖动：拖动\nAlt+Shift+拖动：自由拖动"

DBM_CORE_RANGECHECK_HEADER			= "距离监视（%d码）"
DBM_CORE_RANGECHECK_SETRANGE		= "设置距离"
DBM_CORE_RANGECHECK_SOUNDS			= "声音"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "声音提示：当有玩家接近时"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "声音提示：多名玩家接近时"
DBM_CORE_RANGECHECK_SOUND_0			= "无"
DBM_CORE_RANGECHECK_SOUND_1			= "默认声音"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鸣"
DBM_CORE_RANGECHECK_HIDE			= "隐藏"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d码"
DBM_CORE_RANGECHECK_LOCK			= "锁定框体"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "框体"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "显示雷达框体"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "显示文本框体"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "同时显示2个框体"
DBM_CORE_RANGECHECK_OPTION_SPEED	= "更新频率（重载界面后生效）"
DBM_CORE_RANGECHECK_OPTION_SLOW		= "慢（适用于低端CPU）"
DBM_CORE_RANGECHECK_OPTION_AVERAGE	= "中"
DBM_CORE_RANGECHECK_OPTION_FAST		= "快（几乎实时）"
DBM_CORE_RANGERADAR_HEADER			= "距离雷达（%d码）"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d人在监视距离内"

DBM_CORE_INFOFRAME_LOCK				= "锁定框体"
DBM_CORE_INFOFRAME_HIDE				= "隐藏"
DBM_CORE_INFOFRAME_SHOW_SELF		= "永远显示你的能量值"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "地下城准备确认"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/dbm version：进行团队范围的DBM版本检测（也可使用：ver）",
--	"/dbm version2: 进行团队范围的DBM版本检测并密语给那些使用过期版本的玩家（也可使用：ver2）",
	"/dbm unlock：显示一个可移动的计时条，可通过对它来移动所有DBM计时条的位置（也可使用：move）",
	"/dbm timer <x> <文本>：开始一个以<文本>为名称的时间为<x>秒的倒计时",
	"/dbm broadcast timer <x> <文本>：向团队广播一个以<文本>为名称的时间为<x>秒的倒计时（需要团队领袖或助理权限）",
	"/dbm break <分钟>: 开始一个<分钟>时间的休息计时条。并向所有团队成员发送这个DBM休息计时条（需开启团队广播及助理权限）。",
	"/dbm pull <秒>: 开始一个<秒>时间的开怪计时条。 并向所有团队成员发送这个DBM开怪计时条（需开启团队广播及助理权限）。",
	"/dbm arrow: 显示DBM箭头，输入/dbm arrow查询更多信息。",
	"/dbm lockout: 查询团队成员当前的副本锁定状态（也可使用：lockouts, ids）（需要团队领袖或助理权限）。",
	"/dbm help：显示可用命令的说明。",
}

DBM_ERROR_NO_PERMISSION				= "无权进行该操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "隐藏生命值框体"

DBM_CORE_ALLIANCE					= "联盟"
DBM_CORE_HORDE						= "部落"

DBM_CORE_UNKNOWN					= "未知"
DBM_CORE_LEFT						= "左"
DBM_CORE_RIGHT						= "右"
DBM_CORE_BACK						= "后"
DBM_CORE_FRONT						= "前"

DBM_CORE_BREAK_START				= "开始休息 - %s分钟！"
DBM_CORE_BREAK_MIN					= "%s分钟后休息结束！"
DBM_CORE_BREAK_SEC					= "%s秒后休息结束！"
DBM_CORE_TIMER_BREAK				= "休息时间！"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息已结束"

DBM_CORE_TIMER_PULL					= "开怪倒计时"
DBM_CORE_ANNOUNCE_PULL				= "%d秒后开怪"
DBM_CORE_ANNOUNCE_PULL_NOW			= "开怪！"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "成就：快速击杀"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s结束" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s消失" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd			= "%s冷却"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "%s冷却（%%d）"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "%s冷却: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next 			= "下一次%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "下一次%s（%%d）"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "下一次%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target		= "计时条：$spell:%s减益效果持续时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cast		= "计时条：$spell:%s施法时间"
DBM_CORE_AUTO_TIMER_OPTIONS.active		= "计时条：$spell:%s效果持续时间"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "计时条：$spell:%s何时从玩家身上消失"
DBM_CORE_AUTO_TIMER_OPTIONS.cd			= "计时条：$spell:%s冷却时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount		= "计时条：$spell:%s冷却时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "计时条：$spell:%s冷却时间以及来源"
DBM_CORE_AUTO_TIMER_OPTIONS.next		= "计时条：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount	= "计时条：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "计时条：下一次$spell:%s以及来源"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement	= "计时条：成就%s"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target			= "%s -> >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%d) -> >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "%s剩余：%%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast			= "正在施放 %s：%.1f秒"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon			= "即将 %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn		= "%2$s后 %1$s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase			= "第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase		= "第%s阶段 即将到来"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count			= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack			= "%s -> >%%s< (%%d)"

local prewarnOption			= "预警：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target		= "警报：$spell:%s的目标"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "警报：$spell:%s的目标"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell		= "警报：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "警报：$spell:%s剩余数量"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast			= "警报：$spell:%s的施放"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase		= "警报：第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase		= "预警：第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count		= "警报：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack		= "警报：$spell:%s叠加层数"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell		= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel		= "特殊警报：需要驱散或偷取$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt	= "特殊警报：需要打断$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you			= "特殊警报：当你受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target		= "特殊警报：当他人受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close		= "特殊警报：当你附近有人受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move		= "特殊警报：当你受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run			= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast		= "特殊警报：$spell:%s的施放"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack		= "特殊警报：当叠加了至少%d层$spell:%s时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch 		= "特殊警报：针对$spell:%s需要转换目标"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell		= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel	= ">%%s<中了%s - 快驱散"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt	= "%s - 快打断"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you		= "你中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target	= ">%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close		= "你附近的>%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move		= "%s - 快躲开"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run		= "%s - 快跑"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast		= "%s - 停止施法"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack		= "%s (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch	= ">%s< - 转换目标"


DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "为$spell:%s的目标添加团队标记"
DBM_CORE_AUTO_SOUND_OPTION_TEXT			= "声音警报（快跑啊）：$spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "声音警报：$spell:%s的冷却时间倒计时"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "声音警报：$spell:%s的持续时间正计时"
DBM_CORE_AUTO_YELL_OPTION_TEXT			= "当你受到$spell:%s影响时时大喊"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT		= "我中了%s！"


-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR		= "可拖动的特别警报"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT		= "特别警报"


DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "此区域不支持%d码的距离检查。\n已支持的距离有10，11，15及28码。"

DBM_ARROW_MOVABLE				= "可移动箭头"
DBM_ARROW_NO_RAIDGROUP			= "此功能仅适用于副本中的团队。"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 可用命令：",
	"/dbm arrow <x> <y>  新建一个箭头在指定位置(0 < x/y < 100)",
	"/dbm arrow <玩家>  新建一个箭头并指向你队伍或团队中特定的玩家",
	"/dbm arrow hide  隐藏箭头",
	"/dbm arrow move  移动或锁定箭头",
}

DBM_SPEED_KILL_TIMER_TEXT	= "击杀记录"
DBM_SPEED_KILL_TIMER_OPTION	= "计时条：最速击杀记录"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s请求获取你现在副本的存档ID与进度。是否愿意向&s提交进度？\n\n注意：在接受后，他可以随时查看您当前的进度情况，直到您下线、掉线或重载用户界面。"
DBM_ERROR_NO_RAID					= "使用该功能需要身处一个团队中。"
DBM_INSTANCE_INFO_REQUESTED			= "已发送团队副本进度查看请求。\n请注意，团员会根据需要选择接受或拒绝该请求。请求时间约一分钟，请等待。"
DBM_INSTANCE_INFO_STATUS_UPDATE		= "已收到%d名团员的进度回复（已安装DBM的团员有%d名）：%d人接受请求，%d人拒绝。生成数据需要约%d秒，请等待。"
DBM_INSTANCE_INFO_ALL_RESPONSES		= "所有团员接受请求。"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "发送者：%s 结果类型：%s 副本名：%s 副本ID：%s 难度：%d 规模：%d 进度：%s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s（%d），难度%d："
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, 进度%d：%s"
DBM_INSTANCE_INFO_STATS_DENIED		= "拒绝请求：%s"
DBM_INSTANCE_INFO_STATS_AWAY		= "暂离：%s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "新版DBM未安装：%s"
DBM_INSTANCE_INFO_RESULTS			= "副本进度扫描结果。" --Note that instances might show up more than once if there are players with localized WoW clients in your raid.
DBM_INSTANCE_INFO_SHOW_RESULTS		= "回复请求的玩家：%s\n|HDBM:showRaidIdResults|h|cff3588ff[点击显示结果]|r|h"
