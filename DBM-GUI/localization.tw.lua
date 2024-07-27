if GetLocale() ~= "zhTW" then return end
if not DBM_GUI_L then DBM_GUI_L = {} end
local L = DBM_GUI_L

L.MainFrame	= "Deadly Boss Mods"

L.TranslationByPrefix		= "翻譯:"
L.TranslationBy 			= "三皈依@暗影之月 & Imbav@聖光之願"
L.Website					= "拜訪討論/支援論壇:|cFF73C2Fhttps://discord.gg/deadlybossmods|r. 請在推特上關注@deadlybossmods或@MysticalOS"
L.WebsiteButton				= "論壇"

L.OTabBosses				= "首領選項"
L.OTabRaids					= "團隊"
L.OTabDungeons				= "隊伍/單獨"
L.OTabWorld					= "世界首領"
L.OTabScenarios				= "事件"
L.OTabPlugins				= "其他"
L.OTabOptions				= "核心選項"
L.OTabAbout					= "關於"

L.FOLLOWER					= "追隨者"--i.e. the new dungeon type in 10.2.5. I haven't found a translated string yet

L.TabCategory_CURRENT_SEASON	= "當前賽季"

L.TabCategory_OTHER			= "其它模組"
L.TabCategory_AFFIXES		= "詞綴"

L.BossModLoaded				= "%s狀態"
L.BossModLoad_now 			= [[該模組尚未載入。
當你進入相應副本時其會自動載入。
你也可以點擊該按鈕手動載入該模組。]]

L.PosX						= "X座標"
L.PosY						= "Y座標"

L.MoveMe 					= "移動"
L.Button_OK 				= "確定"
L.Button_Cancel 			= "取消"
L.Button_LoadMod 			= "載入模組"
L.Mod_Enabled				= "啟用首領模組"
L.Mod_Reset					= "讀取預設值"
L.Reset 					= "重置"
L.Import					= "匯入"

L.Enable					= ENABLE
L.Disable					= DISABLE

L.NoSound					= "靜音"

L.IconsInUse				= "此模組已使用的標記"

-- Tab: Boss Statistics
L.BossStatistics			= "首領狀態"
L.Statistic_Kills			= "勝利："
L.Statistic_Wipes			= "失敗："
L.Statistic_Incompletes		= "未完成："
L.Statistic_BestKill		= "最快記錄："
L.Statistic_BestRank		= "最佳排名："

-- Tab: General Options
L.TabCategory_Options	 	= "一般選項"
L.Area_BasicSetup			= "初始DBM設置提示"
L.Area_ModulesForYou		= "哪些DBM模組適合您？"
L.Area_ProfilesSetup		= "DBM配置檔使用指南"
-- Panel: Core & GUI
L.Core_GUI 					= "核心 & 圖形界面"
L.General 					= "一般DBM核心選項"
L.EnableMiniMapIcon			= "顯示小地圖圖示"
L.EnableCompartmentIcon		= "顯示整合按鈕"
L.UseSoundChannel			= "設置DBM警告的音效頻道"
L.UseMasterChannel			= "主聲道"
L.UseDialogChannel			= "對話聲道"
L.UseSFXChannel				= "音效聲道"
L.Latency_Text				= "設定最高延遲同步門檻:%d"

L.Button_RangeFrame			= "顯示/隱藏距離監視器"
L.Button_InfoFrame			= "顯示/隱藏訊息框架"
L.Button_TestBars			= "測試計時條"
L.Button_MoveBars			= "移動計時條"
L.Button_ResetInfoRange		= "重置訊息/距離監視器"

L.ModelOptions				= "3D模型預覽選項"
L.EnableModels				= "在首領選項中啟用3D模型預覽"
L.ModelSoundOptions			= "為模型預覽設置聲音"
L.ModelSoundShort			= SHORT
L.ModelSoundLong			= TOAST_DURATION_LONG

L.ResizeOptions			 	= "尺寸調整選項"
L.ResizeInfo				= "您可以通過點擊右下角並拖動來調整GUI的大小。"
L.Button_ResetWindowSize	= "重設GUI視窗大小"
L.Editbox_WindowWidth		= "GUI視窗寬度"
L.Editbox_WindowHeight		= "GUI視窗高度"

L.UIGroupingOptions			= "界面分組選項 (更改這些需要輸入 /reload 來重載界面)"
L.GroupOptionsExcludeIcon	= "按照技能分組排除“設置標記圖示”選項 (它們將一起分類為為自己的“圖示”類別)"
L.AutoExpandSpellGroups		= "按照技能分組自動擴展選項"
L.ShowWAKeys				= "在法術名稱旁顯示WeakAuras鍵來使用首領模組觸發器協助編寫WeakAuras。"
--L.ShowSpellDescWhenExpanded	= "分組擴展時繼續顯示技能描述"
L.NoDescription				= "此技能無描述說明"
L.CustomOptions				= "此類別包含一個技能或事件本身不具有法術或冒險指南ID的自定義選項。 這些選項已使用自定義手動ID組合在一起，以便於創建WA。"

