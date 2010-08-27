if GetLocale() ~= "zhTW" then return end

local L

local spell				= "%s"				
local debuff			= "%s: >%s<"			
local spellCD			= "%s 冷卻"
local spellSoon			= "%s 即將到來"
local optionWarning		= "為%s顯示警告"
local optionPreWarning	= "為%s顯示預先警告"
local optionSpecWarning	= "為%s顯示特別警告"
local optionTimerCD		= "為%s顯示冷卻計時器"
local optionTimerDur	= "為%s顯示持續時間計時器"
local optionTimerCast	= "為%s顯示施法計時器"

----------------------------------
--  Ahn'Kahet: The Old Kingdom  --
----------------------------------
--  Prince Taldaram  --
-----------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "泰爾達朗親王"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
--  Elder Nadox  --
-------------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "老那杜斯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------
--  Jedoga Shadowseeker  --
---------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "潔杜佳·尋影者"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------
--  Herald Volazj  --
---------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "信使沃菈齊"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------
--  Amanitar  --
----------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "毒蕈魔"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------
--  Azjol-Nerub  --
---------------------------------
--  Krik'thir the Gatewatcher  --
---------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "『守門者』齊力克西爾"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------
--  Hadronox  --
----------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "哈卓諾克斯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  Anub'arak (Party)  --
-------------------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "阿努巴拉克 (隊伍)"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------------------
--  Caverns of Time: Old Stratholme  --
---------------------------------------
--  Meathook  --
----------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "肉鉤"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------------
--  Salramm the Fleshcrafter  --
--------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "『血肉工匠』塞歐朗姆"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  Chrono-Lord Epoch  --
-------------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "紀元時間領主"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
--  Mal'Ganis  --
-----------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "瑪爾加尼斯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	Outro	= "你的旅途才剛開始，年輕的王子。召集你的軍隊，到北裂境的嚴寒之地來見我。在那裡，我們可以算算我們之間的新仇舊恨。你將在那裡理解你真正的命運。"
})

-------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("StratWaves")

L:SetGeneralLocalization({
	name = "斯坦波數"
})

L:SetWarningLocalization({
	WarningWaveNow	= "第%d波: %s 出現了"
})

L:SetTimerLocalization({
	TimerWaveIn		= "下一波(6)",
	TimerRoleplay	= "角色扮演阿薩斯計時"
})

L:SetOptionLocalization({
	WarningWaveNow	= optionWarning:format("新一波"),
	TimerWaveIn		= "為下一波顯示計時器 (之後5隻小兵波數)",
	TimerRoleplay	= "為角色扮演事件顯示計時器"
})

L:SetMiscLocalization({
	Meathook	= "肉鉤",
	Salramm		= "『血肉工匠』塞歐朗姆",
	Devouring	= "吞噬食屍鬼",
	Enraged		= "狂怒食屍鬼",
	Necro		= "死靈大法師",
	Fiend		= "地穴惡魔",
	Stalker		= "墓穴巡者",
	Abom		= "縫補傀儡",
	Acolyte		= "侍僧",
	Wave1		= "%d %s",
	Wave2		= "%d %s 及 %d %s",
	Wave3		= "%d %s，%d %s 及 %d %s",
	Wave4		= "%d %s，%d %s，%d %s 及 %d %s",
	WaveBoss	= "%s",
	WaveCheck	= "天譴軍波數 = (%d+)/10",
	Roleplay	= "真高興你趕到了，烏瑟。",
	Roleplay2	= "大家看來都準備好了。記得，這些人受到恐怖瘟疫所感染，不久人世。我們得淨化斯坦索姆以保護其他百姓免受天譴軍的威脅。出發吧。"
})

------------------------
--  Drak'Tharon Keep  --
------------------------
--  Trollgore  --
-----------------
L = DBM:GetModLocalization("Trollgore")

L:SetGeneralLocalization({
	name = "血角食人妖"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Novos the Summoner  --
--------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "『召喚者』諾沃司"
})

L:SetWarningLocalization({
	WarnCrystalHandler	= "水晶處理者 出現了 (剩餘%d)"
})

