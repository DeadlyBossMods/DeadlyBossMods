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
	warnImpale				= ">%S< проткнут(а)",
	specWarnWhirlwind			= "Вихрь - бегите",
	specWarnColdflame			= "Холодное пламя - отбегите"
})

L:SetOptionLocalization({
	warnImpale				= "Предупредить о проткнутой цели",
	specWarnWhirlwind			= "Спец-предупреждение для Вихря",
	specWarnColdflame			= "Спец-предупреждение, когда вы получаете урон от Холодного пламени",
	PlaySoundOnWhirlwind			= "Звуковой сигнал при Вихре"
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
	SpecWarnStickyOoze	= "Липкая жижа - бегите"
})
L:SetOptionLocalization({
	SpecWarnStickyOoze	= "Спец-предупреждение для Липкой жижи"
})
L:SetMiscLocalization({
	YellSlimePipes		= "Хорошие новости,"	-- Professor Putricide
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





