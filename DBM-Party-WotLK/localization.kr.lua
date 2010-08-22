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
---------------------
-- 문지기 크릭시르 --
---------------------
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

----------------
-- 하드로녹스 --
----------------
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

--------------
-- 아눕아락 --
--------------
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

---------------------------------
-- 시간의 동굴 : 옛 스트라솔름 --
---------------------------------
-- 살덩이갈고리 --
------------------
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

-----------------------
-- 살덩이창조자 살람 --
-----------------------
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

L:SetMiscLocalization({
	Outro	= "너의 여정은 이제 막 시작이다, 젊은 왕자여. 병사들을 모아 극한의 땅, 노스렌드로 나를 찾아와라. 그곳에서 모든 일이 결판날 것이다. 네 진정한 운명도 그곳에서 시작되지."
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
	TimerRoleplay		= "아서스 이야기"	
})

L:SetOptionLocalization({
	WarningWaveNow		= optionWarning:format("새로운 웨이브"),
	TimerWaveIn			= "다음 웨이브 타이머 보기 (5번째 보스 웨이브 이후)",
	TimerRoleplay		= "시작 이벤트 타이머 보기"
})

L:SetMiscLocalization({
	Meathook		= "살덩이갈고리",
	Salramm			= "살덩이창조자 살람",
	Devouring		= "개걸스러운 구울",
	Enraged			= "격노한 구울",
	Necro			= "정예 강령술사",
	Fiend			= "어둠의 강령술사",
	Stalker			= "무덤 거미",
	Abom			= "위액 골렘",
	Acolyte			= "수행 사제",
	Wave1			= "%d %s",
	Wave2			= "%d %s 그리고 %d %s",
	Wave3			= "%d %s, %d %s 그리고 %d %s",
	Wave4			= "%d %s, %d %s, %d %s 그리고 %d %s",
	WaveBoss		= "%s",
	WaveCheck		= "스컬지 공격 = (%d+)/10",
	Roleplay		= "드디어 나타나셨군, 우서",
	Roleplay2		= "준비가 된 것 같군. 명심해라. 이들은 끔찍한 역병에 걸렸고, 어차피 죽을 것이다. 스컬지의 손아귀에서 로데론을 지키려면 스트라솔름을 정화해야 한다. 가자."
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
	WarnCrystalHandler		= "Crystal Handler spawned (%d remaining)"
})

L:SetTimerLocalization({
	timerCrystalHandler		= "Crystal Handler spawns"
})

L:SetOptionLocalization({
	WarnCrystalHandler		= "Show warning when Crystal Handler spawns",
	timerCrystalHandler		= "Show timer for next Crystal Handler spawn"
})

L:SetMiscLocalization({
	YellPull				= "The chill you feel is the herald of your doom!",
	HandlerYell				= "Bolster my defenses! Hurry, curse you!",
	Phase2					= "Surely you can see the futility of it all!",
	YellKill				= "Your efforts... are in vain."
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
	SetIconOnOverloadTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(52658)
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
	timerEvent		= "이벤트"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("# 페이즈"),
	timerEvent		= "이벤트 타이머 보기"
})

L:SetMiscLocalization({
--	Pull		= "해답을 찾을 시간입니다! 이제 가보자고요!",
	Pull		= "이제 잘 보시라고요! 제가 눈 깜짝할 사이에 정보를...",
	Phase1		= "보안 경보를 발령합니다. 출처 불명의 역사 자료 분석은 하위 등급 대기열로 이전됩니다. 방어 작업을 시작합니다.",
	Phase2		= "위협 지수가 임계점을 돌파했습니다. 천체 기록을 중단합니다. 보안 수준이 상승했습니다.",
	Phase3		= "위협 지수가 높습니다. 공허 분석을 종료합니다. 안전성 검증을 시작합니다.",
	Kill		= "정상 작동 중입니다. 생명체가 식별되었습니다. 환영합니다, 브란브론짱 님. 질문은?"
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
	MakeitCountTimer		= "매 순간을 소중히 업적 타이머 보기"
})

L:SetMiscLocalization({
	MakeitCountTimer		= "매 순간을 소중히"
})

--------------------
-- 마법사 군주 우롬 --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "마법사 군주 우롬"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "어리석은 족속들!"
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
	WarningShiftEnd		= "차원 이동 종료"		-- translate
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd		= optionWarning:format(GetSpellInfo(51162).." 종료") 	-- translate the word 'ending'
})

