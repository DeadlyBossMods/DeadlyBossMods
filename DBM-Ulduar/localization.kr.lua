if GetLocale() ~= "koKR" then return end

local L

----------------------
--  FlameLeviathan  --
----------------------
L = DBM:GetModLocalization("FlameLeviathan")

L:SetGeneralLocalization{
	name = "거대 화염 전차"
}

L:SetTimerLocalization{
	timerPursued		= "추적: %s",
	timerFlameVents		= "Flame Vents",
	timerSystemOverload	= "System Overloaded"
}
	
L:SetMiscLocalization{
	YellPull		= "Hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus 30 seconds to re-evaluation.",
	Emote			= "%%s pursues (%S+)%."
}

L:SetWarningLocalization{
	pursueTargetWarn	= "추적중! >%s<!",
	warnNextPursueSoon	= "추적 전환 5 초전"
}

L:SetOptionLocalization{
	timerSystemOverload	= "Show Timer for System Overload",
	timerFlameVents		= "Show Timer for Flame Vents",
	timerPursued		= "추적 타이머 보기",
	SystemOverload		= "Show Special Warning for System Overload",
	SpecialPursueWarnYou	= "추적자 특수 경보 보기",
	PursueWarn		= "추적 플레이어 레이드 경보로 보기",
	warnNextPursueSoon	= "다음 추적 경고"
}

-------------
--  Ignis  --
-------------
L = DBM:GetModLocalization("Ignis")

L:SetGeneralLocalization{
	name = "이그니스"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}

------------------
--  Razorscale  --
------------------
L = DBM:GetModLocalization("Razorscale")

L:SetGeneralLocalization{
	name = "Razorscale"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}

-------------
--  XT002  --
-------------
L = DBM:GetModLocalization("XT002")

L:SetGeneralLocalization{
	name = "XT002"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}


-------------------
--  철의 의회  --
-------------------
L = DBM:GetModLocalization("IronCouncil")

L:SetGeneralLocalization{
	name = "철의 의회"
}

L:SetWarningLocalization{
	WarningSupercharge	= "과충전 시전",
}

L:SetTimerLocalization{
	TimerSupercharge	= "과충전",  -- gives the other bosses more power
}

L:SetOptionLocalization{
	TimerSupercharge	= "과충전 타이머 보기",
	WarningSupercharge	= "과충전 시전 경보 보기",
}

L:SetMiscLocalization{
	Steelbreaker		= "강철분쇄자",
	RunemasterMolgeim 	= "룬마스터 몰게임",
	StormcallerBrundir 	= "폭풍을 부르는 브룬디르 브룬디르",
}

---------------
--  Algalon  --
---------------
L = DBM:GetModLocalization("Algalon")

L:SetGeneralLocalization{
	name = "알갤론"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}


----------------
--  Kologarn  --
----------------
L = DBM:GetModLocalization("Kologarn")

L:SetGeneralLocalization{
	name = "콜로간"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}

--------------
--  Auriya  --
--------------
L = DBM:GetModLocalization("Auriya")

L:SetGeneralLocalization{
	name = "오리아야"
}

L:SetMiscLocalization{
	Defender = "Feral Defender (%d)"
}

L:SetWarningLocalization{
	SpecWarnBlast = "Sentinel Blast - Interrupt!",
	WarnCatDied = "Feral Defender down (%d lifes remaining)",
	WarnFear = "Fear!",
	WarnFearSoon = "Next Fear soon"
}

L:SetOptionLocalization{
	SpecWarnBlast = "Show Special Warning on Sentinel Blast",
	WarnFear = "Show Fear Warning",
	WarnFearSoon = "Show Fear soon Warning",
	WarnCatDied = "Show Warning when the Feral Defender dies"
}

-------------
--  호디르  --
-------------
L = DBM:GetModLocalization("Hodir")

L:SetGeneralLocalization{
	name = "호디르"
}

L:SetWarningLocalization{
	WarningFlashFreeze	= "급속 결빙",
	WarningBitingCold	= "살을 애는 추위 - 움직이세요!"
}

L:SetTimerLocalization{
	TimerFlashFreeze	= "급속 결빙 시전",  -- all ppl have to move on the rock patches
}

L:SetOptionLocalization{
	TimerFlashFreeze	= "급속 결빙 시전 타이머 보기",
	WarningFlashFreeze	= "급속 결빙 경보 보기",
}

L:SetMiscLocalization{
	PlaySoundOnFlashFreeze	= "급속 결빙 시전 소리 듣기",
}


--------------
--  토림  --
--------------
L = DBM:GetModLocalization("Thorim")

L:SetGeneralLocalization{
	name = "토림"
}

L:SetWarningLocalization{
	WarningStormhammer	= "%s 에게 폭풍망치",
	UnbalancingStrike	= ">%s< 에게 넘어트리는 일격",
	WarningPhase2	= "2 페이즈",
	WarningBomb	= ">%s< 에게 룬 폭파",
	LightningOrb = "당신은 번개 충격 범위! 이동하세요!"
}

L:SetTimerLocalization{
	TimerStormhammer	= "폭풍망치 쿨다운",
	TimerUnbalancingStrike	= "넘어트리는 일격 쿨다운",
	TimerHardmode	= "하드 모드"
}

