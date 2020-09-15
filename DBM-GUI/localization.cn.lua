-- Diablohu(diablohudream@gmail.com)
-- yleaf(yaroot@gmail.com)
-- sunlcy@NGA
-- Mini Dragon(projecteurs@gmail.com)
-- Last update: 2020/09/09

if GetLocale() ~= "zhCN" then return end
if not DBM_GUI_L then DBM_GUI_L = {} end

local L = DBM_GUI_L

L.MainFrame 				= "Deadly Boss Mods"

L.TranslationByPrefix		= "翻译:"
L.TranslationBy 			= "Mini_Dragon(Brilla@金色平原) 原翻译：Diablohu & yleaf & sunlcy"
L.Website					= "拜访我们的Discord |cFF73C2FBhttps://discord.gg/deadlybossmods|r. 在Twitter上关注 @deadlybossmods 或 @MysticalOS"
L.WebsiteButton				= "网页"

L.OTabBosses	            = "模块"--Deprecated and will be deleted once tabs no longer use this
L.OTabRaids		            = "副本 & PVP"--Raids & PVP
L.OTabDungeons	            = "地下城"--Might still need editing since it doesn't mention scenarios
L.OTabPlugins	            = "插件"
L.OTabOptions	            = "选项"
L.OTabAbout		            = "关于"

L.TabCategory_OTHER    		= "其它"

L.BossModLoaded 			= "%s状态"
L.BossModLoad_now 			= [[该模块尚未启动。
当你进入相应副本时其会自动加载。
你也可以点击开启模块按钮手动启动该模块。]]

L.PosX 						= 'X坐标'
L.PosY 						= 'Y坐标'

L.MoveMe					= '移动我'
L.Button_OK 				= '确定'
L.Button_Cancel 			= '取消'
L.Button_LoadMod 			= '加载模块'
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
L.Statistic_BestRank		= "最佳排名:"

-- Tab: General Options
L.TabCategory_Options	 	= "常规设置"
L.Area_BasicSetup			= "初始 DBM 设置提示"
L.Area_ModulesForYou		= "哪些 DBM 模块适合您？"
L.Area_ProfilesSetup		= "DBM 配置文件指南"
-- Panel: Core & GUI
L.Core_GUI 					= "DBM核心设置"
L.General 					= "DBM核心综合设置"
L.EnableMiniMapIcon			= "显示小地图按钮"
L.UseSoundChannel			= "设置DBM使用的声道"
L.UseMasterChannel			= "主声道"
L.UseDialogChannel			= "对话声道"
L.UseSFXChannel				= "音效声道"
L.Latency_Text				= "设定团队之间DBM最高延迟阈值：%d"

L.Button_RangeFrame			= "显示/隐藏距离雷达框体"
L.Button_InfoFrame			= "显示/隐藏信息框体"
L.Button_TestBars			= "测试计时条"
L.Button_ResetInfoRange		= "重置信息/距离雷达框体"

L.ModelOptions				= "3D模型选项"
L.EnableModels				= "在首领选项中启用3D模型"
L.ModelSoundOptions			= "为模型查看器设置声音选项"
L.ModelSoundShort			= "短"
L.ModelSoundLong			= "长"

L.ResizeOptions			 	= "调整窗口大小"
L.Button_ResetWindowSize	= "重置窗口大小"
L.Editbox_WindowWidth		= "宽度"
L.Editbox_WindowHeight		= "高度"

