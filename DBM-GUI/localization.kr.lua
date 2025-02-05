if GetLocale() ~= "koKR" then return end

if not DBM_GUI_L then DBM_GUI_L = {} end
local L = DBM_GUI_L

L.TranslationByPrefix		= "번역: "
L.TranslationBy 			= "Elnarfim"
L.Website					= "디스코드 |cFF73C2FBhttps://discord.gg/deadlybossmods|r를 방문해 보세요. SNS에서 @deadlybossmods 또는 @MysticalOS를 팔로우하세요"
L.WebsiteButton				= "웹사이트"

L.OTabBosses					= "보스 설정"--Deprecated and will be deleted once tabs no longer use this
L.OTabRaids						= "공격대"--Just pve raids
L.OTabDungeons						= "던전"--Just dungeons
L.OTabWorld						= "필드 보스"--Since there are so many world mods, enough to get their own tab
L.OTabScenarios						= "시나리오"--Future use, will be used for scenarios and delves, likely after there are more than 2 mods (so probably 12.x or later)
L.OTabPlugins						= "기타"--Scenarios, PVP, Delves (11.x), Solo/Challenge content (torghast, mage tower, etc)
L.OTabOptions					= "핵심 설정"
L.OTabAbout						= "소개"

L.FOLLOWER						= "추종자"--i.e. the new dungeon type in 10.2.5. I haven't found a translated string yet
L.STORY					    		= "이야기"--i.e. the new dungeon type in 11.0.0. I haven't found a translated string yet

L.TabCategory_CURRENT_SEASON		= "현재 시즌"

L.TabCategory_OTHER			= "기타 모드"
L.TabCategory_AFFIXES		= "어픽스"

L.BossModLoaded 			= "%s 통계"
L.BossModLoad_now 			= [[보스 모드가 로딩되지 않았습니다.
해당 인스턴스에 진입하면 로딩됩니다.
아래 버튼을 클릭해서 모드를 직접 로딩할 수도 있습니다.]]

L.PosX						= "위치 X"
L.PosY						= "위치 Y"

L.MoveMe 					= "위치 이동"
L.Button_OK					= "확인"
L.Button_Cancel				= "취소"
L.Button_LoadMod			= "애드온 로드"
L.Mod_Enabled				= "활성화: %s"
L.Mod_Reset					= "설정 기본값 로드"
L.Reset						= "초기화"
L.Import					= "가져오기"

L.Enable					= "활성화"
L.Disable					= "비활성화"

L.NoSound					= "없음"

L.IconsInUse				= "사용되는 공격대 징표:"

-- Tab: Boss Statistics
L.BossStatistics			= "보스 통계"
L.Statistic_Kills			= "승리:"
L.Statistic_Wipes			= "전멸:"
L.Statistic_Incompletes		= "미완료:"
L.Statistic_BestKill		= "최고 승리 기록:"
L.Statistic_BestRank		= "최고 등급:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Options
L.TabCategory_Options		= "일반 설정"
L.Area_BasicSetup			= "DBM 초기 설정 팁"
L.Area_ModulesForYou		= "나에게 맞는 DBM 모듈은 어떤게 있을까?"
L.Area_ProfilesSetup		= "DBM 프로필 사용법 가이드"
-- Panel: Core & GUI
L.Core_GUI 					= "핵심 모드와 GUI"
L.General 					= "일반 설정"
L.EnableMiniMapIcon			= "미니맵 버튼 표시"
L.EnableCompartmentIcon			= "애드온 모음 버튼에 표시"
L.UseSoundChannel			= "DBM 경고 효과음 재생 채널 선택"
L.UseMasterChannel			= "주 음량"
L.UseDialogChannel			= "대화"
L.UseSFXChannel				= "소리 (효과음)"
L.Latency_Text				= "동기화 신호를 보낼 최대 지연시간 설정: %d"

L.Button_RangeFrame			= "거리 창 표시/숨기기"
L.Button_InfoFrame			= "정보 창 표시/숨기기"
L.Button_TestBars			= "테스트 바 시작"
L.Button_MoveBars			= "바 이동"
L.Button_ResetInfoRange		= "정보/거리 창 위치 초기화"

L.ModelOptions				= "3D 모델 뷰어 설정"
L.EnableModels				= "보스 설정에 3D 모델 사용"
L.ModelSoundOptions			= "모델 뷰어에서 사용할 효과음 설정"
L.ModelSoundShort			= "짧은 효과음"
L.ModelSoundLong			= "긴 효과음"

L.ResizeOptions			 	= "설정 창 크기 설정"
L.ResizeInfo				= "우측 하단 모서리를 클릭 후 드래그하면 설정 창 크기를 조절할 수 있습니다."
L.Button_ResetWindowSize	= "설정 창 크기 초기화"
L.Editbox_WindowWidth		= "설정 창 너비"
L.Editbox_WindowHeight		= "설정 창 높이"

L.UIGroupingOptions			= "UI 그룹 설정 (이미 로딩이 된 모드는 UI 재시작을 해야 변경됩니다)"
L.GroupOptionsExcludeIcon	= "주문 단위로 형성된 그룹에서 '공격대 징표' 설정 제외 (제외된 설정들은 '공격대 징표' 카테고리에 배치)"
L.GroupOptionsExcludePrivateAura	= "주문 단위로 형성된 그룹에서 '비공개 오라' 효과음 설정 제외 (제외된 설정들은 '비공개 오라' 카테고리에 배치)"

L.AutoExpandSpellGroups		= "주문 단위로 그룹이 형성된 설정들을 자동으로 펼치기"
L.ShowWAKeys				= "보스 모드 활성 조건을 이용한 WeakAuras 제작을 지원하기 위해 주문 이름 옆에 WeakAuras 키를 표시합니다."
--L.ShowSpellDescWhenExpanded	= "설정 그룹이 펼쳐진 상태에서도 주문 설명 계속 표시"--Might not be used
L.NoDescription				= "이 능력에 대한 설명이 없습니다"
L.CustomOptions				= "이 항목에는 주문이나 도감 ID가 없는 능력이나 이벤트에 대한 사용자 정의 설정이 있습니다. WeakAuras 제작에 활용할 사용자 정의 ID 사용에 관한 설정들이 분류되어 있습니다"

--

-- Panel: Auto Logging
L.Panel_AutoLogging			= "자동 기록"

