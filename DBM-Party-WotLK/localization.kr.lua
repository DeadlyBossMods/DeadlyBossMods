if GetLocale() ~= "koKR" then return end

local L

local spell					= "%s"				
local debuff				= "%s: >%s<"			
local spellCD				= "%s 쿨다운"			-- translate
local spellSoon				= "곧 %s 사용"			-- translate
local optionWarning			= "%s 경고 보기"		-- translate
local optionPreWarning		= "%s 사전 경고 보기"	-- translate
local optionSpecWarning		= "%s 특수 경고 보기"	-- translate
local optionTimerCD			= "%s 쿨다운 타이머 보기"	-- translate
local optionTimerDur		= "%s 지속 타이머 보기"	-- translate
local optionTimerCast		= "%s 시전 타이머 보기"	-- translate

--------------------------------
-- 안카헤트 - 고대 왕국       --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "공작 탈다람"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- 장로 나독스 --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "장로 나독스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
-- 어둠추적자 제도가 --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "어둠추적자 제도가"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
-- 사자 볼라즈 --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "사자 볼라즈"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
-- 아마니타르 --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "아마니타르"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- 아졸네룹    --
-------------------------------
-- 문지기 크릭시르           --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "문지기 크릭시르"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
-- 하드로녹스 --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "하드로녹스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
-- 아눕아락 --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "아눕아락(5인)"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------------------
-- 시간의 동굴 : 옛 스트라솔름 --
--------------------------------------
-- 살덩이갈고리 --
--------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "살덩이갈고리"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------
-- 살덩이창조자 살람 --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "살덩이창조자 살람"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------
-- 시간의 군주 에포크 --
------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "시간의 군주 에포크"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
-- 말가니스 --
--------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "말가니스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "스트라솔룸 웨이브"
})

L:SetWarningLocalization({
	WarningWaveNow		= "웨이브 %d: %s 등장했습니다.",
})

L:SetTimerLocalization({
	TimerWaveIn			= "다음 웨이브 (6)", 
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("새로운 웨이브"),
	TimerWaveIn			= "다음 웨이브 타이머 보기 (5번째 보스 웨이브 이후)",
})

L:SetMiscLocalization({
	Meathook		= "살덩이갈고리",
	Salramm			= "살덩이창조자 살람",
	Devouring		= "개걸스러운 구울",
	Enraged			= "격노한 구울",
	Necro			= "정예 강령술사",
	Friend			= "어둠의 강령술사",
	Tomb			= "무덤 거미",
	Abom			= "위액 골렘",
	Acolyte			= "수행 사제",
	Wave1			= "%d %s",
	Wave2			= "%d %s 그리고 %d %s",
	Wave3			= "%d %s, %d %s 그리고 %d %s",
	Wave4			= "%d %s, %d %s, %d %s 그리고 %d %s",
	WaveBoss		= "%s",
	WaveCheck		= "남은 웨이브 = %d/10"
})

-------------------
-- 드락타론 성채 --
-------------------
-- 송곳아귀 --
--------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "송곳아귀"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
-- 소환사 노보스 --
-------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "소환사 노보스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
-- 랩터왕 서슬발톱 --
---------------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "랩터왕 서슬발톱"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
-- 예언자 타론자 --
-------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "예언자 타론자"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- 군드락 --
--------------
-- 슬라드란 --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "슬라드란"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- 무라비 --
------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "무라비"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- 드라카리 거대골램 --
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "드라카리 거대골램"
})

L:SetWarningLocalization({
	WarningElemental	= "드라카리 정령 페이즈",		-- translate :)
	WarningStone		= "드라카리 거대골렘 페이즈"		-- translate :)
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "드라카리 정령 페이즈 경고 보기",	-- translate ;)
	WarningStone		= "드라카리 거대골렘 페이즈 경고 보기"		-- translate :)
})