-- Panel: Extra Features
L.Panel_ExtraFeatures		= "其他功能"
L.Area_SoundAlerts			= "语音/闪烁警报选项"
L.LFDEnhance				= "当发起角色检查或随机团队/战场就绪时，在主声道播放准备音效(即使关闭了音效而且很大声！)并闪烁图标"
L.WorldBossNearAlert		= "当世界附近的Boss进入战斗时播放准备音效(覆盖单独BOSS设置)并闪烁图标"
L.RLReadyCheckSound			= "在主声道/对话声道播放检查准备音效并闪烁图标。"
L.AFKHealthWarning			= "当你在挂机/暂离受到伤害时播放音效并闪烁图标(你会死)"
--
L.TimerGeneral 				= "计时器选项"
L.SKT_Enabled				= "总是显示最速胜利计时条(覆盖单独BOSS设置)"
L.ShowRespawn				= "Boss战斗未完成时显示Boss刷新计时条"
L.ShowQueuePop				= "显示随机小队/团队查找器确认计时条"
--
L.Area_AutoLogging			= "自动战斗日志选项"
L.AutologBosses				= "自动采用官方格式记录日志。"
L.AdvancedAutologBosses		= "自动采用 Transcriptor 记录日志"
L.RecordOnlyBosses			= "只记录团队BOSS数据 (不记录其他数据，使用 /dbm pull 可提前记录并使得记录更准确，如提前偷药水或是召唤大军。)"
L.LogOnlyNonTrivial			= "只记录团队Boss，而不记录随机团队/5人本/场景战役"
--
L.Area_3rdParty				= "第三方插件选项"
L.ShowBBOnCombatStart		= "战斗开始时使用Big Brother的buff检测"
L.BigBrotherAnnounceToRaid	= "报告Big Brother的检测结果给团队"
L.Area_Invite				= "组队邀请选项"
L.AutoAcceptFriendInvite	= "自动接受来自好友列表里的好友的组队邀请"
L.AutoAcceptGuildInvite		= "自动接受同公会成员的组队邀请"
L.Area_Advanced				= "高级选项"
L.FakeBW					= "当检查Bigwig时，假装DBM就是Bigwig"
L.AITimer					= "DBM为没遇见过的战斗使用人工智能自动产生计时器(在初期的Beta或PTR的Boss测试非常有帮助)。此功能不会对多目标技能生效。"

-- Panel: Profiles
L.Panel_Profile				= "配置文件"
L.Area_CreateProfile		= "创建DBM核心配置"
L.EnterProfileName			= "输入配置文件名称"
L.CreateProfile				= "创建带有默认设置的配置文件"
L.Area_ApplyProfile			= "选择一个已有的DBM核心配置文件并应用它"
L.SelectProfileToApply		= "选择一个配置文件并应用"
L.Area_CopyProfile			= "复制一个配置文件"
L.SelectProfileToCopy		= "选择一个配置文件并复制"
L.Area_DeleteProfile		= "删除一个已有的DBM核心配置文件"
L.SelectProfileToDelete		= "选择一个配置文件并删除"
L.Area_DualProfile			= "Boss模块配置文件选项"
L.DualProfile				= "为Boss的每个专精开启不同的配置选项(Boss的配置在boss模块里)。默认状态下，当你切换专精时，DBM会重置选项到默认状态，选中本选项后，每个专精都有对应的配置文件，切换专精不会丢失上一个专精的配置。"

L.Area_ModProfile			= "复制/删除一个角色/专精选项"
L.ModAllReset				= "重置所有Boss模块选项"
L.ModAllStatReset			= "重置所有Boss模块状态"
L.SelectModProfileCopy		= "复制所有选项："
L.SelectModProfileCopySound	= "只复制声音选项："
L.SelectModProfileCopyNote	= "只复制自定义注记："
L.SelectModProfileDelete	= "删除 Boss 模块设置："

