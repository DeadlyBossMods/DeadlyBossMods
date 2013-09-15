if GetLocale() ~= "zhTW" then return end
local L

---------------
-- Immerseus --
---------------
L= DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory			= "啊，你成功了!水又再次純淨了。"
})

---------------------------
-- The Fallen Protectors --
---------------------------
L= DBM:GetModLocalization(849)

---------------------------
-- Norushen --
---------------------------
L= DBM:GetModLocalization(866)

L:SetOptionLocalization({
	InfoFrame			= "為$journal:8252顯示訊息框架"
})

L:SetMiscLocalization({
	wasteOfTime			= "很好，我會創造一個力場隔離你們的腐化。"
})

------------------
-- Sha of Pride --
------------------
L= DBM:GetModLocalization(867)

L:SetOptionLocalization({
	InfoFrame			= "為$journal:8255顯示訊息框架"
})

--------------
-- Galakras --
--------------
L= DBM:GetModLocalization(868)

L:SetTimerLocalization({
	timerTowerCD	= "下一波塔攻"
})

L:SetOptionLocalization({
	timerTowerCD	= "為下一波塔攻顯示計時器"
})

L:SetMiscLocalization({
	newForces1	= "趕快把她弄下來，讓我用手掐死她。",
	newForces2	= "龍喉氏族，前進!",
	newForces3	= "為了地獄吼!",
	newForces4	= "下一隊，前進!",
	tower		= "的門已經遭到破壞!"
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
	PrisonYell		= "Prison on %s fades (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L= DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon		= "防禦姿態在%d秒"
})

L:SetOptionLocalization({
	warnDefensiveStanceSoon		= "為$spell:143593(五秒前)顯示預先警告倒數"
})

L:SetMiscLocalization({
	newForces1					= "戰士們，快點過來!",
	newForces2					= "守住大門!",
	newForces3					= "重整部隊!",
	newForces4					= "柯爾克隆，來我身邊!",
	newForces5					= "下一隊，來前線!",
	allForces					= "所有柯爾克隆...聽我號令...殺死他們!"
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
	Module1 = "Module 1's all prepared for system reset.",
	Victory	= "Module 2's all prepared for system reset"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L= DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "顯示動態距離框架(10碼)<br/>(This is a smart range frame that shows when you reach Frenzy threshold)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L= DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "Unfinished weapons begin to roll out on the assembly line.",
	newShredder	= "An Automated Shredder draws near!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L= DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable		= "你虛弱於%s - 閃躲!",
	specWarnCriteriaLinked			= "你被%s連線了!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable		= "當你虛弱於活動的議會成員時顯示特別警告",
	specWarnCriteriaLinked			= "當你被$spell:144095連線時顯示特別警告"
})

L:SetMiscLocalization({
	--thanks to blizz, the only accurate way for this to work, is to translate 5 emotes in all languages
	one					= "One",
	two					= "Two",
	three				= "Three",
	four				= "Four",
	five				= "Five",
	hisekFlavor			= "Look who's quiet now",--http://ptr.wowhead.com/quest=31510
	KilrukFlavor		= "Just another day, culling the swarm",--http://ptr.wowhead.com/quest=31109
	XarilFlavor			= "I see only dark skies in your future",--http://ptr.wowhead.com/quest=31216
	KaztikFlavor		= "Reduced to mere kunchong treats",--http://ptr.wowhead.com/quest=31024
	KaztikFlavor2		= "1 Mantid down, only 199 to go",--http://ptr.wowhead.com/quest=31808
	KorvenFlavor		= "The end of an ancient empire",--http://ptr.wowhead.com/quest=31232
	KorvenFlavor2		= "Take your Gurthani Tablets and choke on them",--http://ptr.wowhead.com/quest=31232
	IyyokukFlavor		= "See opportunities. Exploit them!",--Does not have quests, http://ptr.wowhead.com/npc=65305
	KarozFlavor			= "You won't be leaping anymore!",---Does not have questst, http://ptr.wowhead.com/npc=65303
	SkeerFlavor			= "A bloody delight!",--http://ptr.wowhead.com/quest=31178
	RikkalFlavor		= "Specimen request fulfilled"--http://ptr.wowhead.com/quest=31508
})

------------------------
-- Garrosh Hellscream --
------------------------
L= DBM:GetModLocalization(869)

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name =	"圍攻奧格瑪小兵"
})
