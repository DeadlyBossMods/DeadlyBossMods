if GetLocale() ~= "koKR" then return end
local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L = DBM:GetModLocalization("Romogg")

L:SetGeneralLocalization({
	name = "해골분쇄자 롬오그"
})

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L = DBM:GetModLocalization("Corla")

L:SetGeneralLocalization({
	name = "황혼의 전령 코를라"
})

L:SetWarningLocalization({
	WarnAdd		= "광신도 진화!"
})

L:SetOptionLocalization({
	WarnAdd		= "광신도가 $spell:75608 효과를 잃었을 때 경고 보기(광신도 진화)"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L = DBM:GetModLocalization("KarshSteelbender")

L:SetGeneralLocalization({
	name = "카쉬 스틸벤더"
})

L:SetTimerLocalization({
	TimerSuperheated 	= "과열된 수은갑옷 (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "$spell:75846 지속 타이머 보기"
})

------------
-- Beauty --
------------
L = DBM:GetModLocalization("Beauty")

L:SetGeneralLocalization({
	name = "아름이"
})

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L = DBM:GetModLocalization("AscendantLordObsidius")

L:SetGeneralLocalization({
	name = "승천 군주 옵시디우스"
})

L:SetOptionLocalization({
	SetIconOnBoss	= "$spell:76200 시전 후 보스에게 전술 목표 아이콘 표시 "
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L = DBM:GetModLocalization("Glubtok")

L:SetGeneralLocalization({
	name = "글럽톡"
})

-----------------------
-- Helix Gearbreaker --
-----------------------
L = DBM:GetModLocalization("Helix")

L:SetGeneralLocalization({
	name = "헬릭스 기어브레이커"
})

---------------------
-- Foe Reaper 5000 --
---------------------
L = DBM:GetModLocalization("FoeReaper")

L:SetGeneralLocalization({
	name = "전투 절단기 5000"
})

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L = DBM:GetModLocalization("Ripsnarl")

L:SetGeneralLocalization({
	name = "제독 으르렁니"
})

----------------------
-- "Captain" Cookie --
----------------------
L = DBM:GetModLocalization("Cookie")

L:SetGeneralLocalization({
	name = "\"선장\" 쿠키"
})

----------------------
-- Vanessa VanCleef --
----------------------
L = DBM:GetModLocalization("Vanessa")

L:SetGeneralLocalization({
	name = "바네사 밴클리프"
})

L:SetTimerLocalization({
	achievementGauntlet	= "불같은 밴클리프 복수자"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L = DBM:GetModLocalization("GeneralUmbriss")

L:SetGeneralLocalization({
	name = "장군 움브리스"
})

L:SetOptionLocalization{
	PingBlitz	= "당신이 $spell:74670 의 대상이 될 경우 미니맵에 위치 표시하기"
}

L:SetMiscLocalization{
	Blitz		= "보면서"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L = DBM:GetModLocalization("ForgemasterThrongus")

L:SetGeneralLocalization({
	name = "제련장인 트롱구스"
})

-------------------------
-- Drahga Shadowburner --
-------------------------
L = DBM:GetModLocalization("DrahgaShadowburner")

L:SetGeneralLocalization({
	name = "드라가 섀도버너"
})

L:SetMiscLocalization{
	ValionaYell	= "용이여, 내 명령을 따라라! 날 태워라!",	-- translate -- Yell when Valiona is incoming
	Add			= "화염의 기원",
	Valiona		= "발리오나"	-- translate
}

------------
-- Erudax --
------------
L = DBM:GetModLocalization("Erudax")

L:SetGeneralLocalization({
	name = "에루닥스"
})

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L = DBM:GetModLocalization("TempleGuardianAnhuur")

L:SetGeneralLocalization({
	name = "사원 수호자 안후르"
})

---------------------
-- Earthrager Ptah --
---------------------
L = DBM:GetModLocalization("EarthragerPtah")

L:SetGeneralLocalization({
	name = "대지전복자 프타"
})

L:SetMiscLocalization{
	Kill		= "프타는... 이젠..."
}

--------------
-- Anraphet --
--------------
L = DBM:GetModLocalization("Anraphet")

L:SetGeneralLocalization({
	name = "안라펫"
})

L:SetTimerLocalization({
	achievementGauntlet	= "빛 보다 빠르게"
})

L:SetMiscLocalization({
	Brann		= "좋아요. 갑시다! 최종 출입 암호를 넣기만 하면 이 출입문이 작동할 거예요..."
})

------------
-- Isiset --
------------
L = DBM:GetModLocalization("Isiset")

L:SetGeneralLocalization({
	name = "이시세트"
})

L:SetWarningLocalization({
	WarnSplitSoon	= "곧 분리"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "분리 사전 경고 보기"
})

-------------
-- Ammunae --
------------- 
L = DBM:GetModLocalization("Ammunae")

L:SetGeneralLocalization({
	name = "아뮤내"
})

-------------
-- Setesh  --
------------- 
L = DBM:GetModLocalization("Setesh")

L:SetGeneralLocalization({
	name = "세테쉬"
})

----------
-- Rajh --
----------
L = DBM:GetModLocalization("Rajh")

L:SetGeneralLocalization({
	name = "라지"
})

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L = DBM:GetModLocalization("GeneralHusam")

L:SetGeneralLocalization({
	name = "장군 후삼"
})

------------------------------------
-- Siamat, Lord of the South Wind --
-------------------
L = DBM:GetModLocalization("Siamat")

L:SetGeneralLocalization({
	name = "남풍 군주 시아마트"		-- "Siamat, Lord of the South Wind" --> Real name is too long :((
})

L:SetWarningLocalization{
	specWarnPhase2Soon	= "5초 후 2 단계 시작!"
}

L:SetTimerLocalization({
	timerPhase2 		= "2 단계 시작"
})

L:SetOptionLocalization{
	specWarnPhase2Soon	= "2 단계 특수 경고 보기(5초 전)",
	timerPhase2 		= "2 단계 시작 타이머 보기"
}

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "고위 사제 바림"
})

L:SetOptionLocalization{
	BossHealthAdds	= "추가되는 몹의 체력 프레임 보기"	-- translate
}

L:SetMiscLocalization{
	BlazeHeavens		= "천상의 불꽃",	-- translate
	HarbringerDarkness	= "암흑의 전령"	-- translate, 영혼의파편
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "톱니아귀"
})

L:SetOptionLocalization{
	RangeFrame	= "거리 프레임 보기 (5 m)"		-- translate
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "오우"		-- translate
})

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L = DBM:GetModLocalization("Ashbury")

L:SetGeneralLocalization({
	name = "남작 애쉬버리"
})

-----------------------
-- Baron Silverlaine --
-----------------------
L = DBM:GetModLocalization("Silverlaine")

L:SetGeneralLocalization({
	name = "남작 실버레인"
})

--------------------------
-- Commander Springvale --
--------------------------
L = DBM:GetModLocalization("Springvale")

L:SetGeneralLocalization({
	name = "사령관 스프링베일"
})

L:SetTimerLocalization({
	TimerAdds		= "다음 유령 소환"
})

L:SetOptionLocalization{
	TimerAdds		= "다음 유령 소환 타이머 보기"
}

L:SetMiscLocalization{
	YellAdds		= "침입자를 물리쳐라!"
}

-----------------
-- Lord Walden --
-----------------
L = DBM:GetModLocalization("Walden")

L:SetGeneralLocalization({
	name = "월든 경"
})

L:SetWarningLocalization{
	specWarnCoagulant	= "녹색 - 움직이세요!",	-- Green light
	specWarnRedMix		= "빨강 - 움직이지 마세요!"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "녹색/빨강 이동 관련 특수 경고 보기"
}

------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "고드프리 경"
})

L:SetWarningLocalization{
}

L:SetOptionLocalization{
}

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L = DBM:GetModLocalization("Corborus")

L:SetGeneralLocalization({
	name = "코보루스"
})

L:SetWarningLocalization({
	WarnEmerge		= "등장",
	WarnSubmerge	= "잠수"
})

L:SetTimerLocalization({
	TimerEmerge		= "다음 등장",
	TimerSubmerge	= "다음 잠수"
})

L:SetOptionLocalization({
	WarnEmerge		= "등장 경고 보기",
	WarnSubmerge	= "잠수 경고 보기",
	TimerEmerge		= "다음 등장 타이머 보기",
	TimerSubmerge	= "다음 잠수 타이머 보기",
	CrystalArrow	= "당신 주변에 $spell:81634이 시전 된 경우 DBM 화살표 보기",
	RangeFrame		= "거리 프레임 보기 (5m)"	
})



-----------
-- Ozruk --
----------- 
L = DBM:GetModLocalization("Ozruk")

L:SetGeneralLocalization({
	name = "오즈룩"
})

--------------
-- Slabhide --
-------------- 
L = DBM:GetModLocalization("Slabhide")

L:SetGeneralLocalization({
	name = "돌거죽"
})

L:SetWarningLocalization({
	WarnAirphase				= "공중 단계",
	WarnGroundphase				= "지상 단계",
	specWarnCrystalStorm		= "수정 폭풍 - 숨으세요!"
})

L:SetTimerLocalization({
	TimerAirphase				= "다음 공중 단계",
	TimerGroundphase			= "다음 지상 단계"
})

L:SetOptionLocalization({
	WarnAirphase				= "공중 단계일 때 경고 보기",
	WarnGroundphase				= "지상 단계일 때 경고 보기",
	TimerAirphase				= "다음 공중 단계 타이머 보기",
	TimerGroundphase			= "다음 지상 단계 타이머 보기",
	specWarnCrystalStorm		= "$spell:92265 특수 경고 보기"
})

-------------------------
-- High Priestess Azil --
------------------------
L = DBM:GetModLocalization("HighPriestessAzil")

L:SetGeneralLocalization({
	name = "대여사제 아질"
})

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L = DBM:GetModLocalization("GrandVizierErtan")

L:SetGeneralLocalization({
	name = "대장로 에르탄"
})

L:SetMiscLocalization{
	Retract		= "회오리 방패를 가까이 끌어당깁니다!"
}

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "알타이루스"
})

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L = DBM:GetModLocalization("Asaad")

L:SetGeneralLocalization({
	name = "아사드"
})

L:SetOptionLocalization({
	SpecWarnStaticCling	= "$spell:87618의 특수 경고 보기"
})

L:SetWarningLocalization({
	SpecWarnStaticCling	= "전하 응집 - 점프!"
})

---------------------------
--  The Throne of Tides  --
---------------------------
-- Lady Naz'jar --
------------------ 
L = DBM:GetModLocalization("LadyNazjar")

L:SetGeneralLocalization({
	name = "여군주 나즈자르"
})

-----======-----------
-- Commander Ulthok --
---------------------- 
L = DBM:GetModLocalization("CommanderUlthok")

L:SetGeneralLocalization({
	name = "사령관 울톡"
})

-------------------------
-- Erunak Stonespeaker --
-------------------------
L = DBM:GetModLocalization("ErunakStonespeaker")

L:SetGeneralLocalization({
	name = "에루낙 스톤스피커"
})

------------
-- Ozumat --
------------ 
L = DBM:GetModLocalization("Ozumat")

L:SetGeneralLocalization({
	name = "오주마트"
})

----------------
--  Zul'Aman  --
----------------
--  Nalorakk --
---------------
L = DBM:GetModLocalization("Nalorakk5")

L:SetGeneralLocalization{
	name = "날로라크 (곰)"
}

L:SetWarningLocalization{
	WarnBear		= "곰 형상",
	WarnBearSoon	= "5초 후 곰 형상",
	WarnNormal		= "인간 형상",
	WarnNormalSoon	= "5초 후 인간 형상"
}

L:SetTimerLocalization{
	TimerBear		= "다음 곰 형상",
	TimerNormal		= "다음 인간 형상"
}

L:SetOptionLocalization{
	WarnBear		= "곰 형상 경고 보기",
	WarnBearSoon	= "곰 형상 사전 경고 보기(soon)",
	WarnNormal		= "인간 형상 경고 보기",
	WarnNormalSoon	= "인간 형상 사전 경고 보기(soon)",
	TimerBear		= "다음 곰 형상 타이머 보기",
	TimerNormal		= "다음 인간 형상 타이머 보기"
}

L:SetMiscLocalization{
	YellBear 	= "너희들이 짐승을 불러냈다. 놀랄 준비나 해라!",
	YellNormal	= "날로라크 나가신다!"
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "아킬존 (독수리)"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	StormIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43648),
	RangeFrame	= "거리 프레임 보기 (10 m)"
}

