if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name = "바람의 비밀의회"
})

L:SetWarningLocalization({
	warnSpecial				= "특수 능력 활성화!!", --Hurricane/Zephyr/Sleet Storm Active",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "특수 능력 활성화!!"
})

L:SetTimerLocalization({
	timerSpecial			= "특수 능력 쿨타임",
	timerSpecialActive		= "특수 능력 활성화"
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	warnSpecial				= "특수 능력 시전 경고 보기", -- Show warning when Hurricane/Zephyr/Sleet Storm are cast",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "특수 능력 시전을 할 경우 특수 경고 보기",
	timerSpecial			= "특수 능력 쿨다운 타이머 보기",
	timerSpecialActive		= "특수 능력 유지 타이머 보기"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "알아키르"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