--Auto Logging: Logging toggles/types
L.Area_AutoLogging			= "자동 전투 기록 켜기/끄기"
L.AutologBosses				= "블리자드 전투 로그를 사용해 선택한 콘텐트를 자동으로 기록"
L.AdvancedAutologBosses		= "Transcriptor를 사용해 선택한 콘텐트를 자동으로 기록"
--Auto Logging: Global filter Options
L.Area_AutoLoggingFilters	= "자동 기록 필터"
L.RecordOnlyBosses			= "일반몹 기록 안함 (보스만 기록합니다. 보스전 시작 물약과 ENCOUNTER_START 이벤트를 기록하고 싶으면 '/dbm pull' 명령어를 사용하세요)"
L.DoNotLogLFG				= "던전 찾기와 공격대 찾기 기록 안함 (대기열 등록 콘텐트)"
--Auto Logging: Recorded Content types
L.Area_AutoLoggingContent	= "자동으로 기록할 콘텐트"
L.LogCurrentMythicRaids		= "현재 확장팩 (또는 리믹스) 신화 레이드"--Retail Only
L.LogCurrentRaids			= "현재 확장팩 (또는 리믹스) 비 신화 레이드 (영웅, 일반 그리고 던전 찾기와 공찾 기록 안함 옵션이 꺼져있을 경우엔 공찾까지)"
L.LogTWRaids				= "시간여행 또는 크로미의 시간 레이드 (리믹스 제외)"--Retail Only
L.LogTrivialRaids			= "구 레이드 (이전 확장팩)"
L.LogCurrentMPlus			= "현재 확장팩 (또는 리믹스) 신화+ 던전"--Retail Only
L.LogCurrentMythicZero		= "현재 확장팩 (또는 리믹스) 신화 0단 던전"--Retail Only
L.LogTWDungeons				= "시간여행 또는 크로미의 시간 던전 (리믹스 제외)"--Retail Only
L.LogCurrentHeroic			= "현재 확장팩 영웅 던전 (알림: 던전 찾기를 통해 영던을 돌면서 로그를 기록하고 싶다면 던전 찾기 기록 안함 옵션을 끄세요)"

-- Panel: Extra Features
L.Panel_ExtraFeatures		= "기타 기능"

L.Area_SoundAlerts			= "효과음/점멸 알림 설정"
L.LFDEnhance				= "역할 확인 및 전장/공격대 찾기가 열릴 때 전투 준비 효과음 재생(주 오디오 또는 대화 채널) 및 작업 표시줄 아이콘 점멸 (참고: 소리 채널이 꺼져있어도 작동하며, 다른 때보다 더 크게 들립니다)"
L.WorldBossNearAlert		= "근처에서 필드 보스 전투가 시작된 경우 전투 준비 효과음 재생 및 작업 표시줄 아이콘 점멸"
L.RLReadyCheckSound			= "전투 준비 효과음을 주 오디오나 대화 채널을 통해 재생하고 작업 표시줄 아이콘 점멸"
L.AutoReplySound			= "DBM 자동 응답 귓속말을 받을 때 경고음 재생 및 작업 표시줄 아이콘 점멸"

L.Area_CombatAlerts			= "전투 경고 설정"
L.AFKHealthWarning			= "자리 비움 상태 도중 생명력이 깎이면 경고음 재생 및 작업 표시줄 아이콘 점멸 (생명력 기준 무제한)"
L.HealthWarningLow			= "자리 비움 상태 도중 생명력이 깎이면 경고음 재생 및 작업 표시줄 아이콘 점멸 (35퍼센트 미만일 때)"
L.EnteringCombatAlert		= "전투에 돌입했을 때 경고음 재생 및 작업 표시줄 아이콘 점멸"
L.LeavingCombatAlert		= "전투가 끝났을 때 경고음 재생"
--
L.TimerGeneral 				= "타이머 설정"
L.SKT_Enabled				= "가능할 경우 현재 전투의 최고 승리 기록 타이머 표시"
L.ShowRespawn				= "전멸 후 보스 재생성 타이머 표시"
L.ShowQueuePop				= "입장 수락 남은 시간 타이머 표시 (공격대 찾기,전장 등)"
L.ShowBerserkWarnings		= "$spell:26662 타이머가 10/5/3/1분 30/10초 남았을 때 알림"
--
L.Area_3rdParty				= "써드파티 애드온 설정"
L.oRA3AnnounceConsumables	= "전투 시작시 oRA3 버프 검사 알림"
L.Area_Invite				= "초대 설정"
L.AutoAcceptFriendInvite	= "친구의 파티/공격대 초대 자동 수락"
L.AutoAcceptGuildInvite		= "길드원의 파티/공격대 초대 자동 수락"
L.Area_Advanced				= "고급 설정"
L.FakeBW					= "DBM 대신 BigWigs 사용자로 위장하기 (BigWigs 사용을 강제하는 공격대에서 유용)"

-- Panel: Profiles
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

L.Area_ImportExportProfile	= "프로필 가져오기/내보내기"
L.ImportExportInfo			= "가져오기를 하면 현재 프로필 설정에 덮어씌우게 되니 주의하세요."
L.ButtonImportProfile		= "프로필 가져오기"
L.ButtonExportProfile		= "프로필 내보내기"

L.ImportErrorOn				= "프로필 설정에 빠져있는 사용자 지정 효과음: %s"
L.ImportVoiceMissing		= "보이스팩 없음: %s"

-- Tab: Alerts
L.TabCategory_Alerts	 	= "경고"
L.Area_SpecAnnounceConfig	= "특수 경고 외형과 효과음 설정 가이드"
L.Area_SpecAnnounceNotes	= "특수 경고 메모 기능 가이드"
L.Area_VoicePackInfo		= "DBM 음성팩 정보"

-- Panel: Raidwarning
L.Tab_RaidWarning 			= "알림"
L.RaidWarning_Header		= "알림 설정"
L.RaidWarnColors 			= "알림 색상"
L.RaidWarnColor_1 			= "색상 1"
L.RaidWarnColor_2 			= "색상 2"
L.RaidWarnColor_3 			= "색상 3"
L.RaidWarnColor_4 			= "색상 4"
L.InfoRaidWarning			= [[레이드 경고 프레임의 위치와 색상을 설정할 수 있습니다.
본 프레임은 "플레이어 X가 Y에 걸렸습니다"와 같은 메시지를 표시하는데 사용됩니다.]]
L.ColorResetted 			= "이 영역의 색상 설정을 초기화 합니다."
L.ShowWarningsInChat 		= "대화창에서 알림 보기"
L.WarningIconLeft 			= "왼쪽에 아이콘 표시"
L.WarningIconRight 			= "오른쪽에 아이콘 표시"
L.WarningIconChat 			= "대화창에 아이콘 표시"
L.WarningAlphabetical		= "이름 순으로 정렬"
L.Warn_Duration				= "알림 지속시간: %0.1f초"
L.None						= "없음"
L.Random					= "무작위"
L.Outline					= "외곽선"
L.ThickOutline				= "두꺼운 외곽선"
L.MonochromeOutline			= "단색 외곽선"
L.MonochromeThickOutline	= "단색 두꺼운 외곽선"
L.RaidWarnSound				= "레이드 알림에 효과음 재생"