---------------
-- 갈다라 --
---------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "갈다라"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- 사나운 엑크 --
-----------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "사나운 엑크"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- 번개의 전당 --
---------------------
-- 장군 비야른그림 --
---------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "장군 비야른그림"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
-- 아이오나 --
--------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "아이오나"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------
-- 볼칸 --
----------
L = DBM:GetModLocalization("Volkhan")


L:SetGeneralLocalization({
	name = "볼칸"
})

L:SetWarningLocalization({
	WarningStomp 	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp 	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD 	= optionTimerCD:format(GetSpellInfo(52237))
})

----------
-- 로켄 --
----------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "로켄"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- 돌의 전당   --
-----------------
-- 고뇌의 마녀 --
-----------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "고뇌의 마녀"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------
-- 크리스탈루스 --
----------------
L = DBM:GetModLocalization("Krystallus")
L:SetGeneralLocalization({
	name = "크리스탈루스"
})

L:SetWarningLocalization({
	WarningShatter	= spell
})

L:SetTimerLocalization({
	TimerShatterCD	= spellCD
})

L:SetOptionLocalization({
	WarningShatter	= optionWarning:format(GetSpellInfo(50810)),
	TimerShatterCD	= optionTimerCD:format(GetSpellInfo(50810))
})

-----------------------
-- 무쇠구체자 쇼니르 --
-----------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "무쇠구체자 쇼니르"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "브란 브론즈비어드를 보호하라"
})

L:SetWarningLocalization({
	WarningPhase	= "%d 페이즈"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("# 페이즈")
})

L:SetMiscLocalization({
	Pull		= "해답을 찾을 시간입니다! 이제 가보자고요!",
	Phase1		= "xxx anti error xxx",
	Phase2		= "xxx anti error xxx",
	Phase3		= "xxx anti error xxx"
})

---------------
-- 마력의 탑 --
----------------
-- 아노말루스 --
----------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "아노말루스"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- 정원사 오르모로크 --
-----------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "정원사 오르모로크"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
-- 대학자 텔레스트라 --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "대학자 텔레스트라"
})

L:SetWarningLocalization({
	WarningMerge		= "융합",		-- translate
	WarningSplitSoon	= "곧 분리",		-- translate
	WarningSplitNow		= "분리",		-- translate	
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "분리 사전 경고 보기",	-- translate
	WarningSplitNow		= "분리 경고 보기",	-- translate
	WarningMerge		= "융합 경고 보기"	-- translate
})

L:SetMiscLocalization({
	SplitTrigger1		= "호기심이 화를 부르는 법이지..",		-- translate
	SplitTrigger2 		= "과연 나를 감당할 수 있겠느냐!",	-- translate
	MergeTrigger		= "이제 끝을 볼 때다!"				-- translate
})

-----------------
-- 케리스트라자 --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "케리스트라자"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------------
-- 사령관 콜루르그/스타우트비어드 --
---------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "알 수 없음"
if UnitFactionGroup("player") == "Alliance" then
	commander = "사령관 콜루르그"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "사령관 스타우트비어드"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------
-- 마력의 눈 --
---------------------
-- 심문관 드라코스 --
---------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "심문관 드라코스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	MakeitCountTimer		= "Show timer for Make it Count (achievement)"
})

L:SetMiscLocalization({
	MakeitCountTimer		= "Make it Count"
})

--------------------
-- 마법사 군주 우롬 --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "마법사 군주 우롬"
})

L:SetWarningLocalization({
	WarningTimeBomb		= debuff,
	WarningExplosion 	= spell,
	SpecWarnBombYou 	= "당신에게 시한 폭탄"
})

L:SetTimerLocalization({
	TimerTimeBomb = debuff,
	TimerExplosion = spell
})

L:SetOptionLocalization({
	WarningTimeBomb 	= optionWarning:format(GetSpellInfo(51121)),
	WarningExplosion 	= optionWarning:format(GetSpellInfo(51110)),
	TimerTimeBomb 		= optionTimerDur:format(GetSpellInfo(51121)),
	TimerExplosion 		= optionTimerDur:format(GetSpellInfo(51110)),
	SpecWarnBombYou		= "당신이 시한 폭탄에 걸렸을 경우 특수 경고 보기"
})

