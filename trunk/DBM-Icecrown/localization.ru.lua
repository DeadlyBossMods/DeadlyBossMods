if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization({
	name = "Лорд Ребрад"
})

L:SetWarningLocalization({
	specWarnWhirlwind			= "Вихрь! Бегите!",
	specWarnColdflame			= "Холодное пламя, отбегите!"
})

L:SetOptionLocalization({
	specWarnWhirlwind			= "Спец-предупреждение для \"Вихря\"",
	specWarnColdflame			= "Спец-предупреждение, когда вы получаете урон от \"Холодного пламени\"",
	PlaySoundOnWhirlwind			= "Звуковой сигнал, когда \"Вихрь\""
})


-----------------
--  Festergut  --
-----------------
L = DBM:GetModLocalization("Festergut")

L:SetGeneralLocalization({
	name = "Тухлопуз"
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
	name = "Гниломорд"
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
	name = "Воздушное Сражение"
})
L:SetWarningLocalization({
})
L:SetOptionLocalization({
})