L:SetOptionLocalization{
	TimerStormhammer	= "폭풍망치 쿨다운 보기",
	TimerUnbalancingStrike	= "넘어트리는 일격 타이머 보기",
	TimerHardmode	= "하드 모드를 위한 타이머 보기",
	UnbalancingStrike	= "넘어트리는 일격 타겟 알리기",
	WarningStormhammer	= "폭풍망치 타겟 알리기",
	WarningPhase2	= "2 페이즈 알리기",
	RangeFrame	= "Show Range Frame"
}

L:SetMiscLocalization{
	YellPhase1		= "Interlopers! You mortals who dare to interfere with my sport will pay.... Wait--you...",
	YellPhase2		= "Impertinent whelps, you dare challenge me atop my pedestal? I will crush you myself!"
}

-------------
--  Freya  --
-------------
L = DBM:GetModLocalization("Freya")

L:SetGeneralLocalization{
	name = "프레이야"
}

L:SetMiscLocalization{
	SpawnYell = "Children, assist me!",
	WaterSpirit = "고대 물의 정령",
	Snaplasher = "철썩채찍",
	StormLasher = "폭풍 채찍",
	EmoteTree = "???" -- /chatlog failed
}

L:SetWarningLocalization{
	WarnPhase2 = "2 페이즈",
	WarnSimulKill = "First add down - Resurrection in 1 min",
	WarnFury = ">%s< 에게 자연의 분노",
	SpecWarnFury = "당신에게 자연의 분노!"
}

L:SetTimerLocalization{
	TimerUnstableSunBeam = "태양 광선: %s",
	TimerAlliesOfNature = "Allies of Nature CD",
	TimerSimulKill = "Resurrection",
	TimerFuryYou = "당신에게 자연의 분노"
}


-------------------
--  Mimiron  --
-------------------
L = DBM:GetModLocalization("Mimiron")

L:SetGeneralLocalization{
	name = "미미론"
}

L:SetWarningLocalization{
	WarningPlasmaBlast	= "%s 에게 플라즈마 폭발 - 폭힐! 폭힐!",
	Phase2Engaged		= "Phase 2 incoming - regroup now",
	Phase3Engaged		= "Phase 3 incoming - regroup now",	
}

L:SetTimerLocalization{
	ProximityMines		= "새로운 접근 지뢰",
}

L:SetOptionLocalization{
	WarningShockBlast	= "전기충격 폭발 경보 보기",
	WarningPlasmaBlast	= "플라즈마 폭발 경보 보기",
	ProximityMines		= "접근 지뢰 타이머 보기",
	PlaySoundOnShockBlast 	= "Play sound on Shock Blast cast",	
}

L:SetMiscLocalization{
	YellPull		= "We haven't much time, friends! You're going to help me test out my latest and greatest creation. Now, before you change your minds, remember that you kind of owe it to me after the mess you made with the XT-002.",
	YellPhase2		= "WONDERFUL! Positively marvelous results! Hull integrity at 98.9%! Barely a dent! Moving right along.",
	YellPhase3		= "Thank you, friends! Your efforts have yielded some fantastic data! Now, where did I put-- oh, there it is.",
}


--------------------
--  GeneralVezax  --
--------------------
L = DBM:GetModLocalization("GeneralVezax")

L:SetGeneralLocalization{
	name = "장군 베작스"
}

L:SetWarningLocalization{
	SpecialWarningShadowCrash	= "Shadow Crash on You",
	SpecialWarningSurgeDarkness	= "Surge of Darkness",
	WarningShadowCrash	= "당신에게 그림자 충돌!",
	specWarnLifeLeechYou		= "Life Leech on you!",
	specWarnLifeLeechNear		= "Life Leech on %s near you!"	
}

L:SetTimerLocalization{
	timerSearingFlamesCast	= "불사르는 화염",
	timerSurgeofDarkness	= "밀려오는 어둠",
	timerSaroniteVapors	= "Next Saronite Vapors"
}

L:SetOptionLocalization{
	WarningShadowCrash	= "그림자 충돌의 특수 경보 보기",
	timerSearingFlamesCast	= "불사르는 화염 시전 타이머 보기",
	timerSurgeofDarkness	= "밀려오는 어둠 타이머 보기",
	timerSaroniteVapors	= "Show Timer for Saronite Vapors",
	SetIconOnShadowCrash	= "그림자 충돌 대상 표시하기(해골)",
	SetIconOnLifeLeach	= "Set Icon on Life Leach target (cross)",
	SpecialWarningSurgeDarkness	= "Show Special Warning for Surge of Darkness",
	SpecialWarningShadowCrash	= "Show Special Warning for Shadow Crash",	
}

L:SetMiscLocalization{
	EmoteSaroniteVapors	= "A cloud of saronite vapors coalesces nearby!"
}


-----------------
--  YoggSaron  --
-----------------
L = DBM:GetModLocalization("YoggSaron")

L:SetGeneralLocalization{
	name = "요그사론"
}

L:SetMiscLocalization{
}

L:SetWarningLocalization{
}







