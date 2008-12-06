if GetLocale() ~= "zhTW" then return end

local L
--------------------------------
-- Ahnahet: The Old Kingdom --
--------------------------------
-- Prince Taldaram --
---------------------
L = DBM:GetModLocalization("Taldaram")

L:SetGeneralLocalization({
	name = "泰爾達朗王子"
})

L:SetWarningLocalization({
	WarningFlame		= "裂焰之球",
	WarningEmbrace		= "吸血鬼之擁: >%s<"
})

L:SetTimerLocalization({
	TimerEmbrace		= "吸血鬼之擁: %s"
})

L:SetOptionLocalization({
	WarningFlame		= "顯示裂焰之球警告",
	WarningEmbrace		= "顯示吸血鬼之擁警告",
	TimerEmbrace		= "顯示吸血鬼之擁期間計時"
})


-----------------
-- Elder Nadox --
-----------------
L = DBM:GetModLocalization("Nadox")

L:SetGeneralLocalization({
	name = "老那杜斯"
})

L:SetWarningLocalization({
	WarningPlague	= "孵育瘟疫: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPlague	= "顯示孵育瘟疫警告"
})


-------------------------
-- Jedoga Shadowseeker --
-------------------------
L = DBM:GetModLocalization("JedogaShadowseeker")

L:SetGeneralLocalization({
	name = "潔杜佳·尋影者"
})

L:SetWarningLocalization({
	WarningThundershock	= "雷霆震擊",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningThundershock	= "顯示雷霆震擊警告",
})


-------------------
-- Herald Volazj --
-------------------
L = DBM:GetModLocalization("Volazj")

L:SetGeneralLocalization({
	name = "信使沃菈齊"
})

L:SetWarningLocalization({
	WarningInsanity	= "瘋狂",
	WarningShiver	= "粉碎: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningInsanity	= "顯示瘋狂警告",
	WarningShiver	= "顯示粉碎警告"
})


--------------
-- Amanitar --
--------------
L = DBM:GetModLocalization("Amanitar")

L:SetGeneralLocalization({
	name = "毒蕈魔"
})

L:SetWarningLocalization({
	WarningMini	= "迷你化",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningMini	= "顯示迷你化警告",
})



-----------------
-- Azjol-Nerub --
-------------------------------
-- Krik'thir the Gatewatcher --
-------------------------------
L = DBM:GetModLocalization("Krikthir")

L:SetGeneralLocalization({
	name = "『守門者』齊力克西爾"
})

L:SetWarningLocalization({
	WarningCurse	= "疲倦詛咒: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCurse = "顯示疲倦詛咒警告"
})


--------------
-- Hadronox --
--------------
L = DBM:GetModLocalization("Hadronox")

L:SetGeneralLocalization({
	name = "哈卓諾克斯"
})

L:SetWarningLocalization({
	WarningLeech	= "吸血毒液",
	WarningCloud	= "酸性之雲"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningLeech	= "顯示吸血毒液警告",
	WarningCloud	= "顯示酸性之雲警告"
})


---------------
-- Anub'arak --
---------------
L = DBM:GetModLocalization("Anubarak")

L:SetGeneralLocalization({
	name = "阿努巴拉克"
})

L:SetWarningLocalization({
	WarningPound		= "猛擊",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPound		= "顯示猛擊警告",
})


--------------------------------------
-- Caverns of Time - Old Stratholme --
--------------------------------------
-- Meathook --
--------------
L = DBM:GetModLocalization("Meathook")

L:SetGeneralLocalization({
	name = "肉鉤"
})

L:SetWarningLocalization({
	WarningChains		= "壓迫之鍊: >%s<"
})

L:SetTimerLocalization({
	TimerChains		= "壓迫之鍊: %s"
})

L:SetOptionLocalization({
	WarningChains		= "顯示壓迫之鍊警告",
	TimerChains		= "顯示壓迫之鍊計時",
})


------------------------------
-- Salramm the Fleshcrafter --
------------------------------
L = DBM:GetModLocalization("SalrammTheFleshcrafter")

