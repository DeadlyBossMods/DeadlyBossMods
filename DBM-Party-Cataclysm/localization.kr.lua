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
	WarnAdd		= "광신도가 $spell:75608 효과를 잃었을 때 알림 보기(광신도 진화)"
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
	TimerSuperheated	= "$spell:75846 효과 바 표시"
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
	PingBlitz	= "$spell:74670 대상이 될 경우 미니맵에 위치 표시"
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
	WarnSplitSoon	= "분리 사전 알림 보기"
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
	specWarnPhase2Soon	= "2 단계 시작 특수 경고 보기(5초 전)",
	timerPhase2 		= "2 단계 시작 바 표시"
}

------------------------
-- High Prophet Barim --
------------------------
L = DBM:GetModLocalization("HighProphetBarim")

L:SetGeneralLocalization({
	name = "고위 사제 바림"
})

L:SetOptionLocalization{
	BossHealthAdds	= "추가 몬스터에 대한 체력 프레임 보기"
}

L:SetMiscLocalization{
	BlazeHeavens		= "천상의 불꽃",
	HarbringerDarkness	= "암흑의 전령"
}

--------------
-- Lockmaw --
--------------
L = DBM:GetModLocalization("Lockmaw")

L:SetGeneralLocalization({
	name = "톱니아귀"
})

L:SetOptionLocalization{
	RangeFrame	= "거리 프레임 보기 (5m)"
}

----------
-- Augh --
----------
L = DBM:GetModLocalization("Augh")

L:SetGeneralLocalization({
	name = "오우"
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
	TimerAdds		= "다음 유령 소환 바 표시"
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
	specWarnCoagulant	= "녹색 빛 - 움직이세요!",	-- Green light
	specWarnRedMix		= "빨강 빛 - 움직이지 마세요!"		-- Red light
}

L:SetOptionLocalization{
	RedLightGreenLight	= "녹색/빨강 빛 이동 관련 특수 경고 보기"
}

------------------
-- Lord Godfrey --
------------------
L = DBM:GetModLocalization("Godfrey")

L:SetGeneralLocalization({
	name = "고드프리 경"
})

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
	WarnEmerge		= "등장 알림 보기",
	WarnSubmerge	= "잠수 알림 보기",
	TimerEmerge		= "다음 등장 바 표시",
	TimerSubmerge	= "다음 잠수 바 표시",
	CrystalArrow	= "$spell:81634 대상이 근처에 있을 경우 DBM 화살표 보기",
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
	WarnAirphase				= "공중 단계 알림 보기",
	WarnGroundphase				= "지상 단계 알림 보기",
	TimerAirphase				= "다음 공중 단계 바 표시",
	TimerGroundphase			= "다음 지상 단계 바 표시",
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
	SpecWarnStaticCling	= "$spell:87618 특수 경고 보기"
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
	name = "날로라크 (5인)"
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
	WarnBear		= "곰 형상 알림 보기",
	WarnBearSoon	= "곰 형상 사전 알림 보기",
	WarnNormal		= "인간 형상 알림 보기",
	WarnNormalSoon	= "인간 형상 사전 알림 보기",
	TimerBear		= "다음 곰 형상 바 표시",
	TimerNormal		= "다음 인간 형상 바 표",
	InfoFrame		= "$spell:42402 효과에 대한 정보 프레임 보기"
}

L:SetMiscLocalization{
	YellBear 		= "너희들이 짐승을 불러냈다. 놀랄 준비나 해라!",
	YellNormal		= "날로라크 나가신다!",
	PlayerDebuffs	= "쇄도 있음"
}

---------------
--  Akil'zon --
---------------
L = DBM:GetModLocalization("Akilzon5")

L:SetGeneralLocalization{
	name = "아킬존 (5인)"
}

L:SetOptionLocalization{
	StormIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43648),
	RangeFrame		= "거리 프레임 보기 (10m)",
	StormArrow		= "$spell:97300 시전시 DBM 화살표 보기", -- translate
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
--  Jan'alai --
---------------
L = DBM:GetModLocalization("Janalai5")

L:SetGeneralLocalization{
	name = "잔알라이 (5인)"
}

L:SetOptionLocalization{
	FlameIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43140)
}

L:SetMiscLocalization{
	YellBomb		= "태워버리겠다!",
	YellHatchAll	= "힘을 보여주마",
	YellAdds		= "다 어디 갔지? 당장 알을 부화시켜!"
}

