if GetLocale() ~= "zhTW" then return end

local L

---------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "夏德朗"
})


---------------
--  Tenebron  --
---------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "坦納伯朗"
})


---------------
--  Vesperon  --
---------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "維斯佩朗"
})


---------------
--  Sartharion  --
---------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "『黑曜守護者』撒爾薩里安"
})


L:SetWarningLocalization({
	WarningTenebron			= "坦納伯朗進入戰鬥",
	WarningShadron			= "夏德朗進入戰鬥",
	WarningVesperon			= "維斯佩朗進入戰鬥",
	WarningFireWall			= "火牆!",
	WarningVesperonPortal		= "維斯佩朗的傳送門!",
	WarningTenebronPortal		= "坦納伯朗的傳送門!",
	WarningShadronPortal		= "夏德朗的傳送門!",
})

L:SetTimerLocalization({
	TimerWall			= "火牆冷卻",
	TimerTenebron			= "坦納伯朗進入戰鬥",
	TimerShadron			= "夏德朗進入戰鬥",
	TimerVesperon			= "維斯佩朗進入戰鬥"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall		= "為\"火牆\"播放音效",
	AnnounceFails			= "公佈踩中虛空區域和撞上火牆的玩家到團隊頻道(需要開啟團隊廣播及團長/隊長權限)",

	TimerWall			= "為\"火牆\"顯示計時器",
	TimerTenebron			= "為坦納伯朗顯示計時器",
	TimerShadron			= "為夏德朗顯示計時器",
	TimerVesperon			= "為維斯佩朗顯示計時器",

	WarningFireWall			= "顯示\"火牆\"的特別警告",
	WarningTenebron			= "顯示坦納伯朗出現計時",
	WarningShadron			= "顯示夏德朗出現計時",
	WarningVesperon			= "顯示維斯佩朗出現計時",

	WarningTenebronPortal		= "為坦納伯朗的傳送門顯示特別警告",
	WarningShadronPortal		= "為夏德朗的傳送門顯示特別警告",
	WarningVesperonPortal		= "為維斯佩朗的傳送門顯示特別警告",
})

L:SetMiscLocalization({
	Wall				= "圍繞著%s的熔岩開始劇烈地翻騰!",
	Portal				= "%s開始開啟暮光傳送門!",
	NameTenebron			= "坦納伯朗",
	NameShadron			= "夏德朗",
	NameVesperon			= "維斯佩朗",
	FireWallOn			= "火牆: %s",
	VoidZoneOn			= "虛空區域: %s",
	VoidZones			= "踩中虛空區域(這一次): %s",
	FireWalls			= "撞上火牆 (這一次): %s",
	--[[ not in use; don't translate.
	Vesperon	= "Vesperon, the clutch is in danger! Assist me!",
	Shadron		= "Shadron! Come to me! All is at risk!",
	Tenebron	= "Tenebron! The eggs are yours to protect as well!"
	--]]
})