-- Panel: Spec Warn Frame
L.Panel_SpecWarnFrame		= "특수 알림"
L.Area_SpecWarn				= "특수 알림 설정"
L.SpecWarn_ClassColor		= "특수 알림에 직업 색상 사용"
L.ShowSWarningsInChat 		= "대화창에 특수 알림 보기"
L.SWarnNameInNote			= "특수 알림 메모에 내 이름이 있으면 5번 설정 사용"
L.SpecialWarningIcon		= "특수 알림에 아이콘 사용"
L.ShortTextSpellname		= "주문 이름을 짧게 줄여서 사용 (가능할 때만)"
L.SpecWarn_FlashFrameRepeat	= "점멸 %d회 반복"
L.SpecWarn_Flash			= "화면 점멸"
L.SpecWarn_Vibrate			= "컨트롤러 진동"
L.SpecWarn_FlashRepeat		= "점멸 효과 반복"
L.SpecWarn_FlashColor		= "점멸 색상 %d"
L.SpecWarn_FlashDur			= "점멸 지속시간: %0.1f"
L.SpecWarn_FlashAlpha		= "점멸 투명도: %0.1f"
L.SpecWarn_DemoButton		= "예제 보기"
L.SpecWarn_ResetMe			= "기본값으로 초기화"
L.SpecialWarnSoundOption	= "기본 효과음 설정"
L.SpecialWarnHeader1		= "유형 1: 당신이 뭔가 걸렸거나 취해야 할 행동에 대한 보통 수준 알림 설정 세트"
L.SpecialWarnHeader2		= "유형 2: 공격대 전체에 해당되는 보통 수준 알림 설정 세트"
L.SpecialWarnHeader3		= "유형 3: 최우선 알림 설정 세트"
L.SpecialWarnHeader4		= "유형 4: 최우선 도망 특수 알림 설정 세트"
L.SpecialWarnHeader5		= "유형 5: 메모에 당신의 이름이 있을 때 알림 설정 세트"

-- Panel: Generalwarnings
L.Tab_GeneralMessages 		= "대화창 메시지"
L.SelectChatFrameArea				= "대화창 설정"
L.SelectChatFrameButton				= "대화창 선택"
L.SelectChatFrameInfoIdle			= "%s에 메시지가 표시됩니다."
L.SelectChatFrameDefaultName		= "기본 대화창"
L.SelectChatFrameInfoDone			= "이 대화창에 메시지가 표시됩니다."
L.SelectChatFrameInfoSelect			= "대화창을 클릭해서 선택합니다."
L.SelectChatFrameInfoSelectNow		= "클릭해서 %s|1을;를; 선택하세요."
L.CoreMessages				= "기본 메시지 설정"
L.ShowPizzaMessage 			= "대화창에 전송받은 타이머 표시"
L.ShowAllVersions	 		= "버전 검사시 대화창에 모든 파티/공격대원의 보스 모드 버전을 표시합니다. (설정을 꺼도 구버전/신버전으로 간략하게 표시됨)"
L.ShowReminders				= "하위 모드 없음, 하위 모드 비활성화, 하위 모드 핫픽스, 하위 모드 구버전에 알림 메시지를 표시합니다. 조용함 모드에서도 활성화됩니다"

L.CombatMessages			= "전투 메시지 설정"
L.ShowEngageMessage 		= "대화창에 전투 시작 메시지 표시"
L.ShowDefeatMessage 		= "대화창에 처치/전멸 메시지 표시"
L.ShowGuildMessages 		= "대화창에 길드 레이드 전투 시작/보스 처치/전멸 메시지 표시"
L.ShowGuildMessagesPlus		= "길드팟 신화+ 전투 시작/보스 처치/전멸 메시지도 표시 (길드 레이드 옵션 체크 필요)"

L.Area_ChatAlerts			= "기타 알림 설정"
L.RoleSpecAlert				= "공격대에 들어왔을 때 현재 전문화와 설정된 전리품 전문화가 맞지 않으면 알림 메시지 표시"
L.CheckGear					= "풀링 타이머가 나오면 착용 장비 알림 메시지 표시 (착용 아이템 레벨이 소지한 아이템 레벨보다 40 이상 낮거나 주무기가 없을 경우)"
L.WorldBossAlert			= "같은 서버의 길드원이나 친구가 필드 보스 전투를 시작하면 알림 메시지 표시 (전송자가 연합 서버에 있다면 부정확합니다)"
L.WorldBuffAlert			= "내 서버에서 월드 버프가 시작되면 알림 메시지 표시 (디스커버리 시즌 제외)"

L.Area_BugAlerts			= "버그 제보 알림 설정"
L.BadTimerAlert				= "DBM이 최소 1초 이상 맞지 않는 불량 타이머를 감지했을 때 대화창에 메시지 표시"

-- Panel: Spoken Alerts Frame
L.Panel_SpokenAlerts			= "초읽기와 음성팩"
L.Area_VoiceSelection		= "음성 선택"
L.CountdownVoice			= "1순위 초읽기 음성 설정"
L.CountdownVoice2			= "2순위 초읽기 음성 설정"
L.CountdownVoice3			= "3순위 초읽기 음성 설정"
L.PullVoice					= "풀링 타이머 음성 설정"
L.VoicePackChoice			= "음성 경고에 쓸 음성팩 설정"
L.MissingVoicePack				= "음성팩 찾을 수 없음 (%s)"
L.Area_CountdownOptions		= "초읽기 설정"
L.Area_VoicePackReplace		= "음성팩 대체 설정 (사용시 음성팩의 효과음이 출력되며 기본 효과음 대체)"
L.VPReplaceNote				= "알림: 음성팩은 당신이 지정한 경고 효과음을 절대 변경하거나 삭제하지 않습니다.\n음성팩으로 대체되는 효과음들은 출력만 되지 않을 뿐입니다."
L.ReplacesAnnounce			= "알림 효과음 대체 (알림: 페이즈 변경과 쫄 등장을 제외하면 음성팩을 사용하는 효과음이 몇 안됩니다)"
L.ReplacesSADefault		= "기본 특수 알림 효과음 대체 (사용자가 직접 지정한 효과음은 절대 대체되지 않습니다)"
L.Area_VoicePackAdvOptions	= "음성팩 고급 설정"
L.Area_VPLearnMore			= "음성팩에 대한 정보 및 관련 설정 사용법 알아보기"
L.Area_BrowseOtherVP		= "Curse에 올라와있는 다른 음성팩 보기"
L.Area_BrowseOtherCT		= "Curse에 올라와있는 카운트다운 팩 보기"