-- Panel: Auto Logging
L.Panel_AutoLogging					= "自動記錄"

--Auto Logging: Logging toggles/types
L.Area_AutoLogging					= "自動記錄切換"
L.AutologBosses						= "自動使用暴雪戰鬥日誌記錄所選內容"
L.AdvancedAutologBosses				= "自動使用Transcriptor紀錄所選內容"
--Auto Logging: Global filter Options
L.Area_AutoLoggingFilters			= "自動記錄過濾"
L.RecordOnlyBosses					= "不記錄小怪的戰鬥 (只記錄首領。請於首領開打前使用 /dbm pull 以獲取數據)"
L.DoNotLogLFG						= "不記錄地城搜尋器或團隊搜尋器 (佇列的內容)"
--Auto Logging: Recorded Content types
L.Area_AutoLoggingContent			= "自動記錄內容"
L.LogCurrentMythicRaids		= "當前等級傳奇團隊副本"--Retail Only
L.LogCurrentRaids			= "當前等級團隊"
L.LogTWRaids				= "時光漫遊 或 克羅米時光團隊副本"--Retail Only
L.LogTrivialRaids			= "低等團隊副本 (低於角色等級)"
L.LogCurrentMPlus			= "當前等級傳奇+地下城"--Retail Only
L.LogCurrentMythicZero		= "當前等級傳奇0層地下城"--Retail Only
L.LogTWDungeons				= "時光漫遊 或 克羅米時光地下城"--Retail Only
L.LogCurrentHeroic			= "當前等級英雄地下城 (注意：如果您通過地城搜尋器佇列英雄並想要記錄，請關閉地城搜尋器過濾)"

-- Panel: Extra Features
L.Panel_ExtraFeatures		= "額外功能"

L.Area_SoundAlerts			= "聲音/閃爍警告選項"
L.LFDEnhance				= "使用主要或對話聲音頻道播放準備確認音效和閃爍應用程式圖示給角色確認和戰場/隨機團隊進場(I.E. 即使音效被關閉了也會發出音效而且很大聲!)"
L.WorldBossNearAlert		= "當你需要的世界首領在你附近開戰播放準備確認音效和閃爍應用程式圖示"
L.RLReadyCheckSound			= "從主要或對話音效頻道播放準備確認音效和閃爍應用程式圖示"
L.AFKHealthWarning			= "播放警告聲音和閃爍應用程式圖示假如你在暫離時被攻擊"
L.AutoReplySound			= "當接收到DBM自動回覆密語時播放警告聲和閃爍應用程式圖示"
--
L.TimerGeneral 				= "計時器選項"
L.SKT_Enabled				= "顯示目前戰鬥的最佳紀錄勝利計時器"
L.ShowRespawn				= "顯示下一次首領重生計時器"
L.ShowQueuePop				= "顯示接受彈出佇列的剩餘時間(尋求組隊、戰場..等)"
L.ShowBerserkWarnings		= "在10/5/3/1分鐘顯示通告並且在 $spell:26662 計時器剩餘30/10秒時"
--
L.Area_3rdParty				= "協力插件選項"
L.oRA3AnnounceConsumables	= "在戰鬥開始時通告oRA3消耗品檢查"
L.Area_Invite				= "邀請選項"
L.AutoAcceptFriendInvite	= "自動接受來自朋友的隊伍邀請"
L.AutoAcceptGuildInvite		= "自動接受來自公會成員的隊伍邀請"
L.Area_Advanced				= "進階選項"
L.FakeBW					= "假裝使用BigWigs版本檢查而不是用DBM版本(適合用在工會強制使用BigWigs時)"
L.AITimer					= "DBM為從未遭遇的戰鬥使用內建的AI計時器來自動生成計時條(在初期Beta或PTR首次遭遇首領時之測試非常有幫助)。注意：這可能不能正確運作在有著相同技能的多重目標上。"

-- Panel: Profiles
L.Panel_Profile				= "配置檔"
L.Area_CreateProfile		= "建立核心選項配置檔"
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

L.Area_ImportExportProfile	= "匯入/匯出 設定檔"
L.ImportExportInfo			= "匯入會覆寫您當前的設定檔，後果請自負。"
L.ButtonImportProfile		= "匯入設定檔"
L.ButtonExportProfile		= "匯出設定檔"

L.ImportErrorOn				= "缺少設置中的自定義聲音: %s"
L.ImportVoiceMissing		= "缺少語音包: %s"

