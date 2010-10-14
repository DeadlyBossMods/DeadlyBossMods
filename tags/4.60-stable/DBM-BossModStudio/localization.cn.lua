-- Simplified Chinese by Diablohu
-- http://wow.gamespot.com.cn
-- Last Update: 12/13/2008


if GetLocale() ~= "zhCN" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations

-- BossMod studio
L.TabCategory_BossModStudio = "首领模块生成器"
L.TabCategory_Triggers = "触发条件与事件"
L.AreaHead_CreateBossMod = "该新模块的主要信息"
L.BossName = "模块名，比如“霍格”"
L.BossID = "NPC ID"
L.BossLookup = "获取当前目标的NPC ID"

L.AreaHead_Pull = "战斗开始侦测条件"
L.CombatFromYell = "战斗开始时有喊话"
L.CombatAutoDetect = "自动进行侦测"
L.BossPullYell = "在战斗开始时首领喊了些什么"
L.BossEnrages = "首领激怒"
L.BossEnrageBar = "显示激怒计时"
L.BossEnrageAnnounce = "向团队发出激怒警报"

L.Min = "分"
L.Sec = "秒"

L.AreaHead_TriggerCreate = "创建一个事件触发器"
L.Describe_TriggerCreate = [[触发器可以用来处理战斗中的事件。如果首领喊了什么话或是用了什么技能，你需要对其进行一些记录。例如，首领获得了盾墙效果，而你想要当该事件发生时开始一个计时的话，你只需要选择增益或减益效果冰输入该事件的名称，如“盾墙”。]]

L.Trigger_Typ = "将要触发的事件"
L.Trigger_Name = "该触发器名称（作为说明）"
L.Trigger_Typ_Spell = "法术或样式"
L.Trigger_Typ_Buff = "增益或减益效果"
L.Trigger_Typ_Yell = "喊话或表情信息"
L.Trigger_Typ_Time = "基于时间"
L.Trigger_Typ_Hp = "基于生命百分比"
L.Trigger_Create_Bttn = "创建触发器"
L.Trigger_Delete_Bttn = "删除触发器"

L.EventYellText = "可以触发该事件的大喊、说或表情文本"
L.EventTimeBased = "在X秒后触发事件"
L.EventHpBased = "在X%生命值时触发时间"
L.EventSpellID = "法术ID"
L.EventAnnounce = "警报"
L.EventAnnounceText = "警报文本"
L.EventSpecialWarn = "显示特殊警报"
L.EventSpecialWarn_OnlyMe = "（仅当影响我自己时）"
L.EventStartBar = "创建一个计时条"
L.EventWarnEnd = "在倒计时结束前进行警报"
L.EventWarnMsg = "警报文本"
L.EventSetIcon = "对目标添加标记"


