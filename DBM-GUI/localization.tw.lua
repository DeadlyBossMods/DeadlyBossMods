if GetLocale() ~= "zhTW" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame	= "Deadly Boss Mods"

L.TranslationByPrefix		= "翻譯:"
L.TranslationBy 			= "Imbav@聖光之願"
L.Website					= "拜訪討論/支援論壇:|cFF73C2FBwww.deadlybossmods.com|r 請在推特上關注@deadlybossmods或@MysticalOS"
L.WebsiteButton				= "論壇"

L.OTabBosses	= "首領模組"
L.OTabOptions	= GAMEOPTIONS_MENU

L.TabCategory_Options		= "綜合設置"
L.TabCategory_OTHER			= "其它首領模組"

L.BossModLoaded				= "%s狀態"
L.BossModLoad_now 			= [[該模組尚未載入。
當你進入相應副本時其會自動載入。
你也可以點擊該按鈕手動載入該模組。]]

L.PosX						= 'X座標'
L.PosY						= 'Y座標'

L.MoveMe 					= '移動'
L.Button_OK 				= '確定'
L.Button_Cancel 			= '取消'
L.Button_LoadMod 			= '載入模組'
L.Mod_Enabled				= "啟用首領模組"
L.Mod_Reset					= "讀取預設值"
L.Reset 					= "重置"

L.Enable  					= "啟用"
L.Disable					= "禁用"

L.NoSound					= "靜音"

L.IconsInUse				= "此模組已使用的標記"

-- Tab: Boss Statistics
L.BossStatistics			= "首領狀態"
L.Statistic_Kills			= "勝利："
L.Statistic_Wipes			= "失敗："
L.Statistic_Incompletes		= "未完成："
L.Statistic_BestKill		= "最快記錄："
L.Statistic_BestRank		= "最佳等級："

-- Tab: General Core Options
L.General 					= "DBM綜合設置"
L.EnableMiniMapIcon			= "顯示小地圖圖示"
L.UseSoundChannel			= "設置DBM警告的音效頻道"
L.UseMasterChannel			= "主聲道"
L.UseDialogChannel			= "對話聲道"
L.UseSFXChannel				= "音效聲道"
L.Latency_Text				= "設定最高延遲同步門檻:%d"

L.ModelOptions				= "3D模型預覽選項"
L.EnableModels				= "在首領選項中啟用3D模型預覽"
L.ModelSoundOptions			= "為模型預覽設置聲音"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.Button_RangeFrame			= "顯示/隱藏距離監視器"
L.Button_InfoFrame			= "顯示/隱藏訊息監視器"
L.Button_TestBars			= "測試計時條"
L.Button_ResetInfoRange		= "重置訊息/距離監視器"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "團隊警告"
L.RaidWarning_Header		= "團隊警告選項"
L.RaidWarnColors 			= "團隊警告顏色"
L.RaidWarnColor_1 			= "顏色1"
L.RaidWarnColor_2 			= "顏色2"
L.RaidWarnColor_3			= "顏色3"
L.RaidWarnColor_4 			= "顏色4"
L.InfoRaidWarning			= [[你可以對團隊警告的顏色及其位置進行設定。
在這裡會顯示例如“玩家X中了Y效果”之類的資訊。]]
L.ColorResetted 			= "該顏色設置已重置"
L.ShowWarningsInChat 		= "在聊天視窗中顯示警告"
L.WarningIconLeft 			= "左側顯示圖示"
L.WarningIconRight 			= "右側顯示圖示"
L.WarningIconChat 			= "在聊天視窗顯示圖示"
L.WarningAlphabetical		= "依字母排序"
L.Warn_FontType				= "選擇字型"
L.Warn_FontStyle			= "字型風格"
L.Warn_FontShadow			= "陰影"
L.Warn_FontSize				= "字型大小:%d"
L.Warn_Duration				= "警告持續時間:%d秒"
L.None						= "無"
L.Outline					= "輪廓"
L.ThickOutline				= "厚輪廓"
L.MonochromeOutline			= "黑白輪廓"
L.MonochromeThickOutline	= "黑白厚輪廓"
L.RaidWarnSound				= "發出團隊警告時播放音效"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "綜合訊息"
L.CoreMessages				= "核心訊息選項"
L.ShowPizzaMessage 			= "在聊天視窗顯示計時器廣播訊息"
L.ShowAllVersions	 		= "在聊天視窗顯示所有隊伍成員的首領模組版本當執行版本檢查。(如果禁用，依舊顯示過期/目前總結)"
L.CombatMessages			= "戰鬥訊息選項"
L.ShowEngageMessage 		= "在聊天視窗顯示開戰訊息"
L.ShowDefeatMessage 		= "在聊天視窗顯示戰勝/滅團訊息"
L.ShowGuildMessages 		= "在聊天視窗顯示公會的開戰/戰勝/滅團的訊息"
L.WhisperMessages			= "密語訊息選項"
L.AutoRespond 				= "啟用戰鬥中自動密語回覆"
L.EnableStatus 				= "回覆'status'的密語"
L.WhisperStats 				= "在密語回應中加入戰勝/滅團狀態"
L.DisableStatusWhisper 		= "禁用整個團隊狀態密語(需要隊伍隊長)。只套用於普通/英雄/傳奇團隊和挑戰模式/傳奇地城"