-- Tab: Alerts
L.TabCategory_Alerts	 	= "警告"
L.Area_SpecAnnounceConfig	= "特別警告視覺和聲音指南"
L.Area_SpecAnnounceNotes	= "特別警告註記指南"
L.Area_VoicePackInfo		= "有關DBM語音包的訊息"
-- Panel: Raidwarning
L.Tab_RaidWarning 			= "警告"
L.RaidWarning_Header		= "警告選項"
L.RaidWarnColors 			= "警告顏色"
L.RaidWarnColor_1 			= "顏色1"
L.RaidWarnColor_2 			= "顏色2"
L.RaidWarnColor_3			= "顏色3"
L.RaidWarnColor_4 			= "顏色4"
L.InfoRaidWarning			= [[你可以對團隊警告的顏色及其位置進行設定。
在這裡會顯示例如“玩家X中了Y效果”之類的資訊。]]
L.ColorResetted 			= "該顏色設置已重置"
L.ShowWarningsInChat 		= "在聊天視窗中顯示通告"
L.WarningIconLeft 			= "左側顯示圖示"
L.WarningIconRight 			= "右側顯示圖示"
L.WarningIconChat 			= "在聊天視窗顯示圖示"
L.WarningAlphabetical		= "依字母排序"
L.Warn_Duration				= "警告持續時間：%0.1f秒"
L.None						= "無"
L.Random					= "隨機"
L.Outline					= "描邊"
L.ThickOutline				= "厚描邊"
L.MonochromeOutline			= "單色描邊"
L.MonochromeThickOutline	= "單色加粗描邊"
L.RaidWarnSound				= "在團隊通告時播放音效"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame		= "特別提示"
L.Area_SpecWarn				= "特別提示選項"
L.SpecWarn_ClassColor		= "為特別提示套用職業顏色"
L.ShowSWarningsInChat 		= "在聊天視窗中顯示特別提示"
L.SWarnNameInNote			= "使用特別提示5選項如果自訂註記有包含你的名字"
L.SpecialWarningIcon		= "在特別提示上顯示圖示"
L.ShortTextSpellname		= "使用簡短法術名稱文字(如果可用)"
L.SpecWarn_FlashFrameRepeat	= "閃爍%d次"
L.SpecWarn_Flash			= "閃爍螢幕"
L.SpecWarn_Vibrate			= "震動控制器"
L.SpecWarn_FlashRepeat		= "反覆閃爍"
L.SpecWarn_FlashColor		= "閃爍顏色:%d"
L.SpecWarn_FlashDur			= "閃爍長度:%0.1f"
L.SpecWarn_FlashAlpha		= "閃爍透明度:%0.1f"
L.SpecWarn_DemoButton		= "顯示範例"
L.SpecWarn_ResetMe			= "重置為預設值"
L.SpecialWarnSoundOption	= "設置預設音效"
L.SpecialWarnHeader1		= "類型1: 設置影響您或您的操作的普通優先級提示選擇"
L.SpecialWarnHeader2		= "類型2: 設置影響每個人的一般優先級提示選擇"
L.SpecialWarnHeader3		= "類型3: 設置高優先級提示的選擇"
L.SpecialWarnHeader4		= "類型4: 設置高優先級運行特別提示的選擇"
L.SpecialWarnHeader5		= "類型5: 設置提示選項，並在註釋中包含您的玩家名稱"

-- Panel: Generalwarnings
L.Tab_GeneralMessages 			= "聊天訊息"
L.SelectChatFrameArea			= "聊天視窗選項"
L.SelectChatFrameButton			= "選擇聊天視窗"
L.SelectChatFrameInfoIdle		= "訊息顯示在 %s。"
L.SelectChatFrameDefaultName	= "預設聊天視窗"
L.SelectChatFrameInfoDone		= "訊息將顯示在聊天視窗。"
L.SelectChatFrameInfoSelect		= "點擊一個聊天視窗來選擇它。"
L.SelectChatFrameInfoSelectNow	= "點擊選擇 %s。"
L.CoreMessages					= "核心訊息選項"
L.ShowPizzaMessage 				= "在聊天視窗顯示計時器廣播訊息"
L.ShowAllVersions	 			= "當運行版本檢查時在聊天視窗顯示所有隊伍成員的首領模組版本。(如果停用，依舊顯示過期/目前總結)"
L.ShowReminders					= "顯示有關缺少子模組、禁用子模組、子模組修復、子模組過期以及仍啟用靜音模式的提醒訊息。"

L.CombatMessages			= "戰鬥訊息選項"
L.ShowEngageMessage 		= "在聊天視窗顯示開戰訊息"
L.ShowDefeatMessage 		= "在聊天視窗顯示戰勝/滅團訊息"
L.ShowGuildMessages 		= "在聊天視窗顯示公會的開戰/戰勝/滅團的訊息"
L.ShowGuildMessagesPlus		= "同時也顯示公會史詩鑰石的開戰/戰勝/滅團的訊息(需要團隊選項)"

