if GetLocale() ~= "koKR" then return end
local L

------------------------
--  Northrend Beasts  --
------------------------
L = DBM:GetModLocalization("NorthrendBeasts")

L:SetGeneralLocalization{
	name = "노스랜드의 야수"
}

L:SetMiscLocalization{
	--Charge		= "^%%s (%S+)|1을;를; 노려보며 큰 소리로 울부짖습니다.",
	Charge			= "^%%s (%S+) 노려보며 큰 소리로 울부짖습니다.",
	CombatStart		= "폭풍우 봉우리의 가장 깊고 어두운 동굴에서 온, 꿰뚫는 자 고르목일세! 영웅들이여, 전투에 임하게!",
	Phase3			= "다음은, 소개하는 순간 공기마저 얼어붙게 하는 얼음울음일세! 죽이지 않으면 죽을 걸세, 용사들이여!",
	Gormok			= "꿰뚫는 자 고르목",
	Acidmaw			= "산성아귀",
	Dreadscale		= "공포비늘",
	Icehowl			= "얼음울음"	
}

L:SetOptionLocalization{
	WarningSnobold				= "스노볼트 부하 생성 경고 보기",
	SpecialWarningImpale3		= "꿰뚫기 특수 경보 보기(3 중첩이거나 그 이상일 경우)",
	SpecialWarningAnger3		= "솟구치는 분노 특수 경고 보기(3 중첩이거나 그 이상일 경우)",	
	SpecialWarningFireBomb		= "자신의 화염 폭탄 특수 경보 보기",
	SpecialWarningSlimePool		= "독 구름 특수 경보 보기",
	SpecialWarningSilence		= "진동의 발구르기 특수 경보 보기",
	SpecialWarningToxin			= "당신이 마비독에 걸릴 경우 특수 경보 보기",
	SpecialWarningBile			= "당신이 타오르는 담즙에 걸릴 경우 특수 경보 보기",
	SpecialWarningCharge		= "얼음울음이 당신에게 사나운 돌진을 할 경우 특수 경보 보기",
	SpecialWarningChargeNear	= "얼음울음이 당신 주변에 사나운 돌진을 할 경우 특수 경보 보기",
	SpecialWarningTranq			= "얼음울음이 거품 이는 분노를 얻었을 경우 특수 경고 보기(평정 사용 클래스)",	
	SetIconOnChargeTarget		= "사나운 돌진 대상 아이콘 설정 (해골)",
	SetIconOnBileTarget			= "타오르는 담즙 대상 아이콘 설정",
	ClearIconsOnIceHowl			= "얼음울음의 사나운 돌진 이후 모든 공격대 아이콘 없앰",
	PingCharge					= "얼음울음에게 사나운 돌진의 대상이 될 경우 미니맵에 핑 표시하기",		
	TimerNextBoss				= "다음 보스 등장 타이머 보기",		
	TimerCombatStart			= "전투 시작 타이머 보기"
}

L:SetTimerLocalization{
	TimerNextBoss				= "곧 다음 보스",
	TimerCombatStart			= "곧 전투 시작",
}

L:SetWarningLocalization{
	WarningSnobold				= "스노볼트 부하 생성",
	SpecialWarningImpale3		= "꿰뚫기 >%d<!",
	SpecialWarningAnger3		= "솟구치는 분노 >%d<",	
	SpecialWarningFireBomb		= "당신에게 화염 폭탄!",
	SpecialWarningSlimePool		= "독 구름, 벗어나세요!",
	SpecialWarningBile			= "당신에게 타오르는 담즙!",
	SpecialWarningSilence		= "1.5 초이내 진동의 발구르기!!!",
	SpecialWarningToxin			= "당신에게 마비독! 이동하세요!",
	SpecialWarningCharge		= "당신에게 사나운 돌진! 뛰세요!",
	SpecialWarningChargeNear	= "당신 주변에 사나운 돌진! 뛰세요!",
	SpecialWarningTranq			= "거품 이는 분노! - 지금 평정!"
}


-------------------
-- Lord Jaraxxus --
-------------------
L = DBM:GetModLocalization("Jaraxxus")