-- Panel: Event Sounds
L.Panel_EventSounds			= "이벤트 효과음 (승리, 전멸, 기타)"
L.Area_SoundSelection				= "승리, 전멸, 풀링, 배경음악에 사용할 효과음 선택"
L.EventVictorySound			= "보스를 잡았을 때 재생할 효과음 설정"
L.EventWipeSound			= "전멸했을 때 재생할 효과음 설정"
L.EventEngagePT				= "풀링 타이머 시작시 재생할 효과음 설정"
L.EventEngageSound			= "보스 전투 시작시 재생할 효과음 설정"
L.EventDungeonMusic			= "던전/레이드에서 재생할 배경음 설정"
L.EventEngageMusic			= "보스 전투 도중 재생할 배경음 설정"
L.Area_EventSoundsExtras	= "이벤트 효과음 설정"
L.EventMusicCombined		= "던전과 보스 전투 배경음에 모든 음악 사용 (변경사항을 적용하려면 UI 리로드 필요)"
L.DisableBuiltInMusic			= "내장 이벤트 효과음과 음악을 사용하지 않고 써드파티 음악팩만 로드"
L.Area_EventSoundsFilters	= "이벤트 효과음 필터 적용 조건"
L.EventFilterDungMythicMusic		= "신화/신화+ 난이도에선 던전 배경음을 재생하지 않음"
L.EventFilterMythicMusic		= "신화/신화+ 난이도에선 보스 전투 배경음을 재생하지 않음"

-- Tab: Timers
L.TabCategory_Timers			= "타이머 바"
L.Area_ColorBytype			= "속성별 바 색상 가이드"
-- Panel: Color by Type
L.Panel_ColorByType	 		= "바 색상"
L.AreaTitle_BarColors				= "일반 바 색상 (기본값은 스킬 속성마다 지정)"
L.AreaTitle_ImpBarColors			= "중요 바 색상 (사용자가 중요로 설정한 바)"
L.BarTexture 				= "바 텍스쳐"
L.BarStyle 					= "바 작동 방식"
L.BarDBM					= "Classic (처음 생긴 바가 확대 표시될 위치로 스르륵 이동)"
L.BarSimple					= "Simple (처음 바는 사라지고 큰 바가 새로 생성)"
L.BarStartColor	 			= "시작 색상"
L.BarEndColor 				= "종료 색상"
L.Bar_Height				= "바 높이: %d"
L.Slider_BarOffSetX 		= "바 정렬: %d"
L.Slider_BarOffSetY 		= "바 간격: %d"
L.Slider_BarWidth 			= "바 너비: %d"
L.Slider_BarScale 			= "바 크기: %0.2f"
L.BarSaturation				= "작은 바 채도 (커다란 바 사용시 비활성): %0.2f"

--Types
L.BarStartColorAdd				= "시작 색상 1 (쫄)"
L.BarEndColorAdd				= "종료 색상 1 (쫄)"
L.BarStartColorAOE				= "시작 색상 2 (광역 피해)"
L.BarEndColorAOE				= "종료 색상 2 (광역 피해)"
L.BarStartColorDebuff			= "시작 색상 3 (대상)"
L.BarEndColorDebuff				= "종료 색상 3 (대상)"
L.BarStartColorInterrupt		= "시작 색상 4 (차단)"
L.BarEndColorInterrupt			= "종료 색상 4 (차단)"
L.BarStartColorRole				= "시작 색상 5 (역할)"
L.BarEndColorRole				= "종료 색상 5 (역할)"
L.BarStartColorPhase			= "시작 색상 6 (단계)"
L.BarEndColorPhase				= "종료 색상 6 (단계)"
L.BarStartColorUI				= "시작 색상 7 (중요)"
L.BarEndColorUI					= "종료 색상 7 (중요)"
L.BarStartColorI2				= "시작 색상 8 (중요)"
L.BarEndColorI2					= "종료 색상 8 (중요)"
--Type 7 options
L.Bar7Header					= "중요 바 설정"
L.Bar7ForceLarge				= "항상 커다란 바 사용"
L.Bar7CustomInline				= "바 안쪽에 사용자 지정 '!' 아이콘 사용"
--Dropdown Options
L.CBTGeneric					= "일반"
--Timer Example Texts
L.CBTAdd							= "쫄 등장"
L.CBTAOE							= "광역 주문"
L.CBTTargeted						= "대상 지정 주문"
L.CBTInterrupt						= "차단 가능 주문"
L.CBTRole							= "특정 역할 전용 주문"
L.CBTPhase							= "페이즈 전환"
L.CBTImportant						= "사용자 지정 중요 주문"
--Dropdown Options
L.SAOne						= "일반 음성 1 (개인 알림)"
L.SATwo						= "일반 음성 2 (전체 알림)"
L.SAThree					= "일반 음성 3 (동작 1순위)"
L.SAFour					= "일반 음성 4 (도망치기 1순위)"
L.ColorDropGeneric					= "일반 (기본 설정)"
L.ColorDrop1						= "색상 1"
L.ColorDrop2						= "색상 2"
L.ColorDrop3						= "색상 3"
L.ColorDrop4						= "색상 4"
L.ColorDrop5						= "색상 5"
L.ColorDrop6						= "색상 6"
L.CDDImportant1						= "중요 1"
L.CDDImportant2						= "중요 2"
L.CVoiceOne						= "초읽기 음성 1"
L.CVoiceTwo						= "초읽기 음성 2"
L.CVoiceThree					= "초읽기 음성 3"

