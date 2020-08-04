if GetLocale() ~= "koKR" then return end
if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

L.HOW_TO_USE_MOD					= L.DBM .. "을 사용해 주셔서 감사합니다. 대화창에서 /dbm help를 입력하면 사용 가능한 명령어 목록을 볼 수 있습니다. 설정을 하시려면 /dbm을 입력하세요. 보스 알림 설정을 기호에 맞게 변경하려면 원하는 던전을 직접 선택해서 로딩을 클릭하세요. " .. L.DBM .. "이 당신의 현재 전문화에 맞는 기본값을 설정하지만 일부 옵션은 자신에게 맞게 조정해야 할 수도 있습니다."
L.SILENT_REMINDER					= "알림: " .. L.DBM .. "이 아직 조용함 모드입니다."

L.LOAD_MOD_ERROR				= "%s 보스 모드 로딩중 오류 발생: %s"
L.LOAD_MOD_SUCCESS			= "'%s' 모드가 로딩됐습니다. 사용자 지정 경고 효과음을 설정하거나 개인적으로 메모를 적어놓고 싶다면 /dbm을 입력하세요."
L.LOAD_MOD_COMBAT			= "전투가 종료될 때까지 %s|1을;를; 로딩하지 않습니다."
L.LOAD_GUI_ERROR				= "GUI를 로딩할 수 없음: %s"
L.LOAD_GUI_COMBAT			= "전투중에는 GUI의 최초 로딩을 할 수 없습니다. 전투가 종료되면 GUI가 로딩됩니다. GUI가 로딩된 다음부턴 전투중에도 GUI를 열 수 있습니다."
L.BAD_LOAD					= L.DBM .. "이 전투로 인해 현재 인스턴스의 모드를 완전히 로딩하지 못했습니다. 전투가 종료된 후 가능한 빨리 /console reloadui 명령어를 입력해주세요."
L.LOAD_MOD_VER_MISMATCH		= "DBM-Core가 로딩 조건과 맞지 않아 %s|1을;를; 로딩하지 못했습니다. 최신 버전을 설치하세요"
L.LOAD_MOD_EXP_MISMATCH		= "아직 출시되지 않은 WoW 확장팩용으로 설계되었으므로 %s|1을;를; 로딩하지 못했습니다. 확장팩이 출시되면 해당 모드는 자동으로 작동합니다."
L.LOAD_MOD_TOC_MISMATCH		= "아직 나오지 않은 WoW 패치 (%2$s) 용으로 설계되었으므로 %1$s|1을;를; 로딩하지 못했습니다. 패치가 나오면 해당 모드는 자동으로 작동합니다."
L.LOAD_MOD_DISABLED			= "%s|1이;가; 설치는 돼있지만 켜져있질 않습니다. 직접 켜기 전까진 모드가 로딩되지 않습니다."
L.LOAD_MOD_DISABLED_PLURAL	= "%s|1이;가; 설치는 돼있지만 켜져있질 않습니다. 직접 켜기 전까진 모드들이 로딩되지 않습니다."

L.COPY_URL_DIALOG					= "URL 복사"

--Post Patch 7.1
L.NO_RANGE					= "거리 레이더를 인스턴스 던전에서 사용할 수 없습니다. 예전의 텍스트 방식 거리창으로 대체됩니다."
L.NO_ARROW					= "화살표 기능을 인스턴스 던전에서 사용할 수 없습니다"
L.NO_HUD						= "HUD 기능을 인스턴스 던전에서 사용할 수 없습니다"

L.DYNAMIC_DIFFICULTY_CLUMP	= "현재 공격대 규모에 맞는 필요한 플레이어 숫자 관련 정보가 부족하여" .. L.DBM .. "이 이 전투에서 동적 거리창을 비활성화 했습니다."
L.DYNAMIC_ADD_COUNT			= "현재 공격대 규모에 맞는 쫄 등장 정보가 부족하여" .. L.DBM .. "이 이 전투에서 쫄 마릿수 정보를 비활성화 했습니다."
L.DYNAMIC_MULTIPLE			= "현재 공격대 규모에 맞는 보스 기술 작동 원리 정보가 부족하여" .. L.DBM .. "이 이 전투에서 다수의 기능을 비활성화 했습니다."

L.LOOT_SPEC_REMINDER			= "현재 전문화는 %s입니다. 현재 지정한 전리품 획득 전문화는 %s입니다."

L.BIGWIGS_ICON_CONFLICT		= L.DBM .. "이 BigWigs와" .. L.DBM .. " 모두 공격대 징표 기능을 사용하고 있음을 감지했습니다. 충돌을 방지하기 위해 공대장이 두 애드온중 하나의 징표 설정을 비활성화해야 합니다."

L.MOD_AVAILABLE				= "이 지역에서 %s|1을;를; 사용할 수 있습니다. Curse/Twitch 또는 WoWI에서 다운로드 받으실 수 있습니다."

L.COMBAT_STARTED				= "%s 전투 시작. 행운을 빕니다! :)";
L.COMBAT_STARTED_IN_PROGRESS	= "%s 전투 진행 도중 참가했습니다. 행운을 빕니다! :)"
L.GUILD_COMBAT_STARTED		= "길드가 %s 전투를 시작했습니다."
L.SCENARIO_STARTED			= "%s 시작. 행운을 빕니다! :)";
L.SCENARIO_STARTED_IN_PROGRESS	= "%s 시나리오 진행 도중 참가하였습니다. 행운을 빕니다! :)"
L.BOSS_DOWN					= "%s|1이;가; %s만에 쓰러졌습니다!"
L.BOSS_DOWN_I				= "%s|1이;가; 쓰러졌습니다! 총 %d회 승리했습니다."
L.BOSS_DOWN_L				= "%s|1이;가; %s만에 쓰러졌습니다! 지난번 처치 기록은 %s, 가장 빠른 기록은 %s 입니다. 총 %d회 승리했습니다."
L.BOSS_DOWN_NR				= "%s|1이;가; %s만에 쓰러졌습니다! 신기록입니다! (이전 기록은 %s) 총 %d회 승리했습니다."
L.RAID_DOWN					= "%s|1을;를; %s만에 모두 끝냈습니다!"
L.RAID_DOWN_L				= "%s|1을;를; %s만에 모두 끝냈습니다! 가장 빠른 완료 기록은 %s 입니다."
L.RAID_DOWN_NR				= "%s|1을;를; %s만에 모두 끝냈습니다! 신기록입니다! (이전 기록은 %s)"
L.GUILD_BOSS_DOWN			= "길드가 %s|1을;를; %s만에 물리쳤습니다!"
L.SCENARIO_COMPLETE			= "%s|1을;를; %s만에 완료했습니다!"
L.SCENARIO_COMPLETE_I		= "%s|1을;를; 완료했습니다! 총 %d회 완료했습니다."
L.SCENARIO_COMPLETE_L		= "%s|1을;를; %s만에 완료했습니다! 지난번 완료 기록은 %s, 가장 빠른 기록은 %s 입니다. 총 %d회 완료했습니다."
L.SCENARIO_COMPLETE_NR		= "%s|1을;를; %s만에 완료했습니다! 신기록입니다! (이전 기록은 %s) 총 %d회 완료했습니다."
L.COMBAT_ENDED_AT			= "%s (%s) 전투에서 %s만에 전멸했습니다."
L.COMBAT_ENDED_AT_LONG		= "%s (%s) 전투에서 %s만에 전멸했습니다. 현재 난이도에서 총 %d회 전멸했습니다."
L.GUILD_COMBAT_ENDED_AT		= "길드가 %s (%s)에서 %s만에 전멸했습니다."
L.SCENARIO_ENDED_AT			= "%s|1이;가; %s만에 끝났습니다."
L.SCENARIO_ENDED_AT_LONG		= "%s|1이;가; %s만에 끝났습니다. 현재 난이도에서 총 %d회 실패했습니다."
L.COMBAT_STATE_RECOVERED		= "%s 전투가 %s전에 시작됐습니다. 타이머 복구중..."
L.TRANSCRIPTOR_LOG_START		= "Transcriptor 기록이 시작됐습니다."
L.TRANSCRIPTOR_LOG_END		= "Transcriptor 기록이 종료됐습니다."

