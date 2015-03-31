-- DBM_Core
-- Diablohu(diablohudream@gmail.com)
-- yleaf(yaroot@gmail.com)
-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Mar 19, 2015@13358

if GetLocale() ~= "zhCN" then return end

DBM_CORE_NEED_SUPPORT				= "如果你会编程并且英语不错，请来帮助我们完善DBM中文翻译。请访问 http://forums.elitistjerks.com/topic/132449-dbm-localizers-needed/ 获取更多消息。"
DBM_CORE_NEED_LOGS					= "DBM 需要战斗记录器 (http://www.wowace.com/addons/transcriptor/) 的日志来使得技能判断更准确. 如果你想帮忙，请用 transcriptor 记录并上传日志文件到 http://forums.elitistjerks.com/topic/132677-deadly-boss-mods-60-testing/ (请压缩他们). 我们现在只对团本数据感兴趣."
DBM_HOW_TO_USE_MOD					= "欢迎使用DBM。在聊天框输入 /dbm help 以获取可用命令的帮助。输入 /dbm 可打开设置窗口，并对各个Boss模块进行设置，也可以浏览首领击杀记录。DBM 会在你第一次使用时读取你的职业和专精并做出相应设置，但是有些设置需要手动开启。"

DBM_FORUMS_MESSAGE					= "发现BUG或错误的计时条?你希望要让某些模组有新的警告，计时器或是特别功能?\n拜访新的Deadly Boss Mods |HDBM:论坛|h|cff3588ffhttp://www.deadlybossmods.com|r (你可以点击链接复制网址)"
DBM_FORUMS_COPY_URL_DIALOG			= "拜访我们的讨论与支持论坛\r\n(hosted by Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "读取%s模块时发生错误：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功读取%s模块。在聊天框输入 /dbm 或 /dbm help 可进行更多设置。"
DBM_CORE_LOAD_MOD_COMBAT			= "延迟读取模块 '%s' 直到你脱离战斗。"
DBM_CORE_LOAD_GUI_ERROR				= "无法读取图形界面：%s"
DBM_CORE_LOAD_GUI_COMBAT			= "DBM无法在战斗中初始化图形界面。请先在非战斗状态打开图形设置界面，之后的战斗中就可以自由打开和关闭该界面了。"
DBM_CORE_LOAD_SKIN_COMBAT			= "DBM无法在战斗中更换皮肤。请先在非战斗状态更换好皮肤，并重载界面。"
DBM_CORE_BAD_LOAD					= "DBM检测到由于你在战斗过程中载入模块，有些计时器可能会错误。请在离开战斗后马上重载界面。"
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s 模块无法被载入。 DBM核心版本过旧。请升级DBM。"

DBM_CORE_BLIZZ_BUGS					= "6.1 禁用了用.wav 文件播放，所有的语音配置都被重置了一次。这个恢复到默认值只会发生一次，然后你可以再次重新设定自定义音效。记住，一旦你在某个配置文件下设定了自定义音效，你可以从模组状态窗口复制音效配置到另一个配置文件。"

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "由于玩家数量不足，DBM 无法开启动态距离检测。"
DBM_CORE_DYNAMIC_ADD_COUNT			= "由于玩家数量不足，DBM 无法开启倒计时。"
DBM_CORE_DYNAMIC_MULTIPLE			= "由于玩家数量不足，DBM 禁用了多个功能。"

DBM_CORE_LOOT_SPEC_REMINDER			= "你当前的人物专精为 %s。你当前的拾取选择为 %s。"

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM检测到你同时开启了Bigwigs,请关闭自动标记以避免冲突。"

DBM_CORE_PROVINGGROUNDS_AD			= "6.0 版本的 DBM-ProvingGrounds （白虎寺挑战模块） 已经上线了. 旧的模块 DBM-ProvingGrounds-MoP 已经被禁用. 你可以删除旧版本并且在 deadlybossmods.com 或 Curse 上找到新版本。本消息只显示一次。"

