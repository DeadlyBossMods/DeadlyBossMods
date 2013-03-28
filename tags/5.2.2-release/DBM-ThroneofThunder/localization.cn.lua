-- Simplified Chinese by Diablohu(diablohudream@gmail.com)
-- Last update: 3/2/2013

if GetLocale() ~= "zhCN" then return end
local L

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L= DBM:GetModLocalization(827)

L:SetOptionLocalization({
	RangeFrame		= "距离监视"
})


--------------
-- Horridon --
--------------
L= DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds	= "%s"
})

L:SetTimerLocalization({
	timerDoor		= "下一个部族大门",
	timerAdds		= "下一次%s"
})

L:SetOptionLocalization({
	warnAdds		= "警报：新的敌人加入战斗",
	timerDoor		= "计时条：下一个部族大门阶段",
	timerAdds		= "计时条：下一次小怪"
})

L:SetMiscLocalization({
	newForces		= "forces pour from the",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget	= "stamps his tail!"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L= DBM:GetModLocalization(816)

L:SetOptionLocalization({
	RangeFrame		= "距离监视"
})

------------
-- Tortos --
------------
L= DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s由>%s<使用（%d次剩余）",
	specWarnCrystalShell	= "快去获得%s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "特殊警报：当没有$spell:137633效果时",
	InfoFrame				= "信息框：没有$spell:137633效果的团员"
})

L:SetMiscLocalization({
	WrongDebuff		= "没有%s"
})

-------------
-- Megaera --
-------------
L= DBM:GetModLocalization(821)

L:SetMiscLocalization({
	rampageEnds	= "Megaera's rage subsides."
})

------------
-- Ji-Kun --
------------
L= DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock		= "%s %s (%d)",
	specWarnFlock	= "%s %s (%d)"
})

L:SetOptionLocalization({
	RangeFrame		= "Show range frame (8) for $spell:138923"
})

L:SetMiscLocalization({
	eggsHatchL		= "The eggs in one of the lower nests begin to hatch!",
	eggsHatchU		= "The eggs in one of the upper nests begin to hatch!",
	Upper			= "上层",
	Lower			= "下层",
	UpperAndLower	= "上下都有"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L= DBM:GetModLocalization(818)

L:SetWarningLocalization({
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	ArrowOnBeam					= "Show DBM Arrow during $journal:6882 to indicate which direction to move",
})

----------------
-- Primordius --
----------------
L= DBM:GetModLocalization(820)

L:SetOptionLocalization({
	RangeFrame		= "距离监视其（5码/2码）"
})

-----------------
-- Dark Animus --
-----------------
L= DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s：>%s<、>%s<交换"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "警报：$spell:138618交换的目标"
})

L:SetMiscLocalization({
	Pull		= "The orb explodes!"
})

--------------
-- Iron Qon --
--------------
L= DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s：%s、%s被保护"
})

L:SetOptionLocalization({
	RangeFrame		= "距离监视（动态，当存在多名团员过近时显示）"
})

-------------------
-- Twin Consorts --
-------------------
L= DBM:GetModLocalization(829)

L:SetOptionLocalization({
	RangeFrame		= "距离监视（8码）"
})

L:SetMiscLocalization({
	DuskPhase		= "Lu'lin! Lend me your strength!"--Not in use, but a backup just in case, so translate in case it's switched to on moments notice on live or next PTR test
})

--------------
-- Lei Shen --
--------------
L= DBM:GetModLocalization(832)

L:SetOptionLocalization({
	RangeFrame		= "距离监视"--For two different spells
})

------------
-- Ra-den --
------------
L= DBM:GetModLocalization(831)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name =	"雷电王座小怪"
})

L:SetOptionLocalization({
	RangeFrame		= "距离监视（10码）"--For 3 different spells
})

