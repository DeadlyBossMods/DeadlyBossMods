if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "瑪洛加爾領主"
})

L:SetWarningLocalization({
	warnImpale				= ">%s< 被刺穿了",
	specWarnWhirlwind		= "Whirlwind - 快跑開!",
	specWarnColdflame		= "Coldflame, MOVE!"
})

L:SetOptionLocalization({
	warnImpale				= "為被刺穿的目標顯示警告",
	specWarnWhirlwind		= "為Whirlwind顯示特別警告",
	specWarnColdflame		= "當你受到Coldflame的傷害時顯示特別警告",
	PlaySoundOnWhirlwind	= "為Whirlwind播放音效"
})


-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Festergut"
})
L:SetWarningLocalization({
})
L:SetOptionLocalization({
})


---------------
--  Rotface  --
---------------
L = DBM:GetModLocalization("Rotface")

L:SetGeneralLocalization({
	name = "Rotface"
})
L:SetWarningLocalization({
	SpecWarnStickyOoze = "Ooze - 快跑出去!"
})
L:SetOptionLocalization({
	SpecWarnStickyOoze = "為Sticky Ooze顯示特別警告",
	SpecWarnRadiationOoze = "為Radiation Ooze顯示特別警告"
})
L:SetMiscLocalization({
	YellSlimePipes		= "Good news, everyone! I've fixed the poison slime pipes!"	-- Professor Putricide
})


----------------------
--  Gunship Battle  --
----------------------
L = DBM:GetModLocalization("GunshipBattle")

L:SetGeneralLocalization({
	name = "Gunship Battle"
})
L:SetWarningLocalization({
})
L:SetOptionLocalization({
})





