local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "오닉시아"
}

L:SetWarningLocalization{
	SpecWarnBreath	= "깊은 숨",
	WarnWhelpsSoon	= "곧 새끼용(파수병) 등장",
}

L:SetTimerLocalization{
	TimerBreath		= "깊은 숨",
	TimerWhelps 	= "새끼용(파수병)"
}

L:SetOptionLocalization{
	SpecWarnBreath	= "깊은 숨의 특수 경고 보기",
	TimerBreath		= "깊은 숨의 타이머 보기",
	TimerWhelps		= "새끼용 등장 타이머 보기",
	WarnWhelpsSoon	= "새끼용 등장의 사전 경고 보기",
	SoundBreath		= "깊은 숨의 경고 소리 재생"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	Breath = "%s 숨을 깊게 들이쉽니다...",
	YellP2 = "This meaningless exertion bores me. I'll incinerate you all from above!",
	YellP3 = "It seems you'll need another lesson, mortals!"
}