L:SetMiscLocalization({
	MakeitCountTimer	= "매 순간을 소중히"
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

L:SetMiscLocalization({
})

---------------------
-- 약탈자 잉그바르 --
---------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "약탈자 잉그바르"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "안 돼! 난 더 잘할 수... 있는데..."
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

L:SetMiscLocalization({
	CombatStart		= "웬 놈들이 감히 여길? 정신 차려라, 형제들아! 녀석들을 처치하면 거하게 한 상 차려 주마!",
	Phase2			= "피도 눈물도 없는 것들아! 불쌍한 비룡을 괴롭히다니, 가만두지 않겠다!"
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
	timerRoleplay		= "스발라 소로우그레이브 활성"
})

L:SetOptionLocalization({
	timerRoleplay		= "스발라 소로우그레이브 활성 타이머 보기"
})

L:SetMiscLocalization({
	SvalaRoleplayStart	= "주인님! 당신께서 주신 일을 행했습니다. 이제, 축복을 내려 주소서!"
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
	TimerCombatStart	= "전투 시작"
})

L:SetOptionLocalization({
	TimerCombatStart	= "전투 시작 타이머 보기"
})

L:SetMiscLocalization({
	CyanArrived			= "훌륭한 방어였다만, 도시를 지키게 둘 수는 없지! 직접 말리고스 님의 의지를 실현하리라!"
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
	WarningPortalSoon		= "곧 새로운 포탈이 열립니다.",
	WarningPortalNow		= "포탈 #%d",
	WarningBossNow			= "곧 보스 등장"
})

L:SetTimerLocalization({
	TimerPortalIn			= "포탈 #%d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("새로운 포탈"),
	WarningPortalSoon		= optionPreWarning:format("새로운 포탈"),
	WarningBossNow			= optionWarning:format("보스 등장"),
	TimerPortalIn			= "다음 포탈 타이머 보기(보스 이후)",
	ShowAllPortalTimers		= "모든 포탈 타이머 보기"
})

L:SetMiscLocalization({
--	yell1 			= "요새 경비병들이여, 이제 이곳을 떠난다! 여기 모험가들이 맡아 줄 테니 어서 후퇴하라!",
	Sealbroken		= "문을 부쉈다! 달라란으로 가는 길이 열렸다! 이제 마력 전쟁의 끝을 내자!",	
	WavePortal		= "차원문 열림: (%d+)/18"
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
	warnExplode				= "구울 폭발을 시전합니다. 이동하세요!"
})

L:SetTimerLocalization{
	TimerCombatStart		= "전투 시작"
}

L:SetOptionLocalization({
	TimerCombatStart		= "전투 시작 타이머 보기",
	warnExplode				= "구울 폭발을 시전할 경우 경고 알리기",
	SetIconOnMarkedTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(67823)
})

L:SetMiscLocalization({
	Pull					= "Well done. You have proven yourself today-",
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
})

L:SetOptionLocalization({
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
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd			= "훌륭히 해내셨군요!"
})

---------------------
-- Eadric the Pure --
---------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "성기사 에드릭"
})

L:SetWarningLocalization({
	specwarnRadiance			= "광휘! 뒤돌아보세요!"
})

L:SetOptionLocalization({
	specwarnRadiance			= "$spell:66935의 특수 경고 보기.",
	SetIconOnHammerTarget		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(66940)
})

L:SetMiscLocalization({
	YellCombatEnd				= "항복! 제가 졌습니다. 훌륭한 솜씨군요. 이제 집에 가도 되겠습니까?"
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
	specWarnPursuit		= "당신을 추격합니다. - 뛰세요!"
})

L:SetOptionLocalization({
	warnPursuit				= "추격 대상 알리기",
	specWarnPursuit			= "당신을 추격 하게 될 경우 특수 경고 보기",
	SetIconOnPursuitTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68987)
})

L:SetMiscLocalization({
--	IckPursuit			= "%s|1이;가; 당신을 쫓습니다!",
	IckPursuit			= "당신을 쫓습니다!",
	Barrage				= "%s|1이;가; 빠른 속도로 지뢰를 만들어냅니다!"
--	YellCombatEnd		= ""--in case removing kricks creatureid doesn't fix it thinking we wipe.	
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
	warnSaroniteRock			= "$spell:70851 대상 알리기",
	specWarnSaroniteRock		= "$spell:70851의 대상이 될 경우 특수 경고 보기",
	specWarnSaroniteRockNear	= "당신 주변에 $spell:70851 대상이 있을 경우 특수 경고 보기",	
	specWarnPermafrost			= "$spell:70336 중첩이 많을 경우 특수 경고 보기(11 중첩)",
	AchievementCheck			= "Announce 'Doesn't Go to Eleven' achievement warnings to party chat",	
	SetIconOnSaroniteRockTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70851)
})