-- Tab: Barsetup
L.BarSetup   				= "計時條樣式"
L.BarTexture 				= "計時條材質"
L.BarStyle					= "計時條風格"
L.BarDBM					= "DBM(動畫)"
L.BarSimple					= "精簡(沒有動畫)"
L.BarStartColor				= "開始顏色"
L.BarEndColor 				= "結束顏色"
L.Bar_Font					= "計時條使用的字型"
L.Bar_FontSize				= "字型大小"
L.Bar_Height				= "計時條高度:%d"
L.Slider_BarOffSetX 		= "X偏移:%d"
L.Slider_BarOffSetY 		= "Y偏移:%d"
L.Slider_BarWidth 			= "寬度:%d"
L.Slider_BarScale 			= "尺寸:%0.2f"
--Types
L.BarStartColorAdd			= "開始顏色(小怪)"
L.BarEndColorAdd			= "結束顏色(小怪)"
L.BarStartColorAOE			= "開始顏色(AOE)"
L.BarEndColorAOE			= "結束顏色(AOE)"
L.BarStartColorDebuff		= "開始顏色(點名技能)"
L.BarEndColorDebuff			= "結束顏色(點名技能)"
L.BarStartColorInterrupt	= "開始顏色(中斷)"
L.BarEndColorInterrupt		= "結束顏色(中斷)"
L.BarStartColorRole			= "開始顏色(角色)"
L.BarEndColorRole			= "結束顏色(角色)"
L.BarStartColorPhase		= "開始顏色(階段轉換)"
L.BarEndColorPhase			= "結束顏色(階段轉換)"
L.BarStartColorUI			= "開始顏色(自訂)"
L.BarEndColorUI				= "結束顏色(自訂)"
--Type 7 options
L.Bar7Header				= "自訂計時條選項"
L.Bar7ForceLarge			= "總是使用大計時條"
L.Bar7CustomInline			= "使用自訂的'!'圖示"
L.Bar7Footer				= "(測試計時條)"

-- Tab: Timers
L.AreaTitle_BarColors		= "根據計時器類型上色"
L.AreaTitle_BarSetup		= "計時條綜合設置"
L.AreaTitle_BarSetupSmall 	= "小型計時條設置"
L.AreaTitle_BarSetupHuge	= "大型計時條設置"
L.EnableHugeBar 			= "開啟大型計時條(2號計時條)"
L.BarIconLeft 				= "左側顯示圖示"
L.BarIconRight 				= "右側顯示圖示"
L.ExpandUpwards				= "計時條向上延伸"
L.FillUpBars				= "填滿計時條"
L.ClickThrough				= "禁用鼠標事件(允許你點擊穿透計時條)"
L.Bar_Decimal				= "%d秒以下顯示小數點"
L.Bar_DBMOnly				= "以下選項只支援 \"DBM\" 計時條風格"
L.Bar_EnlargeTime			= "計時條時間低於:%d時放大"
L.Bar_EnlargePercent		= "計時條百分比低於:%0.1f%%時放大"
L.BarSpark					= "計時條閃光"
L.BarFlash					= "快結束時閃爍計時條"
L.BarSort					= "依剩餘時間排序"
L.BarColorByType			= "根據類型上色"
L.BarInlineIcons			= "顯示嵌入圖示"
L.ShortTimerText			= "使用較短的計時器文字(如果可用時)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "特別警告"
L.Area_SpecWarn				= "特別警告選項"
L.SpecWarn_ClassColor		= "為特別警告套用職業顏色"
L.ShowSWarningsInChat 		= "在聊天視窗中顯示特別警告"
L.SWarnNameInNote			= "使用特別警告5選項如果自訂註記有包含你的名字"
L.SpecialWarningIcon		= "在特別警告上顯示圖示"
L.SpecWarn_FlashFrame		= "為特別警告閃爍螢幕"
L.SpecWarn_FlashFrameRepeat	= "反覆%d次(如果啟用)"
L.SpecWarn_Font				= "特別警告使用的字型"
L.SpecWarn_FontSize			= "字型大小"
L.SpecWarn_FontColor		= "字型顏色"
L.SpecWarn_FontType			= "選擇字型"
L.SpecWarn_FlashRepeat		= "反覆閃爍"
L.SpecWarn_FlashColor		= "閃爍顏色:%d"
L.SpecWarn_FlashDur			= "閃爍長度:%0.1f"
L.SpecWarn_FlashAlpha		= "閃爍透明度:%0.1f"
L.SpecWarn_DemoButton		= "顯示範例"
L.SpecWarn_MoveMe			= "設定位置"
L.SpecWarn_ResetMe			= "重置為預設值"
L.SpecialWarnSound			= "設定作用於你或你的角色天賦的特別警告音效"
L.SpecialWarnSound2			= "設定作用於全團的特別警告音效"
L.SpecialWarnSound3			= "設定作用於極度重要的特別警告音效"
L.SpecialWarnSound4			= "設定作用於快跑啊小女孩的特別警告音效"
L.SpecialWarnSound5			= "設定作用於註記包含你的名字的特別警告音效"