-- Panel: Bar Appearance
L.Panel_Appearance	 		= "바 외형"
L.Panel_Behavior	 		= "바 작동 방식"
L.AreaTitle_BarSetup		= "바 외형 설정"
L.AreaTitle_Behavior		= "바 작동 방식 설정"
L.AreaTitle_BarSetupSmall 	= "작은 바 설정"
L.AreaTitle_BarSetupHuge 	= "커다란 바 설정"
L.AreaTitle_BarSetupVariance		= "가변적 바 설정"
L.EnableHugeBar 			= "커다란 바 사용 (일명 바 2)"
L.EnableVarianceBar 				= "가변적 바 사용"
L.VarianceTransparency				= "바 투명도: %0.1f"
L.VarianceTimerTextBehavior			= "가변적 타이머 텍스트 작동 방식 설정"
L.ZeroatWindowEnds					= "타이머 마지막 지점을 0으로 설정"
L.ZeroatWindowStartPause			= "타이머 시작 지점을 0으로 하고 0에서 정지"
L.ZeroatWindowStartRestart			= "타이머 시작 지점을 0으로 하고 0에서 재시작"
L.ZeroatWindowStartNeg				= "타이머 시작 지점을 0으로 하고 0에서 음수로 진행"--Default
L.BarIconLeft 				= "왼쪽 아이콘"
L.BarIconRight 				= "오른쪽 아이콘"
L.ExpandUpwards				= "위로 쌓기"
L.FillUpBars				= "채워나가기"
L.ClickThrough				= "마우스 클릭 불가"
L.Bar_Decimal				= "남은시간 소수점 표시: %d초 이하"
L.Bar_Alpha					= "투명도: %0.1f"
L.Bar_EnlargeTime			= "다음 시간보다 적으면 바 확대: %d초"
L.BarSpark					= "바 끝 강조"
L.BarFlash					= "만료 전에 바 점멸"
L.BarSort					= "남은 시간 기준으로 정렬"
L.BarColorByType			= "속성마다 색상 변경"
L.Highest					= "가장 높은 순"
L.Lowest					= "가장 낮은 순"
L.NoBarFade					= "시작/종료시 색상 변화를 그라데이션 효과 대신 작은/큰 바 색을 사용"
L.BarInlineIcons			= "바 안쪽에 아이콘 사용"
L.DisableRightClickBar				= "우클릭으로 타이머 취소 기능 끄기"
L.ShortTimerText			= "짧은 타이머 텍스트 사용 (사용 가능할 때만)"
L.KeepBar					= "스킬 시전 전까지 타이머 작동 중단"
L.KeepBar2					= "(모드에서 지원할 경우에만)"
L.FadeBar					= "사정거리 밖의 스킬에 대한 타이머 바 숨김"
L.BarSkin					= "바 스킨"

-- Panel: Pull, Break, Combat
L.Panel_PullBreakCombat				= "풀링과 휴식"

L.Area_SoundOptions					= "효과음 설정"

-- Tab: Global Disables & Filters
L.TabCategory_Filters	 	= "기능 끄기 및 필터"
L.Area_DBMFiltersSetup		= "DBM 기능 필터 가이드"
L.Area_BlizzFiltersSetup	= "블리자드 기능 필터 가이드"

-- Panel: Toggle DBM Features
L.Panel_SpamFilter			= "DBM 기능 끄기"

L.Area_SpamFilter_SpecFeatures		= "알림 기능"
L.SpamBlockNoShowAnnounce	= "모든 알림 및 효과음 재생 안함"
L.SpamBlockNoSpecWarnText	= "특수 알림 텍스트 표시 안함"
L.SpamBlockNoSpecWarnFlash	= "특수 알림에 화면 점멸 사용 안함"
L.SpamBlockNoSpecWarnVibrate		= "특수 알림에 컨트롤러 진동 안함"
L.SpamBlockNoSpecWarnSound	= "특수 알림 효과음 재생 안함 (초읽기와 음성팩 메뉴에서 활성화된 음성팩은 계속 작동)"
L.SpamBlockNoPrivateAuraSound		= "비공개 오라 효과음 등록 안함"

L.Area_SpamFilter_Timers	= "타이머"
L.SpamBlockNoShowBossTimers		= "던전/레이드 보스 타이머 표시 안함"
L.SpamBlockNoShowTrashTimers		= "던전/레이드 일반몹 타이머 표시 안함 (알림: 이름표의 쿨타임도 표시되지 않습니다)"
L.SpamBlockNoShowEventTimers		= "이벤트나 알림 타이머 표시 안함 (대기열, 보스 재생성 등)"
L.SpamBlockNoShowUTimers	= "사용자 전송 타이머 표시 안함 (사용자 지정/풀링/휴식)"
L.SpamBlockNoCountdowns		= "초읽기 음성 재생 안함"

L.Area_SpamFilter_Nameplates		= "이름표"
L.SpamBlockNoNameplate				= "특수한 보스 패턴의 스킬 아이콘을 이름표에 표시 안함 (예: 적에게 버프나 디버프 거는 패턴)"
L.SpamBlockNoNameplateCD			= "스킬 쿨타임 타이머 아이콘을 이름표에 표시 안함"
L.SpamBlockNoNameplateCasts			= "스킬 시전시 아이콘을 이름표에 표시 안함"
L.SpamBlockNoBossGUIDs				= "타이머도 있는 스킬의 쿨타임 타이머 아이콘을 이름표에 표시 안함\n(보통 던전 보스에 적용)"
L.AlwaysKeepNPs						= "쿨타임 타이머 아이콘을 만료됐어도 스킬 재시전까지 유지"

L.Area_SpamFilter_Misc		= "기타"
L.SpamBlockNoSetIcon		= "대상에 공격대 징표를 자동으로 설정하지 않음"
L.SpamBlockNoRangeFrame		= "거리 창을 자동으로 표시 안함"
L.SpamBlockNoInfoFrame		= "정보 창을 자동으로 표시 안함"
L.SpamBlockNoHudMap			= "HUD 표시 안함"
L.SpamBlockNoYells			= "말풍선 알림 사용 안함"
L.SpamBlockNoNoteSync		= "메모 공유 수락 안함"
L.SpamBlockAutoGossip		= "NPC 대화 자동 수락 안함"

L.Area_Restore				= "DBM 복구 설정 (DBM이 보스 모드 종료시 이전 사용자 설정 상태로 돌아갈 지 여부를 설정)"
L.SpamBlockNoIconRestore	= "아이콘 설정 상태를 저장하지 않고 전투 종료시 원래대로 복구"
L.SpamBlockNoRangeRestore	= "모드가 '숨김' 명령을 내렸을 때 이전 설정 상태로 거리 창 복구 안함"

L.Area_PullTimer			= "풀링, 휴식, 사용자 지정 바 관련 필터 설정"
L.DontShowPTNoID			= "같은 지역에 없는 사용자가 보낸 DBM 풀링 타이머 차단"
L.DontShowPT				= "풀링/휴식 타이머 표시 안함"
L.DontShowPTText			= "풀링/휴식 알림 텍스트 표시 안함"
L.DontPlayPTCountdown		= "풀링/휴식/사용자 지정 초읽기 전구간 음성 재생 안함"
L.PT_Threshold				= "풀링/휴식/사용자 지정 타이머 초읽기 음성 재생 안함: %d초 까지"

-- Panel: Reduce Information
L.Panel_ReducedInformation			= "정보량 줄이기"