L.MOVIE_SKIPPED				= L.DBM .. "이 동영상 자동 생략 기능을 작동시켰습니다."
L.BONUS_SKIPPED				= L.DBM .. "이 자동으로 추가 전리품 주사위 굴림 창을 닫았습니다. 창을 열고 싶으면 3분 안에 /dbmbonusroll 명령어를 입력하세요"
L.BONUS_EXPIRED				= "/dbmbonusroll 명령어를 사용해 추가 전리품 주사위 굴림 창을 열려고 했으나 현재 굴릴 수 있는 추가 전리품 주사위가 없습니다."

L.AFK_WARNING				= "자리 비움 상태에서 전투에 돌입하여 (남은 생명력 %d퍼센트) 경고음을 재생중입니다. 자리를 비우고 있는게 아니라면 자리 비움 상태를 해제하거나 '기타 기능' 항목에서 해당 설정을 비활성화 해주세요."

L.COMBAT_STARTED_AI_TIMER	= "내 CPU는 신경망 프로세서. 기계학습형 컴퓨터 (이 전투에선 새로운 타이머 인공지능 기능을 사용해서 예상 타이머 바를 생성합니다)"

L.PROFILE_NOT_FOUND			= "<" .. L.DBM .. "> 현재 설정된 프로필이 손상되었습니다. " .. L.DBM .. "이 'Default' 프로필을 로딩할 것입니다."
L.PROFILE_CREATED			= "'%s' 프로필을 생성했습니다."
L.PROFILE_CREATE_ERROR		= "프로필 생성 실패. 프로필 이름이 올바르지 않습니다."
L.PROFILE_CREATE_ERROR_D		= "프로필 생성 실패. '%s' 프로필이 이미 존재합니다."
L.PROFILE_APPLIED			= "'%s' 프로필을 적용했습니다."
L.PROFILE_APPLY_ERROR		= "프로필 적용 실패. %s 프로필이 존재하지 않습니다."
L.PROFILE_COPIED				= "'%s' 프로필을 복사했습니다."
L.PROFILE_COPY_ERROR			= "프로필 복사 실패. %s 프로필이 존재하지 않습니다."
L.PROFILE_COPY_ERROR_SELF	= "동일한 프로필로는 복사할 수 없습니다."
L.PROFILE_DELETED			= "'%s' 프로필을 삭제했습니다. 'Default' 프로필이 적용됩니다."
L.PROFILE_DELETE_ERROR		= "프로필 삭제 실패. '%s' 프로필이 존재하지 않습니다."
L.PROFILE_CANNOT_DELETE		= "'Default' 프로필은 삭제할 수 없습니다."
L.MPROFILE_COPY_SUCCESS		= "%s의 (%d 전문화) 모드 설정이 복사됐습니다."
L.MPROFILE_COPY_SELF_ERROR	= "캐릭터 설정은 자기 자신에게 복사할 수 없습니다."
L.MPROFILE_COPY_S_ERROR		= "원본이 손상되었습니다. 설정이 복사되지 않거나 일부만 복사됐습니다. 복사에 실패했습니다."
L.MPROFILE_COPYS_SUCCESS		= "%s의 (%d 전문화) 모드의 효과음 또는 메모가 복사됐습니다."
L.MPROFILE_COPYS_SELF_ERROR	= "캐릭터의 사용자 지정 효과음 또는 메모는 자기 자신에게 복사할 수 없습니다."
L.MPROFILE_COPYS_S_ERROR		= "원본이 손상되었습니다. 효과음과 메모가 복사되지 않거나 일부만 복사됐습니다. 복사에 실패했습니다."
L.MPROFILE_DELETE_SUCCESS	= "%s의 (%d 전문화) 모드를 삭제했습니다."
L.MPROFILE_DELETE_SELF_ERROR	= "사용중에는 모드를 삭제할 수 없습니다."
L.MPROFILE_DELETE_S_ERROR	= "원본이 손상되었습니다. 설정이 삭제되지 않거나 일부만 삭제됩니다. 삭제에 실패했습니다."

L.NOTE_SHARE_SUCCESS			= "%s|1이;가; %s에 대한 메모를 공유했습니다."
L.NOTE_SHARE_FAIL			= "%s|1이;가; %s에 대한 메모 공유를 시도했습니다. 하지만 해당 보스 스킬에 관련된 모드를 설치하지 않았거나 로딩하지 않은 상태입니다. 이 메모가 필요하다면 해당 모드를 로딩했는지 확인 후 공유를 다시 요청하세요."

L.NOTEHEADER					= "%s에 대한 메모를 여기에 입력하세요. 캐릭터명을 >< 로 감싸면 직업 색상으로 표시됩니다. 여러번 경고가 필요한 경우 '/'로 메모를 구분해서 작성하세요."
L.NOTEFOOTER					= "설정을 변경하려면 '확인', 변경을 취소하려면 '취소' 버튼을 누르세요."
L.NOTESHAREDHEADER			= "%s|1이;가; %s에 대해 아래의 메모를 공유했습니다. 수락할 경우 이미 존재하는 메모를 덮어쓰게 됩니다."
L.NOTESHARED					= "메모를 공격대 또는 파티에 전송했습니다."
L.NOTESHAREERRORSOLO			= "외로우세요? 자기 자신에게는 메모를 보낼 수 없습니다."
L.NOTESHAREERRORBLANK		= "빈 메모는 공유할 수 없습니다."
L.NOTESHAREERRORGROUPFINDER	= "전장, 공격대 찾기, 파티 찾기에서는 메모를 공유할 수 없습니다."
L.NOTESHAREERRORALREADYOPEN	= "메모 편집기가 이미 열려 있는 동안에는 편집중인 메모 손실을 방지하기 위해 공유된 메모 링크를 열 수 없습니다."

L.ALLMOD_DEFAULT_LOADED		= "이 인스턴스에 속한 모든 모드의 기본 설정이 로딩됐습니다."
L.ALLMOD_STATS_RESETED		= "모든 모드 통계가 초기화 되었습니다."
L.MOD_DEFAULT_LOADED			= "이 전투의 기본 설정이 로딩됐습니다."
L.SOUNDKIT_MIGRATION			= "한개 이상의 알림/특수 알림 효과음이 호환되지 않는 미디어 형식이거나 파일 경로가 잘못되는 등의 문제로 인해 기본값으로 초기화 되었습니다. " .. L.DBM .. "은 현재 애드온 폴더 내에 있는 효과음 파일이나 미디어 재생에 쓰이는 SoundKit ID만 지원하고 있습니다."

L.WORLDBOSS_ENGAGED			= "당신이 속한 서버에서 %s 전투가 %s 퍼센트의 체력으로 시작된 것 같습니다. (%s|1이;가; 전송)"
L.WORLDBOSS_DEFEATED			= "당신이 속한 서버에서 %s|1이;가; 잡힌 것 같습니다. (%s|1이;가; 전송)"

L.TIMER_FORMAT_SECS			= "%.2f초"
L.TIMER_FORMAT_MINS			= "%d분"
L.TIMER_FORMAT				= "%d분 %.2f초"

