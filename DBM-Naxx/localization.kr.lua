if GetLocale() ~= "koKR" then return end

local L

-------------------
--  거미 지구    --
-------------------
-------------------
--  아눕레칸     --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "아눕레칸"
})

L:SetWarningLocalization({
	SpecialLocust		= "메뚜기 떼 시작!!",
	WarningLocustFaded	= "메뚜기 떼가 사라졌습니다!!"
})

L:SetOptionLocalization({
	SpecialLocust		= "메뚜기 떼 특수 경고 보기",
	WarningLocustFaded	= "메뚜기 떼 사라짐 경고 보기",
	TimerLocustFade 	= "메뚜기 떼 사라짐 타이머 보기"
})

---------------------
--  귀부인 펠리나  --
---------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "귀부인 펠리나"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "귀부인의 은총 종료 5초 전",
	WarningEmbraceExpired	= "귀부인의 은총 사라짐",
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "귀부인의 은총 종료 경고 보기",
	WarningEmbraceExpired	= "귀부인의 은총 사라짐 경고 보기",
})

---------------
--  맥스나   --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "맥스나"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "5 초 후 거미의 입맞춤",
	WarningSpidersNow	= "거미의 입맞춤!!"
})

L:SetTimerLocalization({
	TimerSpider		= "다음 거미의 입맞춤"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "거미의 입맞춤 사전 경고 보기",
	WarningSpidersNow	= "거미의 입맞춤 경고 보기",
	TimerSpider			= "다음 거미의 입맞춤 타이머 보기"	
})

L:SetMiscLocalization({
	YellWebWrap			= "저 거미줄에 걸렸어요!! 살려주세요!!"
})

---------------
-- 역병 지구 --
---------------
---------------------
--  역병술사 노스  --
---------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "역병술사 노스"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "순간이동!!",
	WarningTeleportSoon	= "20초 후 순간이동",
})

L:SetTimerLocalization({
	TimerTeleport		= "순간이동",
	TimerTeleportBack	= "방으로 순간이동"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "순간이동 경고 보기",
	WarningTeleportSoon		= "순간이동 사전 경고 보기",
	TimerTeleport			= "순간이동 타이머 보기",
	TimerTeleportBack		= "방으로 순간이동 타이머 보기"
})

--------------------------
--  부정의 헤이건  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "부정의 헤이건"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "순간이동!",
	WarningTeleportSoon	= "%d초 후 순간이동",
})

L:SetTimerLocalization({
	TimerTeleport		= "순간이동",
})

L:SetOptionLocalization({
	WarningTeleportNow		= "순간이동 경고 보기",
	WarningTeleportSoon		= "순간이동 사전 경고 보기",
	TimerTeleport			= "순간이동 타이머 보기",
})

----------------
--  로데브  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "로데브"
})

L:SetWarningLocalization({
	WarningHealSoon		= "3초 후 힐 가능!!",
	WarningHealNow		= "지금 힐!!!!!"
})

L:SetOptionLocalization({
	WarningHealSoon		= "힐 시전 사전 경고 보기",
	WarningHealNow		= "힐 가능 경고 보기",
	SporeDamageAlert	= "포자에게 데미지를 주는 공격대원에게 귓속말 보내기 및 알리기\n(공대장 및 경보 권한이 있을 경우)"
})

-----------------
-- 피조물 지구 --
-----------------
-----------------
--  패치워크  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "패치워크"
})

L:SetOptionLocalization({
	WarningHateful = "증오의 일격 대상자를 공격대 채팅창에 알리기\n(만약 당신이 공대장의 권한이 있거나, 승급을 받은 유저라면 이 기능을 사용할 수 있습니다.)"
})

L:SetMiscLocalization({
	yell1 = "패치워크랑 놀아줘!",
	yell2 = "켈투자드님이 패치워크 싸움꾼으로 만들었다.",
	HatefulStrike = "증오의 일격 --> %s [%s]"
})

-----------------
--  그라불루스  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "그라불루스"
})

L:SetOptionLocalization({
	SpecialWarningInjection		= "돌연변이 유발 특수 경고 보기",
	SetIconOnInjectionTarget	= "돌연변이 유발 대상 공격대 아이콘 설정"
})

L:SetWarningLocalization({
	SpecialWarningInjection		= "당신에게 돌연변이 유발!!"
})

L:SetTimerLocalization({
})

-------------
--  글루스  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "글루스"
})

----------------
--  타디우스  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "타디우스"
})

L:SetMiscLocalization({
	Yell	= "스탈라그, 박살낸다!",
	Emote	= "%s 광폭화!",
	Emote2	= "테슬라 코일!!",
	Boss1 = "퓨진",
	Boss2 = "스탈라그",
	Charge1 = "마이너스 전하",
	Charge2 = "플러스 전하",
})

L:SetOptionLocalization({
	WarningChargeChanged	= "현재 전하가 바뀌었는지 경고 보기",
	WarningChargeNotChanged	= "현재 전하가 바뀌지 않았는지 경고 보기",
	TimerShiftCast			= "극성 변환 타이머 보기",
	ArrowsEnabled			= "화살표 보기 (일반 \"2 지역\" 공략)",
	ArrowsRightLeft			= "\"4 지역\" 공략을 위한 오른쪽/왼쪽 화살표 보기",
	ArrowsInverse			= "\"4 지역\" 공략을 위한 오른쪽/왼쪽 화살표를 거꾸로 보기",
})