-- Tab: Heads Up Display Frame
L.Panel_HUD					= "HUD提醒顯示"
L.Area_HUDOptions			= "HUD選項"
L.HUDColorOverride			= "為HUD替換模組顏色"
L.HUDSizeOverride			= "為HUD替換模組大小"
L.HUDAlphaOverride			= "為HUD替換模組透明度"
L.HUDTextureOverride		= "為HUD替換模組材質(這不套用到'圖示'材質選項)"
L.HUDColorSelect			= "HUD顏色%d"
L.HUDTextureSelect1			= "為主要HUD設定材質"
L.HUDTextureSelect2			= "為次要HUD設定材質"
L.HUDTextureSelect3			= "為第三HUD設定材質"
L.HUDTextureSelect4			= "為'跑至某處'HUD設定材質"
L.HUDSizeSlider				= "圓形半徑:%0.1f"
L.HUDAlphaSlider			= "透明度:%0.1f"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "語音警告"
L.Area_VoiceSelection		= "語音選擇"
L.CountdownVoice			= "設置主要倒數計時語音"
L.CountdownVoice2			= "設置次要倒數計時語音"
L.CountdownVoice3			= "設置第三倒數計時語音"
L.VoicePackChoice			= "設置語音警告的語音包"
L.Area_CountdownOptions		= "倒數選項"
L.Area_VoicePackOptions		= "語音包選項(協力語音包)"
L.SpecWarn_NoSoundsWVoice	= "設置何時撥放特別警告音效也使用語音警告..."
L.SWFNever					= "絕不"
L.SWFDefaultOnly			= "當特別警告使用預設音效。(允許自訂音效繼續撥放)"
L.SWFAll					= "當特別警告使用所有音效"
L.SpecWarn_AlwaysVoice		= "總是播放所有語音警告(覆蓋所有特定首領選項)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?

-- Tab: HealthFrame
L.Panel_HPFrame				= "血量框架"
L.Area_HPFrame				= "血量框架選項"
L.HP_Enabled				= "總是顯示血量框架 (覆蓋特定首領選項)"
L.HP_GrowUpwards			= "血量框架向上延伸"
L.HP_ShowDemo				= "顯示血量框架"
L.BarWidth					= "寬度:%d"

-- Tab: Global Filter
L.Panel_SpamFilter			= "DBM全局禁用及過濾"
L.Area_SpamFilter_Outgoing	= "DBM全局禁用及過濾選項"
L.SpamBlockNoShowAnnounce	= "不顯示提示或播放警告音效"
L.SpamBlockNoSpecWarn		= "不顯示特別警告或播放特別警告音效"
L.SpamBlockNoShowTimers		= "不顯示計時器"
L.SpamBlockNoShowUTimers	= "不顯示玩家送出的計時器(自訂/拉怪/休息)"
L.SpamBlockNoSetIcon		= "不設置標記在目標上"
L.SpamBlockNoRangeFrame		= "不顯示距離框架"
L.SpamBlockNoInfoFrame		= "不顯示訊息框架"
L.SpamBlockNoHudMap			= "不要顯示HudMap"
L.SpamBlockNoNameplate		= "不要顯示名條光環"
L.SpamBlockNoHealthFrame	= "不顯示血量框架"
L.SpamBlockNoCountdowns		= "不播放倒數音效"
L.SpamBlockNoYells			= "不送出大喊至頻道"
L.SpamBlockNoNoteSync		= "不接受註記分享"

