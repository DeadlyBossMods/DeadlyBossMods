if GetLocale() ~= "koKR" then return end
local L
-------------------
--  거미 지구    --
-------------------
-------------------
--  아눕레칸  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "아눕레칸"
})

L:SetWarningLocalization({
	SpecialLocust		= "메뚜기 때 시작!!",
	WarningLocustSoon	= "메뚜기 때 15초 전",
	WarningLocustNow	= "메뚜기 때!!",
	WarningLocustFaded	= "메뚜기 때가 사라졌습니다!!"
})

L:SetTimerLocalization({
	TimerLocustIn	= "메뚜기 때", 
	TimerLocustFade = "메뚜기 때 시작"
})

L:SetOptionLocalization({
	SpecialLocust		= "메뚜기 때 특수 경보 보기",
	WarningLocustSoon	= "메뚜기 때 시전 경고 보기",
	WarningLocustNow	= "메쭈기 때 경보 보기",
	WarningLocustFaded	= "메뚜기 때 사라짐 경보 보기",
	TimerLocustIn		= "메뚜기 때 타이머 보기", 
	TimerLocustFade 	= "메뚜기 때 사라짐 타이머 보기"
})


----------------------------
--  귀부인 펠리나  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "귀부인 펠리나"
})

L:SetWarningLocalization({
	WarningEmbraceActive	= "귀부인의 은총 시작",
	WarningEmbraceExpire	= "귀부인의 은총 종료 5초 전",
	WarningEmbraceExpired	= "귀부인의 은총 사라짐",
	WarningEnrageSoon		= "격노 5 초전",
	WarningEnrageNow		= "격노!"
})

L:SetTimerLocalization({
	TimerEmbrace	= "귀부인의 은총(침묵)",
	TimerEnrage		= "격노",
})

L:SetOptionLocalization({
	TimerEmbrace			= "귀부인의 은총(침묵) 타이머 보기",	
	WarningEmbraceActive	= "귀부인의 은총 경고 보기",
	WarningEmbraceExpire	= "귀부인의 은총 종료 경보 보기",
	WarningEmbraceExpired	= "귀부인의 은총 사라짐 경보 보기",
	WarningEnrageSoon		= "격노 5초전 경고 알리기",
	WarningEnrageNow		= "격노 경고 알리기",
	TimerEnrage				= "격노 타이머 보기",	
})


---------------
--  맥스나  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "맥스나"
})

L:SetWarningLocalization({
	WarningWebWrap		= "거미줄 감싸기 : >%s<",
	WarningWebSpraySoon	= "5 초 후 거미줄 뿌리기",
	WarningWebSprayNow	= "거미줄 뿌리기!",
	WarningSpidersSoon	= "5 초 후 거미 소환",
	WarningSpidersNow	= "거미 소환!!"
})

L:SetTimerLocalization({
	TimerWebSpray	= "거미줄 뿌리기",
	TimerSpider		= "거미"
})

L:SetOptionLocalization({
	WarningWebWrap		= "거미줄 감싸기 타겟 알리기",
	WarningWebSpraySoon	= "거미줄 뿌리기 사전 경고 보기",
	WarningWebSprayNow	= "거미줄 뿌리기 경고 보기",
	WarningSpidersSoon	= "거미 사전 경고 보기",
	WarningSpidersNow	= "거미 경고 보기",
	TimerWebSpray		= "거미줄 뿌리기 타이머 보기",
	TimerSpider			= "거미 타이머 보기"
})

L:SetMiscLocalization({
	YellWebWrap			= "저 거미줄에 걸렸어요!! 살려주세요!!"
})

---------------
-- 역병 지구 --
---------------
------------------------------
--  역병술사 노스  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "역병술사 노스"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "순간이동!!",
	WarningTeleportSoon	= "20초 후 순간이동",
	WarningCurse		= "저주!"
})

L:SetTimerLocalization({
	TimerTeleport		= "순간이동",
	TimerTeleportBack	= "방으로 순간이동"
})

