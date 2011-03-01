if GetLocale() ~= "zhTW" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations

-- BossMod studio
L.TabCategory_BossModStudio = "首領模組生成器"
L.TabCategory_Triggers = "觸發條件與事件"
L.AreaHead_CreateBossMod = "該新模組的主要資訊"
L.BossName = "模組名，比如“霍格”"
L.BossID = "NPC ID"
L.BossLookup = "獲取當前目標的NPC ID"

L.AreaHead_Pull = "戰鬥開始偵測條件"
L.CombatFromYell = "戰鬥開始時有喊話"
L.CombatAutoDetect = "自動進行偵測"
L.BossPullYell = "在戰鬥開始時首領喊了些什麼"
L.BossEnrages = "首領狂怒"
L.BossEnrageBar = "顯示狂怒計時"
L.BossEnrageAnnounce = "向團隊發出狂怒警報"

L.Min = "分"
L.Sec = "秒"

L.AreaHead_TriggerCreate = "創建一個事件觸發器"
L.Describe_TriggerCreate = [[觸發器可以用來處理戰鬥中的事件。如果首領喊了什麼話或是用了什麼技能，你需要對其進行一些記錄。例如，首領獲得了盾牆效果，而你想要當該事件發生時開始一個計時的話，你只需要選擇增益或減益效果冰輸入該事件的名稱，如“盾牆”。]]

L.Trigger_Typ = "將要觸發的事件"
L.Trigger_Name = "該觸發器名稱（作為說明）"
L.Trigger_Typ_Spell = "法術或樣式"
L.Trigger_Typ_Buff = "增益或減益效果"
L.Trigger_Typ_Yell = "喊話或表情資訊"
L.Trigger_Typ_Time = "基於時間"
L.Trigger_Typ_Hp = "基於生命百分比"
L.Trigger_Create_Bttn = "創建觸發器"
L.Trigger_Delete_Bttn = "刪除觸發器"

L.EventYellText = "可以觸發該事件的大喊、說或表情文本"
L.EventTimeBased = "在X秒後觸發事件"
L.EventHpBased = "在X%生命值時觸發時間"
L.EventSpellID = "法術ID"
L.EventAnnounce = "警報"
L.EventAnnounceText = "警報文本"
L.EventSpecialWarn = "顯示特殊警報"
L.EventSpecialWarn_OnlyMe = "（僅當影響我自己時）"
L.EventStartBar = "創建一個計時條"
L.EventWarnEnd = "在倒計時結束前進行警報"
L.EventWarnMsg = "警報文本"
L.EventSetIcon = "對目標添加標記"


