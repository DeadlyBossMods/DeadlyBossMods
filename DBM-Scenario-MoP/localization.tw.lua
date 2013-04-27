if GetLocale() ~= "zhTW" then return end
local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

L:SetTimerLocalization{
	timerEvent			= "釀酒完成(大約的時間)"
}

L:SetOptionLocalization{
	timerEvent			= "為釀酒完成顯示大約時間的計時器"
}

L:SetMiscLocalization{
	BrewStart			= "風暴開始了!準備好。",
	BrewFinish			= "你成功了!讓我們把這酒帶去靜修居...",
	BorokhulaPull		= "該死了，你這個舌頭分岔的滑溜爬蟲!",
	BorokhulaAdds		= "呼叫援助!"
}

-----------------------
-- A Little Patience --
-----------------------
L= DBM:GetModLocalization("d589")

L:SetMiscLocalization{
	ScargashPull		= "Your Alliance is WEAK!"--Not yet in use but could be with more logs and combat start timers
}

-------------------------
-- Assault of Zan'vess --
-------------------------
L= DBM:GetModLocalization("d593")

L:SetMiscLocalization{
	TelvrakPull			= "Zan'vess will never fall!"
}

------------------------------
-- Crypt of Forgotten Kings --
------------------------------
L= DBM:GetModLocalization("d504")

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

--------------
-- Landfall --
--------------
L = DBM:GetModLocalization("Landfall")

L:SetWarningLocalization({
	WarnAchFiveAlive	= "成就\"五小福\"失敗"
})

L:SetOptionLocalization({
	WarnAchFiveAlive	= "為成就\"五小福\"失敗顯示警告."
})

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

L:SetWarningLocalization({
	specWarnLostSouls		= "靈魂迷失!",
	specWarnEnslavePitLord	= "深淵領主 - 快奴役惡魔!"
})

L:SetTimerLocalization({
	timerCombatStarts		= "戰鬥開始",
	timerLostSoulsCD		= "靈魂迷失冷卻"
})

L:SetOptionLocalization({
	specWarnLostSouls		= "為靈魂迷失重生顯示特別警告",
	specWarnEnslavePitLord	= "為需對深淵領主使用奴役惡魔時顯示特別警告",
	timerCombatStarts		= "為戰鬥開始顯示時間",
	timerLostSoulsCD		= "為下一次靈魂迷失重生顯示冷卻計時器"
})

L:SetMiscLocalization({
	LostSouls				= "面對注定滅亡的同儕靈魂，術士!"
})
