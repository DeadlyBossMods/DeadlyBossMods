if GetLocale() ~= "koKR" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations

-- BossMod studio
L.TabCategory_BossModStudio		= "보스 모드 스튜디오"
L.TabCategory_Triggers			= "트리거와 이벤트"
L.AreaHead_CreateBossMod		= "현재 보스 모드의 기본 정보"
L.BossName						= "보스 이름 - 예: '아서스'"
L.BossID						= "보스의 개체 ID"
L.BossLookup					= "대상으로 부터 개체 ID 얻기"

L.AreaHead_Pull					= "풀링 / 전투 시작 탐지"
L.CombatFromYell				= "외치기와 함께 전투 시작"
L.CombatAutoDetect				= "일반적인 전투 시작"
L.BossPullYell					= "전투 시작시 보스의 외침"
L.BossEnrages					= "광폭화 있음"
L.BossEnrageBar					= "광폭화 바 보기"
L.BossEnrageAnnounce			= "공격대에 광폭화 알리기"

L.Min = "분"
L.Sec = "초"

L.AreaHead_TriggerCreate		= "보스 이벤트 트리거 만들기"
L.Describe_TriggerCreate		= [[보스전에서 발생하는 이벤트를 다루기 위해 트리거를 제작할 수 있습니다. 보스의 외침이나 능력중 하나를 사용할 때를 확인해서 만드시는 것이 좋습니다. 예를 들어, 보스가 "방패의 벽" 능력을 얻었을 때 바를 시작하고 싶다면, 단지 해당 능력이 버프냐 디버프냐를 확인 한 후 이벤트 이름에 "방패의 벽"이라고 적으면 됩니다.]]

L.Trigger_Typ					= "이벤트 발생 조건"
L.Trigger_Name					= "현재 이벤트의 이름 (설명)"
L.Trigger_Typ_Spell				= "주문"
L.Trigger_Typ_Buff				= "버프 또는 디버프"
L.Trigger_Typ_Yell				= "외치기 또는 감정표현"
L.Trigger_Typ_Time				= "시간 기반"
L.Trigger_Typ_Hp				= "체력 기반"
L.Trigger_Create_Bttn			= "이벤트 만들기"
L.Trigger_Delete_Bttn			= "이벤트 삭제"

L.EventYellText					= "외치기/말하기/감정표현 대사"
L.EventTimeBased				= "이벤트 까지의 대기 시간"
L.EventHpBased					= "이벤트 시작시 체력 %"
L.EventSpellID					= "주문 ID"
L.EventAnnounce					= "경고"
L.EventAnnounceText				= "경고 메세지"
L.EventSpecialWarn				= "특수 경고 보기"
L.EventSpecialWarn_OnlyMe		= "자신에게 영향을 미치는 경우만"
L.EventStartBar					= "타이머 시작"
L.EventWarnEnd					= "타이머 종료 전에 경고 표시"
L.EventWarnMsg					= "경고 메세지"
L.EventSetIcon					= "대상에게 전술 목표 아이콘 설정 (외치기의 경우 %t가(대상) 있을 때만)"


