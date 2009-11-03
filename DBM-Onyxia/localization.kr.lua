if GetLocale() ~= "koKR" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "오닉시아"
}

L:SetWarningLocalization{
	SpecWarnBreath		= "깊은 숨",
	SpecWarnBlastNova	= "파멸의 회오리!! 피하세요!!!",--http://www.wowhead.com/?npc=36561
	WarnWhelpsSoon		= "곧 새끼용 등장",
	WarnPhase3Soon		= "곧 3 페이즈"	
}

L:SetTimerLocalization{
	TimerBreath			= "깊은 숨",
	TimerWhelps 		= "새끼용"
}

L:SetOptionLocalization{
	SpecWarnBreath			= "깊은 숨의 특수 경고 보기",
	SpecWarnBlastNova		= "파멸의 회오리 특수 경고 보기",	
	TimerBreath				= "깊은 숨의 타이머 보기",
	TimerWhelps				= "새끼용 등장 타이머 보기",
	WarnWhelpsSoon			= "새끼용 등장의 사전 경고 보기",
	SoundBreath				= "깊은 숨의 경고 소리 재생",
	PlaySoundOnBlastNova	= "파멸의 회오리 경고 소리 재생",	
	SoundWTF				= "독특한 레이드를 즐기기위한 웃긴 소리 재생.(가급적 안하시길 권장)",
	WarnPhase3Soon			= "3 페이즈 사전 경고 보기(41% 이하가 될 경우)"	
}

L:SetMiscLocalization{ 
	Breath 		= "%s 숨을 깊게 들이쉽니다.",
	YellP2 		= "쓸데없이 힘을 쓰는 것도 지루하군. 네 녀석들 머리 위에서 모조리 불살라 주마!",
	YellP3 		= "혼이 더 나야 정신을 차리겠구나!"
}
