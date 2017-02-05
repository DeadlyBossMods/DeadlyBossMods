if GetLocale() ~= "koKR" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

--L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "번역: "
L.TranslationBy 			= "Elnarfim"
L.Website					= "|cFF73C2FBwww.deadlybossmods.com|r에서 토론장/사용자 지원 포럼을 방문해 보세요. 트위터 팔로우 @deadlybossmods 또는 @MysticalOS"
L.WebsiteButton				= "포럼"

L.OTabBosses	= "보스"
--L.OTabOptions	= GAMEOPTIONS_MENU

L.TabCategory_Options		= "일반 설정"
L.TabCategory_OTHER			= "기타 보스 모드"

L.BossModLoaded 			= "%s 통계"
L.BossModLoad_now 			= [[보스 모드가 로딩되지 않았습니다. 
해당 인스턴스에 진입하면 로딩됩니다.
아래 버튼을 클릭해서 모드를 직접 로딩할 수도 있습니다.]]

L.PosX						= '위치 X'
L.PosY						= '위치 Y'

L.MoveMe 					= '위치 이동'
L.Button_OK					= '확인'
L.Button_Cancel				= '취소'
L.Button_LoadMod			= '애드온 로드'
L.Mod_Enabled				= "보스 모드 활성화"
L.Mod_Reset					= "설정 기본값 로드"
L.Reset						= "초기화"

L.Enable					= "활성화"
L.Disable					= "비활성화"

L.NoSound					= "효과음 없음"

L.IconsInUse				= "사용되는 전술 목표 아이콘:"

-- Tab: Boss Statistics
L.BossStatistics			= "보스 통계"
L.Statistic_Kills			= "승리:"
L.Statistic_Wipes			= "전멸:"
L.Statistic_Incompletes		= "실패:"
L.Statistic_BestKill		= "최고 승리 기록:"
L.Statistic_BestRank		= "최고 등급:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Core Options
L.General 					= "DBM 기본 설정"
L.EnableMiniMapIcon			= "미니맵 버튼 표시"
L.UseSoundChannel			= "DBM 경보 효과음 재생 채널 선택"
L.UseMasterChannel			= "주 음량"
L.UseDialogChannel			= "대화"
L.UseSFXChannel				= "소리 (효과음)"
L.Latency_Text				= "동기화 신호를 보낼 최대 지연시간 설정: %d"

L.ModelOptions				= "3D 모델 뷰어 설정"
L.EnableModels				= "보스 설정에 3D 모델 사용"
L.ModelSoundOptions			= "모델 뷰어에서 사용할 효과음 설정"
L.ModelSoundShort			= "짧은 효과음"
L.ModelSoundLong			= "긴 효과음"

L.Button_RangeFrame			= "거리 창 표시/숨기기"
L.Button_InfoFrame			= "정보 창 표시/숨기기"
L.Button_TestBars			= "테스트 바 시작"
L.Button_ResetInfoRange		= "정보/거리 창 위치 초기화"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "공격대 경보"
L.RaidWarning_Header		= "공격대 경보 설정"
L.RaidWarnColors 			= "공격대 경보 색상"
L.RaidWarnColor_1 			= "색상 1"
L.RaidWarnColor_2 			= "색상 2"
L.RaidWarnColor_3 			= "색상 3"
L.RaidWarnColor_4 			= "색상 4"
L.InfoRaidWarning			= [[공격대 경보 프레임의 위치와 색상을 설정할 수 있습니다. 
본 프레임은 "플레이어 X가 Y에 걸렸습니다"와 같은 메시지를 표시하는데 사용됩니다.]]
L.ColorResetted 			= "이 영역의 색상 설정을 초기화 합니다."
L.ShowWarningsInChat 		= "대화창에서 경보 보기"
L.WarningIconLeft 			= "왼쪽에 아이콘 표시"
L.WarningIconRight 			= "오른쪽에 아이콘 표시"
L.WarningIconChat 			= "대화창에 아이콘 표시"
L.WarningAlphabetical		= "이름 순으로 정렬"
L.Warn_FontType				= "글꼴"
L.Warn_FontStyle			= "글꼴 속성"
L.Warn_FontShadow			= "그림자"
L.Warn_FontSize				= "글꼴 크기: %d"
L.Warn_Duration				= "경보 지속시간: %d초"
L.None						= "없음"
L.Outline					= "외곽선"
L.ThickOutline				= "두꺼운 외곽선"
L.MonochromeOutline			= "단색 외곽선"
L.MonochromeThickOutline	= "단색 두꺼운 외곽선"
L.RaidWarnSound				= "공격대 경보에 효과음 재생"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "일반 메시지"
L.CoreMessages				= "기본 메시지 설정"
L.ShowPizzaMessage 			= "대화창에 전송받은 타이머 표시"
L.ShowAllVersions	 		= "버전 검사시 대화창에 모든 파티/공격대원의 보스 모드 버전을 표시합니다. (설정을 꺼도 구버전/신버전으로 간략하게 표시됨)"
L.CombatMessages			= "전투 메시지 설정"
L.ShowEngageMessage 		= "대화창에 전투 시작 메시지 표시"
L.ShowDefeatMessage 		= "대화창에 처치/전멸 메시지 표시"
L.ShowGuildMessages 		= "대화창에 길드의 전투 시작/처치/전멸 메시지 표시"
L.WhisperMessages			= "귓속말 메시지 설정"
L.AutoRespond 				= "전투중 귓속말 자동 응답"
L.EnableStatus 				= "'status' 라는 귓속말을 받으면 자동 응답"
L.WhisperStats 				= "귓속말 응답에 처치/전멸 통계 포함"
L.DisableStatusWhisper 		= "전체 파티/공격대의 귓속말 응답을 끕니다. (파티/공대장 권한 필요) 일반/영웅/신화 공격대 및 도전/신화 5인 던전에만 적용됩니다."

