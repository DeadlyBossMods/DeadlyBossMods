if GetLocale() ~= "koKR" then return end
local L

-------------------------
--  Blackrock Caverns  --
--------------------------
-- Rom'ogg Bonecrusher --
--------------------------
L= DBM:GetModLocalization(105)

-------------------------------
-- Corla, Herald of Twilight --
-------------------------------
L= DBM:GetModLocalization(106)

L:SetWarningLocalization({
	WarnAdd		= "광신도 진화!"
})

L:SetOptionLocalization({
	WarnAdd		= "광신도가 $spell:75608 효과를 잃었을 때 알림 보기(광신도 진화)"
})

-----------------------
-- Karsh SteelBender --
-----------------------
L= DBM:GetModLocalization(107)

L:SetTimerLocalization({
	TimerSuperheated 	= "과열된 수은갑옷 (%d)"
})

L:SetOptionLocalization({
	TimerSuperheated	= "$spell:75846 효과 바 표시"
})

------------
-- Beauty --
------------
L= DBM:GetModLocalization(108)

-----------------------------
-- Ascendant Lord Obsidius --
-----------------------------
L= DBM:GetModLocalization(109)

L:SetOptionLocalization({
	SetIconOnBoss	= "$spell:76200 시전 후 보스에게 전술 목표 아이콘 표시 "
})

---------------------
--  The Deadmines  --
---------------------
-- Glubtok --
-------------
L= DBM:GetModLocalization(89)

-----------------------
-- Helix Gearbreaker --
-----------------------
L= DBM:GetModLocalization(90)

---------------------
-- Foe Reaper 5000 --
---------------------
L= DBM:GetModLocalization(91)

L:SetOptionLocalization{
	HarvestIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88495)
}

----------------------
-- Admiral Ripsnarl --
----------------------
L= DBM:GetModLocalization(92)

----------------------
-- "Captain" Cookie --
----------------------
L= DBM:GetModLocalization(93)

----------------------
-- Vanessa VanCleef --
----------------------
L= DBM:GetModLocalization(95)

L:SetTimerLocalization({
	achievementGauntlet	= "불같은 밴클리프 복수자"
})

------------------
--  Grim Batol  --
---------------------
-- General Umbriss --
---------------------
L= DBM:GetModLocalization(131)

L:SetOptionLocalization{
	PingBlitz	= "$spell:74670 대상이 될 경우 미니맵에 위치 표시"
}

L:SetMiscLocalization{
	Blitz		= "보면서"
}

--------------------------
-- Forgemaster Throngus --
--------------------------
L= DBM:GetModLocalization(132)

-------------------------
-- Drahga Shadowburner --
-------------------------
L= DBM:GetModLocalization(133)

L:SetMiscLocalization{
	ValionaYell	= "용이여, 내 명령을 따라라! 날 태워라!",
	Add			= "화염의 기원"
}

------------
-- Erudax --
------------
L= DBM:GetModLocalization(134)

----------------------------
--  Halls of Origination  --
----------------------------
-- Temple Guardian Anhuur --
----------------------------
L= DBM:GetModLocalization(124)

---------------------
-- Earthrager Ptah --
---------------------
L= DBM:GetModLocalization(125)

L:SetMiscLocalization{
	Kill		= "프타는... 이젠..."
}

--------------
-- Anraphet --
--------------
L= DBM:GetModLocalization(126)

L:SetTimerLocalization({
	achievementGauntlet	= "빛 보다 빠르게"
})

L:SetMiscLocalization({
	Brann		= "좋아요. 갑시다! 최종 출입 암호를 넣기만 하면 이 출입문이 작동할 거예요..."
})

------------
-- Isiset --
------------
L= DBM:GetModLocalization(127)

L:SetWarningLocalization({
	WarnSplitSoon	= "곧 분리"
})

L:SetOptionLocalization({
	WarnSplitSoon	= "분리 사전 알림 보기"
})

-------------
-- Ammunae --
------------- 
L= DBM:GetModLocalization(128)

-------------
-- Setesh  --
------------- 
L= DBM:GetModLocalization(129)

----------
-- Rajh --
----------
L= DBM:GetModLocalization(130)

