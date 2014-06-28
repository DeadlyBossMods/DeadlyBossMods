if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "啊，你成功了!水又再次純淨了。"
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnMeasures	= "絕處求生即將到來(%s)!"
})

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "很好，我會創造一個力場隔離你們的腐化。"
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "為腐化的碎片設置圖示"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen		= "砲塔門被打開了",
	warnTowerGrunt		= "塔防蠻兵"
})

L:SetTimerLocalization({
	timerTowerCD		= "下一波塔攻",
	timerTowerGruntCD	= "下一次塔防蠻兵"
})

L:SetOptionLocalization({
	warnTowerOpen		= "提示砲塔門被打開",
	warnTowerGrunt		= "提示新的塔防蠻兵重生",
	timerTowerCD		= "為下一波塔攻顯示計時器",
	timerTowerGruntCD	= "為下一次塔防蠻兵顯示計時器"
})

L:SetMiscLocalization({
	wasteOfTime		= "做得好!登陸小隊，集合!步兵打前鋒!",
	wasteOfTime2	= "很好，第一梯隊已經登陸。",
	Pull			= "龍喉氏族，奪回碼頭，把他們推進海裡!以地獄吼及正統部落之名!",
	newForces1		= "他們來了!",
	newForces1H		= "趕快把她弄下來，讓我用手掐死她。",
	newForces2		= "龍喉氏族，前進!",
	newForces3		= "為了地獄吼!",
	newForces4		= "下一隊，前進!",
	tower			= "的門已經遭到破壞!"
})

--------------------
--Iron Juggernaut --
--------------------
L= DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L= DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "%s的囚犯被釋放 (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "%d秒後防禦姿態"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon	= "為$spell:143593(五秒前)顯示預先警告倒數"
})

L:SetMiscLocalization({
	newForces1			= "戰士們，快點過來!",
	newForces2			= "守住大門!",
	newForces3			= "重整部隊!",
	newForces4			= "柯爾克隆，來我身邊!",
	newForces5			= "下一隊，來前線!",
	allForces			= "所有柯爾克隆...聽我號令...殺死他們!",
	nextAdds			= "下一次小兵: "
})

-----------------
-- Malkorok -----
-----------------
L= DBM:GetModLocalization(846)

------------------------
-- Spoils of Pandaria --
------------------------
L= DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime		= "我們在錄音嗎?有嗎?好。哥布林-泰坦控制模組開始運作，請後退。",
	Module1 		= "模組一號已準備好系統重置。",
	Victory			= "模組二號已準備好系統重置。"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "顯示動態距離框架(10碼)<br/>(這是智慧距離框架，當到達血之狂暴階段時自動切換)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "尚未完成的武器開始從生產線上掉落。",
	newShredder	= "有個自動化伐木機靠近了!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "你虛弱於%s - 換坦!",
	specWarnMoreParasites		= "你需要更多的寄生蟲 - 不要開招!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable	= "當你虛弱於活動的議會成員時顯示特別警告",
	specWarnMoreParasites		= "當你需要更多寄生蟲時顯示特別警告"
})

L:SetMiscLocalization({
	one					= "一",
	two					= "二",
	three				= "三",
	four				= "四",
	five				= "五",
	hisekFlavor			= "現在是誰寂然無聲啊",
	KilrukFlavor		= "又是個撲殺蟲群的一天",
	XarilFlavor			= "我只在你的未來看到黑色天空",
	KaztikFlavor		= "減少隻昆蟲的蟲害",
	KaztikFlavor2		= "1隻螳螂倒下了，還有199隻要殺",
	KorvenFlavor		= "古代帝國的終結",
	KorvenFlavor2		= "拿著你的葛薩尼石板窒息吧",
	IyyokukFlavor		= "看到機會。剝削他們!",
	KarozFlavor			= "你再也跳不起來了!",
	SkeerFlavor			= "一份血腥的喜悅!",
	RikkalFlavor		= "已滿足樣本要求"
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

L:SetOptionLocalization({
	timerRoleplay		= "為卡爾洛斯/索爾劇情事件顯示計時器",
	RangeFrame			= "顯示動態距離框架(10碼)<br/>(這是智慧距離框架，當到達$spell:147126門檻時自動切換)",
	InfoFrame			= "為玩家在中場階段時沒有傷害減免顯示訊息框架",
	yellMaliceFading	= "當$spell:147209將要退去時大喊"
})

L:SetMiscLocalization({
	wasteOfTime			= "It is not too late, Garrosh. Lay down the mantle of Warchief. We can end this here, now, with no more bloodshed.",
	NoReduce			= "無傷害減免",
	MaliceFadeYell		= "%s的惡意消退中(%d)",
	phase3End			= "你們以為贏了嗎?"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"圍攻奧格瑪小兵"
})