L:SetGeneralLocalization{
	name = "군주 자락서스"
}

L:SetWarningLocalization{
	WarnNetherPower				= "자락서스가 황천의 힘을 얻었습니다! 해제하세요!",
	SpecWarnFlesh				= "당신에게 살점 소각!",
	SpecWarnTouch				= "당신에게 자락서스의 손길!",
	SpecWarnKiss				= "당신에게 여군주의 키스",
	SpecWarnTouchNear			= "당신 주변에 자락서스의 손길 : >%s<",
	SpecWarnFlame				= "당신에게 군단 불꽃! 뛰세요!",
	SpecWarnNetherPower			= "지금 해제!",
	SpecWarnFelInferno			= "군단 불꽃! 움직이세요!",
	SpecWarnFelFireball			= "지옥 화염구 - 차단!",
	SpecWarnFelFireballDispel	= "지옥 화염구 해제 : %s"	
}

L:SetMiscLocalization{
	WhisperFlame			= "당신에게 군단의 불꽃!",
	IncinerateTarget		= "살점 소각: %s"
}

L:SetOptionLocalization{
	WarnNetherPower				= "자락서스가 황천의 힘을 얻었을 경우 경고 하기 (해제를 위한 경고)",
	SpecWarnFlame				= "군단 불꽃에 걸렸을 경우 특수 경보 알리기",
	SpecWarnFlesh				= "살점 소각에 걸렸을 경우 특수 경보 알리기",
	SpecWarnTouch				= "당신이 자락서스의 손길에 걸렸을 경우 특수 경고 알리기",
	SpecWarnTouchNear			= "당신 주변의 플레이어가 자락서스의 손길에 걸렸을 경우 특수 경고 알리기",
	SpecWarnKiss				= "당신이 여군주의 키스에 걸렸을 경우 특수 경고 알리기",
	SpecWarnNetherPower			= "황천의 힘 특수 경고 알리기 (자락서스 해제클래스-법사/사제/주술사)",
	SpecWarnFelInferno			= "당신 주변에 군단 불꽃이 있을 경우 특수 경고 알리기(바닥)",
	SpecWarnFelFireball			= "지옥 화염구의 특수 경고 보기(차단 관련)",
	SpecWarnFelFireballDispel	= "지옥 화염구의 특수 경고 보기(해제 관련)",	
	TouchJaraxxusIcon			= "자락서스의 손길 대상 공격대 아이콘 설정 (엑스)",
	IncinerateFleshIcon			= "살점 소각의 공격대 대상 아이콘 설정 (해골)",
	LegionFlameIcon				= "군단의 불꽃의 공격대 대상 아이콘 설정 (네모)",
	LegionFlameWhisper			= "군단의 불꽃 대상에게 귓속말 보내기",
	IncinerateShieldFrame		= "보스 체력 프레임과 함께 살점 소각 대상자 체력바 보기"
}


-----------------------
-- Faction Champions --
-----------------------
L = DBM:GetModLocalization("Champions")

L:SetGeneralLocalization{
	name = "진영 대표 용사"
}

L:SetTimerLocalization{
}

L:SetWarningLocalization{
	SpecWarnHellfire		= "지옥의 불길! 이동 하세요!",
	SpecWarnHandofProt		= "보호의 손길 : >%s<",
	SpecWarnDivineShield	= "천상의 보호막 :  >%s<",
	specWarnIceBlock       	= "얼음 방어막 : %s"
}