L:SetOptionLocalization({
	WarningTeleportNow		= "순간이동 경고 보기",
	WarningTeleportSoon		= "순간이동 사전 경고 보기",
	WarningCurse			= "저주 경고 보기",
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
	WarningCurse			= "저주 경고 보기",
	TimerTeleport			= "순간이동 타이머 보기",
	TimerTeleportBack		= "단상 이동 타이머 보기"
})


----------------
--  로데브  --
----------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "로데브"
})

L:SetWarningLocalization({
	WarningSporeNow		= "포자 생성!!",
	WarningSporeSoon	= "5초후 포자",
	WarningDoomNow		= "파멸 #%d",
	WarningHealSoon		= "3초 후 힐 가능!!",
	WarningHealNow		= "지금 힐!!!!!"
})

L:SetTimerLocalization({
	TimerDoom			= "파멸 #%d",
	TimerSpore			= "다음 포자",
	TimerAura			= "강령술의 오라"
})

L:SetOptionLocalization({
	WarningSporeNow		= "포자 경고 보기",
	WarningSporeSoon	= "포자 사전 경고 보기",
	WarningDoomNow		= "파멸 경고 보기",
	WarningHealSoon		= "\"힐 가능 3초 전\" 사전 경고 보기",
	WarningHealNow		= "\"지금 바로 힐\" 경보 보기",
	TimerDoom			= "파멸 타이머 보기",
	TimerSpore			= "포자 타이머 보기",
	TimerAura			= "강령술의 오라 타이머 보기"
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
	WarningHateful = "증오의 일격을 공대 채팅창에 알리기\n(만약 당신이 공대장의 권한이 있거나, 승급을 받은 유저라면 이 기능을 사용할 수 있습니다.)"
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
	WarningInjection		= "돌연변이 유발 경고 보기",
	SpecialWarningInjection	= "돌연변이 유발 대상자 경고 보기"
})

L:SetWarningLocalization({
	WarningInjection		= "돌연변이 유발: >%s<",
	SpecialWarningInjection	= "당신에게 돌연변이 유발이 걸렸습니다!"
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

L:SetOptionLocalization({
	WarningDecimateNow	= "척살 경고 보기",
	WarningDecimateSoon	= "척살 사전 경고 보기",
	TimerDecimate		= "척살 타이머 보기"
})

L:SetWarningLocalization({
	WarningDecimateNow	= "척살!",
	WarningDecimateSoon	= "척살 10초 전!!"
})

L:SetTimerLocalization({
	TimerDecimate		= "다음 척살"
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
	Emote	= "%s 광폭화!", -- ?
	Emote2	= "테슬라 코일!!", -- ?
	Boss1 = "퓨진",
	Boss2 = "스탈라그",
	Charge1 = "마이너스 전하",
	Charge2 = "플러스 전하",
})

L:SetOptionLocalization({
	WarningShiftCasting		= "극성 변환 경고 보기",
	WarningChargeChanged	= "현재 전하가 바뀌었는지 경고 보기",
	WarningChargeNotChanged	= "현재 전하가 바뀌지 않았는지 경고 보기",
	TimerShiftCast			= "극성 변환 타이머 보기",
	TimerNextShift			= "극성 변환 쿨다운 타이머 보기",
	ArrowsEnabled			= "화살표 보기 (일반 \"2 지역\" 공략)",
	ArrowsRightLeft			= "\"4 지역\" 공략을 위한 오른쪽/왼쪽 화살표 보기 (만약 극성 변환시엔 왼쪽 화살표를 보여주며, 극성이 변환되지 않았다면 보여주지 않는다.)",
	ArrowsInverse			= "\"4 지역\" 공략을 위한 오른쪽/왼쪽 화살표를 거꾸로 보기 (만약 극성 변환시엔 오른쪽 화살표를 보여주며, 극성이 변환되지 않았다면 보여주지 않는다.",
	WarningThrow			= "탱커 던지기 경고 보기",
	WarningThrowSoon		= "탱커 던지기 사전 경고 보기",
	TimerThrow				= "탱커 던지기 타이머 보기"
})

L:SetWarningLocalization({
	WarningShiftCasting		= "극성 변환 3초 전!!",
	WarningChargeChanged	= "%s로 전하가 바뀌었습니다.",
	WarningChargeNotChanged	= "전하가 바뀌지 않았습니다.",
	WarningThrow			= "탱커 던지기!",
	WarningThrowSoon		= "탱커 던지기 3 초 전!!"
})

L:SetTimerLocalization({
	TimerShiftCast			= "극성 변환",
	TimerNextShift			= "다음 극성 변환",
	TimerThrow				= "탱커 던지기"
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
	WarningShoutNow		= "분열의 외침 경고 보기",
	WarningShoutSoon	= "분열의 외침 사전 경고 보기",
	TimerShout			= "분열의 외침 타이머 타이머 보기",
	WarningShieldWallSoon	= "뼈 보호막 종료 경고 보기",
	TimerShieldWall			= "뼈 보호막 타이머 보기",
	TimerTaunt				= "도발 타이머 보기"	
})

L:SetWarningLocalization({
	WarningShoutNow		= "분열의 외침!",
	WarningShoutSoon	= "분열의 외침 5초 전!",
	WarningShieldWallSoon	= "뼈 보호막 종료 5초 전"	
})

L:SetTimerLocalization({
	TimerShout			= "분열의 외침",
	TimerTaunt			= "도발",
	TimerShieldWall		= "뼈 보호막"	
})

------------------------
--  영혼 착취자 고딕  --
-------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "영혼 착취자 고딕"
})

