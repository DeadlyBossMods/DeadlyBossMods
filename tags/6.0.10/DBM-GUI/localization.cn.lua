-- Diablohu(diablohudream@gmail.com) 
-- yleaf(yaroot@gmail.com)
-- sunlcy@NGA
-- Mini_Dragon(projecteurs@gmail.com)
-- Last update: Dec 27, 2014@12186

if GetLocale() ~= "zhCN" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end

local L = DBM_GUI_Translations

L.MainFrame 				= "Deadly Boss Mods"

L.TranslationByPrefix		= "本地化："
L.TranslationBy 			= "Mini_Dragon(Brilla@金色平原) 原翻译：Diablohu & yleaf & sunlcy"
L.Website					= "拜访我们的论坛（英文） |cFF73C2FBwww.deadlybossmods.com|r (托管于 Elitist Jerks!)，或在Twitter上关注首席程序员 @MysticalOS"
L.WebsiteButton				= "论坛"

L.OTabBosses				= "模块"
L.OTabOptions				= "选项"

L.TabCategory_Options 		= "综合设置"
L.TabCategory_WOD	 		= "德拉诺之王"
L.TabCategory_MOP	 		= "熊猫人之谜"
L.TabCategory_CATA	 		= "大地的裂变"
L.TabCategory_WOTLK 		= "巫妖王之怒"
L.TabCategory_BC 			= "燃烧的远征"
L.TabCategory_CLASSIC 		= "经典旧世"
L.TabCategory_OTHER    		= "其它"

L.BossModLoaded 			= "%s状态"
L.BossModLoad_now 			= [[该模块尚未启动。
当你进入相应副本时其会自动加载。
你也可以点击该按钮手动启动该模块。]]

L.PosX 						= 'X坐标'
L.PosY 						= 'Y坐标'

L.MoveMe					= '移动'
L.Button_OK 				= '确定'
L.Button_Cancel 			= '取消'
L.Button_LoadMod 			= '加载插件'
L.Mod_Enabled				= "开启模块"
L.Mod_Reset					= "恢复默认设置"
L.Reset 					= "重置"

L.Enable  					= "开启"
L.Disable					= "关闭"
L.NoSound					= "静音"

L.IconsInUse				= "该模块使用到的团队标记"

-- Tab: Boss Statistics
L.BossStatistics			= "首领统计"
L.Statistic_Kills			= "击杀:"
L.Statistic_Wipes			= "失败:"
L.Statistic_Incompletes		= "未完成:"
L.Statistic_BestKill		= "最好成绩:"

-- Tab: General Options
L.General 					= "DBM综合设置"
L.EnableDBM 				= "启用DBM"
L.EnableMiniMapIcon			= "显示小地图图标"
L.UseMasterVolume			= "使用游戏总声道播放音频"
L.Latency_Text				= "设定启用同步功能的最高延迟阈值：%d"
-- Tab: General Timer Options
L.TimerGeneral 				= "DBM计时条综合设置"
L.SKT_Enabled				= "总是显示最速胜利计时条(覆盖首领特定的选项)"
L.CRT_Enabled				= "显示下一次可战复CD (限德拉诺团队本)"
L.ChallengeTimerOptions			= "设置挑战模式最佳记录计时条"
L.ChallengeTimerPersonal		= "个人"
L.ChallengeTimerGuild			= "公会"
L.ChallengeTimerRealm			= "服务器"

L.DisableCinematics			= "在副本时自动跳过游戏内过场动画"
L.DisableCinematicsOutside		= "在副本外时自动跳过游戏内过场动画"
L.SKT_Enabled				= "永远显示最速击杀计时条（无论该首领的相关设置如何）"
L.Latency_Text				= "设定启用同步功能的最高延迟阀值：%d"

L.ModelOptions				= "3D模型选项"
L.EnableModels				= "在首领选项中启用3D模型"
L.ModelSoundOptions			= "为模型查看器设置声音选项"
L.ModelSoundShort			= "短"
L.ModelSoundLong			= "长"