DBM_CORE_MOLTENCORE_AD				= "DBM-MC （熔火之心模块） 已经为100级40人随机模式适配。你可以在 deadlybossmods.com 上找到新版本。本消息只显示一次。"

DBM_CORE_COMBAT_STARTED				= "%s作战开始，祝你走运 :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "已进行的战斗-%s正在作战。祝你走运 :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "工会版%s作战开始"
DBM_CORE_SCENARIO_STARTED			= "场景战役-%s作战开始。祝你走运 :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "已进行的场景战役-%s正在作战。祝你走运 :)"
DBM_CORE_BOSS_DOWN					= "%s战斗胜利！用时%s！"
DBM_CORE_BOSS_DOWN_I				= "%s战斗胜利！总计%d次胜利。"
DBM_CORE_BOSS_DOWN_L				= "%s战斗胜利！用时%s！上次用时%s，最快用时%s。总计%d次胜利。"
DBM_CORE_BOSS_DOWN_NR				= "%s战斗胜利！用时%s！新的纪录诞生了！原纪录为%s。总计%d次胜利。"
DBM_CORE_GUILD_BOSS_DOWN			= "工会版%s战斗胜利！用时%s！"
DBM_CORE_SCENARIO_COMPLETE			= "场景战役-%s战斗胜利！用时%s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "场景战役-%s战斗胜利！总计%d次胜利。"
DBM_CORE_SCENARIO_COMPLETE_L		= "场景战役-%s战斗胜利！用时%s！上次用时%s，最快用时%s。总计%d次胜利。"
DBM_CORE_SCENARIO_COMPLETE_NR		= "场景战役-%s战斗胜利！用时%s！新的纪录诞生了！原纪录为%s。总计%d次胜利。"
DBM_CORE_COMBAT_ENDED_AT			= "%s （%s）作战结束，用时%s。"
DBM_CORE_COMBAT_ENDED_AT_LONG		= "%s （%s）作战结束，用时%s。该难度下总计失败%d次。"
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "工会版%s （%s）作战结束，用时%s。"
DBM_CORE_SCENARIO_ENDED_AT			= "场景战役-%s作战结束，用时%s。"
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "场景战役-%s作战结束，用时%s。该难度下总计失败%d次。"
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s作战%s前开始，正在恢复计时条……"
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Transcriptor logging started."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Transcriptor logging ended."

DBM_CORE_PROFILE_NOT_FOUND			= "<Deadly Boss Mods> 你当前的配置文件已损坏. 'Default' 默认配置文件会被应用."
DBM_CORE_PROFILE_CREATED			= "配置文件 '%s' 已经创建."
DBM_CORE_PROFILE_CREATE_ERROR		= "配置文件创建失败. 无效的配置文件名."
DBM_CORE_PROFILE_CREATE_ERROR_D		= "配置文件创建失败. '%s' 已经存在."
DBM_CORE_PROFILE_APPLIED			= "配置文件 '%s' 已经应用."
DBM_CORE_PROFILE_APPLY_ERROR		= "配置文件应用失败. '%s' 并不存在."
DBM_CORE_PROFILE_DELETED			= "配置文件 '%s' 已经删除. 'Default' 默认配置文件会被应用."
DBM_CORE_PROFILE_COPIED				= "配置文件 '%s' 已经复制."
DBM_CORE_PROFILE_COPY_ERROR			= "配置文件复制失败. '%s' 并不存在."
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "无法自己复制自己的配置文件."
DBM_CORE_PROFILE_DELETE_ERROR		= "配置文件删除失败. '%s' 并不存在."
DBM_CORE_PROFILE_CANNOT_DELETE		= "'Default' 默认配置文件无法被删除"
DBM_CORE_MPROFILE_COPY_SUCCESS		= "%s(%d专精)的模块设置已经被复制."
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "无法自己复制自己的配置文件"
DBM_CORE_MPROFILE_COPY_S_ERROR		= "复制的源出错. 源配置文件可能版本过旧或被篡改."
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "%s(%d专精)的模块声音设置已经被复制."
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "无法自己复制自己的声音配置文件"
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "复制的源出错. 源配置文件可能版本过旧或被篡改."
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "%s(%d专精)的模块设置已经被删除."
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "无法删除一个正在使用的模块配置文件."
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "删除的源出错. 源配置文件可能版本过旧或被篡改."

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "本副本里的所有Boss配置已经被初始化"
DBM_CORE_ALLMOD_STATS_RESETED		= "所有模组的状态已被重置"
DBM_CORE_MOD_DEFAULT_LOADED			= "将会使用默认设置来进行本场战斗"

