if GetLocale() ~= "zhTW" then return end
if not DBM_GUI_Translations then DBM_GUI_Translations = {} end

local L = DBM_GUI_Translations

L.MainFrame 			= "Deadly Boss Mods"

L.TranslationBy 		= "Nightkiller@日落沼澤(kc10577)"

L.TabCategory_Options 		= "綜合設置"
L.TabCategory_WOTLK 		= "巫妖王之怒"
L.TabCategory_BC 		= "燃燒的遠征"
L.TabCategory_CLASSIC 		= "舊世界"
L.TabCategory_OTHER     	= "其它"

L.BossModLoaded 		= "%s狀態"
L.BossModLoad_now 		= [[該模組尚未啟動。
當你進入相應副本時其會自動載入。
你也可以點擊該按鈕手動啟動該模組。]]

L.PosX 				= 'X座標'
L.PosY 				= 'Y座標'

L.MoveMe 			= '移動'
L.Button_OK 			= '確定'
L.Button_Cancel 		= '取消'
L.Button_LoadMod 		= '載入模組'
L.Mod_Enabled			= "開啟模組"
L.Mod_EnableAnnounce		= "團隊廣播"
L.Reset 			= "重置"

L.Enable  			= "開啟"
L.Disable			= "關閉"

L.NoSound			= "靜音"

L.IconsInUse			= "此模組已使用的標記"

-- Tab: Boss Statistics
L.BossStatistics		= "首領狀態"
L.Statistic_Kills		= "擊殺："
L.Statistic_Wipes		= "失敗："
L.Statistic_BestKill		= "最好成績："
L.Statistic_Heroic		= "英雄模式"

-- Tab: General Options
L.General 			= "DBM綜合設置"
L.EnableDBM 			= "啟用DBM"
L.EnableStatus 			= "回復“status”密語"
L.EnableSpamBlock		= "過濾<DBM>BossWhispers"
L.AutoRespond 			= "開啟戰鬥中自動密語回復"
L.EnableMiniMapIcon		= "顯示小地圖圖示"

L.Button_RangeFrame		= "顯示/隱藏距離監視器"
L.Button_TestBars		= "測試計時條"

L.PizzaTimer_Headline 		= '創建一個計時條'
L.PizzaTimer_Title		= '名稱（如“Pizza計時器”）'
L.PizzaTimer_Hours 		= "小時"
L.PizzaTimer_Mins 		= "分鐘"
L.PizzaTimer_Secs 		= "秒"
L.PizzaTimer_ButtonStart 	= "開始計時"
L.PizzaTimer_BroadCast		= "向團隊廣播"

-- Tab: Raidwarning
L.Tab_RaidWarning 		= "團隊警告"
L.RaidWarnColors 		= "團隊警告顏色"
L.RaidWarnColor_1 		= "顏色1"
L.RaidWarnColor_2 		= "顏色2"
L.RaidWarnColor_3 		= "顏色3"
L.RaidWarnColor_4 		= "顏色4"
L.InfoRaidWarning		= [[你可以對團隊警報的顏色及其位置進行設定。
在這裡會顯示例如“玩家X受到了Y效果的影響”之類的資訊。]]
L.ColorResetted 		= "該顏色設置已重置"
L.ShowWarningsInChat 		= "在聊天視窗中顯示警報"
L.ShowFakedRaidWarnings 	= "以偽裝團隊警告資訊的方式顯示警告內容"
L.WarningIconLeft 		= "左側顯示圖示"
L.WarningIconRight 		= "右側顯示圖示"
L.RaidWarnMessage 		= "感謝您使用Deadly Boss Mods"
L.BarWhileMove 			= "團隊警告可以移動"
L.RaidWarnSound			= "發出團隊警告時播放聲音"
L.SpecialWarnSound		= "發出特別警告時播放聲音"

-- Tab: Barsetup
L.BarSetup   			= "計時條樣式"
L.BarTexture 			= "計時條材質"
L.BarStartColor 		= "開始顏色"
L.BarEndColor 			= "完結顏色"
L.ExpandUpwards			= "計時條向上延伸"
L.Bar_Font			= "計時條使用的字型"
L.Bar_FontSize			= "字型大小"
L.Slider_BarOffSetX 		= "X偏移"
L.Slider_BarOffSetY 		= "Y偏移"
L.Slider_BarWidth 		= "寬度"
L.Slider_BarScale 		= "尺寸"
L.AreaTitle_BarSetup 		= "計時條綜合設置"
L.AreaTitle_BarSetupSmall 	= "小型計時條設置"
L.AreaTitle_BarSetupHuge 	= "大型計時條設置"
L.BarIconLeft 			= "左側顯示圖示"
L.BarIconRight 			= "右側顯示圖示"
L.EnableHugeBar 		= "開啟大型計時條（2號計時條）"
L.FillUpBars			= "填滿計時條"
L.ClickThrough			= "禁用鼠標事件（允許你點擊穿透計時條）"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "特別警告"
L.Area_SpecWarn			= "配置特別警告"
L.SpecWarn_Enabled		= "為首領的技能顯示特別警告"
L.SpecWarn_Font			= "特別警告使用的字型"
L.SpecWarn_DemoButton		= "顯示範例"
L.SpecWarn_MoveMe		= "設定位置"
L.SpecWarn_FontSize		= "字型大小"
L.SpecWarn_FontColor		= "字型顏色"
L.SpecWarn_FontType		= "選擇字型"
L.SpecWarn_ResetMe		= "回復原廠設定值"

-- Tab: HealthFrame
L.Panel_HPFrame			= "血量框架"
L.Area_HPFrame			= "配置血量框架"
L.HP_Enabled			= "永久顯示血量框架 (覆蓋首領模組的選項)"
L.HP_GrowUpwards		= "血量框架向上延伸"
L.HP_ShowDemo			= "顯示血量框架"
L.BarWidth			= "寬度: %d"


-- Tab: Spam Filter
L.Panel_SpamFilter		= "垃圾過濾"
L.Area_SpamFilter		= "基本垃圾過濾設定"
L.HideBossEmoteFrame		= "隱藏團隊首領表情框"
L.SpamBlockRaidWarning		= "過濾其他首領模組的通告" 
L.SpamBlockBossWhispers		= "當戰鬥時過濾 <DBM> 密語警告"
L.BlockVersionUpdatePopup	= "關閉彈出的更新通知"
L.ShowBigBrotherOnCombatStart	= "戰鬥開始時顯示BigBrother(檢查團隊 增益/精煉UI)"