-- Tab: Barsetup
L.BarSetup  				= "타이머 바 설정"
L.BarTexture 				= "바 텍스쳐"
L.BarStyle 					= "바 스타일"
L.BarDBM					= "DBM (애니메이션)"
L.BarSimple					= "Simple (애니메이션 없음)"
L.BarStartColor	 			= "시작 색상"
L.BarEndColor 				= "종료 색상"
L.Bar_Font					= "바 글꼴"
L.Bar_FontSize				= "글꼴 크기: %d"
L.Bar_Height				= "바 높이: %d"
L.Slider_BarOffSetX 		= "바 정렬: %d"
L.Slider_BarOffSetY 		= "바 간격: %d"
L.Slider_BarWidth 			= "바 너비: %d"
L.Slider_BarScale 			= "바 크기: %0.2f"
--Types
L.BarStartColorAdd			= "시작 색상 (쫄)"
L.BarEndColorAdd			= "종료 색상 (쫄)"
L.BarStartColorAOE			= "시작 색상 (광역 피해)"
L.BarEndColorAOE			= "종료 색상 (광역 피해)"
L.BarStartColorDebuff		= "시작 색상 (대상)"
L.BarEndColorDebuff			= "종료 색상 (대상)"
L.BarStartColorInterrupt	= "시작 색상 (차단)"
L.BarEndColorInterrupt		= "종료 색상 (차단)"
L.BarStartColorRole			= "시작 색상 (역할)"
L.BarEndColorRole			= "종료 색상 (역할)"
L.BarStartColorPhase		= "시작 색상 (단계)"
L.BarEndColorPhase			= "종료 색상 (단계)"
L.BarStartColorUI			= "시작 색상 (사용자)"
L.BarEndColorUI				= "종료 색상 (사용자)"
--Type 7 options
L.Bar7Header				= "사용자 바 설정"
L.Bar7ForceLarge			= "항상 커다란 바 사용"
L.Bar7CustomInline			= "바 안쪽에 사용자 지정 '!' 아이콘 사용"
L.Bar7Footer				= "(Dummy 바는 시간이 끝나면 사라집니다)"

