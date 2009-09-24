if GetLocale() ~= "zhTW" then return end

local L

--------------
--  Onyxia  --
--------------
L = DBM:GetModLocalization("Onyxia")

L:SetGeneralLocalization{
	name = "奧妮克希亞"
}

L:SetWarningLocalization{
	SpecWarnBreath		= "深呼吸",
	WarnWhelpsSoon		= "幼龍即將出現",
}

L:SetTimerLocalization{
	TimerBreath		= "深呼吸",
	TimerWhelps 		= "幼龍出現"
}

L:SetOptionLocalization{
	SpecWarnBreath		= "為深呼吸顯示特別警告",
	TimerBreath		= "為深呼吸顯示計時器",
	TimerWhelps		= "為幼龍顯示計時器",
	WarnWhelpsSoon		= "為幼龍出現顯示預先警告",
	SoundBreath		= "深呼吸時播放音效",
	SoundWTF		= "為經典傳奇式奧妮克希亞副本播放一些有趣的音效"
}

L:SetMiscLocalization{ -- these yells are copy and pasted from our old onyxia mod...I don't know if they still work ;)
	Breath 			= "%s深深地吸了一口氣...",
	YellP2 			= "這毫無意義的行動讓我很厭煩。我會從上空把你們都燒成灰!",
	YellP3 			= "看起來需要再給你一次教訓，凡人!"
}