L:SetMiscLocalization({
--	SaroniteRockThrow			= "%s|1이;가; 거대한 사로나이트 덩어리를 당신에게 던집니다!"
	SaroniteRockThrow			= "거대한 사로나이트 덩어리를 당신에게 던집니다!",
	AchievementFailed			= ">> ACHIEVEMENT FAILED: %s has %d stacks of Permafrost <<"	
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
	specWarnHoarfrost			= "당신에게 흰 서리!",
	specWarnHoarfrostNear		= "당신 주변에 흰 서리! 이동하세요!",
})

L:SetTimerLocalization{
	TimerCombatStart			= "전투 시작"
}

L:SetOptionLocalization({
--	specTyrannusEngaged			= "스컬지군주 티라누스 착지 특수 경고 보기",
	specWarnHoarfrost			= "$spell:69246의 대상이 될 경우 특수 경고 보기",
	specWarnHoarfrostNear		= "주변에 $spell:69246 대상이 있을 경우 특수 경고 보기",
	TimerCombatStart			= "전투 시작 타이머 보기",	
	SetIconOnHoarfrostTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69246)
})

L:SetMiscLocalization({
	CombatStart					= "아아. 용감하고 용감한 모험가들아, 참견도 이제 끝이다. 네놈들 뒤에 있는 굴에서 뼈와 칼이 부딪치는 소리가 들리는가? 네놈들에게 곧 닥칠 죽음의 소리다.", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
--	HoarfrostTarget				= "(%S+)|1을;를; 노려보며 얼음 공격을 준비합니다!",
	HoarfrostTarget				= "노려보며 얼음 공격을 준비합니다!",
	YellCombatEnd				= "말도 안 돼... 서릿발송곳니... 경고를..."
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
	specwarnSoulstorm		= "영혼폭풍! 들어가세요!"
})

L:SetOptionLocalization({
	specwarnSoulstorm		= "$spell:68872을 시전 할 경우 특수 경고 보기(이동경고)"
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
	specwarnWailingSouls		= "울부짖는 영혼"	-- Get behind

})

L:SetOptionLocalization({
	specwarnMirroredSoul		= "$spell:69051 딜 중지 특수 경고 보기",
	specwarnWailingSouls		= "$spell:68899을 시전 할 경우 특수 경고 보기",	
	SetIconOnMirroredTarget		= "$spell:69051 대상 공격대 아이콘 설정"	
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
	WarnNewWaveSoon			= "새로운 웨이브 사전 경고 보기(5 웨이브 보스 이후)",
	ShowAllWaveWarnings		= "모든 웨이브 사전 경고 보기",	--Is this a warning or a pre-warning?
	TimerNextWave			= "다음 웨이브 타이머 보기(5 웨이브 보스 이후)",
	ShowAllWaveTimers		= "모든 웨이브의 사전 경고 및 타이머 보기(부정확)"
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
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
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
	WarnWave1		= "분노한 구울 6, 되살아난 의술사 1 등장",--6 Ghoul, 1 WitchDocter
	WarnWave2		= "분노한 구울 6, 되살아난 의술사 2, 육중한 누더기골렘 1 등장",--6 Ghoul, 2 WitchDocter, 1 Abom
	WarnWave3		= "분노한 구울 6, 되살아난 의술사 2, 육중한 누더기골렘 2 등장",--6 Ghoul, 2 WitchDocter, 2 Abom
	WarnWave4		= "분노한 구울 12, 되살아난 의술사 4, 육중한 누더기골렘 3 등장"--12 Ghoul, 4 WitchDocter, 3 Abom
})

L:SetTimerLocalization({
	achievementEscape	= "탈출 시간"
})

L:SetOptionLocalization({
	ShowWaves		= "웨이브 시작전 경고 보기"
})

L:SetMiscLocalization({
	ACombatStart	= "He is too powerful. We must leave this place at once! My magic can hold him in place for only a short time. Come quickly, heroes!",
	HCombatStart	= "그는... 너무 강하다. 영웅들이여, 어서... 이쪽으로 오라! 즉시 이곳을 떠나야 한다! 도망치는 동안 그를 잡아놓을 수 있도록 조치를 취하겠다.",
	Ghoul			= "분노한 구울",--creature id 36940. Not sure how to use these in function above to simplify locals though. :\
	Abom			= "육중한 누더기골렘",--creature id 37069
	WitchDoctor		= "되살아난 의술사",--creature id 36941	
	Wave1			= "도망칠 방법은 없다!",
	Wave2			= "무덤의 한기에 굴복하라.",
	Wave3			= "또 막다른 곳이다.",
	Wave4			= "얼마나 더 싸울 수 있겠느냐?",	
	YellCombatEnd	= "발사! 발사!"
})