L.MIN						= "분"
L.MIN_FMT					= "%d분"
L.SEC						= "초"
L.SEC_FMT					= "%s초"

L.GENERIC_WARNING_OTHERS		= "외 1명"
L.GENERIC_WARNING_OTHERS2	= "외 %d명"
L.GENERIC_WARNING_BERSERK	= "%s%s 후 광폭화"
L.GENERIC_TIMER_BERSERK		= "광폭화"
L.OPTION_TIMER_BERSERK		= "$spell:26662 타이머 바 보기"
L.GENERIC_TIMER_COMBAT		= "전투 시작"
L.OPTION_TIMER_COMBAT		= "전투 시작 타이머 바 보기"
L.BAD						= "바닥"

L.OPTION_CATEGORY_TIMERS		= "바"
L.OPTION_CATEGORY_WARNINGS	= "일반 알림"
L.OPTION_CATEGORY_WARNINGS_YOU	= "개인 알림"
L.OPTION_CATEGORY_WARNINGS_OTHER	= "대상 관련 알림"
L.OPTION_CATEGORY_WARNINGS_ROLE	= "역할 관련 알림"

L.OPTION_CATEGORY_SOUNDS		= "음성"
--Sub cats for "announce" object
L.OPTION_CATEGORY_DROPDOWNS		= "드롭다운 옵션"
L.OPTION_CATEGORY_YELLS			= "말풍선"
L.OPTION_CATEGORY_NAMEPLATES		= "이름표"
L.OPTION_CATEGORY_ICONS			= "공격대 징표"

L.AUTO_RESPONDED						= "귓속말에 자동응답 메시지를 보냈습니다."
L.STATUS_WHISPER						= "%s: %s, %d/%d 생존"
--Bosses
L.AUTO_RESPOND_WHISPER				= "%s님은 %s 전투 때문에 바쁩니다. (%s, %d/%d 생존)"
L.WHISPER_COMBAT_END_KILL			= "%s님이 %s 전투에서 승리했습니다!"
L.WHISPER_COMBAT_END_KILL_STATS		= "%s님이 %s 전투에서 승리했습니다! 총 %d회 승리했습니다."
L.WHISPER_COMBAT_END_WIPE_AT			= "%s님이 %s %s에서 전멸했습니다."
L.WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s님이 %s %s에서 전멸했습니다. 이 난이도에서 총 %d회 전멸했습니다."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
L.AUTO_RESPOND_WHISPER_SCENARIO		= "%s님이 %s 시나리오를 진행중입니다. (%d/%d 생존)"
L.WHISPER_SCENARIO_END_KILL			= "%s님이 %s 시나리오를 완료했습니다!"
L.WHISPER_SCENARIO_END_KILL_STATS	= "%s님이 %s 시나리오를 완료했습니다! 이 난이도를 %d회 완료했습니다!"
L.WHISPER_SCENARIO_END_WIPE			= "%s님이 %s 시나리오를 완료하지 못했습니다."
L.WHISPER_SCENARIO_END_WIPE_STATS	= "%s님이 %s 시나리오를 완료하지 못했습니다. 이 난이도를 총 %d회 실패했습니다."

L.VERSIONCHECK_HEADER		= "보스 모드 - 버전"
L.VERSIONCHECK_ENTRY_NO_DBM	= "%s: 설치된 보스 모드 없음"
L.VERSIONCHECK_FOOTER		= L.DBM .. "을 설치한 플레이어 %d명과 Bigwigs를 설치한 플레이어 %d명을 발견했습니다."
L.VERSIONCHECK_OUTDATED		= "다음 %d명의 플레이어가 구버전 보스 모드를 사용중: %s"
L.YOUR_VERSION_OUTDATED      = "사용중인 " .. L.DEADLY_BOSS_MODS .. " 버전이 사용 기한을 지났습니다. Curse/Twitch, WoWI 또는 GitHub 릴리즈 페이지에서 최신 버전을 받으세요."
L.VOICE_PACK_OUTDATED		= "선택한 " .. L.DBM .. " 음성팩에 일부 음성이 들어있지 않습니다. 몇가지 경고 음성이 기본 효과음으로 재생됩니다. 최신 음성팩을 다운로드 받거나 제작자에게 누락된 음성 파일 업데이트를 요청하시기 바랍니다"
L.VOICE_MISSING				= "선택한 " .. L.DBM .. " 음성팩을 찾을 수 없습니다. 오류일 경우 음성팩이 제대로 설치되어 있고 애드온 목록에서 활성화되어 있는지 확인해 보시기 바랍니다."
L.VOICE_DISABLED				= "현재 " .. L.DBM .. " 음성팩이 한 개 이상 설치되어 있지만 사용하고 있는게 없습니다. 음성팩을 사용하려면 '음성 경고' 항목에서 음성팩이 지정되어 있는지 확인하세요. 음성팩을 사용할 의사가 없으면 음성팩을 삭제하시면 이 메시지는 더이상 출력되지 않습니다"
L.VOICE_COUNT_MISSING		= "초읽기 음성 %d번으로 설정된 음성/초읽기 팩을 찾을 수 없습니다. 기본 설정으로 초기화 되었습니다: %s"

