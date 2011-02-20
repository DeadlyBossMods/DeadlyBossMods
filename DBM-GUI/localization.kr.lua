if GetLocale() ~= "koKR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "죽이는 보스 모드"

L.TranslationBy 		= "흑묘서희@에이그윈서버 호드진영/Twitter : @Nyx_Khang"

L.TabCategory_Options 	= "일반 옵션"
L.TabCategory_CATA	 	= "대격변"
L.TabCategory_WOTLK 	= "리치왕의 분노"
L.TabCategory_BC 		= "불타는 성전"
L.TabCategory_CLASSIC 	= "오리지널"
L.TabCategory_OTHER     = "기타 보스 모드"

L.BossModLoaded 		= "%s 공략 상황"
L.BossModLoad_now 		= [[현재 보스의 모드가 로드되지 않았습니다. 
애드온 불러오기 버튼을 클릭하여 강제적으로 보스 모드를 실행시킬 수 있습니다.
]]

L.PosX 					= '위치 X'
L.PosY 					= '위치 Y'

L.MoveMe 				= '위치 이동'
L.Button_OK 			= '확인'
L.Button_Cancel 		= '취소'
L.Button_LoadMod 		= '애드온 불러오기'
L.Mod_Enabled			= "보스 모드 허용"
L.Mod_EnableAnnounce	= "공격대 경보로 알리기 (공격대 혹은 파티장일 경우)"
L.Reset 				= "리셋"

L.Enable  				= "켜기"
L.Disable				= "끄기"

L.NoSound				= "사운드 끄기"

L.IconsInUse			= "현재 모드에 공격대 아이콘을 사용합니다."

-- Tab: Boss Statistics
L.BossStatistics		= "보스 공략 상황"
L.Statistic_Kills		= "킬수:"
L.Statistic_Wipes		= "전멸:"
L.Statistic_BestKill	= "최고 기록:"
L.Statistic_Heroic		= "영웅"
L.Statistic_10Man		= "10인 공격대"
L.Statistic_25Man		= "25인 공격대"

-- Tab: General Options
L.General 				= "일반 DBM 옵션"
L.EnableDBM 			= "DBM 사용"
L.EnableStatus 			= "귓속말 대상자에게 'status' 답변 보내기 사용"
L.AutoRespond 			= "자동 부활 사용 - 무덤 이동"
L.EnableMiniMapIcon		= "Minimap 버튼 사용"
L.FixCLEUOnCombatStart	= "전투 시작 할 때 전투 로그 수정"
L.SetCurrentMapOnPull	= "현재 맵과 지역에서 풀링 켜기(/range & /arrow의 정확성 보장)"
L.UseMasterVolume			= "기본 오디오 채널로 사운드 파일 실행(4.0.6+)"
L.SKT_Enabled			= "항상 빠르게 죽인 타이머 보기(각 보스에 포함된 특수 옵션 참고)"
L.Latency_Text			= "최대 지연시간 설정 : %d"

L.Button_RangeFrame		= "거리-프레임 켜기/끄기"
L.Button_TestBars		= "테스트 바 시작"

L.PizzaTimer_Headline 	= '"Pizza Timer" 만들기'
L.PizzaTimer_Title		= '이름 (예 : "Pizza!")'
L.PizzaTimer_Hours 		= "시"
L.PizzaTimer_Mins 		= "분"
L.PizzaTimer_Secs 		= "초"
L.PizzaTimer_ButtonStart 	= "타이머 시작"
L.PizzaTimer_BroadCast		= "공격대에 알리기"

-- Tab: Raidwarning
L.Tab_RaidWarning 		= "공격대 경보"
L.RaidWarning_Header	= "공격대 경고 설정"
L.RaidWarnColors 		= "공격대 경보 색상"
L.RaidWarnColor_1 		= "색상 1"
L.RaidWarnColor_2 		= "색상 2"
L.RaidWarnColor_3 		= "색상 3"
L.RaidWarnColor_4 		= "색상 4"
L.InfoRaidWarning		= [[레이드 경고 프레임의 위치와 컬러를 수정할 수 있습니다. 
이것은 메세지를 위한 색상 수정 프레임이며 "Y 가 X에게 주문을 걸었습니다." 같은 메세지를 뜻합니다.]]
L.ColorResetted 		= "현재 필드의 색상 셋팅을 초기화 합니다."
L.ShowWarningsInChat 	= "위험 알림을 채팅 창에 보여줍니다."
L.ShowFakedRaidWarnings = "위험 알림을 공격대 경보 메세지처럼 보여줍니다."
L.WarningIconLeft 		= "아이콘을 왼쪽에 보여주기"
L.WarningIconRight 		= "아이콘을 오른쪽에 보여주기"
L.RaidWarnMessage 		= "<Deadly Boss Mods>를 사용해 주셔셔 감사합니다."
L.BarWhileMove 			= "레이드 경보 위치 수정"
L.RaidWarnSound			= "레이드-경보 사운드"
L.SpecialWarnSound		= "특별한 경보 사운드"