L.Button_RangeFrame			= "显示/隐藏距离监视信息框体"
L.Button_RangeRadar			= "显示/隐藏距离监视雷达"
L.Button_InfoFrame			= "显示/隐藏信息框体"
L.Button_TestBars			= "测试计时条"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "团队警报"
L.RaidWarning_Header			= "团队警报设置"
L.RaidWarnColors 			= "团队警报颜色"
L.RaidWarnColor_1 			= "颜色1"
L.RaidWarnColor_2 			= "颜色2"
L.RaidWarnColor_3 			= "颜色3"
L.RaidWarnColor_4 			= "颜色4"
L.InfoRaidWarning			= [[你可以对团队警报的文本颜色及其位置进行设定。
在这里会显示诸如“玩家X受到了Y效果的影响”之类的信息。]]
L.ColorResetted 			= "该颜色设置已重置"
L.ShowWarningsInChat 		= "在聊天窗口中显示警报"
L.ShowSWarningsInChat 		= "在聊天窗口中显示特殊警报"
L.ShowFakedRaidWarnings 	= "以伪装团队警报信息的方式显示警报内容"
L.WarningIconLeft 			= "左侧显示图标"
L.WarningIconRight 			= "右侧显示图标"
L.WarningIconChat 			= "在聊天窗口中显示图标"
L.ShowCountdownText			= "为第一倒计时显示文本"
L.RaidWarnMessage 			= "感谢您使用Deadly Boss Mods"
L.BarWhileMove 				= "可移动团队警报"
L.RaidWarnSound				= "发出团队警报时播放声音"
L.CountdownVoice			= "设置第一倒计时语音"
L.CountdownVoice2			= "设置第二倒计时语音"
L.CountdownVoice3			= "设置第三倒计时语音"
L.VoicePackChoice			= "设置语音报警的语音包(快躲开！)"
L.SpecialWarnSound			= "针对你发出特殊警报时播放的声音"
L.SpecialWarnSound2			= "针对所有人发出特殊警报时播放的声音(默认:当心)"
L.SpecialWarnSound3			= "针对非常重要事件(灭团点)的特殊警报播放的声音(默认:毁灭)"

-- Tab: Generalwarnings
L.Tab_GeneralMessages	 		= "综合信息"
L.CoreMessages				= "核心信息设置"
L.ShowLoadMessage 			= "在聊天窗口中显示模块载入信息"
L.ShowPizzaMessage 			= "在聊天窗口中显示计时条广播信息"
L.ShowCombatLogMessage 			= "在聊天窗口中显示DBM战斗记录"
L.ShowTranscriptorMessage		= "在聊天窗口中显示DBM Transcriptor 记录"
L.CombatMessages			= "战斗信息设置"
L.ShowEngageMessage 			= "在聊天窗口中显示开战信息"
L.ShowKillMessage 			= "在聊天窗口中显示击杀信息"
L.ShowWipeMessage 			= "在聊天窗口中显示灭团信息"
L.ShowGuildMessages 			= "在聊天窗口中显示工会开战，击杀，灭团信息"
L.ShowRecoveryMessage 			= "在聊天窗口中显示计时条恢复信息"
L.WhisperMessages			= "密语信息设置"
L.AutoRespond 				= "在战斗中自动回复他人密语"
L.EnableStatus 				= "回复“status”密语"
L.WhisperStats 				= "在回复的密语中包含击杀或灭团次数统计信息"