DBM_CORE_WORLDBOSS_ENGAGED			= "世界Boss-%s可能正在作战。当前还有%s的生命值。 (由%s的DBM发送)"
DBM_CORE_WORLDBOSS_DEFEATED			= "世界Boss-%s可能战斗结束了。 (由%s的DBM发送)"

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分钟"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN						= "分"
DBM_CORE_MIN_FMT					= "%d分"
DBM_CORE_SEC						= "秒"
DBM_CORE_SEC_FMT					= "%s秒"
DBM_CORE_DEAD						= "死亡"
DBM_CORE_OK							= "确定"

DBM_CORE_GENERIC_WARNING_OTHERS		= "和另外一个"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "和另外%d个"
DBM_CORE_GENERIC_WARNING_BERSERK	= "%s%s后狂暴"
DBM_CORE_GENERIC_TIMER_BERSERK		= "狂暴"
DBM_CORE_OPTION_TIMER_BERSERK		= "计时条：$spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "战斗开始"
DBM_CORE_OPTION_TIMER_COMBAT		= "显示战斗开始倒计时"
DBM_CORE_OPTION_HEALTH_FRAME		= "首领生命值窗口"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "计时条"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "警报"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "个人警报"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "目标警报"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "角色警报"
DBM_CORE_OPTION_CATEGORY_MISC		= "其它"
DBM_CORE_OPTION_CATEGORY_SOUNDS		= "声音"

DBM_CORE_AUTO_RESPONDED						= "已自动回复."
DBM_CORE_STATUS_WHISPER						= "%s：%s，%d/%d存活"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s正在与%s交战，（当前%s，%d/%d存活）"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s已在%s的战斗中取得胜利！"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s已在%s的战斗中取得胜利！总计%d次胜利。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s在%s（%s）的战斗中灭团了。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s在%s（%s）的战斗中灭团了。该难度下总共失败%d次。"
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s正在与场景战役-%s交战，（当前%s，%d/%d存活）"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s已在场景战役-%s的战斗中取得胜利！"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s已在场景战役-%s的战斗中取得胜利！总计%d次胜利。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s在场景战役-%s的战斗中灭团了。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s在场景战役-%s的战斗中灭团了。该难度下总共失败%d次。"

DBM_CORE_VERSIONCHECK_HEADER		= "DBM - 版本检测"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d) %s"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) & %s (r%d)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：未安装DBM"
DBM_CORE_VERSIONCHECK_FOOTER		= "团队中有%d名成员正在使用DBM， %d名成员正在使用Bigwigs"
DBM_CORE_VERSIONCHECK_OUTDATED		= "下列%d名玩家的DBM版本已经过期:%s"
DBM_CORE_YOUR_VERSION_OUTDATED		= "你的DBM已经过期。请访问 http://dev.deadlybossmods.com 下载最新版本。"
DBM_CORE_VOICE_PACK_OUTDATED		= "你当前使用的DBM语音包已经过期。有些特殊警告的屏蔽（当心，毁灭）已被禁用。请下载最新语音包，或联系语音包作者更新。"
DBM_CORE_VOICE_MISSING				= "DBM找不到你当前选择的语音包。语音包选项已经被设置成'None'。请确保你的语音包被正确安装和启用。"
DBM_CORE_VOICE_COUNT_MISSING		= "在 %d 语音包中找不到倒计时语音。倒计时已恢复为默认值"