-- Tab: Timers
L.AreaTitle_BarColors		= "타이머 종류별 바 색상"
L.AreaTitle_BarSetup 		= "일반 바 설정"
L.AreaTitle_BarSetupSmall 	= "작은 바 설정"
L.AreaTitle_BarSetupHuge 	= "커다란 바 설정"
L.EnableHugeBar 			= "커다란 바 사용 (일명 바 2)"
L.BarIconLeft 				= "왼쪽 아이콘"
L.BarIconRight 				= "오른쪽 아이콘"
L.ExpandUpwards				= "위로 쌓기"
L.FillUpBars				= "채워나가기"
L.ClickThrough				= "마우스 클릭 불가"
L.Bar_Decimal				= "남은시간 소수점 표시: %d초 이하"
L.Bar_DBMOnly				= "아래 설정은 \"DBM\" 바 스타일에서만 적용됩니다."
L.Bar_EnlargeTime			= "다음 시간보다 적으면 바 확대: %d초"
L.Bar_EnlargePercent		= "다음 비율보다 적으면 바 확대: %0.1f%%"
L.BarSpark					= "바 끝 강조"
L.BarFlash					= "만료 전에 바 점멸"
L.BarSort					= "남은 시간 기준으로 정렬"
L.BarColorByType			= "종류별 색상"
L.BarInlineIcons			= "바 안쪽에 아이콘 사용"
L.ShortTimerText			= "짧은 타이머 텍스트 사용 (사용 가능할 때만)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "특수 경고"
L.Area_SpecWarn				= "특수 경고 설정"
L.SpecWarn_ClassColor		= "특수 경고에 직업 색상 사용"
L.ShowSWarningsInChat 		= "대화창에 특수 경고 보기"
L.SWarnNameInNote			= "메모에 내 이름이 있으면 5번 경고(SW5) 설정 사용"
L.SpecialWarningIcon		= "특수 경고에 아이콘 사용"
L.SpecWarn_FlashFrame		= "특수 경고에 화면 점멸 효과 사용"
L.SpecWarn_FlashFrameRepeat	= "%d회 반복 (설정 켰을때)"
L.SpecWarn_Font				= "특수 경고 글꼴"
L.SpecWarn_FontSize			= "글꼴 크기: %d"
L.SpecWarn_FontColor		= "글꼴 색상"
L.SpecWarn_FontType			= "글꼴 선택"
L.SpecWarn_FlashRepeat		= "점멸 효과 반복"
L.SpecWarn_FlashColor		= "점멸 색상 %d"
L.SpecWarn_FlashDur			= "점멸 지속시간: %0.1f"
L.SpecWarn_FlashAlpha		= "점멸 투명도: %0.1f"
L.SpecWarn_DemoButton		= "예제 보기"
L.SpecWarn_MoveMe			= "위치 설정"
L.SpecWarn_ResetMe			= "기본값으로 초기화"
L.SpecialWarnSound			= "당신 또는 당신의 행동에 영향을 주는 특수 경고의 기본 효과음 설정"
L.SpecialWarnSound2			= "모두에게 영향을 주는 특수 경고의 기본 효과음 설정"
L.SpecialWarnSound3			= "매우 중요한 특수 경고의 기본 효과음 설정"
L.SpecialWarnSound4			= "도망 특수 경고의 기본 효과음 설정"
L.SpecialWarnSound5			= "메모에 이름이 있을때 특수 경고의 기본 효과음 설정"

-- Tab: Heads Up Display Frame
L.Panel_HUD					= "HUD (헤드 업 디스플레이)"
L.Area_HUDOptions			= "HUD 설정"
L.HUDColorOverride			= "모드에서 지정된 색상을 무시"
L.HUDSizeOverride			= "모드에서 지정된 크기를 무시"
L.HUDAlphaOverride			= "모드에서 지정된 투명도를 무시"
L.HUDTextureOverride		= "모드에서 지정된 텍스쳐를 무시 (전술 목표 아이콘 텍스쳐 설정엔 적용 안됨)"
L.HUDColorSelect			= "HUD 색상 %d"
L.HUDTextureSelect1			= "1순위 HUD 텍스쳐"
L.HUDTextureSelect2			= "2순위 HUD 텍스쳐"
L.HUDTextureSelect3			= "3순위 HUD 텍스쳐"
L.HUDTextureSelect4			= "'여기로 이동'을 가리키는 HUD 텍스쳐"
L.HUDSizeSlider				= "원 반지름: %0.1f"
L.HUDAlphaSlider			= "투명도: %0.1f"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "음성 경보"
L.Area_VoiceSelection		= "음성 선택"
L.CountdownVoice			= "1순위 초읽기 음성 설정"
L.CountdownVoice2			= "2순위 초읽기 음성 설정"
L.CountdownVoice3			= "3순위 초읽기 음성 설정"
L.VoicePackChoice			= "음성 경보에 쓸 음성팩 설정"
L.Area_CountdownOptions		= "초읽기 설정"
L.ShowCountdownText			= "1순위 초읽기 음성 재생시 화면 중앙에 숫자 표시"
L.Area_VoicePackOptions		= "음성팩 설정 (써드파티 음성팩)"
L.SpecWarn_NoSoundsWVoice	= "음성 경보가 있는 특수 경고의 효과음 재생"
L.SWFNever					= "하지 않음"
L.SWFDefaultOnly			= "특수 경고가 기본 효과음만 재생할 때 (사용자 지정 효과음은 계속 재생 허용)"
L.SWFAll					= "특수 경고가 모든 효과음을 사용할 때"
L.SpecWarn_AlwaysVoice		= "모든 음성 경보 재생 (보스마다 지정된 설정을 무시합니다. 공대장에게 유용합니다.)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?