------------------------
-- 바로스 클라우드스트라이더 --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "바로스 클라우드스트라이더"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
-- 지맥 수호자 에레고스 --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "지맥 수호자 에레고스"
})

L:SetWarningLocalization({
	WarningShiftEnd	= "차원 이동 종료"		-- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).." 종료") 	-- translate the word 'ending'
})

L:SetMiscLocalization({
	MakeitCountTimer			= "Make it Count"
})

------------------
-- 우트가드 성채 --
---------------------
-- 공작 켈레세스 --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "공작 켈레세스"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
-- 건축가 스카발드 --
-- & 감시자 달론   --
---------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "건축가 스카발드 & 감시자 달론"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
-- 약탈자 잉그바르 --
---------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "약탈자 잉그바르"
})

L:SetWarningLocalization({
	SpecialWarningSpelllock 	= "침묵!! - 캐스팅 중지!!"  -- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningSpelllock		= "주문 잠금 특수 경고 보기"	
})

-------------------
-- 우트가드 첨탑 --
-------------------
-- 학살자 스카디 --
-------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "학살자 스카디"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- 왕 이미론 --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "왕 이미론"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
-- 스발라 소로우그레이브 --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "스발라 소로우그레이브"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
-- 고르톡 패일후프 --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "고르톡 페일후프"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
-- 보라빛 요새 --
-----------------
-- 시아니고사 --
----------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "시아니고사"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- 에레켐 --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "에레켐"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- 이코론 --
------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "이코론"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
-- 라반토르 --
---------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "라반토르"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- 모라그 --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "모라그"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------
-- 제보즈 --
------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "제보즈"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
-- 파멸자 주라마트 --
---------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "파멸자 주라마트"
})

L:SetWarningLocalization({
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted		= optionSpecWarning:format(GetSpellInfo(59343)),
	SpecialShroudofDarkness			= optionSpecWarning:format(GetSpellInfo(59745))
})

-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "포탈 타이머"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "곧 새로운 포탈이 열립니다.",
	WarningPortalNow	= "포탈 #%d",
	WarningBossNow		= "곧 보스 등장"
})

L:SetTimerLocalization({
	TimerPortalIn	= "포탈 #%d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("새로운 포탈"),
	WarningPortalSoon		= optionPreWarning:format("새로운 포탈"),
	WarningBossNow			= optionWarning:format("보스 등장"),
	TimerPortalIn			= "포탈 갯수의 타이머 보기",
	ShowAllPortalWarnings	= "모든 웨이브 경고 보기"
})

L:SetMiscLocalization({
	yell1 			= "요새 경비병들이여, 이제 이곳을 떠난다! 여기 모험가들이 맡아 줄 테니 어서 후퇴하라!",
	WavePortal		= "포탈 열린 수: (%d+)/18"
})

---------------------------
-- Trial of the Champion --
---------------------------
-- The Black Knight --
----------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "흑기사"
})

L:SetWarningLocalization({
	specWarnDesecration		= "모독! 이동하세요!",
	warnExplode				= "구울 폭발을 시전합니다. 이동하세요!"
})

L:SetOptionLocalization({
	specWarnDesecration		= "모독으로부터 타격을 받을 경우 특수 경보 알리기",
	warnExplode				= "구울 폭발을 시전할 경우 경고 알리기",
	SetIconOnMarkedTarget	= "죽음 대상에 공격대 아이콘 설정"
})

L:SetMiscLocalization({
	YellCombatEnd			= "축하하네, 용사들이여. 예정된 시험이든 뜻밖의 시험이든, 그대들은 모두 이겨냈군."	-- can also be "No! I must not fail... again ..."
})

-------------------
-- Grand Champions --
-------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "도시 대표 용사"
})

L:SetWarningLocalization({
	specWarnHaste		= ">%s< 가속!! 지금 해제!",
	specWarnPoison		= "독액! 이동하세요!",
})

