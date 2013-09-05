if GetLocale() ~= "koKR" then return end
local L

---------------------
-- A Brewing Storm --
---------------------
L= DBM:GetModLocalization("d517")

L:SetTimerLocalization{
	timerEvent			= "양조 완료 (추정)"
}

L:SetOptionLocalization{
	timerEvent			= "양조 완료 바 보기(추정)"
}

L:SetMiscLocalization{
	BrewStart			= "폭풍이 몰려오고 있어요! 준비하세요.",
	BorokhulaPull		= "마지막 기회다, 이 갈래 혀 꿈틀이들아!",
	BorokhulaAdds		= "원군을 부릅니다!"--In case useful/important on heroic. On normal just zerg boss and ignore these unless you want achievement.
}

-----------------------
-- A Little Patience --
-----------------------
L= DBM:GetModLocalization("d589")

L:SetMiscLocalization{
	ScargashPull		= "너희 얼라이언스는 약해 빠졌어!"--Not yet in use but could be with more logs and combat start timers
}

---------------------------
-- Arena Of Annihilation --
---------------------------
L= DBM:GetModLocalization("d511")

-------------------------
-- Assault of Zan'vess --
-------------------------
L= DBM:GetModLocalization("d593")

L:SetMiscLocalization{
	TelvrakPull			= "잔베스는 함락되지 않는다!"
}

------------------------------
-- Battle on the High Seas ---
------------------------------
L= DBM:GetModLocalization("d652")

-----------------------
-- Blood in the Snow --
-----------------------
L= DBM:GetModLocalization("d646")

-----------------------
-- Brewmoon Festival --
-----------------------
L= DBM:GetModLocalization("d539")

L:SetTimerLocalization{
	timerBossCD		= "%s"
}

L:SetOptionLocalization{
	timerBossCD		= "우두머리 등장 바 보기"
}

L:SetMiscLocalization{
	RatEngage	= "무리 어미예요! 조심하세요!",
	BeginAttack	= "주민들을 보호해야 하네!",
	Yeti		= "바타리 전투 설인",
	Qobi		= "전쟁인도자 코비"
}

------------------------------
-- Crypt of Forgotten Kings --
------------------------------
L= DBM:GetModLocalization("d504")

-----------------------
-- Dagger in the Dark --
-----------------------
L= DBM:GetModLocalization("d616")

L:SetTimerLocalization{
	timerAddsCD		= "추가병력 가능"
}

L:SetOptionLocalization{
	timerAddsCD		= "도마뱀군주 추가 병력 대기시간 바 보기"
}

L:SetMiscLocalization{
	LizardLord		= "사우록이 동굴을 지키고 있네. 처치하세."
}

----------------------------
-- Dark Heart of Pandaria --
----------------------------
L= DBM:GetModLocalization("d647")

L:SetMiscLocalization{
	summonElemental		= "하수인들아, 이 벌레들을 없애라!"
}
------------------------
-- Greenstone Village --
------------------------
L= DBM:GetModLocalization("d492")

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

----------------------------
-- The Secret of Ragefire --
----------------------------
L= DBM:GetModLocalization("d649")

L:SetMiscLocalization{
	XorenthPull		= "하등한 종족들은 모두 진정한 호드의 적이다!",
	ElagloPull		= "어리석구나! 너희 따위가 진정한 호드를 막아낼 순 없다!"
}

----------------------
-- Theramore's Fall --
----------------------
L= DBM:GetModLocalization("d566")

--------------------------------
-- Troves of the Thunder King --
--------------------------------
L= DBM:GetModLocalization("d620")

----------------
-- Unga Ingoo --
----------------
L= DBM:GetModLocalization("d499")

------------------------
-- Warlock Green Fire --
------------------------
L= DBM:GetModLocalization("d594")

L:SetWarningLocalization{
	specWarnLostSouls		= "길 잃은 영혼!",
	specWarnEnslavePitLord	= "지옥의 군주 - 지배하세요!"
}

L:SetTimerLocalization{
	timerLostSoulsCD		= "길 잃은 영혼 가능"
}

L:SetOptionLocalization{
	specWarnLostSouls		= "길 잃은 영혼 소환시 특수 경고 보기",
	specWarnEnslavePitLord	= "지옥의 군주 활성화 또는 지배 해제시 특수 경고 보기",
	timerLostSoulsCD		= "길 잃은 영혼 대기시간 바 보기"
}

L:SetMiscLocalization{
	LostSouls				= "이곳의 힘은 너 따위의 것이 아니다. 흑마법사!"
}