L:SetGeneralLocalization({
	name = "『血肉工匠』塞歐朗姆"
})

L:SetWarningLocalization({
	WarningCurse	= "扭曲血肉詛咒: >%s<",
	WarningSteal	= "竊取血肉: >%s<",
	WarningGhoul	= "召喚食屍鬼"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCurse	= "顯示扭曲血肉詛咒警告",
	WarningSteal	= "顯示竊取血肉警告",
	WarningGhoul	= "顯示召喚食屍鬼警告"
})


-----------------------
-- Chrono-Lord Epoch --
-----------------------
L = DBM:GetModLocalization("ChronoLordEpoch")

L:SetGeneralLocalization({
	name = "紀元時間領主"
})

L:SetWarningLocalization({
	WarningStrike	= "致傷打擊: >%s<",
	WarningTime	= "時間 >%s<",
	WarningCurse	= "費力詛咒: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningStrike	= "顯示致傷打擊警告",
	WarningTime	= "顯示時間 停止/扭曲警告",
	WarningCurse	= "顯示費力詛咒警告"
})


---------------
-- Mal'Ganis --
---------------
L = DBM:GetModLocalization("MalGanis")

L:SetGeneralLocalization({
	name = "瑪爾加尼斯"
})

L:SetWarningLocalization({
	WarningSleep		= "催眠術: >%s<"
})

L:SetTimerLocalization({
	TimerSleep		= "催眠術: %s"
})

L:SetOptionLocalization({
	WarningSleep		= "顯示催眠術警告",
	TimerSleep		= "顯示催眠術期間計時"
})


----------------------
-- Drak'Tharon Keep --
----------------------
-- Trollgore --
---------------
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


------------------------
-- Novos the Summoner --
------------------------
L = DBM:GetModLocalization("NovosTheSummoner")

