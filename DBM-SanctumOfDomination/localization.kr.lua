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
--L= DBM:GetModLocalization(2442)

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