DBM_CORE_UPDATEREMINDER_HEADER			= "你的DBM版本已过期。\n你可以在如下地址下载到新版本%s（r%d）："
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "你的DBM Alpha 版本已过期了%d个版本。这可能导致你或其他团队成员出错。"
DBM_CORE_UPDATEREMINDER_FOOTER			= "按下 " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "复制下载地址到剪切板。"
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "按下 " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "复制链接到剪切板。"
DBM_CORE_UPDATEREMINDER_DISABLE			= "警告：你的DBM已经过期了%d个版本，它已被禁用，直到你更新。这是为了确保它不会导致你或其他团队成员出错。"
DBM_CORE_UPDATEREMINDER_HOTFIX			= "你的DBM版本会在这首领战斗有不准确的计时器或警告。这问题会在下次正式版更新。你也可以更新至最新的alpha版本立即修正此问题。"
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= DBM_CORE_UPDATEREMINDER_HOTFIX--TEMP, FIX ME!
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "你的DBM已经过期,它已被禁用,直到你更新.这是为了确保它不会导致你或其他团队成员出错.这次更新是一个非常重要的补丁,请确保你得到的是最新版."
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "警告：你使用了不正确版本的DBM。请确保DBM版本和游戏版本一致。"
DBM_CORE_VEM							= "你好像在使用VEM。DBM在这种情况下无法被载入。"
DBM_CORE_3RDPROFILES					= "警告: DBM-Profiles已经无法和本版本DBM兼容。DBM核心已经自带配置文件管理系统，请移除DBM-Profiles避免冲突。"
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "警告: 如果你不完全重启游戏，DBM可能会工作不正常。此次更新包含了新的文件，或者toc文件的改变，这是重载界面无法加载的。不重启游戏可能导致作战模块功能错误。"


DBM_CORE_MOVABLE_BAR				= "拖动我！"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h向你发送了一个DBM计时条：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消该计时]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略来自%1$s的计时条]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在该次游戏连接中屏蔽来自%s的计时条？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <时间（秒）> <文本>"

--DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+拖动 / 右键拖动：拖动\nAlt+Shift+拖动：自由拖动"

DBM_CORE_RANGECHECK_HEADER			= "距离监视（%d码）"
DBM_CORE_RANGECHECK_SETRANGE		= "设置距离"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "设置玩家数量阈值"
DBM_CORE_RANGECHECK_SOUNDS			= "音效"
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
DBM_CORE_RANGECHECK_OPTION_BOTH		= "同时显示雷达和文本框体"
DBM_CORE_RANGERADAR_HEADER			= "距离%d码 玩家%d人"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d人在监视距离内（%d码）"
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1f码)"--One target


DBM_CORE_INFOFRAME_SHOW_SELF		= "总是显示你的能量"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "随机副本确认"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/range <number> 或者 /distance <number>: 显示距离雷达窗体. 使用 /rrange 或者 /rdistance 翻转颜色.",
	"/dbm version:进行团队范围的DBM版本检测（也可使用：ver）",
	"/dbm unlock:显示一个可移动的计时条，可通过对它来移动所有DBM计时条的位置（也可使用：move）",
	"/dbm timer/ctimer/ltimer/cltimer <x> <text>: 启动一个 <x> 秒的计时器。文本内容为 <text>.",
	"/dbm broadcast timer <x> <文本>:向团队广播一个以<文本>为名称的时间为<x>秒的倒计时(需要队长或助理权限)。",
	"/dbm timer endloop: 停止所有的 ltimer 和 cltimer.",
	"/dbm break <分钟>: 开始一个<分钟>时间的休息计时条。并向所有团队成员发送这个DBM休息计时条(需要队长或助理权限)。",
	"/dbm pull <秒>: 开始一个<秒>时间的开怪计时条。 并向所有团队成员发送这个DBM开怪计时条(需要队长或助理权限)。",
	"/dbm arrow: 显示DBM箭头，输入'/dbm arrow'查询更多信息。",
	"/dbm lockout: 查询团队成员当前的副本锁定状态(副本CD)(也可使用：lockouts, ids)(需要队长或助理权限)。",
	"/dbm lag: 检测全团网络延时",
	"/dbm hud: 显示DBM hud，输入'/dbm hud'查询更多信息。"
}

