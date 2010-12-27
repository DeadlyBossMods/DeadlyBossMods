if GetLocale() ~= "zhTW" then return end

local L

------------------------
--  Conclave of Wind  --
------------------------
L = DBM:GetModLocalization("Conclave")

L:SetGeneralLocalization({
	name 				= "風之議會"
})

L:SetWarningLocalization({
	warnSpecial			= "颶風/微風/冰雨風暴啟動",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "特別技能啟動!"
})

L:SetTimerLocalization({
	timerSpecial			= "特別技能冷卻",
	timerSpecialActive		= "特別技能啟動"
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
	warnSpecial			= "當颶風/微風/冰雨風暴施放時顯示警告",--Special abilities hurricane, sleet storm, zephyr(which are on shared cast/CD)
	specWarnSpecial			= "當特別技能施放時顯示特別警告",
	timerSpecial			= "為特別技能冷卻顯示計時器",
	timerSpecialActive		= "為特別技能持續時間顯示計時器"
})

---------------
--  Al'Akir  --
---------------
L = DBM:GetModLocalization("AlAkir")

L:SetGeneralLocalization({
	name = "奧拉基爾"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetMiscLocalization({
})

L:SetOptionLocalization({
})