L:SetTimerLocalization({
	timerCrystalHandler	= "水晶處理者 出現"
})

L:SetOptionLocalization({
	WarnCrystalHandler	= "當水晶處理者出現時顯示警告",
	timerCrystalHandler	= "為下一次 水晶處理者出現顯示計時器"
})

L:SetMiscLocalization({
	YellPull		= "籠罩你的寒氣就是厄運的先兆。",
	HandlerYell		= "協助防禦!快點，廢物們!",
	Phase2			= "你一定看得出來，這一切都只是徒勞無功罷了!",
	YellKill		= "你的努力…全是白費。"
})

-----------------
--  King Dred  --
-----------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "崔德王"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------------
--  The Prophet Tharon'ja  --
-----------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "預言者薩隆杰"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Gundrak  --
----------------
--  Slad'ran  --
----------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "史拉德銳"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Moorabi  --
---------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "慕拉比"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  Drakkari Colossus  --		
-------------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "德拉克瑞巨像"
})

L:SetWarningLocalization({
	WarningElemental	= "元素階段",
	WarningStone		= "巨像階段"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningElemental	= "為元素階段顯示警告",
	WarningStone		= "為巨像階段顯示警告"
})

-----------------
--  Gal'darah  --
-----------------
L = DBM:GetModLocalization("Galdarah")

L:SetGeneralLocalization({
	name = "蓋爾達拉"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  Eck the Ferocious  --
-------------------------
L = DBM:GetModLocalization("Eck")

L:SetGeneralLocalization({
	name = "『兇猛』埃克"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------
--  Halls of Lightning  --
--------------------------
--  General Bjarngrim  --
-------------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "畢亞格林將軍"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------
--  Ionar  --
-------------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "埃歐納"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SetIconOnOverloadTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(52658)
})

---------------
--  Volkhan  --
---------------
L = DBM:GetModLocalization("Volkhan")

L:SetGeneralLocalization({
	name = "渥克瀚"
})

L:SetWarningLocalization({
	WarningStomp	= spell
})

L:SetTimerLocalization({
	TimerStompCD	= spellCD
})

L:SetOptionLocalization({
	WarningStomp	= optionWarning:format(GetSpellInfo(52237)),
	TimerStompCD	= optionTimerCD:format(GetSpellInfo(52237))
})

--------------
--  Kronus  --
--------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "洛肯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------
--  Halls of Stone  --
-----------------------
--  Maiden of Grief  --
-----------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "悲嘆少女"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------
--  Krystallus  --
------------------
L = DBM:GetModLocalization("Krystallus")

L:SetGeneralLocalization({
	name = "克利斯托魯斯"
})

L:SetWarningLocalization({
	WarningShatter	= spell
})

L:SetTimerLocalization({
	TimerShatterCD	= spellCD
})

L:SetOptionLocalization({
	WarningShatter	= optionWarning:format(GetSpellInfo(50810)),
	TimerShatterCD	= optionTimerCD:format(GetSpellInfo(50810))
})

------------------------------
--  Sjonnir the Ironshaper  --
------------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "『塑鐵者』斯雍尼爾"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------------------
--  Brann Bronzebeard Escort Event  --
--------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "布萊恩護衛事件"
})

L:SetWarningLocalization({
	WarningPhase	= "第%d階段"
})

L:SetTimerLocalization({
	timerEvent	= "剩餘時間"
})

L:SetOptionLocalization({
	WarningPhase	= optionWarning:format("階段數"),
	timerEvent		= "為事件的持續時間顯示計時器"
})

L:SetMiscLocalization({
	Pull	= "幫我看著外頭!我只要三兩下就可以搞定這玩意--",
	Phase1	= "安全機制突破中，史實資料分析已調至低優先佇列，啟動反制程序。",
	Phase2	= "已超出威脅指數標準。天界資料庫已中止。安全等級已提昇。",
	Phase3	= "威脅指數過高。已轉移無效的分析。啟動清潔處理協定。",
	Kill	= "警告:安全性系統自動修復裝置已被關閉。開始記憶體內容消除與…"
})