DBM_ERROR_NO_PERMISSION				= "你无权进行该操作。(需要队长或助理权限?)"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "隐藏生命值框体"

DBM_CORE_UNKNOWN					= "未知"
DBM_CORE_LEFT						= "左"
DBM_CORE_RIGHT						= "右"
DBM_CORE_BACK						= "后"
DBM_CORE_FRONT						= "前"
DBM_CORE_INTERMISSION				= "中场时间"

DBM_CORE_BREAK_START				= "开始休息 - %s分钟！（由 %s 发送）"
DBM_CORE_BREAK_MIN					= "%s分钟后休息结束！"
DBM_CORE_BREAK_SEC					= "%s秒后休息结束！"
DBM_CORE_TIMER_BREAK				= "休息时间！"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息已结束"

DBM_CORE_TIMER_PULL					= "开怪倒计时"
DBM_CORE_ANNOUNCE_PULL				= "%d秒后开怪 （由 %s 发送）"
DBM_CORE_ANNOUNCE_PULL_NOW			= "开怪！"
DBM_CORE_GEAR_WARNING				= "警告：请检查你的装备。你当前的装备装等比背包装等低了 %d 点"
DBM_CORE_GEAR_WARNING_WEAPON		= "警告：请检查你的武器并确保已被正确装备"
DBM_CORE_GEAR_FISHING_POLE			= "钓鱼竿"



DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "成就：限时击杀"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target				= "%s -> >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount		= "%s (%%s) -> >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell				= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends 				= "%s 结束"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades				= "%s 消失"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds				= "%s剩余：%%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast				= "正在施放 %s：%.1f秒"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon				= "即将 %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn			= "%2$s后 %1$s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase				= "第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase			= "第%s阶段 即将到来"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count				= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack				= "%s -> >%%s< (%%d)"