L.UPDATEREMINDER_HEADER			= "사용중인 " .. L.DEADLY_BOSS_MODS .. " 버전의 사용 기한이 지났습니다.\n Curse/Twitch, WoWI, GitHub 릴리즈 페이지 등에서 %s (%s) 버전을 다운로드 할 수 있습니다."
L.UPDATEREMINDER_HEADER_ALPHA	= "사용중인 " .. L.DEADLY_BOSS_MODS .. " ALPHA 버전의 사용 기한이 지났습니다.\n 적어도 %s 테스트 버전 이상은 사용해야 합니다. ALPHA 버전을 선택한 " .. L.DBM .. " 이용자는 최신 ALPHA 버전을 실행하는걸 권장합니다. 아니면 최신 RELEASE 버전을 사용하는 것도 좋습니다. 오래된 ALPHA 버전은 개발용인 관계로 버전 검사 기능이 제한되어 있기 때문입니다."
L.UPDATEREMINDER_FOOTER			= (IsMacClient() and "Cmd-C" or "Ctrl-C").. "를 누르면 주소를 복사할 수 있습니다."
L.UPDATEREMINDER_FOOTER_GENERIC	= (IsMacClient() and "Cmd-C" or "Ctrl-C").. "를 누르면 주소를 복사할 수 있습니다."
L.UPDATEREMINDER_DISABLE			= "경고: 지금 사용중인 " .. L.DEADLY_BOSS_MODS .. "가 지나치게 오래되어 강제로 비활성화되며 업데이트 전까진 사용할 수 없습니다. 이는 오래되고 호환되지 않는 모드가 당신과 파티/공대원의 플레이에 악영향을 미치지 않게 하기 위함입니다."
--L.UPDATEREMINDER_NODISABLE		= "경고: 설치한 " .. L.DEADLY_BOSS_MODS .. "가 사용 기한을 지났습니다. 업데이트 알림이 꺼져있거나 해서 특정 기한을 지나면 본 메시지가 등장하는 것이며 이 알림은 끌 수 없습니다. 반드시 업데이트 하시기 바랍니다."
L.UPDATEREMINDER_HOTFIX			= "지금 사용하는 " .. L.DBM .. " 버전은 이 보스 전투에서 알려진 오류를 가지고 있습니다. 이 오류는 최신 버전으로 업데이트하면 수정됩니다."
L.UPDATEREMINDER_HOTFIX_ALPHA	= "지금 사용하는 " .. L.DBM .. " 버전은 이 보스 전투에서 알려진 오류를 가지고 있습니다. 이 오류는 향후 출시될 버전 (또는 최신 ALPHA 버전)에서 수정되어있을 것입니다."
L.UPDATEREMINDER_MAJORPATCH		= "경고: 대규모 패치로 인해 " .. L.DEADLY_BOSS_MODS .. " 버전이 사용 기한이 지나 업데이트하기 전까진 " .. L.DBM .. "이 비활성화됩니다. 이는 오래되고 호환되지 않는 코드로 인해 당신과 공격대원이 조악한 플레이 경험을 겪지 않게 하기 위함입니다. 당장 deadlybossmods.com이나 Curse에서 최신 버전을 다운로드 하시기 바랍니다."
L.UPDATEREMINDER_TESTVERSION		= "경고: 현재 게임 버전과 맞지 않는 " .. L.DEADLY_BOSS_MODS .. " 버전을 사용중입니다. 게임 클라이언트에 맞는 버전을 deadlybossmods.com이나 Curse에서 다운로드 하시기 바랍니다."
L.VEM							= "경고: " .. L.DEADLY_BOSS_MODS .. "와 Voice Encounter Mods를 함께 사용중입니다. 현재 설정으로는 DBM이 작동하지 않으며 로딩도 되지 않을 것입니다."
L.OUTDATEDPROFILES				= "경고: DBM-Profiles가 이 버전의 " .. L.DBM .. "과 호환되지 않습니다. " .. L.DBM .. "이 읽기 전에 삭제해야 충돌을 방지할 수 있습니다."
L.OUTDATEDSPELLTIMERS				= "경고: DBM-SpellTimers로 인해 " .. L.DBM .. "이 작동하지 않습니다. 반드시 비활성화 해야 " .. L.DBM .. "이 정상 작동합니다."
L.OUTDATEDRLT						= "경고: DBM-RaidLeadTools가 " .. L.DBM .. "의 작동을 중단시켰습니다. DBM-RaidLeadTools는 더이상 지원되지 않기 때문에 반드시 삭제해야 " .. L.DBM .. "이 정상 작동합니다."
L.VICTORYSOUND						= "경고: DBM-VictorySound가 이 버전의 " .. L.DBM .. "과 호환되지 않습니다. 반드시 삭제해야 " .. L.DBM .. "이 정상 작동합니다."
L.DPMCORE						= "경고: Deadly PvP 모드는 더이상 개발되지 않으며 이 버전의 " .. L.DBM .. "과 호환되지 않습니다. 반드시 삭제해야 " .. L.DBM .. "이 정상 작동합니다."
L.DBMLDB							= "경고: DBM-LDB는 이제 DBM-Core에 편입되었습니다. 같이 사용해도 문제가 생기는건 아니지만 가급적 애드온 폴더에서 'DBM-LDB' 폴더를 삭제하는걸 권장합니다"
L.DBMLOOTREMINDER				= "경고: 써드파티 모드인 DBM-LootReminder가 설치되었습니다. 이 애드온은 격아 WoW 클라이언트에 더이상 호환되지 않으며 DBM이 오작동하여 풀링 타이머를 전송하지 못하게 될 수 있습니다. 애드온 삭제를 권장합니다"
L.UPDATE_REQUIRES_RELAUNCH		= "경고: 지금 업데이트한 " .. L.DBM .. "은 게임 클라이언트를 완전히 재시작하기 전까진 정상 작동하지 않습니다. 이 업데이트엔 새 파일이 포함되어 있거나 UI 재시작으로는 로딩할 수 없는 .toc 파일의 변경 사항이 있습니다. 클라이언트 재시작 없이 사용할 경우 오류가 발생하거나 작동하지 않을 수 있습니다."
L.OUT_OF_DATE_NAG				= "현재 사용중인 " .. L.DEADLY_BOSS_MODS .. " 버전이 오래되었습니다. 업데이트를 해야 이 전투의 중요한 알림이나 타이머 그리고 공격대원 모두가 보는 외침 등이 빠지지 않게 나옵니다."
L.RETAIL_ONLY					= "경고: 이 " .. L.DBM .. " 버전은 월드 오브 워크래프트 최신 버전용입니다. 삭제하시고 클래식 WoW 전용 DBM을 설치하세요."

L.MOVABLE_BAR				= "드래그 하세요!"

L.PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h님이 당신에게 " .. L.DBM .. " 타이머를 전송했습니다"
L.PIZZA_CONFIRM_IGNORE			= "정말 %s의 " .. L.DBM .. " 타이머를 차단하시겠습니까? 이 공격대에 있는 동안에만 적용됩니다."
L.PIZZA_ERROR_USAGE				= "사용법: /dbm [broadcast] timer <시간> <텍스트>. <시간>은 3초 이상이어야 합니다."

L.MINIMAP_TOOLTIP_FOOTER		= "쉬프트 누르고 드래그로 이동"

L.RANGECHECK_HEADER			= "탐지 거리 (%dm)"
L.RANGECHECK_HEADERT			= "탐지 거리 (%dm-%d명)"
L.RANGECHECK_RHEADER			= "반전-탐지 거리 (%dm)"
L.RANGECHECK_RHEADERT		= "반전-탐지 거리 (%dm-%d명)"
L.RANGECHECK_SETRANGE		= "거리 설정"
L.RANGECHECK_SETTHRESHOLD	= "탐지할 최소 플레이어 수 설정"
L.RANGECHECK_SOUNDS			= "효과음"
L.RANGECHECK_SOUND_OPTION_1	= "거리 내에 플레이어가 1명 있을 경우 재생"
L.RANGECHECK_SOUND_OPTION_2	= "거리 내에 플레이어가 2명 이상 있을 경우 재생"
L.RANGECHECK_SOUND_0			= "효과음 없음"
L.RANGECHECK_SOUND_1			= "기본 효과음"
L.RANGECHECK_SOUND_2			= "짜증나는 효과음"
L.RANGECHECK_SETRANGE_TO		= "%dm"
L.RANGECHECK_OPTION_FRAMES	= "창 종류"
L.RANGECHECK_OPTION_RADAR	= "레이더 창 표시"
L.RANGECHECK_OPTION_TEXT		= "텍스트 창 표시"
L.RANGECHECK_OPTION_BOTH		= "모두 표시"
L.RANGERADAR_HEADER			= "거리:%d, 플레이어:%d"
L.RANGERADAR_RHEADER			= "반전-거리:%d 플레이어:%d"
L.RANGERADAR_IN_RANGE_TEXT	= "거리 내 %d명 (%0.1fm)"
L.RANGECHECK_IN_RANGE_TEXT	= "거리 내 %d명"--Text based doesn't need (%dyd), especially since it's not very accurate to the specific yard anyways
L.RANGERADAR_IN_RANGE_TEXTONE	= "%s (%0.1fm)"--One target

L.INFOFRAME_SHOW_SELF		= "내 자원 항상 보기"		-- Always show your own power value even if you are below the threshold
L.INFOFRAME_SETLINES			= "최대 줄 갯수 지정"
	L.INFOFRAME_SETCOLS		= "최대 열 갯수 지정"
L.INFOFRAME_LINESDEFAULT		= "모드 기본값"
L.INFOFRAME_LINES_TO			= "줄 %d개"
L.INFOFRAME_COLS_TO			= "열 %d개"
L.INFOFRAME_POWER			= "기력"
L.INFOFRAME_AGGRO			= "어그로"
L.INFOFRAME_MAIN			= "주 자원:"--Main power
L.INFOFRAME_ALT				= "보조 자원:"--Alternate Power

L.LFG_INVITE						= "파티찾기 입장"