L:SetMiscLocalization{
	Gorgrim		= "죽기 - 고르그림 섀도클리브",			-- 34458, Horde
	Tyrius		= "죽기 - 티리우스 더스크블레이드",		-- 34461, Allience
	Birana 		= "조드 - 비라나 스톰후프",				-- 34451, Horde
	Erin		= "회드 - 에린 미스트후프",				-- 34459, Horde
	Kavina		= "조드 - 카비나 그로브송",				-- 34460, Allience
	Melador		= "회드 - 멜라도르 베일스트라이더",		-- 34469, Allience
	Rujkah		= "사냥꾼 - 루즈카",					-- 34448, Horde
	Alyssia 	= "사냥꾼 - 알리시아 문스토커",			-- 34467, Allience
	Ginselle	= "마법사 - 진셀 블라이트슬링어",		-- 34449, Horde
	Noozle		= "마법사 - 누즐 위즐스틱",				-- 34468, Allience
	Liandra		= "신성 - 리안드라 선콜러",				-- 34445, Horde
	Malithas	= "징벌 - 말리타스 브라이트블레이드",	-- 34456, Horde
	Baelnor 	= "징벌 - 벨노르 라이트베이러",			-- 34471, Allience
	Velanaa		= "신성 - 벨라나", 						-- 34465, Allience
	Caiphus		= "수양 - 준엄한 카이푸스",				-- 34447, Horde
	Vivienne	= "암흑 - 비비안 블랙위스퍼",			-- 34441, Horde
	Anthar		= "수양 - 안타르 포지멘더",				-- 34466, Allience
	Brienna		= "암흑 - 브리에나 나이트펠",			-- 34473, Allience
	Mazdinah	= "도적 - 마즈디나",					-- 34454, Horde
	Irieth		= "도적 - 이리에스 섀도스텝",			-- 34472, Allience
	Thrakgar	= "정기 - 스락가르",					-- 34444, Horde
	Broln		= "고양 - 브롤른 스타우트혼",			-- 34455, Horde
	Saamul		= "정기 - 사아물", 						-- 34470, Allience
	Shaabad		= "고양 - 샤베드", 						-- 34463, Allience
	Harkzog		= "흑마법사 - 하크조그",				-- 34450, Horde
	Serissa		= "흑마법사 - 세리사 그림대블러",		-- 34474, Allience
	Narrhok		= "전사 - 나르호크 스틸브레이커",		-- 34453, Horde
	Shocuul		= "전사 - 쇼쿨",						-- 34475, Allience
	YellKill	= "상처뿐인 승리로군. 오늘 받은 손해로 우리 전력은 약해졌네. 이런 어리석은 짓으로 리치 왕 말고 또 누가 이득을 보겠나? 위대한 용사들이 목숨을 잃었네. 무엇을 위해서였나? 진짜 위협은 저 앞에 있네. 리치 왕이 우리 모두를 죽음 안에서 기다린다네.",
}

L:SetOptionLocalization{
	SpecWarnHellfire		= "지옥의 불길로 인해 피해를 입을 경우 특수 경고 보기",
	SpecWarnHandofProt		= "성기사가 보호의 손길을 시전 했을 경우 특수 경고 보기(해제)",
	SpecWarnDivineShield	= "성기사가 천상의 보호막을 시전 했을 경우 특수 경고 보기(해제)",
	specWarnIceBlock       	= "마법사가 얼음 방어막을 시전 했을 경우 특수 경고 보기(해제)"	
}


------------------
-- Valkyr Twins --
------------------
L = DBM:GetModLocalization("Twins")

L:SetGeneralLocalization{
	name = "발키르 쌍둥이"
}

L:SetTimerLocalization{
	TimerSpecialSpell	= "다음 속성의 소용돌이"	
}

L:SetWarningLocalization{
	WarnSpecialSpellSoon		= "곧 속성의 소용돌이!",
	SpecWarnSpecial				= "속성(빛/어둠) 변경!",
	SpecWarnEmpoweredDarkness	= "당신에게 강화된 어둠",
	SpecWarnEmpoweredLight		= "당신에게 강화된 빛",
	SpecWarnSwitchTarget		= "대상 전환!",
	SpecWarnKickNow				= "지금 차단!",
	WarningTouchDebuff			= "디버프 : >%s<",
	WarningPoweroftheTwins		= "쌍둥이의 힘 - 오버힐!!  >%s<",
	SpecWarnPoweroftheTwins		= "쌍둥이의 힘!"
}

L:SetMiscLocalization{
	YellPull 	= "어둠의 주인님을 받들어. 리치 왕을 위하여. 너희에게. 죽음을. 안기리라.",
	Fjola 		= "피욜라 라이트베인",
	Eydis		= "아이디스 다크베인"
}