L:SetOptionLocalization({
	specWarnHaste		= "마법사가 가속을 얻었을 경우 특수 경고 알리기(해제/훔치기)",
	specWarnPoison		= "독병에 의해 타격을 받을 경우 특수 경고 알리기"
})

L:SetMiscLocalization({
	YellCombatEnd		= "잘 싸웠네! 다음 상대는 은빛십자군의 일원이라네. 그들을 상대로 자신의 무용을 증명해 보게."
})

--------------------------------
-- Argent Confessor Paletress --
--------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "은빛 고해사제 페일트리스"
})

L:SetWarningLocalization({
	specwarnRenew			= "고해사제 소생 시전 : >%s<, 지금 해제!"
})

L:SetOptionLocalization({
	specwarnRenew			= "고해사제의 소생 대상 특수 경고 알리기(해제/훔치기)"
})

L:SetMiscLocalization({
	YellCombatEnd			= "Excellent work!"
})

---------------------
-- Eadric the Pure --
---------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "성기사 에드릭"
})

L:SetWarningLocalization({
	specwarnHammerofJustice		= "심판의 망치 : >%s<. 지금 해제!",
	specwarnRadiance			= "광휘! 뒤돌아보세요!"
})

L:SetOptionLocalization({
	specwarnHammerofJustice		= "심판의 망치 특수 경고 보기(해제 관련)",
	specwarnRadiance			= "광휘의 특수 경고 보기.",
	SetIconOnHammerTarget		= "심판의 망치 대상자 공격대 아이콘 설정하기"	
})

L:SetMiscLocalization({
	YellCombatEnd				= "I yield! I submit. Excellent work. May I run away now?"
})

--------------------
--  World Events  --
--------------------
-- Coren Direbrew --
--------------------
L = DBM:GetModLocalization("CorenDirebrew")

L:SetGeneralLocalization({
	name = "코렌 다이어브루"
})

L:SetWarningLocalization({
	warnBarrel				= "맥주통 : >%s<", 
	specwarnDisarm			= "무장 해제. Move Away!",
	specWarnBrew			= "흑맥주요정이 맥주를 다시 던지기전에 마셔버리세요!",
	specWarnBrewStun		= "힌트: 맥주를 들고있네요.흑맥주요정의 맥주가 오기전에 마셔버리면 됩니다!"
})

L:SetOptionLocalization({
	warnBarrel				= "맥주통의 대상 알리기",
	specwarnDisarm			= "무장해제의 특수 경고 보기",
	specWarnBrew			= "흑맥주요정의 맥주 특수 경고 보기",
	specWarnBrewStun		= "흑맥주요정의 기절 특수 경고 보기",
	PlaySoundOnDisarm		= "무장 해제의 소리 재생",
	YellOnBarrel			= "맥주통을 가지게 될 경우 외치기"
})

L:SetMiscLocalization{
	YellBarrel		= "저에게 맥주통!"
}

-------------------
-- Headless Horseman --
-------------------
L = DBM:GetModLocalization("HeadlessHorseman")

L:SetGeneralLocalization({
	name = "저주받은 기사"
})

L:SetWarningLocalization({
	warnHorsemanSoldiers		= "고동치는 호박 생성!",
	specWarnHorsemanHead		= "머리 생성! 머리로 대상 전환!"
})

L:SetOptionLocalization({
	warnHorsemanSoldiers		= "고동치는 호박 소환 경고 보기",
	specWarnHorsemanHead		= "저주받은 기사의 머리 대상 전환 특수 경고 보기"
})

L:SetMiscLocalization({
	HorsemanHead				= "냉큼 이리 와라, 이 얼간아!",
	HorsemanSoldiers			= "일어나라, 별사들이여. 나가서 싸워라! 이 쇠락한 기사에게 승리를 안겨다오!",
	SayCombatEnd				= "죽음은 이미 겪어 보았노라. 이제 어떤 모험이 날 기다리는가?"
})

------------------
-- Pit of Saron --
-------------------
-- Ick and Krick --
-------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "이크와 크리크"
})