-- Tab: Alerts
L.TabCategory_Alerts	 	= "警报"
L.Area_SpecAnnounceConfig	= "特殊警报提示和声音指南"
L.Area_SpecAnnounceNotes	= "特殊警报自定义指南"
L.Area_VoicePackInfo		= "所有 DBM 语音包信息"
-- Panel: Raidwarning
L.Tab_RaidWarning 			= "团队警报"
L.RaidWarning_Header		= "团队警报设置"
L.RaidWarnColors 			= "团队警报颜色"
L.RaidWarnColor_1 			= "颜色 1"
L.RaidWarnColor_2 			= "颜色 2"
L.RaidWarnColor_3		 	= "颜色 3"
L.RaidWarnColor_4 			= "颜色 4"
L.InfoRaidWarning			= [[你可以对团队警报的文本颜色及其位置进行设定。
在这里会显示诸如“玩家X受到了Y效果的影响”之类的信息。]]
L.ColorResetted 			= "该颜色设置已重置。"
L.ShowWarningsInChat 		= "在聊天窗口中显示警报"
L.WarningIconLeft 			= "左侧显示图标"
L.WarningIconRight 			= "右侧显示图标"
L.WarningIconChat 			= "在聊天窗口中显示图标"
L.WarningAlphabetical		= "按字母顺序排序"
L.Warn_Duration				= "警告持续时间: %0.1f 秒"
L.None						= "无"
L.Random					= "随机"
L.Outline					= "描边"
L.ThickOutline				= "加粗描边"
L.MonochromeOutline			= "单色描边"
L.MonochromeThickOutline	= "单色加粗描边"
L.RaidWarnSound				= "发出团队警报时播放声音"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame		= "特殊团队警报"
L.Area_SpecWarn				= "特殊警报设置"
L.SpecWarn_ClassColor		= "为特殊警报启用分职业着色"
L.ShowSWarningsInChat 		= "在聊天窗口中显示特殊警报"
L.SWarnNameInNote			= "使用自定义注记的特殊警报请选择 类型5"
L.SpecialWarningIcon		= "特殊警报使用技能图标"
L.ShortTextSpellname		= "使用较短的技能名称 (当可行时)"
L.SpecWarn_FlashFrameRepeat	= "重复 %d 次 (如果开启的话)"
L.SpecWarn_Flash			= "屏幕闪烁"
L.SpecWarn_FlashRepeat		= "重复闪烁"
L.SpecWarn_FlashColor		= "闪烁颜色 %d"
L.SpecWarn_FlashDur			= "闪烁持续时间: %0.1f"
L.SpecWarn_FlashAlpha		= "闪烁透明度: %0.1f"
L.SpecWarn_DemoButton		= "测试警报"
L.SpecWarn_ResetMe			= "重置"
L.SpecialWarnSoundOption	= "设置默认声音"
L.SpecialWarnHeader1		= "类型 1: 设置影响您或您的操作的普通优先级警报选项"
L.SpecialWarnHeader2		= "类型 2: 设置影响每个人的正常优先级警报选项"
L.SpecialWarnHeader3		= "类型 3: 设置高优先级警报的选项"
L.SpecialWarnHeader4		= "类型 4: 设置“高优先级”选项会避免特殊警报"
L.SpecialWarnHeader5		= "类型 5: 设置警报选项，并包含玩家姓名"

-- Panel: Generalwarnings
L.Tab_GeneralMessages 		= "综合信息"
L.CoreMessages				= "核心信息设置"
L.ShowPizzaMessage 			= "在聊天窗口中显示计时条广播信息"
L.ShowAllVersions	 		= "当执行版本检查时,在聊天窗口中显示所有团员的Boss模组版本(如果禁用，仍旧显示过期/目前总结)"
L.ShowReminders				= "显示建议消息，缺少的模块和需要修补程序的信息。"

L.CombatMessages			= "战斗信息设置"
L.ShowEngageMessage 		= "在聊天窗口中显示开战信息"
L.ShowDefeatMessage 		= "在聊天窗口中显示击杀信息"
L.ShowGuildMessages 		= "在聊天窗口中显示公会开战/击杀/灭团信息"
L.ShowGuildMessagesPlus		= "在聊天窗口中显示公会中的M+以上难度的开战/击杀/灭团信息(需要团队选项)"


L.Area_ChatAlerts			= "其他警报选项"
L.RoleSpecAlert				= "当进入团队时，如果拾取专精与当前角色专精不同，则显示警告。"
L.CheckGear					= "当你身上的装备装等低于背包装等40点时显示警告。(可能没有装备某物品或装备了低等级的任务道具或没有装备主武器)"
L.WorldBossAlert			= "当世界Boss进入战斗后发送警告，这个信息可能是你的朋友或者同公会成员发送的。 (由于跨服，卡位面等因素，可能不准确)"