L.Area_SpamFilter_Anounces	= "알림 관련 기능 끄기 및 필터 설정"
L.SpamBlockNoShowTgtAnnounce = "대상자 알림 중 타인에게 영향이 없는 것은 알림과 효과음 출력하지 않음 (DBM 기능 항목에서 전체 끄기를 설정하면 이 설정 무시)"
L.SpamBlockNoTrivialSpecWarnSound	= "현재 레벨에 맞는 콘텐츠 이외에는 특수 알림 효과음 재생이나 화면 점멸 효과 사용 안함 (대신 사용자가 선택한 정규 알림 효과음 재생)"

L.Area_SpamFilter			= "스팸 방지 필터 설정"
L.DontShowFarWarnings		= "멀리 떨어진 곳의 이벤트에 대한 알림 및 바 표시 안함"
L.StripServerName			= "알림, 타이머, 거리 검사, 정보 창에서 이름에 서버명 제거"
L.FilterVoidFormSay2			= "공허의 형상일땐 공격대 징표나 초읽기를 말풍선으로 표시 안함 (그 외 말풍선 알림은 작동)"

L.Area_SpecFilter			= "역할 관련 필터 설정"
L.FilterDispels				= "해제 주문이 쿨타임일땐 해제 알림 보지 않기"
L.FilterCrowdControl			= "메즈기가 쿨타임일땐 메즈 기반 차단 알림 보지 않기"
L.FilterTrashWarnings		= "추종자, 일반, 저레벨 던전에선 일반몹 알림 보지 않기"

L.Area_BInterruptFilter				= "보스 차단 알림 필터 설정"
L.FilterTargetFocus					= "현재 대상/주시 대상/액션 대상(적)이 아니면 알림 표시 안함"
L.FilterInterruptCooldown			= "차단 주문이 쿨타임일땐 표시 안함"
L.FilterInterruptHealer				= "힐러일때 표시 안함"
L.FilterInterruptNoteName			= "시전 횟수가 포함되어 있는 차단 알림에서 사용자 정의 메모에 내 이름이 없으면 표시 안함"--Only used on bosses, trash mods don't assign counts
L.Area_BInterruptFilterFooter		= "필터를 선택하지 않으면 모든 차단 알림이 표시됩니다 (스팸이 될 수 있음)\n일부 모드에선 매우 중요한 주문일 경우 필터 설정이 완전히 무시될 수 있습니다"
L.Area_TInterruptFilter				= "일반몹 차단 알림 필터 설정"--Reuses above 3 strings

-- Panel: DBM Handholding
L.Panel_HandFilter					= "DBM 관할 알림 줄이기"
L.Area_SpamFilter_SpecRoleFilters	= "특수 알림 유형 필터 (DBM이 관할하는 알림의 정보량 조정)"
L.SpamSpecInformationalOnly			= "특수 알림에서 행동 지시 텍스트/음성 알림을 전부 삭제합니다. (UI 재시작 필요) 알림은 여전히 표시되며 음성도 출력되지만 일반적인 사항만 보여주며 직접적인 지시 사항은 줄어듭니다"
L.SpamSpecRoleDispel				= "'해제' 경고 완전히 빼기 (텍스트와 효과음 전부)"
L.SpamSpecRoleInterrupt				= "'차단' 경고 빼기 (텍스트와 효과음 전부)"
L.SpamSpecRoleDefensive				= "'생존기' 경고 빼기 (텍스트와 효과음 전부)"
L.SpamSpecRoleTaunt					= "'도발' 경고 빼기 (텍스트와 효과음 전부)"
L.SpamSpecRoleSoak					= "'바닥 밟기' 경고 빼기 (텍스트와 효과음 전부)"
L.SpamSpecRoleStack					= "'중첩 높음' 경고 빼기 (텍스트와 효과음 전부)"
L.SpamSpecRoleSwitch				= "'대상 변경' &amp; '쫄 등장' 경고 빼기 (텍스트와 효과음 전부)"
L.SpamSpecRoleGTFO					= "'바닥 피하기' 경고 빼기 (텍스트와 효과음 전부)"

-- Panel: Blizzard Features
L.Panel_HideBlizzard				= "블리자드 기능 차단"
--Toast
L.Area_HideToast					= "블리자드 토스트 알림 비활성화 (팝업)"
L.HideGarrisonUpdates				= "보스 전투중 추종자 토스트 알림 숨기기"
L.HideGuildChallengeUpdates			= "보스 전투중 길드 도전 과제 토스트 알림 숨기기"
--L.HideBossKill				= "보스 처치 토스트 알림 숨기기"--NYI
--L.HideVaultUnlock					= "금고 잠금 해제 토스트 알림 숨기기"--NYI
--Cut Scenes
L.Area_Cinematics					= "게임내 시네마틱 재생 차단"
L.DuringFight						= "보스 전투중 컷신 재생 차단"--uses explicite IsEncounterInProgress check
L.InstanceAnywhere					= "던전이나 공격대 인스턴스에서 비전투 컷신 재생 차단"
L.NonInstanceAnywhere				= "위험: 야외 컷신 재생 차단 (권장하지 않음)"
L.OnlyAfterSeen						= "위 선택 사항에 해당되는 것 중 1회 이상 본 컷신만 재생 차단 (스토리 이해를 위해 한번은 보도록 의도된 옵션이며 사용을 강력히 권장합니다)"
--Sound
L.Area_Sound						= "게임내 소리 차단"
L.DisableSFX					= "보스 전투중 효과 음량 비활성화"
L.DisableAmbiance					= "보스 전투중 환경 음량 비활성화"
L.DisableMusic						= "보스 전투중 배경음악 음량 비활성화 (알림: 옵션을 켜면 이벤트 효과음에서 보스 전투 배경음을 설정해도 재생이 되지 않습니다)"
--Other
L.Area_HideBlizzard			= "그 외 블리자드 성가신 요소 비활성화 및 숨김"
L.HideBossEmoteFrame		= "보스 전투중 보스 감정표현 프레임 숨기기"
L.HideWatchFrame			= "추적중인 업적이 없고 신화+ 난이도가 아니라면 보스 전투시 퀘스트 추적 프레임 숨기기"
L.HideQuestTooltips			= "보스 전투중 툴팁에서 퀘스트 목표 숨기기"--Currently hidden (NYI)
L.HideTooltips				= "보스 전투중 툴팁 완전히 숨기기"