L:SetWarningLocalization({
	warnPursuit			= "추격 : >%s<",
	specWarnToxic		= "독성 폐기물! 이동하세요!",
	specWarnPursuit		= "곧 당신을 추격합니다. 뛰세요!",
	specWarnPoisonNova	= "독 회오리! 뛰세요!",
	specWarnMines		= "폭발 탄막 - 이동하세요"	
})

L:SetOptionLocalization({
	warnPursuit				= "추격 대상 알리기",
	specWarnToxic			= "독성 폐기물로부터 영향을 받을 경우 특수 경고 보기",
	specWarnPursuit			= "당신을 추격 하게 될 경우 특수 경고 보기",
	specWarnPoisonNova		= "독 회오리를 시전 할 경우 특수 경고 보기(이동 관련)",
	specWarnMines			= "폭발 탄막을 시전 할 경우 특수 경고 보기(이동 관련)",	
	PlaySoundOnPoisonNova	= "독 회오리 특수 소리 재생",	
	PlaySoundOnPursuit		= "당신이 추격당할 경우 특수 소리 재생",	
	SetIconOnPursuitTarget	= "추격 대상에게 공격대 아이콘 설정"	
})

L:SetMiscLocalization({
--	IckPursuit		= "%s1|이;가; 당신을 쫓습니다!",
--	Barrage			= "%s1|이;가; 빠른 속도로 지뢰를 만들어냅니다!",
	IckPursuit		= "당신을 쫓습니다!",
	Barrage			= "빠른 속도로 지뢰를 만들어냅니다!",	
--	YellCombatEnd	= ""--in case removing kricks creatureid doesn't fix it thinking we wipe.	
})

--------------------------
-- Forgemaster Garfrost --
--------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "제련장인 가프로스트"
})

L:SetWarningLocalization({
	warnSaroniteRock			= "사로나이트 덩어리를 던졌습니다. - 위치 확인",
	specWarnSaroniteRock		= "당신에게 사로나이트를 던집니다. 이동!",
	specWarnSaroniteRockNear	= "당신 주변에 사로나이트를 던집니다. 주의하세요!",	
	specWarnPermafrost			= "%s : %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "사로나이트 덩어리 경고 보기 (영구 결빙을 없애기 위해)",
	specWarnSaroniteRock		= "사로나이트 던지기의 대상이 될 경우 특수 경고 보기",
	specWarnSaroniteRockNear	= "당신 주변에 사로나이트 던지기 대상이 있을 경우 특수 경고 보기",	
	specWarnPermafrost			= "영구 결빙 중첩이 많을 경우 특수 경고 보기(11 중첩)",
	SetIconOnSaroniteRockTarget	= "사로나이트 덩어리 대상 공격대 아이콘 설정"
})

L:SetMiscLocalization({
--	SaroniteRockThrow			= "%s1|이;가; 거대한 사로나이트 덩어리를 당신에게 던집니다!"
	SaroniteRockThrow			= "거대한 사로나이트 덩어리를 당신에게 던집니다!"	
})

-------------------
-- Scourgelord Tyrannus --
-------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "스컬지군주 티라누스"
})

L:SetWarningLocalization({
--	specTyrannusEngaged			= "스컬지군주 티라누스가 곧 내려옵니다. - 준비하세요.",
	specWarnIcyBlast			= "얼음 작렬! 이동하세요!",
	specWarnHoarfrost			= "당신에게 흰 서리!",
	specWarnHoarfrostNear		= "당신 주변에 흰 서리! 이동하세요!",
	specWarnOverlordsBrand		= "당신에게 대군주의 낙인"
})

L:SetTimerLocalization{
	TimerCombatStart			= "전투 시작"
}

