if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  The Tarragrue --
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "자신의 잔재 디버프 중첩 알림"
})

L:SetMiscLocalization({
	Remnant	= "잔재"
})

---------------------------
--  The Eye of the Jailer --
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "경멸과 분노 디버프에 걸리면 끝날때까지 지정된 공격대 징표 말풍선 알림"
})

---------------------------
--  The Nine --
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "조각 "--Space is intentional, leave a space to add a number after it
})

---------------------------
--  Remnant of Ner'zhul --
---------------------------
--L= DBM:GetModLocalization(2444)

---------------------------
--  Soulrender Dormazain --
---------------------------
--L= DBM:GetModLocalization(2445)

---------------------------
--  Painsmith Raznal --
---------------------------
--L= DBM:GetModLocalization(2443)

---------------------------
--  Guardian of the First Ones --
---------------------------
L= DBM:GetModLocalization(2446)

L:SetOptionLocalization({
	IconBehavior	= "공격대 징표 방식 설정 (공대장이면 설정이 공격대 전체에 적용)",
	TypeOne			= "DBM 기본값 (근접 > 원거리)",
	TypeTwo			= "BW 기본값 (전투기록상 순서)"
})

L:SetMiscLocalization({
	Dissection	= "해부를 시작합니다!",
	Dismantle	= "분해 실시!"
})

---------------------------
--  Fatescribe Roh-Kalo --
---------------------------
--L= DBM:GetModLocalization(2447)

---------------------------
--  Kel'Thuzad --
---------------------------
--L= DBM:GetModLocalization(2440)

---------------------------
--  Sylvanas Windrunner --
---------------------------
--L= DBM:GetModLocalization(2441)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SanctumofDomTrash")

L:SetGeneralLocalization({
	name =	"지배의 성소 일반몹"
})