L:SetOptionLocalization{
	TimerSpecialSpell			= "다음 속성의 소용돌이의 타이머 보기",
	WarnSpecialSpellSoon		= "다음 속성의 소용돌이 사전 경고 보기",
	SpecWarnSpecial				= "속성(색) 변경을 해야할 때 특수 경고 보기",
	SpecWarnEmpoweredDarkness	= "강화된 어둠 특수 경고 보기",
	SpecWarnEmpoweredLight		= "강화된 빛 특수 경고 보기",
	SpecWarnSwitchTarget		= "다른 보스에게 시전해야 할 경우 특수 경고 보기",
	SpecWarnKickNow				= "당신이 차단을 해야할 경우 특수 경고 보기",
	SpecialWarnOnDebuff			= "디버프일 경우 특수 경고 보기 (디버프를 바꿀 경우)",
	SetIconOnDebuffTarget		= "손길 디버프 대상에게 공격대 아이콘 설정하기(영웅 모드)",
	WarningTouchDebuff			= "빛/어둠의 손길 디버프 대상 알리기",
	WarningPoweroftheTwins		= "쌍둥이의 힘의 현재 대상 알리기",
	SpecWarnPoweroftheTwins		= "쌍둥이의 힘의 특수 경고 보기(탱커일 경우)"
}


------------------
-- Anub'arak --
------------------
L = DBM:GetModLocalization("Anub'arak_Coliseum")

L:SetGeneralLocalization{
	name 				= "아눕아락"
}

L:SetTimerLocalization{
	TimerEmerge			= "출현",
	TimerSubmerge		= "숨기",
	timerAdds			= "다음 네루비안 땅무지"
}

L:SetWarningLocalization{
	WarnEmerge				= "아눕아락 출현!",
	WarnEmergeSoon			= "아눕아락 10초 이내 출현!",
	WarnSubmerge			= "아눕아락 잠수!",
	WarnSubmergeSoon		= "아눕아락 10초 이내 잠수!",
	SpecWarnPursue			= "당신을 추격 합니다!",
	warnAdds				= "네루비안 땅무지 추가!",	
	SpecWarnPCold	 		= "당신은 냉기 관통! 조심하세요!",
	SpecWarnShadowStrike	= "어둠의 일격! 지금 차단!"
}

L:SetMiscLocalization{
	YellPull				= "여기가 네 무덤이 되리라!",
--	Swarm					= "착취의 무리가 너희를 덮치리라!",
	Emerge					= "땅속에서 모습을 드러냅니다!",
	Burrow					= "땅속으로 숨어버립니다!",
	PcoldIconSet			= "냉기 관통 아이콘{rt%d} : %s",
	PcoldIconRemoved		= "냉기 관통 아이콘 제거 : %s"	
}

L:SetOptionLocalization{
	WarnEmerge				= "출현 경고 보기",
	WarnEmergeSoon			= "출현의 사전 경고 보기",
	WarnSubmerge			= "숨기 경고 보기",
	WarnSubmergeSoon		= "숨기의 사전 경고 보기",
	SpecWarnPursue			= "당신을 추격하기 시작할 때 특수 경고 알리기",
	warnAdds				= "새로운 네루비안 땅무지가 추가 될 때 경고 보기",
	timerAdds				= "새로운 네루비안 땅무지 추가 타이머 보기",	
	TimerEmerge				= "출현 타이머 보기",
	TimerSubmerge			= "숨기 타이머 보기",
	PlaySoundOnPursue		= "당신을 추격하기 시작할 때 특수 소리 재생",
	PursueIcon				= "추격 대상자 공격대 아이콘 설정하기",
	SpecWarnPCold			= "냉기 관통 특수 경고 보기",
	SetIconsOnPCold			= "냉기 관통 대상자 공격대 아이콘 설정하기",
	SpecWarnShadowStrike	= "어둠의 일격 특수 경고 보기(차단 관련)",
	RemoveHealthBuffsInP3	= "3 페이즈를 시작할 때 HP 버프 지우기",
	AnnouncePColdIcons		= "냉기 관통 대상자 및 공격대 아이콘 설정을 공격대 채팅창으로 알리기"	
}