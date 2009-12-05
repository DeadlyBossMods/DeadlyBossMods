if GetLocale() ~= "koKR" then return end

local L

----------------------------
--  General BG functions  --
----------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "기본 전장 기능"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass		= "스코어 화면의 유저 이름을 클래스 이름으로 보이기",
	ShowInviteTimer		= "전장 입장 타이머 보이기",
	AutoSpirit			= "자동 부활"
})

L:SetMiscLocalization({
	ArenaInvite	= "전투 참여"
})

--------------
--  투기장  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "투기장"
})

L:SetTimerLocalization({
	TimerStart	= "게임 시작",
	TimerShadow	= "어둠의 시야"
})

L:SetOptionLocalization({
	TimerStart 		= "시작 타이머 보이기",
	TimerShadow 	= "어둠의 눈 타이머 보기"	
})

L:SetMiscLocalization({
	Start60 	= "투기장 전투 시작 1분 전입니다!",
	Start30 	= "투기장 전투 시작 30초 전입니다!",
	Start15 	= "투기장 전투 시작 15초 전입니다!"
})

---------------
--  Alterac  --
---------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "알터랙 계곡"
})

L:SetTimerLocalization({
	TimerStart 	= "게임 시작", 
	TimerTower	= "%s",
	TimerGY 	= "%s",
})

L:SetMiscLocalization({
	BgStart60 	= "알터랙 계곡 전투 개시 1분 전...",
	BgStart30 	= "알터랙 계곡 전투 개시 30초 전...",
	ZoneName 	= "알터랙 계곡",
})

L:SetOptionLocalization({
	TimerStart  = "시작 타이머 보기",
	TimerTower 	= "탑 점령 타이머 보기",
	TimerGY 	= "무덤 점령 타이머 보기",
	AutoTurnIn 	= "퀘스트 아이템 자동 수락"
})

---------------
--  Arathi  --
---------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "아라시 분지"
})

L:SetMiscLocalization({
	BgStart60 		= "1분 후 아라시 분지 전투가 시작됩니다.",
	BgStart30 		= "30초 후 아라시 분지 전투가 시작됩니다.",
	ZoneName		= "아라시 분지",
	ScoreExpr 		= "(%d+)/1600",
	Alliance 		= "얼라이언스",
	Horde 			= "호드",
	WinBarText 		= "%s 획득",
	BasesToWin		= "필요 점령 갯수 : %d",
	Flag 			= "깃발"
})

L:SetTimerLocalization({
	TimerStart 				= "게임 시작", 
	TimerCap 				= "%s",
})

L:SetOptionLocalization({
	TimerStart  			= "시작 타이머 보기",
	TimerWin 				= "승리 예상 타이머 보기",
	TimerCap 				= "깃발 점령 타이머 보기",
	ShowAbEstimatedPoints 	= "승/패 예상 포인트 보기",
	ShowAbBasesToWin 		= "필요 점령 갯수 보기"
})

-----------------------
--  Eye of the Storm --
-----------------------
L = DBM:GetModLocalization("EyeOfTheStorm")

L:SetGeneralLocalization({
	name = "폭풍의 눈"
})

L:SetMiscLocalization({
	BgStart60		= "1분 후 폭풍의 눈 전투가 시작됩니다.",
	BgStart30 		= "30초 후 폭풍의 눈 전투가 시작됩니다.",
	ZoneName		= "폭풍의 눈",
	ScoreExpr 		= "(%d+)/1600",
	Alliance 		= "얼라이언스",
	Horde 			= "호드",
	WinBarText		= "%s 점령",
	FlagReset 		= "깃발이 제자리로 돌아갔습니다.!",
	FlagTaken 		= "^(.+)|1이;가; 깃발을 차지했습니다!",
	FlagCaptured 	= "(.+)|1이;가; 깃발을 차지했습니다!",
	FlagDropped 	= "깃발을 떨어뜨렸습니다!",

})

L:SetTimerLocalization({
	TimerStart 		= "게임 시작", 
	TimerFlag		= "깃발 재생성",
})

L:SetOptionLocalization({
	TimerStart 		= "시작 타이머 보기",
	TimerWin 		= "점령 타이머 보기",
	TimerFlag 		= "깃발 재생성 타이머 보기",
	ShowPointFrame 	= "깃발 운반 및 필요 예상 포인트 보기",
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "전쟁노래 협곡"
})