local prewarnOption			= "预警：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target			= "警报：$spell:%s的目标"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount		= "警报：$spell:%s的目标"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell			= "警报：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends				= "警报：$spell:%s结束"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget		= "警报：$spell:%s结束"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades			= "警报：$spell:%s消失"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds				= "警报：$spell:%s剩余数量"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast				= "警报：$spell:%s的施放"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon				= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase			= "警报：第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phasechange		= "警报：阶段转换"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase			= "预警：第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count			= "警报：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack			= "警报：$spell:%s叠加层数"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends				= "%s 结束"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s 消失"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "%s 即将到来"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s 于 %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel			= ">%%s<中了%s - 快驱散"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - 快打断"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - 快打断 (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you				= "你中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target			= ">%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= ">%%s<中了%s - 快嘲讽"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close				= "你附近的>%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move				= "%s - 快躲开"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge				= "%s - 躲开攻击"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - 离开人群"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - 靠近 >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run				= "%s - 快跑"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast				= "%s - 停止施法"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect			= ">%%s<中了%s - 快停手"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count				= "%s! (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack				= "你叠加了%%d层%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch			= ">%s< - 转换目标"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount		= ">%s< - 转换目标 (%%d)"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell			= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends			= "特殊警报：$spell:%s结束"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades			= "特殊警报：$spell:%s消失"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon			= "特殊警报：$spell:%s即将到来"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 		= "特殊警报：%s秒前预警$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel			= "特殊警报：需要驱散或偷取$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 		= "特殊警报：$spell:%s需要停止攻击"--Spell Reflect
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt		= "特殊警报：需要打断$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you				= "特殊警报：当你受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target			= "特殊警报：当他人受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 			= "特殊警报：当另外一个T中了$spell:%s并需要你嘲讽时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close			= "特殊警报：当你附近有人受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move			= "特殊警报：当你受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge			= "特殊警报：当你受到$spell:%s影响并需要躲开攻击"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway		= "特殊警报：当你受到$spell:%s影响并需要跑开人群时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto			= "特殊警报：当他人中了$spell:%s并需要你去靠近时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run				= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast			= "特殊警报：$spell:%s的施放（用于打断）"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 			= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack			= "特殊警报：当叠加了>=%d层$spell:%s时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch 			= "特殊警报：针对$spell:%s需要转换目标"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount		= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target				= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast					= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active				= "%s结束"--Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades					= "%s消失"--Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd					= "%s冷却"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount				= "%s冷却（%%d）"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource				= "%s冷却: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial				= "特殊技能冷却"
DBM_CORE_AUTO_TIMER_TEXTS.next 					= "下一次%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount				= "下一次%s（%%d）"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource			= "下一次%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial			= "下一次特殊技能"
DBM_CORE_AUTO_TIMER_TEXTS.achievement 			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.phase					= "下一阶段"

DBM_CORE_AUTO_TIMER_OPTIONS.target				= "计时条：$spell:%s减益效果持续时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cast				= "计时条：$spell:%s施法时间"
DBM_CORE_AUTO_TIMER_OPTIONS.active				= "计时条：$spell:%s效果持续时间"
DBM_CORE_AUTO_TIMER_OPTIONS.fades				= "计时条：$spell:%s何时从玩家身上消失"
DBM_CORE_AUTO_TIMER_OPTIONS.cd					= "计时条：$spell:%s冷却时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount				= "计时条：$spell:%s冷却时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource			= "计时条：$spell:%s冷却时间以及来源"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial			= "计时条：特殊技能冷却"
DBM_CORE_AUTO_TIMER_OPTIONS.next				= "计时条：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount			= "计时条：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource			= "计时条：下一次$spell:%s以及来源"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial			= "计时条：下一次特殊技能"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement			= "计时条：成就%s"
DBM_CORE_AUTO_TIMER_OPTIONS.phase				= "计时条：下一阶段"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay			= "计时条：剧情"

DBM_CORE_AUTO_ICONS_OPTION_TEXT				= "为$spell:%s的目标添加团队标记"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2			= "为$spell:%s添加团队标记"
DBM_CORE_AUTO_ARROW_OPTION_TEXT				= "为$spell:%s的目标添加箭头"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2			= "为$spell:%s的目标添加远离箭头"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3			= "为$spell:%s的目标添加前往指定位置的箭头"
DBM_CORE_AUTO_SOUND_OPTION_TEXT				= "为技能$spell:%s提供内置语音警报（快跑啊，小姑娘）"
DBM_CORE_AUTO_VOICE_OPTION_TEXT				= "为技能$spell:%s提供语音包警报"
DBM_CORE_AUTO_VOICE2_OPTION_TEXT			= "为阶段转换提供语音包警报"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT			= "倒计时：$spell:%s的冷却时间倒计时"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2		= "倒计时：$spell:%s消失时"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT			= "倒计时：$spell:%s的持续时间正计时"
DBM_CORE_AUTO_YELL_OPTION_TEXT				= "当你受到$spell:%s影响时大喊"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell		= UnitName("player") .. " 中了 %s!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.count		= UnitName("player") .. " 中了 %s! (%%d)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.fade		= "%s 于%%d秒后消失"
DBM_CORE_AUTO_HUD_OPTION_TEXT				= "为$spell:%s显示HudMap"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI			= "为多个机制显示HudMap"
DBM_CORE_AUTO_RANGE_OPTION_TEXT				= "距离监视(%s码)：$spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT		= "距离监视(%s码)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_RRANGE_OPTION_TEXT			= "反转距离监视(%s码)：$spell:%s"--Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT		= "反转距离监视(%s码)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT		= "信息框：$spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT		= "当首领开打时播放准备检查的音效（即使没有选定目标）"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR				= "可拖动的团队警报"
DBM_CORE_MOVE_WARNING_MESSAGE			= "感谢您使用Deadly Boss Mods"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR		= "可拖动的特别警报"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT		= "特别警报"

DBM_CORE_HUD_INVALID_TYPE				= "无效的HUD类型"
DBM_CORE_HUD_INVALID_TARGET				= "没有给定HUD目标"
DBM_CORE_HUD_INVALID_SELF				= "不能把自己设定成HUD目标"
DBM_CORE_HUD_INVALID_ICON				= "当使用团队标记作为HUD目标定义时，不能定义一个没有团队标记的目标"
DBM_CORE_HUD_USAGE	= {
	"DBM-HudMap 可用命令：",
	"/dbm hud <类型> <目标> <持续时间>  新建一个指向玩家的HUD指示器",
	"变量-类型: red, blue, green, yellow, icon (请输入英语。如果类型是团队标记需要给目标标记团队标记)",
	"变量-目标: target, focus, <玩家名字> (请输入英语。如果是玩家名字请区分大小写)",
	"变量-持续时间: 秒数. 如果这个参数留空, 默认为20分钟",
	"/dbm hud hide  清空并关闭HUD"
}

DBM_ARROW_MOVABLE				= "可移动箭头"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 可用命令：",
	"/dbm arrow <x> <y>  新建一个箭头到指定位置(使用世界坐标系)",
	"/dbm arrow map <x> <y>  新建一个箭头到指定位置 (使用区域地图坐标系)",
	"/dbm arrow <玩家名字>  新建一个箭头并指向你队伍或团队中特定的玩家。请区分大小写。",
	"/dbm arrow hide  隐藏箭头",
	"/dbm arrow move  移动或锁定箭头"
}

