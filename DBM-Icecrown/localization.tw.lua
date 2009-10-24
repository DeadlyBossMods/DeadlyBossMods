if GetLocale() ~= "zhTW" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "瑪洛加爾領主"
}

L:SetWarningLocalization{
	specWarnWhirlwind			= "Whirlwind - 快跑開!",
	specWarnColdflame			= "Coldflame, MOVE!"
}

L:SetOptionLocalization{
	specWarnWhirlwind			= "為Whirlwind顯示特別警告",
	specWarnColdflame			= "當你受到Coldflame的傷害時顯示特別警告",
	PlaySoundOnWhirlwind		= "為Whirlwind播放音效"
}


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
})
L:SetOptionLocalization({
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