--------------------------------
--  Lost City of the Tol'vir  --
--------------------------------
-- General Husam --
-------------------
L= DBM:GetModLocalization(117)

--------------
-- Lockmaw --
--------------
L= DBM:GetModLocalization(118)

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

------------------------
-- High Prophet Barim --
------------------------
L= DBM:GetModLocalization(119)

L:SetOptionLocalization{
	BossHealthAdds	= "추가 몬스터에 대한 체력 프레임 보기"
}

------------------------------------
-- Siamat, Lord of the South Wind --
------------------------------------
L= DBM:GetModLocalization(122)

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

-----------------------
--  Shadowfang Keep  --
-----------------------
-- Baron Ashbury --
-------------------
L= DBM:GetModLocalization(96)

-----------------------
-- Baron Silverlaine --
-----------------------
L= DBM:GetModLocalization(97)

--------------------------
-- Commander Springvale --
--------------------------
L= DBM:GetModLocalization(98)

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
L= DBM:GetModLocalization(99)

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
L= DBM:GetModLocalization(100)

---------------------
--  The Stonecore  --
---------------------
-- Corborus --
-------------- 
L= DBM:GetModLocalization(110)

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

--------------
-- Slabhide --
-------------- 
L= DBM:GetModLocalization(111)

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

-----------
-- Ozruk --
----------- 
L= DBM:GetModLocalization(112)

-------------------------
-- High Priestess Azil --
------------------------
L= DBM:GetModLocalization(113)

---------------------------
--  The Vortex Pinnacle  --
---------------------------
-- Grand Vizier Ertan --
------------------------
L= DBM:GetModLocalization(114)

L:SetMiscLocalization{
	Retract		= "회오리 방패를 가까이 끌어당깁니다!"
}

--------------
-- Altairus --
-------------- 
L= DBM:GetModLocalization(115)

L:SetOptionLocalization({
	BreathIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(88308)
})

-----------
-- Asaad --
-----------
L= DBM:GetModLocalization(116)

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
L= DBM:GetModLocalization(101)

-----======-----------
-- Commander Ulthok --
---------------------- 
L= DBM:GetModLocalization(102)

-------------------------
-- Erunak Stonespeaker --
-------------------------
L= DBM:GetModLocalization(103)

------------
-- Ozumat --
------------ 
L= DBM:GetModLocalization(104)

L:SetTimerLocalization{
	TimerPhase		= "2 단계"
}

L:SetOptionLocalization{
	TimerPhase		= "2 단계까지 남은시간 바 표시"
}
----------------
--  Zul'Aman  --
----------------
--  Akil'zon --
---------------
L= DBM:GetModLocalization(186)

L:SetOptionLocalization{
	StormIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43648),
	RangeFrame		= "거리 프레임 보기 (10m)",
	StormArrow		= "$spell:97300 시전시 DBM 화살표 보기",
	SetIconOnEagle	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(97318)
}

---------------
--  Nalorakk --
---------------
L= DBM:GetModLocalization(187)

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
	TimerNormal		= "다음 인간 형상 바 표시",
	InfoFrame		= "$spell:42402 효과에 대한 정보 프레임 보기"
}

L:SetMiscLocalization{
	YellBear 		= "너희들이 짐승을 불러냈다. 놀랄 준비나 해라!",
	YellNormal		= "날로라크 나가신다!",
	PlayerDebuffs	= "쇄도 있음"
}

---------------
--  Jan'alai --
---------------
L= DBM:GetModLocalization(188)

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
L= DBM:GetModLocalization(189)

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
L= DBM:GetModLocalization(190)

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
L= DBM:GetModLocalization(191)

L:SetTimerLocalization{
	timerNextForm	= "다음 형상 변환"
}

L:SetOptionLocalization{
	timerNextForm	= "형상 변환 바 표시",
	InfoFrame		= "$spell:42402 효과에 대한 정보 프레임 보기",
	ThrowIcon		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43093),
	ClawRageIcon	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(43150)
}

L:SetMiscLocalization{
	PlayerDebuffs	= "쇄도 있음"
}

-----------------
--  Zul'Gurub  --
-----------------
-- High Priest Venoxis --
-------------------------
L= DBM:GetModLocalization(175)

