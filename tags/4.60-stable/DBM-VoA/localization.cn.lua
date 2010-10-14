-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>


if GetLocale() ~= "zhCN" then return end

local L

----------------------------------
--  Archavon the Stone Watcher  --
----------------------------------
L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name 				= "岩石看守者阿尔卡冯"
})

L:SetWarningLocalization({
	WarningGrab			= "阿尔卡冯抓起了 >%s<"
})

L:SetTimerLocalization({
	ArchavonEnrage			= "阿尔卡冯狂暴"
})

L:SetMiscLocalization({
	TankSwitch			= "%%s向(%S+)冲来！"
})

L:SetOptionLocalization({
	WarningGrab 			= "提示抓取的目标",
	ArchavonEnrage			= "为$spell:26662显示计时条"
})

--------------------------------
--  Emalon the Storm Watcher  --
--------------------------------
L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name 				= "风暴看守者埃玛尔隆"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	timerMobOvercharge		= "超载爆炸",
	EmalonEnrage			= "埃玛尔隆狂暴"
}

L:SetOptionLocalization{
	NovaSound			= "为$spell:65279播放音效",
	timerMobOvercharge		= "为能量超载的小怪显示爆炸倒计时(debuff叠加)",
	EmalonEnrage			= "为$spell:26662显示计时条",
	RangeFrame			= "显示距离框 (10码)"
}

---------------------------------
--  Koralon the Flame Watcher  --
---------------------------------
L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name 				= "火焰看守者科拉隆"
}

L:SetWarningLocalization{
	BurningFury			= "燃烧之怒 >%d<"
}

L:SetTimerLocalization{
	KoralonEnrage			= "科拉隆狂暴"
}

L:SetOptionLocalization{
	PlaySoundOnCinder		= "当你中了$spell:67332时播放音效",
	BurningFury			= "为$spell:66721显示警报",
	KoralonEnrage			= "为$spell:26662显示计时条"
}

L:SetMiscLocalization{
	Meteor				= "%s施放流星拳！"
}
