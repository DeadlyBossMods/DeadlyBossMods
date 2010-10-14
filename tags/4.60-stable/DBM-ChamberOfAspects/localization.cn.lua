-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>


if GetLocale() ~= "zhCN" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "沙德隆"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "塔尼布隆"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "维斯匹隆"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "萨塔里奥"
})

L:SetWarningLocalization({
	WarningTenebron	        = "塔尼布隆到来",
	WarningShadron	        = "沙德隆到来",
	WarningVesperon	        = "维斯匹隆到来",
	WarningFireWall	        = "烈焰之啸",
	WarningVesperonPortal	= "维斯匹隆的传送门",
	WarningTenebronPortal	= "塔尼布隆的传送门",
	WarningShadronPortal    = "沙德隆的传送门"
})

L:SetTimerLocalization({
	TimerTenebron	= "塔尼布隆到来",
	TimerShadron	= "沙德隆到来",
	TimerVesperon	= "维斯匹隆到来"
})

L:SetOptionLocalization({
	PlaySoundOnFireWall	    = "为烈焰之啸播放音效",
	AnnounceFails           = "公布踩中暗影裂隙和撞上烈焰之啸的玩家到团队频道 (需要团长或助理权限)",
	TimerTenebron           = "为塔尼布隆到来显示计时条",
	TimerShadron            = "为沙德隆到来显示计时条",
	TimerVesperon           = "为维斯匹隆到来显示计时条",
	WarningFireWall         = "为烈焰之啸显示特别警报",
	WarningTenebron         = "提示塔尼布隆到来",
	WarningShadron          = "提示沙德隆到来",
	WarningVesperon         = "提示维斯匹隆到来",
	WarningTenebronPortal	= "为塔尼布隆的传送门显示特别警报",
	WarningShadronPortal	= "为沙德隆的传送门显示特别警报",
	WarningVesperonPortal	= "为维斯匹隆的传送门显示特别警报"
})

L:SetMiscLocalization({
	Wall			= "%s周围的岩浆沸腾了起来！",
	Portal			= "%s开始开启暮光传送门!",
	NameTenebron	= "塔尼布隆",
	NameShadron		= "沙德隆",
	NameVesperon	= "维斯匹隆",
	FireWallOn		= "烈焰之啸: %s",
	VoidZoneOn		= "暗影裂隙: %s",
	VoidZones		= "踩中暗影裂隙 (这一次): %s",
	FireWalls		= "撞上烈焰之啸 (这一次): %s"
})