-- Tab: HealthFrame
L.Panel_HPFrame				= "체력 창"
L.Area_HPFrame				= "체력 창 설정"
L.HP_Enabled				= "항상 체력 창 표시 (보스마다 지정된 설정 무시)"
L.HP_GrowUpwards			= "체력 창 위로 확장"
L.HP_ShowDemo				= "체력 창 보기"
L.BarWidth					= "바 너비: %d"

-- Tab: Global Filter
L.Panel_SpamFilter			= "DBM 전역 기능 끄기 및 필터"
L.Area_SpamFilter_Outgoing	= "DBM 전역 기능 끄기 및 필터 설정"
L.SpamBlockNoShowAnnounce	= "알림 및 효과음 재생 안함"
L.SpamBlockNoSpecWarn		= "특수 경고 및 효과음 재생 안함"
L.SpamBlockNoShowTimers		= "모드 타이머 표시 안함 (보스 모드/도전모드/파티찾기/재생성)"
L.SpamBlockNoShowUTimers	= "사용자 전송 타이머 표시 안함 (사용자 지정/풀링/휴식)"
L.SpamBlockNoSetIcon		= "대상에 전술 목표 아이콘 설정 안함"
L.SpamBlockNoRangeFrame		= "거리 창 표시 안함"
L.SpamBlockNoInfoFrame		= "정보 창 표시 안함"
L.SpamBlockNoHudMap			= "HUD 표시 안함"
L.SpamBlockNoNameplate		= "이름표 오라 표시 안함"
L.SpamBlockNoHealthFrame	= "보스 체력 창 표시 안함"
L.SpamBlockNoCountdowns		= "초읽기 효과음 재생 안함"
L.SpamBlockNoYells			= "대화 알림 사용 안함"
L.SpamBlockNoNoteSync		= "메모 공유 수락 안함"

L.Area_Restore				= "DBM 복구 설정 (DBM이 보스 모드 종료시 이전 사용자 설정 상태로 돌아갈 지 여부를 설정)"
L.SpamBlockNoIconRestore	= "아이콘 설정 상태를 저장하지 않고 전투 종료시 원래대로 복구"
L.SpamBlockNoRangeRestore	= "모드가 '숨김' 명령을 내렸을 때 이전 설정 상태로 거리 창 복구 안함"

-- Tab: Spam Filter
L.Area_SpamFilter			= "스팸 필터 설정"
L.DontShowFarWarnings		= "멀리 떨어진 곳의 이벤트에 대한 알림 및 바 표시 안함"
L.StripServerName			= "경고와 타이머에서 서버명 지우기"
L.SpamBlockBossWhispers		= "전투중 &lt;DBM&gt; 귓속말 안봄"
L.BlockVersionUpdateNotice	= "팝업창 대신 대화창에 '업데이트 필요' 알림 더 자주 표시"

L.Area_SpecFilter			= "역할 필터 설정"
L.FilterTankSpec			= "방어 전담이 아닐땐 방어 전담용 경고 보지 않기 (참고: '도발' 경고는 현재 전부 기본값으로 켜짐 상태이기 때문에 대부분의 이용자는 설정을 끄지 않는 것을 권장합니다.)"
L.FilterInterrupts			= "캐스터가 자신의 대상이나 주시 대상이 아닌 경우엔 차단 가능 주문에 경고 보지 않기 (알림: 차단 실패시 공격대에 치명적인 영향을 주는 주문에는 적용되지 않습니다.)"
L.FilterInterruptNoteName	= "사용자 메모에 자기 이름이 포함되지 않은 경우 차단 가능 주문의 경고 보지 않기"
L.FilterDispels				= "해제 주문이 재사용 대기중이면 해제 경고 보지 않기"
L.FilterSelfHud				= "HUD에서 자기 정보는 보지 않기 (거리 기반 HUD 기능은 제외)"

