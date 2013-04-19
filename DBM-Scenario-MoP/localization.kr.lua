if GetLocale() ~= "koKR" then return end
local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

L:SetTimerLocalization{
	timerEvent			= "양조 완료 (추정시간)"
}

L:SetOptionLocalization{
	timerEvent			= "양조 완료 시간 바 보기 (추정)"
}

L:SetMiscLocalization{
	BrewStart			= "The storm is starting! Get ready.",
	BrewFinish			= "You did it! Let's get this brew to the Monastery...",--Maybe switch to UPDATE_WORLD_STATES 100 progress instead in a more polished version of mod.
	BorokhulaPull		= "Last call, you fork-tongued dip-slithers!",
	BorokhulaAdds		= "calls out for reinforcements!"--In case useful/important on heroic. On normal just zerg boss and ignore these unless you want achievement.
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

L:SetWarningLocalization{
	WarnAchFiveAlive	= "\"불사전설\" 업적 실패"
}

L:SetOptionLocalization{
	WarnAchFiveAlive	= "\"불사전설\" 업적 실패시 알림 보기"
}

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

L:SetWarningLocalization{
	specWarnLostSouls		= "길 잃은 영혼!",
	specWarnEnslavePitLord	= "지옥의 군주 - 지배하세요!"
}

L:SetTimerLocalization{
	timerCombatStarts		= "전투 시작",
	timerLostSoulsCD		= "길 잃은 영혼 가능"
}

L:SetOptionLocalization{
	specWarnLostSouls		= "긹 잃은 영혼 소환시 특수 경고 보기",
	specWarnEnslavePitLord	= "지옥의 군주 활성화 또는 지배 해제시 특수 경고 보기",
	timerCombatStarts		= "전투 시작 바 표시",
	timerLostSoulsCD		= "길 잃은 영혼 대기시간 바 표시"
}

L:SetMiscLocalization{
	LostSouls				= "이곳의 힘은 너 따위의 것이 아니다. 흑마법사!"
}