L.Area_BugAlerts			= "错误报告选项"
L.BadTimerAlert				= "在聊天窗口中显示DBM检测到计时器错误且至少有1秒不正确的信息"
L.BadIDAlert				= "在聊天窗口中显示DBM检测到使用中的无效技能或日志ID的信息"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "语音警报"
L.Area_VoiceSelection		= "语音选择"
L.CountdownVoice			= "设置第一倒计时语音"
L.CountdownVoice2			= "设置第二倒计时语音"
L.CountdownVoice3			= "设置第三倒计时语音"
L.VoicePackChoice			= "设置语音报警的语音包(快躲开！)"
L.Area_CountdownOptions		= "倒计时选项"
L.Area_VoicePackOptions		= "语音包选项(第三方语音包)"
L.SpecWarn_NoSoundsWVoice	= "当技能存在语音包语音时，屏蔽播放特殊警报声（当心，毁灭）"
L.SWFNever					= "从不"
L.SWFDefaultOnly			= "当特殊警报使用默认声音时(允许自定义语音包播放)"
L.SWFAll					= "当特殊警报使用任何默认声音时"
L.SpecWarn_AlwaysVoice		= "总是播放所有语音警报(覆盖Boss特定的选项,建议指挥使用)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?
L.Area_GetVEM				= "获取夏一可语音包(普通话最新)"
L.VEMDownload				= "|cFF73C2FBhttps://curseforge.com/wow/addons/dbm-voicepack-yike|r"
L.Area_BrowseOtherVP		= "获取其他语音包"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "获取其他倒计时语音包"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Tab: Event Sounds
L.Panel_EventSounds			= "事件音效"
L.Area_SoundSelection		= "音效选择(使用鼠标滚轮滚动选择)"
L.EventVictorySound			= "设置战斗胜利音效"
L.EventWipeSound			= "设置灭团音效"
L.EventEngageSound			= "设置开战音效"
L.EventDungeonMusic			= "设置在副本内播放的音乐"
L.EventEngageMusic			= "设置战斗过程中的音乐"
L.Area_EventSoundsExtras	= "事件音效选项"
L.EventMusicCombined		= "允许在副本内播放在音乐选项中的全部音效(需要/reload 才能加载)"
L.Area_EventSoundsFilters	= "事件音效过滤条件"
L.EventFilterDungMythicMusic= "不要在M/M+难度下播放副本音乐"
L.EventFilterMythicMusic	= "不要在M/M+难度下播放战斗音乐"

-- Tab: Timers
L.TabCategory_Timers		= "计时条"
L.Area_ColorBytype			= "计时条分类着色指南"
-- Panel: Color by Type
L.Panel_ColorByType	 		= "计时条分类着色"
L.AreaTitle_BarColors		= "计时条颜色"
L.BarTexture				= "计时条材质"
L.BarStyle					= "计时条样式"
L.BarDBM					= "DBM(有动画)"
L.BarSimple					= "简易(没动画)"
L.BarStartColor				= "初始颜色"
L.BarEndColor 				= "结束颜色"
L.Bar_Height				= "计时条高度: %d"
L.Slider_BarOffSetX 		= "X 偏移: %d"
L.Slider_BarOffSetY 		= "Y 偏移: %d"
L.Slider_BarWidth 			= "宽度: %d"
L.Slider_BarScale 			= "缩放: %0.2f"
--Types
L.BarStartColorAdd			= "初始颜色 (小怪入场)"
L.BarEndColorAdd			= "结束颜色 (小怪入场)"
L.BarStartColorAOE			= "初始颜色 (AOE)"
L.BarEndColorAOE			= "结束颜色 (AOE)"
L.BarStartColorDebuff		= "初始颜色 (点名技能)"
L.BarEndColorDebuff			= "结束颜色 (点名技能)"
L.BarStartColorInterrupt	= "初始颜色 (打断)"
L.BarEndColorInterrupt		= "结束颜色 (打断)"
L.BarStartColorRole			= "初始颜色 (剧情)"
L.BarEndColorRole			= "结束颜色 (剧情)"
L.BarStartColorPhase		= "初始颜色 (阶段转换)"
L.BarEndColorPhase			= "结束颜色 (阶段转换)"
L.BarStartColorUI			= "初始颜色 (自定义)"
L.BarEndColorUI				= "结束颜色 (自定义)"
--Type 7 options
L.Bar7Header				= "自定义计时条选项"
L.Bar7ForceLarge			= "总是使用大型计时条"
L.Bar7CustomInline			= "使用自定义 '!' 图标"
--Dropdown Options
L.CBTGeneric				= "通用"
L.CBTAdd					= "小怪"
L.CBTAOE					= "AOE"
L.CBTTargeted				= "点名"
L.CBTInterrupt				= "打断"
L.CBTRole					= "剧情"
L.CBTPhase					= "阶段"
L.CBTImportant				= "重要 (自定义)"
L.CVoiceOne					= "倒数 1"
L.CVoiceTwo					= "倒数 2"
L.CVoiceThree				= "倒数 3"