L.Area_ChatAlerts			= "額外警告選項"
L.RoleSpecAlert				= "當你加入團隊時拾取專精不符合你目前專精顯示警告訊息"
L.CheckGear					= "開怪時顯示裝備警告訊息 (當你裝備的裝備等級低於包包裡40等以上或主手武器沒有裝備時顯示警告訊息)"
L.WorldBossAlert			= "當你的公會成員或是朋友可能在你的伺服器上開戰世界首領時顯示警告訊息(如果發送者是被戰復的會不準確)"
L.WorldBuffAlert			= "當你的伺服器的世界增益啟動時顯示警告訊息以及計時器"

L.Area_BugAlerts			= "錯誤回報警報選項"
L.BadTimerAlert				= "當DBM檢測到計時器錯誤且至少有1秒不正確時顯示聊天訊息"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "語音警告"
L.Area_VoiceSelection		= "語音選擇"
L.CountdownVoice			= "設置主要倒數計時語音"
L.CountdownVoice2			= "設置次要倒數計時語音"
L.CountdownVoice3			= "設置第三倒數計時語音"
L.PullVoice					= "設置開怪計時器的語音"
L.VoicePackChoice			= "設置語音警告的語音包"
L.MissingVoicePack			= "缺少語音包 (%s)"
L.Area_CountdownOptions		= "倒數選項"
L.Area_VoicePackReplace		= "語音包替換選項 (選擇那些語音包要啟用、靜音以及替換)"
L.VPReplaceNote				= "注意: 語音包永遠不會更改或刪除警告聲音。\n當替換語音包時，只是被簡單地靜音。"
L.ReplacesAnnounce			= "替換提示聲音 (注意: 語音包除了階段轉換以及小怪外很少使用)"
L.ReplacesSA1				= "替換特別提示 1 聲音 (個人的 'pvp拔旗' 非地板技能警告)"
L.ReplacesSA2				= "替換特別提示 2 聲音 (每個人 '當心')"
L.ReplacesSA3				= "替換特別提示 3 聲音 (高優先級的 'airhorn')"
L.ReplacesSA4				= "替換特別提示 4 聲音 (高優先級的 '快跑')"
L.ReplacesGTFO				= "替換特別提示 地板技能警告 聲音"
L.ReplacesCustom			= "替換特別提示 自定義使用者設置 (每個警告)(不建議)"
L.Area_VoicePackAdvOptions	= "語音包進階選項"
L.SpecWarn_AlwaysVoice		= "總是播放所有語音警告 (即使已禁用特別警告，對團隊領隊是有用的，除此之外不建議使用)"
L.VPDontMuteSounds			= "當使用語音包時禁用常規警報的靜音 (只有當您希望在警報期間同時聽到兩者時才使用)"
L.Area_VPLearnMore          = "了解更多關於語音包以及如何使用這些選項的訊息"
L.VPLearnMore               = "|cFF73C2FBhttps://github.com/DeadlyBossMods/DBM-Retail/wiki/%5BGuide%5D-DBM-&-Voicepacks#2022-update|r"
L.Area_BrowseOtherVP		= "在Curse上瀏覽其他語言包"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "在Curse上瀏覽倒數包"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://www.curseforge.com/wow/addons/search?search=dbm+count+pack|r"

-- Panel: Event Sounds
L.Panel_EventSounds				= "事件音效 (勝利、滅團..等等)"
L.Area_SoundSelection			= "音效選擇，包含勝利、滅團、開怪以及背景音樂"
L.EventVictorySound				= "設定戰鬥勝利時的音效"
L.EventWipeSound				= "設定滅團或重置時的音效"
L.EventEngagePT					= "設定開怪倒數開始的音效"
L.EventEngageSound				= "設定戰鬥開戰時的音效"
L.EventDungeonMusic				= "設定在地城/團隊中播放的音樂"
L.EventEngageMusic				= "設置戰鬥期間播放的音樂"
L.Area_EventSoundsExtras		= "事件音效選項"
L.EventMusicCombined			= "允許在地城和戰鬥選擇的所有音效選項（更改此選項需要UI重載以生效）"
L.Area_EventSoundsFilters		= "事件音效過濾條件"
L.EventFilterDungMythicMusic	= "不要在傳奇/傳奇+難度播放地城音樂"
L.EventFilterMythicMusic		= "不要在傳奇/傳奇+難度播放戰鬥音樂"

-- Tab: Timers
L.TabCategory_Timers		= "計時條"
L.Area_ColorBytype			= "計時條分類著色指南"
-- Panel: Color by Type
L.Panel_ColorByType	 		= "計時條顏色"
L.AreaTitle_BarColors		= "一般計時條顏色 (預設根據技能類型分配)"
L.AreaTitle_ImpBarColors	= "重要計時條顏色 (對使用者重要的計時條)"
L.BarTexture 				= "計時條材質"
L.BarStyle					= "計時條動作"
L.BarDBM					= "經典 (現有的小計時條滑到大條的錨點)"
L.BarSimple					= "簡單 (小計時條消失，創建新的大計時條)"
L.BarStartColor				= "開始顏色"
L.BarEndColor 				= "結束顏色"
L.Bar_Height				= "計時條高度:%d"
L.Slider_BarOffSetX 		= "X偏移:%d"
L.Slider_BarOffSetY 		= "Y偏移:%d"
L.Slider_BarWidth 			= "寬度:%d"
L.Slider_BarScale 			= "尺寸:%0.2f"
L.BarSaturation				= "小型計時條的飽和度 (當大計時條被停用時): %0.2f"

