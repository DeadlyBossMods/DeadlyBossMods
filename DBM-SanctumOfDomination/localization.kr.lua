if GetLocale() ~= "koKR" then return end
local L

---------------------------
--  The Tarragrue --
---------------------------
L= DBM:GetModLocalization(2435)

L:SetMiscLocalization({
	Remnant	= "잔재"
})

---------------------------
--  The Eye of the Jailer --
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "Scorn과 Ire 디버프에 걸리면 끝날때까지 지정된 공격대 징표 말풍선 알림"
})

---------------------------
--  The Nine --
---------------------------
--L= DBM:GetModLocalization(2439)

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

L:SetMiscLocalization({
	Dissection	= "Dissection!"
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
