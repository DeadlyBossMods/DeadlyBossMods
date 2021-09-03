--Mini Dragon <流浪者酒馆-Brilla@金色平原> 20210902
if GetLocale() ~= "zhCN" then return end
local L

---------------------------
--  The Tarragrue 塔拉格鲁--
---------------------------
L= DBM:GetModLocalization(2435)

L:SetOptionLocalization({
	warnRemnant	= "通告个人残渣层数"
})

L:SetMiscLocalization({
	Remnant	= "残渣"
})

---------------------------
--  The Eye of the Jailer 典狱长之眼--
---------------------------
L= DBM:GetModLocalization(2442)

L:SetOptionLocalization({
	ContinueRepeating	= "重复蔑视和愤怒的标记喊话，直到debuff消失"
})

---------------------------
--  The Nine 九武神--
---------------------------
L= DBM:GetModLocalization(2439)

L:SetMiscLocalization({
	Fragment		= "残片 "--Space is intentional, leave a space to add a number after it
})

---------------------------
--  Remnant of Ner'zhul 耐奥祖--
---------------------------
--L= DBM:GetModLocalization(2444)

---------------------------
--  Soulrender Dormazain 多尔玛赞--
---------------------------
--L= DBM:GetModLocalization(2445)

---------------------------
--  Painsmith Raznal 莱兹纳尔--
---------------------------
--L= DBM:GetModLocalization(2443)

---------------------------
--  Guardian of the First Ones 初诞者的卫士--
---------------------------
L= DBM:GetModLocalization(2446)

L:SetOptionLocalization({
	IconBehavior	= "设置团队标记方式(团长覆盖全团)",
	TypeOne			= "DBM预设(先近战后远程)",
	TypeTwo			= "BigWigs(按照战斗日志先后顺序)"
})


L:SetMiscLocalization({
	Dissection	= "解剖！",
	Dismantle	= "分解"
})

---------------------------
--  Fatescribe Roh-Kalo 卡洛--
---------------------------
--L= DBM:GetModLocalization(2447)

---------------------------
--  Kel'Thuzad 克尔苏加德--
---------------------------
--L= DBM:GetModLocalization(2440)

---------------------------
--  Sylvanas Windrunner 希尔瓦娜斯--
---------------------------
--L= DBM:GetModLocalization(2441)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SanctumofDomTrash")

L:SetGeneralLocalization({
	name =	"统御圣所小怪"
})