L:SetWarningLocalization({
	WarningChargeChanged	= "%s로 전하가 바뀌었습니다.",
	WarningChargeNotChanged	= "전하가 바뀌지 않았습니다.",
})

L:SetOptionCatLocalization({
	Arrows	= "화살표",
})

-----------------
-- 군사 지구   --
-----------------
---------------------------
--  훈련교관 라주비어스  --
---------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "훈련교관 라주비어스"
})

L:SetMiscLocalization({
	Yell1 = "Show them no mercy!",
	Yell2 = "The time for practice is over! Show me what you have learned!",
	Yell3 = "Do as I taught you!",
	Yell4 = "Sweep the leg... Do you have a problem with that?"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "뼈 보호막 종료 경고 보기",
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "뼈 보호막 종료 5초 전"	
})

------------------------
--  영혼 착취자 고딕  --
------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "영혼 착취자 고딕"
})

L:SetOptionLocalization({
	TimerWave			= "다음 웨이브 타이머 보기",
	TimerPhase2			= "2 페이즈 타이머 보기",
	WarningWaveSoon		= "웨이브 사전 경고 보기",
	WarningWaveSpawned	= "웨이브 생성 경고 보기",
	WarningRiderDown	= "죽음의 기병이 죽었을 때 경고 보기",
	WarningKnightDown	= "죽음의 기사가 죽었을 때 경고 보기",
	WarningPhase2		= "2 페이즈 경고 보기"
})

L:SetTimerLocalization({
	TimerWave	= "웨이브 #%d",
	TimerPhase2	= "2 페이즈"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "웨이브 %d: %s 등장하기 3초 전",
	WarningWaveSpawned	= "웨이브 %d: %s 등장",
	WarningRiderDown	= "무자비한 죽음의 기병 죽음",
	WarningKnightDown	= "무자비한 죽음의 기사 죽음",
	WarningPhase2		= "2 페이즈 시작"
})

L:SetMiscLocalization({
	yell			= "어리석은 것들, 스스로 죽음을 자초하다니!",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s 그리고 %d %s",
	WarningWave3	= "%d %s, %d %s 그리고 %d %s",
	Trainee			= "|4수련생:수련생;",
	Knight			= "|4죽음의 기사:죽음의 기사;",
	Rider			= "|4죽음의 기병:죽음의 기병;",
})

--------------------
--  4인의 기사단  --
--------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "4인의 기사단"
})

L:SetOptionLocalization({
	TimerMark					= "징표 타이머 보기",
	WarningMarkSoon				= "징표 사전 경고 보기",
	WarningMarkNow				= "징표 경고 보기",
	SpecialWarningMarkOnPlayer	= "자신의 징표가 4개가 됐을 때의 경고 보기"
})

L:SetTimerLocalization({
	TimerMark = "징표 %d"
})

L:SetWarningLocalization({
	WarningMarkSoon				= "3초 후 징표 %d",
	WarningMarkNow				= "징표 %d!",
	SpecialWarningMarkOnPlayer	= "%s: %s",
})

L:SetMiscLocalization({
	Korthazz	= "영주 코스아즈",
	Rivendare	= "남작 리븐데어",
	Blaumeux	= "여군주 블라미우스",
	Zeliek		= "젤리에크 경",
})

-------------------
-- 서리고룡 둥지 --
-------------------
--------------
--  사피론  --
--------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "사피론"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon		= "비행 페이즈 사전 경고 보기",
	WarningAirPhaseNow		= "비행 페이즈 경고 보기",
	WarningLanded			= "지상 페이즈 경고 보기",
	TimerAir				= "비행 페이즈 타이머 보기",
	TimerLanding			= "착지 타이머 보기",
	TimerIceBlast			= "냉기 숨결 타이머 보기",
	WarningDeepBreath		= "냉기 숨결 특수 경고 보기",
	WarningIceblock			= "얼음 방패가 됐을 경우 외치기"
})

L:SetMiscLocalization({
--	EmoteBreath				= "%s이 숨을 깊게 들이마십니다.",
	EmoteBreath				= "숨을 깊게 들이마십니다.",
	WarningYellIceblock		= "저 얼음 방패! 제 뒤에 숨으세요!!"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon		= "비행 페이즈 10초 전",
	WarningAirPhaseNow		= "비행 페이즈",
	WarningLanded			= "사피론 착지",
	WarningDeepBreath		= "냉기의 숨결!!",
})

L:SetTimerLocalization({
	TimerAir				= "비행 페이즈",
	TimerLanding			= "착지",
	TimerIceBlast			= "냉기 숨결"	
})

------------------
--  켈투자드  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "켈투자드"
})

L:SetOptionLocalization({
	TimerPhase2			= "2 페이즈 타이머 보기",
	specwarnP2Soon		= "2 페이즈 시작하기 전 특수 경고 보기",
	warnAddsSoon		= "얼음왕관의 수호자 등장 사전 경고 보기",
	BlastAlarm			= "냉기 작렬를 시전할 경우 경고 소리 재생",
	ShowRange			= "2 페이즈가 시작되면 거리 프레임 보기"
})

L:SetMiscLocalization({
	Yell 				= "어둠의 문지기와 하수인, 그리고 병사들이여! 나 켈투자드가 부르니 명을 받들라!"
})

L:SetWarningLocalization({
	specwarnP2Soon		= "10초 후 2 페이즈",
	warnAddsSoon		= "곧 얼음왕관의 수호자 등장"
})

L:SetTimerLocalization({
	TimerPhase2			= "2 페이즈"
})