--Types
L.BarStartColorAdd			= "開始顏色1 (小怪)"
L.BarEndColorAdd			= "結束顏色1 (小怪)"
L.BarStartColorAOE			= "開始顏色2 (AOE)"
L.BarEndColorAOE			= "結束顏色2 (AOE)"
L.BarStartColorDebuff		= "開始顏色3 (點名技能)"
L.BarEndColorDebuff			= "結束顏色3 (點名技能)"
L.BarStartColorInterrupt	= "開始顏色4 (中斷)"
L.BarEndColorInterrupt		= "結束顏色4 (中斷)"
L.BarStartColorRole			= "開始顏色5 (角色)"
L.BarEndColorRole			= "結束顏色5 (角色)"
L.BarStartColorPhase		= "開始顏色6 (階段轉換)"
L.BarEndColorPhase			= "結束顏色6 (階段轉換)"
L.BarStartColorUI			= "開始顏色7 (重要)"
L.BarEndColorUI				= "結束顏色7 (重要)"
L.BarStartColorI2			= "開始顏色8 (重要)"
L.BarEndColorI2				= "結束顏色8 (重要)"
--Type 7 options
L.Bar7Header				= "重要計時條選項"
L.Bar7ForceLarge			= "總是使用大計時條"
L.Bar7CustomInline			= "使用自訂的'!'內嵌圖示"
--Timer Example Texts
L.CBTGeneric				= "一般"
L.CBTAdd					= "小怪到來"
L.CBTAOE					= "AOE法術"
L.CBTTargeted				= "點名技能法術"
L.CBTInterrupt				= "可中斷法術"
L.CBTRole					= "角色類型法術"
L.CBTPhase					= "階段轉換"
L.CBTImportant				= "使用者重要法術"
--Dropdown Options
L.SAOne						= "通用音效 1 (個人)"
L.SATwo						= "通用音效 2 (全部人)"
L.SAThree					= "通用音效 3 (高優先動作)"
L.SAFour					= "通用音效 4 (高優先跑開)"
L.ColorDropGeneric			= "通用 (原始)"
L.ColorDrop1				= "顏色 1"
L.ColorDrop2				= "顏色 2"
L.ColorDrop3				= "顏色 3"
L.ColorDrop4				= "顏色 4"
L.ColorDrop5				= "顏色 5"
L.ColorDrop6				= "顏色 6"
L.CDDImportant1				= "重要 1"
L.CDDImportant2				= "重要 2"
L.CVoiceOne					= "倒數語音 1"
L.CVoiceTwo					= "倒數語音 2"
L.CVoiceThree				= "倒數語音 3"

-- Panel: Bar Appearance
L.Panel_Appearance	 		= "計時條外觀"
L.Panel_Behavior	 		= "計時條動作"
L.AreaTitle_BarSetup		= "計時條外觀選項"
L.AreaTitle_Behavior		= "計時條動作選項"
L.AreaTitle_BarSetupSmall 	= "小型計時條設置"
L.AreaTitle_BarSetupHuge	= "大型計時條設置"
L.EnableHugeBar 			= "開啟大型計時條(2號計時條)"
L.BarIconLeft 				= "左側顯示圖示"
L.BarIconRight 				= "右側顯示圖示"
L.ExpandUpwards				= "計時條向上延伸"
L.FillUpBars				= "填滿計時條"
L.ClickThrough				= "禁用鼠標事件(允許你點擊穿透計時條)"
L.Bar_Decimal				= "%d秒以下顯示小數點"
L.Bar_Alpha					= "透明度: %0.1f"
L.Bar_EnlargeTime			= "計時條時間低於: %d時放大"
L.BarSpark					= "計時條閃光"
L.BarFlash					= "快結束時閃爍計時條"
L.BarSort					= "依剩餘時間排序"
L.BarColorByType			= "根據類型上色"
L.Highest					= "頂部最高"
L.Lowest					= "頂部最低"
L.NoBarFade					= "使用開始/結束顏色作為小型/大型顏色，而不是逐漸改變顏色"
L.BarInlineIcons			= "顯示嵌入圖示"
L.DisableRightClickBar		= "停用右鍵點擊來取消計時器"
L.ShortTimerText			= "使用較短的計時器文字(如果可用時)"
L.KeepBar					= "保持計時器啟用直到技能施放"
L.KeepBar2					= "(當有支援的模組時)"
L.FadeBar					= "隱藏已超出距離技能的計時器"
L.BarSkin					= "計時條外觀"

-- Panel: Pull, Break, Combat
L.Panel_PullBreakCombat			= "開怪 & 休息"