-- Panel: Raid Leader Controls
L.Tab_RLControls					= "공대장 제어 설정"
L.Area_FeatureOverrides				= "기능 무시 설정"
L.OverrideIcons 					= "공격대에서 자신 포함 모든 사용자들의 공격대 징표 설정을 비활성화"-- (Use override instead of disable if you want DBM to do marking under your terms)
L.OverrideSay						= "공격대에서 자신 포함 모든 사용자들의 말풍선/일반 대화 메시지 설정 비활성화"
L.DisableStatusWhisperShort			= "공격대/파티의 현재 상태/답변 귓속말 비활성화"--Duplicated from privacy but makes sense to include option in both panels
L.DisableGuildStatusShort			= "공격대/파티의 길드와 연동된 공략 진도 메시지 비활성화"--Duplicated from privacy but makes sense to include option in both panels
--L.DisabledForDropdown				= "비활성화 기능이 적용될 보스 모드 선택"--NYI
--L.DiabledForBoth					= "DBM과 BW 모두 위의 기능 비활성화"--NYI
--L.DiabledForDBM					= "DBM 사용자들만 위의 기능 비활성화"--NYI
--L.DiabledForBW					= "BW 사용자들만 위의 기능 비활성화"--NYI

L.Area_ConfigOverrides				= "기능 강제 적용 설정 (미구현, 향후 구현 예정)"--NYI
L.OverrideBossAnnounceOptions		= "모든 DBM 사용자의 보스 모드 알림 설정을 내 설정대로 적용"--NYI
L.OverrideBossTimerOptions			= "모든 DBM 사용자의 보스 모드 타이머 바 설정을 내 설정대로 적용"--NYI
L.OverrideBossIconOptions			= "모든 DBM 사용자의 보스 모드 공격대 징표 설정을 내 설정대로 적용 (위의 설정에서 공격대 징표를 비활성화했다면 이 설정은 무시합니다)"--NYI
L.OverrideBossSayOptions			= "모든 DBM 사용자의 보스 모드 말풍선 설정을 내 설정대로 적용 (위의 설정에서 말풍선을 비활성화했다면 이 설정은 무시합니다)"--NYI
L.ConfigAreaFooter					= "이곳의 설정들은 전투 시작시 임시로 사용자에게 강제 적용되는 것으로 저장된 개인 설정은 바꾸지 않습니다."
L.ConfigAreaFooter2					= "모든 역할들의 설정을 검토하는 것을 권장하며 탱커나 그밖에 필요로 하는 역할의 타이머 바/경고 설정을 제외하지 마세요"

L.Area_receivingOptions				= "수신 설정 (미구현, 향후 구현 예정)"--NYI
L.NoAnnounceOverride				= "공대장의 알림 강제 적용을 수락하지 않습니다."--NYI
L.NoTimerOverridee					= "공대장의 타이머 바 강제 적용을 수락하지 않습니다."--NYI
L.ReplaceMyConfigOnOverride			= "경고: 강제 적용시 공대장의 설정이 내 모드 설정을 대체하게 되며 되돌릴 수 없습니다"--NYI
L.ReceivingFooter					= "공격대 징표와 말풍선 설정이 주변 다른 사람들에게 적용되고 나면 나만 예외로 빠질 수 없습니다"--NYI
L.ReceivingFooter2					= "이러한 설정을 활성화했을때 내 설정이 의도한 것과 충돌할 경우 당신과 공대장 둘만 조정하면 됩니다"--NYI
L.ReceivingFooter3					= "'내 모드 설정을 대체'를 활성화하면 당신의 원래 설정은 강제 적용된 설정에 의해 지워질 것입니다"--NYI


L.TabFooter							= "이 패널의 모든 설정은 당신이 공격대/공찾 공대장일때만 작동합니다"

-- Panel: Privacy
L.Tab_Privacy 				= "자동 응답과 사생활 보호"
L.Area_WhisperMessages		= "귓속말 설정"
L.AutoRespond 				= "전투중 자동 귓속말 답변"
L.WhisperStats 				= "귓속말 답변에 처치/전멸 통계 포함"
L.DisableStatusWhisper 		= "공격대 전반에 관한 상태 보고 귓속말을 끕니다. (공대장 권한 필요) 일반/영웅/신화 레이드와 신화+ 던전에만 적용됩니다"
L.Area_SyncMessages			= "애드온 동기화 설정"
L.DisableGuildStatus 		= "동기화된 길드에게 레이드 진도 알림 메시지를 받지 않습니다. 공대장일 경우 이 옵션이 공격대 내 모든 DBM 사용자에게 적용됩니다"
L.EnableWBSharing 			= "길드와 같이 필드 보스 전투를 시작/처치시 같은 서버에 있는 배틀넷 친구에게 공유합니다."

-- Tab: Frames & Integrations
L.TabCategory_Frames		= "창 및 통합 기능"
L.Area_NamelateInfo			= "DBM 이름표 오라 정보"
-- Panel: InfoFrame
L.Panel_InfoFrame			= "정보 창"

-- Panel: Range
L.Panel_Range				= "거리 창"

-- Panel: Nameplate
L.Panel_Nameplates			= "이름표"
L.Plater_Config						= "Plater 설정창 열기"
L.Area_NPStyle				= "외형 (알림: Plater를 사용하지 않을 때만 설정이 가능합니다)"
L.NPAuraText					= "이름표 아이콘에 타이머 텍스트 표시"
L.NPAuraSize				= "아이콘 픽셀 크기 (정사각형): %d"
L.NPIcon_BarOffSetX 				= "아이콘 위치 조정 X: %d"
L.NPIcon_BarOffSetY 				= "아이콘 위치 조정 Y: %d"
L.NPIcon_GrowthDirection 			= "아이콘 생성 방향"
L.NPIcon_Spacing		 			= "아이콘 간격: %d"
L.NPIcon_MaxTextLen		 			= "텍스트 최대 길이: %d"
L.NPIconAnchorPoint		 			= "아이콘 기준점"
L.NPDemo							= "테스트 (이름표 보이는데서만 작동)"
L.FontTypeTimer						= "타이머 글꼴 선택"
L.FontTypeText						= "텍스트 글꼴 선택"

L.Area_NPGlow						= "반짝임 (알림: Plater를 사용하지 않을 때만 반짝임 설정이 가능합니다)"
L.NPIcon_GlowBehavior 		    	= "쿨타임 아이콘 반짝임 작동 방식"
L.NPIcon_CastGlowBehavior 		   	= "시전 아이콘 반짝임 작동 방식"
L.NPIcon_GlowNone			    	= "반짝임 사용 안함"
L.NPIcon_GlowImportant			   	= "중요한 주문의 쿨타임/시전 시간 만료시 반짝임"
L.NPIcon_GlowAll			    	= "모든 주문의 쿨타임/시전 시간 만료시 반짝임"
L.NPIcon_GlowTypeCD		        	= "쿨타임 아이콘 반짝임 종류"
L.NPIcon_GlowTypeCast		        = "시전 아이콘 반짝임 종류"
L.NPIcon_Pixel  			    	= "픽셀"
L.NPIcon_Proc  			        	= "스킬 발동 (첫 발동시 시각 효과 버그)"
L.NPIcon_AutoCast					= "자동 시전"
L.NPIcon_Button						= "버튼"