L:SetOptionLocalization({
--	specTyrannusEngaged			= "스컬지군주 티라누스 착지 특수 경고 보기",
	specWarnIcyBlast			= "얼음 작렬로부터 데미지를 받을 경우 특수 경고 보기",
	specWarnHoarfrost			= "당신이 흰 서리의 대상이 될 경우 특수 경고 보기",
	specWarnHoarfrostNear		= "당신의 주변에 흰 서리 대상이 있을 경우 특수 경고 보기",
	specWarnOverlordsBrand		= "대군주의 낙인에 영향을 받을 경우 특수 경고 보기",	
	TimerCombatStart			= "전투 시작 타이머 보기",	
	SetIconOnHoarfrostTarget	= "흰서리 대상에게 공격대 아이콘 설정"
})

L:SetMiscLocalization({
	CombatStart					= "아아. 용감하고, 용감한 모험가들아, 참견도 이제 끝이다. 네놈들 뒤의 굴에서 뼈와 칼이 내는 소리가 들리는가? 네놈들에게 곧 닥칠 죽음의 소리다.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget				= "(%S+)|1을;를; 노려보며 얼음 공격을 준비합니다!",
	YellCombatEnd				= "말도 안돼... 서릿발송곳니... 경고를..."
})

--------------------
-- Forge of Souls --
--------------------
--------------
-- Bronjahm --
--------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "브론잠"
})

L:SetWarningLocalization({
	warnSoulstormSoon		= "곧 영혼폭풍!",
	specwarnSoulstorm		= "영혼폭풍! 들어가세요!"
})

L:SetOptionLocalization({
	warnSoulstormSoon		= "영혼폭풍 사전 경고 보기(40%이하 일 때)",
	specwarnSoulstorm		= "영혼폭풍을 시전 할 경우 특수 경고 보기(이동경고)"
})

-------------------
-- Devourer of Souls --
-------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "영혼의 포식자"
})

L:SetWarningLocalization({
	specwarnMirroredSoul		= "비춰진 영혼! 딜 중지!",
	specwarnWailingSouls		= "울부짖는 영혼",	-- Get behind
	specwarnPhantomBlast		= "차단!"
})

L:SetOptionLocalization({
	specwarnMirroredSoul		= "비춰진 영혼에 대한 딜 중지 특수 경고 보기",
	specwarnWailingSouls		= "울부짖는 영혼을 시전 할 경우 특수 경고 보기",	
	specwarnPhantomBlast		= "환영 폭발을 시전할 경우 특수 경고 보기(차단을 위해)"
})

-------------------------
-- Halls of Reflection --
-------------------------
-- Wave Timers --
-----------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "웨이브 타이머"
})

L:SetWarningLocalization({
	WarnNewWaveSoon		= "곧 새로운 웨이브",
	WarnNewWave			= "%s 시작"
})

L:SetTimerLocalization({
	TimerNextWave		= "다음 웨이브"
})

L:SetOptionLocalization({
	WarnNewWave				= "새로운 보스가 올 때 경고 보기",
	WarnNewWaveSoon			= "새로운 웨이브 사전 경고 보기",
	ShowAllWaveWarnings		= "모든 웨이브 사전 경고 보기",	--Is this a warning or a pre-warning?
	TimerNextWave			= "다음 웨이브 타이머 보기(5번째 보스 웨이브 이후)",
	ShowAllWaveTimers		= "모든 웨이브의 타이머 보기"
})

L:SetMiscLocalization({
	Falric				= "팔릭",
	WaveCheck			= "영혼 공격 = (%d+)/10"
})

------------
-- Falric --
------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "팔릭"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

------------
-- Marwyn --
------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "마윈"
})

L:SetWarningLocalization({
	SpecWarnWellCorruption	= "부패의 샘!! 이동!!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecWarnWellCorruption	= "부패의 샘으로부터 영향을 받을 경우 특수 경고 보기"
})

L:SetMiscLocalization({
})

---------------------
-- Lich King Event --
---------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "리치 왕 이벤트"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "그는... 너무 강하다. 영웅들이여, 어서... 이쪽으로 오라! 즉시 이곳을 떠나야 한다! 도망치는 동안 그를 잡아놓을 수 있도록 조치를 취하겠다.",
	YellCombatEnd	= "발사! 발사!"
})