L.Area_Restore				= "DBM還原選項(DBM是否還原至使用者過去狀態)"
L.SpamBlockNoIconRestore	= "不在戰鬥結束後記住和還原團隊圖示狀態"
L.SpamBlockNoRangeRestore	= "不因模組預設值還原距離框架的狀態"

-- Tab: Spam Filter
L.Area_SpamFilter			= "垃圾過濾選項"
L.DontShowFarWarnings		= "不發送距離過遠的事件提示/計時器"
L.StripServerName			= "隱藏警告和計時器的玩家伺服器名稱"
L.SpamBlockBossWhispers		= "當戰鬥時過濾 &lt;DBM&gt; 密語警告"
L.BlockVersionUpdateNotice	= "在聊天頻道顯示較高頻率的過期通知而非彈出視窗。"

L.Area_SpecFilter			= "專精過濾選項"
L.FilterTankSpec			= "非坦克專精時過濾掉坦克專精的特定警告 (註:不建議玩家關閉此選項因大多數的坦克嘲諷警告都是預設開啟。)"
L.FilterInterrupts			= "過濾可中斷技能的警告如果施法者不是你的目標或專注目標。(註：此選項不套用於可能會導致滅團的必須中斷技能)"
L.FilterInterruptNoteName	= "過濾可中斷技能的警告(與次數)，如果自訂註記警告沒有包含你的名字"
L.FilterDispels				= "過濾可驅散技能如果你的驅散技正在冷卻中"
L.FilterSelfHud				= "從HudMap過濾你自己(排除Hud的距離功能)"

L.Area_PullTimer			= "開怪計時器過濾選項"
L.DontShowPTNoID			= "阻擋與你不同區域ID送出的開怪倒數計時條"
L.DontShowPT				= "不要顯示開怪/休息倒數計時條"
L.DontShowPTText			= "不要顯示開怪/休息提示文字"
L.DontPlayPTCountdown		= "不要使用開怪/休息/開戰/自訂計時器倒數音效"
L.DontShowPTCountdownText	= "不要顯示開怪/休息/開戰/自訂計時器倒數文字"
L.PT_Threshold				= "不要顯示高於%d秒以上的休息/開戰/自訂倒數計時器文字"

L.Panel_HideBlizzard		= "禁用及隱藏暴雪功能"
L.Area_HideBlizzard			= "禁用及隱藏暴雪功能選項"
L.HideBossEmoteFrame		= "首領戰鬥時隱藏團隊首領表情框架"
L.HideWatchFrame			= "首領戰鬥時隱藏任務目標框架。如果在挑戰模式中，當框架隱藏會在首領戰鬥中建立一個暫時的獎牌計時器。"
L.HideGarrisonUpdates		= "首領戰鬥時隱藏要塞任務完成提示"
L.HideGuildChallengeUpdates	= "首領戰鬥時隱藏公會挑戰完成提示"
L.HideQuestTooltips			= "首領戰鬥時隱藏滑鼠提示的任務物件"
L.HideTooltips				= "首領戰鬥時完全地隱藏滑鼠提示"
L.DisableSFX				= "首領戰鬥時禁用音效頻道"
L.SpamBlockSayYell			= "從聊天頻道隱藏聊天泡泡提示"
L.DisableCinematics			= "禁用遊戲中的過場動畫"
L.AfterFirst				= "在每次動畫播放一次之後"
L.Always					= ALWAYS
L.CombatOnly				= "在任何戰鬥中禁用"
L.RaidCombat				= "只在首領戰鬥中禁用"

