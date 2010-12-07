if GetLocale() ~= "zhTW" then return end

local L

---------------------------
--  Valiona & Theralion  --
---------------------------
L = DBM:GetModLocalization("ValionaTheralion")

L:SetGeneralLocalization({
	name =	"瓦莉歐娜和瑟拉里恩"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Halfus Wyrmbreaker  --
--------------------------
L = DBM:GetModLocalization("HalfusWyrmbreaker")

L:SetGeneralLocalization({
	name =	"哈福斯•破龍者"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})

----------------------------------
--  Twilight Ascendant Council  --
----------------------------------
L = DBM:GetModLocalization("AscendantCouncil")

L:SetGeneralLocalization({
	name =	"暮光卓越者議會"
})

L:SetWarningLocalization({
	SpecWarnGrounded	= "拿取禁錮增益",
	SpecWarnSearingWinds	= "拿取旋風增益"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
	Quake			= "The ground beneath you rumbles ominously....",
	Thundershock		= "The surrounding air crackles with energy....",
	Switch			= "We will handle them!",
	Phase3			= "BEHOLD YOUR DOOM!",
	Ignacious		= "伊格納修斯",
	Feludius		= "費魯迪厄斯",
	Arion			= "艾理奧",
	Terrastra		= "特拉斯特拉",
	Monstrosity		= "卓越者議會"
})

L:SetOptionLocalization({
	SpecWarnGrounded	= "當你缺少$spell:83581時顯示特別警告\n(大約施放前10秒內)",
	SpecWarnSearingWinds	= "當你缺少$spell:83500時顯示特別警告\n(大約施放前10秒內)"
})

----------------
--  Cho'gall  --
----------------
L = DBM:GetModLocalization("Chogall")

L:SetGeneralLocalization({
	name =	"丘加利"
})

L:SetWarningLocalization({
	WarnPhase2Soon	= "第2階段 即將到來"
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	WarnPhase2Soon	= "為第2階段顯示預先警告"
})