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
	SpecWarnBlastNova	= "施放衝擊新星 - 快跑開",
	WarnWhelpsSoon		= "奧妮克希亞幼龍 即將出現",
	WarnPhase3Soon		= "第3階段 即將到來"
}

L:SetTimerLocalization{
	TimerWhelps = "奧妮克希亞幼龍"
}

L:SetOptionLocalization{
	SpecWarnBreath			= "為深呼吸顯示特別警告",
	SpecWarnBlastNova		= "為衝擊新星顯示特別警告",
	TimerWhelps				= "為奧妮克希亞幼龍顯示計時器",
	WarnWhelpsSoon			= "為奧妮克希亞幼龍顯示預先警告",
	SoundBreath				= "為深呼吸播放音效",
	PlaySoundOnBlastNova	= "為衝擊新星播放音效",
	SoundWTF				= "為經典傳奇式奧妮克希亞副本播放一些有趣的音效",
	WarnPhase3Soon			= "為第3階段顯示預先警告 (大約在41%)"
}

L:SetMiscLocalization{
	YellP2 = "這毫無意義的行動讓我很厭煩。我會從上空把你們都燒成灰!",
	YellP3 = "看起來需要再給你一次教訓，凡人!"
}