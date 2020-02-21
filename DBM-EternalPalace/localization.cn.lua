-- Mini Dragon(projecteurs@gmail.com)
-- 夏一可
-- Blizzard Entertainment
-- Last update: 2019/08/09

if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  Abyssal Commander Sivara --
---------------------------
--L= DBM:GetModLocalization(2352)

---------------------------
--  Rage of Azshara --
---------------------------
--L= DBM:GetModLocalization(2353)

---------------------------
--  Underwater Monstrosity --
---------------------------
--L= DBM:GetModLocalization(2347)

---------------------------
--  Lady Priscilla Ashvane --
---------------------------
--L= DBM:GetModLocalization(2354)

---------------------------
--  Orgozoa --
---------------------------
--L= DBM:GetModLocalization(2351)

---------------------------
--  The Queen's Court --
---------------------------
L= DBM:GetModLocalization(2359)

L:SetMiscLocalization({
	Circles =	"3秒后出圈"
})

---------------------------
-- Herald of N'zoth --
---------------------------
L= DBM:GetModLocalization(2349)

L:SetMiscLocalization({
	Phase3	=	"扎库尔把你拽进了恐惧领域！",
	Tear	=	"撕裂"
})

---------------------------
--  Queen Azshara --
---------------------------
L= DBM:GetModLocalization(2361)

L:SetTimerLocalization{
	timerStageThreeBerserk		= "小怪狂暴"
}

L:SetOptionLocalization({
	SortDesc 				= "$spell:298569的层数计数信息窗使用从高到低显示，而不是从低到高",
	ShowTimeNotStacks		= "使用信息窗提示$spell:298569的剩余时间而不是使用层数计数器信息框显示剩代替",
	timerStageThreeBerserk	= "为3阶段小怪狂暴显示计时器"
})

L:SetMiscLocalization({
	SoakOrb =	"吸收球",
	AvoidOrb =	"躲开球",
	GroupUp =	"集合",
	Spread =	"分散",
	Move	 =	"保持移动",
	DontMove =	"停止移动",
	HelpSoakMove		= "{rt3}帮忙吸收移动{rt3}",--Purple Diamond
	HelpSoakStay		= "{rt6}帮忙吸收不动{rt6}",--Blue Square
	HelpSoak			= "{rt3}帮忙吸收{rt3}",--Purple Diamond
	HelpMove			= "{rt4}帮忙移动{rt4}",--Green Triangle
	HelpStay			= "{rt7}帮忙不动{rt7}",--Red X
	SoloSoak 			= "单独吸收",
	Solo 				= "单独",
	--Not currently used Yells
	SoloMoving			= "单独移动",
	SoloStay			= "单独不动",
	SoloSoakMove		= "单独吸收移动",
	SoloSoakStay		= "单独吸收不动"
})


-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("EternalPalaceTrash")

L:SetGeneralLocalization({
	name =	"永恒王宫小怪"
})