L.SLASHCMD_HELP				= {
	"사용 가능 슬래시 명령어:",
	"----------------",
	"/dbm unlock: 움직일 수 있는 상태 바 타이머를 표시합니다. (단축 명령어: move)",
	"/range <숫자> 또는 /distance <숫자>: 거리 창을 표시합니다. /rrange 또는 /rdistance는 색상을 반대로 표시합니다.",
	"/hudar <number>: HUD 기반 거리 탐지기를 표시합니다.",
	"/dbm timer: 사용자 지정 " .. L.DBM .. " 타이머를 시작합니다. 자세한 내용은 '/dbm timer'를 참고하세요.",
	"/dbm arrow: " .. L.DBM .. " 화살표를 표시합니다. 자세한 내용은 '/dbm arrow help'를 참고하세요.",
	"/dbm hud: " .. L.DBM .. " HUD를 표시합니다. 자세한 내용은 '/dbm hud'를 참고하세요.",
	"/dbm help2: 공격대 관리와 관련된 슬래시 명령어를 표시합니다."
}
L.SLASHCMD_HELP2				= {
	"사용 가능 슬래시 명령어:",
	"----------------",
	"/dbm pull <초>: 공격대에 <초> 만큼 풀링 타이머를 전송합니다. (승급 권한이 필요합니다. 단축 명령어: pull)",
	"/dbm break <분>: 공격대에 <분> 만큼 지속되는 휴식 타이머를 전송합니다. (승급 권한이 필요합니다. 단축 명령어: break)",
	"/dbm version: 공대원의 보스 모드 버전 검사를 실시합니다. (단축 명령어: ver)",
	"/dbm version2: 공대원 보스 모드 버전 검사 및 구버전 사용자에게 귓속말을 보냅니다. (단축 명령어: ver2)",
	"/dbm lockout: 공대원에게 공격대 귀속 정보를 수집합니다. (단축 명령어: lockouts, ids) (승급 권한 필요)",
	"/dbm lag: 공격대 지연시간 검사 작업을 실행합니다.",
	"/dbm durability: 공대원의 내구도 검사를 실시합니다."
}
L.TIMER_USAGE	= {
	L.DBM .. " 타이머 명령어:",
	"--------------",
	"/dbm timer <초> <텍스트>: <초> 만큼 지속되는 <텍스트> 타이머가 시작됩니다.",
	"/dbm ltimer <초> <텍스트>: 취소하기 전까진 자동 반복되는 타이머가 시작됩니다.",
	"(공대장이나 승급자일 경우 타이머 텍스트 앞에 'Broadcast'를 입력하면 공격대에 공유)",
	"/dbm timer endloop: ltimer와 반복 작동을 멈춥니다."
}

L.ERROR_NO_PERMISSION				= "이 명령어를 실행하기 위한 권한을 가지고 있지 않습니다."

--Common Locals
L.NEXT						= "다음 %s"
L.COOLDOWN					= "%s 쿨타임"
L.UNKNOWN					= "알 수 없음"--UNKNOWN
L.LEFT						= "왼쪽"
L.RIGHT						= "오른쪽"
L.BOTH						= "양쪽"
L.BEHIND					= "뒤쪽"
L.BACK						= "뒤쪽"--BACK
L.SIDE						= "옆쪽"
L.TOP						= "위쪽"
L.BOTTOM					= "아래쪽"
L.MIDDLE					= "가운데"
L.FRONT						= "앞쪽"
L.EAST						= "동쪽"
L.WEST						= "서쪽"
L.NORTH						= "북쪽"
L.SOUTH						= "남쪽"
L.INTERMISSION				= "사잇 단계"
L.ORB						= "구슬"
L.ORBS						= "구슬"
L.CHEST						= "상자"--As in Treasure 'Chest'. Not Chest as in body part.
L.NO_DEBUFF					= "%s 없음"--For use in places like info frame where you put "Not Spellname"
L.ALLY						= "공대원"--Such as "Move to Ally"
L.ADD						= "쫄"--A fight Add as in "boss spawned extra adds"
L.ADDS						= "쫄"
L.BIG_ADD					= "큰 쫄"
L.BOSS						= "보스"
L.ROOM_EDGE					= "구석"
L.FAR_AWAY					= "먼 곳"
L.BREAK_LOS					= "시야를 가리는 곳"
L.RESTORE_LOS				= "시야가 나오는 곳"
L.SAFE						= "안전함"
L.NOTSAFE					= "위험함"
L.SHIELD					= "보호막"
L.PILLAR					= "기둥"
L.INCOMING					= "%s 등장"
L.BOSSTOGETHER				= "보스 붙이세요"
L.BOSSAPART					= "보스 떨어트리세요"
--Common Locals end

L.BREAK_USAGE				= "쉬는 시간은 60분을 초과할 수 없습니다. 쉬는 시간은 초단위가 아니라 분단위로 입력해야 합니다."
L.BREAK_START				= "쉬는 시간 시작 -- %s 받았습니다! (%s|1이;가; 전송)"
L.BREAK_MIN					= "%s분 후 쉬는 시간이 끝납니다!"
L.BREAK_SEC					= "%s초 후 쉬는 시간이 끝납니다!"
L.TIMER_BREAK				= "쉬는 시간!"
L.ANNOUNCE_BREAK_OVER		= "쉬는 시간이 %s에 끝났습니다"

L.TIMER_PULL					= "풀링"
L.ANNOUNCE_PULL				= "%d초 후 풀링합니다. (%s|1이;가; 전송)"
L.ANNOUNCE_PULL_NOW			= "풀링 시작!"
L.ANNOUNCE_PULL_TARGET		= "%s|1을;를; %d초 후 풀링합니다. (%s|1이;가; 전송)"
L.ANNOUNCE_PULL_NOW_TARGET	= "%s 풀링 시작!"
L.GEAR_WARNING				= "경고: 장비를 확인하세요. 착용 아이템 레벨이 보유 아이템 레벨보다 %d 낮습니다."
L.GEAR_WARNING_WEAPON		= "경고: 주 장비가 제대로 장착되어 있는지 확인하세요."
L.GEAR_FISHING_POLE			= "낚싯대"

L.ACHIEVEMENT_TIMER_SPEED_KILL = "업적"--BATTLE_PET_SOURCE_6

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS.you			= "당신에게 %s"
L.AUTO_ANNOUNCE_TEXTS.target			= "%s: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetsource	= ">%%s<의 %s 시전: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s): >%%s<"
L.AUTO_ANNOUNCE_TEXTS.ends			= "%s 종료"
L.AUTO_ANNOUNCE_TEXTS.endtarget		= "%s 종료: >%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades			= "%s 사라짐"
L.AUTO_ANNOUNCE_TEXTS.adds			= "%s 남은 수: %%d"
L.AUTO_ANNOUNCE_TEXTS.cast			= "%s 시전: %.1f초"
L.AUTO_ANNOUNCE_TEXTS.soon			= "곧 %s"
L.AUTO_ANNOUNCE_TEXTS.sooncount		= "곧 %s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.countdown		= "%s %%d초 전"
L.AUTO_ANNOUNCE_TEXTS.prewarn		= "%2$s 후 %1$s"
L.AUTO_ANNOUNCE_TEXTS.bait		= "곧 %s - 위치 유도"
L.AUTO_ANNOUNCE_TEXTS.stage			= "%s단계"
L.AUTO_ANNOUNCE_TEXTS.prestage		= "곧 %s단계"
L.AUTO_ANNOUNCE_TEXTS.stack			= "%s: >%%s< (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto		= "%s - >%%s<|1으로;로; 이동"