L:SetMiscLocalization{
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "잔알라이 (용매)"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb	= "태워버리겠다!",
	YellAdds	= "다 어디 갔지? 당장 알을 부화시켜!"
}

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "할라지 (스라소니)"
}

L:SetWarningLocalization{
	WarnSpirit	= "영혼 단계",
	WarnNormal	= "보통 단계"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnSpirit	= "영혼 단계 경고 보기",
	WarnNormal	= "보통 단계 경고 보기"
}

L:SetMiscLocalization{
	YellSpirit	= "야생의 혼이 내 편이다...",
	YellNormal	= "혼이여, 이리 돌아오라!"
}

-----------------------
-- Hexlord Malacrass --
-----------------------
L = DBM:GetModLocalization("Malacrass5")

L:SetGeneralLocalization{
	name = "주술 군주 말라크라스 (5인)"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "$spell:43501 타이머 보기"
}

L:SetMiscLocalization{
}

-------------
-- Daakara --
-------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "다카라"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
	SetIconOnThrow		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639)
}

-----------------
--  Zul'Gurub  --
-------------------------
-- High Priest Venoxis --
-------------------------
L = DBM:GetModLocalization("Venoxis")

L:SetGeneralLocalization{
	name = "대사제 베녹시스"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477)
}

L:SetMiscLocalization{
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "혈군주 만도키르"
}

L:SetWarningLocalization{
	WarnRevive		= "영혼 부활 - %d회 남음",
	SpecWarnOhgan	= "오간 되살아남! 극딜!"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnRevive		= "영혼 부활 남은 횟수 경고 보기",
	SpecWarnOhgan	= "오간이 공격 가능 할때 특수 경고 보기"
}

L:SetMiscLocalization{
	Ohgan		= "오간"
}

------------
-- Zanzil --
------------
L = DBM:GetModLocalization("Zanzil")

L:SetGeneralLocalization{
	name = "잔질"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
}

----------------------------
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "대여사제 킬나라"
}

L:SetWarningLocalization{
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
}

L:SetMiscLocalization{
}

----------------------------
-- Jindo --
----------------------------
L = DBM:GetModLocalization("Jindo")

L:SetGeneralLocalization{
	name = "신파괴자 진도"
}

L:SetWarningLocalization{
	WarnBarrierDown	= "학카르의 사슬 보호막 사라짐 - %d/3"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	WarnBarrierDown	= "학카르의 사슬 보호막이 사라질 때 경고 보기"
}

L:SetMiscLocalization{
	Kill	= "Oh no, Hakkar's spirit is free!" -- temporarily
}