-----------------
--  The Nexus  --
-----------------
--  Anomalus  --
----------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "艾諾瑪路斯"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

-------------------------------
--  Ormorok the Tree-Shaper  --
-------------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "『樹木造形者』歐爾莫洛克"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------------
--  Grand Magus Telestra  --
----------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "大魔導師特雷斯翠"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "分裂 即將到來",
	WarningSplitNow		= "分裂",
	WarningMerge		= "融合"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "為分裂顯示預先警告",
	WarningSplitNow		= "為分裂顯示警告",
	WarningMerge		= "為融合顯示警告"
})

L:SetMiscLocalization({
	SplitTrigger1		= "這裡有我千萬個分身。",
	SplitTrigger2		= "我要讓你們嚐嚐無所適從的滋味!",
	MergeTrigger		= "現在，最後一步!"
})

-------------------
--  Keristrasza  --
-------------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "凱瑞史卓莎"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------------------
--  Commander Kolurg/Stoutbeard  --
-----------------------------------
L = DBM:GetModLocalization("Commander")

local commander = "未知"
if UnitFactionGroup("player") == "Alliance" then
	commander = "指揮官寇勒格"
elseif UnitFactionGroup("player") == "Horde" then
	commander = "指揮官厚鬚"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

------------------
--  The Oculus  --
-------------------------------
--  Drakos the Interrogator  --
-------------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "『審問者』德拉高斯"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	MakeitCountTimer	= "為成就:倒數吧顯示計時器"
})

L:SetMiscLocalization({
	MakeitCountTimer	= "倒數吧"
})

----------------------
--  Mage-Lord Urom  --
----------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "法師領主厄隆"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "可憐而無知的蠢貨!"
})

--------------------------
--  Varos Cloudstrider  --
--------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "瓦羅斯·雲行者"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------------------
--  Ley-Guardian Eregos  --
---------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "地脈守護者伊瑞茍斯"
})

L:SetWarningLocalization({
	WarningShiftEnd	= "界域轉換結束"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShiftEnd	= optionWarning:format(GetSpellInfo(51162).."結束"),
})

L:SetMiscLocalization({
	MakeitCountTimer	= "倒數吧"
})

--------------------
--  Utgarde Keep  --
-----------------------
--  Prince Keleseth  --
-----------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "凱雷希斯親王"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------------------------
--  Skarvald the Constructor  --
--  & Dalronn the Controller  --
--------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "『控制者』達隆恩"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

----------------------------
--  Ingvar the Plunderer  --
----------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "『盜掠者』因格瓦"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "不!不!我還可以…做得更好……"
})

------------------------
--  Utgarde Pinnacle  --
--------------------------
--  Skadi the Ruthless  --
--------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "無情的斯卡迪"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	CombatStart		= "哪來的蠢狗敢入侵此地?打起精神來，我的兄弟們!誰能把他們的頭顱帶來，我會好好的犒賞一番!",
	Phase2			= "你們這些沒教養的垃圾!你們的屍體剛好拿來當龍的點心!"
})

-------------------
--  King Ymiron  --
-------------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "依米倫國王"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------
--  Svala Sorrowgrave  --
-------------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "絲瓦拉·悲傷亡墓"
})

L:SetWarningLocalization({
	timerRoleplay		= "絲瓦拉·悲傷亡墓 活動"
})

L:SetTimerLocalization({
	timerRoleplay		= "為絲瓦拉·悲傷亡墓能夠活動前的角色扮演顯示計時器"
})

L:SetOptionLocalization({
	SvalaRoleplayStart	= "陛下!我已完成您的要求，如今懇求您的祝福!"
})

-----------------------
--  Gortok Palehoof  --
-----------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "戈托克·白蹄"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------------
--  The Violet Hold  --
-----------------------
--  Cyanigosa  --
-----------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "霞妮苟莎"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
	TimerCombatStart		= "戰鬥開始"
})

L:SetOptionLocalization({
	TimerCombatStart		= "為戰鬥開始顯示計時器"
})

L:SetMiscLocalization({
	CyanArrived	= "真是一群英勇的衛兵，但這座城市必須被夷平。我必須親自執行瑪里苟斯大人的指令!"
})