local prewarnOption = "$spell:%s 사전 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.you			= "당신이 $spell:%s 대상이 된 경우 알림 보기"
L.AUTO_ANNOUNCE_OPTIONS.target		= "$spell:%s 대상 알림"
L.AUTO_ANNOUNCE_OPTIONS.targetNF		= "$spell:%s 대상 알림 (전역 대상 필터 무시)"
L.AUTO_ANNOUNCE_OPTIONS.targetsource	= "$spell:%s 대상 알림 (시전자 포함)"
L.AUTO_ANNOUNCE_OPTIONS.targetcount	= "$spell:%s 대상 알림 (횟수 포함)"
L.AUTO_ANNOUNCE_OPTIONS.spell		= "$spell:%s 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.ends			= "$spell:%s 종료시 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.endtarget	= "$spell:%s 종료시 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.fades		= "$spell:%s|1이;가; 사라졌을 때 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.adds			= "$spell:%s의 남은 수 알림 보기"
L.AUTO_ANNOUNCE_OPTIONS.cast			= "$spell:%s 시전시 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.soon		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.sooncount	= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.countdown	= "$spell:%s의 초읽기 사전 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
L.AUTO_ANNOUNCE_OPTIONS.bait		= "$spell:%s 사전 경고 보기 (위치 유도)"
L.AUTO_ANNOUNCE_OPTIONS.stage		= "%s단계 알림"
L.AUTO_ANNOUNCE_OPTIONS.stagechange	= "단계 전환 알림"
L.AUTO_ANNOUNCE_OPTIONS.prestage		= "%s단계로 넘어가기 전 경고 보기"
L.AUTO_ANNOUNCE_OPTIONS.count		= "$spell:%s 경고 보기 (횟수 포함)"
L.AUTO_ANNOUNCE_OPTIONS.stack		= "$spell:%s 중첩 알림"
L.AUTO_ANNOUNCE_OPTIONS.moveto		= "$spell:%s에 특정인 또는 특정 위치로 이동 경고 보기"

L.AUTO_SPEC_WARN_TEXTS.ends		= "%s 종료!"
L.AUTO_SPEC_WARN_TEXTS.fades		= "%s 사라짐!"
L.AUTO_SPEC_WARN_TEXTS.soon		= "곧 %s"
L.AUTO_SPEC_WARN_TEXTS.sooncount		= "곧 %s (%%s)"
L.AUTO_SPEC_WARN_TEXTS.bait		= "곧 %s - 위치 유도"
L.AUTO_SPEC_WARN_TEXTS.prewarn		= "%2$s 후 %1$s"
L.AUTO_SPEC_WARN_TEXTS.dispel		= "%s: >%%s< - 해제"
L.AUTO_SPEC_WARN_TEXTS.interrupt		= "%s - >%%s< 차단!"
L.AUTO_SPEC_WARN_TEXTS.interruptcount = "%s - >%%s< 차단! (%%d번)"
L.AUTO_SPEC_WARN_TEXTS.you		= "%s: 당신"
L.AUTO_SPEC_WARN_TEXTS.youcount		= "%s (%%s): 당신"
L.AUTO_SPEC_WARN_TEXTS.youpos		= "%s (위치: %%s): 당신"
L.AUTO_SPEC_WARN_TEXTS.soakpos		= "%s (뭉칠 위치: %%s)"
L.AUTO_SPEC_WARN_TEXTS.target		= "%s: >%%s<"
L.AUTO_SPEC_WARN_TEXTS.targetcount	= "%s (%%s): >%%s< "
L.AUTO_SPEC_WARN_TEXTS.defensive		= "%s - 생존기 켜세요"
L.AUTO_SPEC_WARN_TEXTS.taunt		= "%s: >%%s< - 지금 도발"
L.AUTO_SPEC_WARN_TEXTS.close		= "근처의 >%%2$s<에게 %1$s"
L.AUTO_SPEC_WARN_TEXTS.move		= "%s - 피하세요"
L.AUTO_SPEC_WARN_TEXTS.keepmove		= "%s - 계속 이동"
L.AUTO_SPEC_WARN_TEXTS.stopmove		= "%s - 이동 금지"
L.AUTO_SPEC_WARN_TEXTS.dodge		= "%s - 피하세요"
L.AUTO_SPEC_WARN_TEXTS.dodgecount	= "%s (%%s) - 피하세요"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc		= "%s - %%s|1으로;로; 피하세요"
L.AUTO_SPEC_WARN_TEXTS.moveaway		= "%s - 거리 이격"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount	= "%s (%%s) - 밖으로 나오세요"
L.AUTO_SPEC_WARN_TEXTS.moveto		= "%s - >%%s<|1으로;로; 이동"
L.AUTO_SPEC_WARN_TEXTS.soak		= "%s - 맞으세요"
L.AUTO_SPEC_WARN_TEXTS.jump		= "%s - 점프"
L.AUTO_SPEC_WARN_TEXTS.run		= "%s - 도망치세요"
L.AUTO_SPEC_WARN_TEXTS.cast		= "%s - 주문 시전 중지"
L.AUTO_SPEC_WARN_TEXTS.lookaway		= "%%2$s에게 %1$s - 고개 돌리세요"
L.AUTO_SPEC_WARN_TEXTS.reflect		= "%s: >%%s< - 공격 중지"
L.AUTO_SPEC_WARN_TEXTS.stack		= "당신에게 %s (%%d중첩)"
L.AUTO_SPEC_WARN_TEXTS.switch		= "%s - 대상 바꾸세요"
L.AUTO_SPEC_WARN_TEXTS.switchcount	= "%s - 대상 바꾸세요 (%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo		= "%%s 깔림 - 피하세요"
L.AUTO_SPEC_WARN_TEXTS.adds		= "쫄 등장 - 대상 바꾸세요"
L.AUTO_SPEC_WARN_TEXTS.addscustom	= "쫄 등장 - %%s"
L.AUTO_SPEC_WARN_TEXTS.targetchange	= "대상 변경 - %%s 치세요"

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS.spell			= "$spell:%s 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.ends			= "$spell:%s 종료시 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.fades			= "$spell:%s|1이;가; 사라졌을 때 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.soon			= "$spell:%s 이전에 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.sooncount		= "$spell:%s 이전에 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.bait			= "$spell:%s 이전에 특수 알림 보기 (위치 유도)"
L.AUTO_SPEC_WARN_OPTIONS.prewarn			= "$spell:%2$s %1$s초 전에 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.dispel			= "$spell:%s 해제/마법 훔치기 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.interrupt		= "$spell:%s 차단 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount		= "$spell:%s 차단 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.you			= "당신이 $spell:%s 대상이면 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.youcount		= "당신이 $spell:%s 대상이면 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.youpos			= "당신이 $spell:%s 대상이면 특수 알림 보기 (위치 포함)"
L.AUTO_SPEC_WARN_OPTIONS.soakpos			= "$spell:%s 대상에게 뭉쳐야 할 때 특수 알림 보기 (위치 포함)"
L.AUTO_SPEC_WARN_OPTIONS.target			= "$spell:%s 대상 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.targetcount		= "$spell:%s 대상 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.defensive		= "$spell:%s에 생존기 사용 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.taunt			= "다른 탱커가 $spell:%s 대상이면 도발 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.close			= "당신 근처에 $spell:%s 대상이 있으면 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.move			= "$spell:%s 피하기 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 		= "$spell:%s에 계속 이동 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 		= "$spell:%s에 이동 금지 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.dodge			= "$spell:%s 피하기 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount		= "$spell:%s 피하기 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc		= "$spell:%s 피하기 특수 알림 보기 (회피 장소 포함)"
L.AUTO_SPEC_WARN_OPTIONS.moveaway		= "$spell:%s에 거리 이격 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount		= "$spell:%s에 밖으로 나오기 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.moveto			= "$spell:%s에 특정인 또는 특정 위치로 이동 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.soak			= "$spell:%s 맞기 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.jump			= "$spell:%s에 점프 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.run			= "$spell:%s|1으로;로;부터 도망 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.cast			= "$spell:%s에 주문 시전 중지 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.lookaway		= "$spell:%s에 고개 돌리기 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.reflect 		= "$spell:%s에 공격 중지 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.count			= "$spell:%s 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.stack			= "당신이 $spell:%2$s %1$d중첩 이상이 된 경우 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.switch			= "$spell:%s에 대상 변경 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.switchcount 		= "$spell:%s에 대상 변경 특수 알림 보기 (횟수 포함)"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 			= "바닥 피하기 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.adds 			= "쫄 등장시 대상 변경 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.addscustom		= "쫄 등장시 특수 알림 보기"
L.AUTO_SPEC_WARN_OPTIONS.targetchange		= "점사 우선순위 변경시 특수 알림 보기"