L:SetMiscLocalization({
	BgStart60 = "1분 후 전쟁노래 협곡 전투가 시작됩니다!",
	BgStart30 = "30초 후 전쟁노래 협곡 전투가 시작됩니다. 준비하십시오!",
	ZoneName = "전쟁노래 협곡",
	Alliance = "얼라이언스",
	Horde = "호드",	
	InfoErrorText 		= "전투에서 벗어나면 깃발 운반자 타겟팅 기능이 복구됩니다.",
	ExprFlagPickUp 		= "(.+)|1이;가; (.+) 깃발을 손에 넣었습니다!",	
	ExprFlagCaptured 	= "(.+)|1이;가; (.+) 깃발 쟁탈에 성공했습니다!",
	ExprFlagReturn 		= "(.+)|1이;가; (.+) 깃발을 되찾았습니다!",
	FlagAlliance 		= "얼라이언스 깃발 :",
	FlagHorde 			= "호드 깃발 :",
	FlagBase 			= "기지",
})

L:SetTimerLocalization({
	TimerStart 			= "게임 시작", 
	TimerFlag 			= "깃발 재생성",
})

L:SetOptionLocalization({
	TimerStart  			 	= "시작 타이머 보기",
	TimerFlag 					= "깃발 재생성 타이머 보기",
	ShowFlagCarrier 	 	 	= "깃발 운반자 보기",
	ShowFlagCarrierErrorNote	= "전투중 깃발 운반자 에러 메세지 보기",
})



----------------
--  아카본  --
----------------

L = DBM:GetModLocalization("Archavon")

L:SetGeneralLocalization({
	name = "바위 감시자 아카본"
})

L:SetWarningLocalization({
	WarningShards	= "바위 조각 대상 : >%s<",
	WarningGrab		= "분쇄의 도약 : >%s<"
})

L:SetTimerLocalization({
	TimerShards		 = "바위 조각: %s"
})

L:SetMiscLocalization({
	TankSwitch 		= "%%s 이 (%S+) 으로 탱커 전환!"
})

L:SetOptionLocalization({
	TimerShards		= "바위 조각 타이머 보기",
	WarningShards 	= "바위 조각 경고 보기",
	WarningGrab 	= "분쇄의 도약 경고 보기"
})

--------------
--  Emalon  --
--------------

L = DBM:GetModLocalization("Emalon")

L:SetGeneralLocalization{
	name = "폭풍의 감시자 에말론"
}

L:SetWarningLocalization{
	specWarnNova 		= "번개 회오리 - 피하세요!",
	warnNova 			= "번개 회오리",
	warnOverCharge		= "과충전"
}

L:SetTimerLocalization{
	timerMobOvercharge	= "과충전 폭발"
}

L:SetOptionLocalization{
	specWarnNova 		= ("특수 경보로 볼 |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "번개 회오리"),
	warnNova 			= ("공격대 경고 |cff71d5ff|Hspell:%d|h%s|h|r"):format(64216, "번개 회오리"),
	warnOverCharge 		= ("공격대 경고 |cff71d5ff|Hspell:%d|h%s|h|r"):format(64218, "과충전"),
	NovaSound			= "번개 회오리 특수 사운드 재생",		
	timerMobOvercharge	= "과충전 된 몹의 시간 보기(디버프 중첩)",
	RangeFrame			= "거리 프레임 보기"
}

---------------
--  Koralon  --
---------------

L = DBM:GetModLocalization("Koralon")

L:SetGeneralLocalization{
	name = "화염 감시자 코랄론"
}

L:SetWarningLocalization{
	SpecWarnCinder		= "당신은 불타는 잿더미에 있습니다! 뛰세요!!"
}

L:SetTimerLocalization{
}

L:SetOptionLocalization{
	SpecWarnCinder		= "불타는 잿더미 위에 서있을 경우 특수 경고 보기",
	PlaySoundOnCinder	= "불타는 잿더미 위에 서있을 경우 소리 재생하기",
}

L:SetMiscLocalization{
	Meteor	= "%s이 유성 주먹을 시전합니다!"
}


------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleOfConquest")

L:SetGeneralLocalization({
	name = "정복의 섬"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerStart		= "게임 시작", 
	TimerPOI		= "%s",
})

L:SetOptionLocalization({
	TimerStart		= "게임 시작 타이머 보기", 
	TimerPOI		= "획득 타이머 보기",
})

L:SetMiscLocalization({
	ZoneName		= "정복의 섬",
	BgStart60		= "60초 후 전투가 시작됩니다.",
	BgStart30		= "30초 후 전투가 시작됩니다.",
	BgStart15		= "15초 후 전투가 시작됩니다.",
})