L.Area_SoundOptions				= "聲音選項"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 	= "全局禁用及過濾"
L.Area_DBMFiltersSetup		= "DBM過濾器指南"
L.Area_BlizzFiltersSetup	= "暴雪過濾器指南"

-- Panel: Toggle DBM Features
L.Panel_SpamFilter					= "停用DBM功能"

L.Area_SpamFilter_SpecFeatures		= "通告功能"
L.SpamBlockNoShowAnnounce			= "不顯示任何一般（非強調）通告提示文字或播放警告音效"
L.SpamBlockNoSpecWarnText			= "不顯示特別提示文字"
L.SpamBlockNoSpecWarnFlash			= "特別提示時不閃爍螢幕"
L.SpamBlockNoSpecWarnVibrate		= "特別提示時不震動控制器"
L.SpamBlockNoSpecWarnSound			= "不播放特別提示音效 (在倒數與語音包面板中啟用的語音仍會播放)"
L.SpamBlockNoPrivateAuraSound		= "不登記私人光環音效"

L.Area_SpamFilter_Timers			= "全局計時禁用及過濾選項"
L.SpamBlockNoShowBossTimers			= "不顯示地城/團隊首領的計時器"
L.SpamBlockNoShowTrashTimers		= "不顯示地城/團隊小怪的計時器(注意: 這也會停用名條的技能冷卻)"
L.SpamBlockNoShowEventTimers		= "不顯示事件與提示計時器(佇列提示/首領重生..等)"
L.SpamBlockNoShowUTimers			= "不顯示玩家送出的計時器(自訂/拉怪/休息)"
L.SpamBlockNoCountdowns				= "不播放倒數音效"

L.Area_SpamFilter_Nameplates		= "名條通用禁止 & 過濾選項"
L.SpamBlockNoNameplate				= "不要顯示名條光環"
L.SpamBlockNoNameplateCD			= "不要顯示技能冷卻計時的名條圖示"
L.SpamBlockNoBossGUIDs				= "不要在plater名條上顯示主要首領(首領1)計時器作為名條光環\n(如果在Plater中啟用了功能，您仍然會看到小怪/首領計時器）"

L.Area_SpamFilter_Misc				= "全局其他禁用及過濾選項"
L.SpamBlockNoSetIcon				= "不設置標記在目標上"
L.SpamBlockNoRangeFrame				= "不顯示距離框架"
L.SpamBlockNoInfoFrame				= "不顯示訊息框架"
L.SpamBlockNoHudMap					= "不要顯示HudMap"
L.SpamBlockNoYells					= "不送出大喊至頻道"
L.SpamBlockNoNoteSync				= "不接受註記分享"
L.SpamBlockAutoGossip				= "不要自動處理對話內容"

L.Area_Restore						= "DBM還原選項(DBM是否還原至使用者過去狀態)"
L.SpamBlockNoIconRestore			= "不在戰鬥結束後記住和還原團隊圖示狀態"
L.SpamBlockNoRangeRestore			= "不因模組預設值還原距離框架的狀態"

L.Area_PullTimer					= "開怪、休息、戰鬥和自定義計時器過濾器選項"
L.DontShowPTNoID					= "阻擋與你不同區域ID送出的開怪倒數計時條(永遠不會阻擋在沒有區域ID的情況下發送的Bigwigs計時器)"
L.DontShowPT						= "不要顯示開怪/休息倒數計時條"
L.DontShowPTText					= "不要顯示開怪/休息計時提示文字"
L.DontPlayPTCountdown				= "完全不要播放開怪/休息/開戰/自訂計時器倒數音效"
L.PT_Threshold						= "不要播放高於%d秒以上的休息/開戰/自訂倒數計時器音效"

-- Panel: Reduce Information
L.Panel_ReducedInformation			= "減少訊息"

L.Area_SpamFilter_Anounces			= "全局警告禁用及過濾選項"
L.SpamBlockNoShowTgtAnnounce		= "不顯示目標的提示文字或播放警告音效 (上列選項會覆蓋此選項)"
L.SpamBlockNoTrivialSpecWarnSound	= "如果相對你等級是不重要的內容則不要播放特別提示音效 (播放使用者選擇的標準提示音效替代)"

L.Area_SpamFilter					= "垃圾過濾選項"
L.DontShowFarWarnings				= "不發送距離過遠的事件提示/計時器"
L.StripServerName					= "隱藏警告、計時器、距離檢測以及資訊框架的玩家伺服器名稱"
L.FilterVoidFormSay2					= "在虛空型態時不要發送圖示/倒數計時聊天喊話(仍會發送標準聊天喊話)"