-- Auto-generated Timer Localizations
L.AUTO_TIMER_TEXTS.active		= "%s 종료"--Buff/Debuff/event on boss
L.AUTO_TIMER_TEXTS.fades			= "%s 사라짐"--Buff/Debuff on players
L.AUTO_TIMER_TEXTS.ai				= "%s AI 예상"
L.AUTO_TIMER_TEXTS.cd				= "%s 쿨타임"
L.AUTO_TIMER_TEXTS.cdcount		= "%s 쿨타임 (%%s)"
L.AUTO_TIMER_TEXTS.cdsource		= "%s 쿨타임: >%%s<"
L.AUTO_TIMER_TEXTS.cdspecial		= "특수 능력 쿨타임"
L.AUTO_TIMER_TEXTS.cdspecialshort	= "~특수 능력"
L.AUTO_TIMER_TEXTS.next			= "다음 %s"
L.AUTO_TIMER_TEXTS.nextcount		= "다음 %s (%%s)"
L.AUTO_TIMER_TEXTS.nextsource		= "다음 %s: %%s"
L.AUTO_TIMER_TEXTS.nextspecial		= "다음 특수 능력"
L.AUTO_TIMER_TEXTS.nextspecialshort	= "특수 능력"
L.AUTO_TIMER_TEXTS.stage			= "다음 단계"
L.AUTO_TIMER_TEXTS.stageshort		= "단계"
L.AUTO_TIMER_TEXTS.adds			= "쫄 등장"
L.AUTO_TIMER_TEXTS.addsshort		= "쫄"
L.AUTO_TIMER_TEXTS.addscustom		= "쫄 등장 (%%s)"
L.AUTO_TIMER_TEXTS.addscustomshort	= "쫄 (%%s)"

L.AUTO_TIMER_OPTIONS.target		= "$spell:%s 디버프 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.cast		= "$spell:%s 시전 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.castcount		= "$spell:%s 시전 타이머 바 보기 (횟수 포함)"
L.AUTO_TIMER_OPTIONS.castsource		= "$spell:%s 시전 타이머 바 보기 (시전자 이름 포함)"
L.AUTO_TIMER_OPTIONS.active		= "$spell:%s 지속 시간 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.fades		= "$spell:%s 남은 시간 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.ai				= "$spell:%s 쿨타임의 인공지능 예상 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.cd				= "$spell:%s 쿨타임 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.cdcount		= "$spell:%s 쿨타임 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.cdsource		= "$spell:%s 쿨타임 타이머 바 보기 (시전자 이름 포함)"
L.AUTO_TIMER_OPTIONS.cdspecial		= "특수 능력 쿨타임 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.next		= "다음 $spell:%s 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.nextcount		= "다음 $spell:%s 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.nextsource		= "다음 $spell:%s 타이머 바 보기 (시전자 이름 포함)"
L.AUTO_TIMER_OPTIONS.nextspecial		= "다음 특수 능력 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.achievement		= "%s 업적의 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.stage		= "다음 단계 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.adds		= "쫄 등장 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.addscustom		= "쫄 등장 타이머 바 보기"
L.AUTO_TIMER_OPTIONS.roleplay		= "역할 수행(롤플레이) 지속 시간 타이머 바 보기"

L.AUTO_ICONS_OPTION_TEXT			= "$spell:%s 대상에 공격대 징표 설정"
L.AUTO_ICONS_OPTION_TEXT2		= "$spell:%s에 공격대 징표 설정"
L.AUTO_ARROW_OPTION_TEXT			= "$spell:%s 대상을 향하는 " .. L.DBM .. " 화살표 보기"
L.AUTO_ARROW_OPTION_TEXT2		= "$spell:%s 대상과 반대 방향의 " .. L.DBM .. " 화살표 보기"
L.AUTO_ARROW_OPTION_TEXT3		= "$spell:%s 특정 지점을 가리키는 " .. L.DBM .. " 화살표 보기"
L.AUTO_YELL_OPTION_TEXT.shortyell	= "$spell:%s 대상일 때 말풍선으로 알리기"
L.AUTO_YELL_OPTION_TEXT.yell		= "$spell:%s 대상일 때 말풍선으로 알리기 (플레이어 이름 포함)"
L.AUTO_YELL_OPTION_TEXT.count		= "$spell:%s 대상일 때 말풍선으로 알리기 (횟수 포함)"
L.AUTO_YELL_OPTION_TEXT.fade		= "$spell:%s 지속시간이 끝나갈 때 말풍선으로 알리기 (주문 이름 및 초읽기 포함)"
L.AUTO_YELL_OPTION_TEXT.shortfade	= "$spell:%s 지속시간이 끝나갈 때 말풍선으로 알리기 (초읽기 포함)"
L.AUTO_YELL_OPTION_TEXT.iconfade		= "$spell:%s 지속시간이 끝나갈 때 말풍선으로 알리기 (초읽기 및 공격대 징표 포함)"
L.AUTO_YELL_OPTION_TEXT.position	= "$spell:%s 대상일 때 말풍선으로 알리기 (위치 포함)"
L.AUTO_YELL_OPTION_TEXT.combo		= "$spell:%s|1과;와; 다른 디버프가 같이 걸렸을 때 말풍선으로 알리기 (사용자 지정 문자 포함)"
L.AUTO_YELL_OPTION_TEXT.repeatplayer	= "$spell:%s에 걸렸을 때 말풍선 알림 반복 (플레이어 이름 포함)"
L.AUTO_YELL_OPTION_TEXT.repeaticon	= "$spell:%s에 걸렸을 때 말풍선 알림 반복 (공격대 징표 포함)"
L.AUTO_YELL_ANNOUNCE_TEXT.yell	= UnitName("player") .. "에게 %s"
L.AUTO_YELL_ANNOUNCE_TEXT.count	= UnitName("player") .. "에게 %s (%%d)"
L.AUTO_YELL_ANNOUNCE_TEXT.fade	= "%s %%d초 후 사라짐"
L.AUTO_YELL_ANNOUNCE_TEXT.position	= "{rt%%3$d}" .. UnitName("player") .. "{rt%%3$d}에게 %1$s %%2$s"
L.AUTO_YELL_ANNOUNCE_TEXT.combo		= "%s랑 %%s 걸림"
L.AUTO_YELL_CUSTOM_FADE			= "%s 사라짐"
L.AUTO_HUD_OPTION_TEXT			= "$spell:%s에 HUD 표시 (중단됨)"
L.AUTO_HUD_OPTION_TEXT_MULTI		= "여러 보스 기술에 HUD 표시 (중단됨)"
L.AUTO_NAMEPLATE_OPTION_TEXT		= "$spell:%s 오라를 이름표에 표시"
L.AUTO_RANGE_OPTION_TEXT			= "$spell:%2$s 범위에 대한 거리 창 보기 (%1$sm)"
L.AUTO_RANGE_OPTION_TEXT_SHORT	= "거리 창 보기 (%sm)"
L.AUTO_RRANGE_OPTION_TEXT		= "$spell:%2$s 범위에 대한 반전 거리 창 보기 (%1$sm)"
L.AUTO_RRANGE_OPTION_TEXT_SHORT	= "반전 거리 창 보기 (%sm)"
L.AUTO_INFO_FRAME_OPTION_TEXT	= "$spell:%s|1을;를; 정보 창에 표시"
L.AUTO_INFO_FRAME_OPTION_TEXT2	= "전투 전반에 관한 사항을 정보 창에 표시"
L.AUTO_READY_CHECK_OPTION_TEXT	= "보스가 풀링되면 전투 준비 효과음 듣기 (보스를 대상으로 잡지 않아도 재생)"
L.AUTO_SPEEDCLEAR_OPTION_TEXT	= "%s의 완료 신기록 타이머 표시"