--------------
--  Halazzi --
--------------
L = DBM:GetModLocalization("Halazzi5")

L:SetGeneralLocalization{
	name = "할라지 (5인)"
}

L:SetWarningLocalization{
	WarnSpirit	= "영혼 단계",
	WarnNormal	= "보통 단계"
}

L:SetOptionLocalization{
	WarnSpirit	= "영혼 단계 알림 보기",
	WarnNormal	= "보통 단계 알림 보기"
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
	name = "사술 군주 말라크라스 (5인)"
}

L:SetTimerLocalization{
	TimerSiphon	= "%s: %s"
}

L:SetOptionLocalization{
	TimerSiphon	= "$spell:43501 바 표시"
}

L:SetMiscLocalization{
	YellPull	= "너희에게 그림자가 드리우리라..."
}

-------------
-- Daakara --
-------------
L = DBM:GetModLocalization("Daakara")

L:SetGeneralLocalization{
	name = "다카라"
}

L:SetTimerLocalization{
	timerNextForm	= "다음 형상 변환"
}

L:SetOptionLocalization{
	timerNextForm	= "형상 변환 바 표시",
	InfoFrame		= "$spell:42402 효과에 대한 정보 프레임 보기",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97639),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97672)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "쇄도 있음"
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

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "$spell:96477 주문의 영향을 받은 경우 DBM 화살표 보기" -- translate
}

------------------------
-- Bloodlord Mandokir --
------------------------
L = DBM:GetModLocalization("Mandokir")

L:SetGeneralLocalization{
	name = "혈군주 만도키르"
}

L:SetWarningLocalization{
	WarnRevive		= "영혼 부활 - %d회 남음",
	SpecWarnOhgan	= "오간 되살아남!"
}

L:SetOptionLocalization{
	WarnRevive		= "영혼 부활 남은 횟수 알림 보기",
	SpecWarnOhgan	= "되살아난 오간이 공격 가능 할때 특수 경고 보기",
	SetIconOnOhgan	= "되살아난 오간에게 전술 목표 아이콘 설정하기" -- translate
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
	SpecWarnToxic	= "독 가마솥 클릭!"
}

L:SetOptionLocalization{
	SpecWarnToxic	= "$spell:96328 효과가 없을 경우 특수 경고 보기",
	InfoFrame		= "$spell:96328 효과 없음에 대한 정보 프레임 보기",
	SetIconOnGaze	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96342)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "고문의 독액 없음"
}

----------------------------
-- High Priestess Kilnara --
----------------------------
L = DBM:GetModLocalization("Kilnara")

L:SetGeneralLocalization{
	name = "대여사제 킬나라"
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

L:SetOptionLocalization{
	WarnBarrierDown	= "학카르의 사슬 보호막이 사라질 때 알림 보기",
	BodySlamIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97198)
}

L:SetMiscLocalization{
	Kill	= "너는 넘어서는 안 될 선을 넘었다, 진도. 감당하지도 못할 힘으로 장난을 치다니. 너는 내가 누군지 잊었느냐? 너는 내가 가진 힘을 잊었느냐?!"
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
--L= DBM:GetModLocalization(603)

L = DBM:GetModLocalization("CoMGrilek")

L:SetGeneralLocalization{
	name = "그리렉"
}

---------------
-- Hazza'rah --
---------------
--L= DBM:GetModLocalization(604)

L = DBM:GetModLocalization("CoMGHazzarah")

L:SetGeneralLocalization{
	name = "하자라"
}

--------------
-- Renataki --
--------------
--L= DBM:GetModLocalization(605)

L = DBM:GetModLocalization("CoMRenataki")

L:SetGeneralLocalization{
	name = "레나타키"
}

---------------
-- Wushoolay --
---------------
--L= DBM:GetModLocalization(606)

L = DBM:GetModLocalization("CoMWushoolay")

L:SetGeneralLocalization{
	name = "우슐레이"
}

--------------------
--  World Bosses  --
-------------------------
-- Akma'hat --
-------------------------
L = DBM:GetModLocalization("Akmahat")

L:SetGeneralLocalization{
	name = "아크마하트"
}

-----------
-- Garr --
----------
L = DBM:GetModLocalization("Garr")

L:SetGeneralLocalization{
	name = "가르 (대격변)"
}

----------------
-- Julak-Doom --
----------------
L = DBM:GetModLocalization("JulakDoom")

L:SetGeneralLocalization{
	name = "줄락둠"
}

L:SetOptionLocalization{
	SetIconOnMC	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(93621)
}

-----------
-- Mobus --
-----------
L = DBM:GetModLocalization("Mobus")

L:SetGeneralLocalization{
	name = "모부스"
}

-----------
-- Xariona --
-----------
L = DBM:GetModLocalization("Xariona")

L:SetGeneralLocalization{
	name = "자리오나"
}

----------------
--  End Time  --
----------------------
-- Echo of Sylvanas --
----------------------
L = DBM:GetModLocalization("EchoSylvanas")

L:SetGeneralLocalization{
	name = "실바나스의 환영"
}

---------------------
-- Echo of Tyrande --
---------------------
L = DBM:GetModLocalization("EchoTyrande")

L:SetGeneralLocalization{
	name = "티란데의 환영"
}

-------------------
-- Echo of Jaina --
-------------------
L = DBM:GetModLocalization("EchoJaina")

L:SetGeneralLocalization{
	name = "제이나의 환영"
}

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "섬광핵 폭발"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "$spell:101927 폭발 까지 남은 시간 바 표시"
}