-- Tab: Barsetup
L.BarSetup   				= "计时条设置"
L.BarTexture 				= "计时条材质"
L.BarStyle				= "计时条样式"
L.BarDBM				= "DBM"
L.BarBigWigs				= "BigWigs (没动画)"
L.BarStartColor				= "初始颜色"
L.BarEndColor 				= "结束颜色"
L.ExpandUpwards				= "向上扩展"
L.Bar_Font				= "计时条字体"
L.Bar_FontSize				= "字体大小"
L.Bar_Height				= "计时条高度: %d"
L.Slider_BarOffSetX 			= "X偏移"
L.Slider_BarOffSetY 			= "Y偏移"
L.Slider_BarWidth 			= "宽度"
L.Slider_BarScale 			= "缩放"
L.AreaTitle_BarSetup 			= "计时条综合设置"
L.AreaTitle_BarSetupSmall 		= "小型计时条设置"
L.AreaTitle_BarSetupHuge 		= "大型计时条设置"
L.EnableHugeBar 			= "开启大型计时条（2号计时条）"
L.BarIconLeft 				= "左侧图标"
L.BarIconRight 				= "右侧图标"
L.ExpandUpwards				= "计时条向上伸展" --感谢飘去的梦， 木沐的小胖狼@NGA
L.FillUpBars				= "填充计时条"
L.ClickThrough				= "禁用鼠标点击事件（允许你点击计时条后面的目标）"
L.Bar_DBMOnly				= "以下设置只对 \"DBM\" 计时条有效."
L.Bar_EnlargeTime			= "在%d后计时条变大"
L.Bar_EnlargePercent			= "在%0.1f%%后计时条变大"
L.BarSpark				= "计时条闪光"
L.BarFlash				= "当计时条快走完时闪动"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame			= "特殊警报"
L.Area_SpecWarn				= "特殊警报设置"
L.SpecWarn_Enabled			= "显示首领技能特殊警报"
L.SpecWarn_FlashFrame			= "特殊警报时屏幕边缘泛光"
L.SpecWarn_ShakeFrame			= "为毁灭性的技能闪烁屏幕"
L.SpecWarn_AdSound			= "启用特别警告高级声音选项（需要UI重载）"
L.SpecWarn_NoSoundsWVoice	= "当技能存在语音包语音时，屏蔽播放特殊警报声（当心，毁灭）"
L.SpecWarn_Font				= "特殊警报字体"
L.SpecWarn_DemoButton			= "测试警报"
L.SpecWarn_MoveMe			= "设置位置"
L.SpecWarn_FontSize			= "字体大小"
L.SpecWarn_FontColor			= "字体颜色"
L.SpecWarn_FontType			= "选择字体"
L.SpecWarn_FlashColor			= "泛光顏色 (%d)"
L.SpecWarn_FlashDur			= "泛光持续时间: %0.1f"
L.SpecWarn_FlashAlpha			= "泛光透明度: %0.1f"
L.SpecWarn_ResetMe			= "重置"

L.Panel_LTSpecWarnFrame			= "长效特殊警报"
L.Area_LTSpecWarn			= "长效特殊警报设置"
L.LTSpecWarn_Enabled			= "显示长效特殊警报"
L.LTSpecWarn_Font			= "长效特殊警报字体"
L.TestWarningEnd			= "范例只存在五秒，但真实的长效特别警告会长时间的存在於你的屏幕上直到触发取消事件"

-- Tab: HealthFrame
L.Panel_HPFrame				= "生命值框体"
L.Area_HPFrame				= "生命值框体选项"
L.HP_Enabled				= "总是显示生命值框体（无论该首领的相关设置如何）"
L.HP_GrowUpwards			= "向上扩展"
L.HP_ShowDemo				= "显示框体"
L.BarWidth				= "计量条宽度: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter			= "全局及信息过滤"
L.StripServerName			= "警告和计时器中不显示服务器名"
L.Area_SpamFilter			= "信息过滤设置"
L.HideBossEmoteFrame			= "隐藏团队首领表情框体"
L.SpamBlockBossWhispers			= "战斗中过滤DBM密语警报"
L.BlockVersionUpdateNotice		= "禁用升级提示"
L.ShowBBOnCombatStart			= "战斗开始时使用Big Brother检测增益情况"
L.BigBrotherAnnounceToRaid		= "报告Big Brother的检测结果给团队"
L.SpamBlockSayYell			= "隐藏聊天窗口中的使用聊天泡泡的警报信息"

L.Area_SpecFilter			= "专精过滤选项"
L.FilterTankSpec			= "当非坦克专精时，过滤掉给予坦克的专用信息"

