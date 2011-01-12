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
	name = "기본 투기장 기능"
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
	TimerGY 	= "%s"
})

L:SetMiscLocalization({
	BgStart60 	= "알터랙 계곡 전투 개시 1분 전...",
	BgStart30 	= "알터랙 계곡 전투 개시 30초 전..."
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
	ScoreExpr 		= "(%d+)/1600",
	Alliance 		= "얼라이언스",
	Horde 			= "호드",
	WinBarText 		= "%s 획득",
	BasesToWin		= "필요 점령 갯수 : %d",
	Flag 			= "깃발"
})

L:SetTimerLocalization({
	TimerStart 				= "게임 시작", 
	TimerCap 				= "%s"
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
L = DBM:GetModLocalization("EyeoftheStorm")

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
	FlagDropped 	= "깃발을 떨어뜨렸습니다!"

})

L:SetTimerLocalization({
	TimerStart 		= "게임 시작", 
	TimerFlag		= "깃발 재생성"
})

L:SetOptionLocalization({
	TimerStart 		= "시작 타이머 보기",
	TimerWin 		= "점령 타이머 보기",
	TimerFlag 		= "깃발 재생성 타이머 보기",
	ShowPointFrame 	= "깃발 운반 및 필요 예상 포인트 보기"
})

--------------------
--  Warsong Gulch --
--------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "전쟁노래 협곡"
})

L:SetMiscLocalization({
	BgStart60 = "1분 후 전투가 시작됩니다!",
	BgStart30 = "30초 후 전투가 시작됩니다. 준비하십시오!",
	Alliance = "얼라이언스",
	Horde = "호드",	
	InfoErrorText 		= "전투에서 벗어나면 깃발 운반자 타겟팅 기능이 복구됩니다.",
	ExprFlagPickUp 		= "(.+)|1이;가; (.+) 깃발을 손에 넣었습니다!",	
	ExprFlagCaptured 	= "(.+)|1이;가; (.+) 깃발 쟁탈에 성공했습니다!",
	ExprFlagReturn 		= "(.+)|1이;가; (.+) 깃발을 되찾았습니다!",
	FlagAlliance 		= "얼라이언스 깃발 :",
	FlagHorde 			= "호드 깃발 :",
	FlagBase 			= "기지"
})

L:SetTimerLocalization({
	TimerStart 			= "게임 시작", 
	TimerFlag 			= "깃발 재생성",
})

L:SetOptionLocalization({
	TimerStart  			 	= "시작 타이머 보기",
	TimerFlag 					= "깃발 재생성 타이머 보기",
	ShowFlagCarrier 	 	 	= "깃발 운반자 보기",
	ShowFlagCarrierErrorNote	= "전투중 깃발 운반자 에러 메세지 보기"
})

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "정복의 섬"
})

L:SetWarningLocalization({
	WarnSiegeEngine			= "공성 전차 준비!",
	WarnSiegeEngineSoon		= "공성 전차 완료 10초 전"
})

L:SetTimerLocalization({
	TimerStart				= "게임 시작", 
	TimerPOI				= "%s",
	TimerSiegeEngine		= "공성 전차 준비"	
})

L:SetOptionLocalization({
	TimerStart				= "게임 시작 타이머 보기", 
	TimerPOI				= "획득 타이머 보기",
	TimerSiegeEngine		= "공성 전차 제작 타이머 보기",
	WarnSiegeEngine			= "공성 전차가 준비되었을 때 경고 알리기",
	WarnSiegeEngineSoon		= "공성 전차가 곧 준비 될 때 경고 알리기"	
})

L:SetMiscLocalization({
	BgStart60				= "60초 후 전투가 시작됩니다.",
	BgStart30				= "30초 후 전투가 시작됩니다.",
	BgStart15				= "15초 후 전투가 시작됩니다.",
	SiegeEngine				= "공성 전차",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "공성 전차를 수리하는 동안 날 좀 지켜 달라고. 필요하면 저기 있는 시포리움 폭약을 관문에 사용해!",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here.  They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "반쯤 됏다고! 얼라이언스 놈들이 가까이 못오게 해줘. 계약서에 전투 얘긴 없었다고!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "이제 이 공성 전차를 끌고 나가도 좋아!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"	
})

------------------
--  Twin Peaks  --
------------------
L = DBM:GetModLocalization("TwinPeaks")

L:SetGeneralLocalization({
	name = "쌍둥이 봉우리"
})

L:SetMiscLocalization({
	BgStart60 			= "1분 후 전투가 시잡됩니다!",
	BgStart30 			= "30초 후 전투가 시작됩니다! 준비하십시오!",
	ZoneName 			= "쌍둥이",
	Alliance 			= "얼라이언스",
	Horde 				= "호드",	
	InfoErrorText		= "전투에서 벗어나면 깃발 운반자 타겟팅 기능이 복구됩니다.",
	ExprFlagPickUp		= "(.+)|1이;가; (.+) 깃발을 손에 넣었습니다!",
	ExprFlagCaptured	= "(.+)|1이;가; (.+) 깃발 쟁탈에 성공했습니다!",
	ExprFlagReturn		= "(.+)|1이;가; (.+) 깃발을 되찾았습니다!",
	FlagAlliance		= "얼라이언스 깃발: ",
	FlagHorde			= "호드 깃발: ",
	FlagBase			= "기지"
})

L:SetTimerLocalization({
	TimerStart	= "게임 시작", 
	TimerFlag	= "깃발 재생성"
})

L:SetOptionLocalization({
	TimerStart					= "시작 타이머 보기",
	TimerFlag					= "깃발 재생성 타이머 보기",
	ShowFlagCarrier				= "깃발 운반자 보기",
	ShowFlagCarrierErrorNote	= "전투중 깃발 운반자 에러 메세지 보기"
})


--------------------------
--  Battle for Gilneas  --
--------------------------
L = DBM:GetModLocalization("Gilneas")

L:SetGeneralLocalization({
	name = "길니아스 전투지"	-- translate
})

L:SetMiscLocalization({
	BgStart60 		= "1분 후 전투가 시작됩니다.",
	BgStart30 		= "30초 후 전투가 시작됩니다.",
	ScoreExpr 		= "(%d+)/2000",
	Alliance 		= "얼라이언스",
	Horde 			= "호드",
	WinBarText 		= "%s 획득",
	BasesToWin		= "필요 점령 갯수 : %d",
	Flag 			= "깃발"
})

L:SetTimerLocalization({
	TimerStart 				= "게임 시작", 
	TimerCap 				= "%s"
})

L:SetOptionLocalization({
	TimerStart  				= "시작 타이머 보기",
	TimerWin 					= "승리 예상 타이머 보기",
	TimerCap 					= "깃발 점령 타이머 보기",
	ShowGilneasEstimatedPoints 	= "승/패 예상 포인트 보기",
	ShowGilneasBasesToWin 		= "필요 점령 갯수 보기"
})