-- Panel: Timers
L.Panel_Appearance	 		= "计时条设置"
L.Panel_Behavior	 		= "计时条特性"
L.AreaTitle_BarSetup		= "计时条综合设置"
L.AreaTitle_Behavior		= "计时条特性设置"
L.AreaTitle_BarSetupSmall 	= "小型计时条设置"
L.AreaTitle_BarSetupHuge	= "大型计时条设置"
L.EnableHugeBar 			= "开启大型计时条（2号计时条）"
L.BarIconLeft 				= "左侧图标"
L.BarIconRight 				= "右侧图标"
L.ExpandUpwards				= "快消失的计时条在上"
L.FillUpBars				= "填充计时条"
L.ClickThrough				= "禁用鼠标点击事件（允许你点击计时条后面的目标）"
L.Bar_Decimal				= "%d 秒以内显示小数点"
L.Bar_Alpha					= "计时条透明度: %0.1f"
L.Bar_EnlargeTime			= "在 %d 秒后计时条变大"
L.BarSpark					= "计时条闪光"
L.BarFlash					= "快走完时闪动"
L.BarSort					= "按剩余时间排序"
L.BarColorByType			= "按类着色"
L.NoBarFade					= "使用开始/结束颜色作为长/短计时条颜色，而不是颜色渐变"
L.BarInlineIcons			= "显示条内图标"
L.ShortTimerText			= "使用更短的计时条文字 (当可行时)"
L.StripTimerText			= "分离 CD/下一次 计时条"
L.KeepBar					= "保持计时条显示直到技能被释放"
L.KeepBar2					= "(当被模组支持时)"
L.FadeBar					= "隐藏超出技能范围的计时条"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 	= "禁用及过滤选项"
L.Area_DBMFiltersSetup		= "DBM 信息过滤指南"
L.Area_BlizzFiltersSetup	= "暴雪信息过滤指南"
-- Panel: DBM Features
L.Panel_SpamFilter			= "DBM 全局过滤选项"
L.Area_SpamFilter_Anounces	= "警报过滤选项"
L.SpamBlockNoShowAnnounce	= "不显示警报或播放警报音效"
L.SpamBlockNoShowTgtAnnounce= "不显示针对目标类型的警报或播放警报音效(上面那个优先级比这个高)"
L.SpamBlockNoSpecWarnText	= "不显示特殊警报，但允许语音包(上面那个优先级比这个高)"
L.SpamBlockNoSpecWarnFlash	= "不显示特殊警报屏幕闪烁"
L.SpamBlockNoSpecWarnSound	= "不播放特殊团队警报的声音（如果在“语音警报”面板中启用了语音包，则仍然允许语音包）"

L.Area_SpamFilter_Timers	= "计时器过滤选项"
L.SpamBlockNoShowTimers		= "不显示 DBM 原装计时条"
L.SpamBlockNoShowUTimers	= "不显示用户自定义生成的计时条(Custom/Pull/Break)"
L.SpamBlockNoCountdowns		= "不要播放倒计时语音"

L.Area_SpamFilter_Misc		= "全局过滤设置"
L.SpamBlockNoSetIcon		= "不在目标上设定标记"
L.SpamBlockNoRangeFrame		= "不显示距离雷达框体"
L.SpamBlockNoInfoFrame		= "不显示信息框体"
L.SpamBlockNoHudMap			= "不显示 HudMap"
L.SpamBlockNoNameplate		= "不显示姓名面板高亮"
L.SpamBlockNoYells			= "不再战斗中大喊"
L.SpamBlockNoNoteSync		= "不接受别人分享的自定义备注"

L.Area_Restore				= "DBM战斗结束重置设置（在模块完成后，DBM 是否还原先前的设置）"
L.SpamBlockNoIconRestore	= "当战斗结束后不保存团队标记状态并重置"
L.SpamBlockNoRangeRestore	= "当Boss模块隐藏距离窗体时不重置窗体位置"

L.Area_SpamFilter			= "信息过滤选项"
L.DontShowFarWarnings		= "不为过远的事件显示计时条/警报"
L.StripServerName			= "警报和计时器中不显示服务器名"
L.FilterVoidFormSay			= "当在虚无状态下，不播发位置或报数喊叫"