-- Tab: Barsetup
L.BarSetup  				= "바 스타일"
L.BarTexture 				= "바 텍스쳐"
L.BarStartColor	 			= "시작 색상"
L.BarEndColor 				= "마지막 색상"
L.ExpandUpwards				= "바를 위로 쌓기"
L.Bar_Font					= "바에 사용할 폰트"
L.Bar_FontSize				= "폰트 크기"
L.Slider_BarOffSetX 		= "자세한 가로 위치: %d"
L.Slider_BarOffSetY 		= "자세한 세로 위치: %d"
L.Slider_BarWidth 			= "바 길이: %d"
L.Slider_BarScale 			= "바 스케일(크기): %0.2f"
L.AreaTitle_BarSetup 		= "일반 바 옵션"
L.AreaTitle_BarSetupSmall 	= "작은 바 옵션"
L.AreaTitle_BarSetupHuge 	= "커다란 바 옵션"
L.BarIconLeft 				= "왼쪽 아이콘"
L.BarIconRight 				= "오른쪽 아이콘"
L.EnableHugeBar 			= "커다란 바 사용(바 2)"
L.FillUpBars				= "바를 채워나가기"
L.ClickThrough				= "마우스 이벤트 사용 안함 (바를 클릭하는 행위 등)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "특수 경고"
L.Area_SpecWarn				= "특수 경고 설정"
L.SpecWarn_Enabled			= "각 보스별 특수 경고 보기"
L.SpecWarn_Font				= "특수 경고를 위한 폰트 사용"
L.SpecWarn_DemoButton		= "예제 보기"
L.SpecWarn_MoveMe			= "위치 설정"
L.SpecWarn_FontSize			= "폰트 크기"
L.SpecWarn_FontColor		= "폰트 색상"
L.SpecWarn_FontType			= "폰트 선택"
L.SpecWarn_ResetMe			= "초기화"

-- Tab: HealthFrame
L.Panel_HPFrame				= "보스 체력 프레임"
L.Area_HPFrame				= "체력 프레임 설정"
L.HP_Enabled				= "해당 모드에서 끈 상태라도 항상 체력 프레임 보기(강제)"
L.HP_GrowUpwards			= "보스 체력 프레임을 위로 쌓기"
L.HP_ShowDemo				= "체력 프레임 보기"
L.BarWidth					= "바 길이: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "스팸 필터"
L.Area_SpamFilter				= "일반 스팸 필터 옵션"
L.HideBossEmoteFrame			= "레이드 보스가 사용하는 감정표현 숨기기"
L.SpamBlockRaidWarning			= "다른 보스 모드가 알리는 경보 감추기" 
L.SpamBlockBossWhispers			= "전투 중 사용되는 <DBM> 경보 귓속말 감추기"
L.BlockVersionUpdatePopup		= "업데이트 알림 창 끄기"
L.ShowBigBrotherOnCombatStart	= "전투가 시작되면 BigBrother 버프 체크 켜기"
L.BigBrotherAnnounceToRaid		= "Big Brother 결과를 공격대에 알리기"

L.Area_SpamFilter_Outgoing		= "공통 필터 옵션"
L.SpamBlockNoShowAnnounce		= "알림 또는 경고 소리 실행하지 않기"
L.SpamBlockNoSendAnnounce		= "공격대 채팅 알림을 보내지 않기"
L.SpamBlockNoSendWhisper		= "다른 플레이어에게 귓속말을 보내지 않기"
L.SpamBlockNoSetIcon			= "대상 공격대 아이콘 설정하지 않기"