-- Tab: Global Filter
L.Area_SpamFilter_Outgoing		= "全局过滤设置"
L.SpamBlockNoShowAnnounce		= "不显示警报或播放警报音效"
L.DontShowFarWarnings			= "不显示过远事件的通告和计时器"
L.SpamBlockNoRunAway			= "不要播放'快跑啊，小姑娘'"
L.SpamBlockNoSendWhisper		= "不发送悄悄话提示给其他玩家"
L.SpamBlockNoSetIcon			= "不设定标记在目标上"
L.SpamBlockNoRangeFrame			= "不显示距离监视器"
L.SpamBlockNoInfoFrame			= "不显示信息监视器"
L.SpamBlockNoHealthFrame		= "不显示生命值监视器"

-- Tab: Spam Filter
L.Area_PullTimer			= "开怪倒计时过滤设置"
L.DontShowPT				= "不显示开怪倒计时条"
L.DontShowPTCountdownText		= "不显示开怪倒计时动画"
L.DontPlayPTCountdown			= "不播放开怪倒计时语音"
L.DontShowPTText			= "不显示开怪倒计时文字"
L.DontShowPTNoID			= "不显示不同区域发送的倒计时"
L.PT_Threshold				= "不显示高于%d秒的倒计时动画"

L.Panel_HideBlizzard			= "隐藏暴雪框架"
L.Area_HideBlizzard			= "隐藏暴雪框架选项"
L.HideBossEmoteFrame			= "首领战中隐藏团队首领表情框体"
L.HideWatchFrame			= "首领战中隐藏任务追踪框体"
L.HideGarrisonUpdates		= "首领战中隐藏要塞队列完成提示"
L.HideTooltips				= "首领战中隐藏鼠标提示窗体 （tooltips）"
L.HideApplicantAlerts		= "屏蔽预创建队伍邀请信息"
L.HideApplicantAlertsFull	= "当团队已满时"
L.HideApplicantAlertsNotL	= "当我不是团长时 （团长别选）"
L.SpamBlockSayYell			= "隐藏聊天窗口中的使用聊天泡泡的警报信息"
L.DisableCinematics			= "自动跳过游戏内过场动画"
L.AfterFirst				= "仅第一次播放"
L.Always				= "总是跳过"

L.Panel_ExtraFeatures			= "其他功能"
L.Area_ChatAlerts			= "聊天警告选项"
L.RoleSpecAlert				= "当进入团队时，如果拾取专精与当前角色专精不同，则显示警告。"
L.WorldBossAlert			= "当世界BOSS进入战斗后发送警告，这个信息可能是你的朋友或者同工会成员发送的。 (由于跨服，卡位面等因素，可能不准确)"
L.Area_SoundAlerts			= "语音警告选项"
L.LFDEnhance				= "当发起角色检查时，播放准备音效"
L.WorldBossNearAlert			= "当世界附近的BOSS进入战斗时发出特殊音效 (全局设置，覆盖单独BOSS设置)"
L.AFKHealthWarning			= "当你在挂机/暂离而受到伤害时发出警报"
L.Area_AutoLogging			= "自动日志记录选项"
L.AutologBosses				= "自动采用官方格式记录日志。 (使用 /dbm pull 可提前记录并使得记录更准确，如提前偷药水或是召唤大军。)"
L.AdvancedAutologBosses			= "自动采用 Transcriptor 记录日志"
L.LogOnlyRaidBosses			= "只记录团队BOSS，而不记录随机团队，5人本，场景战役。"
L.Area_Invite				= "组队邀请选项"
L.AutoAcceptFriendInvite		= "自动接受来自好友列表里的好友的组队邀请"
L.AutoAcceptGuildInvite			= "自动接受同工会成员的组队邀请"

L.PizzaTimer_Headline 			= '创造一个自定义计时器'
L.PizzaTimer_Title			= '名字 (如 “泡面倒计时”)'
L.PizzaTimer_Hours 			= "小时"
L.PizzaTimer_Mins 			= "分钟"
L.PizzaTimer_Secs 			= "秒"
L.PizzaTimer_ButtonStart	 	= "开始计时"
L.PizzaTimer_BroadCast			= "向全团广播"

-- Misc
L.FontHeight	= 20
