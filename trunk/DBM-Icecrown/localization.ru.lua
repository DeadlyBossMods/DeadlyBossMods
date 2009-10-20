if GetLocale() ~= "ruRU" then return end

local L

----------------------
--  Lord Marrowgar  --
----------------------
L = DBM:GetModLocalization("LordMarrowgar")

L:SetGeneralLocalization{
	name = "Лорд Ребрад"
}

L:SetWarningLocalization{
	specWarnWhirlwind			= "Вихрь! Бегите!",
	specWarnColdflame			= "Холодное пламя, отбегите!"
}

L:SetOptionLocalization{
	specWarnWhirlwind			= "Спец-предупреждение для \"Вихря\"",
	specWarnColdflame			= "Спец-предупреждение, когда вы получаете урон от \"Холодного пламени\"",
	PlaySoundOnWhirlwind			= "Звуковой сигнал, когда \"Вихрь\""
}