L.Panel_ExtraFeatures		= "額外功能"
--
L.Area_ChatAlerts			= "文字警告選項"
L.RoleSpecAlert				= "當你加入團隊時捨取專精不符合你目前專精顯示警告訊息"
L.CheckGear					= "開怪時顯示裝備警告訊息 (當你裝備的裝備等級低於包包裡40等以上或主手武器沒有裝備時顯示警告訊息)"
L.WorldBossAlert			= "當你的工會成員或是朋友可能在你的伺服器上開戰世界首領時顯示警告訊息(如果發送者是被戰復的會不準確)"
--
L.Area_SoundAlerts			= "聲音/閃爍警告選項"
L.LFDEnhance				= "使用主要或對話聲音頻道播放準備確認音效和閃爍應用程式圖示給角色確認和戰場/隨機團隊進場(I.E. 即使音效被關閉了也會發出音效而且很大聲!)"
L.WorldBossNearAlert		= "當你需要的世界首領在你附近開戰播放準備確認音效和閃爍應用程式圖示"
L.RLReadyCheckSound			= "從主要或對話音效頻道播放準備確認音效和閃爍應用程式圖示"
L.AFKHealthWarning			= "播放警告聲音和閃爍應用程式圖示假如你在暫離時被攻擊"
L.AutoReplySound			= "當接收到DBM自動回覆密語時播放警告聲和閃爍應用程式圖示"
--
L.TimerGeneral 				= "計時器選項"
L.SKT_Enabled				= "顯示目前戰鬥的最佳紀錄勝利計時器"
L.CRT_Enabled				= "為下一次戰復充能顯示計時器"
L.ShowRespawn				= "在一個滅團之後顯示首領重生計時器"
L.ShowQueuePop				= "為佇列(隨機,戰場,其他)接受時間顯示計時器"
--
L.Area_AutoLogging			= "自動記錄選項"
L.AutologBosses				= "自動使用暴雪戰鬥日誌記錄首領戰鬥(為了紀錄藥水事件等其他事件請於開打前使用/dbm pull)"
L.AdvancedAutologBosses		= "自動使用Transcriptor紀錄首領戰鬥"
L.LogOnlyRaidBosses			= "只記錄當前資料片團隊首領的戰鬥(除了隨機團隊/隨機隊伍/隨機事件/舊副本團隊)"
--
L.Area_3rdParty				= "協力插件選項"
L.ShowBBOnCombatStart		= "戰鬥開始時顯示BigBrother(檢查團隊 增益/精煉UI)"
L.BigBrotherAnnounceToRaid	= "通告BigBrother的結果給團隊"
L.Area_Invite				= "邀請選項"
L.AutoAcceptFriendInvite	= "自動接受來自朋友的隊伍邀請"
L.AutoAcceptGuildInvite		= "自動接受來自公會成員的隊伍邀請"
L.Area_Advanced				= "進階選項"
L.FakeBW					= "假裝使用BigWigs版本檢查而不是用DBM版本(適合用在工會強制使用BigWigs時)"
L.AITimer					= "DBM為沒遇見過的戰鬥使用內建的AI計時器自動產生計時器(在初期的Beta或PTR的首領測試非常有幫助)。 註: 此功能不會在多目標使用相同技能生效。"
L.AutoCorrectTimer			= "自動校正時間過長的計時器(適合在公會正在進行全新副本而首領模組還沒被更新至可靠的程度). 註: 這選項可能會使某些計時器錯亂，如首領重制計時器或階段轉換而DBM編碼還不能夠去處理。"

L.PizzaTimer_Headline		= '建立一個計時條'
L.PizzaTimer_Title			= '名稱（如“Pizza計時器”）'
L.PizzaTimer_Hours 			= "時"
L.PizzaTimer_Mins 			= "分"
L.PizzaTimer_Secs 			= "秒"
L.PizzaTimer_ButtonStart 	= "開始計時"
L.PizzaTimer_BroadCast		= "向團隊廣播"

L.Panel_Profile				= "配置檔"
L.Area_CreateProfile        = "建立核心選項配置檔"
L.EnterProfileName			= "輸入配置檔名稱"
L.CreateProfile				= "建立預設設定值的新配置檔"
L.Area_ApplyProfile			= "套用DBM核心選項配置檔"
L.SelectProfileToApply		= "選擇配置檔套用"
L.Area_CopyProfile			= "複製DBM核心選項配置檔"
L.SelectProfileToCopy		= "選擇配置檔複製"
L.Area_DeleteProfile		= "移除DBM核心選項配置檔"
L.SelectProfileToDelete		= "選擇配置檔刪除"
L.Area_DualProfile			= "首領模組配置檔選項"
L.DualProfile				= "啟用多首領模組專精設定檔。可依據你的專精去設定不同的首領選項設定。(首領配置檔管理在首領模組頁面下)"

L.Area_ModProfile			= "從其他角色/專精複製或刪除模組設定"
L.ModAllReset				= "重置所有模組設定"
L.ModAllStatReset			= "重置所有模組狀態"
L.SelectModProfileCopy		= "複製所有設定"
L.SelectModProfileCopySound	= "只複製音效設定"
L.SelectModProfileCopyNote	= "只複製註記設定"
L.SelectModProfileDelete	= "刪除模組設定"

-- Misc
L.FontHeight	= 18