L.Area_SpecFilter					= "角色職責過濾選項"
L.FilterTankSpec					= "非坦克角色職責時過濾掉坦克專精的特定警告 (註:不建議玩家關閉此選項因大多數的坦克嘲諷警告都是預設開啟。)"
L.FilterDispels						= "如果你的驅散技能正在冷卻中，過濾可驅散技能"
L.FilterCrowdControl				= "如果你的控場技能正在冷卻中，過濾基於打斷的控場通告"
L.FilterTrashWarnings				= "過濾所有小怪警告在普通與英雄以及過往版本的地城"

L.Area_BInterruptFilter				= "首領打斷過濾選項"
L.FilterTargetFocus					= "過濾如果施法者不是你的目標/專注目標"
L.FilterInterruptCooldown			= "過濾如果打斷技能正在冷卻中"
L.FilterInterruptHealer				= "過濾如果你不是治療專精"
L.FilterInterruptNoteName			= "過濾如果警告有計數，但自訂註記警告沒有包含你的名字"--Only used on bosses, trash mods don't assign counts
L.Area_BInterruptFilterFooter		= "如果未勾選過濾選項，所有打斷都將顯示(可能會有點刷屏)\n如果法術至關重要，有些模組可能會完全忽略這些過濾器"
L.Area_TInterruptFilter				= "小怪打斷過濾選項"--Reuses above 3 strings

-- Panel: DBM Handholding
L.Panel_HandFilter					= "減少DBM的控制"
L.Area_SpamFilter_SpecRoleFilters	= "特別警告類型過濾 (控制DBM要怎麼做)"
L.SpamSpecInformationalOnly			= "更改所有特別警告的說明文字/語音警告 (需要UI重載)。警報仍顯示和播放聲音，但將是通用和非指示性"
L.SpamSpecRoleDispel				= "徹底過濾'驅散'警告 (完全無文字或聲音)"
L.SpamSpecRoleInterrupt				= "過濾'打斷'警告 (完全無文字或聲音)"
L.SpamSpecRoleDefensive				= "過濾'減傷'警告 (完全無文字或聲音)"
L.SpamSpecRoleTaunt					= "過濾'嘲諷'警告 (完全無文字或聲音)"
L.SpamSpecRoleSoak					= "過濾'分擔'警告 (完全無文字或聲音)"
L.SpamSpecRoleStack					= "過濾'高層數'警告 (完全無文字或聲音)"
L.SpamSpecRoleSwitch				= "過濾'切換目標''小怪' 警報 (完全無文字或聲音)"
L.SpamSpecRoleGTFO					= "過濾'地板技能'警告 (完全無文字或聲音)"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "阻擋暴雪功能"
--Toast
L.Area_HideToast					= "停用暴雪彈出提示 (跳出提醒)"
L.HideGarrisonUpdates				= "首領戰鬥時隱藏追隨者彈出提示"
L.HideGuildChallengeUpdates			= "首領戰鬥時隱藏公會挑戰彈出提示"
--L.HideBossKill					= "Hide boss kill toasts"--NYI
--L.HideVaultUnlock					= "Hide vault unlock toasts"--NYI
--Cut Scenes
L.Area_Cinematics					= "阻擋遊戲中的動畫"
L.DuringFight						= "首領戰鬥時阻擋戰鬥過場動畫"--uses explicite IsEncounterInProgress check
L.InstanceAnywhere					= "在地下城或團隊副本中的任何地方阻擋非戰鬥過場動畫"
L.NonInstanceAnywhere				= "危險: 在室外開放世界阻擋過場動畫 (不建議)"
L.OnlyAfterSeen						= "只有阻擋過場動畫，至少播放一次之後您選擇阻擋 (至少體驗一次劇情，強烈建議此選項)"
--Sound
L.Area_Sound						= "阻擋遊戲中聲音"
L.DisableSFX						= "首領戰鬥時停用音效頻道"
L.DisableAmbiance					= "首領戰鬥時停用環境頻道"
L.DisableMusic						= "首領戰鬥時停用音樂頻道 (注意: 如果啟用，在事件音效中啟用的自訂音樂將不會播放)"
--Other
L.Area_HideBlizzard					= "停用 & 隱藏其他暴雪提示"
L.HideBossEmoteFrame				= "首領戰鬥時隱藏團隊首領表情框架"
L.HideWatchFrame					= "首領戰鬥時隱追蹤框架(任務目標)，如果沒有追踪成就，或不是在傳奇+中"
L.HideQuestTooltips					= "首領戰鬥時隱藏任務目標提示"--Currently hidden (NYI)
L.HideTooltips						= "首領戰鬥時隱藏完全隱藏提示"