L:SetOptionLocalization({
	TimerWave			= "웨이브 타이머 보기",
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
	WarningRiderDown	= "무자비한 죽음의 기병 등장",
	WarningKnightDown	= "무자비한 죽음의 기사 등장",
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


----------------
--  4인의 기사단  --
----------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "4인의 기사단"
})

L:SetOptionLocalization({
	TimerMark					= "징표 타이머 보기",
	WarningMarkSoon				= "징ㅍ 사전 경고 보기",
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
-------------------
--  사피론  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "사피론"
})

L:SetOptionLocalization({
	WarningDrainLifeNow		= "생명력 흡수 경고 보기",
	WarningDrainLifeSoon	= "생명력 흡수 사전 경고 보기",
	WarningAirPhaseSoon		= "비행 페이즈 사전 경고 보기",
	WarningAirPhaseNow		= "비행 페이즈 경고 보기",
	WarningLanded			= "지상 페이즈 경고 보기",
	TimerDrainLifeCD		= "생명력 흡수 타이머 보기",
	TimerAir				= "비행 페이즈 타이머 보기",
	TimerLanding			= "착지 타이머 보기",
	TimerIceBlast			= "냉기 숨결 타이머 보기",
	WarningDeepBreath		= "냉기 숨결 특수 경고 보기"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s 이 숨을 깊게 들이쉽니다.",
	WarningYellIceblock	= "저 얼음 방패! 제 뒤에 숨으세요!!"
})

L:SetWarningLocalization({
	WarningDrainLifeNow		= "생명력 흡수!",
	WarningDrainLifeSoon	= "곧 생명력 흡수",
	WarningAirPhaseSoon		= "비행 페이즈 10초 전",
	WarningAirPhaseNow		= "비행 페이즈",
	WarningLanded			= "사피론 착지",
	WarningDeepBreath		= "냉기의 숨결!!",
})

L:SetTimerLocalization({
	TimerDrainLifeCD		= "생명력 흡수 쿨다운",
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
	WarningBlastTargets	= "냉기 작렬 경고 보기",
	WarningPhase2		= "2 페이즈 경고 보기",
	WarningFissure		= "어둠의 균열 경고 보기",
	WarningMana			= "마나 폭발 경고 보기",
	WarningChainsTargets= "켈투자드 정신 지배 경고 보기"
})

L:SetMiscLocalization({
	Yell = "어둠의 문지기와 하수인, 그리고 병사들이여, 나 켈투자드가 부르니 명을 받들라!"
})

L:SetWarningLocalization({
	WarningBlastTargets	= "냉기 작렬: >%s<",
	WarningPhase2		= "2 페이즈",
	WarningFissure		= "어둠의 균열 생성",
	WarningMana			= "마나 폭발 : >%s<",
	WarningChainsTargets= "정신 지배 : >%s<"
})

L:SetTimerLocalization({
	TimerPhase2			= "2 페이즈"
})