-- Misc
L.Area_General				= "일반"
L.Area_Position				= "위치"
L.Area_Style				= "외형"

L.FontSize				= "글꼴 크기: %d"
L.FontStyle				= "글꼴 속성"
L.FontColor			= "글꼴 색상"
L.FontShadow				= "그림자"
L.FontType				= "글꼴 선택"

L.FontHeight	= 16



-- Testing
L.DevPanel							= "개발 및 테스트"
L.DevPanelArea						= "개발 및 테스트 UI"
L.DevPanelExplanation				= "DBM이 의도한 대로 작동하고 있는지 전투 로그를 재생해서 검증하는 개발 및 테스트 UI입니다." -- Test UI panel under options
L.DevModPanelExplanation			= [[본 모듈의 개발 및 시험장에 오신 것을 환영합니다.
이곳에선 보스 전투 로그를 재생해서 해당 모듈이 어떻게 작동하는지 관찰하고 DBM 콜백들의 통합을 테스트합니다. 통합과 콜백에 관한 자세한 사항은 DBM-Test/README.md를 참고하시기 바랍니다. DBM에서 제공하는 여러 레이드의 예제 로그가 있으며 Transcriptor로 작성된 로그를 가져올 수도 있습니다.
]] -- Playground mode in mods

L.TimewarpSetting					= "시간 흐름: %dx"
L.TimewarpDynamic					= "시간 흐름: 동적 (가장 빠름)"
L.TestSupportArea					= "모듈 로딩 설정"
L.ModNotLoadedWithTests				= "경고: 이 모듈은 현재 완전한 테스트가 가능하게 로딩되지 않았습니다. 이 모듈이 UnitHealth()나 UnitName()같은 API 함수를 직접 호출할 경우 제대로 작동하지 않을 것입니다. 유닛의 생명력, 자원, 대상과 관련된 함수에서 자주 발생합니다."
L.ModLoadedWithTests				= "모듈이 완전한 테스트가 가능하도록 로딩되지 않았습니다. 애드온에서 최소 1개 이상의 모듈은 테스트 모드를 활성화해야 합니다."
L.AlwaysLoadModWithTests			= "이 모듈을 항상 완전한 테스트가 가능하도록 로드 (로딩 속도 약간 느려짐)"
L.ModLoadRequiresReload				= ", UI 재시작 필요" -- Appended to L.AlwaysLoadModWithTests
L.TestSelectArea					= "데이터 테스트" -- Title of the UI area
L.SelectPerspective					= "로그 관점 (플레이어로 가정)"
L.ImportTranscriptor				= "Transcriptor 로그 가져오기"
L.ImportTranscriptorHeader			= [[
아래 상자의 아무곳이나 붙여넣으면 Transcriptor 로그를 가져올 수 있습니다. 붙여넣기 속도는 대략 2 MiB/s 정도 되며, 이는 아주 큰 용량의 로그 파일을 붙여넣기하면 수 초 가량 게임이 멈춘다는 뜻입니다.
우측의 가져오기 버튼으로 Transcriptor의 저장된 데이터 중에서 현재 세션만 가져올 수도 있습니다.]]
L.PasteLogHere						= (IsMacClient() and "Cmd-V" or "Ctrl-V") .. "를 눌러서 이곳에 로그를 붙여넣기 하세요."
L.LogPasted							= "%.2f MiB를 %.1f초간 붙여넣었습니다. (%.2f MiB/s)"
L.ImportLocalTranscriptor			= "현재 Transcriptor\n세션 붙여넣기"
L.NoLocalTranscriptor				= "로컬 Transcriptor 데이터를 찾을 수 없습니다."
L.LocalImportDone					= "Transcriptor에서 로그 %d개 보스 전투 %d개를 가져왔습니다."
L.Parsing							= "분석중..."
L.SelectLogDropdown					= "보스 전투 선택"
L.CreateTest						= "테스트 작성"
L.ExportTest						= "테스트 내보내기"
L.ExportedTest						= "테스트 케이스를 %d줄 내보냈습니다. (%.1f%% 걸러짐)"
L.ExportedTestFailedAnon			= "경고: 로그 익명화에 실패했으며 %d개의 익명화가 안된 문자열이 있습니다. (대화창에 세부 내역과 출력)"
L.ExportTestFailedNonAnonString		= "경고: 문자열 %q 익명화되지 않은 것으로 보입니다."
L.CreatedTest						= "%d개의 이벤트로 테스트를 %.1f초에 걸쳐 작성했습니다."
L.NoLogsFound						= "Transcriptor 가져오기에 로그 데이터가 들어있지 않습니다."
L.NoTestDataAvailable				= "사용 가능한 테스트 데이터 없음"
L.NoLogSelected						= "테스트 작성 실패: 선택한 로그가 없습니다."
L.LogAlreadyImported				= "테스트 작성 실패: 이미 가져온 것입니다."

L.RewriteAllToYou					= "모든 플레이어를 동시에"
L.RealModOptionsBelow				= "아래의 모듈 설정은 시험장 모드와 실제 설정간의 동기화에 관한 것입니다."
L.Test								= "테스트"
L.Tests								= "테스트"
L.AllTests							= "모든 테스트"
L.RunTest							= "테스트 실행"
L.RunTestShort						= "실행" -- Same intend as RunTest, but a smaller button
L.StopTest							= "테스트 중지"
L.StopTests							= "테스트 중지"
L.RunAllTests						= "모든 테스트 실행"
L.Queued							= "대기중"
L.Running							= "실행중"
L.Failed							= "실패"
L.ShowReport						= "보고서 보기"
L.ShowErrors						= "오류 보기"
L.TestModEntry						= "[시험장] %s"
L.EnterTestMode						= "시험장 모드"
L.SkipPhase							= "다음 단계로 넘어가기"

L.AnonymizeTest						= "플레이어 이름과 GUID 익명 처리"
L.ShowThisTestEverywhere			= "모든 모드에 이 테스트 표시"
L.SaveThisTest						= "이 테스트 기록을 계속해서 저장"

L.BossModTColor						= "바 색상"
L.BossModCVoice						= "초읽기 음성"
L.BossModSWSound					= "알림 소리"