--------------
--  Erekem  --
--------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "伊銳坎"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

---------------
--  Ichoron  --
---------------
L = DBM:GetModLocalization("Ichoron")

L:SetGeneralLocalization({
	name = "伊仇隆"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-----------------
--  Lavanthor  --
-----------------
L = DBM:GetModLocalization("Lavanthor")

L:SetGeneralLocalization({
	name = "拉方索"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
--  Moragg  --
--------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "摩拉革"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

--------------
--  Xevozz  --
--------------
L = DBM:GetModLocalization("Xevoss")

L:SetGeneralLocalization({
	name = "基沃滋"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

-------------------------------
--  Zuramat the Obliterator  --
-------------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "『消滅者』舒拉邁特"
})

L:SetWarningLocalization({
	SpecialWarningVoidShifted 	= spell:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness 	= spell:format(GetSpellInfo(59745))
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	SpecialWarningVoidShifted	= optionSpecWarning:format(GetSpellInfo(54343)),
	SpecialShroudofDarkness		= optionSpecWarning:format(GetSpellInfo(59745))
})

---------------------
--  Portal Timers  --
---------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "傳送門計時"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "新傳送門即將到來",
	WarningPortalNow	= "傳送門 #%d",
	WarningBossNow		= "首領到來",
})

L:SetTimerLocalization({
	TimerPortalIn	= "傳送門 #%d",
})

L:SetOptionLocalization({
	WarningPortalNow		= optionWarning:format("新傳送門"),
	WarningPortalSoon		= optionPreWarning:format("新傳送門"),
	WarningBossNow			= optionWarning:format("首領到來"),
	TimerPortalIn			= "為下一次 傳送門顯示計時器 (擊敗首領後)",
	ShowAllPortalTimers		= "為所有傳送門顯示計時器 (不準確)"
})

L:SetMiscLocalization({
	Sealbroken	= "我們攻破了監獄大門!通往達拉然的通道已經暢通了!現在我們終於可以終結奧核戰爭了!",
	WavePortal	= "傳送門開啟:(%d+)/18"
})

-----------------------------
--  Trial of the Champion  --
-----------------------------
--  The Black Knight  --
------------------------
L = DBM:GetModLocalization("BlackKnight")

L:SetGeneralLocalization({
	name = "黑騎士"
})

L:SetWarningLocalization({
	warnExplode			= "食屍鬼爆炸 - 快跑開"
})

L:SetTimerLocalization{
	TimerCombatStart	= "戰鬥開始"
}

L:SetOptionLocalization({
	TimerCombatStart		= "為戰鬥開始顯示計時器",
	warnExplode				= "當食屍鬼爪牙即將自我爆炸時警告",
	AchievementCheck		= "提示 '糟糕透頂' 成就到隊伍頻道",
	SetIconOnMarkedTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(67823)
})

L:SetMiscLocalization({
	Pull				= "幹得好。今天，你已證明了你自己-",
	AchievementFailed	= ">> 成就失敗: %s 被食屍鬼爆炸炸到了 <<",
	YellCombatEnd		= "恭喜你，勇士們。儘管試煉隱藏著許多不安的變數，但你們仍然通過了考驗。"	-- can also be "No! I must not fail... again ..."
})

-----------------------
--  Grand Champions  --
-----------------------
L = DBM:GetModLocalization("GrandChampions")

L:SetGeneralLocalization({
	name = "大勇士們"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "精采的戰鬥!你的下一個挑戰者是從十字軍中挑選出來的英勇鬥士。你將會親身面對他們超卓實力的考驗。"
})

----------------------------------
--  Argent Confessor Paletress  --
----------------------------------
L = DBM:GetModLocalization("Confessor")

L:SetGeneralLocalization({
	name = "銀白告解者帕爾璀絲"
})

L:SetWarningLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
	YellCombatEnd	= "你們做得很好!"
})

-----------------------
--  Eadric the Pure  --
-----------------------
L = DBM:GetModLocalization("EadricthePure")

L:SetGeneralLocalization({
	name = "『純淨者』埃卓克"
})