-- New special warnings
L.MOVE_WARNING_BAR				= "알림 이동"
L.MOVE_WARNING_MESSAGE			= L.DEADLY_BOSS_MODS .. "를 이용해 주셔셔 감사합니다."
L.MOVE_SPECIAL_WARNING_BAR		= "특수 알림 이동"
L.MOVE_SPECIAL_WARNING_TEXT		= "특수 알림"

L.HUD_INVALID_TYPE			= "올바르지 않은 HUD 형식이 정의되었습니다"
L.HUD_INVALID_TARGET			= "HUD에 올바른 대상이 주어지지 않았습니다"
L.HUD_INVALID_SELF			= "자신을 HUD 대상으로 설정할 수 없습니다"
L.HUD_INVALID_ICON			= "공격대 징표가 없는 대상엔 징표 기반 HUD 기능을 사용할 수 없습니다"
L.HUD_SUCCESS				= "HUD가 입력한 정보를 표시하기 시작합니다. %s 후 자동으로 사라지며 '/dbm hud hide'를 입력하면 즉시 숨길 수 있습니다."
L.HUD_USAGE	= {
	L.DBM .. " HUD 사용법:",
	"--------------------",
	"/dbm hud <형식> <대상> <지속시간>: 지정한 시간 동안 대상을 가리키는 HUD를 생성",
	"유효한 형식: arrow, red, blue, green, yellow, icon (대상에게 공격대 징표가 설정되어 있어야 함)",
	"유효한 대상: target, focus, <대상이름>",
	"유효한 시간: 아무 숫자(초단위). 지정하지 않으면 20분간 적용됩니다.",
	"/dbm hud hide: 사용자가 생성한 HUD를 비활성화"
}

L.ARROW_MOVABLE						= "화살표 이동"
L.ARROW_WAY_USAGE					= "/dway <x> <y>: 특정 지점을 가리키는 화살표를 생성합니다 (로컬 지역 지도 좌표 사용)"
L.ARROW_WAY_SUCCESS				= "화살표를 숨기려면 '/dbm arrow hide' 또는 화살표 지점까지 도달하세요"
L.ARROW_ERROR_USAGE	= {
	L.DBM .. " 화살표 사용법:",
	"------------------",
	"/dbm arrow <x> <y>: 지정된 위치를 가리키는 화살표 생성 (세계지도 좌표 사용)",
	"/dbm arrow map <x> <y>: 지정된 위치를 가리키는 화살표 생성 (지역지도 좌표 사용)",
	"/dbm arrow <플레이어>: 파티 또는 공격대에서 지정한 <플레이어>를 가리키는 화살표 생성 (대소문자 구분!)",
	"/dbm arrow hide: 화살표 숨김",
	"/dbm arrow move: 화살표 이동 가능"
}

L.SPEED_KILL_TIMER_TEXT	= "최고 승리 기록"
L.SPEED_CLEAR_TIMER_TEXT	= "최고 완료 기록"
L.COMBAT_RES_TIMER_TEXT	= "다음 전투 부활 충전"
L.TIMER_RESPAWN		= "%s 재생성"


L.REQ_INSTANCE_ID_PERMISSION		= "%s|1이;가; 당신의 현재 인스턴스 ID와 진행 상태 열람을 요청했습니다.\n해당 정보를 %s에게 전송할까요? 현재 접속한 세션 동안에는 해당 정보의 요청은 항상 받아들여집니다. (예: 재접속 전까지)"
L.ERROR_NO_RAID					= "이 기능을 사용하려면 공격대에 있어야 합니다."
L.INSTANCE_INFO_REQUESTED			= "공격대에 공격대 귀속 정보 요청을 전송했습니다.\n사용자들은 데이터를 전송하기에 앞서 권한 승인 여부를 결정하므로 모두의 응답을 받기까지 1분이 소요될 수 있습니다."
L.INSTANCE_INFO_STATUS_UPDATE		= L.DBM .. " 사용자 %2$d명 중 %1$d명 응답: %3$d명이 데이터 전송, %4$d명이 요청을 거부했습니다. 응답까지 %5$d초 대기중..."
L.INSTANCE_INFO_ALL_RESPONSES		= "받은 응답 결과"
L.INSTANCE_INFO_DETAIL_DEBUG		= "전송자: %s, 응답형식: %s, 인스턴스명: %s, 인스턴스ID: %s, 난이도: %d, 인원: %d, 처치수: %s"
L.INSTANCE_INFO_DETAIL_HEADER		= "%s, 난이도 %s:"
L.INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, 처치 %d: %s"
L.INSTANCE_INFO_DETAIL_INSTANCE2	= "    처치 %d: %s"
L.INSTANCE_INFO_NOLOCKOUT			= "공격대 인스턴스에 귀속된 공격대원이 없습니다."
L.INSTANCE_INFO_STATS_DENIED		= "확인 요청 거부: %s"
L.INSTANCE_INFO_STATS_AWAY		= "자리 비움: %s"
L.INSTANCE_INFO_STATS_NO_RESPONSE	= "최근 버전 " .. L.DBM .. " 미설치: %s"
L.INSTANCE_INFO_RESULTS			= "인스턴스 ID 검사가 끝났습니다. 다른 언어의 WoW 클라이언트를 사용 중인 공격대원이 있다면 같은 인스턴스가 여러개 보일 수 있습니다."
L.INSTANCE_INFO_SHOW_RESULTS		= "응답 안한 플레이어: %s"

L.LAG_CHECKING				= "공격대의 지연시간 확인중..."
L.LAG_HEADER					= L.DEADLY_BOSS_MODS .. " - 지연시간 확인 결과"
L.LAG_ENTRY					= "%s: 서버 지연시간 [%d ms] / 개인 지연시간 [%d ms]"
L.LAG_FOOTER					= "응답없음: %s"

L.DUR_CHECKING				= "공격대 내구도 검사중..."
L.DUR_HEADER					= L.DEADLY_BOSS_MODS .. " - 내구도 검사 결과"
L.DUR_ENTRY					= "%s: 내구도 [%d 퍼센트] / 깨진 장비 [%s]"
L.LAG_FOOTER					= "응답 없음: %s"

--LDB
L.LDB_TOOLTIP_HELP1			= "왼쪽 클릭으로 " .. L.DBM .. " 열기"
L.LDB_TOOLTIP_HELP2			= "Alt+오른쪽 클릭으로 조용함 모드 켜고 끄기"

L.SILENTMODE_IS					= "조용함 모드 "

L.LDB_LOAD_MODS		= "보스 모드 로드"

L.LDB_CAT_OTHER		= "그 외 보스 모드"

L.LDB_CAT_GENERAL		= "일반"
L.LDB_ENABLE_BOSS_MOD	= "보스 모드 사용"
