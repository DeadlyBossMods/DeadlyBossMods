if GetLocale() ~= "koKR" then return end
if type(DBM_BMS_Translations) ~= "table" then DBM_BMS_Translations = {} end

local L = DBM_BMS_Translations

-- BossMod studio
L.TabCategory_BossModStudio = "보스 모드 스튜디오"
L.TabCategory_Triggers = "트리거와 이벤트"
L.AreaHead_CreateBossMod = "현재 보스모드의 메인 정보"
L.BossName = "보스 이름 - 예: '아서스'"
L.BossID = "보스 고유 ID"
L.BossLookup = "보스로 부터 ID 얻기"

L.AreaHead_Pull = "풀링 / 전투시작 탐지"
L.CombatFromYell = "전투 시작과 함께 외치기"
L.CombatAutoDetect = "자동 전투 탐지"
L.BossPullYell = "풀링할 때 보스가 말하는 것"
L.BossEnrages = "보스 광폭화"
L.BossEnrageBar = "광폭화 바 보기"
L.BossEnrageAnnounce = "공격대에 광폭화 알리기"

L.Min = "분"
L.Sec = "초"

L.AreaHead_TriggerCreate = "보스 이벤트 트리거 만들기"
L.Describe_TriggerCreate = [[보스전의 트리거와 핸들 이벤트를 제작할 수 있습니다. 당신이 만약 보스가 외치거나 혹은 보스가 사용하는 능력을 알고 싶다면, 그것을 잡아내서 사용할 수 있습니다. 예를 들어, 보스가 "Shiledwall"의 능력을 얻었을 경우 당신이 해당 능력의 바를 시작하고 싶다면, 단순하게 이벤트에 대한 이름에 "Shieldwall"이라고 쓰고 이것이 보스버프 또는 디버프인지 선택해야합니다.]]

L.Trigger_Typ = "이벤트 발생 조건"
L.Trigger_Name = "현재 이벤트의 이름 (설명)"
L.Trigger_Typ_Spell = "주문 또는 스타일"
L.Trigger_Typ_Buff = "버프 또는 디버프"
L.Trigger_Typ_Yell = "외치기 또는 감정표현"
L.Trigger_Typ_Time = "시간 기본"
L.Trigger_Typ_Hp = "체력 기본"
L.Trigger_Create_Bttn = "이벤트 만들기"
L.Trigger_Delete_Bttn = "이벤트 삭제"

L.EventYellText = "외치기/말하기/감정표현이 나올때의 이벤트"
L.EventTimeBased = "몇 초 후의 이벤트"
L.EventHpBased = "이벤트 발생 시작 체력 몇 %"
L.EventSpellID = "스펠 ID"
L.EventAnnounce = "알리기"
L.EventAnnounceText = "메세지 알리기"
L.EventSpecialWarn = "특수 경고 보기"
L.EventSpecialWarn_OnlyMe = "자신에게 영향을 미치는 경우만"
L.EventStartBar = "타이머 바 시작"
L.EventWarnEnd = "타이머가 종료하기 전에 경고 표시"
L.EventWarnMsg = "경고 메세지"
L.EventSetIcon = "타겟에게 아이콘 설정 (외치기 %t의 글이 나올 경우)"