L:SetWarningLocalization({
	specwarnRadiance		= "烈光 - 背對王"
})

L:SetOptionLocalization({
	specwarnRadiance		= "為$spell:66935顯示特別警告",
	SetIconOnHammerTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(66940)
})

L:SetMiscLocalization({
	YellCombatEnd	= "我認輸了!我投降。幹得好。我現在可以離場了嗎?"
})

--------------------
--  Pit of Saron  --
---------------------
--  Ick and Krick  --
---------------------
L = DBM:GetModLocalization("Ick")

L:SetGeneralLocalization({
	name = "艾克及克瑞克"
})

L:SetWarningLocalization({
	warnPursuit			= "追擊: >%s<",
	specWarnPursuit		= "你中了追擊 - 快跑"
})

L:SetOptionLocalization({
	warnPursuit				= "提示追擊的目標",
	specWarnPursuit			= "當你被追擊時顯示特別警告",
	SetIconOnPursuitTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(68987)
})

L:SetMiscLocalization({
	IckPursuit		= "%s正在追擊著你!",
	Barrage			= "%s開始迅速地召喚爆裂地雷!"
})

----------------------------
--  Forgemaster Garfrost  --
----------------------------
L = DBM:GetModLocalization("ForgemasterGarfrost")

L:SetGeneralLocalization({
	name = "鍛造大師加弗羅斯"
})

L:SetWarningLocalization({
	warnSaroniteRock		= "投擲薩鋼: >%s<",
	specWarnSaroniteRock	= "你中了投擲薩鋼 - 快跑開",
	specWarnSaroniteRockNear	= "你附近有人中了投擲薩鋼 - 快跑開",
	specWarnPermafrost		= "%s: %s"
})

L:SetOptionLocalization({
	warnSaroniteRock			= "提示$spell:70851的目標",
	specWarnSaroniteRock		= "當你中了$spell:70851時顯示特別警告",
	specWarnSaroniteRockNear	= "當你附近有人中了$spell:70851時顯示特別警告",
	specWarnPermafrost			= "當$spell:70336堆疊太高時顯示特別警告 (11層)",
	AchievementCheck			= "提示 '別到十一' 的成就警告到隊伍頻道",
	SetIconOnSaroniteRockTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(70851)
})

L:SetMiscLocalization({
	SaroniteRockThrow	= "%s對你丟出一大塊薩鋼巨石!",
	AchievementWarning	= "小心: %s 已擁有 %d 層極寒冰霜",
	AchievementFailed	= ">> 成就失敗: %s 已超過 %d 層極寒冰霜 <<"
})

----------------------------
--  Scourgelord Tyrannus  --
----------------------------
L = DBM:GetModLocalization("ScourgelordTyrannus")

L:SetGeneralLocalization({
	name = "天譴領主提朗紐斯"
})

L:SetWarningLocalization({
	specWarnHoarfrost		= "你中了白霜 - 快跑開",
	specWarnHoarfrostNear	= "你附近有人中了白霜 - 快跑開"
})

L:SetTimerLocalization{
	TimerCombatStart	= "戰鬥開始"
}

L:SetOptionLocalization({
	specWarnHoarfrost			= "當你中了$spell:69246時顯示特別警告",
	specWarnHoarfrostNear		= "你附近有人中了$spell:69246時顯示特別警告",
	TimerCombatStart			= "為戰鬥開始顯示計時器",
	SetIconOnHoarfrostTarget	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(69246)
})

L:SetMiscLocalization({
	CombatStart		= "終於，勇敢、勇敢的冒險者，你的干擾終到盡頭。你聽見了身後隧道中的金屬與骨頭敲擊聲嗎?這就是你即將面對的死亡之聲。", --Cannot promise just yet if this is right emote, it may be the second emote after this, will need to do more testing.
	HoarfrostTarget	= "冰霜巨龍霜牙凝視著(%S+)，準備發動寒冰攻擊!",
	YellCombatEnd	= "不可能…霜牙…警告……"
})

----------------------
--  Forge of Souls  --
----------------------
--  Bronjahm  --
----------------
L = DBM:GetModLocalization("Bronjahm")