L.Area_SpecFilter			= "角色过滤选项"
L.FilterTankSpec			= "当非坦克专精时，过滤掉给予坦克的专用信息"
L.FilterInterruptsHeader	= "基于行为偏好的打断技能提示过滤。"
L.FilterInterrupts			= "如果被打断对象不是当前目标/焦点(总是)"
L.FilterInterrupts2			= "如果被打断对象不是当前目标/焦点(总是)或者打断技能正在冷却(限Boss)"
L.FilterInterrupts3			= "如果被打断对象不是当前目标/焦点(总是)或者打断技能正在冷却(Boss和小怪)"
L.FilterInterrupts4			= "始终过滤打断警报 (你不想看到他们的时候)"
L.FilterInterruptNoteName	= "当自定义注记内没有包含你的名字的时候，过滤掉打断提示 (带计数)"
L.FilterDispels				= "当驱散技能在冷却时, 过滤掉驱散提示"
L.FilterTrashWarnings		= "当进入普通或英雄副本时，过滤掉所有小怪警报"

L.Area_PullTimer			= "开怪和倒计时过滤设置"
L.DontShowPTNoID			= "不显示不同区域发送的倒计时"
L.DontShowPT				= "不显示开怪和倒计时条"
L.DontShowPTText			= "不显示开怪和倒计时文字"
L.DontPlayPTCountdown		= "不播放开怪倒计时语音"
L.DontShowPTCountdownText	= "不显示开怪倒计时动画"
L.PT_Threshold				= "不显示高于 %d 秒的倒计时动画"

-- Panel: Blizzard Features
L.Panel_HideBlizzard		= "隐藏游戏自带内容"
L.Area_HideBlizzard			= "隐藏游戏自带提示选项"
L.HideBossEmoteFrame		= "Boss 战斗中隐藏Boss表情框体"
L.HideWatchFrame			= "在没有成就追踪的情况下，Boss战斗中隐藏任务追踪框体"
L.HideGarrisonUpdates		= "Boss 战斗中隐藏要塞队列完成提示"
L.HideGuildChallengeUpdates	= "Boss 战斗中隐藏公会挑战成功信息"
L.HideQuestTooltips			= "Boss 战斗中隐藏鼠标提示窗体中的任务进度"
L.HideTooltips				= "Boss 战斗中完全隐藏鼠标提示窗体"
L.DisableSFX				= "Boss 战斗中关闭音效"
L.DisableCinematics			= "自动跳过游戏内过场动画"
L.OnlyFight					= "只有在战斗中，每部动画播放了一次之后跳过"
L.AfterFirst				= "仅第一次播放"
L.CombatOnly				= "在任何战斗中隐藏"
L.RaidCombat				= "在BOSS战斗中隐藏 "

-- Panel: Privacy
L.Tab_Privacy 				= "密语设置"
L.Area_WhisperMessages		= "密语信息设置"
L.AutoRespond 				= "在战斗中自动回复私聊"
L.WhisperStats 				= "在回复的私聊中包含击杀或灭团次数统计信息"
L.DisableStatusWhisper 		= "屏蔽全团成员的密语(需要团长权限)。只对普通/英雄/神话团队和挑战/神话五人小队有效。"
L.Area_SyncMessages			= "信息同步设置"
L.EnableWBSharing 			= "当世界增益BUFF的激活或者世界BOSS刷新/击杀；分享给在同服务器的战网好友。 （此信息将始终与您的公会分享）"
L.DisableGuildStatus 		= "屏蔽通报团队进度信息到公会(需要团长权限)"

-- Tab: Frames & Integrations
L.TabCategory_Frames		= "框体及其它"
L.Area_NamelateInfo			= "DBM 姓名板光环信息"
-- Panel: InfoFrame
L.Panel_InfoFrame			= "信息框"

-- Panel: Range
L.Panel_Range				= "距离框"

-- Panel: Nameplate
L.Panel_Nameplates			= "姓名板"
L.UseNameplateHandoff		= "将姓名板上显示技能图标移交给支持的插件（KuiNameplates，Threat Plates，Plater），而不是DBM处理。 推荐使用此选项，因为能通过姓名板插件完成更高级的功能和配置。"
L.Area_NPStyle				= "样式(注意：仅能使用DBM配置支持的样式。)"
L.NPAuraSize				= "技能图标大小 (比例): %d"

-- Misc
L.Area_General				= "一般"
L.Area_Position				= "位置"
L.Area_Style				= "样式"

L.FontSize					= "字体大小: %d"
L.FontStyle					= "字体样式"
L.FontColor					= "字体颜色"
L.FontShadow				= "字体阴影"
L.FontType					= "选择字体"


L.FontHeight	= 20