L:SetOptionLocalization{
	SetIconOnToxicLink	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(96477),
	LinkArrow			= "$spell:96477 주문의 영향을 받은 경우 DBM 화살표 보기"
}

------------------------
-- Bloodlord Mandokir --
------------------------
L= DBM:GetModLocalization(176)

L:SetWarningLocalization{
	WarnRevive		= "영혼 부활 - %d회 남음",
	SpecWarnOhgan	= "오간 되살아남!"
}

L:SetOptionLocalization{
	WarnRevive		= "영혼 부활 남은 횟수 알림 보기",
	SpecWarnOhgan	= "되살아난 오간이 공격 가능 할때 특수 경고 보기",
	SetIconOnOhgan	= "되살아난 오간에게 전술 목표 아이콘 설정하기"
}

----------------------
-- Cache of Madness --
----------------------
-------------
-- Gri'lek --
-------------
L= DBM:GetModLocalization(177)

---------------
-- Hazza'rah --
---------------
L= DBM:GetModLocalization(178)

--------------
-- Renataki --
--------------
L= DBM:GetModLocalization(179)

---------------
-- Wushoolay --
---------------
L= DBM:GetModLocalization(180)

----------------------------
-- High Priestess Kilnara --
----------------------------
L= DBM:GetModLocalization(181)

------------
-- Zanzil --
------------
L= DBM:GetModLocalization(184)

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
-- Jindo --
----------------------------
L= DBM:GetModLocalization(185)

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

----------------
--  End Time  --
-------------------
-- Echo of Baine --
-------------------
L= DBM:GetModLocalization(340)

-------------------
-- Echo of Jaina --
-------------------
L= DBM:GetModLocalization(285)

L:SetTimerLocalization{
	TimerFlarecoreDetonate	= "섬광핵 폭발"
}

L:SetOptionLocalization{
	TimerFlarecoreDetonate	= "$spell:101927 폭발 까지 남은시간 바 표시"
}

----------------------
-- Echo of Sylvanas --
----------------------
L= DBM:GetModLocalization(323)

---------------------
-- Echo of Tyrande --
---------------------
L= DBM:GetModLocalization(283)

--------------
-- Murozond --
--------------
L= DBM:GetModLocalization(289)

L:SetMiscLocalization{
	Kill		= "넌 네가 무슨 짓을 저지르는지 모른다. 아만툴... 내가... 본... 것은..."
}

------------------------
--  Well of Eternity  --
------------------------
-- Peroth'arn --
----------------
L= DBM:GetModLocalization(290)

L:SetMiscLocalization{
	Pull		= "필멸자 주제에 내 앞에 서고도 살기를 바라느냐!"
}

-------------
-- Azshara --
-------------
L= DBM:GetModLocalization(291)

L:SetWarningLocalization{
	WarnAdds	= "곧 부하 소환"
}

L:SetTimerLocalization{
	TimerAdds	= "다음 부하 소환"
}

L:SetOptionLocalization{
	WarnAdds	= "새로운 부하가 소환될 때 알림 보기",
	TimerAdds	= "다음 부하 소환 바 표시"
}

L:SetMiscLocalization{
	Kill		= "그만! 너희랑 놀아 주는 것도 재미있다만, 난 더 중요한 일이 있어 이만 가봐야겠다."
}

-----------------------------
-- Mannoroth and Varo'then --
-----------------------------
L= DBM:GetModLocalization(292)

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
L= DBM:GetModLocalization(322)

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
L= DBM:GetModLocalization(342)

L:SetMiscLocalization{
	Pull		= "일단 저놈은 처리했으니, 이제 네놈과 네 멍청한 친구들을 처치하면 되겠군. 음, 날 이렇게 오래 기다리게 하다니!"
}

---------------------------
-- Archbishop Benedictus --
---------------------------
L= DBM:GetModLocalization(341)

L:SetTimerLocalization{
	TimerCombatStart	= "전투 시작"
}

L:SetOptionLocalization{
	TimerCombatStart	= "전투 시작 바 표시"
}

L:SetMiscLocalization{
	Event		= "그럼... 주술사, 용의 영혼을 내놓으시지. 당장."
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