L:SetGeneralLocalization({
	name = "布朗吉姆"
})

L:SetWarningLocalization({
	specwarnSoulstorm	= "靈魂風暴 - 快跑到王身邊"
})

L:SetOptionLocalization({
	specwarnSoulstorm	= "當$spell:68872施放時顯示特別警告 (靠近用)"
})

-------------------------
--  Devourer of Souls  --
-------------------------
L = DBM:GetModLocalization("DevourerofSouls")

L:SetGeneralLocalization({
	name = "眾魂吞噬者"
})

L:SetWarningLocalization({
	specwarnMirroredSoul	= "停止攻擊",
	specwarnWailingSouls	= "哀嚎之魂 - 快跑到王背後"
})

L:SetOptionLocalization({
	specwarnMirroredSoul	= "為$spell:69051需要停止攻擊時顯示特別警告",
	specwarnWailingSouls	= "當$spell:68899施放時顯示特別警告",
	SetIconOnMirroredTarget	= "為$spell:69051的目標設置標記"
})


---------------------------
--  Halls of Reflection  --
---------------------------
--  Wave Timers  --
-------------------
L = DBM:GetModLocalization("HoRWaveTimer")

L:SetGeneralLocalization({
	name = "波數計時"
})

L:SetWarningLocalization({
	WarnNewWaveSoon	= "新一波 即將到來",
	WarnNewWave		= "%s 到來"
})

L:SetTimerLocalization({
	TimerNextWave	= "下一波"
})

L:SetOptionLocalization({
	WarnNewWave			= "當首領到來時顯示警告",
	WarnNewWaveSoon		= "為新一波顯示預先警告 (擊敗首領後)",
	ShowAllWaveWarnings	= "為所有波數顯示警告",
	TimerNextWave		= "為下一波顯示計時器 (擊敗首領後)",
	ShowAllWaveTimers	= "為所有波數顯示計時器及預先警告 (不準確)"
})

L:SetMiscLocalization({
	Falric		= "法勒瑞克",
	WaveCheck	= "靈魂波數 = (%d+)/10"
})

--------------
--  Falric  --
--------------
L = DBM:GetModLocalization("Falric")

L:SetGeneralLocalization({
	name = "法勒瑞克"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

--------------
--  Marwyn  --
--------------
L = DBM:GetModLocalization("Marwyn")

L:SetGeneralLocalization({
	name = "麥爾溫"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})

L:SetMiscLocalization({
})

-----------------------
--  Lich King Event  --
-----------------------
L = DBM:GetModLocalization("LichKingEvent")

L:SetGeneralLocalization({
	name = "逃離巫妖王事件"
})

L:SetWarningLocalization({
	WarnWave1		= "狂怒食屍鬼(6)復活的巫醫(1) 即將到來",
	WarnWave2		= "狂怒食屍鬼(6)復活的巫醫(2)笨拙憎惡體(1) 即將到來",
	WarnWave3		= "狂怒食屍鬼(6)復活的巫醫(2)笨拙憎惡體(2) 即將到來",
	WarnWave4		= "狂怒食屍鬼(12)復活的巫醫(4)笨拙憎惡體(3) 即將到來"
})

L:SetTimerLocalization({
	achievementEscape	= "逃離計時"
})

L:SetOptionLocalization({
	ShowWaves		= "為下一波 即將到來顯示警告"
})

L:SetMiscLocalization({
	Ghoul			= "狂怒食屍鬼",
	Abom			= "笨拙憎惡體",
	WitchDoctor		= "復活的巫醫",
	ACombatStart	= "他太強大了!我們必須立刻離開這裡!我的魔法只能困住他一小段時間。快來吧，英雄們!",
	HCombatStart	= "他…太強大了。英雄們，快點…到我這裡來!我們要立刻離開這裡!我會盡可能地在我們逃走時把他困住。",
	Wave1			= "無處可逃!",
	Wave2			= "屈服於墓地的酷寒之下吧!",
	Wave3			= "又是死路一條!",
	Wave4			= "你還能支持多久?",
	YellCombatEnd	= "開火!開火!"
})