-- Simplified Chinese by Diablohu(diablohudream@gmail.com) & yleaf(yaroot@gmail.com)
-- Last update: 2/4/2013

if GetLocale() ~= "zhCN" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end

local L = DBM_GUI_Translations

L.MainFrame 				= "Deadly Boss Mods"

L.TranslationBy 			= "Diablohu & yleaf"

L.OTabBosses				= "模块"
L.OTabOptions				= "选项"

L.TabCategory_Options 		= "综合设置"
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

L.MoveMe 					= '移动'
L.Button_OK 				= '确定'
L.Button_Cancel 			= '取消'
L.Button_LoadMod 			= '加载插件'
L.Mod_Enabled				= "开启模块"
L.Mod_EnableAnnounce		= "团队广播（需要领袖权限）"
L.Reset 					= "重置"

L.Enable  					= "开启"
L.Disable					= "关闭"

L.NoSound					= "静音"

L.IconsInUse				= "该模块使用到的团队标记"

-- Tab: Boss Statistics
L.BossStatistics			= "首领统计"
L.Statistic_Kills			= "击杀："
L.Statistic_Wipes			= "失败："
L.Statistic_BestKill		= "最好成绩："
L.Statistic_Heroic			= "英雄模式"
L.Statistic_10Man			= "10人"
L.Statistic_25Man			= "25人"

-- Tab: General Options
L.General 					= "DBM综合设置"
L.EnableDBM 				= "启用DBM"
L.EnableMiniMapIcon			= "显示小地图图标"
L.UseMasterVolume			= "使用游戏总声道播放音频"
L.DisableCinematics			= "在副本时自动跳过游戏内过场动画"
L.DisableCinematicsOutside	= "在副本外时自动跳过游戏内过场动画"
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

L.PizzaTimer_Headline 		= '创建一个计时条'
L.PizzaTimer_Title			= '名称（如“泡面倒计时”）'
L.PizzaTimer_Hours 			= "小时"
L.PizzaTimer_Mins 			= "分钟"
L.PizzaTimer_Secs 			= "秒"
L.PizzaTimer_ButtonStart	= "开始计时"
L.PizzaTimer_BroadCast		= "向团队广播"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "团队警报"
L.RaidWarning_Header		= "团队警报设置"
L.RaidWarnColors 			= "团队警报颜色"
L.RaidWarnColor_1 			= "颜色1"
L.RaidWarnColor_2 			= "颜色2"
L.RaidWarnColor_3 			= "颜色3"
L.RaidWarnColor_4 			= "颜色4"
L.InfoRaidWarning			= [[你可以对团队警报的文本颜色及其位置进行设定。
在这里会显示诸如“玩家X受到了Y效果的影响”之类的信息。]]
L.ColorResetted 			= "该颜色设置已重置"
L.ShowWarningsInChat 		= "在聊天窗口中显示警报"
L.ShowFakedRaidWarnings 	= "以伪装团队警报信息的方式显示警报内容"
L.WarningIconLeft 			= "左侧显示图标"
L.WarningIconRight 			= "右侧显示图标"
L.RaidWarnMessage 			= "感谢您使用Deadly Boss Mods"
L.BarWhileMove 				= "可移动团队警报"
L.RaidWarnSound				= "发出团队警报时播放声音"
L.CountdownVoice			= "倒数时播放语音"
L.SpecialWarnSound			= "针对你或你的角色发出特殊警报时播放声音"
L.SpecialWarnSound2			= "针对所有人发出特殊警报时播放声音"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "综合信息"
L.CoreMessages				= "核心信息设置"
L.ShowLoadMessage 			= "在聊天窗口中显示模块载入信息"
L.ShowPizzaMessage 			= "在聊天窗口中显示计时条广播信息"
L.CombatMessages			= "战斗信息设置"
L.ShowEngageMessage 		= "在聊天窗口中显示开战信息"
L.ShowKillMessage 			= "在聊天窗口中显示击杀信息"
L.ShowWipeMessage 			= "在聊天窗口中显示灭团信息"
L.ShowRecoveryMessage 		= "在聊天窗口中显示计时条恢复信息"
L.WhisperMessages			= "密语信息设置"
L.AutoRespond 				= "在战斗中自动回复他人密语"
L.EnableStatus 				= "恢复“status”密语"
L.WhisperStats 				= "在回复的密语中包含击杀或灭团次数统计信息"

