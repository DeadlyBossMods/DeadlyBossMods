if GetLocale() ~= "zhTW" then return end

local L

---------------
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
	WarningTenebron		= "坦納伯朗進入戰鬥",
	WarningShadron		= "夏德朗進入戰鬥",
	WarningVesperon		= "維斯佩朗進入戰鬥",
	WarningFireWall		= "炎嘯",
	WarningVesperonPortal	= "維斯佩朗的傳送門!",
	WarningTenebronPortal	= "坦納伯朗的傳送門!",
	WarningShadronPortal	= "夏德朗的傳送門!",
})

L:SetTimerLocalization({
	TimerTenebron		= "坦納伯朗進入戰鬥",
	TimerShadron		= "夏德朗進入戰鬥",
	TimerVesperon		= "維斯佩朗進入戰鬥"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	= "為炎嘯播放音效",
	AnnounceFails		= "公佈踩中暗影裂縫和撞上炎嘯的玩家到團隊頻道\n(需要團隊隊長或助理權限)",

	TimerTenebron		= "為坦納伯朗到來顯示計時器",
	TimerShadron		= "為夏德朗到來顯示計時器",
	TimerVesperon		= "為維斯佩朗到來顯示計時器",

	WarningFireWall		= "為炎嘯顯示特別警告",
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
	FireWallOn		= "炎嘯: %s",
	VoidZoneOn		= "暗影裂縫: %s",
	VoidZones		= "踩中暗影裂縫(這一次): %s",
	FireWalls		= "撞上炎嘯 (這一次): %s",
})