DBM_SPEED_KILL_TIMER_TEXT	= "击杀记录"
DBM_SPEED_KILL_TIMER_OPTION	= "计时条：最速击杀记录"
DBM_SPEED_CLEAR_TIMER_TEXT	= "最速清除"
DBM_COMBAT_RES_TIMER_TEXT	= "下一次战复CD"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s请求获取你现在副本的存档ID与进度。是否愿意向&s提交进度？\n\n注意：在接受后，他可以随时查看您当前的进度情况，直到您下线、掉线或重载用户界面。"
DBM_ERROR_NO_RAID					= "使用该功能需要身处一个团队中。"
DBM_INSTANCE_INFO_REQUESTED			= "已发送团队副本进度查看请求。\n请注意，团员会根据需要选择接受或拒绝该请求。请求时间约一分钟，请等待。"
DBM_INSTANCE_INFO_STATUS_UPDATE		= "已收到%d名团员的进度回复（已安装DBM的团员有%d名）：%d人接受请求，%d人拒绝。生成数据需要约%d秒，请等待。"
DBM_INSTANCE_INFO_ALL_RESPONSES		= "所有团员接受请求。"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "发送者：%s 结果类型：%s 副本名：%s 副本ID：%s 难度：%d 规模：%d 进度：%s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s，难度%s："
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, 进度%d：%s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    进度%d：%s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "你的团队没有副本进度信息。"
DBM_INSTANCE_INFO_STATS_DENIED		= "拒绝请求：%s"
DBM_INSTANCE_INFO_STATS_AWAY		= "暂离：%s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "未安装DBM：%s"
DBM_INSTANCE_INFO_RESULTS			= "副本进度扫描结果。" --Note that instances might show up more than once if there are players with localized WoW clients in your raid.
DBM_INSTANCE_INFO_SHOW_RESULTS		= "回复请求的玩家：%s\n|HDBM:showRaidIdResults|h|cff3588ff[点击显示结果]|r|h"

DBM_CORE_LAG_CHECKING				= "延时检测请稍后..."
DBM_CORE_LAG_HEADER					= "DBM - 延时检测"
DBM_CORE_LAG_ENTRY					= "%s：世界延时[%d毫秒] / 本地延时[%d毫秒]"
DBM_CORE_LAG_FOOTER					= "未反馈此次检测的团员:%s"