-- Tab: Barsetup
L.BarSetup   				= "计时条样式"
L.BarTexture 				= "计时条材质"
L.BarStartColor				= "初始颜色"
L.BarEndColor 				= "结束颜色"
L.ExpandUpwards				= "向上扩展"
L.Bar_Font					= "计时条字体"
L.Bar_FontSize				= "字体大小"
L.Slider_BarOffSetX 		= "X偏移"
L.Slider_BarOffSetY 		= "Y偏移"
L.Slider_BarWidth 			= "宽度"
L.Slider_BarScale 			= "缩放"
L.AreaTitle_BarSetup 		= "计时条综合设置"
L.AreaTitle_BarSetupSmall 	= "小型计时条设置"
L.AreaTitle_BarSetupHuge 	= "大型计时条设置"
L.BarIconLeft 				= "左侧图标"
L.BarIconRight 				= "右侧图标"
L.EnableHugeBar 			= "开启大型计时条（2号计时条）"
L.FillUpBars				= "填充计时条"
L.ClickThrough				= "禁用鼠标点击事件（允许你点击计时条后面的目标）"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "特殊警报"
L.Area_SpecWarn				= "特殊警报设置"
L.SpecWarn_Enabled			= "显示首领技能特殊警报"
L.SpecWarn_LHFrame			= "特殊警报时屏幕边缘泛光"
L.SpecWarn_Font				= "特殊警报字体"
L.SpecWarn_DemoButton		= "测试警报"
L.SpecWarn_MoveMe			= "设置位置"
L.SpecWarn_FontSize			= "字体大小"
L.SpecWarn_FontColor		= "字体颜色"
L.SpecWarn_FontType			= "选择字体"
L.SpecWarn_ResetMe			= "重置"

-- Tab: HealthFrame
L.Panel_HPFrame				= "生命值框体"
L.Area_HPFrame				= "生命值框体选项"
L.HP_Enabled				= "总是显示生命值框体（无论该首领的相关设置如何）"
L.HP_GrowUpwards			= "向上扩展"
L.HP_ShowDemo				= "显示框体"
L.BarWidth					= "计量条宽度: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "全局及信息过滤"
L.Area_SpamFilter				= "信息过滤设置"
L.HideBossEmoteFrame			= "隐藏团队首领表情框体"
L.SpamBlockRaidWarning			= "过滤其他首领预警插件警报" 
L.SpamBlockBossWhispers			= "战斗中过滤DBM密语警报"
L.BlockVersionUpdateNotice		= "禁用升级提示"
L.ShowBigBrotherOnCombatStart	= "战斗开始时使用Big Brother检测增益情况"
L.BigBrotherAnnounceToRaid		= "报告Big Brother的检测结果给团队"

L.Area_SpamFilter_Outgoing		= "全局过滤设置"
L.SpamBlockNoShowAnnounce		= "不显示警报或播放警报音效"
L.SpamBlockNoSendAnnounce		= "不发送警报到团队频道"
L.SpamBlockNoSendWhisper		= "不发送悄悄话提示给其他玩家"
L.SpamBlockNoSetIcon			= "不设定标记在目标上"
L.SpamBlockNoRangeFrame			= "不显示距离监视器"
L.SpamBlockNoInfoFrame			= "不显示信息监视器"

L.Area_PullTimer				= "开怪倒计时过滤设置"
L.DontShowPT					= "不显示开怪倒计时条"
L.DontShowPTCountdownText		= "不显示开怪倒计时文字"
L.DontPlayPTCountdown			= "不播放开怪倒计时语音"

-- Misc
L.FontHeight	= 20