L:SetGeneralLocalization({
	name = "『召喚者』諾沃司"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- King Dred --
---------------
L = DBM:GetModLocalization("KingDred")

L:SetGeneralLocalization({
	name = "崔德王"
})

L:SetWarningLocalization({
	WarningFear	= "恐懼",
	WarningBite	= "重創撕咬: >%s<",
	WarningSlash	= "%s 斬"
})

L:SetTimerLocalization({
	TimerFear	= "恐懼冷卻",
	TimerSlash	= "%s 斬: %s"
})

L:SetOptionLocalization({
	WarningSlash	= "顯示碎裂斬/穿甲斬警告",
	WarningFear	= "顯示恐懼警告",
	WarningBite	= "顯示重創撕咬警告",
	TimerFear	= "顯示恐懼冷卻計時",
	TimerSlash	= "顯示碎裂斬/穿甲斬持續計時"
})


---------------------------
-- The Prophet Tharon'ja --
---------------------------
L = DBM:GetModLocalization("ProphetTharonja")

L:SetGeneralLocalization({
	name = "預言者薩隆杰"
})

L:SetWarningLocalization({
	WarningCloud	= "毒雲"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCloud	= "顯示毒雲警告"
})


--------------
-- Gun'Drak --
--------------
-- Slad'ran --
--------------
L = DBM:GetModLocalization("Sladran")

L:SetGeneralLocalization({
	name = "史拉德銳"
})

L:SetWarningLocalization({
	WarningNova	= "劇毒新星",
	WarningBite	= "強力撕咬: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningNova	= "顯示劇毒新星警告",
	WarningBite	= "顯示強力撕咬警告"
})


-------------
-- Moorabi --
-------------
L = DBM:GetModLocalization("Moorabi")

L:SetGeneralLocalization({
	name = "慕拉比"
})

L:SetWarningLocalization({
	WarningMojo	= "魔精狂亂"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningMojo	= "顯示魔精狂亂警告"
})


-----------------------
-- Drakkari Colossus --
-----------------------
L = DBM:GetModLocalization("BloodstoneAnnihilator")

L:SetGeneralLocalization({
	name = "德拉克瑞巨像"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- Gal'darah --
---------------
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

-----------------------
-- Eck the Ferocious --
-----------------------
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


------------------------
-- Halls of Lightning --
------------------------
-- General Bjarngrim --
-----------------------
L = DBM:GetModLocalization("Gjarngrin")

L:SetGeneralLocalization({
	name = "畢亞格林將軍"
})

L:SetWarningLocalization({
	WarningWhirlwind	= "旋風斬"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningWhirlwind	= "顯示旋風斬警告"
})


-----------
-- Ionar --
-----------
L = DBM:GetModLocalization("Ionar")

L:SetGeneralLocalization({
	name = "埃歐納"
})

L:SetWarningLocalization({
	WarningOverload	= "靜電超載: >%s<",
	WarningSplit	= "散化/分裂"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningOverload = "顯示靜電超載警告",
	WarningSplit	= "顯示散化警告"
})


-------------
-- Volkhan --
-------------
L = DBM:GetModLocalization("Volkhan")


L:SetGeneralLocalization({
	name = "渥克瀚"
})

L:SetWarningLocalization({
	WarningStomp = "破碎踐踏"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningStomp = "顯示破碎踐踏警告"
})


------------
-- Kronus --
------------
L = DBM:GetModLocalization("Kronus")

L:SetGeneralLocalization({
	name = "洛肯"
})

L:SetWarningLocalization({
	WarningNova	= "閃電新星"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningNova	= "顯示閃電新星警告"
})


--------------------
-- Halls of Stone --
---------------------
-- Maiden of Grief --
---------------------
L = DBM:GetModLocalization("MaidenOfGrief")

L:SetGeneralLocalization({
	name = "悲噗少女"
})

L:SetWarningLocalization({
	WarningWoe	= "哀痛之柱: >%s<",
	WarningSorrow	= "哀傷震擊",
	WarningStorm	= "悲痛風暴",
})

L:SetTimerLocalization({
	TimerWoe	= "哀痛之柱: %s",
	TimerSorrow	= "哀傷震擊",
})

L:SetOptionLocalization({
	WarningWoe	= "顯示哀痛之柱警告",
	WarningSorrow	= "顯示哀傷震擊警告",
	WarningStorm	= "顯示悲痛風暴警告",
	TimerWoe	= "顯示哀痛之柱期間計時",
	TimerSorrow	= "顯示哀傷震擊期間計時",
})


----------------
-- Krystallus --
----------------
L = DBM:GetModLocalization("Krystallus")
L:SetGeneralLocalization({
	name = "克利斯托魯斯"
})

L:SetWarningLocalization({
	WarningShatter	= "即將粉碎!"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShatter	= "顯示粉碎預先警告"
})


----------------------------
-- Sjonnir the Ironshaper --
----------------------------
L = DBM:GetModLocalization("SjonnirTheIronshaper")

L:SetGeneralLocalization({
	name = "『塑鐵者』斯雍尼爾"
})

L:SetWarningLocalization({
	WarningCharge	= "靜電能量: >%s<",
	WarningRing	= "閃電環"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningCharge	= "顯示靜電能量警告",
	WarningRing	= "顯示閃電環警告"
})


------------------------------------
-- Brann Bronzebeard Escort Event --
------------------------------------
L = DBM:GetModLocalization("BrannBronzebeard")

L:SetGeneralLocalization({
	name = "護衛事件"
})

L:SetWarningLocalization({
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
})


---------------
-- The Nexus --
---------------
-- Anomalus --
--------------
L = DBM:GetModLocalization("Anomalus")

L:SetGeneralLocalization({
	name = "艾諾瑪路斯"
})

L:SetWarningLocalization({
	WarningRiftSoon	= "裂縫即將開啟",
	WarningRiftNow	= "裂縫開啟!",
})

L:SetOptionLocalization({
	WarningRiftSoon		= "顯示裂縫開啟預先警告",
	WarningRiftNow		= "顯示裂縫開啟警告"
})


-----------------------------
-- Ormorok the Tree-Shaper --
-----------------------------
L = DBM:GetModLocalization("OrmorokTheTreeShaper")

L:SetGeneralLocalization({
	name = "『樹木造形者』歐爾莫洛克"
})

L:SetWarningLocalization({
	WarningSpikes		= "水晶尖刺",
	WarningReflection	= "法術反射",
	WarningFrenzy		= "狂亂",
	WarningAdd		= "召喚結晶糾纏者"
})

L:SetTimerLocalization({
	TimerReflection		= "法術反射",
})

L:SetOptionLocalization({
	WarningSpikes		= "顯示水晶尖刺警告",
	WarningReflection	= "顯示法術反射警告",
	WarningFrenzy		= "顯示狂亂警告",
	WarningAdd			= "顯示召喚結晶糾纏者警告",
	TimerReflection		= "顯示法術反射期間計時",
})


--------------------------
-- Grand Magus Telestra --
--------------------------
L = DBM:GetModLocalization("GrandMagusTelestra")

L:SetGeneralLocalization({
	name = "大魔導師特雷斯翠"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "即將分裂",
	WarningSplitNow		= "分裂",
	WarningMerge		= "融合"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSplitSoon	= "顯示分裂預先警告",
	WarningSplitNow		= "顯示分裂警告",
	WarningMerge		= "顯示融合警告",
})

L:SetMiscLocalization({
	SplitTrigger1 = "There's plenty of me to go around.",
	SplitTrigger2 = "I'll give you more than you can handle.",
	MergeTrigger = "Now to finish the job!"
})


-----------------
-- Keristrasza --
-----------------
L = DBM:GetModLocalization("Keristrasza")

L:SetGeneralLocalization({
	name = "凱瑞史卓莎"
})

L:SetWarningLocalization({
	WarningChains 	= "水晶之鍊: >%s<",
	WarningEnrage	= "狂怒",
})

L:SetTimerLocalization({
	TimerChains	= "水晶之鍊: %s",
})

L:SetOptionLocalization({
	WarningChains	= "顯示水晶之鍊警告",
	WarningEnrage	= "顯示狂怒警告",
	TimerChains	= "顯示水晶之鍊期間計時",
})


---------------------------------
-- Commander Kolurg/Stoutbeard --
---------------------------------
L = DBM:GetModLocalization("Commander")

local faction = UnitFactionGroup("player")
local commander = "未知"
if faction == "Alliance" then
	commander = "指揮官寇勒格"
elseif faction == "Horde" then
	commander = "指揮官厚鬚"
end

L:SetGeneralLocalization({
	name = commander
})

L:SetWarningLocalization({
	WarningFear 		= "恐懼",
	WarningWhirlwind	= "旋風斬",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningFear		= "顯示恐懼警告",
	WarningWhirlwind	= "顯示旋風斬警告",
})


----------------
-- The Oculus --
-----------------------------
-- Drakos the Interrogator --
-----------------------------
L = DBM:GetModLocalization("DrakosTheInterrogator")

L:SetGeneralLocalization({
	name = "『審問者』德拉高斯"
})

L:SetWarningLocalization({
	WarningPull	= "魔法拖曳",
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningPull	= "顯示魔法拖曳警告",
})

--------------------
-- Mage-Lord Urom --
--------------------
L = DBM:GetModLocalization("MageLordUrom")

L:SetGeneralLocalization({
	name = "法師領主厄隆"
})

L:SetWarningLocalization({
	WarningTimeBomb = "時間爆彈",
	WarningExplosion = "魔爆術",
})

L:SetTimerLocalization({
	TimerTimeBomb = "時間爆彈: %s",
	TimerExplosion = "魔爆術",
})

L:SetOptionLocalization({
	WarningTimeBomb = "顯示時間爆彈警告",
	WarningExplosion = "顯示魔爆術警告",
	TimerTimeBomb = "顯示時間爆彈計時",
	TimerExplosion = "顯示魔爆術計時",
	SpecWarnBombYou = "顯示特別警告，如果您是炸彈",
})


------------------------
-- Varos Cloudstrider --
------------------------
L = DBM:GetModLocalization("VarosCloudstrider")

L:SetGeneralLocalization({
	name = "瓦羅斯·雲行者"
})

L:SetWarningLocalization({
	WarningAmplify	= "魔法增效: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningAmplify	= "顯示魔法增效警告"
})


-------------------------
-- Ley-Guardian Eregos --
-------------------------
L = DBM:GetModLocalization("LeyGuardianEregos")

L:SetGeneralLocalization({
	name = "地脈守護者伊瑞茍斯"
})

L:SetWarningLocalization({
	WarningShift	= "界域轉換",
	WarningShiftEnd	= "界域轉換結束",
	WarningEnraged	= "狂怒襲擊"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningShift	= "顯示界域轉換警告",
	WarningShiftEnd	= "顯示\"界域轉換結束\"警告",
	WarningEnraged	= "顯示狂怒襲擊警告"
})



------------------
-- Utgarde Keep --
---------------------
-- Prince Keleseth --
---------------------
L = DBM:GetModLocalization("Keleseth")

L:SetGeneralLocalization({
	name = "凱雷希斯王子"
})

L:SetWarningLocalization({
	WarningTomb	= "冰霜之墓: >%s<",
})

L:SetTimerLocalization({
	TimerTomb	= "冰霜之墓: %s",
})

L:SetOptionLocalization({
	WarningTomb	= "顯示冰霜之墓警告",
	TimerTomb	= "顯示冰霜之墓期間計時",
})


------------------------------
-- Skarvald the Constructor --
-- & Dalronn the Controller --
------------------------------
L = DBM:GetModLocalization("ConstructorAndController")

L:SetGeneralLocalization({
	name = "『控制者』達隆恩"
})

L:SetWarningLocalization({
	WarningEnfeeble		= "衰弱: >%s<",
	WarningSummon		= "召喚骷髏"
})

L:SetTimerLocalization({
	TimerEnfeeble		= "衰弱: %s",
})

L:SetOptionLocalization({
	WarningEnfeeble		= "顯示衰弱警告",
	WarningSummon		= "顯示召喚骷髏警告",
	TimerEnfeeble		= "顯示衰弱期間計時",
})


--------------------------
-- Ingvar the Plunderer --
--------------------------
L = DBM:GetModLocalization("IngvarThePlunderer")

L:SetGeneralLocalization({
	name = "『盜掠者』因格瓦"
})

L:SetWarningLocalization({
	WarningSmash			= "%s",
	WarningGrowl			= "%s",
	WarningWoeStrike		= "哀痛打擊: >%s<",
	SpecialWarningSpelllock = "法術封鎖 - 停止施法!"
})

L:SetTimerLocalization({
	TimerSmash	= "%s",
	TimerWoeStrike	= "哀痛打擊: %s"
})

L:SetOptionLocalization({
	WarningSmash			= "顯示黑暗破擊警告",
	WarningGrowl			= "顯示低吼警告",
	WarningWoeStrike		= "顯示哀痛打擊警告",
	TimerSmash				= "顯示黑暗破擊施法計時",
	TimerWoeStrike			= "顯示哀痛打擊計時",
	SpecialWarningSpelllock = "顯示法術封鎖",
})


----------------------
-- Utgarde Pinnacle --
------------------------
-- Skadi the Ruthless --
------------------------
L = DBM:GetModLocalization("SkadiTheRuthless")

L:SetGeneralLocalization({
	name = "無情的斯卡迪"
})

L:SetWarningLocalization({
	WarningWhirlwind	= "旋風斬",
	WarningPoison		= "毒矛: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningWhirlwind	= "顯示旋風斬警告",
	WarningPoison		= "顯示毒矛警告"
})

------------
-- Ymiron --
------------
L = DBM:GetModLocalization("Ymiron")

L:SetGeneralLocalization({
	name = "依米倫國王"
})

L:SetWarningLocalization({
	WarningBane	= "災禍"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningBane	= "顯示災禍警告"
})


-----------------------
-- Svala Sorrowgrave --
-----------------------
L = DBM:GetModLocalization("SvalaSorrowgrave")

L:SetGeneralLocalization({
	name = "絲瓦拉·悲傷亡墓"
})

L:SetWarningLocalization({
	WarningSword	= "劍之儀式: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningSword	= "顯示劍之儀式警告"
})


---------------------
-- Gortok Palehoof --
---------------------
L = DBM:GetModLocalization("GortokPalehoof")

L:SetGeneralLocalization({
	name = "戈托克·白蹄"
})

L:SetWarningLocalization({
	WarningImpale	= "刺穿: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningImpale	= "顯示刺穿警告"
})


---------------------
-- The Violet Hold --
---------------------
-- Cyanigosa --
---------------
L = DBM:GetModLocalization("Cyanigosa")

L:SetGeneralLocalization({
	name = "霞妮苟莎"
})

L:SetWarningLocalization({
	WarningVacuum	= "秘法真空",
	WarningBlizzard	= "暴風雪",
	WarningMana	= "法力浩劫: >%s<"
})

L:SetTimerLocalization({
	TimerVacuum	= "下次秘法真空"
})

L:SetOptionLocalization({
	WarningVacuum	= "顯示秘法真空警告",
	WarningBlizzard	= "顯示暴風雪警告",
	WarningMana	= "顯示法力浩劫警告",
	TimerVacuum	= "顯示秘法真空冷卻計時"
})


------------
-- Erekem --
------------
L = DBM:GetModLocalization("Erekem")

L:SetGeneralLocalization({
	name = "伊銳坎"
})

L:SetWarningLocalization({
	WarningES	= "大地之盾"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningES	= "顯示大地之盾警告"
})


-------------
-- Ichoron --
-------------
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


---------------
-- Lavanthor --
---------------
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


------------
-- Moragg --
------------
L = DBM:GetModLocalization("Moragg")

L:SetGeneralLocalization({
	name = "摩拉革"
})

L:SetWarningLocalization({
	WarningLink	= "光學連結: >%s<"
})

L:SetTimerLocalization({
})

L:SetOptionLocalization({
	WarningLink	= "顯示光學連結警告"
})


------------
-- Xevoss --
------------
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


-----------------------------
-- Zuramat the Obliterator --
-----------------------------
L = DBM:GetModLocalization("Zuramat")

L:SetGeneralLocalization({
	name = "『消滅者』舒拉邁特"
})

L:SetWarningLocalization({
	WarningVoidShift		= "虛空移形: >%s<",
	WarningVoidShifted		= "%s 與虛無哨兵戰鬥",
	WarningShroudOfDarkness		= "黑暗障蔽 - 停止 dps",
	SpecialWarningVoidShifted 	= "你被虛空移形!",
	SpecialShroudofDarkness 	= "黑暗 - 停止 DPS",
})

L:SetTimerLocalization({
	TimerVoidShift			= "虛空移形: %s",
	TimerVoidShifted		= "虛空移形: %s",
})

L:SetOptionLocalization({
	WarningVoidShift			= "提示虛空移形 dot",
	WarningVoidShifted			= "提示虛空移形玩家",
	WarningShroudOfDarkness		= "提示黑暗障蔽",
	SpecialWarningVoidShifted	= "特別警告當你虛空移形",
	SpecialShroudofDarkness		= "特別警告當黑暗障蔽",
	TimerVoidShift				= "顯示虛空移形 dot 計時",
	TimerVoidShifted			= "顯示虛空移形玩家計時",
})


-------------------
-- Portal Timers --
-------------------
L = DBM:GetModLocalization("PortalTimers")

L:SetGeneralLocalization({
	name = "傳送門計時"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "新傳送門即將開啟",
	WarningPortalNow	= "傳送門 #%d",
	WarningBossNow		= "首領即將到來"
	WavePortal		= "傳送門開啟: (%d+)/18"
})

L:SetTimerLocalization({
	TimerPortalIn	= "傳送門 #%d" , 
})

L:SetOptionLocalization({
	WarningPortalNow		= "顯示新傳送門警告",
	WarningPortalSoon		= "顯示新傳送門預先警告",
	WarningBossNow			= "顯示首領警告",
	TimerPortalIn			= "顯示 \"傳送門: #\" 計時",
	ShowAllPortalWarnings	= "顯示所有波警告"
})


L:SetMiscLocalization({
	yell1 = "監獄守衛，我們要離開了!這些冒險者會接手!動作快!",
})