L:SetMiscLocalization{
}

----------------------
-- Echo of Baine --
----------------------
L = DBM:GetModLocalization("EchoBaine")

L:SetGeneralLocalization{
	name = "바인의 환영"
}

--------------
-- Murozond --
--------------
L = DBM:GetModLocalization("Murozond")

L:SetGeneralLocalization{
	name = "무르도즈노"
}

L:SetMiscLocalization{
	Kill		= "넌 네가 무슨 짓을 저지르는지 모른다. 아만툴... 내가... 본... 것은..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L = DBM:GetModLocalization("Perotharn")

L:SetGeneralLocalization{
	name = "페로스안"
}

L:SetMiscLocalization{
	Pull		= "필멸자 주제에 내 앞에 서고도 살기를 바라느냐!"
}


-------------
-- Azshara --
-------------
L = DBM:GetModLocalization("Azshara")

L:SetGeneralLocalization{
	name = "여왕 아즈샤라"
}

L:SetWarningLocalization{
	WarnAdds	= "곧 부하 소환"
}

L:SetTimerLocalization{
	TimerAdds	= "다음 부하 소환"
}

L:SetOptionLocalization{
	WarnAdds	= "새로운 부하가 소환될 때 알림 보기",
	TimerAdds	= "다음 부화 소환 바 표시"
}

L:SetMiscLocalization{
	Kill		= "그만! 너희랑 놀아 주는 것도 재미있다만, 난 더 중요한 일이 있어 이만 가봐야겠다."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L = DBM:GetModLocalization("Mannoroth")

L:SetGeneralLocalization{
	name = "만노로스와 바르덴"
}

L:SetTimerLocalization{
	TimerTyrandeHelp	= "티란데 도움요청"
}

L:SetOptionLocalization{
	TimerTyrandeHelp	= "티란데 도움요청 까지 남은시간 바 표시"
}

L:SetMiscLocalization{
	Kill		= "말퓨리온, 그가 해냈어! 차원문이 무너지고 있어!"
}

------------------------
--  Hour of Twilight  --
------------------------
-- Arcurion --
--------------
L = DBM:GetModLocalization("Arcurion")

L:SetGeneralLocalization{
	name = "아큐리온"
}

L:SetTimerLocalization{
	TimerCombatStart	= "전투 시작"
}

L:SetOptionLocalization{
	TimerCombatStart	= "전투 시작 바 표시"
}

L:SetMiscLocalization{
	Event		= "모습을 드러내라!",
	Pull		= "골짜기 위쪽에서 황혼의 군대가 나타납니다."
}

----------------------
-- Asira Dawnslayer --
----------------------
L = DBM:GetModLocalization("AsiraDawnslayer")

L:SetGeneralLocalization{
	name = "아시라 돈슬레이어"
}

L:SetMiscLocalization{
	Pull		= "일단 저놈은 처리했으니, 이제 네놈과 네 멍청한 친구들을 처치하면 되겠군. 음, 날 이렇게 오래 기다리게 하다니!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L = DBM:GetModLocalization("Benedictus")

L:SetGeneralLocalization{
	name = "대주교 베네딕투스"
}

L:SetTimerLocalization{
	TimerCombatStart	= "전투 시작"
}

L:SetOptionLocalization{
	TimerCombatStart	= "전투 시작 바 표시"
}

L:SetMiscLocalization{
	Event		= "그럼... 주술사, 용의 영혼을 내놓으시지. 당장."
}