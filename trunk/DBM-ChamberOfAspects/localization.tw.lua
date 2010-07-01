if GetLocale() ~= "zhTW" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name 			= "夏德朗"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name 			= "坦納伯朗"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name 			= "維斯佩朗"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name 			= "『黑曜守護者』撒爾薩里安"
})

L:SetWarningLocalization({
	WarningTenebron		= "坦納伯朗到來",
	WarningShadron		= "夏德朗到來",
	WarningVesperon		= "維斯佩朗到來",
	WarningFireWall		= "火焰障壁",
	WarningVesperonPortal	= "維斯佩朗的傳送門",
	WarningTenebronPortal	= "坦納伯朗的傳送門",
	WarningShadronPortal	= "夏德朗的傳送門",
})

L:SetTimerLocalization({
	TimerTenebron		= "坦納伯朗到來",
	TimerShadron		= "夏德朗到來",
	TimerVesperon		= "維斯佩朗到來"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "為火焰障壁播放音效",
	AnnounceFails		= "公佈踩中暗影裂縫和撞上火焰障壁的玩家到團隊頻道 (需要團隊隊長或助理權限)",
	TimerTenebron		= "為坦納伯朗到來顯示計時器",
	TimerShadron		= "為夏德朗到來顯示計時器",
	TimerVesperon		= "為維斯佩朗到來顯示計時器",
	WarningFireWall		= "為火焰障壁顯示特別警告",
	WarningTenebron		= "提示坦納伯朗到來",
	WarningShadron		= "提示夏德朗到來",
	WarningVesperon		= "提示維斯佩朗到來",
	WarningTenebronPortal	= "為坦納伯朗的傳送門顯示特別警告",
	WarningShadronPortal	= "為夏德朗的傳送門顯示特別警告",
	WarningVesperonPortal	= "為維斯佩朗的傳送門顯示特別警告",
})

L:SetMiscLocalization({
	Wall			= "圍繞著%s的熔岩開始劇烈地翻騰!",
	Portal			= "%s開始開啟暮光傳送門!",
	NameTenebron		= "坦納伯朗",
	NameShadron		= "夏德朗",
	NameVesperon		= "維斯佩朗",
	FireWallOn		= "火焰障壁: %s",
	VoidZoneOn		= "暗影裂縫: %s",
	VoidZones		= "踩中暗影裂縫 (這一次): %s",
	FireWalls		= "撞上火焰障壁 (這一次): %s",
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "『戰爭之子』巴爾薩拉斯"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "即將分裂"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "為分裂顯示預警",
	RangeFrame			= "顯示距離框體（12碼）",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

L:SetMiscLocalization({
	SplitTrigger		= "別人的痛苦就是我的快樂。"
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "『怒火』薩維安娜"
})

L:SetWarningLocalization({
	specWarnConflagNear		= "焚焰於你附近 - 注意",
	SpecialWarningTranq		= "激怒 - 現在寧神"
})

L:SetOptionLocalization({
	specWarnConflagNear		= "當$spell:74452在你附近時顯示特殊警報",
	SpecialWarningTranq		= "為激怒顯示特殊警報",--$spell:78722 is not in 3.3.3 game files, it cannot be added in to local until 3.3.5
	YellOnConflag			= "被$spell:74452時大喊",
	RangeFrame				= "顯示距離框體（10碼）",
	ConflagIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74452)
})

L:SetMiscLocalization{
	YellConflag				= "焚焰於我！"
}

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "扎瑞斯萊恩將軍"
})

L:SetWarningLocalization({
	WarnAdds	= "新的小怪"
})

L:SetTimerLocalization({
	TimerAdds	= "新的小怪"
})

L:SetOptionLocalization({
	WarnAdds		= "提示新的小怪",
	TimerAdds		= "為新的小怪顯示計時條"
})

L:SetMiscLocalization({
	SummonMinions	= "去吧，將他們挫骨揚灰！"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "海萊恩"
})

L:SetWarningLocalization({
	WarnPhase2Soon		= "即將第二階段",
	WarnPhase3Soon		= "即將第三階段"
})

L:SetOptionLocalization({
	WarnPhase2Soon			= "為第二階段顯示預警（在79%時）",
	WarnPhase3Soon			= "為第三階段顯示預警（在54%時）",
	SoundOnConsumption		= "當$spell:74562或$spell:74792的目標為自己時播放聲音",
	YellOnConsumption		= "當$spell:74562或$spell:74792的目標為自己時大喊",
	SetIconOnConsumption	= "對$spell:74562和$spell:74792的目標設置團隊標記"
})

L:SetMiscLocalization({
	YellPull				= "你們的世界在滅亡的邊緣搖搖欲墜。你們接下來全都會見證這個毀滅新紀元的來臨!",
	twilightcutter			= "這些環繞的球體散發著黑暗能量!",
	phase2					= "在暮光的國度只有磨難在等著你!有膽量的話就進去吧!",
	phase3					= "我是光明亦是黑暗!凡人，匍匐在死亡之翼的信使面前吧!",
	YellCombustion			= "熾熱燃灼於我！",
	YellConsumption			= "靈魂耗損於我！"
})