-- Panel: Raid Leader Controls
L.Tab_RLControls					= "團隊領隊控制項"
L.Area_FeatureOverrides				= "功能覆蓋選項"
L.OverrideIcons 					= "禁用團隊中所有玩家的圖示標記，包括我自己" --(如果您希望DBM按您的原則進行標記，請使用覆蓋而不是禁用)
L.OverrideSay						= "禁用團隊中所有玩家的聊天泡泡/說訊息，包含我自己"
L.DisableStatusWhisperShort			= "禁用整個團隊的狀態/回覆密語"--Duplicated from privacy but makes sense to include option in both panels
L.DisableGuildStatusShort			= "禁用整個團隊同步到公會的進度訊息"--Duplicated from privacy but makes sense to include option in both panels
--L.DisabledForDropdown				= "Choose boss mod(s) disable is sent to"--NYI
--L.DiabledForBoth					= "Disable above features for both DBM and BW"--NYI
--L.DiabledForDBM					= "Disable above features for only DBM users"--NYI
--L.DiabledForBW					= "Disable above features for only BW users"--NYI

L.Area_ConfigOverrides				= "設定覆蓋選項 (施工中, 稍後完成)"--NYI
L.OverrideBossAnnounceOptions		= "將所有DBM玩家的通告配置設定為我的配置"--NYI
L.OverrideBossTimerOptions			= "將所有DBM玩家的計時器配置設定為我的配置"--NYI
L.OverrideBossIconOptions			= "將所有DBM玩家的圖示配置設定為我的配置 (如果在上述選項中禁用圖示設置，則忽略此選項)"--NYI
L.OverrideBossSayOptions			= "將所有DBM玩家的聊天泡泡配置設定為我的配置 (如果在上述選項中禁用聊天泡泡設置，則忽略此選項)"--NYI
L.ConfigAreaFooter					= "該區域的選項僅臨時干涉覆蓋玩家的配置，而沒有更改其保存的配置。"
L.ConfigAreaFooter2					= "建議考慮所有角色職責，並且不排除計時器/警報..等等，可能需要"

L.Area_receivingOptions				= "接收選項 (施工中, 稍後完成)"--NYI
L.NoAnnounceOverride				= "不要接收團隊領隊的通告覆蓋。"--NYI
L.NoTimerOverridee					= "不要接收團隊領隊的計時器覆蓋。"--NYI
L.ReplaceMyConfigOnOverride			= "警告：在覆蓋上永久使用團隊領隊的替換我的配置"--NYI
L.ReceivingFooter					= "圖示和聊天泡泡選項無法選擇覆蓋，因為這些設置會影響您周圍的其他玩家"--NYI
L.ReceivingFooter2					= "如果您啟用這些選項，則在您和領隊之間，您的配置可能會與其意圖衝突"--NYI
L.ReceivingFooter3					= "如果您啟用了 '替換我的配置' 您的原始設置將在覆蓋後丟失"--NYI

L.TabFooter							= "本面板中的所有選項僅在您是非地下城/隨機隊伍中的隊伍領隊的情況下運作"

-- Panel: Privacy
L.Tab_Privacy 				= "隱私控制"
L.Area_WhisperMessages		= "密語訊息選項"
L.AutoRespond 				= "啟用戰鬥中自動密語回覆"
L.WhisperStats 				= "在密語回應中加入戰勝/滅團狀態"
L.DisableStatusWhisper 		= "停用整個團隊的狀態密語(需要為團隊領隊)。只適用於普通/英雄/傳奇難度與傳奇＋地城"
L.Area_SyncMessages			= "插件同步選項"
L.DisableGuildStatus 		= "停用進度訊息同步到公會(如果為領隊，整個隊伍都會禁用。)"
L.EnableWBSharing 			= "當同個伺服器的公會與戰網好友開怪/擊敗世界首領時共享訊息。"

-- Tab: Frames & Integrations
L.TabCategory_Frames		= "框架 & 整合"
L.Area_NamelateInfo			= "DBM名條光環資訊"
-- Panel: InfoFrame
L.Panel_InfoFrame			= "訊息框架"

-- Panel: Range
L.Panel_Range				= "距離框架"

-- Panel: Nameplate
L.Panel_Nameplates			= "名條"
L.Area_NPStyle				= "風格 (注意：僅在DBM處理名條時配置風格。)"
L.NPAuraText				= "在名條圖示上顯示計時文字"
L.NPAuraSize				= "光環像素大小 (平方): %d"
L.NPIcon_BarOffSetX 		= "圖示水平偏移：%d"
L.NPIcon_BarOffSetY 		= "圖示垂直偏移：%d"
L.NPIcon_GrowthDirection 	= "圖示增長方向"
L.NPIcon_Spacing		 	= "圖示間距: %d"
L.NPIcon_MaxTextLen		 	= "最大文字長度: %d"
L.NPIconAnchorPoint		 	= "圖示定位點"
L.NPDemo					= "測試 (靠近名條)"
L.FontTypeTimer				= "選擇計時器字體"
L.FontTypeText				= "選擇文字字體"

-- Misc
L.Area_General				= "一般"
L.Area_Position				= "位置"
L.Area_Style				= "風格"

L.FontSize					= "字型大小:%d"
L.FontStyle					= "字型風格"
L.FontColor					= "文字顏色"
L.FontShadow				= "陰影"
L.FontType					= "選擇字型"

L.FontHeight	= 16
