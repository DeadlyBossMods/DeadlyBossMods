--if GetLocale() ~= "enUS" and GetLocale() ~= "enGB" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations

-- BossMod studio
L.TabCategory_BossModStudio = "Boss Mod Studio"
L.TabCategory_Triggers = "Triggers and Events"
L.AreaHead_CreateBossMod = "Main Informations of this new BossMod"
L.BossName = "Name of the BossMod - like 'Hogger'"
L.BossID = "Creature ID"
L.BossLookup = "Take ID from Target"

L.AreaHead_Pull = "Pull / Combat Detection"
L.CombatFromYell = "Combat starts with a Yell"
L.CombatAutoDetect = "Automatic Combat Detection"
L.BossPullYell = "what does the Boss yell on pull"
L.BossEnrages = "boss enrage"
L.BossEnrageBar = "Show Enrage Bar"
L.BossEnrageAnnounce = "Announce Enrage to Raid"

L.Min = "Min"
L.Sec = "Sec"

L.AreaHead_TriggerCreate = "Create an Boss Event Trigger"
L.Describe_TriggerCreate = [[Triggers can be created to handle events in bossfights. If the Boss yell some stuff or use one of his abilitys you need to catch and use them. As an example, the boss gains Shieldwall and you want to start a Bar when this occur, you simply have to choose BossBuffs or Debuffs and type in an Name for this event like "Shieldwall"]]

L.Trigger_Typ = "Event that shall be triggered"
L.Trigger_Name = "Name of this Trigger (a description)"
L.Trigger_Typ_Spell = "Spell or Style"
L.Trigger_Typ_Buff = "Buff or Debuff"
L.Trigger_Typ_Yell = "Yell or Emote"
L.Trigger_Typ_Time = "Time based"
L.Trigger_Typ_Hp = "HitPoint Based"
L.Trigger_Create_Bttn = "create trigger"
L.Trigger_Delete_Bttn = "delete trigger"

L.EventYellText = "Yell/Say/Emote that shall call the Event"
L.EventTimeBased = "Trigger after X seconds"
L.EventHpBased = "Trigger on X percent HitPoints"
L.EventSpellID = "Spell ID"
L.EventAnnounce = "Announce"
L.EventAnnounceText = "Message to announce"
L.EventSpecialWarn = "Show Special Warning"
L.EventSpecialWarn_OnlyMe = "only if affects me"
L.EventStartBar = "Start a timer Bar"
L.EventWarnEnd = "Show warning before timer ends"
L.EventWarnMsg = "Warning Message"
L.EventSetIcon = "Set Icon on Target (on yells %t of text)"