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
	WarnAdd		= "탄원하며 무릎 꿇기"
})

L:SetOptionLocalization({
	WarnAdd		= "$spell:75608 버프가 추가될 때 경고하기"
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
	SetIconOnBoss	= "$spell:76200 시전 후 보스에게 아이콘 표시 "
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
	PingBlitz	= "장군 움브리스가 당신을 향해 대공세를 시전할 경우 미니맵에 알리기"
}

L:SetMiscLocalization{
	Blitz		= "보면서 |cFFFF0000(%S+)를 시전합니다!"
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
	name = "아뮤나이"
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

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "고위 사제 바림"
})

L:SetOptionLocalization{
	BossHealthAdds	= "보스 체력 프레임 확장 보기"	-- translate
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
	WarnMortalWound	= "%s : >%s< (%d)"		-- Mortal Wound on >args.destName< (args.amount)
}

L:SetOptionLocalization{
	WarnMortalWound	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(93675, GetSpellInfo(93675) or "알 수 없음")
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
	TimerEmerge		= "등장",
	TimerSubmerge	= "잠수"
})

L:SetOptionLocalization({
	WarnEmerge		= "등장 경고 보기",
	WarnSubmerge	= "잠수 경고 보기",
	TimerEmerge		= "등장 타이머 보기",
	TimerSubmerge	= "잠수 타이머 보기",
	CrystalArrow	= "당신의 주변에 $spell:81634이 생성될 경우 DBM 화살표 보기",
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
	specWarnCrystalStorm		= "수정 폭풍"
})

L:SetOptionLocalization({
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

--------------
-- Altairus --
-------------- 
L = DBM:GetModLocalization("Altairus")

L:SetGeneralLocalization({
	name = "알타리우스"
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
	SpecWarnStaticCling	= "점프!"
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