L.Area_PullTimer			= "풀링, 휴식, 전투, 사용자 지정 바 필터 설정"
L.DontShowPTNoID			= "같은 지역에 없는 사용자가 보낸 풀링 타이머 차단"
L.DontShowPT				= "풀링/휴식 타이머 표시 안함"
L.DontShowPTText			= "풀링/휴식 알림 텍스트 표시 안함"
L.DontPlayPTCountdown		= "풀링/휴식/전투/사용자 지정 초읽기 음성 재생 안함"
L.DontShowPTCountdownText	= "풀링/휴식/전투/사용자 지정 초읽기 숫자 표시 안함"
L.PT_Threshold				= "휴식/전투/사용자 지정 타이머 초읽기 숫자 표시 안함: %d초 까지"

L.Panel_HideBlizzard		= "블리자드 기능 끄기 및 숨김"
L.Area_HideBlizzard			= "블리자드 기능 끄기 및 숨김 설정"
L.HideBossEmoteFrame		= "보스 전투중 보스 감정표현 숨기기"
L.HideWatchFrame			= "추적중인 업적이 없을 경우 보스 전투시 퀘스트 추적 프레임을 숨깁니다. 도전 모드에서는 메달 제한시간 프레임이 생성됩니다."
L.HideGarrisonUpdates		= "보스 전투중 주둔지 팝업 알림 숨기기"
L.HideGuildChallengeUpdates	= "보스 전투중 길드 도전 과제 알림 숨기기"
L.HideQuestTooltips			= "보스 전투중 툴팁에서 퀘스트 정보 숨기기"
L.HideTooltips				= "보스 전투중 모든 툴팁 숨기기"
L.DisableSFX				= "보스 전투중 소리 채널 (효과음) 끄기"
L.SpamBlockSayYell			= "말풍선 알림 숨기기"
L.DisableCinematics			= "게임 내 영상 끄기"
L.AfterFirst				= "1회 이상 본 영상만"
L.Always					= "항상 끄기"
L.CombatOnly				= "전투중 차단 (모든 전투)"
L.RaidCombat				= "전투중 차단 (보스만)"

