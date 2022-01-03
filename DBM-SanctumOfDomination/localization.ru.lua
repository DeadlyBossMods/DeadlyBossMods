if GetLocale() ~= "ruRU" then return end
local L

---------------------------
--  The Tarragrue --
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "Объявить персональные стаки дебаффов Фрагмента"
})

L:SetMiscLocalization({
	Remnant	= "Фрагмент"
})

---------------------------
--  The Eye of the Jailer --
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "Продолжайте повторять крики о Презрении и Гневе, пока дебаффы не исчезнут"
})

---------------------------
--  The Nine --
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "Фрагмент "--Space is intentional, leave a space to add a number after it
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
	IconBehavior	= "Установить поведение маркировки для рейда (если лидер рейда, переопределяет рейд)",
	TypeOne			= "DBM по умолчанию (Ближний бой > Дальний бой)",
	TypeTwo			= "BigWigs по умолчанию (Порядок ведения журнала боя)"
})

L:SetMiscLocalization({
	Dissection	= "Рассечение!",
	Dismantle	= "Dismantle"
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
	name =	"Трэш мобы Святилище Господства"
})