L.Panel_ExtraFeatures		= "기타 기능"
--
L.Area_ChatAlerts			= "텍스트 알림 설정"
L.RoleSpecAlert				= "공격대에 들어왔을 때 현재 전문화와 설정된 전리품 전문화가 맞지 않으면 알림 메시지 표시"
L.CheckGear					= "풀링 타이머가 나오면 착용 장비 알림 메시지 표시 (착용 아이템 레벨이 소지한 아이템 레벨보다 40 이상 낮거나 주무기가 장착되어 있지 않은 경우)"
L.WorldBossAlert			= "현재 서버에서 친구나 길드원이 필드 보스 전투를 시작하면 메시지 표시 (전송자가 연합 서버라면 부정확합니다)"
--
L.Area_SoundAlerts			= "효과음/점멸 알림 설정"
L.LFDEnhance				= "역할 확인 및 전장/공격대 찾기가 열릴 때 전투 준비 효과음 재생(주 오디오 또는 대화 채널) 및 와우 트레이 아이콘 점멸 (참고: 소리 채널이 꺼져있어도 작동하며, 다른 때보다 더 크게 들립니다)"
L.WorldBossNearAlert		= "근처에서 필드 보스 전투가 시작된 경우 전투 준비 효과음 재생 및 와우 트레이 아이콘 점멸"
L.RLReadyCheckSound			= "전투 준비 효과음을 주 오디오나 대화 채널을 통해 재생하고 와우 트레이 아이콘 점멸"
L.AFKHealthWarning			= "자리 비움 상태 도중 체력이 줄면 경고음 재생 및 와우 트레이 아이콘 점멸"
L.AutoReplySound			= "DBM 자동 응답 귓속말을 받을 때 경고음 재생 및 와우 트레이 아이콘 점멸"
--
L.TimerGeneral 				= "타이머 설정"
L.SKT_Enabled				= "가능할 경우 현재 전투의 최고 승리 기록 타이머 표시"
L.CRT_Enabled				= "다음 전투 부활 충전 타이머 표시"
L.ShowRespawn				= "전멸 후 보스 재생성 타이머 표시"
L.ShowQueuePop				= "입장 수락 남은 시간 타이머 표시 (공격대 찾기,전장 등)"
--
L.Area_AutoLogging			= "자동 전투 기록 설정"
L.AutologBosses				= "보스 전투시 블리자드 전투 기록 자동 활성화 (전투 시작전 물약이나 여러 이벤트를 기록하려면 /dbm pull 명령어 사용)"
L.AdvancedAutologBosses		= "Transcriptor 사용시 보스 전투 기록 자동 활성화"
L.LogOnlyRaidBosses			= "현재 확장팩의 레이드 보스만 기록하기 (공격대 찾기/파티/시나리오/구 컨텐츠 제외)"
--
L.Area_3rdParty				= "써드파티 애드온 설정"
L.ShowBBOnCombatStart		= "전투 시작시 Big Brother 버프 검사 실행"
L.BigBrotherAnnounceToRaid	= "Big Brother 버프 검사 결과를 공격대에 알림"
L.Area_Invite				= "초대 설정"
L.AutoAcceptFriendInvite	= "친구의 파티/공격대 초대 자동 수락"
L.AutoAcceptGuildInvite		= "길드원의 파티/공격대 초대 자동 수락"
L.Area_Advanced				= "고급 설정"
L.FakeBW					= "DBM 대신 BigWigs 사용자로 위장하기 (BigWigs 사용을 강제하는 공격대에서 유용)"
L.AITimer					= "DBM 내장 인공지능 타이머를 사용하여 처음 하는 전투의 타이머를 자동으로 생성합니다. (베타나 테스트 서버에서 보스 테스트시 유용) 알림: 동일한 주문을 사용하는 쫄이 여러 종류가 나오는 전투에서는 제대로 작동하지 않습니다."
L.AutoCorrectTimer			= "지나치게 긴 대기시간 바를 자동으로 교정합니다. (보스 모드가 업데이트되지 않은 최상위 콘텐츠를 공략하는 공격대에 유용) 알림: 보스 단계 전환시 타이머가 초기화될 경우 이 기능이 일부 타이머의 작동을 더 안좋게 만들 수 있습니다."

L.PizzaTimer_Headline 		= '"피자 타이머" 생성'
L.PizzaTimer_Title			= '이름 (예: "Pizza!")'
L.PizzaTimer_Hours 			= "시"
L.PizzaTimer_Mins 			= "분"
L.PizzaTimer_Secs 			= "초"
L.PizzaTimer_ButtonStart 	= "타이머 시작"
L.PizzaTimer_BroadCast		= "공격대에 알림"

L.Panel_Profile				= "프로필"
L.Area_CreateProfile		= "DBM Core 프로필 생성"
L.EnterProfileName			= "프로필 이름 입력"
L.CreateProfile				= "기본 설정값으로 새 프로필 생성"
L.Area_ApplyProfile			= "DBM Core 설정을 적용할 활성 프로필 설정"
L.SelectProfileToApply		= "적용할 프로필 선택"
L.Area_CopyProfile			= "DBM Core 설정 프로필 복사"
L.SelectProfileToCopy		= "복사할 프로필 선택"
L.Area_DeleteProfile		= "DBM Core 설정 프로필 삭제"
L.SelectProfileToDelete		= "삭제할 프로필 선택"
L.Area_DualProfile			= "보스 모드 프로필 설정"
L.DualProfile				= "전문화마다 다른 보스 모드 설정을 사용합니다. (보스 모드 프로필 관리는 로딩된 보스 모드의 통계 화면에서 이루어집니다)"

L.Area_ModProfile			= "다른 캐릭터/전문화의 설정 복사/삭제"
L.ModAllReset				= "이 모드의 모든 설정 초기화"
L.ModAllStatReset			= "이 모드의 모든 통계 초기화"
L.SelectModProfileCopy		= "전체 설정 복사"
L.SelectModProfileCopySound	= "음성 설정만 복사"
L.SelectModProfileCopyNote	= "메모 설정만 복사"
L.SelectModProfileDelete	= "모드 설정 삭제"
